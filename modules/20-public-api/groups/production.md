# Public API: Production

From Cin7's API Blueprint: field tables (name, type, length, required, allowed values), each operation's query parameters, and request and response bodies as type outlines (`guid`, `string`, `number`, `boolean`, `date`, `null`; `[ … ]` = array of). Base `/ExternalApi/v2`; headers in [docs/PUBLIC-API.md](../../../docs/PUBLIC-API.md).

**Resources:** `/production/factoryCalendar?Year={Year}` · `/production/productionBOM` · `/production/productionBOM/` · `/production/order` · `/production/orderList` · `/production/order/run` · `/production/resourceList?Page={Page}&Limit={Limit}&Name={Name}&OnlyActive={OnlyActive}` · `/production/resource?ResourceID={ResourceID}&IncludeAttachments={IncludeAttachments}` · `/production/suspendReason` · `/production/workcenters`

## Fields

#### FactoryCalendar

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `Year` | Short |  | Yes |  |
| `WeekStart` | String | 50 | Yes* |  |
| `FactoryCalendarDays` | Array |  | Yes* |  |
| `FactoryCalendarSpecialDays` | Array |  |  |  |

#### FactoryCalendarDay

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `DayOfWeek` | String |  | Yes |  |
| `IsWeekend` | Bool |  |  |  |
| `StartTime` | Short |  | Yes |  |
| `EndTime` | Short |  | Yes |  |
| `BreakStartTime` | Short |  |  |  |
| `BreakEndTime` | Short |  |  |  |
| `Capacity` | Int |  |  |  |

#### FactoryCalendarSpecialDay

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `Date` | DateTime |  | Yes |  |
| `IsWeekend` | Bool |  |  |  |
| `IsHoliday` | Bool |  |  |  |
| `StartTime` | Short |  |  |  |
| `EndTime` | Short |  |  |  |
| `BreakStartTime` | Short |  |  |  |
| `BreakEndTime` | Short |  |  |  |
| `Capacity` | Int |  |  |  |
| `Comment` | String | 512 |  |  |

#### Production BOM

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `BOMID` | Guid |  | Yes when … |  |
| `OutputQuantity` | Decimal |  | Yes |  |
| `BufferPercent` | Decimal |  | Yes |  |
| `InstructionUrl` | String |  |  |  |
| `IgnoreCumulativeLeadTime` | Bool |  |  |  |
| `ComponentProductionLeadTime` | Integer |  |  |  |
| `Version` | Integer |  | Yes |  |
| `Name` | String | 256 | Yes |  |
| `IsDefault` | Bool |  | Yes |  |
| `IsTracing` | Bool |  | No |  |
| `DeliveryToID` | Guid |  |  |  |
| `DeliveryToName` | String | 256 |  |  |
| `IssueMethod` | String |  |  |  |
| `Operations` | [] Operation Model |  |  |  |
| `IssueMethodComponent` | String |  |  |  |
| `IssueMethodParameter` | String |  |  |  |
| `MinQuantity` | Decimal |  | No |  |
| `MaxQuantity` | Decimal |  | No |  |
| `DeviationPercent` | Decimal |  | No |  |
| `RunSize` | Decimal |  | No |  |

#### Production BOM Operation Type

| Value | Meaning |
|---|---|

#### Production BOM Resource cost calculation type

| Value | Meaning |
|---|---|

#### Production BOM Operation

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `OperationID` | Guid |  | Yes when … |  |
| `Order` | Integer | Not zero | Yes |  |
| `Name` | String | 200 | Yes |  |
| `CycleTime` | Integer | Not zero | Yes |  |
| `UnitsPerCycle` | Decimal |  | Yes |  |
| `WorkCenterID` | Guid |  | Yes |  |
| `WorkCenterName` | String | 256 |  |  |
| `WorkCenterCoManProcurementType` | String |  |  |  |
| `OperationType` | String |  | Yes |  |
| `DeliveryToID` | Guid |  |  |  |
| `DeliveryToName` | String | 256 |  |  |
| `IssueMethod` | String |  |  |  |
| `IsDropShip` | Bool |  | Yes |  |
| `Resources` | [] Resource Model |  |  |  |
| `Components` | [] Component Model |  |  |  |
| `Attachments` | [] Attachment Model |  |  |  |
| `Notes` | [] Note Model |  |  |  |
| `OperationLinks` | [] Operation Link Model |  |  |  |
| `InputProducts` | [] Input Product Model |  |  |  |
| `OutputProducts` | [] Output Product Model |  |  |  |
| `FinishedProducts` | [] Finished Product Model |  |  |  |
| `IsBackflush` | Bool |  | No |  |

#### Production BOM Resource

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `BOMResourceID` | Guid |  | Yes when … |  |
| `ResourceID` | Guid |  | Yes |  |
| `ResourceName` | String |  |  |  |
| `ResourceCode` | String |  |  |  |
| `Quantity` | Decimal | Not zero | Yes |  |
| `Cost` | Decimal |  |  |  |
| `CycleTime` | Integer |  |  |  |
| `Position` | Integer |  | Yes |  |
| `CostCalculationType` | String |  | Yes |  |

#### Production BOM Component

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `BOMComponentID` | Guid |  | Yes when … |  |
| `ProductID` | Guid |  | Yes when … |  |
| `ProductSKU` | String |  | Yes when … |  |
| `ProductName` | String |  |  |  |
| `Quantity` | Decimal | Not zero | Yes |  |
| `WastageQty` | Decimal | Not zero | 0+ |  |
| `WastagePercent` | Decimal | 0 - 100 |  |  |
| `Cost` | Decimal |  |  |  |
| `CostingMethod` | String |  |  |  |
| `Unit` | String |  |  |  |
| `Position` | Integer |  | Yes |  |
| `SalePriceTier` | Integer | 1 - 10 |  |  |
| `IsBackflush` | Bool |  | No |  |

#### Production BOM Attachment

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `AttachmentID` | Guid |  | Yes when … |  |
| `FileName` | String | 256 |  |  |
| `Date` | DateTime |  |  |  |
| `ContentType` | String |  | Yes |  |
| `Content` | String |  | Yes |  |
| `Position` | Integer |  | Yes |  |

#### Production BOM Note

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `NoteID` | Guid |  | Yes when … |  |
| `Note` | String | 4000 |  |  |
| `Position` | Integer |  | Yes |  |

#### Production BOM Operation Link

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `ID` | Guid |  | Yes when … |  |
| `RelatedOperationID` | Guid |  | Yes when … |  |
| `RelatedOperationName` | String | 200 | Yes when … |  |
| `RelationType` | Integer | 0+ | Yes |  |

#### Production BOM InputProducts, OutputProducts, FinishedProducts

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `ID` | Guid |  | Yes when … |  |
| `ProductID` | Guid |  | Yes when … |  |
| `ProductSKU` | String |  | Yes when … |  |
| `ProductName` | String |  |  |  |
| `CostCalculationType` | String |  | Yes |  |
| `PriceTier` | Integer | 1 - 10 |  |  |
| `Ratio` | Decimal | 0 - 100 |  |  |
| `OutputQuantity` | Decimal | 0+ | Yes |  |
| `Position` | Integer |  | Yes |  |
| `CostingMethod` | String |  |  |  |
| `Unit` | String |  |  |  |
| `AverageCost` | Decimal |  |  |  |
| `WastageCost` | Integer |  |  |  |
| `DeliveryTo` | Guid |  |  |  |
| `DeliveryToName` | String | 256 |  |  |

#### Production BOM Variation Component

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `BOMVariationComponentID` | Guid |  | Yes when … |  |
| `ProductFamilyID` | Guid |  | Yes when … |  |
| `ProductFamilySKU` | String |  | Yes when … |  |
| `ProductFamilyName` | String |  |  |  |
| `QuantitySettingsJSON` | String |  | Yes |  |
| `MapVariationsJSON` | String |  | Yes |  |
| `QuantityOptionName` | String | 50 | Yes |  |
| `CostingMethod` | String |  |  |  |
| `Unit` | String |  |  |  |
| `Position` | Integer |  | Yes |  |
| `SalePriceTier` | Integer | 1 - 10 |  |  |

#### Production Order

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `ProductionOrderID` | Guid |  | Yes |  |
| `ProductID` | Guid |  | Yes |  |
| `ProductSKU` | String |  |  |  |
| `ProductName` | String |  |  |  |
| `OrderNumber` | String |  |  |  |
| `LocationID` | Guid |  | Yes |  |
| `LocationName` | String |  |  |  |
| `CostingMethod` | String |  |  |  |
| `WarehouseName` | String |  |  |  |
| `Unit` | String |  |  |  |
| `OrderStatus` | String |  |  |  |
| `Status` | String |  |  |  |
| `InstructionURL` | String |  |  |  |
| `SourceName` | String |  |  |  |
| `SourceTaskID` | Guid |  |  |  |
| `SourceTaskNumber` | String |  |  |  |
| `WIPAccountCode` | String |  |  |  |
| `FinishedGoodsAccountCode` | String |  |  |  |
| `Quantity` | Decimal |  |  |  |
| `BOMQuantity` | Decimal |  |  |  |
| `CapacityCalculationType` | String |  |  | `FromStartForward`, `FromRequiredBackward` |
| `StartDate` | DateTime |  |  |  |
| `ReleaseDate` | DateTime |  |  |  |
| `RequiredByDate` | DateTime |  |  |  |
| `CompletionDate` | DateTime |  |  |  |
| `IsIgnoreLeadTime` | Boolean |  |  |  |
| `WarehouseID` | Guid |  |  |  |
| `RetailID` | Guid |  |  |  |
| `Comments` | String | 2000 |  |  |
| `ScheduleStart` | DateTime |  |  |  |
| `PlannedBy` | String | 2000 |  |  |
| `ReleasedBy` | String | 2000 |  |  |
| `OrderCycleTime` | Integer |  |  |  |
| `BOMVersion` | Integer |  |  |  |
| `BOMName` | String |  |  |  |
| `Tags` | String |  |  |  |
| `CustomField1` | String |  |  |  |
| `CustomField2` | String |  |  |  |
| `CustomField3` | String |  |  |  |
| `CustomField4` | String |  |  |  |
| `CustomField5` | String |  |  |  |
| `CustomField6` | String |  |  |  |
| `CustomField7` | String |  |  |  |
| `CustomField8` | String |  |  |  |
| `CustomField9` | String |  |  |  |
| `CustomField10` | String |  |  |  |
| `ProductionOrderOperations` | ProductionOrderOperation[] |  |  |  |
| `ProductionRuns` | ProductionRun[] |  |  |  |
| `ProductionOrderDeliveryTo` | ProductionOrderDeliveryTo[] |  |  |  |
| `IssueMethodComponent` | String |  |  |  |
| `IssueMethodParameter` | String |  |  |  |
| `SourceTasks` | ProductionOrderSourceTask[] |  |  |  |
| `RunSize` | Decimal |  | No |  |

#### Production Order Operation

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `OperationID` | Guid |  | Yes* |  |
| `Order` | Integer | 1+ | Yes |  |
| `Name` | String | 200 | Yes |  |
| `CycleTime` | Integer | 0+ | Yes |  |
| `UnitsPerCycle` | Decimal | 0+ | Yes |  |
| `TotalCycleTime` | Integer | 1+ | Yes |  |
| `TotalUnitsPerCycle` | Decimal | 0+ |  |  |
| `OperationType` | String |  |  |  |
| `WorkCenterID` | Guid |  |  |  |
| `WorkCenterName` | String |  |  |  |
| `WorkCenterCode` | String |  |  |  |
| `WorkCenterCoManProcurementType` | String |  |  |  |
| `ComponentLocationID` | Guid |  |  |  |
| `IsDropShip` | Boolean |  |  |  |
| `Attachments` | [] Attachment Model |  |  |  |
| `Components` | [] Component Model |  |  |  |
| `Notes` | [] Note Model |  |  |  |
| `Resources` | [] Resource Model |  |  |  |
| `OperationLinks` | [] Link Model |  |  |  |
| `InputProducts` | [] OperationProduct Model |  |  |  |
| `OutputProducts` | [] OperationProduct Model |  |  |  |
| `FinishedProducts` | [] OperationProduct Model |  |  |  |
| `IsBackflush` | Bool |  |  |  |

#### Production Order Operation Attachment

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `AttachmentID` | Guid |  | Yes* |  |
| `FileName` | String | 256 |  |  |
| `Date` | DateTime |  |  |  |
| `ContentType` | String | 256 | Yes |  |
| `Position` | Integer |  | Yes |  |
| `Content` | String |  | Yes* |  |

