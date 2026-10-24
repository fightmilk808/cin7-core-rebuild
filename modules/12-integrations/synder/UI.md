# Synder: UI

Every component the page code builds, read from the shipped ExtJS bundles: grids with their columns, fields, buttons, menus, windows and custom components. Labels are the English UI text. `renders into` is the id of the `<div>` in the page's server-rendered HTML that the component mounts in; `store` names the data store (see the endpoints in [README.md](README.md)); `on click` is the handler. Visual system and shell layout: [docs/UI.md](../../../docs/UI.md).

## Screens

| Route | Title | Bundles |
|---|---|---|
| `/Synder` | Synder ~ |  |

## Layout

Each screen's server-rendered HTML inside the shell, as an outline: headings, tabs, sections, labels, inputs (`#id`), buttons (`▾` = dropdown), menus, tables and `slot`s (empty `<div>`s the components below mount into). `(hidden)` parts are shown by the page code when needed. Read with GET from a signed-in session; no values are kept.

### `/Synder`: Synder

Frame: `task-upload-frame`.

```text
link "Home"
link "Integrations"
button "Back to list"#backAction
heading "Synder"
tabs#settingsTabs: How integration works #start
tab pane#start
  heading "Synder"
  text "Connect sales platforms (like Shopify, Stripe, Amazon or Etsy), payment processors, and your accounting systems, reconci"
  heading "How it works"
  text "Synder returns reconciliation information to Cin7 Core, so you have a clear view of which sales and transactions have be"
  text "Before you can mark transactions as reconciled, you must:"
  text "Connect QuickBooks Online as your accounting integration in Cin7 Core."
  link "Consolidate transactions for QuickBooks Online"
  text "Sign up with Synder. Once signed up, the Synder team will need your organization details so they can activate reconcilia"
  link "Synder's video instructions here"
  text "Then, to mark transactions as reconciled by Synder in Cin7 Core:"
  text "For more information about your Synder integration, visit the Cin7 Core Help Center. This integration is not available f"
```

