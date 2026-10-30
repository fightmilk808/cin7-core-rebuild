# ShipStation integration: business rules (Cin7 Core)

Rules spec for the ShipStation connector of the sandbox. The structure map (page, fields, tables, endpoints) is in `spec/modules/12-integrations/shipstation/` (`README.md`, `UI.md`, `schema.sql`); the page is built in `src/sandbox/modules/m12_apps.py` and `m12_shipping_finance.py`. This file adds behaviour. Sale-side rules live in `rules/sale.md`, `rules/settings.md` and `rules/reference-books.md`. Page-script findings (what the shipped browser code does) are in `rules/shipstation-client.md`.

> Rebuilding the location and fulfilment behaviour? See [docs/LOCATION-FULFILLMENT-TESTING.md](../docs/LOCATION-FULFILLMENT-TESTING.md) for the test matrices and their limits.

Sources: the public Cin7 Core help center, read in full; ShipStation's public API documentation; the repo spec; and the client-script notes in `rules/shipstation-client.md`.

## ⚠️ Gotchas: the sneaky stuff

The surprising, easy-to-get-wrong and silently failing behaviours, worst first. Each links to the section with the full rule. Tags and source keys are explained in section 0 below.

> [!CAUTION]
> **A sale that fails the eligibility rules is skipped with no error, and three channel settings can cause it without anyone noticing.** ShipStation (Custom Store) only pulls a sale when Pack is authorised, the Ship tab has info with a blank Tracking #, and the Invoice tab has a number. A channel set to "No picking" or "Auto pick" never authorises Pack, so its orders are never pulled; an invoice number created later than sale creation does the same; a pre-filled tracking number blocks it until cleared. [DOC S3, S2]
> [Full rule: 4.1 When a sale is eligible](#41-when-a-sale-is-eligible)

> [!CAUTION]
> **The shipping cost is not imported if the invoice is already authorised.** With "Import shipping costs" on, Cin7 adds the carrier cost under Additional Charges only while the invoice is not yet authorised when the cost comes back. A channel whose invoice status is set to Authorised therefore never records the cost, with no error. [DOC S3, S2]
> [Full rule: 7.5 Shipping-line cost handling](#75-shipping-line-cost-handling)

> [!CAUTION]
> **The sale order export filters EXCLUDE what they match.** A row such as Country equals US skips every US order (status Skipped); it does not mean "export only US". Skipped orders were never attempted, and orders skipped by a filter cannot be pushed through Schedule export. And/Or joins form groups. [DOC S2]
> [Full rule: 4.6 Export filters (they exclude)](#46-export-filters-they-exclude)

> [!CAUTION]
> **Cancelling or voiding in ShipStation does not touch the Cin7 sale, and Cin7 does not say it cancels the ShipStation order either.** The help center states the first for Store mode (void the sale by hand). In the other direction a sale voided in Cin7 shows as Canceled in the Shipment log; whether the ShipStation order is cancelled is not documented. [DOC S1, S2], [ASSUME]
> [Full rule: 4.5 Edits, void and undo after export](#45-edits-void-and-undo-after-export)

> [!WARNING]
> **Tracking coming back does not reliably authorise the Ship tab, and stock only moves on Ship authorisation.** Cin7's own Shopify FAQ says ShipStation pushes tracking but does not authorise the shipment; the Custom Store article says the tab is authorised on return. Authorising (or undoing, or voiding) Ship is also refused while a stocktake is open at the location. [DOC S3, S10, S15]
> [Full rule: 7.4 Status the sale gets](#74-status-the-sale-gets)

> [!WARNING]
> **Store-mode order download silently skips orders when tax mapping is unfinished, and daily consolidation throws away the real customer.** Orders are skipped on download until every ShipStation tax type is mapped. With daily consolidation, all orders of the day become one sale on the configured customer and the imported customer, billing and shipping details are ignored. [DOC S1]
> [Full rule: 3.1 Store mode: Setup tab](#31-store-mode-setup-tab)

> [!WARNING]
> **Failed and skipped exports are not retried for you.** They land in the Shipment log and wait for a manual Schedule export after the cause is fixed. Editing a sale after export does not update ShipStation either; the help center describes no live re-sync. [DOC S2], [ASSUME]
> [Full rule: 12. Logs, errors and retries](#12-logs-errors-and-retries)

> [!WARNING]
> **Label printing is domestic only, one label per package, and double labels appear if two modes are on.** Ship-from and ship-to country must match; ShipStation cannot consolidate boxes into one consignment; running Custom Store and Shipping service together prints duplicates. Export from the Shipping service cannot be on while Custom Store is. [DOC S2, S3, S6]
> [Full rule: 1. Modes at a glance](#1-modes-at-a-glance)

> [!WARNING]
> **One Cin7 login for more than one organisation breaks the connection.** Error code 300 (and a 503 in ShipStation) stops data going to ShipStation. The Custom Store is added in ShipStation with a Cin7 user login, not an API key, and that user must belong to a single organisation. Only one ShipStation account can be connected. [DOC S1, S2, S3]
> [Full rule: 2. Connecting, testing and disconnecting](#2-connecting-testing-and-disconnecting)

> [!WARNING]
> **"Export sales fulfilled externally" is about Amazon FBA only.** It does not mean "any sale fulfilled elsewhere". Turn it off to keep FBA sales out of ShipStation; the page-script notes add that the Resend button is hidden on multi-fulfilment sales when it is off. [DOC S2, S3], [CLIENT]
> [Full rule: 3.2 Custom Store tab](#32-custom-store-tab)

> [!WARNING]
> **Unit or currency mismatches give wrong rates with no error, and country codes differ by screen.** Weight units, dimension units and currency must equal Cin7 General settings and the ShipStation account; products need weight and dimensions; rate quotes want a three-letter country code while the export filter wants two. [DOC S2, S4]
> [Full rule: 5. Rate quotes (Shipping service)](#5-rate-quotes-shipping-service)

> [!NOTE]
> **An unmapped location is not skipped; it exports from the default ship-from address.** Easy to assume the opposite. Preferred carriers also do not restrict anything: they only float to the top of pick lists. [DOC S2]
> [Full rule: 8. Store / location mapping](#8-store--location-mapping)

> [!NOTE]
> **Different clocks run at once.** Cin7 checks for new sales to export every ten minutes, syncs shipment information about every fifteen, captures Store-mode orders hourly, and ShipStation decides how often it pulls from a Custom Store. ShipStation dates are PST/PDT and the API allows 40 requests a minute. [DOC S1, S2, S3], [API A1]
> [Full rule: 7.1 Shipping service / Custom Store return path](#71-shipping-service--custom-store-return-path)

## 0. Conventions and source status

Tags (each rule ends with one tag and a source key from section 17):

| Tag | Meaning |
|---|---|
| [DOC] | Stated in a Cin7 Core help-center article, read in full (keys S1 to S4, S6 and S8 to S20 in section 17). |
| [API] | Stated in ShipStation's public API documentation. |
| [CLIENT] | Settled by the shipped page scripts, as recorded in `rules/shipstation-client.md` (static reading, so server behaviour is not covered). |
| [HELP] | ShipStation help centre or a third-party write-up (secondary, treat with caution). |
| [INFER] | Follows from the repo spec (field names, page layout, endpoints) or from combining documented facts; Cin7 does not state it. |
| [ASSUME] | A reasonable sandbox default; the help center truly says nothing. Change freely. |

A `(corrected)` note marks a rule that an earlier version of this file got wrong.

Names: the page shows **three connection modes** and the spec mixes terms. Used here: **Store** (Cin7 pulls ShipStation orders in), **Custom Store** (ShipStation pulls Cin7 orders out through a store defined in ShipStation), **Shipping service** (Cin7 pushes sale orders to ShipStation, with optional rate quotes and labels). [DOC S1, S2, S3]

## 1. Modes at a glance

| Mode | Direction | Where chosen | Main purpose | Src |
|---|---|---|---|---|
| Store ("Connect ShipStation as a Store") | ShipStation orders -> Cin7 sales | Add-new tab, button "Connect ShipStation as a Store" | ShipStation is an order source (use when channels are wired to ShipStation, not to Cin7). Cin7 downloads orders hourly; stock is never synced back; carrier and tracking are not pushed to Cin7, and Cin7 cannot push fulfilment data to ShipStation. Uses the Setup/Catalog/Pending orders/Log tabs. | [DOC S1] |
| Custom Store | Cin7 sales -> ShipStation (ShipStation polls Cin7) | "Custom Store" tab, status switch; Cin7 added in ShipStation as a Custom Store | Recommended when channels are integrated with Cin7. Fulfilment and label printing happen in ShipStation; tracking returns to Cin7. | [DOC S3] |
| Shipping service ("Connect ShipStation as a shipping service") | Cin7 sales -> ShipStation (Cin7 pushes), rates and labels | "Shipping service" tab | Rate quotes, labels printed in Cin7, and optional export of sales (with filters) for fulfilment in ShipStation. Recommended over Custom Store when sales must be filtered before export. | [DOC S2] |

Rules:
- Only **one ShipStation account** can be connected to a Cin7 account. [DOC S1, S2, S3]
- Which modes may coexist (corrected: the old file said only "do not run both"): Store plus Custom Store may be connected together (Cin7 blocks the same order going both ways) but one is recommended; Store plus Shipping service has no problems; **Shipping service with export on and Custom Store cannot both be on**, because Custom Store must be disconnected for export to work, and running both prints double labels. The browser enforces it: switching export on while Custom Store is enabled is refused, and the Custom Store switch is disabled while export is on. [DOC S1, S2, S3], [CLIENT]
- Between Store and Custom Store, data downloaded from ShipStation cannot be exported back through Custom Store, and Custom Store data cannot be downloaded by the Store. [DOC S1, S3]
- Connecting from a Cin7 login linked to **more than one organisation** raises error code 300 (shown as "Multiple Choices Redirect"; a 503 appears on the ShipStation side) and stops data going to ShipStation. [DOC S1, S2, S3]
- ShipStation currency and units must equal the Cin7 base currency and default units (Settings, General settings). The Shipping service tab also has its own units and currency settings (section 5). [DOC S2, S3]
- An External integration licence is required on the subscription (extra ones are bought on the subscription page), and the user needs the Integrations, Shipment - ShipStation permission. (new) [DOC S1]
- Several shipping services can be connected; only the **default** one prints labels ("Set Default" shows only when more than one is connected). [DOC S2, S6]

## 2. Connecting, testing and disconnecting

Steps (no credentials are ever stored in this document):

1. Open Integrations > ShipStation. The page has tabs: Overview, Custom Store, Shipping service, "+" (add new), Help. [INFER spec UI.md]
2. On the "+" tab, form "To connect ShipStation, please specify your API credentials": fields **API key** and **API secret**, both from the ShipStation account's API settings. [DOC S1, S2], [API A1 (V1 uses Basic auth: key as user, secret as password)]
3. Choose a button: "Connect ShipStation as a Store" or "Connect ShipStation as a shipping service". If an account is already connected the tab shows "You are already using a ShipStation account..." and the credential fields are not needed again; each button is hidden once that kind of connection exists. [INFER spec UI.md], [CLIENT]
4. Connecting validates the key/secret against ShipStation (the call fails if they are wrong); success creates the configuration row (`vEcsConfiguration` for Store, `vShipServConf` with `ModuleType` for Shipping service). The page does no blank-value checking itself; the server decides. [INFER spec schema], [CLIENT]
5. **Test connection**: Cin7 has no separate "Test connection" button; the connect click is the test. For Custom Store the test is done by ShipStation when you add Cin7 Core as a store, using a Cin7 user login and password (not the API key); a failure there shows the error 300 text. (corrected: the old file said the Custom Store used details shown on Cin7's tab) [DOC S2, S3], [CLIENT]
6. **Authorisation lost**: when the token/key is revoked a tab "Action required" appears with a reactivation form to re-enter details. [INFER spec UI.md], [CLIENT]
7. **Disconnect**: Store mode and Shipping service each have their own disconnect button and form, with a confirm dialog ("Are you sure you want to disconnect from ShipStation?") (corrected: confirmation is now known). Disconnecting the **Store** removes every association between Cin7 objects and ShipStation, **including the log and the product catalog** (corrected: the old file said logs stay). What disconnecting the Shipping service removes is not documented. [DOC S1], [CLIENT], [ASSUME shipments already created stay]
8. Custom Store extra steps (outside Cin7): switch the Custom Store status to Enabled in Cin7; then in ShipStation, Account Settings > Selling Channels > Store Setup > Connect Store or Marketplace > Cin7 Core, and enter a Cin7 user login and password. That user must belong to one organisation only. [DOC S3]
9. Setup requires the Integrations, Shipment - ShipStation permission (corrected from [ASSUME]). The page script only distinguishes read-only from configure access. [DOC S2, S3], [CLIENT]

## 3. Settings on the page

### 3.1 Store mode: Setup tab

Field names from `UI.md`; storage column in `vEcsConfiguration`. Option lists are from the page scripts. Defaults are documented only where stated; other sandbox defaults are [ASSUME].

| Setting (label) | Control | Allowed values | Default | Effect | Src |
|---|---|---|---|---|---|
| Capture order when it is (`PickWhenOrderStatus`) | dropdown | created, paid, not on hold, shipped | created [ASSUME] | When a ShipStation order is captured; also decides which historical orders a "Load orders" run picks up. | [DOC S1], [CLIENT] |
| Consolidate sales (`ConsolidationType`) | dropdown | **No consolidation** or **Daily consolidation** only (corrected: no other periods) | no consolidation [ASSUME] | No consolidation: each ShipStation order becomes an identical sale with its own customer and addresses, captured once an hour. Daily: all of the day's orders become one sale on the configured Customer, and imported customer, billing and shipping info is ignored. | [DOC S1], [CLIENT] |
| Consolidation time (`ConsolidationTimeText`) | hour dropdown (00:00 to 23:00) | local hour | n/a | Shown only for daily consolidation; the local time at which the day's pending orders are processed. The page stores the UTC hour of the chosen local hour. | [DOC S1], [CLIENT] |
| Customer (`ConsolidateToCustomerID`) | customer lookup | any customer | blank | **Required** for pending-order processing to succeed; the combined sale's customer under daily consolidation. A customer made just for this is fine. Also used where ShipStation gives no customer info. | [DOC S1], [CLIENT] |
| Sale price tier (`PrimaryPriceTier`) | dropdown | tiers 1..n | 1 [ASSUME] | The price tier used when products are downloaded from ShipStation or their details are updated (corrected: not "when the sale is created"). | [DOC S1] |
| Pick, pack, and ship processing mode (`AutoFulfilmentMode`) | dropdown | Draft order; No picking; Auto pick; Auto pick + pack; Auto pick + pack + ship | Draft order [ASSUME] | How far a created sale task is pushed through fulfilment. If stock is short, the pick stays draft and pack and ship are not completed. | [DOC S1], [CLIENT] |
| Ignore restock for non fulfilled sales (`IgnoreRestockForNotFulfilled`) | checkbox | on/off | off (not auto-enabled on purpose) | A refund on an unfulfilled sale otherwise errors on restock and shows in the log as Pending fulfilment. Ticking it edits restock quantities to match what was fulfilled. Only applies, and is only shown, when the mode is Auto pick + pack + ship. | [DOC S1], [CLIENT] |
| Invoice status (`AutoInvoicingMode`) | dropdown | Draft; Authorized (corrected: no "none" option) | **Draft** | Status of the invoice on created sales. Draft waits for authorisation; Authorized authorises it and queues an accounting sync. | [DOC S1], [CLIENT] |
| Optional revenue account (`RevenueAccount`) | account lookup | revenue accounts | blank | Overrides every other revenue-account setting for all sales downloaded from ShipStation. | [DOC S1] |
| ShipStation dimension units (`ECSspecificParameter5`) | dropdown | in, cm | cm [ASSUME] | Must match the ShipStation account's own display setting (Account settings, Display options). | [DOC S1], [CLIENT] |
| Sales representative name (`CustomSalesRepresentative`) | text | any | blank | Lets the shop name be used as the sales rep. | [DOC S1] |
| Match product manually (`ManualMapping`) | checkbox | on/off | off | Off: matched by SKU on Load products (manual links still possible). On: link by hand in the Catalog. | [DOC S1], [CLIENT] |
| Create a new product if not found by SKU (`AutoCreateNewProductAllowed`) | checkbox | on/off | off | Builds the Cin7 product from ShipStation data. Only available when SKU matching is on. | [DOC S1], [CLIENT] |
| Use ShipStation as master source (`UseAsMasterSource`) | checkbox | on/off | off | On catalog download, linked Cin7 products take ShipStation's price, name, weight, size, pictures and other data except SKU. The article warns it can damage product data. | [DOC S1] |
| Shipment is taxable (`ECSspecificParameter7`) | checkbox | on/off | off | ShipStation holds one tax amount; Cin7 taxes per line. Yes spreads tax across lines pro rata and gives Additional Charges a share; No leaves it untaxed (corrected: not a rate on shipping lines). | [DOC S1] |
| Enable order routing (`EnableOrderRouting`) | checkbox | on/off | off | Routes each order to the nearest location by ship-to address; hidden unless the account supports it. | [DOC S1], [CLIENT] |
| Process auto-assembly as (`CreateAssembly`) | dropdown | For ordered quantity; For minimum quantity required for picking (corrected: no "do not create" choice) | per record | Ordered quantity assembles the full order quantity regardless of stock; minimum assembles only the shortfall, and not at all when stock already covers the order. Stock is checked at the sale's location, ignoring on-order quantity. | [DOC S1], [CLIENT] |
| Link ShipStation warehouses to Cin7 Core locations (`vEcsLocationMapping`) | grid + "Load from ShipStation" | one Cin7 location per ShipStation warehouse; one location cannot serve two warehouses | unmapped | Which Cin7 location an order is allocated to. | [DOC S1], [CLIENT] |
| Link ShipStation and Cin7 Core tax rules (`vEcsTaxMapping`) | grid + "Add a US place of business" | ShipStation tax type -> Cin7 tax rule | unmapped | See section 9. **Orders are skipped on download until this mapping is finished.** | [DOC S1] |
| Link ShipStation payment methods to payment accounts (`vEcsPaymentProcessorMapping`) | grid | payment method -> an account that can receive payments | unmapped | Optional. Without it orders still download but payments must be added by hand (some shops reconcile ShipStation payouts instead). With it, payments are always attached to captured orders. (corrected: not strictly a BANK-type rule) | [DOC S1], [CLIENT] |
| Disconnect | button | | | See section 2. | |

Catalog tab: **Load products** (option "Enable image download", slower), **Load customers**, per-row link modal (leave blank / link to an existing product / create a new Cin7 product, the last only when the SKU does not exist). Pending orders tab: **Load orders** (orders created since a date; Cin7 loads at most one year back), **Process**. [DOC S1], [CLIENT]

The setup tab shows a warning marker until a customer is chosen and the tax, location and payment mappings are filled in. [CLIENT]

### 3.2 Custom Store tab

| Setting | Control | Values / default | Effect | Src |
|---|---|---|---|---|
| Custom Store Integration status (`Enabled`) | checkbox | off | Master switch. Disabled while the Shipping service export is on. | [DOC S3], [CLIENT] |
| Use stock locator instead of location as warehouse (`ShipstationUseStockLocator`) | checkbox | off | Sends the product's stock locator, not the sale location, as the ShipStation Warehouse. **Must be off** if you filter in ShipStation on Warehouse Location to keep a channel out. | [DOC S3] |
| Export sales fulfilled externally (`ShipstationExportFFOrders`) | checkbox | off | Controls whether **Amazon FBA sales fulfilled through Cin7's native FBA integration** are exported. Other externally fulfilled sales are not affected (corrected: not "any externally fulfilled sale"). | [DOC S2, S3] |
| Import shipping costs (`ImportShippingCosts`) | checkbox | off | Pulls the carrier cost back (section 7.5). | [DOC S3] |
| Apply tax on shipping costs (`ApplyTaxOnShippingCost`) | checkbox | off | Shown when import is on. | [CLIENT], [INFER] |
| Zero tax (`ShippingCostZeroTaxRule`) | tax rule | blank | Shown when import is on and apply-tax is off. | [CLIENT] |
| Capture ship to company as (`IgnoreBillingContact`) | radio | leave the ship-to company blank (do not fall back to the billing customer), or use the customer name | page default not documented, [ASSUME] use customer name | What goes in ShipStation's ship-to Company when the sale has none. | [DOC S3], [CLIENT] |
| Currency in ShipStation (`CustomStoreCurrency`) | dropdown | account currencies | base currency [ASSUME] | Currency tag on exported amounts. | [CLIENT], [INFER] |
| ShipStation timezone (`ShipStationTimezone`) | stored value (no visible control) | e.g. PST/PDT | PST [ASSUME] | See section 14. | [API A1], [CLIENT] |
| Tasks not ready for ShipStation | grid, search | | Sales that cannot export yet and the reason (typically a missing shipping address). Columns: invoice number, customer, invoice date, ship-by, address, reason. | [DOC S3], [CLIENT] |

Every control on this tab saves the instant it changes; there is no Save button. [CLIENT]

### 3.3 Shipping service tab: Setup

| Setting | Control | Values / default | Effect | Src |
|---|---|---|---|---|
| Integrate with ShipStation | radio | "Export sale orders to ShipStation" / "Without export" (default without) | Master switch for pushing orders. Without export you still get rates and labels. | [DOC S2], [CLIENT] |
| Default ship from address | address picker | the default company address or the default location | Used when a shipping location has no address of its own. (corrected: a fallback, not the only ship-from) | [DOC S2] |
| Use tax rate from | select | Default rule (then pick Tax rule for shipping) / Customer rule | Which tax rule applies to the shipping charge. | [DOC S2] |
| Weight units, Dimension units, Currency in ShipStation | dropdowns | weight g, kg, oz, lb; dimensions cm, in; currency list | Must equal Cin7 General settings and the ShipStation account or rates are wrong. | [DOC S2], [CLIENT] |
| Additional shipping margin + "Margin value is" | number + select (Absolute / Relative) | 0 / Absolute | Added to quoted rates. Relative = percentage (20 means +20%); Absolute = fixed units of the ShipStation currency. | [DOC S2], [CLIENT] |
| Send notification on shipping label generation | checkbox | off | Raises an **internal** notification when a label is generated (corrected: it does not email the customer). | [DOC S2] |
| From contact / From company on shipping label | text | both default to the company name | Printed on labels. | [DOC S2], [CLIENT] |
| Print shipping labels | checkbox | on/off | Allows label generation at the Ship stage. | [DOC S2] |
| Preferred carriers/services | multi-select | carrier+service pairs from ShipStation | Chosen carriers are listed **at the top** of carrier pickers; they do not hide the others (corrected: not a filter). | [DOC S2] |
| Set default | button | | Makes this the default service for labels (one at a time; shown only if more than one service is connected). | [DOC S2, S6], [CLIENT] |
| Export sales to ShipStation store | dropdown | ShipStation stores | Which ShipStation store receives exported orders. | [INFER], [CLIENT] |
| Use stock locator... / Export sales fulfilled externally / Capture ship to company as | as in 3.2 | | Same meanings (FBA-only wording applies here too). | [DOC S2] |
| Import shipping costs / Apply tax on shipping costs / Zero tax | as in 3.2 | | Apply-tax uses the rule chosen in "Use tax rate from"; when off, pick a Zero tax rule. Costs are added only while the invoice is unauthorised. | [DOC S2] |
| Map Cin7 Core Locations to ShipStation Ship From Locations (grid, "Load from ShipStation") | grid | ShipStation ship-from name -> Cin7 location | Sets the ship-from of each exported order. **An unmapped location uses the Default Ship From Address** (corrected: it is not skipped). The same Cin7 location cannot map to two rows. | [DOC S2], [CLIENT] |
| Sale order export filter | rows: parameter / condition / value / join | see 4.6 | Sales that match are **excluded** and logged as Skipped. | [DOC S2] |
| Notifications: recipients for successful export, failed export, and ship of an exported order, plus an "Internal notification" checkbox for each | multi-select + checkbox | none | One email per event type per run, listing the orders with a CSV attached; internal notifications go to everyone in the organisation with a link to the list. No Automation-module subscription needed. (corrected: batching and no subscription need are new) | [DOC S2] |
| Send predefined package dimensions + carriers + height/width/length table | checkbox, multi-select, table | off | Default size used for rate estimates only; real dimensions are entered at ship. Units follow the integration's dimension units. Add only carriers that need dimensions to quote. | [DOC S2] |
| Use default shipping instructions with Domestic/International carrier-service and package | checkbox + 4 dropdowns | off | Pre-fills carrier, service and package on shipments; editable per sale. (The earlier "May 2024" date is dropped: that release note is not in the help center.) | [DOC S2], [CLIENT] |
| Shipment log tab | grid + "Schedule export" | status filter: All, Shipped, Exported, Skipped, Canceled, Failed; period: this/previous week/month/custom | See section 12. | [DOC S2], [CLIENT] |

## 4. Pushing sales to ShipStation (Custom Store and Shipping service)

### 4.1 When a sale is eligible

ShipStation (Custom Store) pulls a sale from Cin7, and the Shipping service export picks it up, when all of these hold (the two articles list identical conditions; the Shipping service export checks for new sales **every ten minutes**):
1. **Pack tab is authorised.**
2. **Ship tab has info and the Tracking # field is blank**; the Ship tab itself may be authorised or unauthorised.
3. **Invoice tab has an invoice number**; the invoice may be authorised or unauthorised.

[DOC S2, S3]

If any condition fails the sale is silently skipped. Causes the help center lists for "orders not getting pulled":
- The channel's pick/pack/ship mode is **No picking** or **Auto pick**, so Pack is never authorised; use **Auto pick + pack**. [DOC S3]
- Invoice number must be created **on sale creation** (Settings, General settings, Sale process customization), or the sale has no number to sync. [DOC S3]
- Invoice status for the channel should be **Draft**, or shipping costs will not come back (section 7.5). [DOC S3]
- Wire channels to Cin7 first, then Cin7 to ShipStation; wiring ShipStation to the channels directly causes data-flow problems. [DOC S3]

Additional rules:
- The Shipping service export also puts **sales it could export but that have a problem** (such as no shipping address) in the Shipment log, and a failed automatic export lands there too, to be exported by hand once fixed. The Custom Store tab's "Tasks not ready" grid shows address failures. [DOC S2, S3]
- For channel-created sales the checks are a valid shipping address with state, ZIP and country, and data in Pick, Pack and Ship (the last tab not necessarily authorised). This older Shopify-FAQ wording is looser than the Pack-authorised rule above; see section 18. [DOC S10]
- A shipping address is required on the sale when the ShipStation integration is on. [DOC S13]
- The Cin7 **Ship by date** becomes the created date of the ShipStation order. [DOC S2]
- Shipping service export is keyed to **shipment authorisation** for manual re-export ("Schedule export" asks for a period of shipment-authorisation dates). [DOC S2], [CLIENT]
- Sales must pass the **sale order export filters** and be at a location (mapped, or falling back to the default ship-from). [DOC S2]
- Amazon Business orders must go out through ShipStation to print their label (API limitation on the ShipStation side). [DOC S12]
- Voided sales are not pushed; a sale voided after export shows Canceled. [DOC S2], [INFER]

### 4.2 Statuses

ShipStation's help maps Cin7 sale states to ShipStation statuses: Cin7 "Awaiting Shipment | authorised draft paid" and "Shipped | shipped". So an eligible sale arrives as **awaiting_shipment** and becomes **shipped** after the shipment returns. [HELP S5]. The ShipStation API itself allows `awaiting_payment`, `awaiting_shipment`, `shipped`, `on_hold`, `cancelled`, `pending_fulfillment`. [API A2]

### 4.3 Field mapping (sale -> ShipStation order)

Cin7 does not publish this table; the help center documents only the few rows marked [DOC]. The rest uses ShipStation's order model (Create/Update Order) and obvious Cin7 equivalents. Treat as the sandbox contract.

| ShipStation order field | Cin7 source | Notes | Src |
|---|---|---|---|
| `orderNumber` (required, max 50) | Customer reference when present, else sale order number | **Sandbox label rule**: `coalesce(nullif(trim(CustomerReference), ''), SaleOrderNumber)`. Cin7 does not say which it sends (the export filter list does offer "Reference" and the log is searched by "SO#"). The `SO-` number is kept in an internal note as a secondary reference. | [API A2], [ASSUME] |
| `orderKey` | Sale TaskID (GUID) | Makes repeat pushes update, not duplicate (section 4.4). | [API A2], [INFER] |
| `orderDate` | Sale **Ship by** date (corrected: the old file used the sale order date) | | [DOC S2] |
| `orderStatus` | `awaiting_shipment` | | [HELP S5] |
| `shipByDate` | Sale "ship by"/required-by date | Suggested value only. | [API A2], [INFER] |
| `customerEmail`, `customerUsername` | Sale contact email, customer name | | [API A2] |
| `billTo` | Sale billing address and contact | | [API A2] |
| `shipTo` | Sale shipping address: name = shipping contact; company per "Capture ship to company as"; street1/2, city, state, postalCode, country, phone | Missing address parts put the sale in "Tasks not ready for ShipStation". Shipping-rate calls want a three-letter country code. | [DOC S2, S3, S4], [API A2] |
| `items[].sku`, `name`, `quantity` | Sale lines (stock products only; service/additional-charge lines are not items) | One ShipStation item per sale line; `lineItemKey` = line id. | [API A2], [INFER] |
| `items[].unitPrice` | Line price after discount | | [API A2], [INFER] |
| `items[].weight` | Product weight (converted by configured weight unit) | Needed for rates. | [API A2], [DOC S4] |
| `items[].warehouseLocation` | Stock locator when "Use stock locator..." is on | Otherwise the sale location is the warehouse. | [DOC S3] |
| `weight`, `dimensions` (order level) | Sum of line weights; dimensions only when predefined package dimensions are set | Real values are entered at label time. | [API A2], [DOC S2] |
| `taxAmount` | Sale tax total | | [API A2], [INFER] |
| `shippingAmount` | Not sent. Cin7's FAQ says it does not pass shipping costs to ShipStation (corrected: the old file mapped the sale shipping charge). | The customer-facing charge stays on the Cin7 sale. | [DOC S10] |
| `amountPaid` / `paymentDate` / `paymentMethod` | Payments received on the sale | | [API A2], [INFER] |
| `requestedShippingService` | Sale carrier / shipping method text | Cin7 passes the provider info; mapping it to a ShipStation provider is done on the ShipStation side. | [DOC S10], [API A2] |
| `carrierCode`, `serviceCode`, `packageCode` | Carrier/service chosen on the sale or the default shipping instructions | | [API A2], [DOC S2] |
| `customerNotes` | Sale Note / Comments | | [API A2], [INFER] |
| `internalNotes` | Sale shipping notes; Amazon Business orders also carry the PO reference here | Sandbox adds the `SO-` number. | [DOC S12], [ASSUME] |
| `advancedOptions.storeId` | "Export sales to ShipStation store" | | [API A2], [INFER] |
| `advancedOptions.warehouseId` | Ship-from mapping of the sale's location | | [DOC S2], [API A2] |
| `advancedOptions.customField1` | Amazon Business orders: Amazon Business order number and PO reference (printed on the label). Other orders: not documented, sandbox sends the sale order number. | | [DOC S12], [ASSUME] |
| `advancedOptions.customField2..3`, `tagIds`, `confirmation`, `gift*` | Not documented; sandbox sends field 2 = sale reference, field 3 blank, no tags, no confirmation or gift flags | | [ASSUME] |

### 4.4 One-time versus repeat

- Under the **Custom Store** model ShipStation asks for orders in date windows (`action=export`, `start_date`, `end_date`, `page`) on its own schedule (set in ShipStation, or triggered by hand with its Custom Store Sync), so a sale can be read again whenever it falls in a window; ShipStation de-duplicates by order number/key. [DOC S3], [API A5]
- Under the **Shipping service** model Cin7 creates the order once per export run and records the result in the Shipment log (Exported). Re-sending is manual: **Schedule export** re-queues failed or flagged sales by shipment-authorisation period (not sales skipped by user filters). The help center does not mention any "Resend to ShipStation" button; it exists only in the page scripts (`PUT /Sale/ResendToShipStation`, `/SaleMultiple/ResendToShipStation`, param TaskID) and shows only when Ship is authorised, no tracking number exists, and, on multi-fulfilment sales, "Export sales fulfilled externally" is on. [DOC S2], [CLIENT]
- Create/Update: ShipStation updates an order only if `orderKey` matches and the order is in `awaiting_payment`, `awaiting_shipment` or `on_hold`; shipped or cancelled orders cannot be updated; no partial updates, the full order must be resent. [API A2]

### 4.5 Edits, void and undo after export

- **Cancelling or voiding in ShipStation does not void the Cin7 sale.** Documented for Store mode, where the sale must be voided by hand (so the sale stays and the log entry remains). The Custom Store and Shipping service articles say nothing, so the sandbox applies the same rule. [DOC S1], [ASSUME for the other two modes]
- **Voiding in Cin7**: the Shipment log row becomes **Canceled** ("voided by user from Cin7"). Whether ShipStation is told is not documented; the sandbox does not call ShipStation. [DOC S2], [ASSUME]
- **Editing a sale after export**: no live re-sync is described. A manual re-export (4.4) sends the full order with the same `orderKey`, which updates ShipStation if the order is still awaiting shipment. [API A2], [ASSUME]
- **Undo** returns a task to draft, keeps all data and does not create duplicates; re-authorise every step afterwards. Undo needs the module's Undo permission and is refused if the stock has been used elsewhere. [DOC S14]
- **Undo or void of Ship** is refused while a stocktake is open at the location, exactly like authorising it. [DOC S15, S9]
- Undoing Ship after a ShipStation shipment returned does not remove the tracking from ShipStation. [ASSUME]
- Reloading a Store-mode order: void the sale (a record stays), delete its log entry, then Load orders from a date before the order (one year maximum). Deleting a log entry does not void or delete its sale. [DOC S1]

### 4.6 Export filters (they exclude)

Filters decide which sales are **skipped**, set on the Shipping service Setup tab. Skipped sales appear in the Shipment log with status Skipped; no export was attempted. There is no limit on the number of filters. [DOC S2]

- Parameters: Sales Channel, Reference, Sales Representative, Comments, Invoice Memo, Carrier, and Ship To contact, company, city, state, postal code, country (two-letter code, for example US), e-mail and phone. [DOC S2]
- Conditions: Equals, Contains, Does not contain, Empty, Not empty. Value is an alphanumeric string (not editable for Empty/Not empty). [DOC S2], [CLIENT]
- Join: And groups rows together; Or separates groups. Example: Country = US And Customer = A Or Customer = B excludes US orders for customer A and every order for customer B. Each row needs a parameter, condition and (except Empty/Not empty) a value before the page will save. [DOC S2], [CLIENT]
- Sales skipped by a filter are not picked up by Schedule export. [DOC S2]

## 5. Rate quotes (Shipping service)

- Button **Get Shipping Rates** on a sale (quote or order stage, simple or advanced sale; shown only when a rate provider or shipping zones are set up): pick ShipStation, then CARRIER and SERVICE in the dialogue; the estimate shows beside each service and the chosen one is added to Additional Charges. [DOC S4, S2, S15]
- Needs a real address (three-letter country code) and **products with weight and dimensions**. Locations need an address too. [DOC S2, S4]
- Predefined package dimensions supply a size when a carrier needs one to estimate; for estimates only. [DOC S2]
- Weight unit, dimension unit and currency must equal Cin7 General settings and the ShipStation account; otherwise rates are wrong. [DOC S2, S3]
- The rate comes in the ShipStation currency and is **converted to the sale currency** if needed (corrected: there is conversion for rates). [DOC S2]
- If the final label rate differs from the estimate, the real cost flows back to the sale. [DOC S4]
- Additional shipping margin is added to the quoted rate (Relative = percentage, Absolute = fixed). [DOC S2]
- On a rate error Cin7 shows a message with a downloadable text file of the error data, and for unexpected errors an email dialog to send it to the provider. [DOC S2, S4]
- Only one shipping service can be selected for the B2B Portal checkout; its methods then show at the shipping-method step. [DOC S2, S4]
- A rate request is a live call to ShipStation's rates API (`POST /shipments/getrates`); the quote is not stored on the sale until chosen. [API A1 (listed)], [ASSUME storage]

## 6. Carrier and service mapping

- Carriers from a connected shipping service are imported automatically into the Carriers reference book (Settings, Reference books, Other items, Carriers), where each can have a tracking URL ending in the tracking number. [DOC S8]
- ShipStation identifies a carrier by `carrierCode` and service by `serviceCode` (for example `stamps_com` / `usps_first_class_mail`). The page stores pairs in `vCarrierServiceList`. [API A3], [INFER spec]
- No user-editable "Cin7 carrier -> ShipStation carrier" matrix exists on the page. Mapping is: (a) the carrier/service selected at the rate dialogue, (b) the default domestic/international shipping + package, (c) otherwise the sale's carrier text goes to `requestedShippingService`, and the provider is mapped on the ShipStation side. [DOC S2, S10], [CLIENT]
- On return, carrier and tracking number are imported automatically onto the Ship tab. How an unfamiliar carrier code is matched is not documented; the sandbox matches by name and stores unmatched text as is. [DOC S8], [ASSUME matching]
- A sale with a blank carrier/shipping service appears under the sales-list filter "Missing Shipping Service". [DOC S17]

## 7. Shipments returning and shipping cost

### 7.1 Shipping service / Custom Store return path

- When a shipment is created in ShipStation, tracking number, carrier and service flow back to the Cin7 sale (Ship tab). [DOC S2, S3]
- In Custom Store mode ShipStation POSTs a shipment notification (`action=shipnotify`) by default when a label is created, with tracking number, carrier and service; marking an order shipped in ShipStation also posts one. ShipStation users can delay these in Custom Store settings. [API A5]
- ShipStation's API lists shipments with `trackingNumber`, `carrierCode`, `serviceCode`, `shipmentCost`, `insuranceCost`, `shipDate`, `voided`, `orderId`, `orderNumber`, `shipmentItems`, `weight`, `dimensions`; only shipments with labels generated in ShipStation are listed (orders marked shipped through the UI/API are external shipments and excluded). [API A3]
- **Timing (resolved)**: Shipping service shipment information syncs about every **15 minutes**; its export check for new sales runs every **10 minutes**; Store-mode orders are captured **hourly**; the Custom Store pull frequency is chosen in ShipStation (with a manual Custom Store Sync). The third-party "about 10 minutes" figure matches the export check. No webhook is documented. [DOC S1, S2, S3], [HELP S7]
- Fulfilment and label printing happen in ShipStation; labels can be printed from either system when export is on. [DOC S2, S3]

### 7.2 What Cin7 stores per shipment

| Cin7 field | Source in ShipStation | Src |
|---|---|---|
| Ship tab: Tracking Number | `trackingNumber` | [DOC S3] |
| Ship tab: Carrier | `carrierCode` mapped to Cin7 carrier | [DOC S8], [ASSUME matching] |
| Ship tab: shipping method/service | `serviceCode` text | [INFER] |
| Ship date | `shipDate` (date) | [API A3], [INFER] |
| Shipment cost (if import on) | `shipmentCost` (plus `insuranceCost`?) | [DOC S3], [ASSUME insurance excluded] |
| Packages / boxes | one ship line per box, each with its own carrier, tracking number and date | [DOC S9], [INFER] |

### 7.3 Partial shipments and multiple packages

- **Packages**: the ShipStation API cannot consolidate several boxes into one consignment; Cin7 sends every package as its own and ShipStation returns an **individual label per package** (Shippit and Starshipit can consolidate, ShipStation cannot). The Pack tab holds the boxes; "Generate Shipping Label" on Ship sends them. (new) [DOC S2, S6, S11]
- **Per-box tracking**: on the Ship tab each box can have a different carrier, tracking number and ship date. A sale with several boxes therefore has several tracking numbers on separate ship lines, not one comma-separated field (corrected). [DOC S9]
- **Partial shipments**: only an **advanced sale** can be fulfilled in several parts (multiple fulfilments, invoices and credit notes); a simple sale can be converted (irreversibly). Each fulfilment is its own Pick/Pack/Ship and the Shipment log has a Fulfillment # column, so export and resend work per fulfilment. Advanced sales are the default for integrated channels when the General setting is on. (new) [DOC S9, S16], [CLIENT]
- Quantity per fulfilment line comes from `shipmentItems`; this mapping is the sandbox's own. [ASSUME]
- Backordered items do not trigger automatic fulfilment; Pick/Pack/Ship must be authorised by hand once stock arrives, which also delays export. (new) [DOC S20]

### 7.4 Status the sale gets

Sale reaches shipped / `FULFILLED` on Ship authorisation (stock leaves Cin7 then), then follows normal invoice/payment completion (`COMPLETED` when also invoiced and paid). Whether the returning tracking authorises Ship is not consistent in the help center: the Custom Store article says the shipment tab is authorised if it is not yet, while the Shopify FAQ says ShipStation pushes tracking but does not authorise the shipment. The sandbox authorises Ship on return when the shipment mode is automatic, and otherwise leaves it for a user. If shipping is set to automatic, Ship is authorised as soon as Pack is. Ship authorisation is refused while a stocktake is open at the location. [DOC S3, S10, S9, S19], [ASSUME resolution], [INFER rules/sale.md]

### 7.5 Shipping-line cost handling

- **Import shipping costs** on: Cin7 obtains the shipping cost from ShipStation and automatically creates and authorises an invoice entry under **Additional Charges**. [DOC S2, S3]
- Timing: costs are added only if the invoice is **not yet authorised** when ShipStation writes back; the invoice is then authorised along with the cost. If the invoice was already authorised the cost is not sent back. The channel's invoice status should be Draft. [DOC S3]
- Tax on the charge: "Apply tax on shipping costs" applies the rule chosen in "Use tax rate from"; when off, a Zero tax rule is chosen. (corrected: the old file said the sale's shipping tax rule) Toggling Import shipping costs resets Apply tax on the page. [DOC S2], [CLIENT]
- The customer-facing shipping amount on the sale is separate from the carrier cost; Additional shipping margin affects only quoted rates. [INFER]
- Whether insurance cost is part of what is imported is not stated; see section 18. [ASSUME insurance excluded]

## 8. Store / location mapping

- Cin7 location -> ShipStation warehouse: **Shipping service** uses "Map Cin7 Core Locations to ShipStation Ship From Locations" (ship-from name to Cin7 location); **Store** mode uses "Link ShipStation warehouses to Cin7 Core locations". "Load from ShipStation" refreshes the list. [DOC S1, S2]
- "Export sales to ShipStation store" picks the destination ShipStation store. [INFER], [CLIENT]
- Custom Store: if "Use Stock Locator instead of Location as Warehouse" is on, the stock locator is the ShipStation warehouse; if off, the sale's location. To keep a channel out, filter in ShipStation on Warehouse Location (with the setting off) and add an automation rule. [DOC S3]
- **Unmapped location (Shipping service)**: the Default Ship From Address is used; the sale is still exported. (corrected: the old file said such sales are not exported) [DOC S2]
- Inactive mapping rows are a spec detail with no documented effect. [ASSUME]

## 9. Tax and currency

- Store mode: ShipStation tax types map to Cin7 tax rules; "Add a US place of business" (enter the ZIP first) creates three tax rules (state; state and county; state, county and city), applied automatically to downloaded US lines. Cin7 does **not** recalculate: it keeps ShipStation's actual tax amount and just labels it with the mapped rule. Orders are **skipped on download until tax mapping is finished**. (corrected: the old file said unmapped lines use a default rule) [DOC S1]
- Shipping service: "Use tax rate from" Default/Customer plus "Tax rule for shipping". [DOC S2]
- Currency: ShipStation account currency and units must equal Cin7's; rates are converted to the sale currency; the conversion of order amounts pushed to ShipStation is not described, so the sandbox sends the sale currency. [DOC S2, S3], [ASSUME]
- `taxAmount` is sent as a sale total, not a per-line breakdown. [API A2], [ASSUME]
- Customers created from ShipStation take the default field values from Reference books. (new) [DOC S18]

## 10. Catalog and products (Store mode)

- Catalog grid: SKU, Name, Status (Not listed / Listed), Linked SKU/Name, Sync stock level, Ignore product update, Price, Category, Option1..3. Link choices: leave blank, link to an existing Cin7 product, or create a new one. Endpoint: `POST /Shipstation/ChangeMappingAndSyncStock`. [DOC S1], [INFER spec]
- Products only flow **from** ShipStation to Cin7; Cin7 products cannot be listed in ShipStation. Everything arrives as a simple stock product (ShipStation has no variations or quantities; chosen options appear as a line comment). Weight arrives in ounces and is converted to kg. A missing category becomes "Other"; duplicate names give an error and a manual link. (new) [DOC S1]
- Loading products is normally only for testing: Cin7 creates products when it processes sale orders. A sale line with no matching SKU is first looked up in ShipStation; if still unknown it is saved as a service (non-product) line. (new) [DOC S1]
- **Stock levels are never pushed to ShipStation** (API limitation). (corrected to [DOC]; the old file hedged) [DOC S1]
- Order download details: totals and order-level discounts and additional charges are kept whole, not spread by line; adjustment lines become additional charges named shipping; Load orders reaches back at most one year; an order already in the log is skipped. (new) [DOC S1]
- Refunds and returns in ShipStation are captured and applied to the sale, with restock; refunds started in Cin7's RMA portal are not exported back and must be entered in the channel. A refund dated before the integration creates a sale with no lines and an empty restock. (new) [DOC S1]

## 11. Permissions

- Configure the integration (connect, settings): Integrations, **Shipment - ShipStation** permission (corrected from [ASSUME]). [DOC S1, S2, S3]
- To enter package information and shipping instructions: Sales, **Sale Task - Pack** view (Sales List & Tasks). To generate a shipping label: Sales, **Sale Task - Ship** view. [DOC S2, S3, S4]
- Undo has its own per-module permission. [DOC S14]
- Export log, operations log and mailing lists are visible to anyone who can open the page. [ASSUME]

## 12. Logs, errors and retries

| Log | Where | Content | Src |
|---|---|---|---|
| Log (Store mode) `vECSOrderLog` | Setup > Log tab | One entry per captured order linking it to its sale: Date, OrderNumber (shown as Invoice #), Sale task, Status (Pending / Processed / To restock), Type (order or return). Entries can be deleted to allow reprocessing, and a Pending status can be changed to Processed by hand. Export builds a file for a period. | [DOC S1], [CLIENT] |
| Operations log `vEcsOperationLog` | Setup > Operations log | Each download by user or Cin7, with counts of processed, skipped and cancelled orders; Date, Description, Category, Type (error/warning/info), Processed, User. | [DOC S1], [CLIENT] |
| Shipment log `vSSExportLog` | Shipping service > Shipment log | Every sale that could be exported: ScheduledPeriod, SO #, Fulfillment #, Invoice #, Customer, Ship by, **Status**, Comments (the error reason), StatusDate. Searchable by SO#, Fulfillment #, Invoice # and customer. Skipped and failed rows keep the original scheduled date. | [DOC S2], [CLIENT] |
| Pending orders `vECSPendingOrdersNew` | Pending orders tab | Order lines with Error / ValidationText; Process sends valid rows. | [CLIENT] |
| Not matching addresses | Custom Store tab | Sales that cannot export plus Reason. | [DOC S3] |
| Overview | Overview tab | Sales summary (refresh) and Sales/Customers grids filtered by config. | [CLIENT] |

Shipment-log statuses (resolved; the old file only guessed):
- **Skipped**: excluded by an export filter, or found to have a problem before export (the reason shows). Export was not attempted and must be done by hand. [DOC S2]
- **Failed**: exported but ShipStation returned an error. [DOC S2]
- **Exported**: pushed successfully and a ShipStation order exists. [DOC S2]
- **Shipped**: the ShipStation order has shipped. [DOC S2]
- **Canceled**: the sale was voided by a user in Cin7 (not unauthorised). (corrected) [DOC S2]

Other rules:
- Notifications (email or internal) go out on successful export, failed export and ship of an exported order, one message per event type listing all affected orders. [DOC S2]
- Error text that Cin7 documents: error code 300 / 503 for multi-organisation logins (section 1) and the Pending fulfilment restock error after refunds (section 3.1). [DOC S1, S2]
- **Retries**: the help center describes none. Failed automatic exports and flagged sales go to the Shipment log and are re-queued **by hand** with Schedule export after the cause is fixed, for a chosen period of shipment-authorisation dates; sales skipped by a user filter are not included. Whether the ten-minute check re-tries a failed sale on its own is undocumented. (corrected: the old file assumed automatic retries) [DOC S2], [ASSUME automatic]
- The page script shows the Schedule export button only while export is off, which sits oddly with the article; see section 18. [CLIENT]
- Logs can be purged: `DELETE /api/ShipStation_Index_vEcsLogs`. [INFER spec]

## 13. Limits of ShipStation's public API (relevant when the sandbox calls it)

| Limit | Value | Src |
|---|---|---|
| Rate limit | 40 requests per minute per API key + secret pair; headers `X-Rate-Limit-Limit`, `-Remaining`, `-Reset`; HTTP 429 `{"message": "Too Many Requests"}`: wait until Reset seconds have passed | [API A1] |
| Auth | HTTP Basic: key = username, secret = password; V1 host `ssapi.shipstation.com` | [API A1] |
| Date format and zone | `yyyy-mm-dd hh:mm:ss` 24 h; responses in PST/PDT, submit date-times in PST/PDT | [API A1] |
| List orders page size | max 500 per page; filters `modifyDateStart/End`, `orderStatus`, `sortBy` | [API A4] |
| Order number | max 50 characters | [API A2] |
| Order update | needs `orderKey` or `orderId`; only awaiting_payment, awaiting_shipment, on_hold; no partial update | [API A2] |
| Shipments | only label-generated shipments; paged with `page`/`pageSize`; items with `includeShipmentItems=true` | [API A3] |
| Custom Store XML | Basic auth; paged responses via a page count attribute on `Orders`; ShipStation support for custom stores is limited | [API A5] |

Cin7-side batch sizes or throttling are not documented. [ASSUME sandbox: 40 req/min budget shared per config, orders pushed in batches of 10]

## 14. Known limitations and pitfalls

1. Silent skips when pack/tracking/invoice conditions are not met, or when the channel's pick mode never authorises Pack (section 4.1). [DOC S3]
2. Pre-filled tracking number blocks export; clear it before resending. [DOC S3]
3. Shipping cost is not imported if the invoice is already authorised. [DOC S3]
4. Cancelling or voiding in ShipStation does not void the Cin7 sale (Store mode documented). [DOC S1]
5. One ShipStation account per Cin7 account; error 300 for multi-organisation logins. [DOC S1, S2, S3]
6. Do not combine Shipping-service export and Custom Store. [DOC S2, S3]
7. Weight/dimension/currency unit mismatches give wrong rates. [DOC S2]
8. Products without weight/dimensions give no rate quote. [DOC S2, S4]
9. ShipStation timestamps are PST/PDT, which can shift the day boundary of exported date windows (store `ShipStationTimezone`). [API A1], [INFER]
10. Stock locator vs location as warehouse changes what ShipStation filters on. [DOC S3]
11. Orders marked shipped in ShipStation's UI or API are "external shipments" and do not appear in `GET /shipments`, so a poller based on that endpoint misses them. [API A3]
12. Editing a sale after export does not update ShipStation automatically. [ASSUME]
13. Labels: domestic only, one per package, from the default shipping service only. [DOC S2, S6]
14. Export filters exclude matches rather than select them. [DOC S2]
15. Store-mode orders are skipped until tax mapping is complete; daily consolidation ignores the real customer. [DOC S1]
16. Failed or skipped exports need a manual Schedule export. [DOC S2]
17. "Export sales fulfilled externally" covers Amazon FBA only. [DOC S2, S3]
18. Stock levels are never sent to ShipStation and Store mode gets no tracking back. [DOC S1]

## 15. Worked example (made-up)

Setup: Shipping service mode on, export on, store "Main Web", location "Main Warehouse" mapped to ShipStation warehouse "Warehouse 1", weights in kg and dimensions in cm, Import shipping costs on, default ship-from set.

Sale: customer reference `#10458`, order number `SO-0042`, ship-to "A. Example, 12 Sample St, Springfield, IL 62701, US", sale shipping method "Ground", ship-by date 2026-03-02.

| Line | SKU | Qty | Unit price | Unit weight |
|---|---|---|---|---|
| 1 | WIDGET-A | 3 | 20.00 | 0.50 kg |
| 2 | GADGET-B | 1 | 45.00 | 2.00 kg |
| Additional charge | Shipping | 1 | 12.00 | |

Totals: lines 105.00, shipping 12.00, tax 8% on lines = 8.40, invoice total 125.40. Pack authorised, invoice number `INV-0042` (draft), tracking blank.

Pushed (abridged; the customer-facing shipping charge is not sent and the order date is the ship-by date):
```json
{
  "orderNumber": "#10458",
  "orderKey": "<task guid>",
  "orderDate": "2026-03-02",
  "orderStatus": "awaiting_shipment",
  "customerEmail": "a.example@example.test",
  "billTo": {"name": "A. Example", "street1": "12 Sample St", "city": "Springfield", "state": "IL", "postalCode": "62701", "country": "US"},
  "shipTo": {"name": "A. Example", "street1": "12 Sample St", "city": "Springfield", "state": "IL", "postalCode": "62701", "country": "US"},
  "items": [
    {"lineItemKey": "L1", "sku": "WIDGET-A", "name": "Widget A", "quantity": 3, "unitPrice": 20.00, "weight": {"value": 0.5, "units": "kilograms"}},
    {"lineItemKey": "L2", "sku": "GADGET-B", "name": "Gadget B", "quantity": 1, "unitPrice": 45.00, "weight": {"value": 2.0, "units": "kilograms"}}
  ],
  "weight": {"value": 3.5, "units": "kilograms"},
  "taxAmount": 8.40,
  "requestedShippingService": "Ground",
  "internalNotes": "Cin7 order SO-0042",
  "advancedOptions": {"storeId": 111, "warehouseId": 222}
}
```
(ShipStation's own unit names are ounces/pounds/grams; the sandbox converts kg to grams if kilograms is not accepted. [ASSUME]).

Returned shipment (ShipStation user buys a label two hours later): `trackingNumber 1Z-EXAMPLE-0001`, `carrierCode ups`, `serviceCode ups_ground`, `shipmentCost 9.35`, `shipDate 2026-03-02`, `voided false`, two shipment items quantities 3 and 1.

Resulting Cin7 fields:
- Ship tab: Carrier UPS, Tracking Number `1Z-EXAMPLE-0001`, shipping method UPS Ground, ship date 2026-03-02, one box 3.5 kg.
- Ship authorised (manual or auto): stock out 3 x WIDGET-A and 1 x GADGET-B from Main Warehouse; fulfilment status FULFILLED.
- Invoice still draft, so Additional Charges gains an authorised line "Shipping cost" 9.35 (taxed or zero-tax per settings) and the invoice is authorised. Had the invoice been authorised first, the 9.35 would not be imported.
- Shipment log row: Status Shipped, SO # `#10458`, InvoiceNumber `INV-0042`, FulfillmentNumber 1. Sale label everywhere in the UI: `#10458` (secondary `SO-0042`).

## 16. Internal endpoints (spec) and purpose

All are internal web endpoints of the sandbox and are never sent to the real app. Paged reads return `{root, total}`; saves return `{ID, HasErrors, Original, Updated}`.

| URL | Kind / method | Purpose |
|---|---|---|
| `/ShipStation/ConfigurationNG` | page (mvc) | The ShipStation page shell. |
| `/api/Currency` | GET | Currency list for the Currency in ShipStation dropdowns. |
| `/Shipstation/ChangeMappingAndSyncStock` | POST | Save a catalog link (ConfigID, ProductID, SIMProductID, SyncStockLevel, IgnoreProductUpdation). |
| `/api/Shipstation_Ext_CarrierPackage` | GET | Packages for a carrier (carrierCode, ConfigID, box) for default shipping instructions. |
| `/api/Shipstation_Index_CheckProduct` | GET, PUT | Check/update product link status for a config. |
| `/api/Shipstation_Index_Dashboard_Summary` | GET | Sales summary tiles on Overview. |
| `/api/Shipstation_Index_Product` | GET | Cin7 product lookup in the link dialog (Name, IsStockProduct, lang). |
| `/api/Shipstation_Index_vEcsLocationMapping` | GET, write | Store-mode warehouse-to-location mapping. |
| `/api/Shipstation_Index_vEcsProductList` | GET, write | Catalog grid (ConfigID, search, mode). |
| `/api/Shipstation_Index_vEcsUSTaxTypeAhead` | GET | US place of business type-ahead. |
| `/api/Shipstation_Index_vMailingList` | GET | Notification recipients. |
| `/api/Shipstation_Index_vOperationLogs` | GET, write | Operations log. |
| `/api/Shipstation_Index_vShipIntegrationLocationMapping` | GET, write | Shipping-service location-to-warehouse mapping. |
| `/api/Shipstation_Index_vShipStationExportOrdersFilterParameter` | GET | Allowed filter parameters for the export filter. |
| `/api/Shipstation_Index_vShipstationNotMatchingAddresses` | GET, write | Sales not ready for ShipStation, with Reason. |
| `/api/Shipstation_Index_vShipstationOverviewCustomersList` | GET | Overview Customers grid. |
| `/api/Shipstation_Index_vShipstationOverviewSalesList` | GET | Overview Sales grid. |
| `/api/Shipstation_Index_vShipstationPendingOrders` | GET | Pending orders grid. |
| `/api/Shipstation_Index_vStore` | GET | ShipStation stores for "Export sales to ShipStation store". |
| `/api/Shipstation_Index_vTax` | GET, write | Cin7 tax rules for mapping. |
| `/api/Shipstation_Index_vTenantAddress` | GET, write | Ship-from address options. |
| `/api/ShipStation_Index_vAccounts` | GET | Ledger accounts for payment mapping. |
| `/api/ShipStation_Index_vCustomIntegration` | GET, write | Custom Store settings. |
| `/api/ShipStation_Index_vCustomer` | GET | Customer lookup for the Customer setting. |
| `/api/ShipStation_Index_vEcsConfiguration` | GET, write | Store-mode configuration (all Setup fields). |
| `/api/ShipStation_Index_vEcsLogs` | GET, DELETE | Order log. |
| `/api/ShipStation_Index_vEcsPaymentProcessorMapping` | GET, write | Payment method to account mapping. |
| `/api/ShipStation_Index_vEcsTaxMapping` | GET, write | Tax mapping. |
| `/api/ShipStation_Index_vLocation` | GET | Cin7 locations. |
| `/api/ShipStation_Index_vRevenueAccounts` | GET | Revenue accounts. |
| `/api/ShipStation_Index_vSalesPriceTiers` | GET | Price tiers. |
| `/api/ShipStation_Index_vShipServConf` | GET, PUT | Shipping-service configuration (export on/off, units, margin, notifications, defaults). |
| `/api/ShipStation_Index_vTaxRules` | GET | Tax rules list. |
| `/api/ShipStation_Index_vZeroTax` | GET, write | Zero-tax rule used for shipping cost. |
| `/Sale/ResendToShipStation`, `/SaleMultiple/ResendToShipStation` | PUT (TaskID) | Resend one / many sales (from `spec/modules/06-sale`). |
| `/api/Sale_Index_LookupCarrier` | GET | Carrier/service lookup for rates on a sale. |
| `/api/EcsOrderLogExport` | GET | Export of the order log for a period. |

## 17. Source list

All help-center articles were read in full. Keys S5 and S7 are not help-center articles.

| Key | Source |
|---|---|
| S1 | https://help.core.cin7.com/hc/en-us/articles/9034569837839-ShipStation-Integration (Store mode) |
| S2 | https://help.core.cin7.com/hc/en-us/articles/9034589708431-ShipStation-as-a-Shipping-Service |
| S3 | https://help.core.cin7.com/hc/en-us/articles/9034589736463-ShipStation-Custom-Store |
| S4 | https://help.core.cin7.com/hc/en-us/articles/9034590379023-Using-Shipping-Service-for-Shipping-Rate-Quotes |
| S5 | https://help.shipstation.com/hc/en-us/articles/360025855392-Cin7-Core (ShipStation help, search excerpt only) |
| S6 | https://help.core.cin7.com/hc/en-us/articles/9034587181839-Shipping-Label-Printing |
| S7 | https://fiskalfinance.com/shipstation-cin7-integration-configuration-guide (third party) |
| S8 | https://help.core.cin7.com/hc/en-us/articles/9034435146511-Carriers |
| S9 | https://help.core.cin7.com/hc/en-us/articles/10848179032463-Pack-and-ship-an-order |
| S10 | https://help.core.cin7.com/hc/en-us/articles/9034569866639-Shopify-Integration-FAQs (ShipStation questions) |
| S11 | https://help.core.cin7.com/hc/en-us/articles/10664510651023-Packing-with-WMS |
| S12 | https://help.core.cin7.com/hc/en-us/articles/10015383274511-Amazon-Business-orders |
| S13 | https://help.core.cin7.com/hc/en-us/articles/9034512161423-Sale-POST |
| S14 | https://help.core.cin7.com/hc/en-us/articles/9034570756111-What-is-the-Undo-function-When-is-it-no-longer-possible-to-Undo-an-invoice |
| S15 | https://help.core.cin7.com/hc/en-us/articles/9034492714255-Processing-a-sale |
| S16 | https://help.core.cin7.com/hc/en-us/articles/9034450166287-Advanced-Sales-Multiple-Fulfillment |
| S17 | https://help.core.cin7.com/hc/en-us/articles/9034586802319-Sales-list-and-order-status |
| S18 | https://help.core.cin7.com/hc/en-us/articles/9034451009935-Default-field-values-for-new-products-customers-and-suppliers |
| S19 | https://help.core.cin7.com/hc/en-us/articles/9034570508687-Using-the-Cin7-Core-Warehouse-Management-System-WMS |
| S20 | https://help.core.cin7.com/hc/en-us/articles/9034480522511-Backorders-and-Split-Orders |
| A1 | https://www.shipstation.com/docs/api/requirements/ |
| A2 | https://www.shipstation.com/docs/api/orders/create-update-order/ |
| A3 | https://www.shipstation.com/docs/api/shipments/list/ |
| A4 | https://www.shipstation.com/docs/api/orders/list-orders/ |
| A5 | https://www.shipstation.com/docs/custom-store/v1 |
| spec | `spec/modules/12-integrations/shipstation/{README,UI}.md`, `schema.sql`; `spec/modules/06-sale/README.md` |
| client | `rules/shipstation-client.md` (static reading of the shipped page scripts) |

## 18. Unclear / docs disagree

Resolved by the full help center (struck through, with where the answer now lives):

- ~~Which mode is "the" integration, and how the three modes pair with settings.~~ Resolved: the help center defines Store, Custom Store and Shipping service clearly and says which can coexist (sections 1 and 3).
- ~~**Poll interval**: 15 minutes versus 10 minutes.~~ Resolved: they are different clocks (10-minute export check, 15-minute shipment sync, hourly Store capture, Custom Store frequency set in ShipStation). Section 7.1.
- ~~**Export eligibility**: whether push mode uses the same trigger.~~ Resolved: both articles list the same Pack/Ship/Invoice conditions; Schedule export is keyed by shipment-authorisation date. Sections 4.1 and 4.4.
- ~~**Which sale statuses push** and what happens on void or undo.~~ Resolved as far as documented: voided shows Canceled; undo returns to draft. Section 4.5. What ShipStation is told stays in the open list below.
- ~~**Partial shipments and multiple packages.**~~ Resolved: advanced sales for partial fulfilment; one label per package; per-box tracking lines. Section 7.3.
- ~~**Shipment log statuses.**~~ Resolved: meanings are documented. Section 12.
- ~~**Test connection.**~~ Resolved: no Cin7 control; connecting is the test, and ShipStation tests the Custom Store login. Section 2.
- ~~Whether "Resend to ShipStation" exists in the help center.~~ Resolved: it does not; it exists only in the page scripts. Section 4.4.
- ~~Cin7 help pages could only be read via search excerpts.~~ Resolved: all [DOC] rules were re-checked against the full articles.

Still open (the help center and page scripts truly do not settle these):

- **`orderNumber` source**: whether Cin7 sends the customer reference or the SO number to ShipStation is unstated; the sandbox label rule overrides. The same goes for custom fields 2 and 3, tags and notes (only Amazon Business orders are documented). Section 4.3.
- **Does the returning tracking authorise Ship?** The Custom Store article says it does; the Shopify FAQ says ShipStation pushes tracking but does not authorise. The sandbox authorises only in automatic shipment mode. Section 7.4.
- **Insurance cost**: whether imported shipping cost includes `insuranceCost` or only `shipmentCost` is unstated. Section 7.5.
- **Void or edit after export**: what Cin7 tells ShipStation (cancel the order, update it) is undocumented; the sandbox sends nothing. Section 4.5.
- **Automatic retries**: manual re-export is documented, but whether the ten-minute check retries a failed sale itself is not. Section 12.
- **Schedule export visibility**: the article describes it for failed exports while export is on; the page script shows the button only while export is off. Section 12.
- **Carrier matching on return**: how a returned carrier code is matched to a Cin7 carrier is undocumented. Section 6.
- **Time zone**: ShipStation says PST/PDT; Cin7 stores `ShipStationTimezone` but nothing says how it is applied. Section 14.
- **Cin7-side throttling and batch sizes**, and the Store-mode defaults other than Invoice status (draft), are undocumented. Sections 3.1 and 13.
- **Looser eligibility wording in the Shopify FAQ** (Pick, Pack and Ship have data, last tab not necessarily authorised) against the Pack-authorised rule of the ShipStation articles. The sandbox follows the ShipStation articles. Section 4.1.
