# WooCommerce: UI

Every component the page code builds, read from the shipped ExtJS bundles: grids with their columns, fields, buttons, menus, windows and custom components. Labels are the English UI text. `renders into` is the id of the `<div>` in the page's server-rendered HTML that the component mounts in; `store` names the data store (see the endpoints in [README.md](README.md)); `on click` is the handler. Visual system and shell layout: [docs/UI.md](../../../docs/UI.md).

## Screens

| Route | Title | Bundles |
|---|---|---|
| `/WooCommerce` | WooCommerce | [`WooCommerce2019`](#woocommerce2019) |

## Components by bundle

### `WooCommerce2019`

10 grids · 45 standalone fields · 0 windows · 7 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `catalogGridContainer` · store `productStore` · placeholder `No products found.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | SKU | `ProductCode` |  | flex 1 | renderer() |  |
    | Product | `Name` |  | flex 2 | renderer() |  |
    | Category | `Category` |  | flex 1 | renderer() |  |
    | Status | `Status` |  | 120 | renderer() |  |
    | Available quantity | `Quantity` |  | 100 | renderer() |  |
    | Sync quantity | `SyncQuantity` |  | 100 |  |  |
    | Buffer inventory | `SyncBufferInventory` |  | 100 |  |  |
    | Price | `Price` |  |  | renderer() |  |

- **grid** · renders into `divTaxMapping` · store `vEcsTaxMappingStore` · placeholder `There are no tax rates.`
  - *columns:*
    - *(component built elsewhere: `taxMappingColumns`)*
- **grid** · renders into `divShippingMetadataFieldsMapping` · store `shippingMetadataFieldsMappingStore` · placeholder `There are no custom metadata fields.`
  - *columns:*
    - *(component built elsewhere: `shippingMetadataColumns`)*
- **grid** · renders into `divPaymentProcessorMapping` · store `vEcsPaymentProcessorMappingStore` · placeholder `There are no known payment methods. Try to create a paid order.`
  - *columns:*
    - *(component built elsewhere: `paymentProcessorMappingsColumns`)*
- **grid** · renders into `divPendingOrdersGrid` · store `pendingOrdersStore` · placeholder `You do not have any pending WooCommerce sales at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Order # | `OrderNumber` |  | 100 | renderer() |  |
    | Date | `DateCreated` | date column | 120 | renderer() |  |
    | Customer | `CustomerName` |  | flex 1 | renderer() |  |
    | Product | `Name` |  | flex 2 | renderer() |  |
    | Quantity | `Quantity` |  | 100 |  |  |
    | Total paid | `Total` |  | flex 1 | renderer() |  |

- **grid** · renders into `logGridContainer` · store `logStore` · placeholder `You do not have any captured WooCommerce sales at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | WooCommerce invoice # | `OrderNumber` |  | flex 1 | RenderHTMLText |  |
    | Type | `Type` |  | flex 1 | renderer() |  |
    | Date | `Date` | date column | flex 1 | renderer() |  |
    | Download date | `DownloadDate` | date column | flex 1 | renderer() |  |
    | Process date | `ProcessDate` | date column | flex 1 | renderer() |  |
    | Sale task | `SaleOrderNumber` |  | flex 1 | renderer() |  |
    | Status | `Status` |  | flex 1 | renderer() |  |

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

- **grid** · renders into `divBulkList` · store `bulkStore` · placeholder `No products found.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | SKU | `ProductCode` |  | flex 1 | renderer() |  |
    | Product | `Name` |  | flex 2 | renderer() |  |
    | Category | `Category` |  | flex 1 | renderer() |  |
    | Status | `Status` |  | flex 1 | renderer() |  |
    | Available quantity | `Quantity` |  | 100 | renderer() |  |
    | Sync quantity | `SyncQuantity` |  | 100 |  |  |
    | Buffer inventory | `SyncBufferInventory` |  | 100 |  |  |
    | Price | `Price` |  |  | renderer() |  |

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


#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| date field |  | `WooCommerce_FromOrders` | `` | placeholder `Choose...` · format `UserDateFormat` |
| text field |  | `WooCommerce_Index_ShopName` | `` |  |
| text field |  | `WooCommerce_Index_ShopUrl` | `` |  |
| text field |  | `WooCommerce_Index_ShopName_OAuth` | `` |  |
| text field |  | `WooCommerce_Index_ShopUrl_OAuth` | `` |  |
| text field |  | `WooCommerce_Index_ShopUrl_Setup` | `` | disabled |
| text field |  | `WooCommerce_Index_ConsumerKey` | `` |  |
| text field |  | `WooCommerce_Index_ConsumerSecret` | `` |  |
| combo |  | `Woocommerce_Index_ConnectionType` | `ConnectionType` | shows `name` · value `value` · pick-only |
| combo |  | `Woocommerce_Index_ReConnectionType` | `ConnectionType` | shows `name` · value `value` · pick-only |
| text field |  | `WooCommerce_Index_ReconnectShopUrlOauth` | `` |  |
| text field |  | `WooCommerce_Index_ReconnectShopUrl` | `` |  |
| text field |  | `WooCommerce_Index_ReconnectConsumerKey` | `` |  |
| text field |  | `WooCommerce_Index_ReconnectConsumerSecret` | `` |  |
| combo |  | `Woocommerce_ChangeCredentials_ConnectionType` | `ConnectionType` | shows `name` · value `value` · pick-only |
| text field |  | `WooCommerce_ChangeCredentials_ShopName` | `` |  |
| text field |  | `WooCommerce_ChangeCredentials_ShopUrl` | `` |  |
| text field |  | `WooCommerce_ChangeCredentials_ShopName_OAuth` | `` |  |
| text field |  | `WooCommerce_ChangeCredentials_ShopUrl_OAuth` | `` |  |
| text field |  | `WooCommerce_ChangeCredentials_ConsumerKey` | `` |  |
| text field |  | `WooCommerce_ChangeCredentials_ConsumerSecret` | `` |  |
| combo |  | `WooCommerce_Index_Topic` | `TopicStore` | shows `description` · value `type` · pick-only |
| combo |  | `WooCommerce_Index_ConsolidationType` | `ConsolidationTypeStore` | shows `description` · value `type` · pick-only |
| combo |  | `WooCommerce_Index_ConsolidationTime` | `vTimeStore` | shows `Name` · value `Value` · pick-only |
| combo |  | `WooCommerce_Index_Customer` | `vCustomerStore` | shows `Name` · value `CustomerID` · placeholder `Choose...` |
| combo |  | `WooCommerce_Editor_SalePriceTier` | `vSalesPriceTiersStore` | shows `Name` · value `Code` · placeholder `Choose...` · pick-only |
| combo |  | `WooCommerce_Editor_RegularPriceTier` | `vSalesPriceTiersStore` | shows `Name` · value `Code` · placeholder `Choose...` · pick-only |
| combo |  | `WooCommerce_Editor_AutoFulfilmentMode` | `AutoFulfilmentModeStore` | shows `name` · value `value` · placeholder `Choose...` · pick-only |
| combo |  | `WooCommerce_Editor_InvoiceStatus` | `InvoiceStatusStore` | shows `name` · value `value` · placeholder `Choose...` · pick-only |
| combo |  | `WooCommerce_Index_CreateAssembly` | `CreateAssemblyStore` | shows `name` · value `value` · placeholder `Choose...` · pick-only |
| number field |  | `WooCommerce_Catalog_BufferInventory` | `` | placeholder `0` |
| combo |  | `WooCommerce_Index_RevenueAccount` | `RevenueAccountStore` | shows `DisplayName` · value `Code` · placeholder `Choose...` |
| text field |  | `WooCommerce_Index_CustomSalesRepresentative` | `` | placeholder `write...` |
| number field |  | `WooCommerce_Index_BufferInventory` | `` | placeholder `0` |
| combo |  | `tdBulkCategory` | `CategoryStore` | shows `Category` · value `CategoryID` · placeholder `List all categories` |
| combo |  | `tdBulkTag` | `TagsStore` | shows `Value` · value `Value` · placeholder `List all tags` |
| combo |  | `tdBulkListingStatus` | `BulkListingStatusStore` | shows `Name` · value `Value` · placeholder `List all products` · pick-only |
| number field |  | `tdBulkBufferInventory` | `` | placeholder `0` |
| combo |  | `tdBulkUseBufferInventory` | `UseBufferInventoryOptionsStore` | shows `name` · value `value` · placeholder `Don’t update existing setting` · pick-only |
| combo |  | `WooCommerce_Editor_Location` | `LocationStore` | shows `Description` · value `LocationID` · placeholder `Choose warehouse...` · pick-only |
| combo |  | `tdBulkListingBrand` | `vTenantBrandStore` | shows `Brand` · value `ID` · placeholder `List all brands` |
| combo |  | `tdBulkListingListedIn` | `ECommerceShopStore` | shows `ShopName` · value `ConfigID` · placeholder `Choose...` |
| date field |  | `divExportLogFrom` | `` | format `UserDateFormat` |
| date field |  | `divExportLogTo` | `` | format `UserDateFormat` |
| combo |  | `divExportLogPeriod` | `periodStore` | shows `name` · value `value` · pick-only |

#### Menus, buttons and other parts

- **column** “Type” · field `Description`
- **column** “Tax rule” · field `TaxRuleName`
- **column** “Field name” · field `PropertyName`
- **column** “Value” · field `Value`
- **column** “Name” · field `PaymentProcessorName`
- **column** “Payment account code” · field `LedgerAccount`
- **component** · renders into `tdBulkFamily` · store `FamilyStore` · shows `Name` · value `ID` · placeholder `List all families`

