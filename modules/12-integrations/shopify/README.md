# Shopify

The Shopify connector: its settings page, mappings, logs and the endpoints behind them. Part of [Integrations](../README.md).

| | Count |
|---|---:|
| Pages | 1 |
| Data models | 22 (plus [shared](../../00-shared/README.md)) |
| Internal endpoints | 32 (10 write) |
| Public API operations | 0 |

## How to rebuild it

1. **Schema.** Create one table per data model below (22), starting from the generated [`schema.sql`](schema.sql). Ids are GUIDs; join on the `*ID` fields.
2. **Internal API.** Implement each controller's endpoints with the verbs listed, following the [internal API contract](../../../docs/INTERNAL-API.md): one URL per store for GET/POST/PUT/DELETE, paged reads returning `{root, total}`, saves wrapped as `{ID, HasErrors, Original, Updated}`.
3. **Screens.** Build each route below as a server-rendered shell that loads the shell bundle and the page's own app, opening a record from `#<guid>` once at load ([page model](../../../docs/ARCHITECTURE.md#what-a-page-is)). Every grid, column, field, button and dialog is in [UI.md](UI.md).

## Pages

| Route | Menu label | Title | Bundle | Endpoints (write) |
|---|---|---|---|---:|
| `/Shopify` |  | Shopify | `Shopify2019` | 32 (12) |

## Data models

ExtJS models the pages use; `v` prefix = view-model. Full DDL in [`schema.sql`](schema.sql).

| Model | Fields |
|---|---|
| `ConsolidationFrequencyModel` | value:int, description:string |
| `ConsolidationTypeModel` | value:string, text:string |
| `ECommerceShop` | ConfigID:string, ShopName:string |
| `MasterDataSource` | name:string, value:string |
| `PaymentReferenceStore` | type:string, description:string |
| `TopicStore` | type:string, description:string |
| `stateList` | Code:string, Value:string |
| `vAccount` | Code:string, DisplayName:string |
| `vLocation` | LocationID:string, Description:string |
| `vReportLayout` | Fakeid:string, ReportName:string, LayoutName:string, Layout:string |
| `vSaleAttribute` | Id:int, Name:string, Type:string |
| `vShopifyCatalogBulkListing` | ProductID:string, ProductCode:string, Name:string, Status:string, Available:int, CategoryName:string, PriceTear1:decimal, PriceTear2:decimal, PriceTear3:decimal, PriceTear4:decimal, PriceTear5:decimal, PriceTear6:decimal, PriceTear7:decimal, PriceTear8:decimal, PriceTear9:decimal, PriceTear10:decimal, SellOutOfStock:bool, UseBufferInventory:bool, BufferInventory:int, SyncBufferInventory:int, SyncQuantity:float, IsLinkToKitProduct:bool |
| `vShopifyCatalogList` | ProductID:string, ProductCode:string, Name:string, Status:string, PriceTier:int, Available:int, PriceTear1:float, PriceTear2:float, PriceTear3:float, PriceTear4:float, PriceTear5:float, PriceTear6:float, PriceTear7:float, PriceTear8:float, PriceTear9:float, PriceTear10:float, SellOutOfStock:bool, UseBufferInventory:bool, BufferInventory:int, SyncBufferInventory:int, SyncQuantity:float, IsLinkToKitProduct:bool |
| `vShopifyConfiguration` | ConfigID:string, TenantID:string, ShopName:string, AccessToken:string, LastCheck:date, IsActive:bool, ConsolidationType:string, ConsolidationTimeText:string, ConsolidateToCustomerID:string, CustomerName:string, Topic:string, ShippingTaxed:bool, SyncStockLevel:bool, ListAsDraft:bool, AllowDuplicateNames:bool, UseCompanyAsCustomer:bool, AddCompanyToAddresses:bool, UploadFulfilmentWithoutTrackingNumber:bool, SellOutOfStock:bool, BringDiscountCodes:bool, AutoShippingMode:string, InvoiceStatus:string, LiabilityAccount:string, RevenueAccount:string, CustomSalesRepresentative:string, PriceTier:int, … |
| `vShopifyLocation` | ID:string, ConfigID:string, ShopifyLocationName:string, ShopifyLocationID:int, IsFulfillmentLocation:bool, IsActive:bool, LocationID:string, LocationName:string, IsSelected:bool |
| `vShopifyLog` | LogID:string, ConfigID:string, Date:date, DownloadDate:date, ProcessDate:date, OrderNumber:string, SaleTaskID:string, InventoryTaskID:string, Status:string, Type:string, FulfillmentNumber:number, SaleOrderNumber:string, StocktakeNumber:string, TT:number |
| `vShopifyOperationLog` | ID:string, ConfigID:string, Date:date, Description:string, Category:string, Processed:bool, Type:int, UserName:string, TT:int |
| `vShopifyPaymentProcessorMapping` | ID:string, ConfigID:string, PaymentProcessor:string, AccountCode:string, SortOrder:int, AccountName:string |
| `vShopifyPendingOrders` | OrderLineID:string, OrderNumber:string, InvoiceDate:date, Name:string, Quantity:float, Total:float, Contact:string, Error:string, ValidationText:string, ValidationState:string |
| `vShopifyTaxMapping` | ID:string, ConfigID:string, Country:string, Province:string, Name:string, Value:string, SortOrder:int, TaxRuleName:string |
| `vTax` | RuleID:string, Description:string |
| `vTime` | Value:string, Name:string |

