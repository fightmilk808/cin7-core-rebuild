-- Inventory: one table per Cin7 Core data model, generated from data/models.json

create table "Account" (
  "Code" text,
  "DisplayName" text,
  "Class" text
);

create table "Attachment" (
  "TaskID" text,  -- -> Task (any document)
  "AttachmentID" text,  -- -> Attachment
  "BlobGUID" text,  -- -> Blob (stored file)
  "ContentType" text,
  "FileName" text,
  "Date" timestamptz,
  "UserName" text,
  "IsProcessed" boolean,
  "ExternalDownloadLink" text,
  "ExternalViewLink" text
);

create table "BOMProductList" (
  "ProductID" text,  -- -> Product
  "CodeWithName" text
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

create table "FamilyMatrix_Option" (
  "name" text,
  "index" integer,
  "values" text
);

create table "FamilyMatrix_ProductAvailability" (
  "ProductID" text,  -- -> Product
  "ProductCode" text,
  "Name" text,
  "UnitOfMeasure" text,
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
  "Available" numeric,
  "OnHand" numeric,
  "AverageCost" numeric,
  "CostingMethod" text,
  "RevenueAccount" text,
  "BatchSN" text,
  "ExpiryDate" timestamptz,
  "DropShipMode" text,
  "SaleTaxRule" text,
  "Account" text,
  "TaxRule" text,
  "TaxPercent" numeric,
  "ImageID" text,  -- -> Blob (stored file)
  "Type" text,
  "Option1" text,
  "Option2" text,
  "Option3" text,
  "AddQuantity" numeric
);

create table "FamilyMatrix_Value" (
  "name" text
);

create table "ManualJournal" (
  "FakeID" integer,
  "TaskID" text,  -- -> Task (any document)
  "ID" text,
  "Reference" text,
  "Amount" numeric,
  "Date" timestamptz,
  "Debit" text,
  "Credit" text,
  "ValidationText" text,
  "ValidationState" text
);

create table "ManualJournalDistributedCost" (
  "ID" text,
  "ManualJournalID" text,  -- -> ManualJournal
  "ProductID" text,  -- -> Product
  "ProductCode" text,
  "ProductName" text,
  "AccountCode" text,
  "DistributedCost" numeric,
  "Total" numeric,
  "ValidationText" text,
  "ValidationState" text
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

create table "Parent" (
  "TaskID" text,  -- -> Task (any document)
  "CreatedDate" timestamptz,
  "LastUpdatedDate" timestamptz,
  "StocktakeNumber" text,
  "Status" text,
  "Type" text,
  "LastUpdatedBy" text,
  "Location" text,
  "CustomerReference" text
);

create table "PickZones" (
  "Value" text,
  "LocationID" text  -- -> Location
);

create table "PriceTiers" (
  "Code" integer,
  "Name" text
);

create table "ProductFamilyWrapper" (
  "ID" integer,
  "LastSupplierName" text,
  "DropShipSupplierName" text,
  "HasErrors" boolean,
  "GenerateVariationBoms" boolean,
  "IsSupplierPriceNotUpdated" boolean
);

create table "ProductLocation" (
  "BatchSN" text,
  "ExpiryDate" timestamptz,
  "FakeKey" text,
  "Available" numeric,
  "CostingMethod" text,
  "OnHand" numeric,
  "LocationID" text,  -- -> Location
  "Location" text
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

create table "ProductOption" (
  "id" integer,
  "value" text
);

create table "ProductOrder" (
  "ProductID" text,  -- -> Product
  "ProductCode" text,
  "Name" text,
  "UnitOfMeasure" text,
  "Available" numeric,
  "OnHand" numeric,
  "CostingMethod" text,
  "UnitName" text,
  "ProductType" text
);

create table "ProductStatus" (
  "Value" text,
  "Name" text
);

create table "ProductWrapper" (
  "ID" integer,
  "HasErrors" boolean
);

create table "SearchProduct" (
  "FakeID" text,
  "LocationID" text,  -- -> Location
  "ProductID" text,  -- -> Product
  "ID" text,
  "QuantityOnHand" numeric,
  "Adjustment" numeric,
  "Name" text,
  "ProductCode" text,
  "Barcode" text,
  "CostingMethod" text,
  "BatchSN" text,
  "ExpiryDate" timestamptz,
  "AverageCost" numeric
);

create table "SearchResult" (
  "ProductID" text,  -- -> Product
  "LocationID" text,  -- -> Location
  "ID" text,
  "QuantityOnHand" numeric,
  "Adjustment" numeric,
  "Name" text,
  "ProductCode" text,
  "Barcode" text,
  "CostingMethod" text,
  "BatchSN" text,
  "ExpiryDate" timestamptz
);

create table "ServiceProduct" (
  "ProductID" text,  -- -> Product
  "Code" text,
  "Name" text
);

create table "StockAdjustmentWrapper" (
  "ID" integer,
  "HasErrors" boolean
);

create table "StockTransferOrderLineUploadError" (
  "ValidationState" text,
  "ValidationText" text,
  "Line" integer,
  "SKU" text,
  "SKUError" text,
  "Name" text,
  "NameError" text,
  "Quantity" text,
  "QuantityError" text,
  "Comments" text,
  "CommentsError" text
);

create table "StockTransferWrapper" (
  "ID" integer,
  "HasErrors" boolean,
  "PickRecommendationWarning" text
);

create table "StocktakeImportError" (
  "ValidationState" text,
  "ValidationText" text,
  "Line" integer,
  "ProductCode" text,
  "ProductCodeError" text,
  "ProductName" text,
  "ProductNameError" text,
  "Bin" text,
  "BinError" text,
  "Unit" text,
  "UnitError" text,
  "BatchSN" text,
  "BatchSNError" text,
  "ExpiryDate_YYYYMMDD" text,
  "ExpiryDate_YYYYMMDDError" text,
  "QuantityOnHand" text,
  "QuantityOnHandError" text,
  "StocktakeQuantity" text,
  "StocktakeQuantityError" text,
  "ReceivedDate_YYYYMMDD" text,
  "ReceivedDate_YYYYMMDDError" text
);

create table "StocktakeLineUploadError" (
  "ValidationState" text,
  "ValidationText" text,
  "Line" integer,
  "LineType" text,
  "LineTypeError" text,
  "Location" text,
  "LocationError" text,
  "SKU" text,
  "SKUError" text,
  "Name" text,
  "NameError" text,
  "Bin" text,
  "BinError" text,
  "BatchSerialNumber" text,
  "BatchSerialNumberError" text,
  "ExpiryDate_YYYYMMDD" text,
  "ExpiryDate_YYYYMMDDError" text,
  "Quantity" text,
  "QuantityError" text,
  "UnitCost" text,
  "UnitCostError" text,
  "Comments" text,
  "CommentsError" text,
  "ReceivedDate_YYYYMMDD" text,
  "ReceivedDate_YYYYMMDDError" text
);

create table "StocktakeWrapper" (
  "ID" integer,
  "HasErrors" boolean
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

create table "UsedInItem" (
  "FakeKey" integer,
  "ProductId" text,  -- -> Product
  "HasFamilyDerivedBom" boolean,
  "IsFamilyDerivedBomDefault" boolean,
  "IsMapped" boolean,
  "FamilyID" text  -- -> ProductFamily
);

create table "ZeroProduct" (
  "ProductID" text,  -- -> Product
  "ProductCode" text,
  "Name" text,
  "UnitOfMeasure" text,
  "CostingMethod" text,
  "Cost" numeric,
  "LocationID" text,  -- -> Location
  "Type" text
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

create table "pRecallCustomers" (
  "TaskID" text,  -- -> Task (any document)
  "Number" text,
  "TaskType" text,
  "ProductID" text,  -- -> Product
  "CustomerID" text,  -- -> Customer
  "Customer" text,
  "Phone" text,
  "Email" text,
  "ProductCode" text,
  "Name" text,
  "CustomerAddressLine1" text,
  "CustomerAddressLine2" text,
  "Quantity" numeric,
  "BatchSN" text,
  "ExpiryDate" timestamptz
);

create table "pRecallOnHand" (
  "ProductID" text,  -- -> Product
  "ProductCode" text,
  "Name" text,
  "BatchSN" text,
  "ExpiryDate" timestamptz,
  "Location" text,
  "OnHand" numeric,
  "Allocated" numeric,
  "InTransit" numeric,
  "InWIP" numeric
);

create table "pRecallSuppliers" (
  "TaskID" text,  -- -> Task (any document)
  "Number" text,
  "ProductID" text,  -- -> Product
  "SupplierID" text,  -- -> Supplier
  "Supplier" text,
  "Phone" text,
  "Email" text,
  "ProductCode" text,
  "Name" text,
  "Quantity" numeric,
  "BatchSN" text,
  "ExpiryDate" timestamptz
);

create table "pRecallUsedIn" (
  "TaskID" text,  -- -> Task (any document)
  "OrderNumber" text,
  "TaskType" text,
  "ProductID" text,  -- -> Product
  "ProductCode" text,
  "Name" text,
  "BatchSN" text,
  "ExpiryDate" timestamptz,
  "Unit" text,
  "Quantity" numeric
);

create table "vAccount" (
  "Code" text,
  "DisplayName" text
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

create table "vBillOfMaterialVariationProducts" (
  "ProductFamilyID" text,  -- -> ProductFamily
  "SKU" text,
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

create table "vBinGroup" (
  "ID" text,
  "Name" text
);

create table "vBomVersion" (
  "BomID" text,  -- -> ProductionBOM
  "Version" integer,
  "Name" text,
  "DisplayName" text,
  "IsDefault" boolean
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

create table "vGiftCardRecord" (
  "ID" text,
  "GiftCardCode" text,
  "InitialBalance" numeric,
  "CurrentBalance" numeric,
  "Date" timestamptz,
  "ExpirationDate" timestamptz,
  "TaskID" text,  -- -> Task (any document)
  "RefundID" text,  -- -> Refund
  "IsUsedInPayments" boolean,
  "SaleOrderNumber" text,
  "IsBreakeraged" boolean,
  "Currency" text,
  "SaleType" text,
  "Selected" boolean
);

create table "vInventoryAdjustment" (
  "FakeID" integer,
  "ID" text,
  "TaskID" text,  -- -> Task (any document)
  "ProductID" text,  -- -> Product
  "BatchSN" text,
  "ExpiryDate" timestamptz,
  "CostingMethod" text,
  "QuantityOnHand" numeric,
  "Adjustment" numeric,
  "Available" numeric,
  "LocationID" text,  -- -> Location
  "Name" text,
  "UnitOfMeasure" text,
  "ProductCode" text,
  "Comments" text,
  "ValidationText" text,
  "ValidationState" text
);

create table "vInventoryAdjustmentNew" (
  "FakeID" integer,
  "ID" text,
  "TaskID" text,  -- -> Task (any document)
  "ProductID" text,  -- -> Product
  "LocationID" text,  -- -> Location
  "BatchSN" text,
  "ExpiryDate" timestamptz,
  "CostingMethod" text,
  "Quantity" numeric,
  "UnitCost" numeric,
  "Available" numeric,
  "Name" text,
  "UnitOfMeasureName" text,
  "ProductCode" text,
  "Comments" text,
  "ReceivedDate" timestamptz,
  "ValidationText" text,
  "ValidationState" text,
  "ProductType" text
);

create table "vInventoryTask" (
  "TaskID" text,  -- -> Task (any document)
  "CreatedDate" timestamptz,
  "Type" text,
  "IncludeQuantityOnHand" boolean,
  "StocktakeNumber" text,
  "LastUpdatedDate" timestamptz,
  "LastUpdatedBy" text,
  "Status" text,
  "Account" text,
  "ValidationText" text,
  "ValidationState" text,
  "CustomerReference" text,
  "CostEstimationMethod" text,
  "Comment" text
);

create table "vLocationsWithBins" (
  "LocationID" text,  -- -> Location
  "Description" text
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

create table "vMissingExpenseAccountInBOM" (
  "ProductID" text,  -- -> Product
  "ProductCode" text,
  "Name" text
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

create table "vProductAttribute" (
  "ProductCode" text,
  "Name" text,
  "CustomField1" jsonb,
  "CustomField2" jsonb,
  "CustomField3" jsonb,
  "CustomField4" jsonb,
  "CustomField5" jsonb,
  "CustomField6" jsonb,
  "CustomField7" jsonb,
  "CustomField8" jsonb,
  "CustomField9" jsonb,
  "CustomField10" jsonb
);

create table "vProductBrand" (
  "ID" text,
  "Brand" text
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

create table "vProductFamilyImage" (
  "FamilyID" text,  -- -> ProductFamily
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

create table "vProductFamilyList" (
  "ID" text,
  "Name" text,
  "SKU" text,
  "Category" text,
  "Brand" text,
  "ProductCount" integer,
  "ImageID" text  -- -> Blob (stored file)
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

create table "vProductionBomVariationComponent" (
  "BomVariationComponentID" text,  -- -> BomVariationComponent
  "OperationID" text,  -- -> Operation
  "ProductFamilyID" text,  -- -> ProductFamily
  "ProductFamilyName" text,
  "ProductFamilySku" text,
  "Quantity" numeric,
  "QuantityOptionName" text,
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
  "QuantitySettingsJSON" text,
  "MapVariationsJSON" text,
  "IsMapVariationComplete" boolean,
  "NotMappedProducts" text,
  "AverageCost" numeric,
  "MinTotalCost" numeric,
  "MaxTotalCost" numeric
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

create table "vSaleGiftCardAllocation" (
  "ID" text,
  "TaskID" text,  -- -> Task (any document)
  "DocNumber" text,
  "InvoiceNumber" text,
  "SaleType" text,
  "DatePaid" timestamptz,
  "Currency" text,
  "Amount" numeric
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

create table "vStockLocator" (
  "Value" text
);

create table "vStockTransferDetail" (
  "FakeID" integer,
  "ID" text,
  "TaskID" text,  -- -> Task (any document)
  "ProductID" text,  -- -> Product
  "QuantityOnHand" numeric,
  "QuantityAvailable" numeric,
  "TransferQuantity" numeric,
  "Name" text,
  "UnitOfMeasure" text,
  "UnitName" text,
  "ProductCode" text,
  "Comments" text,
  "CostingMethod" text,
  "BatchSN" text,
  "ExpiryDate" timestamptz,
  "LocationID" text,  -- -> Location
  "Location" text,
  "NonInventory" boolean,
  "ValidationText" text,
  "ValidationState" text
);

create table "vStockTransferExciseTaxLine" (
  "FakeID" integer,
  "LineID" text,  -- -> Line (parent document's line)
  "TaskID" text,  -- -> Task (any document)
  "ProductID" text,  -- -> Product
  "Quantity" numeric,
  "ExciseTax" numeric,
  "Name" text,
  "ProductCode" text,
  "ValidationText" text,
  "ValidationState" text
);

create table "vStockTransferOrderLine" (
  "FakeID" integer,
  "ID" text,
  "TaskID" text,  -- -> Task (any document)
  "ProductID" text,  -- -> Product
  "Quantity" numeric,
  "AvailableQuantity" numeric,
  "OnHandQuantity" numeric,
  "Name" text,
  "UnitOfMeasure" text,
  "UnitName" text,
  "ProductCode" text,
  "Comments" text,
  "CostingMethod" text,
  "NonInventory" boolean,
  "ValidationText" text,
  "ValidationState" text
);

create table "vStockTransferPutAwayLine" (
  "FakeID" integer,
  "ID" text,
  "TaskID" text,  -- -> Task (any document)
  "ProductID" text,  -- -> Product
  "Name" text,
  "UnitOfMeasure" text,
  "UnitName" text,
  "ProductCode" text,
  "CostingMethod" text,
  "BatchSN" text,
  "ExpiryDate" timestamptz,
  "LocationID" text,  -- -> Location
  "Location" text,
  "ReceivedQuantity" numeric,
  "NonInventory" boolean,
  "ValidationText" text,
  "ValidationState" text
);

create table "vStockTransferTask" (
  "TaskID" text,  -- -> Task (any document)
  "CreatedDate" timestamptz,
  "From" text,
  "FromLocation" text,
  "To" text,
  "ToLocation" text,
  "ToLocationIsBin" boolean,
  "LastUpdatedBy" text,
  "Status" text,
  "Number" text,
  "CompletionDate" timestamptz,
  "DepartureDate" timestamptz,
  "InTransitAccount" text,
  "CostDistributionType" text,
  "CountrySpecificKey" text,
  "CountrySpecificData" text,
  "ValidationText" text,
  "ValidationState" text,
  "CustomerReference" text,
  "SkipOrder" boolean,
  "OrderStatus" text,
  "RequiredByDate" timestamptz,
  "UsePutAway" boolean,
  "IsCoMan" boolean,
  "HasMultipleShipments" boolean,
  "InboundShipmentID" text,  -- -> InboundShipment
  "ECSConfigID" text,  -- -> IntegrationConfig
  "LinkedProductionOrderID" text,  -- -> ProductionOrder
  "Comment" text
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

create table "vTenantCategory" (
  "ID" text,
  "Name" text
);

create table "vTenantLocationBin" (
  "ID" text,
  "Name" text,
  "BinGroupID" text  -- -> BinGroup
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
