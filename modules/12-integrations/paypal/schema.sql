-- PayPal: one table per Cin7 Core data model, generated from data/models.json

create table "payPalPaymentLogEntry" (
  "Id" text,
  "SaleTaskId" text,
  "Amount" numeric,
  "AccountCode" text,
  "AccountName" text,
  "Currency" text,
  "SaleInvoiceNumber" text,
  "StatusText" text,
  "PayPalPaymentId" text,
  "IsTestMode" boolean,
  "InitTime" timestamptz,
  "LastUpdateTime" timestamptz
);

create table "vAccount" (
  "Code" text,
  "DisplayName" text
);
