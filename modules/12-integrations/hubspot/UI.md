# HubSpot: UI

Every component the page code builds, read from the shipped ExtJS bundles: grids with their columns, fields, buttons, menus, windows and custom components. Labels are the English UI text. `renders into` is the id of the `<div>` in the page's server-rendered HTML that the component mounts in; `store` names the data store (see the endpoints in [README.md](README.md)); `on click` is the handler. Visual system and shell layout: [docs/UI.md](../../../docs/UI.md).

## Screens

| Route | Title | Bundles |
|---|---|---|
| `/HubSpot` | HubSpot | [`HubSpot2019`](#hubspot2019) |

## Layout

Each screen's server-rendered HTML inside the shell, as an outline: headings, tabs, sections, labels, inputs (`#id`), buttons (`▾` = dropdown), menus, tables and `slot`s (empty `<div>`s the components below mount into). `(hidden)` parts are shown by the page code when needed. Read with GET from a signed-in session; no values are kept.

### `/HubSpot`: HubSpot

Frame: `task-upload-frame`.

```text
link "Integrations"
block #main-top-tabs
  link "Overview"#li-top-tab-Overview
  link "HubSpot shop"#li-top-tab-Setup (hidden)
button "Help"
block #page-container
  block #setup-left-menu (hidden)
    button "Setup"
    button "Products"
    button "Customers"
    button "Sales"
    button "Log"
  block #tab-overview-content (hidden)
    block #overview-content-block
      block #overview-base-settings
        heading "Base settings"
        text "Sale sync"
        slot #overview-base-settings-sale-sync
        text "Product sync"
        slot #overview-base-settings-product-sync
        text "Sale price tier"
        slot #overview-base-settings-sale-price-tier
        text "Auto-synchronization"
        slot #overview-base-settings-autosync
      block #overview-sales-summary-portlet
        heading "Sales summary"
        button "Refresh"#divRefreshSalesSummary
        slot #overview-sales-summary
      block #overview-tabs-container
        tabs#overview-tabs: Sales #overview-tab-sales | Customers #overview-tab-customers
        tab pane#overview-tab-sales
          input text#divSearchOverviewSales placeholder "Type text to search..."
          button "Search" primary
          button #Grid_OverviewSalesGrid_Options
          slot #overviewSalesGridContainer
        tab pane#overview-tab-customers
          input text#divSearchOverviewCustomers placeholder "Type text to search..."
          button "Search" primary
          button #Grid_OverviewCustomersGrid_Options
          slot #overviewCustomersGridContainer
  block #tab-portal-settings (hidden)
    heading "Setup"
    button "Save"#SetupSaveButton primary
    block #divConnectToHubSpotRequired (hidden)
      button "Connect" primary
    block #divSetup
      label "Synchronization status" for #cbHubSpotSyncStatus
      input checkbox#cbHubSpotSyncStatus
      block #divActiveBlock
        label "Update sale"
        select#cmbSaleSyncType
        label "Update product"
        select#cmbProductSyncType
        label "Update customer"
        select#cmbCustomerSyncType
        label "Product description type"
        select#cmdProductExportDescription
        label "Price tier"
        select#cmbPriceTier
        label "Price tier currency"
        select#cmbPriceTierCurrency
        label "Location"
        select#cmdLocation
        label "Save in Cin7 Core as"
        select#cmdProductImportType
        label "Force update HubSpot entities"
        input checkbox#cbForceUpdateOnExport
        label "Payment term"
        select#cmdProductExportTermPeriod
        input text#tbProductExportTermValue
        label "Save in Cin7 Core with category"
        select#cmdProductImportCategory
        label "Import contacts w/o companies"
        input checkbox#cbImportContactsWOOrg
        label "Force update Cin7 Core entities"
        input checkbox#cbForceUpdateOnImport
        label "Customer base currency"
        select#cmbCustomersBaseCurrency
        label "Revenue account"
        select#cmbCustomersRevenueAccount
        label "Payment term"
        select#cmbCustomersPaymentTerm
        label "Default customer taxation rule"
        select#cmbCustomersTaxRule
        label "Sync contact marketing consent"
        input checkbox#cbSyncMarketingConsent
        label "Default address type"
        select#cmbCustomersAddressType
        label ""
        input checkbox#cbAutoCreateProduct (hidden)
        label "Auto-synchronization" for #cbToHubSpotAutoSync
        input checkbox#cbToHubSpotAutoSync
        heading "Auto-sync" (hidden)
        label "Start date" (hidden)
        slot #divAutoSyncStartDate
        label "Start time" (hidden)
        input text#txtAutoSyncStartTime
        label "Sync frequency" (hidden)
        select#cmbAutoSyncFrequency
        label "Alert type for errors" (hidden)
        select#cmbAutoSyncAlertTypeForErrors
        label "Mailing list" (hidden)
        slot #divAutoSyncMailingList
        heading "Link HubSpot deal stages and Cin7 Core sale statuses"
        label "HubSpot pipeline"
        select#cmbSalePipeline
        button "Load pipelines from HubSpot"#HubSpot_Setup_DonwloadPipelines
        label "Import at HubSpot deal stage"
        slot #cmbCreateSaleWhenHubSpotReachesStage
        text "Note: Cin7 Core sale statuses will be mapped to HubSpot pipeline stages as per the configuration below. If you change de"
        text "Note: Cin7 Core loads deals from HubSpot only once when deal reaches the selected stage. According to the stage mapping "
        slot #divHubspotStatusesMapping
        heading "Link HubSpot and Cin7 Core customer fields"
        button #btnHubSpot_Setup_AddCustomerFieldsMappingLine primary
        slot #divHubspotCustomerFieldsMapping
        heading "Link HubSpot and Cin7 Core sale fields"
        button #btnHubSpot_Setup_AddSaleFieldsMappingLine primary
        slot #divHubspotSaleFieldsMapping
      block #divActiveButtonsBlock
        heading "Disconnect from HubSpot"
        button "Disconnect"#btnDisconnectFromHubSpot
        button "Reconnect"#btnReconnect (hidden)
  block #tab-products (hidden)
    heading "Products"
    button "Save" primary
    block #products-tabs
      tabs: From Cin7 Core #product-tab-from | To Cin7 Core #product-tab-to
      tab pane#product-tab-from
        text "Bulk list your products in HubSpot."
        slot #cmdProductToExport_PriceTier
        label "Price tier"
        slot #cmbProductToExport_PriceTierCurrency
        label "Price tier currency"
        slot #cmbProductToExport_Category
        label "Category"
        slot #cmbProductToExport_Type
        label "Product type"
        slot #cmbProductToExport_ListingStatus
        label "Listing status"
        input text#txtProductToExport_Search placeholder "Type text to search"
        button "Search" primary
        button "Start"#btnProductToExport_StartExport primary
        button "Refresh"#btnProductToExport_Refresh
        button #ProductToExportGrid_Options
        slot #HubSpot_ProductListing_ValidationContainer
        slot #divProductToExportList
      tab pane#product-tab-to
        slot #HubSpot_ProductCatalog_ValidationContainer
        input text#txtProductCatalog_Search placeholder "Type text to search"
        button "Search" primary
        button "Load products"#btnProductCatalog_LoadFromHubSpot primary
        button "Refresh"#btnProductCatalog_Refresh
        button #ProductCatelogGrid_Options
        slot #divProductCatalogList
        modal#dlgHubSpot_DownloadProducts_Content medium
          heading "Load products from HubSpot"
          button "×"
          slot #HubSpot_DownloadProducts_ValidationContainer (hidden)
          button "Load from HubSpot"#HubSpot_DownloadProducts_Actions primary
          button "Close"
  block #tab-contacts (hidden)
    heading "Contacts"
    button "Save" primary
    block #contacts-tabs
      tabs: From Cin7 Core #contact-tab-from | To Cin7 Core #contact-tab-to
      tab pane#contact-tab-to
        slot #HubSpot_ContactsCatalog_ValidationContainer
        input text#txtContacts_Search placeholder "Type text to search"
        button "Search"#divSearchContacts primary
        button "Download contacts" primary
        button "Refresh"#divRefreshContacts
        button #ContactsGrid_Options
        slot #contactsGridContainer
        modal#dlgHubSpot_DownloadContacts_Content medium
          heading "Load contacts from HubSpot"
          button "×"
          slot #HubSpot_DownloadContacts_ValidationContainer (hidden)
          button "Load from HubSpot"#divDownloadContacts primary
          button "Close"
      tab pane#contact-tab-from
        text "Bulk list your customers in HubSpot. Please note that if the customer has no contact, Cin7 Core exports only customer na"
        select#cmbCustomersToExport_IsActive: All | Active | Deprecated
        label "Customer status"
        select#cmbCustomersToExport_ListingStatus: All | Listed | Not listed
        label "Listing status"
        input text#txtCustomersToExport_Search placeholder "Type text to search"
        button "Search" primary
        block #HubSpot_ListCustomers_Actions
          button "Start"#btnCustomersToExport_StartExport primary
          button "Refresh"#btnCustomersToExport_Refresh
          button #CustomerExportGrid_Options
        slot #HubSpot_ListCustomers_ValidationContainer
        slot #divCustomersToExportList
  block #tab-sales (hidden)
    heading "Sales"
    button "Save" primary
    block #sales-tabs
      tabs: From Cin7 Core #sale-tab-from | To Cin7 Core #sale-tab-to
      tab pane#sale-tab-to
        slot #HubSpot_SalesCatalog_ValidationContainer
        input text#txtSalesImport_Search placeholder "Type text to search"
        button "Search" primary
        button "Download sales"#btnSalesImport_ShowImportDialog primary
        button "Refresh"#divRefreshSales
        button #SalesImportGrid_Options
        slot #salesImportGridContainer
        modal#dlgHubSpot_ImportSales_Content medium
          heading "Load sales from HubSpot"
          button "×"
          slot #HubSpot_ImportSales_ValidationContainer (hidden)
          heading #ImportDialogText
          slot #HubSpot_FromOrders
          button "Load from HubSpot"#HubSpot_ImportSales_Actions primary
          button "Close"
      tab pane#sale-tab-from
        text "Bulk list your sales in HubSpot."
        slot #HubSpot_ExportFromOrders
        label "From"
        input text#txtSalesExport_Search placeholder "Type text to search"
        button "Search" primary
        block #HubSpot_ListCustomers_Actions
          button "Start"#btnSalesExport_StartExport primary
          button "Refresh"#btnSalesToExport_Refresh
          button #SalesExportGrid_Options
        slot #HubSpot_ExportSales_ValidationContainer
        slot #salesExportGridContainer
  block #tab-log (hidden)
    heading "Log"
    input text#txtLog_Search placeholder "Type text to search"
    button "Search" primary
    button "Refresh"#btnLog_Refresh
    button #LogGrid_Options
    slot #logGridContainer
    form#frmExportAffectedEntitiesToExcel
  heading "Help"
  button "Read information sheet" primary
modal#dlgHubSpot_ProductCatalog_EditProduct medium
  heading "Map product from Cin7 Core to HubSpot"
  button "×"
  slot #HubSpot_ProductCatalog_Edit_ValidationContainer (hidden)
  heading "You are managing the product on HubSpot"
  label "SKU"
  slot #txtHubSpot_ProductCatalog_Edit_ProductCode
  input text#HubSpot_ProductCatalog_Edit_ProductCode (hidden)
  label "Product name"
  slot #txtHubSpot_ProductCatalog_Edit_ProductName
  slot #HubSpot_ProductCatalog_Edit_ProductName
  label "Status"
  slot #HubSpot_ProductCatalog_Edit_Status
  heading "Choosing price for your product"
  link "Product maintenance"#aProductMaintenance
  label "Price tier"
  slot #HubSpot_ProductCatalog_Edit_PriceTier
  label "Price"
  slot #HubSpot_ProductCatalog_Edit_Price
  label "Currency"
  slot #HubSpot_ProductCatalog_Edit_Currency
  heading "Manage product on HubSpot"
  block #HubSpot_ProductCatalog_Edit_AllActions
    button "Save"#HubSpot_ProductCatalog_Edit_Save primary
    button "Link with Cin7 Core"#HubSpot_ProductCatalog_Edit_Link (hidden)
    button "Create in Cin7 Core"#HubSpot_ProductCatalog_Edit_Create
    button "List on HubSpot"#HubSpot_ProductCatalog_Edit_List
    button "Update on HubSpot"#HubSpot_ProductCatalog_Edit_Update
    button "Unlink"#HubSpot_ProductCatalog_Edit_Unlink
    button "Remove from HubSpot"#HubSpot_ProductCatalog_Edit_Remove
    button "Close"
modal#HubSpot_NewProperty_Dialog small
  heading "Add a new HubSpot property"
  button "×"
  input text#HubSpot_NewProperty_PropertyName placeholder "Enter a displayed property name"
  label "Name"
  slot #HubSpot_NewProperty_EntityType
  label "Entity"
  button "Create" primary
  button "Close"
```

## Components by bundle

What the page code builds and mounts into the layout's slots.

### `HubSpot2019`

12 grids · 14 standalone fields · 0 windows · 0 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `contactsGridContainer` · store `contactsStore` · placeholder `Contacts are not found`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Contact name | `ContactName` |  | flex 1 |  |  |
    | Company name | `CompanyName` |  | flex 1 |  |  |
    | Company / person | `IsOrganization` |  | flex 1 | renderer() |  |

- **grid** · renders into `divCustomersToExportList` · store `customerStore` · placeholder `Customers are not found`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Name | `Name` |  | flex 1 |  |  |
    | Currency | `Currency` |  | flex 1 | RenderHTMLText |  |
    | Discount | `Discount` |  | flex 1 | RenderHTMLText |  |
    | Status | `IsListed` |  | flex 1 | renderer() |  |
    | Is active | `IsActive` | check column | 90 | renderer() |  |

- **grid** · renders into `logGridContainer` · store `logStore` · placeholder `You do not have any HubSpot log entries at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Date | `LogDate` | date column | flex 1 | renderer() |  |
    | Action | `Action` |  | flex 2 | RenderHTMLText |  |
    | Message | `Message` |  | flex 4 | renderer() |  |

- **grid** · renders into `overviewSalesGridContainer` · store `overviewSalesStore` · placeholder `No data`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Date | `SaleOrderDate` |  | flex 1 | renderer() |  |
    | Number | `SaleOrderNumber` |  | flex 1 | renderer() |  |
    | Customer | `CustomerName` |  | flex 1 | RenderHTMLText |  |
    | Amount | `PaidTotalAmount` |  | flex 1 | renderer() |  |
    | Status | `Status` |  | flex 1 | renderer() |  |

- **grid** · renders into `overviewCustomersGridContainer` · store `overviewCustomersStore` · placeholder `No data`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Customer | `Name` |  | flex 1 | RenderHTMLText |  |
    | Sales | `OrderCount` |  | flex 1 | RenderHTMLText |  |
    | Amount | `PaidTotalAmount` |  | flex 1 | renderer() |  |

- **grid** · renders into `divProductCatalogList` · store `vProductCatalogStore` · placeholder `No products are found.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | HubSpot name | `HubSpotName` |  | flex 1 | renderer() |  |
    | {Ext.String.format(…)} | `ProductCode` |  | flex 3 | renderer() |  |
    | Status | `Status` |  | flex 1 | renderer() |  |
    | Price | `ProductID` |  | flex 1 | renderer() |  |

- **grid** · renders into `divProductToExportList` · store `vProductToExportStore` · placeholder `No products are found.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Category | `CategoryName` |  | flex 1 | RenderHTMLText |  |
    | Type | `Type` |  | flex 1 | RenderHTMLText |  |
    | Product | `ProductCode` |  | flex 5 | renderer() |  |
    | Status | `Status` |  | flex 1 | renderer() |  |
    | Price | `ProductID` |  | flex 1 | renderer() |  |
    |  | `` | action column | 25 |  |  |

- **grid** · renders into `salesImportGridContainer` · store `salesImportStore` · placeholder `You do not have any pending HubSpot sales at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Deal name | `HubSpotDealName` |  | flex 1 |  |  |
    | Create date | `HubSpotDealDate` | date column | flex 1 | renderer() |  |
    | Total | `HubSpotTotal` |  | flex 1 | renderer() |  |
    | HubSpot deal stage | `HubSpotDealStage` |  | flex 1 | RenderHTMLText |  |

- **grid** · renders into `salesExportGridContainer` · store `saleExportStore` · placeholder `Sales are not found.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Order number | `OrderNo` |  | flex 1 |  |  |
    | Date | `OrderDate` | date column | flex 1 | renderer() |  |
    | Customer | `Customer` |  | flex 2 | RenderHTMLText |  |
    | Amount | `TotalAmount` |  | flex 1 | renderer() |  |

- **grid** · renders into `divHubspotCustomerFieldsMapping` · store `vHubspotCustomerFieldsMappingStore` · placeholder `No fields specified yet...`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | {Ext.String.format(…)} | `DearFieldName` |  | flex 1 | renderer() |  |
    | Hubspot field name | `ECSFieldName` |  | flex 1 | renderer() |  |
    |  | `` | action column | 45 | renderer() |  |

- **grid** · renders into `divHubspotSaleFieldsMapping` · store `vHubspotSaleFieldsMappingStore` · placeholder `No fields specified yet...`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | {Ext.String.format(…)} | `DearFieldName` |  | flex 1 | renderer() |  |
    | Hubspot field name | `ECSFieldName` |  | flex 1 | renderer() |  |
    |  | `` | action column | 45 | renderer() |  |

- **grid** · renders into `divHubspotStatusesMapping` · store `vPipeLineStageMappingStore` · placeholder `No fields specified yet...`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Hubspot deal stage | `HubSpotStageName` |  | flex 1 |  |  |
    | {Ext.String.format(…)} | `DearStatus` |  | flex 1 | renderer() |  |


#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| combo |  | `HubSpot_ProductCatalog_Edit_PriceTier` | `vSalesPriceTiersStore` | shows `Name` · value `Code` · placeholder `Choose...` · pick-only |
| combo |  | `HubSpot_ProductCatalog_Edit_Currency` | `` | shows `DisplayCurrency` · value `Currency` · placeholder `Choose...` · pick-only |
| combo |  | `HubSpot_ProductCatalog_Edit_ProductName` | `DearProductStore` | shows `Name` · value `ProductID` · placeholder `type or choose...` |
| combo |  | `cmbProductToExport_Category` | `vTenantCategoriesStore` | shows `Name` · value `Value` |
| combo |  | `cmbProductToExport_Type` | `ProductToExportTypeStore` | shows `Name` · value `Value` |
| combo |  | `cmdProductToExport_PriceTier` | `vSalesPriceTiersStore` | shows `Name` · value `Code` · placeholder `Choose...` · pick-only |
| combo |  | `cmbProductToExport_PriceTierCurrency` | `` | shows `DisplayCurrency` · value `Currency` · placeholder `Choose...` · pick-only |
| combo |  | `cmbProductToExport_ListingStatus` | `BulkListingStatusStore` | shows `Name` · value `Value` · placeholder `List all products` · pick-only |
| date field |  | `HubSpot_FromOrders` | `` | placeholder `Choose...` · format `UserDateFormat` |
| date field |  | `HubSpot_ExportFromOrders` | `` | placeholder `Choose...` · format `UserDateFormat` |
| combo |  | `HubSpot_NewProperty_EntityType` | `PropertyTypeStore` | shows `Name` · value `Value` · placeholder `Select an entity type` · pick-only |
| date field |  | `divAutoSyncStartDate` | `` | placeholder `Choose...` · format `UserDateFormat` |
| combo |  | `divAutoSyncMailingList` | `MailingListStore` | shows `Name` · value `MailingListID` · placeholder `type or choose...` |
| combo |  | `cmbCreateSaleWhenHubSpotReachesStage` | `vHubSpotStagesStore` | shows `HubSpotStageName` · value `HubSpotStageID` · placeholder `type or choose...` |