#### Production Order Operation Component

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `OrderComponentID` | Guid |  | Yes* |  |
| `ProductID` | Guid |  | Yes* |  |
| `ProductSKU` | String |  | Yes* |  |
| `ProductName` | String |  |  |  |
| `Position` | Integer |  | Yes |  |
| `Available` | Decimal |  |  |  |
| `Quantity` | Decimal |  | Yes |  |
| `TotalQuantity` | Decimal | 0+ |  |  |
| `WastageQty` | Decimal | 0+ |  |  |
| `WastagePercent` | Decimal | 0+ |  |  |
| `Cost` | Decimal | 0+ |  |  |
| `TotalCost` | Decimal | 0+ |  |  |
| `ProductCost` | Decimal | 0+ |  |  |
| `CostingMethod` | String |  |  |  |
| `Unit` | String |  |  |  |
| `ProductType` | String |  |  |  |
| `SalePriceTier` | Integer |  |  |  |
| `IsBackflush` | Bool |  |  |  |

#### Production Order Operation Note

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `NoteID` | Guid |  | Yes* |  |
| `Note` | String | 4000 |  |  |
| `Position` | Integer |  | Yes |  |

#### Production Order Operation Resource

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `OrderResourceID` | Guid |  | Yes* |  |
| `ResourceID` | Guid |  | Yes* |  |
| `ResourceCode` | String |  | Yes* |  |
| `ResourceName` | String |  |  |  |
| `Position` | Integer |  | Yes |  |
| `Quantity` | Decimal | 0+ | Yes |  |
| `Cost` | Decimal |  |  |  |
| `TotalCost` | Decimal |  |  |  |
| `ResourceCost` | Decimal | 0+ |  |  |
| `CycleTime` | Integer |  |  |  |
| `CostCalculationType` | String |  | Yes |  |

#### Production Order Operation Link. This is a readonly entity.

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `ID` | Guid |  |  |  |
| `RelatedOperationID` | Guid |  |  |  |
| `Position` | Integer |  | Yes |  |

#### Production Order Operation Product. This is a readonly entity (only deletion is allowed).

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `ID` | Guid |  |  |  |
| `ProductID` | Guid |  |  |  |
| `ProductSKU` | String |  |  |  |
| `ProductName` | String |  |  |  |
| `Position` | Integer |  |  |  |
| `CostCalculationType` | String |  |  |  |
| `PriceTier` | Integer |  |  |  |
| `Ratio` | Decimal |  |  |  |
| `OutputQuantity` | Decimal |  |  |  |
| `TotalOutputQuantity` | Decimal |  |  |  |
| `Cost` | Decimal |  |  |  |
| `TotalCost` | Decimal |  |  |  |
| `AverageCost` | Decimal |  |  |  |
| `FixedCost` | Decimal |  |  |  |
| `CostingMethod` | String |  |  |  |
| `Unit` | String |  |  |  |
| `WastageCost` | Decimal |  |  |  |

#### Production Order Source Task

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `SourceTaskID` | Guid |  |  |  |
| `SourceTaskNumber` | String |  |  |  |

#### Production Order List Item

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `TaskID` | Guid |  |  |  |
| `ProductionOrderID` | Guid |  |  |  |
| `Type` | String |  |  | `O`, `R` |
| `ProductID` | Guid |  |  |  |
| `ProductSKU` | String |  |  |  |
| `ProductName` | String |  |  |  |
| `OrderNumber` | String |  |  |  |
| `LocationID` | Guid |  |  |  |
| `LocationName` | String |  |  |  |
| `Status` | String |  |  |  |
| `OrderStatus` | String |  |  |  |
| `Quantity` | Decimal |  |  |  |
| `StartDate` | DateTime |  |  |  |
| `ReleaseDate` | DateTime |  |  |  |
| `RequiredByDate` | DateTime |  |  |  |
| `CompletionDate` | DateTime |  |  |  |
| `Comments` | String | 2000 |  |  |
| `CapacityCalculationType` | String |  |  | `FromStartForward`, `FromRequiredBackward` |
| `WIPAccountCode` | String |  |  |  |
| `Tags` | String |  |  |  |
| `FinishedGoodsAccountCode` | String |  |  |  |
| `SourceTaskID` | Guid |  |  |  |
| `SourceTaskNumber` | String |  |  |  |
| `SourceTaskType` | Integer |  |  | `0`, `1` |
| `IsSourceTaskVoided` | Boolean |  |  |  |
| `CustomField1` | String |  |  |  |
| `CustomField2` | String |  |  |  |
| `CustomField3` | String |  |  |  |
| `CustomField4` | String |  |  |  |
| `CustomField5` | String |  |  |  |
| `CustomField6` | String |  |  |  |
| `CustomField7` | String |  |  |  |
| `CustomField8` | String |  |  |  |
| `CustomField9` | String |  |  |  |
| `CustomField10` | String |  |  |  |
| `SourceTasks` | ProductionOrderListSourceTask[] |  |  |  |

#### Production Order List Source Task

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `SourceTaskID` | Guid |  |  |  |
| `SourceTaskNumber` | String |  |  |  |
| `SourceTaskType` | Integer |  |  | `0`, `1` |
| `IsSourceTaskVoided` | Boolean |  |  |  |

#### Available Statuses for Production Run

| Value | Meaning |
|---|---|

#### Available Statuses for Production Run Operation

| Value | Meaning |
|---|---|

#### Production Run

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `RunID` | Guid |  |  |  |
| `Number` | Int |  |  |  |
| `Status` | String |  |  |  |
| `Quantity` | Decimal |  |  |  |
| `WIPAccount` | String | 50 |  |  |
| `StartDate` | DateTime |  |  |  |
| `EndDate` | DateTime |  |  |  |
| `DueDate` | DateTime |  |  |  |
| `ReceivedDate` | DateTime |  |  |  |
| `ScheduleStart` | DateTime |  |  |  |
| `ScheduleDue` | DateTime |  |  |  |
| `Operations` | Array items |  |  |  |
| `Output` | Array items |  |  |  |
| `PendingOutput` | Array items |  |  |  |
| `ManualJournals` | Array items |  |  |  |
| `Traceability` | Array items |  |  |  |
| `IssueMethodParameter` | String |  |  |  |
| `CustomField1` | String |  |  |  |
| `CustomField2` | String |  |  |  |
| `CustomField3` | String |  |  |  |
| `CustomField4` | String |  |  |  |
| `CustomField5` | String |  |  |  |
| `CustomField6` | String |  |  |  |
| `CustomField7` | String |  |  |  |
| `CustomField8` | String |  |  |  |
| `CustomField9` | String |  |  |  |
| `CustomField10` | String |  |  |  |

#### Production Run Operation

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `OperationID` | Guid |  | Yes |  |
| `Status` | String |  |  |  |
| `Order` | Int |  |  |  |
| `Name` | String | 512 |  |  |
| `PlannedTime` | Int |  |  |  |
| `ActualTime` | Int |  |  |  |
| `UnitsPerCycle` | Decimal |  |  |  |
| `StartDate` | DateTime |  |  |  |
| `EndDate` | DateTime |  |  |  |
| `DueDate` | DateTime |  |  |  |
| `OperationType` | String |  |  |  |
| `WorkCenterID` | Guid |  |  |  |
| `WorkCenterCode` | String |  |  |  |
| `WorkCenterName` | String |  |  |  |
| `SuspendReason` | String |  |  |  |
| `CoManStatus` | String |  |  |  |
| `Components` | Array items |  |  |  |
| `Resources` | Array items |  |  |  |
| `ResourceCosts` | Array items |  |  |  |
| `FinishedProducts` | Array items |  |  |  |
| `OutputProducts` | Array items |  |  |  |
| `InputProducts` | Array items |  |  |  |
| `CoManTasks` | Array items |  |  |  |
| `CoManTaskLines` | Array items |  |  |  |
| `Attachments` | Array items |  |  |  |
| `Notes` | Array items |  |  |  |
| `IsBackflush` | bool |  |  |  |
| `ManualStartDate` | Date |  |  |  |
| `ManualEndDate` | Date |  |  |  |
| `CustomField1` | String |  |  |  |
| `CustomField2` | String |  |  |  |
| `CustomField3` | String |  |  |  |
| `CustomField4` | String |  |  |  |
| `CustomField5` | String |  |  |  |
| `CustomField6` | String |  |  |  |
| `CustomField7` | String |  |  |  |
| `CustomField8` | String |  |  |  |
| `CustomField9` | String |  |  |  |
| `CustomField10` | String |  |  |  |

#### Production Run Operation Component

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `RunComponentID` | Guid |  |  |  |
| `ProductID` | Guid |  |  |  |
| `ProductCode` | String | 50 |  |  |
| `ProductName` | String |  |  |  |
| `Quantity` | Decimal |  |  |  |
| `ExpectedQuantity` | Decimal |  |  |  |
| `WastageQty` | Decimal |  |  |  |
| `WastagePercent` | Decimal |  |  |  |
| `BatchSN` | String | 50 |  |  |
| `ExpiryDate` | DateTime |  |  |  |
| `UnitCost` | Decimal |  |  |  |
| `LocationID` | Guid |  |  |  |
| `LocationName` | String |  |  |  |
| `ProductCost` | String |  |  |  |
| `Available` | Decimal |  |  |  |
| `CostingMethod` | String |  |  |  |
| `Unit` | String |  |  |  |
| `ReservedQuantity` | Decimal |  |  |  |
| `IsReserved` | Bool |  |  |  |
| `IsBackflush` | bool |  |  |  |

#### Production Run Operation Resource

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `RunResourceID` | Guid |  | Yes* |  |
| `ResourceID` | Guid |  |  |  |
| `ResourceCode` | Guid |  |  |  |
| `ResourceName` | String | 50 |  |  |
| `UnitCost` | Decimal |  |  |  |
| `Quantity` | Decimal |  |  |  |
| `Cost` | Decimal |  |  |  |
| `CycleTime` | Decimal |  |  |  |

#### Production Run Operation Resource Cost

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `RunCostID` | Guid |  | Yes |  |
| `ProductID` | Guid |  | Yes |  |
| `ProductName` | String |  |  |  |
| `AccountName` | String | 50 |  |  |
| `ExpenseAccount` | String | 50 |  |  |
| `Comments` | String |  | 256 |  |
| `Cost` | Decimal |  | Yes |  |

#### Production Run Operation Product

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `ProductID` | Guid |  |  |  |
| `ProductSKU` | String | 50 |  |  |
| `ProductName` | String |  |  |  |
| `Unit` | String |  |  |  |
| `OutputQuantity` | Decimal |  |  |  |
| `ExpectedQuantity` | Decimal |  |  |  |
| `WastageQuantity` | Decimal |  |  |  |
| `BatchSN` | String | 50 |  |  |
| `ExpiryDate` | DateTime |  |  |  |
| `LocationID` | Guid |  |  |  |
| `LocationName` | String |  |  |  |

#### Production Run Operation CoMan Task

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `TaskID` | Guid |  |  |  |
| `Type` | String |  |  |  |
| `TaskStatus` | String |  |  |  |
| `TaskNumber` | String |  |  |  |

#### Production Run Operation CoMan Line

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `TaskID` | Guid |  |  |  |
| `ProductID` | Guid |  |  |  |
| `ProductCode` | String | 50 |  |  |
| `ProductName` | String |  |  |  |
| `Unit` | String |  |  |  |
| `Quantity` | Decimal |  |  |  |
| `Cost` | Decimal |  |  |  |
| `BatchSN` | String | 50 |  |  |
| `ExpiryDate` | DateTime |  |  |  |
| `LocationID` | Guid |  |  |  |
| `LocationName` | String |  |  |  |
| `ReceivedDate` | DateTime |  |  |  |

#### Production Run Operation Attachment

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `AttachmentID` | Guid |  | Yes* |  |
| `FileName` | String | 256 |  |  |
| `Date` | DateTime |  |  |  |
| `ContentType` | String | 256 |  |  |
| `Position` | Integer |  | Yes |  |
| `Content` | String |  | Yes* |  |

#### Production Run Operation Note

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `NoteID` | Guid |  | Yes* |  |
| `Note` | String | 4000 |  |  |
| `Position` | Integer |  | Yes |  |

#### Production Run Pending Output

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `ProductID` | Guid |  |  |  |
| `ProductCode` | String | 50 |  |  |
| `ProductName` | String |  |  |  |
| `Unit` | String |  |  |  |
| `CostingMethod` | String |  |  |  |
| `BatchSN` | String | 50 |  |  |
| `ExpiryDate` | DateTime |  |  |  |

