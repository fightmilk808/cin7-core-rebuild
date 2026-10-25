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
  "CustomerID" text,  -- -> Customer
  "CustomerName" text,
  "AvalaraCustomerID" integer,  -- -> AvalaraCustomer
  "AvalaraCustomerName" text,
  "IsLinked" boolean,
  "Selected" boolean
);

create table "vAvalaraCustomerLookup" (
  "CustomerID" text,  -- -> Customer
  "Name" text,
  "IsDisplay" boolean
);

create table "vMailingList" (
  "MailingListID" text,  -- -> MailingList
  "Name" text,
  "Emails" text,
  "ValidationText" text,
  "ValidationState" text
);

create table "vProductTaxCode" (
  "Type" text,
  "ProductID" text,  -- -> Product
  "ProductCode" text,
  "ProductName" text,
  "AvalaraTaxCode" text,
  "AvalaraTaxName" text
);

create table "vSyncEntry" (
  "SaleTaskID" text,  -- -> Sale
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
  "CustomerID" text,  -- -> Customer
  "CustomerName" text,
  "ControllerName" text
);

create table "vTenantAddress" (
  "AddressID" text,  -- -> Address
  "Line1" text,
  "Line2" text,
  "CitySuburb" text,
  "StateProvince" text,
  "ZipPostCode" text,
  "Country" text,
  "Type" text,
  "DefaultForType" boolean
);
