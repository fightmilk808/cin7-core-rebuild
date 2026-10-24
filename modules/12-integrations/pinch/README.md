# Pinch

The Pinch connector: its settings page, mappings, logs and the endpoints behind them. Part of [Integrations](../README.md).

| | Count |
|---|---:|
| Pages | 1 |
| Data models | 2 (plus [shared](../../00-shared/README.md)) |
| Internal endpoints | 9 (6 write) |
| Public API operations | 0 |

## How to rebuild it

1. **Schema.** Create one table per data model below (2), starting from the generated [`schema.sql`](schema.sql). Ids are GUIDs; join on the `*ID` fields.
2. **Internal API.** Implement each controller's endpoints with the verbs listed, following the [internal API contract](../../../docs/INTERNAL-API.md): one URL per store for GET/POST/PUT/DELETE, paged reads returning `{root, total}`, saves wrapped as `{ID, HasErrors, Original, Updated}`.
3. **Screens.** Build each route below as a server-rendered shell that loads the shell bundle and the page's own app, opening a record from `#<guid>` once at load ([page model](../../../docs/ARCHITECTURE.md#what-a-page-is)). Every grid, column, field, button and dialog is in [UI.md](UI.md).

## Pages

| Route | Menu label | Title | Bundle | Endpoints (write) |
|---|---|---|---|---:|
| `/Pinch` |  | Pinch | `Pinch` | 4 (6) |

## Data models

ExtJS models the pages use; `v` prefix = view-model. Full DDL in [`schema.sql`](schema.sql).

| Model | Fields |
|---|---|
| `PinchPaymentLogEntry` | Id:string, SaleTaskID:string, PaymentId:string, Amount:float, AccountCode:string, AccountName:string, Currency:string, SaleInvoiceNumber:string, Status:string, PaymentStatus:string, TransID:string, ClientTransID:string, IsTestMode:boolean, Created:date, LastUpdateTime:date |
| `vAccount` | Code:string, DisplayName:string |

## Internal endpoints

Grouped by controller. Effect: 🟢 read · 🟠 read + write at the same URL · 🔴 write. `api` = JSON under `/api/`, `mvc` = controller action.

### Pinch

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/Pinch/CompletePaymentToKen` | mvc | POST | 🔴 write |  |  |  |
| `/Pinch/Connect` | mvc | POST | 🔴 write |  |  |  |
| `/Pinch/Disconnect` | mvc | POST | 🔴 write |  |  |  |
| `/Pinch/Pay` | mvc |  | 🔴 write | doc |  |  |
| `/Pinch/SaveSettings` | mvc | POST | 🔴 write |  |  |  |
| `/api/Pinch_Index_Dashboard_Summary` | api | GET | 🟢 read |  |  |  |
| `/api/Pinch_Index_LogEntries` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  | root |
| `/api/Pinch_Index_vAccounts` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Pinch_PayDoc_Page` | api |  | 🟢 read | doc |  |  |
