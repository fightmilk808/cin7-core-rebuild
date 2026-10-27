# Cin7 Core: Shopify integration rules spec

Behaviour rules for the Shopify connector (page `/Shopify`, bundle `Shopify2019`). The structure map in
`spec/modules/12-integrations/shopify/` (README, UI.md, schema.sql) says what the screen holds; this file says what
each setting does and how data moves. Rules only: no company data, no credentials. Everything below comes from public
documentation; no store, app or API was called.

## ⚠️ Gotchas: the sneaky stuff

The surprising, easy-to-get-wrong and silently failing behaviours, worst first. Each links to the section with the full rule. Tags are explained in "How to read this file" below.

> [!CAUTION]
> **Disconnecting wipes the links between the two systems.** It removes all associations between Cin7 products, orders and customers and their Shopify objects, and the page text adds that it deletes logs and pending orders. Refunds on historical orders cause trouble after reconnecting. Cin7 says not to do it without contacting support. [DOC S-CONN], [SPEC]
> [Full rule: 2.3 Disconnect](#23-disconnect)

> [!CAUTION]
> **Turning on automatic stock updates overwrites Shopify with whatever Cin7 holds.** If Cin7 quantities are wrong, or a newly created product sits at 0, Shopify is set to those numbers. Leave it off until a stocktake confirms Cin7. [DOC S-STK, S-DLP, S-INTRO]
> [Full rule: 4.2 Inventory sync (Cin7 to Shopify)](#42-inventory-sync-cin7-to-shopify)

> [!CAUTION]
> **Three silent ways an order never becomes a sale.** "Paid" capture ignores unpaid orders, an order with an unmapped tax rule cannot be processed, and an order with a gift card but no liability account waits in Pending orders. All of these just look like missing orders. [HELP S-FAQ], [DOC S-SET]
> [Full rule: 11. Known limitations and pitfalls](#11-known-limitations-and-pitfalls)

> [!CAUTION]
> **Orders are frozen after download, and almost nothing flows back.** Edits made in Shopify after download are ignored, and edits, cancellations, refunds and restocks made in Cin7 are never sent to Shopify. Only stock, product listings and fulfilment go from Cin7 to Shopify. [DOC S-ORD, S-REF]
> [Full rule: 1. Model of the integration](#1-model-of-the-integration-read-this-first)

> [!CAUTION]
> **A product mapped to no location pushes the total of all Cin7 locations to every Shopify location.** You would expect it to send nothing. Instead each Shopify location shows the full company-wide quantity, which can oversell. [DOC S-STK, S-LST]
> [Full rule: 4.2 Inventory sync (Cin7 to Shopify)](#42-inventory-sync-cin7-to-shopify)

> [!WARNING]
> **Fulfilment goes to Shopify only on Ship authorisation, and only for some orders.** Pick and pack do nothing. It is not sent for consolidated sales, POS orders or "Load data from Shopify" mode, and a shipping integration that writes tracking back without authorising Ship leaves Shopify unfulfilled. [DOC S-FUL, S-SET], [HELP S-FAQ]
> [Full rule: 7.1 Cin7 to Shopify (orders captured before fulfilment)](#71-cin7-to-shopify-orders-captured-before-fulfilment)

> [!WARNING]
> **Payments are not imported while the invoice is Draft.** With Invoice status Draft, Shopify payments wait until the invoice is authorised and another sync runs. Authorised invoices take payments immediately. [DOC S-SET, S-ORD, S-FAQ]
> [Full rule: 3.3 Account and cash settings](#33-account-and-cash-settings)

> [!WARNING]
> **A refund can error on unshipped sales, and double restocks create adjustments.** With Auto pick + pack + ship, restocking goods never shipped errors (log status Pending fulfillment) unless "Ignore restock for non fulfilled sales" is on. Restocking by hand in Cin7 and then cancelling in Shopify with restock makes a stock adjustment, not a second credit note. [DOC S-SET, S-REF], [HELP S-FAQ]
> [Full rule: 8. Refunds, returns, cancellations](#8-refunds-returns-cancellations)

> [!WARNING]
> **A Log row blocks re-import, and deleting it does not delete the sale.** To reload an order you void the sale, delete the log row, then load orders from before its date. [DOC S-ORD]
> [Full rule: 5.1 Which orders and when](#51-which-orders-and-when)

> [!WARNING]
> **With "Import duplicate SKUs" off, only the first product per SKU is imported.** The rest are skipped until the Shopify SKUs are made unique. Turning it on builds a hidden kit product per Shopify variant, and stock must then be adjusted on the main product only. [DOC S-SET, S-DUP]
> [Full rule: 4.4 Duplicate SKUs](#44-duplicate-skus-when-import-duplicate-skus-is-on)

> [!WARNING]
> **Shopify allows 100 variants per product.** A Cin7 product family with more than 100 products lists the first 100 and the rest fail, and identical option sets also fail. [HELP S-INTRO]
> [Full rule: 4.5 Variant limits and listing failures](#45-variant-limits-and-listing-failures)

> [!NOTE]
> **Cin7's own articles contradict each other in places.** The "Auto pick + pack + ship" description says Cin7 sends tracking yet also that it will not create fulfilments in Shopify, and the Required by date and comments mapping disagree between articles. Cin7 publishes no defaults for any setting, so every default here is an assumption. [DOC S-SET, S-ORD], [ASSUME]
> [Full rule: 14. Unclear / docs disagree](#14-unclear--docs-disagree)

---

## How to read this file

Source tags (every rule ends in one):

| Tag | Meaning |
|---|---|
| **[DOC]** | Stated in a Cin7 Core help-centre article (read as public JSON from `help.core.cin7.com/api/v2/help_center/en-us/articles/<id>.json`, not blocked; articles last edited 2026-10-18 to 2026-10-22). The article is named in the source key. |
| **[HELP]** | Stated in the Cin7 Shopify FAQ / troubleshooting text (key S-FAQ, or the "Common troubleshooting" block of S-INTRO). Less formal than [DOC]; Cin7 can contradict itself here. |
| **[API]** | Taken from Shopify's public developer docs (shopify.dev) or from the Cin7 API v2 map (`cin7-core` MCP `describe_operation`). Cin7's own public API v2 has no Shopify operations (map: "Public API: 0"). |
| **[INFER]** | Follows from documented behaviour or from the spec's field/label names, but nobody states it. |
| **[ASSUME]** | A choice the sandbox must make because the docs are silent (mostly defaults and enum internals). Not fact. |

Source key (all Cin7 articles are on `https://help.core.cin7.com/hc/en-us/articles/`):

| Key | URL |
|---|---|
| S-INTRO | `9034589848335-Introduction-to-Shopify` |
| S-CONN | `11797034900367-Connect-to-Shopify` |
| S-UPD | `16315692850959-Update-Shopify-connection` |
| S-SET | `11797034961039-Shopify-settings` |
| S-ORD | `11796986460431-Download-orders-from-Shopify` |
| S-FUL | `11797014743951-Fulfill-Shopify-orders` |
| S-REF | `11797034944015-Returns-refunds-and-cancellations-in-Shopify` |
| S-DLP | `11797017759887-Download-products-in-Shopify` |
| S-LST | `11797001416847-List-or-update-products-in-Shopify` |
| S-STK | `11797001436943-Stock-levels-in-Shopify` |
| S-BUF | `11797017743375-Buffer-inventory` |
| S-DUP | `9034481333775-Duplicate-SKUs-in-Shopify` |
| S-FAQ | `9034569866639-Shopify-Integration-FAQs` |
| SH-SCOPES | https://shopify.dev/docs/api/usage/access-scopes |
| SH-LIMITS | https://shopify.dev/docs/api/usage/rate-limits |
| SH-HOOKS | https://shopify.dev/docs/apps/build/webhooks |
| SH-ORDER | https://shopify.dev/docs/api/admin-graphql/latest/objects/Order |
| SH-FULFIL | https://shopify.dev/docs/api/admin-graphql/latest/mutations/fulfillmentCreate |
| SPEC | `spec/modules/12-integrations/shopify/{README.md,UI.md,schema.sql}`, `src/sandbox/modules/m12_storefronts.py` |

Sandbox state today: the page is read-only. Every control is disabled, grids are empty, and the module makes no outbound
call (no OAuth, no webhooks, no sync) (SPEC, `m12_storefronts.py` docstring). Anything below that says "Cin7 does X"
is the behaviour to emulate if the sandbox ever simulates a store.

---

## 1. Model of the integration (read this first)

1. **One connection = one store = one `ConfigID`.** A Cin7 account can link several Shopify stores; each has its own
   catalog, logs, settings and mappings, and consumes one integration licence. [DOC S-CONN, S-INTRO]
2. **Directions are fixed by data type.** [DOC S-INTRO, S-STK, S-DLP]
   - Stock quantity: Cin7 to Shopify only. Never downloaded.
   - Orders, customers, payments, cancellations, refunds, restocks: Shopify to Cin7 only. Edits, cancellations,
     refunds and restocks made in Cin7 are never sent to Shopify.
   - Fulfilment status and tracking: Cin7 to Shopify (unless mode is "Load data from Shopify", which reverses it).
   - Product master data: both ways, by explicit user action (list = Cin7 to Shopify, download = Shopify to Cin7),
     gated by "Master of data".
3. **Pending orders buffer.** Every captured order first lands in *Pending orders* (grid `vShopifyPendingOrders`), then
   a process step converts it to a Cin7 sale and writes a *Log* row (`vShopifyLog`). A log row blocks re-import of the
   same order. [DOC S-ORD]
4. **No later edits.** Once logged, changes made to the order in Shopify are not picked up, and changes in Cin7 are not
   sent back. Exception: quantities changed in Shopify *before* download are honoured (current quantity). [DOC S-ORD]
5. **Matching key for products is SKU in Cin7 and product title/options in Shopify.** Cin7 SKU is mandatory and
   unique; Shopify SKU is optional and not unique. Most product pitfalls come from this. [DOC S-SET, S-DUP, S-FAQ]
6. **Transport is webhook-first with a nightly poll.** Notifications on order created, paid, fulfilled, cancelled,
   deleted trigger capture; a midnight job downloads missed orders. [DOC S-ORD, S-INTRO]

---

## 2. Connection

### 2.1 Connect (steps only)

| Step | Rule | Src |
|---|---|---|
| Prerequisites | A free integration licence on the plan; chart of accounts, tax rules and locations already exist in Cin7. | [DOC S-CONN] |
| Permission | User needs the "Ecommerce - Shopify" permission to view or change the integration; "full access" on Integration > eCommerce and marketplaces - Shopify to update the connection. | [DOC S-INTRO, S-UPD] |
| Start | Integrations > Shopify > **+** > **Connect to Shopify** (button in form `frmAuthorise`, tab `tab-add-new`; the tab text says Cin7 asks permission to connect to the shop). | [DOC S-CONN], [SPEC UI.md] |
| Authorise | Browser redirects to Shopify's login, the merchant signs in, confirms data sharing, clicks **Update App**, and is redirected back to Cin7 to finish. | [DOC S-CONN] |
| Store URL | The shop is identified by its Shopify store domain, kept as `ShopName`. The user is not shown typing it in the Cin7 steps; the redirect carries it. | [INFER] from `vShopifyConfiguration.ShopName`, `ECommerceShop` |
| Credential storage | Cin7 stores an access token per connection (`AccessToken`). Rule for the sandbox: never render or log it. | [INFER] from `vShopifyConfiguration` |
| After connect | Configure settings, then map tax rules, locations and payment methods (section 5), then list or download products. | [DOC S-CONN] |
| Several stores | Repeat per store; when updating a connection, be logged in to the matching Shopify store first. | [DOC S-CONN, S-UPD] |

### 2.2 Access scopes

- Cin7 does **not** publish the list of scopes it requests. Searches of the help centre found no article that lists
  them. [DOC S-UPD gap]
- What the integration touches, and the Shopify scopes those data need (the minimum set a connector doing this work
  would hold): [API SH-SCOPES]

| Cin7 job | Shopify data | Scope family needed |
|---|---|---|
| Capture orders, cancellations, refunds, transactions | Orders, fulfilments, transactions | `read_orders` (+ `write_orders` if it ever edits); `read_all_orders` for orders older than 60 days |
| Create/update/remove products, set prices, images, tags | Products, variants | `read_products`, `write_products` |
| Push stock quantities per location | Inventory items and levels | `read_inventory`, `write_inventory` |
| Load and map locations | Locations | `read_locations` |
| Match/create customers | Customers, B2B companies | `read_customers` (`write_customers` only if it pushes) |
| Push fulfilment and tracking | Fulfilment orders | one of `write_merchant_managed_fulfillment_orders`, `write_assigned_fulfillment_orders`, `write_third_party_fulfillment_orders`; and `read_fulfillments` |
| Read carrier/shipping lines | Shipping | `read_shipping` |
| Gateways, taxes, discounts, duties | On the order/transactions | covered by order scopes |

  All tagged [INFER] (the per-job mapping is inferred; the scope names and meanings are from SH-SCOPES).
- **Older than 60 days:** without `read_all_orders` an app sees only the last 60 days of orders. Cin7 says manual
  loading goes back one year, so the connector must hold the extended scope. [API SH-SCOPES] / [DOC S-ORD], [INFER] link.
- **New scopes arrive later.** When Cin7 ships a feature needing a new permission, an **Update Shopify connection**
  button appears (`frmUpdateConnection`, block `divUpdateConnection`; also at the top of Bulk listing). It is not a
  re-authentication; existing syncs keep running. Flag `NotAllScopesAdded` on the configuration drives it. [DOC S-UPD, S-FAQ], [INFER] flag link.
- **Reauthorisation.** If the token is revoked or invalid, block `authError` shows "Connection with your Shopify store
  requires reauthorization" with **Reconnect to Shopify** (`frmReauthorise`). [SPEC UI.md]

### 2.3 Disconnect

| Rule | Src |
|---|---|
| Setup tab > "Disconnect from your Shopify store" > **Disconnect from Shopify store** (`frmDisconnect`). | [DOC S-CONN] |
| Disconnecting removes **all associations** between Cin7 objects (products, orders, customers) and Shopify objects. The on-page text adds that it deletes logs and pending orders. | [DOC S-CONN], [SPEC UI.md] |
| Not recommended. It breaks order links in both systems and causes trouble with refunds on historical orders after reconnecting. Contact support first. | [DOC S-CONN] |
| The store can only be disconnected by that button; changing preferences never removes it. | [HELP S-FAQ] |
| Disconnect does not delete anything in Shopify. | [INFER] (no rule sends deletes) |
| `CreationDate` (shown near the button) is the date of integration; refunds are compared to it (section 9). | [DOC S-REF], [INFER] |

---

## 3. Settings on the Setup tab

Page order follows `UI.md` (tab `tab-portal-setup`). Control = the control the spec shows. **Allowed values** list only
what the docs name. **Default** is always [ASSUME] unless stated, because Cin7 publishes no defaults for this page.
Column "Model" is the `vShopifyConfiguration` column.

### 3.1 Top of the tab

| UI label | Control / Model | Allowed values and default | What it changes | Src |
|---|---|---|---|---|
| Load orders from Shopify | checkbox `LoadOrdersFromShopify` | on/off. Default on [ASSUME]. | Off: no automatic order sync, and the manual **Load orders** button on Pending orders is disabled. Used to pause during peaks or outages. On: orders load per the other settings. | [DOC S-SET] |
| Save | button `btnSaveSetupChanges` | - | Persists the whole page (single `vShopifyConfiguration` write). | [SPEC] |

### 3.2 General settings

| UI label | Control / Model | Allowed values and default | What it changes | Src |
|---|---|---|---|---|
| Capture order when it is | combo `Topic` (`TopicStore`) | `Created`, `Paid`, `Fulfilled`. Default `Paid` ("recommended default") [HELP]. | Chooses which Shopify event pulls the order into Pending orders. Also sets the **order date** used for consolidation (created date / latest payment date / latest shipment date) and the sale's *Required by* date for paid/fulfilled capture. Created suits edit-before-process and B2B-style delayed payment; Fulfilled suits "process in Shopify, record in Cin7". Paid captures only paid orders, so unpaid orders appear missing. Must be Created or Paid to fulfil from Cin7. | [DOC S-SET, S-FUL], [HELP S-FAQ] |
| Delay order downloads (in minutes) | number `TimeDelayOrderDownloadMinutes` (`txtTimeDelayMinutes`) | Whole minutes, 0 = none. Default 0 [ASSUME]. | Wait this long after the trigger (creation if Created, payment if Paid) before downloading. Match it to the post-purchase upsell window so upsell edits are included. | [DOC S-SET, S-ORD] |
| Consolidate orders | legacy combo `ConsolidationType` (`ConsolidationTypeStore`) or new checkbox | Off or on. Internal enum values unknown. Default off [ASSUME]. | On: orders with the same order date stay in Pending orders and are merged into one sale per schedule, under one customer (the Customer setting). Off: each order becomes its own sale within minutes. | [DOC S-SET, S-ORD] |
| Consolidation frequency | combo `ConsolidationFrequencyHours` (`ConsolidationFrequencyStore`) | 3, 6, 12 or 24 hours. | Run interval for the merge. Shown only when consolidation is on. | [DOC S-SET] |
| Consolidation time | combo `ConsolidationTimeText` (`vTimeStore`, shows `Name`, value `Value`) | A clock time list. | Time of day the merge runs (time zone = account time zone [INFER]). Shown only when consolidation is on. | [SPEC UI.md], [INFER] |
| Customer | combo `ConsolidateToCustomerID` (`vCustomerStore`) | Any customer. Required [ASSUME]. | Customer for consolidated sales, and the fallback when an order has no customer. Every order needs one. | [DOC S-SET, S-ORD] |
| Use company as a customer | checkbox `UseCompanyAsCustomer` | on/off. Default off [ASSUME]. | On: the sale's customer is the Shopify **Company**; falls back to the person, then to the default Customer. Off: person, then default Customer. Unconsolidated orders only. Affects labels and shipping/billing documents. | [DOC S-SET, S-ORD] |
| Sale price tier | combo `PriceTier` | Any of the 10 price tiers. Default Tier 1 [ASSUME]; product mapping says "Price Tier. Default is Price Tier 1". | Tier used for the price pushed to Shopify when listing/updating, and the price tier stamped on imported sales. | [DOC S-SET, S-ORD, S-LST] |
| Show comparison price / Compare price tier | checkbox `ShowComparisonPrice`; combo `CompareAtPriceTier` | Checkbox on/off; tier list. Default off [ASSUME]. | Maps a tier to Shopify's "Compare at price" when listing. | [DOC S-SET] |
| Pick, pack, and ship process mode for online sales | combo `AutoShippingMode` (`AutoShippingModeStore`) | Draft; No picking; Auto pick; Auto pick + pack; Auto pick + pack + ship; Load data from Shopify. Default Draft [ASSUME]. | See table 3.2.1. Online sales only; POS fulfilment is controlled in Shopify POS settings. | [DOC S-SET] |
| Compare price tier | combo (group `GrpCompareAtPriceTier`) | see above | shown with the comparison checkbox | [SPEC] |
| Ignore restock for non fulfilled sales | checkbox `IgnoreRestockForNotFulfilled` | on/off. Default off [ASSUME]; Cin7 recommends **on** with Auto pick + pack + ship. | Only meaningful in Auto pick + pack + ship. Stops the error where a refund tries to restock goods never shipped (otherwise log shows status *Pending fulfillment*); restock and allocation follow the items actually fulfilled. | [DOC S-SET, S-REF, S-FAQ] |
| Enable partial fulfillment | checkbox `EnablePartialFulfillment` | on/off. Default off [ASSUME]. Needs every Shopify location mapped 1-1 to a Cin7 location, and mode not "Load data from Shopify". | On: status and tracking are sent per fulfilment line; Shopify order becomes *Partially fulfilled*. Off: a single order id + tracking is sent as soon as any item ships, so the whole order shows fulfilled. Simple sales must be converted to advanced to ship in parts. | [DOC S-SET, S-FUL, S-DUP] |
| Send tracking URL | radio `AppendTrackingNumberToTrackingUrl` | "With tracking number" or "Without tracking number". Default with [ASSUME]. | Whether the URL sent to Shopify is the carrier tracking-URL prefix **plus** the number, or the prefix alone. The tracking number also goes in its own field either way. | [DOC S-SET, S-FAQ] |
| Process auto-assembly | combo `CreateAssembly` (`CreateAssemblyStore`) | "For ordered quantity" or "For minimum quantity required for picking". Default ordered quantity [ASSUME]. | For assembly-BOM products with auto-assembly: ordered quantity creates an assembly for the full sale quantity regardless of stock; minimum quantity assembles only the shortfall (and more than the sale if availability is negative); no assembly if stock already covers it. Checks stock at the sale location, ignoring stock on order. | [DOC S-SET] |

#### 3.2.1 Processing modes

| Mode | Order/invoice created as | Pick | Pack | Ship | Shopify fulfilment | Src |
|---|---|---|---|---|---|---|
| Draft | Draft; user can edit before picking | not authorised | no | no | Cin7 sends status and tracking when Ship is authorised | [DOC S-SET] |
| No picking | Authorised order, fixed content | manual | manual | manual | Cin7 to Shopify on Ship | [DOC S-SET] |
| Auto pick | Authorised | authorised | manual | manual | Cin7 to Shopify on Ship | [DOC S-SET] |
| Auto pick + pack | Authorised | authorised | authorised | manual | Cin7 to Shopify on Ship | [DOC S-SET] |
| Auto pick + pack + ship | Authorised | authorised | authorised | authorised | Cin7 to Shopify (the same article also says Cin7 "does not pick up shipment information from Shopify, and will not create fulfillments in Shopify": see Unclear) | [DOC S-SET] |
| Load data from Shopify | Order loaded after fulfilment in Shopify | auto-filled from Shopify | auto | auto | None: Cin7 never updates Shopify. Overrides "Use Shopify location". Recommended for consolidated orders. | [DOC S-SET, S-FUL] |

Rules common to all modes:
- If stock on hand cannot cover the pick quantity, pick stays draft and pack/ship are not completed. [DOC S-SET]
- Modes other than Auto pick + pack + ship and Load data are "not recommended" for consolidated orders; shipping
  info is only sent to Shopify for **unconsolidated** sales. [DOC S-SET, S-FUL]
- "Load data from Shopify" prerequisites: multi-location on in Shopify, locations created and products assigned,
  shipment profiles (zones, rates, package sizes, weights), and Shopify to Cin7 location mapping. Cin7 receives pick
  location, address, ship date, packing info and carrier per item, but **no tracking URL**. [DOC S-FUL]
- Non-inventory and dropship lines follow Shopify rules in that mode; auto-assembly runs when the fulfilled order is
  captured. [DOC S-FUL]

### 3.3 Account and cash settings

| UI label | Control / Model | Allowed values and default | What it changes | Src |
|---|---|---|---|---|
| Invoice status | combo `InvoiceStatus` (`InvoiceStatusStore`) | `Draft` or `Authorized`. Default Draft [ASSUME]. | Draft: invoice editable (e.g. match invoice date to ship date); Shopify payments are **not** imported until it is authorised and another sync runs. Authorized: locked, payments sync immediately, invoice flows to the accounting integration at its next sync. | [DOC S-SET, S-ORD, S-FAQ] |
| List products as draft | checkbox `ListAsDraft` | on/off. Default off [ASSUME]; Cin7 recommends on. | Default status for newly listed products (Draft vs Active in Shopify); overridable per listing. | [DOC S-SET, S-LST] |
| Update stock levels in Shopify | checkbox `SyncStockLevel` | on/off. Default off until stock is verified [ASSUME]. | On: any stock-level change in Cin7 pushes to Shopify. Required for buffer inventory and for backorder behaviour. Off: only manual push and list/update push. Turning it on overwrites Shopify quantities. | [DOC S-SET, S-STK, S-INTRO] |
| Allow users to purchase out of stock items | checkbox `SellOutOfStock` | on/off. Default off [ASSUME]. | Sets "Continue selling when out of stock" on listed products (per-product override exists). A zero-stock sale then creates a backorder of the negative quantity in Cin7. | [DOC S-SET, S-LST] |
| Use buffer inventory | checkbox `UseBufferInventory` | on/off; needs Update stock levels. | See 4.2. | [DOC S-SET, S-BUF] |
| Buffer inventory | number `BufferInventory` | Integer >= 0 [INFER]. Default 0. | Channel-wide units withheld from the pushed quantity. | [DOC S-BUF] |
| Create a fulfillment in Shopify even if a tracking number is not available | checkbox `UploadFulfilmentWithoutTrackingNumber` | on/off. Default off [ASSUME]. | On: authorising Ship marks the item/order fulfilled in Shopify without tracking. Off: a tracking number is required or Shopify is not marked fulfilled. | [DOC S-SET, S-FAQ] |
| Allow Cin7 Core to create Shopify products when Cin7 Core product names are not unique | checkbox `AllowDuplicateNames` | on/off. Default off [ASSUME]. | On: one Shopify product per unique Name+SKU pair. Off: Cin7 products sharing a Name become variants of one Shopify product. | [DOC S-SET] |
| Bring discount codes from Shopify | checkbox `BringDiscountCodes` | on/off. Applies only when "Add a discount as" is Additional charge. | Additional charge description becomes "Discount <CODE>" instead of "Discount". | [DOC S-SET, S-ORD] |
| Import duplicate SKUs from Shopify | checkbox `SupportDuplicatedSKU` | on/off. Default off [ASSUME]. | See 4.4. | [DOC S-SET, S-DUP] |
| MASTER data source | combo `MasterDataSource` (`MasterDataSourceStore`) | Shopify; Cin7 Core; Source system. Default Source system [ASSUME]. | See 4.3. | [DOC S-SET] |
| Use Shopify order location | checkbox `HonourShopifyLocation` | on/off. | Sales take the location Shopify assigned. Ignores "Location for online sales"; ignored in Load-data mode. | [DOC S-SET, S-FUL] |
| Add a company to the address | checkbox `AddCompanyToAddresses` | on/off. | Adds the company name to the billing address beside the person name. | [DOC S-SET] |
| Location for online sales | combo `LocationID` (`LocationStore`) | A Cin7 location or "Default location"; or "Order routing" when `EnableOrderRouting`. | Default sale location for online sales; one per store. Also decides the stock figure on the Catalog: Default location = sum of all locations. Not applied to POS sales. | [DOC S-SET, S-FUL] |
| Gift card liability account | combo `LiabilityAccount` | A liability account that can receive payments. | Gift-card lines post here instead of revenue. Orders containing gift cards stay in Pending orders until set (mandatory if gift certificates are used). | [DOC S-SET, S-FAQ] |
| Optional revenue account | combo `RevenueAccount` | Any revenue account, or empty. | If set, overrides product, customer, sale and default revenue accounts for every Shopify sale. | [DOC S-SET, S-ORD] |
| Sales representative name | text `CustomRepresentative` (`CustomSalesRepresentative`) | Free text. | Sales rep on every captured sale (mandatory in Cin7). If empty the sale uses the Shopify store name. | [DOC S-SET, S-ORD] |
| Add a discount as | radio `AddDiscountAsChangedPrice` | "Price reduction" or "Additional charge". Default Price reduction [ASSUME]. | See 6.5. | [DOC S-SET, S-ORD] |
| Auto retry sale order sync | checkbox `AutoSyncRetry` | on/off. | Re-attempts sales that failed processing; see 10. | [DOC S-SET label], [INFER] |
| Import Shopify sale order tags to | combo `CustomFieldForTags` (`vSaleAttributeStore`) | A text field in the sale's additional attribute set, or "Do not import". | Writes order tags there, comma-separated; unconsolidated only. Needs a default attribute set on the sales process. Remap if the attribute set changes. | [DOC S-SET, S-ORD] |
| Import Shopify order type to | combo `CustomFieldForType` | A text field, or "Do not import". | Writes the source/channel type to that field. Cin7 now also fills the built-in *Channel order type* itself. | [DOC S-SET, S-ORD] |
| Order exclusion tags | tag input `OrderExclusionTags` | Comma-separated tags; each must be followed by a comma to activate (turns green). | Orders carrying any listed tag are not downloaded. To pull an excluded order later, remove the tag in either system, then load manually with a backdated "Orders created since". | [DOC S-SET] |
| Order lock date | date `OrderLockDate` | A date. | Orders and payments dated before it are not synced automatically; manual loading still works; refunds unaffected. | [DOC S-SET] |
| Retail delivery fee account | combo `RetailDeliveryAccount` | An account. | Receives retail-delivery-fee charges so the right tax rule applies in Cin7 and the accounting integration. | [DOC S-SET] |
| Import additional product properties from Shopify | checkbox `LoadAdditionalProductProperties` | on/off. | Line-item custom properties (size, engraving) go as text into the sale Comment; unconsolidated only. | [DOC S-SET, S-ORD] |
| Download products automatically | checkbox `ImportProductsAutomatically` (+ `ImportProductsFromDate`) | on/off. | New and updated active products flow in; first run covers products created or updated since the switch was enabled; drafts and archived are excluded. | [DOC S-SET, S-DLP] |
| Payment reference | combo `PaymentReferenceType` (`PaymentReferenceStore`) | Transaction ID or Payment ID. | Value stored as the payment reference on the Cin7 sale, for reconciliation. Payment ID suits large volumes, Transaction ID smaller ones. | [DOC S-SET] |

Other model columns with no visible control in the spec (read-only or internal): `ShippingTaxed`, `Country`,
`UseLogging`, `HighLoad`, `EnableOrderRouting`, `CreationDate`, `LastCheck`, `IsActive`, `TenantID`. Their meaning is
[INFER] only: `ShippingTaxed` = whether shipping lines carry tax; `HighLoad` = spike-protection state (section 10);
`EnableOrderRouting` = a location chosen by Cin7 order routing.

### 3.4 Mapping tables (also on the Setup tab)

| Table (grid / model) | Columns | Rules | Src |
|---|---|---|---|
| Tax rules (`divTaxMapping`, `vShopifyTaxMapping`) | Country, Province, Shopify tax name, Tax rule | **Mandatory** for order download: an order with an unmapped tax rule cannot be processed. **Load from Shopify** pulls rules not yet known; rules on orders are captured automatically. Map the default rules too. Cin7 fills provinces for US and Canada; other countries' provinces are typed manually. "Add US place of business" modal takes state, county, city, each with a Taxable flag, spelled exactly as in Shopify. | [DOC S-CONN, S-FAQ], [SPEC UI.md] |
| Locations (`divLocationMapping`, `vShopifyLocation`) | Shopify location name, Cin7 location (or "All locations") | Recommended; mandatory for partial fulfilment and restock-to-other-location. Unmapped: stock is taken from the default location for online sales. Locations also download with sales. | [DOC S-CONN, S-FUL, S-REF] |
| Payment methods (`divPaymentMapping`, `vShopifyPaymentProcessorMapping`) | Payment processor, Payment account code | Optional. Account must be type BANK or flagged to accept payments (UI text). Unmapped: sale imports but payments are added by hand. | [DOC S-CONN], [SPEC UI.md] |

---

## 4. Product sync

### 4.1 Field mapping (both directions)

| Cin7 field | Shopify field | Notes | Src |
|---|---|---|---|
| SKU | Variant SKU, else first 50 characters of title + option 1/2/3 values | Matching key on list and download. SKU is mandatory in Cin7; Shopify products without SKU are rejected; Cin7 cannot auto-generate. | [DOC S-LST, S-DLP, S-FAQ] |
| Name | Title + option 1 + option 2 + option 3 values | | [DOC] |
| Category | Product type | | [DOC] |
| Description | HTML description | | [DOC] |
| Weight | Weight | No unit conversion; units must match beforehand. | [DOC] |
| Barcode | Barcode | | [DOC] |
| Price tier N (default tier 1) | Price | Tier chosen per listing; prices cannot be edited from the integration page. Compare-at uses its own tier. | [DOC S-LST, S-SET] |
| Images | Product image | See 4.5. | [DOC] |
| Tags | First 256 characters of product tags | | [DOC] |
| Option 1-3 values, Variation | Option 1-3 values, Variation | Variants of a Cin7 product family become Shopify variants. | [DOC] |
| Brand | Vendor | Shopify uses the store name if Cin7 brand is blank. | [DOC] |
| HS code, Country of origin | HS code, Country/Region of origin | | [DOC] |
| Stock level | Inventory level per location | Cin7 to Shopify only (4.2). | [DOC S-STK] |
| Status (Active/Draft) | Product status | Cin7 to Shopify via "List product as"; download takes active only (drafts/archived by explicit tick). | [DOC S-LST, S-DLP] |
| Metafields | - | Not in any mapping table: not synced. | [DOC] absence, [INFER] |
| Product type | Physical item + Track quantity | Download: physical+tracked = Stock; physical, untracked = Non-inventory; non-physical, tracked = Stock; non-physical, untracked = Service. List: Stock and Non-inventory upload; **Service is never uploaded**. Switching stock/non-inventory later is not propagated; stock to service blocked once there are movements. | [DOC S-DLP, S-LST] |
| Service products | Used on orders | Shipping-type service lines and discounts become additional charges on sales. | [DOC S-DLP, S-ORD] |

### 4.2 Inventory sync (Cin7 to Shopify)

| Rule | Detail | Src |
|---|---|---|
| Quantity pushed | **Available** (on hand minus allocated), not On hand. Brief mismatches and negative dips come from update lag, not from the quantity choice. | [HELP S-FAQ] |
| Per location | A listed product's quantity per Shopify location = available at the mapped Cin7 location (sum if mapped to several). If the product is mapped to no location, the total of **all** Cin7 locations is sent to each Shopify location. Sale-location stock on the Catalog uses mapped locations first, then the "Location for online sales". | [DOC S-STK, S-LST] |
| Triggers (automatic) | Every Cin7 stock change: sale fulfilment, purchase receipt, transfer, write-off, stock adjustment, return. Needs "Update stock levels in Shopify". | [DOC S-STK, S-INTRO] |
| Triggers (always on) | Listing or updating a product always pushes its stock; the **Update quantities in Shopify** button (Catalog) pushes all listed items on demand; both work with automatic sync off. | [DOC S-STK] |
| Schedule | Event-driven, no fixed interval. A stock update for a product also triggers a product-info update for it. | [DOC S-FAQ] |
| Buffer | Pushed (sync) quantity = actual available - buffer. Product-level buffer (checkbox + number) beats the channel buffer; changing the channel value never alters product-level values. Applied only after List/Update; Catalog and Bulk listing grow *Sync quantity* and *Buffer inventory* columns. Bulk listing has "Don't update existing setting / turn on / remove" for the product-level buffer. | [DOC S-BUF], [SPEC UI.md] |
| Negative or zero | Cin7 does not describe a floor. With buffer larger than stock the arithmetic gives <= 0; whether the push clamps at 0 is not stated. Shopify itself allows negative available only when backorder is enabled. | [ASSUME] clamp at 0 |
| Kits / auto-assembly | With auto-assembly on, availability = assembled stock + what components can build; off, only assembled units. Advanced Manufacturing: finished-goods availability ignores component stock, so pushed quantity can be 0 despite components. Batch + auto-assembly: orders cannot be edited without voiding the assemblies, so merchants often turn auto-update off. | [HELP S-FAQ] |
| Additional units of measure | If SKUs are linked as multiples (case of 6, case of 12), each SKU is pushed its own derived availability (e.g. 180 singles, 30 six-packs, 15 twelve-packs). Unlinked SKUs get their own quantity. Download does not link them. | [DOC S-STK, S-DLP] |
| Stocktake | While a stocktake is running at a location, new Shopify sales still download but wait as pending until it completes. | [HELP S-FAQ] |
| First connection | Turn auto-update off until a stocktake confirms Cin7 quantities; newly created products start at 0 and would overwrite Shopify. | [DOC S-DLP, S-INTRO] |
| Product deleted in Shopify | Cin7 product is untouched; the next quantity push unlinks it and sets status *Not listed*. | [DOC S-DLP] |

### 4.3 Direction, creation and update rules

| Rule | Src |
|---|---|
| **Master of data = Shopify**: Cin7 never changes existing Shopify product/variant details except stock; it may create new products. **= Cin7 Core**: Shopify never changes existing Cin7 product details; downloads only create new ones (including duplicate-SKU helper products). **= Source system**: either can overwrite the other; whichever side the user acts from (list vs download) is master for that action. | [DOC S-SET] |
| Download requires master = Shopify or Source system; list requires Cin7 Core or Source system. | [DOC S-DLP, S-LST] |
| **Match then create**: list checks the Cin7 SKU against Shopify SKUs; match = update, no match = create. Download likewise matches an existing Cin7 product (by SKU) or creates one. | [DOC S-INTRO, S-LST] |
| Updates to listed products are manual only (Update on Shopify / bulk List); never automatic. Updates to Shopify products come back automatically only with "Download products automatically" or a manual download. Sales downloads create missing products but do **not** update existing ones. | [DOC S-LST, S-DLP, S-FAQ] |
| Readiness check: the *Ready for Shopify* column flags products that cannot be listed (for example price 0). | [DOC S-LST] |
| Images: list skips images entirely when the Shopify product already has any; download adds new images beside existing ones, skipping files with the same name; download only with the image option ticked (slower). | [DOC S-LST, S-DLP] |
| Locations: listing can add locations, never remove them; removing is done in Shopify. | [DOC S-LST] |
| Bulk list size: up to 50,000 products at once; beyond that 50,000 on day one then 1,000 per day (Shopify throttling). | [DOC S-LST] |
| **Unlink**: breaks the link without touching either product; Shopify listing remains sellable until stock hits 0. A later manual download or a sale containing the SKU relinks by matching SKU. **Remove from Shopify / Unlist**: deletes the Shopify listing, leaves Cin7 untouched. | [DOC S-LST] |
| **Missing on Shopify side**: product deleted in Shopify becomes *Not listed* on next quantity push (above). **Missing on Cin7 side**: product on an order is downloaded automatically; otherwise it waits for a download. | [DOC S-DLP, S-ORD] |
| Download dialog: created/updated-after date; tick boxes for archived, draft, images. Customers can be downloaded manually too: existing customer with the same name is matched, others created. | [DOC S-DLP], [SPEC UI.md] |
| Duplicate names toggle (3.3) controls whether Cin7 creates one Shopify product per unique name+SKU. | [DOC S-SET] |

### 4.4 Duplicate SKUs (when "Import duplicate SKUs" is on)

- Off: only the first product seen for a SKU is imported; the rest are skipped until Shopify SKUs are made unique. [DOC S-SET, S-DUP]
- On: Cin7 builds one **MainProduct** (the SKU) plus one hidden **KitProduct** per Shopify variant, named with the
  Shopify variant id, "not for sale", each with a one-component assembly BOM of the MainProduct and auto-assembly and
  disassembly on. If a Cin7 product is already linked to one duplicate, it becomes the MainProduct ("direct link"). [DOC S-DUP]
- A sale of any duplicate shows the MainProduct on the sale; stock is taken from it; the same stock figure is pushed to
  every duplicate. Adjust stock on MainProducts only. First duplicate downloaded sets price tier 1; other prices look
  like discounts or surcharges. Unlisting a duplicate in Cin7 deletes that Shopify listing and the KitProduct link is
  not recreated. Partial fulfilment needs the partial-fulfilment setting plus 1-1 location mapping. [DOC S-DUP]

### 4.5 Variant limits and listing failures

| Rule | Src |
|---|---|
| Shopify caps variants per product at **100**. A Cin7 product family with more than 100 products lists the first 100; the rest fail. Remedy: restructure the family (and remove listed variants first). | [HELP S-INTRO] |
| Each variant in a Shopify product needs a unique set of the three option values; identical option values in a family fail. | [HELP S-INTRO] |
| A "default variant" with a different SKU in Shopify than in Cin7: Cin7 finds the product by name but not the variant by SKU, tries to create a second default variant, and Shopify refuses ("may have reached the API calls limit" message is misleading). | [HELP S-FAQ] |

---

## 5. Order import

### 5.1 Which orders and when

| Rule | Detail | Src |
|---|---|---|
| Trigger | Webhook-style notifications on order Created, Paid, Fulfilled, Canceled, Deleted. The configured "Capture order when" event decides which one imports. | [DOC S-ORD, S-INTRO] |
| Latency | Up to about 10 minutes (Shopify may delay notifications), plus the configured delay. Unconsolidated: processed "within a few minutes". | [DOC S-ORD] |
| Safety net | A nightly (midnight) job downloads missed orders. | [DOC S-ORD] |
| Manual load | Pending orders > **Load orders** > "Orders created since" date > **Load from Shopify**. Goes back at most one year; more than a month at once may be slow. Needed for testing, after changing Capture setting, after a pause, or to reload a deleted-log order. | [DOC S-ORD] |
| Paid / partially refunded / fulfilled states | `Paid` capture only takes paid orders; `Fulfilled` only fulfilled ones; `Created` takes everything not excluded. Whether a *partially paid* or *authorised-only* order counts as paid is not documented. Fulfilled-after-capture orders behave per 7.2. | [DOC S-SET, S-FAQ], [ASSUME] for partials |
| Exclusions | Order exclusion tags, order lock date, "Load orders from Shopify" off. | [DOC S-SET] |
| Stocktake | Orders for a location under stocktake stay pending until it finishes. | [HELP S-FAQ] |
| Stock allocation | Allocated immediately on download, lowering available in Shopify and other channels. | [DOC S-ORD] |
| Cancel / delete in Shopify | Before processing: the pending order is removed. After processing: the Cin7 sale is voided. | [DOC S-ORD, S-REF] |
| Dedup | A Log row for the order number prevents re-import. To reload: void the sale, delete the log row (does not delete sale), load orders from before the order date. | [DOC S-ORD] |
| Edited orders | Shopify edits after download are ignored. Fix by hand in Cin7, or void the sale, delete the log entry, re-import. Cin7 can only represent changes as credit note + new sale. Quantities use Shopify's *current* quantity, not the original. | [DOC S-ORD, S-FAQ], [API SH-ORDER] |

### 5.2 Order to sale field mapping

| Cin7 sale field | Source | Src |
|---|---|---|
| Customer reference ("Reference") | Shopify order number/name (e.g. `#1042`), unconsolidated. Consolidated: text "Shopify sales for <date>". | [DOC S-ORD], [API SH-ORDER `name`] |
| Customer, contact, phone, email | Consolidated: default Customer. Else per "Use company as customer": Shopify customer (or company, falling back to customer, then default). Customers are matched/created automatically for unconsolidated sales; customer tags import automatically. | [DOC S-ORD, S-INTRO, S-FAQ] |
| Billing address | Shopify billing address; if no customer, the default customer's billing address; not updated for consolidated or POS. Company name added when "Add a company to the address" is on. | [DOC S-ORD, S-SET] |
| Shipping address / company / contact | Shopify shipping address; falls back to billing, then to the default customer's; not updated for consolidated or POS. | [DOC S-ORD] |
| Shipping notes | Shopify notes plus shipping phone if it differs from billing; plus customs identifiers (Resident ID, CPF, CNPJ, PCCC, CF, PEC) for China, Brazil, South Korea, Italy. | [DOC S-ORD] |
| Order date | Created date, latest payment date or latest ship date, per Capture setting. | [DOC S-ORD] |
| Invoice date | Shopify order creation date. | [DOC S-ORD] |
| Required by | Unconsolidated: date captured in Cin7 (but see 5.1: payment/ship date for Paid/Fulfilled capture). Consolidated: Shopify creation date. | [DOC S-ORD] (inconsistent, see Unclear) |
| Due date | Invoice date + customer payment term. Terms = customer's term. | [DOC S-ORD] |
| Carrier/service | Online: Shopify carrier, else "Free Shipping". POS: "In store pickup". | [DOC S-ORD] |
| Location | Mapped Shopify order/fulfilment location; else Shopify location if "Use Shopify location"; else "Location for online sales"; else order routing result. | [DOC S-ORD, S-FUL] |
| Price tier | Setting "Sale price tier". | [DOC S-ORD] |
| Sales rep | Setting, else Shopify store name. | [DOC S-ORD] |
| Account (revenue) | Optional revenue account; else customer's sales account. | [DOC S-ORD] |
| Tax rule | Via the tax mapping. | [DOC S-ORD] |
| Purchase order reference | Shopify PO number. | [DOC S-ORD] |
| Channel order type | Shopify web, Shopify POS, Shopify admin (draft orders); source name from the order. | [DOC S-ORD], [API SH-ORDER `sourceName`] |
| Comment | Shopify notes for unconsolidated; for consolidated, the list of included order numbers (the article states these two cases the other way round: see Unclear). Plus additional properties if enabled. | [DOC S-ORD] |
| Tags / type (attribute fields) | Per 3.3, unconsolidated only. | [DOC S-SET] |
| Payment reference | Transaction or Payment id per setting. | [DOC S-SET] |
| Sale line quantity | Shopify current quantity. | [DOC S-ORD] |
| Currency | The Cin7 customer/sale currency rules apply; Cin7 supports multi-currency Shopify stores. The mapping of the Shopify presentment currency to the sale's currency and rate is not described. | [HELP S-FAQ], [ASSUME] |

### 5.3 Sale shape created

- **Sale type.** Cin7's docs do not say whether an import is a simple or an advanced sale. A simple sale is the
  default; the docs require a simple sale to be converted to advanced to ship in parts, and advanced sales "can create
  multiple fulfilments by default". Sandbox rule: create a **simple** sale and convert to advanced only on a
  partial-ship action. [INFER] from S-FUL; [ASSUME] for the creation type.
- **Statuses created.** Determined by the processing mode (3.2.1) and invoice status (3.3). Quote stage is skipped; the
  order is Authorised, except Draft mode which leaves order/pick editable. The invoice is Draft or Authorised per
  setting. Cin7 API enums: sale order `AUTHORISED`, status strings on the order body. [DOC S-SET], [API `sale order-create`: `Status`, `AutoPickPackShipMode`]
- **Lines.** All Shopify line items with quantity, unit price, line total; tax rule from mapping; backorder quantity if
  stock is short and backorder allowed. Products optionally dropshipped in Cin7 are always dropshipped from Shopify
  sales; kits and assemblies behave as in the Cin7 UI. [DOC S-ORD], [API]
- **Additional charges.** Shipping and handling lines go in as additional charges under shipping; duties and duty taxes
  as additional charges with their tax; discounts per 6.5; non-physical untracked Shopify products (services) also as
  charges. [DOC S-ORD, S-DLP]
- **Tax-inclusive.** Shopify's `taxesIncluded` flag says whether prices include tax. How Cin7 sets the sale's
  tax-inclusive flag from it is not documented. Sandbox rule: copy it, apply the mapped tax rule per line. [API SH-ORDER `taxesIncluded`], [ASSUME]
- **Gift cards.** Lines recognised as gift cards (Shopify gift-card product, or a Cin7 Stock product mapped to
  "Shopify Gift") post to the liability account, not revenue; order waits in Pending until the account is set. [DOC S-FAQ, S-SET]
- **Tips, POS cash rounding.** Tips are not mentioned. POS cash totals are rounded in AU, CA, NZ, CH, BE, FI, DK, SE, NO;
  Cin7 imports Shopify's rounded totals. [DOC S-ORD]
- **POS orders.** Fulfilment state comes from Shopify POS settings; but if any line has a costing method needing batch
  or serial numbers (Special, FIFO or FEFO serial/batch) the sale stays unfulfilled for manual fulfilment. [DOC S-FUL, S-FAQ]
- **Payments.** Recorded against the invoice when the payment method is mapped to an account **and** the invoice is
  Authorised. Draft invoices wait for authorisation plus the next sync. Bank account = the mapped account. [DOC S-ORD, S-SET]
- **Consolidated sales.** One sale per schedule and order date under the default customer; addresses are not updated;
  tags, type, properties are not imported; shipping is not sent back to Shopify; refunds still work. [DOC S-SET, S-REF]

---

## 6. Order details: discounts, shipping, tax, payment

### 6.1 Shipping method to carrier
No mapping table exists. The Shopify shipping line's carrier name is copied into *Carrier/Service* (fallback "Free
Shipping"). Reference-book carriers supply the **tracking URL prefix** used when pushing tracking back. [DOC S-ORD, S-FAQ]

### 6.2 Payment gateway to payment method / bank account
Table in 3.4. One row per processor, one account each. No payment-method concept beyond the account. [DOC S-CONN]

### 6.3 Tax mapping
Table in 3.4; mandatory. Retail delivery fee has its own account for tax. Shipping tax is a separate flag
(`ShippingTaxed`). Duty tax goes in with duty. [DOC S-CONN, S-SET, S-ORD], [INFER] flag

### 6.4 Sales channel / POS
Shopify POS orders: no "Location for online sales"; the POS location (mapped) is used; fulfilment from POS settings;
carrier "In store pickup"; billing/shipping address not updated. [DOC S-SET, S-ORD, S-FUL]

### 6.5 Discounts
Cin7 does no discount maths; it imports Shopify's amounts. [DOC S-ORD]
- **Price reduction:** item-level discounts reduce the line price (code name not shown); order-level discounts are
  spread across lines proportionally as line price reductions.
- **Additional charge:** one charge per (line, code) pair when "Bring discount codes" is on (description `Discount
  <CODE>`, comment = SKU); one per discounted line when off (description `Discount`). A service product is created once
  per code (or once for plain "Discount") and reused. Order-level discounts are spread per line so each charge carries
  that line's tax rule, keeping refunds correct.

---

## 7. Fulfilment push back

### 7.1 Cin7 to Shopify (orders captured before fulfilment)
| Rule | Src |
|---|---|
| Trigger: authorising **Ship** on the Cin7 sale (not pick or pack). | [DOC S-FUL, S-SET] |
| Sent: fulfilment status and tracking. Tracking URL = carrier URL prefix from Reference books > Carriers + the number on the shipment line (or the prefix alone per "Send tracking URL"). The number is also sent in the tracking-number field. A wrong prefix gives wrong carrier links in Shopify. | [DOC S-SET], [HELP S-FAQ] |
| Without a tracking number: fulfilment is created only if "Create a fulfillment even if tracking is not available" is on. | [DOC S-SET] |
| Carrier: taken from the shipment's carrier; Shopify decides how to display it. Shipping integrations (ShipStation) pass carrier names that must be mapped on that side. | [HELP S-FAQ] |
| Notify customer: not controlled in Cin7; Shopify sends its own shipping confirmation when the fulfilment is created. | [HELP S-FAQ], [INFER] |
| Partial fulfilments: per 3.2; each Cin7 fulfilment (advanced sale) becomes a Shopify fulfilment and the order shows *Partially fulfilled*. | [DOC S-FUL] |
| Not sent for consolidated sales, POS orders, or mode "Load data from Shopify". | [DOC S-FUL, S-SET] |
| Shopify mechanics: a fulfilment is created for fulfilment orders sharing one order and one location; partial = choose line items; needs a fulfilment-order write scope. | [API SH-FULFIL] |
| Shipping integration: if the shipper writes tracking back to Cin7 without authorising Ship, Shopify is not marked fulfilled; fix by enabling the "without tracking" option or authorising Ship. | [HELP S-FAQ] |

### 7.2 Shopify to Cin7 (orders captured after fulfilment)
Stock is allocated from the Shopify fulfilment location (mapped), pick/pack/ship auto-filled, and Cin7 sends nothing
back. Location order: Use Shopify location > mapped fulfilment location > "Location for online sales". [DOC S-FUL]

---

## 8. Refunds, returns, cancellations

| Rule | Src |
|---|---|
| Direction is Shopify to Cin7 only. Process refunds/returns in Shopify; Cin7 captures them. Cin7-side cancellations, refunds, restocks are not sent. | [DOC S-REF] |
| Cancellation before processing: pending order removed / sale task voided. After processing and fulfilment: use refund + return in Shopify. | [DOC S-REF, S-FAQ] |
| Refund on a processed sale becomes a **credit note** (with refund) plus a **restock** on the sale, for individual and consolidated sales. Credit notes sync once the sale's shipping and invoice tabs are authorised. | [DOC S-REF, S-SET] |
| Restock to a different location: Shopify's "Restock item at: [location]" produces an **authorised stock transfer** from the sale location to the restock location. Needs the 1-1 location mapping. | [DOC S-REF] |
| Auto pick + pack + ship with unshipped sales: the restock errors (*Pending fulfillment* in log) unless "Ignore restock for non-fulfilled sales" is on. | [DOC S-SET, S-REF] |
| Cancelling in Shopify with restock=yes after a manual Cin7 restock: Cin7 creates a **stock adjustment** instead of a second credit note; avoid doing both. | [HELP S-FAQ] |
| Pre-integration sale (order date before `CreationDate`): credit note and refund are imported against a stub sale with no order or invoice lines; restock section empty; no stock adjustment. Manual import of the original order gives a full sale, credit note and restock; fix residual stock with an adjustment. | [DOC S-REF] |
| Order lock date does not stop refunds. | [DOC S-SET] |
| Duties and duty taxes are refunded with the order. | [DOC S-ORD] |
| RMA portal returns are not exported to Shopify; update Shopify by hand. | [DOC S-REF] |
| Void: voiding the sale keeps a record for reconciliation but deletes transactional data; used with log deletion to reload. | [DOC S-ORD] |

---

## 9. Tabs other than Setup

| Tab | Rules | Src |
|---|---|---|
| Overview | Sales over time chart: group by, period, from/to, type = sales count, returns count, gross sales; deleted and refunded sales excluded from sales count/gross. "Sales summary" tiles from `Shopify_Index_Dashboard_Summary`. | [DOC S-INTRO], [SPEC] |
| Catalog | One row per Cin7 product: Product, Status (Listed/Unlisted), Available stock, Sync quantity, Buffer inventory, Price from (tier), Allow backorder. Click row for list/update/unlink/remove/save modal. Buttons: Download (products, customers, orders menu), Update quantities in Shopify. | [SPEC UI.md], [DOC S-LST] |
| Bulk listing | Filters: category, brand, family, product tag, price tier, listing status, products listed in (store). Pick Shopify locations, Active/Draft, backorder, product-level buffer; buttons List, Unlist, Unlink. Columns include *Ready for Shopify*. | [SPEC UI.md], [DOC S-LST] |
| Pending orders | Date filter, search, **Load orders**, **Process** (processes the *filtered* list immediately, ignoring consolidation). Columns: order #, date, customer, product, quantity, total (one row per order line). | [DOC S-ORD], [SPEC UI.md] |
| Log | One row per captured order or event: order #, date, download date, process date, status, type, sale task. Filter by date type, type, status; export; delete row (does not delete the sale). Deleting allows recapture. Statuses seen in docs: *To be loaded* (spike), *Pending fulfillment* (restock error). | [DOC S-ORD, S-SET] |
| Operations log | Uploads, downloads, config changes: date, type, user, category, processed, description. Filter by date, type, category. | [DOC S-INTRO], [SPEC UI.md] |

---

## 10. Errors, retries, rate limits, transport

| Topic | Rule | Src |
|---|---|---|
| Sales spikes | Cin7 checks Shopify API headroom; when near the limit it pauses automatic order capture and stock updates, records pending sales in the Log with status *To be loaded*, and downloads them at 5-minute intervals. Manual load/process is unaffected. Normal operation resumes by itself. | [DOC S-ORD] |
| Stock update limit | Cin7 states Shopify allows 60 API calls per minute and one call per variant per location, so many products x locations are slow or fail. | [HELP S-INTRO] (see Unclear) |
| Shopify limits | Leaky-bucket model; limits vary by API and plan; on throttle back off at least one second; use the usage data in responses. | [API SH-LIMITS] |
| Webhooks | Not guaranteed or ordered; Shopify says to reconcile periodically. Cin7's midnight catch-up is that reconciliation. Verify `X-Shopify-Hmac-Sha256`; dedupe with `X-Shopify-Webhook-Id`. | [API SH-HOOKS], [INFER] |
| Auto retry | "Auto retry sale order sync" re-attempts failed processing. Cadence unstated. | [SPEC label], [ASSUME] |
| Unprocessable orders | Stay in Pending orders with `Error`, `ValidationText`, `ValidationState` columns. Causes documented: unmapped tax rule, gift card without liability account, missing mapped locations, unmapped payment accounts (payments only), missing SKU on a product, duplicate SKU without the option. | [DOC S-CONN, S-SET, S-FAQ], [SPEC] |
| Connection errors | "Update Shopify connection" button on Bulk listing; "Reconnect to Shopify" on auth failure. | [HELP S-FAQ], [SPEC] |
| Product listing errors | Over 100 variants; duplicate option sets; default-variant SKU mismatch; reported as a product-level validation message. | [HELP S-INTRO, S-FAQ] |
| Progress | Synced-items counter; if stuck, an error occurred. | [HELP S-FAQ] |
| Permissions | Ecommerce - Shopify permission to view/change; full access to update the connection. | [DOC S-INTRO, S-UPD] |

---

## 11. Known limitations and pitfalls

1. Orders edited in Shopify after download are not reflected (and Shopify edits cannot be sent as exchanges). [DOC S-ORD]
2. Nothing in Cin7 is sent to Shopify except stock, product listings and fulfilment. [DOC S-REF]
3. Stock may briefly oversell: updates lag; use buffer inventory. [HELP S-FAQ]
4. Turning on auto stock update with wrong Cin7 quantities overwrites Shopify. [DOC S-STK]
5. Shopify product identity is the title; Cin7 is the SKU. Duplicate titles, duplicate SKUs and blank SKUs each need a setting or a data fix. [DOC S-SET, S-FAQ]
6. 100 variants per product; identical option sets rejected. [HELP S-INTRO]
7. "Paid" capture hides unpaid orders; unmapped taxes hide orders; gift cards without an account hide orders. [HELP S-FAQ, DOC S-SET]
8. Consolidated sales lose per-order tags, addresses, notes, shipping push-back. [DOC S-SET, S-ORD]
9. Draft invoices do not receive Shopify payments until authorised. [DOC S-SET]
10. Disconnect/reconnect breaks order links and later refunds. [DOC S-CONN]
11. Shopify POS serial/batch products are never auto-fulfilled. [DOC S-FUL]
12. No automatic customer shipping email from Cin7 for Shopify orders; Shopify sends its own on fulfilment. [HELP S-FAQ]
13. Manual download over a month or older than a year is limited. [DOC S-ORD]
14. Cin7 sends Available, which already deducts allocations; do not also deduct open sales. [HELP S-FAQ]

---

## 12. Internal endpoints (from the spec)

All are internal web-app endpoints (not public API v2; "Public API: 0"). `store` calls are the generic ExtJS REST
shape (GET reads; POST/PUT/DELETE on sync). Paged reads answer `{root, total}`; saves answer
`{ID, HasErrors, Original, Updated}`. Purposes are [INFER] from names, params and the screen that mounts them. [SPEC]

| Endpoint | Effect | Purpose |
|---|---|---|
| `GET /Shopify/GetFeatureFlags` | read | Feature switches that show/hide controls (e.g. new consolidation checkbox, partial fulfilment, order routing). |
| `GET /api/Shopify_Chart_Sales` | read | Overview chart series (group by, period, from/to, type). |
| `GET /api/Shopify_Index_Dashboard_Summary` | read | Overview sales summary tiles. |
| `/api/Shopify_Index_vShopifyConfiguration` | read+write | Load and save the Setup settings (all of section 3.2-3.3, 58 params). |
| `/api/Shopify_Index_vShopifyTaxMapping` | read+write | Tax mapping grid; `Update` param pulls rules from Shopify. |
| `/api/Shopify_Index_LocationMapping` | read+write | Location mapping grid; `Update` pulls Shopify locations. |
| `/api/Shopify_Index_LocationMapping_Locations` | read | Cin7 location choices for the mapping combo. |
| `/api/Shopify_Index_Locations` | read | Shopify locations for the list/update pickers. |
| `/api/Shopify_Index_vShopifyPaymentProcessorMapping` | read+write | Payment-processor to account mapping; `Update` pulls processors. |
| `/api/Shopify_Index_vShopifyCatalogList` | read | Catalog grid (search, `ConfigID`). |
| `GET /api/Shopify_Index_vShopifyCatalog` | read | Per-product action call: `Operation` (list/update/unlink/remove/save), `PriceTier`, `Locations`, `ListAsDraft`, `SellOutOfStock`, buffer params, `ProductID`. Despite "read" the spec marks it GET with side effects [INFER]. |
| `/api/Shopify_Index_BulkList` | read+write | Bulk listing grid with filters (`Category`, `Family`, `Tag`, `brandID`, `listStatus`, `listedInConfigID`, `search`); PUT/DELETE for bulk list/unlist/unlink. |
| `/api/Shopify_Index_vShopifyPendingOrders` | read | Pending orders grid. |
| `/api/Shopify_Index_vShopifyLogs` | read+delete | Log grid with `dateColumn`, `fromDate`, `toDate`, `status`, `typeFilter`, `search`; DELETE a log row. |
| `/api/Shopify_Index_vShopifyOperationLogs` | read+write | Operations log grid with `categoryFilter`, `typeFilter`, dates. |
| `/api/Shopify_Index_vAccounts` | read | Bank/payment accounts for the payment mapping. |
| `/api/Shopify_Index_vLiabilityAccounts` | read | Gift card liability account choices. |
| `/api/Shopify_Index_vRevenueAccounts` | read | Optional revenue account choices. |
| `/api/Shopify_Index_vRetailDeliveryFeeAccounts` | read | Retail delivery fee account choices. |
| `/api/Shopify_Index_vCustomer` | read | Default customer choices. |
| `/api/Shopify_Index_vSalesPriceTiers` | read | Price tier lists (sale, compare, bulk, modal). |
| `/api/Shopify_Index_vTaxRules` | read | Cin7 tax rules for the tax mapping. |
| `/api/Shopify_Index_vSaleAttributes` | read | Attribute-set text fields for tag/type import. |
| `/api/Shopify_Index_vMasterDataSource` | read | The three master-of-data options. |
| `/api/Shopify_Index_vCategory` | read | Category filter for bulk listing. |
| `/api/Shopify_Index_Family` | read | Product family filter. |
| `/api/Shopify_Index_Tags` | read | Product tag filter. |
| `/api/USState` | read | State list for the US place-of-business modal. |
| `/api/ECommerce_Common_BulkListing/shops`, `/product/brands` | read+write | Shared across storefronts: store list for "Products listed in", brand filter. |
| `/api/EcsOrderLogExport` | read | Log export. |
| `/api/Report_v`, `/api/Report_vReportLayout`, `/Report/DeleteLayout`, `/Report/DeleteLayoutNew` | read/write | Shared report-layout plumbing present on the page's bundle; not Shopify-specific. |

---

## 13. Worked example (all values made up)

**Settings used:** Capture = Paid; consolidation off; mode = Auto pick; invoice status = Authorised; price reduction;
sale price tier = Tier 1; location for online sales = "Main"; partial fulfilment off; tracking URL with number;
default customer "Web Sales"; sales rep text "Web store"; payment processor `shopify_payments` mapped to bank account
code 1010; tax mapping "US/CA State Tax" mapped to rule "Sales Tax 8%"; shipping not taxed.

**Shopify order** `#1042`, placed 2026-03-02 10:00, paid 10:02, `taxesIncluded=false`, source web.
Customer: Jane Doe (no company), email jane@example.com. Lines: 2 x `WID-100` at 20.00; 1 x `GAD-200` at 15.00.
Order discount code `SAVE10` (10%): 5.50. Shipping: carrier "UPS Ground" 8.00. Tax 8% on goods after discount: 3.96.
Total 61.46. Gateway `shopify_payments`, transaction id `T-9001`.

**Step 1: capture (10:02 plus webhook lag plus 0 delay).** Row in Pending orders, one per line. If a tax name was not mapped it stays here with a `ValidationText`.

**Step 2: processed to a sale** (within minutes; Log row written: order `#1042`, status processed, sale task = the new sale):

| Cin7 field | Value |
|---|---|
| Customer | Jane Doe (matched/created by name) |
| Customer reference | `#1042` |
| Sale type / order | Simple sale, order Authorised, pick Authorised (Auto pick), pack/ship open |
| Order date / invoice date | 2026-03-02 (payment date) / 2026-03-02 |
| Location | Main |
| Price tier | Tier 1 |
| Sales rep | Web store |
| Carrier | UPS Ground |
| Line 1 | `WID-100` qty 2, price 18.00 (20.00 less 10%), tax rule Sales Tax 8%, total 36.00 |
| Line 2 | `GAD-200` qty 1, price 13.50, Sales Tax 8%, total 13.50 |
| Additional charge | Shipping 8.00, no tax |
| Totals | Before tax 57.50, tax 3.96, total 61.46 |
| Invoice | Authorised on creation |
| Payment | 61.46 to account 1010, reference `T-9001` (Transaction ID) |
| Stock | 2 and 1 allocated at Main (available drops immediately; if stock-update on, new available pushed to Shopify) |

**Step 3: fulfilment.** Warehouse packs and ships in Cin7. User authorises Ship with carrier UPS, tracking
`1Z999`. Cin7 pushes to Shopify: fulfilment for the whole order (partial off), tracking number `1Z999`, tracking URL =
UPS prefix + `1Z999`. Shopify shows `#1042` fulfilled and emails the customer. Cin7 stock updates, then an automatic
quantity push goes out for both SKUs.

**Step 4 (variation): refund.** The customer returns `GAD-200`; the merchant refunds and restocks in Shopify at
location Main. Cin7 captures it: credit note for 13.50 + 1.08 tax (14.58 refund) against the sale, restock +1 of
`GAD-200` at Main; stock push follows. Nothing is sent back to Shopify.

---

## 14. Unclear / docs disagree

1. **Mode "Auto pick + pack + ship"**: the processing-mode list says Cin7 updates fulfilment and sends tracking in all
   modes except Load data, yet the same bullet says Cin7 "does not pick up shipment information from Shopify, and will
   not create fulfillments in Shopify". Likely meaning: Cin7 does not read Shopify fulfilments (unlike Load data) and
   the shipping integration, not Shopify, produces tracking. Unresolved. [DOC S-SET]
2. **Comments field mapping for consolidation** in the order-field table is reversed (says consolidated uses Shopify
   Notes and unconsolidated lists order numbers). Other sections say notes are skipped when consolidating, so the table
   is treated as a typo. [DOC S-ORD]
3. **Required by date**: S-SET says paid capture uses the payment date and fulfilled capture uses the ship date; the
   field table says unconsolidated = date captured in Cin7, consolidated = Shopify creation date. [DOC S-SET vs S-ORD]
4. **Shopify rate limit**: Cin7 states 60 API calls per minute. Shopify's own docs describe leaky-bucket cost models
   that vary by plan and API, not a flat 60 per minute. The Cin7 figure may be historic. [HELP S-INTRO vs API SH-LIMITS]
5. **Scopes**: Cin7 publishes none; the list in 2.2 is inferred, not Cin7's.
6. **Defaults and enum internals**: the docs give no defaults for any setting and no internal values for
   `Topic`, `ConsolidationType`, `AutoShippingMode`, `InvoiceStatus`, `CreateAssembly`, `PaymentReferenceType`,
   `MasterDataSource`. All defaults in section 3 are [ASSUME].
7. **Sale type created** (simple vs advanced) is not documented.
8. **Paid state edge cases**: partially paid, authorised-only, voided, and partially refunded orders: whether Paid
   capture takes them is not documented.
9. **Tips, metafields, order-level currency conversion, tax-inclusive handling, negative/clamped stock pushes**: not
   documented anywhere found.
10. **Consolidation time of day**: docs only mention 3/6/12/24-hour frequency; the spec also has a time-of-day control.
11. **Disconnect scope of deletion**: article says it removes associations; the on-page text (truncated in the map)
    says it deletes logs and pending orders. Treated as both.
12. **Image sync wording**: S-FAQ says all images download on first catalog download and that the master side
    overwrites the other side's images; S-LST says list skips images if Shopify already has any. Treated as: list
    never overwrites existing Shopify images.
13. **Tax-inclusive Shopify prices** and **Draft-mode invoice dating**: the article implies the invoice date can be
    changed on a Draft invoice but never states what date the import sets other than "order creation date" while the
    order date follows the Capture setting.
14. **Automatic retry cadence** and the number of attempts are not stated.
15. **Product-title uniqueness claim**: the article says Shopify's unique identifier is the product name; Shopify
    allows duplicate titles (products are keyed by id). Cin7's wording is likely a simplification. [INFER]
