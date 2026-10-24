# Airwallex: UI

Every component the page code builds, read from the shipped ExtJS bundles: grids with their columns, fields, buttons, menus, windows and custom components. Labels are the English UI text. `renders into` is the id of the `<div>` in the page's server-rendered HTML that the component mounts in; `store` names the data store (see the endpoints in [README.md](README.md)); `on click` is the handler. Visual system and shell layout: [docs/UI.md](../../../docs/UI.md).

## Screens

| Route | Title | Bundles |
|---|---|---|
| `/Airwallex` | Airwallex | [`Airwallex2019`](#airwallex2019) |

## Layout

Each screen's server-rendered HTML inside the shell, as an outline: headings, tabs, sections, labels, inputs (`#id`), buttons (`▾` = dropdown), menus, tables and `slot`s (empty `<div>`s the components below mount into). `(hidden)` parts are shown by the page code when needed. Read with GET from a signed-in session; no values are kept.

### `/Airwallex`: Airwallex

Frame: `task-upload-frame`.

```text
link "Home"
link "Integrations"
button "Help"
heading "Airwallex"
tab pane#about
  heading "Airwallex"
  text "Instantly pay supplier invoices from Cin7 Core."
  heading "How it works"
  text "Airwallex allows you to pay supplier invoices from Cin7 Core. Those payments will sync directly from Airwallex to Xero f"
  text "Before paying a supplier invoice with Airwallex, you must:"
  link "Sign up for Airwallex"
  link "{email}"
  link "Integrate Xero with Cin7 Core."
  text "Then, to make a payment:"
  text "Log in to Cin7 Core."
  text "From the Purchase menu, open Purchases."
  text "Open the supplier invoice to pay."
  text "Open the Invoice tab."
  text "Select Pay with Airwallex–if this option is unavailable, the supplier invoice hasn′t been synced to Xero. Sync it and tr"
  text "You′ll be taken to Airwallex′s Bill Pay. For help paying your supplier invoice, follow Airwallex′s guide to paying bills"
  text "For more information about your Airwallex integration, visit the Cin7 Core Help Center. This integration is not availabl"
```

