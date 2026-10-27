# Sale: client-side behaviour of Cin7 Core (from the shipped page scripts)

Source: static reading of the public, cached ExtJS bundles. Nothing was executed, nothing was called.

| Short name | Bundle (cached) | What it is |
|---|---|---|
| **SM** | `SaleMultiple2019.js` | The "Sale" form (`/SaleMultiple#<TaskID>`): header, Quote, Order, Pick, Pack, Ship, Invoice, Credit note, Restock, Payments tabs |
| **Main** | `Main2019.js` | Shared helpers: rounding, line math, money format, field validation, decimals |
| **SL** | `SalesList2019.js` | Sales list (General / Accounting / Fulfilment views, bulk actions, status rendering) |
| **CN** | `CreditNote2019.js` | Stand-alone customer credit note page (service-only "sale" with only credit-note lines) |
| **TPT** | `TenantPaymentTerm2019.js` | Payment term definitions (used for due-date maths) |

References are written `File › function`. The analysis used beautified copies (`js-beautify`); line numbers are deliberately left out because they only exist in those copies.

Not read in depth: `SimpleSale2019.js`, `ServiceSale2019.js`, `AwaitingSale2019.js`, `FulfilmentOrder2019.js`, `CustomerPayment2019.js`, `RMA*.js`. They share the same helper functions (Main) and the same `DRAFT / AUTHORISED` status vocabulary but are different pages.

## ⚠️ Gotchas: the sneaky stuff

