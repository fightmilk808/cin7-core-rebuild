# Inventory

The product master (products, services, fixed assets, families/variants), stock availability per location and bin, stock adjustments, stocktakes, stock transfers, batch recall, price lists and gift cards. MRP is its own module: [`16-mrp`](../16-mrp/README.md).

| | Count |
|---|---:|
| Pages | 15 |
| Data models | 127 (plus [shared](../00-shared/README.md)) |
| Internal endpoints | 215 (84 write) |
| Public API operations | 33 |

## How to rebuild it

1. **Schema.** Create one table per data model below (127), starting from the generated [`schema.sql`](schema.sql). Ids are GUIDs; join on the `*ID` fields.
2. **Internal API.** Implement each controller's endpoints with the verbs listed, following the [internal API contract](../../docs/INTERNAL-API.md): one URL per store for GET/POST/PUT/DELETE, paged reads returning `{root, total}`, saves wrapped as `{ID, HasErrors, Original, Updated}`.
3. **Screens.** Build each route below as a server-rendered shell that loads the shell bundle and the page's own app, opening a record from `#<guid>` once at load ([page model](../../docs/ARCHITECTURE.md#what-a-page-is)). Every grid, column, field, button and dialog is in [UI.md](UI.md).
4. **Public API.** Expose the 33 operations below under `/ExternalApi/v2` with header auth ([public API contract](../../docs/PUBLIC-API.md)).

## Pages

| Route | Menu label | Title | Bundle | Endpoints (write) |
|---|---|---|---|---:|
| `/GiftCards` | Gift cards | Gift cards | `GiftCards2019` | 2 (1) |
| `/PriceList` | Print the products price list | Price list | `PriceList2019` | 4 (0) |
| `/Product` | Product/Service/Asset | Products | `MultilingualSupport2019 Customization2019 FixedAssetType2019 Product2019` | 77 (50) |
| `/ProductFamily` | Product family | Product family | `ProductFamily2019` | 29 (14) |
| `/ProductFamilyList` | Product families | Product families | `ProductFamilyList2019` | 2 (1) |
| `/Recall` | Batch/lot recall | Batch/lot recall | `RecallReport2019` | 6 (0) |
| `/Stock` | Availability | Product availability | `Stock2019` | 8 (2) |
| `/StockAdjustment` | Stock adjustment | Stock adjustment | `StockAdjustment2019` | 14 (7) |
| `/StockAdjustmentList` | Stocktake/adjustments | Stock adjustments and stocktakes | `StockAdjustmentList2019` | 1 (0) |
| `/StockTake` | Stocktake (redirects to /Stocktake/New) | Stocktake/adjustments | `Stocktake2019` | 21 (10) |
| `/StockTransfer` | Transfer | Stock transfer | `StockTransfer2019` | 20 (9) |
| `/StockTransferList` | Transfers (alias) | Stock transfers | `StocktransferList2019` | 0 (0) |
| `/Stocktake/New` | Stocktake | Stocktake/adjustments | `Stocktake2019` | 21 (10) |
| `/Stocktransfer` | Transfer (alias) | Stock transfer | `StockTransfer2019` | 20 (9) |
| `/StocktransferList` | Transfers | Stock transfers | `StocktransferList2019` | 0 (0) |

## Data models

ExtJS models the pages use; `v` prefix = view-model. Full DDL in [`schema.sql`](schema.sql).

