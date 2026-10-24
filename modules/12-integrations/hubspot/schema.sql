-- HubSpot: one table per Cin7 Core data model, generated from data/models.json

create table "CurrencyAndPortalIdWrapper" (
  "PortalId" text
);

create table "HubSpotStage" (
  "HubSpotStageID" text,
  "HubSpotStageName" text
);

create table "StatusMappingModel" (
  "ID" text,
  "HubSpotID" text,
  "HubSpotPipeLineID" text,
  "HubSpotPipeLineName" text,
  "HubSpotStageID" text,
  "HubSpotStageName" text,
  "DearStatus" text,
  "SortOrder" text
);

create table "ValueNameDescriptionModel" (
  "Value" text,
  "Name" text,
  "Description" text,
  "Type" text
);

create table "ValueNameModel" (
  "Value" text,
  "Name" text
);

create table "vContactType" (
  "ContactType" text,
  "ContactTypeLocalized" text
);

create table "vCurrency" (
  "Currency" text,
  "DisplayCurrency" text
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

create table "vExportSale" (
  "TaskID" text,
  "OrderNo" text,
  "OrderDate" timestamptz,
  "Status" text,
  "TotalAmount" numeric,
  "Currency" text,
  "Customer" text
);

create table "vHubSpot" (
  "HubSpotID" text,
  "IsActive" boolean,
  "PriceTier" text,
  "PriceTierCurrency" text,
  "DefaultLocation" text,
  "AutoSync" boolean,
  "AutoSync_StartDateStr" text,
  "AutoSync_StartTime" text,
  "AutoSync_Frequency" text,
  "AutoSync_ErrorAlertType" text,
  "AutoSync_MailListID" text,
  "ProductSyncType" text,
  "ProductExport_DescriptionType" text,
  "ProductExport_TermValue" integer,
  "ProductExport_TermPeriod" text,
  "ProductImport_Type" text,
  "ProductImport_Category" text,
  "ProductImport_MappingByUniqueName" boolean,
  "ProductImport_AutoCreate" boolean,
  "CustomerSyncType" text,
  "CustomerExport_AddressType" text,
  "CustomerExport_AllowCustomFields" boolean,
  "CustomerExport_CustomFieldGoupName" text,
  "CustomerImport_ImportContactsWithoutCompanies" boolean,
  "SyncMarketingConsent" boolean,
  "ForceUpdateOnImport" boolean,
  "ForceUpdateOnExport" boolean,
  "CustomerImport_UseDefaultSettings" boolean,
  "CustomerImport_BaseCurrency" text,
  "CustomerImport_RevenueAccount" text,
  "CustomerImport_PaymentTerm" text,
  "CustomerImport_PurchaseTaxRule" text,
  "CustomerImport_SaleTaxRule" text,
  "SaleSyncType" text,
  "SaleImport_HubSpotPipeline" text,
  "SaleImport_CreateSaleWhenHubSpotReachesStage" text
);

create table "vHubSpotContact" (
  "ID" text,
  "ContactName" text,
  "CompanyName" text,
  "IsOrganization" boolean
);

create table "vHubspotFieldsMapping" (
  "ID" text,
  "ECSConfigID" text,
  "DearFieldModel" text,
  "DearFieldName" text,
  "ECSFieldName" text
);

create table "vImportSale" (
  "DealID" text,
  "DealCurrency" text,
  "HubSpotDealId" text,
  "HubSpotDealName" text,
  "HubSpotDealDate" timestamptz,
  "HubSpotTotal" numeric,
  "HubSpotDealStage" text,
  "Error" text,
  "ValidationText" text,
  "ValidationState" text
);

create table "vLog" (
  "LogID" text,
  "Action" text,
  "Message" text,
  "AdditionalInfo" text,
  "LogDate" timestamptz,
  "Error" text,
  "LogType" text,
  "SyncID" text,
  "AffectedEntitiesCount" integer,
  "ValidationText" text,
  "ValidationState" text
);

create table "vMailingList" (
  "MailingListID" text,
  "Name" text,
  "Emails" text,
  "ValidationText" text,
  "ValidationState" text
);

create table "vProductCatalogModel" (
  "ID" text,
  "HubSpotCatalogID" text,
  "ProductID" text,
  "ProductCode" text,
  "Name" text,
  "Type" text,
  "CategoryName" text,
  "Status" text,
  "HubSpotName" text,
  "HubSpotObjectID" text,
  "HubSpotPrice" text,
  "PriceTier1" numeric,
  "PriceTier2" numeric,
  "PriceTier3" numeric,
  "PriceTier4" numeric,
  "PriceTier5" numeric,
  "PriceTier6" numeric,
  "PriceTier7" numeric,
  "PriceTier8" numeric,
  "PriceTier9" numeric,
  "PriceTier10" numeric,
  "ValidationState" text,
  "ValidationText" text
);

create table "vProductToExportModel" (
  "ProductID" text,
  "ProductCode" text,
  "Name" text,
  "Type" text,
  "CategoryName" text,
  "Status" text,
  "PriceTier" integer,
  "PriceTier1" numeric,
  "PriceTier2" numeric,
  "PriceTier3" numeric,
  "PriceTier4" numeric,
  "PriceTier5" numeric,
  "PriceTier6" numeric,
  "PriceTier7" numeric,
  "PriceTier8" numeric,
  "PriceTier9" numeric,
  "PriceTier10" numeric
);

create table "vTaxRules" (
  "RuleID" text,
  "Description" text
);
