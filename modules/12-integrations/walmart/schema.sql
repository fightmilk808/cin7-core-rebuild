-- Walmart: one table per Cin7 Core data model, generated from data/models.json

create table "ConsolidationStore" (
  "type" text,
  "description" text
);

create table "CtlgProduct" (
  "ProductID" text,  -- -> Product
  "ProductCode" text,
  "Name" text,
  "Available" numeric,
  "OnHand" numeric,
  "ImageID" text,  -- -> Blob (stored file)
  "IsStockProduct" boolean
);

create table "ECommerceShop" (
  "ConfigID" text,  -- -> IntegrationConfig
  "ShopName" text
);

create table "TopicStore" (
  "type" text,
  "description" text
);

create table "vAccount" (
  "Code" text,
  "DisplayName" text
);

create table "vBankAccount" (
  "AccountCode" text,
  "DisplayName" text
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

create table "vEcsCatalogItemNew" (
  "SIMID" text,  -- -> SIM
  "ProductID" text,  -- -> Product
  "FamilyID" text,  -- -> ProductFamily
  "EntityType" text,
  "LinkedSKU" text,
  "LinkedName" text,
  "SKU" text,
  "Name" text,
  "Status" text,
  "ImageID" text,  -- -> Blob (stored file)
  "SyncStockLevel" boolean,
  "Price" numeric,
  "Category" text,
  "Option1" text,
  "Option2" text,
  "Option3" text,
  "IsStockProduct" boolean,
  "IgnoreProductUpdation" boolean,
  "Quantity" numeric
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

create table "vEcsOperationLog" (
  "ID" text,
  "ConfigID" text,  -- -> IntegrationConfig
  "Date" timestamptz,
  "Description" text,
  "Category" text,
  "Processed" boolean,
  "Type" integer,
  "UserName" text,
  "ConfigName" text,
  "ConfigType" text,
  "Disabled" boolean
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

create table "vEcsPaymentProcessorMapping" (
  "ID" text,
  "ConfigID" text,  -- -> IntegrationConfig
  "PaymentProcessorID" text,  -- -> PaymentProcessor
  "PaymentProcessorName" text,
  "LedgerAccount" text,
  "AccountName" text,
  "SortOrder" text
);

create table "vEcsTaxMapping" (
  "ID" text,
  "ECSConfigID" text,  -- -> IntegrationConfig
  "ECSTaxType" text,
  "ECSTaxID" text,  -- -> ECSTax
  "Description" text,
  "Value" text,
  "TaxRuleName" text,
  "SortOrder" integer
);

create table "vLocation" (
  "LocationID" text,  -- -> Location
  "Description" text
);

create table "vPaymentAccount" (
  "Code" text,
  "DisplayName" text
);

create table "vTax" (
  "RuleID" text,  -- -> Rule (context-specific)
  "Description" text
);

create table "vTime" (
  "Value" text,
  "Name" text
);
