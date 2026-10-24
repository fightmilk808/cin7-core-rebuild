-- Production: one table per Cin7 Core data model, generated from data/models.json

create table "AccessPermission" (
  "Name" text,
  "Title" text
);

create table "BOMWrapper" (
  "ID" text
);

create table "BatchSNModel" (
  "BatchSN" text,
  "DisplayName" text
);

create table "BatchSerialAndExpiryDate" (
  "FakeID" text,
  "OrderNumber" text,
  "RunNumber" text,
  "BatchSerial" text,
  "ExpiryDate" timestamptz
);

create table "CodeName" (
  "Code" integer,
  "Name" text
);

create table "ComponentLineUploadError" (
  "ValidationState" text,
  "ValidationText" text,
  "Line" integer,
  "SKU" text,
  "SKUError" text,
  "Bin" text,
  "BinError" text,
  "BatchSN" text,
  "BatchSNError" text,
  "ExpiryDate" text,
  "ExpiryDateError" text,
  "ExpenseAccount" text,
  "ExpenseAccountError" text,
  "Quantity" numeric,
  "QuantityError" text,
  "Cost" numeric,
  "CostError" text,
  "Available" numeric,
  "TotalCost" numeric
);

create table "ComponentProductReplacement" (
  "FakeKey" text,
  "ProductID" text,
  "ProductCode" text,
  "Name" text,
  "Available" numeric,
  "Cost" numeric,
  "CostingMethod" text,
  "Type" text,
  "ExpenseAccount" text,
  "Unit" text
);

create table "DisassemblyComponentsSelect" (
  "ProductID" text,
  "ProductCode" text,
  "Name" text,
  "DisplayName" text,
  "InventoryAccount" text,
  "CostingMethod" text,
  "Unit" text,
  "DefaultLocation" text,
  "NonInventory" boolean
);

create table "DisassemblyProductSelect" (
  "ProductID" text,
  "ProductCode" text,
  "Name" text,
  "DisplayName" text,
  "QuantityToProduce" numeric,
  "AccountCode" text,
  "CostingMethod" text,
  "AssemblyInstructionURL" text
);

create table "DisassemblyServicesSelect" (
  "ProductID" text,
  "Name" text,
  "ExpenseAccount" text
);

create table "DisassemblyWrapper" (
  "ID" text,
  "HasErrors" boolean
);

create table "Disassembly_LoadBOM_Components" (
  "ID" text,
  "ProductID" text,
  "Quantity" numeric,
  "CostPercentage" numeric,
  "ProductCode" text,
  "Name" text,
  "CostingMethod" text,
  "Account" text,
  "Unit" text,
  "BinID" text,
  "NonInventory" boolean
);

create table "Disassembly_LoadBOM_Services" (
  "ID" text,
  "ProductID" text,
  "Amount" numeric,
  "Name" text,
  "Account" text
);

create table "FinishedGoodsBatch" (
  "FakeKey" text,
  "BatchSN" text,
  "Available" numeric,
  "ExpiryDate" timestamptz,
  "Cost" numeric,
  "BinID" text,
  "BinName" text,
  "LocationName" text
);

create table "FinishedGoodsWrapper" (
  "ID" integer,
  "HasErrors" boolean,
  "PickRecommendationWarning" text
);

create table "FinishedProductBatchSN" (
  "FakeID" text,
  "TraceabilityID" text,
  "RunID" text,
  "ProductID" text,
  "DisplayName" text,
  "BatchSN" text,
  "ExpiryDate" timestamptz,
  "CostingMethod" text,
  "ValidationState" text,
  "ValidationText" text
);

create table "InvoicingMilestone" (
  "ID" text,
  "Name" text
);

create table "IssueToProductionWrapper" (
  "ID" integer,
  "HasErrors" boolean
);

create table "JobCostingInfo" (
  "Code" text,
  "DisplayName" text,
  "JobID" text
);

create table "JobCostingWrapper" (
  "ID" integer,
  "HasErrors" boolean,
  "IsCreatedByRMA" boolean
);

create table "Location" (
  "LocationID" text,
  "Description" text
);

create table "OrderReferenceData" (
  "ID" integer,
  "ProductionOrderPermission" text,
  "FulfillmentPermission" text,
  "EditCompletedOperationsPermission" text,
  "ProductionFinancialDataPermission" text,
  "InventoryControlAccount" text,
  "WipAccount" text,
  "MOProduce" text,
  "MOStatus" text,
  "MOWastageType" text,
  "MOWastageExpenseAccount" text,
  "UndoPermission" text,
  "VoidPermission" text,
  "CurrentAttributeSet" text,
  "MOTraceFinishedProduct" integer,
  "UseBackdatedTransaction" boolean
);

create table "OrderWrapper" (
  "ID" text,
  "AllowReschedule" boolean,
  "HasErrors" boolean,
  "Lang" text
);

create table "PriceTiers" (
  "Code" integer,
  "Name" text
);

create table "ProductModel" (
  "ProductID" text,
  "DisplayName" text
);

create table "ProductionOrderSourceTask" (
  "ProductionOrderID" text,
  "SourceTaskID" text,
  "SourceTaskNumber" text,
  "SourceTaskType" integer,
  "SourceType" text,
  "IsVoided" boolean
);

create table "ProductionRunAutoPickWrapper" (
  "FakeKey" text,
  "Warning" text
);

create table "ProductionRunRelatedOrdersModel" (
  "TaskID" integer,
  "OrderNumber" text
);

create table "ReferenceData" (
  "ID" text
);

create table "ReservedComponent" (
  "FakeID" text,
  "ProductName" text,
  "OperationName" text,
  "LocationName" text,
  "BatchSN" text,
  "ExpiryDate" timestamptz,
  "Available" numeric,
  "OnOrder" numeric,
  "Reserved" numeric
);

create table "ResourceReferenceData" (
  "ID" integer
);

create table "ResourceWrapper" (
  "ID" text,
  "AllowReschedule" boolean,
  "HasErrors" boolean
);

create table "SalePickerModel" (
  "UserID" text,
  "Email" text
);

create table "Status" (
  "Value" text,
  "Name" text
);

create table "WarehouseLocation" (
  "LocationID" text,
  "LocationName" text
);

create table "WorkCenterWrapper" (
  "FakeID" text,
  "HasErrors" boolean,
  "Errors" text,
  "CustomersCreated" text,
  "WarningMessage" text
);

