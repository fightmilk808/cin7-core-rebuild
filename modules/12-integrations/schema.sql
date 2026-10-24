-- Integrations: one table per Cin7 Core data model, generated from data/models.json

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

create table "AmazonCode" (
  "ECSCarrierCode" text
);

create table "AmazonConf" (
  "ID" text,
  "ShopName" text,
  "Region" text,
  "Country" text,
  "DisplayName" text
);

create table "AspnetRole" (
  "RoleId" text,
  "RoleName" text
);

create table "AuthorizeNetPaymentLogEntry" (
  "Id" text,
  "SaleTaskId" text,
  "PaymentId" text,
  "Amount" numeric,
  "AccountCode" text,
  "AccountName" text,
  "Currency" text,
  "SaleInvoiceNumber" text,
  "StatusText" text,
  "AuthorizeNetPaymentId" text,
  "IsTestMode" boolean,
  "InitTime" timestamptz,
  "LastUpdateTime" timestamptz
);

create table "AvalaraCompany" (
  "CompanyCode" text,
  "Name" text
);

create table "AvalaraTaxCode" (
  "Code" text,
  "Name" text
);

create table "B2B_SearchProduct" (
  "Id" text,
  "Code" text,
  "Name" text,
  "Type" text
);

create table "Carrier" (
  "Key" text,
  "Value" text
);

create table "CashManagementReason" (
  "ID" text,
  "ReasonName" text
);

create table "Category2" (
  "Category" text
);

create table "ChannelMapping" (
  "ChannelName" text,
  "ConfigID" text,
  "FulfillmentBoxSetting" text,
  "LogisticsProviderSetting" text
);

create table "ConsolidationFrequencyModel" (
  "value" integer,
  "description" text
);

create table "ConsolidationStore" (
  "type" text,
  "description" text
);

create table "ConsolidationTypeModel" (
  "value" text,
  "text" text
);

create table "ContactInfo" (
  "ContactID" text,
  "ContactTypeName" text,
  "ContactType" text,
  "ContactName" text,
  "IsActive" boolean
);

create table "CtlgFamily" (
  "FamilyID" text,
  "SKU" text,
  "Name" text,
  "Category" text,
  "Brand" text,
  "SKUCount" numeric,
  "Option1Name" text,
  "Option2Name" text,
  "Option3Name" text,
  "Option1Values" text,
  "Option2Values" text,
  "Option3Values" text,
  "ImageID" text,
  "ShortDescription" text,
  "Tags" text
);

create table "CtlgProduct" (
  "ProductID" text,
  "ProductCode" text,
  "Name" text,
  "Available" numeric,
  "OnHand" numeric,
  "ImageID" text,
  "IsStockProduct" boolean
);

create table "CurrencyAndPortalIdWrapper" (
  "PortalId" text
);

create table "DEARMappingModel" (
  "Description" text,
  "FieldName" text
);

create table "ECommerceShop" (
  "ConfigID" text,
  "ShopName" text
);

create table "EcsProductDetails" (
  "ProductID" text,
  "SyncStockLevel" boolean,
  "UseBufferInventory" boolean,
  "BufferInventory" integer,
  "SyncBufferInventory" integer,
  "SyncQuantity" numeric
);

create table "EnumNameValue" (
  "name" text,
  "value" numeric
);

create table "EtsyPublishingFailed" (
  "ProductID" text,
  "ProfileName" text,
  "SKU" text,
  "Name" text,
  "Result" text,
  "ImageID" text,
  "ProductType" text
);

create table "EtsyPublishingNotListed" (
  "ProductID" text,
  "SKU" text,
  "Type" text,
  "ProductType" text,
  "Name" text,
  "Category" text,
  "Brand" text,
  "Price" numeric,
  "Quantity" numeric,
  "Status" text,
  "LProfile" text,
  "ItemID" text,
  "Selected" boolean,
  "ImageID" text,
  "FamilyID" text,
  "ValidationText" text,
  "ValidationState" text
);

