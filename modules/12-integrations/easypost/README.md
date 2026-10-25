# EasyPost

The EasyPost connector: its settings page, mappings, logs and the endpoints behind them. Part of [Integrations](../README.md).

| 📄 Pages | 🧱 Models | 🔌 Endpoints | ✍️ Can write | 🌍 Public API |
|:-:|:-:|:-:|:-:|:-:|
| **1** | **5** + [shared](../../00-shared/README.md) | **1** | 1 | **0** |

[📄 Pages (1)](#pages) · [🧱 Models (5)](#data-models) · [🔌 Endpoints (1)](#internal-endpoints) · [🖼️ UI](UI.md) · [🗄️ schema.sql](schema.sql)

## How to rebuild it

| # | Build | How |
|:-:|---|---|
| 1 | 🗄️ Schema | 5 tables from [`schema.sql`](schema.sql); GUID ids, join on `*ID` |
| 2 | 🔌 Internal API | Each controller's verbs · [contract](../../../docs/INTERNAL-API.md) · paged `{root, total}` · saves `{ID, HasErrors, Original, Updated}` |
| 3 | 🖥️ Screens | Server-rendered shell + page app, record from `#<guid>` · [page model](../../../docs/ARCHITECTURE.md#what-a-page-is) · every control in [UI.md](UI.md) |

## Pages

| Route | Menu label | Title | Bundle | Endpoints (write) |
|---|---|---|---|---:|
| `/EasyPost` |  | EasyPost | `EasyPost2019` | 1 (1) |

## Data models

ExtJS models the pages use; `v` prefix = view-model. Full DDL in [`schema.sql`](schema.sql).

| Model | Fields |
|---|---|
| `NameValue` | Name:string, Value:string |
| `ShippingReferenceData` | DefaultDimensionName:string |
| `vSSTenantAddress` | AddressID:string, Line1:string, Line2:string, CitySuburb:string, StateProvince:string, ZipPostCode:string, Country:string, CountryLine:string |
| `vShipServConf` | ID:string, ModuleType:string |
| `vTax` | RuleID:string, Description:string |

## Internal endpoints

Grouped by controller. Effect: 🟢 read · 🟠 read + write at the same URL · 🔴 write. `api` = JSON under `/api/`, `mvc` = controller action.

### EasyPost

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/EasyPost_Index_vShipServConf` | api | GET(read) PUT REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | id |  | Configurations |
