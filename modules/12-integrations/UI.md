# Integrations: UI

Every component the page code builds, read from the shipped ExtJS bundles: grids with their columns, fields, buttons, menus, windows and custom components. Labels are the English UI text. `renders into` is the id of the `<div>` in the page's server-rendered HTML that the component mounts in; `store` names the data store (see the endpoints in [README.md](README.md)); `on click` is the handler. Visual system and shell layout: [docs/UI.md](../../docs/UI.md).

## Screens

| Route | Title | Bundles |
|---|---|---|
| `/Integrations` | Integrations | [`IntegrationList2019`](#integrationlist2019) |

## Layout

Each screen's server-rendered HTML inside the shell, as an outline: headings, tabs, sections, labels, inputs (`#id`), buttons (`▾` = dropdown), menus, tables and `slot`s (empty `<div>`s the components below mount into). `(hidden)` parts are shown by the page code when needed. Read with GET from a signed-in session; no values are kept.

### `/Integrations`: Integrations

Frame: `task-upload-frame`.

```text
link "Home"
heading "Integrations"
tabs#IntegrationTabs: 
input text#txtSearch placeholder "Type text to search..."
tab pane#tab-content
  block #noFound (hidden)
  block #IntegrationItems
    block #Integrations_Xero
    block #Integrations_QBO
    block #bigCommerceIntegration
    block #WalmartIntegration
```

