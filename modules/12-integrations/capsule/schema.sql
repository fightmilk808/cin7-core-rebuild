-- Capsule: one table per Cin7 Core data model, generated from data/models.json

create table "vAddressType" (
  "AddressType" text
);

create table "vContact" (
  "ID" text,
  "ECSConfigID" text,  -- -> IntegrationConfig
  "ECSName" text,
  "IsOrganization" boolean,
  "ContactType" text,
  "Status" text,
  "Tags" text
);

create table "vContactType" (
  "ContactType" text,
  "ContactTypeLocalized" text
);

create table "vEcsAddressTypesMapping" (
  "ID" text,
  "ECSConfigID" text,  -- -> IntegrationConfig
  "ECSAddressType" text,
  "AddressType" text,
  "SortOrder" text
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

create table "vEcsContactTagMapping" (
  "ID" text,
  "ECSConfigID" text,  -- -> IntegrationConfig
  "ECSTag" text,
  "ContactType" text,
  "SortOrder" text
);

create table "vTaxRules" (
  "RuleID" text,  -- -> Rule (context-specific)
  "Description" text
);
