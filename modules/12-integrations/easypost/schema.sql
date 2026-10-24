-- EasyPost: one table per Cin7 Core data model, generated from data/models.json

create table "NameValue" (
  "Name" text,
  "Value" text
);

create table "ShippingReferenceData" (
  "DefaultDimensionName" text
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

create table "vShipServConf" (
  "ID" text,
  "ModuleType" text
);

create table "vTax" (
  "RuleID" text,
  "Description" text
);
