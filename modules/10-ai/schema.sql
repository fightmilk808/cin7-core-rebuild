-- AI: one table per Cin7 Core data model, generated from data/models.json

create table "AvalaraSaleTaxCode" (
  "Code" text,
  "Name" text
);

create table "GiftCardGlobalSettings" (
  "GiftCardProductID" text,  -- -> GiftCardProduct
  "IsGiftCardEnabled" boolean,
  "DefaultGiftCardExpirationPeriod" text,
  "CanGiftCardExpire" boolean,
  "GiftCardSaleTaxID" text,  -- -> GiftCardSaleTax
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
  "CustomerID" text,  -- -> Customer
  "Name" text
);

create table "vExtractedDocument" (
  "DocumentName" text,
  "Status" text,
  "StatusDescription" text,
  "DateCreated" timestamptz,
  "EntityID" text  -- -> Entity (polymorphic)
);

create table "vSaleGiftCards" (
  "ID" text,
  "TaskID" text,  -- -> Task (any document)
  "GiftCardCode" text,
  "InitialBalance" numeric,
  "CurrentBalance" numeric,
  "Date" timestamptz,
  "ExpirationDate" timestamptz,
  "RefundID" text  -- -> Refund
);

create table "vShippingManifestAttachment" (
  "BlobGUID" text,  -- -> Blob (stored file)
  "TrackNumber" text
);
