-- ShipStation: one table per Cin7 Core data model, generated from data/models.json

create table "ConsolidationStore" (
  "type" text,
  "description" text
);

create table "CtlgProduct" (
  "ProductID" text,
  "ProductCode" text,
  "Name" text,
  "Available" numeric,
  "OnHand" numeric,
  "ImageID" text,
  "IsStockProduct" boolean
);

create table "ECommerceShop" (
  "ConfigID" text,
  "ShopName" text
);

create table "TopicStore" (
  "type" text,
  "description" text
);

create table "USTaxTypeAhead" (
  "ID" text,
  "Description" text,
  "Name" text
);

create table "vAccount" (
  "Code" text,
  "DisplayName" text
);

create table "vCarrierList" (
  "value" text,
  "name" text
);

create table "vCarrierServiceList" (
  "FakeID" text,
  "CarrierCode" text,
  "ServiceCode" text,
  "Highlighted" boolean,
  "DisplayName" text,
  "CarrierServiceCode" text,
  "Domestic" boolean,
  "International" boolean
);

create table "vCurrency" (
  "Currency" text,
  "DisplayCurrency" text
);

create table "vCustomIntegration" (
  "ShipstationUseStockLocator" boolean,
  "ShipstationExportFFOrders" boolean,
  "ShipStationTimezone" text,
  "Enabled" boolean,
  "ImportShippingCosts" boolean,
  "ApplyTaxOnShippingCost" boolean,
  "ShippingCostZeroTaxRule" text,
  "IgnoreBillingContact" boolean,
  "CustomStoreCurrency" text
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

create table "vEcsCatalogItemNew" (
  "SIMID" text,
  "ProductID" text,
  "FamilyID" text,
  "EntityType" text,
  "LinkedSKU" text,
  "LinkedName" text,
  "SKU" text,
  "Name" text,
  "Status" text,
  "ImageID" text,
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

create table "vEcsLocationMapping" (
  "ID" text,
  "ECSConfigID" text,
  "ECSLocationName" text,
  "ECSLocationID" text,
  "LocationID" text,
  "LocationName" text
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

create table "vExportFilter" (
  "ParameterName" text,
  "Condition" text,
  "Value" text,
  "Join" text,
  "ValidationText" text,
  "ValidationState" text
);

create table "vExportFilterItem" (
  "Value" text,
  "Name" text
);

create table "vExportFilterItemGroupped" (
  "Value" text,
  "Name" text,
  "Group" text,
  "IsFirst" boolean
);

create table "vLocation" (
  "LocationID" text,
  "Description" text
);

create table "vMailingList" (
  "MailingListID" text,
  "Name" text,
  "Emails" text,
  "ValidationText" text,
  "ValidationState" text
);

create table "vPackagesList" (
  "name" text,
  "value" text,
  "Domestic" boolean,
  "International" boolean
);

create table "vSSExportLog" (
  "ScheduledPeriod" timestamptz,
  "OrderNumber" text,
  "FulfillmentNumber" text,
  "InvoiceNumber" text,
  "OrderID" text,
  "FulfillmenID" text,
  "InvoiceID" text,
  "CustomerName" text,
  "ShipByDate" timestamptz,
  "Status" text,
  "Comments" text,
  "StatusDate" timestamptz
);

create table "vSSStoreList" (
  "name" text,
  "value" text
);

create table "vSSTenantAddress" (
  "AddressID" text,
  "Line1" text,
  "Line2" text,
  "CitySuburb" text,
  "StateProvince" text,
  "ZipPostCode" text,
  "Country" text,
  "CountryLine" text
);

create table "vScheduledExport" (
  "periodBeg" timestamptz,
  "periodEnd" timestamptz
);

create table "vShipIntegrationLocationMapping" (
  "ID" text,
  "ConfigID" text,
  "WarehouseName" text,
  "WarehouseId" text,
  "LocationID" text,
  "LocationName" text,
  "IsActive" boolean
);

create table "vShipServConf" (
  "ID" text,
  "ModuleType" text
);

create table "vShipstationNotMatchingAddresses" (
  "TaskID" text,
  "InvoiceNumber" text,
  "ShippingAddressLine1" text,
  "ShippingAddressLine2" text,
  "CustomerName" text,
  "CustomerID" text,
  "InvoiceDate" timestamptz,
  "ShipmentRequiredByDate" timestamptz,
  "Reason" text
);

create table "vTax" (
  "RuleID" text,
  "Description" text
);

create table "vTime" (
  "Value" text,
  "Name" text
);

create table "vUSTaxMapping" (
  "id" integer,
  "configid" text,
  "zip" text,
  "city" text,
  "county" text
);

create table "vWeightUnit" (
  "Code" text,
  "Name" text
);
