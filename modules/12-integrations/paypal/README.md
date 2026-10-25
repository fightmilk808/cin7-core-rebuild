# PayPal

The PayPal connector: its settings page, mappings, logs and the endpoints behind them. Part of [Integrations](../README.md).

| 📄 Pages | 🧱 Models | 🔌 Endpoints | ✍️ Can write | 🌍 Public API |
|:-:|:-:|:-:|:-:|:-:|
| **1** | **2** + [shared](../../00-shared/README.md) | **10** | 8 | **0** |

[📄 Pages (1)](#pages) · [🧱 Models (2)](#data-models) · [🔌 Endpoints (10)](#internal-endpoints) · [🖼️ UI](UI.md) · [🗄️ schema.sql](schema.sql)

```mermaid
pie showData title Endpoints by effect
    "read + write" : 4
    "write" : 4
    "read" : 2
```

## How to rebuild it

| # | Build | How |
|:-:|---|---|
| 1 | 🗄️ Schema | 2 tables from [`schema.sql`](schema.sql); GUID ids, join on `*ID` |
| 2 | 🔌 Internal API | Each controller's verbs · [contract](../../../docs/INTERNAL-API.md) · paged `{root, total}` · saves `{ID, HasErrors, Original, Updated}` |
| 3 | 🖥️ Screens | Server-rendered shell + page app, record from `#<guid>` · [page model](../../../docs/ARCHITECTURE.md#what-a-page-is) · every control in [UI.md](UI.md) |

## Pages

| Route | Menu label | Title | Bundle | Endpoints (write) |
|---|---|---|---|---:|
| `/PayPal` |  | PayPal | `PayPal2019` | 7 (8) |

## Data models

ExtJS models the pages use; `v` prefix = view-model. Full DDL in [`schema.sql`](schema.sql).

| Model | Fields |
|---|---|
| `payPalPaymentLogEntry` | Id:string, SaleTaskId:string, Amount:float, AccountCode:string, AccountName:string, Currency:string, SaleInvoiceNumber:string, StatusText:string, PayPalPaymentId:string, IsTestMode:boolean, InitTime:date, LastUpdateTime:date |
| `vAccount` | Code:string, DisplayName:string |

## Internal endpoints

Grouped by controller. Effect: 🟢 read · 🟠 read + write at the same URL · 🔴 write. `api` = JSON under `/api/`, `mvc` = controller action.

### PayPal

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/PayPal/CompletePayment` | mvc |  | 🔴 write |  |  |  |
| `/PayPal/CompleteTestPayment` | mvc |  | 🔴 write |  |  |  |
| `/PayPal/StartPayment` | mvc |  | 🔴 write | doc |  |  |
| `/PayPal/StartTestPayment` | mvc |  | 🔴 write |  |  |  |
| `/api/PayPal_Index` | api |  | 🟠 read + write |  |  |  |
| `/api/PayPal_Index_Config` | api |  | 🟠 read + write |  |  |  |
| `/api/PayPal_Index_Dashboard_Summary` | api | GET | 🟢 read |  |  |  |
| `/api/PayPal_Index_LogEntries` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  | root |
| `/api/PayPal_Index_vAccounts` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/PayPal_PayDoc_Page` | api |  | 🟢 read | doc |  |  |
