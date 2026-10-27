# Cin7 Core inventory rules

Rules spec for the inventory module of the clone. Companion to `spec/modules/04-inventory/` (structure), `rules/inventory-client.md` (what the shipped page scripts decide in the browser) and `rules/settings.md` (settings, written separately).

Source: the public Cin7 Core help center, read in full, plus the API shape map, the repo spec and the client-script notes.

## How to read this file

Every rule carries a confidence tag and a source.

| Tag | Meaning |
|---|---|
| **[DOC]** | Stated in a Cin7 Core help-center article (including the API reference pages hosted there). The Source column names the article key. |
| **[API]** | Read from the API shape map in `spec/data/public-api-shapes.json` or the `cin7-core` MCP map tools (`describe_operation`). Field names, enums, required flags only. |
| **[CLIENT]** | Settled by the page-script findings in `rules/inventory-client.md`: what the browser enforces, its message text and button rules. Server-side behaviour is not covered by this tag. |
| **[INFER]** | Not stated by Cin7 anywhere in the help center or the client scripts. Derived from [DOC]/[API]/[CLIENT] facts plus standard inventory accounting. Verify before treating it as exact. |

A note reading `(corrected: ...)` marks a rule that an earlier version of this file got wrong.

Source key (used in the Source column). All keys are help-center articles unless stated:

| Key | URL |
|---|---|
| S-COST | https://help.core.cin7.com/hc/en-us/articles/9034464614415-Costing-Methods |
| S-NONINV | https://help.core.cin7.com/hc/en-us/articles/9034505211663-Non-inventory-products |
| S-CREATE | https://help.core.cin7.com/hc/en-us/articles/12047211508879-Create-products-and-services |
| S-INTRO | https://help.core.cin7.com/hc/en-us/articles/9034539857295-Introduction-to-products-and-services |
| S-LIST | https://help.core.cin7.com/hc/en-us/articles/12047211541391-Products-and-services-list |
| S-DELETE | https://help.core.cin7.com/hc/en-us/articles/9034497926543-Delete-products |
| S-PRODUCTS | https://help.core.cin7.com/hc/en-us/articles/9034494038671-Products (API reference page) |
| S-ADJ | https://help.core.cin7.com/hc/en-us/articles/9034574097039-Stock-adjustment-and-revaluation |
| S-ACCT | https://help.core.cin7.com/hc/en-us/articles/9982480207375-Accounting-transactions-in-Cin7-Core |
| S-XFER | https://help.core.cin7.com/hc/en-us/articles/9034487790095-Stock-transfers |
| S-XFERCOST | https://help.core.cin7.com/hc/en-us/articles/10553608889871-Allocate-costs-to-stock-transfers-and-adjustments |
| S-LANDED | https://help.core.cin7.com/hc/en-us/articles/9034516716047-Landed-cost-expense-distribution |
| S-STKT | https://help.core.cin7.com/hc/en-us/articles/9034616083599-Stocktake |
| S-STKT-POS | https://help.core.cin7.com/hc/en-us/articles/10553580426895-Stocktake-in-POS |
| S-STKT-WMS | https://help.core.cin7.com/hc/en-us/articles/10664511012111-Stocktake-with-WMS |
| S-BATCH | https://help.core.cin7.com/hc/en-us/articles/9034605081231-Working-with-batch-and-serial-numbers |
| S-BATCHFIX | https://help.core.cin7.com/hc/en-us/articles/17348137673231-Unable-to-select-the-Batch-Number-re-entered-through-Stock-Adjustment-when-using-the-FIFO-batch-costing-method |
| S-PICK | https://help.core.cin7.com/hc/en-us/articles/10848183141519-Pick-items-for-a-sale |
| S-PICKSTK | https://help.core.cin7.com/hc/en-us/articles/9034539220879-Picking-stocks |
| S-PMSET | https://help.core.cin7.com/hc/en-us/articles/11073339845135-Product-and-measurement-settings |
| S-PURCHSET | https://help.core.cin7.com/hc/en-us/articles/11073310369679-Purchase-process-customization-settings |
| S-SALESET | https://help.core.cin7.com/hc/en-us/articles/11073350145935-Sale-process-customization |
| S-ACCRUAL | https://help.core.cin7.com/hc/en-us/articles/9034465644559-Inventory-Accrual-and-Stock-in-Transit-implementation-GRNI-GINR |
| S-CHART | https://help.core.cin7.com/hc/en-us/articles/9034460268815-Charts-of-accounts-and-other-financial-settings |
| S-COGS | https://help.core.cin7.com/hc/en-us/articles/9982508174223-An-Introduction-to-Cost-of-Goods-Sold-COGS |
| S-COGS2 | https://help.core.cin7.com/hc/en-us/articles/9034488169359-Multiple-COGS-entries |
| S-AVGCOST | https://help.core.cin7.com/hc/en-us/articles/9034464211343-Average-Cost |
| S-VALUE | https://help.core.cin7.com/hc/en-us/articles/9034450506895-Calculate-current-and-historical-inventory-value |
| S-IMS | https://help.core.cin7.com/hc/en-us/articles/9034436435855-Inventory-Movement-Summary-Report |
| S-SOH | https://help.core.cin7.com/hc/en-us/articles/12047267533071-Set-stock-on-hand |
| S-OPEN | https://help.core.cin7.com/hc/en-us/articles/9034487616015-Manage-opening-balances-conversions |
| S-WRITEOFF | https://help.core.cin7.com/hc/en-us/articles/9034490040079-Inventory-write-off |
| S-UNSTOCK | https://help.core.cin7.com/hc/en-us/articles/9034587737871-Unstock-incorrectly-received-items |
| S-CREDIT | https://help.core.cin7.com/hc/en-us/articles/9034480981007-Customer-Credit-Notes-and-Refunds |
| S-ASM | https://help.core.cin7.com/hc/en-us/articles/9034464144015-Assembly |
| S-BOMASM | https://help.core.cin7.com/hc/en-us/articles/9034480629647-Bill-of-materials-assembly |
| S-DISASM | https://help.core.cin7.com/hc/en-us/articles/9034497989135-Disassembly |
| S-AUTOASM | https://help.core.cin7.com/hc/en-us/articles/11952177561743-Auto-assembly |
| S-MULTILVL | https://help.core.cin7.com/hc/en-us/articles/9034476129295-Multi-level-Assembly |
| S-ASMCOST | https://help.core.cin7.com/hc/en-us/articles/10553608901263-Allocate-costs-to-assemblies |
| S-PRODBOM | https://help.core.cin7.com/hc/en-us/articles/9034493208847-Production-BOM |
| S-PHANTOM | https://help.core.cin7.com/hc/en-us/articles/9034491863567-Phantom-BOM |
| S-UOM | https://help.core.cin7.com/hc/en-us/articles/9034463961231-Additional-Units-of-Measure |
| S-FAMILY | https://help.core.cin7.com/hc/en-us/articles/9034519955855-Product-families |
| S-CALC | https://help.core.cin7.com/hc/en-us/articles/17647517073295-Calculation-of-Available-On-Hand-and-Allocated-Stock-quantity |
| S-AVAIL | https://help.core.cin7.com/hc/en-us/articles/9034523140879-ProductAvailability (API reference page) |
| S-AVAILUI | https://help.core.cin7.com/hc/en-us/articles/9034588181263-View-product-availability |
| S-AVAILRPT | https://help.core.cin7.com/hc/en-us/articles/9034522979343-Product-Availability-Report |
| S-STOCKLVL | https://help.core.cin7.com/hc/en-us/articles/9034541060495-Products-Stock-Level-Report |
| S-REORDER | https://help.core.cin7.com/hc/en-us/articles/9034541036559-Products-Reordering-Report |
| S-LOWSTOCK | https://help.core.cin7.com/hc/en-us/articles/9034475105167-Low-stock-reorder |
| S-REORDERPARAM | https://help.core.cin7.com/hc/en-us/articles/10553627492239-Set-reorder-parameters |
| S-LOC | https://help.core.cin7.com/hc/en-us/articles/9034487246735-Locations |
| S-BINS | https://help.core.cin7.com/hc/en-us/articles/11321150323727-Bins |
| S-NOSTOCK | https://help.core.cin7.com/hc/en-us/articles/9034471671055-Not-enough-stock-to-complete-sale |
| S-RECALL | https://help.core.cin7.com/hc/en-us/articles/9034450417167-Batch-Lot-Recall |
| S-GIFT | https://help.core.cin7.com/hc/en-us/articles/9034481642895-Gift-Cards |
| S-FIXED | https://help.core.cin7.com/hc/en-us/articles/9034435967887-Fixed-assets |
| S-LIGHTSPEED | https://help.core.cin7.com/hc/en-us/articles/9034588105359-Lightspeed-FAQs |
| API-SHAPES | `spec/data/public-api-shapes.json` (groups Product, Product Family, Stock, Inventory Write-Off, Location) |
| API-MAP | `cin7-core` MCP `describe_operation`: `stock adjustment-get`, `stock transfer-get`, `stock take-get`, `product availability-list` |
| CLIENT-INV | `rules/inventory-client.md` (cited by section number) |

## ⚠️ Gotchas: the sneaky stuff

Ranked worst first: silent money or stock errors at the top, annoyances at the bottom.

