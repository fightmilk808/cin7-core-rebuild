# Production

Manufacturing: production BOMs and operations, production orders and runs, the production scheduler, capacity planner, MRP scheduler, resources and work centres, the factory calendar, assemblies (finished goods), disassemblies, job costing and inventory write-offs.

| | Count |
|---|---:|
| Pages | 16 |
| Data models | 142 (plus [shared](../00-shared/README.md)) |
| Internal endpoints | 205 (68 write) |
| Public API operations | 66 |

## How to rebuild it

1. **Schema.** Create one table per data model below (142), starting from the generated [`schema.sql`](schema.sql). Ids are GUIDs; join on the `*ID` fields.
2. **Internal API.** Implement each controller's endpoints with the verbs listed, following the [internal API contract](../../docs/INTERNAL-API.md): one URL per store for GET/POST/PUT/DELETE, paged reads returning `{root, total}`, saves wrapped as `{ID, HasErrors, Original, Updated}`.
3. **Pages.** Build each route below as a server-rendered shell that loads the shell bundle and the page's own app, opening a record from `#<guid>` once at load ([page model](../../docs/ARCHITECTURE.md#what-a-page-is)).
4. **Public API.** Expose the 66 operations below under `/ExternalApi/v2` with header auth ([public API contract](../../docs/PUBLIC-API.md)).

## Pages

| Route | Menu label | Title | Bundle | Endpoints (write) |
|---|---|---|---|---:|
| `/CapacityPlanner` | Capacity Planner | Capacity Planner | `CapacityPlanner` | 6 (2) |
| `/Disassembly` | Disassembly | Disassembly | `Disassembly2019` | 12 (6) |
| `/DisassemblyList` | Disassemblies | Disassemblies | `DisassemblyList2019` | 1 (0) |
| `/FinishedGoods` | Assembly | Assemblies | `Assembly2019` | 27 (10) |
| `/FinishedGoodsList` | Assemblies | Assemblies | `FinishedGoodsList2019` | 2 (0) |
| `/IssueToProduction` | Inventory write-off | Inventory write-off | `IssueToProduction2019` | 18 (8) |
| `/IssueToProductionList` | Inventory write-offs | Inventory write-off list | `IssueToProductionList2019` | 1 (0) |
| `/JobCosting` | Job | Job details | `JobCosting2019` | 17 (7) |
| `/JobCostingList` | Jobs | Job costings | `JobCostingList2019` | 2 (0) |
| `/MRPScheduler` | MRP scheduler | MRP Scheduler | `MRPScheduler` | 17 (2) |
| `/ProductionCalendar` | Factory calendar | Factory Calendar | `ProductionCalendar` | 4 (3) |
| `/ProductionOrder` | Production order | Production order | `Customization2019 ProductionOrder` | 40 (20) |
| `/ProductionOrders` | Production orders | Production orders list | `ProductionOrdersList` | 13 (9) |
| `/ProductionResource` | Production resource | Production resource | `ProductionResource` | 8 (4) |
| `/ProductionScheduler` | Scheduler | Scheduler | `Scheduler` | 11 (9) |
| `/ProductionSetup` | Setup | Setup | `ProductionSetup` | 8 (5) |

## Data models

ExtJS models the pages use; `v` prefix = view-model. Full DDL in [`schema.sql`](schema.sql).

