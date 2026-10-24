# Etsy

The Etsy connector: its settings page, mappings, logs and the endpoints behind them. Part of [Integrations](../README.md).

| | Count |
|---|---:|
| Pages | 1 |
| Data models | 27 (plus [shared](../../00-shared/README.md)) |
| Internal endpoints | 27 (10 write) |
| Public API operations | 0 |

## How to rebuild it

1. **Schema.** Create one table per data model below (27), starting from the generated [`schema.sql`](schema.sql). Ids are GUIDs; join on the `*ID` fields.
2. **Internal API.** Implement each controller's endpoints with the verbs listed, following the [internal API contract](../../../docs/INTERNAL-API.md): one URL per store for GET/POST/PUT/DELETE, paged reads returning `{root, total}`, saves wrapped as `{ID, HasErrors, Original, Updated}`.
3. **Screens.** Build each route below as a server-rendered shell that loads the shell bundle and the page's own app, opening a record from `#<guid>` once at load ([page model](../../../docs/ARCHITECTURE.md#what-a-page-is)). Every grid, column, field, button and dialog is in [UI.md](UI.md).

## Pages

| Route | Menu label | Title | Bundle | Endpoints (write) |
|---|---|---|---|---:|
| `/Etsy` |  | Etsy | `Etsy2019` | 29 (12) |

## Data models

ExtJS models the pages use; `v` prefix = view-model. Full DDL in [`schema.sql`](schema.sql).

| Model | Fields |
|---|---|
| `ConsolidationStore` | type:string, description:string |
| `CtlgFamily` | FamilyID:string, SKU:string, Name:string, Category:string, Brand:string, SKUCount:float, Option1Name:string, Option2Name:string, Option3Name:string, Option1Values:string, Option2Values:string, Option3Values:string, ImageID:string, ShortDescription:string, Tags:string |
| `CtlgProduct` | ProductID:string, ProductCode:string, Name:string, Available:float, OnHand:float, ImageID:string, IsStockProduct:bool |
| `ECommerceShop` | ConfigID:string, ShopName:string |
| `EtsyPublishingFailed` | ProductID:string, ProfileName:string, SKU:string, Name:string, Result:string, ImageID:string, ProductType:string |
| `EtsyPublishingNotListed` | ProductID:string, SKU:string, Type:string, ProductType:string, Name:string, Category:string, Brand:string, Price:float, Quantity:float, Status:string, LProfile:string, ItemID:string, Selected:bool, ImageID:string, FamilyID:string, ValidationText:string, ValidationState:string |
| `IdNameModel` | id:string, name:string |
| `TopicStore` | type:string, description:string |
| `vAccount` | Code:string, DisplayName:string |
| `vECSOrderLog` | LogID:string, ConfigID:string, Date:date, DownloadDate:date, ProcessDate:date, OrderNumber:string, SaleTaskID:string, Status:string, Type:string, SaleOrderNumber:string, RefundID:string, OrderID:string, IsNewSale:bool |
| `vECSPendingOrdersNew` | OrderLineID:string, OrderNumber:string, DateCreated:date, Name:string, Quantity:float, Total:float, CustomerName:string, Error:string, ValidationText:string, ValidationState:string |
| `vEcsCatalogItemNew` | SIMID:string, ProductID:string, FamilyID:string, EntityType:string, LinkedSKU:string, LinkedName:string, SKU:string, Name:string, Status:string, ImageID:string, SyncStockLevel:bool, Price:float, Category:string, Option1:string, Option2:string, Option3:string, IsStockProduct:bool, IgnoreProductUpdation:bool, Quantity:float |
| `vEcsConfiguration` | ID:string, TenantID:string, ShopName:string, AccessToken:string, RefreshToken:string, PrimaryPriceTier:int, ConsolidationType:string, ConsolidationTimeText:string, ConsolidateToCustomerID:string, IsActive:bool, PickWhenOrderStatus:string, ShippingTaxed:bool, SyncStockLevel:bool, ExportShippingInformation:bool, AutoInvoicingMode:string, AutoFulfilmentMode:string, ECSspecificParameter1:bool, ECSspecificParameter9:string, ECSspecificParameter8:string, ECSspecificParameter6:bool, ECSspecificParameter10:string, CustomerName:string, ECSTokenType:string, RevenueAccount:string, MoneySettlementBankAcc… |
| `vEcsOperationLog` | ID:string, ConfigID:string, Date:date, Description:string, Category:string, Processed:bool, Type:int, UserName:string, ConfigName:string, ConfigType:string, Disabled:bool |
| `vEcsOverviewCustomersList` | CustomerID:string, Name:string, OrderCount:int, PaidTotalAmount:decimal, ConfigID:string |
| `vEcsOverviewSalesList` | SaleOrderDate:date, SaleOrderNumber:string, CustomerName:string, Status:string, PaidTotalAmount:decimal, InvoicingStatus:string, OrderStatus:string, FulFilmentStatus:string, PaymentStatus:string, TaskID:string, TT:int, ConfigID:string |
| `vEcsPaymentProcessorMapping` | ID:string, ConfigID:string, PaymentProcessorID:string, PaymentProcessorName:string, LedgerAccount:string, AccountName:string, SortOrder:string |
| `vEcsProductVariation` | SIMID:string, SKU:string, Name:string, Category:string, Option1:string, Option2:string, Option3:string, Status:string, CustomField1:string, CustomField2:string, CustomField3:string, CustomField4:string, CustomField5:string, CustomField6:string, CustomField7:string, CustomField8:string, CustomField9:string, CustomField10:string, Price:float, SIMFamilyID:string, ProductID:string, LinkedName:string, LinkedSKU:string, ImageID:string, ValidationText:string, MaxRows:int |
| `vEcsTaxMapping` | ID:string, ECSConfigID:string, ECSTaxType:string, ECSTaxID:string, Description:string, Value:string, TaxRuleName:string, SortOrder:int |
| `vEtsyLanguage` | Code:string, description:string |
| `vListingProfile` | id:string, Name:string, ShippingProfileID:string, ShippingProfileName:string, ReadinessStateId:auto |
| `vLocation` | LocationID:string, Description:string |
| `vProductVariation` | ProductID:string, FamilyID:string, ProductCode:string, ImageID:string, Name:string, Option1:string, Option2:string, Option3:string |
| `vReadinessState` | Id:auto, Title:string, ReadinessState:string, DisplayTitle:string |
| `vShippingTemplate` | Id:string, Title:string |
| `vTax` | RuleID:string, Description:string |
| `vTime` | Value:string, Name:string |

