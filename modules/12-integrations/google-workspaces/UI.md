# Google Workspaces: UI

Every component the page code builds, read from the shipped ExtJS bundles: grids with their columns, fields, buttons, menus, windows and custom components. Labels are the English UI text. `renders into` is the id of the `<div>` in the page's server-rendered HTML that the component mounts in; `store` names the data store (see the endpoints in [README.md](README.md)); `on click` is the handler. Visual system and shell layout: [docs/UI.md](../../../docs/UI.md).

## Screens

| Route | Title | Bundles |
|---|---|---|
| `/GSuites` | Google Workspaces | [`GSuites2019`](#gsuites2019) |

## Components by bundle

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

