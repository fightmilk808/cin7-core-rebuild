-- Reference books: one table per Cin7 Core data model, generated from data/models.json

create table "AccountingDimensionsWrapper" (
  "ID" text,
  "HasErrors" boolean
);

create table "AttachedFile" (
  "EmailID" text,  -- -> Email
  "AttachmentID" text,  -- -> Attachment
  "Send" boolean,
  "FileName" text,
  "ContentType" text,
  "BlobGUID" text  -- -> Blob (stored file)
);

create table "BOMProductList" (
  "ProductID" text,  -- -> Product
  "CodeWithName" text
);

create table "BalanceWrapper" (
  "HasErrors" boolean,
  "TenantID" text,  -- -> Tenant
  "HistoricalAccount" text,
  "Error" text,
  "OpeningBalancesDate" timestamptz
);

create table "BinGroup" (
  "ID" text,
  "Name" text,
  "LocationID" text  -- -> Location
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
  "ProductID" text,  -- -> Product
  "ProductName" text,
  "ProductCode" text,
  "CustomPrice" numeric,
  "ImageID" text,  -- -> Blob (stored file)
  "LatestPrice" numeric,
  "LatestDate" timestamptz,
  "ValidationState" text,
  "ValidationText" text
);

create table "DearToDearContactEmail" (
  "FakeID" text,
  "EmailID" text,  -- -> Email
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
  "EmailID" text,  -- -> Email
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
  "TaskID" text,  -- -> Task (any document)
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
  "LocationID" text  -- -> Location
);

create table "PriceTiers" (
  "Code" integer,
  "Name" text
);

create table "ProductMarkupPrices" (
  "ProductID" text,  -- -> Product
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
  "CurrentAttributeSetId" text,  -- -> AttributeSet
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
  "ContactID" text,  -- -> Contact
  "Name" text
);

create table "Recipients" (
  "Name" text,
  "Email" text,
  "IncludeInEmail" text,
  "SupplierCustomerID" text,  -- -> Customer
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
  "LocationID" text,  -- -> Location
  "LeadSafetyOptionID" text  -- -> LeadSafetyOption
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
  "LocationID" text,  -- -> Location
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
  "LocationID" text  -- -> Location
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
  "SIMProductID" text,  -- -> SIMProduct
  "AliasName" text,
  "ShopName" text,
  "ShopType" text,
  "ProductID" text,  -- -> Product
  "SKU" text,
  "ECSConfigID" text,  -- -> IntegrationConfig
  "ECSProductID" text,  -- -> ECSProduct
  "ECSVariantID" text,  -- -> ECSVariant
  "ECSDescription" text
);

create table "pProduct_AdditionalUnitsOfMeasure_SearchProduct" (
  "ProductID" text,  -- -> Product
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
  "AttributeID" text,  -- -> Attribute
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
  "ItemID" text,  -- -> Item (context-specific)
  "ComponentProductID" text,  -- -> ComponentProduct
  "ProductID" text,  -- -> Product
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
  "AccountID" text,  -- -> Account
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
  "ProductID" text,  -- -> Product
  "ProductCode" text,
  "Name" text,
  "Cost" numeric,
  "CostingMethod" text,
  "ImageID" text,  -- -> Blob (stored file)
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
  "ProductID" text,  -- -> Product
  "ProductCode" text,
  "Name" text,
  "Cost" numeric,
  "CostingMethod" text,
  "ImageID" text,  -- -> Blob (stored file)
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
  "ProductID" text,  -- -> Product
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
  "ItemID" text,  -- -> Item (context-specific)
  "ComponentProductID" text,  -- -> ComponentProduct
  "ProductID" text,  -- -> Product
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
  "LocationID" text,  -- -> Location
  "Description" text
);

create table "vBinData" (
  "LocationID" text,  -- -> Location
  "Name" text
);

create table "vBinDataBinGroups" (
  "LocationID" text,  -- -> Location
  "Name" text
);

create table "vBinGroup" (
  "ID" text,
  "Name" text
);

create table "vBinSimple" (
  "LocationID" text,  -- -> Location
  "Description" text,
  "BinGroupID" text  -- -> BinGroup
);

create table "vBomVersion" (
  "BomID" text,  -- -> ProductionBOM
  "Version" integer,
  "Name" text,
  "DisplayName" text,
  "IsDefault" boolean
);

