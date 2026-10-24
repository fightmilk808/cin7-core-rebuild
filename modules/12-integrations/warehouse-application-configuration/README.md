# Warehouse application configuration

The Warehouse application configuration connector: its settings page, mappings, logs and the endpoints behind them. Part of [Integrations](../README.md).

| | Count |
|---|---:|
| Pages | 1 |
| Data models | 2 (plus [shared](../../00-shared/README.md)) |
| Internal endpoints | 0 (0 write) |
| Public API operations | 0 |

## How to rebuild it

1. **Schema.** Create one table per data model below (2), starting from the generated [`schema.sql`](schema.sql). Ids are GUIDs; join on the `*ID` fields.
2. **Screens.** Build each route below as a server-rendered shell that loads the shell bundle and the page's own app, opening a record from `#<guid>` once at load ([page model](../../../docs/ARCHITECTURE.md#what-a-page-is)). Every grid, column, field, button and dialog is in [UI.md](UI.md).

## Pages

| Route | Menu label | Title | Bundle | Endpoints (write) |
|---|---|---|---|---:|
| `/WarehouseApp` |  | Warehouse application configuration | `WarehouseApp2019` | 3 (4) |

## Data models

ExtJS models the pages use; `v` prefix = view-model. Full DDL in [`schema.sql`](schema.sql).

| Model | Fields |
|---|---|
| `ECommerceShop` | ConfigID:string, ShopName:string |
| `TimeTrackingOptionsStore` | id:number, displayName:string |
