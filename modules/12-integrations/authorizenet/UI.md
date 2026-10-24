# AuthorizeNet: UI

Every component the page code builds, read from the shipped ExtJS bundles: grids with their columns, fields, buttons, menus, windows and custom components. Labels are the English UI text. `renders into` is the id of the `<div>` in the page's server-rendered HTML that the component mounts in; `store` names the data store (see the endpoints in [README.md](README.md)); `on click` is the handler. Visual system and shell layout: [docs/UI.md](../../../docs/UI.md).

## Screens

| Route | Title | Bundles |
|---|---|---|
| `/AuthorizeNet` | AuthorizeNet | [`AuthorizeNet2019`](#authorizenet2019) |

## Layout

Each screen's server-rendered HTML inside the shell, as an outline: headings, tabs, sections, labels, inputs (`#id`), buttons (`▾` = dropdown), menus, tables and `slot`s (empty `<div>`s the components below mount into). `(hidden)` parts are shown by the page code when needed. Read with GET from a signed-in session; no values are kept.

### `/AuthorizeNet`: AuthorizeNet

Frame: `task-upload-frame`.

```text
link "Home"
link "Integrations"
button "Back to list"#backAction
tabs#portal-main-tab: Overview #tab_overview | Setup #tab-portal-setup | Log #tab-portal-log | Help #tab-portal-help
tab pane#tab_overview
  heading "Overview"
  text "Sales summary"
  button "Refresh"#divRefreshSalesSummary
  slot #overview-sales-summary
  input text#divSearchOverviewGrid placeholder "Type text to search"
  button "Search" primary
  button #divRefreshOverview
  button #overviewDashboardGrid_Options
  slot #overviewDashboardGridContainer
tab pane#tab-portal-setup
  heading "Setup"
  slot #setupValidation
  block #divAuthorizeNetAccountName (hidden)
    label "Authorize.net account name"
    slot #txtAuthorizeNetAccountName
  block #divConnect (hidden)
    label ""
    block #connectDiv
  block #divDisconnect (hidden)
    label ""
  block #divConnectForm (hidden)
    form
      label "Authorization code"
      input text#code
      button "Submit connection" primary
  block #divAccountSettings (hidden)
    label "Payment account"
    slot #cmbTargetAccount
    label "Time zone"
    slot #txtTimeZone
    link "Change"
    label "Ask for billing information"
    input checkbox#chkBillingRequiredInLive
    label ""
    block #btnSaveSetupChanges
      button "Save settings" primary
tab pane#tab-portal-log
  heading "Log"
  input text#divSearchLog placeholder "Type text to search"
  button "Search" primary
  button #divRefreshLog
  button #Grid_logEntriesGrid_Options
  slot #logsGridContainer
tab pane#tab-portal-help
  heading "Help"
  link "this invoice template"
```

## Components by bundle

What the page code builds and mounts into the layout's slots.

### `AuthorizeNet2019`

2 grids · 3 standalone fields · 0 windows · 0 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `logsGridContainer` · store `window.logsStore` · placeholder `No log entries to display.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Payment date | `InitTime` | date column | flex 2 | renderer() |  |
    | Sale invoice | `` |  | flex 1 | renderer() |  |
    | Amount | `` |  | flex 1 | renderer() |  |
    | Account | `` |  | flex 2 | renderer() |  |
    | AuthorizeNet payment ID | `AuthorizeNetPaymentId` |  | flex 3 |  |  |
    | Payment status | `StatusText` |  | flex 1 |  |  |

- **grid** · renders into `overviewDashboardGridContainer` · store `window.overviewDashboardStore` · placeholder `No payments to display.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Payment date | `InitTime` | date column | flex 1 | renderer() |  |
    | Sale invoice | `` |  | flex 1 | renderer() |  |
    | Amount | `` |  | flex 1 | renderer() |  |


#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| text field |  | `txtAuthorizeNetAccountName` | `` |  |
| text field |  | `txtTimeZone` | `` |  |
| combo |  | `cmbTargetAccount` | `accountStore` | shows `DisplayName` · value `Code` · pick-only |

