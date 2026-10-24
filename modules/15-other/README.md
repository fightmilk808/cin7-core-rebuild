# Unassigned endpoints

Endpoints found in shared bundles that no menu page claims. Rebuild them where their name says they belong.

| | Count |
|---|---:|
| Pages | 0 |
| Data models | 0 (plus [shared](../00-shared/README.md)) |
| Internal endpoints | 48 (23 write) |
| Public API operations | 0 |

## How to rebuild it

1. **Internal API.** Implement each controller's endpoints with the verbs listed, following the [internal API contract](../../docs/INTERNAL-API.md): one URL per store for GET/POST/PUT/DELETE, paged reads returning `{root, total}`, saves wrapped as `{ID, HasErrors, Original, Updated}`.

## Internal endpoints

Grouped by controller. Effect: 🟢 read · 🟠 read + write at the same URL · 🔴 write. `api` = JSON under `/api/`, `mvc` = controller action.

### BankAccount

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/BankAccount_Index_CreateDetailed` | api | POST | 🔴 write |  |  |  |
| `/api/BankAccount_Index_CreateReconcilation` | api | DELETE POST PUT | 🔴 write |  |  |  |
| `/api/BankAccount_Index_vBalance` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | AccountId |  | root |
| `/api/BankAccount_Index_vBankAccounts` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | excludeAccountId |  |  |
| `/api/BankAccount_Index_vChartOfAccounts` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/BankAccount_Index_vComment` | api | PUT | 🔴 write |  |  |  |
| `/api/BankAccount_Index_vCustomerWithSuppliers` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/BankAccount_Index_vReconcilation` | api | DELETE POST PUT REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | accountId limit start statementId |  | root |
| `/api/BankAccount_Index_vSelectReconcilation` | api | DELETE POST PUT REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | Id ReconcileID accountId option search transactionAmount |  | root |
| `/api/BankAccount_Index_vStatementList` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | accountId |  | root |
| `/api/BankAccount_Index_vStatements` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | accountId |  | root |
| `/api/BankAccount_Index_vTenantTaxationRule` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | type |  |  |
| `/api/BankAccount_Index_vTransactions` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | accountId |  | root |

### BankStatement

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/BankStatement/List` | mvc |  | 🟢 read | statementId |  |  |
| `/BankStatement/Upload` | mvc | POST | 🔴 write |  |  |  |
| `/api/BankStatement_Index_vMapping` | api | DELETE PUT REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | accountId operationId |  |  |
| `/api/BankStatement_Index_vProfile` | api | POST PUT REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | Name accountId hash |  |  |
| `/api/BankStatement_Index_vTransactions` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | statementId |  | root |

### BudgetPlanner

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/BudgetPlanner_Index_Data` | api | GET POST | 🟠 read + write | mode |  |  |

### InventoroSettings

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/InventoroSettings/ExportProducts` | mvc | POST | 🟢 read |  |  |  |
| `/InventoroSettings/ExportSuppliers` | mvc | POST | 🟢 read |  |  |  |
| `/api/InventoroSettings_ProductRules` | api |  | 🟢 read |  |  |  |
| `/api/InventoroSettings_ProductRules/Reorder` | api |  | 🟢 read |  |  |  |
| `/api/InventoroSettings_ReferenceData/RuleParameters` | api |  | 🟢 read |  |  |  |
| `/api/InventoroSettings_Suppliers` | api |  | 🟢 read |  |  |  |

### Quickbooks

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/Quickbooks_StartSync` | api | POST | 🔴 write |  |  |  |

### QuickbooksSynchronisation

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/QuickbooksSynchronisation/GetLastSyncDate` | mvc | GET | 🟢 read |  |  |  |
| `/api/QuickbooksSynchronisation_History` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | entity search status |  | root |
| `/api/QuickbooksSynchronisation_History/BulkStatusUpdate` | api | POST | 🔴 write |  |  |  |

### Report

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/Report_vReportCurrency` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |

### StockTransferList

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/StockTransferList_Index_StockTransferBulkPermissions` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |

### StocktransferList

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/StocktransferList_Index_vStockTransferTask` | api |  | 🟢 read |  |  |  |
| `/api/StocktransferList_Index_vStockTransferTask/Filter` | api |  | 🟢 read |  |  |  |
| `/api/StocktransferList_Index_vStockTransferTask/GetAllFromLocations` | api |  | 🟢 read |  |  |  |
| `/api/StocktransferList_Index_vStockTransferTask/GetAllToLocations` | api |  | 🟢 read |  |  |  |
| `/api/StocktransferList_Index_vStockTransferTask/GetLocationBins` | api |  | 🟢 read |  |  |  |

### StockTransferListBulkAction

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/StockTransferListBulkAction` | api | POST | 🔴 write | Action IDs |  |  |

### Stripe

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/Stripe/Connect` | mvc |  | 🔴 write |  |  |  |
| `/Stripe/CreatePaymentIntent` | mvc | GET | 🔴 write | amount doc |  |  |
| `/Stripe/Disconnect` | mvc |  | 🔴 write |  |  |  |
| `/Stripe/PaidCallback` | mvc |  | 🔴 write | token |  |  |
| `/Stripe/Pay` | mvc |  | 🔴 write | doc |  |  |
| `/Stripe/SaveSettings` | mvc |  | 🔴 write |  |  |  |
| `/Stripe/TestPayment` | mvc |  | 🔴 write |  |  |  |
| `/api/Stripe_Index_Dashboard_Summary` | api | GET | 🟢 read |  |  |  |
| `/api/Stripe_Index_LogEntries` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  | root |
| `/api/Stripe_Index_vAccounts` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Stripe_PayDoc_Page` | api |  | 🟢 read | doc |  |  |
