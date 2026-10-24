# AI: UI

Every component the page code builds, read from the shipped ExtJS bundles: grids with their columns, fields, buttons, menus, windows and custom components. Labels are the English UI text. `renders into` is the id of the `<div>` in the page's server-rendered HTML that the component mounts in; `store` names the data store (see the endpoints in [README.md](README.md)); `on click` is the handler. Visual system and shell layout: [docs/UI.md](../../docs/UI.md).

## Screens

| Route | Title | Bundles |
|---|---|---|
| `/AMA` | Ask Me Anything ~ |  |
| `/DocumentExtraction` | Document data extraction | [`DocumentExtraction2024`](#documentextraction2024) |

## Layout

Each screen's server-rendered HTML inside the shell, as an outline: headings, tabs, sections, labels, inputs (`#id`), buttons (`▾` = dropdown), menus, tables and `slot`s (empty `<div>`s the components below mount into). `(hidden)` parts are shown by the page code when needed. Read with GET from a signed-in session; no values are kept.

### `/DocumentExtraction`: Document data extraction

Frame: `ifrmIdrUploader`.

```text
link "Home"
link "Import"
block #divIdr
  link "Upload"
  link "Mapping"
  link "Logs"
  tab pane#divDocumentImport
    slot #FeatureModuleDetailsBlock (hidden)
    slot #divLimitAlert (hidden)
    text "Use document data extraction to import PDF files, parse and extract data automatically using AI, and map the extracted d"
    block #divIdrPreviewTemplate (hidden)
    slot #ifrmIdrUploader (hidden)
    form#frmIdrUpload
      heading "Drop files here or click to upload."
    button "Attach from Google Drive" primary
    text "Upload your document.Core extracts document fields and values. Core uses AI to map extracted fields to Core fields.Check"
    button "Refresh"#btnDocExtRefresh
    button #btnCustomizeDocExtGrid
    slot #gridDocExt
  tab pane#divDocumentExtraction
    heading "Import as sale - Mapping..."
    button "Ready for approval"#btnDocExtApprove primary
    button "Save"#btnDocExtSave primary
    button "Back to list"#btnDocExtBack
    input text#txtDocExtFileName read-only
    label "Import file name"
    slot #divMappingFields
    heading "File preview -"
    slot #ifrmFilePreview
  tab pane#divIdeLogs
    input text#divSearchLog placeholder "Type text to search"
    button "Search"#btnSearch primary
    button "Refresh"#divRefreshLog
    button #Grid_gridName_Options
    slot #logsGridContainer
```

Dialogs on this page:

<details><summary><code>Sale_NewCustomer_Content</code></summary>

```text
modal#Sale_NewCustomer_Content medium
  heading "New customer"
  button "×"
  input text#tdSale_NewCustomer_Name placeholder "Enter a customer name"
  label "Name"
  slot #tdSale_NewCustomer_Parent
  label "Parent"
  select#tdSale_NewCustomer_PaymentTerm
  label "Payment term"
  select#tdSale_NewCustomer_SaleAccount
  label "Sale account"
  select#tdSale_NewCustomer_DefaultSalesRepresentative
  label "Sales representative"
  select#tdSale_NewCustomer_DefaultLocation
  label "Default location"
  input text#tdSale_NewCustomer_Discount placeholder "Enter a customer discount"
  label "Discount"
  slot #tdSale_NewCustomer_IsLegalEntity
  label "Legal entity" for #chkSale_NewCustomer_IsLegalEntity
  input text#tdSale_NewCustomer_CustomerName placeholder "Enter a display name"
  label "Display name"
  slot #tdSale_NewCustomer_BillParent
  label "Bill parent" for #chkSale_NewCustomer_BillParent
  slot #tdSale_NewCustomer_Currency
  label "Currency"
  select#tdSale_NewCustomer_AccountPayable
  label "Account receivable"
  block #divCustomerTaxRule
    select#tdSale_NewCustomer_TaxRule
    label "Tax rule"
  select#tdSale_NewCustomer_DefaultCarrier
  label "Default carrier"
  block #divCustomerTaxNumber
    input text#tdSale_NewCustomer_TaxNumber placeholder "Enter a tax number"
    label "Tax number"
  select#tdSale_NewCustomer_SalePriceTier
  label "Sale price tier"
  textarea#tdSale_NewCustomer_Comments placeholder "Enter comments"
  label "Comments"
  button "Save" primary
  button "Close"
```

</details>

## Components by bundle

What the page code builds and mounts into the layout's slots.

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

