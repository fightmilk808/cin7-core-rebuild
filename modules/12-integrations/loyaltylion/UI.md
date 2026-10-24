# LoyaltyLion: UI

Every component the page code builds, read from the shipped ExtJS bundles: grids with their columns, fields, buttons, menus, windows and custom components. Labels are the English UI text. `renders into` is the id of the `<div>` in the page's server-rendered HTML that the component mounts in; `store` names the data store (see the endpoints in [README.md](README.md)); `on click` is the handler. Visual system and shell layout: [docs/UI.md](../../../docs/UI.md).

## Screens

| Route | Title | Bundles |
|---|---|---|
| `/LoyaltyLion` | LoyaltyLion | [`LoyaltyLion2019`](#loyaltylion2019) |

## Layout

Each screen's server-rendered HTML inside the shell, as an outline: headings, tabs, sections, labels, inputs (`#id`), buttons (`▾` = dropdown), menus, tables and `slot`s (empty `<div>`s the components below mount into). `(hidden)` parts are shown by the page code when needed. Read with GET from a signed-in session; no values are kept.

### `/LoyaltyLion`: LoyaltyLion

Frame: `task-upload-frame`.

```text
link "Home"
link "Integrations"
block #pageBody
  heading "Connect to LoyaltyLion"
  button "Connect to LoyaltyLion"#connectButton primary
  label "Token"
  input text required
  label "Secret"
  input text required
  label "API Key"
  input text required
  text "LoyaltyLion now requires API Key authentication. Please disconnect this integration and then connect with your API Key, "
  heading "Setup"
  button "Save" primary
  label "Currency"
  select: {{item.DisplayCurrency}}
  button "Disconnect from LoyaltyLion"
```

## Components by bundle

What the page code builds and mounts into the layout's slots.

### `LoyaltyLion2019`

0 grids · 2 standalone fields · 0 windows · 0 menus, buttons and other parts · 0 custom components

#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| combo |  | `tdBulkListingBrand` | `vTenantBrandStore` | shows `Brand` · value `ID` · placeholder `List all brands` |
| combo |  | `tdBulkListingListedIn` | `ECommerceShopStore` | shows `ShopName` · value `ConfigID` · placeholder `Choose...` |

