# StarShipIT

The StarShipIT connector: its settings page, mappings, logs and the endpoints behind them. Part of [Integrations](../README.md).

| | Count |
|---|---:|
| Pages | 1 |
| Data models | 9 (plus [shared](../../00-shared/README.md)) |
| Internal endpoints | 2 (1 write) |
| Public API operations | 0 |

## How to rebuild it

1. **Schema.** Create one table per data model below (9), starting from the generated [`schema.sql`](schema.sql). Ids are GUIDs; join on the `*ID` fields.
2. **Internal API.** Implement each controller's endpoints with the verbs listed, following the [internal API contract](../../../docs/INTERNAL-API.md): one URL per store for GET/POST/PUT/DELETE, paged reads returning `{root, total}`, saves wrapped as `{ID, HasErrors, Original, Updated}`.
3. **Screens.** Build each route below as a server-rendered shell that loads the shell bundle and the page's own app, opening a record from `#<guid>` once at load ([page model](../../../docs/ARCHITECTURE.md#what-a-page-is)). Every grid, column, field, button and dialog is in [UI.md](UI.md).

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
