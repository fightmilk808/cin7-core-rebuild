# Production: client-side behaviour of Cin7 Core (from shipped page scripts)

Source: static reading of the public, minified ExtJS page bundles (beautified copies, never executed, no call to the live app, no write to Cin7).
Bundles read: `ProductionSetup`, `ProductionOrder`, `ProductionOrdersList`, `ProductionResource`, `ProductionCalendar`, `CapacityPlanner`, `Scheduler`, `Assembly2019` (route `/FinishedGoods`), `Disassembly2019`, `IssueToProduction2019` (route `/IssueToProduction`, titled "Inventory write-off"), `JobCosting2019`, `FinishedGoodsList2019`, plus the production BOM editor inside `Product2019` (`Product_ProductionBom_*`) and helpers in `Main2019` (`DEARRound`, `IsSerialNumberCostingMethod`).
Rule references are `Bundle :: function` (line numbers change between beautifiers, function names do not).
Scope: only what the browser decides. What the server decides is listed at the end ("Not determinable statically"). Message text is verbatim from the scripts, including odd spelling and spacing. No company data appears here: every row is a rule, a constant or a message.
Sibling files: `rules/production.md` (help-doc rules), `rules/settings-client.md` (general settings wiring), `rules/mrp-client.md` (MRP), `rules/inventory-client.md` (BOM on the product page for assembly).

Conventions used below
- Time values in production (`CycleTime`, `TotalCycleTime`, `PlannedTime`, `ActualTime`, resource `CycleDuration`, calendar `Capacity`, capacity planner columns) are **seconds**. Clock times (`StartTime`, `EndTime`, `BreakStartTime`, `BreakEndTime`) are **minutes from midnight**; `-1` means "not set" in the grids and is converted to null / 0 on save.
- `DEARRound(v, n)` (`Main2019 :: DEARRound`) is half-away-from-zero rounding: `sign(v) * round(toFixed(abs(v) * 10^n, 6)) / 10^n`.
- A serial-number costing method is `SN`, `FISN` or `FESN` (`Main2019 :: IsSerialNumberCostingMethod`). The production scripts also test `CostingMethod.indexOf('SN') > -1` for the same purpose (whole-number quantities).
- `IsReadOnly` is a page-level flag set from the user's permission on the page; every action below is additionally gated by `!IsReadOnly`.

## ⚠️ Gotchas: the sneaky stuff

The surprising, easy-to-get-wrong and silently failing behaviours the page scripts show, worst first. Everything here is from static reading of the scripts, so server-side effects are not covered (see the end of the file). Each links to the section with the full rule.

