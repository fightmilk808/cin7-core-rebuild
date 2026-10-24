# RMA Portal

The RMA Portal connector: its settings page, mappings, logs and the endpoints behind them. Part of [Integrations](../README.md).

| | Count |
|---|---:|
| Pages | 1 |
| Data models | 6 (plus [shared](../../00-shared/README.md)) |
| Internal endpoints | 12 (11 write) |
| Public API operations | 0 |

## How to rebuild it

1. **Schema.** Create one table per data model below (6), starting from the generated [`schema.sql`](schema.sql). Ids are GUIDs; join on the `*ID` fields.
2. **Internal API.** Implement each controller's endpoints with the verbs listed, following the [internal API contract](../../../docs/INTERNAL-API.md): one URL per store for GET/POST/PUT/DELETE, paged reads returning `{root, total}`, saves wrapped as `{ID, HasErrors, Original, Updated}`.
3. **Screens.** Build each route below as a server-rendered shell that loads the shell bundle and the page's own app, opening a record from `#<guid>` once at load ([page model](../../../docs/ARCHITECTURE.md#what-a-page-is)). Every grid, column, field, button and dialog is in [UI.md](UI.md).

## Pages

| Route | Menu label | Title | Bundle | Endpoints (write) |
|---|---|---|---|---:|
| `/RmaPortal` |  | RMA Portal | `RmaPortal2019` | 12 (15) |

## Data models

ExtJS models the pages use; `v` prefix = view-model. Full DDL in [`schema.sql`](schema.sql).

| Model | Fields |
|---|---|
| `vAddress` | AddressID:string, Line1:string, Line2:string |
| `vAppearance` | WebPortalID:string, Name:string, ButtonsBackgroundColor:string, ButtonsColor:string, ContactsTextColor:string, ContentColor:string, ContentLinkColor:string, FooterBackgroundColor:string, FooterLinkColor:string, FooterTextColor:string, HeaderBackgroundColor:string, NavigationTextColor:string, NavigationTextHoverColor:string, PageBackgroundColor:string, PreFooterBackgroundColor:string, PreFooterTextColor:string, PreHeaderBackgroundColor:string, SloganBackgroundColor:string, Status:string |
| `vContact` | ID:string, ECSConfigID:string, ECSName:string, IsOrganization:bool, ContactType:string, Status:string, Tags:string |
| `vPortalEmailTemplate` | WebPortalID:string, Name:string, Content:string, Description:string, Subject:string |
| `vPortalPage` | WebPortalPageID:string, WebPortalID:string, Name:string, LineOrder:string, Content:string, IsActive:string, Type:string |
| `vWebPortal` | WebPortalID:string, Name:string, Type:string, Domain:string, Description:string, IsActive:bool, HorizontalNavbarDataType:string, DefaultCustomer:string, AllowBackorder:bool, ShowAdditionalAttributes:bool, ShowOutOfStockItems:bool, ShowMinimumOrderQuantityForProducts:bool, ShowMaximumOrderQuantityForProducts:bool, FacebookURL:string, GooglePlusURL:string, TwitterURL:string, InstagramURL:string, YouTubeURL:string, LinkedInURL:string, TenantContactID:string, TenantAddressID:string, LocationID:string, ShowImagesInShoppingCart:bool, SalesRepresentative:string, GoogleAnalyticsTrackerID:string, Goog… |

## Internal endpoints

Grouped by controller. Effect: 🟢 read · 🟠 read + write at the same URL · 🔴 write. `api` = JSON under `/api/`, `mvc` = controller action.

### RmaPortal

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/RmaPortal/AddDomain` | mvc | POST | 🔴 write |  |  |  |
| `/RmaPortal/AuthorisePost` | mvc | POST | 🔴 write |  |  |  |
| `/RmaPortal/RemoveCustomDomain` | mvc | DELETE | 🔴 write | id |  |  |
| `/api/RmaPortal_Index_B2BPortalAppearance` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/RmaPortal_Index_ChangePortalDomain` | api | POST | 🔴 write | domainName webPortalID |  |  |
| `/api/RmaPortal_Index_vAddress` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/RmaPortal_Index_vContacts` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/RmaPortal_Index_vEmailTemplates` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | WebPortalID |  |  |
| `/api/RmaPortal_Index_vNavbarItems` | api | POST | 🔴 write |  | List WebPortalID |  |
| `/api/RmaPortal_Index_vPages` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | WebPortalID |  |  |
| `/api/RmaPortal_Index_vSortingOptions` | api | POST | 🔴 write |  | List WebPortalID |  |
| `/api/RmaPortal_Index_vWebPortal` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
