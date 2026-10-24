# Shared integration endpoints

Integration endpoints that no single connector page claims (shared by several, or by the catalogue).

| | Count |
|---|---:|
| Pages | 0 |
| Data models | 0 (plus [shared](../../00-shared/README.md)) |
| Internal endpoints | 1 (0 write) |
| Public API operations | 0 |

## How to rebuild it

1. **Internal API.** Implement each controller's endpoints with the verbs listed, following the [internal API contract](../../../docs/INTERNAL-API.md): one URL per store for GET/POST/PUT/DELETE, paged reads returning `{root, total}`, saves wrapped as `{ID, HasErrors, Original, Updated}`.

## Internal endpoints

Grouped by controller. Effect: 🟢 read · 🟠 read + write at the same URL · 🔴 write. `api` = JSON under `/api/`, `mvc` = controller action.

### vCurrentIntegrations

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/vCurrentIntegrations` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
