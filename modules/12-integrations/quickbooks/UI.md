# QuickBooks: UI

Every component the page code builds, read from the shipped ExtJS bundles: grids with their columns, fields, buttons, menus, windows and custom components. Labels are the English UI text. `renders into` is the id of the `<div>` in the page's server-rendered HTML that the component mounts in; `store` names the data store (see the endpoints in [README.md](README.md)); `on click` is the handler. Visual system and shell layout: [docs/UI.md](../../../docs/UI.md).

## Screens

| Route | Title | Bundles |
|---|---|---|
| `/Quickbooks` | QuickBooks | [`Quickbooks2019`](#quickbooks2019) |

## Layout

Each screen's server-rendered HTML inside the shell, as an outline: headings, tabs, sections, labels, inputs (`#id`), buttons (`▾` = dropdown), menus, tables and `slot`s (empty `<div>`s the components below mount into). `(hidden)` parts are shown by the page code when needed. Read with GET from a signed-in session; no values are kept.

### `/Quickbooks`: QuickBooks

Redirects to `/Quickbooks/NotConnected`.

Frame: `task-upload-frame`.

```text
link "Home"
link "Integrations"
heading "Integration settings"
tabs#settingsTabs: How integration works #about | General settings #configuration | Sync options #sync_options | Advanced settings #settings
tab pane#about
  heading "QuickBooks is not connected."
  text "QuickBooks integration is currently disabled for your account. Would you like to enable it? Please click the button belo"
  button "Start QuickBooks Connect Wizard" primary
  heading "How does the integration work?"
  text "Integration with QuickBooks works in both ways. Press 'Sync now' in the footer when you want to synchronize your data:"
  text "Chart of accounts"
  text "Any changes in the chart of accounts in QuickBooks will be synced to Cin7 Core. Chart of accounts is read-only in Cin7 C"
  text "Tax rules"
  text "Any changes in tax rules in QuickBooks will be synced to Cin7 Core. Tax rules are read-only in Cin7 Core."
  text "Payment terms"
  text "Any changes in payment terms in QuickBooks will be synced to Cin7 Core. Payment terms are read-only in Cin7 Core."
  text "Vendors / Suppliers"
  text "Changes in QuickBooks vendors are synced with Cin7 Core as well as changes in Cin7 Core suppliers are synced with QuickB"
  text "Customers"
  text "Changes in QuickBooks customers are synced with Cin7 Core as well as changes in Cin7 Core customers are synced with Quic"
  text "Items / Products"
  text "Changes in QuickBooks items are synced with Cin7 Core. Products, created or updated in Cin7 Core, are pushed to QuickBoo"
  text "Purchase orders (optional)"
  text "If the blind receipt option is not checked, all purchase orders authorized in Cin7 Core will be exported to QuickBooks."
  text "Bills / Purchase invoices"
  text "Purchase invoices authorized in Cin7 Core will be exported to QuickBooks as bills."
  text "Vendor credits / Purchase credit notes"
  text "Purchase credit notes authorized in Cin7 Core will be exported to QuickBooks as vendor credits."
  text "Bill payments / Purchase payments and refunds"
  text "Bill payments and refunds will be imported to Cin7 Core from QuickBooks."
  text "Sale quotes (optional)"
  text "If the skip quote option is not checked, all sale quotes authorized in Cin7 Core will be exported to QuickBooks."
  text "Sale invoices"
  text "Sale invoices authorized in Cin7 Core will be exported to QuickBooks."
  text "Credit memos / Sale credit notes"
  text "Sale credit notes authorized in Cin7 Core will be exported to QuickBooks as 'Credit memos'."
  text "Payments / Refunds"
  text "Payments for invoices and refunds for credit memos will be synced with QuickBooks."
  text "IMPORTANT: Cin7 Core can integrate only with QuickBooks Online Plus and QuickBooks Online Advanced edition.For QuickBook"
modal#dlgConfirmationNotUsingDearUaeSpecificFinancialFeature small
  heading "Confirm not utilizing Cin7 Core UAE specific financial features"
  button "×"
  slot #dlgConfirmationNotUsingDearUaeSpecificFinancialFeatureMessage
  button "Yes"#btnConfirmationNotUsingDearUaeSpecificFinancialFeature primary
  button "No"
```

## Components by bundle

What the page code builds and mounts into the layout's slots.

### `Quickbooks2019`

2 grids · 13 standalone fields · 0 windows · 0 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `JournalsSearchResultGrid` · store `journalsSearchResultStore` · placeholder `Nothing found.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Void | `Selected` | check column | flex 3 | renderer() |  |
    | QBO ID | `QBOID` |  | flex 3 | renderer() |  |
    | Document number | `DocNumber` |  | flex 3 | renderer() |  |
    | Date | `Date` |  | flex 3 | renderer() |  |

- **grid** · renders into `divConsolidationChannelTypes` · store `ConsolidationChannelTypesStore` · placeholder `No sales channels`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | SALES CHANNEL | `SaleChannel` |  | flex 1 | renderer() |  |
    | INVOICE SYNC TYPE | `InvoiceSyncType` |  | flex 1 | renderer() |  |
    | COGS SYNC TYPE | `COGSSyncType` |  | flex 1 | renderer() |  |


#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| combo |  | `divQuickBooks_Customer` | `ConsolidateCustomerStore` | shows `name` · value `value` · placeholder `type or choose...` |
| date field |  | `tdQuickbooksInventoryStartDate` | `` | placeholder `Choose...` · format `UserDateFormat` |
| date field |  | `tdFrom` | `` | placeholder `Choose...` · format `UserDateFormat` |
| date field |  | `tdTo` | `` | placeholder `Choose...` · format `UserDateFormat` |
| date field |  | `tdSaleOverpaymentsSearchFrom` | `` | placeholder `Choose...` · format `UserDateFormat` |
| date field |  | `tdSaleOverpaymentsSearchTo` | `` | placeholder `Choose...` · format `UserDateFormat` |
| date field |  | `tdJournalsSearchFrom` | `` | placeholder `Choose...` · format `UserDateFormat` |
| date field |  | `tdJournalsSearchTo` | `` | placeholder `Choose...` · format `UserDateFormat` |
| date field |  | `tdQuickbooksAutosynchronizationStartDate` | `` | placeholder `Choose...` · format `UserDateFormat` |
| combo |  | `tdQuickbooksAutosynchronizationMailingList` | `MailingListStore` | shows `Name` · value `MailingListID` · placeholder `type or choose...` |
| date field |  | `ExportHistoricalDataDialog_StartDate` | `` | placeholder `Choose...` · format `UserDateFormat` |
| combo |  | `cmbQboWizardSohLocation` | `window.LocationStore` | shows `Description` · value `LocationID` · placeholder `Choose...` |
| combo |  | `cmbQboWizardSohLocation` | `window.LocationStore` | shows `Description` · value `LocationID` · placeholder `Choose...` |

