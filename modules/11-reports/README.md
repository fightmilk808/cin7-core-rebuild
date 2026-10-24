# Reports

The report catalogue (`/Reports`) and each `/Report/<Name>` page. Most reports render inside a frame served by the separate report service; see [`../21-report-service`](../21-report-service/README.md).

| | Count |
|---|---:|
| Pages | 83 |
| Data models | 16 (plus [shared](../00-shared/README.md)) |
| Internal endpoints | 58 (14 write) |
| Public API operations | 0 |
| Reports | 69 |

## How to rebuild it

1. **Schema.** Create one table per data model below (16), starting from the generated [`schema.sql`](schema.sql). Ids are GUIDs; join on the `*ID` fields.
2. **Internal API.** Implement each controller's endpoints with the verbs listed, following the [internal API contract](../../docs/INTERNAL-API.md): one URL per store for GET/POST/PUT/DELETE, paged reads returning `{root, total}`, saves wrapped as `{ID, HasErrors, Original, Updated}`.
3. **Pages.** Build each route below as a server-rendered shell that loads the shell bundle and the page's own app, opening a record from `#<guid>` once at load ([page model](../../docs/ARCHITECTURE.md#what-a-page-is)).
4. **Reports.** Each report is a pivot grid over the columns listed, served by the report service ([`21-report-service`](../21-report-service/README.md)).

## Pages

