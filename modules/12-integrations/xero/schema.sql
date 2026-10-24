-- Xero: one table per Cin7 Core data model, generated from data/models.json

create table "AccountsMapping" (
  "InventoryControlAccount" text,
  "CostOfGoodsSoldAccount" text,
  "DefaultRevenueAccount" text,
  "TaxLiabilityAccount" text,
  "PurchasePrepayment" text,
  "SalePrepayment" text,
  "InventoryAccrualAccount" text,
  "StockInTransitAccount" text,
  "InventoryDiscrepancyAccount" text,
  "GiftCardAccount" text,
  "WipAccount" text,
  "TransferInTransitAccount" text,
  "CurrentYearProfitsAccount" text,
  "UnrealisedCurrencyGainAccount" text,
  "RealisedCurrencyGainAccount" text,
  "PaymentClearingAccount" text
);

create table "ExternalEntityMapping" (
  "ID" text,
  "ExternalCode" text,
  "ExternalName" text,
  "EntityCode" text,
  "EntityType" text
);

create table "ExternalEntityMappingTaxRule" (
  "ID" text,
  "ExternalCode" text,
  "ExternalName" text,
  "EntityCode" text,
  "EntityType" text,
  "TaxRuleIsActive" boolean,
  "TaxRuleIsPurchase" boolean,
  "TaxRuleIsSale" boolean,
  "TaxRulePercent" numeric,
  "TaxRuleName" text
);

create table "XeroAccounts" (
  "Code" text,
  "DisplayName" text,
  "Class" text,
  "Type" text,
  "SystemAccount" text,
  "EnablePaymentsToAccount" boolean,
  "IsFirst" boolean
);

create table "XeroTaxationRule" (
  "TaxType" text,
  "Name" text,
  "EffectiveRate" numeric,
  "IsPurchaseTaxRule" boolean,
  "IsSaleTaxRule" boolean
);
