# Shared integration endpoints

Integration endpoints that no single connector page claims (shared by several, or by the catalogue).

| 📄 Pages | 🧱 Models | 🔌 Endpoints | ✍️ Can write | 🌍 Public API |
|:-:|:-:|:-:|:-:|:-:|
| **0** | **0** + [shared](../../00-shared/README.md) | **1** | 0 | **0** |

[🔌 Endpoints (1)](#internal-endpoints)

## How to rebuild it

| # | Build | How |
|:-:|---|---|
| 1 | 🔌 Internal API | Each controller's verbs · [contract](../../../docs/INTERNAL-API.md) · paged `{root, total}` · saves `{ID, HasErrors, Original, Updated}` |

## Internal endpoints

Grouped by controller. Effect: 🟢 read · 🟠 read + write at the same URL · 🔴 write. `api` = JSON under `/api/`, `mvc` = controller action.

### vCurrentIntegrations

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/vCurrentIntegrations` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