create table "vBrand" (
  "BrandID" text,  -- -> Brand
  "Name" text
);

create table "vCategory" (
  "CategoryID" text,  -- -> ProductCategory
  "Name" text
);

create table "vCondition" (
  "ConditionID" text,  -- -> Condition
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
  "ProductID" text,  -- -> Product
  "CustomerID" text,  -- -> Customer
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
  "SupplierCustomerID" text,  -- -> Customer
  "Name" text,
  "SupplierID" text,  -- -> Supplier
  "SupplierName" text,
  "CustomerID" text,  -- -> Customer
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
  "SupplyIntervalID" text,  -- -> SupplyInterval
  "LocationID" text  -- -> Location
);

create table "vDiscountLine" (
  "FakeID" integer,
  "ID" text,
  "DiscountID" text,  -- -> Discount
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
  "DiscountID" text,  -- -> Discount
  "CustomerID" text,  -- -> Customer
  "ProductID" text,  -- -> Product
  "Customer" text,
  "DiscountName" text,
  "CustomerTag" text,
  "ValidationText" text,
  "ValidationState" text
);

create table "vDiscountMatrixCustomer" (
  "CustomerID" text,  -- -> Customer
  "Name" text
);

create table "vError" (
  "Message" text
);

create table "vExpenseItem" (
  "ExpenseItemID" text,  -- -> ExpenseItem
  "Description" text,
  "AccountCode" text
);

create table "vFamily" (
  "FamilyID" text,  -- -> ProductFamily
  "FamilyValue" text,
  "RMAReturnPolicyID" text  -- -> RMAReturnPolicy
);

create table "vIntegration" (
  "NetworkingKey" text,
  "LegalName" text,
  "FromMail" text
);

create table "vLeadStatus" (
  "StatusID" text,  -- -> Status
  "Name" text,
  "IsActive" boolean,
  "IsKanban" boolean,
  "Position" integer,
  "ValidationText" text,
  "ValidationState" text
);

create table "vLocation" (
  "LocationID" text,  -- -> Location
  "Description" text
);

create table "vLogisticsPath" (
  "PathID" text,  -- -> Path
  "WarehouseLocationID" text,  -- -> WarehouseLocation
  "ShopFloorLocationID" text,  -- -> ShopFloorLocation
  "RetailLocationID" text  -- -> RetailLocation
);

create table "vMakeToOrderBomConfiguration" (
  "BOMConfigurationID" text,  -- -> ProductionBOM
  "HasValidationErrors" boolean,
  "MenuConfigurationID" text,  -- -> MenuConfiguration
  "Name" text,
  "ProductID" text,  -- -> Product
  "TemplateID" text,  -- -> Template
  "TemplateName" text,
  "QuantityRelationsJSON" text,
  "QuantityConfigurationJSON" text,
  "ValidationState" text,
  "ValidationText" text,
  "IsExpanded" boolean
);

create table "vMakeToOrderBomImage" (
  "MenuConfigurationID" text,  -- -> MenuConfiguration
  "TemplateName" text,
  "OperationID" text,  -- -> Operation
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
  "BOMConfigurationID" text,  -- -> ProductionBOM
  "BOMProductMapID" text,  -- -> BOMProductMap
  "IsMain" boolean,
  "MappedProductCode" jsonb,
  "MappedProductID" jsonb,  -- -> MappedProduct
  "MappedProductName" jsonb,
  "MappedProductUnit" jsonb,
  "MenuConfigurationID" text,  -- -> MenuConfiguration
  "Name" text,
  "MenuConfigurationType" integer,
  "ProductID" text,  -- -> Product
  "Quantity" numeric,
  "Order" numeric
);

create table "vMakeToOrderConditionOperator" (
  "Value" text,
  "Name" text
);

create table "vMakeToOrderConfigMenuItem" (
  "Level" integer,
  "MenuConfigurationID" text,  -- -> MenuConfiguration
  "Name" text,
  "Type" integer
);

create table "vMakeToOrderConfigTemplate" (
  "IsDisabled" boolean,
  "TemplateID" text,  -- -> Template
  "TemplateName" text
);

create table "vMakeToOrderJoinCondition" (
  "Value" text,
  "Label" text
);

create table "vMakeToOrderMappedProduct" (
  "ProductCode" text,
  "ProductID" text,  -- -> Product
  "Name" text,
  "Unit" text
);

