# BigCommerce: UI

Every component the page code builds, read from the shipped ExtJS bundles: grids with their columns, fields, buttons, menus, windows and custom components. Labels are the English UI text. `renders into` is the id of the `<div>` in the page's server-rendered HTML that the component mounts in; `store` names the data store (see the endpoints in [README.md](README.md)); `on click` is the handler. Visual system and shell layout: [docs/UI.md](../../../docs/UI.md).

## Screens

| Route | Title | Bundles |
|---|---|---|
| `/Bigcommerce` | BigCommerce | [`Bigcommerce2019`](#bigcommerce2019) |

## Layout

Each screen's server-rendered HTML inside the shell, as an outline: headings, tabs, sections, labels, inputs (`#id`), buttons (`▾` = dropdown), menus, tables and `slot`s (empty `<div>`s the components below mount into). `(hidden)` parts are shown by the page code when needed. Read with GET from a signed-in session; no values are kept.

### `/Bigcommerce`: BigCommerce

Frame: `task-upload-frame`.

```text
link "Home"
link "Integrations"
tabs#portal-main-tab: Overview #tab_overview |  #tab-add-new | Help #tab-portal-help
tab pane#tab_overview
  tabs#overview-list: 
  block #overview-content (hidden)
    text "BigCommerce"
    text "Read the full information sheet about BigCommerce and Cin7 Core integration."
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
  text "BigCommerce"
  text "Read the full information sheet about BigCommerce and Cin7 Core integration."
  button "Read information sheet" primary
  button "Help" primary
  tab pane#tab-portal-setup
    heading "Setup"
    button "Save"#btnSaveSetupChanges primary
    block #authError (hidden)
      text "Connection with your BigCommerce store requires reauthorization."
      form#frmReConnect
        label "Type of connection"
        slot #Bigcommerce_Index_ReConnectionType
        block #li_BigcommerceReConnect_At (hidden)
          label "Client ID"
          slot #Bigcommerce_Index_ReconnectConsumerKey
          label "Client secret"
          slot #Bigcommerce_Index_ReconnectConsumerSecret
          label "Access token"
          slot #Bigcommerce_Index_ReconnectAccessToken
        button "Reconnect to BigCommerce"#frmReConnectButton primary
    slot #setupValidation (hidden)
    text "General settings"
    label "Capture order when it is"
    slot #Bigcommerce_Index_Topic
    label "Customer"
    slot #Bigcommerce_Index_Customer
    label "Consolidate orders"
    slot #Bigcommerce_Index_ConsolidationType
    block #liBigcommerce_Index_ConsolidationTime (hidden)
      label "Consolidation time"
      slot #Bigcommerce_Index_ConsolidationTime
    label "Regular price tier"
    slot #Bigcommerce_Editor_RegularPriceTier
    label "Sale price tier"
    slot #Bigcommerce_Editor_SalePriceTier
    label "Pick, pack, and ship processing mode"
    slot #Bigcommerce_Editor_AutoFulfilmentMode
    label "Process auto-assembly"
    slot #Bigcommerce_Index_CreateAssembly
    label "Link BigCommerce sales to Cin7 Core location"
    slot #Bigcommerce_Editor_Location
    block #chkIgnoreRestockForNotFulfilledContainer
      label "Ignore restock for non fulfilled sales"
      input checkbox#divIgnoreRestockForNotFulfilled
    text "Account and cash settings"
    label "Invoice status"
    slot #Bigcommerce_Editor_InvoiceStatus
    label "Sales representative name"
    slot #Bigcommerce_Index_CustomSalesRepresentative
    label "Optional revenue account"
    slot #Bigcommerce_Index_RevenueAccount
    label "Update stock levels in BigCommerce"
    input checkbox#Bigcommerce_Index_SyncStockLevel
    label "Use BigCommerce as master source for Cin7 Core products"
    input checkbox#Bigcommerce_Index_SyncCategoryAndBrand
    block #chkUseBufferInventoryContainer
      label "Use buffer inventory"
      input checkbox#Bigcommerce_Index_UseBufferInventory
    block #txtBufferInventoryContainer
      label "Buffer inventory"
      slot #Bigcommerce_Index_BufferInventory
    block #wrnUseBufferInventory
      text "To enable the stock buffer only for specific products (like best-sellers), set 0 for 'Buffer inventory' here, and the re"
    label "List products as draft"
    input checkbox#Bigcommerce_Index_ListAsDraft
    label "Load coupons from BigCommerce"
    input checkbox#Bigcommerce_Index_LoadCouponCodes
    label "Export shipping information to BigCommerce"
    input checkbox#Bigcommerce_Index_ExportShipInfo
    label "Add a company to the address"
    input checkbox#Bigcommerce_Index_AddCompanyToAddresses
    text "Link BigCommerce and Cin7 Core tax rules"
    slot #taxRulesErrorContainer (hidden)
    button "Load from BigCommerce"#divLoadTaxMapping
    slot #divTaxMapping
    text "Link BigCommerce payment methods to payment accounts"
    slot #paymentProcessorsMappingErrorContainer (hidden)
    button "Load from BigCommerce"#divLoadPaymentProcessorMapping
    text "You can select accounts to use for payments received via listed payment methods if account has type "BANK" or has indica"
    slot #divPaymentProcessorMapping
    text "Disconnect from your BigCommerce store"
    form#frmDisconnect
    slot #CreationDate
    button "Disconnect from BigCommerce store"
  tab pane#tab-portal-catalog
    heading "Catalog"
    input text#divSearchCatalog placeholder "Type text to search"
    button "Search" primary
    button "Refresh"#divRefreshCatalog
    button "Download"#downloadAction ▾
    slot #cmbDownload
    button "Sync stock levels in BigCommerce"#divUploadQuantities
    button #Grid_CatalogGrid_Options
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
    slot #tdBulkPriceTier
    label "Price tier"
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
    slot #Bigcommerce_BulkListing_ValidationContainer (hidden)
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
  heading "Link your BigCommerce shop with Cin7 Core"
  text "You need BigCommerce merchant account for e-Shop with administrator role, and properly configured settings for: • basic "
  block #addNewNote
    heading 
  form#frmAuthorise
    label "Type of connection"
    slot #Bigcommerce_Index_ConnectionType
    label "BigCommerce shop hash"
    slot #Bigcommerce_Index_ShopName
    label "Sample" for #hashSample
    block #hashSample
    block #li_Bigcommerce_At (hidden)
      label "BigCommerce shop WEB-Page"
      slot #Bigcommerce_Index_ShopUrl
      label "Client ID"
      slot #Bigcommerce_Index_ConsumerKey
      label "Client secret"
      slot #Bigcommerce_Index_ConsumerSecret
      label "Access token"
      slot #Bigcommerce_Index_AccessToken
    button "Connect to BigCommerce"#frmAuthoriseButton primary
tab pane#tab-portal-help
  heading "Help"
  text "IMPORTANT: Initial load of products from BigCommerce does not import current stock quantities. Ensure you have correct s"
  button "Read information sheet" primary
modal#Bigcommerce_Index_Catalog small
  heading "BigCommerce product management"
  button "×"
  slot #Bigcommerce_Catalog_ValidationContainer (hidden)
  label "SKU"
  slot #Bigcommerce_Catalog_ProductCode
  label "Product name"
  slot #Bigcommerce_Catalog_ProductName
  label "Status"
  slot #Bigcommerce_Catalog_Status
  label "Sync stock level"
  input checkbox#Bigcommerce_Catalog_SyncStockLevel
  block #Bigcommerce_Catalog_BufferInventoryControlsWarning
    slot #Bigcommerce_Catalog_BufferInventoryControlsWarningCount
  block #Bigcommerce_Catalog_BufferInventoryControlsContainer
    block #Bigcommerce_Catalog_UseBufferInventoryContainer
      label "Use product-level buffer inventory"
      input checkbox#Bigcommerce_Catalog_UseBufferInventory
    block #Bigcommerce_Catalog_BufferInventoryContainer
      label "Product-level buffer"
      slot #Bigcommerce_Catalog_BufferInventory
  block #Bigcommerce_Catalog_AllActions
    button "List on BigCommerce"#Bigcommerce_Catalog_List primary
    button "Update on BigCommerce"#Bigcommerce_Catalog_Update primary
    button "Unlink"#Bigcommerce_Catalog_UnList
    button "Remove from BigCommerce"#Bigcommerce_Catalog_Remove
    button "Save"#Bigcommerce_Catalog_Save primary
    button "Close"
modal#Bigcommerce_DownloadProducts_Content small
  heading "Load products from BigCommerce"
  button "×"
  slot #Bigcommerce_DownloadProducts_ValidationContainer (hidden)
  text "All products from BigCommerce will be loaded into Cin7 Core. If a matching product is found in Cin7 Core this product wi"
  label "Enable image download" for #Bigcommerce_Download_Image
  input checkbox#Bigcommerce_Download_Image
  text "Enabling this option would increase the time taken to download products."
  block #Bigcommerce_DownloadProducts_Actions
    button "Load from BigCommerce" primary
    button "Close"
modal#Bigcommerce_DownloadCustomers_Content small
  heading "Load customers from BigCommerce"
  button "×"
  slot #Bigcommerce_DownloadCustomers_ValidationContainer (hidden)
  text "All customers from BigCommerce will be loaded into Cin7 Core. If there is a customer in Cin7 Core with the same name as "
  block #Bigcommerce_DownloadCustomers_Actions
    button "Load from BigCommerce" primary
    button "Close"
modal#Bigcommerce_DownloadOrders_Content small
  heading "Load orders from BigCommerce"
  button "×"
  slot #Bigcommerce_DownloadOrders_ValidationContainer (hidden)
  text "All orders from BigCommerce will be loaded into Cin7 Core as pending orders. This operation may take a long time. Please"
  label "Orders created since"
  slot #Bigcommerce_FromOrders
  block #Bigcommerce_DownloadOrders_Actions
    button "Load from BigCommerce" primary
    button "Close"
modal#Bigcommerce_CheckCompatibility_Content small
  heading "Check compatibility with Cin7 Core"
  button "×"
  form#frmDownloadDebugInfo
  slot #Bigcommerce_CheckCompatibility_ValidationContainer (hidden)
  text "Cin7 Core will try to"
  button "Start compatibility check"#checkCompatibilityStartButton primary
  button "Close"
modal#Bigcommerce_ChangeCredentials_Content medium
  heading "Change BigCommerce credentials"
  button "×"
  label "Type of connection"
  slot #Bigcommerce_ChangeCredentials_ConnectionType
  form#frmChangeCredentials
    label "BigCommerce shop name"
    slot #Bigcommerce_ChangeCredentials_ShopName
    label "BigCommerce website"
    slot #Bigcommerce_ChangeCredentials_ShopUrl
    label "Consumer key"
    slot #Bigcommerce_ChangeCredentials_ConsumerKey
    label "Consumer secret"
    slot #Bigcommerce_ChangeCredentials_ConsumerSecret
  form#frmChangeCredentialsOAuth
    label "BigCommerce shop name"
    slot #Bigcommerce_ChangeCredentials_ShopName_OAuth
    label "BigCommerce website"
    slot #Bigcommerce_ChangeCredentials_ShopUrl_OAuth
  button "Change credentials"#divChangeCredentialsButton primary
  button "Close"
modal#Bigcommerce_UpdateQuantity_Content small
  heading "Update quantities in BigCommerce"
  button "×"
  slot #Bigcommerce_UpdateQuantity_ValidationContainer (hidden)
  text "All products listed in Cin7 Core BigCommerce catalog will be updated in BigCommerce with current available quantities fr"
  block #Bigcommerce_UpdateQuantity_Actions
    button "Start" primary
    button "Close"
form#frmProcess
```

## Components by bundle

What the page code builds and mounts into the layout's slots.

### `Bigcommerce2019`

9 grids · 43 standalone fields · 0 windows · 7 menus, buttons and other parts · 0 custom components

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
    | Price | `Price` |  | flex 1 | renderer() |  |

- **grid** · renders into `divTaxMapping` · store `vEcsTaxMappingStore` · placeholder `There are no tax rates.`
  - *columns:*
    - *(component built elsewhere: `taxMappingColumns`)*
- **grid** · renders into `divPaymentProcessorMapping` · store `vEcsPaymentProcessorMappingStore` · placeholder `There are no known payment methods. Try to create a paid order.`
  - *columns:*
    - *(component built elsewhere: `paymentProcessorMappingsColumns`)*
- **grid** · renders into `divPendingOrdersGrid` · store `pendingOrdersStore` · placeholder `You do not have any pending BigCommerce sales at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Order # | `OrderNumber` |  | 100 | renderer() |  |
    | Date | `DateCreated` | date column | 120 | renderer() |  |
    | Customer | `CustomerName` |  | flex 1 | renderer() |  |
    | Product | `Name` |  | flex 2 | renderer() |  |
    | Quantity | `Quantity` |  | 100 |  |  |
    | Total paid | `Total` |  | flex 1 | renderer() |  |

- **grid** · renders into `logGridContainer` · store `logStore` · placeholder `You do not have any captured BigCommerce sales at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | BigCommerce invoice # | `OrderNumber` |  | flex 1 | RenderHTMLText |  |
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
    | Price | `Price` |  | flex 1 | renderer() |  |

- **grid** · renders into `overviewSalesGridContainer` · store `overviewSalesStore` · placeholder `No fulfillment orders.`
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
| date field |  | `Bigcommerce_FromOrders` | `` | placeholder `Choose...` · format `UserDateFormat` |
| text field |  | `Bigcommerce_Index_ShopName` | `` |  |
| text field |  | `Bigcommerce_Index_ShopUrl` | `` |  |
| text field |  | `Bigcommerce_Index_ConsumerKey` | `` |  |
| text field |  | `Bigcommerce_Index_ConsumerSecret` | `` |  |
| text field |  | `Bigcommerce_Index_AccessToken` | `` |  |
| combo |  | `Bigcommerce_Index_ConnectionType` | `ConnectionType` | shows `name` · value `value` · pick-only |
| combo |  | `Bigcommerce_Index_ReConnectionType` | `ConnectionType` | shows `name` · value `value` · pick-only |
| text field |  | `Bigcommerce_Index_ReconnectConsumerKey` | `` |  |
| text field |  | `Bigcommerce_Index_ReconnectConsumerSecret` | `` |  |
| text field |  | `Bigcommerce_Index_ReconnectAccessToken` | `` |  |
| combo |  | `Bigcommerce_ChangeCredentials_ConnectionType` | `ConnectionType` | shows `name` · value `value` · pick-only |
| text field |  | `Bigcommerce_ChangeCredentials_ShopName` | `` |  |
| text field |  | `Bigcommerce_ChangeCredentials_ShopUrl` | `` |  |
| text field |  | `Bigcommerce_ChangeCredentials_ShopName_OAuth` | `` |  |
| text field |  | `Bigcommerce_ChangeCredentials_ShopUrl_OAuth` | `` |  |
| text field |  | `Bigcommerce_ChangeCredentials_ConsumerKey` | `` |  |
| text field |  | `Bigcommerce_ChangeCredentials_ConsumerSecret` | `` |  |
| combo |  | `Bigcommerce_Index_Topic` | `TopicStore` | shows `description` · value `type` · pick-only |
| combo |  | `Bigcommerce_Index_ConsolidationType` | `ConsolidationTypeStore` | shows `description` · value `type` · pick-only |
| combo |  | `Bigcommerce_Index_ConsolidationTime` | `vTimeStore` | shows `Name` · value `Value` · pick-only |
| combo |  | `Bigcommerce_Index_Customer` | `vCustomerStore` | shows `Name` · value `CustomerID` · placeholder `Choose...` |
| combo |  | `Bigcommerce_Editor_SalePriceTier` | `vSalesPriceTiersStore` | shows `Name` · value `Code` · placeholder `Choose...` · pick-only |
| combo |  | `Bigcommerce_Editor_RegularPriceTier` | `vSalesPriceTiersStore` | shows `Name` · value `Code` · placeholder `Choose...` · pick-only |
| combo |  | `Bigcommerce_Editor_AutoFulfilmentMode` | `AutoFulfilmentModeStore` | shows `name` · value `value` · placeholder `Choose...` · pick-only |
| combo |  | `Bigcommerce_Editor_InvoiceStatus` | `InvoiceStatusStore` | shows `name` · value `value` · placeholder `Choose...` · pick-only |
| combo |  | `Bigcommerce_Index_CreateAssembly` | `CreateAssemblyStore` | shows `name` · value `value` · placeholder `Choose...` · pick-only |
| number field |  | `Bigcommerce_Catalog_BufferInventory` | `` | placeholder `0` |
| combo |  | `Bigcommerce_Index_RevenueAccount` | `RevenueAccountStore` | shows `DisplayName` · value `Code` · placeholder `Choose...` |
| text field |  | `Bigcommerce_Index_CustomSalesRepresentative` | `` | placeholder `write...` |
| number field |  | `Bigcommerce_Index_BufferInventory` | `` | placeholder `0` |
| combo |  | `tdBulkCategory` | `CategoryStore` | shows `Category` · value `CategoryID` · placeholder `List all categories` |
| combo |  | `tdBulkTag` | `TagsStore` | shows `Value` · value `Value` · placeholder `List all tags` |
| combo |  | `tdBulkPriceTier` | `vSalesPriceTiersStore` | shows `Name` · value `Code` · placeholder `List all price tiers` |
| combo |  | `tdBulkListingStatus` | `BulkListingStatusStore` | shows `Name` · value `Value` · placeholder `List all products` · pick-only |
| number field |  | `tdBulkBufferInventory` | `` | placeholder `0` |
| combo |  | `tdBulkUseBufferInventory` | `UseBufferInventoryOptionsStore` | shows `name` · value `value` · placeholder `Don’t update existing setting` · pick-only |
| combo |  | `Bigcommerce_Editor_Location` | `LocationStore` | shows `Description` · value `LocationID` · placeholder `Choose warehouse...` · pick-only |
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

