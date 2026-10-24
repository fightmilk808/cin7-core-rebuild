# eBay

The eBay connector: its settings page, mappings, logs and the endpoints behind them. Part of [Integrations](../README.md).

| | Count |
|---|---:|
| Pages | 1 |
| Data models | 31 (plus [shared](../../00-shared/README.md)) |
| Internal endpoints | 34 (11 write) |
| Public API operations | 0 |

## How to rebuild it

1. **Schema.** Create one table per data model below (31), starting from the generated [`schema.sql`](schema.sql). Ids are GUIDs; join on the `*ID` fields.
2. **Internal API.** Implement each controller's endpoints with the verbs listed, following the [internal API contract](../../../docs/INTERNAL-API.md): one URL per store for GET/POST/PUT/DELETE, paged reads returning `{root, total}`, saves wrapped as `{ID, HasErrors, Original, Updated}`.
3. **Screens.** Build each route below as a server-rendered shell that loads the shell bundle and the page's own app, opening a record from `#<guid>` once at load ([page model](../../../docs/ARCHITECTURE.md#what-a-page-is)). Every grid, column, field, button and dialog is in [UI.md](UI.md).

## Pages

| Route | Menu label | Title | Bundle | Endpoints (write) |
|---|---|---|---|---:|
| `/eBayNG` |  | eBay | `eBay2019` | 36 (13) |

## Data models

ExtJS models the pages use; `v` prefix = view-model. Full DDL in [`schema.sql`](schema.sql).

| Model | Fields |
|---|---|
| `ConsolidationStore` | type:string, description:string |
| `CtlgFamily` | FamilyID:string, SKU:string, Name:string, Category:string, Brand:string, SKUCount:float, Option1Name:string, Option2Name:string, Option3Name:string, Option1Values:string, Option2Values:string, Option3Values:string, ImageID:string, ShortDescription:string, Tags:string |
| `CtlgProduct` | ProductID:string, ProductCode:string, Name:string, Available:float, OnHand:float, ImageID:string, IsStockProduct:bool |
| `DEARMappingModel` | Description:string, FieldName:string |
| `ECommerceShop` | ConfigID:string, ShopName:string |
| `IDDescription` | Description:string, ID:int |
| `ItemSpecificsModel` | Name:string, FieldType:string, IsRequired:bool, Value:string, Mapped:bool, IsMultiSelection:bool, MappedField:string |
| `ListingsSpecificsModel` | Name:string, FieldType:string, IsRequired:bool, Value:string, Mapped:bool, MappedField:string |
| `NameDescriptionModel` | Name:string, Description:string |
| `ShippingPackageType` | DimensionsSupported:bool, DefaultValue:bool, PackageID:int, Description:string, ShippingPackage:int |
| `ShippingService` | CODEnabled:bool, DimensionsRequired:bool, WeightRequired:bool, ExpeditedService:bool, InternationalService:bool, Description:string, ShippingTimeMax:int, ShippingTimeMin:int, Description:string, ShippingCategoryDescription:string, ShippingCategory:string, ValidForSellingFlow:bool, SurchargeApplicable:bool, DisplayName:string, ShippingServiceID:int |
| `SiteIdModel` | ID:int, Name:string, Abbr:string |
| `eBayPublishingFailed` | ProductID:string, ProfileName:string, SKU:string, Name:string, Result:string, ImageID:string, ProductType:string |
| `eBayPublishingNotListed` | ProductID:string, SKU:string, Type:string, ProductType:string, Name:string, Category:string, Brand:string, Price:float, Quantity:float, Status:string, LProfile:string, ItemID:string, Selected:bool, ImageID:string, FamilyID:string, ValidationText:string, ValidationState:string |
| `vAccount` | Code:string, DisplayName:string |
| `vECSOrderLog` | LogID:string, ConfigID:string, Date:date, DownloadDate:date, ProcessDate:date, OrderNumber:string, SaleTaskID:string, Status:string, Type:string, SaleOrderNumber:string, RefundID:string, OrderID:string, IsNewSale:bool |
| `vECSPendingOrdersNew` | OrderLineID:string, OrderNumber:string, DateCreated:date, Name:string, Quantity:float, Total:float, CustomerName:string, Error:string, ValidationText:string, ValidationState:string |
| `vEcsBulkListing` | ProductID:string, ProductCode:string, Name:string, Status:string, Category:string, ProductType:string, Price:float, Quantity:float, UseBufferInventory:bool, BufferInventory:int, SyncBufferInventory:int, SyncQuantity:float |
| `vEcsCatalogItemNew` | SIMID:string, ProductID:string, FamilyID:string, EntityType:string, LinkedSKU:string, LinkedName:string, SKU:string, Name:string, Status:string, ImageID:string, SyncStockLevel:bool, Price:float, Category:string, Option1:string, Option2:string, Option3:string, IsStockProduct:bool, IgnoreProductUpdation:bool, Quantity:float |
| `vEcsConfiguration` | ID:string, TenantID:string, ShopName:string, AccessToken:string, RefreshToken:string, PrimaryPriceTier:int, ConsolidationType:string, ConsolidationTimeText:string, ConsolidateToCustomerID:string, IsActive:bool, PickWhenOrderStatus:string, ShippingTaxed:bool, SyncStockLevel:bool, ExportShippingInformation:bool, AutoInvoicingMode:string, AutoFulfilmentMode:string, ECSspecificParameter1:bool, ECSspecificParameter9:string, ECSspecificParameter8:string, ECSspecificParameter6:bool, ECSspecificParameter10:string, CustomerName:string, ECSTokenType:string, RevenueAccount:string, MoneySettlementBankAcc… |
| `vEcsOperationLog` | ID:string, ConfigID:string, Date:date, Description:string, Category:string, Processed:bool, Type:int, UserName:string, ConfigName:string, ConfigType:string, Disabled:bool |
| `vEcsOverviewCustomersList` | CustomerID:string, Name:string, OrderCount:int, PaidTotalAmount:decimal, ConfigID:string |
| `vEcsOverviewSalesList` | SaleOrderDate:date, SaleOrderNumber:string, CustomerName:string, Status:string, PaidTotalAmount:decimal, InvoicingStatus:string, OrderStatus:string, FulFilmentStatus:string, PaymentStatus:string, TaskID:string, TT:int, ConfigID:string |
| `vEcsPaymentProcessorMapping` | ID:string, ConfigID:string, PaymentProcessorID:string, PaymentProcessorName:string, LedgerAccount:string, AccountName:string, SortOrder:string |
| `vEcsProductVariation` | SIMID:string, SKU:string, Name:string, Category:string, Option1:string, Option2:string, Option3:string, Status:string, CustomField1:string, CustomField2:string, CustomField3:string, CustomField4:string, CustomField5:string, CustomField6:string, CustomField7:string, CustomField8:string, CustomField9:string, CustomField10:string, Price:float, SIMFamilyID:string, ProductID:string, LinkedName:string, LinkedSKU:string, ImageID:string, ValidationText:string, MaxRows:int |
| `vEcsTaxMapping` | ID:string, ECSConfigID:string, ECSTaxType:string, ECSTaxID:string, Description:string, Value:string, TaxRuleName:string, SortOrder:int |
| `vListingProfile` | id:string, Name:string, ShippingProfileID:string, ShippingProfileName:string, ReadinessStateId:auto |
| `vLocation` | LocationID:string, Description:string |
| `vProductVariation` | ProductID:string, FamilyID:string, ProductCode:string, ImageID:string, Name:string, Option1:string, Option2:string, Option3:string |
| `vTax` | RuleID:string, Description:string |
| `vTime` | Value:string, Name:string |

