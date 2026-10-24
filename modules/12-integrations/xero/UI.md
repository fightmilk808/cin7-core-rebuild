# Xero: UI

Every component the page code builds, read from the shipped ExtJS bundles: grids with their columns, fields, buttons, menus, windows and custom components. Labels are the English UI text. `renders into` is the id of the `<div>` in the page's server-rendered HTML that the component mounts in; `store` names the data store (see the endpoints in [README.md](README.md)); `on click` is the handler. Visual system and shell layout: [docs/UI.md](../../../docs/UI.md).

## Screens

| Route | Title | Bundles |
|---|---|---|
| `/Xero` | Xero | [`Xero2019`](#xero2019) |

## Layout

Each screen's server-rendered HTML inside the shell, as an outline: headings, tabs, sections, labels, inputs (`#id`), buttons (`▾` = dropdown), menus, tables and `slot`s (empty `<div>`s the components below mount into). `(hidden)` parts are shown by the page code when needed. Read with GET from a signed-in session; no values are kept.

### `/Xero`: Xero

Redirects to `/Xero/NotConnected`.

Frame: `task-upload-frame`.

```text
link "Home"
link "Integrations"
heading "Integration settings"
tabs#settingsTabs: How the integration works #about | General settings #configuration | Sync options #sync_options | Advanced settings #settings
tab pane#about
  heading "Xero is not connected"
  heading "How the integration works"
  text "You can sync data in both directions."
  text "Chart of accounts"
  text "Changes in the chart of accounts in Xero are synced to Cin7 Core. Chart of accounts is read-only in Cin7 Core."
  text "Tax rules"
  text "Changes in tax rules in Xero are synced to Cin7 Core. Tax rules are read-only in Cin7 Core."
  text "Customers and suppliers"
  text "Suppliers and customers in Cin7 Core are exported to Xero contacts. When invoice download is enabled, contacts associate"
  text "Products"
  text "Products created and updated in Cin7 Core are exported as Xero items. New and updated items in Xero are optionally downl"
  text "Xero inventory tracking is not compatible with Cin7 Core; this feature must be turned off."
  text "Invoices"
  text "Invoices authorized in Cin7 Core are exported to Xero. Invoices authorized in Xero are optionally downloaded to Cin7 Cor"
  text "Credit notes"
  text "Credit notes authorized in Cin7 Core are exported to Xero, but won't be allocated against invoices. Credit notes created"
  text "Payments and refunds"
  text "Payments and refunds may be synced in either or both directions. Payments and refunds require an authorized invoice or c"
  text "Prepayments"
  text "Prepayments are exported to Xero and are allocated against related invoices on authorization."
  text "Overpayments"
  text "Overpayments are not synced with Xero."
  text "Manual journals"
  text "Cin7 Core creates manual journals in Xero to reflect COGS, assembly, disassembly, stock adjustment, and purchase and sal"
  text "Category tracking"
  text "Map Xero tracking categories to Cin7 Core entities to add tracking information to invoices, credit notes, and journals e"
modal#dlgConfirmationNotUsingDearUaeSpecificFinancialFeature small
  heading "Confirm not utilizing Cin7 Core UAE specific financial features"
  button "×"
  slot #dlgConfirmationNotUsingDearUaeSpecificFinancialFeatureMessage
  button "Yes"#btnConfirmationNotUsingDearUaeSpecificFinancialFeature primary
  button "No"
```

