# Lokad: UI

Every component the page code builds, read from the shipped ExtJS bundles: grids with their columns, fields, buttons, menus, windows and custom components. Labels are the English UI text. `renders into` is the id of the `<div>` in the page's server-rendered HTML that the component mounts in; `store` names the data store (see the endpoints in [README.md](README.md)); `on click` is the handler. Visual system and shell layout: [docs/UI.md](../../../docs/UI.md).

## Screens

| Route | Title | Bundles |
|---|---|---|
| `/Lokad` | Lokad | [`Lokad2019`](#lokad2019) |

## Layout

Each screen's server-rendered HTML inside the shell, as an outline: headings, tabs, sections, labels, inputs (`#id`), buttons (`▾` = dropdown), menus, tables and `slot`s (empty `<div>`s the components below mount into). `(hidden)` parts are shown by the page code when needed. Read with GET from a signed-in session; no values are kept.

### `/Lokad`: Lokad

Frame: `task-upload-frame`.

```text
block #LokadPage
  link "Home"
  link "Integrations"
  tabs#portal-main-tab: Export #tab-setup |  #tab-portal-help (hidden)
  button "Help"
  tab pane#tab-setup
    heading "Lokad"
    label "Date from" for #Lokad_Index_DateFrom
    slot #Lokad_Index_DateFrom
    label "Date to" for #Lokad_Index_DateTo
    slot #Lokad_Index_DateTo
    label "Sale price tier" for #Lokad_Editor_PrimaryPriceTier
    slot #Lokad_Editor_PrimaryPriceTier
    block #lokadGetFiles
      button "Export" primary
    form#frmGetItems
  tab pane#tab-portal-help
    heading "Help"
```

## Components by bundle

What the page code builds and mounts into the layout's slots.

### `Lokad2019`

0 grids · 3 standalone fields · 0 windows · 0 menus, buttons and other parts · 0 custom components

#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| combo |  | `Lokad_Editor_PrimaryPriceTier` | `vSalesPriceTiersStore` | shows `Name` · value `Code` · placeholder `Choose...` · pick-only |
| date field |  | `Lokad_Index_DateFrom` | `` | placeholder `Choose...` · format `UserDateFormat` |
| date field |  | `Lokad_Index_DateTo` | `` | placeholder `Choose...` · format `UserDateFormat` |

