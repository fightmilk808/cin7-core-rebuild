# Etsy: UI

Every component the page code builds, read from the shipped ExtJS bundles: grids with their columns, fields, buttons, menus, windows and custom components. Labels are the English UI text. `renders into` is the id of the `<div>` in the page's server-rendered HTML that the component mounts in; `store` names the data store (see the endpoints in [README.md](README.md)); `on click` is the handler. Visual system and shell layout: [docs/UI.md](../../../docs/UI.md).

## Screens

| Route | Title | Bundles |
|---|---|---|
| `/Etsy` | Etsy | [`Etsy2019`](#etsy2019) |

## Layout

Each screen's server-rendered HTML inside the shell, as an outline: headings, tabs, sections, labels, inputs (`#id`), buttons (`▾` = dropdown), menus, tables and `slot`s (empty `<div>`s the components below mount into). `(hidden)` parts are shown by the page code when needed. Read with GET from a signed-in session; no values are kept.

### `/Etsy`: Etsy

Frame: `task-upload-frame`.

```text
link "Home"
link "Integrations"
block #divTopBlock
  tabs#portal-main-tab: Overview #tab_overview |  #tab-add-new | Help #tab-portal-help
block #divAllBlocks
  tab pane#tab_overview
    tabs#overview-list: 
    block #overview-content
      text "Etsy"
      text "Read the full information sheet about Etsy and Cin7 Core integration."
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
    tabs: Setup #tab-portal-setup | Action required #tab-portal-auth | Catalog #tab-portal-catalog | Publishing #tab-portal-publish | Pending orders #tab-portal-pendingOrders | Log #tab-portal-log | Operations log #tab-portal-operationsLog
    text "Etsy"
    text "Read the full information sheet about Etsy and Cin7 Core integration."
    button "Read information sheet" primary
    button "Help" primary
    tab pane#tab-portal-setup
      heading "Setup"
      button "Save"#btnSaveSetupChanges primary
      slot #setupValidation
      label "Capture order when it is"
      slot #Etsy_Index_Topic
      label "Consolidate sales"
      slot #Etsy_Index_ConsolidationType
      block #trDailyConsolidationWarning (hidden)
      block #liEtsy_Index_ConsolidationTime (hidden)
        label "Consolidation time"
        slot #Etsy_Index_ConsolidationTime
      label "Customer"
      slot #Etsy_Index_Customer
      label "Store language"
      slot #Etsy_Index_Language
      label "Price tier"
      slot #Etsy_Editor_PrimaryPriceTier
      label "Link Etsy sales to Cin7 Core location"
      slot #Etsy_Editor_Location
      label "Pick, pack, and ship processing mode"
      slot #Etsy_Editor_AutoFulfilmentMode
      block #chkIgnoreRestockForNotFulfilledContainer
        label "Ignore restock for non fulfilled sales"
        input checkbox#divIgnoreRestockForNotFulfilled
      label "Invoice status"
      slot #Etsy_Editor_InvoiceStatus
      label "Optional revenue account"
      slot #Etsy_Editor_RevenueAccount
      label "Sales representative name"
      slot #Etsy_Editor_CustomSalesRepresentative
      label "Match product manually"
      input checkbox#Etsy_Index_Mathcing
      block #Etsy_Index_AllowCreateDearProducts
        label "Create a new product if not found by SKU"
        input checkbox#Etsy_Index_AllowCreate
      label "Use Etsy as master source for Cin7 Core products"
      input checkbox#Etsy_Index_UseAsMaster
      label "Update stock levels in Etsy"
      input checkbox#Etsy_Index_SyncStockLevel
      label "Allow Cin7 Core to activate/deactivate Etsy listings."
      input checkbox#Etsy_Index_AllowActivate
      label "Export shipping information to Etsy"
      input checkbox#Etsy_Index_ExportShipInfo
      label "Process auto-assembly"
      slot #Etsy_Index_CreateAssembly
      text "Link Etsy and Cin7 Core tax rules"
      slot #divTaxMapping
      text "Link Etsy payment methods to payment accounts"
      button "Load from Etsy"#divLoadPaymentProcessorMapping primary
      text "You can select accounts to use for payments received via listed payment methods if account has type "BANK" or has indica"
      slot #divPaymentProcessorMapping
      text "Disconnect from your Etsy store"
      slot #CreationDate
      button "Disconnect from Etsy store"
      form#frmDisconnect
    tab pane#tab-portal-auth
      heading "Connection with Etsy requires authorization"
      text "To allow Cin7 Core to access your Etsy store please"
      button "Reconnect to Etsy"
      form#frmRefreshToken
    tab pane#tab-portal-catalog
      heading "Catalog"
      button "Load products"#divDownloadProducts primary
      button "Update quantities in Etsy"#divUploadQuantities primary
      input checkbox#Etsy_Catalog_ViewMode
      label "Show variations separately" for #Etsy_Catalog_ViewMode
      input checkbox#Etsy_Catalog_ListFilter
      label "Show only active listings" for #Etsy_Catalog_ListFilter
      input text#divSearchCatalog placeholder "Type text to search"
      button "Search" primary
      button "Refresh"#divRefreshCatalog
      slot #catalogGridContainer
    tab pane#tab-portal-publish
      tabs: Not listed #tab_1_1 | Selected to be listed #tab_1_2 | Failed #tab_1_3 | Publishing profiles #tab_1_4
      tab pane#tab_1_1
        input text#Etsy_Publish_Search placeholder "Type text to search"
        button "Search" primary
        button "Select all"#btnPublishNotListedSelectAllFromPage primary
        button "Refresh"
        slot #dearCatalogGridContainer
      tab pane#tab_1_2
        button "Remove from the list"#btnPublishSelectedClear
        button "Bulk apply to..."#Etsy_Index_Publish_SelectedBulkMenuBtn primary ▾
        button "Publish"#btnPublishSelectedPublish primary
        button "Refresh"
        slot #dearSelectedCatalogGridContainer
      tab pane#tab_1_3
        input text#Etsy_Publish_SearchFailed placeholder "Type text to search"
        button "Search" primary
        button "Refresh"
        slot #failedPublishGridContainer
      tab pane#tab_1_4
        button "Create"#btnPublishingLProfileOpen primary
        button "Refresh"
        slot #EtsyListingProfilesContainer
    tab pane#tab-portal-pendingOrders
      heading "Pending orders"
      button "Load orders"#divDownloadOrders primary
      button "Process"#divProcessOrders primary
      input text#divSearchPendingOrders placeholder "Type text to search"
      button "Search" primary
      button "Refresh"#divRefreshPendingOrders
      slot #divPendingOrdersGrid
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
    tab pane#tab-portal-operationsLog
      heading "Operations log"
      input text#divSearchOperationsLog placeholder "Type text to search"
      button "Search" primary
      button "Refresh"#divRefreshOperationsLog
      button #OperationsLogGrid_Options
      slot #operationsLogGridContainer
  tab pane#tab-add-new
    heading "Link your Etsy shop with Cin7 Core"
    button "Connect to Etsy"#btnConnectToShop primary
    form#frmAuthorise
      label "Your shop name at Etsy"
      slot #Etsy_Index_ShopName
  tab pane#tab-portal-help
    heading "Help"
    button "Read information sheet" primary
modal#Etsy_Index_CatalogFamily large
  heading "Link Etsy products to Cin7 Core family products"
  button "×"
  slot #Etsy_Product_FamilyImagePlaceholder
  heading #Etsy_Catalog_FamilyProductName
  table
  tab pane
    heading "Select Cin7 Core family product to link with..."
    slot #Etsy_CatalogManagment_LinkToFamily
    slot #linkedFamilyPreview
    slot #Etsy_Catalog_FamilyMappingGrid
  block #Etsy_Catalog_FamilyAllActions
    button "Save"#Etsy_Catalog_FamilyUpdate primary
    button "Close"#Etsy_Index_CatalogFamily_Cancel
block #Etsy_PListingDialog_Content (hidden)
  heading "Publishing profile for Etsy"
  button "Next"#Etsy_PublishProfile_Next primary
  button "Save"#Etsy_PublishProfile_Save primary
  button "Close"#Etsy_PublishProfile_Cancel
  label "Please type the name of the profile."
  input text#Etsy_LProfile_Name placeholder "Type a profile name here..."
  block #Etsy_LProfile_Step1
    label "Category"
    slot #Etsy_PListingDialog_Category
    label "Shipping template"
    slot #Etsy_LProfile_ShipTemplate
    label "Readiness State" for #Etsy_LProfile_ReadinessState_Input
    slot #Etsy_LProfile_ReadinessState
    label "Who made"
    slot #Etsy_LProfile_Who
    label "When made"
    slot #Etsy_LProfile_When
    label "Is not taxable"
    input checkbox#Etsy_LProfile_NonTaxable
    label "The product is a supply"
    input checkbox#Etsy_LProfile_IsSupply
modal#Etsy_Index_Catalog large
  heading "Link Etsy product to Cin7 Core product"
  button "×"
  slot #Etsy_Product_ImagePlaceholder
  heading #Etsy_Catalog_ProductName
  table
  slot #tabUnlinked
  slot #tabLinked
  slot #tabBuild
  input radio#rbtnUnlinked name=radioActionToDo
  label "Do not link Etsy product to any Cin7 Core product" for #rbtnUnlinked
  input radio#rbtnLink name=radioActionToDo
  label "Link Etsy product to the existing Cin7 Core product" for #rbtnLink
  input radio#rbtnCreate name=radioActionToDo
  label "Create a new Cin7 Core product using Etsy product details" for #rbtnCreate
  tab pane#tabCatalogInfo
    heading "Etsy product is not linked."
  tab pane#tabCatalogLink
    heading "Select Cin7 Core product to link with..."
    slot #Etsy_CatalogManagment_LinkToProduct
    slot #linkedProductPreview
    block #Catalog_SyncStockLevelBlock
      input checkbox#Etsy_Catalog_SyncStockLevel
      label "Sync stock level" for #Etsy_Catalog_SyncStockLevel
    block #Catalog_IgnoreProductUpdationBlock
      input checkbox#Etsy_Catalog_IgnoreProductUpdation
      label "Do not update the linked Cin7 Core product" for #Etsy_Catalog_IgnoreProductUpdation
  tab pane#tabCatalogBuild
    heading "Create a new Cin7 Core product from Etsy listing and link..."
    button "Build and link"#btnBuildProduct primary
    slot #foundProductPreview
  block #Etsy_Catalog_AllActions
    button "Save"#Etsy_Catalog_Update primary
    button "Close"
modal#Etsy_DownloadProducts_Content medium
  heading "Load products from Etsy"
  button "×"
  slot #Etsy_DownloadProducts_ValidationContainer
  label "Enable image download" for #Etsy_Download_Image
  input checkbox#Etsy_Download_Image
  text "Enabling this option would increase the time taken to download products."
  block #Etsy_DownloadProducts_Actions
    button "Start" primary
    button "Close"
modal#Etsy_UpdateQuantity_Content medium
  heading "Update quantities in Etsy"
  button "×"
  slot #Etsy_UpdateQuantity_ValidationContainer
  block #Etsy_UpdateQuantity_Actions
    button "Start" primary
    button "Close"
modal#Etsy_DownloadOrders_Content medium
  heading "Load orders from Etsy"
  button "×"
  slot #Etsy_DownloadOrders_ValidationContainer
  text "All orders created on or after the selected date will be loaded to Cin7 Core."
  label "Orders created since"
  slot #Etsy_FromOrders
  block #Etsy_DownloadOrders_Actions
    button "Start" primary
    button "Close"
form#frmProcess
```

## Components by bundle

What the page code builds and mounts into the layout's slots.

### `Etsy2019`

13 grids · 28 standalone fields · 0 windows · 8 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `divTaxMapping` · store `vEcsTaxMappingStore` · placeholder `Loading Etsy tax rates...`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Type | `Description` |  | flex 1 | RenderHTMLText |  |
    | Tax rule | `TaxRuleName` |  | flex 1 | renderer() |  |

- **grid** · renders into `divPaymentProcessorMapping` · store `vEcsPaymentProcessorMappingStore` · placeholder `Loading Etsy payment methods...`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Name | `PaymentProcessorName` |  | flex 1 | RenderHTMLText |  |
    | Payment account code | `LedgerAccount` |  | flex 1 | renderer() |  |

- **grid** · renders into `divPendingOrdersGrid` · store `pendingOrdersStore` · placeholder `You do not have any pending Etsy sales at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Order number | `OrderNumber` |  | flex 2 | renderer() |  |
    | Date | `DateCreated` | date column | 150 | renderer() |  |
    | Customer | `CustomerName` |  | flex 2 | renderer() |  |
    | Product | `Name` |  | flex 2 | renderer() |  |
    | Quantity | `Quantity` |  | flex 1 |  |  |
    | Total paid | `Total` |  | flex 1 | renderer() |  |

- **grid** · renders into `logGridContainer` · store `logStore` · placeholder `You do not have any captured Etsy sales at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Status | `Status` |  | flex 1 | renderer() |  |
    | Date | `Date` | date column | flex 1 | renderer() |  |
    | Download date | `DownloadDate` | date column | flex 1 | renderer() |  |
    | Process date | `ProcessDate` | date column | flex 1 | renderer() |  |
    | Etsy invoice # | `OrderNumber` |  | flex 1 |  |  |
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
    | Processed | `Processed` | check column | 80 | renderer() |  |
    | Description | `Description` |  | flex 4 | renderer() |  |

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

- **grid** · renders into `dearCatalogGridContainer` · store `productToListStore` · placeholder `There are no products available to be published.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `Name` |  | flex 1 | renderer() |  |
    | Price | `Price` |  | 100 | renderer() |  |
    | Quantity | `Quantity` |  | 100 | renderer() |  |
    | Status | `Status` |  | 150 | renderer() |  |

- **grid** · renders into `dearSelectedCatalogGridContainer` · store `selectedProductsToListStore` · placeholder `There are no selected products.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `Name` |  | flex 3 | renderer() |  |
    | SKU | `SKU` |  | flex 1 | renderer() |  |
    | Price | `Price` |  | 80 | renderer() |  |
    | Publishing profile | `LProfile` |  | flex 2 | renderer() |  |

- **grid** · renders into `EtsyListingProfilesContainer` · store `vListingProfileStore` · placeholder `There are no profiles created yet..`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Profile name | `Name` |  | flex 3 | renderer() |  |
    | Shipping template | `ShippingProfileName` |  | flex 3 | renderer() |  |

- **grid** · renders into `failedPublishGridContainer` · store `productToListFailedStore` · placeholder `There are no error messages..`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `Name` |  | flex 5 | renderer() |  |
    | Publishing profile | `ProfileName` |  | flex 3 |  |  |
    | Message | `Result` |  | flex 6 | renderer() |  |

- **grid** · renders into `catalogGridContainer` · store `productStore` · placeholder `There are no products in the catalog.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | SKU | `SKU` |  | flex 2 | renderer() |  |
    | Name | `Name` |  | flex 4 | renderer() |  |
    | Category | `Category` |  | flex 2 | renderer() |  |
    | Price | `Price` |  | flex 1 | renderer() |  |
    | Status | `Status` |  | 75 | renderer() |  |
    | Quantity | `Quantity` |  | 90 | renderer() |  |
    | Linked product | `ProductID` |  | flex 4 | renderer() |  |

- **grid** · renders into `Etsy_Catalog_FamilyMappingGrid` · store `variationStore` · placeholder `There are no variations.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    |  | `Status` |  | 110 | renderer() |  |
    | Etsy product | `SKU` |  | flex 4 | renderer() |  |
    | Price | `Price` |  | flex 1 | renderer() |  |
    | Option 1 | `Option1` |  | flex 1 | renderer() |  |
    | Option 2 | `Option2` |  | flex 1 | renderer() |  |
    | Option 3 | `Option3` |  | flex 1 | renderer() |  |
    | Linked product | `ProductID` |  | flex 4 | renderer() |  |


#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| text field |  | `Etsy_Index_ShopName` | `` |  |
| combo |  | `Etsy_Index_Language` | `vEtsyLanguageStore` | shows `description` · value `Code` · pick-only |
| combo |  | `Etsy_Editor_RevenueAccount` | `RevenueAccountStore` | shows `DisplayName` · value `Code` · placeholder `Choose...` |
| text field |  | `Etsy_Editor_CustomSalesRepresentative` | `` | placeholder `write...` |
| combo |  | `Etsy_Index_Topic` | `TopicStore` | shows `description` · value `type` · pick-only |
| combo |  | `Etsy_Index_ConsolidationType` | `ConsolidationTypeStore` | shows `description` · value `type` · pick-only |
| combo |  | `Etsy_Index_ConsolidationTime` | `vTimeStore` | shows `Name` · value `Value` · pick-only |
| combo |  | `Etsy_Index_Customer` | `vCustomerStore` | shows `Name` · value `CustomerID` · placeholder `Choose...` |
| combo |  | `Etsy_Editor_PrimaryPriceTier` | `vSalesPriceTiersStore` | shows `Name` · value `Code` · placeholder `Choose...` · pick-only |
| combo |  | `Etsy_Editor_AutoFulfilmentMode` | `AutoFulfilmentModeStore` | shows `name` · value `value` · placeholder `Choose...` · pick-only |
| combo |  | `Etsy_Editor_InvoiceStatus` | `InvoiceStatusStore` | shows `name` · value `value` · placeholder `Choose...` · pick-only |
| combo |  | `Etsy_Index_CreateAssembly` | `CreateAssemblyStore` | shows `name` · value `value` · placeholder `Choose...` · pick-only |
| combo |  | `Etsy_Editor_Location` | `LocationStore` | shows `Description` · value `LocationID` · placeholder `Choose warehouse...` · pick-only |
| date field |  | `Etsy_FromOrders` | `` | placeholder `Choose...` · format `UserDateFormat` |
| text field |  | `` | `` | placeholder `Type a price...` |
| combo |  | `` | `vListingProfileStore` | shows `Name` · value `id` · placeholder `Select a profile...` |
| combo |  | `Etsy_PListingDialog_Category` | `EstyCategoryStore` | shows `name` · value `id` · placeholder `Select category...` · pick-only |
| combo |  | `Etsy_LProfile_ShipTemplate` | `ShippingTemplateStore` | shows `Title` · value `Id` · placeholder `Select a template...` · pick-only |
| combo |  | `Etsy_LProfile_ReadinessState` | `ReadinessStateStore` | shows `DisplayTitle` · value `Id` · placeholder `Select readiness state...` · pick-only |
| combo |  | `Etsy_LProfile_Who` | `EstyWhoStore` | shows `name` · value `id` · placeholder `Made by...` · pick-only |
| combo |  | `Etsy_LProfile_When` | `EstyWhenStore` | shows `name` · value `id` · placeholder `Select when it was made...` · pick-only |
| combo |  | `Etsy_CatalogManagment_LinkToProduct` | `ProductChooseStore` | shows `Name` · value `ProductCode` |
| combo |  | `Etsy_CatalogManagment_LinkToFamily` | `FamilyChooseStore` | shows `Name` · value `FamilyID` · placeholder `Do not link Etsy product` |
| combo |  | `tdBulkListingBrand` | `vTenantBrandStore` | shows `Brand` · value `ID` · placeholder `List all brands` |
| combo |  | `tdBulkListingListedIn` | `ECommerceShopStore` | shows `ShopName` · value `ConfigID` · placeholder `Choose...` |
| date field |  | `divExportLogFrom` | `` | format `UserDateFormat` |
| date field |  | `divExportLogTo` | `` | format `UserDateFormat` |
| combo |  | `divExportLogPeriod` | `periodStore` | shows `name` · value `value` · pick-only |

#### Menus, buttons and other parts

- **button** “All” · on click `Etsy_Index_Publish_SelectedBulkMenu_SetLProfileAll`
- **button** “Only selected” · on click `Etsy_Index_Publish_SelectedBulkMenu_SetLProfileSelected`
- **button** “Only empty” · on click `Etsy_Index_Publish_SelectedBulkMenu_SetLProfileOnlyForEmpty`
- **button** “Clear all” · on click `Etsy_Index_Publish_SelectedBulkMenu_SetLProfileEmptyAll`
- **button** “All” · on click `Etsy_Index_Publish_SelectedBulkMenu_SetPriceAll`
- **button** “Only selected” · on click `Etsy_Index_Publish_SelectedBulkMenu_SetPriceSelected`
- **item** “Price”
- **item** “Profile”

