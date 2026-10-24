# Shippit: UI

Every component the page code builds, read from the shipped ExtJS bundles: grids with their columns, fields, buttons, menus, windows and custom components. Labels are the English UI text. `renders into` is the id of the `<div>` in the page's server-rendered HTML that the component mounts in; `store` names the data store (see the endpoints in [README.md](README.md)); `on click` is the handler. Visual system and shell layout: [docs/UI.md](../../../docs/UI.md).

## Screens

| Route | Title | Bundles |
|---|---|---|
| `/Shippit` | Shippit | [`Shippit2019`](#shippit2019) |

## Layout

Each screen's server-rendered HTML inside the shell, as an outline: headings, tabs, sections, labels, inputs (`#id`), buttons (`▾` = dropdown), menus, tables and `slot`s (empty `<div>`s the components below mount into). `(hidden)` parts are shown by the page code when needed. Read with GET from a signed-in session; no values are kept.

### `/Shippit`: Shippit

Frame: `task-upload-frame`.

```text
link "Home"
link "Integrations"
button "Back to list"#backAction
tabs#shop-main-tab: Shipping service #tab-ship-service |  #tab-add-new |  #tab-shop-help (hidden)
button "Help"
tab pane#tab-ship-service
  heading "Shipping service"
  block #btnSaveServiceChanges
    form#frmMakeDefaultSS
    button "Save" primary
  label "Use tax rate from customer"
  input checkbox#Shippit_ShipServ_CustomerTax
  block #Shippit_ShipServ_TaxRuleBlock
    label "Tax rule for shipping" for #Shippit_ShipServ_TaxRule
    slot #Shippit_ShipServ_TaxRule
  label "Currency in Shippit" for #Shippit_ShipServ_Currency
  slot #Shippit_ShipServ_Currency
  label "Additional shipping margin" for #Shippit_ShipServ_MarginValue
  slot #Shippit_ShipServ_MarginValue
  label "By default, authority to leave is allowed."
  input checkbox#Shippit_ShipServ_Default_AuthorityToLeave
  label "Send notification on shipping label generation"
  input checkbox#SendNotificationOnLabelGeneration
  label "Margin value is"
  input radio#Shippit_ShipServ_Margin_true name=Shippit_ShipServ_Margin
  label "Relative" for #Shippit_ShipServ_Margin_true
  input radio#Shippit_ShipServ_Margin_false name=Shippit_ShipServ_Margin
  label "Absolute" for #Shippit_ShipServ_Margin_false
  label "Print shipping labels"
  input checkbox#StarShipIt_ShipServ_PrintShippingLabels
  block #divPreferredCarrierServiceList
    label "Preferred carriers/services"
    select#cmbCarrierServiceList
  slot #divSelectedCarrierServiceValues (hidden)
  heading "Pre-defined package types"
  button "Package type"#divAddPackageType primary
  slot #divPackageTypesGrid
  form#frmDisconnectSS
  block #divDisconnectSS
    button "Set default"#Shippit_Index_MakeDefaultButton primary
    button "Disconnect from your Shippit"
tab pane#tab-add-new
  heading "Connect to Shippit"
  block #btnConnectToShop
    button "Connect"#btnConnectAsShipServ primary (hidden)
  block #credentialsTitle
    heading "To connect Shippit, please specify your API key"
  form#frmAuthorise
    block #connectCredentials
      label "API key"
      slot #Shippit_Index_ApiKey
      label "Is a sandbox account"
      slot #Shippit_Index_Sandbox
tab pane#tab-shop-help
  heading "Help"
```

## Components by bundle

What the page code builds and mounts into the layout's slots.

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