create table "vMakeToOrderMenuConfiguration" (
  "Description" text,
  "DetailedImageID" text,  -- -> DetailedImage
  "MenuConfigurationID" text,  -- -> MenuConfiguration
  "IsDefault" jsonb,
  "IsOpened" jsonb,
  "IsOptional" jsonb,
  "Name" text,
  "Order" integer,
  "ParentID" jsonb,  -- -> Parent
  "PriceDelta" numeric,
  "ProductFamilyID" jsonb,  -- -> ProductFamily
  "ProductFamilyName" jsonb,
  "ProductFamilyUnitOfMeasure" text,
  "ProductID" text,  -- -> Product
  "SketchImageID" text,  -- -> SketchImage
  "Type" integer,
  "IsCopy" boolean,
  "ValidationState" text,
  "ValidationText" text
);

create table "vMakeToOrderMenuConfigurationCondition" (
  "MenuConfigurationConditionID" text,  -- -> MenuConfigurationCondition
  "Condition" text,
  "IsHidden" boolean,
  "JoinCondition" text,
  "MenuConfigurationID" text,  -- -> MenuConfiguration
  "RelatedMenuConfigurationID" text,  -- -> RelatedMenuConfiguration
  "RelatedMenuConfigurationName" text,
  "ValidationState" text,
  "ValidationText" text
);

create table "vMakeToOrderQuantityMenuItem" (
  "BOMConfigurationID" text,  -- -> ProductionBOM
  "MenuConfigurationID" text,  -- -> MenuConfiguration
  "Name" text
);

create table "vMakeToOrderQuantityMenuItemOption" (
  "Level" integer,
  "MenuConfigurationID" text,  -- -> MenuConfiguration
  "Name" text
);

create table "vMakeToOrderTreeConfigItem" (
  "IsDisabled" boolean,
  "Level" integer,
  "MenuConfigurationID" text,  -- -> MenuConfiguration
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
  "RMACostTypeID" text,  -- -> RMACostType
  "RMACostTypeName" text,
  "ChargedTo" text,
  "RMAReturnPolicyID" text,  -- -> RMAReturnPolicy
  "ValidationState" text,
  "ValidationText" text
);

create table "vMissingExpenseAccountInBOM" (
  "ProductID" text,  -- -> Product
  "ProductCode" text,
  "Name" text
);

create table "vOpeningBalanceFixedAsset" (
  "ID" text,
  "TaskID" text,  -- -> Task (any document)
  "PurchaseOrderNumber" text,
  "AccountCode" text,
  "Amount" numeric
);

create table "vOpeningBalanceMultiCurrencyLine" (
  "ID" text,
  "TaskID" text,  -- -> Task (any document)
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
  "TaskID" text,  -- -> Task (any document)
  "TenantID" text,  -- -> Tenant
  "SupplierID" text,  -- -> Supplier
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
  "TaskID" text,  -- -> Task (any document)
  "TenantID" text,  -- -> Tenant
  "CustomerID" text,  -- -> Customer
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
  "TaskID" text,  -- -> Task (any document)
  "PurchaseOrderNumber" text,
  "AccountCode" text,
  "Amount" numeric
);

create table "vOpeningBalancesFixedAssetDetail" (
  "CardID" text,  -- -> InventoryCard
  "TaskID" text,  -- -> Task (any document)
  "Date" timestamptz,
  "PurchaseDate" timestamptz,
  "DepreciationStartDate" timestamptz,
  "Quantity" numeric,
  "UnitCost" numeric,
  "BatchSN" text,
  "Product" text,
  "ProductID" text,  -- -> Product
  "Location" text,
  "LocationID" text,  -- -> Location
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
  "CardID" text,  -- -> InventoryCard
  "TaskID" text,  -- -> Task (any document)
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
  "TenantID" text,  -- -> Tenant
  "OrderRoutingEnabled" boolean,
  "OrderRoutingKeepRouting" boolean,
  "ValidationText" text,
  "ValidationState" text
);

create table "vOrderRoutingSettings" (
  "ID" text,
  "LocationID" text,  -- -> Location
  "LocationName" text,
  "City" text,
  "State" text,
  "ZipPostCode" text,
  "Country" text,
  "TenantID" text,  -- -> Tenant
  "ValidationText" text,
  "ValidationState" text
);

