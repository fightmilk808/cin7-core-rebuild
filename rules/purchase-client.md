# Purchase: client-side behaviour of Cin7 Core (static analysis of shipped page scripts)

Source: cached public ExtJS bundles, read statically (never executed, no calls to Cin7).
Readable copies were made with `js-beautify -s 1`; function names below are exact, line numbers
are not quoted because they only exist in the beautified copies.

Bundles and what they are:

| Bundle | Page | Function prefix |
|---|---|---|
| `AdvancedPurchase2019.js` | Advanced purchase (master PO + invoice/receiving children + credit notes) | `PurchaseAdvanced_*`, shared `PurchaseCommon_*`, `CommonPurchase_*`, `Purchase_New*` dialogs |
| `SimplePurchase2019.js` | Simple purchase (one document, tabs Order / Stock received / Invoice / Credit note / Unstock / Manual journals) | `Purchase_*` |
| `PurchaseDropShip2019.js` | Drop-ship purchase (a Simple purchase linked to a sale; no stock tab) | `DropShipPurchase_*` |
| `PurchaseService2019.js` | Service purchase (no product lines, additional-cost lines only; no stock) | `PurchaseService_*` |
| `PurchaseCreditNote2019.js` | Stand-alone purchase credit note (no order, no stock) | `PurchaseCreditNote_*` |
| `PurchaseList2019.js` | Purchase list (General / Accounting views, bulk actions) | `PurchaseList_*` |
| `Supplier2019.js`, `SupplierList2019.js`, `SupplierDeposits2019.js` | Supplier form, list, deposits list | `Supplier_*`, `SupplierDeposits_*` |
| `ReorderSuggestion2019.js`, `ReorderLevelOfStock2019.js`, `ReorderBackorderedStock2019.js` | Reorder pages that create POs | `Reorder_*`, `ReorderBackordered_*` |
| `TenantPaymentTerm2019.js` | Payment terms book | `TenantPaymentTerm_*` |
| `Main2019.js` | Shared maths and helpers (`DEARRound`, `UpdateTaxAndTotalPurchase`, `PurchaseEditCalculator`) | |

Advanced, Simple, DropShip and Service all embed the same shared code (same `CommonPurchase_*`
functions, same totals maths). Where behaviour differs it is called out. Most rules are written for
Advanced because it is the richest; the Simple, drop-ship, service and stand-alone credit-note differences are in section 8.

Everything here is what the **browser** does. The server decides final numbers (document numbers,
PO status roll-up, landed cost, stock cards, journals). Those are in "Not determinable statically".

## ⚠️ Gotchas: the sneaky stuff

> [!CAUTION]
> **Changing supplier silently reprices every line**
>
> Picking a different supplier overwrites SupplierInventoryCode and Price on every order line, invoice line, put-away line and stock card from the new supplier's fixed-cost list, and sets both to null for products that supplier does not list (client script). The supplier discount applies only to new lines. [details](#31-choosing-a-supplier-purchase_supplier_changeevent--_selectevent-vpurchase_supplier-model)

