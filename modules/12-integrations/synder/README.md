# Synder

The Synder connector: its settings page, mappings, logs and the endpoints behind them. Part of [Integrations](../README.md).

| | Count |
|---|---:|
| Pages | 1 |
| Data models | 0 (plus [shared](../../00-shared/README.md)) |
| Internal endpoints | 0 (0 write) |
| Public API operations | 0 |

## How to rebuild it

1. **Screens.** Build each route below as a server-rendered shell that loads the shell bundle and the page's own app, opening a record from `#<guid>` once at load ([page model](../../../docs/ARCHITECTURE.md#what-a-page-is)). Its page code builds no ExtJS components; the screen is server-rendered HTML.

## Pages

| Route | Menu label | Title | Bundle | Endpoints (write) |
|---|---|---|---|---:|
| `/Synder` |  | Synder ~ | `` | 0 (0) |
