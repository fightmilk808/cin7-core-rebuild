-- Reference books: one table per Cin7 Core data model, generated from data/models.json

create table "AccountingDimensionsWrapper" (
  "ID" text,
  "HasErrors" boolean
);

create table "AttachedFile" (
  "EmailID" text,
  "AttachmentID" text,
  "Send" boolean,
  "FileName" text,
  "ContentType" text,
  "BlobGUID" text
);

create table "BOMProductList" (
  "ProductID" text,
  "CodeWithName" text
);

create table "BalanceWrapper" (
  "HasErrors" boolean,
  "TenantID" text,
  "HistoricalAccount" text,
  "Error" text,
  "OpeningBalancesDate" timestamptz
);

create table "BinGroup" (
  "ID" text,
  "Name" text,
  "LocationID" text
);

create table "Brand" (
  "ID" text,
  "Name" text
);

create table "Category" (
  "ID" text,
  "Name" text
);

create table "ConnectionTypeModel" (
  "ID" integer,
  "Name" text
);

create table "ContactMailingLists" (
  "id" text,
  "name" text
);

create table "CountryRegion" (
  "ID" text,
  "Selected" boolean,
  "CountryCode2" text,
  "RegionName" text
);

create table "CustomPriceLine" (
  "ProductID" text,
  "ProductName" text,
  "ProductCode" text,
  "CustomPrice" numeric,
  "ImageID" text,
  "LatestPrice" numeric,
  "LatestDate" timestamptz,
  "ValidationState" text,
  "ValidationText" text
);

create table "DearToDearContactEmail" (
  "FakeID" text,
  "EmailID" text,
  "ID" text,
  "Email" text,
  "ConnectionType" integer
);

create table "DiscountWrapper" (
  "ID" integer,
  "HasErrors" boolean
);

