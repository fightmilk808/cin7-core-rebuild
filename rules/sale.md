# Sale business rules (Cin7 Core)

Rules spec for the sale module of the sandbox. Structure map (screens, fields, tables) lives in `spec/modules/06-sale/`; this file adds behaviour.
Settings that change behaviour are named here and defined in `rules/settings.md` (written separately).

Source: the public Cin7 Core help center, read in full (all sale, fulfilment, returns, pricing, tax, costing, accounting, customer, settings and API-reference articles), plus the API operation map, the repo spec and the client-script notes in `rules/sale-client.md`. Nothing was written to Cin7.

A sale is labelled by its customer reference, falling back to its `SO-` number: `coalesce(nullif(trim(CustomerReference), ''), SaleOrderNumber)`. The `SO-` number stays the join key and secondary text.

## Conventions

- Source tags: every rule ends in a tag. `[DOC Sn]` = stated in the full help-center article with that number in section 14. `[API]` = stated in the API reference pages (S12 and its sub-pages) or the API map. `[CLIENT §x]` = settled by the page-script findings in `rules/sale-client.md` (section number given). `[SPEC]` = repo spec. `[OBS]` = distinct values seen on a live account (enum values only, no business data).
- `(corrected)` = the earlier excerpt-based draft was wrong or incomplete and this version fixes it. `(inferred)` = follows from documented behaviour but no source states it.
- "Authorise" is Cin7's UI verb ("Authorize" in US help text). API enum spelling is `AUTHORISED`.
- Dollar figures in worked examples are made up.

## ⚠️ Gotchas: the sneaky stuff

Ranked worst first (data loss and money first, display quirks last).

