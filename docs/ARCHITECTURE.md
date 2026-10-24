# Architecture

## Hosts

| Host | What it is |
|---|---|
| `inventory.dearsystems.com` | The main app. ASP.NET MVC renders each page's shell and serves three API surfaces: internal JSON at `/api/*`, controller actions at `/<Controller>/<Action>`, and the public API at `/ExternalApi/v2` (and v1). Signed out, pages 302 to `/Account/Login`; an unknown route 302s to `/Error/NotFound` |
| `corecontent.dearsystems.com` | CDN (Azure Front Door) for static files: page scripts at `/js/<Bundle>_lang_en-us`, shared bundles at `/bundles/*`, CSS at `/css/app_css`. Public, `access-control-allow-origin: *`, 1-hour cache |
| `reporting.dearsystems.com` | The report service ([module 21](../modules/21-report-service/README.md)) |
| `pos.dearsystems.com` | The POS ([module 22](../modules/22-pos/README.md)) |
| `<name>.dearportal.com`, `<name>.dearreturns.com` | B2B and RMA portals, one site per portal ([module 25](../modules/25-portals/README.md)) |
| Handheld apps | WMS (`dear.wms`) and MES (`dear.man`), Cordova + Angular, on `/ExternalApi/system/*` ([23](../modules/23-wms/README.md), [24](../modules/24-mes/README.md)) |
| SignalR hub `messageHub` | Real-time notifications and chat (`/api/updateAzureConnectionId`, `/api/notificationCount`, `/api/MessageChat*`) |
| Third-party on every page | Pendo analytics, Freshworks help widget; reCAPTCHA Enterprise on the production order page |

## Stack

- **Server:** ASP.NET MVC + Web API. Each route returns a server-rendered shell; data moves over JSON.
- **Pages:** ExtJS 4 apps (with jQuery and Bootstrap): `Ext.data.Model` definitions, `JsonStore`s on a `rest` proxy, grids
  and forms. Report pages use DevExpress; the POS uses AngularJS 1.x; the handheld apps use Angular in Cordova.
- **Localisation:** every script is served per language (`_lang_en-us`).

## What a page is

1. A route such as `/ProductionOrder` returns a shell that loads `Main2019` (menu, notifications, session timeout, calendar,
   activity log) and one or more page bundles. Most page bundles are `<Page>2019`; rebuilt pages drop the suffix
   (`ProductionOrder`, `Scheduler`, `CapacityPlanner`, `MRPList`) or carry a newer year (`DocumentExtraction2024`).
   Each module's page table names its bundle.
2. The page builds ExtJS models and stores, then loads them from `/api/…`.
3. A record opens from the URL hash, `/<Page>#<guid>`, read **once** at page load. The tab title stays `<screen> | Cin7 Core`.
4. List pages (`/SaleList`, `/PurchaseList`…) are grids over a paged store; detail pages are tabbed forms over one record
   and its child stores (lines, payments, attachments, history).
5. Document-level operations (void, undo, cancel, print, upload, download, export, import) are controller actions, not
   store saves. A print is a form POST that downloads a file.

## Deep links

| Record | Link |
|---|---|
| Sale (any type) | `/Sale#<id>` (redirects to the right screen, e.g. `/SaleMultiple#…`) |
| Purchase (any type) | `/Purchase#<id>` (redirects to `/PurchaseAdvanced`, `/PurchaseService`, `/DropShipPurchase` or stays) |
| Production order | `/ProductionOrder#<id>` |
| Product, supplier, customer | `/Product#<id>`, `/Supplier#<id>`, `/Customer#<id>` |
| Transfer | `/StockTransfer#<id>` |
| Stocktake or stock adjustment | `/StockTake#<id>` (redirects to `/Stocktake/New#…`) |
| Location | `/TenantLocationEdit#<id>` |
| MRP run | `/MRP#<id>` |

## Ways in

| Surface | Auth | Reaches |
|---|---|---|
| Internal `/api/*` and controller actions | Session cookie from a signed-in browser | Everything the UI shows |
| Public API `/ExternalApi/v2` | `api-auth-accountid` + `api-auth-applicationkey` headers | Master data and documents ([PUBLIC-API.md](PUBLIC-API.md)) |
| Handheld namespace `/ExternalApi/system/*` | Device sign-in returns an application key; public API headers plus user id/name | WMS and MES work |
| POS namespace `/ExternalApi/POS/*` | `POST /PosExternalAuth` | Registers, orders, customers, stock |
| Signed document links (`/Sale/DownloadPickList?tenantID=&saleTaskID=&templateID=&timeStamp=`, `Purchase/Download…`) | The link itself | Sale and purchase PDFs |
| Webhooks | Outbound POST to the subscriber | Status-change events ([module 20](../modules/20-public-api/README.md)) |
| Report service | One-time `requestID` minted by the main app | Report grids and exports |

## Build order

1. **Tenancy, users, roles, page access** ([02](../modules/02-account/README.md), [13](../modules/13-settings/README.md)).
2. **Shared models and reference books**: locations and bins, chart of accounts, tax rules, payment terms, units, categories,
   brands, attribute sets, carriers ([00](../modules/00-shared/README.md), [14](../modules/14-reference-books/README.md)).
3. **Shell**: menu, search, notifications ([01](../modules/01-shell/README.md)).
4. **Inventory master and stock** ([04](../modules/04-inventory/README.md)).
5. **Purchase, Sale, Production** ([05](../modules/05-purchase/README.md), [06](../modules/06-sale/README.md),
   [07](../modules/07-production/README.md)), then **Financials** ([08](../modules/08-financials/README.md)).
6. **Public API and webhooks** over those ([20](../modules/20-public-api/README.md)).
7. **Reports and the report service** ([11](../modules/11-reports/README.md), [21](../modules/21-report-service/README.md)).
8. **CRM, AI, Dashboard** ([09](../modules/09-crm/README.md), [10](../modules/10-ai/README.md), [03](../modules/03-dashboard/README.md)).
9. **Front ends and integrations** ([12](../modules/12-integrations/README.md), [22](../modules/22-pos/README.md)–[25](../modules/25-portals/README.md)).