create table "YieldLineUploadError" (
  "ValidationState" text,
  "ValidationText" text,
  "Line" integer,
  "SKU" text,
  "SKUError" text,
  "Name" text,
  "NameError" text,
  "BatchSerialNumber" text,
  "BatchSerialNumberError" text,
  "ExpiryDate_YYYYMMDD" text,
  "ExpiryDate_YYYYMMDDError" text,
  "Quantity" text,
  "QuantityError" text,
  "Location" text,
  "LocationError" text,
  "DateReceived_YYYYMMDD" text,
  "DateReceived_YYYYMMDDError" text
);

create table "vCapacityPlannerDetailsRecord" (
  "FakeID" text,
  "ProductionOrderID" text,
  "ProductionOrderNumber" text,
  "LocationID" text,
  "LocationName" text,
  "ResourceID" text,
  "ResourceCode" text,
  "ResourceName" text,
  "ReleaseDate" timestamptz,
  "StartDate" timestamptz,
  "Status" text,
  "Type" integer,
  "RequiredByDate" timestamptz,
  "DueDate" timestamptz,
  "UnitQuantity" numeric,
  "Capacity" integer,
  "SaleTaskID" text,
  "SaleOrderNumber" text,
  "CustomerName" text,
  "CustomerContact" text,
  "CustomerEmail" text,
  "SalesRepresentative" text,
  "ProductCode" text,
  "ProductName" text,
  "ValidationState" text,
  "ValidationText" text
);

create table "vCapacityPlannerRecord" (
  "FakeID" text,
  "LocationID" text,
  "LocationName" text,
  "ResourceID" text,
  "ResourceCode" text,
  "ResourceName" text,
  "TotalCapacity" integer,
  "AllocatedCapacity" integer,
  "AvailableCapacity" integer,
  "ConsumedCapacity" integer,
  "IsFirstRow" boolean,
  "IsLastRow" boolean,
  "AllocatedPlanned" integer,
  "AllocatedReleased" integer
);

create table "vCustomerAddress" (
  "CustomerID" text,
  "AddressID" text,
  "Line1" text,
  "Line2" text,
  "CitySuburb" text,
  "StateProvince" text,
  "ZipPostCode" text,
  "Country" text,
  "Type" text,
  "DefaultForType" boolean
);

create table "vCustomerContact" (
  "CustomerID" text,
  "ContactID" text,
  "Name" text,
  "JobTitle" text,
  "Phone" text,
  "MobilePhone" text,
  "Fax" text,
  "Email" text,
  "Website" text,
  "IsDefault" boolean,
  "Comment" text
);

create table "vDisassemblyComponents" (
  "FakeID" integer,
  "ID" text,
  "TaskID" text,
  "ProductID" text,
  "BinID" text,
  "Quantity" numeric,
  "Account" text,
  "Cost" numeric,
  "BatchSN" text,
  "ExpiryDate" timestamptz,
  "ProductCode" text,
  "Name" text,
  "CostingMethod" text,
  "Unit" text,
  "NonInventory" boolean,
  "ValidationText" text,
  "ValidationState" text
);

create table "vDisassemblyList" (
  "TaskID" text,
  "DisassemblyNumber" text,
  "ProductCode" text,
  "Date" timestamptz,
  "Name" text,
  "Quantity" numeric,
  "Location" text,
  "Status" text,
  "Notes" text
);

create table "vDisassemblyPicking" (
  "FakeID" integer,
  "ID" text,
  "CardID" text,
  "TaskID" text,
  "Quantity" numeric,
  "Date" timestamptz,
  "UnitCost" numeric,
  "BatchSN" text,
  "ExpiryDate" timestamptz,
  "Available" numeric,
  "Cost" numeric,
  "IsLocked" boolean,
  "Bin" text,
  "ValidationText" text,
  "ValidationState" text
);

create table "vDisassemblyServices" (
  "FakeID" integer,
  "ID" text,
  "ProductID" text,
  "TaskID" text,
  "Amount" numeric,
  "Account" text,
  "Comments" text,
  "Name" text,
  "ValidationText" text,
  "ValidationState" text
);

create table "vDisassemblyTask" (
  "TaskID" text,
  "DisassemblyNumber" text,
  "Status" text,
  "LocationID" text,
  "ProductID" text,
  "Quantity" numeric,
  "ProductCode" text,
  "Name" text,
  "BatchSN" text,
  "WIPDate" timestamptz,
  "CompletionDate" timestamptz,
  "Date" timestamptz,
  "CostingMethod" text,
  "WIPAccount" text,
  "QuantityToProduce" numeric,
  "AssemblyInstructionURL" text,
  "Notes" text,
  "ValidationText" text,
  "ValidationState" text
);

create table "vDisassemblyTaskFile" (
  "FileID" text,
  "FinishedGoodsID" text,
  "FileName" text,
  "ContentType" text,
  "UserName" text,
  "UploadedDate" timestamptz,
  "ExternalDownloadLink" text,
  "ExternalViewLink" text
);

create table "vDistributedAmount" (
  "ID" text,
  "TaskID" text,
  "TaskType" text,
  "ValidationText" text,
  "ValidationState" text
);

create table "vDistributedAmountAccount" (
  "AccountCode" text,
  "AccountAmount" numeric,
  "AccountName" text,
  "DistributedAmount" numeric
);

create table "vDocumentAccount" (
  "AccountCode" text,
  "AccountAmount" numeric,
  "AccountName" text
);

create table "vFinishedGoodsComponent" (
  "FakeID" integer,
  "ComponentID" text,
  "TaskID" text,
  "ProductID" text,
  "BinID" text,
  "BinName" text,
  "Quantity" numeric,
  "TotalQuantity" numeric,
  "WastageQuantity" numeric,
  "WastagePercent" numeric,
  "Available" numeric,
  "Cost" numeric,
  "Name" text,
  "ProductCode" text,
  "BatchSN" text,
  "ExpiryDate" timestamptz,
  "CostingMethod" text,
  "PriceTier" integer,
  "ExpenseAccount" text,
  "Type" text,
  "ValidationText" text,
  "ValidationState" text,
  "Unit" text,
  "NonInventory" boolean
);

create table "vFinishedGoodsFile" (
  "FileID" text,
  "FinishedGoodsID" text,
  "FileName" text,
  "ContentType" text,
  "UserName" text,
  "UploadedDate" timestamptz,
  "ExternalDownloadLink" text,
  "ExternalViewLink" text
);

create table "vFinishedGoodsList" (
  "TaskID" text,
  "AssemblyNumber" text,
  "ProductCode" text,
  "SysDate" timestamptz,
  "Name" text,
  "Quantity" numeric,
  "Location" text,
  "Status" text,
  "BatchSN" text,
  "ExpiryDate" timestamptz,
  "UnitCost" numeric,
  "Notes" text,
  "CompletionDate" timestamptz,
  "CustomField1" text,
  "CustomField2" text,
  "CustomField3" text,
  "CustomField4" text,
  "CustomField5" text,
  "CustomField6" text,
  "CustomField7" text,
  "CustomField8" text,
  "CustomField9" text,
  "CustomField10" text
);

