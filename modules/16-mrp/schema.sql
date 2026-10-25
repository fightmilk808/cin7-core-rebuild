-- MRP: one table per Cin7 Core data model, generated from data/models.json

create table "vBrand" (
  "BrandID" text,  -- -> Brand
  "Name" text
);

create table "vCategory" (
  "CategoryID" text,  -- -> ProductCategory
  "Name" text
);

create table "vCustomerID" (
  "CustomerID" text,  -- -> Customer
  "Name" text,
  "MRPSettingsID" text  -- -> MRPSettings
);

create table "vError" (
  "Message" text
);

create table "vForecastError" (
  "Line" integer,
  "DemandLocation" text,
  "ProductSku" text,
  "ProductName" text,
  "Quantity" numeric,
  "RequiredByDate" timestamptz,
  "ValidationState" text,
  "ValidationText" text
);

create table "vLocationID" (
  "LocationID" text,  -- -> Location
  "Name" text,
  "MRPSettingsID" text  -- -> MRPSettings
);

create table "vLog" (
  "LogID" text,  -- -> Log
  "Action" text,
  "Message" text,
  "AdditionalInfo" text,
  "LogDate" timestamptz,
  "Error" text,
  "LogType" text,
  "SyncID" text,  -- -> Sync
  "AffectedEntitiesCount" integer,
  "ValidationText" text,
  "ValidationState" text
);

create table "vMRP" (
  "Number" text,
  "CreatedBy" text,
  "CreatedAt" timestamptz,
  "Status" text
);

create table "vMRPSettings" (
  "ID" text,
  "Name" text,
  "PlanningPeriodStart" timestamptz,
  "PlanningPeriodEnd" timestamptz,
  "SupplyCalculation" text,
  "SupplyTask" integer,
  "IsIgnoreStockOnHand" boolean,
  "IsProcureUpToStockLevel" boolean,
  "IsProcureUpToMinimumBeforeReorder" boolean,
  "IsIncludePastDueDemand" boolean,
  "IsIncludeDraft" boolean,
  "IsBomExplosion" boolean,
  "IsIncludeForecast" boolean,
  "ForecastID" text,  -- -> Forecast
  "DemandSales" text,
  "IsDemandProductionDraft" boolean,
  "IsDemandProductionPlanned" boolean,
  "IsDemandProductionReleased" boolean,
  "IsDemandAssemblyDraft" boolean,
  "IsDemandAssemblyReleased" boolean,
  "IsDemandTransferDraft" boolean,
  "SupplyTaskPurchaseStatus" text,
  "SupplyTaskTransferStatus" text,
  "SupplyTaskProductionOrderStatus" text,
  "SupplyTaskAssemblyStatus" text,
  "SalesForecastTemplateName" text,
  "IsLoadDetails" boolean,
  "ConsolidationType" text
);

create table "vSuggestionProduct" (
  "ProductID" text,  -- -> Product
  "ProductCode" text,
  "ProductName" text,
  "Quantity" numeric,
  "UnitOfMeasure" text,
  "ProductBOM" text,
  "MrpSupplySuggestionID" text,  -- -> MrpSupplySuggestion
  "IsSplitted" boolean
);

create table "vSupplyItem" (
  "ID" text,
  "Name" text
);

create table "vSupplyResult" (
  "ID" text,
  "TaskID" text,  -- -> Task (any document)
  "TaskNumber" text,
  "TaskType" text,
  "CreatedAt" timestamptz,
  "SupplyName" text,
  "DemandLocationName" text,
  "RequiredByDate" timestamptz,
  "TaskStatus" text,
  "CreatedBy" text,
  "TotalQuantity" numeric
);

create table "vSupplySuggestion" (
  "ID" text,
  "MRPID" text,  -- -> MRP
  "SupplyTask" text,
  "DemandLocationID" text,  -- -> DemandLocation
  "DemandLocationName" text,
  "SupplyID" text,  -- -> Supply
  "SupplyName" text,
  "RequiredByDate" timestamptz,
  "DocumentDate" timestamptz,
  "TaskStatus" text,
  "IsSelected" boolean,
  "ValidationState" text,
  "ValidationText" text,
  "IsSupplyTaskChanged" boolean
);

create table "vSupplyTask" (
  "Value" text
);

create table "vSuppySuggestionsWrapper" (
  "ID" integer
);
