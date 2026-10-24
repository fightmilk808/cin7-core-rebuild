# EasyPost: UI

Every component the page code builds, read from the shipped ExtJS bundles: grids with their columns, fields, buttons, menus, windows and custom components. Labels are the English UI text. `renders into` is the id of the `<div>` in the page's server-rendered HTML that the component mounts in; `store` names the data store (see the endpoints in [README.md](README.md)); `on click` is the handler. Visual system and shell layout: [docs/UI.md](../../../docs/UI.md).

## Screens

| Route | Title | Bundles |
|---|---|---|
| `/EasyPost` | EasyPost | [`EasyPost2019`](#easypost2019) |

## Components by bundle

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