| Route | Menu label | Title | Bundle | Endpoints (write) |
|---|---|---|---|---:|
| `/Report/AccountSummary` | Account Summary Report | Account Summary Report | `AccountSummaryReport2019` | 7 (3) |
| `/Report/AccountingDimensionsSummary` | Accounting Dimensions Summary Report | Accounting Dimensions Summary Report | `ReportService` | 0 (0) |
| `/Report/AuditReport` | Audit Report | Audit Report | `AuditReport2019` | 3 (0) |
| `/Report/BalanceSheet` | Balance Sheet Report | Balance Sheet Report | `BalanceSheetReport2019` | 6 (3) |
| `/Report/DepreciationSchedule` | Depreciation Schedule Report | Depreciation Schedule Report | `ReportService` | 0 (0) |
| `/Report/DisassemblyAnalysis` | Disassembly Analysis Report | Disassembly Analysis Report | `ReportService` | 0 (0) |
| `/Report/ExpenseClaim` | Expense Claim Report | Expense Claim Report | `ReportService` | 0 (0) |
| `/Report/FinancialPaymentDetails` | Financial Payment Details Report | Financial Payment Details Report | `ReportService` | 0 (0) |
| `/Report/FindByPurchaseOrder` | Find Sale Backorder by Purchase Order Report | Find Sale Backorder by Purchase Order Report | `ReportService` | 0 (0) |
| `/Report/FinishedGoodsAnalysis` | Production Cost Analysis Report | Production Cost Analysis Report | `ReportService` | 0 (0) |
| `/Report/FixedAssetOverview` | Fixed Asset Overview | Fixed Asset Overview | `FixedAssetOverviewReport2019` | 2 (3) |
| `/Report/GeneralLedger` | General Ledger Report | General Ledger Report | `GeneralLedgerReport2019` | 6 (3) |
| `/Report/InventoryAging` | Inventory Aging Report | Inventory Aging Report | `ReportService` | 0 (0) |
| `/Report/InventoryBOMComponentDetails` | BOM Component Availability Report | BOM Component Availability Report | `ReportService` | 0 (0) |
| `/Report/InventoryLowOnStock` | Products Low on Stock Report | Products Low on Stock Report | `ReportService` | 0 (0) |
| `/Report/InventoryMovementDetails` | Inventory Movement Details Report | Inventory Movement Details Report | `ReportService` | 0 (0) |
| `/Report/InventoryMovementSummary` | Inventory Movement Summary Report | Inventory Movement Summary Report | `ReportService` | 0 (0) |
| `/Report/InventoryPriceList` | Products Price List Report | Products Price List Report | `ReportService` | 0 (0) |
| `/Report/InventoryReordering` | Products Reordering Report | Products Reordering Report | `ReportService` | 0 (0) |
| `/Report/InventoryStockLevel` | Products Stock Level Report | Products Stock Level Report | `ReportService` | 0 (0) |
| `/Report/InventorySuppliers` | Inventory Suppliers Report | Inventory Suppliers Report | `ReportService` | 0 (0) |
| `/Report/InventoryVelocity` | Inventory Velocity Report | Inventory Velocity Report | `InventoryVelocityReport2019_Service ReportService` | 13 (7) |
| `/Report/InventoryWarehouseDetails` | Warehouse Details Report | Warehouse Details Report | `ReportService` | 0 (0) |
| `/Report/JobCostingMaterials` | Job Costing Materials Report | Job Costing Materials Report | `ReportService` | 0 (0) |
| `/Report/JobCostingProfitLoss` | Job Costing Profit & Loss Report | Job Costing Profit & Loss Report | `ReportService` | 0 (0) |
| `/Report/LotExpiry` | Lot Expiry Report | Lot Expiry Report | `ReportService` | 0 (0) |
| `/Report/OutOfStockComponentsForAutoAssembly` | Out of Stock Components for Auto-Assembly Report | Out of Stock Components for Auto-Assembly Report | `ReportService` | 0 (0) |
| `/Report/ProductionActualVsPlannedCycleTime` | Production Actual vs Planned Cycle Time Report | Production Actual vs Planned Cycle Time Report | `ReportService` | 0 (0) |
| `/Report/ProductionCoManCostAnalysis` | Co-manufacturer Production Cost Analysis Report | Co-manufacturer Production Cost Analysis Report | `ReportService` | 0 (0) |
| `/Report/ProductionComanMovementSummary` | Co-manufacturing Components Movement Report | Co-manufacturing Components Movement Report | `ReportService` | 0 (0) |
| `/Report/ProductionCostBreakdown` | Production Cost Breakdown Report | Production Cost Breakdown Report | `ReportService` | 0 (0) |
| `/Report/ProductionDowntime` | Production Downtime Report | Production Downtime Report | `ReportService` | 0 (0) |
| `/Report/ProductionFinishedProductsWastageRate` | Production Finished Products Wastage Rate Report | Production Finished Products Wastage Rate Report | `ReportService` | 0 (0) |
| `/Report/ProductionOverdue` | Production Overdue Report | Production Overdue Report | `ReportService` | 0 (0) |
| `/Report/ProductionProductsUsedInProductionBOM` | Production BOM Components and Resources | Production BOM Components and Resources | `ReportService` | 0 (0) |
| `/Report/ProductionResourceEfficiency` | Production Resource Efficiency Report | Production Resource Efficiency Report | `ReportService` | 0 (0) |
| `/Report/ProductionScheduleUpdate` | Production Required by Date Exceptions Report | Production Required by Date Exceptions Report | `ReportService` | 0 (0) |
| `/Report/ProductionShortage` | Production Shortage Report | Production Shortage Report | `ReportService` | 0 (0) |
| `/Report/Products` | Finished Product Traceability | Finished Product Traceability | `TraceabilityReport2019` | 1 (0) |
| `/Report/ProfitAndLoss` | Profit & Loss Report | Profit & Loss Report | `ProfitAndLossReport2019` | 6 (3) |
| `/Report/ProfitLossByProduct` | Profit & Loss by Product Report | Profit & Loss by Product Report | `ReportService` | 0 (0) |
| `/Report/PurchaseCostAnalysis` | Purchase Cost Analysis Report | Purchase Cost Analysis Report | `ReportService` | 0 (0) |
| `/Report/PurchaseDocuments` | Purchase Invoices & Credit Notes Report | Purchase Invoices & Credit Notes Report | `ReportService` | 0 (0) |
| `/Report/PurchaseGoodsReceivedNotInvoiced` | Stock Received Not Invoiced | Stock Received Not Invoiced | `ReportService` | 0 (0) |
| `/Report/PurchaseInvoiceDetails` | Purchase Invoice Details Report | Purchase Invoice Details Report | `ReportService` | 0 (0) |
| `/Report/PurchaseInvoiceSummary` | Purchase Invoice Summary Report | Purchase Invoice Summary Report | `ReportService` | 0 (0) |
| `/Report/PurchaseOrderDetails` | Purchase Order Details Report | Purchase Order Details Report | `ReportService` | 0 (0) |
| `/Report/PurchaseOrderPending` | Pending Purchase Orders Report | Pending Purchase Orders Report | `ReportService` | 0 (0) |
| `/Report/PurchaseOrderSummary` | Purchase Order Summary Report | Purchase Order Summary Report | `ReportService` | 0 (0) |
| `/Report/PurchaseOrderVsInvoice` | Purchase Order vs Invoice Report | Purchase Order vs Invoice Report | `ReportService` | 0 (0) |
| `/Report/PurchaseSupplierFinancialSummary` | Supplier Financial Summary Report | Supplier Financial Summary Report | `ReportService` | 0 (0) |
| `/Report/SaleBackorderDetails` | Sale Backorder Details Report | Sale Backorder Details Report | `ReportService` | 0 (0) |
| `/Report/SaleBackordersSummary` | Sale Backorder Summary Report | Sale Backorder Summary Report | `ReportService` | 0 (0) |
| `/Report/SaleCreditNotesByProduct` | Sale Credit Notes by Product Report | Sale Credit Notes by Product Report | `ReportService` | 0 (0) |
| `/Report/SaleCustomerOrderByProduct` | Customer Orders by Product Report | Customer Orders by Product Report | `ReportService` | 0 (0) |
| `/Report/SaleCustomerPaymentDetails` | Customer Payment Details Report | Customer Payment Details Report | `ReportService` | 0 (0) |
| `/Report/SaleCustomerPaymentSummary` | Customer Payment Summary Report | Customer Payment Summary Report | `ReportService` | 0 (0) |
| `/Report/SaleDocuments` | Sale Invoices & Credit Notes Report | Sale Invoices & Credit Notes Report | `ReportService` | 0 (0) |
| `/Report/SaleFulfillmentDetails` | Fulfillment Details Report | Fulfillment Details Report | `ReportService` | 0 (0) |
| `/Report/SaleOrderDetails` | Sale Order Details | Sale Order Details | `ReportService` | 0 (0) |
| `/Report/SaleOrderPending` | Pending Sale Orders Report | Pending Sale Orders Report | `ReportService` | 0 (0) |
| `/Report/SaleOutstandingQuotes` | Sale Outstanding Quotes Report | Sale Outstanding Quotes Report | `ReportService` | 0 (0) |
| `/Report/SaleOverview` | Sale Overview Report | Sale Overview Report | `ReportService` | 0 (0) |
| `/Report/SalePriceHistory` | Sale Price History Report | Sale Price History Report | `ReportService` | 0 (0) |
| `/Report/SaleProfitBySalesRepresentative` | Profit by Sales Representatives Report | Profit by Sales Representatives Report | `ReportService` | 0 (0) |
| `/Report/SaleProfitSummary` | Sale Profit Summary Report | Sale Profit Summary Report | `ReportService` | 0 (0) |
| `/Report/SalesByCustomer` | Sales by Customer Report | Sales by Customer Report | `ReportService` | 0 (0) |
| `/Report/SalesByProductDetails` | Sales by Product Details Report | Sales by Product Details Report | `ReportService` | 0 (0) |
| `/Report/SalesByProductSummary` | Sales by Product Summary Report | Sales by Product Summary Report | `ReportService` | 0 (0) |
| `/Report/SalesDemandForecast` | Sales Demand Forecast Report | Sales Demand Forecast Report | `ReportService` | 0 (0) |
| `/Report/SalesTaxSummary` | Sales Tax Report | Sales Tax Report | `SalesTaxSummaryReport2019` | 6 (3) |
| `/Report/StockReceivedVsInvoice` | Stock Received vs Invoice Report | Stock Received vs Invoice Report | `ReportService` | 0 (0) |
| `/Report/StockValueInventoryAging` | Stock Value Inventory Aging Report | Stock Value Inventory Aging Report | `ReportService` | 0 (0) |
| `/Report/TaxTransactions` | Sales Tax Transactions Report | Sales Tax Transactions Report | `ReportService` | 0 (0) |
| `/Report/TransactionPeriods` | Financial Periods Report | Financial Periods Report | `TransactionPeriods` | 3 (0) |
| `/Report/Transactions` | Transactions Report | Transactions Report | `ReportService` | 0 (0) |
| `/Report/TransactionsVsInventoryCards` | Transactions vs Stock on Hand Difference Report | Transactions vs Stock on Hand Difference Report | `ReportService` | 0 (0) |
| `/Report/TrialBalance` | Trial Balance Report | Trial Balance Report | `TrialBalanceReport2019` | 6 (3) |
| `/Report/VATReturn` | VAT Return | VAT Return | `VATReturnListReport2019` | 1 (0) |
| `/Report/VATReturnList` | VAT Return | VAT Return | `VATReturnListReport2019` | 1 (0) |
| `/Report/XeroSync` | Xero Synchronization Report | Xero Synchronization Report | `ReportService` | 0 (0) |
| `/Reports` | Reports | Reports | `Reports2019` | 3 (4) |
| `/ScheduledReportSettings` | Scheduled reports | Scheduled report settings | `ScheduledReportSettings2019` | 10 (6) |

