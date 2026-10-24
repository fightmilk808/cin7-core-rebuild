# Google Workspaces

The Google Workspaces connector: its settings page, mappings, logs and the endpoints behind them. Part of [Integrations](../README.md).

| | Count |
|---|---:|
| Pages | 1 |
| Data models | 3 (plus [shared](../../00-shared/README.md)) |
| Internal endpoints | 3 (3 write) |
| Public API operations | 0 |

## How to rebuild it

1. **Schema.** Create one table per data model below (3), starting from the generated [`schema.sql`](schema.sql). Ids are GUIDs; join on the `*ID` fields.
2. **Internal API.** Implement each controller's endpoints with the verbs listed, following the [internal API contract](../../../docs/INTERNAL-API.md): one URL per store for GET/POST/PUT/DELETE, paged reads returning `{root, total}`, saves wrapped as `{ID, HasErrors, Original, Updated}`.
3. **Screens.** Build each route below as a server-rendered shell that loads the shell bundle and the page's own app, opening a record from `#<guid>` once at load ([page model](../../../docs/ARCHITECTURE.md#what-a-page-is)). Every grid, column, field, button and dialog is in [UI.md](UI.md).

## Pages

| Route | Menu label | Title | Bundle | Endpoints (write) |
|---|---|---|---|---:|
| `/GSuites` |  | Google Workspaces | `GSuites2019` | 3 (3) |

## Data models

ExtJS models the pages use; `v` prefix = view-model. Full DDL in [`schema.sql`](schema.sql).

| Model | Fields |
|---|---|
| `ContactInfo` | ContactID:string, ContactTypeName:string, ContactType:string, ContactName:string, IsActive:bool |
| `vGSuiteConfig` | ConfigID:string, HasSyncContacts:bool, HasExportData:bool, GD_DefaultDirID_Printing:string, GD_DefaultDirPath_Printing:string, GD_DefaultDirID_Reporting:string, GD_DefaultDirPath_Reporting:string, NeedsToReconnect:bool, ConnectedGoogleEmail:string, RequiresFolderReselection:bool |
| `vGSuiteLog` | LogID:string, Action:string, Message:string, LogDate:date |

## Internal endpoints

Grouped by controller. Effect: 🟢 read · 🟠 read + write at the same URL · 🔴 write. `api` = JSON under `/api/`, `mvc` = controller action.

### GSuites

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/GSuites_Index_Config` | api | GET REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  | root |
| `/api/GSuites_Index_Contacts` | api | GET REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  | root |
| `/api/GSuites_Index_Logs` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  | root |
