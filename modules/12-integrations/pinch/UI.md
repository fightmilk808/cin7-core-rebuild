# Pinch: UI

Every component the page code builds, read from the shipped ExtJS bundles: grids with their columns, fields, buttons, menus, windows and custom components. Labels are the English UI text. `renders into` is the id of the `<div>` in the page's server-rendered HTML that the component mounts in; `store` names the data store (see the endpoints in [README.md](README.md)); `on click` is the handler. Visual system and shell layout: [docs/UI.md](../../../docs/UI.md).

## Screens

| Route | Title | Bundles |
|---|---|---|
| `/Pinch` | Pinch | [`Pinch`](#pinch) |

## Components by bundle

### `Pinch`

2 grids · 8 standalone fields · 0 windows · 0 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `logsGridContainer` · store `window.logsStore` · placeholder `No log entries to display.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Payment date | `Created` | date column | flex 2 | renderer() |  |
    | Sale invoice | `` |  | flex 1 | renderer() |  |
    | Amount | `` |  | flex 1 | renderer() |  |
    | Account | `` |  | flex 2 | renderer() |  |
    | Pinch payment ID | `TransID` |  | flex 3 |  |  |
    | Payment status | `PaymentStatus` |  | flex 1 |  |  |

- **grid** · renders into `overviewDashboardGridContainer` · store `window.overviewDashboardStore` · placeholder `No payments to display.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Payment date | `Created` | date column | flex 1 | renderer() |  |
    | Sale invoice | `` |  | flex 1 | renderer() |  |
    | Amount | `` |  | flex 1 | renderer() |  |


#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| text field |  | `txtPinchAccountName` | `` |  |
| text field |  | `txtTimeZone` | `` |  |
| combo |  | `cmbTargetAccount` | `accountStore` | shows `DisplayName` · value `Code` · pick-only |
| combo |  | `cmbPaymentCurrency` | `currenciesStore` | shows `CurrencyCode` · value `CurrencyCode` · pick-only |
| text field |  | `ccNumber` | `` |  |
| combo |  | `ccExpiryDateMonth` | `monthStore` | shows `value` · value `value` · placeholder `Month` |
| combo |  | `ccExpiryDateYear` | `yearStore` | shows `value` · value `value` · placeholder `Year` |
| text field |  | `ccCVV` | `` |  |