> [!CAUTION]
> **Blank rows are silently deleted on save, and the Quote tab deletes more**
>
> Order and quote lines with no product, price, quantity, tax or total are stripped on save (client script). Saving while on the Quote tab also removes order lines or charges that lack a product or description, have quantity 0, or have no tax rule. [details](#41-line-level)

> [!CAUTION]
> **Voiding a sale with a payment deletes the transactions without refunding**
>
> The void confirm itself states that voiding a sale with an existing payment deletes the financial transactions and does not refund the payment. [details](#25-separate-non-save-calls)

> [!CAUTION]
> **Skip quote deletes quote content**
>
> Setting Skip quote removes all quote lines and charges and hides the tab, and authorising an order with SkipQuote removes the quote lines too. It locks once the quote or order is authorised. [details](#32-other-header-dependencies)

> [!CAUTION]
> **Cell arithmetic is evaluated and bad input becomes 0**
>
> Quantity, Price, Total, Amount and size cells run the typed text through eval (so 12*3 works); NaN or Infinity becomes 0, while an exception keeps the old value. [details](#13-cell-input)

> [!CAUTION]
> **The credit check fails open**
>
> The credit-limit and hold check is advisory, and if the CurrentCredit call fails the authorise simply proceeds. Answering No reverts the status to DRAFT. [details](#43-credit-limit--hold-tenant-creditlimit-per-customer-get-apisalemult_index_currentcredit)

> [!WARNING]
> **Rounding must be half away from zero, with a toFixed(6) pre-step**
>
> DEARRound rounds half away from zero after cleaning binary noise (1.005 becomes 1.01); Math.round(x*100)/100 or banker's rounding will give different cents. [details](#11-rounding-primitive)

> [!WARNING]
> **TaxCalculationMethod changes the totals**
>
> Row Total rounds tax per line to 2 dp, while Total keeps 4 dp per line and rounds only the section sum; ten lines of 0.10 at 8.25% give a footer of 0.10 versus 0.08. [details](#110-worked-example-made-up-numbers)

> [!WARNING]
> **Changing the customer overwrites many header fields**
>
> Selecting a new customer resets currency and rate, carrier, credit limit, terms, tax rule, price tier, location, revenue account, sales rep, internal memo and header discount, and clears contact and address lines. Reselecting the original customer restores the saved values instead. [details](#31-choosing-a-customer-sale_customer_selectevent-and-sale_customer_changeevent-sm)

> [!WARNING]
> **Editing an order field sends an uncompleted order back to DRAFT**
>
> Editing any non-tax-rule order field while the order is not completed forces its status back to DRAFT, and status is recomputed from the presence of lines on every save. [details](#22-document-lifecycle-what-the-client-enforces)

> [!WARNING]
> **The discount engine splits lines and recreates charge lines on every run**
>
> Each run removes and recreates the Order total discount, Buy collection discount and free-shipping charge lines, and splits a line in two when a discount covers only part of its quantity. It also reruns on any exchange-rate change. [details](#34-pricediscount-engine)

> [!WARNING]
> **Quote approval stops the automatic quote-to-order copy**
>
> With approval enabled, authorising the quote no longer copies it to the order; Copy from quote becomes a manual step. [details](#26-quote-approval-and-archive-tenant-settings-isquoteapproveenabled-isarchiveenabled)

> [!NOTE]
> **Some status constants are referenced but never defined**
>
> splitOrder, partialPaid and pconfirmauthorisation evaluate to undefined, so those branches are dead and their intended strings are unknown; BACKORDER, SHORT STOCK and NO STOCK are set only by the server. [details](#21-status-vocabulary-sm--salemult_index_initializestatustracker)

---

## 0. The shape of the whole thing (read this first)

* A sale is **one tree** loaded from `GET /api/SaleMult_Index_vSaleTask?id=<TaskID>&lang=..&CountrySpecificKey=..` and saved whole with `POST /api/SaleMult_Index_vSaleTask` (new) or `PUT /api/SaleMult_Index_vSaleTask/<TaskID>` (existing). Body: `{ID, AvalaraTaxExemptionCode, HasErrors:false, SuppressTransactions, DiscountsDescription, Original:[task...], Updated:[task...]}`. The response wraps `{HasErrors, Warnings, PickRecommendationWarning, Original|Updated, ReferenceData...}`. (SM › `SaleMult_Index_Submit_Internal`, `SaleTaskWrapperStore`)
* `SuppressTransactions` is `true` when the save is only a prelude to Print or Email.
* The first record of `Updated` is the **master task** (`TaskTypeSign = 1`, index 0). Children follow: `TaskTypeSign` **2 = fulfilment (pick/pack/ship)**, **3 = invoice**, **4 = credit note (and restock)**. `0` is legacy and treated like 1 in loops. (SM › `StatusTracker.*` loops, `SaleMult_Index_New`)
* **The client never sends "authorise" as a command.** It sets a status string on the task (`QuoteStatus`, `SaleOrderStatus`, `PickStatus`, `PackStatus`, `ShipmentStatus`, `InvoiceStatus`, `CreditNoteStatus`, `RestockStatus`, `AdditionalCOGSStatus`) to `AUTHORISED` (or `DRAFT`, `FULFILLED`, `CLOSED`) and saves the whole tree. The server validates and does the stock/ledger work. So a clone's save endpoint is one "diff and transition" endpoint, not one endpoint per button.
* Only these actions are separate HTTP calls: Undo, Void, Undo/Void child, Clone, Print, Email, CurrentCredit, price/discount request, exchange rate, approve/reject, archive. They are listed in section 2.5.
* Line `Total`/`Tax` are **computed on the client** and sent to the server (server almost certainly recomputes; see "Not determinable").
* Page boot: the first sale GET response also carries `ReferenceData` (tenant settings + all lookup lists: locations, tax rules, terms, price tiers, carriers, accounts, units, shipping providers); `SaleReferenceDataStore` is loaded from it once (`FirstLoad`).

---

## 1. Calculations

### 1.1 Rounding primitive

`Main › DEARRound(value, places)`

```
k = 10^places
DEARRound = sign(value) * Math.round( (abs(value) * k).toFixed(6) ) / k      // sign(0) = +1
```

Rounds half **away from zero**, and the `.toFixed(6)` pre-step cleans binary noise (so 1.005 -> 1.01, 2.675 -> 2.68, -1.005 -> -1.01). Anything computed in the clone must use this, not `Math.round(x*100)/100` or banker's rounding.

Money display: `Main › DEARMoneyFormat(v)` = `DEARRound(v,2)` then `toMoney(2)`: `,` thousands, `.` decimal, leading `-` for negatives, `''` for null. `DEARPriceFormat` uses `PriceDecimals`; `DEARCostFormat` uses 4. Quantities in footers are shown as `DEARRound(sum, 4)`.

### 1.2 Decimal precision (window globals set at boot / from tenant settings)

| Global | Value | Source |
|---|---|---|
| `PriceDecimals` | **4** (always) | Main › account-info load |
| `PurchasePriceDecimals` | 4 if `Xero`, else 7 | same |
| `TaxPrecision` | **2 if `TaxCalculationMethod == 'Row Total'`, else 4** | SM › `SaleReferenceDataStore.load` (field `TaxCalculationMethod`; other value is `'Total'`) |
| Quantity | 4 | `SaleEditCalculator` |
| Line total, tax shown, footer totals | 2 | everywhere |
| Currency conversion rate | 5 decimals, min 0.00001 | SM › `txtSaleMult_Index_OrderCurrencyConversionRate` |

### 1.3 Cell input

`Main › SaleEditCalculator` runs on `validateedit` of every sale grid. For the fields `Quantity, Price, Total, Amount, Weight, Width, Height, Length`:

* the typed text is **`eval`ed as an arithmetic expression** (so `12*3` or `100/4` works). Empty/undefined/null -> `'0'`;
* `numCalc = DEARRound(Number(eval(str)), precision)` where precision = `PriceDecimals` (4) for `Price`, **4 for `Quantity`**, **6 for anything else**;
* if eval throws, the old value is kept; if `NaN` or `Infinity` the value becomes `0`.

### 1.4 Line total and line tax (Quote, Order, Invoice, Credit note lines all use this)

`Main › UpdateTaxAndTotal(record)`:

```
unit    = DEARRound( Price * (100 - Discount) / 100 , 4 )          // DEARRoundPrice
Total   = DEARRound( Quantity * unit , 2 )
Tax     = (TaxPercent > 0) ? Total * TaxPercent / 100 : 0
Tax     = DEARRound( Tax , TaxPrecision )                          // 2 or 4, see 1.2
```

Order of operations that matters: discount is applied to the **unit price first and that is rounded to 4 dp**, then multiplied by quantity, then rounded to 2 dp. Tax is calculated **from the rounded Total**, never from the unrounded one.

`TaxPercent` on the line is **not the rule's headline rate**; it is a field of the tax rule chosen by the sale's inclusive flag:

```
TaxPercent = TaxInclusive ? rule.EffectivePercentInclusive : rule.EffectivePercentExclusive
```

(both are returned by the server on each tax rule: `vTenantTaxationRule {RuleID, Description, EffectivePercent, EffectivePercentExclusive, EffectivePercentInclusive, Inclusive, Tax1, IsForSale, IsActive}`). For a single 8.25% rule the server evidently supplies Exclusive = 8.25 and Inclusive = 8.25 / 108.25 * 100 = 7.6212...; the client never derives one from the other. A clone must store both columns.

Additional-charge lines (shipping etc.): `Main › UpdateAdditionalTaxAndTotal`: same, but the unit is the `Amount` field and the price rounding is `DEARRoundPriceForPurchase` = 4 dp if Xero else **7 dp**; `Quantity` defaults to 1.

`Main › UpdateTax(record)`: `Tax = DEARRound(Total*TaxPercent/100, TaxPrecision)` for when `Total` is edited directly.

When any of `Price, Quantity, Discount, TaxRule` is edited and changed, the grid calls `UpdateTaxAndTotal` then recomputes the footer. (SM › `vSaleOrderLinesEditing.edit`, same pattern in quote/invoice/credit-note editors.) Editing `Total` directly writes the number but does not recompute `Tax` in the order editor.

### 1.5 Totals box (identical shape for Quote, Order, Invoice, Credit note)

Functions: SM › `SaleMult_Quote_UpdateTotals`, `SaleMult_Order_UpdateTotals`, `SaleMult_Invoice_UpdateTotals`, `SaleMult_CreditNote_UpdateTotals` (CN › `CreditNote_CreditNote_UpdateTotals` has only the lines block).

Lines block:

```
A_lines  = Σ line.Total                       (shown un-subtracted as the grid footer "Total": DEARRound(A_lines,2))
T_lines  = DEARRound( Σ line.Tax , 2 )
if TaxInclusive:  A_lines = A_lines - T_lines            // line Totals already contain tax
LinesGoods = A_lines
LinesTax   = T_lines
LinesTotal = A_lines + T_lines
```

Additional charges block:

```
A_ch = Σ ch.Total ;  T_ch = DEARRound( Σ ch.Tax , 2 )
if TaxInclusive:  A_ch = A_ch - T_ch
A_ch = DEARRound(A_ch, 2)                     // note: lines block does NOT re-round Amount; Quote/Order/Invoice lines block skip it, credit-note lines block does it
ChGoods = A_ch ;  ChTax = T_ch ;  ChTotal = A_ch + T_ch
```

Grand block:

```
GrandGoods = LinesGoods + ChGoods
GrandTax   = LinesTax   + ChTax
GrandTotal = LinesTotal + ChTotal             // in CUSTOMER currency
```

So: **tax-exclusive**: GrandTotal = ΣTotal + round2(ΣTax) (lines) + same for charges. **Tax-inclusive**: GrandTotal = ΣTotal (tax is carved out of it, `Goods = ΣTotal - round2(ΣTax)`).

Tax is summed **per section** (lines, charges) and rounded **per section**, not per document and not per line (per-line rounding happens in 1.4 via `TaxPrecision`).

Plain-total helpers used for credit checks and balances: `SaleMult_Order_GetTotal` / `SaleMult_Invoice_GetTotal`:
`Σ Total (+ round2(ΣTax) if not inclusive)` for lines, plus same for charges.

Permission masking: if `HasPriceInfoAccess` is false the Order/Quote totals and grid prices render the literal text `No access`. Margin column hidden/`No access` when `MarginPermission == 'None'`.

### 1.6 Currency

Fields: `Currency` (tenant base, upper-cased), `CustomerCurrency` (from customer), `CurrencyConversionRate` (Quote/Order/Invoice share this on the master task), `CreditNoteConversionRate` (credit notes).

* Rate semantics are **tenant units per 1 customer-currency unit**; label text is `'{TenantCurrency} units per {CustomerCurrency}'` (SM › `SaleMult_Index_UpdateRateConversionLabel`). When customer currency equals tenant currency the label is `Conversion rate`, rate = 1 and the rate block is hidden.
* `TotalTenantCurrency = DEARRound( GrandTotal * rate , 2 )` and is shown (with caption `(<TENANT>)`) only when the two currencies differ and are both non-empty. Lines themselves are never converted; they stay in customer currency.
* Rate lookup: `GET /api/GetRate?From=<customerCcy>&To=<tenantCcy>&Date=<yyyy-mm-dd>` -> plain-text float. On failure: warning `Failed to acquire currency exchange rate. Please provide the rate manually.` plus the error text. (SM › `SaleMult_Index_GetConversionRate`)
* The rate is re-fetched when: the customer is changed to one with a different currency; the order **date** changes (only if the customer is assigned, the field is valid and quote/order are not authorised, and not on first load, and only if the rate actually changed); the "Get rate" button is pressed (`SaleMult_Quote_GetRate` / `SaleMult_Order_GetRate`: no-op once authorised/fulfilled/closed, no-op if currencies equal).
* Changing the rate (or receiving a different one) triggers `SaleMult_*_ApplyDiscounts(null,null,true)`, i.e. the discount engine re-runs with `OnlyDiscountedProducts=true` (section 3.4).
* Payment lines carry their own `CurrencyConversionRate`; tenant amount of a payment = `DEARRound(Amount * CurrencyConversionRate, 2)`. When a bank account's currency equals the document currency the per-payment rate is not editable (`...IsPaymentLinesFieldEditable('Conversion rate')`), and when customer = tenant currency payments on tenant-currency accounts are forced to rate 1.
* New-payment dialog shows "Amount in {Currency} will be: {Amount * ConversionRate}" (SM › `SaleMult_NewPayment_UpdateBaseAmount`).

### 1.7 Paid / Due (invoice)

SM › `SaleMult_Invoice_UpdateTotals` (bottom), `SaleMult_NewPayment_GetInvoiceDue`, `SaleMult_Invoice_CheckForDeposits`:

```
Paid  = Σ payment.Amount   for payment lines with  Type == 'ACCREC'  and  PaymentType in {'R' (received), 'A' (allocation)}
Balance = DEARRound( -InvoiceGrandTotal + Paid , 2 )        // negative = still owed
Balance < 0  -> header text "Balance due ({custCcy})",  amount shown = -Balance, payment buttons ENABLED
Balance >= 0 -> payment buttons DISABLED;  header text "Balance credited ({custCcy})" if Balance > 0, else "Balance due"
```

Tenant-currency balance: `BalanceTenant = DEARRound( -TotalTenantCurrency + Σ DEARRound(Amount*Rate,2) , 2 )`; header `Realized ({tenantCcy})` when `Balance == 0` and currencies differ, otherwise `Balance credited/due ({tenantCcy})`.

New-payment dialog default amount (`SaleMult_NewPayment_GetInvoiceDue`): `DEARRound( (ΣTotal(+round2 ΣTax if exclusive) lines + same for charges) - Σ Amount of 'R'/ACCREC payments , 2 )`. Only `PaymentType 'R'` counts here (allocations excluded). For a credit note the dialog is titled `Add a new refund` (invoice: `Add a new payment`) and uses `ACCRECCREDIT` rows.

Credit-note refund balance: same shape with `Type == 'ACCRECCREDIT'`.

### 1.8 Invoice due date

SM › `SaleMult_Invoice_UpdateDueDate` (re-run when the invoice date changes, when terms are chosen, on invoice open when no due date and fill-date mode is order/shipment):

`TermMethod` ids (TPT › `MethodStore`): **1 Number of days, 2 Day of next month, 3 Last day of next month, 5 Days since the end of the month** (4 appears in the code as a legacy branch).

```
1 / default : due = InvoiceDate + TermDays days
2           : due = (first day of the month after InvoiceDate) + (TermDays - 1) days        // TermDays capped 0..31 in the term editor
3           : due = last day of the month after InvoiceDate                                  // Days field disabled / not applicable
5           : due = (first day of the month after InvoiceDate) + (TermDays - 1) days        // same arithmetic as 2, max 999
4 (legacy)  : if TermDueNextMonth == -1: same as 2 ; else t = InvoiceDate + TermDueNextMonth days;
              d = first of t's month + (TermDays - 1); if t.day >= TermDays: d = d moved to next month, same day number
```

Term editor limits (TPT): Method required (`Method cannot be empty.`), Days required unless method 3 (`Days cannot be empty.`), Days clamped to `0..999` (`0..31` for method 2); blank or `-` becomes 0.
Authorising an invoice with no due date: error `Please enter due date.`

### 1.9 Margin column (display only)

SM › Order/Quote/Invoice `colMargin_*` renderer + `Sale_Margin_GetLineUnitCostInBase`:

```
Amount    = Price - Price*Discount/100                       (only if Discount > 0)
if TaxInclusive and TaxPercent > 0:  Amount -= Amount * TaxPercent/100     // BaseAmount * TaxPercent/100
SalePrice = Amount * master.CurrencyConversionRate ;  if SalePrice < 0.000045 then 0
Cost      = AverageCost                                         // normal stock line
          = supplierRaw * ratio  when drop-ship / non-inventory (see below)
Margin%   = SalePrice == 0 ? 0 : DEARRound( (SalePrice - Cost) * 100 / SalePrice , 2 )
```
Supplier cost for drop-ship or non-inventory lines: `raw = SupplierLatestPurchasePrice` if non-zero else `SupplierFixedCost`; converted to tenant currency with the exchange-rate list from `GET /api/Sale_Index_MarginExchangeRates` (direct ratio, else 1/inverse, else 1). Supplier cost is used when: line `DropShip` true and (NonInventory or mode `A` or mode `O`); or `DropShip` undefined and (NonInventory or mode `A`). Mode `O` + NonInventory is treated as `A`. Colour: >0 green, <0 red.

### 1.10 Worked example (made-up numbers)

Setup: tenant ccy USD, customer ccy USD (rate 1). Tax rule "Sales 8.25%": `EffectivePercentExclusive = 8.25`, `EffectivePercentInclusive = 7.6212471...`. `TaxCalculationMethod = 'Row Total'` (TaxPrecision 2). Sale is **tax exclusive**.

| # | Qty | Price | Disc % | unit = round4(P*(100-D)/100) | Total = round2(Q*unit) | Tax% | Tax = round2(Total*Tax%/100) |
|---|---|---|---|---|---|---|---|
| 1 | 3 | 19.99 | 10 | 17.991 | 53.97 (53.973) | 8.25 | 4.45 (4.452525) |
| 2 | 2.5 | 4.3333 | 0 | 4.3333 | 10.83 (10.83325) | 8.25 | 0.89 (0.893) |
| 3 | 1 | 100.00 | 15.5 | 84.5 | 84.50 | 0 | 0.00 |
| 4 | 7 | 0.10 | 33.333 | 0.0667 | 0.47 (0.4669) | 8.25 | 0.04 |

Additional charge "Shipping": qty 1, Amount 12.50, disc 0, tax 8.25% -> Total 12.50, Tax 1.03.

```
Lines:   A = 53.97+10.83+84.50+0.47 = 149.77      T = round2(4.45+0.89+0+0.04) = 5.38
         LinesGoods 149.77  LinesTax 5.38  LinesTotal 155.15
Charges: A = 12.50   T = round2(1.03) = 1.03        ChTotal 13.53
Grand:   Goods 162.27   Tax 6.41   GrandTotal 168.68
```

Same sale **tax inclusive** (lines 1-3 only, `TaxPercent = 7.6212...`; 1: Tax 4.11, 2: Tax 0.83, 3: 0):
`A = 53.97+10.83+84.50 = 149.30`, `T = round2(4.11+0.83) = 4.94`, `Goods = 149.30 - 4.94 = 144.36`, `LinesTotal = 144.36 + 4.94 = 149.30`. The grid footer "Total" shows 149.30 either way.

Where `TaxCalculationMethod` ('Row Total' vs 'Total') matters: ten lines of Total 0.10 at 8.25%: Row Total -> each tax round2(0.00825)=0.01, sum 0.10, footer 0.10. 'Total' -> each 0.0083 (4 dp), sum 0.083, footer round2 = **0.08**.

Foreign currency: customer EUR, rate 1.0850 (USD per EUR). GrandTotal EUR 168.68 -> `GrandTotal (USD) = round2(168.68 * 1.085) = 183.02`. Payments: received EUR 100 at 1.09 -> USD 109.00; allocation EUR 20 at 1.085 -> USD 21.70. `Paid = 120`, `Balance = round2(-168.68 + 120) = -48.68` -> "Balance due (EUR) 48.68", payment buttons on. `BalanceTenant = round2(-183.02 + 109.00 + 21.70) = -52.32` -> shown as 52.32.

Margin: line 1, AverageCost 12.00: Amount = 19.99 - 19.99*10/100 = 17.991; margin = round2((17.991 - 12) * 100 / 17.991) = **33.30%**.

Due date: invoice date 2026-10-27. Method 1/30 days -> 2026-11-26. Method 2/15 -> 2026-11-15. Method 3 -> 2026-11-30. Method 5/10 -> 2026-11-10.

Credit warning: customer CurrentCredit 9,000.00 + this order 1,200.00 = 10,200.00 vs limit 10,000.00 -> dialog (section 4.3).

---

## 2. Status model

### 2.1 Status vocabulary (SM › `SaleMult_Index_InitializeStatusTracker`)

| Constant | String sent/received |
|---|---|
| draft | `DRAFT` |
| notAvailable | `NOT AVAILABLE` |
| authorized | `AUTHORISED` (British spelling on the wire, "Authorized" in the UI) |
| authNoAllocation | `AUTH_NO_ALLOC` |
| fulfilled | `FULFILLED` |
| closed | `CLOSED` |
| voided | `VOIDED` |
| paid | `PAID` |
| backorder | `BACKORDER` |
| shortstock | `SHORT STOCK` |
| nostock | `NO STOCK` |
| invalidaddress / pinvalidaddress | `INVALID ADDRESS` / `PINVALID ADDRESS` |
| confirmauthorisation | `CONFIRM` |

`StatusTracker.statuses.splitOrder`, `.partialPaid`, `.pconfirmauthorisation` are referenced but **never defined** (they evaluate to `undefined`, so those branches are dead). `BACKORDER`, `SHORT STOCK`, `NO STOCK` are only ever *set by the server*; the client reads them.

Per-document status fields on the task: `QuoteStatus`, `SaleOrderStatus`, `PickStatus`, `PackStatus`, `ShipmentStatus`, `InvoiceStatus`, `CreditNoteStatus`, `RestockStatus`, `AdditionalCOGSStatus`; overall `Status`. New sale defaults (SM › `SaleMult_Index_New`): every document status `NOT AVAILABLE`, overall `Status = 'DRAFT'`, `TaskTypeSign = 1`, `FulfillmentNumber = 1`, `PriceTier = 1`, rates 1, `TaxPercent 0`, `SaleOrderNumber = 'Not assigned'`, `InvoiceNumber = 'Not assigned'`, `SaleOrderDate = today`, `SkipQuote = (no JobID) && tenant DefaultSkipQuote`, `SalesRepresentative = default rep` (section 3.2), `IsServiceOnly=false`.

Overall `Status` display (SM › `SaleMult_Index_AdjustStatus`; SL › `SaleStatuses`): `CLOSED Closed`, `COMPLETED Completed`, `PARTIALLY INVOICED / CREDITED`, `PARTIALLY INVOICED`, `INVOICED / CREDITED`, `INVOICED`, `ORDERED`, `BACKORDERED`, `ORDERING`, `ESTIMATED`, `ESTIMATING`, `DRAFT`, `VOIDED`, `COMPLETED / CREDIT NOTE` -> "Credited", `INVOICE COMPLETED` -> "Invoiced", `INVOICE IN PROGRESS` -> "Invoicing", `SHIPMENT IN PROGRESS` -> "Shipping", `PACK COMPLETED` -> "Packed", `PACK IN PROGRESS` -> "Packing", `PICK COMPLETED` -> "Picked", `PICK IN PROGRESS` -> "Picking", `SO COMPLETED` -> "Ordered", `SO IN PROGRESS` -> "Ordering", `QUOTE COMPLETED` -> "Estimated", `QUOTE IN PROGRESS` -> "Estimating"; list adds `AWAITING APPROVAL`, `IN PROGRESS`, `CREDITED`, `PAID`, `AUTHORISED`. Unknown strings display as-is. The server computes this string; the client only maps it. CSS class: `VOIDED` -> voided, `DRAFT` -> draft, `CLOSED/COMPLETED/RECEIVED` -> completed, else default.

Tab status chip text (per document): `New` (default look), `Draft`, `Authorized`, plus order `Not created` for `NOT AVAILABLE` once a number exists, invoice `Paid` for `PAID`. A new unsaved order (`SaleOrderNumber` still `Not assigned`) shows `New`.

Form title: unsaved -> `New sale`; saved -> `Sale #<SaleOrderNumber> for <CustomerName>` (name truncated to 60 chars + `...` when longer than 70). (SM › `SaleMult_Index_ProcessLoad`, `cmbCustomer.blur`). Per project convention the displayed identifier in the clone should lead with `CustomerReference` (see repo rules) with `SaleOrderNumber` as the fallback; the original title uses the SO number.

### 2.2 Document lifecycle (what the client enforces)

```
Quote:   NOT AVAILABLE --(any line/charge present, on save)--> DRAFT --(Authorise)--> AUTHORISED
Order:   NOT AVAILABLE --(any line/charge present, on save)--> DRAFT --(Authorise)--> AUTHORISED | AUTH_NO_ALLOC
                          server may set BACKORDER / SHORT STOCK / NO STOCK     AUTHORISED --Mark as fulfilled--> FULFILLED --> CLOSED (Mark as closed)
Pick:    NOT AVAILABLE -> DRAFT -> AUTHORISED          Authorise Pick sets Pack to DRAFT if pack lines exist
Pack:    NOT AVAILABLE -> DRAFT -> AUTHORISED          Authorise Pack sets Ship to DRAFT if shipment lines exist
Ship:    NOT AVAILABLE -> DRAFT -> AUTHORISED
Invoice: NOT AVAILABLE -> DRAFT -> AUTHORISED -> PAID (server)       VOIDED via Void
CreditNote / Restock: NOT AVAILABLE -> DRAFT -> AUTHORISED           VOIDED via Void
```

`StatusTracker.quote.updateStatus` / `order.updateStatus` run on every save (`StatusTracker.updateStatuses`): if not read-only, not cancelled, permission `Full`, not already completed (and for the order not manually set) then status = `DRAFT` when the lines store or charges store has >0 rows else `NOT AVAILABLE`. "Completed" for the quote = `AUTHORISED` or `SkipQuote`; for the order = `AUTHORISED | AUTH_NO_ALLOC | FULFILLED | CLOSED`. Editing any non-tax-rule order field while the order is not completed forces it back to `DRAFT`.

Loading maps `BACKORDER` order status to `DRAFT` for display (`StatusTracker.ProcessLoad`).

`mainFulfillment`: fulfilments are only creatable when the order status is `AUTH_NO_ALLOC | AUTHORISED | BACKORDER | FULFILLED | CLOSED` **and** `Σ order qty (excluding drop-ship lines) - Σ picked qty in authorised pick/pack/ship fulfilments > 0` **and** `PickViewPermission == 'Full'` (`possibleToCreate`). Master `FulfillmentNumber` is set to 1 unless a non-voided fulfilment child (`TaskTypeSign 2`) exists, then 0, flipped back to 1 if the master task itself has pick lines or a non-void/non-NA pick status (`updateMasterTaskFulfillmentNumber`).

Invoice creatable (`StatusTracker.invoice.possibleToCreate`): `Σ order qty > Σ qty on AUTHORISED/PAID invoices` or same test on charge quantities, and `InvoiceCreditNoteViewPermission == 'Full'`. The Invoice tab is only enabled (`invoice.isDisabled()` false) when order status is `AUTHORISED` or `AUTH_NO_ALLOC`. If tenant setting `ShowInvoiceBeforeFulfillment` the Invoices+Payments blocks are moved above the fulfilment block.

### 2.3 Enable / disable / hide conditions

Global flags: `IsReadOnly` (access level read-only, tenant subscription `On Hold`, voided sale), `StatusTracker.isCancelled` (master `Status == 'VOIDED'`), `isRejected()` (quote approval enabled and `SkipQuote !== true` and `QuoteApprove == 1`). Permissions come from `SaleReferenceData` (`Full | ReadOnly | None`): `Quote/Order/Pick/Pack/Ship ViewPermission`, `...AuthorisationPermission`, `InvoiceCreditNoteViewPermission`, `InvoiceCreditNoteAuthorisationPermission`, `MarginPermission`, `PricesDiscountsPermission`, `VoidPermission`, `UndoPermission`, `EditAuthorizedDocumentsPermission`, `QuoteApproveRejectReviewPermission`, `PurchasePermission`, `FinancialDataPermission`.
`ViewPermission == 'None'` disables the corresponding tab (`StatusTracker.<doc>.disabled = true`; Invoice `None` disables Invoice, Credit note and Restock together).

**Header** (`StatusTracker.header.applyState`, SM):

| Control | Disabled when |
|---|---|
| Customer | `header.disabled()` OR customer already has credit/allocations on the sale OR any active child exists (`hasActiveChild`) |
| `header.disabled()` | cancelled OR order completed (`AUTHORISED/AUTH_NO_ALLOC/FULFILLED/CLOSED`) OR read-only OR rejected |
| Price tier | `header.disabled()` |
| Terms | cancelled OR read-only (still editable after authorisation) |
| Customer reference | cancelled OR read-only |
| Purchase order reference | cancelled OR read-only OR an authorised/paid invoice exists |
| Sales representative | read-only OR NOT(OrderView Full OR QuoteView Full); also unchanged-by-customer when `UseCurrentUserAsSaleRep` pinned the rep |
| Location | `header.disabled()` OR NOT(OrderView Full OR QuoteView Full) |
| Default account | `header.disabled()` OR InvoiceCreditNoteView != Full |
| Order date | `header.disabled()` OR OrderView != Full |
| Shipment required-by date | cancelled OR read-only |
| Tax rule | cancelled OR OrderView != Full OR read-only OR InvoiceCreditNoteView != Full |
| Ship-to-other checkbox, shipping address | read-only OR OrderView != Full |
| Shipping address line 2 | always |
| Skip-quote checkbox | read-only once Quote or Order is `AUTHORISED`; otherwise read-only = `header.disabled()` |

`hasActiveChild`: any child (index >= 1) whose pick (type 2) / invoice (3) / credit-note (4) status is neither `VOIDED` nor `DRAFT`, or the master has pick, invoice or credit-note status other than `NOT AVAILABLE`/`VOIDED`.

**Quote tab** (`StatusTracker.quote.setDisabled(disabled)` with `disabled = (QuoteStatus == AUTHORISED)`):

* `readOnly = IsReadOnly || cancelled || disabled || QuoteView != Full || isRejected()`.
* Visible when `!readOnly`: New line, Scan, Import, Add bulk (also needs `ProductFamilyCount > 0`), Discounts (`DiscountCount > 0`), Coupon (`CouponCount > 0`), New charge line, delete column, New payment (deposit) rows.
* **Authorise** visible = `!disabled && !IsReadOnly && !cancelled && QuoteAuthorisationPermission == 'Full'`. "Go to order" button visible when Authorise is hidden AND order status != `NOT AVAILABLE` AND OrderView != None.
* Quote memo disabled when `QuoteView == 'ReadOnly'` or (readOnly and not `EditAuthorizedDocumentsPermission == Full`). Quote tab link hidden when `QuoteView == None` or `SkipQuote` or quote `VOIDED`.
* Approve/Reject/Review/Archive buttons: section 2.6.

**Order tab** (`StatusTracker.order.setDisabled(disabled)`, `disabled = status in {AUTHORISED, AUTH_NO_ALLOC, CLOSED, FULFILLED}`):

* `readOnly = IsReadOnly || cancelled || disabled || OrderView != Full`; `readOnlyTaxAccounts` additionally true when `IsSaleTaxManagementServiceEnabled` (Avalara-style tax service) so tax rule can't be edited.
* Visible when `!readOnly`: New line, Scan, Import, Add bulk, New charge, Discounts, Coupon; "Copy from quote" only when `!quote.skip`.
* **Authorise** (`divAuthorise_Order`) visible = status NOT in `{BACKORDER, SHORT STOCK, NO STOCK}` AND `!disabled && !IsReadOnly && !cancelled && OrderAuthorisationPermission == 'Full'`. When tenant `AllowOrderNoAlloc` is false the dropdown toggle is removed (single button); when true the button has a dropdown that offers authorise-without-allocation.
* **Split** (`divSplit_Order`) visible only when status `SHORT STOCK` and OrderAuthorisation Full. **Backorder** (`divBackorder_Order`) visible when status `SHORT STOCK` or `NO STOCK` and OrderAuthorisation Full.
* **Price cell exception**: `Price` stays editable on an authorised order if `EditAuthorizedDocumentsPermission == 'Full'` (SM › `vSaleOrderLinesEditing.beforeedit` checks it before the read-only test). Comment is editable on an authorised order unless `IsReadOnly`.
* If `PricesDiscountsPermission != 'Full'`: `Discount` never editable; `Price` not editable when the existing value is non-zero (grid) / when line discount != 0 (`SaleMult_Order_IsFieldEditable`).
* Tax rule cell blocked when `readOnlyTaxAccounts`.
* Order memo disabled when `OrderView == 'ReadOnly'` or (readOnly and not allowAuthorizeEdit).

**Deposits (customer prepayments)** `StatusTracker.deposits.setDisabled`: `readOnly = IsReadOnly || cancelled || QuoteView != Full || OrderView != Full`. Add-payment buttons require `!readOnly`; gateway buttons additionally `IsPaymentGatewayEnabled`; Cin7 Pay buttons additionally `IsCin7PayEnabled` and the sale being saved.

**Pick** (`SaleMult_Pick_OnOpen`): disabled (read-only) when `PickStatus` is `AUTHORISED` or `VOIDED`, or `NOT AVAILABLE` on a non-fulfilment (type != 2) task; `pick.readOnly = IsReadOnly || cancelled || disabled || PickView != Full`. Authorise visible = not voided, not read-only, not cancelled, `PickAuthorisationPermission Full`, and `PickStatus != AUTHORISED`. "Go to pack" visible when authorised and `PackView != None`. **Undo pick** visible when pick is authorised AND pack not authorised AND `UndoPermission == Full` AND not read-only. Buttons New/Scan/Auto/Auto-available follow `!pick.readOnly`.

**Pack** (`selectPack`): read-only when `PackStatus` is `AUTHORISED`/`VOIDED`, or `NOT AVAILABLE` while pick not authorised. Authorise visible when not voided/authorised (+ perms as above); "Go to ship" when authorised and `ShipView != None`; **Undo pack** when pack authorised AND shipment not authorised AND `UndoPermission Full`. Sub-tabs "Shipping instructions" and "Package detail" are enabled only when pack is `AUTHORISED`.

**Ship** (`selectShip`): read-only when `ShipmentStatus` is `AUTHORISED`/`VOIDED`, or `NOT AVAILABLE` while pack not authorised. Authorise visible unless statuses `PINVALID ADDRESS | INVALID ADDRESS | CONFIRM`; a separate "Confirm and authorise" button shows for the two invalid-address statuses. **Undo ship** when ship authorised and `UndoPermission Full`.

**Invoice** (`SaleMult_Invoice_OnOpen`): lines read-only when status `AUTHORISED`/`PAID` (and then payments become editable; before authorisation payments are read-only). Authorise visible = not read-only, not cancelled, `InvoiceCreditNoteAuthorisationPermission Full`, status not `AUTHORISED`/`PAID`. **Undo** visible = same perms AND status `AUTHORISED|PAID` AND `UndoPermission Full`. "Copy remaining" buttons visible only before authorisation. Invoice date editable before authorisation, or after if `EditAuthorizedDocumentsPermission Full` (and not in a locked accounting period: `SaleMult_Index_IsInLockedPeriod`, tenant `TenantLockDate`). Due date editable unless read-only. Payments block is shown only when status `AUTHORISED|PAID`. Invoice conversion rate editable only before authorisation. Add-charge allowed unless (read-only without allow-change-authorised) or locked period. Quantity cells read-only when `readOnlyQuantities`; Tax rule/Account cells ignore `readOnlyLines` but obey `readOnlyTaxAccounts`.

**Credit note** (`SaleMult_CreditNote_OnOpen`): lines editable while status != `AUTHORISED`; once authorised, payments (refunds) become editable and lines lock (unless `EditAuthorizedDocumentsPermission Full`). Authorise visible for `InvoiceCreditNoteAuthorisationPermission Full`, status not `AUTHORISED`/`VOIDED`. "Copy from invoices" visible when lines editable and not locked period. Invoice selector disabled when authorised/voided or restock voided. Refund block visible only after authorisation.

**Restock** (`SaleMult_Restock_OnOpen`): Authorise visible for `InvoiceCreditNoteAuthorisationPermission Full`, not read-only, not cancelled, restock not `AUTHORISED`/`VOIDED`. Invoice selector editable only while neither restock nor its credit note is authorised/voided.

**Toolbar / menu** (`SaleMult_Index_AdjustMainToolbarActions`, `SaleMult_Index_UpdateVisibilityForExclusiveStatuses`):

| Action | Visible when |
|---|---|
| Save | `!IsReadOnly && !cancelled` |
| Print, Email | `!IsReadOnly && !cancelled && saved` |
| Undo (whole sale) | `UndoPermission Full && !IsReadOnly && !cancelled && saved` |
| Void (whole sale) | `VoidPermission Full && !IsReadOnly && !cancelled && saved` |
| Clone | always listed; guarded by `Sale_CommonSale_CanSaleClone` |
| Mark as fulfilled | `OrderAuthorisationPermission Full && !IsReadOnly` and order status `AUTHORISED` or `AUTH_NO_ALLOC` |
| Mark as closed | same perm and order status `AUTHORISED`, `AUTH_NO_ALLOC` or `FULFILLED` |

A voided sale is fully read-only (`SaleMult_Index_ApplyReadOnlyState` hides Save etc.). Ctrl+S = Save with `PlannedOperation = ''` (does **not** run required-field validation; the Save buttons do).

### 2.4 Button handlers: what each does (endpoint + payload)

All "Authorise" buttons first run `window.__HighlightInvalidFields.validation(RequiredFieldsIds)` (only Quote and Order buttons and Save do; child-tab Authorise buttons rely on their own checks below). **Required fields** = `SaleMult_Index_Customer`, `SaleMult_Index_PriceTier`, `SaleMult_Index_SalesRepresentative`, `tdSaleMult_Index_DefaultAccount`, `SaleMult_Index_Tax`, `SaleMult_Index_Location`, `SaleMult_Index_Date`, `Sale_ARE_PlaceOfSupply` (country-specific, only if visible). Invalid fields get an `invalid` highlight; toast (error) = `<Label> is required.` per field joined with `<br />`, or `Please specify all required fields.` if no label could be read. Disabled or hidden controls are skipped. A control with `data-positive-value` must also be `> 0`.

| Button | Client pre-checks (messages verbatim) | What it sends |
|---|---|---|
| Authorise **Quote** (`SaleMult_Quote_PreComplete` -> `SaleMult_Quote_Complete`) | (optional) make-to-order BOM config check; if `IsAutomaticallyApplyDiscounts && DiscountCount>0` run discounts first. Then: no `QuoteAuthorisationPermission Full` -> `You do not have permission to authorize quotes.`; no lines and no charges -> `Your sale quote is empty. You cannot authorize an empty quote. If you don't need it, use the skip quote option.`; no customer -> `Please provide a customer name first.` | Sets `QuoteStatus=AUTHORISED`; if tenant `IsQuoteApproveEnabled` is false also sets `SaleOrderStatus=DRAFT` and `PlannedOperation='Order:CopyFromQuote'`; then full save. After save, `Order:CopyFromQuote` copies quote lines + charges into the order (memo too if order memo empty) and toasts `Sale quote has been successfully authorized.` |
| Authorise **Order** (`SaleMult_Order_PreComplete` -> `...CompleteAction` -> `SaleMult_Order_Complete` / `...CompleteNoAlloc`) | Pre: if `AllowOrderNoAlloc` is false, run directly; discounts first if auto-apply. `OrderAuthorisationPermission != Full` -> `You do not have permission to authorize orders.`; no order lines -> `Your sale order is empty. You cannot authorize an empty order.`; no customer -> `In order to complete this action, please create a customer record. The currently provided information is insufficient to complete the action.`. Blank rows (no product/price/qty/tax/total) are stripped first (`SaleMult_Order_PrepareForSave`). Then the credit check (4.3). | Sets `SaleOrderStatus=AUTHORISED` (or `AUTH_NO_ALLOC` for the no-allocation variant) on **all** tasks in the tree, `GET /api/SaleMult_Index_CurrentCredit?CustomerID=` (see 4.3), on continue: if `SkipQuote` the quote lines/charges are removed, then full save. If the user answers No to the credit dialog the order status is put back to `DRAFT`. |
| **Split** / **Backorder** (Order) | Backorder: customer required else (modal) `In order to complete this action, please create a customer record. The currently provided information is insufficient to complete the action.` | Backorder: copies order into the invoice (`SaleMult_Invoice_CopyFromSaleOrder`), sets order status `BACKORDER`, saves. Split has no client handler in this bundle (server-side by status). |
| Authorise **Pick** (`SaleMult_Pick_Complete`) | `You do not have permission to authorize pick.`; zero pick lines -> `Pick is empty, pick cannot be authorized without items. `(trailing space); per order product: picked qty > ordered qty -> `The product with code ({0}) has the picked quantity ({1}) greater than the ordered quantity ({2}). The total quantity in pick cannot exceed the ordered quantity.` | Sets fulfilment task `PickStatus=AUTHORISED`; if pack lines exist sets `PackStatus=DRAFT`; (when tenant `DefaultSkipPack` is false and no pack lines it plans `Pack:CopyFromPick`, which this bundle's post-save switch does not handle; the actual auto-copy occurs when the Pack tab is opened with `DefaultSkipPack` true and `PackAuthorisationPermission Full`); full save. |
| Authorise **Pack** (`SaleMult_Pack_Complete`) | empty -> `Your packing list is empty. You cannot authorize an empty packing list.`; per (product, location[, batch/SN, expiry]) pick qty != pack qty (rounded 4 dp) -> `The product with code ({0}) in location ({1}) has a different quantity in pack ({2}) than in pick ({3}). Total quantities in pick and pack should match.` or, with serial/batch, `The product with code ({0}) in location ({1}) with serial number ({2}) has a different quantity in pack ({3}) than in pick ({4}). Total quantities in pick and pack should match.`; pack row quantity > matching pick qty -> `The quantity of the packed products is greater than has been picked. Please correct.` (FIFO costing ignores batch/expiry in matching.) | `PackStatus=AUTHORISED`; if `DefaultSkipShip` false and no shipment lines -> plan `Ship:CopyFromPack` (after save copies pack to ship and toasts `Packing has been successfully authorized.`); if shipment lines exist -> `ShipmentStatus=DRAFT`; full save. |
| Authorise **Ship** (`SaleMult_Ship_Complete_Check` -> `SaleMult_Ship_Complete`) | external-fulfilment confirms (below); nothing marked shipped -> `Please specify the boxes you have shipped!`; some not shipped -> confirm `Not all boxes are marked as shipped. If you click 'Yes' a new fulfillment with the unshipped boxes will be created.`; empty -> `Your shipment is empty. You cannot authorize an empty shipment.`; packed boxes missing from shipment -> confirm `Your shipment doesn't include some packed boxes. You may split the fulfillment by clicking 'Yes' or add the missing boxes manually after clicking 'No'.`; a box listed by two shipment lines -> error `The package could be shipped only by one carrier. Please check shipments before completing.` | `ShipmentStatus=AUTHORISED` (after optional `SaleMult_Ship_SplitFulfillment` which spawns a new fulfilment task for unshipped boxes), `Boxes` string = `BoxesUI.join(',')`, full save. |
| Authorise **Invoice** (`SaleMult_Invoice_Complete`) | `You don't have permission to authorize an invoice.` (straight apostrophe); empty -> `Your invoice is empty. You cannot authorize an empty invoice.`; if `InvoiceDate` is null it is auto-filled (4.2); no due date -> `Please enter due date.`; over-invoicing check `SaleMult_Index_ValidateInvoiceAgainstOrder` -> `You cannot authorize more than was ordered or remains to be invoiced.` (and each offending line gets `ValidationText = 'The invoiced quantity exceeds the remaining quantity to be invoiced.'`, `ValidationState='Invalid'`); then credit check (4.3, uses `SaleMult_Invoice_GetTotal`). | `InvoiceStatus=AUTHORISED`, `PlannedOperation='Invoice:Authorise'`, full save. After save: `SaleMult_Invoice_CheckForDeposits`: if `Balance != 0` and the customer has unused credit/deposit (`vSaleTaskCreditStore` row with `RemainingAmount>0`, or `GET /api/Sale_Invoice_CheckForDeposits?CustomerID=&TaskID=` returns `true`) -> confirm titled `Use customer credit`: `The customer has an unused deposit for this sale. Do you want to allocate it?` -> opens the allocation dialog. |
| Authorise **Credit note** (`SaleMult_CreditNote_Complete`) | `You do not have permission to authorize credit notes.`; empty (lines + charge lines) -> `Your credit note is empty. You cannot authorize an empty credit note.`; per product: credited qty > Σ invoiced qty on authorised/paid invoices -> `The credited quantity ({0}) for product ({1}) exceeds the invoiced quantity ({2}) which is not allowed.`; restock vs credit rule -> `Total product ({0}) restock quantity ({1}) cannot exceed the total credited quantity ({2}).` | Date defaults to now if empty; `CreditNoteStatus=AUTHORISED`; full save. |
| Authorise **Restock** (`SaleMult_Restock_Complete`) | `You do not have permission to authorize restocks.`; empty -> `Your restock is empty. You cannot authorize an empty restock.`; restock > credited (same message as above); restock qty > shipped-and-not-already-restocked qty -> `Product ({0}) restock quantity ({1}) could not exceed the picked quantity ({2}).` or with batch `Product ({0}) batch ({1}) restock quantity ({2}) could not exceed the picked quantity ({3}).` | `RestockStatus=AUTHORISED`, full save. |
| Add payment (invoice, from "New payment" dialog `SaleMult_NewPayment_Save`) | required: account, date paid, amount (field-validation toast `<Label> is required.`) ; row-add path `SaleMult_Invoice_AddPaymentLinesRecord`: invoice not `AUTHORISED/PAID` -> `You need to authorize the invoice before registering payments.` | Appends a `vSalePaymentLines` row `{PaymentID:guid, Type:'ACCREC', PaymentType:'R', AccountCode, Reference, DatePaid, Amount, CurrencyConversionRate}` (credit note: `vSaleCreditNotePaymentLines`, `Type:'ACCRECCREDIT'`, `IsNewCustomerCredit:false`); it is persisted by the next full save. Credit-note refund add: in the Sale form (`SaleMult_CreditNote_AddPaymentLinesRecord`) the credit note not being `AUTHORISED` gives `You need to authorize the credit note before entering a refund.`; the stand-alone credit-note page (CN) words it `You need to authorize the credit note before registering refunds.` |
| Add customer deposit/credit (`SaleMult_Order_AddDepositsRecord`) | no customer account mapping -> `Please specify a customer credit account in your account mapping before saving the changes.`; no customer -> `You must select a customer before adding customer credit.`; cancelled or unsaved -> `Sale task must be saved before adding a customer credit.`; blocked when order is `CLOSED` | opens deposit dialog (`SaleMult_NewDeposit_Show`) |
| **Mark as fulfilled** (`SaleMult_Index_MarkAsFulfilled`) | silent return if read-only or order status in `VOIDED, CLOSED, FULFILLED, NOT AVAILABLE, DRAFT`; blocked while a type-1 task has a pick+pack+ship in flight (ship not `VOIDED/AUTHORISED`, none `NOT AVAILABLE`) -> error `You cannot mark a sale as fulfilled while uncompleted fulfillments remain. Please complete or void the uncompleted fulfillments.`; confirm `The sale will be marked as fulfilled. Click 'yes' to proceed.` (title `Confirmation`) | sets `SaleOrderStatus=FULFILLED` on every non-voided task, full save |
| **Mark as closed** (`SaleMult_Index_MarkAsClosed`) | same silent returns (no FULFILLED exclusion); all shipments done, and Σ invoiced qty per product (authorised/paid invoices on the master) must equal Σ shipped qty per product -> else `You cannot mark the sale as closed. Please ensure there are no discrepancies between the invoiced and fulfilled goods and all of your fulfillments are completed.`; confirm `The sale will be marked as closed. Click 'yes' to proceed.` | sets `SaleOrderStatus=CLOSED` on every non-voided task, full save |

### 2.5 Separate (non-save) calls

| Action | Call | Notes / confirm text |
|---|---|---|
| Undo whole sale (`SaleMult_Index_Undo`) | `POST /SaleMultiple/Undo` form params `TaskID`, `RemoveAllocations` (bool), timeout 300 s | Pre: `UndoPermission != Full` -> `You do not have permission to undo this sale.`; unsaved -> `You cannot undo an unsaved task.`. If the sale has customer credits (`vSaleTaskCreditStore` non-empty) first `POST /SaleMultiple/DepositValidate` (params `TaskID`): OK -> confirm `This will change the task status back to draft. You will need to authorize each step to confirm your changes! Would you like to proceed anyway?` (title `Confirmation`, buttons Yes!/No); error -> warning titled `Deposit deletion warning` then confirm `This will change the task status back to draft.\nDeposit(s) with all allocated payments will be removed. Do you want to proceed?` and call with `RemoveAllocations=true`. Success toast `Undo operation completed successfully.` (or the server text), tab reset to Quote (Order if SkipQuote). |
| Void whole sale (`SaleMult_Index_Cancel`) | `POST /SaleMultiple/Cancel` params `TaskID`, `RemoveAllocations` | `VoidPermission != Full` -> `You do not have permission to void this sale.`; unsaved -> `You cannot void an unsaved task. Close this page to discard any changes.`; confirm (HTML) `This will discard your current changes and delete the quote, order, pick, pack, ship, invoice and payment records! <span style="color: red;">Voiding a sale with an existing payment will delete the financial transactions and will not refund a payment.</span> Would you like to proceed anyway?`; with deposits: after DepositValidate failure `Deposit(s) with all allocated payments will be removed. Do you want to proceed?`. Success toast `Void operation completed successfully.` |
| Undo child (fulfilment/invoice/credit note) | `POST /SaleMultiple/UndoChild` params `TaskID`, `TaskTypeSign`; restock `POST /SaleMultiple/UndoRestock`; journals `/SaleMultiple/UndoJournals` | `You do not have permission to undo.`; `You cannot undo an unsaved task.`; invoice with an authorised linked credit note -> `You cannot undo an invoice while you have an authorized linked credit note.` (rule `canUndoVoidInvoice`: any non-NA/VOIDED/DRAFT credit note whose `CreditNoteInvoiceNumber` list contains the invoice number, case-insensitive). Confirms: `All unsaved changes will be lost. This will revert fulfillment #{n} status back to picking. Would you like to proceed?`, `... revert invoice #{no} status back to draft...`, `... revert credit note #{no} status back to draft...`; invoice with allocations: `This will revert the invoice #{no} status back to draft. All allocated payments will be removed. Would you like to proceed?`. Success toasts `Undo operation for fulfillment #{n} completed successfully.`, `...for invoice #{no} completed successfully.`, `...for credit note #{no}...`. HTTP 404 -> client force-deletes the stale child. |
| Void child | `POST /SaleMultiple/CancelChild` params `TaskID`, `TaskTypeSign` | `You do not have permission to void.`; `You cannot void it. Reload the sale to discard any changes.`; `You cannot void an invoice while you have an authorized linked credit note.`; confirms `All unsaved changes will be lost. This will discard your changes and void fulfillment #{n}: pick, pack and ship records! Would you like to proceed anyway?`, `...void invoice #{no}. Would you like to proceed?`, `...void credit note #{no}...`; invoice with allocations `This will void invoice #{no}. All allocated payments will be removed. Would you like to proceed?`. Toasts `The void operation for fulfillment/invoice/credit note ... completed successfully.` |
| Pick / Pack / Ship undo | **no endpoint**: sets statuses and saves. Pick undo: `PickStatus=DRAFT, PackStatus=NOT AVAILABLE, ShipmentStatus=NOT AVAILABLE`. Pack undo: `PackStatus=DRAFT, ShipmentStatus=NOT AVAILABLE` + clears package details and shipping instructions. Ship undo: `ShipmentStatus=DRAFT`. Guards: `Unable to undo pick when pick has not been authorized.` / `...pack...` / `Unable to undo ship when ship has not been authorized.` |
| Clone | `POST /SaleMultiple/CloneValidate`, then form submit `frmClone` with `IDToClone` | guarded by `Sale_CommonSale_CanSaleClone` / `Sale_CommonSale_CheckOnSalesLimit` |
| Credit position | `GET /api/SaleMult_Index_CurrentCredit?CustomerID=` -> `{CurrentCredit, IsOnCreditHold, GracePeriodExceeded}` | section 4.3 |
| Price / discount engine | `POST /api/SaleMult_Index_PriceRequest` | section 3.4 |
| Exchange rate | `GET /api/GetRate?From&To&Date` | 1.6 |
| Approve / reject | `POST /QuoteNOrderApprove/Approve` params `taskID,newState (1 reject, 2 approve, 0 review),taskType:'sale'` | 2.6 |
| Archive | `POST /QuoteNOrderArchive/Archive` params `taskID` | 2.6 |
| Print | `GET /Sale/Print?PrintEntityID=&PrintTemplateID=` -> document id; downloaded via `/Sale/Download/<id>?isPrint=true` | save first with `SuppressTransactions=true`; toast `Printing...` |
| Email | same `/Sale/Print` then email dialog | toast `Generating a report, please wait...` |
| Mark fulfilled/closed, all Authorise, Save, Add payment, line edits | **no dedicated endpoint**: just the full-tree save of section 0 |

Save outcome handling (`SaleTaskWrapperStore.load`): if `HasErrors`, each task's `ValidationText` is shown as an error toast, or the generic `There were problems saving changes. Please see the errors in details.`; rows carry per-row `ValidationText`/`ValidationState` (`Good|Invalid`) rendered in the grid's validation column; new children are dropped from `Original`. If `Warnings` present -> success toast with them. Otherwise `Changes saved successfully.` (suppressed when a planned operation will toast instead). A payment already synced to Xero produces the sticky warning `The payments which were made previously have already been synced to Xero. Therefore please remove the payments / refunds in target invoice / credit note manually.`.

### 2.6 Quote approval and archive (tenant settings `IsQuoteApproveEnabled`, `IsArchiveEnabled`)

Approval state `QuoteApprove`: **0 = pending, 1 = rejected, 2 = approved** (SM › `setApproveButtonsVisible`, `isApproved`, `isRejected`).

* With approval enabled and the quote authorised: state 0 -> Approve and Reject buttons visible; state 1 -> Review (resets to 0 via Undo) visible; state 2 -> static "approved" label.
* Confirms: `Are you sure you want to reject this sale quote?` / `Are you sure you want to approve this sale quote?` (title `Confirmation`, Yes/No). Failure toast `Approve failed! Please try again later.`
* `isApproved()` is true when approval is disabled, or state == 2, or no approval needed (`SkipQuote`, an authorised/paid invoice exists, or stock status authorised). The Order link/"Go to order" button only appear when `(SkipQuote || quote AUTHORISED) && isApproved() && OrderView != None && !IsServiceOnly && order not VOIDED`. The sale opens on the Order tab if quote authorised/skipped and approved.
* With approval enabled, authorising the quote does **not** copy it to the order automatically (`IsQuoteApproveEnabled` true skips the `Order:CopyFromQuote` plan); "Copy from quote" is manual.
* Order status chip in lists shows `Awaiting approval` when order status 1 and overall `Status == 'AWAITING APPROVAL'`.
* Archive (only when `IsArchiveEnabled`, saved, quote/order not archived): Archive button shown with the Authorise-visible condition. Errors: `Prepaid sale quote can not be archived.` (any ACCREC `PaymentType P` payment line exists). Confirm `Are you sure you want to archive this sale quote?`. Failure `Archiving failed! Please try again later.` Archived quotes show an "archived" static label.

---

## 3. Field dependencies

### 3.1 Choosing a customer (`Sale_Customer_SelectEvent` and `Sale_Customer_ChangeEvent`, SM)

Customer combo: remote-queried by `Name` (`GET /api/SaleMult_Index_vSaleMult_Customer?Name=..&lang=..&CountrySpecificKey=..`), `forceSelection`, empty text `Select a customer...`, "Add" link opens New customer. Customer record fields used: `CustomerID, Name, Currency, PaymentTerm, TaxRule, Comments, DefaultSalesRepresentative, AccountCode, DefaultLocation (+LocationName etc.), Discount, DefaultCarrier, SalePriceTier, CreditLimit, AttributeSet, BillParent`.

Applied to **every** task in the tree: `CustomerID`, `CustomerName`. Then:

| Sale field | Value after selecting customer (new customer, not the sale's original one) |
|---|---|
| `CustomerCurrency` | `customer.Currency` upper-cased (if the customer is removed: tenant currency) |
| Rate | if currency changed: equal to tenant -> rate 1 (and discounts re-run); else fetch `GetRate` (see 1.6) and set `CurrencyConversionRate`/`CreditNoteConversionRate`, quote or order rate box, re-run discounts |
| `Carrier` | `customer.DefaultCarrier`; `CarrierServiceDisplayName` = carrier description; `CarrierCode`, `CarrierServiceCode` cleared |
| `CreditLimit` | `customer.CreditLimit` (0 if cleared); if `> 0` the credit position is checked immediately (4.3 first message) |
| Terms | `customer.PaymentTerm` id -> term name, `TermDays`, `TermMethod`, `TermDueNextMonth`; else if the tenant has exactly one term, that term; else `Terms=null, TermDays=null, TermDueNextMonth=-1` |
| Contact, Phone, Email, Billing/Shipping address lines, `ShipAddressID`, `ShipTo*` | cleared (contact/address stores reload from `CustomerID`, defaults come from the customer's address book); if "ship to other" is unchecked `ShipToCompany/Contact` cleared |
| Tax rule | unless `IsSaleTaxManagementServiceEnabled`: `customer.TaxRule` -> sets `TaxSchema`, `TaxPercent = rule.EffectivePercent`, `TaxInclusive = rule.Inclusive`, and re-prices all lines (`SaleMult_Index_UpdateTaxInclusive`) + empty lines get the rule; else if tenant has one rule use it; else none (`TaxPercent 0`, exclusive) |
| Price tier | `customer.SalePriceTier` if > 0 else the first tier in the tenant list -> triggers `SaleMult_Index_LoadPrices` |
| Location | `customer.DefaultLocation` if set and known; else if tenant has one location, it; else null |
| Default account (revenue) | `customer.AccountCode` if set else first account of the sale revenue list |
| Sales rep | only if `CommonSale_Index_CanSaleRepChanged()` (not pinned by `UseCurrentUserAsSaleRep`): `customer.DefaultSalesRepresentative`, else the tenant's only contact, else null |
| Internal memo (`SaleTaskMemoInternal`) | `customer.Comments` |
| `Discount` (header % applied to new lines) | `customer.Discount` |
| Attribute set | copied per tenant `AttributeSetCopyFrom` if the sale is unsaved |
| Prepayment blocks | shown once a customer is assigned, hidden when cleared |

If the user re-selects the customer the sale already had (`newValue == original CustomerName`) all of the above are restored from the **original** values instead (terms, contact, addresses, tax rule, price tier, location, account, rep, discount, memo).

Customer can't be changed once the sale has customer credits/allocations, an active child, or the header is disabled (2.3).

### 3.2 Other header dependencies

* **Tax rule combo** (`cmbTax.change`, not on first load): sets `TaxPercent = rule.EffectivePercent` on all tasks, fills empty lines with the rule, sets the Tax-inclusive checkbox to `rule.Inclusive`.
* **Tax inclusive checkbox** (`SaleMult_Index_UpdateTaxInclusive`): if the value changes it re-derives `TaxPercent` on **every** line and charge in Quote, Order, Invoice and Credit-note stores from the line's own `TaxRule` (inclusive or exclusive percent), recalculates `Total`/`Tax` per line, then refreshes all four totals boxes. Lines whose rule isn't in the tenant list are left unchanged.
* **Price tier** change -> `SaleMult_Index_LoadPrices(newTier)` (3.4). Tier values `1..10`; label `Name`, value `Code`. Alert if tier 0: `Please select a price tier before applying the discounts.`
* **Terms** select -> copy `Days, Method, DueNextMonth` to all tasks, recompute the open invoice's due date.
* **Order date** change -> copies `SaleOrderDate` to every task; re-fetches the exchange rate (1.6).
* **Location** select -> copies `OrderLocationID` + `SaleOrderLocation` to every task, reloads the product list for that location (`TaskLocationID`). If tenant has exactly one location it is selected automatically on load.
* **Required-by date** -> copied to the master and to any task without its own date.
* **Skip quote** (`SaleMult_Quote_Skip`): setting it removes all quote lines/charges (and hides the quote tab), seeds three blank order lines if the order is empty and `OrderView Full`, moves to the Order tab; clearing it shows the Quote tab again and seeds three blank quote lines if quote is empty and `QuoteView Full`. Locked once quote or order is `AUTHORISED`.
* **Default account** select -> sets `DefaultAccount` on every task; new invoice lines take line `RevenueAccount` or fall back to it.
* New sale: three blank quote lines are seeded when `DefaultSkipQuote` is false (blank quantity = tenant `DefaultQuantity`, `getDefaultQuoteQuantity` returns 0 when unset).
* Ship-to: an alternative-address option (`ShipToOther`) with `ShipToCompany, ShipToContact, ShipToAddress1/2, City, State, PostCode, Country`; `SaleMult_Index_RouteOrder` (only when tenant `OrderRoutingEnabled`, not first load, header enabled) picks a location from `ShipTo*` via the server and sets the Location combo.

### 3.3 Choosing a product on a line (`changeProduct` inside `SaleMult_Order_CreateControls`; quote/invoice versions are analogous)

Product combo: remote search through `ProductStore` with params `{lang, TaskLocationID: cmbLocation, currencyRate: order rate if the rate box is visible else 1, customerID, Name:<query>}`; each result carries `ProductID, ProductCode, Name, UnitOfMeasure, AverageCost, PriceTear1..PriceTear10, Available, OnHand, Type, DropShipMode, SaleTaxRule, RevenueAccount, CostingMethod, ImageID, IsMakeToOrderBom, SupplierLatestPurchasePrice, SupplierFixedCost, SupplierCurrency`. List item shows name, SKU, price for the current tier, `Available/On hand`.

On change of `ProductCode` the line is set to:

| Line field | Value |
|---|---|
| `ProductID`, `ProductCode`, `Name`, `UnitOfMeasure`, `CostingMethod`, `RevenueAccount`, `ImageID` | from product |
| `Price` | `SaleMult_Index_GetPrice(product)` = `product.PriceTear<N>` where N = current price-tier value (1..10); any other value -> **0** |
| `Discount` | the sale's header `Discount` (customer's default discount %) |
| `AverageCost`, `SupplierLatestPurchasePrice`, `SupplierFixedCost`, `SupplierCurrency` | from product (for margin) |
| `NonInventory` | `product.Type === 'Non Inventory'` |
| `IsMakeToOrderProduct` | `product.IsMakeToOrderBom` (opens the BOM configuration dialog) |
| `DropShipMode` | `product.DropShipMode` (`N` never, `O` optional, `A` always) |
| `DropShip` | `N` or `O` -> false; `A` -> true |
| Tax rule + percent | unless `IsSaleTaxManagementServiceEnabled` (then rule = `TaxSchema`, percent 0): `product.SaleTaxRule` if set else the header tax rule; percent = rule's inclusive/exclusive percent per the sale flag |
| `Quantity` | unchanged (blank line = `DefaultQuantity` or 0 from the quote seeding; order blank rows have 0) |
| then | `UpdateTaxAndTotal`, `SaleMult_Order_UpdateTotals`, grid refresh |

Drop-ship `O` (optional): editing Quantity sets `DropShip = !(Quantity <= product.Available)`. If the typed code isn't found in `ProductStore` the cell reverts to the original code.
`Backordered` starts at 0 (Quote -> Order copy sets `DropShip = (DropShipMode == 'A')`).
Alternative-product picker swaps product via the same function (`requiredQuantityKoeff` passed through).

### 3.4 Price/discount engine

`SaleMult_Index_LoadPrices(tier, submitAfter, callback, OnlyDiscountedProducts)`; no-op on first load; works on the quote lines if quote not completed, else on order lines if order not completed.
Request `POST /api/SaleMult_Index_PriceRequest` JSON `{Tier, CustomerID, Products:[{ProductID, Price, Quantity (summed per product), IsMakeToOrder}], SaleTaskID, OnlyDiscountedProducts, CurrencyRate}`. Make-to-order lines are excluded; if all lines are MTO nothing is sent. Blocking message `Applying discounts...`. Failure -> error toast of the response.
Response `{list:[{ProductID, Price, DiscountedPrice, Quantity, DealID, DealName, DiscountID, DiscountName}], customerPercentOverDiscounts}`. Client-side application (`SaleMult_Index_ApplyDiscountedPrices`):

```
discount = (price == 0) ? 100 : DEARRound( 100*(price - discountedPrice)/price , 4 ) ; cap at 100
if round2(line value using round2(discount)) equals round2(line value using full discount): discount = DEARRound(discount, 2)
tenant DiscountCalculationMethod == 'Price' :  line.Price = discountedPrice ; line.Discount = 0
otherwise (percent mode)                      :  line.Price = price ; line.Discount = discount
```

Special entries: `ProductID` empty/`buyCollectionChargeGuid` with qty 1 -> a negative-style "order total discount" charge line (`Order total discount` / `Buy collection discount`, `Amount = discountedPrice`, tenant header tax rule); free-shipping deals -> a charge line `FreeShipping <shipping description>` with negated amounts. Previous `Order total discount` / `Buy collection discount` / free-shipping charge lines are removed and recreated each run. Quantity splitting: if the discount covers only part of a line's quantity the line is split into two lines (new line gets `guid`). Not applied when tenant `IsApplyManualPriceChangesForNonDiscountProducts` is true AND `customerPercentOverDiscounts <= 0` AND the response row has no deal/discount info, nor to the gift-card product. The banner lists the deals; customer discount line reads `Customer discount - {n}%` and links to the customer.

Triggers: price-tier change; "Discounts" button; `Quote/Order Authorise` when `IsAutomaticallyApplyDiscounts && DiscountCount > 0`; any rate change (with `OnlyDiscountedProducts=true`).

### 3.5 Quote/Order/Invoice/Credit-note line copying

* **Order from quote** (`SaleMult_Order_CopyFromQuote`): wipes order lines, creates `vSaleOrderLines` with Quantity, Price, Discount, Total, Tax, product fields, `Backordered 0`, `DropShip = (DropShipMode=='A')`, `TaxRule` (or the tax-service rule), `TaxPercent`, comment, MTO config; sets order `DRAFT`; charges copied similarly.
* **Invoice from order / remaining** (`SaleMult_Invoice_CopyFromSaleOrder`, `SaleMult_Invoice_CopyRemaining`): lines get `AccountCode = line.RevenueAccount || DefaultAccount`, `Type 'ACCREC'`, `Total/Tax` recomputed with `UpdateTaxAndTotal`. When the invoice is linked to fulfilments the "remaining" qty per (product+code+price+discount+tax rule, rounded 4 dp) line is the smaller of (order qty minus qty already on authorised/paid invoices linked to the same fulfilments) and (order qty minus qty on all authorised/paid invoices). Invoice memo defaults to the order memo when empty. (The remainder of this function, including how picked quantities are applied, was not read.)
* **Credit note from invoice** (`SaleMult_CreditNote_CopyLinesFromInvoice`, `...CreditNoteLineSelectStore`): choosing `ProductCode` in a credit-note line fills qty = remaining creditable qty, discount, price, account, tax rule/percent from the invoice line; `RemainingQuantity` bookkeeping prevents over-crediting; line add/copy blocked with warning `Please select invoice(s).` when no invoice picked.
* Quote->Order and Invoice dedupe key: `ProductID + Price + ProductCode + TaxRule + Discount (+ BOM configuration id)`.

### 3.6 When fields lock (summary)

See 2.3. Plus: invoice/credit-note dates and payment lines lock when inside an accounting lock period (`SaleMult_Index_IsInLockedPeriod`, tenant `TenantLockDate`); document lines lock after authorisation (edit-authorised override via `EditAuthorizedDocumentsPermission`); conversion-rate boxes lock with their document; tax/account cells lock when `IsSaleTaxManagementServiceEnabled`.

---

## 4. Validations

### 4.1 Line-level

* Blank rows are silently removed on save: order/quote line with no product AND price 0 AND qty 0 AND tax 0 AND total 0; charge with description `''` AND amount 0 AND qty 0 AND tax 0 AND total 0. **Extra rule when saving while on the Quote tab**: order lines/charges missing product (or description) OR qty 0 OR tax rule are removed too. `LineOrder` is then re-numbered 1..n separately for lines and charges.
* Edits that don't change the value are ignored (`e.value !== e.originalValue`).
* Order cell restrictions per 2.3. Quantity/price/etc. accept expressions (1.3).
* Make-to-order lines must have a valid configuration before authorise (`IsMakeToOrderConfigurationValid`; check dialog from `SaleMult_Index_CheckMakeToOrderProductConfigurations`).
* Invoice line: over-invoice check at authorise (2.4). Credit note: over-credit and restock checks (2.4). Pick/pack/ship checks (2.4). Per-row server validation comes back via `ValidationText`/`ValidationState`.

### 4.2 Invoice date auto-fill (tenant `FillInvoiceDateOnOrderAuthorisation`, `FillInvoiceDateOption`)

Constants: `WHEN_INVOICE_AUTHORISED`, `WHEN_ORDER_AUTHORISED`, `WHEN_SHIPMENT_AUTHORISED`; option `SALE_ORDER_DATE` | `SALE_SHIPMENT_DATE`. 

* `SaleMult_Invoice_OnOpen` (invoice has no date): for `WHEN_ORDER_AUTHORISED`: order date, or latest authorised shipment date (only if exactly one authorised fulfilment with shipment rows; else today). For `WHEN_SHIPMENT_AUTHORISED`: if >=1 authorised shipment: order date or the shipment date; else if every order line is drop-ship: order date (when option is order date) else leave **empty**; otherwise empty. `WHEN_INVOICE_AUTHORISED` leaves it empty until authorise. Whatever is filled also recomputes the due date.
* `SaleMult_Invoice_Complete` with a still-null date: default today; with the two non-"invoice" modes: order date, or latest shipment date of the fulfilments listed in `LinkedFulfillmentNumber` (comma list), else default-ship-date logic, else today.
* Latest shipment date = max of `ShipmentDate` over the shipment rows of authorised fulfilments.

### 4.3 Credit limit / hold (tenant `CreditLimit` per customer; `GET /api/SaleMult_Index_CurrentCredit`)

Response `{CurrentCredit, IsOnCreditHold, GracePeriodExceeded}`.

* **On customer select** (only if `customer.CreditLimit > 0`; `SaleMult_Index_CheckCreditLimit`): `IsOnCreditHold` -> error toast `Customer is on credit hold`; `GracePeriodExceeded` -> warning `Customer has been put on credit hold by the system due to exceeding their payment grace period.`; else if `creditLimit > 0 && CurrentCredit >= creditLimit` -> error titled `Credit limit exceeded`: `The customer outstanding balance is {CurrentCredit}, whereas the customer credit limit is {limit}.` (money-formatted).
* **On authorise Order / Invoice**: `current = CurrentCredit + total` where total = `SaleMult_Order_GetTotal()` / `SaleMult_Invoice_GetTotal()`. Warning dialog (`dearSwal`, type warning, Yes/No) if `IsOnCreditHold || (limit>0 && current > limit) || GracePeriodExceeded` (the no-allocation order variant uses `>=` to open the dialog but still prints the limit message only when `>`). Messages in priority order: hold -> title `Customer is on credit hold`, text `The customer is on credit hold. Would you like to continue?`; over limit -> title `Credit limit exceeded`, text `The customer outstanding balance including this order is {current}, whereas the customer credit limit is {limit}. Would you like to continue?` (same wording for invoices); grace -> title `Grace period exceeded`, text `Customer has been put on credit hold by the system due to exceeding their payment grace period. Would you like to continue?`. Yes = continue to save; No = status reverted to `DRAFT`. The check is **advisory**; if the CurrentCredit call fails the authorise proceeds. Tenant `CustomerCreditLimitMode` (settings page) selects how the server computes `CurrentCredit`.

### 4.4 Misc

* Customer required for any authorise (messages in 2.4). Add customer credit/deposit needs a customer and a saved sale (messages in 2.4).
* Credit note date defaults to today when empty; refunds only after authorisation.
* Term-editor and payment term validations in 1.8. New payment dialog requires account, date, amount.
* Gift cards: not used as payment in the sale that issued them, must not be refunded/forfeited, amount <= balance (CN has the messages: `This gift card is in this sale. It cannot be used for payment in the same sale.`, `This gift card is already used for payment. Please, enter another gift card code.`, `Please enter the amount to pay with this gift card that is less than or equal to the current gift card balance.`, `This gift card has been refunded.`, `This gift card has been forfeited.`, `Please enter a gift card price.`, `The expiration date should be greater than the current date.`, `Gift card refund is not allowed.`). Coupon: `Please enter a coupon code.`; `Please save this sale.`.
* Stand-alone credit note page (CN › `CreditNote_CreditNote_Complete`): `You do not have permission to authorize credit notes.`, `Your credit note is empty. You cannot authorize an empty credit note.`, `Please provide a customer name first.` (all as warnings); refunds before authorisation: `You need to authorize the credit note before registering refunds.`; customer credit refund: `You cannot add a customer credit for a non-saved customer.`; undo (`POST /SaleService/Undo` param `TaskID`) confirm `This will change the task status back to draft. You will need to authorize each step to confirm your changes! Would you like to proceed anyway?`; `You cannot undo an unsaved task.`. It creates a service-only task (`IsServiceOnly:true`, `SkipQuote:true`, `FulfillmentNumber:999`, `CreditNoteDate` today) and its totals are lines-only (no charges block).

---

## 5. Tenant settings that change sale behaviour

All arrive in `SaleReferenceData` (SM › `SaleReferenceDataStore.load`) unless noted. Settings page: `GeneralSettings2019.js`.

| Setting field | Effect |
|---|---|
| `SkipQuote` (`DefaultSkipQuote`) | default of the Skip-quote checkbox on new sales; also decides whether 3 blank quote lines are seeded |
| `SkipPack` (`DefaultSkipPack`) | when true, opening the Pack tab with no pack lines auto-copies pick -> pack (needs `PackAuthorisationPermission Full`); when false Pick-authorise plans a Pack copy that this page does not execute |
| `SkipShip` (`DefaultSkipShip`) | when false, Pack-authorise with no shipment rows auto-copies pack -> ship after save and toasts `Packing has been successfully authorized.`; selectShip clears shipment rows when `NOT AVAILABLE` and false |
| `ShowInvoiceBeforeFulfillment` | moves Invoices + Payments blocks above Fulfilment |
| `AllowOrderNoAlloc` | enables the "authorise without allocation" dropdown on the Order Authorise button; if false that dropdown is removed |
| `DefaultShipDate` | `'Invoice'` -> default shipment date = invoice date, else today (`CommonSale_GetDefaultShipmentDate`) |
| `FillInvoiceDateOnOrderAuthorisation`, `FillInvoiceDateOption` | invoice date auto-fill (4.2) |
| `TaxCalculationMethod` (`Row Total` / `Total`) | `TaxPrecision` 2 vs 4 (1.2) |
| `DiscountCalculationMethod` (`Price` or percent mode) | how discount-engine results land on lines (3.4); read-only for Xero tenants |
| `IsAutomaticallyApplyDiscounts` | discounts run automatically before Quote/Order authorise (needs `DiscountCount > 0`) |
| `IsApplyManualPriceChangesForNonDiscountProducts` | keeps manual prices on products with no deal/discount |
| `DiscountCount`, `CouponCount`, `ProductFamilyCount` | hide the Discounts / Coupon / Add-bulk buttons when 0 |
| `DefaultQuantity` | quantity of newly added quote lines |
| `IsQuoteApproveEnabled` | approval flow (2.6); authorise-quote no longer auto-copies to order |
| `IsArchiveEnabled` | Archive button |
| `UseCurrentUserAsSaleRep` | default sales rep = signed-in user's Sale contact (then not changeable by customer selection), else the `DefaultForType` rep, else first Sale contact; otherwise first contact |
| `IsSaleTaxManagementServiceEnabled` (+ `SaleTaxManagementRuleID`, `SaleTaxManagementServiceName`) | tax rule/percent taken from the service: line tax rule = `TaxSchema`/`SaleTaxManagementRuleID`, percent 0 (server fills), tax-rule cells locked, customer selection doesn't change tax |
| `OrderRoutingEnabled` | auto-pick location from ship-to address |
| `ShipStation`, `ExternallyFulfiledOrdersToShipStation`, `ForceHideLookup`, `ShipZonesEnabled`, shipping provider lists | shipping rate/label buttons and carrier lookups (`Get shipping rate` buttons show when >=1 rate provider; label buttons depend on provider `PrintShippingLabels && IsDefault`); "Resend to ShipStation" when authorised ship without tracking |
| `CountrySpecificKey` / `CountrySpecificData` | loads a country script (`/SaleMultiple/CountrySpecific?Key=`) adding fields (e.g. Place of supply) and tax-editability rules |
| `FinancialDataPermission`, `IsAccountingDimensionsEnabled` | accounting dimensions UI and prompts on save |
| `HeadersVisible` | whether the header block starts collapsed |
| `WarrantySetupEnabled`, `HasSaleDefaultAttributeSet`, `CurrentAttributeSetId`, `AttributeSetCopyFrom` | custom fields (CustomField1..10) and copy-from-customer |
| `RecommendBatchSNMode` | pick recommendations for batch/serial costing |
| Account-level (`Main`): `Xero`, `Quickbooks`, `EnableFinancials` | `PurchasePriceDecimals`, enable/disable of some settings, Xero link buttons, Xero-synced payments warning |
| `IsPaymentGatewayEnabled`, `IsCin7PayEnabled` | gateway / Cin7 Pay payment buttons |
| `TenantLockDate` (account info) | accounting period lock for invoice/credit-note/payment edits |
| `TenantCurrency`, `TenantCountry` | base currency and default country in dialogs |
| Payment terms list, tax rules list, price tiers list, locations, carriers, accounts (revenue / payments / customer credit / additional COGS) | all lookup combos; single-item lists auto-select (terms, tax rule, price tier, location, sales rep) |
| Permission set (section 2.3) | per-user, not per-tenant |

---

## 6. Sales list (SL)

* Three server-paged, remote-sorted grids selected by the `SaleListView` cookie (`#vGeneral` default, `#vAccounting`, `#vFulfilment`, plus `#vTransactions` for consolidated transactions): `GET /api/vSaleListGeneral`, `/api/vSaleListAccounting`, `/api/vSaleListFulfilment`. Query params: `search` (text box, Enter), `lang`, `customFilterID` (from `localStorage.customFilter`), `filter` (the per-view filter combo; cookie per view), and `date` (General) or `requiredByDate` (Fulfilment). `loadPage(1)` on every change. Empty text `You do not have any sales at the moment.` (Fulfilment: `You do not have any fulfillments matching the selected criteria.`).
* **General columns**: status icons, Order #, Order date, To (customer), Contact, Phone, Email, Ref, Documents, Ship by, Carrier, Tracking numbers, Status (hidden), Shipping line 1, Sale rep, Estimated (`DCQuoteTotal`, hidden), **Total** (`DCOrderTotal`), custom fields 1-10, Location, Quote sent, Order sent, Shipping notes, Type. **Accounting columns**: Order #, Document, Status, Ref, To, Contact, Phone, Email, Order date, Date, Due date, Terms, Overdue by, Sale rep, Total, Paid, Credited, **Due**, Location, Fulfillment status, Sent. **Fulfilment columns**: Sale status, Status, Order #, Order date, To, Contact, Phone, Email, Fulfillment #, Ship by, Overdue by, Ref, Shipping line 1, Sale rep, Payment status, Invoice status, Terms, Location, Carrier, Tracking numbers, Selected for picking, Picker, Shipping notes.
* Money in lists: `DEARMoneyFormat`; if the row's `Currency != TenantCurrency` and value != 0 the currency code is prefixed. Voided rows render grey (#ccc) strike-through; overdue rows in the Accounting view (`DaysOverdue > 0`) render red. `HasPriceInfoAccess` false -> `No access`.
* **Status icon cluster (General)** for non-voided rows (voided rows show a single `Voided`): quote icon (`QuoteStatus` 0 `Quote not available.` / 1 `Quote in progress` / 2 `Quote authorized`; `QuoteApprove==1` -> `Quote rejected`, archived -> `Quote archived`), order icon (`OrderStatus` 0 `Order not available`, 1 `Ordering` (or `Awaiting approval` when overall status is `AWAITING APPROVAL`), 2 `Ordered`, 3 `Closed`, 4 `Fulfilled`, plus a carrier chip), fulfilment icon (`FulFilmentStatus`: `NOT AVAILABLE | FULFILLED | NOT FULFILLED | PARTIALLY FULFILLED`), invoice icon (`InvoicingStatus`: `NOT AVAILABLE`->"Not ready for invoicing", `INVOICED`, `NOT INVOICED`, `PARTIALLY INVOICED / CREDITED`, `PARTIALLY INVOICED`, `INVOICED / CREDITED`, `AWAITING APPROVAL`, `PARTIALLY REFUNDED`, `CREDITED`, `COMPLETED`, `DRAFT`; for credit-notes (TT 4) uses `Status`), payment icon (`PaymentStatus`: `PREPAID`(orange), `UNPAID`, `PAID`, `PARTIALLY PAID`, `OVERPAID`, `OVERPAID / CREDITED`, `NOT AVAILABLE`, `NOT REFUNDED`, `REFUNDED`, `PARTIALLY REFUNDED`; greyed when invoicing status is `NOT AVAILABLE`/`NOT INVOICED`). Row `TT` (task type) 4 = credit note: no quote/order/fulfilment icons; `TT == 3` = advanced multi-doc sale.
* **Bulk actions** (`SaleList_BulkAction` -> `POST /api/SaleListBulkAction` params `ID` = task ids joined with `|`, `Action`, timeout 1 h): `AuthoriseQuote`, `AuthoriseOrder`, `AuthorisePick`, `AuthorisePack`, `AuthoriseShip`, `AuthoriseInvoice`, `Complete`, `Void`, `Undo`, `Email` (+`TemplateID`, `lang`, `CaptchaToken` via reCAPTCHA modal), plus `SaleList/Print`, `PrintCombined`, `ScheduleForPicking`, `UnscheduleForPicking`, `SetSalePicker`. Busy messages: `Authorizing quotes...`, `Authorizing orders...`, `Authorizing picking...`, `Authorizing shipment...` (pack and ship), `Authorizing invoices...`, `Completing sales...`, `Performing void operation...`, `Performing undo operation...`. Void confirm: `This will delete the quote, order, pick, pack, ship, invoice and payment records. Would you like to proceed anyway?`; Undo confirm: `This will change the task status back to draft. Would you like to proceed anyway?`. Selecting rows with `TT == 3` outside the General view: warning `Bulk actions for these advanced sales are allowed only on GENERAL VIEW:` + list of order numbers. No selection: `Please select at least one task to print.` / `...to e-mail.`.
* Print skipped notices: `Printing of {n} sale task(s) complete.`; skipped sales listed with `These sales skipped due to missing fulfillments:` / `invoices:` / `credit notes:`; `Document generated successfully. Download should start shortly...`; failure `Failed to generate a document.`
* Invoice financing (tenant-enabled): only unpaid, authorised, non-past-due invoices; invalid selection dialog `You have selected transactions that cannot be financed:` ... `You may only finance unpaid, authorized, non-past due invoices.`

---

## 7. Not determinable statically (server-side only)

* Document numbering: `SaleOrderNumber`, `InvoiceNumber`, `QuoteNumber`, `CreditNoteNumber`, `FulfillmentNumber` allocation; the client only shows the literal `Not assigned`.
* Whether the server recomputes `Total`/`Tax` from `Price/Quantity/Discount/TaxPercent` or trusts the client; the server-side tax-rule math that yields `EffectivePercentInclusive` and `EffectivePercentExclusive` (and compound taxes via `Tax1`).
* The real status transition rules and what each `AUTHORISED` write triggers: stock allocation, backorder/short-stock/no-stock decisions, `AUTH_NO_ALLOC` semantics, costing (FIFO/FEFO/special) and `AverageCost`, journals/COGS, payment -> `PAID`, order -> `FULFILLED/CLOSED` auto-transitions, the overall `Status` strings (`ORDERING`, `INVOICE IN PROGRESS`, ...).
* `Split` order logic, drop-ship purchase-order creation, make-to-order production creation, pick recommendations.
* Credit position (`CurrentCredit`, `IsOnCreditHold`, `GracePeriodExceeded`) and `CustomerCreditLimitMode`.
* Price tiers per product (`PriceTear1..10`), deal/discount evaluation, coupons, gift cards, customer discount order of application.
* Exchange rate source and rounding for `/api/GetRate`; period-lock enforcement; permission evaluation (`Full/ReadOnly/None`).
* Search/filter semantics of the list endpoints, the list of filter options (`filter` values live in server-rendered HTML, not in the bundle), sort keys, paging size.
* Carrier/shipping-rate/label provider behaviour (ShipStation, Amazon MCF etc.), Xero/QuickBooks/Avalara sync.
* Email/print template rendering, attachment storage.
* Validation beyond what is echoed in `ValidationText` (field length limits, unique customer reference, etc.): none are enforced in these bundles except the ones listed above.
* `statuses.splitOrder`, `.partialPaid`, `.pconfirmauthorisation` referenced by the client but undefined, so their intended strings are unknown.
