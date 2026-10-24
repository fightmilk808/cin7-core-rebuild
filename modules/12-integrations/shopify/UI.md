# Shopify: UI

Every component the page code builds, read from the shipped ExtJS bundles: grids with their columns, fields, buttons, menus, windows and custom components. Labels are the English UI text. `renders into` is the id of the `<div>` in the page's server-rendered HTML that the component mounts in; `store` names the data store (see the endpoints in [README.md](README.md)); `on click` is the handler. Visual system and shell layout: [docs/UI.md](../../../docs/UI.md).

## Screens

| Route | Title | Bundles |
|---|---|---|
| `/Shopify` | Shopify | [`Shopify2019`](#shopify2019) |

## Layout

Each screen's server-rendered HTML inside the shell, as an outline: headings, tabs, sections, labels, inputs (`#id`), buttons (`▾` = dropdown), menus, tables and `slot`s (empty `<div>`s the components below mount into). `(hidden)` parts are shown by the page code when needed. Read with GET from a signed-in session; no values are kept.

### `/Shopify`: Shopify

Frame: `task-upload-frame`.

```text
link "Home"
link "Integrations"
tabs#portal-main-tab: Overview #tab_overview |  #tab-add-new | Help #tab-portal-help
tab pane#tab_overview
  tabs#overview-list: 
  block #overview-content (hidden)
    text "Shopify"
    text "Read the full information sheet about Shopify and Cin7 Core integration."
    button "Read information sheet" primary
    button "Help" primary
    tab pane#overview-content-tab
      heading #overview-portal-name
      block #overview-base-portal-settings (hidden)
        text "Base settings"
        slot #overview-portal-settings (hidden)
        slot #overview-portal-link
      text "Sales summary"
      slot #overview-sales-summary (hidden)
      heading "Sales over time"
      slot #tdShopify_Chart_GroupBy
      slot #tdShopify_Chart_Period
      slot #tdShopify_Chart_From
      slot #tdShopify_Chart_To
      slot #tdShopify_Chart_Type
      button "Update"
      block #shopify_chart_container
        slot #Shopify_Chart_Sales
        block #Shopify_Chart_Sales-no-data
tab pane#tab-portal-settings
  tabs: Setup #tab-portal-setup | Catalog #tab-portal-catalog | Bulk listing #tab-portal-bulkLoad | Pending orders #tab-portal-pendingOrders | Log #tab-portal-log | Operations log #tab-portal-operationsLog
  text "Shopify"
  text "Read the full information sheet about Shopify and Cin7 Core integration."
  button "Read information sheet" primary
  button "Help" primary
  tab pane#tab-portal-setup
    heading "Setup"
    label "Load orders from Shopify"
    input checkbox#Shopify_Index_LoadOrdersFromShopify
    button "Save"#btnSaveSetupChanges primary
    block #authError (hidden)
      text "Connection with your Shopify store requires reauthorization."
      form#frmReauthorise
        button "Reconnect to Shopify" primary
    block #divUpdateConnection (hidden)
      form#frmUpdateConnection
        button "Update Shopify connection" primary
    slot #setupValidation (hidden)
    text "General settings"
    label "Capture order when it is"
    slot #Shopify_Index_Topic
    block #divShopify_Index_TimeDelay
      label "Delay order downloads (in minutes)"
      input number#txtTimeDelayMinutes
      slot #lblTimeDelayConversion
    label "Consolidate orders"
    block #ConsolidateOrdersLegacy
      slot #Shopify_Index_ConsolidateOrdersLegacy
    block #ConsolidateOrdersNew (hidden)
      input checkbox#Shopify_Index_ConsolidateOrders
    block #liShopify_Index_ConsolidationFrequency (hidden)
      label "Consolidation frequency"
      slot #Shopify_Index_ConsolidationFrequency
    block #liShopify_Index_ConsolidationTime (hidden)
      label "Consolidation time"
      block #divConsolidationTimeControl
        slot #Shopify_Index_ConsolidationTime
    label "Customer"
    slot #Shopify_Index_Customer
    label "Use company as a customer"
    input checkbox#Shopify_Index_UseCompanyAsCustomer
    label "Sale price tier"
    slot #Shopify_Editor_PriceTier
    label "Process auto-assembly"
    slot #Shopify_Index_CreateAssembly
    label "Show comparison price"
    input checkbox#Shopify_Index_ShowComparisonPrice
    label "Pick, pack, and ship process mode for online sales"
    slot #Shopify_Editor_AutoShippingMode
    block #wrnAutoShippingMode
      text "WARNING: with this option chosen order fulfillment information will be downloaded to Cin7 Core from Shopify but Cin7 Cor"
    block #Shopify_Editor_GrpCompareAtPriceTier
      label "Compare price tier"
      slot #Shopify_Editor_CompareAtPriceTier
    block #chkIgnoreRestockForNotFulfilledContainer
      block #chkIgnoreRestockForNotFulfilledContainer
        label "Ignore restock for non fullfilled sales"
        input checkbox#divIgnoreRestockForNotFulfilled
    block #EnablePartialFulfillmentOverallContainer
      block #chkEnablePartialFulfillmentContainer
        label "Enable partial fulfillment"
        input checkbox#divEnablePartialFulfillment
      block #wrnEnablePartialFulfillment (hidden)
        text "WARNING! Please make sure that all Shopify locations are mapped 1-1 with Cin7 Core locations. This is mandatory to enabl"
    label "Send tracking URL:"
    input radio#Shopify_Index_AppendTrackingNumberToTrackingUrl
    label "With tracking number" for #Shopify_Index_AppendTrackingNumberToTrackingUrl
    input radio#Shopify_Index_DontAppendTrackingNumberToTrackingUrl name=Shopify_Index_AppendTrackingNumberToTrackingUrl
    label "Without tracking number" for #Shopify_Index_DontAppendTrackingNumberToTrackingUrl
    text "Account and cash settings"
    label "Invoice status"
    slot #Shopify_Editor_InvoiceStatus
    label "List products as draft"
    input checkbox#Shopify_Index_ListAsDraft
    label "Update stock levels in Shopify"
    input checkbox#Shopify_Index_SyncStockLevel
    label "Allow users to purchase out of stock items"
    input checkbox#Shopify_Index_SellOutOfStock
    block #chkUseBufferInventoryContainer
      label "Use buffer inventory"
      input checkbox#Shopify_Index_UseBufferInventory
    block #txtBufferInventoryContainer
      label "Buffer inventory"
      slot #Shopify_Index_BufferInventory
    label "Create a fulfillment in Shopify even if a tracking number is not available"
    input checkbox#Shopify_Index_UploadFulfilmentWithoutTrackingNumber
    label "Allow Cin7 Core to create Shopify products when Cin7 Core product names are not unique"
    input checkbox#Shopify_Index_AllowDuplicateNames
    label "Bring discount codes from Shopify"
    input checkbox#Shopify_Index_BringDiscountCodes
    block #chkSupportDuplicatedSKUContainer
      label "Import duplicate SKUs from Shopify"
      input checkbox#divSupportDuplicatedSKU
    label "MASTER data source"
    block #master-source
      slot #Shopify_Index_Master_Data_Source
    block #Shopify_Index_HonourShopifyLocationContainer
      label "Use Shopify order location"
      input checkbox#Shopify_Index_HonourShopifyLocation
    label "Add a company to the address"
    input checkbox#Shopify_Index_AddCompanyToAddresses
    label "Location for online sales"
    slot #Shopify_Index_Location
    label "Gift card liability account"
    slot #Shopify_Index_LiabilityAccount
    label "Optional revenue account"
    slot #Shopify_Index_RevenueAccount
    label "Sales representative name"
    slot #Shopify_Index_CustomSalesRepresentative
    label "Add a discount as"
    input radio#Shopify_Index_AddDiscountAsChangedPrice_1 name=Shopify_Index_AddDiscountAsChangedPrice
    label "Price reduction" for #Shopify_Index_AddDiscountAsChangedPrice_1
    input radio#Shopify_Index_AddDiscountAsChangedPrice_2 name=Shopify_Index_AddDiscountAsChangedPrice
    label "Additional charge" for #Shopify_Index_AddDiscountAsChangedPrice_2
    block #Shopify_Editor_GrpAutoSyncRetry
      label "Auto retry sale order sync"
      input checkbox#Shopify_Index_AutoSyncRetry
    block #divShopify_Index_AttributeForTags
      label "Import Shopify sale order tags to"
      slot #Shopify_Index_AttributeForTags
    block #divShopify_Index_AttributeForType
      label "Import Shopify order type to"
      slot #Shopify_Index_AttributeForType
    label "Order exclusion tags"
    slot #Shopify_Index_OrderExclusionTags
    label "Order lock date"
    slot #Shopify_Index_OrderLockDate
    block #divShopify_Index_RetailDeliveryAccount
      label "Retail delivery fee account"
      slot #Shopify_Index_RetailDeliveryFeeAccount
    label "Import additional product properties from Shopify"
    input checkbox#Shopify_Index_LoadAdditionalProductProperties
    block #Shopify_Index_ImportProductsAutomaticallyContainer
      label "Download products automatically"
      input checkbox#Shopify_Index_ImportProductsAutomatically
    label "Payment reference"
    slot #Shopify_Index_PaymentReference
    text "Link Shopify and Cin7 Core tax rules"
    button #divAddTaxMapping primary
    button "Load from Shopify"#divLoadTaxMapping
    slot #divTaxMapping
    text "Link Shopify locations to Cin7 Core locations"
    button "Load from Shopify"#divLoadLocationMapping
    slot #divLocationMapping
    text "Link Shopify payment methods to payment accounts"
    button "Load from Shopify"#divLoadPaymentMapping
    text "You can select accounts to use for payments received via listed payment methods if account has type "BANK" or has indica"
    slot #divPaymentMapping
    text "Disconnect from your Shopify store"
    text "You can disconnect from Shopify store if you no longer want to track sales on Shopify. This will delete all logs, pendin"
    form#frmDisconnect
    slot #CreationDate
    button "Disconnect from Shopify store"
  tab pane#tab-portal-catalog
    heading "Catalog"
    input text#divSearchCatalog placeholder "Type text to search"
    button "Search" primary
    button "Refresh"#divRefreshCatalog
    button "Download"#downloadAction ▾
    slot #cmbDownload
    button "Update quantities in Shopify"#divUploadQuantities
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
    label "Choose Shopify location(s) to list or update the product(s) to"
    slot #Shopify_BulkList_Location
    block #Shopify_Product_Status_BulkListing_Container
      label "List product(s) as:"
      block #Shopify_Product_Status_BulkListing
        input radio#Shopify_Index_ListAsActive_BulkListing name=Shopify_Index_ProductStatus
        label "Active" for #Shopify_Index_ListAsActive_BulkListing
        input radio#Shopify_Index_ListAsDraft_BulkListing name=Shopify_Index_ProductStatus
        label "Draft" for #Shopify_Index_ListAsDraft_BulkListing
    slot #tdBulkSellOutOfStock
    label "Allow backorder"
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
    button "List"#divListBulk primary
    button "Unlist"#divUnlistBulk
    button "Unlink"#divUnlinkBulk
    button #Grid_bulkGrid_Options
    slot #Shopify_BulkListing_ValidationContainer (hidden)
    slot #divBulkList
  tab pane#tab-portal-pendingOrders
    heading "Orders"
    input text#divSearchPendingOrders placeholder "Type text to search"
    button "Search" primary
    text "Date"#shopify-date-label
    slot #divFromDatePendingOrders
    slot #divToDatePendingOrders
    button #clearDateFilters
    button "Refresh"#divRefreshPendingOrders
    button "Load orders"#divDownloadOrders
    button "Process"#divProcessOrders
    button #Grid_PendingOrders_Options
    slot #divPendingOrdersGrid
  tab pane#tab-portal-log
    heading "Log"
    input text#divSearchLog placeholder "Type text to search"
    button "Search" primary
    label "Date"
    slot #logDateColumnFilter
    slot #logFromDate
    slot #logToDate
    button #clearLogDatesFilters
    label "Type"
    slot #logTypeFilter
    label "Status"
    slot #logStatusFilter
    button "Reset All"#resetAllLogFilters
    button "Refresh"#divRefreshLog
    button "Export"#divExportLog
    slot #logGridContainer
  tab pane#tab-portal-operationsLog
    heading "Operations log"
    input text#divSearchOperationsLog placeholder "Type text to search"
    button "Search" primary
    label "Date"
    slot #operationsLogFromDate
    slot #operationsLogToDate
    button #clearDatesFilters
    slot #operationsLogTypeFilter
    slot #operationsLogCategoryFilter
    button "Reset All"#resetAllFilters
    button "Refresh"#divRefreshOperationsLog
    slot #operationsLogGridContainer
tab pane#tab-add-new
  heading "Link your Shopify shop with Cin7 Core"
  text "Authorize Cin7 Core to connect to your Shopify account In order to give Cin7 Core permission to connect to your shop, yo"
  block #addNewNote
    heading 
  form#frmAuthorise
    button "Connect to Shopify" primary
tab pane#tab-portal-help
  heading "Help"
  link "Shopify - Start your FREE trial now!"
  button "Read information sheet" primary
modal#Shopify_TaxMapping_AddTaxMapping small
  heading "Add a new US place of business"
  button "×"
  text "Please provide the state, county, and city where your US business is located in exactly the same way as they are defined"
  label "State"
  slot #Shopify_TaxMapping_State
  label "Taxable"
  input checkbox#Shopify_TaxMapping_StateTaxable
  label "County"
  slot #Shopify_TaxMapping_County
  label "Taxable"
  input checkbox#Shopify_TaxMapping_CountyTaxable
  label "City"
  slot #Shopify_TaxMapping_Municipality
  label "Taxable"
  input checkbox#Shopify_TaxMapping_MunicipalityTaxable
  button "Save"#Shopify_TaxMapping_Save primary
  button "Close"
modal#Shopify_Index_Catalog small
  heading "Shopify product management"
  button "×"
  slot #Shopify_Catalog_ValidationContainer (hidden)
  label "SKU"
  slot #Shopify_Catalog_ProductCode
  label "Product name"
  slot #Shopify_Catalog_ProductName
  label "Status"
  slot #Shopify_Catalog_Status
  text "You may choose any price tier from your product to specify the price of your product in Shopify. If you want to specify "
  label "Price tier"
  slot #Shopify_Index_PriceTier
  label "Price"
  slot #Shopify_Catalog_Price
  block #Shopify_Product_Status_Catalogue_Container
    label "List product as:"
    block #Shopify_Product_Status_Catalogue
      input radio#Shopify_Index_ListAsActive_Catalogue name=Shopify_Index_ProductStatus
      label "Active" for #Shopify_Index_ListAsActive_Catalogue
      input radio#Shopify_Index_ListAsDraft_Catalogue name=Shopify_Index_ProductStatus
      label "Draft" for #Shopify_Index_ListAsDraft_Catalogue
  label "Choose Shopify location(s) to list or update the product(s)"
  slot #Shopify_Catalog_Location
  label "Allow backorder"
  input checkbox#Shopify_Catalog_SellOutOfStock
  block #Shopify_Catalog_BufferInventoryControlsWarning
    slot #Shopify_Catalog_BufferInventoryControlsWarningCount
  block #Shopify_Catalog_BufferInventoryControlsContainer
    block #Shopify_Catalog_UseBufferInventoryContainer
      label "Use product-level buffer inventory"
      input checkbox#Shopify_Catalog_UseBufferInventory
    block #Shopify_Catalog_BufferInventoryContainer
      label "Product-level buffer"
      slot #Shopify_Catalog_BufferInventory
  block #Shopify_Catalog_AllActions
    button "List on Shopify"#Shopify_Catalog_List primary
    button "Update on Shopify"#Shopify_Catalog_Update primary
    button "Unlink"#Shopify_Catalog_Unlink
    button "Remove from Shopify"#Shopify_Catalog_Remove
    button "Save"#Shopify_Catalog_Save primary
    button "Close"
modal#Shopify_UpdateQuantity_Content small
  heading "Update quantities in Shopify"
  button "×"
  slot #Shopify_UpdateQuantity_ValidationContainer (hidden)
  text "All products listed in Cin7 Core Shopify catalog will be updated in Shopify with current available quantities from Cin7 "
  block #Shopify_UpdateQuantity_Actions
    button "Start" primary
    button "Close"
modal#Shopify_DownloadProducts_Content small
  heading "Load products from Shopify"
  button "×"
  slot #Shopify_DownloadProducts_ValidationContainer (hidden)
  block #Shopify_DownloadProducts_V2_Content
    text "All active products created after the selected date will be downloaded. Updates to linked products made after the select"
    block #Shopify_ImportProductsFromDate_Actions
      label "Created or updated after date"
      slot #Shopify_ProductsFromDate
  block #Shopify_DownloadProducts_V1_Content
    text "All active products from Shopify will be automatically loaded into Cin7 Core. If you need to include archived and draft "
  block #Shopify_DownloadArchiveProducts_Actions
    label "Download archived products" for #Shopify_Archive_Products
    input checkbox#Shopify_Archive_Products
  block #Shopify_DownloadDraftProducts_Actions
    label "Download draft products" for #Shopify_Archive_Products
    input checkbox#Shopify_Draft_Products
  block #Shopify_DownloadImage_Actions
    label "Download product images" for #Shopify_Download_Image
    input checkbox#Shopify_Download_Image
    text "Enabling this option would increase the time taken to download products."
  block #Shopify_DownloadProducts_Actions
    button "Load from Shopify" primary
    button "Close"
modal#Shopify_DownloadCustomers_Content small
  heading "Load customers from Shopify"
  button "×"
  slot #Shopify_DownloadCustomers_ValidationContainer (hidden)
  text "All customers from Shopify will be loaded into Cin7 Core. If there is a customer in Cin7 Core with the same name as in S"
  block #Shopify_DownloadCustomers_Actions
    button "Load from Shopify" primary
    button "Close"
modal#Shopify_DownloadOrders_Content small
  heading "Load orders from Shopify"
  button "×"
  slot #Shopify_DownloadOrders_ValidationContainer (hidden)
  text "All orders from Shopify will be loaded into Cin7 Core as pending orders. This operation may take a long time. Please lea"
  label "Orders created since"
  slot #Shopify_FromOrders
  block #Shopify_DownloadOrders_Actions
    button "Load from Shopify" primary
    button "Close"
form#frmProcess
```

## Components by bundle

What the page code builds and mounts into the layout's slots.

### `Shopify2019`

8 grids · 58 standalone fields · 0 windows · 2 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `divLocationMapping` · store `vShopifyLocationMappingStore` · placeholder `No locations loaded from Shopify`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Name | `ShopifyLocationName` |  | flex 1 | renderer() |  |
    | Location | `LocationName` |  | flex 1 | renderer() |  |

- **grid** · renders into `divTaxMapping` · store `vShopifyTaxMappingStore` · placeholder `Loading Shopify tax rates...`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Country | `Country` |  | flex 1 | RenderHTMLText |  |
    | Province | `Province` |  | flex 1 | RenderHTMLText |  |
    | Shopify tax name | `Name` |  | flex 1 | RenderHTMLText |  |
    | Tax rule | `TaxRuleName` |  | flex 1 | renderer() |  |

- **grid** · renders into `divPaymentMapping` · store `vShopifyPaymentProcessorMappingStore` · placeholder `Loading Shopify payment processors...`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Payment processor | `PaymentProcessor` |  | flex 1 | RenderHTMLText |  |
    | Payment account code | `AccountCode` |  | flex 1 | renderer() |  |

- **grid** · renders into `catalogGridContainer` · store `catalogStore` · placeholder `No products found.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `ProductCode` |  | flex 5 | renderer() |  |
    | Status | `Status` |  | 120 | renderer() |  |
    | Available stock | `Available` |  | 100 |  |  |
    | Sync quantity | `SyncQuantity` |  | 100 |  |  |
    | Buffer inventory | `SyncBufferInventory` |  | 100 |  |  |
    | Price from | `PriceTier` |  | flex 1 | renderer() |  |
    | Allow backorder | `SellOutOfStock` |  | flex 1 | renderer() |  |

- **grid** · renders into `divBulkList` · store `bulkStore` · placeholder `No products found.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `ProductCode` |  | flex 2 | renderer() |  |
    | Category | `CategoryName` |  | flex 1 | renderer() |  |
    | Status | `Status` |  | 120 | renderer() |  |
    | Available stock | `Available` |  | 100 |  |  |
    | Sync quantity | `SyncQuantity` |  | 100 |  |  |
    | Buffer inventory | `SyncBufferInventory` |  | 100 |  |  |
    | Price | `ProductID` |  | 120 | renderer() |  |
    | Ready for Shopify | `ProductID` |  | flex 1 | renderer() |  |
    | Allow backorder | `SellOutOfStock` |  | flex 1 | renderer() |  |

- **grid** · renders into `divPendingOrdersGrid` · store `pendingOrdersStore` · placeholder `You do not have any pending Shopify orders at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Order # | `OrderNumber` |  | 100 | renderer() |  |
    | Date | `InvoiceDate` | date column | 120 | renderer() |  |
    | Customer | `Contact` |  | flex 1 | renderer() |  |
    | Product | `Name` |  | flex 2 | renderer() |  |
    | Quantity | `Quantity` |  | 100 |  |  |
    | Total | `Total` |  | flex 1 | renderer() |  |

- **grid** · renders into `logGridContainer` · store `logStore` · placeholder `You do not have any captured Shopify orders at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Order # | `OrderNumber` |  | flex 1 |  |  |
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
    | Date | `Date` | date column | flex 2 | renderer() |  |
    | Type | `Type` |  | flex 1 | renderer() |  |
    | User | `UserName` |  | flex 2 | renderer() |  |
    | Category | `Category` |  | flex 2 | renderer() |  |
    | Processed | `Processed` | check column | 100 | renderer() |  |
    | Description | `Description` |  | flex 4 | renderer() |  |


#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| checkbox |  | `"Shopify_Catalog_Location".concat(…)` | `` |  |
| checkbox |  | `"Shopify_BulkList_Location".concat(…)` | `` |  |
| date field |  | `Shopify_FromOrders` | `` | placeholder `Choose...` · format `UserDateFormat` |
| date field |  | `Shopify_ProductsFromDate` | `` | placeholder `Choose...` · format `UserDateFormat` |
| date field |  | `Shopify_Index_OrderLockDate` | `` | placeholder `Choose...` · format `UserDateFormat` |
| combo |  | `Shopify_TaxMapping_State` | `USStateStore` | shows `Value` · value `Code` · placeholder `Choose...` · pick-only |
| text field |  | `Shopify_TaxMapping_County` | `` | placeholder `County` |
| text field |  | `Shopify_TaxMapping_Municipality` | `` | placeholder `City` |
| combo |  | `tdBulkCategory` | `CategoryStore` | shows `Category` · value `CategoryID` · placeholder `List all categories` |
| combo |  | `tdBulkTag` | `TagsStore` | shows `Value` · value `Value` · placeholder `List all tags` |
| combo |  | `tdBulkPriceTier` | `vSalesPriceTiersStore` | shows `Name` · value `Code` · placeholder `Choose...` · pick-only |
| combo |  | `tdBulkSellOutOfStock` | `SellOutOfStockOptionsStore` | shows `name` · value `value` · placeholder `Don't update existing setup` · pick-only |
| number field |  | `tdBulkBufferInventory` | `` | placeholder `0` |
| combo |  | `tdBulkUseBufferInventory` | `UseBufferInventoryOptionsStore` | shows `name` · value `value` · placeholder `Don’t update existing setting` · pick-only |
| combo |  | `Shopify_Index_Topic` | `TopicStore` | shows `description` · value `type` · pick-only |
| combo |  | `Shopify_Index_Master_Data_Source` | `MasterDataSourceStore` | shows `name` · value `value` · pick-only |
| combo |  | `Shopify_Index_ConsolidateOrdersLegacy` | `ConsolidationTypeStore` | shows `text` · value `value` · pick-only |
| combo |  | `Shopify_Index_ConsolidationFrequency` | `ConsolidationFrequencyStore` | shows `description` · value `value` · pick-only |
| combo |  | `Shopify_Index_PaymentReference` | `PaymentReferenceTypeStore` | shows `description` · value `type` · pick-only |
| combo |  | `Shopify_Index_ConsolidationTime` | `vTimeStore` | shows `Name` · value `Value` · pick-only |
| combo |  | `Shopify_Index_Customer` | `vCustomerStore` | shows `Name` · value `CustomerID` · placeholder `Choose...` |
| combo |  | `Shopify_Editor_PriceTier` | `vSalesPriceTiersStore` | shows `Name` · value `Code` · placeholder `Choose...` · pick-only |
| combo |  | `Shopify_Editor_CompareAtPriceTier` | `vSalesPriceTiersStore` | shows `Name` · value `Code` · placeholder `Choose...` · pick-only |
| combo |  | `Shopify_Editor_AutoShippingMode` | `AutoShippingModeStore` | shows `name` · value `value` · placeholder `Choose...` · pick-only |
| combo |  | `Shopify_Editor_InvoiceStatus` | `InvoiceStatusStore` | shows `name` · value `value` · placeholder `Choose...` · pick-only |
| combo |  | `Shopify_Index_CreateAssembly` | `CreateAssemblyStore` | shows `name` · value `value` · placeholder `Choose...` · pick-only |
| combo |  | `Shopify_Index_LiabilityAccount` | `LiabilityAccountStore` | shows `DisplayName` · value `Code` · placeholder `Choose...` · pick-only |
| combo |  | `Shopify_Index_RetailDeliveryFeeAccount` | `RetailDeliveryAccountStore` | shows `DisplayName` · value `Code` · placeholder `Choose...` · pick-only |
| combo |  | `Shopify_Index_RevenueAccount` | `RevenueAccountStore` | shows `DisplayName` · value `Code` · placeholder `Choose...` |
| text field |  | `Shopify_Index_CustomSalesRepresentative` | `` | placeholder `write...` |
| number field |  | `Shopify_Index_BufferInventory` | `` | placeholder `0` |
| combo |  | `Shopify_Index_Location` | `LocationStore` | shows `DescriptionSetupOnlineSales` · value `LocationID` · placeholder `Choose...` · pick-only |
| combo |  | `Shopify_Index_AttributeForTags` | `vSaleAttributeStore` | shows `Name` · value `Id` · placeholder `Choose...` |
| combo |  | `Shopify_Index_AttributeForType` | `vSaleAttributeStore` | shows `Name` · value `Id` · placeholder `Do not import` |
| combo |  | `Shopify_Index_PriceTier` | `vSalesPriceTiersStore` | shows `Name` · value `Code` · placeholder `Choose...` · pick-only |
| number field |  | `Shopify_Catalog_BufferInventory` | `` | placeholder `0` |
| combo |  | `tdBulkListingStatus` | `BulkListingStatusStore` | shows `Name` · value `Value` · placeholder `List all products` · pick-only |
| combo |  | `tdShopify_Chart_Period` | `ChartDatePeriodStore` | shows `name` · value `value` · pick-only |
| date field |  | `tdShopify_Chart_From` | `` | format `UserDateFormat` |
| date field |  | `tdShopify_Chart_To` | `` | format `UserDateFormat` |
| date field |  | `divFromDatePendingOrders` | `` | placeholder `From` · format `UserDateFormat` |
| date field |  | `divToDatePendingOrders` | `` | placeholder `To` · format `UserDateFormat` |
| combo |  | `tdShopify_Chart_GroupBy` | `ChartGroupByStore` | shows `name` · value `value` · pick-only |
| combo |  | `tdShopify_Chart_Type` | `ChartTypeStore` | shows `name` · value `value` · pick-only |
| date field |  | `operationsLogFromDate` | `` | placeholder `From` · format `UserDateFormat` |
| date field |  | `operationsLogToDate` | `` | placeholder `To` · format `UserDateFormat` |
| combo |  | `operationsLogTypeFilter` | `operationsLogTypeStore` | shows `text` · value `value` · placeholder `All Types` · pick-only |
| combo |  | `operationsLogCategoryFilter` | `operationsLogCategoryStore` | shows `text` · value `value` · placeholder `All Categories` · pick-only |
| combo |  | `logDateColumnFilter` | `logDateColumnStore` | shows `text` · value `value` · placeholder `Select Date Type` · pick-only |
| date field |  | `logFromDate` | `` | placeholder `From` · format `UserDateFormat` |
| date field |  | `logToDate` | `` | placeholder `To` · format `UserDateFormat` |
| combo |  | `logTypeFilter` | `logTypeStore` | shows `text` · value `value` · placeholder `All Types` · pick-only |
| combo |  | `logStatusFilter` | `logStatusStore` | shows `text` · value `value` · placeholder `All Statuses` · pick-only |
| combo |  | `tdBulkListingBrand` | `vTenantBrandStore` | shows `Brand` · value `ID` · placeholder `List all brands` |
| combo |  | `tdBulkListingListedIn` | `ECommerceShopStore` | shows `ShopName` · value `ConfigID` · placeholder `Choose...` |
| date field |  | `divExportLogFrom` | `` | format `UserDateFormat` |
| date field |  | `divExportLogTo` | `` | format `UserDateFormat` |
| combo |  | `divExportLogPeriod` | `periodStore` | shows `name` · value `value` · pick-only |

#### Menus, buttons and other parts

- **column** · field `j`
- **component** · renders into `tdBulkFamily` · store `FamilyStore` · shows `Name` · value `ID` · placeholder `List all families`

