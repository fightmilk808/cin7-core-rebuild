# Amazon: UI

Every component the page code builds, read from the shipped ExtJS bundles: grids with their columns, fields, buttons, menus, windows and custom components. Labels are the English UI text. `renders into` is the id of the `<div>` in the page's server-rendered HTML that the component mounts in; `store` names the data store (see the endpoints in [README.md](README.md)); `on click` is the handler. Visual system and shell layout: [docs/UI.md](../../../docs/UI.md).

## Screens

| Route | Title | Bundles |
|---|---|---|
| `/Amazon` | Amazon | [`Amazon2019`](#amazon2019) |

## Layout

Each screen's server-rendered HTML inside the shell, as an outline: headings, tabs, sections, labels, inputs (`#id`), buttons (`▾` = dropdown), menus, tables and `slot`s (empty `<div>`s the components below mount into). `(hidden)` parts are shown by the page code when needed. Read with GET from a signed-in session; no values are kept.

### `/Amazon`: Amazon

Frame: `task-upload-frame`.

```text
link "Home"
link "Integrations"
button "Back to list"#backAction
tabs#shop-main-tab: Overview #tab_overview |  #tab-add-new | Help
block #divAllBlocks
  tab pane#tab_overview
    tabs#overview-list: 
    block #overview-content (hidden)
      text "Amazon"
      text "Read the full information sheet about Amazon and Cin7 Core integration."
      button "Read information sheet" primary
      button "Help" primary
      tab pane#overview-content-tab
        heading #overview-shop-name
        block #overview-base-shop-settings (hidden)
          block #overview-shop-logo
          text "Base settings"
          slot #overview-shop-settings (hidden)
          slot #overview-shop-link
        block #overview-shop-summary-logo
        text "Sales summary"
        button "Refresh"#divRefreshSalesSummary
        slot #overview-sales-summary
        tabs#overview-tabs: Sales #overview-tab-sales | Customers #overview-tab-customers
        tab pane#overview-tab-sales
          input text#divSearchOverviewSales placeholder "Type text to search"
          button "Search" primary
          slot #overviewSalesGridContainer
        tab pane#overview-tab-customers
          input text#divSearchOverviewCustomers placeholder "Type text to search"
          button "Search" primary
          slot #overviewCustomersGridContainer
  tab pane#tab-shop-settings
    tabs: Setup #tab-shop-setup | Action required #tab-shop-auth (hidden) | Carrier mapping #tab-shop-carrierMapping | Catalog #tab-shop-catalog | Pending orders #tab-shop-pendingOrders | Amazon settlement files #tab-shop-manualJournals | Log #tab-shop-log | Operations log #tab-shop-operationsLog
    text "Amazon"
    text "Read the full information sheet about Amazon and Cin7 Core integration."
    button "Read information sheet" primary
    button "Help" primary
    tab pane#tab-shop-setup
      heading "Setup"
      block #btnSaveSetupChanges
        button "Save" primary
      slot #setupValidation (hidden)
      text "General settings"
      label "Load from Amazon" for #Amazon_Index_Topic
      slot #Amazon_Index_Topic
      label "Price tier" for #Amazon_Editor_PrimaryPriceTier
      slot #Amazon_Editor_PrimaryPriceTier
      label "Customer" for #Amazon_Index_Customer
      slot #Amazon_Index_Customer
      label "Sales representative name" for #Amazon_Editor_CustomSalesRepresentative
      slot #Amazon_Editor_CustomSalesRepresentative
      label "Location for merchant fulfilled orders" for #Amazon_Editor_Location
      slot #Amazon_Editor_Location
      label "Location for Amazon fulfilled orders" for #Amazon_Editor_LocationFBA
      slot #Amazon_Editor_LocationFBA
      label "Pick, pack, and ship processing mode" for #Amazon_Editor_AutoFulfilmentMode
      slot #Amazon_Editor_AutoFulfilmentMode
      label "Process auto-assembly" for #Amazon_Index_CreateAssembly
      slot #Amazon_Index_CreateAssembly
      block #chkIgnoreRestockForNotFulfilledContainer
        block #chkIgnoreRestockForNotFulfilledContainer
          label "Ignore restock for non fulfilled sales"
          input checkbox#divIgnoreRestockForNotFulfilled
      label "Use Amazon as master source for Cin7 Core products"
      input checkbox#Amazon_Index_UseAsMaster
      label "Match product manually"
      input checkbox#Amazon_Index_Mathcing
      block #Amazon_Index_AllowCreateDearProducts
        label "Create a new product if not found by SKU"
        input checkbox#Amazon_Index_AllowCreate
      label "Update stock levels in Amazon"
      input checkbox#Amazon_Index_SyncStockLevel
      label "Export shipping information to Amazon"
      input checkbox#Amazon_Index_ExportShipInfo
      text "Consolidation settings"
      label "Consolidate orders" for #Amazon_Index_ConsolidationType
      input checkbox#Amazon_Index_ConsolidationOption
      block #Amazon_Index_ConsolidationType-block (hidden)
        label "Type"
        block #divType
          input radio#radioConsolidationAll name=rbConsolidationType
          label "All" for #radioConsolidationAll
          input radio#radioConsolidationFbm name=rbConsolidationType
          label "FBM" for #radioConsolidationFbm
          input radio#radioConsolidationFba name=rbConsolidationType
          label "FBA" for #radioConsolidationFba
        label "Consolidation time" for #Amazon_Index_ConsolidationTime
        slot #Amazon_Index_ConsolidationTime
      text "Account and cash settings"
      label "Invoice status" for #Amazon_Editor_InvoiceStatus
      slot #Amazon_Editor_InvoiceStatus
      label "Optional revenue account" for #Amazon_Editor_RevenueAccount
      slot #Amazon_Editor_RevenueAccount
      label "Ignore Amazon taxes"
      input checkbox#Amazon_Index_IgnoreTaxes
      label "Process Amazon Settlements Report"
      input checkbox#Amazon_Index_ProcessMJ
      label "Money settlement bank account" for #Amazon_Editor_MoneySettlementBankAccount
      slot #Amazon_Editor_MoneySettlementBankAccount
      block #xero-settings-block (hidden)
        label "Xero synchronization mode"
        input radio#radioIndividualSales name=rbXeroSyncMode
        label "Sync individual sales" for #radioIndividualSales
        input radio#radioConsolidateBySettlement name=rbXeroSyncMode
        label "Consolidate by Amazon settlement" for #radioConsolidateBySettlement
      block #divGroupTransactionsBy (hidden)
        label "Group transactions by"
        select#txtGroupBy: All sales | By products | By product categories | By Xero tracking categories
      text "Link Amazon and Cin7 Core tax rules"
      button "Add an EU country tax rule"#divAddTaxMapping
      slot #divTaxMapping
      text "Link Amazon payment methods to payment accounts"
      button "Load from Amazon"#divLoadPaymentProcessorMapping
      text "You can select accounts to use for payments received via listed payment methods if account has type "BANK" or has indica"
      slot #divPaymentProcessorMapping
      text "Link chart of accounts and tax rules with Amazon transaction types"
      button "Load from Amazon"#divLoadManualJournalsMapping
      button "Set default tax rule"#btnSetDefaultTaxRule
      slot #divManualJournalsMapping
      block #divDisconnect
        text "Manage Amazon store connection"
        form#frmDisconnect
        button "Disconnect"
        button "Reauthorize"
    tab pane#tab-shop-carrierMapping
      button "Save changes" primary
      block #divCopyMappingsContainer (hidden)
        button "Copy mappings from..."#copyMappings ▾
        slot #copyMappingsDropDown
      slot #carrierMappingGrid
    tab pane#tab-shop-auth
      heading "Something went wrong"
      text "Please reauthorize to use this Amazon store integration."
      form#frmRefreshToken
      button "Reauthorize"
    tab pane#tab-shop-catalog
      heading "Catalog"
      input text#divSearchCatalog placeholder "Type text to search"
      button "Search" primary
      label "Show variations separately"
      input checkbox#Amazon_Catalog_ViewMode
      label "Show only active listings"
      input checkbox#Amazon_Catalog_ListFilter
      button "Refresh"#divRefreshCatalog
      button "Load products"#divDownloadProducts
      button "Update quantities in Amazon"#divUploadQuantities
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
    tab pane#tab-shop-manualJournals
      heading "Amazon settlement files"
      button "Refresh"#divRefreshManualJournals
      button "Load settlement data"#divDownloadManualJournals
      button #ManualJournalGrid_Options
      slot #divManualJournalGrid
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
    heading "Link your Amazon shop with Cin7 Core"
    text "This integration requires an Amazon Seller Pro account. We recommend you turn off the Amazon Open listings report notifi"
    block #addNewNote
      heading 
    form#frmAuthorise
      label "Amazon merchant token (Seller ID)" for #ShopName
      slot #Amazon_Index_ShopName
      label "Amazon Marketplace" for #Marketplace
      slot #Amazon_Index_Marketplace
      label "Store name" for #Title
      slot #Amazon_Index_ShopTitle
      label ""
      button "Connect to Amazon"#frmAuthoriseButton primary
block #Amazon_Index_CatalogFamily
  heading "Link Amazon products to Cin7 Core family products"
  slot #Amazon_Product_FamilyImagePlaceholder
  heading #Amazon_Catalog_FamilyProductName
  table
  heading "Select Cin7 Core family product to link with..."
  slot #Amazon_CatalogManagment_LinkToFamily_FakeForREsize
  slot #Amazon_CatalogManagment_LinkToFamily
  slot #linkedFamilyPreview
  slot #Amazon_Catalog_FamilyMappingGrid
  block #Amazon_Catalog_AllActions
    button "Save"#Amazon_Catalog_FamilyUpdate primary
    button "Close"#Amazon_Index_CatalogFamily_Cancel
modal#Amazon_TaxMapping_AddTaxMapping small
  heading "Select an EU country to create a taxation rule"
  button "×"
  label "Country"
  slot #Amazon_TaxMapping_Country
  block #Amazon_Catalog_AllActions
    button "Save"#Amazon_TaxMapping_Save primary
    button "Close"
modal#Amazon_Index_Catalog medium
  heading "Link Amazon product to Cin7 Core product"
  button "×"
  slot #Amazon_Product_ImagePlaceholder
  heading #Amazon_Catalog_ProductName
  table
  slot #tabUnlinked
  slot #tabLinked
  slot #tabBuild
  input radio#rbtnUnlinked name=radioActionToDo
  label "Do not link Amazon product to any Cin7 Core product" for #rbtnUnlinked
  input radio#radioActionToDo
  label "Link Amazon product to the existing Cin7 Core product" for #radioActionToDo
  input radio#rbtnCreate name=radioActionToDo
  label "Create a new Cin7 Core product using Amazon product details" for #rbtnCreate
  tab pane#tabCatalogInfo
    text "Amazon product is not linked."
    text "You may choose what to do with an unlinked Amazon product. You can link it to the existing Cin7 Core product or create a"
  tab pane#tabCatalogLink
    heading "Select Cin7 Core product to link with..."
    slot #Amazon_CatalogManagment_LinkToProduct_FakeForREsize
    slot #Amazon_CatalogManagment_LinkToProduct
    slot #linkedProductPreview
    block #Catalog_SyncStockLevelBlock
      label "Sync stock level"
      input checkbox#Amazon_Catalog_SyncStockLevel
    block #Catalog_IgnoreProductUpdationBlock
      label "Do not update the linked Cin7 Core product"
      input checkbox#Amazon_Catalog_IgnoreProductUpdation
  tab pane#tabCatalogBuild
    heading "Create a new Cin7 Core product from Amazon listing and link..."
    button "Build and link"#btnBuildProduct primary
    slot #foundProductPreview
  block #Amazon_Catalog_AllActions
    button "Save"#Amazon_Catalog_Update primary
    button "Close"
modal#Amazon_DownloadProducts_Content medium
  heading "Load products from Amazon"
  button "×"
  slot #Amazon_DownloadProducts_ValidationContainer
  text "All not suppressed products from Amazon will be loaded into Cin7 Core. This operation may take a long time. Please leave"
  label "Enable image download" for #Amazon_Download_Image
  input checkbox#Amazon_Download_Image
  text "Enabling this option would increase the time taken to download products."
  button "Start"#Amazon_DownloadProducts_Actions primary
  button "Close"
modal#Amazon_SettlementDetails_Content large
  heading "Settlement details"#Amazon_SettlementDetails_Dialog_Header
  button "×"
  slot #settlement-invoice-to-span
  slot #settlement-amount-span
  input text#divManualJournaLinesSearch placeholder "Type text to search"
  button "Search" primary
  button "Recalculate"#btnInvoiceRecalculate
  slot #divManualJournalLinesGrid
  button "Confirm sync with Xero"#amazon-confirm-invoice-button primary
  slot #settlement-invoice-links
  slot #settlement-cogs-span
  input text#divCogsSearch placeholder "Type text to search"
  button "Search" primary
  button "Recalculate"#btnCogsRecalculate
  slot #divCogsGrid
  button "Confirm sync with Xero"#amazon-confirm-cogs-button primary
  slot #settlement-cogs-links
modal#Amazon_UpdateQuantity_Content medium
  heading "Update quantities in Amazon"
  button "×"
  slot #Amazon_UpdateQuantity_ValidationContainer
  text "All products listed in Cin7 Core Amazon catalog will be updated in Amazon with current available quantities from Cin7 Co"
  button "Start"#Amazon_UpdateQuantity_Actions primary
  button "Close"
modal#Amazon_DownloadOrders_Content medium
  heading "Load orders from Amazon"
  button "×"
  slot #Amazon_DownloadOrders_ValidationContainer
  text "All orders from Amazon will be loaded into Cin7 Core as pending orders. This operation may take a long time. Please leav"
  slot #Amazon_FromOrders
  label "From"
  slot #Amazon_ToOrders
  label "To"
  block #Amazon_DownloadOrders_Actions
    button "Start" primary
    button "Close"
modal#Amazon_DownloadManualJournals_Content medium
  heading "Load manual journals from Amazon"
  button "×"
  slot #Amazon_DownloadManualJournals_ValidationContainer
  text "All new settlements from Amazon will be loaded into Cin7 Core as pending. This operation may take some time. Please leav"
  text "All settlements created on or after the selected date will be loaded to Cin7 Core"
  label "Since"
  slot #Amazon_FromManualJournals
  label "To"
  slot #Amazon_ToManualJournals
  block #Amazon_DownloadManualJournals_Actions
    button "Start"#btnStartImportMJ primary
    button "Close"
form#frmProcess
form#frmExport
```

## Components by bundle

What the page code builds and mounts into the layout's slots.

### `Amazon2019`

14 grids · 27 standalone fields · 0 windows · 0 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `divManualJournalsMapping` · store `vEcsManualJournalAccountMappingStore` · placeholder `There are no accounts.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Type | `EcsAccountType` |  | flex 1 |  |  |
    | Account | `Value` |  | flex 1 | renderer() |  |
    | Tax rule | `TaxRuleID` |  | flex 1 | renderer() |  |
    | Skip mapping | `SkipMapping` | check column | 100 | renderer() |  |

- **grid** · renders into `divTaxMapping` · store `vEcsTaxMappingStore` · placeholder `There are no tax rates.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Type | `Description` |  | flex 1 |  |  |
    | Tax rule | `TaxRuleName` |  | flex 1 | renderer() |  |

- **grid** · renders into `divPaymentProcessorMapping` · store `vEcsPaymentProcessorMappingStore` · placeholder `There are no known payment methods. Try to create a paid order.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Name | `PaymentProcessorName` |  | flex 1 |  |  |
    | Payment account code | `LedgerAccount` |  | flex 1 | renderer() |  |

- **grid** · renders into `divManualJournalGrid` · store `manualJournalStore` · placeholder `You do not have any Amazon settlements yet.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Date | `ActualDate` | date column | flex 1 | renderer() |  |
    | Start | `DateStart` | date column | flex 1 | renderer() |  |
    | End | `DateEnd` | date column | flex 1 | renderer() |  |
    | Status | `Status` |  | flex 1 | renderer() |  |
    | Action | `Status` |  | flex 1 | renderer() |  |

- **grid** · renders into `divCogsGrid` · store `cogsStore` · placeholder `You do not have any Amazon COGS yet.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | SKU | `SKU` |  | flex 1 |  |  |
    | Product name | `ProductName` |  | flex 3 |  |  |
    | Average cost | `AverageCost` |  | flex 1 | renderer() |  |
    | Sold qty | `SoldQty` |  | flex 1 |  |  |
    | Last updated date | `LastUpdatedDate` | date column | flex 1 | renderer() |  |
    | Last updated by | `LastUpdatedBy` |  | flex 1 |  |  |
    | Total cost | `TotalCost` |  | flex 1 | renderer() |  |

- **grid** · renders into `divManualJournalLinesGrid` · store `manualJournalLineStore` · placeholder `You do not have any Amazon lines yet.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Description | `Description` |  | flex 3 |  |  |
    | Amount | `Amount` |  | flex 1 | renderer() |  |
    | Account | `AccountCode` |  | flex 1 | renderer() |  |
    | Tax | `TaxRuleID` |  | flex 1 | renderer() |  |

- **grid** · renders into `divPendingOrdersGrid` · store `pendingOrdersStore` · placeholder `You do not have any pending Amazon orders at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Order # | `OrderNumber` |  | 100 | renderer() |  |
    | Date | `DateCreated` | date column | 120 | renderer() |  |
    | Customer | `CustomerName` |  | flex 1 | renderer() |  |
    | Product | `Name` |  | flex 1 | renderer() |  |
    | Quantity | `Quantity` |  | 100 |  |  |
    | Total | `Total` |  | 100 | renderer() |  |

- **grid** · renders into `logGridContainer` · store `logStore` · placeholder `You do not have any captured Amazon orders at the moment.`
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
    | Linked product | `ProductID` |  | flex 4 | renderer() |  |

- **grid** · renders into `Amazon_Catalog_FamilyMappingGrid` · store `variationStore` · placeholder `There are no variations.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    |  | `Status` | action column | 65 | renderer() |  |
    | Amazon product | `SKU` |  | flex 4 | renderer() |  |
    | Price | `Price` |  | flex 1 | renderer() |  |
    | Option 1 | `Option1` |  | flex 1 | renderer() |  |
    | Option 2 | `Option2` |  | flex 1 | renderer() |  |
    | Option 3 | `Option3` |  | flex 1 | renderer() |  |
    | Linked product | `ProductID` |  | flex 4 | renderer() |  |

- **grid** · renders into `carrierMappingGrid` · store `carrierMappingStore` · placeholder `You do not have any carrier at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | {Ext.String.format(…)} | `Description` |  | flex 1 | RenderHTMLText(…) |  |
    | Amazon carrier | `ECSCarrierCode` |  | flex 1 | RenderHTMLText(…) |  |


#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| text field |  | `Amazon_Index_ShopName` | `` |  |
| text field |  | `Amazon_Index_ShopTitle` | `` |  |
| combo |  | `Amazon_TaxMapping_Country` | `EUCountryStore` | shows `Name` · value `Code` · placeholder `Choose a country...` · pick-only |
| combo |  | `Amazon_Index_Marketplace` | `MarketPlaceStore` | shows `Name` · value `ID` · pick-only |
| combo |  | `Amazon_Index_Topic` | `TopicStore` | shows `description` · value `type` · pick-only |
| combo |  | `Amazon_Index_ConsolidationTime` | `vTimeStore` | shows `Name` · value `Value` · pick-only |
| combo |  | `Amazon_Index_Customer` | `vCustomerStore` | shows `Name` · value `CustomerID` · placeholder `Choose...` |
| combo |  | `Amazon_Editor_PrimaryPriceTier` | `vSalesPriceTiersStore` | shows `Name` · value `Code` · placeholder `Choose...` · pick-only |
| combo |  | `Amazon_Editor_AutoFulfilmentMode` | `AutoFulfilmentModeStore` | shows `name` · value `value` · placeholder `Choose...` · pick-only |
| combo |  | `Amazon_Editor_InvoiceStatus` | `InvoiceStatusStore` | shows `name` · value `value` · placeholder `Choose...` · pick-only |
| combo |  | `Amazon_Index_CreateAssembly` | `CreateAssemblyStore` | shows `name` · value `value` · placeholder `Choose...` · pick-only |
| combo |  | `Amazon_Editor_RevenueAccount` | `RevenueAccountStore` | shows `DisplayName` · value `Code` · placeholder `Choose...` |
| combo |  | `Amazon_Editor_MoneySettlementBankAccount` | `MoneySettlementBankAccountStore` | shows `DisplayName` · value `AccountCode` · placeholder `Choose...` · pick-only |
| text field |  | `Amazon_Editor_CustomSalesRepresentative` | `` | placeholder `write...` |
| combo |  | `Amazon_Editor_Location` | `LocationStore` | shows `Description` · value `LocationID` · placeholder `Choose a location...` · pick-only |
| combo |  | `Amazon_Editor_LocationFBA` | `ExtLocationStore` | shows `Description` · value `LocationID` · placeholder `Choose a location...` · pick-only |
| date field |  | `Amazon_FromOrders` | `` | placeholder `Choose...` · format `UserDateFormat` |
| date field |  | `Amazon_ToOrders` | `` | placeholder `Choose...` · format `UserDateFormat` |
| date field |  | `Amazon_FromManualJournals` | `` | placeholder `Choose...` · format `UserDateFormat` |
| date field |  | `Amazon_ToManualJournals` | `` | placeholder `Choose...` · format `UserDateFormat` |
| combo |  | `Amazon_CatalogManagment_LinkToProduct` | `ProductChooseStore` | shows `Name` · value `ProductCode` |
| combo |  | `Amazon_CatalogManagment_LinkToFamily` | `FamilyChooseStore` | shows `Name` · value `FamilyID` · placeholder `Do not link Amazon product` |
| combo |  | `tdBulkListingBrand` | `vTenantBrandStore` | shows `Brand` · value `ID` · placeholder `List all brands` |
| combo |  | `tdBulkListingListedIn` | `ECommerceShopStore` | shows `ShopName` · value `ConfigID` · placeholder `Choose...` |
| date field |  | `divExportLogFrom` | `` | format `UserDateFormat` |
| date field |  | `divExportLogTo` | `` | format `UserDateFormat` |
| combo |  | `divExportLogPeriod` | `periodStore` | shows `name` · value `value` · pick-only |