| Model | Fields |
|---|---|
| `AccessPermission` | Name:string, Title:string |
| `BOMWrapper` | ID:string |
| `BatchSNModel` | BatchSN:string, DisplayName:string |
| `BatchSerialAndExpiryDate` | FakeID:string, OrderNumber:string, RunNumber:string, BatchSerial:string, ExpiryDate:date |
| `CodeName` | Code:int, Name:string |
| `ComponentLineUploadError` | ValidationState:string, ValidationText:string, Line:int, SKU:string, SKUError:string, Bin:string, BinError:string, BatchSN:string, BatchSNError:string, ExpiryDate:string, ExpiryDateError:string, ExpenseAccount:string, ExpenseAccountError:string, Quantity:float, QuantityError:string, Cost:float, CostError:string, Available:float, TotalCost:float |
| `ComponentProductReplacement` | FakeKey:string, ProductID:string, ProductCode:string, Name:string, Available:float, Cost:float, CostingMethod:string, Type:string, ExpenseAccount:string, Unit:string |
| `DisassemblyComponentsSelect` | ProductID:string, ProductCode:string, Name:string, DisplayName:string, InventoryAccount:string, CostingMethod:string, Unit:string, DefaultLocation:string, NonInventory:bool |
| `DisassemblyProductSelect` | ProductID:string, ProductCode:string, Name:string, DisplayName:string, QuantityToProduce:float, AccountCode:string, CostingMethod:string, AssemblyInstructionURL:string |
| `DisassemblyServicesSelect` | ProductID:string, Name:string, ExpenseAccount:string |
| `DisassemblyWrapper` | ID:string, HasErrors:bool |
| `Disassembly_LoadBOM_Components` | ID:string, ProductID:string, Quantity:float, CostPercentage:float, ProductCode:string, Name:string, CostingMethod:string, Account:string, Unit:string, BinID:string, NonInventory:bool |
| `Disassembly_LoadBOM_Services` | ID:string, ProductID:string, Amount:float, Name:string, Account:string |
| `FinishedGoodsBatch` | FakeKey:string, BatchSN:string, Available:float, ExpiryDate:date, Cost:float, BinID:string, BinName:string, LocationName:string |
| `FinishedGoodsWrapper` | ID:int, HasErrors:bool, PickRecommendationWarning:string |
| `FinishedProductBatchSN` | FakeID:string, TraceabilityID:string, RunID:string, ProductID:string, DisplayName:string, BatchSN:string, ExpiryDate:date, CostingMethod:string, ValidationState:string, ValidationText:string |
| `InvoicingMilestone` | ID:string, Name:string |
| `IssueToProductionWrapper` | ID:int, HasErrors:bool |
| `JobCostingInfo` | Code:string, DisplayName:string, JobID:string |
| `JobCostingWrapper` | ID:int, HasErrors:bool, IsCreatedByRMA:bool |
| `Location` | LocationID:string, Description:string |
| `OrderReferenceData` | ID:int, ProductionOrderPermission:string, FulfillmentPermission:string, EditCompletedOperationsPermission:string, ProductionFinancialDataPermission:string, InventoryControlAccount:string, WipAccount:string, MOProduce:string, MOStatus:string, MOWastageType:string, MOWastageExpenseAccount:string, UndoPermission:string, VoidPermission:string, CurrentAttributeSet:string, MOTraceFinishedProduct:int, UseBackdatedTransaction:bool |
| `OrderWrapper` | ID:string, AllowReschedule:bool, HasErrors:bool, Lang:string |
| `PriceTiers` | Code:int, Name:string |
| `ProductModel` | ProductID:string, DisplayName:string |
| `ProductionOrderSourceTask` | ProductionOrderID:string, SourceTaskID:string, SourceTaskNumber:string, SourceTaskType:int, SourceType:string, IsVoided:bool |
| `ProductionRunAutoPickWrapper` | FakeKey:string, Warning:string |
| `ProductionRunRelatedOrdersModel` | TaskID:int, OrderNumber:string |
| `ReferenceData` | ID:string |
| `ReservedComponent` | FakeID:string, ProductName:string, OperationName:string, LocationName:string, BatchSN:string, ExpiryDate:date, Available:float, OnOrder:float, Reserved:float |
| `ResourceReferenceData` | ID:int |
| `ResourceWrapper` | ID:string, AllowReschedule:bool, HasErrors:bool |
| `SalePickerModel` | UserID:string, Email:string |
| `Status` | Value:string, Name:string |
| `WarehouseLocation` | LocationID:string, LocationName:string |
| `WorkCenterWrapper` | FakeID:string, HasErrors:boolean, Errors:string, CustomersCreated:string, WarningMessage:string |
| `YieldLineUploadError` | ValidationState:string, ValidationText:string, Line:int, SKU:string, SKUError:string, Name:string, NameError:string, BatchSerialNumber:string, BatchSerialNumberError:string, ExpiryDate_YYYYMMDD:string, ExpiryDate_YYYYMMDDError:string, Quantity:string, QuantityError:string, Location:string, LocationError:string, DateReceived_YYYYMMDD:string, DateReceived_YYYYMMDDError:string |
| `vCapacityPlannerDetailsRecord` | FakeID:string, ProductionOrderID:string, ProductionOrderNumber:string, LocationID:string, LocationName:string, ResourceID:string, ResourceCode:string, ResourceName:string, ReleaseDate:date, StartDate:date, Status:string, Type:int, RequiredByDate:date, DueDate:date, UnitQuantity:float, Capacity:int, SaleTaskID:string, SaleOrderNumber:string, CustomerName:string, CustomerContact:string, CustomerEmail:string, SalesRepresentative:string, ProductCode:string, ProductName:string, ValidationState:string, ValidationText:string |
| `vCapacityPlannerRecord` | FakeID:string, LocationID:string, LocationName:string, ResourceID:string, ResourceCode:string, ResourceName:string, TotalCapacity:int, AllocatedCapacity:int, AvailableCapacity:int, ConsumedCapacity:int, IsFirstRow:boolean, IsLastRow:boolean, AllocatedPlanned:int, AllocatedReleased:int |
| `vCustomerAddress` | CustomerID:string, AddressID:string, Line1:string, Line2:string, CitySuburb:string, StateProvince:string, ZipPostCode:string, Country:string, Type:string, DefaultForType:bool |
| `vCustomerContact` | CustomerID:string, ContactID:string, Name:string, JobTitle:string, Phone:string, MobilePhone:string, Fax:string, Email:string, Website:string, IsDefault:bool, Comment:string |
| `vDisassemblyComponents` | FakeID:int, ID:string, TaskID:string, ProductID:string, BinID:string, Quantity:float, Account:string, Cost:float, BatchSN:string, ExpiryDate:date, ProductCode:string, Name:string, CostingMethod:string, Unit:string, NonInventory:bool, ValidationText:string, ValidationState:string |
| `vDisassemblyList` | TaskID:string, DisassemblyNumber:string, ProductCode:string, Date:date, Name:string, Quantity:float, Location:string, Status:string, Notes:string |
| `vDisassemblyPicking` | FakeID:int, ID:string, CardID:string, TaskID:string, Quantity:float, Date:date, UnitCost:float, BatchSN:string, ExpiryDate:date, Available:float, Cost:float, IsLocked:bool, Bin:string, ValidationText:string, ValidationState:string |
| `vDisassemblyServices` | FakeID:int, ID:string, ProductID:string, TaskID:string, Amount:float, Account:string, Comments:string, Name:string, ValidationText:string, ValidationState:string |
| `vDisassemblyTask` | TaskID:string, DisassemblyNumber:string, Status:string, LocationID:string, ProductID:string, Quantity:float, ProductCode:string, Name:string, BatchSN:string, WIPDate:date, CompletionDate:date, Date:date, CostingMethod:string, WIPAccount:string, QuantityToProduce:float, AssemblyInstructionURL:string, Notes:string, ValidationText:string, ValidationState:string |
| `vDisassemblyTaskFile` | FileID:string, FinishedGoodsID:string, FileName:string, ContentType:string, UserName:string, UploadedDate:date, ExternalDownloadLink:string, ExternalViewLink:string |
| `vDistributedAmount` | ID:string, TaskID:string, TaskType:string, ValidationText:string, ValidationState:string |
| `vDistributedAmountAccount` | AccountCode:string, AccountAmount:float, AccountName:string, DistributedAmount:float |
| `vDocumentAccount` | AccountCode:string, AccountAmount:float, AccountName:string |
| `vFinishedGoodsComponent` | FakeID:int, ComponentID:string, TaskID:string, ProductID:string, BinID:string, BinName:string, Quantity:float, TotalQuantity:float, WastageQuantity:float, WastagePercent:float, Available:float, Cost:float, Name:string, ProductCode:string, BatchSN:string, ExpiryDate:date, CostingMethod:string, PriceTier:int, ExpenseAccount:string, Type:string, ValidationText:string, ValidationState:string, Unit:string, NonInventory:bool |
| `vFinishedGoodsFile` | FileID:string, FinishedGoodsID:string, FileName:string, ContentType:string, UserName:string, UploadedDate:date, ExternalDownloadLink:string, ExternalViewLink:string |
| `vFinishedGoodsList` | TaskID:string, AssemblyNumber:string, ProductCode:string, SysDate:date, Name:string, Quantity:float, Location:string, Status:string, BatchSN:string, ExpiryDate:date, UnitCost:float, Notes:string, CompletionDate:date, CustomField1:string, CustomField2:string, CustomField3:string, CustomField4:string, CustomField5:string, CustomField6:string, CustomField7:string, CustomField8:string, CustomField9:string, CustomField10:string |
| `vFinishedGoodsManualJournals` | FakeID:int, TaskID:string, ID:string, Reference:string, Amount:float, Date:date, Debit:string, Credit:string, ValidationText:string, ValidationState:string |
| `vFinishedGoodsOrder` | FakeID:int, ComponentID:string, ProductID:string, TaskID:string, Quantity:float, TotalQuantity:float, WastageQuantity:float, WastagePercent:float, Available:float, Cost:float, TotalCost:float, Name:string, ProductCode:string, CostingMethod:string, PriceTier:int, ExpenseAccount:string, Type:string, ValidationText:string, ValidationState:string, Unit:string |
| `vFinishedGoodsTask` | TaskID:string, AssemblyNumber:string, Status:string, LocationID:string, LocationName:string, ProductID:string, BinID:string, BinName:string, Quantity:float, ProductCode:string, Name:string, BatchSN:string, ExpiryDate:date, WIPDate:date, CompletionDate:date, CostingMethod:string, Type:string, Account:string, WIPAccount:string, TaskType:string, QuantityToProduce:float, AssemblyInstructionURL:string, Notes:string, CountrySpecificKey:string, CountrySpecificData:string, ValidationText:string, ValidationState:string, NonInventory:bool, JobID:string, JobMilestoneID:string, CustomField1:string, Custo… |
| `vInventoryWriteOffAttachment` | FinishedGoodsID:string, FileID:string, ContentType:string, FileName:string, UploadedDate:date, UserName:string, ExternalDownloadLink:string, ExternalViewLink:string |
| `vIssueToProductionList` | TaskID:string, AssemblyNumber:string, Date:date, Location:string, Status:string, Notes:string |
| `vJobCosting` | JobID:string, JobNumber:string, CustomerID:string, Name:string, AddressLine1:string, AddressLine2:string, AccountCode:string, Contact:string, Comments:string, Status:string, StartDate:date, CompletedDate:date, EstimatedValue:float, BudgetedMargin:float, AttributeSet:string, CustomField1:string, CustomField2:string, CustomField3:string, CustomField4:string, CustomField5:string, CustomField6:string, CustomField7:string, CustomField8:string, CustomField9:string, CustomField10:string, ProjectManager:string, TaxRuleID:string, Phone:string, AutoInvoice:bool, Frequency:string, NextInvoiceDate:date, … |
| `vJobCostingAllAttachements` | AttachementID:string, FileName:string, UserName:string, Date:date, AttachmentType:string, MileStoneName:string |
| `vJobCostingAttachement` | AttachementID:string, FileName:string, UserName:string, Date:date |
| `vJobCostingLinkingSale` | TaskID:string, SaleOrderNumber:string |
| `vJobCostingMilestone` | FakeID:int, ID:string, JobID:string, Name:string, Description:string, DateEstimated:date, DateActual:date, Status:string, LinksCount:int, ValidationText:string, ValidationState:string |
| `vJobCostingNote` | FakeID:int, ID:string, JobID:string, Category:string, Note:string, Date:date, Username:string, ValidationText:string, ValidationState:string |
| `vJobCostingSales` | TaskID:string, SaleOrderNumber:string, InvoiceNumber:string, Milestone:string, InvoiceDate:date, ExpenseAmount:float, SaleAmount:float, BudgetedAmount:float, SaleControllerName:string |
| `vJobCostingUnallocatedExpenses` | ExpenseTaskID:string, Type:string, TaskNumber:string, Date:date, ExpenseAmount:float, InvoicingAmount:float, MilestoneID:string, MilestoneName:string, Selected:bool |
| `vJobCostingUnauthorisedSales` | TaskID:string, JobID:string, JobNumber:string, JobName:string, Milestone:string, Amount:float, SaleOrderNumber:string, InvoiceNumber:string, SaleOrderDate:date |
| `vJobMilestone` | ID:string, Name:string |
| `vLogisticsPath` | PathID:string, WarehouseLocationID:string, ShopFloorLocationID:string, RetailLocationID:string |
| `vPlannedOperation` | ID:string, ProductionOrderID:string, OperationName:string, OperationOrder:int, OperationStatus:string, WorkCenterID:string, CycleTime:int, ActualTime:int, FromDate:date, ToDate:date, OperationID:string |
| `vProductCost` | ProductID:string, ProductName:string, ProductCode:string, Cost:string, ExpenseAccount:string |
| `vProductionBom` | BomID:string, ProductID:string, OutputQuantity:float, BufferPercent:float, InstructionUrl:string, IssueMethod:int, IssueMethodComponent:int, IssueMethodParameter:int, IgnoreCumulativeLeadTime:boolean, ComponentProductionLeadTime:int, Version:int, Name:string, IsDefault:boolean, CreatedDate:date, CreatedBy:string, DeliveryTo:string, IsTracing:bool, MinQuantity:float, MaxQuantity:float, DeviationPercent:float, RunSize:float, ValidationState:string, ValidationText:string |
| `vProductionBomVersion` | Version:int, BomID:string, Name:string, IsDefault:bool, DisplayName:string |
| `vProductionCalendar` | CalendarID:string, Year:int, WeekStart:int, ValidationState:string, ValidationText:string |
| `vProductionCalendarDay` | DayID:string, CalendarID:string, DayOfWeek:int, IsWeekend:boolean, StartTime:int, EndTime:int, StartTimeStr:string, EndTimeStr:string, BreakStartTime:int, BreakEndTime:int, BreakStartTimeStr:string, BreakEndTimeStr:string, SortOrder:int, ValidationState:string, ValidationText:string |
| `vProductionCalendarSpecialDay` | DayID:string, CalendarID:string, Date:date, IsWeekend:boolean, IsHoliday:boolean, StartTime:int, EndTime:int, StartTimeStr:string, EndTimeStr:string, BreakStartTime:int, BreakEndTime:int, BreakStartTimeStr:string, BreakEndTimeStr:string, Comment:string, ValidationState:string, ValidationText:string |
| `vProductionComponentBin` | FakeKey:string, BatchSN:string, Quantity:float, ExpiryDate:date, Cost:float, BinID:string, BinName:string |
| `vProductionOperationAttachment` | AttachmentID:string, OperationID:string, FileName:string, Date:date, ContentType:string, BlobGuid:string, Position:int, IsCloned:bool, FromBOM:bool, ProductAttachmentID:string, ValidationState:string, ValidationText:string |
| `vProductionOperationItem` | ItemID:string, OperationID:string, Type:string, Value:string, ResourceID:string, ResourceName:string, ResourceCode:string, Quantity:float, ProductID:string, ProductName:string, ProductSku:string, WastageQty:float, WastagePercent:float, AttachmentFileName:string, AttachmentDate:date, AttachmentContentType:string, AttachmentBlobGuid:string, Note:string, Cost:float, CostingMethod:string, CycleTime:int, ValidationState:string, ValidationText:string, TotalCost:float, Position:int, Unit:string, WastageCost:int, SalePriceTier:int, PriceTier1:float, PriceTier2:float, PriceTier3:float, PriceTier4:floa… |
| `vProductionOrder` | ProductionOrderID:string, ProductID:string, ProductCode:string, ProductName:string, OrderNumber:string, LocationID:string, LocationName:string, OrderStatus:string, Status:string, Source:int, MakeToOrderConfigurationID:string, WIPAccount:string, Account:string, Quantity:float, BomQuantity:float, CapacityCalType:int, StartDate:date, RequiredByDate:date, ReleaseDate:date, CompletionDate:date, MaxQuantityCalculated:string, IsIgnoreLeadTime:bool, IsMakeToOrderBomProduct:bool, WarehouseID:string, RetailID:string, QuantityInProduction:float, QuantityRemained:float, QuantityPutAway:float, QuantityCom… |
| `vProductionOrderAttachment` | AttachmentID:string, ProductionOrderID:string, FileName:string, Date:date, ContentType:string, BlobGuid:string, UserName:string, IsProcessed:boolean, ValidationState:string, ValidationText:string, Position:int, AttachmentFrom:string, ExternalDownloadLink:string, ExternalViewLink:string |
| `vProductionOrderAvailabilityItem` | FakeID:string, ProductID:string, LocationID:string, LocationName:string, Quantity:float, OnOrder:float |
| `vProductionOrderComponent` | OrderComponentID:string, OperationID:string, ProductID:string, ProductName:string, ProductSku:string, ProductType:string, Quantity:float, TotalQuantity:float, TotalWastageQty:float, WastageQty:float, WastagePercent:float, ProductCost:float, TotalCost:float, Cost:float, Available:float, CostingMethod:string, ValidationState:string, ValidationText:string, Position:int, Unit:string, SalePriceTier:int, IsAlternative:bool, IsReverted:bool, PriceTier1:float, PriceTier2:float, PriceTier3:float, PriceTier4:float, PriceTier5:float, PriceTier6:float, PriceTier7:float, PriceTier8:float, PriceTier9:float… |
| `vProductionOrderConfiguration` | ProductionOrderConfigurationID:string, OperationID:string, Configuration:string, ValidationState:string, ValidationText:string, Position:int |
| `vProductionOrderDeliveryTo` | FakeID:string, ID:string, ProductionOrderID:string, ProductID:string, LocationID:string, ProductName:string, ProductUnit:string, SaleTaskID:string, SaleOrderNumber:string, ValidationState:string, ValidationText:string |
| `vProductionOrderList` | TaskID:string, ProductionOrderID:string, Type:string, ProductID:string, ProductCode:string, ProductName:string, OrderNumber:string, LocationID:string, LocationName:string, Status:string, Quantity:float, StartDate:date, RequiredByDate:date, ReleaseDate:date, CompletionDate:date, TimeStatus:string, ResourceStatus:string, InventoryStatus:string, OrderStatus:string, CapacityCalType:integer, Comments:string, Tags:string, IsSourceTaskVoided:bool, IsBatchSnExists:bool, CustomField1:string, CustomField2:string, CustomField3:string, CustomField4:string, CustomField5:string, CustomField6:string, Custom… |
| `vProductionOrderNote` | NoteID:string, OperationID:string, Note:string, ValidationState:string, ValidationText:string, Position:int |
| `vProductionOrderOperation` | OperationID:string, ProductionOrderID:string, Order:int, Name:string, CycleTime:int, CycleTimeString:string, TotalCycleTime:int, TotalCycleTimeString:string, UnitsPerCycle:float, TotalUnitsPerCycle:float, WorkCenterID:string, WorkCenterName:string, WorkCenterCode:string, WorkCenterCoManProcurementType:string, TotalCost:float, OperationType:int, OperationRelationIDsFake:auto, ComponentLocationID:string, IsDropShip:bool, IsBackflush:bool, ValidationState:string, ValidationText:string |
| `vProductionOrderOperationLink` | ID:string, OperationID:string, RelatedOperationID:string, RelationType:int, ValidationState:string, ValidationText:string |
| `vProductionOrderOperationProduct` | ID:string, OperationID:string, ProductID:string, ProductName:string, ProductSku:string, Type:int, CostCalculationType:int, PriceTier:int, Ratio:float, OutputQuantity:float, TotalOutputQuantity:float, AverageCost:float, CostingMethod:string, FixedCost:float, Position:int, Unit:string, Cost:float, TotalCost:float, Formula:string, WastageCost:int, IsTracing:bool, ValidationState:string, ValidationText:string |
| `vProductionOrderResource` | OrderResourceID:string, OperationID:string, ResourceID:string, ResourceName:string, ResourceCode:string, ResourceCost:float, Quantity:float, CycleTime:int, TotalCost:float, Cost:float, Available:float, ValidationState:string, ValidationText:string, Position:int, CostCalculationType:int |
| `vProductionOrderSourceTask` | SourceTaskID:string, SourceTaskNumber:string, ProductionOrderID:string, SourceType:string |
| `vProductionOrderSplit` | ProductionOrderID:string, Number:string, Quantity:float, RemainingQuantity:float, ValidationState:string, ValidationText:string |
| `vProductionResource` | ResourceID:string, Name:string, Code:string, Tags:string, IsInfinite:bool, IsAllowAllCapacityUsage:bool, IsAvailableOnHolidays:bool, IsAvailableOnWeekends:bool, CycleDuration:int, CycleDurationStr:string, IsActive:bool, Type:int, ResourceType:int, ValidationState:string, ValidationText:string |
| `vProductionResourceAttachment` | AttachmentID:string, ResourceID:string, Date:date, FileName:string, ContentType:string, BlobGuid:string, UserName:string, ExternalDownloadLink:string, ExternalViewLink:string, ValidationState:string, ValidationText:string |
| `vProductionResourceCapacity` | FakeID:string, ResourceCapacityID:string, ResourceID:string, LocationID:string, LocationName:string, ResourceQuantity:int, NonOperationalFrom:date, NonOperationalTo:date, HasCapacityHours:bool, CapacityHoursWeek:float, ValidationState:string, ValidationText:string |
| `vProductionResourceCapacityDay` | ResourceDayID:string, ResourceID:string, LocationID:string, DayOfWeek:int, StartTime:int, EndTime:int, StartTimeStr:string, EndTimeStr:string, BreakStartTime:int, BreakEndTime:int, BreakStartTimeStr:string, BreakEndTimeStr:string, Capacity:float, SortOrder:string, DefaultStart:int, DefaultEnd:int, DefaultBreakStart:int, DefaultBreakEnd:int, DefaultStartStr:string, DefaultEndStr:string, DefaultBreakStartStr:string, DefaultBreakEndStr:string, ValidationState:string, ValidationText:string |
| `vProductionResourceCost` | FakeID:string, ResourceCostID:string, ResourceID:string, ProductID:string, ProductName:string, AccountCode:string, Cost:float, PriceTier:int, PriceTier1:float, PriceTier2:float, PriceTier3:float, PriceTier4:float, PriceTier5:float, PriceTier6:float, PriceTier7:float, PriceTier8:float, PriceTier9:float, PriceTier10:float, PlannedDowntimeCost:float, PlannedDowntimePriceTier:int, NotPlannedDowntimeCost:float, NotPlannedDowntimePriceTier:int, ValidationState:string, ValidationText:string |
| `vProductionResourceProduct` | ProductID:string, ProductCode:string, ProductName:string, ImageID:string, Type:string |
| `vProductionResourceRemark` | FakeID:string, RemarkID:string, ResourceID:string, Remark:string, CreatedDate:date, CreatedBy:string, ValidationState:string, ValidationText:string |
| `vProductionResourceUnit` | FakeID:string, ResourceUnitID:string, ResourceID:string, LocationID:string, Name:string, NonOperationalFrom:date, NonOperationalTo:date, OperationalFrom:date, OperationalTo:date, ValidationState:string, ValidationText:string |
| `vProductionResources` | ResourceID:string, Code:string, Name:string, ResourceCost:float, CycleDuration:int |
| `vProductionRun` | RunID:string, ProductionOrderID:string, Number:int, Status:string, Quantity:float, WIPAccount:string, StartDate:date, EndDate:date, DueDate:date, ReceivedDate:date, ScheduleStart:date, ScheduleDue:date, WastageType:string, WastageExpenseAccount:string, IssueMethodParameter:int, ValidationState:string, ValidationText:string, IsBatchSnExists:bool, PurchaseFulfillmentTaskID:string, CustomField1:string, CustomField2:string, CustomField3:string, CustomField4:string, CustomField5:string, CustomField6:string, CustomField7:string, CustomField8:string, CustomField9:string, CustomField10:string |
| `vProductionRunCoManTask` | ID:string, OperationID:string, Type:int, TaskStatus:string, TaskNumber:string, SaleTaskID:string, PurchaseTaskID:string, TransferTaskID:string, CombinedReceivingStatus:string, CombinedPickingStatus:string, CombinedShippingStatus:string, CombinedInvoiceStatus:string, IsPurchaseDropShip:bool, IsServicePurchase:bool |
| `vProductionRunCoManTaskLine` | ID:string, OperationID:string, TaskID:string, TaskNo:string, ProductID:string, ProductCode:string, ProductName:string, ProductType:string, CostingMethod:string, Quantity:float, BatchSN:string, ExpiryDate:date, LocationID:string, LocationName:string, ReceivedDate:date, Cost:float, Type:string, Unit:string |
| `vProductionRunComponent` | RunComponentID:string, OperationID:string, ProductID:string, ProductName:string, ProductSku:string, ProductType:string, Quantity:float, WastageQty:float, WastagePercent:float, ProductCost:float, UnitCost:float, TotalCost:float, CostingMethod:string, BinID:string, BinName:string, BatchSN:string, ExpiryDate:date, Available:float, Unit:string, IsProductionBom:bool, ReservedQuantity:float, IsBackflush:bool, IsNotEnough:bool, ValidationState:string, ValidationText:string |
| `vProductionRunCost` | RunCostID:string, OperationID:string, ProductID:string, ProductName:string, ResourceID:string, ResourceName:string, AccountName:string, ExpenseAccount:string, Comments:string, Cost:float, ValidationState:string, ValidationText:string |
| `vProductionRunCreate` | Number:int, Quantity:float, RemainingQuantity:float, ValidationState:string, ValidationText:string |
| `vProductionRunManualJournal` | JournalID:string, ProductionRunID:string, Reference:string, Amount:float, Date:date, Debit:string, Credit:string, OperationID:string, OperationName:string, ValidationState:string, ValidationText:string |
| `vProductionRunOperation` | OperationID:string, ProductionRunID:string, Status:string, Order:int, Name:string, PlannedTime:int, PlannedTimeString:string, ActualTime:int, ActualTimeString:string, UnitsPerCycle:float, WorkCenterID:string, WorkCenterName:string, WorkCenterCode:string, WorkCenterCoManProcurementType:string, StartDate:date, EndDate:date, ActualStartDate:date, ActualEndDate:date, DueDate:date, TotalCost:float, OperationType:int, SourceOperationID:string, SuspendReason:string, DowntimeType:int, CoManStatus:string, IsDropShip:bool, IsBackflush:bool, ValidationState:string, ValidationText:string, ManualStartDate… |
| `vProductionRunOperationAttachment` | AttachmentID:string, RunOperationID:string, FileName:string, Date:date, ContentType:string, BlobGuid:string, Position:int, FromOrder:bool, ValidationState:string, ValidationText:string |
| `vProductionRunOperationNote` | NoteID:string, RunOperationID:string, Note:string, Position:int, ValidationState:string, ValidationText:string |
| `vProductionRunOperationNoteItem` | ItemID:string, Type:string, Value:string, OperationID:string, AttachmentFileName:string, AttachmentDate:date, AttachmentContentType:string, AttachmentBlobGuid:string, AttachmentID:string, OrderOperationAttachmentID:string, FromOrder:bool, NoteID:string, Note:string, Position:int |
| `vProductionRunOperationPrintSelectModel` | Selected:bool, Name:string, OperationID:string |
| `vProductionRunOperationProduct` | ID:string, OperationID:string, ProductID:string, Type:int, PlannedQuantity:float, OutputQuantity:float, WastageQuantity:float, LocationID:string, ProductName:string, ProductSku:string, Unit:string, LocationName:string, FixedWastageCost:float, BatchSN:string, ExpiryDate:date, ValidationState:string, ValidationText:string |
| `vProductionRunOutputLine` | ID:string, ProductionRunID:string, PutAwayID:string, WastageID:string, Quantity:float, WastageQuantity:float, LocationID:string, LocationName:string, BatchSN:string, ExpiryDate:date, ProductID:string, ProductCode:string, ProductName:string, CostingMethod:string, Unit:string, ReceivedDate:date, FixedCost:float, CostCalculationType:int, Received:bool, CardID:string, CardQuantity:float, UnitCost:float, IsPending:bool, CustomField1:auto, CustomField2:auto, CustomField3:auto, CustomField4:auto, CustomField5:auto, CustomField6:auto, CustomField7:auto, CustomField8:auto, CustomField9:auto, CustomFie… |
| `vProductionRunProductItem` | ID:string, ItemType:string, OperationProductType:int, OperationID:string, ProductID:string, ProductName:string, ProductSku:string, ProductType:string, PlannedQuantity:float, Quantity:float, WastageQuantity:float, ActualQuantity:float, ProductCost:float, UnitCost:float, TotalCost:float, CostingMethod:string, LocationID:string, LocationName:string, BatchSN:string, ExpiryDate:date, Available:float, Unit:string, ReceivedDate:date, CostCalculationType:int, IsProductionBom:bool, IsReserved:bool, IsBackflush:bool, ReservedQuantity:float, IsNotEnough:bool, ValidationState:string, ValidationText:string |
| `vProductionRunPutAway` | ID:string, ProductionRunID:string, Quantity:float, LocationID:string, LocationName:string, BatchSN:string, ExpiryDate:date, ProductID:string, ProductCode:string, ProductName:string, CostingMethod:string, Unit:string, ReceivedDate:date, FixedCost:float, CostCalculationType:int, Received:bool, CardID:string, CardQuantity:float, UnitCost:float, CustomField1:string, CustomField2:string, CustomField3:string, CustomField4:string, CustomField5:string, CustomField6:string, CustomField7:string, CustomField8:string, CustomField9:string, CustomField10:string, ValidationState:string, ValidationText:string |
| `vProductionRunResource` | RunResourceID:string, OperationID:string, ResourceID:string, ResourceName:string, ResourceCode:string, UnitCost:float, TotalCost:float, Quantity:float, CycleTime:int, Available:int, Cost:float, ValidationState:string, ValidationText:string |
| `vProductionRunTraceability` | TraceabilityID:string, RunID:string, ProducedProductID:string, ProducedProductBatchSN:string, ProducedProductExpiryDate:date, ProducedProductDisplayName:string, UsedProductID:string, UsedProductBatchSN:string, UsedProductExpiryDate:date, UsedProductDisplayName:string, UsedFullBatchSN:string, IsPending:bool, ValidationState:string, ValidationText:string |
| `vPurchaseExpense` | TaskID:string, AccountCode:string, AccountName:string, Amount:float, Invoices:string, DistributedAmount:float, LeftToDistribute:float, Selected:bool |
| `vReportTemplate` | TemplateID:string, Name:string |
| `vResource` | ResourceID:string, Code:string, Name:string, IsSelected:boolean |
| `vRunComponent` | FakeKey:string, ProductID:string, ProductCode:string, Name:string, Available:float, Cost:float, CostingMethod:string, Type:string, ExpenseAccount:string, Unit:string, BatchSN:string, ExpiryDate:date, BinID:string, BinName:string, IsProductionBom:bool |
| `vRunResources` | FakeID:string, ResourceID:string, ResourceName:string, ResourceCode:string, ResourceCost:float, CycleDuration:int, Available:float |
| `vSaleOrder` | TaskID:string, SaleOrderNumber:string, ShipmentRequiredByDate:date, OrderLocationID:string |
| `vSaleTaskWmsOperator` | ID:string, TaskID:string, UserName:string, StartedPickDate:date |
| `vSchedulerLinks` | FakeID:string, Source:string, Target:string |
| `vSchedulerOperation` | OperationID:string, ProductionOrderID:string, OperationName:string, OperationOrder:int, OperationStatus:string, WorkCenterID:string, CycleTime:int, ActualTime:int, RunID:string, FromDateUtc:date, ToDateUtc:date, FromDate:date, ToDate:date, Duration:int, Progress:float |
| `vSchedulerOperationItem` | FakeID:string, OperationID:string, FromDateUtc:date, ToDateUtc:date, FromDate:date, ToDate:date, WorkCenterColorCode:string |
| `vSchedulerOperationResource` | FakeID:string, OperationID:string, ResourceID:string, Quantity:float |
| `vSchedulerOrderOperation` | OperationID:string, ProductionOrderID:string, OperationName:string, OperationOrder:int, OperationStatus:string, WorkCenterID:string, CycleTime:int, ActualTime:int, RunID:string, FromDateUtc:date, ToDateUtc:date, FromDate:date, ToDate:date, Duration:int |
| `vSchedulerRun` | RunID:string, ProductionOrderID:string, Number:int, Status:string, Quantity:float, WIPAccount:string, StartDate:date, EndDate:date, DueDate:date, ReceivedDate:date, ScheduleStart:date, ScheduleDue:date, ScheduleStartLocal:date, ScheduleDueLocal:date, BufferSize:int, LackOfComponents:boolean, RunRequiredByDate:date, Progress:float, ValidationState:string, ValidationText:string |
| `vServiceProduct` | ProductID:string, Name:string, PriceTear1:float, PriceTear2:float, PriceTear3:float, PriceTear4:float, PriceTear5:float, PriceTear6:float, PriceTear7:float, PriceTear8:float, PriceTear9:float, PriceTear10:float, ExpenseAccount:string |
| `vShopFloor` | LocationID:string, Description:string |
| `vSourceTask` | SourceTaskID:string, SourceOrderNumber:string, ShipmentRequiredByDate:date, Retail:string, RepID:string, RepName:string, SourceType:string |
| `vSuspendReasons` | Reason:string, DowntimeType:int, WorkCenterIDs:string |
| `vSuspendReasonsWrapper` | FakeID:string |
| `vUser` | UserName:string, LoweredUserName:string |
| `vWorkCenter` | WorkCenterID:string, Code:string, Name:string, IsCoMan:boolean, CoManProcurementType:string, IsCoManPurchase:boolean |
| `vWorkCenterLocation` | ID:string, WorkCenterID:string, LocationID:string, ParentLocationID:string, LocationName:string, Type:int |
| `vWorkCenterSupplier` | WorkCenterID:string, SupplierID:string, SupplierName:string |

