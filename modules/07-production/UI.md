# Production: UI

Every component the page code builds, read from the shipped ExtJS bundles: grids with their columns, fields, buttons, menus, windows and custom components. Labels are the English UI text. `renders into` is the id of the `<div>` in the page's server-rendered HTML that the component mounts in; `store` names the data store (see the endpoints in [README.md](README.md)); `on click` is the handler. Visual system and shell layout: [docs/UI.md](../../docs/UI.md).

## Screens

| Route | Title | Bundles |
|---|---|---|
| `/CapacityPlanner` | Capacity Planner | [`CapacityPlanner`](#capacityplanner) |
| `/Disassembly` | Disassembly | [`Disassembly2019`](#disassembly2019) |
| `/DisassemblyList` | Disassemblies | [`DisassemblyList2019`](#disassemblylist2019) |
| `/FinishedGoods` | Assemblies | [`Assembly2019`](#assembly2019) |
| `/FinishedGoodsList` | Assemblies | [`FinishedGoodsList2019`](#finishedgoodslist2019) |
| `/IssueToProduction` | Inventory write-off | [`IssueToProduction2019`](#issuetoproduction2019) |
| `/IssueToProductionList` | Inventory write-off list | [`IssueToProductionList2019`](#issuetoproductionlist2019) |
| `/JobCosting` | Job details | [`JobCosting2019`](#jobcosting2019) |
| `/JobCostingList` | Job costings | [`JobCostingList2019`](#jobcostinglist2019) |
| `/ProductionCalendar` | Factory Calendar | [`ProductionCalendar`](#productioncalendar) |
| `/ProductionOrder` | Production order | [`Customization2019`](#customization2019), [`ProductionOrder`](#productionorder) |
| `/ProductionOrders` | Production orders list | [`ProductionOrdersList`](#productionorderslist) |
| `/ProductionResource` | Production resource | [`ProductionResource`](#productionresource) |
| `/ProductionScheduler` | Scheduler | [`Scheduler`](#scheduler) |
| `/ProductionSetup` | Setup | [`ProductionSetup`](#productionsetup) |

## Components by bundle

### `Assembly2019`

8 grids · 16 standalone fields · 0 windows · 18 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `divRealDimensions` · store `window.AccountingDimensionsRealTempStore` · placeholder `emptyMsgText`
- **grid** · renders into `divTDetails` · store `TransactionsStore` · placeholder `No transactions created.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Effective date | `EffectiveDate` |  | flex 1 | renderer() |  |
    | Debit | `Debit` |  | flex 1 | Common_COA_TreeMode_RestoreDisplayName |  |
    | Credit | `Credit` |  | flex 1 | Common_COA_TreeMode_RestoreDisplayName |  |
    | Amount | `Amount` |  | 130 | renderer() |  |

- **grid** · renders into `divOrderLines` · placeholder `Click the 'Load BOM' button to view the bill of materials`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `ProductCode` |  | flex 2 | renderer() | total count |
    | Expense account | `ExpenseAccount` |  | flex 1 | renderer() |  |
    | Quantity | `Quantity` |  | flex 1 |  |  |
    | Unit | `Unit` |  | flex 1 | RenderHTMLText |  |
    | Wastage % | `WastagePercent` |  | flex 1 | renderer() |  |
    | Wastage quantity | `WastageQuantity` |  | flex 1 | renderer() |  |
    | Total quantity | `TotalQuantity` |  | flex 1 | renderer() | total sum |
    | Available | `Available` |  | flex 1 | renderer() |  |
    | Total cost | `TotalCost` |  | flex 1 | renderer() | total sum |

- **grid** · renders into `divPickLines` · placeholder `Click the 'Auto pick' button to fill in the data`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `ProductCode` |  | flex 2 | renderer() | total count |
    | Bin | `BinName` |  | flex 1 | renderer() |  |
    | Batch # | `BatchSN` |  | flex 1 | renderer() |  |
    | Expiry date | `ExpiryDate` |  | flex 1 | renderer() |  |
    | Total quantity | `TotalQuantity` |  | flex 1 | renderer() | total sum |
    | Unit | `Unit` |  | flex 1 | RenderHTMLText |  |
    | Available | `Available` |  | flex 1 | renderer() |  |
    | Cost | `TotalQuantity` |  | flex 1 | renderer() | total sum |

- **grid** · renders into `divManualJournalsLines` · placeholder `You do not have any manual journals.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Debit | `Debit` |  | flex 1 | renderer() |  |
    | Credit | `Credit` |  | flex 1 | renderer() |  |
    | Reference | `Reference` |  | flex 1 | RenderHTMLText |  |
    | Date | `Date` | date column | flex 1 | edit: date field |  |
    | Amount | `Amount` |  | flex 1 | renderer() |  |

- **grid** · renders into `divRelatedOrdersDetails` · store `RelatedOrdersStore` · placeholder `No related orders created.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Order | `TaskNumber` |  | flex 1 | renderer() |  |
    | Type | `TaskTypeName` |  | flex 1 | RenderHTMLText |  |
    | Order date | `OrderDate` |  | flex 1 | renderer() |  |
    | Status | `Status` |  | flex 1 | renderer() |  |
    | Total | `TotalAmount` |  | 130 | renderer() |  |

- **grid** · renders into `divScanProductSelection` · store `storeScanProduct`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `ProductCode` |  | flex 2 | renderer() |  |
    | Batch/serial # | `BatchSN` |  | flex 1 | renderer() |  |
    | Expiry date | `ExpiryDate` |  | flex 1 | renderer() |  |

- **grid** · renders into `divAttachmentList` · store `FileStore` · placeholder `You do not have any uploaded files.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | File name | `FileName` |  | flex 1 | renderer() |  |
    | Attached by | `UserName` |  | flex 1 | renderer() |  |
    | Uploaded date | `UploadedDate` |  | flex 1 | renderer() |  |


#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| combo |  | `tdLocation` | `vTenantLocationStore` | shows `Description` · value `LocationID` · placeholder `Choose...` |
| combo |  | `tdBin` | `BinsStore` | shows `Description` · value `LocationID` · placeholder `Choose...` |
| combo |  | `tdJobMilestone` | `vJobMilestonesStore` | shows `Name` · value `ID` · placeholder `type to search...` |
| date field |  | `tdWIPDate` | `` | placeholder `Choose...` · format `UserDateFormat` |
| date field |  | `tdCompletionDate` | `` | placeholder `Choose...` · format `UserDateFormat` |
| text field |  | `tdBatchSN` | `` |  |
| date field |  | `tdExpiryDate` | `` | placeholder `Choose...` · format `UserDateFormat` |
| text field |  | `tdScanPackBox` | `` | placeholder `Choose...` |
| text field |  | `tdScanPackBoxInventory` | `` | placeholder `Choose...` |
| combo |  | `inputId` | `AutocompleteAddressField.prototype.AddressInfoSto…` | shows `description` · value `place_id` · placeholder `Look up an address` |
| date field |  | `WorkflowModal_dtWorkflowDate` | `` | format `UserDateFormat` |
| combo |  | `"SalePicker_".concat(…)` | `window.saleVars.originalStore` | shows `window.saleVars.displayFieldName` · value `window.saleVars.idFieldName` · placeholder `window.saleVars.emptyText… |
| text field |  | `renderTo` | `` |  |
| checkbox |  | `renderTo` | `` |  |
| numeric field |  | `renderTo` | `` |  |
| date field |  | `renderTo` | `` | placeholder `Choose...` · format `UserDateFormat` |

#### Menus, buttons and other parts

- **column** “Entity” · field `EntityType` · id `colRealDimensionsEntity`
- **column** “Account” · field `AccountCode` · id `colRealDimensionsAccount`
- **column** “Amount” · field `Amount` · id `colRealDimensionsAmount`
- **column** “Reference number” · field `ReferenceNumber` · id `colRealDimensionsReferenceNumber`
- **column** “Effective date” · field `EffectiveDate` · id `colRealDimensionsDate`
- **column** “Product” · field `ProductCode` · id `colRealDimensionsProduct`
- **column** “Supplier \| Customer” · field `"".concat(…)` · id `"colRealDimensions".concat(…)`
- **column** “{attr}” · field `attr.replace(…)` · id `"col".concat(…)`
- **button** “{Name}” · id `"Print".concat(…)` · on click `handler()`
- **component** · renders into `tdProductCode` · store `ProductsStore` · shows `ProductCode` · value `ProductID` · placeholder `Choose...`
- **component** · renders into `tdProductName` · store `ProductsStore` · shows `Name` · value `ProductID` · placeholder `Choose...`
- **component** · renders into `tdWIPAccount` · store `wipAccountStore` · shows `DisplayName` · value `Code` · placeholder `Choose...`
- **component** · renders into `tdAccount` · store `FinishedGoodsAccountStore` · shows `DisplayName` · value `Code` · placeholder `Choose...`
- **component** · renders into `tdQuantity` · required
- **component** · renders into `tdScanQuantity` · required
- **text area** · renders into `divInventoryModeBarcodes` · placeholder `Enter your barcodes here...`
- **component** · id `cmpId` · renders into `renderTo` · store `localStore` · shows `name` · value `value` · placeholder `Choose...` · pick-only
- **column** “{attrSet.name}” · field `"CustomField".concat(…)`

### `CapacityPlanner`

2 grids · 5 standalone fields · 0 windows · 0 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `listContainer` · store `mainStore` · placeholder `PageResources.NoResources`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | {PageResources.Resource} | `ResourceID` |  | flex 2 | renderer() |  |
    | {PageResources.Location} | `LocationID` |  | flex 2 | renderer() | total count |
    | {PageResources.Total} | `TotalCapacity` |  | flex 1 | renderer() | total sum |
    | {PageResources.Available} | `AvailableCapacity` |  | flex 1 | renderer() | total sum |
    | {PageResources.Allocated} | `AllocatedCapacity` |  | flex 1 | renderer() | total sum |
    | {PageResources.AllocatedPlanned} | `AllocatedPlanned` |  | flex 2 | renderer() | total sum |
    | {PageResources.AllocatedReleased} | `AllocatedReleased` |  | flex 2 | renderer() | total sum |
    | {PageResources.Consumed} | `ConsumedCapacity` |  | flex 1 | renderer() | total sum |

- **grid** · renders into `detailsContainer` · store `detailsStore`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    |  | `Status` |  | 34 | renderer() |  |
    | {PageResources.OrderNo} | `ProductionOrderNumber` |  | flex 1 | renderer() |  |
    | {PageResources.SaleOrderNumber} | `SaleOrderNumber` |  | flex 1 | renderer() |  |
    | {PageResources.CustomerName} | `CustomerName` |  | flex 1 | renderer() |  |
    | {PageResources.ProductName} | `ProductCode` |  | flex 1 | renderer() |  |
    | {PageResources.SalesRep} | `SalesRepresentative` |  | flex 1 | renderer() |  |
    | {PageResources.Resource} | `ResourceCode` |  | flex 1 | renderer() |  |
    | {PageResources.Location} | `LocationName` |  | flex 1 |  |  |
    | {PageResources.ReleaseDate} | `ReleaseDate` |  | flex 1 | renderer() |  |
    | {PageResources.PlannedDate} | `StartDate` | date column | flex 1 | renderer() · edit: date field |  |
    | {PageResources.RequiredByDate} | `RequiredByDate` | date column | flex 1 | renderer() · edit: date field |  |
    | {PageResources.Allocated} | `Capacity` |  | flex 1 | renderer() |  |
    |  | `FakeID` |  | 150 | renderer() |  |


#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| date field |  | `cmbPlanFrom` | `` | format `UserDateFormat` |
| date field |  | `cmbPlanTo` | `` | format `UserDateFormat` |
| combo |  | `cmbLocation` | `locationStore` | shows `Description` · value `LocationID` · placeholder `Choose...` · multi-select |
| combo |  | `cmbResource` | `resourcesStore` | shows `Name` · value `ResourceID` · placeholder `Choose...` · multi-select |
| checkbox |  | `chkOverAllocated` | `` |  |

### `Disassembly2019`

6 grids · 3 standalone fields · 0 windows · 13 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `divAttachmentList` · store `FileStore` · placeholder `You do not have any uploaded files.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | File name | `FileName` |  | flex 1 | renderer() |  |
    | Attached by | `UserName` |  | flex 1 | renderer() |  |
    | Uploaded date | `UploadedDate` |  | flex 1 | renderer() |  |

- **grid** · renders into `divRealDimensions` · store `window.AccountingDimensionsRealTempStore` · placeholder `emptyMsgText`
- **grid** · renders into `divTDetails` · store `TransactionsStore` · placeholder `No transactions created.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Effective date | `EffectiveDate` |  | flex 1 | renderer() |  |
    | Debit | `Debit` |  | flex 1 | Common_COA_TreeMode_RestoreDisplayName |  |
    | Credit | `Credit` |  | flex 1 | Common_COA_TreeMode_RestoreDisplayName |  |
    | Amount | `Amount` |  | 130 | renderer() |  |

- **grid** · renders into `divPickLines` · placeholder `Click the 'Auto pick' button to view the available cards to disassemb…`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Bin | `Bin` |  | flex 1 | renderer() |  |
    | Date received | `Date` | date column | flex 1 |  | total count |
    | Batch/serial # | `BatchSN` |  | flex 1 | renderer() |  |
    | Expiry date | `ExpiryDate` | date column | flex 1 | renderer() |  |
    | On hand | `Available` |  | flex 1 |  |  |
    | Unit cost | `UnitCost` |  | flex 1 |  |  |
    | Quantity to disassemble | `Quantity` |  | flex 1 | renderer() | total sum |
    | Total cost | `Cost` |  | flex 1 |  | total sum |

- **grid** · renders into `ComponentsContainer` · placeholder `Add at least one component as a result of disassembly.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `ProductCode` |  | flex 2 | renderer() | total count |
    | Bin | `BinID` |  | flex 1 | renderer() |  |
    | Unit of measure | `Unit` |  | flex 1 | renderer() |  |
    | Batch no. | `BatchSN` |  | flex 1 | renderer() |  |
    | Expiry date | `ExpiryDate` | date column | flex 1 | renderer() · edit: date field |  |
    | Inventory account | `Account` |  | flex 1 | renderer() |  |
    | Quantity | `Quantity` |  | flex 1 |  | total sum |
    | Total cost | `Cost` |  | flex 1 | renderer() | total sum |

- **grid** · renders into `ServicesContainer` · placeholder `No labor and overheads added to this disassembly.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Labor & overheads | `Name` |  | flex 2 | renderer() | total count |
    | Expense account | `Account` |  | flex 1 | renderer() |  |
    | Comments | `Comments` |  | flex 2 |  |  |
    | Amount | `Amount` |  | flex 1 | renderer() | total sum |


#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| date field |  | `WorkflowModal_dtWorkflowDate` | `` | format `UserDateFormat` |
| combo |  | `tdLocation` | `vTenantLocationStore` | shows `Description` · value `LocationID` · placeholder `Choose...` |
| date field |  | `tdCompletionDate` | `` | placeholder `Choose...` · format `UserDateFormat` |

#### Menus, buttons and other parts

- **column** “Entity” · field `EntityType` · id `colRealDimensionsEntity`
- **column** “Account” · field `AccountCode` · id `colRealDimensionsAccount`
- **column** “Amount” · field `Amount` · id `colRealDimensionsAmount`
- **column** “Reference number” · field `ReferenceNumber` · id `colRealDimensionsReferenceNumber`
- **column** “Effective date” · field `EffectiveDate` · id `colRealDimensionsDate`
- **column** “Product” · field `ProductCode` · id `colRealDimensionsProduct`
- **column** “Supplier \| Customer” · field `"".concat(…)` · id `"colRealDimensions".concat(…)`
- **column** “{attr}” · field `attr.replace(…)` · id `"col".concat(…)`
- **button** “{Name}” · id `"Print".concat(…)` · on click `handler()`
- **component** · renders into `tdProductCode` · store `DisassemblyProductSelectStore` · shows `ProductCode` · value `ProductID` · placeholder `Choose...`
- **component** · renders into `tdProductName` · store `DisassemblyProductSelectStore` · shows `Name` · value `ProductID` · placeholder `Choose...`
- **component** · renders into `tdWIPAccount` · store `InventoryAccountsStore` · shows `DisplayName` · value `Code` · placeholder `Choose...`
- **component** · renders into `tdQuantity` · required

### `DisassemblyList2019`

1 grids · 0 standalone fields · 0 windows · 0 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `DisassemblyList_Index_Container` · store `mainStore` · placeholder `You do not have any disassemblies at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    |  | `` |  | flex 1 | renderer() | hidden |
    | Disassembly # | `DisassemblyNumber` |  | flex 1 | renderer() |  |
    | Product | `ProductCode` |  | flex 1 | renderer() |  |
    | Quantity | `Quantity` |  | flex 1 |  |  |
    | Location | `Location` |  | flex 1 | renderer() |  |
    | Date | `Date` |  | flex 1 | renderer() |  |
    | Status | `Status` |  | flex 1 | RenderStatus |  |
    | Comment | `Notes` |  | flex 1 |  |  |


### `FinishedGoodsList2019`

1 grids · 0 standalone fields · 0 windows · 0 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `FinishedGoodsList_Index_Container` · store `mainStore` · placeholder `You do not have any finished goods at the moment.`

### `IssueToProduction2019`

7 grids · 8 standalone fields · 0 windows · 11 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `divRealDimensions` · store `window.AccountingDimensionsRealTempStore` · placeholder `emptyMsgText`
- **grid** · renders into `divTDetails` · store `TransactionsStore` · placeholder `No transactions created.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Effective date | `EffectiveDate` |  | flex 1 | renderer() |  |
    | Debit | `Debit` |  | flex 1 | Common_COA_TreeMode_RestoreDisplayName |  |
    | Credit | `Credit` |  | flex 1 | Common_COA_TreeMode_RestoreDisplayName |  |
    | Amount | `Amount` |  | 130 | renderer() |  |

- **grid** · renders into `GridContainer` · placeholder `Nothing added to this inventory write-off task.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `ProductCode` |  | flex 2 | renderer() | total count |
    | Bin | `LocationName` |  | flex 1 | renderer() |  |
    | Batch/serial no. | `BatchSN` |  | flex 1 | renderer() |  |
    | Expiry date | `ExpiryDate` |  | flex 1 | renderer() |  |
    | Expense account | `ExpenseAccount` |  | flex 1 | renderer() |  |
    | Quantity | `Quantity` |  | flex 1 |  | total sum |
    | Cost | `CostValue` |  | flex 1 | renderer() |  |
    | Available | `Available` |  | flex 1 | renderer() |  |
    | Total cost | `TotalQuantity` |  | flex 1 | renderer() | total count |

- **grid** · renders into `UploadExceptionsGrid` · store `UploadErrorsStore` · placeholder `Please upload a file to check for issues.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Line # | `Line` |  | 50 |  |  |
    | Product SKU | `SKU` |  | 150 | renderer() |  |
    | Bin | `Bin` |  | 120 | renderer() |  |
    | Batch S/N | `BatchSN` |  | 120 | renderer() |  |
    | Expiry date | `ExpiryDate` |  | 100 | renderer() |  |
    | Expense account | `ExpenseAccount` |  | 100 | renderer() |  |
    | Quantity | `Quantity` |  | 80 | renderer() |  |

- **grid** · renders into `divScanProductSelection` · store `storeScanProduct`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `ProductCode` |  | flex 2 | renderer() |  |
    | Batch/serial # | `BatchSN` |  | flex 1 | renderer() |  |
    | Expiry date | `ExpiryDate` |  | flex 1 | renderer() |  |

- **grid** · renders into `divAttachmentList` · store `AttachmentsStore` · placeholder `You do not have any files attached.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Name | `FileName` |  | flex 2 | renderer() |  |
    | Date | `UploadedDate` |  | flex 1 | renderer() |  |
    | Attached by | `UserName` |  | flex 2 | RenderHTMLText |  |

- **grid** · renders into `_classPrivateFieldGet(…)` · store `_classPrivateFieldGet(…)`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    |  | `Selected` |  | 58 | renderer() |  |
    | Original account | `AccountCode` |  | flex 1 | renderer() |  |
    | Amount | `Amount` |  | flex 1 | renderer() |  |
    | Distributed amount | `DistributedAmount` |  | flex 1 | renderer() |  |
    | Left to distribute | `LeftToDistribute` |  | flex 1 | renderer() |  |
    | Note | `Invoices` |  | flex 2 | renderer() |  |


#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| date field |  | `WorkflowModal_dtWorkflowDate` | `` | format `UserDateFormat` |
| combo |  | `tdLocation` | `vTenantLocationStore` | shows `Description` · value `LocationID` · placeholder `Choose...` |
| combo |  | `tdJobMilestone` | `vJobMilestonesStore` | shows `Name` · value `ID` · placeholder `type to search...` |
| date field |  | `tdCompletionDate` | `` | placeholder `Choose...` · format `UserDateFormat` |
| text field |  | `tdScanPackBox` | `` | placeholder `Choose...` |
| text field |  | `tdScanPackBoxInventory` | `` | placeholder `Choose...` |
| combo |  | `"js-task-name_".concat(…)` | `store` | shows `DistributedAmountGrid_classPrivateField…` · value `DistributedAmountGrid_classPrivateField…` · placeholder `type… |
| numeric field |  | `"divTargetAccountDistribute_".concat(id).concat(…)` | `` |  |

#### Menus, buttons and other parts

- **column** “Entity” · field `EntityType` · id `colRealDimensionsEntity`
- **column** “Account” · field `AccountCode` · id `colRealDimensionsAccount`
- **column** “Amount” · field `Amount` · id `colRealDimensionsAmount`
- **column** “Reference number” · field `ReferenceNumber` · id `colRealDimensionsReferenceNumber`
- **column** “Effective date” · field `EffectiveDate` · id `colRealDimensionsDate`
- **column** “Product” · field `ProductCode` · id `colRealDimensionsProduct`
- **column** “Supplier \| Customer” · field `"".concat(…)` · id `"colRealDimensions".concat(…)`
- **column** “{attr}” · field `attr.replace(…)` · id `"col".concat(…)`
- **component** · renders into `tdAccount` · store `vChartOfAccountsStore` · shows `DisplayName` · value `Code` · placeholder `Choose...`
- **component** · renders into `tdScanQuantity` · required
- **text area** · renders into `divInventoryModeBarcodes` · placeholder `Enter your barcodes here...`

### `IssueToProductionList2019`

1 grids · 0 standalone fields · 0 windows · 0 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · id `Grid` · renders into `IssueToProductionList_Index_Container` · store `mainStore`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    |  | `` |  | flex 1 | renderer() | hidden |
    | Write-off # | `AssemblyNumber` |  | flex 1 | renderer() |  |
    | Location | `Location` |  | flex 1 | renderer() |  |
    | Date | `Date` |  | flex 1 | renderer() |  |
    | Status | `Status` |  | flex 1 | RenderStatus |  |
    | Notes | `Notes` |  | flex 2 | RenderHTMLText |  |


### `JobCosting2019`

7 grids · 30 standalone fields · 0 windows · 2 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `divMilestonesLines` · placeholder `No milestones added to this job.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Description | `Name` |  | flex 2 | RenderHTMLText |  |
    | Comments | `Description` |  | flex 2 | renderer() |  |
    | Date estimated | `DateEstimated` | date column | flex 1 | renderer() · edit: date field |  |
    | Date actual | `DateActual` | date column | flex 1 | renderer() · edit: date field |  |
    | Status | `Status` |  | flex 1 | renderer() |  |

- **grid** · renders into `divAttachmentsLines` · store `vJobCostingAllAttachementsStore` · placeholder `No attachments found.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | File | `FileName` |  | flex 2 | renderer() |  |
    | Date | `Date` |  | flex 1 | renderer() |  |
    | Milestone | `MileStoneName` |  | flex 1 | RenderHTMLText |  |
    | Attached by | `UserName` |  | flex 1 | RenderHTMLText |  |

- **grid** · renders into `divInvoicedLines` · store `vJobCostingSalesStore` · placeholder `No sale invoices found.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Milestone | `Milestone` |  | flex 1 | renderer() |  |
    | Sale order # | `SaleOrderNumber` |  | flex 1 | renderer() |  |
    | Invoice # | `InvoiceNumber` |  | flex 1 | renderer() |  |
    | Invoice date | `InvoiceDate` |  | flex 1 | renderer() |  |
    | Expense amount | `ExpenseAmount` |  | flex 1 | renderer() |  |
    | Budgeted amount | `BudgetedAmount` |  | flex 1 | renderer() |  |
    | Invoiced amount | `SaleAmount` |  | flex 1 | renderer() |  |

- **grid** · renders into `tblNote` · placeholder `You do not have any notes.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Date | `Date` |  | flex 1 | renderer() |  |
    | Category | `Category` |  | flex 1 | renderer() |  |
    | Note | `Note` |  | flex 2 | renderer() |  |
    | User | `Username` |  | flex 1 | renderer() |  |

- **grid** · renders into `divAttachmentsGrid` · store `vJobCostingAttachementStore` · placeholder `You do not have any attached files.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | File | `FileName` |  | flex 1 | renderer() |  |

- **grid** · renders into `divUnallocatedExpensesLinesInvoicing` · store `vJobCostingUnallocatedExpensesStore` · placeholder `You do not have any unallocated expenses.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Expense task | `ExpenseTaskID` |  | flex 1 | renderer() | total count |
    | Milestone | `MilestoneName` |  | flex 1 | renderer() |  |
    | Date | `Date` |  | flex 1 | renderer() |  |
    | Expense amount | `ExpenseAmount` |  | flex 1 | renderer() |  |
    | Margin | `ExpenseAmount` |  | flex 1 | renderer() |  |
    | Invoicing amount | `InvoicingAmount` |  | flex 1 | renderer() | total sum |

- **grid** · renders into `divUnallocatedExpensesLinesLinking` · store `vJobCostingUnallocatedExpensesStore` · placeholder `You do not have any unallocated expenses.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Expense task | `ExpenseTaskID` |  | flex 1 | renderer() | total count |
    | Milestone | `MilestoneName` |  | flex 1 | renderer() |  |
    | Date | `Date` |  | flex 1 | renderer() |  |
    | Expense amount | `ExpenseAmount` |  | flex 1 | renderer() | total sum |


#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| date field |  | `WorkflowModal_dtWorkflowDate` | `` | format `UserDateFormat` |
| text field |  | `JobCosting_Index_Name` | `` |  |
| combo |  | `JobCosting_Index_Customer` | `vCustomerStore` | shows `Name` · value `Name` · placeholder `type to search...` |
| combo |  | `JobCosting_Index_Contact` | `vCustomerContactStore` | shows `Name` · value `Name` · placeholder `Choose or type new...` |
| text field |  | `JobCosting_Index_Phone` | `` | placeholder `write...` |
| combo |  | `JobCosting_Index_AddressLine1` | `vCustomerAddressStore` | shows `Line1` · value `Line1` · placeholder `Choose or type new...` |
| text field |  | `JobCosting_Index_AddressLine2` | `` | placeholder `Choose...` |
| combo |  | `JobCosting_Index_ProjectManager` | `vTenantContactsStore` | shows `Name` · value `Name` · placeholder `Choose or type new...` |
| combo |  | `JobCosting_Index_Account` | `vChartOfAccountsStore` | shows `DisplayName` · value `Code` |
| date field |  | `JobCosting_Index_Start` | `` | placeholder `Choose...` · format `UserDateFormat` |
| date field |  | `JobCosting_Index_Completed` | `` | placeholder `Choose...` · format `UserDateFormat` |
| checkbox |  | `JobCosting_Index_AutoInvoice` | `` |  |
| date field |  | `JobCosting_Index_NextInvoiceDate` | `` | placeholder `Choose...` · format `UserDateFormat` |
| combo |  | `JobCosting_Index_Frequency` | `FrequencyStore` | shows `Name` · value `Value` · pick-only |
| combo |  | `JobCosting_Index_Status` | `JobCostingStatusStore` | shows `Name` · value `Value` · pick-only |
| numeric field |  | `JobCosting_Index_EstimatedValue` | `` |  |
| numeric field |  | `JobCosting_Index_BudgetedMargin` | `` |  |
| combo |  | `JobCosting_Index_TaxRule` | `vTenantTaxationRuleStore` | shows `Description` · value `RuleID` · placeholder `Choose...` |
| combo |  | `JobCosting_Index_AttributeSet` | `AttributeSetStore` | shows `Name` · value `SetID` · pick-only |
| text field |  | `JobCosting_Index_NoteCategory` | `` |  |
| date field |  | `JobCosting_Index_NoteDate` | `` | placeholder `Choose...` · format `UserDateFormat` |
| combo |  | `JobCosting_Index_InvoicingMilestone` | `InvoicingMilestoneStore` | shows `Name` · value `ID` · placeholder `Select the milestone you would like to …` |
| numeric field |  | `JobCosting_Index_Rate` | `` | placeholder `Specify the exchange rate between your …` |
| combo |  | `JobCosting_Index_LinkingMilestone` | `InvoicingMilestoneStore` | shows `Name` · value `ID` · placeholder `Select the milestone you would like to …` |
| combo |  | `JobCosting_Index_LinkingSale` | `vJobCostingLinkingSaleStore` | shows `SaleOrderNumber` · value `TaskID` · placeholder `Choose a sale invoice...` |
| combo |  | `tdJobCosting_Print_Milestone` | `vJobCostingMilestonePrintStore` | shows `Name` · value `ID` · pick-only |
| text field |  | `renderTo` | `` |  |
| checkbox |  | `renderTo` | `` |  |
| numeric field |  | `renderTo` | `` |  |
| date field |  | `renderTo` | `` | placeholder `Choose...` · format `UserDateFormat` |

#### Menus, buttons and other parts

- **component** · id `cmpId` · renders into `renderTo` · store `localStore` · shows `name` · value `value` · placeholder `Choose...` · pick-only
- **column** “{attrSet.name}” · field `"CustomField".concat(…)`

### `JobCostingList2019`

2 grids · 0 standalone fields · 0 windows · 0 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `JobsContainer` · store `mainStore` · placeholder `You do not have any jobs at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    |  | `` |  | flex 1 | renderer() | hidden |
    | Job # | `JobNumber` |  | flex 1 | RenderHTMLText |  |
    | Name | `Name` |  | flex 1 | RenderHTMLText |  |
    | Start date | `StartDate` |  | flex 1 | renderer() |  |
    | Customer | `CustomerName` |  | flex 1 | RenderHTMLText |  |
    | Account | `AccountCode` |  | flex 1 | Common_COA_TreeMode_RestoreDisplayName |  |
    | Status | `Status` |  | flex 1 | renderer() |  |

- **grid** · renders into `InvoicesContainer` · store `invoicesStore` · placeholder `You do not have any draft sale invoices associated with jobs.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    |  | `` |  | flex 1 | renderer() | hidden |
    | Job # | `JobNumber` |  | flex 1 | renderer() |  |
    | Job name | `JobName` |  | flex 2 | renderer() |  |
    | Milestone | `Milestone` |  | flex 2 | RenderHTMLText |  |
    | SO # | `SaleOrderNumber` |  | flex 1 | renderer() |  |
    | Invoice # | `InvoiceNumber` |  | flex 1 | renderer() |  |
    | Date | `SaleOrderDate` |  | flex 1 | renderer() |  |
    | Amount | `Amount` |  | flex 1 | renderer() |  |


### `ProductionCalendar`

3 grids · 3 standalone fields · 0 windows · 0 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `divHolidaysGrid` · placeholder `You do not have any holidays yet.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Date | `Date` | date column | flex 1 | edit: date field |  |
    | Description | `Comment` |  | flex 1 | renderer() |  |

- **grid** · renders into `divSpecialsGrid` · placeholder `You do not have any custom working days yet.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Date | `Date` | date column | 100 | edit: date field |  |
    | Start | `StartTime` |  | 130 | renderer() |  |
    | End | `EndTime` |  | 130 | renderer() |  |
    | Break start | `BreakStartTime` |  | flex 1 | renderer() |  |
    | Break end | `BreakEndTime` | date column | flex 1 | renderer() |  |

- **grid** · renders into `divDaysGrid` · placeholder `You do not have any working days yet.` · layout column
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Day | `DayOfWeek` |  | flex 1 | renderer() | pick-only |
    | Start | `StartTime` |  | flex 1 | renderer() |  |
    | End | `EndTime` |  | flex 1 | renderer() |  |
    | Break start | `BreakStartTime` |  | flex 1 | renderer() |  |
    | Break end | `BreakEndTime` | date column | flex 1 | renderer() |  |
    |  | `` |  | 57 | renderer() |  |


#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| date field |  | `cmbReleaseOrderDate` | `` | format `UserDateFormat` |
| combo |  | `weekStartCmb` | `WeekDaysStore` | shows `name` · value `value` |
| multi-select combo |  | `weekEndsCmb` | `WeekDaysStore` | shows `name` · value `value` |

### `ProductionOrder`

23 grids · 29 standalone fields · 0 windows · 19 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `divRealDimensions` · store `window.AccountingDimensionsRealTempStore` · placeholder `emptyMsgText`
- **grid** · renders into `divProductionOrderSplitGrid` · store `ProductionOrderSplitStore`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Production order | `Number` |  | flex 1 | renderer() |  |
    | Quantity to produce | `Quantity` |  | flex 1 | renderer() |  |
    | Remaining quantity | `RemainingQuantity` |  | flex 1 | renderer() |  |

- **grid** · renders into `divScanProductSelection` · store `storeScanProduct`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `ProductCode` |  | flex 2 | renderer() |  |
    | Bin | `BinName` |  | flex 1 | renderer() |  |
    | Batch/serial # | `BatchSN` |  | flex 1 | renderer() |  |
    | Expiry date | `ExpiryDate` |  | flex 1 | renderer() |  |

- **grid** · renders into `divTDetails` · store `TransactionsStore` · placeholder `No transactions created.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Effective date | `EffectiveDate` |  | flex 1 | renderer() |  |
    | Debit | `Debit` |  | flex 1 | Common_COA_TreeMode_RestoreDisplayName |  |
    | Credit | `Credit` |  | flex 1 | Common_COA_TreeMode_RestoreDisplayName |  |
    | Amount | `Amount` |  | 130 | renderer() |  |

- **grid** · renders into `divRelatedOrdersDetails` · store `RelatedOrdersStore` · placeholder `No related orders created.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Order | `Number` |  | flex 1 | renderer() |  |
    | Type | `TaskTypeName` |  | flex 1 | RenderHTMLText |  |
    | Parent production order | `ParentProductionOrderNumber` |  | flex 1 | renderer() |  |
    | Order date | `OrderDate` |  | flex 1 | renderer() |  |
    | Status | `Status` |  | flex 1 | renderer() |  |
    | Total | `TotalAmount` |  | 130 | renderer() |  |

- **grid** · renders into `divDeliveryToDetails` · store `vProductionOrderDeliveryToStore` · placeholder `No finished products.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `ProductName` |  | flex 1 | renderer() |  |
    | Unit | `ProductUnit` |  | flex 1 | RenderHTMLText |  |
    | Sale | `SaleTaskID` |  | flex 1 | renderer() |  |
    | Delivery to | `LocationID` |  | flex 1 | renderer() |  |

- **grid** · renders into `divAttachmentList` · store `AttachmentsStore` · placeholder `You do not have any files attached.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Name | `FileName` |  | flex 2 | renderer() |  |
    | Date | `Date` |  | flex 1 | renderer() |  |
    | Attached by | `UserName` |  | flex 2 |  |  |

- **grid** · renders into `divCreateRunsGrid` · store `ProductionRunCreateStore`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Production run # | `Number` |  | flex 1 | renderer() |  |
    | Quantity to produce | `Quantity` |  | flex 1 | renderer() |  |
    | Remaining quantity | `RemainingQuantity` |  | flex 1 | renderer() |  |

- **grid** · renders into `divProductionRunPrintOperationsGrid` · store `ProductionRunOperationsPrintSelectStore`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Name | `Name` |  | flex 1 | renderer() | pick-only |

- **grid** · renders into `runComponentGrid` · store `RunProductItemsStore` · placeholder `No components selected.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Type | `ItemType` |  | flex 1 | renderer() |  |
    | Component | `ProductSku` |  | flex 2 | renderer() |  |
    | Location | `LocationName` |  | flex 1 | renderer() |  |
    | Batch no. | `BatchSN` |  | flex 1 | renderer() |  |
    | Backflush | `IsBackflush` | check column | 100 | renderer() | hidden |
    | Required/expected quantity | `PlannedQuantity` |  | 100 | renderer() |  |
    | Actual quantity | `ActualQuantity` |  | 100 | renderer() |  |
    | Wastage quantity | `WastageQuantity` |  | 100 | renderer() |  |
    | Total quantity | `Quantity` |  | 100 | renderer() |  |
    | Unit | `Unit` |  | 80 | RenderHTMLText |  |
    | Cost per unit | `UnitCost` |  | 80 | renderer() |  |
    | Cost | `TotalCost` |  | 80 | renderer() |  |
    | Reserved | `IsReserved` | check column | 80 | renderer() |  |

- **grid** · renders into `runResourceGrid` · placeholder `No resources selected.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Resource | `ResourceCode` |  | flex 1 | renderer() |  |
    | Quantity | `Quantity` |  | flex 1 |  |  |
    | Availability | `Available` |  | flex 1 | renderer() |  |
    | Cost | `TotalCost` |  | flex 1 | renderer() |  |

- **grid** · renders into `runCostGrid` · placeholder `No costs selected.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Labor and overheads | `ProductName` |  | flex 1 | RenderHTMLText |  |
    | Resource | `ResourceID` |  | flex 1 | renderer() |  |
    | Expense account | `ExpenseAccount` |  | flex 1 | renderer() |  |
    | Cost | `Cost` |  | flex 1 | renderer() |  |

- **grid** · renders into `runMasterGrid`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Sequence | `Order` |  | 100 | renderer() |  |
    | Type | `OperationType` |  | 120 | renderer() |  |
    | Operation | `Name` |  | flex 3 | renderer() |  |
    | Backflush | `IsBackflush` | check column | 100 | renderer() | hidden |
    | Planned time | `PlannedTimeString` |  | 100 |  |  |
    | Actual time | `ActualTimeString` |  | 100 |  |  |
    | Work center | `WorkCenterCode` |  | flex 1 | renderer() |  |

- **grid** · renders into `runNotesGrid` · placeholder `You do not have notes or attachments in this operation.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Notes & attachments | `Type` |  | 150 | renderer() |  |
    |  | `Value` |  | flex 2 | renderer() |  |

- **grid** · renders into `divManualJournalsLines` · placeholder `You do not have any manual journals.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Debit | `Debit` |  | flex 1 | renderer() |  |
    | Credit | `Credit` |  | flex 1 | renderer() |  |
    | Reference | `Reference` |  | flex 1 | RenderHTMLText |  |
    | Operation | `OperationID` |  | flex 1 | renderer() |  |
    | Date | `Date` | date column | flex 1 | edit: date field |  |
    | Amount | `Amount` |  | flex 1 | renderer() |  |

- **grid** · renders into `divRunTDetails` · store `RunTransactionsStore` · placeholder `No transactions created.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Effective date | `EffectiveDate` |  | flex 1 | renderer() |  |
    | Debit | `Debit` |  | flex 1 | Common_COA_TreeMode_RestoreDisplayName |  |
    | Credit | `Credit` |  | flex 1 | Common_COA_TreeMode_RestoreDisplayName |  |
    | Amount | `Amount` |  | 130 | renderer() |  |

- **grid** · renders into `divRunReservationDetails` · store `ReservedComponentsStore` · placeholder `No reserved components.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Component | `ProductName` |  | flex 1 | RenderHTMLText |  |
    | Operation | `OperationName` |  | flex 1 | RenderHTMLText |  |
    | Location | `LocationName` |  | flex 1 | RenderHTMLText |  |
    | Batch S/N | `BatchSN` |  | flex 1 | RenderHTMLText |  |
    | Expiry date | `ExpiryDate` |  | flex 1 | renderer() |  |
    | Available | `Available` |  | 130 | renderer() |  |
    | On order | `OnOrder` |  | 130 | renderer() |  |
    | Reserved | `Reserved` |  | 130 | renderer() |  |

- **grid** · renders into `divPutAwayGrid` · store `RunOutputStore` · placeholder `You do not have any output lines in the production run.`
- **grid** · renders into `divCoManReceivingGrid` · store `RunCoManReceivingStore` · placeholder `You do not have any stock receiving lines.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Source | `TaskID` |  | 100 | renderer() |  |
    | Product | `ProductCode` |  | flex 2 | renderer() |  |
    | Batch / serial # | `BatchSN` |  | flex 1 | renderer() |  |
    | Expiry date | `ExpiryDate` | date column | flex 1 |  |  |
    | Quantity | `Quantity` |  | flex 1 | renderer() |  |
    | Unit | `Unit` |  | flex 1 | renderer() |  |
    | Received date | `ReceivedDate` | date column | 100 | renderer() |  |
    | Location | `LocationName` |  | flex 1 | renderer() |  |
    | Cost per unit | `Cost` |  | flex 1 | renderer() |  |
    | Cost | `Cost` |  | flex 1 | renderer() |  |

- **grid** · renders into `traceabilityFP` · store `TraceabilityFPStore` · placeholder `No finished products have been added yet.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `ProductID` |  | flex 2 | renderer() |  |
    | Batch/serial # | `BatchSN` |  | flex 2 | renderer() |  |
    | Expiry date | `ExpiryDate` |  | flex 1 | renderer() |  |

- **grid** · renders into `"traceabilityGridComponents".concat(…)` · store `TraceabilityComponentsByProductStore` · placeholder `No components have been reserved or consumed yet.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Component | `UsedProductID` |  | flex 1 | renderer() |  |
    | Batch/serial # | `UsedFullBatchSN` |  | flex 1 | renderer() |  |
    | Expiry date | `UsedProductExpiryDate` |  | flex 1 | renderer() |  |

- **grid** · renders into `divYieldPopupGrid` · store `ProductionRunYieldStore` · placeholder `You do not have any component lines.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Type | `ItemType` |  | 120 | renderer() |  |
    | Product | `ProductSku` |  | flex 2 | renderer() |  |
    | Batch / serial # | `BatchSN` |  | flex 1 | renderer() |  |
    | Expiry date | `ExpiryDate` | date column | flex 1 | renderer() · edit: date field |  |
    | Actually produced | `Quantity` |  | flex 1 | renderer() |  |
    | Wastage | `WastageQuantity` |  | flex 1 | renderer() |  |
    | Total produced | `Quantity` |  | flex 1 | renderer() |  |
    | Unit | `Unit` |  | flex 1 | renderer() |  |
    | Received date | `ReceivedDate` | date column | flex 1 | renderer() · edit: date field |  |
    | Location | `LocationName` |  | flex 1 | renderer() |  |
    |  | `` |  | flex 1 | renderer() |  |
    |  | `` |  | flex 1 | renderer() |  |

- **grid** · renders into `UploadYieldLinesExceptionsGrid` · store `YieldLinesUploadErrorsStore` · placeholder `Please upload a file to check for issues.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Line # | `Line` |  | 60 |  |  |
    | Product SKU | `SKU` |  | 150 | renderer() |  |
    | Product name | `Name` |  | 250 | renderer() |  |
    | Batch/serial # | `BatchSerialNumber` |  | 120 | renderer() |  |
    | Expiry date | `ExpiryDate_YYYYMMDD` |  | 100 | renderer() |  |
    | Quantity | `Quantity` |  | 100 | renderer() |  |
    | Location | `Location` |  | 100 | renderer() |  |
    | Date received | `DateReceived_YYYYMMDD` |  | 100 | renderer() |  |


#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| text field |  | `renderTo` | `` |  |
| checkbox |  | `renderTo` | `` |  |
| numeric field |  | `renderTo` | `` |  |
| date field |  | `renderTo` | `` | placeholder `Choose...` · format `UserDateFormat` |
| date field |  | `WorkflowModal_dtWorkflowDate` | `` | format `UserDateFormat` |
| date field |  | `cmbReleaseOrderDate` | `` | format `UserDateFormat` |
| combo |  | `cmbLocation` | `vTenantLocationsStore` | shows `Description` · value `LocationID` |
| combo |  | `cmbAccount` | `FinishedGoodsAccountStore` | shows `DisplayName` · value `Code` |
| combo |  | `cmbWIPAccount` | `WipAccountStore` | shows `DisplayName` · value `Code` |
| date field |  | `cmbStartDate` | `` | format `UserDateFormat` |
| date field |  | `cmbCompletionDate` | `` | format `UserDateFormat` |
| date field |  | `cmbRequiredByDate` | `` | format `UserDateFormat` |
| combo |  | `cmbCalcType` | `CapacityCalculationsStore` | shows `name` · value `value` |
| date field |  | `cmbReleaseDate` | `` | format `UserDateFormat` |
| text field |  | `tdScanPackBox` | `` | placeholder `Choose...` |
| text field |  | `tdScanPackBoxInventory` | `` | placeholder `Choose...` |
| combo |  | `cmbBomVersion` | `vProductionBomVersions` | shows `DisplayName` · value `Version` |
| combo |  | `cmbRunWipAccount` | `WipAccountStore` | shows `DisplayName` · value `Code` |
| date field |  | `cmbRunStartDate` | `` | format `UserDateFormat` |
| date field |  | `cmbRunScheduledStartDate` | `` | format `UserDateFormat` |
| date field |  | `cmbRunDueDate` | `` | format `UserDateFormat` |
| date field |  | `cmbRunCompletionDate` | `` | format `UserDateFormat` |
| combo |  | `cmb_BackflushDefinedFor` | `BackflushDefinedForStore` | shows `name` · value `value` · pick-only |
| date field |  | `cmbOperationStartDate` | `` | format `UserDateFormat` |
| date field |  | `cmbOperationCompletionDate` | `` | format `UserDateFormat` |
| combo |  | `cmbOperationSuspendReason` | `vSuspendReasonsStoreFiltered` | shows `Reason` · value `Reason` |
| date field |  | `cmbRunReceivedDate` | `` | format `UserDateFormat` |
| date field |  | `divPutAwayScanFPExpiryDate` | `` | format `UserDateFormat` |
| combo |  | `divPutAwayScanFP` | `YieldProductsScanStore` | shows `ProductName` · value `ProductID` |

#### Menus, buttons and other parts

- **component** · id `cmpId` · renders into `renderTo` · store `localStore` · shows `name` · value `value` · placeholder `Choose...` · pick-only
- **column** “{attrSet.name}” · field `"CustomField".concat(…)`
- **column** “Entity” · field `EntityType` · id `colRealDimensionsEntity`
- **column** “Account” · field `AccountCode` · id `colRealDimensionsAccount`
- **column** “Amount” · field `Amount` · id `colRealDimensionsAmount`
- **column** “Reference number” · field `ReferenceNumber` · id `colRealDimensionsReferenceNumber`
- **column** “Effective date” · field `EffectiveDate` · id `colRealDimensionsDate`
- **column** “Product” · field `ProductCode` · id `colRealDimensionsProduct`
- **column** “Supplier \| Customer” · field `"".concat(…)` · id `"colRealDimensions".concat(…)`
- **column** “{attr}” · field `attr.replace(…)` · id `"col".concat(…)`
- **component** · renders into `cmbProduct` · store `ProductsStore` · shows `ProductCode` · value `ProductID`
- **component** · renders into `cmbProductName` · store `ProductsStore` · shows `Name` · value `ProductID`
- **component** · renders into `txtQuantity` · required
- **component** · renders into `tdScanQuantity` · required
- **text area** · renders into `divInventoryModeBarcodes` · placeholder `Enter your barcodes here...`
- **component**
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    |  | `CustomerName` |  |  |  | hidden |
    | Resource | `ProductionResource` |  | flex 1 |  |  |

- **column**
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Type | `Type` |  | flex 1 | renderer() |  |
    | Component | `Value` |  | flex 2 | renderer() |  |
    |  | `CostCalculationType` |  | 150 | renderer() |  |
    | Quantity | `TotalQuantity` |  | 80 | renderer() |  |
    | Unit | `Unit` |  | 80 | renderer() |  |
    | Wastage % | `WastagePercent` |  | 90 | renderer() |  |
    | Wastage qty | `TotalWastageQty` |  | 100 | renderer() |  |
    | Availability | `Available` |  | 100 | renderer() |  |
    | Sales price | `SalePriceTier` |  | 120 | renderer() |  |
    | Cost per unit | `Cost` |  | 110 | renderer() |  |
    | Total cost | `TotalCost` |  | 90 | renderer() |  |

- **column**
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Sequence | `Order` |  | flex 1 | renderer() |  |
    | Previous step | `OperationRelationIDsFake` |  | flex 1 | renderer() |  |
    | Type | `OperationType` |  | flex 1 | renderer() |  |
    | Operation | `Name` |  | flex 1 | renderer() |  |
    | Cycle time | `CycleTimeString` |  | flex 1 |  |  |
    | Work center | `WorkCenterID` |  | flex 1 | renderer() |  |
    | Units per cycle time | `UnitsPerCycle` |  | flex 1 | renderer() |  |
    | Number of cycles | `ProductionOrderID` |  | flex 1 | renderer() |  |
    | Total cost | `TotalCost` |  | flex 1 | renderer() |  |

- **component** · renders into `txtRunQuantity` · required

### `ProductionOrdersList`

2 grids · 7 standalone fields · 0 windows · 0 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `listContainer` · store `mainStore` · placeholder `You do not have any production orders at the moment.`
- **grid** · renders into `divSalesOrdersList`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Sales order | `SourceTaskID` |  | flex 1 | renderer() |  |


#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| date field |  | `cmbReleaseOrderDate` | `` | format `UserDateFormat` |
| combo |  | `cmbLocation` | `locationStore` | shows `Description` · value `LocationID` · placeholder `Choose...` · pick-only · multi-select |
| date field |  | `DateFrom` | `` | placeholder `Choose...` · format `UserDateFormat` |
| date field |  | `DateTo` | `` | placeholder `Choose...` · format `UserDateFormat` |
| combo |  | `cmbPlanOrderCalcType` | `CapacityCalculationsStore` | shows `name` · value `value` |
| date field |  | `cmbPlanOrderDate` | `` | format `UserDateFormat` |
| date field |  | `ConsolidateOrders_RequiredByDate` | `` | format `UserDateFormat` |

### `ProductionResource`

7 grids · 3 standalone fields · 0 windows · 0 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `divAttachmentList` · store `AttachmentsStore` · placeholder `You do not have any files attached.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Name | `FileName` |  | 200 | renderer() |  |
    | Date | `Date` |  | flex 1 | renderer() |  |
    | Attached by | `UserName` |  | flex 2 |  |  |
    |  | `` | action column | 23 |  |  |

- **grid** · renders into `capacityGridContainer` · placeholder `You do not have any shop floor locations yet.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Shop floor | `LocationID` |  | flex 1 | renderer() | total custom |
    | Custom operational hours | `HasCapacityHours` |  | flex 1 | renderer() |  |
    | Number of individual resources | `ResourceQuantity` |  | flex 1 | renderer() | total sum |
    | Capacity per week (hours) | `CapacityHoursWeek` |  | flex 1 | renderer() | total sum |

- **grid** · renders into `divDaysGrid` · placeholder `You do not have any working days yet.` · layout column
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Day | `DayOfWeek` |  | flex 1 | renderer() | pick-only |
    | Start | `StartTime` |  | flex 1 | renderer() |  |
    | End | `EndTime` |  | flex 1 | renderer() |  |
    | Break start | `BreakStartTime` |  | flex 1 | renderer() |  |
    | Break end | `BreakEndTime` | date column | flex 1 | renderer() |  |
    |  | `` |  | 57 | renderer() |  |

- **grid** · renders into `unitsGridContainer` · placeholder `You do not have any individual resources in shop floor.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Name | `Name` |  | flex 1 |  |  |
    | Operational from | `OperationalFrom` | date column | flex 1 | edit: date field |  |
    | Operational to | `OperationalTo` | date column | flex 1 | edit: date field |  |
    | Non-operational from | `NonOperationalFrom` | date column | flex 1 | edit: date field |  |
    | Non-operational to | `NonOperationalTo` | date column | flex 1 | edit: date field |  |

- **grid** · renders into `costsGridContainer` · placeholder `You do not have any costs in resource.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    |  | `ProductName` |  | flex 2 |  |  |
    | Account | `AccountCode` |  | flex 1 | renderer() |  |
    | Production | `PriceTier` |  | flex 1 | renderer() |  |
    | Amount | `Cost` |  | flex 1 | renderer() | total sum |
    | Planned downtime | `PlannedDowntimePriceTier` |  | flex 1 | renderer() |  |
    | Amount | `PlannedDowntimeCost` |  | flex 1 | renderer() | total sum |
    | Not planned downtime | `NotPlannedDowntimePriceTier` |  | flex 1 | renderer() |  |
    | Amount | `NotPlannedDowntimeCost` |  | flex 1 | renderer() | total sum |

- **grid** · renders into `divReferences` · store `ReferencesStore` · placeholder `Resource is not used in any production BOM.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    |  | `ImageID` |  | 60 | renderer() |  |
    | Product | `ProductCode` |  | flex 1 | renderer() |  |

- **grid** · renders into `remarksGrid` · placeholder `You do not have any remarks yet.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Remark | `Remark` |  | flex 3 |  |  |
    | Attached by | `CreatedBy` |  | flex 1 |  |  |
    | Date | `CreatedDate` |  | flex 1 | renderer() |  |


#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| date field |  | `cmbReleaseOrderDate` | `` | format `UserDateFormat` |
| combo |  | `cmbOperational` | `StatusStore` | shows `name` · value `value` |
| combo |  | `cmbType` | `TypesStore` | shows `name` · value `value` |

### `ProductionSetup`

3 grids · 1 standalone fields · 0 windows · 3 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `wcGridContainer` · store `workCenterListStore` · placeholder `You do not have any work centers yet. To set up bin for every work ce…`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    |  | `` |  | flex 1 | renderer() | hidden |
    | Code | `Code` |  | flex 1 |  |  |
    | Purchase co-man | `IsCoManPurchase` | check column | 100 | renderer() |  |
    | Co-man | `IsCoMan` | check column | 90 | renderer() |  |
    | Name | `NameFake` |  | flex 1 | renderer() |  |
    | Color code | `ColorCode` |  | flex 1 | renderer() |  |
    | Mode | `CoManProcurementType` |  | flex 1 | renderer() |  |
    |  | `InLocationIDsFake` |  | flex 1 | renderer() |  |
    | {"".concat('Output bin'+'<span class="prod-tooltip-icon" da… | `OutLocationIDsFake` |  | flex 1 | renderer() |  |
    | State | `IsActive` |  | 120 | renderer() |  |

- **grid** · renders into `resGridContainer` · store `resourcesStore` · placeholder `You do not have any resources yet.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    |  | `` |  | flex 1 | renderer() | hidden |
    | Code | `Code` |  | flex 1 |  |  |
    | Name | `Name` |  | flex 1 |  |  |
    | State | `IsActive` |  | flex 1 | renderer() |  |

- **grid** · renders into `SuspendReasonGridContainer` · store `vSuspendReasonsLocalStore` · placeholder `You do not have any suspend reasons at the moment.`
  - *columns:*
    - *(component built elsewhere: `addColumns`)*

#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| date field |  | `cmbReleaseOrderDate` | `` | format `UserDateFormat` |

#### Menus, buttons and other parts

- **check column** “{"".concat(item.Code,": ").concat(…)}” · field `item.WorkCenterID` · id `"colSuspendReasonGrid_".concat(…)`
- **column** “Reason” · field `Reason` · id `colSuspendReasonId`
- **column** “Downtime type” · field `DowntimeType` · id `colDowntimeType`

### `Scheduler`

0 grids · 8 standalone fields · 0 windows · 3 menus, buttons and other parts · 0 custom components

#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| date field |  | `cmbReleaseOrderDate` | `` | format `UserDateFormat` |
| date field |  | `cmbPlanFrom` | `` | placeholder `Choose...` · format `UserDateFormat` |
| date field |  | `newStartDate` | `` | placeholder `Choose...` · format `UserDateFormat` |
| date field |  | `cmbPlanTo` | `` | placeholder `Choose...` · format `UserDateFormat` |
| combo |  | `cmbShopFloor` | `shopFloorsStore` | shows `Description` · value `LocationID` |
| combo |  | `btnResourceSetup` | `resourcesStoreForFilter` | shows `Name` · value `ResourceID` · placeholder `Choose...` · multi-select |
| combo |  | `btnWorkCenterSetup` | `workCentersStore` | shows `Name` · value `WorkCenterID` · placeholder `Choose...` · multi-select |
| date field |  | `ConsolidateOrders_RequiredByDate` | `` | format `UserDateFormat` |

#### Menus, buttons and other parts

- **component**
  - *columns:*
    - **component** · name `text`
    - **component** · name `start_date`
    - **component** · name `duration`
    - **component** · name `add`
- **component**
  - *columns:*
    - **component** · name `name`
    - **component** · name `capacity`
    - **component** · name `count`
- **EmbeddedCalendarPicker** · renders into `schedulerDayRange` · format `window.UserDateFormat`

