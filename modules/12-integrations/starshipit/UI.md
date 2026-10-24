# StarShipIT: UI

Every component the page code builds, read from the shipped ExtJS bundles: grids with their columns, fields, buttons, menus, windows and custom components. Labels are the English UI text. `renders into` is the id of the `<div>` in the page's server-rendered HTML that the component mounts in; `store` names the data store (see the endpoints in [README.md](README.md)); `on click` is the handler. Visual system and shell layout: [docs/UI.md](../../../docs/UI.md).

## Screens

| Route | Title | Bundles |
|---|---|---|
| `/StarShipIt` | StarShipIT | [`StarShipIt2019`](#starshipit2019) |

## Components by bundle

### `StarShipIt2019`

1 grids · 8 standalone fields · 0 windows · 2 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `divPackageTypesGrid` · store `UserPackagesStore` · placeholder `There are no pre-defined package types...`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Package type name | `name` |  | flex 3 |  |  |
    | {Ext.String.format(…)} | `Weight` |  | flex 1 |  |  |
    | {Ext.String.format(…)} | `Width` |  | flex 1 |  |  |
    | {Ext.String.format(…)} | `Height` |  | flex 1 |  |  |
    | {Ext.String.format(…)} | `Length` |  | flex 1 |  |  |


#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| combo |  | `StarShipIt_ShipServ_CustomerTax` | `UseCustomerTaxStore` | shows `Name` · value `Code` |
| combo |  | `StarShipIt_ShipServ_Margin` | `MarginTaxStore` | shows `Name` · value `Code` |
| text field |  | `StarShipIt_Index_ApiKey` | `` |  |
| combo |  | `StarShipIt_ShipServ_WeightUnits` | `WeightUnitStore` | shows `Name` · value `Code` |
| combo |  | `StarShipIt_ShipServ_DimensionUnits` | `DimUnitStore` | shows `Name` · value `Code` |
| combo |  | `SendNotificationOnLabelGeneration` | `SendNotificationOnLabelGenerationStore` | shows `Name` · value `Code` |
| combo |  | `StarShipIt_ShipServ_Currency` | `CurrencyStore` | shows `Code` · value `Code` |
| combo |  | `StarShipIt_ShipServ_TaxRule` | `TaxStore` | shows `Description` · value `RuleID` |

#### Menus, buttons and other parts

- **UserPackage** · name `item.name` · id `guid(…)`
- **component** · renders into `StarShipIt_ShipServ_MarginValue` · required

