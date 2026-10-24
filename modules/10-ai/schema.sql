-- AI: one table per Cin7 Core data model, generated from data/models.json

create table "AvalaraSaleTaxCode" (
  "Code" text,
  "Name" text
);

create table "GiftCardGlobalSettings" (
  "GiftCardProductID" text,
  "IsGiftCardEnabled" boolean,
  "DefaultGiftCardExpirationPeriod" text,
  "CanGiftCardExpire" boolean,
  "GiftCardSaleTaxID" text,
  "GiftProductName" text,
  "GiftProductCode" text,
  "GiftCardRevenueAccount" text,
  "GiftCardRevenueAccountName" text,
  "CanGiftCardRefund" boolean
);

create table "spTaskImportLogEntry" (
  "ID" text,
  "Date" timestamptz,
  "DocumentName" text,
  "Comment" text,
  "UserName" text
);

create table "vCustomerParent" (
  "CustomerID" text,
  "Name" text
);

create table "vExtractedDocument" (
  "DocumentName" text,
  "Status" text,
  "StatusDescription" text,
  "DateCreated" timestamptz,
  "EntityID" text
);

create table "vSaleGiftCards" (
  "ID" text,
  "TaskID" text,
  "GiftCardCode" text,
  "InitialBalance" numeric,
  "CurrentBalance" numeric,
  "Date" timestamptz,
  "ExpirationDate" timestamptz,
  "RefundID" text
);

create table "vShippingManifestAttachment" (
  "BlobGUID" text,
  "TrackNumber" text
);
