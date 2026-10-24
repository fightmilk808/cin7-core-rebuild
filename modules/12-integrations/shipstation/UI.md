# ShipStation: UI

Every component the page code builds, read from the shipped ExtJS bundles: grids with their columns, fields, buttons, menus, windows and custom components. Labels are the English UI text. `renders into` is the id of the `<div>` in the page's server-rendered HTML that the component mounts in; `store` names the data store (see the endpoints in [README.md](README.md)); `on click` is the handler. Visual system and shell layout: [docs/UI.md](../../../docs/UI.md).

## Screens

| Route | Title | Bundles |
|---|---|---|
| `/ShipStation/ConfigurationNG` | ShipStation | [`Shipstation2019`](#shipstation2019) |

## Layout

Each screen's server-rendered HTML inside the shell, as an outline: headings, tabs, sections, labels, inputs (`#id`), buttons (`▾` = dropdown), menus, tables and `slot`s (empty `<div>`s the components below mount into). `(hidden)` parts are shown by the page code when needed. Read with GET from a signed-in session; no values are kept.

### `/ShipStation/ConfigurationNG`: ShipStation

Frame: `task-upload-frame`.

```text
link "Home"
link "Integrations"
tabs#shop-main-tab: Overview #tab_overview | Custom Store #tab-custom-store | Shipping service #tab-ship-service |  #tab-add-new | Help #tab-shop-help
tab pane#tab_overview
  block #overview-content
    text "ShipStation"
    text "Read full information sheet about ShipStation and Cin7 Core integration."
    button "Read information sheet" primary
    button "Help" primary
    tab pane#overview-content-tab
      block #overview-base-shop-settings
        text "Base settings"
        slot #overview-shop-settings
        slot #overview-shop-link
      block #overview-content
        block #overview-shop-logo
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
tab pane#tab-shop-settings
  tabs: Setup #tab-shop-setup | Action required #tab-shop-auth | Catalog #tab-shop-catalog | Pending orders #tab-shop-pendingOrders | Log #tab-shop-log | Operations log #tab-shop-operationsLog
  tab pane#tab-shop-setup
    heading "Setup"
    button "Save"#btnSaveSetupChanges primary
    slot #setupValidation
    label "Capture order when it is"
    slot #ShipStationFF_Index_Topic
    label "Consolidate sales"
    slot #ShipStationFF_Index_ConsolidationType
    block #liShipStationFF_Index_ConsolidationTime (hidden)
      label "Consolidation time"
      slot #ShipStationFF_Index_ConsolidationTime
    label "Customer"
    slot #ShipStationFF_Index_Customer
    label "Sale price tier"
    slot #ShipStationFF_Editor_PrimaryPriceTier
    label "Pick, pack, and ship processing mode"
    slot #ShipStationFF_Editor_AutoFulfilmentMode
    block #chkIgnoreRestockForNotFulfilledContainer
      label "Ignore restock for non fulfilled sales"
      input checkbox#divIgnoreRestockForNotFulfilled
    label "Invoice status"
    slot #ShipStationFF_Editor_InvoiceStatus
    label "Optional revenue account"
    slot #ShipStationFF_Editor_RevenueAccount
    label "ShipStation dimensions units"
    slot #ShipStationFF_Editor_DimUnits
    label "Sales representative name"
    slot #ShipStationFF_Editor_CustomSalesRepresentative
    label "Match product manually"
    input checkbox#ShipStationFF_Index_Mathcing
    block #ShipStationFF_Index_AllowCreateDearProducts
      label "Create a new product if not found by SKU"
      input checkbox#ShipStationFF_Index_AllowCreate
    label "Use ShipStation as master source for Cin7 Core products"
    input checkbox#ShipStationFF_Index_UseAsMaster
    label "Shipment is taxable"
    input checkbox#ShipStationFF_Editor_ShipmentTaxable
    block #ShipStation_Index_EnableOrderRoutingBlock
      label "Enable order routing"
      input checkbox#ShipStation_Index_EnableOrderRouting
    label "Process auto-assembly"
    slot #ShipStationFF_Index_CreateAssembly
    text "Link ShipStation warehouses to Cin7 Core locations"
    button "Load from ShipStation"#divLoadLocationMapping primary
    slot #divLocationMapping
    text "Link ShipStation and Cin7 Core tax rules"
    button "Add a US place of business"#divAddTaxMapping primary
    slot #divTaxMapping
    text "Link ShipStation payment methods to payment accounts"
    text "You can select accounts to use for payments received via listed payment methods if account has type "BANK" or has indica"
    slot #divPaymentProcessorMapping
    block #divDisconnect
      text "Disconnect from your ShipStation store"
      button "Disconnect from ShipStation store"
      form#frmDisconnect
  tab pane#tab-shop-auth
    heading "Connection with ShipStation requires authorization"
    text "Cin7 Core has problems accessing ShipStation. Most likely, the access token has been revoked. Please try to reactivate i"
    form#frmReactivation
  tab pane#tab-shop-catalog
    heading "Catalog"
    button "Load products"#divDownloadProducts primary
    button "Load customers"#divDownloadCustomers primary
    input text#divSearchCatalog placeholder "Type text to search"
    button "Search" primary
    button "Refresh"#divRefreshCatalog
    button #CatalogGrid_Options
    slot #catalogGridContainer
  tab pane#tab-shop-pendingOrders
    heading "Pending orders"
    button "Load orders"#divDownloadOrders primary
    button "Process"#divProcessOrders primary
    input text#divSearchPendingOrders placeholder "Type text to search"
    button "Search" primary
    button "Refresh"#divRefreshPendingOrders
    button #PendingOrdersGrid_Options
    slot #divPendingOrdersGrid
  tab pane#tab-shop-log
    heading "Logs"
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
tab pane#tab-custom-store
  block #divInstruction
    heading "ShipStation Custom Store integration setup"
    link "ShipStation"
  label "Custom Store Integration status"
  input checkbox#Shipstation_Index_CustomerStoreStatus
  block #ShipStation_id_stockLocatorBlock (hidden)
    label "Use stock locator instead of location as warehouse"
    input checkbox#ShipStation_StockLocator
  block #ShipStation_id_exportFFOrdersBlock (hidden)
    label "Export sales fulfilled externally"
    input checkbox#ShipStation_ExportFFOrders
  block #ShipStation_id_importShippingCostsBlock (hidden)
    label "Import shipping costs"
    input checkbox#ShipStation_ImportShippingCosts
  block #ShipStation_id_applyTaxOnShippingCostBlock (hidden)
    label "Apply tax on shipping costs"
    input checkbox#ShipStation_ApplyTaxOnShippingCost
  block #ShipStation_id_shippingCostZeroTaxRuleBlock (hidden)
    label "Zero tax"
    slot #ShipStation_ShippingCostZeroTaxRule
  block #ShipStation_id_ignoreBillingContactBlock (hidden)
    label "Capture ship to company as:"
    input radio#ShipStation_IgnoreBillingContact_true name=ShipStation_IgnoreBillingContact
    label "Ignore billing customer even when ship to company is not specified" for #ShipStation_IgnoreBillingContact_true
    input radio#ShipStation_IgnoreBillingContact_false name=ShipStation_IgnoreBillingContact
    label "Use customer name when ship to company not specified" for #ShipStation_IgnoreBillingContact_false
  block #ShipStation_id_customStoreCurrencyBlock (hidden)
    label "Currency in ShipStation"
    slot #ShipStation_CustomStoreCurrency
  block #tabNotMatchingAddresses (hidden)
    text "Tasks not ready for ShipStation"
    input text#divSearch placeholder "Type text to search"
    button "Search" primary
    button "Refresh"#divRefresh
    button #Grid_Grid_Options
    slot #NotMatchingAddresses
tab pane#tab-ship-service
  tabs#navShippingService: Setup #tab-shipping-service-setup | Shipment log #tab-shipping-service-log
  tab pane#tab-shipping-service-setup
    heading "Shipping service"
    block #btnSaveServiceChanges
      button "Set default"#ShipStationFF_Index_MakeDefaultButton primary
      button "Save"#btnSaveSetupChanges primary
      form#frmMakeDefaultSS
    label "Integrate with ShipStation"
    input radio#ShippingService_Export_On name=ShippingService_Export
    label "Export sale orders to ShipStation" for #ShippingService_Export_On
    input radio#ShippingService_Export_Off name=ShippingService_Export
    label "Without export of sale orders to ShipStation" for #ShippingService_Export_Off
    text "Generate shipping label"
    label "Default ship from address"
    slot #ShipStationFF_ShipServ_FromAddress
    label "Use tax rate from"
    select#ShipStationFF_ShipServ_CustomerTax: Default | Customer
    block #ShipStationFF_ShipServ_TaxRuleBlock
      label "Tax rule for shipping"
      slot #ShipStationFF_ShipServ_TaxRule
    label "Weight units in ShipStation"
    slot #ShipStationFF_ShipServ_WeightUnits
    label "Dimension units in ShipStation"
    slot #ShipStationFF_ShipServ_DimUnits
    label "Currency in ShipStation"
    slot #ShipStationFF_ShipServ_Currency
    label "Additional shipping margin"
    slot #ShipStationFF_ShipServ_MarginValue
    label "Margin value is"
    select#ShipStationFF_ShipServ_Margin: Absolute | Relative
    label "Send notification on shipping label generation" for #SendNotificationOnLabelGeneration
    input checkbox#SendNotificationOnLabelGeneration
    label "From contact on shipping label"
    slot #From_Contact_On_Shipping_Label
    label "From company on shipping label"
    slot #From_Company_On_Shipping_Label
    label "Print shipping labels" for #StarShipIt_ShipServ_PrintShippingLabels
    input checkbox#StarShipIt_ShipServ_PrintShippingLabels
    block #divPreferredCarrierServiceList
      label "Preferred carriers/services"
      select#cmbCarrierServiceList
    slot #divSelectedCarrierServiceValues (hidden)
    block #divShippingServiceExportSetup (hidden)
      text "Export for sale order setup"
      block #divShippingServiceStockLocator
        label "Use stock locator instead of location as warehouse"
        input checkbox#chkShippingServiceStockLocator
      block #divShippingServiceExportFFOrders
        label "Export sales fulfilled externally"
        input checkbox#chkShippingServiceExportFFOrders
      block #divShippingServiceIgnoreBillingContact
        label "Capture ship to company as:"
        input radio#rbtShippingServiceIgnoreBillingContactTrue name=ShippingService_IgnoreBilling
        label "Leave blank when ship to company is not specified." for #rbtShippingServiceIgnoreBillingContactTrue
        input radio#rbtShippingServiceIgnoreBillingContactFalse name=ShippingService_IgnoreBilling
        label "Use customer name when ship to company not specified" for #rbtShippingServiceIgnoreBillingContactFalse
      label "Export sales to ShipStation store"
      slot #ShipStationFF_ShipServ_SSStore
      block #divShippingServiceImportShippingCosts
        label "Import shipping costs"
        input checkbox#chkShippingServiceImportShippingCosts
      block #divShippingServiceApplyTaxOnShippingCost (hidden)
        label "Apply tax on shipping costs"
        input checkbox#chkShippingServiceApplyTaxOnShippingCost
      block #divShippingServiceShippingCostZeroTaxRuleBlock (hidden)
        label "Zero tax"
        slot #cmbShippingServiceShippingCostZeroTaxRule
      text "Map Cin7 Core Locations to ShipStation Ship From Locations"
      button "Load from ShipStation"#divLoadShipIntegrationLocationMapping primary
      slot #divShipIntegrationLocationMapping
      text "Sale order export filter"
      button  primary
      slot #gridShipmentServiceFilter
      button "Add filter" primary
      text "Notifications"
      label "Notification recipient(s) for successful order export"
      select#cmbShippingServiceNotificationSuccess multiple
      label "Notification recipient(s) for failed order export"
      select#cmbShippingServiceNotificationFail multiple
      label "Notification recipient(s) on ship of exported order"
      select#cmbShippingServiceNotificationShip multiple
      label "Internal notification"
      input checkbox#chkShippingServiceNotificationInternalSuccess
      label "Internal notification"
      input checkbox#chkShippingServiceNotificationInternalFail
      label "Internal notification"
      input checkbox#chkShippingServiceNotificationInternalShipped
    text "Estimated shipping rate details"
    label "Send predefined package dimensions" for #AddPackageDimensions
    input checkbox#AddPackageDimensions
    block #divCarriersWithDimensions
      label "Select carriers"
      select#cmbCarrierList
    slot #divSelectedCarrierValues (hidden)
    block #divDimensionsTable (hidden)
      heading "Predefined package dimensions:"
      text "Please note UOM are as selected in 'Generate shipping label' settings above."
      table: Dimension | Quantity | UOM
    text "Default shipping settings"
    label "Use default shipping instructions" for #AddDefaultCarrierServicePackage
    input checkbox#AddDefaultCarrierServicePackage
    block #divCarrierServiceDomestic
      label "Domestic shipping"
      select#cmbCarrierServiceDomestic
    block #divPackageDomestic
      label "Domestic package"
      select#cmbPackageDomestic
    block #divCarrierServiceInternational
      label "International shipping"
      select#cmbCarrierServiceInternational
    block #divPackageInternational
      label "International package"
      select#cmbPackageInternational
    block #divDisconnectSS
      heading "Disconnect from your ShipStation Shipping Service"
      button "Disconnect"
      form#frmDisconnectSS
  tab pane#tab-shipping-service-log
    heading "Shipment log"
    heading "Filter orders by scheduled for export date"
    select#cmbShippingServiceLogDatePeriod: This week | Previous week | This month | Previous month | Custom
    slot #cmbShippingServiceLogDateFrom
    slot #cmbShippingServiceLogDateTo
    select#cmbShippingServiceLogStatus: All | Shipped | Exported | Skipped | Canceled | Failed
    label "Status"
    button "Schedule export"#btnShippingServiceScheduleExport
    button "Refresh"#btnRefreshShipmentLog
    text "Sale orders with shipment authorization between to have been scheduled for export."#divScheduledExportMessage
    input text#txtSearchShipmentLog placeholder "Type text to search"
    button "Search"#btnSearchShipmentLog primary
    slot #divShipmentLogGrid
tab pane#tab-add-new
  block #credentialsTitle
    heading "To connect ShipStation, please specify your API credentials"
  block #noteConnect
    heading "You are already using a ShipStation account."
    text "You may easily use it for other purposes by clicking on the button."
  form#frmAuthorise
    block #connectCredentials
      label "API key"
      slot #ShipStationFF_Index_ApiKey
      label "API secret"
      slot #ShipStationFF_Index_ApiSecret
  block #btnConnectToShop
    button "Connect ShipStation as a Store"#btnConnectAsStore primary
    button "Connect ShipStation as a shipping service"#btnConnectAsShipServ primary
tab pane#tab-shop-help
  heading "Help"
  button "Read information sheet" primary
modal#ShipstationFF_TaxMapping_AddTaxMapping small
  heading "Provide the place in the US where your business is located"
  button "×"
  label "Postal (ZIP) code"
  slot #ShipstationFF_TaxMapping_Zip
  label "County"
  slot #ShipstationFF_TaxMapping_County
  label "City"
  slot #ShipstationFF_TaxMapping_City
  block #ShipstationFF_TaxMapping_Actions
    button "Add"#ShipstationFF_TaxMapping_Save primary
    button "Close"
modal#ShipStationFF_Index_Catalog large
  heading "Link ShipStation product to Cin7 Core product"
  button "×"
  slot #ShipStationFF_Product_ImagePlaceholder
  heading #ShipStationFF_Catalog_ProductName
  table
  slot #tabUnlinked
  slot #tabLinked
  slot #tabBuild
  input radio#rbtnUnlinked name=radioActionToDo
  label "Do not link ShipStation product to any Cin7 Core product" for #rbtnUnlinked
  input radio#rbtnLink name=radioActionToDo
  label "Link ShipStation product to the existing Cin7 Core product" for #rbtnLink
  input radio#rbtnCreate name=radioActionToDo
  label "Create a new Cin7 Core product using ShipStation product details" for #rbtnCreate
  tab pane#tabCatalogInfo
    heading "ShipStation product is not linked."
  tab pane#tabCatalogLink
    heading "Select Cin7 Core product to link with..."
    slot #ShipStationFF_CatalogManagment_LinkToProduct
    slot #linkedProductPreview
    block #Catalog_IgnoreProductUpdationBlock
      input checkbox#ShipStationFF_Catalog_IgnoreProductUpdation
      label "Do not update the linked Cin7 Core product" for #ShipStationFF_Catalog_IgnoreProductUpdation
  tab pane#tabCatalogBuild
    heading "Create a new Cin7 Core product from ShipStation listing and link..."
    button "Build and link"#btnBuildProduct primary
    slot #foundProductPreview
  block #ShipStationFF_Catalog_AllActions
    button "Save"#ShipStationFF_Catalog_Update primary
    button "Close"
modal#ShipstationFF_DownloadProducts_Content medium
  heading "Load products from ShipStation"
  button "×"
  slot #ShipstationFF_DownloadProducts_ValidationContainer
  label "Enable image download" for #ShipStationFF_Download_Image
  input checkbox#ShipstationFF_Download_Image
  text "Enabling this option would increase the time taken to download products."
  block #ShipStationFF_DownloadProducts_Actions
    button "Load from ShipStation" primary
    button "Close"
modal#ShipstationFF_DownloadOrders_Content medium
  heading "Load orders from ShipStation"
  button "×"
  slot #ShipstationFF_DownloadOrders_ValidationContainer
  text "All orders created on or after the selected date will be loaded to Cin7 Core."
  label "Orders created since"
  slot #ShipstationFF_FromOrders
  block #ShipstationFF_DownloadOrders_Actions
    button "Load from ShipStation" primary
    button "Close"
modal#ShipStationFF_DownloadCustomers_Content medium
  heading "Load customers from ShipStation"
  button "×"
  slot #ShipStationFF_DownloadCustomers_ValidationContainer
  block #ShipStationFF_DownloadCustomers_Actions
    button "Load from ShipStation" primary
    button "Close"
modal#divShippingServiceScheduleExport small
  heading "Set up sale order manual export"
  button "×"
  text "Sale orders within the selected filter period will be exported to Shipstation at the next scheduled export. Shipment aut"
  label "From"
  slot #cmbShippingServiceScheduleExportFrom
  label "To"
  slot #cmbShippingServiceScheduleExportTo
  button "OK"#btnSubmitShippingServiceScheduleExport primary
  button "Close"
form#frmProcess
```

## Components by bundle

What the page code builds and mounts into the layout's slots.

### `Shipstation2019`

13 grids · 34 standalone fields · 0 windows · 4 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `overviewSalesGridContainer` · store `overviewSalesStore` · placeholder `No sales yet.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    |  | `Status` |  | 100 | renderer() |  |
    | Number | `SaleOrderNumber` |  | flex 2 | renderer() |  |
    | Date | `SaleOrderDate` |  | flex 1 | renderer() |  |
    | Customer | `CustomerName` |  | flex 1 | RenderHTMLText |  |
    | Amount | `PaidTotalAmount` |  | flex 1 | renderer() |  |

- **grid** · renders into `overviewCustomersGridContainer` · store `overviewCustomersStore` · placeholder `No customers yet.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Customer | `Name` |  | flex 2 | renderer() |  |
    | Sales | `OrderCount` |  | flex 1 |  |  |
    | Amount | `PaidTotalAmount` |  | flex 1 | renderer() |  |

- **grid** · renders into `NotMatchingAddresses` · store `mainStore` · placeholder `All sale tasks have matching customer addresses.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Invoice # | `InvoiceNumber` |  | flex 1 | renderer() |  |
    | Customer | `CustomerName` |  | flex 1 | renderer() |  |
    | Invoice date | `InvoiceDate` |  | flex 1 | renderer() |  |
    | Ship by | `ShipmentRequiredByDate` |  | flex 1 | renderer() |  |
    | Address | `ShippingAddressLine1` |  | flex 1 | renderer() |  |
    | Reason | `Reason` |  | flex 2 | RenderHTMLText |  |

- **grid** · renders into `divTaxMapping` · store `vEcsTaxMappingStore` · placeholder `Loading ShipStation tax rates...`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Type | `Description` |  | flex 1 |  |  |
    | Tax rule | `TaxRuleName` |  | flex 1 | renderer() |  |

- **grid** · renders into `divLocationMapping` · store `vEcsLocationMappingStore` · placeholder `Loading ShipStation warehouses...`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Name | `ECSLocationName` |  | flex 1 | RenderHTMLText |  |
    | Location | `LocationName` |  | flex 1 | renderer() |  |

- **grid** · renders into `divShipIntegrationLocationMapping` · store `vShipIntegrationLocationMappingStore` · placeholder `Loading ShipStation warehouses...`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Name | `WarehouseName` |  | flex 1 | RenderHTMLText |  |
    | Location | `LocationName` |  | flex 1 | renderer() |  |

- **grid** · renders into `divPaymentProcessorMapping` · store `vEcsPaymentProcessorMappingStore` · placeholder `Loading ShipStation payment methods...`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Name | `PaymentProcessorName` |  | flex 1 | RenderHTMLText |  |
    | Payment account code | `LedgerAccount` |  | flex 1 | renderer() |  |

- **grid** · renders into `divPendingOrdersGrid` · store `pendingOrdersStore` · placeholder `You do not have any pending orders at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Order # | `OrderNumber` |  | flex 1 | renderer() |  |
    | Date | `DateCreated` | date column | 80 | renderer() |  |
    | Customer | `CustomerName` |  | flex 2 | renderer() |  |
    | Product | `Name` |  | flex 2 | renderer() |  |
    | Quantity | `Quantity` |  | flex 1 |  |  |
    | Total paid | `Total` |  | flex 1 | renderer() |  |

- **grid** · renders into `logGridContainer` · store `logStore` · placeholder `You do not have any captured orders at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Status | `Status` |  | flex 1 | renderer() |  |
    | Date | `Date` | date column | flex 1 | renderer() |  |
    | Invoice # | `OrderNumber` |  | flex 1 |  |  |
    | Type | `Type` |  | flex 1 | renderer() |  |
    | Sale task | `SaleOrderNumber` |  | flex 1 | renderer() |  |

- **grid** · renders into `operationsLogGridContainer` · store `operationsLogStore` · placeholder `No entries found. Please hit refresh or change the search criteria.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Date | `Date` | date column | 170 | renderer() |  |
    | Type | `Type` |  | 80 | renderer() |  |
    | User | `UserName` |  | 200 | renderer() |  |
    | Category | `Category` |  | 100 | renderer() |  |
    | Processed | `Processed` | check column | 80 | renderer() |  |
    | Description | `Description` |  | flex 1 | renderer() |  |

- **grid** · renders into `catalogGridContainer` · store `productStore` · placeholder `There are no products in the catalog.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | SKU | `SKU` |  | flex 2 | renderer() |  |
    | Name | `Name` |  | flex 4 | renderer() |  |
    | Category | `Category` |  | flex 2 | renderer() |  |
    | Price | `Price` |  | flex 1 | renderer() |  |
    | Status | `Status` |  | 85 | renderer() |  |
    | Quantity | `Quantity` |  | flex 1 | renderer() |  |
    | Linked product | `ProductID` |  | flex 4 | renderer() |  |

- **grid** · renders into `gridShipmentServiceFilter` · placeholder `You do not have any filters at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Parameter name | `ParameterName` |  | flex 1 | renderer() |  |
    | Condition | `Condition` |  | flex 1 | renderer() |  |
    | Value | `Value` |  | flex 1 | renderer() |  |
    | Join | `Join` |  | flex 1 | renderer() |  |

- **grid** · renders into `divShipmentLogGrid` · store `ExportLogStore` · placeholder `You do not have any exported sale orders at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Scheduled for export | `ScheduledPeriod` |  | 105 | renderer() |  |
    | SO # | `OrderNumber` |  | flex 1 | renderer() |  |
    | Fulfillment # | `FulfillmentNumber` |  | flex 1 | renderer() |  |
    | Invoice # | `InvoiceNumber` |  | flex 1 | renderer() |  |
    | Customer | `CustomerName` |  | flex 1 | renderer() |  |
    | Ship by | `ShipByDate` |  | 105 | renderer() |  |
    | Status | `Status` |  | 120 | renderer() |  |
    | Comments | `Comments` |  | flex 2 | renderer() |  |


#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| text field |  | `ShipStationFF_Index_ApiKey` | `` |  |
| text field |  | `ShipStationFF_Index_ApiSecret` | `` |  |
| combo |  | `ShipStation_ShippingCostZeroTaxRule` | `ZeroTaxStore` | shows `Description` · value `RuleID` · placeholder `Choose...` |
| combo |  | `ShipstationFF_TaxMapping_Zip` | `USTaxZipTypeAhead` | shows `Name` · value `ID` · placeholder `Type a ZIP code here...` |
| combo |  | `ShipstationFF_TaxMapping_County` | `USTaxCountyTypeAhead` | shows `Name` · value `ID` · placeholder `Type the county name here...` · disabled |
| combo |  | `ShipstationFF_TaxMapping_City` | `USTaxCityTypeAhead` | shows `Name` · value `ID` · placeholder `Type the city name here...` · disabled |
| combo |  | `ShipStationFF_Editor_RevenueAccount` | `RevenueAccountStore` | shows `DisplayName` · value `Code` · placeholder `Choose...` |
| combo |  | `ShipStationFF_Editor_DimUnits` | `DefaultDimUnitStore` | shows `description` · value `type` · placeholder `Choose...` · pick-only |
| text field |  | `ShipStationFF_Editor_CustomSalesRepresentative` | `` | placeholder `write...` |
| combo |  | `ShipStationFF_Index_Topic` | `TopicStore` | shows `description` · value `type` · pick-only |
| combo |  | `ShipStationFF_Index_ConsolidationType` | `ConsolidationTypeStore` | shows `description` · value `type` · pick-only |
| combo |  | `ShipStationFF_Index_ConsolidationTime` | `vTimeStore` | shows `Name` · value `Value` · pick-only |
| combo |  | `ShipStationFF_Index_Customer` | `vCustomerStore` | shows `Name` · value `CustomerID` · placeholder `Choose...` |
| combo |  | `ShipStationFF_Editor_PrimaryPriceTier` | `vSalesPriceTiersStore` | shows `Name` · value `Code` · placeholder `Choose...` · pick-only |
| combo |  | `ShipStationFF_Editor_AutoFulfilmentMode` | `AutoFulfilmentModeStore` | shows `name` · value `value` · placeholder `Choose...` · pick-only |
| combo |  | `ShipStationFF_Editor_InvoiceStatus` | `InvoiceStatusStore` | shows `name` · value `value` · placeholder `Choose...` · pick-only |
| combo |  | `ShipStationFF_Index_CreateAssembly` | `CreateAssemblyStore` | shows `name` · value `value` · placeholder `Choose...` · pick-only |
| combo |  | `ShipStationFF_ShipServ_Currency` | `CurrencyStore` | shows `Code` · value `Code` |
| combo |  | `ShipStation_CustomStoreCurrency` | `CurrencyStore` | shows `Code` · value `Code` · pick-only |
| combo |  | `ShipStationFF_ShipServ_FromAddress` | `vTenantAddressStore` | shows `CountryLine` · value `AddressID` |
| combo |  | `ShipStationFF_ShipServ_TaxRule` | `TaxStore` | shows `Description` · value `RuleID` |
| combo |  | `ShipStationFF_ShipServ_WeightUnits` | `WeightUnitStore` | shows `Name` · value `Code` |
| combo |  | `ShipStationFF_ShipServ_DimUnits` | `DimUnitStore` | shows `Name` · value `Code` |
| combo |  | `ShipStationFF_ShipServ_SSStore` | `ShipstationStoresList` | shows `name` · value `value` · placeholder `Select store` |
| combo |  | `cmbShippingServiceShippingCostZeroTaxRule` | `window.ZeroTaxStore` | shows `Description` · value `RuleID` · placeholder `Choose...` |
| date field |  | `ShipstationFF_FromOrders` | `` | placeholder `Choose...` · format `UserDateFormat` |
| combo |  | `ShipStationFF_CatalogManagment_LinkToProduct` | `ProductChooseStore` | shows `Name` · value `ProductCode` |
| combo |  | `tdBulkListingBrand` | `vTenantBrandStore` | shows `Brand` · value `ID` · placeholder `List all brands` |
| combo |  | `tdBulkListingListedIn` | `ECommerceShopStore` | shows `ShopName` · value `ConfigID` · placeholder `Choose...` |
| date field |  | `divExportLogFrom` | `` | format `UserDateFormat` |
| date field |  | `divExportLogTo` | `` | format `UserDateFormat` |
| combo |  | `divExportLogPeriod` | `periodStore` | shows `name` · value `value` · pick-only |
| date field |  | `"cmbShippingServiceScheduleExport".concat(…)` | `` | placeholder `Choose date` · format `UserDateFormat` |
| date field |  | `"cmbShippingServiceLogDate".concat(…)` | `` | placeholder `Choose date` · format `UserDateFormat` · disabled |

#### Menus, buttons and other parts

- **component** · renders into `ShipStationFF_ShipServ_MarginValue` · required
- **component** · renders into `From_Contact_On_Shipping_Label` · required
- **component** · renders into `From_Company_On_Shipping_Label` · required
- **component** · renders into `"ShipStationFF_ShipServ_".concat(…)`