create table "vFinishedGoodsManualJournals" (
  "FakeID" integer,
  "TaskID" text,
  "ID" text,
  "Reference" text,
  "Amount" numeric,
  "Date" timestamptz,
  "Debit" text,
  "Credit" text,
  "ValidationText" text,
  "ValidationState" text
);

create table "vFinishedGoodsOrder" (
  "FakeID" integer,
  "ComponentID" text,
  "ProductID" text,
  "TaskID" text,
  "Quantity" numeric,
  "TotalQuantity" numeric,
  "WastageQuantity" numeric,
  "WastagePercent" numeric,
  "Available" numeric,
  "Cost" numeric,
  "TotalCost" numeric,
  "Name" text,
  "ProductCode" text,
  "CostingMethod" text,
  "PriceTier" integer,
  "ExpenseAccount" text,
  "Type" text,
  "ValidationText" text,
  "ValidationState" text,
  "Unit" text
);

create table "vFinishedGoodsTask" (
  "TaskID" text,
  "AssemblyNumber" text,
  "Status" text,
  "LocationID" text,
  "LocationName" text,
  "ProductID" text,
  "BinID" text,
  "BinName" text,
  "Quantity" numeric,
  "ProductCode" text,
  "Name" text,
  "BatchSN" text,
  "ExpiryDate" timestamptz,
  "WIPDate" timestamptz,
  "CompletionDate" timestamptz,
  "CostingMethod" text,
  "Type" text,
  "Account" text,
  "WIPAccount" text,
  "TaskType" text,
  "QuantityToProduce" numeric,
  "AssemblyInstructionURL" text,
  "Notes" text,
  "CountrySpecificKey" text,
  "CountrySpecificData" text,
  "ValidationText" text,
  "ValidationState" text,
  "NonInventory" boolean,
  "JobID" text,
  "JobMilestoneID" text,
  "CustomField1" text,
  "CustomField2" text,
  "CustomField3" text,
  "CustomField4" text,
  "CustomField5" text,
  "CustomField6" text,
  "CustomField7" text,
  "CustomField8" text,
  "CustomField9" text,
  "CustomField10" text
);

create table "vInventoryWriteOffAttachment" (
  "FinishedGoodsID" text,
  "FileID" text,
  "ContentType" text,
  "FileName" text,
  "UploadedDate" timestamptz,
  "UserName" text,
  "ExternalDownloadLink" text,
  "ExternalViewLink" text
);

create table "vIssueToProductionList" (
  "TaskID" text,
  "AssemblyNumber" text,
  "Date" timestamptz,
  "Location" text,
  "Status" text,
  "Notes" text
);

create table "vJobCosting" (
  "JobID" text,
  "JobNumber" text,
  "CustomerID" text,
  "Name" text,
  "AddressLine1" text,
  "AddressLine2" text,
  "AccountCode" text,
  "Contact" text,
  "Comments" text,
  "Status" text,
  "StartDate" timestamptz,
  "CompletedDate" timestamptz,
  "EstimatedValue" numeric,
  "BudgetedMargin" numeric,
  "AttributeSet" text,
  "CustomField1" text,
  "CustomField2" text,
  "CustomField3" text,
  "CustomField4" text,
  "CustomField5" text,
  "CustomField6" text,
  "CustomField7" text,
  "CustomField8" text,
  "CustomField9" text,
  "CustomField10" text,
  "ProjectManager" text,
  "TaxRuleID" text,
  "Phone" text,
  "AutoInvoice" boolean,
  "Frequency" text,
  "NextInvoiceDate" timestamptz,
  "CustomerName" text,
  "CustomerCurrency" text,
  "ValidationText" text,
  "ValidationState" text
);

create table "vJobCostingAllAttachements" (
  "AttachementID" text,
  "FileName" text,
  "UserName" text,
  "Date" timestamptz,
  "AttachmentType" text,
  "MileStoneName" text
);

create table "vJobCostingAttachement" (
  "AttachementID" text,
  "FileName" text,
  "UserName" text,
  "Date" timestamptz
);

create table "vJobCostingLinkingSale" (
  "TaskID" text,
  "SaleOrderNumber" text
);

create table "vJobCostingMilestone" (
  "FakeID" integer,
  "ID" text,
  "JobID" text,
  "Name" text,
  "Description" text,
  "DateEstimated" timestamptz,
  "DateActual" timestamptz,
  "Status" text,
  "LinksCount" integer,
  "ValidationText" text,
  "ValidationState" text
);

create table "vJobCostingNote" (
  "FakeID" integer,
  "ID" text,
  "JobID" text,
  "Category" text,
  "Note" text,
  "Date" timestamptz,
  "Username" text,
  "ValidationText" text,
  "ValidationState" text
);

create table "vJobCostingSales" (
  "TaskID" text,
  "SaleOrderNumber" text,
  "InvoiceNumber" text,
  "Milestone" text,
  "InvoiceDate" timestamptz,
  "ExpenseAmount" numeric,
  "SaleAmount" numeric,
  "BudgetedAmount" numeric,
  "SaleControllerName" text
);

create table "vJobCostingUnallocatedExpenses" (
  "ExpenseTaskID" text,
  "Type" text,
  "TaskNumber" text,
  "Date" timestamptz,
  "ExpenseAmount" numeric,
  "InvoicingAmount" numeric,
  "MilestoneID" text,
  "MilestoneName" text,
  "Selected" boolean
);

create table "vJobCostingUnauthorisedSales" (
  "TaskID" text,
  "JobID" text,
  "JobNumber" text,
  "JobName" text,
  "Milestone" text,
  "Amount" numeric,
  "SaleOrderNumber" text,
  "InvoiceNumber" text,
  "SaleOrderDate" timestamptz
);

create table "vJobMilestone" (
  "ID" text,
  "Name" text
);

create table "vLogisticsPath" (
  "PathID" text,
  "WarehouseLocationID" text,
  "ShopFloorLocationID" text,
  "RetailLocationID" text
);

create table "vPlannedOperation" (
  "ID" text,
  "ProductionOrderID" text,
  "OperationName" text,
  "OperationOrder" integer,
  "OperationStatus" text,
  "WorkCenterID" text,
  "CycleTime" integer,
  "ActualTime" integer,
  "FromDate" timestamptz,
  "ToDate" timestamptz,
  "OperationID" text
);

