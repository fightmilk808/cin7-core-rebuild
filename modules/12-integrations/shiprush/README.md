# ShipRush

The ShipRush connector: its settings page, mappings, logs and the endpoints behind them. Part of [Integrations](../README.md).

| 📄 Pages | 🧱 Models | 🔌 Endpoints | ✍️ Can write | 🌍 Public API |
|:-:|:-:|:-:|:-:|:-:|
| **1** | **8** + [shared](../../00-shared/README.md) | **2** | 1 | **0** |

[📄 Pages (1)](#pages) · [🧱 Models (8)](#data-models) · [🔌 Endpoints (2)](#internal-endpoints) · [🖼️ UI](UI.md) · [🗄️ schema.sql](schema.sql)

## How to rebuild it

| # | Build | How |
|:-:|---|---|
| 1 | 🗄️ Schema | 8 tables from [`schema.sql`](schema.sql); GUID ids, join on `*ID` |
| 2 | 🔌 Internal API | Each controller's verbs · [contract](../../../docs/INTERNAL-API.md) · paged `{root, total}` · saves `{ID, HasErrors, Original, Updated}` |
| 3 | 🖥️ Screens | Server-rendered shell + page app, record from `#<guid>` · [page model](../../../docs/ARCHITECTURE.md#what-a-page-is) · every control in [UI.md](UI.md) |

## Pages

| Route | Menu label | Title | Bundle | Endpoints (write) |
|---|---|---|---|---:|
| `/ShipRush` |  | ShipRush | `ShipRush2019` | 2 (1) |

## Data models

ExtJS models the pages use; `v` prefix = view-model. Full DDL in [`schema.sql`](schema.sql).

| Model | Fields |
|---|---|
| `EnumNameValue` | name:string, value:number |
| `NameValue` | Name:string, Value:string |
| `ShippingReferenceData` | DefaultDimensionName:string |
| `vCarrierList` | value:string, name:string |
| `vCarrierServiceList` | FakeID:string, CarrierCode:string, ServiceCode:string, Highlighted:bool, DisplayName:string, CarrierServiceCode:string, Domestic:bool, International:bool |
| `vSSTenantAddress` | AddressID:string, Line1:string, Line2:string, CitySuburb:string, StateProvince:string, ZipPostCode:string, Country:string, CountryLine:string |
| `vShipServConf` | ID:string, ModuleType:string |
| `vTax` | RuleID:string, Description:string |

## Internal endpoints

Grouped by controller. Effect: 🟢 read · 🟠 read + write at the same URL · 🔴 write. `api` = JSON under `/api/`, `mvc` = controller action.

### Sale

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/Sale_Index_LookupCarrier` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ShippingServiceID carrierCode jsonData serviceCode shippingServiceID |  |  |

### ShipRush

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/ShipRush_Index_vShipServConf` | api | GET(read) PUT REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | id |  | Configurations |
