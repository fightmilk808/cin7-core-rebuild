# Warehouse application configuration: UI

Every component the page code builds, read from the shipped ExtJS bundles: grids with their columns, fields, buttons, menus, windows and custom components. Labels are the English UI text. `renders into` is the id of the `<div>` in the page's server-rendered HTML that the component mounts in; `store` names the data store (see the endpoints in [README.md](README.md)); `on click` is the handler. Visual system and shell layout: [docs/UI.md](../../../docs/UI.md).

## Screens

| Route | Title | Bundles |
|---|---|---|
| `/WarehouseApp` | Warehouse application configuration | [`WarehouseApp2019`](#warehouseapp2019) |

## Layout

Each screen's server-rendered HTML inside the shell, as an outline: headings, tabs, sections, labels, inputs (`#id`), buttons (`▾` = dropdown), menus, tables and `slot`s (empty `<div>`s the components below mount into). `(hidden)` parts are shown by the page code when needed. Read with GET from a signed-in session; no values are kept.

### `/WarehouseApp`: Warehouse application configuration

Frame: `task-upload-frame`.

```text
link "Home"
link "Integrations"
heading "Warehouse application configuration"
block #divWorkFlowDetails
  form#frmSave
    label "Always scan bin numbers" for #tdWarehouseAlwaysScanBinNumbers
    input checkbox#tdWarehouseAlwaysScanBinNumbers
    label "Allow manual quantity entry" for #tdWarehouseAllowManualQuantityEntry
    input checkbox#tdWarehouseAllowManualQuantityEntry
    label "Expense account"
    select#tdExpenseAccount_Select
    label "In-transit account"
    select#tdInTransitAccount_Select
    label "Sale order picking scheduled"
    input radio#tdWarehousePickingType_true name=tdWarehousePickingType
    label "Scheduled" for #tdWarehousePickingType_true
    input radio#tdWarehousePickingType_false name=tdWarehousePickingType
    label "All" for #tdWarehousePickingType_false
    block #pickOrdersPerRoundBlock (hidden)
      label "Number of orders per pick" for #tdWarehousePickOrdersPerRound
      input text#tdWarehousePickOrdersPerRound
      text "Default quantity for new line"
    label "Use tote no." for #tdWarehouseUseTote
    input checkbox#tdWarehouseUseTote
    label "Enforce per-unit batch scanning" for #tdWarehouseExplicitBatchPickConfirmation
    input checkbox#tdWarehouseExplicitBatchPickConfirmation
    label "Sale order packing"
    input radio#tdWarehouseAutoPack_true name=tdWarehouseAutoPack
    label "Automatic" for #tdWarehouseAutoPack_true
    input radio#tdWarehouseAutoPack_false name=tdWarehouseAutoPack
    label "Manual" for #tdWarehouseAutoPack_false
    label "Sale order shipping"
    input radio#tdWarehouseAutoShip_true name=tdWarehouseAutoShip
    label "Automatic" for #tdWarehouseAutoShip_true
    input radio#tdWarehouseAutoShip_false name=tdWarehouseAutoShip
    label "Manual" for #tdWarehouseAutoShip_false
    input radio#tdWarehouseAutoShip_disabled name=tdWarehouseAutoShip
    label "No shipment" for #tdWarehouseAutoShip_disabled
    label "Print package details" for #tdPrintBoxLabel
    input checkbox#tdPrintBoxLabel
    label "Time tracking for"
    slot #divWarehouseTimeTrackingMode
    label "Enforce single picker per sale" for #tdAllowMultiPickers
    input checkbox#tdAllowMultiPickers
    label "Use picking for kitting" for #tdUsePickingForKitting
    input checkbox#tdUsePickingForKitting
```

## Components by bundle

What the page code builds and mounts into the layout's slots.

### `WarehouseApp2019`

0 grids · 3 standalone fields · 0 windows · 0 menus, buttons and other parts · 0 custom components

#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| combo |  | `divWarehouseTimeTrackingMode` | `timeTrackingOptionsStore` | shows `displayName` · value `id` · pick-only |
| combo |  | `tdBulkListingBrand` | `vTenantBrandStore` | shows `Brand` · value `ID` · placeholder `List all brands` |
| combo |  | `tdBulkListingListedIn` | `ECommerceShopStore` | shows `ShopName` · value `ConfigID` · placeholder `Choose...` |

