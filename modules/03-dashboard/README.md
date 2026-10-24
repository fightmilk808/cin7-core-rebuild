# Dashboard

The home page (`/Home`): counters and grids that link into the document lists, plus the setup checklist (`/ContinueSetup`).

| | Count |
|---|---:|
| Pages | 2 |
| Data models | 15 (plus [shared](../00-shared/README.md)) |
| Internal endpoints | 65 (33 write) |
| Public API operations | 0 |

## How to rebuild it

1. **Schema.** Create one table per data model below (15), starting from the generated [`schema.sql`](schema.sql). Ids are GUIDs; join on the `*ID` fields.
2. **Internal API.** Implement each controller's endpoints with the verbs listed, following the [internal API contract](../../docs/INTERNAL-API.md): one URL per store for GET/POST/PUT/DELETE, paged reads returning `{root, total}`, saves wrapped as `{ID, HasErrors, Original, Updated}`.
3. **Pages.** Build each route below as a server-rendered shell that loads the shell bundle and the page's own app, opening a record from `#<guid>` once at load ([page model](../../docs/ARCHITECTURE.md#what-a-page-is)).

## Pages

| Route | Menu label | Title | Bundle | Endpoints (write) |
|---|---|---|---|---:|
| `/ContinueSetup` | Setup guide | Continue setup | `ContinueSetup` | 14 (20) |
| `/Home` | Dashboard | Dashboard | `Home2019` | 31 (14) |

## Data models

ExtJS models the pages use; `v` prefix = view-model. Full DDL in [`schema.sql`](schema.sql).

| Model | Fields |
|---|---|
| `ContinueSetupViewModel` | UserName:string, DemoDataDeleted:bool, OnBoarding:bool, AccountingSystem:string, SyncErrorMessage:string, IsAccountMappingComplete:bool, SyncRequired:bool, SetupCompleted:bool, ConnectRequired:bool, InitialSyncRequired:bool, ShopifyConnected:bool, ShopifyConfigID:string, ShopifyShopName:string, ShopifyProductsNumber:int, ShopifyOrdersNumber:int, ShopifyPriceTier:int, WooCommerceConnected:bool, WooCommerceConfigID:string, WooCommerceShopName:string, WooCommerceProductsNumber:int, WooCommerceOrdersNumber:int, WooCommercePriceTier:int, VendConnected:bool, VendConfigID:string, VendShopName:string… |
| `CustomerOverviewByProduct` | CustomerName:string, CustomerID:string, Sales:int, Amount:float, Tax:float |
| `CustomerOverviewNoBuys` | CustomerName:string, CustomerID:string |
| `CustomerOverviewSalesRep` | SaleRep:string, Sales:int, Amount:float, Tax:float |
| `CustomerOverviewTopCustomer` | CustomerName:string, CustomerID:string, Sales:int, Amount:float, Tax:float |
| `DChart` | Name:string, Due:float, Overdue:float |
| `ExternalEntityMapping` | ID:string, ExternalCode:string, ExternalName:string, EntityCode:string, EntityType:string |
| `ProductOverviewBrand` | Name:string, Amount:float, Quantity:int, Tax:float |
| `ProductOverviewRegion` | City:string, Country:string, Amount:float, Tax:float |
| `ProductOverviewSellings` | ProductImage:string, ProductID:string, ProductName:string, Total:float, Tax:float, Quantity:int |
| `Purchase` | TaskID:string, OrderNo:string, OrderDate:date, Supplier:string, InvoiceDueDate:date, Invoiced:float, Ordered:float, Due:float, SupplierCurrency:string, DropShipTaskID:string, TaskTypeSign:int, TaskTypeName:string, ShipmentRequiredByDate:date |
| `Reorder` | ProductCode:string, ProductID:string, Name:string, Supplier:string, Available:float |
| `Sale` | TaskID:string, OrderNo:string, OrderDate:date, Customer:string, InvoiceDueDate:date, Amount:float, Due:float, CustomerCurrency:string, TT:int |
| `TaskCount` | Date:date, Tasks:int |
| `vProductList` | ProductID:string, ProductCode:string, Name:string, DefaultUnitOfMeasure:string, Type:string, Category:string, Brand:string, LatestSupplier:string, Status:string, Selected:bool, ImageID:string, CustomField1:string, CustomField2:string, CustomField3:string, CustomField4:string, CustomField5:string, CustomField6:string, CustomField7:string, CustomField8:string, CustomField9:string, CustomField10:string, NotSellable:string |

