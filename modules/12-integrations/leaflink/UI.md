# LeafLink: UI

Every component the page code builds, read from the shipped ExtJS bundles: grids with their columns, fields, buttons, menus, windows and custom components. Labels are the English UI text. `renders into` is the id of the `<div>` in the page's server-rendered HTML that the component mounts in; `store` names the data store (see the endpoints in [README.md](README.md)); `on click` is the handler. Visual system and shell layout: [docs/UI.md](../../../docs/UI.md).

## Screens

| Route | Title | Bundles |
|---|---|---|
| `/LeafLink` | LeafLink | [`LeafLink2019`](#leaflink2019) |

## Layout

Each screen's server-rendered HTML inside the shell, as an outline: headings, tabs, sections, labels, inputs (`#id`), buttons (`▾` = dropdown), menus, tables and `slot`s (empty `<div>`s the components below mount into). `(hidden)` parts are shown by the page code when needed. Read with GET from a signed-in session; no values are kept.

### `/LeafLink`: LeafLink

Frame: `task-upload-frame`.

```text
link "Home"
link "Integrations"
tabs#portal-main-tab: Overview #tab_overview |  #tab-add-new | Help #tab-portal-help
tab pane#tab_overview
  tabs#overview-list: 
  block #overview-content (hidden)
    text "LeafLink"
    text "Read the full information sheet about LeafLink and Cin7 Core integration."
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
        block #GridOptions_overviewSalesGridContainer
          button #Grid_gridName_Options1
        slot #overviewSalesGridContainer
      tab pane#overview-tab-customers
        input text#divSearchOverviewCustomers placeholder "Type text to search"
        button "Search" primary
        block #GridOptions_overviewCustomersGridContainer
          button #Grid_gridName_Options2
        slot #overviewCustomersGridContainer
tab pane#tab-portal-settings
  tabs: Setup #tab-portal-setup | Catalog #tab-portal-catalog | Bulk operations #tab-portal-bulkLoad | Pending orders #tab-portal-pendingOrders | Log #tab-portal-log | Operations log #tab-shop-operationsLog
  text "LeafLink"
  text "Read the full information sheet about LeafLink and Cin7 Core integration."
  button "Read information sheet" primary
  button "Help" primary
  tab pane#tab-portal-setup
    heading "Setup"
    button "Save"#btnSaveSetupChanges primary
    heading "General settings"
    block #authError (hidden)
      text "Connection with your LeafLink store requires reauthorization."
      form#frmReConnect
        label "API key"
        slot #LeafLink_Index_ReconnectApiKey
        button "Reconnect to LeafLink" primary
    slot #setupValidation (hidden)
    label "Capture order when it is"
    slot #LeafLink_Index_Topic
    label "Customer"
    slot #LeafLink_Index_Customer
    label "Consolidate orders"
    slot #LeafLink_Index_ConsolidationType
    block #liLeafLink_Index_ConsolidationTime (hidden)
      label "Consolidate time"
      slot #LeafLink_Index_ConsolidationTime
    label "Wholesale price tier"
    slot #LeafLink_Editor_WholeSalePriceTier
    label "Sale price tier"
    slot #LeafLink_Editor_SalePriceTier
    label "Regular price tier"
    slot #LeafLink_Editor_RetailPriceTier
    label "Process auto-assembly"
    slot #LeafLink_Index_CreateAssembly
    label "Pick, pack, and ship processing mode"
    slot #LeafLink_Editor_AutoFulfilmentMode
    label "Link LeafLink store to Cin7 Core location"
    slot #LeafLink_Editor_LinkStoreToDear
    text "Account and cash settings"
    label "Invoice status"
    slot #LeafLink_Editor_InvoiceStatus
    label "Sales representative name"
    slot #LeafLink_Index_CustomSalesRepresentative
    label "Optional revenue account"
    slot #LeafLink_Index_RevenueAccount
    label "Update stock levels in LeafLink"
    input checkbox#LeafLink_Index_SyncStockLevel
    label "Use LeafLink as master source for Cin7 Core products"
    input checkbox#LeafLink_Index_UseAsMasterSourceForDearProducts
    block #chkUseBufferInventoryContainer
      label "Use buffer inventory"
      input checkbox#LeafLink_Index_UseBufferInventory
    block #txtBufferInventoryContainer
      label "Buffer inventory"
      slot #LeafLink_Index_BufferInventory
    block #wrnUseBufferInventory
      text "To enable the stock buffer only for specific products (like best-sellers), set 0 for 'Buffer inventory' here, and the re"
    label "List products as draft"
    input checkbox#LeafLink_Index_ListProductsAsDraft
    label "Load promocodes from LeafLink"
    input checkbox#LeafLink_Index_LoadPromoCodes
    label "Export shipping information to LeafLink"
    input checkbox#LeafLink_Index_ExportShipInfo
    label "Add a company to the address"
    input checkbox#LeafLink_Index_AddCompanyToAddress
    label "Tax rules mapping mode"
    slot #LeafLink_Index_TaxRuleMappingMode
    block #LeafLink_Editor_PaymentsAccountPanel (hidden)
      label "Payments account"
      slot #LeafLink_Editor_PaymentsAccount
    text "Link LeafLink & Cin7 Core tax rules"
    slot #LeafLinkDearTaxRules
    text "Link LeafLink payment methods to Cin7 Core payment account"
    text "You can select accounts to use for payments received via listed payment methods if account has type "BANK" or has indica"
    slot #LeafLinkPaymentMethodsToDear
    text "Disconnect from your LeafLink store"
    form#frmDisconnect
    slot #CreationDate
    button "Disconnect from LeafLink store"
  tab pane#tab-portal-catalog
    heading "Catalog"
    input text#divSearchCatalog placeholder "Type text to search"
    button "Search" primary
    button "Refresh"#divRefreshCatalog
    button "Download"#downloadAction ▾
    slot #cmbDownload
    button "Update quantities in LeafLink"#divUploadQuantities
    button #Grid_CatalogGrid_Options
    slot #catalogGridContainer
  tab pane#tab-portal-bulkLoad
    heading "Bulk operations"
    slot #tdBulkCategory
    label "Category"
    slot #tdBulkListingBrand
    label "Brand"
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
    button "Update"#btnListBulk
    button "Unlist"#btnUnlistBulk
    button "Unlink"#btnUnlinkBulk
    button #Grid_bulkGrid_Options
    slot #LeafLink_BulkListing_ValidationContainer (hidden)
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
    button #Grid_LogGrid_Options
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
  heading "Link your LeafLink shop with Cin7 Core"
  button "Connect to LeafLink"#btnConnectToShop primary
  text "You need LeafLink account with developer options for e-shop with properly configured settings for:"
  block #addNewNote
    heading 
  form#frmAuthorise
    label "LeafLink shop name"
    slot #LeafLink_Index_ShopName
    label "LeafLink Company ID"
    slot #LeafLink_Index_CompanyID
    label "LeafLink License ID"
    slot #LeafLink_Index_LicenseID
    label "LeafLink API key"
    slot #LeafLink_Index_ApiKey
tab pane#tab-portal-help
  heading "Help"
  text "IMPORTANT: Initial load of products from LeafLink does not import current stock quantities. Ensure you have correct stoc"
  heading "Integration guidelines"
  button "Read information sheet" primary
modal#LeafLink_Index_Catalog small
  heading "LeafLink product management"
  button "×"
  slot #LeafLink_Catalog_ValidationContainer (hidden)
  text "You are managing product in LeafLink store"
  label "SKU"
  slot #LeafLink_Catalog_ProductCode
  label "Product name"
  slot #LeafLink_Catalog_ProductName
  label "Status"
  slot #LeafLink_Catalog_Status
  label "Sync stock level"
  input checkbox#LeafLink_Catalog_SyncStockLevel
  block #LeafLink_Catalog_BufferInventoryControlsWarning
    slot #LeafLink_Catalog_BufferInventoryControlsWarningCount
  block #LeafLink_Catalog_BufferInventoryControlsContainer
    block #LeafLink_Catalog_UseBufferInventoryContainer
      label "Use product-level buffer inventory"
      input checkbox#LeafLink_Catalog_UseBufferInventory
    block #LeafLink_Catalog_BufferInventoryContainer
      label "Product-level buffer"
      slot #LeafLink_Catalog_BufferInventory
  block #LeafLink_Catalog_AllActions
    button "Update on LeafLink"#LeafLink_Catalog_Update primary
    button "Unlink"#LeafLink_Catalog_UnList
    button "Remove from LeafLink"#LeafLink_Catalog_Remove
    button "Save"#LeafLink_Catalog_Save primary
    button "Close"
modal#LeafLink_DownloadProducts_Content small
  heading "Load products from LeafLink"
  button "×"
  slot #LeafLink_DownloadProducts_ValidationContainer (hidden)
  text "All products from LeafLink will be loaded into Cin7 Core. If a matching product is found in Cin7 Core this product will "
  label "Enable image download" for #LeafLink_Download_Image
  input checkbox#LeafLink_Download_Image
  text "Enabling this option would increase the time taken to download products."
  block #LeafLink_DownloadProducts_Actions
    button "Load from LeafLink" primary
    button "Close"
modal#LeafLink_DownloadCustomers_Content small
  heading "Load customers from LeafLink"
  button "×"
  slot #LeafLink_DownloadCustomers_ValidationContainer (hidden)
  text "All customers from LeafLink will be loaded into Cin7 Core. If there is a customer in Cin7 Core with the same name as in "
  block #LeafLink_DownloadCustomers_Actions
    button "Load from LeafLink" primary
    button "Close"
modal#LeafLink_DownloadSuppliers_Content small
  heading "Load suppliers from LeafLink"
  button "×"
  slot #LeafLink_DownloadSuppliers_ValidationContainer (hidden)
  text "All suppliers from LeafLink will be loaded into Cin7 Core. If there is a supplier in Cin7 Core with the same name as in "
  block #LeafLink_DownloadSuppliers_Actions
    button "Load from LeafLink" primary
    button "Close"
modal#LeafLink_UpdateQuantity_Content small
  heading "Update quantities in LeafLink"
  button "×"
  slot #LeafLink_UpdateQuantity_ValidationContainer (hidden)
  text "All products listed in Cin7 Core LeafLink catalog will be updated in LeafLink with current available quantities from Cin"
  block #LeafLink_UpdateQuantity_Actions
    button "Start" primary
    button "Close"
modal#LeafLink_DownloadOrders_Content small
  heading "Load orders from LeafLink"
  button "×"
  slot #LeafLink_DownloadOrders_ValidationContainer (hidden)
  text "All orders from LeafLink will be loaded into Cin7 Core as pending orders. This operation may take a long time. Please le"
  label "Sales created since"
  slot #LeafLink_FromOrders
  block #LeafLink_DownloadOrders_Actions
    button "Load from LeafLink" primary
    button "Close"
form#frmProcess
```

## Components by bundle

What the page code builds and mounts into the layout's slots.

### `LeafLink2019`

9 grids · 32 standalone fields · 0 windows · 0 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `catalogGridContainer` · store `productStore` · placeholder `No products found.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | SKU | `ProductCode` |  | flex 1 | renderer() |  |
    | Product | `Name` |  | flex 2 | renderer() |  |
    | Category | `Category` |  | flex 1 | renderer() |  |
    | Status | `Status` |  | 100 | renderer() |  |
    | Available quantity | `Quantity` |  | 100 |  |  |
    | Sync quantity | `SyncQuantity` |  | 100 |  |  |
    | Buffer inventory | `SyncBufferInventory` |  | 100 |  |  |
    | Price | `Price` |  | flex 1 | renderer() |  |

- **grid** · renders into `LeafLinkDearTaxRules` · store `vEcsTaxMappingStore` · placeholder `Loading LeafLink taxes rates...`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Type | `Description` |  | flex 1 | RenderHTMLText |  |
    | Tax rule | `TaxRuleName` |  | flex 1 | renderer() |  |

- **grid** · renders into `LeafLinkPaymentMethodsToDear` · store `vEcsPaymentProcessorMappingStore` · placeholder `Loading LeafLink payment methods...`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Name | `PaymentProcessorName` |  | flex 1 | RenderHTMLText |  |
    | Payment account code | `LedgerAccount` |  | flex 1 | renderer() |  |

- **grid** · renders into `divPendingOrdersGrid` · store `pendingOrdersStore` · placeholder `You do not have any pending LeafLink sales at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Order # | `OrderNumber` |  | 100 | renderer() |  |
    | Date | `DateCreated` | date column | 120 | renderer() |  |
    | Customer | `CustomerName` |  | flex 1 | renderer() |  |
    | Product | `Name` |  | flex 2 | renderer() |  |
    | Quantity | `Quantity` |  | 100 |  |  |
    | Total paid | `Total` |  | flex 1 | renderer() |  |

- **grid** · renders into `logGridContainer` · store `logStore` · placeholder `You do not have any captured LeafLink sales at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | LeafLink invoice # | `OrderNumber` |  | flex 1 |  |  |
    | Type | `Type` |  | flex 1 | renderer() |  |
    | Date | `Date` | date column | flex 1 | renderer() |  |
    | Download date | `DownloadDate` | date column | flex 1 | renderer() |  |
    | Process date | `ProcessDate` | date column | flex 1 | renderer() |  |
    | Sale task | `SaleOrderNumber` |  | flex 1 | renderer() |  |
    | Status | `Status` |  | flex 1 | renderer() |  |

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

- **grid** · renders into `operationsLogGridContainer` · store `operationsLogStore` · placeholder `No entries found. Please hit refresh or change the search criteria.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Date | `Date` | date column | 170 | renderer() |  |
    | Type | `Type` |  | 80 | renderer() |  |
    | User | `UserName` |  | flex 1 | renderer() |  |
    | Category | `Category` |  | 100 | renderer() |  |
    | Processed | `Processed` | check column | 100 | renderer() |  |
    | Description | `Description` |  | flex 2 | renderer() |  |

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


#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| text field |  | `LeafLink_Index_ShopName` | `` |  |
| text field |  | `LeafLink_Index_CompanyID` | `` |  |
| text field |  | `LeafLink_Index_LicenseID` | `` |  |
| text field |  | `LeafLink_Index_ApiKey` | `` |  |
| text field |  | `LeafLink_Index_ReconnectApiKey` | `` |  |
| combo |  | `LeafLink_Index_Topic` | `TopicStore` | shows `description` · value `type` · pick-only |
| combo |  | `LeafLink_Index_ConsolidationType` | `ConsolidationTypeStore` | shows `description` · value `type` · pick-only |
| combo |  | `LeafLink_Index_ConsolidationTime` | `vTimeStore` | shows `Name` · value `Value` · pick-only |
| combo |  | `LeafLink_Index_Customer` | `vCustomerStore` | shows `Name` · value `CustomerID` · placeholder `Choose...` |
| combo |  | `LeafLink_Editor_WholeSalePriceTier` | `vSalesPriceTiersStore` | shows `Name` · value `Code` · placeholder `Choose...` · pick-only |
| combo |  | `LeafLink_Editor_SalePriceTier` | `vSalesPriceTiersStore` | shows `Name` · value `Code` · placeholder `Choose...` · pick-only |
| combo |  | `LeafLink_Editor_RetailPriceTier` | `vSalesPriceTiersStore` | shows `Name` · value `Code` · placeholder `Choose...` · pick-only |
| combo |  | `LeafLink_Editor_LinkStoreToDear` | `LocationStore` | shows `Description` · value `LocationID` · placeholder `Choose...` · pick-only |
| combo |  | `LeafLink_Editor_AutoFulfilmentMode` | `AutoFulfilmentModeStore` | shows `name` · value `value` · placeholder `Choose...` · pick-only |
| combo |  | `LeafLink_Editor_InvoiceStatus` | `InvoiceStatusStore` | shows `name` · value `value` · placeholder `Choose...` · pick-only |
| combo |  | `LeafLink_Index_CreateAssembly` | `CreateAssemblyStore` | shows `name` · value `value` · placeholder `Choose...` · pick-only |
| combo |  | `LeafLink_Index_RevenueAccount` | `RevenueAccountStore` | shows `DisplayName` · value `Code` · placeholder `Choose...` |
| text field |  | `LeafLink_Index_CustomSalesRepresentative` | `` | placeholder `write...` |
| number field |  | `LeafLink_Index_BufferInventory` | `` | placeholder `0` |
| number field |  | `LeafLink_Catalog_BufferInventory` | `` | placeholder `0` |
| combo |  | `LeafLink_Index_TaxRuleMappingMode` | `TaxRuleMappingModeStore` | shows `name` · value `value` · placeholder `Choose...` · pick-only |
| date field |  | `LeafLink_FromOrders` | `` | placeholder `Choose...` · format `UserDateFormat` |
| combo |  | `tdBulkCategory` | `CategoryStore` | shows `Category` · value `CategoryID` · placeholder `List all categories` |
| combo |  | `tdBulkTag` | `TagsStore` | shows `Value` · value `Value` · placeholder `List all tags` |
| combo |  | `tdBulkListingStatus` | `BulkListingStatusStore` | shows `Name` · value `Value` · placeholder `List all products` · pick-only |
| number field |  | `tdBulkBufferInventory` | `` | placeholder `0` |
| combo |  | `tdBulkUseBufferInventory` | `UseBufferInventoryOptionsStore` | shows `name` · value `value` · placeholder `Don’t update existing setting` · pick-only |
| combo |  | `tdBulkListingBrand` | `vTenantBrandStore` | shows `Brand` · value `ID` · placeholder `List all brands` |
| combo |  | `tdBulkListingListedIn` | `ECommerceShopStore` | shows `ShopName` · value `ConfigID` · placeholder `Choose...` |
| date field |  | `divExportLogFrom` | `` | format `UserDateFormat` |
| date field |  | `divExportLogTo` | `` | format `UserDateFormat` |
| combo |  | `divExportLogPeriod` | `periodStore` | shows `name` · value `value` · pick-only |

