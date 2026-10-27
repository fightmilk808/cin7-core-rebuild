# Cin7 Core reference books: rules spec

What each lookup list / master list (Settings > Reference books, module 14) is for, every field, the validation and
in-use rules, what a new account starts with, and what each book does to the rest of the app. Rules only: no company
data. The map in `spec/` has screens, fields and tables; this file adds the behaviour.

Source: the public Cin7 Core help center, read in full (all 660 articles, plain text), plus the public API v2 map and
the repo spec. Rules are paraphrased; each carries a tag and a source key (keys are listed under "Sources").

## How to read this file

Every rule carries a tag and, where it is not obvious, a source key (keys are listed under "Sources").

| Tag | Meaning |
|---|---|
| `[DOC:KEY]` | Stated in the Cin7 Core help center article named by the key (URL under "Sources"). The article was read in full; the rule is paraphrased, never quoted at length. |
| `[API]` | Visible in the public API v2 shape (field names/types from the `cin7-core` map: `describe_operation`) or in the help center's API reference articles (lengths, required flags, enumerations). Neither carries validation text beyond that, so `[API]` never proves a range. |
| `[SPEC]` | Recorded in the repo spec (`spec/modules/14-reference-books/{README,UI}.md`, `schema.sql`): the screen, control, option list or table that exists. Proves the field exists and which options a select offers, not what they do. |
| `[INFER]` | The help center does not say, but the rule follows from a documented rule or from how a comparable documented rule behaves. Safe default for the sandbox; flag if tests disagree. |
| `[ASSUME]` | A choice made to fill a gap. Nothing supports it. Each is repeated in "Unclear / docs disagree". |

Conventions: "required" in field tables means the screen or API rejects a blank. Where no source says, the cell reads
`?` and the same row is listed in the final section. Lengths come from the API reference articles (name fields are
50 characters unless stated); where the repo spec's screen text differs, the difference is called out. `(corrected)`
marks a rule this pass changed because the full articles contradict the earlier excerpt-based version.

## Contents