#### Production Run Pending Output

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `ProductID` | Guid |  |  |  |
| `ProductCode` | String | 50 |  |  |
| `ProductName` | String |  |  |  |
| `Unit` | String |  |  |  |
| `CostingMethod` | String |  |  |  |
| `BatchSN` | String | 50 |  |  |
| `ExpiryDate` | DateTime |  |  |  |
| `UnitCost` | Decimal |  |  |  |
| `Quantity` | Decimal |  | Yes |  |
| `WastageQuantity` | Decimal |  | Yes |  |
| `ReceivedDate` | DateTime |  | Yes |  |
| `Received` | Boolean |  | Yes |  |
| `LocationID` | Guid |  |  |  |
| `LocationName` | String |  |  |  |
| `CustomField1` | String |  |  |  |
| `CustomField2` | String |  |  |  |
| `CustomField3` | String |  |  |  |
| `CustomField4` | String |  |  |  |
| `CustomField5` | String |  |  |  |
| `CustomField6` | String |  |  |  |
| `CustomField7` | String |  |  |  |
| `CustomField8` | String |  |  |  |
| `CustomField9` | String |  |  |  |
| `CustomField10` | String |  |  |  |

#### Production Run Manual Journal

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `JournalID` | Guid |  | Yes* |  |
| `Reference` | String | 50 |  |  |
| `Amount` | Decimal | 50 | Yes |  |
| `Date` | DateTime |  | Yes |  |
| `Debit` | String | 50 | Yes |  |
| `Credit` | String | 50 | Yes |  |
| `OperationID` | Guid |  |  |  |
| `OperationName` | String |  |  |  |

#### Production Run Traceability

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `TraceabilityID` | Guid |  | Yes* |  |
| `ProducedProductID` | Guid |  | Yes |  |
| `ProducedProductBatchSN` | String | 50 | Yes |  |
| `ProducedProductExpiryDate` | DateTime |  | No |  |
| `UsedProductID` | Guid |  | Yes |  |
| `UsedProductBatchSN` | String | 50 | Yes |  |
| `UsedProductExpiryDate` | DateTime |  | No |  |

#### Available Resource Types

| Value | Meaning |
|---|---|

#### Available DayOfWeek values

| Value | Meaning |
|---|---|

#### Resource

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `ResourceID` | Guid |  | Yes* |  |
| `Code` | String | 50 | Yes* |  |
| `Name` | String | 512 | Yes* |  |
| `ResourceType` | String |  | Yes |  |
| `CycleDuration` | Int |  | Yes |  |
| `IsActive` | Bool |  |  |  |
| `IsInfinite` | Bool |  |  |  |
| `IsAllowAllCapacityUsage` | Bool |  |  |  |
| `IsAvailableOnHolidays` | Bool |  |  |  |
| `IsAvailableOnWeekends` | Bool |  |  |  |
| `Tags` | String | 2000 |  |  |
| `ResourceCapacities` | Array |  |  |  |
| `ResourceCosts` | Array |  |  |  |
| `ResourceRemarks` | Array |  |  |  |
| `ResourceAttachments` | Array |  |  |  |

#### ResourceCapacity

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `LocationID` | Guid |  | Yes |  |
| `LocationName` | String | 50 | Yes* |  |
| `ResourceQuantity` | Int |  |  |  |
| `NonOperationalFrom` | DateTime |  |  |  |
| `NonOperationalTo` | DateTime |  |  |  |
| `CustomWorkingDays` | Array |  |  |  |
| `ResourceUnits` | Array |  |  |  |

#### CustomWorkingDay

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `DayOfWeek` | String |  | Yes |  |
| `StartTime` | Short |  | Yes* |  |
| `EndTime` | Short |  | Yes* |  |
| `BreakStartTime` | Short |  |  |  |
| `BreakEndTime` | Short |  |  |  |
| `Capacity` | Int |  |  |  |

#### ResourceUnit

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `Name` | String | 256 | Yes |  |
| `NonOperationalFrom` | DateTime |  |  |  |
| `NonOperationalTo` | DateTime |  |  |  |
| `OperationalFrom` | DateTime |  |  |  |
| `OperationalTo` | DateTime |  |  |  |

#### ResourceCost

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `ResourceCostID` | Guid |  |  |  |
| `ProductID` | Guid |  | Yes |  |
| `AccountCode` | String | 50 | Yes |  |
| `Cost` | Decimal |  |  |  |
| `PriceTier` | Int |  | Yes |  |
| `PlannedDowntimeCost` | Decimal |  |  |  |
| `PlannedDowntimePriceTier` | Int |  |  |  |
| `NotPlannedDowntimeCost` | Decimal |  |  |  |
| `NotPlannedDowntimePriceTier` | Int |  |  |  |

#### ResourceRemark

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `RemarkID` | Guid |  |  |  |
| `Remark` | String | 1024 | Yes |  |
| `CreatedDate` | DateTime |  |  |  |

#### ResourceAttachment

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `AttachmentID` | Guid |  |  |  |
| `FileName` | String | 256 | Yes |  |
| `Date` | DateTime |  |  |  |
| `ContentType` | String | 256 |  |  |
| `Content` | String | 32 Mb | Yes |  |

#### SuspendReason

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `SuspendReasonID` | Guid |  | Yes* |  |
| `Reason` | String |  | Yes* |  |
| `Workcenters` | Guid Array |  |  |  |

#### WorkCenter

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `WorkCenterID` | Guid |  | Yes |  |
| `Code` | String | 256 | Yes |  |
| `Name` | String | 256 | Yes |  |
| `IsActive` | Boolean |  | Yes |  |
| `IsCoMan` | Boolean |  | Yes |  |
| `IsCoManPurchase` | Boolean |  | Yes |  |
| `SupplierID` | Guid |  | Yes* |  |
| `SupplierName` | String |  |  |  |
| `CoManProcurementType` | String | 10 | Yes* |  |
| `WorkCenterLocations` | [] WorkCenter Location Model |  |  |  |
| `WorkCenterSuppliers` | [] WorkCenter Supplier Model |  | Yes* |  |

#### WorkCenter Location

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `ID` | Guid |  | Yes |  |
| `LocationID` | Guid |  | Yes |  |
| `Type` | String | 256 | Yes |  |
| `ParentLocationID` | Guid |  |  |  |
| `LocationName` | String |  | Yes |  |

#### WorkCenter Supplier

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `SupplierID` | Guid |  | Yes* |  |
| `SupplierName` | String |  | Yes* |  |

## Operations

### GET `/production/factoryCalendar`

| Parameter | Type | Required |
|---|---|---|
| `Year` | Int | yes |

Response 200:

```text
Year: number
WeekStart: string
FactoryCalendarDays: [
  DayOfWeek: string
  IsWeekend: boolean
  StartTime: number
  EndTime: number
  BreakStartTime: null
  BreakEndTime: null
  Capacity: number
]
FactoryCalendarSpecialDays: [
  Date: date
  IsHoliday: boolean
  IsWeekend: boolean
  StartTime: number
  EndTime: number
  BreakStartTime: null
  BreakEndTime: null
  Comment: string
  Capacity: number
]
```

### POST `/production/factoryCalendar`

Request body:

```text
Year: number
WeekStart: string
FactoryCalendarDays: [
  DayOfWeek: string
  IsWeekend: boolean
  StartTime: number
  EndTime: number
  BreakStartTime: null
  BreakEndTime: null
  Capacity: number
]
FactoryCalendarSpecialDays: [
  Date: date
  IsHoliday: boolean
  IsWeekend: boolean
  StartTime: number
  EndTime: number
  BreakStartTime: null
  BreakEndTime: null
  Comment: string
  Capacity: number
]
```

Response 200:

```text
Year: number
WeekStart: string
FactoryCalendarDays: [
  DayOfWeek: string
  IsWeekend: boolean
  StartTime: number
  EndTime: number
  BreakStartTime: null
  BreakEndTime: null
  Capacity: number
]
FactoryCalendarSpecialDays: [
  Date: date
  IsHoliday: boolean
  IsWeekend: boolean
  StartTime: number
  EndTime: number
  BreakStartTime: null
  BreakEndTime: null
  Comment: string
  Capacity: number
]
```

### PUT `/production/factoryCalendar`

Request body:

```text
Year: number
WeekStart: string
FactoryCalendarDays: [
  DayOfWeek: string
  IsWeekend: boolean
  StartTime: number
  EndTime: number
  BreakStartTime: null
  BreakEndTime: null
  Capacity: number
]
FactoryCalendarSpecialDays: [
  Date: date
  IsHoliday: boolean
  IsWeekend: boolean
  StartTime: number
  EndTime: number
  BreakStartTime: null
  BreakEndTime: null
  Comment: string
  Capacity: number
]
```

Response 200:

```text
Year: number
WeekStart: string
FactoryCalendarDays: [
  DayOfWeek: string
  IsWeekend: boolean
  StartTime: number
  EndTime: number
  BreakStartTime: null
  BreakEndTime: null
  Capacity: number
]
FactoryCalendarSpecialDays: [
  Date: date
  IsHoliday: boolean
  IsWeekend: boolean
  StartTime: number
  EndTime: number
  BreakStartTime: null
  BreakEndTime: null
  Comment: string
  Capacity: number
]
```

### GET `/production/productionBOM`

| Parameter | Type | Required |
|---|---|---|
| `ProductID` | guid | yes |
| `ReturnAttachmentsContent` | bool |  |

Response 200:

```text
ProductID: guid
ProductionBOMs: [
  BOMID: guid
  OutputQuantity: number
  BufferPercent: number
  InstructionUrl: string
  IgnoreCumulativeLeadTime: boolean
  ComponentProductionLeadTime: number
  Version: number
  Name: string
  IsDefault: boolean
  CreatedDate: date
  DeliveryToID: null
  DeliveryToName: null
  IssueMethod: number
  IsTracing: boolean
  IssueMethodComponent: number
  IssueMethodParameter: number
  MinQuantity: number
  MaxQuantity: number
  DeviationPercent: number
  RunSize: number
  Operations: [
    OperationID: guid
    Order: number
    Name: string
    CycleTime: number
    UnitsPerCycle: number
    WorkCenterID: guid
    WorkCenterName: string
    WorkCenterCoManProcurementType: null
    OperationType: string
    IsDropShip: boolean
    IsBackflush: boolean
    Resources: [
      BOMResourceID: guid
      ResourceID: guid
      ResourceName: string
      ResourceCode: string
      Quantity: number
      Cost: number
      CycleTime: number
      Position: number
      CostCalculationType: string
    ]
    Components: [
      BOMComponentID: guid
      ProductID: guid
      ProductName: string
      ProductSKU: string
      Quantity: number
      WastageQty: number
      WastagePercent: number
      Cost: number
      CostingMethod: string
      Unit: string
      Position: number
      SalePriceTier: number
      IsBackflush: boolean
    ]
    Attachments: []
    Notes: [
      NoteID: guid
      Note: string
      Position: number
    ]
    OperationLinks: []
    InputProducts: []
    OutputProducts: [
      ID: guid
      ProductID: guid
      ProductFamilyID: null
      CostCalculationType: string
      PriceTier: number
      Ratio: number
      OutputQuantity: number
      ProductName: string
      ProductSKU: string
      AverageCost: number
      CostingMethod: string
      Unit: string
      Position: number
      WastageCost: number
      DeliveryTo: null
      DeliveryToName: null
    ]
    FinishedProducts: []
    VariationComponents: []
  ]
]
```

### POST `/production/productionBOM`

Request body:

```text
ProductID: guid
SetParentHasProductionBom: boolean
ProductionBOMs: [
  BOMID: string
  ProductID: string
  OutputQuantity: number
  BufferPercent: number
  InstructionUrl: string
  IssueMethod: number
  IgnoreCumulativeLeadTime: boolean
  ComponentProductionLeadTime: number
  Version: number
  Name: string
  IsDefault: boolean
  CreatedDate: date
  CreatedBy: string
  DeliveryTo: string
  IsTracing: boolean
  IssueMethodComponent: number
  IssueMethodParameter: number
  MinQuantity: number
  MaxQuantity: number
  DeviationPercent: number
  RunSize: number
  Operations: [
    OperationID: string
    Order: number
    Name: string
    CycleTime: number
    CycleTimeString: string
    UnitsPerCycle: number
    WorkCenterID: guid
    OperationType: number
    TotalCost: number
    IsDropShip: boolean
    IsBackflush: boolean
    Resources: [
      BOMResourceID: string
      ResourceID: guid
      ResourceName: string
      ResourceCode: string
      Quantity: number
      CycleTime: number
      Cost: number
      Position: number
      CostCalculationType: string
    ]
    Components: [
      BOMComponentID: string
      ProductID: guid
      ProductName: string
      ProductSKU: string
      Quantity: number
      WastageQty: number
      WastagePercent: number
      Cost: number
      CostingMethod: string
      Position: number
      Unit: string
      SalePriceTier: null
      IsBackflush: boolean
    ]
    Attachments: [
      FileName: string
      ContentType: string
      Position: number
      Content: string
    ]
    Notes: []
    OperationLinks: []
    InputProducts: []
    OutputProducts: []
    FinishedProducts: []
  ]
]
```

