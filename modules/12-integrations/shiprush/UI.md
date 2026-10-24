# ShipRush: UI

Every component the page code builds, read from the shipped ExtJS bundles: grids with their columns, fields, buttons, menus, windows and custom components. Labels are the English UI text. `renders into` is the id of the `<div>` in the page's server-rendered HTML that the component mounts in; `store` names the data store (see the endpoints in [README.md](README.md)); `on click` is the handler. Visual system and shell layout: [docs/UI.md](../../../docs/UI.md).

## Screens

| Route | Title | Bundles |
|---|---|---|
| `/ShipRush` | ShipRush | [`ShipRush2019`](#shiprush2019) |

## Layout

Each screen's server-rendered HTML inside the shell, as an outline: headings, tabs, sections, labels, inputs (`#id`), buttons (`▾` = dropdown), menus, tables and `slot`s (empty `<div>`s the components below mount into). `(hidden)` parts are shown by the page code when needed. Read with GET from a signed-in session; no values are kept.

### `/ShipRush`: ShipRush

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
  label "Default ship from address"
  slot #ShipRush_ShipServ_FromAddress
  label "Use tax rate from"
  slot #ShipRush_ShipServ_CustomerTax
  block #ShipRush_ShipServ_TaxRuleBlock
    label "Tax rule for shipping" for #ShipRush_ShipServ_TaxRule
    slot #ShipRush_ShipServ_TaxRule
  label "Additional shipping margin" for #ShipRush_ShipServ_MarginValue
  slot #ShipRush_ShipServ_MarginValue
  label "Margin value is"
  select#ShipRush_ShipServ_Margin: Absolute | Relative
  label "Send notification on shipping label generation"
  input checkbox#SendNotificationOnLabelGeneration
  label "From company on shipping label"
  slot #ShipRush_ShipServ_Company
  label "From contact on shipping label"
  slot #ShipRush_ShipServ_Contact
  label "Print shipping labels"
  input checkbox#ShipRush_ShipServ_PrintShippingLabels
  label "Freight shipping"
  input checkbox#ShipRush_ShipServ_UseFreight
  block #divPreferredCarrierServiceList
    label "Preferred carriers/services"
    select#cmbCarrierServiceList
    slot #divSelectedCarrierServiceValues (hidden)
  heading "Pre-defined package dimensions"
  block #divNoDimensions (hidden)
    text "Please note if UOM are not displayed for the dimensions fields, they must first be configured in General Settings - Prod"
  block #divDimensionsTable
    table: Dimension | Quantity | UOM
  block #divFreightFields (hidden)
    heading "Pre-defined settings for freight shipping"
    label "Shipping type"
    slot #ShipRush_ShipServ_FreightServiceType
    label "Equipment"
    slot #ShipRush_ShipServ_EquipmentType
    label "Item packaging"
    slot #ShipRush_ShipServ_ItemPackaging
    label "Freight commodities class"
    slot #ShipRush_ShipServ_ItemFreightClass
  form#frmDisconnectSS
  block #divDisconnectSS
    button "Set default"#ShipRush_Index_MakeDefaultButton primary
    button "Disconnect"
tab pane#tab-add-new
  heading "Connect to ShipRush"
  block #btnConnectToShop
    button "Connect to ShipRush"#btnConnectAsShipServ primary (hidden)
  form#frmAuthorise
    block #connectCredentials
      label "User token"
      slot #ShipRush_Index_ApiKey
      label "Is a sandbox account"
      input checkbox#ShipRush_Index_Sandbox
tab pane#tab-shop-help
  heading "Help"
  link "privacy policy"
```

## Components by bundle

What the page code builds and mounts into the layout's slots.

### `ShipRush2019`

0 grids · 5 standalone fields · 0 windows · 4 menus, buttons and other parts · 0 custom components

#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| combo |  | `ShipRush_ShipServ_TaxRule` | `TaxStore` | shows `Description` · value `RuleID` |
| combo |  | `ShipRush_ShipServ_FromAddress` | `vTenantAddressStore` | value `AddressID` · placeholder `` |
| combo |  | `ShipRush_ShipServ_CustomerTax` | `UseTaxRateFromStore` | shows `name` · value `value` |
| combo |  | `input` | `store` | shows `name` · value `value` |
| text field |  | `ShipRush_Index_ApiKey` | `` |  |

#### Menus, buttons and other parts

- **component** · renders into `ShipRush_ShipServ_MarginValue`
- **component** · renders into `ShipRush_ShipServ_Contact`
- **component** · renders into `ShipRush_ShipServ_Company`
- **component** · renders into `"ShipRush_ShipServ_".concat(…)`

