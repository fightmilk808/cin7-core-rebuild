-- Shippit: one table per Cin7 Core data model, generated from data/models.json

create table "UserPackage" (
  "id" text,
  "name" text,
  "Weight" numeric,
  "Width" numeric,
  "Height" numeric,
  "Length" numeric
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

create table "vShipServConf" (
  "ID" text,
  "ModuleType" text
);

create table "vTax" (
  "RuleID" text,
  "Description" text
);
