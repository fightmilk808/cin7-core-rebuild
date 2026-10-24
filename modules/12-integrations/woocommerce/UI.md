# WooCommerce: UI

Every component the page code builds, read from the shipped ExtJS bundles: grids with their columns, fields, buttons, menus, windows and custom components. Labels are the English UI text. `renders into` is the id of the `<div>` in the page's server-rendered HTML that the component mounts in; `store` names the data store (see the endpoints in [README.md](README.md)); `on click` is the handler. Visual system and shell layout: [docs/UI.md](../../../docs/UI.md).

## Screens

| Route | Title | Bundles |
|---|---|---|
| `/WooCommerce` | WooCommerce | [`WooCommerce2019`](#woocommerce2019) |

## Layout

Each screen's server-rendered HTML inside the shell, as an outline: headings, tabs, sections, labels, inputs (`#id`), buttons (`▾` = dropdown), menus, tables and `slot`s (empty `<div>`s the components below mount into). `(hidden)` parts are shown by the page code when needed. Read with GET from a signed-in session; no values are kept.

### `/WooCommerce`: WooCommerce

Frame: `task-upload-frame`.

```text
link "Home"
link "Integrations"
tabs#portal-main-tab: Overview #tab_overview |  #tab-add-new | Help #tab-portal-help
tab pane#tab_overview
  tabs#overview-list: 
  block #overview-content (hidden)
    text "WooCommerce"
    text "Read the full information sheet about WooCommerce and Cin7 Core integration."
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
  text "WooCommerce"
  text "Read the full information sheet about WooCommerce and Cin7 Core integration."
  button "Read information sheet" primary
  button "Help" primary
  tab pane#tab-portal-setup
    heading "Setup"
    button "Save"#btnSaveSetupChanges primary
    block #authError (hidden)
      text "Connection with your WooCommerce store requires reauthorization."
      label "Type of connection"
      slot #Woocommerce_Index_ReConnectionType
      form#frmReConnect
        label "WooCommerce website"
        slot #WooCommerce_Index_ReconnectShopUrl
        block #li_Woocommerce_Ck
          label "Consumer key"
          slot #WooCommerce_Index_ReconnectConsumerKey
        block #li_Woocommerce_Cs
          label "Consumer secret"
          slot #WooCommerce_Index_ReconnectConsumerSecret
          button "Reconnect to WooCommerce" primary
      form#frmReConnectOauth
        label "WooCommerce website"
        slot #WooCommerce_Index_ReconnectShopUrlOauth
        button "Reconnect to WooCommerce" primary
    slot #setupValidation (hidden)
    label "Shop website:"
    slot #WooCommerce_Index_ShopUrl_Setup
    button "Check compatibility with Cin7 Core"#divCheckCompatibility primary
    button "Change credentials"#divChangeCredentials primary
    text "General settings"
    label "Capture order when it is"
    slot #WooCommerce_Index_Topic
    label "Consolidate orders"
    slot #WooCommerce_Index_ConsolidationType
    block #liWooCommerce_Index_ConsolidationTime (hidden)
      label "Consolidation time"
      slot #WooCommerce_Index_ConsolidationTime
    label "Customer"
    slot #WooCommerce_Index_Customer
    label "Regular price tier"
    slot #WooCommerce_Editor_RegularPriceTier
    label "Sale price tier"
    slot #WooCommerce_Editor_SalePriceTier
    label "Pick, pack, and ship processing mode"
    slot #WooCommerce_Editor_AutoFulfilmentMode
    label "Link WooCommerce sales to Cin7 Core location"
    slot #WooCommerce_Editor_Location
    block #chkIgnoreRestockForNotFulfilledContainer
      label "Ignore restock for non fulfilled sales"
      input checkbox#divIgnoreRestockForNotFulfilled
    label "Process auto-assembly"
    slot #WooCommerce_Index_CreateAssembly
    text "Account and cash settings"
    label "Invoice status"
    slot #WooCommerce_Editor_InvoiceStatus
    label "Optional revenue account"
    slot #WooCommerce_Index_RevenueAccount
    label "Sales representative name"
    slot #WooCommerce_Index_CustomSalesRepresentative
    label "List products as draft"
    input checkbox#WooCommerce_Index_ListAsDraft
    label "Update stock levels in WooCommerce"
    input checkbox#WooCommerce_Index_SyncStockLevel
    label "Use WooCommerce as master source for Cin7 Core products"
    input checkbox#WooCommerce_Index_SyncCategoryAndBrand
    block #chkUseBufferInventoryContainer
      label "Use buffer inventory"
      input checkbox#WooCommerce_Index_UseBufferInventory
    block #txtBufferInventoryContainer
      label "Buffer inventory"
      slot #WooCommerce_Index_BufferInventory
    block #wrnUseBufferInventory
      text "To enable the stock buffer only for specific products (like best-sellers), set 0 for 'Buffer inventory' here, and the re"
    label "Export shipping information to WooCommerce"
    input checkbox#WooCommerce_Index_ExportShipInfo
    label "Load coupon codes from WooCommerce"
    input checkbox#WooCommerce_Index_LoadCouponCodes
    label "Add a company to the address"
    input checkbox#WooCommerce_Index_AddCompanyToAddresses
    text "Link WooCommerce and Cin7 Core tax rules"
    slot #taxRulesErrorContainer (hidden)
    button "Load from WooCommerce"#divLoadTaxMapping
    slot #divTaxMapping
    text "Link WooCommerce payment methods to payment accounts"
    slot #paymentProcessorsMappingErrorContainer (hidden)
    button "Load from WooCommerce"#divLoadPaymentProcessorMapping
    text "You can select accounts to use for payments received via listed payment methods if account has type "BANK" or has indica"
    slot #divPaymentProcessorMapping
    block #divShippingMetadataFieldsMapping_Container (hidden)
      text "Link WooCommerce shipping metadata fields to Cin7 Core shipment details"
      button #divAddShippingMetadataMapping primary
      slot #divShippingMetadataFieldsMapping
    text "Disconnect from your WooCommerce store"
    form#frmDisconnect
    slot #CreationDate
    button "Disconnect from WooCommerce store"
  tab pane#tab-portal-catalog
    heading "Catalog"
    input text#divSearchCatalog placeholder "Type text to search"
    button "Search" primary
    button "Refresh"#divRefreshCatalog
    button "Download"#downloadAction ▾
    slot #cmbDownload
    button "Update quantities in WooCommerce"#divUploadQuantities
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
    slot #WooCommerce_BulkListing_ValidationContainer (hidden)
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
    button "Search" primary
    button "Refresh"#divRefreshOperationsLog
    button #OperationsLogGrid_Options
    slot #operationsLogGridContainer
tab pane#tab-add-new
  heading "Link your WooCommerce shop with Cin7 Core"
  button "Connect to WooCommerce"#frmAuthoriseButton primary (hidden)
  button "Connect to WooCommerce"#frmAuthoriseOauthButton primary
  text "Make sure that your WooCommerce instance is supported by Cin7 Core. (Required versions: WooCommerce >= 3.0.x and WordPre"
  block #addNewNote
    heading 
  label "Type of connection"
  slot #Woocommerce_Index_ConnectionType
  form#frmAuthorise
    label "WooCommerce shop name"
    slot #WooCommerce_Index_ShopName
    label "WooCommerce store home page URL address"
    slot #WooCommerce_Index_ShopUrl
    block #li_Woocommerce_Ck
      label "Consumer key"
      slot #WooCommerce_Index_ConsumerKey
    block #li_Woocommerce_Cs
      label "Consumer secret"
      slot #WooCommerce_Index_ConsumerSecret
  form#frmAuthoriseOauth
    label "WooCommerce shop name"
    slot #WooCommerce_Index_ShopName_OAuth
    label "WooCommerce website"
    slot #WooCommerce_Index_ShopUrl_OAuth
tab pane#tab-portal-help
  heading "Help"
  text "IMPORTANT: Cin7 Core can integrate with WooCommerce version starting from 3.0.x, WordPress version starting from 4.4.x."
  button "Read information sheet" primary
modal#WooCommerce_Index_Catalog small
  heading "WooCommerce product management"
  button "×"
  slot #WooCommerce_Catalog_ValidationContainer (hidden)
  label "SKU"
  slot #WooCommerce_Catalog_ProductCode
  label "Product name"
  slot #WooCommerce_Catalog_ProductName
  label "Status"
  slot #WooCommerce_Catalog_Status
  label "Sync stock level"
  input checkbox#WooCommerce_Catalog_SyncStockLevel
  block #WooCommerce_Catalog_BufferInventoryControlsWarning
    slot #WooCommerce_Catalog_BufferInventoryControlsWarningCount
  block #WooCommerce_Catalog_BufferInventoryControlsContainer
    block #WooCommerce_Catalog_UseBufferInventoryContainer
      label "Use product-level buffer inventory"
      input checkbox#WooCommerce_Catalog_UseBufferInventory
    block #WooCommerce_Catalog_BufferInventoryContainer
      label "Product-level buffer"
      slot #WooCommerce_Catalog_BufferInventory
  block #WooCommerce_Catalog_AllActions
    button "List on WooCommerce"#WooCommerce_Catalog_List primary
    button "Update on WooCommerce"#WooCommerce_Catalog_Update primary
    button "Unlink"#WooCommerce_Catalog_UnList
    button "Remove from WooCommerce"#WooCommerce_Catalog_Remove
    button "Save"#WooCommerce_Catalog_Save primary
    button "Close"
modal#WooCommerce_DownloadProducts_Content small
  heading "Load products from WooCommerce"
  button "×"
  slot #WooCommerce_DownloadProducts_ValidationContainer (hidden)
  text "All products from WooCommerce will be loaded into Cin7 Core. If a matching product is found in Cin7 Core this product wi"
  label "Enable image download" for #WooCommerce_Download_Image
  input checkbox#WooCommerce_Download_Image
  text "Enabling this option would increase the time taken to download products."
  block #WooCommerce_DownloadProducts_Actions
    button "Load from WooCommerce" primary
    button "Close"
modal#WooCommerce_DownloadCustomers_Content small
  heading "Load customers from WooCommerce"
  button "×"
  slot #WooCommerce_DownloadCustomers_ValidationContainer (hidden)
  text "All customers from WooCommerce will be loaded into Cin7 Core. If there is a customer in Cin7 Core with the same name as "
  block #WooCommerce_DownloadCustomers_Actions
    button "Load from WooCommerce" primary
    button "Close"
modal#WooCommerce_DownloadOrders_Content small
  heading "Load orders from WooCommerce"
  button "×"
  slot #WooCommerce_DownloadOrders_ValidationContainer (hidden)
  text "All orders from WooCommerce will be loaded into Cin7 Core as pending orders. This operation may take a long time. Please"
  label "Orders created since"
  slot #WooCommerce_FromOrders
  block #WooCommerce_DownloadOrders_Actions
    button "Load from WooCommerce" primary
    button "Close"
modal#WooCommerce_CheckCompatibility_Content small
  heading "Check compatibility with Cin7 Core"
  button "×"
  form#frmDownloadDebugInfo
  slot #WooCommerce_CheckCompatibility_ValidationContainer (hidden)
  text "Cin7 Core will try to"
  button "Start compatibility check"#checkCompatibilityStartButton primary
  button "Close"
modal#WooCommerce_ChangeCredentials_Content medium
  heading "Change WooCommerce credentials"
  button "×"
  label "Type of connection"
  slot #Woocommerce_ChangeCredentials_ConnectionType
  form#frmChangeCredentials
    label "WooCommerce shop name"
    slot #WooCommerce_ChangeCredentials_ShopName
    label "WooCommerce website"
    slot #WooCommerce_ChangeCredentials_ShopUrl
    label "Consumer key"
    slot #WooCommerce_ChangeCredentials_ConsumerKey
    label "Consumer secret"
    slot #WooCommerce_ChangeCredentials_ConsumerSecret
  form#frmChangeCredentialsOAuth
    label "WooCommerce shop name"
    slot #WooCommerce_ChangeCredentials_ShopName_OAuth
    label "WooCommerce website"
    slot #WooCommerce_ChangeCredentials_ShopUrl_OAuth
  button "Change credentials"#divChangeCredentialsButton primary
  button "Close"
modal#WooCommerce_UpdateQuantity_Content small
  heading "Update quantities in WooCommerce"
  button "×"
  slot #WooCommerce_UpdateQuantity_ValidationContainer (hidden)
  text "All products listed in Cin7 Core WooCommerce catalog will be updated in WooCommerce with current available quantities fr"
  block #WooCommerce_UpdateQuantity_Actions
    button "Start" primary
    button "Close"
form#frmProcess
```

## Components by bundle

What the page code builds and mounts into the layout's slots.

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

