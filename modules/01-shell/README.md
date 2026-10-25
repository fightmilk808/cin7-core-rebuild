# Shell and navigation

The frame every page loads: top menu, global search, favourites, quick links, notifications and chat (SignalR `messageHub`), session timeout, the activity log and access checks. Bundle `Main2019`.

| | Count |
|---|---:|
| Pages | 0 |
| Data models | 0 (plus [shared](../00-shared/README.md)) |
| Internal endpoints | 130 (36 write) |
| Public API operations | 0 |

## Integration endpoints this module calls

Filed under their integration; listed here because pages in this module call them.

| Integration | Endpoints |
|---|---|
| [google-workspaces](../12-integrations/google-workspaces/README.md) | `/api/GSuites_Index_Directory`, `/api/GSuites_Index_Files` |
| [quickbooks](../12-integrations/quickbooks/README.md) | `/Quickbooks/StartConnection` |
| [square](../12-integrations/square/README.md) | `/Square/Main` |

## How to rebuild it

1. **Internal API.** Implement each controller's endpoints with the verbs listed, following the [internal API contract](../../docs/INTERNAL-API.md): one URL per store for GET/POST/PUT/DELETE, paged reads returning `{root, total}`, saves wrapped as `{ID, HasErrors, Original, Updated}`.

## Internal endpoints

Grouped by controller. Effect: 🟢 read · 🟠 read + write at the same URL · 🔴 write. `api` = JSON under `/api/`, `mvc` = controller action.

### Account

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/Account/FinalizeAjax` | mvc |  | 🔴 write |  |  |  |
| `/Account/LoginAjax` | mvc |  | 🔴 write |  |  |  |
| `/Account/RegisterAjax` | mvc |  | 🔴 write |  |  |  |
| `/Account/SetLanguage` | mvc |  | 🔴 write | langtag |  |  |
| `/Account/TfaAuthDialog` | mvc | POST | 🟢 read |  |  |  |
| `/Account/TfaSetupDialog` | mvc | POST | 🔴 write |  |  |  |

### account

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/account/ConfirmAlternativeEmail` | api | POST | 🔴 write |  |  |  |
| `/api/account/tfa` | api | GET POST | 🟠 read + write |  | RememberMe |  |

### Admin

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/Admin_RequestCancellation/GetCancellationRequestDetails` | api | GET | 🟢 read | _dc |  |  |

### Calendar

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/Calendar_Index_vTask/Get` | api | GET | 🟢 read | endDate entityTypes startDate taskCategoryID userID |  |  |
| `/api/Calendar_Index_vTenantUser` | api |  | 🟢 read |  |  |  |

### ContinueSetup

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/ContinueSetup_Statistic_UpdateState` | api | PUT | 🔴 write |  |  |  |

### CustomerList

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/CustomerList/CustomerTooltip` | mvc | GET | 🟢 read | customerId |  |  |
| `/CustomerList/CustomerTooltipsBulk` | mvc | GET | 🔴 write | allCustomerIds |  |  |

### DefaultFieldValues

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/DefaultFieldValues/Customer` | mvc |  | 🟢 read |  |  |  |
| `/DefaultFieldValues/Product` | mvc |  | 🟢 read |  |  |  |
| `/DefaultFieldValues/Supplier` | mvc |  | 🟢 read |  |  |  |

### ExpenseClaim

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/ExpenseClaim_Index_Email` | api |  | 🔴 write |  |  |  |

### ExpenseClaimReceipt

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/ExpenseClaimReceipt_Index_Email` | api |  | 🔴 write |  |  |  |

### Favorites

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/Favorites` | api | GET POST | 🟠 read + write |  |  |  |

### Home

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/Home/LoadTestData` | mvc |  | 🔴 write |  |  |  |

### Impersonation

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/Impersonation/RequestFullAccess` | mvc |  | 🔴 write | TenantID |  |  |

### marketplaceMenu

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/marketplaceMenu` | api | GET | 🟢 read | _dc |  |  |

### MessageChat

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/MessageChat_Index_vMessage` | api | GET | 🟢 read | FromDate IsGroup To |  |  |
| `/api/MessageChat_Index_vTenantChat` | api | GET | 🟢 read | groupID |  |  |

### MySubscription

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/MySubscription/RenewSubscription` | mvc |  | 🔴 write |  |  |  |
| `/api/MySubscription_Index_SharedPoolUsageData` | api | GET | 🟢 read |  |  |  |

### notificationCount

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/notificationCount` | api | GET | 🟢 read | _dc |  |  |

### Notifications

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/Notifications/MarkAsRead` | mvc | GET | 🔴 write | id |  |  |
| `/api/Notifications` | api | GET | 🟢 read |  |  |  |

### NotificationSettings

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/NotificationSettings/MailingList` | mvc |  | 🟢 read |  |  |  |
| `/NotificationSettings/Notifications` | mvc |  | 🟢 read |  |  |  |