Response 200:

```text
ProductID: guid
ProductionBOMs: [
  BOMID: guid
  OutputQuantity: number
  BufferPercent: number
  InstructionUrl: string
  IgnoreCumulativeLeadTime: boolean
  ComponentProductionLeadTime: number
  Version: number
  Name: string
  IsDefault: boolean
  CreatedDate: date
  DeliveryToID: null
  DeliveryToName: null
  IssueMethod: number
  IsTracing: boolean
  IssueMethodComponent: number
  IssueMethodParameter: number
  MinQuantity: number
  MaxQuantity: number
  DeviationPercent: number
  RunSize: number
  Operations: [
    OperationID: guid
    Order: number
    Name: string
    CycleTime: number
    UnitsPerCycle: number
    WorkCenterID: guid
    WorkCenterName: string
    WorkCenterCoManProcurementType: null
    OperationType: string
    IsDropShip: boolean
    IsBackflush: boolean
    Resources: [
      BOMResourceID: guid
      ResourceID: guid
      ResourceName: string
      ResourceCode: string
      Quantity: number
      Cost: number
      CycleTime: number
      Position: number
      CostCalculationType: string
    ]
    Components: [
      BOMComponentID: guid
      ProductID: guid
      ProductName: string
      ProductSKU: string
      Quantity: number
      WastageQty: number
      WastagePercent: number
      Cost: number
      CostingMethod: string
      Unit: string
      Position: number
      SalePriceTier: null
      IsBackflush: boolean
    ]
    Attachments: [
      AttachmentID: guid
      FileName: string
      Date: date
      ContentType: string
      Position: number
      Content: null
    ]
    Notes: []
    OperationLinks: []
    InputProducts: []
    OutputProducts: []
    FinishedProducts: []
    VariationComponents: []
  ]
]
```

### PUT `/production/productionBOM`

Request body:

```text
BOMID: guid
ProductID: guid
OutputQuantity: number
Version: number
IssueMethodComponent: number
IssueMethodParameter: number
Operations: [
  OperationID: guid
  Order: number
  Name: string
  CycleTime: number
  UnitsPerCycle: number
  WorkCenterID: guid
  WorkCenterName: string
  OperationType: string
  IsDropShip: boolean
  IsTracing: boolean
  IsBackflush: boolean
  Resources: [
    BOMResourceID: guid
    ResourceID: guid
    ResourceName: string
    ResourceCode: string
    Quantity: number
    CycleTime: number
    Position: number
    CostCalculationType: string
  ]
  Components: [
    BOMComponentID: guid
    ProductID: guid
    ProductName: string
    ProductSKU: string
    Quantity: number
    WastageQty: number
    WastagePercent: number
    Cost: number
    CostingMethod: string
    Unit: string
    Position: number
    SalePriceTier: null
    IsBackflush: boolean
  ]
  OperationLinks: []
  Attachments: []
]
```

Response 200:

```text
ProductID: guid
ProductionBOMs: [
  BOMID: guid
  OutputQuantity: number
  BufferPercent: number
  InstructionUrl: string
  IgnoreCumulativeLeadTime: boolean
  ComponentProductionLeadTime: number
  Version: number
  Name: string
  IsDefault: boolean
  CreatedDate: date
  DeliveryToID: null
  DeliveryToName: null
  IssueMethod: number
  IsTracing: boolean
  IssueMethodComponent: number
  IssueMethodParameter: number
  MinQuantity: number
  MaxQuantity: number
  DeviationPercent: number
  RunSize: number
  Operations: [
    OperationID: guid
    Order: number
    Name: string
    CycleTime: number
    UnitsPerCycle: number
    WorkCenterID: guid
    WorkCenterName: string
    WorkCenterCoManProcurementType: null
    OperationType: string
    IsDropShip: boolean
    IsBackflush: boolean
    Resources: [
      BOMResourceID: guid
      ResourceID: guid
      ResourceName: string
      ResourceCode: string
      Quantity: number
      Cost: number
      CycleTime: number
      Position: number
      CostCalculationType: string
    ]
    Components: [
      BOMComponentID: guid
      ProductID: guid
      ProductName: string
      ProductSKU: string
      Quantity: number
      WastageQty: number
      WastagePercent: number
      Cost: number
      CostingMethod: string
      Unit: string
      Position: number
      SalePriceTier: null
      IsBackflush: boolean
    ]
    Attachments: []
    Notes: []
    OperationLinks: []
    InputProducts: []
    OutputProducts: []
    FinishedProducts: []
    VariationComponents: []
  ]
]
```

### DELETE `/production/productionBOM`

| Parameter | Type | Required |
|---|---|---|
| `ProductID` | guid | yes |
| `BOMID` | guid | yes |

### GET `/production/productionBOM`

| Parameter | Type | Required |
|---|---|---|
| `ProductFamilyID` | guid | yes |
| `ReturnAttachmentsContent` | bool |  |

Response 200:

```text
ProductFamilyID: guid
ProductionBOMs: [
  BOMID: guid
  OutputQuantity: number
  BufferPercent: number
  InstructionUrl: string
  IgnoreCumulativeLeadTime: boolean
  ComponentProductionLeadTime: number
  Version: number
  Name: string
  IsDefault: boolean
  CreatedDate: date
  DeliveryToID: null
  DeliveryToName: null
  IssueMethod: number
  Operations: [
    OperationID: guid
    Order: number
    Name: string
    CycleTime: number
    UnitsPerCycle: number
    WorkCenterID: guid
    WorkCenterName: string
    WorkCenterCoManProcurementType: null
    OperationType: string
    IsDropShip: boolean
    Resources: [
      BOMResourceID: guid
      ResourceID: guid
      ResourceName: string
      ResourceCode: string
      Quantity: number
      Cost: number
      CycleTime: number
      Position: number
      CostCalculationType: string
    ]
    Components: []
    Attachments: []
    Notes: []
    OperationLinks: [
      ID: guid
      RelatedOperationID: null
      RelatedOperationName: null
      RelationType: number
    ]
    InputProducts: []
    OutputProducts: []
    FinishedProducts: [
      ID: guid
      ProductID: null
      ProductFamilyID: guid
      CostCalculationType: string
      PriceTier: number
      Ratio: number
      OutputQuantity: number
      ProductName: string
      ProductSKU: string
      AverageCost: number
      CostingMethod: string
      Unit: string
      Position: number
      WastageCost: null
      DeliveryTo: null
      DeliveryToName: null
    ]
    VariationComponents: [
      BOMVariationComponentID: guid
      ProductFamilyID: guid
      ProductFamilyName: string
      ProductFamilySKU: string
      QuantitySettingsJSON: string
      MapVariationsJSON: string
      CostingMethod: string
      Unit: string
      Position: number
      SalePriceTier: null
      QuantityOptionName: string
    ]
  ]
]
```

### POST `/production/productionBOM`

Request body:

```text
ProductFamilyID: guid
ProductionBOMs: [
  OutputQuantity: number
  BufferPercent: number
  InstructionUrl: string
  IssueMethod: number
  IgnoreCumulativeLeadTime: boolean
  ComponentProductionLeadTime: number
  Operations: [
    Order: number
    Name: string
    CycleTime: number
    CycleTimeString: string
    UnitsPerCycle: number
    WorkCenterID: guid
    OperationType: number
    IsDropShip: boolean
    Resources: [
      ResourceID: guid
      ResourceName: string
      ResourceCode: string
      Quantity: number
      CycleTime: number
      Cost: number
      Position: number
      CostCalculationType: string
    ]
    Components: [
      ProductID: guid
      ProductName: string
      ProductSKU: string
      Quantity: number
      WastageQty: number
      WastagePercent: number
      Cost: number
      CostingMethod: string
      Position: number
      Unit: string
      SalePriceTier: null
    ]
    VariationComponents: [
      ProductFamilySKU: string
      QuantitySettingsJSON: string
      QuantityOptionName: string
      MapVariationsJSON: string
      Cost: number
      CostingMethod: string
      Position: number
      Unit: string
      SalePriceTier: null
    ]
    Attachments: []
    Notes: []
    OperationLinks: [
      RelatedOperationID: null
      RelatedOperationName: null
      RelationType: number
    ]
    InputProducts: []
    OutputProducts: []
    FinishedProducts: [
      ProductFamilyID: guid
      CostCalculationType: string
      PriceTier: number
      Ratio: number
      OutputQuantity: number
      ProductName: string
      ProductSKU: string
      AverageCost: number
      CostingMethod: string
      Unit: string
      Position: number
      WastageCost: number
      DeliveryTo: null
      DeliveryToName: null
    ]
  ]
]
```

Response 200:

```text
ProductFamilyID: guid
ProductionBOMs: [
  BOMID: guid
  OutputQuantity: number
  BufferPercent: number
  InstructionUrl: string
  IgnoreCumulativeLeadTime: boolean
  ComponentProductionLeadTime: number
  Version: number
  Name: string
  IsDefault: boolean
  CreatedDate: date
  DeliveryToID: null
  DeliveryToName: null
  IssueMethod: number
  Operations: [
    OperationID: guid
    Order: number
    Name: string
    CycleTime: number
    UnitsPerCycle: number
    WorkCenterID: guid
    WorkCenterName: string
    WorkCenterCoManProcurementType: null
    OperationType: string
    IsDropShip: boolean
    Resources: [
      BOMResourceID: guid
      ResourceID: guid
      ResourceName: string
      ResourceCode: string
      Quantity: number
      Cost: number
      CycleTime: number
      Position: number
      CostCalculationType: string
    ]
    Components: [
      BOMComponentID: guid
      ProductID: guid
      ProductName: string
      ProductSKU: string
      Quantity: number
      WastageQty: number
      WastagePercent: number
      Cost: number
      CostingMethod: string
      Unit: string
      Position: number
      SalePriceTier: null
    ]
    Attachments: []
    Notes: []
    OperationLinks: [
      ID: guid
      RelatedOperationID: null
      RelatedOperationName: null
      RelationType: number
    ]
    InputProducts: []
    OutputProducts: []
    FinishedProducts: [
      ID: guid
      ProductID: null
      ProductFamilyID: guid
      CostCalculationType: string
      PriceTier: number
      Ratio: number
      OutputQuantity: number
      ProductName: string
      ProductSKU: string
      AverageCost: number
      CostingMethod: string
      Unit: string
      Position: number
      WastageCost: null
      DeliveryTo: null
      DeliveryToName: null
    ]
    VariationComponents: [
      BOMVariationComponentID: guid
      ProductFamilyID: guid
      ProductFamilyName: string
      ProductFamilySKU: string
      QuantitySettingsJSON: string
      MapVariationsJSON: string
      CostingMethod: string
      Unit: string
      Position: number
      SalePriceTier: null
      QuantityOptionName: string
    ]
  ]
]
```

### PUT `/production/productionBOM`

Request body:

```text
BOMID: guid
ProductFamilyID: guid
OutputQuantity: number
Operations: [
  OperationID: guid
  Order: number
  Name: string
  CycleTime: number
  UnitsPerCycle: number
  WorkCenterID: guid
  WorkCenterName: string
  OperationType: string
  IsDropShip: boolean
  Resources: [
    BOMResourceID: guid
    ResourceID: guid
    ResourceName: string
    ResourceCode: string
    Quantity: number
    Cost: number
    CycleTime: number
    Position: number
    CostCalculationType: string
  ]
  Attachments: []
  Notes: []
  OperationLinks: [
    ID: guid
    RelatedOperationID: null
    RelatedOperationName: null
    RelationType: number
  ]
  InputProducts: []
  OutputProducts: []
  FinishedProducts: []
  Components: []
  VariationComponents: []
]
```

Response 200:

```text
ProductFamilyID: guid
ProductionBOMs: [
  BOMID: guid
  OutputQuantity: number
  BufferPercent: number
  InstructionUrl: string
  IgnoreCumulativeLeadTime: boolean
  ComponentProductionLeadTime: number
  Version: number
  Name: string
  IsDefault: boolean
  CreatedDate: date
  DeliveryToID: null
  DeliveryToName: null
  IssueMethod: number
  Operations: [
    OperationID: guid
    Order: number
    Name: string
    CycleTime: number
    UnitsPerCycle: number
    WorkCenterID: guid
    WorkCenterName: string
    WorkCenterCoManProcurementType: null
    OperationType: string
    IsDropShip: boolean
    Resources: [
      BOMResourceID: guid
      ResourceID: guid
      ResourceName: string
      ResourceCode: string
      Quantity: number
      Cost: number
      CycleTime: number
      Position: number
      CostCalculationType: string
    ]
    Components: []
    Attachments: []
    Notes: []
    OperationLinks: [
      ID: guid
      RelatedOperationID: null
      RelatedOperationName: null
      RelationType: number
    ]
    InputProducts: []
    OutputProducts: []
    FinishedProducts: []
    VariationComponents: []
  ]
]
```

