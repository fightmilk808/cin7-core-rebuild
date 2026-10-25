# Warehouse application configuration

The Warehouse application configuration connector: its settings page, mappings, logs and the endpoints behind them. Part of [Integrations](../README.md).

| 📄 Pages | 🧱 Models | 🔌 Endpoints | ✍️ Can write | 🌍 Public API |
|:-:|:-:|:-:|:-:|:-:|
| **1** | **2** + [shared](../../00-shared/README.md) | **0** | 0 | **0** |

[📄 Pages (1)](#pages) · [🧱 Models (2)](#data-models) · [🖼️ UI](UI.md) · [🗄️ schema.sql](schema.sql)

## How to rebuild it

| # | Build | How |
|:-:|---|---|
| 1 | 🗄️ Schema | 2 tables from [`schema.sql`](schema.sql); GUID ids, join on `*ID` |
| 2 | 🖥️ Screens | Server-rendered shell + page app, record from `#<guid>` · [page model](../../../docs/ARCHITECTURE.md#what-a-page-is) · every control in [UI.md](UI.md) |

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