create table "vProductCost" (
  "ProductID" text,
  "ProductName" text,
  "ProductCode" text,
  "Cost" text,
  "ExpenseAccount" text
);

create table "vProductionBom" (
  "BomID" text,
  "ProductID" text,
  "OutputQuantity" numeric,
  "BufferPercent" numeric,
  "InstructionUrl" text,
  "IssueMethod" integer,
  "IssueMethodComponent" integer,
  "IssueMethodParameter" integer,
  "IgnoreCumulativeLeadTime" boolean,
  "ComponentProductionLeadTime" integer,
  "Version" integer,
  "Name" text,
  "IsDefault" boolean,
  "CreatedDate" timestamptz,
  "CreatedBy" text,
  "DeliveryTo" text,
  "IsTracing" boolean,
  "MinQuantity" numeric,
  "MaxQuantity" numeric,
  "DeviationPercent" numeric,
  "RunSize" numeric,
  "ValidationState" text,
  "ValidationText" text
);

create table "vProductionBomVersion" (
  "Version" integer,
  "BomID" text,
  "Name" text,
  "IsDefault" boolean,
  "DisplayName" text
);

create table "vProductionCalendar" (
  "CalendarID" text,
  "Year" integer,
  "WeekStart" integer,
  "ValidationState" text,
  "ValidationText" text
);

create table "vProductionCalendarDay" (
  "DayID" text,
  "CalendarID" text,
  "DayOfWeek" integer,
  "IsWeekend" boolean,
  "StartTime" integer,
  "EndTime" integer,
  "StartTimeStr" text,
  "EndTimeStr" text,
  "BreakStartTime" integer,
  "BreakEndTime" integer,
  "BreakStartTimeStr" text,
  "BreakEndTimeStr" text,
  "SortOrder" integer,
  "ValidationState" text,
  "ValidationText" text
);

create table "vProductionCalendarSpecialDay" (
  "DayID" text,
  "CalendarID" text,
  "Date" timestamptz,
  "IsWeekend" boolean,
  "IsHoliday" boolean,
  "StartTime" integer,
  "EndTime" integer,
  "StartTimeStr" text,
  "EndTimeStr" text,
  "BreakStartTime" integer,
  "BreakEndTime" integer,
  "BreakStartTimeStr" text,
  "BreakEndTimeStr" text,
  "Comment" text,
  "ValidationState" text,
  "ValidationText" text
);

create table "vProductionComponentBin" (
  "FakeKey" text,
  "BatchSN" text,
  "Quantity" numeric,
  "ExpiryDate" timestamptz,
  "Cost" numeric,
  "BinID" text,
  "BinName" text
);

create table "vProductionOperationAttachment" (
  "AttachmentID" text,
  "OperationID" text,
  "FileName" text,
  "Date" timestamptz,
  "ContentType" text,
  "BlobGuid" text,
  "Position" integer,
  "IsCloned" boolean,
  "FromBOM" boolean,
  "ProductAttachmentID" text,
  "ValidationState" text,
  "ValidationText" text
);

create table "vProductionOperationItem" (
  "ItemID" text,
  "OperationID" text,
  "Type" text,
  "Value" text,
  "ResourceID" text,
  "ResourceName" text,
  "ResourceCode" text,
  "Quantity" numeric,
  "ProductID" text,
  "ProductName" text,
  "ProductSku" text,
  "WastageQty" numeric,
  "WastagePercent" numeric,
  "AttachmentFileName" text,
  "AttachmentDate" timestamptz,
  "AttachmentContentType" text,
  "AttachmentBlobGuid" text,
  "Note" text,
  "Cost" numeric,
  "CostingMethod" text,
  "CycleTime" integer,
  "ValidationState" text,
  "ValidationText" text,
  "TotalCost" numeric,
  "Position" integer,
  "Unit" text,
  "WastageCost" integer,
  "SalePriceTier" integer,
  "PriceTier1" numeric,
  "PriceTier2" numeric,
  "PriceTier3" numeric,
  "PriceTier4" numeric,
  "PriceTier5" numeric,
  "PriceTier6" numeric,
  "PriceTier7" numeric,
  "PriceTier8" numeric,
  "PriceTier9" numeric,
  "PriceTier10" numeric,
  "TemplateID" text,
  "IsBackflush" boolean,
  "CostCalculationType" integer
);

create table "vProductionOrder" (
  "ProductionOrderID" text,
  "ProductID" text,
  "ProductCode" text,
  "ProductName" text,
  "OrderNumber" text,
  "LocationID" text,
  "LocationName" text,
  "OrderStatus" text,
  "Status" text,
  "Source" integer,
  "MakeToOrderConfigurationID" text,
  "WIPAccount" text,
  "Account" text,
  "Quantity" numeric,
  "BomQuantity" numeric,
  "CapacityCalType" integer,
  "StartDate" timestamptz,
  "RequiredByDate" timestamptz,
  "ReleaseDate" timestamptz,
  "CompletionDate" timestamptz,
  "MaxQuantityCalculated" text,
  "IsIgnoreLeadTime" boolean,
  "IsMakeToOrderBomProduct" boolean,
  "WarehouseID" text,
  "RetailID" text,
  "QuantityInProduction" numeric,
  "QuantityRemained" numeric,
  "QuantityPutAway" numeric,
  "QuantityCompleted" numeric,
  "Comments" text,
  "CostingMethod" text,
  "WarehouseName" text,
  "Unit" text,
  "ScheduleStart" timestamptz,
  "ScheduleDue" timestamptz,
  "PlannedBy" text,
  "ReleasedBy" text,
  "OrderCycleTime" integer,
  "InstructionURL" text,
  "ShowDeliveryTo" boolean,
  "BomVersion" integer,
  "BomName" text,
  "ShowRevertProducts" boolean,
  "ValidationState" text,
  "ValidationText" text,
  "Tags" text,
  "MRPTaskID" text,
  "IsCreatedFromMRP" boolean,
  "CustomField1" text,
  "CustomField2" text,
  "CustomField3" text,
  "CustomField4" text,
  "CustomField5" text,
  "CustomField6" text,
  "CustomField7" text,
  "CustomField8" text,
  "CustomField9" text,
  "CustomField10" text,
  "IsTracing" boolean,
  "IssueMethodComponent" integer,
  "IssueMethodParameter" integer,
  "MinQuantity" numeric,
  "MaxQuantity" numeric,
  "RunSize" numeric,
  "IsLoadBOM" boolean,
  "IsCreatedFromPurchase" boolean
);

