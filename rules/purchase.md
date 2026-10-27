# Purchase business rules (Cin7 Core)

Rules for the Purchase module of the sandbox: simple, advanced, service and drop-ship purchases, receiving,
invoices, payments, credit notes and landed cost. Field and table names come from `spec/modules/05-purchase/`
and `spec/modules/20-public-api/groups/purchase.md`. Settings are named here only; `rules/settings.md` owns them.

## How to read this file

**Sources.** The public Cin7 Core help center, read in full (every purchase, costing, accounting, supplier,
landed-cost and report article), plus the API map, the repo spec, and the client-script notes in
`rules/purchase-client.md`. Nothing was run against the live Cin7 app, so server-only behaviour that none of these
sources shows stays marked as open.

Every rule carries a source tag `[S#]`; the key is below. Confidence tags:

- **[DOC]** stated in a help-center article (the `S#` that follows is the article). High confidence.
- **[API]** read directly from the API spec or repo spec. High confidence.
- **[CLIENT]** settled by static reading of Cin7's shipped page scripts (`rules/purchase-client.md`). High confidence
  for what the browser does; the server may add further checks.
- **[INFER]** deduced from other rules. Medium-low.
- **[ASSUME]** a sandbox default we chose because no source settles it. Listed again in section 12.

A rule marked `(corrected)` replaces an earlier version of this file that the full text contradicted.

### Source key

| Tag | URL |
|---|---|
| S1 | https://help.core.cin7.com/hc/en-us/articles/9034461557519-Introduction-to-the-Purchase-Module |
| S2 | https://help.core.cin7.com/hc/en-us/articles/9034492644879-Process-a-Purchase |
| S3 | https://help.core.cin7.com/hc/en-us/articles/9034446632975-Advanced-Purchase-Partial-Orders-Deliveries |
| S4 | https://help.core.cin7.com/hc/en-us/articles/9034573660943-Service-Purchase |
| S5 | https://help.core.cin7.com/hc/en-us/articles/9034557801871-Purchases-Views-and-Order-Status-Values |
| S6 | https://help.core.cin7.com/hc/en-us/articles/9034532450831-Purchase-GET (status table; mirrored in `spec/data/public-api-shapes.json`, "Available Purchase Statuses") |
| S7 | https://help.core.cin7.com/hc/en-us/articles/9034547620751-PurchaseList |
| S8 | https://help.core.cin7.com/hc/en-us/articles/11073310369679-Purchase-process-customization-settings |
| S9 | https://help.core.cin7.com/hc/en-us/articles/9034465644559-Inventory-Accrual-and-Stock-in-Transit-implementation-GRNI-GINR |
| S10 | https://help.core.cin7.com/hc/en-us/articles/9982480207375-Accounting-transactions-in-Cin7-Core |
| S11 | https://help.core.cin7.com/hc/en-us/articles/9034570756111-What-is-the-Undo-function-When-is-it-no-longer-possible-to-Undo-an-invoice |
| S12 | https://help.core.cin7.com/hc/en-us/articles/9034541199503-Purchase-Bulk-Actions |
| S13 | https://help.core.cin7.com/hc/en-us/articles/9034521303055-Purchase-Credit-Notes-and-Refunds |
| S14 | https://help.core.cin7.com/hc/en-us/articles/9034587737871-Unstock-incorrectly-received-items |
| S15 | https://help.core.cin7.com/hc/en-us/articles/9034516716047-Landed-cost-expense-distribution |
| S16 | https://help.core.cin7.com/hc/en-us/articles/10553625549711-Landed-costs-for-purchases |
| S17 | https://help.core.cin7.com/hc/en-us/articles/9982508174223-An-Introduction-to-Cost-of-Goods-Sold-COGS |
| S18 | https://help.core.cin7.com/hc/en-us/articles/9034590012559-Supplier-Deposits |
| S19 | https://help.core.cin7.com/hc/en-us/articles/9034446753935-Applying-Credit-Notes-as-Part-Payment-Purchases |
| S20 | https://help.core.cin7.com/hc/en-us/articles/9034435083791-Bulk-Supplier-Payments |
| S21 | https://help.core.cin7.com/hc/en-us/articles/9034494222863-Purchase-Order-Approval |
| S22 | https://help.core.cin7.com/hc/en-us/articles/10664584489103-Receive-and-put-away-stock-with-WMS |
| S23 | https://help.core.cin7.com/hc/en-us/articles/9034481322639-Dropshipping |
| S24 | https://help.core.cin7.com/hc/en-us/articles/9034511096335-Purchase-POST |
| S25 | https://help.core.cin7.com/hc/en-us/articles/9034465437071-Import-purchase-tasks-via-CSV |
| S26 | https://help.core.cin7.com/hc/en-us/articles/9034574221071-Tax-rules |
| S27 | https://help.core.cin7.com/hc/en-us/articles/9034504782735-Managing-Suppliers |
| S28 | https://help.core.cin7.com/hc/en-us/articles/12429786547983-Calculation-of-Available-On-Hand-and-Allocated-Stock-quantity (and https://help.core.cin7.com/hc/en-us/articles/9034523140879-ProductAvailability) |
| S29 | https://help.core.cin7.com/hc/en-us/articles/9034464211343-Average-Cost |
| S30 | https://fiskalfinance.com/cin7-grni-ginr-inventory-value (third party; no longer relied on, S9 settles it) |
| S31 | https://help.core.cin7.com/hc/en-us/articles/9034451009935-Default-field-values-for-new-products-customers-and-suppliers |
| S32 | https://help.core.cin7.com/hc/en-us/articles/9034604405007-User-permissions-explained |
| S33 | Repo: `spec/modules/05-purchase/UI.md`, `schema.sql` (PurchaseTask, PurchaseReferenceData) |
| S34 | Repo: `spec/modules/20-public-api/groups/purchase.md` (field tables, allowed values) |
| S35 | https://fiskalfinance.com/cin7-unit-cost-wrong (third party; no longer relied on, S9 and S17 settle it) |
| S36 | https://help.core.cin7.com/hc/en-us/articles/11073350117775-Organization-settings (tax calculation method) |
| S37 | https://help.core.cin7.com/hc/en-us/articles/9034476155279-Multicurrency-and-currency-conversion |
| S38 | https://help.core.cin7.com/hc/en-us/articles/9034518503311-Overpayments (sales side) |
| S39 | https://help.core.cin7.com/hc/en-us/articles/11073339810575-Financial-settings (period lock date) |
| S40 | https://help.core.cin7.com/hc/en-us/articles/9034460268815-Charts-of-accounts-and-other-financial-settings |
| S41 | https://help.core.cin7.com/hc/en-us/articles/9034491249423-Monthly-Closing-Process-Financial-Periods-Report |
| S42 | https://help.core.cin7.com/hc/en-us/articles/9034471048335-Managing-Manual-Journals |
| S43 | https://help.core.cin7.com/hc/en-us/articles/9034524341263-Purchase-FAQs |
| S44 | https://help.core.cin7.com/hc/en-us/articles/13000990566671-Sync-purchases-with-Xero |
| S45 | https://help.core.cin7.com/hc/en-us/articles/9034604135823-Stock-Received-vs-Invoice-Report |
| S46 | https://help.core.cin7.com/hc/en-us/articles/9034464614415-Costing-Methods |
| S47 | https://help.core.cin7.com/hc/en-us/articles/9034548724495-Sale-Overview-Report (FAQ on drop-ship COGS) |
| S48 | https://help.core.cin7.com/hc/en-us/articles/12047242513039-Configure-product-suppliers |
| S49 | https://help.core.cin7.com/hc/en-us/articles/9034589963279-Stock-Received-Not-Invoiced-Report |
| S50 | Repo: `rules/purchase-client.md` (static reading of the shipped page scripts; section numbers cited as "client §n") |

## ⚠️ Gotchas: the sneaky stuff