| Model | Fields |
|---|---|
| `Account` | Code:string, DisplayName:string, Class:string |
| `Attachment` | TaskID:string, AttachmentID:string, BlobGUID:string, ContentType:string, FileName:string, Date:date, UserName:string, IsProcessed:bool, ExternalDownloadLink:string, ExternalViewLink:string |
| `BOMProductList` | ProductID:string, CodeWithName:string |
| `CostTypeModel` |  |
| `CustomPriceLine` | ProductID:string, ProductName:string, ProductCode:string, CustomPrice:float, ImageID:string, LatestPrice:float, LatestDate:date, ValidationState:string, ValidationText:string |
| `ExceptionsList` | Line:int, SupplierName:string, SupplierNameError:string, SupplierReference:string, SupplierReferenceError:string, InvoiceDate:string, InvoiceDateError:string, Amount:string, AmountError:string, CurrencyConversionRate:string, CurrencyConversionRateError:string, ValidationText:string, ValidationState:string |
| `FamilyMatrix_Option` | name:string, index:int, values:string |
| `FamilyMatrix_ProductAvailability` | ProductID:string, ProductCode:string, Name:string, UnitOfMeasure:string, PriceTear1:float, PriceTear2:float, PriceTear3:float, PriceTear4:float, PriceTear5:float, PriceTear6:float, PriceTear7:float, PriceTear8:float, PriceTear9:float, PriceTear10:float, Available:float, OnHand:float, AverageCost:float, CostingMethod:string, RevenueAccount:string, BatchSN:string, ExpiryDate:date, DropShipMode:string, SaleTaxRule:string, Account:string, TaxRule:string, TaxPercent:float, ImageID:string, Type:string, Option1:string, Option2:string, Option3:string, AddQuantity:float |
| `FamilyMatrix_Value` | name:string |
| `ManualJournal` | FakeID:int, TaskID:string, ID:string, Reference:string, Amount:float, Date:date, Debit:string, Credit:string, ValidationText:string, ValidationState:string |
| `ManualJournalDistributedCost` | ID:string, ManualJournalID:string, ProductID:string, ProductCode:string, ProductName:string, AccountCode:string, DistributedCost:float, Total:float, ValidationText:string, ValidationState:string |
| `MarkupLine` | TierNumber:int, Price:float, CalculatedPrice:float, Calculated:boolean, MarkupType:string, UsePriceType:string, MarkupValue:float, ValidationState:string, ValidationText:string |
| `MarkupType` | Value:string, Name:string |
| `MeasurementUnit` | UoMAbbr:string, UoMName:string, IsFirst:bool, MeasurementSystem:string |
| `MovementTypeModel` | name:string, value:string |
| `Parent` | TaskID:string, CreatedDate:date, LastUpdatedDate:date, StocktakeNumber:string, Status:string, Type:string, LastUpdatedBy:string, Location:string, CustomerReference:string |
| `PickZones` | Value:string, LocationID:string |
| `PriceTiers` | Code:int, Name:string |
| `ProductFamilyWrapper` | ID:int, LastSupplierName:string, DropShipSupplierName:string, HasErrors:bool, GenerateVariationBoms:bool, IsSupplierPriceNotUpdated:bool |
| `ProductLocation` | BatchSN:string, ExpiryDate:date, FakeKey:string, Available:float, CostingMethod:string, OnHand:float, LocationID:string, Location:string |
| `ProductMarkupPrices` | ProductID:string, PriceTier1:float, PriceTier2:float, PriceTier3:float, PriceTier4:float, PriceTier5:float, PriceTier6:float, PriceTier7:float, PriceTier8:float, PriceTier9:float, PriceTier10:float, AvgPriceUsed1:string, AvgPriceUsed2:string, AvgPriceUsed3:string, AvgPriceUsed4:string, AvgPriceUsed5:string, AvgPriceUsed6:string, AvgPriceUsed7:string, AvgPriceUsed8:string, AvgPriceUsed9:string, AvgPriceUsed10:string |
| `ProductOption` | id:int, value:string |
| `ProductOrder` | ProductID:string, ProductCode:string, Name:string, UnitOfMeasure:string, Available:float, OnHand:float, CostingMethod:string, UnitName:string, ProductType:string |
| `ProductStatus` | Value:string, Name:string |
| `ProductWrapper` | ID:int, HasErrors:bool |
| `SearchProduct` | FakeID:string, LocationID:string, ProductID:string, ID:string, QuantityOnHand:float, Adjustment:float, Name:string, ProductCode:string, Barcode:string, CostingMethod:string, BatchSN:string, ExpiryDate:date, AverageCost:float |
| `SearchResult` | ProductID:string, LocationID:string, ID:string, QuantityOnHand:float, Adjustment:float, Name:string, ProductCode:string, Barcode:string, CostingMethod:string, BatchSN:string, ExpiryDate:date |
| `ServiceProduct` | ProductID:string, Code:string, Name:string |
| `StockAdjustmentWrapper` | ID:int, HasErrors:bool |
| `StockTransferOrderLineUploadError` | ValidationState:string, ValidationText:string, Line:int, SKU:string, SKUError:string, Name:string, NameError:string, Quantity:string, QuantityError:string, Comments:string, CommentsError:string |
| `StockTransferWrapper` | ID:int, HasErrors:bool, PickRecommendationWarning:string |
| `StocktakeImportError` | ValidationState:string, ValidationText:string, Line:int, ProductCode:string, ProductCodeError:string, ProductName:string, ProductNameError:string, Bin:string, BinError:string, Unit:string, UnitError:string, BatchSN:string, BatchSNError:string, ExpiryDate_YYYYMMDD:string, ExpiryDate_YYYYMMDDError:string, QuantityOnHand:string, QuantityOnHandError:string, StocktakeQuantity:string, StocktakeQuantityError:string, ReceivedDate_YYYYMMDD:string, ReceivedDate_YYYYMMDDError:string |
| `StocktakeLineUploadError` | ValidationState:string, ValidationText:string, Line:int, LineType:string, LineTypeError:string, Location:string, LocationError:string, SKU:string, SKUError:string, Name:string, NameError:string, Bin:string, BinError:string, BatchSerialNumber:string, BatchSerialNumberError:string, ExpiryDate_YYYYMMDD:string, ExpiryDate_YYYYMMDDError:string, Quantity:string, QuantityError:string, UnitCost:string, UnitCostError:string, Comments:string, CommentsError:string, ReceivedDate_YYYYMMDD:string, ReceivedDate_YYYYMMDDError:string |
| `StocktakeWrapper` | ID:int, HasErrors:bool |
| `SupplyInterval` | ID:string, DeliveryMethod:string, IntervalStartDate:date, IsMonday:bool, IsTuesday:bool, IsWednesday:bool, IsThursday:bool, IsFriday:bool, IsSaturday:bool, IsSunday:bool, LocationID:string, LeadSafetyOptionID:string |
| `UsedInItem` | FakeKey:int, ProductId:string, HasFamilyDerivedBom:bool, IsFamilyDerivedBomDefault:bool, IsMapped:bool, FamilyID:string |
| `ZeroProduct` | ProductID:string, ProductCode:string, Name:string, UnitOfMeasure:string, CostingMethod:string, Cost:float, LocationID:string, Type:string |
| `pProductAdditionalDescriptions` | SIMProductID:string, AliasName:string, ShopName:string, ShopType:string, ProductID:string, SKU:string, ECSConfigID:string, ECSProductID:string, ECSVariantID:string, ECSDescription:string |
| `pProduct_AdditionalUnitsOfMeasure_SearchProduct` | ProductID:string, Name:string, Code:string, Unit:string, PriceTear1:float, PriceTear2:float, PriceTear3:float, PriceTear4:float, PriceTear5:float, PriceTear6:float, PriceTear7:float, PriceTear8:float, PriceTear9:float, PriceTear10:float |
| `pRecallCustomers` | TaskID:string, Number:string, TaskType:string, ProductID:string, CustomerID:string, Customer:string, Phone:string, Email:string, ProductCode:string, Name:string, CustomerAddressLine1:string, CustomerAddressLine2:string, Quantity:float, BatchSN:string, ExpiryDate:date |
| `pRecallOnHand` | ProductID:string, ProductCode:string, Name:string, BatchSN:string, ExpiryDate:date, Location:string, OnHand:float, Allocated:float, InTransit:float, InWIP:float |
| `pRecallSuppliers` | TaskID:string, Number:string, ProductID:string, SupplierID:string, Supplier:string, Phone:string, Email:string, ProductCode:string, Name:string, Quantity:float, BatchSN:string, ExpiryDate:date |
| `pRecallUsedIn` | TaskID:string, OrderNumber:string, TaskType:string, ProductID:string, ProductCode:string, Name:string, BatchSN:string, ExpiryDate:date, Unit:string, Quantity:float |
| `vAccount` | Code:string, DisplayName:string |
| `vBOMServices` | FakeID:int, ItemID:string, ComponentProductID:string, ProductID:string, Name:string, Quantity:float, Cost:float, PriceTier:float, PriceTier1:float, PriceTier2:float, PriceTier3:float, PriceTier4:float, PriceTier5:float, PriceTier6:float, PriceTier7:float, PriceTier8:float, PriceTier9:float, PriceTier10:float, ExpenseAccount:string, ValidationText:string, ValidationState:string |
| `vBillOfMaterialFinishedProducts` | ProductID:string, ProductCode:string, Name:string, Cost:float, CostingMethod:string, ImageID:string, Unit:string, PriceTier1:float, PriceTier2:float, PriceTier3:float, PriceTier4:float, PriceTier5:float, PriceTier6:float, PriceTier7:float, PriceTier8:float, PriceTier9:float, PriceTier10:float |
| `vBillOfMaterialProducts` | ProductID:string, ProductCode:string, Name:string, Cost:float, CostingMethod:string, ImageID:string, Unit:string, PriceTier1:float, PriceTier2:float, PriceTier3:float, PriceTier4:float, PriceTier5:float, PriceTier6:float, PriceTier7:float, PriceTier8:float, PriceTier9:float, PriceTier10:float |
| `vBillOfMaterialServices` | ProductID:string, Name:string, PriceTear1:float, PriceTear2:float, PriceTear3:float, PriceTear4:float, PriceTear5:float, PriceTear6:float, PriceTear7:float, PriceTear8:float, PriceTear9:float, PriceTear10:float, ExpenseAccount:string |
| `vBillOfMaterialVariationProducts` | ProductFamilyID:string, SKU:string, Name:string, Cost:float, CostingMethod:string, ImageID:string, Unit:string, PriceTier1:float, PriceTier2:float, PriceTier3:float, PriceTier4:float, PriceTier5:float, PriceTier6:float, PriceTier7:float, PriceTier8:float, PriceTier9:float, PriceTier10:float |
| `vBillOfMaterials` | FakeID:int, ItemID:string, ComponentProductID:string, ProductID:string, ProductCode:string, Name:string, Quantity:float, WastagePercent:float, WastageQuantity:float, CostPercentage:float, Cost:float, TotalCost:float, CostingMethod:string, ValidationText:string, ValidationState:string |
| `vBinGroup` | ID:string, Name:string |
| `vBomVersion` | BomID:string, Version:int, Name:string, DisplayName:string, IsDefault:boolean |
| `vCountryOfOrigin` | Code:string, Name:string |
| `vCustomPrice` | ProductID:string, CustomerID:string, Price:float, IsDeleted:bool |
| `vDiscountMatrix` | FakeID:int, ID:string, DiscountID:string, CustomerID:string, ProductID:string, Customer:string, DiscountName:string, CustomerTag:string, ValidationText:string, ValidationState:string |
| `vDiscountMatrixCustomer` | CustomerID:string, Name:string |
| `vGiftCardRecord` | ID:string, GiftCardCode:string, InitialBalance:float, CurrentBalance:float, Date:date, ExpirationDate:date, TaskID:string, RefundID:string, IsUsedInPayments:bool, SaleOrderNumber:string, IsBreakeraged:bool, Currency:string, SaleType:string, Selected:bool |
| `vInventoryAdjustment` | FakeID:int, ID:string, TaskID:string, ProductID:string, BatchSN:string, ExpiryDate:date, CostingMethod:string, QuantityOnHand:float, Adjustment:float, Available:float, LocationID:string, Name:string, UnitOfMeasure:string, ProductCode:string, Comments:string, ValidationText:string, ValidationState:string |
| `vInventoryAdjustmentNew` | FakeID:int, ID:string, TaskID:string, ProductID:string, LocationID:string, BatchSN:string, ExpiryDate:date, CostingMethod:string, Quantity:float, UnitCost:float, Available:float, Name:string, UnitOfMeasureName:string, ProductCode:string, Comments:string, ReceivedDate:date, ValidationText:string, ValidationState:string, ProductType:string |
| `vInventoryTask` | TaskID:string, CreatedDate:date, Type:string, IncludeQuantityOnHand:bool, StocktakeNumber:string, LastUpdatedDate:date, LastUpdatedBy:string, Status:string, Account:string, ValidationText:string, ValidationState:string, CustomerReference:string, CostEstimationMethod:string, Comment:string |
| `vLocationsWithBins` | LocationID:string, Description:string |
| `vMakeToOrderBomConfiguration` | BOMConfigurationID:string, HasValidationErrors:bool, MenuConfigurationID:string, Name:string, ProductID:string, TemplateID:string, TemplateName:string, QuantityRelationsJSON:string, QuantityConfigurationJSON:string, ValidationState:string, ValidationText:string, IsExpanded:bool |
| `vMakeToOrderBomImage` | MenuConfigurationID:string, TemplateName:string, OperationID:string, OriginalDetailedImageUrl:string, OriginalSketchUrl:string, UpdatedDetailedImageUrl:string, UpdatedSketchUrl:string |
| `vMakeToOrderBomProductFamily` | ID:string, Name:string, Unit:string |
| `vMakeToOrderBomProductMap` | BOMConfigurationID:string, BOMProductMapID:string, IsMain:bool, MappedProductCode:auto, MappedProductID:auto, MappedProductName:auto, MappedProductUnit:auto, MenuConfigurationID:string, Name:string, MenuConfigurationType:int, ProductID:string, Quantity:number, Order:number |
| `vMakeToOrderConditionOperator` | Value:string, Name:string |
| `vMakeToOrderConfigMenuItem` | Level:int, MenuConfigurationID:string, Name:string, Type:int |
| `vMakeToOrderConfigTemplate` | IsDisabled:bool, TemplateID:string, TemplateName:string |
| `vMakeToOrderJoinCondition` | Value:string, Label:string |
| `vMakeToOrderMappedProduct` | ProductCode:string, ProductID:string, Name:string, Unit:string |
| `vMakeToOrderMenuConfiguration` | Description:string, DetailedImageID:string, MenuConfigurationID:string, IsDefault:auto, IsOpened:auto, IsOptional:auto, Name:string, Order:int, ParentID:auto, PriceDelta:decimal, ProductFamilyID:auto, ProductFamilyName:auto, ProductFamilyUnitOfMeasure:string, ProductID:string, SketchImageID:string, Type:int, IsCopy:bool, ValidationState:string, ValidationText:string |
| `vMakeToOrderMenuConfigurationCondition` | MenuConfigurationConditionID:string, Condition:string, IsHidden:bool, JoinCondition:string, MenuConfigurationID:string, RelatedMenuConfigurationID:string, RelatedMenuConfigurationName:string, ValidationState:string, ValidationText:string |
| `vMakeToOrderQuantityMenuItem` | BOMConfigurationID:string, MenuConfigurationID:string, Name:string |
| `vMakeToOrderQuantityMenuItemOption` | Level:int, MenuConfigurationID:string, Name:string |
| `vMakeToOrderTreeConfigItem` | IsDisabled:bool, Level:int, MenuConfigurationID:string, Name:string |
| `vMakeToOrderVisibilityOption` | Value:string, Label:string |
| `vMissingExpenseAccountInBOM` | ProductID:string, ProductCode:string, Name:string |
| `vPickZone` | Value:string |
| `vProblematicProductCode` | ProductID:string, ProductCode:string, Name:string |
| `vProductAlternative` | MainProductID:string, AlternativeProductID:string, AlternativeProductCode:string, AlternativeProductName:string, Matching:float, UseInProduction:bool, IsInterchangeable:bool, Quantity:float, ValidationText:string, ValidationState:string |
| `vProductAlternativeAdd` | ProductID:string, ProductCode:string, Name:string |
| `vProductAttribute` | ProductCode:string, Name:string, CustomField1:auto, CustomField2:auto, CustomField3:auto, CustomField4:auto, CustomField5:auto, CustomField6:auto, CustomField7:auto, CustomField8:auto, CustomField9:auto, CustomField10:auto |
| `vProductBrand` | ID:string, Brand:string |
| `vProductCombinedList` | ID:string, ProductCode:string, Name:string, DefaultUnitOfMeasure:string, Type:string, Category:string, Brand:string, LatestSupplier:string, Status:string, Selected:bool, ImageID:string, CustomField1:string, CustomField2:string, CustomField3:string, CustomField4:string, CustomField5:string, CustomField6:string, CustomField7:string, CustomField8:string, CustomField9:string, CustomField10:string, NotSellable:string, RowType:int, CountVariants:int, Barcode:string, BomType:string, AttributeSetID:string |
| `vProductFamilyImage` | FamilyID:string, ImageID:string, ContentType:string, FileName:string, Uri:string, isDefault:bool, IsImage:bool, ExternalDownloadLink:string, ExternalViewLink:string, RowOrderNum:int |
| `vProductFamilyList` | ID:string, Name:string, SKU:string, Category:string, Brand:string, ProductCount:int, ImageID:string |
| `vProductImage` | ProductID:string, ImageID:string, ContentType:string, FileName:string, Uri:string, isDefault:bool, IsImage:bool, ExternalDownloadLink:string, ExternalViewLink:string, RowOrderNum:int |
| `vProductLeadSafetyOptionDisplay` | FakeID:int, ID:string, ProductID:string, LocationID:string, LocationName:string, SupplierID:string, SupplierName:string, ReorderQuantity:float, Lead:int, Safety:int, MinimumToReorder:float, ReorderQuantityLocation:float, LeadLocation:int, SafetyLocation:int, OnlyLocationRow:bool, ValidationText:string, ValidationState:string |
| `vProductLeadSafetyOptions` | FakeID:int, ID:string, ProductID:string, LocationID:string, LocationName:string, SupplierID:string, SupplierName:string, ReorderQuantity:float, Lead:int, Safety:int, MinimumToReorder:float, ValidationText:string, ValidationState:string |
| `vProductList` | ProductID:string, ProductCode:string, Name:string, DefaultUnitOfMeasure:string, Type:string, Category:string, Brand:string, LatestSupplier:string, Status:string, Selected:bool, ImageID:string, CustomField1:string, CustomField2:string, CustomField3:string, CustomField4:string, CustomField5:string, CustomField6:string, CustomField7:string, CustomField8:string, CustomField9:string, CustomField10:string, NotSellable:string |
| `vProductLocation` | FakeID:int, ID:string, LocationID:string, ProductID:string, MinimumBeforeReorder:float, ReorderQuantity:float, LocationName:string, StockLocator:string, PickZones:string, ValidationText:string, ValidationState:string |
| `vProductMarkups` | TierNumber:int, ProductID:string, MarkupType:string, UsePriceType:string, MarkupValue:float |
| `vProductMovement` | CardDetailsID:string, ProductID:string, TaskID:string, Type:string, Number:string, Status:string, Date:date, Quantity:float, Amount:float, Location:string, BatchSN:string, ExpiryDate:date, FromTo:string |
| `vProductMovementQuantity` | CardDetailsID:string, ProductID:string, TaskID:string, Type:string, Number:string, Status:string, Date:date, Quantity:float, Location:string, BatchSN:string, ExpiryDate:date, FromTo:string |
| `vProductQuantityChanges` | ConfigID:string, ProductID:string, TaskID:string, ChangeDate:date, Action:string, Reference:string, ReferenceName:string, Location:string, QtyMoved:string, Available:string, Status:string, UserName:string |
| `vProductionBom` | BomID:string, ProductID:string, OutputQuantity:float, BufferPercent:float, InstructionUrl:string, IssueMethod:int, IssueMethodComponent:int, IssueMethodParameter:int, IgnoreCumulativeLeadTime:boolean, ComponentProductionLeadTime:int, Version:int, Name:string, IsDefault:boolean, CreatedDate:date, CreatedBy:string, DeliveryTo:string, IsTracing:bool, MinQuantity:float, MaxQuantity:float, DeviationPercent:float, RunSize:float, ValidationState:string, ValidationText:string |
| `vProductionBomAttachment` | AttachmentID:string, OperationID:string, FileName:string, Date:date, ContentType:string, BlobGuid:string, IsCloned:bool, ValidationState:string, ValidationText:string, Position:int |
| `vProductionBomComponent` | BomComponentID:string, OperationID:string, ProductID:string, ProductName:string, ProductSku:string, Quantity:float, WastageQty:float, WastagePercent:float, Cost:float, CostingMethod:string, ValidationState:string, ValidationText:string, Position:int, Unit:string, SalePriceTier:int, PriceTier1:float, PriceTier2:float, PriceTier3:float, PriceTier4:float, PriceTier5:float, PriceTier6:float, PriceTier7:float, PriceTier8:float, PriceTier9:float, PriceTier10:float, IsBackflush:bool |
| `vProductionBomCopy` | BomID:string, ProductID:string, Version:int, VersionName:string, ProductID:string, ProductCode:string, Name:string, Description:string, IsMakeToOrderBom:bool |
| `vProductionBomNote` | NoteID:string, OperationID:string, Note:string, ValidationState:string, ValidationText:string, Position:int |
| `vProductionBomOperation` | OperationID:string, BomID:string, Order:int, Name:string, CycleTime:int, CycleTimeString:string, UnitsPerCycle:float, WorkCenterID:string, WorkCenterName:string, WorkCenterCoManProcurementType:string, WorkCenterCode:string, OperationType:int, TotalCost:float, OperationRelationIDsFake:auto, IsDropShip:bool, IsBackflush:bool, ValidationState:string, ValidationText:string |
| `vProductionBomOperationLink` | ID:string, OperationID:string, RelatedOperationID:string, RelationType:int, ValidationState:string, ValidationText:string |
| `vProductionBomOperationProduct` | ID:string, OperationID:string, ProductID:string, ProductName:string, ProductSku:string, Type:int, CostCalculationType:int, PriceTier:int, Ratio:float, OutputQuantity:float, AverageCost:float, CostingMethod:string, PriceTier:float, PriceTier1:float, PriceTier2:float, PriceTier3:float, PriceTier4:float, PriceTier5:float, PriceTier6:float, PriceTier7:float, PriceTier8:float, PriceTier9:float, PriceTier10:float, Position:int, Unit:string, Cost:float, TotalCost:float, Formula:string, WastageCost:int, DeliveryTo:string, ValidationState:string, ValidationText:string |
| `vProductionBomResource` | BomResourceID:string, OperationID:string, ResourceID:string, ResourceName:string, ResourceCode:string, Quantity:float, CycleTime:int, Cost:float, ValidationState:string, ValidationText:string, Position:int, CostCalculationType:int |
| `vProductionBomTemplate` | TemplateID:string, OperationID:string, Name:string, Quantity:float, ValidationState:string, ValidationText:string, Position:int |
| `vProductionBomVariationComponent` | BomVariationComponentID:string, OperationID:string, ProductFamilyID:string, ProductFamilyName:string, ProductFamilySku:string, Quantity:float, QuantityOptionName:string, WastageQty:float, WastagePercent:float, Cost:float, CostingMethod:string, ValidationState:string, ValidationText:string, Position:int, Unit:string, SalePriceTier:int, PriceTier1:float, PriceTier2:float, PriceTier3:float, PriceTier4:float, PriceTier5:float, PriceTier6:float, PriceTier7:float, PriceTier8:float, PriceTier9:float, PriceTier10:float, QuantitySettingsJSON:string, MapVariationsJSON:string, IsMapVariationComplete:boo… |
| `vProductionOperationItem` | ItemID:string, OperationID:string, Type:string, Value:string, ResourceID:string, ResourceName:string, ResourceCode:string, Quantity:float, ProductID:string, ProductName:string, ProductSku:string, WastageQty:float, WastagePercent:float, AttachmentFileName:string, AttachmentDate:date, AttachmentContentType:string, AttachmentBlobGuid:string, Note:string, Cost:float, CostingMethod:string, CycleTime:int, ValidationState:string, ValidationText:string, TotalCost:float, Position:int, Unit:string, WastageCost:int, SalePriceTier:int, PriceTier1:float, PriceTier2:float, PriceTier3:float, PriceTier4:floa… |
| `vProductionResources` | ResourceID:string, Code:string, Name:string, ResourceCost:float, CycleDuration:int |
| `vProductsAdditionalUnitsOfMeasure` | FakeID:int, ID:string, ParentProductID:string, ProductID:string, Name:string, ProductCode:string, DefaultUnitOfMeasure:string, ConversionRate:float, PriceTear1:float, PriceTear2:float, PriceTear3:float, PriceTear4:float, PriceTear5:float, PriceTear6:float, PriceTear7:float, PriceTear8:float, PriceTear9:float, PriceTear10:float, NotSellable:bool, ValidationText:string, ValidationState:string |
| `vProductsStock` | Name:string, ProductID:string, ProductCode:string, BatchSN:string, ExpiryDate:date, Location:string, Bin:string, LocationID:string, OnHand:float, OnHandVolume:float, Available:float, Allocated:float, OnOrder:float, StockOnHand:float, InTransit:float, Category:string, Brand:string, Unit:string, Family:string, StockLocator:string, Status:string, Selected:bool, NextDeliveryDate:date |
| `vProductsStockAllocated` | TaskID:string, Number:string, Type:string, CustomerName:string, Date:date, Quantity:float |
| `vProductsStockInTransit` | TaskID:string, Number:string, SupplierName:string, Date:date, RequiredByDate:date, Quantity:float, Type:string, NextDeliveryDate:date |
| `vProductsStockOnOrder` | TaskID:string, Number:string, SupplierName:string, Date:date, RequiredByDate:date, Quantity:float, Type:string, NextDeliveryDate:date |
| `vPublishingProfile` | Id:string, Name:string |
| `vSaleGiftCardAllocation` | ID:string, TaskID:string, DocNumber:string, InvoiceNumber:string, SaleType:string, DatePaid:date, Currency:string, Amount:float |
| `vServiceUsage` | ID:string, ProductID:string, TaskID:string, Type:string, Number:string, Status:string, Date:date, Price:float |
| `vStockLocator` | Value:string |
| `vStockTransferDetail` | FakeID:int, ID:string, TaskID:string, ProductID:string, QuantityOnHand:float, QuantityAvailable:float, TransferQuantity:float, Name:string, UnitOfMeasure:string, UnitName:string, ProductCode:string, Comments:string, CostingMethod:string, BatchSN:string, ExpiryDate:date, LocationID:string, Location:string, NonInventory:bool, ValidationText:string, ValidationState:string |
| `vStockTransferExciseTaxLine` | FakeID:int, LineID:string, TaskID:string, ProductID:string, Quantity:float, ExciseTax:float, Name:string, ProductCode:string, ValidationText:string, ValidationState:string |
| `vStockTransferOrderLine` | FakeID:int, ID:string, TaskID:string, ProductID:string, Quantity:float, AvailableQuantity:float, OnHandQuantity:float, Name:string, UnitOfMeasure:string, UnitName:string, ProductCode:string, Comments:string, CostingMethod:string, NonInventory:bool, ValidationText:string, ValidationState:string |
| `vStockTransferPutAwayLine` | FakeID:int, ID:string, TaskID:string, ProductID:string, Name:string, UnitOfMeasure:string, UnitName:string, ProductCode:string, CostingMethod:string, BatchSN:string, ExpiryDate:date, LocationID:string, Location:string, ReceivedQuantity:float, NonInventory:bool, ValidationText:string, ValidationState:string |
| `vStockTransferTask` | TaskID:string, CreatedDate:date, From:string, FromLocation:string, To:string, ToLocation:string, ToLocationIsBin:boolean, LastUpdatedBy:string, Status:string, Number:string, CompletionDate:date, DepartureDate:date, InTransitAccount:string, CostDistributionType:string, CountrySpecificKey:string, CountrySpecificData:string, ValidationText:string, ValidationState:string, CustomerReference:string, SkipOrder:bool, OrderStatus:string, RequiredByDate:date, UsePutAway:bool, IsCoMan:bool, HasMultipleShipments:bool, InboundShipmentID:string, ECSConfigID:string, LinkedProductionOrderID:string, Comment:s… |
| `vSupplierProduct` | FakeID:int, SupplierProductID:string, SupplierID:string, ProductID:string, SupplierName:string, Currency:string, SupplierInventoryCode:string, URL:string, Cost:float, FixedCost:float, SupplierProductName:string, SysDate:date, DropShip:bool, IncludeInPricing:bool, ValidationText:string, ValidationState:string |
| `vTenantCategory` | ID:string, Name:string |
| `vTenantLocationBin` | ID:string, Name:string, BinGroupID:string |
| `vWarrantySetup` | ID:string, Name:string |
| `vWorkCenter` | WorkCenterID:string, Code:string, Name:string, IsCoMan:boolean, CoManProcurementType:string, IsCoManPurchase:boolean |

