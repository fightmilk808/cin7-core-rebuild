# QuickBooks: UI

Every component the page code builds, read from the shipped ExtJS bundles: grids with their columns, fields, buttons, menus, windows and custom components. Labels are the English UI text. `renders into` is the id of the `<div>` in the page's server-rendered HTML that the component mounts in; `store` names the data store (see the endpoints in [README.md](README.md)); `on click` is the handler. Visual system and shell layout: [docs/UI.md](../../../docs/UI.md).

## Screens

| Route | Title | Bundles |
|---|---|---|
| `/Quickbooks` | QuickBooks | [`Quickbooks2019`](#quickbooks2019) |

## Components by bundle

### `Quickbooks2019`

2 grids · 13 standalone fields · 0 windows · 0 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `JournalsSearchResultGrid` · store `journalsSearchResultStore` · placeholder `Nothing found.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Void | `Selected` | check column | flex 3 | renderer() |  |
    | QBO ID | `QBOID` |  | flex 3 | renderer() |  |
    | Document number | `DocNumber` |  | flex 3 | renderer() |  |
    | Date | `Date` |  | flex 3 | renderer() |  |

- **grid** · renders into `divConsolidationChannelTypes` · store `ConsolidationChannelTypesStore` · placeholder `No sales channels`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | SALES CHANNEL | `SaleChannel` |  | flex 1 | renderer() |  |
    | INVOICE SYNC TYPE | `InvoiceSyncType` |  | flex 1 | renderer() |  |
    | COGS SYNC TYPE | `COGSSyncType` |  | flex 1 | renderer() |  |


#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| combo |  | `divQuickBooks_Customer` | `ConsolidateCustomerStore` | shows `name` · value `value` · placeholder `type or choose...` |
| date field |  | `tdQuickbooksInventoryStartDate` | `` | placeholder `Choose...` · format `UserDateFormat` |
| date field |  | `tdFrom` | `` | placeholder `Choose...` · format `UserDateFormat` |
| date field |  | `tdTo` | `` | placeholder `Choose...` · format `UserDateFormat` |
| date field |  | `tdSaleOverpaymentsSearchFrom` | `` | placeholder `Choose...` · format `UserDateFormat` |
| date field |  | `tdSaleOverpaymentsSearchTo` | `` | placeholder `Choose...` · format `UserDateFormat` |
| date field |  | `tdJournalsSearchFrom` | `` | placeholder `Choose...` · format `UserDateFormat` |
| date field |  | `tdJournalsSearchTo` | `` | placeholder `Choose...` · format `UserDateFormat` |
| date field |  | `tdQuickbooksAutosynchronizationStartDate` | `` | placeholder `Choose...` · format `UserDateFormat` |
| combo |  | `tdQuickbooksAutosynchronizationMailingList` | `MailingListStore` | shows `Name` · value `MailingListID` · placeholder `type or choose...` |
| date field |  | `ExportHistoricalDataDialog_StartDate` | `` | placeholder `Choose...` · format `UserDateFormat` |
| combo |  | `cmbQboWizardSohLocation` | `window.LocationStore` | shows `Description` · value `LocationID` · placeholder `Choose...` |
| combo |  | `cmbQboWizardSohLocation` | `window.LocationStore` | shows `Description` · value `LocationID` · placeholder `Choose...` |