create table "vPickZone" (
  "Value" text
);

create table "vProblematicProductCode" (
  "ProductID" text,  -- -> Product
  "ProductCode" text,
  "Name" text
);

create table "vProductAlternative" (
  "MainProductID" text,  -- -> Product
  "AlternativeProductID" text,  -- -> AlternativeProduct
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
  "ProductID" text,  -- -> Product
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
  "ImageID" text,  -- -> Blob (stored file)
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
  "AttributeSetID" text  -- -> AttributeSet
);

create table "vProductImage" (
  "ProductID" text,  -- -> Product
  "ImageID" text,  -- -> Blob (stored file)
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
  "ProductID" text,  -- -> Product
  "LocationID" text,  -- -> Location
  "LocationName" text,
  "SupplierID" text,  -- -> Supplier
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
  "ProductID" text,  -- -> Product
  "LocationID" text,  -- -> Location
  "LocationName" text,
  "SupplierID" text,  -- -> Supplier
  "SupplierName" text,
  "ReorderQuantity" numeric,
  "Lead" integer,
  "Safety" integer,
  "MinimumToReorder" numeric,
  "ValidationText" text,
  "ValidationState" text
);

create table "vProductList" (
  "ProductID" text,  -- -> Product
  "ProductCode" text,
  "Name" text,
  "DefaultUnitOfMeasure" text,
  "Type" text,
  "Category" text,
  "Brand" text,
  "LatestSupplier" text,
  "Status" text,
  "Selected" boolean,
  "ImageID" text,  -- -> Blob (stored file)
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
  "LocationID" text,  -- -> Location
  "ProductID" text,  -- -> Product
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
  "ProductID" text,  -- -> Product
  "MarkupType" text,
  "UsePriceType" text,
  "MarkupValue" numeric
);

create table "vProductMovement" (
  "CardDetailsID" text,  -- -> InventoryCard
  "ProductID" text,  -- -> Product
  "TaskID" text,  -- -> Task (any document)
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
  "CardDetailsID" text,  -- -> InventoryCard
  "ProductID" text,  -- -> Product
  "TaskID" text,  -- -> Task (any document)
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
  "ConfigID" text,  -- -> IntegrationConfig
  "ProductID" text,  -- -> Product
  "TaskID" text,  -- -> Task (any document)
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
  "BomID" text,  -- -> ProductionBOM
  "ProductID" text,  -- -> Product
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
  "AttachmentID" text,  -- -> Attachment
  "OperationID" text,  -- -> Operation
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
  "BomComponentID" text,  -- -> BomComponent
  "OperationID" text,  -- -> Operation
  "ProductID" text,  -- -> Product
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
  "BomID" text,  -- -> ProductionBOM
  "ProductID" text,  -- -> Product
  "Version" integer,
  "VersionName" text,
  "ProductCode" text,
  "Name" text,
  "Description" text,
  "IsMakeToOrderBom" boolean
);

create table "vProductionBomNote" (
  "NoteID" text,  -- -> Note
  "OperationID" text,  -- -> Operation
  "Note" text,
  "ValidationState" text,
  "ValidationText" text,
  "Position" integer
);

create table "vProductionBomOperation" (
  "OperationID" text,  -- -> Operation
  "BomID" text,  -- -> ProductionBOM
  "Order" integer,
  "Name" text,
  "CycleTime" integer,
  "CycleTimeString" text,
  "UnitsPerCycle" numeric,
  "WorkCenterID" text,  -- -> WorkCentre
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
  "OperationID" text,  -- -> Operation
  "RelatedOperationID" text,  -- -> RelatedOperation
  "RelationType" integer,
  "ValidationState" text,
  "ValidationText" text
);

create table "vProductionBomOperationProduct" (
  "ID" text,
  "OperationID" text,  -- -> Operation
  "ProductID" text,  -- -> Product
  "ProductName" text,
  "ProductSku" text,
  "Type" integer,
  "CostCalculationType" integer,
  "PriceTier" integer,
  "Ratio" numeric,
  "OutputQuantity" numeric,
  "AverageCost" numeric,
  "CostingMethod" text,
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
  "BomResourceID" text,  -- -> BomResource
  "OperationID" text,  -- -> Operation
  "ResourceID" text,  -- -> ProductionResource
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
  "TemplateID" text,  -- -> Template
  "OperationID" text,  -- -> Operation
  "Name" text,
  "Quantity" numeric,
  "ValidationState" text,
  "ValidationText" text,
  "Position" integer
);

