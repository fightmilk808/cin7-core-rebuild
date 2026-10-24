-- POS: one table per Cin7 Core data model, generated from data/models.json

create table "AspnetRole" (
  "RoleId" text,
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
  "ConfigID" text,
  "ShopName" text
);

create table "EcsProductDetails" (
  "ProductID" text,
  "SyncStockLevel" boolean,
  "UseBufferInventory" boolean,
  "BufferInventory" integer,
  "SyncBufferInventory" integer,
  "SyncQuantity" numeric
);

create table "OutletSelector" (
  "PosOutletID" text,
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
  "UserId" text,
  "UserName" text,
  "Name" text
);

create table "vBanknoteDenomination" (
  "BanknoteID" text,
  "Code" text,
  "Nominal" numeric
);

create table "vCCLP" (
  "CustomerID" text,
  "Name" text,
  "LoyaltyPoints" numeric,
  "StoreCredits" numeric,
  "SendReceiptViaEmail" boolean
);

create table "vECSOrderLog" (
  "LogID" text,
  "ConfigID" text,
  "Date" timestamptz,
  "DownloadDate" timestamptz,
  "ProcessDate" timestamptz,
  "OrderNumber" text,
  "SaleTaskID" text,
  "Status" text,
  "Type" text,
  "SaleOrderNumber" text,
  "RefundID" text,
  "OrderID" text,
  "IsNewSale" boolean
);

create table "vECSPaymentsToExport" (
  "TaskID" text,
  "OrderID" text,
  "OrderNumber" text,
  "TaskID" text,
  "InvoiceNumber" text,
  "Error" text
);

create table "vECSPendingOrdersNew" (
  "OrderLineID" text,
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
  "LogID" text,
  "ConfigID" text,
  "ECSPurchaseID" text,
  "ECSPurchaseNumber" text,
  "ECSStatus" text,
  "DearPurchaseID" text,
  "CreatedDate" timestamptz,
  "ReceivedDate" timestamptz,
  "Location" text,
  "DearStatus" text,
  "DearOrderNumber" text
);

create table "vECSStockAdjustments" (
  "LogID" text,
  "ConfigID" text,
  "ECSStockAdjustmentID" text,
  "ECSStockAdjustmentNumber" text,
  "ECSStatus" text,
  "DearStockAdjustmentID" text,
  "CreatedDate" timestamptz,
  "CompletedDate" timestamptz,
  "DearStatus" text,
  "DearNumber" text
);

create table "vECSStockTransfers" (
  "LogID" text,
  "ConfigID" text,
  "ECSStockTransferID" text,
  "ECSStockTransferNumber" text,
  "ECSStatus" text,
  "DearStockTransferID" text,
  "FromLocation" text,
  "ToLocation" text,
  "CreatedDate" timestamptz,
  "ReceivedDate" timestamptz,
  "DearStatus" text,
  "DearNumber" text
);

create table "vEcsBulkListing" (
  "ProductID" text,
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
  "TenantID" text,
  "ShopName" text,
  "AccessToken" text,
  "RefreshToken" text,
  "PrimaryPriceTier" integer,
  "ConsolidationType" text,
  "ConsolidationTimeText" text,
  "ConsolidateToCustomerID" text,
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
  "LocationID" text,
  "EnableOrderRouting" boolean,
  "CreateAssembly" text,
  "IgnoreRestockForNotFulfilled" boolean,
  "IsConsolidateBySettlement" boolean,
  "GroupTransactionBy" text,
  "ConsolidationSubType" text
);

create table "vEcsOverviewCustomersList" (
  "CustomerID" text,
  "Name" text,
  "OrderCount" integer,
  "PaidTotalAmount" numeric,
  "ConfigID" text
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
  "TaskID" text,
  "TT" integer,
  "ConfigID" text
);

create table "vLocation" (
  "LocationID" text,
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
  "SurchargeID" text,
  "PaymentMethodID" text,
  "ConfigID" text
);

create table "vPosOutlets" (
  "PosOutletID" text,
  "LocationID" text,
  "OutletName" text,
  "TimeZone" text,
  "DefaultTaxRule" text,
  "LocationName" text,
  "DefaultTaxRuleName" text,
  "CountRegistry" integer,
  "EcsPaymentProcessorID" text,
  "LedgerAccount" text,
  "ReceiptID" text,
  "PrintNotes" boolean,
  "PrintDiscounts" boolean,
  "Active" boolean,
  "SquareIntegrationID" text,
  "PaymentSenseURL" text,
  "PaymentSenseAPIKey" text,
  "SurchargeTaxRule" text,
  "PaymentSenseAPIKey" text,
  "TyroMerchantID" text,
  "TriPOSAccountID" text,
  "TriPOSAcceptorID" text,
  "TriPOSAccountToken" text,
  "CustomizedCustomerDisplayUI" boolean,
  "CustomerDisplayLogo" text,
  "CustomerDisplayBackground" text
);

create table "vPosProductEx" (
  "ProductID" text,
  "Name" text,
  "SKU" text,
  "Category" text,
  "OutletSKU" text,
  "ConfigID" text,
  "PosOutletID" text,
  "ValidationText" text,
  "ValidationState" text
);

create table "vPosQuickKey" (
  "QuickKeyID" text,
  "Name" text,
  "ContentQuery" text
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

create table "vReceiptTemplate" (
  "TemplateID" text,
  "Name" text
);

create table "vRegistries" (
  "ConfigID" text,
  "RegistryID" text,
  "RegistryCode" text,
  "LocationID" text,
  "LocationName" text,
  "EcsPaymentProcessorID" text,
  "LedgerAccount" text,
  "ReceiptID" text,
  "TillDiscrepancyMapping" text,
  "CashFloatMapping" text,
  "PettyCashMapping" text,
  "CashInOutMapping" text,
  "RegistryPrefix" text,
  "RegistrySuffix" text,
  "Active" boolean,
  "QuickKeyID" text,
  "UseTyro" boolean,
  "TyroTerminalID" text,
  "UseTriPOS" boolean,
  "TriPOSLaneID" text,
  "CatalogTilesSize" text,
  "CatalogTilesVisibility" text,
  "ShowProductAvailability" boolean,
  "LinklyUserName" text,
  "LinklyPassword" text,
  "WindcaveStation" text
);

create table "vReportTemplate" (
  "TemplateID" text,
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
  "RuleID" text,
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
  "UserId" text,
  "ImageID" text,
  "ContentType" text,
  "FileName" text,
  "Uri" text,
  "isDefault" boolean,
  "IsImage" boolean
);