## Internal endpoints

Grouped by controller. Effect: 🟢 read · 🟠 read + write at the same URL · 🔴 write. `api` = JSON under `/api/`, `mvc` = controller action.

### AccountingDimensions

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/AccountingDimensions_Index_RealDimensions` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |

### address

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/address` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | CountryCode countryCode |  |  |
| `/api/address/country/code` | api | GET | 🟢 read |  |  |  |
| `/api/address/details` | api | GET | 🟢 read |  |  |  |
| `/api/address/hasAccess` | api | GET | 🟢 read |  |  |  |

### Calendar

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/Calendar_Index_vProductionCalendar` | api | POST PUT REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | allowCapacityUpdate year |  |  |

### CapacityPlanner

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/CapacityPlanner_Index_CapacityDetails` | api | POST(read) | 🟢 read | LocationIDs ResourceIDs endDate startDate type |  | root |
| `/api/CapacityPlanner_Index_RePlan` | api | PUT | 🔴 write |  |  |  |
| `/api/CapacityPlanner_Index_ResourceCapacityRecords` | api | POST(read) | 🟢 read |  |  | root |
| `/api/CapacityPlanner_Index_vResources` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  | root |
| `/api/CapacityPlanner_Index_vSaleTask` | api | PUT | 🔴 write |  |  |  |

