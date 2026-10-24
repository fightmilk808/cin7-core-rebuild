# Shiptheory: UI

Every component the page code builds, read from the shipped ExtJS bundles: grids with their columns, fields, buttons, menus, windows and custom components. Labels are the English UI text. `renders into` is the id of the `<div>` in the page's server-rendered HTML that the component mounts in; `store` names the data store (see the endpoints in [README.md](README.md)); `on click` is the handler. Visual system and shell layout: [docs/UI.md](../../../docs/UI.md).

## Screens

| Route | Title | Bundles |
|---|---|---|
| `/Shiptheory` | Shiptheory | [`Shiptheory2019`](#shiptheory2019) |

## Components by bundle

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

