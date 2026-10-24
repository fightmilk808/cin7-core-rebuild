# Magento 2.x: UI

Every component the page code builds, read from the shipped ExtJS bundles: grids with their columns, fields, buttons, menus, windows and custom components. Labels are the English UI text. `renders into` is the id of the `<div>` in the page's server-rendered HTML that the component mounts in; `store` names the data store (see the endpoints in [README.md](README.md)); `on click` is the handler. Visual system and shell layout: [docs/UI.md](../../../docs/UI.md).

## Screens

| Route | Title | Bundles |
|---|---|---|
| `/Magento2` | Magento 2.x | [`MagentoSd2019`](#magentosd2019) |

## Layout

Each screen's server-rendered HTML inside the shell, as an outline: headings, tabs, sections, labels, inputs (`#id`), buttons (`▾` = dropdown), menus, tables and `slot`s (empty `<div>`s the components below mount into). `(hidden)` parts are shown by the page code when needed. Read with GET from a signed-in session; no values are kept.

### `/Magento2`: Magento 2.x

Frame: `task-upload-frame`.

```text
link "Home"
link "Integrations"
tabs#portal-main-tab: Overview #tab_overview |  #tab-add-new | Help #tab-portal-help
tab pane#tab_overview
  tabs#overview-list: 
  block #overview-content (hidden)
    text "Magento 2.x"
    text "Read the full information sheet about Magento and Cin7 Core integration."
    button "Read information sheet" primary
    button "Help" primary
    tab pane#overview-content-tab
      heading #overview-portal-name
      block #overview-base-portal-settings (hidden)
        text "Base settings"
        slot #overview-portal-settings (hidden)
        slot #overview-portal-link
      block #overview-portal-logo (hidden)
      text "Sales summary"
      button "Refresh"#divRefreshSalesSummary
      slot #overview-sales-summary (hidden)
      tabs#overview-tabs: Sales #overview-tab-sales | Customers #overview-tab-customers
      tab pane#overview-tab-sales
        input text#divSearchOverviewSales placeholder "Type text to search"
        button "Search" primary
        slot #overviewSalesGridContainer
      tab pane#overview-tab-customers
        input text#divSearchOverviewCustomers placeholder "Type text to search"
        button "Search" primary
        slot #overviewCustomersGridContainer
tab pane#tab-portal-settings
  tabs: Setup #tab-portal-setup | Catalog #tab-portal-catalog | Bulk listing #tab-portal-bulkLoad | Pending orders #tab-portal-pendingOrders | Log #tab-portal-log | Operations log #tab-shop-operationsLog
  text "Magento 2.x"
  text "Read the full information sheet about Magento and Cin7 Core integration."
  button "Read information sheet" primary
  button "Help" primary
  tab pane#tab-portal-setup
    heading "Setup"
    button "Save"#btnSaveSetupChanges primary
    block #authError (hidden)
      text "Connection with your Magento store requires reauthorization."
      form#frmReConnect
        label "Consumer key"
        slot #Magento2_Index_ReconnectConsumerKey
        label "Consumer secret"
        slot #Magento2_Index_ReconnectConsumerSecret
        label "Access token"
        slot #Magento2_Index_ReconnectAccessToken
        label "Access token secret"
        slot #Magento2_Index_ReconnectAccessTokenSecret
        button "Reconnect to Magento" primary
    slot #setupValidation (hidden)
    text "General settings"
    label "Shop website:"
    slot #Magento2_Index_ShopUrl_Setup
    label "Magento store"
    slot #Magento2_Editor_MagentoStore
    label "Capture order when it is"
    slot #Magento2_Index_Topic
    label "Consolidate orders"
    slot #Magento2_Index_ConsolidationType
    block #liMagento2_Index_ConsolidationTime (hidden)
      label "Consolidation time"
      slot #Magento2_Index_ConsolidationTime
    label "Customer"
    slot #Magento2_Index_Customer
    label "Use company as a customer"
    input checkbox#Magento2_Index_UseCompanyAsCustomer
    label "Price tier"
    slot #Magento2_Editor_PriceTier
    label "Sale price tier"
    slot #Magento2_Editor_SalePriceTier
    label "Pick, pack, and ship processing mode"
    slot #Magento2_Editor_AutoFulfilmentMode
    label "Process auto-assembly"
    slot #Magento2_Index_CreateAssembly
    block #chkIgnoreRestockForNotFulfilledContainer
      block #chkIgnoreRestockForNotFulfilledContainer
        label "Ignore restock for non fulfilled sales"
        input checkbox#divIgnoreRestockForNotFulfilled
    text "Account and cash settings"
    label "Link Magento sales to Cin7 Core location"
    slot #Magento2_Editor_Location
    label "Invoice status"
    slot #Magento2_Editor_InvoiceStatus
    label "Add a discount as"
    input radio#Magento2_Index_AddDiscountAsChangedPrice_1 name=Magento2_Index_AddDiscountAsChangedPrice
    label "Price reduction" for #Magento2_Index_AddDiscountAsChangedPrice_1
    input radio#Magento2_Index_AddDiscountAsChangedPrice_2 name=Magento2_Index_AddDiscountAsChangedPrice
    label "Additional charge" for #Magento2_Index_AddDiscountAsChangedPrice_2
    label "Gift card liability account"
    slot #Magento2_Editor_LiabilityAccount
    label "Optional revenue account"
    slot #Magento2_Index_RevenueAccount
    label "Sales representative name"
    slot #Magento2_Index_CustomSalesRepresentative
    label "List products as draft"
    input checkbox#Magento2_Index_ListAsDraft
    label "Update stock levels in Magento"
    input checkbox#Magento2_Index_SyncStockLevel
    block #chkUseBufferInventoryContainer
      label "Use buffer inventory"
      input checkbox#Magento2_Index_UseBufferInventory
    block #txtBufferInventoryContainer
      label "Buffer inventory"
      slot #Magento2_Index_BufferInventory
    block #wrnUseBufferInventory
      text "To enable the stock buffer only for specific products (like best-sellers), set 0 for 'Buffer inventory' here, and the re"
    label "Update manage stock in Magento"
    input checkbox#Magento2_Index_UpdateManageStock
    label "Update 'Is in stock' product option in Magento"
    input checkbox#Magento2_Index_UpdateIsInStock
    label "Use Magento as master source for Cin7 Core products"
    input checkbox#Magento2_Index_SyncCategoryAndBrand
    label "Automatically import stock operations from Magento"
    input checkbox#Magento2_Index_StockPolling
    label "Export shipping information to Magento"
    input checkbox#Magento2_Index_ExportShipInfo
    label "Don't create fulfillment in Magento without tracking number"
    input checkbox#Magento2_Index_FulfilmentWithoutTrackingNumber
    label "Send an email from Magento"
    input checkbox#Magento2_Index_SendShippingEmail
    label "Load coupon codes from Magento"
    input checkbox#Magento2_Index_LoadCouponCodes
    text "Link Magento and Cin7 Core tax rules"
    slot #taxRulesErrorContainer (hidden)
    button "Load from Magento"#divLoadTaxMapping
    slot #divTaxMapping
    text "Link Magento payment methods to payment accounts"
    slot #paymentProcessorsMappingErrorContainer (hidden)
    button "Load from Magento"#divLoadPaymentProcessorMapping
    text "You can select accounts to use for payments received via listed payment methods if account has type "BANK" or has indica"
    slot #divPaymentProcessorMapping
    text "Set up your carriers in Cin7 Core Magento only supports 5 carriers by default: "ups", "usps", "dhl", "fedex" and "dhlint"
    text "Disconnect from your Magento store"
    form#frmDisconnect
    slot #CreationDate
    button "Disconnect from Magento store"
  tab pane#tab-portal-catalog
    heading "Catalog"
    input text#divSearchCatalog placeholder "Type text to search"
    button "Search" primary
    button "Refresh"#divRefreshCatalog
    button "Download"#downloadAction ▾
    slot #cmbDownload
    button "Update quantities in Magento"#divUploadQuantities
    slot #catalogGridContainer
  tab pane#tab-portal-bulkLoad
    heading "Bulk listing"
    slot #tdBulkCategory
    label "Category"
    slot #tdBulkListingBrand
    label "Brand"
    slot #tdBulkFamily
    label "Family"
    slot #tdBulkTag
    label "Product tag"
    slot #Magento_Catalog_AttributeSet
    label "Attribute set"
    slot #tdBulkListingStatus
    label "Listing status"
    slot #tdBulkListingListedIn
    label "Products listed in"
    block #wrnBulkUseBufferInventory
      text "Buffer inventory and sync quantity displayed on bulk listing will get updated for selected products only after bulk list"
    slot #tdBulkUseBufferInventory
    label "Use product-level buffer inventory"
    block #divBulkBufferInventoryContainer
      slot #tdBulkBufferInventory
      label "Product-level buffer"
    input text#divSearchBulk placeholder "Type text to search"
    button "Search" primary
    button "Refresh"#divRefreshBulkCatalog
    button "List"#btnListBulk
    button "Unlist"#btnUnlistBulk
    button "Unlink"#btnUnlinkBulk
    button #Grid_bulkGrid_Options
    slot #Magento2_BulkListing_ValidationContainer (hidden)
    slot #divBulkList
  tab pane#tab-portal-pendingOrders
    heading "Orders"
    input text#divSearchPendingOrders placeholder "Type text to search"
    button "Search" primary
    button "Refresh"#divRefreshPendingOrders
    button "Load orders"#divDownloadOrders
    button "Process"#divProcessOrders
    button #Grid_PendingOrders_Options
    slot #divPendingOrdersGrid
  tab pane#tab-portal-log
    heading "Log"
    input text#divSearchLog placeholder "Type text to search"
    button "Search" primary
    button "Refresh"#divRefreshLog
    slot #divExportLogPeriod
    slot #divExportLogFrom
    slot #divExportLogTo
    button "Export"#divExportLog
    slot #logGridContainer
  tab pane#tab-shop-operationsLog
    heading "Operations log"
    input text#divSearchOperationsLog placeholder "Type text to search"
    button "Search"#divRefreshOperationsLogSearchButton primary
    button "Refresh"#divRefreshOperationsLog
    slot #operationsLogGridContainer
tab pane#tab-add-new
  heading "Link your Magento shop with Cin7 Core"
  button "Connect to Magento"#btnConnectToShop primary
  block #addNewNote
    heading 
  form#frmAuthorise
    label "Magento shop name"
    slot #Magento2_Index_ShopName
    label "Magento store home page URL address"
    slot #Magento2_Index_ShopUrl
    label "Consumer key"
    slot #Magento2_Index_ConsumerKey
    label "Consumer secret"
    slot #Magento2_Index_ConsumerSecret
    label "Access token"
    slot #Magento2_Index_AccessToken
    label "Access token secret"
    slot #Magento2_Index_AccessTokenSecret
tab pane#tab-portal-help
  heading "Help"
  button "Read information sheet" primary
modal#Magento2_Index_Catalog small
  heading "Magento product management"
  button "×"
  slot #Magento2_Catalog_ValidationContainer (hidden)
  label "SKU"
  slot #Magento2_Catalog_ProductCode
  label "Product name"
  slot #Magento2_Catalog_ProductName
  label "Status"
  slot #Magento2_Catalog_Status
  label "Attribute set"
  slot #Magento_Catalog_AttributeSetIndividual
  label "Sync stock level"
  input checkbox#Magento2_Catalog_SyncStockLevel
  block #Magento2_Catalog_BufferInventoryControlsWarning
    slot #Magento2_Catalog_BufferInventoryControlsWarningCount
  block #Magento2_Catalog_BufferInventoryControlsContainer
    block #Magento2_Catalog_UseBufferInventoryContainer
      label "Use product-level buffer inventory"
      input checkbox#Magento2_Catalog_UseBufferInventory
    block #Magento2_Catalog_BufferInventoryContainer
      label "Product-level buffer"
      slot #Magento2_Catalog_BufferInventory
  block #Magento2_Catalog_AllActions
    button "List on Magento"#Magento2_Catalog_List primary
    button "Update on Magento"#Magento2_Catalog_Update primary
    button "Unlink"#Magento2_Catalog_UnList
    button "Remove from Magento"#Magento2_Catalog_Remove
    button "Save"#Magento2_Catalog_Save primary
    button "Close"
modal#Magento2_DownloadProducts_Content small
  heading "Load products from Magento"
  button "×"
  slot #Magento2_DownloadProducts_ValidationContainer (hidden)
  text "All products from Magento will be loaded into Cin7 Core. If a matching product is found in Cin7 Core this product will b"
  label "Enable image download" for #Magento2_Download_Image
  input checkbox#Magento2_Download_Image
  text "Enabling this option would increase the time taken to download products."
  block #Magento2_DownloadProducts_Actions
    button "Load from Magento" primary
    button "Close"
modal#Magento2_DownloadCustomers_Content small
  heading "Load customers from Magento"
  button "×"
  slot #Magento2_DownloadCustomers_ValidationContainer (hidden)
  text "All customers from Magento will be loaded into Cin7 Core. If there is a customer in Cin7 Core with the same name as in M"
  block #Magento2_DownloadCustomers_Actions
    button "Load from Magento" primary
    button "Close"
modal#Magento2_DownloadOrders_Content small
  heading "Load orders from Magento"
  button "×"
  slot #Magento2_DownloadOrders_ValidationContainer (hidden)
  text "All orders from Magento will be loaded into Cin7 Core as pending orders. This operation may take a long time. Please lea"
  label "Orders created since"
  slot #Magento2_FromOrders
  block #Magento2_DownloadOrders_Actions
    button "Load from Magento" primary
    button "Close"
modal#Magento2_UpdateQuantity_Content small
  heading "Update quantities in Magento"
  button "×"
  slot #Magento2_UpdateQuantity_ValidationContainer (hidden)
  text "All products listed in Cin7 Core Magento catalog will be updated in Magento with current available quantities from Cin7 "
  block #Magento2_UpdateQuantity_Actions
    button "Start" primary
    button "Close"
form#frmProcess
```

## Components by bundle

What the page code builds and mounts into the layout's slots.

### `MagentoSd2019`

9 grids · 40 standalone fields · 0 windows · 1 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `catalogGridContainer` · store `productStore` · placeholder `No products found.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | SKU | `ProductCode` |  | flex 1 | renderer() |  |
    | Product | `Name` |  | flex 2 | renderer() |  |
    | Category | `Category` |  | flex 1 | renderer() |  |
    | Status | `Status` |  | 120 | renderer() |  |
    | Available quantity | `Quantity` |  | 100 |  |  |
    | Sync quantity | `SyncQuantity` |  | 100 |  |  |
    | Buffer inventory | `SyncBufferInventory` |  | 100 |  |  |
    | Price | `Price` |  | flex 1 | renderer() |  |

- **grid** · renders into `divTaxMapping` · store `vEcsTaxMappingStore` · placeholder `There are no tax rates.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Type | `Description` |  | flex 1 |  |  |
    | Tax rule | `TaxRuleName` |  | flex 1 | renderer() |  |

- **grid** · renders into `divPaymentProcessorMapping` · store `vEcsPaymentProcessorMappingStore` · placeholder `No orders were paid in Magento within the last month. New payment met…`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Name | `PaymentProcessorName` |  | flex 1 | RenderHTMLText |  |
    | Payment account code | `LedgerAccount` |  | flex 1 | renderer() |  |

- **grid** · renders into `divPendingOrdersGrid` · store `pendingOrdersStore` · placeholder `You do not have any pending Magento sales at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Order # | `OrderNumber` |  | 100 | renderer() |  |
    | Date | `DateCreated` | date column | 120 | renderer() |  |
    | Customer | `CustomerName` |  | flex 1 | renderer() |  |
    | Product | `Name` |  | flex 2 | renderer() |  |
    | Quantity | `Quantity` |  | 100 |  |  |
    | Total paid | `Total` |  | flex 1 | renderer() |  |

- **grid** · renders into `logGridContainer` · store `logStore` · placeholder `You do not have any captured Magento sales at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Magento invoice # | `OrderNumber` |  | flex 1 |  |  |
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
    | Available quantity | `Quantity` |  | 100 |  |  |
    | Sync quantity | `SyncQuantity` |  | 100 |  |  |
    | Buffer inventory | `SyncBufferInventory` |  | 100 |  |  |
    | Price | `Price` |  | flex 1 | renderer() |  |

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
| date field |  | `Magento2_FromOrders` | `` | placeholder `Choose...` · format `UserDateFormat` |
| text field |  | `Magento2_Index_ShopName` | `` |  |
| text field |  | `Magento2_Index_ShopUrl` | `` |  |
| text field |  | `Magento2_Index_ConsumerKey` | `` |  |
| text field |  | `Magento2_Index_ConsumerSecret` | `` |  |
| text field |  | `Magento2_Index_AccessToken` | `` |  |
| text field |  | `Magento2_Index_AccessTokenSecret` | `` |  |
| text field |  | `Magento2_Index_ShopUrl_Setup` | `` | disabled |
| text field |  | `Magento2_Index_ReconnectConsumerKey` | `` |  |
| text field |  | `Magento2_Index_ReconnectConsumerSecret` | `` |  |
| text field |  | `Magento2_Index_ReconnectAccessToken` | `` |  |
| text field |  | `Magento2_Index_ReconnectAccessTokenSecret` | `` |  |
| combo |  | `Magento2_Index_Topic` | `TopicStore` | shows `description` · value `type` · pick-only |
| combo |  | `Magento2_Index_ConsolidationType` | `ConsolidationTypeStore` | shows `description` · value `type` · pick-only |
| combo |  | `Magento2_Index_ConsolidationTime` | `vTimeStore` | shows `Name` · value `Value` · pick-only |
| combo |  | `Magento2_Index_Customer` | `vCustomerStore` | shows `Name` · value `CustomerID` · placeholder `Choose...` |
| combo |  | `Magento2_Editor_PriceTier` | `vSalesPriceTiersStore` | shows `Name` · value `Code` · placeholder `Choose...` · pick-only |
| combo |  | `Magento2_Editor_SalePriceTier` | `vSalesPriceTiersStore` | shows `Name` · value `Code` · placeholder `choose...` · pick-only |
| combo |  | `Magento2_Editor_AutoFulfilmentMode` | `AutoFulfilmentModeStore` | shows `name` · value `value` · placeholder `Choose...` · pick-only |
| combo |  | `Magento2_Editor_InvoiceStatus` | `InvoiceStatusStore` | shows `name` · value `value` · placeholder `Choose...` · pick-only |
| combo |  | `Magento2_Index_CreateAssembly` | `CreateAssemblyStore` | shows `name` · value `value` · placeholder `Choose...` · pick-only |
| combo |  | `Magento2_Editor_MagentoStore` | `MagentoStoresStore` | shows `Name` · value `ID` · placeholder `Choose...` · pick-only |
| number field |  | `Magento2_Catalog_BufferInventory` | `` | placeholder `0` |
| combo |  | `Magento2_Index_RevenueAccount` | `RevenueAccountStore` | shows `DisplayName` · value `Code` · placeholder `Choose...` |
| text field |  | `Magento2_Index_CustomSalesRepresentative` | `` | placeholder `write...` |
| number field |  | `Magento2_Index_BufferInventory` | `` | placeholder `0` |
| combo |  | `Magento2_Editor_LiabilityAccount` | `LiabilityAccountStore` | shows `DisplayName` · value `Code` · placeholder `Choose...` · pick-only |
| combo |  | `tdBulkCategory` | `CategoryStore` | shows `Category` · value `CategoryID` · placeholder `List all categories` |
| combo |  | `tdBulkTag` | `TagsStore` | shows `Value` · value `Value` · placeholder `List all tags` |
| combo |  | `tdBulkListingStatus` | `BulkListingStatusStore` | shows `Name` · value `Value` · placeholder `List all products` · pick-only |
| number field |  | `tdBulkBufferInventory` | `` | placeholder `0` |
| combo |  | `tdBulkUseBufferInventory` | `UseBufferInventoryOptionsStore` | shows `name` · value `value` · placeholder `Don’t update existing setting` · pick-only |
| combo |  | `Magento2_Editor_Location` | `LocationStore` | shows `Description` · value `LocationID` · placeholder `Choose warehouse...` · pick-only |
| combo |  | `Magento_Catalog_AttributeSet` | `AttributeSetStore` | shows `Name` · value `ID` · placeholder `Choose...` · pick-only |
| combo |  | `Magento_Catalog_AttributeSetIndividual` | `AttributeSetStore` | shows `Name` · value `ID` · placeholder `Choose...` · pick-only |
| combo |  | `tdBulkListingBrand` | `vTenantBrandStore` | shows `Brand` · value `ID` · placeholder `List all brands` |
| combo |  | `tdBulkListingListedIn` | `ECommerceShopStore` | shows `ShopName` · value `ConfigID` · placeholder `Choose...` |
| date field |  | `divExportLogFrom` | `` | format `UserDateFormat` |
| date field |  | `divExportLogTo` | `` | format `UserDateFormat` |
| combo |  | `divExportLogPeriod` | `periodStore` | shows `name` · value `value` · pick-only |

#### Menus, buttons and other parts

- **component** · renders into `tdBulkFamily` · store `FamilyStore` · shows `Name` · value `ID` · placeholder `List all families`

