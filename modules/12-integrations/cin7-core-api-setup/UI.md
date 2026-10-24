# Cin7 Core API setup: UI

Every component the page code builds, read from the shipped ExtJS bundles: grids with their columns, fields, buttons, menus, windows and custom components. Labels are the English UI text. `renders into` is the id of the `<div>` in the page's server-rendered HTML that the component mounts in; `store` names the data store (see the endpoints in [README.md](README.md)); `on click` is the handler. Visual system and shell layout: [docs/UI.md](../../../docs/UI.md).

## Screens

| Route | Title | Bundles |
|---|---|---|
| `/ExternalApi` | Cin7 Core API setup | [`ExternalApi2019`](#externalapi2019) |

## Layout

Each screen's server-rendered HTML inside the shell, as an outline: headings, tabs, sections, labels, inputs (`#id`), buttons (`▾` = dropdown), menus, tables and `slot`s (empty `<div>`s the components below mount into). `(hidden)` parts are shown by the page code when needed. Read with GET from a signed-in session; no values are kept.

### `/ExternalApi`: Cin7 Core API setup

Frame: `task-upload-frame`.

```text
link "Home"
link "Integrations"
button "Back to list"
block #tabContainer
  tabs#shop-main-tab: Overview #tab_overview |  #tab-add-new | Help #tab-shop-help
tab pane#tab_overview
  button "All applications"#overview-total
  slot #FeatureModuleDetailsBlock (hidden)
  heading #overview-shop-name
  block #overview-content
    block #overview-shop-logo
    slot #overview-shop-link
    block #overview-base-shop-settings (hidden)
      slot #overview-shop-settings
    button "Refresh"#divRefreshSalesSummary
    slot #overview-sales-summary
    slot #overview-sales-summary-small
tab pane#tab-shop-settings
  button "Setup"#setupLinkTab
  button "API explorer"
  button "Log"
  tab pane#tab-app-setup
    heading "Setup"
    block #btnSaveSetupChanges
      button "Save"#btnSaveApplicationSettings primary
    label "Account ID" for #DearApi_Index_TenantIDApplication
    input text#DearApi_Index_TenantIDApplication read-only
    label "Name" for #DearApi_Index_Name
    input text#DearApi_Index_Name
    label "Key" for #DearApi_Index_Key
    input text#DearApi_Index_Key read-only
    button #DearApi_Index_Key_Regen
    label "Is active" for #TenantGeneralSettings_Index_EnableChat
    input checkbox#DearApi_Index_Enabled
  tab pane#tab-app-explorer
    heading "API explorer"
    label ""
    slot #Fake_Control_ID6
    label "Select an API version" for #DearApiExplorer_Index_SelectVersion
    select#DearApiExplorer_Index_SelectVersion
    label "Select an endpoint" for #DearApiExplorer_Index_SelectEndpoint
    select#DearApiExplorer_Index_SelectEndpoint
    label "Select a method" for #DearApiExplorer_Index_SelectEndpointMethod
    select#DearApiExplorer_Index_SelectEndpointMethod
    block #DearApi_ParameterList
      slot #vDearApiMethodParams
    button "Execute"#vDearSubmitButton primary
    heading "Link to documentation"
    block #DearApi_Explorer_RequestUrl
      slot #RequestdivDearApiExpUrl
    heading "Request"
    block #DearApi_Explorer_RequestText
      slot #RequestdivDearApiExpRequest
    heading "Response"
    block #DearApi_Explorer_ResponseText
      slot #ResponsedivDearApiExpResponse
  tab pane#tab-app-log
    heading "Log"
    input text#divSearchLog name=divSearch placeholder "Type text to search"
    button "Search" primary
    button #divRefreshLog
    button #Grid_gridName_Options
    text "This log only keeps data for 5 days.Please click on the row to see the details."
    slot #DearApiApplication_Index_ContainerLog
tab pane#tab-add-new
  heading "New"
  label "Name" for #DearApi_Index_Name_New
  input text#DearApi_Index_Name_New placeholder "Type name of the new application..."
  block #divCreateNewApplication
    button "Create"#btnCreateNewApplication primary
tab pane#tab-shop-help
  heading "Cin7 Core API setup"
modal#divDearApiRequestResponseDetails medium
  heading #formCaptionLog
  button "×"
  heading "URL"
  slot #DearApi_Index_LogRequestUrlPath
  heading "Request"
  slot #DearApi_Index_LogRequestDetailshCore
  slot #DearApi_Index_LogRequestDetail
  heading "Response"
  slot #DearApi_Index_LogResponseDetail
```

## Components by bundle

What the page code builds and mounts into the layout's slots.

### `ExternalApi2019`

1 grids · 0 standalone fields · 0 windows · 1 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `DearApiApplication_Index_ContainerLog` · store `mainStoreRequests` · placeholder `No API requests found.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Date | `Date` |  | 130 | renderer() |  |
    | Method | `Method` |  | flex 1 | renderer() |  |
    | URL | `Url` |  | flex 3 | renderer() |  |
    | Status | `Code` |  | 100 | renderer() |  |


#### Menus, buttons and other parts

- **text area** · renders into `DearApi_Index_LogResponseDetail` · placeholder `Response` · read-only