## Internal endpoints

Grouped by controller. Effect: 🟢 read · 🟠 read + write at the same URL · 🔴 write. `api` = JSON under `/api/`, `mvc` = controller action.

### AccountingDimensions

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/AccountingDimensions_Index_RealDimensions` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |

### ChatGpt

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/ChatGpt_GetSettings` | api | GET | 🟢 read |  |  |  |
| `/api/ChatGpt_ProductDescription` | api | POST | 🟢 read | requestContent |  |  |

### CustomerList

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/CustomerList/ImportCustomPricesJson` | mvc | POST | 🔴 write |  |  |  |
| `/api/CustomerList_ImportCustomPrices_Exceptions` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |

### DefaultFieldValues

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/DefaultFieldValues` | api | GET POST | 🟠 read + write | entityType |  |  |

### FixedAssetType

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/FixedAssetType_Index_vChartOfAccountsExpense` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/FixedAssetType_Index_vChartOfAccountsFixedAsset` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/FixedAssetType_Index_vFixedAssetType` | api | POST PUT REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | filter id search |  | vFixedAssetTypes |

### GiftCards

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/GiftCards/Import` | mvc | GET(navigate) | 🔴 write | ref |  |  |
| `/api/GiftCards_Index_vAllocation` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | SaleGiftCardID |  | root |
| `/api/GiftCards_Index_vList` | api | POST REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | search showUsedCards |  | root |

