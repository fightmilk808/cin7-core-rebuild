-- Shopify: one table per Cin7 Core data model, generated from data/models.json

create table "ConsolidationFrequencyModel" (
  "value" integer,
  "description" text
);

create table "ConsolidationTypeModel" (
  "value" text,
  "text" text
);

create table "ECommerceShop" (
  "ConfigID" text,
  "ShopName" text
);

create table "MasterDataSource" (
  "name" text,
  "value" text
);

create table "PaymentReferenceStore" (
  "type" text,
  "description" text
);

create table "TopicStore" (
  "type" text,
  "description" text
);

create table "stateList" (
  "Code" text,
  "Value" text
);

create table "vAccount" (
  "Code" text,
  "DisplayName" text
);

create table "vLocation" (
  "LocationID" text,
  "Description" text
);

create table "vReportLayout" (
  "Fakeid" text,
  "ReportName" text,
  "LayoutName" text,
  "Layout" text
);

create table "vSaleAttribute" (
  "Id" integer,
  "Name" text,
  "Type" text
);

create table "vShopifyCatalogBulkListing" (
  "ProductID" text,
  "ProductCode" text,
  "Name" text,
  "Status" text,
  "Available" integer,
  "CategoryName" text,
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
  "SellOutOfStock" boolean,
  "UseBufferInventory" boolean,
  "BufferInventory" integer,
  "SyncBufferInventory" integer,
  "SyncQuantity" numeric,
  "IsLinkToKitProduct" boolean
);

create table "vShopifyCatalogList" (
  "ProductID" text,
  "ProductCode" text,
  "Name" text,
  "Status" text,
  "PriceTier" integer,
  "Available" integer,
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
  "SellOutOfStock" boolean,
  "UseBufferInventory" boolean,
  "BufferInventory" integer,
  "SyncBufferInventory" integer,
  "SyncQuantity" numeric,
  "IsLinkToKitProduct" boolean
);

create table "vShopifyConfiguration" (
  "ConfigID" text,
  "TenantID" text,
  "ShopName" text,
  "AccessToken" text,
  "LastCheck" timestamptz,
  "IsActive" boolean,
  "ConsolidationType" text,
  "ConsolidationTimeText" text,
  "ConsolidateToCustomerID" text,
  "CustomerName" text,
  "Topic" text,
  "ShippingTaxed" boolean,
  "SyncStockLevel" boolean,
  "ListAsDraft" boolean,
  "AllowDuplicateNames" boolean,
  "UseCompanyAsCustomer" boolean,
  "AddCompanyToAddresses" boolean,
  "UploadFulfilmentWithoutTrackingNumber" boolean,
  "SellOutOfStock" boolean,
  "BringDiscountCodes" boolean,
  "AutoShippingMode" text,
  "InvoiceStatus" text,
  "LiabilityAccount" text,
  "RevenueAccount" text,
  "CustomSalesRepresentative" text,
  "PriceTier" integer,
  "LocationID" text,
  "LocationName" text,
  "NotAllScopesAdded" boolean,
  "EnableOrderRouting" boolean,
  "AddDiscountAsChangedPrice" boolean,
  "AppendTrackingNumberToTrackingUrl" boolean,
  "CreateAssembly" text,
  "AutoSyncRetry" boolean,
  "HighLoad" boolean,
  "IgnoreRestockForNotFulfilled" boolean,
  "CreationDate" timestamptz,
  "UseBufferInventory" boolean,
  "BufferInventory" integer,
  "EnablePartialFulfillment" boolean,
  "SupportDuplicatedSKU" boolean,
  "CustomFieldForTags" integer,
  "CustomFieldForType" integer,
  "MasterDataSource" text,
  "RetailDeliveryAccount" text,
  "Country" text,
  "UseLogging" boolean,
  "CompareAtPriceTier" integer,
  "LoadOrdersFromShopify" boolean,
  "OrderLockDate" text,
  "LoadAdditionalProductProperties" boolean,
  "PaymentReferenceType" text,
  "OrderExclusionTags" text,
  "ImportProductsAutomatically" boolean,
  "ImportProductsFromDate" text,
  "HonourShopifyLocation" boolean,
  "TimeDelayOrderDownloadMinutes" integer,
  "ConsolidationFrequencyHours" integer
);

create table "vShopifyLocation" (
  "ID" text,
  "ConfigID" text,
  "ShopifyLocationName" text,
  "ShopifyLocationID" integer,
  "IsFulfillmentLocation" boolean,
  "IsActive" boolean,
  "LocationID" text,
  "LocationName" text,
  "IsSelected" boolean
);

create table "vShopifyLog" (
  "LogID" text,
  "ConfigID" text,
  "Date" timestamptz,
  "DownloadDate" timestamptz,
  "ProcessDate" timestamptz,
  "OrderNumber" text,
  "SaleTaskID" text,
  "InventoryTaskID" text,
  "Status" text,
  "Type" text,
  "FulfillmentNumber" numeric,
  "SaleOrderNumber" text,
  "StocktakeNumber" text,
  "TT" numeric
);

create table "vShopifyOperationLog" (
  "ID" text,
  "ConfigID" text,
  "Date" timestamptz,
  "Description" text,
  "Category" text,
  "Processed" boolean,
  "Type" integer,
  "UserName" text,
  "TT" integer
);

create table "vShopifyPaymentProcessorMapping" (
  "ID" text,
  "ConfigID" text,
  "PaymentProcessor" text,
  "AccountCode" text,
  "SortOrder" integer,
  "AccountName" text
);

create table "vShopifyPendingOrders" (
  "OrderLineID" text,
  "OrderNumber" text,
  "InvoiceDate" timestamptz,
  "Name" text,
  "Quantity" numeric,
  "Total" numeric,
  "Contact" text,
  "Error" text,
  "ValidationText" text,
  "ValidationState" text
);

create table "vShopifyTaxMapping" (
  "ID" text,
  "ConfigID" text,
  "Country" text,
  "Province" text,
  "Name" text,
  "Value" text,
  "SortOrder" integer,
  "TaxRuleName" text
);

create table "vTax" (
  "RuleID" text,
  "Description" text
);

create table "vTime" (
  "Value" text,
  "Name" text
);