### Opportunity

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/Opportunity_Index_Email` | api | POST REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | TaskID |  |  |

### organisations

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/organisations` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |

### partneraccess

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/partneraccess` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |

### Pendo

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/Pendo` | api | GET | 🟢 read |  |  |  |

### Product

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/Product_Index_vProductAlternative/stock` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | productID |  |  |

### ProductFamily

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/ProductFamily/Download` | mvc |  | 🟢 read |  |  |  |

### ProductionOrder

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/ProductionOrder_Index_Email` | api |  | 🔴 write |  |  |  |

### Purchase

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/Purchase_Index_Email` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | TaskID |  |  |

### PurchaseAdvanced

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/PurchaseAdvanced_Index_Email` | api |  | 🔴 write |  |  |  |

### QuickLinks

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/QuickLinks_Index_Tooltips` | api | GET | 🟢 read | taskId |  |  |
| `/api/QuickLinks_Index_Tooltips/resource` | api | GET | 🟢 read | locationID resourceID |  |  |

### Report

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/Report/AuditReport` | mvc |  | 🟢 read |  |  |  |
| `/Report/DepreciationSchedule` | mvc |  | 🔴 write |  |  |  |
| `/Report/DisassemblyAnalysis` | mvc |  | 🟢 read |  |  |  |
| `/Report/ExpenseClaim` | mvc |  | 🟢 read |  |  |  |
| `/Report/FindByPurchaseOrder` | mvc |  | 🟢 read |  |  |  |
| `/Report/FinishedGoodsAnalysis` | mvc |  | 🟢 read |  |  |  |
| `/Report/FixedAssetOverview` | mvc |  | 🟢 read |  |  |  |
| `/Report/InventoroOverStock` | mvc |  | 🟢 read |  |  |  |
| `/Report/InventoroSalesForecast` | mvc |  | 🟢 read |  |  |  |
| `/Report/InventoroWinnersLosers` | mvc |  | 🟢 read |  |  |  |
| `/Report/InventoryAging` | mvc |  | 🟢 read |  |  |  |
| `/Report/InventoryBOMComponentDetails` | mvc |  | 🟢 read |  |  |  |
| `/Report/InventoryLowOnStock` | mvc |  | 🟢 read |  |  |  |
| `/Report/InventoryMovementDetails` | mvc |  | 🔴 write |  |  |  |
| `/Report/InventoryMovementSummary` | mvc |  | 🔴 write |  |  |  |
| `/Report/InventoryPriceList` | mvc |  | 🟢 read |  |  |  |
| `/Report/InventoryReordering` | mvc |  | 🟢 read |  |  |  |
| `/Report/InventoryStockLevel` | mvc |  | 🟢 read |  |  |  |
| `/Report/InventorySuppliers` | mvc |  | 🟢 read |  |  |  |
| `/Report/InventoryVelocity` | mvc |  | 🟢 read |  |  |  |
| `/Report/InventoryWarehouseDetails` | mvc |  | 🟢 read |  |  |  |
| `/Report/JobCostingMaterials` | mvc |  | 🟢 read |  |  |  |
| `/Report/JobCostingProfitLoss` | mvc |  | 🟢 read |  |  |  |
| `/Report/LotExpiry` | mvc |  | 🟢 read |  |  |  |
| `/Report/OutOfStockComponentsForAutoAssembly` | mvc |  | 🟢 read |  |  |  |
| `/Report/ProductionActualVsPlannedCycleTime` | mvc |  | 🟢 read |  |  |  |
| `/Report/ProductionCostBreakdown` | mvc |  | 🟢 read |  |  |  |
| `/Report/ProductionDowntime` | mvc |  | 🟢 read |  |  |  |
| `/Report/ProductionFinishedProductsWastageRate` | mvc |  | 🟢 read |  |  |  |
| `/Report/ProductionOverdue` | mvc |  | 🟢 read |  |  |  |
| `/Report/ProductionProductsUsedInProductionBOM` | mvc |  | 🟢 read |  |  |  |
| `/Report/ProductionResourceEfficiency` | mvc |  | 🟢 read |  |  |  |
| `/Report/ProductionScheduleUpdate` | mvc |  | 🔴 write |  |  |  |
| `/Report/ProductionShortage` | mvc |  | 🟢 read |  |  |  |
| `/Report/ProfitLossByProduct` | mvc |  | 🟢 read |  |  |  |
| `/Report/PurchaseCostAnalysis` | mvc |  | 🟢 read |  |  |  |
| `/Report/PurchaseDocuments` | mvc |  | 🟢 read |  |  |  |
| `/Report/PurchaseGoodsReceivedNotInvoiced` | mvc |  | 🟢 read |  |  |  |
| `/Report/PurchaseInvoiceDetails` | mvc |  | 🟢 read |  |  |  |
| `/Report/PurchaseInvoiceSummary` | mvc |  | 🟢 read |  |  |  |
| `/Report/PurchaseOrderDetails` | mvc |  | 🟢 read |  |  |  |
| `/Report/PurchaseOrderPending` | mvc |  | 🟢 read |  |  |  |
| `/Report/PurchaseOrderSummary` | mvc |  | 🟢 read |  |  |  |
| `/Report/PurchaseOrderVsInvoice` | mvc |  | 🟢 read |  |  |  |
| `/Report/PurchaseSupplierFinancialSummary` | mvc |  | 🟢 read |  |  |  |
| `/Report/ReconciliationWithXero` | mvc |  | 🟢 read |  |  |  |
| `/Report/SaleBackorderDetails` | mvc |  | 🟢 read |  |  |  |
| `/Report/SaleBackordersSummary` | mvc |  | 🟢 read |  |  |  |
| `/Report/SaleCreditNotesByProduct` | mvc |  | 🟢 read |  |  |  |
| `/Report/SaleCustomerOrderByProduct` | mvc |  | 🟢 read |  |  |  |
| `/Report/SaleCustomerPaymentDetails` | mvc |  | 🔴 write |  |  |  |
| `/Report/SaleCustomerPaymentSummary` | mvc |  | 🔴 write |  |  |  |
| `/Report/SaleDocuments` | mvc |  | 🟢 read |  |  |  |
| `/Report/SaleFulfillmentDetails` | mvc |  | 🟢 read |  |  |  |
| `/Report/SaleOrderDetails` | mvc |  | 🟢 read |  |  |  |
| `/Report/SaleOrderPending` | mvc |  | 🟢 read |  |  |  |
| `/Report/SaleOutstandingQuotes` | mvc |  | 🟢 read |  |  |  |
| `/Report/SaleOverview` | mvc |  | 🟢 read |  |  |  |
| `/Report/SalePriceHistory` | mvc |  | 🟢 read |  |  |  |
| `/Report/SaleProfitBySalesRepresentative` | mvc |  | 🟢 read |  |  |  |
| `/Report/SaleProfitSummary` | mvc |  | 🟢 read |  |  |  |
| `/Report/SalesByCustomer` | mvc |  | 🟢 read |  |  |  |
| `/Report/SalesByProductDetails` | mvc |  | 🟢 read |  |  |  |
| `/Report/SalesByProductSummary` | mvc |  | 🟢 read |  |  |  |
| `/Report/SalesDemandForecast` | mvc |  | 🟢 read |  |  |  |
| `/Report/StockReceivedVsInvoice` | mvc |  | 🟢 read |  |  |  |
| `/Report/StockValueInventoryAging` | mvc |  | 🟢 read |  |  |  |
| `/Report/Transactions` | mvc |  | 🟢 read |  |  |  |
| `/Report/TransactionsVsInventoryCards` | mvc |  | 🟢 read |  |  |  |

### RMA

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/RMA_Index_Email` | api |  | 🔴 write |  |  |  |
| `/api/RMA_RO_Email` | api |  | 🔴 write |  |  |  |

