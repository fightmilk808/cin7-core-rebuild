# RMA Portal: UI

Every component the page code builds, read from the shipped ExtJS bundles: grids with their columns, fields, buttons, menus, windows and custom components. Labels are the English UI text. `renders into` is the id of the `<div>` in the page's server-rendered HTML that the component mounts in; `store` names the data store (see the endpoints in [README.md](README.md)); `on click` is the handler. Visual system and shell layout: [docs/UI.md](../../../docs/UI.md).

## Screens

| Route | Title | Bundles |
|---|---|---|
| `/RmaPortal` | RMA Portal | [`RmaPortal2019`](#rmaportal2019) |

## Components by bundle

### `RmaPortal2019`

0 grids · 3 standalone fields · 0 windows · 0 menus, buttons and other parts · 0 custom components

#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| combo |  | `RmaPortal_Index_Contacts` | `vContactsStore` | shows `Name` · value `ContactID` · placeholder `Choose...` |
| combo |  | `RmaPortal_Index_Address` | `vAddressesStore` | shows `Line1` · value `AddressID` · placeholder `Choose...` |
| file field |  | `RmaPortal_Index_Logo` | `attachedFile` |  |