> [!CAUTION]
> **Void is permanent and takes deposits, payments and linked production with it**
>
> Voiding a purchase deletes its inventory, invoice and payment records and the document can never be edited again [DOC]. When the purchase holds deposits the client warns they go too, with every allocated payment, and any linked production orders or runs are voided as well [CLIENT]. Undo is the reversible option: it only returns the stage to draft [DOC]. [details](#33-component-state-machine-each-part-separately)

> [!CAUTION]
> **Undo is blocked once the stock has been used, and undoing an invoice drops its payments**
>
> A purchase cannot be undone after its goods were sold, transferred or used in production; those later tasks must be undone first [DOC]. Undoing or voiding a single invoice warns that every payment allocated to it will be removed, and both are refused while an authorised credit note is linked to the invoice [CLIENT]. Undoing a whole order keeps lines, invoices and payment info [DOC]. [details](#33-component-state-machine-each-part-separately)

> [!CAUTION]
> **The invoice sets cost, not the receipt: received stock can sit at cost 0 and sell at COGS 0**
>
> With accruals off, stock received but not yet invoiced has no value, and a sale shipped from it books COGS 0 until the invoice is authorised, when it is restated at the invoice date [DOC]. (corrected) The old "PO cost, then average, then 0" fallback is real only when Inventory Accrual is on, where the receipt is valued at PO cost or, failing that, average cost [DOC]. [details](#41-receiving-before-the-invoice-cost)

> [!CAUTION]
> **Drop-ship COGS posts when the purchase invoice is authorised, not when goods arrive**
>
> There is no ship tab, no stock-received tab and no unstock on a drop-ship purchase; cost of goods sold is booked at the supplier invoice date, and shows as 0 until that invoice is authorised even if the supplier has delivered [DOC]. (corrected) An earlier note said "once the purchase is fulfilled"; only one report FAQ words it that way. [details](#9-drop-ship)

> [!CAUTION]
> **Landed cost is capitalised only when booked to the inventory account, and late cost makes a second COGS entry**
>
> A cost line or manual-journal debit on any other account is a plain expense [DOC]. A line on an asset-class account that is not among the product-line accounts is blocked at invoice authorisation [CLIENT]. Manual journals need an authorised invoice first, and cost added after goods shipped creates an extra COGS journal dated at that authorisation [DOC]. (corrected) Quantity, weight, volume and manual bases are available on purchases, not only cost [DOC]. [details](#61-additional-costs-and-landed-cost)

> [!CAUTION]
> **Unstock and credit-note void are refused once stock has moved; credits are capped by what was invoiced**
>
> Unstock fails if the stock was sold, moved or adjusted; the workaround is to authorise the credit note with the unstock lines deleted, then fix quantity by stock adjustment [DOC]. Voiding a credit note is refused if restocking would drive on-hand negative [DOC]. (corrected) A credit note quantity cannot exceed the invoiced quantity, and unstock cannot exceed the credited or received quantity [CLIENT]. [details](#7-credit-notes-returns-refunds)

> [!WARNING]
> **A simple purchase cannot take a partial delivery, and Convert cannot be reversed**
>
> Receiving part of a simple purchase errors; the fix is Convert to advanced, which is irreversible but allowed at any stage [DOC]. In a simple purchase the received quantity must equal the invoiced quantity exactly, and a stock-first invoice is refused when it differs [CLIENT]. [details](#1-purchase-types)

> [!WARNING]
> **Authorising an invoice does not touch quantities, and a receipt posts no journal (unless accruals are on)**
>
> Invoice authorisation posts the journal and sets cost; stock must be authorised separately; a plain receipt posts no accounting [DOC]. With accrual or stock in transit enabled the receipt does post system journals that cannot be deleted by hand [DOC][CLIENT]. [details](#33-component-state-machine-each-part-separately)

> [!WARNING]
> **Accrual changes which posting happens, ignores additional costs, and locks invoice accounts**
>
> Stock-first purchases accrue at receipt (GRNI) and invoice-first purchases park the invoice in Stock in Transit; the accrual is valued without additional costs; once stock is authorised an invoice line account cannot change without Undo; the two accounts must be distinct and unmapped elsewhere [DOC]. [details](#8-journals-per-step-summary-level)

> [!WARNING]
> **Tax rounding is a tenant setting, and one inclusive flag governs every line**
>
> Row total rounds tax per line to 2 decimals; Document total keeps 4 decimals per line and rounds only the sum, so a grand total can differ by a cent [DOC][CLIENT]. The inclusive flag sits on the header and applies to all lines whatever their tax rule says [DOC]. [details](#5-line-totals-tax-rounding-totals-box)

> [!WARNING]
> **Changing the supplier silently reprices lines; ticking Blind receipt deletes the order lines**
>
> Picking another supplier overwrites price and supplier SKU on every order, invoice, put-away and stock line from the new supplier's fixed price list, blanking products it does not list; the supplier discount applies only to new lines [CLIENT]. [details](#102-supplier-defaults-filling-a-new-purchase)

> [!WARNING]
> **Payment amounts are barely validated and PAID appears late**
>
> The client accepts a payment of 0 or more than the amount due; deposits must be above zero [CLIENT]. An invoice moves to PAID only on the next save after the balance reaches zero, and an overpaid invoice stays AUTHORISED [CLIENT]. Supplier-side overpayment is not addressed in the help center (sales overpayments are prohibited) [DOC]. [details](#63-payments)

> [!NOTE]
> **The period lock date blocks edits, payment deletes and cost lines on authorised documents**
>
> Once set, no transaction dated before the lock date can be added, edited or deleted [DOC]; the client enforces it on payments and additional-cost lines of authorised purchases [CLIENT]. [details](#11-settings-that-change-purchase-behaviour-names-only-see-rulessettingsmd)

> [!NOTE]
> **Whole-purchase status precedence is unpublished, and PAID is not a task status**
>
> A fully received and invoiced purchase satisfies RECEIVED, INVOICED and COMPLETED at once, and the evaluation order is not documented; the sandbox ordering is [ASSUME]. PAID is an invoice and accounting-view status, not a value of the whole-purchase status table [DOC][API]. [details](#32-whole-purchase-status-derivation)

---

## 1. Purchase types

| Type | API `Type` / list value | What it is | Rules | Source |
|---|---|---|---|---|
| Simple purchase | `Simple Purchase` | One order, one stock receipt, one invoice, one credit note. The default unless the "Default load advanced purchase order" setting is on. | Receiving a partial delivery errors; the user must Convert to an advanced purchase (UI button `Convert`, `#convertAction`). Convert is irreversible (advanced cannot go back to simple), asks for confirmation, and can be done at any stage; header data carries across. A draft invoice is created automatically for a simple purchase. Stock-first simple purchases require received quantity to equal invoiced quantity exactly (client). | [DOC] S1, S2, S3, S8, S45; [CLIENT] §8 |
| Advanced purchase | `Advanced Purchase` | One order with many stock receipts, many invoices, many credit notes. | Same lines can be received on the same date more than once. Items not received on a date appear as separate lines. Put-away (second receiving step) is only available here. Multiple credit notes need advanced. New advanced purchases take the order (stock or invoice first) of whichever part is authorised first; converted ones keep the existing order. Stock can be received before any invoice exists. | [DOC] S1, S3 |
| Service purchase | `Service Purchase`, `IsServiceOnly = true` | Order for services only. No stock step. | Only service products can be added; stock and non-inventory products cannot. There is no Stock Received tab and only one lines grid. The invoice is processed after the order is authorised and has a total-validation field. Account on lines must be an expense account if the cost is to stay out of product cost. Can also carry a landed-cost invoice. | [DOC] S4, S15, S16 |
| Drop-ship purchase | list field `DropShipTaskID`; GET field `RelatedDropShipSaleTask` | Simple purchase generated from a sale for a drop-ship product. | No cloning, blind receipt, input method, stock receipt/put away or unstock on credit notes. A simple drop-ship purchase may convert to advanced, with some features still unavailable. See section 9. | [DOC] S23, S3 |
| Blind receipt | `BlindReceipt = true` | A purchase with no order stage (`true` if there is no order in the purchase). UI: advanced screen labels it "Skip order"; read-only banner "This purchase is a blind receipt and has no purchase order." | Goes straight to the Invoice or Stock Received tab. Ticking it clears the order and cost lines on the client (client §2.3). Purchases created by CSV import are authorised blind receipts, with the invoice either draft or authorised; PO lines are not importable. | [DOC] S2, S25; [API] S34; [CLIENT] §2.3; S33 |
| Stand-alone credit note | list `Purchase credit note` | A supplier credit not tied to a purchase. | Only non-inventory items can be selected; no order or stock steps. | [DOC] S13; [CLIENT] §8.3 |

## 2. Purchase process options

| Option | Field | Values | Behaviour | Source |
|---|---|---|---|---|
| Purchase method (`Approach`) | `PurchaseTask.Approach`, UI radios `Purchase_Index_StockFirst` / `Purchase_Index_InvoiceFirst` | API: `STOCK` = Stock first, `INVOICE` = Invoice first (max 10 chars) | Default comes from General settings, changeable per purchase in the header; the radio locks once either side is authorised. Stock first: order, then stock received, then invoice. Invoice first: order, then invoice, then stock received. | [DOC] S2, S8; [API] S34; [CLIENT] §8 |
| Invoice first lock | | | With Invoice first the invoice must be authorised before the order can be received. The Stock Received tab needs the Invoice tab done first. | [DOC] S2, S22 |
| Order-Invoice-Stock vs Order-Stock-Invoice | | | These are the two orderings above. The list view icon order (Order, Billing, Stock Receiving, Payment) flips with the setting. | [DOC] S5 |
| Blind receipt | `BlindReceipt` | boolean, default false | See section 1. | [DOC] S2; [API] S34 |
| Receive in one step vs two | setting `UsePurchasePutAway` | on/off | Off: receive and put away into bins in one step. On: receive everything to the working-area location first, then put loose stock away into bins as a second step. Advanced purchases and WMS only; the setting does not apply to simple purchases. | [DOC] S2, S3, S8, S22; [API] S33 |
| Mark as Received | UI button `#markAsReceivedAction` | | Available only after stock received is authorised. Tells Cin7 no further receipts are expected; the remaining on-order quantity drops out of On Order, reports and the pending list. Blocked while uncompleted receivings remain. | [DOC] S2, S3; [CLIENT] §2.4 |
| Mark as Closed | client action | | Closes the purchase; blocked while any receiving or invoice is unfinished. The help-center FAQ words the blocker as an open, unpaid invoice (see section 12, item 23). | [DOC] S43; [CLIENT] §2.3 |
| Inventory Accrual | settings: Inventory Accrual account (current ASSET or LIABILITY), Stock In Transit account (current ASSET) | | Accrual postings apply to Stock-first purchases (received, not invoiced). Stock-in-transit postings apply to Invoice-first purchases (invoiced, not received). If accrual is off or an account is not mapped, behaviour is as with no accrual. Both accounts must be distinct from each other and from any other mapped account, not system accounts, and not payment-accepting. | [DOC] S1, S8, S9 |
| Order approval | setting `IsOrderApproveEnabled`, header `OrderApprove` | | See section 3.5. | [DOC] S21; [API] S33 |
| Default load advanced | setting | on/off | New purchases, including those from reorder and backordering, open as advanced. | [DOC] S2, S3, S8 |

---

## 3. Status model

### 3.1 The status enums (from the API)

| Level | Field | Values | Source |
|---|---|---|---|
| Whole purchase | `Status` (`PurchaseStatesList`) | `DRAFT`, `VOIDED`, `ORDERING`, `ORDERED`, `RECEIVING`, `RECEIVED`, `INVOICED`, `CREDITED`, `RECEIVING / CREDITED`, `RECEIVED / CREDITED`, `PARTIALLY INVOICED`, `COMPLETED` | [API] S6 |
| Whole purchase (list filter) | `Status` filter on `/purchaseList` | `NOT AVAILABLE`, `DRAFT`, `AUTHORISED`, `VOIDED`, `PAID` | [API] `describe_operation purchase list` |
| Whole purchase (page label map, server-set) | `Status` strings the page labels | adds `AWAITING APPROVAL`, `NEW`, `PO COMPLETED`, `PO IN PROGRESS`, `INVOICE COMPLETED`, `PARTIALLY REFUNDED`, `COMPLETED / CREDIT NOTE`, `COMPLETED / CREDIT NOTE CLOSED` and the `FULLY/PARTIALLY RECEIVED` and `... / CREDITED` forms | [CLIENT] §2.1 |
| Order part | `OrderStatus` / `Order.Status` | `NOT AVAILABLE`, `DRAFT`, `AUTHORISED`, `VOIDED`; the page also holds `RECEIVED` and `CLOSED` on the order after Mark as received/closed | [API] S34; [CLIENT] §2.1 |
| Stock received part | `StockReceivedStatus` (list), also called `RestockReceivedStatus` in the filter and in the status table | `NOT AVAILABLE`, `DRAFT`, `AUTHORISED`, `VOIDED`; the page adds `PARTIALLY RECEIVED` | [API] S34; [CLIENT] §2.1 |
| Invoice part | `InvoiceStatus` / `Invoice.Status` | `NOT AVAILABLE`, `DRAFT`, `AUTHORISED`, `VOIDED`, `PAID` (PAID only in the invoice model) | [API] S34 |
| Credit note part | `CreditNoteStatus` | `NOT AVAILABLE`, `DRAFT`, `AUTHORISED`, `VOIDED` | [API] S34 |
| Unstock part | `UnstockStatus` | `NOT AVAILABLE`, `DRAFT`, `AUTHORISED`, `VOIDED` | [API] S34 |
| Manual journals part | `ManualJournalsStatus` | same four | [API] S33, S34 |
| Combined receiving | `CombinedReceivingStatus` | `NOT AVAILABLE`, `NOT RECEIVED`, `PARTIALLY RECEIVED`, `FULLY RECEIVED`, `VOIDED` | [API] S34 |
| Combined invoice | `CombinedInvoiceStatus` | `NOT AVAILABLE`, `NOT INVOICED`, `PARTIALLY INVOICED`, `INVOICED`, `PARTIALLY INVOICED / CREDITED`, `INVOICED / CREDITED` | [API] S34 |
| Combined payment | `CombinedPaymentStatus` | `UNPAID`, `PREPAID`, `PARTIALLY PAID`, `PAID`, `OVERPAID / CREDITED`, `VOIDED`; the list page also shows `OVERPAID`, `PARTIALLY REFUNDED`, `NOT REFUNDED`, `REFUNDED` | [API] S34; [DOC] S5; [CLIENT] §2.2 |
| Payment record type | `Type` | `PREPAYMENT`, `PAYMENT`, `REFUND` | [API] S34 |
| General view columns (display words) | Invoice status | Not available, Not billed, Partially billed, Fully billed, Partially billed/credited, Billed/credited, Credited (standalone, no refund), Refunding, Refunded | [DOC] S5 |
| | Stock status | Not available, Not received, Partially received, Received (also shown when marked as received) | [DOC] S5 |
| | Payment status | Paid, Prepaid, Partially paid, Unpaid, Overpaid, Overpaid/Credited (refund applied to a credit note), Not refunded, Partially refunded, Refunded | [DOC] S5 |
| Accounting view status (per invoice or credit note) | Status | Draft, Authorized (including partly paid), Paid, Refunded (credit note), Rejected, Voided; overdue rows show red | [DOC] S5 |

Meaning of "NOT AVAILABLE": the part cannot be started yet (grey icon in the General view). DRAFT: part exists and is editable (yellow icon; also means partially received/invoiced on advanced). AUTHORISED: part is posted/complete (green). [DOC] S5.

General-view filters: All (or all but voided), Draft Orders, Billing (not fully billed), Awaiting Payment, Awaiting Delivery (cleared by Mark as received), Completed (fully received, invoiced and paid), With a Credit Note, Awaiting Approval, Order sent (cleared when an invoice is authorised), Archived, Rejected. [DOC] S5.

### 3.2 Whole-purchase status derivation

The table is Cin7's own definition; the precedence between overlapping rows is still not published (section 12, item 2).

| Status | Definition (API docs) | Source |
|---|---|---|
| DRAFT | No data is added to the purchase details. | [API] S6 |
| ORDERING | `OrderStatus = DRAFT` | [API] S6 |
| ORDERED | `OrderStatus = AUTHORISED` | [API] S6 |
| RECEIVING | `OrderStatus = AUTHORISED`, `StockReceivedStatus = DRAFT` | [API] S6 |
| RECEIVED | `StockReceivedStatus = AUTHORISED` | [API] S6 |
| INVOICED | `InvoiceStatus = AUTHORISED` | [API] S6 |
| CREDITED | `CreditNoteStatus = AUTHORISED` | [API] S6 |
| RECEIVING / CREDITED | combined stock status `PARTIALLY RECEIVED` and `RestockReceivedStatus = AUTHORISED` | [API] S6 |
| RECEIVED / CREDITED | combined stock status `FULLY RECEIVED` and `RestockReceivedStatus = AUTHORISED` | [API] S6 |
| PARTIALLY INVOICED | combined invoice status `PARTIALLY INVOICED` | [API] S6 |
| COMPLETED | `InvoiceStatus = AUTHORISED` and `RestockReceivedStatus = AUTHORISED` | [API] S6 |
| VOIDED | task has been voided | [API] S6 |

The status is computed on the server; the page only maps labels and the per-part statuses [CLIENT] §10. The list also exposes the three separate columns (invoice, stock, payment), so a consumer never needs the single whole-purchase value to know where a purchase stands [DOC] S5.

[ASSUME] sandbox precedence for computing `Status`, highest first: VOIDED; COMPLETED; CREDITED family (when a credit note is authorised); PARTIALLY INVOICED; INVOICED; RECEIVED; RECEIVING; ORDERED; ORDERING; DRAFT. `PAID` is a payment-level state, held on the invoice and in `CombinedPaymentStatus`; it is not a whole-purchase `Status` value (section 12, item 3, resolved).

### 3.3 Component state machine (each part separately)

Applies to Order, Stock received, Invoice, Credit note, Unstock. Source for the general Undo/Void/Authorise semantics: S2, S11, S12.

| Part | State | Action | Next state | Preconditions | Blocks / side effects | Source |
|---|---|---|---|---|---|---|
| Order | NOT AVAILABLE | (blind receipt only) | stays NOT AVAILABLE | Blind receipt skips the order | Order tab absent | [DOC] S2 |
| Order | DRAFT | Save | DRAFT | Supplier, Location required (API: `Approach` and `Location` required; one of `SupplierID` / `Supplier`) | Nothing posted. No On Order. Saving drafts keeps them out of accounting reports. | [DOC] S2; [API] S24, S34 |
| Order | DRAFT | Authorise | AUTHORISED (or "awaiting approval" if approval on) | Needs Purchase: Authorize Order permission; at least one line (an empty non-blind order is refused) | Adds line quantities to On Order. Opens Stock Received and Invoice parts. Order lines become read-only unless the user has Edit Authorized documents. No journals, except one deposit journal if a deposit exists. | [DOC] S2, S10, S28, S32; [CLIENT] §2.4 |
| Order | AUTHORISED | Undo | DRAFT | Purchase: Undo permission. Purchased items must not have been sold, transferred or used in production (undo those tasks first). Cin7 attempts to remove accounting entries first. | Order lines, invoice lines and payment info remain. On Order removed again [INFER]. After Undo on a WMS purchase, delete the lines or WMS receiving/put-away misbehaves. | [DOC] S2, S11, S12, S22 |
| Order | any | Void | VOIDED | Purchase: Void permission | Inventory, invoice and payment records are deleted; document is read-only for ever. Deposits with all allocated payments are removed and linked production orders/runs voided (client confirm). | [DOC] S2, S12; [CLIENT] §2.4 |
| Order | AUTHORISED | Mark as Received | RECEIVED | Stock received authorised; no uncompleted receivings | Removes remaining on-order quantity; leaves the pending list. | [DOC] S2; [CLIENT] §2.4 |
| Order | AUTHORISED | Mark as Closed | CLOSED | Every receiving/invoice finished | See section 12, item 23. | [CLIENT] §2.3; [DOC] S43 |
| Order | AUTHORISED | Reject (approval on) | rejected: read-only, no payments | Approve/reject permission | Stays in Rejected filter. | [DOC] S21 |
| Order | rejected | Review | DRAFT | Approve/reject/review permission | Can be edited and authorised again. | [DOC] S21 |
| Stock received | NOT AVAILABLE | (order authorised; for Invoice first also invoice authorised; with approval on, also approved) | DRAFT | see section 2 | Stock tab opens. | [DOC] S2, S22; [CLIENT] §2.4 |
| Stock received | DRAFT | Authorise | AUTHORISED | Lines have quantity and location; every line ticked Received on a simple purchase; batch/serial/expiry where the costing method requires it; quantity cannot exceed what is invoiced once the invoice is authorised | On Hand increases by received qty at the line location (and bin). On Order decreases by the same qty. **No journals** unless accrual or stock in transit is enabled. Cost layer is set by the invoice, not the receipt. | [DOC] S9, S10, S28, S46; [CLIENT] §4, §8 |
| Stock received | AUTHORISED | Undo | DRAFT | Purchase: Undo permission; the received stock must not be consumed elsewhere | On Hand reduced back; On Order restored. | [DOC] S11; [INFER] |
| Stock received | AUTHORISED | Unstock (via credit note) | see credit note | see section 7 | | [DOC] S13 |
| Invoice | NOT AVAILABLE | (Stock first: stock part authorised, or advanced) | DRAFT | For Stock first the invoice opens after receiving; Invoice first it opens right after the order | Simple purchases already have a draft invoice. | [DOC] S2, S22, S45 |
| Invoice | DRAFT | Authorise | AUTHORISED | Supplier invoice number, invoice date and due date; typed total must match the lines; due date from Terms; permission to authorise bills | Posts journal (section 8). Sets cost layers: product cost is established on invoice authorisation. Does **not** change quantities; stock must be authorised separately. | [DOC] S2, S10, S17; [CLIENT] §2.4 |
| Invoice | AUTHORISED | add payment / prepayment | stays AUTHORISED until balance is zero; then PAID on next save | Payment against an authorised invoice only | See section 6. | [DOC] S2, S3; [CLIENT] §1.5 |
| Invoice | AUTHORISED | Undo | DRAFT | Undo permission. Cin7 tries to remove accounting entries and checks whether the document was exported to Xero/QuickBooks; closed accounting periods can make this fail. Refused while an authorised credit note is linked to the invoice. Not offered when Xero is connected (client). | Journals reversed. Cost layers revert. Line data remains; the client warns that allocated payments are removed. (corrected) | [DOC] S11; [CLIENT] §2.3, §2.4 |
| Invoice | AUTHORISED | edit without Undo | AUTHORISED | Purchase: Edit Authorized documents permission | Some fields only. Others stay read-only until Undo. Blocked for dates before the lock date. | [DOC] S11; [CLIENT] §2.3 |
| Invoice | any | Void | VOIDED | Void permission; refused while a linked authorised credit note exists | Invoice and its allocated payments deleted. | [DOC] S12; [CLIENT] §2.4 |
| Credit note | NOT AVAILABLE / DRAFT | create (after invoice authorised) | DRAFT | Used to correct an authorised invoice: line, part shipment, whole shipment or post-invoice discount | | [DOC] S13 |
| Credit note | DRAFT | Authorise | AUTHORISED | Number and date required; not empty; credited qty within invoiced qty; if lines sit on asset accounts, unstock is authorised together | Posts reversal journal. Unstock moves to DRAFT/AUTHORISED. | [DOC] S13; [CLIENT] §2.4 |
| Credit note | AUTHORISED | Void | VOIDED | Refused if restocking the lines on removal would make stock on hand negative. Voiding a credit note does not void the purchase. | | [DOC] S13 |
| Unstock | DRAFT | Authorise | AUTHORISED | Stock must still be on hand; quantity at most the credited and received quantity | On Hand decreases. If stock was already sold/moved, authorise the credit note with the unstock lines removed and fix with a stock adjustment. | [DOC] S13, S14; [CLIENT] §2.4 |

"Revert" is not a separate action: the client's wording for Undo is "revert ... back to draft" (section 12, item 5, resolved).

### 3.4 Combined view: which actions are allowed at each whole-purchase status

| Whole status | Authorise | Undo | Void | Notes |
|---|---|---|---|---|
| DRAFT | order | no | yes | Nothing yet. |
| ORDERING | order | no | yes | Draft order has data. |
| ORDERED | stock / invoice (per method) | order | yes | On Order counted. |
| RECEIVING | stock | order, stock draft edits | yes | Stock draft exists. |
| RECEIVED | invoice | stock | yes | Invoice first: invoice already authorised. |
| INVOICED | stock (if not yet) | invoice (payments flagged for removal) | yes | Cost layers exist. |
| COMPLETED | credit note | stock, invoice (undo the later one first) | yes | Payments can still be added. |
| CREDITED variants | further credit notes (advanced only) | credit note | yes | |
| VOIDED | none | none | none | Terminal. |

Undo order: the help center says only that a purchase cannot be undone once its stock was used elsewhere, so downstream tasks go first [DOC] S11. "Undo the last authorised part first" is the sandbox's reading of that [INFER].

### 3.5 Order approval (optional)

| Rule | Source |
|---|---|
| When enabled, order approval applies to simple, service and advanced purchases. Enabling it also enables quote approval. | [DOC] S21 |
| It records supplier approval or rejection of an authorised order. (corrected) The settings page words it as approval before authorisation; the process articles and the client both place Approve/Reject after Authorise. | [DOC] S2, S21 vs S8; [CLIENT] §2.3 |
| After Authorise, Reject and Approve buttons appear in place of the move to the next tab. Approve continues the purchase normally. Stock and invoice tabs stay locked until approved (unless blind, skip-quote, or already authorised). | [DOC] S21; [CLIENT] §2.4 |
| Reject makes the order a rejected order: read-only, payments cannot be applied, invoice tab disabled. Review sends it back to DRAFT. | [DOC] S21; [CLIENT] §2.3 |
| Approval state values: 0 unset, 1 rejected, 2 approved. | [CLIENT] §2.3 |
| List filters: Awaiting approval, Rejected, All but rejected and voided. | [DOC] S21 |
| Permission: "Purchase – Approve, reject, and review orders" (`OrderApproveRejectReviewPermission`). The approver need not differ from the authoriser: no source says so (section 12, item 22). | [DOC] S2, S21; [API] S33 |

### 3.6 Error and confirm texts (client)

Paraphrased; short phrases quoted only where a match is useful. Server-side messages are not visible to any source.

| Situation | Message gist | Source |
|---|---|---|
| Authorise empty order | "empty order", suggests blind receipt | [CLIENT] §2.4 |
| Authorise empty invoice or credit note | empty document cannot be authorised | [CLIENT] §2.4 |
| Invoice number, date or due date missing | asks to specify the missing field | [CLIENT] §2.4 |
| Typed invoice total differs from lines | "does not match" the line and cost-line totals | [CLIENT] §1.5 |
| Same supplier invoice number already used | confirm "Another invoice from the same supplier" | [CLIENT] §2.4 |
| Non-asset account on a product line | confirm that the product will be written off from inventory now | [CLIENT] §2.4 |
| Additional cost on an asset account not used by product lines | warning about "an incorrect asset account" | [CLIENT] §2.4 |
| Receipt above ordered quantity or product not on order | confirm "Would you like to proceed anyway?" (Advanced); allowed | [CLIENT] §4 |
| Receipt above invoiced quantity | error that received exceeds invoiced; offending lines flagged | [CLIENT] §4 |
| Stock-first simple invoice differs from receipt | received must "exactly match" invoiced | [CLIENT] §8 |
| Put-away tab differs from stock-received tab | quantities in the two tabs "do not match" | [CLIENT] §4 |
| Credit quantity above invoiced | "exceeds the invoiced quantity ... not allowed" | [CLIENT] §2.4 |
| Unstock above credited or received quantity | "could not exceed" credited or received quantity | [CLIENT] §2.4 |
| Payment before invoice authorised | "authorize the invoice before registering payments" | [CLIENT] §2.4 |
| Refund before credit note authorised | "authorize the credit note before registering refunds" | [CLIENT] §2.4 |
| Deposit amount zero or less | "must be greater than zero" | [CLIENT] §2.4 |
| Deposit allocation larger than due | sum must be above zero and at most the required amount | [CLIENT] §2.4 |
| Deposit with no mapped account | asks for a supplier deposit account in account mapping | [CLIENT] §2.4 |
| Void/undo invoice with linked authorised credit note | refused | [CLIENT] §2.4 |
| Mark received/closed with unfinished receivings or invoices | refused | [CLIENT] §2.4 |
| Archive with a deposit | "can not be archived" | [CLIENT] §2.4 |
| Delete payment dated before lock date | "cannot delete a payment within a locked period" | [CLIENT] §2.4 |
| Manual-journal distribution does not tally | "does not tally with the amount" | [CLIENT] §6 |
| Partial delivery on a simple purchase | a blocking error exists per the help center; the client expresses it as the order-vs-receipt difference check and the strict equality check above | [DOC] S3; [CLIENT] §4, §8 |
| API validation failure | HTTP 400, list of `{ErrorCode, Exception}` | https://help.core.cin7.com/hc/en-us/articles/9034464091023-API-Status-Codes |

---

## 4. Effects per transition

"On Order" = authorised, not yet received. "On Hand" = physically expected in the warehouse, excluding unreceived purchases. [DOC] S28.

| Transition | On Order | On Hand | Cost | Journal | Other | Source |
|---|---|---|---|---|---|---|
| Order Authorise | + ordered qty (per product, at order Location) | none | none | none (deposit journal only if a deposit exists) | Opens next stages | [DOC] S10, S28 |
| Order Undo | - ordered qty | none | none | none | Order editable; blocked once stock is used | [DOC] S11; [INFER] |
| Order Void | - remaining ordered qty | reverses any received qty [INFER] | removes cost layers [INFER] | reverses | Records deleted | [DOC] S12 |
| Stock Authorise (qty r) | - r (not below zero) | + r at line location/bin; batch/serial/expiry recorded | none until invoice; with accrual on, valued at PO cost else average cost | none (accrual journal if on) | `PurchaseStockTask.StockReceivedDate/Location/Received` set | [DOC] S9, S10; [API] S34 |
| Stock Undo | + r | - r | none | none | | [INFER] |
| Mark as Received | remaining order qty removed | none | none | none | Prevents further receipts | [DOC] S2 |
| Invoice Authorise | none | none | Sets/updates cost: new cost layer for the invoiced qty; average cost recalculated; cost flows to any units already sold before the invoice (COGS updated at the invoice date) | Section 8 | `InvoiceStatus = AUTHORISED` | [DOC] S17, S29 |
| Invoice Undo | none | none | cost layers reverted | reversal | Allocated payments flagged for removal | [DOC] S11; [CLIENT] §2.4 |
| Payment | none | none | none | Dr Accounts Payable / Cr Bank | `CombinedPaymentStatus` moves | [DOC] S10, S3 |
| Credit note Authorise (price/discount only) | none | none | Cost lowered by the credited amount [INFER] | reversal of invoice portion (negative amounts) | Price-only credits delete the restock line | [DOC] S10, S13 |
| Credit note + Unstock Authorise | none | - unstock qty | cost layer consumed | reversal incl. inventory | Fails if stock already used | [DOC] S13, S14 |
| Refund | none | none | none | Dr Bank / Cr Accounts Payable | Or kept as supplier deposit | [INFER]; [DOC] S13 |
| Void | clears | clears | clears | reverses all | Terminal | [DOC] S12 |

### 4.1 Receiving before the invoice (cost)

Cost is calculated on invoice authorisation, while quantity is added on stock-received authorisation [DOC] S9, S17. Consequences:

- Accrual off: if the invoice is not authorised, or has no cost, the stock value is 0 though units exist; if the invoice is authorised first the value is booked even though nothing has arrived [DOC] S9. A sale shipped from not-yet-invoiced stock shows COGS 0 and is restated on the invoice date [DOC] S17.
- Accrual on (Stock first): the receipt is valued at the PO cost value when present, otherwise the product's average cost at that moment; the invoice later reverses that accrual and books the real cost [DOC] S9. (corrected) This replaces the third-party fallback chain, which applied it to all purchases.
- Additional costs on the PO are not part of the accrual value [DOC] S9.
- Costs are never edited after the fact: a cost event dated after the COGS journal makes an additional COGS entry [DOC] S17.

### 4.2 Receiving detail

| Rule | Source |
|---|---|
| Each stock line has Date, Quantity, Product, Location (`LocationID`), `Received` flag, `BatchSN`, `ExpiryDate`, `CardID`. | [API] S34 |
| Receiving into a bin uses the product bin; with put-away on, stock first sits at the working-area location until put away. | [DOC] S22; [CLIENT] §4 |
| Stock can be received into two locations by adding a second line. | [DOC] S2 |
| Serial costing methods split a receipt into one line per unit; a serial or batch number is mandatory for serial/batch methods and the expiry date for FEFO; FIFO plain forbids a batch or serial. Duplicate serial numbers are not detected by Cin7. | [DOC] S2, S46; [CLIENT] §4 |
| Blank serials: the client offers server auto-fill for serial and special methods but never prompts for FIFO-batch. | [CLIENT] §4 |
| Several receipts on the same date are allowed on advanced purchases. | [DOC] S3 |
| Partial receipt on advanced: reduce or remove lines that did not arrive, authorise, repeat for the rest; the remainder stays on order until fully received or Mark as Received. | [DOC] S2, S3 |
| Closing a purchase that will never be fully received without changing the order: remove undelivered lines on Stock Received, make invoiced equal received, authorise stock, then Mark as Received. Removing an item from the order itself needs Undo, and anything that consumed the stock must be undone first. | [DOC] S2 |
| Invoiced and received quantity must match (the introduction states received equals invoiced and may differ from ordered). | [DOC] S1 |
| Partially received purchases appear under the "Awaiting Delivery" filter until marked received. | [DOC] S5 |
| Backorders: purchases created by the Reorder Backordered function link to the backordered sale; the Purchase Order Pending Report lists them with a stock-received flag. | [DOC] https://help.core.cin7.com/hc/en-us/articles/9034451767311-Purchase-Order-Pending-Report |
| Stock Received Not Invoiced and Stock Received vs Invoice reports are the audit views for receipts without invoices; a draft invoice counts for the latter. | [DOC] S45, S49 |

### 4.3 Quantity guards between order, invoice and receipt

| Rule | Source |
|---|---|
| Advanced: receipt above the PO quantity, or a product not on the PO, only asks for confirmation; below the PO quantity is silent. | [CLIENT] §4 |
| Advanced: once the invoice is authorised, receipt above invoiced minus already-received is refused; below it is allowed with a warning. | [CLIENT] §4 |
| Simple: differences between order and invoice or receipt are flagged; stock-first simple requires received equal to invoiced. | [CLIENT] §5.4, §8 |
| Put-away flow: the two stages must match per product, batch and expiry. | [CLIENT] §4 |
| CSV import: stock received must have the same products and the same total quantity per product as the invoice lines. | [DOC] S25 |

---

## 5. Line totals, tax, rounding, totals box

### 5.1 Formulas

| Item | Formula | Source |
|---|---|---|
| Line net unit | `net_unit = round(price * (100 - discount) / 100, 7)` (4 dp when a Xero integration is connected) | [CLIENT] §1.2; [DOC] S25 |
| Line total | `round(qty * net_unit, 2)` (corrected from `qty * price * (1 - discount%)`) | [CLIENT] §1.2; [DOC] S25 |
| Precision | price up to 7 decimals; quantity 4 decimals, range 0 to 10,000,000; discount 2 decimals on import (the page keeps 4); line total 2 decimals; import rate 5 decimals | [DOC] S25; [CLIENT] §5.2 |
| API decimals | totals and tax: up to 4 decimals; payment `Amount`: up to 2 decimals; payment `CurrencyRate`: up to 4 decimals | [API] S34 |
| Tax calculation method | Tenant setting. Row total: tax per row rounded to 2 dp, rows summed. Document total: tax per row rounded to 4 dp, rows summed, then the sum rounded to 2 dp. | [DOC] S36; [CLIENT] §1.2 |
| Tax exclusive | `tax = round(line_total * effective_rate, precision)` where precision is 2 (Row total) or 4 (Document total); `total = net + tax` | [CLIENT] §1.2 |
| Tax inclusive | line total is gross; the rate used is the inclusive effective rate, for a single rate `rate / (100 + rate)`; goods = `sum(total) - round(sum(tax), 2)` | [CLIENT] §1.2, §1.4; the single-rate form is [INFER] |
| Inclusive flag | one flag on the document header, from the tax rule (default exclusive); it governs every line even if lines carry different tax rules. Flipping it re-derives line tax from each line's own rule without converting prices. | [DOC] S26; [CLIENT] §1.8 |
| Tax rule priority | order line (if changed), sales channel, product, document header, then supplier | [DOC] S26 |
| `TaxCalculation` | API field, defaults to the tax rule's setting when omitted | [DOC] S24 |
| Line `Tax` can be sent in the API only when the purchase's tax rule is tax-inclusive | [DOC] S24 |
| Inclusive import validation | tax must have the same sign as the total and be smaller than it in absolute value | [DOC] S25 |
| Additional charges | same shape as lines (Description, Reference, Quantity, Price/Amount, Discount, Tax, TaxRule, Total; `Account` on invoice side); import total may be negative but not zero | [API] S34; [DOC] S25 |
| Totals box | `TotalBeforeTax = sum(line goods) + sum(charge goods)`; `Tax = round(sum(line tax), 2) + round(sum(charge tax), 2)`; `Total = TotalBeforeTax + Tax`. Always sum stored line values; never recompute from prices at document level. | [CLIENT] §1.4, §9 |
| Supplier-currency to base | `base_total = round(supplier_total * rate, 2)`; rate has 5 decimals, minimum 0.00001 | [CLIENT] §1.4 |
| Invoice amount fields | `InvoiceTotalAmount`, `InvoiceTotalTaxAmount`, `Paid` | [API] S34 |
| Invoice total check | the typed total must equal the computed one | [CLIENT] §1.5 |
| Amount due | `invoice total - sum(payments and allocated deposits)`. (corrected) Credit notes are not subtracted: Cin7 never links a credit note to its invoice, so the credit must first become a deposit and be applied. | [CLIENT] §1.5; [DOC] S19 |

The tax method decides per-line versus total rounding, resolving the earlier open question (section 12, item 8). The tenant default value is not stated; the sandbox default is Row total [ASSUME].

### 5.2 Worked example (made-up numbers, exclusive, 10% tax)

| Line | Qty | Price | Disc % | Net | Tax @10% |
|---|---:|---:|---:|---:|---:|
| A | 10 | 25.0000 | 10 | 225.00 | 22.50 |
| B | 4 | 12.3450 | 0 | 49.38 | 4.94 (4.938 under Row total; 4.9380 under Document total) |
| Freight (additional charge) | 1 | 40.00 | 0 | 40.00 | 4.00 |

Totals box: TotalBeforeTax = 225.00 + 49.38 + 40.00 = **314.38**; Tax = 22.50 + 4.94 + 4.00 = **31.44** (Document total: 22.50 + 4.938 + 4.00 = 31.438, rounds to 31.44: same here); Total = **345.82**. The two methods can differ by a cent on other data; see the client worked example (102.58 versus 102.59).

Inclusive variant: one line, gross 110.00 at 10%: tax = 110 * 10 / 110 = 10.00; net = 100.00.

Payments: prepayment 50.00 + payment 200.00 gives `CombinedPaymentStatus = PARTIALLY PAID`, due = 345.82 - 250.00 = 95.82. Pay 95.82 and it becomes `PAID` (on the next save). Pay 100.00 more and the list shows `OVERPAID` (corrected: `OVERPAID / CREDITED` is the credit-note-refund state); the client does not block it, and the invoice status stays AUTHORISED [DOC] S5; [CLIENT] §1.5.

### 5.3 Landed cost on the same example

Freight 40.00 on the invoice, with account = the products' inventory account (capitalised). The default distribution is by line value (share of invoice line cost). Goods value 274.38.

| Method | A | B | Unit cost A | Unit cost B |
|---|---:|---:|---:|---:|
| By value (Cin7 default for purchase additional costs) | 32.80 | 7.20 (remainder) | (225.00+32.80)/10 = 25.78 | (49.38+7.20)/4 = 14.145 |
| By quantity (manual journal Type) | 28.57 | 11.43 | 25.357 | 15.2925 |
| By weight, A 2 kg ea, B 5 kg ea (manual journal Type) | 20.00 | 20.00 | 24.50 | 17.345 |

Rounding remainder inside one purchase: not documented; the sandbox rounds shares to 2 decimals and puts the remainder on the last line [ASSUME]. (When expenses are distributed across several documents with Auto-allocate, the client gives the remainder to the largest allocation [CLIENT] §6.)

---

## 6. Additional costs, landed cost, deposits, payments

### 6.1 Additional costs and landed cost

| Rule | Source |
|---|---|
| Additional costs are lines on the invoice (and order/credit note) with their own account, tax rule, quantity, price, discount. | [API] S34; [DOC] S2 |
| Choice of capitalising: if the cost line's account equals the products' inventory account the cost is added to product cost and raises stock value; any other (expense) account keeps it out of product cost and posts it as an expense. | [DOC] S15, S16, S17 |
| An additional cost on an asset-class (non-fixed-asset) account must use an account that also appears on the invoice's product lines, else authorisation is blocked. | [CLIENT] §2.4, §6 |
| Default distribution of additional costs on a purchase is by product value: proportional to each invoice line cost to total invoice amount, not weight or unit count. | [DOC] S15, S16, S17 |
| (corrected) Other bases are available on a **manual journal** on the purchase; its `Type` selects the basis: Cost, Quantity, Weight, Volume, or Manually. Quantity, weight and volume are available for purchases and stock transfers; Cost also for assemblies and production runs. The older COGS introduction still says cost-only for purchases and assemblies; the newer landed-cost articles and the process article supersede it. | [DOC] S2, S15, S16 vs S17 |
| Weight and volume need product weight and dimensions configured. | [DOC] S15, S16 |
| For a manual journal to capitalise, its debit account must equal the inventory account of the item lines; otherwise it is a business expense. | [DOC] S15, S42 |
| Manual journals can be added only after the sale or purchase invoice is authorised; the journals are always in base currency and cannot be added when Xero is the accounting system (managed there). | [DOC] S15, S42 |
| Type Manually: save, press View more, enter an amount per invoice line; the per-line amounts must sum to the journal amount. | [DOC] S15; [CLIENT] §6 |
| Costs from a separate (e.g. freight-forwarder) invoice: enter a blind-receipt simple or service purchase with an expense account, authorise, then use Expenses, +Allocation and either type amounts or Auto-allocate (proportional to invoice cost) to purchases, stock transfers, assemblies or production runs. | [DOC] S15, S16 |
| Allocated expense increases stock-on-hand value. | [DOC] S15 |
| If landed cost is added after goods already sold, a second COGS journal is created, effective on the landed-cost authorisation date. A single COGS journal combines the invoice, manual journal and allocated landed costs when the sale ships afterwards. | [DOC] S15, S16, S17 |
| Verify an Invoice and Verify an Order are estimators only: they show cartons, volume and freight per line, post nothing and create no journals. | [DOC] S2; [CLIENT] §3.2 |
| API: `ManualJournals` lines are `Reference, Amount, Date, Debit, Credit, IsSystem`. | [API] S34 |
| Schema flags: `HasDistributeExpense`, `AllowAddDistributeExpense`, credit-note equivalents. | [API] S33 |
| System journals for accrual, goods in transit and inventory discrepancy cannot be edited or deleted. | [CLIENT] §6; [DOC] S9 |

### 6.2 Deposits and prepayments

| Rule | Source |
|---|---|
| A deposit account is required: a current-asset account that accepts payments, mapped under account mapping. | [DOC] S18; [CLIENT] §2.4 |
| A deposit can be added from an authorised purchase order, from a credit note/refund ("+ Supplier Deposit", on a purchase with an authorised, paid invoice), or from Spend Money (not tied to a purchase). | [DOC] S18 |
| On authorising a PO that holds a deposit: Dr Supplier Deposits, Cr Bank for the deposit amount, dated at the deposit date. Nothing is posted if no deposit is attached. | [DOC] S10 |
| When the supplier invoice is authorised, an unused deposit linked to this purchase prompts "allocate to invoice"; any other of the supplier's deposits can be applied through "+Use Supplier Deposit" once the invoice is authorised. | [DOC] S2, S3, S18; [CLIENT] §2.4 |
| When a deposit is applied, Accounts Payable is reduced by the amount applied. | [DOC] S10, S18 |
| The allocation must be above zero and no more than the amount still due. | [CLIENT] §2.4 |
| A deposit locks the supplier field of the purchase, and an order that holds a deposit cannot be archived. | [CLIENT] §2.3, §2.4; [DOC] S8 |
| API: payment `Type = PREPAYMENT` is recorded on the order; `DepositID` links a deposit. | [API] S34 |
| Supplier deposits list: Purchases, Supplier Deposits; shows amount and remaining balance. | [DOC] S18; [CLIENT] §5.1 |
| Cash refund of an unused deposit: no documented step. | section 12, item 13 |

### 6.3 Payments

| Rule | Source |
|---|---|
| Payments apply to authorised invoices only; rejected orders cannot take payments. Regular payments belong on the invoice, not the order deposit area. | [DOC] S2, S3, S21; [CLIENT] §2.4 |
| Payment fields: Reference, Amount (2 dp), DatePaid, Account (bank), CurrencyRate (4 dp in the API, required), Type. | [API] S34 |
| Amount is only required-field validated in the client: 0 and amounts above the due are accepted. | [CLIENT] §5.2 |
| Bulk Supplier Payments settles several invoices for one supplier; needs a Conversion Rate when the supplier currency differs from base; unallocated remainder shows at the top of the outstanding-invoice grid; bulk payments do not change payments saved on individual invoices; separate permission. | [DOC] S20, S27 |
| `CombinedPaymentStatus`: UNPAID (no payment), PREPAID (prepayment before invoice), PARTIALLY PAID, PAID, OVERPAID (list page) / OVERPAID / CREDITED (API). | [API] S34; [DOC] S5 |
| Invoice becomes PAID only when the balance is exactly zero at the next save; an over-payment leaves it AUTHORISED. | [CLIENT] §1.5 |
| Overpaying a **sale** invoice is prohibited because it breaks accounting sync; the purchase side has no equivalent statement. | [DOC] S38 |
| Xero: purchase payments sync only after the invoice synced; a Xero credit-note allocation does not sync back. | [DOC] S44 |

---

## 7. Credit notes, returns, refunds

| Rule | Source |
|---|---|
| A credit note corrects an authorised invoice: single line, part or whole shipment, or a post-invoice discount. | [DOC] S13 |
| In advanced, the "Credit Note for" field picks the invoice and copies its lines. | [DOC] S3 |
| Price-only credit: enter the price difference and quantity; on authorise delete the restock line so stock is unchanged. | [DOC] S13 |
| A post-invoice discount is entered as an additional-costs line with the discount value, the correct account and tax rule; stock is unchanged. | [DOC] S13 |
| Authorising a credit note that changes a quantity prompts an Unstock; the unstock quantity is editable (you may keep items the supplier did not ask back). | [DOC] S13 |
| Unstock fails if stock is not on hand (already sold, moved, adjusted). Workaround: authorise the credit note with unstock lines removed, then write the items off by stock adjustment. | [DOC] S13, S14 |
| (corrected) A credit note line quantity cannot exceed the invoiced quantity (cumulative across credit notes on the same invoice), and unstock cannot exceed the credited or the received quantity. CSV import enforces the same for credit lines. | [CLIENT] §2.4; [DOC] S25 |
| Void of a credit note is refused if putting its stock back would make stock on hand negative. Voiding it does not void the purchase. | [DOC] S13 |
| A credit note cannot be shown on the supplier's purchase order document; use the PO memo. Standalone credit notes have a credit memo field on the Purchase Return template. | [DOC] S13 |
| Settle by refund (Refund button, `Type = REFUND`, cash) or keep as supplier deposit for future purchases. Refunds are applied to authorised credit notes like payments to invoices. | [DOC] S3, S13, S18 |
| Cin7 does not auto-link a purchase credit note to the invoice it offsets: add the credit as a supplier deposit, then use "+Use Supplier Deposit" on the invoice. | [DOC] S19, S44 |
| One credit note per simple purchase; many need advanced. | [DOC] S3, S13 |
| Unstock is never required on drop-ship or job-linked purchases. | [CLIENT] §8.1; [DOC] S23 |
| Xero: authorised credit notes export; refunds created in Xero do not sync back. | [DOC] https://help.core.cin7.com/hc/en-us/articles/13000995426575-Sync-credit-notes-and-refunds-with-Xero |

---

## 8. Journals per step (summary level)

Cin7 posts accounting entries only when: a purchase or sale invoice/credit note is authorised, an order or quote carrying a deposit is authorised, a manual journal is authorised, a stock adjustment/write-off or similar is completed, or any of these is undone/voided. Stock receipt itself posts nothing, unless accrual or stock in transit is enabled. [DOC] S9, S10.
Accounts involved: Inventory control, Accounts Payable, Tax, optional expense, and the Supplier Deposits account. [DOC] S10.
A credit note posts the same accounts as the invoice with negative amounts rather than flipped sides. (corrected presentation) [DOC] S10.

| Step | Default (no accrual) | With Inventory Accrual (Stock first) | With Stock In Transit (Invoice first) | Source |
|---|---|---|---|---|
| Order authorise | none; with a deposit: Dr Supplier Deposits, Cr Bank at the deposit date | same | same | [DOC] S10, S18 |
| Stock authorise | none | Dr Inventory, Cr Inventory Accrual (GRNI), amount = PO cost value else average cost, dated stock received date; system manual journal, not deletable | Dr invoice accounts (inventory), Cr Stock In Transit, dated the latest received date; system manual journal | [DOC] S9 |
| Invoice authorise | Dr Inventory control (lines + capitalised charges) and Dr expense lines, Dr Tax (input), Cr Accounts Payable; then Dr Accounts Payable, Cr Supplier prepayment for any deposit applied | Reverses the accrual (Dr Inventory, Cr GRNI, negative amount, invoice date) and posts the normal invoice: Dr Inventory, Cr Accounts Payable. (corrected) No separate price-variance line is documented; the difference falls out of the two cost movements. | Asset-class accounts on the invoice are replaced by Stock In Transit: Dr Stock In Transit (GINR), Cr Accounts Payable. After stock is authorised, invoice-line accounts cannot be changed without Undo. | [DOC] S9, S10 |
| Payment | Dr Accounts Payable, Cr Bank | same | same | [DOC] S10 |
| Credit note authorise | invoice entries with negative amounts (Inventory, Tax, Payable) | same | same | [DOC] S10 |
| Unstock authorise | quantities only; its accounting rides on the credit note | same | same | [DOC] S13 |
| Refund | Dr Bank, Cr Accounts Payable | same | same | [INFER] |
| Drop-ship invoice | adds Dr COGS, Cr Inventory control at the invoice date | same | n/a | [DOC] S10, S17, S23 |
| Manual journal (landed cost) | Dr Inventory control (capitalised) or Dr expense, Cr the journal's credit account (for example an overhead account), at the manual journal date | same | same | [DOC] S10, S15 |
| Sale ship (not purchase) | Dr COGS, Cr Inventory at the ship date | | | [DOC] S10, S17 |
| Undo/Void | reverses the entries of that step (accrual journals are deleted automatically on Undo) | | | [DOC] S9, S10, S11 |

Accrual notes: the accrual journals are added automatically to the purchase, cannot be deleted by hand, and export to Xero/QuickBooks regardless of manual-journal authorisation. The accrual ignores additional costs. All cost movements show on the product's Movements tab. [DOC] S9.

The mapping of inventory cost to the account is the product's inventory account; the document default is `InventoryAccount` / `DefaultAccount` on the header. [API] S34.

---

## 9. Drop ship

| Rule | Source |
|---|---|
| Product must be set Always Dropship or Optionally Dropship and have at least one supplier on its Suppliers tab; exactly one supplier is ticked as the drop-ship supplier. Users need the Products permission to enable drop ship. | [DOC] S23 |
| Authorising the sale order generates the purchase order(s). For Optionally Dropship products the box is ticked automatically when there is no stock on hand; tick it manually otherwise, before authorising. | [DOC] S23 |
| The sale's Related Orders tab links to the purchases; the purchase carries `RelatedDropShipSaleTask`; list rows carry `DropShipTaskID` (filterable). | [DOC] S23; [API] S34 |
| Pick, Pack and Ship are not available on a drop-ship sale. | [DOC] S23 |
| The generated purchase is a simple purchase with no cloning, blind receipt, input method, stock receipt/put-away or unstock. | [DOC] S23; [CLIENT] §8.1 |
| (corrected) COGS on the sale is generated when the **purchase invoice is authorised**, dated at the supplier invoice date (Dr COGS, Cr Inventory control); order authorisation and receipt generate none. Until the invoice is authorised the COGS is 0 even if goods were delivered. A report FAQ saying "once fulfilled" is looser wording. | [DOC] S10, S17, S23 vs S47 |
| Stock effect: there is no receipt step, so On Hand is untouched by the purchase; cost reaches COGS directly from the invoice. | [DOC] S10, S23; [INFER] |
| Undoing the sale deletes the unauthorised drop-ship purchases created for it; the effect of voiding the sale on an authorised purchase is not documented. | [DOC] S11 |
| Converting a simple drop-ship purchase to advanced needs Purchase: Authorize Order, is irreversible, and still leaves some features unavailable. Advanced drop-ship hides receiving, clone and Mark as received. | [DOC] S3, S23; [CLIENT] §8.1 |
| Drop-ship Undo needs the order to be complete; Clone only when the invoice is complete. | [CLIENT] §8.1 |
| Page route `/DropShipPurchase` renders the same task header and tabs as `/Purchase`, minus stock and unstock. | [API] S33; [CLIENT] §8.1 |

---

## 10. Currency, exchange rate, supplier defaults

### 10.1 Currency

| Rule | Source |
|---|---|
| Supplier currency differing from base: Cin7 fetches the rate (an external rate provider) effective at document creation; the user may overwrite it with the actual rate. A supplier has exactly one currency. | [DOC] S27, S37 |
| The document shows both the supplier-currency total and the base total. Line prices are in the document (supplier) currency; static price tiers are not converted. | [DOC] S37 |
| Rate convention: base-currency units per one supplier-currency unit. Field `CurrencyRate` (header) / `CurrencyConversionRate` (schema). | [API] S34, S33; [CLIENT] §1.6 |
| The rate is re-fetched when the supplier changes to one with another currency, on the rate button, and when an unauthorised invoice date changes; the invoice then keeps its own editable rate until authorised. A failed fetch asks for a manual rate. | [CLIENT] §1.6 |
| Header carries `BaseCurrency` and `SupplierCurrency` (3 chars). | [API] S34 |
| Payment `CurrencyRate` is required and may differ from the invoice rate; bulk payments require a rate for foreign suppliers. | [API] S34; [DOC] S20 |
| The rate is sent to the connected accounting system. The base currency cannot change once a transaction exists. | [DOC] S37 |
| FX gain/loss: a Realized Currency Gains account is required for multi-currency accounting. A period report shows realised gain or loss for settled invoices, and an optional setting adds an unrealised exchange adjustment at period close, one manual journal per currency. The per-payment posting formula is not published; sandbox: Dr/Cr Realized Currency Gains for the difference between invoice-rate and payment-rate base value. | [DOC] S40, S41; [ASSUME] for the payment-level posting |

### 10.2 Supplier defaults filling a new purchase

| New-purchase field | Fills from | Source |
|---|---|---|
| Supplier name | supplier record, editable | [DOC] S2, S27 |
| Contact, Phone, billing address | cleared when the supplier changes, restored when the original supplier is re-picked | [CLIENT] §3.1 |
| Terms (`Terms`, `TermDays`, `TermMethod`) | supplier payment term (or the only term, else blank); sets invoice due date | [DOC] S2, S27; [CLIENT] §3.1 |
| Tax rule (`TaxRule`, `TaxPercent`, `TaxInclusive`) | supplier tax rule (or the only rule, else blank) | [DOC] S26, S27; [CLIENT] §3.1 |
| Accounts payable / inventory account | supplier account and `DefaultAccount` | [DOC] S27 |
| Currency and rate | supplier currency; rate at creation date | [DOC] S27, S37 |
| Discount | supplier standing discount, applied to **new** lines only; existing lines keep theirs | [DOC] S27; [CLIENT] §3.1 |
| Internal memo | supplier comments | [CLIENT] §3.1 |
| Location | not a supplier field; the document-level location is untouched by a supplier change | [DOC] S27; [CLIENT] §3.1 |
| Line price | fixed supplier price (product Suppliers tab) or last/latest supplier price, chosen by setting; neither may be 0 | [DOC] S2, S8, S48 |
| Line tax rule | product tax rule, header inclusive flag overrides | [DOC] S26 |
| Price tier | not a purchasing concept; the supplier record has no price tier | [DOC] S27 |
| (corrected) Changing supplier | overwrites price and supplier SKU on every order, invoice, put-away and stock line from the new supplier's price list; products it does not list get blanks | [CLIENT] §3.1 |
| New supplier form defaults | Settings -> Reference books -> Default Field Values | [DOC] S27, S31 |
| Product search limited to supplier products | setting "Limit product search by supplier" | [DOC] S2, S8 |

---

## 11. Settings that change purchase behaviour (names only; see `rules/settings.md`)

| Setting (UI name / schema field) | Effect | Source |
|---|---|---|
| Default purchase method: Stock first / Invoice first (`DefaultPurchaseMethod`) | Default `Approach` on new purchases | S8, S33 |
| Enable accrued inventory transactions, Inventory Accrual (GRNI) account, Stock In Transit (GINR) account | Enable accrual (Stock first) and transit (Invoice first) postings; accounts distinct, current asset/liability and asset, non-system, non-payment | S8, S9 |
| Purchase put-away (`UsePurchasePutAway`) | Splits receiving into receive + put away (advanced / WMS) | S8, S22 |
| Order approval (`IsOrderApproveEnabled`) | Adds Approve/Reject after Authorise | S8, S21 |
| Default load advanced purchase order | New purchases open as advanced | S8 |
| Enable archiving and archive period (`IsArchiveEnabled`) | Archive action on unauthorised orders without a prepayment | S5, S8, S33 |
| Default supplier price: fixed or latest | Line price fill | S2, S8 |
| Limit product search by supplier | Line product picker | S2, S8 |
| Line sort order for purchase documents | Display order: entered, SKU or name | S8 |
| Default attribute set; additional email attachments | Custom fields on the Logs tab; attach product and supplier files to purchase emails | S2, S8 |
| Reorder minimum scope (all units or each location) | Reorder triggers per product total or per location | S8, S43 |
| Tax calculation method (`TaxCalculationMethod`), tax rule inclusive flag | Totals maths: Row total vs Document total | S36, S33, S26 |
| Default account (`DefaultAccount`) | Header inventory account | S33 |
| Lock date (`LockDate`) | No transaction dated before it can be added, edited or deleted; synced from Xero/QuickBooks when connected; client blocks payment delete and cost-line edits on authorised purchases | S39, S33; [CLIENT] §2.4 |
| Accounting dimensions (`IsAccountingDimensionsEnabled`) | Dimensions on lines/payments; supplier data outranks product data on purchases | S33; https://help.core.cin7.com/hc/en-us/articles/9034429852047-Accounting-Dimensions |
| Permissions: Order view/authorise, Bill/credit note view/authorise, Stock received view/authorise, Edit authorised documents, Undo, Void, Approve/reject/review, Fixed asset, Financial data, Supplier payment, CSV import | Gate every transition above | S2, S32, S33 |

---

## 12. Unclear / docs disagree

Each of the 22 original items is resolved (struck through, answer in the named section) or kept open with the exact reason. Items 23 and after are new findings from the full read.

1. ~~**Help center not read directly.**~~ Resolved: the whole help center was read; tags above reflect it. Server-only behaviour is the remaining gap.
2. **Status precedence.** Still open. The help center gives overlapping definitions (S6) and the page script only maps the server-set label (client §2.1), never computing it. Section 3.2 stays [ASSUME]. Mitigation: the list exposes separate invoice, stock and payment columns (S5).
3. ~~**`PAID` as a status.**~~ Resolved (3.1, 3.2): PAID is an invoice and accounting-view status and a payment-status word; it is not a whole-purchase `Status` value.
4. **`RestockReceivedStatus` vs `StockReceivedStatus`.** Still open, low impact: no article or script distinguishes them; the sandbox treats them as one field (the page uses `StockStatus`).
5. ~~**"Revert".**~~ Resolved (3.3): it is the client's wording inside the Undo confirmation, not a separate action.
6. ~~**Exact error texts.**~~ Resolved for everything the page shows (3.6). Open only for messages generated by the server alone; the help center quotes none for purchases.
7. ~~**Undo preconditions.**~~ Resolved (3.3): a purchase cannot be undone once its goods were sold, transferred or consumed; the invoice Undo checks accounting export and closed periods; the client refuses Undo/Void while a linked authorised credit note exists and warns allocated payments go.
8. ~~**Tax rounding.**~~ Resolved (5.1): a tenant tax-calculation method picks Row total (2 dp per row) or Document total (4 dp per row, sum rounded); line totals round to 2 dp from a 7-dp net unit. Only the tenant's default method is unknown ([ASSUME] Row total).
9. ~~**Landed cost basis.**~~ Resolved (6.1): manual journals offer Cost, Quantity, Weight, Volume and Manually on purchases; the COGS introduction's cost-only statement is stale. Omni rules are not used.
10. **Rounding remainder in allocation.** Partly resolved: cross-document Auto-allocate gives the remainder to the largest allocation (client §6). Within a single purchase, allocation is server-side and unpublished; sandbox puts the remainder on the last line [ASSUME].
11. ~~**Receiving before invoice cost.**~~ Resolved (4.1): cost is set on invoice authorisation; accrual-on receipts use PO cost else average cost; the third-party chain is withdrawn.
12. ~~**GL journals for accrual and transit.**~~ Resolved (8): the accrual and transit tables come from the help center's own example (S9), including the reversing entry.
13. **Deposit cash refund.** Still open: help covers using a deposit against invoices and turning a credit note into a deposit, and a separate money-in page only points back to deposits. No step returns a deposit to the bank.
14. **Supplier overpayment.** Partly resolved: the client accepts payments above the amount due and leaves the invoice AUTHORISED; the list shows an Overpaid word (S5, client §1.5). Sale overpayments are prohibited (S38), but no article says the same for purchases, and the posting is unpublished. Sandbox allows it.
15. **FX gain/loss.** Partly resolved (10.1): the account, the period report and the optional unrealised adjustment are documented; the per-payment posting amount is not. Sandbox assumes realised gain/loss on the base difference.
16. ~~**Supplier defaults.**~~ Resolved (10.2): the supplier form has no location and no price tier; it supplies currency, term, payable account, tax rule, status, carrier, tax number, standing discount and comments.
17. ~~**Drop-ship receiving.**~~ Resolved (9): no receiving, no unstock; COGS at purchase invoice authorisation; the invoice attaches like any purchase invoice. Only the effect of voiding an already-invoiced sale remains undocumented.
18. ~~**Credit note over-quantity.**~~ Resolved (7): capped by invoiced quantity (cumulative) in the client and the CSV import.
19. ~~**Lock date.**~~ Resolved (11): no add, edit or delete before the lock date; the client blocks payment deletion and cost-line edits on authorised purchases.
20. **Merge rules.** Still open. The help center says merging same-supplier purchases is irreversible and has "several restrictions" without listing them (S12); the client shows the permission and confirm texts only. An earlier note that purchases with invoice or stock lines cannot be merged is not found anywhere in the help center and is dropped as unverified.
21. ~~**Convert simple to advanced.**~~ Resolved (1, 3.3): irreversible, any stage, confirm prompt, header carries over; child statuses become draft where lines exist. Authorised parts are not undone.
22. **Order approval and permissions.** Still open: no source states whether the approver must differ from the authoriser; the approval permission is separate from authorise.

New findings:

23. **Mark as Closed versus unpaid invoice.** The FAQ says an open, unpaid invoice blocks closing; the client check rejects only invoices not authorised, paid or voided. They differ for an authorised-but-unpaid invoice. Open. Sandbox follows the client (authorised unpaid allowed) [ASSUME].
24. ~~**Drop-ship COGS timing, two wordings.**~~ Resolved (9): three articles agree on purchase-invoice authorisation; one report FAQ says "fulfilled".
25. ~~**Approval timing wording.**~~ Resolved (3.5): approval follows authorisation (process articles and client); the settings description is looser.
26. ~~**Credit note against invoice amount due.**~~ Resolved (5.1, 7): not auto-linked; convert to deposit and apply.
27. **Default tax calculation method and default approach** for a brand-new tenant are not stated in any article. Open; sandbox defaults are Row total and Stock first [ASSUME].
