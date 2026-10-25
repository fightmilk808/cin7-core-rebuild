-- QuickBooks: one table per Cin7 Core data model, generated from data/models.json

create table "ExternalEntityMapping" (
  "ID" text,
  "ExternalCode" text,
  "ExternalName" text,
  "EntityCode" text,
  "EntityType" text
);

create table "ExternalEntityMappingTaxRule" (
  "ID" text,
  "ExternalCode" text,
  "ExternalName" text,
  "EntityCode" text,
  "EntityType" text,
  "TaxRuleIsActive" boolean,
  "TaxRuleIsPurchase" boolean,
  "TaxRuleIsSale" boolean,
  "TaxRulePercent" numeric,
  "TaxRuleName" text
);

create table "InventoryProductsCountInfo" (
  "Count" integer
);

create table "JournalsSearchResultModel" (
  "QBOID" text,  -- -> QBO
  "Date" timestamptz,
  "DocNumber" text,
  "Selected" boolean
);

create table "QuickbooksAccounts" (
  "Code" text,
  "DisplayName" text,
  "Class" text,
  "Type" text,
  "SystemAccount" text,
  "IsFirst" boolean
);

create table "QuickbooksPaymentTerm" (
  "Id" text,
  "Name" text
);

create table "QuickbooksTaxationRule" (
  "TaxType" text,
  "Name" text,
  "EffectiveRate" numeric,
  "IsPurchaseTaxRule" boolean,
  "IsSaleTaxRule" boolean
);

create table "vConsolidateCustomers" (
  "value" text,
  "name" text
);

create table "vConsolidationChannelTypesStore" (
  "EntryID" text,  -- -> Entry
  "SaleChannel" text,
  "InvoiceSyncType" text,
  "COGSSyncType" text
);

create table "vLocation" (
  "LocationID" text,  -- -> Location
  "Description" text
);

create table "vMailingList" (
  "MailingListID" text,  -- -> MailingList
  "Name" text,
  "Emails" text,
  "ValidationText" text,
  "ValidationState" text
);
