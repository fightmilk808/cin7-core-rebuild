# Avalara

The Avalara connector: its settings page, mappings, logs and the endpoints behind them. Part of [Integrations](../README.md).

| | Count |
|---|---:|
| Pages | 1 |
| Data models | 8 (plus [shared](../../00-shared/README.md)) |
| Internal endpoints | 15 (7 write) |
| Public API operations | 0 |

## How to rebuild it

1. **Schema.** Create one table per data model below (8), starting from the generated [`schema.sql`](schema.sql). Ids are GUIDs; join on the `*ID` fields.
2. **Internal API.** Implement each controller's endpoints with the verbs listed, following the [internal API contract](../../../docs/INTERNAL-API.md): one URL per store for GET/POST/PUT/DELETE, paged reads returning `{root, total}`, saves wrapped as `{ID, HasErrors, Original, Updated}`.
3. **Screens.** Build each route below as a server-rendered shell that loads the shell bundle and the page's own app, opening a record from `#<guid>` once at load ([page model](../../../docs/ARCHITECTURE.md#what-a-page-is)). Every grid, column, field, button and dialog is in [UI.md](UI.md).

## Pages

| Route | Menu label | Title | Bundle | Endpoints (write) |
|---|---|---|---|---:|
| `/Avalara` |  | Avalara | `Avalara2019` | 12 (7) |

## Data models

ExtJS models the pages use; `v` prefix = view-model. Full DDL in [`schema.sql`](schema.sql).

| Model | Fields |
|---|---|
| `AvalaraCompany` | CompanyCode:string, Name:string |
| `AvalaraTaxCode` | Code:string, Name:string |
| `vAvalaraCustomerData` | Id:int, CustomerID:string, CustomerName:string, AvalaraCustomerID:int, AvalaraCustomerName:string, IsLinked:boolean, Selected:boolean |
| `vAvalaraCustomerLookup` | CustomerID:string, Name:string, IsDisplay:boolean |
| `vMailingList` | MailingListID:string, Name:string, Emails:string, ValidationText:string, ValidationState:string |
| `vProductTaxCode` | Type:string, ProductID:string, ProductCode:string, ProductName:string, AvalaraTaxCode:string, AvalaraTaxName:string |
| `vSyncEntry` | SaleTaskID:string, Type:string, DateSynchronised:date, DateCreated:date, Status:string, Error:string, SaleOrderNumber:string, InvoiceNumber:string, CreditNoteNumber:string, InvoiceDate:date, SaleOrderDate:date, CustomerID:string, CustomerName:string, ControllerName:string |
| `vTenantAddress` | AddressID:string, Line1:string, Line2:string, CitySuburb:string, StateProvince:string, ZipPostCode:string, Country:string, Type:string, DefaultForType:bool |

## Internal endpoints

Grouped by controller. Effect: 🟢 read · 🟠 read + write at the same URL · 🔴 write. `api` = JSON under `/api/`, `mvc` = controller action.

### Avalara

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/Avalara/CheckAvalaraAddresses` | mvc | POST | 🟢 read |  |  |  |
| `/api/Avalara_Index_CustomerDataList` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  | root |
| `/api/Avalara_Index_CustomerDataList/ApplyLink` | api | POST | 🔴 write |  |  |  |
| `/api/Avalara_Index_CustomerDataList/AutoLinkByCustomerName` | api | POST | 🔴 write |  |  |  |
| `/api/Avalara_Index_CustomerDataList/Customers` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Avalara_Index_CustomerDataList/LoadFromAvalara` | api | POST | 🔴 write |  |  |  |
| `/api/Avalara_Index_LicenseKey` | api | POST | 🔴 write |  |  |  |
| `/api/Avalara_Index_vCompany` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  | root |
| `/api/Avalara_Index_vMailingList` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  | root |
| `/api/Avalara_Index_vProductsTaxCodeList` | api | POST REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  | root |
| `/api/Avalara_Index_vSyncEntries` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  | root |
| `/api/Avalara_Index_vTaxCodeList` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  | root |
| `/api/Avalara_Index_vTaxCodeList/TaxExemptionReason` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Avalara_Index_vTaxCodeList/hasintegration` | api | GET | 🟢 read |  |  |  |

### TenantAddress

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/TenantAddress_Index_vTenantAddress` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
