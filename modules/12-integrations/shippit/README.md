# Shippit

The Shippit connector: its settings page, mappings, logs and the endpoints behind them. Part of [Integrations](../README.md).

| 📄 Pages | 🧱 Models | 🔌 Endpoints | ✍️ Can write | 🌍 Public API |
|:-:|:-:|:-:|:-:|:-:|
| **1** | **6** + [shared](../../00-shared/README.md) | **2** | 1 | **0** |

[📄 Pages (1)](#pages) · [🧱 Models (6)](#data-models) · [🔌 Endpoints (2)](#internal-endpoints) · [🖼️ UI](UI.md) · [🗄️ schema.sql](schema.sql)

## How to rebuild it

| # | Build | How |
|:-:|---|---|
| 1 | 🗄️ Schema | 6 tables from [`schema.sql`](schema.sql); GUID ids, join on `*ID` |
| 2 | 🔌 Internal API | Each controller's verbs · [contract](../../../docs/INTERNAL-API.md) · paged `{root, total}` · saves `{ID, HasErrors, Original, Updated}` |
| 3 | 🖥️ Screens | Server-rendered shell + page app, record from `#<guid>` · [page model](../../../docs/ARCHITECTURE.md#what-a-page-is) · every control in [UI.md](UI.md) |

## Pages

| Route | Menu label | Title | Bundle | Endpoints (write) |
|---|---|---|---|---:|
| `/Shippit` |  | Shippit | `Shippit2019` | 4 (1) |

## Data models

ExtJS models the pages use; `v` prefix = view-model. Full DDL in [`schema.sql`](schema.sql).

| Model | Fields |
|---|---|
| `UserPackage` | id:string, name:string, Weight:number, Width:number, Height:number, Length:number |
| `vCarrierList` | value:string, name:string |
| `vCarrierServiceList` | FakeID:string, CarrierCode:string, ServiceCode:string, Highlighted:bool, DisplayName:string, CarrierServiceCode:string, Domestic:bool, International:bool |
| `vCurrency` | Currency:string, DisplayCurrency:string |
| `vShipServConf` | ID:string, ModuleType:string |
| `vTax` | RuleID:string, Description:string |

## Internal endpoints

Grouped by controller. Effect: 🟢 read · 🟠 read + write at the same URL · 🔴 write. `api` = JSON under `/api/`, `mvc` = controller action.

### Shippit

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/Shippit_Index_vShipServConf` | api | PUT REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | id |  |  |
| `/api/Shippit_Index_vTaxRules` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