### Images

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/Images/Integrations` | mvc |  | 🟢 read |  |  |  |

### InventoryTaskAttachment

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/InventoryTaskAttachment` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | TaskID |  |  |

### LatestProductPriceBySupplier

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/LatestProductPriceBySupplier/Export` | mvc |  | 🟢 read |  |  |  |

### LeadSafetyValues

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/LeadSafetyValues/Export` | mvc |  | 🟢 read |  |  |  |

### MakeToOrder

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/MakeToOrder/DownloadMakeToOrderImage` | mvc | GET | 🟢 read | id |  |  |
| `/MakeToOrder/GetMakeToOrderArtImage` | mvc |  | 🟢 read | ArtID |  |  |
| `/MakeToOrder/UploadArtImage` | mvc | POST | 🔴 write |  |  |  |

### MySubscription

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/MySubscription/DetailsUpdate` | mvc | GET | 🔴 write |  |  |  |

### PickRecommendation

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/PickRecommendation` | api | POST | 🟢 read | allowAllLocations locationID taskID |  |  |

### PriceList

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/PriceList_Tags` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/PriceList_Templates` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/PriceList_vBrand` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/PriceList_vCategory` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |

### Product

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/Product/CountrySpecific` | mvc |  | 🟢 read | Key |  |  |
| `/Product/DownloadBomAttachment` | mvc |  | 🟢 read | id |  |  |
| `/Product/DownloadImage` | mvc |  | 🟢 read | id |  |  |
| `/Product/ExportBOM` | mvc |  | 🟢 read |  |  |  |
| `/Product/ExportCostingMethodUpdates` | mvc |  | 🟢 read | ids |  |  |
| `/Product/ExportCustomPrices` | mvc |  | 🟢 read |  |  |  |
| `/Product/ExportDiscountMatrix` | mvc |  | 🟢 read |  |  |  |
| `/Product/ExportFixedAssets` | mvc |  | 🟢 read |  |  |  |
| `/Product/ExportImages` | mvc |  | 🟢 read |  |  |  |
| `/Product/ExportInventoryList` | mvc |  | 🟢 read | withdescriptions |  |  |
| `/Product/ExportLocations` | mvc |  | 🟢 read |  |  |  |
| `/Product/ExportMarkupPrices` | mvc |  | 🟢 read |  |  |  |
| `/Product/ExportProductionBOM` | mvc |  | 🟢 read |  |  |  |
| `/Product/ExportSKUUpdates` | mvc |  | 🟢 read |  |  |  |
| `/Product/ExportSimplePrices` | mvc |  | 🟢 read |  |  |  |
| `/Product/ExportStockOnHand` | mvc |  | 🟢 read |  |  |  |
| `/Product/ExportUoM` | mvc |  | 🟢 read |  |  |  |
| `/Product/ImportCustomPricesJson` | mvc | POST | 🔴 write |  |  |  |
| `/Product/ImportFixedAssetsJson` | mvc | POST | 🔴 write |  |  |  |
| `/Product/ImportImagesJson` | mvc | POST | 🔴 write |  |  |  |
| `/Product/ImportInventoryListJson` | mvc | POST | 🔴 write |  |  |  |
| `/Product/ImportMarkupPricesJson` | mvc | POST | 🔴 write |  |  |  |
| `/Product/ImportSKUUpdatesJson` | mvc | POST | 🔴 write |  |  |  |
| `/Product/ImportStockOnHandJson` | mvc | POST | 🔴 write |  |  |  |
| `/Product/ImportUoMJson` | mvc | POST | 🔴 write |  |  |  |
| `/Product/Print` | mvc | POST | 🟢 read (logs) | IDList TemplateID |  |  |
| `/Product/Upload` | mvc | POST | 🔴 write |  |  |  |
| `/Product/UploadMakeToOrderImage` | mvc | POST | 🔴 write |  |  |  |
| `/Product/UploadMakeToOrderImage2` | mvc | POST | 🔴 write |  |  |  |
| `/Product/UploadProductionBomAttachment` | mvc | POST | 🔴 write |  |  |  |
| `/api/Product_AdditionalUnitsOfMeasure_SearchProduct` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | Name ProductID lang |  |  |
| `/api/Product_AdditionalUnitsOfMeasure_SearchProduct/CheckProductSKU` | api | GET | 🟢 read | sku |  |  |
| `/api/Product_Channels_PerformAction` | api | POST | 🔴 write |  |  |  |
| `/api/Product_Channels_PublishingProfiles` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID |  | root |
| `/api/Product_Channels_SIMQuantity` | api | POST | 🟢 read |  |  |  |
| `/api/Product_ImportCustomPrices_Exceptions` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/Product_ImportFixedAsset_Exceptions` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/Product_ImportImages_Exceptions` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/Product_ImportInventoryList_Exceptions` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/Product_ImportMarkupPrices_Exceptions` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/Product_ImportSKUUpdates_Exceptions` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/Product_ImportStockOnHand_Exceptions` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/Product_ImportUoM_Exceptions` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/Product_Index_BOMBulkUpdate` | api | GET POST | 🟠 read + write | componentProductId | NewComponent OldComponent |  |
| `/api/Product_Index_BOMProducts` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | search |  | root |
| `/api/Product_Index_Channels` | api | GET | 🟢 read | productID |  |  |
| `/api/Product_Index_Cost` | api | POST | 🟢 read | CostType costType |  |  |
| `/api/Product_Index_CostingMethod` | api | POST | 🔴 write |  |  |  |
| `/api/Product_Index_CustomPrices` | api | DELETE REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ProductID filter nonExistingOnly productID returnCount |  | root |
| `/api/Product_Index_CustomerTags` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Product_Index_DeleteDeprecated` | api | POST | 🔴 write |  |  |  |
| `/api/Product_Index_FamilyMakeToOrderConfiguration` | api | GET | 🟢 read | ProductID |  |  |
| `/api/Product_Index_PickZones` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  | PickZones |
| `/api/Product_Index_PickZonesWithLocations` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  | PickZones |
| `/api/Product_Index_ReferenceData` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Product_Index_Tags` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Product_Index_vAdditionalDescriptions` | api | DELETE REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ID ProductID |  | root |
| `/api/Product_Index_vBillOfMaterialProducts` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | CostType ProductID |  |  |
| `/api/Product_Index_vBillOfMaterialServices` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ProductID |  |  |
| `/api/Product_Index_vCountryOfOrigin` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Product_Index_vCustomer` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Product_Index_vMakeToOrderBomConfigurationProducts` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Product_Index_vMissingExpenseAccountInBOM` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Product_Index_vProblematicProductCodes` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Product_Index_vProduct` | api | POST PUT REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | CountrySpecificKey id | HasErrors ID Original SkuAutogenerationFlag Updated |  |
| `/api/Product_Index_vProduct/Locations` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | assetsOnly withBins |  |  |
| `/api/Product_Index_vProductAlternative` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ProductID |  |  |
| `/api/Product_Index_vProductAlternative/products` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | MainProductID Type |  |  |
| `/api/Product_Index_vProductCombinedList` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | IsActive lang search |  | root |
| `/api/Product_Index_vProductFamily` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Product_Index_vProductImage` | api | POST | 🔴 write |  |  |  |
| `/api/Product_Index_vProductList` | api | GET REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | IsActive lang search |  | root |
| `/api/Product_Index_vProductMovement` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ProductID search |  | root |
| `/api/Product_Index_vProductMovementActions` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/Product_Index_vProductMovementChannels` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/Product_Index_vProductMovementQuantity` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ProductID search |  | root |
| `/api/Product_Index_vProductQuantityChanges` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ProductID action channel search |  | root |
| `/api/Product_Index_vProductionBom` | api | GET REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | bomID cloneMakeToOrderConf isMakeToOrder sourceProductID |  |  |
| `/api/Product_Index_vProductionBomCopyProducts` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/Product_Index_vProductionBomFinishedProducts` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ProductID allowService |  |  |
| `/api/Product_Index_vProductionBomProducts` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ProductID Type |  |  |
| `/api/Product_Index_vProductionBomResources` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ShopFloorId |  |  |
| `/api/Product_Index_vServiceUsage` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ProductID search |  | root |
| `/api/Product_Index_vSupplier` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | lang |  |  |
| `/api/Product_Index_vTenantBrand` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/Product_Index_vTenantInventoryCategory` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/Product_Index_vTenantLocation` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/Product_Index_vTenantUnitOfMeasure` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/Product_Index_vWarrantySetup` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Product_Index_vWorkCenter` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  | root |
| `/api/Product_Merge` | api | POST | 🔴 write |  |  |  |

### product

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/product_Index_vProductImage` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ProductID |  |  |

