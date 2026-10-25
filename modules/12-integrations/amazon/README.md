# Amazon

The Amazon connector: its settings page, mappings, logs and the endpoints behind them. Part of [Integrations](../README.md).

| | Count |
|---|---:|
| Pages | 1 |
| Data models | 29 (plus [shared](../../00-shared/README.md)) |
| Internal endpoints | 45 (21 write) |
| Public API operations | 0 |

## How to rebuild it

1. **Schema.** Create one table per data model below (29), starting from the generated [`schema.sql`](schema.sql). Ids are GUIDs; join on the `*ID` fields.
2. **Internal API.** Implement each controller's endpoints with the verbs listed, following the [internal API contract](../../../docs/INTERNAL-API.md): one URL per store for GET/POST/PUT/DELETE, paged reads returning `{root, total}`, saves wrapped as `{ID, HasErrors, Original, Updated}`.
3. **Screens.** Build each route below as a server-rendered shell that loads the shell bundle and the page's own app, opening a record from `#<guid>` once at load ([page model](../../../docs/ARCHITECTURE.md#what-a-page-is)). Every grid, column, field, button and dialog is in [UI.md](UI.md).

## Pages

| Route | Menu label | Title | Bundle | Endpoints (write) |
|---|---|---|---|---:|
| `/Amazon` |  | Amazon | `Amazon2019` | 40 (21) |

## Data models

ExtJS models the pages use; `v` prefix = view-model. Full DDL in [`schema.sql`](schema.sql).

| Model | Fields |
|---|---|
| `AmazonCode` | ECSCarrierCode:string |
| `ConsolidationStore` | type:string, description:string |
| `CtlgFamily` | FamilyID:string, SKU:string, Name:string, Category:string, Brand:string, SKUCount:float, Option1Name:string, Option2Name:string, Option3Name:string, Option1Values:string, Option2Values:string, Option3Values:string, ImageID:string, ShortDescription:string, Tags:string |
| `CtlgProduct` | ProductID:string, ProductCode:string, Name:string, Available:float, OnHand:float, ImageID:string, IsStockProduct:bool |
| `ECommerceShop` | ConfigID:string, ShopName:string |
| `TopicStore` | type:string, description:string |
| `vAccount` | Code:string, DisplayName:string |
| `vAmazonCogs` | EcsManualJournalSetID:string, SKU:string, ProductID:string, ProductName:string, AverageCost:float, SoldQty:float, LastUpdatedDate:date, LastUpdatedBy:string, TotalCost:float |
| `vBankAccount` | AccountCode:string, DisplayName:string |
| `vCountry` | Code:string, configid:string, Name:string, Code2:string |
| `vECSCarrierMapping` | ID:string, ECSConfigID:string, CarrierID:string, ECSCarrierCode:string, Description:string |
| `vECSOrderLog` | LogID:string, ConfigID:string, Date:date, DownloadDate:date, ProcessDate:date, OrderNumber:string, SaleTaskID:string, Status:string, Type:string, SaleOrderNumber:string, RefundID:string, OrderID:string, IsNewSale:bool |
| `vECSPendingOrdersNew` | OrderLineID:string, OrderNumber:string, DateCreated:date, Name:string, Quantity:float, Total:float, CustomerName:string, Error:string, ValidationText:string, ValidationState:string |
| `vEcsCatalogItemNew` | SIMID:string, ProductID:string, FamilyID:string, EntityType:string, LinkedSKU:string, LinkedName:string, SKU:string, Name:string, Status:string, ImageID:string, SyncStockLevel:bool, Price:float, Category:string, Option1:string, Option2:string, Option3:string, IsStockProduct:bool, IgnoreProductUpdation:bool, Quantity:float |
| `vEcsConfiguration` | ID:string, TenantID:string, ShopName:string, AccessToken:string, RefreshToken:string, PrimaryPriceTier:int, ConsolidationType:string, ConsolidationTimeText:string, ConsolidateToCustomerID:string, IsActive:bool, PickWhenOrderStatus:string, ShippingTaxed:bool, SyncStockLevel:bool, ExportShippingInformation:bool, AutoInvoicingMode:string, AutoFulfilmentMode:string, ECSspecificParameter1:bool, ECSspecificParameter9:string, ECSspecificParameter8:string, ECSspecificParameter6:bool, ECSspecificParameter10:string, CustomerName:string, ECSTokenType:string, RevenueAccount:string, MoneySettlementBankAcc… |
| `vEcsManualJournalAccountMapping` | ID:string, EcsConfigID:string, EcsAccountCode:string, EcsAccountType:string, Description:string, Value:string, SortOrder:int, SkipMapping:bool, TaxRuleID:string |
| `vEcsManualJournalSet` | SetID:string, EcsConfigID:string, ActualDate:date, DateStart:date, DateEnd:date, Status:string, IsExportable:bool |
| `vEcsOperationLog` | ID:string, ConfigID:string, Date:date, Description:string, Category:string, Processed:bool, Type:int, UserName:string, ConfigName:string, ConfigType:string, Disabled:bool |
| `vEcsOverviewCustomersList` | CustomerID:string, Name:string, OrderCount:int, PaidTotalAmount:decimal, ConfigID:string |
| `vEcsOverviewSalesList` | SaleOrderDate:date, SaleOrderNumber:string, CustomerName:string, Status:string, PaidTotalAmount:decimal, InvoicingStatus:string, OrderStatus:string, FulFilmentStatus:string, PaymentStatus:string, TaskID:string, TT:int, ConfigID:string |
| `vEcsPaymentProcessorMapping` | ID:string, ConfigID:string, PaymentProcessorID:string, PaymentProcessorName:string, LedgerAccount:string, AccountName:string, SortOrder:string |
| `vEcsProductVariation` | SIMID:string, SKU:string, Name:string, Category:string, Option1:string, Option2:string, Option3:string, Status:string, CustomField1:string, CustomField2:string, CustomField3:string, CustomField4:string, CustomField5:string, CustomField6:string, CustomField7:string, CustomField8:string, CustomField9:string, CustomField10:string, Price:float, SIMFamilyID:string, ProductID:string, LinkedName:string, LinkedSKU:string, ImageID:string, ValidationText:string, MaxRows:int |
| `vEcsTaxMapping` | ID:string, ECSConfigID:string, ECSTaxType:string, ECSTaxID:string, Description:string, Value:string, TaxRuleName:string, SortOrder:int |
| `vLocation` | LocationID:string, Description:string |
| `vManualJournalLine` | EcsManualJournalSetID:string, ID:string, Description:string, Amount:float, Tax:float, AccountCode:string, AccountName:string, TaxRuleID:string, TaxRuleName:string |
| `vMarketplace` | ID:string, Name:string |
| `vProductVariation` | ProductID:string, FamilyID:string, ProductCode:string, ImageID:string, Name:string, Option1:string, Option2:string, Option3:string |
| `vTax` | RuleID:string, Description:string |
| `vTime` | Value:string, Name:string |

