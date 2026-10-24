# Zapier: UI

Every component the page code builds, read from the shipped ExtJS bundles: grids with their columns, fields, buttons, menus, windows and custom components. Labels are the English UI text. `renders into` is the id of the `<div>` in the page's server-rendered HTML that the component mounts in; `store` names the data store (see the endpoints in [README.md](README.md)); `on click` is the handler. Visual system and shell layout: [docs/UI.md](../../../docs/UI.md).

## Screens

| Route | Title | Bundles |
|---|---|---|
| `/Zapier` | Zapier ~ |  |

## Layout

Each screen's server-rendered HTML inside the shell, as an outline: headings, tabs, sections, labels, inputs (`#id`), buttons (`▾` = dropdown), menus, tables and `slot`s (empty `<div>`s the components below mount into). `(hidden)` parts are shown by the page code when needed. Read with GET from a signed-in session; no values are kept.

### `/Zapier`: Zapier

Frame: `task-upload-frame`.

```text
link "Home"
link "Integrations"
heading "Connect Cin7 Core Inventory to hundreds of other apps with Zapier."
link "Zapier"
heading "Before you start"
link "Cin7 Core subscription"
heading "How do I connect Cin7 Core Inventory to Zapier?"
link "article"
link "Zapier account"
heading "Need inspiration?"
link "Cin7 Core Inventory and Zapier"
heading "Getting started with Zapier"
link "Zapier"
```

