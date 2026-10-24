# Faire: UI

Every component the page code builds, read from the shipped ExtJS bundles: grids with their columns, fields, buttons, menus, windows and custom components. Labels are the English UI text. `renders into` is the id of the `<div>` in the page's server-rendered HTML that the component mounts in; `store` names the data store (see the endpoints in [README.md](README.md)); `on click` is the handler. Visual system and shell layout: [docs/UI.md](../../../docs/UI.md).

## Screens

| Route | Title | Bundles |
|---|---|---|
| `/Faire` | Faire | [`Faire2019`](#faire2019) |

## Layout

Each screen's server-rendered HTML inside the shell, as an outline: headings, tabs, sections, labels, inputs (`#id`), buttons (`▾` = dropdown), menus, tables and `slot`s (empty `<div>`s the components below mount into). `(hidden)` parts are shown by the page code when needed. Read with GET from a signed-in session; no values are kept.

### `/Faire`: Faire

Frame: `task-upload-frame`.

```text
link "Home"
link "Integrations"
tabs#portal-main-tab: Overview #tab_overview |  #tab-add-new | Help #tab-portal-help
tab pane#tab_overview
  tabs#overview-list: 
  block #overview-content (hidden)
    text "FAIRE"
    text "Watch our short video guide and read the full information sheet about FAIRE and Cin7 Core integration."
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
      slot #overview-sales-summary
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
  tabs: Setup #tab-portal-setup | Carriers mapping #tab-portal-carriers-mapping | Catalog #tab-portal-catalog | Bulk operations #tab-portal-bulkLoad | Pending orders #tab-portal-pendingOrders | Log #tab-portal-log | Operations log #tab-shop-operationsLog
  text "FAIRE"
  button "Help" primary
  tab pane#tab-portal-setup
    heading "Store setup"
    button "Save"#btnSaveSetupChanges primary
    heading "General settings"
    block #authError (hidden)
      text "Connection with your FAIRE store requires reauthorization."
    slot #setupValidation (hidden)
    label "Capture order when it is"
    slot #Faire_Index_Topic
    label "Customer"
    slot #Faire_Index_Customer
    block #trDailyConsolidationWarning (hidden)
      text "Returns and refunds for walk-in sales are not supported by daily consolidation mode."
    label "Consolidate orders"
    slot #Faire_Index_ConsolidationType
    block #liFaire_Index_ConsolidationTime (hidden)
      label "Consolidate time"
      slot #Faire_Index_ConsolidationTime
    label "Wholesale price tier"
    slot #Faire_Editor_WholeSalePriceTier
    label "Retail price tier"
    slot #Faire_Editor_RetailPriceTier
    label "Process auto-assembly"
    slot #Faire_Index_CreateAssembly
    label "Pick, pack, and ship processing mode"
    slot #Faire_Editor_AutoFulfilmentMode
    label "Link FAIRE store to Cin7 Core location"
    slot #Faire_Editor_LinkStoreToDear
    text "Account and cash settings"
    label "Invoice status"
    slot #Faire_Editor_InvoiceStatus
    label "Sales representative name"
    slot #Faire_Index_CustomSalesRepresentative
    label "Optional revenue account"
    slot #Faire_Index_RevenueAccount
    label "Update stock levels in FAIRE"
    input checkbox#Faire_Index_SyncStockLevel
    label "Use FAIRE as master source for Cin7 Core products"
    input checkbox#Faire_Index_UseAsMasterSourceForDearProducts
    block #chkUseBufferInventoryContainer
      label "Use buffer inventory"
      input checkbox#Faire_Index_UseBufferInventory
    block #txtBufferInventoryContainer
      label "Buffer inventory"
      slot #Faire_Index_BufferInventory
    block #wrnUseBufferInventory
      text "To enable the stock buffer only for specific products (like best-sellers), set 0 for 'Buffer inventory' here, and the re"
    label "List products as draft"
    input checkbox#Faire_Index_ListProductsAsDraft
    label "Export shipping information to FAIRE"
    input checkbox#Faire_Index_ExportShipInfo
    label "Tax rules mapping mode"
    slot #Faire_Index_TaxRuleMappingMode
    block #Faire_Editor_PaymentsAccountPanel (hidden)
      label "Payments account"
      slot #Faire_Editor_PaymentsAccount
    text "Link FAIRE & Cin7 Core tax rules"
    slot #FaireDearTaxRules
    text "Link FAIRE payment methods to Cin7 Core payment accounts"
    text "You can select accounts to use for payments received via listed payment methods if account has type "BANK" or has indica"
    slot #FairePaymentMethodsToDear
    text "Disconnect from your FAIRE store"
    form#frmDisconnect
    slot #CreationDate
    button "Disconnect from FAIRE store"
  tab pane#tab-portal-carriers-mapping
    heading "Carriers mapping"
    button "Save"#btnSaveCarriersMappingChanges primary
    heading "Link FAIRE and Cin7 Core shipping carriers"
    block #divCopyMappingsContainer (hidden)
      button "Copy mapping from..."#CopyMappingFromAction ▾
      slot #cmbCopyMappingFrom
    slot #carriersMappingGridContainer
  tab pane#tab-portal-catalog
    heading "Catalog"
    input text#divSearchCatalog placeholder "Type text to search"
    button "Search" primary
    button "Refresh"#divRefreshCatalog
    button "Download products"#downloadAction
    button "Update stock levels in FAIRE"#divUploadQuantities
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
    button "Clear filters"#divClearFilters
    slot #tdBulkListingTaxonomyType
    label "Taxonomy type to list"
    text "This list returns actual products taxonomy types by FAIRE. It will be used only for new product listing from Cin7 Core i"
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
    slot #Faire_BulkListing_ValidationContainer (hidden)
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
  heading "Link your FAIRE store"
  button "Connect to FAIRE"#btnConnectToShop primary
  text "You need FAIRE account, e-shop page properly configured settings for:"
  text "and e-shop activated."
  block #addNewNote
    heading 
  form#frmAuthorise
    label "FAIRE shop name"
    slot #Faire_Index_ShopName
    label "API key"
    slot #Faire_Index_APIKey
tab pane#tab-portal-help
  heading "Help"
  text "IMPORTANT: Initial load of products from FAIRE does not import current stock quantities. Ensure you have correct stock q"
  heading "Integration guidelines"
modal#Faire_Index_Catalog small
  heading "FAIRE product management"
  button "×"
  slot #Faire_Catalog_ValidationContainer (hidden)
  text "You are managing product in FAIRE store"
  label "SKU"
  slot #Faire_Catalog_ProductCode
  label "Product name"
  slot #Faire_Catalog_ProductName
  label "Status"
  slot #Faire_Catalog_Status
  block #Faire_Catalog_SyncStockLevelOption
    label "Don't sync product level"
    input checkbox#Faire_Catalog_SyncStockLevel
  slot #tdBulkListingTaxonomyTypeModal
  label "Taxonomy type to list"
  text "This list returns actual products taxonomy types by FAIRE. It's used only for new product listing from Cin7 Core invento"
  block #Faire_Catalog_BufferInventoryControlsWarning
    slot #Faire_Catalog_BufferInventoryControlsWarningCount
  block #Faire_Catalog_BufferInventoryControlsContainer
    block #Faire_Catalog_UseBufferInventoryContainer
      label "Use product-level buffer inventory"
      input checkbox#Faire_Catalog_UseBufferInventory
    block #Faire_Catalog_BufferInventoryContainer
      label "Product-level buffer"
      slot #Faire_Catalog_BufferInventory
  block #Faire_Catalog_AllActions
    button "List on FAIRE"#Faire_Catalog_List primary
    button "Update on FAIRE"#Faire_Catalog_Update primary
    button "Unlink"#Faire_Catalog_UnList
    button "Remove from FAIRE"#Faire_Catalog_Remove
    button "Save"#Faire_Catalog_Save primary
    button "Close"
modal#Faire_DownloadProducts_Content small
  heading "Load products from FAIRE"
  button "×"
  slot #Faire_DownloadProducts_ValidationContainer (hidden)
  text "All products from FAIRE will be loaded into Cin7 Core. If a matching product is found in Cin7 Core this product will be "
  label "Enable image download" for #Faire_Download_Image
  input checkbox#Faire_Download_Image
  text "Enabling this option would increase the time taken to download products."
  block #Faire_DownloadProducts_Actions
    button "Load from FAIRE" primary
    button "Close"
modal#Faire_DownloadCustomers_Content small
  heading "Load customers from FAIRE"
  button "×"
  slot #Faire_DownloadCustomers_ValidationContainer (hidden)
  text "All customers from FAIRE will be loaded into Cin7 Core. If there is a customer in Cin7 Core with the same name as in FAI"
  block #Faire_DownloadCustomers_Actions
    button "Load from FAIRE" primary
    button "Close"
modal#Faire_DownloadSuppliers_Content small
  heading "Load suppliers from FAIRE"
  button "×"
  slot #Faire_DownloadSuppliers_ValidationContainer (hidden)
  text "All suppliers from FAIRE will be loaded into Cin7 Core. If there is a supplier in Cin7 Core with the same name as in FAI"
  block #Faire_DownloadSuppliers_Actions
    button "Load from FAIRE" primary
    button "Close"
modal#Faire_UpdateQuantity_Content small
  heading "Update stock levels in FAIRE"
  button "×"
  slot #Faire_UpdateQuantity_ValidationContainer (hidden)
  text "All products listed in Cin7 Core FAIRE catalog will be updated in FAIRE with current available quantities from Cin7 Core"
  block #Faire_UpdateQuantity_Actions
    button "Start" primary
    button "Close"
modal#Faire_DownloadOrders_Content small
  heading "Load orders from FAIRE"
  button "×"
  slot #Faire_DownloadOrders_ValidationContainer (hidden)
  text "All orders from FAIRE will be loaded into Cin7 Core as pending orders. This operation may take a long time. Please leave"
  label "Sales created since"
  slot #Faire_FromOrders
  block #Faire_DownloadOrders_Actions
    button "Load from FAIRE" primary
    button "Close"
form#frmProcess
```

## Components by bundle

What the page code builds and mounts into the layout's slots.

### `Faire2019`

10 grids · 31 standalone fields · 0 windows · 0 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `catalogGridContainer` · store `productStore` · placeholder `No products found.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | SKU | `ProductCode` |  | flex 1 | renderer() |  |
    | Product | `Name` |  | flex 2 | renderer() |  |
    | Category | `Category` |  | flex 1 | renderer() |  |
    | Status | `Status` |  | 100 | renderer() |  |
    | Available quantity | `Quantity` |  | 100 | renderer() |  |
    | Sync quantity | `SyncQuantity` |  | 100 |  |  |
    | Buffer inventory | `SyncBufferInventory` |  | 100 |  |  |
    | Price | `Price` |  | flex 1 | renderer() |  |

- **grid** · renders into `FaireDearTaxRules` · store `vEcsTaxMappingStore` · placeholder `Loading Faire taxes rates...`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Type | `Description` |  | flex 1 | RenderHTMLText |  |
    | Tax rule | `TaxRuleName` |  | flex 1 | renderer() |  |

- **grid** · renders into `FairePaymentMethodsToDear` · store `vEcsPaymentProcessorMappingStore` · placeholder `Loading Faire payment methods...`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Name | `PaymentProcessorName` |  | flex 1 | RenderHTMLText |  |
    | Payment account code | `AccountName` |  | flex 1 | renderer() |  |

- **grid** · renders into `divPendingOrdersGrid` · store `pendingOrdersStore` · placeholder `You do not have any pending Faire sales at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Order # | `OrderNumber` |  | 100 | renderer() |  |
    | Date | `DateCreated` | date column | 120 | renderer() |  |
    | Customer | `CustomerName` |  | flex 1 | renderer() |  |
    | Product | `Name` |  | flex 2 | renderer() |  |
    | Quantity | `Quantity` |  | 100 |  |  |
    | Total paid | `Total` |  | flex 1 | renderer() |  |

- **grid** · renders into `logGridContainer` · store `logStore` · placeholder `You do not have any captured FAIRE sales at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | FAIRE order # | `OrderNumber` |  | flex 1 |  |  |
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
    | Date | `SaleOrderDate` |  | 130 | renderer() |  |
    | Sale # | `SaleOrderNumber` |  | 130 | renderer() |  |
    | Customer | `CustomerName` |  | flex 3 | RenderHTMLText |  |

- **grid** · renders into `overviewCustomersGridContainer` · store `overviewCustomersStore` · placeholder `No customers yet.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Customer | `Name` |  | flex 3 | renderer() |  |
    | Total by today | `PaidTotalAmount` |  | flex 1 | renderer() |  |

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

- **grid** · renders into `carriersMappingGridContainer` · store `vEcsCarriersMappingStore` · placeholder `Ext.String.format(…)`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | {Ext.String.format(…)} | `Description` |  | flex 1 | RenderHTMLText |  |
    | FAIRE carrier | `ECSCarrierCode` |  | flex 1 | renderer() |  |


#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| text field |  | `Faire_Index_ShopName` | `` |  |
| text field |  | `Faire_Index_APIKey` | `` |  |
| combo |  | `Faire_Index_Topic` | `TopicStore` | shows `description` · value `type` · pick-only |
| combo |  | `Faire_Index_ConsolidationType` | `ConsolidationTypeStore` | shows `description` · value `type` · pick-only |
| combo |  | `Faire_Index_ConsolidationTime` | `vTimeStore` | shows `Name` · value `Value` · pick-only |
| combo |  | `Faire_Index_Customer` | `vCustomerStore` | shows `Name` · value `CustomerID` · placeholder `Choose...` |
| combo |  | `Faire_Editor_WholeSalePriceTier` | `vSalesPriceTiersStore` | shows `Name` · value `Code` · placeholder `Choose...` · pick-only |
| combo |  | `Faire_Editor_RetailPriceTier` | `vSalesPriceTiersStore` | shows `Name` · value `Code` · placeholder `Choose...` · pick-only |
| combo |  | `Faire_Editor_LinkStoreToDear` | `LocationStore` | shows `Description` · value `LocationID` · placeholder `Choose...` · pick-only |
| combo |  | `Faire_Editor_InvoiceStatus` | `InvoiceStatusStore` | shows `name` · value `value` · placeholder `Choose...` · pick-only |
| combo |  | `Faire_Editor_AutoFulfilmentMode` | `AutoFulfilmentModeStore` | shows `name` · value `value` · placeholder `Choose...` · pick-only |
| combo |  | `Faire_Index_CreateAssembly` | `CreateAssemblyStore` | shows `name` · value `value` · placeholder `Choose...` · pick-only |
| combo |  | `Faire_Index_RevenueAccount` | `RevenueAccountStore` | shows `DisplayName` · value `Code` · placeholder `Choose...` |
| combo |  | `tdBulkListingTaxonomyType` | `TaxonomyTypeStore` | shows `Name` · value `Id` · placeholder `List all categories` |
| combo |  | `tdBulkListingTaxonomyTypeModal` | `TaxonomyTypeStore` | shows `Name` · value `Id` · placeholder `List all categories` |
| text field |  | `Faire_Index_CustomSalesRepresentative` | `` | placeholder `write...` |
| number field |  | `Faire_Index_BufferInventory` | `` | placeholder `0` |
| number field |  | `Faire_Catalog_BufferInventory` | `` | placeholder `0` |
| combo |  | `Faire_Index_TaxRuleMappingMode` | `TaxRuleMappingModeStore` | shows `name` · value `value` · placeholder `Choose...` · pick-only |
| date field |  | `Faire_FromOrders` | `` | placeholder `Choose...` · format `UserDateFormat` |
| combo |  | `tdBulkCategory` | `CategoryStore` | shows `Category` · value `CategoryID` · placeholder `List all categories` |
| combo |  | `tdBulkTag` | `TagsStore` | shows `Value` · value `Value` · placeholder `List all tags` |
| combo |  | `tdBulkListingStatus` | `BulkListingStatusStore` | shows `Name` · value `Value` · placeholder `List all products` · pick-only |
| number field |  | `tdBulkBufferInventory` | `` | placeholder `0` |
| combo |  | `tdBulkUseBufferInventory` | `UseBufferInventoryOptionsStore` | shows `name` · value `value` · placeholder `Don’t update existing setting` · pick-only |
| text field |  | `CreationDate` | `` |  |
| combo |  | `tdBulkListingBrand` | `vTenantBrandStore` | shows `Brand` · value `ID` · placeholder `List all brands` |
| combo |  | `tdBulkListingListedIn` | `ECommerceShopStore` | shows `ShopName` · value `ConfigID` · placeholder `Choose...` |
| date field |  | `divExportLogFrom` | `` | format `UserDateFormat` |
| date field |  | `divExportLogTo` | `` | format `UserDateFormat` |
| combo |  | `divExportLogPeriod` | `periodStore` | shows `name` · value `value` · pick-only |

