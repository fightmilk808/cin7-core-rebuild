-- AuthorizeNet: one table per Cin7 Core data model, generated from data/models.json

create table "AuthorizeNetPaymentLogEntry" (
  "Id" text,
  "SaleTaskId" text,  -- -> Sale
  "PaymentId" text,  -- -> Payment
  "Amount" numeric,
  "AccountCode" text,
  "AccountName" text,
  "Currency" text,
  "SaleInvoiceNumber" text,
  "StatusText" text,
  "AuthorizeNetPaymentId" text,  -- -> AuthorizeNetPayment
  "IsTestMode" boolean,
  "InitTime" timestamptz,
  "LastUpdateTime" timestamptz
);

create table "vAccount" (
  "Code" text,
  "DisplayName" text
);
