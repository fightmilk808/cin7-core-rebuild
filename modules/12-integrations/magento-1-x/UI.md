# Magento 1.x: UI

Every component the page code builds, read from the shipped ExtJS bundles: grids with their columns, fields, buttons, menus, windows and custom components. Labels are the English UI text. `renders into` is the id of the `<div>` in the page's server-rendered HTML that the component mounts in; `store` names the data store (see the endpoints in [README.md](README.md)); `on click` is the handler. Visual system and shell layout: [docs/UI.md](../../../docs/UI.md).

## Screens

| Route | Title | Bundles |
|---|---|---|
| `/MagentoSIM` | Magento 1.x | [`Magento2019`](#magento2019) |

## Layout

Each screen's server-rendered HTML inside the shell, as an outline: headings, tabs, sections, labels, inputs (`#id`), buttons (`▾` = dropdown), menus, tables and `slot`s (empty `<div>`s the components below mount into). `(hidden)` parts are shown by the page code when needed. Read with GET from a signed-in session; no values are kept.

### `/MagentoSIM`: Magento 1.x

Frame: `task-upload-frame`.

```text
link "Home"
link "Integrations"
tabs#portal-main-tab: Overview #tab_overview |  #tab-add-new | Help #tab-portal-help
tab pane#tab_overview
  tabs#overview-list: 
  block #overview-content (hidden)
    text "Magento 1.x"
    text "Read the full information sheet about Magento 1.x and Cin7 Core integration."
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
  text "Magento 1.x"
  text "Read the full information sheet about Magento 1.x and Cin7 Core integration."
  button "Read information sheet" primary
  button "Help" primary
  tab pane#tab-portal-setup
    heading "Setup"
    button "Save"#btnSaveSetupChanges primary
    block #authError (hidden)
      text "Connection with your Magento store requires reauthorization."
      form#frmReConnect
        label "Username"
        slot #MagentoSim_Index_ReconnectUserName
        label "API key"
        slot #MagentoSim_Index_ReconnectApiKey
        button "Reconnect to Magento" primary
    slot #setupValidation (hidden)
    text "General settings"
    label "Shop website"
    slot #MagentoSim_Index_ShopUrl_Setup
    label "Capture order when it is"
    slot #MagentoSim_Index_Topic
    label "Consolidate orders"
    slot #MagentoSim_Index_ConsolidationType
    block #liMagentoSim_Index_ConsolidationTime (hidden)
      label "Consolidation time"
      slot #MagentoSim_Index_ConsolidationTime
    label "Customer"
    slot #MagentoSim_Index_Customer
    label "Use company as a customer"
    input checkbox#MagentoSim_Index_UseCompanyAsCustomer
    label "Price tier"
    slot #MagentoSim_Editor_PriceTier
    label "Pick, pack, and ship processing mode"
    slot #MagentoSim_Editor_AutoFulfilmentMode
    label "Process auto-assembly"
    slot #MagentoSim_Index_CreateAssembly
    block #chkIgnoreRestockForNotFulfilledContainer
      block #chkIgnoreRestockForNotFulfilledContainer
        label "Ignore restock for non fulfilled sales"
        input checkbox#divIgnoreRestockForNotFulfilled
    text "Account and cash settings"
    label "Link Magento sales to Cin7 Core location"
    slot #MagentoSim_Editor_Location
    label "Invoice status"
    slot #MagentoSim_Editor_InvoiceStatus
    label "Gift card liability account"
    slot #MagentoSim_Editor_LiabilityAccount
    label "Optional revenue account"
    slot #MagentoSim_Index_RevenueAccount
    label "Sales representative name"
    slot #MagentoSim_Index_CustomSalesRepresentative
    label "List products as draft"
    input checkbox#MagentoSim_Index_ListAsDraft
    label "Update stock levels in Magento"
    input checkbox#MagentoSim_Index_SyncStockLevel
    block #chkUseBufferInventoryContainer
      label "Use buffer inventory"
      input checkbox#MagentoSim_Index_UseBufferInventory
    block #txtBufferInventoryContainer
      label "Buffer inventory"
      slot #MagentoSim_Index_BufferInventory
    block #wrnUseBufferInventory
      text "To enable the stock buffer only for specific products (like best-sellers), set 0 for 'Buffer inventory' here, and the re"
    label "Export shipping information to Magento"
    input checkbox#MagentoSim_Index_ExportShipInfo
    label "Send an email from Magento"
    input checkbox#MagentoSim_Index_SendShippingEmail
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
    slot #td_Currency
    label "Currency"
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
    slot #MagentoSim_BulkListing_ValidationContainer (hidden)
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
    slot #MagentoSim_Index_ShopName
    label "Magento store home page URL address"
    slot #MagentoSim_Index_ShopUrl
    label "Username"
    slot #MagentoSim_Index_UserName
    label "API key"
    slot #MagentoSim_Index_ApiKey
tab pane#tab-portal-help
  heading "Help"
  button "Read information sheet" primary
modal#MagentoSim_Index_Catalog small
  heading "Magento product management"
  button "×"
  slot #MagentoSim_Catalog_ValidationContainer (hidden)
  label "SKU"
  slot #MagentoSim_Catalog_ProductCode
  label "Product name"
  slot #MagentoSim_Catalog_ProductName
  label "Status"
  slot #MagentoSim_Catalog_Status
  label "Attribute set"
  slot #Magento_Catalog_AttributeSetIndividual
  label "Sync stock level"
  input checkbox#MagentoSim_Catalog_SyncStockLevel
  block #MagentoSim_Catalog_BufferInventoryControlsWarning
    slot #MagentoSim_Catalog_BufferInventoryControlsWarningCount
  block #MagentoSim_Catalog_BufferInventoryControlsContainer
    block #MagentoSim_Catalog_UseBufferInventoryContainer
      label "Use product-level buffer inventory"
      input checkbox#MagentoSim_Catalog_UseBufferInventory
    block #MagentoSim_Catalog_BufferInventoryContainer
      label "Product-level buffer"
      slot #MagentoSim_Catalog_BufferInventory
  block #MagentoSim_Catalog_AllActions
    button "List on Magento"#MagentoSim_Catalog_List primary
    button "Update on Magento"#MagentoSim_Catalog_Update primary
    button "Unlink"#MagentoSim_Catalog_UnList
    button "Remove from Magento"#MagentoSim_Catalog_Remove
    button "Save"#MagentoSim_Catalog_Save primary
    button "Close"
modal#MagentoSim_DownloadProducts_Content small
  heading "Load products from Magento"
  button "×"
  slot #MagentoSim_DownloadProducts_ValidationContainer (hidden)
  text "All products from Magento will be loaded into Cin7 Core. If a matching product is found in Cin7 Core this product will b"
  label "Enable image download" for #Magento_Download_Image
  input checkbox#Magento_Download_Image
  text "Enabling this option would increase the time taken to download products."
  block #MagentoSim_DownloadProducts_Actions
    button "Load from Magento" primary
    button "Close"
modal#MagentoSim_DownloadCustomers_Content small
  heading "Load customers from Magento"
  button "×"
  slot #MagentoSim_DownloadCustomers_ValidationContainer (hidden)
  text "All customers from Magento will be loaded into Cin7 Core. If there is a customer in Cin7 Core with the same name as in M"
  block #MagentoSim_DownloadCustomers_Actions
    button "Load from Magento" primary
    button "Close"
modal#MagentoSim_DownloadOrders_Content small
  heading "Load orders from Magento"
  button "×"
  slot #MagentoSim_DownloadOrders_ValidationContainer (hidden)
  text "All orders from Magento will be loaded into Cin7 Core as pending orders. This operation may take a long time. Please lea"
  label "Orders created since"
  slot #MagentoSim_FromOrders
  block #MagentoSim_DownloadOrders_Actions
    button "Load from Magento" primary
    button "Close"
modal#MagentoSim_UpdateQuantity_Content small
  heading "Update quantities in Magento"
  button "×"
  slot #MagentoSim_UpdateQuantity_ValidationContainer (hidden)
  text "All products listed in Cin7 Core Magento catalog will be updated in Magento with current available quantities from Cin7 "
  block #MagentoSim_UpdateQuantity_Actions
    button "Start" primary
    button "Close"
form#frmProcess
```

## Components by bundle

What the page code builds and mounts into the layout's slots.

### `Magento2019`

9 grids · 35 standalone fields · 0 windows · 1 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `catalogGridContainer` · store `productStore` · placeholder `No products found.`
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
    |  | `Status` |  | 100 | renderer() |  |
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
| date field |  | `MagentoSim_FromOrders` | `` | placeholder `Choose...` · format `UserDateFormat` |
| text field |  | `MagentoSim_Index_ShopName` | `` |  |
| text field |  | `MagentoSim_Index_ShopUrl` | `` |  |
| text field |  | `MagentoSim_Index_ShopUrl_Setup` | `` | disabled |
| text field |  | `MagentoSim_Index_UserName` | `` |  |
| text field |  | `MagentoSim_Index_ApiKey` | `` |  |
| text field |  | `MagentoSim_Index_ReconnectUserName` | `` |  |
| text field |  | `MagentoSim_Index_ReconnectApiKey` | `` |  |
| combo |  | `MagentoSim_Index_Topic` | `TopicStore` | shows `description` · value `type` · pick-only |
| combo |  | `MagentoSim_Index_ConsolidationType` | `ConsolidationTypeStore` | shows `description` · value `type` · pick-only |
| combo |  | `MagentoSim_Index_ConsolidationTime` | `vTimeStore` | shows `Name` · value `Value` · pick-only |
| combo |  | `MagentoSim_Index_Customer` | `vCustomerStore` | shows `Name` · value `CustomerID` · placeholder `Choose...` |
| combo |  | `MagentoSim_Editor_PriceTier` | `vSalesPriceTiersStore` | shows `Name` · value `Code` · placeholder `Choose...` · pick-only |
| combo |  | `MagentoSim_Editor_AutoFulfilmentMode` | `AutoFulfilmentModeStore` | shows `name` · value `value` · placeholder `Choose...` · pick-only |
| combo |  | `MagentoSim_Editor_InvoiceStatus` | `InvoiceStatusStore` | shows `name` · value `value` · placeholder `Choose...` · pick-only |
| combo |  | `MagentoSim_Index_CreateAssembly` | `CreateAssemblyStore` | shows `name` · value `value` · placeholder `Choose...` · pick-only |
| number field |  | `MagentoSim_Catalog_BufferInventory` | `` | placeholder `0` |
| combo |  | `MagentoSim_Index_RevenueAccount` | `RevenueAccountStore` | shows `DisplayName` · value `Code` · placeholder `Choose...` |
| text field |  | `MagentoSim_Index_CustomSalesRepresentative` | `` | placeholder `write...` |
| number field |  | `MagentoSim_Index_BufferInventory` | `` | placeholder `0` |
| combo |  | `MagentoSim_Editor_LiabilityAccount` | `LiabilityAccountStore` | shows `DisplayName` · value `Code` · placeholder `Choose...` · pick-only |
| combo |  | `tdBulkCategory` | `CategoryStore` | shows `Category` · value `CategoryID` · placeholder `List all categories` |
| combo |  | `tdBulkTag` | `TagsStore` | shows `Value` · value `Value` · placeholder `List all tags` |
| combo |  | `tdBulkListingStatus` | `BulkListingStatusStore` | shows `Name` · value `Value` · placeholder `List all products` · pick-only |
| number field |  | `tdBulkBufferInventory` | `` | placeholder `0` |
| combo |  | `tdBulkUseBufferInventory` | `UseBufferInventoryOptionsStore` | shows `name` · value `value` · placeholder `Don’t update existing setting` · pick-only |
| combo |  | `MagentoSim_Editor_Location` | `LocationStore` | shows `Description` · value `LocationID` · placeholder `Choose warehouse...` · pick-only |
| combo |  | `Magento_Catalog_AttributeSet` | `AttributeSetStore` | shows `Name` · value `ID` · placeholder `Choose...` · pick-only |
| combo |  | `Magento_Catalog_AttributeSetIndividual` | `AttributeSetStore` | shows `Name` · value `ID` · placeholder `Choose...` · pick-only |
| combo |  | `td_Currency` | `currencyStore` | shows `Code` · value `Code` |
| combo |  | `tdBulkListingBrand` | `vTenantBrandStore` | shows `Brand` · value `ID` · placeholder `List all brands` |
| combo |  | `tdBulkListingListedIn` | `ECommerceShopStore` | shows `ShopName` · value `ConfigID` · placeholder `Choose...` |
| date field |  | `divExportLogFrom` | `` | format `UserDateFormat` |
| date field |  | `divExportLogTo` | `` | format `UserDateFormat` |
| combo |  | `divExportLogPeriod` | `periodStore` | shows `name` · value `value` · pick-only |

#### Menus, buttons and other parts

- **component** · renders into `tdBulkFamily` · store `FamilyStore` · shows `Name` · value `ID` · placeholder `List all families`

