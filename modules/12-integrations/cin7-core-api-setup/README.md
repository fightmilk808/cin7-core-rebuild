# Cin7 Core API setup

The Cin7 Core API setup connector: its settings page, mappings, logs and the endpoints behind them. Part of [Integrations](../README.md).

| 📄 Pages | 🧱 Models | 🔌 Endpoints | ✍️ Can write | 🌍 Public API |
|:-:|:-:|:-:|:-:|:-:|
| **1** | **4** + [shared](../../00-shared/README.md) | **6** | 1 | **0** |

[📄 Pages (1)](#pages) · [🧱 Models (4)](#data-models) · [🔌 Endpoints (6)](#internal-endpoints) · [🖼️ UI](UI.md) · [🗄️ schema.sql](schema.sql)

```mermaid
pie showData title Endpoints by effect
    "read" : 5
    "read + write" : 1
```

## How to rebuild it

| # | Build | How |
|:-:|---|---|
| 1 | 🗄️ Schema | 4 tables from [`schema.sql`](schema.sql); GUID ids, join on `*ID` |
| 2 | 🔌 Internal API | Each controller's verbs · [contract](../../../docs/INTERNAL-API.md) · paged `{root, total}` · saves `{ID, HasErrors, Original, Updated}` |
| 3 | 🖥️ Screens | Server-rendered shell + page app, record from `#<guid>` · [page model](../../../docs/ARCHITECTURE.md#what-a-page-is) · every control in [UI.md](UI.md) |

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