## Internal endpoints

Grouped by controller. Effect: 🟢 read · 🟠 read + write at the same URL · 🔴 write. `api` = JSON under `/api/`, `mvc` = controller action.

### Etsy

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/Etsy/ChangeMappingAndSyncStock` | mvc | POST | 🔴 write | ConfigID IgnoreProductUpdation ProductID SIMProductID SyncStockLevel |  |  |
| `/api/Etsy_Index_CheckFamily` | api | GET PUT | 🟠 read + write |  |  |  |
| `/api/Etsy_Index_CheckProduct` | api | GET PUT | 🟠 read + write | ConfigID |  |  |
| `/api/Etsy_Index_Dashboard_Summary` | api | GET | 🟢 read |  |  |  |
| `/api/Etsy_Index_Family` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ConfigID CurrentFamilyID lang |  |  |
| `/api/Etsy_Index_Product` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ConfigID IsStockProduct Name lang |  |  |
| `/api/Etsy_Index_PublishingFailed` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ConfigID lang search |  | root |
| `/api/Etsy_Index_PublishingNotListed` | api | PUT REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID lang search |  | root |
| `/api/Etsy_Index_PublishingProfiles` | api | PUT REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID | IsSupply Name NonTaxable ReadinessStateId ShippingProfileID ShippingProfileName TaxonomyCategoryName TaxonomyID When Who | root |
| `/api/Etsy_Index_vAccounts` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Etsy_Index_vCustomer` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Etsy_Index_vEcsConfiguration` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/Etsy_Index_vEcsLogs` | api | DELETE REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID search |  | root |
| `/api/Etsy_Index_vEcsPaymentProcessorMapping` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID Update |  |  |
| `/api/Etsy_Index_vEcsProductList` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ConfigID lang mode search status |  | root |
| `/api/Etsy_Index_vEcsTaxMapping` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID |  |  |
| `/api/Etsy_Index_vEcsVariationList` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ConfigID SIMFamilyID ScanFamilyID |  | root |
| `/api/Etsy_Index_vEcsVariationManual` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ConfigID FamilyID SIMFamilyID additionalSKUs search |  | root |
| `/api/Etsy_Index_vEtsyOverviewCustomersList` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ConfigID search |  | root |
| `/api/Etsy_Index_vEtsyOverviewSalesList` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ConfigID search |  | root |
| `/api/Etsy_Index_vEtsyPendingOrders` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ConfigID search |  | root |
| `/api/Etsy_Index_vLocation` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Etsy_Index_vOperationLogs` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID search |  | root |
| `/api/Etsy_Index_vReferenceDataForPublishing` | api | GET | 🟢 read | ConfigID |  |  |
| `/api/Etsy_Index_vRevenueAccounts` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Etsy_Index_vSalesPriceTiers` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Etsy_Index_vTaxRules` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
