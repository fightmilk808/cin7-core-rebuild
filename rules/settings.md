# Cin7 Core settings: rules spec

What every setting is, which values it takes, what a new account starts with, and what it changes in the
rest of the app. This is the "settings half" of the rules the sandbox still lacks (the map in `spec/` has
screens, fields and tables but no behaviour). Rules only: no company data.

Source: the public Cin7 Core help center, read in full (660 articles, last edited up to 2026-10-26), plus the
Cin7 Core API v2 map (`cin7-core` operations) and the repo spec (`spec/modules/13-settings`, `14-reference-books`).
Help-center text is paraphrased, never copied.

How to read an entry

- **UI name** is the label on the screen (from `spec/modules/13-settings/UI.md` and the help center).
- **Map field** is the column on `vTenant` (`spec/modules/13-settings/schema.sql`) or the table named. Where
  the UI control id and the model column differ, both are given. `-` means the map has no column for it.
- **Verified** is one line per entry: `confirmed` (the help center agrees), `corrected` (the old text was wrong or
  incomplete; the fix is marked `(corrected: ...)` in the entry), `added` (new in this pass) or `open` (the help
  center says nothing). It carries the confidence tag and the article URL.
- **Confidence tags** (used on every rule, inline where one entry mixes kinds):
  - `[DOC]` stated by a help-center article (URL given).
  - `[API]` taken from the Cin7 Core API v2 map; the help center does not state it.
  - `[INFER]` read from the repo spec (UI labels, schema columns, screens) or deduced from it; the help center is silent.
  - `[ASSUME]` a sandbox choice because nothing documents it. Where a default is marked `[ASSUME]` it is the least
    surprising option and matches the order of options on the screen. Nothing tagged `[ASSUME]` is fact.
- **Effect** is written as concrete rules a sandbox can implement. `(added: ...)` marks a rule found in this pass.

Permissions needed to change anything on the General settings page: `Settings: Your company - General Settings`
(full access). Read-only access shows the page but cannot save. [DOC] https://help.core.cin7.com/hc/en-us/articles/9034465203343-General-settings

---

## ⚠️ Gotchas: the sneaky stuff

The easy-to-miss behaviours, worst first. `CAUTION` = silently corrupts data, cost or stock, is irreversible, or fails silently. `WARNING` = a surprising rule that breaks a rebuild if missed. `NOTE` = the sources disagree. Each links to the full rule below.

> [!CAUTION]
> **Data reset deletes real records, and it is the only way to change base currency**
> The help center says only that changing base currency after the first transaction needs the owner to delete the organisation's data first. The two reset buttons (transactional: purchases, sales, adjustments, stocktakes; full: also products, suppliers, customers, jobs, discounts, deals) come from the repo UI spec, not the help center, so their exact scope is `[INFER]`. The spec has them behind a typed confirmation word and the password. No undo is described anywhere. See [A-06](#a-06-subscription-referral-and-data-reset-mysubscription).

