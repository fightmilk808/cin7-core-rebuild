# Shippit: UI

Every component the page code builds, read from the shipped ExtJS bundles: grids with their columns, fields, buttons, menus, windows and custom components. Labels are the English UI text. `renders into` is the id of the `<div>` in the page's server-rendered HTML that the component mounts in; `store` names the data store (see the endpoints in [README.md](README.md)); `on click` is the handler. Visual system and shell layout: [docs/UI.md](../../../docs/UI.md).

## Screens

| Route | Title | Bundles |
|---|---|---|
| `/Shippit` | Shippit | [`Shippit2019`](#shippit2019) |

## Components by bundle

### `Shippit2019`

1 grids · 4 standalone fields · 0 windows · 2 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `divPackageTypesGrid` · store `UserPackagesStore` · placeholder `There are no pre-defined package types...`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Package type name | `name` |  | flex 3 |  |  |
    | {Ext.String.format \| Weight(…)} | `Weight` |  | flex 1 |  |  |
    | {Ext.String.format \| Width(…)} | `Width` |  | flex 1 |  |  |
    | {Ext.String.format \| Height(…)} | `Height` |  | flex 1 |  |  |
    | {Ext.String.format \| Length(…)} | `Length` |  | flex 1 |  |  |


#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| text field |  | `Shippit_Index_ApiKey` | `` |  |
| checkbox |  | `Shippit_Index_Sandbox` | `` |  |
| combo |  | `Shippit_ShipServ_Currency` | `CurrencyStore` | shows `Code` · value `Code` |
| combo |  | `Shippit_ShipServ_TaxRule` | `TaxStore` | shows `Description` · value `RuleID` |

#### Menus, buttons and other parts

- **UserPackage** · name `item.name` · id `guid(…)`
- **component** · renders into `Shippit_ShipServ_MarginValue` · required

