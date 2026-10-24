# PayPal: UI

Every component the page code builds, read from the shipped ExtJS bundles: grids with their columns, fields, buttons, menus, windows and custom components. Labels are the English UI text. `renders into` is the id of the `<div>` in the page's server-rendered HTML that the component mounts in; `store` names the data store (see the endpoints in [README.md](README.md)); `on click` is the handler. Visual system and shell layout: [docs/UI.md](../../../docs/UI.md).

## Screens

| Route | Title | Bundles |
|---|---|---|
| `/PayPal` | PayPal | [`PayPal2019`](#paypal2019) |

## Layout

Each screen's server-rendered HTML inside the shell, as an outline: headings, tabs, sections, labels, inputs (`#id`), buttons (`▾` = dropdown), menus, tables and `slot`s (empty `<div>`s the components below mount into). `(hidden)` parts are shown by the page code when needed. Read with GET from a signed-in session; no values are kept.

### `/PayPal`: PayPal

Frame: `task-upload-frame`.

```text
link "Home"
link "Integrations"
tabs#main-tabs: Notice #tab_notice | Overview #tab_overview | Setup #tab-portal-setup | Log #tab-portal-log | Help #tab-portal-help
tab pane#tab_notice
  heading "Notice"
  link "Cin7 Pay"
tab pane#tab_overview
  heading "Overview"
  text "Sales summary"
  button "Refresh"#divRefreshSalesSummary
  slot #overview-sales-summary
  input text#divSearchOverviewGrid placeholder "Type text to search"
  button "Search" primary
  button #divRefreshOverview
  button #Grid_gridName_Options
  slot #overviewDashboardGridContainer
tab pane#tab-portal-setup
  heading "Setup"
  block #sandboxWarningMessage
    text "You are connected to PayPal Sandbox. It can only be used for testing the integration, no real money will be deposited to"
  label "PayPal merchant ID" for #txtMerchantId
  slot #txtMerchantId
  label "PayPal API client ID" for #txtClientId
  slot #txtClientId
  label "PayPal API secret" for #txtSecret
  slot #txtSecret
  link "Cin7 Pay"
  label "PayPal account type" for #txtPayPalAccountType
  slot #txtPayPalAccountType
  button "Connect to PayPal" primary
  button "Disconnect from PayPal"
  label "Payment account" for #cmbTargetAccount
  slot #cmbTargetAccount
  label "Time zone" for #txtTimeZone
  slot #txtTimeZone
  link "Change"
  button "Save settings" primary
  label "Test payment amount" for #numTestPaymentAmount
  slot #numTestPaymentAmount
  label "Payment currency" for #cmbCurrency
  slot #cmbCurrency
  button "Test payment"#btnTestPayment primary
tab pane#tab-portal-log
  heading "Log"
  input text#divSearchLog placeholder "Type text to search"
  button "Search" primary
  button #divRefreshLog
  button #Grid_logEntriesGrid_Options
  slot #logsGridContainer
tab pane#tab-portal-help
  heading "Help"
  link "Profile page"
  link "Dashboard->Applications->Create app"
  link "this invoice template"
  button "Read information sheet" primary
  modal#merchantIdHelpDialog medium
    heading "Merchant ID field help"
    button "×"
    heading "Step 1. Open the PayPal Business Account profile page."
    heading "Step 2. Copy the Merchant ID to the clipboard and then paste it to the "Merchant"
    button "<Prev step" primary
    button "Next step >" primary
    button "Close"
  modal#credentialsHelpDialog medium
    heading "REST API credentials help"
    button "×"
    heading "Step 1."
    link "https://developer.paypal.com/developer/applications/create"
    heading "Step 2."
    button "<Prev step" primary
    button "Next step >" primary
    button "Close"
```

## Components by bundle

What the page code builds and mounts into the layout's slots.

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