### ProductFamily

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/ProductFamily/DownloadImage` | mvc |  | 🟢 read | id |  |  |
| `/ProductFamily/ImportImagesJson` | mvc | POST | 🔴 write |  |  |  |
| `/ProductFamily/Upload` | mvc | POST | 🔴 write |  |  |  |
| `/api/ProductFamily_ImportImages_Exceptions` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/ProductFamily_Index_CloneBom` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | sourceBomID sourceFamilyID targetFamilyID |  |  |
| `/api/ProductFamily_Index_DeleteDeprecated` | api | POST | 🔴 write |  |  |  |
| `/api/ProductFamily_Index_ProductFamilyProducts` | api | GET | 🟢 read | ProductFamilyID |  |  |
| `/api/ProductFamily_Index_Products` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/ProductFamily_Index_ReferenceData` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/ProductFamily_Index_Suppliers` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/ProductFamily_Index_vProductFamily` | api | DELETE POST PUT REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | id | GenerateVariationBoms HasErrors ID Original Updated UsedInItems |  |
| `/api/ProductFamily_Index_vProductFamilyBomProducts` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ProductFamilyID Type |  |  |
| `/api/ProductFamily_Index_vProductFamilyBomVariationProducts` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ProductFamilyID Type |  |  |
| `/api/ProductFamily_Index_vProductFamilyImage` | api | POST REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/ProductFamily_Index_vProductionBomsToCopy` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | productFamilyID |  |  |