create table "vProductionCalendar" (
  "CalendarID" text,  -- -> Calendar
  "Year" integer,
  "WeekStart" integer,
  "ValidationState" text,
  "ValidationText" text
);

create table "vProductionCalendarDay" (
  "DayID" text,  -- -> Day
  "CalendarID" text,  -- -> Calendar
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
  "DayID" text,  -- -> Day
  "CalendarID" text,  -- -> Calendar
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
  "ItemID" text,  -- -> Item (context-specific)
  "OperationID" text,  -- -> Operation
  "Type" text,
  "Value" text,
  "ResourceID" text,  -- -> ProductionResource
  "ResourceName" text,
  "ResourceCode" text,
  "Quantity" numeric,
  "ProductID" text,  -- -> Product
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
  "TemplateID" text,  -- -> Template
  "IsBackflush" boolean,
  "CostCalculationType" integer
);

create table "vProductionResources" (
  "ResourceID" text,  -- -> ProductionResource
  "Code" text,
  "Name" text,
  "ResourceCost" numeric,
  "CycleDuration" integer
);

create table "vProductsAdditionalUnitsOfMeasure" (
  "FakeID" integer,
  "ID" text,
  "ParentProductID" text,  -- -> Product
  "ProductID" text,  -- -> Product
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
  "ProductID" text,  -- -> Product
  "ProductCode" text,
  "BatchSN" text,
  "ExpiryDate" timestamptz,
  "Location" text,
  "Bin" text,
  "LocationID" text,  -- -> Location
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
  "TaskID" text,  -- -> Task (any document)
  "Number" text,
  "Type" text,
  "CustomerName" text,
  "Date" timestamptz,
  "Quantity" numeric
);

create table "vProductsStockInTransit" (
  "TaskID" text,  -- -> Task (any document)
  "Number" text,
  "SupplierName" text,
  "Date" timestamptz,
  "RequiredByDate" timestamptz,
  "Quantity" numeric,
  "Type" text,
  "NextDeliveryDate" timestamptz
);

create table "vProductsStockOnOrder" (
  "TaskID" text,  -- -> Task (any document)
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
  "SupplierID" text,  -- -> Supplier
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
  "RuleID" text  -- -> Rule (context-specific)
);

create table "vServiceUsage" (
  "ID" text,
  "ProductID" text,  -- -> Product
  "TaskID" text,  -- -> Task (any document)
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
  "DefaultReturnLocationID" text,  -- -> ReturnLocation
  "CreateCreditNoteType" text
);

create table "vShipZoneApplyTo" (
  "ID" text,
  "ZoneID" text,  -- -> Zone
  "Country2" text,
  "StateID" text,  -- -> State
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
  "SupplierProductID" text,  -- -> SupplierProduct
  "SupplierID" text,  -- -> Supplier
  "ProductID" text,  -- -> Product
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
  "LocationID" text,  -- -> Location
  "TakeStockQuantity" text,
  "FulfilDemandQuantity" text,
  "Capacity" numeric,
  "SupplierCondition" text,
  "RuleID" text,  -- -> Rule (context-specific)
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
  "AddressID" text,  -- -> Address
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
  "LocationID" text,  -- -> Location
  "Description" text
);

create table "vTenantShipZone" (
  "ZoneID" text,  -- -> Zone
  "Name" text,
  "IsRestZone" boolean,
  "ShortDesc" text,
  "PricesInclTax" boolean,
  "DefaultShippingCost" numeric,
  "Negative" boolean,
  "TaxRuleID" text,  -- -> TaxRule
  "ValidationText" text,
  "ValidationState" text
);

create table "vTenantTaxationRuleComponent" (
  "FakeID" integer,
  "RuleID" text,  -- -> Rule (context-specific)
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
  "WorkCenterID" text,  -- -> WorkCentre
  "Code" text,
  "Name" text,
  "IsCoMan" boolean,
  "CoManProcurementType" text,
  "IsCoManPurchase" boolean
);

create table "vWorkCenters" (
  "WorkCenterID" text,  -- -> WorkCentre
  "Code" text,
  "Name" text,
  "IsActive" boolean
);

create table "vXEROTaxTypes" (
  "Name" text,
  "TaxType" text
);