create table "vProductionOrderAttachment" (
  "AttachmentID" text,
  "ProductionOrderID" text,
  "FileName" text,
  "Date" timestamptz,
  "ContentType" text,
  "BlobGuid" text,
  "UserName" text,
  "IsProcessed" boolean,
  "ValidationState" text,
  "ValidationText" text,
  "Position" integer,
  "AttachmentFrom" text,
  "ExternalDownloadLink" text,
  "ExternalViewLink" text
);

create table "vProductionOrderAvailabilityItem" (
  "FakeID" text,
  "ProductID" text,
  "LocationID" text,
  "LocationName" text,
  "Quantity" numeric,
  "OnOrder" numeric
);

create table "vProductionOrderComponent" (
  "OrderComponentID" text,
  "OperationID" text,
  "ProductID" text,
  "ProductName" text,
  "ProductSku" text,
  "ProductType" text,
  "Quantity" numeric,
  "TotalQuantity" numeric,
  "TotalWastageQty" numeric,
  "WastageQty" numeric,
  "WastagePercent" numeric,
  "ProductCost" numeric,
  "TotalCost" numeric,
  "Cost" numeric,
  "Available" numeric,
  "CostingMethod" text,
  "ValidationState" text,
  "ValidationText" text,
  "Position" integer,
  "Unit" text,
  "SalePriceTier" integer,
  "IsAlternative" boolean,
  "IsReverted" boolean,
  "PriceTier1" numeric,
  "PriceTier2" numeric,
  "PriceTier3" numeric,
  "PriceTier4" numeric,
  "PriceTier5" numeric,
  "PriceTier6" numeric,
  "PriceTier7" numeric,
  "PriceTier8" numeric,
  "PriceTier9" numeric,
  "PriceTier10" numeric,
  "AverageCost" numeric,
  "IsBackflush" boolean
);

create table "vProductionOrderConfiguration" (
  "ProductionOrderConfigurationID" text,
  "OperationID" text,
  "Configuration" text,
  "ValidationState" text,
  "ValidationText" text,
  "Position" integer
);

create table "vProductionOrderDeliveryTo" (
  "FakeID" text,
  "ID" text,
  "ProductionOrderID" text,
  "ProductID" text,
  "LocationID" text,
  "ProductName" text,
  "ProductUnit" text,
  "SaleTaskID" text,
  "SaleOrderNumber" text,
  "ValidationState" text,
  "ValidationText" text
);

create table "vProductionOrderList" (
  "TaskID" text,
  "ProductionOrderID" text,
  "Type" text,
  "ProductID" text,
  "ProductCode" text,
  "ProductName" text,
  "OrderNumber" text,
  "LocationID" text,
  "LocationName" text,
  "Status" text,
  "Quantity" numeric,
  "StartDate" timestamptz,
  "RequiredByDate" timestamptz,
  "ReleaseDate" timestamptz,
  "CompletionDate" timestamptz,
  "TimeStatus" text,
  "ResourceStatus" text,
  "InventoryStatus" text,
  "OrderStatus" text,
  "CapacityCalType" integer,
  "Comments" text,
  "Tags" text,
  "IsSourceTaskVoided" boolean,
  "IsBatchSnExists" boolean,
  "CustomField1" text,
  "CustomField2" text,
  "CustomField3" text,
  "CustomField4" text,
  "CustomField5" text,
  "CustomField6" text,
  "CustomField7" text,
  "CustomField8" text,
  "CustomField9" text,
  "CustomField10" text
);

create table "vProductionOrderNote" (
  "NoteID" text,
  "OperationID" text,
  "Note" text,
  "ValidationState" text,
  "ValidationText" text,
  "Position" integer
);

create table "vProductionOrderOperation" (
  "OperationID" text,
  "ProductionOrderID" text,
  "Order" integer,
  "Name" text,
  "CycleTime" integer,
  "CycleTimeString" text,
  "TotalCycleTime" integer,
  "TotalCycleTimeString" text,
  "UnitsPerCycle" numeric,
  "TotalUnitsPerCycle" numeric,
  "WorkCenterID" text,
  "WorkCenterName" text,
  "WorkCenterCode" text,
  "WorkCenterCoManProcurementType" text,
  "TotalCost" numeric,
  "OperationType" integer,
  "OperationRelationIDsFake" jsonb,
  "ComponentLocationID" text,
  "IsDropShip" boolean,
  "IsBackflush" boolean,
  "ValidationState" text,
  "ValidationText" text
);

create table "vProductionOrderOperationLink" (
  "ID" text,
  "OperationID" text,
  "RelatedOperationID" text,
  "RelationType" integer,
  "ValidationState" text,
  "ValidationText" text
);

create table "vProductionOrderOperationProduct" (
  "ID" text,
  "OperationID" text,
  "ProductID" text,
  "ProductName" text,
  "ProductSku" text,
  "Type" integer,
  "CostCalculationType" integer,
  "PriceTier" integer,
  "Ratio" numeric,
  "OutputQuantity" numeric,
  "TotalOutputQuantity" numeric,
  "AverageCost" numeric,
  "CostingMethod" text,
  "FixedCost" numeric,
  "Position" integer,
  "Unit" text,
  "Cost" numeric,
  "TotalCost" numeric,
  "Formula" text,
  "WastageCost" integer,
  "IsTracing" boolean,
  "ValidationState" text,
  "ValidationText" text
);

create table "vProductionOrderResource" (
  "OrderResourceID" text,
  "OperationID" text,
  "ResourceID" text,
  "ResourceName" text,
  "ResourceCode" text,
  "ResourceCost" numeric,
  "Quantity" numeric,
  "CycleTime" integer,
  "TotalCost" numeric,
  "Cost" numeric,
  "Available" numeric,
  "ValidationState" text,
  "ValidationText" text,
  "Position" integer,
  "CostCalculationType" integer
);

create table "vProductionOrderSourceTask" (
  "SourceTaskID" text,
  "SourceTaskNumber" text,
  "ProductionOrderID" text,
  "SourceType" text
);

create table "vProductionOrderSplit" (
  "ProductionOrderID" text,
  "Number" text,
  "Quantity" numeric,
  "RemainingQuantity" numeric,
  "ValidationState" text,
  "ValidationText" text
);

create table "vProductionResource" (
  "ResourceID" text,
  "Name" text,
  "Code" text,
  "Tags" text,
  "IsInfinite" boolean,
  "IsAllowAllCapacityUsage" boolean,
  "IsAvailableOnHolidays" boolean,
  "IsAvailableOnWeekends" boolean,
  "CycleDuration" integer,
  "CycleDurationStr" text,
  "IsActive" boolean,
  "Type" integer,
  "ResourceType" integer,
  "ValidationState" text,
  "ValidationText" text
);

