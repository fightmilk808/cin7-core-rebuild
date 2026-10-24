# Google Workspaces: UI

Every component the page code builds, read from the shipped ExtJS bundles: grids with their columns, fields, buttons, menus, windows and custom components. Labels are the English UI text. `renders into` is the id of the `<div>` in the page's server-rendered HTML that the component mounts in; `store` names the data store (see the endpoints in [README.md](README.md)); `on click` is the handler. Visual system and shell layout: [docs/UI.md](../../../docs/UI.md).

## Screens

| Route | Title | Bundles |
|---|---|---|
| `/GSuites` | Google Workspaces | [`GSuites2019`](#gsuites2019) |

## Layout

Each screen's server-rendered HTML inside the shell, as an outline: headings, tabs, sections, labels, inputs (`#id`), buttons (`▾` = dropdown), menus, tables and `slot`s (empty `<div>`s the components below mount into). `(hidden)` parts are shown by the page code when needed. Read with GET from a signed-in session; no values are kept.

### `/GSuites`: Google Workspaces

Frame: `task-upload-frame`.

```text
link "Home"
link "Integrations"
tabs#portal-main-tab: Setup #tab_setup | Contacts #tab_contacts (hidden) | Log #tab_logs | Help #tab-help
tab pane#tab_setup
  heading "Setup"
  button "Save"#btnSave primary (hidden)
  block #gsuitesReconnectBanner (hidden)
    text "Your Google Workspace connection needs to be updated to use reduced permissions. Please reconnect and then reselect your"#gsuitesReconnectMessage
    form
      button "Reconnect" primary
  block #gsuitesFolderReselectBanner (hidden)
    text "Your export folder selections were cleared during reconnection. Please reselect the required folders below, then save."#gsuitesFolderReselectMessage
  block #regForm (hidden)
    label "Connect to"
    form
  block #setupForm (hidden)
    label "Synchronize contacts from Cin7 Core to Google"
    input checkbox#chkSyncContacts
    label "Export data from Cin7 Core to Google Drive when printing/ emailing"
    input checkbox#chkExportWhenPrintEmail
    block #gsLocationBlock (hidden)
      heading "Data export folder"
      slot #gdLocationNamePrinting
      button "Change"#btnChangeGDrivePrinting primary
      form
    heading "Report export folder"
    slot #gdLocationNameReporting
    button "Change"#btnChangeGDriveReporting primary
    form
    form#frmDisconnect
      button "Disconnect"
tab pane#tab_contacts
  heading "Contacts"
  select#GSuites_Index_ContactLabel
  label "Google Workspace label"
  button "Start"#GSuites_Sync_Start primary
  slot #GSuites_SyncContactsValidation
  input text#divSearch placeholder "Type text to search"
  button "Search" primary
  select#GSuites_Index_ContactTypeStatus: All | Active | Inactive
  label "Status"
  select#GSuites_Index_ContactType: Any | Customer | Supplier
  label "Cin7 Core contact type"
  button #divRefresh
  slot #divContacts
tab pane#tab_logs
  heading "Log"
  button "Refresh"
  slot #divLogs
tab pane#tab-help
  heading "Help"
```

## Components by bundle

What the page code builds and mounts into the layout's slots.

### `GSuites2019`

2 grids · 0 standalone fields · 0 windows · 1 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `divContacts` · store `ContactInfoStore` · placeholder `You do not have any contacts.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Contact | `ContactName` |  | flex 2 |  |  |
    | Contact type | `ContactType` |  | flex 1 | renderer() |  |
    | Customer/ supplier name | `ContactTypeName` |  | flex 1 |  |  |
    | Status | `IsActive` |  | flex 1 | renderer() |  |

- **grid** · renders into `divLogs` · store `vGsuiteLogStore` · placeholder `You do not have any logs.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Date | `LogDate` |  | 150 | renderer() |  |
    | Action | `Action` |  | 300 | renderer() |  |
    | Message | `Message` |  | flex 1 | renderer() |  |


#### Menus, buttons and other parts

- **component** “{window.WarningCaption}”

