# Capsule: UI

Every component the page code builds, read from the shipped ExtJS bundles: grids with their columns, fields, buttons, menus, windows and custom components. Labels are the English UI text. `renders into` is the id of the `<div>` in the page's server-rendered HTML that the component mounts in; `store` names the data store (see the endpoints in [README.md](README.md)); `on click` is the handler. Visual system and shell layout: [docs/UI.md](../../../docs/UI.md).

## Screens

| Route | Title | Bundles |
|---|---|---|
| `/Capsule` | Capsule | [`Capsule2019`](#capsule2019) |

## Components by bundle

### `Capsule2019`

3 grids · 2 standalone fields · 0 windows · 0 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `contactsGridContainer` · store `contactsStore` · placeholder `Contacts are not found`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Name | `ECSName` |  | flex 1 | renderer() |  |
    | Company / person | `IsOrganization` |  | flex 1 | renderer() |  |
    | Customer / supplier | `ContactType` |  | flex 1 | renderer() |  |

- **grid** · renders into `divAddressTypesMapping` · store `vEcsAddressTypesMappingStore` · placeholder `No address types loaded yet...`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Capsule address type | `ECSAddressType` |  | flex 1 | RenderHTMLText |  |
    | Address type | `AddressType` |  | flex 1 | renderer() |  |

- **grid** · renders into `divTagsMapping` · store `vEcsContactTagMappingStore` · placeholder `No tags loaded yet...`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Capsule tag | `ECSTag` |  | flex 1 | RenderHTMLText |  |
    | Contact type | `ContactType` |  | flex 1 | renderer() |  |


#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| combo |  | `CapsuleCustomerTaxRule` | `vCustomerTaxRulesStore` | shows `Description` · value `RuleID` · placeholder `Choose...` |
| combo |  | `CapsuleSupplierTaxRule` | `vSupplierTaxRulesStore` | shows `Description` · value `RuleID` · placeholder `Choose...` |

