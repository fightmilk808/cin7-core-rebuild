# eBay: UI

Every component the page code builds, read from the shipped ExtJS bundles: grids with their columns, fields, buttons, menus, windows and custom components. Labels are the English UI text. `renders into` is the id of the `<div>` in the page's server-rendered HTML that the component mounts in; `store` names the data store (see the endpoints in [README.md](README.md)); `on click` is the handler. Visual system and shell layout: [docs/UI.md](../../../docs/UI.md).

## Screens

| Route | Title | Bundles |
|---|---|---|
| `/eBayNG` | eBay | [`eBay2019`](#ebay2019) |

## Layout

Each screen's server-rendered HTML inside the shell, as an outline: headings, tabs, sections, labels, inputs (`#id`), buttons (`▾` = dropdown), menus, tables and `slot`s (empty `<div>`s the components below mount into). `(hidden)` parts are shown by the page code when needed. Read with GET from a signed-in session; no values are kept.

### `/eBayNG`: eBay

Frame: `task-upload-frame`.

```text
link "Home"
link "Integrations"
tabs#shop-main-tab: Overview #tab_overview |  #tab-add-new | Help #tab-shop-help
block #divAllBlocks
  tab pane#tab_overview
    tabs#overview-list: 
    block #overview-content (hidden)
      text "eBay"
      text "Read the full information sheet about eBay and Cin7 Core integration."
      button "Read information sheet" primary
      button "Help" primary
      tab pane#tab_overview
        heading #overview-shop-name
        block #overview-base-shop-settings (hidden)
          text "Base settings"
          slot #overview-shop-settings (hidden)
          slot #overview-shop-link
        block #overview-shop-logo (hidden)
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
  tab pane#tab-shop-settings
    tabs: Setup #tab-shop-setup | Action required #tab-shop-auth (hidden) | Catalog #tab-shop-catalog | Publishing #tab-shop-publish | Pending orders #tab-shop-pendingOrders | Log #tab-shop-log | Operations log #tab-shop-operationsLog
    text "eBay"
    text "Read the full information sheet about eBay and Cin7 Core integration."
    button "Read information sheet" primary
    button "Help" primary
    tab pane#tab-shop-setup
      heading "Setup"
      button "Save"#btnSaveSetupChanges primary
      block #capability-section (hidden)
        text "Cin7 Core detected that you can improve your eBay store management by using new integration features. To turn this ON yo"
      slot #setupValidation (hidden)
      text "General settings"
      label "Consolidate sales"
      slot #EbayNG_Index_ConsolidationType
      block #liEbayNG_Index_ConsolidationTime (hidden)
        label "Consolidation time"
        slot #EbayNG_Index_ConsolidationTime
      label "Customer"
      slot #EbayNG_Index_Customer
      label "Price tier"
      slot #EbayNG_Editor_PrimaryPriceTier
      label "Location"
      slot #EbayNG_Editor_Location
      label "Pick, pack, and ship processing mode"
      slot #EbayNG_Editor_AutoFulfilmentMode
      label "Process auto-assembly"
      slot #EbayNG_Index_CreateAssembly
      block #chkIgnoreRestockForNotFulfilledContainer
        label "Ignore restock for non fulfilled sales"
        input checkbox#divIgnoreRestockForNotFulfilled
      label "Product launch year"
      slot #EbayNG_Index_ProductLaunchYear
      text "Account and cash settings"
      label "Invoice status"
      slot #EbayNG_Editor_InvoiceStatus
      label "Optional revenue account"
      slot #EBayNG_Editor_RevenueAccount
      label "Sales representative name"
      slot #EBayNG_Editor_CustomSalesRepresentative
      label "Match product"
      block #EbayNG_Index_Mathcing_radioGroup
        input radio#EbayNG_Index_Mathcing_1 name=EbayNG_Index_Mathcing
        label "Manually" for #EbayNG_Index_Mathcing_1
        input radio#EbayNG_Index_Mathcing_2 name=EbayNG_Index_Mathcing
        label "by SKU" for #EbayNG_Index_Mathcing_2
      block #EbayNG_Index_AllowCreateDearProducts
        label "Create a new product if not found by SKU"
        input checkbox#EbayNG_Index_AllowCreate
      label "Use eBay as master source for Cin7 Core products"
      input checkbox#EbayNG_Index_UseAsMaster
      label "Update stock levels in eBay"
      input checkbox#EbayNG_Index_SyncStockLevel
      label "Export shipping information to eBay"
      input checkbox#EbayNG_Index_ExportShipInfo
      label "Ignore eBay taxes"
      input checkbox#EbayNG_Index_IgnoreTaxes
      text "Link eBay and Cin7 Core tax rules"
      button "Load from eBay"#divLoadTaxMapping
      slot #divTaxMapping
      text "Link eBay payment methods to payment accounts"
      button "Load from eBay"#divLoadPaymentProcessorMapping
      text "You can select accounts to use for payments received via listed payment methods if account has type "BANK" or has indica"
      slot #divPaymentProcessorMapping
      text "Disconnect from your eBay store"
      form#frmDisconnect
      button "Disconnect from eBay store"
    tab pane#tab-shop-auth
      heading "Connection with your eBay store requires authorization"
      text "To allow Cin7 Core to access your eBay store again please"
      form#frmRefreshToken
        button "Reconnect to eBay" primary
    tab pane#tab-shop-catalog
      heading "Catalog"
      input text#divSearchCatalog placeholder "Type text to search"
      button "Search" primary
      button "Refresh"#divRefreshCatalog
      button "Load products"#divDownloadProducts
      button "Update quantities in eBay"#divUploadQuantities
      label "Show variations separately"
      input checkbox#EbayNG_Catalog_ViewMode
      label "Show only active listings"
      input checkbox#EbayNG_Catalog_ListFilter
      slot #catalogGridContainer
    tab pane#tab-shop-publish
      heading "Publishing"
      tabs: Not listed #tab_1_1 | Selected to be listed #tab_1_2 | Failed #tab_1_3 | Publishing profiles #tab_1_4
      tab pane#tab_1_1
        input text#EbayNG_Publish_Search placeholder "Type text to search"
        button "Search" primary
        button "Refresh"
        button "Select all"#btnPublishNotListedSelectAll
        button #Grid_Publish_NotListedGrid_Options
        slot #dearCatalogGridContainer
      tab pane#tab_1_2
        button "Remove from the list"#btn_EbayNG_Index_Publish_SelectedClear
        button "Bulk apply to..."#EbayNG_Index_Publish_SelectedBulkMenuBtn ▾
        button "Publish"#btn_EbayNG_Index_Publish_SelectedPublish primary
        button "Refresh"
        button #Grid_Publish_SelectedGrid_Options
        slot #dearSelectedCatalogGridContainer
      tab pane#tab_1_3
        input text#EbayNG_Publish_SearchFailed placeholder "Type text to search"
        button "Search" primary
        button "Refresh"
        button #Grid_Publish_FailedGrid_Options
        slot #failedPublishGridContainer
      tab pane#tab_1_4
        button #btn_EbayNG_Publishing_LProfile_Open primary
        button "Refresh"
        button #Publish_ListingProfilesGrid_Options
        slot #ebayListingProfilesContainer
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
    heading "eBay setup"
    button "Connect to eBay"#btnConnectToShop primary
    text "Before integrating, ensure that your inventory is ready for import. After the initial import, changes to product details"
    block #addNewNote
      heading 
    form#frmAuthorise
      label "Choose eBay site"
      select#siteId
      label "Item will be handled by"
      input checkbox#useSku2
      label "This shop is"
      input checkbox#isSandbox2
  tab pane#tab-shop-help
    heading "Help"
    link "Sell on eBay!"
    button "Read information sheet" primary
modal#EbayNG_Index_CatalogFamily medium
  heading "Link eBay product to Cin7 Core family products"
  button "×"
  label ""
  slot #EbayNG_Product_FamilyImagePlaceholder
  table
  label "Select Cin7 Core family product to link with..."
  slot #EbayNG_CatalogManagment_LinkToFamily_FakeForREsize
  slot #EbayNG_CatalogManagment_LinkToFamily
  slot #linkedFamilyPreview
  slot #EbayNG_Catalog_FamilyMappingGrid
  button "Save"#EbayNG_Catalog_FamilyUpdate primary
  button "Close"
modal#EbayNG_PListingDialog_Content medium
  heading "Publishing profile for eBay"
  button "×"
  label "Profile name"
  input text#Ebay_LProfile_Name placeholder "Type a profile name here..."
  block #Ebay_LProfile_Step1 (hidden)
    label "Category"
    button "Click here to choose..."#EbayNG_PListingDialog_Category primary
  block #Ebay_LProfile_Step2 (hidden)
    heading "Listings specifics"
    text "Cin7 Core will use Product Name (first 80 characters) as Title for eBay listing If you would like to use "Subtitle" opti"
    slot #Ebay_LProfile_ListingsSpecifics_Grid
    block #Ebay_LProfile_ItemSpecifics_Group
      heading "Item specifics"
      slot #Ebay_LProfile_ItemSpecifics_Grid
      button "Add more items"#EbayNG_Publishing_LProfile_AddNewItemSpecificLink primary
      slot #Ebay_LProfile_ItemSpecifics_Toolbar (hidden)
  block #Ebay_LProfile_Step3 (hidden)
    heading "Payment options"
    label "Profile currency"
    slot #Ebay_LProfile_Currency
    slot #Ebay_LProfile_FakeControlWidth
    block #Ebay_LProfile_PayPalEmail_Group
      label "Your PayPal account email address"
      input text#Ebay_LProfile_PayPalEmail placeholder "PayPal email address..."
    block #Ebay_LProfile_AutoPay_Group (hidden)
      label "Require immediate payment with 'Buy It Now'"
      input checkbox#Ebay_LProfile_AutoPay
    block #Ebay_LProfile_BestOffer_Group (hidden)
      label "Best offer"
      input checkbox#Ebay_LProfile_BestOffer
    slot #Ebay_LProfile_Payment_Options
    label "Additional checkout instructions"
    textarea#Ebay_LProfile_Payment_Instruction
    block #Ebay_LProfile_ReturnPolicy_Group
      label "Return policy"
      slot #Ebay_LProfile_ReturnPolicy_Returns
      block #Ebay_LProfile_ReturnPolicy_Options (hidden)
        block #Ebay_LProfile_ReturnPolicy_RefundsGroup
          label "Refund will be given as"
          slot #Ebay_LProfile_ReturnPolicy_Refunds
        block #Ebay_LProfile_ReturnPolicy_ReturnsWithinGroup
          label "After receiving the item, your buyer should contact you within"
          slot #Ebay_LProfile_ReturnPolicy_ReturnsWithin
        block #Ebay_LProfile_ReturnPolicy_RestockingFeeGroup
          label "Do you charge a restocking fee?"
          slot #Ebay_LProfile_ReturnPolicy_RestockingFee
        label "Return postage will be paid by"
        slot #Ebay_LProfile_ReturnPolicy_ShippingCost
        block #Ebay_LProfile_ReturnPolicy_EAN_Group (hidden)
          label "EAN"
          input text#Ebay_LProfile_ReturnPolicy_EAN placeholder "EAN"
        block #Ebay_LProfile_ReturnPolicy_Description_Group (hidden)
          label "Additional return policy details"
          textarea#Ebay_LProfile_ReturnPolicy_Descriprion placeholder "Write your description here..."
    block #Ebay_LProfile_Compliance_Group
      heading "CPSC compliance document (US only)"
      text "Required for children's products and apparel sold on eBay US from July 8, 2026. Obtain the Document ID from eBay Seller "
      label "Document ID"
      input text#Ebay_LProfile_ComplianceDocumentId placeholder "Enter the Document ID from eBay Seller Hub..."
  block #Ebay_LProfile_Step4 (hidden)
    heading "Shipping details"
    block #Ebay_LProfile_DomesticPostage_Group
      block #Ebay_LProfile_Postage_GlobalShipping_Group (hidden)
        label "Use eBay Global Shipping Program"
        input checkbox#Ebay_LProfile_Postage_GlobalShipping
      heading "Domestic postage"
      label "Shipping type"
      slot #Ebay_LProfile_DomesticPostage_ShipType
      block #Ebay_LProfile_DomesticPostage_ShipService_Group
        label "Shipping service and cost"
        slot #Ebay_LProfile_DomesticPostage_ShipService
        slot #Ebay_LProfile_DomesticPostage_ShipService_Fake
        block #Ebay_LProfile_DomesticPostage_ShipService_Cost_Group
          slot #Ebay_LProfile_DomesticPostage_ShipService_Cost
          slot #Ebay_LProfile_DomesticPostage_ShipService_Cost_Fake
      block #Ebay_LProfile_DomesticPostage_FreePostage_Group (hidden)
        label "Offer free postage (no additional shipping or handling cost)"
        input checkbox#Ebay_LProfile_DomesticPostage_FreePostage
      block #Ebay_LProfile_DomesticPostage_HandlingTime_Group (hidden)
        label "Handling time and cost"
        slot #Ebay_LProfile_DomesticPostage_HandlingTime
        block #Ebay_LProfile_DomesticPostage_HandlingCost_SubGroup (hidden)
          slot #Ebay_LProfile_DomesticPostage_HandlingCost
          slot #Ebay_LProfile_DomesticPostage_HandlingCost_Fake
      block #Ebay_LProfile_InternationalPostageAlternative_Group
        text "International postage This functionality isn't available for the selected type of domestic postage."
      block #Ebay_LProfile_InternationalPostage_Group (hidden)
        heading "International postage"
        label "Shipping type"
        slot #Ebay_LProfile_InternationalPostage_ShipType
        block #Ebay_LProfile_InternationalPostage_ShipService_Group (hidden)
          label "Shipping service and cost"
          slot #Ebay_LProfile_InternationalPostage_ShipService
          slot #Ebay_LProfile_InternationalPostage_ShipService_Fake
          block #Ebay_LProfile_InternationalPostage_ShipService_Cost_Group
            slot #Ebay_LProfile_InternationalPostage_ShipService_Cost
            slot #Ebay_LProfile_InternationalPostage_ShipService_Cost_Fake
        block #Ebay_LProfile_InternationalPostage_HandlingCost_Group (hidden)
          label "Handling cost"
          slot #Ebay_LProfile_InternationalPostage_HandlingCost
          slot #Ebay_LProfile_InternationalPostage_HandlingCost_Fake
      block #Ebay_LProfile_Package_Group (hidden)
        heading "Package weight and dimensions"
        label "Measurement units"
        slot #Ebay_LProfile_Package_UOM
        label "Dimensions"
        slot #Ebay_LProfile_Package_DimensionsX
        slot #Ebay_LProfile_Package_DimensionsY
        slot #Ebay_LProfile_Package_DimensionsZ
        slot #Ebay_LProfile_Package_Dimensions_Fake
        label "Weight"
        block #Ebay_LProfile_Package_Weight_UseProductInfo_Group
          label "Use Product Weight" for #Ebay_LProfile_Package_Weight_UseProductInfo
          input checkbox#Ebay_LProfile_Package_Weight_UseProductInfo
        block #Ebay_LProfile_Package_Weight_Group
          slot #Ebay_LProfile_Package_WeightMajor
          slot #Ebay_LProfile_Package_WeightMinor
        slot #Ebay_LProfile_Package_Weight_Fake
        block #Ebay_LProfile_Package_Type_Group (hidden)
          label "Package type"
          slot #Ebay_LProfile_Package_Type
      block #Ebay_LProfile_LocationBlock
        heading "Item location"
        label "Country"
        slot #Ebay_LProfile_Country
        label "Postal code"
        input text#Ebay_LProfile_PostalCode placeholder "Postal code"
        label "Suburb/town, state/territory"
        input text#Ebay_LProfile_Location placeholder "Location"
  button "Next"#EbayNG_PublishProfile_Next primary
  button "Save"#EbayNG_PublishProfile_Save primary
  button "Close"
modal#EbayNG_Migration_Content
  button 
  heading "Migrate to the new version eBay"
  slot #EbayNG_Migration_ValidationContainer
  button "Start"#EbayNG_Migration_Action
  button "Close"
modal#EbayNG_Index_Catalog medium
  heading "Link eBay product to Cin7 Core product"
  button "×"
  label ""
  slot #EbayNG_Product_ImagePlaceholder
  table
  slot #tabUnlinked
  slot #tabLinked
  slot #tabBuild
  block #EbayNG_Index_Mathcing_radioGroup
    input radio#rbtnUnlinked name=radioActionToDo
    label "Do not link eBay product to any Cin7 Core product" for #rbtnUnlinked
    input radio#rbtnLink name=radioActionToDo
    label "Link eBay product to the existing Cin7 Core product" for #rbtnLink
    input radio#rbtnCreate name=radioActionToDo
    label "Create a new Cin7 Core product using eBay product details" for #rbtnCreate
  tab pane#tabCatalogInfo
    text "eBay product is not linked. You may choose what to do with an unlinked eBay product. You can link it to the existing Cin"
  tab pane#tabCatalogLink
    label "Select Cin7 Core product to link with..."
    slot #EbayNG_CatalogManagment_LinkToProduct_FakeForREsize
    slot #EbayNG_CatalogManagment_LinkToProduct
    slot #linkedProductPreview
    block #Catalog_SyncStockLevelBlock
      label "Sync stock level"
      input checkbox#EbayNG_Catalog_SyncStockLevel
    block #Catalog_IgnoreProductUpdationBlock
      label "Do not update the linked Cin7 Core product"
      input checkbox#EbayNG_Catalog_IgnoreProductUpdation
  tab pane#tabCatalogBuild
    label "Create a new Cin7 Core product from eBay listing and link..."
    button "Build and link"#btnBuildProduct primary
    slot #foundProductPreview
  block #EbayNG_Catalog_AllActions
    button "Save"#EbayNG_Catalog_Update primary
    button "Close"
modal#EbayNG_DownloadProducts_Content small
  heading "Load products from eBay"
  button "×"
  slot #EbayNG_DownloadProducts_ValidationContainer (hidden)
  text "All products from eBay will be loaded into Cin7 Core. This operation may take a long time. Please leave this dialog open"
  label "Enable image download" for #EbayNG_Download_Image
  input checkbox#EbayNG_Download_Image
  text "Enabling this option would increase the time taken to download products."
  block #EbayNG_DownloadProducts_Actions
    button "Load from eBay" primary
    button "Close"
modal#EbayNG_UpdateQuantity_Content small
  heading "Update quantities in eBay"
  button "×"
  slot #EbayNG_UpdateQuantity_ValidationContainer (hidden)
  text "All products listed in Cin7 Core eBay catalog will be updated in eBay with current available quantities from Cin7 Core. "
  block #EbayNG_UpdateQuantity_Actions
    button "Start" primary
    button "Close"
modal#EbayNG_CategorySelect_Content medium
  heading "Select eBay category"#EbayNG_CategorySelect_Content_Width
  button "×"
  input radio#categoryOptionsSuggested name=categoryOptionsRadios
  label "Suggested category search" for #categoryOptionsSuggested
  input radio#categoryOptionsDrilldown name=categoryOptionsRadios
  label "Category drilldown" for #categoryOptionsDrilldown
  block #buttonForDrillDown
    button "Back"
  block #EbayNG_CategorySelect_Suggested
    label "Search category"
    input text#EbayNG_CategorySelect_Suggested_Search placeholder "Type text to search"
    button "Search" primary
    slot #EbayNG_CategorySelect_Suggested_Results
  block #EbayNG_CategorySelect_Drilldown (hidden)
    slot #EbayNG_CategorySelect_Drilldown_Row
  button "Select"#EbayNG_CategorySelect_BtnSelect primary (hidden)
  button "Close"
modal#EbayNG_DownloadOrders_Content small
  heading "Load orders from eBay"
  button "×"
  slot #EbayNG_DownloadOrders_ValidationContainer (hidden)
  text "All orders from eBay will be loaded into Cin7 Core as pending orders. This operation may take a long time. Please leave "
  label "Orders created since"
  slot #EbayNG_FromOrders
  block #EbayNG_DownloadOrders_Actions
    button "Load from eBay" primary
    button "Close"
form#frmProcess
```

## Components by bundle

What the page code builds and mounts into the layout's slots.

### `eBay2019`

15 grids · 45 standalone fields · 0 windows · 8 menus, buttons and other parts · 0 custom components

#### Grids

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

- **grid** · renders into `dearCatalogGridContainer` · store `productToListStore` · placeholder `There are no products available to be published.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `Name` |  | flex 4 | renderer() |  |
    | Status | `Status` |  | 120 | renderer() |  |
    | Quantity | `Quantity` |  | 100 | renderer() |  |
    | Price | `Price` |  | 100 | renderer() |  |

- **grid** · renders into `dearSelectedCatalogGridContainer` · store `selectedProductsToListStore` · placeholder `There are no selected products.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    |  | `Selected` | check column | 48 | renderer() |  |
    | Product | `Name` |  | flex 3 | renderer() |  |
    | SKU | `SKU` |  | flex 1 | renderer() |  |
    | Price | `Price` |  | 80 | renderer() |  |
    | Publishing profile | `LProfile` |  | flex 2 | renderer() |  |

- **grid** · renders into `ebayListingProfilesContainer` · store `vListingProfileStore` · placeholder `There are no profiles created yet..`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | eBay category | `CategoryName` |  | flex 3 | renderer() |  |
    | Profile name | `Name` |  | flex 1 |  |  |

- **grid** · renders into `failedPublishGridContainer` · store `productToListFailedStore` · placeholder `There are no error messages..`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product/ variation | `Name` |  | flex 5 | renderer() |  |
    | Publishing profile | `ProfileName` |  | flex 2 |  |  |
    | Message | `Result` |  | flex 6 | renderer() |  |

- **grid** · renders into `Ebay_LProfile_ListingsSpecifics_Grid` · store `ListingsSpecificsStore`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    |  | `Name` |  | flex 1 | renderer() |  |
    | Constant value | `Value` |  | flex 1 | renderer() |  |
    | ...or value of a product attribute | `MappedField` |  | flex 1 | renderer() |  |

- **grid** · renders into `Ebay_LProfile_ItemSpecifics_Grid` · store `ItemSpecificsStore`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    |  | `Name` |  | flex 1 | renderer() |  |
    | Constant value | `Value` |  | flex 1 |  |  |
    | ...or value of a product attribute | `MappedField` |  | flex 1 | renderer() |  |

- **grid** · renders into `catalogGridContainer` · store `productStore` · placeholder `There are no products in the catalog.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | SKU | `SKU` |  | flex 1 | renderer() |  |
    | Name | `Name` |  | flex 1 | renderer() |  |
    | Category | `Category` |  | flex 1 | renderer() |  |
    | Status | `Status` |  | 120 | renderer() |  |
    | Linked product | `ProductID` |  | flex 2 | renderer() |  |
    | Quantity | `Quantity` |  | 100 | renderer() |  |
    | Price | `Price` |  | flex 1 | renderer() |  |

- **grid** · renders into `EbayNG_Catalog_FamilyMappingGrid` · store `variationStore` · placeholder `There are no variations.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    |  | `Status` | action column | 65 | renderer() |  |
    | eBay product | `SKU` |  | flex 4 | renderer() |  |
    | Price | `Price` |  | flex 1 | renderer() |  |
    | Option 1 | `Option1` |  | flex 1 | renderer() |  |
    | Option 2 | `Option2` |  | flex 1 | renderer() |  |
    | Option 3 | `Option3` |  | flex 1 | renderer() |  |
    | Linked product | `ProductID` |  | flex 4 | renderer() |  |

- **grid** · renders into `divTaxMapping` · store `vEcsTaxMappingStore` · placeholder `Loading eBay taxes rates...`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Type | `Description` |  | flex 1 |  |  |
    | Tax rule | `TaxRuleName` |  | flex 1 | renderer() |  |

- **grid** · renders into `divPaymentProcessorMapping` · store `vEcsPaymentProcessorMappingStore` · placeholder `Loading eBay payment methods...`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Name | `PaymentProcessorName` |  | flex 1 |  |  |
    | Payment account code | `LedgerAccount` |  | flex 1 | renderer() |  |

- **grid** · renders into `divPendingOrdersGrid` · store `pendingOrdersStore` · placeholder `You do not have any pending eBay orders at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Order # | `OrderNumber` |  | 100 | renderer() |  |
    | Date | `DateCreated` | date column | 120 | renderer() |  |
    | Customer | `CustomerName` |  | flex 1 | renderer() |  |
    | Product | `Name` |  | flex 2 | renderer() |  |
    | Quantity | `Quantity` |  | 100 |  |  |
    | Total | `Total` |  | flex 1 | renderer() |  |

- **grid** · renders into `logGridContainer` · store `logStore` · placeholder `You do not have any captured eBay orders at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Invoice # | `OrderNumber` |  | flex 1 | RenderHTMLText |  |
    | Date | `Date` | date column | flex 1 | renderer() |  |
    | Download date | `DownloadDate` | date column | flex 1 | renderer() |  |
    | Process date | `ProcessDate` | date column | flex 1 | renderer() |  |
    | Status | `Status` |  | flex 1 | renderer() |  |
    | Type | `Type` |  | flex 1 | renderer() |  |
    | Sale task | `SaleOrderNumber` |  | flex 1 | renderer() |  |

- **grid** · renders into `operationsLogGridContainer` · store `operationsLogStore` · placeholder `No entries found. Please hit refresh or change the search criteria.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Date | `Date` | date column | flex 1 | renderer() |  |
    | Type | `Type` |  | 100 | renderer() |  |
    | User | `UserName` |  | flex 1 | renderer() |  |
    | Category | `Category` |  | flex 1 | renderer() |  |
    | Processed | `Processed` | check column | 100 | renderer() |  |
    | Description | `Description` |  | flex 2 | renderer() |  |


#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| text field |  | `` | `` | placeholder `Type a price...` |
| combo |  | `` | `vListingProfileStore` | shows `Name` · value `id` · placeholder `Select a profile...` |
| combo |  | `Ebay_LProfile_Currency` | `EbayCurrencyStore` | shows `Description` · value `Name` · placeholder `Select currency` · pick-only |
| combo |  | `Ebay_LProfile_Country` | `EbayCountryStore` | shows `Description` · value `Name` · pick-only |
| combo |  | `Ebay_LProfile_ReturnPolicy_Returns` | `ReturnPolicy_ReturnsStore` | shows `Description` · value `Name` · pick-only |
| combo |  | `Ebay_LProfile_ReturnPolicy_Refunds` | `ReturnPolicy_RefundStore` | shows `Description` · value `Name` · pick-only |
| combo |  | `Ebay_LProfile_ReturnPolicy_ReturnsWithin` | `ReturnPolicy_ReturnsWithinStore` | shows `Description` · value `Name` · pick-only |
| combo |  | `Ebay_LProfile_ReturnPolicy_RestockingFee` | `ReturnPolicy_RestockingFeeStore` | shows `Description` · value `Name` · pick-only |
| combo |  | `Ebay_LProfile_ReturnPolicy_ShippingCost` | `ReturnPolicy_ShippingCostStore` | shows `Description` · value `Name` · pick-only |
| combo |  | `Ebay_LProfile_DomesticPostage_HandlingTime` | `HandlingTimeStore` | shows `Description` · value `Name` · pick-only |
| combo |  | `Ebay_LProfile_DomesticPostage_ShipType` | `DomesticShipTypeStore` | shows `Description` · value `ID` · pick-only |
| combo |  | `Ebay_LProfile_InternationalPostage_ShipType` | `InternationalShipTypeStore` | shows `Description` · value `ID` · pick-only |
| number field |  | `Ebay_LProfile_DomesticPostage_HandlingCost` | `` | placeholder `0.00` · required |
| number field |  | `Ebay_LProfile_InternationalPostage_HandlingCost` | `` | required |
| number field |  | `Ebay_LProfile_DomesticPostage_ShipService_Cost` | `` | placeholder `0.00` · required |
| number field |  | `Ebay_LProfile_InternationalPostage_ShipService_Co…` | `` | placeholder `0.00` · required |
| number field |  | `Ebay_LProfile_Package_DimensionsX` | `` | placeholder `Depth` |
| number field |  | `Ebay_LProfile_Package_DimensionsY` | `` | placeholder `Length` · required |
| number field |  | `Ebay_LProfile_Package_DimensionsZ` | `` | placeholder `Width` · required |
| number field |  | `Ebay_LProfile_Package_WeightMajor` | `` | placeholder `` |
| number field |  | `Ebay_LProfile_Package_WeightMinor` | `` | placeholder `` |
| combo |  | `Ebay_LProfile_Package_UOM` | `MeasurementUOMStore` | shows `Description` · value `Name` · pick-only |
| combo |  | `Ebay_LProfile_DomesticPostage_ShipService` | `DomesticShipServiceStore` | shows `DisplayName` · value `ShippingServiceID` · pick-only |
| combo |  | `Ebay_LProfile_InternationalPostage_ShipService` | `InternationalShipServiceStore` | shows `Description` · value `ShippingServiceID` · pick-only |
| combo |  | `Ebay_LProfile_Package_Type` | `PackageTypeStore` | shows `Description` · value `PackageID` · pick-only |
| combo |  | `Ebay_LProfile_Subtitle` | `DEARMappingModelStore` | shows `Description` · value `FieldName` · pick-only |
| combo |  | `EbayNG_CatalogManagment_LinkToProduct` | `ProductChooseStore` | shows `Name` · value `ProductCode` |
| combo |  | `EbayNG_CatalogManagment_LinkToFamily` | `FamilyChooseStore` | shows `Name` · value `FamilyID` · placeholder `Do not link eBay product` |
| date field |  | `EbayNG_FromOrders` | `` | placeholder `Choose...` · format `UserDateFormat` |
| combo |  | `EBayNG_Editor_RevenueAccount` | `RevenueAccountStore` | shows `DisplayName` · value `Code` · placeholder `Choose...` |
| text field |  | `EBayNG_Editor_CustomSalesRepresentative` | `` | placeholder `write...` |
| combo |  | `EbayNG_Index_ConsolidationType` | `ConsolidationTypeStore` | shows `description` · value `type` · pick-only |
| combo |  | `EbayNG_Index_ConsolidationTime` | `vTimeStore` | shows `Name` · value `Value` · pick-only |
| combo |  | `EbayNG_Index_Customer` | `vCustomerStore` | shows `Name` · value `CustomerID` · placeholder `Choose...` |
| combo |  | `EbayNG_Index_ProductLaunchYear` | `ProductLaunchYearStore` | shows `name` · value `value` · placeholder `Select year` · pick-only |
| combo |  | `EbayNG_Editor_PrimaryPriceTier` | `vSalesPriceTiersStore` | shows `Name` · value `Code` · placeholder `Choose...` · pick-only |
| combo |  | `EbayNG_Editor_AutoFulfilmentMode` | `AutoFulfilmentModeStore` | shows `name` · value `value` · placeholder `Choose...` · pick-only |
| combo |  | `EbayNG_Editor_InvoiceStatus` | `InvoiceStatusStore` | shows `name` · value `value` · placeholder `Choose...` · pick-only |
| combo |  | `EbayNG_Index_CreateAssembly` | `CreateAssemblyStore` | shows `name` · value `value` · placeholder `Choose...` · pick-only |
| combo |  | `EbayNG_Editor_Location` | `LocationStore` | shows `Description` · value `LocationID` · placeholder `Choose warehouse...` · pick-only |
| combo |  | `tdBulkListingBrand` | `vTenantBrandStore` | shows `Brand` · value `ID` · placeholder `List all brands` |
| combo |  | `tdBulkListingListedIn` | `ECommerceShopStore` | shows `ShopName` · value `ConfigID` · placeholder `Choose...` |
| date field |  | `divExportLogFrom` | `` | format `UserDateFormat` |
| date field |  | `divExportLogTo` | `` | format `UserDateFormat` |
| combo |  | `divExportLogPeriod` | `periodStore` | shows `name` · value `value` · pick-only |

#### Menus, buttons and other parts

- **button** “All” · on click `EbayNG_Index_Publish_SelectedBulkMenu_SetLProfileAll`
- **button** “Only selected” · on click `EbayNG_Index_Publish_SelectedBulkMenu_SetLProfileSelected`
- **button** “Only empty” · on click `EbayNG_Index_Publish_SelectedBulkMenu_SetLProfileOnlyForEmpty`
- **button** “Clear all” · on click `EbayNG_Index_Publish_SelectedBulkMenu_SetLProfileEmptyAll`
- **button** “All” · on click `EbayNG_Index_Publish_SelectedBulkMenu_SetPriceAll`
- **button** “Only selected” · on click `EbayNG_Index_Publish_SelectedBulkMenu_SetPriceSelected`
- **item** “Price”
- **item** “Profile”

