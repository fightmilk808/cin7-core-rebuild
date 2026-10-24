# PayPal: UI

Every component the page code builds, read from the shipped ExtJS bundles: grids with their columns, fields, buttons, menus, windows and custom components. Labels are the English UI text. `renders into` is the id of the `<div>` in the page's server-rendered HTML that the component mounts in; `store` names the data store (see the endpoints in [README.md](README.md)); `on click` is the handler. Visual system and shell layout: [docs/UI.md](../../../docs/UI.md).

## Screens

| Route | Title | Bundles |
|---|---|---|
| `/PayPal` | PayPal | [`PayPal2019`](#paypal2019) |

## Components by bundle

### `PayPal2019`

2 grids · 8 standalone fields · 0 windows · 0 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `logsGridContainer` · store `self.logsStore` · placeholder `No log entries to display.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Payment date | `InitTime` | date column | flex 2 | renderer() |  |
    | Sale invoice | `SaleInvoiceNumber` |  | flex 1 | renderer() |  |
    | Amount | `Amount` |  | flex 1 | renderer() |  |
    | Account | `AccountCode` |  | flex 2 | renderer() |  |
    | PayPal payment ID | `PayPalPaymentId` |  | flex 3 |  |  |
    | Payment status | `StatusText` |  | flex 1 |  |  |

- **grid** · renders into `overviewDashboardGridContainer` · store `self.overviewDashboardStore` · placeholder `No payments to display.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Payment date | `InitTime` | date column | flex 1 | renderer() |  |
    | Sale invoice | `SaleInvoiceNumber` |  | flex 1 | renderer() |  |
    | Amount | `Amount` |  | flex 1 | renderer() |  |


#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| text field |  | `txtMerchantId` | `` |  |
| text field |  | `txtClientId` | `` |  |
| text field |  | `txtSecret` | `` |  |
| text field |  | `txtPayPalAccountType` | `` | disabled |
| text field |  | `txtTimeZone` | `` | disabled |
| combo |  | `cmbTargetAccount` | `accountStore` | shows `DisplayName` · value `Code` · pick-only |
| number field |  | `numTestPaymentAmount` | `` | required |
| combo |  | `cmbCurrency` | `currencyStore` | shows `Code` · value `Code` |

