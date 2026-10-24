# eBay: UI

Every component the page code builds, read from the shipped ExtJS bundles: grids with their columns, fields, buttons, menus, windows and custom components. Labels are the English UI text. `renders into` is the id of the `<div>` in the page's server-rendered HTML that the component mounts in; `store` names the data store (see the endpoints in [README.md](README.md)); `on click` is the handler. Visual system and shell layout: [docs/UI.md](../../../docs/UI.md).

## Screens

| Route | Title | Bundles |
|---|---|---|
| `/eBayNG` | eBay | [`eBay2019`](#ebay2019) |

## Components by bundle

### `eBay2019`

15 grids · 45 standalone fields · 0 windows · 8 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `overviewSalesGridContainer` · store `overviewSalesStore` · placeholder `No sales yet.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    |  | `Status` |  | flex 1 | renderer() |  |
    | Number | `SaleOrderNumber` |  | 130 | renderer() |  |
    | Date | `SaleOrderDate` |  | 130 | renderer() |  |
    | Customer | `CustomerName` |  | flex 3 | RenderHTMLText |  |
    | Amount | `PaidTotalAmount` |  | flex 1 | renderer() |  |

- **grid** · renders into `overviewCustomersGridContainer` · store `overviewCustomersStore` · placeholder `No customers yet.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Customer | `Name` |  | flex 3 | renderer() |  |
    | Sales | `OrderCount` |  | 100 |  |  |
    | Amount | `PaidTotalAmount` |  | flex 1 | renderer() |  |

- **grid** · renders into `dearCatalogGridContainer` · store `productToListStore` · placeholder `There are no products available to be published.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `Name` |  | flex 4 | renderer() |  |
    | Status | `Status` |  | 120 | renderer() |  |
    | Quantity | `Quantity` |  | 100 | renderer() |  |
    | Price | `Price` |  | 100 | renderer() |  |

- **grid** · renders into `dearSelectedCatalogGridContainer` · store `selectedProductsToListStore` · placeholder `There are no selected products.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    |  | `Selected` | check column | 48 | renderer() |  |
    | Product | `Name` |  | flex 3 | renderer() |  |
    | SKU | `SKU` |  | flex 1 | renderer() |  |
    | Price | `Price` |  | 80 | renderer() |  |
    | Publishing profile | `LProfile` |  | flex 2 | renderer() |  |

- **grid** · renders into `ebayListingProfilesContainer` · store `vListingProfileStore` · placeholder `There are no profiles created yet..`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | eBay category | `CategoryName` |  | flex 3 | renderer() |  |
    | Profile name | `Name` |  | flex 1 |  |  |

- **grid** · renders into `failedPublishGridContainer` · store `productToListFailedStore` · placeholder `There are no error messages..`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product/ variation | `Name` |  | flex 5 | renderer() |  |
    | Publishing profile | `ProfileName` |  | flex 2 |  |  |
    | Message | `Result` |  | flex 6 | renderer() |  |

- **grid** · renders into `Ebay_LProfile_ListingsSpecifics_Grid` · store `ListingsSpecificsStore`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    |  | `Name` |  | flex 1 | renderer() |  |
    | Constant value | `Value` |  | flex 1 | renderer() |  |
    | ...or value of a product attribute | `MappedField` |  | flex 1 | renderer() |  |

- **grid** · renders into `Ebay_LProfile_ItemSpecifics_Grid` · store `ItemSpecificsStore`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    |  | `Name` |  | flex 1 | renderer() |  |
    | Constant value | `Value` |  | flex 1 |  |  |
    | ...or value of a product attribute | `MappedField` |  | flex 1 | renderer() |  |

- **grid** · renders into `catalogGridContainer` · store `productStore` · placeholder `There are no products in the catalog.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | SKU | `SKU` |  | flex 1 | renderer() |  |
    | Name | `Name` |  | flex 1 | renderer() |  |
    | Category | `Category` |  | flex 1 | renderer() |  |
    | Status | `Status` |  | 120 | renderer() |  |
    | Linked product | `ProductID` |  | flex 2 | renderer() |  |
    | Quantity | `Quantity` |  | 100 | renderer() |  |
    | Price | `Price` |  | flex 1 | renderer() |  |

- **grid** · renders into `EbayNG_Catalog_FamilyMappingGrid` · store `variationStore` · placeholder `There are no variations.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    |  | `Status` | action column | 65 | renderer() |  |
    | eBay product | `SKU` |  | flex 4 | renderer() |  |
    | Price | `Price` |  | flex 1 | renderer() |  |
    | Option 1 | `Option1` |  | flex 1 | renderer() |  |
    | Option 2 | `Option2` |  | flex 1 | renderer() |  |
    | Option 3 | `Option3` |  | flex 1 | renderer() |  |
    | Linked product | `ProductID` |  | flex 4 | renderer() |  |

- **grid** · renders into `divTaxMapping` · store `vEcsTaxMappingStore` · placeholder `Loading eBay taxes rates...`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Type | `Description` |  | flex 1 |  |  |
    | Tax rule | `TaxRuleName` |  | flex 1 | renderer() |  |

- **grid** · renders into `divPaymentProcessorMapping` · store `vEcsPaymentProcessorMappingStore` · placeholder `Loading eBay payment methods...`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Name | `PaymentProcessorName` |  | flex 1 |  |  |
    | Payment account code | `LedgerAccount` |  | flex 1 | renderer() |  |

- **grid** · renders into `divPendingOrdersGrid` · store `pendingOrdersStore` · placeholder `You do not have any pending eBay orders at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Order # | `OrderNumber` |  | 100 | renderer() |  |
    | Date | `DateCreated` | date column | 120 | renderer() |  |
    | Customer | `CustomerName` |  | flex 1 | renderer() |  |
    | Product | `Name` |  | flex 2 | renderer() |  |
    | Quantity | `Quantity` |  | 100 |  |  |
    | Total | `Total` |  | flex 1 | renderer() |  |

- **grid** · renders into `logGridContainer` · store `logStore` · placeholder `You do not have any captured eBay orders at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Invoice # | `OrderNumber` |  | flex 1 | RenderHTMLText |  |
    | Date | `Date` | date column | flex 1 | renderer() |  |
    | Download date | `DownloadDate` | date column | flex 1 | renderer() |  |
    | Process date | `ProcessDate` | date column | flex 1 | renderer() |  |
    | Status | `Status` |  | flex 1 | renderer() |  |
    | Type | `Type` |  | flex 1 | renderer() |  |
    | Sale task | `SaleOrderNumber` |  | flex 1 | renderer() |  |

- **grid** · renders into `operationsLogGridContainer` · store `operationsLogStore` · placeholder `No entries found. Please hit refresh or change the search criteria.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Date | `Date` | date column | flex 1 | renderer() |  |
    | Type | `Type` |  | 100 | renderer() |  |
    | User | `UserName` |  | flex 1 | renderer() |  |
    | Category | `Category` |  | flex 1 | renderer() |  |
    | Processed | `Processed` | check column | 100 | renderer() |  |
    | Description | `Description` |  | flex 2 | renderer() |  |


#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| text field |  | `` | `` | placeholder `Type a price...` |
| combo |  | `` | `vListingProfileStore` | shows `Name` · value `id` · placeholder `Select a profile...` |
| combo |  | `Ebay_LProfile_Currency` | `EbayCurrencyStore` | shows `Description` · value `Name` · placeholder `Select currency` · pick-only |
| combo |  | `Ebay_LProfile_Country` | `EbayCountryStore` | shows `Description` · value `Name` · pick-only |
| combo |  | `Ebay_LProfile_ReturnPolicy_Returns` | `ReturnPolicy_ReturnsStore` | shows `Description` · value `Name` · pick-only |
| combo |  | `Ebay_LProfile_ReturnPolicy_Refunds` | `ReturnPolicy_RefundStore` | shows `Description` · value `Name` · pick-only |
| combo |  | `Ebay_LProfile_ReturnPolicy_ReturnsWithin` | `ReturnPolicy_ReturnsWithinStore` | shows `Description` · value `Name` · pick-only |
| combo |  | `Ebay_LProfile_ReturnPolicy_RestockingFee` | `ReturnPolicy_RestockingFeeStore` | shows `Description` · value `Name` · pick-only |
| combo |  | `Ebay_LProfile_ReturnPolicy_ShippingCost` | `ReturnPolicy_ShippingCostStore` | shows `Description` · value `Name` · pick-only |
| combo |  | `Ebay_LProfile_DomesticPostage_HandlingTime` | `HandlingTimeStore` | shows `Description` · value `Name` · pick-only |
| combo |  | `Ebay_LProfile_DomesticPostage_ShipType` | `DomesticShipTypeStore` | shows `Description` · value `ID` · pick-only |
| combo |  | `Ebay_LProfile_InternationalPostage_ShipType` | `InternationalShipTypeStore` | shows `Description` · value `ID` · pick-only |
| number field |  | `Ebay_LProfile_DomesticPostage_HandlingCost` | `` | placeholder `0.00` · required |
| number field |  | `Ebay_LProfile_InternationalPostage_HandlingCost` | `` | required |
| number field |  | `Ebay_LProfile_DomesticPostage_ShipService_Cost` | `` | placeholder `0.00` · required |
| number field |  | `Ebay_LProfile_InternationalPostage_ShipService_Co…` | `` | placeholder `0.00` · required |
| number field |  | `Ebay_LProfile_Package_DimensionsX` | `` | placeholder `Depth` |
| number field |  | `Ebay_LProfile_Package_DimensionsY` | `` | placeholder `Length` · required |
| number field |  | `Ebay_LProfile_Package_DimensionsZ` | `` | placeholder `Width` · required |
| number field |  | `Ebay_LProfile_Package_WeightMajor` | `` | placeholder `` |
| number field |  | `Ebay_LProfile_Package_WeightMinor` | `` | placeholder `` |
| combo |  | `Ebay_LProfile_Package_UOM` | `MeasurementUOMStore` | shows `Description` · value `Name` · pick-only |
| combo |  | `Ebay_LProfile_DomesticPostage_ShipService` | `DomesticShipServiceStore` | shows `DisplayName` · value `ShippingServiceID` · pick-only |
| combo |  | `Ebay_LProfile_InternationalPostage_ShipService` | `InternationalShipServiceStore` | shows `Description` · value `ShippingServiceID` · pick-only |
| combo |  | `Ebay_LProfile_Package_Type` | `PackageTypeStore` | shows `Description` · value `PackageID` · pick-only |
| combo |  | `Ebay_LProfile_Subtitle` | `DEARMappingModelStore` | shows `Description` · value `FieldName` · pick-only |
| combo |  | `EbayNG_CatalogManagment_LinkToProduct` | `ProductChooseStore` | shows `Name` · value `ProductCode` |
| combo |  | `EbayNG_CatalogManagment_LinkToFamily` | `FamilyChooseStore` | shows `Name` · value `FamilyID` · placeholder `Do not link eBay product` |
| date field |  | `EbayNG_FromOrders` | `` | placeholder `Choose...` · format `UserDateFormat` |
| combo |  | `EBayNG_Editor_RevenueAccount` | `RevenueAccountStore` | shows `DisplayName` · value `Code` · placeholder `Choose...` |
| text field |  | `EBayNG_Editor_CustomSalesRepresentative` | `` | placeholder `write...` |
| combo |  | `EbayNG_Index_ConsolidationType` | `ConsolidationTypeStore` | shows `description` · value `type` · pick-only |
| combo |  | `EbayNG_Index_ConsolidationTime` | `vTimeStore` | shows `Name` · value `Value` · pick-only |
| combo |  | `EbayNG_Index_Customer` | `vCustomerStore` | shows `Name` · value `CustomerID` · placeholder `Choose...` |
| combo |  | `EbayNG_Index_ProductLaunchYear` | `ProductLaunchYearStore` | shows `name` · value `value` · placeholder `Select year` · pick-only |
| combo |  | `EbayNG_Editor_PrimaryPriceTier` | `vSalesPriceTiersStore` | shows `Name` · value `Code` · placeholder `Choose...` · pick-only |
| combo |  | `EbayNG_Editor_AutoFulfilmentMode` | `AutoFulfilmentModeStore` | shows `name` · value `value` · placeholder `Choose...` · pick-only |
| combo |  | `EbayNG_Editor_InvoiceStatus` | `InvoiceStatusStore` | shows `name` · value `value` · placeholder `Choose...` · pick-only |
| combo |  | `EbayNG_Index_CreateAssembly` | `CreateAssemblyStore` | shows `name` · value `value` · placeholder `Choose...` · pick-only |
| combo |  | `EbayNG_Editor_Location` | `LocationStore` | shows `Description` · value `LocationID` · placeholder `Choose warehouse...` · pick-only |
| combo |  | `tdBulkListingBrand` | `vTenantBrandStore` | shows `Brand` · value `ID` · placeholder `List all brands` |
| combo |  | `tdBulkListingListedIn` | `ECommerceShopStore` | shows `ShopName` · value `ConfigID` · placeholder `Choose...` |
| date field |  | `divExportLogFrom` | `` | format `UserDateFormat` |
| date field |  | `divExportLogTo` | `` | format `UserDateFormat` |
| combo |  | `divExportLogPeriod` | `periodStore` | shows `name` · value `value` · pick-only |

#### Menus, buttons and other parts

- **button** “All” · on click `EbayNG_Index_Publish_SelectedBulkMenu_SetLProfileAll`
- **button** “Only selected” · on click `EbayNG_Index_Publish_SelectedBulkMenu_SetLProfileSelected`
- **button** “Only empty” · on click `EbayNG_Index_Publish_SelectedBulkMenu_SetLProfileOnlyForEmpty`
- **button** “Clear all” · on click `EbayNG_Index_Publish_SelectedBulkMenu_SetLProfileEmptyAll`
- **button** “All” · on click `EbayNG_Index_Publish_SelectedBulkMenu_SetPriceAll`
- **button** “Only selected” · on click `EbayNG_Index_Publish_SelectedBulkMenu_SetPriceSelected`
- **item** “Price”
- **item** “Profile”