### DefaultFieldValues

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/DefaultFieldValues` | api | GET POST | 🟠 read + write | entityType |  |  |

### Disassembly

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/Disassembly/Cancel` | mvc | POST | 🔴 write | TaskID |  |  |
| `/Disassembly/DownloadFile` | mvc |  | 🟢 read | id |  |  |
| `/Disassembly/MaximumQuantityByProduct` | mvc |  | 🟢 read |  |  |  |
| `/Disassembly/MaximumQuantityByTask` | mvc |  | 🟢 read |  |  |  |
| `/Disassembly/Undo` | mvc | POST | 🔴 write | TaskID |  |  |
| `/Disassembly/Upload` | mvc | POST | 🔴 write |  |  |  |
| `/api/Disassembly_Index_Components` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ProductID |  |  |
| `/api/Disassembly_Index_LoadBOM` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | LocationID ProductID |  |  |
| `/api/Disassembly_Index_Pick` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Disassembly_Index_Products` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Disassembly_Index_Services` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Disassembly_Index_Transactions` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | id |  |  |
| `/api/Disassembly_Index_vDisassemblyTask` | api | POST PUT REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | id | HasErrors ID Original Updated |  |
| `/api/Disassembly_Index_vDisassemblyTaskFile` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | TaskID |  |  |

### DisassemblyList

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/DisassemblyList_Index_vDisassemblyList` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | filter search |  | root |

