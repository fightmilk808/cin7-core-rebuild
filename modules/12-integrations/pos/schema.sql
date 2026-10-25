-- POS: one table per Cin7 Core data model, generated from data/models.json

create table "AspnetRole" (
  "RoleId" text,  -- -> Role
  "RoleName" text
);

create table "CashManagementReason" (
  "ID" text,
  "ReasonName" text
);

create table "Category2" (
  "Category" text
);

create table "ConsolidationStore" (
  "type" text,
  "description" text
);

create table "ECommerceShop" (
  "ConfigID" text,  -- -> IntegrationConfig
  "ShopName" text
);

create table "EcsProductDetails" (
  "ProductID" text,  -- -> Product
  "SyncStockLevel" boolean,
  "UseBufferInventory" boolean,
  "BufferInventory" integer,
  "SyncBufferInventory" integer,
  "SyncQuantity" numeric
);

create table "OutletSelector" (
  "PosOutletID" text,  -- -> PosOutlet
  "OutletName" text
);

create table "ReferenceDataModel" (
  "ID" integer,
  "TimeZone" text,
  "TenantTaxCalculationMethod" text
);

create table "RegisterCountModel" (
  "RegisterCount" integer
);

create table "TopicStore" (
  "type" text,
  "description" text
);

create table "vAccount" (
  "Code" text,
  "DisplayName" text
);

create table "vAspnetUserRoles" (
  "UserId" text,  -- -> User
  "UserName" text,
  "Name" text
);

create table "vBanknoteDenomination" (
  "BanknoteID" text,  -- -> Banknote
  "Code" text,
  "Nominal" numeric
);

create table "vCCLP" (
  "CustomerID" text,  -- -> Customer
  "Name" text,
  "LoyaltyPoints" numeric,
  "StoreCredits" numeric,
  "SendReceiptViaEmail" boolean
);

create table "vECSOrderLog" (
  "LogID" text,  -- -> Log
  "ConfigID" text,  -- -> IntegrationConfig
  "Date" timestamptz,
  "DownloadDate" timestamptz,
  "ProcessDate" timestamptz,
  "OrderNumber" text,
  "SaleTaskID" text,  -- -> Sale
  "Status" text,
  "Type" text,
  "SaleOrderNumber" text,
  "RefundID" text,  -- -> Refund
  "OrderID" text,  -- -> Order (context-specific)
  "IsNewSale" boolean
);

create table "vECSPaymentsToExport" (
  "TaskID" text,  -- -> Task (any document)
  "OrderID" text,  -- -> Order (context-specific)
  "OrderNumber" text,
  "InvoiceNumber" text,
  "Error" text
);

