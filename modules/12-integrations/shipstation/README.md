# ShipStation

The ShipStation connector: its settings page, mappings, logs and the endpoints behind them. Part of [Integrations](../README.md).

| | Count |
|---|---:|
| Pages | 1 |
| Data models | 37 (plus [shared](../../00-shared/README.md)) |
| Internal endpoints | 34 (16 write) |
| Public API operations | 0 |

## How to rebuild it

1. **Schema.** Create one table per data model below (37), starting from the generated [`schema.sql`](schema.sql). Ids are GUIDs; join on the `*ID` fields.
2. **Internal API.** Implement each controller's endpoints with the verbs listed, following the [internal API contract](../../../docs/INTERNAL-API.md): one URL per store for GET/POST/PUT/DELETE, paged reads returning `{root, total}`, saves wrapped as `{ID, HasErrors, Original, Updated}`.
3. **Screens.** Build each route below as a server-rendered shell that loads the shell bundle and the page's own app, opening a record from `#<guid>` once at load ([page model](../../../docs/ARCHITECTURE.md#what-a-page-is)). Every grid, column, field, button and dialog is in [UI.md](UI.md).

## Pages

| Route | Menu label | Title | Bundle | Endpoints (write) |
|---|---|---|---|---:|
| `/ShipStation/ConfigurationNG` |  | ShipStation | `Shipstation2019` | 36 (18) |

## Data models

ExtJS models the pages use; `v` prefix = view-model. Full DDL in [`schema.sql`](schema.sql).

| Model | Fields |
|---|---|
| `ConsolidationStore` | type:string, description:string |
| `CtlgProduct` | ProductID:string, ProductCode:string, Name:string, Available:float, OnHand:float, ImageID:string, IsStockProduct:bool |
| `ECommerceShop` | ConfigID:string, ShopName:string |
| `TopicStore` | type:string, description:string |
| `USTaxTypeAhead` | ID:string, Description:string, Name:string |
| `vAccount` | Code:string, DisplayName:string |
| `vCarrierList` | value:string, name:string |
| `vCarrierServiceList` | FakeID:string, CarrierCode:string, ServiceCode:string, Highlighted:bool, DisplayName:string, CarrierServiceCode:string, Domestic:bool, International:bool |
| `vCurrency` | Currency:string, DisplayCurrency:string |
| `vCustomIntegration` | ShipstationUseStockLocator:bool, ShipstationExportFFOrders:bool, ShipStationTimezone:string, Enabled:bool, ImportShippingCosts:bool, ApplyTaxOnShippingCost:bool, ShippingCostZeroTaxRule:string, IgnoreBillingContact:bool, CustomStoreCurrency:string |
| `vECSOrderLog` | LogID:string, ConfigID:string, Date:date, DownloadDate:date, ProcessDate:date, OrderNumber:string, SaleTaskID:string, Status:string, Type:string, SaleOrderNumber:string, RefundID:string, OrderID:string, IsNewSale:bool |
| `vECSPendingOrdersNew` | OrderLineID:string, OrderNumber:string, DateCreated:date, Name:string, Quantity:float, Total:float, CustomerName:string, Error:string, ValidationText:string, ValidationState:string |
| `vEcsCatalogItemNew` | SIMID:string, ProductID:string, FamilyID:string, EntityType:string, LinkedSKU:string, LinkedName:string, SKU:string, Name:string, Status:string, ImageID:string, SyncStockLevel:bool, Price:float, Category:string, Option1:string, Option2:string, Option3:string, IsStockProduct:bool, IgnoreProductUpdation:bool, Quantity:float |
| `vEcsConfiguration` | ID:string, TenantID:string, ShopName:string, AccessToken:string, RefreshToken:string, PrimaryPriceTier:int, ConsolidationType:string, ConsolidationTimeText:string, ConsolidateToCustomerID:string, IsActive:bool, PickWhenOrderStatus:string, ShippingTaxed:bool, SyncStockLevel:bool, ExportShippingInformation:bool, AutoInvoicingMode:string, AutoFulfilmentMode:string, ECSspecificParameter1:bool, ECSspecificParameter9:string, ECSspecificParameter8:string, ECSspecificParameter6:bool, ECSspecificParameter10:string, CustomerName:string, ECSTokenType:string, RevenueAccount:string, MoneySettlementBankAcc… |
| `vEcsLocationMapping` | ID:string, ECSConfigID:string, ECSLocationName:string, ECSLocationID:string, LocationID:string, LocationName:string |
| `vEcsOperationLog` | ID:string, ConfigID:string, Date:date, Description:string, Category:string, Processed:bool, Type:int, UserName:string, ConfigName:string, ConfigType:string, Disabled:bool |
| `vEcsOverviewCustomersList` | CustomerID:string, Name:string, OrderCount:int, PaidTotalAmount:decimal, ConfigID:string |
| `vEcsOverviewSalesList` | SaleOrderDate:date, SaleOrderNumber:string, CustomerName:string, Status:string, PaidTotalAmount:decimal, InvoicingStatus:string, OrderStatus:string, FulFilmentStatus:string, PaymentStatus:string, TaskID:string, TT:int, ConfigID:string |
| `vEcsPaymentProcessorMapping` | ID:string, ConfigID:string, PaymentProcessorID:string, PaymentProcessorName:string, LedgerAccount:string, AccountName:string, SortOrder:string |
| `vEcsTaxMapping` | ID:string, ECSConfigID:string, ECSTaxType:string, ECSTaxID:string, Description:string, Value:string, TaxRuleName:string, SortOrder:int |
| `vExportFilter` | ParameterName:string, Condition:string, Value:string, Join:string, ValidationText:string, ValidationState:string |
| `vExportFilterItem` | Value:string, Name:string |
| `vExportFilterItemGroupped` | Value:string, Name:string, Group:string, IsFirst:bool |
| `vLocation` | LocationID:string, Description:string |
| `vMailingList` | MailingListID:string, Name:string, Emails:string, ValidationText:string, ValidationState:string |
| `vPackagesList` | name:string, value:string, Domestic:bool, International:bool |
| `vSSExportLog` | ScheduledPeriod:date, OrderNumber:string, FulfillmentNumber:string, InvoiceNumber:string, OrderID:string, FulfillmenID:string, InvoiceID:string, CustomerName:string, ShipByDate:date, Status:string, Comments:string, StatusDate:date |
| `vSSStoreList` | name:string, value:string |
| `vSSTenantAddress` | AddressID:string, Line1:string, Line2:string, CitySuburb:string, StateProvince:string, ZipPostCode:string, Country:string, CountryLine:string |
| `vScheduledExport` | periodBeg:date, periodEnd:date |
| `vShipIntegrationLocationMapping` | ID:string, ConfigID:string, WarehouseName:string, WarehouseId:string, LocationID:string, LocationName:string, IsActive:bool |
| `vShipServConf` | ID:string, ModuleType:string |
| `vShipstationNotMatchingAddresses` | TaskID:string, InvoiceNumber:string, ShippingAddressLine1:string, ShippingAddressLine2:string, CustomerName:string, CustomerID:string, InvoiceDate:date, ShipmentRequiredByDate:date, Reason:string |
| `vTax` | RuleID:string, Description:string |
| `vTime` | Value:string, Name:string |
| `vUSTaxMapping` | id:int, configid:string, zip:string, city:string, county:string |
| `vWeightUnit` | Code:string, Name:string |

