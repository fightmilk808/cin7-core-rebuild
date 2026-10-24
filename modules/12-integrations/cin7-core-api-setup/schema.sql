-- Cin7 Core API setup: one table per Cin7 Core data model, generated from data/models.json

create table "vDearApiEndpoint" (
  "Name" text,
  "Path" text
);

create table "vDearApiEndpointMethod" (
  "Name" text,
  "Url" text
);

create table "vDearApiEndpointMethodParam" (
  "Name" text,
  "Type" text,
  "Required" text,
  "Value" text,
  "ToolTip" text
);

create table "vDearApiRequests" (
  "ID" text,
  "Date" timestamptz,
  "ApplicationKey" text,
  "Url" text,
  "Request" text,
  "Response" text,
  "Code" integer,
  "Comments" text,
  "Method" text,
  "ApplicationName" text
);
