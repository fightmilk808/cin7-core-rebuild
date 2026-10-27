# Shopify integration: client-side behaviour of Cin7 Core (from the shipped page scripts)

Source: static reading of the public, cached ExtJS bundles. Nothing was executed, no live app or store was contacted, nothing was written.

| Short name | Bundle | What it is |
|---|---|---|
| **SH** | `Shopify2019.js` | The `/Shopify` page: settings, catalog, bulk listing, orders, logs, dashboard. About 12k lines readable, the rest is bundled charting and tag-input libraries |
| **Main** | `Main2019.js` | Shared helpers (order-processing banners, page registry) |
| **PR** | `Product2019.js` | Product screen: "Additional descriptions" and "Channels" tabs |
| **SM** / **SS** | `SaleMultiple2019.js` / `SimpleSale2019.js` | Sale forms (two Shopify-aware fields) |
| **SL** | `SalesList2019.js` | Sales list ("Channel" column) |
| **CS** | `ContinueSetup.js` | Onboarding wizard (Shopify connect and price tier) |
| **IL** | `IntegrationList2019.js` | Integration tiles page (generic, no Shopify-specific code) |

References are written `Bundle › function`. `Shopify_Index_*` functions are in SH unless stated. Layout, ids and static labels of the server-rendered HTML are in `spec/modules/12-integrations/shopify/UI.md`; this file adds the behaviour behind them.

Important shape facts:

* The settings page is **one record per connected shop** (`vShopifyConfiguration`, id `ConfigID`). A tab strip lists shops; selecting one runs `Shopify_Index_ChangeShop`, which loads that record into every control and reloads the three mapping grids with `ConfigID` as a param. Several shops can be connected; every call carries `ConfigID`.
* Save is **one whole-record PUT** of the config via the ExtJS store (`vShopifyConfigurationStore.save()` → `/api/Shopify_Index_vShopifyConfiguration`). The three mapping grids save themselves row by row on cell edit.
* Long operations (load products, load customers, load orders, update quantities, bulk list) are **not REST calls**. They are SignalR hub calls (`chat.server.shopify*`) with progress pushed back through `chat.client.shopify*` callbacks, matched on `ConfigID`. Only "Process" orders is a form POST.
* Two server feature flags change the UI. They come from `GET /Shopify/GetFeatureFlags` (`fetchShopifyV2FeatureFlags`): `isShopifyV2ImportProductsEnabled`, `isShopifyV2ExportProductsEnabled`, `isShopifyV2UnlistProductsEnabled`, `isShopifyV2UnlinkProductsEnabled`, `isShopifyV2ImportOrdersEnabled`, `isShopifyConsolidationFrequencyEnabled`. On failure all default to `false` (legacy layout). A clone can pick either set; both are described below.

## ⚠️ Gotchas: the sneaky stuff

The surprising, easy-to-get-wrong and silently failing behaviours the page scripts show, worst first. Everything is from static reading, so server-side effects are not covered (see the end of the file). Each links to the section with the full rule.

