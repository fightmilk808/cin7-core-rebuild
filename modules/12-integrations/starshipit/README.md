# StarShipIT

The StarShipIT connector: its settings page, mappings, logs and the endpoints behind them. Part of [Integrations](../README.md).

| 📄 Pages | 🧱 Models | 🔌 Endpoints | ✍️ Can write | 🌍 Public API |
|:-:|:-:|:-:|:-:|:-:|
| **1** | **9** + [shared](../../00-shared/README.md) | **2** | 1 | **0** |

[📄 Pages (1)](#pages) · [🧱 Models (9)](#data-models) · [🔌 Endpoints (2)](#internal-endpoints) · [🖼️ UI](UI.md) · [🗄️ schema.sql](schema.sql)

## How to rebuild it

| # | Build | How |
|:-:|---|---|
| 1 | 🗄️ Schema | 9 tables from [`schema.sql`](schema.sql); GUID ids, join on `*ID` |
| 2 | 🔌 Internal API | Each controller's verbs · [contract](../../../docs/INTERNAL-API.md) · paged `{root, total}` · saves `{ID, HasErrors, Original, Updated}` |
| 3 | 🖥️ Screens | Server-rendered shell + page app, record from `#<guid>` · [page model](../../../docs/ARCHITECTURE.md#what-a-page-is) · every control in [UI.md](UI.md) |

## Pages

| Route | Menu label | Title | Bundle | Endpoints (write) |
|---|---|---|---|---:|
| `/StarShipIt` |  | StarShipIT | `StarShipIt2019` | 7 (1) |

## Data models

ExtJS models the pages use; `v` prefix = view-model. Full DDL in [`schema.sql`](schema.sql).

| Model | Fields |
|---|---|
| `UserPackage` | id:string, name:string, Weight:number, Width:number, Height:number, Length:number |
| `vCurrency` | Currency:string, DisplayCurrency:string |
| `vDimensionUnit` | Code:string, Name:string |
| `vMarginTax` | Code:boolean, Name:string |
| `vSendNotificationOnLabelGeneration` | Code:boolean, Name:string |
| `vShipServConf` | ID:string, ModuleType:string |
| `vTax` | RuleID:string, Description:string |
| `vUseCustomerTax` | Code:boolean, Name:string |
| `vWeightUnit` | Code:string, Name:string |

## Internal endpoints

Grouped by controller. Effect: 🟢 read · 🟠 read + write at the same URL · 🔴 write. `api` = JSON under `/api/`, `mvc` = controller action.

### StarShipIt

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/StarShipIt_Index_vShipServConf` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/StarShipIt_Index_vTaxRules` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