create table "vECSPendingOrdersNew" (
  "OrderLineID" text,  -- -> Line (parent document's line)
  "OrderNumber" text,
  "DateCreated" timestamptz,
  "Name" text,
  "Quantity" numeric,
  "Total" numeric,
  "CustomerName" text,
  "Error" text,
  "ValidationText" text,
  "ValidationState" text
);

create table "vECSPurchases" (
  "LogID" text,  -- -> Log
  "ConfigID" text,  -- -> IntegrationConfig
  "ECSPurchaseID" text,  -- -> ECSPurchase
  "ECSPurchaseNumber" text,
  "ECSStatus" text,
  "DearPurchaseID" text,  -- -> DearPurchase
  "CreatedDate" timestamptz,
  "ReceivedDate" timestamptz,
  "Location" text,
  "DearStatus" text,
  "DearOrderNumber" text
);

create table "vECSStockAdjustments" (
  "LogID" text,  -- -> Log
  "ConfigID" text,  -- -> IntegrationConfig
  "ECSStockAdjustmentID" text,  -- -> ECSStockAdjustment
  "ECSStockAdjustmentNumber" text,
  "ECSStatus" text,
  "DearStockAdjustmentID" text,  -- -> DearStockAdjustment
  "CreatedDate" timestamptz,
  "CompletedDate" timestamptz,
  "DearStatus" text,
  "DearNumber" text
);

create table "vECSStockTransfers" (
  "LogID" text,  -- -> Log
  "ConfigID" text,  -- -> IntegrationConfig
  "ECSStockTransferID" text,  -- -> ECSStockTransfer
  "ECSStockTransferNumber" text,
  "ECSStatus" text,
  "DearStockTransferID" text,  -- -> DearStockTransfer
  "FromLocation" text,
  "ToLocation" text,
  "CreatedDate" timestamptz,
  "ReceivedDate" timestamptz,
  "DearStatus" text,
  "DearNumber" text
);

create table "vEcsBulkListing" (
  "ProductID" text,  -- -> Product
  "ProductCode" text,
  "Name" text,
  "Status" text,
  "Category" text,
  "ProductType" text,
  "Price" numeric,
  "Quantity" numeric,
  "UseBufferInventory" boolean,
  "BufferInventory" integer,
  "SyncBufferInventory" integer,
  "SyncQuantity" numeric
);

create table "vEcsConfiguration" (
  "ID" text,
  "TenantID" text,  -- -> Tenant
  "ShopName" text,
  "AccessToken" text,
  "RefreshToken" text,
  "PrimaryPriceTier" integer,
  "ConsolidationType" text,
  "ConsolidationTimeText" text,
  "ConsolidateToCustomerID" text,  -- -> Customer
  "IsActive" boolean,
  "PickWhenOrderStatus" text,
  "ShippingTaxed" boolean,
  "SyncStockLevel" boolean,
  "ExportShippingInformation" boolean,
  "AutoInvoicingMode" text,
  "AutoFulfilmentMode" text,
  "ECSspecificParameter1" boolean,
  "ECSspecificParameter9" text,
  "ECSspecificParameter8" text,
  "ECSspecificParameter6" boolean,
  "ECSspecificParameter10" text,
  "CustomerName" text,
  "ECSTokenType" text,
  "RevenueAccount" text,
  "MoneySettlementBankAccount" text,
  "CustomSalesRepresentative" text,
  "UseAsMasterSource" boolean,
  "CompatibleToDEAR" boolean,
  "ManualMapping" boolean,
  "AutoCreateNewProductAllowed" boolean,
  "MatchProductByName" boolean,
  "LocationID" text,  -- -> Location
  "EnableOrderRouting" boolean,
  "CreateAssembly" text,
  "IgnoreRestockForNotFulfilled" boolean,
  "IsConsolidateBySettlement" boolean,
  "GroupTransactionBy" text,
  "ConsolidationSubType" text
);

create table "vEcsOverviewCustomersList" (
  "CustomerID" text,  -- -> Customer
  "Name" text,
  "OrderCount" integer,
  "PaidTotalAmount" numeric,
  "ConfigID" text  -- -> IntegrationConfig
);

create table "vEcsOverviewSalesList" (
  "SaleOrderDate" timestamptz,
  "SaleOrderNumber" text,
  "CustomerName" text,
  "Status" text,
  "PaidTotalAmount" numeric,
  "InvoicingStatus" text,
  "OrderStatus" text,
  "FulFilmentStatus" text,
  "PaymentStatus" text,
  "TaskID" text,  -- -> Task (any document)
  "TT" integer,
  "ConfigID" text  -- -> IntegrationConfig
);

create table "vLocation" (
  "LocationID" text,  -- -> Location
  "Description" text
);

create table "vNameCodeModel" (
  "Code" text,
  "Name" text
);

create table "vPaymentMethod" (
  "Value" text,
  "Name" text
);

create table "vPaymentMethodSurcharge" (
  "SurchargeID" text,  -- -> Surcharge
  "PaymentMethodID" text,  -- -> PaymentMethod
  "ConfigID" text  -- -> IntegrationConfig
);

create table "vPosOutlets" (
  "PosOutletID" text,  -- -> PosOutlet
  "LocationID" text,  -- -> Location
  "OutletName" text,
  "TimeZone" text,
  "DefaultTaxRule" text,
  "LocationName" text,
  "DefaultTaxRuleName" text,
  "CountRegistry" integer,
  "EcsPaymentProcessorID" text,  -- -> EcsPaymentProcessor
  "LedgerAccount" text,
  "ReceiptID" text,  -- -> Receipt
  "PrintNotes" boolean,
  "PrintDiscounts" boolean,
  "Active" boolean,
  "SquareIntegrationID" text,  -- -> SquareIntegration
  "PaymentSenseURL" text,
  "PaymentSenseAPIKey" text,
  "SurchargeTaxRule" text,
  "TyroMerchantID" text,  -- -> TyroMerchant
  "TriPOSAccountID" text,  -- -> TriPOSAccount
  "TriPOSAcceptorID" text,  -- -> TriPOSAcceptor
  "TriPOSAccountToken" text,
  "CustomizedCustomerDisplayUI" boolean,
  "CustomerDisplayLogo" text,
  "CustomerDisplayBackground" text
);

create table "vPosProductEx" (
  "ProductID" text,  -- -> Product
  "Name" text,
  "SKU" text,
  "Category" text,
  "OutletSKU" text,
  "ConfigID" text,  -- -> IntegrationConfig
  "PosOutletID" text,  -- -> PosOutlet
  "ValidationText" text,
  "ValidationState" text
);

create table "vPosQuickKey" (
  "QuickKeyID" text,  -- -> QuickKey
  "Name" text,
  "ContentQuery" text
);

create table "vProductionCalendar" (
  "CalendarID" text,  -- -> Calendar
  "Year" integer,
  "WeekStart" integer,
  "ValidationState" text,
  "ValidationText" text
);

create table "vProductionCalendarDay" (
  "DayID" text,  -- -> Day
  "CalendarID" text,  -- -> Calendar
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
  "DayID" text,  -- -> Day
  "CalendarID" text,  -- -> Calendar
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

create table "vReceiptTemplate" (
  "TemplateID" text,  -- -> Template
  "Name" text
);

create table "vRegistries" (
  "ConfigID" text,  -- -> IntegrationConfig
  "RegistryID" text,  -- -> Registry
  "RegistryCode" text,
  "LocationID" text,  -- -> Location
  "LocationName" text,
  "EcsPaymentProcessorID" text,  -- -> EcsPaymentProcessor
  "LedgerAccount" text,
  "ReceiptID" text,  -- -> Receipt
  "TillDiscrepancyMapping" text,
  "CashFloatMapping" text,
  "PettyCashMapping" text,
  "CashInOutMapping" text,
  "RegistryPrefix" text,
  "RegistrySuffix" text,
  "Active" boolean,
  "QuickKeyID" text,  -- -> QuickKey
  "UseTyro" boolean,
  "TyroTerminalID" text,  -- -> TyroTerminal
  "UseTriPOS" boolean,
  "TriPOSLaneID" text,  -- -> TriPOSLane
  "CatalogTilesSize" text,
  "CatalogTilesVisibility" text,
  "ShowProductAvailability" boolean,
  "LinklyUserName" text,
  "LinklyPassword" text,
  "WindcaveStation" text
);

create table "vReportTemplate" (
  "TemplateID" text,  -- -> Template
  "Name" text
);

create table "vSquareIntegration" (
  "ID" text,
  "ShopName" text
);

create table "vSurcharge" (
  "PaymentMethod" text,
  "Type" text,
  "FlatAmount" numeric,
  "Rate" numeric,
  "MaxAmount" numeric
);

create table "vTax" (
  "RuleID" text,  -- -> Rule (context-specific)
  "Description" text
);

create table "vTime" (
  "Value" text,
  "Name" text
);

create table "vTimezone" (
  "name" text,
  "displayName" text
);

create table "vUserImage" (
  "UserId" text,  -- -> User
  "ImageID" text,  -- -> Blob (stored file)
  "ContentType" text,
  "FileName" text,
  "Uri" text,
  "isDefault" boolean,
  "IsImage" boolean
);
