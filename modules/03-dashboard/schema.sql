-- Dashboard: one table per Cin7 Core data model, generated from data/models.json

create table "ContinueSetupViewModel" (
  "UserName" text,
  "DemoDataDeleted" boolean,
  "OnBoarding" boolean,
  "AccountingSystem" text,
  "SyncErrorMessage" text,
  "IsAccountMappingComplete" boolean,
  "SyncRequired" boolean,
  "SetupCompleted" boolean,
  "ConnectRequired" boolean,
  "InitialSyncRequired" boolean,
  "ShopifyConnected" boolean,
  "ShopifyConfigID" text,
  "ShopifyShopName" text,
  "ShopifyProductsNumber" integer,
  "ShopifyOrdersNumber" integer,
  "ShopifyPriceTier" integer,
  "WooCommerceConnected" boolean,
  "WooCommerceConfigID" text,
  "WooCommerceShopName" text,
  "WooCommerceProductsNumber" integer,
  "WooCommerceOrdersNumber" integer,
  "WooCommercePriceTier" integer,
  "VendConnected" boolean,
  "VendConfigID" text,
  "VendShopName" text,
  "VendProductsNumber" integer,
  "VendOrdersNumber" integer,
  "VendPriceTier" integer,
  "MagentoConnected" boolean,
  "MagentoConfigID" text,
  "MagentoShopName" text,
  "MagentoProductsNumber" integer,
  "MagentoOrdersNumber" integer,
  "MagentoPriceTier" integer,
  "Magento2Connected" boolean,
  "Magento2ConfigID" text,
  "Magento2ShopName" text,
  "Magento2ProductsNumber" integer,
  "Magento2OrdersNumber" integer,
  "Magento2PriceTier" integer,
  "Magento2SalePriceTier" integer,
  "EbayConnected" boolean,
  "EbayConfigID" text,
  "EbayShopName" text,
  "EbayProductsNumber" integer,
  "EbayOrdersNumber" integer,
  "EbayPriceTier" integer,
  "ShipStationConnected" boolean,
  "ShipStationConfigID" text,
  "ShipStationShopName" text,
  "ShipStationProductsNumber" integer,
  "ShipStationOrdersNumber" integer,
  "ShipStationPriceTier" integer,
  "AmazonConnected" boolean,
  "AmazonConfigID" text,
  "AmazonShopName" text,
  "AmazonProductsNumber" integer,
  "AmazonOrdersNumber" integer,
  "AmazonPriceTier" integer,
  "BigcommerceConnected" boolean,
  "BigcommerceConfigID" text,
  "BigcommerceShopName" text,
  "BigcommerceProductsNumber" integer,
  "BigcommerceOrdersNumber" integer,
  "BigcommercePriceTier" integer
);

create table "CustomerOverviewByProduct" (
  "CustomerName" text,
  "CustomerID" text,
  "Sales" integer,
  "Amount" numeric,
  "Tax" numeric
);

create table "CustomerOverviewNoBuys" (
  "CustomerName" text,
  "CustomerID" text
);

create table "CustomerOverviewSalesRep" (
  "SaleRep" text,
  "Sales" integer,
  "Amount" numeric,
  "Tax" numeric
);

create table "CustomerOverviewTopCustomer" (
  "CustomerName" text,
  "CustomerID" text,
  "Sales" integer,
  "Amount" numeric,
  "Tax" numeric
);

create table "DChart" (
  "Name" text,
  "Due" numeric,
  "Overdue" numeric
);

create table "ExternalEntityMapping" (
  "ID" text,
  "ExternalCode" text,
  "ExternalName" text,
  "EntityCode" text,
  "EntityType" text
);

create table "ProductOverviewBrand" (
  "Name" text,
  "Amount" numeric,
  "Quantity" integer,
  "Tax" numeric
);

create table "ProductOverviewRegion" (
  "City" text,
  "Country" text,
  "Amount" numeric,
  "Tax" numeric
);

create table "ProductOverviewSellings" (
  "ProductImage" text,
  "ProductID" text,
  "ProductName" text,
  "Total" numeric,
  "Tax" numeric,
  "Quantity" integer
);

create table "Purchase" (
  "TaskID" text,
  "OrderNo" text,
  "OrderDate" timestamptz,
  "Supplier" text,
  "InvoiceDueDate" timestamptz,
  "Invoiced" numeric,
  "Ordered" numeric,
  "Due" numeric,
  "SupplierCurrency" text,
  "DropShipTaskID" text,
  "TaskTypeSign" integer,
  "TaskTypeName" text,
  "ShipmentRequiredByDate" timestamptz
);

create table "Reorder" (
  "ProductCode" text,
  "ProductID" text,
  "Name" text,
  "Supplier" text,
  "Available" numeric
);

create table "Sale" (
  "TaskID" text,
  "OrderNo" text,
  "OrderDate" timestamptz,
  "Customer" text,
  "InvoiceDueDate" timestamptz,
  "Amount" numeric,
  "Due" numeric,
  "CustomerCurrency" text,
  "TT" integer
);

create table "TaskCount" (
  "Date" timestamptz,
  "Tasks" integer
);

create table "vProductList" (
  "ProductID" text,
  "ProductCode" text,
  "Name" text,
  "DefaultUnitOfMeasure" text,
  "Type" text,
  "Category" text,
  "Brand" text,
  "LatestSupplier" text,
  "Status" text,
  "Selected" boolean,
  "ImageID" text,
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
  "NotSellable" text
);