## Data models

ExtJS models the pages use; `v` prefix = view-model. Full DDL in [`schema.sql`](schema.sql).

| Model | Fields |
|---|---|
| `Layout` | Layout:string |
| `MailingList` | ID, Name |
| `NameValue` | Name:string, Value:string |
| `ScheduledReport` | ReportName:string, Title:string, GroupName:string |
| `ScheduledReportWrapper` | ID:int, HasErrors:bool |
| `TenantLocation` | ID, Name |
| `VATReturn` | Id:string, Status:string, PublishDate:date, Name:string |
| `vMailingSettingsWrapper` | FakeID:string, ValidationText:string, ValidationState:string |
| `vReorderSuggestionGroup` | ID:string, LocationID:string, LocationName:string, MailingListID:string, LocationName:string, ValidationText:string, ValidationState:string |
| `vReport` | id:string, name:string, status:string, createDate:date, createdByUserName:string, reportTypeId:string, reportDate:string, publishDate:date |
| `vReportCurrency` | Currency:string, DisplayCurrency:string |
| `vReportGenerationLog` | ReportGenerationLogID:string, ReportID:string, ReportName:string, ReportTitle:string, StartExecutionDate:date, EndExecutionDate:date, FileID:string, FileFormat:string, FileName:string, GenerationStatus:string, GenerationMessage:string, IsEmailSended:string, EmailSendingResult:string, ExternalDownloadLink:string |
| `vReportLayout` | Fakeid:string, ReportName:string, LayoutName:string, Layout:string |
| `vReportSalesDemandTemplate` | TemplateName:string, TemplateID:string |
| `vScheduledReportSettings` | ReportID:string, IsActive:bool, ReportScheduleName:string, ReportName:string, LayoutName:string, Currency:string, DatePeriod:string, DatePeriodValue:string, Frequency:string, FrequencyValue:string, ReportFormat:string, StartExecutionDate:date, LastExecutionDate:date, LastExecutionStatus:string, MailingListIDs:string, MailingList:string, GenerationStatus:string, GenerationMessage:string, IsActiveAdmin:bool, ReportTitle:string, InventoryIntervalDays:int, ValidationText:string, ValidationState:string, UniqueParameter1:string, UniqueParameter2:string, UniqueParameter3:string, SaveToGDrive:bool, G… |
| `vTenantSystemLog` | ID:string, Date:date, TaskID:string, Category:string, Message:string, Reference:string, UserName:string |

## Internal endpoints

Grouped by controller. Effect: 🟢 read · 🟠 read + write at the same URL · 🔴 write. `api` = JSON under `/api/`, `mvc` = controller action.

### access

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/access` | api | POST REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | Action Controller DeviceID |  |  |

### Production

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/Production_vProducts` | api | GET REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | BatchSN ExpiryDate ProductID |  |  |

