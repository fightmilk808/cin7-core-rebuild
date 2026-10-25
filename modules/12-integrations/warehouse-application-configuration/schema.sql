-- Warehouse application configuration: one table per Cin7 Core data model, generated from data/models.json

create table "ECommerceShop" (
  "ConfigID" text,  -- -> IntegrationConfig
  "ShopName" text
);

create table "TimeTrackingOptionsStore" (
  "id" numeric,
  "displayName" text
);