### ProductFamilyList

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/ProductFamilyList` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | search |  | root |
| `/api/ProductFamilyList_Index_DeleteDeprecated` | api | POST | 🔴 write |  |  |  |

### ProductionOrder

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/ProductionOrder_Index_ConsumptionBins` | api | POST | 🟢 read |  |  |  |

### Purchase

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/Purchase_Index_Service` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | SupplierID |  |  |

### Recall

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/Recall_Index_Customers` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | BatchSN ProductID search showRelated |  | root |
| `/api/Recall_Index_OnHand` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | BatchSN ProductID search showRelated |  | root |
| `/api/Recall_Index_Product` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Recall_Index_ReportTemplates` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Recall_Index_Suppliers` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | BatchSN ProductID search showRelated |  | root |
| `/api/Recall_Index_UsedIn` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | BatchSN ProductID search showRelated |  | root |

### Stock

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/Stock/Download` | mvc |  | 🟢 read |  |  |  |
| `/Stock/DownloadForStockTransfer` | mvc |  | 🟢 read |  |  |  |
| `/Stock/Print` | mvc | POST | 🟢 read (logs) | IDList TemplateID |  |  |
| `/Stock/Upload` | mvc |  | 🔴 write |  |  |  |
| `/Stock/UploadForStockTransfer` | mvc |  | 🔴 write |  |  |  |
| `/api/Stock_Index_Permissions` | api | GET | 🟢 read | Type |  |  |
| `/api/Stock_Index_PriceTierName` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Stock_Index_ReferenceData` | api | GET | 🟢 read |  |  |  |
| `/api/Stock_Index_ReportTemplates` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Stock_Index_vProductsStock` | api | GET REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | inventoroFilter lang limit locationID page prodID search showNonZero showOnlyActive sort start withBatches |  | root |
| `/api/Stock_Index_vProductsStock/GetByProductId` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | lang productId search showNonZero withBatches |  | root |
| `/api/Stock_Index_vProductsStockAllocated` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | BatchSN LocationID ProductID lang withBatches |  | root |
| `/api/Stock_Index_vProductsStockInTransit` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | LocationID ProductID lang |  | root |
| `/api/Stock_Index_vProductsStockOnOrder` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | LocationID ProductID lang |  | root |

### StockAdjustment

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/StockAdjustment/Undo` | mvc | POST | 🔴 write | TaskID |  |  |
| `/StockAdjustment/UploadNewLinesTemplate` | mvc | POST | 🔴 write |  |  |  |
| `/StockAdjustment/Void` | mvc | POST | 🔴 write | TaskID |  |  |
| `/api/StockAdjustment_Index_Products` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/StockAdjustment_Index_ReferenceData` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/StockAdjustment_Index_ReferenceData/Locations` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | assetsOnly withBins |  |  |
| `/api/StockAdjustment_Index_Transactions` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | id |  |  |
| `/api/StockAdjustment_Index_ZeroProducts` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | costType productType |  |  |
| `/api/StockAdjustment_Index_vInventoryTask` | api | POST PUT REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | id | HasErrors ID Original Updated |  |
| `/api/StockAdjustment_Scan` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | LocationID lang search |  |  |
| `/api/StockAdjustment_Scan_InventoryMode` | api | POST | 🟢 read |  |  |  |

