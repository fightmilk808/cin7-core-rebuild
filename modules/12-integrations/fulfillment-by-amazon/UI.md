# Fulfillment by Amazon: UI

Every component the page code builds, read from the shipped ExtJS bundles: grids with their columns, fields, buttons, menus, windows and custom components. Labels are the English UI text. `renders into` is the id of the `<div>` in the page's server-rendered HTML that the component mounts in; `store` names the data store (see the endpoints in [README.md](README.md)); `on click` is the handler. Visual system and shell layout: [docs/UI.md](../../../docs/UI.md).

## Screens

| Route | Title | Bundles |
|---|---|---|
| `/FBA` | Fulfillment by Amazon | [`FBA2019`](#fba2019) |

## Layout

Each screen's server-rendered HTML inside the shell, as an outline: headings, tabs, sections, labels, inputs (`#id`), buttons (`▾` = dropdown), menus, tables and `slot`s (empty `<div>`s the components below mount into). `(hidden)` parts are shown by the page code when needed. Read with GET from a signed-in session; no values are kept.

### `/FBA`: Fulfillment by Amazon

Frame: `task-upload-frame`.

```text
link "Home"
link "Integrations"
button "Back to list"#backAction
tabs#shop-main-tab: Overview #tab_overview |  #tab-add-new | Help
tab pane#tab_overview
  tabs#overview-list: 
  block #overview-content (hidden)
    text "Fulfillment by Amazon"
    text "Read the full information sheet about FBA and Cin7 Core integration."
    button "Read information sheet" primary
    button "Help" primary
    tab pane#overview-content-tab
      heading #overview-shop-name
      block #overview-base-shop-settings (hidden)
        text "Base settings"
        slot #overview-shop-settings
        slot #overview-shop-link
      block #overview-shop-logo (hidden)
      text "Sales summary"
      button "Refresh"#divRefreshSalesSummary
      slot #overview-orders-summary
      tabs#overview-tabs: Sales #overview-tab-sales | Customers #overview-tab-customers
      tab pane#overview-tab-sales
        input text#divSearchOverviewOrders placeholder "Type text to search"
        button "Search" primary
        button #Grid_OverviewOrdersGrid_Options
        slot #overviewOrdersGridContainer
      tab pane#overview-tab-customers
        input text#divSearchOverviewCustomers placeholder "Type text to search"
        button "Search" primary
        button #Grid_OverviewCustomersGrid_Options
        slot #overviewCustomersGridContainer
tab pane#tab-shop-settings
  tabs: Setup #tab-shop-setup | Action required #tab-shop-auth (hidden) | Catalog #tab-shop-catalog | Activity log #tab-shop-log | Operations log #tab-shop-operationsLog
  text "Fulfillment by Amazon"
  text "Read the full information sheet about FBA and Cin7 Core integration."
  button "Read information sheet" primary
  button "Help" primary
  tab pane#tab-shop-setup
    heading "Setup"
    block #btnSaveSetupChanges
      button "Save changes" primary
    slot #setupValidation
    label "Price tier for downloaded products" for #FBA_Editor_PrimaryPriceTier
    slot #FBA_Editor_PrimaryPriceTier
    label "Create FBA fulfillment order with status" for #FBA_Editor_NewStatus
    slot #FBA_Editor_NewStatus
    label "Process fulfillment orders"
    input checkbox#FBA_Editor_ProcessManually
    label "Match product manually"
    input checkbox#FBA_Index_ManualMapping
    label "Create Cin7 Core product if it does not exist"
    input checkbox#FBA_Editor_CreateNewProduct
    label "Auto-sync with FBA" for #FBA_Editor_StocktakePeriod
    select#FBA_Editor_StocktakePeriod: Never | Every day | Every week | Every month
    block #FBA_Editor_StocktakePeriodBlock (hidden)
      label "Start date for auto-sync stock" for #FBA_Editor_StocktakePeriod
      block #FBA_Editor_StocktakePeriod_day (hidden)
        slot #FBA_Editor_StocktakePeriod_day_Ctrl
      block #FBA_Editor_StocktakePeriod_week (hidden)
        select#FBA_Editor_StocktakePeriod_week_Ctrl: Sunday | Monday | Tuesday | Wednesday | Thursday | Friday | Saturday
      block #FBA_Editor_StocktakePeriod_month (hidden)
        select#FBA_Editor_StocktakePeriod_month_Ctrl (31 options)
    label "Labels printing (limited options)" for #FBA_Editor_LabelsPrinting
    input checkbox#FBA_Editor_LabelsPrinting
    text "Company contact person for shipments"
    label "Name" for #txtContactName
    input text#txtContactName
    label "Email" for #txtContactEmail
    input text#txtContactEmail
    label "Phone" for #txtContactPhone
    input text#txtContactPhone
    text "Amazon MCF settings"
    text "Some eCommerce platforms and marketplaces have policies against Amazon-branded packaging or logistics for deliveries. Pl"
    slot #divChannelMapping
    text "Disconnect from Amazon FBA"
    block #divDisconnect
      form#frmDisconnect
      button "Disconnect from Amazon FBA store"
  tab pane#tab-shop-auth
    heading "Something went wrong"
    button "Update access token" primary
    button "Reactivate" primary
    text "To allow Cin7 Core access to your FBA store please update the access token or just re-activate the connection."
    form#frmRefreshToken
      label "New MWS token" for #FBA_Refresh_Token
      input text#FBA_Refresh_Token name=newToken
  tab pane#tab-shop-catalog
    heading "Catalog"
    input text#divSearchCatalog placeholder "Type text to search"
    button "Search" primary
    button "Refresh"#divRefreshCatalog
    button "Force sync"#divDownloadProducts
    button "Sync stock levels"#divSyncStockLevels
    button #Grid_CatalogGrid_Options
    slot #catalogGridContainer
  tab pane#tab-shop-inboundShipment
    heading "FBA inbound shipments"
    select#cmbInboundSHopmentFilterStatus: WORKING | SHIPPED | DELIVERED | CHECKED IN | IN TRANSIT | RECEIVING | CLOSED | CANCELED | DELETED | ERROR
    label "Status"
    slot #FBA_Index_InboundShipmentsFromDate
    label "Transfer order dates from" for #dtInboundShipmentsFromDate
    slot #FBA_Index_InboundShipmentsToDate
    label "To" for #dtInboundShipmentsToDate
    button "Clear filter"#divClearFilter
    input text#divSearchInboundShipments placeholder "Type text to search"
    button "Search" primary
    button "New stock transfer"#btnAddInboundShipments
    button "Refresh"#divRefreshInboundShipments
    button "Update"#divDownloadInboundShipments
    button "Print labels"#divPrintLabels (hidden)
    button #Grid_InboundShipmentsGrid_Options
    slot #InboundShipmentsGridContainer
  tab pane#tab-shop-log
    heading "Activity log"
    input text#divSearchActivityLog placeholder "Type text to search"
    button "Search" primary
    button "Refresh"#divRefreshLog
    button #Grid_LogGrid_Options
    slot #divLogLines
  tab pane#tab-shop-operationsLog
    heading "Operation log"
    input text#divSearchOperationsLog placeholder "Type text to search"
    button "Search" primary
    button "Refresh"#divRefreshOperationsLog
    button #Grid_OperationsLogGrid_Options
    slot #operationsLogGridContainer
tab pane#tab-add-new
  block #add-new-tabs
    tabs#overview-list: Use an existing Amazon connection #tab-add-new-amazon | Connect manually #tab-add-new-manual
  tab pane#tab-add-new-amazon
    heading "Use an existing Amazon connection"
    form#frmConnectViaAmazon
    block #ConnectToFBAAuto
      label "Use Amazon credentials from" for #tdAmazonConfiguration
      slot #tdAmazonConfiguration
    block #ConnectToFBAAuto2
      label "Location for FBA" for #tdLocationSelector1
      slot #tdLocationSelector1
    label ""
    button "Connect to FBA"#btnConnectStore primary
  tab pane#tab-add-new-manual
    heading "Connect manually"
    text "This integration requires an Amazon Seller Pro account. We recommend you turn off the Amazon Open listings report notifi"
    form#frmAuthorise
      label "Amazon merchant token (Seller ID)" for #FBA_Index_SellerID
      slot #FBA_Index_SellerID
      label "Marketplace ID" for #FBA_Index_MarketplaceID
      slot #FBA_Index_MarketplaceID
      label "Location for FBA warehouse" for #tdLocationSelector2
      slot #tdLocationSelector2
      label ""
      block #ConnectToFBAManual
        button "Connect to FBA" primary
modal#FBA_Index_Catalog medium
  heading "Link Amazon FBA product to Cin7 Core product"
  button "×"
  heading #FBA_Catalog_ProductName
  table
  table
  slot #tabUnlinked
  slot #tabLinked
  slot #tabBuild
  label "Do not link Amazon FBA product to any Cin7 Core product" + radio #rbtnUnlinked
  label "Link Amazon FBA product to the existing Cin7 Core product" + radio #rbtnLink
  label "Create a new Cin7 Core product using Amazon FBA product details" + radio #rbtnCreate
  tab pane#tabCatalogInfo
    heading "Amazon FBA product is not linked."
  tab pane#tabCatalogLink
    heading "Select Cin7 Core product to link with..."
    slot #FBA_CatalogManagment_LinkToProduct_FakeForREsize
    slot #FBA_CatalogManagment_LinkToProduct
    slot #linkedProductPreview
  tab pane#tabCatalogBuild
    heading "Create a new Cin7 Core product from Amazon FBA listing and link..."
    button "Build and link"#btnBuildProduct primary
    slot #foundProductPreview
  block #FBA_Catalog_AllActions
    button "Save"#FBA_Catalog_Update primary
    button "Close"
modal#FBA_DownloadProducts_Content medium
  heading "Update FBA inventory list"
  button "×"
  slot #FBA_DownloadProducts_ValidationContainer
  text "All not suppressed products from FBA will be preloaded. If there is a product with an identical SKU it will be linked, o"
  block #FBA_DownloadProducts_Actions
    button "Load from FBA" primary
    button "Close"
modal#FBA_DownloadInboundShipments_Content medium
  heading "Update inbound shipments from FBA"
  button "×"
  slot #FBA_DownloadInboundShipments_ValidationContainer
  text "All shipment with changed statuses in FBA will be updated in Cin7 Core."
  block #FBA_DownloadInboundShipments_Actions
    button "Load from FBA" primary
    button "Close"
modal#dlgFbaPrintLabels large
  heading "Print FBA shipment labels"
  button "×"
  text "Configure shipment labels for FBA inbound transfer order: . Status: (all settings are frozen until acceptance is voided)"
  heading "Shipping service"
  block #divShippingService
    heading "Shipping method"
    input radio#rbSPD name=rbShippingMethod
    label "Small parcel delivery (SPD)" for #rbSPD
    input radio#rbLTL name=rbShippingMethod
    label "Less than truckload" for #rbLTL
    heading "Shipping carrier"
    input radio#rbAPC name=rbCarrier
    label "Amazon-partnered carrier" for #rbAPC
    block #grpCarrier (hidden)
      input radio#rbUPS name=rbAPCCarrier
      label "UPS" for #rbUPS
      input radio#rbFedEx name=rbAPCCarrier
      label "FedEx" for #rbFedEx
    input radio#rbOC name=rbCarrier
    label "Other carrier" for #rbOC
    block #grpOtherCarrier (hidden)
      select#cmbShippingMode: Air | Ocean | Ground
      label "Shipping mode"
      select#cmbShippingCarrier
      label "Carrier"
      input text#txtTrackingNumber placeholder "Enter tracking number(s)"
      label "Tracking number(s)"
  heading "Shipment packing"
  block #divShipmentPacking
    select#cmbPackageMethod: Everything in one box | One SKU per box | More than one SKU per box | More than one SKU per box
    label "Preferred shipment package method"
    input text#txtBoxWeight
    label "Box weight (lbs)"
    input text#txtBoxesTotal
    label "Total numbers of boxes"
    input text#txtBoxW
    label "Width (in)"
    input text#txtBoxH
    label "Height (in)"
    input text#txtBoxD
    label "Depth (in)"
  button "Box content information"
  button "Pallet information"
  button "Shipping charges"
  button "Box labels"
  button "Print labels"
  block #divBoxContent
    block #divShipmentItems
      button  primary (hidden)
      input text#txtPrintLabelsSearchField placeholder "Type text to search"
      button "Search"#btnPrintLabelsSearch primary
      slot #gridShipmentItems
      button "Add more items" primary
    block #divUploadItems (hidden)
      text "Column headings in the template file must remain unchanged for the import to work properly. Please use CSV file upload f"
      text "Upload CSV file with packing information using downloadable template. Enter box number, product SKU, SKU qty per box, bo"
      input file#fileImportItems (hidden)
      button "Download CSV template"#btnDownloadItems
      button "Upload file"#btnUploadItems primary
      button "Remove"#btnRemoveItems (hidden)
      slot #divFileUploadingErrorsAlert (hidden)
      block #divFileUploadingErrorsGrid (hidden)
        slot #gridImportItemsErrors
  block #divPalletInformation (hidden)
    button  primary
    input text#txtPrintLabelsSearchPalletField placeholder "Type text to search"
    button "Search"#btnPrintLabelsPalletSearch primary
    slot #gridPallets
    button "Add more items" primary
  block #divShippingCharges (hidden)
    text "Click to calculate shipment costs after all required fields below have been filled in. Calculated shipping charges shoul"
    button "Calculate"#btnPrintLabelsCalculateCharges primary
    button "Accept"#btnPrintLabelsAcceptCharges primary (hidden)
    button "Void"#btnPrintLabelsVoidCharges (hidden)
    slot #gridShippingCharges
  block #divBoxLabels (hidden)
    text "Click to generate box labels after all required fields below have been filled in."
    button "Generate box labels"#btnPrintLabelsGenerateBoxLabels primary
    slot #gridShippingBoxLabels
  block #divPrintBoxLabels (hidden)
    text "Click to print shipment labels after all required fields below have been filled in."
    button "Print box labels"#btnPrintLabelsPrintBoxLabels primary
    slot #gridShippingPrintLabels
  button "Save as draft"#btnPrintLabelsSave primary
  button "Close"
```

## Components by bundle

What the page code builds and mounts into the layout's slots.

### `FBA2019`

13 grids · 11 standalone fields · 0 windows · 12 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `InboundShipmentsGridContainer` · store `fbaInboundShipmentItemStore` · placeholder `There are no inbound shipments.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Transfer order # | `TransferOrderID` |  | flex 1 | renderer() |  |
    | Order date | `ShipmentDate` | date column | flex 1 | renderer() |  |
    | From location | `LocationName` |  | flex 1 | RenderHTMLText |  |
    | Printed labels | `HasPrintedLabels` |  | flex 1 | renderer() |  |
    | FBA status | `ShipmentStatus` |  | flex 1 | renderer() |  |
    | Total SKU to ship | `TotalUnits` |  | flex 1 | RenderHTMLText |  |
    | Total | `TotalAmount` |  | flex 1 | DEARMoneyFormat |  |

- **grid** · renders into `operationsLogGridContainer` · store `operationsLogStore` · placeholder `No entries found. Please hit refresh or change the search criteria.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Date | `Date` | date column | 170 | renderer() |  |
    | Type | `Type` |  | 80 | renderer() |  |
    | User | `UserName` |  | flex 1 | renderer() |  |
    | Category | `Category` |  | 170 | renderer() |  |
    | Processed | `Processed` | check column | 80 | renderer() |  |
    | Description | `Description` |  | flex 3 | renderer() |  |

- **grid** · renders into `catalogGridContainer` · store `productStore` · placeholder `There are no products in the catalog.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | SKU | `SKU` |  | flex 2 | renderer() |  |
    | Name | `Name` |  | flex 4 | renderer() |  |
    | ASIN | `FFProductID` |  | 70 | renderer() | hidden |
    | Category | `AdditionalField9` |  | flex 2 | renderer() |  |
    | Price | `Price` |  | flex 1 | renderer() |  |
    | Quantities | `QuantityFulfillable` |  | flex 2 | renderer() |  |
    | Quantity | `Quantity` |  | 70 | renderer() |  |
    | Linked product | `ProductID` |  | flex 4 | renderer() |  |
    | Blank box eligibility | `IsEligibleForBlankBox` |  | 95 | renderer() |  |
    | Blank box stock qty | `QuantityBlankBox` |  | 105 | renderer() |  |

- **grid** · renders into `divLogLines` · store `LogStore` · placeholder `No usage history`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Date | `LogDate` |  | 130 | renderer() |  |
    | Information | `ChangesText` |  | flex 4 | renderer() |  |
    | Fulfillment order | `FulfillmentOrderId` |  | flex 1 | renderer() |  |
    | User | `ChangedBy` |  | flex 1 |  |  |

- **grid** · renders into `overviewOrdersGridContainer` · store `overviewOrdersStore` · placeholder `No fulfillment orders.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    |  | `Status` |  | 60 | renderer() |  |
    | Date | `Date` |  | 80 | renderer() |  |
    | Sale # | `SaleOrderNumber` |  | flex 1 |  |  |
    | Customer | `CustomerName` |  | flex 3 | RenderHTMLText |  |

- **grid** · renders into `overviewCustomersGridContainer` · store `overviewCustomersStore` · placeholder `No customers yet.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Customer | `CustomerName` |  | flex 3 | RenderHTMLText |  |
    | Fulfillment | `OrderCount` |  | flex 1 | RenderHTMLText |  |

- **grid** · renders into `divChannelMapping` · store `ChannelMappingStore` · placeholder `There are no Amazon MCF mappings.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Sales channel | `ChannelName` |  | flex 1 |  |  |
    | Box branding | `FulfillmentBoxSetting` |  | flex 1 | renderer() |  |
    | Logistics provider | `LogisticsProviderSetting` |  | flex 1 | renderer() |  |

- **grid** · renders into `this.$divGrid.attr(…)` · store `extendedLocalStore \| @this.store` · placeholder `No products have been selected yet.`
- **grid** · renders into `this.$divErrorsGrid.attr(…)` · store `store` · placeholder `Please upload a file to check for issues.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Line # | `Line` |  | 65 |  |  |
    | Box # | `BoxNumber` |  | flex 1 | RenderHTMLText |  |
    | SKU | `SKU` |  | flex 2 | RenderHTMLText |  |
    | Items per  box | `UnitsPerBox` |  | flex 1 | RenderHTMLText |  |
    | Weight of box (lbs) | `BoxWeight` |  | flex 1 | RenderHTMLText |  |
    | Box width (in) | `BoxWidth` |  | flex 1 | RenderHTMLText |  |
    | Box height ;(in) | `BoxHeight` |  | flex 1 | RenderHTMLText |  |
    | Box depth (in) | `BoxDepth` |  | flex 1 | RenderHTMLText |  |

- **grid** · renders into `this.$divGrid.attr(…)` · store `store` · placeholder `No pallets.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Transfer order # | `TransferOrderNumber` |  | flex 1 | renderer() |  |
    | Order date | `ShipmentDate` |  | flex 1 | renderer() |  |
    | Number of pallets | `NumberOfPallets` |  | flex 1 | RenderHTMLText |  |
    | Dimensions of pallet W·D·H (in) (group: Width, Depth, Height) | `` |  | flex 1 |  |  |
    | Weight (lbs) | `PalletWeight` |  | flex 1 | RenderHTMLText |  |
    | Stackable pallet | `IsStackable` | check column | flex 1 | renderer() |  |

- **grid** · renders into `this.$divGrid.attr(…)` · store `store` · placeholder `No shipping charges.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Freight ready date | `FreightReadyDate` | date column | flex 3 | renderer() · edit: date field | hidden |
    | Freight class | `FreightClass` |  | flex 2 | RenderHTMLText | hidden |
    | {Ext.String.format(…)} | `DeclaredValue` |  | flex 2 | DEARMoneyFormat | hidden |
    | Contact person | `ContactPerson` |  | flex 5 | RenderHTMLText | hidden |
    | Shipping carrier | `ShippingCarrier` |  | flex 2 | RenderHTMLText |  |
    | Number of boxes | `NumberOfBoxes` |  | flex 2 | RenderHTMLText |  |
    | Shipment weight (lbs) | `ShipmentWeight` |  | flex 2 | RenderHTMLText |  |
    | Billable weight (lbs) | `BillableWeight` |  | flex 2 | RenderHTMLText |  |
    | {Ext.String.format(…)} | `EstimatedShipmentCost` |  | flex 2 | DEARMoneyFormat |  |

- **grid** · renders into `this.$divGrid.attr(…)` · store `store` · placeholder `No box label parameters.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Boxes from | `FromBox` |  | flex 1 | RenderHTMLText | hidden |
    | Boxes to | `ToBox` |  | flex 1 | RenderHTMLText | hidden |
    | Total no. of boxes | `TotalOfBoxes` |  | flex 1 | RenderHTMLText | hidden |
    | Paper type | `PaperType` |  | flex 1 | renderer() |  |

- **grid** · renders into `this.$divGrid.attr(…)` · store `store` · placeholder `No box labels parameters.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Number of boxes | `NumberOfBoxes` |  | flex 1 | RenderHTMLText |  |
    | Paper type | `PaperType` |  | flex 1 | renderer() |  |
    | Paper size | `PaperSize` |  | flex 1 | renderer() |  |
    | Ship date | `ShipmentDate` | date column | flex 1 | renderer() · edit: date field |  |


#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| text field |  | `FBA_Index_SellerID` | `` |  |
| text field |  | `FBA_Index_MarketplaceID` | `` |  |
| combo |  | `tdLocationSelector1` | `vShortLocationStore` | shows `Description` · value `LocationID` · pick-only |
| combo |  | `tdLocationSelector2` | `vShortLocationStore` | shows `Description` · value `LocationID` · pick-only |
| combo |  | `tdAmazonConfiguration` | `AmazonConfStore` | shows `DisplayName` · value `ID` · placeholder `Choose Amazon store...` · pick-only |
| combo |  | `FBA_Editor_StocktakePeriod_day_Ctrl` | `vTimeStore` | shows `Name` · value `Value` · pick-only |
| combo |  | `FBA_Editor_NewStatus` | `NewStatusStore` | shows `description` · value `type` · pick-only |
| combo |  | `FBA_CatalogManagment_LinkToProduct` | `dearProductStore` | shows `Name` · value `ProductID` |
| combo |  | `FBA_Editor_PrimaryPriceTier` | `vSalesPriceTiersStore` | shows `Name` · value `Code` · placeholder `Choose...` · pick-only |
| date field |  | `FBA_Index_InboundShipmentsFromDate` | `` | placeholder `Choose date` · format `UserDateFormat` |
| date field |  | `FBA_Index_InboundShipmentsToDate` | `` | placeholder `Choose date` · format `UserDateFormat` |

#### Menus, buttons and other parts

- **tooltip** · renders into `Ext.getBody(…)`
- **column** “Box #” · field `BoxNumber`
- **column** “Product” · field `SKU`
- **column** “Asin” · field `ASIN`
- **column** “Transfer order #” · field `TransferOrderNumber`
- **column** “Order date” · field `ShipmentDate`
- **column** “Items per  box” · field `UnitsPerBox`
- **column** “No. Of boxes” · field `NumberOfBoxes`
- **column** “Box weight (lbs)” · field `BoxWeight`
- **column** “Box dimensions W·H·D (in)”
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Width | `BoxWidth` |  | flex 1 | RenderHTMLText |  |
    | Height | `BoxHeight` |  | flex 1 | RenderHTMLText |  |
    | Depth | `BoxDepth` |  | flex 1 | RenderHTMLText |  |

- **column** “Ship QTY” · field `QuantityInCase`
- **column** “{Ext.String.format(…)}” · field `ProductTotalPrice`

