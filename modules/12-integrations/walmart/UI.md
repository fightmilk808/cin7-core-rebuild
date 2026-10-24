# Walmart: UI

Every component the page code builds, read from the shipped ExtJS bundles: grids with their columns, fields, buttons, menus, windows and custom components. Labels are the English UI text. `renders into` is the id of the `<div>` in the page's server-rendered HTML that the component mounts in; `store` names the data store (see the endpoints in [README.md](README.md)); `on click` is the handler. Visual system and shell layout: [docs/UI.md](../../../docs/UI.md).

## Screens

| Route | Title | Bundles |
|---|---|---|
| `/Walmart` | Walmart | [`Walmart2019`](#walmart2019) |

## Layout

Each screen's server-rendered HTML inside the shell, as an outline: headings, tabs, sections, labels, inputs (`#id`), buttons (`▾` = dropdown), menus, tables and `slot`s (empty `<div>`s the components below mount into). `(hidden)` parts are shown by the page code when needed. Read with GET from a signed-in session; no values are kept.

### `/Walmart`: Walmart

Frame: `task-upload-frame`.

```text
link "Home"
link "Integrations"
button "Back to list"#backAction
tabs#portal-main-tab: Overview #tab_overview |  #tab-add-new | Help
block #divAllBlocks
  tab pane#tab_overview
    tabs#overview-list: 
    block #overview-content (hidden)
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
    tabs: Setup #tab-shop-setup | Catalog #tab-shop-catalog | Pending orders #tab-shop-pendingOrders | Log #tab-shop-log | Operations log #tab-shop-operationsLog
    tab pane#tab-shop-setup
      heading "Setup"
      block #btnSaveSetupChanges
        button "Save" primary
      block #authError (hidden)
        form#frmReConnect
          text "Your Walmart integration is going to disconnect. Click Reconnect to Walmart to re-authenticate your connection using Wal"
      slot #setupValidation (hidden)
      text "General settings"
      label "Load from Walmart" for #Walmart_Index_Topic
      slot #Walmart_Index_Topic
      label "Price tier" for #Walmart_Editor_PrimaryPriceTier
      slot #Walmart_Editor_PrimaryPriceTier
      label "Customer" for #Walmart_Index_Customer
      slot #Walmart_Index_Customer
      label "Sales representative name" for #Walmart_Editor_CustomSalesRepresentative
      slot #Walmart_Editor_CustomSalesRepresentative
      label "Consolidate orders" for #Walmart_Index_ConsolidationType
      slot #Walmart_Index_ConsolidationType
      block #liWalmart_Index_ConsolidationTime (hidden)
        label "Consolidation time" for #Walmart_Index_ConsolidationTime
        slot #Walmart_Index_ConsolidationTime
      label "Location for merchant fulfilled orders" for #Walmart_Editor_Location
      slot #Walmart_Editor_Location
      label "Location for Walmart fulfilled orders" for #Walmart_Editor_LocationWFS
      slot #Walmart_Editor_LocationWFS
      label "Pick, pack, and ship processing mode" for #Walmart_Editor_AutoFulfilmentMode
      slot #Walmart_Editor_AutoFulfilmentMode
      label "Process auto-assembly" for #Walmart_Index_CreateAssembly
      slot #Walmart_Index_CreateAssembly
      block #chkIgnoreRestockForNotFulfilledContainer
        block #chkIgnoreRestockForNotFulfilledContainer
          label "Ignore restock for non fullfilled sales"
          input checkbox#divIgnoreRestockForNotFulfilled
      label "Match product manually"
      input checkbox#Walmart_Index_Mathcing
      block #Walmart_Index_AllowCreateDearProducts
        label "Create a new product if not found by SKU"
        input checkbox#Walmart_Index_AllowCreate
      label "Update stock levels in Walmart"
      input checkbox#Walmart_Index_SyncStockLevel
      label "Export shipping information to Walmart"
      input checkbox#Walmart_Index_ExportShipInfo
      block #chkUseBufferInventoryContainer
        label "Use buffer inventory"
        input checkbox#Walmart_Index_UseBufferInventory
      block #txtBufferInventoryContainer
        label "Buffer inventory"
        slot #Walmart_Index_BufferInventory
      text "Account and cash settings"
      label "Invoice status" for #Walmart_Editor_InvoiceStatus
      slot #Walmart_Editor_InvoiceStatus
      label "Optional revenue account" for #Walmart_Editor_RevenueAccount
      slot #Walmart_Editor_RevenueAccount
      label "Ignore Walmart taxes"
      input checkbox#Walmart_Index_IgnoreTaxes
      label "Walmart payment method" for #Walmart_Editor_PaymentMethodBankAccount
      slot #Walmart_Editor_PaymentMethod
      label "Money settlement bank account" for #Walmart_Editor_MoneySettlementBankAccount
      slot #Walmart_Editor_MoneySettlementBankAccount
      text "Link Walmart and Cin7 Core tax rules"
      slot #taxRulesErrorContainer (hidden)
      button "Load from Walmart"#divLoadTaxMapping
      slot #divTaxMapping
      block #divDisconnect
        text "Disconnect from your Walmart store"
        form#frmDisconnect
        button "Disconnect from Walmart store"
    tab pane#tab-shop-catalog
      heading "Catalog"
      input text#divSearchCatalog placeholder "Type text to search"
      button "Search" primary
      label "Show variations separately"
      input checkbox#Walmart_Catalog_ViewMode
      label "Show only active listings"
      input checkbox#Walmart_Catalog_ListFilter
      button "Refresh"#divRefreshCatalog
      button "Load products"#divDownloadProducts
      button "Update quantities in Walmart"#divUploadQuantities
      button #CatalogGrid_Options
      slot #catalogGridContainer
    tab pane#tab-shop-pendingOrders
      heading "Orders"
      input text#divSearchPendingOrders placeholder "Type text to search"
      button "Search" primary
      button "Refresh"#divRefreshPendingOrders
      button "Load orders"#divDownloadOrders
      button "Process"#divProcessOrders
      button #Grid_PendingOrders_Options
      slot #divPendingOrdersGrid
    tab pane#tab-shop-log
      heading "Log"
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
      button "Search" primary
      button "Refresh"#divRefreshOperationsLog
      button #OperationsLogGrid_Options
      slot #operationsLogGridContainer
  tab pane#tab-add-new
    heading "Link your Walmart shop with Cin7 Core"
    text "Click Connect to Walmart to log in and authorize a connection to the Walmart marketplace. Get help in the Help Center"
    form#frmAuthorise
      label "Shop name" for #Title
      slot #Walmart_Index_ShopTitle
      label ""
      button "Connect to Walmart"#frmAuthoriseButton primary
    slot #authoriseValidation (hidden)
modal#Walmart_Index_Catalog medium
  heading "Link Walmart product to Cin7 Core product"
  button "×"
  slot #Walmart_Product_ImagePlaceholder
  heading #Walmart_Catalog_ProductName
  table
  slot #tabUnlinked
  slot #tabLinked
  slot #tabBuild
  input radio#rbtnUnlinked name=radioActionToDo
  label "Do not link Walmart product to any Cin7 Core product" for #rbtnUnlinked
  input radio#radioActionToDo
  label "Link Walmart product to the existing Cin7 Core product" for #radioActionToDo
  input radio#rbtnCreate name=radioActionToDo
  label "Create a new Cin7 Core product using Walmart product details" for #rbtnCreate
  tab pane#tabCatalogInfo
    text "Walmart product is not linked."
    text "You may choose what to do with an unlinked Walmart product. You can link it to the existing Cin7 Core product or create "
  tab pane#tabCatalogLink
    heading "Select Cin7 Core product to link with..."
    slot #Walmart_CatalogManagment_LinkToProduct_FakeForREsize
    slot #Walmart_CatalogManagment_LinkToProduct
    slot #linkedProductPreview
    block #Catalog_IgnoreProductUpdationBlock
      label "Do not update the linked Cin7 Core product"
      input checkbox#Walmart_Catalog_IgnoreProductUpdation
  tab pane#tabCatalogBuild
    heading "Create a new Cin7 Core product from Walmart listing and link..."
    button "Build and link"#btnBuildProduct primary
    slot #foundProductPreview
  block #Catalog_SyncStockLevelBlock
    label "Sync stock levels"
    input checkbox#Walmart_Catalog_SyncStockLevel
  block #Walmart_Catalog_BufferInventoryControlsWarning
    slot #Walmart_Catalog_BufferInventoryControlsWarningCount
  block #Walmart_Catalog_BufferInventoryControlsContainer
    block #Walmart_Catalog_UseBufferInventoryContainer
      label "Use product level buffer inventory"
      input checkbox#Walmart_Catalog_UseBufferInventory
  block #Walmart_Catalog_BufferInventoryContainer
    label "Product-level buffer"
    slot #Walmart_Catalog_BufferInventory
  block #Walmart_Catalog_AllActions
    button "Save"#Walmart_Catalog_Update primary
    button "Close"
modal#Walmart_DownloadProducts_Content medium
  heading "Load products from Walmart"
  button "×"
  slot #Walmart_DownloadProducts_ValidationContainer
  text "All not suppressed products from Walmart will be loaded into Cin7 Core. This operation may take a long time. Please leav"
  button "Start"#Walmart_DownloadProducts_Actions primary
  button "Close"
modal#Walmart_DownloadOrders_Content medium
  heading "Load orders from Walmart"
  button "×"
  slot #Walmart_DownloadOrders_ValidationContainer
  text "All orders from Walmart will be loaded into Cin7 Core as pending orders. This operation may take a long time. Please lea"
  label "Orders created since"
  slot #Walmart_FromOrders
  block #Walmart_DownloadOrders_Actions
    button "Start" primary
    button "Close"
modal#Walmart_UpdateQuantity_Content medium
  heading "Update quantities in Walmart"
  button "×"
  slot #Walmart_UpdateQuantity_ValidationContainer
  text "All products listed in Cin7 Core Walmart catalog will be updated in Walmart with current available quantities from Cin7 "
  button "Start"#Walmart_UpdateQuantity_Actions primary
  button "Close"
form#frmProcess
```

## Components by bundle

What the page code builds and mounts into the layout's slots.

### `Walmart2019`

7 grids · 24 standalone fields · 0 windows · 2 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `divPendingOrdersGrid` · store `pendingOrdersStore` · placeholder `You do not have any pending Walmart sales at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Order # | `OrderNumber` |  | 100 | renderer() |  |
    | Date | `DateCreated` | date column | 120 | renderer() |  |
    | Customer | `CustomerName` |  | flex 1 | renderer() |  |
    | Product | `Name` |  | flex 2 | renderer() |  |
    | Quantity | `Quantity` |  | 100 |  |  |
    | Total paid | `Total` |  | flex 1 | renderer() |  |

- **grid** · renders into `logGridContainer` · store `logStore` · placeholder `You do not have any captured Walmart orders at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Status | `Status` |  | flex 1 | renderer() |  |
    | Date | `Date` | date column | flex 1 | renderer() |  |
    | Download date | `DownloadDate` | date column | flex 1 | renderer() |  |
    | Process date | `ProcessDate` | date column | flex 1 | renderer() |  |
    | Invoice # | `OrderNumber` |  | flex 1 |  |  |
    | Type | `Type` |  | flex 1 | renderer() |  |
    | Sale task | `SaleOrderNumber` |  | flex 1 | renderer() |  |

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

- **grid** · renders into `divTaxMapping` · store `vEcsTaxMappingStore` · placeholder `There are no tax rates.`
  - *columns:*
    - *(component built elsewhere: `taxMappingColumns`)*
- **grid** · renders into `catalogGridContainer` · store `productStore` · placeholder `There are no products in the catalog.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | SKU | `SKU` |  | flex 2 | renderer() |  |
    | Name | `Name` |  | flex 4 | renderer() |  |
    | Category | `Category` |  | flex 2 | renderer() |  |
    | Price | `Price` |  | flex 1 | renderer() |  |
    | Status | `Status` |  | 85 | renderer() |  |
    | Quantity | `Quantity` |  | 95 | renderer() |  |
    | Sync quantity | `Quantity` |  | 95 | renderer() |  |
    | Buffer inventory | `BufferInventory` |  | 95 | renderer() |  |
    | Linked product | `ProductID` |  | flex 4 | renderer() |  |


#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| text field |  | `Walmart_Index_ShopTitle` | `title` |  |
| combo |  | `Walmart_Index_Topic` | `TopicStore` | shows `description` · value `type` · placeholder `Choose...` · pick-only |
| combo |  | `Walmart_Editor_PrimaryPriceTier` | `vSalesPriceTiersStore` | shows `Name` · value `Code` · placeholder `Choose...` · pick-only |
| combo |  | `Walmart_Index_Customer` | `vCustomerStore` | shows `Name` · value `CustomerID` · placeholder `Choose...` |
| combo |  | `Walmart_Index_ConsolidationType` | `ConsolidationTypeStore` | shows `description` · value `type` · placeholder `Choose...` · pick-only |
| combo |  | `Walmart_Index_ConsolidationTime` | `vTimeStore` | shows `Name` · value `Value` · pick-only |
| combo |  | `Walmart_Editor_Location` | `LocationStore` | shows `Description` · value `LocationID` · placeholder `Choose a location...` · pick-only |
| combo |  | `Walmart_Editor_LocationWFS` | `ExtLocationStore` | shows `Description` · value `LocationID` · placeholder `Choose a location...` · pick-only |
| combo |  | `Walmart_Editor_AutoFulfilmentMode` | `AutoFulfilmentModeStore` | shows `name` · value `value` · placeholder `Choose...` · pick-only |
| combo |  | `Walmart_Index_CreateAssembly` | `CreateAssemblyStore` | shows `name` · value `value` · placeholder `Choose...` · pick-only |
| text field |  | `Walmart_Editor_CustomSalesRepresentative` | `` | placeholder `write...` |
| number field |  | `Walmart_Index_BufferInventory` | `` | placeholder `0` |
| combo |  | `Walmart_Editor_InvoiceStatus` | `InvoiceStatusStore` | shows `name` · value `value` · placeholder `Choose...` · pick-only |
| combo |  | `Walmart_Editor_RevenueAccount` | `RevenueAccountStore` | shows `DisplayName` · value `Code` · placeholder `Choose...` |
| combo |  | `Walmart_Editor_MoneySettlementBankAccount` | `MoneySettlementBankAccountStore` | shows `DisplayName` · value `AccountCode` · placeholder `Choose...` · pick-only |
| combo |  | `Walmart_Editor_PaymentMethod` | `AccountStore` | shows `DisplayName` · value `Code` · placeholder `Choose...` |
| combo |  | `Walmart_CatalogManagment_LinkToProduct` | `ProductChooseStore` | shows `Name` · value `ProductCode` |
| number field |  | `Walmart_Catalog_BufferInventory` | `` | placeholder `0` |
| date field |  | `Walmart_FromOrders` | `` | placeholder `Choose...` · format `UserDateFormat` |
| combo |  | `tdBulkListingBrand` | `vTenantBrandStore` | shows `Brand` · value `ID` · placeholder `List all brands` |
| combo |  | `tdBulkListingListedIn` | `ECommerceShopStore` | shows `ShopName` · value `ConfigID` · placeholder `Choose...` |
| date field |  | `divExportLogFrom` | `` | format `UserDateFormat` |
| date field |  | `divExportLogTo` | `` | format `UserDateFormat` |
| combo |  | `divExportLogPeriod` | `periodStore` | shows `name` · value `value` · pick-only |

#### Menus, buttons and other parts

- **column** “Type” · field `Description`
- **column** “Tax rule” · field `TaxRuleName`

