# Cin7 Core API setup

The Cin7 Core API setup connector: its settings page, mappings, logs and the endpoints behind them. Part of [Integrations](../README.md).

| | Count |
|---|---:|
| Pages | 1 |
| Data models | 4 (plus [shared](../../00-shared/README.md)) |
| Internal endpoints | 6 (1 write) |
| Public API operations | 0 |

## How to rebuild it

1. **Schema.** Create one table per data model below (4), starting from the generated [`schema.sql`](schema.sql). Ids are GUIDs; join on the `*ID` fields.
2. **Internal API.** Implement each controller's endpoints with the verbs listed, following the [internal API contract](../../../docs/INTERNAL-API.md): one URL per store for GET/POST/PUT/DELETE, paged reads returning `{root, total}`, saves wrapped as `{ID, HasErrors, Original, Updated}`.
3. **Screens.** Build each route below as a server-rendered shell that loads the shell bundle and the page's own app, opening a record from `#<guid>` once at load ([page model](../../../docs/ARCHITECTURE.md#what-a-page-is)). Every grid, column, field, button and dialog is in [UI.md](UI.md).

## Pages

| Route | Menu label | Title | Bundle | Endpoints (write) |
|---|---|---|---|---:|
| `/ExternalApi` |  | Cin7 Core API setup | `ExternalApi2019` | 7 (3) |

## Data models

ExtJS models the pages use; `v` prefix = view-model. Full DDL in [`schema.sql`](schema.sql).

| Model | Fields |
|---|---|
| `vDearApiEndpoint` | Name:string, Path:string |
| `vDearApiEndpointMethod` | Name:string, Url:string |
| `vDearApiEndpointMethodParam` | Name:string, Type:string, Required:string, Value:string, ToolTip:string |
| `vDearApiRequests` | ID:string, Date:date, ApplicationKey:string, Url:string, Request:string, Response:string, Code:int, Comments:string, Method:string, ApplicationName:string |

## Internal endpoints

Grouped by controller. Effect: 🟢 read · 🟠 read + write at the same URL · 🔴 write. `api` = JSON under `/api/`, `mvc` = controller action.

### DearApi

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/DearApi_Index_Dashboard_Summary` | api | GET | 🟢 read |  |  |  |
| `/api/DearApi_Index_vApplicationNG` | api | GET PUT | 🟠 read + write |  |  |  |
| `/api/DearApi_Index_vDearApiRequestsNG` | api | GET REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ID appId search |  | root |
| `/api/DearApi_Index_vEndpointActionParams` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | action apiVersion endpoint |  | root |
| `/api/DearApi_Index_vEndpointActions` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | apiVersion endpoint |  | root |
| `/api/DearApi_Index_vEndpoints` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | apiVersion |  | root |