### DELETE `/production/productionBOM`

| Parameter | Type | Required |
|---|---|---|
| `ProductFamilyID` | guid | yes |
| `BOMID` | guid | yes |

### GET `/production/order`

| Parameter | Type | Required |
|---|---|---|
| `ProductionOrderID` | guid | yes |
| `ReturnAttachmentsContent` | bool |  |

Response 200:

```text
ProductionOrders: [
  ProductionOrderID: guid
  ProductID: guid
  ProductName: string
  ProductSKU: string
  OrderNumber: string
  LocationID: guid
  LocationName: string
  CostingMethod: string
  WarehouseID: guid
  WarehouseName: string
  Unit: string
  OrderStatus: string
  Status: string
  SourceName: number
  SourceTaskID: null
  SourceTaskNumber: string
  WIPAccountCode: string
  FinishedGoodsAccountCode: string
  Quantity: number
  BOMQuantity: number
  CapacityCalculationType: string
  StartDate: date
  ReleaseDate: date
  RequiredByDate: date
  CompletionDate: null
  IsIgnoreLeadTime: boolean
  RetailID: null
  Comments: string
  StartUpdate: boolean
  PlannedBy: string
  ReleasedBy: string
  OrderCycleTime: number
  BOMVersion: number
  BOMName: string
  Tags: string
  CustomField1: string
  CustomField2: string
  CustomField3: string
  CustomField4: string
  CustomField5: string
  CustomField6: string
  CustomField7: string
  CustomField8: string
  CustomField9: string
  CustomField10: string
  IssueMethodComponent: number
  IssueMethodParameter: number
  RunSize: number
  Operations: [
    OperationID: guid
    Order: number
    Name: string
    CycleTime: number
    UnitsPerCycle: number
    TotalCycleTime: number
    TotalUnitsPerCycle: number
    OperationType: string
    WorkCenterID: guid
    WorkCenterName: string
    WorkCenterCode: string
    WorkCenterCoManProcurementType: null
    ComponentLocationID: null
    IsDropShip: boolean
    IsBackflush: boolean
    Attachments: [
      AttachmentID: guid
      FileName: string
      Date: date
      ContentType: string
      Position: number
      Content: null
    ]
    Components: [
      OrderComponentID: guid
      ProductID: guid
      ProductName: string
      ProductSKU: string
      Available: number
      Quantity: number
      TotalQuantity: number
      WastageQty: number
      WastagePercent: number
      Cost: number
      TotalCost: number
      ProductCost: number
      CostingMethod: string
      Unit: string
      ProductType: string
      Position: number
      SalePriceTier: number
      IsAlternative: boolean
      IsBackflush: boolean
    ]
    Notes: []
    Resources: [
      OrderResourceID: guid
      ResourceID: guid
      ResourceCode: string
      ResourceName: string
      Quantity: number
      Cost: number
      TotalCost: number
      ResourceCost: number
      CycleTime: number
      Position: number
      CostCalculationType: string
    ]
    OperationLinks: [
      ID: guid
      RelatedOperationID: null
      RelationType: number
    ]
    InputProducts: []
    OutputProducts: []
    FinishedProducts: []
  ]
  Deliveries: []
  SourceTasks: [
    SourceTaskID: guid
    SourceTaskNumber: string
  ]
]
```

### POST `/production/order`

| Parameter | Type | Required |
|---|---|---|
| `RecalculateDates` | bool |  |

Request body:

```text
ProductID: guid
ProductSKU: string
LocationID: guid
LocationName: string
FinishedGoodsAccountCode: string
WIPAccountCode: string
Quantity: number
CapacityCalculationType: string
StartDate: date
BOMVersion: number
IsIgnoreLeadTime: boolean
```

Response 200:

```text
ProductionOrders: [
  ProductionOrderID: guid
  ProductID: guid
  ProductName: string
  ProductSKU: string
  OrderNumber: string
  LocationID: guid
  LocationName: string
  CostingMethod: string
  WarehouseID: null
  WarehouseName: null
  Unit: string
  OrderStatus: string
  Status: string
  SourceName: number
  SourceTaskID: null
  SourceTaskNumber: null
  WIPAccountCode: string
  FinishedGoodsAccountCode: string
  Quantity: number
  BOMQuantity: number
  CapacityCalculationType: string
  StartDate: date
  ReleaseDate: date
  RequiredByDate: date
  CompletionDate: null
  IsIgnoreLeadTime: boolean
  RetailID: null
  Comments: null
  StartUpdate: boolean
  PlannedBy: null
  ReleasedBy: null
  OrderCycleTime: null
  BOMVersion: number
  BOMName: null
  Tags: null
  CustomField1: string
  CustomField2: string
  CustomField3: string
  CustomField4: string
  CustomField5: string
  CustomField6: string
  CustomField7: string
  CustomField8: string
  CustomField9: string
  CustomField10: string
  IssueMethodComponent: number
  IssueMethodParameter: number
  RunSize: number
  Operations: [
    OperationID: guid
    Order: number
    Name: string
    CycleTime: number
    UnitsPerCycle: number
    TotalCycleTime: number
    TotalUnitsPerCycle: number
    OperationType: string
    WorkCenterID: guid
    WorkCenterName: string
    WorkCenterCode: string
    WorkCenterCoManProcurementType: null
    ComponentLocationID: null
    IsDropShip: boolean
    Attachments: []
    IsBackflush: boolean
    Components: [
      OrderComponentID: guid
      ProductID: guid
      ProductName: string
      ProductSKU: string
      Available: number
      Quantity: number
      TotalQuantity: number
      WastageQty: number
      WastagePercent: number
      Cost: number
      TotalCost: number
      ProductCost: number
      CostingMethod: string
      Unit: string
      ProductType: string
      Position: number
      SalePriceTier: number
      IsAlternative: boolean
      IsBackflush: boolean
    ]
    Notes: [
      NoteID: guid
      Note: string
      Position: number
    ]
    Resources: [
      OrderResourceID: guid
      ResourceID: guid
      ResourceCode: string
      ResourceName: string
      Quantity: number
      Cost: number
      TotalCost: number
      ResourceCost: number
      CycleTime: number
      Position: number
      CostCalculationType: string
    ]
    OperationLinks: [
      ID: guid
      RelatedOperationID: null
      RelationType: number
    ]
    InputProducts: []
    OutputProducts: [
      ID: guid
      ProductID: guid
      ProductName: string
      ProductSKU: string
      CostCalculationType: string
      PriceTier: number
      Ratio: number
      OutputQuantity: number
      TotalOutputQuantity: number
      Cost: number
      TotalCost: number
      AverageCost: number
      FixedCost: number
      CostingMethod: string
      Unit: string
      Position: number
      WastageCost: number
    ]
    FinishedProducts: []
  ]
  Deliveries: []
  SourceTasks: [
    SourceTaskID: guid
    SourceTaskNumber: string
  ]
]
```

### PUT `/production/order`

| Parameter | Type | Required |
|---|---|---|
| `AllowRecalculateDates` | bool |  |
| `AllowRecalculateCyclesAndQuantities` | bool |  |

Request body:

```text
ProductionOrderID: guid
LocationID: guid
Quantity: number
BOMVersion: number
```

Response 200:

```text
ProductionOrders: [
  ProductionOrderID: guid
  ProductID: guid
  ProductName: string
  ProductSKU: string
  OrderNumber: string
  LocationID: guid
  LocationName: string
  CostingMethod: string
  WarehouseID: null
  WarehouseName: null
  Unit: string
  OrderStatus: string
  Status: string
  SourceName: number
  SourceTaskID: null
  SourceTaskNumber: null
  WIPAccountCode: string
  FinishedGoodsAccountCode: string
  Quantity: number
  BOMQuantity: number
  CapacityCalculationType: string
  StartDate: date
  ReleaseDate: date
  RequiredByDate: date
  CompletionDate: null
  IsIgnoreLeadTime: boolean
  RetailID: null
  Comments: null
  StartUpdate: boolean
  PlannedBy: null
  ReleasedBy: null
  OrderCycleTime: null
  BOMVersion: number
  BOMName: null
  Tags: null
  CustomField1: string
  CustomField2: string
  CustomField3: string
  CustomField4: string
  CustomField5: string
  CustomField6: string
  CustomField7: string
  CustomField8: string
  CustomField9: string
  CustomField10: string
  IssueMethodComponent: number
  IssueMethodParameter: number
  RunSize: number
  Operations: [
    OperationID: guid
    Order: number
    Name: string
    CycleTime: number
    UnitsPerCycle: number
    TotalCycleTime: number
    TotalUnitsPerCycle: number
    OperationType: string
    WorkCenterID: guid
    WorkCenterName: string
    WorkCenterCode: string
    WorkCenterCoManProcurementType: null
    ComponentLocationID: null
    IsDropShip: boolean
    Attachments: []
    IsBackflush: boolean
    Components: [
      OrderComponentID: guid
      ProductID: guid
      ProductName: string
      ProductSKU: string
      Available: number
      Quantity: number
      TotalQuantity: number
      WastageQty: number
      WastagePercent: number
      Cost: number
      TotalCost: number
      ProductCost: number
      CostingMethod: string
      Unit: string
      ProductType: string
      Position: number
      SalePriceTier: number
      IsAlternative: boolean
      IsBackflush: boolean
    ]
    Notes: [
      NoteID: guid
      Note: string
      Position: number
    ]
    Resources: [
      OrderResourceID: guid
      ResourceID: guid
      ResourceCode: string
      ResourceName: string
      Quantity: number
      Cost: number
      TotalCost: number
      ResourceCost: number
      CycleTime: number
      Position: number
      CostCalculationType: string
    ]
    OperationLinks: [
      ID: guid
      RelatedOperationID: null
      RelationType: number
    ]
    InputProducts: []
    OutputProducts: [
      ID: guid
      ProductID: guid
      ProductName: string
      ProductSKU: string
      CostCalculationType: string
      PriceTier: number
      Ratio: number
      OutputQuantity: number
      TotalOutputQuantity: number
      Cost: number
      TotalCost: number
      AverageCost: number
      FixedCost: number
      CostingMethod: string
      Unit: string
      Position: number
      WastageCost: number
    ]
    FinishedProducts: []
  ]
  Deliveries: []
  SourceTasks: [
    SourceTaskID: guid
    SourceTaskNumber: string
  ]
]
```

### POST `/production/order/authorise` (Authorise)

Request body:

```text
productionOrderID: guid
```

Response 200:

```text
ProductionOrders: [
  ProductionOrderID: guid
  ProductID: guid
  ProductName: string
  ProductSKU: string
  OrderNumber: string
  LocationID: guid
  LocationName: string
  CostingMethod: string
  WarehouseID: null
  WarehouseName: null
  Unit: string
  OrderStatus: string
  Status: string
  SourceName: number
  SourceTaskID: null
  SourceTaskNumber: null
  WIPAccountCode: string
  FinishedGoodsAccountCode: string
  Quantity: number
  BOMQuantity: number
  CapacityCalculationType: string
  StartDate: date
  ReleaseDate: date
  RequiredByDate: date
  CompletionDate: null
  IsIgnoreLeadTime: boolean
  RetailID: null
  Comments: null
  StartUpdate: boolean
  PlannedBy: string
  ReleasedBy: null
  OrderCycleTime: null
  BOMVersion: number
  BOMName: null
  Tags: null
  CustomField1: string
  CustomField2: string
  CustomField3: string
  CustomField4: string
  CustomField5: string
  CustomField6: string
  CustomField7: string
  CustomField8: string
  CustomField9: string
  CustomField10: string
  IssueMethodComponent: number
  IssueMethodParameter: number
  RunSize: number
  Operations: [
    OperationID: guid
    Order: number
    Name: string
    CycleTime: number
    UnitsPerCycle: number
    TotalCycleTime: number
    TotalUnitsPerCycle: number
    OperationType: string
    WorkCenterID: guid
    WorkCenterName: string
    WorkCenterCode: string
    WorkCenterCoManProcurementType: null
    ComponentLocationID: null
    IsDropShip: boolean
    Attachments: []
    IsBackflush: boolean
    Components: [
      OrderComponentID: guid
      ProductID: guid
      ProductName: string
      ProductSKU: string
      Available: number
      Quantity: number
      TotalQuantity: number
      WastageQty: number
      WastagePercent: number
      Cost: number
      TotalCost: number
      ProductCost: number
      CostingMethod: string
      Unit: string
      ProductType: string
      Position: number
      SalePriceTier: number
      IsAlternative: boolean
      IsBackflush: boolean
    ]
    Notes: [
      NoteID: guid
      Note: string
      Position: number
    ]
    Resources: [
      OrderResourceID: guid
      ResourceID: guid
      ResourceCode: string
      ResourceName: string
      Quantity: number
      Cost: number
      TotalCost: number
      ResourceCost: number
      CycleTime: number
      Position: number
      CostCalculationType: string
    ]
    OperationLinks: [
      ID: guid
      RelatedOperationID: null
      RelationType: number
    ]
    InputProducts: []
    OutputProducts: [
      ID: guid
      ProductID: guid
      ProductName: string
      ProductSKU: string
      CostCalculationType: string
      PriceTier: number
      Ratio: number
      OutputQuantity: number
      TotalOutputQuantity: number
      Cost: number
      TotalCost: number
      AverageCost: number
      FixedCost: number
      CostingMethod: string
      Unit: string
      Position: number
      WastageCost: number
    ]
    FinishedProducts: []
  ]
  Deliveries: []
  SourceTasks: [
    SourceTaskID: guid
    SourceTaskNumber: string
  ]
]
```