## Internal endpoints

Grouped by controller. Effect: 🟢 read · 🟠 read + write at the same URL · 🔴 write. `api` = JSON under `/api/`, `mvc` = controller action.

### AccountMapping

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/AccountMapping/CountrySpecific` | mvc |  | 🟢 read | Key |  |  |
| `/AccountMapping/OnBoardingPartial` | mvc | POST | 🟢 read |  |  |  |
| `/api/AccountMapping_Index_vTaxationRules` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |

### ChartOfAccounts

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/ChartOfAccounts_Index_vChartOfAccounts` | api | POST PUT REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | includeXeroAccountsIfPossible returnActiveOnly |  |  |

### Cin7Capital

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/Cin7Capital/GenerateConnectTokenForSalesList` | mvc | POST | 🔴 write |  |  |  |
| `/Cin7Capital/GenerateSessionToken` | mvc | POST | 🔴 write | idList |  |  |

### ContinueSetup

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/ContinueSetup/ChangeCurrency` | mvc | GET(navigate) | 🔴 write |  |  |  |
| `/ContinueSetup/ConnectToDEAR` | mvc | GET(navigate) | 🔴 write |  |  |  |
| `/ContinueSetup/ConnectToQuickBooks` | mvc | GET(navigate) | 🔴 write | isSandbox |  |  |
| `/ContinueSetup/ConnectToXero` | mvc | GET(navigate) | 🔴 write |  |  |  |
| `/ContinueSetup/ImportFromQuickBooks` | mvc | GET(navigate) | 🔴 write |  |  |  |
| `/ContinueSetup/ImportFromXero` | mvc | GET(navigate) | 🔴 write |  |  |  |
| `/ContinueSetup/ResetAccessCache` | mvc | GET | 🔴 write |  |  |  |
| `/api/ContinueSetup_DeleteArchivedAccounts` | api | DELETE | 🔴 write |  |  |  |
| `/api/ContinueSetup_DemoDataDelete` | api | DELETE GET | 🟠 read + write |  |  |  |
| `/api/ContinueSetup_ECommerceParameter` | api | PUT | 🔴 write |  |  |  |
| `/api/ContinueSetup_Index` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/ContinueSetup_OnboardingParameter` | api | PUT | 🔴 write |  |  |  |
| `/api/ContinueSetup_SetSyncRequired` | api | DELETE | 🔴 write |  |  |  |

### CustomerList

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/CustomerList/ImportCustomerListJson` | mvc | POST | 🔴 write |  |  |  |
| `/api/CustomerList_Import_Exceptions` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |

