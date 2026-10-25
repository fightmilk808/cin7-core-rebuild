-- Pinch: one table per Cin7 Core data model, generated from data/models.json

create table "PinchPaymentLogEntry" (
  "Id" text,
  "SaleTaskID" text,  -- -> Sale
  "PaymentId" text,  -- -> Payment
  "Amount" numeric,
  "AccountCode" text,
  "AccountName" text,
  "Currency" text,
  "SaleInvoiceNumber" text,
  "Status" text,
  "PaymentStatus" text,
  "TransID" text,  -- -> Trans
  "ClientTransID" text,  -- -> ClientTrans
  "IsTestMode" boolean,
  "Created" timestamptz,
  "LastUpdateTime" timestamptz
);

create table "vAccount" (
  "Code" text,
  "DisplayName" text
);