### POST `/production/order/release` (Release)

Request body:

```text
productionOrderID: guid
releaseDate: date
```

Response 200:

```text
Warning: string
ProductionOrders: [
  ProductionOrderID: guid
  ProductID: guid
  ProductName: string
  ProductSKU: string
  OrderNumber: string
  LocationID: guid
  LocationName: string
  CostingMethod: string
  WarehouseID: null
  WarehouseName: null
  Unit: string
  OrderStatus: string
  Status: string
  SourceName: number
  SourceTaskID: null
  SourceTaskNumber: null
  WIPAccountCode: string
  FinishedGoodsAccountCode: string
  Quantity: number
  BOMQuantity: number
  CapacityCalculationType: string
  StartDate: date
  ReleaseDate: date
  RequiredByDate: date
  CompletionDate: null
  IsIgnoreLeadTime: boolean
  RetailID: null
  Comments: null
  StartUpdate: boolean
  PlannedBy: string
  ReleasedBy: string
  OrderCycleTime: number
  BOMVersion: number
  BOMName: null
  Tags: null
  CustomField1: string
  CustomField2: string
  CustomField3: string
  CustomField4: string
  CustomField5: string
  CustomField6: string
  CustomField7: string
  CustomField8: string
  CustomField9: string
  CustomField10: string
  IssueMethodComponent: number
  IssueMethodParameter: number
  RunSize: number
  Operations: [
    OperationID: guid
    Order: number
    Name: string
    CycleTime: number
    UnitsPerCycle: number
    TotalCycleTime: number
    TotalUnitsPerCycle: number
    OperationType: string
    WorkCenterID: guid
    WorkCenterName: string
    WorkCenterCode: string
    WorkCenterCoManProcurementType: null
    ComponentLocationID: null
    IsDropShip: boolean
    Attachments: []
    IsBackflush: boolean
    Components: [
      OrderComponentID: guid
      ProductID: guid
      ProductName: string
      ProductSKU: string
      Available: number
      Quantity: number
      TotalQuantity: number
      WastageQty: number
      WastagePercent: number
      Cost: number
      TotalCost: number
      ProductCost: number
      CostingMethod: string
      Unit: string
      ProductType: string
      Position: number
      SalePriceTier: number
      IsAlternative: boolean
      IsBackflush: boolean
    ]
    Notes: [
      NoteID: guid
      Note: string
      Position: number
    ]
    Resources: [
      OrderResourceID: guid
      ResourceID: guid
      ResourceCode: string
      ResourceName: string
      Quantity: number
      Cost: number
      TotalCost: number
      ResourceCost: number
      CycleTime: number
      Position: number
      CostCalculationType: string
    ]
    OperationLinks: [
      ID: guid
      RelatedOperationID: null
      RelationType: number
    ]
    InputProducts: []
    OutputProducts: [
      ID: guid
      ProductID: guid
      ProductName: string
      ProductSKU: string
      CostCalculationType: string
      PriceTier: number
      Ratio: number
      OutputQuantity: number
      TotalOutputQuantity: number
      Cost: number
      TotalCost: number
      AverageCost: number
      FixedCost: number
      CostingMethod: string
      Unit: string
      Position: number
      WastageCost: number
    ]
    FinishedProducts: []
  ]
  Deliveries: []
  SourceTasks: [
    SourceTaskID: guid
    SourceTaskNumber: string
  ]
]
```

### POST `/production/order/undo` (Undo)

Request body:

```text
productionOrderID: guid
ApplyToTasks: boolean
```

Response 200:

```text
Message: string
ProductionOrderID: guid
```

### POST `/production/order/attachment` (Post Attachment)

| Parameter | Type | Required |
|---|---|---|
| `ProductionOrderID` | guid | yes |

Request body:

```text
FileName: string
Date: date
ContentType: string
IsProcessed: boolean
UserName: string
ExternalDownloadLink: null
ExternalViewLink: null
Content: string
```

Response 200:

```text
AttachmentID: guid
FileName: string
Date: date
ContentType: string
IsProcessed: boolean
UserName: string
Content: null
ExternalDownloadLink: null
ExternalViewLink: null
```

### PUT `/production/order/attachment` (Put Attachment)

Request body:

```text
keys: AttachmentID, IsProcessed
```

Response 200:

```text
AttachmentID: guid
FileName: string
Date: date
ContentType: string
IsProcessed: boolean
UserName: string
Content: null
ExternalDownloadLink: null
ExternalViewLink: null
```

### DELETE `/production/order/attachment` (Delete Attachment)

| Parameter | Type | Required |
|---|---|---|
| `ProductionOrderAttachmentID` | guid | yes |

### GET `/production/order/attachment` (Get Production Order Attachments)

| Parameter | Type | Required |
|---|---|---|
| `ProductionOrderID` | guid | yes |
| `ReturnAttachmentsContent` | bool |  |

Response 200:

```text
ProductionOrderID: guid
OrderAttachments: [
  AttachmentID: guid
  FileName: string
  Date: date
  ContentType: string
  IsProcessed: boolean
  UserName: string
  Content: null
  ExternalDownloadLink: null
  ExternalViewLink: null
]
OrderOperationAttachments: []
OrderOperationResourceAttachments: []
```

### POST `/production/order/void` (Void)

Request body:

```text
productionOrderID: guid
ApplyToTasks: boolean
```

Response 200:

```text
Message: string
ProductionOrderID: guid
```

### GET `/production/order/referenceData` (Get Production Order Reference Data)

Response 200:

```text
ProductionOrderTags: [string]
ChartOfAccounts: [
  Code: string
  Status: string
  Name: string
  Type: string
  Description: string
  Class: string
  SystemAccount: null
  SystemAccountCode: null
  BankAccountNumber: null
  BankAccountId: null
  ForPayments: boolean
  DisplayName: string
]
ShopFloorLocations: [
  LocationID: guid
  Description: string
  IsDefault: boolean
  UseForFixedAssetsOnly: boolean
  IsShopFloor: boolean
  IsCoMan: boolean
]
LogisticsPaths: [
  PathID: guid
  WarehouseLocationID: guid
  WarehouseLocation: string
  ShopFloorLocationID: guid
  ShopFloorLocation: string
  RetailLocationID: guid
  RetailLocation: string
]
WorkCenters: [
  WorkCenterID: guid
  Code: string
  Name: string
  IsActive: boolean
  IsCoMan: boolean
  Locations: [
    ID: guid
    LocationID: guid
    Type: string
    LocationName: string
  ]
  CoManProcurementType: null
]
PriceTiers: []
InventoryControlAccount: string
WipAccount: string
SuspendReasons: [
  ID: guid
  Reason: string
  WorkCenterIDs: guid
]
```

### GET `/production/orderList`

| Parameter | Type | Required |
|---|---|---|
| `Page` | number |  |
| `Limit` | number |  |
| `Status` | string |  |
| `Search` | string |  |
| `LocationID` | uniqueidentifier |  |
| `RequiredByDateFrom` | DateTime |  |
| `RequiredByDateTo` | DateTime |  |
| `CompletionDateFrom` | DateTime |  |
| `CompletionDateTo` | DateTime |  |
| `SourceTaskID` | uniqueidentifier |  |

Response 200:

```text
ProductionOrderListItems: [
  TaskID: guid
  ProductionOrderID: guid
  Type: string
  ProductID: guid
  ProductSKU: string
  ProductName: string
  OrderNumber: string
  LocationID: guid
  LocationName: string
  Status: string
  OrderStatus: string
  Quantity: number
  StartDate: date
  ReleaseDate: date
  RequiredByDate: date
  CompletionDate: null
  TotalCount: number
  CapacityCalculationType: string
  WIPAccountCode: string
  FinishedGoodsAccountCode: string
  Comments: string
  SourceTaskID: null
  SourceTaskNumber: string
  SourceTaskType: null
  IsSourceTaskVoided: boolean
  CustomField1: string
  CustomField2: string
  CustomField3: string
  CustomField4: string
  CustomField5: string
  CustomField6: string
  CustomField7: string
  CustomField8: string
  CustomField9: string
  CustomField10: string
  SourceTasks: [
    SourceTaskID: guid
    SourceTaskNumber: string
    SourceTaskType: number
    IsSourceTaskVoided: boolean
  ]
]
```

### POST `/production/order/run`

Request body:

```text
ProductionOrderID: guid
IncreaseOrderQuantity: boolean
Runs: [
  Quantity: number
  WIPAccount: string
]
```

Response 200:

```text
Warnings: []
ProductionOrderID: guid
OrderNumber: string
Runs: [
  RunID: guid
  Number: number
  Status: string
  Quantity: number
  WIPAccount: string
  StartDate: null
  EndDate: null
  DueDate: null
  ReceivedDate: null
  IssueMethodParameter: number
  Operations: [
    OperationID: guid
    Status: string
    Order: number
    Name: string
    PlannedTime: number
    ActualTime: null
    UnitsPerCycle: number
    WorkCenterID: guid
    WorkCenterName: string
    OperationType: string
    WorkCenterCode: string
    StartDate: null
    EndDate: null
    DueDate: null
    IsDropShip: boolean
    IsBackflush: boolean
    Components: [
      RunComponentID: guid
      ProductID: guid
      ProductName: string
      ProductCode: string
      Quantity: number
      ExpectedQuantity: number
      WastageQty: number
      WastagePercent: number
      BatchSN: null
      ExpiryDate: null
      UnitCost: number
      LocationID: guid
      LocationName: string
      ProductCost: number
      Available: number
      CostingMethod: string
      Unit: string
      ReservedQuantity: null
      IsReserved: boolean
      IsBackflush: boolean
    ]
    Resources: [
      ResourceID: guid
      ResourceName: string
      ResourceCode: string
      UnitCost: number
      Quantity: number
      Cost: number
      CycleTime: number
      Available: number
    ]
    ResourceCosts: []
    FinishedProducts: []
    OutputProducts: []
    InputProducts: []
    CoManTasks: []
    CoManTaskLines: []
    Attachments: []
    Notes: []
    SuspendReason: null
    CoManStatus: null
    ManualStartDate: null
    ManualEndDate: null
  ]
  Output: []
  PendingOutput: []
  ManualJournals: []
  Traceability: []
]
```

### GET `/production/order/run`

| Parameter | Type | Required |
|---|---|---|
| `ProductionOrderID` | guid | yes |
| `IncludeAttachmentContent` | boolean |  |

Response 200:

```text
ProductionOrderID: guid
OrderNumber: string
Runs: [
  RunID: guid
  Number: number
  Status: string
  Quantity: number
  WIPAccount: string
  StartDate: null
  EndDate: null
  DueDate: null
  ReceivedDate: null
  ScheduleStart: null
  ScheduleDue: null
  IssueMethodParameter: number
  Operations: [
    OperationID: guid
    Status: string
    Order: number
    Name: string
    PlannedTime: number
    ActualTime: null
    UnitsPerCycle: number
    WorkCenterID: guid
    WorkCenterName: string
    OperationType: string
    WorkCenterCode: string
    StartDate: null
    EndDate: null
    DueDate: null
    IsDropShip: boolean
    IsBackflush: boolean
    Components: [
      RunComponentID: guid
      ProductID: guid
      ProductName: string
      ProductCode: string
      Quantity: number
      ExpectedQuantity: number
      WastageQty: number
      WastagePercent: number
      BatchSN: null
      ExpiryDate: null
      UnitCost: number
      LocationID: guid
      LocationName: string
      ProductCost: number
      Available: number
      CostingMethod: string
      Unit: string
      ReservedQuantity: null
      IsReserved: boolean
      IsBackflush: boolean
    ]
    Resources: [
      ResourceID: guid
      ResourceName: string
      ResourceCode: string
      UnitCost: number
      Quantity: number
      Cost: number
      CycleTime: number
      Available: number
    ]
    ResourceCosts: []
    FinishedProducts: []
    OutputProducts: []
    InputProducts: []
    CoManTasks: []
    CoManTaskLines: []
    Attachments: []
    Notes: []
    SuspendReason: null
    CoManStatus: null
    ManualStartDate: null
    ManualEndDate: null
  ]
  Output: []
  PendingOutput: []
  ManualJournals: []
  Traceability: [
    TraceabilityID: guid
    ProducedProductID: guid
    ProducedProductBatchSN: string
    ProducedProductExpiryDate: null
    UsedProductID: guid
    UsedProductBatchSN: string
    UsedProductExpiryDate: date
  ]
]
```