### ExpenseDestribution

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/ExpenseDestribution_ProductionForDistribution` | api |  | 🟢 read |  |  |  |
| `/api/ExpenseDestribution_PurchaseForDistribution` | api |  | 🟢 read |  |  |  |
| `/api/ExpenseDestribution_TaskForDistribution` | api |  | 🟢 read |  |  |  |

### FinishedGoods

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/FinishedGoods/Cancel` | mvc | POST | 🔴 write | TaskID |  |  |
| `/FinishedGoods/CountrySpecific` | mvc |  | 🟢 read | Key |  |  |
| `/FinishedGoods/DownloadFile` | mvc |  | 🟢 read | id |  |  |
| `/FinishedGoods/MaximumQuantityByProduct` | mvc |  | 🟢 read |  |  |  |
| `/FinishedGoods/MaximumQuantityByTask` | mvc |  | 🟢 read |  |  |  |
| `/FinishedGoods/Undo` | mvc | POST | 🔴 write | TaskID |  |  |
| `/FinishedGoods/Upload` | mvc | POST | 🔴 write |  |  |  |
| `/api/FinishedGoods_Index_AutoPick` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/FinishedGoods_Index_Batches` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/FinishedGoods_Index_Bin` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | LocationID |  |  |
| `/api/FinishedGoods_Index_Components` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | CostingMethod LocationID PriceTier ProductID Type |  |  |
| `/api/FinishedGoods_Index_Job` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/FinishedGoods_Index_Location` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/FinishedGoods_Index_Pick` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | LocationID TaskID lang |  |  |
| `/api/FinishedGoods_Index_Products` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | LocationID lang |  |  |
| `/api/FinishedGoods_Index_Transactions` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | id |  |  |
| `/api/FinishedGoods_Index_vBillOfMaterials` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | LocationID ProductID lang |  |  |
| `/api/FinishedGoods_Index_vFinishedGoodsFile` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | TaskID |  |  |
| `/api/FinishedGoods_Index_vFinishedGoodsTask` | api | POST PUT REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | CountrySpecificKey id lang | HasErrors ID Original Updated |  |
| `/api/FinishedGoods_Index_vJobMilestones` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | jobID |  |  |
| `/api/FinishedGoods_RelatedTasks` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | taskId |  | root |
| `/api/FinishedGoods_Scan` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | lang locationId priceTier productId scanSource search |  |  |
| `/api/FinishedGoods_Scan_InventoryMode` | api | POST | 🟢 read | LocationID PriceTier ProductID ScanSource lang search |  |  |