### QuickLinks

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/QuickLinks_Index_Tooltips/customer` | api | GET | 🟢 read | customerId |  |  |
| `/api/QuickLinks_Index_Tooltips/product` | api | GET | 🟢 read | currentPage customerId locationId productId |  |  |
| `/api/QuickLinks_Index_Tooltips/sections` | api | GET | 🟢 read |  |  |  |
| `/api/QuickLinks_Index_Tooltips/supplier` | api | GET | 🟢 read | supplierId |  |  |

### Report

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/Report/AccountSummary` | mvc |  | 🟢 read |  |  |  |
| `/Report/AccountSummaryGrid` | mvc |  | 🟢 read |  |  |  |
| `/Report/AccountingDimensionsSummary` | mvc |  | 🟢 read |  |  |  |
| `/Report/BalanceSheet` | mvc |  | 🟢 read |  |  |  |
| `/Report/BalanceSheetGrid` | mvc |  | 🟢 read |  |  |  |
| `/Report/CheckLink` | mvc | POST | 🟢 read | Category |  |  |
| `/Report/DeleteLayout` | mvc | DELETE | 🔴 write | LayoutName ReportName |  |  |
| `/Report/DeleteLayoutNew` | mvc |  | 🔴 write | layoutName reportTypeId |  |  |
| `/Report/FinancialPaymentDetails` | mvc |  | 🔴 write |  |  |  |
| `/Report/GeneralLedger` | mvc |  | 🟢 read |  |  |  |
| `/Report/GeneralLedgerGrid` | mvc |  | 🟢 read |  |  |  |
| `/Report/InventoroPotentialStockout` | mvc |  | 🟢 read |  |  |  |
| `/Report/ProductionCoManCostAnalysis` | mvc |  | 🟢 read |  |  |  |
| `/Report/ProductionComanMovementSummary` | mvc |  | 🔴 write |  |  |  |
| `/Report/Products` | mvc |  | 🟢 read |  |  |  |
| `/Report/ProfitAndLoss` | mvc |  | 🟢 read |  |  |  |
| `/Report/ProfitAndLossGrid` | mvc |  | 🟢 read |  |  |  |
| `/Report/SalesTaxSummary` | mvc |  | 🟢 read |  |  |  |
| `/Report/SalesTaxSummaryGrid` | mvc |  | 🟢 read |  |  |  |
| `/Report/TaxTransactions` | mvc |  | 🟢 read |  |  |  |
| `/Report/TransactionPeriodDetails` | mvc | GET(navigate) | 🟢 read |  |  |  |
| `/Report/TransactionPeriods` | mvc |  | 🟢 read |  |  |  |
| `/Report/TrialBalance` | mvc |  | 🟢 read |  |  |  |
| `/Report/TrialBalanceGrid` | mvc |  | 🟢 read |  |  |  |
| `/Report/VATReturn` | mvc | GET(navigate) POST | 🟢 read |  |  |  |
| `/Report/VATReturnList` | mvc |  | 🟢 read |  |  |  |
| `/Report/XeroSync` | mvc |  | 🔴 write |  |  |  |
| `/api/Report_AuditReport2019` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | category desc endDate search start startDate user |  | root |
| `/api/Report_Audit_Categories` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Report_Audit_Users` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Report_TransactionPeriodReference` | api | GET | 🟢 read |  |  |  |
| `/api/Report_TransactionPeriods` | api |  | 🟢 read |  |  |  |
| `/api/Report_TransactionPeriodsYears` | api | GET | 🟢 read |  |  |  |
| `/api/Report_VATReturnList` | api | POST REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  | root |
| `/api/Report_v` | api |  | 🟢 read |  |  |  |
| `/api/Report_vAccountCodeParameter` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Report_vReportLayout` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ReportName |  |  |
| `/api/Report_vReportsList` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | search status |  | root |

### ReportGenerationLog

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/ReportGenerationLog_vReportGenerationLog` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | reportID reportName |  | root |

### Reports

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/Reports_vUserReports` | api |  | 🟢 read |  |  |  |

### ScheduledReportProcess

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/ScheduledReportProcess/Download` | mvc |  | 🟢 read | fileID |  |  |

### ScheduledReportSettings

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/ScheduledReportSettings_Edit_CheckScheduleName` | api | GET | 🟢 read | ReportGuid ScheduleName |  |  |
| `/api/ScheduledReportSettings_Edit_Reports` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | id |  |  |
| `/api/ScheduledReportSettings_Edit_vMailingList/Get` | api |  | 🟢 read |  |  |  |
| `/api/ScheduledReportSettings_Edit_vReportCurrency` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/ScheduledReportSettings_Edit_vReportLayout` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | reportName |  |  |
| `/api/ScheduledReportSettings_Edit_vReportSalesDemandTemplate` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/ScheduledReportSettings_Edit_vScheduledReportSettings` | api | POST PUT REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | id | ID |  |
| `/api/ScheduledReportSettings_Index_vScheduledReportSettings` | api | DELETE REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | reportID status term |  | root |

### SuggestReorder

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/SuggestReorder_Report_MailingList` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/SuggestReorder_Report_vReorderSuggestionGroup` | api | PUT REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/SuggestReorder_Report_vTenantLocation` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |

## Reports and their columns

