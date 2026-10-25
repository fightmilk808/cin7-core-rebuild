-- PayPal: one table per Cin7 Core data model, generated from data/models.json

create table "payPalPaymentLogEntry" (
  "Id" text,
  "SaleTaskId" text,  -- -> Sale
  "Amount" numeric,
  "AccountCode" text,
  "AccountName" text,
  "Currency" text,
  "SaleInvoiceNumber" text,
  "StatusText" text,
  "PayPalPaymentId" text,  -- -> PayPalPayment
  "IsTestMode" boolean,
  "InitTime" timestamptz,
  "LastUpdateTime" timestamptz
);

create table "vAccount" (
  "Code" text,
  "DisplayName" text
);