> [!CAUTION]
> **Voiding a sale that has a payment deletes its financial transactions and refunds nothing**
>
> Void is permanent: the quote, order, pick, pack, ship, invoice and payment records go, and the sale can never be re-authorised. The confirm box itself warns that an existing payment is not refunded [DOC S17] [CLIENT §2.5]. Undo is the reversible one. [details](#43-transition-table-quote-and-order)

> [!CAUTION]
> **Undo on an invoice removes its allocated payments (after a confirm), but is refused with a linked authorised credit note or a consolidated accounting export**
>
> (corrected) The earlier draft said payments block the Undo; they do not, they are deleted. Undo is blocked when an authorised credit note is linked to the invoice, and impossible for invoices rolled into a consolidated Xero daily invoice [CLIENT §2.5] [DOC S18]. [details](#45-transition-table-invoice)

> [!CAUTION]
> **A period lock date blocks add, edit and delete of any transaction dated before it, so default dates can trap you**
>
> Ship, invoice, payment, credit note and every Undo/Void post or reverse transactions with an effective date. If that date is before the lock date the action fails, and the default ship date (today, or the invoice date if that setting is on) may already be in a locked period; the user must enter a later date. The lock date syncs from Xero or QuickBooks [DOC S27, S43]. [details](#10-gl-journals-summary-level)

> [!CAUTION]
> **Only Ship moves stock; Pick and Pack do not**
>
> Pick allocates stock but records no stock movement, and Pack neither; OnHand drops and COGS posts only when Ship is authorised [DOC S5, S20, S21]. Ship (and its Undo/Void, and invoice authorisation) is blocked while a stocktake runs in the location. [details](#44-transition-table-fulfilment-pick-pack-ship)

> [!CAUTION]
> **COGS is 0 until cost is known, and old COGS is never rewritten**
>
> Cost is the actual purchase cost from the authorised purchase invoice, not average cost; if that invoice is not yet authorised COGS at ship can be 0, and later cost events add extra transactions instead of editing old ones. Drop-ship COGS appears only at purchase-invoice authorisation. The report filter "All COGS" shows 0 for unshipped sales [DOC S7, S21, S27, S45]. [details](#52-effects-per-transition)

> [!CAUTION]
> **Authorising with short stock always succeeds, bulk authorise silently backorders, and automatic fulfilment never restarts**
>
> A dialog offers split, backorder or purchase order, but authorisation is always allowed. The bulk "Authorize Order" action backorders without ever splitting; the API silently creates a backorder; and an order under automatic fulfilment does not start the chain when stock arrives, so it must be authorised by hand. Related: authorising a quote reserves nothing, and the whole order is allocated at order authorisation unless allocation is optional (then the Authorise button gets a no-allocation variant and allocation waits for Pick) [DOC S1, S3, S8, S34] [API] [CLIENT §2.3]. [details](#53-backorders-splits-partial-fulfilment)

> [!WARNING]
> **Overpayment is forbidden because it breaks accounting sync, yet OVERPAID exists**
>
> (corrected) Three articles forbid it; the three that say "not forbidden" read as a typo (they give the same two workarounds). Record the excess as a customer credit. OVERPAID and OVERPAID / CREDITED remain valid payment statuses for data that arrives from elsewhere [DOC S1, S32, S33, S9]. [details](#46-transition-table-payment-deposit-refund)

> [!WARNING]
> **A credit note does not return stock; Restock is a separate authorisation with its own caps**
>
> Credit note and restock authorise independently and in any order. Restock cannot exceed the credited quantity or the shipped-and-not-yet-restocked quantity, and voiding a credit note is refused if removing its restock would drive stock negative [DOC S6] [CLIENT §2.4]. [details](#47-transition-table-credit-note-and-restock)

> [!WARNING]
> **Invoice lines are not frozen: quantities are, but price, discount, tax rule and account can be edited**
>
> (corrected) The earlier draft said lines "cannot be changed". Items and quantities are copied from the order and locked; to change those you must Undo the order [DOC S33]. [details](#45-transition-table-invoice)

> [!WARNING]
> **Discounts do not simply stack**
>
> Only one product discount applies at a time (individual customer, then customer group, then product). A customer percentage discount stacks only when "Apply customer discount after other discounts" is on; otherwise the lower resulting price wins. The order-line discount always applies last, and a quantity-based % applies to the total quantity [DOC S29, S39]. [details](#72-discounts)

> [!WARNING]
> **Tax rule priority is line, channel, product, header, customer, and the header inclusive flag overrides the lines**
>
> If lines carry different tax rules, the header's tax-inclusive or exclusive setting applies to the whole order. A line's tax percent comes from the rule's inclusive or exclusive percent, not its headline rate [DOC S30] [CLIENT §1.4]. [details](#73-tax)

> [!WARNING]
> **The credit limit only warns unless the user lacks one permission, and 0 means no limit**
>
> Authorising over the limit or on credit hold asks to confirm and can be bypassed; users without Sale Task - Ignore Mandatory Credit Limit are blocked. (corrected) The "limit cannot be 0" lines are leftovers from the grace-period text; 0 and blank both mean no limit [DOC S31, S14] [CLIENT §4.3]. [details](#8-customer-defaults-and-credit-control)

> [!NOTE]
> **Static price tiers are not currency-converted, custom prices beat tiers, and the sale's tier beats the customer's**
>
> A static tier of 200 shows 200 in any customer currency, while a calculated tier converts its base value at the current rate before the markup. (corrected) Custom per-customer prices are documented to take precedence over tier prices [DOC S15, S40]. [details](#71-price-tier)

> [!NOTE]
> **COMPLETED means shipped and paid; the displayed status depends on the tab-order setting**
>
> (corrected) The API derivation and the list description both require a zero balance; only one filter-table line says payment "may or may not" be made, and the earlier "observed COMPLETED but UNPAID" claim could not be re-checked. In the UI, which of Picking or Invoicing shows first depends on "Show invoice tab before fulfillment tab" [DOC S9] [API]. [details](#42-combined-sale-status-the-status-shown-on-the-sale)

## 1. Labelling and numbering

| Rule | Detail | Src |
|---|---|---|
| Sale label (sandbox rule) | Label = `coalesce(nullif(trim(CustomerReference), ''), SaleOrderNumber)`. Cin7 itself shows `Order #` as a default lead column and `Ref` beside it; the sandbox deliberately inverts that. The `SO-` number stays the join key and secondary text. | house rule; DOC S9 |
| Customer reference | Free text on the sale header (API `CustomerReference`, UI "Reference"), max 256 characters in the API. Typically the customer's own PO number. Searchable in the sales list (General search covers Order number, To, Contact, Phone, Email, Ref, Documents, Carrier, Tracking Numbers, Shipping Line 1, Sale Rep, Location; the API `search` covers OrderNumber, Status, Customer, invoiceNumber, CustomerReference, CreditNoteNumber). Custom filter "Customer reference": equals, contains, does not contain, empty, not empty. Nothing in the docs or the page scripts enforces uniqueness, so treat it as not unique. It stays editable after authorisation until the sale is voided or read-only (the separate "Purchase order reference" locks once an invoice is authorised). | DOC S9, S10, S12; CLIENT §2.3, §7 |
| Comments / Note | Separate from reference, max 1024 characters in the API. Pre-filled from the customer's Comments; shows on quote, order and invoice. Cin7 suggests putting reference numbers here because it is searchable. | DOC S1, S10, S12; CLIENT §3.1 |
| Document numbers | Order, invoice, credit note, fulfilment numbers are generated by the server (the page shows `Not assigned` until saved); prefix, suffix and starting number are configurable (Settings > General settings > Document numbers). Setting "Assign invoice number": `On sale creation` (number exists as soon as the order exists) or `On invoice authorization` (number only after the invoice is authorised). Default prefixes and padding are not documented (commonly `SO-`, `INV-`, `CN-`; unverified). | DOC S3, S11; CLIENT §0, §7 |
| Fulfilment number | Integer per sale (`FulfillmentNumber`), 1..n for advanced sales; one fulfilment for a simple sale. The standalone credit-note sale uses a fixed sentinel. | DOC S2, S5, S9; API; CLIENT §2.2, §4.4 |
| Quote number | Quotes have their own number (`QuoteNumber`); the Accounting tab lists "estimate number" as a document number alongside invoice and credit note numbers, one line each. (corrected from inferred) | DOC S9; SPEC |
| Credit note numbers | `CreditNoteNumber` assigned when the credit note is **authorised**, not when drafted. | DOC S6 |

## 2. Sale types

| Type | API `Type` | Created from | Stock lines | Fulfilment | Invoices | Credit notes | Notes | Src |
|---|---|---|---|---|---|---|---|---|
| Simple sale | simple | Sales > + > Simple sale | yes + additional charges | exactly one Pick/Pack/Ship | exactly one | exactly one | Default type unless setting `Default load advanced sale order` is on (that also makes every integrated-channel sale advanced). Tabs: Quote, Order, Invoice/Fulfilment (order of last two switchable), Credit Note. Can be **converted** to advanced; conversion is irreversible and allowed at any point in the process. | DOC S1, S2, S3, S37 |
| Advanced sale | advanced | + > Advanced sale, or Convert | yes | many fulfilments (each with Pick/Pack/Ship) | many; each invoice can cover one, several, or no fulfilments (`LinkedFulfillmentNumber`) | many (per invoice) | Sidebar layout. Stays `ORDERED`/`BACKORDERED` in the General list until completed, then `COMPLETED`. Extra actions: Mark as Fulfilled, Mark as Closed. Partial pick/pack/ship statuses are not shown as `PICKING` etc. in the General tab (hover the icons instead; the Fulfilment tab shows partial states). Clone from the menu next to the order number. | DOC S2, S9, S36 |
| Service sale | service (`ServiceOnly=true`) | + > Sale service | no: only service/non-inventory items selectable | none (Pick/Pack/Ship absent; fulfilment icon grey) | one (invoice tab) | yes | Quote lines then invoice. "Skip quote" goes straight to the invoice tab where lines are entered directly (no order step; order icon grey). Customer credit allowed on Quote and Invoice tabs. Bulk "Authorize Order" skips service-only sales. | DOC S4, S9, S34 |
| Sale credit note (standalone) | credit note | New > Sale Credit Note | refund/service item | none | none | the document itself | Needs a service/non-inventory "Refund" product to exist. No linked order. Status `REFUNDED` when fully refunded (credit notes inside a sale show `PAID`). Has a Credit Memo field that prints on the Sale Return template (credit notes inside a sale cannot print a memo; use the order memo). | DOC S6, S9 |
| Drop-ship lines | n/a (line flag `DropShip`) | product setting Always/Optionally Dropship | line only | Pick/Pack/Ship tabs unavailable for the sale; fulfilment icon grey | normal | normal | See section 9. | DOC S7 |
| Recurring sale/invoice | n/a (`IsRecursive`, `Frequency`, `NextInvoiceDate`, `TermDueNextMonth`) | "Recurring task" box on header | | | invoice generated on schedule | | Frequencies: weekly, fortnightly, monthly, quarterly, half-yearly, annual. New orders are generated every interval counted from the invoice date, never in the past: a past-due next date snaps to the nearest future interval. Sales > Recurring sales lists them and "Create Invoices" generates one early. Price source set by `Recurring invoice price` (`Copy previous price` default, or `Use product price`). Needs the Sales List & Tasks permission. | DOC S3, S35 |
| Preset (template) | n/a | Save as preset on a draft, then pick a preset on a new sale | any | | | | Copies customer, accounting, shipping/billing, lines and quantities; presets with stock lines applied to a service sale copy only the header details. Not periodic, unlike recurring. | DOC S36 |

Type rules:
- Simple -> advanced is one-way. Advanced -> simple is not offered. [DOC S2]
- Service sale cannot contain stock items; stock sale additional-charges section accepts only service/non-inventory items (advanced invoices: service type only). [DOC S2, S4]
- Quote approval applies to simple, service and advanced sales. [DOC S13]
- Clone needs an active (not deprecated) customer; the clone is a new unauthorised sale. [DOC S36]

## 3. Header defaults: how a new sale is filled

Choosing a customer pre-fills the header; every field remains editable on the sale. [DOC S1, S10, S14]

| Sale header field | Filled from | Notes |
|---|---|---|
| Contact, phone, email | customer default contact | |
| Billing / shipping address | customer default address of that type (`Default for Type`) | shipping can be overridden with "Ship to different company" (`ShipToOther`, `ShipToCompany`, etc.). With order routing on, the ship-to address can pick the location. [DOC S10] [CLIENT §3.2] |
| Price tier | **sale** header value; the sale's tier takes priority over the customer's. New sale starts with the customer's tier, else the first tier in the list. | [DOC S15] [CLIENT §3.1] |
| Terms (payment term) | customer payment term; if the customer has none and the account has exactly one term, that term | Invoice `InvoiceDueDate` = invoice date + term (formulas in 1.8 of the client notes). [DOC S10] [CLIENT §3.1] |
| Tax rule | customer tax rule; for brand-new customers the tax rule comes from setting `Default sale tax rule` | line tax rule is pre-filled from the product's tax rule if set, else the header. Priority in 7.3. [DOC S3, S30] |
| Tax inclusive | the tax rule's default | can be flipped on the sale; flipping re-derives every line's tax percent. [DOC S30] [CLIENT §3.2] |
| Account (sales revenue) | customer account, else first sale revenue account | `DefaultAccount`; API `SaleAccount` is used for invoice lines whose product has no revenue account. [DOC S12] [CLIENT §3.1] |
| Location | customer default location; if the account has exactly one location, that one | Controls where Pick draws stock first. [CLIENT §3.1] |
| Carrier / service | customer default carrier | [DOC S14] |
| Currency + rate | customer currency; rate fetched from the exchange-rate feed when different from base currency; editable on the sale | [DOC S16] [CLIENT §1.6] |
| Discount % | customer discount (see section 7) | [DOC S14, S29] |
| Sales rep | customer rep; or the creating user if `Default sales rep is user creating the sale` (checked against the sales contacts, else first alphabetical) | [DOC S3] [CLIENT §5] |
| Note / comments | customer Comments | [DOC S10] |
| Credit limit | customer credit limit (`CreditLimit` on task) | warnings only, see section 8. |
| Attributes | copied from customer if `Copy customer attribute values to sale attribute fields` and sets match exactly | [DOC S3] |
| Skip quote | setting `By default, quote is` (Visible / Skipped) | per-sale checkbox overrides; locked once the quote or order is authorised; ticking it deletes the quote lines. [DOC S3] [CLIENT §3.2] |
| Pick / Pack / Ship mode | settings `Picking is` / `Packing is` / `Shipping is` (Manual/Automatic) | not per sale. [DOC S3] |
| New line quantity | setting `Default new line quantity` (default 0) | [DOC S1, S3] |
| Temporary customer | typing a name without creating a record is allowed on a quote; Tax rule and Location become mandatory | [DOC S1] |
| Required before any authorise | Customer, Price tier, Sales rep, Account, Tax rule, Location, Date (plus Place of supply where the country shows it) | [CLIENT §2.4] |
| Changing the customer later | resets currency and rate, carrier, credit limit, terms, tax rule, price tier, location, account, rep, memo and header discount, and clears contact and address; re-picking the original customer restores the saved values. Customer cannot be changed once credits are allocated or a child document is active. | [CLIENT §3.1, §2.3] |

Customer defaults can themselves be pre-filled from Settings > Reference books > Default Field Values (Customer). [DOC S14]

## 4. State machines

### 4.1 Per-document status enums

| Document | Values | Notes | Src |
|---|---|---|---|
| Quote (`QuoteStatus`) | `NOT AVAILABLE` (skipped or empty), `DRAFT`, `AUTHORISED`, `VOIDED`; with Quote Approval a separate approval state: pending (0), rejected (1), approved (2) (UI: Awaiting Approval, Rejected) | `DRAFT` in the document sense; the sale-level `DRAFT/ESTIMATING` split in 4.2 is about line count. | DOC S9, S13; API; CLIENT §2.6 |
| Order (`OrderStatus`) | `NOT AVAILABLE`, `DRAFT`, `AUTHORISED`, `VOIDED`; page-only variants `AUTH_NO_ALLOC` (authorised without allocation), `FULFILLED`, `CLOSED`; server-set `BACKORDER`, `SHORT STOCK`, `NO STOCK` | The page maps `BACKORDER` to draft for display. | API; CLIENT §2.1, §2.2 |
| Pick (`CombinedPickStatus` filter) | `NOT AVAILABLE`, `NOT PICKED`, `PARTIALLY PICKED`, `PICKING`, `PICKED`, `VOIDED` | Per fulfilment document: `DRAFT`, `AUTHORISED`, `VOIDED`, `NOT AVAILABLE`. | API; OBS |
| Pack (`CombinedPackStatus`) | `NOT AVAILABLE`, `NOT PACKED`, `PARTIALLY PACKED`, `PACKING`, `PACKED`, `VOIDED` | per fulfilment as above | API |
| Ship (`CombinedShippingStatus`) | `NOT AVAILABLE`, `NOT SHIPPED`, `PARTIALLY SHIPPED`, `SHIPPING`, `SHIPPED`, `VOIDED` | per ship line `IsShipped` boolean. | API |
| Fulfilment overall (`FulFilmentStatus`) | UI: Picking, Picking Overdue, Packing, Packing Overdue, Shipping, Shipping Overdue, Partially Fulfilled, Fulfilled. List filter wording: Not fulfilled, Partially fulfilled, Fulfilled, Not available. "Overdue" = current date after the Required By date; "Picking" = at least one item left to pick, "Packing" = fully picked with a pack left, "Shipping" = fully packed with a ship left. | | DOC S9 |
| Invoice (`CombinedInvoiceStatus`) | `NOT AVAILABLE`, `NOT INVOICED`, `DRAFT`, `AUTHORISED`, `INVOICED`, `PAID`, `VOIDED`; also `INVOICED / CREDITED`, `PARTIALLY INVOICED`, `PARTIALLY INVOICED / CREDITED`. Per invoice document: `DRAFT`, `AUTHORISED`, `PAID`, `VOIDED`. | Fulfilment-tab wording: Invoiced, Invoiced/Credited, Not Invoiced, Partially Invoiced, Partially Invoiced/Credited. | DOC S9; API; OBS |
| Payment (`CombinedPaymentStatus`) | `UNPAID`, `PARTIALLY PAID`, `PAID`, `OVERPAID`, `OVERPAID / CREDITED`, `PREPAID` (partial/full payment on the quote); the page also knows `NOT REFUNDED`, `REFUNDED`, `PARTIALLY REFUNDED` for credit notes | | DOC S9; CLIENT §6 |
| Credit note (`CreditNoteStatus`) | `NOT AVAILABLE`, `DRAFT`, `AUTHORISED`, `VOIDED`; Accounting tab adds `PAID`, `REFUNDED`, `Rejected` (estimates) | | DOC S9; API |
| Restock (`RestockStatus` on task) | draft/authorised/voided, independent of credit note | | DOC S6; CLIENT §2.1 |
| Sale-level `Status` filter | The published SaleList page defines `Status` by the sale statuses of 4.2 (example filter `Status=BACKORDERED`). (corrected) The API map's older list (`DRAFT/AUTHORISED/PARTIALLY AUTHORISED/NOT AVAILABLE/VOIDED`) is not what the page documents; prefer 4.2. | | API |

Grey/yellow/green row icons (Quote, Order, Fulfilment, Invoice, Payment): grey = unavailable/not started (skipped quote, unauthorised order, dropship fulfilment, service sale order+fulfilment, unauthorised invoice for the payment icon), yellow = draft or partial, green = authorised/complete. Icon order follows the stock-first or invoice-first setting. [DOC S9]

### 4.2 Combined sale status (the `Status` shown on the sale)

The published API derivation is a set of mutually exclusive conditions on the document statuses of 4.1; it is stock-first (fulfilment steps show until Ship is authorised). The General tab of the UI can instead put Invoicing/Invoiced ahead of the fulfilment steps when "Show invoice tab before fulfillment tab" is on; both orders of authorisation are allowed either way. (corrected: precedence is now published, no longer inferred.)

| Status | Condition (API derivation) | UI label notes | Src |
|---|---|---|---|
| `VOIDED` | task voided; terminal | | API; DOC S9 |
| `DRAFT` | quote and order empty and not authorised | quote with no lines | API; DOC S9 |
| `ESTIMATING` | `QuoteStatus = DRAFT`, order `NOT AVAILABLE` | saved, unauthorised quote with lines | API; DOC S9 |
| `AWAITING APPROVAL` (UI only) | quote authorised but approval pending (Quote Approval on) | not an API status | DOC S9, S13; CLIENT §2.6 |
| `ESTIMATED` | quote `AUTHORISED` (or Skip quote), order `NOT AVAILABLE` | with approval on, also approved | API; DOC S9 |
| `ORDERING` | `OrderStatus = DRAFT` | | API |
| `ORDERED` | order `AUTHORISED`, everything in stock, pick `NOT AVAILABLE` | advanced sales stay here until completed | API; DOC S9 |
| `BACKORDERED` | order `AUTHORISED`, at least one product backordered, pick `NOT AVAILABLE` | advanced stays until completed | API; DOC S9 |
| `PICKING` | pick `DRAFT` | UI also uses it for "order authorised, pick not authorised"; never shown for advanced sales | API; DOC S9 |
| `PICKED` | pick `AUTHORISED`, pack `NOT AVAILABLE` | | API |
| `PACKING` | pack `DRAFT` | | API |
| `PACKED` | pack `AUTHORISED`, ship `NOT AVAILABLE` | | API |
| `SHIPPING` | ship `DRAFT` | | API |
| `INVOICING` | order `AUTHORISED`, ship `AUTHORISED`, invoice `DRAFT` | UI table says fulfilment may be in any state (invoice-first mode) | API; DOC S9 |
| `INVOICED` | ship `AUTHORISED`, invoice `AUTHORISED` or `PAID`, invoices minus credit notes minus paid is not 0 | | API |
| `CREDITED` | credit note `AUTHORISED`, balance not 0 | also a standalone authorised credit note; "Invoiced/credited" | API; DOC S9 |
| `COMPLETED` | invoice `PAID`, ship `AUTHORISED`, balance 0 (the invoice total already nets credit notes) | resolved: includes payment; see gotcha | API; DOC S9 |
| `CLOSED` | advanced sale marked closed (no further invoicing or receiving expected) | | DOC S2, S9; OBS |
| `RESTOCKING` | not documented anywhere; name only | | |

Observed stored values on a live account: BACKORDERED, CLOSED, COMPLETED, DRAFT, ESTIMATED, ORDERED, ORDERING, PICKING, VOIDED. [OBS]

The page keeps longer internal strings and maps them to labels: `QUOTE IN PROGRESS` Estimating, `QUOTE COMPLETED` Estimated, `SO IN PROGRESS` Ordering, `SO COMPLETED` Ordered, `PICK IN PROGRESS` Picking, `PICK COMPLETED` Picked, `PACK IN PROGRESS` Packing, `PACK COMPLETED` Packed, `SHIPMENT IN PROGRESS` Shipping, `INVOICE IN PROGRESS` Invoicing, `INVOICE COMPLETED` Invoiced, `COMPLETED / CREDIT NOTE` Credited. Unknown strings display as-is. [CLIENT §2.1]

Document-status lifecycle on the page: NOT AVAILABLE becomes DRAFT as soon as a line or charge exists, then AUTHORISED; invoice goes on to PAID (server); credit note/restock/pick/pack/ship follow the same draft/authorised pattern, with VOIDED terminal. Authorising Pick sets Pack to DRAFT if pack lines exist; authorising Pack sets Ship to DRAFT if shipment lines exist. Editing an order field while the order is not completed forces it back to DRAFT. [CLIENT §2.2]

Fulfilments can only be created while the order is authorised, backordered, fulfilled or closed and unpicked quantity (excluding drop-ship lines) remains. An invoice can be created while ordered quantity exceeds invoiced quantity on authorised or paid invoices; the Invoice tab is enabled only for authorised orders. [CLIENT §2.2]

### 4.3 Transition table: quote and order

Columns: current -> action -> next. "Blocks" lists what the action prevents or requires.

| From | Action | To | Preconditions / validations | Blocks / side-effects | Src |
|---|---|---|---|---|---|
| (new) | Save | `DRAFT` (no lines) or `ESTIMATING` (lines) when quote visible; `ORDERING` when quote skipped | customer or temporary customer; Tax rule + Location mandatory for temporary. Ctrl+S saves without the required-field check. | no stock allocation. Blank rows are deleted on save. | DOC S1; CLIENT §2.4, §4.1 |
| `ESTIMATING` | Authorise quote | `ESTIMATED` (or `AWAITING APPROVAL` when approval on) | needs a customer and at least one line or charge; an empty quote cannot be authorised (use Skip quote). (corrected: lines are not optional) | **Does not reserve stock.** Customer credit (prepayment) may be added once the quote is saved or authorised. Auto-apply discounts if setting on. With approval off, the quote is copied to the order automatically. | DOC S1, S3, S10; CLIENT §2.4 |
| `AWAITING APPROVAL` | Approve | `ESTIMATED`, then Order tab | permission `Sale Task - Quote Approve/Reject/Review` | enabling Quote Approval also enables Order Approval. With approval on, authorising no longer copies the quote to the order; "Copy from quote" becomes manual. | DOC S13; CLIENT §2.6 |
| `AWAITING APPROVAL` | Reject | rejected sale (read-only; no payments can be applied) | same permission | filter "Rejected quotes" | DOC S13 |
| rejected | Review | `DRAFT` | | quote can be authorised again | DOC S13 |
| `ESTIMATED` / `ESTIMATING` | open Order tab, Copy from Quote | `ORDERING` | lines + additional charges copy from quote | | DOC S1; CLIENT §3.5 |
| `ORDERING` | Authorise order | `ORDERED` (stock covered) / `BACKORDERED` (stock short, backorder chosen) / split (see 5.3) | Needs a customer and at least one line. Authorisation **allowed even if stock short**: a dialog offers Split Order (only if partial stock exists), Backorder, or Create Purchase Order (single supplier; "For backordered" or "For whole sale"). Credit limit / credit hold produce a warning with confirm, not a hard block unless the user lacks `Sale Task - Ignore Mandatory Credit Limit` (see section 8). If `Automatically apply discount and deals` on, discounts are applied now. Auto-assembly triggers per setting. Drop-ship POs are created for drop-ship lines. | Allocates stock for the whole order (unless `Make stock allocation optional` is on, then the Authorise button offers a no-allocation variant and allocation happens at Pick). Allocated stock can still be reallocated to other orders until Pick is authorised. Once the invoice is authorised, item lines are locked. Auto-pick (if automatic) runs only if sufficient stock is available (never for B2B). A skipped quote's lines are removed at this point. | DOC S1, S8, S3; CLIENT §2.4 |
| any authorised stage | Undo | back to draft of that stage | permission `Undo` for the Sale module (each module has its own). Whole-sale Undo returns everything to draft and every step must be re-authorised; lines, quantities and prices are kept. | Reverses accounting transactions and checks whether they were exported. Blocked when stock created by the task has been used elsewhere (the help example is a purchase; for sales it bites on restocked stock), during a stocktake in the ship location, or when the invoice sits in a consolidated Xero export (issue a credit note and a new order instead; QuickBooks Online can remove invoices). Unauthorised drop-ship POs are deleted. If the sale has customer credits, a second confirm says the deposits and their allocated payments will be removed. | DOC S17, S18; CLIENT §2.5 |
| any | Void | `VOIDED` | permission `Sale Task - Void`; same stocktake restriction on Ship; unsaved sale cannot be voided | permanent; removes quote/order/pick/pack/ship/invoice/payment records; **a payment's transactions are deleted and not refunded**; cannot re-authorise | DOC S17, S1; CLIENT §2.5 |
| `ORDERED` / `BACKORDERED` (advanced) | Mark as Fulfilled | order marked `FULFILLED` | order authorised; blocked while a fulfilment has pick/pack/ship in flight (complete or void it first) | removes the stock allocation for the unshipped remainder | DOC S2; CLIENT §2.4 |
| advanced | Mark as Closed | `CLOSED` | includes Mark as Fulfilled; all shipments done and, per product, invoiced quantity must equal shipped quantity (otherwise an error asks you to fix the discrepancy) | "do not plan to invoice remaining" | DOC S2; CLIENT §2.4 |
| any simple | Convert | advanced | irreversible, confirm dialog | | DOC S2 |
| any | Clone | new draft with same customer and order details | customer must be active; clone is not authorised | | DOC S1, S2, S36 |
| draft quote older than threshold | Archive (auto/manual) | archived (filter "Archived") | only unauthorised quotes without prepayments; authorised quotes and quotes with prepayments cannot be archived | Settings `Enable archiving`, `Archive sale quotes older than`; manual Archive archives at once | DOC S3; CLIENT §2.6 |

Edit-after-authorise: sales documents cannot be edited once authorised unless Undone, with two exceptions: price, discount, tax rule and account on invoice lines (see 4.5), and users holding `Edit authorized documents` can still change an authorised order's price, the invoice date, memos and credit-note lines. (corrected: the earlier draft said that permission was not described for sales; the sale page does use it, though the help text lists it only for purchases and production.) [DOC S33, S18] [CLIENT §2.3]

### 4.4 Transition table: fulfilment (Pick, Pack, Ship)

Fulfilment exists only for stock (non-service, non-dropship) lines. Advanced sales have one fulfilment record per `+Fulfillment`.

| Step | Preconditions | Authorise effect | Undo / Void | Next | Src |
|---|---|---|---|---|---|
| Pick | Order authorised; at least one pick line; picked quantity per product cannot exceed ordered. | Picks lines (`Location`, `LocationID`, `Quantity`, `BatchSN`, `ExpiryDate`). **Allocates stock if not already allocated.** Does not move stock: a pick list is only an instruction, so no movement is recorded until pack and ship. | Undo pick is offered only while Pack is not authorised; Void cancels. (corrected: no longer inferred) | Pack | DOC S20; CLIENT §2.3, §2.4 |
| Pack | Pick authorised; pack lines default to a copy of the pick, one box by default; per product, location (and batch/serial) pack quantity must equal pick quantity and cannot exceed it. | Assigns lines to boxes (`Box` per line). No stock movement. | Undo pack offered only while Ship is not authorised; undo clears package details and shipping instructions. | Ship | DOC S5; CLIENT §2.4 |
| Ship | Pack authorised; boxes marked shipped; **no open stocktake in the origin location** (error shown otherwise, same for Undo/Void). Ship date cannot fall in a locked accounting period (error; user must enter a later date). A box can be listed by only one carrier line. If not all boxes are marked shipped, Yes creates a new fulfilment holding the unshipped boxes; if packed boxes are missing from the shipment, you may split or add them. | **Stock leaves inventory (OnHand drops) and COGS is posted** (Dr COGS, Cr Inventory) dated the ship date (max ship date if several). Tracking info synced to integrations. Status `SHIPPED`/fulfilment `Fulfilled`. | Undo reverses movement and COGS (needs no stocktake in the location). | complete | DOC S5, S21, S20; CLIENT §2.4 |

Pick lines when stock is short: `Pick Available` (advanced only) picks what is in stock; `Pick Remaining` picks all unpicked quantities. [DOC S2] An unauthorisable pick for lack of stock leaving the sale at `PICKING` is from a community feature-request thread only and is **not confirmed** by the help center (inferred). [S22]

Dropship: Pick/Pack/Ship tabs not shown. [DOC S7]

Fulfilment tab (list) rules: only authorised orders appear, voided sales are removed; "Ready for partial pick" = enough stock for part, "Ready to pick" = enough for the whole order, "Ready to start pick" = no draft pick lines; pickers can be assigned and picks scheduled from there (WMS picking only). [DOC S9, S10]

### 4.5 Transition table: invoice

| Step | Preconditions | Authorise effect | Undo / Void | Src |
|---|---|---|---|---|
| Invoice (simple) | Order authorised. Can be before or after fulfilment (setting `Show invoice tab before fulfillment tab` changes tab order only; **both orders are allowed**). Not authorisable while a stocktake is open in the sale location. An empty invoice and a missing due date are rejected; invoiced quantity cannot exceed what was ordered or remains. | Invoice number assigned per `Assign invoice number`; invoice date per `Set invoice date` / `Default date settings` (invoice authorisation, order authorisation, or shipment authorisation date). Posts revenue/tax/AR journals (section 10). If the customer has unused credit, a dialog offers to allocate it. `DueDate` = invoice date + payment term. Item lines and quantities are copied from the order and locked; price, discount, tax rule and account can still be changed on the invoice; additional charges can be added. (corrected) Sale status `INVOICED` / `INVOICING` per 4.2. | Undo to draft reverses journals; **allocated payments are removed after a confirm** (not a block), but Undo/Void are refused while an authorised credit note is linked to the invoice and for invoices in a consolidated Xero export. Void permanent. A locked accounting period would block the reversal (inferred from the lock-date rule). (corrected) | DOC S1, S3, S33, S18, S43; CLIENT §2.4, §2.5, §4.2 |
| Invoice (advanced) | order authorised; choose `Fulfillment #` (0..n) or `Invoice Remaining`; additional charges must be Service type. | as above per invoice | as above | DOC S2 |
| Service sale invoice | Quote authorised (or quote skipped: lines added directly). `Copy from Quote`. | as above | as above | DOC S4 |

An authorised invoice cannot be edited beyond price/discount/tax/account; to change amounts after the fact post a credit note. [DOC S1, S6, S33]

### 4.6 Transition table: payment, deposit, refund

| Event | Rule | Effect | Src |
|---|---|---|---|
| Prepayment / deposit | Added from a **saved or authorised quote**, order or invoice via "Customer Credit" (not for regular payments). Needs a saved sale, a customer and a mapped customer-credits account. Deposit account defaults to the mapped Customer Credits (liability) account; pick a bank account and amount. | The accounting article lists "authorised quote with deposit" as the trigger: Dr Bank, Cr Prepayment (customer credits liability). Sale payment status `PREPAID`. Posting time for a deposit added at order or invoice stage is not stated (see section 13). | DOC S1, S10, S23, S21; CLIENT §2.4 |
| Use credit on invoice | On authorise, if unused customer credit exists a dialog asks. Otherwise `+Use Customer Credit` later; choose how much of each credit to allocate. | Dr Prepayment, Cr AR for the allocated amount. | DOC S1, S33, S21 |
| Payment | Only on an **authorised** invoice. Methods: bank account payment (account, date paid, amount, reference), customer credit, credit-note allocation (`+Allocate credit note`, any unrefunded credit note of the same customer, partial amounts allowed), gift card (base currency only, not on third-party channels). Payment buttons disable once the balance reaches 0. | Dr Bank, Cr AR dated payment date. Status goes `PARTIALLY PAID` -> `PAID` (invoice status `PAID`). Payments in foreign currency carry their own rate. | DOC S1, S24, S33, S41, S21; CLIENT §1.7 |
| Bulk payment | Sales > Bulk payment: pick a customer and period, enter the amount; it is spread over due invoices or allocated by hand. A foreign-currency customer needs a conversion rate. | one payment line per invoice paid | DOC S33 |
| Overpayment | **Forbidden** (resolved): it causes accounting-sync errors. Record a customer credit for the extra, or record the whole payment as credit then pay with credit. `OVERPAID` / `OVERPAID / CREDITED` still exist as statuses for data imported from elsewhere. API payments reject a negative amount. | | DOC S1, S32, S33, S9; API |
| Refund | On an **authorised** credit note. Two forms: `+Refund` (bank account, date) or `+Return to Customer Credit` (creates customer credit). | Credit-note balance reduced; credit note shows `PAID` (in-sale) or `REFUNDED` (standalone). | DOC S6, S2, S9 |
| Customer credit sources | Credit notes returned as store credit, prepayments, overpayments, and Financials > Receive money (account currency must equal the customer's). A credit cannot move to another customer: delete it and create a new one. POS store credit only works in POS. | | DOC S23, S37 |
| Payment on rejected quote / voided sale | not allowed | | DOC S13 |

### 4.7 Transition table: credit note and restock

| Rule | Detail | Src |
|---|---|---|
| Precondition | Credit notes can be issued only to sales with an **authorised invoice** (the API page also requires the shipment stage authorised, which the UI article does not; see section 13). Simple sale: one credit note; advanced: many (each "Credit note for" an invoice, lines copied). Standalone credit notes need no sale. Credited quantity cannot exceed the invoiced quantity. | DOC S6, S2; API; CLIENT §2.4 |
| Scenarios | Unit-price overcharge (price = difference, delete the restock line -> no stock change); partial shipment; full shipment (copy invoice items); discount after invoice (additional-charge line with discount value; inventory unchanged). | DOC S6 |
| Authorise credit note | Posts negative revenue/tax and, if restocking, negative COGS. Prompts for Restock. Items with a BOM are auto-disassembled on restock. | DOC S6, S21 |
| Restock | Separate tab; **credit note and restock can be authorised independently and in any order**. Quantity defaults to credit-note quantity and may be lowered (e.g. damaged: refund but do not restock); location can differ from sale location; batch/expiry carried. Delete line if quantity is 0. Restock quantity cannot exceed the credited quantity or the shipped-and-not-yet-restocked quantity. Authorising restock returns items to OnHand at that location and posts the negative COGS (Dr Inventory, Cr COGS). | DOC S6, S2, S21; API; CLIENT §2.4 |
| Void credit note | Allowed at any time, **except** when removing the restock would drive stock on hand negative. Voiding does not void the sale. | DOC S6 |
| Refund | See 4.6. | DOC S6 |
| Channel behaviour | POS and most channels auto-create credit notes (not Amazon, Magento, B2B). A Shopify refund + restock is captured and applied to the sale; a restock to another location creates an authorised transfer; an unprocessed cancelled order is found and voided automatically; refunds and restocks made in Cin7 are not sent back to Shopify. A refund for a sale older than the integration creates a bare sale holding only the credit note. | DOC S6, S25 |
| RMA | RMA/return orders (paid add-on) can raise credit notes, restocks, transfers, write-offs; unsuitable for unit-price overcharge, post-invoice discount, standalone credit note. Out of scope here (separate module). An RMA cannot be undone after product receipt is authorised. | DOC S6, S47 |
| Sale status | `CREDITED`/`INVOICED / CREDITED` when a credit note is authorised; overall payment status `OVERPAID / CREDITED` when a refund is applied to a credit note. | DOC S9 |
| Undo order of operations | Undoing an invoice needs its linked credit notes undone first. Undo order between credit note and restock is not documented (inferred: restock first). | CLIENT §2.5 |

### 4.8 Messages and error texts

Cin7's wording is mostly unpublished in the help center; these come from the page scripts and a few help pages. The sandbox may reuse the meaning, not necessarily the wording.

| Situation | Message (short form) | Src |
|---|---|---|
| Authorise empty quote / order / invoice / credit note / restock / pack list | "... is empty. You cannot authorize an empty ..." (quote text points to Skip quote) | CLIENT §2.4 |
| Authorise without customer | asks to create a customer record first | CLIENT §2.4 |
| Missing required header field | "<Label> is required." joined per field | CLIENT §2.4 |
| Missing permission | "You do not have permission to authorize quotes / orders / pick / invoices / credit notes / restocks" | CLIENT §2.4 |
| Pick over ordered | picked quantity for the product exceeds ordered quantity | CLIENT §2.4 |
| Pack differs from pick | pack quantity differs from pick quantity (per product and location); packed more than picked | CLIENT §2.4; API |
| Ship incomplete | nothing marked shipped; not all boxes shipped (offers a new fulfilment); box assigned to two carriers | CLIENT §2.4 |
| Stocktake running | stocktake/inventory count "in progress" in one or more locations blocks processing | DOC S42, S1 |
| Closed period | transaction not allowed in a closed period; choose a later date | DOC S27, S43 |
| Invoice over-invoicing | cannot authorise more than ordered or remaining; line shows an exceeded-remaining note | CLIENT §2.4 |
| Invoice without due date | "Please enter due date." | CLIENT §1.8 |
| Credit exceeds invoice | credited quantity exceeds invoiced quantity; restock exceeds credited or picked quantity | CLIENT §2.4 |
| Payment before authorise | invoice (or credit note) must be authorised before payments (refunds) | CLIENT §2.4 |
| Credit note void blocked | restock removal would lead to negative stock on hand | DOC S6 |
| Invoice undo/void blocked | cannot undo or void an invoice with an authorised linked credit note | CLIENT §2.5 |
| Undo/void unsaved | cannot undo or void an unsaved task | CLIENT §2.5 |
| Mark fulfilled/closed blocked | uncompleted fulfilments remain; invoiced and fulfilled goods differ | CLIENT §2.4 |
| Archive blocked | prepaid quote cannot be archived | CLIENT §2.6 |
| Stock short on authorise | dialog: Split Order / Backorder / Create Purchase Order (not an error) | DOC S8 |
| Credit limit / hold | warning with Yes/No: on hold, over limit, grace period exceeded (No reverts to DRAFT) | CLIENT §4.3 |
| API: duplicate SKU in lines | exception; a short-stock line silently backorders | API |
| API: negative payment amount | "Amount can't be negative" (400) | API |

### 4.9 Automation and bulk actions

| Option | Rule | Src |
|---|---|---|
| `Picking is` Automatic | Pick filled and authorised when the order is authorised, only if stock is sufficient for the whole order. Not for B2B. | DOC S3, S20 |
| `Packing is` Automatic | Pack filled and authorised when pick is authorised. Not for B2B. | DOC S3, S5 |
| `Shipping is` Automatic | Ship filled and authorised when pack is authorised. Not for B2B. Needs the pack stage. | DOC S3, S5 |
| WMS | `Picking is` and `Packing is` must be Manual for the WMS app. | DOC S3 |
| Page behaviour | `SkipPack`/`SkipShip`: when set, opening Pack (or authorising Pack) auto-copies pick to pack (pack to ship) if the user holds the authorise permission. | CLIENT §5 |
| API `AutoPickPackShipMode` | `NOPICK`, `AUTOPICK`, `AUTOPICKPACK`, `AUTOPICKPACKSHIP`; lines are fulfilled whole, never split; ignored for service-only sales; if stock is short the pick stays draft and pack/ship stay not available, with no error. | API |
| CSV import mode | No picking, Auto Pick, Auto Pick + Pack, Auto Pick + Pack + Ship; imported orders arrive authorised (never draft); "backorder on low stock" creates the sale backordered and skips credit/refund/restock rows; max 100 tasks per file; cannot add lines to existing sales. | DOC S36 import article |
| Bulk Fill & Authorize | Each sale is processed on its own, top to bottom; unmet prerequisites skip the sale. Authorise Quote: draft, not skipped, has a line. Authorise Order: not service-only; **backorders on short stock and never splits**; copies quote lines if the order is empty; triggers auto-assembly. Authorise Pick: skipped if any product has a special costing method; auto-picks when empty; for advanced sales authorises draft fulfilments and spawns another for the unpicked remainder. Authorise Pack: auto-packs into one box. Authorise Ship: default shipment dated the invoice date, else today. Authorise Invoice: for advanced sales authorises drafts or creates invoices for the uninvoiced remainder. Full completion walks all stages and stops at the first blocked step, keeping earlier ones. | DOC S34; CLIENT §6 |
| Bulk Undo / Void | need the matching Undo/Void permission; advanced sales only in the General view. Email needs a template body and recipients and goes out per sale. | DOC S34; CLIENT §6 |

## 5. Stock effects

### 5.1 Quantity definitions

- **OnHand** = quantity from actual inventory cards/transactions (includes goods on authorised but unshipped sales; excludes un-received PO stock). [DOC S26]
- **Allocated** = quantity reserved by authorised sales and work orders not yet completed; used to decide Available for quoting, ordering and picking. [DOC S26]
- **Available = OnHand - Allocated**, calculated either for the product across locations or for a specific location/batch/expiry, depending on setting `Available quantity is limited to` (all locations vs the sale-header location; not applied to B2B portal). Available can go negative (the auto-assembly formula allows for it). [DOC S26, S3]
- A stocktake locks its location: stock there cannot be used, sold or moved, and integrated-channel orders stay Pending until it finishes. [DOC S42]
- Margin estimate on the sale uses **average cost**: (price - average cost) x 100 / price, shown N/A if average cost is 0 (the page shows 0 when price is 0). Average cost is for estimates only, never COGS. [DOC S10, S27] [CLIENT §1.9]

### 5.2 Effects per transition

| Transition | OnHand | Allocated | Available | COGS / cost | Journals | Src |
|---|---|---|---|---|---|---|
| Quote authorise | no | no | no | none | prepayment only if credit added | DOC S1 |
| Order authorise (stock sufficient) | no | + line qty (whole order) unless `Make stock allocation optional` | - | none | none | DOC S1, S3 |
| Order authorise, optional allocation on | no | only if the user picks the allocate variant of Authorise; else at Pick. (corrected: not advanced-only; the page offers it on any sale when `AllowOrderNoAlloc` is on) | | | | DOC S2, S3; CLIENT §2.3 |
| Order authorise, stock short | no | allocation of what exists (inferred); shortfall -> backorder | | | | DOC S8 |
| Split order | no | original reduced to in-stock qty (authorised); new order for remainder | | | | DOC S8 |
| Backorder | no | adds to "Reorder Backordered" list (needs supplier on product) | Available can go negative | | | DOC S8, S3 |
| Pick authorise | no (explicit: no stock movement) | + (if not yet) | | none | none | DOC S20 |
| Pack authorise | no | | | none | none | DOC S5 |
| **Ship authorise** | **- shipped qty** | **- shipped qty** (inferred) | | **COGS = cost of picked cards** | **Dr COGS / Cr Inventory** | DOC S5, S21, S27 |
| Invoice authorise | no | no | | none | Dr AR, Cr Sales, Cr Tax | DOC S21 |
| Ship undo/void | + | + (back to allocated if order still authorised) (inferred) | | COGS reversed | reversed | DOC S17 |
| Credit note authorise | no | no | | none | Dr Sales/Tax, Cr AR (shown as negative amounts); the COGS part comes with Restock | DOC S6, S21 |
| Restock authorise | + | no | + | negative COGS at the cost of the stock being returned (cost basis inferred) | Dr Inventory, Cr COGS (negative COGS) | DOC S6, S21 |
| Mark as Fulfilled (advanced) | no | releases remaining allocation | + | | | DOC S2 |
| Void order | no | releases (inferred) | + | | | DOC S1 |
| Drop-ship line | never touches OnHand of the seller | none | | COGS at **purchase invoice** authorisation | see section 9 | DOC S7, S21 |

COGS timing details:
- COGS is created only when **Ship** is authorised; before that COGS shows 0. COGS date = ship date (multiple ships: max ship date). Setting `Default shipment date` can default the ship date to the invoice date so invoice date and COGS date match; the ship tab must still be authorised. A manual (including past) ship date is allowed but not into a closed accounting period. Journal or landed-cost entries created before the ship are dated the ship date; after it they use their own effective date. [DOC S27, S3]
- Cost is the **actual purchase cost** of the picked cards from the authorised purchase invoice, not average cost. Average cost is display/estimate only and not used in P&L or reports. If a unit is received but its purchase invoice is not yet authorised, COGS at ship can be 0 and is updated (extra transaction, purchase-invoice date) when the invoice is authorised. Cin7 never rewrites old COGS; later cost events add additional transactions (`AdditionalCOGSStatus`). [DOC S27, S45]
- Reports with the filters "only COGS within range" or "All COGS" (Sale Profit Summary, Profit by Sales Representative, Sales by Product Details/Summary, Customer Orders by Product, Sale Credit Notes by Product) can show 0 COGS for an invoice whose ship tab is unauthorised. [DOC S27]
- Finished-goods cost = component actual cost plus labour/overhead (assemblies). The BOM figure is only an estimate. [DOC S27]

### 5.3 Backorders, splits, partial fulfilment

| Rule | Detail | Src |
|---|---|---|
| Authorise with short stock | Always allowed. Dialog: Split Order (only if some stock exists), Backorder (whole quantity), Create Purchase Order. | DOC S8, S1 |
| Backorder requires supplier | Backordering only works for products with an assigned supplier (the Reorder page warns about missing suppliers); needs the Purchase `Reorder Stock` permission. | DOC S8 |
| Assembly and production items | Out-of-stock assembly: with auto-assembly the assembly order is created automatically; without it you are asked to backorder, which needs a supplier on the item. If components are short the shortfall becomes backorderable and the assembly does **not** complete itself when they arrive. Production items: you are prompted to backorder; with `Create Production Order: When order is authorized` on, the production order and nested semi-finished orders are created; otherwise a supplier is needed. | DOC S8 |
| Auto-assembly quantity | Setting `On order authorization auto-assemble`: quantity required; or required plus maintaining the minimum/reorder buffer (order qty - (minimum + reorder qty + on order - available)); or only the shortfall (order qty - available - on order). | DOC S3 |
| Split order | The original order is cut to the in-stock quantity and stays authorised (can be fulfilled/invoiced now). A second authorised order is created with the remainder; its quantity enters the Reorder Backordered list. Not applied to auto-assembled products unless `Split auto-assembly products in sale orders` is on (example: 10 ordered, 5 available: 0 shipped when off, 5 when on). | DOC S8, S3 |
| Create PO from sale | "For backordered" or "For whole sale"; one supplier per PO (several POs allowed, even when stock is available); header and supplier may need filling; PO linked in Related Orders. | DOC S1, S8 |
| Reordering | Purchases > Reorder backorders: choose a supplier, filter by customer/tag, Reorder creates one PO per supplier; default quantity accumulates other outstanding backorders for the product and is editable. | DOC S8 |
| Completing a backorder | When stock is received the sale is fulfilled/invoiced normally; with automatic fulfilment **nothing starts by itself**: invoice and fulfilment must be authorised manually. | DOC S8 |
| Backorder fields in API | Line `Backorder` (bool), `BackorderQuantity`; sale status `BACKORDERED`. Via API POST a short line silently gets a backorder record. | API |
| Backorder reports | Backorder Summary (per product, no sale link), Backorder Details (authorised unshipped sales with backordered items), Find Sale Backorder by Purchase Order. | DOC S8 |
| Partial fulfilment | Only advanced sales: several fulfilments, several invoices. Simple sale: all-or-nothing per step except by converting or splitting. Ship status `PARTIALLY SHIPPED`. | DOC S2, S20 |
| Sale list filters | "Ready for partial pick" = enough stock to fulfil part; "Ready to pick" = enough for the entire order; "Ready to start pick" = no draft pick lines. | DOC S9 |

### 5.4 Which batch, serial or bin is picked

| Costing method | Auto-pick choice | User control | Src |
|---|---|---|---|
| FIFO | oldest **Date Received** first (not the receipt authorisation date) | none (no batch/serial) | DOC S28 |
| FIFO - Batch / FIFO - Serial Number | oldest received first; batch/serial mandatory at receipt and at pick | | DOC S28 |
| FEFO - Batch / FEFO - Serial | earliest expiry first; expiry mandatory; batch auto-generated if none | batch of a FEFO line cannot be changed after auto-pick | DOC S28, S20 |
| Special - Batch / Special - Serial | none; user chooses batch/serial regardless of date or expiry | required | DOC S28 |

- Excluding expired stock from auto-pick is governed by the setting `Exclude expired batch/serial numbers` (Products and measurements settings); manual scanning or selection is never validated by it. (corrected: it is a setting, not an unconditional rule) [DOC S28, S44, S20]
- Setting `Recommend batch/serial no. for FIFO/FEFO` (sale fulfilment, transfers, assembly; not production components): Don't recommend; Recommend and warn (a warning at pick authorisation, user may ignore it); Recommend and enforce (user must swap to the recommended stock). (resolved from the earlier open item) [DOC S28, S44]
- Auto-pick picks from the sale location first; if short, it checks other locations (honouring costing method) subject to setting `Available quantity is limited to`. Changing pick location manually requires picking from all locations enabled. [DOC S20, S3]
- Transfers keep the original received date unless setting `Update Stock Received Date with Transfer Completion Date` is on (that changes FIFO order). [DOC S28]
- Bin picking order and document sorting: `Sale documents` ordering setting (screen order, name, SKU, or location/bin > store locator > attributes > screen order). [DOC S3]
- Serial-number uniqueness is not enforced; changing costing method mid-transaction is a common source of errors, and a non-serial method cannot become serial for a SKU with transactions. [DOC S28]

## 6. Statuses at a glance: what each action blocks

| Current stage authorised | Undo here requires | Void here requires | While authorised, you cannot |
|---|---|---|---|
| Quote | There is no quote-only Undo; Undo is for the whole sale (a rejected quote's Review uses it) [CLIENT §2.5] | permission | edit quote lines; a quote with a prepayment cannot be archived |
| Order | permission; stock not used elsewhere; no stocktake at the ship location; no consolidated export lock. The whole sale returns to draft. | permission | change item lines once invoice authorised |
| Pick | pack not authorised (button shown only then) [CLIENT §2.3] | | edit pick lines |
| Pack | ship not authorised [CLIENT §2.3] | | |
| Ship | no open stocktake in origin location; period lock on ship-date posting | same | |
| Invoice | no authorised linked credit note; no consolidated Xero export; payments are removed after confirm (not a block); a closed period would block the reversal (inferred) | same (and payments removed) | change item lines; edit amounts except price/discount/tax/account or via credit note; authorise while stocktake runs in the sale location |
| Credit note | linked invoice undo needs it undone first; restock order not documented (inferred) | void blocked if restock removal would make stock negative | |
| Payment | delete the payment line first (or let invoice Undo remove it) | | pay beyond balance (buttons disable at zero) |

"Undo one stage" is available on the Pick, Pack and Ship tabs without affecting the others; Undo/Void work on one sale, several sales in bulk, or one stage. [DOC S17, S9] [CLIENT §2.5]

Permissions are per module; Undo has its own permission per module (a user can undo production but not sales). Help text lists `Edit authorized documents` for purchases and production only, but the sale page checks it too (see 4.3). Rejected quotes and voided sales are read-only. [DOC S18, S13] [CLIENT §2.3]

## 7. Pricing

### 7.1 Price tier

- Up to 10 price tiers per product; names are set in General settings (Price Tier Names). Customer has a tier; the sale header tier overrides the customer's. Line price = the product's price for the sale's tier at the time the line is added; manually editable. A tier value outside 1..10 gives price 0. [DOC S15] [CLIENT §3.3]
- Static tier: fixed number, **not** currency-converted (a 200 tier shows 200 in whatever the customer currency is; Cin7 advises a separate tier per currency). Calculated tier (Markup % or Append) uses a base value (Average cost, Fixed price, Latest price, Price tier value, Highest fixed price, Highest latest price) in base currency and is converted to the customer's currency at the current rate before the markup/append. Examples: avg cost 100 + 10% = 110; latest 80 append 5 = 85. "Price tier value" is treated as a base-currency amount and converted. [DOC S15, S16]
- Rounding tables: apply to calculated prices only; rules by range (`Range from` 0, `Range to`), `Round to nearest`, optional Add/Subtract adjustment (e.g. 38.87 -> 39 - 0.10 = 38.90); applied after deals. [DOC S15, S39]
- Custom per-customer prices (Custom Pricing) take precedence over tier prices and are set per product/customer or by CSV. (corrected from inferred) [DOC S40, S15]
- Exchange rates for automatic conversion come from an external rate feed; the base currency cannot be changed after the first transaction. [DOC S16]
- Recurring invoices: `Recurring invoice price` = Copy previous price (default) or Use product price. [DOC S3]

### 7.2 Discounts

| Layer | Kind | Applied when | Rule | Src |
|---|---|---|---|---|
| Order line `Discount` | % only, 0..100; negative values are refused unless the discount rule is "Updates the sale price" (markup) | typed on quote/order | Applied **last** when discount rule = "Updates the sale price"; added into the discount % when rule = "Updates discount %". After invoice, discounts go through credit notes. | DOC S29, S3 |
| Customer discount | % on customer | on authorise if `Automatically apply discount and deals`, else on `Apply Discounts` click | applies to all products; with auto-apply on you cannot skip applying it | DOC S29, S14 |
| Product discount (rule) | Simple: Discount Amount, % Discount, Markup Amount, % Markup, Price Override (per unit), Flat Amount (on line total); Quantity-based (tiers by "up to" qty; % applies to the **total quantity**, e.g. 100 units at 10%, 200 units at 20%); Free Shipping (cart level only, B2B/Core sales not channels; added as a negative additional charge). Attached to product, to a customer-group tag on the product, or to one customer. | as above | Priority: individual customer, then customer group, then product. **Only one product discount applies at a time.** | DOC S29, S39 |
| Interaction | If `Apply customer discount after other discounts` is on, customer discount applies after the highest-priority product discount (stack); if off, both are computed from the original price and **the lower resulting price wins** | | | DOC S29 |
| Product Deals | cart-level promos (category/brand/tag/product, all customers/POS/B2B/selected/tagged; buy-X-get-Y, order-total, free shipping; effective dates; optional coupons) | | If several discounts match a product, only the best applies; deals do not stack, apart from the customer discount (when stacking is on) and manual line discounts. Cart-level deals use Simple discounts only. | DOC S39 |
| Display | `Discount rule`: "Updates the sale price" changes unit price (and cost shown); "Updates discount %" shows total % on the line. Discount must stay 0..100%; markup via negative discount requires "Updates the sale price". | | | DOC S3, S29 |
| Engine behaviour on the page | Each run deletes and recreates the Order total discount, Buy collection discount and free-shipping charge lines and splits a line when a discount covers only part of its quantity; reruns on any exchange-rate change. | | | CLIENT §3.4 |

### 7.3 Tax

- Tax rules: one or more components (name, rate, `Compound` flag, liability account). Simple components each = rate x line value; **compound** component = rate x (line value + earlier tax). Example in help: WET 29% on total, then GST 10% on the taxed subtotal. Rules cannot be deleted, only deprecated. [DOC S30]
- Priority of tax rule on a line: order line (if changed by hand), then sales channel, then product, then the sale header, then customer. B2B portal sales cannot override the rule by hand. [DOC S30]
- Rule has a default inclusive/exclusive setting; sale header `Tax inclusive` can override and, if lines carry different rules, applies to the whole order. [DOC S30, S1]
- Tax exclusive: tax is added on top. Tax inclusive: price already includes tax; `net = gross / (1 + rate)`; `tax = gross - net`. The page uses the rule's separate inclusive and exclusive effective percents per line, so both must be stored. [DOC S30] [CLIENT §1.4]
- Additional charges carry their own `TaxRule`, `Account`, `Discount` and appear on invoices as lines; invoices can be combined or split with `CombineAdditionalCharges`. [DOC S1, S12]
- Credit-note lines use the same fields and negate the invoice. [DOC S21]
- Setting `Tax calculation method`: `Row Total` rounds each line's tax to 2 dp, `Total` keeps 4 dp per line and rounds only the section sum. [CLIENT §1.2]

### 7.4 Line and document formulas (sandbox implementation)

Resolved from the page scripts and the API page; no longer inferred. All rounding is half away from zero with a `toFixed(6)` clean-up (1.005 -> 1.01); do not use banker's rounding. [CLIENT §1.1]

```
unit        = round4( Price * (100 - Discount) / 100 )
line Total  = round2( Quantity * unit )          # includes tax when the sale is tax-inclusive
line Tax    = round(TaxPrecision)( Total * TaxPercent / 100 ), TaxPercent = rule inclusive or exclusive effective percent
              TaxPrecision = 2 for Row Total method, else 4 ; tax comes from the ROUNDED Total
section     = lines block and additional-charges block, each: A = sum(Total), T = round2(sum(Tax));
              if tax-inclusive then A = A - T ; section total = A + T
document    = TotalBeforeTax = goods of both blocks ; Tax = T lines + T charges ; Total = TotalBeforeTax + Tax
Invoice balance = Total - payments(received + allocated) ; credit note balance uses its refunds
Foreign currency: lines stay in customer currency; base total = round2(GrandTotal * rate); rate = base units per 1 customer unit (5 dp)
```

API alignment: line `Total` has 2 dp and "can include tax" when the tax rule is inclusive; line `Tax` has 4 dp; document `TotalBeforeTax`, `Tax` and `Total` (= before tax + tax) are in customer currency; invoice list `InvoiceAmount` is invoices minus credit notes. API POST requires `Tax` and `Total` for validation. [API] [CLIENT §1.4, §1.5]

### 7.5 Worked example (made-up numbers)

Customer "Acme Test Ltd": price tier Wholesale, tax rule "Sales 10%" (exclusive), terms Net 30, currency = base.

| # | Item | Qty | Tier price | Line disc % | Line net | Tax 10% |
|---|---|---|---|---|---|---|
| 1 | Widget | 3 | 40.00 | 10 | 3 x 40 x 0.90 = 108.00 | 10.80 |
| 2 | Gadget | 2 | 19.99 | 0 | 2 x 19.99 = 39.98 | 3.998 -> 4.00 |
| AC | Shipping (additional charge, 10% rule) | 1 | 15.00 | 0 | 15.00 | 1.50 |

- TotalBeforeTax = 108.00 + 39.98 + 15.00 = **162.98**
- Tax = 10.80 + 4.00 + 1.50 = **16.30** (Row Total method; tax is summed per section and rounded)
- Total = **179.28**
- Prepayment of 50.00 on the quote: Dr Bank 50 / Cr Prepayment 50 at deposit. At invoice authorisation: Dr AR / Cr Sales for the lines, shipping and tax (journal table below); Dr Prepayment 50 / Cr AR 50. Balance due = 129.28. Payment of 129.28 -> status `PAID`.
- Ship: picked cards cost Widget 3 x 22.00 = 66.00 and Gadget 2 x 9.00 = 18.00 -> COGS 84.00 posted at ship: Dr COGS 84.00 / Cr Inventory 84.00.
- Tax-inclusive variant of line 1 with price 55.00 inclusive, qty 2, 0% disc, rate 10%: gross 110.00, net 100.00, tax 10.00.
- Credit note later for 1 Widget returned, restocked: line net -36.00 (1 x 40 x 0.90), tax -3.60, total -39.60; COGS reversal Dr Inventory 22.00 / Cr COGS 22.00 at the original card cost.

Journals for this example (details in section 10):

| Event | Dr | Cr | Amount |
|---|---|---|---|
| Deposit on quote | Bank | Prepayment | 50.00 |
| Invoice authorise | Accounts Receivable | Sales (line account) | 147.98 |
| | Accounts Receivable | Sales (shipping account) | 15.00 |
| | Accounts Receivable | Tax | 16.30 |
| | Prepayment | Accounts Receivable | 50.00 |
| Ship authorise | COGS | Inventory | 84.00 |
| Payment | Bank | Accounts Receivable | 129.28 |
| Credit note authorise | Accounts Receivable | Sales | -36.00 |
| | Accounts Receivable | Tax | -3.60 |
| Restock authorise | COGS | Inventory | -22.00 |

## 8. Customer defaults and credit control

| Customer field | Effect on a new sale | Src |
|---|---|---|
| Payment term | `Terms`; sets invoice due date | DOC S14 |
| Tax rule (mandatory on the customer) | header tax rule; new customers default to `Default sale tax rule` | DOC S3, S14, S30 |
| Price tier | header price tier | DOC S14, S15 |
| Location | sale location (default) | DOC S14; CLIENT §3.1 |
| Default carrier | shipping carrier on header | DOC S14 |
| Currency | document currency and rate | DOC S14, S16 |
| Discount % | pre-filled line discount (and applied via Apply Discounts) | DOC S14, S29 |
| Sales rep | header rep | DOC S14 |
| Comments | copied into Note | DOC S14 |
| Tags | customer-group discounts, filters, deal targeting | DOC S29, S39 |
| Credit limit | see below | DOC S31 |
| Credit hold (manual) | see below | DOC S31 |
| Customer status Active/Deprecated | deprecated customers cannot be cloned (confirmed); not selectable on new sales (inferred) | DOC S14, S36 |
| Default templates | per-document default print/email template | DOC S14 |
| Parent / Bill parent | customer hierarchy with combined sales history | DOC S14 |

Credit control: [DOC S31] [CLIENT §4.3]
- Credit limit applies to all outstanding invoices, including overdue. Attempting to authorise a **sale order** (or invoice) that exceeds the limit shows a warning asking to confirm; the user can bypass. A blocking mode exists via permissions: users without `Sale Task - Ignore Mandatory Credit Limit` cannot make sales for a customer whose limit is reached (enforced server-side; the page only shows the dialog).
- Manual credit hold (checkbox, permission `Customer - Enable/Disable Credit Hold`): authorising a sale order or invoice warns and asks to continue. POS shows the same message on Add Customer.
- Automatic credit hold: set when credit limit exceeded or an overdue payment passes the grace period (`Credit Hold Grace Period`, general setting, positive integer, minimum 1); released as soon as payment is made. Authorising order/fulfilment/invoice on a hold warns and asks to continue.
- A credit limit of 0 or blank means **no limit**: the page only runs the check when the limit is above 0, and the article's note says 0 applies none. The two "Credit Limit cannot be 0" lines sit under the hold sections next to the grace-period note and read as copy errors for the grace period (resolved).
- Page behaviour: the check is advisory; if the credit call fails the authorise proceeds; answering No reverts the status to DRAFT. On picking a customer, a limit above 0 triggers an immediate check and toast.

## 9. Drop ship from a sale

| Rule | Detail | Src |
|---|---|---|
| Enable | Product has Dropship = Always Dropship or Optionally Dropship, and at least one supplier, and exactly one supplier flagged Dropship. | DOC S7 |
| On order authorise | `Always`: every such line is drop-shipped, cannot be changed on the sale. `Optionally`: checkbox auto-ticked when product has no stock on hand, not ticked if stock exists; user can tick before authorising. The page flips an optional line to drop-ship when the typed quantity exceeds available. | DOC S7; CLIENT §3.3 |
| Result | A **simple purchase order** per drop-ship supplier is created automatically; linked under Related Orders. Convert to advanced PO allowed. Not available on dropship POs: cloning, blind receipt, input methods, stock receipt and put-away, unstock on credit notes. | DOC S7 |
| Fulfilment | No Pick/Pack/Ship for drop-ship lines; drop-ship lines are excluded when counting what is left to pick. | DOC S7; CLIENT §2.2 |
| COGS | Created when the **purchase invoice** is authorised (not at PO authorisation); COGS date = purchase invoice date; until then COGS shows 0 even if stock was received. Dr COGS, Cr Inventory control for the cost. | DOC S7, S21, S27 |
| Undo sale | Unauthorised drop-ship POs are deleted when the sale is undone. | DOC S18 |
| Sale status | Fulfilment icon is grey. | DOC S9 |
| Accounting | When the sale invoice is authorised, transactions export to the accounting software and payments come back from it. | DOC S7 |

## 10. GL journals (summary level)

Transactions are created on: authorised quote prepayment, authorised invoice/credit note, authorised shipment, manual journals, stocktake/adjustment/assembly/write-off/disassembly completion, and Undo/Void of any. Purchase stock receipt posts nothing. [DOC S21]

| Step | Dr | Cr | Amount | Date | Src |
|---|---|---|---|---|---|
| Prepayment on quote/order | Bank | Prepayment (Customer credits, liability) | deposit | deposit date | DOC S21 |
| Invoice authorise, per stock line | Accounts Receivable | Sale revenue account (line/product account) | line net | invoice date | DOC S21 |
| Invoice tax | Accounts Receivable | Tax liability account (per tax component) | tax | invoice date | DOC S21 |
| Invoice additional charge | Accounts Receivable | account named on the charge (e.g. Sale 2) | net | invoice date | DOC S21 |
| Non-inventory item | Accounts Receivable | account on the invoice line | net | invoice date | DOC S21 |
| Prepayment consumed | Prepayment | Accounts Receivable | applied credit | invoice date | DOC S21 |
| Ship authorise (COGS) | COGS | Inventory control | cost of picked cards | max ship date | DOC S21 |
| Manual journal to COGS | COGS | Warehouse overheads (example) | amount | journal date (effective) | DOC S21 |
| Payment | Bank | Accounts Receivable | payment | payment date | DOC S21 |
| Credit note | Accounts Receivable | Sale and Tax | negative amounts | credit note date | DOC S21 |
| Restock | COGS | Inventory control | negative cost | credit note date in the help example; restock date not stated (section 13) | DOC S21 |
| Refund | Accounts Receivable (credit balance) | Bank | refund | refund date | inferred from DOC S6 |
| Drop-ship COGS | COGS | Inventory control | cost | purchase invoice date | DOC S21 |
| Undo/Void | the mirror of the original lines | | | | DOC S17, S21 |

Account mapping (Customer Credits liability, AR, Inventory control, COGS, Sales) must exist for authorisation to post. **Period lock:** once a lock date is set (synced from Xero or QuickBooks), nothing can be added, edited or deleted when its effective date is earlier than the lock date; ship, invoice, payment and credit-note dates and every Undo/Void of them are therefore blocked in locked periods, and the user must use a later date. A financial period cannot be closed while draft manual journals exist. Inventory account used by additional purchase costs is purchase-side and out of scope here. [DOC S21, S27, S23, S43]

## 11. Settings that change sale behaviour (names only; defined in `rules/settings.md`)

| Setting (Settings > General settings > Sale process customization unless noted) | Affects | Src |
|---|---|---|
| By default, quote is (Visible/Skipped) | initial Skip quote checkbox | DOC S3 |
| Picking is / Packing is / Shipping is (Manual/Automatic) | auto-pick/auto-pack/auto-ship chain at order authorise | DOC S3, S20 |
| Show invoice tab before fulfillment tab ("Invoice first" vs "Stock first" in the list article: the same setting) | tab/icon order, which status shows first in the General list | DOC S3, S9 |
| Default load advanced sale order | new sales are advanced (all channel sales too) | DOC S3 |
| Assign invoice number (On sale creation / On invoice authorization) | invoice number timing | DOC S3 |
| Set invoice date; Default invoice date; Default shipment date | invoice date and COGS date | DOC S3, S27 |
| Available quantity is limited to (all locations / sale location) | availability, auto-pick, B2B excluded | DOC S3 |
| Make stock allocation optional | when Allocated increases; adds the no-allocation Authorise variant | DOC S3; CLIENT §5 |
| Discount rule; Automatically apply discount and deals; Apply customer discount after other discounts | discount arithmetic | DOC S3, S29 |
| Default sale tax rule | new customers | DOC S3 |
| Enable quote approval; Enable archiving; Archive sale quotes older than | quote workflow | DOC S3, S13 |
| Default new line quantity | initial line qty | DOC S3 |
| On order authorization auto-assemble (3 modes); Split auto-assembly products | assembly on authorise | DOC S3 |
| Create Production Order: When order is authorized (production settings) | production orders created by a sale | DOC S8 |
| Recurring invoice price | recurring invoices | DOC S3 |
| Sale documents (sort order) | printouts | DOC S3 |
| Default attribute set; Copy customer attribute values | attributes | DOC S3 |
| Default sales rep is user creating the sale | rep | DOC S3 |
| Add existing attachments to emails | sale emails | DOC S3 |
| Credit Hold Grace Period (Organization settings) | automatic holds | DOC S31 |
| Price tier names; Rounding table; Document numbers (General settings) | pricing, numbering | DOC S15, S11 |
| Update Stock Received Date with Transfer Completion Date; Recommend batch/serial no. for FIFO/FEFO; Exclude expired batch/serial numbers (Product and measurement settings) | FIFO order, pick validation, auto-pick | DOC S28, S44 |
| Period lock date; Unrealised FX; Carry-forward P&L (Financial settings) | blocks and closing | DOC S43 |
| Gift card support, liability account, expiry, refund (Gift card settings) | gift cards as payment/product | DOC S41 |
| Consolidate sales upon export (Xero integration) | whether invoices can be Undone | DOC S18 |

## 12. Sandbox implementation notes (mapping to `spec/`)

- Sale task table fields in `spec/data/models.json` (`SaleTask`): `Status`, `QuoteStatus`, `SaleOrderStatus`, `InvoiceStatus`, `PickStatus`, `PackStatus`, `ShipmentStatus`, `RestockStatus`, `CreditNoteStatus`, `AdditionalCOGSStatus`, `COGSAmount`, `SkipQuote`, `IsServiceOnly`, `IsRecursive`, `CustomerReference`, `SaleOrderNumber`, `QuoteNumber`, `InvoiceNumber`, `CreditNoteNumber`, `FulfillmentNumber`. Derive combined statuses from these per 4.2 rather than storing independently. [SPEC]
- The client never sends "authorise" as a command: it sets document statuses and saves the whole sale tree; Undo, Void, child Undo/Void, Clone, approve/reject, archive, credit check and rate fetch are the only separate calls. Model the sandbox the same way: one diff-and-transition save plus those actions. [CLIENT §0, §2.5]
- API write endpoints (`POST/PUT /sale`, `/sale/quote`, `/sale/order`, `/sale/invoice`, `/sale/fulfilment/*`, `/sale/creditnote`, `/sale/payment`) map to the transitions in 4. Fulfilment sub-resources: Pick (`Lines`: ProductID, SKU, Location, LocationID, Quantity, BatchSN, ExpiryDate, NonInventory), Pack (`Box`), Ship (`Lines`: ShipmentDate, Carrier, Boxes, TrackingNumber, TrackingURL, IsShipped; `RequireBy`, `ShippingAddress`, `ShippingNotes`). [API]
- API POST limits worth copying: a short-stock line silently backorders; a SKU may appear once per sale; a quote is created only when `OrderStatus` is false (then lines are quote lines); `OrderStatus`/`InvoiceStatus` accept `NOTAUTHORISED` (default) or `AUTHORISED`; payments in the body become prepayments unless the order is authorised; field limits: reference 256, note and memos 1024, line comment 256; line discount 0..100 with 2 dp; the Ship PUT replaces an unauthorised shipment and must list every packed box; no external-fulfilment products on that endpoint. [API]
- Cin7's API returns journals under `Transactions` (`Debit`, `Credit`, `Amount`, `EffectiveDate`) and cost under `InventoryMovements` (`COGS`, `Date`). Generate these from the effects table. [API]
- Margin uses average cost and display-only rounding; tax management services (Avalara-style) lock tax cells and fill tax server-side; not modelled. [CLIENT §1.9, §5]

## 13. Unclear / docs disagree

Resolved items are struck through with the answer and where it now lives; the rest say exactly why they stay open.

1. ~~**Status precedence.**~~ Resolved: the API pages publish the derivation (4.2). Residual open item is 19.
2. ~~**"Invoice first" vs "Fulfil first".**~~ Resolved: one setting, `Show invoice tab before fulfillment tab`, worded differently in the list article; both orders of authorisation are always allowed (11, 4.5).
3. ~~**`COMPLETED` meaning.**~~ Resolved: shipped and paid (balance 0) per the API derivation and the status description; the filter-table line is the outlier; the earlier "observed COMPLETED but unpaid" could not be re-checked (4.2).
4. ~~**Overpayment.**~~ Resolved: forbidden (three articles); the "not forbidden" lines are typos; `OVERPAID` stays a valid status for imported data (4.6).
5. ~~**Credit limit 0.**~~ Resolved: 0 or blank = no limit (8).
6. ~~**Credit limit enforcement.**~~ Resolved: warn-and-confirm, hard block only for users lacking the Ignore Mandatory Credit Limit permission, enforced server-side (8).
7. ~~**Rounding.**~~ Resolved from the page scripts: half away from zero, discounted unit to 4 dp, line total to 2 dp, tax per line to 2 or 4 dp by method, summed and rounded per section (7.4).
8. ~~**API `Total` on lines.**~~ Resolved: includes tax on tax-inclusive sales, 2 dp; tax is a separate 4 dp field (7.4).
9. **Allocation on short stock** stays open. The optional-allocation mechanism is now settled (5.2), but no source says whether an order authorised with short stock allocates only what exists or nothing; the table keeps "what exists" as inferred.
10. **Undo prerequisites** partly open. Pick, pack, ship, invoice (credit-note link, payments removed, export lock) and whole-sale rules are now documented (4.3, 4.5, 6). Still undocumented: whether a credit note can be undone before its restock, and whether an Undo into a locked period is refused or silently reposted; both stay inferred.
11. ~~**Cin7 error text.**~~ Resolved as far as sources go: see 4.8.
12. ~~**Quote and order statuses in the API enum.**~~ Resolved: 4.2 lists the 16 API sale statuses; `AWAITING APPROVAL` is UI-only; internal long strings map to labels (4.2).
13. **Order numbering defaults and uniqueness** stays open: prefixes, suffixes, padding and starting numbers are configurable but no article gives the defaults, and numbering is allocated server-side only.
14. ~~**Customer reference.**~~ Resolved: 256 characters (API), editable after authorisation, not enforced unique anywhere documented (1). Server-side uniqueness is not documented either way, so the sandbox must not enforce it.
15. **Credit-note refund journal account** stays open: the accounting article shows no refund journal, so the account debited or credited by a refund is unknown; the sandbox mirrors the payment journal.
16. **Recurring sales** partly open. Frequencies, snapping to a future date and the "Create Invoices" action are documented (2). Still unknown: whether the generated invoice is authorised or left draft, and the generated sale's status.
17. **Restock vs credit note COGS timing** stays open. The accounting example dates the COGS credit with the credit note, while the credit-note article makes restock a separate authorisation; no source says which date wins when they differ.
18. ~~**Serial/batch pick enforcement setting.**~~ Resolved: three modes plus the exclude-expired setting (5.4).
19. **UI order when invoice-first is on** (new, residual of 1): the UI says Invoicing/Invoiced can show instead of the picking steps, but the exact order and the overlap between `INVOICED` and `CREDITED` (both can be true) are not published.
20. **Deposit posting time** (new): the accounting article posts a quote deposit when the quote is authorised; when a deposit added at order or invoice stage posts is not stated (the sandbox posts it at once).
21. **`RESTOCKING` status** (new): named in an earlier source list, described nowhere in the help center, the API pages or the page scripts.
22. **Credit-note precondition** (new): the UI article needs only an authorised invoice; the API page says invoice and shipment stages must both be authorised. Treat the UI rule as the default and the API rule as an API-only check until proven.

## 14. Sources

Help-center articles were read in full from the downloaded copy of the public help center (660 articles, including the API reference pages). The API operation map was read through the `cin7-core` map tools (no credentials). No Cin7 app or credentials were used and nothing was written to Cin7.

| Tag | Source |
|---|---|
| S1 | Processing a sale: https://help.core.cin7.com/hc/en-us/articles/9034492714255-Processing-a-sale |
| S2 | Advanced Sales - Multiple Fulfillment: https://help.core.cin7.com/hc/en-us/articles/9034450166287-Advanced-Sales-Multiple-Fulfillment |
| S3 | Sale process customization: https://help.core.cin7.com/hc/en-us/articles/11073350145935-Sale-process-customization |
| S4 | Service sale: https://help.core.cin7.com/hc/en-us/articles/9034615606927--Service-sale |
| S5 | Pack and ship an order: https://help.core.cin7.com/hc/en-us/articles/10848179032463-Pack-and-ship-an-order |
| S6 | Customer Credit Notes and Refunds: https://help.core.cin7.com/hc/en-us/articles/9034480981007-Customer-Credit-Notes-and-Refunds |
| S7 | Dropshipping: https://help.core.cin7.com/hc/en-us/articles/9034481322639-Dropshipping |
| S8 | Backorders and Split Orders: https://help.core.cin7.com/hc/en-us/articles/9034480522511-Backorders-and-Split-Orders ; Not enough stock to complete sale: https://help.core.cin7.com/hc/en-us/articles/9034471671055-Not-enough-stock-to-complete-sale |
| S9 | Sales list and order status: https://help.core.cin7.com/hc/en-us/articles/9034586802319-Sales-list-and-order-status |
| S10 | Sale quotes and orders: https://help.core.cin7.com/hc/en-us/articles/10848200373647-Sale-quotes-and-orders |
| S11 | General settings (Document numbers): https://help.core.cin7.com/hc/en-us/articles/9034465203343-General-settings |
| S12 | Cin7 Core API v2: operation maps read via the `cin7-core` MCP map tools (`sale get`, `sale list`, `sale quote-get`, `sale order-get`, `sale invoice-get`, `sale fulfilment-pick-get`, `sale fulfilment-ship-get`, `sale credit-note-get`, `sale payments-get`) and the published reference pages SaleList https://help.core.cin7.com/hc/en-us/articles/9034555593871-SaleList , Sale GET https://help.core.cin7.com/hc/en-us/articles/9034512071951-Sale-GET , Sale POST https://help.core.cin7.com/hc/en-us/articles/9034512161423-Sale-POST , SaleCreditNote https://help.core.cin7.com/hc/en-us/articles/9034586656015-SaleCreditNote , SalePayments https://help.core.cin7.com/hc/en-us/articles/9034555624847-SalePayments , SalePack https://help.core.cin7.com/hc/en-us/articles/9034569202319-SalePack , SaleShip https://help.core.cin7.com/hc/en-us/articles/9034603570831-SaleShip ; API reference https://dearinventory.docs.apiary.io/ |
| S13 | Quote Approval: https://help.core.cin7.com/hc/en-us/articles/9034557973007-Quote-Approval |
| S14 | Customer Management: https://help.core.cin7.com/hc/en-us/articles/9034481027983-Customer-Management |
| S15 | Pricing and price tiers: https://help.core.cin7.com/hc/en-us/articles/9034506082063-Pricing-and-price-tiers |
| S16 | Multicurrency and currency conversion: https://help.core.cin7.com/hc/en-us/articles/9034476155279-Multicurrency-and-currency-conversion |
| S17 | Undo or void a sale: https://help.core.cin7.com/hc/en-us/articles/10848183159695-Undo-or-void-a-sale |
| S18 | What is the Undo function?: https://help.core.cin7.com/hc/en-us/articles/9034570756111-What-is-the-Undo-function-When-is-it-no-longer-possible-to-Undo-an-invoice |
| S19 | Stage-level Undo on Pick/Pack/Ship is described in S17 (no separate article) |
| S20 | Pick items for a sale: https://help.core.cin7.com/hc/en-us/articles/10848183141519-Pick-items-for-a-sale |
| S21 | Accounting transactions in Cin7 Core: https://help.core.cin7.com/hc/en-us/articles/9982480207375-Accounting-transactions-in-Cin7-Core |
| S22 | Community post on multiple picks in advanced sale: https://help.core.cin7.com/hc/en-us/community/posts/16332499641103 (feature request, not official behaviour, not part of the downloaded help center) |
| S23 | Customer Credits: https://help.core.cin7.com/hc/en-us/articles/9034481007375-Customer-Credits |
| S24 | Applying Credit Notes as Part Payment - Sales: https://help.core.cin7.com/hc/en-us/articles/9034459928463-Applying-Credit-Notes-as-Part-Payment-Sales |
| S25 | Returns, refunds, and cancellations in Shopify: https://help.core.cin7.com/hc/en-us/articles/11797034944015-Returns-refunds-and-cancellations-in-Shopify |
| S26 | Calculation of Available, On Hand, and Allocated Stock quantity: https://help.core.cin7.com/hc/en-us/articles/17647517073295-Calculation-of-Available-On-Hand-and-Allocated-Stock-quantity |
| S27 | An Introduction to Cost of Goods Sold (COGS): https://help.core.cin7.com/hc/en-us/articles/9982508174223-An-Introduction-to-Cost-of-Goods-Sold-COGS |
| S28 | Costing Methods: https://help.core.cin7.com/hc/en-us/articles/9034464614415-Costing-Methods |
| S29 | Discounts: https://help.core.cin7.com/hc/en-us/articles/9034464989327-Discounts |
| S30 | Tax rules: https://help.core.cin7.com/hc/en-us/articles/9034574221071-Tax-rules |
| S31 | Credit limits and holds: https://help.core.cin7.com/hc/en-us/articles/9034450723215-Credit-limits-and-holds |
| S32 | Overpayments: https://help.core.cin7.com/hc/en-us/articles/9034518503311-Overpayments |
| S33 | Invoices and payments: https://help.core.cin7.com/hc/en-us/articles/10848169450895-Invoices-and-payments |
| S34 | Sales Bulk Actions: https://help.core.cin7.com/hc/en-us/articles/9034615382927-Sales-Bulk-Actions |
| S35 | Recurring Orders/Invoices: https://help.core.cin7.com/hc/en-us/articles/9034544513423-Recurring-Orders-Invoices |
| S36 | Copy a sales order: https://help.core.cin7.com/hc/en-us/articles/10848200323087-Copy-a-sales-order ; Import sales tasks via CSV: https://help.core.cin7.com/hc/en-us/articles/9034481770127-Import-sales-tasks-via-CSV |
| S37 | Introduction to the sales module: https://help.core.cin7.com/hc/en-us/articles/9034451864719-Introduction-to-the-sales-module |
| S39 | Product Deals: https://help.core.cin7.com/hc/en-us/articles/9034519918095-Product-Deals |
| S40 | Setting Custom Product Prices: https://help.core.cin7.com/hc/en-us/articles/9034569670415-Setting-Custom-Product-Prices |
| S41 | Gift Cards: https://help.core.cin7.com/hc/en-us/articles/9034481642895-Gift-Cards |
| S42 | Stocktake: https://help.core.cin7.com/hc/en-us/articles/9034616083599-Stocktake |
| S43 | Financial settings (period lock date): https://help.core.cin7.com/hc/en-us/articles/11073339810575-Financial-settings ; Monthly Closing Process: https://help.core.cin7.com/hc/en-us/articles/9034491249423-Monthly-Closing-Process-Financial-Periods-Report |
| S44 | Product and measurement settings: https://help.core.cin7.com/hc/en-us/articles/11073339845135-Product-and-measurement-settings |
| S45 | Multiple COGS entries: https://help.core.cin7.com/hc/en-us/articles/9034488169359-Multiple-COGS-entries |
| S47 | Returns (RMAs and Return Orders): https://help.core.cin7.com/hc/en-us/articles/9034548335631-Returns-RMAs-and-Return-Orders ; Undo or void an RMA or return order: https://help.core.cin7.com/hc/en-us/articles/10553610744847-Undo-or-void-an-RMA-or-return-order |
| CLIENT | Page-script findings in `rules/sale-client.md`, cited as `[CLIENT §x]` with that file's section numbers |
| spec | Repo structure map: `spec/modules/06-sale/README.md`, `spec/modules/06-sale/schema.sql`, `spec/data/models.json`, `spec/data/endpoints.csv` |
| observed | Distinct status names only, as seen on a live account; no record-level or business data is reproduced here |