### FinishedGoodsList

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/FinishedGoodsList_Index_vFinishedGoodsList` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | filter search |  | root |

### FinishedGoodsTask

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/FinishedGoodsTask_Index_vPurchaseExpense` | api |  | 🟢 read |  |  |  |

### GetRate

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/GetRate` | api | GET | 🟢 read | From |  |  |

### IssueToProduction

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/IssueToProduction/Cancel` | mvc | POST | 🔴 write | TaskID |  |  |
| `/IssueToProduction/CountrySpecific` | mvc |  | 🟢 read | Key |  |  |
| `/IssueToProduction/Download` | mvc |  | 🟢 read | id |  |  |
| `/IssueToProduction/Undo` | mvc | POST | 🔴 write | TaskID |  |  |
| `/IssueToProduction/Upload` | mvc | POST | 🔴 write |  |  |  |
| `/IssueToProduction/UploadTemplate` | mvc | POST | 🔴 write |  |  |  |
| `/api/IssueToProduction_Index_Job` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/IssueToProduction_Index_Product` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | LocationID ProductID lang |  |  |
| `/api/IssueToProduction_Index_ReferenceData` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/IssueToProduction_Index_Transactions` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | id |  |  |
| `/api/IssueToProduction_Index_vFinishedGoodsTask` | api | POST PUT REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | CountrySpecificKey id lang | HasErrors ID Original Updated |  |
| `/api/IssueToProduction_Index_vInventoryWriteOffAttachment` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | TaskID |  |  |
| `/api/IssueToProduction_Index_vJobMilestones` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | jobID |  |  |
| `/api/IssueToProduction_Scan` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | lang locationId search |  |  |
| `/api/IssueToProduction_Scan_InventoryMode` | api | POST | 🟢 read |  |  |  |

### IssueToProductionList

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/IssueToProductionList_Index_vIssueToProductionList` | api |  | 🟢 read |  |  |  |

### JobCosting

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/JobCosting/Download` | mvc |  | 🟢 read |  |  |  |
| `/JobCosting/Upload` | mvc | POST | 🔴 write |  |  |  |
| `/api/JobCosting_Index_GenerateSaleTask` | api | POST | 🔴 write |  |  |  |
| `/api/JobCosting_Index_LinkSaleTask` | api | POST | 🔴 write |  |  |  |
| `/api/JobCosting_Index_LinkingSale` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | CustomerID |  |  |
| `/api/JobCosting_Index_ReferenceData` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/JobCosting_Index_vCustomer` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/JobCosting_Index_vCustomerAddress` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | CustomerID |  |  |
| `/api/JobCosting_Index_vCustomerContact` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | CustomerID |  |  |
| `/api/JobCosting_Index_vJobCosting` | api | POST PUT REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | id | HasErrors ID Original Updated |  |
| `/api/JobCosting_Index_vJobCostingAllAttachement` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | JobID search |  | root |
| `/api/JobCosting_Index_vJobCostingAttachement` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | NoteID |  |  |
| `/api/JobCosting_Index_vJobCostingSales` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | JobID search |  | root |
| `/api/JobCosting_Index_vJobCostingUnallocatedExpenses` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |

### JobCostingList

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/JobCostingList_Index_vJobCosting` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | filter search |  | root |
| `/api/JobCostingList_Index_vJobCostingUnauthorisedSales` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | search |  | root |

### MakeToOrder

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/MakeToOrder/DownloadMakeToOrderImage` | mvc | GET | 🟢 read | id |  |  |
| `/MakeToOrder/GetMakeToOrderArtImage` | mvc |  | 🟢 read | ArtID |  |  |
| `/MakeToOrder/UploadArtImage` | mvc | POST | 🔴 write |  |  |  |
| `/api/MakeToOrder_MakeToOrderConfiguration` | api | GET | 🟢 read | ProductID |  |  |

### MRP

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/MRP_SupplySuggestionProducts` | api | POST | 🟢 read |  |  |  |

### MRPScheduler

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/MRPScheduler_Demand` | api |  | 🟢 read |  |  |  |
| `/api/MRPScheduler_ExistedSupply` | api |  | 🟢 read |  |  |  |
| `/api/MRPScheduler_LocationCalendar` | api |  | 🟢 read |  |  |  |
| `/api/MRPScheduler_MRP` | api |  | 🟢 read | mrpID |  |  |
| `/api/MRPScheduler_Supply` | api |  | 🟢 read |  |  |  |
| `/api/MRPScheduler_vMRPReorder` | api | POST | 🔴 write |  |  |  |

### MySubscription

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/MySubscription/DetailsUpdate` | mvc | GET | 🔴 write |  |  |  |

### PickRecommendation

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/PickRecommendation` | api | POST | 🟢 read | allowAllLocations locationID taskID |  |  |

### Product

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/Product/DownloadImage` | mvc |  | 🟢 read | id |  |  |
| `/api/Product_Index_vProductionBomResources` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ShopFloorId |  |  |

### Production

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/Production_AttributeSet` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | pageName |  |  |