### StockAdjustmentList

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/StockAdjustmentList_Index_vInventoryTask` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | search |  | root |

### Stocktake

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/Stocktake/Import` | mvc | POST | 🔴 write |  |  |  |
| `/Stocktake/New` | mvc | GET(navigate) | 🟢 read |  |  |  |
| `/Stocktake/Undo` | mvc | POST | 🔴 write | TaskID |  |  |
| `/Stocktake/UploadNewLinesTemplate` | mvc | POST | 🔴 write |  |  |  |
| `/Stocktake/Void` | mvc | POST | 🔴 write | TaskID |  |  |
| `/api/Stocktake_New_InventoryMode` | api | POST | 🟢 read | TaskID barcodes |  |  |
| `/api/Stocktake_New_Products` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | LocationID TaskID search |  |  |
| `/api/Stocktake_New_ReferenceData` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | taskID |  |  |
| `/api/Stocktake_New_Transactions` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | id |  |  |
| `/api/Stocktake_New_ZeroProducts` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Stocktake_New_vBin` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | locationID |  |  |
| `/api/Stocktake_New_vBinGroup` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | locationID |  |  |
| `/api/Stocktake_New_vBinGroupBins` | api | GET | 🟢 read |  |  |  |
| `/api/Stocktake_New_vBrand` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Stocktake_New_vCategory` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Stocktake_New_vExternalInventory` | api | POST PUT | 🔴 write |  |  |  |
| `/api/Stocktake_New_vInventoryAdjustment` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  | root |
| `/api/Stocktake_New_vInventoryTask` | api | POST PUT REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | id | HasErrors ID Original Updated |  |
| `/api/Stocktake_New_vPickZone` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | locationID |  |  |
| `/api/Stocktake_New_vStockLocator` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Stocktake_New_vTag` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |

### StockTransfer

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/StockTransfer/CountrySpecific` | mvc |  | 🟢 read | Key |  |  |
| `/StockTransfer/UploadNewLinesTemplate` | mvc | POST | 🔴 write |  |  |  |
| `/StockTransfer/UploadNewOrderLinesTemplate` | mvc | POST | 🔴 write |  |  |  |
| `/api/StockTransfer_Index_AutoPick` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/StockTransfer_Order_Products` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | LocationID lang taskID toLocationID |  |  |
| `/api/StockTransfer_Scan` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | lang locationId search taskID type |  |  |
| `/api/StockTransfer_Scan_InventoryMode` | api | POST | 🟢 read |  |  |  |

### Stocktransfer

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/Stocktransfer/CreateInboundShipment` | mvc | POST | 🔴 write | TaskID |  |  |
| `/Stocktransfer/Undo` | mvc | POST | 🔴 write | IsPutAway TaskID |  |  |
| `/Stocktransfer/Void` | mvc | POST | 🔴 write | TaskID |  |  |
| `/api/Stocktransfer_Index_Family` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Stocktransfer_Index_FamilyProductsAvailability` | api |  | 🟢 read |  |  |  |
| `/api/Stocktransfer_Index_LocationWithBins` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | LocationFromID LocationToID |  |  |
| `/api/Stocktransfer_Index_ProductLocations` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | LocationID productID taskID toLocationID |  |  |
| `/api/Stocktransfer_Index_Products` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Stocktransfer_Index_Products/GetByAccount` | api | GET | 🟢 read | accountCode taskID |  |  |
| `/api/Stocktransfer_Index_Transactions` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | id |  |  |
| `/api/Stocktransfer_Index_vStockTransferTask` | api | POST PUT REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | CountrySpecificKey id lang | HasErrors ID Original Updated |  |

### StockTransferAttachment

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/StockTransferAttachment` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | TaskID |  |  |

### TaskShared

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/TaskShared_TaskList_vTask` | api |  | 🟢 read |  |  |  |
| `/api/TaskShared_Workflow_WorkflowProcess` | api | DELETE | 🔴 write | id |  |  |
| `/api/TaskShared_Workflow_vWorkflow` | api |  | 🟢 read |  |  |  |

### TenantAccessToFeatures

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/TenantAccessToFeatures` | api | GET POST | 🟠 read + write |  |  |  |

### TenantAttributeSet

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/TenantAttributeSet_Index_vTenantAttributeSet/GetCopyFrom` | api | GET | 🟢 read | entityID entityType fromID id |  |  |

### TenantGeneralSettings

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/TenantGeneralSettings_Index_vMultilingualSupport` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | newItem |  |  |
| `/api/TenantGeneralSettings_Index_vMultilingualSupportAccess` | api |  | 🟢 read |  |  |  |

## Public API (`/ExternalApi/v2`)

Fields, parameters and body shapes: [Price Tiers](../20-public-api/groups/price-tiers.md) · [Product](../20-public-api/groups/product.md) · [Product Family](../20-public-api/groups/product-family.md) · [Product Markup Prices](../20-public-api/groups/product-markup-prices.md) · [Stock](../20-public-api/groups/stock.md).

| Group | Method | Path | Query / params |
|---|---|---|---|
| Price Tiers | GET | `/ref/priceTier` |  |
| Product | GET | `/product` | ID,Page,Limit,Name,Sku,ModifiedSince,IncludeDeprecated,IncludeBOM,IncludeSuppliers,IncludeMovements,IncludeAttachments,IncludeReorderLevels,IncludeCustomPrices |
| Product | POST | `/product` |  |
| Product | PUT | `/product` |  |
| Product | DELETE | `/product/attachments` | ID |
| Product | GET | `/product/attachments` | ProductID |
| Product | POST | `/product/attachments` |  |
| Product | GET | `/ref/productavailability` | Page,Limit,ID,Name,Sku,Location,Batch,Category |
| Product Family | GET | `/productFamily` | ID,Page,Limit,Name,Sku,ModifiedSince |
| Product Family | POST | `/productFamily` |  |
| Product Family | PUT | `/productFamily` |  |
| Product Family | DELETE | `/productFamily/attachments` | ID |
| Product Family | GET | `/productFamily/attachments` | FamilyID |
| Product Family | POST | `/productFamily/attachments` |  |
| Product Markup Prices | GET | `/product/markupprices` | ProductID |
| Product Markup Prices | PUT | `/product/markupprices` |  |
| Stock | GET | `/stockTakeList` | Page,Limit,Status |
| Stock | DELETE | `/stockTransfer` | ID,Void |
| Stock | GET | `/stockTransfer` | TaskID |
| Stock | POST | `/stockTransfer` |  |
| Stock | PUT | `/stockTransfer` |  |
| Stock | GET | `/stockTransfer/order` | TaskID |
| Stock | POST | `/stockTransfer/order` |  |
| Stock | GET | `/stockTransferList` | Page,Limit,Status,Search |
| Stock | DELETE | `/stockadjustment` | ID,Void |
| Stock | GET | `/stockadjustment` | TaskID |
| Stock | POST | `/stockadjustment` |  |
| Stock | PUT | `/stockadjustment` |  |
| Stock | GET | `/stockadjustmentList` | Page,Limit,Status |
| Stock | DELETE | `/stocktake` | ID,Void |
| Stock | GET | `/stocktake` | TaskID |
| Stock | POST | `/stocktake` |  |
| Stock | PUT | `/stocktake` |  |