⚠️ [Gotchas: the sneaky stuff](#%EF%B8%8F-gotchas-the-sneaky-stuff)

0. [Cross-cutting rules](#0-cross-cutting-rules)
1. Financial: [Chart of accounts](#1-chart-of-accounts) · [Account mapping](#2-account-mapping) · [Bank accounts](#3-bank-accounts) · [Tax rules](#4-tax-rules) · [Payment terms](#5-payment-terms) · [Accounting dimensions](#6-accounting-dimensions) · [Opening balances](#7-opening-balances) · [Fixed asset types](#8-fixed-asset-types) · [Expense items](#9-expense-items)
2. Currencies and exchange rates (no book of its own): [section 10](#10-currencies-and-exchange-rates)
3. Stock: [Locations](#11-locations) · [Bins](#12-bins) · [Put away rules, bin groups, pick zones](#13-put-away-rules-bin-groups-and-pick-zones) · [Supply rules and transfer planning](#14-supply-rules-and-transfer-planning) · [Logistics paths](#15-logistics-paths) · [Units of measure](#16-units-of-measure) · [Product categories](#17-product-categories) · [Brands](#18-brands) · [Attribute sets](#19-attribute-sets) · [Discounts](#20-discounts-and-deals) · [Price tiers](#21-price-tiers) · [Default field values](#22-default-field-values)
4. Other items: [Carriers](#23-carriers) · [Shipping zones](#24-shipping-zones) · [Order routing](#25-order-routing) · [Returns: reasons, policies, settings](#26-returns-reason-for-return-return-policy-return-order-settings) · [Warranties](#27-warranties) · [Company addresses and contacts](#28-company-addresses-and-contacts) · [Lead statuses](#29-lead-statuses) · [Cin7 Core to Cin7 Core network](#30-cin7-core-to-cin7-core-network)
5. [Unclear / docs disagree](#unclear--docs-disagree) · [Sources](#sources)

Page-to-book map (31 module-14 pages, `spec/modules/14-reference-books/UI.md`): AccountMapping, AccountingDimensions,
BankAccounts, ChartOfAccounts, DealList, DearToDearNetworking, DefaultFieldValues x3 (Customer, Product, Supplier),
DiscountListNew, ExpenseItems, FixedAssetType, LeadStatus, OpeningBalances, OrderRouting, RMAReasonForReturn,
RMAReturnOrderSettings, RMAReturnPolicy, TenantAddress, TenantAttributeSet, TenantBrand, TenantCarrier, TenantContact,
TenantInventoryCategory, TenantLocation, TenantLocationEdit, TenantPaymentTerm, TenantShipZone, TenantTaxationRule,
TenantUnitOfMeasure, WarrantySetupList. [SPEC]

---

## ⚠️ Gotchas: the sneaky stuff

The easy-to-miss behaviours, worst first. `CAUTION` = silently corrupts data, cost or stock, is irreversible, or fails silently. `WARNING` = a surprising rule that breaks a rebuild if missed. `NOTE` = the sources disagree or the rule is easy to misread. Each links to the full rule below.

> [!CAUTION]
> **A locked period rejects postings, including the shipment that creates COGS**
> Once a period lock date is set, nothing dated before it can be added, edited or deleted. A sale invoiced before the lock but shipped after it fails to authorise the shipment at the default (invoice-date) ship date; the user must re-date the shipment after the lock, and that date becomes the COGS date [DOC:COGS, DOC:FIN-SET]. See [How the slots are used](#how-the-slots-are-used-which-transaction-picks-which-account).

> [!CAUTION]
> **Shipping before the purchase invoice is authorised books zero COGS, then a late correction**
> Cost comes from the authorised purchase invoice, not from the stock receipt. Stock received but not yet invoiced can be picked and shipped with COGS of 0; when the invoice is authorised later, an extra COGS entry is created at the invoice date (history is never rewritten). Drop-ship lines have no Ship tab and book COGS at purchase-invoice authorisation instead [DOC:COGS]. See [How the slots are used](#how-the-slots-are-used-which-transaction-picks-which-account).

> [!CAUTION]
> **Loading stock on hand twice creates duplicate stock, not an update; the conversion date cannot be edited**
> The stock-on-hand import is a one-time setup tool: a second upload creates new product instances instead of changing quantities. Once opening balances are entered the conversion date is locked; the only way back is to void the opening-balance tasks and re-enter them. Transactions dated before the conversion date are disregarded [DOC:OPEN, DOC:SOH]. See [section 7](#7-opening-balances).

> [!CAUTION]
> **Adding a first sub-account moves all of the parent's history to the child**
> In tree mode (the default for a standalone account), adding a sub-account to an account that already has transactions asks for confirmation, then moves every transaction to the new child. Postings are allowed only on the lowest level afterwards, and only lowest-level accounts can be mapped or picked on documents [DOC:COA]. See [section 1](#1-chart-of-accounts).

> [!CAUTION]
> **Used records can never be deleted, only retired**
> Accounts, bank accounts, locations, bins, tax rules, accounting dimensions, logistics paths and customers/suppliers/products that were used cannot be deleted (tax rules can never be deleted at all). Warranties and return policies behave differently: a warranty in use on a product must be swapped off first. For books the docs are silent on, the same retire-don't-delete pattern is applied [DOC, INFER]. See [section 0, rule 3](#0-cross-cutting-rules).

> [!CAUTION]
> **Blank account-mapping slots only fail when a function needs them**
> Blank slots are allowed, so the setup looks complete. The error appears mid-operation: Cin7 reports it and may not complete the operation [DOC:COA-SET]. A tree chart also hides every parent account from mapping [DOC:COA]. See [section 2](#2-account-mapping).

> [!WARNING]
> **Discounts: customer-level does not always win, and the "stack" switch changes the answer**
> (corrected) Only one product discount applies at a time (individual-customer beats customer-group beats product). The percentage discount on the customer record is separate: with "Apply customer discount after other discounts" Off, Cin7 compares it with the product discount and keeps whichever gives the lower price; with it On, it is applied on top of the best product discount. Order-line discounts always apply last. Deals never stack with catalogue discounts: the best one wins [DOC:DISC, DOC:DEAL]. See [section 20](#20-discounts-and-deals).

> [!WARNING]
> **The document's "Tax inclusive" box beats every line rule**
> A rule has its own inclusive/exclusive default (Exclusive), but the header checkbox decides for the whole document. Rule priority is line, then sales channel, then product, header, customer; on the B2B portal the buyer cannot override it and a product-level rule beats the customer's [DOC:TAX]. See [section 4](#4-tax-rules).

> [!WARNING]
> **Payment-term "0" means different things per method**
> (corrected) "Day of next month" with 0 is the last day of the invoice month; "Days since the end of the month" with 0 is the last day of the invoice month for a created sale but the first day of the next month for recurring sales/invoices. "Last day of next month" ignores Days and is not offered on QuickBooks Online accounts [DOC:REF]. See [section 5](#5-payment-terms).

> [!WARNING]
> **Order routing exact-matches text and its out-of-stock fallback is described two ways**
> State names must match exactly ("Victoria" and "Victoria (VIC)" differ). With "Keep routing" Off (default) one passage says an out-of-stock line goes to the default location, another says a random location that has stock. Not available for Shopify POS, and routing beats the Shopify location [DOC:OR]. See [section 25](#25-order-routing).

> [!WARNING]
> **Foreign-currency prices: static tiers are not converted and there is no rate table**
> Base currency can only change before the first transaction. There is no currency or rate book; the rate lives on each document and is filled from an external rate feed. The order of conversion versus markup for calculated tiers is stated both ways in the same articles [DOC:MULTI, DOC:PRICE]. See [section 10](#10-currencies-and-exchange-rates).

> [!WARNING]
> **Defaults only pre-fill new records; changing one rewrites nothing**
> Default field values (and defaults like default location or payment term) are copied at creation and stay editable. Existing records keep the old value. The same defaults feed customers created by Amazon, eBay, Magento, ShipStation, Shopify and WooCommerce [DOC:DEFVAL, INFER for "never rewrites"]. See [section 22](#22-default-field-values).

> [!WARNING]
> **Accounting dimensions: unavailable with Xero/QuickBooks, new transactions only, undeletable once used**
> The feature is off by default, cannot be used on an account connected to Xero or QuickBooks Online, is applied to new transactions only (older ones can be edited only while their period is open), and a dimension that has been used can never be deleted [DOC:DIM]. See [section 6](#6-accounting-dimensions).

> [!NOTE]
> **Two articles rank revenue accounts differently**
> One lists order line, sales channel, product, customer, order header, general settings; another lists order line, product, header, customer/supplier. The header-versus-customer order is the conflict. The sandbox follows the first for revenue and the second for everything else [DOC:COA, DOC:COA-SET]. See [section 2](#2-account-mapping).

---

## 0. Cross-cutting rules

These apply to every book unless the book's section says otherwise.

1. **Where they live.** Settings > Reference books, with tabs All / Your company / Financial / Default field values /
   Other items / Stock. [DOC:REF]
2. **Shared screen features.** Most books have Export (CSV) and an Activity log (who changed what, and when); several
   have Import (CSV); long lists such as company contacts have Search. The import header row must stay, all columns
   must be present and in template/export order, and the file is saved as `.csv` or `.txt`. [DOC:REF, DOC:IMPORT]
3. **Deprecate, don't delete, once used.** A record never used in a transaction can be deleted; a used one can only be
   made inactive (Deprecated / Archived / Is active off), which removes it from pickers but keeps history. Per book:

   | Book | Guard |
   |---|---|
   | Accounts, bank accounts | Archive first, then "Delete unused archived accounts"; any use (transaction, customer, supplier) blocks delete. Archiving a parent archives its sub-accounts. [DOC:COA, DOC:BANK] |
   | Tax rules | Never deletable; set Deprecated. [DOC:TAX] |
   | Locations | Deletable only if unused AND on hand, available, on order, in transit and allocated are all zero; otherwise tick Deprecated. [DOC:LOC] |
   | Bins | Deletable if never used; once used, Deprecated (drops out of WMS). [DOC:BINS] |
   | Accounting dimensions | Never deletable once used; edits apply to new tasks only. [DOC:DIM] |
   | Logistics paths | Cannot be deleted or have a location changed once used on a production or sales order. [DOC:LP] |
   | Warranties | Deletable/deactivatable at any time unless applied to a product (swap the product's warranty first); existing sales keep their warranty. [DOC:WARR] |
   | Return policies | Can be deactivated or deleted; at least one active policy must exist for RMAs to start. [DOC:RET-POL] |
   | Lead statuses | Default statuses are fixed; custom ones can be edited and deleted. Leads themselves cannot be deleted. [DOC:LEAD] |
   | Customers, suppliers, products | Deletable only if never used (deprecate otherwise). [DOC] |
   | Payment terms, carriers, categories, brands, units, attribute sets, price tiers, discounts, deals, shipping zones, expense items, fixed asset types, routing rows | Not stated; the sandbox applies delete-unless-in-use. [INFER] |

4. **Inactive entries leave pickers, stay on old documents.** An inactive entry is not offered on new documents or in
   CSV import look-ups, but documents already carrying it keep displaying it. [DOC:TAX, DOC:WARR, INFER for the rest]
5. **Priority when several places set the same thing.** Tax: order line > sales channel > product > document header >
   customer/supplier. Accounts: order line > product > document header > customer/supplier (revenue accounts also
   have a sales-channel level; see Gotchas and [section 2](#2-account-mapping)). Defaults from Default field values
   apply only when nothing else filled the field. [DOC:TAX, DOC:COA-SET, DOC:COA]
6. **Defaults pre-fill only new records.** A reference book default (default location, default payment term, default
   tax rule, default carrier...) is copied into a *new* record or document and stays editable. Changing it later
   never rewrites existing records. [DOC:DEFVAL, INFER for the "never rewrites"]
7. **Xero / QuickBooks Online connected.** Chart of accounts, bank accounts, tax rules, payment terms and company
   addresses are managed in the accounting system and arrive read-only or sync-only in Cin7; fixed assets, spend/
   receive money, expense claims, journals and bank reconciliation are not available with Xero; accounting
   dimensions need an unconnected account. Details per book. [DOC:COA, DOC:FIN-INTRO, DOC:DIM, DOC:TAX2, DOC:XERO-SYNC]
8. **Permissions.** Each reference book is gated by a role permission in Users and roles (read-only or full access;
   multiple roles combine to the highest). Read-only shows the list but save/add/delete/import are disabled. Names
   in the docs: Settings - Your company (General settings, Addresses, Contacts); Settings - Financial (Chart of
   accounts and mapping, Taxation rules, Payment terms); Settings - Stock (Product categories, Brands, Locations,
   Units of measure, Product discounts); Settings - Other items (Carriers, Shipping zones, Additional attributes,
   Lead categories); Financials (Bank accounts, Fixed assets, Opening balances, Default expense items, Accounting
   dimensions - Settings and - Transactions); RMA - Set up; Warranty - Setup and - Search; Configure default values
   (admins/owners and users granted it); Core to Core networking. [DOC:PERM, DOC:FIN-INTRO, DOC:DEFVAL]
9. **API v2 surface for reference data** (`GET` list with `Page`/`Limit` where paged, `POST` create, `PUT` update,
   some `DELETE`; the help center's API reference pages document GET only): `/ref/account`, `/ref/account/bank` (GET
   only), `/ref/attributeset`, `/ref/brand`, `/ref/carrier`, `/ref/category`, `/ref/fixedassettype`, `/ref/location`,
   `/ref/paymentterm`, `/ref/priceTier` (GET only), `/ref/tax`, `/ref/unit`. Nothing else in module 14 has a public
   endpoint. [API]
10. **IDs.** Public API ids are GUIDs (`ID`, `CarrierID`, `AccountID`, `FixedAssetTypeID`); chart-of-accounts rows are
    keyed by `Code`. [API]
11. **What a new account starts with** (seeded entries; everything else is empty):

    | Seeded | Detail |
    |---|---|
    | Accounts | A default chart ("Use default" restores it) including the four system accounts Accounts Receivable, Accounts Payable, Sales Tax and Sales/Revenue. [DOC:COA] |
    | Chart structure | Tree for a standalone account, flat when Xero/QuickBooks Online is connected. [DOC:COA] |
    | Tax rules | Default rules pre-loaded when the store country is Australia, the UK, the USA or New Zealand; other countries start empty. [DOC:TAX] |
    | Payment term | Customers and suppliers default to a 30-day term. [DOC:DEFVAL] |
    | Product defaults | Type Stock, costing FIFO, "I am selling this product" Yes, drop ship No. [DOC:DEFVAL, DOC:API-DEFAULTS] |
    | Customer/supplier currency default | The organisation's base currency. [DOC:DEFVAL] |
    | Lead statuses | Attempting to contact, New, Qualified, Disqualified. [DOC:LEAD] |
    | RMA milestones and cost types | Milestones: shipping from customer, inspection, repair, shipping to customer. Cost types: shipping, inspection, repair. [DOC:RET-POL] |
    | Warranty form defaults | Registration number Auto, term Lifetime, status Active. [DOC:WARR] |
    | Shipping zones | Feature starts Disabled until switched on. [DOC:SZ] |
    | Accounting dimensions | Feature starts disabled. [DOC:DIM] |
    | Order routing | Off, with Keep routing Off. [DOC:OR] |
    | Locations | None named in the docs; with a single location it becomes the default automatically. [DOC:LOC] |
    | Not published | The full default chart's account list, and which seeded entries are locked. [see Unclear] |

---

## 1. Chart of accounts

Route `/ChartOfAccounts`. Table `vChartOfAccounts`; lookups `vAccountTypesAndClasses`, `vAccountClassTypes`,
`vAccountStatusCode`, `vSystemAccountInfo`. API `/ref/account`. [SPEC, API]

**Purpose.** The ledger accounts every financial posting lands in: sales, purchases, inventory, COGS, tax liability,
customer credits, supplier deposits, bank, fixed assets, WIP, currency gains. Accounts are picked on products,
customers, suppliers, tax rule components, fixed asset types, expense items and in account mapping.

### Fields

| Field (UI / API) | Required | Type | Allowed values / rules | Default |
|---|---|---|---|---|
| Code / `Code` | yes | text, 50 | Unique across the chart. [API] The repo spec's modal hint shows a longer limit that its map cuts off; the API reference (50) is used. Codes can be edited (import has a "New code" column); `OldCode` records the previous one. [DOC:COA, SPEC] | none |
| Name / `Name` | yes | text, 50 | Short title. (corrected: the repo spec's screen says 150; the API reference says 50.) [API, SPEC] | none |
| Description / `Description` | no | text, 1024 | How the account should be used. [API] | blank |
| Account type / `Type` | yes | list | See type list below; type determines class. [SPEC, DOC:COA] | none |
| Class / `Class` | derived | list | `ASSET, EQUITY, LIABILITY, EXPENSE, REVENUE`; set by the type. [API] | derived |
| System account / `SystemAccount` | no | list | A system role the account plays (Accounts Receivable, Accounts Payable, Sales Tax, Revenue...). `None` for ordinary accounts. Grid `vSystemAccountInfo` has "Multiple allowed". [SPEC, API] | None |
| Parent account | no | list | Tree charts only: choosing None makes a root account; otherwise parent, type and system-account are inherited and cannot be edited on the child; up to 10 levels. [DOC:COA] | none |
| Status / `Status` | yes | list | `ACTIVE`, `ARCHIVED`. "Deprecated" is used loosely in the tree-chart text for the same retired state. [API, DOC:COA] | Active |
| Accept payments / `AcceptPayments` | no | bool | Lets the account be chosen as a payment account in the purchase and sale payment sections. [DOC:COA, API] | off |
| Bank fields (`BankAccountNumber`, `BankAccountId`, `CurrencyCode`) | bank only | text | Only on accounts created via "+ Bank account" (section 3). [SPEC, API] | null |
| Old code / `OldCode` | no | text | Written when a code is changed by import. [SPEC, API] | null |
| Accounting dimension tab | no | per-dimension tick | Which dimensions (and which master data) are tracked on this account (section 6). [DOC:DIM] | none ticked |

**Type list** (the Xero-style list the add-account modal offers): Current Asset, Fixed asset, Non-current Asset,
Prepayment, Equity, Depreciation, Direct Cost, Expense, Overhead, Current Liability, Liability, Non-current
Liability, Other Income, Revenue, Sales (list truncated in the map). Bank is a separate type created only through
the bank-account dialog. [SPEC]

### Rules

- A default chart exists for a new account. The "Use default" button resets the chart to it; More actions > Import
  loads a CSV (first download the export as the template, which can add, edit and delete rows; the header must not
  change; a "performed actions" grid reports per row). [DOC:COA, SPEC]
- **Always present (created by Cin7):** Accounts Receivable, Accounts Payable, Sales Tax, Sales/Revenue (system
  accounts). [DOC:COA]
- **Required accounts and their types** (must exist; mapped in section 2). Used by default when nothing more specific
  is set on the product, customer, document or line. [DOC:COA, DOC:COA-SET]

  | Account | Type | Accepts payments |
  |---|---|---|
  | Inventory Control | Current Asset | no |
  | Inventory Discrepancy | Expense | no |
  | Cost of Goods Sold | Expense - Direct Cost (standalone and Xero); Cost of Sales - Supplies and Materials (QuickBooks) | no |
  | Default Revenue | Revenue | no |
  | Tax Liability | Current Liability in one article, Liability in the other | no |
  | Work In Progress | Current Asset | no |
  | In Transit | Current Asset | no |
  | Supplier Deposits | Current Asset | yes |
  | Customer Credits | Current Liability | yes |

- **Optional accounts** (corrected: Current Year Profits is optional, not required): Inventory Accrual / Goods
  Received Not Invoiced (current asset or current liability), Stock in Transit / Goods Invoiced Not Received (current
  asset), Realized Currency Gains (expense), Unrealized Currency Gains (expense), Payment Clearing (bank), Current Year
  Profits (equity), Gift Card Liability (current liability, accepts payments). The two accrual accounts need the
  Inventory Accrual setting on; gift card liability needs gift cards on; realized gains is required for multiple
  currencies; realized gains and payment clearing are required to consolidate QuickBooks Online transactions;
  unrealized gains and current year profits are needed only when the matching financial settings are on.
  [DOC:COA, DOC:COA-SET, DOC:PERIOD]
- **Tree vs flat** is the tenant setting "Chart of accounts type": tree by default for a standalone account, flat
  only when Xero/QBO is connected. In tree mode: postings, mapping, document pickers and journals use only the
  lowest-level accounts; parents are summary-only; archiving a parent archives its sub-accounts; adding a sub-account
  to an account that already has transactions asks for confirmation and moves those transactions to the new child.
  An account-code delimiter (setting) joins parent and child names for display. Parents can be selected on the trial
  balance, balance sheet, profit and loss, account summary and financial payment details reports. [DOC:COA, DOC:FIN-SET]
- **Deletion.** An account that has been used (transaction, supplier, customer) cannot be deleted, only archived.
  Unused accounts must be archived first, then removed with More actions > "Delete unused archived accounts".
  [DOC:COA]
- **In use means:** appears on a posted transaction, a supplier or customer, a tax-rule component or an account-
  mapping slot. Archiving a mapped account is not described; the sandbox blocks it `[INFER]`.
- **Xero / QuickBooks Online connected:** the chart is created there and arrives read-only; Cin7 will not edit it.
  Remapping many accounts at once after connecting Xero can lock the organisation for hours, so remap one at a time.
  QuickBooks product-level revenue mapping always overrides Cin7's. [DOC:COA, DOC:COA-SET]
- **Revenue account priority** (a different list from the generic account priority in section 2): order line (if
  manually changed) > sales channel (integration) revenue account > product > customer > order header > general
  settings. [DOC:COA]
- Permission: "Financial - Chart of accounts and mapping" (full to change); "Settings - Your company - General
  settings" to switch tree/flat. [DOC:COA]

### Effects elsewhere

Every posting resolves to a `Code` from this book (section 2). Tax rule components carry an account here; fixed
asset types carry three; expense items carry one; customers/suppliers carry AR/AP and sale/purchase accounts;
products carry revenue/COGS/inventory accounts.

---

## 2. Account mapping

Route `/AccountMapping`. Model `AccountsMapping`; the page also reads `vTenantTaxationRule` for the supplier deposit
zero-rate tax rule. [SPEC]

**Purpose.** Chooses which chart-of-accounts account each *system function* posts to when nothing more specific
(order line, product, header, customer/supplier) overrides it. [DOC:COA-SET]

### Fields (one select per slot; all pick active accounts of an allowed type)

| Slot (UI label) | Map field | Required to use | Type of account expected | Shown only when |
|---|---|---|---|---|
| Inventory control account | `InventoryControlAccount` | any stock movement | current asset | always |
| Cost of goods sold account | `CostOfGoodsSoldAccount` | any shipment | direct cost (QuickBooks: cost of sales) | always |
| Default revenue account | `DefaultRevenueAccount` | sale invoice with no more specific revenue account | revenue | always |
| Tax liability account | `TaxLiabilityAccount` | tax rule component with no account of its own `[INFER]` | liability / current liability (articles differ) | always |
| Inventory discrepancy account | `InventoryDiscrepancyAccount` | stocktake, adjustment | expense | always |
| Work in progress account | `WipAccount` | assembly, disassembly, production | current asset | always |
| In-transit account | `TransferInTransitAccount` | stock transfer marked in transit, co-manufacturing transfers | current asset | always |
| Supplier deposits account | `PurchasePrepayment` | supplier deposit | current asset, accepts payments | always |
| Customer credit account | `SalePrepayment` | customer credit / prepayment | current liability, accepts payments | always |
| Current year profits account | `CurrentYearProfitsAccount` | carry-forward P&L at period close | equity | always (needed when carry forward or unrealized adjustment is on) |
| Realized currency gains account | `RealisedCurrencyGainAccount` | settling a foreign-currency document at a different rate | expense | always (Xero: must be the Xero system account for realized gains) |
| Unrealized currency gains account | `UnrealisedCurrencyGainAccount` | unrealized FX adjustment at period close | expense (the period report says the result sits in equity) | always (Xero: Xero system account for unrealized gains) |
| Payment clearing account | `PaymentClearingAccount` | consolidating QuickBooks payments | bank | always |
| Goods received not invoiced account | `InventoryAccrualAccount` | stock-first purchases | current asset or current liability | Inventory accrual enabled (also mappable in general settings) |
| Goods invoiced not received account | `StockInTransitAccount` | invoice-first purchases | current asset | same setting on |
| Gift card liability account | `GiftCardAccount` | gift card sale | current liability, accepts payments | Gift cards on |
| Supplier deposit zero-rated tax rule | QB-only select | QuickBooks supplier deposits | active tax rule | QuickBooks Online connected |

[SPEC for slots and conditions; DOC:COA, DOC:COA-SET, DOC:ACCRUAL, DOC:PERIOD for the types and when each is needed]. A page section "Add account to Xero"
(type, code, name, description, show in expense claims, enable payments) lets a missing account be created in the
accounting system without leaving the page. [SPEC]

### Rules

- Mappings are one-to-one with accounting-system accounts: each Cin7 account must map to a unique Xero/QuickBooks
  account. [DOC:COA-SET]
- With a tree chart only bottom-level accounts can be mapped. [DOC:COA]
- Setup order: charts, mapping and bank accounts must exist before the first data load (suppliers, customers,
  products, stock on hand, opening balances, any transaction). [DOC:COA-SET, DOC:OPEN]
- Defaults are pre-selected for some activities; the user confirms or changes them and saves. [DOC:COA]
- Blank slots are allowed. The error appears only when a function needs the slot; Cin7 reports it and may not
  complete the operation. [DOC:COA-SET]
- **Resolution order for any financial line:** order line (highest, overrides everything) > product > document
  header > customer / supplier > this mapping. Revenue accounts have the longer list in section 1 (sales channel and
  an order level that sits after the customer). [DOC:COA-SET, DOC:COA]
- **Where each override lives:** products carry inventory control, revenue and COGS accounts and tax rules; suppliers
  carry the accounts-payable account, tax rule and payment term; customers carry the accounts-receivable account,
  default sale account, tax rule and payment term; a purchase document and its lines carry the inventory account,
  tax rule and a conversion rate; a sale document carries the sale account, tax rule (also per line) and rate;
  additional costs and additional charges can each use their own account and tax rule. An additional purchase cost
  booked to the same inventory account as the product is capitalised into stock cost; booked to any other account
  it is an expense. [DOC:COA-SET, DOC:COGS]
- Permission "Financial - Chart of accounts and mapping" full access. [DOC:PERM]
- Accrual and gift-card slots are hidden until their feature is enabled. [DOC:COA-SET, DOC:ACCRUAL]

### How the slots are used (which transaction picks which account)

Journals are generated when these events are authorised or completed: a purchase order or sale quote that carries a
deposit/prepayment, a purchase or sale invoice or credit note, a sale shipment, a manual journal, a stocktake,
stock adjustment, assembly, production, write-off or disassembly, and the undo or void of any of these. Authorising
a purchase **stock receipt creates no journal** (unless the accrual setting is on); it only updates quantities.
Stock transfers create journals only while in transit. [DOC:ACCT-TX, DOC:XFER]

Amounts shown are the documented examples' signs: a reversal is a negative amount on the same debit/credit pair,
not a swapped pair.

| Transaction (event) | Debit | Credit | Date | Account source |
|---|---|---|---|---|
| Purchase order with supplier deposit authorised | Supplier Deposits | Bank | deposit date | mapping (deposit account auto-filled) [DOC:ACCT-TX, DOC:SD] |
| Purchase invoice authorised, product lines | Inventory Control | Accounts Payable | invoice date | product inventory account, else header/mapping [DOC:ACCT-TX] |
| Purchase invoice tax | Tax (component liability account) | Accounts Payable | invoice date | tax rule [DOC:ACCT-TX] |
| Purchase invoice additional cost, not capitalised | Expense account chosen on the line | Accounts Payable | invoice date | line [DOC:ACCT-TX] |
| Purchase invoice additional cost, capitalised | Inventory Control (same account as the product) | Accounts Payable | invoice date | line [DOC:ACCT-TX] |
| Supplier deposit applied to the invoice | Accounts Payable | Prepayment (Supplier Deposits) | invoice date | mapping [DOC:ACCT-TX] |
| Drop-ship purchase invoice (extra) | Cost of Goods Sold | Inventory Control | invoice date | product/mapping [DOC:ACCT-TX, DOC:COGS] |
| Purchase credit note | Inventory Control (negative), Tax (negative) | Accounts Payable | credit note date | as the invoice [DOC:ACCT-TX] |
| Purchase payment | Accounts Payable | Bank | payment date | payment account [DOC:ACCT-TX] |
| Stock first, accrual on: stock received | Inventory | Goods Received Not Invoiced | stock received date | cost from the PO line, else average cost at receipt; additional costs are not accrued [DOC:ACCRUAL] |
| Stock first, accrual on: invoice authorised | Inventory (negative, reverses accrual) then Inventory | Goods Received Not Invoiced (negative) then Accounts Payable | invoice date | system manual journals, undeletable [DOC:ACCRUAL] |
| Invoice first, accrual on: invoice authorised | Stock in Transit (replaces every asset-class line account) | Accounts Payable | invoice date | mapping [DOC:ACCRUAL] |
| Invoice first, accrual on: stock received | Inventory (invoice accounts) | Stock in Transit | latest stock received date | system manual journal [DOC:ACCRUAL] |
| Sale quote/order with customer credit (prepayment) | Bank | Customer Credits | prepayment date | mapping [DOC:ACCT-TX, DOC:CC] |
| Sale invoice authorised, revenue lines | Accounts Receivable | Revenue (line > channel > product > customer > order > Default Revenue) | invoice date | [DOC:ACCT-TX, DOC:COA] |
| Sale invoice tax | Accounts Receivable | Tax (component account, else Tax Liability) | invoice date | tax rule [DOC:ACCT-TX] |
| Sale invoice additional charge | Accounts Receivable | Sale account chosen on the charge | invoice date | charge line [DOC:ACCT-TX] |
| Customer credit applied to invoice | Prepayment (Customer Credits) | Accounts Receivable | invoice date | mapping [DOC:ACCT-TX] |
| Non-inventory item invoiced | Accounts Receivable | Account specified on the invoice line | invoice date | line [DOC:ACCT-TX] |
| Sale shipment authorised | Cost of Goods Sold | Inventory Control | latest shipment date; a manual or landed-cost entry made later is dated at its own effective date | cost of the picked layers by costing method [DOC:ACCT-TX, DOC:COGS] |
| Sale payment | Bank | Accounts Receivable | payment date | [DOC:ACCT-TX] |
| Sale credit note | Accounts Receivable and Cost of Goods Sold (amounts negative) | Sale, Tax and Inventory Control respectively | credit note date | [DOC:ACCT-TX] |
| Manual journal capitalising overhead | Inventory Control (or COGS to change a sale's margin) | the chosen overhead account | journal date | journal lines [DOC:ACCT-TX] |
| Stock adjustment / stocktake gain | Inventory Control | Inventory Discrepancy | effective date | mapping or the expense account chosen on the task [DOC:ACCT-TX] |
| Stock adjustment / stocktake loss | Inventory Control with negative amount | Inventory Discrepancy with negative amount | effective date | same [DOC:ACCT-TX] |
| Inventory write-off | Expense account selected on the task | Inventory Control (components) and the labour/overhead account (those lines) | completion date | task [DOC:ACCT-TX] |
| Assembly: components allocated | Work in Progress | Inventory Control | completion date | mapping [DOC:ACCT-TX] |
| Assembly: completed | Inventory Control | Work in Progress | completion date | mapping [DOC:ACCT-TX] |
| Assembly: labour / overhead allocated | Inventory Control | the labour or overhead account | completion date | task [DOC:ACCT-TX] |
| Disassembly | (1) Work in Progress, (2) Inventory Control for the recovered components, (3) Inventory Control for labour/overhead | (1) Inventory Control, (2) Work in Progress, (3) the labour/overhead account | completion date | mapping [DOC:ACCT-TX] |
| Stock transfer sent while in transit | In-transit account (or an asset account picked on the transfer) | Inventory (the account of the stock moved) | stock sent date | mapping [DOC:XFER] |
| Stock transfer received | Inventory | In-transit account | stock received date | reverses the send; cost changes after sending are posted at their own date; a transfer with no transit time posts no journal [DOC:XFER] |
| Co-manufacturing components sent / received / completed | In Transit on send; Work in Progress on receipt; product cost base on completion | Inventory; In Transit; Work in Progress | each step's date | [DOC:COMAN] |
| Foreign-currency settlement at a different rate | Realized Currency Gains (loss or gain) | Accounts Receivable/Payable | settlement | mapping [DOC:MULTI, DOC:PERIOD] |
| Period close, unrealized adjustment on | one manual journal per currency, rate editable first | Unrealized Currency Gains | period close | mapping [DOC:PERIOD] |
| Period close, carry-forward on | profit and loss balances | Current Year Profits (retained earnings) | period close | mapping, balances editable before posting [DOC:PERIOD] |
| Fixed-asset depreciation run | Depreciation expense account of the asset's type | Accumulated depreciation account of the type | run end date | fixed asset type [INFER] |

### Cost and COGS timing rules

- Cost is attached to stock when the **purchase invoice** is authorised; stock quantity is added when the **stock
  received** is authorised. A product received but not invoiced carries 0 cost and can ship at 0 COGS; the cost then
  appears on the invoice date as an extra entry. Average cost is a reference figure only and is never used for COGS.
  [DOC:COGS, DOC:ACCRUAL]
- The COGS date is the shipment date. By default the ship date is today; a setting can use the sale invoice date
  instead. A manually entered past date is allowed. COGS is never rewritten: later cost events create additional COGS
  entries. A shipment cannot be authorised into a closed (locked) period. [DOC:COGS]
- Drop-ship lines have no Ship tab: COGS is booked when the purchase invoice is authorised, dated at the invoice date.
  [DOC:COGS, DOC:ACCT-TX]
- Finished-goods cost is the actual cost of the components allocated plus labour and overheads; the BOM figure is
  only an estimate. [DOC:COGS]

### Worked example (illustrative numbers)

Header default revenue = 4000; product A overrides revenue to 4100; one line of a sale also overrides to 4200.
Sale lines: line 1 product A (no line override) -> posts to 4100. Line 2 product A with line override 4200 -> 4200.
Line 3 product B (no product account) -> falls back to header (none) -> customer (none) -> Default Revenue mapping 4000.

---

## 3. Bank accounts

Route `/BankAccounts`. Table `vBankAccountToShow`; public `GET /ref/account/bank`. [SPEC, API]

**Purpose.** Cash/bank accounts (and credit cards) that payments and receipts are posted to, reconciled against bank
statements. [DOC:BANK]

### Fields

| Field | Required | Type | Rules | Default |
|---|---|---|---|---|
| Account name / `AccountName` | yes | text | editable | none |
| Account currency / `Currency` | yes at create | currency code | read-only on edit [SPEC] | not stated `[ASSUME]` base currency |
| Account code / `AccountCode` | yes at create | text | read-only on edit; it is the chart-of-accounts code of the underlying account [SPEC] | none |
| Bank name / `Bank` | no | text | | blank |
| Account number / `AccountNumber` | no | text | | blank |
| Initial account balance / `InitialBalance` | no | number | optional at creation [DOC:BANK] | 0 |
| Status | yes | Active / Archived | | Active |
| `StatementBalance`, `BalanceInDear`, `BalanceInDearInBankAccountCurrency`, `LastDate`, `TransactionCount` | derived | number/date | statement vs ledger balance, last statement date, count of postings [SPEC, API] | derived |

### Rules

- A bank account is created from the Chart of accounts page with "+ Bank account"; it is an asset account with type
  Bank and appears in the asset list. It can also be edited from Financials > Bank accounts. [DOC:BANK]
- Fully deletable only if never used in any operation or transaction (archive, then "Delete unused archived
  accounts"); used ones stay archived to drop out of selection. [DOC:BANK]
- Statements: CSV import with column mapping (the mapping can be saved for reuse; lines can be deleted, which
  changes the statement balance, and restored), then reconcile; Cin7 auto-matches each statement line to the most
  likely transaction, offers alternatives, and lets the user add bank fees or minor adjustments before reconciling.
  [DOC:BANK]
- Migration: enter the statement balance against the account; items the statement does not yet show go to an
  "Unpresented funds" account created in the chart (current asset, no system account, accepts payments). [DOC:OPEN]
- With Xero, bank accounts are created, managed and reconciled in Xero. With QuickBooks Online, creating bank accounts
  in Cin7 is unavailable (reconciliation can happen in either). [DOC:BANK, DOC:FIN-INTRO]
- Permission: Financials - Bank (add, edit, import statements, reconcile). [DOC:FIN-INTRO]

### Effects elsewhere

Payments on sales and purchases, supplier deposits, customer credits, refunds, spend/receive/transfer money and bank
rules choose from active bank accounts; receiving a customer credit through Receive money needs the bank account and
customer in the same currency. A payment in a currency different from the account's uses the rate on the document
(section 10). [DOC:CC, DOC:MULTI]

---

## 4. Tax rules

Route `/TenantTaxationRule`. Tables `vTenantTaxationRule`, `vTenantTaxationRuleComponent`. API `/ref/tax`. [SPEC, API]

**Purpose.** Defines how tax is added to or extracted from a price: one or more components, each with a rate,
a compound flag and a liability account; and whether prices are tax-inclusive or tax-exclusive by default.

### Fields

| Field (UI / API) | Required | Type | Allowed | Default |
|---|---|---|---|---|
| Tax rule name / `Name` (`Description`) | yes | text, 50 | unique among rules `[INFER]`; referenced by exact name on CSV import | none |
| Inclusive/exclusive / `TaxInclusive` | yes | list | Inclusive, Exclusive | Exclusive [DOC:TAX] |
| Status / `IsActive` | yes | list | Active, Deprecated | Active [DOC:TAX] |
| Tax type / `Type` | yes (API) | list | chosen from the default tax types for the store's country; affects how the tax is classified in reports [DOC:TAX, API] | none |
| Liability account / `Account` | yes | account | an account of class LIABILITY [API]; a single account may serve every component or each component may use its own [DOC:TAX] | none |
| `TaxPercent` | derived | number | effective rate; `EffectivePercentExclusive`, `EffectivePercentInclusive`, `EffectivePercent` are derived columns [SPEC, API] | derived |
| `IsTaxForSale`, `IsTaxForPurchase` | no | bool | whether the rule applies to sales / purchases (filterable in the API; defaults not stated) [API] | both on `[ASSUME]` |
| Component: name / `Name` | yes | text | | none |
| Component: rate / `Percent` | yes | number | percent; 0 allowed for zero-rated rules `[INFER]` | none |
| Component: compound / `Compound` | no | bool | apply to the already-taxed subtotal [DOC:TAX] | off |
| Component: liability account / `AccountCode` | yes | account | | none |
| Component order / `ComponentOrder` | yes | integer | order matters only for compound components | position |

### Rules

- A rule needs at least one component (a default component is added automatically on create). [DOC:TAX]
- Rules cannot be deleted once created; set Status = Deprecated to retire (removes it from rule pickers). Whether a
  rule already used on documents can be deprecated is not stated; the sandbox allows it (history keeps the old
  rule). [DOC:TAX, INFER]
- CSV import for customers/suppliers/products accepts only an active rule by name. [SPEC]
- Each rule has a default inclusive/exclusive, but the document header "Tax inclusive" checkbox decides for that
  document and applies to all lines regardless of the line rule's own default. [DOC:TAX]
- **Which rule a sale line gets** (highest priority first): order line if manually changed > sales channel
  (integration) > product > document header > customer/supplier. A customer's rule fills the header when the sale is
  created; the header fills new lines; a product's sale (or purchase) tax rule then pre-fills that line; a blank
  product rule leaves the header rule in place. In the B2B portal the buyer cannot override a rule: the customer's or
  supplier's rule is used unless the product has its own. [DOC:TAX]
- Tax rule is mandatory on a sale/purchase header and on customers and suppliers; a customer's/supplier's rule
  pre-fills the header. [DOC:TAX]
- POS: each POS point has a default sales tax, default tax-free rate and an inclusive/exclusive switch; rules can be
  changed per sale item. [DOC:TAX]
- **Xero:** rules are created in Xero and download into Cin7; once synced, Cin7 may change inclusive/exclusive, a
  component's rate, and add/remove components, and those changes sync both ways. A rule created only in Cin7 never
  syncs out: Xero just shows the correct tax with an adjustment line for the difference. **QuickBooks Online:** some
  regions allow no custom rates, so QBO's own rates are imported; before connecting an existing account, edit or
  remove Cin7 rules that do not match them. [DOC:TAX, DOC:TAX2, DOC:XERO-SYNC]
- New accounts in AU / UK / US / NZ come with default rules loaded. [DOC:TAX]
- Permission: Settings - Financial - Taxation rules. [DOC:PERM]

### How a tax rule changes a sale line

Rounding follows the tenant "Tax calculation method": **Row total** (tax per line rounded to 2 dp, then summed) or
**Document total** (line tax kept to 4 dp, summed, then rounded to 2 dp). [DOC:ORG-SET]

**Example A, exclusive, single component 10%.** Line: 3 x 25.00 = 75.00. Tax = 75.00 x 10% = 7.50. Line total 82.50.

**Example B, inclusive, single component 10%.** Line total entered 110.00 (price includes tax). Net = 110.00 / 1.10 =
100.00. Tax = 10.00. (Formula: tax = gross - gross/(1+r).) [DOC:TAX for the inclusive meaning, INFER for the formula]

**Example C, multiple simple components.** Base 50.00; components 3% + 4% + 5%. Each applies to the base: 1.50 + 2.00
+ 2.50 = 6.00. Total 56.00. [DOC:TAX]

**Example D, compound.** Base 50.00; component 1 = 29% (not compound), component 2 = 10% compound. C1 = 14.50.
C2 applies to 50.00 + 14.50 = 64.50 -> 6.45. Total tax 20.95; total 70.95. [DOC:TAX]

**Example E, inclusive with a compound rule.** Gross 70.95 using Example D's rule. Net = 70.95 / (1.29 x 1.10) =
50.00; C1 = 14.50; C2 = 6.45. For simple multi-components the divisor is 1 + sum of rates (1.12 for 3+4+5).
[INFER]

**Example F, row vs document rounding.** Three lines each with net 3.33 at 10%: line tax 0.333. Row total: 0.33 x 3 =
0.99. Document total: 0.3330 x 3 = 0.9990 -> 1.00. [DOC:ORG-SET for the two methods; arithmetic is ours]

Posting: the tax of each component is posted to that component's liability account (so a two-component rule creates
two tax journal lines). [DOC:TAX, DOC:ACCT-TX]

---

## 5. Payment terms

Route `/TenantPaymentTerm`. Table `vTenantPaymentTermNew` (columns TermID, Name, Days, Method, DueNextMonth, IsActive,
IsDefault). API `/ref/paymentterm` (`Name` 50, `Duration`, `Method`, `IsActive`, `IsDefault`). [SPEC, API]

**Purpose.** Rules that turn an invoice date into a due date; chosen on customers, suppliers and (copied to) every
sale/purchase header.

### Fields

| Field | Required | Type | Allowed values | Default |
|---|---|---|---|---|
| Name / `Name` | yes | text, 50 | free text; customers/suppliers reference it by exact name | none |
| Method / `Method` | yes | list | UI: `Number of days`, `Day of next month`, `Last day of next month`, `Days since the end of the month`; QuickBooks-connected accounts also get `Date-driven`. API codes documented: `DAYS`, `MONTHDAY`, `LASTMONTHDAY` [DOC:REF, API] | Number of days |
| Days / `Duration` | yes (ignored by Last day of next month) | integer | >= 0; meaning depends on method (below) [API, DOC:REF] | none |
| Is default / `IsDefault` | no | bool | exactly one default term | the 30-day term |
| Is active / `IsActive` | no | bool | | on |
| `DueNextMonth` | QuickBooks date-driven only | integer (days) | the push-to-next-month threshold of the Date-driven method (resolved: it is not an unused column) [DOC:REF] | |

Grid: Description, Method, Duration (days), Is default, Is active. [SPEC]

### Rules

- The default term for new customers and suppliers is **30 days**; it can be changed in Default field values to any
  active term. [DOC:DEFVAL]
- Only one term is default; setting a new default clears the old. [INFER]
- Default terms appear on invoices automatically but can be changed by hand; terms can be made inactive (hidden from
  pickers). [DOC:REF]
- A term cannot be deleted while in use: not stated, so the sandbox deactivates instead `[INFER]`.
- Precedence on a document: a term typed on the document header > customer/supplier term > the default term.
  Integrations (Amazon, WooCommerce, Walmart, Shopify) use the customer's term, else the default term. The due date
  is generated from the term when the invoice date is entered. [DOC:DUE, DOC:AMAZON, DOC:SHOPIFY-DL]
- The due date drives "Overdue" status (authorised invoices not fully paid within the term, highlighted in red,
  "Overdue by" days) and automatic credit hold once the grace period (minimum 1 day, whole numbers) has passed.
  [DOC:SALES-LIST, DOC:CREDIT]
- Terms created or changed in Xero download into Cin7. [DOC:XERO-SYNC]
- Permission: Settings - Financial - Payment terms. [DOC:PERM]

### Due-date arithmetic

The help center states each method in words and gives worked examples only for the QuickBooks-only Date-driven
method. The formulas below follow its wording; the two spots it leaves open are marked.

| Method | Due date |
|---|---|
| Number of days | invoice date + Days [DOC:REF] |
| Day of next month | day number Days of the month after the invoice month; Days = 0 gives the last day of the invoice month [DOC:REF]. The 0 case equals "day 0 of next month", so the same arithmetic is used for N >= 1. If Days is larger than the month, the sandbox clamps to the month end `[ASSUME]` |
| Last day of next month | last calendar day of the month after the invoice month; Days ignored; not available to QuickBooks accounts [DOC:REF, API] |
| Days since the end of the month | last day of the invoice month + Days. With Days = 0 the due date is the last day of the invoice month for a created sale, and the first day of the next month for recurring sales/invoices [DOC:REF] |
| Date-driven (QuickBooks only) | day Days of the invoice month; if the invoice is issued fewer than DueNextMonth days before that day, the same day of the next month [DOC:REF] |

**Worked examples** (made-up dates, non-leap year):

| Term | Invoice date | Due date | Working |
|---|---|---|---|
| Number of days, 30 | 15 Mar | 14 Apr | 15 Mar + 30 d (16 d left in Mar, then 14 into Apr) |
| Number of days, 0 | 15 Mar | 15 Mar | due on receipt |
| Day of next month, 10 | 20 Jan | 10 Feb | 10th of the month after January |
| Day of next month, 0 | 20 Jan | 31 Jan | documented: 0 = last day of the current month |
| Day of next month, 31 | 20 Jan | 28 Feb | February has no 31st, clamp to month end `[ASSUME]` |
| Day of next month, 15 | 28 Dec | 15 Jan (next year) | month rolls over the year |
| Last day of next month | 15 Jan | 28 Feb | |
| Last day of next month | 31 Jan | 28 Feb | |
| Days since end of month, 30 ("30 days EOM") | 12 Mar | 30 Apr | EOM 31 Mar + 30 d |
| Days since end of month, 30 | 5 Feb | 30 Mar | EOM 28 Feb + 30 d = 30 Mar |
| Days since end of month, 15 | 5 Jan | 15 Feb | EOM 31 Jan + 15 d |
| Days since end of month, 0 (created sale) | 12 Mar | 31 Mar | end of month |
| Days since end of month, 0 (recurring sale) | 12 Mar | 1 Apr | first day of next month |
| Date-driven, Days 20, DueNextMonth 10 (QuickBooks) | 5 Jul 2019 | 20 Jul 2019 | 15 days before the 20th, at least 10 |
| Date-driven, Days 20, DueNextMonth 10 (QuickBooks) | 15 Jul 2019 | 20 Aug 2019 | 5 days before the 20th, fewer than 10 |

---

## 6. Accounting dimensions

Route `/AccountingDimensions`. Tables `vAccountingDimension` (Name1..10, IsActive1..10, ListValues1..10),
`vAccountingDimensionAttribute` (AttributeID, Name, Type, ListValues, IsActive), `vAccountingDimensionsChartOfAccount`.
Master toggle `IsAccountingDimensionsEnabled` on the tenant. [SPEC]

**Purpose.** Tag financial transactions with up to 10 user-defined analysis dimensions (customer group, business group,
cost centre, product region...) in addition to the built-in master-data sources: customer, supplier, product, company
contact, expense item and (Advanced Manufacturing) production resource. [DOC:DIM]

### Fields (per dimension)

| Field | Required | Type | Rules | Default |
|---|---|---|---|---|
| Name / `Name` | yes | text | user-defined; max 10 dimensions | none |
| Type / `Type` | yes | list | `List` (values separated by commas or semicolons), `Text` (free text, up to 256 characters), `Checkbox` (true/false) (resolved) [DOC:DIM] | List |
| List values / `ListValues` | for List | delimited text | the allowed values | none |
| Is active / `IsActive` | no | bool | inactive dimensions are not shown | on |
| Per-account tick | no | bool | set in the account's Accounting dimensions tab; some master data is ticked automatically for certain accounts | none ticked |

### Rules

- Feature is **off by default**, switched on in General settings > Financial settings. It cannot be used on an account
  connected to Xero or QuickBooks Online. When on, dimensions are applied to new transactions automatically; earlier
  transactions are not updated but can be edited by hand while their period is open. [DOC:DIM]
- A dimension applies to a posting only if the *posting's account* has that dimension ticked. [DOC:DIM]
- **Reference data** (the default values held on customers, suppliers, products, company contacts, expense items,
  production resources) pre-fills each transaction. The mode setting decides what can be changed: *Cannot overwrite*
  = values come from the reference data and only blank dimensions can be edited on the transaction; *Can overwrite*
  = values come from the task's own prefill table and every dimension is editable, and the transaction-level value
  always wins. [DOC:DIM]
- When reference data conflicts (cannot-overwrite mode), priority is by transaction: sale orders customer over product;
  purchase orders supplier over product; production orders product over production resource; expense claims company
  contact over expense item. [DOC:DIM]
- Covered transactions: sales, purchases, stock transfers, stocktakes, stock adjustments, inventory write-offs,
  assembly/disassembly, production orders, expense claims, money operations and manual journals. Each shows a
  Financials tab with Edit dimensions, Transactions and Final values; the Accounting Dimensions Summary report
  totals the final values. [DOC:DIM]
- **Deleting:** a dimension that has been used cannot be deleted. Edits (names, values) apply to new tasks only and
  reference data keeps the old values until updated by hand. (resolved: not just deactivated) [DOC:DIM]
- Permissions: Settings - Your company - General settings (enable), Settings - Financial - Chart of accounts and
  mapping (assign to accounts), Financials - Accounting dimensions - Settings (list, reference data), Financials -
  Accounting dimensions - Transactions (edit on a transaction), Reports - Financials (summary report). [DOC:DIM, DOC:PERM]

---

## 7. Opening balances

Route `/OpeningBalances` (tabs: Opening balances, Outstanding purchases, Outstanding sales, Stock on hand, Fixed
assets, Activity log). Tables `OpeningBalanceLine` (Code, Name, Currency, Debit, Credit, SystemAccount, AccountType,
AccountClass, InventoryAsset), `vOpeningBalancePurchases`, `vOpeningBalanceSales`, `vOpeningBalanceStockOnHand`,
`vOpeningBalanceFixedAsset`. [SPEC]

**Purpose.** One-time conversion: load the trial balance, open payables/receivables, stock and fixed assets as of the
day before Cin7 starts being used.

### Fields

| Tab | Field | Required | Type / rules |
|---|---|---|---|
| Opening balances | Conversion month / year (`OpeningBalancesMonth`, `OpeningBalancesYear`) | yes | the day you stop the old system and start Cin7; balances are as of the day before (start October -> balances at 30 Sept) [DOC:OPEN] |
| | Per account: Debit, Credit | no | numbers; the "Inventory/Fixed asset" tick marks which asset accounts hold inventory or fixed assets [DOC:OPEN] |
| Outstanding purchases | Supplier, document number, date, due date, amount, currency | yes | open supplier invoices; "Add a supplier" dialog: name (required), payment term, tax rule, discount, currency, account payable, default carrier, tax number, comments [SPEC] |
| Outstanding sales | Customer, ... | yes | same fields for customers plus sale account, sales representative, default location, sale price tier [SPEC] |
| Stock on hand | Product code, location, quantity, average cost, received date (and batch/serial/expiry where costed so) | yes | received date is the date the stock value enters the inventory account; when closing the old system on one day, enter the following day [DOC:SOH] |
| Fixed assets | Name/product, serial number, location, purchase date, purchase cost, salvage value, accumulated depreciation, depreciation start date, depreciation method, averaging method, rate (%) or effective life (yrs), asset / accumulated depreciation / depreciation expense accounts | yes | [SPEC] |

### Rules

- Prerequisites: chart of accounts, account mapping and bank accounts configured; permission "Financial - Opening
  balances" (full access to edit balances and the conversion date). [DOC:OPEN, DOC:PERM]
- Transactions dated before the conversion date are disregarded; reports can still be generated before it. [DOC:OPEN]
- **The conversion date locks** once any opening-balance data is entered. To change it, void the opening-balance tasks,
  sales/purchases and manual journals and re-enter the balances. (new) [DOC:OPEN]
- Customer credits carried over cannot be loaded as opening balances; create standalone credit notes. [DOC:OPEN]
- **Balance check:** the screen shows "Balance out by"; it must be 0 before using Cin7. Receivables and payables must
  equal the outstanding sales and purchases entered on their tabs; the inventory account debit must equal the stock
  on hand value; fixed-asset accounts must equal the registered assets. Whether Save is blocked while out of balance
  is not stated. (resolved: debits equal credits is a requirement, enforcement unknown) [DOC:OPEN]
- Bank account balances are entered against the statement balance; unpresented items go to an Unpresented funds
  account (current asset, no system account, accepts payments). [DOC:OPEN]
- Outstanding items land as authorised documents using the supplier/customer's AP/AR account, in the party's currency
  `[INFER]`.
- Stock on hand is a one-time import (export the stock-on-hand template from the product list, fill quantity, average
  cost, location and received date, import). Imported products post to the default inventory account unless the
  product has its own; a second upload creates new instances; later changes use stock adjustment or stocktake. After
  import, a stock-on-hand entry can be opened to edit unit cost or account. Layers feed FIFO/FEFO costing and the
  Inventory Control balance. [DOC:OPEN, DOC:SOH, INFER for the layering]
- Fixed assets are added from Financials > Fixed assets and use the same depreciation inputs as fixed-asset types
  (section 8). [DOC:OPEN]

### Worked example

Conversion month October; balances at 30 Sept. Inventory control account debit 12,400.00 (tick Inventory), stock on
hand loaded with 400 units x 31.00 = 12,400.00 received date 1 Oct. The ledger Inventory Control balance and the
stock valuation must agree at 12,400.00 ("Balance out by" 0); any difference is a sign the stock tab or the trial
balance is wrong.

---

## 8. Fixed asset types

Route `/FixedAssetType`. Table `vFixedAssetType`. API `/ref/fixedassettype`. [SPEC, API]

**Purpose.** Template of depreciation and accounts for a group of fixed assets; a fixed asset takes its settings from
its type (and can override them individually under Financials > Fixed assets). Types can also be created from the
product screen (the + next to Fixed asset type). [DOC:FA]

### Fields

| Field | Required | Type | Allowed | Default |
|---|---|---|---|---|
| Name | yes | text | | none |
| Depreciation method / `DepreciationMethod` | yes | list | No Depreciation (ND), Straight Line (SL), Declining Balance (DL), Declining Balance 150% (DB150), Declining Balance 200% (DB200), Sum of the Years' Digits (SYD), Full Depreciation at Purchase (FDP) [DOC:FA-DEP] | `?` |
| Averaging method / `AveragingMethod` | yes | list | the help center names the field but not its options | `?` |
| Rate (%) **or** Effective life (yrs) / `Rate`, `EffectiveLife` | one of the two | number | radio picks which one is stored; the other is null [SPEC, API] | |
| Asset account / `AssetAccountCode` | yes | account | | none |
| Accumulated depreciation account | yes | account | | none |
| Depreciation expense account | yes | account | | none |

### Rules

- Method "No Depreciation" and "Full Depreciation at Purchase" need no rate/life `[INFER]`.
- Product type "Fixed asset" on a product requires a fixed asset type, and a fixed asset location (a separate list from
  stock locations, even when the physical place is the same). Fixed assets get quantity through a purchase receipt, a
  stock adjustment (one at a time) or a stocktake, then must be **registered** before depreciation runs. [SPEC, DOC:FA]
- Salvage value is subtracted from cost to get the depreciable amount; depreciation is proportional to Business Use %
  (0% means none posted). Only registered assets depreciate. [DOC:FA, DOC:FA-DEP]
- Depreciation is run from Financials > Depreciation: start date is the end of the last run, the user picks an end
  date, only assets registered for that period are included, and a mistaken run is reversed with Rollback. It must be
  run before a financial period can be closed. [DOC:FA, DOC:PERIOD]
- Disposal is done through an inventory write-off against the fixed asset location and an expense account; the cost is
  prefilled with cost less accumulated depreciation; the asset becomes Disposed with a disposal date. The financial
  setting "Reverse current year depreciation" governs depreciation already taken in the year of disposal. [DOC:FA, DOC:FIN-SET]
- With Xero as the accounting system, fixed assets are not available in Cin7. Permission: Financials - Fixed assets
  (read-only can view types and assets). [DOC:FA, DOC:FIN-INTRO]
- Deleting a type that has assets: not documented; deactivate instead. [ASSUME]

### Worked example (straight line, rate)

Cost 12,000.00, salvage 2,000.00, rate 20% (5-year life), straight line, full-month averaging. Depreciable 10,000.00;
annual 2,000.00 = 166.67 per month. Month 1 posts Dr Depreciation expense 166.67, Cr Accumulated depreciation
166.67. `[INFER]` for the formula; the docs list the methods but not the formulas.

---

## 9. Expense items

Route `/ExpenseItems`. Table `vExpenseItem` (ExpenseItemID, Description, AccountCode). [SPEC]

**Purpose.** Pre-defined named costs that map to an expense account and can be picked on expense-claim receipts;
also an accounting-dimension source. (corrected: the earlier text also said purchases and landed costs; the docs
mention only expense claims.) [DOC:EXP, DOC:DIM]

| Field | Required | Type | Rules |
|---|---|---|---|
| Description | yes | text | `?` unique |
| Account / `AccountCode` | yes | account | the account the item is charged to; expense class `[INFER]` |
| Accounting dimensions | no | per-dimension values | shown only when dimensions are enabled [SPEC, DOC:DIM] |

Rules: items are chosen on a receipt line, and new items can also be typed on the receipt; with Xero the whole expense
claim function is not available in Cin7; permission "Default expense items" (under Financials) lets a user view
and set them. An item used in a document is deactivated, not deleted `[INFER]`.

---

## 10. Currencies and exchange rates

There is **no currency or exchange-rate reference book in module 14** (no page, route or public endpoint). Currency
is set in the base-currency setting, on customers/suppliers/bank accounts, and the rate is held on each document.

### Rules

- **Base currency** is chosen in Organization settings and can be changed only until the first transaction exists.
  [DOC:MULTI]
- **Customer / supplier currency**: one currency per record (bill in several currencies with one profile each); the
  default comes from Default field values; the bank-account currency is fixed at creation. [DOC:MULTI, DOC:DEFVAL, SPEC]
- **Document conversion.** When a sale or purchase has a currency different from base, a conversion field appears,
  filled from the Open Exchange Rates feed and overwritable by hand. Line prices are in the document currency; the
  total shows in both currencies. With Xero/QuickBooks the rate is sent to the accounting system. [DOC:MULTI]
- **No fixed rate or rate table.** A community request for fixed/periodic rates implies it is not built in. [DOC:MULTI-COMM]
- **Prices.** Static price tiers are not converted: a tier price of 200 shows as 200 in whatever currency the customer
  uses. Calculated tiers are shown in base currency and recalculated at the latest rate. Two sentences in the same
  articles conflict on order: "markup and append values are added after the currency conversion" and "markup pricing
  is specified in base currency, then converted". See Unclear. [DOC:PRICE, DOC:MULTI]
- **Realized gain/loss.** Settling at a rate different from the document rate posts the difference to the Realized
  Currency Gains account (required for multiple currencies; shown in income). Customer payment reports carry an FX
  Gain/Loss column; the formula for "due" in those reports is not documented. [DOC:MULTI, DOC:PERIOD, DOC:COA, DOC:CUSTPAY]
- **Unrealized gain/loss.** Optional (financial setting; mandatory for organisations in some countries, e.g. China).
  Calculated when a financial period is closed: all currencies used in the period and their rates are listed, the
  rate and final value can be edited, and closing creates one manual journal per currency, recorded in equity.
  Needs Unrealized Currency Gains and Current Year Profits mapped. [DOC:PERIOD, DOC:FIN-SET]
- **Xero sync:** realized and unrealized gains must map to the Xero system accounts of those names. [DOC:XERO-CONNECT]

### Worked example (convention assumed: rate = units of document currency per 1 unit of base)

Base USD. Customer in EUR, rate 0.92 EUR per USD. Sale line 100.00 EUR. Base equivalent = 100.00 / 0.92 = 108.70 USD.
Invoice posted at 0.92. Customer pays 100.00 EUR when rate is 0.90: base received = 100.00 / 0.90 = 111.11 USD.
Realized gain = 111.11 - 108.70 = 2.41 USD to Realized Currency Gains. [INFER; rate direction is [ASSUME]]

Static tier: tier price 50.00 stored as 50.00 and shown as 50.00 EUR on the EUR customer's sale. Calculated tier: base
average cost 40.00 USD, markup 50% = 60.00 USD; shown to the EUR customer as 60.00 x 0.92 = 55.20 EUR (convert
after computing) `[INFER]`.

---

## 11. Locations

Routes `/TenantLocation` (list), `/TenantLocationEdit` (edit). Tables `vTenantLocation`, `vLogisticsPath`. API
`/ref/location`. [SPEC, API]

**Purpose.** Physical or logical places that hold stock. Every stock figure, document and reorder is per location.

### Fields

| Field (UI / API) | Required | Type | Allowed | Default |
|---|---|---|---|---|
| Name / `Name` (`Description`) | yes | text, 256 | unique `[INFER]` | none |
| Type | yes | list | Warehouse/retail, Fixed assets, Shop floor, Co-manufacturing [DOC:LOC]. API flags: `FixedAssetsLocation`, `IsShopfloor`, `IsCoMan`, `IsStaging` (all false = warehouse/retail) [API, SPEC] | Warehouse/retail |
| Status | yes | radio | Active, Deprecated (`IsDeprecated`) | Active |
| Set as default / `IsDefault` | no | bool | only one default; auto-set when there is only one location [DOC:LOC] | |
| Allow to reorder stock level / `AllowReorder` | no | bool | enables or disables Low-stock reorder for this location [DOC:LOC] | off `[ASSUME]` |
| Use directed pick | no | bool | enables bin groups for WMS picking [DOC:LOC] | off |
| Use directed receive/put away | no | bool | enables put-away rules and the bin suggestion priority [DOC:LOC, DOC:DPU] | off |
| Bin suggestion priority | no | list | emptiest bin first, fullest bin first, alphabetical ascending, alphabetical descending (resolved) [DOC:DPU] | `?` |
| Address: Line 1, Line 2, City/suburb, State/province, ZIP/postcode, Country / `AddressLine1`, ... | no | text / country | | blank |
| Description | no | text | | blank |
| Supply rules, transfer planning, delivery scheduling | no | | sections 13-14; delivery calendar is an Advanced WMS feature [DOC:LOC] | |
| Pick zones / `PickZones` | no | comma-delimited list, 512 | Advanced WMS only (section 13) | null |
| `Bins` | derived | list | section 12 | [] |

### Rules

- **Type behaviour.** [DOC:LOC, DOC:COMAN, DOC:LP, SPEC]
  - *Warehouse/retail*: normal selling, receiving, storing; counts toward the subscription's location limit `[INFER]`.
  - *Fixed assets*: only for registering and managing fixed assets (kept as its own tab/list); not counted in the
    location limit; no bins; cannot hold regular stock or be a production location `[SPEC]`.
  - *Shop floor*: a production location (needs the Advanced Manufacturing add-on; at least one needed to use that
    module). Bins at a shop floor define where components are taken before and after operations. Renaming a shop floor
    updates every document that uses it; one used on any order cannot be deleted.
  - *Co-manufacturing*: an external, restricted location. No bins; cannot be the default location for products,
    families, customers or suppliers; supply rules limited to transfer and purchase; can be a demand location in
    transfer planning but never a replenishment source; the purchase-suggestion supplier comes from its work centre.
- **Default location** pre-fills new purchases and sales; with a single location it is set automatically. A
  deprecated location cannot stay the default `[INFER]`.
- **Deprecation / deletion.** A location used in any transaction can only be deprecated (ticking Deprecated makes it
  inactive and removes it as a transaction option). Deletion requires all quantities attached to it (on hand,
  available, on order, in transit, allocated) to be zero and no use in transactions; voiding the transactions that
  used it makes deletion possible. `DELETE /ref/location?ID=` returns `Success`. [DOC:LOC, DOC:BINS, API]
- **Location permissions** per user restrict picking, receiving, inventory actions (stocktake, adjustment, write-off)
  and production actions (production, assembly, disassembly) to allowed locations, in the web app, WMS and MES (POS
  has its own); documents made by others stay visible. "Settings - Stock - Locations" edits locations. [DOC:LOC]
- The RMA return location may be any location except fixed-asset, co-manufacturing and deprecated ones. [DOC:RET-SET]
- Stock is added to a location once at set-up with the stock-on-hand import; after that use adjustments, stocktakes
  and transfers. [DOC:LOC, DOC:SOH]
- Tenant setting "Available quantity is limited to" decides whether availability on a sale counts only the sale's
  location or all locations. [SPEC (settings.md G-53)]

### Effects on stock behaviour

| Setting | Effect |
|---|---|
| Type = Warehouse/retail | Stock counted in Available quantity and reorder |
| Type = Fixed assets | Excluded from stock availability; fixed-asset register only |
| Type = Shop floor | Production orders consume/produce here; MRP treats it as the production demand location |
| Type = Co-manufacturing | Components are sent here (value held in the In Transit account until received, then Work in Progress) and finished goods come back via a co-man purchase; no stock reorder |
| Allow reorder off | Location skipped by Low stock reorder in "each location" mode |
| Use directed receive/put away | A Stock received tab shows "Apply directed put away", which suggests bins by rule |
| Use directed pick | Picking in the WMS app can be limited to chosen bin groups |
| Auto-assemble (tenant setting "On order authorization auto-assemble" + product flag) | There is **no location-level auto-assemble field** in the map. Assembly on sale authorisation is always limited to the sale's location and uses components stocked there; if components are missing there, nothing is assembled. [SPEC (settings.md G-53, G-54)] |

---

## 12. Bins

Within `/TenantLocationEdit` (grid `divGridBins`, model `vBinSimple`: LocationID, Description, BinGroupID). API
`Bins` on `/ref/location`. [SPEC, API]

**Purpose.** Positions inside a location (shelf, rack, pallet slot). Stock can be recorded per bin. The smallest unit
of warehouse space; on a shop floor, bins are where production components are staged. [DOC:BINS, DOC:LP]

### Fields

| Field | Required | Type | Rules |
|---|---|---|---|
| Location | yes | location | bins belong to one location |
| Bin name / `Description` | yes | text, 256 | Shown as `Location:Bin` where the screen combines them. Uniqueness within a location is not stated; the sandbox enforces it `[INFER]` |
| Bin group | no | group | a bin can be in at most one group [DOC:DPICK] |
| Status | no | Active / Deprecated | |
| Staging | no | flag | a temporary holding bin for two-stage transfers (from location, staging bin, to location); excluded from directed put away [DOC:BINS, DOC:DPU] |

### Rules

- Bins are added on the location's Bins tab with "+"; the location must be saved first (screen text: "Location is not
  saved. Please click save before adding bins"). Bins cannot be added to Fixed-asset or Co-manufacturing locations.
  [SPEC, DOC:BINS]
- Import/export: bins list as CSV from the Bins tab; start from the Bins Template CSV. [DOC:BINS]
- **Deletion.** A bin never used in a transaction can be deleted. Once used it can only be deprecated; a deprecated bin
  is inactive and no longer an option in WMS. The article repeats the location rule (zero quantities); how a
  deprecated bin that still holds stock behaves is not stated. [DOC:BINS]
- Product search / picks use bins as a stock key: stock is by (product, location, bin, batch/serial). [INFER]
- **Pick order.** In the WMS app the pick-list order is generated from bin names in alphanumeric order (numbers before
  letters: 1B, 2B, 3B before B1, B2, B3). (corrected: this is documented, not just a community report.) [DOC:BINS]
- Shop-floor bins: each work centre can have a consumption bin and an output bin (or use the same, or neither).
  [DOC:LP]
- Barcodes for bin locations exist as a separate feature (not a reference-book field). [DOC:BINS]

---

## 13. Put away rules, bin groups and pick zones

Within `/TenantLocationEdit`: grids `divGridPutAwayRules` (`TenantLocationPutAwayRule`), `divGridBinGroups`
(`BinGroup`: ID, Name, LocationID). [SPEC]

### Put away rule fields

Name; Active; Bin (target, one or more; several rules may point at the same bin); capacity Min/Max; "Allow batch split";
Min/Max length, width, height, weight; product selector (All products, or Families / Tags / Categories / Brands, or
specific Products). [SPEC, DOC:DPU]

### Rules

- Needs "Use directed receive/put away" on the location; applies to products of type Stock and Fixed assets; applied
  on the purchase Stock received tab with "Apply directed put away". [DOC:DPU]
- A product must satisfy **every** parameter of a rule (capacity, dimensions, weight, product filter) to be sent to
  that rule's bin. Staging and deprecated bins are excluded. [DOC:DPU]
- **Capacity counts items, not volume.** One unit of any product uses one unit of capacity; available capacity = bin
  capacity minus on-hand quantity. A blank maximum means unlimited. [DOC:DPU]
- **Bin choice** follows the location's bin suggestion priority (emptiest first, fullest first, alphabetical asc/desc):
  the first bin in that order that passes the rules is suggested. [DOC:DPU]
- **Filters:** values inside one group (e.g. several brands) are OR; the groups (family, tag, category, brand,
  product) combine with AND. [DOC:DPU]
- If several rules match, apply in this order: **Family, Tag, Category, Brand**; rules for specific product groups
  beat rules for all products. [DOC:DPU]
- **Batch splitting** applies only to batch-costed products (FIFO batch, FEFO batch, Special batch), not plain FIFO or
  serial. On: a received batch may be spread across bins in suggestion-priority order. Off: the whole batch goes to the
  highest-priority bin it fits entirely; if none fits, the stock is not put away to a bin. [DOC:DPU]
- Dimension and weight units come from Product and measurement settings (prompted if unset); product dimensions are
  held on the product. [DOC:DPU]

### Bin groups

- Directed pick must be on for the location. A group contains several bins; a bin is in at most one group. In the WMS
  app Menu > Working area, the user multi-selects groups (All by default); pick lists, stock-availability checks and
  FIFO/FEFO batch or serial recommendations are then limited to those groups, and kitting picks fail with an error if
  a component is not in the chosen groups. [DOC:DPICK]

### Pick zones

- Advanced WMS add-on only. Created on the location's Pick zones tab (name, save; delete icon removes one). [DOC:PZ]
- Assigned at **product level** from the zones of the product's Default Location; a product can belong to several
  zones; bulk-assign by exporting the inventory list, filling the Pick zones column and re-importing. [DOC:PZ]
- WMS pickers choose Location and Pick zone while picking (Menu > Working area). Pick zones do not print on picking
  slips (bin name and location do). [DOC:PZ]
- Another article says a pick zone can be set per location in the reorder levels (see Unclear).

### Worked example (put away priority)

Product P is in family F1, category C1, brand B1. Rule R1 (target bin A1) is for family F1; rule R2 (bin B2) is for
category C1; R3 (bin C3) for all products. R1, R2, R3 all pass capacity. Winner: R1 (Family beats Category beats
All). If A1 is full (above Max capacity), R1 fails and R2 is used. [DOC:DPU, INFER for the full-bin fallback]

---

## 14. Supply rules and transfer planning

Within `/TenantLocationEdit` (grid `divGridRules`, model `TenantLocationSupplyRule`). [SPEC]

**Purpose.** Tell MRP and reorder suggestions *how to fulfil* demand at this location: buy, transfer from another
location, or produce. MRP is an optional add-on. Orders are never created automatically from suggestions. [DOC:SUPPLY]

### Fields

Name; Active; product selector (All / families / tags / categories / brands / products); action = Purchase | Transfer
| Produce; "from" (source location, for Transfer); "take" = All available | Until minimum before reorder | Until stock
level (minimum before reorder + reorder quantity); "to fulfill" = All required | Partial; "if > N % production capacity
is available" (Produce); supplier choice = Lowest price | Lowest lead time | Latest supplier (Purchase); plus a "final
action" (transfer, production, purchase or nothing) when no rule can run. Transfer planning: Planning method (Transfer
at intervals | Transfer on fixed days), Demand location(s), Interval (days), Start date, Fixed days (Mon-Sun). Delivery
scheduling: deliveries per day, time interval (minutes), working week start, weekend days, working-hours grid with
breaks. [SPEC, DOC:SUPPLY]

### Rules

- **Rules are tried in order.** If one cannot be executed (stock short, capacity short, Transfer rule with "All
  required" and not enough at the source), the next rule is triggered; "Partial" creates a partial suggestion and then
  moves on. If every rule fails, the final action fires: Transfer creates a suggestion regardless of source stock (and
  so a demand there), Produce regardless of capacity, Purchase from the supplier, or Nothing (demand stays). (new)
  [DOC:SUPPLY]
- When multiple supply rules match a product, priority is Family > Tag > Category > Brand; rules for specific product
  groups beat All-products rules. Filter groups combine as in put away (OR inside, AND across). Two rules cannot have
  identical product parameters; a rule can be cloned. [DOC:SUPPLY]
- Supply rules only produce **suggestions**; a user creates and authorises the orders. [DOC:SUPPLY]
- Produce rules only apply to products with a production or assembly BOM, always add a transfer suggestion for the
  finished goods back to the demand location, and ignore the capacity % for assembly. Purchase rules need the
  product's supplier details (price, lead time). [DOC:SUPPLY]
- Location-specific "minimum before reorder" is recommended for MRP (Purchase process customization: specified for each
  location). [DOC:SUPPLY]
- **Transfer planning, intervals:** the first suggestion lands on the start date, the next every interval days after;
  every day counts as a working day. **Fixed days:** suggestions go on the ticked weekdays; the documented example puts
  a Monday transfer ahead of a Tuesday demand, so the chosen date is the latest ticked weekday not after the demand
  date (corrected: earlier text said on or after). [DOC:SUPPLY]
- Permission: Settings - Stock - Locations. [DOC:SUPPLY]

---

## 15. Logistics paths

Grid `TenantLocation_Index_LogisticsPaths`, model `vLogisticsPath` (PathID). [SPEC]

**Purpose.** Reflects the physical movement of components and finished goods to and from a shop floor; decides lead
times when scheduling, logs stock movements, and creates purchase and transfer orders. [DOC:LP]

Fields (resolved): **Components** location (where components are picked if the shop floor lacks them), **Shop floor**
(production location) and **Demand** location (where finished goods are sold). The same location may fill several of the
fields, but a path always involves a shop-floor location.

Rules: a shop floor and a path must exist before production orders; a components or demand location can link to many
shop floors, but each shop floor links to only one warehouse; a path cannot be deleted or changed once used on a
production or sales order. [DOC:LP]

---

## 16. Units of measure

Route `/TenantUnitOfMeasure`. Table `vTenantUnitOfMeasure` (UnitOfMeasureID, Unit). API `/ref/unit`. [SPEC, API]

**Purpose.** The unit a product is stocked, bought and sold in (each, kg, box).

| Field | Required | Type | Rules | Default |
|---|---|---|---|---|
| Name / `Unit` | yes | text, 50 | list entries are free names, or created on the fly from a product; uniqueness `[INFER]` | none |

### Rules

- Not the same as the default weight and dimension units in Product and measurement settings. [DOC:REF]
- Default product UOM comes from Default field values (not offered when the default product type is Service). [DOC:DEFVAL]
- **Additional units of measure** on a product (e.g. a pack of 6) are separate products, each with its own SKU, created
  from the smallest unit (the base). They must share the base's costing method. The ratio ("Number of ...") may be an
  integer or decimal. The system writes a BOM on the additional product with auto-assembly and auto-disassembly
  enabled: **auto-disassembly triggers on purchase stock receipt, auto-assembly when a sale is authorised.** The base
  product may keep an ordinary BOM, but not an auto-assembly/disassembly one, and a product that already has additional
  units cannot take an auto-assembly BOM. Availability shows singles on hand and every pack size as available. Base
  stock allocated elsewhere reduces what is available. Imported via a CSV with Create/Update/Delete actions. [DOC:AUOM]
- Deleting a unit in use on a product is not described; the sandbox blocks it `[INFER]`; no deprecate state exists in
  the map.

### Worked example

Product "Each" (SKU X1) has additional unit "Box of 6" (SKU X6). Sale of 2 x X6 authorised with 5 X1 on hand: auto-
assembly needs 12 X1, short by 7 -> not assembled (nothing partially assembled) -> backorder/split prompt. [DOC:AUOM
for the trigger; shortage behaviour is INFER (+settings.md G-54)]

---

## 17. Product categories

Route `/TenantInventoryCategory`. Table `vTenantInventoryCategory` (Category). API `/ref/category`. [SPEC, API]

| Field | Required | Type | Rules |
|---|---|---|---|
| Category | yes | text, 50 | unique `[INFER]` |

Rules: a product belongs to **one** category (use tags for more) and **category is mandatory** when creating a product
or service (resolved); new categories can also be created from the product form; the default category comes from
Default field values. Categories select products for supply rules, put-away rules, return policies, discounts/deals
and reports. Permission: Settings - Stock - Product categories. A category in use cannot be deleted `[INFER]`. No
documented hierarchy or deprecate flag. [DOC:SEG, DOC:REF, API]

---

## 18. Brands

Route `/TenantBrand`. Table `vTenantBrand` (Brand). API `/ref/brand`. [SPEC, API]

| Field | Required | Type | Rules |
|---|---|---|---|
| Brand | yes | text, 50 | unique `[INFER]` |

Rules: one brand per product, and brand is **optional** on a product (resolved); new brands can be created from the
product form; used the same way as categories in rules, deals and reports; permission Settings - Stock - Brands; the API
`POST` body is not described in the map (`_keys` empty), only `Name` is returned. [DOC:SEG, DOC:REF, API]

---

## 19. Attribute sets

Route `/TenantAttributeSet`. Table `vTenantAttributeSet` (Column1..10). API `/ref/attributeset`. [SPEC, API]

**Purpose.** A named template of up to 10 additional fields shown on products, customers, suppliers and, through the
default-set settings, purchases, sales and production orders/operations/outputs.

### Fields

| Field | Required | Type | Allowed | Default |
|---|---|---|---|---|
| Set name / `Name` | yes | text, 50 | unique `[INFER]` | none |
| Attribute N name (N = 1..10) / `AttributeNName` | per used attribute | text, 50 | the API requires names 1-10 on create | blank |
| Attribute N type / `AttributeNType` | yes | list | Not used, List, Checkbox, Text, Numeric, Date in the UI (the API reference lists only List, Checkbox, Text and Not used) [DOC:ATTR, API] | Not used |
| Attribute N values / `AttributeNValues` | for List | delimited text | list values separated by commas or semicolons | blank |

Type limits: Text up to 256 characters; Numeric up to 4 decimal places, digits only; Date uses the organisation's date
format. [DOC:ATTR]

### Rules

- Max 10 attributes per set; only one set per product, customer or supplier. [DOC:ATTR]
- CSV import can assign a set (and values) to products, suppliers and customers only if the set already exists; with
  the set field blank, the values are ignored; List values must match, checkbox values must be True/False; a set cannot
  be assigned to the purchase/sale/production process by CSV. [DOC:ATTR]
- Default sets for the purchase, sale and production process (and per production order, operation and output) are
  chosen in the process customization settings; the sale/purchase default pre-fills the Logs & attributes tab.
  [DOC:ATTR]
- "Copy customer's (supplier's) attribute values to the sale (purchase)" is off by default; when on, the source and
  target sets must have identical field names, types and values or an error is shown; copied values overwrite existing
  ones, and changing the customer later overwrites again. [DOC:ATTR]
- Changing an attribute's type after values are stored: not documented. [ASSUME: blocked once values exist]
- Permission: Settings - Other items - Additional attributes. [DOC:PERM]

---

## 20. Discounts and deals

Routes `/DiscountListNew` (grid columns: Discount name, Discount type, Status; lines: Up to, Type of discount,
Amount) and `/DealList` (Deal name, Date from, Date to, Active). Tables `vDiscount`, `vDiscountLine`, `vDeal`. [SPEC]

**Purpose.** Reusable price adjustments applied to a product, a customer group or a single customer (discounts), and
time-boxed cart-level promotions (deals).

### Discount types (corrected: the earlier list was approximate)

| Type | Effect |
|---|---|
| Discount amount | price reduced by a fixed amount |
| % discount | price reduced by a percentage |
| Markup amount | price raised by a fixed amount |
| % markup | price raised by a percentage; a negative discount needs the discount rule set to "Updates the sale price" |
| Price override | the value is the new unit price (1 unit 15, 2 units 30) |
| Flat amount | the value is the new price for the product total (1, 2 or 100 units all 15) |
| Quantity-based | lines of "Up to" quantity, a simple type and a value; the rate for the order's total quantity applies to the combined value |
| Free shipping | order total threshold; deal level only; B2B and Cin7 sales only, not eCommerce-channel sales |

[DOC:DISC]

### Rules

- **Product-discount priority:** the discount set for the individual customer on the product beats the customer-group
  (tag) discount, which beats the product-level discount. **Only one product discount applies at a time.** [DOC:DISC]
- **Customer discount** (a % on the customer record) applies to every product that customer buys. Setting "Apply
  customer discount after other discounts": **On** = applied after the top-priority product discount (they stack);
  **Off** = the product discount and the customer discount are each applied to the original price and the lower
  result is used. (corrected: "customer level wins" was wrong.) [DOC:DISC]
- **Order-line discount:** percentage only, no negative values, entered at quote or order, applied after all other
  discounts (with "Updates discount %", added to the total %). [DOC:DISC]
- **Auto-apply:** when "Automatically apply discounts" is on, customer and product discounts are added when a quote or
  order is authorised and cannot be skipped; when off, the user must press Apply discounts or the order is authorised
  with none. "Discount rule" shows discounts as a reduced price or as a total discount %. [DOC:DISC]
- Custom per-customer prices beat tiers; a sale's price tier beats the customer's tier. [DOC:PRICE]
- **Deals** (Settings > Reference books > Stock > Product deals): cart-level, have effective-from/to dates, an Active
  flag, a customer type (all, B2B, POS, selected customers or tagged customers) and optional coupons (single-use or
  multi-use, applied after the order is saved). Simple deals pick brands, categories, tags or products; quantity-based
  deals define Buy and Get criteria (units or order total) and whether the percentage applies to the whole order or
  only the qualifying items. They need a product discount template to exist first; cart-level (non-quantity) deals use
  simple types only. Discounts do not stack: if several apply to a product, the best one wins; the exceptions are the
  customer discount (setting above) and manual line discounts. The rounding table is applied after deals.
  (resolved: deals vs catalogue discounts) [DOC:DEAL]
- Bulk edit: product-level discounts through the inventory list CSV, customer and customer-group discounts through the
  Discount Matrix CSV (customer name and customer tag are mutually exclusive); deals can also be imported by CSV (separate article). [DOC:DISC]
- Permission: Settings - Stock - Product discounts. [DOC:PERM]
- Tie-break between two discounts of the same level on one product is not stated. [ASSUME: the better price]

### Worked example

Tier price 80.00; product discount 10%; customer % discount 5%. Setting Off: product -> 72.00; customer -> 76.00;
lower used = 72.00. Setting On: 80.00 x 0.90 = 72.00, then x 0.95 = 68.40. Add a 3% order-line discount: 72.00 x 0.97
= 69.84 (Off) or 68.40 x 0.97 = 66.35 (On). [DOC:DISC, arithmetic ours]

---

## 21. Price tiers

No module-14 page: tier **names** live in General settings (Price tier names, 10 slots), listed by
`GET /ref/priceTier` (`Code`, `Name`); tier **values** are stored per product (Prices tab). [API, DOC:PRICE]

### Fields

| Field | Rules |
|---|---|
| `Code` (1..10) | fixed numbers |
| `Name` | up to 10 names; blank names hide the tier in pickers `[SPEC]` |
| Per product: static price, **or** calculated (Calculated ticked) = base value + calculation type | base value options: Average cost (default), Fixed price (most recent fixed supplier price), Latest price, Price tier value, Highest fixed price, Highest latest price; the highest/latest variants use only suppliers with "Include in pricing" selected; types: Markup % (percent of the base) or Append (base plus an amount); Price tier value uses the entered value directly and disables the type (resolved/corrected) [DOC:PRICE] |

### Rules

- The customer carries a tier; the sale header tier (changeable) overrides the customer's; a custom per-customer
  product price overrides both. A price tier can also be applied to POS sales. [DOC:PRICE]
- Static tiers are not converted for foreign-currency customers; use separate tiers for those customers (simple
  pricing). [DOC:PRICE, DOC:MULTI]
- **Rounding table** (General settings > Rounding table) applies only to calculated prices: the first row starts at 0,
  find the row whose range contains the price, round to the nearest "Round to nearest" value, then optionally Add or
  Subtract a value. Rounding is applied after deals. [DOC:PRICE, DOC:DEAL]
- Permissions: Settings - Your company - General settings (names, rounding), Inventory - Products & families and
  Product - Price info (values). [DOC:PRICE]

### Worked example (calculated tier)

Average cost 40.00. Tier 2 = Markup 50% of Average cost -> 60.00. Tier 3 = Append 5.00 of Average cost -> 45.00.
Rounding row 0-100: round to nearest 1, subtract 0.10: 60.00 -> 60 -> 59.90; a calculated 38.87 -> 39 -> 38.90 (matches
the help center's own 38.87 example). Sale header tier = 3 for a customer whose default is 2: line price 45.00 (then
rounding rule). [DOC:PRICE]

---

## 22. Default field values

Routes `/DefaultFieldValues/Product`, `/Customer`, `/Supplier`. [SPEC]

**Purpose.** The values pre-filled on new records; also applied to customers created by eCommerce integrations
(Amazon, eBay, Magento, ShipStation, Shopify, WooCommerce) and to API-created records when an optional field is
omitted. Fields not given a default stay empty. [DOC:DEFVAL, DOC:API-DEFAULTS]

| Record | Fields (shown depend on product type) | Built-in default |
|---|---|---|
| Product | Type (Stock, Service, Gift Card, Non-Inventory, Fixed Asset), Fixed asset type (fixed asset only), Category, Brand, Costing method (FIFO, FIFO - Serial Number, FIFO - Batch, FEFO - Serial Number, FEFO - Batch, Special - Batch, Special - Serial Number), Unit of measure, Drop ship (No / Optional / Always), Product discount, Default location, Additional attribute set, I am selling this product | Type Stock; Costing method FIFO; Drop ship No; "I am selling this product" = Yes |
| Customer | Currency, Sale account, Tax rule, Payment term, Account receivable, Sale price tier, Sales representative, Default carrier, Default location, Attribute set | Currency = base; Payment term = 30 days |
| Supplier | Currency, Default carrier, Tax rule, Payment term, Account payable, Attribute set | Currency = base; Payment term = 30 days |

Which product fields show by type: Stock and Non-inventory show every field except Fixed asset type; Fixed asset shows
all fields; Service and Gift card show reduced sets (Service has no unit of measure; Gift card has no costing method,
drop ship, discount or default location). [DOC:DEFVAL]

### Rules

- Only admin users and owners, or users with "Configure default values" for product/customer/supplier, see the
  section. [DOC:DEFVAL, DOC:PERM]
- Changing a default never changes existing records; defaults are copied at creation and remain editable. [DOC:DEFVAL,
  INFER for "never changes"]
- CSV product import uses the "I am selling this product" default when Sellable is blank. [DOC:DEFVAL]
- A default that points at a record later made inactive stops pre-filling `[INFER]`.

---

## 23. Carriers

Route `/TenantCarrier`. Table `vTenantCarrier` (CarrierID, Description). API `/ref/carrier` (`Description` only).
UI also has `TrackingURL`. [SPEC, API]

| Field | Required | Type | Rules |
|---|---|---|---|
| Carrier name / `Description` | yes | text | unique `[INFER]` |
| Tracking URL | no | text | ends with a query such as `...?trackNumber=`; on Enter, Cin7 appends `[TrackingNumber]` [DOC:CARRIER] |

### Rules

- Where used: the Ship tab of a sale (carrier per shipment + tracking number), customer/supplier default carrier,
  purchase documents. The tracking link on printed documents, eCommerce notifications (e.g. Shopify) and tracking
  change notifications are built as URL + tracking number. [DOC:CARRIER, DOC:REF]
- Carriers are imported automatically from a connected shipping service (ShipStation, Shippit...). [DOC:CARRIER]
- Permission: Settings - Other items - Carriers. Delete/deactivate restrictions when used are not documented. [DOC:PERM, ASSUME]

---

## 24. Shipping zones

Route `/TenantShipZone`. Tables `vTenantShipZone` (ZoneID, Name, IsRestZone, ShortDesc, PricesInclTax,
DefaultShippingCost, Negative, TaxRuleID), `vShipZoneApplyTo` (Country2, StateID, PostCodeFrom/To, PostCodesList,
ShippingRate). Master switch Enabled/Disabled. [SPEC]

**Purpose.** Shipping cost by destination for sales (via "Get shipping rates > Shipping zones" on a quote or order
in the web app) and for the B2B portal once the B2B shipping service is switched from manual methods to shipping zones.
(corrected: not B2B only.) [DOC:SZ]

### Fields

Zone name; Tax rule (required, also in the CSV); Default shipping cost; tax status / "Tax included" (`PricesInclTax`);
"Applies to" rows (country, state, post-code from/to, post-code list, shipping rate); price-based rate rows (description,
Min total, Max total, Rate; basis tax-included or tax-excluded order value); weight-based rate rows (description, Min
weight, Max weight, Rate, free shipping by default). Zone kinds: regular, Rest of World (`IsRestZone`, fallback; **no
price- or weight-based rates**, only a tax status and a default rate), Exception (`Negative`: matching addresses get no
rate; only available once a Rest-of-World zone exists). CSV columns: zone name, country, state, post-code from/to (to is
required when from is set), post-code list, shipping rate, zone type (`ShippingZone`, `RestWorldZone`, `ExceptionZone`),
tax rule. [SPEC, DOC:SZ]

### Rules

- A zone needs at least one country row; only Country and Shipping rate are required per row. [DOC:SZ]
- The feature must be enabled before it applies to orders; the shipping address on the order drives the lookup; rates
  can be edited by hand afterwards. [DOC:SZ]
- Weight-based rates need product weights (blank counts as zero) and convert from the default weight unit in Product and
  measurement settings. [DOC:SZ]
- Import/export as CSV. [DOC:SZ]
- Match order and rate selection are not published. Sandbox: Exception zones first (no rate), then the most specific
  regular zone, then Rest of World; inside a zone a price-based row whose Min <= cart total <= Max, else weight-based, else
  Default shipping cost. [INFER]
- Permission: Settings - Other items - Shipping zones. [DOC:PERM]

---

## 25. Order routing

Route `/OrderRouting`. Table `vOrderRoutingSettings` (ID, LocationID, LocationName, City, State, ZipPostCode,
Country, TenantID). Two toggles: Order routing (On/Off) and "Keep routing, regardless of the stock status" (On/Off).
[SPEC]

**Purpose.** Chooses the fulfilment location of an eCommerce order from the shipping address; the sale header location
is pre-filled and can still be changed by hand. [DOC:OR]

| Field | Required | Rules |
|---|---|---|
| Country | yes | |
| State/province, City/suburb, Zip/postcode | no | spelling must match the eCommerce platform's address exactly ("Victoria" vs "Victoria (VIC)" differ) [DOC:OR] |
| Location | yes | one location per routing row; a location may serve many rows |

### Rules

- Matching order: postcode first; if the row's postcode is empty, then city/suburb, then state, then country (most
  specific wins). [DOC:OR]
- Routing applies only after each eCommerce integration's "link sales to Cin7 location" is set to Order routing, and the
  global switch is On. Available for eCommerce channels (Amazon, eBay, Etsy, WooCommerce, Magento, Shopify...); **not**
  for Shopify POS. Routing beats the Shopify location. Permission: Sale - Order routing plus the integration's own
  permission. If no routing row matches, Cin7 sets the default location. [DOC:OR, DOC:REF]
- Keep routing **Off** (default): if the routed location is out of stock, Cin7 picks another location with stock; one
  passage says the order goes to the default location, another says a random location with stock (see Unclear).
  **On**: always use the routed location. [DOC:OR]
- Rows can be exported, edited and re-imported as CSV (the import also updates existing rows). Missing routing can
  slow the import of online orders. [DOC:OR]

### Worked example

Rows: (US, CA, "", "", Location West), (US, "", "", "", Location East). Order ships to US/CA/90001: matches row 1
(country+state) -> West. Order to US/NY: row 2 -> East. If West has 0 stock of a line and Keep routing is Off, the
line goes to another stocked location (East if stocked); On: stays West and backorders.

---

## 26. Returns: reason for return, return policy, return order settings

Routes `/RMAReasonForReturn` (model `ReasonForReturn`: ID, Name), `/RMAReturnPolicy` (`RMAReturnPolicyGrid`: ID,
Name, CreatedDate, UpdatedDate, IsActive), `/RMAReturnOrderSettings` (`vSettings`). RMA is a subscription add-on.
[SPEC, DOC:RMA]

### Reason for return

Name (required, text). A reason is mandatory when an RMA is created (and on the customer portal request form). Add by
"+" or "Add more items". No deactivate flag in the map. Permission: RMA - Set up. [DOC:RET-SET, DOC:RMA, DOC:PERM]

### Return policy fields

Active; Name; scope Countries, Product families, Tags, Categories, Brands; RMA processing milestones (a separate
list); attributes: Return is possible, Return calculation start date (order, invoice or shipment authorisation; the
order date when unfulfilled or unpaid), Return available within X calendar days; Refund is possible, Refund
calculation start date, Refund within X days; Replacement is possible, Cross ship is possible, Replacement start
date, Replacement within X days; policy text. Repo spec extras not found in the help center: Refund payment options
(Credit | Based on original method of payment), blank = Lifetime, Restocking fees (percent **or** amount), and a "cost
type" list. [SPEC, DOC:RET-POL]

### Rules

- A policy states which products can be returned, refunded or replaced, and for how long. At least one active policy
  must exist for RMAs and return orders to start. Policies guide the workflow; the RMA officer decides. [DOC:RET-POL]
- No countries selected = all countries; no families/tags/categories/brands selected = all products. Values inside a
  group are OR, groups are AND. **Overlap:** the most specific wins in the order Family, Tag, Category, Brand, with
  group-specific policies beating all-products ones; two policies cannot have identical country and product
  parameters. (resolved: overlap) [DOC:RET-POL]
- Saving a changed policy applies it retroactively by default; the RMA officer can override. A repair request is
  always allowed within the return period regardless of refund/replacement limits. [DOC:RET-POL]
- Processing milestones (default: shipping from customer, inspection, repair, shipping to customer) drive job orders
  and costs; each has a cost type (default shipping, inspection, repair; more can be added) and a default payer
  (company or customer); at least one milestone is mandatory. [DOC:RET-POL]
- Return types: Refund, Replacement, Repair, Other (only Refund and Other for an unfulfilled product). Receipt actions:
  Inspect, Scrap, Restock (restocks as the original SKU), Receipt not required, Cancel. No inspection or repair costs
  can be added when the action is Scrap or Restock. Receiving the products (or Receipt not required) creates an
  authorised credit note for their value. Default RMA expiry one month. [DOC:RMA]
- Restocking fee: percent or fixed amount deducted from a refund; **the help center has no restocking-fee feature**,
  so this is repo-spec only. `[SPEC, INFER for the arithmetic]`

### Return order settings fields

Receive-returned-products-to location (any location except fixed-asset, co-manufacturing and deprecated ones);
Non-warranty expense account (cleared when the customer is invoiced); Warranty expense account; Scrap/write-off
default expense account; Credit note creation (per receiving-order line | one note after all lines). The settings
must be active for RMAs to start; they prefill RMA fields and apply to new RMAs only. [DOC:RET-SET]

### Worked example (restocking fee, spec feature)

Return policy: refund possible, 15% restocking fee, return window 30 days from invoice date. Line sold 200.00 on 1 May;
RMA raised 20 May: within window. Refund = 200.00 - 30.00 = 170.00. RMA on 5 Jun: outside the window -> return
not allowed. [INFER on the arithmetic]

---

## 27. Warranties

Route `/WarrantySetupList`. Table `vWarrantySetup` (ID, Name). Grid: Name, Start date (`CalculationStartDate`), Terms
(`TermsType`), Active. The page also has an "auto-generated number" toggle. [SPEC]

**Purpose.** Manufacturer warranty templates (not extended warranties) attached to products and product families.
(resolved: rules were previously "not published"). [DOC:WARR]

### Rules

- Fields: name; start from Sales order (authorised date), Invoice (authorised date) or Shipment (ship date);
  registration number Auto (default, generated at the Pack step) or Manual (must be unique); term Lifetime (default) or
  Calculated in days, months or years; warranty agreement text or link; Active (default). [DOC:WARR]
- Applicable to Stock, Non-inventory and Fixed-asset products (not Service or Gift card); a product-level warranty beats
  its family's. Registration happens at the Pack stage of a sale; with automatic packing the number must be entered
  afterwards or no warranty is registered. The certificate can be printed or emailed once a number exists.
  [DOC:WARR]
- Deleting/deactivating: blocked while a product uses the warranty; existing sales keep it. Undo of the whole sale
  resets the number; void deletes the registration; undoing Pack keeps previously issued numbers for reuse. [DOC:WARR]
- Permissions: Warranty - Setup (view/edit templates), Warranty - Search (registered warranties list). Document
  numbering uses the WRN prefix from General settings. [DOC:WARR, DOC:PERM, SPEC (settings.md G-93)]

---

## 28. Company addresses and contacts

Routes `/TenantAddress` (`vTenantAddress`), `/TenantContact` (`vTenantContact`). [SPEC]

### Address fields

Line 1, Line 2 (optional), City/suburb, State/province, ZIP/postcode, Country, Type (Billing | Business | Shipping),
Default (one per type; with several, the first default in the list is used). [SPEC, DOC:COMPANY, DOC:REF]

### Contact fields

Name, Phone, Fax, Email, Website, Type (Billing | Business | Sale | Shipping | Employee), Default (one per type; the first
default in the list is used), Mailing list (multi-select), sales commission %, accounting dimensions (when enabled). A
"Reassign company contact" action moves records from one contact to another before deletion. [SPEC, DOC:REF, DOC:COMPANY]

### Rules

- The default business and shipping addresses print on documents; each type's default contact is pre-selected on
  new documents. [DOC:REF, DOC:COMPANY]
- At least one default billing contact must exist: it receives the subscription invoice and is needed to email invoices
  to customers. [DOC:COMPANY, DOC:REF]
- A contact in use (sales representative, commission, assignment) must be reassigned before delete. [SPEC, INFER]
- Contacts act as an accounting-dimension source and as sales representatives (with commission). [DOC:DIM]
- Permissions: Settings - Your company - Addresses and - Contacts. Xero addresses download to Cin7. [DOC:PERM, DOC:XERO-SYNC]

---

## 29. Lead statuses

Route `/LeadStatus`. Table `vLeadStatus` (StatusID, Name, IsActive, IsKanban, Position). Grid: Name, Is active.
(The map's modal re-uses the payment-term control ids, an artefact.) [SPEC]

**Purpose.** Pipeline stages of CRM leads, shown as board columns when `IsKanban`.

Rules: the four defaults are Attempting to contact, New, Qualified and Disqualified; custom statuses are added with +
or Add more items, edited by clicking, and deleted. "Show in Kanban" and drag-to-reorder control the board columns
(position). Leads cannot be deleted, only moved to Disqualified; a lead of any status can be converted to a customer
(irreversible). Permission: Settings - Other items - Lead categories. Deleting a status in use on leads is not
described `[INFER]` blocked. [DOC:LEAD, DOC:PERM]

---

## 30. Cin7 Core to Cin7 Core network

Route `/DearToDearNetworking`. Table `vDearToDearNetworking`. Grid: Contact (supplier/customer id), Contact type
(`ConnectionType`), Is invite sent, Date invite sent, Status, Date connected, Networking key. An invitation email form
(To, Subject) and recipient selection exist. [SPEC]

**Purpose.** Connect a supplier or customer that also uses Cin7 Core so purchase orders, sale orders and invoices flow
between the two accounts. (resolved: behaviour is documented.) [DOC:NETWORK]

Rules:

- Invite: Settings > Reference books > Your company > Core to Core networking > Send an invite. The email carries the
  sender's network key and organisation name and must not lose them. The row shows Is invite sent and Status "Waiting
  to connect". An account missing from the table can be added by typing its registered email as the recipient.
- Accept: the invited party creates a connection, picks the customer or supplier, and enters the inviter's network key;
  both sides then show Connected, a permission is created on both, and connected contacts get a Connected icon. If that
  permission is off the page is hidden but documents still flow.
- One side must be a customer and the other a supplier; both-customer or both-supplier pairs are unsupported.
- Flow: a purchase order emailed with "Send via Core Network" appears at the supplier as a pre-sale order "Waiting
  for approval"; approving it makes an authorised simple sale; either party can then send invoices the same way.
- Only administrators open the network page; any user can still send documents to connected contacts. A connection is
  removed with the X on its row. [DOC:NETWORK]

---

## Unclear / docs disagree

Each item says what is missing or conflicting and the sandbox choice. Items resolved by the full help center are struck
through with a pointer to where the answer now lives.

1. ~~**Help centre unreadable directly.**~~ Resolved: the full help center was read; sources are listed below.
2. ~~**Payment-term arithmetic.**~~ Mostly resolved in [section 5](#5-payment-terms): the method wording, the meaning of
   0 for two methods, the Last-day method and the `DueNextMonth` column (QuickBooks date-driven) are documented.
   **Still open, narrower:** (a) whether "Day of next month" with Days greater than the month length clamps (sandbox) or
   rolls into the following month; (b) the API code for "Days since the end of the month" (only DAYS, MONTHDAY and
   LASTMONTHDAY are listed in the API reference).
3. **Tax rules in use.** The docs say rules cannot be deleted and can be deprecated; they do not say whether a rule
   already on documents can be deprecated, nor whether a deprecated rule stays on old documents. Chosen: allowed,
   history kept. `IsTaxForSale` / `IsTaxForPurchase` appear in the API as applicability flags, but their defaults and
   enforcement are not described.
4. **Inclusive compound formula** (Example E) is derived, not documented. Rounding per component is also
   undocumented beyond the tenant "Tax calculation method" (row total vs document total, now documented).
5. **Account type names differ:** Tax Liability is "Liability" in one article and "Current Liability" in the other (still
   open, minor). ~~Cost of Goods Sold naming~~ resolved: Expense - Direct Cost for standalone/Xero, Cost of Sales for
   QuickBooks. ~~Customer Credits liability vs current liability~~ resolved: Current Liability in both tables.
   ~~Whether Current Year Profits is required~~ resolved: optional (needed when carry-forward or unrealized is on). New:
   the Unrealized Currency Gains account is typed Expense but the period report says the result is recorded in equity.
6. ~~**Chart of accounts limits.**~~ Resolved: code and name are 50 characters (API reference); accounts can be edited at
   any time and the import template can change codes. Still unstated: the UI's own length hint (the repo spec says 150
   for name) and whether archiving a still-mapped account is blocked.
7. **Account mapping.** The journal pairs are now documented for purchases, sales, adjustments, assembly, write-off,
   disassembly, transfers and accruals ([section 2](#2-account-mapping)). **Still open:** fixed-asset depreciation and
   period-close journal directions (only the accounts are named), and the allowed account types of the accrual slots are
   as listed (asset or liability for accrual) with no further validation text.
8. **Bank accounts.** Still open: the default currency when none is chosen, how the initial balance is dated, whether
   the code is system-generated, and initial-balance behaviour for foreign-currency accounts.
9. **Multicurrency order of operations.** Still open, and now sharper: both the pricing and multicurrency articles say
   markup/append values are "added after the currency conversion" and that calculated prices display in base currency,
   yet the multicurrency article also says markup pricing is specified in base currency and then converted. The earlier
   repo spec (`rules/settings.md`) says "computed in base then converted". Chosen: compute in base, then convert for the
   document. Rate direction (document currency per base, chosen) and the rate source for historic dates are `[ASSUME]`.
10. **Locations.** ~~Bin suggestion priority values~~ resolved ([section 11](#11-locations)). ~~Location-limit counting~~
    partly resolved (fixed asset locations do not count). **Still open:** the API `IsStaging` flag versus the UI types
    (no "staging location" option), location name uniqueness, whether deprecating the default location is blocked, and
    whether warehouse locations count toward the limit (only fixed-asset locations are said not to).
11. **Bins.** ~~Auto-pick order~~ resolved (alphanumeric, documented). **Still open:** bin-name uniqueness within a
    location, and what happens to stock when a bin holding stock is deprecated.
12. **Pick zones.** Still open: the Pick Zones article assigns zones on the product's Pick zones field using the default
    location's zones, while the product-creation article describes a pick zone per location inside the reorder levels.
    Sandbox: product-level field plus the optional per-location entry.
13. ~~**Supply rules / transfer planning.**~~ Resolved: priority Family > Tag > Category > Brand, the rule-by-rule
    fallthrough, final action, and the interval/fixed-day arithmetic are documented ([section 14](#14-supply-rules-and-transfer-planning)).
14. **Fixed asset types.** Still open: the averaging-method option list, rate-vs-life conversion and half-year
    conventions are in no article; the seven depreciation codes come from the Depreciation Schedule report article, and
    the formulas for each code are not published.
15. **Opening balances.** ~~Whether debits must equal credits~~ resolved: "Balance out by" must be 0 (whether Save is
    blocked is unstated). ~~What locks after the conversion date~~ resolved: the date locks once data exists. **Still
    open:** how outstanding foreign-currency items are converted, and treatment of open purchase orders and unpaid sale
    orders (a repo question list already asks the same).
16. **Discounts.** ~~Stacking with deals and discount type names~~ resolved ([section 20](#20-discounts-and-deals)).
    **Still open:** the tie-break between two discounts of the same level on one product.
17. ~~**Return policy.**~~ Overlap resolved (most specific, Family > Tag > Category > Brand). **Still open:** the help
    center has no restocking fee, refund-payment-option or "Lifetime when blank" setting; they exist only in the repo
    spec's map.
18. **Reference-book permissions.** Mostly resolved: names are listed in [section 0, rule 8](#0-cross-cutting-rules).
    Still open: whether any book beyond those named has its own permission (fixed asset types ride on Financials - Fixed
    assets; shipping zones and attributes are named; accounting dimension controls are named).
19. **Units of measure / categories / brands.** ~~Required or optional~~ resolved (category mandatory, brand optional,
    name length 50). **Still open:** uniqueness and delete-while-in-use for all three; the sandbox applies unique-name and
    block-delete-if-in-use.
20. **Warranties, lead statuses, expense items, Cin7-to-Cin7 network, logistics paths.** Resolved: warranty rules,
    lead-status defaults, expense items' real use (expense claims), network flow and logistics-path fields are now in
    sections 27, 29, 9, 30 and 15. **Still open:** the delete guard for expense items and for statuses in use.
21. ~~**Seeded entries.**~~ Resolved for what the docs publish: see [section 0, rule 11](#0-cross-cutting-rules). **Still
    open:** the full default chart and which seeded entries are locked.
22. **New: revenue account priority.** One article ranks revenue accounts order line > sales channel > product >
    customer > order header > general settings; another ranks all account settings order line > product > header >
    customer/supplier. The header and customer levels are swapped. Chosen: the first for revenue, the second for
    every other account and for tax.
23. **New: order-routing fallback.** The same article says an out-of-stock routed order goes to the default location
    (set-up steps) and to a random location with stock (tips). Chosen: any location with stock, preferring the default.
24. **New: bank accounts and credit cards.** The Bank Accounts article says credit cards can be added the same way; no
    separate type or rules are described. Treated as ordinary bank-type accounts.

---

## Sources

Cin7 Core help center, read in full from the public site (plain-text copy of all 660 articles). Keys used in tags:

- [REF] https://help.core.cin7.com/hc/en-us/articles/9034511314831-Reference-books
- [IMPORT] https://help.core.cin7.com/hc/en-us/articles/9034481752847-Import-data-via-CSV-files
- [COA] https://help.core.cin7.com/hc/en-us/articles/9034463858831-Accounts-and-Chart-of-Accounts
- [COA-SET] https://help.core.cin7.com/hc/en-us/articles/9034460268815-Charts-of-accounts-and-other-financial-settings
- [ACCT-TX] https://help.core.cin7.com/hc/en-us/articles/9982480207375-Accounting-transactions-in-Cin7-Core
- [COGS] https://help.core.cin7.com/hc/en-us/articles/9982508174223-An-Introduction-to-Cost-of-Goods-Sold-COGS
- [ACCRUAL] https://help.core.cin7.com/hc/en-us/articles/9034465644559-Inventory-Accrual-and-Stock-in-Transit-implementation-GRNI-GINR
- [XFER] https://help.core.cin7.com/hc/en-us/articles/9034487790095-Stock-transfers
- [COMAN] https://help.core.cin7.com/hc/en-us/articles/9034480843919-Co-manufacturing-outsourcing-parts-of-the-production-process
- [BANK] https://help.core.cin7.com/hc/en-us/articles/9034464234639-Bank-Accounts
- [FIN-INTRO] https://help.core.cin7.com/hc/en-us/articles/9034481949455-Introduction-to-the-Financial-Module
- [FIN-SET] https://help.core.cin7.com/hc/en-us/articles/11073339810575-Financial-settings
- [PERIOD] https://help.core.cin7.com/hc/en-us/articles/9034491249423-Monthly-Closing-Process-Financial-Periods-Report
- [ORG-SET] https://help.core.cin7.com/hc/en-us/articles/11073350117775-Organization-settings
- [TAX] https://help.core.cin7.com/hc/en-us/articles/9034574221071-Tax-rules
- [TAX2] https://help.core.cin7.com/hc/en-us/articles/13625639267087-Tax-rules-with-Cin7-Core-and-Xero-or-QuickBooks-Online
- [XERO-SYNC] https://help.core.cin7.com/hc/en-us/articles/13000978343695-Xero-sync-options
- [XERO-CONNECT] https://help.core.cin7.com/hc/en-us/articles/9034588410383-Connect-Cin7-Core-and-Xero
- [DUE] https://help.core.cin7.com/hc/en-us/articles/9034492714255-Processing-a-sale
- [SALES-LIST] https://help.core.cin7.com/hc/en-us/articles/9034586802319-Sales-list-and-order-status
- [CREDIT] https://help.core.cin7.com/hc/en-us/articles/9034450723215-Credit-limits-and-holds
- [AMAZON] https://help.core.cin7.com/hc/en-us/articles/9034459874703-Amazon-integration and [SHOPIFY-DL]
  https://help.core.cin7.com/hc/en-us/articles/11796986460431-Download-orders-from-Shopify (due-date and term lines)
- [DEFVAL] https://help.core.cin7.com/hc/en-us/articles/9034451009935-Default-field-values-for-new-products-customers-and-suppliers
- [API-DEFAULTS] https://help.core.cin7.com/hc/en-us/articles/9034494038671-Products (omitted optional fields take the default)
- [DIM] https://help.core.cin7.com/hc/en-us/articles/9034429852047-Accounting-Dimensions
- [OPEN] https://help.core.cin7.com/hc/en-us/articles/9034487616015-Manage-opening-balances-conversions
- [SOH] https://help.core.cin7.com/hc/en-us/articles/12047267533071-Set-stock-on-hand
- [FA] https://help.core.cin7.com/hc/en-us/articles/9034435967887-Fixed-assets
- [FA-DEP] https://help.core.cin7.com/hc/en-us/articles/9034481254671-Depreciation-Schedule
- [EXP] https://help.core.cin7.com/hc/en-us/articles/9034547850639-Receipts-Expense-Claims
- [MULTI] https://help.core.cin7.com/hc/en-us/articles/9034476155279-Multicurrency-and-currency-conversion
- [MULTI-COMM] https://help.core.cin7.com/hc/en-us/community/posts/15584588125839-Fixed-Exchange-Rates (community post; not in the 660-article corpus, kept from the earlier pass)
- [CUSTPAY] https://help.core.cin7.com/hc/en-us/articles/9034464766991-Customer-Payment-Summary-Report
- [PRICE] https://help.core.cin7.com/hc/en-us/articles/9034506082063-Pricing-and-price-tiers
- [LOC] https://help.core.cin7.com/hc/en-us/articles/9034487246735-Locations
- [BINS] https://help.core.cin7.com/hc/en-us/articles/11321150323727-Bins
- [DPU] https://help.core.cin7.com/hc/en-us/articles/9034497973647-Directed-put-away
- [DPICK] https://help.core.cin7.com/hc/en-us/articles/9034590791439-WMS-Directed-pick-and-bin-groups
- [PZ] https://help.core.cin7.com/hc/en-us/articles/9034505649679-Pick-Zones
- [SUPPLY] https://help.core.cin7.com/hc/en-us/articles/9034516955791-Location-supply-rules-and-transfer-planning
- [LP] https://help.core.cin7.com/hc/en-us/articles/9034569676431-Shop-floors-and-logistics-paths
- [AUOM] https://help.core.cin7.com/hc/en-us/articles/9034463961231-Additional-Units-of-Measure
- [SEG] https://help.core.cin7.com/hc/en-us/articles/9034477839247-Product-segmentation
- [ATTR] https://help.core.cin7.com/hc/en-us/articles/9034463879055-Additional-Attributes
- [DISC] https://help.core.cin7.com/hc/en-us/articles/9034464989327-Discounts
- [DEAL] https://help.core.cin7.com/hc/en-us/articles/9034519918095-Product-Deals
- [CARRIER] https://help.core.cin7.com/hc/en-us/articles/9034435146511-Carriers
- [SZ] https://help.core.cin7.com/hc/en-us/articles/9034573853967-Shipping-Zones
- [OR] https://help.core.cin7.com/hc/en-us/articles/9034471791119-Order-routing-for-eCommerce-integrations
- [RMA] https://help.core.cin7.com/hc/en-us/articles/9034548335631-Returns-RMAs-and-Return-Orders
- [RET-SET] https://help.core.cin7.com/hc/en-us/articles/9034460342159-Configure-returns-settings
- [RET-POL] https://help.core.cin7.com/hc/en-us/articles/10553626982799-Add-and-edit-return-policies
- [WARR] https://help.core.cin7.com/hc/en-us/articles/9034590702607-Warranties
- [SD] https://help.core.cin7.com/hc/en-us/articles/9034590012559-Supplier-Deposits
- [CC] https://help.core.cin7.com/hc/en-us/articles/9034481007375-Customer-Credits
- [COMPANY] https://help.core.cin7.com/hc/en-us/articles/12327495978767-Company-and-contact-settings
- [LEAD] https://help.core.cin7.com/hc/en-us/articles/9034487069071-Leads
- [NETWORK] https://help.core.cin7.com/hc/en-us/articles/9034498285327-Getting-Started-with-Core-to-Core-Networking
- [PERM] https://help.core.cin7.com/hc/en-us/articles/9034604405007-User-permissions-explained

API v2 reference articles (field lengths, enumerations): ChartOfAccounts
https://help.core.cin7.com/hc/en-us/articles/9034480763023-ChartOfAccounts , PaymentTerms
https://help.core.cin7.com/hc/en-us/articles/9034491663759-PaymentTerms , Locations
https://help.core.cin7.com/hc/en-us/articles/9034490412559-Locations-endpoint , TaxationRules
https://help.core.cin7.com/hc/en-us/articles/9034574233871-TaxationRules , ProductBrands
https://help.core.cin7.com/hc/en-us/articles/9034540057487-ProductBrands , ProductCategories
https://help.core.cin7.com/hc/en-us/articles/9034523167503-ProductCategories , UnitsOfMeasure
https://help.core.cin7.com/hc/en-us/articles/9034574293007-UnitsOfMeasure , AttributeSets
https://help.core.cin7.com/hc/en-us/articles/9034464178575-AttributeSets .

API v2 (via the `cin7-core` map tools `search_operations` / `describe_operation`, no credentials, no `read`; shapes
only): `location create|update|delete|list`, `tax create|update|list`, `payment-term create|list`, `carrier create|list`,
`unit-of-measure create|list`, `brand create|list`, `product-categories create|list`, `attribute-set create|list`,
`chart-of-accounts create|list`, `bank-accounts list`, `price-tiers list`, `fixed-asset-type create|list`.

Repo: `spec/modules/14-reference-books/README.md`, `UI.md`, `schema.sql`; `src/sandbox/modules/m14_reference_books.py`;
`rules/settings.md` (earlier spec; entries marked `settings.md G-/R-` are repo-spec cross-references); `questions/14-reference-books.md`.