| Report | Title | Script | Columns |
|---|---|---|---|
| `AccountingDimensionsSummary` | Accounting Dimensions Summary Report | `AccountingDimensionsSummaryReport2019` | Opening balance, Turnover debit, Turnover credit, Closing balance, Account, Product, Customer/ supplier, Company contact, Expense item, Production resource |
| `DepreciationSchedule` | Depreciation Schedule Report | `Report2019` | SKU, Product, Category, Fixed asset type, Location, Serial number, Purchase date, Registration date, On hand, Purchase cost, Salvage value, Rate, Start balance, Depreciation, Accumulated depreciation, End balance |
| `DisassemblyAnalysis` | Disassembly Analysis Report | `Report2019` | Disassembly #, Date, Location, Type, Disassembled product, Disassembled SKU, Disassembled quantity, Disassembled cost, Services cost, Component SKU, Component, Component batch #, Component unit, Component quantity, Component cost, Disassembled brand, Disassembled category, Disassembled family, Disassembled tags, Disassembled unit, Year, Quarter, Month, Product additional attribute 1-10 |
| `ExpenseClaim` | Expense Claim Report | `Report2019` | Employee, Claim item, Status, Date picked, Effective date, Claim total amount, Approved amount, Due amount, Paid amount, Year, Quarter, Month, Day |
| `FinancialPaymentDetails` | Financial Payment Details Report | `FinancialPaymentDetailsReport2019` | Document total, Amount, Base currency amount, Account, Customer/ supplier, Date, Document #, Currency |
| `FindByPurchaseOrder` | Find Sale Backorder by Purchase Order Report | `FindByPurchaseOrderReport2019` | Purchase invoice #, Sale order date, Customer, Sales representative, Ship by, Ready for shipment, Purchase order #, Supplier, Stock received, Sale order #, Customer reference, Sale invoice #, SKU, Quantity ordered, Customer additional attribute 1-10, Supplier additional attribute 1-10, Tenant custom attributes |
| `FinishedGoodsAnalysis` | Production Cost Analysis Report | `FinishedGoodsAnalysisReport2019` | Completion date, Production cost, Year, Quarter, Month, Component quantity, Component, Component SKU, Yield, Component cost, Status, Location, Product, Order #, Type, Batch #, Brand, Category, Component batch #, Component unit, Family, Notes, SKU, Tags, Unit, Product additional attribute 1-10 |
| `InventoryAging` | Inventory Aging Report | `InventoryAgingReport2019` | Tags, Category, Brand, Family, Unit, Location, Bin, 0-30 days, 30-60 days, 60-90 days, 90-120 days, 120-150 days, 150-180 days, Above 180 days, Batch #, SKU, Product, Expiry date, Product additional attribute 1-10 |
| `InventoryBOMComponentDetails` | BOM Component Availability Report | `InventoryBOMComponentDetailsReport2019` | Quantity, Available, OnHand, Product, Component SKU, Product SKU, Component, Location |
| `InventoryLowOnStock` | Products Low on Stock Report | `InventoryLowOnStockReport2019` | Available, Minimum before reorder, Reorder quantity, On order, Location, Supplier, SKU, Product, Product tags, Unit, Category, Brand, Family, Barcode, Purchase price, Product additional attribute 1-10, Supplier additional attribute 1-10 |
| `InventoryMovementDetails` | Inventory Movement Details Report | `InventoryMovementDetailsReport2019` | Quantity in, Quantity out, Cost in, Cost out, Year, Quarter, Month, SKU, Product, Family, Location, Date, Type, Reference, Reference type, Document reference, Category, Brand, Tags, Expiry date, Bin, Stock locator, Barcode, Asset account, Unit, Batch #, Product additional attribute 1-10, Tenant custom attributes |
| `InventoryMovementSummary` | Inventory Movement Summary Report | `Report2019` | SKU, Product, Unit, Location, Bin, Batch/SN, Stock locator, Barcode, Quantity on hand, In, Out, Unit cost, Average cost, Stock on hand, Volume on hand, Tags, Category, Brand, Family, Product additional attribute 1-10 |
| `InventoryPriceList` | Products Price List Report | `InventoryPriceListReport2019` | SKU, Product, Barcode, Unit, Brand, Category, Tags, Family, Family option 1-3 name, Family option 1-3 value, Stock locator, Sell Price, Average cost, Weight, Length, Height, Width, Tier 2-10, Product attribute 1-10 |
| `InventoryReordering` | Products Reordering Report | `InventoryReorderingReport2019` | Brand, Family, Unit, Product tags, Available, Purchase price, Minimum before reorder, On order, Reorder quantity, Location, Supplier, SKU, Product, Category, Product additional attribute 1-10, Supplier additional attribute 1-10 |
| `InventoryStockLevel` | Products Stock Level Report | `InventoryStockLevelReport2019` | Available, Quantity on hand, Allocated, In transit, On order, Stock on hand, Volume on hand, Unit cost, Minimum before reorder, Reorder quantity, SKU, Unit, Barcode, Product, Tags, Category, Brand, Family, Bin, Location, Product additional attribute 1-10 |
| `InventorySuppliers` | Inventory Suppliers Report | `InventorySuppliersReport2019` | Supplier, SKU, Product, Supplier SKU, Supplier product name, Supplier product URL, Latest price, Fixed price, Brand, Family, Unit, Category, Product tags, Product additional attribute 1-10, Supplier additional attribute 1-10 |
| `InventoryVelocity` | Inventory Velocity Report | `InventoryVelocityReport2019` | Active, On B2B portal, Finished good, Component, Last sale, Location, Safety defined, Date added, Lead stock, On hand, Available, Units sold, Shipped per day, On order, Velocity, Days to zero (inc. on order), Days to zero, Reorder quantity, SKU, Product name, On sale channels, Days since added, Recommended action, Supplier |
| `InventoryWarehouseDetails` | Warehouse Details Report | `InventoryWarehouseDetailsReport2019` | Orders picked, SKUs picked, Time tracked, User, Location, Task, Date, Sale order # |
| `JobCostingMaterials` | Job Costing Materials Report | `Report2019` | Job #, Job, Milestone, Status, Customer, Date, Address, Contact, Supplier, SKU, Product, Unit, Quantity, Price, Tax, Total, Year, Quarter, Month, Tags, Category, Brand, Family, Product additional attribute 1-10 |
| `JobCostingProfitLoss` | Job Costing Profit & Loss Report | `Report2019` | Job #, Job, Customer, Status, Milestone, Type, Date, Reference, Address, Contact, Supplier, Start, Finish, Expense, Tax, Income, Profit, Year, Quarter, Month |
| `LotExpiry` | Lot Expiry Report | `LotExpiryReport2019` | Tags, Category, Brand, Family, Unit, Year, Quarter, Month, Bin, Quantity on hand, SKU, Product, Location, Batch #, Expiry date, Product additional attribute 1-10 |
| `OutOfStockComponentsForAutoAssembly` | Out of Stock Components for Auto-Assembly Report | `OutOfStockComponentsForAutoAssemblyReport2019` | Product SKU, Product, Allocated quantity, Needed quantity, Location, Component SKU, Component, Component unit |
| `ProductionActualVsPlannedCycleTime` | Actual vs Planned Cycle Time Report | `ActualVsPlannedTimeReport2019` | Production order #, Production run #, Product, Operation, Work center, Location, Status, Type, Version, Required by date, Planned, Actual, Overrun(+) / underrun(-), Overrun %(+) / underrun %(-), Notes, Year, Quarter, Month |
| `ProductionCoManCostAnalysis` | Co-manufacturer Production Cost Analysis | `ActualVsPlannedTimeReport2019` | Production order #, Production run #, Finished product, Co-manufacturing supplier, Co-man operation name, Work center, Location, Finished product received qty, Total co-man operation cost, Cost/unit of finished product, Year, Quarter, Month |
| `ProductionComanMovementSummary` | Co-manufacturing Components Movement Summary Report | `ActualVsPlannedTimeReport2019` | Production order #, Production run #, Operation #, Co-man, Work center, Finished product, Location, Status, Type, Input/ output, Date, Start date, Unit, Quantity in, Quantity out, Cost in, Cost out, Year, Quarter, Month, Component additional attribute 1-10 |
| `ProductionCostBreakdown` | Production Cost Breakdown Report | `ActualVsPlannedTimeReport2019` | Production order #, Production run #, SKU, Product, Location, Work center, Status, Type, Version, Actual time, Planned components cost, Actual components cost, Planned resources cost, Actual resources cost, Overhead, Total planned costs, Total actual costs, Cost overrun (+) / underrun (-), Cost overrun %(+) / underrun %(-), Notes, Year, Quarter, Month, Product additional attribute 1-10 |
| `ProductionDowntime` | Production Downtime Report | `ActualVsPlannedTimeReport2019` | Order #, Run #, Operation, Resource, Work center, Location, Status, Type, Version, Reason, Downtime, Downtime cost, Required by date, Notes |
| `ProductionFinishedProductsWastageRate` | Production Finished Products Wastage Rate Report | `ProductionFinishedProductsWastageRate2019` | Production order #, Production run #, SKU, Product, Type, Status, Location, Work center, Version, Batch #, Expiry date, Required by date, Planned/ expected quantity, Actual produced/ consumed, Total produced/ consumed, Wastage, Wastage %, Notes, Year, Quarter, Month, Tags, Category, Brand, Family, Unit, Product additional attribute 1-10 |
| `ProductionOverdue` | Production Overdue Report | `ProductionReport2019` | Production order #/ run, SKU, Product, Status, Type, Shop floor, Release date, Required by date, Demand, Sale order number, Customer, Customer contact, Sales representative, Total, To produce, In production, Ready for put away, Put away, Notes, Product additional attribute 1-10 |
| `ProductionProductsUsedInProductionBOM` | Production BOM Components and Resources Report | `ProductionReport2019` | Bill of materials, BOM type, BOM status, Version, SKU, Component/ resource, Type, Status, Quantity, Unit, Costing method, Brand, Family, Tags, Category, Product additional attribute 1-10 |
| `ProductionResourceEfficiency` | Production Resource Efficiency Report | `ActualVsPlannedTimeReport2019` | Production order #, Production run #, Product, Operation, Resource, Work center, Location, Status, Type, Version, Required by date, Planned, Actual, Overrun(+) / underrun(-), Overrun %(+) / underrun %(-), Notes, Year, Quarter, Month |
| `ProductionScheduleUpdate` | Production Required by Date Exceptions Report | `ProductionReport2019` | Production order #, SKU, Product, Status, Type, Version, Shop floor, Release date, Required by date, Demand, Sale order #, Customer, Customer contact, Sales representative, Total, To produce, In production, Ready for put away, Put away, Notes, Product additional attribute 1-10 |
| `ProductionShortage` | Production Shortage Report | `ProductionReport2019` | Production order #, Finished product, Status, Type, Version, Location, Release date, Required by date, Component, Quantity, Required, Available, On order, Shortage, Unit, Brand, Family, Category, Tags, Notes, Component additional attribute 1-10 |
| `ProfitLossByProduct` | Profit & Loss by Product Report | `Report2019` | SKU, Product, Location, Batch #, Expiry date, Date, Sale proceeds, COGS, Production / Inventory / Transfer, Profit, Year, Quarter, Month, Unit, Tags, Category, Brand, Family, Product additional attribute 1-10, Tenant custom attributes |
| `PurchaseCostAnalysis` | Purchase Cost Analysis Report | `PurchaseCostAnalysisReport2019` | PO #, Order date, Invoice #, Supplier, Supplier SKU, Supplier product, SKU, Product, Status, Location, Batch #, Expiry date, Quantity, Main cost, Additional cost, Journal cost, Tax, Total cost, Unit cost, Currency, Year, Quarter, Month, Category, Brand, Product tags, Family, Unit, Product additional attribute 1-10, Supplier additional attribute 1-10, Tenant custom attributes |
| `PurchaseDocuments` | Purchase Invoices & Credit Notes Report | `Report2019` | Invoice/ credit note, Document #, Order #, Order date, Date, Invoice due, Supplier, Account, Location, SKU, Product, Unit, Quantity, Amount, Tax, Total, Currency, Base currency amount, Base currency tax, Base currency total, Comment, Year, Quarter, Month, Brand, Category, Family, Product tags, Product additional attribute 1-10, Supplier additional attribute 1-10, Tenant custom attributes |
| `PurchaseGoodsReceivedNotInvoiced` | Stock Received Not Invoiced Report | `Report2019` | PO #, PO date, Received date, Required by, Supplier, Location, SKU, Product, Unit, Quantity, Cost, Total, Year, Quarter, Month, Brand, Category, Family, Product tags, Product additional attribute 1-10, Supplier additional attribute 1-10, Tenant custom attributes |
| `PurchaseInvoiceDetails` | Purchase Invoice Details Report | `Report2019` | PO #, Status, Invoice #, Invoice date, Invoice status, Required by, Supplier, Location, SKU, Product, Unit, Quantity, Price, Total, Currency, Comment, Year, Quarter, Month, Category, Brand, Family, Product tags, Product additional attribute 1-10, Supplier additional attribute 1-10, Tenant custom attributes |
| `PurchaseInvoiceSummary` | Purchase Invoice Summary Report | `Report2019` | PO #, Invoice #, Supplier, Invoice date, Invoice due date, Status, Invoice status, Required by, Currency, Invoice total, Paid total, Due, Year, Quarter, Month, Supplier additional attribute 1-10, Tenant custom attributes |
| `PurchaseOrderDetails` | Purchase Order Details Report | `Report2019` | PO #, PO date, PO status, Status, Required by, Invoice #, Invoice date, Invoice status, Supplier, Location, SKU, Product, Unit, Quantity, Cost, Total, Currency, Invoice currency rate, Payment currency rate, Comment, Notes, Year, Quarter, Month, Brand, Category, Family, Product tags, Product additional attribute 1-10, Supplier additional attribute 1-10, Tenant custom attributes |
| `PurchaseOrderPending` | Pending Purchase Orders Report | `Report2019` | PO #, PO date, Status, Required by, Supplier, Location, SKU, Product, Unit, Ordered, To receive, To invoice, Year, Quarter, Month, Category, Brand, Family, Product tags, Product additional attribute 1-10, Supplier additional attribute 1-10, Tenant custom attributes |
| `PurchaseOrderSummary` | Purchase Order Summary Report | `Report2019` | PO #, PO date, PO status, Status, Required by, Supplier, Invoice #, Invoice date, Invoice status, Currency, Order total, Invoice total, Paid total, Due, Year, Quarter, Month, Supplier additional attribute 1-10, Tenant custom attributes |
| `PurchaseOrderVsInvoice` | Purchase Order vs Invoice Report | `PurchaseOrderVsInvoiceReport2019` | PO #, Supplier, Location, SKU, Product, Order quantity, Invoice quantity, Difference in quantity, Order price, Invoice price, Difference in price, Order total, Invoice total, Difference in total, Currency, Year, Quarter, Month, Brand, Family, Category, Unit, Product tags, Product additional attribute 1-10, Supplier additional attribute 1-10 |
| `PurchaseSupplierFinancialSummary` | Supplier Financial Summary Report | `Report2019` | Supplier, Opening balance, Invoice total, Paid total, Closing balance, Supplier additional attribute 1-10 |
| `SaleBackorderDetails` | Sale Backorder Details Report | `SaleBackorderDetailsReport2019` | Order #, Customer reference, Date, Customer, Sales representative, Ship by, Location, SKU, Product, Quantity ordered, Category, Brand, Family, Unit, Product tags, Customer tags, Customer additional attribute 1-10, Product additional attribute 1-10, Tenant custom attributes |
| `SaleBackordersSummary` | Sale Backorder Summary Report | `SaleBackordersSummaryReport2019` | Order Number, Customer reference, Ship By, Status, Location, Supplier, SKU, Product, Unit, Quantity ordered, Quantity required, Quantity on hand, Quantity remaining, Category, Brand, Product tags, Family, Product additional attribute 1-10 |
| `SaleCreditNotesByProduct` | Sale Credit Notes by Product Report | `SaleCreditNotesByProductReport2019` | Credit note #, Credit note date, Invoice #, Invoice date, Invoice due date, Customer, Customer reference, Sales representative, Location, SKU, Product, Quantity, Credited, Sale, Discount, COGS, City, State, Postcode, Country, Year, Quarter, Month, Brand, Category, Family, Unit, Product tags, Customer tags, Customer additional attribute 1-10, Product additional attribute 1-10, Tenant custom attributes |
| `SaleCustomerOrderByProduct` | Customer Orders by Product Report | `SaleCustomerOrderByProductReport2019` | Document, Date, Customer, Customer reference, Sales representative, Shipment date, Location, SKU, Product, Quantity, Invoice, Sale, Tax, Discount, COGS, Journals, Profit, Profit less journals, City, State, Postcode, Country, Year, Quarter, Month, Category, Brand, Family, Unit, Product tags, Customer tags, Customer additional attribute 1-10, Product additional attribute 1-10, Tenant custom attributes |
| `SaleCustomerPaymentDetails` | Customer Payment Details Report | `Report2019` | Invoice #, Invoice date, Due date, Customer, Customer reference, Sales representative, Shipment date, Total invoice, Total paid, Due/credit, FX gain/ loss, Shipping address 1, City, State, Postcode, Country, Year, Quarter, Month, Customer tags, Customer additional attribute 1-10, Tenant custom attributes |
| `SaleCustomerPaymentSummary` | Customer Payment Summary Report | `Report2019` | Customer, Last invoice date, Last payment date, Total invoice, Total paid, Due/credit, FX gain/ loss, Customer tags, Customer additional attribute 1-10 |
| `SaleDocuments` | Sale Invoices & Credit Notes Report | `Report2019` | Invoice/ credit note, Document #, Order #, Order date, Date, Invoice due, Customer, Customer reference, Sales representative, Account, Location, SKU, Product, Unit, Quantity, Amount, Tax, Total, Currency, Base currency amount, Base currency tax, Base currency total, Comment, Year, Quarter, Month, Brand, Category, Family, Product tags, Customer tags, Customer additional attribute 1-10, Product additional attribute 1-10, Tenant custom attributes |
| `SaleFulfillmentDetails` | Fulfillment Details Report | `Report2019` | Order #, Order date, Customer, Customer reference, Sales representative, Location, Fulfillment #, Fulfillment status, Required by, Shipment date, Carrier, Tracking #, Shipment note, Invoice #, SKU, Product, Unit, Batch/lot, Quantity ordered, Quantity picked, Quantity packed, Quantity shipped, Total, Tax, Ship to company, Ship to contact, Shipping address, City, State, Postcode, Country, Year, Quarter, Month, Brand, Category, Family, Product tags, Customer additional attribute 1-10, Product additional attribute 1-10, Tenant custom attributes |
| `SaleOrderDetails` | Sale Order Details Report | `Report2019` | Order #, Order date, Status, Customer, Customer reference, Sales representative, Location, Carrier, Ship by, Shipment date, Delivery date, Delivery number, Invoice #, Invoice date, Invoice status, SKU, Product, Unit, Quantity, Sale, Discount, Tax, Total, Notes, Shipping address 1, City, State, Postcode, Country, Year, Quarter, Month, Brand, Category, Family, Product tags, Customer tags, Customer additional attribute 1-10, Product additional attribute 1-10, Tenant custom attributes |
| `SaleOrderPending` | Pending Sale Orders Report | `Report2019` | Order #, Date, Customer, Customer reference, Sales representative, Ship by, Location, Ship to city, Ship to state, SKU, Product, Unit, Quantity required, Currency, Year, Quarter, Month, Category, Brand, Family, Product tags, Customer tags, Customer additional attribute 1-10, Product additional attribute 1-10, Tenant custom attributes |
| `SaleOutstandingQuotes` | Sale Outstanding Quotes Report | `SaleOutstandingQuotesReport` | Order #, Date, Customer, Customer reference, Sales representative, Ship by, Location, SKU, Product, Unit, Quantity, Sale, Total, Currency, Is archived, Year, Quarter, Month, Category, Brand, Family, Product tags, Customer tags, Customer additional attribute 1-10, Product additional attribute 1-10, Tenant custom attributes |
| `SaleOverview` | Sale Overview Report | `Report2019` | Order #, Order date, Customer, Customer reference, Sales representative, Location, Status, Sale order status, Quote status, Pick status, Pack status, Ship status, Fulfillment status, Payment status, Invoice status, Ready for shipment, Ship by, Shipment date, Invoice #, Invoice date, Due date, Quoted, Ordered, Lines, Additional charges, Invoice, Sale, Paid, Due, COGS, Journals, Profit, Profit less journals, FX gain/ loss, Notes, Shipping address 1, City, State, Postcode, Country, Customer tags, Customer additional attribute 1-10, Tenant custom attributes |
| `SalePriceHistory` | Sale Price History Report | `SalePriceHistoryReport2019` | SKU, Product, Invoice date, Price tier, Price, Currency, Location, Year, Quarter, Month, Category, Brand, Product tags, Family, Unit, Product additional attribute 1-10 |
| `SaleProfitBySalesRepresentative` | Profit by Sales Representatives Report | `SaleProfitBySalesRepresentativeReport2019` | Sales representative, Customer, Customer reference, Invoice #, Invoice date, Due date, Due, Ship by, Shipment date, Invoice lines, Additional charges, Invoice total, Lines tax, Additional charges tax, Sale, Paid, COGS, Journals, Profit, Profit less journals, Gross margin, Markup, FX gain/ loss, Commission amount, Credit note #, Credit note date, Status, Shipping address 1, City, State, Postcode, Country, Customer tags, Customer additional attribute 1-10 |
| `SaleProfitSummary` | Sale Profit Summary Report | `SaleProfitSummaryReport2019` | Order #, Invoice #, Customer, Customer reference, Sales representative, Invoice date, Due date, Due, Ship by, Shipment date, Ordered, Invoice, Sale, Paid, COGS, Journals, Profit, Profit less journals, Gross margin, Markup, FX gain/ loss, Credit note #, Credit note date, Shipping address 1, City, State, Postcode, Country, Customer tags, Customer additional attribute 1-10, Tenant custom attributes |
| `SalesByCustomer` | Sales by Customer Report | `SalesByCustomerReport2019` | Customer, Sales representative, Month, No. of sales, Sales total |
| `SalesByProductDetails` | Sales by Product Details Report | `SalesByProductDetailsReport2019` | Order #, Order date, Document #, Invoice date, Invoice status, Customer, Customer reference, Sales representative, Shipment date, Shipment status, SKU, Product, Quantity, Invoice, Sale, Tax, COGS, Journals, Profit, Profit less journals, Weight, Weight units, Credit note date, Shipping address 1, City, State, Postcode, Country, Year, Quarter, Month, Category, Brand, Family, Unit, Product tags, Customer tags, Customer additional attribute 1-10, Product additional attribute 1-10, Tenant custom attributes |
| `SalesByProductSummary` | Sales by Product Summary Report | `SalesByProductSummaryReport2019` | SKU, Product, Unit, Customer, Customer reference, Sales representative, Shipment date, Quantity, Invoice, Sale, Tax, COGS, Journals, Profit, Profit less journals, Weight, Weight units, Category, Brand, Family, Product tags, Customer tags, Customer additional attribute 1-10, Product additional attribute 1-10, Tenant custom attributes |
| `SalesDemandForecast` | Sales Demand Forecast Report | `SalesDemandForecastReport` | SKU, Product, Location, Period, Quantity, Brand, Unit, Family, Category, Tags |
| `StockReceivedVsInvoice` | Stock Received vs Invoice Report | `Report2019` | PO #, Status, Stock status, Required by, Received date, Invoice #, Invoice status, Invoice date, Invoice due date, Supplier, Location, SKU, Product, Unit, Received, Invoiced, Difference in quantity, PO total, Category, Brand, Product tags, Family, Product additional attribute 1-10, Supplier additional attribute 1-10, Tenant custom attributes |
| `StockValueInventoryAging` | Stock Value Inventory Aging Report | `StockValueInventoryAgingReport2019` | SKU, Product, Location, Bin, Batch #, Expiry date, Range, Quantity, Value, Tags, Category, Brand, Family, Unit, Product additional attribute 1-10 |
| `TaxTransactions` | Sales Tax Transactions Report | `TaxTransactionsReport2019` | Document number, Sales channel, Tax rule, Tax component, Net, Tax, Gross, Sync type, Consolidation journal number |
| `Transactions` | Transactions Report | `Report2019` | Date, Type, Reference, Description, PO/SO, Invoice #, Supplier/ customer, Debit, Credit, Debit job #, Credit job #, Amount, Year, Quarter, Month |
| `TransactionsVsInventoryCards` | Transactions vs Stock on Hand Difference Report | `TransactionsVsInventoryCardsReport2019` | Task #, Link, Account, Transaction type, Stock amount, Document amount |
| `XeroSync` | Xero Synchronization Report | `XeroSyncReport2019` | Sync date, Cin7 Core number, Xero link, Status, Type, Consolidated invoice/credit note #, Payment account, Document link, Effective date, Message, Year, Quarter, Month, Day |
