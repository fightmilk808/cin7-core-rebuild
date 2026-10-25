-- StarShipIT: one table per Cin7 Core data model, generated from data/models.json

create table "UserPackage" (
  "id" text,
  "name" text,
  "Weight" numeric,
  "Width" numeric,
  "Height" numeric,
  "Length" numeric
);

create table "vCurrency" (
  "Currency" text,
  "DisplayCurrency" text
);

create table "vDimensionUnit" (
  "Code" text,
  "Name" text
);

create table "vMarginTax" (
  "Code" boolean,
  "Name" text
);

create table "vSendNotificationOnLabelGeneration" (
  "Code" boolean,
  "Name" text
);

create table "vShipServConf" (
  "ID" text,
  "ModuleType" text
);

create table "vTax" (
  "RuleID" text,  -- -> Rule (context-specific)
  "Description" text
);

create table "vUseCustomerTax" (
  "Code" boolean,
  "Name" text
);

create table "vWeightUnit" (
  "Code" text,
  "Name" text
);
