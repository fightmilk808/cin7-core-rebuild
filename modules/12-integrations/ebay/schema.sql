-- eBay: one table per Cin7 Core data model, generated from data/models.json

create table "ConsolidationStore" (
  "type" text,
  "description" text
);

create table "CtlgFamily" (
  "FamilyID" text,  -- -> ProductFamily
  "SKU" text,
  "Name" text,
  "Category" text,
  "Brand" text,
  "SKUCount" numeric,
  "Option1Name" text,
  "Option2Name" text,
  "Option3Name" text,
  "Option1Values" text,
  "Option2Values" text,
  "Option3Values" text,
  "ImageID" text,  -- -> Blob (stored file)
  "ShortDescription" text,
  "Tags" text
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

create table "DEARMappingModel" (
  "Description" text,
  "FieldName" text
);

create table "ECommerceShop" (
  "ConfigID" text,  -- -> IntegrationConfig
  "ShopName" text
);

create table "IDDescription" (
  "Description" text,
  "ID" integer
);

create table "ItemSpecificsModel" (
  "Name" text,
  "FieldType" text,
  "IsRequired" boolean,
  "Value" text,
  "Mapped" boolean,
  "IsMultiSelection" boolean,
  "MappedField" text
);

create table "ListingsSpecificsModel" (
  "Name" text,
  "FieldType" text,
  "IsRequired" boolean,
  "Value" text,
  "Mapped" boolean,
  "MappedField" text
);

create table "NameDescriptionModel" (
  "Name" text,
  "Description" text
);

create table "ShippingPackageType" (
  "DimensionsSupported" boolean,
  "DefaultValue" boolean,
  "PackageID" integer,  -- -> Package
  "Description" text,
  "ShippingPackage" integer
);

create table "ShippingService" (
  "CODEnabled" boolean,
  "DimensionsRequired" boolean,
  "WeightRequired" boolean,
  "ExpeditedService" boolean,
  "InternationalService" boolean,
  "Description" text,
  "ShippingTimeMax" integer,
  "ShippingTimeMin" integer,
  "ShippingCategoryDescription" text,
  "ShippingCategory" text,
  "ValidForSellingFlow" boolean,
  "SurchargeApplicable" boolean,
  "DisplayName" text,
  "ShippingServiceID" integer  -- -> pingService
);

create table "SiteIdModel" (
  "ID" integer,
  "Name" text,
  "Abbr" text
);

create table "eBayPublishingFailed" (
  "ProductID" text,  -- -> Product
  "ProfileName" text,
  "SKU" text,
  "Name" text,
  "Result" text,
  "ImageID" text,  -- -> Blob (stored file)
  "ProductType" text
);

create table "eBayPublishingNotListed" (
  "ProductID" text,  -- -> Product
  "SKU" text,
  "Type" text,
  "ProductType" text,
  "Name" text,
  "Category" text,
  "Brand" text,
  "Price" numeric,
  "Quantity" numeric,
  "Status" text,
  "LProfile" text,
  "ItemID" text,  -- -> Item (context-specific)
  "Selected" boolean,
  "ImageID" text,  -- -> Blob (stored file)
  "FamilyID" text,  -- -> ProductFamily
  "ValidationText" text,
  "ValidationState" text
);

create table "vAccount" (
  "Code" text,
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

create table "vEcsProductVariation" (
  "SIMID" text,  -- -> SIM
  "SKU" text,
  "Name" text,
  "Category" text,
  "Option1" text,
  "Option2" text,
  "Option3" text,
  "Status" text,
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
  "Price" numeric,
  "SIMFamilyID" text,  -- -> SIMFamily
  "ProductID" text,  -- -> Product
  "LinkedName" text,
  "LinkedSKU" text,
  "ImageID" text,  -- -> Blob (stored file)
  "ValidationText" text,
  "MaxRows" integer
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

create table "vListingProfile" (
  "id" text,
  "Name" text,
  "ShippingProfileID" text,  -- -> pingProfile
  "ShippingProfileName" text,
  "ReadinessStateId" jsonb  -- -> ReadinessState
);

create table "vLocation" (
  "LocationID" text,  -- -> Location
  "Description" text
);

create table "vProductVariation" (
  "ProductID" text,  -- -> Product
  "FamilyID" text,  -- -> ProductFamily
  "ProductCode" text,
  "ImageID" text,  -- -> Blob (stored file)
  "Name" text,
  "Option1" text,
  "Option2" text,
  "Option3" text
);

create table "vTax" (
  "RuleID" text,  -- -> Rule (context-specific)
  "Description" text
);

create table "vTime" (
  "Value" text,
  "Name" text
);
