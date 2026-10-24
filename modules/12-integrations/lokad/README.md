# Lokad

The Lokad connector: its settings page, mappings, logs and the endpoints behind them. Part of [Integrations](../README.md).

| | Count |
|---|---:|
| Pages | 1 |
| Data models | 0 (plus [shared](../../00-shared/README.md)) |
| Internal endpoints | 5 (0 write) |
| Public API operations | 0 |

## How to rebuild it

1. **Internal API.** Implement each controller's endpoints with the verbs listed, following the [internal API contract](../../../docs/INTERNAL-API.md): one URL per store for GET/POST/PUT/DELETE, paged reads returning `{root, total}`, saves wrapped as `{ID, HasErrors, Original, Updated}`.
2. **Screens.** Build each route below as a server-rendered shell that loads the shell bundle and the page's own app, opening a record from `#<guid>` once at load ([page model](../../../docs/ARCHITECTURE.md#what-a-page-is)). Every grid, column, field, button and dialog is in [UI.md](UI.md).

## Pages

| Route | Menu label | Title | Bundle | Endpoints (write) |
|---|---|---|---|---:|
| `/Lokad` |  | Lokad | `Lokad2019` | 5 (0) |

## Internal endpoints

Grouped by controller. Effect: 🟢 read · 🟠 read + write at the same URL · 🔴 write. `api` = JSON under `/api/`, `mvc` = controller action.

### Lokad

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/Lokad_Index_vSalesPriceTiers` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |

### QuickLinks

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/QuickLinks_Index_Tooltips/customer` | api | GET | 🟢 read | customerId |  |  |
| `/api/QuickLinks_Index_Tooltips/product` | api | GET | 🟢 read | currentPage customerId locationId productId |  |  |
| `/api/QuickLinks_Index_Tooltips/sections` | api | GET | 🟢 read |  |  |  |
| `/api/QuickLinks_Index_Tooltips/supplier` | api | GET | 🟢 read | supplierId |  |  |