### ProductionOrder

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/ProductionOrder/CheckLinkedTasks` | mvc | GET | 🟢 read | ID |  |  |
| `/ProductionOrder/CheckNestedOrdersToVoid` | mvc | GET | 🟢 read | productionOrderID |  |  |
| `/ProductionOrder/CheckOperationLinkedTasks` | mvc |  | 🟢 read |  |  |  |
| `/ProductionOrder/DownloadAttachment` | mvc |  | 🟢 read | id |  |  |
| `/ProductionOrder/DownloadBomAttachment` | mvc |  | 🟢 read | id |  |  |
| `/ProductionOrder/DownloadOperationAttachment` | mvc |  | 🟢 read | id |  |  |
| `/ProductionOrder/DownloadRunOperationAttachment` | mvc |  | 🟢 read | id |  |  |
| `/ProductionOrder/GetSuggestedQuantity` | mvc | POST | 🟢 read | locationId |  |  |
| `/ProductionOrder/MaximumQuantityByOrder` | mvc |  | 🟢 read |  |  |  |
| `/ProductionOrder/MaximumQuantityByProduct` | mvc |  | 🟢 read |  |  |  |
| `/ProductionOrder/Print` | mvc | POST | 🔴 write |  |  |  |
| `/ProductionOrder/Undo` | mvc | POST | 🔴 write | ID allowUndoTasks |  |  |
| `/ProductionOrder/UndoRun` | mvc | POST | 🔴 write | operationID runId updateTasks |  |  |
| `/ProductionOrder/Upload` | mvc | POST | 🔴 write |  |  |  |
| `/ProductionOrder/UploadProductionBomAttachment` | mvc | POST | 🔴 write |  |  |  |
| `/ProductionOrder/UploadProductionRunOperationAttachment` | mvc | POST | 🔴 write |  |  |  |
| `/ProductionOrder/UploadRunYieldLines` | mvc | POST | 🔴 write |  |  |  |
| `/ProductionOrder/Void` | mvc | POST | 🔴 write | ID allowVoidNestedOrders allowVoidTasks |  |  |
| `/ProductionOrder/VoidRun` | mvc | POST | 🔴 write | runId updateTasks |  |  |
| `/api/ProductionOrder_Index_AlternativeProducts/check` | api | GET | 🟢 read | productionOrderID |  |  |
| `/api/ProductionOrder_Index_AlternativeProducts/getOriginalProduct` | api | GET | 🟢 read | productionOrderID |  |  |
| `/api/ProductionOrder_Index_AlternativeProducts/substitute` | api | PUT | 🔴 write | productionOrderID |  |  |
| `/api/ProductionOrder_Index_ComponentAvailability` | api | GET | 🟢 read | orderId productId shopFloorId warehouseId |  |  |
| `/api/ProductionOrder_Index_ConsumptionBins` | api | POST | 🟢 read |  |  |  |
| `/api/ProductionOrder_Index_GetPlanDates` | api | POST | 🟢 read | Version ignoreLeadTime locationId orderId plannedDate productId quantity requiredByDate type |  |  |
| `/api/ProductionOrder_Index_ProductionOrderBulk` | api | POST | 🔴 write |  | Action Filter ProductionOrderIDs Schedule |  |
| `/api/ProductionOrder_Index_ProductionOrderBulkPermissions` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/ProductionOrder_Index_ProductionOrderConsolidation` | api | POST PUT | 🔴 write |  | Filter ProductionOrderIDs ProductionOrders RequiredByDate |  |
| `/api/ProductionOrder_Index_ProductionOrderList` | api | POST(read) | 🟢 read |  |  | root |
| `/api/ProductionOrder_Index_ProductionOrderList/BatchSerials` | api | GET | 🟢 read | ProductionOrderID RunID |  |  |
| `/api/ProductionOrder_Index_ProductionOrderPlan` | api | POST | 🔴 write |  | OrderCalcType PlanOrderDate ProductionOrderID SuggestedQuantity |  |
| `/api/ProductionOrder_Index_ProductionOrderRelease` | api | POST | 🔴 write |  | ProductionOrderID ReleaseOrderDate SuggestedQuantity |  |
| `/api/ProductionOrder_Index_ProductionOrderSplit` | api | POST | 🔴 write |  | ProductionOrders |  |
| `/api/ProductionOrder_Index_RelatedTasks` | api | DELETE REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | productionOrderId taskId |  | root |
| `/api/ProductionOrder_Index_RelatedTasks/GetOrderDetails` | api | GET | 🟢 read |  |  |  |
| `/api/ProductionOrder_Index_RelatedTasks/GetOrderList` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | CurrentProductionOrderID IsBOMLoaded ProductCode |  |  |
| `/api/ProductionOrder_Index_ShopFloorLocations` | api | GET | 🟢 read | onlyShopfloor |  |  |
| `/api/ProductionOrder_Index_Tags` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  | ProductionOrderTags |
| `/api/ProductionOrder_Index_Transactions` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | id |  |  |
| `/api/ProductionOrder_Index_vAttachments` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | OrderID |  |  |
| `/api/ProductionOrder_Index_vComponentProducts` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ProductID ShopFloorId WarehouseID |  |  |
| `/api/ProductionOrder_Index_vComponentProducts/GetSupplierDetails` | api | POST | 🟢 read |  |  |  |
| `/api/ProductionOrder_Index_vDeliveryTo` | api | GET REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | productionOrderId |  |  |
| `/api/ProductionOrder_Index_vProductionBom` | api | GET POST | 🟠 read + write | OrderID ProductID ShopFloorId Version WarehouseID lang |  |  |
| `/api/ProductionOrder_Index_vProductionBomVersions` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ProductID |  | root |
| `/api/ProductionOrder_Index_vProductionOrder` | api | POST PUT REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | id lang | AllowReschedule HasErrors ID Lang Original Updated |  |
| `/api/ProductionOrder_Index_vProducts` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | LocationID lang |  |  |
| `/api/ProductionOrder_Index_vSaleOrders` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | LocationID |  |  |
| `/api/ProductionOrder_Scan` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | lang locationId priceTier productId runOperationID scanSource search |  |  |
| `/api/ProductionOrder_Scan_InventoryMode` | api | POST | 🟢 read | LocationID PriceTier ProductID ScanSource lang runOperationID search |  |  |

### ProductionOrdersList

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/ProductionOrdersList/Print` | mvc | POST | 🟢 read (logs) | orderIDs |  |  |

### ProductionOrdersListBulkAction

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/ProductionOrdersListBulkAction` | api | POST | 🔴 write | Action IDs Tags |  |  |

### ProductionResource

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/ProductionResource/Download` | mvc |  | 🟢 read | id |  |  |

### ProductionRun

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/ProductionRun_Index_AutoPick` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | OrderID Quantity RunOperationID SourceOperationID WorkCenterID |  |  |
| `/api/ProductionRun_Index_Batches` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | OrderID ProductID RunOperationID WorkCenterID |  |  |
| `/api/ProductionRun_Index_ProductCosts` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/ProductionRun_Index_ReservedComponent` | api | GET | 🟢 read | RunId batchSN expiryDate locationId orderId productId |  |  |
| `/api/ProductionRun_Index_Transactions` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | id |  |  |
| `/api/ProductionRun_Index_vComponentProducts` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | OrderID WorkCenterId |  |  |
| `/api/ProductionRun_Index_vProductionResources` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | OrderID WorkCenterId |  |  |
| `/api/ProductionRun_Index_vShopFloorLocations` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | LocationID |  |  |

### ProductionSetup

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/ProductionSetup_Index_vResources` | api | DELETE REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ResourceID onlyActive search |  | root |
| `/api/ProductionSetup_Index_vSuppliers` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/ProductionSetup_Index_vSuspendReasons` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  | root |
| `/api/ProductionSetup_Index_vTenantLocations` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/ProductionSetup_Index_vWorkCenters` | api | PUT REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | search | Errors HasErrors Updated | root |