## Internal endpoints

Grouped by controller. Effect: 🟢 read · 🟠 read + write at the same URL · 🔴 write. `api` = JSON under `/api/`, `mvc` = controller action.

### Currency

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/Currency` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |

### Shipstation

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/Shipstation/ChangeMappingAndSyncStock` | mvc | POST | 🔴 write | ConfigID IgnoreProductUpdation ProductID SIMProductID SyncStockLevel |  |  |
| `/api/Shipstation_Ext_CarrierPackage` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ConfigID box carrierCode limit page start |  |  |
| `/api/Shipstation_Index_CheckProduct` | api | GET PUT | 🟠 read + write | ConfigID |  |  |
| `/api/Shipstation_Index_Dashboard_Summary` | api | GET | 🟢 read |  |  |  |
| `/api/Shipstation_Index_Product` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ConfigID IsStockProduct Name lang |  |  |
| `/api/Shipstation_Index_vEcsLocationMapping` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/Shipstation_Index_vEcsProductList` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID lang mode search |  | root |
| `/api/Shipstation_Index_vEcsUSTaxTypeAhead` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Shipstation_Index_vMailingList` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Shipstation_Index_vOperationLogs` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID search |  | root |
| `/api/Shipstation_Index_vShipIntegrationLocationMapping` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID Update |  |  |
| `/api/Shipstation_Index_vShipStationExportOrdersFilterParameter` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Shipstation_Index_vShipstationNotMatchingAddresses` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | search |  | root |
| `/api/Shipstation_Index_vShipstationOverviewCustomersList` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ConfigID search |  | root |
| `/api/Shipstation_Index_vShipstationOverviewSalesList` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ConfigID search |  | root |
| `/api/Shipstation_Index_vShipstationPendingOrders` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | search |  | root |
| `/api/Shipstation_Index_vStore` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ConfigID |  |  |
| `/api/Shipstation_Index_vTax` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/Shipstation_Index_vTenantAddress` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |

### ShipStation

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/ShipStation/ConfigurationNG` | mvc |  | 🟢 read |  |  |  |
| `/api/ShipStation_Index_vAccounts` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/ShipStation_Index_vCustomIntegration` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/ShipStation_Index_vCustomer` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/ShipStation_Index_vEcsConfiguration` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/ShipStation_Index_vEcsLogs` | api | DELETE REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID search |  | root |
| `/api/ShipStation_Index_vEcsPaymentProcessorMapping` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID |  |  |
| `/api/ShipStation_Index_vEcsTaxMapping` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/ShipStation_Index_vLocation` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/ShipStation_Index_vRevenueAccounts` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/ShipStation_Index_vSalesPriceTiers` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/ShipStation_Index_vShipServConf` | api | PUT REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/ShipStation_Index_vTaxRules` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/ShipStation_Index_vZeroTax` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
