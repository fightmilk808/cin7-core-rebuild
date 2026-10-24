# Lokad: UI

Every component the page code builds, read from the shipped ExtJS bundles: grids with their columns, fields, buttons, menus, windows and custom components. Labels are the English UI text. `renders into` is the id of the `<div>` in the page's server-rendered HTML that the component mounts in; `store` names the data store (see the endpoints in [README.md](README.md)); `on click` is the handler. Visual system and shell layout: [docs/UI.md](../../../docs/UI.md).

## Screens

| Route | Title | Bundles |
|---|---|---|
| `/Lokad` | Lokad | [`Lokad2019`](#lokad2019) |

## Components by bundle

### `Lokad2019`

0 grids · 3 standalone fields · 0 windows · 0 menus, buttons and other parts · 0 custom components

#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| combo |  | `Lokad_Editor_PrimaryPriceTier` | `vSalesPriceTiersStore` | shows `Name` · value `Code` · placeholder `Choose...` · pick-only |
| date field |  | `Lokad_Index_DateFrom` | `` | placeholder `Choose...` · format `UserDateFormat` |
| date field |  | `Lokad_Index_DateTo` | `` | placeholder `Choose...` · format `UserDateFormat` |

