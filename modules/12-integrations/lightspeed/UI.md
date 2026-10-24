# Lightspeed: UI

Every component the page code builds, read from the shipped ExtJS bundles: grids with their columns, fields, buttons, menus, windows and custom components. Labels are the English UI text. `renders into` is the id of the `<div>` in the page's server-rendered HTML that the component mounts in; `store` names the data store (see the endpoints in [README.md](README.md)); `on click` is the handler. Visual system and shell layout: [docs/UI.md](../../../docs/UI.md).

## Screens

| Route | Title | Bundles |
|---|---|---|
| `/Lightspeed` | Lightspeed | [`Vend2019`](#vend2019) |
| `/Vend` | Lightspeed | [`Vend2019`](#vend2019) |

## Layout

Each screen's server-rendered HTML inside the shell, as an outline: headings, tabs, sections, labels, inputs (`#id`), buttons (`▾` = dropdown), menus, tables and `slot`s (empty `<div>`s the components below mount into). `(hidden)` parts are shown by the page code when needed. Read with GET from a signed-in session; no values are kept.

### `/Lightspeed`: Lightspeed

Frame: `task-upload-frame`.

```text
link "Home"
link "Integrations"
tabs#portal-main-tab: Overview #tab_overview |  #tab-add-new | Help #tab-portal-help
tab pane#tab_overview
  tabs#overview-list: 
  block #overview-content (hidden)
    text "Lightspeed"
    text "Read the full information sheet about Lightspeed and Cin7 Core integration."
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
  tabs: Setup #tab-portal-setup | Catalog #tab-portal-catalog | Bulk listing #tab-portal-bulkLoad | Pending sales #tab-portal-pendingOrders | Export payments #tab-portal-exportPayments | Stock #tab-portal-stock | Log #tab-portal-log | Operations log #tab-shop-operationsLog
  text "Lightspeed"
  text "Read the full information sheet about Lightspeed and Cin7 Core integration."
  button "Read information sheet" primary
  button "Help" primary
  tab pane#tab-portal-setup
    heading "Setup"
    button "Save"#btnSaveSetupChanges primary
    block #authError (hidden)
      text "Connection with your Lightspeed store requires reauthorization."
      form#frmReConnect
        button "Reconnect to Lightspeed" primary
    slot #account_details
    slot #setupValidation (hidden)
    text "General settings"
    label "Capture Lightspeed sale when it is"
    slot #Vend_Index_Topic
    label "Consolidate sales"
    slot #Vend_Index_ConsolidationType
    block #trDailyConsolidationWarning
      text "Returns and refunds for walk-in sales are not supported by daily consolidation mode."
    block #liVend_Index_ConsolidationTime (hidden)
      label "Consolidation time"
      slot #Vend_Index_ConsolidationTime
    label "Customer"
    slot #Vend_Index_Customer
    label "Sale price tier"
    slot #Vend_Editor_PrimaryPriceTier
    label "Pick, pack, and ship processing mode"
    slot #Vend_Editor_AutoFulfilmentMode
    label "Process auto-assembly"
    slot #Vend_Editor_CreateAssembly
    block #chkIgnoreRestockForNotFulfilledContainer
      block #chkIgnoreRestockForNotFulfilledContainer
        label "Ignore restock for non fulfilled sales"
        input checkbox#divIgnoreRestockForNotFulfilled
    text "Account and cash settings"
    label "Invoice status"
    slot #Vend_Editor_InvoiceStatus
    label "Gift card liability account"
    slot #Vend_Editor_LiabilityAccount
    label "Optional revenue account"
    slot #Vend_Editor_RevenueAccount
    text "Lightspeed settings"
    label "List products as draft"
    input checkbox#Vend_Index_ListAsDraft
    label "Sales representative name"
    slot #Vend_Editor_CustomSalesRepresentative
    label "Update stock levels in Lightspeed"
    input checkbox#Vend_Index_SyncStockLevel
    label "Use Lightspeed as master source for Cin7 Core products"
    input checkbox#Vend_Index_SyncCategoryAndBrand
    block #chkUseBufferInventoryContainer
      label "Use buffer inventory"
      input checkbox#Vend_Index_UseBufferInventory
    block #txtBufferInventoryContainer
      label "Buffer inventory"
      slot #Vend_Index_BufferInventory
    block #wrnUseBufferInventory
      text "To enable the stock buffer only for specific products (like best-sellers), set 0 for 'Buffer inventory' here, and the re"
    label "Automatically import stock operations from Lightspeed"
    input checkbox#Vend_Index_StockPolling
    label "Default supplier"
    slot #Vend_Index_Supplier
    text "Link Lightspeed and Cin7 Core tax rules"
    button "Load from Lightspeed"#divLoadTaxMapping
    slot #divTaxMapping
    text "Link Lightspeed outlets to Cin7 Core locations"
    button "Load from Lightspeed"#divLoadLocationMapping
    slot #divLocationMapping
    text "Link Lightspeed payment methods to payment accounts"
    button "Load from Lightspeed"#divLoadPaymentProcessorMapping
    text "You can select accounts to use for payments received via listed payment methods if account has type "BANK" or has indica"
    slot #divPaymentProcessorMapping
    text "Disconnect from your Lightspeed store"
    slot #CreationDate
    button "Disconnect from Lightspeed store"
    form#frmDisconnect
  tab pane#tab-portal-catalog
    heading "Catalog"
    input text#divSearchCatalog placeholder "Type text to search"
    button "Search" primary
    button "Refresh"#divRefreshCatalog
    button "Download"#downloadAction ▾
    slot #cmbDownload
    button "More actions"#divMore ▾
    link "Update quantity"
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
    slot #Vend_BulkListing_ValidationContainer (hidden)
    slot #divBulkList
  tab pane#tab-portal-pendingOrders
    heading "Sales"
    input text#divSearchPendingOrders placeholder "Type text to search"
    button "Search" primary
    button "Refresh"#divRefreshPendingOrders
    button "Load sales"#divDownloadOrders
    button "Process"#divProcessOrders
    button #Grid_PendingOrders_Options
    slot #divPendingOrdersGrid
  tab pane#tab-portal-exportPayments
    heading "Export payments"
    input text#divSearchExportPayments placeholder "Type text to search"
    button "Search" primary
    button "Refresh"#divRefreshExportPayments
    button "Export to Lightspeed"#divExportPaymentsToVend
    button #Grid_ExportPaymentsGrid_Options
    slot #exportPaymentsGridContainer
  tab pane#tab-portal-stock
    heading "Stock"
    slot #Vend_FromStock
    label "Stock operations since"
    button "Download stock"#btnDownloadStock primary
    link "Purchases"
    link "Stock adjustments"
    link "Stock transfers"
    tab pane#stock-purchase-tab
      input text#divSearchPurchases placeholder "Type text to search"
      button "Search" primary
      button "Refresh"#divRefreshPurchases
      button #Grid_PurchasesGrid_Options
      slot #purchasesGridContainer
    tab pane#stock-adjustment-tab
      input text#divSearchStockAdjustments placeholder "Type text to search"
      button "Search" primary
      button "Refresh"#divRefreshStockAdjustments
      button #Grid_StockAdjustmentsGrid_Options
      slot #stockAdjustmentsGridContainer
    tab pane#stock-transfers-tab
      input text#divSearchStockTransfers placeholder "Type text to search"
      button "Search" primary
      button "Refresh"#divRefreshStockTransfers
      button #Grid_StockTransfersGrid_Options
      slot #stockTransfersGridContainer
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
    button "Search"#divRefreshOperationsLogSearchButton primary
    button "Refresh"#divRefreshOperationsLog
    slot #operationsLogGridContainer
tab pane#tab-add-new
  heading "Link your Lightspeed shop with Cin7 Core"
  button "Connect to Lightspeed"#btnConnectToShop primary
  block #addNewNote
    heading 
  form#frmAuthorise
    label "Your shop name at Lightspeed"
    slot #Vend_Index_ShopName
tab pane#tab-portal-help
  heading "Help"
  link "Lightspeed - Start your FREE trial now!"
  button "Read information sheet" primary
modal#Vend_Index_Catalog small
  heading "Lightspeed product management"
  button "×"
  slot #Vend_Catalog_ValidationContainer (hidden)
  text "You are managing the product on Lightspeed"
  label "SKU"
  slot #Vend_Catalog_ProductCode
  label "Product name"
  slot #Vend_Catalog_ProductName
  label "Status"
  slot #Vend_Catalog_Status
  label "Sync stock level"
  input checkbox#Vend_Catalog_SyncStockLevel
  block #Vend_Catalog_BufferInventoryControlsWarning
    slot #Vend_Catalog_BufferInventoryControlsWarningCount
  block #Vend_Catalog_BufferInventoryControlsContainer
    block #Vend_Catalog_UseBufferInventoryContainer
      label "Use product-level buffer inventory"
      input checkbox#Vend_Catalog_UseBufferInventory
    block #Vend_Catalog_BufferInventoryContainer
      label "Product-level buffer"
      slot #Vend_Catalog_BufferInventory
  block #Vend_Catalog_AllActions
    button "List on Lightspeed"#Vend_Catalog_List primary
    button "Update on Lightspeed"#Vend_Catalog_Update primary
    button "Remove from Lightspeed"#Vend_Catalog_Remove
    button "Save"#Vend_Catalog_Save primary
    button "Close"
modal#Vend_DownloadCustomers_Content small
  heading "Load customers from Lightspeed"
  button "×"
  slot #Vend_DownloadCustomers_ValidationContainer (hidden)
  text "All customers from Lightspeed will be loaded into Cin7 Core. If there is a customer in Cin7 Core with the same name as i"
  block #Vend_DownloadCustomers_Actions
    button "Load from Lightspeed" primary
    button "Close"
modal#Vend_DownloadSuppliers_Content small
  heading "Load suppliers from Lightspeed"
  button "×"
  slot #Vend_DownloadSuppliers_ValidationContainer (hidden)
  text "All suppliers from Lightspeed will be loaded into Cin7 Core. If there is a supplier in Cin7 Core with the same name as i"
  block #Vend_DownloadSuppliers_Actions
    button "Load from Lightspeed" primary
    button "Close"
modal#Vend_DownloadProducts_Content small
  heading "Load products from Lightspeed"
  button "×"
  slot #Vend_DownloadProducts_ValidationContainer (hidden)
  text "All products from Lightspeed will be loaded into Cin7 Core. If a matching product is found in Cin7 Core this product wil"
  block #Vend_DownloadProducts_Actions
    button "Load from Lightspeed" primary
    button "Close"
modal#Vend_DownloadOrders_Content small
  heading "Load sales from Lightspeed"
  button "×"
  slot #Vend_DownloadOrders_ValidationContainer (hidden)
  text "All orders from Lightspeed will be loaded into Cin7 Core as pending orders. This operation may take a long time. Please "
  label "Sales created since"
  slot #Vend_FromOrders
  block #Vend_DownloadOrders_Actions
    button "Load from Lightspeed" primary
    button "Close"
modal#Vend_UpdateQuantity_Content small
  heading "Update quantities in Lightspeed"
  button "×"
  slot #Vend_UpdateQuantity_ValidationContainer (hidden)
  text "All products listed in Cin7 Core Lightspeed catalog will be updated in Lightspeed with current available quantities from"
  block #Vend_UpdateQuantity_Actions
    button "Start" primary
    button "Close"
modal#Vend_ExportPayments_Content small
  heading "Export payments to Lightspeed"
  button "×"
  slot #Vend_ExportPayments_ValidationContainer (hidden)
  text "Payments for on account and lay by sales that exist in Cin7 Core but not in Lightspeed will be exported to Lightspeed. T"
  block #Vend_ExportPayments_Actions
    button "Start" primary
    button "Close"
modal#Vend_DownloadStockOperations_Content small
  heading "Load stock operations from Lightspeed"
  button "×"
  slot #Vend_DownloadStockOperations_ValidationContainer (hidden)
  text "All stock operations from Lightspeed will be loaded into Cin7 Core. This operation may take a long time. Please leave th"
  block #Vend_DownloadStockOperations_Actions
    button "Close"
form#frmProcess
```

### `/Vend`: Lightspeed

Redirects to `/Lightspeed`.

Frame: `task-upload-frame`.

```text
link "Home"
link "Integrations"
tabs#portal-main-tab: Overview #tab_overview |  #tab-add-new | Help #tab-portal-help
tab pane#tab_overview
  tabs#overview-list: 
  block #overview-content (hidden)
    text "Lightspeed"
    text "Read the full information sheet about Lightspeed and Cin7 Core integration."
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
  tabs: Setup #tab-portal-setup | Catalog #tab-portal-catalog | Bulk listing #tab-portal-bulkLoad | Pending sales #tab-portal-pendingOrders | Export payments #tab-portal-exportPayments | Stock #tab-portal-stock | Log #tab-portal-log | Operations log #tab-shop-operationsLog
  text "Lightspeed"
  text "Read the full information sheet about Lightspeed and Cin7 Core integration."
  button "Read information sheet" primary
  button "Help" primary
  tab pane#tab-portal-setup
    heading "Setup"
    button "Save"#btnSaveSetupChanges primary
    block #authError (hidden)
      text "Connection with your Lightspeed store requires reauthorization."
      form#frmReConnect
        button "Reconnect to Lightspeed" primary
    slot #account_details
    slot #setupValidation (hidden)
    text "General settings"
    label "Capture Lightspeed sale when it is"
    slot #Vend_Index_Topic
    label "Consolidate sales"
    slot #Vend_Index_ConsolidationType
    block #trDailyConsolidationWarning
      text "Returns and refunds for walk-in sales are not supported by daily consolidation mode."
    block #liVend_Index_ConsolidationTime (hidden)
      label "Consolidation time"
      slot #Vend_Index_ConsolidationTime
    label "Customer"
    slot #Vend_Index_Customer
    label "Sale price tier"
    slot #Vend_Editor_PrimaryPriceTier
    label "Pick, pack, and ship processing mode"
    slot #Vend_Editor_AutoFulfilmentMode
    label "Process auto-assembly"
    slot #Vend_Editor_CreateAssembly
    block #chkIgnoreRestockForNotFulfilledContainer
      block #chkIgnoreRestockForNotFulfilledContainer
        label "Ignore restock for non fulfilled sales"
        input checkbox#divIgnoreRestockForNotFulfilled
    text "Account and cash settings"
    label "Invoice status"
    slot #Vend_Editor_InvoiceStatus
    label "Gift card liability account"
    slot #Vend_Editor_LiabilityAccount
    label "Optional revenue account"
    slot #Vend_Editor_RevenueAccount
    text "Lightspeed settings"
    label "List products as draft"
    input checkbox#Vend_Index_ListAsDraft
    label "Sales representative name"
    slot #Vend_Editor_CustomSalesRepresentative
    label "Update stock levels in Lightspeed"
    input checkbox#Vend_Index_SyncStockLevel
    label "Use Lightspeed as master source for Cin7 Core products"
    input checkbox#Vend_Index_SyncCategoryAndBrand
    block #chkUseBufferInventoryContainer
      label "Use buffer inventory"
      input checkbox#Vend_Index_UseBufferInventory
    block #txtBufferInventoryContainer
      label "Buffer inventory"
      slot #Vend_Index_BufferInventory
    block #wrnUseBufferInventory
      text "To enable the stock buffer only for specific products (like best-sellers), set 0 for 'Buffer inventory' here, and the re"
    label "Automatically import stock operations from Lightspeed"
    input checkbox#Vend_Index_StockPolling
    label "Default supplier"
    slot #Vend_Index_Supplier
    text "Link Lightspeed and Cin7 Core tax rules"
    button "Load from Lightspeed"#divLoadTaxMapping
    slot #divTaxMapping
    text "Link Lightspeed outlets to Cin7 Core locations"
    button "Load from Lightspeed"#divLoadLocationMapping
    slot #divLocationMapping
    text "Link Lightspeed payment methods to payment accounts"
    button "Load from Lightspeed"#divLoadPaymentProcessorMapping
    text "You can select accounts to use for payments received via listed payment methods if account has type "BANK" or has indica"
    slot #divPaymentProcessorMapping
    text "Disconnect from your Lightspeed store"
    slot #CreationDate
    button "Disconnect from Lightspeed store"
    form#frmDisconnect
  tab pane#tab-portal-catalog
    heading "Catalog"
    input text#divSearchCatalog placeholder "Type text to search"
    button "Search" primary
    button "Refresh"#divRefreshCatalog
    button "Download"#downloadAction ▾
    slot #cmbDownload
    button "More actions"#divMore ▾
    link "Update quantity"
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
    slot #Vend_BulkListing_ValidationContainer (hidden)
    slot #divBulkList
  tab pane#tab-portal-pendingOrders
    heading "Sales"
    input text#divSearchPendingOrders placeholder "Type text to search"
    button "Search" primary
    button "Refresh"#divRefreshPendingOrders
    button "Load sales"#divDownloadOrders
    button "Process"#divProcessOrders
    button #Grid_PendingOrders_Options
    slot #divPendingOrdersGrid
  tab pane#tab-portal-exportPayments
    heading "Export payments"
    input text#divSearchExportPayments placeholder "Type text to search"
    button "Search" primary
    button "Refresh"#divRefreshExportPayments
    button "Export to Lightspeed"#divExportPaymentsToVend
    button #Grid_ExportPaymentsGrid_Options
    slot #exportPaymentsGridContainer
  tab pane#tab-portal-stock
    heading "Stock"
    slot #Vend_FromStock
    label "Stock operations since"
    button "Download stock"#btnDownloadStock primary
    link "Purchases"
    link "Stock adjustments"
    link "Stock transfers"
    tab pane#stock-purchase-tab
      input text#divSearchPurchases placeholder "Type text to search"
      button "Search" primary
      button "Refresh"#divRefreshPurchases
      button #Grid_PurchasesGrid_Options
      slot #purchasesGridContainer
    tab pane#stock-adjustment-tab
      input text#divSearchStockAdjustments placeholder "Type text to search"
      button "Search" primary
      button "Refresh"#divRefreshStockAdjustments
      button #Grid_StockAdjustmentsGrid_Options
      slot #stockAdjustmentsGridContainer
    tab pane#stock-transfers-tab
      input text#divSearchStockTransfers placeholder "Type text to search"
      button "Search" primary
      button "Refresh"#divRefreshStockTransfers
      button #Grid_StockTransfersGrid_Options
      slot #stockTransfersGridContainer
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
    button "Search"#divRefreshOperationsLogSearchButton primary
    button "Refresh"#divRefreshOperationsLog
    slot #operationsLogGridContainer
tab pane#tab-add-new
  heading "Link your Lightspeed shop with Cin7 Core"
  button "Connect to Lightspeed"#btnConnectToShop primary
  block #addNewNote
    heading 
  form#frmAuthorise
    label "Your shop name at Lightspeed"
    slot #Vend_Index_ShopName
tab pane#tab-portal-help
  heading "Help"
  link "Lightspeed - Start your FREE trial now!"
  button "Read information sheet" primary
modal#Vend_Index_Catalog small
  heading "Lightspeed product management"
  button "×"
  slot #Vend_Catalog_ValidationContainer (hidden)
  text "You are managing the product on Lightspeed"
  label "SKU"
  slot #Vend_Catalog_ProductCode
  label "Product name"
  slot #Vend_Catalog_ProductName
  label "Status"
  slot #Vend_Catalog_Status
  label "Sync stock level"
  input checkbox#Vend_Catalog_SyncStockLevel
  block #Vend_Catalog_BufferInventoryControlsWarning
    slot #Vend_Catalog_BufferInventoryControlsWarningCount
  block #Vend_Catalog_BufferInventoryControlsContainer
    block #Vend_Catalog_UseBufferInventoryContainer
      label "Use product-level buffer inventory"
      input checkbox#Vend_Catalog_UseBufferInventory
    block #Vend_Catalog_BufferInventoryContainer
      label "Product-level buffer"
      slot #Vend_Catalog_BufferInventory
  block #Vend_Catalog_AllActions
    button "List on Lightspeed"#Vend_Catalog_List primary
    button "Update on Lightspeed"#Vend_Catalog_Update primary
    button "Remove from Lightspeed"#Vend_Catalog_Remove
    button "Save"#Vend_Catalog_Save primary
    button "Close"
modal#Vend_DownloadCustomers_Content small
  heading "Load customers from Lightspeed"
  button "×"
  slot #Vend_DownloadCustomers_ValidationContainer (hidden)
  text "All customers from Lightspeed will be loaded into Cin7 Core. If there is a customer in Cin7 Core with the same name as i"
  block #Vend_DownloadCustomers_Actions
    button "Load from Lightspeed" primary
    button "Close"
modal#Vend_DownloadSuppliers_Content small
  heading "Load suppliers from Lightspeed"
  button "×"
  slot #Vend_DownloadSuppliers_ValidationContainer (hidden)
  text "All suppliers from Lightspeed will be loaded into Cin7 Core. If there is a supplier in Cin7 Core with the same name as i"
  block #Vend_DownloadSuppliers_Actions
    button "Load from Lightspeed" primary
    button "Close"
modal#Vend_DownloadProducts_Content small
  heading "Load products from Lightspeed"
  button "×"
  slot #Vend_DownloadProducts_ValidationContainer (hidden)
  text "All products from Lightspeed will be loaded into Cin7 Core. If a matching product is found in Cin7 Core this product wil"
  block #Vend_DownloadProducts_Actions
    button "Load from Lightspeed" primary
    button "Close"
modal#Vend_DownloadOrders_Content small
  heading "Load sales from Lightspeed"
  button "×"
  slot #Vend_DownloadOrders_ValidationContainer (hidden)
  text "All orders from Lightspeed will be loaded into Cin7 Core as pending orders. This operation may take a long time. Please "
  label "Sales created since"
  slot #Vend_FromOrders
  block #Vend_DownloadOrders_Actions
    button "Load from Lightspeed" primary
    button "Close"
modal#Vend_UpdateQuantity_Content small
  heading "Update quantities in Lightspeed"
  button "×"
  slot #Vend_UpdateQuantity_ValidationContainer (hidden)
  text "All products listed in Cin7 Core Lightspeed catalog will be updated in Lightspeed with current available quantities from"
  block #Vend_UpdateQuantity_Actions
    button "Start" primary
    button "Close"
modal#Vend_ExportPayments_Content small
  heading "Export payments to Lightspeed"
  button "×"
  slot #Vend_ExportPayments_ValidationContainer (hidden)
  text "Payments for on account and lay by sales that exist in Cin7 Core but not in Lightspeed will be exported to Lightspeed. T"
  block #Vend_ExportPayments_Actions
    button "Start" primary
    button "Close"
modal#Vend_DownloadStockOperations_Content small
  heading "Load stock operations from Lightspeed"
  button "×"
  slot #Vend_DownloadStockOperations_ValidationContainer (hidden)
  text "All stock operations from Lightspeed will be loaded into Cin7 Core. This operation may take a long time. Please leave th"
  block #Vend_DownloadStockOperations_Actions
    button "Close"
form#frmProcess
```

## Components by bundle

What the page code builds and mounts into the layout's slots.

### `Vend2019`

14 grids · 27 standalone fields · 0 windows · 1 menus, buttons and other parts · 0 custom components

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
    | Price | `Price` |  | flex 1 | renderer() |  |

- **grid** · renders into `exportPaymentsGridContainer` · store `exportPaymentsStore` · placeholder `No payments to export.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Lightspeed sale # | `OrderNumber` |  | 120 | RenderHTMLText |  |
    | Invoice # | `InvoiceNumber` |  | 120 | renderer() |  |
    | Error | `Error` |  | flex 1 | renderer() |  |

- **grid** · renders into `divTaxMapping` · store `vEcsTaxMappingStore` · placeholder `Loading Lightspeed taxes rates...`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Type | `Description` |  | flex 1 | RenderHTMLText |  |
    | Tax rule | `TaxRuleName` |  | flex 1 | renderer() |  |

- **grid** · renders into `divLocationMapping` · store `vEcsLocationMappingStore` · placeholder `Loading Lightspeed location rates...`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Name | `ECSLocationName` |  | flex 1 | renderer() |  |
    | Location | `LocationName` |  | flex 1 | renderer() |  |

- **grid** · renders into `divPaymentProcessorMapping` · store `vEcsPaymentProcessorMappingStore` · placeholder `Loading Lightspeed payment rates...`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Name | `PaymentProcessorName` |  | flex 1 | RenderHTMLText |  |
    | Payment account code | `LedgerAccount` |  | flex 1 | renderer() |  |

- **grid** · renders into `divPendingOrdersGrid` · store `pendingOrdersStore` · placeholder `You do not have any pending Lightspeed sales at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Order number | `OrderNumber` |  | 100 | renderer() |  |
    | Date | `DateCreated` | date column | 120 | renderer() |  |
    | Customer | `CustomerName` |  | flex 1 | renderer() |  |
    | Product | `Name` |  | flex 2 | renderer() |  |
    | Quantity | `Quantity` |  | 100 |  |  |
    | Total paid | `Total` |  | flex 1 | renderer() |  |

- **grid** · renders into `logGridContainer` · store `logStore` · placeholder `You do not have any captured Lightspeed sales at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Status | `Status` |  | flex 1 | renderer() |  |
    | Date | `Date` | date column | flex 1 | renderer() |  |
    | Download date | `DownloadDate` | date column | flex 1 | renderer() |  |
    | Process date | `ProcessDate` | date column | flex 1 | renderer() |  |
    | Lightspeed invoice # | `OrderNumber` |  | flex 1 | RenderHTMLText |  |
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
    | SKU | `ProductCode` |  | flex 1 | renderer() |  |
    | Product | `Name` |  | flex 2 | renderer() |  |
    | Category | `Category` |  | flex 1 | renderer() |  |
    | Status | `Status` |  | 120 | renderer() |  |
    | Available quantity | `Quantity` |  | 100 | renderer() |  |
    | Sync quantity | `SyncQuantity` |  | 100 |  |  |
    | Buffer inventory | `SyncBufferInventory` |  | 100 |  |  |
    | Price | `Price` |  | flex 1 | renderer() |  |

- **grid** · renders into `stockTransfersGridContainer` · store `stockTransfersStore` · placeholder `You do not have any captured Lightspeed stock transfers at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Lightspeed transfer # | `ECSStockTransferNumber` |  | flex 1 | RenderHTMLText |  |
    | Transfer # | `DearNumber` |  | flex 1 | renderer() |  |
    | Creation date | `CreatedDate` | date column | flex 1 | renderer() |  |
    | Receive date | `ReceivedDate` | date column | flex 1 | renderer() |  |
    | Lightspeed status | `ECSStatus` |  | flex 1 | renderer() |  |
    | Status | `DearStatus` |  | flex 1 | renderer() |  |

- **grid** · renders into `stockAdjustmentsGridContainer` · store `stockAdjustmentsStore` · placeholder `You do not have any captured Lightspeed stock adjustments at the mome…`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Lightspeed stocktake # | `ECSStockAdjustmentNumber` |  | flex 1 | RenderHTMLText |  |
    | Stock adjustment # | `DearNumber` |  | flex 1 | renderer() |  |
    | Creation date | `CreatedDate` | date column | flex 1 | renderer() |  |
    | Completion date | `CompletedDate` | date column | flex 1 | renderer() |  |
    | Lightspeed status | `ECSStatus` |  | flex 1 | renderer() |  |
    | Status | `DearStatus` |  | flex 1 | renderer() |  |

- **grid** · renders into `purchasesGridContainer` · store `purchasesStore` · placeholder `You do not have any captured Lightspeed purchases at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Lightspeed purchase # | `ECSPurchaseNumber` |  | flex 1 | RenderHTMLText |  |
    | Purchase # | `DearOrderNumber` |  | flex 1 | renderer() |  |
    | Creation date | `CreatedDate` | date column | flex 1 | renderer() |  |
    | Receive date | `ReceivedDate` | date column | flex 1 | renderer() |  |
    | Lightspeed status | `ECSStatus` |  | flex 1 | renderer() |  |
    | Status | `DearStatus` |  | flex 1 | renderer() |  |

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
| text field |  | `Vend_Index_ShopName` | `` |  |
| combo |  | `Vend_Index_Topic` | `TopicStore` | shows `description` · value `type` · pick-only |
| combo |  | `Vend_Index_ConsolidationType` | `ConsolidationTypeStore` | shows `description` · value `type` · pick-only |
| combo |  | `Vend_Index_ConsolidationTime` | `vTimeStore` | shows `Name` · value `Value` · pick-only |
| combo |  | `Vend_Index_Customer` | `vCustomerStore` | shows `Name` · value `CustomerID` · placeholder `Choose...` |
| combo |  | `Vend_Index_Supplier` | `vSupplierStore` | shows `Name` · value `SupplierID` · placeholder `Choose...` |
| combo |  | `Vend_Editor_PrimaryPriceTier` | `vSalesPriceTiersStore` | shows `Name` · value `Code` · placeholder `Choose...` · pick-only |
| combo |  | `Vend_Editor_AutoFulfilmentMode` | `AutoFulfilmentModeStore` | shows `name` · value `value` · placeholder `Choose...` · pick-only |
| combo |  | `Vend_Editor_InvoiceStatus` | `InvoiceStatusStore` | shows `name` · value `value` · placeholder `Choose...` · pick-only |
| combo |  | `Vend_Editor_CreateAssembly` | `CreateAssemblyStore` | shows `name` · value `value` · placeholder `Choose...` · pick-only |
| combo |  | `Vend_Editor_LiabilityAccount` | `LiabilityAccountStore` | shows `DisplayName` · value `Code` · placeholder `Choose...` · pick-only |
| combo |  | `Vend_Editor_RevenueAccount` | `RevenueAccountStore` | shows `DisplayName` · value `Code` · placeholder `Choose...` |
| text field |  | `Vend_Editor_CustomSalesRepresentative` | `` | placeholder `write...` |
| number field |  | `Vend_Index_BufferInventory` | `` | placeholder `0` |
| number field |  | `Vend_Catalog_BufferInventory` | `` | placeholder `0` |
| combo |  | `tdBulkCategory` | `CategoryStore` | shows `Category` · value `CategoryID` · placeholder `List all categories` |
| combo |  | `tdBulkTag` | `TagsStore` | shows `Value` · value `Value` · placeholder `List all tags` |
| combo |  | `tdBulkListingStatus` | `BulkListingStatusStore` | shows `Name` · value `Value` · placeholder `List all products` · pick-only |
| number field |  | `tdBulkBufferInventory` | `` | placeholder `0` |
| combo |  | `tdBulkUseBufferInventory` | `UseBufferInventoryOptionsStore` | shows `name` · value `value` · placeholder `Don’t update existing setting` · pick-only |
| date field |  | `Vend_FromStock` | `` | placeholder `Choose...` · format `UserDateFormat` |
| date field |  | `Vend_FromOrders` | `` | placeholder `Choose...` · format `UserDateFormat` |
| combo |  | `tdBulkListingBrand` | `vTenantBrandStore` | shows `Brand` · value `ID` · placeholder `List all brands` |
| combo |  | `tdBulkListingListedIn` | `ECommerceShopStore` | shows `ShopName` · value `ConfigID` · placeholder `Choose...` |
| date field |  | `divExportLogFrom` | `` | format `UserDateFormat` |
| date field |  | `divExportLogTo` | `` | format `UserDateFormat` |
| combo |  | `divExportLogPeriod` | `periodStore` | shows `name` · value `value` · pick-only |

#### Menus, buttons and other parts

- **component** · renders into `tdBulkFamily` · store `FamilyStore` · shows `Name` · value `ID` · placeholder `List all families`