create table "ExceptionsList" (
  "Line" integer,
  "SupplierName" text,
  "SupplierNameError" text,
  "SupplierReference" text,
  "SupplierReferenceError" text,
  "InvoiceDate" text,
  "InvoiceDateError" text,
  "Amount" text,
  "AmountError" text,
  "CurrencyConversionRate" text,
  "CurrencyConversionRateError" text,
  "ValidationText" text,
  "ValidationState" text
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

create table "FaireCarrierCode" (
  "ECSCarrierCode" text
);

create table "FulfillmentBoxOption" (
  "Name" text,
  "Description" text
);

create table "HubSpotStage" (
  "HubSpotStageID" text,
  "HubSpotStageName" text
);

create table "IDDescription" (
  "Description" text,
  "ID" integer
);

create table "IdNameModel" (
  "id" text,
  "name" text
);

create table "ImportItemsError" (
  "Line" integer,
  "BoxNumber" integer,
  "SKU" text,
  "ProductName" text,
  "UnitsPerBox" integer,
  "BoxWeight" numeric,
  "BoxWidth" numeric,
  "BoxHeight" numeric,
  "BoxDepth" numeric,
  "ValidationState" text,
  "ValidationText" text
);

create table "IntegrationModel" (
  "ShopType" text
);

create table "IntegrationTypeStore" (
  "value" text,
  "name" text
);

create table "InventoryProductsCountInfo" (
  "Count" integer
);

create table "ItemSpecificsModel" (
  "Name" text,
  "FieldType" text,
  "IsRequired" boolean,
  "Value" text,
  "Mapped" boolean,
  "IsMultiSelection" boolean,
  "MappedField" text
);

create table "JournalsSearchResultModel" (
  "QBOID" text,
  "Date" timestamptz,
  "DocNumber" text,
  "Selected" boolean
);

create table "ListingsSpecificsModel" (
  "Name" text,
  "FieldType" text,
  "IsRequired" boolean,
  "Value" text,
  "Mapped" boolean,
  "MappedField" text
);

create table "LogisticsProviderOption" (
  "Name" text,
  "Description" text
);

create table "MasterDataSource" (
  "name" text,
  "value" text
);

create table "NameDescriptionModel" (
  "Name" text,
  "Description" text
);

create table "NameValue" (
  "Name" text,
  "Value" text
);

create table "NewStatusStore" (
  "type" text,
  "description" text
);

create table "OrderStatusStore" (
  "type" text,
  "description" text
);

create table "OutletSelector" (
  "PosOutletID" text,
  "OutletName" text
);

create table "PaymentReferenceStore" (
  "type" text,
  "description" text
);

create table "PinchPaymentLogEntry" (
  "Id" text,
  "SaleTaskID" text,
  "PaymentId" text,
  "Amount" numeric,
  "AccountCode" text,
  "AccountName" text,
  "Currency" text,
  "SaleInvoiceNumber" text,
  "Status" text,
  "PaymentStatus" text,
  "TransID" text,
  "ClientTransID" text,
  "IsTestMode" boolean,
  "Created" timestamptz,
  "LastUpdateTime" timestamptz
);

create table "QuickbooksAccounts" (
  "Code" text,
  "DisplayName" text,
  "Class" text,
  "Type" text,
  "SystemAccount" text,
  "IsFirst" boolean
);

create table "QuickbooksPaymentTerm" (
  "Id" text,
  "Name" text
);

create table "QuickbooksTaxationRule" (
  "TaxType" text,
  "Name" text,
  "EffectiveRate" numeric,
  "IsPurchaseTaxRule" boolean,
  "IsSaleTaxRule" boolean
);

create table "ReferenceDataModel" (
  "ID" integer,
  "TimeZone" text,
  "TenantTaxCalculationMethod" text
);

create table "RegisterCountModel" (
  "RegisterCount" integer
);

create table "ShippingPackageType" (
  "DimensionsSupported" boolean,
  "DefaultValue" boolean,
  "PackageID" integer,
  "Description" text,
  "ShippingPackage" integer
);

create table "ShippingReferenceData" (
  "DefaultDimensionName" text
);

create table "ShippingService" (
  "CODEnabled" boolean,
  "DimensionsRequired" boolean,
  "WeightRequired" boolean,
  "ExpeditedService" boolean,
  "InternationalService" boolean,
  "Description" text,
  "ShippingTimeMax" integer,
  "ShippingTimeMin" integer,
  "Description" text,
  "ShippingCategoryDescription" text,
  "ShippingCategory" text,
  "ValidForSellingFlow" boolean,
  "SurchargeApplicable" boolean,
  "DisplayName" text,
  "ShippingServiceID" integer
);

create table "SiteIdModel" (
  "ID" integer,
  "Name" text,
  "Abbr" text
);

create table "StatusMappingModel" (
  "ID" text,
  "HubSpotID" text,
  "HubSpotPipeLineID" text,
  "HubSpotPipeLineName" text,
  "HubSpotStageID" text,
  "HubSpotStageName" text,
  "DearStatus" text,
  "SortOrder" text
);

create table "TimeTrackingOptionsStore" (
  "id" numeric,
  "displayName" text
);

create table "TopicStore" (
  "type" text,
  "description" text
);

create table "USTaxTypeAhead" (
  "ID" text,
  "Description" text,
  "Name" text
);

create table "UserPackage" (
  "id" text,
  "name" text,
  "Weight" numeric,
  "Width" numeric,
  "Height" numeric,
  "Length" numeric
);

create table "ValueNameDescriptionModel" (
  "Value" text,
  "Name" text,
  "Description" text,
  "Type" text
);

create table "ValueNameModel" (
  "Value" text,
  "Name" text
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

create table "eBayPublishingFailed" (
  "ProductID" text,
  "ProfileName" text,
  "SKU" text,
  "Name" text,
  "Result" text,
  "ImageID" text,
  "ProductType" text
);

create table "eBayPublishingNotListed" (
  "ProductID" text,
  "SKU" text,
  "Type" text,
  "ProductType" text,
  "Name" text,
  "Category" text,
  "Brand" text,
  "Price" numeric,
  "Quantity" numeric,
  "Status" text,
  "LProfile" text,
  "ItemID" text,
  "Selected" boolean,
  "ImageID" text,
  "FamilyID" text,
  "ValidationText" text,
  "ValidationState" text
);

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

create table "stateList" (
  "Code" text,
  "Value" text
);

create table "vAbandonedCart" (
  "CartID" text,
  "DateTime" timestamptz,
  "CustomerContactEmail" text,
  "CustomerID" text,
  "CustomerContactName" text,
  "CartTotal" numeric,
  "CartTotalCurrency" text,
  "Quantity" numeric
);

create table "vAbandonedCartProduct" (
  "ProductID" text,
  "CartID" text,
  "ProductName" text,
  "ProductCode" text,
  "Quantity" numeric,
  "PriceValue" numeric,
  "PriceCurrency" text,
  "AvailableQuantity" numeric,
  "Status" text
);

create table "vAccount" (
  "Code" text,
  "DisplayName" text
);

create table "vAddress" (
  "AddressID" text,
  "Line1" text,
  "Line2" text
);

create table "vAddressType" (
  "AddressType" text
);

create table "vAmazonCogs" (
  "EcsManualJournalSetID" text,
  "SKU" text,
  "ProductID" text,
  "ProductName" text,
  "AverageCost" numeric,
  "SoldQty" numeric,
  "LastUpdatedDate" timestamptz,
  "LastUpdatedBy" text,
  "TotalCost" numeric
);

create table "vAppearance" (
  "WebPortalID" text,
  "Name" text,
  "ButtonsBackgroundColor" text,
  "ButtonsColor" text,
  "ContactsTextColor" text,
  "ContentColor" text,
  "ContentLinkColor" text,
  "FooterBackgroundColor" text,
  "FooterLinkColor" text,
  "FooterTextColor" text,
  "HeaderBackgroundColor" text,
  "NavigationTextColor" text,
  "NavigationTextHoverColor" text,
  "PageBackgroundColor" text,
  "PreFooterBackgroundColor" text,
  "PreFooterTextColor" text,
  "PreHeaderBackgroundColor" text,
  "SloganBackgroundColor" text,
  "Status" text
);

create table "vAspnetUserRoles" (
  "UserId" text,
  "UserName" text,
  "Name" text
);

create table "vAttributeSet" (
  "ID" integer,
  "Name" text
);

create table "vAvalaraCustomerData" (
  "Id" integer,
  "CustomerID" text,
  "CustomerName" text,
  "AvalaraCustomerID" integer,
  "AvalaraCustomerName" text,
  "IsLinked" boolean,
  "Selected" boolean
);

create table "vAvalaraCustomerLookup" (
  "CustomerID" text,
  "Name" text,
  "IsDisplay" boolean
);

create table "vBankAccount" (
  "AccountCode" text,
  "DisplayName" text
);

create table "vBanknoteDenomination" (
  "BanknoteID" text,
  "Code" text,
  "Nominal" numeric
);

create table "vBulkListingProduct" (
  "ProductID" text,
  "ProductCode" text,
  "Name" text,
  "Status" text,
  "Category" text,
  "Price" numeric,
  "OrderedQuantity" numeric,
  "MinimumToOrder" integer,
  "MaximumToOrder" integer,
  "Quantity" numeric,
  "MenuItems" text,
  "IsBackorderEnabled" boolean
);

create table "vCCLP" (
  "CustomerID" text,
  "Name" text,
  "LoyaltyPoints" numeric,
  "StoreCredits" numeric,
  "SendReceiptViaEmail" boolean
);

create table "vCarrierList" (
  "value" text,
  "name" text
);

create table "vCarrierServiceList" (
  "FakeID" text,
  "CarrierCode" text,
  "ServiceCode" text,
  "Highlighted" boolean,
  "DisplayName" text,
  "CarrierServiceCode" text,
  "Domestic" boolean,
  "International" boolean
);

create table "vCin7PayTransaction" (
  "PaymentIntent" text,
  "Created" timestamptz,
  "Amount" numeric,
  "Currency" text
);

create table "vConsolidateCustomers" (
  "value" text,
  "name" text
);

create table "vConsolidationChannelTypesStore" (
  "EntryID" text,
  "SaleChannel" text,
  "InvoiceSyncType" text,
  "COGSSyncType" text
);

create table "vContact" (
  "ID" text,
  "ECSConfigID" text,
  "ECSName" text,
  "IsOrganization" boolean,
  "ContactType" text,
  "Status" text,
  "Tags" text
);

create table "vContactType" (
  "ContactType" text,
  "ContactTypeLocalized" text
);

create table "vCountry" (
  "Code" text,
  "configid" text,
  "Name" text,
  "Code2" text
);

create table "vCurrency" (
  "Currency" text,
  "DisplayCurrency" text
);

create table "vCustomIntegration" (
  "ShipstationUseStockLocator" boolean,
  "ShipstationExportFFOrders" boolean,
  "ShipStationTimezone" text,
  "Enabled" boolean,
  "ImportShippingCosts" boolean,
  "ApplyTaxOnShippingCost" boolean,
  "ShippingCostZeroTaxRule" text,
  "IgnoreBillingContact" boolean,
  "CustomStoreCurrency" text
);

create table "vCustomerInvite" (
  "ID" text,
  "CustomerID" text,
  "CustomerName" text,
  "ContactPerson" text,
  "Email" text,
  "Status" text,
  "Role" text,
  "InviteSendDate" timestamptz,
  "InviteAccepted" boolean,
  "Selected" boolean,
  "SaleRepAccessType" integer
);

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

create table "vDearPaymentGatewayNotificationsLogs" (
  "NotificationExecutionLogID" text,
  "ExecutionDate" timestamptz,
  "Recipients" text,
  "Subject" text,
  "CustomerBody" text,
  "MerchantBody" text,
  "Status" text,
  "ErrorMessage" text
);

create table "vDimensionUnit" (
  "Code" text,
  "Name" text
);

create table "vDispute" (
  "DisputeID" text,
  "DearPaymentGatewayTransactionID" text,
  "CustomerName" text,
  "Email" text,
  "Currency" text,
  "Amount" numeric,
  "FeeAmount" numeric,
  "ConvertedAmount" numeric,
  "ConvertedAmountToAdditionalChargeExceptFee" numeric,
  "State" text,
  "Reason" text,
  "DisputeDate" timestamptz,
  "DisputeDueDate" timestamptz,
  "TransactionDate" timestamptz,
  "DocumentName" text,
  "BillingAddressLine1" text,
  "BillingAddressLine2" text,
  "Error" text
);

create table "vDisputeItem" (
  "DisputeID" text,
  "DisputeItemID" text,
  "DisputeItemDate" timestamptz,
  "Actor" text,
  "Details" text,
  "Error" text
);

create table "vECSCarrierMapping" (
  "ID" text,
  "ECSConfigID" text,
  "CarrierID" text,
  "ECSCarrierCode" text,
  "Description" text
);

create table "vECSOrderLog" (
  "LogID" text,
  "ConfigID" text,
  "Date" timestamptz,
  "DownloadDate" timestamptz,
  "ProcessDate" timestamptz,
  "OrderNumber" text,
  "SaleTaskID" text,
  "Status" text,
  "Type" text,
  "SaleOrderNumber" text,
  "RefundID" text,
  "OrderID" text,
  "IsNewSale" boolean
);

create table "vECSPaymentsToExport" (
  "TaskID" text,
  "OrderID" text,
  "OrderNumber" text,
  "TaskID" text,
  "InvoiceNumber" text,
  "Error" text
);

create table "vECSPendingOrders" (
  "OrderLineID" text,
  "InvoiceDate" timestamptz,
  "Name" text,
  "Quantity" numeric,
  "Total" numeric,
  "Contact" text,
  "Error" text
);

create table "vECSPendingOrdersNew" (
  "OrderLineID" text,
  "OrderNumber" text,
  "DateCreated" timestamptz,
  "Name" text,
  "Quantity" numeric,
  "Total" numeric,
  "CustomerName" text,
  "Error" text,
  "ValidationText" text,
  "ValidationState" text
);

create table "vECSPurchases" (
  "LogID" text,
  "ConfigID" text,
  "ECSPurchaseID" text,
  "ECSPurchaseNumber" text,
  "ECSStatus" text,
  "DearPurchaseID" text,
  "CreatedDate" timestamptz,
  "ReceivedDate" timestamptz,
  "Location" text,
  "DearStatus" text,
  "DearOrderNumber" text
);

create table "vECSStockAdjustments" (
  "LogID" text,
  "ConfigID" text,
  "ECSStockAdjustmentID" text,
  "ECSStockAdjustmentNumber" text,
  "ECSStatus" text,
  "DearStockAdjustmentID" text,
  "CreatedDate" timestamptz,
  "CompletedDate" timestamptz,
  "DearStatus" text,
  "DearNumber" text
);

create table "vECSStockTransfers" (
  "LogID" text,
  "ConfigID" text,
  "ECSStockTransferID" text,
  "ECSStockTransferNumber" text,
  "ECSStatus" text,
  "DearStockTransferID" text,
  "FromLocation" text,
  "ToLocation" text,
  "CreatedDate" timestamptz,
  "ReceivedDate" timestamptz,
  "DearStatus" text,
  "DearNumber" text
);

create table "vEcsAddressTypesMapping" (
  "ID" text,
  "ECSConfigID" text,
  "ECSAddressType" text,
  "AddressType" text,
  "SortOrder" text
);

create table "vEcsBulkListing" (
  "ProductID" text,
  "ProductCode" text,
  "Name" text,
  "Status" text,
  "Category" text,
  "ProductType" text,
  "Price" numeric,
  "Quantity" numeric,
  "UseBufferInventory" boolean,
  "BufferInventory" integer,
  "SyncBufferInventory" integer,
  "SyncQuantity" numeric
);

create table "vEcsCarriersMapping" (
  "ID" text,
  "ECSConfigID" text,
  "CarrierID" text,
  "Description" text,
  "ECSCarrierCode" text
);

create table "vEcsCatalogItemNew" (
  "SIMID" text,
  "ProductID" text,
  "FamilyID" text,
  "EntityType" text,
  "LinkedSKU" text,
  "LinkedName" text,
  "SKU" text,
  "Name" text,
  "Status" text,
  "ImageID" text,
  "SyncStockLevel" boolean,
  "Price" numeric,
  "Category" text,
  "Option1" text,
  "Option2" text,
  "Option3" text,
  "IsStockProduct" boolean,
  "IgnoreProductUpdation" boolean,
  "Quantity" numeric
);

create table "vEcsConfiguration" (
  "ID" text,
  "TenantID" text,
  "ShopName" text,
  "AccessToken" text,
  "RefreshToken" text,
  "PrimaryPriceTier" integer,
  "ConsolidationType" text,
  "ConsolidationTimeText" text,
  "ConsolidateToCustomerID" text,
  "IsActive" boolean,
  "PickWhenOrderStatus" text,
  "ShippingTaxed" boolean,
  "SyncStockLevel" boolean,
  "ExportShippingInformation" boolean,
  "AutoInvoicingMode" text,
  "AutoFulfilmentMode" text,
  "ECSspecificParameter1" boolean,
  "ECSspecificParameter9" text,
  "ECSspecificParameter8" text,
  "ECSspecificParameter6" boolean,
  "ECSspecificParameter10" text,
  "CustomerName" text,
  "ECSTokenType" text,
  "RevenueAccount" text,
  "MoneySettlementBankAccount" text,
  "CustomSalesRepresentative" text,
  "UseAsMasterSource" boolean,
  "CompatibleToDEAR" boolean,
  "ManualMapping" boolean,
  "AutoCreateNewProductAllowed" boolean,
  "MatchProductByName" boolean,
  "LocationID" text,
  "EnableOrderRouting" boolean,
  "CreateAssembly" text,
  "IgnoreRestockForNotFulfilled" boolean,
  "IsConsolidateBySettlement" boolean,
  "GroupTransactionBy" text,
  "ConsolidationSubType" text
);

create table "vEcsContactTagMapping" (
  "ID" text,
  "ECSConfigID" text,
  "ECSTag" text,
  "ContactType" text,
  "SortOrder" text
);

create table "vEcsLocationMapping" (
  "ID" text,
  "ECSConfigID" text,
  "ECSLocationName" text,
  "ECSLocationID" text,
  "LocationID" text,
  "LocationName" text
);

create table "vEcsManualJournalAccountMapping" (
  "ID" text,
  "EcsConfigID" text,
  "EcsAccountCode" text,
  "EcsAccountType" text,
  "Description" text,
  "Value" text,
  "SortOrder" integer,
  "SkipMapping" boolean,
  "TaxRuleID" text
);

create table "vEcsManualJournalSet" (
  "SetID" text,
  "EcsConfigID" text,
  "ActualDate" timestamptz,
  "DateStart" timestamptz,
  "DateEnd" timestamptz,
  "Status" text,
  "IsExportable" boolean
);

create table "vEcsOperationLog" (
  "ID" text,
  "ConfigID" text,
  "Date" timestamptz,
  "Description" text,
  "Category" text,
  "Processed" boolean,
  "Type" integer,
  "UserName" text,
  "ConfigName" text,
  "ConfigType" text,
  "Disabled" boolean
);

create table "vEcsOverviewCustomersList" (
  "CustomerID" text,
  "Name" text,
  "OrderCount" integer,
  "PaidTotalAmount" numeric,
  "ConfigID" text
);

create table "vEcsOverviewFulfilmentCustomersList" (
  "CustomerID" text,
  "CustomerName" text,
  "OrderCount" integer,
  "ConfigID" text
);

create table "vEcsOverviewOrdersList" (
  "Date" timestamptz,
  "SaleOrderNumber" text,
  "CustomerName" text,
  "Status" text,
  "FulfillmentOrderID" text,
  "SaleTaskID" text,
  "ConfigID" text
);

create table "vEcsOverviewSalesList" (
  "SaleOrderDate" timestamptz,
  "SaleOrderNumber" text,
  "CustomerName" text,
  "Status" text,
  "PaidTotalAmount" numeric,
  "InvoicingStatus" text,
  "OrderStatus" text,
  "FulFilmentStatus" text,
  "PaymentStatus" text,
  "TaskID" text,
  "TT" integer,
  "ConfigID" text
);

create table "vEcsPaymentProcessorMapping" (
  "ID" text,
  "ConfigID" text,
  "PaymentProcessorID" text,
  "PaymentProcessorName" text,
  "LedgerAccount" text,
  "AccountName" text,
  "SortOrder" text
);

create table "vEcsProductVariation" (
  "SIMID" text,
  "SKU" text,
  "Name" text,
  "Category" text,
  "Option1" text,
  "Option2" text,
  "Option3" text,
  "Status" text,
  "CustomField1" text,
  "CustomField2" text,
  "CustomField3" text,
  "CustomField4" text,
  "CustomField5" text,
  "CustomField6" text,
  "CustomField7" text,
  "CustomField8" text,
  "CustomField9" text,
  "CustomField10" text,
  "Price" numeric,
  "SIMFamilyID" text,
  "ProductID" text,
  "LinkedName" text,
  "LinkedSKU" text,
  "ImageID" text,
  "ValidationText" text,
  "MaxRows" integer
);

create table "vEcsTaxMapping" (
  "ID" text,
  "ECSConfigID" text,
  "ECSTaxType" text,
  "ECSTaxID" text,
  "Description" text,
  "Value" text,
  "TaxRuleName" text,
  "SortOrder" integer
);

create table "vEmailNotification" (
  "EmailNotificationSettingsID" text,
  "IsActive" boolean,
  "Code" text,
  "EmailTemplate" text,
  "EmailSubject" text,
  "ConditionParameterValue" text,
  "Error" text
);

create table "vEtsyLanguage" (
  "Code" text,
  "description" text
);

create table "vExportFilter" (
  "ParameterName" text,
  "Condition" text,
  "Value" text,
  "Join" text,
  "ValidationText" text,
  "ValidationState" text
);

create table "vExportFilterItem" (
  "Value" text,
  "Name" text
);

create table "vExportFilterItemGroupped" (
  "Value" text,
  "Name" text,
  "Group" text,
  "IsFirst" boolean
);

create table "vExportSale" (
  "TaskID" text,
  "OrderNo" text,
  "OrderDate" timestamptz,
  "Status" text,
  "TotalAmount" numeric,
  "Currency" text,
  "Customer" text
);

create table "vFFProduct" (
  "ID" text,
  "ConfigID" text,
  "FFProductID" text,
  "SKU" text,
  "FFSKU" text,
  "Name" text,
  "Price" numeric,
  "QuantityFulfillable" numeric,
  "QuantityWarehouse" numeric,
  "QuantityUnsellable" numeric,
  "QuantityReserved" numeric,
  "QuantityInbound" numeric,
  "Quantity" numeric,
  "ProductID" text,
  "MappedSKU" text,
  "MappedName" text,
  "ImageID" text,
  "AdditionalField1" text,
  "AdditionalField2" text,
  "AdditionalField3" text,
  "AdditionalField4" text,
  "AdditionalField5" text,
  "AdditionalField6" text,
  "AdditionalField7" text,
  "AdditionalField8" text,
  "AdditionalField9" text,
  "AdditionalField10" text,
  "IsLinktoAnotherLocation" boolean,
  "IsEligibleForBlankBox" boolean,
  "QuantityBlankBox" text
);

create table "vFaireTaxonomyType" (
  "Id" text,
  "Name" text
);

create table "vFulfillmentInboundShipment" (
  "InboundShipmentID" text,
  "ConfigID" text,
  "Currency" text,
  "CarrierName" text,
  "ShippingMethod" text,
  "TrackingNumber" text,
  "ShipmentPacking" text,
  "PaperType" text,
  "PageType" text,
  "ShipmentDate" timestamptz,
  "FromBox" integer,
  "ToBox" integer,
  "GeneratePaperType" text,
  "TransferOrderID" text,
  "HasPrintedLabels" boolean,
  "TransferOrderNumber" text,
  "OrderDate" timestamptz,
  "ShipmentID" text,
  "ShipmentStatus" text,
  "LabelPrepType" text,
  "BoxContentsSource" text,
  "ShipmentName" text,
  "DestinationFulfillmentCenterId" text,
  "AreCasesRequired" boolean,
  "ConfirmedNeedByDate" timestamptz,
  "AddressName" text,
  "AddressLine1" text,
  "AddressLine2" text,
  "AddressDistrictOrCounty" text,
  "AddressCity" text,
  "AddressStateOrProvinceCode" text,
  "AddressCountryCode" text,
  "AddressStateOrProvinceCode" text,
  "AddressPostalCode" text,
  "TotalUnits" integer,
  "AmountPerUnit" numeric,
  "TotalAmount" numeric,
  "ShippingMode" text,
  "IsPartnered" boolean,
  "FreightReadyDate" timestamptz,
  "DeclaredValue" numeric,
  "BoxCount" integer,
  "IsEstimateCalculated" boolean,
  "ValidationText" text,
  "ValidationState" text
);

create table "vFulfillmentInboundShipmentBoxContent" (
  "ID" text,
  "InboundShipmentID" text,
  "BoxNumber" integer,
  "ProductID" text,
  "SKU" text,
  "ProductName" text,
  "ProductPrice" numeric,
  "ProductTotalPrice" numeric,
  "UnitsPerBox" integer,
  "QuantityInCase" integer,
  "NumberOfBoxes" integer,
  "BoxWidth" numeric,
  "BoxHeight" numeric,
  "BoxDepth" numeric,
  "BoxWeight" numeric,
  "ASIN" text,
  "TransferOrderID" text,
  "TransferOrderNumber" text,
  "ShipmentDate" timestamptz,
  "ValidationText" text,
  "ValidationState" text
);

create table "vFulfillmentInboundShipmentEstimate" (
  "CalculationID" text,
  "ConfigID" text,
  "InboundShipmentID" text,
  "Carrier" text,
  "NumberOfBoxes" integer,
  "ShipmentWeight" numeric,
  "ShipmentCosts" numeric,
  "FreightReadyDate" timestamptz,
  "FreightClass" text,
  "DeclaredValue" numeric,
  "NumberOfPallets" integer,
  "PickUpDate" timestamptz,
  "Status" text,
  "CalculationDate" timestamptz,
  "ValidationText" text,
  "ValidationState" text
);

create table "vFulfillmentInboundShipmentItem" (
  "LineID" text,
  "InboundShipmentID" text,
  "ConfigID" text,
  "ASIN" text,
  "HasPrintedLabels" boolean,
  "LocationID" text,
  "LocationName" text,
  "ProductCode" text,
  "ProductName" text,
  "ProductPrice" numeric,
  "ProductTotalPrice" numeric,
  "ProductID" text,
  "QuantityInCase" integer,
  "QuantityReceived" integer,
  "QuantityShipped" integer,
  "SKU" text,
  "ShipmentDate" timestamptz,
  "ShipmentStatus" text,
  "TransferOrderID" text,
  "TransferOrderNumber" text,
  "Condition" text,
  "ReleaseDate" timestamptz,
  "ValidationText" text,
  "ValidationState" text
);

create table "vFulfillmentInboundShipmentList" (
  "InboundShipmentID" text,
  "ConfigID" text,
  "Currency" text,
  "TransferOrderID" text,
  "TransferOrderNumber" text,
  "HasPrintedLabels" boolean,
  "HasBillOfLading" boolean,
  "HasPalletLabels" boolean,
  "HasMultipleShipments" boolean,
  "CarrierName" text,
  "ShippingMethod" text,
  "ShipmentID" text,
  "ShipmentStatus" text,
  "TotalUnits" integer,
  "AmountPerUnit" numeric,
  "TotalAmount" numeric,
  "ShipmentDate" timestamptz,
  "SellerCentralLink" text,
  "LocationName" text,
  "ValidationText" text,
  "ValidationState" text
);

create table "vFulfillmentInboundShipmentPallet" (
  "ID" text,
  "ConfigID" text,
  "InboundShipmentID" text,
  "NumberOfPallets" integer,
  "PalletWeight" numeric,
  "PalletDepth" numeric,
  "PalletWidth" numeric,
  "PalletHeight" numeric,
  "TransferOrderID" text,
  "TransferOrderNumber" text,
  "ShipmentDate" timestamptz,
  "IsStackable" boolean,
  "ValidationText" text,
  "ValidationState" text
);

create table "vFulfillmentInboundShipmentWrapper" (
  "ID" text,
  "HasErrors" boolean
);

create table "vGSuiteConfig" (
  "ConfigID" text,
  "HasSyncContacts" boolean,
  "HasExportData" boolean,
  "GD_DefaultDirID_Printing" text,
  "GD_DefaultDirPath_Printing" text,
  "GD_DefaultDirID_Reporting" text,
  "GD_DefaultDirPath_Reporting" text,
  "NeedsToReconnect" boolean,
  "ConnectedGoogleEmail" text,
  "RequiresFolderReselection" boolean
);

create table "vGSuiteLog" (
  "LogID" text,
  "Action" text,
  "Message" text,
  "LogDate" timestamptz
);

create table "vHubSpot" (
  "HubSpotID" text,
  "IsActive" boolean,
  "PriceTier" text,
  "PriceTierCurrency" text,
  "DefaultLocation" text,
  "AutoSync" boolean,
  "AutoSync_StartDateStr" text,
  "AutoSync_StartTime" text,
  "AutoSync_Frequency" text,
  "AutoSync_ErrorAlertType" text,
  "AutoSync_MailListID" text,
  "ProductSyncType" text,
  "ProductExport_DescriptionType" text,
  "ProductExport_TermValue" integer,
  "ProductExport_TermPeriod" text,
  "ProductImport_Type" text,
  "ProductImport_Category" text,
  "ProductImport_MappingByUniqueName" boolean,
  "ProductImport_AutoCreate" boolean,
  "CustomerSyncType" text,
  "CustomerExport_AddressType" text,
  "CustomerExport_AllowCustomFields" boolean,
  "CustomerExport_CustomFieldGoupName" text,
  "CustomerImport_ImportContactsWithoutCompanies" boolean,
  "SyncMarketingConsent" boolean,
  "ForceUpdateOnImport" boolean,
  "ForceUpdateOnExport" boolean,
  "CustomerImport_UseDefaultSettings" boolean,
  "CustomerImport_BaseCurrency" text,
  "CustomerImport_RevenueAccount" text,
  "CustomerImport_PaymentTerm" text,
  "CustomerImport_PurchaseTaxRule" text,
  "CustomerImport_SaleTaxRule" text,
  "SaleSyncType" text,
  "SaleImport_HubSpotPipeline" text,
  "SaleImport_CreateSaleWhenHubSpotReachesStage" text
);

create table "vHubSpotContact" (
  "ID" text,
  "ContactName" text,
  "CompanyName" text,
  "IsOrganization" boolean
);

create table "vHubspotFieldsMapping" (
  "ID" text,
  "ECSConfigID" text,
  "DearFieldModel" text,
  "DearFieldName" text,
  "ECSFieldName" text
);

create table "vImportSale" (
  "DealID" text,
  "DealCurrency" text,
  "HubSpotDealId" text,
  "HubSpotDealName" text,
  "HubSpotDealDate" timestamptz,
  "HubSpotTotal" numeric,
  "HubSpotDealStage" text,
  "Error" text,
  "ValidationText" text,
  "ValidationState" text
);

create table "vInboundShipmentBoxLabes" (
  "FromBox" integer,
  "ToBox" integer,
  "TotalOfBoxes" integer,
  "PaperType" text,
  "ValidationText" text,
  "ValidationState" text
);

create table "vInboundShipmentCharges" (
  "ShippingCarrier" text,
  "NumberOfBoxes" integer,
  "ShipmentWeight" numeric,
  "BillableWeight" numeric,
  "EstimatedShipmentCost" numeric,
  "FreightReadyDate" timestamptz,
  "FreightClass" text,
  "DeclaredValue" numeric,
  "ContactPerson" text,
  "ValidationText" text,
  "ValidationState" text
);

create table "vInboundShipmentPrintLabes" (
  "NumberOfBoxes" integer,
  "PaperType" text,
  "PaperSize" text,
  "ShipmentDate" timestamptz,
  "ValidationText" text,
  "ValidationState" text
);

create table "vInternalNotification" (
  "NotificationSettingsID" text,
  "IsActive" boolean,
  "Code" text,
  "Error" text
);

create table "vInvoiceTemplate" (
  "TemplateID" text,
  "Name" text
);

create table "vListingProfile" (
  "id" text,
  "Name" text,
  "ShippingProfileID" text,
  "ShippingProfileName" text,
  "ReadinessStateId" jsonb
);

create table "vLocation" (
  "LocationID" text,
  "Description" text
);

create table "vLog" (
  "LogID" text,
  "Action" text,
  "Message" text,
  "AdditionalInfo" text,
  "LogDate" timestamptz,
  "Error" text,
  "LogType" text,
  "SyncID" text,
  "AffectedEntitiesCount" integer,
  "ValidationText" text,
  "ValidationState" text
);

create table "vLogRecord" (
  "ID" text,
  "LogDate" text,
  "FulfillmentOrderId" text,
  "FFOrderID" text,
  "ChangesText" text,
  "ChangedBy" text
);

create table "vMagentoStores" (
  "ID" text,
  "Name" text
);

create table "vMailingList" (
  "MailingListID" text,
  "Name" text,
  "Emails" text,
  "ValidationText" text,
  "ValidationState" text
);

create table "vManualJournalLine" (
  "EcsManualJournalSetID" text,
  "ID" text,
  "Description" text,
  "Amount" numeric,
  "Tax" numeric,
  "AccountCode" text,
  "AccountName" text,
  "TaxRuleID" text,
  "TaxRuleName" text
);

create table "vMarginTax" (
  "Code" boolean,
  "Name" text
);

create table "vMarketplace" (
  "ID" text,
  "Name" text
);

create table "vNameCodeModel" (
  "Code" text,
  "Name" text
);

create table "vNameValue" (
  "Name" text,
  "Value" text
);

create table "vNavbarItem" (
  "ID" text,
  "WebPortalID" text,
  "NavbarType" text,
  "Item" text,
  "ItemId" text,
  "ItemName" text,
  "DisplayName" text,
  "ItemType" text,
  "LineOrder" integer
);

create table "vOverviewAbandonedCarts" (
  "ID" text,
  "DateTime" timestamptz,
  "ContactName" text,
  "Quantity" numeric,
  "CartTotal" numeric
);

create table "vOverviewCustomers" (
  "CustomerID" text,
  "CustomerName" text,
  "Sales" integer,
  "Amount" numeric
);

create table "vOverviewSales" (
  "ID" text,
  "Date" timestamptz,
  "Number" text,
  "CustomerName" text,
  "CustomerID" text,
  "Amount" numeric,
  "Status" text,
  "TaskType" text
);

create table "vPackagesList" (
  "name" text,
  "value" text,
  "Domestic" boolean,
  "International" boolean
);

create table "vPaymentAccount" (
  "Code" text,
  "DisplayName" text
);

create table "vPaymentMethod" (
  "Value" text,
  "Name" text
);

create table "vPaymentMethodSurcharge" (
  "SurchargeID" text,
  "PaymentMethodID" text,
  "ConfigID" text
);

create table "vPayout" (
  "PayoutID" text,
  "PayoutPlanedDate" timestamptz,
  "PayoutDate" timestamptz,
  "State" text,
  "PayoutAmount" numeric,
  "MoneyTaskID" text,
  "PurchaseTaskID" text,
  "Note" text,
  "Error" text
);

create table "vPayoutItem" (
  "PayoutItemID" text,
  "PayoutID" text,
  "TransactionDate" timestamptz,
  "DocumentName" text,
  "CustomerName" text,
  "Amount" numeric,
  "Error" text
);

create table "vPortalEmailTemplate" (
  "WebPortalID" text,
  "Name" text,
  "Content" text,
  "Description" text,
  "Subject" text
);

create table "vPortalPage" (
  "WebPortalPageID" text,
  "WebPortalID" text,
  "Name" text,
  "LineOrder" text,
  "Content" text,
  "IsActive" text,
  "Type" text
);

create table "vPortalPriceList" (
  "WebPortalID" text,
  "Name" text,
  "ID" text,
  "LineOrder" integer
);

create table "vPosOutlets" (
  "PosOutletID" text,
  "LocationID" text,
  "OutletName" text,
  "TimeZone" text,
  "DefaultTaxRule" text,
  "LocationName" text,
  "DefaultTaxRuleName" text,
  "CountRegistry" integer,
  "EcsPaymentProcessorID" text,
  "LedgerAccount" text,
  "ReceiptID" text,
  "PrintNotes" boolean,
  "PrintDiscounts" boolean,
  "Active" boolean,
  "SquareIntegrationID" text,
  "PaymentSenseURL" text,
  "PaymentSenseAPIKey" text,
  "SurchargeTaxRule" text,
  "PaymentSenseAPIKey" text,
  "TyroMerchantID" text,
  "TriPOSAccountID" text,
  "TriPOSAcceptorID" text,
  "TriPOSAccountToken" text,
  "CustomizedCustomerDisplayUI" boolean,
  "CustomerDisplayLogo" text,
  "CustomerDisplayBackground" text
);

create table "vPosProductEx" (
  "ProductID" text,
  "Name" text,
  "SKU" text,
  "Category" text,
  "OutletSKU" text,
  "ConfigID" text,
  "PosOutletID" text,
  "ValidationText" text,
  "ValidationState" text
);

create table "vPosQuickKey" (
  "QuickKeyID" text,
  "Name" text,
  "ContentQuery" text
);

create table "vPriceListBrand" (
  "ID" text,
  "WebPortalPriceListID" text,
  "BrandID" text,
  "Name" text
);

create table "vPriceListCategory" (
  "ID" text,
  "WebPortalPriceListID" text,
  "CategoryID" text,
  "Name" text
);

create table "vPriceListTag" (
  "ID" text,
  "WebPortalPriceListID" text,
  "Tag" text
);

create table "vProductAttributeRow" (
  "ID" text,
  "DisplayName" text,
  "SetID" text,
  "ColumnNumber" text,
  "AttributeSetName" text,
  "ColumnName" text,
  "ColumnType" text,
  "ColumnValues" text,
  "AttributeName" text
);

create table "vProductCatalogModel" (
  "ID" text,
  "HubSpotCatalogID" text,
  "ProductID" text,
  "ProductCode" text,
  "Name" text,
  "Type" text,
  "CategoryName" text,
  "Status" text,
  "HubSpotName" text,
  "HubSpotObjectID" text,
  "HubSpotPrice" text,
  "PriceTier1" numeric,
  "PriceTier2" numeric,
  "PriceTier3" numeric,
  "PriceTier4" numeric,
  "PriceTier5" numeric,
  "PriceTier6" numeric,
  "PriceTier7" numeric,
  "PriceTier8" numeric,
  "PriceTier9" numeric,
  "PriceTier10" numeric,
  "ValidationState" text,
  "ValidationText" text
);

create table "vProductTaxCode" (
  "Type" text,
  "ProductID" text,
  "ProductCode" text,
  "ProductName" text,
  "AvalaraTaxCode" text,
  "AvalaraTaxName" text
);

create table "vProductToExportModel" (
  "ProductID" text,
  "ProductCode" text,
  "Name" text,
  "Type" text,
  "CategoryName" text,
  "Status" text,
  "PriceTier" integer,
  "PriceTier1" numeric,
  "PriceTier2" numeric,
  "PriceTier3" numeric,
  "PriceTier4" numeric,
  "PriceTier5" numeric,
  "PriceTier6" numeric,
  "PriceTier7" numeric,
  "PriceTier8" numeric,
  "PriceTier9" numeric,
  "PriceTier10" numeric
);

create table "vProductVariation" (
  "ProductID" text,
  "FamilyID" text,
  "ProductCode" text,
  "ImageID" text,
  "Name" text,
  "Option1" text,
  "Option2" text,
  "Option3" text
);

create table "vProductionCalendar" (
  "CalendarID" text,
  "Year" integer,
  "WeekStart" integer,
  "ValidationState" text,
  "ValidationText" text
);

create table "vProductionCalendarDay" (
  "DayID" text,
  "CalendarID" text,
  "DayOfWeek" integer,
  "IsWeekend" boolean,
  "StartTime" integer,
  "EndTime" integer,
  "StartTimeStr" text,
  "EndTimeStr" text,
  "BreakStartTime" integer,
  "BreakEndTime" integer,
  "BreakStartTimeStr" text,
  "BreakEndTimeStr" text,
  "SortOrder" integer,
  "ValidationState" text,
  "ValidationText" text
);

create table "vProductionCalendarSpecialDay" (
  "DayID" text,
  "CalendarID" text,
  "Date" timestamptz,
  "IsWeekend" boolean,
  "IsHoliday" boolean,
  "StartTime" integer,
  "EndTime" integer,
  "StartTimeStr" text,
  "EndTimeStr" text,
  "BreakStartTime" integer,
  "BreakEndTime" integer,
  "BreakStartTimeStr" text,
  "BreakEndTimeStr" text,
  "Comment" text,
  "ValidationState" text,
  "ValidationText" text
);

create table "vReadinessState" (
  "Id" jsonb,
  "Title" text,
  "ReadinessState" text,
  "DisplayTitle" text
);

create table "vReceiptTemplate" (
  "TemplateID" text,
  "Name" text
);

create table "vRefundReasons" (
  "Code" text,
  "Name" text
);

create table "vRegistries" (
  "ConfigID" text,
  "RegistryID" text,
  "RegistryCode" text,
  "LocationID" text,
  "LocationName" text,
  "EcsPaymentProcessorID" text,
  "LedgerAccount" text,
  "ReceiptID" text,
  "TillDiscrepancyMapping" text,
  "CashFloatMapping" text,
  "PettyCashMapping" text,
  "CashInOutMapping" text,
  "RegistryPrefix" text,
  "RegistrySuffix" text,
  "Active" boolean,
  "QuickKeyID" text,
  "UseTyro" boolean,
  "TyroTerminalID" text,
  "UseTriPOS" boolean,
  "TriPOSLaneID" text,
  "CatalogTilesSize" text,
  "CatalogTilesVisibility" text,
  "ShowProductAvailability" boolean,
  "LinklyUserName" text,
  "LinklyPassword" text,
  "WindcaveStation" text
);

create table "vReportLayout" (
  "Fakeid" text,
  "ReportName" text,
  "LayoutName" text,
  "Layout" text
);

create table "vReportTemplate" (
  "TemplateID" text,
  "Name" text
);

create table "vSSExportLog" (
  "ScheduledPeriod" timestamptz,
  "OrderNumber" text,
  "FulfillmentNumber" text,
  "InvoiceNumber" text,
  "OrderID" text,
  "FulfillmenID" text,
  "InvoiceID" text,
  "CustomerName" text,
  "ShipByDate" timestamptz,
  "Status" text,
  "Comments" text,
  "StatusDate" timestamptz
);

create table "vSSStoreList" (
  "name" text,
  "value" text
);

create table "vSSTenantAddress" (
  "AddressID" text,
  "Line1" text,
  "Line2" text,
  "CitySuburb" text,
  "StateProvince" text,
  "ZipPostCode" text,
  "Country" text,
  "CountryLine" text
);

create table "vSaleAttribute" (
  "Id" integer,
  "Name" text,
  "Type" text
);

create table "vScheduledExport" (
  "periodBeg" timestamptz,
  "periodEnd" timestamptz
);

create table "vSendNotificationOnLabelGeneration" (
  "Code" boolean,
  "Name" text
);

create table "vShipIntegrationLocationMapping" (
  "ID" text,
  "ConfigID" text,
  "WarehouseName" text,
  "WarehouseId" text,
  "LocationID" text,
  "LocationName" text,
  "IsActive" boolean
);

create table "vShipServConf" (
  "ID" text,
  "ModuleType" text
);

create table "vShippingMetadataMapping" (
  "FakeID" text,
  "PropertyName" text,
  "Value" text
);

create table "vShippingMethod" (
  "ID" text,
  "Name" text
);

create table "vShippingService" (
  "ID" text,
  "Name" text
);

create table "vShippingTemplate" (
  "Id" text,
  "Title" text
);

create table "vShipstationNotMatchingAddresses" (
  "TaskID" text,
  "InvoiceNumber" text,
  "ShippingAddressLine1" text,
  "ShippingAddressLine2" text,
  "CustomerName" text,
  "CustomerID" text,
  "InvoiceDate" timestamptz,
  "ShipmentRequiredByDate" timestamptz,
  "Reason" text
);

create table "vShopifyCatalogBulkListing" (
  "ProductID" text,
  "ProductCode" text,
  "Name" text,
  "Status" text,
  "Available" integer,
  "CategoryName" text,
  "PriceTear1" numeric,
  "PriceTear2" numeric,
  "PriceTear3" numeric,
  "PriceTear4" numeric,
  "PriceTear5" numeric,
  "PriceTear6" numeric,
  "PriceTear7" numeric,
  "PriceTear8" numeric,
  "PriceTear9" numeric,
  "PriceTear10" numeric,
  "SellOutOfStock" boolean,
  "UseBufferInventory" boolean,
  "BufferInventory" integer,
  "SyncBufferInventory" integer,
  "SyncQuantity" numeric,
  "IsLinkToKitProduct" boolean
);

create table "vShopifyCatalogList" (
  "ProductID" text,
  "ProductCode" text,
  "Name" text,
  "Status" text,
  "PriceTier" integer,
  "Available" integer,
  "PriceTear1" numeric,
  "PriceTear2" numeric,
  "PriceTear3" numeric,
  "PriceTear4" numeric,
  "PriceTear5" numeric,
  "PriceTear6" numeric,
  "PriceTear7" numeric,
  "PriceTear8" numeric,
  "PriceTear9" numeric,
  "PriceTear10" numeric,
  "SellOutOfStock" boolean,
  "UseBufferInventory" boolean,
  "BufferInventory" integer,
  "SyncBufferInventory" integer,
  "SyncQuantity" numeric,
  "IsLinkToKitProduct" boolean
);

create table "vShopifyConfiguration" (
  "ConfigID" text,
  "TenantID" text,
  "ShopName" text,
  "AccessToken" text,
  "LastCheck" timestamptz,
  "IsActive" boolean,
  "ConsolidationType" text,
  "ConsolidationTimeText" text,
  "ConsolidateToCustomerID" text,
  "CustomerName" text,
  "Topic" text,
  "ShippingTaxed" boolean,
  "SyncStockLevel" boolean,
  "ListAsDraft" boolean,
  "AllowDuplicateNames" boolean,
  "UseCompanyAsCustomer" boolean,
  "AddCompanyToAddresses" boolean,
  "UploadFulfilmentWithoutTrackingNumber" boolean,
  "SellOutOfStock" boolean,
  "BringDiscountCodes" boolean,
  "AutoShippingMode" text,
  "InvoiceStatus" text,
  "LiabilityAccount" text,
  "RevenueAccount" text,
  "CustomSalesRepresentative" text,
  "PriceTier" integer,
  "LocationID" text,
  "LocationName" text,
  "NotAllScopesAdded" boolean,
  "EnableOrderRouting" boolean,
  "AddDiscountAsChangedPrice" boolean,
  "AppendTrackingNumberToTrackingUrl" boolean,
  "CreateAssembly" text,
  "AutoSyncRetry" boolean,
  "HighLoad" boolean,
  "IgnoreRestockForNotFulfilled" boolean,
  "CreationDate" timestamptz,
  "UseBufferInventory" boolean,
  "BufferInventory" integer,
  "EnablePartialFulfillment" boolean,
  "SupportDuplicatedSKU" boolean,
  "CustomFieldForTags" integer,
  "CustomFieldForType" integer,
  "MasterDataSource" text,
  "RetailDeliveryAccount" text,
  "Country" text,
  "UseLogging" boolean,
  "CompareAtPriceTier" integer,
  "LoadOrdersFromShopify" boolean,
  "OrderLockDate" text,
  "LoadAdditionalProductProperties" boolean,
  "PaymentReferenceType" text,
  "OrderExclusionTags" text,
  "ImportProductsAutomatically" boolean,
  "ImportProductsFromDate" text,
  "HonourShopifyLocation" boolean,
  "TimeDelayOrderDownloadMinutes" integer,
  "ConsolidationFrequencyHours" integer
);

create table "vShopifyLocation" (
  "ID" text,
  "ConfigID" text,
  "ShopifyLocationName" text,
  "ShopifyLocationID" integer,
  "IsFulfillmentLocation" boolean,
  "IsActive" boolean,
  "LocationID" text,
  "LocationName" text,
  "IsSelected" boolean
);

create table "vShopifyLog" (
  "LogID" text,
  "ConfigID" text,
  "Date" timestamptz,
  "DownloadDate" timestamptz,
  "ProcessDate" timestamptz,
  "OrderNumber" text,
  "SaleTaskID" text,
  "InventoryTaskID" text,
  "Status" text,
  "Type" text,
  "FulfillmentNumber" numeric,
  "SaleOrderNumber" text,
  "StocktakeNumber" text,
  "TT" numeric
);

create table "vShopifyOperationLog" (
  "ID" text,
  "ConfigID" text,
  "Date" timestamptz,
  "Description" text,
  "Category" text,
  "Processed" boolean,
  "Type" integer,
  "UserName" text,
  "TT" integer
);

create table "vShopifyPaymentProcessorMapping" (
  "ID" text,
  "ConfigID" text,
  "PaymentProcessor" text,
  "AccountCode" text,
  "SortOrder" integer,
  "AccountName" text
);

create table "vShopifyPendingOrders" (
  "OrderLineID" text,
  "OrderNumber" text,
  "InvoiceDate" timestamptz,
  "Name" text,
  "Quantity" numeric,
  "Total" numeric,
  "Contact" text,
  "Error" text,
  "ValidationText" text,
  "ValidationState" text
);

create table "vShopifyTaxMapping" (
  "ID" text,
  "ConfigID" text,
  "Country" text,
  "Province" text,
  "Name" text,
  "Value" text,
  "SortOrder" integer,
  "TaxRuleName" text
);

create table "vShortLocation" (
  "LocationID" text,
  "Description" text
);

create table "vSortingOption" (
  "WebPortalID" text,
  "ID" text,
  "Name" text,
  "B2BName" text,
  "IsDefault" boolean
);

create table "vSquareIntegration" (
  "ID" text,
  "ShopName" text
);

create table "vSurcharge" (
  "PaymentMethod" text,
  "Type" text,
  "FlatAmount" numeric,
  "Rate" numeric,
  "MaxAmount" numeric
);

create table "vSyncEntry" (
  "SaleTaskID" text,
  "Type" text,
  "DateSynchronised" timestamptz,
  "DateCreated" timestamptz,
  "Status" text,
  "Error" text,
  "SaleOrderNumber" text,
  "InvoiceNumber" text,
  "CreditNoteNumber" text,
  "InvoiceDate" timestamptz,
  "SaleOrderDate" timestamptz,
  "CustomerID" text,
  "CustomerName" text,
  "ControllerName" text
);

create table "vTax" (
  "RuleID" text,
  "Description" text
);

create table "vTaxRules" (
  "RuleID" text,
  "Description" text
);

create table "vTenantAddress" (
  "AddressID" text,
  "Line1" text,
  "Line2" text,
  "CitySuburb" text,
  "StateProvince" text,
  "ZipPostCode" text,
  "Country" text,
  "Type" text,
  "DefaultForType" boolean
);

create table "vTime" (
  "Value" text,
  "Name" text
);

create table "vTimezone" (
  "name" text,
  "displayName" text
);

create table "vUSTaxMapping" (
  "id" integer,
  "configid" text,
  "zip" text,
  "city" text,
  "county" text
);

create table "vUseCustomerTax" (
  "Code" boolean,
  "Name" text
);

create table "vUserImage" (
  "UserId" text,
  "ImageID" text,
  "ContentType" text,
  "FileName" text,
  "Uri" text,
  "isDefault" boolean,
  "IsImage" boolean
);

create table "vWebPortal" (
  "WebPortalID" text,
  "Name" text,
  "Type" text,
  "Domain" text,
  "Description" text,
  "IsActive" boolean,
  "HorizontalNavbarDataType" text,
  "DefaultCustomer" text,
  "AllowBackorder" boolean,
  "ShowAdditionalAttributes" boolean,
  "ShowOutOfStockItems" boolean,
  "ShowMinimumOrderQuantityForProducts" boolean,
  "ShowMaximumOrderQuantityForProducts" boolean,
  "FacebookURL" text,
  "GooglePlusURL" text,
  "TwitterURL" text,
  "InstagramURL" text,
  "YouTubeURL" text,
  "LinkedInURL" text,
  "TenantContactID" text,
  "TenantAddressID" text,
  "LocationID" text,
  "ShowImagesInShoppingCart" boolean,
  "SalesRepresentative" text,
  "GoogleAnalyticsTrackerID" text,
  "GoogleAnalytics4TrackerID" text,
  "UseHubSpotTracking" boolean,
  "ShowAllCustomerOrders" boolean,
  "CreateSaleAs" text,
  "InvoiceTemplateID" text,
  "PriceListTemplateID" text,
  "HeaderBackgroundColor" text,
  "NavigationTextColor" text,
  "NavigationTextHoverColor" text,
  "ContactsTextColor" text,
  "PageBackgroundColor" text,
  "PreHeaderBackgroundColor" text,
  "TitleTextColor" text,
  "ContentColor" text,
  "ContentLinkColor" text,
  "ButtonsBackgroundColor" text,
  "CategoryTextBackgroundColor" text,
  "CategoryTextColor" text,
  "SloganBackgroundColor" text,
  "Slogan" text,
  "PreFooterBackgroundColor" text,
  "PreFooterTextColor" text,
  "FooterBackgroundColor" text,
  "FooterTextColor" text,
  "TableHeaderBackgroundColor" text,
  "TableHeaderColor" text,
  "DefaultRevenueAccount" text,
  "LogoGuid" text,
  "CartImageGuid" text,
  "NoImageGuid" text,
  "ShowAvailableQuantity" text,
  "ShowNotDiscountedPrice" boolean,
  "IncludeAvailableQtyToPriceList" boolean,
  "ProductExtraParams" text,
  "NewTagName" text,
  "ShippingService" text,
  "FamilyPriceFormat" text,
  "ProductListLayout" text,
  "ShowTaxPercents" boolean,
  "ShowTaxMethod" boolean,
  "HideImagesInProductList" boolean,
  "OutOfStockColor" text,
  "InStockColor" text,
  "IsAttachmentMandatory" boolean,
  "AllowGuestAccess" boolean,
  "PriceTierForGuestUser" integer,
  "ButtonsColor" text,
  "PriceColor" text,
  "FooterLinkColor" text,
  "CustomMenuFirstLevelBgColor" text,
  "CustomMenuFirstLevelHoverBgColor" text,
  "CustomMenuFirstLevelTextColor" text,
  "CustomMenuSecondLevelBgColor" text,
  "CustomMenuSecondLevelHoverBgColor" text,
  "CustomMenuSecondLevelTitleColor" text,
  "CustomMenuSecondLevelTextColor" text,
  "CustomMenuThirdLevelBgColor" text,
  "CustomMenuThirdLevelHoverBgColor" text,
  "CustomMenuThirdLevelTitleColor" text,
  "CustomMenuThirdLevelTextColor" text,
  "CustomMenuSeparatorColor" text,
  "CustomDomain" text,
  "MinimumOrderAmount" numeric,
  "MaximumOrderAmount" numeric,
  "HideShippingCost" boolean,
  "EnableOrderRouting" boolean,
  "ShowDealInformation" boolean,
  "RRPPriceTier" integer,
  "AllowCreateOrderWhenCreditHold" boolean,
  "FamilyProductsView" integer,
  "EnabledProductReturn" boolean,
  "ReturnDeliveryLocationID" text,
  "ShowLeftMenuBrands" boolean,
  "ShowLeftMenuCategories" boolean,
  "ShowLeftMenuTags" boolean,
  "EnabledAbandonedCarts" boolean,
  "AbandonedCartTimeValue" integer,
  "AbandonedCartTimeUnit" text,
  "MaxMenuItemCount" integer,
  "ShowSeparateProductsForFamily" boolean,
  "ShowSingleMultipleDeliveryOptions" boolean,
  "LogInInfo" text,
  "ShowCustomerAttachmentsOnly" boolean
);

create table "vWebPortalPageElements" (
  "Id" text,
  "WebPortalId" text,
  "Name" text,
  "LineOrder" integer,
  "IsRemovable" boolean,
  "IsVisible" boolean,
  "SectionType" text,
  "Location" text,
  "HideNavigationMenu" boolean
);

create table "vWebPortalPageElementsDetails" (
  "Id" text,
  "WebPortalPageElementId" text,
  "DetailsType" text,
  "LineOrder" integer,
  "LinkType" text,
  "ContentType" text,
  "LinkItem" text,
  "LinkMessage" text,
  "LinkUrl" text,
  "Text" text,
  "FileName" text,
  "FileHtml" text,
  "IsFamily" text
);

create table "vWebPortalSale" (
  "TaskId" text,
  "OrderDate" timestamptz,
  "Customer" text,
  "SaleOrderNumber" text,
  "Status" text,
  "PaymentStatus" text,
  "InvoiceAmount" numeric,
  "Reference" text
);

create table "vWeightUnit" (
  "Code" text,
  "Name" text
);