> [!CAUTION]
> **Set stock on hand is not an update; on existing balances it duplicates stock**
>
> You would assume it overwrites quantities. It does not: re-running it creates new product instances next to the old ones, so use adjustments or stocktakes after go-live [DOC]. A wrong opening cost can be fixed by voiding the Set-stock-on-hand action and re-uploading, but if transactions already used that stock they must be undone first [DOC]. [details](#24-average-cost)

> [!CAUTION]
> **COGS comes from the purchase invoice, not from the receipt**
>
> Cost is calculated when the purchase invoice is authorised; stock enters when stock received is authorised. Ship stock whose invoice is not authorised and COGS posts as 0, then catches up dated on the invoice date. Later cost changes add a second COGS entry instead of editing the first [DOC]. [details](#25-cogs-timing-and-dating)

> [!CAUTION]
> **A new stock-adjustment line is dated "received today", whatever the effective date says**
>
> The effective date only dates the journals. Stock added by an adjustment or stocktake gets a received date of the day it is completed, so under FIFO and FIFO (Batch) a batch found and re-entered this way is picked last, not first [DOC]. Use a Special method when a specific batch must be pickable. [details](#42-quantity--cost-effects-on-completed)

> [!CAUTION]
> **Costing method can change with stock on hand, but the change can destroy batch data and can never go to a serial method**
>
> (corrected: an earlier version said the method is locked while stock is non-zero.) Changes are allowed from the product page or by CSV, subject to a one-way matrix: any non-serial method to any serial method is refused once the SKU has history. Some moves silently discard numbers (Special to FIFO) or lose them (FIFO (Batch) to Special (Batch)) [DOC]. [details](#22-costing-method-change-rules)

> [!CAUTION]
> **Landed cost only reaches stock value if the debit account is the same inventory account as the lines**
>
> An expense debit is accepted but is booked as business expense and never raises stock value. A manual journal posted to a different inventory account than the item lines also does not capitalise, and the stock value then drifts from the balance sheet [DOC]. Adjustments accept manual distribution only [DOC]. [details](#52-landed-costs-on-transfers)

> [!CAUTION]
> **A missing accrual mapping silently switches accrual postings off**
>
> With the accrual setting off or an account unmapped, purchases revert to real-cost-only postings and no error appears. Both accrual accounts must differ from each other and from every other mapped account [DOC]. Extra cost lines on a PO are not part of the accrual amount [DOC]. [details](#12-inventory-journal-entries-summary-level)

> [!WARNING]
> **Revaluation is a write-off plus a re-add, and void stops working once the stock has moved**
>
> There is no revalue operation. You zero the existing line and add the same quantity as new stock at the new unit cost, so the posting is two movements [DOC]. A completed adjustment or stocktake cannot be voided once the stock has been sold, transferred or used in production [DOC]. [details](#41-state-machine)

> [!WARNING]
> **Auto-assembly and auto-disassembly fire at different moments and different places**
>
> Auto-assembly triggers on sale authorisation, only from components at the sale location regardless of pick settings, and never builds a partial assembly. Auto-disassembly triggers when stock received is authorised (both stock received and invoice for advanced purchases), never on a sale [DOC]. Available shows the same stock in several pack sizes at once, and nested kits are picked as components or as sub-assemblies depending on each level's flag [DOC]. [details](#14-bill-of-materials-types)

> [!WARNING]
> **A stocktake locks the whole location, and a bin filter counts more than that bin**
>
> While IN PROGRESS the location cannot be used, sold or moved, and incoming orders wait as pending [DOC]. A bin filter selects the products found in that bin, then counts ALL instances of those products in the location [DOC]. Only Stock-type products appear, and negative stock or stale quantities can make the completion fail with a discrepancy error [DOC]. [details](#62-freeze--lock)

> [!WARNING]
> **Average cost looks authoritative but does not drive COGS, and it stops moving at zero on hand**
>
> Posted COGS comes from FIFO/FEFO/Special layers; average cost is for margin estimates, finished-good estimates and price tiers. It freezes at its last value when on hand reaches 0 and revaluation resets it only until the next movement [DOC]. [details](#24-average-cost)

> [!WARNING]
> **Serial and batch numbers are not checked for uniqueness, and FIFO/FEFO picking is advice unless a setting enforces it**
>
> Duplicates are accepted on receiving across orders (only one receiving action rejects its own duplicates), adjustments and stocktakes [DOC]. Scanning lets a picker take any batch; a product-and-measurement setting chooses between no check, warn, or enforce (corrected: not an Advanced WMS feature) [DOC]. [details](#7-batch-serial-expiry-handling)

> [!WARNING]
> **Delete needs deprecated, never used (drafts included) and not linked to any channel**
>
> Draft documents count as use, and a product listed on B2B, POS or another channel cannot be deleted until it is unlisted. The bulk delete-deprecated action quietly skips the products it cannot remove [DOC]. Deprecating a product that still has stock on hand is not documented as blocked [INFER]. [details](#13-product-status-state-machine)

> [!WARNING]
> **Short stock does not block a sale; the order just sits in Picking, and negative on hand can still happen**
>
> Authorising a sale with short stock only prompts for split, backorder or purchase order. Fulfilment then waits in Picking until stock exists [DOC]. Negative on hand arises from backdated receipts or adjustments, and a transfer over available is only shown in red by the client [DOC][CLIENT]. No global allow-negative switch is documented. [details](#9-negative-stock)

> [!NOTE]
> **Saving or creating a product family overwrites fields on its variations**
>
> Category, default location, brand, descriptions, reorder fields, drop-ship mode, accounts, tax rules, prices, country of origin and tags are rewritten on the variations when the family is created or updated. Export the inventory list first if per-variation values matter [DOC]. [details](#10-product-families-and-variants)

---

## 1. Product master

### 1.1 Product types

| Type | Moves stock? | Availability check on sale/purchase | Notes | Source |
|---|---|---|---|---|
| Stock | Yes. Has OnHand, Allocated, cost layers, journals. | Yes. | The only type that appears in stocktakes. Carries a costing method that matters, inventory/COGS accounts, locations, bins, reorder levels. Product Stock tab, Movements tab and Reorder levels are for this type. [DOC][CLIENT] | S-CREATE, S-STKT, CLIENT-INV 1.5 |
| Service | No. | No. | Account fields that apply only to Stock products (inventory, COGS) are ignored for services; the expense account applies to services instead. Can be written off and used as a labour or overhead line on a BOM. Average cost is editable. Has a Usage tab instead of Movements. [DOC][CLIENT] | S-CREATE, S-PRODUCTS, S-WRITEOFF, CLIENT-INV 1.1 |
| Non-inventory | No. Separate rules below. | No. Can be bought or sold without a stock check. | Cannot be reordered, backordered, restocked or unstocked, received into stock, disassembled, written off, or given additional units of measure. No cost transaction on sale; invoicing it posts Dr Accounts Receivable and Cr the account on the invoice. As a BOM component it adds no cost to the assembly. Expense account is mandatory; "Always show quantity" applies only here. Excluded from Sales Profit Summary and Sales by Product Details. Can be created inline from Sale, Purchase and Advanced purchase pages. Always/optional drop-ship still applies. Client allows only FIFO costing. [DOC][CLIENT] | S-NONINV, S-CREATE, S-ACCT, CLIENT-INV 1.7 |
| Fixed asset | No stock. Separate Fixed Asset Type model. | n/a | Needs a Fixed Asset Type and a fixed-asset location (kept separate from stock locations even when the place is the same). Quantity comes from a purchase invoice, adjustment or stocktake, then the asset is registered and depreciated. Unavailable when Xero is the accounting system. Client forces costing method Special (Serial) and disables the field. (corrected: the intro does not say BOM items count as non-inventory; the non-inventory article lists BOM items as one use case.) [DOC][CLIENT] | S-FIXED, S-INTRO, CLIENT-INV 1.5 |
| Gift card | No stock. | n/a | Only one gift-card product exists; it appears automatically once gift cards are enabled and is paid for in the base currency only. Revenue goes to a liability account. Not usable through third-party e-commerce channels. HS code and country blanking never fires from the client. [DOC][CLIENT] | S-GIFT, S-CREATE, CLIENT-INV 1.2 |

Type values: the API reference page accepts `Stock` or `Service` for `Type` on write [DOC]; the client's type store holds `Stock`, `Service`, `GiftCard`, `Non Inventory`, `Fixed Asset` [CLIENT]. (corrected: earlier note said the API strings were unknown.)

### 1.2 Required fields and validations (product form)

| Rule | Detail | Tag | Source |
|---|---|---|---|
| Required to save as Active | SKU (max 50), Name (max 256), Type, Category (max 256), Costing method (max 50), Unit of measure (max 50). Client also demands the Fixed Asset Type for fixed assets. | [DOC]+[API]+[CLIENT] | S-CREATE, API-SHAPES, CLIENT-INV 1.7 |
| Required by API POST | SKU, Name, Category, CostingMethod, DefaultLocation, UOM, Type and Status. | [DOC]+[API] | S-PRODUCTS, API-SHAPES |
| Product status | `Active`, `Deprecated`, `Setup required` in the UI; the API accepts only Active and Deprecated. Client codes are A, D, P. (corrected: the API gap is now explained, Setup required is UI-only.) | [DOC]+[CLIENT] | S-CREATE, S-PRODUCTS, CLIENT-INV 1.1 |
| Setup required | Marks a product with missing mandatory fields (typical for products downloaded from an integration) and can also be set on purpose when the product is not ready. Cannot be used in transactions. Make-to-order configuration errors also push a product here via a client prompt. | [DOC]+[CLIENT] | S-CREATE, CLIENT-INV 1.7 |
| SKU uniqueness | SKUs must be unique; each family variation has its own unique SKU. Not acceptable: all digits with a leading 0 (breaks CSV import/export), and any leading space (breaks sync). All digits not starting with 0 is fine. Case sensitivity and the error text are not published. | [DOC] | S-CREATE, S-FAMILY |
| Import limits | Inventory-list import takes at most 5000 lines; column headings and their order must not change. Export-edit-reimport is the bulk edit path. | [DOC] | S-CREATE |
| Length limits | SKU 50, Name 256, Category 256, Brand 50, Barcode 256, ShortDescription 500, InternalNote 4000, AdditionalAttribute1..10 256 each, Tags 256, StockLocator 256, PickZones 256, UOM 50, DefaultLocation 50, account fields 50. Family SKU is 45 in the help text. | [API]+[DOC] | API-SHAPES, S-FAMILY |
| Defaults for new products | Costing method, UOM, location, tax rules and accounts default from "Default field values for new products". Client defaults: Type Stock, Status Active, costing FIFO, quantity to produce 1, cost estimate Average, location = the only one or the flagged default. | [DOC]+[CLIENT] | https://help.core.cin7.com/hc/en-us/articles/9034451009935-Default-field-values-for-new-products-customers-and-suppliers, CLIENT-INV 1.4 |
| Not sellable | "I am selling this product" = No hides the product from sale selection while leaving it available for purchase and production. Stored inverted in the client. | [DOC]+[CLIENT] | S-CREATE, CLIENT-INV 1.1 |
| Accounts | Inventory, COGS, Revenue accounts are optional per product and editable on documents. Non-inventory needs an expense account. A liability revenue account is allowed but makes the sale overview and P&L disagree. With several matching rules the highest-priority revenue account or tax rule wins. API: COGS is an EXPENSE-class account, inventory an ASSET-class account that is not FIXED or BANK. | [DOC] | S-CREATE, S-PRODUCTS |
| Dropship | Always, optional or never (API strings "Always Drop Ship", "Optional Drop Ship", "No Drop Ship"). A supplier must be assigned to drop-ship. Client codes N, O, A. | [DOC]+[CLIENT] | S-CREATE, S-PRODUCTS, CLIENT-INV 1.1 |
| Reorder fields | Minimum before reorder and reorder quantity are defaults; a location row can override them. Negative entries become 0 in the client; make-to-order products save 0. | [DOC]+[CLIENT] | S-CREATE, CLIENT-INV 1.1 |
| Identity fields | Barcode enables scan-based picking and packing. HS code and country of origin are passed to channels that take them. Stock locator and pick zones (pick zones matter only with the WMS app). | [DOC] | S-CREATE |
| Permissions | Changing a costing method needs the Products and Families inventory permission; BOM edits need the Bill of materials permission too. | [DOC] | S-COST, S-BOMASM |
| Clone | Clone copies a product to a new draft; the client drops supplier codes, images, additional units and any production BOM on copy and shows a save-the-copy notice. | [DOC]+[CLIENT] | S-CREATE, CLIENT-INV 1.11 |
| Merge | Merge folds several products into a primary; irreversible; every transaction is repointed to the primary, merged products take its values, and channel links move to it. Must also be repeated in the accounting software. Needs two or more products. | [DOC]+[CLIENT] | S-LIST, CLIENT-INV 1.11 |
| Movements tab | Shows purchases, sales, adjustments, stocktakes, transfers, restocks, unstocks and finished goods, as quantity, quantity and cost, or availability effect. | [DOC] | S-CREATE |
| Duplicate lookup | API `product` list accepts `Sku`/`Name` filters (prefix match), `IncludeDeprecated` (deprecated hidden by default). | [API]+[DOC] | API-MAP, S-PRODUCTS |

Client save-time checks and message text are catalogued in CLIENT-INV 1.7 (non-inventory FIFO-only, drop-ship with production BOM, empty BOM, carton volume without unit, and so on); they are not repeated here.

Settings that change this: **Product and measurement settings** (SKU auto-generation, weight and dimension units, transfer received-date rule, FIFO/FEFO recommendation), **Default field values for new products**. See `rules/settings.md`.

### 1.3 Product status state machine

| From | Action | To | Who | Validation / effect | Tag | Source |
|---|---|---|---|---|---|---|
| (new) | Save with all required fields | Active | Product-edit permission | | [DOC] | S-CREATE |
| (new/import) | Save with missing mandatory fields | Setup required | System (or user, on purpose) | Cannot be used in any transaction until fixed. | [DOC] | S-CREATE |
| Active | Set Deprecated (single, or bulk through inventory-list CSV) | Deprecated | Product-edit permission | Record kept; product unavailable for sale, purchase, production and other operations and absent from product drop-downs. Hidden from the list unless "only active" is cleared. Stock Level report shows active products only, while Inventory Movement Summary includes deprecated ones. No stock or open-document check is documented. | [DOC]+[INFER] | S-DELETE, S-STOCKLVL, S-IMS |
| Deprecated | Set Active | Active | Product-edit permission | Reappears in drop-downs. | [INFER] | S-DELETE |
| Deprecated | Delete (single, or More actions > Delete deprecated products) | (removed) | Delete permission | Only if never used in any transaction or operation, draft ones included (void them to free the product; the Movements tab shows where it is used), and not linked to an external sales channel (B2B, POS and others). The bulk action deletes the eligible deprecated products and skips the rest. | [DOC] | S-DELETE |
| Active | Delete without deprecating first | blocked | | Must deprecate before delete. | [DOC] | S-DELETE |

Deprecated product consequences for integrations: automatic adjustments from Lightspeed fail when a product does not exist, was deleted or is deprecated; they also fail for non-FIFO products because batch data is not available there. [DOC] S-LIGHTSPEED.

Deleting a product family first deprecates every variation, then deletes the unused ones and the family itself; variations with transactions stay behind as deprecated (corrected: the family is always deleted). [DOC] S-FAMILY.

### 1.4 Bill of materials types

The product form has a Bill of materials tab and `BillOfMaterial`, `BOMType`, `AutoAssembly`, `AutoDisassembly`, `QuantityToProduce`, `AssemblyCostEstimationMethod`, `AssemblyInstructionURL` fields. [API] The client BOM selector holds `no`, `bom` (Assembly), `pbom` (Production) and `mto-bom` (make-to-order), stored as three booleans. [CLIENT]

| BOM type | Use | Rules | Source |
|---|---|---|---|
| None | Plain stock product | `BillOfMaterial` false. | API-SHAPES |
| Assembly BOM | Simple joins: kits, packs, case-to-single breakdown | Components must exist first and may be stock products and services (labour and overheads lines need an expense account and a price tier as cost basis). Quantity to produce is the yield (default 1). Wastage % and wastage quantity are mutually exclusive; both locked for serial-numbered components in the client. Disassembly cost % per line must total 100%; blank means the parent cost is split equally between the LINES, ignoring each line's quantity. A product cannot be a component of its own component (circular BOMs stop assembly and disassembly orders from authorising). Duplicate component or service lines are rejected and an empty BOM cannot be saved. Cost estimate on the BOM (Average, Latest purchase, Fixed purchase) is reference only. For a manual assembly the BOM is a draft that can be edited on the order. Components can be replaced in bulk across assembly, production and family BOMs. CSV import/export of BOMs exists (action Create/Update/Delete; delete removes components only). Statuses DRAFT, WORK IN PROGRESS, COMPLETED, VOIDED. | S-BOMASM, S-ASM, S-DISASM, CLIENT-INV 1.6 |
| Production BOM | Multi-step manufacturing | Part of the Advanced Manufacturing add-on. Components, operations, resources, versions (one default). Produces Production orders and Finished goods tasks. Cost estimate can use average cost only. Out of scope for this file, see production rules. [DOC] | S-PRODBOM, S-AVGCOST |
| Auto-assembly (flag on an Assembly BOM) | Hold only components; build the finished good on demand | Stock of the finished product is virtual: Available = what could be built from available components. Sale authorisation triggers an assembly order; the date follows the latest authorisation if a sale is undone and re-authorised. Never builds a partial assembly and never triggers without enough components at the sale location, whatever the pick settings say. Builds the sale quantity first, then, where settings allow, enough to refill negative stock. Components and wastage cannot be edited on the order. Supported costing methods: FIFO, FIFO (Batch) and Special (Batch). (corrected: "FIFO (Special)" in the help text is not a real method; the client script lists exactly those three.) Quantity built is chosen by the sale-process setting: sale quantity only; sale quantity plus minimum-stock buffer (sale qty - (minimum before reorder + reorder qty + on order - available)); or only the shortfall (sale qty - available - on order). Split-order handling of auto-assembled lines is a separate setting. Integration channels have their own "process auto-assembly as" option. Short components can be backordered or sent to the Out-of-stock components report; after receiving them undo and re-authorise the sale. | S-AUTOASM, S-SALESET, CLIENT-INV 1.3 |
| Auto-disassembly (flag) | Receive cases, hold singles | Triggers when stock received is authorised on a simple purchase; on an advanced purchase both stock received and invoice must be authorised. Also triggers when an auto-assembled product is restocked from a credit note. Not triggered by sales. Results land in the PO's receiving location and cannot be altered. Never allowed on non-inventory. 5 received 12-packs show 60 singles OnHand, but 5 12-packs, 10 6-packs and 60 singles Available. The help text allows FIFO, FIFO (Batch), "FIFO (Special)" and Special (Batch); the client also lists FEFO (Batch). Recommended only when the assembled product is not sold. | S-DISASM, S-BOMASM, CLIENT-INV 1.6 |
| Phantom BOM | Secondary unit of measure; nested kits in production | Created by the system when an additional unit of measure is added: an assembly BOM with auto-assembly and auto-disassembly on, linked to the base product. Inside a production order a phantom is exploded to its components without making an assembly order. A product with additional units cannot also use an auto-assembly BOM. | S-PHANTOM, S-UOM |
| Multi-level assembly | Kits inside kits | Auto-assembly on a level means its components are picked and pre-assembled units of that level are ignored; manual assembly on a level means pre-assembled units are picked and its components ignored. A manual level under an auto level with no pre-assembled stock leaves the auto-assembly unable to complete. Support recommends auto on the top level only. | S-MULTILVL |

BOM quantity/cost effects:

| Event | Component SKU | Finished SKU | Cost | Source |
|---|---|---|---|---|
| Assembly order authorised | Allocated += component qty (reserved); short components show red and go to backorder candidates | OnOrder += qty (authorised finished goods) | n/a | S-AVAIL, S-ASM [DOC] |
| Assembly pick/allocate step done | OnHand -= qty used (incl. wastage); value moves to the work-in-progress account (components must sit at the assembly location) | | Dr WIP, Cr Inventory | S-ASM, S-ACCT [DOC] |
| Assembly order completed | | OnHand += actual yield (editable) ; OnOrder -= | Finished unit cost = components consumed (each by its own costing method) + labour/overhead services. Dr Inventory, Cr WIP; services Dr Inventory, Cr labour/overheads account | S-ASM, S-COGS, S-ACCT [DOC] |
| Assembly serial/batch | Assembled products get a system-generated serial that cannot be typed in; production outputs can be given a serial until put away and not after they are sold, transferred or adjusted | | | S-BATCH [DOC] |
| Assembly order voided | reverse the above | reverse the above | Reverses cost layers. | [INFER] |
| Disassembly completed | OnHand += components | OnHand -= qty (whole quantity only; no partial disassembly) | Component cost = parent cost by disassembly cost % (equal per line if blank). Rounding differences in the split must be corrected in the Total cost field of the Result tab or completion fails. Dr WIP, Cr Inventory for the parent; Dr Inventory, Cr WIP for components | S-DISASM, S-ACCT [DOC] |
| Re-assembly after disassembly | | | Cost can differ from the original because the next unused cost layer is taken, which may be older stock. | S-DISASM [DOC] |

Settings that change this: **Production / manufacturing settings**, **Sale process customization** (auto-assembly quantity, split of auto-assembled lines, "Available quantity is limited to"), **Assembly cost estimation method** on the product (`AssemblyCostEstimationMethod`: A, L, F in the client). See `rules/settings.md`.

---

## 2. Costing methods and cost layers

### 2.1 The methods

| Method (UI label) | Tracks | Pick order | Expiry date | Source |
|---|---|---|---|---|
| FIFO | Quantity only; no batch or serial can be kept | Oldest first, measured from the "Date received" on stock received, not the authorisation date | no | S-COST |
| FIFO (Batch) | Batch number, mandatory at receiving and pick | Oldest first | optional | S-COST, S-BATCH |
| FIFO (Serial Number) | Serial number, mandatory | Oldest first | optional | S-COST |
| FEFO (Batch) | Batch + expiry; a batch is generated if none is given | First expiring first | **mandatory** | S-COST, S-BATCH |
| FEFO (Serial Number) | Serial + expiry | First expiring first | **mandatory** | S-COST, S-BATCH |
| Special (Batch) | Batch; a batch is generated if none is given | Auto-pick follows first-in, user may change the batch; no order enforced | optional | S-COST, S-BATCH |
| Special (Serial Number) | Serial | Auto-pick follows first-in, user may select any unit | optional | S-COST, S-BATCH |

All [DOC]. There are seven methods. `CostingMethod` is a required product field and is also stored on `ProductLocation`. [API] API/CSV strings are exactly: "FIFO", "FIFO - Batch", "FIFO - Serial Number", "FEFO - Batch", "FEFO - Serial Number", "Special - Batch", "Special - Serial Number" (corrected: earlier note said these were unknown). [DOC] S-PRODUCTS. Client codes: FIFO, FIBATCH, FISN, FEBATCH, FESN, BATCH, SN. [CLIENT]

Transfer date rule: setting "Update stock received date with transfer completion date". Off, a transferred unit keeps its original received date; on, the date becomes the transfer completion date, so a transferred unit queues behind stock received in between. [DOC] S-PMSET.

### 2.2 Costing-method change rules

(corrected: the earlier rule "cannot change while stock on hand is non-zero" is wrong. Change is allowed with stock on hand, under the matrix below.)

| Rule | Tag | Source |
|---|---|---|
| Change on the product page, or in bulk with Export/Import "Bulk costing method change" (rows with no new method are skipped). Needs the Products and Families permission. | [DOC] | S-COST |
| Non-serial to serial is never allowed on a SKU with history (purchase, sale, assembly, production, write-off, adjustment and so on). Create a new SKU. The client checks the inventory card and reverts with an error; with no card the change is a plain edit. | [DOC]+[CLIENT] | S-COST, CLIENT-INV 1.3 |
| Serial to any other method is allowed. Going to a batch or serial method keeps existing numbers and expiry dates; going to FIFO discards them; Special (Serial) to Special (Batch) turns serials into batches. | [DOC] | S-COST |
| FIFO to a batch method (FIFO/FEFO/Special Batch) is allowed: a batch number is mandatory (expiry optional) and is applied only to stock that never had a batch record. | [DOC] | S-COST |
| FIFO (Batch) to FEFO (Batch) needs batch and expiry for the existing stock. FIFO (Batch) to Special (Batch) does not preserve numbers; new ones must be entered. Any batch method to FIFO ignores batch and expiry. | [DOC] | S-COST |
| Changing the method while a transaction is open (for example paying a PO that was invoiced and received earlier) causes errors; the documented fix is to change it back. | [DOC] | S-COST |
| Extra client blocks: make-to-order products allow only serial, batch and special methods; auto-assembly allows only FIFO, FIFO (Batch), Special (Batch); non-inventory allows only FIFO; fixed assets are forced to Special (Serial). | [CLIENT] | CLIENT-INV 1.3, 1.7 |
| Batch/serial entry at receiving or picking only works when the product's method is a batch or serial one. Tracking is switched on by the costing method; there is no separate flag. | [DOC] | S-BATCH |
| Serial/batch uniqueness is not checked on receiving across orders, adjustment, stocktake or anywhere else; duplicates can exist. A single receiving action does reject duplicate serial numbers within itself. (corrected: earlier text said uniqueness is never checked.) | [DOC] | S-BATCH, S-COST |

### 2.3 How cost layers are created and consumed

Cin7 does not expose cost layers as an entity; the layers live behind `InventoryCard`/`vProductMovement` rows (CardDetailsID, Quantity, Amount, BatchSN, ExpiryDate, Location, Date). A layer is one receipt line of one product at one location (and batch/serial/expiry where tracked). [INFER from table shape: `spec/modules/04-inventory/schema.sql` `vProductMovement`; CLIENT-INV 5 lists the same movement fields]

Core principle: cost is calculated when the purchase invoice is authorised; stock is added when stock received is authorised. With no authorised invoice, or an invoice with no cost, the stock value is 0 although units exist. [DOC] S-ACCRUAL.

| Event | Layer effect | Cost used | Source |
|---|---|---|---|
| Stock received authorised, purchase invoice already authorised (Invoice first) | New layer, qty = received qty | Invoice line cost (landed costs distributed in) | S-ACCRUAL, S-COGS |
| Stock received authorised, no invoice yet (Stock first) | New layer | PO line cost if the PO has one, else product average cost at the moment of authorisation, else 0. Additional costs on the PO are not part of this accrual cost. With accrual off, only real invoice costs are ever recorded. (corrected: now first-party, not a third-party blog.) | S-ACCRUAL |
| Purchase invoice authorised after receipt | Accrual cost movements are reversed by identical negative ones dated on the invoice date and the normal cost movements are created from the invoice. | Invoice cost | S-ACCRUAL |
| Stock adjustment, new stock line (zero-stock lines) | New layer, received date = the day the adjustment is completed (not the effective date) | Unit cost if entered (takes priority); otherwise the header's cost estimate method: Average, Fixed purchase, or Latest purchase cost (accrual costs included for Average and Latest) | S-ADJ, S-BATCHFIX, CLIENT-INV 2.4 |
| Stocktake, zero-stock line counted > 0 | New layer | Unit cost on the line, generated automatically and editable | S-STKT |
| Stock transfer received | New layer at destination | Source layer cost(s) carried over, plus any landed-cost manual journal capitalised to the transfer. Received date either kept or reset to the completion date per the setting. | S-XFER, S-XFERCOST, S-PMSET |
| Assembly/production completed | New layer for finished good | Components consumed (each by its own method) + services | S-ASM, S-COGS |
| Credit note / return to stock (Restock) | Layer returns to stock, restock location can differ from the sale location | Original sale cost; the COGS reversal is dated the credit-note date. A returned restock to a different SKU must have the same costing method. Items with a BOM are auto-disassembled on restock. | S-CREDIT, S-ACCT, https://help.core.cin7.com/hc/en-us/articles/10553586548111-Inspect-and-add-expenses-to-a-return |
| Sale shipment authorised (Ship step) | Layers consumed | Per method (below). Cost comes from the authorised purchase invoice of the picked item. Date is the ship date. | S-COGS |
| Stock adjustment, existing stock line, qty down | Layers consumed | Per method; the line carries no cost of its own | S-ADJ, CLIENT-INV 2.4 |
| Stock adjustment, existing stock line, qty up | Not documented (see Unclear) | | |
| Inventory write-off completed | Layers consumed | Cost calculated from the costing method and prior transactions; expense account on the header; labour and overhead lines are separate | S-WRITEOFF, S-ACCT |
| Landed-cost / manual journal capitalised to inventory | Raises value of existing stock | Debit account must be the same inventory account as the item lines. An expense account does not raise stock value. Distribution by Cost, Quantity, Weight, Volume or Manually depending on the document | S-LANDED, S-XFERCOST |

Consumption order:

| Method | Layer consumed | Source |
|---|---|---|
| FIFO, FIFO (Batch), FIFO (Serial) | Oldest "date received" first. Auto-pick follows this. Web portal and WMS let a picker scan or select any batch/serial; the product-and-measurement setting chooses no check, warn, or enforce. | S-COST, S-PMSET |
| FEFO (Batch/Serial) | Earliest expiry first. Auto-pick, batch recommendation and auto-consume exclude expired stock only when the "Exclude expired batch/serial numbers" setting is on. If Core auto-picked a FEFO batch, the batch of the line cannot be changed. | S-PMSET, S-PICK |
| Special (Batch/Serial) | Auto-pick follows first-in; the user may choose any unit. Cost = that unit's own purchase-invoice cost. | S-BATCH, S-COGS |

Pick location: auto-pick uses the sale location first, then other locations only if the "Available quantity is limited to" setting allows all locations; otherwise the order waits in Picking. [DOC] S-PICK, S-PICKSTK.

### 2.4 Average cost

| Rule | Tag | Source |
|---|---|---|
| Average cost = value on hand / quantity on hand, from the average purchase price including landed costs, using all historical costs; selling price is ignored. | [DOC] | S-AVGCOST |
| It is informational and estimating only. It does not drive posted COGS (FIFO/FEFO/Special layers do) and does not affect P&L. | [DOC] | S-AVGCOST, S-COGS |
| Uses: gross margin estimate = (sale price - average cost) x 100 / sale price (N/A when average cost is 0); finished-good cost estimates (production BOMs can use only this); base for calculated price tiers; fallback receipt cost on Stock-first receipts with no PO cost; default unit cost for new adjustment lines. | [DOC] | S-AVGCOST, S-ACCRUAL, S-ADJ |
| Recalculated on every inventory movement, specifically when a purchase invoice is authorised or a sale shipment is authorised with differing card costs. When on hand reaches 0 the value stops updating and keeps its last figure. | [DOC] | S-AVGCOST |
| Revaluation: the unit cost entered becomes the new Average Cost until further movements change it. | [DOC] | S-ADJ, S-AVGCOST |
| Wrong Average Cost, two cases: (a) the stock value is right and only the reference is wrong (compare the Unit cost in the Stock Level report): import a corrected value through the inventory list, which changes only the informational field; (b) the stock is mis-valued: use an adjustment revaluation. | [DOC] | S-AVGCOST |
| Wrong opening cost from Set stock on hand: void the Set-stock-on-hand action and re-upload. If transactions already took place they must be undone first, then re-authorised after the re-upload. (corrected: earlier text said only while no transactions exist.) | [DOC] | S-AVGCOST |
| Set stock on hand must be used once at go-live; it must not be used on existing balances because it creates new product instances instead of updating quantities. Use adjustments or stocktakes. The Account for imported stock is the default Inventory account unless a product-level one is set. | [DOC] | S-SOH, S-OPEN |
| Service and non-inventory products allow editing the average cost directly; for others it is read-only. | [CLIENT] | CLIENT-INV 1.1 |
| `AverageCost` is a read field on the product (decimal). | [API] | API-SHAPES |
| Report difference: unit cost is the actual-method value on the report date; average cost is the estimate and can differ sharply. | [DOC] | S-IMS |

Settings that change this: **Inventory accrual (GRNI/GINR)**, **Stock in transit account**, **Costing / landed cost settings**, **Default accounts mapping** (Inventory, COGS, Inventory discrepancy). See `rules/settings.md`.

### 2.5 COGS timing and dating

| Rule | Tag | Source |
|---|---|---|
| COGS is created when the Ship tab of a sale is authorised; before that it shows 0. The ship date is the COGS date. | [DOC] | S-COGS |
| Default ship date is today (the authorisation date) or, by setting, the sale invoice authorisation date; the shipment date can also be typed, including a past date. The Ship tab must still be authorised either way. | [DOC] | S-COGS, S-SALESET |
| Costs come from purchase invoices. If stock is picked and shipped before its invoice is authorised, COGS can be 0 at ship time; it updates on the date the purchase invoice is authorised, using the purchase invoice date. | [DOC] | S-COGS |
| Drop-ship products have no Ship tab; COGS posts when the purchase invoice is authorised, dated the invoice date. PO authorisation posts none. | [DOC] | S-COGS, S-ACCT |
| Additional COGS entries come from manual journals and landed costs: if created before the ship date they use the ship date; if created after, the journal's effective date. A second COGS journal is added when landed costs arrive after shipping. | [DOC] | S-COGS, S-LANDED |
| Historic COGS entries are never edited: cost events dated later add a new entry dated at the cost change date, for invoices and credit-note restocks alike. | [DOC] | S-COGS2 |
| No transaction can be created in a closed accounting period. Authorising a shipment whose default date falls in a locked period errors until a later date is entered; that date becomes the COGS effective date. | [DOC] | S-COGS |
| Several ship dates: the posting uses the maximum shipment date. | [DOC] | S-ACCT |
| Report filters "only COGS within range" (transaction dates) and "All COGS" (invoice/order date, COGS shown whenever shipped, 0 if not yet shipped) give different totals on the sale profit, sales by product and credit-notes-by-product reports. | [DOC] | S-COGS |

---

## 3. Quantity fields per location / bin / batch

Fields returned by `GET /ref/productavailability` (one row per product x location x bin x batch/serial x expiry): `OnHand`, `Allocated`, `Available`, `OnOrder`, `StockOnHand` (stock value), `InTransit`, `NextDeliveryDate`. [API-MAP] The public ProductAvailability page lists `ID, SKU, Name, Barcode, Location, Bin, Batch, ExpiryDate, OnHand, Allocated, Available, OnOrder, StockOnHand`; the endpoint returns a row only when available, on hand or on order is non-zero; `Batch` is empty for FIFO products and for allocated stock that has not been picked. [DOC] S-AVAIL

| Field | Definition | Tag | Source |
|---|---|---|---|
| OnHand | Quantity physically expected in the warehouse, from actual transactions or inventory cards. Includes goods on sale orders not yet fulfilled; excludes purchase orders not yet received. | [DOC] | S-CALC |
| Allocated | Quantity reserved by authorised sale tasks and finished-goods (assembly/production) tasks, from authorisation until shipped. | [DOC] | S-CALC, S-AVAILRPT |
| Available | OnHand - Allocated; for auto-assembly/auto-disassembly products, plus what could be made from available components. Computed either across all locations or only the selected location, depending on the "Available quantity is limited to" setting, and also per location/batch/expiry. | [DOC] | S-CALC, S-AVAIL, S-SALESET |
| OnOrder | Quantity on authorised purchase orders (or authorised finished-goods tasks) not yet received. | [DOC] | S-AVAIL |
| InTransit | Quantity in transit; the drill-down links purchases, advanced purchases, stock transfers and production orders with Order, Supplier, Date, Required by, Quantity and Next delivery. A location cannot be deleted until its in-transit quantity is 0. The Inventory Movement Summary does not include stock in transit unless accrual is enabled. | [CLIENT]+[DOC] | CLIENT-INV 5, S-LOC, S-IMS |
| NextDeliveryDate | Expected delivery date of the stock on order, regardless of whether the product is in stock. Used in Products Reordering/Availability. | [DOC] | S-AVAILRPT |
| StockOnHand | Stock value (cost), not a quantity. Column header "Stock value"; hidden for users without the stock value permission. | [API]+[CLIENT] | CLIENT-INV 5 |

Report behaviour that explains differences: the Availability report lists only SKUs that have had a movement or an initial quantity (the Stock Level report lists all active SKUs); the Stock Level report ignores BOM-derived availability, drops zero rows beyond 200,000 product-location combinations, and shows active products only; the Reordering report does not compute available for assemblies; a larger-unit SKU shows as available only after it has its own movement or transaction. [DOC] S-AVAILUI, S-AVAILRPT, S-STOCKLVL, S-REORDER

Which transaction moves which field (qty = line quantity, location = the document's location):

| Transaction / transition | OnHand | Allocated | Available | OnOrder | InTransit | NextDeliveryDate | Source |
|---|---|---|---|---|---|---|---|
| Purchase order authorised | - | - | - | +qty | - | set from line delivery/required-by date | S-AVAIL, S-REORDER |
| Purchase order voided / line removed | - | - | - | -qty | - | recomputed | [INFER] |
| Purchase invoice authorised **before** stock received (invoice first) | - | - | - | stays | stock-in-transit value in GINR | - | S-ACCRUAL, S-VALUE |
| Stock received authorised (partial ok on advanced purchases; received qty must match invoiced qty) | +qty received | - | +qty | -qty received (down to 0, not negative) | - | recomputed | S-AVAIL, S-ACCT |
| Put-away authorised | bin split only; location OnHand unchanged | - | - | - | - | - | API-SHAPES (Purchase Put Away) |
| Unstock (with a supplier credit note) | -qty | - | -qty | - | - | - | S-UNSTOCK |
| Sale order authorised | - | +qty | -qty | - | - | - | S-CALC, S-AVAILRPT |
| Sale fulfilment pick authorised | - | allocates if not yet allocated; no movement recorded until pack and ship | - | - | - | - | S-PICK |
| Sale fulfilment ship authorised | -qty | -qty | net 0 vs allocated | - | - | - | S-AVAILRPT, S-ACCT |
| Sale voided before ship | - | -qty | +qty | - | - | - | [INFER] |
| Sale credit note, Restock | +qty (any location) | - | +qty | - | - | - | S-CREDIT |
| Stock adjustment completed, existing line | +/- (new qty - on hand) | - | +/- | - | - | - | S-ADJ |
| Stock adjustment completed, new line | +Quantity | - | + | - | - | - | S-ADJ |
| Stock adjustment voided | reverses; blocked once the stock was sold, transferred or used | - | reverses | - | - | - | S-ADJ |
| Stock adjustment DRAFT | nothing | nothing | nothing | - | - | - | S-ADJ |
| Stock transfer order authorised (order step, status Ordered) | - | not documented | - | - | - | - | [INFER] |
| Transfer sent (IN TRANSIT) | -qty at source | - | - | - | +qty | - | S-XFER, CLIENT-INV 5 |
| Transfer received (COMPLETED) | +qty at destination | - | +qty | - | -qty | - | S-XFER |
| Transfer, skip-order or direct complete: one step | -qty source, +qty destination at once; no transit postings | - | | - | - | - | S-XFER |
| Stocktake IN PROGRESS | location frozen: no movement permitted; sales load as pending | - | - | - | - | - | S-STKT |
| Stocktake COMPLETED | +/- (counted - OnHand) per line | - | | - | - | - | S-STKT, CLIENT-INV 4.3 |
| Assembly/Production authorised | - | components +qty | components -qty | finished +qty | - | - | S-AVAIL, S-ASM |
| Assembly allocate/pick done | components leave on hand | components -qty | | finished stays on order | - | - | S-ASM |
| Assembly/Production completed | finished +qty | | | finished -qty | - | - | S-ASM |
| Inventory write-off completed | -qty | - | -qty | - | - | - | S-WRITEOFF |

Notes:
- Allocation and OnHand are reported per bin/batch after pick, but Available at order time is only known at product-location level. [DOC] S-AVAIL ("Batch" empty for allocated stock not yet picked).
- A transfer may move stock that is allocated to sales or other processes but not yet picked. [DOC] S-XFER. The client colours a transfer quantity above available red and still saves. [CLIENT] CLIENT-INV 3.5
- Stock added by an adjustment or stocktake becomes pickable at the actual completion moment; the effective date only dates journals. [DOC] S-PICKSTK
- Non-inventory and Service products never appear in these tables. [DOC] S-NONINV.

---

## 4. Stock adjustment

Entity: StockAdjustment task. Fields: `TaskID`, `EffectiveDate`, `StocktakeNumber` (the adjustment number; the field name is shared with stocktake), `Status`, `Account`, `Reference`, `Comment`, `ExistingStockLines`, `NewStockLines`, `Transactions` (journal lines). POST/PUT body takes `Lines` plus `UpdateOnHand` boolean. [API] Account may be an expense account, a liability account or the mapped Inventory discrepancy account. [DOC] S-ADJ

### 4.1 State machine

| From | Action | To | Who | Validation | Source |
|---|---|---|---|---|---|
| (new) | Save | DRAFT | Stock-adjustment permission | EffectiveDate and Lines required (client: at least one line, otherwise a warning). No stock or journal effect. | API-SHAPES, S-ADJ, CLIENT-INV 2.2 |
| (new) | Complete | COMPLETED | same | Account and effective date required. Quantities update immediately; journals dated EffectiveDate. A failed complete rolls back to DRAFT. | S-ADJ, CLIENT-INV 2.2 |
| DRAFT | Edit | DRAFT | | Free editing. Date, account and cost type editable only in DRAFT; reference and comment also in COMPLETED. | CLIENT-INV 2.2 |
| DRAFT | Complete | COMPLETED | | As above. | S-ADJ |
| DRAFT | Void | VOIDED | | API DELETE on `/stockadjustment` (no stock effect, none existed). The client offers Void on any saved, non-voided adjustment. | API-MAP, CLIENT-INV 2.2 |
| COMPLETED | Undo | DRAFT | Undo permission | Reverses the quantity and layer effect and the journals, keeps the lines. (corrected: the help center names only Void; the client script shows Undo to DRAFT.) | CLIENT-INV 2.3 |
| COMPLETED | Void | VOIDED | Void permission | Reverses all transactions and closes the adjustment for good; it cannot be reopened or re-authorised. Not possible any more once the stock has been transferred, sold or used in production. | S-ADJ, CLIENT-INV 2.2 |
| VOIDED | - | terminal | | Not editable, not re-openable. | S-ADJ |

The POST/PUT API only accepts `DRAFT` and `COMPLETED` (`Status` required); `VOIDED` is read-only in the model and reached through DELETE. [API]

The adjustment list is shared with stocktakes (type column "Stock Adjustment" or "Stocktake"). [CLIENT] CLIENT-INV 2.3

### 4.2 Quantity / cost effects on COMPLETED

| Line kind | Meaning | Fields | Effect |
|---|---|---|---|
| ExistingStockLines | Product/location/batch already has stock | `QuantityOnHand`, `Available`, `Adjustment` (the NEW quantity, not a delta; variance = new - on hand), `BatchSN`, `ExpiryDate` | OnHand becomes the new quantity. Down: consume layers per method at the layers' own cost. Up: cost source not documented (see Unclear). Negative entries become 0; plain serial products are held to 1. [DOC][CLIENT] |
| NewStockLines | Adds stock (zero-stock lines: nothing of that product at that location, even if it exists elsewhere) | `Quantity`, `UnitCost`, `LocationID`, `BatchSN`, `ExpiryDate`, `ReceivedDate` | New layer at `UnitCost`. OnHand += Quantity. Received date = completion day. |

| Case | Rule | Source |
|---|---|---|
| Cost estimate method | A header choice (Average, Fixed purchase, Latest purchase) gives each new-stock line a default unit cost; a typed unit cost wins. Changing the choice after load re-prices every new line, typed costs included. | S-ADJ, CLIENT-INV 2.4 |
| Costed add | Cost = UnitCost x Quantity. | S-ADJ |
| Zero-cost add | A zero or missing cost is accepted by the client. The CSV import asks for a positive unit cost on Zero lines. Whether the server accepts and posts 0 is not documented (see Unclear). (corrected: earlier text asserted the help center allows cost 0.) | S-ADJ, CLIENT-INV 2.4 |
| Adjust down | Consumes layers by costing method; journal value = cost consumed. | S-ACCT |
| Revaluation | A type of adjustment: on the non-zero tab set the SKU to 0 to write it off, then on the zero tab add the same SKU and the original quantity at the new unit cost. Average cost then becomes that unit cost. | S-ADJ, S-AVGCOST |
| Existing and new lines in one adjustment | Allowed together. | S-ADJ |
| Batch/serial/expiry | Required on new lines for batch/serial/FEFO products; FEFO requires ExpiryDate. No uniqueness check. FIFO products show N/A. | S-BATCH, CLIENT-INV 2.4 |
| Landed costs | Manual-journal costs only, with manual distribution (no cost, quantity, weight or volume distribution as on transfers); a separate landed-cost invoice can also be allocated to an adjustment. | S-XFERCOST |
| CSV import | Replaces all lines on the adjustment. Each row needs a unique Zero/NonZero + Location + Bin + SKU + Batch/Serial + Cost combination; unit cost is ignored for NonZero rows. Unmatched rows can be dropped and only valid lines uploaded. | S-ADJ, CLIENT-INV 2.3 |
| Barcode scan | Scans add to the quantity, so a double scan counts twice. | CLIENT-INV 2.4 |
| Duplicate line | Same product, location, batch, expiry is warned and cleared. | CLIENT-INV 2.4 |
| Effective date vs availability | The date only dates journals; picking sees the stock from the actual completion moment. A re-entered old batch under FIFO (Batch) is therefore picked last. | S-PICKSTK, S-BATCHFIX |
| Accounting sync | A non-"real" adjustment can be kept out of the ledger by changing its manual-journal sync entry from Pending to Skipped. | S-ADJ |
| Attachments | Draft adjustments take attachments up to 10 MB; printed PDFs attach automatically. | S-ADJ |

Settings: **Adjustment account / Inventory discrepancy account mapping**, accounting integration sync. See `rules/settings.md`.

### 4.3 Journal (summary)

| Direction | Debit | Credit | Amount | Source |
|---|---|---|---|---|
| Stock added (net gain) | Inventory control | Account chosen on the adjustment (Inventory discrepancy / expense / liability) | cost of lines added | S-ACCT [DOC] |
| Stock removed (net loss) | The help center shows the same two accounts with a negative amount; economically Dr chosen account, Cr Inventory | | cost consumed | S-ACCT [DOC] (corrected: leg direction now documented, as negative amounts) |

Effective date = journal date. Output via `Transactions[]` with `Debit`, `Credit`, `Amount`, `EffectiveDate`. [API-MAP]

### 4.4 Inventory write-off

| Rule | Tag | Source |
|---|---|---|
| Functionally an adjustment that expenses stock and services lost, stolen, damaged, given away or used internally, or allocates them to a job. | [DOC] | S-WRITEOFF |
| Header: location and expense account; lines: product or service and quantity; cost comes from the costing method and prior transactions. Non-inventory products cannot be written off. | [DOC] | S-WRITEOFF |
| Permission: the production inventory-write-off task permission. No import/export and no summary report; use a single expense account plus the general ledger or filter the movement details report. | [DOC] | S-WRITEOFF |
| Undo returns it to Draft and reverses movements; Void reverses and closes it permanently. | [DOC] | S-WRITEOFF |
| Expenses from a separate invoice can be allocated to purchases, assemblies, transfers and production runs through the write-off's Financials tab. | [DOC] | S-WRITEOFF |
| Journal: Dr selected expense account, Cr Inventory; labour and overhead lines Dr expense, Cr labour/overheads account; dated the completion date. | [DOC] | S-ACCT |

---

## 5. Stock transfer

Entity: StockTransfer task (+ optional StockTransferOrder sub-document). Fields: `From`/`To` location, `Number`, `Status`, `CostDistributionType` (Cost, Quantity, Weight, Volume, plus Manually in the client), `InTransitAccount`, `DepartureDate`, `CompletionDate`, `RequiredByDate`, `Reference`, `SkipOrder`, `Lines` (`TransferQuantity`, `QuantityOnHand`, `QuantityAvailable`, `BatchSN`, `ExpiryDate`), `ManualJournals`, `Order`. [API-MAP][CLIENT]

### 5.1 State machine - transfer

Statuses: `DRAFT`, `ORDERED`, `PICKING`, `IN TRANSIT`, `COMPLETED`, `VOIDED`. [CLIENT] CLIENT-INV 3.1

| From | Action | To | Validation | Effect | Source |
|---|---|---|---|---|---|
| (new) | Save | DRAFT | From and To required; From may equal To (the client then forces skip-order, and a bin-to-same-bin move is refused). (corrected: earlier note said the two must differ.) At least one line before sending or completing. | none | API-SHAPES, CLIENT-INV 3.2, 3.4 |
| DRAFT | Authorise the order (Order tab; not for skip-order) | ORDERED | Empty order cannot be authorised. | Order lines recorded; source reservation is not documented. | S-XFER, CLIENT-INV 3.4 |
| ORDERED/PICKING (or DRAFT with skip order) | Send stock (enter stock sent date = `DepartureDate`) | IN TRANSIT | InTransitAccount (defaults from mapping; any asset account may be chosen). Stock sent date required. Skipping this step makes the transfer instant when put-away is off. | Source OnHand -= qty; stock value moves to the in-transit account. | S-XFER, API-SHAPES |
| IN TRANSIT | Receive (enter stock received date = `CompletionDate`; put away to destination bins if enabled) | COMPLETED | Received date >= sent date. With put-away, received quantity cannot exceed the transferred quantity. | Destination OnHand += qty; value leaves the in-transit account. | S-XFER, CLIENT-INV 3.4, 3.5 |
| DRAFT | Complete directly (no transit time) | COMPLETED | Put away must be off or done. | Both moves at once, no in-transit postings. | S-XFER |
| DRAFT | Skip order (`SkipOrder = true`) | go straight to pick/send | No Order document. | | S-XFER |
| COMPLETED / ORDERED | Undo | DRAFT | Keeps lines and entered data. Not possible once the transferred products were consumed (sold, used in production) by another task. Documented as not applicable to FBA orders or to orders in transit; the client nevertheless offers Undo in IN TRANSIT (see Unclear). | Reverses movements and journals. | S-XFER, CLIENT-INV 3.3 |
| any saved | Void | VOIDED | Closes the order for good. Same consumed-stock and not-in-transit limits as Undo. | Reverses movements and journals. | S-XFER |
| COMPLETED with put-away | Undo put-away | IN TRANSIT | Needs undo and void permissions. | Reverses put-away distributions. | CLIENT-INV 3.4 |

Transfer order sub-document: `Order.Status` is `DRAFT`, `AUTHORISED` or `NOT AVAILABLE` (skip-order). [API][CLIENT] Imports and exports apply to Draft and Ordered transfers only; documents print and email with PDFs saved to Attachments (up to 10 MB). [DOC] S-XFER

### 5.2 Landed costs on transfers

| Rule | Source |
|---|---|
| Costs (freight, duty, insurance) are added after completion on the transfer's Manual Journals tab, or allocated from a separate invoice (a Simple purchase with Blind receipt; the Expenses button then offers +Allocation and Auto-allocate in proportion to cost). | S-XFER, S-XFERCOST |
| Type field decides distribution across lines: Cost (proportional to line cost), Quantity, Weight, Volume (weight and dimensions must be set on all products) or Manually. Mirrors `CostDistributionType`. | S-XFERCOST, API-SHAPES |
| To capitalise, the journal's debit account must be the same inventory account as the item lines. An expense account books a business expense and does not raise stock value. | S-XFERCOST, S-LANDED |
| If the cost of transferred goods changes after the sent or received date, a separate entry is made at the date of the cost change, grouped by date. | S-XFER |
| Adjustments only support manual distribution of such costs. | S-XFERCOST |

### 5.3 Journal (summary)

| Transition | Debit | Credit | Dated | Source |
|---|---|---|---|---|
| Send | Stock in transit (InTransitAccount; defaults to mapped account) | Inventory | Stock sent date | S-XFER |
| Receive | Inventory | Stock in transit | Stock received date | S-XFER |
| One step, no in-transit | none; no transit-related transactions are generated | | | S-XFER |

(corrected: the receive leg and the one-step case are now documented, not inferred.)

Settings: **Stock in transit account mapping**, **Put away**, **Update stock received date with transfer completion date**. See `rules/settings.md`.

---

## 6. Stocktake

Entity: Stocktake task (same family as adjustment; uses `StocktakeNumber`). Fields: `Status`, `Account`, `LocationID`, filters (`Tags`, `PickZones`, `StockLocators`, `Categories`, `Brands`, `Bins`, plus bin groups in the client), `NonZeroStockOnHandProducts`, `ZeroStockOnHandProducts`, `Transactions`, `UseRelativeQuantity`, `Reference`, "Include quantity on hand" toggle. Required: EffectiveDate, Account, Location. Only products of type Stock are available. [API-MAP, API-SHAPES, DOC S-STKT, CLIENT-INV 4.1]

### 6.1 State machine

| From | Action | To | Validation | Effect | Source |
|---|---|---|---|---|---|
| (new) | Save | DRAFT | Location and Account required. Filters optional. Quantities on a draft keep refreshing; to pick up newer stock levels void the draft and create a new one. | none, no lock | S-STKT, API-SHAPES |
| DRAFT | Start | IN PROGRESS | Product list is generated and split into Non-zero stock on hand and Zero stock on hand sections. Location required. | Location is locked. | S-STKT, CLIENT-INV 4.2 |
| IN PROGRESS | Save | IN PROGRESS | Counts saved (draft counts); counting by typing, barcode scan (adds to the count and files the item in the right section) or CSV export/edit/import. | lock stays | S-STKT, CLIENT-INV 4.2 |
| IN PROGRESS | Complete | COMPLETED | Effective date required. | Variances posted (6.3). Location unlocked. | S-STKT |
| COMPLETED or IN PROGRESS | Undo | DRAFT | "Reverse all stocktake transactions"; details kept. | Reverses variance adjustments, status back to Draft. | S-STKT, CLIENT-INV 4.2 |
| DRAFT or IN PROGRESS | Void | VOIDED | Client confirm says it voids the count and deletes its adjustments. | Unlocks the location (a browser cache refresh may be needed before blocked sales proceed). | CLIENT-INV 4.2, S-STKT |

POS lists the same states as Draft, In Progress, Completed and Canceled. [DOC] S-STKT-POS

### 6.2 Freeze / lock

| Rule | Source |
|---|---|
| While IN PROGRESS the stocktake's location is locked: its inventory cannot be used, sold or moved. | S-STKT |
| Background work continues, such as loading sales from a connected store, but those orders stay pending so local stock is untouched. | S-STKT |
| A blocked process raises an error saying processing cannot complete while a stocktake or count is in progress in one or more locations. | S-STKT, S-STKT-WMS |
| Scope filters: stock locators, categories, brands, tags, bins, bin groups, pick zones. They define the product list, not extra location filters: a bin filter selects products in that bin, then counts ALL instances of those products in the location, not only the ones in the bin. Keeping each product in one bin is the only way to avoid this. | S-STKT, S-STKT-WMS |
| Completion can fail with a discrepancy error between the required adjustment and actual movement, caused by stock changing after the stocktake was created, or by negative stock levels. Void and restart for the first cause. | S-STKT |

### 6.3 How variances post

| Line | Variance | Quantity effect | Cost | Source |
|---|---|---|---|---|
| Non-zero line | Adjustment = counted - QuantityOnHand (counted value is absolute) | OnHand becomes the count | Gain: new layer at default cost. Loss: consumes layers per method. | S-STKT, API-MAP, CLIENT-INV 4.3 |
| Zero-stock line counted > 0 | + counted | New layer at `UnitCost` | UnitCost on line, generated automatically and editable | S-STKT |
| Line not counted | Not documented (see Unclear) | | | |
| `UseRelativeQuantity` | Not described in the help center; typed `number` in the API shape | | | API-SHAPES |
| WMS count | Counts at SKU level for the whole location (not the bin); a different count asks for confirmation; additional units of measure are counted in the unit already in the bin, or the user chooses | | | S-STKT-WMS |

Journal (summary): net gain Dr Inventory control / Cr the stocktake Account; net loss the same pair with negative amounts. Dated EffectiveDate and synced on next accounting sync. [DOC] S-ACCT, S-STKT. A stocktake that only corrects data entry can be kept out of the ledger by changing its inventory-adjustment manual journal sync entry from Pending to Skipped. [DOC] S-STKT

Settings: **Stocktake / Inventory discrepancy account**, **Location bins and pick zones**. See `rules/settings.md`.

---

## 7. Batch, serial, expiry handling

| Rule | Detail | Tag | Source |
|---|---|---|---|
| Enable | Via costing method only. | [DOC] | S-BATCH |
| Receiving | Batch/serial entered per line (serials one by one) before the Stock Received can be authorised. One receiving action refuses duplicate serials within itself. | [DOC] | S-BATCH |
| Expiry | Mandatory on FEFO products; optional on other batch/serial methods. FEFO and Special methods generate a batch number when none is entered. | [DOC] | S-COST |
| Uniqueness | Not enforced for batch or serial in any operation across documents (receiving, adjustment, stocktake). | [DOC] | S-BATCH, S-COST |
| Picking (auto) | FIFO/FEFO auto-pick; Special follows first-in. Expired stock is skipped only if "Exclude expired batch/serial numbers" is on. Orders pick from the sale location first. | [DOC] | S-BATCH, S-PMSET, S-PICKSTK |
| Picking (manual) | The portal and WMS let a picker scan or select any number. The "Recommend batch/serial no. for FIFO/FEFO" setting chooses Don't recommend, Recommend and warn (the user may ignore the warning) or Recommend and enforce (the user must swap to the recommended stock). It covers sale fulfilment, stock transfers and assembly orders, but not production components. The client mirrors it as mode 0/1/2. The sale-pick article says FIFO/FEFO lines cannot be switched to a different number in the UI; see Unclear. | [DOC]+[CLIENT] | S-PMSET, S-BATCH, CLIENT-INV 3.5 |
| FEFO auto-pick lock | A batch auto-picked on a FEFO product cannot be changed. | [DOC] | S-PICK |
| Assembled / produced serials | Assembly outputs get system-assigned serials; production outputs can be given one until put away and not after sale, transfer or adjustment. | [DOC] | S-BATCH |
| Serial quantity | Serial new-stock lines are forced to quantity 1 and locked in the client; the plain serial method refuses a stock-adjustment new quantity above 1. | [CLIENT] | CLIENT-INV 2.4 |
| Re-entering an old batch | An adjustment gives it today's received date, so FIFO (Batch) will not pick it first. Use Special (Batch) to select by number. | [DOC] | S-BATCHFIX |
| Availability grain | Availability is reported per batch/serial and expiry (`Batch`, `ExpiryDate` on availability row); hide the batch columns for SKU totals. | [API]+[DOC] | API-MAP, S-AVAILUI |
| Recall | Recall report: product + batch; panels for stock on hand, suppliers and customers. A product appears in the picker only if it has been sold; use the movement details report to trace unsold stock. Letters go only to customers whose sale was fulfilled. | [DOC]+[CLIENT] | S-RECALL, CLIENT-INV 6 |
| Recall tables | `pRecall*` tables | [API] | `spec/modules/04-inventory/schema.sql` |

---

## 8. Locations, bins, reorder levels

| Rule | Detail | Tag | Source |
|---|---|---|---|
| Per-location product settings | `ProductLocation` has `MinimumBeforeReorder`, `ReorderQuantity`, `StockLocator`, `PickZones` per product per location. Product-level `MinimumBeforeReorder`/`ReorderQuantity` are the default. API `ReorderLevels[]` are the per-location rows. | [API] | API-SHAPES, schema.sql `vProductLocation` |
| Reorder mode | The "Minimum before reorder specified for" purchase setting picks All product units (total across locations) or Each location. | [DOC] | S-PURCHSET |
| Reorder trigger | A product shows in Purchases > Reorder when available falls to or below its minimum before reorder; suggested order qty = `ReorderQuantity`. At least one supplier must be on the product. Make-to-order products do not use these fields. The Low-on-stock report lists only products strictly below the minimum. The reorder page needs a non-zero positive price and quantity per line and one supplier per PO. | [DOC]+[CLIENT] | S-LOWSTOCK, S-REORDER, CLIENT-INV 6 |
| Smart reorder | Per supplier and optionally per location: lead days, safety days, reorder quantity, minimum to order, used with sales history by the Inventory Velocity report; blank values distort it. Set by CSV (Export/Import Reorder parameters) too. | [DOC] | S-REORDERPARAM |
| Location types | Warehouse/retail, Fixed asset, Shop floor (Advanced Manufacturing), Co-manufacturing (Advanced Manufacturing). (corrected: `IsStaging` is a bin flag, not a location type.) | [DOC] | S-LOC |
| Location options | Set as default (only one; automatic when there is a single location), Use directed receive/put away, Use directed pick (bin groups), Allow to reorder stock level (turns Low stock reorder on or off for that location). | [DOC] | S-LOC |
| Location flags in the API | `AllowReorder`, `IsDeprecated`, `IsShopfloor`, `IsCoMan`. | [API] | API-SHAPES |
| Removing a location or bin | Never used: can be deleted. Used in any transaction: cannot be deleted, only deprecated, which removes it as a transaction option (and from WMS for bins). Quantities (on hand, available, on order, in transit, allocated) must be 0. (corrected: earlier note was an inference.) | [DOC] | S-LOC, S-BINS |
| Location permissions | A user's picking, receiving, stocktake, adjustment, write-off, assembly and production actions can be limited to chosen locations; users can still see other users' documents elsewhere. | [DOC] | S-LOC |
| Default location | Product `DefaultLocation` used to prefill documents. Fixed assets need fixed-asset locations (client filters the list). | [API]+[CLIENT] | CLIENT-INV 1.4 |
| Bins | Optional; OnHand tracked per bin when bins exist. Not available on fixed-asset or co-manufacturing locations. Bin names sort alphanumerically in WMS pick lists. A Staging bin enables two-stage transfers (from location, staging bin, to location). Directed put away rules and bin groups for directed pick are location options. | [DOC] | S-BINS |
| Fulfilment-service locations | A location with an external fulfilment service lets a stocktake pull quantities from the service. | [CLIENT] | CLIENT-INV 4.3 |

---

## 9. Negative stock

| Rule | Tag | Source |
|---|---|---|
| Sale authorisation checks stock. If not enough: a message offers split order (only if partial stock exists), backorder (only for products with an assigned supplier) or create purchase order (one supplier per PO; for backordered items or the whole sale). Sale orders can still be authorised. | [DOC] | S-NOSTOCK |
| After authorisation, fulfilment with insufficient stock stays in Picking until enough stock exists; automatic picking runs only when stock is sufficient. This is the effective block, not an error at authorisation. (corrected: earlier note called it an inference.) | [DOC] | S-PICKSTK, S-SALESET, S-LIGHTSPEED |
| Negative on-hand does occur: the movement summary can show negative balances when stock is received after the sale date, when an adjustment is backdated, or a receipt is future-dated; availability can also be negative and enters the auto-assembly quantity formulas. | [DOC] | S-IMS, S-AUTOASM, S-SALESET |
| Auto-assembly never partially assembles and will not trigger without enough components at the sale location; it may also build extra to refill negative stock "if your settings allow this" (the setting is not named). | [DOC] | S-AUTOASM |
| Operations that refuse to leave stock negative: voiding a credit note whose restock reversal would go negative; voiding an adjustment or undoing a transfer after the stock was consumed; unstock after the stock was sold, transferred or adjusted. A stocktake can fail when negative stock exists. | [DOC] | S-CREDIT, S-ADJ, S-XFER, S-UNSTOCK, S-STKT |
| A transfer quantity above available is coloured red in the client but still saved. | [CLIENT] | CLIENT-INV 3.5 |
| A global "allow negative stock" toggle is not documented. | [INFER] | |
| Cost on dispatch before the purchase invoice is authorised: COGS shows 0 and is corrected on the invoice date once the invoice is authorised. (corrected: previously sourced from a third-party blog.) | [DOC] | S-COGS |
| Channel backorders: when backorder is allowed on a store, selling a zero-stock product creates a backorder for the negative quantity. | [DOC] | https://help.core.cin7.com/hc/en-us/articles/11797034961039-Shopify-settings |

---

## 10. Product families and variants

| Rule | Tag | Source |
|---|---|---|
| A family has up to 3 option labels (`Option1Name` required, 2 and 3 optional) and any number of values (Shopify caps variations at 100 per family; Cin7 does not). | [DOC]+[API] | S-FAMILY, API-SHAPES |
| Family has its own unique SKU (up to 45 characters); each variation has a unique SKU. Variations are generated from option value combinations or existing products can be mapped. Generated SKU = family SKU, " - ", then a 3-digit counter (4 digits above 999), skipping codes already used. Generated name = family name + option values. Re-generation does not duplicate an existing option combination. | [DOC]+[CLIENT] | S-FAMILY, CLIENT-INV 1.12 |
| Family-level required fields: SKU, Name, Category, CostingMethod, DefaultLocation, UOM, Option1Name. Values `Option1Values` etc. are read-only on update through the API. At least one variation is needed, and all variations must carry the same number of options. | [API]+[CLIENT] | API-SHAPES, CLIENT-INV 1.12 |
| What a family writes onto its variations when created or updated: category, default location, brand, description, short description, reorder quantity, minimum before reorder, drop-ship mode, inventory/revenue/COGS accounts, purchase and sale tax rules, prices, country of origin, tags. Export the inventory list beforehand to restore per-variation edits. Barcode can be set only on a variation. Dropship supplier, last supplier and supplier price apply to all variations unless overridden. | [DOC] | S-FAMILY |
| Family-level prices are simple prices only; dynamic prices are set on the variation. Family images do not apply to variations. Dimensions, weight and attribute values are set per variation from the family's Variations tab. | [DOC] | S-FAMILY |
| Costing method per product; changes follow the matrix in 2.2. | [DOC] | S-COST |
| Deleting a family deprecates every variation, deletes unused ones, and deletes the family; used variations remain deprecated. | [DOC] | S-FAMILY |
| Family BOM: a general production BOM at family level is expanded into per-variation production BOMs using the mapping values; regenerating updates the variation BOMs. | [DOC]+[API] | S-FAMILY, schema.sql |
| Clone family: new family SKU and name; options, prices and production BOM copy and new variations are generated on save. | [DOC] | S-FAMILY |
| Bulk add: variations can be added to a purchase, sale or transfer in list or matrix format. | [DOC] | S-FAMILY |
| An incorrectly configured family (no options or variations without option values) can break listing to sales channels. | [DOC] | S-FAMILY |

---

## 11. Units of measure

| Rule | Tag | Source |
|---|---|---|
| Each product has one base `UOM` (required; the default unit is "item"). Unit names are a reference book (`/ref/unit`: ID, Name). | [API]+[DOC] | API-SHAPES, S-CREATE |
| Additional units: create the smallest unit as the base product; on its Additional Units of Measure tab add each larger unit with a conversion ratio in the "Number of.." field (integer or decimal). Each additional unit is its own SKU, flagged sellable or not, with an optional first price tier. The additional-unit product must use the same costing method as the base and a different unit. Sales are recorded per SKU, so filter by product to total across units. | [DOC] | S-UOM |
| The tab is hidden unless the product is Stock type; it is also hidden when auto-assembly is on, for gift cards, non-inventory and make-to-order products. | [CLIENT] | CLIENT-INV 1.5 |
| System creates a Phantom BOM on each additional-unit SKU with auto-assembly and auto-disassembly on, linked to the base. Functionally identical to a manual auto-assembly BOM. | [DOC] | S-UOM, S-PHANTOM |
| Stock is held in the base unit. Buying an additional unit disassembles it on stock received (50 packs of eggs become 50 x pack size singles); selling a larger unit auto-assembles it from singles at sale authorisation. Availability shows the larger units as derived from singles. | [DOC] | S-PHANTOM, S-UOM, S-AVAILUI |
| In a production order an additional unit is exploded to a multiple or fraction of the base unit (7 oz of an item whose base is the kilogram becomes a decimal kilogram quantity at ratio 0.0283495). If the base unit is used in a production BOM, the order does not disassemble further. | [DOC] | S-PHANTOM |
| A product with additional units cannot also use an auto-assembly BOM; you may add a plain BOM to the base product, but not auto-assembly/disassembly on it. Disabling the automation means giving the units ordinary BOMs and disassembling by hand, and availability of cases then stops being derived. | [DOC] | S-UOM, S-DISASM |
| Non-inventory products cannot have additional units. | [DOC] | S-NONINV |
| CSV import/export of units: columns Action (Create/Update/Delete, required for Delete), base SKU/name/unit, additional SKU/name/unit, NumberOfBaseUnitsInAdditionalUnit (decimal), IAmSelling (required for new products). Import can load only valid lines. | [DOC] | S-UOM |
| Creating a unit product in the client suggests SKU `<SKU>-<unit>` and name `<Name>-<unit>`, checks the SKU is free, and refuses duplicates. | [CLIENT] | CLIENT-INV 1.10 |
| WMS stocktake counts an additional-unit SKU in the unit already in the bin. | [DOC] | S-STKT-WMS |
| Rounding of fractional remainders is not documented. | | |

Settings: **Product and measurement settings** (weight and dimension units, SKU auto-generation). See `rules/settings.md`.

---

## 12. Inventory journal entries (summary level)

Transactions are created when: a PO or quote with a deposit is authorised, an invoice or credit note is authorised, a sale shipment is authorised, a manual journal is authorised, a stocktake, adjustment, assembly, production, write-off or disassembly is authorised/completed, or any of these is undone or voided. Stock received on a purchase does NOT create a transaction by itself; stock receipt only updates quantities, and an invoice authorisation does not update quantities. No transactions can be created in a closed accounting period. [DOC] S-ACCT, S-COGS

| Transaction | Debit | Credit | Dated | Source |
|---|---|---|---|---|
| Purchase invoice, accrual off | Inventory control (+ tax; additional-cost lines to inventory if the account is the inventory account, else expense) | Accounts Payable | Invoice date | S-ACCT, S-ACCRUAL |
| Stock received, Stock-first (accrual on) | Inventory | Inventory Accrual (GRNI) | Receipt date | S-ACCRUAL |
| Purchase invoice authorised after receipt (accrual on) | Inventory | Inventory Accrual (GRNI), with a negative amount that reverses the receipt-date entry; then the ordinary Dr Inventory, Cr Accounts Payable | Invoice date | S-ACCRUAL (corrected: the clearing is a negative-amount reversal, not Dr GRNI / Cr Accounts Payable with a price-variance leg) |
| Purchase invoice authorised, Invoice-first (accrual on) | Stock in Transit (GINR) (asset accounts on the invoice lines are replaced by it) | Accounts Payable | Invoice date | S-ACCRUAL |
| Stock received after invoice-first | Inventory | Stock in Transit (GINR) | Receipt date | S-ACCRUAL |
| Accrual journals | Added automatically to the purchase, cannot be deleted by hand, are sent to Xero/QuickBooks regardless of manual journal authorisation, and are removed on Undo. After stock is received on an invoice-first order, the invoice-line account cannot be changed without Undo. | | | S-ACCRUAL |
| Purchase credit note | Inventory control (negative), Tax (negative) | Accounts Payable | Credit note date | S-ACCT |
| Drop-ship purchase invoice | COGS | Inventory control | Invoice date | S-ACCT |
| Sale ship authorised (COGS) | Cost of Goods Sold | Inventory | Ship authorisation date (maximum of ship dates if several) | S-COGS, S-ACCT |
| Sale invoice | Accounts Receivable | Revenue (+ tax) | Invoice date | S-ACCT |
| Credit note, stock restocked | Inventory | COGS | Credit note date | S-ACCT (the help page prints the ship pair COGS/Inventory with a negative amount) |
| Credit note, price-only | No stock change; delete the restock line to amend financials only | | | S-CREDIT |
| Return scrapped (RMA) | Inventory write-off to the configured scrap write-off expense account | Inventory | Resolution | https://help.core.cin7.com/hc/en-us/articles/10553599470479-Return-orders-Process-returned-products |
| Stock adjustment up / stocktake gain | Inventory control | Inventory discrepancy / chosen account | Effective date | S-ACCT |
| Stock adjustment down / stocktake loss | Same pair, negative amount | | Effective date | S-ACCT |
| Inventory write-off, stock | Selected expense account | Inventory control | Completion date | S-ACCT |
| Inventory write-off, labour/overheads | Selected expense account | Labour or overheads account | Completion date | S-ACCT |
| Transfer sent | Stock in Transit | Inventory | Stock sent date | S-XFER |
| Transfer received | Inventory | Stock in Transit | Stock received date | S-XFER |
| Cost of transferred goods changes later | Separate entries per cost-change date | | Cost change date | S-XFER |
| Landed cost via manual journal | Inventory (to capitalise; same account as the lines) | Chosen account (for example overheads) | Manual journal date | S-ACCT, S-XFERCOST |
| Assembly, components allocated | Work in progress | Inventory control | Assembly completion date | S-ACCT |
| Assembly, completed | Inventory control (finished goods) | Work in progress | Assembly completion date | S-ACCT |
| Assembly, labour/overheads | Inventory control | Labour or overheads account | Assembly completion date | S-ACCT |
| Disassembly, parent consumed | Work in progress | Inventory control | Disassembly completion date | S-ACCT |
| Disassembly, components produced | Inventory control | Work in progress | Disassembly completion date | S-ACCT |
| Disassembly, labour/overheads | Inventory control | Labour or overheads account | Disassembly completion date | S-ACCT |
| Revaluation | Two adjustment postings: the write-off of the old value and the re-add at the new cost | | Effective date | S-ADJ (corrected: it is not a single revalue leg) |

Accounts come from the **Chart of accounts and account mapping** setting (Inventory control and Work in progress are current assets, Inventory discrepancy an expense, In transit a current asset) and, per product, `InventoryAccount`, `COGSAccount`, `RevenueAccount`, `ExpenseAccount`. [DOC] S-CHART. Accrual accounts: the Goods Received Not Invoiced account is a current asset or current liability, the Goods Invoiced Not Received account a current asset; neither accepts payments, system account None; neither may equal the other or any other mapped account. If the accrual setting is disabled or a mapping is missing, accrual is skipped and only real costs post. [DOC] S-ACCRUAL, S-PURCHSET

Balance-sheet vs stock value gaps come from goods invoiced-not-received or received-not-invoiced (the balance sheet follows invoice authorisation, stock value follows receipt), and from manual journals not reflected in movements; the transactions-vs-stock-on-hand report finds them. [DOC] S-VALUE, S-IMS

---

## Unclear / docs disagree

Resolved items are struck through with the answer and where it now lives. Everything else stays open for the stated reason.

1. ~~**Help-center full text not read.**~~ Resolved: the full help center was read; [DOC] items now cite the articles.
2. ~~**Product status values.**~~ Resolved: Setup required is a UI/system status (missing mandatory fields, integrations, or set on purpose); the API accepts only Active and Deprecated. See 1.2 and 1.3.
3. **What deprecating blocks.** Documented: the product is unavailable for sale, purchase, production and other operations and hidden from drop-downs. Not documented: whether deprecating is refused with stock on hand or open documents, and whether open drafts keep it.
4. **SKU uniqueness details.** Uniqueness and the leading-0/leading-space rules are documented (1.2). Still unknown: the error text and whether comparison is case-sensitive.
5. **API enum strings (partly resolved).** Resolved: `Type` (Stock/Service on the API page; more in the client), `CostingMethod`, `Status`, `DropShipMode`, and the client codes for BOM and cost estimation. Still open: the API strings for `BOMType` and `AssemblyCostEstimationMethod`; pull them from a live read-only Product response before hard-coding.
6. ~~**Special (Batch/Serial) cost treatment.**~~ Resolved: COGS comes from the authorised purchase invoice of the unit that was picked, so a Special pick carries its own receipt cost (2.3, 2.5).
7. ~~**"FIFO (Special)".**~~ Resolved: not a method; the client script allows exactly FIFO, FIFO (Batch) and Special (Batch) for auto-assembly (1.4).
8. ~~**InTransit field.**~~ Resolved: the drill-down covers purchases, advanced purchases, stock transfers and production orders; locations cannot be deleted while in-transit quantity is non-zero (3).
9. **NextDeliveryDate.** Described only as the expected delivery date of stock on order. Which date wins with several open POs (earliest assumed) is undocumented.
10. ~~**Allocation moment.**~~ Resolved: sale authorisation allocates (released at ship), picking allocates if that has not happened, and allocated stock keeps an empty batch until it is picked; assembly allocates components at authorisation and removes them from on hand at the allocate step (3, 1.4).
11. ~~**Void rules for adjustments, transfers, stocktakes.**~~ Resolved: see 4.1 (void/undo, blocked once stock is consumed), 5.1 and 6.1. One conflict remains, item 20.
12. **Cost of positive adjustments on existing stock lines.** Cost entry is documented for zero-stock/new lines only; existing lines carry no cost in the client and the CSV ignores unit cost for them. The cost applied to a gain on an existing line is assumed to be the product's average cost.
13. **Zero-cost add and journals.** The UI makes unit cost optional with a cost estimate default, the CSV requires a positive cost for Zero rows, and the client does not check. Whether the server stores a 0-cost layer and whether a 0-amount journal is created or suppressed is not documented.
14. **Negative stock (narrowed).** Documented in 9: sales authorise, fulfilment waits in Picking, voids and undos refuse to go negative, backdated receipts create negatives. Still open: a global allow-negative setting (the auto-assembly article refers to unnamed "settings" that allow refilling negative stock) and whether transfers or write-offs block at zero on the server.
15. **Stocktake uncounted lines.** The help center lists the sections and says to enter a count per non-zero line but never says what happens to a line left blank. A third-party WMS guide treated blanks as zero. `UseRelativeQuantity` is undocumented (typed `number`); the client treats counts as absolute.
16. ~~**Gift card and fixed asset rules.**~~ Resolved: see 1.1 (one gift-card product, liability account, base currency, no third-party channels; fixed assets need a type and a fixed-asset location, quantity via purchase/adjustment/stocktake, unavailable under Xero).
17. ~~**Family inheritance.**~~ Resolved: the "How families update variations" list of overwritten fields is in 10. What locks after variations have stock is still unstated but no longer blocks implementation.
18. **Rounding in unit conversion** is not documented (the ratio accepts decimals; fractional results are only shown, not explained).
19. ~~**Journal legs marked [INFER].**~~ Resolved: the transfer receive, assembly, disassembly, write-off, credit-note restock and accrual-off legs are documented (12). Remaining [INFER] rows (PO void, sale void, assembly void, deprecate-reactivate) are low-risk reversals.
20. **Transfer undo while in transit.** The help center says undo and void do not apply to FBA orders or orders in transit; the client script enables Undo for IN TRANSIT. Treat the help text as authoritative for the clone's first cut and verify on a sandbox account.
21. **Manual selection of FIFO/FEFO batches.** The sale-pick and batch articles say a picker cannot choose a different number on FIFO/FEFO lines; the costing-method, pick-settings and WMS articles say any batch or serial can be scanned and the recommendation setting only warns or enforces. The portal selector versus scanner distinction is the likely reconciliation, unconfirmed.
22. **"Exclude expired batch/serial numbers" default.** The setting exists; its default and whether auto-pick excluded expired stock before it was added are not stated.
23. **Auto-disassembly costing methods.** Help text allows FIFO, FIFO (Batch) and Special (Batch) (plus the non-existent "FIFO (Special)"); the client alert also lists FEFO (Batch). The client check clears the auto-assembly box instead of the auto-disassembly box (see `rules/inventory-client.md`).
24. **Transfer order reservation.** Whether authorising a transfer order reserves source stock is not documented; transfers may move allocated-but-unpicked stock, and the client does not block quantities above available.
25. **Family SKU length.** The family article gives 45 characters; the product API and client give 50. Use 45 for families until proven otherwise.