## Internal endpoints

Grouped by controller. Effect: 🟢 read · 🟠 read + write at the same URL · 🔴 write. `api` = JSON under `/api/`, `mvc` = controller action.

### Report

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/Report/DeleteLayout` | mvc | DELETE | 🔴 write | LayoutName ReportName |  |  |
| `/Report/DeleteLayoutNew` | mvc |  | 🔴 write | layoutName reportTypeId |  |  |
| `/api/Report_v` | api |  | 🟢 read |  |  |  |
| `/api/Report_vReportLayout` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ReportName |  |  |

### Shopify

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/Shopify/GetFeatureFlags` | mvc | GET | 🟢 read |  |  |  |
| `/api/Shopify_Chart_Sales` | api | GET | 🟢 read |  |  |  |
| `/api/Shopify_Index_BulkList` | api | DELETE PUT REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | Category ConfigID Family Tag brandID listStatus listedInConfigID search |  | root |
| `/api/Shopify_Index_Dashboard_Summary` | api | GET | 🟢 read |  |  |  |
| `/api/Shopify_Index_Family` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Shopify_Index_LocationMapping` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID Update |  |  |
| `/api/Shopify_Index_LocationMapping_Locations` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Shopify_Index_Locations` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Shopify_Index_Tags` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Shopify_Index_vAccounts` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Shopify_Index_vCategory` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Shopify_Index_vCustomer` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Shopify_Index_vLiabilityAccounts` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Shopify_Index_vMasterDataSource` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Shopify_Index_vRetailDeliveryFeeAccounts` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Shopify_Index_vRevenueAccounts` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Shopify_Index_vSaleAttributes` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Shopify_Index_vSalesPriceTiers` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Shopify_Index_vShopifyCatalog` | api | GET | 🟢 read | BufferInventory ConfigID ListAsDraft Locations Operation PriceTier ProductID SellOutOfStock UseBufferInventory |  |  |
| `/api/Shopify_Index_vShopifyCatalogList` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ConfigID search |  | root |
| `/api/Shopify_Index_vShopifyConfiguration` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/Shopify_Index_vShopifyLogs` | api | DELETE REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID dateColumn fromDate search status toDate typeFilter |  | root |
| `/api/Shopify_Index_vShopifyOperationLogs` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID categoryFilter fromDate search toDate typeFilter |  | root |
| `/api/Shopify_Index_vShopifyPaymentProcessorMapping` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID Update |  |  |
| `/api/Shopify_Index_vShopifyPendingOrders` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  | root |
| `/api/Shopify_Index_vShopifyTaxMapping` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID Update |  |  |
| `/api/Shopify_Index_vTaxRules` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |

### USState

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/USState` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
