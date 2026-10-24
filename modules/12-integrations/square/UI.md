# Square: UI

Every component the page code builds, read from the shipped ExtJS bundles: grids with their columns, fields, buttons, menus, windows and custom components. Labels are the English UI text. `renders into` is the id of the `<div>` in the page's server-rendered HTML that the component mounts in; `store` names the data store (see the endpoints in [README.md](README.md)); `on click` is the handler. Visual system and shell layout: [docs/UI.md](../../../docs/UI.md).

## Screens

| Route | Title | Bundles |
|---|---|---|
| `/Square/Main` | Square | [`Square2019`](#square2019) |

## Layout

Each screen's server-rendered HTML inside the shell, as an outline: headings, tabs, sections, labels, inputs (`#id`), buttons (`▾` = dropdown), menus, tables and `slot`s (empty `<div>`s the components below mount into). `(hidden)` parts are shown by the page code when needed. Read with GET from a signed-in session; no values are kept.

### `/Square/Main`: Square

Frame: `task-upload-frame`.

```text
link "Home"
link "Integrations"
tabs#portal-main-tab: Overview #tab_overview |  #tab-add-new | Help #tab-portal-help
tab pane#tab_overview
  tabs#overview-list: 
  block #overview-content
    text "Square"
    text "Read the full information sheet about Square and Cin7 Core integration."
    button "Read information sheet" primary
    button "Help" primary
    tab pane#overview-content-tab
      heading #overview-portal-name
      block #overview-base-portal-settings
        text "Base settings"
        slot #overview-portal-settings
        slot #overview-portal-link
      block #overview-content
        block #overview-portal-logo
        block #OverviewSalesSummary
          text "Sales summary"
          button "Refresh"#divRefreshSalesSummary
          slot #overview-sales-summary
      tabs#overview-tabs: Sales #overview-tab-sales | Customers #overview-tab-customers
      tab pane#overview-tab-sales
        input text#divSearchOverviewSales placeholder "Type text to search"
        button "Search" primary
        button #OverviewSalesGrid_Options
        slot #overviewSalesGridContainer
      tab pane#overview-tab-customers
        input text#divSearchOverviewCustomers placeholder "Type text to search"
        button "Search" primary
        button #OverviewCustomersGrid_Options
        slot #overviewCustomersGridContainer
tab pane#tab-portal-settings
  tabs: Setup #tab-portal-setup | Catalog #tab-portal-catalog | Bulk listing #tab-portal-bulkLoad | Pending orders #tab-portal-pendingOrders | Log #tab-portal-log | Operations log #tab-shop-operationsLog
  text "Square"
  text "Read the full information sheet about Square and Cin7 Core integration."
  button "Read information sheet" primary
  button "Help" primary
  block #authError (hidden)
    button "Reconnect to Square" primary
  tab pane#tab-portal-setup
    heading "Setup"
    button "Save"#btnSaveSetupChanges primary
    slot #setupValidation
    label "Use Square integration to"
    slot #Square_Index_IntegrationType
    block #StoreConfig
      label "Capture order when it is"
      slot #Square_Index_Topic
      label "Consolidate orders"
      slot #Square_Index_ConsolidationType
      block #trDailyConsolidationWarning (hidden)
      block #liSquare_Index_ConsolidationTime (hidden)
        label "Consolidation time"
        slot #Square_Index_ConsolidationTime
      label "Customer"
      slot #Square_Index_Customer
      label "Price tier"
      slot #Square_Editor_PrimaryPriceTier
      label "Pick, pack, and ship processing mode"
      slot #Square_Editor_AutoFulfilmentMode
      block #chkIgnoreRestockForNotFulfilledContainer
        label "Ignore restock for non fulfilled sales"
        input checkbox#divIgnoreRestockForNotFulfilled
      label "Invoice status"
      slot #Square_Editor_InvoiceStatus
      label "Add a discount as"
      input radio#Square_Index_AddDiscountAsChangedPrice_1 name=Square_Index_AddDiscountAsChangedPrice
      label "Price reduction" for #Square_Index_AddDiscountAsChangedPrice_1
      input radio#Square_Index_AddDiscountAsChangedPrice_2 name=Square_Index_AddDiscountAsChangedPrice
      label "Additional charge" for #Square_Index_AddDiscountAsChangedPrice_2
      label "Link Square sales to Cin7 Core location"
      slot #Square_Editor_Location
      label "Gift card liability account"
      slot #Square_Editor_LiabilityAccount
      label "Optional revenue account"
      slot #Square_Editor_RevenueAccount
      label "Sales representative name"
      slot #Square_Editor_CustomSalesRepresentative
      label "Update stock levels in Square"
      input checkbox#Square_Index_SyncStockLevel
      block #chkUseBufferInventoryContainer
        label "Use buffer inventory"
        input checkbox#Square_Index_UseBufferInventory
      block #txtBufferInventoryContainer
        label "Buffer inventory"
        slot #Square_Index_BufferInventory
      block #wrnUseBufferInventory
        text "To enable the stock buffer only for specific products (like best-sellers), set 0 for 'Buffer inventory' here, and the re"
      label "Use Square as master source for Cin7 Core products"
      input checkbox#Square_Index_SyncCategoryAndBrand
      label "Export shipping information to Square"
      input checkbox#Square_Index_ExportShipInfo
      label "Process auto-assembly"
      slot #Square_Index_CreateAssembly
    text "Link Square and Cin7 Core tax rules"
    slot #divTaxMapping
    text "Link Square payment methods to payment accounts"
    button "Load from Square"#divLoadPaymentProcessorMapping primary
    text "You can select accounts to use for payments received via listed payment methods if account has type "BANK" or has indica"
    slot #divPaymentProcessorMapping
    text "Disconnect from your Square store"
    text "Square integration status Enabled"
    form#frmDisconnect
    slot #CreationDate
    button "Disconnect from Square store"
    block #divUpdate
      text "Update Square permissions"
      button "Update Square permissions" primary
  tab pane#tab-portal-catalog
    heading "Catalog"
    input text#divSearchCatalog placeholder "Type text to search"
    button "Search" primary
    button "Load products"#divDownloadProducts
    button "Update quantities in Square"#divUploadQuantities
    button "Refresh"#divRefreshCatalog
    button #CatalogGrid_Options
    slot #catalogGridContainer
  tab pane#tab-portal-bulkLoad
    heading "Bulk list your products in Square store."
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
    slot #Square_BulkListing_ValidationContainer (hidden)
    input text#divSearchBulk placeholder "Type text to search"
    button "Search" primary
    button "List"#btnListBulk
    button "Unlist"#btnUnlistBulk
    button "Unlink"#btnUnlinkBulk
    button "Refresh"#divRefreshBulkCatalog
    button #bulkGrid_Options
    slot #divBulkList
  tab pane#tab-portal-pendingOrders
    heading "Pending orders"
    input text#divSearchPendingOrders placeholder "Type text to search"
    button "Search" primary
    button "Load orders"#divDownloadOrders
    button "Process"#divProcessOrders
    button "Refresh"#divRefreshPendingOrders
    button #PendingOrdersGrid_Options
    slot #divPendingOrdersGrid
    form#frmProcess
  tab pane#tab-portal-log
    heading "Logs"
    input text#divSearchLog placeholder "Type text to search"
    button "Search" primary
    button "Refresh"#divRefreshLog
    button #LogGrid_Options
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
  heading "Link your Square shop with Cin7 Core"
  button "Connect to Square"#btnConnectToShop primary
  button "Cancel"#btnSquareLocationSelected
  button "Finish"#btnSquareLocationCancel primary
  form#frmAuthorise
  form#frmUpdatePermissions
  form#frmSelectLocation
  form#frmSelectLocationCancel
tab pane#tab-portal-help
  heading "Help"
  link "Square - Start your FREE trial now!"
  button "Read information sheet" primary
modal#Square_UpdateQuantity_Content medium
  heading "Update quantities in Square"
  button "×"
  slot #Square_UpdateQuantity_ValidationContainer
  block #Square_UpdateQuantity_Actions
    button "Start" primary
    button "Close"
modal#Square_Index_Catalog medium
  heading "Square product management"
  button "×"
  slot #Square_Catalog_ValidationContainer
  label "SKU"
  slot #Square_Catalog_ProductCode
  label "Product name"
  slot #Square_Catalog_ProductName
  label "Status"
  slot #Square_Catalog_Status
  label "Sync stock level"
  input checkbox#Square_Catalog_SyncStockLevel
  block #Square_Catalog_BufferInventoryControlsWarning
    slot #Square_Catalog_BufferInventoryControlsWarningCount
  block #Square_Catalog_BufferInventoryControlsContainer
    block #Square_Catalog_UseBufferInventoryContainer
      label "Use product-level buffer inventory"
      input checkbox#Square_Catalog_UseBufferInventory
    block #Square_Catalog_BufferInventoryContainer
      label "Product-level buffer"
      slot #Square_Catalog_BufferInventory
  block #Square_Catalog_AllActions
    button "List on Square"#Square_Catalog_List primary
    button "Update on Square"#Square_Catalog_Update primary
    button "Unlink from Square"#Square_Catalog_UnList
    button "Remove from Square"#Square_Catalog_Remove
    button "Save"#Square_Catalog_Save primary
    button "Close"
modal#Square_DownloadProducts_Content medium
  heading "Load products from Square"
  button "×"
  slot #Square_DownloadProducts_ValidationContainer
  label "Enable image download" for #Square_Download_Image
  input checkbox#Square_Download_Image
  text "Enabling this option would increase the time taken to download products."
  block #Square_DownloadProducts_Actions
    button "Load from Square" primary
    button "Close"
modal#Square_DownloadOrders_Content medium
  heading "Load orders from Square"
  button "×"
  slot #Square_DownloadOrders_ValidationContainer
  text "All orders created on or after the selected date will be loaded to Cin7 Core."
  label "Sales created since"
  slot #Square_FromOrders
  block #Square_DownloadOrders_Actions
    button "Load from Square" primary
    button "Close"
modal#Square_DownloadCustomers_Content medium
  heading "Load customers from Square"
  button "×"
  slot #Square_DownloadCustomers_ValidationContainer
  block #Square_DownloadCustomers_Actions
    button "Load from Square" primary
    button "Close"
```

## Components by bundle

What the page code builds and mounts into the layout's slots.

### `Square2019`

9 grids · 27 standalone fields · 0 windows · 1 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `catalogGridContainer` · store `productStore` · placeholder `No products found.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | SKU | `ProductCode` |  | flex 1 | renderer() |  |
    | Product | `Name` |  | flex 2 | renderer() |  |
    | Category | `Category` |  | flex 1 | renderer() |  |
    | Price | `Price` |  | flex 1 | renderer() |  |
    | Available quantity | `Quantity` |  | flex 1 |  |  |
    | Sync quantity | `SyncQuantity` |  | 100 |  |  |
    | Buffer inventory | `SyncBufferInventory` |  | 100 |  |  |
    | Status | `Status` |  | flex 1 | renderer() |  |

- **grid** · renders into `divPaymentProcessorMapping` · store `vEcsPaymentProcessorMappingStore` · placeholder `The system is loading payment methods from Square sales done during l…`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Name | `PaymentProcessorName` |  | flex 1 | RenderHTMLText |  |
    | Payment account code | `LedgerAccount` |  | flex 1 | renderer() |  |

- **grid** · renders into `divTaxMapping` · store `vEcsTaxMappingStore` · placeholder `Loading Square taxes rates...`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Sale line type | `Description` |  | flex 1 | renderer() |  |
    | Tax rule | `TaxRuleName` |  | flex 1 | renderer() |  |

- **grid** · renders into `divPendingOrdersGrid` · store `pendingOrdersStore` · placeholder `You do not have any pending Square sales at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Order number | `OrderNumber` |  | flex 2 | renderer() |  |
    | Date | `DateCreated` | date column | 150 | renderer() |  |
    | Customer | `CustomerName` |  | flex 2 | renderer() |  |
    | Product | `Name` |  | flex 2 | renderer() |  |
    | Quantity | `Quantity` |  | flex 1 |  |  |
    | Total paid | `Total` |  | flex 1 | renderer() |  |

- **grid** · renders into `logGridContainer` · store `logStore` · placeholder `You do not have any captured Square sales at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Status | `Status` |  | flex 1 | renderer() |  |
    | Date | `Date` | date column | flex 1 | renderer() |  |
    | Download date | `DownloadDate` | date column | flex 1 | renderer() |  |
    | Process date | `ProcessDate` | date column | flex 1 | renderer() |  |
    | Square invoice # | `OrderNumber` |  | flex 1 |  |  |
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

- **grid** · renders into `divBulkList` · store `bulkStore` · placeholder `No products found.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Category | `Category` |  | flex 1 | renderer() |  |
    | SKU | `ProductCode` |  | flex 1 | renderer() |  |
    | Product | `Name` |  | flex 2 | renderer() |  |
    | Available quantity | `Quantity` |  | flex 1 |  |  |
    | Sync quantity | `SyncQuantity` |  | 100 |  |  |
    | Buffer inventory | `SyncBufferInventory` |  | 100 |  |  |
    | Price | `Price` |  | flex 1 | renderer() |  |
    | Status | `Status` |  | flex 1 | renderer() |  |

- **grid** · renders into `overviewSalesGridContainer` · store `overviewSalesStore` · placeholder `No sales yet.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    |  | `Status` |  | 100 | renderer() |  |
    | Number | `SaleOrderNumber` |  | 130 | renderer() |  |
    | Date | `SaleOrderDate` |  | 130 | renderer() |  |
    | Customer | `CustomerName` |  | flex 1 | RenderHTMLText |  |
    | Amount | `PaidTotalAmount` |  | 130 | renderer() |  |

- **grid** · renders into `overviewCustomersGridContainer` · store `overviewCustomersStore` · placeholder `No customers yet.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Customer | `Name` |  | flex 1 | renderer() |  |
    | Sales | `OrderCount` |  | 100 |  |  |
    | Amount | `PaidTotalAmount` |  | 130 | renderer() |  |


#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| combo |  | `Square_Index_Topic` | `TopicStore` | shows `description` · value `type` · pick-only |
| combo |  | `Square_Index_IntegrationType` | `IntegrationTypeStore` | shows `name` · value `value` · pick-only |
| combo |  | `Square_Index_ConsolidationType` | `ConsolidationTypeStore` | shows `description` · value `type` · pick-only |
| combo |  | `Square_Index_ConsolidationTime` | `vTimeStore` | shows `Name` · value `Value` · pick-only |
| combo |  | `Square_Index_Customer` | `vCustomerStore` | shows `Name` · value `CustomerID` · placeholder `Choose...` |
| combo |  | `Square_Editor_PrimaryPriceTier` | `vSalesPriceTiersStore` | shows `Name` · value `Code` · placeholder `Choose...` · pick-only |
| combo |  | `Square_Editor_AutoFulfilmentMode` | `AutoFulfilmentModeStore` | shows `name` · value `value` · placeholder `Choose...` · pick-only |
| combo |  | `Square_Editor_InvoiceStatus` | `InvoiceStatusStore` | shows `name` · value `value` · placeholder `Choose...` · pick-only |
| combo |  | `Square_Index_CreateAssembly` | `CreateAssemblyStore` | shows `name` · value `value` · placeholder `Choose...` · pick-only |
| combo |  | `Square_Editor_Location` | `LocationStore` | shows `Description` · value `LocationID` · placeholder `Choose warehouse...` · pick-only |
| combo |  | `Square_Editor_LiabilityAccount` | `LiabilityAccountStore` | shows `DisplayName` · value `Code` · placeholder `Choose...` · pick-only |
| combo |  | `Square_Editor_RevenueAccount` | `RevenueAccountStore` | shows `DisplayName` · value `Code` · placeholder `Choose...` |
| text field |  | `Square_Editor_CustomSalesRepresentative` | `` | placeholder `write...` |
| number field |  | `Square_Index_BufferInventory` | `` | placeholder `0` |
| number field |  | `Square_Catalog_BufferInventory` | `` | placeholder `0` |
| date field |  | `Square_FromOrders` | `` | placeholder `Choose...` · format `UserDateFormat` |
| combo |  | `tdBulkCategory` | `CategoryStore` | shows `Category` · value `CategoryID` · placeholder `List all categories` |
| combo |  | `tdBulkTag` | `TagsStore` | shows `Value` · value `Value` · placeholder `List all tags` |
| combo |  | `tdBulkListingStatus` | `BulkListingStatusStore` | shows `Name` · value `Value` · placeholder `List all products` · pick-only |
| number field |  | `tdBulkBufferInventory` | `` | placeholder `0` |
| combo |  | `tdBulkUseBufferInventory` | `UseBufferInventoryOptionsStore` | shows `name` · value `value` · placeholder `Don’t update existing setting` · pick-only |
| combo |  | `Square_Is_Virtual_Store_Connection` | `IsVirtualStore` | shows `name` · value `value` · placeholder `choose...` · pick-only |
| combo |  | `tdBulkListingBrand` | `vTenantBrandStore` | shows `Brand` · value `ID` · placeholder `List all brands` |
| combo |  | `tdBulkListingListedIn` | `ECommerceShopStore` | shows `ShopName` · value `ConfigID` · placeholder `Choose...` |
| date field |  | `divExportLogFrom` | `` | format `UserDateFormat` |
| date field |  | `divExportLogTo` | `` | format `UserDateFormat` |
| combo |  | `divExportLogPeriod` | `periodStore` | shows `name` · value `value` · pick-only |

#### Menus, buttons and other parts

- **component** · renders into `tdBulkFamily` · store `FamilyStore` · shows `Name` · value `ID` · placeholder `List all families`

