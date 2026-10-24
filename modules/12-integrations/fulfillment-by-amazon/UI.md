# Fulfillment by Amazon: UI

Every component the page code builds, read from the shipped ExtJS bundles: grids with their columns, fields, buttons, menus, windows and custom components. Labels are the English UI text. `renders into` is the id of the `<div>` in the page's server-rendered HTML that the component mounts in; `store` names the data store (see the endpoints in [README.md](README.md)); `on click` is the handler. Visual system and shell layout: [docs/UI.md](../../../docs/UI.md).

## Screens

| Route | Title | Bundles |
|---|---|---|
| `/FBA` | Fulfillment by Amazon | [`FBA2019`](#fba2019) |

## Components by bundle

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