create table "vProductionResourceAttachment" (
  "AttachmentID" text,
  "ResourceID" text,
  "Date" timestamptz,
  "FileName" text,
  "ContentType" text,
  "BlobGuid" text,
  "UserName" text,
  "ExternalDownloadLink" text,
  "ExternalViewLink" text,
  "ValidationState" text,
  "ValidationText" text
);

create table "vProductionResourceCapacity" (
  "FakeID" text,
  "ResourceCapacityID" text,
  "ResourceID" text,
  "LocationID" text,
  "LocationName" text,
  "ResourceQuantity" integer,
  "NonOperationalFrom" timestamptz,
  "NonOperationalTo" timestamptz,
  "HasCapacityHours" boolean,
  "CapacityHoursWeek" numeric,
  "ValidationState" text,
  "ValidationText" text
);

create table "vProductionResourceCapacityDay" (
  "ResourceDayID" text,
  "ResourceID" text,
  "LocationID" text,
  "DayOfWeek" integer,
  "StartTime" integer,
  "EndTime" integer,
  "StartTimeStr" text,
  "EndTimeStr" text,
  "BreakStartTime" integer,
  "BreakEndTime" integer,
  "BreakStartTimeStr" text,
  "BreakEndTimeStr" text,
  "Capacity" numeric,
  "SortOrder" text,
  "DefaultStart" integer,
  "DefaultEnd" integer,
  "DefaultBreakStart" integer,
  "DefaultBreakEnd" integer,
  "DefaultStartStr" text,
  "DefaultEndStr" text,
  "DefaultBreakStartStr" text,
  "DefaultBreakEndStr" text,
  "ValidationState" text,
  "ValidationText" text
);

create table "vProductionResourceCost" (
  "FakeID" text,
  "ResourceCostID" text,
  "ResourceID" text,
  "ProductID" text,
  "ProductName" text,
  "AccountCode" text,
  "Cost" numeric,
  "PriceTier" integer,
  "PriceTier1" numeric,
  "PriceTier2" numeric,
  "PriceTier3" numeric,
  "PriceTier4" numeric,
  "PriceTier5" numeric,
  "PriceTier6" numeric,
  "PriceTier7" numeric,
  "PriceTier8" numeric,
  "PriceTier9" numeric,
  "PriceTier10" numeric,
  "PlannedDowntimeCost" numeric,
  "PlannedDowntimePriceTier" integer,
  "NotPlannedDowntimeCost" numeric,
  "NotPlannedDowntimePriceTier" integer,
  "ValidationState" text,
  "ValidationText" text
);

create table "vProductionResourceProduct" (
  "ProductID" text,
  "ProductCode" text,
  "ProductName" text,
  "ImageID" text,
  "Type" text
);

create table "vProductionResourceRemark" (
  "FakeID" text,
  "RemarkID" text,
  "ResourceID" text,
  "Remark" text,
  "CreatedDate" timestamptz,
  "CreatedBy" text,
  "ValidationState" text,
  "ValidationText" text
);

create table "vProductionResourceUnit" (
  "FakeID" text,
  "ResourceUnitID" text,
  "ResourceID" text,
  "LocationID" text,
  "Name" text,
  "NonOperationalFrom" timestamptz,
  "NonOperationalTo" timestamptz,
  "OperationalFrom" timestamptz,
  "OperationalTo" timestamptz,
  "ValidationState" text,
  "ValidationText" text
);

create table "vProductionResources" (
  "ResourceID" text,
  "Code" text,
  "Name" text,
  "ResourceCost" numeric,
  "CycleDuration" integer
);

create table "vProductionRun" (
  "RunID" text,
  "ProductionOrderID" text,
  "Number" integer,
  "Status" text,
  "Quantity" numeric,
  "WIPAccount" text,
  "StartDate" timestamptz,
  "EndDate" timestamptz,
  "DueDate" timestamptz,
  "ReceivedDate" timestamptz,
  "ScheduleStart" timestamptz,
  "ScheduleDue" timestamptz,
  "WastageType" text,
  "WastageExpenseAccount" text,
  "IssueMethodParameter" integer,
  "ValidationState" text,
  "ValidationText" text,
  "IsBatchSnExists" boolean,
  "PurchaseFulfillmentTaskID" text,
  "CustomField1" text,
  "CustomField2" text,
  "CustomField3" text,
  "CustomField4" text,
  "CustomField5" text,
  "CustomField6" text,
  "CustomField7" text,
  "CustomField8" text,
  "CustomField9" text,
  "CustomField10" text
);

create table "vProductionRunCoManTask" (
  "ID" text,
  "OperationID" text,
  "Type" integer,
  "TaskStatus" text,
  "TaskNumber" text,
  "SaleTaskID" text,
  "PurchaseTaskID" text,
  "TransferTaskID" text,
  "CombinedReceivingStatus" text,
  "CombinedPickingStatus" text,
  "CombinedShippingStatus" text,
  "CombinedInvoiceStatus" text,
  "IsPurchaseDropShip" boolean,
  "IsServicePurchase" boolean
);

create table "vProductionRunCoManTaskLine" (
  "ID" text,
  "OperationID" text,
  "TaskID" text,
  "TaskNo" text,
  "ProductID" text,
  "ProductCode" text,
  "ProductName" text,
  "ProductType" text,
  "CostingMethod" text,
  "Quantity" numeric,
  "BatchSN" text,
  "ExpiryDate" timestamptz,
  "LocationID" text,
  "LocationName" text,
  "ReceivedDate" timestamptz,
  "Cost" numeric,
  "Type" text,
  "Unit" text
);

create table "vProductionRunComponent" (
  "RunComponentID" text,
  "OperationID" text,
  "ProductID" text,
  "ProductName" text,
  "ProductSku" text,
  "ProductType" text,
  "Quantity" numeric,
  "WastageQty" numeric,
  "WastagePercent" numeric,
  "ProductCost" numeric,
  "UnitCost" numeric,
  "TotalCost" numeric,
  "CostingMethod" text,
  "BinID" text,
  "BinName" text,
  "BatchSN" text,
  "ExpiryDate" timestamptz,
  "Available" numeric,
  "Unit" text,
  "IsProductionBom" boolean,
  "ReservedQuantity" numeric,
  "IsBackflush" boolean,
  "IsNotEnough" boolean,
  "ValidationState" text,
  "ValidationText" text
);