> [!CAUTION]
> **Bulk Unlist and Unlink act on every row matching the filters, not on ticked rows.** The confirm count is `bulkStore.totalCount`. Unlist removes all those products from Shopify, so a loose filter delists everything it matches.
> [Full rule: 3.2 Bulk listing tab](#32-bulk-listing-tab-apishopify_index_bulklist)

> [!CAUTION]
> **Deleting a Log row allows the order to be loaded again.** The confirm text says so, and reloading a processed order may create a second sale (inferred). The delete button is hidden only for type `X` (exchange) rows with status Processed.
> [Full rule: 4.2 Log tab](#42-log-tab-apishopify_index_vshopifylogs-one-row-per-captured-order-event)

> [!CAUTION]
> **Ticking "Update stock levels in Shopify" pushes current available quantities, zeros included.** The only protection is a warning toast saying that if available stock is 0, Shopify will show 0.
> [Full rule: 1.4 Dependent visibility / enable rules](#14-dependent-visibility--enable-rules-summary)

> [!WARNING]
> **Product-dialog actions are GET requests with side effects, and success is an empty body.** List, Update, Save, Unlink and Remove all call `GET /api/Shopify_Index_vShopifyCatalog`; any non-empty body is treated as an error string.
> [Full rule: 3. Catalog, bulk listing, product dialogs](#3-catalog-bulk-listing-product-dialogs)

> [!WARNING]
> **Consolidation time is stored as a UTC hour.** The combo shows the local hour but saves the UTC hour of it.
> [Full rule: 1.1 Order capture](#11-order-capture)

> [!WARNING]
> **Consolidated orders never carry tags or order type.** Ticking consolidation hides both "Import Shopify ... to" fields, and unticking shows them again.
> [Full rule: 1.4 Dependent visibility / enable rules](#14-dependent-visibility--enable-rules-summary)

> [!WARNING]
> **Two attribute-mapping warnings behave differently on save.** If the stored tags field is gone from the attribute set the warning is skipped on save, but the same warning for the order-type field always blocks the save. The Setup tab turns red either way.
> [Full rule: 1.5 Validation on save and the red tab marker](#15-validation-on-save-and-the-red-tab-marker)

> [!WARNING]
> **Changing "Capture order when it is" can reset the process mode.** On blur, Fulfilled forces the mode to Ship (or keeps Load) and greys out the other modes; going back to Created or Paid resets the mode to Draft.
> [Full rule: 1.8 Capture topic and process mode coupling](#18-capture-topic-and-process-mode-coupling)

> [!WARNING]
> **Partial fulfilment can untick itself.** It needs at least one mapped location and no two rows sharing a Cin7 location; otherwise the checkbox is disabled, or auto-unticked if you just ticked it, and it is force-cleared when mode becomes Load. The container toggle and the validation also disagree about Load.
> [Full rule: 1.3 Fulfilment and stock](#13-fulfilment-and-stock)

> [!WARNING]
> **Compare price tier is saved as 0 when the box is unticked, and 0 loads as tier 1.** A stored 0 shows as tier 1 in the combo, so the stored and displayed values can differ.
> [Full rule: 1.2 Pricing and customer-facing sale data](#12-pricing-and-customer-facing-sale-data)

> [!WARNING]
> **Manual order loading goes back one year at most.** A start date more than 365 days back is refused with "The system only allows loading a maximum of one year of historical sales data."
> [Full rule: 4.1 Orders tab](#41-orders-tab-apishopify_index_vshopifypendingorders)

> [!NOTE]
> **The Log grid labels a sale by its SO number.** The Sale task column shows the SO number and "Not processed yet" when blank; per the house rule the displayed label of a sale should be its customer reference, which the grid does not have.
> [Full rule: 4.2 Log tab](#42-log-tab-apishopify_index_vshopifylogs-one-row-per-captured-order-event)

---

## 1. Settings page: "Setup" tab fields

Data model: `SH › Ext.define('vShopifyConfiguration')`. Control creation: `SH › Shopify_Index_CreateControls`. Load into controls: `SH › Shopify_Index_ChangeShop`. Collect on save: `SH › Shopify_Index_Submit`. Labels are from the page HTML (UI.md).

### 1.1 Order capture

| Label | Config field | Control / options | Default / notes |
|---|---|---|---|
| Capture order when it is * | `Topic` | Combo, not editable: `created` "Created", `paid` "Paid", `fulfilled` "Fulfilled" (`TopicStore`) | Required. See 1.8 for the link to process mode |
| Delay order downloads (in minutes) | `TimeDelayOrderDownloadMinutes` | Integer input `#txtTimeDelayMinutes`; a read-only hint `#lblTimeDelayConversion` shows `NhNm` (e.g. `1h30m`, `45m`, empty when 0) | Default 0. Clamped to 0..`MAX_ORDER_DELAY_MINUTES` = 2880 (`clampTimeDelayInput`, `formatDelayMinutesToDisplay`) |
| Load orders from Shopify | `LoadOrdersFromShopify` | Checkbox | Shows/hides the "Load orders" button on the Orders tab (1.9) |
| Consolidate orders | `ConsolidationType` | Legacy (flag off): combo `No consolidation` / `Daily consolidation`. New (flag on): checkbox; checked sends `Daily consolidation`, unchecked `No consolidation` | Server value is the same string in both modes |
| Consolidation frequency | `ConsolidationFrequencyHours` | Combo: 3 "3 hours", 6 "6 hours", 12 "12 hours", 24 "24 hours" | Default 24. Only shown when flag on **and** consolidation on. Sent only when flag on |
| Consolidation time * / "Consolidation reference time" * | `ConsolidationTimeText` | Combo of 24 hourly slots `00:00`..`23:00`; the stored **value is the UTC hour** of that local hour (`Shopify_Index_AddTime` builds each from a local `setHours` then `getUTCHours`), display is the local hour | Required. Hint text flag off: "Your local time when sale orders from Shopify will be processed into the sale task in Cin7 Core." Flag on: label switches to "Consolidation reference time", hint "The time that interval consolidation schedules are based on." (`Shopify_Index_ApplyConsolidationFrequencyFlag`) |
| Customer * | `ConsolidateToCustomerID` (+ `CustomerName`) | Remote-query combo over `/api/Shopify_Index_vCustomer` (query param `Name`); first list row is "Add a new customer" which opens `/Customer` in a new tab | Required. Name is copied from the store on save |
| Use company as a customer | `UseCompanyAsCustomer` | Checkbox | |
| Add a company to the address | `AddCompanyToAddresses` | Checkbox | |
| Order exclusion tags | `OrderExclusionTags` | Tags-input (free text chips); sent as one comma-joined string | Loaded by splitting on `,` and trimming |
| Order lock date | `OrderLockDate` | Date field; sent as `YYYY-MM-DD` or empty string | |
| Import Shopify sale order tags to | `CustomFieldForTags` | Combo over sale attribute fields (`/api/Shopify_Index_vSaleAttributes`: `Id`, `Name`, `Type`), empty text "Choose..." | See 1.7 |
| Import Shopify order type to | `CustomFieldForType` | Same store, empty text "Do not import" | See 1.7 |
| Payment reference | `PaymentReferenceType` | Combo `TransactionID` "Transaction ID", `PaymentID` "Payment ID" | |
| Sales representative name | `CustomSalesRepresentative` | Free text, placeholder "write..." | |

### 1.2 Pricing and customer-facing sale data

| Label | Config field | Control / options | Notes |
|---|---|---|---|
| Sale price tier * | `PriceTier` | Combo over `/api/Shopify_Index_vSalesPriceTiers` (`Code` int, `Name`), not editable | Required (`0`/empty is an error) |
| Show comparison price | (no own field) checkbox sets local `isCheckedShowComparisonPrice` | Checkbox | On load: checked iff `CompareAtPriceTier != 0` |
| Compare price tier | `CompareAtPriceTier` | Same tier store | Visible only when "Show comparison price" is ticked (`Shopify_Index_ShowHideComparePriceTier`). Saved as `0` when the box is unticked. On load a stored `0` is shown as tier 1 |
| Add a discount as | `AddDiscountAsChangedPrice` | Radio pair: "Price reduction" (= true) / "Additional charge" (= false) | |
| Bring discount codes from Shopify | `BringDiscountCodes` | Checkbox | |
| Retail delivery fee account | `RetailDeliveryAccount` | Account combo over `/api/Shopify_Index_vRetailDeliveryFeeAccounts` (`Code`, `DisplayName`) | See 1.6 |
| Gift card liability account | `LiabilityAccount` | Account combo over `/api/Shopify_Index_vLiabilityAccounts` | |
| Optional revenue account | `RevenueAccount` | Editable account combo over `/api/Shopify_Index_vRevenueAccounts`; list header row "Clear selection" sets value null | |
| Invoice status | `InvoiceStatus` | Combo `DRAFT` "Draft" / `AUTHORISED` "Authorized" | |

### 1.3 Fulfilment and stock

| Label | Config field | Control / options | Notes |
|---|---|---|---|
| Pick, pack, and ship process mode for online sales | `AutoShippingMode` | Combo (`AutoShippingModeStore`): `Draft` "Draft order", `None` "No picking", `Pick` "Auto pick", `Pack` "Auto pick + pack", `Ship` "Auto pick + pack + ship", `Load` "Load data from Shopify" | Interacts with `Topic` (1.8) and several dependent controls (below) |
| Ignore restock for non fullfilled sales (sic) | `IgnoreRestockForNotFulfilled` | Checkbox | Visible only when mode = `Ship` |
| (warning block `#wrnAutoShippingMode`) | | Static warning text | Visible only when mode = `Load` |
| Enable partial fulfillment | `EnablePartialFulfillment` | Checkbox | See the partial fulfilment note under this table |
| Send tracking URL | `AppendTrackingNumberToTrackingUrl` | Radio pair: "With tracking number" (= true) / "Without tracking number" (= false) | |
| Create a fulfillment in Shopify even if a tracking number is not available | `UploadFulfilmentWithoutTrackingNumber` | Checkbox | |
| Process auto-assembly | `CreateAssembly` | Combo `always` "For ordered quantity" / `basedonavailability` "For minimum quantity required for picking" | |
| Location for online sales | `LocationID` + `EnableOrderRouting` + `LocationName` | Combo over `/api/Shopify_Index_Locations` (`LocationID`, `DescriptionSetupOnlineSales`). A synthetic option with value `routing` means order routing: saved as `LocationID = empty guid`, `EnableOrderRouting = true`. Otherwise `EnableOrderRouting = false` | On load `EnableOrderRouting=true` selects `routing` |
| Use Shopify order location | `HonourShopifyLocation` | Checkbox | When ticked, the "Location for online sales" combo is disabled (`Shopify_Index_SetLocationReadOnly`) |
| Update stock levels in Shopify | `SyncStockLevel` | Checkbox | See 1.4 |
| Allow users to purchase out of stock items | `SellOutOfStock` | Checkbox | Account-wide default for new listings; also a per-product flag (3.3) |
| Use buffer inventory / Buffer inventory | `UseBufferInventory`, `BufferInventory` | Checkbox + integer 0..999999 (no minus, no decimals; empty becomes 0) | Both only visible when `SyncStockLevel` is on; the number only when "Use buffer inventory" is on |
| MASTER data source | `MasterDataSource` | Combo over `/api/Shopify_Index_vMasterDataSource` (`name`, `value`, 60s timeout) | Empty stored value is shown as `SOURCE SYSTEM` |
| Import duplicate SKUs from Shopify | `SupportDuplicatedSKU` | Checkbox | |
| Allow Cin7 Core to create Shopify products when Cin7 Core product names are not unique | `AllowDuplicateNames` | Checkbox | |
| List products as draft | `ListAsDraft` | Checkbox | Default for the Active/Draft radios on listing dialogs when export-v2 flag is on |
| Import additional product properties from Shopify | `LoadAdditionalProductProperties` | Checkbox | |
| Download products automatically | `ImportProductsAutomatically` | Checkbox | Visible only when import-products-v2 flag is on (`Shopify_Index_ShowHideImportProductsAutomaticallyContainer`) |
| Auto retry sale order sync | `AutoSyncRetry` | Checkbox | **Hidden** when the import-orders-v2 flag is on (`IsAnyV2OrdersFeatureEnabled`) |

Partial fulfilment note: the checkbox and its warning are governed by `Shopify_Index_ValidateLocationsMapping` (1.5), and `cmbAutoShippingMode.change` toggles their container by `$('#EnablePartialFulfillmentOverallContainer').toggleContent(newVal === 'Load')`. `isPartialFFVisible()` is true for any mode **except** `Load` and empty. Read literally the toggle and the validation disagree (one shows the container for `Load`, the other treats `Load` as "no partial fulfilment"); the code also force-clears `EnablePartialFulfillment` when mode becomes `Load`. A clone should treat partial fulfilment as available for `Draft/None/Pick/Pack/Ship` and cleared on `Load`.

### 1.4 Dependent visibility / enable rules (summary)

* `SyncStockLevel` ticked (and not while loading a shop): warning toast "Please note that the stock on hand quantity will be updated in Shopify with currently available quantities.<br/>If your current available stock quantity is "0", this will be reflected in Shopify." (`chkSyncStockLevel.change`).
* `SyncStockLevel` off hides: "Use buffer inventory" row, the buffer number, the "Update quantities in Shopify" button, and the catalog/bulk grid columns "Sync quantity" and "Buffer inventory". `SyncStockLevel` on shows the first and the button; the number and the four columns additionally need `UseBufferInventory` on (`Shopify_Index_UpdateGlobalBufferInventoryControls`, `Shopify_Index_UpdateSyncStockLevelControls`).
* `LoadOrdersFromShopify` off hides the Orders-tab "Load orders" button (`Shopify_Index_UpdateLoadOrderControls`).
* Consolidation ticked/`Daily consolidation`: shows "Consolidation time" (and "Consolidation frequency" when flag on) and **hides** "Import Shopify sale order tags to" and "Import Shopify order type to"; unticked reverses it (`Shopify_Index_UpdateConsolidationControls`). Consolidated orders therefore never carry tags/type.
* Process mode `Ship` shows "Ignore restock..."; `Load` shows the warning and hides both; others hide both (`cmbAutoShippingMode.change`).
* `ReadOnly` access level (`Shopify_Index_AccessCallback`): every control above is disabled, Save buttons, "Load from Shopify" mapping buttons, tax add, all download/listing/process buttons and the delete columns are hidden. Page access is checked with `CheckAccess('Shopify','Index', ...)`.

### 1.5 Validation on save and the red tab marker

`Shopify_Index_Submit` first requires a selected shop, else the message "Please select a shop to manage before saving the changes." Then `Shopify_Index_Setup_PrepareValidationMessage(rec, ignoreStockLevel=true, ignoreLoadOrder=true)` builds an error string; a non-empty one blocks the save with the toast "Cannot save setup configuration. <br/>" + the string. Then a separate check blocks the save with "Additional attribute field can only be mapped to import one type of shopify data at a time." when tags field and type field are both set and equal. Otherwise the toast "Saving..." appears and the store is saved; after the response the toast "Changes saved successfully." (store `write`).

The same function (without the two ignore flags) is re-run by `Shopify_Index_ValidatePortalTabs` 500 ms after tab changes and saves; a non-empty result puts class `with-error` on the Setup tab link and shows `#tabSetupValidator` with the text as a popover. So the Setup tab shows warnings that do not block saving.

Messages, in order checked (verbatim, `<br />`-separated):

1. If the record has `NotAllScopesAdded`: reveals the "Update Shopify connection" button (only when `IsActive`) and adds: `Not all required permission scopes are granted to your store connection on Shopify. Please use "Update Shopify connection" to resolve the problem with stock level updates and other potential issues.`. Otherwise hides the button.
2. `"Capture order when it is" field is required.` when Topic empty.
3. `Time to delay online order downloads must be a whole number between 0 and 2880.` when the delay is non-empty and not an integer in 0..2880.
4. `"Consolidation time" field is required.` (flag on: `"Consolidation reference time" field is required.`) when no consolidation time (checked even if consolidation is off, because the combo always has a value in practice).
5. Flag on, consolidation ticked, no frequency: `"Consolidation frequency" field is required.`
6. `"Customer" field is required.` when no customer.
7. Warning only (skipped on save): `Your stock level update is currently disabled. {company} won't update the stock level in your store.` when `SyncStockLevel` is off.
8. Warning only (skipped on save): `Loading of orders from Shopify is disabled.` when `LoadOrdersFromShopify` is off.
9. `"Price tier" field is required.` when `PriceTier` is 0/empty.
10. `Retail delivery fee account requires a liability account.` when the chosen retail delivery account is no longer in the allowed list (stored code absent from the store; the client adds it as a flagged leftover item, see 1.6).
11. When partial fulfilment was **newly** turned on this edit, mode is not `Load`, and the location mapping is not 1-1: the warning block text (UI.md `#wrnEnablePartialFulfillment`, "WARNING! Please make sure that all Shopify locations are mapped 1-1 with Cin7 Core locations. This is mandatory to enabl...").
12. Warning only (skipped on save): `The default attribute set for sales process customization has been changed. Please select which field to import Shopify tags to again.` when the stored tags field is not in the attribute store or is flagged `Warning`.
13. Always: `The default attribute set for sales process customization has been changed. Please select which field to import Shopify type to again.` when the stored type field is not in the store or flagged `Warning`.

### 1.6 Account combos with stale values

`Shopify_Index_ApplyRetailDeliveryAccountValue`: if the stored retail-delivery account code is not in the loaded list, the client inserts it as a pseudo-row (`DisplayName = code`), remembers it as `retailDeliveryAccountLeftoverCode` and sets `retailDeliveryAccountInvalid = true` (drives message 10). Picking any other real row removes the pseudo-row and clears the invalid flag (`Shopify_Index_OnRetailDeliveryAccountSelected`). Liability and revenue combos simply re-apply the stored code after their store loads. Account lists re-restore codes via `Common_COA_TreeMode_RestoreCodes` (chart-of-accounts tree-mode helper in Main).

### 1.7 Sale attribute (tags / type) combos

Both combos are bound to the same store. Stored ids that are not in the store are injected as a row `{Id: <id>, Name: <id>, Type: 'Warning'}` and rendered greyed and non-selectable (template with class `x-boundlist-item-notactive`). Rows whose `Type` is `Warning` count as "changed attribute set" for messages 12/13. The injected row is removed before each shop switch.

### 1.8 Capture topic and process mode coupling

`SH › Shopify_ProcessMode_Update` (runs on Topic **blur**):

* Topic `fulfilled`: process mode is forced to `Load` if it already was `Load`, else `Ship`; in the mode list only `Ship` and `Load` stay selectable (the other rows get `disabled = true`, shown grey, `beforeselect` rejects them).
* Topic `created` or `paid` after previously being `fulfilled`: mode is reset to `Draft`.
* Otherwise all modes are selectable.

### 1.9 Connection block (connect / reauthorise / disconnect)

Rendered by the server as forms; the bundle only toggles and fills them (form `action` URLs are not in the script, see "Not determinable").

* **Connect** (tab "Link your Shopify shop with Cin7 Core", form `#frmAuthorise`, button "Connect to Shopify"): plain form submit, no script logic. Returning from the OAuth step the page is reloaded with `Shopify_Index_Ready(newConfigID, tabId)`; `newConfigID` selects the new shop after the config store loads (`vShopifyConfigurationStore.load`). The onboarding wizard (CS) reacts to hash `shopify` + `start` by opening a sync dialog (`SalesChannel_Shopify_OpenSyncDialog`), and to any other value with a modal "Connection to Shopify ..." / "Connection to Shopify failed.Refresh page and try again." (sic).
* **Inactive connection** (`IsActive == false`): shows `#authError` ("Connection with your Shopify store requires reauthorization.") and fills hidden input `Shopify_Index_ReauthoriseShopName` with `ShopName`; the user presses "Reconnect to Shopify" (form `#frmReauthorise`).
* **Missing scopes** (`NotAllScopesAdded` and `IsActive`): shows "Update Shopify connection" (form `#frmUpdateConnection`), hidden input `Shopify_Index_UpdateConnectionShopName` = `ShopName`.
* **Disconnect** (`Shopify_Index_Disconnect`): confirm dialog, title "Confirmation", text "Are you sure you want to disconnect from Shopify?", buttons "Disconnect" / "No". On confirm sets hidden input `DisconnectConfigID` to the current `ConfigID` and submits `#frmDisconnect`. The static page text says it deletes logs and pending orders. Hidden for read-only users via `.js-disconnect-controls`.
* Shows "Connection date: {date}" from `CreationDate`.

---

## 2. Mapping grids (Setup tab)

All three use cell-editing (`clicksToEdit: 1`), `markDirty: false`, `minHeight 100 / maxHeight 500`, are read-only for `ReadOnly` users, save through `Shopify_Index_SaveEditingWithKeepScoll` (blocking spinner, `store.save()`, scroll position restored) after each effective edit, and have a "Load from Shopify" button that clears the store and re-reads with `extraParams {ConfigID, Update:'1'}` (server re-pulls from Shopify). Grids are hidden while a shop is being switched and revealed when the Setup tab is shown (`Shopify_SetActiveTab`).

### 2.1 Tax mapping (`vShopifyTaxMapping`, `/api/Shopify_Index_vShopifyTaxMapping`)

Model: `ID`, `ConfigID`, `Country`, `Province`, `Name`, `Value`, `SortOrder`, `TaxRuleName`. Empty text "Loading Shopify tax rates...".

| Column | Field | Editor |
|---|---|---|
| Country | `Country` | none |
| Province | `Province` | none |
| Shopify tax name | `Name` | none |
| Tax rule | `TaxRuleName` | Local combo over `/api/Shopify_Index_vTaxRules` (`RuleID`, `Description`); selecting a description sets `Value = RuleID`; clearing sets `Value = null`. Empty cell renders "Use default tax for items" |
| (delete) | | Trash column |

* Delete: blocked for `Country == 'Default'` (toast "Default tax entries cannot be deleted."). Otherwise confirm "Would you like to delete this tax mapping entry?" ("Yes, delete it!" / "No"), then remove + save.
* "Add a new US place of business" dialog (button `#divAddTaxMapping`): fields State (combo over `/api/USState`, `Code`/`Value`), County (text, placeholder "County"), City (text, placeholder "City"), each with a Taxable checkbox default ticked. Changing the state clears county and city; changing county clears city. Save validation, in order: `Please choose a state.`, `Please choose a county.`, `At least one component should be taxable.` (toasts). Save then creates rows (Country fixed `United States`, `Province` = state, `SortOrder` 3, `Name` built below), skipping any `Name` already in the grid, and saves the store.
  * Names built (`Shopify_TaxMapping_Save` click): city+county+state taxable: `"City, County, State"`; city only: `"City"`; city+county: `"City, County"`; city+state: `"City, State"`; then, with state and county taxable: `"County, State"`; state taxable: `"State"`; county taxable without state: `"County"`. City rows are created only when the city is non-empty and its own Taxable box is ticked.

### 2.2 Location mapping (`vShopifyLocation`, `/api/Shopify_Index_LocationMapping`)

Model: `ID`, `ConfigID`, `ShopifyLocationName`, `ShopifyLocationID` (int), `IsFulfillmentLocation`, `IsActive`, `LocationID`, `LocationName`, `IsSelected`. Empty text "No locations loaded from Shopify".

| Column | Field | Editor / rendering |
|---|---|---|
| Name | `ShopifyLocationName` | Read-only; inactive locations (`IsActive == false`) rendered grey with strike-through |
| Location | `LocationName` | Local combo over `/api/Shopify_Index_LocationMapping_Locations` (`LocationID`, `DescriptionMappings`), display/value `DescriptionMappings`. Empty renders grey "All locations" |
| (delete) | | Confirm "Would you like to delete this location mapping entry?"; remove + save |

Edit rules (`locationMappingEditing.edit`): clearing sets `LocationID`/`LocationName` null; picking looks up `LocationID` by description; **if partial fulfilment is enabled and the same Cin7 location (or "All locations" for blanks) now appears on more than one row**, toast "Please make sure each mapped location is unique." and the edit is rejected. On store load, when exactly one Shopify location exists it is auto-`IsSelected`.

`Shopify_Index_ValidateLocationsMapping` (run after load, write, save and mode change): mapping is valid iff at least one row has a mapped `LocationID` **and** no two rows share a `LocationID`. It disables the "Enable partial fulfillment" checkbox when invalid and currently off, auto-unticks a newly ticked checkbox when invalid, and shows/hides `#wrnEnablePartialFulfillment`.

### 2.3 Payment mapping (`vShopifyPaymentProcessorMapping`, `/api/Shopify_Index_vShopifyPaymentProcessorMapping`, timeout 180 s)

Model: `ID`, `ConfigID`, `PaymentProcessor`, `AccountCode`, `SortOrder`, `AccountName`. Empty text "Loading Shopify payment processors...".

| Column | Field | Editor |
|---|---|---|
| Payment processor | `PaymentProcessor` | read-only |
| Payment account code | `AccountCode` | Local combo over `/api/Shopify_Index_vAccounts` (valueField `Code`, display `DisplayName`); empty renders "Default payment account"; an edit to a value not in the store clears the code |
| (delete) | | Blocked for `PaymentProcessor == 'Default'` (toast "The default payment account cannot be deleted."); confirm text is the copy-pasted "Are you sure you want to delete the brand?" (sic) |

`EcsCommon_TogglePaymentProcessorMappingInfoMessage` (Main-style helper at the end of SH): the info block `.paymentProcessorMappingInfo` is shown iff **no** row has an empty `AccountCode`/`LedgerAccount`. Per the static text only accounts of type BANK or flagged for payments are offered.

---

## 3. Catalog, bulk listing, product dialogs

### 3.1 Catalog tab (`/api/Shopify_Index_vShopifyCatalogList`)

Server-paged (`root`), page size from a stored preference `ShopifyCatalogPageSize` (default 20; sizes 10/20/50/100), remote sort, search box (Enter or "Search") sends `search`, `ConfigID`. Empty text "No products found.". Footer "Displaying products {0} - {1} of {2}". Row click opens the product dialog (3.3). Downloads dropdown (`#cmbDownload`): "Products" → 3.4, "Customers" → 3.5. "Update quantities in Shopify" → 3.6 (visible only with stock sync on).

| Column | Field | Rendering |
|---|---|---|
| Product | `ProductCode` + `Name` | `"{code}: {name}"` |
| Status | `Status` | Pill; `Listed` styled "invited", anything else "notinvited"; `Not listed` / `Not Listed` both show "Not listed" |
| Available stock | `Available` | Right-aligned, not sortable. Header text becomes **"Sale location stock"** when the shop has a specific `LocationID` (non-empty guid), else "Available stock" |
| Sync quantity | `SyncQuantity` | Right-aligned; only visible with stock sync + buffer inventory on |
| Buffer inventory | `SyncBufferInventory` | Right-aligned; same visibility |
| Price from | `PriceTier` | Tier name from the tier store; 0 or unknown renders "not specified" |
| Allow backorder | `SellOutOfStock` | "Yes" / "No" |

The model also carries `PriceTear1..10`, `UseBufferInventory`, `BufferInventory`, `IsLinkToKitProduct` (not shown as columns).

### 3.2 Bulk listing tab (`/api/Shopify_Index_BulkList`)

Filters (all re-run `Shopify_LoadBulkGrid`): Category ("List all categories", `/api/Shopify_Index_vCategory`), Brand ("List all brands", `/api/ECommerce_Common_BulkListing/product/brands`, lazily loaded), Family ("List all families", remote query `Name` over `/api/Shopify_Index_Family`), Product tag ("List all tags"), Price tier, Listing status (`BulkListingStatusStore`: "Any listings" `''`, "Only listed" `Listed`, "Only not listed" `Not listed`; empty text "List all products"), Products listed in (shop combo over `/api/ECommerce_Common_BulkListing/shops`, param `currentConfigID`), search box. Request params: `search, Category, Family, Tag, ConfigID, listStatus, brandID, listedInConfigID`. Page size preference `ShopifyBulkPageSize`.

Grid columns: Product (`code: name`), Category (`CategoryName`), Status, Available stock (header same "Sale location stock" rule), Sync quantity, Buffer inventory (both gated as in 3.1), **Price** (value of the tier chosen in the "Price tier" filter: `PriceTear{N}`, money format), **Ready for Shopify** (`"No: Price is 0"` when that tier price is 0, else `Yes`), Allow backorder.

Bulk dialog controls: "Choose Shopify location(s) to list or update the product(s) to" (a checkbox per **active** Shopify location, `Shopify_RenderLocationsSelection`), "List product(s) as:" Active/Draft radios (only when export-v2 flag is on; seeded from the account `ListAsDraft`), "Allow backorder" combo (`Don't allow`=false, `Allow`=true, `Don't update existing setup`=null, empty text "Don't update existing setup"), "Use product-level buffer inventory" combo (`Turn on product level setting`=true, `Remove product level setting`=false, `Don’t update existing setting`=null) and "Product-level buffer" number (shown only when the combo is true; both only with stock sync + buffer on).

Actions (all disabled for read-only users; the three buttons hide while an operation runs, except under export-v2 where only the List path hides them):

* **List** (`Shopify_Index_BulkListing_Start`): errors `Please choose a shop to manage.`, `Please choose a price tier.`; then SignalR `chat.server.shopifyBulkListing(Category, Family, Tag, PriceTier, ConfigID, searchText, listStatus, Locations, brandID, listedInConfigID, SellOutOfStock, BulkUseBufferInventory, BulkBufferInventory, listAsDraft)`; progress via `shopifyBulkListingProgress` (warning style, message + "..."), `shopifyBulkListingComplete`, `shopifyBulkListingException`. `Locations` = comma-joined `ShopifyLocationID` of ticked locations.
* **Unlist**: confirm text `Would you like to unlist {N} products?` plus the bold warning "Clicking yes will remove all these products from Shopify.". Calls `PUT /api/Shopify_Index_BulkList` with the filter params. Messages: "Start unlisting...", success "The selected products have successfully been unlisted from Shopify.", cancel "User canceled the unlist operation.", empty "No product selected for the unlist operation.".
* **Unlink**: confirm `Would you like to unlink {N} products?`; calls `DELETE /api/Shopify_Index_BulkList` with the filter params. "Start unlinking...", "The selected products have successfully been unlinked from Shopify.", "User canceled the unlink operation.", "No product selected for the unlink operation.".
* Failure handling for unlist/unlink: on timeout, v2 flag → "Monitor your product unlisting|unlinking in the Operations Log.", legacy → "Product unlist|unlink in progress. This may take a few minutes to complete."; on error body `{error}` with v2 flag the text is shown (info style when it contains "in the operations log", else error); otherwise "An error occurred while processing the request.".

`{N}` is `bulkStore.totalCount`, i.e. the operation applies to **all rows matching the filters**, not a ticked selection.

### 3.3 Product dialog ("Shopify product management", `Shopify_Index_Catalog_*`)

Opened by catalog row click. Shows SKU, Product name, Status, "Price tier" combo (+ read-out "Price" of that tier; "Please choose a price tier." when none), Active/Draft radios (export-v2 only; seeded from `ListAsDraft`), location checkboxes (active Shopify locations; when export-v2 is on and the product is `Listed`, already-ticked locations are locked), "Allow backorder" checkbox, buffer-inventory controls. Allow-backorder default for a not-yet-listed product = the account setting; for a listed product = the product's own `SellOutOfStock`. Buttons shown by status: not listed → "List on Shopify" (+ "Save"); listed → "Update on Shopify", "Unlink", "Remove from Shopify" (+ "Save"). Buttons disable when read-only. While a call runs the price-tier combo is read-only and the button block hides.

Buffer rules (`Shopify_Index_Catalog_UpdateBufferInventoryControls`): the whole block shows only with stock sync + account buffer on; the number input shows when "Use product-level buffer inventory" is ticked; otherwise a warning shows: "Buffer inventory set by default on the grid is based on your integration setup configurations to value {n}. To apply product leve..." (truncated in source reading).

All five operations are `GET /api/Shopify_Index_vShopifyCatalog` with params `ProductID, ConfigID, PriceTier, SellOutOfStock, UseBufferInventory, BufferInventory, Operation, Locations` (+ `ListAsDraft` for List/Update), `Operation` in `List | Update | Save | Unlink | Remove`. A GET with side effects: a clone must keep that shape. Success is an empty body or `""`; any non-empty body is an error string (JSON string). Messages: "Creating or updating the product in Shopify..." / "Updating the product in Shopify..." / "Saving changes..." / "Removing the link between products..." / "Deleting product from Shopify..."; successes "The product has been created or updated in Shopify.", "The product has been updated in Shopify.", "Changes have been saved.", "The product has been unlinked from Shopify.", "The product has been removed from Shopify."; failure "An error occurred while processing the request.". Under export-v2 List/Update show "Product upload in progress. View details in the Operations Log." and parse a JSON `{Message, AdditionalProperties:{TotalFailedCount,...}}` body; the status flips to Listed only when `TotalFailedCount === 0`. After Unlink/Remove the status is set to Not listed and the grid row reloaded.

### 3.4 "Load products from Shopify" dialog

Opened from Downloads → Products (`Shopify_Index_DownloadProductsShow`). Options: "Download product images" (default ticked), "Download archived products" (default off), "Download draft products" (default off). Legacy text "All active products from Shopify will be automatically loaded into Cin7 Core. If you need to include archived and draft ..." Import-v2 text "All active products created after the selected date will be downloaded. Updates to linked products made after the select..." plus a date "Created or updated after date" (`dtProductsFromDate`, defaults to the stored `ImportProductsFromDate`, else today). Start (`Shopify_Index_DownloadProducts_Start`): "Starting..." info, then SignalR `chat.server.shopifyDownloadProducts(downloadImages, downloadArchived, downloadDraft, ConfigID, fromDate)`; `fromDate` is `YYYY-MM-DD±HH:MM` (local offset) or null. Callbacks: `shopifyProgress` (info), `shopifyDownloadComplete` (info, re-enables buttons, refreshes catalog), `shopifyException` (error). Button "Load from Shopify".

### 3.5 "Load customers from Shopify"

Start: "Starting..." then `chat.server.shopifyDownloadCustomers(ConfigID)`. Callbacks `shopifyCustomersProgress` (warning, message + "..."), `shopifyDownloadCustomersComplete` (info), `shopifyCustomersException` (error). Static text: customers with the same name already in Cin7 Core are matched, not duplicated.

### 3.6 "Update quantities in Shopify"

Start: "Starting..." then `chat.server.shopifyUpdateQuantity(ConfigID)`; callbacks `shopifyUpdateQuantityProgress` (warning, + "..."), `shopifyUpdateQuantityComplete` (info), `shopifyUpdateQuantityException` (error). Button only exists when `SyncStockLevel` is on and the user is not read-only.

---

## 4. Orders: Pending orders tab, log, operations log

### 4.1 "Orders" tab (`/api/Shopify_Index_vShopifyPendingOrders`)

Server-paged; search + From/To date (change fires a search; the "To" min = From, the "From" max = To; a clear-dates button toggles class `has-filters`). Empty text "You do not have any pending Shopify orders at the moment.". Footer "Displaying pending Shopify orders {0} - {1} of {2}". Columns: validation icon column (`GetValidationColumnConfig`; rows whose `Error` is non-empty get `ValidationState = Invalid`, `ValidationText = Error` with `"` replaced by `'`), Order # (`OrderNumber`), Date (`InvoiceDate`, user date format), Customer (`Contact`), Product (`Name`), Quantity (`Quantity`), Total (`Total`, money). Row id is `OrderLineID` (lines, not orders).

Buttons: **Load orders** (`#divDownloadOrders`; hidden if `LoadOrdersFromShopify` off or read-only), **Process** (`#divProcessOrders`).

* Load orders dialog: label "Orders created since" (date, defaults today). Start validation: empty → "Please choose the orders created since date."; more than 365 days back → "The system only allows loading a maximum of one year of historical sales data." Otherwise "Starting..." then `chat.server.shopifyDownloadOrders(date as DD.MM.YYYY, ConfigID)`; callbacks `shopifyOrdersProgress` (warning, + "..."), `shopifyOrdersComplete` (info; refreshes the grid), `shopifyOrdersException` (error). If opened without a configured shop it appends "Please configure the Shopify integration before loading the transaction history..." (link to `/Shopify`).
* **Process** (`Shopify_Index_Process`): `POST` to the action of form `#frmProcess` with `{currentConfigID, connectionId}` (SignalR connection id, empty if hub fails). If `shouldUseShardPoolWorker` the button hides and the banner "Processing orders. This may take a few minutes." (`ShowProcessingBanner` in Main) shows. Response handling (`Main › HandleOrderProcessingInitiateResponse`): flags `IsOrderProcessingQueued`, `HasInternalError`, `IsOrderProcessingAlreadyRunning`. Without the worker flag and with none of them set the page just reloads; already running → banner "Order processing already running. Please wait until the current process finishes executing."; internal error → "An internal error occurred which is preventing the Order processing execution. Please contact support."; transport error → "Order processing failed.". Hub callbacks `orderProcessingComplete(configID)` → banner "Orders processed successfully." and grid refresh; `orderProcessingFailed(configID)` → failure banner. Callbacks for a different shop than the one on screen are ignored (case-insensitive id compare, `Shopify_IsSameConfigId`).

### 4.2 "Log" tab (`/api/Shopify_Index_vShopifyLogs`, one row per captured order **event**)

Model: `LogID`, `ConfigID`, `Date`, `DownloadDate`, `ProcessDate`, `OrderNumber`, `SaleTaskID`, `InventoryTaskID`, `Status`, `Type`, `FulfillmentNumber`, `SaleOrderNumber`, `StocktakeNumber`, `TT`. Empty text "You do not have any captured Shopify orders at the moment.". Footer "Displaying captured Shopify orders {0} - {1} of {2}". Page-size preference `ShopifyLogPageSize`.

Filters (params: `search, status, ConfigID, fromDate, toDate, typeFilter, dateColumn`): date-column picker "By Date" (`Date`), "Download Date" (`DownloadDate`), "Process Date" (`ProcessDate`); From/To; Type: All Types, `O` Sale order, `C` Credit note, `F` Fulfillment, `S` Payment, `R` Refund, `E` Export/Fulfillment, `X` Exchange; Status: All Statuses plus the list below; "Reset All"; "Refresh"; "Export".

| Column | Field | Rendering |
|---|---|---|
| Order # | `OrderNumber` | |
| Date / Download date / Process date | `Date`, `DownloadDate`, `ProcessDate` | user date format + ` H:i:s` |
| Status | `Status` | Processed, Processing (pending style), Pending, `ToLoad` "To be loaded", `NotReady` "Not ready to load", Archived, `ToCancel` "To be canceled", `ToVoid` "To be voided", Voided, `ToRestock` "To restock", `Previously Picked` "Previously picked", `Insufficient Stock` "Insufficient stock" |
| Type | `Type` | `O` Sale order, `C` Credit note, `F` Fulfillment, `S` Payment, `R` Refund, `E` "Fulfillment #{FulfillmentNumber}", `X` Exchange |
| Sale task | `SaleOrderNumber` | Link to the sale (`EscCommon_GetSaleLink`): route by `TT` (1 `/SaleService#`, 2 `/Sale#`, 4 `/CreditNote#`, else `/SaleMultiple#`) + `SaleTaskID`; text "Not processed yet" when blank. Link text is the SO number; per house rule the displayed label of a sale should be its customer reference, which this grid does not have |
| (delete) | | Not shown for type `X` with status `Processed`. Confirm "Deleting the log entry will allow reloading this order from Shopify. Would you like to proceed?"; then `DELETE /api/Shopify_Index_vShopifyLogs/{LogID}`; failure "Failed to delete this log entry." |

Export: `GET /api/EcsOrderLogExport` (binary) with `configId, search, status, from, to, type, dateColumn, sort(JSON array of {property,direction})`; blocks with "'From' date cannot be later than 'to' date." when from > to; downloads the file named in `Content-Disposition`.

### 4.3 "Operations log" tab (`/api/Shopify_Index_vShopifyOperationLogs`)

Model: `ID`, `ConfigID`, `Date`, `Description`, `Category`, `Processed` (bool), `Type` (int), `UserName`, `TT`. Page size fixed 10. Filters: search, From/To date, Type (All Types, `1` Error, `2` Warning, `3` Info), Category (All Categories, Configuration, Fulfillment, Products, Orders), "Reset All", "Refresh"; params `search, ConfigID, fromDate, toDate, typeFilter, categoryFilter`. Empty text "No entries found. Please hit refresh or change the search criteria.".

Columns: Date (red when `Type == 1`), Type (1 "Error" red, 2 "Warning", 3 "Info"), User, Category (red for errors), **Processed** (editable check column), Description (`|` becomes line break, `<span>` becomes `<b>`; red for errors). Checking "Processed" saves the store immediately (acknowledge an error). It is **not editable** for read-only users, nor for `Products` rows when any v2 product flag is on.

### 4.4 Overview tab (dashboard)

First tab "Overview" with a shop list plus "All stores" (`overviewConfigID = null`). Per-shop "Base settings" list (`Shopify_Index_GetPortalSettings`): "Consolidate orders" (yes unless `No consolidation`), "Update stock levels in Shopify" (yes/no), "Backorders" (yes/no from `SellOutOfStock`), "Location" (`LocationName`). "Sales summary" list from `GET /api/Shopify_Index_Dashboard_Summary?configID=` rows `{Period, Amount}`. "Sales over time" chart from `GET /api/Shopify_Chart_Sales` with `configID, dateFrom, dateTo, groupBy, type, timeZoneOffset`; controls: Group by (Day, Week, Month, "Hour of day"=`HourOfDay`, "Day of week"=`DayOfWeek`), Period (Today, Yesterday, Last 7/30/90 days, Last month, Last year, Week/Month/Quarter/Year to date, 1st-4th quarter (financial year aware), Custom; default Last 30 days; non-Custom disables the date pickers), Type ("Sales count" `SalesCount`, "Returns count" `ReturnsCount`, "Gross sales" `GrossSales`; series labels "Count of sales", "Count of returns", "Gross sales amount, {currency}"). Grouping `HourOfDay`/`DayOfWeek` forces Custom and disables the period and To date. Week/Month grouping widens dates to whole weeks/months. "'From' date cannot be later than 'to' date." blocks the call. No data shows `#Shopify_Chart_Sales-no-data`.

---

## 5. What other screens do for Shopify

| Where | Behaviour | Reference |
|---|---|---|
| Sale form (SaleMultiple) | Two fields are hidden by default (`#SaleMult_Index_ChannelOrderType_FormControl`, `#SaleMult_Index_PurchaseOrderReference_FormControl`). A read-only text "Channel order type" bound to `ChannelSourceType` is shown only when `SourceChannel === 'Shopify'` **and** `ChannelSourceType !== ''`. The purchase-order reference field is shown only when `SourceChannel === 'Shopify'` and `PurchaseOrderNumber !== null`. Both are set in the sale-load function. The type field is always disabled (`txtChannelOrderType.setDisabled(true)`) | `SM › txtChannelOrderType` creation; `SM › sale load` (the `masterTask.get('SourceChannel') === 'Shopify'` block) |
| Simple sale form | Same two rules with ids `#Sale_Index_ChannelOrderType_FormControl` / `#Sale_Index_PurchaseOrderReference_FormControl` | `SS › sale load` |
| Sale model | `SourceChannel` (string) and `ChannelSourceType` (string) are plain fields on the sale task; `StatusTracker.statuses.sourceChannel` caches `SourceChannel` for the Ship step. The Ship step has special behaviour only for channels beginning `AMAZON`, **none for Shopify** | `SM › StatusTracker.statuses.sourceChannel`, `SaleMult_Ship_Complete_Check` |
| Sales list | A "Channel" column renders `Channel` through a name map: `Pos`→"Cin7 Core POS", `B2B`→"Cin7 Core B2B", `Ebay`→"eBay", anything else (including `Shopify`) as-is. Automated workflow editor filters by `SourceChannel` values from `/api/vAutomatedWorkflow_Edit_vSaleChannels` | `SL › SalesChannelNameService`, column `colCT_Channel` |
| Product → "Additional descriptions" tab | Enabled when `(IsStock or IsNonInventory) and not IsGiftCard`. Loads `GET /api/Product_Index_vAdditionalDescriptions?ID={ProductID}`; each row is one external listing (`ShopName`, `ShopType`, `ProductID`, `SKU`, `ECSConfigID`, `ECSProductID`, `ECSVariantID`, `ECSDescription`, `SIMProductID`). A combo (display `ShopName`, value `SIMProductID`) picks the listing; shows channel logo (`/Images/Integrations/shopify.png` for `ShopType == 'Shopify'`), external product id, SKU, variation id (only when not the empty guid) and the description. When no rows: note "Note: This product is not linked to any external shop." Delete button: confirm "Deleting product mapping permanently? You can list this product again from {ShopType} the integration page.", then `DELETE /api/Product_Index_vAdditionalDescriptions?ProductID={id}&ConfigID={ECSConfigID}&ShopType={ShopType}` where `id` is `ProductID` for Shopify and `SIMProductID` for other shop types; toasts "Product mapping deleted" / "Failed to delete this product mapping." | `PR › Product_Index_LoadAdditionalDescriptionsTab`, `Product_Index_SelectProductDescription`, `Product_Index_DeleteProductMapping`, `setIntegrationImage` |
| Product → "Channels" tab | Enabled when `((IsStock or IsNonInventory) and not IsGiftCard) and not IsNewProduct`. Loads `GET /api/Product_Index_Channels?productID=` → `{DisplayProductName, DearAvailableTotal, ChannelStores:[{ConfigID, Name, StoreType, ListedProductName, IsListed, Locations:[{LocationID, LocationName, DearAvailable}]}]}`. Columns: "Sale Channel Store", "Dear Location" (sic), "Quantity", "Listed product to Sale Channel", "Status" ("Listed" / "Not Listed"), "Actions". Shopify rows: listed → links "Update", "Remove", "Unlink" (Unlink message says "Unlinking started..."); not listed → "List". Non-Shopify stores get different action sets. Each action `POST /api/Product_Channels_PerformAction` `{ProductID, Action: List|Update|Remove|Unlink, ConfigID, Profile?}` and shows the toast "Action added to the queue and will be performed soon."; the row text becomes "Listing started, please check the results in the notification." (etc.). Quantities for non-POS stores come from `POST /api/Product_Channels_SIMQuantity` `{productId, configID, locations}` → `{ConfigID, AvailableOnLocations:[{LocationID, Available}]}` | `PR › Channels` (`createChannelDataModel`, `appendChannelRow`, `performAction`), `Product_IsTabDisabled` |
| Onboarding wizard | Model fields `ShopifyConnected`, `ShopifyConfigID`, `ShopifyShopName`, `ShopifyProductsNumber`, `ShopifyOrdersNumber`, `ShopifyPriceTier`; the price tier chosen in the wizard is set on the Shopify model | `CS › ContinueSetup model`, `price tier switch` |
| Page registry | `/Shopify` is registered in Main's permission/page list as "Shopify" | `Main › PageKey list` |
| Integration tiles | Generic: the tile list comes from `/api/vCurrentIntegrations` (`ShopType`); nothing Shopify-specific in the script | `IL › Integrations_Index_Load` |

---

## 6. Tenant / account settings that change Shopify behaviour

Names as they appear in the scripts; where a field is per shop it is part of `vShopifyConfiguration` (section 1), not a tenant-wide setting.

* `TenantCurrency` (page global): chart label "Gross sales amount, {currency}".
* `UserDateFormat`, `FinancialYearEndMonth` / `FinancialYearEndDay`: drive date display, the 1st-4th quarter chart periods, and "year to date".
* `IsReadOnly` / access level from `CheckAccess('Shopify','Index')`: disables every editor (1.4).
* `window.installationCompanyName`: product name inserted into the stock-sync warning message.
* `OpenDetailsInNewTabs`: sale link in the Log grid and `Shopify_Index_EditCustomer` open in a new tab.
* `window.shouldUseShardPoolWorker`: selects the queued, asynchronous order-processing flow (banner, hub completion callbacks) over page-reload.
* Per-sale-screen attribute set: the "import tags/type to" fields map into the sale attribute set (custom fields on the sale); deleting or changing that default set yields messages 12/13 above.
* Master data source (`MasterDataSource`): server-supplied options; empty = `SOURCE SYSTEM`.
* Order routing (`OrderRouting2019.js` exists in the bundle set and is the origin of the `routing` option in the location combo; its internals were not read here).

---

## 7. Endpoint and payload index (field NAMES only)

| Endpoint | Method | Used for | Params / body fields |
|---|---|---|---|
| `/Shopify/GetFeatureFlags` | GET | UI feature flags | none → the six `isShopify...` flags |
| `/api/Shopify_Index_vShopifyConfiguration` | REST | Shop list and settings save | record = `vShopifyConfiguration` fields (1) |
| `/api/Shopify_Index_vShopifyTaxMapping` | REST | Tax grid | `ConfigID`, `Update`; record fields in 2.1 |
| `/api/Shopify_Index_LocationMapping` | REST | Location grid | `ConfigID`, `Update`; record fields in 2.2 |
| `/api/Shopify_Index_vShopifyPaymentProcessorMapping` | REST | Payment grid | `ConfigID`, `Update`; record fields in 2.3 |
| `/api/Shopify_Index_vTaxRules`, `_Locations`, `_LocationMapping_Locations`, `_vAccounts`, `_vLiabilityAccounts`, `_vRetailDeliveryFeeAccounts`, `_vRevenueAccounts`, `_vSalesPriceTiers`, `_vSaleAttributes`, `_vMasterDataSource`, `_vCustomer`, `_vCategory`, `_Family`, `_Tags`, `/api/USState` | GET | Lookup sources for combos | `vCustomer` and `Family`: `Name` query |
| `/api/Shopify_Index_vShopifyCatalogList` | GET | Catalog grid | `search, ConfigID`, paging, sort |
| `/api/Shopify_Index_vShopifyCatalog` | GET (side effects) | Product dialog operations | `ProductID, ConfigID, PriceTier, SellOutOfStock, UseBufferInventory, BufferInventory, Operation, Locations, ListAsDraft` |
| `/api/Shopify_Index_BulkList` | GET / PUT (unlist) / DELETE (unlink) | Bulk grid and bulk unlist/unlink | `search, Category, Family, Tag, ConfigID, listStatus, brandID, listedInConfigID` |
| `/api/Shopify_Index_vShopifyPendingOrders` | GET | Orders grid | `search, ConfigID, fromDate, toDate` |
| `/api/Shopify_Index_vShopifyLogs` (+ `/{LogID}` DELETE) | GET / DELETE | Log grid | `search, status, ConfigID, fromDate, toDate, typeFilter, dateColumn` |
| `/api/Shopify_Index_vShopifyOperationLogs` | REST | Operations log (PUT/POST on `Processed` change) | `search, ConfigID, fromDate, toDate, typeFilter, categoryFilter` |
| `/api/EcsOrderLogExport` | GET binary | Log export | `configId, search, status, from, to, type, dateColumn, sort` |
| `/api/Shopify_Index_Dashboard_Summary`, `/api/Shopify_Chart_Sales` | GET | Overview | `configID`; `configID, dateFrom, dateTo, groupBy, type, timeZoneOffset` |
| `/api/ECommerce_Common_BulkListing/product/brands`, `/shops` | GET | Bulk filter lookups | `currentConfigID` |
| form `#frmProcess` action | POST | Process pending orders | `currentConfigID, connectionId` |
| form `#frmAuthorise` / `#frmReauthorise` / `#frmUpdateConnection` / `#frmDisconnect` | POST (form) | Connect, reconnect, add scopes, disconnect | hidden `Shopify_Index_ReauthoriseShopName`, `Shopify_Index_UpdateConnectionShopName`, `DisconnectConfigID`; authorise form fields are server-rendered |
| SignalR `chatHub` server methods | hub | Long jobs | `shopifyDownloadProducts(images, archived, draft, ConfigID, fromDate)`, `shopifyDownloadCustomers(ConfigID)`, `shopifyDownloadOrders(DD.MM.YYYY, ConfigID)`, `shopifyUpdateQuantity(ConfigID)`, `shopifyBulkListing(...)` (3.2) |
| `/api/Product_Index_vAdditionalDescriptions`, `/api/Product_Index_Channels`, `/api/Product_Channels_PerformAction`, `/api/Product_Channels_SIMQuantity` | GET / DELETE / POST | Product screen (section 5) | as in section 5 |

---

## 8. Smaller details worth copying

* Switching shops clears the catalog, bulk and log stores and re-filters; the hash becomes `#Settings~{ConfigID}`. Tab ids: `tabNewShop`, `tabSetup`, `tabCatalog`, `tabBulkLoad`, `tabPendingOrders`, `tabLog`, `tabOperationsLog`; all but `tabNewShop` are disabled when no shop exists; `tabNewShop` is disabled for read-only users once a shop exists (`Shopify_IsTabDisabled`). Hash `#tab_overview` or none opens the Overview ("All stores").
* Each grid stores its column layout (`stateId` `ShopifyCatalog_4`, `ShopifyBulkListing_3`, `ShopifyPendingOrders_3`, `ShopifyLog_4`, `ShopifyOperationsLog_2`, `ShopifyTaxMappingGrid_2`, `LocationMappingGrid_1`, `ShopifyPaymentProcessorMappingGrid_1`) and each has a "reset layout" function.
* Progress/error messages from the server may contain `|` and are split into `<br/>` lines (`Shopify_SetValidation`); v2 messages are normalised so double `<br>` collapse (`NormalizeShopifyV2Message`).
* Time values: consolidation hour is stored in UTC; order lock date is a plain date; products-from date carries the user's UTC offset; the orders-since date is sent as `DD.MM.YYYY`.
* A voided log row's text would render struck through via `Shopify_Index_FormatTextGeneral` (`Status == 'VOIDED'`); not wired to any visible column in this bundle.

---

## 9. Not determinable statically

Everything below is server-side or in server-rendered HTML and cannot be recovered from these scripts:

* The OAuth connect flow itself: the `action` URLs and field names of `#frmAuthorise`, `#frmReauthorise`, `#frmUpdateConnection`, `#frmDisconnect`, `#frmProcess`, the requested Shopify scopes, how `NotAllScopesAdded` and `IsActive` are computed, where the access token is stored, and what disconnect deletes beyond what the static page says.
* Webhook subscription and how `Topic` (created / paid / fulfilled) maps to a Shopify event; order polling cadence; what "Pending" vs "ToLoad" vs "NotReady" mean precisely; when a log row is created; retry rules for `AutoSyncRetry`.
* Order to sale mapping: how an order becomes a sale task, which fields feed `SourceChannel`, `ChannelSourceType` (Shopify order type) and `PurchaseOrderNumber`; customer matching/creation when `UseCompanyAsCustomer` or consolidation is on; how consolidation groups orders and applies the frequency; how shipping, discounts (`AddDiscountAsChangedPrice`, `BringDiscountCodes`), gift cards (liability account), retail delivery fees, and tax names are turned into lines and accounts; rounding; currency handling; how `OrderLockDate` and `OrderExclusionTags` filter orders; what "Insufficient stock" and "Previously picked" detection does.
* Fulfilment: how each `AutoShippingMode` advances pick/pack/ship, how fulfilment is pushed back to Shopify (tracking URL, partial fulfilment per location), restock rules for unfulfilled sales, refunds/exchanges/credit notes (types `C`, `R`, `X`).
* Products: matching rules between Shopify products/variants and Cin7 products (SKU, name uniqueness with `AllowDuplicateNames`, `SupportDuplicatedSKU`, `MasterDataSource`), what is overwritten on import, which Shopify fields are created on export, how price tiers and compare-at price map, kit/assembly links (`IsLinkToKitProduct`), how `SyncQuantity` is computed (available stock at the mapped location(s), minus buffer inventory, per-product override), the schedule of automatic stock pushes and automatic product download. There is **no unmatched-product dialog** in the Shopify page script; mismatches surface only as `Error` text on pending-order lines and as Operations Log entries.
* Server-side validation beyond the client messages, the exact content of the `Message` / `AdditionalProperties` payloads, and the text of server error strings.
* The sets returned by the lookup endpoints (which accounts qualify as liability, revenue, retail-delivery or payment accounts; which attribute fields qualify; which locations are listed besides `routing`; the master-data-source options beyond `SOURCE SYSTEM`).
* Rate limiting, batching and timeouts on the Shopify side, the meaning of the `HighLoad` and `UseLogging` flags (carried in the model, unused by the client), and the `ShippingTaxed` flag (model only).