### Purchase

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/Purchase/Download` | mvc | GET POST | 🟢 read | PrintEntityID PrintTemplateID |  |  |
| `/Purchase/PrintReceiveTo` | mvc | POST | 🟢 read (logs) | PrintTemplateID |  |  |
| `/api/Purchase_Index_CoManCheck` | api | GET | 🟢 read | taskID |  |  |
| `/api/Purchase_Index_CoManCheck/CanBeCompleted` | api | POST | 🟢 read | masterTaskID taskID |  |  |
| `/api/Purchase_Index_CoManCheck/HasProduction` | api | GET | 🟢 read | masterTaskID taskID |  |  |
| `/api/Purchase_Index_SaleOrder/Prefill` | api | GET | 🟢 read | currentUILang onlyBackorder saleID |  |  |
| `/api/Purchase_Index_SaleOrder/SupplierProducts` | api | POST | 🟢 read | supplierID |  |  |
| `/api/Purchase_Index_WorkflowHistory` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | entityID |  |  |
| `/api/Purchase_Index_vPurchaseExpense` | api | DELETE POST REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | taskID | AccountCode OriginalPurchaseDate ProductionExpenseDistributions PurchaseExpenseDistributions TaskExpenseDistributions |  |
| `/api/Purchase_Index_vPurchase_SupplierSKU` | api | POST | 🟢 read | supplierID |  |  |
| `/api/Purchase_Index_vTenantLocation` | api | GET REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | assetsOnly locationID withBins |  |  |
| `/api/Purchase_Invoice_CheckForName` | api | POST | 🟢 read | InvoiceNumbers SupplierID |  |  |
| `/api/Purchase_RelatedTasks` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | taskId |  | root |

### QuoteNOrderApprove

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/QuoteNOrderApprove/Approve` | mvc | POST | 🔴 write | newState taskID taskType |  |  |

### QuoteNOrderArchive

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/QuoteNOrderArchive/Archive` | mvc | POST | 🔴 write | taskID |  |  |
| `/QuoteNOrderArchive/ArchivePurchase` | mvc | POST | 🔴 write | taskID |  |  |

### Resource

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/Resource_Index_vCostServices` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Resource_Index_vProductionResource` | api | POST PUT REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | id | HasErrors ID Original Updated |  |
| `/api/Resource_Index_vProductionResourceAttachments` | api | POST REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/Resource_Index_vProductionResourceReferences` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | id |  | root |
| `/api/Resource_Index_vUsers` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |

### Sale

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/Sale/LoadUsers` | mvc | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  | Data |

### SaleService

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/SaleService/Download` | mvc | GET | 🟢 read | PrintEntityID PrintTemplateID |  |  |

### Scheduler

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/Scheduler_Calendar_vProductionOrders` | api | PUT | 🟠 read + write | requiredByUpdate | Status |  |
| `/api/Scheduler_Index_CompleteOperation` | api | POST | 🔴 write |  |  |  |
| `/api/Scheduler_Index_StartOperation` | api | POST | 🔴 write |  |  |  |
| `/api/Scheduler_Index_vEditor/StartEdit` | api | POST | 🔴 write | locationId |  |  |
| `/api/Scheduler_Index_vEditor/StopEdit` | api | POST | 🔴 write | locationId |  |  |
| `/api/Scheduler_Index_vProductionOrders` | api | POST PUT | 🟠 read + write | buffers due from groupChilds includePlanned requiredByUpdate search shopFloorId showCompleted to |  |  |
| `/api/Scheduler_Index_vSchedulerReferenceData` | api | GET | 🟢 read |  |  |  |

### TaskShared

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/TaskShared_TaskList_vTask` | api |  | 🟢 read |  |  |  |
| `/api/TaskShared_Workflow_WorkflowProcess` | api | DELETE | 🔴 write | id |  |  |
| `/api/TaskShared_Workflow_vWorkflow` | api |  | 🟢 read |  |  |  |

### TenantAccessToFeatures

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/TenantAccessToFeatures` | api | GET POST | 🟠 read + write |  |  |  |

### TenantAttributeSet

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/TenantAttributeSet_Index_vTenantAttributeSet/GetCopyFrom` | api | GET | 🟢 read | entityID entityType fromID id |  |  |

## Public API (`/ExternalApi/v2`)

| Group | Method | Path | Query / params |
|---|---|---|---|
| Disassembly | DELETE | `/disassembly` | ID,Void |
| Disassembly | GET | `/disassembly` | TaskID |
| Disassembly | POST | `/disassembly` |  |
| Disassembly | GET | `/disassembly/order` | TaskID |
| Disassembly | POST | `/disassembly/order` |  |
| Disassembly | GET | `/disassemblyList` | Page,Limit,Status,Search |
| Finished Goods | DELETE | `/finishedGoods` | ID,Void |
| Finished Goods | GET | `/finishedGoods` | TaskID |
| Finished Goods | POST | `/finishedGoods` |  |
| Finished Goods | PUT | `/finishedGoods` |  |
| Finished Goods | GET | `/finishedGoods/order` | TaskID |
| Finished Goods | POST | `/finishedGoods/order` |  |
| Finished Goods | GET | `/finishedGoods/pick` | TaskID |
| Finished Goods | POST | `/finishedGoods/pick` |  |
| Finished Goods | GET | `/finishedGoodsList` | Page,Limit,Status,Search,SaleID |
| Inventory Write-Off | DELETE | `/inventoryWriteOff` | ID,Void |
| Inventory Write-Off | GET | `/inventoryWriteOff` | TaskID |
| Inventory Write-Off | POST | `/inventoryWriteOff` |  |
| Inventory Write-Off | PUT | `/inventoryWriteOff` |  |
| Inventory Write-Off | GET | `/inventoryWriteOffList` | Page,Limit,Status,Search |
| Production | GET | `/production/factoryCalendar` | Year |
| Production | POST | `/production/factoryCalendar` |  |
| Production | PUT | `/production/factoryCalendar` |  |
| Production | GET | `/production/order` | ProductionOrderID,returnAttachmentsContent |
| Production | POST | `/production/order` | RecalculateDates |
| Production | PUT | `/production/order` | AllowRecalculateDates,AllowRecalculateCyclesAndQuantities |
| Production | DELETE | `/production/order/attachment` | ProductionOrderAttachmentID |
| Production | GET | `/production/order/attachment` | ProductionOrderID,ReturnAttachmentsContent |
| Production | POST | `/production/order/attachment` | ProductionOrderID |
| Production | PUT | `/production/order/attachment` |  |
| Production | POST | `/production/order/authorise` |  |
| Production | GET | `/production/order/referenceData` |  |
| Production | POST | `/production/order/release` |  |
| Production | GET | `/production/order/run` | ProductionOrderID,IncludeAttachmentContent |
| Production | POST | `/production/order/run` |  |
| Production | PUT | `/production/order/run` | ProductionOrderID,IncreaseOrderQuantity |
| Production | PUT | `/production/order/run/complete` |  |
| Production | PUT | `/production/order/run/manualJournal` | ProductionOrderID |
| Production | PUT | `/production/order/run/operation/complete` |  |
| Production | PUT | `/production/order/run/operation/resume` |  |
| Production | PUT | `/production/order/run/operation/start` |  |
| Production | PUT | `/production/order/run/operation/suspend` |  |
| Production | PUT | `/production/order/run/undo` |  |
| Production | PUT | `/production/order/run/void` |  |
| Production | POST | `/production/order/undo` |  |
| Production | POST | `/production/order/void` |  |
| Production | GET | `/production/orderList` | Page,Limit,Status,Search,LocationID,RequiredByDateFrom,RequiredByDateTo,CompletionDateFrom,CompletionDateTo,SourceTaskID |
| Production | DELETE | `/production/productionBOM` | ProductID,BOMID |
| Production | DELETE | `/production/productionBOM` | ProductFamilyID,BOMID |
| Production | GET | `/production/productionBOM` | ProductID,ReturnAttachmentsContent |
| Production | GET | `/production/productionBOM` | ProductFamilyID,ReturnAttachmentsContent |
| Production | POST | `/production/productionBOM` |  |
| Production | POST | `/production/productionBOM` |  |
| Production | PUT | `/production/productionBOM` |  |
| Production | PUT | `/production/productionBOM` |  |
| Production | DELETE | `/production/resource` | ResourceID |
| Production | GET | `/production/resource` | ResourceID,IncludeAttachments |
| Production | POST | `/production/resource` |  |
| Production | PUT | `/production/resource` |  |
| Production | GET | `/production/resourceList` | Page,Limit,Name,OnlyActive |
| Production | GET | `/production/suspendReason` | Page,Limit,WorkcenterID |
| Production | PUT | `/production/suspendReason` |  |
| Production | DELETE | `/production/workcenters` | WorkCenterId |
| Production | GET | `/production/workcenters` | Page,Limit,Name |
| Production | POST | `/production/workcenters` |  |
| Production | PUT | `/production/workcenters` |  |
