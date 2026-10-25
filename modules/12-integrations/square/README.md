# Square

The Square connector: its settings page, mappings, logs and the endpoints behind them. Part of [Integrations](../README.md).

| 📄 Pages | 🧱 Models | 🔌 Endpoints | ✍️ Can write | 🌍 Public API |
|:-:|:-:|:-:|:-:|:-:|
| **1** | **19** + [shared](../../00-shared/README.md) | **27** | 11 | **0** |

[📄 Pages (1)](#pages) · [🧱 Models (19)](#data-models) · [🔌 Endpoints (27)](#internal-endpoints) · [🖼️ UI](UI.md) · [🗄️ schema.sql](schema.sql)

```mermaid
pie showData title Endpoints by effect
    "read" : 16
    "read + write" : 7
    "write" : 4
```

## How to rebuild it

| # | Build | How |
|:-:|---|---|
| 1 | 🗄️ Schema | 19 tables from [`schema.sql`](schema.sql); GUID ids, join on `*ID` |
| 2 | 🔌 Internal API | Each controller's verbs · [contract](../../../docs/INTERNAL-API.md) · paged `{root, total}` · saves `{ID, HasErrors, Original, Updated}` |
| 3 | 🖥️ Screens | Server-rendered shell + page app, record from `#<guid>` · [page model](../../../docs/ARCHITECTURE.md#what-a-page-is) · every control in [UI.md](UI.md) |

## Pages

| Route | Menu label | Title | Bundle | Endpoints (write) |
|---|---|---|---|---:|
| `/Square/Main` |  | Square | `Square2019` | 25 (12) |

## Data models

ExtJS models the pages use; `v` prefix = view-model. Full DDL in [`schema.sql`](schema.sql).

| Model | Fields |
|---|---|
| `ConsolidationStore` | type:string, description:string |
| `ECommerceShop` | ConfigID:string, ShopName:string |
| `EcsProductDetails` | ProductID:string, SyncStockLevel:bool, UseBufferInventory:bool, BufferInventory:int, SyncBufferInventory:int, SyncQuantity:float |
| `IntegrationTypeStore` | value:string, name:string |
| `TopicStore` | type:string, description:string |
| `vAccount` | Code:string, DisplayName:string |
| `vECSOrderLog` | LogID:string, ConfigID:string, Date:date, DownloadDate:date, ProcessDate:date, OrderNumber:string, SaleTaskID:string, Status:string, Type:string, SaleOrderNumber:string, RefundID:string, OrderID:string, IsNewSale:bool |
| `vECSPendingOrders` | OrderLineID:string, InvoiceDate:date, Name:string, Quantity:float, Total:float, Contact:string, Error:string |
| `vECSPendingOrdersNew` | OrderLineID:string, OrderNumber:string, DateCreated:date, Name:string, Quantity:float, Total:float, CustomerName:string, Error:string, ValidationText:string, ValidationState:string |
| `vEcsBulkListing` | ProductID:string, ProductCode:string, Name:string, Status:string, Category:string, ProductType:string, Price:float, Quantity:float, UseBufferInventory:bool, BufferInventory:int, SyncBufferInventory:int, SyncQuantity:float |
| `vEcsConfiguration` | ID:string, TenantID:string, ShopName:string, AccessToken:string, RefreshToken:string, PrimaryPriceTier:int, ConsolidationType:string, ConsolidationTimeText:string, ConsolidateToCustomerID:string, IsActive:bool, PickWhenOrderStatus:string, ShippingTaxed:bool, SyncStockLevel:bool, ExportShippingInformation:bool, AutoInvoicingMode:string, AutoFulfilmentMode:string, ECSspecificParameter1:bool, ECSspecificParameter9:string, ECSspecificParameter8:string, ECSspecificParameter6:bool, ECSspecificParameter10:string, CustomerName:string, ECSTokenType:string, RevenueAccount:string, MoneySettlementBankAcc… |
| `vEcsOperationLog` | ID:string, ConfigID:string, Date:date, Description:string, Category:string, Processed:bool, Type:int, UserName:string, ConfigName:string, ConfigType:string, Disabled:bool |
| `vEcsOverviewCustomersList` | CustomerID:string, Name:string, OrderCount:int, PaidTotalAmount:decimal, ConfigID:string |
| `vEcsOverviewSalesList` | SaleOrderDate:date, SaleOrderNumber:string, CustomerName:string, Status:string, PaidTotalAmount:decimal, InvoicingStatus:string, OrderStatus:string, FulFilmentStatus:string, PaymentStatus:string, TaskID:string, TT:int, ConfigID:string |
| `vEcsPaymentProcessorMapping` | ID:string, ConfigID:string, PaymentProcessorID:string, PaymentProcessorName:string, LedgerAccount:string, AccountName:string, SortOrder:string |
| `vEcsTaxMapping` | ID:string, ECSConfigID:string, ECSTaxType:string, ECSTaxID:string, Description:string, Value:string, TaxRuleName:string, SortOrder:int |
| `vLocation` | LocationID:string, Description:string |
| `vTax` | RuleID:string, Description:string |
| `vTime` | Value:string, Name:string |

## Internal endpoints

Grouped by controller. Effect: 🟢 read · 🟠 read + write at the same URL · 🔴 write. `api` = JSON under `/api/`, `mvc` = controller action.

### Square

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/Square/AddPaymentsShop` | mvc |  | 🔴 write |  |  |  |
| `/Square/ListOrUpdateProduct` | mvc | POST | 🔴 write | ConfigID ProductID SyncStockLevel bufferInventory useBufferInventory |  |  |
| `/Square/Main` | mvc |  | 🟢 read |  |  |  |
| `/Square/RemoveProduct` | mvc | POST | 🔴 write | ConfigID ProductID |  |  |
| `/Square/SaveEcsProductLocally` | mvc | POST | 🔴 write | bufferInventory configID productID syncStockLevel useBufferInventory |  |  |
| `/api/Square_Index_Dashboard_Summary` | api | GET | 🟢 read |  |  |  |
| `/api/Square_Index_EcsBulkList` | api | DELETE REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | Category ConfigID Family Tag brandID lang listStatus listedInConfigID search |  | root |
| `/api/Square_Index_Family` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Square_Index_Tags` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Square_Index_vAccounts` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Square_Index_vCategory` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Square_Index_vCustomer` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Square_Index_vEcsConfiguration` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/Square_Index_vEcsLogs` | api | DELETE REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID search |  | root |
| `/api/Square_Index_vEcsPaymentProcessorMapping` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID Update |  |  |
| `/api/Square_Index_vEcsProduct` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ConfigID ProductID |  |  |
| `/api/Square_Index_vEcsProductList` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID lang search |  | root |
| `/api/Square_Index_vEcsTaxMapping` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID |  |  |
| `/api/Square_Index_vLiabilityAccounts` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Square_Index_vLocation` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Square_Index_vOperationLogs` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID search |  | root |
| `/api/Square_Index_vRevenueAccounts` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Square_Index_vSalesPriceTiers` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Square_Index_vSquareOverviewCustomersList` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ConfigID search |  | root |
| `/api/Square_Index_vSquareOverviewSalesList` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ConfigID search |  | root |
| `/api/Square_Index_vSquarePendingOrders` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ConfigID search |  | root |
| `/api/Square_Index_vTaxRules` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