create table "vProductionRunCost" (
  "RunCostID" text,
  "OperationID" text,
  "ProductID" text,
  "ProductName" text,
  "ResourceID" text,
  "ResourceName" text,
  "AccountName" text,
  "ExpenseAccount" text,
  "Comments" text,
  "Cost" numeric,
  "ValidationState" text,
  "ValidationText" text
);

create table "vProductionRunCreate" (
  "Number" integer,
  "Quantity" numeric,
  "RemainingQuantity" numeric,
  "ValidationState" text,
  "ValidationText" text
);

create table "vProductionRunManualJournal" (
  "JournalID" text,
  "ProductionRunID" text,
  "Reference" text,
  "Amount" numeric,
  "Date" timestamptz,
  "Debit" text,
  "Credit" text,
  "OperationID" text,
  "OperationName" text,
  "ValidationState" text,
  "ValidationText" text
);

create table "vProductionRunOperation" (
  "OperationID" text,
  "ProductionRunID" text,
  "Status" text,
  "Order" integer,
  "Name" text,
  "PlannedTime" integer,
  "PlannedTimeString" text,
  "ActualTime" integer,
  "ActualTimeString" text,
  "UnitsPerCycle" numeric,
  "WorkCenterID" text,
  "WorkCenterName" text,
  "WorkCenterCode" text,
  "WorkCenterCoManProcurementType" text,
  "StartDate" timestamptz,
  "EndDate" timestamptz,
  "ActualStartDate" timestamptz,
  "ActualEndDate" timestamptz,
  "DueDate" timestamptz,
  "TotalCost" numeric,
  "OperationType" integer,
  "SourceOperationID" text,
  "SuspendReason" text,
  "DowntimeType" integer,
  "CoManStatus" text,
  "IsDropShip" boolean,
  "IsBackflush" boolean,
  "ValidationState" text,
  "ValidationText" text,
  "ManualStartDate" timestamptz,
  "ManualEndDate" timestamptz,
  "CustomField1" text,
  "CustomField2" text,
  "CustomField3" text,
  "CustomField4" text,
  "CustomField5" text,
  "CustomField6" text,
  "CustomField7" text,
  "CustomField8" text,
  "CustomField9" text,
  "CustomField10" text
);

create table "vProductionRunOperationAttachment" (
  "AttachmentID" text,
  "RunOperationID" text,
  "FileName" text,
  "Date" timestamptz,
  "ContentType" text,
  "BlobGuid" text,
  "Position" integer,
  "FromOrder" boolean,
  "ValidationState" text,
  "ValidationText" text
);

create table "vProductionRunOperationNote" (
  "NoteID" text,
  "RunOperationID" text,
  "Note" text,
  "Position" integer,
  "ValidationState" text,
  "ValidationText" text
);

create table "vProductionRunOperationNoteItem" (
  "ItemID" text,
  "Type" text,
  "Value" text,
  "OperationID" text,
  "AttachmentFileName" text,
  "AttachmentDate" timestamptz,
  "AttachmentContentType" text,
  "AttachmentBlobGuid" text,
  "AttachmentID" text,
  "OrderOperationAttachmentID" text,
  "FromOrder" boolean,
  "NoteID" text,
  "Note" text,
  "Position" integer
);

create table "vProductionRunOperationPrintSelectModel" (
  "Selected" boolean,
  "Name" text,
  "OperationID" text
);

create table "vProductionRunOperationProduct" (
  "ID" text,
  "OperationID" text,
  "ProductID" text,
  "Type" integer,
  "PlannedQuantity" numeric,
  "OutputQuantity" numeric,
  "WastageQuantity" numeric,
  "LocationID" text,
  "ProductName" text,
  "ProductSku" text,
  "Unit" text,
  "LocationName" text,
  "FixedWastageCost" numeric,
  "BatchSN" text,
  "ExpiryDate" timestamptz,
  "ValidationState" text,
  "ValidationText" text
);

create table "vProductionRunOutputLine" (
  "ID" text,
  "ProductionRunID" text,
  "PutAwayID" text,
  "WastageID" text,
  "Quantity" numeric,
  "WastageQuantity" numeric,
  "LocationID" text,
  "LocationName" text,
  "BatchSN" text,
  "ExpiryDate" timestamptz,
  "ProductID" text,
  "ProductCode" text,
  "ProductName" text,
  "CostingMethod" text,
  "Unit" text,
  "ReceivedDate" timestamptz,
  "FixedCost" numeric,
  "CostCalculationType" integer,
  "Received" boolean,
  "CardID" text,
  "CardQuantity" numeric,
  "UnitCost" numeric,
  "IsPending" boolean,
  "CustomField1" jsonb,
  "CustomField2" jsonb,
  "CustomField3" jsonb,
  "CustomField4" jsonb,
  "CustomField5" jsonb,
  "CustomField6" jsonb,
  "CustomField7" jsonb,
  "CustomField8" jsonb,
  "CustomField9" jsonb,
  "CustomField10" jsonb,
  "ValidationState" text,
  "ValidationText" text
);

create table "vProductionRunProductItem" (
  "ID" text,
  "ItemType" text,
  "OperationProductType" integer,
  "OperationID" text,
  "ProductID" text,
  "ProductName" text,
  "ProductSku" text,
  "ProductType" text,
  "PlannedQuantity" numeric,
  "Quantity" numeric,
  "WastageQuantity" numeric,
  "ActualQuantity" numeric,
  "ProductCost" numeric,
  "UnitCost" numeric,
  "TotalCost" numeric,
  "CostingMethod" text,
  "LocationID" text,
  "LocationName" text,
  "BatchSN" text,
  "ExpiryDate" timestamptz,
  "Available" numeric,
  "Unit" text,
  "ReceivedDate" timestamptz,
  "CostCalculationType" integer,
  "IsProductionBom" boolean,
  "IsReserved" boolean,
  "IsBackflush" boolean,
  "ReservedQuantity" numeric,
  "IsNotEnough" boolean,
  "ValidationState" text,
  "ValidationText" text
);

create table "vProductionRunPutAway" (
  "ID" text,
  "ProductionRunID" text,
  "Quantity" numeric,
  "LocationID" text,
  "LocationName" text,
  "BatchSN" text,
  "ExpiryDate" timestamptz,
  "ProductID" text,
  "ProductCode" text,
  "ProductName" text,
  "CostingMethod" text,
  "Unit" text,
  "ReceivedDate" timestamptz,
  "FixedCost" numeric,
  "CostCalculationType" integer,
  "Received" boolean,
  "CardID" text,
  "CardQuantity" numeric,
  "UnitCost" numeric,
  "CustomField1" text,
  "CustomField2" text,
  "CustomField3" text,
  "CustomField4" text,
  "CustomField5" text,
  "CustomField6" text,
  "CustomField7" text,
  "CustomField8" text,
  "CustomField9" text,
  "CustomField10" text,
  "ValidationState" text,
  "ValidationText" text
);

