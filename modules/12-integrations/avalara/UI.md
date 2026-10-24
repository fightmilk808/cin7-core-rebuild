# Avalara: UI

Every component the page code builds, read from the shipped ExtJS bundles: grids with their columns, fields, buttons, menus, windows and custom components. Labels are the English UI text. `renders into` is the id of the `<div>` in the page's server-rendered HTML that the component mounts in; `store` names the data store (see the endpoints in [README.md](README.md)); `on click` is the handler. Visual system and shell layout: [docs/UI.md](../../../docs/UI.md).

## Screens

| Route | Title | Bundles |
|---|---|---|
| `/Avalara` | Avalara | [`Avalara2019`](#avalara2019) |

## Components by bundle

### `Avalara2019`

3 grids · 4 standalone fields · 0 windows · 0 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `ProductTaxCodeGridContainer` · store `productTaxCodeStore` · placeholder `No products`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product SKU | `ProductCode` |  | flex 1 |  |  |
    | Product name | `ProductName` |  | flex 2 |  |  |
    | Avalara tax code | `AvalaraTaxCode` |  | flex 1 | renderer() |  |

- **grid** · renders into `CustomerDataGridContainer` · store `customerDataStore` · placeholder `No tax-exempt customers found`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Avalara customer | `AvalaraCustomerName` |  | flex 1 | renderer() |  |
    | CORE CUSTOMER | `CustomerID` |  | flex 2 | renderer() |  |
    |  | `IsLinked` |  | 120 | renderer() |  |

- **grid** · renders into `SyncGridContainer` · store `syncStore` · placeholder `No sync entries.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    |  | `StatusBtn` |  | 58 | renderer() |  |
    | Status | `Status` |  | 118 | renderer() |  |
    | Date | `DateCreated` |  | 160 | renderer() |  |
    | What to sync | `SaleOrderNumber` |  | flex 1 | renderer() |  |
    | Error/ comment | `Error` |  | flex 1 | renderer() |  |


#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| date field |  | `Avalara_Index_Start` | `` | placeholder `Choose...` · format `UserDateFormat` |
| combo |  | `tdAutosynchronizationMailingList` | `MailingListStore` | shows `Name` · value `MailingListID` · placeholder `type or choose...` |
| combo |  | `Avalara_Company` | `companyStore` | shows `Name` · value `Code` · placeholder `Select a Avalara company` · pick-only |
| combo |  | `AvalaraCustomerDataFilterComboContainer` | `AvalaraCustomerDataFilterStore` | shows `text` · value `value` · pick-only |

