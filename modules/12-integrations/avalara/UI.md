# Avalara: UI

Every component the page code builds, read from the shipped ExtJS bundles: grids with their columns, fields, buttons, menus, windows and custom components. Labels are the English UI text. `renders into` is the id of the `<div>` in the page's server-rendered HTML that the component mounts in; `store` names the data store (see the endpoints in [README.md](README.md)); `on click` is the handler. Visual system and shell layout: [docs/UI.md](../../../docs/UI.md).

## Screens

| Route | Title | Bundles |
|---|---|---|
| `/Avalara` | Avalara | [`Avalara2019`](#avalara2019) |

## Layout

Each screen's server-rendered HTML inside the shell, as an outline: headings, tabs, sections, labels, inputs (`#id`), buttons (`▾` = dropdown), menus, tables and `slot`s (empty `<div>`s the components below mount into). `(hidden)` parts are shown by the page code when needed. Read with GET from a signed-in session; no values are kept.

### `/Avalara`: Avalara

Frame: `task-upload-frame`.

```text
link "Home"
link "Integrations"
button "Back to list"#backAction
heading "Integration settings"
tabs#settingsTabs: How integration works #start | General settings #tab-setup | Tax codes #tax_codes | Sync options #sync_options | Customer settings #customer_data
tab pane#start
  heading "Connect to Avalara"
  label "Account ID" for #Avalara_AccountID
  input text#Avalara_AccountID
  label "License key" for #Avalara_LicenseKey
  input text#Avalara_LicenseKey
  button "Connect"#btnConnectToShop primary
  heading "How does the integration work?"
  text "Avalara connects with Cin7 Core to help you calculate the sales tax for orders depending on their shipping address. For "
  text "Connect to Avalara"
  text "Connect your Avalara account by entering your Avalara Account ID and License key. You can find these on the Avalara Admi"
  text "Report to tax authority"
  text "Sync sales transactions with Avalara by enabling Report to tax authority. You can then enable the sync with Avalara for "
  text "Validate addresses"
  text "This validates where you are sending goods from. These addresses will be obtained from your Locations."
  text "Tax codes"
  text "You may edit tax codes for individual products via the Avalara integration page. Avalara provides a tax code list for re"
  text "Sync options"
  text "You can sync sales orders in Cin7 Core with Avalara. When in sync, updates to Cin7 Core sales orders will update the sam"
tab pane#tab-setup
  label "Account ID" for #Avalara_AccountID2
  input text#Avalara_AccountID2
  label "Avalara company*" for #CompanyCode
  slot #Avalara_Company
  label "Report to tax authority" for #Report_To_Tax_Authority
  input checkbox#Report_To_Tax_Authority
  label "Export sales from Shopify" for #ExportFromControl_Shopify
  input checkbox#ExportFromControl_Shopify
tab pane#tax_codes
  heading "Tax codes"
  input text#divAvalaraProductTaxCodeSearch placeholder "Type text to search"
  button "Search" primary
  slot #ProductTaxCodeGridContainer
tab pane#sync_options
  heading "Sync status"
  label "Synchronization status"
  text "In sync"
  heading "Autosync and alerts"
  label "Auto synchronization" for #chkAvalaraAutoSync
  input checkbox#chkAvalaraAutoSync
  block #divAutoSyncControls (hidden)
    label "Start date"
    slot #Avalara_Index_Start
    label "Start time"
    input text#tdAvalaraAutosynchronizationStartTime
    label "Sync frequency" for #cmbAutoSyncFrequency
    select#cmbAutoSyncFrequency: Every 2 hours | Every 4 hours | Every 8 hours | Every 12 hours | Daily
    label "Alert type for errors" for #cmbAutoSyncAlertTypes
    select#cmbAutoSyncAlertTypes: Email | Internal
    label "Mailing list" for #cmbAutoSyncMailingList
    slot #tdAutosynchronizationMailingList
  heading "Sync history"
  input text#divAvalaraSyncSearch placeholder "Type text to search"
  button "Search" primary
  button "Refresh"#btnRefresh
  select#divFilterEntity
  select#divFilterStatus
  button #Grid_gridName_Options
  block #divSync (hidden)
    slot #AvalaraSynchronisation_ValidationContainer
  slot #SyncGridContainer
tab pane#customer_data
  heading "Tax exempt customers"
  slot #AvalaraCustomerDataFilterComboContainer
  button "Link"#btnBulkLinkData (hidden)
  button "Unlink"#btnBulkUnlinkData (hidden)
  button "Load from Avalara"#btnCustomerDataRefresh
  slot #CustomerDataGridContainer
form#frmAvalaraForm
form#frmAvalaraDisconnectForm
modal#Avalara_LicenseKeyModal small
  heading "Avalara license key is not authenticated, enter a valid license key for the acco"
  button "×"
  input text#inpLicenseKey_Number
  label "License key"
  button "Save" primary
  button "Close"
```

## Components by bundle

What the page code builds and mounts into the layout's slots.

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