### Dashboard

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/Dashboard_Inventoro/KPI` | api |  | 🟢 read |  |  |  |
| `/api/Dashboard_Inventoro/Overstock` | api |  | 🟢 read |  |  |  |
| `/api/Dashboard_Inventoro/Teaser` | api |  | 🟢 read |  |  |  |
| `/api/Dashboard_Inventoro/Winners` | api |  | 🟢 read |  |  |  |

### Dashboard2017

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/Dashboard2017_CustomersOverviewByProducts` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | EndDate Lang Search StartDate |  | root |
| `/api/Dashboard2017_CustomersOverviewNoBuys` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | EndDate Lang StartDate |  | root |
| `/api/Dashboard2017_CustomersOverviewSalesRep` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | EndDate Lang StartDate |  | root |
| `/api/Dashboard2017_CustomersOverviewTopCustomers` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | EndDate Lang StartDate |  | root |
| `/api/Dashboard2017_DashboardSections` | api | POST | 🟢 read |  |  |  |
| `/api/Dashboard2017_GetKPIData` | api |  | 🟢 read |  |  |  |
| `/api/Dashboard2017_ProductsOverviewBrands` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | EndDate Lang StartDate |  | root |
| `/api/Dashboard2017_ProductsOverviewRegions` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | EndDate Lang StartDate |  | root |
| `/api/Dashboard2017_ProductsOverviewTopWorstSelling` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | EndDate Lang Search StartDate |  | root |
| `/api/Dashboard2017_Purchase` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | endDate lang startDate type |  | root |
| `/api/Dashboard2017_PurchaseNumbers` | api |  | 🟢 read |  |  |  |
| `/api/Dashboard2017_Purchases` | api |  | 🟢 read |  |  |  |
| `/api/Dashboard2017_Reorder` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | lang search |  | root |
| `/api/Dashboard2017_Sale` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | endDate lang startDate type |  | root |
| `/api/Dashboard2017_SaleNumbers` | api |  | 🟢 read |  |  |  |
| `/api/Dashboard2017_StatNumbers` | api | POST | 🟢 read |  |  |  |

### ExternalEntityMapping

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/ExternalEntityMapping_Index_vExternalEntityMapping` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | returnActiveOnly showDetails type |  |  |

### Product

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/Product/ImportInventoryListJson` | mvc | POST | 🔴 write |  |  |  |
| `/api/Product_ImportInventoryList_Exceptions` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/Product_Index_vProductList` | api | GET REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | IsActive lang search |  | root |

### Quickbooks

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/Quickbooks/ConnectWizard` | mvc | GET(navigate) | 🔴 write | isSandbox |  |  |
| `/api/Quickbooks_HasConsolidatedTranscations` | api | GET | 🟢 read |  |  |  |

### QuickBooks

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/QuickBooks_StartOnboardingImport` | api | POST | 🔴 write |  |  |  |
| `/api/QuickBooks_StartSync` | api | POST | 🔴 write |  |  |  |

### SaleCommon

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/SaleCommon_GetAvailableLocations` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | withBins |  |  |

### SaleList

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/SaleList/Print` | mvc | POST | 🟢 read (logs) | IDList TemplateID |  |  |
| `/SaleList/PrintCombined` | mvc | POST | 🟢 read (logs) | IDList SortBy TemplateID |  |  |
| `/SaleList/ScheduleForPicking` | mvc | POST | 🔴 write | IDList |  |  |
| `/SaleList/SetSalePicker` | mvc | POST | 🔴 write | IDList SalePicker |  |  |
| `/SaleList/UnscheduleForPicking` | mvc | POST | 🔴 write | IDList |  |  |
| `/api/SaleList_Index_UndoVoidAccess` | api | GET | 🟢 read |  |  |  |

### SaleListBulkAction

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/SaleListBulkAction` | api | POST | 🔴 write | Action CaptchaToken ID TemplateID lang |  |  |

### Stocktake

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/Stocktake/New` | mvc | GET(navigate) | 🟢 read |  |  |  |

### SupplierList

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/SupplierList/ImportSuppliersListJson` | mvc | POST | 🔴 write |  |  |  |
| `/api/SupplierList_Import_Exceptions` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |

### TenantGeneralSettings

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/TenantGeneralSettings_Index_vTenant/short` | api | GET | 🟢 read |  |  |  |

### TenantRemindersSettings

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/TenantRemindersSettings` | api | GET PUT | 🟠 read + write | reminderName |  |  |

### TenantTaxationRule

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/TenantTaxationRule_Index_vTenantTaxationRule` | api | POST PUT REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |

### Xero

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/Xero_StartOnboardingImport` | api | POST | 🔴 write |  |  |  |
| `/api/Xero_StartSync` | api | POST | 🔴 write |  |  |  |
