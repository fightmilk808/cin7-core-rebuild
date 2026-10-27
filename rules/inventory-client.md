# Inventory: client-side behaviour of Cin7 Core (from shipped page scripts)

Source: static reading of the public, minified ExtJS page bundles (beautified copies, never executed, no calls to Cin7).
Bundles: `Product2019.js`, `ProductFamily2019.js`, `ProductFamilyList2019.js`, `StockAdjustment2019.js`, `StockAdjustmentList2019.js`, `StockTransfer2019.js`, `StockTransferList2019.js`, `Stocktake2019.js`, `Stock2019.js`, `ReorderLevelOfStock2019.js`, `ReorderSuggestion2019.js`, `ReorderBackorderedStock2019.js`, `PriceList2019.js`, `GiftCards2019.js`, `RecallReport2019.js`, plus helpers in `Main2019.js`.
Rule references are `Bundle :: function` (line numbers move between beautifiers, so function names are the anchor).
Scope: only what the browser decides. Anything the server decides is listed at the end under "Not determinable statically". Message text is verbatim from the scripts (including odd spelling).
No company data appears here. Everything is a rule, a constant or a message string.

## ⚠️ Gotchas: the sneaky stuff

> [!CAUTION]
> **Transfer quantity above available is shown in red but not blocked**
>
> The client colours TransferQuantity red when it exceeds QuantityAvailable but sends the data anyway (client script). The same holds for negative stock in general: the bundles show red text, and any hard stop would be a server message the scripts do not contain. [details](#35-line-rules)

> [!CAUTION]
> **Changing Cost type re-prices every new-stock line and overwrites typed unit costs**
>
> On an adjustment, switching the Cost type combo (Average, Latest, Fixed) after the first load re-prices every new-stock line via the server, including lines whose unit cost was typed by hand. A zero unit cost is allowed by the client with no check. [details](#24-line-rules)

> [!CAUTION]
> **Importing adjustment lines replaces everything already on the grids**
>
> Applying an upload replaces both the existing-stock and new-stock stores and marks every row Edited; it does not merge. The stocktake bulk new-line import also overwrites a matching row's Quantity, ExpiryDate and UnitCost instead of adding to them. [details](#23-endpoints-and-payloads)

> [!CAUTION]
> **Barcode scans add to the count instead of setting it**
>
> In an adjustment, scanned quantities are added to Adjustment (which holds the new quantity) for existing lines and to Quantity for new lines, and the stocktake scan mode increments counts too. Scanning the same item twice therefore counts it twice. [details](#24-line-rules)

> [!CAUTION]
> **Product merge cannot be reversed**
>
> Merge needs at least two products and a chosen primary, and the client warns that it is not reversible and must be repeated in the accounting software. [details](#111-product-list-page)

> [!WARNING]
> **On an adjustment line, Adjustment is the new quantity, not a delta**
>
> The field named Adjustment holds the new quantity; the Variance column (new minus on hand) is the real delta. Negative entries are coerced to 0, and for the plain serial method SN a value above 1 is forced to 1. A stocktake's Adjustment is likewise an absolute count, and the variance is posted server side. [details](#24-line-rules)

> [!WARNING]
> **Not-sellable is stored inverted**
>
> The "I am selling this product" combo shows Yes for the stored value 'false' and No for 'true', and a new product starts at 'false'. Copy the inversion or every product's sellable flag flips. [details](#11-field-inventory-model-vproduct-product2019js--extdefinevproduct)

> [!WARNING]
> **The auto-disassembly check clears the wrong checkbox**
>
> Ticking auto-disassembly with an unsupported costing method clears auto-assembly (not auto-disassembly) and shows the disassembly alert; this is what ships. Any change of the BOM combo also resets both flags to false. [details](#16-bom-selector-and-assembly-controls)

> [!WARNING]
> **Costing-method changes follow a one-way matrix with an odd helper**
>
> A non-serial method cannot become a serial method (the combo reverts with an error), and any non-FIFO target demands a batch/serial number. IsSpecialCostingCostingMethod is literally SN or BATCH or FEBATCH, which looks wrong but ships. [details](#13-costing-methods-main2019--createcostingmethodstore)

> [!WARNING]
> **Gift card HS code and country blanking never fires from the client**
>
> The type store saves the value GiftCard but the save routine tests for 'Gift Card', so the branch that blanks HS code and country of origin never runs for gift cards. [details](#12-product-types-product_editor_init--producttypestore)

> [!WARNING]
> **Changing the product type silently resets several fields**
>
> A type change resets the BOM selector to none, clears the fixed-asset type, may clear the default location, and switching to Service converts any calculated price tier using F, L, HF or HL back to a plain price with markup value 0. [details](#15-what-shows-or-hides-by-type-product_index_updatecontrolsvisibility-product_istabdisabled)

> [!NOTE]
> **Cost, availability and negative-stock rules are not in these scripts**
>
> Cost layers, average-cost updates, in-transit valuation, negative-stock blocking and all server validation messages are decided server side and cannot be read from the bundles. How a product enters the Setup required status beyond the make-to-order case is also unknown. [details](#8-not-determinable-statically)

---

## 1. Product form

### 1.1 Field inventory (model `vProduct`, Product2019.js :: `Ext.define('vProduct')`)

| Field (JSON) | UI control id | Kind | Notes |
|---|---|---|---|
| `ProductCode` | `txtProductCode` (SKU) | text | Required. Disabled and read-only with placeholder `auto-generated` when tenant `SkuAutogeneration` is true (`Product_Editor_Init`). Save sends `SkuAutogenerationFlag`. |
| `Name` | `txtProductName` | text | Required. Disabled for QuickBooks tenants when name is `Order Discount` or `Customer Credit` (tooltip: `Description for this predefined product cannot be changed when QuickBooks integration is enabled`) (`Product_Index_UpdateControlsVisibility`). |
| `Type` | `cmbType` | combo (non-editable) | Options in 1.2. Required. |
| `FixedAssetTypeID` | `cmbFixedAssetType` (combo with "add") | combo | Shown only for Fixed Asset (`liFixedAssetType`). Required id in the required-field list. Cleared whenever type changes away from Fixed Asset. |
| `Category` | `cmbCategory` (combo with add; value is CategoryID) | combo, forceSelection | Required. |
| `BrandID` | `cmbBrand` | combo with add, not forced | Optional. |
| `CostingMethod` | `cmbCostingMethod` | select | Options in 1.3. Required. |
| `DefaultUnitOfMeasure` | `cmbDefaultUnitOfMeasure` (value UnitOfMeasureID) | combo with add, forceSelection | Required. Selecting renames the additional-UoM grid column header to `Number of <unit>`. |
| `DropShipMode` | `cmbDropShipMode` | combo | `N` No drop ship, `O` Optional drop ship, `A` Always drop ship (`Main2019 :: CreateDropShipModeStore`). |
| BOM type (derived) | `cmbBillOfMaterial` | combo | Values `no` No BOM, `bom` Assembly BOM, `pbom` Production BOM, `mto-bom` Make-to-order BOM. Stored as three booleans `BillOfMaterial`, `IsProductionBom`, `IsMakeToOrderBom` (`Product_Index_PrepareDataForSave`). |
| `InventoryAccount` / `RevenueAccount` / `ExpenseAccount` / `COGSAccount` | `cmbInventoryAccount`, `cmbRevenueAccount`, `cmbExpenseAccount`, `cmbCOGSAccount` | typeahead combos (value = account Code) | Inventory account blur: value cleared if not in store. |
| `PurchaseTaxRule` / `SaleTaxRule` | `cmbPurchaseTaxRule`, `cmbSaleTaxRule` | combos | |
| `Barcode` | `txtBarcode` | text | |
| `MinimumBeforeReorder`, `ReorderQuantity` | `txtMinimumBeforeReorder`, `txtReorderQuantity` | decimal mask | Negative values coerced to 0 on change for ReorderQuantity, dimensions, weight and carton fields. Forced to 0 on save for make-to-order BOM. |
| `DefaultLocation` | `cmbDefaultLocation` (combo with add, remote query) | combo | Query loads `withBins:true`, `assetsOnly:true` when type is Fixed Asset. |
| `StockLocator` | `txtStockLocator` | text | |
| `PickZones` | `txtPickZones` | tags input | |
| `Tags` | `txtTags` | tags input | |
| `Status` | `cmbStatus` | combo | `A` Active, `D` Deprecated, `P` Setup required. List order in the store: Active, Deprecated, Setup required. |
| `NotSellable` | `notSellable` ("I am selling this product") | combo | Display `Yes` = value `'false'`, `No` = value `'true'` (inverted). New product: `'false'`. |
| `AlwaysShowQuantity` | `txtAlwaysShowQuantity` | decimal, min 0 | Only for Non-inventory. |
| `ShortDescription` | `txtShortDescription` | textarea, maxLength 500 | |
| `Description`, `InternalNote` | `txtDescription`, `txtIntNote` | plain/HTML (TinyMCE) | Modes `Plain`/HTML via `Product_Index_ChangeDescriptionMode`, `Product_Index_ChangeIntNoteMode`. |
| `Length`, `Width`, `Height`, `Weight`, `DimensionsUnits`, `WeightUnits` | `txtLength` etc. | decimals + unit combos | Units come from tenant defaults. |
| `CartonLength/Width/Height`, `CartonInnerQuantity`, `CartonQuantity`, `CartonVolume` | | decimals | `CartonVolume` is read-only and computed (1.9). |
| `HSCode`, `CountryCode`/`CountryOfOrigin` | `txtHSCode`, `cmbCountryOfOrigin` | text/combo | Blanked on save for Service and "Gift Card" (1.7). |
| `WarrantySetupID` | `cmbWarrantySetup` | combo | Row visible only when tenant `WarrantySetupEnabled`. |
| `ProductAttributeSet`, `CustomField1..10` | `cmbProductAttributeSet` | combo + dynamic controls | Empty guid = no set. |
| `DiscountID` | `cmbDiscount` | combo | Empty guid default. |
| `PriceTear1..10` | Prices tab (markup grid) | numbers | Note the spelling `PriceTear` in the model. |
| `AverageCost` | `txtAverageCost` | number | Editable and saved only for Service and Non Inventory, otherwise read-only text. |
| `QuantityToProduce`, `AssemblyInstructionURL`, `AssemblyCostEstimationMethod`, `AutoAssembly`, `AutoDisassembly` | `txtQuantityToProduce`, `txtAssemblyInstructionURL`, `cmbCostType`, `chkAutoAssembly`, `chkAutoDisassembly` | assembly settings | See 1.6. |
| `CanEditBOM`, `EnableAutoAssembly`, `ParentProductID`, `ParentProductName` | server-supplied flags | | `CanEditBOM=false` locks BOM controls and shows a link to the parent product (`BomDisabledReason`). |
| `IsCoManDropShip`, `ShowDeliveryTo`, `CountrySpecificKey/Data` | server-supplied | | |

Child collections on the product: `vBillOfMaterials`, `vBOMServices`, `vDiscountMatrix`, `vSupplierProducts`, `vProductLocations`, `vProductsAdditionalUnitsOfMeasure`, `vProductLeadSafetyOptions`, `vProductMarkups`, `ProductMarkupPrices`, `vCustomPrices`, `vProductionBoms`, `vMakeToOrderMenuConfigurations`, `vMakeToOrderBOMConfigurations`, `vProductAlternative`, `vDimensionDefaultValues`, `vMultilingualTemplateDatas`.

### 1.2 Product types (`Product_Editor_Init :: ProductTypeStore`)

| Label | Stored value |
|---|---|
| Stock | `Stock` |
| Service | `Service` |
| Gift card | `GiftCard` |
| Non-inventory | `Non Inventory` |
| Fixed asset | `Fixed Asset` (added only when `FixedAssetPermission == 'Full'` and not Xero and `EnableFinancials`) |

Oddity worth copying or deliberately avoiding: the type store value is `GiftCard`, but `Product_Index_PrepareDataForSave` tests `'Gift Card'` when blanking HS code/country, so for gift cards that branch never fires from the client.
List-page type column renders `getTypeLabel` = `value.toUpperCase()`; the Fixed Asset label is `Fixed asset`. List BOM column (`getBomTypeLabel`): `BillOfMaterial` = `Assembly BOM`, `ProductionBom` = `Production BOM`, `MakeToOrderBom` = `Make-to-order BOM`, else `No BOM`.

### 1.3 Costing methods (`Main2019 :: CreateCostingMethodStore`)

| Code | Display |
|---|---|
| `FIFO` | FIFO |
| `FISN` | FIFO - Serial number |
| `FIBATCH` | FIFO - Batch |
| `FESN` | FEFO - Serial number |
| `FEBATCH` | FEFO - Batch |
| `BATCH` | Special - Batch |
| `SN` | Special - Serial number |

Helpers: `IsSerialNumberCostingMethod` = `SN`, `FISN`, `FESN`. `IsSpecialCostingCostingMethod` is literally `SN` or `BATCH` or `FEBATCH` (looks wrong, but that is what ships).
Make-to-order allowed methods (`window.mtoAvailableCostingMethods`): `FISN`, `FIBATCH`, `FESN`, `FEBATCH`, `BATCH`, `SN`.

**Changing the costing method on a saved product** (`Product_CostingMethod_Changed`, `Product_CostingMethod_IsChangingValid`, `CostingMethodModal_Save`, Product2019.js):
1. Only applies when the product already has an inventory card (GET `api/Product_Index_CostingMethod?productId=`, boolean `result`). Without one, the change is just an edit.
2. Unknown code throws `Unknow Costing Method`.
3. `allowFrom` matrix (new method -> old methods allowed). Violating it shows error `A non-serial costing method cannot be changed to a serial numbered costing method.` and reverts the combo:

| New | allowFrom | Dialog title | Expiry |
|---|---|---|---|
| `FIFO` | FIBATCH, FISN, FESN, FEBATCH, SN, BATCH | none (no dialog; record just updated) | n/a |
| `FISN` | FESN, SN | `FIFO costing method` | optional |
| `FIBATCH` | FIFO, FISN, FESN, FEBATCH, SN, BATCH | `FIFO costing method` | optional |
| `FESN` | FISN, SN | `FEFO costing method` | required |
| `FEBATCH` | FIFO, FISN, FESN, FIBATCH, SN, BATCH | `FEFO costing method` | required |
| `BATCH` | FIFO, FISN, FESN, FIBATCH, SN, FEBATCH | `Special costing method` | optional |
| `SN` | FESN, FISN | `Special costing method` | optional |

4. Extra blocks: make-to-order product and new method not in the MTO list -> `FIFO serial, FIFO batch, FEFO serial, FEFO batch, Special serial/batch costing method can be applied to make to order customizable product.`; auto-assembly on and new method not FIFO/FIBATCH/BATCH -> `Only the "FIFO", "FIFO - Batch" and "Special - Batch" costing methods support auto-assembly.`
5. For any non-FIFO target a modal asks for a batch/serial number (and expiry date). Validation messages: `Please enter a batch/serial number and an expiry date.`, `Please enter a batch/serial number.`, `Please enter an expiry date.` Expiry is demanded only when `hasEDateReq` (FESN, FEBATCH).
6. Save: POST `/api/Product_Index_CostingMethod` body `{productID, newCM, batchSN, expiryDate}`; success toast `Changes saved successfully.`; failure shows `ModelState.serverError[0]` or `An error occurred. Please try to reopen the dialog; if the error will appear again, please contact support.` Cancel restores the previous value.
7. Fixed Asset forces and disables costing method: sets `SN` and disables the control (`Product_Index_UpdateControlsVisibility`).

### 1.4 Defaults for a new product (`Product_Index_New`)

`Type='Stock'`, `Status='A'`, `DropShipMode='N'`, `CostingMethod='FIFO'`, `QuantityToProduce=1`, `DimensionsUnits`/`WeightUnits` = tenant defaults (`DefaultMeasurementDimensionsUnit`, `DefaultMeasurementWeightUnit`), `BillOfMaterial=false`, `AutoAssembly=false`, `AutoDisassembly=false`, attribute set and discount = empty guid, `CanEditBOM=true`, `EnableAutoAssembly=true`, `AverageCost=0`, min-before-reorder 0, reorder quantity 0, all dimensions and carton fields 0, `notSellable='false'`, BOM combo `no`, cost estimation combo `A` (Average Cost), `DefaultLocation`: the only location if there is exactly one, else the location flagged `IsDefault`. Caption `New product`, status badge `Active`. Movements, Usage, Channels and Additional-descriptions tabs hidden until saved. Hash `#new` opens it; `#requiresetup` lists products matching `Setup Required` with the "active only" box cleared. Create = POST `/api/Product_Index_vProduct`, update = PUT `/api/Product_Index_vProduct/{id}`; body `{ID, HasErrors:false, Original:[...], Updated:[...], SkuAutogenerationFlag}`; new record has wrapper `ID: 0`.

### 1.5 What shows or hides by type (`Product_Index_UpdateControlsVisibility`, `Product_IsTabDisabled`)

Row visibility (`SetButtonVisible`):

| Row | Visible when |
|---|---|
| Bill of material selector (`liBillOfMaterial`) | (Stock or Fixed Asset or Non Inventory) and `BillOfMaterialsPermission != 'None'` |
| Costing method | Stock, Fixed Asset, Non Inventory |
| Drop ship mode | Stock or Non Inventory, and not make-to-order BOM |
| Inventory account | Stock or GiftCard; hidden for Non Inventory (final state, see below) |
| Expense account | not Stock and not GiftCard |
| COGS account | Stock |
| Stock locator, Barcode | Stock or Non Inventory |
| Min before reorder, Reorder quantity | Stock or Non Inventory, and not make-to-order BOM |
| Warranty setup, HS code, Country of origin | not Service and not GiftCard |
| Purchase tax rule, Default location, Pick zones | not GiftCard |
| Fixed asset type | Fixed Asset |
| Average cost (editable) vs text cost | editable for Service and Non Inventory (`UpdatePricesUseOptions` runs last on a type change and wins), text for everyone else |
| Always show quantity, `.requiredForNonInventory` | Non Inventory |
| `.requiredForGiftCard` | GiftCard |

Side effects of leaving Stock/Non Inventory: drop ship mode reset to `N` and every supplier row `DropShip=false`. Service or GiftCard with a warranty set: warranty cleared. Unsaved GiftCard hides all `.tabContent`. A saved GiftCard disables type and revenue account. If `FixedAssetPermission != 'Full'` and the product is Fixed Asset, every field is disabled (movement type combo excepted).

Type change handler (`cmbType.change`): resets BOM selector to `no`; clears fixed asset type unless Fixed Asset; clears default location when entering or leaving Fixed Asset; filters locations by `UseForFixedAssetsOnly == (type is Fixed Asset)`; Non Inventory forces `AutoDisassembly=false` read-only; `SetGiftAccountStores` swaps account stores; changing to Service converts any calculated price tier whose Use is `F`, `L`, `HF` or `HL` back to a plain price (Calculated off, `MarkupType='P'`, `UsePriceType='A'`, `MarkupValue=0`). `select` on the type combo clears the inventory account.

Gift card specifics (`SetGiftAccountStores`): revenue combo relabelled `Liability account` and shows only LIABILITY accounts with `ForPayments` true and not BANK (ASSET or LIABILITY when QuickBooks); inventory row relabelled `Revenue account`; sale tax rules filtered to rules whose three effective percents are 0; default unit auto-set to the unit named `Item` if exactly one exists; revenue account defaults to tenant `GiftCardDefaultAccount`.

Tabs (`Product_IsTabDisabled`; true = hidden):

| Tab | Hidden when |
|---|---|
| General | never (still hidden for an unsaved GiftCard) |
| Price (`tabPrice`), Custom prices (`tabCustomPrices`) | Fixed Asset, GiftCard, or `PricesPermission == 'None'` |
| Stock (`tabStock`) | type != Stock |
| Dimensions | not Stock and not Non Inventory |
| Additional attributes | no attribute set chosen or set not found |
| Suppliers | (not Stock and not Non Inventory) or `SuppliersPermission == 'None'` or make-to-order BOM |
| Locations | not Stock, or make-to-order BOM |
| Movements | Service, GiftCard, Non Inventory, unsaved, or `MovementsPermission == 'None'` |
| Usage | not (Service or GiftCard), unsaved, or no movements permission |
| Bill of material | `BillOfMaterial` false or `BillOfMaterialsPermission == 'None'` |
| Production BOM | `IsProductionBom` false or either BOM permission `None` |
| Make-to-order BOM | `IsMakeToOrderBom` false or `BillOfMaterialsPermission`/`MakeToOrderBOMPermission == 'None'` (MTO permission is copied from `ProductionBOMPermission`) |
| Discount | Fixed Asset or GiftCard |
| Attachments, Activity logs, Product alternative | unsaved |
| Additional units of measure | not Stock, auto-assembly ticked, GiftCard, Non Inventory, or make-to-order BOM |
| Additional descriptions | not Stock and not Non Inventory, or GiftCard |
| Channels | not Stock/Non Inventory, GiftCard, or new product |
| Accounting dimensions | `DimensionsPermission` not Full/ReadOnly, or `IsAccountingDimensionsEnabled` false, or no active dimension |

### 1.6 BOM selector and assembly controls

BOM combo change (`cmbBillOfMaterial.change`):
- Shows exactly one of tabs Assembly/Production/Make-to-order BOM; activates it (or General for `no`).
- Hides for make-to-order: Suppliers, Locations, Additional UoM and Product alternative tabs, min-before-reorder, reorder quantity, drop ship mode and the clone action.
- Sets the three booleans on the record; always resets `AutoAssembly` and `AutoDisassembly` to false.
- Switching from `pbom`/`mto-bom` destroys the grid helper; if the saved product had no production BOM / MTO menu / MTO config rows, the corresponding in-memory collections are cleared.
- Option filtering: without `MakeToOrderBOMPermission == 'Full'` the `mto-bom` option is removed unless the product already is one; same for `pbom` with `ProductionBOMPermission`.

Controls (all become read-only when `CanEditBOM` false, `BillOfMaterialsPermission` is `ReadOnly`, or the form is read-only):
- `chkAutoDisassembly` ticked: if costing method is not `FIFO`, `FIBATCH`, `BATCH`, `FEBATCH`, the script clears **`chkAutoAssembly`** (not auto-disassembly; this is what ships) and alerts `Only the "FIFO", "FIFO - Batch", "FEFO - Batch" and "Special - Batch" costing methods support auto-disassembly.`
- `chkAutoAssembly` changing hides the Additional UoM tab when ticked (Stock only).
- Non Inventory forces auto-disassembly off and read-only.
- Auto-assembly and auto-disassembly are read-only when `EnableAutoAssembly` false or `CanEditBOM` false.
- Cost type combo (`cmbCostType`): `A` Average Cost, `L` Latest Purchase Cost, `F` Fixed Purchase Cost; changing it POSTs `/api/Product_Index_Cost?CostType=` with the component product ids and refreshes each BOM row `Cost`.
- Assembly BOM line total (`Product_Index_UpdateBOMLineTotal`): `TotalCost = Cost * (Quantity + (WastageQuantity > 0 ? WastageQuantity : WastagePercent * Quantity / 100))`. Labor/overhead line (`Product_Index_UpdateBOMServiceLineTotal`): `Cost = Quantity * record['PriceTier' + PriceTier]`.
- BOM grid editability (`vBillOfMaterialsEditing.beforeedit`): `Wastage %` locked if `WastageQuantity > 0`; `Wastage quantity` locked if `WastagePercent > 0`; both locked for serial-number costing methods; `CostPercentage` (disassembly cost %) clamped 0..100 on edit. Duplicate component: `Your bill of materials already has this product.`; duplicate service: `You already have this item in labor and overheads.`
- Save guards: BOM product without any component or service: `At least one product is required in BOM.` (warning, save aborted).

### 1.7 Save-time validation (client) and messages

Required ids (red highlight via `__HighlightInvalidFields`): `Product_Index_ProductCode`, `Product_Index_ProductName`, `Product_Index_Type`, `Product_Index_FixedAssetType`, `Product_Index_Category`, `Product_Index_CostingMethod`, `Product_Index_DefaultUnitOfMeasure`, plus production-BOM and MTO fields (`liOutputQuantity`, `cmb_ProductionIssueMethod`, `cmb_BackflushDefinedFor`, `cmbFinishedProductCost`, `liMakeToOrderOutputQuantity`, `cmb_MakeToOrderIssueMethod`, `cmbMakeToOrderFinishedProductCost`). Only controls that are visible are enforced in practice.

`Product_Editor_ConfirmThenSave` order of errors (all `Dear_Notification_Error`, save stops):
1. Non Inventory with costing != FIFO: `For type "non-inventory" only "FIFO" costing method is available.`
2. MTO BOM with costing not in the MTO list: `FIFO serial, FIFO batch, FEFO serial, FEFO batch, Special serial/batch costing method can be applied to make to order customizable product.`
3. MTO BOM with drop ship `Y`: `Make-to-order product cannot be used for drop shipment.` (note `Y` is not an option in the store; `O`/`A` are, so this check never fires from the UI)
4. Drop ship `O` or `A` with Production BOM: `Dropship products cannot have a production BOM.`
5. BOM product with zero components and zero services: warning `At least one product is required in BOM.`
6. QuickBooks tenant: product named `Customer Credit` (SKU `Customer Credit`): status must stay `A` (`It is not allowed to change "Customer Credit" product status if QuickBooks is connected.`) and name/SKU unchanged (`It is not allowed to change "Customer Credit" product name or SKU, if QuickBooks is connected.`).
7. In `ArePendingChanges`: invalid production-BOM or MTO grid blocks save; any markup row `Invalid`: `There were problems saving changes for markup prices. Please see errors in details in the prices tab.`; `CartonVolume > 0` with empty dimension unit: `Please specify unit of measure on 'Dimensions' tab.`

MTO configuration status coupling: if MTO config changed and product is `A` while config invalid, a dialog "Make-to-order configuration has errors" -> `Cannot save product with active status and invalid make to order configuration. Do you want to change status to "setup required"?` (buttons `Yes, change status and save.` / `No, cancel saving`); if status `P` and config now valid -> `Make-to-order configuration is valid now. Do you want to change product's status to active?`.

Server result handling: wrapper `HasErrors`; the server's `ValidationText` is shown, else `There were problems saving changes. Please see the errors in details.`; success toast `Changes saved successfully.`; the tab with an invalid child store is activated (BOM, discount, suppliers, additional UoM, production/MTO BOM). Per-row `ValidationState` (`Good`, `Edited`, `Invalid`, `Warning`) and `ValidationText` come back on every child row.

On save the client also writes: `AverageCost` only for Service/Non Inventory; `ReorderQuantity`, `MinimumBeforeReorder` = 0 for MTO; `HSCode` trimmed; `AssemblyCostEstimationMethod` from `cmbCostType`.

### 1.8 Prices tab and price tiers

- Number of tiers shown: tenant `AvailablePriceTiers` (AccessInfo store, `GetAvailablePriceTiers`), tier names from `SalePricesStore`; fallback label `Price tier N`.
- Markup grid row (`MarkupLine`): `Price`, `Calculated`, `MarkupType` (`P` Markup %, `A` Append), `UsePriceType` (`A` Average cost, `F` Fixed price, `L` Latest price, `V` Price tier value, `HL` Highest latest price, `HF` Highest fixed price), `MarkupValue`, `CalculatedPrice`.
- Editability (`MarkupGridEditing.beforeedit`): if not Calculated, Type/Use/Value are locked; if Calculated, Price is locked and Type is also locked when Use is `V`. Calculated `MarkupValue < 0` rejected. Max price `99999999999999` -> `The maximum allowed price is <formatted>.`
- Service type removes `F`, `L`, `HL`, `HF` from the Use list (`UpdatePricesUseOptions`); other types restore `F`, `L` at positions 1,2 and add `HL`, `HF` at the end.
- Row validation (`validateMarkup`) when Calculated: Use `A` with zero average cost -> `warnAvgPriceZero`; `F` with no latest fixed supplier price -> `warnFixedPriceZero`; `L` with no latest supplier price -> `warnPriceZero`; `HL` -> `warnPriceZero`; `HF` -> `warnFixedPriceZero`; `V` with markup value 0 -> `warnValueZero`. The text of those four warning constants is injected by the page template, not in the bundle (see end).
- Supplier-derived prices (`Product_RecalculateSupplierDerivedPrices`): latest price = supplier row `Cost` with the newest `SysDate` among rows with non-zero cost; latest fixed likewise with `FixedCost`; highest = max `Cost` (resp. `FixedCost`) among rows with `IncludeInPricing` true and non-zero. These feed `LatestSupplierPrice`, `LatestSupplierFixedPrice`, `HighestSupplierPrice`, `HighestSupplierFixedPrice`.
- Saving markups (`saveMarkups`): always writes `PriceTear1..10` from the grid; non-calculated tiers delete their `vProductMarkups` row; calculated ones upsert type/use/value.
- Custom prices (per customer): row needs a customer, else `Customer cannot be empty!`; refresh with unsaved edits asks `Please note that all custom prices changes will be lost. <br/>Are you sure you want to refresh the custom prices list?` (auto-fill variant: `...start the auto-fill of custom prices?`).

### 1.9 Dimensions

Carton volume (`Product_Index_CalculateCartonVolume`) = L x W x H converted to cubic feet or cubic metres: `in` /1728, `ft` x1, `yd` x27, `mi` x5280^3; `cm` /1e6, `mm` /1e9, `m` x1, `km` x1000^3. Volumes under `0.00000001` become 0. The label reads `Cubic feet` for imperial units and `Cubic meter` for metric (`Product_Index_ChangeCartonVolumeLabel`).

### 1.10 Child grids

- Suppliers (`ProductSupplierListGrid`): columns Supplier, SKU, Product name, Product URL, Drop ship, Currency, Latest price, Fixed price, Last supplied, Include in pricing. New row: `Currency = TenantCurrency`, `Cost=0`, `FixedCost=0`, `DropShip=false`, `IncludeInPricing=true`. Drop ship box is disabled when product `DropShipMode == 'N'` or supplier permission not Full; ticking one clears the others (one drop-ship supplier). Duplicate: `Your suppliers list already has this supplier.` Edit and delete need `SuppliersPermission == 'Full'`.
- Locations (`ProductLocationsGrid`): Location, Minimum before reorder, Reorder quantity, Stock locator, Pick zones; empty text `No locations found.`; guard `Select a location first.`; duplicate `Your locations list already has this location.`; new row mins 0.
- Additional units of measure (`GridAdditionalUnitsOfMeasure`): product, Unit of measure, Conversion rate (header becomes `Number of <default unit>`), `I am selling this product`, Tier 1..10 prices (header = tier name). New row `ConversionRate=1`, tiers 0. Creating a new unit-of-measure product (modal `NewProduct_AdditionalUnitOfMeasure*`): defaults SKU = `<SKU>-<unit>` and Name = `<Name>-<unit>` on unit select; validation `Unit of measure is required.`, `SKU is required.`, `A name is required.`, `SKU should be less than 50 symbols.`, `A name should be less than 256 symbols.`; then GET `/api/Product_AdditionalUnitsOfMeasure_SearchProduct/CheckProductSKU/?sku=`; found -> `A product with the entered SKU already exists.`; already in grid -> `A product with the same SKU already exists.`; ok -> `The new product will be created after saving.` (info `Checking SKU...` first). Same product twice: `This product has already been selected.`
- Discount matrix: Customer, Customer tag, Discount; new row discount `No Discount` (empty guid); duplicates `Your customer discounts list already has this customer.` / `...this tag.`
- Lead/safety options per supplier and location (`Product_LeadSafety_*`), alternatives (`Product_AlternativeProduct_*`), channels (`Channels`) exist; their rules were not read in depth.

### 1.11 Product list page

Grids `Grid` (state `ProductList2025_11`) and `GridCombined` (products plus families, `ProductListCombined3`). Columns: image, SKU, Product name, Unit, Type, Category, Brand (hidden), Last supplier (`LatestSupplier`), Attribute 1..10 (hidden), Status, `I am selling this product` (hidden; `'true'`->No, `'false'`->Yes, else Yes in plain grid, blank in combined), Barcode (hidden), BOM type (hidden). Status pill (`getStatusLabel`): `A` ACTIVE, `P` SETUP REQUIRED, `D` DEPRECATED; unknown values render as DEPRECATED. Search params `{search, lang, IsActive}` (checkbox "only active" defaults true; setting stored via cookie `ProductListView`, page size cookie `ProductPageSize` default 20). Combined view row types: `RowType === 1` is a family (`(N variants)`), others show `(N additional units)`. Empty text `No products found.`
Actions: Merge (`Product_Merge_Show`/`Product_Index_Merge`): not read-only; zero selected `Please select products to merge.`; one: `Please select at least two products to merge.`; read-only user: `You do not have permission to merge products.`; warning `Please note: Merging products is not reversible. You will need to merge the same products in your accounting software.`; no primary `Please select the primary product to merge the other products into.`; POST `/api/Product_Merge` `{PrimaryID, IDs}`; success `Successfully merged all products.`. Delete deprecated (`Product_Index_Start_Delete`): POST `/api/Product_Index_DeleteDeprecated` with SignalR progress. Copy (`Product_Index_Copy`) clears ids and sets: `Status='A'`, `LastSuppliedBy`, `FamilyID`, `HSCode` blank; BOM/supplier/location/discount/lead-safety rows lose ids; supplier `SupplierInventoryCode` and `SysDate` cleared; additional UoMs and images dropped; production BOM dropped (BOM selector reset to `no`, drop ship `N`); notice `The product has been copied. Please save the new product.`

### 1.12 Product families (ProductFamily2019.js)

- Model `vProductFamily`: `ID, Name, SKU, SKUCount, CostingMethod, Category, BrandID, UnitOfMeasure, MinimumBeforeReorder, ReorderQuantity, DefaultLocation, PriceTear1..10, Description, ShortDescription, AttributeSet, DiscountID, Option1Name..Option3Name, Option1Values..Option3Values, Tags, LastSupplierID, SupplierPrice, COGSAccount, RevenueAccount, InventoryAccount, DropShipMode, DropShipSupplierID, PurchaseTaxRule, SaleTaxRule, WarrantySetupID, IsProductionBom, IsProductionBomChanged`.
- New family (`ProductFamily_Index_New`): tiers 0, `SupplierPrice=0`, `DropShipMode='N'`, `CostingMethod='FIFO'`, `SKUCount=1`, `IsProductionBom=false`, empty guid attribute set and discount. Required ids: `tdSKU, tdName, tdCategory, tdCostingMethod, tdOption1Name, tdUnitOfMeasure, tdDefaultLocation` (+ BOM ids when production BOM).
- Generate variations (`ProductFamily_Index_GenerateVariations`): errors `Please enter a product family name. `, `Please enter a product family SKU.`, `No valid option values found to create variations.`. Cross product of Option1 x Option2 x Option3 values (empty values skipped; a missing option list is skipped, not multiplied). Name = `<family name> <opt1> <opt2> <opt3>` (space joined). SKU = `<family SKU> - <NNN>` where NNN is `SKUCount` zero-padded to 3 digits (4 digits if `SKUCount > 999`), incrementing past any code already in the grid; `SKUCount` is then set to the row count. New variation defaults: `Status='A'`, `Type='Stock'`, tenant weight/dimension units, tier prices copied from the family tier inputs, `FamilyID`. Existing variations with identical option triplet are not duplicated. Save with no variations: `Please add/generate variations.`; options missing on some variations: `Please update variations so that all variation had the same number of options.`; duplicate: `Your family already has this product.`
- Delete: confirm `Delete this product family permanently? All products in the family will be marked as deprecated.` (DELETE `/api/ProductFamily_Index_vProductFamily/{id}`; there is also a removal alert with SignalR `/api/ProductFamily_Index_DeleteDeprecated`). Clone: confirm `Are you sure you want to create a copy of this product family?`, asks new SKU and Name, clears variation `ProductID`s, success `Product family successfully cloned.`. Generate BOM when production BOM: `Production BOMs generated for product family variations will be updated. Would you like to proceed?`; no change: `There are no changes to apply for BOM generation.`
- Tabs: Options, Variations (always), Attachments and Activity logs only when saved. List columns: SKU, Family name, Category, Brand, `Products in the family`.

---

## 2. Stock adjustment (StockAdjustment2019.js)

### 2.1 Shape

Header (`vInventoryTask`, `Type='A'`): `TaskID, StocktakeNumber, CreatedDate, LastUpdatedDate` (the effective date), `LastUpdatedBy, Status, Account, CustomerReference, Comment, CostEstimationMethod, ValidationText/State`, collections `vInventoryAdjustments` (existing stock, tab `tabNonZero`), `vInventoryAdjustmentsNew` (new stock lines, tab `tabZero`), `vDimensionDefaultValues`. Caption `New stock adjustment` / `Stock adjustment #<StocktakeNumber>`. New adjustment: `Status='DRAFT'`, `CostEstimationMethod='A'`, date now, wrapper `ID:0`, account preset from reference data `Account1`. First tab shown: `tabNonZero`.

Statuses (`window.StockAdjustmentStatuses`): `DRAFT` Draft, `COMPLETED` Completed, `VOIDED` Voided.

### 2.2 Controls and button enable conditions (`StockAdjustment_Index_SetStatus`)

With `IsReadOnly` false unless stated:

| Control | Rule |
|---|---|
| Save (`saveAction`, `saveAction2`) | status != VOIDED |
| Complete (`completeAction`) | DRAFT |
| Undo (`undoAction`) | COMPLETED and tenant `UndoPermission == 'Full'` |
| Void (`voidAction`) | not VOIDED, already saved, `VoidPermission == 'Full'` |
| Print | not VOIDED |
| Add line buttons, scan buttons | DRAFT |
| Row delete columns | DRAFT |
| Export lines (`exportNewAction`) | saved and not VOIDED |
| Import lines (`importNewAction`) | not COMPLETED and not VOIDED |
| Effective date, Account, Cost type | enabled only in DRAFT |
| Customer reference, Comment | enabled in DRAFT or COMPLETED |
| Tabs Activity logs, Transactions | saved; Financial tab needs `FinancialDataPermission` Full/ReadOnly and COMPLETED |

Complete: remembers old status, sets `COMPLETED`, submits (validation of `tdEffectiveDate` and `tdAccount` required first). Failure rolls status back (`StockAdjustment_Index_RollbackStatus`); if the server returns `HasErrors` the client forces the status back to `DRAFT`. Save with zero lines (both stores empty): warning `Please add at least one adjustment line before saving.`

### 2.3 Endpoints and payloads

- Reference data GET `/api/StockAdjustment_Index_ReferenceData` -> `UndoPermission, VoidPermission, Account1, FinancialDataPermission, IsAccountingDimensionsEnabled`, `accounts`, `vTemplates`, units, locations.
- Load GET `/api/StockAdjustment_Index_vInventoryTask?id=<TaskID>` (hash = TaskID).
- Save POST (new, wrapper id 0) or PUT `/api/StockAdjustment_Index_vInventoryTask/{TaskID}` with `{ID, HasErrors:false, Original:[task], Updated:[task with both line collections]}`; 9000 s timeout. Success message `Changes saved successfully.`; error with empty text: `There were problems saving changes. Please check errors in adjustment lines.`
- Products for existing-stock lines: GET `/api/StockAdjustment_Index_Products` (query on product name; rows carry `FakeKey, ProductID, ProductCode, Name, UnitOfMeasure, LocationID, Location, BatchSN, ExpiryDate, CostingMethod, Available, OnHand`). New-stock products: `/api/StockAdjustment_Index_ZeroProducts?costType=&productType=` (`ProductID, ProductCode, Name, UnitOfMeasure, CostingMethod, Cost, LocationID, Type`). Locations: `/api/StockAdjustment_Index_ReferenceData/Locations` (`withBins`, `assetsOnly`). Transactions: `/api/StockAdjustment_Index_Transactions?id=`. Cost lookup: POST `/api/Product_Index_Cost?costType=` with product ids.
- Undo: confirm `This will reverse all adjustments and change the adjustment status to DRAFT! Would you like to proceed anyway?`, POST `/StockAdjustment/Undo` form param `TaskID`; success toast `Undo operation completed successfully.`; unsaved: warning `You cannot undo an unsaved adjustment.`
- Void: confirm `This will void this stock adjustment! Would you like to proceed?`, POST `/StockAdjustment/Void` `TaskID`; success `Void operation completed successfully.`; unsaved: `You cannot void an unsaved adjustment.`
- Print posts a hidden form (`PrintEntityID`, `PrintTemplateID`, `PrintSorting`); the template named `Stock Adjustment` first asks for sorting in the stocktake sorting dialog.
- Lines import/export: POST form `frmDownloadNewLines` (`NewLines` JSON, rows tagged `LineType: 'Zero'` or `'NonZero'`), upload result `{HasErrors, ErrorMessage, ErrorLines, ValidLinesCount, Lines, LinesNew}`; applying an import **replaces** both stores, sets every row `ValidationState='Edited'` and gives new-stock rows fresh guids; errors show `ErrorMessage`, `Server communication error: <status>`; user may upload only the valid lines.
- Tooltips/inline stock adjustment variant (`isInlineStockAdjustment`) has the same grids with no product editor and no delete column.

### 2.4 Line rules

Existing-stock line (`vInventoryAdjustment`: `ProductID, LocationID, BatchSN, ExpiryDate, CostingMethod, QuantityOnHand, Available, Adjustment` = the **new quantity**, `UnitOfMeasure, Comments`):
- Columns: Product, Batch/serial no., Expiry date, Unit, Location, On hand, Available, `New quantity`, `Variance`, Comments. Variance = `DEARRound(Adjustment - QuantityOnHand, 4)`; 0 renders `0`, negative in red, positive in green.
- Batch/serial and expiry render `N/A` when `CostingMethod == 'FIFO'`.
- Picking a product row fills ProductID, Name, UoM, LocationID, QuantityOnHand (`OnHand`), Available, CostingMethod, BatchSN, ExpiryDate from the chosen stock row (a product x location x batch combination). Duplicate (same product, location, batch, expiry): warning `Your stock adjustment already has this product in this location.` and the row is cleared.
- `Adjustment < 0` is coerced to 0. New quantity editor: decimals up to 4 places. For costing method exactly `SN` (not FISN/FESN) a value above 1 gives warning `You cannot set up new quantity > 1 for serial number products.` and sets 1.
- Editing blocked when read-only or COMPLETED. `StockAdjustment_NonZeroStock_IsFieldEditable`: Quantity locked for serial costing methods; Batch/serial and Expiry locked when FIFO. New line default `CostingMethod='FIFO'`.

New-stock line (`vInventoryAdjustmentNew`: `ProductID, LocationID, BatchSN, ExpiryDate, CostingMethod, Quantity, UnitCost, UnitOfMeasureName, Comments, ReceivedDate, ProductType, ID` guid):
- Columns: Location, Product, Batch/serial no., Expiry date, Unit, Quantity, Unit cost, Comments, Received date.
- New row defaults: `Quantity 0`, `UnitCost 0`, `CostingMethod 'FIFO'`, `LocationID` = previous row's location, `ReceivedDate` = effective date, `ID` = fresh guid.
- Choosing a product sets Name, UoM, `UnitCost = product Cost` (per header cost type), CostingMethod; for serial methods (`SN`, `FISN`, `FESN`) quantity is set to 1 and then locked. `Quantity < 0` and `UnitCost < 0` are coerced to 0. Batch/serial and expiry locked for FIFO. Unit cost editor 7 decimals, quantity 4.
- Product list depends on the location: bin flagged `UseForFixedAssetsOnly` -> products of type `Fixed Asset`; a normal location -> type `Stock`; none -> no type filter. The Location editor uses `withBins:true`; for Fixed Asset rows `withBins:false, assetsOnly:true`.
- **Cost handling**: existing-stock lines carry no cost (the adjustment uses the stock's own cost on the server). New-stock lines are costed: `UnitCost` is pre-filled from the product cost chosen by the header `Cost type` combo (`A` Average Cost, `L` Latest Purchase Cost, `F` Fixed Purchase Cost; saved as `CostEstimationMethod`). Changing that combo while not first-loading re-prices **every** new-stock line via POST `/api/Product_Index_Cost` (overwrites manual unit cost). A zero unit cost is allowed by the client (no check). Journals are generated on completion only: debit/credit shown in the Financial/Transactions grid (`Effective date, Debit, Credit, Amount`), and a banner for Xero/QuickBooks tenants: manual journals are generated upon completion of stock adjustment or stocktake.
- Locked period: the effective date `change` calls `OrderAccountingDimensions_Default_SetDisabledLineInLockedPeriod` (lines in a locked period are disabled for dimension edits).

Barcode scan (dialog, `StockAdjustment_Scan_*`): "inventory mode" textarea POSTs `/api/StockAdjustment_Scan_InventoryMode` `{locationId, search, lang}` and receives rows with `StockType` `NonZeroStock` or `ZeroStock`. NonZero rows merge into an existing line by product + location (+ batch, case-insensitive, for non-FIFO) and **add** the scanned quantity to `Adjustment`; Zero rows merge by product + location and add to `Quantity` (new rows use `UnitCost = AverageCost`). Messages: `Please provide a list of barcodes to process.`, `Searching products...`, `All barcodes were recognized and added to your document.`, `Some of the barcodes supplied could not be matched to any products or more than one product was found per supplied barcode. Unprocessed barcodes are listed in the box below.`, `An unexpected error happened while processing barcodes.`, single scan `Product <code> has been added.`.

List page (StockAdjustmentList2019.js): one grid for adjustments and stocktakes: API `/api/StockAdjustmentList_Index_vInventoryTask`, columns Number (`StocktakeNumber`), Type (`S` -> `Stocktake`, else `Stock Adjustment`), Location, Date (`LastUpdatedDate`, falling back to `CreatedDate`), Status (raw string), Created by, Reference. Empty text `You do not have any stock adjustments and stocktakes.`

---

## 3. Stock transfer (StockTransfer2019.js)

### 3.1 Statuses (`window.StockTransferStatuses`)

`DRAFT` Draft, `ORDERED` Ordered, `PICKING` Picking, `IN TRANSIT` In transit, `COMPLETED` Completed, `VOIDED` Voided. Order sub-status `OrderStatus`: `DRAFT`, `AUTHORISED`, `NOT AVAILABLE`.
List filter (`StockTransferList2019.js`, `StatusFilterStore`): All transfers, Completed, In transit, Picking, Ordered, Draft, Voided; list columns Transfer #, Date, From, To, Status, User, Reference (`IsFBA` flag exists). Bulk actions via POST `/api/StockTransferListBulkAction` `{IDs, Action}` with actions `void` (`This will reverse all transactions and change the status to voided! Would you like to proceed anyway?`) and `undo` (`This will reverse all transactions and change the status to DRAFT. Would you like to proceed anyway?`), each gated by bulk permission names `Void` / `Undo` from `/api/StockTransferList_Index_StockTransferBulkPermissions`; response text containing `error` -> error banner, containing `warning` -> warning, else success.

### 3.2 Workflow flags

Header (`vStockTransferTask`): `TaskID, Number, From, To (+FromLocation, ToLocation, ToLocationIsBin), Status, OrderStatus, SkipOrder, UsePutAway, DepartureDate (stock sent), RequiredByDate, CompletionDate (stock received), InTransitAccount, CostDistributionType, CustomerReference, Comment, IsCoMan, HasMultipleShipments, InboundShipmentID, ECSConfigID, LinkedProductionOrderID`, collections `vStockTransferOrderLines`, `vStockTransferDetails` (the picked/product lines), `vStockTransferPutAwayLines`, `ManualJournals`, `vStockTransferExciseLines`, `vDimensionDefaultValues`.
- Path A "Skip order" (`SkipOrder=true`): DRAFT -> (Send stock) IN TRANSIT -> COMPLETED, or DRAFT -> COMPLETED directly.
- Path B (order first): DRAFT (order lines on Order tab) -> `Authorise` -> status `ORDERED`, `OrderStatus='AUTHORISED'` (`StockTransfer_Order_Complete`) -> products tab edited as ORDERED/PICKING -> IN TRANSIT -> COMPLETED.
- `IsLocationTheSame` (From == To, not while loading) forces `SkipOrder` on and hides the skip-order block (`blockSkipOrder`).
- `chkUsePutAway` (needs `AuthorisePermission` Full, not read-only, not COMPLETED/VOIDED, not CoMan): tab renamed `Pick` instead of `Products`, the `completeAction` button is hidden (completion happens from the put-away tab), and put-away lines are cleared when it is switched off.
- Changing `From` (non-empty) clears the detail, put-away and order line stores and re-points product stores at the new location.
- `chkSkipOrder` change in DRAFT with order path: clears detail lines; with skip: clears order lines; `OrderStatus` is set to `NOT AVAILABLE` (skip) or `DRAFT` (not AUTHORISED).

### 3.3 Button / field enable conditions (`StockTransfer_Index_SetStatus`)

(Permissions come from reference data: `UndoPermission, VoidPermission, AuthorisePermission, CompletePermission, FinancialDataPermission`; all default `'Full'` before load.)

| Control | Rule |
|---|---|
| Save | not VOIDED |
| Send stock (`sendStockAction`, sets IN TRANSIT) | `AuthorisePermission` Full and ((DRAFT and skip order) or (order path and status ORDERED/PICKING)) |
| Complete (`completeAction`, sets COMPLETED) | `CompletePermission` Full and ((DRAFT and skip) or (order path and ORDERED/PICKING) or IN TRANSIT); hidden when put-away is used |
| Complete put-away (`completePutAwayAction`) | `CompletePermission` Full and IN TRANSIT |
| Undo put-away (`undoPutAwayAction`) | COMPLETED and Void+Undo permissions Full |
| Undo | (COMPLETED or IN TRANSIT or ORDERED/PICKING) and `UndoPermission` Full |
| Void | not VOIDED, saved, `VoidPermission` Full |
| Print, Email | not VOIDED and saved |
| Import lines | not COMPLETED, not IN TRANSIT, not VOIDED |
| Auto-pick (`divAuto_Pick`) | not COMPLETED/IN TRANSIT/VOIDED, order path, ORDERED/PICKING |
| Add product, scan | (DRAFT and skip) or (order path and ORDERED/PICKING) |
| Product row delete | DRAFT or ORDERED/PICKING |
| Add family matrix (`divAddBulk`) | as add product, and tenant `ProductFamilyCount > 0` |
| From, To | DRAFT only (To also disabled when URL has `ShopID`) |
| Account (in transit) | not COMPLETED/IN TRANSIT/VOIDED |
| Stock sent date | not COMPLETED/IN TRANSIT/VOIDED |
| Required-by date | not COMPLETED/VOIDED |
| Stock received date | not COMPLETED/VOIDED |
| Reference, Comment, Cost distribution | not VOIDED |
| Skip order checkbox | Authorise Full, not read-only, not COMPLETED/IN TRANSIT/ORDERED(PICKING)/VOIDED, and From != To |
| Put-away add/scan | IN TRANSIT |
| Order tab add/import/scan/skip | not skip order, `OrderStatus != 'AUTHORISED'`, not VOIDED; Authorise button also needs `AuthorisePermission` Full |
| Print labels | only with `ShopID` and `isPrintLabelsEnabled` URL params (FBA), authorised order, not skip |
| Manual journals new row | not VOIDED; journal rows editable only when COMPLETED |

Tab availability (`StockTransfer_IsTabDisabled`, `StockTransfer_Index_UpdateTabsVisibility`): Order tab off when skip order; Products tab off while order path and `OrderStatus != 'AUTHORISED'`; Excise tax tab only COMPLETED/IN TRANSIT; Manual journals only COMPLETED; Transactions off in DRAFT/VOIDED; Put-away tab only COMPLETED/IN TRANSIT (and then only visible when `UsePutAway`); Financial tab needs permission and COMPLETED/IN TRANSIT.

### 3.4 Save / transitions / validation

- Locations (`StockTransfer_Index_ValidateLocations`): `Please choose the 'From' location.`, `Please choose the 'To' location.` (html lines inside a `validation-summary-errors` div), and for transitions to IN TRANSIT or COMPLETED with no detail lines: `Please add at least one product to transfer before saving.`
- Dates (`ValidateDates`): `Stock received date should be later than or equal to the stock sent date.`
- Plain Save requires highlight validation of `tdFrom`, `tdTo` plus the two checks above.
- Transitions are expressed as `PlannedOperation` = `set_ORDERED`, `set_IN TRANSIT`, `set_COMPLETED`; the client sets the status locally then PUTs the whole task. Completing with a bin as destination (`ToLocationIsBin`): any line whose `LocationID` equals the destination bin gets `ValidationState='Invalid'` / `Transfer to the same bin is not allowed.` plus notification `There were problems saving changes. Please check errors in details.` and the Products tab is focused.
- Authorise an empty order: `Cannot authorize an empty order.`
- Save: POST `/api/Stocktransfer_Index_vStockTransferTask` (new) or PUT `/api/Stocktransfer_Index_vStockTransferTask/{id}` with `{ID, HasErrors:false, Original:[], Updated:[task]}` (timeout 200 s). Empty detail lines (no ProductID and quantity 0) are dropped before save. FBA-sourced new transfers (`FromFBA`) with no `CustomerReference` call `SendInboundShipment` (`/Stocktransfer/CreateInboundShipment`).
- Load GET `/api/Stocktransfer_Index_vStockTransferTask?id=&lang=&CountrySpecificKey=`. Other endpoints: `/api/Stocktransfer_Index_LocationWithBins`, `/api/Stocktransfer_Index_Products` (params `LocationID, lang, taskID, toLocationID`), `/api/Stocktransfer_Index_ProductLocations`, `/api/StockTransfer_Order_Products`, `/api/StockTransfer_Index_AutoPick` (`TaskID, LocationID, lang, toLocationID`), `/api/StockTransfer_Scan`, `/api/StockTransfer_Scan_InventoryMode`, `/api/Stocktransfer_Index_Transactions`, `/api/PickRecommendation`.
- Undo: confirm `This will reverse all stock movements and transactions and will change the transfer status to draft! Would you like to proceed anyway?`; POST `/Stocktransfer/Undo` `TaskID`; success `Undo operation completed successfully.`; unsaved `You cannot undo an unsaved transfer.` Void: `This will reverse all stock movements and transactions and will change the transfer status to voided! Would you like to proceed anyway?`; POST `/Stocktransfer/Void`; `Void operation completed successfully.`; `You cannot void an unsaved transfer.` Undo put-away: `This will reverse all put away distributions and transactions and will change the transfer status to in-transit! Would you like to proceed anyway?`; POST `/Stocktransfer/Undo` with `IsPutAway: true`.
- The in-transit account is remembered per user in cookie `TenantStockTransferInTransitAccountKey` when changed.

### 3.5 Line rules

Product line (`vStockTransferDetail`, grid columns Product, Batch/serial no., Expiry date, Unit, Location (bin), On hand, Available, Transfer quantity, Comments): fields `ProductID, ProductCode, Name, UnitOfMeasure, UnitName, LocationID, Location, BatchSN, ExpiryDate, CostingMethod, QuantityOnHand, QuantityAvailable, TransferQuantity, NonInventory, Type ('S' for auto-pick lines)`.
- Adding a line needs From: warning `Please choose the 'From' location first.`
- The product dropdown shows stock rows (product x bin x batch) from the From location; choosing one fills location, on hand, available, batch, expiry, costing method, `NonInventory = (ProductType == 'Non Inventory')`. Duplicate (same product, batch, location): warning `Your stock transfer already has this product.` and row cleared.
- Bin editor only enabled once a product is chosen and not for non-inventory lines; picking a different bin refreshes batch/expiry/on hand/available.
- `TransferQuantity < 0` -> 0. Quantity displays red when `QuantityAvailable < TransferQuantity` and the product is not non-inventory (the client does **not** block it).
- Batch/serial and expiry show `N/A` for FIFO.
- Put-away line (`vStockTransferPutAwayLine`: product, batch, expiry, unit, location, `ReceivedQuantity`): destination required (`Please choose the 'To' location first.`), duplicate `Your put away already has this product.`, received quantity above the transferred total for that product/batch/location key: warning `Received quantity can not exceed transfer quantity.` (value clamped). Scans merge into an existing put-away row on product + batch + location (+ expiry) by adding to `ReceivedQuantity`.
- Order line (`vStockTransferOrderLine`: product, unit, `OnHandQuantity`, `AvailableQuantity`, `Quantity`, comments): duplicate `Your stock transfer order already has this product.`
- Auto-pick (`StockTransfer_Index_AutoPick`) replaces all product lines with the server's proposal (type `S`).
- Pick recommendation (tenant `RecommendBatchSNMode` on reference data): 0 off, 1 warn, 2 enforce. `RecommendationHelper.validate` flags scanned/selected batch lines that skip the FIFO/FEFO order: row `ValidationState` is `Warning` (mode 1) or `Invalid` (mode 2); row text `For product <code> recommended batch/serial number is <batch>. Quantity recommended = <n>` (or `... recommended bin is <bin>. ...`); toast `Scanned/selected batch/serial no. does not follow FIFO/FEFO costing method.` with specific variants per costing method: batch `... batch no. does not follow FIFO costing method.` / `FEFO`, serial `... serial no. ...`, FIFO `Scanned/selected item does not follow FIFO costing method.`. A server `PickRecommendationWarning` is shown as a sticky warning.
- Scan messages (transfer): `Product not found. Scan another barcode.`, `Product not found. Type in or scan another barcode and press enter.`, `Product not found in the current stock transfer. Please, scan another barcode.`, inventory mode messages as in 2.4.
- Cost distribution (`CostDistributionType`): `Cost`, `Quantity`, `Weight`, `Volume`, `Manually`. `Manually` reveals the per-journal column `Manually distribute cost`. Manual journals (COMPLETED only) have Debit, Credit, Reference (a service product name), Amount; empty text `Enter manual journals to distribute additional costs associated with the stock transfer`.

---

## 4. Stocktake (Stocktake2019.js)

### 4.1 Statuses and header

Statuses: `DRAFT` Draft, `IN PROGRESS` In progress, `COMPLETED` Completed, `VOIDED` Voided. Header is the same `vInventoryTask` with `Type='S'`; extra fields `LocationID, IncludeQuantityOnHand` (checkbox `chkIncludeQuantityOnHand`), `FilteredItems`, filter lists `StockLocators, Categories, Brands, Tags, Bins, BinGroups, PickZones`. New: `Status='DRAFT'`, `IncludeQuantityOnHand=false`, date now. Caption `New stocktake` / `Stocktake #<StocktakeNumber>`.
Save/load: `/api/Stocktake_New_vInventoryTask` (POST new or PUT by id, 200 s), lines `/api/Stocktake_New_vInventoryAdjustment`, new-stock products `/api/Stocktake_New_ZeroProducts`, products `/api/Stocktake_New_Products`, filter sources `/api/Stocktake_New_vCategory|vBrand|vTag|vStockLocator|vPickZone|vBin|vBinGroup`, reference data `/api/Stocktake_New_ReferenceData`, scan `/api/Stocktake_New_InventoryMode`, import POST `/Stocktake/Import`, new-lines template `/Stocktake/UploadNewLinesTemplate`, undo POST `/Stocktake/Undo`, void POST `/Stocktake/Void`.

### 4.2 Buttons (`Stocktake_New_SetStatus`)

| Control | Rule |
|---|---|
| Save | not read-only, not VOIDED |
| Start (`startAction`) | DRAFT |
| Scan (`scanAction`) | IN PROGRESS |
| Complete | IN PROGRESS |
| Undo | (COMPLETED or IN PROGRESS) and `UndoPermission` Full |
| Void | not VOIDED, saved, `VoidPermission` Full |
| Print | always |
| Export (`exportAction`) | not DRAFT, not VOIDED |
| Import (`importAction`) | IN PROGRESS and saved |
| Import new lines, Add new line, row delete | DRAFT or IN PROGRESS |
| Sync (`syncAction`) | IN PROGRESS and the location has `FFServiceID` (external fulfilment) |
| Location | DRAFT only; Include-quantity-on-hand box editable in DRAFT only |
| Date, Account, Reference, Comment | not COMPLETED/VOIDED |

Start: highlight-validates `tdEffectiveDate`, `tdLocation`, `tdAccount`, requires a location (`Please choose a location.`), sets `IN PROGRESS` and saves; the server then snapshots the existing stock into the stocktake. Complete: sets COMPLETED, saves. Filters (stock locator, category, brand, tag, bin, bin group, pick zone) are editable only in DRAFT; afterwards read-only chips (empty chip groups hidden), and `foundFilteredItems` count shown when not DRAFT/VOIDED. The filter chips are written back as comma lists in `PrepareDataForSave` (tags, pick zones, stock locators joined `, `; categories, brands, bins, bin groups by id with `,`). New-stock lines with no `LocationID` get the stocktake location.
Messages: unsaved undo `You cannot undo an unsaved stocktake.`; undo confirm `This will reverse the stocktake/inventory count status to DRAFT keeping all details intact! Would you like to proceed?`; void confirm `This will void this stocktake/inventory count and delete all adjustments! Would you like to proceed?`; unsaved void `You cannot void an unsaved stocktake.`; `Undo operation completed successfully.` / `Void operation completed successfully.`; download without location `Please choose a location before downloading the file.`; grid empty text `Click start to view existing stock.`.

### 4.3 Lines

- Existing-stock grid (from server snapshot, paged, searchable): Product, Bin, Batch/serial no., Expiry date, Unit, `Quantity on hand` (hidden unless `IncludeQuantityOnHand`), `Stocktake quantity` (`Adjustment`), `Variance` (hidden unless `IncludeQuantityOnHand`; same red/green rule). Clicking a row in IN PROGRESS opens the scan dialog titled `Specify the stocktake quantity` with batch/expiry read-only; Save updates `Adjustment` and shows `Product <code> has been updated with stocktake quantity <n>.`
- New-stock grid (items not in the snapshot): same editor rules as an adjustment's new lines: serial costing locks Quantity (quantity 1 on choose), non-FIFO only for batch/expiry, negative quantity or unit cost -> 0; columns Product, Bin, Batch/serial no., Expiry date, Unit, Quantity, Unit cost, Received date; empty text `No products added to new stock.`
- Scan "inventory mode" (`/api/Stocktake_New_InventoryMode`): increments quantities per barcode; messages `All barcodes were recognized, and stock count quantity has been incremented for products related to these barcodes.`, the unmatched message as in 2.4, `An unexpected error happened while saving barcodes.`
- Bulk new-line import (`Stocktake_New_ProcessBulkLoad`): a row matching an existing new-stock row by product + location + batch overwrites its `Quantity`, `ExpiryDate`, `UnitCost` (does not add).
- Stocktake quantity is a counted quantity (absolute), not a delta: completion posts the variance (`Adjustment - QuantityOnHand`) per line, but the posting itself is server side.
- External locations (`FFServiceID`): after save the client calls `Stocktake_New_FillNewProducts_FromFF` and offers a sync that pulls quantities from the fulfilment service (`Stocktake_New_FillNewProducts_SyncQuantityFromFF`).

---

## 5. Availability columns and quantity meanings (Product tab `Stock`, `Stock_Controls_Init` in Product2019.js)

Endpoint GET `/api/Stock_Index_vProductsStock/GetByProductId` with `{productId, search, showNonZero, withBatches, lang}`; paged. State id `ProductAvailability2021`. Controls: search, a "non-zero only" checkbox (persisted in `localStorage.StockNonZero`), batch toggle (`Show batch/serial no.` = `batch` / `Consolidate batch/SN` = `consolidate`; showing the Batch/serial # and Expiry date columns requeries with `withBatches`). Empty texts: `You do not have any products matching the specified criteria.` and `No stock information is available for the product.`

| Column | Field | Meaning in the UI |
|---|---|---|
| Location | `Location` | location name |
| Bin | `Bin` | bin name |
| Batch/serial # | `BatchSN` | only when batch view is on |
| Expiry date | `ExpiryDate` | only when batch view is on |
| Stock value | `StockOnHand` | value of stock on hand; column hidden and unavailable when GET `/api/Stock_Index_Permissions?Type=stock` returns `"None"` (`StockValueVisible=false`) |
| On hand | `OnHand` | physical quantity (a volume `OnHandVolume` also exists in the model) |
| Available | `Available` | quantity free to promise (server computed); same column used as `QuantityAvailable` in transfers |
| On order | `OnOrder` | quantity on open purchase-type orders; clickable when non-zero |
| In transit | `InTransit` | quantity on transfers in transit; clickable when non-zero |
| Allocated | `Allocated` | quantity reserved by documents; clickable when non-zero |
| Next delivery | `NextDeliveryDate` | date, else text `N/A` |

Expanded-row template (tablet/mobile) also shows Category, Brand, Unit, Family, Stock locator, Status. Unit cost helper `Stock_Index_FormatUnitCostPrice` = `StockOnHand / OnHand` rounded to 2 decimals (0 if either is falsy).
Drill-downs: Allocated (`/api/Stock_Index_vProductsStockAllocated`, columns Task no., Customer, Quantity, Date) links by type: `S` -> `/Sale`, `SM` -> `/SaleMultiple`, `D` -> `/Disassembly`, `ST` -> `/StockTransfer`, `MO` -> `/ProductionOrder`, `F` -> `/FinishedGoods`, `RO` -> `/RMAReturnOrder`. On order (`/api/Stock_Index_vProductsStockOnOrder`) and In transit (`/api/Stock_Index_vProductsStockInTransit`) columns Order, Supplier, Date, Required by, Quantity, Next delivery; links by type: `P` -> `/Purchase`, `PA` -> `/PurchaseAdvanced`, `ST` -> `/StockTransfer`, `MO` -> `/ProductionOrder`, other -> `/FinishedGoods`. Allocated drill-down passes the batch (single space when blank).
Movements tab (`vProductMovement`: `CardDetailsID, TaskID, Type, Number, Status, Date, Quantity, Amount, Location, BatchSN, ExpiryDate, FromTo`) with filter `Show quantity movements` (`Quantity`) / `Show quantity and cost movements` (`QuantityAmount`); the amount column exists only in the second mode.
Product-pick dropdowns in adjustments/transfers show per row `Batch/serial #`, `Location`, available and on hand (template `drop-product-3columns`).

---

## 6. Reorder, price list, gift cards, recall

- **Reorder by level** (`ReorderLevelOfStock2019.js`): tenant GET `/api/Reorder_Index_Tenant` returns `ReorderMode`; when `'Location'` the location picker shows (otherwise reorder is global). Products `/api/Reorder_Index_Products/search` (columns Supplier SKU, Product, Available, On order, Minimum before reorder, Reorder quantity, Price; empty text `You do not have any products ready for reorder.`). Submit POST `/api/Reorder_Index_Products` `{LocationID, Reorder:[{SupplierID, ProductID, Price, ReorderQuantity}]}`. Errors: `<name> Reorder price should have a non-zero positive value.` (fires for price < 0), `<name> Reorder quantity should have a non-zero positive value.` (fires for qty <= 0), `Please select at least one product to reorder.`; the server returns messages in `ModelState.serverError`.
- **Reorder suggestion** (`ReorderSuggestion2019.js`): `cmbReorderFrom` values `purchase`, `transfer`, `production`; purchase shows the supplier picker, transfer shows warehouse picker; purchase/transfer also show an action picker from `/api/SuggestReorder_Index_AvailableReorderActions`; production shows none. Columns: Location, Supplier, Supplier SKU, Product, Reorder date, Units of measure, Available at (warehouse), Available, On order, Minimum order quantity, Reorder quantity, Price. Extra error for purchase: `<code>: <name> Reorder quantity is less than minimum order quantity.`; same price/quantity/none-selected messages as above. POST `/api/SuggestReorder_Index_vEmailRecords` `{ReorderType, WarehouseID, SupplierID, Hash, Action, Reorder:[{ID, SupplierID, ProductID, LocationID, Price, ReorderQuantity, ReorderDate}]}`. Second grid of already-ordered lines (empty text `You do not have any ordered products.`; columns Product, Task, From, To, Ordered).
- **Reorder backordered** (`ReorderBackorderedStock2019.js`): filters by customer tag/customer/location; columns Supplier SKU, Product, On hand, Available, On order, Backordered, Suggested reorder quantity, Price; same validation and POST `/api/ReorderBackordered_Index_Products` (`CustomerID` or `LocationID` in the wrapper).
- **Price list** (`PriceList2019.js`): filters category (`/api/PriceList_vCategory`), brand, tags, templates; the page only validates that a selection exists then posts a report request; no pricing rules in the client.
- **Gift cards** (`GiftCards2019.js`): list `/api/GiftCards_Index_vList`: Number, Sold in, Date, Expiration date, Amount/balance, Status; forfeit action needs a selection (`Select at least one gift card to forfeit`) and refuses already-forfeited cards (`An already forfeited gift card cannot be forfeited once more.`); export needs a selection (`Select at least one gift card to export`); allocation drill-down columns Document #, Invoice #, Date paid, Allocated amount.
- **Recall report** (`RecallReport2019.js`): choose product + batch; three panels from `/api/Recall_Index_OnHand` (Location, Product, Batch/serial no., Expiry date, On hand, Allocated, In transit, In WIP), `/api/Recall_Index_Suppliers` (Supplier, Phone, Email, Task, Product, Batch/serial no., Expiry date, Quantity) and `/api/Recall_Index_Customers` (Customer, Phone, Email, Address line 1, Address line 2, Task, SKU, ...); templates `/api/Recall_Index_ReportTemplates`; printing before loading: `Please click the 'Show' button to load the data before printing.`

---

## 7. Tenant and user settings that change inventory behaviour

Field names are as they arrive in the scripts (reference-data wrappers or page globals).

| Setting | Where it arrives | Effect |
|---|---|---|
| `SkuAutogeneration` | Product reference data | SKU box disabled, placeholder `auto-generated`; `SkuAutogenerationFlag` sent on save |
| `DefaultMeasurementDimensionsUnit`, `DefaultMeasurementWeightUnit` | Product reference data | defaults for new products and generated family variations |
| `PricesPermission`, `SuppliersPermission`, `MovementsPermission`, `FixedAssetPermission`, `BillOfMaterialsPermission`, `ProductionBOMPermission`, `DimensionsPermission` | Product reference data | `None` hides tabs/rows; `ReadOnly`/non-`Full` locks controls (see 1.5, 1.6, 1.10) |
| `FixedAssetPermission == 'Full'` + `EnableFinancials` + not Xero | page globals | enables the Fixed asset product type |
| `Xero`, `Quickbooks` | page globals | Xero: type Fixed asset unavailable; Xero/QB: info banner on adjustments/stocktakes about generated manual journals; QB protects `Order Discount` / `Customer Credit` products; Xero rounds purchase prices to 4 dp instead of 7 (`DEARRoundPriceForPurchase`) |
| `GiftCardDefaultAccount` | Product reference data | default liability account for gift cards |
| `WarrantySetupEnabled` | Product reference data | shows Warranty setup row |
| `MOWastageType`, `MOTraceFinishedProduct`, `IsTradingHelperTurnedOn` | Product reference data | production-BOM behaviour, trading helper |
| `IsAccountingDimensionsEnabled` | all inventory reference data | accounting dimensions tab/dialog |
| `AvailablePriceTiers` (AccessInfo), `PriceDecimals`, `PurchasePriceDecimals` | page globals | number of price tiers; decimals of price editors |
| `OpenDetailsInNewTabs` | user setting | list row click opens `/Product#id` in a new tab |
| `UserDateFormat`, `currentUILang` | user setting | date format, language passed on every list/load call |
| `StockValueVisible` (`/api/Stock_Index_Permissions?Type=stock`) | per-user | hides Stock value column |
| `UndoPermission`, `VoidPermission`, `AuthorisePermission`, `CompletePermission`, `FinancialDataPermission` | adjustment/transfer/stocktake reference data | button rules in sections 2.2, 3.3, 4.2 |
| `RecommendBatchSNMode` (0/1/2) | transfer reference data | FIFO/FEFO pick recommendation off/warn/enforce |
| `ProductFamilyCount` | transfer reference data | shows the family-matrix bulk add |
| `ReorderMode` (`'Location'`) | `/api/Reorder_Index_Tenant` | reorder screen per location |
| Location `FFServiceID`, `IsDefault`, `IsBin`, `UseForFixedAssetsOnly` | location records | external-fulfilment sync on stocktake; default location of new product; bin-to-same-bin check; fixed-asset-only locations |
| Account `Account1` | adjustment reference data | default adjustment account |
| Cookie `TenantStockTransferInTransitAccountKey` | browser | remembers the in-transit account |

---

## 8. Not determinable statically

- Cost layers: how FIFO/FEFO/special layers are consumed or created, what an adjustment's journal amounts are, how average cost is recalculated after receipts/adjustments/transfers, in-transit valuation, and the result of cost-distribution types (`Cost`, `Quantity`, `Weight`, `Volume`, `Manually`) on landed transfer cost.
- Quantity maths on the server: exact definitions of `Available` (on hand minus allocated, minus anything else), `Allocated`, `OnOrder`, `InTransit`, `OnHandVolume`, `StockOnHand`, `NextDeliveryDate`, backorder quantity and the "In WIP" figure in the recall report; negative-stock rules (the client shows red text but sends the data; any hard block would be a server `ModelState`/row `ValidationText` message).
- All server validation messages: per-row `ValidationText` on save for products, adjustments, transfers and stocktakes (duplicate SKU, SKU length, invalid account, locked period, negative result, serial uniqueness, expiry required, bin capacity) is generated by the API and not present in the bundles.
- Text of the four markup warnings (`warnAvgPriceZero`, `warnFixedPriceZero`, `warnPriceZero`, `warnValueZero`) and all field/tab labels that live in the server-rendered HTML (tab names, section headings, field captions, tooltips); only ids are visible here.
- Which products appear in the adjustment/transfer pickers (stock-only vs including non-inventory, bin filtering, `toLocationID` effects) and sort order.
- Auto-pick algorithm, pick recommendation ordering, put-away distribution into bins, FBA inbound shipment creation, `Setup required` (`P`) status assignment beyond the MTO case, and the effect of `Deprecated` on availability.
- SKU auto-generation format, family SKU uniqueness, merge semantics (what is repointed to the primary product), delete-deprecated rules (what blocks deletion), and gift-card forfeit effects.
- Stocktake snapshot content (how "existing stock" is chosen from filters, bin groups, pick zones), variance posting and how new-stock items in a stocktake are costed.
- Permissions model: how each `*Permission` value is derived from the user role.
- Reorder suggestion calculation (`ReorderDate`, minimum order quantity, availability-at-warehouse).
- Any behaviour in bundles not read in depth: lead/safety-time intervals (`Product_LeadSafety_*`), alternative products, channel availability (`Channels`), make-to-order configuration, production BOM and work-centre rules (covered by `ProductionOrder*` bundles), multilingual templates, attribute sets, country-specific plug-ins.
