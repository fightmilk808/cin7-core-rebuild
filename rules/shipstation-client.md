# Cin7 Core ShipStation integration: client-side behaviour (static analysis of the shipped page scripts)

Source: public ExtJS bundles in the public page bundles Cin7 serves to every browser, beautified into a scratch copy and read as text only (nothing executed, no call to the live app or to ShipStation, no Cin7 write). No tenant data, no credentials.

How to read this file

- Bundle names are written without `.js`; `function` is the function or window variable that does the work. Line numbers are not given (the shipped files are minified).
- The page is server-rendered. The JS wires controls by DOM id. Labels of static controls are in the sibling spec (`spec/modules/12-integrations/shipstation/UI.md`); this file records only what the JS decides: option lists it injects, defaults it applies, show/hide and enable/disable rules, validation text, endpoints and payload field names.
- Everything below is in `Shipstation2019` unless another bundle is named. `IsReadOnly` is set from the access level returned by `CheckAccess('ShipStation','Configuration')`.
- Endpoints are internal `/api/<Controller>_<Action>` REST routes (GET list, PUT/POST/DELETE write). Payloads are the ExtJS model JSON (`getData(true)` or the store writer), so the field names are the model fields.

## ⚠️ Gotchas: the sneaky stuff

The surprising, easy-to-get-wrong and silently failing behaviours the page scripts show, worst first. Everything is from static reading, so what the server does is not covered (see the end of the file). Each links to the section with the full rule.

