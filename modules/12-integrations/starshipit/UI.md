# StarShipIT: UI

Every component the page code builds, read from the shipped ExtJS bundles: grids with their columns, fields, buttons, menus, windows and custom components. Labels are the English UI text. `renders into` is the id of the `<div>` in the page's server-rendered HTML that the component mounts in; `store` names the data store (see the endpoints in [README.md](README.md)); `on click` is the handler. Visual system and shell layout: [docs/UI.md](../../../docs/UI.md).

## Screens

| Route | Title | Bundles |
|---|---|---|
| `/StarShipIt` | StarShipIT | [`StarShipIt2019`](#starshipit2019) |

## Layout

Each screen's server-rendered HTML inside the shell, as an outline: headings, tabs, sections, labels, inputs (`#id`), buttons (`▾` = dropdown), menus, tables and `slot`s (empty `<div>`s the components below mount into). `(hidden)` parts are shown by the page code when needed. Read with GET from a signed-in session; no values are kept.

### `/StarShipIt`: StarShipIT

Frame: `task-upload-frame`.

```text
block #StarShipIT
  link "Home"
  link "Integrations"
  button "Back to list"#backAction
  tabs#shop-main-tab: Shipping service #tab-ship-service |  #tab-add-new |  #tab-shop-help (hidden)
  button "Help"
  tab pane#tab-ship-service
    heading "StarShipIT"
    label "Use tax rate from"
    slot #StarShipIt_ShipServ_CustomerTax
    block #StarShipIt_ShipServ_TaxRuleBlock
      label "Tax rule for shipping" for #StarShipIt_ShipServ_TaxRule
      slot #StarShipIt_ShipServ_TaxRule
    label "Currency in StarShipIT" for #StarShipIt_ShipServ_Currency
    slot #StarShipIt_ShipServ_Currency
    label "Weight units in StarShipIT" for #StarShipIt_ShipServ_WeightUnits
    slot #StarShipIt_ShipServ_WeightUnits
    label "Dimension units in StarShipIT" for #StarShipIt_ShipServ_DimensionUnits
    slot #StarShipIt_ShipServ_DimensionUnits
    label "Additional shipping margin" for #StarShipIt_ShipServ_MarginValue
    slot #StarShipIt_ShipServ_MarginValue
    label "Margin value is" for #StarShipIt_ShipServ_Margin
    slot #StarShipIt_ShipServ_Margin
    label "Print shipping labels" for #StarShipIt_ShipServ_PrintShippingLabels
    input checkbox#StarShipIt_ShipServ_PrintShippingLabels
    heading "Pre-defined package types"
    button "Package type"#divAddPackageType primary
    slot #divPackageTypesGrid
    slot #SendNotificationOnLabelGeneration
    label "Send notification on shipping label generation" for #SendNotificationOnLabelGeneration
    block #btnSaveServiceChanges
      form#frmMakeDefaultSS
      button "Save changes" primary
      button "Set default"#StarShipIt_Index_MakeDefaultButton primary
    block #divDisconnectSS
      form#frmDisconnectSS
      heading "Disconnect from your StarShipIT"
      button "Disconnect" primary
  tab pane#tab-add-new
    heading "StarShipIT"
    block #credentialsTitle
      heading "To connect please specify your StarShipIT API key"
    form#frmAuthorise
      block #connectCredentials
        label "API key" for #StarShipIt_Index_ApiKey
        slot #StarShipIt_Index_ApiKey
      block #btnConnectToShop
        button "Connect StarShipIT"#btnConnectAsShipServ primary
  tab pane#tab-shop-help
    heading "Help"
    link "document"
```

## Components by bundle

What the page code builds and mounts into the layout's slots.

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

