-- Faire: one table per Cin7 Core data model, generated from data/models.json

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

create table "FaireCarrierCode" (
  "ECSCarrierCode" text
);

create table "OrderStatusStore" (
  "type" text,
  "description" text
);

create table "TopicStore" (
  "type" text,
  "description" text
);

create table "vAccount" (
  "Code" text,
  "DisplayName" text
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

create table "vEcsCarriersMapping" (
  "ID" text,
  "ECSConfigID" text,
  "CarrierID" text,
  "Description" text,
  "ECSCarrierCode" text
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

create table "vEcsOperationLog" (
  "ID" text,
  "ConfigID" text,
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

create table "vEcsPaymentProcessorMapping" (
  "ID" text,
  "ConfigID" text,
  "PaymentProcessorID" text,
  "PaymentProcessorName" text,
  "LedgerAccount" text,
  "AccountName" text,
  "SortOrder" text
);

create table "vEcsTaxMapping" (
  "ID" text,
  "ECSConfigID" text,
  "ECSTaxType" text,
  "ECSTaxID" text,
  "Description" text,
  "Value" text,
  "TaxRuleName" text,
  "SortOrder" integer
);

create table "vFaireTaxonomyType" (
  "Id" text,
  "Name" text
);

create table "vLocation" (
  "LocationID" text,
  "Description" text
);

create table "vTax" (
  "RuleID" text,
  "Description" text
);

create table "vTime" (
  "Value" text,
  "Name" text
);
