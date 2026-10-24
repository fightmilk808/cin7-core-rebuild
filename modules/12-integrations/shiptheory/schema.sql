-- Shiptheory: one table per Cin7 Core data model, generated from data/models.json

create table "ExceptionsList" (
  "Line" integer,
  "SupplierName" text,
  "SupplierNameError" text,
  "SupplierReference" text,
  "SupplierReferenceError" text,
  "InvoiceDate" text,
  "InvoiceDateError" text,
  "Amount" text,
  "AmountError" text,
  "CurrencyConversionRate" text,
  "CurrencyConversionRateError" text,
  "ValidationText" text,
  "ValidationState" text
);

create table "vBulkListingProduct" (
  "ProductID" text,
  "ProductCode" text,
  "Name" text,
  "Status" text,
  "Category" text,
  "Price" numeric,
  "OrderedQuantity" numeric,
  "MinimumToOrder" integer,
  "MaximumToOrder" integer,
  "Quantity" numeric,
  "MenuItems" text,
  "IsBackorderEnabled" boolean
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

create table "vMailingList" (
  "MailingListID" text,
  "Name" text,
  "Emails" text,
  "ValidationText" text,
  "ValidationState" text
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

create table "vScheduledExport" (
  "periodBeg" timestamptz,
  "periodEnd" timestamptz
);

create table "vShipServConf" (
  "ID" text,
  "ModuleType" text
);