create table "Email" (
  "Checked" text,
  "EmailID" text,
  "From" text,
  "To" text,
  "CC" text,
  "Subject" text,
  "Body" text,
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

create table "LocationWrapper" (
  "ID" integer,
  "HasErrors" boolean,
  "RecommendBatchSN" numeric
);

create table "MarkupLine" (
  "TierNumber" integer,
  "Price" numeric,
  "CalculatedPrice" numeric,
  "Calculated" boolean,
  "MarkupType" text,
  "UsePriceType" text,
  "MarkupValue" numeric,
  "ValidationState" text,
  "ValidationText" text
);

create table "MarkupType" (
  "Value" text,
  "Name" text
);

create table "MeasurementUnit" (
  "UoMAbbr" text,
  "UoMName" text,
  "IsFirst" boolean,
  "MeasurementSystem" text
);

create table "MovementTypeModel" (
  "name" text,
  "value" text
);

create table "OpeningBalanceLine" (
  "Code" text,
  "TaskID" text,
  "Name" text,
  "Currency" text,
  "CurrencyName" text,
  "Debit" numeric,
  "SystemAccount" text,
  "AccountType" text,
  "AccountClass" text,
  "Credit" numeric,
  "InventoryAsset" boolean,
  "ValidationText" text,
  "ValidationState" text
);

create table "PerformedImportActions" (
  "ActionType" text,
  "Code" text,
  "NewCode" text,
  "Name" text,
  "Type" text,
  "Class" text,
  "Status" text,
  "ImportResult" text,
  "IsSuccessed" boolean
);

create table "PickZones" (
  "Value" text,
  "LocationID" text
);

create table "PriceTiers" (
  "Code" integer,
  "Name" text
);

create table "ProductMarkupPrices" (
  "ProductID" text,
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
  "AvgPriceUsed1" text,
  "AvgPriceUsed2" text,
  "AvgPriceUsed3" text,
  "AvgPriceUsed4" text,
  "AvgPriceUsed5" text,
  "AvgPriceUsed6" text,
  "AvgPriceUsed7" text,
  "AvgPriceUsed8" text,
  "AvgPriceUsed9" text,
  "AvgPriceUsed10" text
);

create table "ProductStatus" (
  "Value" text,
  "Name" text
);

create table "ProductWrapper" (
  "ID" integer,
  "HasErrors" boolean
);

create table "PurchaseReferenceData" (
  "ID" integer,
  "OrderViewPermission" text,
  "OrderAuthorisationPermission" text,
  "BillCreditNoteViewPermission" text,
  "BillCreditNoteAuthorisationPermission" text,
  "StockReceivedViewPermission" text,
  "StockReceivedAuthorisationPermission" text,
  "EditAuthorizedDocumentsPermission" text,
  "UndoPermission" text,
  "VoidPermission" text,
  "OrderApproveRejectReviewPermission" text,
  "OtherUsersAttachmentsPermission" text,
  "ProductFamilyCount" integer,
  "DefaultAccount" text,
  "TaxCalculationMethod" text,
  "DefaultPurchaseMethod" text,
  "HeadersVisible" text,
  "FixedAssetPermission" text,
  "CurrentAttributeSetId" text,
  "AttributeSetCopyFrom" text,
  "UsePurchasePutAway" boolean,
  "LockDate" timestamptz,
  "CountrySpecificData" text,
  "IsArchiveEnabled" boolean,
  "IsOrderApproveEnabled" boolean,
  "FinancialDataPermission" text,
  "IsAccountingDimensionsEnabled" boolean,
  "SaleAllowOrderNoAlloc" boolean
);

create table "RMAReturnPolicy" (
  "ID" text,
  "Name" text,
  "CreatedDate" timestamptz,
  "UpdatedDate" timestamptz,
  "IsActive" boolean,
  "IsRefundPossible" boolean,
  "RefundPaymentOptions" text,
  "RefundDays" integer,
  "IsReplacementPossible" boolean,
  "IsPossibleCrossSale" boolean,
  "ReplacementDays" integer,
  "RestockingFeesPercent" integer,
  "RestockingFeesFixedAmount" integer,
  "InspectionsCost" text,
  "RepairCost" text,
  "IsReturnPossible" boolean,
  "ReturnDays" integer,
  "ShippingCost" text,
  "PolicyText" text
);

create table "RMAReturnPolicyGrid" (
  "ID" text,
  "Name" text,
  "CreatedDate" timestamptz,
  "UpdatedDate" timestamptz,
  "IsActive" boolean
);

create table "ReasonForReturn" (
  "ID" text,
  "Name" text
);

create table "Reassign_TenantContact" (
  "ContactID" text,
  "Name" text
);

create table "Recipients" (
  "Name" text,
  "Email" text,
  "IncludeInEmail" text,
  "SupplierCustomerID" text,
  "ConnectionType" integer
);

create table "SaleReferenceDataWrapper" (
  "ID" integer,
  "DefaultTaxRule" text
);

create table "SupplierCustomerModel" (
  "ID" text,
  "Name" text,
  "Type" integer
);

create table "SupplyInterval" (
  "ID" text,
  "DeliveryMethod" text,
  "IntervalStartDate" timestamptz,
  "IsMonday" boolean,
  "IsTuesday" boolean,
  "IsWednesday" boolean,
  "IsThursday" boolean,
  "IsFriday" boolean,
  "IsSaturday" boolean,
  "IsSunday" boolean,
  "LocationID" text,
  "LeadSafetyOptionID" text
);

create table "TaxInclusive" (
  "Value" boolean,
  "Name" text
);

create table "TaxStatus" (
  "Value" text,
  "Name" text
);

create table "TenantLocation" (
  "ID" text,
  "Name" text
);

create table "TenantLocationPutAwayRule" (
  "ID" text,
  "Name" text,
  "IsActive" boolean,
  "LocationID" text,
  "IsAppliedForAllProducts" boolean,
  "IsAllowBatchSplit" boolean,
  "MinCapacity" numeric,
  "MaxCapacity" numeric,
  "MinLength" numeric,
  "MaxLength" numeric,
  "MinWidth" numeric,
  "MaxWidth" numeric,
  "MinHeight" numeric,
  "MaxHeight" numeric,
  "MinWeight" numeric,
  "MaxWeight" numeric
);

create table "TenantLocationSupplyRule" (
  "ID" text,
  "Name" text,
  "IsActive" boolean,
  "IsAppliedForAllProducts" boolean,
  "LocationID" text
);

create table "WarrantySetupWrapper" (
  "ID" integer,
  "HasErrors" boolean
);

create table "Year" (
  "year" numeric
);

create table "accountModel" (
  "Code" text,
  "DisplayName" text
);

create table "pProductAdditionalDescriptions" (
  "SIMProductID" text,
  "AliasName" text,
  "ShopName" text,
  "ShopType" text,
  "ProductID" text,
  "SKU" text,
  "ECSConfigID" text,
  "ECSProductID" text,
  "ECSVariantID" text,
  "ECSDescription" text
);

create table "pProduct_AdditionalUnitsOfMeasure_SearchProduct" (
  "ProductID" text,
  "Name" text,
  "Code" text,
  "Unit" text,
  "PriceTear1" numeric,
  "PriceTear2" numeric,
  "PriceTear3" numeric,
  "PriceTear4" numeric,
  "PriceTear5" numeric,
  "PriceTear6" numeric,
  "PriceTear7" numeric,
  "PriceTear8" numeric,
  "PriceTear9" numeric,
  "PriceTear10" numeric
);

create table "vAccountClassTypes" (
  "Class" text
);

create table "vAccountStatusCode" (
  "Value" text,
  "Name" text
);

create table "vAccountTypesAndClasses" (
  "Description" text,
  "AccountType" text,
  "AccountClass" text,
  "IsFirst" boolean
);

create table "vAccountingDimension" (
  "ID" text,
  "Name1" text,
  "Name2" text,
  "Name3" text,
  "Name4" text,
  "Name5" text,
  "Name6" text,
  "Name7" text,
  "Name8" text,
  "Name9" text,
  "Name10" text,
  "IsActive1" boolean,
  "IsActive2" boolean,
  "IsActive3" boolean,
  "IsActive4" boolean,
  "IsActive5" boolean,
  "IsActive6" boolean,
  "IsActive7" boolean,
  "IsActive8" boolean,
  "IsActive9" boolean,
  "IsActive10" boolean,
  "ListValues1" text,
  "ListValues2" text,
  "ListValues3" text,
  "ListValues4" text,
  "ListValues5" text,
  "ListValues6" text,
  "ListValues7" text,
  "ListValues8" text,
  "ListValues9" text,
  "ListValues10" text,
  "Type1" text,
  "Type2" text,
  "Type3" text,
  "Type4" text,
  "Type5" text,
  "Type6" text,
  "Type7" text,
  "Type8" text,
  "Type9" text,
  "Type10" text,
  "ValidationState" boolean,
  "ValidationText" text
);

create table "vAccountingDimensionAttribute" (
  "AttributeID" text,
  "Name" text,
  "Type" text,
  "ListValues" text,
  "IsActive" boolean,
  "ValidationText" text,
  "ValidationState" text
);

create table "vAccountingDimensionsChartOfAccount" (
  "ID" text,
  "AccountCode" text,
  "IsAtribute1Enabled" boolean,
  "IsAtribute2Enabled" boolean,
  "IsAtribute3Enabled" boolean,
  "IsAtribute4Enabled" boolean,
  "IsAtribute5Enabled" boolean,
  "IsAtribute6Enabled" boolean,
  "IsAtribute7Enabled" boolean,
  "IsAtribute8Enabled" boolean,
  "IsAtribute9Enabled" boolean,
  "IsAtribute10Enabled" boolean,
  "IsCustomerAtributeEnabled" boolean,
  "IsSupplierAtributeEnabled" boolean,
  "IsProductAtributeEnabled" boolean,
  "IsExpenseClaimAtributeEnabled" boolean,
  "IsCompanyContactAtributeEnabled" boolean,
  "IsProductionResourceAtributeEnabled" boolean,
  "ValidationState" text,
  "ValidationText" text
);

create table "vBOMServices" (
  "FakeID" integer,
  "ItemID" text,
  "ComponentProductID" text,
  "ProductID" text,
  "Name" text,
  "Quantity" numeric,
  "Cost" numeric,
  "PriceTier" numeric,
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
  "ExpenseAccount" text,
  "ValidationText" text,
  "ValidationState" text
);

create table "vBankAccount" (
  "AccountCode" text,
  "DisplayName" text
);

create table "vBankAccountToShow" (
  "AccountID" text,
  "Bank" text,
  "AccountName" text,
  "AccountCode" text,
  "AccountNumber" text,
  "Currency" text,
  "StatementBalance" numeric,
  "BalanceInDear" numeric,
  "BalanceInDearInBankAccountCurrency" numeric,
  "InitialBalance" numeric,
  "LastDate" timestamptz,
  "TransactionCount" integer
);

create table "vBillOfMaterialFinishedProducts" (
  "ProductID" text,
  "ProductCode" text,
  "Name" text,
  "Cost" numeric,
  "CostingMethod" text,
  "ImageID" text,
  "Unit" text,
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

create table "vBillOfMaterialProducts" (
  "ProductID" text,
  "ProductCode" text,
  "Name" text,
  "Cost" numeric,
  "CostingMethod" text,
  "ImageID" text,
  "Unit" text,
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

create table "vBillOfMaterialServices" (
  "ProductID" text,
  "Name" text,
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
  "ExpenseAccount" text
);

create table "vBillOfMaterials" (
  "FakeID" integer,
  "ItemID" text,
  "ComponentProductID" text,
  "ProductID" text,
  "ProductCode" text,
  "Name" text,
  "Quantity" numeric,
  "WastagePercent" numeric,
  "WastageQuantity" numeric,
  "CostPercentage" numeric,
  "Cost" numeric,
  "TotalCost" numeric,
  "CostingMethod" text,
  "ValidationText" text,
  "ValidationState" text
);

create table "vBin" (
  "LocationID" text,
  "Description" text
);

create table "vBinData" (
  "LocationID" text,
  "Name" text
);

create table "vBinDataBinGroups" (
  "LocationID" text,
  "Name" text
);

create table "vBinGroup" (
  "ID" text,
  "Name" text
);

create table "vBinSimple" (
  "LocationID" text,
  "Description" text,
  "BinGroupID" text
);

create table "vBomVersion" (
  "BomID" text,
  "Version" integer,
  "Name" text,
  "DisplayName" text,
  "IsDefault" boolean
);

create table "vBrand" (
  "BrandID" text,
  "Name" text
);

create table "vCategory" (
  "CategoryID" text,
  "Name" text
);

create table "vCondition" (
  "ConditionID" text,
  "Field" text,
  "Condition" text,
  "Expected" text,
  "LineOrder" integer
);

create table "vCountry" (
  "Code" text,
  "configid" text,
  "Name" text,
  "Code2" text
);

create table "vCountryOfOrigin" (
  "Code" text,
  "Name" text
);

create table "vCustomPrice" (
  "ProductID" text,
  "CustomerID" text,
  "Price" numeric,
  "IsDeleted" boolean
);

create table "vDeal" (
  "ID" text,
  "Name" text,
  "DateFrom" timestamptz,
  "DateTo" timestamptz,
  "IsActive" boolean,
  "AllowCoupons" boolean,
  "SingleCouponCodeUsage" boolean,
  "CouponCodes" text,
  "CustomersGroup" text,
  "ValidationText" text,
  "ValidationState" text
);

create table "vDearToDearNetworking" (
  "ID" text,
  "SupplierCustomerID" text,
  "Name" text,
  "SupplierID" text,
  "SupplierName" text,
  "CustomerID" text,
  "CustomerName" text,
  "ConnectionType" integer,
  "IsInviteSent" boolean,
  "Status" text,
  "DateInviteSent" timestamptz,
  "DateConnected" timestamptz,
  "NetworkingKey" text,
  "LastUpdatedDate" timestamptz,
  "ValidationState" text,
  "ValidationText" text
);

create table "vDemandLocationID" (
  "SupplyIntervalID" text,
  "LocationID" text
);

create table "vDiscountLine" (
  "FakeID" integer,
  "ID" text,
  "DiscountID" text,
  "MinValue" numeric,
  "MaxValue" numeric,
  "Type" text,
  "Amount" numeric,
  "ValidationText" text,
  "ValidationState" text
);

create table "vDiscountMatrix" (
  "FakeID" integer,
  "ID" text,
  "DiscountID" text,
  "CustomerID" text,
  "ProductID" text,
  "Customer" text,
  "DiscountName" text,
  "CustomerTag" text,
  "ValidationText" text,
  "ValidationState" text
);

create table "vDiscountMatrixCustomer" (
  "CustomerID" text,
  "Name" text
);

create table "vError" (
  "Message" text
);

create table "vExpenseItem" (
  "ExpenseItemID" text,
  "Description" text,
  "AccountCode" text
);

create table "vFamily" (
  "FamilyID" text,
  "FamilyValue" text,
  "RMAReturnPolicyID" text
);

create table "vIntegration" (
  "NetworkingKey" text,
  "LegalName" text,
  "FromMail" text
);

create table "vLeadStatus" (
  "StatusID" text,
  "Name" text,
  "IsActive" boolean,
  "IsKanban" boolean,
  "Position" integer,
  "ValidationText" text,
  "ValidationState" text
);

create table "vLocation" (
  "LocationID" text,
  "Description" text
);

create table "vLogisticsPath" (
  "PathID" text,
  "WarehouseLocationID" text,
  "ShopFloorLocationID" text,
  "RetailLocationID" text
);

create table "vMakeToOrderBomConfiguration" (
  "BOMConfigurationID" text,
  "HasValidationErrors" boolean,
  "MenuConfigurationID" text,
  "Name" text,
  "ProductID" text,
  "TemplateID" text,
  "TemplateName" text,
  "QuantityRelationsJSON" text,
  "QuantityConfigurationJSON" text,
  "ValidationState" text,
  "ValidationText" text,
  "IsExpanded" boolean
);

create table "vMakeToOrderBomImage" (
  "MenuConfigurationID" text,
  "TemplateName" text,
  "OperationID" text,
  "OriginalDetailedImageUrl" text,
  "OriginalSketchUrl" text,
  "UpdatedDetailedImageUrl" text,
  "UpdatedSketchUrl" text
);

create table "vMakeToOrderBomProductFamily" (
  "ID" text,
  "Name" text,
  "Unit" text
);

create table "vMakeToOrderBomProductMap" (
  "BOMConfigurationID" text,
  "BOMProductMapID" text,
  "IsMain" boolean,
  "MappedProductCode" jsonb,
  "MappedProductID" jsonb,
  "MappedProductName" jsonb,
  "MappedProductUnit" jsonb,
  "MenuConfigurationID" text,
  "Name" text,
  "MenuConfigurationType" integer,
  "ProductID" text,
  "Quantity" numeric,
  "Order" numeric
);

create table "vMakeToOrderConditionOperator" (
  "Value" text,
  "Name" text
);

create table "vMakeToOrderConfigMenuItem" (
  "Level" integer,
  "MenuConfigurationID" text,
  "Name" text,
  "Type" integer
);

create table "vMakeToOrderConfigTemplate" (
  "IsDisabled" boolean,
  "TemplateID" text,
  "TemplateName" text
);

create table "vMakeToOrderJoinCondition" (
  "Value" text,
  "Label" text
);

create table "vMakeToOrderMappedProduct" (
  "ProductCode" text,
  "ProductID" text,
  "Name" text,
  "Unit" text
);

create table "vMakeToOrderMenuConfiguration" (
  "Description" text,
  "DetailedImageID" text,
  "MenuConfigurationID" text,
  "IsDefault" jsonb,
  "IsOpened" jsonb,
  "IsOptional" jsonb,
  "Name" text,
  "Order" integer,
  "ParentID" jsonb,
  "PriceDelta" numeric,
  "ProductFamilyID" jsonb,
  "ProductFamilyName" jsonb,
  "ProductFamilyUnitOfMeasure" text,
  "ProductID" text,
  "SketchImageID" text,
  "Type" integer,
  "IsCopy" boolean,
  "ValidationState" text,
  "ValidationText" text
);

create table "vMakeToOrderMenuConfigurationCondition" (
  "MenuConfigurationConditionID" text,
  "Condition" text,
  "IsHidden" boolean,
  "JoinCondition" text,
  "MenuConfigurationID" text,
  "RelatedMenuConfigurationID" text,
  "RelatedMenuConfigurationName" text,
  "ValidationState" text,
  "ValidationText" text
);

create table "vMakeToOrderQuantityMenuItem" (
  "BOMConfigurationID" text,
  "MenuConfigurationID" text,
  "Name" text
);

create table "vMakeToOrderQuantityMenuItemOption" (
  "Level" integer,
  "MenuConfigurationID" text,
  "Name" text
);

create table "vMakeToOrderTreeConfigItem" (
  "IsDisabled" boolean,
  "Level" integer,
  "MenuConfigurationID" text,
  "Name" text
);

create table "vMakeToOrderVisibilityOption" (
  "Value" text,
  "Label" text
);

create table "vMilestone" (
  "ID" text,
  "Name" text,
  "Number" integer,
  "RMACostTypeID" text,
  "RMACostTypeName" text,
  "ChargedTo" text,
  "RMAReturnPolicyID" text,
  "ValidationState" text,
  "ValidationText" text
);

create table "vMissingExpenseAccountInBOM" (
  "ProductID" text,
  "ProductCode" text,
  "Name" text
);

create table "vOpeningBalanceFixedAsset" (
  "ID" text,
  "TaskID" text,
  "PurchaseOrderNumber" text,
  "AccountCode" text,
  "Amount" numeric
);

create table "vOpeningBalanceMultiCurrencyLine" (
  "ID" text,
  "TaskID" text,
  "AccountCode" text,
  "Type" text,
  "Currency" text,
  "Amount" numeric,
  "Rate" numeric,
  "CurrencyName" text,
  "SystemAccount" text,
  "ValidationText" text,
  "ValidationState" text
);

create table "vOpeningBalancePurchases" (
  "TaskID" text,
  "TenantID" text,
  "SupplierID" text,
  "AccountCode" text,
  "SupplierName" text,
  "Currency" text,
  "InvoiceTotalAmount" numeric,
  "CurrencyConversionRate" numeric,
  "InvoiceDate" timestamptz,
  "SupplierReference" text,
  "ValidationText" text,
  "ValidationState" text,
  "InvoiceDueDate" timestamptz
);

create table "vOpeningBalanceSales" (
  "TaskID" text,
  "TenantID" text,
  "CustomerID" text,
  "AccountCode" text,
  "CustomerName" text,
  "Currency" text,
  "InvoiceTotalAmount" numeric,
  "CurrencyConversionRate" numeric,
  "InvoiceDate" timestamptz,
  "CustomerReference" text,
  "InvoiceNumber" text,
  "ValidationText" text,
  "ValidationState" text,
  "InvoiceDueDate" timestamptz
);

create table "vOpeningBalanceStockOnHand" (
  "ID" text,
  "TaskID" text,
  "PurchaseOrderNumber" text,
  "AccountCode" text,
  "Amount" numeric
);

create table "vOpeningBalancesFixedAssetDetail" (
  "CardID" text,
  "TaskID" text,
  "Date" timestamptz,
  "PurchaseDate" timestamptz,
  "DepreciationStartDate" timestamptz,
  "Quantity" numeric,
  "UnitCost" numeric,
  "BatchSN" text,
  "Product" text,
  "ProductID" text,
  "Location" text,
  "LocationID" text,
  "DepreciationMethod" text,
  "AveragingMethod" text,
  "Rate" numeric,
  "EffectiveLife" numeric,
  "SalvageValue" numeric,
  "AssetAccountCode" text,
  "AssetAccount" text,
  "AccumulatedDepreciationAccountCode" text,
  "DepreciationExpenseAccountCode" text,
  "StartAccumulatedDepreciationAmount" numeric,
  "ValidationText" text,
  "ValidationState" text
);

create table "vOpeningBalancesSOHDetail" (
  "CardID" text,
  "TaskID" text,
  "Date" timestamptz,
  "Quantity" numeric,
  "UnitCost" numeric,
  "BatchSN" text,
  "ExpiryDate" timestamptz,
  "AccountCode" text,
  "Account" text,
  "Product" text,
  "Location" text,
  "ValidationText" text,
  "ValidationState" text
);

create table "vOrderRouting" (
  "TenantID" text,
  "OrderRoutingEnabled" boolean,
  "OrderRoutingKeepRouting" boolean,
  "ValidationText" text,
  "ValidationState" text
);

create table "vOrderRoutingSettings" (
  "ID" text,
  "LocationID" text,
  "LocationName" text,
  "City" text,
  "State" text,
  "ZipPostCode" text,
  "Country" text,
  "TenantID" text,
  "ValidationText" text,
  "ValidationState" text
);

create table "vPickZone" (
  "Value" text
);

create table "vProblematicProductCode" (
  "ProductID" text,
  "ProductCode" text,
  "Name" text
);

create table "vProductAlternative" (
  "MainProductID" text,
  "AlternativeProductID" text,
  "AlternativeProductCode" text,
  "AlternativeProductName" text,
  "Matching" numeric,
  "UseInProduction" boolean,
  "IsInterchangeable" boolean,
  "Quantity" numeric,
  "ValidationText" text,
  "ValidationState" text
);

create table "vProductAlternativeAdd" (
  "ProductID" text,
  "ProductCode" text,
  "Name" text
);

create table "vProductCombinedList" (
  "ID" text,
  "ProductCode" text,
  "Name" text,
  "DefaultUnitOfMeasure" text,
  "Type" text,
  "Category" text,
  "Brand" text,
  "LatestSupplier" text,
  "Status" text,
  "Selected" boolean,
  "ImageID" text,
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
  "NotSellable" text,
  "RowType" integer,
  "CountVariants" integer,
  "Barcode" text,
  "BomType" text,
  "AttributeSetID" text
);

create table "vProductImage" (
  "ProductID" text,
  "ImageID" text,
  "ContentType" text,
  "FileName" text,
  "Uri" text,
  "isDefault" boolean,
  "IsImage" boolean,
  "ExternalDownloadLink" text,
  "ExternalViewLink" text,
  "RowOrderNum" integer
);

create table "vProductLeadSafetyOptionDisplay" (
  "FakeID" integer,
  "ID" text,
  "ProductID" text,
  "LocationID" text,
  "LocationName" text,
  "SupplierID" text,
  "SupplierName" text,
  "ReorderQuantity" numeric,
  "Lead" integer,
  "Safety" integer,
  "MinimumToReorder" numeric,
  "ReorderQuantityLocation" numeric,
  "LeadLocation" integer,
  "SafetyLocation" integer,
  "OnlyLocationRow" boolean,
  "ValidationText" text,
  "ValidationState" text
);

create table "vProductLeadSafetyOptions" (
  "FakeID" integer,
  "ID" text,
  "ProductID" text,
  "LocationID" text,
  "LocationName" text,
  "SupplierID" text,
  "SupplierName" text,
  "ReorderQuantity" numeric,
  "Lead" integer,
  "Safety" integer,
  "MinimumToReorder" numeric,
  "ValidationText" text,
  "ValidationState" text
);

create table "vProductList" (
  "ProductID" text,
  "ProductCode" text,
  "Name" text,
  "DefaultUnitOfMeasure" text,
  "Type" text,
  "Category" text,
  "Brand" text,
  "LatestSupplier" text,
  "Status" text,
  "Selected" boolean,
  "ImageID" text,
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
  "NotSellable" text
);

create table "vProductLocation" (
  "FakeID" integer,
  "ID" text,
  "LocationID" text,
  "ProductID" text,
  "MinimumBeforeReorder" numeric,
  "ReorderQuantity" numeric,
  "LocationName" text,
  "StockLocator" text,
  "PickZones" text,
  "ValidationText" text,
  "ValidationState" text
);

create table "vProductMarkups" (
  "TierNumber" integer,
  "ProductID" text,
  "MarkupType" text,
  "UsePriceType" text,
  "MarkupValue" numeric
);

create table "vProductMovement" (
  "CardDetailsID" text,
  "ProductID" text,
  "TaskID" text,
  "Type" text,
  "Number" text,
  "Status" text,
  "Date" timestamptz,
  "Quantity" numeric,
  "Amount" numeric,
  "Location" text,
  "BatchSN" text,
  "ExpiryDate" timestamptz,
  "FromTo" text
);

create table "vProductMovementQuantity" (
  "CardDetailsID" text,
  "ProductID" text,
  "TaskID" text,
  "Type" text,
  "Number" text,
  "Status" text,
  "Date" timestamptz,
  "Quantity" numeric,
  "Location" text,
  "BatchSN" text,
  "ExpiryDate" timestamptz,
  "FromTo" text
);

create table "vProductQuantityChanges" (
  "ConfigID" text,
  "ProductID" text,
  "TaskID" text,
  "ChangeDate" timestamptz,
  "Action" text,
  "Reference" text,
  "ReferenceName" text,
  "Location" text,
  "QtyMoved" text,
  "Available" text,
  "Status" text,
  "UserName" text
);

create table "vProductionBom" (
  "BomID" text,
  "ProductID" text,
  "OutputQuantity" numeric,
  "BufferPercent" numeric,
  "InstructionUrl" text,
  "IssueMethod" integer,
  "IssueMethodComponent" integer,
  "IssueMethodParameter" integer,
  "IgnoreCumulativeLeadTime" boolean,
  "ComponentProductionLeadTime" integer,
  "Version" integer,
  "Name" text,
  "IsDefault" boolean,
  "CreatedDate" timestamptz,
  "CreatedBy" text,
  "DeliveryTo" text,
  "IsTracing" boolean,
  "MinQuantity" numeric,
  "MaxQuantity" numeric,
  "DeviationPercent" numeric,
  "RunSize" numeric,
  "ValidationState" text,
  "ValidationText" text
);

create table "vProductionBomAttachment" (
  "AttachmentID" text,
  "OperationID" text,
  "FileName" text,
  "Date" timestamptz,
  "ContentType" text,
  "BlobGuid" text,
  "IsCloned" boolean,
  "ValidationState" text,
  "ValidationText" text,
  "Position" integer
);

create table "vProductionBomComponent" (
  "BomComponentID" text,
  "OperationID" text,
  "ProductID" text,
  "ProductName" text,
  "ProductSku" text,
  "Quantity" numeric,
  "WastageQty" numeric,
  "WastagePercent" numeric,
  "Cost" numeric,
  "CostingMethod" text,
  "ValidationState" text,
  "ValidationText" text,
  "Position" integer,
  "Unit" text,
  "SalePriceTier" integer,
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
  "IsBackflush" boolean
);

create table "vProductionBomCopy" (
  "BomID" text,
  "ProductID" text,
  "Version" integer,
  "VersionName" text,
  "ProductID" text,
  "ProductCode" text,
  "Name" text,
  "Description" text,
  "IsMakeToOrderBom" boolean
);

create table "vProductionBomNote" (
  "NoteID" text,
  "OperationID" text,
  "Note" text,
  "ValidationState" text,
  "ValidationText" text,
  "Position" integer
);

create table "vProductionBomOperation" (
  "OperationID" text,
  "BomID" text,
  "Order" integer,
  "Name" text,
  "CycleTime" integer,
  "CycleTimeString" text,
  "UnitsPerCycle" numeric,
  "WorkCenterID" text,
  "WorkCenterName" text,
  "WorkCenterCoManProcurementType" text,
  "WorkCenterCode" text,
  "OperationType" integer,
  "TotalCost" numeric,
  "OperationRelationIDsFake" jsonb,
  "IsDropShip" boolean,
  "IsBackflush" boolean,
  "ValidationState" text,
  "ValidationText" text
);

create table "vProductionBomOperationLink" (
  "ID" text,
  "OperationID" text,
  "RelatedOperationID" text,
  "RelationType" integer,
  "ValidationState" text,
  "ValidationText" text
);

create table "vProductionBomOperationProduct" (
  "ID" text,
  "OperationID" text,
  "ProductID" text,
  "ProductName" text,
  "ProductSku" text,
  "Type" integer,
  "CostCalculationType" integer,
  "PriceTier" integer,
  "Ratio" numeric,
  "OutputQuantity" numeric,
  "AverageCost" numeric,
  "CostingMethod" text,
  "PriceTier" numeric,
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
  "Position" integer,
  "Unit" text,
  "Cost" numeric,
  "TotalCost" numeric,
  "Formula" text,
  "WastageCost" integer,
  "DeliveryTo" text,
  "ValidationState" text,
  "ValidationText" text
);

create table "vProductionBomResource" (
  "BomResourceID" text,
  "OperationID" text,
  "ResourceID" text,
  "ResourceName" text,
  "ResourceCode" text,
  "Quantity" numeric,
  "CycleTime" integer,
  "Cost" numeric,
  "ValidationState" text,
  "ValidationText" text,
  "Position" integer,
  "CostCalculationType" integer
);

create table "vProductionBomTemplate" (
  "TemplateID" text,
  "OperationID" text,
  "Name" text,
  "Quantity" numeric,
  "ValidationState" text,
  "ValidationText" text,
  "Position" integer
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

create table "vProductionOperationItem" (
  "ItemID" text,
  "OperationID" text,
  "Type" text,
  "Value" text,
  "ResourceID" text,
  "ResourceName" text,
  "ResourceCode" text,
  "Quantity" numeric,
  "ProductID" text,
  "ProductName" text,
  "ProductSku" text,
  "WastageQty" numeric,
  "WastagePercent" numeric,
  "AttachmentFileName" text,
  "AttachmentDate" timestamptz,
  "AttachmentContentType" text,
  "AttachmentBlobGuid" text,
  "Note" text,
  "Cost" numeric,
  "CostingMethod" text,
  "CycleTime" integer,
  "ValidationState" text,
  "ValidationText" text,
  "TotalCost" numeric,
  "Position" integer,
  "Unit" text,
  "WastageCost" integer,
  "SalePriceTier" integer,
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
  "TemplateID" text,
  "IsBackflush" boolean,
  "CostCalculationType" integer
);

create table "vProductionResources" (
  "ResourceID" text,
  "Code" text,
  "Name" text,
  "ResourceCost" numeric,
  "CycleDuration" integer
);

create table "vProductsAdditionalUnitsOfMeasure" (
  "FakeID" integer,
  "ID" text,
  "ParentProductID" text,
  "ProductID" text,
  "Name" text,
  "ProductCode" text,
  "DefaultUnitOfMeasure" text,
  "ConversionRate" numeric,
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
  "NotSellable" boolean,
  "ValidationText" text,
  "ValidationState" text
);

create table "vProductsStock" (
  "Name" text,
  "ProductID" text,
  "ProductCode" text,
  "BatchSN" text,
  "ExpiryDate" timestamptz,
  "Location" text,
  "Bin" text,
  "LocationID" text,
  "OnHand" numeric,
  "OnHandVolume" numeric,
  "Available" numeric,
  "Allocated" numeric,
  "OnOrder" numeric,
  "StockOnHand" numeric,
  "InTransit" numeric,
  "Category" text,
  "Brand" text,
  "Unit" text,
  "Family" text,
  "StockLocator" text,
  "Status" text,
  "Selected" boolean,
  "NextDeliveryDate" timestamptz
);

create table "vProductsStockAllocated" (
  "TaskID" text,
  "Number" text,
  "Type" text,
  "CustomerName" text,
  "Date" timestamptz,
  "Quantity" numeric
);

create table "vProductsStockInTransit" (
  "TaskID" text,
  "Number" text,
  "SupplierName" text,
  "Date" timestamptz,
  "RequiredByDate" timestamptz,
  "Quantity" numeric,
  "Type" text,
  "NextDeliveryDate" timestamptz
);

create table "vProductsStockOnOrder" (
  "TaskID" text,
  "Number" text,
  "SupplierName" text,
  "Date" timestamptz,
  "RequiredByDate" timestamptz,
  "Quantity" numeric,
  "Type" text,
  "NextDeliveryDate" timestamptz
);

create table "vPublishingProfile" (
  "Id" text,
  "Name" text
);

create table "vPurchase_Supplier" (
  "SupplierID" text,
  "Name" text,
  "Currency" text,
  "PaymentTerm" text,
  "TaxRule" text,
  "Comments" text,
  "Discount" numeric,
  "AttributeSet" text
);

create table "vRMACostType" (
  "ID" text,
  "Name" text
);

create table "vRMAExpenseAccount" (
  "DisplayName" text,
  "RuleID" text
);

create table "vServiceUsage" (
  "ID" text,
  "ProductID" text,
  "TaskID" text,
  "Type" text,
  "Number" text,
  "Status" text,
  "Date" timestamptz,
  "Price" numeric
);

create table "vSettings" (
  "NoWarrantyExpenseAccount" text,
  "ScrapWriteOffDefaultExpenseAccount" text,
  "WarrantyExpenseAccount" text,
  "DefaultReturnLocationID" text,
  "CreateCreditNoteType" text
);

create table "vShipZoneApplyTo" (
  "ID" text,
  "ZoneID" text,
  "Country2" text,
  "StateID" text,
  "PostCodeFrom" text,
  "PostCodeTo" text,
  "PostCodesList" text,
  "ShippingRate" numeric,
  "ValidationText" text,
  "ValidationState" text
);

create table "vShipZoneCountryCode" (
  "Code" text
);

create table "vSupplierProduct" (
  "FakeID" integer,
  "SupplierProductID" text,
  "SupplierID" text,
  "ProductID" text,
  "SupplierName" text,
  "Currency" text,
  "SupplierInventoryCode" text,
  "URL" text,
  "Cost" numeric,
  "FixedCost" numeric,
  "SupplierProductName" text,
  "SysDate" timestamptz,
  "DropShip" boolean,
  "IncludeInPricing" boolean,
  "ValidationText" text,
  "ValidationState" text
);

create table "vSupplyRuleAction" (
  "ID" text,
  "SupplyTask" text,
  "LocationID" text,
  "TakeStockQuantity" text,
  "FulfilDemandQuantity" text,
  "Capacity" numeric,
  "SupplierCondition" text,
  "RuleID" text,
  "LineOrder" integer,
  "IsOtherwiseAction" boolean
);

create table "vSystemAccount" (
  "Code" text,
  "Name" text
);

create table "vSystemAccountInfo" (
  "Code" text,
  "Name" text,
  "MultipleAllowed" text
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

create table "vTenantLocationList" (
  "LocationID" text,
  "Description" text
);

create table "vTenantShipZone" (
  "ZoneID" text,
  "Name" text,
  "IsRestZone" boolean,
  "ShortDesc" text,
  "PricesInclTax" boolean,
  "DefaultShippingCost" numeric,
  "Negative" boolean,
  "TaxRuleID" text,
  "ValidationText" text,
  "ValidationState" text
);

create table "vTenantTaxationRuleComponent" (
  "FakeID" integer,
  "RuleID" text,
  "ID" text,
  "Name" text,
  "Percent" numeric,
  "AccountCode" text,
  "Compound" boolean,
  "ComponentOrder" integer
);

create table "vWarrantySetup" (
  "ID" text,
  "Name" text
);

create table "vWorkCenter" (
  "WorkCenterID" text,
  "Code" text,
  "Name" text,
  "IsCoMan" boolean,
  "CoManProcurementType" text,
  "IsCoManPurchase" boolean
);

create table "vWorkCenters" (
  "WorkCenterID" text,
  "Code" text,
  "Name" text,
  "IsActive" boolean
);

create table "vXEROTaxTypes" (
  "Name" text,
  "TaxType" text
);
