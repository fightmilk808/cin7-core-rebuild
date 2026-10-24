# Inventory: UI

Every component the page code builds, read from the shipped ExtJS bundles: grids with their columns, fields, buttons, menus, windows and custom components. Labels are the English UI text. `renders into` is the id of the `<div>` in the page's server-rendered HTML that the component mounts in; `store` names the data store (see the endpoints in [README.md](README.md)); `on click` is the handler. Visual system and shell layout: [docs/UI.md](../../docs/UI.md).

## Screens

| Route | Title | Bundles |
|---|---|---|
| `/GiftCards` | Gift cards | [`GiftCards2019`](#giftcards2019) |
| `/PriceList` | Price list | [`PriceList2019`](#pricelist2019) |
| `/Product` | Products | [`MultilingualSupport2019`](#multilingualsupport2019), [`Customization2019`](#customization2019), [`FixedAssetType2019`](#fixedassettype2019), [`Product2019`](#product2019) |
| `/ProductFamily` | Product family | [`ProductFamily2019`](#productfamily2019) |
| `/ProductFamilyList` | Product families | [`ProductFamilyList2019`](#productfamilylist2019) |
| `/Recall` | Batch/lot recall | [`RecallReport2019`](#recallreport2019) |
| `/Stock` | Product availability | [`Stock2019`](#stock2019) |
| `/StockAdjustment` | Stock adjustment | [`StockAdjustment2019`](#stockadjustment2019) |
| `/StockAdjustmentList` | Stock adjustments and stocktakes | [`StockAdjustmentList2019`](#stockadjustmentlist2019) |
| `/StockTake` | Stocktake/adjustments | [`Stocktake2019`](#stocktake2019) |
| `/StockTransfer` | Stock transfer | [`StockTransfer2019`](#stocktransfer2019) |
| `/StockTransferList` | Stock transfers | [`StocktransferList2019`](#stocktransferlist2019) |
| `/Stocktake/New` | Stocktake/adjustments | [`Stocktake2019`](#stocktake2019) |
| `/Stocktransfer` | Stock transfer | [`StockTransfer2019`](#stocktransfer2019) |
| `/StocktransferList` | Stock transfers | [`StocktransferList2019`](#stocktransferlist2019) |

## Components by bundle

### `FixedAssetType2019`

1 grids · 0 standalone fields · 0 windows · 1 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `FixedAssetType_Index_Container` · store `store` · placeholder `You do not have any fixed asset types at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    |  | `` |  | flex 1 | renderer() | hidden |
    | Name | `Name` |  | flex 1 | RenderHTMLText |  |
    | Depreciation method | `DepreciationMethod` |  | flex 1 | RenderHTMLText |  |
    | Averaging method | `AveragingMethod` |  | flex 1 | RenderHTMLText |  |
    | Rate | `Rate` |  | flex 1 | renderer() |  |
    | Effective life | `EffectiveLife` |  | flex 1 | renderer() |  |
    | Asset account | `AssetAccountName` |  | flex 1 | Common_COA_TreeMode_RestoreDisplayName |  |
    | Accumulated depreciation account | `AccumulatedDepreciationAccountName` |  | flex 2 | Common_COA_TreeMode_RestoreDisplayName |  |
    | Depreciation expense account | `DepreciationExpenseAccountName` |  | flex 2 | Common_COA_TreeMode_RestoreDisplayName |  |


#### Menus, buttons and other parts

- **component**
  - *buttons:*
    - **item**

### `GiftCards2019`

2 grids · 0 standalone fields · 0 windows · 0 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `GiftCards_Index_Container` · store `mainStore` · placeholder `There are no gift cards at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Number | `GiftCardCode` |  | flex 2 | renderer() |  |
    | Sold in | `SaleOrderNumber` |  | flex 2 | renderer() |  |
    | Date | `Date` |  | flex 2 | renderer() |  |
    | Expiration date | `ExpirationDate` |  | flex 2 | renderer() |  |
    | Amount/balance | `InitialBalance` |  | flex 2 | renderer() |  |
    | Status | `IsBreakeraged` |  | flex 2 | renderer() |  |
    |  | `` |  | flex 1 | renderer() | hidden |

- **grid** · renders into `divAllocatedDetailsGridContainer` · store `vAllocatedStore`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Document # | `DocNumber` |  | flex 1 | renderer() |  |
    | Invoice # | `InvoiceNumber` |  | flex 1 | renderer() |  |
    | Date paid | `DatePaid` |  | flex 1 | renderer() |  |
    | Allocated amount | `Amount` |  | flex 1 | renderer() |  |
    |  | `` |  | flex 1 | renderer() | hidden |


### `Product2019`

33 grids · 72 standalone fields · 1 windows · 11 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `divPBom_Versions` · store `window.VersionsBomTempStore` · placeholder `There are no production BOM versions at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Number | `Version` |  | flex 1 | renderer() |  |
    | Name | `Name` |  | flex 1 | renderer() |  |
    | Created | `CreatedDate` |  | flex 1 | renderer() |  |
    | Default | `IsDefault` | check column | 100 | renderer() |  |

- **grid** · renders into `CustomPrices_Container` · store `CustomPricesGridStore` · placeholder `There are no custom prices at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Customer | `CustomerName` |  | flex 1 | renderer() |  |
    | Customer currency | `CurrencyCode` |  | flex 1 | renderer() |  |
    | Latest price | `LatestPrice` |  | flex 1 | renderer() |  |
    | Custom price | `CustomPrice` | number column | flex 1 | renderer() |  |
    | Last sold | `LatestDate` |  | flex 1 | renderer() |  |

- **grid** · renders into `Markup_Container` · store `MarkupGridStore` · placeholder `There are no price tiers at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Price tier | `TierNumber` |  | flex 1 | renderer() |  |
    | Price | `Price` | number column | 100 | renderer() |  |
    | Calculated | `Calculated` | check column | 100 | renderer() |  |
    | Type | `MarkupType` |  | flex 1 | renderer() |  |
    | Use | `UsePriceType` |  | flex 1 | renderer() |  |
    | Value | `MarkupValue` | number column | 100 | renderer() |  |

- **grid** · renders into `MergeProductGridContainer` · store `selectedStore`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    |  | `Name` |  | flex 1 | renderer() |  |

- **grid** · renders into `divMovementLines` · store `vProductMovementStore` · placeholder `You do not have any product movements at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Type | `Type` |  | flex 1 | renderer() |  |
    | Date | `Date` |  | flex 1 | renderer() |  |
    | Task | `Number` |  | flex 1 | renderer() |  |
    | From/to | `FromTo` |  | flex 1 | renderer() |  |
    | Status | `Status` |  | flex 1 |  |  |
    | Location | `Location` |  | flex 1 | renderer() |  |
    | Batch/serial # | `BatchSN` |  | flex 1 | renderer() |  |
    | Expiry date | `ExpiryDate` |  | flex 1 | renderer() |  |
    | Quantity | `Quantity` |  | flex 1 |  |  |
    | Cost | `Amount` |  | flex 1 | renderer() |  |

- **grid** · renders into `divMovementQuantityLines` · store `vProductMovementQuantityStore` · placeholder `You do not have any product movements at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Type | `Type` |  | flex 1 | renderer() |  |
    | Date | `Date` |  | flex 1 | renderer() |  |
    | Task | `Number` |  | flex 1 | renderer() |  |
    | From/To | `FromTo` |  | flex 1 | renderer() |  |
    | Status | `Status` |  | flex 1 |  |  |
    | Location | `Location` |  | flex 1 | renderer() |  |
    | Batch/serial # | `BatchSN` |  | flex 1 | renderer() |  |
    | Expiry date | `ExpiryDate` |  | flex 1 | renderer() |  |
    | Quantity | `Quantity` |  | flex 1 |  |  |

- **grid** · renders into `divMovementQuantityChangesLines` · store `vProductQuantityChangesStore` · placeholder `You do not have any product movements at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Date | `ChangeDate` |  | 135 | renderer() |  |
    | User name | `UserName` |  | flex 1 |  |  |
    | Action | `Action` |  | flex 2 |  |  |
    | Reference | `Reference` |  | flex 1 | renderer() |  |
    | Location | `Location` |  | flex 2 | renderer() |  |
    | Qty moved | `QtyMoved` |  | 85 | renderer() |  |
    | Available qty in stock | `Available` |  | 100 |  |  |
    | Status | `Status` |  | 75 | renderer() |  |

- **grid** · renders into `divUsageLines` · store `vServiceUsageStore` · placeholder `Service has never been used.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Type | `Type` |  | flex 1 | renderer() |  |
    | Date | `Date` |  | flex 1 | renderer() |  |
    | Document number | `Number` |  | flex 1 | renderer() |  |
    | Status | `Status` |  | flex 1 |  |  |
    | Price | `Price` |  | flex 1 | renderer() |  |

- **grid** · renders into `divBOMComponents` · placeholder `You do not have any components in BOM.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `ProductCode` |  | flex 2 | renderer() | total count |
    | Quantity | `Quantity` |  | flex 1 |  | total sum |
    | Wastage % | `WastagePercent` |  | flex 1 |  |  |
    | Wastage quantity | `WastageQuantity` |  | flex 1 |  |  |
    | Disassembly cost % | `CostPercentage` | number column | flex 1 | renderer() | total sum |
    | Cost per unit | `Cost` |  | flex 1 | renderer() |  |
    | Total cost | `TotalCost` |  | flex 1 | renderer() | total sum |

- **grid** · renders into `divBOMServices` · placeholder `You do not have any labor or overheads in BOM.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Labor & overheads | `Name` |  | flex 2 | RenderHTMLText | total count |
    | Quantity | `Quantity` |  | flex 1 |  |  |
    | Expense account | `ExpenseAccount` |  | flex 1 | renderer() |  |
    | Price tier | `PriceTier` |  | flex 1 | renderer() |  |
    | Total cost | `Cost` |  | flex 1 | renderer() | total sum |

- **grid** · renders into `divDiscountLines` · placeholder `You do not have any customer-specific discounts for this product.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Customer | `Customer` |  | flex 1 | RenderHTMLText |  |
    | Customer tag | `CustomerTag` |  | flex 1 | RenderHTMLText · edit: combo |  |
    | Discount | `DiscountName` |  | flex 1 | RenderHTMLText |  |

- **grid** · renders into `divSupplierLines` · placeholder `No suppliers found.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Supplier | `SupplierName` |  | flex 2 | renderer() |  |
    | SKU | `SupplierInventoryCode` |  | flex 1 | renderer() |  |
    | Product name | `SupplierProductName` |  | flex 1 | renderer() |  |
    | Product URL | `URL` |  | flex 1 | renderer() |  |
    | Drop ship | `DropShip` | check column | 80 | renderer() |  |
    | Currency | `Currency` |  | flex 1 |  |  |
    | Latest price | `Cost` |  | flex 1 | renderer() |  |
    | Fixed price | `FixedCost` |  | flex 1 | renderer() |  |
    | Last supplied | `SysDate` |  | flex 1 | renderer() |  |
    | Include in pricing Find out about calculated pricing"> | `IncludeInPricing` | check column | 130 | renderer() |  |

- **grid** · renders into `divLocationLines` · placeholder `No locations found.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Location | `LocationName` |  | flex 1 | renderer() |  |
    | Minimum before reorder | `MinimumBeforeReorder` |  | flex 1 |  |  |
    | Reorder quantity | `ReorderQuantity` |  | flex 1 |  |  |
    | Stock locator | `StockLocator` |  | flex 1 | renderer() |  |
    | Pick zones | `PickZones` |  | flex 1 | renderer() |  |

- **grid** · renders into `divAdditionalUnitOfMeasureLines` · placeholder `You do not have any additional units of measure for this product.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `ProductID` |  | flex 1 | renderer() |  |
    | Unit of measure | `DefaultUnitOfMeasure` |  | flex 1 | renderer() · edit: combo |  |
    | Conversion rate | `ConversionRate` |  | flex 1 | renderer() |  |
    | I am selling this product | `NotSellable` | check column | flex 1 | renderer() |  |
    | Tier 1 | `PriceTear1` |  | flex 1 | renderer() |  |
    | Tier 2 | `PriceTear2` |  | flex 1 | renderer() | hidden |
    | Tier 3 | `PriceTear3` |  | flex 1 | renderer() | hidden |
    | Tier 4 | `PriceTear4` |  | flex 1 | renderer() | hidden |
    | Tier 5 | `PriceTear5` |  | flex 1 | renderer() | hidden |
    | Tier 6 | `PriceTear6` |  | flex 1 | renderer() | hidden |
    | Tier 7 | `PriceTear7` |  | flex 1 | renderer() | hidden |
    | Tier 8 | `PriceTear8` |  | flex 1 | renderer() | hidden |
    | Tier 9 | `PriceTear9` |  | flex 1 | renderer() | hidden |
    | Tier 10 | `PriceTear10` |  | flex 1 | renderer() | hidden |

- **grid** · renders into `Product_Index_Container` · store `mainStore` · placeholder `No products found.`
- **grid** · renders into `CombinedProduct_Index_Container` · store `combinedProductsStore` · placeholder `No products found.`
- **grid** · renders into `divAttachmentList` · store `ImageStore` · placeholder `You do not have any files attached.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Reorder | `` |  | 80 | renderer() |  |
    | No. | `RowOrderNum` |  | 60 | renderer() |  |
    | Mark as default | `isDefault` | check column | 116 | renderer() |  |
    | Img. preview | `ImageID` |  | 100 | renderer() |  |
    | Filename | `FileName` |  | flex 2 | renderer() |  |

- **grid** · renders into `renderTo` · store `store` · placeholder `Please upload a file to check for issues.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Line # | `Line` |  | 50 |  |  |
    | Product code | `ProductCode` |  | 200 | renderer() |  |
    | Name | `Name` |  | 300 | renderer() |  |
    | Category | `Category` |  | 200 | renderer() |  |
    | Brand | `Brand` |  | 200 | renderer() |  |
    | Type | `Type` |  | 100 | renderer() |  |
    | Costing method | `CostingMethod` |  | 150 | renderer() |  |
    | Length | `Length` |  | 100 | renderer() |  |
    | Width | `Width` |  | 100 | renderer() |  |
    | Height | `Height` |  | 100 | renderer() |  |
    | Dimension units | `DimensionUnits` |  | 100 | renderer() |  |
    | Weight | `Weight` |  | 100 | renderer() |  |
    | Weight units | `WeightUnits` |  | 100 | renderer() |  |
    | Barcode | `Barcode` |  | 150 | renderer() |  |
    | Minimum before reorder | `MinimumBeforeReorder` |  | 100 | renderer() |  |
    | Reorder quantity | `ReorderQuantity` |  | 150 | renderer() |  |
    | Default location | `DefaultLocation` |  | 150 | renderer() |  |
    | Last supplied by | `LastSuppliedBy` |  | 200 | renderer() |  |
    | Supplier product code | `SupplierProductCode` |  | 300 | renderer() |  |
    | Supplier product name | `SupplierProductName` |  | 300 | renderer() |  |
    | Price tier 1 | `PriceTier1` |  | 130 | renderer() |  |
    | Price tier 2 | `PriceTier2` |  | 130 | renderer() |  |
    | Price tier 3 | `PriceTier3` |  | 130 | renderer() |  |
    | Price tier 4 | `PriceTier4` |  | 130 | renderer() |  |
    | Price tier 5 | `PriceTier5` |  | 130 | renderer() |  |
    | Price tier 6 | `PriceTier6` |  | 130 | renderer() |  |
    | Price tier 7 | `PriceTier7` |  | 130 | renderer() |  |
    | Price tier 8 | `PriceTier8` |  | 130 | renderer() |  |
    | Price tier 9 | `PriceTier9` |  | 130 | renderer() |  |
    | Price tier 10 | `PriceTier10` |  | 130 | renderer() |  |
    | Assembly BOM | `AssemblyBOM` |  | 200 | renderer() |  |
    | Auto assemble | `AutoAssemble` |  | 200 | renderer() |  |
    | Auto disassemble | `Auto Disassemble` |  | 200 | renderer() |  |
    | Drop ship | `DropShip` |  | 200 | renderer() |  |
    | Average cost | `AverageCost` |  | 130 | renderer() |  |
    | Default unit of measure | `DefaultUnitOfMeasure` |  | 200 | renderer() |  |
    | Inventory account | `InventoryAccount` |  | 200 | renderer() |  |
    | Revenue account | `RevenueAccount` |  | 200 | renderer() |  |
    | Expense account | `ExpenseAccount` |  | 200 | renderer() |  |
    | COGS account | `COGSAccount` |  | 200 | renderer() |  |
    | Product attribute set | `ProductAttributeSet` |  | 200 | renderer() |  |
    | Additional attribute 1 | `AdditionalAttribute1` |  | 200 | renderer() |  |
    | Additional attribute 2 | `AdditionalAttribute2` |  | 200 | renderer() |  |
    | Additional attribute 3 | `AdditionalAttribute3` |  | 200 | renderer() |  |
    | Additional attribute 4 | `AdditionalAttribute4` |  | 200 | renderer() |  |
    | Additional attribute 5 | `AdditionalAttribute5` |  | 200 | renderer() |  |
    | Additional attribute 6 | `AdditionalAttribute6` |  | 200 | renderer() |  |
    | Additional attribute 7 | `AdditionalAttribute7` |  | 200 | renderer() |  |
    | Additional attribute 8 | `AdditionalAttribute8` |  | 200 | renderer() |  |
    | Additional attribute 9 | `AdditionalAttribute9` |  | 200 | renderer() |  |
    | Additional attribute 10 | `AdditionalAttribute10` |  | 200 | renderer() |  |
    | Discount name | `DiscountName` |  | 200 | renderer() |  |
    | Product family SKU | `ProductFamilySKU` |  | 200 | renderer() |  |
    | Product family option 1 value | `ProductFamilyOption1Value` |  | 200 | renderer() |  |
    | Product family option 2 value | `ProductFamilyOption2Value` |  | 200 | renderer() |  |
    | Product family option 3 value | `ProductFamilyOption3Value` |  | 200 | renderer() |  |
    | Comma-delimited tags | `CommaDelimitedTags` |  | 200 | renderer() |  |
    | Stock locator | `StockLocator` |  | 200 | renderer() |  |
    | Purchase tax rule | `PurchaseTaxRule` |  | 200 | renderer() |  |
    | Sale tax rule | `SaleTaxRule` |  | 200 | renderer() |  |
    | Status | `Status` |  | 100 | renderer() |  |
    | Pick zones | `PickZones` |  | 100 | renderer() |  |
    | Always show quantity | `AlwaysShowQuantity` |  | 200 | renderer() |  |
    | Production BOM | `ProductionBOM` |  | 200 | renderer() |  |
    | Quantity to produce | `QuantityToProduce` |  | 200 | renderer() |  |

- **grid** · renders into `divExceptionsContainer` · store `store` · placeholder `Please upload a file to check for issues.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Line # | `Line` |  | 50 |  |  |
    | Action | `Action` |  | 120 | renderer() |  |
    | Product SKU | `ProductSKU` |  | 200 | renderer() |  |
    | Product name | `ProductName` |  | 300 | renderer() |  |
    | Price tier | `PriceTier` |  | 200 | renderer() |  |
    | Type | `MarkupType` |  | 300 | renderer() |  |
    | Use | `UseType` |  | 200 | renderer() |  |
    | Value | `Value` |  | 200 | renderer() |  |

- **grid** · renders into `divExceptionsContainer` · store `store` · placeholder `Please upload a file to check for issues.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Line # | `Line` |  | 50 |  |  |
    | Old product SKU | `CurrentSKU` |  | 200 | renderer() |  |
    | Product SKU | `NewSKU` |  | 200 | renderer() |  |
    | Product name | `Name` |  | flex 1 | renderer() |  |

- **grid** · renders into `divExceptionsContainer` · store `store` · placeholder `Please upload a file to check for issues.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Line # | `Line` |  | 50 |  |  |
    | Action | `Action` |  | flex 1 | renderer() |  |
    | Base SKU | `BaseSKU` |  | flex 1 | renderer() |  |
    | Base product name | `BaseProductName` |  | flex 1 | renderer() |  |
    | Base units of measure | `BaseUnitsOfMeasure` |  | flex 1 | renderer() |  |
    | Additional units of measure SKU | `AdditionalUnitsOfMeasureSKU` |  | flex 1 | renderer() |  |
    | Additional units of measure product name | `AdditionalUnitsOfMeasureProductName` |  | flex 1 | renderer() |  |
    | Additional units of measure name | `AdditionalUnitsOfMeasureName` |  | flex 1 | renderer() |  |
    | Number of base units in additional unit | `NumberOfBaseUnitsInAdditionalUnit` |  | flex 1 | renderer() |  |
    | I am selling this product | `IAmSellingThisProduct` |  | flex 1 | renderer() |  |

- **grid** · renders into `divExceptionsContainer` · store `store`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Line # | `Line` |  | 50 |  |  |
    | Action | `Action` |  |  | renderer() |  |
    | Product SKU | `ProductSKU` |  |  | renderer() |  |
    | Product name | `ProductName` |  | flex 1 | renderer() |  |
    | Customer name | `CustomerName` |  | 200 | renderer() |  |
    | Price | `Price` |  |  | renderer() |  |

- **grid** · renders into `divExceptionsContainer` · store `store`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Line # | `Line` |  | 50 |  |  |
    | Product code | `ProductCode` |  | 100 | renderer() |  |
    | Quantity | `Quantity` |  | 100 | renderer() |  |
    | Average cost | `AverageCost` |  | 100 | renderer() |  |
    | Location | `Location` |  | 100 | renderer() |  |
    | Batch or serial number | `BatchOrSerialNumber` |  | 200 | renderer() |  |
    | Expiry date | `ExpiryDate_YYYYMMDD` |  | 100 | renderer() |  |
    | Received date | `ReceivedDate_YYYYMMDD` |  | 100 | renderer() |  |

- **grid** · renders into `divExceptionsContainer` · store `store` · placeholder `Please upload a file to check for issues.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Line # | `Line` |  | 50 |  |  |
    | Product code | `ProductCode` |  | 150 | renderer() |  |
    | Quantity | `Quantity` |  | 100 | renderer() |  |
    | Average cost | `AverageCost` |  | 100 | renderer() |  |
    | Location | `Location` |  | flex 1 | renderer() |  |
    | Batch or serial number | `BatchOrSerialNumber` |  | 200 | renderer() |  |
    | Received date | `ReceivedDate_YYYYMMDD` |  | 150 | renderer() |  |

- **grid** · renders into `divAlternativProducts` · placeholder `No alternative products found.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `AlternativeProductCode` |  | flex 1 | renderer() |  |
    | Interchangeable | `IsInterchangeable` | check column | 150 | renderer() |  |
    |  | `Matching` |  | 150 | renderer() |  |
    | Use in production | `UseInProduction` | check column | 100 | renderer() |  |
    | Quantity | `Quantity` |  | 110 | renderer() |  |

- **grid** · renders into `Stock_Index_Container` · store `stockStore` · placeholder `You do not have any products matching the specified criteria.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Location | `Location` |  | flex 1 | RenderHTMLText |  |
    | Bin | `Bin` |  | flex 1 | RenderHTMLText |  |
    | Batch/serial # | `BatchSN` |  | flex 1 | RenderHTMLText |  |
    | Expiry date | `ExpiryDate` |  | 100 | renderer() |  |
    | Stock value | `StockOnHand` |  | 100 | renderer() |  |
    | On hand | `OnHand` |  | 90 |  |  |
    | Available | `Available` |  | 90 |  |  |
    | On order | `OnOrder` |  | 90 | renderer() |  |
    | In transit | `InTransit` |  | 80 | renderer() |  |
    | Allocated | `Allocated` |  | 90 | renderer() |  |
    | Next delivery | `NextDeliveryDate` |  | flex 1 | Stock_Index_FormatNextDeliveryDate |  |

- **grid** · renders into `AllocatedGrid_Container` · store `vProductsStockAllocatedStore`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Task no. | `Number` |  | flex 1 | renderer() |  |
    | Customer | `CustomerName` |  | flex 2 | renderer() |  |
    | Quantity | `Quantity` |  | flex 1 |  |  |
    | Date | `Date` | date column | flex 1 | renderer() |  |

- **grid** · renders into `OnOrderGrid_Container` · store `vProductsStockOnOrderStore`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Order | `Number` |  | flex 1 | renderer() |  |
    | Supplier | `SupplierName` |  | flex 2 | renderer() |  |
    | Date | `Date` | date column | flex 1 | renderer() |  |
    | Required by | `RequiredByDate` | date column | flex 1 | renderer() |  |
    | Quantity | `Quantity` |  | flex 1 |  |  |
    | Next delivery | `NextDeliveryDate` | date column | flex 1 | renderer() |  |

- **grid** · renders into `InTransitGrid_Container` · store `vProductsStockInTransitStore`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Order | `Number` |  | flex 1 | renderer() |  |
    | Supplier | `SupplierName` |  | flex 2 | renderer() |  |
    | Date | `Date` | date column | flex 1 | renderer() |  |
    | Required by | `RequiredByDate` | date column | flex 1 | renderer() |  |
    | Quantity | `Quantity` |  | flex 1 |  |  |
    | Next delivery | `NextDeliveryDate` | date column | flex 1 | renderer() |  |
    |  | `` |  | flex 1 | renderer() | hidden |

- **grid** · renders into `divExceptionsContainer` · store `store` · placeholder `Please upload a file to check for issues.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Line # | `Line` |  | 50 |  |  |
    | Action | `Action` |  | 150 | RenderHTMLText |  |
    | Product SKU | `ProductSKU` |  | 250 | renderer() |  |
    | URL | `ImageUrl` |  | 600 | renderer() |  |
    | File name | `ImageFileName` |  | 400 | renderer() |  |

- **grid** · renders into `divLeadSafetyLines` · store `vProductLeadSafetyPagedStore` · placeholder `No suppliers found.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    |  (group: Supplier, Lead, Safety, Reorder quantity, Minimum order quantity) | `` |  |  |  |  |
    | Location set up (group: Location, Lead, Safety, Reorder quantity, ) | `` |  |  |  |  |

- **grid** · renders into `"divMTOProductMapGrid-".concat(…)` · store `item.vMakeToOrderBOMProductMaps(…)` · placeholder `Please add at least one choice, product family or custom element item…`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Choice | `MenuConfigurationID` |  | flex 1 | renderer() |  |
    | Product | `MappedProductCode` |  | flex 1 | renderer() |  |
    | Unit | `MappedProductUnit` |  | 100 | renderer() |  |

- **grid** · renders into `divMakeToOrderConditionsGrid` · store `vMakeToOrderConditionsStore` · placeholder `There are no conditions added.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Condition item | `RelatedMenuConfigurationID` |  | flex 1 | renderer() |  |
    | Condition | `Condition` |  | flex 1 | renderer() |  |


#### Windows and dialogs

- **window** “Add a new product category” · layout fit

#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| combo |  | `cmbPBomVersion` | `PBomVersionStore` | shows `DisplayName` · value `BomID` · pick-only |
| number field |  | `liOutputQuantity` | `` |  |
| text field |  | `Product_Index_ProductionInstructionURL` | `` |  |
| number field |  | `liManufacturingBufferTime` | `` |  |
| combo |  | `liManufacturingDeliveryTo` | `vTenantLocationLoadStore` | shows `Description` · value `LocationID` · placeholder `Choose...` |
| checkbox |  | `liIgnoreCumulativeLeadTime` | `` |  |
| checkbox |  | `divProductTracing` | `` |  |
| number field |  | `liComponentProductionLeadTime` | `` |  |
| combo |  | `cmb_ProductionIssueMethod` | `IssueMethodTypesStore` | shows `name` · value `value` · pick-only |
| combo |  | `cmb_BackflushDefinedFor` | `BackflushDefinedForStore` | shows `name` · value `value` · pick-only |
| number field |  | `liManufacturingMinQuantity` | `` |  |
| number field |  | `liManufacturingMaxQuantity` | `` |  |
| number field |  | `liManufacturingDeviationPercent` | `` |  |
| number field |  | `liManufacturingRunSize` | `` |  |
| combo |  | `cmbFinishedProductCost` | `CostCalculationsTypesStore` | shows `name` · value `value` · pick-only |
| combo |  | `cmbCopyBom` | `vProductionBomProductsCopyStore` | shows `Description` · value `BomID` · placeholder `Select another BOM to copy` |
| combo |  | `Product_Index_BulkComponentUpdateInBOMs_OldCompon…` | `vProductListBOMOldComponentStore` | shows `CodeWithName` · value `ProductID` · placeholder `Select old component` |
| combo |  | `Product_Index_BulkComponentUpdateInBOMs_NewCompon…` | `vProductListBOMNewComponentStore` | shows `CodeWithName` · value `ProductID` · placeholder `Select new component` |
| combo |  | `Product_Channels_PublishingProfiles` | `vPublishingProfileStore` | shows `Name` · value `Id` · pick-only |
| combo |  | `Product_Index_Type` | `ProductTypeStore` | shows `name` · value `value` · pick-only |
| combo (+ add new) |  | `Product_Index_FixedAssetType` | `vProductFixedAssetTypeStore` | shows `Name` · value `FixedAssetTypeID` |
| combo (+ add new) |  | `Product_Index_Category` | `vTenantInventoryCategoryStore` | shows `Category` · value `CategoryID` |
| combo (+ add new) |  | `Product_Index_Brand` | `vTenantBrandStore` | shows `Brand` · value `ID` |
| combo (+ add new) |  | `Product_Index_DefaultUnitOfMeasure` | `vTenantUnitOfMeasureStore` | shows `Unit` · value `UnitOfMeasureID` |
| combo |  | `Product_Index_DropShipMode` | `DropShipModeStore` | shows `DisplayName` · value `DropShipMode` · pick-only |
| combo |  | `Product_Index_BillOfMaterial` | `BomTypeStore` | shows `name` · value `value` · pick-only |
| combo |  | `Product_Index_InventoryAccount` | `InventoryAccountsStore` | shows `DisplayName` · value `Code` |
| combo |  | `Product_Index_RevenueAccount` | `RevenueAccountsStore` | shows `DisplayName` · value `Code` |
| combo |  | `Product_Index_ExpenseAccount` | `vChartOfAccountsStore` | shows `DisplayName` · value `Code` |
| combo |  | `Product_Index_COGSAccount` | `vChartOfAccountsStore` | shows `DisplayName` · value `Code` |
| combo |  | `Product_Index_PurchaseTaxRule` | `PurchaseTaxRuleStore` | shows `Description` · value `RuleID` |
| combo |  | `Product_Index_SaleTaxRule` | `SaleTaxRuleStore` | shows `Description` · value `RuleID` |
| combo |  | `Product_Index_Discount` | `vDiscountStore` | shows `Name` · value `ID` |
| combo |  | `Product_Index_WarrantySetup` | `vWarrantySetupStore` | shows `Name` · value `ID` |
| combo |  | `Product_Index_CountryOfOrigin` | `vCountryOfOriginStore` | shows `Name` · value `Code` · placeholder `Not defined` |
| combo |  | `Product_Index_Status` | `StatusStore` | shows `Name` · value `Value` · pick-only |
| combo (+ add new) |  | `Product_Index_DefaultLocation` | `vTenantLocationLoadStore` | shows `Description` · value `LocationID` |
| combo |  | `Product_Index_ProductAttributeSet` | `AttributeSetStore` | shows `Name` · value `SetID` · pick-only |
| combo |  | `Product_Index_NotSellable` | `NotSellableTypesStore` | shows `name` · value `value` |
| text field |  | `Product_Index_AssemblyInstructionURL` | `` |  |
| checkbox |  | `liAutoAssembly` | `` |  |
| checkbox |  | `liAutoDisassembly` | `` |  |
| combo |  | `liCostType` | `window.CostTypeStore` | shows `CostTypeName` · value `CostType` · pick-only |
| number field |  | `liQuantityToProduce` | `` |  |
| combo |  | `divMovementType` | `MovementTypeStore` | shows `name` · value `value` · pick-only |
| combo |  | `divMovementChanel` | `MovementChanelStore` | shows `name` · value `value` · pick-only |
| combo |  | `divMovementAction` | `MovementActionStore` | shows `name` · value `value` · pick-only |
| combo |  | `divNewProduct_AdditionalUnitOfMeasureUnitOfMeasure` | `vTenantUnitOfMeasureStore` | shows `Unit` · value `UnitOfMeasureID` |
| combo |  | `Product_Index_WeightUnits` | `MeasurementWeightStore` | shows `UoMName` · value `UoMAbbr` · pick-only |
| combo |  | `Product_Index_DimensionUnits` | `MeasurementDimensionsStore` | shows `UoMName` · value `UoMAbbr` · pick-only |
| combo |  | `AdditionalDescriptionsSelect` | `pProductAdditionalDescriptionsStore` | shows `ShopName` · value `SIMProductID` · pick-only |
| text field |  | `tdProduct_NewFixedAssetType_Category` | `` |  |
| date field |  | `"dtSupplyIntervalDate".concat(…)` | `` | placeholder `Select date` · format `UserDateFormat` |
| date field |  | `divCostingMethodModal_ExpiryDate` | `` | placeholder `Choose...` · format `UserDateFormat` |
| text field |  | `renderTo` | `` |  |
| checkbox |  | `renderTo` | `` |  |
| numeric field |  | `renderTo` | `` |  |
| date field |  | `renderTo` | `` | placeholder `Choose...` · format `UserDateFormat` |
| number field |  | `liMakeToOrderOutputQuantity` | `` |  |
| text field |  | `Product_Index_MakeToOrderInstructionURL` | `` |  |
| number field |  | `liMakeToOrderManufacturingBufferTime` | `` |  |
| checkbox |  | `liMakeToOrderIgnoreCumulativeLeadTime` | `` |  |
| combo |  | `liMakeToOrderManufacturingDeliveryTo` | `vTenantLocationLoadStore` | shows `Description` · value `LocationID` · placeholder `Choose...` |
| number field |  | `liMakeToOrderComponentProductionLeadTime` | `` |  |
| combo |  | `cmb_MakeToOrderIssueMethod` | `window.IssueMethodTypesStore` | shows `name` · value `value` · pick-only |
| combo |  | `cmbMakeToOrderFinishedProductCost` | `window.CostCalculationsTypesStore` | shows `name` · value `value` · pick-only |
| combo |  | `cmbMakeToOrderCopyBom` | `vProductionBomProductsCopyStore` | shows `Description` · value `BomID` · placeholder `Select another BOM to copy` |
| combo |  | `"divMTOConfigTemplate-".concat(…)` | `vMakeToOrderConfigTemplatesStore` | shows `TemplateName` · value `TemplateID` · pick-only |
| combo |  | `"divMTOConfigMenuItem-".concat(…)` | `vMakeToOrderConfigMenuItemsStore` | shows `Name` · value `MenuConfigurationID` · pick-only |
| combo |  | `divId` | `window[optionStoreName]` | shows `Name` · value `MenuConfigurationID` · pick-only |
| combo |  | `divMakeToOrderConditionalVisibility` | `vMakeToOrderVisibilityOptionsStore` | shows `Label` · value `Value` · placeholder `Choose...` · pick-only |
| combo |  | `divMakeToOrderJoinCondition` | `vMakeToOrderJoinConditionsStore` | shows `Label` · value `Value` · placeholder `Choose...` · pick-only |

#### Menus, buttons and other parts

- **column** · placeholder `You do not have any components yet.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Type | `Type` |  | flex 1 | renderer() |  |
    | Component | `Value` |  | flex 1 | renderer() |  |
    |  | `CostCalculationType` |  | flex 1 | renderer() |  |
    | Backflush | `IsBackflush` | check column | 100 | renderer() | hidden |
    | Quantity | `Quantity` |  | flex 1 | renderer() |  |
    | Unit | `Unit` |  | flex 1 | renderer() |  |
    | Wastage % | `WastagePercent` |  | flex 1 | renderer() |  |
    |  | `WastageQty` |  | flex 1 | renderer() |  |
    | Sales price | `SalePriceTier` |  | flex 1 | renderer() |  |
    | Cost per unit | `Cost` |  | flex 1 | renderer() |  |
    | Total cost | `TotalCost` |  | flex 1 | renderer() |  |

- **column**
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Sequence | `Order` |  | 75 | renderer() |  |
    | Previous step | `OperationRelationIDsFake` |  | 75 | renderer() |  |
    | Type | `OperationType` |  | flex 1 | renderer() |  |
    | Operation | `Name` |  | flex 1 | renderer() |  |
    | Backflush | `IsBackflush` | check column | flex 1 | renderer() | hidden |
    | Cycle time | `CycleTimeString` |  | 90 | renderer() |  |
    | Units per cycle | `UnitsPerCycle` |  | flex 1 | renderer() |  |
    | Work center | `WorkCenterID` |  | flex 1 | renderer() |  |
    |  | `IsDropShip` | check column | 100 | renderer() |  |
    | Total cost | `TotalCost` |  | flex 1 | renderer() |  |

- **column** · store `OperationProductsStore` · placeholder `You do not have any finished products yet.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `ProductSku` |  | flex 2 | renderer() |  |
    | Unit of measure | `Unit` |  | 100 | renderer() |  |
    | Sales Value | `PriceTier` | number column | flex 1 | renderer() |  |
    | Sales Value per unit | `Ratio` | number column | flex 1 | renderer() |  |
    | Estimated cost per unit | `Cost` | number column | flex 1 | renderer() |  |
    | Estimated total cost | `TotalCost` | number column | flex 1 | renderer() |  |
    | Delivery to | `DeliveryTo` |  | flex 1 | renderer() |  |

- **column** · store `WastageProductsStore` · placeholder `You do not have any finished products or input/output components yet.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `ProductSku` |  | flex 2 | renderer() |  |
    | Fixed price | `WastageCost` | number column | flex 1 | renderer() |  |
    | Cost per unit | `WastageCost` | number column | flex 1 | renderer() |  |

- **MovementTypeModel** · name `Show availability changes`
- **MovementTypeModel** · name `Show quantity movements`
- **MovementTypeModel** · name `Show quantity and cost movements`
- **form** · renders into `Ext.getBody(…)`
- **component** · id `cmpId` · renders into `renderTo` · store `localStore` · shows `name` · value `value` · placeholder `Choose...` · pick-only
- **column** “{attrSet.name}” · field `"CustomField".concat(…)`
- **column** · store `OperationProductsStore` · placeholder `You do not have any finished products yet.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `ProductSku` |  | flex 2 | renderer() |  |
    | Unit of measure | `Unit` |  | 100 | renderer() |  |
    | Sales Value | `PriceTier` | number column | flex 1 | renderer() |  |
    | Sales Value per unit | `Ratio` | number column | flex 1 | renderer() |  |
    | Estimated cost per unit | `Cost` | number column | flex 1 | renderer() |  |
    | Estimated total cost | `TotalCost` | number column | flex 1 | renderer() |  |
    | Delivery to | `DeliveryTo` |  | flex 1 | renderer() |  |


### `ProductFamily2019`

8 grids · 48 standalone fields · 0 windows · 7 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `divAttachmentList` · store `ImageStore` · placeholder `You do not have any files attached.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Image order | `RowOrderNum` |  | flex 1 | renderer() |  |
    | Name | `FileName` |  | flex 1 | renderer() |  |
    | Default | `isDefault` | check column | 100 | renderer() |  |

- **grid** · renders into `tdOption1Values` · store `StoreOption1Values`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Option 1 values | `value` |  | flex 1 | RenderHTMLText |  |

- **grid** · renders into `tdOption2Values` · store `StoreOption2Values`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Option 2 values | `value` |  | flex 1 | RenderHTMLText |  |

- **grid** · renders into `tdOption3Values` · store `StoreOption3Values`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Option 3 values | `value` |  | flex 1 | RenderHTMLText |  |

- **grid** · renders into `tdVariationDims` · placeholder `You do not have any variants in the family.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `ProductCode` |  | flex 2 | renderer() |  |
    | Weight | `Weight` |  | 120 | RenderHTMLText |  |
    | Weight units | `WeightUnits` |  | flex 1 | renderer() |  |
    | Width | `Width` |  | 120 | RenderHTMLText |  |
    | Height | `Height` |  | 120 | RenderHTMLText |  |
    | Length | `Length` |  | 120 | RenderHTMLText |  |
    | Dimension units | `DimensionsUnits` |  | flex 1 | renderer() |  |

- **grid** · renders into `tdVariations` · placeholder `You do not have any variants in the family.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `ProductCode` |  | flex 3 | renderer() |  |
    | Option 1 value | `Option1` |  | flex 1 | RenderHTMLText |  |
    | Option 2 value | `Option2` |  | flex 1 | RenderHTMLText |  |
    | Option 3 value | `Option3` |  | flex 1 | RenderHTMLText |  |
    | Price tier 1 | `PriceTear1` |  | flex 1 | renderer() |  |
    | Price tier 2 | `PriceTear2` |  | flex 1 | renderer() |  |
    | Price tier 3 | `PriceTear3` |  | flex 1 | renderer() |  |
    | Price tier 4 | `PriceTear4` |  | flex 1 | renderer() |  |
    | Price tier 5 | `PriceTear5` |  | flex 1 | renderer() |  |
    | Price tier 6 | `PriceTear6` |  | flex 1 | renderer() |  |
    | Price tier 7 | `PriceTear7` |  | flex 1 | renderer() |  |
    | Price tier 8 | `PriceTear8` |  | flex 1 | renderer() |  |
    | Price tier 9 | `PriceTear9` |  | flex 1 | renderer() |  |
    | Price tier 10 | `PriceTear10` |  | flex 1 | renderer() |  |

- **grid** · renders into `divExceptionsContainer` · store `store` · placeholder `Please upload a file to check for issues.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Line # | `Line` |  | 50 |  |  |
    | Action | `Action` |  | 150 | RenderHTMLText |  |
    | Product SKU | `ProductSKU` |  | 250 | renderer() |  |
    | URL | `ImageUrl` |  | 600 | renderer() |  |
    | File name | `ImageFileName` |  | 400 | renderer() |  |

- **grid** · renders into `divUsedInProductsData` · placeholder `You do not have any generated production BOMs for variations of the p…`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `ProductId` |  | flex 2 | renderer() |  |
    | Production BOM generated. | `HasFamilyDerivedBom` |  | flex 1 | renderer() |  |
    | Used as default version | `IsFamilyDerivedBomDefault` |  | flex 1 | renderer() |  |
    | Mapping is finished | `IsMapped` |  | flex 1 | renderer() |  |


#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| text field |  | `tdSKU` | `` |  |
| text field |  | `tdName` | `` |  |
| combo (+ add new) |  | `tdCategory` | `vTenantInventoryCategoryStore` | shows `Category` · value `CategoryID` |
| combo (+ add new) |  | `tdBrand` | `vTenantBrandStore` | shows `Brand` · value `ID` |
| combo |  | `tdCostingMethod` | `CostingMethodStore` | shows `DisplayName` · value `CostingMethod` |
| combo |  | `tdDropShipMode` | `DropShipModeStore` | shows `DisplayName` · value `DropShipMode` · pick-only |
| combo |  | `tdDropShipSupplier` | `DropShipSupplierStore` | shows `Name` · value `SupplierID` · placeholder `type to search...` |
| combo |  | `tdLastSupplier` | `SupplierStore` | shows `Name` · value `SupplierID` · placeholder `type to search...` |
| numeric field |  | `tdSupplierPrice` | `` |  |
| text field |  | `tdOption1Name` | `` |  |
| text field |  | `tdOption2Name` | `` |  |
| text field |  | `tdOption3Name` | `` |  |
| combo (+ add new) |  | `tdUnitOfMeasure` | `vTenantUnitOfMeasureStore` | shows `Unit` · value `UnitOfMeasureID` |
| combo |  | `tdInventoryAccount` | `InventoryAccountsStore` | shows `DisplayName` · value `Code` · pick-only |
| combo |  | `tdRevenueAccount` | `RevenueAccountsStore` | shows `DisplayName` · value `Code` · pick-only |
| combo |  | `tdCOGSAccount` | `COGSAccountsStore` | shows `DisplayName` · value `Code` · pick-only |
| combo |  | `tdPurchaseTaxRule` | `PurchaseTaxRuleStore` | shows `Description` · value `RuleID` · pick-only |
| combo |  | `tdSaleTaxRule` | `SaleTaxRuleStore` | shows `Description` · value `RuleID` |
| combo (+ add new) |  | `tdDefaultLocation` | `vTenantLocationLoadStore` | shows `Description` · value `LocationID` |
| combo |  | `divCountryOfOrigin` | `vCountryOfOriginStore` | shows `Name` · value `Code` · placeholder `Not defined` |
| combo |  | `tdAttributeSet` | `AttributeSetStore` | shows `Name` · value `SetID` · pick-only |
| number field |  | `tdMinimumBeforeReorder` | `` |  |
| number field |  | `tdReorderQuantity` | `` |  |
| numeric field |  | `tdPriceTier1` | `` |  |
| numeric field |  | `tdPriceTier2` | `` |  |
| numeric field |  | `tdPriceTier3` | `` |  |
| numeric field |  | `tdPriceTier4` | `` |  |
| numeric field |  | `tdPriceTier5` | `` |  |
| numeric field |  | `tdPriceTier6` | `` |  |
| numeric field |  | `tdPriceTier7` | `` |  |
| numeric field |  | `tdPriceTier8` | `` |  |
| numeric field |  | `tdPriceTier9` | `` |  |
| numeric field |  | `tdPriceTier10` | `` |  |
| combo |  | `tdDiscount` | `vDiscountStore` | shows `Name` · value `ID` |
| combo |  | `tdBOM` | `vBOMStore` | shows `name` · value `value` · pick-only |
| combo |  | `tdWarrantySetup` | `vWarrantySetupStore` | shows `Name` · value `ID` |
| number field |  | `liOutputQuantity` | `` |  |
| text field |  | `ProductFamily_Index_ProductionInstructionURL` | `` |  |
| number field |  | `liManufacturingBufferTime` | `` |  |
| checkbox |  | `liIgnoreCumulativeLeadTime` | `` |  |
| number field |  | `liComponentProductionLeadTime` | `` |  |
| combo |  | `cmb_ProductionIssueMethod` | `IssueMethodTypesStore` | shows `name` · value `value` · pick-only |
| combo |  | `cmbFinishedProductCost` | `CostCalculationsTypesStore` | shows `name` · value `value` · pick-only |
| combo |  | `cmbCopyBom` | `vProductionBomProductsCopyStore` | shows `Description` · value `BomID` · placeholder `Select another BOM to copy` |
| text field |  | `renderTo` | `` |  |
| checkbox |  | `renderTo` | `` |  |
| numeric field |  | `renderTo` | `` |  |
| date field |  | `renderTo` | `` | placeholder `Choose...` · format `UserDateFormat` |

#### Menus, buttons and other parts

- **column** · renders into `tdAdditionalAttributes` · store `StoreProductsAttributes` · placeholder `You do not have any variants in the family.`
- **column** · placeholder `You do not have any components yet.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Type | `Type` |  | 150 | renderer() |  |
    | Component | `Value` |  | flex 1 | renderer() |  |
    |  | `CostCalculationType` |  | 150 | renderer() |  |
    | Quantity | `Quantity` |  | flex 1 | renderer() |  |
    | Unit | `Unit` |  | 100 | renderer() |  |
    | Wastage % | `WastagePercent` |  | 100 | renderer() |  |
    |  | `WastageQty` |  | 100 | renderer() |  |
    | Sales price | `SalePriceTier` |  | 120 | renderer() |  |
    | Cost per unit | `Cost` |  | 100 | renderer() |  |
    | Total cost | `TotalCost` |  | 100 | renderer() |  |

- **column**
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Sequence | `Order` |  | 100 | renderer() |  |
    | Previous step | `OperationRelationIDsFake` |  | 150 | renderer() |  |
    | Type | `OperationType` |  | flex 1 | renderer() |  |
    | Operation | `Name` |  | flex 1 | renderer() |  |
    | Cycle time | `CycleTimeString` |  |  | renderer() |  |
    | Units per cycle | `UnitsPerCycle` |  |  | renderer() |  |
    | Work center | `WorkCenterID` |  |  | renderer() |  |
    |  | `IsDropShip` | check column | 100 | renderer() |  |
    | Total cost | `TotalCost` |  | 100 | renderer() |  |

- **column** · store `OperationProductsStore` · placeholder `You do not have any finished products yet.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `ProductSku` |  | flex 2 | renderer() |  |
    | Unit of measure | `Unit` |  | 100 | renderer() |  |
    | Sales Value | `PriceTier` | number column | flex 1 | renderer() |  |
    | Sales Value per unit | `Ratio` | number column | flex 1 | renderer() |  |
    | Estimated cost per unit | `Cost` | number column | flex 1 | renderer() |  |
    | Estimated total cost | `TotalCost` | number column | flex 1 | renderer() |  |

- **column** · store `WastageProductsStore` · placeholder `You do not have any finished products or input/output components yet.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `ProductSku` |  | flex 2 | renderer() |  |
    | Fixed price | `WastageCost` | number column | flex 1 | renderer() |  |
    | Cost per unit | `WastageCost` | number column | flex 1 | renderer() |  |

- **component** · id `cmpId` · renders into `renderTo` · store `localStore` · shows `name` · value `value` · placeholder `Choose...` · pick-only
- **column** “{attrSet.name}” · field `"CustomField".concat(…)`

### `ProductFamilyList2019`

1 grids · 0 standalone fields · 0 windows · 0 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `ProductFamilyList_Index_Container` · store `mainStore` · placeholder `You do not have any product families at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    |  | `ImageID` |  | 60 | renderer() |  |
    | SKU | `SKU` |  | flex 1 | renderer() |  |
    | Family name | `Name` |  | flex 2 | renderer() |  |
    | Category | `Category` |  | flex 1 | renderer() |  |
    | Brand | `Brand` |  | flex 1 | renderer() |  |
    | Products in the family | `ProductCount` |  | 150 |  |  |
    |  | `` |  | flex 1 | renderer() | hidden |


### `RecallReport2019`

4 grids · 2 standalone fields · 0 windows · 1 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `divOnHandLines` · store `pRecallOnHandStore` · placeholder `No products to display.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Location | `Location` |  | flex 1 | renderer() |  |
    | Product | `ProductCode` |  | flex 2 | renderer() |  |
    | Batch/serial no. | `BatchSN` |  | flex 1 | renderer() |  |
    | Expiry date | `ExpiryDate` |  | flex 1 | renderer() |  |
    | On hand | `OnHand` |  | flex 1 |  |  |
    | Allocated | `Allocated` |  | flex 1 |  |  |
    | In transit | `InTransit` |  | flex 1 |  |  |
    | In WIP | `InWIP` |  | flex 1 |  |  |

- **grid** · renders into `divSupplierLines` · store `pRecallSuppliersStore` · placeholder `No suppliers to display.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Supplier | `Supplier` |  | flex 2 | renderer() |  |
    | Phone | `Phone` |  | flex 1 | renderer() |  |
    | Email | `Email` |  | flex 1 | renderer() |  |
    | Task | `Number` |  | flex 1 | renderer() |  |
    | Product | `ProductCode` |  | flex 2 | renderer() |  |
    | Batch/serial no. | `BatchSN` |  | flex 1 | renderer() |  |
    | Expiry date | `ExpiryDate` |  | flex 1 | renderer() |  |
    | Quantity | `Quantity` |  | flex 1 |  |  |

- **grid** · renders into `divCustomerLines` · store `pRecallCustomersStore` · placeholder `No customers to display.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Customer | `Customer` |  | flex 2 | renderer() |  |
    | Phone | `Phone` |  | flex 1 | renderer() |  |
    | Email | `Email` |  | flex 1 | renderer() |  |
    | Address line 1 | `CustomerAddressLine1` |  | flex 2 | renderer() |  |
    | Address line 2 | `CustomerAddressLine2` |  | flex 1 | renderer() |  |
    | Task | `Number` |  | flex 1 | renderer() |  |
    | SKU | `ProductCode` |  | flex 2 | renderer() |  |
    | Batch/serial no. | `BatchSN` |  | flex 1 | renderer() |  |
    | Expiry date | `ExpiryDate` |  | flex 1 | renderer() |  |
    | Quantity | `Quantity` |  | flex 1 |  |  |

- **grid** · renders into `divUsedInLines` · store `pRecallUsedInStore` · placeholder `No products to display.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Task | `TaskID` |  | flex 2 | renderer() |  |
    | Product | `ProductCode` |  | flex 2 | renderer() |  |
    | Batch/serial no. | `BatchSN` |  | flex 1 | renderer() |  |
    | Expiry date | `ExpiryDate` |  | flex 1 | renderer() |  |
    | Quantity | `Quantity` |  | flex 1 |  |  |
    | Unit | `Unit` |  | flex 1 | renderer() |  |


#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| checkbox |  | `divShowRelated` | `` |  |
| combo |  | `tdProduct` | `vProductStore` | shows `Name` · value `CardID` · placeholder `Choose...` |

#### Menus, buttons and other parts

- **button** “{Name}” · id `"Print".concat(…)` · on click `handler()`

### `Stock2019`

6 grids · 0 standalone fields · 0 windows · 2 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `divRemaining` · placeholder `Click the 'Add more items' button to add a new adjustment`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `ProductCode` |  | flex 2 | renderer() | total count |
    | Batch/serial no. | `BatchSN` |  | flex 1 | renderer() |  |
    | Expiry date | `ExpiryDate` |  | flex 1 | renderer() |  |
    | Unit | `UnitOfMeasure` |  | flex 1 | renderer() |  |
    | Location | `LocationID` |  | flex 1 | renderer() |  |
    | On hand | `QuantityOnHand` |  | flex 1 |  |  |
    | Available | `Available` |  | flex 1 |  |  |
    | New quantity | `Adjustment` |  | flex 1 |  |  |
    | Variance | `Adjustment` |  | flex 1 | renderer() |  |
    | Comments | `Comments` |  | flex 1 | renderer() |  |

- **grid** · renders into `divNoStock` · placeholder `Click the 'Add more items' button to add a new adjustment to zero sto…`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Location | `LocationID` |  | flex 1 | renderer() |  |
    | Product | `ProductCode` |  | flex 2 | renderer() |  |
    | Batch/serial no. | `BatchSN` |  | flex 1 | renderer() |  |
    | Expiry date | `ExpiryDate` | date column | flex 1 | renderer() · edit: date field |  |
    | Unit | `UnitOfMeasureName` |  | flex 1 | renderer() |  |
    | Quantity | `Quantity` |  | flex 1 |  |  |
    | Unit cost | `UnitCost` |  | flex 1 |  |  |
    | Comments | `Comments` |  | flex 1 | renderer() |  |
    | Received date | `ReceivedDate` | date column | flex 1 | renderer() · edit: date field |  |

- **grid** · renders into `Stock_Index_Container` · store `mainStore` · placeholder `You do not have any products matching the specified criteria.`
- **grid** · renders into `AllocatedGrid_Container` · store `vProductsStockAllocatedStore`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Task no. | `Number` |  | flex 1 | renderer() |  |
    | Customer | `CustomerName` |  | flex 2 | renderer() |  |
    | Quantity | `Quantity` |  | flex 1 |  |  |
    | Date | `Date` | date column | flex 1 | renderer() |  |
    |  | `` |  | flex 1 | renderer() | hidden |

- **grid** · renders into `OnOrderGrid_Container` · store `vProductsStockOnOrderStore`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Order | `Number` |  | flex 1 | renderer() |  |
    | Supplier | `SupplierName` |  | flex 2 | renderer() |  |
    | Date | `Date` | date column | flex 1 | renderer() |  |
    | Required by | `RequiredByDate` | date column | flex 1 | renderer() |  |
    | Quantity | `Quantity` |  | flex 1 |  |  |
    | Next delivery | `NextDeliveryDate` | date column | flex 1 | renderer() |  |
    |  | `` |  | flex 1 | renderer() | hidden |

- **grid** · renders into `InTransitGrid_Container` · store `vProductsStockInTransitStore`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Order | `Number` |  | flex 1 | renderer() |  |
    | Supplier | `SupplierName` |  | flex 2 | renderer() |  |
    | Date | `Date` | date column | flex 1 | renderer() |  |
    | Required by | `RequiredByDate` | date column | flex 1 | renderer() |  |
    | Quantity | `Quantity` |  | flex 1 |  |  |
    | Next delivery | `NextDeliveryDate` | date column | flex 1 | renderer() |  |
    |  | `` |  | flex 1 | renderer() | hidden |


#### Menus, buttons and other parts

- **column** “{_renderHeader(…)}” · field `InventoroWin` · itemId `id` · id `id`
- **column** “{_renderHeader(…)}” · field `InventoroStockout` · itemId `id` · id `id`

### `StockAdjustment2019`

7 grids · 7 standalone fields · 0 windows · 12 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `divRealDimensions` · store `window.AccountingDimensionsRealTempStore` · placeholder `emptyMsgText`
- **grid** · renders into `divAttachmentList` · store `StockAttachmentsStore` · placeholder `You do not have any files attached.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Name | `FileName` |  | flex 2 | renderer() |  |
    | Date | `Date` |  | flex 1 | renderer() |  |
    | Attached by | `UserName` |  | flex 2 | RenderHTMLText |  |
    | Processed | `IsProcessed` | check column | 80 | renderer() |  |

- **grid** · renders into `divRemaining` · placeholder `Click the 'Add more items' button to add a new adjustment`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `ProductCode` |  | flex 2 | renderer() | total count |
    | Batch/serial no. | `BatchSN` |  | flex 1 | renderer() |  |
    | Expiry date | `ExpiryDate` |  | flex 1 | renderer() |  |
    | Unit | `UnitOfMeasure` |  | flex 1 | renderer() |  |
    | Location | `LocationID` |  | flex 1 | renderer() |  |
    | On hand | `QuantityOnHand` |  | flex 1 |  |  |
    | Available | `Available` |  | flex 1 |  |  |
    | New quantity | `Adjustment` |  | flex 1 |  |  |
    | Variance | `Adjustment` |  | flex 1 | renderer() |  |
    | Comments | `Comments` |  | flex 1 | renderer() |  |

- **grid** · renders into `divNoStock` · placeholder `Click the 'Add more items' button to add a new adjustment to zero sto…`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Location | `LocationID` |  | flex 1 | renderer() |  |
    | Product | `ProductCode` |  | flex 2 | renderer() |  |
    | Batch/serial no. | `BatchSN` |  | flex 1 | renderer() |  |
    | Expiry date | `ExpiryDate` | date column | flex 1 | renderer() · edit: date field |  |
    | Unit | `UnitOfMeasureName` |  | flex 1 | renderer() |  |
    | Quantity | `Quantity` |  | flex 1 |  |  |
    | Unit cost | `UnitCost` |  | flex 1 |  |  |
    | Comments | `Comments` |  | flex 1 | renderer() |  |
    | Received date | `ReceivedDate` | date column | flex 1 | renderer() · edit: date field |  |

- **grid** · renders into `divTDetails` · store `TransactionsStore` · placeholder `No transactions created.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Effective date | `EffectiveDate` |  | flex 1 | renderer() |  |
    | Debit | `Debit` |  | flex 1 | Common_COA_TreeMode_RestoreDisplayName |  |
    | Credit | `Credit` |  | flex 1 | Common_COA_TreeMode_RestoreDisplayName |  |
    | Amount | `Amount` |  | 130 | renderer() |  |

- **grid** · renders into `ImportLinesExceptionsGrid` · store `UploadLinesErrorsStore` · placeholder `Please upload a file to check for issues.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Line # | `Line` |  | 50 |  |  |
    | Line type | `LineType` |  | 80 | renderer() |  |
    | Location | `Location` |  | 120 | renderer() |  |
    | SKU | `SKU` |  | 150 | renderer() |  |
    | Product name | `Name` |  | 250 | renderer() |  |
    | Bin | `Bin` |  | 100 | renderer() |  |
    | Batch S/N | `BatchSerialNumber` |  | 100 | renderer() |  |
    | Quantity | `Quantity` |  | 120 | renderer() |  |
    | Unit cost | `UnitCost` |  | 120 | renderer() |  |
    | Expiry date | `ExpiryDate_YYYYMMDD` |  | 120 | renderer() |  |
    | Comments | `Comments` |  | 120 | renderer() |  |
    | Received date | `ReceivedDate_YYYYMMDD` |  | flex 1 | renderer() |  |

- **grid** · renders into `divScanProductSelection` · store `storeScanProduct`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `ProductCode` |  | flex 2 | renderer() |  |
    | Batch/serial # | `BatchSN` |  | flex 1 | renderer() |  |
    | Expiry date | `ExpiryDate` |  | flex 1 | renderer() |  |


#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| date field |  | `WorkflowModal_dtWorkflowDate` | `` | format `UserDateFormat` |
| date field |  | `tdEffectiveDate` | `` | placeholder `Choose...` · format `UserDateFormat` |
| text field |  | `tdCustomerReference` | `` |  |
| combo |  | `liCostType` | `window.CostTypeStore` | shows `CostTypeName` · value `CostType` · pick-only |
| combo |  | `tdScanLocation` | `vTenantLocationLoadStore` | shows `Description` · value `LocationID` · placeholder `Choose...` |
| text field |  | `tdScanPackBox` | `` | placeholder `Choose...` |
| text field |  | `tdScanPackBoxInventory` | `` | placeholder `Choose...` |

#### Menus, buttons and other parts

- **column** “Entity” · field `EntityType` · id `colRealDimensionsEntity`
- **column** “Account” · field `AccountCode` · id `colRealDimensionsAccount`
- **column** “Amount” · field `Amount` · id `colRealDimensionsAmount`
- **column** “Reference number” · field `ReferenceNumber` · id `colRealDimensionsReferenceNumber`
- **column** “Effective date” · field `EffectiveDate` · id `colRealDimensionsDate`
- **column** “Product” · field `ProductCode` · id `colRealDimensionsProduct`
- **column** “Supplier \| Customer” · field `"".concat(…)` · id `"colRealDimensions".concat(…)`
- **column** “{attr}” · field `attr.replace(…)` · id `"col".concat(…)`
- **component** · renders into `tdAccount` · store `AccountStore` · shows `DisplayName` · value `Code` · placeholder `Choose...`
- **text area** · renders into `tdComment` · placeholder `Write your comment here...`
- **component** · renders into `tdScanQuantity` · required
- **text area** · renders into `divInventoryModeBarcodes` · placeholder `Enter your barcodes here...`

### `StockAdjustmentList2019`

1 grids · 0 standalone fields · 0 windows · 0 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `StockAdjustmentContainer` · store `parentStore` · placeholder `You do not have any stock adjustments and stocktakes.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    |  | `` |  | flex 1 | renderer() | hidden |
    | Number | `StocktakeNumber` |  | flex 1 | renderer() |  |
    | Type | `Type` |  | 150 | renderer() |  |
    | Location | `Location` |  | flex 1 | renderer() |  |
    | Date | `LastUpdatedDate` | date column | 120 | renderer() |  |
    | Status | `Status` |  | 120 |  |  |
    | Created by | `LastUpdatedBy` |  | flex 1 | renderer() |  |
    | Reference | `CustomerReference` |  | flex 1 | renderer() |  |


### `StockTransfer2019`

11 grids · 12 standalone fields · 0 windows · 17 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `divRealDimensions` · store `window.AccountingDimensionsRealTempStore` · placeholder `emptyMsgText`
- **grid** · renders into `divAttachmentList` · store `StockAttachmentsStore` · placeholder `You do not have any files attached.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Name | `FileName` |  | flex 2 | renderer() |  |
    | Date | `Date` |  | flex 1 | renderer() |  |
    | Attached by | `UserName` |  | flex 2 | RenderHTMLText |  |
    | Processed | `IsProcessed` | check column | 80 | renderer() |  |

- **grid** · renders into `StockTransfer_Index_Content` · placeholder `You do not have any products.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `ProductCode` |  | flex 2 | renderer() |  |
    | Batch/serial no. | `BatchSN` |  | flex 1 | renderer() |  |
    | Expiry date | `ExpiryDate` |  | flex 1 | renderer() |  |
    | Unit | `UnitName` |  | flex 1 | RenderHTMLText |  |
    | Location | `Location` |  | flex 1 | renderer() |  |
    | On hand | `QuantityOnHand` |  | flex 1 |  |  |
    | Available | `QuantityAvailable` |  | flex 1 |  |  |
    | Transfer quantity | `TransferQuantity` |  | flex 1 | renderer() |  |
    | Comments | `Comments` |  | flex 1 | renderer() |  |

- **grid** · renders into `divManualJournalsLines` · placeholder `Enter manual journals to distribute additional costs associated with …`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    |  | `ID` |  | flex 1 | renderer() | hidden |
    | Debit | `Debit` |  | flex 1 | renderer() |  |
    | Credit | `Credit` |  | flex 1 | renderer() |  |
    | Reference | `Reference` |  | flex 1 | renderer() |  |
    | Date | `Date` | date column | flex 1 | edit: date field |  |
    | Amount | `Amount` |  | flex 1 | renderer() |  |

- **grid** · renders into `divTDetails` · store `TransactionsStore` · placeholder `No transactions created for this stock transfer.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Description | `Description` |  | flex 2 | RenderHTMLText |  |
    | Effective date | `EffectiveDate` |  | flex 1 | renderer() |  |
    | Debit | `Debit` |  | flex 1 | Common_COA_TreeMode_RestoreDisplayName |  |
    | Credit | `Credit` |  | flex 1 | Common_COA_TreeMode_RestoreDisplayName |  |
    | Amount | `Amount` |  | 130 | DEARMoneyFormat |  |

- **grid** · renders into `ImportLinesExceptionsGrid` · store `UploadLinesErrorsStore` · placeholder `Please upload a file to check for issues.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Line # | `Line` |  | 50 |  |  |
    | SKU | `SKU` |  | 150 | renderer() |  |
    | Product name | `Name` |  | 250 | renderer() |  |
    | Batch S/N | `BatchSerialNumber` |  | 100 | renderer() |  |
    | Transfer quantity | `TransferQuantity` |  | 120 | renderer() |  |
    | Expiry date | `ExpiryDate_YYYYMMDD` |  | 120 | renderer() |  |
    | Location | `Location` |  | 100 | renderer() |  |
    | Comments | `Comments` |  | 120 | renderer() |  |

- **grid** · renders into `StockTransfer_PutAway_Content` · placeholder `You do not have any products.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `ProductCode` |  | flex 2 | renderer() |  |
    | Batch/serial no. | `BatchSN` |  | flex 1 | renderer() |  |
    | Expiry date | `ExpiryDate` |  | flex 1 | renderer() |  |
    | Unit | `UnitName` |  | flex 1 | RenderHTMLText |  |
    | Location | `Location` |  | flex 1 | renderer() |  |
    | Received quantity | `ReceivedQuantity` |  | flex 1 | renderer() |  |

- **grid** · renders into `divScanProductSelection` · store `storeScanProduct`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `ProductCode` |  | flex 2 | renderer() |  |
    | Batch/serial # | `BatchSN` |  | flex 1 | renderer() |  |
    | Expiry date | `ExpiryDate` |  | flex 1 | renderer() |  |
    | Location | `Location` |  | flex 1 | renderer() |  |

- **grid** · renders into `StockTransfer_Order_Content` · placeholder `You do not have any order products.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `ProductCode` |  | flex 2 | renderer() |  |
    | Unit | `UnitName` |  | flex 1 | RenderHTMLText |  |
    | On hand | `OnHandQuantity` |  | flex 1 | renderer() |  |
    | Available | `AvailableQuantity` |  | flex 1 | renderer() |  |
    | Quantity | `Quantity` |  | flex 1 | renderer() |  |
    | Comments | `Comments` |  | flex 1 | renderer() |  |

- **grid** · renders into `ImportOrderLinesExceptionsGrid` · store `UploadOrderLinesErrorsStore` · placeholder `Please upload a file to check for issues.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Line # | `Line` |  | 50 |  |  |
    | SKU | `SKU` |  | 150 | renderer() |  |
    | Product name | `Name` |  | 250 | renderer() |  |
    | Quantity | `Quantity` |  | 120 | renderer() |  |
    | Comments | `Comments` |  | 120 | renderer() |  |

- **grid** · renders into `divManualJournalsDistributedCostLines` · placeholder `Enter manual journals to distribute additional costs associated with …`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `ProductID` |  | flex 1 | renderer() |  |
    | Product total | `Total` |  | 200 | renderer() | total sum |
    | Manual journal cost | `DistributedCost` |  | 200 | renderer() | total sum |


#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| date field |  | `WorkflowModal_dtWorkflowDate` | `` | format `UserDateFormat` |
| combo |  | `tdFrom` | `vTenantLocationStore` | shows `Description` · value `LocationID` · placeholder `Choose...` |
| combo |  | `tdTo` | `vTenantLocationSecondStore` | shows `Description` · value `LocationID` · placeholder `Choose...` |
| text field |  | `tdCustomerReference` | `` |  |
| date field |  | `tdDepartureDate` | `` | placeholder `Choose...` · format `UserDateFormat` |
| date field |  | `tdRequiredBy` | `` | placeholder `Choose...` · format `UserDateFormat` |
| date field |  | `tdCompletionDate` | `` | placeholder `Choose...` · format `UserDateFormat` |
| checkbox |  | `chkSkipOrder` | `` |  |
| checkbox |  | `chkUsePutAway` | `` |  |
| combo |  | `tdCostDistributionType` | `CostDistributionTypeStore` | shows `Name` · value `Value` · pick-only |
| text field |  | `tdScanPackBox` | `` | placeholder `Choose...` |
| text field |  | `tdScanPackBoxInventory` | `` | placeholder `Choose...` |

#### Menus, buttons and other parts

- **column** “Entity” · field `EntityType` · id `colRealDimensionsEntity`
- **column** “Account” · field `AccountCode` · id `colRealDimensionsAccount`
- **column** “Amount” · field `Amount` · id `colRealDimensionsAmount`
- **column** “Reference number” · field `ReferenceNumber` · id `colRealDimensionsReferenceNumber`
- **column** “Effective date” · field `EffectiveDate` · id `colRealDimensionsDate`
- **column** “Product” · field `ProductCode` · id `colRealDimensionsProduct`
- **column** “Supplier \| Customer” · field `"".concat(…)` · id `"colRealDimensions".concat(…)`
- **column** “{attr}” · field `attr.replace(…)` · id `"col".concat(…)`
- **component** · renders into `_self.names.cmbFamily` · store `_self.familyStore` · shows `Name` · value `ID`
- **component** · renders into `_self.names.cmbBaseOption` · store `_self.familyOptionStore` · shows `name` · value `name` · pick-only
- **component** · renders into `_self.names.cmbBaseOptionValue` · store `_self.familyBaseOptionValueStore` · shows `name` · value `name` · pick-only
- **FamilyMatrix_Option** · name `optionName`
- **FamilyMatrix_Value** · name `item`
- **text area** · renders into `tdComment` · placeholder `Write your comment here...`
- **component** · renders into `tdAccount` · store `AssetAccountsStore` · shows `DisplayName` · value `Code` · placeholder `Choose...`
- **component** · renders into `tdScanQuantity` · required
- **text area** · renders into `divInventoryModeBarcodes` · placeholder `Enter your barcodes here...`

### `Stocktake2019`

8 grids · 14 standalone fields · 0 windows · 12 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `divRealDimensions` · store `window.AccountingDimensionsRealTempStore` · placeholder `emptyMsgText`
- **grid** · renders into `divAttachmentList` · store `StockAttachmentsStore` · placeholder `You do not have any files attached.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Name | `FileName` |  | flex 2 | renderer() |  |
    | Date | `Date` |  | flex 1 | renderer() |  |
    | Attached by | `UserName` |  | flex 2 | RenderHTMLText |  |
    | Processed | `IsProcessed` | check column | 80 | renderer() |  |

- **grid** · renders into `divRemaining` · store `storeExisting` · placeholder `Click start to view existing stock.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `ProductCode` |  | flex 2 | renderer() |  |
    | Bin | `LocationID` |  | flex 1 | renderer() |  |
    | Batch/serial no. | `BatchSN` |  | flex 1 | renderer() |  |
    | Expiry date | `ExpiryDate` |  | flex 1 | renderer() |  |
    | Unit | `UnitOfMeasureName` |  | flex 1 | renderer() |  |
    | Quantity on hand | `QuantityOnHand` |  | flex 1 |  |  |
    | Stocktake quantity | `Adjustment` |  | flex 1 |  |  |
    | Variance | `Adjustment` |  | flex 1 | renderer() |  |

- **grid** · renders into `divNoStock` · placeholder `No products added to new stock.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `ProductCode` |  | flex 2 | renderer() |  |
    | Bin | `LocationID` |  | flex 1 | renderer() |  |
    | Batch/serial no. | `BatchSN` |  | flex 1 | renderer() |  |
    | Expiry date | `ExpiryDate` | date column | flex 1 | renderer() · edit: date field |  |
    | Unit | `UnitOfMeasureName` |  | flex 1 | renderer() |  |
    | Quantity | `Quantity` |  | flex 1 |  |  |
    | Unit cost | `UnitCost` |  | flex 1 |  |  |
    | Received date | `ReceivedDate` | date column | flex 1 | renderer() · edit: date field |  |

- **grid** · renders into `divTDetails` · store `TransactionsStore` · placeholder `No transactions created.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Effective date | `EffectiveDate` |  | flex 1 | renderer() |  |
    | Debit | `Debit` |  | flex 1 | Common_COA_TreeMode_RestoreDisplayName | total count |
    | Credit | `Credit` |  | flex 1 | Common_COA_TreeMode_RestoreDisplayName |  |
    | Amount | `Amount` |  | flex 1 | renderer() | total sum |

- **grid** · renders into `ImportExceptionsGrid` · store `ImportErrorsStore` · placeholder `Please upload a file to check for issues.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Line # | `Line` |  | flex 1 |  |  |
    | Product code | `ProductCode` |  | flex 1 | renderer() |  |
    | Product name | `ProductName` |  | flex 2 | renderer() |  |
    | Bin | `Bin` |  | flex 1 | renderer() |  |
    | Batch S/N | `BatchSN` |  | flex 1 | renderer() |  |
    | Quantity on hand | `QuantityOnHand` |  | flex 1 | renderer() |  |
    | Stocktake quantity | `StocktakeQuantity` |  | flex 1 | renderer() |  |
    | Expiry date | `ExpiryDate_YYYYMMDD` |  | flex 1 | renderer() |  |
    | Received date | `ReceivedDate_YYYYMMDD` |  | flex 1 | renderer() |  |

- **grid** · renders into `ImportLinesExceptionsGrid` · store `UploadLinesErrorsStore` · placeholder `Please upload a file to check for issues.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Line # | `Line` |  | flex 1 |  |  |
    | SKU | `SKU` |  | flex 1 | renderer() |  |
    | Product name | `Name` |  | flex 2 | renderer() |  |
    | Bin | `Bin` |  | flex 1 | renderer() |  |
    | Batch S/N | `BatchSerialNumber` |  | flex 1 | renderer() |  |
    | Quantity | `Quantity` |  | flex 1 | renderer() |  |
    | Unit cost | `UnitCost` |  | flex 1 | renderer() |  |
    | Expiry date | `ExpiryDate_YYYYMMDD` |  | flex 1 | renderer() |  |

- **grid** · renders into `divProductSelection` · store `storeSearchResult`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `ProductCode` |  | flex 2 | renderer() |  |
    | Bin | `LocationID` |  | flex 1 | renderer() |  |
    | Batch/serial # | `BatchSN` |  | flex 1 | renderer() |  |
    | Expiry date | `ExpiryDate` |  | flex 1 | renderer() |  |


#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| date field |  | `WorkflowModal_dtWorkflowDate` | `` | format `UserDateFormat` |
| date field |  | `tdEffectiveDate` | `` | placeholder `Choose...` · format `UserDateFormat` |
| text field |  | `tdCustomerReference` | `` |  |
| combo |  | `tdLocation` | `vTenantLocationStore` | shows `Description` · value `LocationID` · placeholder `Choose...` |
| checkbox |  | `tdIncludeQuantityOnHand` | `` |  |
| combo |  | `Stocktake_New_Categories` | `ProductFiltersCategoriesStore` | shows `Name` · value `ID` · placeholder `Choose...` |
| combo |  | `Stocktake_New_Brands` | `ProductFiltersBrandsStore` | shows `Name` · value `ID` · placeholder `Choose...` |
| combo |  | `Stocktake_New_Tags` | `ProductFiltersTagsStore` | shows `Value` · value `Value` · placeholder `Choose...` |
| combo |  | `Stocktake_New_Bins` | `ProductFiltersBinsStore` | shows `Name` · value `ID` · placeholder `Choose...` |
| combo |  | `Stocktake_New_BinGroups` | `ProductFiltersBinGroupsStore` | shows `Name` · value `ID` · placeholder `Choose...` |
| combo |  | `Stocktake_New_StockLocators` | `ProductFiltersStockLocatorsStore` | shows `Value` · value `Value` · placeholder `Choose...` |
| combo |  | `Stocktake_New_PickZones` | `ProductFiltersPickZonesStore` | shows `Value` · value `Value` · placeholder `Choose...` |
| text field |  | `tdBatchSN` | `` | placeholder `write...` |
| date field |  | `tdExpiryDate` | `` | placeholder `Choose...` · format `UserDateFormat` |

#### Menus, buttons and other parts

- **column** “Entity” · field `EntityType` · id `colRealDimensionsEntity`
- **column** “Account” · field `AccountCode` · id `colRealDimensionsAccount`
- **column** “Amount” · field `Amount` · id `colRealDimensionsAmount`
- **column** “Reference number” · field `ReferenceNumber` · id `colRealDimensionsReferenceNumber`
- **column** “Effective date” · field `EffectiveDate` · id `colRealDimensionsDate`
- **column** “Product” · field `ProductCode` · id `colRealDimensionsProduct`
- **column** “Supplier \| Customer” · field `"".concat(…)` · id `"colRealDimensions".concat(…)`
- **column** “{attr}” · field `attr.replace(…)` · id `"col".concat(…)`
- **component** · renders into `tdAccount` · store `AccountStore` · shows `DisplayName` · value `Code` · placeholder `Choose...`
- **text area** · renders into `tdComment` · placeholder `Write your comment here...`
- **component** · renders into `tdQuantity` · required
- **text area** · renders into `divInventoryModeBarcodes` · placeholder `Enter your barcodes here...`

