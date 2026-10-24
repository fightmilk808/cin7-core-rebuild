-- Avalara: one table per Cin7 Core data model, generated from data/models.json

create table "AvalaraCompany" (
  "CompanyCode" text,
  "Name" text
);

create table "AvalaraTaxCode" (
  "Code" text,
  "Name" text
);

create table "vAvalaraCustomerData" (
  "Id" integer,
  "CustomerID" text,
  "CustomerName" text,
  "AvalaraCustomerID" integer,
  "AvalaraCustomerName" text,
  "IsLinked" boolean,
  "Selected" boolean
);

create table "vAvalaraCustomerLookup" (
  "CustomerID" text,
  "Name" text,
  "IsDisplay" boolean
);

create table "vMailingList" (
  "MailingListID" text,
  "Name" text,
  "Emails" text,
  "ValidationText" text,
  "ValidationState" text
);

create table "vProductTaxCode" (
  "Type" text,
  "ProductID" text,
  "ProductCode" text,
  "ProductName" text,
  "AvalaraTaxCode" text,
  "AvalaraTaxName" text
);

create table "vSyncEntry" (
  "SaleTaskID" text,
  "Type" text,
  "DateSynchronised" timestamptz,
  "DateCreated" timestamptz,
  "Status" text,
  "Error" text,
  "SaleOrderNumber" text,
  "InvoiceNumber" text,
  "CreditNoteNumber" text,
  "InvoiceDate" timestamptz,
  "SaleOrderDate" timestamptz,
  "CustomerID" text,
  "CustomerName" text,
  "ControllerName" text
);

create table "vTenantAddress" (
  "AddressID" text,
  "Line1" text,
  "Line2" text,
  "CitySuburb" text,
  "StateProvince" text,
  "ZipPostCode" text,
  "Country" text,
  "Type" text,
  "DefaultForType" boolean
);