### PUT `/production/order/run`

| Parameter | Type | Required |
|---|---|---|
| `ProductionOrderID` | guid | yes |
| `IncreaseOrderQuantity` | bool | yes |

Request body:

```text
keys: Quantity, RunID
```

Response 200:

```text
RunID: guid
Number: number
Status: string
Quantity: number
WIPAccount: string
StartDate: date
EndDate: null
DueDate: null
ReceivedDate: date
IssueMethodParameter: number
Operations: [
  OperationID: guid
  Status: string
  Order: number
  Name: string
  PlannedTime: number
  ActualTime: number
  UnitsPerCycle: number
  WorkCenterID: guid
  WorkCenterName: string
  OperationType: string
  WorkCenterCode: string
  StartDate: date
  EndDate: null
  DueDate: null
  IsDropShip: boolean
  IsBackflush: boolean
  Components: [
    RunComponentID: guid
    ProductID: guid
    ProductName: string
    ProductCode: string
    Quantity: number
    ExpectedQuantity: number
    WastageQty: number
    WastagePercent: number
    BatchSN: string
    ExpiryDate: null
    UnitCost: number
    LocationID: guid
    LocationName: string
    ProductCost: number
    Available: number
    CostingMethod: null
    Unit: string
    ReservedQuantity: number
    IsReserved: boolean
    IsBackflush: boolean
  ]
  Resources: [
    RunResourceID: guid
    ResourceID: guid
    ResourceName: string
    ResourceCode: string
    UnitCost: number
    Quantity: number
    Cost: number
    CycleTime: number
    Available: number
  ]
  Attachments: [
    AttachmentID: guid
    FileName: string
    Date: date
    ContentType: string
    Content: null
    Position: number
  ]
  Notes: []
]
```

### PUT `/production/order/run/complete` (Complete Run)

Request body:

```text
ProductionOrderID: guid
ProductionRunID: guid
EffectiveDate: date
FinishedProducts: [
  Quantity: number
  WastageQuantity: number
  Received: boolean
  ReceivedDate: date
  LocationID: guid
  ProductID: guid
  BatchSN: string
  ExpiryDate: null
]
```

Response 200:

```text
Warnings: []
ProductionOrderID: guid
OrderNumber: string
Runs: [
  RunID: guid
  Number: number
  Status: string
  Quantity: number
  WIPAccount: string
  StartDate: date
  EndDate: date
  DueDate: null
  ReceivedDate: date
  ScheduleStart: date
  ScheduleDue: date
  IssueMethodParameter: number
  Operations: [
    OperationID: guid
    Status: string
    Order: number
    Name: string
    PlannedTime: number
    ActualTime: number
    UnitsPerCycle: number
    WorkCenterID: guid
    WorkCenterName: string
    OperationType: string
    WorkCenterCode: string
    StartDate: date
    EndDate: date
    DueDate: null
    IsDropShip: boolean
    Components: [
      RunComponentID: guid
      ProductID: guid
      ProductName: string
      ProductCode: string
      Quantity: number
      ExpectedQuantity: number
      WastageQty: number
      WastagePercent: number
      BatchSN: string
      ExpiryDate: null
      UnitCost: number
      LocationID: guid
      LocationName: string
      ProductCost: number
      Available: number
      CostingMethod: string
      Unit: string
      ReservedQuantity: number
      IsReserved: boolean
      IsBackflush: boolean
    ]
    Resources: []
    ResourceCosts: []
    FinishedProducts: []
    OutputProducts: []
    InputProducts: []
    CoManTasks: []
    CoManTaskLines: []
    Attachments: []
    Notes: []
    SuspendReason: null
    CoManStatus: null
    IsBackflush: boolean
    ManualStartDate: null
    ManualEndDate: null
  ]
  Output: [
    ProductName: string
    Unit: string
    UnitCost: number
    CostingMethod: string
    Quantity: number
    WastageQuantity: number
    Received: boolean
    ReceivedDate: date
    LocationID: guid
    LocationName: string
    ProductID: guid
    ProductCode: string
    BatchSN: string
    ExpiryDate: null
  ]
  PendingOutput: []
  ManualJournals: []
  Traceability: []
]
```

### PUT `/production/order/run/undo` (Undo Run)

Request body:

```text
ProductionOrderID: guid
ProductionRunID: guid
ApplyToRelatedTasks: boolean
```

Response 200:

```text
ProductionOrderID: guid
ProductionRunID: guid
ApplyToRelatedTasks: boolean
ErrorMessage: string
```

### PUT `/production/order/run/void` (Void Run)

Request body:

```text
ProductionOrderID: guid
ProductionRunID: guid
ApplyToRelatedTasks: boolean
```

Response 200:

```text
ProductionOrderID: guid
ProductionRunID: guid
ApplyToRelatedTasks: boolean
ErrorMessage: string
```

### PUT `/production/order/run/manualJournal` (Update Manual Journals)

| Parameter | Type | Required |
|---|---|---|
| `ProductionOrderID` | guid | yes |

Request body:

```text
keys: Amount, Credit, Date, Debit, JournalID, ManualJournals, OperationID, Reference, RunID
```

Response 200:

```text
Warnings: []
ProductionOrderID: guid
OrderNumber: string
Runs: [
  RunID: guid
  Number: number
  Status: string
  Quantity: number
  WIPAccount: string
  StartDate: date
  EndDate: date
  DueDate: null
  ReceivedDate: date
  Operations: [
    OperationID: guid
    Status: string
    Order: number
    Name: string
    PlannedTime: number
    ActualTime: number
    UnitsPerCycle: number
    WorkCenterID: guid
    WorkCenterName: string
    OperationType: string
    WorkCenterCode: string
    StartDate: date
    EndDate: date
    DueDate: null
    IsDropShip: boolean
    Components: [
      RunComponentID: guid
      ProductID: guid
      ProductName: string
      ProductCode: string
      Quantity: number
      ExpectedQuantity: number
      WastageQty: number
      WastagePercent: number
      BatchSN: null
      ExpiryDate: null
      UnitCost: number
      LocationID: guid
      LocationName: string
      ProductCost: number
      Available: number
      CostingMethod: null
      Unit: string
      ReservedQuantity: number
      IsReserved: boolean
    ]
    Resources: []
    ResourceCosts: []
    FinishedProducts: []
    OutputProducts: []
    InputProducts: []
    CoManTasks: []
    CoManTaskLines: []
    Attachments: []
    Notes: []
    SuspendReason: null
    CoManStatus: null
    ManualStartDate: null
    ManualEndDate: null
  ]
  Output: [
    ProductName: string
    Unit: string
    UnitCost: number
    CostingMethod: string
    Quantity: number
    WastageQuantity: number
    Received: boolean
    ReceivedDate: date
    LocationID: guid
    LocationName: string
    ProductID: guid
    ProductCode: string
    BatchSN: string
    ExpiryDate: null
  ]
  PendingOutput: []
  ManualJournals: [
    Reference: string
    Amount: number
    Date: date
    Debit: string
    Credit: string
    OperationID: guid
    OperationName: string
  ]
]
```

### PUT `/production/order/run/operation/start` (Start Run Operation)

Request body:

```text
ProductionOrderID: guid
ProductionRunID: guid
RunOperationID: guid
WithAutoConsume: boolean
ManualStartDate: date
InputProducts: [
  ProductID: null
  ProductCode: string
  BatchSN: string
  Quantity: number
]
```

Response 200:

```text
Warnings: []
ProductionOrderID: guid
OrderNumber: string
Runs: [
  RunID: guid
  Number: number
  Status: string
  Quantity: number
  WIPAccount: string
  StartDate: date
  EndDate: null
  DueDate: null
  ReceivedDate: date
  IssueMethodParameter: number
  Operations: [
    OperationID: guid
    Status: string
    Order: number
    Name: string
    PlannedTime: number
    ActualTime: null
    UnitsPerCycle: number
    WorkCenterID: guid
    WorkCenterName: string
    OperationType: string
    WorkCenterCode: string
    StartDate: date
    EndDate: null
    DueDate: null
    IsDropShip: boolean
    IsBackflush: boolean
    Components: [
      RunComponentID: guid
      ProductID: guid
      ProductName: string
      ProductCode: string
      Quantity: number
      ExpectedQuantity: number
      WastageQty: number
      WastagePercent: number
      BatchSN: string
      ExpiryDate: null
      UnitCost: number
      LocationID: guid
      LocationName: string
      ProductCost: number
      Available: number
      CostingMethod: null
      Unit: string
      ReservedQuantity: number
      IsReserved: boolean
      IsBackflush: boolean
    ]
    Resources: [
      ResourceID: guid
      ResourceName: string
      ResourceCode: string
      UnitCost: number
      Quantity: number
      Cost: number
      CycleTime: number
      Available: number
    ]
    ResourceCosts: [
      RunCostID: guid
      ProductID: guid
      ProductName: string
      AccountName: string
      ExpenseAccount: string
      Comments: null
      Cost: number
    ]
    FinishedProducts: []
    OutputProducts: []
    InputProducts: []
    CoManTasks: []
    CoManTaskLines: []
    Attachments: [
      AttachmentID: guid
      FileName: string
      Date: date
      ContentType: string
      Content: string
      Position: number
    ]
    Notes: []
    SuspendReason: null
    CoManStatus: null
    ManualStartDate: date
    ManualEndDate: null
  ]
  Output: []
  PendingOutput: []
  ManualJournals: []
]
```

### PUT `/production/order/run/operation/suspend` (Suspend Run Operation)

Request body:

```text
ProductionOrderID: guid
ProductionRunID: guid
RunOperationID: guid
SuspendReasonID: guid
```

Response 200:

```text
Warnings: []
ProductionOrderID: guid
OrderNumber: string
Runs: [
  RunID: guid
  Number: number
  Status: string
  Quantity: number
  WIPAccount: string
  StartDate: date
  EndDate: null
  DueDate: null
  ReceivedDate: date
  IssueMethodParameter: number
  Operations: [
    OperationID: guid
    Status: string
    Order: number
    Name: string
    PlannedTime: number
    ActualTime: null
    UnitsPerCycle: number
    WorkCenterID: guid
    WorkCenterName: string
    OperationType: string
    WorkCenterCode: string
    StartDate: date
    EndDate: null
    DueDate: null
    IsDropShip: boolean
    IsBackflush: boolean
    Components: [
      RunComponentID: guid
      ProductID: guid
      ProductName: string
      ProductCode: string
      Quantity: number
      ExpectedQuantity: number
      WastageQty: number
      WastagePercent: number
      BatchSN: string
      ExpiryDate: null
      UnitCost: number
      LocationID: guid
      LocationName: string
      ProductCost: number
      Available: number
      CostingMethod: null
      Unit: string
      ReservedQuantity: number
      IsReserved: boolean
      IsBackflush: boolean
    ]
    Resources: [
      ResourceID: guid
      ResourceName: string
      ResourceCode: string
      UnitCost: number
      Quantity: number
      Cost: number
      CycleTime: number
      Available: number
    ]
    ResourceCosts: [
      RunCostID: guid
      ProductID: guid
      ProductName: string
      AccountName: string
      ExpenseAccount: string
      Comments: null
      Cost: number
    ]
    FinishedProducts: []
    OutputProducts: []
    InputProducts: []
    CoManTasks: []
    CoManTaskLines: []
    Attachments: [
      AttachmentID: guid
      FileName: string
      Date: date
      ContentType: string
      Content: string
      Position: number
    ]
    Notes: []
    SuspendReason: null
    CoManStatus: null
    ManualStartDate: null
    ManualEndDate: null
  ]
  Output: []
  PendingOutput: []
  ManualJournals: []
]
```

### PUT `/production/order/run/operation/resume` (Resume Run Operation)

Request body:

```text
ProductionOrderID: guid
ProductionRunID: guid
RunOperationID: guid
```

Response 200:

```text
Warnings: []
ProductionOrderID: guid
OrderNumber: string
Runs: [
  RunID: guid
  Number: number
  Status: string
  Quantity: number
  WIPAccount: string
  StartDate: date
  EndDate: null
  DueDate: null
  ReceivedDate: date
  IssueMethodParameter: number
  Operations: [
    OperationID: guid
    Status: string
    Order: number
    Name: string
    PlannedTime: number
    ActualTime: null
    UnitsPerCycle: number
    WorkCenterID: guid
    WorkCenterName: string
    OperationType: string
    WorkCenterCode: string
    StartDate: date
    EndDate: null
    DueDate: null
    IsDropShip: boolean
    IsBackflush: boolean
    Components: [
      RunComponentID: guid
      ProductID: guid
      ProductName: string
      ProductCode: string
      Quantity: number
      ExpectedQuantity: number
      WastageQty: number
      WastagePercent: number
      BatchSN: string
      ExpiryDate: null
      UnitCost: number
      LocationID: guid
      LocationName: string
      ProductCost: number
      Available: number
      CostingMethod: null
      Unit: string
      ReservedQuantity: number
      IsReserved: boolean
      IsBackflush: boolean
    ]
    Resources: [
      ResourceID: guid
      ResourceName: string
      ResourceCode: string
      UnitCost: number
      Quantity: number
      Cost: number
      CycleTime: number
      Available: number
    ]
    ResourceCosts: [
      RunCostID: guid
      ProductID: guid
      ProductName: string
      AccountName: string
      ExpenseAccount: string
      Comments: null
      Cost: number
    ]
    FinishedProducts: []
    OutputProducts: []
    InputProducts: []
    CoManTasks: []
    CoManTaskLines: []
    Attachments: [
      AttachmentID: guid
      FileName: string
      Date: date
      ContentType: string
      Content: string
      Position: number
    ]
    Notes: []
    SuspendReason: null
    CoManStatus: null
    ManualStartDate: null
    ManualEndDate: null
  ]
  Output: []
  PendingOutput: []
  ManualJournals: []
]
```

### PUT `/production/order/run/operation/complete` (Complete Run Operation)

Request body:

```text
ProductionOrderID: guid
ProductionRunID: guid
RunOperationID: guid
WithAutoConsume: boolean
WithoutOutput: boolean
AutoGenerateBatchSerialNumbers: boolean
ManualEndDate: date
FinishedProducts: [
  Quantity: number
  WastageQuantity: number
  BatchSN: string
  ExpiryDate: null
  ReceivedDate: date
  LocationID: guid
  ProductID: guid
  Received: boolean
]
```

Response 200:

```text
Warnings: []
ProductionOrderID: guid
OrderNumber: string
Runs: [
  RunID: guid
  Number: number
  Status: string
  Quantity: number
  WIPAccount: string
  StartDate: date
  EndDate: date
  DueDate: null
  ReceivedDate: date
  IssueMethodParameter: number
  Operations: [
    OperationID: guid
    Status: string
    Order: number
    Name: string
    PlannedTime: number
    ActualTime: number
    UnitsPerCycle: number
    WorkCenterID: guid
    WorkCenterName: string
    OperationType: string
    WorkCenterCode: string
    StartDate: date
    EndDate: date
    DueDate: null
    IsDropShip: boolean
    IsBackflush: boolean
    Components: [
      RunComponentID: guid
      ProductID: guid
      ProductName: string
      ProductCode: string
      Quantity: number
      ExpectedQuantity: number
      WastageQty: number
      WastagePercent: number
      BatchSN: string
      ExpiryDate: null
      UnitCost: number
      LocationID: guid
      LocationName: string
      ProductCost: number
      Available: number
      CostingMethod: null
      Unit: string
      ReservedQuantity: number
      IsReserved: boolean
      IsBackflush: boolean
    ]
    Resources: [
      ResourceID: guid
      ResourceName: string
      ResourceCode: string
      UnitCost: number
      Quantity: number
      Cost: number
      CycleTime: number
      Available: number
    ]
    ResourceCosts: [
      RunCostID: guid
      ProductID: guid
      ProductName: string
      AccountName: string
      ExpenseAccount: string
      Comments: null
      Cost: number
    ]
    FinishedProducts: []
    OutputProducts: []
    InputProducts: []
    CoManTasks: []
    CoManTaskLines: []
    Attachments: [
      AttachmentID: guid
      FileName: string
      Date: date
      ContentType: string
      Content: string
      Position: number
    ]
    Notes: []
    SuspendReason: null
    CoManStatus: null
    ManualStartDate: date
    ManualEndDate: date
  ]
  Output: []
  PendingOutput: []
  ManualJournals: []
]
```

### GET `/production/resourceList`

| Parameter | Type | Required |
|---|---|---|
| `Page` | number |  |
| `Limit` | number |  |
| `Name` | string |  |
| `OnlyActive` | boolean |  |

Response 200:

```text
Resources: [
  ResourceID: guid
  IsInfinite: boolean
  IsAllowAllCapacityUsage: boolean
  IsAvailableOnHolidays: boolean
  IsAvailableOnWeekends: boolean
  IsActive: boolean
  Code: string
  Name: string
  Tags: string
  ResourceType: string
  CycleDuration: number
]
```

### GET `/production/resource`

| Parameter | Type | Required |
|---|---|---|
| `ResourceID` | Guid | yes |
| `IncludeAttachments` | boolean |  |

Response 200:

```text
ResourceID: guid
IsInfinite: boolean
IsAllowAllCapacityUsage: boolean
IsAvailableOnHolidays: boolean
IsAvailableOnWeekends: boolean
IsActive: boolean
Code: string
Name: string
Tags: string
ResourceType: string
CycleDuration: number
ResourceCapacities: [
  LocationID: guid
  LocationName: string
  ResourceQuantity: number
  NonOperationalFrom: null
  NonOperationalTo: null
  CustomWorkingDays: [
    DayOfWeek: string
    StartTime: number
    EndTime: number
    BreakStartTime: number
    BreakEndTime: number
    Capacity: number
  ]
  ResourceUnits: [
    Name: string
    NonOperationalFrom: null
    NonOperationalTo: null
    OperationalFrom: null
    OperationalTo: null
  ]
]
ResourceCosts: [
  ResourceCostID: guid
  ProductID: guid
  ProductName: string
  AccountCode: string
  Cost: number
  PriceTier: number
]
ResourceRemarks: [
  RemarkID: guid
  Remark: string
  CreatedDate: date
]
ResourceAttachments: [
  AttachmentID: guid
  FileName: string
  Date: date
  ContentType: string
  Content: string
]
```

### POST `/production/resource`

Request body:

```text
Resources: [
  IsInfinite: boolean
  IsAllowAllCapacityUsage: boolean
  IsAvailableOnHolidays: boolean
  IsAvailableOnWeekends: boolean
  IsActive: boolean
  Code: string
  Name: string
  Tags: string
  ResourceType: string
  CycleDuration: number
  ResourceCapacities: [
    LocationID: guid
    NonOperationalFrom: null
    NonOperationalTo: null
    CustomWorkingDays: [
      DayOfWeek: string
      StartTime: number
      EndTime: number
      BreakStartTime: number
      BreakEndTime: number
      Capacity: number
    ]
    ResourceUnits: [
      Name: string
      NonOperationalFrom: null
      NonOperationalTo: null
      OperationalFrom: null
      OperationalTo: null
    ]
  ]
  ResourceCosts: [
    ProductID: guid
    AccountCode: string
    PriceTier: number
  ]
  ResourceRemarks: [
    Remark: string
  ]
  ResourceAttachments: [
    FileName: string
    Content: string
  ]
]
```

Response 200:

```text
Resources: [
  ResourceID: guid
  IsInfinite: boolean
  IsAllowAllCapacityUsage: boolean
  IsAvailableOnHolidays: boolean
  IsAvailableOnWeekends: boolean
  IsActive: boolean
  Code: string
  Name: string
  Tags: string
  ResourceType: string
  CycleDuration: number
  ResourceCapacities: [
    LocationID: guid
    LocationName: string
    ResourceQuantity: number
    NonOperationalFrom: null
    NonOperationalTo: null
    CustomWorkingDays: [
      DayOfWeek: string
      StartTime: number
      EndTime: number
      BreakStartTime: number
      BreakEndTime: number
      Capacity: number
    ]
    ResourceUnits: [
      Name: string
      NonOperationalFrom: null
      NonOperationalTo: null
      OperationalFrom: null
      OperationalTo: null
    ]
  ]
  ResourceCosts: [
    ResourceCostID: guid
    ProductID: guid
    ProductName: string
    AccountCode: string
    Cost: number
    PriceTier: number
  ]
  ResourceRemarks: [
    RemarkID: guid
    Remark: string
    CreatedDate: date
  ]
  ResourceAttachments: [
    AttachmentID: guid
    FileName: string
    Date: date
    ContentType: string
    Content: string
  ]
]
```

### PUT `/production/resource`

Request body:

```text
IsInfinite: boolean
IsAllowAllCapacityUsage: boolean
IsAvailableOnHolidays: boolean
IsAvailableOnWeekends: boolean
IsActive: boolean
Code: string
Name: string
Tags: string
ResourceType: string
CycleDuration: number
ResourceCapacities: []
ResourceCosts: []
ResourceRemarks: []
ResourceAttachments: []
```

Response 200:

```text
IsInfinite: boolean
IsAllowAllCapacityUsage: boolean
IsAvailableOnHolidays: boolean
IsAvailableOnWeekends: boolean
IsActive: boolean
Code: string
Name: string
Tags: string
ResourceType: string
CycleDuration: number
ResourceCapacities: []
ResourceCosts: []
ResourceRemarks: []
ResourceAttachments: []
```

### DELETE `/production/resource`

| Parameter | Type | Required |
|---|---|---|
| `ResourceID` | Guid | yes |

Response 200:

```text
IsInfinite: boolean
IsAllowAllCapacityUsage: boolean
IsAvailableOnHolidays: boolean
IsAvailableOnWeekends: boolean
IsActive: boolean
Code: string
Name: string
Tags: string
ResourceType: string
CycleDuration: number
ResourceCapacities: []
ResourceCosts: []
ResourceRemarks: []
ResourceAttachments: []
```

### GET `/production/suspendReason`

| Parameter | Type | Required |
|---|---|---|
| `Page` | number |  |
| `Limit` | number |  |
| `WorkcenterID` | guid |  |

Response 200:

```text
SuspendReasons: [
  SuspendReasonID: guid
  Reason: string
  Workcenters: [guid]
]
```

### PUT `/production/suspendReason`

Request body:

```text
keys: Reason, Workcenters
```

Response 200:

```text
SuspendReasonID: guid
Reason: string
Workcenters: [guid]
```

### GET `/production/workcenters`

| Parameter | Type | Required |
|---|---|---|
| `Page` | number |  |
| `Limit` | number |  |
| `Name` | string |  |

Response 200:

```text
keys: CoManProcurementType, Code, ID, IsActive, IsCoMan, IsCoManPurchase, LocationID, LocationName, Name, ParentLocationID, ParentLocationName, SupplierID, SupplierName, Type, WorkCenterID, WorkCenterLocations, WorkCenterSuppliers, Workcenters
```

### POST `/production/workcenters`

Request body:

```text
Workcenters: [
  WorkCenterID: string
  Code: string
  Name: string
  IsActive: boolean
  IsCoMan: boolean
  IsCoManPurchase: boolean
  SupplierID: guid
  SupplierName: string
  WorkCenterLocations: [
    ID: string
    WorkCenterID: guid
    LocationID: guid
    LocationName: string
    ParentLocationID: null
    ParentLocationName: null
    Type: string
  ]
  CoManProcurementType: string
  WorkCenterSuppliers: []
]
```

Response 200:

```text
Workcenters: [
  WorkCenterID: guid
  Code: string
  Name: string
  IsActive: boolean
  IsCoMan: boolean
  IsCoManPurchase: boolean
  SupplierID: guid
  SupplierName: string
  WorkCenterLocations: [
    ID: guid
    WorkCenterID: guid
    LocationID: guid
    LocationName: string
    ParentLocationID: null
    ParentLocationName: null
    Type: string
  ]
  WorkCenterSuppliers: []
  CoManProcurementType: string
]
```

### PUT `/production/workcenters`

Request body:

```text
Workcenters: [
  WorkCenterID: guid
  Code: string
  Name: string
  IsActive: boolean
  IsCoMan: boolean
  IsCoManPurchase: boolean
  SupplierID: guid
  SupplierName: string
  WorkCenterLocations: []
  CoManProcurementType: string
]
```

Response 200:

```text
WarningMessage: string
Workcenters: [
  WorkCenterID: guid
  Code: string
  Name: string
  IsActive: boolean
  IsCoMan: boolean
  IsCoManPurchase: boolean
  SupplierID: guid
  SupplierName: string
  WorkCenterLocations: []
  CoManProcurementType: null
]
```

### DELETE `/production/workcenters`

| Parameter | Type | Required |
|---|---|---|
| `WorkCenterId` | Guid | yes |