> [!CAUTION]
> **Deleting an order-log row lets the order be loaded again.** The confirm text says deleting the log entry allows reloading the order from ShipStation, so a deleted row on a processed order may let it come back as a second sale on the next load (inferred).
> [Full rule: 6. Pending orders, logs, processing](#6-pending-orders-logs-processing-store)

> [!CAUTION]
> **A user can mark a pending order "Processed" by hand.** The log Status cell is editable only while it is Pending, and any other change saves immediately. The order is then treated as processed without a sale being created (the Sale task column shows "Manually processed").
> [Full rule: 6. Pending orders, logs, processing](#6-pending-orders-logs-processing-store)

> [!CAUTION]
> **The Custom Store tab has no Save button.** Every control writes the moment it changes, with no confirm, and only the Enabled checkbox shows a "Changes saved" toast.
> [Full rule: 7. Custom Store tab](#7-custom-store-tab-vcustomintegration-one-row)

> [!CAUTION]
> **Toggling "Import shipping costs" silently resets "Apply tax on shipping costs".** The apply-tax box is cleared on every change of the import box, and the Zero tax rule is saved as an empty string whenever its row is hidden, so re-enabling tax or import can blank a rule you set earlier.
> [Full rule: 4.2 Export-to-ShipStation setup](#42-export-to-shipstation-setup-visible-when-export-is-on)

> [!WARNING]
> **The "resend to ShipStation" button is often hidden.** On a multi-fulfilment sale it needs the integration connected, a shipment line, Ship authorised, no tracking number on any line, and "Export sales fulfilled externally" on. If that last flag is off the button is missing even though everything else is true.
> [Full rule: 9. What the sale screens do for ShipStation](#9-what-the-sale-screens-do-for-shipstation)

> [!WARNING]
> **Shipping-service export and Custom Store block each other in the browser.** Turning export on while the Custom Store is enabled is refused with a "Disconnect Custom Store" alert, and while export is on the Custom Store checkbox is disabled. "Schedule export" only appears while export is off, and leaving the tab with unsaved export changes asks before discarding them.
> [Full rule: 4.1 Fields](#41-fields)

> [!WARNING]
> **Consolidation time is stored as a UTC hour.** The dropdown shows the local hour but saves the UTC hour of it.
> [Full rule: 2.1 Fields](#21-fields)

> [!WARNING]
> **Settings are packed into generic `Parameter*` slots.** `Parameter5` is a JSON blob (currency, units, package dimensions) with a legacy fallback where it is the weight unit; `Parameter9` is a second JSON blob; `Parameter10` is the margin, where a `%` prefix means relative and a plain number means absolute. Reading these as plain values breaks the page.
> [Full rule: 4.1 Fields](#41-fields)

> [!WARNING]
> **Credentials are stored as one `key:secret` string split at the first colon.** The connect form pre-fills by splitting on the first `:`, and the page does no JavaScript validation of blank values, so the server decides what is accepted.
> [Full rule: 1. Connect / disconnect / reactivate](#1-connect--disconnect--reactivate)

> [!WARNING]
> **The same Cin7 location cannot map to two warehouses.** Picking one already used shows a warning and clears the row, so a mapping edit can empty a cell you meant to change. The same rule applies on the Shipping service location grid.
> [Full rule: 3. Mapping grids](#3-mapping-grids-store-setup)

> [!WARNING]
> **Catalog "Unlink" may throw at runtime.** It calls two helpers that are not defined in the bundle, so a clone should not copy that call text.
> [Full rule: 5. Catalog tab](#5-catalog-tab-product-linking)

> [!NOTE]
> **The scripts are inconsistent in places.** Two save buttons share an id, route casing mixes `Shipstation` and `ShipStation`, and the apply-tax and zero-tax logic is written with inverted `toggleContent` calls. Clone by observed behaviour, not call text.
> [Full rule: 11. Quirks worth knowing before cloning](#11-quirks-worth-knowing-before-cloning)

## 0. Page structure and boot

| Rule | Source | Behaviour |
|---|---|---|
| One page, three connection kinds | `Shipstation2019` `ShipStationFF_Index_AccessCallback` | Page has: **Store** (an e-commerce style config, `vEcsConfiguration`, tab "ShipStation Store" inserted after Overview), **Custom Store** tab (`vCustomIntegration`, one row), and **Shipping service** tab (`vShipServConf`, one row, `li-tab-ship-service`). |
| Load order | `ShipStationFF_Index_AccessCallback` | Ten stores load in parallel: `vEcsConfigurationStore`, `vShipServConfStore`, `mailingListsStore`, `TaxStore`, `vSalesPriceTiersStore`, `LocationStore`, `CurrencyStore`, `AccountStore`, `RevenueAccountStore`, `vCustomIntegrationStore`. `ShowMainContent()` runs only when all ten returned success. |
| Read-only mode | `ShipStationFF_Index_AccessCallback` | When access is `ReadOnly`: disable the Custom Store checkboxes (`#Shipstation_Index_CustomerStoreStatus`, `#ShipStation_StockLocator`, `#ShipStation_ExportFFOrders`, `#ShipStation_ImportShippingCosts`, `#ShipStation_ApplyTaxOnShippingCost`, both ignore-billing radios); hide `add-new-shop`, `btnSaveSetupChanges`, `btnSaveServiceChanges`, `divDisconnect`, `divDisconnectSS`, `divDownloadProducts`, `divLoadLocationMapping`, `divDownloadOrders`, `divAddTaxMapping`, `divProcessOrders`, `divDownloadCustomers`, `ShipstationFF_Catalog_List`; disable the Width/Height/Length inputs. Every grid cell editor returns false from `beforeedit` while `IsReadOnly`. |
| Tab state in URL hash | `ShipstationFF_Index_UpdateSelectedTabFromHash`, `ShipStationFF_Index_Events` | `location.hash` follows the shown main tab; `#Settings~<configID>` opens the store tab for that config. With no usable hash the Overview tab opens. |
| Which store sub-tab is allowed | `ShipStationFF_IsTabDisabled` | `tabSetup`, `tabCatalog`, `tabPendingOrders`, `tabLog` disabled unless a store config exists (`vEcsConfigurationStore.getCount() > 0`). `tabAuth` ("Action required") disabled unless the selected config is not active (`IsActive` false). Empty id is disabled. `tabOperationsLog` is never disabled. |
| First available tab | `ShipStationFF_SetFirstAvailableTab` | If the current tab is disabled: `tabSetup` when allowed, else `tabAuth`. |
| Tab load actions | `ShipStationFF_SetActiveTab` | `tabSetup`: reload the three mapping stores (location, tax, payment processor) with `ConfigID`. `tabCatalog`: refresh and run catalog search. `tabPendingOrders`: refresh and search. `tabLog`: refresh and search. `tabOperationsLog`: refresh and search. |
| Active vs inactive store | `ShipStationFF_Index_ChangeShop` | `IsActive` true: hide `#authError`, click `#setupLinkTab`. Otherwise show `#authError` and click its link (the "Action required" pane). |
| Add-new tab visibility | `vEcsConfigurationStore` load; `vShipServConfStore` load | `add-new-shop` shown when there is no store config **and** no shipping-service config (`SetButtonVisible('add-new-shop', shipServCount === 0)` after the store loads; `storeCount === 0` after the service loads; `!IsReadOnly` when neither exists). `li-tab-ship-service` shown only when a shipping-service config exists. |
| Order-routing block | `vEcsConfigurationStore` load | `#ShipStation_Index_EnableOrderRoutingBlock` is un-hidden only when the first config's `AvailableEnableOrderRouting` is true. |
| Scroller | `ShipStationFF_Index_CreateControls` | Main tab strip is a `lightSlider` (`autoWidth`, `loop:false`, `pager:false`). |
| Unsaved-change guard | `ShipStationFF_ShippingService_LeaveTab`, `_LeaveConfirmation`, `_RollbackUnsaved` | Leaving the Shipping service tab while `IsExportSettingSaved` is false asks `All unsaved changes will be lost. Would you like to proceed?` (Yes!/No). On yes the export controls roll back to the stored `IsExportOrdersEnabled`. |

## 1. Connect / disconnect / reactivate

All three are plain HTML form posts (not Ajax). The endpoint URLs are the forms' `action` attributes, which are server-rendered and not in the bundle.

| Control | Source: function | Payload (field names only) | Behaviour |
|---|---|---|---|
| API key / API secret inputs | `ShipStationFF_Index_CreateControls`: `txtApiKey` (input id `key`), `txtApiSecret` (input id `secret`) | form `frmAuthorise` posts `key`, `secret`, `connectionType` | Both are width 350 text fields. No JS validation of blank values (server decides). |
| "Connect ShipStation as a Store" `#btnConnectAsStore` | `ShipStationFF_Index_Connect` | sets hidden `#connectionType` = `store`, submits `frmAuthorise` | |
| "Connect ShipStation as a shipping service" `#btnConnectAsShipServ` | `ShipStationFF_Index_ConnectShipService` | sets `#connectionType` = `shipservice`, submits `frmAuthorise` | |
| Double-submit guard | `ShipStationFF_Index_AccessCallback` | | `form#frmAuthorise` uses `preventDoubleSubmission()`. |
| Pre-fill of stored credentials | `ShipStationFF_Index_UpdateControlSizes_NewTab` | reads `Parameter1` (shipping service) or `AccessToken` (store) | The stored value is one string `key:secret`; the page splits at the first `:` and puts the parts in the two inputs. Each connect button is hidden once that connection kind exists (`btnConnectAsShipServ` hidden when `hasSS`; `btnConnectAsStore` hidden when `hasEcs`). When either exists the `#connectCredentials` and `#credentialsTitle` blocks are hidden and `#noteConnect` is shown; otherwise the reverse. |
| "Open ShipStation API settings" | `ShipstationFF_Index_ApiSettingsOpen` | | opens `https://ss.shipstation.com/#/settings/api` in a new window (credentials are obtained there). |
| Disconnect store | `ShipStationFF_Index_Disconnect` | hidden `#DisconnectConfigID` = current config id, submits `frmDisconnect` | Confirm dialog: title `Confirmation`, text `Are you sure you want to disconnect from ShipStation?`, buttons `Disconnect` (danger) / `No`. No-op when `IsReadOnly`. |
| Disconnect shipping service | `ShipStationFF_Index_DisconnectSS` | hidden `#DisconnectSSConfigID` = `currentSSConfigID`, submits `frmDisconnectSS` | Same confirmation text. |
| Reactivate (Action required pane) | `ShipStationFF_Index_Reactivate` | hidden `#RefreshConfigID` = current config id, submits `frmReactivation` | No-op without a current config. |
| Make default shipping service | `ShipStationFF_Index_MakeDefaultSS` | hidden `#SSConfigID` = `currentSSConfigID`, submits `frmMakeDefaultSS` | `#ShipStationFF_Index_MakeDefaultButton` shown only when the service config is **not** `IsDefault`. No-op when read-only. |
| Onboarding entry | `ContinueSetup` `SalesChannel_ShipStation_OpenSyncDialog` (called by the sales-channel switch on hash `start`) | | If the hash is not `start` it shows modal `#dlgError`, title `Connection to ShipStation ...`, body `Connection to ShipStation failed.Refresh page and try again.` (sic, no space after the full stop). The setup model carries `ShipStationConnected`, `ShipStationConfigID`, `ShipStationShopName`, `ShipStationProductsNumber`, `ShipStationOrdersNumber`, `ShipStationPriceTier`; a price-tier choice in setup sets `ShipStationPriceTier`. The sync-dialog function itself is not in the bundle. |
| Integration icon | `Product2019` (product integration-source renderer) | | `ShipStation` maps to image `/Images/Integrations/shipstation25.png`. No other product behaviour references ShipStation. |
| Menu entry | `Main2019` `pageMapping` | | `{PageKey:'/ShipStation/ConfigurationNG', PageName:'ShipStation'}`. |

## 2. Store setup tab (`vEcsConfiguration`)

Store: `vEcsConfigurationStore`, REST `/api/ShipStation_Index_vEcsConfiguration`, id `ID`. Save = `ShipStationFF_Index_Submit` (button `#btnSaveSetupChanges`; shared id is also used by the shipping-service pane, which rebinds its own handler through `#divSaveChanges`).

### 2.1 Fields

Model fields: `ID, TenantID, ShopName, AccessToken, RefreshToken, PrimaryPriceTier(int), ConsolidationType, ConsolidationTimeText, ConsolidateToCustomerID, IsActive, PickWhenOrderStatus, ShippingTaxed, SyncStockLevel, AutoInvoicingMode, AutoFulfilmentMode, ECSspecificParameter5, ECSspecificParameter7(bool), CustomerName, RevenueAccount, CustomSalesRepresentative, LocationID, CompatibleToDEAR, ManualMapping, AutoCreateNewProductAllowed, MatchProductByName, EnableOrderRouting, AvailableEnableOrderRouting, UseAsMasterSource, CreateAssembly, IgnoreRestockForNotFulfilled`. `AccessToken`/`RefreshToken` are never edited in the UI.

| Label (see UI.md) | Model field | Control (window var) and options | Default / load rule | Show-hide-enable rule |
|---|---|---|---|---|
| Capture order when it is | `PickWhenOrderStatus` | combo `cmbTopic`, `editable:false`, local `TopicStore`: `created`=Created, `paid`=Paid, `notonhold`=Not on hold, `shipped`=Shipped | value from record | none |
| Consolidate sales | `ConsolidationType` | combo `cmbConsolidationType`, `editable:false`: `Daily consolidation`, `No consolidation` | from record | Consolidation time row `#liShipStationFF_Index_ConsolidationTime` visible only when value is `Daily consolidation` (on `change`) |
| Consolidation time | `ConsolidationTimeText` | combo `cmbConsolidationTime`, width 90, `editable:false`, `vTimeStore` | 24 entries `00:00`..`23:00`; display text is the hour, **stored value is the UTC hour** of that local hour (`ShipStationFF_Index_AddTime`: sets local hours then `getUTCHours()`, `HH:00`) | see above |
| Customer | `ConsolidateToCustomerID` (+`CustomerName`) | remote typeahead combo `cmbCustomer`, `queryParam:'Name'`, `minChars:0`, store `/api/ShipStation_Index_vCustomer`; list header row "Add a new customer" opens `/Customer` in a new window (`ShipStationFF_Index_NewCustomer`) | on load: record seeded into store so the saved name shows; empty id clears | on save: id present but not found in store -> error toast `Please choose a customer from the dropdown list or create a new customer.`; empty -> both fields set null |
| Sale price tier | `PrimaryPriceTier` | combo `cmbPrimaryPriceTier`, `editable:false`, `forceSelection`, store `/api/ShipStation_Index_vSalesPriceTiers` (`Code`,`Name`) | from record | none |
| Pick, pack, and ship processing mode | `AutoFulfilmentMode` | combo `cmbAutoFulfilmentMode`, `editable:false`: `Draft`=Draft order, `None`=No picking, `Pick`=Auto pick, `Pack`=Auto pick + pack, `Ship`=Auto pick + pack + ship | from record | `#chkIgnoreRestockForNotFulfilledContainer` shown only when value is `Ship` (on `change`), hidden otherwise |
| Ignore restock for non fulfilled sales | `IgnoreRestockForNotFulfilled` | checkbox `#divIgnoreRestockForNotFulfilled` | from record | only visible with mode `Ship` |
| Invoice status | `AutoInvoicingMode` | combo `cmbInvoiceStatus`, `editable:false`: `DRAFT`=Draft, `AUTHORISED`=Authorized | from record | none |
| Optional revenue account | `RevenueAccount` | combo `cmbRevenueAccount`, local, editable, store `/api/ShipStation_Index_vRevenueAccounts` (`Code`,`DisplayName`); list has a first row "Clear selection" that sets null; `Common_COA_TreeMode_RestoreCodes` post-processes the load | value applied after the account store loads | none |
| ShipStation dimensions units | `ECSspecificParameter5` | combo `cmbShipStationDimUnits`, `editable:false`: `in`=Inches, `cm`=Centimeters | from record | none |
| Sales representative name | `CustomSalesRepresentative` | text `txtCustomSalesRepresentative`, emptyText `write...` | from record | none |
| Match product manually | `ManualMapping` | checkbox `#ShipStationFF_Index_Mathcing` | from record | when checked, hide `#ShipStationFF_Index_AllowCreateDearProducts`; when unchecked show it (also on load) |
| Create a new product if not found by SKU | `AutoCreateNewProductAllowed` | checkbox `#ShipStationFF_Index_AllowCreate` | from record | hidden while Match product manually is checked |
| Use ShipStation as master source for Cin7 Core products | `UseAsMasterSource` | checkbox `#ShipStationFF_Index_UseAsMaster` | from record | also drives the catalog dialog (section 5): when false the "do not update linked product" block is hidden |
| Shipment is taxable | `ECSspecificParameter7` | checkbox `#ShipStationFF_Editor_ShipmentTaxable` | from record | none |
| Enable order routing | `EnableOrderRouting` | checkbox `#ShipStation_Index_EnableOrderRouting` | from record | block shown only if `AvailableEnableOrderRouting` is true |
| Process auto-assembly | `CreateAssembly` | combo `cmbCreateAssembly`, `editable:false`, width 270: `always`=For ordered quantity, `basedonavailability`=For minimum quantity required for picking | from record | none |

Save logic (`ShipStationFF_Index_Submit`):
- No current config: validation banner `Please select a shop to manage before saving the changes.` (rendered in `#setupValidation` as `<div class="note note-danger">`; `|` in a message becomes `<br/>`).
- All fields above are copied into the record, then `vEcsConfigurationStore.save()` (REST write to `/api/ShipStation_Index_vEcsConfiguration`), then `ShipstationFF_Index_ValidatePortalTabs`. Success toast: `Changes saved successfully.` Errors are emitted as separate error toasts (`Dear_Notification_Error`) and the save is skipped.
- `SyncStockLevel`, `ShippingTaxed`, `MatchProductByName`, `LocationID`, `CompatibleToDEAR` are loaded but never written by this page's controls (server-owned / used elsewhere: `SyncStockLevel` shows or hides catalog Quantity and the sync-stock block).

### 2.2 Setup-completeness indicator (`ShipstationFF_Index_ValidatePortalTabs`)

Runs after every load/save of customer and the three mapping stores. Builds a multi-line message; if non-empty the warning marker `#tabSetupValidator` is shown with that text as its `data-content` popover, else hidden. A line is added when:

| Condition | Message (verbatim) |
|---|---|
| no customer chosen in `cmbCustomer` | `Please select the default customer to be used for sales when no customer info is available in Shipstation or in the daily consolidation mode.` |
| tax mapping store empty, or any row has empty `Value` | `Please map your tax rules to rules defined in Shipstation to correctly generate accounting transactions.` |
| location mapping store empty, or any row has empty `LocationID` | `Please map your warehouses to locations defined in Shipstation for proper accounting.` |
| payment-processor mapping store empty, or any row has empty `LedgerAccount` | `Please map your Shipstation payment methods to accounts.` |

## 3. Mapping grids (store setup)

All use `Ext.grid.plugin.CellEditing` with `clicksToEdit:1`, cell-model selection, `maxHeight:300`, and write on edit (`store.getProxy().extraParams = null; store.save()` then `ValidatePortalTabs`). A delete column (`extExtension.column.getDelete`) confirms with `Confirmation` / the text below, buttons `Yes` / `No`.

| Grid (window var) | Store, endpoint, fields | Columns (header -> field, editor, renderer) | Rules and messages |
|---|---|---|---|
| Tax mapping `vShipStationFFTaxMappingGrid` into `#divTaxMapping` | `vEcsTaxMappingStore` `/api/ShipStation_Index_vEcsTaxMapping`, load param `ConfigID`. Fields `ID, ECSConfigID, ECSTaxType, ECSTaxID, Description, Value, TaxRuleName, SortOrder` | `Type` -> `Description` (read only); `Tax rule` -> `TaxRuleName`, combo over `TaxStore` (`/api/ShipStation_Index_vTaxRules`, `RuleID`/`Description`), local typeahead, `minChars:0`, case-insensitive regex filter; delete column | Empty cell text renders red `Please choose a tax rule.` On edit the chosen description is matched back to `RuleID` and written to `Value`; no match or blank sets `Value` and `TaxRuleName` null. Rows with `ECSTaxType` = `Default Lines Tax` or `Default Additional Charges Tax` cannot be deleted: warning toast `Default tax entries cannot be deleted.` Delete confirm text: `Would you like to delete this tax mapping entry?` Empty text: `Loading ShipStation tax rates...` |
| Add US place of business | modal `#ShipstationFF_TaxMapping_AddTaxMapping`, button `#divAddTaxMapping` ("Add a US place of business"), save `#ShipstationFF_TaxMapping_Save` | three remote typeahead combos: ZIP (`txtZip`, `minChars:2`, queryParam `zip`, rows shown as `<b>{ID}</b> - State: {Description}`), County (`txtCounty`, queryParam `county`, extra param `zip`), City (`txtCity`, queryParam `city`, extra params `zip`,`county`); all `forceSelection`; endpoint `/api/Shipstation_Index_vEcsUSTaxTypeAhead` | County starts disabled and enables on ZIP select; City starts disabled and enables on County select; clearing ZIP disables and clears both; clearing County disables and clears City. Save validations (error toasts, in order): `Please specify a zip.`, `Please choose a county.`, `Please choose a city.`, `A field cannot include a comma character.` Then POST via `vUSTaxMappingStore` (`/api/Shipstation_Index_vTax`, fields `id, configid, zip, city, county`, values trimmed), reload tax mapping, clear and close modal. |
| Warehouse -> location mapping `vLocationMappingGrid` into `#divLocationMapping` | `vEcsLocationMappingStore` `/api/Shipstation_Index_vEcsLocationMapping`; fields `ID, ECSConfigID, ECSLocationName, ECSLocationID, LocationID, LocationName`. Option source `LocationStore` `/api/ShipStation_Index_vLocation` (`LocationID`,`Description`) | `Name` -> `ECSLocationName` (read only); `Location` -> `LocationName`, local typeahead combo over location `Description` | Same location cannot be used for two rows: warning toast `Cannot map the same location to multiple warehouses.` and the row is cleared. Blank/unknown clears `LocationID` and `LocationName`. Empty cell renders red `Please choose a location.` Delete confirm: `Would you like to delete this location mapping entry?` Empty text `Loading ShipStation warehouses...` Button `#divLoadLocationMapping` ("Load from ShipStation") reloads the store with `ConfigID` and `Update:'1'` (server refreshes the ShipStation-side rows); no-op when read-only. |
| Payment method -> account `vShipStationFFPaymentProcessorMappingGrid` into `#divPaymentProcessorMapping` | `vEcsPaymentProcessorMappingStore` `/api/ShipStation_Index_vEcsPaymentProcessorMapping`; fields `ID, ConfigID, PaymentProcessorID, PaymentProcessorName, LedgerAccount, AccountName, SortOrder`. Option source `AccountStore` `/api/ShipStation_Index_vAccounts` (`Code`,`DisplayName`) | `Name` -> `PaymentProcessorName` (read only); `Payment account code` -> `LedgerAccount`, local typeahead combo (`valueField Code`, `displayField DisplayName`) | Unknown selection nulls `LedgerAccount`. Empty cell renders red `Please choose the payment account.` Delete confirm: `Would you like to delete this payment processor mapping entry?` Empty text `Loading ShipStation payment methods...` After load/write `EcsCommon_TogglePaymentProcessorMappingInfoMessage` shows `.paymentProcessorMappingInfo` while any row lacks an account (`LedgerAccount` or `AccountCode`), hides it when all are mapped. Help text in the HTML says accounts must be type BANK or have the payment indicator. |

## 4. Shipping service tab (`vShipServConf`, one row)

Store `vShipServConfStore`, REST `/api/ShipStation_Index_vShipServConf`. Save (`#divSaveChanges` -> `ShipStationFF_Index_SubmitSS`): PUT `/api/ShipStation_Index_vShipServConf/<currentSSConfigID>` with `Ext.encode(rec.getData(true))` (includes the nested `vExportFilters`, `vCarrierServiceList`, `vCarrierList` associations), timeout 2,000,000 ms, with `blockUI`. Success: `window.IsExportSettingSaved = true` and toast `Changes saved successfully.`; failure: error toast with the server message. If the record is not dirty: warning toast `There is nothing to save.` The save button is visible on the Setup sub-tab and hidden on the Shipment log sub-tab.

Pre-save validation (`Shipstation_Index_Validate`): when "Send predefined package dimensions" is checked and any of Width/Height/Length is empty -> error toast `Please define all package dimensions.` and no request. Export-filter grid also validates (section 4.4) and blocks the save.

### 4.1 Fields

Model fields: `ID, ModuleType, Parameter1..Parameter10, CanCalcRate, IsDefault, TaxRule, UseCustomerTaxRule, SendNotificationOnLabelGeneration, PrintShippingLabels, IsExportOrdersEnabled, IsShipstationUseStockLocator, IsShipstationExportFFOrders, IsImportShippingCosts, IsApplyTaxOnShippingCost, ShippingCostZeroTaxRule, IsIgnoreBillingContact, NotificationIfExportSuccessfulMailingList, IsInternalNotificationIfExportSuccessful, NotificationIfExportFailsMailingList, IsInternalNotificationIfExportFails, NotificationIfExportShippedMailingList, IsInternalNotificationIfExportShipped`; associations `vExportFilters`, `vCarrierServiceList`, `vCarrierList`.

Generic `Parameter*` slots used by this page:

| Slot | Meaning |
|---|---|
| `Parameter1` | credentials string `key:secret` (read to pre-fill the connect form; never written here) |
| `Parameter2` | default ship-from address id (`AddressID`) |
| `Parameter3` | selected ShipStation store id for exported orders |
| `Parameter5` | JSON blob `{Currency, WeightUnit, DimUnit, Height, Width, Length, AddDefaultDimensions}` (`setDefaultValues`/`getDefaultValues`); legacy fallback when the blob is absent: `Parameter5` = weight unit, `Parameter6` = dimension unit, `Parameter9` = currency |
| `Parameter7` | from company on shipping label |
| `Parameter8` | from contact on shipping label |
| `Parameter9` | JSON blob `{AddDefaultCarrierServicePackage, CarrierServiceDomestic, PackageDomestic, CarrierServiceInternational, PackageInternational}` (`setDefaultCarrierServiceValues`/`getDefaultCarrierServiceValues`) |
| `Parameter10` | shipping margin: `%` prefix + number means relative, plain number means absolute; empty = 0 |

| Label (UI.md) | Field | Control and options | Load / save rule |
|---|---|---|---|
| Integrate with ShipStation: Export sale orders / Without export | `IsExportOrdersEnabled` | radios `#ShippingService_Export_On` / `_Off` | On: reveals `#divShippingServiceExportSetup` (export setup). Off: hides it. Switching On while the Custom Store is enabled is refused: alert titled `Disconnect Custom Store` with text `Export of sale orders from Shipping Service cannot be connected at the same time as ShipStation Custom Store. Please disable the connection from ShipStation Custom Store tab to proceed.` Conversely, while export is On the Custom Store checkbox `#Shipstation_Index_CustomerStoreStatus` is disabled (`ShipStationFF_ShippingService_ExportControls`). Any switch clears `IsExportSettingSaved`. Dirty is forced when the value changed. |
| Default ship from address | `Parameter2` | combo `cmbFromAddress` over `/api/Shipstation_Index_vTenantAddress` (`AddressID, Line1, Line2, CitySuburb, StateProvince, ZipPostCode, Country, CountryLine`); list shows Line1 / city, state, zip / country; display `CountryLine` | |
| Use tax rate from | `UseCustomerTaxRule` | select `Default` / `Customer`; stored as boolean (`'true'` = Customer) | `Customer` hides the "Tax rule for shipping" row `#ShipStationFF_ShipServ_TaxRuleBlock`; `Default` shows it. |
| Tax rule for shipping | `TaxRule` | combo `cmbTaxRuleForShipping` over `TaxStore` | |
| Weight units in ShipStation | in `Parameter5` blob `WeightUnit` | combo `cmbWeightUnit`, local: `g`=grams, `kg`=kgs, `oz`=ounces, `lb`=lbs | |
| Dimension units in ShipStation | blob `DimUnit` | combo `cmbDimUnit`, local: `cm`=cm, `in`=inches | Changing it rewrites the UOM cell (`td.dimensions-unit`) of the dimensions table. |
| Currency in ShipStation | blob `Currency` | remote typeahead combo `cmbCurrency` over `/api/Currency`, `queryParam Code`, shown `{Code} - {Name}`, `forceSelection` | |
| Additional shipping margin / Margin value is | `Parameter10` | number field `txtMarginValue` (`allowBlank:false`, precision 2, no spinner) + select `Absolute`/`Relative` | Save writes `'%'+value` when Relative else value. Tooltip on the select: `You control how an additional shipping margin will be added: as an absolute value or as a percentage.` Tooltip on "Use tax rate from": `You control what tax rate will be used for shipping.` |
| Send notification on shipping label generation | `SendNotificationOnLabelGeneration` | checkbox | |
| From contact on shipping label | `Parameter8` | text `txtFromContactOnShippingLabel` (`allowBlank:false`) | |
| From company on shipping label | `Parameter7` | text `txtFromCompanyOnShippingLabel` (`allowBlank:false`) | |
| Print shipping labels | `PrintShippingLabels` | checkbox `#StarShipIt_ShipServ_PrintShippingLabels` | |
| Preferred carriers/services | `vCarrierServiceList` | multi-select `cmbCarrierServiceList` + chip container `#divSelectedCarrierServiceValues`; options from `/api/Sale_Index_LookupCarrier` with params `shippingServiceID` (= current service config), `carrierCode`, `serviceCode`, `jsonData`; row fields `FakeID, CarrierCode, ServiceCode, Highlighted, DisplayName, CarrierServiceCode, Domestic, International` | Save serialises chips to rows `{DisplayName, ServiceCode, CarrierCode}`; marks the record dirty only if the list of names changed. The same load also fills the default-service dropdowns (below). |
| Send predefined package dimensions | blob `AddDefaultDimensions` | checkbox `#AddPackageDimensions` | Toggles the dimensions table section (`.dimensionsSection`). |
| Select carriers | `vCarrierList` | multi-select `cmbCarrierList`, chips `#divSelectedCarrierValues`; options from `/api/Shipstation_Ext_Carrier` with `ConfigID`, `page:1,start:0,limit:25,box:'undefined'`; row `{value,name}` | Same dirty-if-changed logic. |
| Predefined package dimensions table | blob `Width`, `Height`, `Length` | three number fields (`input-small`, `maxLength 6`, precision 2, no spinner), disabled when read-only | Saved only inside the `Parameter5` blob. The page text says units follow the dimension unit above. |
| Use default shipping instructions | blob `AddDefaultCarrierServicePackage` (in `Parameter9`) | checkbox `#AddDefaultCarrierServicePackage` | Turning it **on** asks (title `Confirm default shipping instructions`, text `The default carrier, service, and package will be automatically selected when creating a new shipment for an order. Default values can be manually edited when processing a sale. Do you want to continue?`, buttons Yes/No); No reverts the checkbox. Section `.carrierServicePackageSection` shows only while on. |
| Domestic shipping / Domestic package / International shipping / International package | blob `CarrierServiceDomestic`, `PackageDomestic`, `CarrierServiceInternational`, `PackageInternational` | four selectpickers `#cmbCarrierServiceDomestic`, `#cmbPackageDomestic`, `#cmbCarrierServiceInternational`, `#cmbPackageInternational` | Service lists are filled from the preferred-services store, filtered by its `Domestic` / `International` boolean per row (`PopulateComboLists`). Choosing a service loads its packages from `/api/Shipstation_Ext_CarrierPackage` with `ConfigID`, `carrierCode` (from the selected option's `data-code`), `box:'undefined'`, `page:1,start:0,limit:25`; package rows `{name,value,Domestic,International}`. Package select is disabled while no service is chosen or the package list comes back empty. |

### 4.2 Export-to-ShipStation setup (visible when export is On)

| Label | Field | Control | Rule |
|---|---|---|---|
| Use stock locator instead of location as warehouse | `IsShipstationUseStockLocator` | checkbox `#chkShippingServiceStockLocator` | dirty forced if changed |
| Export sales fulfilled externally | `IsShipstationExportFFOrders` | checkbox `#chkShippingServiceExportFFOrders` | same. Reported to the sale screens as `ExternallyFulfiledOrdersToShipStation` (section 7). |
| Capture ship to company as | `IsIgnoreBillingContact` | radios `#rbtShippingServiceIgnoreBillingContactTrue` ("Leave blank when ship to company is not specified.") / `...False` ("Use customer name when ship to company not specified") | Load: true selects the first radio, otherwise the second. |
| Export sales to ShipStation store | `Parameter3` | combo `cmbSSStore`, emptyText `Select store`, options from `/api/Shipstation_Index_vStore?ConfigID=<service config id>` (`name`,`value`) | list reloads after the service config loads |
| Import shipping costs | `IsImportShippingCosts` | checkbox `#chkShippingServiceImportShippingCosts` | When **checked** the "Apply tax on shipping costs" row (`#divShippingServiceApplyTaxOnShippingCost`) is **un**hidden and the apply-tax box is cleared on every change; when unchecked the apply-tax row is hidden. (Implementation toggles with `toggleContent(!isChecked)`, i.e. the hide flag is the inverse of checked.) |
| Apply tax on shipping costs | `IsApplyTaxOnShippingCost` | checkbox `#chkShippingServiceApplyTaxOnShippingCost` | Saved true only if the row is visible **and** checked. |
| Zero tax | `ShippingCostZeroTaxRule` | combo `extSSCmbTax` over `/api/ShipStation_Index_vZeroTax` (`RuleID`,`Description`), `forceSelection` | Row `#divShippingServiceShippingCostZeroTaxRuleBlock` is shown only when Import shipping costs is checked **and** Apply tax on shipping costs is unchecked (same rule as the Custom Store tab). Implementation: `toggleContent(flag)` hides when `flag` is true; Import-costs change calls it with `!checked`, Apply-tax change with `checked`, `_ExportControls` with `applyTax \|\| !importCosts`. Saved as `''` when the row is hidden. |
| Map Cin7 Core Locations to ShipStation Ship From Locations | store `vShipIntegrationLocationMappingStore`, `/api/Shipstation_Index_vShipIntegrationLocationMapping` | fields `ID, ConfigID, WarehouseName, WarehouseId, LocationID, LocationName, IsActive`; grid created lazily (`ShipStationFF_CreateShipIntegrationLocationMappingGrid`) in `#divShipIntegrationLocationMapping` | Columns `Name` -> `WarehouseName` (read only) and `Location` -> `LocationName` (combo over `ShipServLocationStore`, filled from `LocationStore` minus the all-zero GUID). Same duplicate rule/message as 3, delete confirm text `Would you like to delete this location mapping entry?` with title empty and button `Yes!`. Empty cell renders grey `Please choose a location.` Button `#divLoadShipIntegrationLocationMapping` ("Load from ShipStation") reloads with `ConfigID: currentSSConfigID, Update:'1'`; no-op without a service config or when read-only. |
| Notification recipient(s) for successful order export / failed order export / on ship of exported order | `NotificationIfExportSuccessfulMailingList`, `NotificationIfExportFailsMailingList`, `NotificationIfExportShippedMailingList` | three multi-select selectpickers, options from `/api/Shipstation_Index_vMailingList` (`ID`,`Name`) | stored as comma-joined ids (load splits on `,`) |
| Internal notification (x3) | `IsInternalNotificationIfExportSuccessful`, `...Fails`, `...Shipped` | checkboxes | dirty forced if changed |

### 4.3 Shipment log sub-tab (`ShipmentLogTab('Shipstation')`)

Grid `ExportLogGrid` (stateful, paged 10) into `#divShipmentLogGrid`; store `/api/Shipstation_Index_vShipstationExportOrdersLog`, fields `ScheduledPeriod, OrderNumber, FulfillmentNumber, InvoiceNumber, OrderID, FulfillmenID, InvoiceID, CustomerName, ShipByDate, Status, Comments, StatusDate`. Request params: `configId` (current service config), `search`, `status`, `period_beg`, `period_end`.

| Column | Field | Render |
|---|---|---|
| Scheduled for export | `ScheduledPeriod` | date |
| SO # | `OrderNumber` | link to `OrderID` when id non-empty, else plain text |
| Fulfillment # | `FulfillmentNumber` | link from `FulfillmenID` (sic) |
| Invoice # | `InvoiceNumber` | link from `InvoiceID` |
| Customer | `CustomerName` | text |
| Ship by | `ShipByDate` | date |
| Status | `Status` | date (`StatusDate`) + badge: `Skipped`->"Skipped" (class `draft`), `Failed`->"Failed" (`notinvited`), `Exported`->"Exported" (`invited`), `Shipped`->"Shipped" (`authorised`), `Cancelled`->"Canceled" (`notinvited`) |
| Comments | `Comments` | multiline text |

Controls: period select `This week / Previous week / This month / Previous month / Custom` (`thisWeek, prevWeek, thisMonth, prevMonth, custom`) sets the from/to dates (week and month boundaries via moment `startOf/endOf`; date boxes disabled unless `custom`; a change of the To date or a valid custom range re-runs the search); status select `All / Shipped / Exported / Skipped / Canceled / Failed`; text search (Enter or button); Refresh calls `show()` (reload scheduled-export info, search, refresh view). Date validation: From later than To clears both and warns `'From' date cannot be later than 'to' date.` Empty text: `You do not have any exported sale orders at the moment.`; paging text `Displaying exported sale orders {0} - {1} of {2}`.

"Schedule export" (`#btnShippingServiceScheduleExport`, visible only while export is **off**) opens a dialog with From/To date fields (emptyText `Choose date`). Submit (`submitScheduleExportDialog`): both dates required else error toast `Please specify export period.`; POST `/api/Shipstation_Index_vShipstationExportOrdersManualPeriod/` with `{configId, periodBeg, periodEnd}`; success toast `Sale orders with shipment authorization between <from> to <to> have been scheduled for export.` and `#divScheduledExportMessage` shows the period; error toast with server message. On show, GET of the same URL (param `configId`) returns `{periodBeg, periodEnd}` and the message is shown only when both exist.

### 4.4 Sale order export filter (`OrderExportFilterGrid('ShipStation')`)

Grid into `#gridShipmentServiceFilter`, rows are `vExportFilter`: `ParameterName, Condition, Value, Join, ValidationText, ValidationState`. Option source for parameter: `/api/ShipStation_Index_vShipStationExportOrdersFilterParameter` (`Value, Name, Group, IsFirst`; grouped list with group header rows). Columns: validation icon; `Parameter name` (non-editable combo, appends " ship to" for `ship_to.company` and " bill to" for `bill_to.company`); `Condition` (`=` Equals, `%` Contains, `!%` Does not contain, `0` Empty, `!0` Not empty); `Value` (text); `Join` (`And`, `Or`); delete. Rules:

- Value cell is not editable when Condition is `0` or `!0`; choosing those conditions blanks Value.
- "Add filter" (`.js-btn-add-filter`) appends a row; if the previous row has no Join it is set to `And`.
- Delete confirm: `Are you sure you want to remove this line?` (`Yes, delete it!` / `No`).
- Validation per row (joined with `<br />`, state `Invalid`, else `Good`): `Please select parameter name.`, `Please select condition.`, `Please specify value.` (Value required when Condition is `=`, `%` or `!%`). Any error -> error toast `There were problems saving changes. Please check errors in details.` and the save is aborted.
- Empty text `You do not have any filters at the moment.`; no paging.

## 5. Catalog tab (product linking)

| Rule | Source: function | Detail |
|---|---|---|
| Grid | `CatalogGrid` (store `productStore`, `/api/Shipstation_Index_vEcsProductList`, param `mode:'variations'`, `search`, `ConfigID`, `lang`) | Model `vEcsCatalogItemNew`: `SIMID, ProductID, FamilyID, EntityType, LinkedSKU, LinkedName, SKU, Name, Status, ImageID, SyncStockLevel, Price, Category, Option1..3, IsStockProduct, IgnoreProductUpdation, Quantity`. Columns: `SKU`, `Name`, `Category`, `Price` (blank for `EntityType='FamilyProduct'`), `Status` (badge `invited` when `Listed`, else `notinvited`; text localised `Listed`/`Not listed`), `Quantity` (id `colQty`), `Linked product` (image + `LinkedName` over `LinkedSKU`, or grey `No product linked.`). Empty text `There are no products in the catalog.` |
| Quantity column | `ShipStationFF_Index_CatalogGrid_ResetLayout`; renderer | Column visible only when `!IsReadOnly` and the config's `SyncStockLevel` is true. Cell blank when unlinked or family; stock product with `SyncStockLevel` shows the quantity; stock product without it shows a red exclamation icon; non-stock shows the number. |
| Row click | `CatalogGrid` `cellclick` | `EntityType='FamilyProduct'` -> `ShipStationFF_Index_FamilyCatalog_Edit` (not defined in this bundle); otherwise `ShipStationFF_Index_Catalog_Edit`. |
| Link dialog | `ShipStationFF_Index_Catalog_Edit`, modal `#ShipStationFF_Index_Catalog` | Shows SKU, name, price, category, image (`/Product/GetEcsImage?id=<SIMID>&size=120`, zoom), type text `Stock product` or `Non-physical product / service`, status. "Do not update the linked product" block hidden unless config `UseAsMasterSource`; "sync stock level" block hidden unless config `SyncStockLevel`. Three radios `radioActionToDo`: `null` (unlinked), `link`, `build`. Opens on the Unlinked pane when no product, else Linked pane. Product picker `cmbCatalogLinkToProduct`: remote, `queryParam Name`, value `ProductCode`, options from `/api/Shipstation_Index_Product` (`ProductID, ProductCode, Name, Available, OnHand, ImageID, IsStockProduct`) with params `ConfigID, IsStockProduct, Name, lang`; row shows `SKU:` and `Available/on hand`. Picking a product sets the "ignore update" box to true when the picked SKU differs from the ShipStation SKU. |
| Save link | `ShipStationFF_Index_Catalog_Update` | POST `/Shipstation/ChangeMappingAndSyncStock` (timeout 600000) with `ConfigID, SIMProductID, ProductID, SyncStockLevel, IgnoreProductUpdation`. `null` choice sends `ProductID` null, `SyncStockLevel` true, `IgnoreProductUpdation` false and zeroes the row's quantity; `link` sends the chosen product, `SyncStockLevel` false and the ignore flag, and updates the row from the picked product (`LinkedSKU, LinkedName, ProductID, ImageID, Quantity=Available`). `build` choice via Save only warns `Please create a new {company} product or link ShipStation product to {company} products.` Failure toast `An error occurred during saving.` |
| Build product | `#btnBuildProduct` | PUT `/api/Shipstation_Index_CheckProduct?ConfigID=..&SIMProductID=..` (timeout 2,000,000) -> toast `Product '{0}' has been built.` and the row is linked to the returned product. Failure `An error occurred during saving.` |
| Duplicate-SKU probe | `ShipStationFF_CatalogManagment_CheckProduct` | GET `/api/Shipstation_Index_CheckProduct` with `ConfigID, SimProductID`: success shows the Build button; HTTP 409 means a product with the same SKU exists: if it is the one already linked the Create option is disabled and a preview shown, else the dialog shows `An error occurred. Please try to reopen the dialog; if the error will appear again, please contact support.` The warning text is `We have found {1} product with the same SKU ({0}). Please note that we cannot create another product with the same SKU in {1}.` with a button `Link to this {0} product` and alternatives (link to an existing product, select another product, change the SKU of the existing product). |
| Unlink | `#ShipstationFF_Catalog_List` -> `ShipStationFF_Index_Catalog_UnList` | Removes the record from `productStore` and saves; shows `Unlinking the product...`. It calls `ShipStationFF_Index_Catalog_StartSaving` / `_SetValidation`, which are **not defined** in the bundle (possible runtime error; do not replicate). No-op when read-only. |
| Load products | `#divDownloadProducts` -> modal `#ShipstationFF_DownloadProducts_Content` | Option "Enable image download" with note `Enabling this option would increase the time taken to download products.` Start sends over the SignalR hub `chatHub`: `sIMDownloadCatalog(ConfigID, 'ShipStation', enableImgDownload)`; status area shows `Starting...`. Client callbacks: `simDownloadCatalogProgress(ConfigID, message)` -> `<message>...` (warning style); `simDownloadCatalogResult(ConfigID, errorMessage, successMessage)` -> success note and/or error note, re-enables actions and refreshes the catalog. Callbacks ignore other configs. |
| Load customers | `#divDownloadCustomers` | Hub call `sIMDownloadCustomers(ConfigID, 'ShipStation')`; callbacks `simDownloadCustomersProgress`, `simDownloadCustomersComplete` (success), `simDownloadCustomersException` (error). |
| Search | `#divSearchCatalog` (Enter), `#divRefreshCatalog` | `ShipStationFF_Index_CatalogSearch` returns without config; reloads page 1. Page text `Displaying products {0} - {1} of {2}`. |

## 6. Pending orders, logs, processing (store)

| Rule | Source: function | Detail |
|---|---|---|
| Pending orders grid | `PendingOrdersGrid`, store `/api/Shipstation_Index_vShipstationPendingOrders` (search param) | Model `vECSPendingOrdersNew`: `OrderLineID, OrderNumber, DateCreated, Name, Quantity, Total, CustomerName, Error, ValidationText, ValidationState`. Columns `Order #`, `Date`, `Customer`, `Product`, `Quantity` (right), `Total paid` (right, money). After load, any row whose `Error` is non-empty gets `ValidationText = Error` (double quotes turned into single) and `ValidationState = 'Invalid'`. Empty text `You do not have any pending orders at the moment.`; page text `Displaying ShipStation pending orders {0} - {1} of {2}`. |
| Load orders | `#divDownloadOrders` -> modal `#ShipstationFF_DownloadOrders_Content` | Date field `dtFromOrders` (default today, emptyText `Choose...`). Start requires a date: `Please choose the orders created since date.` Hub call `sIMDownloadSales(ConfigID, 'ShipStation', From)`. Callbacks `simDownloadSalesProgress` (`<message>...`), `simDownloadSalesComplete` (success), `simDownloadSalesException` (error); on finish the pending list reloads. `ShipStationFF_Index_DownloadOrders_Show(true)` appends the note `Please configure the ShipStation integration before loading the transaction history...` (link to `/ShipStation/ConfigurationNG`). |
| Process | `#divProcessOrders` -> `ShipStationFF_Index_Process` | Starts SignalR, then POST to the `frmProcess` form's action with `currentConfigID`, `connectionId` (empty string if the hub fails). While `shouldUseShardPoolWorker` the button is hidden and the banner `Processing orders. This may take a few minutes.` shows. Response handling (`Main2019` `HandleOrderProcessingInitiateResponse`): reload the page unless queued/internal error/already running; `IsOrderProcessingAlreadyRunning` -> banner `Order processing already running. Please wait until the current process finishes executing.`; `HasInternalError` -> `An internal error occurred which is preventing the Order processing execution. Please contact support.`; request error -> `Order processing failed.` Hub callbacks `orderProcessingComplete` (banner `Orders processed successfully.`, refresh pending list) and `orderProcessingFailed` (banner `Order processing failed.`) re-show the button. |
| Order log grid | `LogGrid`, store `/api/ShipStation_Index_vEcsLogs` (params `search`, `ConfigID`; editable, writer json) | Model `vECSOrderLog`: `LogID, ConfigID, Date, OrderNumber, SaleTaskID, Status, Type, SaleOrderNumber, RefundID, OrderID, IsNewSale`. Columns: `Status` (green bold `Processed`; underlined bold `Pending`; `To restock` for `ToRestock`; editor combo `StatusStore` Pending/Processed), `Date` (with time), `Invoice #` (`OrderNumber`), `Type` (`O`=Sale order, `C`=Return), `Sale task` (link `/SaleMultiple#<SaleTaskID>` when `IsNewSale`, else `/Sale#<SaleTaskID>`; blank number renders `Manually processed` if Processed, `Never processed` if Voided, else `Not processed yet`), delete. Status is editable only when its current value is `Pending`; editing to blank or back to Pending reverts; any other change saves the store (this is how a user marks a pending order Processed manually). Delete confirm: `Deleting the log entry will allow reloading this order from ShipStation. Would you like to proceed?`; DELETE `/api/ShipStation_Index_vEcsLogs/<LogID>`, failure toast `Failed to delete this log entry.` Empty text `You do not have any captured orders at the moment.`; page text `Displaying entries {0} - {1} of {2}`. |
| Order log export | `EcsOrderLogExport` | Period combo from `Common_GetDatePeriodStore` (default `Last Month`; non-`Custom` periods fill and disable the From/To date boxes). GET `/api/EcsOrderLogExport` (binary) with `configID, from, to, search, sort` (JSON of the grid sorters); the file name comes from the `Content-Disposition` header. From later than To -> error toast `'From' date cannot be later than 'to' date.` |
| Operations log grid | `OperationsLogGrid`, `/api/Shipstation_Index_vOperationLogs` (page size 10) | Model `vEcsOperationLog`: `ID, ConfigID, Date, Description, Category, Processed, Type, UserName, ConfigName, ConfigType, Disabled`. Columns `Date`, `Type` (1=Error in red, 2=Warning, 3=Info), `User`, `Category`, `Processed` (check column; toggling saves the store; disabled when read-only), `Description` (`|` becomes line break, `<span>` becomes bold; red for errors). Error rows render red across columns. Empty text `No entries found. Please hit refresh or change the search criteria.` |
| Searches | Enter in each search box | each reloads page 1 with `search` (and `ConfigID` for logs). |

## 7. Custom Store tab (`vCustomIntegration`, one row)

Store `vCustomIntegrationStore`, REST `/api/ShipStation_Index_vCustomIntegration`, id `Enabled`. Model: `ShipstationUseStockLocator, ShipstationExportFFOrders, ShipStationTimezone, Enabled, ImportShippingCosts, ApplyTaxOnShippingCost, ShippingCostZeroTaxRule, IgnoreBillingContact, CustomStoreCurrency`. Every control writes immediately (no Save button): the change handler sets the field on row 0 and calls `vCustomIntegrationStore.save()` (no-op when read-only). The `Enabled` change additionally toasts `Changes saved successfully.`

| Label | Field | Control | Rule (`ShipStationFF_Index_UpdateCustomIntegrationStatus`, run after every load/write) |
|---|---|---|---|
| Custom Store Integration status | `Enabled` | checkbox `#Shipstation_Index_CustomerStoreStatus` | Disabled while the shipping-service export is On. When **off**: hide every block below and the "Tasks not ready for ShipStation" panel; the tab `tabNotMatchingAddresses` is disabled. When **on**: show the blocks, enable that tab. |
| Use stock locator instead of location as warehouse | `ShipstationUseStockLocator` | `#ShipStation_StockLocator` | block shown when Enabled |
| Export sales fulfilled externally | `ShipstationExportFFOrders` | `#ShipStation_ExportFFOrders` | block shown when Enabled |
| Import shipping costs | `ImportShippingCosts` | `#ShipStation_ImportShippingCosts` | block shown when Enabled |
| Apply tax on shipping costs | `ApplyTaxOnShippingCost` | `#ShipStation_ApplyTaxOnShippingCost` | shown when Enabled **and** Import shipping costs is on |
| Zero tax | `ShippingCostZeroTaxRule` | combo `cmbZeroTax` over `/api/ShipStation_Index_vZeroTax` (`forceSelection`, emptyText `Choose...`); saved on select | shown when Enabled **and** Import shipping costs is on **and** Apply tax on shipping costs is off |
| Capture ship to company as | `IgnoreBillingContact` | radios `..._true` / `..._false` (second radio writes `!checked`) | block shown when Enabled |
| Currency in ShipStation | `CustomStoreCurrency` | combo `cmbCustomStoreCurrency`, `editable:false`, remote over `/api/Currency` (`Code`), `forceSelection`; saved on valid `change` | block shown when Enabled |
| Tasks not ready for ShipStation | store `mainStore` `/api/Shipstation_Index_vShipstationNotMatchingAddresses` (`root`, search param) | grid columns `Invoice #` (link `/Sale#<id>`), `Customer` (link `/Customer#<CustomerID>`), `Invoice date`, `Ship by`, `Address` (line 1 over line 2), `Reason` (html). Model fields `TaskID, InvoiceNumber, ShippingAddressLine1, ShippingAddressLine2, CustomerName, CustomerID, InvoiceDate, ShipmentRequiredByDate, Reason`. Empty text `All sale tasks have matching customer addresses.` | |

## 8. Overview tab

| Rule | Source: function | Detail |
|---|---|---|
| Base settings summary | `ShipstationFF_Index_GetShopSettings` | List of `Export sales to ShipStation` (yes/no from the Custom Store `Enabled`), and when a store config exists also `Consolidate orders` (no when `ConsolidationType === 'No consolidation'`) and `Shipment is taxable` (from `ECSspecificParameter7`). |
| Sales summary | `ShipstationFF_Index_ChangeOverview` | GET `/api/Shipstation_Index_Dashboard_Summary` with `configID`; rows `{Period, Amount}` become list items; the portlet `#overview-sales-summary-portlet` is shown only when rows exist. Without a config the shop logo shows and the summary box is hidden. Refresh button `#divRefreshSalesSummary` re-runs it. |
| Sales sub-tab | `OverviewSalesGrid`, `/api/Shipstation_Index_vShipstationOverviewSalesList` | Model `vEcsOverviewSalesList`: `SaleOrderDate, SaleOrderNumber, CustomerName, Status, PaidTotalAmount, InvoiceStatus, OrderStatus, FulFilmentStatus, PaymentStatus, TaskID, TT, ConfigID`. Columns: status icons (ordered / fulfilled / invoiced / paid, colour grey-orange-green by status string; `Voided` text for VOIDED), `Number` (link by `TT`: 1 `/SaleService#`, 2 `/Sale#`, 4 `/CreditNote#`, else `/SaleMultiple#`, id = `SaleTaskID` or record id), `Date`, `Customer`, `Amount`. Empty text `No sales yet.` |
| Customers sub-tab | `OverviewCustomersGrid`, `/api/Shipstation_Index_vShipstationOverviewCustomersList` | Columns `Customer` (click opens `/Customer#<id>`), `Sales` (`OrderCount`), `Amount`. Empty text `No customers yet.` |

## 9. What the sale screens do for ShipStation

Only one feature: a "resend to ShipStation" button. No push button for unshipped sales, no status column, and `SalesList2019` does not mention ShipStation at all.

| Rule | Source: function | Detail |
|---|---|---|
| Tenant flags | `SaleMultiple2019`, `SimpleSale2019`, `AwaitingSale2019`: model of the sale reference-data row | Boolean fields `ShipStation` (a ShipStation shipping-service integration is connected) and `ExternallyFulfiledOrdersToShipStation` (sic; the shipping-service export option "Export sales fulfilled externally" is on). Copied into `window.Shipstation` and `window.ExternallyFulfiledOrdersToShipStation` when reference data loads (`AwaitingSale2019` copies only `Shipstation`). The same row carries `ShipZonesEnabled`, which hides `divGetShippingRate_Order` when off (not ShipStation specific). |
| Button `#divResendToShipStation` (multi-fulfilment sale) | `SaleMultiple2019` fulfilment-load routine | Hidden by default. Shown only when `Shipstation` is true **and** the fulfilment has at least one shipment line **and** the ship step status is Authorized **and** no shipment line has a tracking number **and** `ExternallyFulfiledOrdersToShipStation` is true. |
| Click, multi-fulfilment | `SaleMult_Ship_CreateControls` | PUT `/SaleMultiple/ResendToShipStation` with param `TaskID` = the selected fulfilment task id (`window.SelectedFFTaskID`). Success toast (info) `The fulfillment has been scheduled to be sent to Ship Station.` (sic, "Ship Station"); failure toast (error) `Failed to schedule the fulfillment to be sent to ShipStation.` |
| Button (classic simple sale) | `SimpleSale2019` sale-load routine | Evaluated on first load only. Shown when `Shipstation` is true, the sale has shipment lines, ship status is Authorized, no line has a tracking number, and (`ExternallyFulfiledOrdersToShipStation` is true **or** the fulfilment `StatusTracker.fulfillment.used` equals that flag, i.e. both false). Otherwise hidden. Hidden again whenever the ship status is not Authorized. |
| Click, simple sale | same routine | PUT `/Sale/ResendToShipStation` with param `TaskID` = the sale task id. Success (info, title `Done`) `The sale has been scheduled to be sent to ShipStation.`; failure (warning) `Failed to schedule the sale to be sent to ShipStation.` |
| Shipments grid header | `SaleMultiple2019` | When `ContainExternalFulfillment` the third shipments-grid header reads `Carrier / shipping service`, otherwise `Carrier`. |
| Where shipments get carrier/service | `Sale_Index_LookupCarrier`, `/api/Shipstation_Ext_Carrier*` | The preferred-carrier/service lists configured in section 4.1 feed the carrier and service pickers on shipment lines; not further ShipStation-specific in the sale bundles read. |

## 10. Tenant settings that change ShipStation behaviour (field names)

| Field | Where | Effect |
|---|---|---|
| `ShipStation` (bool) | sale reference data | gates the resend button (section 9) |
| `ExternallyFulfiledOrdersToShipStation` (bool) | sale reference data | resend button visibility rule (section 9); mirrors shipping-service `IsShipstationExportFFOrders` |
| `ShipZonesEnabled` (bool) | sale reference data | shipping-rate button visibility on the order (feature flag, not integration specific) |
| `IsExportOrdersEnabled` | `vShipServConf` | switches sale-order export on; mutually exclusive with the Custom Store `Enabled` |
| `Enabled` | `vCustomIntegration` | custom store integration on/off; drives which settings are visible |
| `UseAsMasterSource`, `SyncStockLevel`, `ManualMapping`, `AutoCreateNewProductAllowed`, `EnableOrderRouting` / `AvailableEnableOrderRouting`, `AutoFulfilmentMode`, `AutoInvoicingMode`, `CreateAssembly`, `PickWhenOrderStatus`, `ConsolidationType` | `vEcsConfiguration` | see section 2 for the UI effect; their business effect is server-side |

## 11. Quirks worth knowing before cloning

- Mixed `Shipstation` / `ShipStation` casing in routes: pages use `/api/ShipStation_Index_*` and `/api/Shipstation_Index_*`; ASP.NET routing is case-insensitive so both reach the same controllers.
- Two save buttons share the id `btnSaveSetupChanges` (store setup) vs `divSaveChanges` (shipping service); the page hides `#divSaveChanges` on the log sub-tab.
- `ShipStationFF_Index_Setup_SetValidation` is the only place validation is drawn as a banner; everything else is a toast.
- The apply-tax / zero-tax visibility logic in the shipping-service pane is written with inverted `toggleContent(!flag)` calls; clone by observable behaviour in the table above, not by the call text.
- `ShipStationFF_Index_Catalog_UnList` references helpers that do not exist in this bundle.

## Not determinable statically

- Everything the server does: how ShipStation orders are captured and turned into sales (the `PickWhenOrderStatus` semantics, consolidation, tax/location/payment lookups), customer matching, price-tier use, auto-pick/pack/ship and invoicing, assembly creation, order routing.
- What `Update:'1'` does when loading warehouse/location mappings (assumed: refresh ShipStation-side rows server-side), and how `ConfigID` rows are created on connect.
- Connect, disconnect, reactivate, make-default and process form `action` URLs, and what the server checks on the key and secret (including error text shown after a failed connect).
- Export mechanics: when a sale is "scheduled for export", how filters are evaluated against sale fields (`ParameterName` values come from the server list), how `Status` transitions Skipped/Failed/Exported/Shipped/Canceled, retry rules, and what the resend endpoints actually queue.
- Shipping-cost import, margin application, rate calculation (`CanCalcRate`) and label generation; how tracking numbers flow back onto shipments.
- Sync of stock levels (`SyncStockLevel`) and product updates when `UseAsMasterSource` / `IgnoreProductUpdation` are set; family-product linking (`ShipStationFF_Index_FamilyCatalog_Edit` is not in the bundle).
- `SalesChannel_ShipStation_OpenSyncDialog` (onboarding sync dialog) and the SignalR hub server methods beyond their names and arguments.
- Option lists that are server-fed (parameter names for the export filter, mailing lists, carriers, services, packages, ShipStation stores, tax rules, accounts) and any defaults applied when a record is first created.
- Permission model beyond `ReadOnly` (the access callback only distinguishes that level in this bundle).