## Internal endpoints

Grouped by controller. Effect: 🟢 read · 🟠 read + write at the same URL · 🔴 write. `api` = JSON under `/api/`, `mvc` = controller action.

### EbayNG

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/EbayNG/ChangeMappingAndSyncStock` | mvc | POST | 🔴 write | ConfigID IgnoreProductUpdation ProductID SIMProductID SyncStockLevel |  |  |
| `/api/EbayNG_Index_CheckFamily` | api | GET PUT | 🟠 read + write |  |  |  |
| `/api/EbayNG_Index_CheckProduct` | api | GET PUT | 🟠 read + write | ConfigID |  |  |
| `/api/EbayNG_Index_Dashboard_Summary` | api | GET | 🟢 read |  |  |  |
| `/api/EbayNG_Index_Family` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ConfigID CurrentFamilyID lang |  |  |
| `/api/EbayNG_Index_Migration` | api | GET PUT | 🟠 read + write | ConfigID | ConfigID |  |
| `/api/EbayNG_Index_Product` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ConfigID IsStockProduct Name lang |  |  |
| `/api/EbayNG_Index_PublishingFailed` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ConfigID lang search |  | root |
| `/api/EbayNG_Index_PublishingNotListed` | api | PUT REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID lang search |  | root |
| `/api/EbayNG_Index_Tags` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/EbayNG_Index_vAccounts` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/EbayNG_Index_vCategory` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/EbayNG_Index_vCustomer` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/EbayNG_Index_vEBayPendingOrders` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ConfigID search |  | root |
| `/api/EbayNG_Index_vEbayCategory` | api | GET | 🟢 read | ConfigID |  |  |
| `/api/EbayNG_Index_vEbayCategorySg` | api | GET | 🟢 read | ConfigID |  |  |
| `/api/EbayNG_Index_vEbayCategorySpecs` | api | GET | 🟢 read | CategoryID ConfigID catLevel |  |  |
| `/api/EbayNG_Index_vEbayPublishingProfiles` | api | PUT REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID |  | root |
| `/api/EbayNG_Index_vEcsConfiguration` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/EbayNG_Index_vEcsLogs` | api | DELETE REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID search |  | root |
| `/api/EbayNG_Index_vEcsPaymentProcessorMapping` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID Update |  |  |
| `/api/EbayNG_Index_vEcsProductList` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ConfigID lang mode search status |  | root |
| `/api/EbayNG_Index_vEcsTaxMapping` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID Update |  |  |
| `/api/EbayNG_Index_vEcsVariationList` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ConfigID SIMFamilyID ScanFamilyID |  | root |
| `/api/EbayNG_Index_vEcsVariationManual` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ConfigID FamilyID SIMFamilyID additionalSKUs search |  | root |
| `/api/EbayNG_Index_vLiabilityAccounts` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/EbayNG_Index_vLocation` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/EbayNG_Index_vSalesPriceTiers` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/EbayNG_Index_vSiteId` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/EbayNG_Index_vTaxRules` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/EbayNG_Index_veBayOverviewCustomersList` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ConfigID search |  | root |
| `/api/EbayNG_Index_veBayOverviewSalesList` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ConfigID search |  | root |

### EBayNG

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/EBayNG_Index_vOperationLogs` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID search |  | root |
| `/api/EBayNG_Index_vRevenueAccounts` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