## Internal endpoints

Grouped by controller. Effect: 🟢 read · 🟠 read + write at the same URL · 🔴 write. `api` = JSON under `/api/`, `mvc` = controller action.

### Amazon

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/Amazon/ChangeMappingAndSyncStock` | mvc | POST | 🔴 write | ConfigID IgnoreProductUpdation ProductID SIMProductID SyncStockLevel |  |  |
| `/Amazon/CopyCarrierMappings` | mvc | POST | 🔴 write | destinationID sourceID |  |  |
| `/api/Amazon_Index_CheckFamily` | api | GET PUT | 🟠 read + write |  |  |  |
| `/api/Amazon_Index_CheckProduct` | api | GET PUT | 🟠 read + write | ConfigID |  |  |
| `/api/Amazon_Index_ConfirmSettlementXeroSync` | api | POST | 🔴 write |  |  |  |
| `/api/Amazon_Index_Dashboard_Summary` | api | GET | 🟢 read |  |  |  |
| `/api/Amazon_Index_EUCountries` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Amazon_Index_Family` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ConfigID CurrentFamilyID lang |  |  |
| `/api/Amazon_Index_Marketplace` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/Amazon_Index_Product` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ConfigID IsStockProduct Name lang |  |  |
| `/api/Amazon_Index_RecalculateCogs` | api | POST | 🔴 write |  |  |  |
| `/api/Amazon_Index_RecalculateSettlementInvoice` | api | POST | 🔴 write |  |  |  |
| `/api/Amazon_Index_SettlementCogs` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | EcsManualJournalSetID search |  | root |
| `/api/Amazon_Index_SettlementDetails` | api | POST | 🟢 read |  |  |  |
| `/api/Amazon_Index_SettlementLines` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | EcsManualJournalSetID search |  | root |
| `/api/Amazon_Index_vAccountMJMapping` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID Update |  |  |
| `/api/Amazon_Index_vAccounts` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Amazon_Index_vAmazonOverviewCustomersList` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ConfigID search |  | root |
| `/api/Amazon_Index_vAmazonOverviewSalesList` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ConfigID search |  | root |
| `/api/Amazon_Index_vAmazonPendingOrders` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ConfigID search |  | root |
| `/api/Amazon_Index_vAmazonSettlements` | api | DELETE REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID |  | root |
| `/api/Amazon_Index_vBankAccounts` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Amazon_Index_vCustomer` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Amazon_Index_vECSCarrierMapping` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID |  | root |
| `/api/Amazon_Index_vEcsConfiguration` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/Amazon_Index_vEcsLogs` | api | DELETE REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID search |  | root |
| `/api/Amazon_Index_vEcsPaymentProcessorMapping` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID Update |  |  |
| `/api/Amazon_Index_vEcsProductList` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ConfigID lang mode search status |  | root |
| `/api/Amazon_Index_vEcsTaxMapping` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID |  |  |
| `/api/Amazon_Index_vEcsVariationList` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ConfigID SIMFamilyID ScanFamilyID |  | root |
| `/api/Amazon_Index_vEcsVariationManual` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ConfigID FamilyID SIMFamilyID additionalSKUs search |  | root |
| `/api/Amazon_Index_vLocation` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Amazon_Index_vLocationExt` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Amazon_Index_vManualJournalAccounts` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Amazon_Index_vOperLog` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID search |  | root |
| `/api/Amazon_Index_vRevenueAccounts` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Amazon_Index_vSalesPriceTiers` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Amazon_Index_vTax` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/Amazon_Index_vTaxRules` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |

### AmazonBusinessShipping

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/AmazonBusinessShipping/GetBhdrWarningOrDefault` | api | GET | 🟢 read |  |  |  |

### ECommerce

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/ECommerce_Common_BulkListing/product/brands` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/ECommerce_Common_BulkListing/shops` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | currentConfigID |  |  |

### EcsOrderLogExport

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/EcsOrderLogExport` | api | GET | 🟢 read |  |  |  |

### Product

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/Product/GetEcsFamilyImage` | mvc |  | 🟢 read | id |  |  |
| `/Product/GetEcsImage` | mvc |  | 🟢 read | id |  |  |