> [!CAUTION]
> **Country and base currency are one-way decisions**
> `[DOC]` Country can never be changed on an existing account (a new organisation is needed). Base currency can only change before the first transaction; after that the owner must delete the data first. Customers and suppliers each hold a single currency, so a partner billed in two currencies needs two records. See [G-03](#g-03-base-currency).

> [!CAUTION]
> **Accrued inventory (GRNI/GINR) does nothing if its accounts are not mapped**
> `[DOC]` Cost is only recognised when the purchase invoice is authorised, while stock lands when stock-received is authorised, so an invoice with no stock yet inflates the balance sheet. Switching accrual on fixes that only when both accounts are mapped; a missing mapping silently leaves the old behaviour. In invoice-first mode every asset-class invoice line account is swapped for Stock in Transit, and lines cannot be re-accounted after stock is authorised without Undo. See [G-48](#g-48-enable-accrued-inventory-transactions--grni--ginr-accounts).

> [!CAUTION]
> **Ship before the purchase invoice is authorised and COGS is zero**
> `[DOC]` Cost comes from the authorised purchase invoice, not from receiving. Stock can be received, picked and shipped first; COGS then shows 0 at the ship date and is posted later, dated with the purchase-invoice date, when that invoice is authorised. Dropship lines have no ship tab at all: their COGS posts at purchase-invoice authorisation. See [G-59](#g-59-default-shipment-date).

> [!CAUTION]
> **Changing a setting never fixes documents that already exist**
> `[INFER]` Most general settings are only the starting value copied into a document header at creation (purchase method, tax rule, price tier, location, quote skipped, advanced vs simple). The help center confirms each can be changed per document; it does not say existing documents are rewritten, and a changed numbering prefix affects new documents only. See [section 0, rule 1](#0-how-settings-interact-read-this-first).

> [!WARNING]
> **The lock date also blocks dates that were filled in for you, and the accounting system can overwrite it**
> `[DOC]` A ship date that defaulted to an earlier invoice date counts as locked, so authorising the ship tab errors until a later date is typed. Add, edit and delete are all blocked. With Xero or QuickBooks Online the lock date is set there and is pulled back into Cin7 on each sync, so a value typed in Cin7 can revert; invoices dated before the lock also stop receiving synced payments. See [G-27](#g-27-period-lock-date).

> [!WARNING]
> **A blank account mapping works until the day a function needs it**
> `[DOC]` Mapping gaps are allowed and nothing complains at save time. When a function needs an unmapped account, Cin7 errors and may not complete the operation, so the failure shows up mid-transaction. Mappings are one-to-one, and in a tree chart only bottom-level accounts can be mapped. See [R-06](#r-06-account-mapping-accountmapping).

> [!WARNING]
> **Auto-assembly is all or nothing, only at the sale location, and only for some costing methods**
> `[DOC]` If components are missing at the sale location nothing is assembled (no partial assembly) and the user is offered Backorder. The parent product costing must be FIFO, FIFO-batch, the special FIFO variant or Special-batch; the serial-number and FEFO methods are not on the list. Re-authorising after Undo uses the new authorisation date. See [G-54](#g-54-on-order-authorization-auto-assemble).

> [!WARNING]
> **"Assign invoice number: on invoice authorization" breaks channels that need the number early**
> `[DOC]` A ShipStation sale needs its invoice number at creation to sync, so that integration wants "On sale creation". Sale invoice numbers must be unique across the organisation, purchase invoice numbers unique per supplier. The sandbox default is `[ASSUME]` (the help center names no default). See [G-51](#g-51-assign-invoice-number).

> [!WARNING]
> **Accounting dimensions are unavailable with Xero or QuickBooks Online, are not retroactive and cannot be deleted once used**
> `[DOC]` The feature is off by default, only works on standalone accounts, applies to new transactions only, and a dimension that has been used cannot be removed. See [G-30](#g-30-accounting-dimensions).

> [!WARNING]
> **Tax calculation method changes the cents**
> `[DOC]` Row total rounds each line to 2 dp then sums; Document total keeps 4 dp per line and rounds the sum to 2 dp. The claim that some accounting links reject one of the two is `[INFER]` (repo UI warning text; the help center is silent). See [G-13](#g-13-tax-calculation-method).

> [!WARNING]
> **Turning on order approval also turns on quote approval, and the reverse**
> `[DOC]` Both approval articles say enabling one enables the other, although the UI has two checkboxes. Disabling is not described. A rejected document becomes read-only and takes no payments. See [G-47](#g-47-enable-order-approval).

> [!WARNING]
> **There is no "allow negative stock" setting**
> `[DOC]` Authorising a sale with too little stock always offers Split order, Backorder or Create purchase order, and Available can still go negative (backdated adjustments, stock received dated after the sale). Unstock and credit-note voids are blocked only when they would make on hand negative. Exact on-hand blocking at ship is not documented. See [section 11, item 9](#11-unclear--docs-disagree).

> [!NOTE]
> **A customer credit limit of 0 means "no limit", but the credit articles also say a limit "cannot be 0"**
> `[DOC]` The same article gives both statements; the second is boilerplate that sits under the credit-hold and grace-period sections (grace period minimum is 1). The Stop mode is enforced through the "ignore credit limit" permissions. See [G-62](#g-62-customer-credit-limit).

---

## 0. How settings interact (read this first)

1. **Header beats customer beats general setting.** Almost every general setting is only the starting value for a
   new document. The value is copied into the document header when the document is created and can then be
   changed per document (purchase method, tax rule, tax inclusive, price tier, location, quote skipped, advanced
   vs simple). `[DOC]` per-document override is stated for purchase method, tax rule/inclusive flag, quote
   visibility and the default location. `[INFER]` Changing a setting later does not rewrite existing documents.
   Verified: confirmed [DOC] https://help.core.cin7.com/hc/en-us/articles/11073350145935-Sale-process-customization
2. **Tax rule priority** (highest first): order line (if manually changed) > sales channel > product > document
   header > customer/supplier. The header's tax-inclusive flag applies to the whole document even if lines use
   rules with a different default. In the B2B portal a rule cannot be overridden manually; the customer/supplier
   rule is used unless a product rule exists.
   Verified: confirmed [DOC] https://help.core.cin7.com/hc/en-us/articles/9034574221071-Tax-rules
3. **Account priority** for financial transactions has two documented orders. General (inventory, COGS, payables):
   order line > product > document header > customer/supplier. If a function needs an account that is not mapped,
   Cin7 errors and may not complete the operation. (corrected: **revenue** accounts follow a longer order,
   order line > sales-channel revenue account > product > customer > order header > general settings, and
   QuickBooks Online always overrides the product revenue mapping. The two articles differ on where the header
   and customer sit; see section 11 item 6.)
   Verified: corrected [DOC] https://help.core.cin7.com/hc/en-us/articles/9034460268815-Charts-of-accounts-and-other-financial-settings , https://help.core.cin7.com/hc/en-us/articles/9034463858831-Accounts-and-Chart-of-Accounts
4. **Price tier priority**: the tier on the sale header beats the tier on the customer. Custom (per-customer)
   product prices are used in place of the regular product price (so they beat tiers).
   Verified: confirmed [DOC] https://help.core.cin7.com/hc/en-us/articles/9034506082063-Pricing-and-price-tiers , https://help.core.cin7.com/hc/en-us/articles/9034569670415-Setting-Custom-Product-Prices
5. **Available quantity** = On hand - Allocated. It is kept per product and also per location/batch/expiry. Which
   locations count in the general figure is controlled by "Available quantity is limited to". On hand includes
   stock on sale orders not yet fulfilled and excludes purchase orders not yet received.
   Verified: confirmed [DOC] https://help.core.cin7.com/hc/en-us/articles/17647517073295-Calculation-of-Available-On-Hand-and-Allocated-Stock-quantity
6. **Lock date** (period lock) blocks add/edit/delete of any transaction whose effective date is earlier than the
   lock date, including a ship date that defaulted to an earlier invoice date. The user must enter a later date.
   Cin7 does not generate transactions in a closed period.
   Verified: confirmed [DOC] https://help.core.cin7.com/hc/en-us/articles/11073339810575-Financial-settings , https://help.core.cin7.com/hc/en-us/articles/9982508174223-An-Introduction-to-Cost-of-Goods-Sold-COGS
7. **Integrations override some settings**: with Xero or QuickBooks Online connected, tax rules, chart of
   accounts and bank accounts are created in the accounting system and appear read-only (tax rule components,
   rate and inclusive flag can be edited in Cin7 and sync both ways); the lock date is pulled from there; the
   chart of accounts must be flat. (added: accounting dimensions are unavailable on these accounts.) `[INFER]` The
   tax calculation method carries UI warnings for the two systems.
   Verified: corrected [DOC] https://help.core.cin7.com/hc/en-us/articles/9034574221071-Tax-rules , https://help.core.cin7.com/hc/en-us/articles/9034429852047-Accounting-Dimensions
8. **Module add-ons gate whole sections**: Production settings need Advanced Manufacturing; MRP is an optional
   add-on; notifications, workflow and tasks need the Automation module; returns need the RMA add-on; WMS needs the
   WMS app. Several modules can be trialled for 30 days. `[INFER]` When the add-on is off the screens are hidden or
   locked, not errored.
   Verified: confirmed [DOC] https://help.core.cin7.com/hc/en-us/articles/12327468731407-Manage-subscription , https://help.core.cin7.com/hc/en-us/articles/9034471690255-Notifications
9. (added) **Undo** returns an authorised document to Draft without deleting its lines; every step must be
   re-authorised. It needs the module's own Undo permission. It is refused once the document's products have been
   used elsewhere (a received purchase that was sold, transferred or consumed must have those later tasks undone
   first). A Xero sale folded into a consolidated daily invoice cannot be undone; a credit note plus a new order is
   the only route. Undoing a sale with dropshipped lines deletes the unauthorised dropship purchase orders.
   Verified: added [DOC] https://help.core.cin7.com/hc/en-us/articles/9034570756111-What-is-the-Undo-function-When-is-it-no-longer-possible-to-Undo-an-invoice

---

## 1. General settings: Organization (tab `tab1`)

Source: https://help.core.cin7.com/hc/en-us/articles/11073350117775-Organization-settings

### G-01 Legal/trading name
- Verified: confirmed [DOC] https://help.core.cin7.com/hc/en-us/articles/11073350117775-Organization-settings
- Map: `vTenant.Company`. Values: text. Default: set at sign-up. [INFER]
- Effect: the official name that appears on documents. `[INFER]` Also shown in the tenant switcher. `/Me` returns it as `Company`. [DOC]

### G-02 Country
- Verified: confirmed [DOC] https://help.core.cin7.com/hc/en-us/articles/11073350117775-Organization-settings
- Map: `vTenant` (country, shown read-only in the spec text input `TenantGeneralSettings_Index_Country`; the
  save model has `CountrySpecificKey`/`CountrySpecificData`). Values: country. Default: set at sign-up.
- Effect: cannot be changed after the account exists (a new organisation must be created instead). [DOC] Default
  tax rules are pre-loaded for AU/UK/US/NZ accounts [DOC https://help.core.cin7.com/hc/en-us/articles/9034574221071-Tax-rules]
  and a default chart of accounts exists [DOC https://help.core.cin7.com/hc/en-us/articles/9034463858831-Accounts-and-Chart-of-Accounts].
  (added: UAE organisations get extra location fields for VAT, Designated Zone and Emirate
  [DOC https://help.core.cin7.com/hc/en-us/articles/13625654020495-VAT-compliance-for-UAE].) `[INFER]` Drives the
  country-specific screens (`/TenantGeneralSettings/CountrySpecific`).

### G-03 Base currency
- Verified: confirmed [DOC] https://help.core.cin7.com/hc/en-us/articles/11073350117775-Organization-settings , https://help.core.cin7.com/hc/en-us/articles/9034476155279-Multicurrency-and-currency-conversion
- Map: `vTenant.Currency`; `/me` returns `Currency`. Values: ISO currency. Default: chosen at sign-up.
- Effect: can only be changed before the first transaction exists; after that an account owner must delete the
  organisation's data first. Documents for a customer/supplier whose currency differs from base show totals in
  both currencies and carry a `CurrencyRate` filled from a third-party exchange-rate feed and editable; the rate
  is sent to a connected Xero/QuickBooks. (added: a customer or supplier has exactly one currency. Prices on order
  lines are in the document currency. Static price tiers are not converted; markup-type calculated tiers are
  computed in base then converted; see G-92.)

### G-04 Time zone
- Verified: confirmed [DOC] https://help.core.cin7.com/hc/en-us/articles/11073350117775-Organization-settings
- Map: `vTenant.TimeZone`, reference list `vTimezone`. Default: set at sign-up.
- Effect: used for regularly scheduled processes such as report scheduling and data consolidation. [DOC]
  `[INFER]` Also used for notifications, recurring invoices and rendering timestamps.

### G-05 Date format
- Verified: corrected [DOC] https://help.core.cin7.com/hc/en-us/articles/11073350117775-Organization-settings , https://help.core.cin7.com/hc/en-us/articles/9034460672783-Date-Format , https://help.core.cin7.com/hc/en-us/articles/9034471421967-Me-Endpoint
- Map: `vTenant.DateFormat`. Values: `MM/dd/yyyy`, `dd/MM/yyyy`, `yyyy/MM/dd` (UI order: dd/MM/yyyy, MM/dd/yyyy,
  yyyy/MM/dd). Default: not documented; `[ASSUME]` `dd/MM/yyyy`, or by country (US: `MM/dd/yyyy`).
- Effect: display format for every date on screens, documents and reports. [DOC] The public API uses ISO 8601
  UTC (`yyyy-MM-ddTHH:mm:ss.fff`) for all its date fields and parameters. (corrected: the exceptions are `/Me`
  `LockDate` and `OpeningBalanceDate`, which the API doc says come back in the tenant date format; the
  attribute-set "Date" type also follows the organisation format; gift-card CSV import uses `YYYYMMDD`.) Other CSV
  import/export date formats are not documented (section 11 item 11).

### G-06 Send emails from
- Verified: confirmed [DOC] https://help.core.cin7.com/hc/en-us/articles/11073350117775-Organization-settings
- Map: `vTenant.EmailSender`. Values: Company's billing contact | Currently logged-in user | Company's billing
  contact (sent from the system) | Currently logged-in user (sent from the system). Default: `[ASSUME]` billing contact.
- Effect: From address on every emailed document and notification. The "sent from the system" variants go through
  Cin7's mail servers and are the fix when mail is flagged as spam. [DOC] The billing contact is configured in
  company contacts and at least one default billing contact must exist. [DOC https://help.core.cin7.com/hc/en-us/articles/12327495978767-Company-and-contact-settings]

### G-07 Add email sender to CC
- Verified: confirmed [DOC] https://help.core.cin7.com/hc/en-us/articles/11073350117775-Organization-settings
- Map: `vTenant.AddEmailSenderToCC`. Values: Add sender to CC | Do not add sender to CC. Default: `[ASSUME]` do not add.
- Effect: the sender gets a copy of each emailed document for their records. (The article calls the setting "CC
  email sender".)

### G-08 Global BCC address
- Verified: corrected [DOC] https://help.core.cin7.com/hc/en-us/articles/11073350117775-Organization-settings
- Map: `vTenant.GlobalBcc`. Values: email or blank. Default: blank.
- Effect: (corrected: BCC on **every** email Cin7 sends, not only purchase and sale documents.) Counts toward the
  20-recipient-per-email cap (To+CC+BCC combined; 5 on trial accounts). Sending is also rate-limited per minute,
  hour and day.

### G-09 Email read receipts
- Verified: confirmed [DOC] https://help.core.cin7.com/hc/en-us/articles/11073350117775-Organization-settings
- Map: `vTenant.RequestMailReceipt`. Values: Required | Not required. Default: `[ASSUME]` Not required.
- Effect: asks the recipient's mail client to confirm the email was seen. `[INFER]` Implemented as a read-receipt
  request header.

### G-10 Open details in
- Verified: confirmed [DOC] https://help.core.cin7.com/hc/en-us/articles/11073350117775-Organization-settings
- Map: `vTenant.OpenDetailsInNewTabs`. Values: New tab | Same tab. Default: `[ASSUME]` Same tab.
- Effect: clicking a task in a list (purchase, sale, production, stock transfer, stock adjustment, ...) opens it
  in a new browser tab or in place. Other links are unaffected.

### G-11 Purchase and sale headers
- Verified: confirmed [DOC] https://help.core.cin7.com/hc/en-us/articles/11073350117775-Organization-settings
- Map: `vTenant.HeadersVisible`. Values: Visible | Hidden. Default: `[ASSUME]` Visible.
- Effect: when opening an existing purchase or sale the document header block is expanded or minimised.

### G-12 Export CSV file encoding
- Verified: confirmed [DOC] https://help.core.cin7.com/hc/en-us/articles/11073350117775-Organization-settings
- Map: `vTenant.ExportEncoding`. Values: ASCII | Unicode (UTF-8). Default: `[ASSUME]` ASCII (first in list).
- Effect: encoding of every CSV export. Non-Latin text (for example Chinese) is only correct with Unicode.

### G-13 Tax calculation method
- Verified: confirmed [DOC] https://help.core.cin7.com/hc/en-us/articles/11073350117775-Organization-settings
- Map: `vTenant.TaxCalculationMethod`; `/me.TaxCalculationMethod`. Values: Row total | Document total.
  Default: `[ASSUME]` Row total.
- Effect (exact, [DOC]): **Row total** = tax per line, each rounded to 2 dp, then summed. **Document total** =
  tax per line rounded to 4 dp, summed, then the total rounded to 2 dp. Applies to sale and purchase documents.
  The help center places this setting on the Organization tab. `[INFER]` UI warnings (hidden spans) appear when the
  method does not match the connected accounting system: Document total is incompatible with Xero and QuickBooks
  Online Global; Row total with QuickBooks Online US. `[API]` The method is also stored per document
  (`TaxCalculation` on Sale and Purchase).

### G-14 Max. decimal places in documents
- Verified: corrected [DOC] https://help.core.cin7.com/hc/en-us/articles/11073350117775-Organization-settings , https://help.core.cin7.com/hc/en-us/articles/9034558116879-Report-FAQs
- Map: `vTenant.DecimalPlacesInQuantity`; `/me.MaximumDecimalPlacesInQuantity`. Values: No decimal places | 1 | 2
  | 3 | 4. (corrected: the help center calls it "Maximum decimal places in quantity", and the default is **2**.)
- Effect: limits how many decimals of a quantity are shown in reports and documents. Display only; stored
  quantity precision is unchanged. A report FAQ says it changes exported PDF reports only.

### G-15 Credit hold grace period
- Verified: confirmed [DOC] https://help.core.cin7.com/hc/en-us/articles/11073350117775-Organization-settings , https://help.core.cin7.com/hc/en-us/articles/9034450723215-Credit-limits-and-holds
- Map: `vTenant.CreditHoldGracePeriod` (integer days). Values: positive integer, minimum 1. Default: blank, meaning
  the hold starts as soon as the payment is overdue.
- Effect: an automatic credit hold is placed on a customer who has exceeded the credit limit and has an overdue
  payment (overdue judged by the customer's payment term). The hold is delayed by this many days after the due
  date and is released as soon as payment is made. Manual credit hold (checkbox on the customer) is independent.
  See G-62 for the warning/stop behaviour at authorisation. (The Organization article says "exceeded limit AND
  overdue"; the credit article words it as either condition; see section 11 item 2.)

### G-16 Charge card on file
- Verified: corrected [DOC] https://help.core.cin7.com/hc/en-us/articles/11073350117775-Organization-settings , https://help.core.cin7.com/hc/en-us/articles/12327468731407-Manage-subscription , https://help.core.cin7.com/hc/en-us/articles/11282072728975-Introduction-to-users
- Map: `vTenant.AllowChargeToCardOnFile` (+ `CanEditCardOnFileSetting`). Values: on/off. Default: off.
- Effect: lets the owner and co-owners charge new subscription add-ons to the card on file; monthly plans only
  (monthly subscribers must turn it on to pay for add-ons with their card). (corrected: co-owners can charge
  add-ons too, if they hold the Update subscription and Subscription and onboarding details permissions. Who may
  flip the toggle itself is not stated; the old "owner only" claim is `[INFER]`.) No effect on trading documents.

---

## 2. General settings: Security (tab `tab2`)

Source: https://help.core.cin7.com/hc/en-us/articles/11073340701327-Security-settings

### G-17 Two-factor authentication (organisation level)
- Verified: corrected [DOC] https://help.core.cin7.com/hc/en-us/articles/11073340701327-Security-settings , https://help.core.cin7.com/hc/en-us/articles/9735470581263-Two-factor-authentication-2FA , https://help.core.cin7.com/hc/en-us/articles/11282056119567-Invite-users-and-advisers
- Map: `vTenants.IsTFAEnabled` / `vTenant.IsTFAEnabled`. Values: on/off, set by the account owner. Default: off.
- Effect: when on, every user needs password + authentication code at login. (corrected: the owner or a
  co-owner does **not** reset a user's 2FA in the app; they submit a support ticket. An owner's own reset needs ID,
  business-registration proof and a signed letter. The user then deletes the old token and sets 2FA up again.)
  (added: a brand-new invited user is made to set up 2FA when accepting the invitation, whatever this switch says;
  SSO sign-ins still need 2FA; a passkey sign-in needs neither password nor code.) Per-user setup lives in the
  profile (`vUserData.IsTFAEnabled`, security questions, alternative email). `[INFER]` The security questions and
  alternative email are named only in repo spec; the passkey article calls passkeys an alternative to them.

### G-18 Password change frequency
- Verified: confirmed [DOC] https://help.core.cin7.com/hc/en-us/articles/11073340701327-Security-settings , https://help.core.cin7.com/hc/en-us/articles/11282116268687-Reset-password
- Map: `vTenant.PasswordChangeFrequency` (integer, months). Values: Never | Every month | Every 3 months | Every 6
  months | Every year. Default: Never.
- Effect: the next change date counts from when the current password was *set*, not from when the setting was
  switched on, so old passwords can be due immediately. An expired password forces a change at login.
  (added: password rules are 8+ characters with at least one upper case, lower case, number and special
  character, and must differ from the previous 10.)

### G-19 Session timeout
- Verified: confirmed [DOC] https://help.core.cin7.com/hc/en-us/articles/11073340701327-Security-settings
- Map: `vTenant.SessionTimeout` (integer, minutes). Values: 5, 10, 20, 30, 60 minutes or 12 hours. Default: 60
  minutes.
- Effect: measured from last activity (mouse, click, scroll, key). A warning appears shortly before expiry so the
  user can extend or log out; no response logs the user out. Applies to all users. `[INFER]` The UI lists the
  options 12 hours, 60, 30, 20, 10, 5 and the hint text follows the selected value.

---

## 3. General settings: Financial (tab `tab3`)

Source: https://help.core.cin7.com/hc/en-us/articles/11073339810575-Financial-settings

### G-20 Financial year end (day + month)
- Verified: confirmed [DOC] https://help.core.cin7.com/hc/en-us/articles/11073339810575-Financial-settings
- Map: `vTenant.FinancialYearEndDay`, `FinancialYearEndMonth`. Values: day 1-31, month Jan-Dec. Default:
  `[ASSUME]` 31 December.
- Effect: **none.** Recording only. Do not use it for period reports or lock dates (periods are closed through the
  Financial Periods report, G-26a).

### G-21 Tax calculation basis
- Verified: open [INFER] (no help-center article lists this setting)
- Map: `vTenant.TaxCalculationBasis`; options list `vTaxCalculationBasisOptions` (Code, Name). Default: none.
- Effect: `[ASSUME]` recording only, like the other tax-reporting fields.

### G-22 Tax period
- Verified: confirmed [DOC] https://help.core.cin7.com/hc/en-us/articles/11073339810575-Financial-settings
- Map: `vTenant.TaxPeriod`; options `vTaxCalculationFrequency`. Effect: the frequency used for sales tax; recording
  only. Option values are `[INFER]` (VAT filing is monthly or quarterly for UAE accounts [DOC]).

### G-23 Tax ID number / Tax ID display name
- Verified: confirmed [DOC] https://help.core.cin7.com/hc/en-us/articles/11073339810575-Financial-settings
- Map: `vTenant.TaxNumber`, `TaxNumberDisplayName`. Effect: the organisation's tax reference number and its display
  label; recording only. `[INFER]` Printed on documents via mail-merge fields. No validation.

### G-24 Reverse current year depreciation
- Verified: confirmed [DOC] https://help.core.cin7.com/hc/en-us/articles/11073339810575-Financial-settings
- Map: `vTenant.ReverseCurrentYearDepreciationWhenAssetsAreSold`. Values: Yes | No. Default: `[ASSUME]` No.
- Effect: when a fixed asset is sold or disposed of, depreciation already calculated for the current financial
  year is reversed. Can be changed at any time and only affects sales/write-offs made after the change. `[INFER]`
  Shown only when fixed assets exist.

### G-25 Unrealized foreign currency exchange adjustment
- Verified: confirmed [DOC] https://help.core.cin7.com/hc/en-us/articles/11073339810575-Financial-settings , https://help.core.cin7.com/hc/en-us/articles/9034491249423-Monthly-Closing-Process-Financial-Periods-Report
- Map: `vTenant.UnrealizedForeignCurrency`. Values: on/off. Default: off.
- Effect: when closing a financial period, the unrealised FX adjustment is calculated and journals are created
  automatically. Required for China-based organisations, optional elsewhere. (added: needs an Unrealized Currency
  Gains account created and mapped; the Financial Periods report gains an unrealised column, and the calculation
  must be run before the period can close.)

### G-26 Carry forward P&L calculation
- Verified: confirmed [DOC] https://help.core.cin7.com/hc/en-us/articles/11073339810575-Financial-settings , https://help.core.cin7.com/hc/en-us/articles/9034491249423-Monthly-Closing-Process-Financial-Periods-Report
- Map: `vTenant.CarryForward`. Values: on/off. Default: off.
- Effect: on period close, carry-forward P&L is calculated and journalled automatically; needs Current Year
  Profits mapped to an equity account. (added: opening the period's Carry forward P&L tab runs the calculation
  every time until the period closes; final balances are editable before the journal posts; closing creates the
  special journals.)

### G-26a Closing a financial period
- Verified: added [DOC] https://help.core.cin7.com/hc/en-us/articles/9034491249423-Monthly-Closing-Process-Financial-Periods-Report
- Map: `-` (Financial Periods report: Reports > Financial). Needs the Financial Reports permission.
- Effect: periods can be opened and closed from the report. Closing requires: no draft manual journals (void or
  authorise them), depreciation run for fixed assets, the unrealised-FX process run (if G-25 on), the carry-forward
  process run (if G-26 on). The report shows lock date, open/closed state, accumulated depreciation and realised
  and unrealised FX per period, and generates some manual journals into the ledger itself.

### G-27 Period lock date
- Verified: corrected [DOC] https://help.core.cin7.com/hc/en-us/articles/11073339810575-Financial-settings , https://help.core.cin7.com/hc/en-us/articles/9982508174223-An-Introduction-to-Cost-of-Goods-Sold-COGS , https://help.core.cin7.com/hc/en-us/articles/9034590908175-Xero-Integration-FAQs
- Map: `vTenant.LockDate`; `/me.LockDate` (returned in the tenant date format). Values: date or blank. Default: blank.
- Effect: see section 0 rule 6. Can be changed or removed at any time by users with the permission. With Xero or
  QuickBooks Online the lock date is set there and syncs into Cin7. (corrected/added: a Cin7 value reverts to the
  accounting system's on the next sync; invoices dated before the lock are not updated, so payments made later in
  the accounting system do not come back until the lock is lifted temporarily and a historical load is run. A
  QuickBooks lock also makes Cin7 sync entries fail until skipped.) COGS and shipment dates must fall after it:
  authorising a ship tab whose default date is locked gives an error until a later date is entered.

### G-28 Chart of accounts type
- Verified: corrected [DOC] https://help.core.cin7.com/hc/en-us/articles/11073339810575-Financial-settings , https://help.core.cin7.com/hc/en-us/articles/9034463858831-Accounts-and-Chart-of-Accounts
- Map: `vTenant.ChartOfAccountsType`. Values: Flat structure | Tree structure. Default: Tree for accounts
  without Xero/QuickBooks; Flat (only option) when connected to either.
- Effect: Tree allows sub-accounts. Postings, mapping and journals are allowed only on the bottom-most level;
  parents are summary only and can be picked in the trial balance, balance sheet, P&L, account summary and
  financial payment details reports. Adding a sub-account to an account that has transactions asks for
  confirmation and moves all its transactions to the new child. (corrected: a sub-account inherits parent, type
  and system flag, up to 10 levels are allowed, and an account with transactions cannot be deleted; accounts are
  archived first (status Archived, which also archives sub-accounts), and only unused archived accounts can be
  deleted. The word "deprecated" in the old text applies to tax rules and locations, not accounts.)

### G-29 Account code delimiter
- Verified: confirmed [DOC] https://help.core.cin7.com/hc/en-us/articles/11073339810575-Financial-settings
- Map: `vTenant.ChartOfAccountsTreeDelimiter`. Values: text. Visible only for Tree.
- Effect: separates parent from sub-account names when account names are displayed. `[INFER]` The `.` character
  is not allowed.

### G-30 Accounting dimensions
- Verified: corrected [DOC] https://help.core.cin7.com/hc/en-us/articles/9034429852047-Accounting-Dimensions
- Map: `vTenant.IsAccountingDimensionsEnabled`; tables `vAccountingDimension` (Name1..10, IsActive1..10,
  ListValues1..10), `vAccountingDimensionAttribute`, `vAccountingDimensionsChartOfAccount`. Default: off.
- Effect: lets financial transactions carry up to 10 user-defined dimensions (types List, Text up to 256
  characters, Checkbox) plus master-data dimensions that are always available: customer, supplier, product, company
  contact, expense item and (Advanced Manufacturing) production resource. (corrected: **not available on accounts
  integrated with Xero or QuickBooks Online**; applies to new transactions only, older ones can be edited in an
  open period; a dimension that has been used cannot be deleted; edits are not retroactive.) Each dimension is
  switched on per account in the chart of accounts. Needs the General Settings permission to enable, the Chart of
  Accounts and Mapping permission to assign to accounts and the Financial reports permission for the summary
  report. `[INFER]` The page warning that documents may save more slowly.

### G-31 Accounting dimensions: Reference data priority
- Verified: corrected [DOC] https://help.core.cin7.com/hc/en-us/articles/9034429852047-Accounting-Dimensions
- Map: `vTenant.AccountingDimensionsPriorityMode`. Values: "Can overwrite reference data" | "Cannot overwrite
  reference data". Default: `[ASSUME]` can overwrite.
- Effect: **Can overwrite**: the values pre-filled on the transaction come from its own table and every dimension
  can be changed on the transaction. **Cannot overwrite**: the value comes from the customer/supplier/product
  reference data and can be changed on the transaction only when the reference value is empty. (added: when two
  reference sources clash the winner depends on the transaction: sale = customer over product; purchase = supplier
  over product; production = product over production resource; expense claim = company contact over expense item.)

---

## 4. General settings: Product and measurement (tab `tab4`)

Source: https://help.core.cin7.com/hc/en-us/articles/11073339845135-Product-and-measurement-settings

### G-32 Weight units of measure
- Verified: confirmed [DOC] https://help.core.cin7.com/hc/en-us/articles/11073339845135-Product-and-measurement-settings
- Map: `vTenant.DefaultWeightUnits` (list `vUOMWeight`); `/me.DefaultWeightUnits`. Default: `[ASSUME]` kg (g/lb/oz
  etc. are the alternatives). Effect: the default unit for product weight. `[INFER]` Pre-fills new products and
  cartons and feeds shipping-rate calculations. The directed put-away rule limits read their units from here
  [DOC https://help.core.cin7.com/hc/en-us/articles/9034497973647-Directed-put-away].

### G-33 Dimensions units of measure
- Verified: confirmed [DOC] https://help.core.cin7.com/hc/en-us/articles/11073339845135-Product-and-measurement-settings
- Map: `vTenant.DefaultDimensionsUnits` (list `vUOMDim`). Default: `[ASSUME]` cm. Effect: the default unit for
  product width, length, depth and height. `[INFER]` Pre-fills new products.

### G-34 SKU auto generation
- Verified: confirmed [DOC] https://help.core.cin7.com/hc/en-us/articles/11073339845135-Product-and-measurement-settings
- Map: `vTenant.SkuAutogeneration` plus numbering rows `Stock*`, `Service*`, `FixedAsset*` (Prefix, NextNumber,
  Suffix, `...Changed`). Values: on/off. Default: `[ASSUME]` off.
- Effect: when on, a new stock, service or fixed-asset product gets its SKU from a naming pattern per type and
  can be toggled at any time without touching existing SKUs. `[INFER]` Pattern = `Prefix + NextNumber
  (zero-padded) + Suffix`, the counter advances, and the pattern table appears only when on. When off the user
  types the SKU (must be unique).

### G-35 Update stock received date with transfer completion date
- Verified: confirmed [DOC] https://help.core.cin7.com/hc/en-us/articles/11073339845135-Product-and-measurement-settings , https://help.core.cin7.com/hc/en-us/articles/9034464614415-Costing-Methods
- Map: `vTenant.UpdateStockReceivedDateOnLocationTransfer`. Default: off.
- Effect: with FIFO costing, stock is picked oldest "stock received date" first. Off: transferred stock keeps its
  original date and is still picked first. On: the date becomes the transfer completion date, so un-transferred
  stock (earlier date) is picked first. Lets users push stock to the back of the FIFO queue.

### G-36 Recommend batch/serial no. for FIFO/FEFO
- Verified: confirmed [DOC] https://help.core.cin7.com/hc/en-us/articles/11073339845135-Product-and-measurement-settings
- Map: `vTenant.RecommendBatchSN` (numeric enum). Values: Don't recommend (0) | Recommend and warn (1) | Recommend
  and enforce (2) (numbering `[INFER]`). Default: `[ASSUME]` Don't recommend.
- Effect: applies to sale picking, stock transfers and assembly orders, also in WMS. WMS directs the picker to the
  first-in/first-expired bin. At pick authorisation, if the batch/serial picked is not the first-in or
  first-expired one for the costing method: Warn shows the recommended batch/serial and lets the user keep the
  pick; Enforce shows the same but the user must change the pick. Auto-pick and auto-consume always follow the
  costing method regardless. Manual selection/scan is not blocked.

### G-37 Exclude expired batch/serial numbers
- Verified: confirmed [DOC] https://help.core.cin7.com/hc/en-us/articles/11073339845135-Product-and-measurement-settings
- Map: `vTenant.IgnoreExpiredBatch`. Default: off.
- Effect: auto-pick, batch/serial recommendation and auto-consume for production skip stock whose expiry date has
  passed. Manual selection/scan is not validated.

### G-38 New product description prompt / Rephrase product description prompt
- Verified: corrected [DOC] https://help.core.cin7.com/hc/en-us/articles/11073339845135-Product-and-measurement-settings
- Map: `vTenant.ChatGptPromptForEmptyDescription`, `ChatGptPromptForExistingDescription`. Values: free text with
  placeholders `[ProductName] [ProductDescription] [ForBrand] [ForCategory] [N]` (N = word limit). Default: a
  placeholder prompt supplied by Cin7.
- Effect: (corrected: the prompts are sent to an external AI text service, and the source text comes from the
  product's inventory record.) Feeds the "generate" and "rephrase" actions for short and long descriptions.

---

## 5. General settings: Purchase process customization (tab `tab5`)

Source: https://help.core.cin7.com/hc/en-us/articles/11073310369679-Purchase-process-customization-settings

### G-39 Default purchase method
- Verified: confirmed [DOC] https://help.core.cin7.com/hc/en-us/articles/11073310369679-Purchase-process-customization-settings , https://help.core.cin7.com/hc/en-us/articles/9034465644559-Inventory-Accrual-and-Stock-in-Transit-implementation-GRNI-GINR
- Map: `vTenant.DefaultPurchaseMethod`. Values: Invoice first | Stock first (UI order). Default: `[ASSUME]` Invoice first.
- Effect: the starting method of a new purchase, changeable on each purchase header (API `Approach` `[API]`).
  Stock first is the Goods Received Not Invoiced route and Invoice first is Goods Invoiced Not Received; with
  accrual enabled (G-48) they produce GRNI and stock-in-transit postings respectively. `[INFER]` Invoice first
  orders the tabs Order > Invoice > Stock received, Stock first Order > Stock received > Invoice; "Blind receipt"
  removes the Order tab.

### G-40 Purchase order will use
- Verified: confirmed [DOC] https://help.core.cin7.com/hc/en-us/articles/11073310369679-Purchase-process-customization-settings
- Map: `vTenant.UseLatestPurchaseCost` (true = Latest). Values: Latest supplier price | Fixed supplier price.
  Default: `[ASSUME]` Latest.
- Effect: which supplier price is auto-filled into a purchase line; editable on the line.

### G-41 Purchase documents (sort order)
- Verified: confirmed [DOC] https://help.core.cin7.com/hc/en-us/articles/11073310369679-Purchase-process-customization-settings
- Map: `vTenant.PurchaseDocumentSortOrder`. Values: Order entered | Product SKU | Product name. Default:
  `[ASSUME]` order entered.
- Effect: line order on purchase orders, stock-received documents and invoices. `[INFER]` Screens keep entry order.

### G-42 Minimum before reorder set for
- Verified: corrected [DOC] https://help.core.cin7.com/hc/en-us/articles/11073310369679-Purchase-process-customization-settings , https://help.core.cin7.com/hc/en-us/articles/9034475105167-Low-stock-reorder
- Map: `vTenant.ReorderMode`. Values: All product units | Each location. Default: `[ASSUME]` All product units.
- Effect: **All product units**: Low stock reorder triggers when total quantity across all locations is below the
  product's Minimum before reorder. **Each location**: triggers per location using the product's "Reorder
  levels" rows (Location, Minimum, Reorder quantity); the location's "Allow to reorder stock level" option turns
  reorder on or off for it. Also used by the production "produce difference" calculation and recommended for MRP.
  (added: low-stock reorder needs at least one supplier on the product, needs the Purchases Reorder permission and
  filters by family, tag, category, brand within groups using AND between groups and OR inside a group.) The
  production article names this setting differently (section 11 item 5).

### G-43 Default attribute set (purchase)
- Verified: confirmed [DOC] https://help.core.cin7.com/hc/en-us/articles/11073310369679-Purchase-process-customization-settings , https://help.core.cin7.com/hc/en-us/articles/9034463879055-Additional-Attributes
- Map: `vTenant.PurchaseAttributeSet`; copy flag/source `PurchaseAttributeSetCopyFrom`. Values: an attribute set
  or none.
- Effect: the set's custom fields (up to 10) appear on the Attributes and logs tab of each purchase.
  `[INFER]` A "copy supplier attribute values" checkbox (set must match the supplier's exactly; needs a default set)
  exists for purchases as the help center documents for sales (see G-68).

### G-44 Limit product search by supplier
- Verified: confirmed [DOC] https://help.core.cin7.com/hc/en-us/articles/11073310369679-Purchase-process-customization-settings
- Map: `vTenant.SearchOnlySupplierAttachedProductsInPurchaseLines`. Default: `[ASSUME]` off.
- Effect: when adding lines to a PO only that supplier's products are offered; off shows all products.

### G-45 Use put away
- Verified: corrected [DOC] https://help.core.cin7.com/hc/en-us/articles/11073310369679-Purchase-process-customization-settings , https://help.core.cin7.com/hc/en-us/articles/9034497973647-Directed-put-away
- Map: `vTenant.UsePurchasePutAway`. Default: `[ASSUME]` off.
- Effect: Advanced purchases get a Put away tab after Stock received (receive first, then assign bins). Simple
  purchases are not affected. In WMS, several orders can be received then put away together; off means
  receive-and-store per order. (corrected: directed put-away rules are enabled per **location**, and their
  "Apply directed put away" action sits on the Stock received tab; the help center does not tie them to this
  setting, so that link is `[INFER]`.)

### G-46 Enable archiving + Archive purchase orders older than
- Verified: confirmed [DOC] https://help.core.cin7.com/hc/en-us/articles/11073310369679-Purchase-process-customization-settings
- Map: `vTenant.AllowArchiving`, `PurchaseOrderArchivePeriod`. Values: off/on; period list `[INFER]`: Do not
  archive | 3 months | 6 months | 1 year. Default: `[ASSUME]` off.
- Effect: unauthorised purchase orders without prepayments older than the period are archived and removed from the
  list (an "Archived" filter shows them). An Archive button also appears on any unauthorised order and archives
  immediately. Authorised orders and orders with prepayments are never archived. `[INFER]` Runs nightly. `[INFER]`
  One shared `AllowArchiving` switch drives both the purchase and sale checkboxes.

### G-47 Enable order approval
- Verified: corrected [DOC] https://help.core.cin7.com/hc/en-us/articles/9034494222863-Purchase-Order-Approval , https://help.core.cin7.com/hc/en-us/articles/11073310369679-Purchase-process-customization-settings
- Map: `vTenant.AllowPurchaseOrderApproval`. Default: off.
- Effect: after a PO is authorised it shows Approve / Reject instead of moving on. Approve continues to the next
  tab. Reject makes a rejected PO (read-only, no payments), meant for a PO the supplier turned down. A Review
  button on a rejected PO returns it to Draft. List filters "Awaiting approval", "Rejected" and "All but Rejected
  and Voided" appear. Applies to simple, service and advanced purchases. With the setting off, authorising simply
  turns the PO into an invoice. (corrected: enabling this also enables quote approval, and the sale article says
  the same in reverse. The permission is "Purchase - Approve, reject, and review orders".)

### G-48 Enable accrued inventory transactions (+ GRNI / GINR accounts)
- Verified: confirmed [DOC] https://help.core.cin7.com/hc/en-us/articles/9034465644559-Inventory-Accrual-and-Stock-in-Transit-implementation-GRNI-GINR , https://help.core.cin7.com/hc/en-us/articles/11073310369679-Purchase-process-customization-settings
- Map: `vTenant.InventoryAccrual`, `InventoryAccrualAccount` (GRNI), `StockInTransitAccount` (GINR); lists
  `...InventoryAccrualAccounts`. Default: off.
- Effect: cost is calculated at purchase-invoice authorisation while stock lands at stock-received
  authorisation; with accrual off an invoice with no stock yet inflates the balance sheet. On:
  - **Stock first (GRNI)**: authorising stock received posts Dr Inventory / Cr GRNI at the PO line cost (or the
    product's average cost if the PO has none; additional costs are not included), dated the stock-received date.
    Authorising the invoice posts the reversing amount (negative) at invoice date, then the normal Dr Inventory /
    Cr Accounts payable.
  - **Invoice first (GINR)**: on invoice authorisation, every ASSET-class line account is replaced by the Stock in
    Transit account (also on export to Xero/QBO); on stock authorisation a system manual journal (dated the latest
    stock-received date) moves Stock in transit to the invoice line accounts. Lines can't be re-accounted after
    stock is authorised without Undo.
  - Accrual journals are system manual journals: cannot be deleted by hand, deleted automatically (and voided in
    the linked accounting software) on Undo, and exported to Xero/QBO regardless of manual-journal authorisation.
  - Account rules: GRNI = current asset or current liability, no system account, does not accept payments;
    GINR = current asset, same; both must differ from every other mapped account and from each other. The two
    accounts can be mapped here or in Account Mapping. With accrual off, or a mapping missing, purchasing works as
    if accrual did not exist. Needs the General Settings permission to switch on.

### G-49 Default load advanced purchase order
- Verified: confirmed [DOC] https://help.core.cin7.com/hc/en-us/articles/11073310369679-Purchase-process-customization-settings , https://help.core.cin7.com/hc/en-us/articles/9034461557519-Introduction-to-the-Purchase-Module
- Map: `vTenant.IsDefaultAdvancedPurchase`. Default: off (new purchases are Simple).
- Effect: new purchases (including those from Low stock reorder and backorders) are created Advanced: several
  bills and stock-received actions per PO and several credit notes. A simple purchase can be converted to
  advanced but not back.

### G-50 Add existing attachments to emails
- Verified: confirmed [DOC] https://help.core.cin7.com/hc/en-us/articles/11073310369679-Purchase-process-customization-settings
- Map: `vTenant.AddExistingAttachmentsIntoTheEmail` (single column behind both the purchase and sale checkbox in
  the UI). Default: `[ASSUME]` off.
- Effect: in the purchase email dialog the user can attach files already stored on the product and the supplier.
  The help center treats the purchase and sale versions as two settings (section 11 item 10).

---

## 6. General settings: Sale process customization (tab `tab6`)

Source: https://help.core.cin7.com/hc/en-us/articles/11073350145935-Sale-process-customization

### G-51 Assign invoice number
- Verified: corrected [DOC] https://help.core.cin7.com/hc/en-us/articles/11073350145935-Sale-process-customization , https://help.core.cin7.com/hc/en-us/articles/9034589736463-ShipStation-Custom-Store , https://help.core.cin7.com/hc/en-us/articles/12119914011791-Xero-settings
- Map: `vTenant.InvoiceNumberTimePoint`. Values: On sale creation | On invoice authorization. Default: not
  documented; `[ASSUME]` On invoice authorization.
- Effect: **On creation**: an invoice number is allocated the moment the sale is created. **On authorization**:
  no number until the invoice tab is authorised. (added: a sale needs an invoice number to sync to ShipStation, so
  that integration needs "On creation"; a sale invoice number must be unique in the organisation and a purchase
  invoice number unique for its supplier.) `[INFER]` The `INV-` prefix and that cancelled sales burn numbers.

### G-52 Default sale tax rule
- Verified: confirmed [DOC] https://help.core.cin7.com/hc/en-us/articles/11073350145935-Sale-process-customization , https://help.core.cin7.com/hc/en-us/articles/9034574221071-Tax-rules
- Map: `vTenant.DefaultTaxationRule` (list `vTenantTaxationRule`); `/me.DefaultSaleTaxRuleId/Name` `[API]`.
  Values: any active tax rule or blank.
- Effect: pre-fills the Tax rule field on new customers only (the field may stay blank); changeable per customer
  and per sale. The customer's rule then pre-fills the sale header (section 0 rule 2). Tax rule is mandatory on a
  sale/purchase header and on customer/supplier records.

### G-53 Available quantity is limited to
- Verified: confirmed [DOC] https://help.core.cin7.com/hc/en-us/articles/11073350145935-Sale-process-customization , https://help.core.cin7.com/hc/en-us/articles/9034539220879-Picking-stocks
- Map: `vTenant.PickFromAllLocations`. Values: All locations | Selected location only. Default: `[ASSUME]` Selected
  location only.
- Effect: **Selected location only**: availability shown on the sale and the ability to authorise/pick counts only
  stock at the header's location. **All locations**: availability sums all locations; at pick the system takes
  stock first from the header location, then other locations (respecting the costing method); if still short the
  sale stays at Picking until stock arrives. Not applied to the B2B portal (location comes from portal
  settings). Auto-assembly is always limited to the sale location. [DOC https://help.core.cin7.com/hc/en-us/articles/11952177561743-Auto-assembly]

### G-54 On order authorization auto-assemble
- Verified: corrected [DOC] https://help.core.cin7.com/hc/en-us/articles/11952177561743-Auto-assembly , https://help.core.cin7.com/hc/en-us/articles/11073350145935-Sale-process-customization
- Map: `vTenant.FGProduce`. Values (all three, exact formulas):
  1. Quantity required: assemble = ordered qty; ignores stock and settings.
  2. Quantity required and maintain minimum stock level quantity: assemble = ordered qty - (minimum before
     reorder + reorder quantity + on order - available); a negative available is included.
  3. Difference between available quantity and quantity required to cover a shortage: assemble = ordered qty -
     available - on order.
  Default: `[ASSUME]` Quantity required.
- Effect: applied when a sale containing a product flagged Auto-assembly is authorised. Never creates a partial
  assembly; if components are missing at the sale location, nothing is assembled and the user is offered
  Backorder. Re-authorising after Undo uses the new authorisation date. (corrected: the parent product's costing
  method must be FIFO, FIFO batch, the special-FIFO variant the article lists, or Special batch; the old "FIFO
  family" wording would wrongly admit serial and FEFO methods. Added: assembly covers the order first, then any
  negative stock if the formula says so; components and wastage cannot be adjusted by hand; a backorder lists the
  missing components on the Out-of-Stock Components report, and after receiving them the sale is undone and
  re-authorised; e-commerce integrations have their own "Process auto-assembly as" setting: ordered quantity, or
  the minimum needed for picking.)

### G-55 Split auto-assembly products in sale orders
- Verified: confirmed [DOC] https://help.core.cin7.com/hc/en-us/articles/11073350145935-Sale-process-customization
- Map: `vTenant.SplitAutoAssembly`. Default: off.
- Effect: when "Split order" is chosen at authorisation (partial stock), off = auto-assembled lines get 0 in the
  shippable order; on = a partial assembly is made for what the components allow (example: ordered 10, 5
  assemblable, so 5 ship).

### G-56 Sale documents (sort order)
- Verified: confirmed [DOC] https://help.core.cin7.com/hc/en-us/articles/11073350145935-Sale-process-customization
- Map: `vTenant.DocumentSortOrder`. Values: Screen order | Alphabetical (name) | Alphabetical (SKU) | Stock
  location, custom attributes and screen order. Default: screen order.
- Effect: line order on sale documents (quotes, orders, pick/pack slips, invoices; documents only). The fourth
  option sorts by Location:Bin, then store locator (when bin blank and one location), then attributes 1..n, then
  screen order, all alphanumerically.

### G-57 Set invoice date
- Verified: confirmed [DOC] https://help.core.cin7.com/hc/en-us/articles/11073350145935-Sale-process-customization
- Map: `vTenant.FillInvoiceDateOnOrderAuthorisation`. Values: When invoice authorized | When order authorized |
  When shipment authorized. Default: `[ASSUME]` When invoice authorized.
- Effect: the moment the invoice date field is auto-filled. The next setting decides which date is used.

### G-58 Default invoice date
- Verified: corrected [DOC] https://help.core.cin7.com/hc/en-us/articles/11073350145935-Sale-process-customization
- Map: `vTenant.FillInvoiceDateOption`. Values: `[INFER]` Current date | Sale order date | Sale shipment date.
  Default: `[ASSUME]` Current date.
- Effect: which date is auto-filled (G-57 decides when). (corrected: the help center describes this setting as a
  choice between the invoice-authorisation, order-authorisation or shipment-authorisation date, i.e. the same
  three events as G-57, not as "current date"; the labels above come from the repo UI.) The invoice date is the
  financial posting date for revenue and receivable, so it fixes which period the sale lands in; choosing it to
  match the ship date aligns financial and COGS transactions. Still open: section 11 item 7.

### G-59 Default shipment date
- Verified: corrected [DOC] https://help.core.cin7.com/hc/en-us/articles/9982508174223-An-Introduction-to-Cost-of-Goods-Sold-COGS , https://help.core.cin7.com/hc/en-us/articles/11073350145935-Sale-process-customization
- Map: `vTenant.DefaultShipDate`. Values: Invoice date | Current date. Default (doc): Current date (the date the
  ship tab is authorised).
- Effect: COGS transactions are dated with the ship date. "Invoice date" aligns COGS with the sale invoice
  authorisation date. The user can overwrite with any date (including past) except inside a locked period. Ship
  must still be authorised to create COGS (COGS is 0 until then). Dropship lines have no ship tab; COGS is created
  at purchase-invoice authorisation using the purchase invoice date. (added: COGS is the actual cost of the item
  picked, taken from its authorised purchase invoice; if stock is shipped before that invoice is authorised the
  COGS shows 0 and updates, dated by the purchase invoice, when the invoice is authorised; later cost events such as
  manual journals or landed costs add a new COGS transaction rather than editing the old one, dated the ship date
  if created before shipping and the journal's effective date if created after. Average cost is for reference only
  and never drives COGS or P&L.)

### G-60 By default, quote is
- Verified: confirmed [DOC] https://help.core.cin7.com/hc/en-us/articles/11073350145935-Sale-process-customization
- Map: `vTenant.SkipQuote`. Values: Skipped | Visible. Default: `[ASSUME]` Visible (UI lists Skipped first).
- Effect: a new sale either starts on the Order tab (quote skipped) or on the Quote tab. Per-sale override; API
  `SkipQuote` `[API]`.

### G-61 Picking is / Packing is / Shipping is
- Verified: corrected [DOC] https://help.core.cin7.com/hc/en-us/articles/11073350145935-Sale-process-customization , https://help.core.cin7.com/hc/en-us/articles/10848179032463-Pack-and-ship-an-order
- Map: `vTenant.AutoPick`, `SkipPack` (UI control id `AutoPack`), `SkipShip`. Values: Automatic | Manual each.
  Default: `[ASSUME]` all Manual.
- Effect (chain): **Auto pick** completes and authorises Pick when the order is authorised, only if enough stock
  is available. **Auto pack** completes Pack when pick is authorised. **Auto ship** completes Ship when pack is
  authorised, which removes stock and creates COGS. None of the three applies to B2B portal sales. For WMS, pick
  and pack must both be Manual. API `AutoPickPackShipMode` `[API]` sets the same mode per sale. (added: shipping
  needs pick and pack authorised and **no open stocktake in the shipping location**; the pack step defaults to a
  single box; each box can take its own carrier, tracking number and ship date; the column polarity is section 11
  item 3.)

### G-62 Customer credit limit
- Verified: corrected [DOC] https://help.core.cin7.com/hc/en-us/articles/9034450723215-Credit-limits-and-holds , https://help.core.cin7.com/hc/en-us/articles/9034604405007-User-permissions-explained
- Map: `vTenant.CustomerCreditLimitMode`. Values: `[INFER]` Shows a warning when exceeded | Stops processing when
  exceeded. Default: `[ASSUME]` warning.
- Effect: at authorisation of an order, fulfilment or invoice for a customer on credit hold or whose outstanding
  invoices (overdue ones included) plus this order exceed the limit. **Warning** asks "continue?" and lets any
  user bypass. **Stop** blocks the action unless the user holds the permission to ignore the limit (listed as
  "Sale - Ignore credit limit" in the permission reference and "Sale Task - Ignore Mandatory Credit Limit" in the
  credit article). POS shows the same prompt when a customer on hold is added, and the user can confirm past it.
  (corrected: a credit limit of 0 applies **no** limit; the "cannot be 0" lines in the same article belong to the
  hold and grace-period sections. The two Warning/Stop labels are not in the help center.)

### G-63 Discount rule
- Verified: confirmed [DOC] https://help.core.cin7.com/hc/en-us/articles/11073350145935-Sale-process-customization , https://help.core.cin7.com/hc/en-us/articles/9034464989327-Discounts
- Map: `vTenant.DiscountCalculationMethod`; `/me.DiscountRule`. Values: Updates the sale price | Updates
  discount %. Default: `[ASSUME]` Updates discount %.
- Effect: when a product discount/deal/customer discount applies to a line, either the unit price is changed
  or the Discount % column is recalculated. Discounts must be 0-100%; a mark-up (negative discount, or the
  Markup % / Markup Amount discount types) needs "Updates the sale price".

### G-64 Automatically apply discounts and deals
- Verified: confirmed [DOC] https://help.core.cin7.com/hc/en-us/articles/11073350145935-Sale-process-customization
- Map: `vTenant.AutomaticallyApplyDiscounts`; `/me.AutomaticallyApplyDiscounts`. Default: `[ASSUME]` off.
- Effect: eligible discounts and deals are applied automatically when the sale is authorised; off = users apply
  them manually. `[INFER]` Turning on disables manual price overriding (G-65) and shows a note on the page.

### G-65 Allow manual price overriding on sale quotes and orders
- Verified: open [INFER] (no help-center article describes this checkbox)
- Map: `vTenant.ApplyManualPriceChanges` (UI id `ApplyManualChanges`). Default: `[ASSUME]` on.
- Effect: `[INFER]` only shown when G-64 is on; lets users edit price on lines that have no discount or deal. The
  separate permission "Sale - Change prices and discounts" exists [DOC https://help.core.cin7.com/hc/en-us/articles/9034604405007-User-permissions-explained].

### G-66 Apply customer discount after other discounts
- Verified: confirmed [DOC] https://help.core.cin7.com/hc/en-us/articles/11073350145935-Sale-process-customization
- Map: `vTenant.ApplyCustomerDiscountAfterOtherDiscounts`; `/me.ApplyCustomerDiscountsAfterOtherDiscounts`.
  Default: `[ASSUME]` off.
- Effect: the customer's blanket discount % is applied after product discounts have been applied (an additional
  step). `[INFER]` Compounds on the discounted price instead of competing with it.

### G-67 Recurring invoice price
- Verified: confirmed [DOC] https://help.core.cin7.com/hc/en-us/articles/11073350145935-Sale-process-customization , https://help.core.cin7.com/hc/en-us/articles/9034451864719-Introduction-to-the-sales-module
- Map: `vTenant.RecurringInvoicePriceHandlingMethod`. Values: Copy previous price | Use product price. Default
  (doc): Copy previous price.
- Effect: a generated recurring invoice either copies the unit prices from the last invoice, or re-prices from
  the customer's current price tier or custom price. Recurring sales can repeat weekly, fortnightly, monthly,
  quarterly, half-yearly or annually.

### G-68 Default attribute set (sale) + copy customer attributes
- Verified: confirmed [DOC] https://help.core.cin7.com/hc/en-us/articles/11073350145935-Sale-process-customization , https://help.core.cin7.com/hc/en-us/articles/9034463879055-Additional-Attributes
- Map: `vTenant.SaleAttributeSet`, `SaleAttributeSetCopyFrom`. Same behaviour as G-43 with the customer's set.
- Effect: the set's fields appear on the Attributes and logs tab of a sale. The copy option fills sale attribute
  fields from the customer's; the two sets must match exactly and a default set must be chosen. Off by default; when on it
  applies to simple, advanced and service sales.

### G-69 Show invoice tab before fulfillment tab
- Verified: confirmed [DOC] https://help.core.cin7.com/hc/en-us/articles/11073350145935-Sale-process-customization
- Map: `vTenant.ShowInvoiceBeforeFulfillment` (UI id `SaleShowInvoiceFirst`). Values: Invoice first | Fulfillment
  first. Default: `[ASSUME]` Fulfillment first.
- Effect: swaps the order of the Invoice and Fulfillment tabs on a sale. `[INFER]` Presentation only;
  authorisation prerequisites are unchanged (ship needs pick and pack authorised).

### G-70 Make stock allocation optional
- Verified: confirmed [DOC] https://help.core.cin7.com/hc/en-us/articles/11073350145935-Sale-process-customization
- Map: `vTenant.AllowOrderNoAlloc` (UI id `SaleNoAlloc`). Values: Optional | Mandatory. Default: Mandatory
  (setting disabled).
- Effect: **Mandatory**: authorising the order allocates the whole quantity (reduces Available so it cannot be
  sold or used elsewhere in sales, production or transfers). **Optional**: user may authorise without allocating;
  stock is allocated only at the pick stage. Use for orders fulfilled over a long period.

### G-71 Enable archiving + Archive sale quotes older than
- Verified: confirmed [DOC] https://help.core.cin7.com/hc/en-us/articles/11073350145935-Sale-process-customization
- Map: `vTenant.AllowArchiving`, `SaleQuoteArchivePeriod`. Values: `[INFER]` Do not archive | 3 months | 6 months |
  1 year. Same mechanics as G-46 for unauthorised quotes without prepayments; authorised quotes are never archived.

### G-72 Default new line quantity
- Verified: confirmed [DOC] https://help.core.cin7.com/hc/en-us/articles/11073350145935-Sale-process-customization
- Map: `vTenant.DefaultQuantity` (integer). Default (doc): 0.
- Effect: quantity placed on a newly added quote/order line.

### G-73 Enable quote approval
- Verified: corrected [DOC] https://help.core.cin7.com/hc/en-us/articles/9034557973007-Quote-Approval
- Map: `vTenant.AllowQuoteApproval`. Default: off.
- Effect: same as G-47 for quotes: Approve / Reject / Review after authorising a quote; Approve continues to the
  Order tab; a rejected quote becomes a rejected sale, read-only with no payments. Applies to simple, service and
  advanced sales. Reports (Sale Outstanding, Overview, Order Detail) include rejected sales; list filters as G-47.
  Needs "Sale Task - Quote Approve/Reject/Review" (also listed as "Sale - Approve, reject, and review quote").
  With the setting off, authorising a quote converts it to a sale. (corrected: enabling it also enables order
  approval, per the article.)

### G-74 Default load advanced sale order
- Verified: confirmed [DOC] https://help.core.cin7.com/hc/en-us/articles/11073350145935-Sale-process-customization , https://help.core.cin7.com/hc/en-us/articles/9034450166287-Advanced-Sales-Multiple-Fulfillment
- Map: `vTenant.IsDefaultAdvancedSale`. Default: off (Simple).
- Effect: new sales (and all sales arriving from integrated channels) are Advanced: multiple invoices, multiple
  fulfilments, multiple credit notes per order. Simple to Advanced is one-way. Sale types: Simple, Service (no
  fulfilment, no stock), Advanced. API `Type`, `ServiceOnly` `[API]`.

### G-75 Add existing attachments to emails (sale)
- Verified: confirmed [DOC] https://help.core.cin7.com/hc/en-us/articles/11073350145935-Sale-process-customization
- Map: `vTenant.AddExistingAttachmentsIntoTheEmail`. Lets the user attach files already stored on the product and
  the customer to sale emails. See G-50.

### G-76 Default sales rep is user creating the sale
- Verified: confirmed [DOC] https://help.core.cin7.com/hc/en-us/articles/11073350145935-Sale-process-customization
- Map: `vTenant.UseCurrentUserAsSaleRep`. Default: `[ASSUME]` off.
- Effect: on: the sale's rep is the creating user if that user's email is a company contact of type Sales;
  otherwise the first sales contact alphabetically. Off: the rep comes from the customer record.

---

## 7. General settings: Production process customization (tab `tab7`)

Needs the Advanced Manufacturing add-on. Source:
https://help.core.cin7.com/hc/en-us/articles/11073293006991-Production-process-customization-settings

### G-77 Stock transfer is (Automatic | Manual)
- Verified: confirmed [DOC] https://help.core.cin7.com/hc/en-us/articles/11073293006991-Production-process-customization-settings
- Map: `vTenant.MOIsStockTransferAuto`. Default: `[ASSUME]` Manual.
- Effect: Automatic: when a production order is released, transfer orders are created from the connected
  warehouse (logistics path) to the production location for components that are short. They are completed
  manually on receipt. Manual: user creates them. Automatic suits just-in-time but makes many small orders.

### G-78 Purchase order replenishment is (Automatic | Manual)
- Verified: confirmed [DOC] https://help.core.cin7.com/hc/en-us/articles/11073293006991-Production-process-customization-settings
- Map: `vTenant.MOIsPurchaseOrderAuto`. Default: `[ASSUME]` Manual.
- Effect: Automatic: on release, POs to the production location are created for missing components (needs a
  supplier on the product). Completed manually.

### G-79 Nested production order creation is (Automatic | Manual)
- Verified: corrected [DOC] https://help.core.cin7.com/hc/en-us/articles/11073293006991-Production-process-customization-settings
- Map: `vTenant.MOIsNestedOrderAuto`. Default: `[ASSUME]` Manual.
- Effect: Automatic: production orders for nested components (a component that itself needs a production order)
  are created when the parent is released. (corrected: the old "created with the parent" wording; when orders come
  from a sale the nested ones take the parent's status.) Nested **assembly** orders must always be created manually.

### G-80 Assembly order replenishment / Create production order (from sale)
- Verified: confirmed [DOC] https://help.core.cin7.com/hc/en-us/articles/11073293006991-Production-process-customization-settings
- Map: `vTenant.MOIsFinishedGoodsAuto` (radio "When order is authorized" vs "Via smart reordering / MRP") and
  `vTenant.MOCreateProductionOrder` (select with the same two options). The help center has one toggle, "Create
  production order from sale" (section 11 item 4). Default: `[ASSUME]` Via smart reordering / MRP.
- Effect: "When order is authorized": authorising **or backordering** a sale of a finished product creates a
  production order for it automatically (manual creation, MRP and reorder suggestions are unaffected). This reveals
  G-81 and G-82. Creating many small orders suits just-in-time; draft status or leaving it off suits batching.

### G-81 Set order status to
- Verified: confirmed [DOC] https://help.core.cin7.com/hc/en-us/articles/11073293006991-Production-process-customization-settings
- Map: `vTenant.MOCreateProductionOrderStatus`. Values: Draft | Planned | Released. Default: `[ASSUME]` Draft.
- Effect: status of auto-created production orders. Draft: no resources or components allocated, release by hand.
  Planned: resource capacity planned and allocated, components not allocated, release by hand. Released: capacity
  and stock components allocated and the order appears on the Scheduler.

### G-82 On order release produce
- Verified: confirmed [DOC] https://help.core.cin7.com/hc/en-us/articles/11073293006991-Production-process-customization-settings
- Map: `vTenant.MOProduce`. Values: Quantity required | Quantity required and maintain minimum stock level
  quantity | Difference between available quantity and quantity required to cover a shortage. Default:
  `[ASSUME]` Quantity required.
- Effect: quantity of auto-created production orders: (1) = sale qty; (2) = sale qty + (minimum before reorder +
  reorder quantity - on order - available), using the demand location of the logistics path (the retail
  location's reorder values when it differs from the shop floor); (3) = sale qty - available - on order. Only
  Released orders use these; Draft and Planned always use the sale quantity. On each status change component
  availability is rechecked and the user may update or keep the quantity. Availability uses the product's
  reorder level at the shop floor location, else the product header values, per "Minimum before reorder set for"
  (G-42); the article's wording of that setting differs (section 11 item 5).

### G-83 Waste write off (+ Wastage expense account)
- Verified: confirmed [DOC] https://help.core.cin7.com/hc/en-us/articles/11073293006991-Production-process-customization-settings
- Map: `vTenant.MOWastageType`, `MOWastageExpenseAccount`. Values: Posted to expense account | Included in
  production cost. Default: `[ASSUME]` Included in production cost.
- Effect: expense: waste cost (at the sale price tier chosen in the BOM's Cost of wastage section) is posted to the
  chosen expense account (the "Waste posting account" field, shown only in this mode). Included: waste cost is
  added to production cost and spread across finished products by the sales-value or net-realisable-value method
  chosen on the BOM.

### G-84 Backdated transactions
- Verified: open [INFER] (not described in the production settings article)
- Map: `vTenant.MOBackdatedTransaction`. Default: `[ASSUME]` off.
- Effect: `[INFER]` lets component consumption and finished goods receipt carry a date other than today. `[DOC]`
  Still blocked by the lock date (section 0 rule 6).

### G-85 Co-manufacturing procurement mode
- Verified: confirmed [DOC] https://help.core.cin7.com/hc/en-us/articles/11073293006991-Production-process-customization-settings , https://help.core.cin7.com/hc/en-us/articles/12119885977359-Co-manufacturing-procurement-settings
- Map: `vTenant.MOCoManType`. Values: Sell components - Buy finished products | Transfer components - Buy
  finished product | Purchase components for co-manufacturer - Buy finished products. Default: `[ASSUME]`
  Transfer components.
- Effect: Sell: components sold to the co-manufacturer (a customer record is auto-created for the supplier); they
  own the components, finished cost excludes components. Transfer: components transferred to the co-manufacturing
  location; you keep ownership; finished-product cost includes component cost. Purchase: components dropped from
  supplier to the co-manufacturer, you keep ownership; suited to fully outsourced production.

### G-86 Production component description source
- Verified: open [INFER] (not in the production settings article)
- Map: `vTenant.MOComponentDescriptionSource`. Values: Product description | Product short description |
  Product internal note. Effect: `[INFER]` which product field prints as the component description on production
  documents.

### G-87 Transfer finished products to storage location
- Verified: confirmed [DOC] https://help.core.cin7.com/hc/en-us/articles/11073293006991-Production-process-customization-settings
- Map: `vTenant.MOTransferFinishedProduct` (integer, coding `[INFER]`). Values: Don't transfer | On production
  order completion | On production run completion. Default: `[ASSUME]` Don't transfer.
- Effect: Don't: delivery-location fields on BOM and production order are hidden. Others generate transfer orders
  from the production location to the delivery location (set on the BOM/order, else the logistics path's demand
  location) when the run, or the whole order, completes. Run-level transfers make more, smaller transfer orders.

### G-88 Production order/run, operation and output additional attribute sets
- Verified: confirmed [DOC] https://help.core.cin7.com/hc/en-us/articles/11073293006991-Production-process-customization-settings , https://help.core.cin7.com/hc/en-us/articles/9034463879055-Additional-Attributes
- Map: `vTenant.MOAttributeSet`, `MORunOperationAttributeSet`, `MORunOutputAttributeSet`. Effect: custom fields
  appear on the order (Logs and attributes tab) and run (Attributes tab), on the operation rows (Production run
  tab), and in the output window. Editing them after an operation completes needs "Production orders - Edit
  completed operations".

### G-89 Product tracing
- Verified: confirmed [DOC] https://help.core.cin7.com/hc/en-us/articles/11073293006991-Production-process-customization-settings
- Map: `vTenant.MOTraceFinishedProduct` (integer). Values: `[INFER]` Never traced | Always traced | Optional traced.
  Default: `[ASSUME]` Never.
- Effect: whether component-to-finished-product traceability is recorded for all runs, some, or optionally per BOM.
  Finished product and component both need batch and/or serial costing methods to be traced.

### G-90 Production documents (sort order)
- Verified: confirmed [DOC] https://help.core.cin7.com/hc/en-us/articles/11073293006991-Production-process-customization-settings
- Map: `vTenant.MODocumentSortOrder`. Values: screen order (order added to the BOM) | alphabetical by name |
  alphabetical by SKU. Effect: component order on printed production documents.

---

## 8. General settings: Rounding table, price tiers, numbering, multilingual, gift cards, tooltips, CRM, MRP

### G-91 Rounding table (tab `tab8`)
- Verified: confirmed [DOC] https://help.core.cin7.com/hc/en-us/articles/9034506082063-Pricing-and-price-tiers
- Map: table `vMarkupRounding` (MarkupRoundingID, TenantID, RangeFrom, RangeTo, RoundToNearest, AdjustmentRule,
  AdjustmentValue); flag `vTenant.RoundingTableChanged`; `/me.RoundingTable` (RangeTo, RoundToNearest,
  AdjustmentRule, AdjustmentValue) `[API]`. Default: empty (no rounding).
- Rules: rows are ranges; the first row starts at 0 and each RangeFrom continues the previous RangeTo. Applies only
  to **calculated** (markup %/append) price-tier prices, never to static prices. Steps: find the row whose range
  holds the calculated price; round to the nearest `RoundToNearest` (8.54 with 0.1 gives 8.50); then apply
  AdjustmentRule: No adjustment (default) | Add | Subtract with AdjustmentValue (e.g. round to 1 or 5 then subtract
  0.10 gives 38.87 -> 39 -> 38.90; 137.80 -> 140 -> 139 with a subtract of 1). Edit needs the General Settings
  permission.

### G-92 Sale price tier names (tab `tab9`)
- Verified: confirmed [DOC] https://help.core.cin7.com/hc/en-us/articles/9034506082063-Pricing-and-price-tiers
- Map: `vTenant.PriceTierName1` .. `PriceTierName10`; public `GET /ref/priceTier` `[API]`. Default: `[ASSUME]`
  Tier 1 .. Tier 10 (the UI placeholders "Price tier N"); tier 1 is usually the retail price.
- Effect: only names (up to 10 tiers per product). Values live per product (Prices tab). **Static** price: set
  one value per tier, untouched by currency conversion (so a foreign-currency customer sees the same number in
  their currency). **Calculated**: Markup % or Append over a base: Average cost (default) | Fixed price (most
  recent if several) | Latest price | Price tier value (the tier's own Value used directly; type disabled) |
  Highest fixed price | Highest latest price (these two use suppliers flagged Include in pricing). Worked results
  from the article: 10% on cost 100 = 110; 30% on fixed 50 = 65; append 5 to latest 80 = 85; tier value 150 = 150;
  append 10 to highest fixed 120 = 130; 20% on highest latest 90 = 108. Calculated prices display in base
  currency; supplier foreign prices are converted to base before the markup/append is added, and a foreign-currency
  sale is re-priced at the current rate. The customer carries a tier; the sale header tier overrides it. `[INFER]`
  Blank names hide the tier in pickers.

### G-93 Document numbering (tab `tab10`)
- Verified: confirmed [DOC] https://help.core.cin7.com/hc/en-us/articles/9034465203343-General-settings
- Map: for each document type D: `vTenant.D Prefix`, `D NextNumber`, `D Suffix`, `D Changed`. Types in the map and
  what they most likely number (labels `[INFER]`, see open points): Stock, Service, FixedAsset (SKUs, see G-34),
  PO (purchase order), INV (sale invoice), SO (sale order), Job (job costing task), CR (credit note), ST (stock
  take or stock transfer), TR (transfer), FG (finished goods assembly), FO (fulfilment order), MO (production
  order), WRN (warranty), RMA, RMAReturnOrder, MRP (MRP run), ECR (expense claim receipt), Opportunity.
- Rules: the help center says each transaction document gets an automatic number and the user can set the prefix,
  suffix and starting number. `[INFER]` number = Prefix + zero-padded NextNumber + Suffix, for example `PO-00001`.
  `[ASSUME]` The counter increments per use and cannot be set below the highest used. `[INFER]` The `...Changed`
  flag marks a row the user edited so the save only writes those. Editing a prefix affects new documents only.

### G-94 Multilingual support (tab `tab11`)
- Verified: corrected [DOC] https://help.core.cin7.com/hc/en-us/articles/12327491041935-Language-settings , https://help.core.cin7.com/hc/en-us/articles/9034465203343-General-settings
- Map: `vTenant.IsSupportMultilingual`; `vMultilingualTemplate` (Code, Name, IsDefault); culture list
  `vMultilingualSupportCultureModel`. Default: off.
- Effect: adds a globe icon next to product/customer/supplier names to store names in alternative languages
  (English, Czech, Russian, Chinese Simplified, Chinese Traditional; others via Support). Languages are added as
  rows on the tab. Does not translate system text. Do not change the main language once localised names exist.
  `[API]` Document templates can have per-language variants (`Template.MultilingualTemplateCode`). (added: the
  interface language is a separate per-user choice from the globe icon in the toolbar: English (US), English (UK)
  or Chinese Simplified.)

### G-95 Gift card settings (tab `tab12`)
- Verified: corrected [DOC] https://help.core.cin7.com/hc/en-us/articles/11073306149775-Gift-card-settings , https://help.core.cin7.com/hc/en-us/articles/9034481642895-Gift-Cards
- Map: `vTenant.IsGiftCardEnabled`, `GiftCardAccount`, `CanGiftCardExpire`, `DefaultGiftCardExpirationPeriod`,
  `CanGiftCardRefund`. Defaults: all off.
- Effect: enabling makes a single Gift Card product appear in inventory and shows the gift card liability account
  (current liability, not a system account, accepts payments; it must also be mapped in Account Mapping).
  Expiration on: gift cards get an expiry from the default period, which can be changed or cleared per card.
  (corrected: the Gift Cards article lists only Year, Quarter and Month as default periods; the old "Five years |
  Three years" options come from the repo UI, `[INFER]`, section 11 item 18.) Refund on: unused, whole cards can be
  refunded/cashed in; partial balances cannot. Works in Sales, B2B and POS. (added: a card can only be generated
  when the customer's currency equals base currency; generation is possible in the app and POS, not in the B2B
  portal, but cards redeem there; the Sales Gift Cards permission governs viewing, import, export and forfeit.)

### G-96 Tooltip settings (tab `tab13`)
- Verified: confirmed [DOC] https://help.core.cin7.com/hc/en-us/articles/9982527443471-Tooltips-in-Cin7-Core , https://help.core.cin7.com/hc/en-us/articles/9034465203343-General-settings
- Map: `vTenant.TooltipSections` (text list of enabled sections). Sections `[INFER]`: Supplier details, Product
  details, Stock details, Customer details, Product deals, Alternative products, Sale due details, Customer due
  details, Resource details. Default (doc): all enabled.
- Effect: underlined fields on documents show a hover popup with the record summary and a hyperlink that opens
  the record in a new tab. Each type is switched on or off with its own slider.

### G-97 CRM: Enable opportunity approval (tab `tab14`)
- Verified: confirmed [DOC] https://help.core.cin7.com/hc/en-us/articles/11073310290831-CRM-settings , https://help.core.cin7.com/hc/en-us/articles/9034604405007-User-permissions-explained
- Map: `vTenant.EnableOpportunityApproval`. Default: off.
- Effect: approve/reject/review on opportunities before they convert to a sale; rejected opportunities can be
  reset to Draft; with the setting off, authorising an opportunity converts it to a sale. Needs "Opportunity -
  Approve, reject, and review" (full access to opportunity list and details, and this setting on).

### G-98 MRP: Production demand calculation date (tab `tab15`)
- Verified: confirmed [DOC] https://help.core.cin7.com/hc/en-us/articles/11073292991375-MRP-settings
- Map: `vTenant.MRPProductionDate`. Values: Planned/required by date | Release date. Default: `[ASSUME]`
  Planned/required by date.
- Effect: the date used to time BOM component demand from production orders in an MRP run. "Release date" uses the
  order's release date when it has one, else falls back to required-by. "Planned/required by" uses the planned date
  when the order uses forward capacity planning and the required-by date when backward.

---

## 9. Reference books that act as settings (module 14)

Reference books are grouped under Settings > Reference books in five areas: Your Company, Financial, Default Field
Values, Other Items and Stock. Common to them: CSV export and an Activity Log of who changed what and when.
[DOC https://help.core.cin7.com/hc/en-us/articles/9034511314831-Reference-books]

### R-01 Taxation rules (`/TenantTaxationRule`)
- Verified: corrected [DOC] https://help.core.cin7.com/hc/en-us/articles/9034574221071-Tax-rules , https://help.core.cin7.com/hc/en-us/articles/9034574233871-TaxationRules
- Map: `vTenantTaxationRule` (RuleID, Description, EffectivePercentExclusive, EffectivePercentInclusive,
  EffectivePercent, Inclusive); components `vTenantTaxationRuleComponent` (Name, Percent, AccountCode, Compound,
  ComponentOrder). Public `GET/POST/PUT /ref/tax` `[API]`: Name, Account, IsActive, TaxInclusive, TaxPercent,
  IsTaxForSale, IsTaxForPurchase, Components[]. (corrected: the help-center API page documents only list/view for
  tax rules; writes are `[API]` only. It adds that the rule's Account must be a liability-class account and Name
  is at most 50 characters.)
- Rules: Inclusive/exclusive default for a new rule = **exclusive**; the document header checkbox "Tax inclusive"
  overrides per document and wins over line rules. Status Active (default) | Deprecated; rules cannot be deleted,
  only deprecated, and inactive rules drop out of pickers (CSV import accepting only active rules is `[INFER]`).
  Needs >= 1 component; a component has name, rate, liability account, and Compound flag. A Tax Type from the
  country's list classifies the rule in reports. Simple multi-component: each rate on the base (3%+4%+5% of 50 =
  6.00 tax, 56.00). Compound: later component applies to base + earlier tax (29% then 10% on 50: 14.50 + 6.45 =
  20.95, 70.95). AU/UK/US/NZ accounts start with default rules loaded. With Xero/QBO, rules are created there and
  synced (components, rate, inclusive flag editable and sync both ways); some QuickBooks regions only offer the
  provider's own rates. Effective rate fields are derived. Tax rules can also be set in POS per sale.

### R-02 Payment terms (`/TenantPaymentTerm`)
- Verified: corrected [DOC] https://help.core.cin7.com/hc/en-us/articles/9034511314831-Reference-books , https://help.core.cin7.com/hc/en-us/articles/9034491663759-PaymentTerms
- Map: `vTenantPaymentTermNew` (TermID, Name, Days, Method, DueNextMonth, IsActive, IsDefault); public
  `/ref/paymentterm` (ID, Name, Duration, Method, IsActive, IsDefault) `[API]`.
- Methods and arithmetic (corrected: previously "not documented"):
  - **Number of days** (API `DAYS`): due = invoice date + Duration days.
  - **Day of next month** (API `MONTHDAY`): Duration is the day of the month the payment falls due; Duration 0
    means the last day of the current month.
  - **Last day of next month** (API `LASTMONTHDAY`, Duration ignored): due on the last day of the month after the
    invoice month. Not available for QuickBooks-integrated accounts.
  - **Days since the end of the month**: Duration days are added to the end of the month; 0 means the last day of
    the current month for a created sale, or the first day of next month for recurring invoices.
  - **Date-driven** (QuickBooks accounts only; the DueNextMonth column): due on day `Days` of the month, but if the
    invoice is issued fewer than `DueNextMonth` days before that date the due date moves to the next month
    (Days 20, DueNextMonth 10: invoice on the 5th due the 20th; invoice on the 15th due the 20th of next month).
- Rules: the default for new customers/suppliers is **30 days** [DOC]. `[INFER]` Only one term can be default;
  customers and suppliers must reference an active term by exact name `[API]`. The default term is placed on
  invoices automatically and can be typed over; the due date is the payment term applied to the invoice date.
  Inactive terms can be set. Overdue is judged from the due date (feeds automatic credit hold G-15).

### R-03 Carriers (`/TenantCarrier`)
- Verified: confirmed [DOC] https://help.core.cin7.com/hc/en-us/articles/9034435146511-Carriers , https://help.core.cin7.com/hc/en-us/articles/9034511314831-Reference-books
- Map: `vTenantCarrier` (CarrierID, Description); with shipping services `vTenantCarrierWithShippingOptions`;
  public `/ref/carrier` `[API]`.
- Rules: name plus optional tracking URL; entering a URL appends `[TrackingNumber]` so documents can link to the
  shipment (also used in PDFs, e-commerce channels such as Shopify and for notifying users when a tracking number
  changes). Chosen on the Ship tab per box with tracking number. With a shipping service (ShipStation, Shippit
  etc.) carriers import automatically. Customer/supplier can have a default carrier.

### R-04 Locations and bins (`/TenantLocation`, `/TenantLocationEdit`)
- Verified: corrected [DOC] https://help.core.cin7.com/hc/en-us/articles/9034487246735-Locations , https://help.core.cin7.com/hc/en-us/articles/9034516955791-Location-supply-rules-and-transfer-planning , https://help.core.cin7.com/hc/en-us/articles/9034490412559-Locations-endpoint
- Map: `vTenantLocation` (LocationID, Description, IsDefault), bins `vTenantLocationBin` (BinGroupID), tabs
  supply rule `vSupplyRule`, put-away rule `vPutAwayRule`, bin groups `vBinGroup`, work centres. Public
  `/ref/location`: Name, address, IsShopfloor, IsCoMan, IsStaging `[API]`; the help-center endpoint page adds
  IsDefault, AllowReorder, Bins, FixedAssetsLocation, PickZones and IsDeprecated, with Name up to 256 characters.
- Rules: types Warehouse/retail, Fixed assets (separate from stock locations; not counted in the location
  limit), Shop floor (production, needs Advanced Manufacturing), Co-manufacturing (external). Only one default
  location (auto-set when there is just one); it pre-fills new purchases and sales. Options: Use directed
  receive/put away, Use directed pick (bin groups for WMS), Allow to reorder stock level (switches Low stock
  reorder for that location). A location used in any transaction can only be deprecated, not deleted, and
  deletion needs all quantities (on hand, available, on order, in transit, allocated) at 0. Location permissions
  per user restrict picking, receiving, inventory actions (stocktake, adjustment, write-off) and production
  actions to allowed locations, in WMS and MES too (POS sets its own); others' documents stay visible.
  (corrected/added) Transfer planning (at intervals, all days working, or on fixed weekdays, per demand location)
  and supply rules (Transfer, Produce, Purchase tasks tried in order; a final action if none can run) drive MRP
  suggestions only; orders are always created by a user. A rule applies to all products or to chosen
  families/tags/categories/brands/products (OR inside a group, AND between groups); when several match the
  priority is Family > Tag > Category > Brand and specific beats "all"; two rules cannot have identical product
  parameters. Produce rules need free capacity (assembly ignores capacity) and always add a transfer of the
  finished goods back; Purchase rules pick by lowest price, lowest lead time or latest supplier. Co-manufacturing
  locations only allow transfer and purchase rules and cannot supply other locations.

### R-05 Chart of accounts (`/ChartOfAccounts`)
- Verified: corrected [DOC] https://help.core.cin7.com/hc/en-us/articles/9034463858831-Accounts-and-Chart-of-Accounts , https://help.core.cin7.com/hc/en-us/articles/9034460268815-Charts-of-accounts-and-other-financial-settings
- Map: `vChartOfAccounts` (Code, OldCode, Status, Name, Type, TaxType, Description, Class, SystemAccount,
  BankAccountNumber, CurrencyCode, BankAccountId, ForPayments); lookups `vAccountTypesAndClasses`,
  `vAccountClassTypes`, `vAccountStatusCode`. Actions `FillByDefault`, `Import`.
- Rules: a default chart exists (the Use Default button resets to it); created by Cin7 and always present:
  Accounts Receivable, Accounts Payable, Sales Tax, Sales/Revenue. Read-only when Xero/QBO is connected. Tree vs
  flat per G-28. Required accounts and types: Inventory Control (current asset), Inventory Discrepancy (expense),
  Cost of Goods Sold (expense / direct cost; Cost of Sales - Supplies and Materials on QuickBooks), Default Revenue
  (revenue), Tax Liability (current liability), Work in Progress (current asset), Supplier Deposits (current asset,
  accepts payments), Customer Credits (current liability, accepts payments), In Transit (current asset). Optional:
  Inventory Accrual, Stock in Transit, Realized and Unrealized Currency Gains (expense), Payment Clearing (bank),
  Current Year Profits (equity), Gift Card Liability. Realized Currency Gains is also required for multiple
  currencies. (corrected: statuses are Active and Archived; archive before delete; Delete unused archived accounts
  is a bulk action; Tax Liability is shown as "Liability" in one article and "Current Liability" in the other, so
  accept either liability type; accounts can be imported and exported by CSV. In a QuickBooks account every
  product maps to an account and QuickBooks overrides the Cin7 revenue mapping.)

### R-06 Account mapping (`/AccountMapping`)
- Verified: confirmed [DOC] https://help.core.cin7.com/hc/en-us/articles/9034460268815-Charts-of-accounts-and-other-financial-settings , https://help.core.cin7.com/hc/en-us/articles/9034463858831-Accounts-and-Chart-of-Accounts
- Map: `AccountsMapping` fields `[API]`: InventoryControlAccount, CostOfGoodsSoldAccount, DefaultRevenueAccount,
  TaxLiabilityAccount, PurchasePrepayment, SalePrepayment, InventoryAccrualAccount, StockInTransitAccount,
  InventoryDiscrepancyAccount, GiftCardAccount, WipAccount, TransferInTransitAccount, CurrentYearProfitsAccount,
  UnrealisedCurrencyGainAccount, RealisedCurrencyGainAccount, PaymentClearingAccount.
- Rules: mappings are one-to-one to accounting-system accounts. The system works with gaps until a function that
  needs the account is used, then errors. Accrual and gift-card rows appear only when those settings are on
  (G-48, G-95). In a tree chart only bottom-level accounts can be mapped. Needs "Financial - Chart of accounts and
  mapping" full access. Reference books page: Settings > Reference books > Financial > Account Mapping. With Xero,
  plan the whole chart before connecting; remapping many codes at once afterwards can lock the organisation for hours.

### R-07 Default field values (`/DefaultFieldValues/Product|Customer|Supplier`)
- Verified: confirmed [DOC] https://help.core.cin7.com/hc/en-us/articles/9034451009935-Default-field-values-for-new-products-customers-and-suppliers
- Map: pages' field settings; values come from the `core` tables they reference.
- Product defaults: Type (default Stock; Stock, Service, Gift Card, Non-Inventory, Fixed Asset), Fixed Asset
  Type, Category, Brand, Costing Method (default FIFO), Unit of Measure, Drop Ship (No | Optional | Always),
  Product Discount, Default Location, Additional Attribute Set, "I am selling this product" (default Yes; CSV
  imports use it when Sellable blank). Fields shown depend on type: Stock and Non-Inventory show all but Fixed Asset
  Type, Fixed Asset shows all, Service and Gift Card show fewer (the article's table is garbled; `[INFER]` Service:
  category, brand, discount, location, attribute set, selling; Gift Card: category, brand, unit, attribute set,
  selling).
- Customer defaults: Currency (the creating user's base currency), Sale Account, Tax Rule, Payment Term (30 days),
  Account Receivable, Sale Price Tier, Sales Representative, Default Carrier, Default Location, Attribute Set.
- Supplier defaults: Currency, Default Carrier, Tax Rule, Payment Term (30 days), Account Payable, Attribute Set.
- Rules: pre-fill new records created in the app and customers created by integrations (Amazon, eBay, Magento,
  ShipStation, Shopify, WooCommerce). Editable afterwards. Only admins/owners or users with the "Configure default
  values" permission see the section (off for regular users by default).

### R-08 Costing method (a product field, listed here because new-product defaults depend on it)
- Verified: corrected [DOC] https://help.core.cin7.com/hc/en-us/articles/9034464614415-Costing-Methods
- Methods: FIFO, FIFO - Serial Number, FIFO - Batch, FEFO - Serial Number, FEFO - Batch, Special - Batch, Special
  - Serial Number. Default FIFO.
- Rules: set per product, not per tenant. FIFO "in" date = the stock-received **Date received** field, not the
  authorisation date. Serial/batch variants make the batch/serial mandatory at Stock received and at Pick. FEFO
  needs an expiry date and auto-generates a batch if none is given (Special does too). Special lets the picker
  choose any batch/serial regardless of date. A non-serial product cannot change to a serial method once it has
  transactions (switching FIFO to a batch method is allowed and asks for a batch for stock that has none).
  Changing costing mid-transaction is a known source of errors; revert it to finish the transaction. COGS is
  assigned at ship, cost at purchase-invoice authorisation. (added: Cin7 does not enforce unique serial numbers;
  a bulk costing-method change exists as an Export/Import on the products list; needs the Products and families
  permission.)

### R-09 Shipping zones (`/TenantShipZone`)
- Verified: confirmed [DOC] https://help.core.cin7.com/hc/en-us/articles/9034573853967-Shipping-Zones
- Map: `vTenantShipZone` (ZoneID, Name, IsRestZone, ShortDesc, PricesInclTax, DefaultShippingCost, Negative,
  TaxRuleID), `vShipZoneApplyTo` (Country2, StateID, PostCodeFrom, PostCodeTo, PostCodesList, ShippingRate).
- Rules: master toggle Enabled/Disabled. Zone types: regular, Rest of World (fallback), Exception (only once a
  Rest-of-World zone exists; matching address gets no rate). Each zone has a tax rule. A zone needs at least one
  country row; only Country and Shipping Rate required. Price- and weight-based rates optional. Zones can be
  imported and exported by CSV (zone types `ShippingZone`, `RestWorldZone`, `ExceptionZone`). Used to compute
  shipping automatically for customers; requires the B2B integration.

### R-10 Units of measure (`/TenantUnitOfMeasure`)
- Verified: confirmed [DOC] https://help.core.cin7.com/hc/en-us/articles/9034463961231-Additional-Units-of-Measure , https://help.core.cin7.com/hc/en-us/articles/9034511314831-Reference-books
- Map: `vTenantUnitOfMeasure` (UnitOfMeasureID, Unit); public `/ref/unit` `[API]`. Rules: free list of names.
  "Additional units of measure" on a product (case of 12 etc.) auto-assemble at sale authorisation and
  auto-disassemble at stock receipt; each additional unit is its own SKU with the same costing method; the base
  product (smallest unit) cannot also carry an auto-assembly BOM. The default measurement units for the store are
  a separate setting (G-32, G-33).

### R-11 Other reference lists
- Verified: confirmed [DOC] https://help.core.cin7.com/hc/en-us/articles/9034511314831-Reference-books , https://help.core.cin7.com/hc/en-us/articles/12327495978767-Company-and-contact-settings
- Product categories (`vTenantInventoryCategory`) and Brands (`vTenantBrand`): a product has at most one of each;
  tags give extra grouping. Additional attribute sets (`vTenantAttributeSet`, Column1..10; see R-14), Discounts
  (`vDiscount`, `vDiscountLine`), Order routing (`vOrderRouting`: enable + keep routing; e-commerce channels only,
  not Shopify POS), RMA return policies, Lead statuses (custom ones added to defaults), Warranty setup. Each
  "Default" per type is pre-selected on new documents; if several are marked default the first in the list is used.
  Company addresses/contacts and returns settings: R-12 and R-13.

### R-12 Company addresses and contacts
- Verified: added [DOC] https://help.core.cin7.com/hc/en-us/articles/12327495978767-Company-and-contact-settings , https://help.core.cin7.com/hc/en-us/articles/9034511314831-Reference-books
- Map: `vTenantAddress` (Line1/Line2/CitySuburb/StateProvince/ZipPostCode/Country/Type/DefaultForType),
  `vTenantContact` (Name, Email, Type, DefaultForType; sales commission; mailing lists).
- Rules: addresses are billing, shipping or business; the default business and shipping addresses print on
  documents. Contacts are sales, billing, shipping, business or employee, with phone, fax, email, website, mailing
  lists and a sales-commission %. At least one default billing contact must exist: it receives the subscription
  invoice and is the address behind "billing contact" in G-06. Contacts can be reassigned (their leads and
  customers move to another contact). Needs the Your company - Addresses / Contacts permissions.

### R-13 Return and RMA settings
- Verified: added [DOC] https://help.core.cin7.com/hc/en-us/articles/9034460342159-Configure-returns-settings
- Map: `[INFER]` return order settings (receive location, warranty and non-warranty expense accounts, scrap account,
  credit-note creation).
- Rules: needs the RMA add-on and the RMA Setup permission. At least one active return policy must exist and the
  return-order settings must be active before an RMA or return order can start. The return location can be any
  location except fixed-asset, co-manufacturing or deprecated ones. Non-warranty expenses are charged to their
  account and cleared when the customer is invoiced. Credit notes are created either for each received line that is
  authorised, or one note for the whole return order once all lines are authorised (new RMAs only). Reasons for
  return are a free list.

### R-14 Additional attribute sets (`/AttributeSets`)
- Verified: added [DOC] https://help.core.cin7.com/hc/en-us/articles/9034463879055-Additional-Attributes
- Map: `vTenantAttributeSet` (Column1..10).
- Rules: a set holds up to 10 attributes of type List (values separated by commas/semicolons), Text (256
  characters), Checkbox, Numeric (up to 4 dp), Date (organisation date format) or Not Used. One set per product,
  customer and supplier; sets can also be the default for purchases, sales and the three production levels
  (G-43, G-68, G-88). Attributes can be used in workflow conditions.

### R-15 Bins
- Verified: added [DOC] https://help.core.cin7.com/hc/en-us/articles/11321150323727-Bins
- Map: `vTenantLocationBin`.
- Rules: bins are the smallest storage unit and cannot be added to fixed-asset or co-manufacturing locations. A
  bin can be marked Staging (temporary stop for a two-stage transfer; directed put away does not apply to staging
  or deprecated bins). A used bin can only be deprecated, which removes it from WMS. Pick lists in WMS sort by bin
  name alphanumerically (1B before B1). Bins import/export by CSV. Bin groups exist when directed pick is on.

---

## 10. Automation, users, templates, account

### A-01 Users and roles (`/PageAccess`)
- Verified: corrected [DOC] https://help.core.cin7.com/hc/en-us/articles/11282072728975-Introduction-to-users , https://help.core.cin7.com/hc/en-us/articles/11282074309007-Manage-roles , https://help.core.cin7.com/hc/en-us/articles/9034604405007-User-permissions-explained , https://help.core.cin7.com/hc/en-us/articles/11282088612751-Manage-account-ownership
- Map: `vTenantUser` (IsOwner, IsCoOwner, IsLockedOut, IsPending, IsPartner, Roles), `AspnetRole`,
  `vTenantUserPageAccessEdit` (PageID, Category, AllowReadOnly, ReadOnlyAccess, FullAccess),
  `SettingsPermission`.
- Rules: four user types: Account owner (everything incl. lock users, assign co-owners, change owner, roles, special
  permissions, reset 2FA via support, charge card on file), Co-owner (picked by the owner; can authorise support to
  change the owner, charge add-ons; otherwise role-bound), Adviser (partner; fixed full-but-read-only access; not
  counted toward the user limit; invite as many as needed), Regular user. A permission is None, Read-only or Full
  access per area. Multiple roles combine to the highest level. Deleting a role falls back to the user's other
  roles/special permissions. Pending = invited, not accepted (support can resend). Locked users cannot sign in
  but keep their data and can still use other accounts; deleted users lose access but their data is kept for
  audit. (corrected: locking, deleting and role changes are governed by the Settings > Users and roles permission, not
  by ownership alone; changing owner makes the previous owner a regular user.) Permission areas: Audit (Audit
  report, Email log, Login history views), Cloud integration, CRM, Dashboard, Financials, Financing, Fulfillment,
  Inventory, Manufacturing, Purchase, RMA, Sale, Settings (Your company: General settings/Addresses/Contacts;
  Financial: Chart of accounts and mapping, Taxation rules, Payment terms; Stock: categories, brands, locations,
  units, discounts; Other items: carriers, shipping zones, attribute sets, lead categories), Users and roles,
  Document and email templates, Export to CSV (button visible but "Not Allowed to Export" without it; import needs
  no permission), Automation, Tasks, Subscription. Sale and purchase have a View + Authorize pair per step (quote,
  order, pick, pack, ship, invoice/credit note; order, stock received, invoice), plus Undo, Void,
  Approve/Reject/Review, Change prices and discounts, Ignore credit limit, Edit authorized documents.

### A-02 Document and email templates (`/Template`)
- Verified: confirmed [DOC] https://help.core.cin7.com/hc/en-us/articles/9034490726415-Introduction-to-document-and-email-templates
- Map: `Template` (TemplateID, Type, Name, ThumbnailPath, IsNew, IsDefault, Process, EmailTemplateID,
  EmailSubject, MultilingualTemplateCode, EmailTypes, MailingList, CustomEmail), `vTemplate`.
- Rules: sections Purchase, Sale, Inventory, POS, Production, CRM, Financial. Each document type has a default
  Word template (.doc/.docx, mail-merge fields; every TableStart needs a matching TableEnd). A document can also
  have an email template (body) plus subject and default recipients; **by default no document has an email
  template**, so email body and subject are blank. `[API]` Customers and suppliers can have default templates per
  type (`CustomerDefaultTemplate`, `SupplierDefaultTemplate`). Needs Documents & Email Templates permission (read:
  download; full: upload/reset/set subject lines).

### A-03 Notifications, mailing lists, reminders, workflow (Automation module)
- Verified: confirmed [DOC] https://help.core.cin7.com/hc/en-us/articles/9034471690255-Notifications , https://help.core.cin7.com/hc/en-us/articles/9034471319823-Workflow-automation-overview
- Map: `vNotificationSettings` (IsActive, DeliveryMethods IsInternal/IsEmail/IsExternal, Message, EmailSubject,
  Period, StartExecutionDate, CustomEmail, SendToRelated, SendToSaleRep, TemplateID, MailingListIDs,
  ConditionParameter...), `vExternalNotificationSettings` (IsWebhook, ExternalURL, auth type none/basic/bearer,
  headers), logs `vNotificationExecutionLogInternal/Email/External`, `vMailingList`, `vAutomatedWorkflow`,
  `vWorkflow*`, `TenantRemindersSettings`.
- Rules: each notification has an on/off toggle and per-channel messages (different text per channel). Internal
  goes to every user's notification centre (cannot target one user or group). Email: All active users, All company
  contacts, Send to customer/supplier (default contact or B2B user), BCC list, mailing lists. External: HTTP call
  with JSON key-value body, auth No/Basic/Bearer, custom headers; not all notifications support it. Every send is
  logged per channel. Workflows (modules: Sale, Purchase, Lead, Opportunity) run Event -> Actions with optional
  AND/OR conditions on parameter/condition/value; **a workflow with no conditions applies to all records**; only
  active workflows fire. Needs Automation full access and the Workflow permission.

### A-04 Task settings (`/TaskSettings`)
- Verified: confirmed [DOC] https://help.core.cin7.com/hc/en-us/articles/9034604819343-View-and-Manage-Tasks
- Map: `vTenantTaskSettings` (IsActive, ApprovalEnabled, FirstDayOfWeek, WeekendDays), `vTaskCategory`
  (IsPredefined), `vTenantHoliday` (Date, Description, Skip). Default: tasks module off.
- Rules: module toggle (other tabs appear once on); calendar first day of week (default Sunday) and weekend days;
  non-working holidays (`[INFER]` a "Skip" holiday is skipped when workflow steps count days); optional categories
  with a label colour (predefined ones cannot be edited). Needs the Automation add-on and the Tasks permissions.
  A task has one assignee and any number of observers; completed tasks cannot be edited or moved; Undo returns
  a task to draft, Void is final.

### A-05 User profile and security (`/UserProfile`)
- Verified: corrected [DOC] https://help.core.cin7.com/hc/en-us/articles/11282074322575-Manage-your-profile , https://help.core.cin7.com/hc/en-us/articles/16315692860175-Sign-in-with-a-passkey , https://help.core.cin7.com/hc/en-us/articles/11282074371855-Single-sign-on-SSO
- Map: `vUserData` (IsTFAEnabled, TFAAlternativeMethod, security questions), `vUserPasskey`,
  `vUserLoginHistory`.
- Rules: per-user password change, 2FA setup (organisation toggle G-17), passkeys (added/removed in the profile
  with a name, creation date and last-used date), a change of display name (which can retroactively relabel
  mail-merge output), the list of organisations the user belongs to, and login history. (corrected: the profile
  shows the **last 10** attempts with timestamp, country and organisation, no IP; the separate Login History
  report permission shows date, user name and IP for the whole account.)

### A-06 Subscription, referral and data reset (`/MySubscription`)
- Verified: corrected [DOC] https://help.core.cin7.com/hc/en-us/articles/12327468731407-Manage-subscription , https://help.core.cin7.com/hc/en-us/articles/9034544569359-Referral-Credit-Program
- Map: `vPaymentHistory`, `vReferrals`, `vTenants` (PlanType, IsExpired, ExpirationDate).
- Rules: plan and add-on selection gates features (section 0 rule 8). (added from the help center: billing is
  monthly or annual; the invoice goes to the default billing contact; an unpaid invoice makes the account
  read-only, and after 6 weeks of non-payment the account is permanently cancelled; add-on changes take effect
  immediately with a pro-rated charge and no refund on removal; cancelling keeps full access to the end of the paid
  period and then 6 weeks read-only; referral credit is 10% of the new subscriber's fee and they get 10% off for 6
  months; permissions: Subscription and onboarding details, Update subscription, Payment history, Change billing
  address.) `[INFER]` "Transactional data reset" deletes purchases, sales, stock adjustments, stocktakes etc. and
  keeps products, suppliers, customers, integrations and reference data. "Full data reset" also deletes products,
  suppliers, customers, jobs, discounts and deals, but keeps Settings -> reference books (except discounts/deals),
  templates and documents. Both need the owner to type a confirmation word and re-enter the password (repo UI spec
  only). `[DOC]` The base currency can only change when no transactions exist (G-03), which is what deleting the
  data restores.

### A-07 Account security features and audit trail
- Verified: added [DOC] https://help.core.cin7.com/hc/en-us/articles/9982494462351-Systems-Auditing-in-Cin7-Core , https://help.core.cin7.com/hc/en-us/articles/11282074371855-Single-sign-on-SSO , https://help.core.cin7.com/hc/en-us/articles/11282116141967-I-can-t-log-in-to-Cin7-Core
- Map: `-` (reports and sign-in screens).
- Rules: sign-in options are password + authenticator code, SSO (Xero, Intuit, Google or Microsoft; the SSO email must
  match the Cin7 user and 2FA must already be set; Google and Microsoft also work in POS, WMS and MES) and passkeys.
  Forgotten passwords are self-service from the login screen. The Audit Report (Reports > Audit) lists every
  action, including API changes and settings changes, with old and new values, 30 days by default, filterable by
  category and user, and limited to the modules the viewer can access; it needs "Can see User Audit Report", and
  each document has its own Activity Log (needs that module's list permission). Notification sends are logged
  per notification.

---

## 11. Unclear / docs disagree

Everything the full help center resolved has been moved into the entries above and struck from this list. What
follows is only what is still open, and why. (Resolved in this pass: credit limit of 0, credit limit mode vs bypass,
approval coupling, account type labels, payment-term arithmetic, decimal-place default, `/Me` date formats, defaults
that are now documented, country editability, help-center drift.)

1. **Defaults for a brand-new account**: documented defaults are session timeout 60 min, password change Never,
   tooltips all on, recurring invoice Copy previous price, tax rule exclusive, payment term 30 days, product
   type Stock, costing FIFO, selling Yes, default new line quantity 0, tree CoA when standalone, ship date current
   date, decimal places 2, accounting dimensions off, copy-customer-attributes off, stock allocation mandatory,
   tasks first day Sunday, credit-hold grace none. Every other `[ASSUME]` default is still a guess.
2. **Automatic credit hold trigger**: the Organization article requires the limit to be exceeded *and* an overdue
   payment; the credit-limits article words it as the limit being exceeded *or* an overdue payment past the grace
   period, and says the default trigger is the limit breach itself. The Organization wording is used (G-15).
3. **Packing/shipping field polarity**: the help center confirms the Automatic/Manual behaviour and the
   pick > pack > ship chain, but `vTenant.SkipPack`/`SkipShip` polarity (true = automatic) is still read from radio
   labels.
4. **Production "create from sale"**: the help center has one toggle ("Create production order from sale"); the
   map/UI has two columns (`MOIsFinishedGoodsAuto` and `MOCreateProductionOrder`) both carrying the same two
   labels. Their precedence is unknown.
5. **Reorder mode names**: the purchase article says "All product units / Each location". The production article
   calls it "Every location / Product", says Every location sums all locations and Product sums Shop Floor + Retail
   only, which does not obviously match. The purchase-article meaning is used.
6. **Revenue account priority**: the financial-settings article puts order line > product > header >
   customer/supplier; the chart-of-accounts article puts order line > sales channel > product > customer > order >
   general settings. Section 0 rule 3 states both.
7. **Invoice date wording**: "Set invoice date" (when) and "Default invoice date" (which date) are described in the
   article with the same three events (order, invoice or shipment authorisation) for both. The labels "Current
   date / Sale order date / Sale shipment date" are repo-UI only. What happens when "when shipment authorized"
   meets "Sale order date" is untested.
8. **Document numbering**: default prefixes, zero-padding width and which type each code (ST, TR, FG, FO, MO,
   WRN, ECR, CR) numbers are not documented. Only `PO-00001` and `FG-xxxx`-style samples appear in articles.
   Whether counters can be lowered is unknown.
9. **Negative stock / backorders**: there is **no** tenant setting named "allow negative stock". Authorising a
   sale with too little stock always offers Split order / Backorder / Create purchase order (one supplier per
   purchase order); an under-stocked pick waits in Picking; Available (and on hand, via backdated adjustments or
   stock received dated after the sale) can go negative; auto-assembly formulas handle negative availability.
   Unstock and credit-note voids are blocked when they would make on hand negative. Exact on-hand blocking at ship
   is not documented.
10. **One column, two settings**: `AddExistingAttachmentsIntoTheEmail` and `AllowArchiving` are each one column
    behind a purchase checkbox and a sale checkbox (the second labelled `AllowArchiving2`), yet the help center
    describes purchase and sale versions as separate settings. Whether a real tenant stores one flag is unknown.
11. **CSV date format**: whether CSV import/export of general templates use the display format or ISO is not
    stated (gift-card CSV uses `YYYYMMDD`).
12. **Quantity precision**: the display default is 2 decimals, but how stored quantities and UoM conversions round is
    unspecified (the BOM API allows `QuantityToProduce` up to 10 decimals).
13. **Reference lists**: the full ISO time zone, currency and country lists come from reference endpoints not
    described in the docs. `Country` is fixed after sign-up but the repo model has it as editable text.
14. **Rounding table**: the behaviour when ranges overlap or have gaps, and whether it applies to prices converted to
    a foreign currency, are unspecified.
15. **Period lock vs system-generated entries**: whether accrual journals, depreciation or recurring invoices may
    post inside a locked period is undocumented (the help center only says Cin7 does not create transactions in
    closed periods).
16. **Add-on gating**: the exact UI state of locked pages (hidden vs upsell) is not described;
    `TenantAccessToFeatures` is the endpoint that decides.
17. **Production setting codes**: `MOTransferFinishedProduct` and `MOTraceFinishedProduct` integer codes, and which
    BOM-level flag makes "Optional traced" work, are inferred from label order.
18. **Settings in the repo UI that the help center never describes**: Tax calculation basis (G-21), Allow manual
    price overriding (G-65), Backdated transactions (G-84), Production component description source (G-86), the
    3/6/12-month archive periods (G-46, G-71), the Five/Three-year gift card expiry options (G-95), the
    Xero/QuickBooks warnings on the tax calculation method (G-13), the tooltip section names (G-96), the exact
    numbering of enum values, and who may toggle "Charge card on file" (G-16). All are `[INFER]` or `[ASSUME]`.

---

## Sources

The public Cin7 Core help center was read in full from a local copy (660 articles, plain text; each carries its
title, section, URL and update date). Article URLs are given on the entries; this list names the keys.

- [GS] https://help.core.cin7.com/hc/en-us/articles/9034465203343-General-settings
- [ORG] https://help.core.cin7.com/hc/en-us/articles/11073350117775-Organization-settings
- [SEC] https://help.core.cin7.com/hc/en-us/articles/11073340701327-Security-settings
- [FIN] https://help.core.cin7.com/hc/en-us/articles/11073339810575-Financial-settings
- [PRODSET] https://help.core.cin7.com/hc/en-us/articles/11073339845135-Product-and-measurement-settings
- Purchase: https://help.core.cin7.com/hc/en-us/articles/11073310369679-Purchase-process-customization-settings
- Sale: https://help.core.cin7.com/hc/en-us/articles/11073350145935-Sale-process-customization
- Production: https://help.core.cin7.com/hc/en-us/articles/11073293006991-Production-process-customization-settings
- [MRP] https://help.core.cin7.com/hc/en-us/articles/11073292991375-MRP-settings
- [CRM] https://help.core.cin7.com/hc/en-us/articles/11073310290831-CRM-settings
- [LANG] https://help.core.cin7.com/hc/en-us/articles/12327491041935-Language-settings
- [GIFT] https://help.core.cin7.com/hc/en-us/articles/11073306149775-Gift-card-settings and https://help.core.cin7.com/hc/en-us/articles/9034481642895-Gift-Cards
- [TIP] https://help.core.cin7.com/hc/en-us/articles/9982527443471-Tooltips-in-Cin7-Core
- [PRICE] https://help.core.cin7.com/hc/en-us/articles/9034506082063-Pricing-and-price-tiers
- [CREDIT] https://help.core.cin7.com/hc/en-us/articles/9034450723215-Credit-limits-and-holds
- [COGS] https://help.core.cin7.com/hc/en-us/articles/9982508174223-An-Introduction-to-Cost-of-Goods-Sold-COGS
- [AVAIL] https://help.core.cin7.com/hc/en-us/articles/17647517073295-Calculation-of-Available-On-Hand-and-Allocated-Stock-quantity
- [PICK] https://help.core.cin7.com/hc/en-us/articles/9034539220879-Picking-stocks and
  https://help.core.cin7.com/hc/en-us/articles/10848179032463-Pack-and-ship-an-order
- [LOWSTOCK] https://help.core.cin7.com/hc/en-us/articles/9034475105167-Low-stock-reorder
- [PUTAWAY] https://help.core.cin7.com/hc/en-us/articles/9034497973647-Directed-put-away
- [MULTI] https://help.core.cin7.com/hc/en-us/articles/9034476155279-Multicurrency-and-currency-conversion
- [TAX] https://help.core.cin7.com/hc/en-us/articles/9034574221071-Tax-rules
- [COA] https://help.core.cin7.com/hc/en-us/articles/9034463858831-Accounts-and-Chart-of-Accounts
- [COA-SET] https://help.core.cin7.com/hc/en-us/articles/9034460268815-Charts-of-accounts-and-other-financial-settings
- [CARRIER] https://help.core.cin7.com/hc/en-us/articles/9034435146511-Carriers
- [LOC] https://help.core.cin7.com/hc/en-us/articles/9034487246735-Locations
- [DEFVAL] https://help.core.cin7.com/hc/en-us/articles/9034451009935-Default-field-values-for-new-products-customers-and-suppliers
- [REFBOOKS] https://help.core.cin7.com/hc/en-us/articles/9034511314831-Reference-books
- [NOTIF] https://help.core.cin7.com/hc/en-us/articles/9034471690255-Notifications
- Accrual: https://help.core.cin7.com/hc/en-us/articles/9034465644559-Inventory-Accrual-and-Stock-in-Transit-implementation-GRNI-GINR
- Auto-assembly: https://help.core.cin7.com/hc/en-us/articles/11952177561743-Auto-assembly
- Not-enough-stock flow: https://help.core.cin7.com/hc/en-us/articles/9034471671055-Not-enough-stock-to-complete-sale
- API v2 (via the `cin7-core` map, no credentials): `me get` (`/me`), `payment-term list`, `tax create|list`,
  `location create|list`, `carrier list`, `price-tiers list`, `unit-of-measure list`, `sale create`,
  `purchase create`. Help-center API reference pages used: `/Me`, `PaymentTerms`, `TaxationRules`, `Locations`, `Date Format`.
- Repo: `spec/modules/13-settings/{README,UI}.md`, `schema.sql` (`vTenant`), `spec/modules/14-reference-books/`,
  `spec/data/models.json`, `questions/13-settings.md`.
