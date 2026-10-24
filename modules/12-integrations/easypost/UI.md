# EasyPost: UI

Every component the page code builds, read from the shipped ExtJS bundles: grids with their columns, fields, buttons, menus, windows and custom components. Labels are the English UI text. `renders into` is the id of the `<div>` in the page's server-rendered HTML that the component mounts in; `store` names the data store (see the endpoints in [README.md](README.md)); `on click` is the handler. Visual system and shell layout: [docs/UI.md](../../../docs/UI.md).

## Screens

| Route | Title | Bundles |
|---|---|---|
| `/EasyPost` | EasyPost | [`EasyPost2019`](#easypost2019) |

## Layout

Each screen's server-rendered HTML inside the shell, as an outline: headings, tabs, sections, labels, inputs (`#id`), buttons (`▾` = dropdown), menus, tables and `slot`s (empty `<div>`s the components below mount into). `(hidden)` parts are shown by the page code when needed. Read with GET from a signed-in session; no values are kept.

### `/EasyPost`: EasyPost

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
  slot #EasyPost_ShipServ_FromAddress
  label "Use tax rate from"
  slot #EasyPost_ShipServ_CustomerTax
  block #EasyPost_ShipServ_TaxRuleBlock
    label "Tax rule for shipping" for #EasyPost_ShipServ_TaxRule
    slot #EasyPost_ShipServ_TaxRule
  label "Additional shipping margin" for #EasyPost_ShipServ_MarginValue
  slot #EasyPost_ShipServ_MarginValue
  label "Margin value is"
  select#EasyPost_ShipServ_Margin: Absolute | Relative
  label "Send notification on shipping label generation"
  input checkbox#SendNotificationOnLabelGeneration
  label "Sender company on shipping label"
  slot #EasyPost_ShipServ_Company
  label "Sender contact on shipping label"
  slot #EasyPost_ShipServ_Contact
  label "Return contact phone number"
  slot #EasyPost_ShipServ_ReturnPhoneNumber
  label "Customs signer"
  slot #EasyPost_ShipServ_CustomsSigner
  label "Print shipping labels"
  input checkbox#EasyPost_ShipServ_PrintShippingLabels
  heading "Pre-defined package dimensions"
  block #divNoDimensions (hidden)
    text "Please note if UOM are not displayed for the dimensions fields, they must first be configured in General Settings - Prod"
  block #divDimensionsTable
    table: Dimension | Quantity | UOM
  form#frmDisconnectSS
  block #divDisconnectSS
    heading "Disconnect from EasyPost"
    button "Set default"#EasyPost_Index_MakeDefaultButton primary
    button "Disconnect"
tab pane#tab-add-new
  heading "Connect to EasyPost"
  block #btnConnectToShop
    button "Connect to EasyPost"#btnConnectAsShipServ primary (hidden)
  form#frmAuthorise
    block #connectCredentials
      label "API key"
      slot #EasyPost_Index_ApiKey
      block #EasyPost_Index_TestApiKeyBlock (hidden)
        label "Test API key" for #EasyPost_TestApiKey
        slot #EasyPost_Index_TestApiKey
      label "Is a sandbox account"
      input checkbox#EasyPost_Index_Sandbox
tab pane#tab-shop-help
  heading "Help"
  link "privacy policy"
```

## Components by bundle

What the page code builds and mounts into the layout's slots.

### `EasyPost2019`

0 grids · 5 standalone fields · 0 windows · 6 menus, buttons and other parts · 0 custom components

#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| combo |  | `EasyPost_ShipServ_TaxRule` | `TaxStore` | shows `Description` · value `RuleID` |
| combo |  | `EasyPost_ShipServ_FromAddress` | `vTenantAddressStore` | value `AddressID` · placeholder `` |
| combo |  | `EasyPost_ShipServ_CustomerTax` | `UseTaxRateFromStore` | shows `name` · value `value` |
| text field |  | `EasyPost_Index_ApiKey` | `` |  |
| text field |  | `EasyPost_Index_TestApiKey` | `` |  |

#### Menus, buttons and other parts

- **component** · renders into `EasyPost_ShipServ_MarginValue`
- **component** · renders into `EasyPost_ShipServ_Contact`
- **component** · renders into `EasyPost_ShipServ_Company`
- **component** · renders into `EasyPost_ShipServ_ReturnPhoneNumber`
- **component** · renders into `EasyPost_ShipServ_CustomsSigner`
- **component** · renders into `"EasyPost_ShipServ_".concat(…)`

