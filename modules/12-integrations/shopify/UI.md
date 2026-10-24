# Shopify: UI

Every component the page code builds, read from the shipped ExtJS bundles: grids with their columns, fields, buttons, menus, windows and custom components. Labels are the English UI text. `renders into` is the id of the `<div>` in the page's server-rendered HTML that the component mounts in; `store` names the data store (see the endpoints in [README.md](README.md)); `on click` is the handler. Visual system and shell layout: [docs/UI.md](../../../docs/UI.md).

## Screens

| Route | Title | Bundles |
|---|---|---|
| `/Shopify` | Shopify | [`Shopify2019`](#shopify2019) |

## Components by bundle

### `Shopify2019`

8 grids · 58 standalone fields · 0 windows · 2 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `divLocationMapping` · store `vShopifyLocationMappingStore` · placeholder `No locations loaded from Shopify`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Name | `ShopifyLocationName` |  | flex 1 | renderer() |  |
    | Location | `LocationName` |  | flex 1 | renderer() |  |

- **grid** · renders into `divTaxMapping` · store `vShopifyTaxMappingStore` · placeholder `Loading Shopify tax rates...`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Country | `Country` |  | flex 1 | RenderHTMLText |  |
    | Province | `Province` |  | flex 1 | RenderHTMLText |  |
    | Shopify tax name | `Name` |  | flex 1 | RenderHTMLText |  |
    | Tax rule | `TaxRuleName` |  | flex 1 | renderer() |  |

- **grid** · renders into `divPaymentMapping` · store `vShopifyPaymentProcessorMappingStore` · placeholder `Loading Shopify payment processors...`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Payment processor | `PaymentProcessor` |  | flex 1 | RenderHTMLText |  |
    | Payment account code | `AccountCode` |  | flex 1 | renderer() |  |

- **grid** · renders into `catalogGridContainer` · store `catalogStore` · placeholder `No products found.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `ProductCode` |  | flex 5 | renderer() |  |
    | Status | `Status` |  | 120 | renderer() |  |
    | Available stock | `Available` |  | 100 |  |  |
    | Sync quantity | `SyncQuantity` |  | 100 |  |  |
    | Buffer inventory | `SyncBufferInventory` |  | 100 |  |  |
    | Price from | `PriceTier` |  | flex 1 | renderer() |  |
    | Allow backorder | `SellOutOfStock` |  | flex 1 | renderer() |  |

- **grid** · renders into `divBulkList` · store `bulkStore` · placeholder `No products found.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `ProductCode` |  | flex 2 | renderer() |  |
    | Category | `CategoryName` |  | flex 1 | renderer() |  |
    | Status | `Status` |  | 120 | renderer() |  |
    | Available stock | `Available` |  | 100 |  |  |
    | Sync quantity | `SyncQuantity` |  | 100 |  |  |
    | Buffer inventory | `SyncBufferInventory` |  | 100 |  |  |
    | Price | `ProductID` |  | 120 | renderer() |  |
    | Ready for Shopify | `ProductID` |  | flex 1 | renderer() |  |
    | Allow backorder | `SellOutOfStock` |  | flex 1 | renderer() |  |

- **grid** · renders into `divPendingOrdersGrid` · store `pendingOrdersStore` · placeholder `You do not have any pending Shopify orders at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Order # | `OrderNumber` |  | 100 | renderer() |  |
    | Date | `InvoiceDate` | date column | 120 | renderer() |  |
    | Customer | `Contact` |  | flex 1 | renderer() |  |
    | Product | `Name` |  | flex 2 | renderer() |  |
    | Quantity | `Quantity` |  | 100 |  |  |
    | Total | `Total` |  | flex 1 | renderer() |  |

- **grid** · renders into `logGridContainer` · store `logStore` · placeholder `You do not have any captured Shopify orders at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Order # | `OrderNumber` |  | flex 1 |  |  |
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
    | Date | `Date` | date column | flex 2 | renderer() |  |
    | Type | `Type` |  | flex 1 | renderer() |  |
    | User | `UserName` |  | flex 2 | renderer() |  |
    | Category | `Category` |  | flex 2 | renderer() |  |
    | Processed | `Processed` | check column | 100 | renderer() |  |
    | Description | `Description` |  | flex 4 | renderer() |  |


#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| checkbox |  | `"Shopify_Catalog_Location".concat(…)` | `` |  |
| checkbox |  | `"Shopify_BulkList_Location".concat(…)` | `` |  |
| date field |  | `Shopify_FromOrders` | `` | placeholder `Choose...` · format `UserDateFormat` |
| date field |  | `Shopify_ProductsFromDate` | `` | placeholder `Choose...` · format `UserDateFormat` |
| date field |  | `Shopify_Index_OrderLockDate` | `` | placeholder `Choose...` · format `UserDateFormat` |
| combo |  | `Shopify_TaxMapping_State` | `USStateStore` | shows `Value` · value `Code` · placeholder `Choose...` · pick-only |
| text field |  | `Shopify_TaxMapping_County` | `` | placeholder `County` |
| text field |  | `Shopify_TaxMapping_Municipality` | `` | placeholder `City` |
| combo |  | `tdBulkCategory` | `CategoryStore` | shows `Category` · value `CategoryID` · placeholder `List all categories` |
| combo |  | `tdBulkTag` | `TagsStore` | shows `Value` · value `Value` · placeholder `List all tags` |
| combo |  | `tdBulkPriceTier` | `vSalesPriceTiersStore` | shows `Name` · value `Code` · placeholder `Choose...` · pick-only |
| combo |  | `tdBulkSellOutOfStock` | `SellOutOfStockOptionsStore` | shows `name` · value `value` · placeholder `Don't update existing setup` · pick-only |
| number field |  | `tdBulkBufferInventory` | `` | placeholder `0` |
| combo |  | `tdBulkUseBufferInventory` | `UseBufferInventoryOptionsStore` | shows `name` · value `value` · placeholder `Don’t update existing setting` · pick-only |
| combo |  | `Shopify_Index_Topic` | `TopicStore` | shows `description` · value `type` · pick-only |
| combo |  | `Shopify_Index_Master_Data_Source` | `MasterDataSourceStore` | shows `name` · value `value` · pick-only |
| combo |  | `Shopify_Index_ConsolidateOrdersLegacy` | `ConsolidationTypeStore` | shows `text` · value `value` · pick-only |
| combo |  | `Shopify_Index_ConsolidationFrequency` | `ConsolidationFrequencyStore` | shows `description` · value `value` · pick-only |
| combo |  | `Shopify_Index_PaymentReference` | `PaymentReferenceTypeStore` | shows `description` · value `type` · pick-only |
| combo |  | `Shopify_Index_ConsolidationTime` | `vTimeStore` | shows `Name` · value `Value` · pick-only |
| combo |  | `Shopify_Index_Customer` | `vCustomerStore` | shows `Name` · value `CustomerID` · placeholder `Choose...` |
| combo |  | `Shopify_Editor_PriceTier` | `vSalesPriceTiersStore` | shows `Name` · value `Code` · placeholder `Choose...` · pick-only |
| combo |  | `Shopify_Editor_CompareAtPriceTier` | `vSalesPriceTiersStore` | shows `Name` · value `Code` · placeholder `Choose...` · pick-only |
| combo |  | `Shopify_Editor_AutoShippingMode` | `AutoShippingModeStore` | shows `name` · value `value` · placeholder `Choose...` · pick-only |
| combo |  | `Shopify_Editor_InvoiceStatus` | `InvoiceStatusStore` | shows `name` · value `value` · placeholder `Choose...` · pick-only |
| combo |  | `Shopify_Index_CreateAssembly` | `CreateAssemblyStore` | shows `name` · value `value` · placeholder `Choose...` · pick-only |
| combo |  | `Shopify_Index_LiabilityAccount` | `LiabilityAccountStore` | shows `DisplayName` · value `Code` · placeholder `Choose...` · pick-only |
| combo |  | `Shopify_Index_RetailDeliveryFeeAccount` | `RetailDeliveryAccountStore` | shows `DisplayName` · value `Code` · placeholder `Choose...` · pick-only |
| combo |  | `Shopify_Index_RevenueAccount` | `RevenueAccountStore` | shows `DisplayName` · value `Code` · placeholder `Choose...` |
| text field |  | `Shopify_Index_CustomSalesRepresentative` | `` | placeholder `write...` |
| number field |  | `Shopify_Index_BufferInventory` | `` | placeholder `0` |
| combo |  | `Shopify_Index_Location` | `LocationStore` | shows `DescriptionSetupOnlineSales` · value `LocationID` · placeholder `Choose...` · pick-only |
| combo |  | `Shopify_Index_AttributeForTags` | `vSaleAttributeStore` | shows `Name` · value `Id` · placeholder `Choose...` |
| combo |  | `Shopify_Index_AttributeForType` | `vSaleAttributeStore` | shows `Name` · value `Id` · placeholder `Do not import` |
| combo |  | `Shopify_Index_PriceTier` | `vSalesPriceTiersStore` | shows `Name` · value `Code` · placeholder `Choose...` · pick-only |
| number field |  | `Shopify_Catalog_BufferInventory` | `` | placeholder `0` |
| combo |  | `tdBulkListingStatus` | `BulkListingStatusStore` | shows `Name` · value `Value` · placeholder `List all products` · pick-only |
| combo |  | `tdShopify_Chart_Period` | `ChartDatePeriodStore` | shows `name` · value `value` · pick-only |
| date field |  | `tdShopify_Chart_From` | `` | format `UserDateFormat` |
| date field |  | `tdShopify_Chart_To` | `` | format `UserDateFormat` |
| date field |  | `divFromDatePendingOrders` | `` | placeholder `From` · format `UserDateFormat` |
| date field |  | `divToDatePendingOrders` | `` | placeholder `To` · format `UserDateFormat` |
| combo |  | `tdShopify_Chart_GroupBy` | `ChartGroupByStore` | shows `name` · value `value` · pick-only |
| combo |  | `tdShopify_Chart_Type` | `ChartTypeStore` | shows `name` · value `value` · pick-only |
| date field |  | `operationsLogFromDate` | `` | placeholder `From` · format `UserDateFormat` |
| date field |  | `operationsLogToDate` | `` | placeholder `To` · format `UserDateFormat` |
| combo |  | `operationsLogTypeFilter` | `operationsLogTypeStore` | shows `text` · value `value` · placeholder `All Types` · pick-only |
| combo |  | `operationsLogCategoryFilter` | `operationsLogCategoryStore` | shows `text` · value `value` · placeholder `All Categories` · pick-only |
| combo |  | `logDateColumnFilter` | `logDateColumnStore` | shows `text` · value `value` · placeholder `Select Date Type` · pick-only |
| date field |  | `logFromDate` | `` | placeholder `From` · format `UserDateFormat` |
| date field |  | `logToDate` | `` | placeholder `To` · format `UserDateFormat` |
| combo |  | `logTypeFilter` | `logTypeStore` | shows `text` · value `value` · placeholder `All Types` · pick-only |
| combo |  | `logStatusFilter` | `logStatusStore` | shows `text` · value `value` · placeholder `All Statuses` · pick-only |
| combo |  | `tdBulkListingBrand` | `vTenantBrandStore` | shows `Brand` · value `ID` · placeholder `List all brands` |
| combo |  | `tdBulkListingListedIn` | `ECommerceShopStore` | shows `ShopName` · value `ConfigID` · placeholder `Choose...` |
| date field |  | `divExportLogFrom` | `` | format `UserDateFormat` |
| date field |  | `divExportLogTo` | `` | format `UserDateFormat` |
| combo |  | `divExportLogPeriod` | `periodStore` | shows `name` · value `value` · pick-only |

#### Menus, buttons and other parts

- **column** · field `j`
- **component** · renders into `tdBulkFamily` · store `FamilyStore` · shows `Name` · value `ID` · placeholder `List all families`

