# MRP: UI

Every component the page code builds, read from the shipped ExtJS bundles: grids with their columns, fields, buttons, menus, windows and custom components. Labels are the English UI text. `renders into` is the id of the `<div>` in the page's server-rendered HTML that the component mounts in; `store` names the data store (see the endpoints in [README.md](README.md)); `on click` is the handler. Visual system and shell layout: [docs/UI.md](../../docs/UI.md).

## Screens

| Route | Title | Bundles |
|---|---|---|
| `/MRP` | MRP run settings | [`ReportService`](#reportservice), [`MRPRunSettings`](#mrprunsettings) |
| `/MRPList` | MRP list | [`MRPList`](#mrplist) |
| `/MRPScheduler` | MRP Scheduler | [`MRPScheduler`](#mrpscheduler) |

## Components by bundle

### `MRPList`

1 grids · 0 standalone fields · 0 windows · 0 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `divMRPListGrid` · store `store` · placeholder `You do not have any MRP at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | MRP run | `Number` |  | flex 1 | RenderHTMLText |  |
    | Created by | `CreatedBy` |  | flex 1 | RenderHTMLText |  |
    | Date | `CreatedAt` | date column | flex 1 | renderer() |  |
    | Status | `Status` |  | flex 1 | renderer() |  |


### `MRPRunSettings`

7 grids · 5 standalone fields · 0 windows · 2 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `divForecastUploadingErrorsGrid` · store `store` · placeholder `Please upload a file to check for issues.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Line # | `Line` |  | 55 |  |  |
    | Demand | `DemandLocation` |  | flex 1 | RenderHTMLText |  |
    | SKU | `ProductSku` |  | flex 1 | RenderHTMLText |  |
    | Name | `ProductName` |  | flex 1 | RenderHTMLText |  |
    | Quantity | `Quantity` |  | 80 | RenderHTMLText |  |
    | Required by date | `RequiredByDate` | date column | 100 | renderer() |  |

- **grid** · renders into `divGridSplitProducts` · store `store` · placeholder `No products.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `ProductID` |  | flex 5 | renderer() |  |
    | Quantity | `Quantity` |  | flex 1 | RenderHTMLText |  |
    | UOM | `UnitOfMeasure` |  | flex 1 | RenderHTMLText |  |
    | Split | `IsSplitted` |  | flex 1 | renderer() |  |

- **grid** · renders into `"divGridProductsTask".concat(…)` · store `subStores[i]` · placeholder `No products.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `ProductCode` |  | flex 5 | renderer() |  |
    | Quantity | `Quantity` |  | flex 1 | RenderHTMLText |  |
    | UOM | `UnitOfMeasure` |  | flex 1 | RenderHTMLText |  |

- **grid** · renders into `divGridSupplyErrors` · store `store` · placeholder `No supply errors.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Error description | `Message` |  | flex 1 | renderer() |  |

- **grid** · renders into `divResultsId` · store `store` · placeholder `You have not created any supply orders at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Supply task | `TaskNumber` |  | flex 1 | renderer() |  |
    | Total QTY | `TotalQuantity` |  | 80 | RenderHTMLText |  |
    | Demand | `DemandLocationName` |  | flex 1 | RenderHTMLText |  |
    | Supply | `SupplyName` |  | flex 1 | RenderHTMLText |  |
    | Required by date | `RequiredByDate` | date column | flex 1 | renderer() |  |
    | Status | `TaskStatus` |  | flex 1 | RenderHTMLText |  |
    | Created by | `CreatedBy` |  | flex 1 | RenderHTMLText |  |
    | Created at | `CreatedAt` | date column | flex 1 | renderer() |  |
    |  | `` |  | 110 | renderer() |  |

- **grid** · renders into `divGridShowProducts` · store `productStore` · placeholder `No products.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `ProductID` |  | flex 5 | renderer() |  |
    | Quantity | `Quantity` |  | flex 1 | RenderHTMLText |  |
    | UOM | `UnitOfMeasure` |  | flex 1 | RenderHTMLText |  |
    | Split | `IsSplitted` |  | flex 1 | renderer() |  |

- **grid** · renders into `divGridActivityLog` · store `store` · placeholder `You do not have any activity at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Action | `Message` |  | flex 2 | RenderHTMLText |  |
    | Supply order | `TaskType` |  | 110 | RenderHTMLText |  |
    | Demand in | `DemandLocationName` |  | flex 1 | RenderHTMLText |  |
    | Supply from/buy from | `SupplyName` |  | flex 1 | RenderHTMLText |  |
    | User | `Username` |  | flex 1 | RenderHTMLText |  |
    | Date/time | `Date` | date column | flex 1 | renderer() |  |


#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| date field |  | `cmbPlanFrom` | `` | placeholder `Choose...` · format `UserDateFormat` |
| date field |  | `cmbPlanTo` | `` | placeholder `Choose...` · format `UserDateFormat` |
| combo |  | `cmbCustomer` | `customerListStore` | shows `Name` · value `CustomerID` · placeholder `Choose...` · multi-select |
| combo |  | `cmbLocation` | `locationListStore` | shows `Name` · value `ID` · placeholder `Choose...` · multi-select |
| combo |  | `renderToId` | `store` | shows `fieldName` · value `fieldValue` · placeholder `Choose...` · multi-select |

#### Menus, buttons and other parts

- **column** · renders into `divSuggestionsId` · store `suggestionStore` · placeholder `You do not have any supply orders at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    |  | `Expand` |  | 58 | renderer() |  |
    | Supply order | `SupplyTask` |  | flex 1 | renderer() |  |
    | Products | `` |  | flex 1 | renderer() |  |
    | Demand in | `DemandLocationName` |  | flex 1 | RenderHTMLText |  |
    | Supply from/buy from | `SupplyID` |  | flex 1 | renderer() |  |
    | Required by date | `RequiredByDate` | date column | flex 1 | renderer() · edit: date field |  |
    | Status | `TaskStatus` |  | flex 1 | renderer() |  |

- **action column** · id `actionColumn_validationstate`
  - **component** · on click `handler()`

### `MRPScheduler`

1 grids · 0 standalone fields · 0 windows · 1 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `divRelatedOrdersDetails` · store `RelatedOrdersStore` · placeholder `No related orders created.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Order | `TaskNumber` |  | flex 1 | renderer() |  |
    | Type | `TaskTypeName` |  | flex 1 | RenderHTMLText |  |
    | Order date | `OrderDate` |  | flex 1 | renderer() |  |
    | Status | `Status` |  | flex 1 | renderer() |  |
    | Total | `TotalAmount` |  | 130 | renderer() |  |


#### Menus, buttons and other parts

- **component**
  - *columns:*
    - **component** · name `text`
    - **component** · name `start_date`
    - **component** · name `duration`
    - **component** · name `add`