> [!CAUTION]
> **Editing an order line silently deletes all production runs.** Changing a quantity or other row value while the order is not RELEASED or COMPLETED removes every run, because run lines are derived from order lines. Lowering the order quantity below the runs total, or reloading a BOM whose operations changed, does the same after a confirm.
> [Full rule: 4.3 Order BOM grid](#43-order-bom-grid-quantities-wastage-cycle-time)

> [!CAUTION]
> **The bulk "Mark as completed" reverses uncompleted work.** The confirm text says it will reverse all uncompleted operations and the component and resource allocations, whereas the single-order button refuses while any run is incomplete. A list-level click is destructive in a way the order page is not.
> [Full rule: 5. Production orders list](#5-production-orders-list-productionorders-bundle-productionorderslist)

> [!CAUTION]
> **Completing an operation from the Scheduler locks it to planned figures.** The confirm says used components and resources become equal to the planned quantities and cannot be edited after the operation is completed.
> [Full rule: 9.2 Editing mode](#92-editing-mode)

> [!CAUTION]
> **The suggested-quantity dialog can void the order.** On Release (always) the page asks what quantity to produce; when the suggestion is 0 the confirm button becomes "Cancel order", and a rejected check voids the order. Reading the dialog as a simple resize is a trap.
> [Full rule: 4.7 Authorize, Release, quantity suggestion, alternatives](#47-authorize-release-quantity-suggestion-alternatives)

> [!CAUTION]
> **Scheduler scheduling never runs backward.** The `forward` flag is passed into `_scheduleOperations` but never read, so operations are always laid out forward on the time line. If planning fails it throws `Could not schedule task within given time period.` and the task is undone.
> [Full rule: 9.3 Capacity model and scheduling algorithm](#93-capacity-model-and-scheduling-algorithm-schedulereditorcomponent)

> [!CAUTION]
> **NRV cost allocation hides its own failures.** Formulas are stored as text and run with `eval`; evaluation errors are ignored, and negative results are clamped to 0 only when the order has a co-man operation. Elsewhere a negative result is kept (the BOM page only warns, and run completion refuses it under NRV).
> [Full rule: 4.4 Order cost roll-up](#44-order-cost-roll-up-productionordercostcalculationshelper)

> [!WARNING]
> **Wastage quantity beats wastage percent, silently.** When both are set on a component the percent is ignored (a line with qty 0.2 and 10 % uses 0.2). On the order the percent is not editable, and the "Wastage qty" display column ignores percentage wastage.
> [Full rule: 4.3 Order BOM grid](#43-order-bom-grid-quantities-wastage-cycle-time)

> [!WARNING]
> **Setup and co-manufacturing operations ignore order quantity.** Their planned time is just the cycle time, "Units per cycle" shows `N/A`, and components on a Setup operation scale by the BOM output quantity, not the order quantity. Treating every operation as quantity-driven overstates setup time and materials.
> [Full rule: 4.3 Order BOM grid](#43-order-bom-grid-quantities-wastage-cycle-time)

> [!WARNING]
> **NRV allocation applies only when there is more than one finished product.** With a single finished-product row it silently falls back to Sales Value, whatever the selector says.
> [Full rule: 3.4 BOM cost roll-up](#34-bom-cost-roll-up-product_productionbom_updaterowcost-_updateoperationcost-_updatetotalcost-_updateyieldcost-_salesvaluecost)

> [!WARNING]
> **Work-centre grid edits drop and clear data without a warning.** Rows with an empty Name and empty Code are silently dropped before save, and toggling a co-man flag clears the name, supplier and both bin lists. Two bins in the same shop floor are refused.
> [Full rule: 1.2 Work centers tab](#12-work-centers-tab)

> [!WARNING]
> **The factory calendar cannot take past special days, and times mix units.** Special-day dates must not be earlier than today, and a save with no working-day hours is refused. Clock times are minutes from midnight with `-1` meaning unset, while durations are seconds.
> [Full rule: 7. Factory calendar](#7-factory-calendar-productioncalendar-bundle-productioncalendar)

> [!NOTE]
> **The client and the help docs disagree on the order status flow.** The page shows Authorize then Release (button needs `AUTHORISED`), shows `AUTHORISED` raw on the form chip, and the list labels it "Authorized", while the help text calls the state Planned.
> [Full rule: 4.2 Status strings and button / tab matrix](#42-status-strings-and-button--tab-matrix)

---

## 1. Production setup page (`/ProductionSetup`, bundle `ProductionSetup`)

The page has three tabs (`setupTabs`): `resourcesTab` Resources, `wcTab` Work centers, `suspendReasonsTab` Suspend reasons. It also shows two shortcut blocks (Factory Calendar "Set up calendar", Account mapping "Go to account mapping"). Access is checked with `CheckAccess('CapacityPlanner', 'Index', ...)` (`ProductionSetup_Ready`), so the page uses the Capacity Planner permission.

### 1.1 Resources tab

| Item | Rule | Ref |
|---|---|---|
| Grid columns | `Code`, `Name`, `State` (read-only text columns), an edit icon, a delete icon. Clicking any cell except the delete column (index 6) opens `/ProductionResource#<ResourceID>` in a new window; edit icon does the same. | `ProductionSetup_CreateControls :: resGrid` |
| Add button | `window.location.href = '/ProductionResource'` (blocked when read-only). | `ProductionSetup_AddRes` |
| Search | Text box `searchRes` (Enter triggers), checkbox `chkOnlyOperational` ("Only operational"). Query: `GET /api/ProductionSetup_Index_vResources` with `search` and `onlyActive` (checkbox state). Remote paging and sorting. | `ProductionSetup_ResSearch` |
| State values | `Operational` = true, `Non-operational` = false (`OperationalStore`). | `ProductionSetup_InitStores` |
| Delete | Confirm `Are you sure you want to delete the resource?` (Yes / No), then `DELETE /api/ProductionSetup_Index_vResources?ResourceID=<id>`. Response `{Success, Error}`: success shows `Resource successfully deleted.` and reloads, else the `Error` text. | `resGrid :: colDelete_Res` |

### 1.2 Work centers tab

Model `vWorkCenter` (key `WorkCenterID`): `Code`, `Name`, `NameFake` (editor value, may be an array of supplier ids), `IsActive`, `InLocationIDsFake` / `InLocationsName` (consumption bins), `OutLocationIDsFake` / `OutLocationsName` (output bins), `IsCoMan`, `IsCoManPurchase`, `SupplierID` / `SupplierName`, `CoManLocationID` / `CoManLocationName`, `CoManProcurementType`, `ColorCode`, `ValidationState`, `ValidationText`. Children: `vWorkCenterLocations` (`ID`, `WorkCenterID`, `LocationID`, `ParentLocationID`, `LocationName`, `Type` 1 = consumption, 2 = output, `WCLocationType`) and `vWorkCenterSuppliers` (`WorkCenterID`, `SupplierID`, `SupplierName`).

| Column (header) | Field | Control | Options / rule |
|---|---|---|---|
| (validation icon) | `ValidationState` | | Shows row errors. |
| Code | `Code` | text editor | Free text. |
| Purchase co-man | `IsCoManPurchase` | check column, width 100 | Tooltip: `Defines an external location where co-manufacturing can be raised from a purchase.` |
| Co-man | `IsCoMan` | check column, width 90 | Tooltip: `Defines an external location where co-manufacturing operations are carried out as part as production processes.` |
| Name | `NameFake` | editor depends on flags (below) | Plain text for an internal work center; supplier pickers for co-man types. |
| Color code | `ColorCode` | colour input (jscolor class `js-color-ingrid`) | New rows default `6A56C9`. Colour is saved to the record on every edit start and every change (`ProductionSetup_SaveColorValues`). Used by the scheduler as `WorkCenterColorCode`. |
| Mode | `CoManProcurementType` | combo (not editable), options below | Only editable when `IsCoMan` or `IsCoManPurchase`; otherwise `beforeedit` returns false. Renders `N/A` for an unknown value. |
| Consumption bin | `InLocationIDsFake` | multi-select (internal) or single combo (co-man) | Tooltip: `If you plan to pick up components from a shop floor location, the "Consumption bin" field should be left empty. Otherwise set location for every work center.` |
| Output bin | `OutLocationIDsFake` | multi-select | Tooltip: `Output bin defines where finished products can be put away after production. This connected output bin defines the list of bins for output in <product name> MES app and in output dialog. If output bin is not connected to work center, output is done to shop floor.` |
| State | `IsActive` | combo | `Operational` (true) / `Non-operational` (false). |
| (delete) | | icon | Confirm `Are you sure you want to delete the work center?` Yes / No; row is marked `ValidationState = 'Deleted'`, kept in `deletedWCs`, removed from the grid, and sent in the next save. |

Mode options (`ModeStore`):

| Label | Value |
|---|---|
| Sell components - Buy finished products | `buysell` |
| Transfer components - Buy finished product | `transfer` |
| Purchase components for co-manufacturer - Buy finished products | `purchase` |

Behaviour rules (`ProductionSetup_CreateControls :: wcEditing`, `checkchange` handlers, `ProductionSetup_WC_GetNameEditor`, `ProductionSetup_WC_GetLocationEditor`):
1. Toggling `IsCoMan` or `IsCoManPurchase` clears `Name`, `NameFake`, `SupplierID`, `SupplierName`, both bin lists and the supplier children. Then `CoManProcurementType` is set to the page-level `GlobalCoManProcurementType` (delivered with the work-center list payload) when the toggled flag is true or the other flag is already true; otherwise it is set to null.
2. Name editor: internal (neither flag) = free text. `IsCoMan` = single supplier combo (remote query, `/api/ProductionSetup_Index_vSuppliers`); picking sets `SupplierID`, `SupplierName`, `NameFake`. `IsCoManPurchase` without `IsCoMan` = multi-select of suppliers; the grid shows the comma-joined supplier names and the children rebuild from the selection. On save `Name` = `NameFake` (or comma-joined supplier names in the purchase-only case).
3. Consumption bin: internal work centers pick from the non-co-man tenant locations (`binsStore`, multi-select); co-man work centers pick one co-man location (`coManStore`, locations with `IsCoMan`). Output bin always picks from `binsStore`, multi-select.
4. Two chosen bins with the same `ParentID` (same shop floor) are refused: warning `Work center cannot be mapped to multiple bins in the same shop floor.` and the previous value is restored.
5. New row: `WorkCenterID` = new guid, `IsActive = true`, `ColorCode = '6A56C9'`. Tab on the last cell adds another row.
6. Reload guard (search, paging): if there are unsaved changes, error `Please save data first.` and the reload is cancelled.
7. Rows with empty `Name` and empty `Code` are silently dropped before save (`ProductionSetup_WCPrepareBeforeSaving`).

Client validation on save (`ProductionSetup_WCValidate`, only dirty rows, first matching error wins per row):

| Order | Condition | Row message |
|---|---|---|
| 1 | `Name == ''` | `Please enter a name.` |
| 2 | co-man (either flag) and no consumption bin | `Please specify co-manufacturing location (consumption bin field).` |
| 3 | co-man and mode not one of `buysell`, `transfer`, `purchase` | `Please specify co-manufacturing mode.` |
| 4 | purchase-only co-man with no supplier | `Please specify supplier name.` |

Any failure also shows `There were errors while saving changes. Please see details.` and nothing is sent.

Save call (`ProductionSetup_WCSave`): `PUT /api/ProductionSetup_Index_vWorkCenters` with `{Updated: [dirty rows + deleted rows], HasErrors: false, Errors: ''}`. Response wrapper `WorkCenterWrapper`: `HasErrors`, `Errors`, `CustomersCreated`, `WarningMessage`, plus the updated rows. Success text is `Data saved successfully.`; if `CustomersCreated` is non-empty it appends ` Following customers were created for co-manufacturing sales: <list>. Please go to customer page and finish setup.`; a `WarningMessage` is appended and the toast becomes a warning. Errors show the server `Errors` text or `There were errors while saving changes. Please see details.` and mark rows returned `Invalid`. Transport failure: `Could not save data.`

Empty grid text: `You do not have any work centers yet. To set up bin for every work center please follow this link.` (links to `/TenantLocation`).

### 1.3 Suspend reasons tab

Model `vSuspendReasons` (`ID`, `Reason`, `WorkCenterIDs` csv, `DowntimeType` int). Grid: `Reason` (text), `Downtime type`, one check column per **active** work center (header `<Code>: <Name>`, field = the work-center id), delete icon.

| Downtime type | Value |
|---|---|
| Undefined | 0 |
| Planned | 1 |
| Not planned | 2 |

Rules: delete confirm `Are you sure you want to delete the suspend reason?` (Yes, delete it! / No); `WorkCenterIDs` is built from the ticked columns (comma-joined, no trailing comma); empty text `You do not have any suspend reasons at the moment.`; save goes through the store (`/api/ProductionSetup_Index_vSuspendReasons` REST) and ends with `Changes saved successfully.` A reason with an **empty** `WorkCenterIDs` applies to every work center: the suspend dialog on a run operation offers reasons where `WorkCenterIDs` is empty or contains the operation's work center (`ProductionRunComponent :: _suspendOperation`).

---

## 2. Tenant settings that change production behaviour (client-visible)

Names are the fields of the tenant general-settings model (page `GeneralSettings2019`, DOM ids `TenantGeneralSettings_Index_<name>`) and of the production page reference-data payloads. Option lists of the selects live in server-rendered HTML, so only values the scripts compare against are known.

| Field | What the production pages do with it | Ref |
|---|---|---|
| `MOProduce` (reference field also named `MOProduce`) | Values `requiredInSalesAndReorder` and `availableMinusRequired` switch on the "suggested quantity" check (section 4.7). Any other value skips it. Setting names used in the message: `Quantity required and maintain minimum stock level quantity` and `Difference between available quantity and quantity required to cover a shortage`. | `ProductionOrder :: ProductionCommon_CheckOrderQuantity`, `ProductionOrderComponent :: _checkOrderQuantity` |
| `MOCreateProductionOrder` | Value `saleOrder` reveals the sale-order sub-section (`.TenantGeneralSettings_Index_MO_SaleOrder_Container`) that holds `MOProduce`. | `GeneralSettings2019 :: TenantGeneralSettings_Index_MOProduce_Container_UpdateVisibility` |
| `MOStatus` (reference field; value `RELEASED` is tested) | If `RELEASED`, the quantity check also runs when **authorising** an order and when planning from the list (`ProductionList_Index_PlanOrder`); the release popup runs the check when the order is not already `RELEASED`. | `_authorise`, `ProductionCommon_OpenReleasePopup` |
| `MOWastageType` | `auto` shows the wastage-products cost block on the BOM when it has any input/output rows and un-hides `MOWastageExpenseAccount`. `include`: completing a run whose total output quantity is 0 is refused with `Cannot complete production run without any output.` New runs copy `WastageType` and `WastageExpenseAccount` from the tenant. | `Product2019 :: Product_ProductionBom_UpdateWastageStore`, `ProductionRunComponent :: _complete`, `ProductionRunCreationComponent :: _createRuns` |
| `MOWastageExpenseAccount` | Copied to each new run as `WastageExpenseAccount`. | `_createRuns` |
| `MOTraceFinishedProduct` (int: 0 NeverTrace, 1 AlwaysTrace, 2 Option) | 0: no finished-product traceability. 1: always traced, and the BOM's issue-method UI and the backflush columns are hidden (`window.MOTraceFinishedProduct != 1` gates them). 2: the BOM checkbox `chkProductTracing` decides, per BOM, and only for products whose costing method is not FIFO. A component issue method of Backflush also turns tracing off. | `ProductionRunTraceability :: loadFinishedProducts / isVisible`, `Product2019 :: Product_ProductionBom_IssueMethodChanged`, `Product_ProductionBom_IsBackflush*Visible` |
| `UseBackdatedTransaction` (from `MOBackdatedTransaction`) | When true the run operation start/completion date pickers (`cmbOperationStartDate`, `cmbOperationCompletionDate`) are enabled, per operation status (section 6.4). | `ProductionRunComponent :: _operationDatesVisibility` |
| `MOCoManType` | Delivered to the setup page as `GlobalCoManProcurementType`, the default Mode for new co-man work centers. | `ProductionSetup_InitStores` |
| `MOAttributeSet`, `MORunOutputAttributeSet`, `MORunOperationAttributeSet` | Attribute sets (custom fields 1 to 10) for orders, run output lines and run operations (`AttributeSetStore`, `RunOutputAttributeSetStore`, `RunOperationAttributeSetStore`). | `ProductionOrder_InitStores` |
| `MRPProductionDate` | Not used by production pages (MRP module). | |
| Permissions in reference data | `ProductionOrderPermission`, `FulfillmentPermission` (`Full` gates Authorize, Release, Complete put-away), `EditCompletedOperationsPermission` (`Full` edits completed operations), `ProductionFinancialDataPermission` (`Full` shows costs and transactions), `UndoPermission`, `VoidPermission`, `SchedulerPermission`, `ProductionBOMPermission`. | `StatusTrackerHelper :: _setPermissions`, `RunStatusTrackerHelper :: _setPermissions` |
| Accounting dimensions | `IsAccountingDimensionsEnabled` and `DimensionsPermission != 'None'` and at least one active dimension turns on the dimension prompts (section 4.9). | `ProductionOrder_InitStores :: ReferenceDataStore load` |

Account pickers on the order form (`ProductionOrder_InitStores :: ReferenceDataStore load`), built from the chart of accounts, excluding system accounts:

| Store | Accounts included |
|---|---|
| `ExpenseAccountStore` | class EXPENSE or LIABILITY |
| `StockAccountStore` | class EXPENSE, or class ASSET with type not BANK and not FIXED |
| `FinishedGoodsAccountStore`, `WipAccountStore` | class ASSET with type not BANK and not FIXED, and code with no `.` (no sub-account / job account) |

---

## 3. Production BOM definition (Production BOM tab of the product page, `Product2019`)

### 3.1 BOM header fields (`Product_ProductionBom_CreateControls`)

The first column is a descriptive name: the script holds control ids and fields, not the label text, except where a quoted option label is shown.

| Label / purpose | Control id | Field saved (`vProductionBom`) | Rules |
|---|---|---|---|
| Output quantity | `txtOutputQuantity` | `OutputQuantity` | Decimal, precision 10. Changing it recomputes every Resource row whose cost type is "Cost per finished product" (`Product_ProductionBom_OutputQuantityChanged`). Becomes `BomQuantity` on an order. |
| Instruction URL | `txtProductionInstructionURL` | `InstructionUrl` | Free text; shown as a link on the order. |
| Buffer (percent) | `txtManufacturingBufferTime` | `BufferPercent` | Decimal, max length 16. Scheduler `BufferSize`. |
| Delivery to | `cmbliManufacturingDeliveryTo` | `DeliveryTo` | Location combo (remote, `withBins: true`). |
| Ignore cumulative lead time | `chkIgnoreCumulativeLeadTime` | `IgnoreCumulativeLeadTime` | When ticked, shows `ComponentProductionLeadTimeContainer`. |
| Component production lead time | `txtComponentProductionLeadTime` | `ComponentProductionLeadTime` | Integer only. |
| Product tracing | `chkProductTracing` | `IsTracing` | Disabled and cleared when issue method is Backflush. |
| Issue method | `cmbProductionIssueMethod` | `IssueMethodComponent` | Options: Manual = 1, Backflush = 2 (`ProductionIssueMethodEnum`). Not editable text. |
| Backflush defined for | `cmbBackflushDefinedFor` | `IssueMethodParameter` | Options: BOM = 1, Operation = 2, Component = 3 (`ProductionIssueMethodParameterEnum`). Shown only for Backflush; selecting Backflush defaults it to 1 (BOM); saved as null when issue method is Manual. |
| Min quantity to produce | `txtMinQuantityToProduce` | `MinQuantity` | Number >= 0, precision 4. |
| Max quantity to produce | `txtMaxQuantityToProduce` | `MaxQuantity` | Number >= 0, precision 4. |
| Deviation percent | `txtDeviationPercentQuantity` | `DeviationPercent` | 0 to 100, precision 2. |
| Run size | `txtRunSize` | `RunSize` | Number >= 0, precision 4. Used by the order save warning (section 4.6). |
| Finished product cost | `cmbFinishedProductCostId` | `CostCalculationType` on every finished-product row | Options: `Sales Value` = 1, `NRV (Net Realizable Value)` = 2. Changing it rewrites `CostCalculationType` on all rows in `OperationProductsStore` and recomputes totals. |
| Versions | `cmbPBomVersion`, versions grid | `Version`, `Name`, `IsDefault` | Display name `<Name> (v. <n>.0)` or `Version <n>.0`; only Version/Name/IsDefault are editable in the grid. |

`Product_ProductionBom_PrepareSave` writes the header values onto the current version and calls `ProductionBomGridHelper.completeEditDetails` / `ProductionBomDataHelper.prepareSave`. Editing the BOM requires `ProductionBOMPermission === 'Full'` (`Product_ProductionBom_IsFieldEditable`).

### 3.2 Operation and row types

Operation types (`OperationTypeEnum`, `OperationTypesStore`): Manufacturing = 1, Setup = 2, Quality control = 3 (`QA`), Co-manufacturing = 4 (`CoMan`). A Setup operation's `Type` cannot be edited (`Product_ProductionBom_IsFieldEditable`).

Row types (`ProductionComponentEnum`, `vComponentTypesStore`; the values are the strings `'1'` to `'8'`, and `'8'` is `Template` on the product page but `Configuration` on the order page) and the operation types each is offered for:

| Row type | Value | Manufacturing | Setup | QA | CoMan |
|---|---|---|---|---|---|
| Component (`Product`) | 1 | yes | yes | yes | yes |
| Resource | 2 | yes | yes | yes | no |
| Note | 3 | yes | yes | yes | yes |
| Attachment | 4 | yes | yes | yes | yes |
| Finished product | 5 | yes | no | yes | yes |
| Input | 6 | yes | no | yes | yes |
| Output | 7 | yes | no | yes | yes |
| Template (BOM page) / Configuration (order page) | 8 | `Template`: yes | no | yes | no |

Operation product types (`OperationProductTypeEnum` on the order, `BomProductTypeEnum` on the BOM): FinishedProduct = 1, Input = 2, Output = 3. Operation link `RelationType` is always 1. Sequence: operations have `Order` (step number); several operations may share a step; "Previous step" (`OperationRelationIDsFake`) lists linked prior operations. When a step has no explicit links, its predecessors are the operations of the nearest lower step (`ProductionOrderComponent :: _calculateOperationSequence`, `Product_ProductionBom_GetPrevOperations`).

Which fields are editable per row type (`Product_ProductionBom_IsComponentFieldEditable`; header text or data index is the test key):

| Row type | Editable fields (everything else locked; `Type` is always editable) |
|---|---|
| Component | `Component`, `Quantity`; `Wastage %` and `Wastage qty` editable but mutually exclusive: percent locked when quantity > 0, quantity locked when percent > 0; both locked for serial-number costing methods |
| Resource | `Component` (resource), `Quantity` |
| Note | `Component` (the note text) |
| Attachment | none (upload only) |
| Finished product, Input, Output, Template | `Component`, `Quantity` |
| (no type chosen) | none |

### 3.3 BOM validations

| Message | Condition | Ref |
|---|---|---|
| `Your operation already has this product.` | Same product twice in one operation | `Product_ProductionBom_CheckFPAndComponent` |
| `Your BOM already has this product in finished products output. You cannot have the same product as component and finished product.` | Component equals a finished product (not for co-man buy/sell) | same |
| `Your BOM already has this finished product in output.` | Same finished product listed twice | same |
| `Your BOM already has this product as component. You cannot have the same product as component and finished product.` | Finished product already used as a component (not in co-man buy/sell operations) | same |
| `This product is listed as a finished product in a previous operation. It cannot be used as input/output in subsequent operations.` | Input/output product is a finished product of an earlier step | `Product_ProductionBom_CheckInputOutputRecord` |
| `This product should be listed as an output in current or previous operation.` | Input with no matching output in the same or earlier step | same |
| `Quantity for output/input components does not match.` | Linked input and output quantities differ | same |
| `Your operation already has this resource.` | Same resource twice in one operation (also on the order grid) | order grid `edit` handler |
| Operation graph check | Every non-zero operation needs both an incoming and an outgoing link (`ProductionBomNrvHelper :: _isValid` returns `operationIds` that fail) | `ProductionBomNrvHelper` |
| `Production with these components and resources returns a negative cost per finished good. Your production set up may be unprofitable or incorrectly input.` | Warning when any NRV/formula cost is < 0 | `ProductionBomNrvHelper :: _calculate` |

### 3.4 BOM cost roll-up (`Product_ProductionBom_UpdateRowCost`, `_UpdateOperationCost`, `_UpdateTotalCost`, `_UpdateYieldCost`, `_SalesValueCost`)

Order of operations, in this order:
1. **Row cost.** Type Component: `Cost` (unit cost from the product), but for a co-man operation in `buysell` mode `Cost` = the sale price of tier `SalePriceTier` (`PriceTier<n>`, or 0 when tier is 0). `TotalCost = Cost * (Quantity + (WastageQty > 0 ? WastageQty : WastagePercent * Quantity / 100))`. Type Resource: with `CostCalculationType = CostPerUnitTime (0)`: `TotalCost = CycleTime > 0 ? OperationCycleTime / ResourceCycleTime * Cost * Quantity : 0`; with `CostPerFinishedProduct (1)`: `TotalCost = Cost * Quantity * OutputQuantity` (BOM header output quantity). All other row types: 0. No rounding at this stage in the BOM editor.
2. **Operation cost** = sum of its rows' `TotalCost`.
3. **BOM total** = sum of operation costs.
4. **Allocation to finished products** (non co-man finished products only). Sales Value: `totalSales = sum(PriceTier<pt> * OutputQuantity)` over finished products with a valid tier (1 to 10); each product gets `allCost = totalCost * (price * OutputQuantity) / totalSales` (ratio 0 when `totalSales = 0`), `unitCost = allCost / OutputQuantity` (0 when output quantity 0). NRV: see 3.5. The NRV mode is only used when there is more than one finished-product row; with a single one it falls back to Sales Value.

### 3.5 NRV allocation (`ProductionBomNrvHelper`)

Builds a graph of operations (index 0 = virtual start) and finished products (each with its source operation). For each finished product it finds the chain of operations that lead only to it (separable cost: charged fully to that product) and the operations shared with others (joint cost). Joint cost is split in proportion to the downstream products' sales values: `k = (sum of the product's sales value share path) / (sum of all downstream sales values)` built as a printed formula with `[operation_<index>]` (operation `TotalCost`, rounded to 4) and `[product_<id>]` (`PriceTier<pt> * OutputQuantity`, rounded to 4) placeholders and evaluated with `eval`. Result per product: `TotalCost = DEARRound(value, 4)`, `Cost = TotalCost / OutputQuantity`. The formula string is stored on the row (`Formula`) and reused on load. Negative results trigger the warning in 3.3. (On the production order the same formula is re-evaluated, see 4.4.)

---

## 4. Production order page (`/ProductionOrder`, bundle `ProductionOrder`)

### 4.1 Header fields

Labels are from the page; controls and fields from `ProductionTaskComponent`.

| Label | Control | Field | Options / defaults / rules |
|---|---|---|---|
| SKU / Product name | `cmbProduct`, `cmbProductName` | `ProductID`, `ProductCode`, `ProductName` | Picking one fills the other. Picking resets `BomVersion = 0`, `BomName = null`, reloads BOM versions, sets finished-goods account from the product's `AccountCode`, and sets the WIP account to the same code only when the WIP field is empty and the code exists in `WipAccountStore`. If operations were already loaded: warning `You have changed production order product.Please reload your BOM.` (sic, no space) and the operations are cleared. |
| Shop floor | `cmbLocation` | `LocationID`, `WarehouseID` | Only locations with `IsShopFloor === true` are kept; otherwise cleared. `WarehouseID` = `WarehouseLocationID` of the logistics path whose `ShopFloorLocationID` equals the choice. Disabled if status is not DRAFT or the order was created from a purchase. |
| Tags | `ProductionOrder_Index_Tags` | `Tags` | Tag input. |
| Order source | `cmbOrderSource` | `Source` | Manual = 1, Sale order = 2, Smart reorder = 3 (`ProductionOrderSourceEnum`, `OrderSourceStore`). New orders default to Manual. |
| Sales order # | `cmbSaleOrder` | `SourceTasks` (`vProductionOrderSourceTask`: `SourceTaskID`, `SourceTaskNumber`, `SourceType`) | Loaded from `GET /api/ProductionOrder_Index_vSaleOrders` (param `LocationID`). |
| Finished goods account | `cmbAccount` | `Account` | Defaults to reference `InventoryControlAccount` when empty. |
| Work in progress account | `cmbWIPAccount` (`cbmWipAccount`) | `WIPAccount` | Defaults to reference `WipAccount` when empty. |
| Quantity | `txtQuantity` | `Quantity` | Changing it recomputes all lines (4.3) and checks runs (4.6). Disabled when order status is RELEASED, VOIDED or COMPLETED. |
| Maximum quantity | `MaxQuantity` + calculator button | `MaxQuantityCalculated` (default text `Not calculated`) | See 4.8. |
| Total cycle time | `txtTotalCycleTime` | computed | `secondsToTimeString(sum of operation planned times)`; shows `N/A` when above 2147483647. |
| Capacity calculation | `cmbCalcType` | `CapacityCalType` | `From planned date forward` = 1, `From required by date backward` = 2 (`CapacityCalculationsStore`, `ProductionCalculationTypeEnum`). Default 1. |
| Required by date | `cmbRequiredByDate` | `RequiredByDate` | Required when calc type is 2. |
| Planned date | `cmbStartDate` | `StartDate` | Required when calc type is 1. |
| Release date | `cmbReleaseDate` | `ReleaseDate` | Required to release (`Please specify release date.`). |
| Completion date | `cmbCompletionDate` | `CompletionDate` | Always disabled (set by the server). |
| Ignore components cumulative lead time | `chkIgnoreLeadTime` | `IsIgnoreLeadTime` | Disabled unless status is DRAFT. |
| In production / Ready to put away / Remaining / Output | `QuantityInProgress`, `QuantityCompleted`, `QuantityRemained`, `QuantityPutAway` | computed | See 4.5. |
| Comments | `Comments` | `Comments` | |
| BOM version | `cmbBomVersion` | `BomVersion`, `BomName` | Shown as a combo while loading is allowed, otherwise read-only text `<BomName>: <ProductName>`. Changing version warns `You have changed production BOM version. Please reload your BOM.` |

Other model fields (not edited here): `OrderNumber`, `OrderStatus`, `Status`, `MakeToOrderConfigurationID`, `IsMakeToOrderBomProduct`, `BomQuantity`, `MinQuantity`, `MaxQuantity`, `RunSize`, `IsTracing`, `IssueMethodComponent`, `IssueMethodParameter`, `IsLoadBOM`, `IsCreatedFromPurchase`, `IsCreatedFromMRP` / `MRPTaskID`, `ShowDeliveryTo`, `ShowRevertProducts`, `ScheduleStart`, `ScheduleDue`, `PlannedBy`, `ReleasedBy`, `OrderCycleTime`, `InstructionURL`, `CustomField1..10`.

Required fields on Save, Authorize and Release (`window.RequiredFieldsIds`, adjusted by `ProductionOrder_AdjustRequiredFieldList`): `cmbProduct`, `cmbProductName`, `cmbLocation`, `cmbOrderSource`, `cmbAccount`, `cmbWIPAccount`, `txtQuantity`, `cmbCalcType`, plus `cmbStartDate` when calc type is Forward or `cmbRequiredByDate` when it is Backward (the other one is removed from the list). Highlighting is done by `__HighlightInvalidFields.validation`.

Page title: `Production order #<OrderNumber>` or `New production order`.

### 4.2 Status strings and button / tab matrix

`Status` is the order's effective status; `OrderStatus` is the order-level status the client writes on Authorize / Release / Complete.

Order `Status` enum (`StatusTrackerHelper :: _statusEnum`): `DRAFT`, `AUTHORISED`, `PLANNED`, `RELEASED`, `IN PROGRESS`, `COMPLETED`, `VOIDED`. Run `Status` (`runStatusEnum`): `PLANNED`, `IN PROGRESS`, `OPERATIONS COMPLETED`, `COMPLETED`, `VOIDED`. Operation `Status` (`operationStatusEnum`): `PLANNED`, `IN PROGRESS`, `COMPLETED`, `VOIDED`, `SUSPENDED`.

Order form status chip (`_updateStatusElement`): COMPLETED `Completed`, PLANNED `Planned`, RELEASED `Released`, DRAFT `Draft`, IN PROGRESS `Work in progress`, VOIDED `Voided`; any other value (including AUTHORISED) is shown raw. The list page (`ProductionOrderStatuses`) shows AUTHORISED as `Authorized` and OPERATIONS COMPLETED as `Operations completed`; a list row of type `R` with status PLANNED shows `Released`.

| Control | Visible / enabled when | Ref |
|---|---|---|
| Save (`saveBtn`, `saveAction2`) | not read-only and Status != VOIDED | `canSaveData` |
| Authorize (`btnAuthoriseOrder`) | `FulfillmentPermission = Full`, OrderStatus DRAFT and at least one operation loaded | `canAuthoriseOrder` |
| Release (`btnReleaseOrder`) | `FulfillmentPermission = Full` and OrderStatus AUTHORISED | `canReleaseOrder` |
| Split (`btnSplitOrder`) | OrderStatus DRAFT and the order is saved | `canSplitOrder` |
| Production run (`btnAddRun`) | Status RELEASED or IN PROGRESS and not created from a purchase | `canAddRun` |
| Mark as completed (`btnMarkCompleted`) | not read-only, Status not COMPLETED/VOIDED, and Status RELEASED or IN PROGRESS | `isHeaderDisabled`, `isAfterReleased` |
| Undo (`btnUndo`) | `UndoPermission = Full` and Status not DRAFT and not VOIDED | `canUndo` |
| Void (`btnVoid`) | `VoidPermission = Full`, order saved, Status != VOIDED. On an unsaved order the Void click just goes to `/ProductionOrders`. | `canVoid`, `_void` |
| Print / Email | hidden when Status = VOIDED; Print menu needs a saved order | `canPrint` |
| Load BOM (`btnLoadBOM`) | Status DRAFT or PLANNED, and (not make-to-order product, or a make-to-order configuration is selected) | `canLoadBom` |
| Make-to-order buttons (`divMTOButtons`) | Status DRAFT or PLANNED, make-to-order product, no configuration chosen yet | `canLoadMtoConfiguration` |
| Maximum quantity calculator | not created from a purchase | `_updateVisibility` |
| Recalculate dates (`recalculateDates`) | order details not locked (OrderStatus not RELEASED/VOIDED/COMPLETED) | `canCalculateDates` |
| General fields (shop floor, product, accounts, ignore lead time) | Status DRAFT | `isGeneralDisabled` |
| Detail fields (quantity, planned date, calc type, release date) | OrderStatus not RELEASED/VOIDED/COMPLETED | `isDetailsDisabled` |
| Required by date | Status not COMPLETED/VOIDED | `isHeaderDisabled` |
| Transactions tab | Status != DRAFT and `ProductionFinancialDataPermission = Full`; transactions load only when Status is IN PROGRESS or COMPLETED | `canViewTransactions`, `canLoadTransactions` |
| Attachments tab | order saved | `_updateVisibility` |
| Activity log tab | order saved | `canViewActivityLog` |
| Related orders tab | always; adding related orders requires an authorised/released saved order | `AddNewRelatedOrder` |
| Delivery to tab | `ShowDeliveryTo` and not created from a purchase; editable when Status DRAFT or PLANNED | `canShowDeliveryTo`, `canEditDeliveryTo` |
| Availability column | Status not VOIDED and not COMPLETED | `canViewAvailability` |
| Run tabs (`Production run NN`) | appear when OrderStatus is RELEASED, COMPLETED or VOIDED; CSS state: `in-progress` (IN PROGRESS), `ready` (OPERATIONS COMPLETED), `completed`, `cancelled` (VOIDED); number padded to 2 digits (3 above 99) | `_rebuildMainTabs` |

### 4.3 Order BOM grid: quantities, wastage, cycle time

Order rows copy the BOM (4.4). Grid columns for components/resources: `Type`, `Component`, (cost-type icon), `Quantity` (`TotalQuantity`), `Unit`, `Wastage %` (`WastagePercent`), `Wastage qty` (`TotalWastageQty`), `Availability`, `Sales price` (`SalePriceTier`), `Cost per unit` (`Cost`), `Total cost`. Operation columns: `Sequence`, `Previous step`, `Type`, `Operation`, `Cycle time` (`CycleTimeString`), `Work center`, `Units per cycle time`, `Number of cycles`, `Total cost`.

Formulas (`ProductionBomComponentsHelper :: _recalculateQuantity`, `ProductionOrderComponent :: getOperationPlannedTime`):

- `qty` = order `Quantity`; `bomQty` = order `BomQuantity` (BOM output quantity).
- **Operation planned time (seconds):** for Manufacturing and Quality control: `Math.ceil(qty / UnitsPerCycle * CycleTime)`; for Setup and Co-manufacturing: `CycleTime` (quantity independent). `TotalUnitsPerCycle` = `qty` for non Setup/CoMan, else 0.
- **"Number of cycles" display:** Setup/CoMan show `1`; others `Math.ceil(TotalCycleTime / CycleTime)`. "Units per cycle time" shows `N/A` for Setup/CoMan.
- **Component total quantity:** for non-Setup operations `TotalQuantity = DEARRound(qty * (Quantity + (WastageQty > 0 ? WastageQty : WastagePercent * Quantity / 100)), 4)`; for Setup operations the same with `bomQty` in place of `qty`. If the component's `CostingMethod` contains `SN`, `TotalQuantity = Math.ceil(...)`. `Quantity` and `WastageQty` are **per unit**, `WastageQty` takes precedence over `WastagePercent`.
- **Cost seed per row:** component `Cost = ProductCost`; resource `Cost = ResourceCost`; output product `Cost = FixedCost`, `TotalOutputQuantity = OutputQuantity * qty`.
- `TotalWastageQty` (display) = `WastageQty * (non-Setup ? qty : bomQty)` (percentage wastage does not feed this column).
- **Editing the Quantity cell on a component:** `Quantity = DEARRound(value / (Setup ? bomQty : qty), 10)`; serial costing methods round `TotalQuantity` up. Editing `Wastage qty`: refused when greater than the total (`Wastage quantity cannot be more than total quantity for the component.`); otherwise `Quantity = DEARRound((TotalQuantity - value) / divisor, 10)` and `WastageQty = DEARRound(value / divisor, 10)` with the same divisor. On the order `Wastage %` is not editable (`beforeedit` returns false); resource `Quantity` edit sets `Quantity` and `TotalQuantity` to `DEARRound(value, 4)`.
- Editing a row's value while the order is not RELEASED/COMPLETED **removes all production runs** (`vProductionRunsStore.removeAll()`), because run lines are derived from order lines.

Editability on the order grid: Component rows: all fields except `Wastage %` and cost-type; Resource rows: `Component`, `Quantity`, cost-type only; Note/Attachment rows: `Component` only; FinishedProduct/Input/Output rows: none of `Component`, `Type`, cost-type. All locked unless `canLoadBom() || canLoadMtoConfiguration()` (grid `setEditable`).

Worked example (made-up numbers). Order quantity 50, BOM output quantity 10. Operation "Cut": Manufacturing, `CycleTime` 600 s, `UnitsPerCycle` 4. Component X: `Quantity` 2.5 per unit, `WastagePercent` 4, `WastageQty` 0, cost 1.20. Component Y: `Quantity` 1, `WastageQty` 0.2, `WastagePercent` 10, cost 0.50 (the 0.2 wins). Setup operation: component Z `Quantity` 0.5, no wastage, cost 3.00.
- Planned time "Cut" = `ceil(50 / 4 * 600)` = 7 500 s = `2h 5m`; number of cycles shown = `ceil(7500 / 600)` = 13.
- X total quantity = `50 * (2.5 + 4 * 2.5 / 100)` = `50 * 2.6` = 130.0000; Y = `50 * (1 + 0.2)` = 60.0000; Z (Setup, uses 10) = `10 * 0.5` = 5.0000.
- If X had a serial-number costing method: `ceil(130)` = 130; with 129.2 it would round up to 130.

### 4.4 Order cost roll-up (`ProductionOrderCostCalculationsHelper`)

Order of operations:
1. **Resource row** (`_updateResourceCost`): `rCost` = stored `Cost` when the order is not editable (status not DRAFT), else `ResourceCost`; `opCycleTime` = operation `TotalCycleTime`; `CostPerUnitTime`: `rTotal = cycleTime > 0 ? opCycleTime / cycleTime * rCost * Quantity : 0`; `CostPerFinishedProduct`: `rTotal = rCost * Quantity * orderQuantity`. `TotalCost = DEARRound(rTotal, 4)`; while editable `Cost = DEARRound(rCost, 4)`. (`cycleTime` is the resource's unit of time in seconds.)
2. **Component row** (`_updateComponentCost`): `cost` = stored `Cost` when not editable, else `ProductCost`; `TotalCost = DEARRound(cost * TotalQuantity, 4)` (wastage is already in `TotalQuantity`); `TotalWastageQty = WastageQty * (non-Setup ? orderQuantity : BomQuantity)`.
3. **Operation** (`_updateOperationCost`): `TotalCost` = sum of its resource and component `TotalCost` (no rounding, nulls count 0).
4. **Order total** (`_recalculateOrderTotal`): sum of operation costs. Shown as `DEARRound(total, 0)` when the order has no FinishedProduct rows, otherwise a table: per finished product `SKU`, `DEARRound(TotalOutputQuantity, 4)`, unit cost `TotalCost / TotalOutputQuantity` (blank-safe: 0 when quantity 0; `N/A` when the order has a co-man operation), and a **Total** row (`DEARRound(totalQty, 4)`, `DEARRound(totalCost, 2)`). Hidden when the user has no financial-data permission.
5. **Allocation to finished products** (`_updateYieldCost`, non co-man products only): the cost type is the `CostCalculationType` of the last such row. Sales Value (1): `totalSales = sum(Cost * TotalOutputQuantity)` where `Cost` is the product's fixed sales price copied from the BOM; each product gets `TotalCost = totalOrderCost * (Cost * TotalOutputQuantity) / totalSales` (ratio 0 when `totalSales = 0`). NRV (2): `_updateNrvCosts` takes each product's stored `Formula`, replaces `[operation_<index>]` with the operation `TotalCost` (index = position after sorting operations by `Order` then `Name`, index 0 = virtual start with cost 0) and `[product_<ProductID>]` with `Cost * TotalOutputQuantity`, `eval`s it, and sets `TotalCost = DEARRound(result, 4)`; negative results are clamped to 0 **only** when the order has a co-man operation; evaluation errors are ignored.

Worked example (continues 4.3). Resource R1, Machine, resource unit of time 3 600 s, cost 24.00 per unit, `Quantity` 2, `CostPerUnitTime`: `7500 / 3600 * 24 * 2` = 100.0000. Resource R2, `CostPerFinishedProduct`, cost 0.30, `Quantity` 2: `0.30 * 2 * 50` = 30.0000. Component rows: X `DEARRound(130 * 1.20, 4)` = 156.0000; Y `60 * 0.50` = 30.0000; Setup Z `5 * 3.00` = 15.0000. Operation "Cut" = 100 + 30 + 156 + 30 = 316.0000; Setup = 15.0000; order total = 331.0000. Two finished products: A (price 10, output 50), B (price 5, output 25): `totalSales = 500 + 125 = 625`; A cost = `331 * 500 / 625` = 264.8000 (unit 5.2960), B cost = `331 * 125 / 625` = 66.2000 (unit 2.6480).

### 4.5 Header quantity boxes (`ProductionTaskComponent :: _recalculateQuantities`)

For the main product only:
- **In production** = sum of `Quantity` of runs with Status IN PROGRESS.
- **Ready to put away** (`QuantityCompleted`) = for runs with Status OPERATIONS COMPLETED: sum of put-away line quantities for the order's product plus, for co-man tasks, sum of task lines with `Type = 'B'` for that product.
- **Output** (`QuantityPutAway`) = the same two sums for runs with Status COMPLETED.
- **Remaining** = `orderQuantity - Output - ReadyToPutAway`.
Each box shows `DEARRound(value, 4)`, and 0 when negative.

### 4.6 Runs, quantity checks, split

Create runs (`ProductionRunCreationComponent`, dialog `createRunModal`):
- Opening the dialog: `_remainingInRuns = orderQuantity - getRestQuantityToProduce()`, where `getRestQuantityToProduce(excludeRunId)` = for COMPLETED / OPERATIONS COMPLETED runs the put-away quantity of the main product (plus co-man `B` lines), for other non-voided runs the run `Quantity`, rounded to 4. Next run number = `max(run Number) + 1` over all runs.
- Each line: `Number`, `Quantity`, `RemainingQuantity = DEARRound(remaining - sum of previous lines, 4)`; deleting a line renumbers from `max(Number)` over **non-voided** runs.
- Create: error `Please add at least one production run.` for an empty dialog; per line error `Quantity should be greater than zero.`
- A new run is `Status PLANNED`, `WIPAccount` = order WIP account, `WastageType` / `WastageExpenseAccount` from the tenant, `IssueMethodParameter` from the order. For each order operation a run operation is created: `PlannedTime = getOperationPlannedTime(order operation, run quantity)`, status PLANNED, `SourceOperationID`, `OperationType`, work center, `IsBackflush`; each order resource is copied (`UnitCost = Cost`) and its cost computed (4.9). Backflush components are added when the order's `IssueMethodComponent` is Backflush: for BOM-level backflush all components, for Operation-level when the operation `IsBackflush`, for Component-level when the component `IsBackflush`; co-man operations always get their components.
- Before creating, `_checkOrderQtyAgainstRuns('runCreate', ...)` runs; if the total of runs exceeds the order quantity and operations exist the user gets a warning dialog, and on Proceed the order quantity is raised to the runs total (`updateQuantities`).

`_checkOrderQtyAgainstRuns` dialog: title `Warning`, text `Total order quantity has been changed. The quantities in the production order will be updated.` plus, when the change is an order-quantity decrease below the runs total, `<br/>All existing production runs will be removed.`, then `<br/>Would you like to proceed anyway?`; Proceed / Cancel. Cancel on an order-quantity edit restores the old quantity; Proceed with "removed" deletes all runs.

Save-time confirmations (`ProductionTaskComponent :: _save`, in this order, first match shown):
1. Backflush components removed: `Batches will be removed for components marked as backflush. Would you like to proceed?`
2. Reserved components removed: `Components reservation will be reset. Would you like to proceed?`
3. Quantity outside BOM min/max (`hasCoveredMinMax` false): `The production order quantity does not meet the minimum/maximum order quantity specified in the production BOM. Would you like to proceed anyway?` (No restores the previous order status.)
4. New run quantity differs from BOM `RunSize` on a RELEASED order: `The production order has a run with a quantity different then run size specified by the production BOM. Would you like to proceed anyway?`
5. Dimension changes: `Accounting dimensions in final accounting dimensions tab will be updated by current changes. It will be applied for all entities according event type. Do you want to continue or save page without saving accounting dimensions?`
Also an operation whose total cycle time exceeds 2147483647: row error `Total cycle time of the operation has been calculated to be very large. Production order cannot be created. Please check production BOM for errors in cycle time.` with toast `There were problems saving changes. Please see the errors in details.`

Save call (`_saveProcess`): `POST /api/ProductionOrder_Index_vProductionOrder` (new) or `PUT /api/ProductionOrder_Index_vProductionOrder/<ID>` with `{ID, HasErrors:false, Lang, AllowReschedule, Original:[...], Updated:[...]}`; timeout 7 200 000 ms. Result toast: `Changes saved successfully.` (+ server `ValidationText` on a new line), or `There were problems saving changes. Please see the errors in details.`, or the server text. Failure shows the error and reloads.

Split (`btnSplitOrder`, only DRAFT): dialog lines `Number`, `Quantity`, `RemainingQuantity`; first line is the original order. `RemainingQuantity = originalQuantity - sum of quantities so far`. Execute is refused unless the remainder is exactly 0: `The new quantity is higher than the original quantity.` Call: `POST /api/ProductionOrder_Index_ProductionOrderSplit` with `{ProductionOrders:[{ProductionOrderID, Quantity}]}`; result `{IsSuccess, Result, Error}`.

### 4.7 Authorize, Release, quantity suggestion, alternatives

- **Authorize** (`ProductionOrderComponent :: _authorise`): error `Please load BOM first.` if no operations; then (only if `MOStatus === 'RELEASED'`) the suggested-quantity check; then `OrderStatus = AUTHORISED` and Save.
- **Release** (`_release`): error `Please specify release date.` if empty; Save; then the alternative-products check; then the suggested-quantity check (always); then `OrderStatus = RELEASED` and Save. A rejected quantity check (user chose "Cancel order") voids the order (`/ProductionOrder/Void`, `allowVoidTasks`).
- **Alternative products** (`_checkAlternativeProducts`): `GET /api/ProductionOrder_Index_AlternativeProducts/check?productionOrderID=<id>` returns `[{ProductName, AlternativeProductName,...}]`. Dialog lines `The <ProductName> will be substituted by <AlternativeProductName>.`; Yes calls `PUT /api/ProductionOrder_Index_AlternativeProducts/substitute?productionOrderID=<id>` with the list. Revert: `GET .../getOriginalProduct?productionOrderID&operationID&productID`, dialog `The alternative product will be substituted by the original product.` (+ linked transfer order note, `A new transfer order/purchase will be created if required.`, `Would you like to proceed?`). Reverted rows get `IsAlternative=false`, `IsReverted=true` and the run components for that product are removed.
- **Suggested-quantity check** (`_checkOrderQuantity`, `ProductionCommon_CheckOrderQuantity`): only when `MOProduce` is `requiredInSalesAndReorder` or `availableMinusRequired`. `POST /ProductionOrder/GetSuggestedQuantity?locationId&productId&orderID` (order page) or `&qty=` (list/scheduler); response `{Quantity, Unit}`. On the order page the suggestion is clamped to the BOM: if `qty != 0` and `qty < MinQuantity` then `qty = MinQuantity` (message adds `The minimum quantity set up for production order is <b>min</b>.`), else if `qty > MaxQuantity` then `qty = MaxQuantity` (message adds the maximum sentence). Dialog (title `Confirmation`): `You created the production order for <b>{orderQty}</b> of {productName}. The quantity needed to cover "{settingName}" is <b>{qty}</b>. ` + clamp sentence + `<br/><br/>Would you like to produce:`. Buttons: cancel button labelled with the entered quantity (keep it), confirm button labelled with the suggestion, or `Cancel order` when the suggestion is 0. Shown only when `qty === 0` or `qty` differs from the entered quantity. Confirm with a suggestion calls `_updateQuantities(qty, true)` (removes runs if the new quantity is below the active runs' total); confirm with 0 voids the order.

### 4.8 Calculate dates, maximum quantity, BOM load

- **Recalculate dates** (`_calculateDates`): needs shop floor, product, quantity, calc type, the date matching the calc type, and no unsaved resource changes. Errors (concatenated with `<br/>`): `Please select shop floor.`, `Please select product.`, `Please specify quantity to produce.`, `Please select capacity calculation type.`, `Please specify planned date.`, `Please specify required by date.`, `Please save production order to calculate capacity.` Call: `POST /api/ProductionOrder_Index_GetPlanDates` with `locationId, productId, quantity, type, ignoreLeadTime, plannedDate` (type 1) or `requiredByDate` (type 2), `orderId` (only if operations exist), `Version` (BOM version); timeout 600 000. Response `{Success, RequiredByDate, PlannedDate, WorkStartDate, ErrorMessage}`. For type 1 it sets Required by date; for type 2 it sets Planned date; `WorkStartDate` always sets Release date. Info toast lists `Required by date has been set to <d>.` / `Planned date has been set to <d>.` / `Release date has been set to <d>.` A communication failure shows `The planning of the production order has taken more time than expected. Please try again and if it appears again contact Support.`
- **Maximum quantity** (`_recalculateMaxQty`): saved order: `POST /ProductionOrder/MaximumQuantityByOrder` (`orderId`); new order: errors `Please select order location.` / `Please select product.`, then `POST /ProductionOrder/MaximumQuantityByProduct` (`locationId`, `productId`, `version`). Result `{value}`.
- **Load BOM** (`_loadBom`): refused when read-only, Status VOIDED/COMPLETED or OrderStatus RELEASED. Errors `Please select BOM version first.` and `Please select product and shop floor first.` Call: `GET /api/ProductionOrder_Index_vProductionBom` with `ProductID, ShopFloorId, lang, WarehouseID, OrderID, Version`; response `{bom}` or `{errorText}`.
- **Process BOM load** (`_processBomLoad`): if existing runs contain an operation whose (`Order`, `Name`) is not in the new BOM: on a RELEASED order error `Could not reload BOM because we have detected changes in operations structure. Please undo this production order and reload BOM manually.`; otherwise confirm `We've detected changes in BOM structure. All existing production runs will be removed. Would you like to proceed anyway?` On success the order takes the BOM's `IsTracing`, `MinQuantity`, `MaxQuantity`, `RunSize`, `BomQuantity` (= BOM `OutputQuantity`), `IssueMethodComponent`, `IssueMethodParameter`, copies operations/resources/components/attachments/notes/configurations/links/output products with new guids (attachments marked `IsCloned`), then recalculates quantities, cost and cycle times (4.3, 4.4) and refreshes delivery-to.

### 4.9 Production run page area

Run tracker rules (`RunStatusTrackerHelper`), with `run` = current run, `op` = operation, `prev` = predecessor operations of the step:

| Action / control | Allowed when | Ref |
|---|---|---|
| Edit run header | run PLANNED | `canEditRun` |
| Start operation | not read-only, all predecessor operations COMPLETED, run PLANNED or IN PROGRESS, op PLANNED | `canStartOperation` |
| Suspend operation | run IN PROGRESS, op IN PROGRESS | `canSuspendOperation` |
| Resume operation | run IN PROGRESS, op SUSPENDED | `canResumeOperation` |
| Complete operation | run PLANNED/IN PROGRESS and op IN PROGRESS or SUSPENDED; for a co-man op additionally `CoManStatus` is `COMPLETED` or `RECEIVED` | `canCompleteOperation` |
| Yield operation | as Complete but non-co-man only, and `isYieldRequired` | `canYieldOperation`, `isYieldRequired` |
| Edit op components | non-co-man, run PLANNED/IN PROGRESS, op PLANNED/IN PROGRESS/SUSPENDED | `canEditOperationComponents` |
| Edit op field `ManualStartDate` | op PLANNED | `canEditOperation` |
| Edit op `EndDate` / `ManualEndDate` | op IN PROGRESS and run IN PROGRESS or PLANNED | same |
| Edit `ActualTimeString` | op COMPLETED, `EditCompletedOperationsPermission = Full`, run IN PROGRESS or OPERATIONS COMPLETED | same |
| Edit `PlannedTimeString` | only co-man ops, op not COMPLETED, same permission and run states; otherwise never | same |
| Edit op costs | `EditCompletedOperationsPermission = Full` and the op status equals `COMPLETED` | `canEditOperationCosts` |
| Edit op attributes | op not COMPLETED, or COMPLETED with the permission | `canEditOperationAttributes` |
| Edit op notes | run PLANNED/IN PROGRESS and op PLANNED/IN PROGRESS/SUSPENDED | `canEditOperationNotes` |
| Put-away tab visible | run != VOIDED | `canViewRunPutAway` |
| Edit put-away | run OPERATIONS COMPLETED | `canEditPutAway` |
| Prepare put-away | run not OPERATIONS COMPLETED and not COMPLETED | `canPreparePutAway` |
| Complete (finish) run | `FulfillmentPermission = Full`, run OPERATIONS COMPLETED | `canCompletePutAway` |
| Run void | `VoidPermission = Full`, run != VOIDED, order Status != COMPLETED | `canVoid` |
| Run undo | `UndoPermission = Full`, run not VOIDED and not PLANNED, order Status != COMPLETED | `canUndo` |
| Undo one operation | `UndoPermission = Full`, run not COMPLETED/PLANNED, op not PLANNED, and no **later** operation (higher `Order`) that is not PLANNED | `canUndoOperation` |
| Run transactions | run IN PROGRESS / OPERATIONS COMPLETED / COMPLETED and financial permission | `canViewRunTransactions` |
| Manual journals | run COMPLETED (edit) and financial permission (view) | `canEditManualJournals`, `canViewManualJournals` |
| Availability column | run not COMPLETED and not VOIDED | `canViewAvailability` |
| Reserve a component | run != COMPLETED, op PLANNED, and `DEARRound(reservedQty, 6) <= DEARRound(available - already-reserved-by-other-dirty-lines, 6)` for the same product and batch | `canComponentBeReserved` |
| Edit traceability | run != COMPLETED | `canEditTraceability` |
| Backflush flags | order `IssueMethodComponent` = Backflush; per-operation / per-component flags editable only on PLANNED operations | `canEditBackflush*` |
| Edit actual qty on a co-man input | co-man op PLANNED and an earlier operation outputs the same co-man product | `canEditActualQtyForInput` |

`isYieldRequired(op)`: for a non-co-man op, true if the source order operation has any FinishedProduct/Output line; if no operation has such a line and the order has no finished products at all, true only for the **last** non-completed operation (all other operations completed).

Operation actions (`ProductionRunComponent`):
- **Start** (`_startOperation` / `startOperationAction`): error `Operation doesn't have any components or resources. Please use auto pick.` if the op has neither (non co-man); for work-center mode `purchase`, products without a supplier are checked first. Start date defaults to today (date part). Error `Operation start date cannot be earlier than previous operation completion date.` if any operation of step `Order - 1` ended after the chosen date. Sets op IN PROGRESS and `StartDate`; sets run `StartDate` when the run was not yet IN PROGRESS; saves (a save failure reverts the op to PLANNED).
- **Suspend**: reason required, `Suspend reason is required.`; sets `SuspendReason` and `DowntimeType` from the chosen reason and op status SUSPENDED, then saves. **Resume**: op IN PROGRESS, saves.
- **Complete** (`_completeOperation`): `EndDate` defaults to today; errors `Operation completion date cannot be earlier than components write off date.` (start after end) and `Operation completion date cannot be earlier than operation start date.` (manual start after manual end). If yield is required the yield dialog opens first. Then op status goes to COMPLETED, `EndDate` set, run `EndDate` set when every operation is COMPLETED, planned operation `CompleteOperation`, Save; when the run ends up OPERATIONS COMPLETED the put-away tab opens.
- **Run resource cost** (`_updateResourceCost`): `UnitCost = Cost` until the op is COMPLETED; `opCycleTime = ActualTime || PlannedTime`; cost type read from the source order resource (default CostPerUnitTime). `CostPerUnitTime`: `cycleTime > 0 ? opCycleTime / cycleTime * UnitCost * Quantity : 0`. `CostPerFinishedProduct`: `UnitCost * Quantity * N` where `N` is the run quantity argument, else the quantity of the main product received through completed co-man task lines when > 0, else the run quantity box. `TotalCost = DEARRound(..., 4)`.
- **Run component cost** (`ProductionRunProductsComponent :: _updateComponentCost`): `TotalCost = DEARRound(UnitCost * Quantity, 4)`.
- **Planned run component quantity**: `PlannedQuantity = DEARRound(order component TotalQuantity * qtyRatio, 10)` with `qtyRatio = Setup ? 1 : runQuantity / orderQuantity` (serial-number components `Math.ceil`); output rows `ActualQuantity = DEARRound(Quantity - WastageQuantity, 10)`.
- **Complete run** (`_complete`): errors `Please fill effective date.` (received date empty), `Could not complete production run. Please see errors in details.` (output validation failed), `Based on NRV (Net Realizable Value) cost allocation type some costs for you finished products will be negative. Please check costs of your operations and sale values of finished products.` (`_hasNegativeCosts`), and `Cannot complete production run without any output.` when `MOWastageType === 'include'` and total output (put-away lines plus co-man `B` lines) is 0. Then, if there is no list of finished products and total output differs from the run quantity: `Output quantity is not equal to quantity in production run. Do you want to proceed anyway?` (Proceed / Cancel). Completing sets run Status COMPLETED, marks all put-away lines `Received = true`, Save. A text exists for zero allocated cost: `Production costs allocated is 0. Please ensure that 'sales value' is set up correctly in <product> production BOM. Would you like to proceed anyway?`.
- **Output line validation** (`ProductionRunPutAwayComponent :: _isValid`, per line; `total = Quantity + WastageQuantity`): `Please specify batch/serial number.` (non-FIFO, total > 0, no batch); `Please specify expiry date.` (costing `FEFO` or `FEBATCH`, total > 0); `Wastage should be posted as separate batch/serial number.` (Quantity > Wastage, wastage <> 0, non-FIFO with batch); `Please select received date.`; `Please select location.`; `Please select product.`; `Actually produced quantity for a product with serial number cannot be more than 1.` (serial costing and Quantity > 1); `Duplicate serial number`; `You already have a line with the same product, location, and batch/serial number.`; `Received date for finished product cannot be later than effective date.`; `You already have an output line with this location.` (FIFO, same location and product). Warnings: `Expiry date is in the past.`, `Quantity of the product is more than planned quantity.`
- **Void / Undo run**: Void confirm `This will reverse all transactions and change the status to voided! Would you like to proceed anyway?` (an unsaved/new run: `Production run will be deleted! Would you like to proceed?`). Linked tasks (`GET /ProductionOrder/CheckLinkedTasks?ID&runId`, or `CheckOperationLinkedTasks?ID&operationID` for one co-man op) raise `Following tasks were created for this production run. Would you like to void these tasks?` / `... undo these tasks?` with links; for undo, linked tasks in DRAFT or `SO IN PROGRESS` are skipped. Calls: `POST /ProductionOrder/VoidRun`, `POST /ProductionOrder/UndoRun`. After void: `Production run has been voided.`
- Dimensions on run: `Accounting dimensions` tab shown only for runs where `canViewRunDimensionTransactions` (status in progress / operations completed / completed) and financial permission.

Order-level destructive actions (`ProductionTaskComponent`):
- **Undo**: confirm `This will reverse all transactions and change the status to DRAFT. Would you like to proceed?` + optional ` and components reservation will be reset` / ` and link to source purchase will be removed` + `! Would you like to proceed anyway?`; `POST /ProductionOrder/Undo` (`ID`, `allowUndoTasks`); success `Production order has been undone.` or the warning form `Production order has been undone. Following problems occurred: ...`. Linked tasks (`GET /ProductionOrder/CheckLinkedTasks?ID`) prompt `Following tasks were created on production order release. Would you like to undo these tasks?`; for undo, tasks in `DRAFT`, `PO IN PROGRESS`, `SO IN PROGRESS` are skipped.
- **Void**: first `GET /ProductionOrder/CheckNestedOrdersToVoid?productionOrderID` (`{Result}`); the dialog `This will reverse all transactions and change the status to voided! Would you like to proceed anyway?` offers No/Yes, or Cancel / Yes / Yes with nested orders when nested orders exist; then linked-task prompt (`... Would you like to void these tasks?`); `POST /ProductionOrder/Void` (`ID`, `allowVoidTasks`, `allowVoidNestedOrders`); success `Production order has been voided.`
- **Mark as completed** (`_markAsCompleted`): refused with `The production order cannot be completed while there are incompleted production runs. Please complete output tab for production runs or void all active production runs.` (button Ok) if any run is neither COMPLETED nor VOIDED; otherwise `OrderStatus = COMPLETED` and Save.
- **Print / email**: `POST /ProductionOrder/Print` `{ProductionOrderID, PrintTemplateID, TasksIDs, Type}` (timeout 180 000) returns a blob id, downloaded through the hidden form `frmPrintDownload`. Print operations dialog needs a selection: `Please select any operations to print.`

Dimensions: when accounting dimensions are enabled and a prompt is needed, run dimension changes are saved only after the confirmation in 4.6 item 5.

Related-orders tab: error `Related orders can only be added to authorized, released production orders.`, `Please save the order before adding the Related Orders.`, `Unable to remove the related order. Please try again.`, `Unable to fetch order details. Please try again.`

Attachments: upload `POST /ProductionOrder/Upload` (order) / `UploadProductionBomAttachment` (operation) / `UploadProductionRunOperationAttachment` (run op) / `UploadRunYieldLines` (bulk yield lines); error `Could not upload file.`

### 4.10 Endpoints used by the order page (summary)

| Purpose | Method and URL |
|---|---|
| Load / save order | `GET /api/ProductionOrder_Index_vProductionOrder`, `POST` and `PUT .../<id>` |
| Product list, sale orders, BOM versions | `GET /api/ProductionOrder_Index_vProducts`, `vSaleOrders`, `vProductionBomVersions` |
| Load BOM | `GET /api/ProductionOrder_Index_vProductionBom` |
| Calculate dates | `POST /api/ProductionOrder_Index_GetPlanDates` |
| Max quantity | `POST /ProductionOrder/MaximumQuantityByOrder`, `MaximumQuantityByProduct` |
| Suggested quantity | `POST /ProductionOrder/GetSuggestedQuantity` |
| Availability | `GET /api/ProductionOrder_Index_ComponentAvailability` |
| Split | `POST /api/ProductionOrder_Index_ProductionOrderSplit` |
| Undo / Void order | `POST /ProductionOrder/Undo`, `Void`; `GET CheckLinkedTasks`, `CheckNestedOrdersToVoid` |
| Undo / Void run | `POST /ProductionOrder/UndoRun`, `VoidRun`; `GET CheckOperationLinkedTasks` |
| Run helpers | `GET /api/ProductionRun_Index_vComponentProducts`, `vShopFloorLocations`, `vProductionResources`, `Batches`, `ProductCosts`, `AutoPick`, `ReservedComponent` |
| Transactions | `GET /api/ProductionOrder_Index_Transactions`, `ProductionRun_Index_Transactions` |
| Related orders | `GET /api/ProductionOrder_Index_RelatedTasks` (+ `GetOrderList`, `GetOrderDetails`) |
| Scan | `/api/ProductionOrder_Scan`, `ProductionOrder_Scan_InventoryMode` |
| Make-to-order configuration | `GET /api/MakeToOrder_MakeToOrderConfiguration?ProductID` |

---

## 5. Production orders list (`/ProductionOrders`, bundle `ProductionOrdersList`)

- Model `vProductionOrderList` rows are orders (`TaskID == ProductionOrderID`) or run rows; columns include `OrderNumber`, product, `LocationName`, `Status`, `Quantity`, `StartDate`, `RequiredByDate`, `ReleaseDate`, `CompletionDate`, `TimeStatus`, `ResourceStatus`, `InventoryStatus`, tags, custom fields, source tasks, batches/serials.
- Filter (`ProductionList_FilterSet`): `ALL_BUT_VOIDED` (default, "All but voided"), `DRAFT`, `PLANNED`, `RELEASED`, `COMPLETED`, `IN_PROGRESS`, anything else "All". Date filter (`filterSetup.setDateFilter`): `all` (default), `7 days`, `14 days` (from today), `custom` (from/to pickers). Location filter is a multi-select. Settings persist in `localStorage` key `POList_filterSettings`. Query params: `filter, search, locationIDs, dateFrom, dateTo`.
- Row action buttons (only on order rows, user has bulk permission, not read-only): status DRAFT shows a plan button -> `ProductionList_Index_PlanOrder`; status AUTHORISED shows a release button -> `ProductionCommon_OpenReleasePopup`.
- **Plan dialog** (`planProductionOrder`): capacity calculation (1/2) and date are required, messages `Capacity calculation is required.<br/>` and `<label> required<br/>`; `POST /api/ProductionOrder_Index_ProductionOrderPlan` with `{ProductionOrderID, OrderCalcType, PlanOrderDate, SuggestedQuantity: null}`; success toast `Order successfully planned`. If `MOStatus === 'RELEASED'` the suggested-quantity check runs first.
- **Release dialog** (`ProductionCommon_ReleaseOrder`): error `Release date is required.<br/>`; `POST /api/ProductionOrder_Index_ProductionOrderRelease` `{ProductionOrderID, ReleaseOrderDate, SuggestedQuantity}`; toast `Order successfully released`.
- **Bulk actions** (permission-driven): `Void`, `Undo`, `ProductionOrder` (mark as completed, add tag), `BulkActions` (plan/release/consolidate/print) from `BulkPermissionStore`. Void / Undo / Complete confirmations: `This will reverse all transactions and change the status to voided! Would you like to proceed anyway?`, `This will reverse all transactions and change the status to DRAFT. Would you like to proceed anyway?`, `Marking the order as completed will reverse all uncompleted operations and components/resources allocations. The order status will be changed to completed.`; empty selection: `Please select at least one order.`; call `POST /api/ProductionOrdersListBulkAction` `{IDs, Action}` with `Action` = `void` / `undo` / `complete`. Plan / Release bulk: `POST /api/ProductionOrder_Index_ProductionOrderBulk` `{ProductionOrderIDs, Filter, Action: 'Plan'|'Release'}`; summary `Plan|Release of <TotalCount> production orders done. Failed: <FailedCount>, Skipped: <SkippedCount>` plus `Errors` joined by `<br/>`.
- **Consolidate**: `POST /api/ProductionOrder_Index_ProductionOrderConsolidation` returns groups (`SKU`, `Name`, `OrderNumbers`, `ProductionOrderIDs`, `OrderStatus`) and `MinimumRequiredByDate`; empty -> `Production orders for consolidation are not found.`; confirm needs `Required by date is required.<br/>`; `PUT` the same URL with `{ProductionOrders, RequiredByDate}`; success `Consolidation of production orders is done.` + results.

---

## 6. Production resources (`/ProductionResource`, bundle `ProductionResource`)

### 6.1 Resource record (`vProductionResource`)

| Field | Control | Options / rule |
|---|---|---|
| `Code`, `Name` | text | Required (`__HighlightInvalidFields.validation(['Code','Name','cmbType','cmbOperational'])`). |
| `ResourceType` | `cmbType` | `Labor` = 1, `Machine` = 2, `Other` = 3. Changing an existing resource **to Labor** shows a Warning dialog: `Changing resource type to labor will require to go over all individual resources and select user name from the list.` (button `Got it!`). |
| `IsActive` | `cmbOperational` | `Operational` (true) / `Non-operational` (false). |
| `Tags` | tag input | |
| `IsInfinite` | `chkInfiniteResource` | Hides the Capacity tab and its content; if the Capacity tab was active it switches to Costs. An infinite resource is never a constraint in the scheduler. |
| `IsAllowAllCapacityUsage` | `chkUseAllAvailable` | Carried to the scheduler model; semantics server-side. |
| `IsAvailableOnWeekends` | `chkWorkOnWeekends` | Includes weekend days in capacity and custom-hours editing. |
| `IsAvailableOnHolidays` | `chkWorkOnHolidays` | |
| `CycleDuration` | `CycleTimeH`, `CycleTimeM`, `CycleTimeS` | Seconds = `h*3600 + m*60 + s`. Max 90 days: error `Unit of time cannot be more than 90 days (2 160 hours).` (value restored). Zero or empty marks the three inputs invalid; Save refuses with `Please specify cycle duration.` and switches to the Costs tab. This is the resource's "unit of time" for time-based costing (the cost per unit is per this period; shown as the period next to the total). |

Tabs: Capacity, Costs, Attachments (enabled when saved), Remarks, References (when saved), Dimensions (needs `DimensionsPermission` Full/ReadOnly, dimensions enabled and at least one active). Warning text `noCalendarWarning` is shown when the tenant has no factory calendar. Resource title `Resource <Code>: <Name>`, new = `New resource`. Save: `POST /api/Resource_Index_vProductionResource` (new) / `PUT .../<id>` with `{ID, HasErrors, Original, Updated}`; failure `Could not save data. Please contact support.`; invalid form `There were problems saving changes. Please see the errors in details.`; Ctrl+S saves.

### 6.2 Capacity tab

Per shop floor (`vProductionResourceCapacity`: `LocationID`, `ResourceQuantity`, `HasCapacityHours`, `CapacityHoursWeek`); one row per tenant location is auto-created, rows for locations that no longer exist are removed (`ProductionResource_ProcessCapacities`). Columns: `Shop floor`, `Custom operational hours` (button `Add custom hours` / `Edit custom hours`), `Number of individual resources` (link to the units dialog), `Capacity per week (hours)`; totals are summed in the footer.

- `ResourceQuantity` = number of individual units (`vProductionResourceUnit`) of that shop floor (`ProductionResource_UpdateUnitsCount`); not directly editable (`ResourceQuantity` field locks tabbing only).
- **Individual resources** (`vProductionResourceUnit`: `Name`, `OperationalFrom`, `OperationalTo`, `NonOperationalFrom`, `NonOperationalTo`): row errors `Please specify name.`, `'Operational from' cannot be later than 'operational to'.`, `Non-operational from cannot be later than non-operational to.`; grid-level errors `Names of individual resources should be unique.` and `There were problems while saving changes. See errors in details.` Units whose shop floor has no capacity row are deleted on save.
- **Capacity per week** (`ProductionResource_UpdateCapacityValuesLocation`): `CapacityHoursWeek = DEARRound(weekCapacity * ResourceQuantity, 2)` where `weekCapacity` = for every weekday with a custom-hours row for that shop floor: its `Capacity` (hours; skipped if the day is a calendar weekend and `IsAvailableOnWeekends` is false), plus for the remaining weekdays the factory-calendar day capacity `Capacity / 3600` rounded to 2 (same weekend rule). `HasCapacityHours = true` when any custom row exists for the shop floor.
- **Custom hours dialog**: seven weekdays (sorted from the calendar `WeekStart`; weekend days only when "work on weekends" is ticked), defaults shown from the calendar (`DefaultStart`, `DefaultEnd`, `DefaultBreakStart`, `DefaultBreakEnd`). Times are chosen from a 5-minute list (`00:00` to `24:00`, `N/A` = -1). Validation per day: all four `-1` -> stored as 0/0/0/0 (day off); otherwise `Please specify start time.</br>`, `Please specify end time.</br>`, `Start time cannot be later than end time.</br>`, `Break start time cannot be later than break end time.</br>`, `Break start time should be between start time and end time.</br>`, `Break end time should be between start time and end time.</br>`; failure toast `There were problems while saving changes. See errors in details.` Delete removes all custom rows for the shop floor (falls back to the calendar).
- **Day capacity** (`ProductionResource_GetDayCapacity`, hours): `start`/`end`/`breakStart`/`breakEnd` of -1 are null; break 0..0 means no break; returns 0 when `start > end`, `breakStart > breakEnd`, `start > breakStart` or `end < breakEnd`; else `(end - start - (breakEnd - breakStart)) / 60` rounded to 2. (Minutes in, hours out.)

### 6.3 Costs tab (`vProductionResourceCost`)

Rows are service products: pick `ProductName` (service product, store `vProductCostsStore` with `PriceTear1..10`), `AccountCode`, `Cost`, `PriceTier`, `PlannedDowntimeCost` / `PlannedDowntimePriceTier`, `NotPlannedDowntimeCost` / `NotPlannedDowntimePriceTier`. Header tooltip on Cost: `Cost per cycle is set by service products. Please set up service products for all locations where your production is executed.`
- Picking a product sets all three tiers to 1 and `Cost = PlannedDowntimeCost = NotPlannedDowntimeCost = tier-1 price`, `AccountCode` = the product's expense account.
- Changing a tier sets the matching cost to `PriceTier<n>` or 0 when the tier is empty. `Cost`, `PlannedDowntimeCost`, `NotPlannedDowntimeCost` themselves are read-only (`ProductionResource_IsCostFieldEditable`).
- An account not in the cost-account store is cleared. Rows without a product are dropped on save.
- Totals (`ProductionResource_Cost_UpdateTotals`): `DEARRound(sum(Cost), 2)`, `sum(PlannedDowntimeCost)`, `sum(NotPlannedDowntimeCost)`; displayed as `<currency> <total>` per the unit of time. The order cost of one resource is therefore `sum of row Cost` per `CycleDuration`.
- `ResourceCost` and `CycleDuration` on BOM and order resource rows come from the server (`vProductionBomResources` store), the client does not total this tab into it. The two downtime rates are only edited here; how they are applied per suspend-reason `DowntimeType` (1 Planned, 2 Not planned) is server-side.

### 6.4 Backdated dates on run operations

`UseBackdatedTransaction` enables `cmbOperationStartDate` when the op field `ManualStartDate` is editable (op PLANNED) and `cmbOperationCompletionDate` when `ManualEndDate` is editable (op IN PROGRESS). Without it both are disabled (`_operationDatesVisibility`).

---

## 7. Factory calendar (`/ProductionCalendar`, bundle `ProductionCalendar`)

Model `vProductionCalendar` (`CalendarID`, `Year`, `WeekStart`); children `vProductionCalendarDay` (weekday rows: `DayOfWeek` 0 = Sunday to 6, `IsWeekend`, `StartTime`, `EndTime`, `BreakStartTime`, `BreakEndTime`) and `vProductionCalendarSpecialDay` (`Date`, `IsHoliday`, times, `Comment`). One calendar per year; URL hash is the year; new calendar defaults `WeekStart = 1`, `Year = current`.

- **Week start** options (`WeekDaysStore`): Monday 1, Tuesday 2, Wednesday 3, Thursday 4, Friday 5, Saturday 6, Sunday 0. **Weekends** is a multi-select of weekdays (`IsWeekend` per day); a calendar with no day rows defaults weekends to `[0, 6]`. Missing weekday rows are created client-side with times -1.
- Time pickers use 5-minute steps from `00:00` to `24:00` plus `N/A` (-1). A day with start and end both `0` is shown as -1 (not set); break only if both > 0.
- **Special days** (`FactoryCalendar_ValidationSpecialDates`, only dirty rows): `Please specify date.</br>`; `Date should not be less than today.</br>`; `Please specify start time and end time.</br>` (non-holiday needs both > 0); `Start time should be less than end time.</br>`; `Break start time should be less than break end time.</br>`; `Break start time and break end time should be between start time and end time.</br>`; `Start time and end time should be specified.</br>`; `Break start time and break end time should be specified.</br>`. **Holidays**: only `Please specify date.</br>`.
- Save (`FactoryCalendar_SaveProcess`): both validations pass, then (a) if no working day has hours: dialog `Please ensure that operational hours are added for all working days. These hours are essential for the resources capacity planning.` (Ok, save is not performed); (b) if holidays changed: confirm `Changing the dates of holidays/days off may cause changes in production order completion timelines. Would you like to proceed anyway?`; then `POST /api/Calendar_Index_vProductionCalendar` (new) or `PUT /api/Calendar_Index_vProductionCalendar?allowCapacityUpdate=false`. Times of -1 are sent as null. Validation failure toast `There were problems while saving changes. See errors in details.`; success `Changes saved successfully.`; leaving with unsaved changes while switching year: `There are unsaved changes. Do you really want to switch year?`
- Calendar marks holidays orange (`#ffa500`) and special days green (`#4caf50`).

---

## 8. Capacity planner (`/CapacityPlanner`, bundle `CapacityPlanner`)

- Only one browser tab: a second tab shows `You already have a Capacity Planner page opened in your browser, please close current page and use already opened page.`
- Filters (`CapacityPlanner_GetDataSearch`): `DateFrom` (default today), `DateTo` (default `DateFrom + 14 days`), `ResourceIDs`, `LocationIDs` (multi-selects), `IsOverAllocated` (checkbox). Data: `GET /api/CapacityPlanner_Index_ResourceCapacityRecords`; details `GET /api/CapacityPlanner_Index_CapacityDetails` (`startDate, endDate, LocationIDs, ResourceIDs, type` = `ALLOCATED` or `CONSUMED`); resources `GET /api/CapacityPlanner_Index_vResources`.
- Grid per resource and shop floor (`vCapacityPlannerRecord`): `Total` (`TotalCapacity`), `Available` (`AvailableCapacity`), `Allocated` (`AllocatedCapacity`), `Allocated planned` (`AllocatedPlanned`), `Allocated released` (`AllocatedReleased`), `Consumed` (`ConsumedCapacity`). Values arrive in **seconds** and are shown as hours: `DEARRound(value / 3600, 1)`; footer sums them. Allocated and Consumed non-zero values are links opening the details dialog (`CapacityPlanner_ShowAllocated`, `CapacityPlanner_ShowConsumed`). Presumably `Available = Total - Allocated` (computed server-side).
- Details rows (`vCapacityPlannerDetailsRecord`): order number, sale order, customer, product, sales rep, resource, location, `ReleaseDate`, `StartDate` (planned), `RequiredByDate`, status, `Capacity`, `Type`. Rows can be edited and re-planned: line errors `You already have a line of this production order with different planned/required by dates.`, `Please specify planned date.`, `Please specify required by date.`, `Required by date should be later than planned date.` (planned must be strictly earlier). The re-plan type is 1 when only the planned date changed, 2 when only the required-by date changed, else the row's `Type`.
- Re-plan (`CapacityPlanner_AutoRePlan`, `ManualRePlan`): `PUT /api/CapacityPlanner_Index_RePlan` with `type, orderId, plannedDate | requiredByDate, orderNumber, saveAllocation, isManual, SaleOrderNumber, SaleTaskID`. Response branches: `Success && saveAllocation`: toast `Production order <link> is allocated to planned date: <d>, Required by date <d>`, and if `CanChangeSaleDate` a prompt `Do you want to change required by date in <sale link> to newly set date?` (Yes calls `PUT /api/CapacityPlanner_Index_vSaleTask?taskId&date` and toasts `Sale has been updated.`); `Success && !saveAllocation`: dialog `Production order <link> can be allocated from <d> to <d>.Would you like to allocate production order <link> from <d> to <d>?` (Yes repeats with `saveAllocation: true`); `NotFoundCapacity && type == 2`: dialog `No available capacity found up to required by date <d> from the order. Would you like to allocate capacity starting from the required by date forward?` (Yes re-plans with type 1 from the required-by date); else `ErrorMessage` or `Could not plan production order for selected dates.`

---

## 9. Scheduler (`/ProductionScheduler`, bundle `Scheduler`)

### 9.1 Views and settings

Tabs: `orders`, `planning`, `calendar` view, plus resource table. Settings persist in `localStorage` key `ProductionSchedulerSettings` with defaults: `currentTab 'orders'`, `zoom 'day'`, `collapseAll false`, `showResources false`, `showDependencies false`, `showProblemLog false`, `showCompleted false`, `showWeekends false`, `dateSetup '14 days'`, `horizontalLines true`, `verticalLines true`, `customDateFrom/To null`, `shopFloorId null`, `nestedOrders false`.
Date ranges (`SchedulerSettingsComponent :: _setDates`): `all` (no range), `due today` (required-by = today), `week` (start of week to end of week), `7 days` (today + 7), `14 days` (today + 14), `custom`. An end date at 00:00 is extended to 23:59:59. Weekends/holidays are hidden in the Gantt unless "show weekends" is on (`gantt.ignore_time` = holiday or weekend).
Priority (`productionOrderPriorityType`): High 1, Medium 2, Low 3. Group status filters: `Released` = `RELEASED`, `Planned` = `PLANNED`.
Order flags: "lack of components" when `LackOfComponents` is non-empty; "behind the schedule" when status `PLANNED` and (release date before today or `PlanningDue` before today).
Group progress (`Scheduler_Gantt_RecalculateProgress`): for orders/runs/operations their own `progress`; for groups the average of child order progress, `DEARRound(total / count, 2)`; quantity sums child order `qty`.

### 9.2 Editing mode

`Start edit`: `POST /api/Scheduler_Index_vEditor/StartEdit?locationId=<shop floor>`; `{Success, ErrorMessage}`; on success the Save / Cancel buttons appear. Save: asks `Update required by date` -> `Would you like to update the required by date for the re-scheduled orders?` (calendar view: `... for the re-planned orders?`); `PUT /api/Scheduler_Index_vProductionOrders?requiredByUpdate=<Yes|No>` with the modified orders; success `Data saved successfully.`; `FailedRescheduleOrders` warns `Rescheduling failed for the following production order(s). Their schedule and capacity were not changed: <numbers>`; nothing changed -> warning `There is nothing to save.` Cancel/stop: `POST /api/Scheduler_Index_vEditor/StopEdit?locationId=...`. Errors `Please reload the page.`.
Rescheduling a task into the past: warning `Cannot re-schedule task in the past.`
Inline actions: start operation `POST /api/Scheduler_Index_StartOperation {OperationID}` (toast `Operation successfully started`); complete operation confirm `Used components and resources for the operation will be equal to planned quantities and cannot be edited after operation is completed.<br/>Would you like to proceed anyway?` (Proceed / Cancel) then `POST /api/Scheduler_Index_CompleteOperation` (toast `Operation successfully completed`); release selected planned orders (planning view, `ProductionOrderFulfillmentPermission = Full`): one order opens the release popup, several call `POST /api/ProductionOrder_Index_ProductionOrderBulk` `{ProductionOrderIDs, Filter:{}, Action:'Release', Schedule:true}`; no planned selection -> `Please select planned production order(s) to release.`

### 9.3 Capacity model and scheduling algorithm (`SchedulerEditorComponent`)

Data: factory calendar for the year of each date (`_getDateDetails`: weekday row gives `isWeekEnd`, times; a special-day row for the exact date gives `isHoliday` or `isSpecialDay` with its own times; holiday days keep the weekday times in the calendar record), resources with their units and custom day hours.

1. **Per-resource time line** (`_calculateResourceCalendar`): for each date from (view start - 3 days) to (view end + 3 days) (the cached range is reused when the view stays inside it and the shop floor is unchanged): the day starts from the calendar times; a custom-hours row for that shop floor and weekday replaces them; if (holiday and the resource is not `IsAvailableOnHolidays`) or (weekend and not `IsAvailableOnWeekends`) the times become 0. `hoursPerDay = max(end - start - (breakEnd - breakStart))` in minutes /60 rounded to 1. The working segments are `[start, breakStart]` and `[breakEnd, end]` (or `[start, end]` with no break), each with `total` = number of units of that shop floor that are available that day.
2. **Unit availability** (`_calculateResourceCalendar`): a unit counts for a day unless the day is within its non-operational range (open-ended ranges use 1970-02-01 and 2100-02-01 as bounds) or, when an operational range is set, the day is outside it.
3. **Allocation** (`_calculateAllocations`, `_calculateTimeLineWithAllocations`): every operation Gantt item of every non-completed run (and order-level planned operations) allocates `resource.value` units on each of its time segments; the merged time line is cut at every segment boundary; each interval gets `total` (available units), `allocated`, `available = total - allocated`. An interval with `allocated > total` flags all its tasks as problem orders (`getIsEnoughResources` false, `getIsResourceOverused` true).
4. **Capacity per day** (`getCapacityPerDay`): sum over setup intervals fully inside the day of `(end - start) * total`, in minutes. Allocated capacity uses `available` instead.
5. **Scheduling operations** (`_scheduleOperations`; the `forward` flag is passed in but never read, so scheduling always walks the time line forward): operations are taken in ascending step order. The earliest start for an operation is the latest end of its linked predecessors (or the start point); operations in the same step start at the earliest common start. Duration = `operation.Duration || operation.CycleTime` seconds. With no limited (non-infinite) resources the operation is placed back-to-back at the time point. With resources, it finds, per resource, the first interval with `total > 0` (or, when "respect others" is on, `total - allocations by other tasks >= required units`) at or after the start, then walks the time line allocating `min(remaining, interval length)` where all resources are simultaneously available; if "respect others" finds an interval that lacks capacity but has units it restarts the placement. If `remainingCapacity > 0` at the end of the time line: throws `Could not schedule task within given time period.` (task undone). Consecutive allocations are merged when they touch and are on the same calendar day.
6. **Guard:** rescheduling a set that contains a COMPLETED operation throws `Some operations were already completed and cannot be rescheduled. Please drag specific operations to reschedule them.`
7. **Propagation:** scheduling an operation reschedules the later operations of the same run, then later runs (`Number` greater) from the same time point, then the order-level (non-run) operations. Order `ScheduleStart` / `ScheduleDue` and run schedule dates are recalculated as min start / max end of their operations; `Items` (segments) are re-sent on save.
8. **Smart schedule** (`_smartSchedule`): start = `max(today, gantt start)`, forward, respecting other tasks.

---

## 10. Assembly (`/FinishedGoods`, bundle `Assembly2019`, list `FinishedGoodsList2019`)

Task model `vFinishedGoodsTask`: `AssemblyNumber`, `Status`, `LocationID`, `BinID`, `ProductID`, `Quantity`, `BatchSN`, `ExpiryDate`, `WIPDate`, `CompletionDate`, `Account` (finished goods account), `WIPAccount`, `QuantityToProduce` (BOM output quantity), `JobID`, `JobMilestoneID`, `Notes`, `CustomField1..10`. Children: `vFinishedGoodsOrders` (BOM lines, "order" grid), `vFinishedGoodsComponents` (pick lines), `vFinishedGoodsManualJournals`.

Statuses: `DRAFT`, `AUTHORISED`, `IN PROGRESS`, `COMPLETED`, `VOIDED` (list labels: Completed, Authorized, Draft, In progress, Voided). Flow: Draft -> Authorise -> (Allocate/pick) -> Start (`IN PROGRESS`) -> Complete. `FinishedGoods_Index_SetStatus` matrix:

| Control | Enabled when |
|---|---|
| Save | not read-only and not VOIDED |
| Undo | not VOIDED, not DRAFT, saved, `UndoPermission = Full` |
| Void | not VOIDED, saved, `VoidPermission = Full` |
| Clone, Print | not VOIDED, saved |
| Add BOM line, Scan, Authorise, Load BOM | DRAFT |
| Allocate (BOM tab), Add pick line, Scan, Allocate (pick tab) | AUTHORISED |
| Auto pick | AUTHORISED or IN PROGRESS |
| Complete | IN PROGRESS |
| Fields location, bin, account, WIP account, completion date, product | DRAFT only (account also locked for jobs) |
| Quantity, batch, expiry, WIP date, completion date | until COMPLETED or VOIDED; quantity label becomes `Actual yield` when IN PROGRESS or COMPLETED |
| Pick tab | enabled except VOIDED and (DRAFT) |
| Manual journals tab | COMPLETED only |

Rules:
- **Validate on authorise/start/complete/load BOM** (`FinishedGoods_Index_ValidateSubmit`), messages joined by `<br/>`: `Please choose a location.`, `Please choose the finished goods account.`, `Please choose the work in progress account.`, `Please choose a product.`, `Please specify a quantity.` (quantity must be > 0), `Please specify the expiry date.` (costing method `FESN` / `FEBATCH`).
- **BOM line totals** (`FinishedGoods_Index_UpdateTotals`): with assembly quantity `A > 0`: `TotalQuantity = DEARRound(A * (Quantity + (WastageQuantity > 0 ? WastageQuantity : WastagePercent * Quantity / 100)), 4)`; `TotalCost = DEARRound(TotalQuantity * Cost, 7)` (recomputed always for Stock lines or when the total is empty/zero or an explicit recompute is requested, else a typed total cost is kept); `A = 0` sets both to 0. The footer shows the sums of total quantity (4 decimals) and total cost.
- **Max quantity** (`FinishedGoods_Index_GetMaxQuantity`): warnings `Please select a location.` / `Please select a product to assemble.`; `POST /FinishedGoods/MaximumQuantityByProduct` (`ProductID`, `LocationID`) for a new task or `/FinishedGoods/MaximumQuantityByTask` (`TaskID`).
- **Start:** `Your pick list is empty.` warning if no pick lines. **Complete:** if `WIPDate > CompletionDate`: confirm `Work in progress date is greater than completion date. Are you sure you want to complete?`.
- **Auto pick** replaces the pick lines with the server's `AutoPick` result: each line `Quantity = TotalQuantity` of the pick, wastage 0, `PriceTier 1`, `Type 'Stock'`.
- **Void:** `You cannot void an unsaved assembly.`; confirm `This will reverse all transactions and change the status to voided! Would you like to proceed anyway?`; `POST /FinishedGoods/Cancel`; success toast `Void operation completed successfully.` **Undo:** `POST /FinishedGoods/Undo`, toast `Undo operation completed successfully.`
- Save: `POST/PUT /api/FinishedGoods_Index_vFinishedGoodsTask`. Titles `New assembly` / `Assembly #<number> of <product (truncated at 70 chars + ...)>`. Assembly instruction link text `Assembly instruction: No instruction specified for the product.` or `... Open`.
- Job link: hash `#job<JobID>|<MilestoneID>` preselects the job account and milestone.

## 11. Disassembly (`/Disassembly`, bundle `Disassembly2019`)

Task model `vDisassemblyTask`: `DisassemblyNumber`, `Status`, `LocationID`, `ProductID`, `Quantity`, `WIPAccount`, `WIPDate`, `CompletionDate`, `QuantityToProduce`, `Notes`; children `vDisassemblyPicking` (source cards: `CardID`, `Quantity`, `Date`, `UnitCost`, `BatchSN`, `ExpiryDate`, `Available`, `Cost`, `IsLocked`, `Bin`), `vDisassemblyComponents` (results: `ProductID`, `Quantity`, `Account`, `Cost`, `BatchSN`, `ExpiryDate`, `BinID`), `vDisassemblyServices` (`ProductID`, `Amount`, `Account`, `Comments`).
Statuses: `DRAFT`, `WORK IN PROGRESS`, `COMPLETED`, `VOIDED`. Flow: Draft -> Authorise (needs at least one pick line, else `You need to have at least one line in the pick to authorize it.`) -> Work in progress (fill results) -> Complete.
- Validation (`Disassembly_Index_ValidateSubmit`): `Please choose a location.`, `Please choose the work in progress account.`, `Please choose a product.`, `Please specify a quantity to disassemble.`; pick lines with quantity 0 are removed.
- Editable: pick lines only in DRAFT and not locked (`IsLocked`); components and services only in WORK IN PROGRESS (batch/expiry not editable for FIFO). Result tab disabled in DRAFT. Add / Load BOM / delete only in WORK IN PROGRESS; AutoPick and Authorise only in DRAFT; Complete (authorise-result button) only in WORK IN PROGRESS. Undo needs not DRAFT/VOIDED, saved, `UndoPermission = Full`; Void needs saved, `VoidPermission = Full`.
- **Auto pick** (`Disassembly_Pick_AutoPick`): walks the server's cards in order; for each unlocked card takes `min(card quantity, remaining)`; locked cards get 0; empty result -> `Not enough quantity to disassemble.` Pick `Cost = DEARRound(UnitCost * Quantity, 7)`.
- **Load BOM** (`Disassembly_Index_LoadBOM` -> store callback): `TotalPickCost = sum(pick Cost)`; per BOM component row `Quantity = BomQuantity * QuantityToDisassemble / QuantityToProduce`, `Cost = (totalPercentage == 0 ? 1 / componentCount : CostPercentage / 100) * TotalPickCost`; per BOM service `Amount = BomAmount * QuantityToDisassemble / QuantityToProduce`. Footer total = sum(component `Cost`) + sum(service `Amount`).
- Calls: `POST /Disassembly/Cancel`, `/Disassembly/Undo`, `GET /api/Disassembly_Index_LoadBOM`, `Pick`, `Components`, `Services`, `Products`, save `/api/Disassembly_Index_vDisassemblyTask`. Save toast `Changes saved successfully.` or `There were problems saving changes. Please check errors in details.`

## 12. Inventory write-off / issue to production (`/IssueToProduction`, bundle `IssueToProduction2019`)

Task model reuses `vFinishedGoodsTask` and `vFinishedGoodsComponent` (`ProductID`, `BinID`, `Quantity`, `TotalQuantity`, `Cost`, `CostValue`, `BatchSN`, `ExpiryDate`, `ExpenseAccount`). Statuses: `DRAFT`, `COMPLETED`, `VOIDED` (labels Draft, Completed, Voided). Required header fields (`RequiredFieldsIds`): location, account, completion date. Validation: `Please choose a location.`, `Please choose an account.` (a validation failure restores the previous status). `TotalQuantity = DEARRound(Quantity, 10)`. Add line needs a location: `Please choose the location first.`
Buttons: Complete only in DRAFT; Undo only when COMPLETED and `UndoPermission = Full`; Void when saved and not VOIDED with `VoidPermission = Full`; add/scan/import lines and delete column only in DRAFT; location, account and completion date only in DRAFT (account also locked for jobs). Calls `POST /IssueToProduction/Cancel`, `/Undo`, `/UploadTemplate`, `/Upload`; save `/api/IssueToProduction_Index_vFinishedGoodsTask`; reference data `/api/IssueToProduction_Index_ReferenceData`.

## 13. Job costing (`/JobCosting`, bundle `JobCosting2019`)

Job model `vJobCosting`: `JobNumber`, `Name`, `CustomerID`, `AccountCode`, `Contact`, `Status`, `StartDate`, `CompletedDate`, `EstimatedValue`, `BudgetedMargin`, `ProjectManager`, `TaxRuleID`, `AutoInvoice`, `Frequency`, `NextInvoiceDate`, `AttributeSet`, `CustomField1..10`; children milestones (`Name`, `Description`, `DateEstimated`, `DateActual`, `Status`) and notes.
Options: job `Status` PROSPECT (Prospect), IN PROGRESS (In progress), COMPLETED (Completed), CANCELLED (Canceled); milestone status DRAFT, IN PROGRESS, COMPLETED, CANCELLED; invoice `Frequency` Weekly, Fortnightly, Monthly (default), Quarterly, Half-Yearly (label Half-yearly), Annually; the frequency row is shown only when `AutoInvoice` is ticked.
Unallocated expenses to invoice: `InvoicingAmount = DEARRound(ExpenseAmount * (1 + BudgetedMargin / 100), 2)` (margin blank = 0), `JobCosting_Index_CalculateInvoicedAmount`. Calls: save `/api/JobCosting_Index_vJobCosting`, generate sale `POST /api/JobCosting_Index_GenerateSaleTask`, link sale `/api/JobCosting_Index_LinkSaleTask`.

---

## Not determinable statically (server-side rules)

- Any option list that lives in server-rendered HTML: general-settings selects (`MOCreateProductionOrder` values other than `saleOrder`, `MOProduce` values other than the two compared, `MOStatus` values, `MOWastageType` values other than `auto` / `include`, `MOCoManType`, `MOComponentDescriptionSource`, `MOTransferFinishedProduct`, `MODocumentSortOrder`, `FGProduce`) and the labels of the Production section.
- How `MOStatus` is derived from the stored settings, and exactly which of `MOCreateProductionOrderStatus` / `MOStatus` governs automatic order creation.
- Document numbering for production orders, assemblies, disassemblies and write-offs (prefix, next number, suffix); the run number format beyond the display padding.
- Everything behind `/api/...` and `/ProductionOrder/...` calls: server validation, the exact status transitions (including when a run becomes `OPERATIONS COMPLETED`, when an order becomes `PLANNED`, `IN PROGRESS` or `COMPLETED`, and how `Status` is derived from `OrderStatus` and the runs), stock movements, allocation and reservation, backflush execution, batch/serial selection in auto pick, and the sequencing of nested/dependent orders (`CheckNestedOrdersToVoid`).
- Journal postings: WIP debit/credit, finished goods and wastage accounts, co-man sale/purchase/transfer documents created on release, accounting dimension propagation, manual journal rules.
- Costing at execution: actual cost of components (FIFO/FEFO/average and batch cost picking), allocation of labour and downtime cost by `DowntimeType` (`PlannedDowntimeCost`, `NotPlannedDowntimeCost`), wastage cost distribution (`FixedWastageCost`, `WastageCost`), and the server-side NRV re-check.
- Capacity and planning engines: `GetPlanDates`, `MaximumQuantityBy*`, `GetSuggestedQuantity` (what "required in sales and reorder" and "available minus required" compute), `CapacityPlanner_Index_RePlan` allocation, `TotalCapacity` / `AllocatedCapacity` / `ConsumedCapacity` aggregation, how holidays interact with working times when planning forward/backward, buffer (`BufferPercent`) and lead-time arithmetic, `IsIgnoreLeadTime`, and priority handling.
- Bulk actions: how `Plan`, `Release`, `Consolidate` select and merge orders, what "Skipped" means, and the permission rules behind `BulkPermissionStore`.
- Make-to-order configuration rules, product customization, alternative-product substitution logic and revert conditions.
- Resource model: `IsAllowAllCapacityUsage` semantics, labour resources tied to user names, how `CycleDuration` converts into the cost per cycle for service-product based rates.
- Co-manufacturing: the documents generated per mode (`buysell`, `transfer`, `purchase`), `CoManStatus` values beyond those compared (`COMPLETED`, `RECEIVED`, and the other `CoManTaskStatusEnum` strings), supplier-less product checks.
- Permissions: the mapping of roles to `Full`, `ReadOnly`, `None` for each permission field.
- Job costing: sale generation, expense-to-milestone allocation, auto-invoice scheduling.