### Sale

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/Sale_Index_Email` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | TaskID |  |  |

### SaleCommon

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/SaleCommon_ShippingService_Email` | api | POST | 🔴 write | TaskID |  |  |

### SaleMult

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/SaleMult_Index_Email` | api |  | 🔴 write |  |  |  |

### StockTransfer

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/StockTransfer_Index_Email` | api |  | 🔴 write |  |  |  |

### Stocktransfer

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/Stocktransfer_Index_Email` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | TaskID |  |  |

### Task

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/Task/Search4Entity` | mvc |  | 🟢 read |  |  |  |

### Tasks

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/Tasks` | api | GET | 🟢 read |  |  |  |

### TaskShared

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/TaskShared_DeliveryItems` | api | POST REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | deliveryDateStr saleTaskID | DeliveryDateStr DeliveryItemID TaskID TaskStatus | DeliveryItems |
| `/api/TaskShared_DeliveryYearCalendar` | api | POST | 🟢 read | saleTaskID |  |  |
| `/api/TaskShared_TaskList/GetLink` | api |  | 🟢 read |  |  |  |
| `/api/TaskShared_vDeliveryNotes` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | taskID |  |  |
| `/api/TaskShared_vTask` | api |  | 🟢 read |  |  |  |
| `/api/TaskShared_vTaskFile` | api | POST REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | TaskID id |  |  |

### updateAzureConnectionId

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/updateAzureConnectionId` | api |  | 🔴 write |  |  |  |

### vSaleListGeneral

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/vSaleListGeneral/Summary` | api | GET | 🟢 read | documentType taskID |  |  |
| `/api/vSaleListGeneral/SummaryBulk` | api | GET | 🟢 read | allTasks |  |  |