create table "vProductionRunResource" (
  "RunResourceID" text,
  "OperationID" text,
  "ResourceID" text,
  "ResourceName" text,
  "ResourceCode" text,
  "UnitCost" numeric,
  "TotalCost" numeric,
  "Quantity" numeric,
  "CycleTime" integer,
  "Available" integer,
  "Cost" numeric,
  "ValidationState" text,
  "ValidationText" text
);

create table "vProductionRunTraceability" (
  "TraceabilityID" text,
  "RunID" text,
  "ProducedProductID" text,
  "ProducedProductBatchSN" text,
  "ProducedProductExpiryDate" timestamptz,
  "ProducedProductDisplayName" text,
  "UsedProductID" text,
  "UsedProductBatchSN" text,
  "UsedProductExpiryDate" timestamptz,
  "UsedProductDisplayName" text,
  "UsedFullBatchSN" text,
  "IsPending" boolean,
  "ValidationState" text,
  "ValidationText" text
);

create table "vPurchaseExpense" (
  "TaskID" text,
  "AccountCode" text,
  "AccountName" text,
  "Amount" numeric,
  "Invoices" text,
  "DistributedAmount" numeric,
  "LeftToDistribute" numeric,
  "Selected" boolean
);

create table "vReportTemplate" (
  "TemplateID" text,
  "Name" text
);

create table "vResource" (
  "ResourceID" text,
  "Code" text,
  "Name" text,
  "IsSelected" boolean
);

create table "vRunComponent" (
  "FakeKey" text,
  "ProductID" text,
  "ProductCode" text,
  "Name" text,
  "Available" numeric,
  "Cost" numeric,
  "CostingMethod" text,
  "Type" text,
  "ExpenseAccount" text,
  "Unit" text,
  "BatchSN" text,
  "ExpiryDate" timestamptz,
  "BinID" text,
  "BinName" text,
  "IsProductionBom" boolean
);

create table "vRunResources" (
  "FakeID" text,
  "ResourceID" text,
  "ResourceName" text,
  "ResourceCode" text,
  "ResourceCost" numeric,
  "CycleDuration" integer,
  "Available" numeric
);

create table "vSaleOrder" (
  "TaskID" text,
  "SaleOrderNumber" text,
  "ShipmentRequiredByDate" timestamptz,
  "OrderLocationID" text
);

create table "vSaleTaskWmsOperator" (
  "ID" text,
  "TaskID" text,
  "UserName" text,
  "StartedPickDate" timestamptz
);

create table "vSchedulerLinks" (
  "FakeID" text,
  "Source" text,
  "Target" text
);

create table "vSchedulerOperation" (
  "OperationID" text,
  "ProductionOrderID" text,
  "OperationName" text,
  "OperationOrder" integer,
  "OperationStatus" text,
  "WorkCenterID" text,
  "CycleTime" integer,
  "ActualTime" integer,
  "RunID" text,
  "FromDateUtc" timestamptz,
  "ToDateUtc" timestamptz,
  "FromDate" timestamptz,
  "ToDate" timestamptz,
  "Duration" integer,
  "Progress" numeric
);

create table "vSchedulerOperationItem" (
  "FakeID" text,
  "OperationID" text,
  "FromDateUtc" timestamptz,
  "ToDateUtc" timestamptz,
  "FromDate" timestamptz,
  "ToDate" timestamptz,
  "WorkCenterColorCode" text
);

create table "vSchedulerOperationResource" (
  "FakeID" text,
  "OperationID" text,
  "ResourceID" text,
  "Quantity" numeric
);

create table "vSchedulerOrderOperation" (
  "OperationID" text,
  "ProductionOrderID" text,
  "OperationName" text,
  "OperationOrder" integer,
  "OperationStatus" text,
  "WorkCenterID" text,
  "CycleTime" integer,
  "ActualTime" integer,
  "RunID" text,
  "FromDateUtc" timestamptz,
  "ToDateUtc" timestamptz,
  "FromDate" timestamptz,
  "ToDate" timestamptz,
  "Duration" integer
);

create table "vSchedulerRun" (
  "RunID" text,
  "ProductionOrderID" text,
  "Number" integer,
  "Status" text,
  "Quantity" numeric,
  "WIPAccount" text,
  "StartDate" timestamptz,
  "EndDate" timestamptz,
  "DueDate" timestamptz,
  "ReceivedDate" timestamptz,
  "ScheduleStart" timestamptz,
  "ScheduleDue" timestamptz,
  "ScheduleStartLocal" timestamptz,
  "ScheduleDueLocal" timestamptz,
  "BufferSize" integer,
  "LackOfComponents" boolean,
  "RunRequiredByDate" timestamptz,
  "Progress" numeric,
  "ValidationState" text,
  "ValidationText" text
);

create table "vServiceProduct" (
  "ProductID" text,
  "Name" text,
  "PriceTear1" numeric,
  "PriceTear2" numeric,
  "PriceTear3" numeric,
  "PriceTear4" numeric,
  "PriceTear5" numeric,
  "PriceTear6" numeric,
  "PriceTear7" numeric,
  "PriceTear8" numeric,
  "PriceTear9" numeric,
  "PriceTear10" numeric,
  "ExpenseAccount" text
);

create table "vShopFloor" (
  "LocationID" text,
  "Description" text
);

create table "vSourceTask" (
  "SourceTaskID" text,
  "SourceOrderNumber" text,
  "ShipmentRequiredByDate" timestamptz,
  "Retail" text,
  "RepID" text,
  "RepName" text,
  "SourceType" text
);

create table "vSuspendReasons" (
  "Reason" text,
  "DowntimeType" integer,
  "WorkCenterIDs" text
);

create table "vSuspendReasonsWrapper" (
  "FakeID" text
);

create table "vUser" (
  "UserName" text,
  "LoweredUserName" text
);

create table "vWorkCenter" (
  "WorkCenterID" text,
  "Code" text,
  "Name" text,
  "IsCoMan" boolean,
  "CoManProcurementType" text,
  "IsCoManPurchase" boolean
);

create table "vWorkCenterLocation" (
  "ID" text,
  "WorkCenterID" text,
  "LocationID" text,
  "ParentLocationID" text,
  "LocationName" text,
  "Type" integer
);

create table "vWorkCenterSupplier" (
  "WorkCenterID" text,
  "SupplierID" text,
  "SupplierName" text
);
