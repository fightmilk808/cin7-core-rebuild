# Shiptheory: UI

Every component the page code builds, read from the shipped ExtJS bundles: grids with their columns, fields, buttons, menus, windows and custom components. Labels are the English UI text. `renders into` is the id of the `<div>` in the page's server-rendered HTML that the component mounts in; `store` names the data store (see the endpoints in [README.md](README.md)); `on click` is the handler. Visual system and shell layout: [docs/UI.md](../../../docs/UI.md).

## Screens

| Route | Title | Bundles |
|---|---|---|
| `/Shiptheory` | Shiptheory | [`Shiptheory2019`](#shiptheory2019) |

## Layout

Each screen's server-rendered HTML inside the shell, as an outline: headings, tabs, sections, labels, inputs (`#id`), buttons (`▾` = dropdown), menus, tables and `slot`s (empty `<div>`s the components below mount into). `(hidden)` parts are shown by the page code when needed. Read with GET from a signed-in session; no values are kept.

### `/Shiptheory`: Shiptheory

Frame: `task-upload-frame`.

```text
link "Home"
link "Integrations"
tabs#shop-main-tab: Shipping service #tab-ship-service |  #tab-add-new |  #tab-shop-help (hidden)
button "Help"
tab pane#tab-ship-service
  tabs#navShippingService: Setup #tab-shipping-service-setup | Shipment log #tab-shipping-service-log | Catalog #tab-shipping-service-productcatalogue
  tab pane#tab-shipping-service-setup
    heading "Shipping service"
    block #btnSaveServiceChanges
      button "Set default"#Shiptheory_Index_MakeDefaultButton primary
      button "Save" primary
      form#frmMakeDefaultSS
    label "Integrate with Shiptheory"
    input radio#ShippingService_Export_On name=ShippingService_Export
    label "Export sale orders to Shiptheory" for #ShippingService_Export_On
    input radio#ShippingService_Export_Off name=ShippingService_Export
    label "Generate shipping labels in Cin7 Core" for #ShippingService_Export_Off
    label "Currency in Shiptheory"
    slot #Shiptheory_ShipServ_Currency
    label "Use as document number"
    slot #Shiptheory_ShipServ_UseAsDocumentNumber
    block #divSendNotificationOnLabelGeneration
      label "Send notification on shipping label generation"
      input checkbox#SendNotificationOnLabelGeneration
    label "Submit recipient TAX number"
    input checkbox#SubmitRecipientTaxNumber
    label "Print shipping labels"
    input checkbox#StarShipIt_ShipServ_PrintShippingLabels
    label "Shipping label per package"
    input checkbox#AllowMultipleShippingLabels
    block #divPreferredCarrierServiceList
      label "Preferred carriers/services"
      select#cmbCarrierServiceList
      slot #divSelectedCarrierServiceValues (hidden)
    block #divShippingServiceExportSetup
      text "Export for sale order setup"
      block #divShippingServiceExportFFOrders
        label "Export sales fulfilled externally"
        input checkbox#chkShippingServiceExportFFOrders
      block #divShippingServiceIgnoreBillingContact
        label "Capture ship to company as:"
        input radio#rbtShippingServiceIgnoreBillingContactTrue name=ShippingService_IgnoreBilling
        label "Leave blank when ship to company is not specified." for #rbtShippingServiceIgnoreBillingContactTrue
        input radio#rbtShippingServiceIgnoreBillingContactFalse name=ShippingService_IgnoreBilling
        label "Use customer name when ship to company not specified" for #rbtShippingServiceIgnoreBillingContactFalse
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
    block #divDisconnectSS
      heading "Disconnect from your Shiptheory"
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
  tab pane#tab-shipping-service-productcatalogue
    heading "Catalog"#formCaption
    text "Here you are able to add custom fields required for international shipping like commodity description and commodity comp"
    slot #tdCategoryFilter
    label "Category"
    slot #tdProductTagFilter
    label "Product tag"
    slot #tdFamilyFilter
    label "Family"
    slot #tdBrandFilter
    label "Brand"
    input text#divSearchCatalog name=divSearch placeholder "Type text to search"
    button "Search"#btnSearchCatalog primary
    button "Import"#btnImportCatalog
    button "Export"#btnExportCatalog
    slot #catalogGridContainer
tab pane#tab-add-new
  heading "To connect please specify your Shiptheory credentials"
  button "Connect to Shiptheory"#btnConnectAsShipServ primary
  form#frmAuthorise
    label "Shiptheory login"
    slot #Shiptheory_Index_Login
    label "Shiptheory password"
    slot #Shiptheory_Index_Password
tab pane#tab-shop-help
  heading "Help"
  link "privacy policy"
modal#divShippingServiceScheduleExport small
  heading "Set up sale order manual export"
  button "×"
  text "Sale orders within the selected filter period will be exported to Shiptheory at the next scheduled export. Shipment auth"
  label "From"
  slot #cmbShippingServiceScheduleExportFrom
  label "To"
  slot #cmbShippingServiceScheduleExportTo
  button "OK"#btnSubmitShippingServiceScheduleExport primary
  button "Close"
```

## Components by bundle

What the page code builds and mounts into the layout's slots.

### `Shiptheory2019`

4 grids · 9 standalone fields · 0 windows · 2 menus, buttons and other parts · 0 custom components

#### Grids

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

- **grid** · renders into `divExceptionsContainer` · store `store` · placeholder `Please upload a file to check for issues.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Line # | `Line` |  | 50 |  |  |
    | Product code | `ProductCode` |  | 200 | renderer() |  |
    | Commodity description | `CommodityDescription` |  | 200 | renderer() |  |
    | Commodity composition | `CommodityComposition` |  | flex 1 | renderer() |  |

- **grid** · renders into `catalogGridContainer` · store `vCatalogStore` · placeholder `No products found.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | SKU | `ProductCode` |  | flex 1 | renderer() |  |
    | Product | `Name` |  | flex 2 | renderer() |  |
    | Commodity description | `CommodityDescription` |  | flex 2 | renderer() |  |
    | Commodity composition | `CommodityComposition` |  | flex 2 | renderer() |  |


#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| combo |  | `Shiptheory_ShipServ_UseAsDocumentNumber` | `vDocumentNumberTypesStore` | shows `name` · value `value` |
| text field |  | `Shiptheory_Index_Login` | `` |  |
| text field |  | `Shiptheory_Index_Password` | `` |  |
| combo |  | `Shiptheory_ShipServ_Currency` | `CurrencyStore` | shows `Code` · value `Code` |
| date field |  | `"cmbShippingServiceScheduleExport".concat(…)` | `` | placeholder `Choose date` · format `UserDateFormat` |
| date field |  | `"cmbShippingServiceLogDate".concat(…)` | `` | placeholder `Choose date` · format `UserDateFormat` · disabled |
| combo |  | `tdCategoryFilter` | `CategoryStore` | shows `Category` · value `CategoryID` · placeholder `List of all categories` |
| combo |  | `tdProductTagFilter` | `TagsStore` | shows `Value` · value `Value` · placeholder `List of all tags` |
| combo |  | `tdBrandFilter` | `BrandStore` | shows `Brand` · value `ID` · placeholder `List of all brands` |

#### Menus, buttons and other parts

- **component** · renders into `tdFamilyFilter` · store `FamilyStore` · shows `Name` · value `ID` · placeholder `List all families`
- **form** · renders into `Ext.getBody(…)`

