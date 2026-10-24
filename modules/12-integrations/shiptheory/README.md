# Shiptheory

The Shiptheory connector: its settings page, mappings, logs and the endpoints behind them. Part of [Integrations](../README.md).

| | Count |
|---|---:|
| Pages | 1 |
| Data models | 12 (plus [shared](../../00-shared/README.md)) |
| Internal endpoints | 11 (4 write) |
| Public API operations | 0 |

## How to rebuild it

1. **Schema.** Create one table per data model below (12), starting from the generated [`schema.sql`](schema.sql). Ids are GUIDs; join on the `*ID` fields.
2. **Internal API.** Implement each controller's endpoints with the verbs listed, following the [internal API contract](../../../docs/INTERNAL-API.md): one URL per store for GET/POST/PUT/DELETE, paged reads returning `{root, total}`, saves wrapped as `{ID, HasErrors, Original, Updated}`.
3. **Screens.** Build each route below as a server-rendered shell that loads the shell bundle and the page's own app, opening a record from `#<guid>` once at load ([page model](../../../docs/ARCHITECTURE.md#what-a-page-is)). Every grid, column, field, button and dialog is in [UI.md](UI.md).

## Pages

| Route | Menu label | Title | Bundle | Endpoints (write) |
|---|---|---|---|---:|
| `/Shiptheory` |  | Shiptheory | `Shiptheory2019` | 10 (4) |

## Data models

ExtJS models the pages use; `v` prefix = view-model. Full DDL in [`schema.sql`](schema.sql).

| Model | Fields |
|---|---|
| `ExceptionsList` | Line:int, SupplierName:string, SupplierNameError:string, SupplierReference:string, SupplierReferenceError:string, InvoiceDate:string, InvoiceDateError:string, Amount:string, AmountError:string, CurrencyConversionRate:string, CurrencyConversionRateError:string, ValidationText:string, ValidationState:string |
| `vBulkListingProduct` | ProductID:string, ProductCode:string, Name:string, Status:string, Category:string, Price:float, OrderedQuantity:float, MinimumToOrder:int, MaximumToOrder:int, Quantity:float, MenuItems:string, IsBackorderEnabled:bool |
| `vCarrierList` | value:string, name:string |
| `vCarrierServiceList` | FakeID:string, CarrierCode:string, ServiceCode:string, Highlighted:bool, DisplayName:string, CarrierServiceCode:string, Domestic:bool, International:bool |
| `vCurrency` | Currency:string, DisplayCurrency:string |
| `vExportFilter` | ParameterName:string, Condition:string, Value:string, Join:string, ValidationText:string, ValidationState:string |
| `vExportFilterItem` | Value:string, Name:string |
| `vExportFilterItemGroupped` | Value:string, Name:string, Group:string, IsFirst:bool |
| `vMailingList` | MailingListID:string, Name:string, Emails:string, ValidationText:string, ValidationState:string |
| `vSSExportLog` | ScheduledPeriod:date, OrderNumber:string, FulfillmentNumber:string, InvoiceNumber:string, OrderID:string, FulfillmenID:string, InvoiceID:string, CustomerName:string, ShipByDate:date, Status:string, Comments:string, StatusDate:date |
| `vScheduledExport` | periodBeg:date, periodEnd:date |
| `vShipServConf` | ID:string, ModuleType:string |

## Internal endpoints

Grouped by controller. Effect: 🟢 read · 🟠 read + write at the same URL · 🔴 write. `api` = JSON under `/api/`, `mvc` = controller action.

### Product

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/Product/ExportCommodityDetails` | mvc | GET(navigate) | 🟢 read |  |  |  |
| `/Product/ImportProductCommodityDetails` | mvc | GET(navigate) | 🔴 write | module ref |  |  |
| `/Product/ImportProductCommodityDetailsJson` | mvc | POST | 🔴 write |  |  |  |
| `/api/Product_ImportCommodityDetails_Exceptions` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |

### Shipping

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/Shipping_Index_Family` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Shipping_Index_vBrands` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Shipping_Index_vCategories` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Shipping_Index_vTags` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Shipping_ProductCatalogueList` | api | POST REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | brand category family search tag |  | root |

### Shiptheory

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/Shiptheory_Index_vMailingList` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Shiptheory_Index_vShipServConf` | api | PUT REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