> [!CAUTION]
> **Ticking Blind receipt removes all order lines**
>
> The client deletes every order line and cost line and forces the PO status to NOT AVAILABLE; unticking only restores the previous status and returns to the Order tab. [details](#23-button--tab-enable-matrix-advanced)

> [!CAUTION]
> **A PO file import replaces all order lines, and family bulk-add overwrites existing ones**
>
> Import removes every order line before adding the file's lines. The family matrix bulk-add overwrites Quantity and Price on products already on the order and counts them as skipped. [details](#32-choosing-a-product-on-a-line)

> [!CAUTION]
> **Cell arithmetic is evaluated and bad input becomes 0**
>
> Quantity, Price and Total cells run the typed text through eval (so 12*3 works); NaN or Infinity becomes 0, while an exception keeps the old value. [details](#13-editing-behaviour-in-the-line-grid-vpurchaseorderlinesediting-purchaseeditcalculator)

> [!CAUTION]
> **Voiding a purchase removes deposits with their allocations and voids linked production**
>
> Void deletes inventory, invoice and payment records; when deposits exist the confirm says the deposit(s) with all allocated payments will be removed, and linked production orders or runs are voided too. [details](#24-handlers-endpoints-payloads-confirm-texts-verbatim)

> [!WARNING]
> **Over-receiving against the PO is allowed after a confirm; under-receiving is silent**
>
> In Advanced, receiving more than ordered or a product not on the PO only raises a confirm ("proceed anyway?"), and receiving less raises nothing; only Simple flags it. Authorised-invoice receipts are the hard limit. [details](#4-receiving-rules-advanced-simple-differences-in-section-8)

> [!WARNING]
> **The blank-serial prompt skips FIFO-batch products**
>
> On authorise, a line with an empty BatchSN prompts for server auto-fill only when the method is serial or special. FIBATCH is in neither set, so blank batch numbers on FIFO-batch never prompt. [details](#4-receiving-rules-advanced-simple-differences-in-section-8)

> [!WARNING]
> **An invoice shows PAID only after the next save**
>
> Authorising leaves InvoiceStatus at AUTHORISED until the roll-up on the next save sees a zero balance; an over-payment stays AUTHORISED because no partial-paid document status exists in the client. [details](#9-edge-rules-and-quirks-worth-copying)

> [!WARNING]
> **Payment amounts are barely validated**
>
> A payment amount is only required-field validated, so 0 or more than the amount due is accepted; only deposits enforce greater than zero. The reorder price test is below zero, so a price of 0 passes despite its error text. [details](#52-numeric-limits)

> [!WARNING]
> **The tax calculation method can move a total by a cent**
>
> TaxCalculationMethod Row Total rounds tax per line to 2 dp, while Total keeps 4 dp per line and rounds only the sum; in the worked example the grand total is 102.58 versus 102.59. [details](#18-worked-totals-example-made-up-numbers)

> [!WARNING]
> **A memo reading exactly "Lock PO" locks the purchase order**
>
> The header memo text exactly `Lock PO` makes the order lines and header read-only; it is a hidden convention, not a visible setting. [details](#51-required--format)

> [!NOTE]
> **Some status values exist in the client but are never assigned there**
>
> FULLY RECEIVED and COMPLETED are defined but only used in comparisons, and partialPaid is referenced but undefined, so the server writes the real task Status. The intended meaning of those branches is unknown. [details](#21-status-strings-advancedpurchase2019js-purchasestatuses-statustrackerstatuses)

---

## 1. Calculations

### 1.1 Rounding primitives (Main2019.js)

```
DEARRound(value, places) = sign(value) * Math.round( (abs(value) * 10^places).toFixed(6) ) / 10^places
```
Half rounds away from zero; the `.toFixed(6)` pre-step removes float noise (so 1.005*100 rounds to 101).
`sign(0)` is +1.

| Helper | Meaning |
|---|---|
| `DEARRoundPrice(v)` | `DEARRound(v, 4)` (sales) |
| `DEARRoundPriceForPurchase(v)` | `Xero ? DEARRound(v, 4) : DEARRound(v, 7)` |
| `DEARMoneyFormat(v, extra)` | `extra ? DEARRound(v,4)` first, then `DEARRound(v,2)`, then `toMoney(2)`; null renders `''` |
| `DEARCostFormat(v)` | `toMoney(4)` |
| `window.PurchasePriceDecimals` | 7 normally, 4 when `result.Xero` is true (set in the tenant bootstrap in `Main2019.js`); `PriceDecimals` is always 4 |
| Quantity | always `DEARRound(q, 4)` in purchase code (editor precision 4; not driven by `DecimalPlacesInQuantity`) |
| Discount | Ext Number field, `decimalPrecision: 4`, no min/max, displayed as `"<n>%"` |

### 1.2 Product line (order lines, invoice lines, credit-note lines, stock cards)

`UpdateTaxAndTotalPurchase(record)` (Main2019.js). Used by Advanced, Simple, DropShip, Service, CreditNote:

```
net_unit  = DEARRoundPriceForPurchase( Price * (100 - Discount) / 100 )     // 7 dp (4 dp on Xero)
Total     = DEARRound( Quantity * net_unit , 2 )
Tax       = TaxPercent > 0 ? Total * TaxPercent / 100 : 0
Tax       = DEARRound( Tax , TaxPrecision )
```
`Total` is the line amount **as entered** (net for tax-exclusive documents, gross for tax-inclusive);
`Tax` is the tax inside or on top of it. There is no separate "line gross" field.

`TaxPrecision` (global): `PurchaseReferenceData.TaxCalculationMethod == 'Row Total' ? 2 : 4`
(AdvancedPurchase2019.js `PurchaseTaskWrapperStore` load handler; same in SimplePurchase2019.js).
So tenant setting `TaxCalculationMethod`: `Row Total` rounds tax per line to 2 dp, anything else
(`Total`) keeps 4 dp per line and rounds only the summed tax (1.3).

`TaxPercent` on a line is **not** the rule's headline rate:
```
TaxPercent = TaxInclusive ? rule.EffectivePercentInclusive : rule.EffectivePercentExclusive
```
(`EffectivePercentInclusive` is a server-supplied field of `vTenantTaxationRuleStore`; for a single
10% rule the inclusive figure is the "tax fraction of gross", see 1.8.) Tax is therefore always
`Total * TaxPercent / 100` for both modes; the inclusive maths lives in the rate, not in a separate branch.

Other line helpers (Main2019.js):
- `UpdateTax(record)`: tax only, from the existing `Total` (same formula/rounding, uses `TaxPrecision`).
- `UpdateAdditionalTaxAndTotal(record)`: additional-cost lines, same as above with `Amount` in place of `Price`:
  `Total = DEARRound( Quantity * DEARRoundPriceForPurchase(Amount * (100-Discount)/100), 2 )`,
  `Tax = DEARRound( Total*TaxPercent/100, TaxPrecision )`.
- `UpdateTaxAndTotal(record)` (sales variant, `DEARRoundPrice` = 4 dp) is used for credit-note *select* rows
  (`CreditNoteLineSelect`) and when summing duplicate credit-note lines in `PurchaseAdvanced_CreditNote_CopyLinesFromInvoice`.

### 1.3 Editing behaviour in the line grid (`vPurchaseOrderLinesEditing`, `PurchaseEditCalculator`)

- Quantity, Price and Total cells are **text** editors that accept arithmetic. `PurchaseEditCalculator`
  (`validateedit`) does `Number(eval(text))` then rounds: Quantity/OrderQuantity/Amount to 4 dp,
  Price to `PurchasePriceDecimals`, Total to 2. `NaN` or `Infinity` becomes 0; an exception keeps the old value.
  The result is stashed in `window.calculatedValue` and written back in the `edit` handler.
- Edit Price, Quantity, Discount or Tax rule (value changed) -> `UpdateTaxAndTotalPurchase` then totals refresh.
- Edit **Total** (value changed, `Quantity != 0`, `Discount != 100`):
  `Price = DEARRound( Total / Quantity * 100 / (100 - Discount), PurchasePriceDecimals )`, then `UpdateTax` only
  (Total stays as typed; Tax = Total * TaxPercent/100). If Quantity is 0 or Discount is 100 the price is not
  recomputed and tax is not refreshed.
- Total column is not editable when `Xero` is true (`beforeedit` and `PurchaseAdvanced_Order_IsLinesFieldEditable`).
- Tax rule edit: rule not found -> `TaxRule = null`, `TaxPercent = 0`; otherwise `TaxPercent` per 1.2.
- Price cell renderer: values in (0, 0.0001) are printed as `"0.000000" + (val*10000000)` (cosmetic quirk).

### 1.4 Document totals box (order tab) - `PurchaseAdvanced_Order_UpdateTotals`

Lines (`vPurchaseOrderLinesStore`):
```
Amount = SUM(line.Total) ; Tax = DEARRound( SUM(line.Tax), 2 ) ; Qty = SUM(line.Quantity)  (shown DEARRound(Qty,4))
if TaxInclusive:  Amount = Amount - Tax                 // Amount becomes the ex-tax goods value
LinesGoodsTotal = Amount ; LinesTaxTotal = Tax ; LinesTotal = Amount + Tax
```
Additional costs (`vPurchaseOrderCostLinesStore`) - same but `Tax` rounded to 2 dp **and** `Amount = DEARRound(Amount, 2)` after the inclusive subtraction:
```
AddGoods = Amount ; AddTax = Tax ; AddTotal = Amount + Tax
```
Grand totals:
```
GrandGoods = LinesGoodsTotal + AddGoods
GrandTax   = LinesTaxTotal   + AddTax
TotalSupplierCurrency = LinesTotal + AddTotal
```
Foreign currency: `TotalTenantCurrency = DEARRound( TotalSupplierCurrency * rate , 2 )` where `rate` is the header
field `txtPurchase_Index_CurrencyConversionRate` (tenant units per 1 supplier unit; ExtJS field: 5 dp, min 0.00001, default 1).
The tenant-currency total block shows only when `tenantCurrency != supplierCurrency` and both are non-empty.

Payments/deposits on the order tab (all tasks' `vPurchasePaymentLinesStore` rows with `PaymentType === 'P'`):
```
paid_supplier = SUM(Amount)           paid_tenant = SUM( DEARRound(Amount * CurrencyConversionRate, 2) )
Balance       = DEARRound( -LinesTotal - AddTotal + paid_supplier , 2 )
BalanceTenant = DEARRound( -TotalTenantCurrency + paid_tenant , 2 )
```
Balance label: same currency or no supplier currency -> `Balance due` (empty supplier currency) /
`Balance credited (CUR)` when Balance > 0 else `Balance due (CUR)`. Foreign currency adds a tenant header: `Realized (CUR)` when
`Balance == 0`, `Balance credited (CUR)` when `BalanceTenant > 0`, else `Balance due (CUR)`. The number shown is
`abs(Balance)`; `BalanceTenant` is sign-flipped only when `Balance != 0`. Caption on the grand total is `(SUP)` or `TOTAL`.
Users without price access (`HasPriceInfoAccess` false) see `No access` in every total cell and cannot edit any price/total cell.

### 1.5 Invoice totals and payment status

`PurchaseAdvanced_Invoice_GetTotal` (also `PurchaseAdvanced_Invoice_UpdateTotals`, `PurchaseAdvanced_Invoice_CheckForDeposits`):
```
LinesTotal = (SUM(Total) - (TI ? DEARRound(SUM(Tax),2) : 0)) + DEARRound(SUM(Tax),2)
AddTotal   = same on invoice additional-cost lines (Amount rounded 2 dp)
invoiceTotal = DEARRound(LinesTotal + AddTotal, 2).toFixed(2)
```
`PurchaseAdvanced_NewPayment_GetInvoiceDue` uses a slightly different order (no rounding of Total before the
TI branch): `DEARRound(SUM(Total),2)`, `DEARRound(SUM(Tax),2)`, `TI ? Amount : Amount + Tax`, minus SUM of payment lines
where `PaymentType === 'R' && Type === 'ACCPAY'`, rounded to 2 dp. Credit notes: `Type === 'ACCPAYCREDIT'`.
Payment "Base amount" column = `DEARMoneyFormat(Amount * CurrencyConversionRate, true)`.

Invoice status roll-up on save, `StatusTracker.invoice.updateStatus` (called from `StatusTracker.updateStatuses`
in `PurchaseAdvanced_Index_Submit_Internal`): for each task that can have an invoice and is `AUTHORISED` or `PAID`:
```
InvoiceBalance = DEARRound( InvoiceLinesTotal + InvoiceAdditionalCostLinesTotal - SUM(payments with PaymentType 'R') , 2 )
InvoiceStatus  = (InvoiceBalance === 0) ? 'PAID' : 'AUTHORISED'
```
Notes: payments are summed in supplier currency (no base conversion); an over-payment (balance < 0) stays AUTHORISED
(no "partially paid" document status exists in the client, `StatusTracker.statuses.partialPaid` is referenced but undefined).
`StatusTracker.calculateBalanceDue`: `balanceDue = DEARRound(InvoiceBalance - CreditNoteBalance, 2)` using the same sums
(credit-note payments summed with no PaymentType filter in Simple; `'R'` filter only on the invoice side).

Invoice total entry check (`PurchaseAdvanced_Invoice_IsTotalsMatch`): the user-typed `txtPurchase_Invoice_Total`
must `!=`-equal the computed string `invoiceTotal`; if the typed value is exactly `0` it is auto-filled from the lines.
Mismatch -> error `Invoice total does not match with invoice lines and additional cost lines totals.`

### 1.6 Currency / exchange rate

- Rate meaning: `CurrencyConversionRate` = tenant-currency units per 1 supplier-currency unit (label
  `"{TENANT} units per {SUPPLIER}"`, `PurchaseAdvanced_Index_UpdateRateConversionLabel`).
- Same currency: rate forced to 1 and the rate control disabled (`StatusTracker.header.applyCurrencyConversionRateState`).
- Fetch: `GET /api/GetRate?From=<supplierCur>&To=<tenantCur>&Date=<yyyy-mm-dd>` returns a bare number
  (`PurchaseAdvanced_Index_GetConversionRate`). Failure: warning
  `Failed to acquire currency exchange rate. Please provide the rate manually.` plus the server error.
- When the rate is (re)fetched: choosing a supplier whose currency differs from the previous supplier's; the "Get rate" button;
  an invoice date change on a non-authorised invoice (`dtPurchase_Invoice_Date` change handler, not while the invoice is loading);
  credit-note and payment dialogs fetch for their own dates.
- New invoice/credit-note child tasks copy `SupplierCurrency`, `Currency` and `CurrencyConversionRate` from the master task
  (`PurchaseAdvanced_PurchaseTask_Create`) - the invoice keeps its **own** rate afterwards (`txtPurchase_Index_InvoiceCurrencyConversionRate`),
  editable only while the invoice is not authorised.
- Payment dialog (`PurchaseAdvanced_NewPayment_*`): amount defaults to the invoice due, rate defaults to the invoice rate,
  "Amount in {tenant} will be: DEARMoneyFormat(Amount * Rate)". The rate row is hidden when `SupplierCurrency == '' || == Currency`.
  Choosing a bank account in another currency (when document currency == tenant currency) fetches `base/bank` rate and shows the rate row.
- Deposits: rate row visible when `supplierCurrency != tenantCurrency || bankCurrency != supplierCurrency`; rate defaults to the task rate;
  base preview shown only if `Amount > 0 && rate != 1 && rate != 0` as `DEARMoneyFormat(DEARRound(Amount*rate,2))`.
  Bank accounts offered: those whose currency equals the supplier currency or the tenant currency (and `Type === 'BANK'` when Xero).

### 1.7 Credit-note totals
`PurchaseAdvanced_CreditNote_UpdateTotals` mirrors 1.4 (lines + additional lines, `TI` subtraction, tenant conversion, balance from
credit-note payment lines `Type === 'ACCPAYCREDIT'`). Same worked example applies with credit-note lines.

### 1.8 Worked totals example (made-up numbers)

Header: tax-exclusive, tax rule "VAT 10%" (`EffectivePercentExclusive` = 10), supplier discount 10%, non-Xero (7 dp prices).

| # | Qty | Price | Disc | net_unit (7 dp) | Total = round(Qty*net_unit, 2) | Tax (10%) unrounded | Tax `Row Total` (2 dp) | Tax `Total` method (4 dp) |
|---|---|---|---|---|---|---|---|---|
| A | 3 | 12.3456 | 10% | 11.11104 | 33.33 | 3.333 | 3.33 | 3.3330 |
| B | 7 | 4.99 | 0% | 4.99 | 34.93 | 3.493 | 3.49 | 3.4930 |

Additional cost line: freight, Qty 1, Amount 25.00, Disc 0, tax 10% -> Total 25.00, Tax 2.50.

| | `TaxCalculationMethod = 'Total'` (TaxPrecision 4) | `'Row Total'` (TaxPrecision 2) |
|---|---|---|
| Lines Amount (sum Total) | 68.26 | 68.26 |
| Lines Tax: `DEARRound(sum,2)` | round(6.826,2) = **6.83** | round(3.33+3.49=6.82,2) = **6.82** |
| LinesTotal | 75.09 | 75.08 |
| Additional goods / tax / total | 25.00 / 2.50 / 27.50 | 25.00 / 2.50 / 27.50 |
| Grand goods / tax / total | 93.26 / 9.33 / **102.59** | 93.26 / 9.32 / **102.58** |

Foreign currency (supplier USD, tenant AUD, rate 1.52): `TotalTenantCurrency = DEARRound(102.59*1.52, 2) = 155.94`
(155.9368). Deposit paid 50.00 USD at rate 1.50: `paid_tenant = DEARRound(50*1.50,2)=75.00`;
`Balance = DEARRound(-75.09-27.50+50.00,2) = -52.59` -> header `Balance due (USD)`, value `52.59`;
`BalanceTenant = DEARRound(-155.94+75.00,2) = -80.94` -> `Balance due (AUD)` `80.94`.

Tax-inclusive variant (header `TaxInclusive = true`, rule 10%, server `EffectivePercentInclusive` = 100*10/110 = 9.0909..%):
one line Qty 2, Price 55.00 -> `Total = 110.00` (gross), `Tax = 110.00 * 9.0909.../100 = 10.00`.
Totals: Amount 110.00, Tax 10.00 -> `Amount -= Tax` -> Goods 100.00, Tax 10.00, LinesTotal 110.00.
Flipping the header inclusive checkbox re-derives every line's `TaxPercent` from its own tax rule and re-runs
`UpdateTaxAndTotalPurchase` on order, invoice and credit-note lines (and additional-cost lines via `UpdateAdditionalTaxAndTotal`)
- `PurchaseAdvanced_Index_UpdateTaxInclusive` - Prices are NOT converted; only the tax split changes.

---

## 2. Status model

### 2.1 Status strings (AdvancedPurchase2019.js `PurchaseStatuses`, `StatusTracker.statuses`)

Per-document statuses: `NOT AVAILABLE`, `DRAFT`, `AUTHORISED`, `PAID` (invoice only), `PARTIALLY RECEIVED` (stock), `VOIDED`.
Additional values only on `PurchaseOrderStatus`: `RECEIVED`, `CLOSED`. Defined but never assigned in the client:
`FULLY RECEIVED`, `COMPLETED` (used in comparisons only; server writes them to task `Status`).

Master task `PurchaseOrderStatus`: on a new task `NOT AVAILABLE`. `StatusTracker.purchaseOrder.updateStatus` (run on every save, only if
`!IsReadOnly && !isCancelled && OrderViewPermission=='Full'` and the order is not yet "completed"):
`DRAFT` if there is >=1 order line or order cost line, else `NOT AVAILABLE`.
`StatusTracker.purchaseOrder.IsCompleted()` = status not in (`DRAFT`,`NOT AVAILABLE`) and not cancelled.
`PurchaseCommon_isPOAuthorized` = `AUTHORISED | RECEIVED | CLOSED`. `PurchaseCommon_isPOCompleted` adds "or blind receipt".

Task `Status` label map (`window.PurchaseStatuses`; server sets the value, client only labels it; also used by the list):

| `Status` | Label | Style |
|---|---|---|
| `AWAITING APPROVAL` | Awaiting approval | default |
| `DRAFT` | Draft | draft |
| `NEW` | New | draft |
| `ORDERED` / `PO COMPLETED` | Ordered | authorised |
| `ORDERING` / `PO IN PROGRESS` | Ordering | authorised |
| `PARTIALLY RECEIVED` | Receiving | authorised |
| `PARTIALLY RECEIVED / CREDITED` | Receiving / credited | authorised |
| `FULLY RECEIVED` | Received | authorised |
| `FULLY RECEIVED / CREDITED` | Received / credited | authorised |
| `PARTIALLY INVOICED` | Partially billed | authorised |
| `PARTIALLY INVOICED / CREDITED` | Partially billed / credited | authorised |
| `INVOICED` | Fully billed | authorised |
| `INVOICED / CREDITED` | Billed / credited | authorised |
| `INVOICE COMPLETED` | Billed | authorised |
| `PARTIALLY REFUNDED` | Refunding | authorised |
| `CREDITED` / `COMPLETED / CREDIT NOTE` | Credited | authorised |
| `COMPLETED` / `COMPLETED / CREDIT NOTE CLOSED` | Completed | completed |
| `VOIDED` | Voided | voided |

Order tab ribbon (`PurchaseAdvanced_Order_UpdateControlState`): `DRAFT` -> "Draft"; authorised -> "Authorized" /
"Received" (`RECEIVED`) / "Closed" (`CLOSED`); otherwise "New". Invoice ribbon: Draft / Authorized / Paid / New.
Stock ribbon: Authorized when `StockStatus` AUTHORISED (and, with put-away, `IntermediateStockStatus` AUTHORISED);
Draft when any of those is DRAFT or the invoice is authorised/paid with `StockStatus` DRAFT; else New.
Credit-note ribbon: Draft / Authorized / New.

### 2.2 List badges (PurchaseList2019.js)

Order-status icon (`gridColumnStatusRender.renderOrderStatus`): `OrderApprove===1` -> "Purchase order rejected." (red); `IsArchived` ->
"Purchase order archived." (red); numeric `PurchaseOrderStatus` 0 -> "Purchase order not available." (grey) or, when `Status==='AWAITING APPROVAL' && TaskTypeSign===999`,
"Purchase order is waiting for approval." (orange); 1 -> "Purchase order in progress." (orange); 2 -> "Purchase order authorized." (green).

Text mappers:
- Invoice status (`PurchaseList_Index_InvoicingStatus`, field `BillStatus`): NOT AVAILABLE "Not available"; PARTIALLY INVOICED / CREDITED "Partially billed / credited";
  PARTIALLY INVOICED "Partially billed"; INVOICED / CREDITED "Billed / credited"; NOT INVOICED "Not billed"; INVOICED "Fully billed"; COMPLETED "Completed";
  PARTIALLY REFUNDED "Refunding"; CREDITED "Credited"; DRAFT "Draft"; AWAITING APPROVAL "Awaiting approval".
- Stock status (`StockStatus`): NOT AVAILABLE "Not available"; PARTIALLY RECEIVED "Partially received"; NOT RECEIVED "Not received"; RECEIVED/FULLY RECEIVED "Received".
- Payment status (`PaymentStatus`): PREPAID "Prepaid"; UNPAID "Unpaid"; PARTIALLY PAID "Partially paid"; OVERPAID "Overpaid"; OVERPAID / CREDITED "Overpaid / credited";
  PAID "Paid"; PARTIALLY REFUNDED "Partially refunded"; NOT REFUNDED "Not refunded"; REFUNDED "Refunded"; NOT AVAILABLE "Not available".
  The grey/colour rule: `UNPAID` while bill status is `NOT AVAILABLE`/`NOT INVOICED` is drawn grey.
- Accounting view (`PurchaseList_Accounting_RenderStatus`): `VOIDED` -> "Voided"; `AUTHORISED|PAID` with `Due == 0` -> "Paid" (or "Refunded" for `Type === 2` credit notes) else "Authorized"; any other value -> "Draft".
  Overdue (`DaysOverdue > 0`) turns the text red; `Due date` and `Overdue by` columns only render for `Type == 1` (invoices).
- General columns: Order #, Order date, Supplier, Type (`TaskTypeName`), Document # (`DocNumbers`), Required by, Total (`POTotalAmount`), Invoice status, Stock status, Payment status, Order sent (`OrderSendStatus`), custom fields 1-10, Location.
  Accounting columns: Order #, Document, Status, From, Contact, Phone, Order date, Date, Due date, Terms, Overdue by, Total, Paid, Credited, Due, custom fields, Location.
- Row click path (`PurchaseList_Index_GetDetailsPath`): `/<TaskTypeName>#id` if named; else `TaskTypeSign===0` -> `/DropShipPurchase#id` when `DropShipTaskID` else `/Purchase#id`; else `/PurchaseAdvanced#id`.

### 2.3 Button / tab enable matrix (Advanced)

`P` = permission gate in parentheses; `RO` = `IsReadOnly` (access level read-only or tenant subscription `On Hold`); `CX` = task voided (`StatusTracker.isCancelled`, i.e. task `Status == 'VOIDED'`).

**Header** (`StatusTracker.header.applyState`): `headerDisabled = CX || PO completed || any AUTHORISED/PAID invoice child || RO || isRejected()`.
- Supplier combo disabled when `headerDisabled || supplier has deposits (StatusTracker.header.supplierDeposited) || hasActiveChild()` (any non-voided invoice/credit-note child exists).
- Order date, Location, Blind receipt (also read-only when order memo text is exactly `Lock PO`), Default account (also when `JobID` set): disabled when `headerDisabled`.
- Terms: disabled only when `CX || RO` (still editable after authorisation).
- Tax rule combo: disabled when `BillCreditNoteViewPermission != 'Full' || CX || RO`.
- Currency rate: disabled when same currency, or `RO || CX || headerDisabled`.
- `isRejected()` = order-approval enabled (`IsOrderApproveEnabled`) and `OrderApprove === 1` and not `SkipQuote`.

**Order tab** (`StatusTracker.purchaseOrder.setDisabled(disabled)`, called with `disabled = PurchaseCommon_isPOAuthorized(status)`):
- `readOnly = RO || CX || disabled || memo=='Lock PO' || OrderViewPermission != 'Full' || isRejected()`
- `readOnlyTaxAccounts = RO || CX || memo=='Lock PO' || OrderViewPermission != 'Full'`
- `allowChangeAuthorized = !(RO||CX) && EditAuthorizedDocumentsPermission === 'Full'`
- Authorise button: `!disabled && !RO && !CX && memo!='Lock PO' && OrderAuthorisationPermission=='Full'`
- New line / Scan / Import / Verify: `!readOnly`. Bulk add by family: `!readOnly && ProductFamilyCount > 0`.
- New additional-cost line (and its delete column): `(!readOnly || allowChangeAuthorized) && !isRejected()`.
- Line delete column: `!readOnly`. Memo editable if `!readOnly || allowChangeAuthorized`.
- Cell editing (`beforeedit`): needs `HasPriceInfoAccess`, not rejected; tax rule column blocked by `readOnlyTaxAccounts`; every other column blocked by `readOnly && !allowChangeAuthorized`; Total blocked on Xero.
  After authorisation a user with `EditAuthorizedDocumentsPermission=='Full'` can therefore still edit lines of an authorised PO.
- "Prepayment/deposit" block visible once a supplier is assigned and PO is authorised (`OrderPrepaymentBlock`). New payment/deposit button: `!(RO || CX || OrderViewPermission!='Full' || isRejected())` (`StatusTracker.deposits.setDisabled(false)`), delete column same.
- Archive button (`setArchiveButtonVisible`): only when `IsArchiveEnabled`, task saved, tab = Order, PO not completed, not already archived. Approve/Reject/Review buttons (`setApproveButtonsVisible`): only when `IsOrderApproveEnabled`, tab = Order, PO completed, no authorised invoice/stock yet; `OrderApprove` 0 -> Approve + Reject, 1 (rejected) -> Review, 2 -> neither.
- Opening the Order tab on an empty, editable, non-blind order auto-adds **three** empty lines (`PurchaseAdvanced_Order_OnOpen`); blank lines (no product, price 0, qty 0, tax 0, total 0) are stripped on save (`PurchaseAdvanced_Order_PrepareForSave`) and `LineOrder` renumbered 1..n for lines and cost lines.
- Order tab itself disabled when `!purchaseOrder.isVisible || CX`; `isVisible` false for blind receipts or `OrderViewPermission == 'None'`. Ticking Blind receipt: PO status forced `NOT AVAILABLE`, active tab cleared, **all order lines and cost lines removed** (`PurchaseAdvanced_Index_BlindReceiptChanged`); unticking restores the previous status and returns to the Order tab.

**Main toolbar** (`PurchaseAdvanced_Index_AdjustMainToolbarActions`):
- Save: `!RO && !CX`. Print and Email: `!RO && !CX && (PO completed || blind receipt)`.
- Void (whole PO, menu item `itmVoidWholePurchase1`): `VoidPermission=='Full' && !RO && !CX && saved`.
- Undo (`itmUndoWholePurchase1`): `UndoPermission=='Full' && !RO && !CX && saved`.
- Clone: hidden for drop-ship; "Save as clone" unavailable for an unsaved task: warning `You cannot clone an unsaved task. Save it first.`
- Mark as received (`ExclusiveOrderStatusBlock1/2`): `OrderAuthorisationPermission=='Full' && !dropship && !RO && CanMarkAsReceived()`.
- Mark as closed (`ExclusiveOrderStatusBlock3`): `OrderAuthorisationPermission=='Full' && !RO && CanMarkAsClosed()`.
- `PurchaseAdvanced_Index_CanMaskAsReceived`: false if blind receipt, or PO status in (`VOIDED`,`RECEIVED`,`NOT AVAILABLE`,`DRAFT`); also false if any non-voided invoice+receiving child has
  (invoice not AUTHORISED/PAID and task status FULLY/PARTIALLY RECEIVED) or (invoice AUTHORISED/PAID and `StockStatus != AUTHORISED`).
- `PurchaseAdvanced_Index_CanMarkAsClosed`: false if blind receipt; PO status in (`VOIDED`,`CLOSED`,`NOT AVAILABLE`,`DRAFT`) or task Status `COMPLETED`.
  Non-dropship additionally requires: every virtual stock task `AUTHORISED`; at least one invoice-capable task whose `StockStatus` is `AUTHORISED` or `PARTIALLY RECEIVED`; no non-master invoice-capable task whose stock is not (`AUTHORISED`|`VOIDED`).
  All invoice-capable tasks (except a master whose invoice is `NOT AVAILABLE`) must have invoice `PAID|AUTHORISED|VOIDED`.

**Invoice tab** (`PurchaseAdvanced_Invoice_OnOpen`, `StatusTracker.invoice.*`):
- Add invoice (+): only if PO is completed (`PurchaseCommon_isPOCompleted`) and master saved (TaskID not empty) - otherwise silently returns. New child: `TaskTypeSign=2`, `InvoiceStatus=DRAFT`, `InvoiceDate=today`,
  `InvoicingAndReceivingNumber = max(existing)+1`, copies header fields, supplier, currency, rate, terms, tax settings from master.
  Tab enabled only if `PurchaseCommon_isPOAuthorized(PurchaseOrderStatus)` (`StatusTracker.invoice.isDisabled`) or blind receipt.
- Authorise button: `!RO && !CX && BillCreditNoteAuthorisationPermission=='Full' && InvoiceStatus not AUTHORISED/PAID`.
- Undo invoice (`divUndo_Invoice`): `!RO && !Xero && !CX && BillCreditNoteAuthorisationPermission=='Full' && InvoiceStatus === 'AUTHORISED'` (not offered once PAID).
- Lines read-only once AUTHORISED/PAID (`setLinesDisabled(true)`) unless `allowChangeAuthorized` (`EditAuthorizedDocumentsPermission=='Full'`); additional-cost buttons also hidden when `StatusTracker.invoice.IsLocked()` (authorised/paid and invoice date before `TenantLockDate`).
- Payments (`setPaymentsDisabled`): editable only when invoice AUTHORISED/PAID. Buttons "New payment" and "Allocate deposit" need `!readOnlyPayments`. Settle/Airwallex pay buttons need an integration sync record and balance < 0; disabled when an external payment already exists.
  Adding a payment line while the invoice is not authorised/paid -> warning `You need to authorize the invoice before registering payments.`
- Copy from PO: visible when not authorised/paid, not blind receipt, `!RO && !CX`. Copy from receiving: same plus `PurchaseAdvanced_HasAnyReceivedLines()`.
- Distribute expenses block visible when task `HasDistributeExpense`.
- Manual journals tab: editable only when invoice AUTHORISED/PAID (`StatusTracker.manualJournals.setDisabled(false)`), otherwise disabled.
- Due date control disabled only on `RO`; invoice number/date disabled when lines read-only and not `allowChangeAuthorized`.

**Receiving tab** (`StatusTracker.stock.setDisabled(disabled)`, `PurchaseAdvanced_StockReceived_OnOpen`):
- `hasPermission = !RO && !CX && StockReceivedAuthorisationPermission=='Full'`; Authorise visible `!disabled && hasPermission`; `readOnly = !hasPermission || disabled`.
- Copy-from-PO visible: `!readOnly && !UsePurchasePutAway && invoice not AUTHORISED/PAID && !blind receipt`. Copy-from-invoice/receiving, Scan, Import: `!readOnly`.
- `canAddNewLines` = `!RO && !CX && !StockReceivedViewPermission !== 'Full'` (the original expression is the always-true `!x !== 'Full'`, so the New-line button is visible whenever the doc is writable).
- Existing authorised receiving lines (with `CardDetailsID`) in a read-only receiving: only Quantity and Supplier SKU editable, and only if `EditAuthorizedDocumentsPermission=='Full'`;
  Expiry date editable too for `FESN`/`FEBATCH` while the invoice has no completed receiving (`StatusTracker.stock.hasCompletedReceiving()`).
- Put-away mode (`UsePurchasePutAway` true): two sub-tabs "Stock received" (intermediate, `IntermediateStockStatus`) then "Put away" (`StockStatus`); the Put-away stage is disabled until the intermediate stage is AUTHORISED.
  Without put-away the intermediate tab is disabled and the tab title is "Stock receiving" with "Copy from invoice".
- Receiving tab disabled only when `CX`; dropship purchases cannot open it (`PurchaseAdvanced_SetActiveTab` returns early).

**Credit note tab** (`PurchaseAdvanced_CreditNote_OnOpen`, `StatusTracker.creditNote.*`):
- Authorise: `!RO && !CX && BillCreditNoteAuthorisationPermission=='Full' && CreditNoteStatus not AUTHORISED/VOIDED && CreditNoteInnerStatus != AUTHORISED`.
- When not authorised: payments (refunds) disabled, lines enabled; authorised: lines disabled, payments enabled. Refund block visible only when Authorise is not visible.
- New refund buttons `!RO`; adding a refund before authorisation: warning `You need to authorize the credit note before registering refunds.`
- Credit note number and date editable only while authorisable (or `allowChangeAuthorized`). Invoice selector (`cmbCreditNoteSelectInvoice`) disabled when lines are read-only.
- Unstock tab: Authorise-unstock and Copy buttons visible when `!RO && !CX && BillCreditNoteAuthorisationPermission=='Full' && UnstockStatus != AUTHORISED && CreditNoteStatus != VOIDED`.

### 2.4 Handlers: endpoints, payloads, confirm texts (verbatim)

**Save / authorise (all steps)**: `PurchaseAdvanced_Index_Submit` -> `ValidateInvoiceNumber` -> accounting-dimensions check -> `PurchaseAdvanced_Index_Submit_Internal`:
- Guard: ignores re-entrant clicks (`SavingProcessing`); if `IsReadOnly` or `!ArePendingChanges()` no request is sent (planned operation runs directly).
- `POST /api/PurchaseAdvanced_Index_vPurchaseTask` (new, `ID` empty guid) or `PUT /api/PurchaseAdvanced_Index_vPurchaseTask/{ID}`; body
  `{ ID, HasErrors:false, Lang, ClientDateTime, Original:[task records], Updated:[task records], QuickBooksSyncedInvoices, XeroSyncedInvoices, PurchaseExternalPayments, IsAirwallexEnabled }`.
  Timeout 7 200 000 ms. Before sending: deposit store saved if dirty, `StatusTracker.updateStatuses()`, line numbering, `PurchaseAdvanced_StockReceived_PrepareToSave`,
  `PurchaseAdvanced_Invoice_AccountChangedValidation`.
- Response reloads the whole wrapper. New task: URL hash set to the new `TaskID`. If previously-made payments were already synced to Xero:
  warning (no auto-hide, 30 s) `The payments which were made previously have already been synced to Xero. Therefore please remove the payments / refunds in target invoice / credit note manually.`
- Failure: error toast with server message and the task reloaded.

**Authorise PO** (`PurchaseAdvanced_Order_Complete`): needs `OrderAuthorisationPermission=='Full'` else warning `You do not have permission to authorize purchase orders.`
Empty order (no lines and no cost lines, not blind) -> warning `Your purchase order is empty. You cannot authorize an empty order. If you don't need it, use the blind receipt option.`
Else sets `PurchaseOrderStatus = AUTHORISED` and saves. The authorise click also runs required-field highlighting first.

**Authorise invoice** (`PurchaseAdvanced_Invoice_Complete` -> `_CompleteAction`) in order:
1. `Please specify the invoice number.` (SupplierReference), `Please specify the invoice date.`, `Please specify the invoice due date.` (errors, stop).
2. Permission: warning `You do not have permission to authorize bills.`; empty invoice (no lines and no cost lines): warning `Your invoice is empty. You cannot authorize an empty invoice.`
3. If blind receipt, or the task `Status` is already `PARTIALLY RECEIVED`/`FULLY RECEIVED`, the order-match check is skipped; otherwise `CommonPurchase_CheckIfMatchesTheOrder(order lines, invoice lines, ..., 'invoice')` runs as a soft check (5.4). Then, if this child's `StockStatus` is `AUTHORISED`,
   `/api/Purchase_Index_CoManCheck/CanBeCompleted` runs first (see section 4); otherwise it proceeds directly.
4. `IsTotalsMatch` (1.5).
5. Per-line validation: on a non-LIABILITY account, a tax rule with `Tax1 == 'GSTONIMPORTS'` is invalid: line text `GST/sales tax on import can only be used with a liability account.`, toast `Invalid use of GST/sales tax on import tax rule. Please see the errors in lines.`
6. Non-asset account on any product line (class != `ASSET`, ignored for drop-ship): confirm `You are using a non-asset account in your invoice lines. In this case, the product with a liability/expense account will be written off from inventory now. Would you like to proceed?`
   and for additional-cost lines on an ASSET account (type != `FIXED`) whose account is not among the product-line accounts: warning
   `An incorrect asset account has been used in the additional charges section. In order to allocate additional cost correctly, an account must be from the range used in the invoice lines for products.`
7. Put-away / stock quantity guard: received/put-away per product may not exceed invoiced -> `PurchaseAdvanced_ValidateQtys` sets each offending line `Invalid` with
   `Product "CODE: Name" has the quantity invoiced (X) which is different from the quantity received (Y).` and toast `Products received quantities are more than invoiced quantities. Please see the errors in details.`
8. Sets `InvoiceStatus = AUTHORISED`, `Approach = 'Stock'` if stock already AUTHORISED/PARTIALLY RECEIVED else `'Invoice'`; if invoiced == put-away for every product `StockStatus = AUTHORISED`,
   else if any put-away exists `PARTIALLY RECEIVED`. `PlannedOperation = 'Invoice:Authorise'`, save. After the save `PurchaseAdvanced_Invoice_CheckForDeposits` offers deposit allocation (below).
Duplicate supplier invoice number (`ValidateInvoiceNumber`, runs on every save of a changed number): within the document duplicates, or `POST /api/Purchase_Invoice_CheckForName` (`SupplierID`, `InvoiceNumbers`) ->
confirm `Another invoice from the same supplier is associated with invoice number/s {n1,n2}. Do you want to continue?`; declining reverts invoice/stock status to the original values.

**Deposit allocation prompt** (after invoice authorise, `PurchaseAdvanced_Invoice_CheckForDeposits`): if `Balance !== 0` (Balance = -InvoiceTotal + sum of R/ACCPAY payments) and either an existing deposit row has
`RemainingAmount > 0` or `GET /api/Purchase_Invoice_CheckForDeposits?SupplierID=` returns the text `true`: confirm title `Use supplier deposit`, text
`The supplier has an unused deposit for this purchase. Do you want to allocate it?`.

**Void whole PO** (`PurchaseAdvanced_Index_Cancel`): unsaved -> warning `You cannot void an unsaved task. Just close this page if you don't want to save it.`
Confirm title `Confirmation`, text `This will drop your current changes and delete the inventory, invoice and payment records!` + (production-order note) + `Would you like to proceed anyway?`.
If the task has deposits: first `POST /Purchase/DepositValidate {TaskID}`; success (HTTP ok) -> the confirm above and `removeAllocations=false`; failure -> warning `Deposit deletion warning` (5 s, server text) and confirm
`Deposit(s) with all allocated payments will be removed.` + note + `Do you want to proceed?` with `removeAllocations=true`. Then `POST /PurchaseAdvanced/Cancel {TaskID, removeAllocations}` (7 200 s timeout);
non-empty response text = error toast, else the task reloads (it becomes `VOIDED`). Production-order note (`/api/Purchase_Index_CoManCheck/HasProduction`): `Production orders: <links> will be voided!` / on a run
`Production runs: <links> will be voided!`.

**Undo whole PO** (`PurchaseAdvanced_Index_Undo`): unsaved -> `You cannot undo an unsaved task.` Confirm `This will change the task status back to draft. You will need to authorize each step to confirm your changes! ...Would you like to proceed anyway?`
(deposit failure variant: `This will change the task status back to draft.<note>Deposit(s) with all allocated payments will be removed. Do you want to proceed?`).
`POST /PurchaseAdvanced/Undo {TaskID, removeAllocations}`; empty response -> success toast `Undo operation completed successfully.`; text containing `-error` -> error; other text -> warning. Then reload, open Order tab (or none if the user may not view orders).

**Void / undo a child** (`PurchaseAdvanced_Index_CancelChild` / `_UndoChild`): permission errors `You do not have permission to void.` / `You do not have permission to undo.`; unsaved -> `You cannot void it. Reload the purchase to discard any changes.` / `You cannot undo an unsaved task.`;
invoice with an authorised linked credit note (`StatusTracker.creditNote.canUndoVoidInvoice`: matches the credit note's `SupplierReference` to the invoice's, case-insensitive) -> `You cannot void an invoice while you have an authorized linked credit note.` / `You cannot undo an invoice while you have an authorized linked credit note.`
Texts: void invoice+receiving `All unsaved changes will be lost. This will discard your changes and void invoicing and receiving #{n}: pick, pack and ship records! ...Would you like to proceed anyway?`, success `The void operation for invoicing and receiving #{n} completed successfully.`;
void credit note `All unsaved changes will be lost. This will discard your changes and void credit note #{n}. Would you like to proceed?` / success `The void operation for credit note #{n} completed successfully.`;
undo invoice `All unsaved changes will be lost. This will revert invoicing and receiving #{n} status back to draft. ...Would you like to proceed?`, success `Undo operation for invoicing and receiving #{n} completed successfully.`;
undo credit note `...This will revert credit note #{n} status back to draft. Would you like to proceed?`, success `Undo operation for credit note #{n} completed successfully.`
Endpoints: `POST /PurchaseAdvanced/CancelChild` and `/PurchaseAdvanced/UndoChild`, params `{TaskID, TaskTypeSign}` (2 = invoice+receiving, 3 = credit note); undo timeout 180 s. A 404 removes the row locally (`PurchaseAdvanced_Index_DeleteChildForce`).
If the invoice has allocated payments: `This will void invoice #{SupplierReference}. All allocated payments will be removed.` (void) / `This will revert the invoice #{SupplierReference} status back to draft. All allocated payments will be removed.` (undo); pending changes add `<br/>Note: All allocated payments will be removed.`

**Mark received / closed**: `PurchaseAdvanced_Index_MarkAsReceived`: not allowed -> error `You cannot mark a purchase as received while uncompleted receivings remain. Please complete or void the uncompleted receivings.`; confirm `Purchase will be marked as received. Click 'Yes' to proceed.`
-> every non-voided task's `PurchaseOrderStatus = 'RECEIVED'`, then save. `..._MarkAsClosed`: error `You cannot mark a purchase as closed while uncompleted receivings or invoices remain. Please complete or void the uncompleted receivings or invoices.`;
confirm `Purchase will be marked as complete. Click 'Yes' to proceed.` -> `'CLOSED'`, save. (Simple: `Purchase_Index_MarkAsReceived` allowed only when PO `AUTHORISED` and `StockStatus` AUTHORISED, same texts, sets `RECEIVED`.)

**Archive** (`archiveQuoteOrOrder`): blocked when a prepayment exists - error `Purchase order with deposit can not be archived.`; confirm `Are you sure you want to archive this purchase order?`; `POST /QuoteNOrderArchive/ArchivePurchase {taskID}`; failure `Archiving failed! Please try again later.`
**Approve / Reject** (`setApprovalStateForQuoteOrOrder`): confirms `Are you sure you want to approve this purchase order?` / `Are you sure you want to reject this purchase order?`; `POST /QuoteNOrderApprove/Approve {taskID, newState (1 reject, 2 approve), taskType}`; failure `Approve failed! Please try again later.` State 0 (review) runs `undoFun()`.
Approval gating (verified in Simple: `StatusTracker.stockReceived.setTabDisabled` / `invoice.setTabDisabled` use `isApproved()`): with `IsOrderApproveEnabled`, the Stock and Invoice tabs stay disabled until `OrderApprove === 2`, except when `SkipQuote`, or an invoice/stock is already AUTHORISED/PAID, or blind receipt. `isRejected()` (state 1) also locks the order and disables the invoice tab.

**Credit note** (`PurchaseAdvanced_CreditNote_Complete`): `Please specify the credit note number.` / `Please specify the credit note date.` / `You do not have permission to authorize credit notes.` / `Your credit note is empty. You cannot authorize an empty credit note.`
Quantity guards per product: credited qty (this CN) may not exceed the sum of AUTHORISED/PAID invoices' qty -> warning `The credited quantity ({0}) for product ({1}) exceeds the invoiced quantity ({2}) which is not allowed.`;
if linked to an invoice, cumulative: `Total credited quantity for product ({0}) would exceed the invoiced quantity. Invoiced: {1}, already credited: {2}, attempting to credit: {3}.`
Then `UnstockStatus` handling: lines on an ASSET account (not for job/drop-ship) require unstock authorised together: warning `You need to authorize the unstock together with the credit note.` and the Unstock inner tab opens.
Per-line edit: quantity above that product's invoiced total on the linked invoice is reverted with warning `The credit note quantity for a product can not be more than the invoiced quantity.`
Unstock (`validateUnstockQty`): `Product ({0}) unstock quantity ({1}) could not exceed the credited quantity ({2}).`; `Product ({0}) unstock quantity ({1}) could not exceed the received quantity ({2}).`; batch variant `Product ({0}) batch ({1}) unstock quantity ({2}) could not exceed the received quantity ({3}).`
Received quantity available to unstock = received (Received=true) cards of the linked invoice grouped by (location, card, costing, expiry, date, BatchSN) minus unstocks already authorised on other credit notes.
Copy from invoice (`..._CopyFromInvoiceAction`) merges identical lines (same product, price, account, comment, discount) summing quantity, re-computes totals; additional-cost lines subtract quantities already credited on authorised credit notes for the same invoice and skip lines that net to <= 0.
Select-invoice warning when none: `Please select invoice(s).`; unstock copy message `Items cannot be unstocked as they have not been received or have been used in other operations (purchase, production, etc.)`, success `Unstock copied.`

**Payments & deposits**:
- New payment (`PurchaseAdvanced_NewPayment_Save`): required Account, Date paid, Amount (field highlighting). Creates a payment line `Type 'ACCPAY'` (invoice) / `'ACCPAYCREDIT'` (credit note), `PaymentType 'R'`, with `CurrencyConversionRate`. Dialog title "Add a new payment" (invoice) / "Add a new refund" (credit note).
- Supplier deposit (`Purchase_NewDeposit_Save`): `Amount must be greater than zero.`; `Please specify a date.`; `Please specify a bank account.` (not for refunds); reference truncated to 50 chars; info toast `Creating supplier deposit...`;
  `POST /api/Purchase_Index_vPurchaseDeposit` with `{ID, SupplierID, Currency (supplier), Amount, RemainingAmount = Amount, Account (deposit account), CreditSourceTaskID, OrigTaskType 'S', Type 'P' (deposit) or 'R' (refund), Date, SourceLineID (= payment line id)}`
  then a payment line (`Type ACCPAY, PaymentType 'P'` for deposits; credit-note payment line `ACCPAYCREDIT/'R'` for refunds) is added and the task saved. After a deposit the supplier combo is disabled.
  Preconditions to open (`PurchaseAdvanced_Order_AddDepositsRecord`): `Please specify a supplier deposit account in your account mapping before saving the changes.` (needs `AccountSupplierDepositStore`), QuickBooks: `Please select a zero-rated tax rule for purchase deposit in Account mapping` (HTML link),
  `You must select a supplier.`, `Purchase task must be saved before adding a supplier deposit.` The deposit account combo auto-selects and locks when exactly one candidate exists.
- Allocate deposit to invoice (`Purchase_NewAllocation_*`): only authorised/paid invoices (`You need to authorize the invoice before registering payments.`); shows deposits for the supplier with `RemainingAmount > 0` after subtracting deposits already allocated in this unsaved session;
  clicking a deposit allocates `min(required - alreadySelected, remaining)` rounded 2 dp, where `required = abs(invoiceTotal - paid)`; auto-deselects when selected total already equals required.
  Save is valid only if `0 < abs(total) <= abs(required)` else warning `The sum of your selected deposits to be allocated must be greater than zero and less than or equal to the required amount!`
  Creates a payment line per deposit (`Type ACCPAY, PaymentType 'R'`, reference = description text stripped of HTML, max 50 chars, `DatePaid` = today, rate = deposit's `ConvRate`) plus a `vPurchaseAllocations` row (`PurchaseDepositID`, `PurchasePaymentID`, `Flag true`) and saves.
  Deleting an allocated payment line removes its allocation and triggers a save; deleting within a locked period: `You cannot delete a payment within a locked period.`
  Lock rule (`SaleMult_Index_IsInLockedPeriod`): `date < TenantLockDate` (tenant setting `LockDate`); only enforced once the document is AUTHORISED/PAID. Locked editing warning: `Editing has been disabled as transaction takes place in locked period.`

**Required-by / dates**: `ShipmentRequiredByDate` optional. Invoice due date from terms (section 3.3).

---

## 3. Field dependencies

### 3.1 Choosing a supplier (`Purchase_Supplier_ChangeEvent` / `_SelectEvent`, `vPurchase_Supplier` model)

Always:
- Product and service pickers re-query with `SupplierID` (`ProductStore.extraParams = {SupplierID, lang}`; `ServiceStore.extraParams = {SupplierID}`); hidden `SupplierID` inputs on the line dialogs updated.
- Every task in the document gets `SupplierName`, `SupplierID`, `Discount = supplier.Discount` (the Discount is applied only to **new** lines; existing lines keep theirs).
- `SupplierCurrency = supplier.Currency.toUpperCase()`. If it changed: same as tenant currency -> rate `1`; else fetch rate for the PO date (`dtDate`).
- If the supplier actually changed from the one that was last selected (and a previous supplier existed), `CommonPurchase_UpdateSupplierProductSKU` calls `POST /api/Purchase_Index_vPurchase_SupplierSKU?supplierID=` with the product IDs on the order lines and **overwrites on every order line, invoice line, put-away line and stock card**:
  `SupplierInventoryCode = found.SupplierInventoryCode` and `Price = found.FixedCost`, or both `null` if that supplier doesn't list the product; then recomputes tax/total and totals.
  (So changing supplier reprices to the new supplier's fixed price list and wipes prices of unlisted products.)
- Contacts and addresses stores reload for the supplier; QuickLinks tooltip supplier updated; supplier attribute set may copy to the PO (`attributeSetHelper.tryToCopyFrom(AttributeSetCopyFrom, supplier)` when `AttributeSetCopyFrom` configured).

If the chosen supplier equals the **original** saved supplier: terms, term days/method/due-next-month, contact, phone, vendor address lines, tax rule, tax percent, tax-inclusive and internal memo are restored from the saved values.
Otherwise (a different supplier):
- **Terms**: supplier `PaymentTerm` -> term name, `TermDays`, `TermMethod`, `TermDueNextMonth`; else if the tenant has exactly one payment term -> that term; else `Terms = null`, `TermDays = null`, `TermDueNextMonth = -1`.
- **Contact, Phone, Vendor address line 1/2**: cleared (null).
- **Tax**: supplier `TaxRule` -> `cmbTax`, `TaxPercent = rule.EffectivePercent`, `TaxInclusive = rule.Inclusive`; else if the tenant has exactly one tax rule -> that rule; else `cmbTax = null`, `TaxPercent = 0`, `TaxInclusive = false`. Order grid refreshed.
- **Internal memo** (`PurchaseOrderMemoInternal`, sticky note) = supplier `Comments`.
- Location, default account, date, shipping address are not touched.
- A supplier chosen but no longer in the store is injected from the task (`vPurchase_Supplier` built from task fields) so inactive suppliers on old documents still display.

Prefill from a sale (`CommonPurchase_PrefillOrderLinesIfRequired`, URL `?saleID=&onlyBackorder=` default true): `GET /api/Purchase_Index_SaleOrder/Prefill` returns supplier details and lines; supplier is selected (`select` event fired), line `Discount = supplier.Discount`, `Tax = Total = 0`;
lines without a tax rule get the header rule (and `TaxPercent` per inclusive/exclusive if it was 0); lines with `Price == 0` are priced via `POST /api/Purchase_Index_SaleOrder/SupplierProducts?supplierID=` (`found.Cost`). The sale's `OrderComment` is prepended to the internal memo.

### 3.2 Choosing a product on a line

Product pickers refuse to open without a supplier: warning `You need to select a supplier first.` (stock-received picker only enforces this for blind receipts: `You need to select a supplier first.`).
Setting the `ProductCode` cell copies from the `ProductStore` record (the server already applied the supplier filter/price):
- Order line (`vPurchaseOrderLinesEditing` edit): `ProductID`, `ProductCode`, `Name`, `UnitOfMeasure = Unit`, `CostingMethod`, `InventoryAccount = DefaultFixedAssetAccountCode = Account`, `BinID`, `ProductType = Type`,
  `SupplierInventoryCode` (propagated to every line of that product on every tab via `PurchaseAdvanced_Index_SetSupplierInventoryCode`), `Price = rec.Cost`.
  Tax: product `TaxRule` if set else the header tax rule; `TaxPercent` per inclusive/exclusive; then `UpdateTaxAndTotalPurchase`, totals refresh, and `CommonPurchase_GetLocationFromProduct` registers the product's default bin in the location stores. Unknown code reverts the cell to the original value.
  Discount is not changed on product pick (set when the row is created = supplier discount).
- Invoice line: as above plus `AccountCode`: product `Account` if non-empty and the PO has no `JobID`; else the header default account (`cmbPurchase_Index_DefaultAccount`); fixed-asset products also keep `DefaultFixedAssetAccount(Code)`.
  Changing a fixed-asset line's account away from its default asks: `The product "[ProductName]" has type fixed asset and by default is allocated to "[DefaultAccount]" account. Would you like to use "[SelectedAccount]" account  instead? Account "[SelectedAccount]" is type of "[SelectedAccountType]".`
  An account not in the COA list is cleared.
- Stock-received line: `ProductID, Name, ProductCode, UnitOfMeasure, SupplierInventoryCode, InventoryAccount, DefaultFixedAssetAccountCode, TaxRule, ProductType, CostingMethod`; if the product has a `BinID` whose parent is the header location, `Location = BinID`; serial-costed products set `Quantity = 1`.
- Additional-cost line `Description` (service picker, `ServiceStore`): fills `ExpenseAccount = service.Account` and tax rule (service `TaxRule` else header rule; percent per inclusive/exclusive). Cost lines default `Quantity = 1`, `Amount = 0`, `Discount = supplier discount`, header tax rule.
- New order line defaults: `Quantity 0, Price 0, Discount = task.Discount, CostingMethod 'FIFO', TaxRule = header rule, TaxPercent = task.TaxPercent`.
- Family matrix "bulk add" (`divAddBulk_Order`; shown only if `ProductFamilyCount > 0`): needs supplier (`Please choose a supplier for your purchase task.`); dialog errors `Please choose a product family.`, `Please choose the family options.`, `There are no products with quantity more than 0.`, `The product price should be positive.` (validation is `price >= 0`).
  Applying (`PurchaseAdvanced_Order_FamilyMatrix_AddProducts`): price override applies only if `> 0`, else each product's `Cost`; a product already on the order has its **Quantity and Price overwritten** (counted as "skipped"); new lines get `Discount = task.Discount`, product tax rule else header rule.
  Toast: `<n> product(s) was/were added` and/or `<m> product(s) was/were already in the Order`, or `No variations found in the family with specified search criteria.`
- PO file import (`PurchaseAdvanced_Order_UploadPOLines_Completed`): `Please choose a supplier before uploading the file.` Replaces **all** order lines (`removeAll()` then add); lines with unknown/missing tax rule get the header rule and percent; success `Product lines imported successfully.`; server errors come back as `ErrorLines` shown in the exceptions grid.
- Product replenishment "Verify" (`PurchaseAdvanced_ProductReplenishmentDetails_*`, `POST /api/Purchase_Index_ProductReplenishmentDetails {Lang, SupplierID, LocationName, Products[{ProductID, Quantity, InternalId}]}`): editable `OrderQuantity` writes back to the PO line;
  `NumberOfCartons = ceil( ceil(OrderQuantity / CartonInnerQuantity) / CartonQuantity )` and `LineVolumeSum = DEARRound(NumberOfCartons * LineVolume, 3)` when both carton quantities > 0 (else 0).
  Validation (error stops, warning only flags): `OrderQuantity === 0` -> `Please specify a quantity.` (Invalid); `> 10000000` -> `Quantity should be less than 10000000.` (Invalid);
  `< MOQ` -> `Order quantity for the product is less than the minimum order quantity (MOQ) acceptable by the supplier.` (Warning); `OrderQuantity + Backordered - OnOrder - Available > MinimumBeforeReorder + ReorderQuantity`
  -> `The total quantity of the product may exceed the maximum stock level.` (Warning); `< Backordered` -> `Order quantity for the product is insufficient to fulfill backordered sales.` (Warning). Only the first matching branch applies.
- Invoice "Verify" freight allocation (`Purchase_Invoice_Verify_CalculateCosts`): `totalCost = oceanBase + domesticBase`; per line `LineFreightCost = totalCost * (LineVolume / SUM(LineVolume))`, `UnitFreightCost = LineFreightCost / InvoiceQuantity` (only if `SUM(LineVolume) > 0`). Other-currency amount = base * `Ratio`; base = other / `Ratio`.

### 3.3 Dates and terms
- New PO defaults (`PurchaseAdvanced_Index_New`): `PurchaseOrderNumber 'Not assigned'`, `PurchaseOrderDate = today`, `Currency = TenantCurrency`, `CurrencyConversionRate 1`, `TermDueNextMonth -1`, `TaxPercent 0`, `DefaultAccount = InventoryControlAccount`, `Approach 'Invoice'`,
  `Status DRAFT`, all child statuses `NOT AVAILABLE`, `InvoiceToInventorySynch true`. On load, if the tenant has exactly one tax rule and the PO has none, that rule (and its `Inclusive`) is applied; terms default to the tenant default term if none.
- Invoice due date (`PurchaseAdvanced_Invoice_UpdateDueDate`, runs when the invoice date changes, when terms are selected, and on opening an invoice with no due date). `m0` = month of invoice date, `D = TermDays`:

| `TermMethod` | Name (payment term book) | Due date |
|---|---|---|
| 1 (default) | Number of days | `InvoiceDate + D days` |
| 2 | Day of next month | first day of next month `+ (D - 1)` days (day `D` of next month; overflows into the following month if `D` exceeds that month's length; editor clamps `Days` to 31) |
| 3 | Last day of next month | `new Date(y, m0+2, 1) - 1 day` (`Days` not applicable) |
| 4 (legacy) | - | if `TermDueNextMonth == -1`: as method 2; else `t = InvoiceDate + TermDueNextMonth days; t2 = first of t's month + (D-1) days;` if `t.getDate() >= D` then `t2 = same day in the next month` |
| 5 | Days since the end of the month | first day of next month `+ (D - 1)` days (= last day of the month + D) |

Payment-term book (`TenantPaymentTerm2019.js`): Method options are exactly 1, 2, 3, 5 above; method 3 disables Days (shown "Not applicable"); Days max 999 (31 for method 2); empty days coerce to 0;
validation texts `Name cannot be empty.`, `Method cannot be empty.`, `Days cannot be empty.`; ticking `IsDefault` clears it on all other terms (exactly one default). New row defaults `Method 1, IsActive true`.
- Setting the PO `Terms` combo stores `TermDays/TermMethod/TermDueNextMonth` on the task and recomputes the open invoice's due date.
- Location select: clears the shipping address and reloads tenant addresses for that location; shipping address selection fills line 2; location change also drives `Purchase_Scan_SetBin`.
- Order date does not refetch the currency rate (only supplier change / invoice date do).

### 3.4 Header tax rule / inclusive
- Choosing a tax rule (after first load): `TaxPercent = rule.EffectivePercent`, then the Inclusive checkbox is set to `rule.Inclusive`; toggling that checkbox runs `PurchaseAdvanced_Index_UpdateTaxInclusive` (1.8) which rewrites every line's `TaxPercent` from **its own** `TaxRule` (lines are not re-pointed to the header rule).
- Supplier change sets rule/inclusive as described in 3.1.

---

## 4. Receiving rules (Advanced; Simple differences in section 8)

Create receiving: the "+" next to Stock received adds an invoice+receiving child (`PurchaseAdvanced_Invoice_Add` creates the same child used for both; `PurchaseAdvanced_StockReceiving_Add/CreateTask` adds a *virtual* stock task `PurchaseStockTask`, several per invoice, each with its own date).

- Date required: error `Please specify date received` (both stages).
- At least one line unless every invoice line is a non-inventory product: warning `Please choose the items to be received.`
- Non-inventory products (`NonInventory` flag on the order line, else on the line itself; `PurchaseAdvanced_IsNotNonInventoryProduct`) are excluded from copy and from quantity comparisons: `Non-inventory products cannot be added to stock receive.` / `There are no lines to copy.`
- **Copy buttons** (`PurchaseAdvanced_StockReceived_Copy`): quantity to receive per product =
  - from PO (`fromPO`): ordered per product minus receivings already AUTHORISED for this invoice (`GetCurrentToBeReceived_PO`);
  - from invoice/receiving: invoiced per product (non-inventory excluded) minus receivings already AUTHORISED (`GetCurrentToBeReceived`); products at 0 remaining are skipped;
  - with put-away enabled, copy-from-receiving takes the put-away (intermediate) line quantities.
  Non-serial costing: one line `Quantity = remaining`. Serial costing (`SN`, `FISN`, `FESN`): **N lines of quantity 1** (N = remaining), each needing its own serial. Lines carry batch/serial, expiry, supplier SKU, UoM, tax rule, account.
  Copy replaces all existing unreceived lines first (`removeAll`).
- Location per line: product default bin (`BinID`/`LocationID`) if its parent equals the header location (or the header location is empty) - except when a co-manufacturing account type forbids it; otherwise the header location; fixed assets get no default location; picking a fixed-asset product on a non-fixed-asset-only location nulls the location, and vice versa the header location is restored.
- Grid editability (`PurchaseAdvanced_StockReceived_IsFieldEditable`): Quantity not editable for serial-costing (fixed 1); Batch/serial # and Expiry date not editable (render "N/A") when `CostingMethod == 'FIFO'`.
- Costing method strings: `FIFO`, `FISN` (FIFO-serial), `FIBATCH` (FIFO-batch), `FESN` (FEFO-serial), `FEBATCH` (FEFO-batch), `BATCH` (special-batch), `SN` (special-serial). `IsSerialNumberCostingMethod` = SN|FISN|FESN. `IsSpecialCostingCostingMethod` = SN|BATCH|FEBATCH.
- **Blank serials**: on authorise, if any line whose method is serial **or** special has an empty `BatchSN`, confirm `Some of your serial numbers are not defined, would you like to autofill them?` (server fills). Note `FIBATCH` is in neither set, so blank batch numbers on FIFO-batch never prompt.
- **Order vs receipt (only when the invoice is NOT authorised/paid, not blind, and not a put-away flow with lines)**: `CommonPurchase_CheckIfMatchesTheOrder(orderLines, receivedLines, ..., 'stock received', withoutCheckingTotal=true)`: per product sums by `ProductID`;
  Advanced: product not on PO -> `Product {code}:{name} is not on the purchase order.`; received qty > ordered qty -> `For product {code}:{name}, the stock received quantity ({received}) exceeds the order quantity ({ordered}).`
  then confirm (title Confirmation) `<messages> Would you like to proceed anyway?` (so over-receiving against the PO is allowed after confirmation; under-receiving is silent in Advanced, flagged only in Simple).
- **Receiving vs invoice (invoice AUTHORISED/PAID)**: `PurchaseAdvanced_CheckQuantityWithInvoice('StockComplete')` per product: received quantity (this receiving) may not exceed invoiced minus already-AUTHORISED receivings (`toPut`), compared at 4 dp; offending lines flagged and error
  `Products received quantities are more than invoiced quantities. Please see the errors in details.` Products not on the invoice at all are also rejected. Less than remaining -> allowed with warning `Authorized quantity is less than invoiced quantity.`
- **Put-away enabled (`UsePurchasePutAway`)**: stage 1 (intermediate "Stock received", `PurchaseAdvanced_IntermediateStockReceived_Complete`) checks vs invoice remaining (`GetCurrentToBeIntermReceived`) the same way; stage 2 requires the two stages to match exactly per key `(ProductID, BatchSN, ExpiryDate)` after 4-dp rounding:
  error `The product quantities in the 'Stock received' and 'Put away' tabs do not match.` Completing stage 1 sets `IntermediateStockStatus` AUTHORISED (all quantities matched) or PARTIALLY RECEIVED on the invoice task, lines `Received = true`, virtual task AUTHORISED, then opens the Put-away sub-tab.
- Statuses written on authorise (`PurchaseAdvanced_StockReceived_CompleteAction`): virtual `StockStatus = AUTHORISED`; lines `Received = true`; if the invoice is AUTHORISED/PAID: `Approach = 'Invoice'` and invoice-task `StockStatus = AUTHORISED` when received == invoiced for **every** product (both directions) else `PARTIALLY RECEIVED`;
  if invoice not yet authorised: `Approach = 'Stock'` and invoice-task `StockStatus = DRAFT`.
- Re-evaluation on load (`PurchaseAdvanced_StockReceived_RecalculateStatus`): an AUTHORISED/PAID invoice whose `StockStatus` is `PARTIALLY RECEIVED` or `NOT AVAILABLE` flips to `AUTHORISED` (and silently re-saves) when received == invoiced for all products and no unreceived lines remain.
- Save-time (`PurchaseAdvanced_StockReceived_PrepareToSave`): every virtual stock task's lines are merged into the invoice task with `Date = stockTask.Date` (today if empty); if put-away lines exist and none is `Received`, `IntermediateStockStatus = DRAFT`.
- Co-manufacturing (production order) check before invoice or receive authorise when the PO has `HasProductionOrder`: `POST /api/Purchase_Index_CoManCheck/CanBeCompleted?taskID=&masterTaskID=` with product IDs. If any production order would be blocked: confirm
  `Production run &nbsp; <links> cannot be completed.&nbsp;Would you like to authorize receive anyway?` (`...authorize invoice anyway?` for invoices) or, for receive when a run doesn't exist yet,
  `Production run cannot be created until invoice is authorized. Please authorize invoice first.Would you like to authorize receive anyway?`. Declining remembers the check as still required.
- Mark-as-received / closed see 2.4. A received-but-not-invoiced PO ("Approach Stock") is valid; the invoice can be authorised later and must then match received quantities for a `Received` stock status.
- Over-receipt guard text for put-away vs stock grids: `Product "CODE: Name" has the quantity invoiced (X) which is different from the quantity received (Y).`

---

## 5. Validations, limits, and helper rules

### 5.1 Required / format
- Required-field highlighting (`__HighlightInvalidFields.validation`) before authorising PO, payment, deposits, supplier.
- Supplier form required: Name, Currency, Payment term, Account code (accounts payable), Tax rule, Status (`Supplier_Index_Submit`). New supplier defaults (`Supplier_Index_New`): `AccountCode` = first COA entry, `Discount 0`, `IsActive true`.
  Status values `ACTIVE` / `DEPRECATED` (`IsActive` boolean). Discount: number, `minValue 0`, `maxValue 100`, 4 dp. Currency defaults: record currency, else the only tenant currency, else first. Payment term default: record, else the only/first term. Tax rule default: record else first.
  Delete contact confirm `Are you sure you want to delete the contact?`, address `Are you sure you want to delete the address?`.
- Quick-add supplier dialog (`Purchase_NewSupplier_*`): required Name, Payment term, Tax rule, Currency, Account code; discount must be numeric: `The discount value is not valid.` (note: 0-100 is NOT enforced in this dialog); defaults: currency = tenant currency, payment term = first term, tax rule only if exactly one, carrier = first carrier, account code only if exactly one; saved as `IsActive true`.
- Supplier list (`SupplierList2019.js`): merge needs >= 2 selected (`Please select suppliers to merge.`, `Please select at least two suppliers to merge.`, `Please select the primary supplier to merge the other suppliers into.`, read-only users: `You do not have permission to merge suppliers.`), `POST /api/SupplierList_Merge`, success `Successfully merged all suppliers.`; delete needs write access (`You do not have permission to delete suppliers.`); the list defaults to active suppliers only (checkbox `IsActive` default true); columns Name, Contact, Phone, Email, Website, Address, Due (`DueAmount`), Status (`ACTIVE`/`DEPRECATED`).
- Supplier deposits list (`SupplierDeposits2019.js`): grouped by supplier; columns Supplier, Date, `Amount/balance` (`Amount / RemainingAmount`; when different the balance is a link to the allocation list showing Document #, Date paid, Allocated amount), "Created as/by"; filter `usedDeposits`; `GET /api/SupplierDeposits_Index_vList`.
- Purchase list bulk actions (`PurchaseList_BulkAction`, `POST /api/PurchaseListBulkAction {Action, ids}`): Merge (`Please select the primary product to merge the other products into.` / `Please select purchases to merge.` / `Please select at least two purchases to merge.`; permission `You do not have permission to merge purchases.`; confirm `This will merge the selected orders. Would you like to proceed?`),
  Void (`This will delete the order, stock received, invoice and payment records. Would you like to proceed anyway?`), Undo (`This will change the task status back to draft. Would you like to proceed anyway?`), Print (`Please select at least one task to print.`). Void/Undo buttons shown from `GET /api/Purchase_Index_UndoVoidAccess` (`[0]==0` shows Void, `[1]==0` shows Undo).
  `IsDefaultAdvancedPurchase` (from `/api/TenantGeneralSettings_Index_vTenant/short`) decides whether the "New" button opens Advanced.
- Invoice/PO header memo text exactly `Lock PO` locks the PO (order lines and header), a documented hidden convention.

### 5.2 Numeric limits
- Quantity 4 dp; price up to 7 dp (4 dp on Xero); discount 4 dp; money 2 dp; tenant-currency conversions 2 dp; rate 5 dp, min 0.00001.
- Replenishment: order quantity must be > 0 and <= 10 000 000 (error text above).
- Payment/deposit amount: deposit `> 0` enforced (`Amount must be greater than zero.`); payment amount is only required-field validated (can be 0 or over the due).
- Reorder pages (all three): selected row price `< 0` -> `<code>: <name> Reorder price should have a non-zero positive value.` (the test is `< 0`, so 0 is accepted despite the text); `ReorderQty <= 0` -> `... Reorder quantity should have a non-zero positive value.`;
  purchase reorder below MOQ -> `... Reorder quantity is less than minimum order quantity.`; none selected -> `Please select at least one product to reorder.`
  Reorder email page (`ReorderSuggestion2019.js`): types Purchase / Transfer / Production (Transfer hidden when the tenant has one warehouse); columns Product, Reorder date, Units of measure, Available at, Available, On order, Minimum order quantity, Reorder quantity, Price; rows load pre-selected; `POST /api/SuggestReorder_Index_vEmailRecords {ReorderType, WarehouseID, SupplierID, Hash, Action, Reorder:[{ID, SupplierID, ProductID, LocationID, Price, ReorderQuantity, ReorderDate}]}`.
  Level-of-stock page `POST /api/Reorder_Index_Products` (location selector shown only when tenant `ReorderMode == 'Location'` via `GET /api/Reorder_Index_Tenant`). Backordered page: `POST /api/ReorderBackordered_Index_Products`, with a warning list of backordered products that have no supplier (`ProductsWithOutSupplier`):
  `The following products are on backorder but don't have supplier linked to them and therefore can't be reordered. Please add a supplier for these products to successfully use reorder function:`.

### 5.3 Permissions that gate purchase behaviour (from `PurchaseReferenceData`)
`OrderViewPermission`, `OrderAuthorisationPermission`, `BillCreditNoteViewPermission`, `BillCreditNoteAuthorisationPermission`, `StockReceivedViewPermission`, `StockReceivedAuthorisationPermission`,
`EditAuthorizedDocumentsPermission`, `UndoPermission`, `VoidPermission`, `OrderApproveRejectReviewPermission`, `OtherUsersAttachmentsPermission`, `FixedAssetPermission`, `FinancialDataPermission` (`Full|ReadOnly|None`), plus `HasPriceInfoAccess`. Value `'Full'` is required for every editing/authorising capability; `'None'` hides the tab.

### 5.4 Soft "does it match the order" check (`CommonPurchase_CheckIfMatchesTheOrder`)
Aggregates both sides by `ProductID` (Quantity summed with 4 dp rounding, plus Total/Tax/TotalWithTax unless `withoutCheckingTotal`). For each checking line with a product:
- product missing on the order -> `Product {code}:{name} is not on the purchase order. `
- Advanced: `checkingQty > orderQty` -> `For product {0}:{1}, the {entity} quantity ({checking}) exceeds the order quantity ({order}). `
- Simple/others: qty differs -> `For product {0}:{1}, the order quantity ({order}) differs from the {entity} quantity ({checking}). `; same qty but totals differ (`Total + Tax` for tax-exclusive, `Total` for inclusive, exact `!==`) -> `For product {0}:{1}, the order total ({order}) differs from the {entity} total ({checking}). `
- Non-Advanced only: order products absent from the checked store -> `Product {0}:{1} is on the purchase order but not on the {entity}. `
If anything matched badly: the concatenated messages plus `Would you like to proceed anyway?` are shown as both a warning toast and a confirm. `entity` is `invoice` or `stock received`.
Invoice vs order hard limit (`PurchaseAdvanced_Index_ValidateInvoiceAgainstOrder`, available but the shipped Authorise path uses the soft check): per key (product, price, code, tax rule, discount), invoiced qty may not exceed ordered minus other authorised invoices:
line text `The invoiced quantity exceeds the remaining quantity to be invoiced.`, toast `You cannot authorize more than was ordered or remains to be invoiced.`

### 5.5 Copy invoice from PO (`PurchaseAdvanced_Invoice_CopyLinesFromPO`)
Copies every PO line (qty, price, discount, tax rule/percent, comment, supplier SKU, UoM, costing method, `NonInventory`) to the open invoice, replacing existing invoice lines. Invoice `AccountCode` = the PO line's `InventoryAccount`, or the header default account if blank or the PO has a `JobID`
(or the co-man production account when the tenant is set up for it and its type != 4). Then subtracts quantities already on AUTHORISED/PAID invoices (matching product + code + price + discount + tax rule, reducing from the last duplicate backwards, then an overall per-product remainder pass);
lines that net to 0 are removed and totals recomputed. Additional-cost lines are copied similarly (`PurchaseAdvanced_Invoice_CopyAdditionalCostLinesFromPO`).

### 5.6 Attachments, history, misc
The invoice-lines file upload (Dropzone on `frmDownloadInvoice`) has `maxFilesize: 32` (MB). Print/email of an unauthorised invoice asks `Invoice is not authorized or/and paid. Would you like to print the chosen template?` / `...email the chosen template?`.
Print/email menus are refreshed by `PurchaseAdvanced_Index_RefreshPrintEmailTemplatesMenu`; with no supplier: error `Please select a supplier.`

---

## 6. Landed cost / additional costs (client-visible parts)

The browser does **not** compute landed-cost allocation to stock cards; it only (a) captures costs, (b) validates accounts, (c) offers manual allocation tools. What it exposes:

1. **Additional-cost lines** on the order, invoice and credit note: fields `Description`, `Reference`, `Quantity` (default 1), `Amount`, `Discount`, `TaxRule`, `TaxPercent`, `Tax`, `Total`, `ExpenseAccount`/`AccountCode`. Maths per 1.2 (`UpdateAdditionalTaxAndTotal`).
   Description picks from the supplier's services (`ServiceStore`) and fills the account and tax rule.
2. **Invoice account rule** (2.4, authorise invoice, step 6): an additional-cost line on an `ASSET`-class, non-`FIXED` account is treated as capitalised cost and must use an account that also appears on the invoice's product lines, else blocked with the message quoted in 2.4. Cost lines on non-asset (expense) accounts are plain expenses.
3. **Manual journal "Additional cost" allocation** (`Advanced Manual journals` tab, `vPurchaseManualJournals`, only editable once the invoice is AUTHORISED/PAID): columns Date, Debit, Credit, Amount, Type. `DistributeType` store (`DistributionTypeStore`):
   `C` Cost, `Q` Quantity, `W` Weight, `V` Volume, `M` Manually. Defaults for a new line: `Debit = InventoryControlAccount` (else warning `Inventory account is not defined in account mapping.`), `Amount 0`, `Date today`, `DistributeType 'C'`.
   Allocation for C/Q/W/V is done by the server. For `M` the user fills `vPurchaseManualJournalsDistributedCosts` rows (`ProductID`, `InvoiceTotal`, `DistributedCost`); on save the sum of `DistributedCost` (each `DEARRound(,4)`) must equal `DEARRound(Amount,4)`:
   error `The manual journal cost does not tally with the amount for the relevant journal entry. Please make sure these values tally with each other.` Switching a journal away from `M` clears its distributed rows.
   Protected journals (cannot be edited/deleted): `AccrualType` `+`/`-` (`Inventory accrual cost journal cannot be deleted.`), `I` (`Goods in transit journal cannot be deleted.`), `D` (`Inventory discrepancy journal cannot be deleted.`), journals created by a production run (`Cannot delete this manual journal. Please undo/void production run first.`). Authorising an empty list: `Your manual journals list is empty. You cannot authorize an empty manual journals list.`
   Editing any value moves `ManualJournalsStatus` to `DRAFT`; authorise sets it `AUTHORISED` (undo button needs `UndoPermission=='Full'`).
4. **Distribute expenses** (post-hoc allocation of an expense-account invoice/credit-note amount onto other purchase invoices, assemblies/stock transfers and production runs; `ExpenseDestributionBase`, shown when invoice `HasDistributeExpense`):
   - Auto-allocate: `koff = totalToAllocate / SUM(AccountAmount of every selected target document)`; each target account gets `DEARRound(AccountAmount * koff, 2)`; the remaining difference (`DEARRound(total - distributed, 4)`) is added to the single largest allocation.
   - Save validations: `Amount to allocate is 0. Please select the line in the expenses grid.`; targets with no document: row error `Document is not selected`; each target needs a non-zero distributed total: row error `Distributed amount cannot be zero`; `There were problems saving changes. Please see the errors in details.`;
     over-allocation (positive left: `leftToDistribute < totalDistributed || totalDistributed < 0`; negative left mirrored): `You are trying to allocate more than available {x}. Please make an adjustment to the ‘Allocated’ value.`; nothing allocated: `You have not allocated any expense.`;
     locked accounts: `Allocation cannot be saved: your accounts are locked {date}` / `The production run cannot be added: your accounts are locked {date}`. Success `Allocation saved successfully.`
   - Only invoices with positive left-to-distribute for invoice mode (credit notes: negative). Wrong-tab hints: `To allocate the credited amount please go to the 'Credit note' tab.` / `To allocate the invoiced amount please go to the 'Invoice' tab.`
   - `POST` to the document type's API (`getDocumentAPI()`, e.g. `/api/Purchase_Index_vPurchaseExpense`) with `{TaskID, OriginalPurchaseDate, AccountCode, PurchaseExpenseDistributions, TaskExpenseDistributions, ProductionExpenseDistributions}`.
5. **Freight "Verify" estimator**: volume-share split in 3.2.

---

## 7. Tenant settings and flags that change client behaviour

| Field / flag | Where read | Effect |
|---|---|---|
| `TaxCalculationMethod` (`'Row Total'` vs other) | `PurchaseReferenceData` -> `window.TaxPrecision` | 2 dp vs 4 dp per-line tax (1.2/1.8). Also warns in settings if `Xero && 'Total'`, `Quickbooks && 'Row Total' && USD`, `Quickbooks && 'Total' && non-USD` (`TenantGeneralSettings_Index_UpdateTaxCalculationMethodWarning`) |
| `Xero` (integration connected) | `Main2019.js` bootstrap `result.Xero` | `PurchasePriceDecimals 4` instead of 7; Total column locked; Undo of authorised invoice hidden; Xero link button on invoice |
| `Quickbooks` | bootstrap | deposits need a zero-rated deposit tax rule (`QBSupplierDepositZeroTaxStore`); Settle button; "Add a new term in QuickBooks and click 'Sync now'" |
| `DefaultPurchaseMethod` / `IsDefaultAdvancedPurchase` | reference data / list | which page the "New purchase" button opens (Simple vs Advanced) |
| `UsePurchasePutAway` | reference data | two-stage receiving (intermediate + put-away), hides Copy-from-PO on the receiving tab, `HideNonInventory` option in the scanner |
| `LockDate` (reference data) / `TenantLockDate` (global used by `SaleMult_Index_IsInLockedPeriod`) | reference data | blocks editing/deleting payments, additional-cost lines, accounting-dimension lines dated before it, once documents are authorised |
| `IsOrderApproveEnabled` | reference data | approve/reject/review workflow; blocks later tabs until approved |
| `IsArchiveEnabled` | reference data | archive button |
| `IsAccountingDimensionsEnabled` | reference data | dimension dialogs and `Common_AccountingDimensions_CheckTransactions_And_ShowDialog` on every save |
| `SaleAllowOrderNoAlloc` | reference data | sale-related (drop-ship link) |
| `HeadersVisible` (`'True'`) | reference data | grid header option |
| `DefaultAccount` | reference data | default invoice-line account (`InventoryControlAccount`) |
| `CurrentAttributeSetId`, `AttributeSetCopyFrom` | reference data | purchase attribute set; copied from supplier when configured |
| `ProductFamilyCount` | reference data | 0 hides bulk-add by family |
| `SearchOnlySupplierAttachedProductsInPurchaseLines` | general settings (server filters `ProductStore` by `SupplierID`) | product pick-list scope |
| `POPrefix/PONextNumber/POSuffix`, `PurchaseDocumentSortOrder`, `ReorderMode`, `UnrealizedForeignCurrency`, `InvoiceNumberTimePoint`, `DecimalPlacesInQuantity`, `AllowPurchaseOrderApproval`, `PurchaseOrderArchivePeriod`, `PurchaseAttributeSet(CopyFrom)` | general settings page | exist in the settings model; purchase page logic is server-side (see below) |
| `JobID` on the PO (co-manufacturing / production job) | task field | default account fixed, account combo disabled, unstock not required |
| `HasProductionOrder` (task) | task field | triggers the co-man checks before authorise/void/undo |
| `OrderViewPermission`, ... | see 5.3 | |
| `IsReadOnly` | access level / `TenantSubscription === 'On Hold'` | everything read-only |
| `CountrySpecificKey` | task | country hooks (`Purchase_CountrySpecific_*`, bill of entry) - out of scope |

---

## 8. Simple purchase (`SimplePurchase2019.js`) - differences

- One task, tabs Order / Stock received / Invoice / (Bill of entry) / Credit note / Unstock / Manual journals / Related orders / Financial. No child documents; statuses live on the single task:
  `PurchaseOrderStatus`, `StockStatus`, `InvoiceStatus`, `CreditNoteStatus`, `UnstockStatus`, `ManualJournalsStatus`. The Simple statuses object lacks `received/closed/completed/fullyReceived`; the only way to `RECEIVED` is "Mark as received" (literal string).
- Task-level `Status` drives tab state (`StatusTracker.UpdateControlsState`). "Locked" = read-only; "open" = editable. Two branch families depend on the approach radio (`rStockFirst` checked = receive first):

| Task `Status` | Order | Deposits | Stock tab | Invoice lines / payments / tab | Credit note | Unstock / Manual journals |
|---|---|---|---|---|---|---|
| `DRAFT`, `PO IN PROGRESS` (both modes) | open | locked | disabled | lines locked, payments open, **tab disabled** | disabled | disabled |
| `PO COMPLETED` - invoice first | locked | open | disabled | lines **open**, payments open, tab open | disabled | disabled |
| `PO COMPLETED` - stock first (also `DRAFT`/`PO IN PROGRESS` with blind receipt) | locked | open | **open** (tab gated by approval unless blind) | lines locked, payments locked, tab disabled | disabled | disabled |
| `FULLY RECEIVED` or `PARTIALLY RECEIVED` with stock `AUTHORISED` - stock first | locked | open | locked, tab open | lines **open**, payments open | disabled | disabled |
| same - invoice first | locked | open | locked, tab open | lines locked, payments open | lines open, payments open | unstock + journals enabled |
| `PARTIALLY RECEIVED` with stock `PARTIALLY RECEIVED` - stock first | locked | open | open | lines open, payments open | disabled | disabled |
| same - invoice first | locked | open | open | lines locked, payments open | lines open, payments open | unstock disabled, journals enabled |
| `INVOICE COMPLETED` - stock first | locked | open | locked, tab open | lines locked, payments open | lines open, payments open | unstock + journals enabled |
| `INVOICE COMPLETED` - invoice first | locked | open | open, tab open | lines locked, payments open | lines locked, payments locked, tab disabled | unstock disabled, journals enabled |
| `COMPLETED` (credit note authorised) | locked | open | locked | locked, payments open | lines locked, payments (refunds) open | journals enabled; unstock tab only if `Purchase_Unstock_IsRequired()` |
| `COMPLETED` (no authorised credit note) | locked | open | locked | locked, payments open | lines open, payments open | unstock tab enabled only once the credit note is complete |
| `COMPLETED / CREDIT NOTE`, `COMPLETED / CREDIT NOTE CLOSED` | locked | open | locked | locked, payments open | lines open until authorised, payments open | as above |
| `VOIDED` | tab disabled | locked | disabled | all disabled | disabled | disabled |

  (Source of truth: the `if/else if` ladder in `StatusTracker.UpdateControlsState` in `SimplePurchase2019.js`.)
- Stock vs invoice approach radios: `rStockFirst` / `rInvoiceFirst` (`Approach` property `'Stock'` or `'Invoice'`); disabled once either side is authorised. Stock-first requires **exactly** matching quantities when authorising the invoice:
  `Product {code}: {name} has the quantity invoiced ({invQty}) which is different from the quantity received ({stockQty}). The quantity received should exactly match the quantity invoiced.`;
  and `Invoice cannot be authorized if there are product lines added to the stock received tab. Please remove all products from stock received tab.` when the invoice has no lines but stock lines exist.
  Invoice-first: authorising Stock requires receiving to match invoice (rounded 4 dp) with the same message.
- Stock-received authorise (`Purchase_StockReceived_Complete`): every stock row must be ticked `Received` else warning `You need to mark all stock items as received before completing.` (Advanced has no per-row tick requirement; it sets all `Received = true`). Stock status is `NOT AVAILABLE` (no rows) / `DRAFT` (none received) / `PARTIALLY RECEIVED` (some ticked) / `AUTHORISED`.
- Invoice authorise (`Purchase_Invoice_Complete`) also checks invoice vs order with `CommonPurchase_CheckIfMatchesTheOrder` unless blind receipt or stock-first (then strict qty equality above); order-vs-stock check applies when stock first.
- Convert to Advanced (`Purchase_Index_Convert`): visible `saved && !RO && OrderAuthorisationPermission=='Full'`; confirm `This purchase will be converted to a purchase with advanced features. Please note that the conversion is irreversible. Would you like to proceed?`;
  sets `TaskTypeSign = 1`; child statuses `NOT AVAILABLE` -> `DRAFT` if lines exist; `InvoiceTaskForCreditNoteID` = own TaskID if the credit note is authorised; saves with `PlannedOperation = 'Advanced'`.
- Toolbar (`Purchase_Index_AdjustMainToolbarActions`): void/undo/convert/clone as in Advanced (void: `VoidPermission`; undo: `UndoPermission`; mark received visible when PO `AUTHORISED` and `StockStatus AUTHORISED`; clone when saved and writable; print/email menus when saved and writable).
  Void/undo endpoints `POST /Purchase/Cancel`, `/Purchase/Undo` (`{TaskID, removeAllocations}`), deposit check `POST /Purchase/DepositValidate`, same texts as Advanced. Save: `/api/Purchase_Index_vPurchaseTask`.
- Voiding a credit note in Simple: `divVoid_CreditNote` visible `creditNote.IsCompleted() && !RO && !CX && VoidPermission=='Full'`.

### 8.1 Drop-ship (`PurchaseDropShip2019.js`)
Same as Simple minus Stock received and Unstock. Matrix (`UpdateControlsState` override): `DRAFT`/`PO IN PROGRESS` order editable; `PO COMPLETED` invoice lines editable, payments editable, credit note disabled;
`INVOICE COMPLETED` invoice locked, credit note editable; `COMPLETED` / `COMPLETED / CREDIT NOTE...` as Simple; `VOIDED` all disabled. Tabs: Order, Invoice, Bill of entry, Credit note, Manual journals, Financial (default tab is Invoice after save; `''` tab disabled).
Toolbar: Void `VoidPermission`; **Undo needs the order to be completed** (`IsCompleted && UndoPermission`); Clone only when the invoice is completed; Print/email only when order completed.
"Convert to advanced" (simple drop-ship only): confirm `This drop shipment purchase will be converted to an advanced drop shipment purchase. Please note that the conversion is irreversible. Would you like to proceed?`, posts the hidden form `frmConvertToAdvanced` with `TaskIDToConvert`; unsaved: `You cannot convert an unsaved task. Save the purchase first.`
Endpoints: `PUT /api/DropShipPurchase_Index_vPurchaseTask/{id}`, `/DropShipPurchase/Cancel`, `/DropShipPurchase/Undo`, `/DropShipPurchase/CancelCreditNote {TaskID, RemoveAllocations}` (with `/Purchase/CreditNoteDepositValidate`).
Credit note authorise (`DropShipPurchase_CreditNote_Complete`): same permission/empty checks; `The credited quantity ({0}) for product ({1}}) exceeds the invoiced quantity ({2}) which is not allowed.` (the shipped text has a stray extra `}`), compared per product against all invoice lines of the task.
Unstock is never required for drop-ship (`PurchaseAdvanced_Unstock_IsRequired` returns false when `IsDropshipPurchase`); advanced drop-ship hides the receiving tab, Clone, and the "Mark as received" item.

### 8.2 Service purchase (`PurchaseService2019.js`)
Order tab has only additional-cost ("service") lines (no product lines, no stock). Tab matrix mirrors drop-ship (`PO IN PROGRESS`/`DRAFT` vs `PO COMPLETED` vs `INVOICE COMPLETED` ...). Endpoints `/api/PurchaseService_Index_vPurchaseTask`, `PurchaseService_Index_Cancel/Undo`.
`PurchaseService_Index_SetSupplierInventoryCode` is a no-op. Drafts treated by `isDraft && isBlindReceipt` like `PO COMPLETED`.

### 8.3 Stand-alone purchase credit note (`PurchaseCreditNote2019.js`)
Single document with credit-note lines, additional-cost lines, payments (refunds) and distribute-expenses; no order/stock. Matrix: `DRAFT` -> lines editable, payments disabled, tab enabled; credit note completed -> lines disabled, payments (refunds) enabled; `VOIDED` all disabled.
Messages: `You do not have permission to authorize credit notes.`, `Your credit note is empty. You cannot authorize an empty credit note.`, `You need to authorize the credit note before registering refunds.`, `Please select a supplier.`, `You need to select a supplier first.`, and void/undo texts identical to 2.4 Simple.

---

## 9. Edge rules and quirks worth copying

- Rounding is applied at three levels: unit net price (7 dp), line total (2 dp), tax per line (2 or 4 dp), document tax (2 dp). Do not recompute totals from prices at document level - always sum stored line `Total`/`Tax`.
- Tax-inclusive: `Total` is gross. Document goods = `sum(Total) - round(sum(Tax),2)`. Document total = `sum(Total)` (i.e. goods + tax).
- Order balance counts only payments with `PaymentType === 'P'` (deposits); invoice balance counts `PaymentType === 'R'` and `Type === 'ACCPAY'`. Deposit allocation to an invoice creates an `'R'` payment (so the deposit moves from order to invoice balances).
- Changing supplier re-prices lines from the new supplier's price list and nulls unlisted products' price/SKU; supplier discount only affects new lines.
- Blind receipt wipes order lines. `Lock PO` memo locks the PO. Supplier combo locks once any deposit or active child document exists.
- Qty, price and total cells evaluate arithmetic via `eval` (e.g. `12*3`).
- `Received` flag per stock line; authorised receiving quantities are only editable by users with `EditAuthorizedDocumentsPermission`.
- List filter/search persistence uses `localStorage.PurchaseListSearch`; view (`General`/`Accounting`) cookie `PurchaseListView`.
- Invoice authorise leaves `InvoiceStatus` `AUTHORISED` until the roll-up on the **next save** sees a zero balance (so a final payment is reflected as PAID after save, not live).
- `StatusTracker.stock.canAddNewLines` and the receiving-tab "New" button are effectively always on for writable docs (always-true expression).

---

## 10. Not determinable statically

- **Document numbering**: PO/invoice/receiving/credit-note numbers (`POPrefix/PONextNumber/POSuffix`, `InvoiceNumberTimePoint`, "Not assigned" until first save, invoicing-and-receiving numbers across voids); the client only displays them.
- **Task `Status` roll-up** (`PO IN PROGRESS`, `PO COMPLETED`, `PARTIALLY RECEIVED`, `FULLY RECEIVED`, `PARTIALLY INVOICED`, `INVOICE COMPLETED`, `COMPLETED`, `COMPLETED / CREDIT NOTE`, `... CLOSED`, `PARTIALLY RECEIVED / CREDITED`, etc.), `BillStatus`, `PaymentStatus` (PREPAID, OVERPAID...), `OrderSendStatus`, `DaysOverdue`, `Due`: computed server-side; the client only maps labels and reads them.
- **Landed cost / additional cost allocation to inventory cards** for `C/Q/W/V` distribution types, the accrual (`+`/`-`), goods-in-transit (`I`) and discrepancy (`D`) manual journals, FIFO/FEFO/special costing, average cost updates, `Approach` ('Stock' vs 'Invoice') effect on cost basis, journal postings, Xero/QuickBooks sync.
- Server-side validation rules (max lengths, duplicate checks beyond the invoice-number lookup, concurrency, whether `Quantity` can be negative, permission checks on the API, `LockDate` enforcement on the server).
- `EffectivePercent`, `EffectivePercentInclusive`, `EffectivePercentExclusive` derivation from tax-rule components (compound/multi-component rules); the client reads them from `/api` data. Only the single-rate illustration `100*r/(100+r)` is inferred, not proven.
- The product `Cost` returned for the picker (per-supplier `FixedCost` / last price / product default; `UseLatestPurchaseCost` setting) and `LatestProductPriceBySupplier` ordering - the filter is server-side from `SupplierID`; the client only receives `Cost`.
- Which products appear in the picker (`SearchOnlySupplierAttachedProductsInPurchaseLines`), product search ranking.
- Bin suggestion logic (`binSuggestionHelper`), serial autofill pattern, expiry defaults, FEFO ordering.
- Reorder-suggestion calculation (`ReorderQty`, `MinimumToReorder`, `ReorderDate`, `AvailableAtWarehouse`, which action list is offered, resulting PO grouping, MRP), and `ProductReplenishmentDetails` source data (`MOQ`, `Backordered`, `OnOrder`, `Available`, `MinimumBeforeReorder`, carton data).
- Email/print template rendering, report templates, Document extraction (IDR) mapping, networking (DEAR-to-DEAR) links, attachment processing.
- Approval workflow semantics beyond the three `OrderApprove` states (who may approve, notifications); workflow engine (`TaskShared_Workflow_*`).
- Country-specific hooks (`Purchase_CountrySpecific_*`, bill of entry) - loaded from `/PurchaseAdvanced/CountrySpecific?Key=` per country.
- Exact meaning of `TermMethod 4` (legacy) in term-book UI (not offered by the editor store).
- Timeouts/retries and the server error strings returned in `ModelState`.
