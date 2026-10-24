# AI: UI

Every component the page code builds, read from the shipped ExtJS bundles: grids with their columns, fields, buttons, menus, windows and custom components. Labels are the English UI text. `renders into` is the id of the `<div>` in the page's server-rendered HTML that the component mounts in; `store` names the data store (see the endpoints in [README.md](README.md)); `on click` is the handler. Visual system and shell layout: [docs/UI.md](../../docs/UI.md).

## Screens

| Route | Title | Bundles |
|---|---|---|
| `/AMA` | Ask Me Anything ~ |  |
| `/DocumentExtraction` | Document data extraction | [`DocumentExtraction2024`](#documentextraction2024) |

## Components by bundle

### `DocumentExtraction2024`

3 grids · 8 standalone fields · 0 windows · 1 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `_classPrivateFieldGet(_DOM_ID_MAP,this).DIV_GRID` · store `store` · placeholder `You have not imported any files.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | File name | `DocumentName` |  | flex 3 | renderer() |  |
    | Status | `Status` |  | flex 1 | renderer() |  |
    | Extracted date | `DateCreated` |  | flex 1 | renderer() |  |
    | Action | `FileID` |  | flex 1 | renderer() |  |

- **grid** · renders into `logsGridContainer` · store `store`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Date | `Date` | date column | 200 | renderer() |  |
    | Document name | `DocumentName` |  | flex 1 | RenderHTMLText |  |
    | Comment | `Comment` |  | flex 1 |  |  |
    | User | `UserName` |  | flex 1 |  |  |

- **grid** · renders into `divRelatedOrdersDetails` · store `RelatedOrdersStore` · placeholder `No related orders created.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Order | `TaskNumber` |  | flex 1 | renderer() |  |
    | Type | `TaskTypeName` |  | flex 1 | RenderHTMLText |  |
    | Order date | `OrderDate` |  | flex 1 | renderer() |  |
    | Status | `Status` |  | flex 1 | renderer() |  |
    | Total | `TotalAmount` |  | 130 | renderer() |  |


#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| combo (+ add new) |  | `extDocExtCustomer` | `store` | shows `Name` · value `Name` · placeholder `type to search...` |
| date field |  | `dtNewSaleGiftCardExpirationDate` | `` | placeholder `Choose...` · format `UserDateFormat` |
| combo |  | `cmbAvalaraTaxExemptionCode` | `vSale_AvalaraSaleTaxCodeStore` | shows `Name` · value `Code` · placeholder `Choose...` |
| combo |  | `cmbAvalaraTaxExemptionCode_NewAddress` | `vSale_AvalaraSaleTaxCodeStore` | shows `Name` · value `Code` · placeholder `Choose...` |
| combo |  | `tdSale_NewCustomer_Currency` | `currencyStore` | shows `Code` · value `Code` |
| checkbox |  | `tdSale_NewCustomer_IsLegalEntity` | `` |  |
| checkbox |  | `tdSale_NewCustomer_BillParent` | `` |  |
| combo |  | `tdSale_NewCustomer_Parent` | `vCustomerParentStore` | shows `Name` · value `CustomerID` · placeholder `Select parent` |

#### Menus, buttons and other parts

- **button** “{"Manifest: ".concat(…)}” · id `r.get(…)` · on click `handler()`

