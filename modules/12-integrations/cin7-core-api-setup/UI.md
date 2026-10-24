# Cin7 Core API setup: UI

Every component the page code builds, read from the shipped ExtJS bundles: grids with their columns, fields, buttons, menus, windows and custom components. Labels are the English UI text. `renders into` is the id of the `<div>` in the page's server-rendered HTML that the component mounts in; `store` names the data store (see the endpoints in [README.md](README.md)); `on click` is the handler. Visual system and shell layout: [docs/UI.md](../../../docs/UI.md).

## Screens

| Route | Title | Bundles |
|---|---|---|
| `/ExternalApi` | Cin7 Core API setup | [`ExternalApi2019`](#externalapi2019) |

## Components by bundle

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

