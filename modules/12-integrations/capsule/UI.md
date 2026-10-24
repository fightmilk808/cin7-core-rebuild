# Capsule: UI

Every component the page code builds, read from the shipped ExtJS bundles: grids with their columns, fields, buttons, menus, windows and custom components. Labels are the English UI text. `renders into` is the id of the `<div>` in the page's server-rendered HTML that the component mounts in; `store` names the data store (see the endpoints in [README.md](README.md)); `on click` is the handler. Visual system and shell layout: [docs/UI.md](../../../docs/UI.md).

## Screens

| Route | Title | Bundles |
|---|---|---|
| `/Capsule` | Capsule | [`Capsule2019`](#capsule2019) |

## Layout

Each screen's server-rendered HTML inside the shell, as an outline: headings, tabs, sections, labels, inputs (`#id`), buttons (`▾` = dropdown), menus, tables and `slot`s (empty `<div>`s the components below mount into). `(hidden)` parts are shown by the page code when needed. Read with GET from a signed-in session; no values are kept.

### `/Capsule`: Capsule

Frame: `task-upload-frame`.

```text
link "Home"
link "Integrations"
tabs#portal-main-tab: Overview #tab_overview |  #tab-add-new | Help #tab-portal-help
tab pane#tab_overview
  tabs#overview-list: 
  block #overview-content (hidden)
    text "Capsule"
    text "Read the full information sheet about Capsule and Cin7 Core integration."
    button "Read information sheet" primary
    button "Help" primary
    tab pane#overview-content-tab
      heading #overview-portal-name
      block #overview-base-portal-settings (hidden)
        text "Base settings"
        slot #overview-portal-settings (hidden)
        slot #overview-portal-link
      block #overview-portal-logo (hidden)
tab pane#tab-portal-settings
  tabs: Setup #tab-portal-setup | Contacts #tab-portal-contacts
  text "Capsule"
  text "Read the full information sheet about Capsule and Cin7 Core integration."
  button "Read information sheet" primary
  button "Help" primary
  tab pane#tab-portal-setup
    heading "Setup"
    button "Save"#btnSaveSetupChanges primary
    block #authError (hidden)
      text "Seems like your integration is using the first version of Capsule API To update the integration to using API v.2 press t"
      form#frmUpdateApiVersion
        button "Update integration" primary
    block #authErrorReconect (hidden)
      text "Seems like your integration needs connection to Capsule"
      form#frmReconect
        button "Reconnect" primary
    text "General settings"
    slot #setupValidation (hidden)
    label "Ignore contacts without organizations"
    input checkbox#Capsule_Index_WithOrganisations
    label "Download only tagged contacts"
    input checkbox#Capsule_Index_WithTags
    label "Default customer taxation rule"
    slot #CapsuleCustomerTaxRule
    label "Default supplier taxation rule"
    slot #CapsuleSupplierTaxRule
    text "Link Capsule and Cin7 Core address types"
    button "Load from Capsule"#divLoadAddressTypesMapping
    slot #divAddressTypesMapping
    text "Link Capsule tags to Cin7 Core contact types"
    button "Load from Capsule"#divLoadTagsMapping
    slot #divTagsMapping
    block #divDisconnect
      text "Disconnect from your Capsule store"
      form#frmDisconnect
      button "Disconnect from Capsule store"
  tab pane#tab-portal-contacts
    heading "Contacts"
    input text#divSearchContacts placeholder "Type text to search"
    button "Search" primary
    button "Refresh"#divRefreshContacts
    button "Download contacts"#divDownloadContacts
    button "Save Not defined as customers"#divSaveAsCustomer
    button "Save Not defined as suppliers"#divSaveAsSupplier
    button #Grid_ContactsGrid_Options
    slot #contactsGridContainer
tab pane#tab-add-new
  heading "Link your Capsule marketplace with Cin7 Core"
  button "Connect to Capsule" primary
  block #addNewNote
    heading 
  link "Capsule - Start your FREE trial now!"
  button "Read information sheet" primary
tab pane#tab-portal-help
  heading "Help"
  link "Capsule - Start your FREE trial now!"
  button "Read information sheet" primary
modal#Capsule_DownloadContacts_Content small
  heading "Load contacts from Capsule"
  button "×"
  slot #Capsule_DownloadContacts_ValidationContainer (hidden)
  text "All contacts from Capsule will be loaded into Cin7 Core. If there is a contact in Cin7 Core with the same name as in Cap"
  block #Capsule_DownloadContacts_Actions
    button "Load from Capsule" primary
    button "Close"
form#frmSaveAsCustomers
form#frmSaveAsSuppliers
form#frmAuthoriseStepOne
```

## Components by bundle

What the page code builds and mounts into the layout's slots.

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

