# Reports: UI

Every component the page code builds, read from the shipped ExtJS bundles: grids with their columns, fields, buttons, menus, windows and custom components. Labels are the English UI text. `renders into` is the id of the `<div>` in the page's server-rendered HTML that the component mounts in; `store` names the data store (see the endpoints in [README.md](README.md)); `on click` is the handler. Visual system and shell layout: [docs/UI.md](../../docs/UI.md).

## Screens

| Route | Title | Bundles |
|---|---|---|
| `/Report/AccountSummary` | Account Summary Report | [`AccountSummaryReport2019`](#accountsummaryreport2019) |
| `/Report/AccountingDimensionsSummary` | Accounting Dimensions Summary Report | [`ReportService`](#reportservice) |
| `/Report/AuditReport` | Audit Report | [`AuditReport2019`](#auditreport2019) |
| `/Report/BalanceSheet` | Balance Sheet Report | [`BalanceSheetReport2019`](#balancesheetreport2019) |
| `/Report/DepreciationSchedule` | Depreciation Schedule Report | [`ReportService`](#reportservice) |
| `/Report/DisassemblyAnalysis` | Disassembly Analysis Report | [`ReportService`](#reportservice) |
| `/Report/ExpenseClaim` | Expense Claim Report | [`ReportService`](#reportservice) |
| `/Report/FinancialPaymentDetails` | Financial Payment Details Report | [`ReportService`](#reportservice) |
| `/Report/FindByPurchaseOrder` | Find Sale Backorder by Purchase Order Report | [`ReportService`](#reportservice) |
| `/Report/FinishedGoodsAnalysis` | Production Cost Analysis Report | [`ReportService`](#reportservice) |
| `/Report/FixedAssetOverview` | Fixed Asset Overview | [`FixedAssetOverviewReport2019`](#fixedassetoverviewreport2019) |
| `/Report/GeneralLedger` | General Ledger Report | [`GeneralLedgerReport2019`](#generalledgerreport2019) |
| `/Report/InventoryAging` | Inventory Aging Report | [`ReportService`](#reportservice) |
| `/Report/InventoryBOMComponentDetails` | BOM Component Availability Report | [`ReportService`](#reportservice) |
| `/Report/InventoryLowOnStock` | Products Low on Stock Report | [`ReportService`](#reportservice) |
| `/Report/InventoryMovementDetails` | Inventory Movement Details Report | [`ReportService`](#reportservice) |
| `/Report/InventoryMovementSummary` | Inventory Movement Summary Report | [`ReportService`](#reportservice) |
| `/Report/InventoryPriceList` | Products Price List Report | [`ReportService`](#reportservice) |
| `/Report/InventoryReordering` | Products Reordering Report | [`ReportService`](#reportservice) |
| `/Report/InventoryStockLevel` | Products Stock Level Report | [`ReportService`](#reportservice) |
| `/Report/InventorySuppliers` | Inventory Suppliers Report | [`ReportService`](#reportservice) |
| `/Report/InventoryVelocity` | Inventory Velocity Report | [`InventoryVelocityReport2019_Service`](#inventoryvelocityreport2019_service), [`ReportService`](#reportservice) |
| `/Report/InventoryWarehouseDetails` | Warehouse Details Report | [`ReportService`](#reportservice) |
| `/Report/JobCostingMaterials` | Job Costing Materials Report | [`ReportService`](#reportservice) |
| `/Report/JobCostingProfitLoss` | Job Costing Profit & Loss Report | [`ReportService`](#reportservice) |
| `/Report/LotExpiry` | Lot Expiry Report | [`ReportService`](#reportservice) |
| `/Report/OutOfStockComponentsForAutoAssembly` | Out of Stock Components for Auto-Assembly Report | [`ReportService`](#reportservice) |
| `/Report/ProductionActualVsPlannedCycleTime` | Production Actual vs Planned Cycle Time Report | [`ReportService`](#reportservice) |
| `/Report/ProductionCoManCostAnalysis` | Co-manufacturer Production Cost Analysis Report | [`ReportService`](#reportservice) |
| `/Report/ProductionComanMovementSummary` | Co-manufacturing Components Movement Report | [`ReportService`](#reportservice) |
| `/Report/ProductionCostBreakdown` | Production Cost Breakdown Report | [`ReportService`](#reportservice) |
| `/Report/ProductionDowntime` | Production Downtime Report | [`ReportService`](#reportservice) |
| `/Report/ProductionFinishedProductsWastageRate` | Production Finished Products Wastage Rate Report | [`ReportService`](#reportservice) |
| `/Report/ProductionOverdue` | Production Overdue Report | [`ReportService`](#reportservice) |
| `/Report/ProductionProductsUsedInProductionBOM` | Production BOM Components and Resources | [`ReportService`](#reportservice) |
| `/Report/ProductionResourceEfficiency` | Production Resource Efficiency Report | [`ReportService`](#reportservice) |
| `/Report/ProductionScheduleUpdate` | Production Required by Date Exceptions Report | [`ReportService`](#reportservice) |
| `/Report/ProductionShortage` | Production Shortage Report | [`ReportService`](#reportservice) |
| `/Report/Products` | Finished Product Traceability | [`TraceabilityReport2019`](#traceabilityreport2019) |
| `/Report/ProfitAndLoss` | Profit & Loss Report | [`ProfitAndLossReport2019`](#profitandlossreport2019) |
| `/Report/ProfitLossByProduct` | Profit & Loss by Product Report | [`ReportService`](#reportservice) |
| `/Report/PurchaseCostAnalysis` | Purchase Cost Analysis Report | [`ReportService`](#reportservice) |
| `/Report/PurchaseDocuments` | Purchase Invoices & Credit Notes Report | [`ReportService`](#reportservice) |
| `/Report/PurchaseGoodsReceivedNotInvoiced` | Stock Received Not Invoiced | [`ReportService`](#reportservice) |
| `/Report/PurchaseInvoiceDetails` | Purchase Invoice Details Report | [`ReportService`](#reportservice) |
| `/Report/PurchaseInvoiceSummary` | Purchase Invoice Summary Report | [`ReportService`](#reportservice) |
| `/Report/PurchaseOrderDetails` | Purchase Order Details Report | [`ReportService`](#reportservice) |
| `/Report/PurchaseOrderPending` | Pending Purchase Orders Report | [`ReportService`](#reportservice) |
| `/Report/PurchaseOrderSummary` | Purchase Order Summary Report | [`ReportService`](#reportservice) |
| `/Report/PurchaseOrderVsInvoice` | Purchase Order vs Invoice Report | [`ReportService`](#reportservice) |
| `/Report/PurchaseSupplierFinancialSummary` | Supplier Financial Summary Report | [`ReportService`](#reportservice) |
| `/Report/SaleBackorderDetails` | Sale Backorder Details Report | [`ReportService`](#reportservice) |
| `/Report/SaleBackordersSummary` | Sale Backorder Summary Report | [`ReportService`](#reportservice) |
| `/Report/SaleCreditNotesByProduct` | Sale Credit Notes by Product Report | [`ReportService`](#reportservice) |
| `/Report/SaleCustomerOrderByProduct` | Customer Orders by Product Report | [`ReportService`](#reportservice) |
| `/Report/SaleCustomerPaymentDetails` | Customer Payment Details Report | [`ReportService`](#reportservice) |
| `/Report/SaleCustomerPaymentSummary` | Customer Payment Summary Report | [`ReportService`](#reportservice) |
| `/Report/SaleDocuments` | Sale Invoices & Credit Notes Report | [`ReportService`](#reportservice) |
| `/Report/SaleFulfillmentDetails` | Fulfillment Details Report | [`ReportService`](#reportservice) |
| `/Report/SaleOrderDetails` | Sale Order Details | [`ReportService`](#reportservice) |
| `/Report/SaleOrderPending` | Pending Sale Orders Report | [`ReportService`](#reportservice) |
| `/Report/SaleOutstandingQuotes` | Sale Outstanding Quotes Report | [`ReportService`](#reportservice) |
| `/Report/SaleOverview` | Sale Overview Report | [`ReportService`](#reportservice) |
| `/Report/SalePriceHistory` | Sale Price History Report | [`ReportService`](#reportservice) |
| `/Report/SaleProfitBySalesRepresentative` | Profit by Sales Representatives Report | [`ReportService`](#reportservice) |
| `/Report/SaleProfitSummary` | Sale Profit Summary Report | [`ReportService`](#reportservice) |
| `/Report/SalesByCustomer` | Sales by Customer Report | [`ReportService`](#reportservice) |
| `/Report/SalesByProductDetails` | Sales by Product Details Report | [`ReportService`](#reportservice) |
| `/Report/SalesByProductSummary` | Sales by Product Summary Report | [`ReportService`](#reportservice) |
| `/Report/SalesDemandForecast` | Sales Demand Forecast Report | [`ReportService`](#reportservice) |
| `/Report/SalesTaxSummary` | Sales Tax Report | [`SalesTaxSummaryReport2019`](#salestaxsummaryreport2019) |
| `/Report/StockReceivedVsInvoice` | Stock Received vs Invoice Report | [`ReportService`](#reportservice) |
| `/Report/StockValueInventoryAging` | Stock Value Inventory Aging Report | [`ReportService`](#reportservice) |
| `/Report/TaxTransactions` | Sales Tax Transactions Report | [`ReportService`](#reportservice) |
| `/Report/TransactionPeriods` | Financial Periods Report | [`TransactionPeriods`](#transactionperiods) |
| `/Report/Transactions` | Transactions Report | [`ReportService`](#reportservice) |
| `/Report/TransactionsVsInventoryCards` | Transactions vs Stock on Hand Difference Report | [`ReportService`](#reportservice) |
| `/Report/TrialBalance` | Trial Balance Report | [`TrialBalanceReport2019`](#trialbalancereport2019) |
| `/Report/VATReturn` | VAT Return | [`VATReturnListReport2019`](#vatreturnlistreport2019) |
| `/Report/VATReturnList` | VAT Return | [`VATReturnListReport2019`](#vatreturnlistreport2019) |
| `/Report/XeroSync` | Xero Synchronization Report | [`ReportService`](#reportservice) |
| `/Reports` | Reports | [`Reports2019`](#reports2019) |
| `/ScheduledReportSettings` | Scheduled report settings | [`ScheduledReportSettings2019`](#scheduledreportsettings2019) |

## Components by bundle

### `AccountSummaryReport2019`

1 grids · 4 standalone fields · 0 windows · 8 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `pivotGrid_footnotes_grid` · store `self.footNotesStore` · placeholder `You do not have any footnotes on this report.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | # | `index` |  | 50 | renderer() |  |
    | note | `note` |  | flex 1 | renderer() |  |
    |  | `` | action column | 20 |  |  |


#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| combo |  | `tdReporting_Index_Period` | `DatePeriodStore` | shows `name` · value `value` · pick-only |
| date field |  | `tdReporting_Index_From` | `` | format `UserDateFormat` |
| date field |  | `tdReporting_Index_To` | `` | format `UserDateFormat` |
| combo (+ add new) |  | `tdLayoutName` | `self.layoutStore` | shows `Layout` · value `Layout` · pick-only |

#### Menus, buttons and other parts

- **component** · renders into `tdReporting_Index_AccountCode` · store `vChartOfAccountsLinesStore` · shows `DisplayName` · value `Code` · placeholder `Choose...`
- **button** “Excel” · on click `handler()`
- **button** “Excel (without totals)” · on click `handler()`
- **button** “Excel (with totals)” · on click `handler()`
- **button** “PDF” · on click `handler()`
- **button** “RTF” · on click `handler()`
- **button** · renders into `$(cellDom).children('#placeForCmb')[0]` · on click `handler()`
  - *menu:*
    - **component**
      - **button** “Add a footnote” · on click `handler()`
- **button** “{menuItemCaption}” · on click `handler()`

### `AuditReport2019`

1 grids · 4 standalone fields · 0 windows · 1 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `AuditReport_Index_Container` · store `mainStore` · placeholder `You do not have any records at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Date | `Date` | date column | flex 1 | renderer() |  |
    | Category | `Category` |  | flex 1 | renderer() |  |
    | Reference | `Reference` |  | flex 1 | renderer() |  |
    | User | `UserName` |  | flex 1 | RenderHTMLText |  |


#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| combo |  | `divFilterUser` | `FilterStoreUsers` | shows `Name` · value `Value` · placeholder `All users` |
| combo |  | `divFilterCategory` | `FilterStoreCategories` | shows `Name` · value `Value` · placeholder `All categories` |
| date field |  | `startreportrange` | `` | placeholder `Choose...` · format `dearDateFormat` |
| date field |  | `endreportrange` | `` | placeholder `Choose...` · format `dearDateFormat` |

#### Menus, buttons and other parts

- **button** “CSV file” · on click `handler()`

### `BalanceSheetReport2019`

1 grids · 4 standalone fields · 0 windows · 7 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `pivotGrid_footnotes_grid` · store `self.footNotesStore` · placeholder `You do not have any footnotes on this report.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | # | `index` |  | 50 | renderer() |  |
    | note | `note` |  | flex 1 | renderer() |  |
    |  | `` | action column | 20 |  |  |


#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| combo |  | `tdReporting_Index_balanceDates` | `datesStore` | shows `name` · value `value` · pick-only |
| combo |  | `tdReporting_Index_compareTo` | `self.compareToTypesStorage` | shows `name` · value `value` · pick-only |
| combo |  | `tdReporting_Index_comparePeriods` | `self.comparePeriodsStorage` | shows `name` · value `value` · pick-only |
| combo (+ add new) |  | `tdLayoutName` | `self.layoutStore` | shows `Layout` · value `Layout` · pick-only |

#### Menus, buttons and other parts

- **button** “Excel” · on click `handler()`
- **button** “Excel (without totals)” · on click `handler()`
- **button** “Excel (with totals)” · on click `handler()`
- **button** “PDF” · on click `handler()`
- **button** “RTF” · on click `handler()`
- **button** · renders into `$(cellDom).children('#placeForCmb')[0]` · on click `handler()`
  - *menu:*
    - **component**
      - **button** “Add a footnote” · on click `handler()`
- **button** “{menuItemCaption}” · on click `handler()`

### `GeneralLedgerReport2019`

1 grids · 4 standalone fields · 0 windows · 7 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `pivotGrid_footnotes_grid` · store `self.footNotesStore` · placeholder `You do not have any footnotes on this report.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | # | `index` |  | 50 | renderer() |  |
    | note | `note` |  | flex 1 | renderer() |  |
    |  | `` | action column | 20 |  |  |


#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| combo |  | `tdReporting_Index_Period` | `DatePeriodStore` | shows `name` · value `value` · pick-only |
| date field |  | `tdReporting_Index_From` | `` | format `UserDateFormat` |
| date field |  | `tdReporting_Index_To` | `` | format `UserDateFormat` |
| combo (+ add new) |  | `tdLayoutName` | `self.layoutStore` | shows `Layout` · value `Layout` · pick-only |

#### Menus, buttons and other parts

- **button** “Excel” · on click `handler()`
- **button** “Excel (without totals)” · on click `handler()`
- **button** “Excel (with totals)” · on click `handler()`
- **button** “PDF” · on click `handler()`
- **button** “RTF” · on click `handler()`
- **button** · renders into `$(cellDom).children('#placeForCmb')[0]` · on click `handler()`
  - *menu:*
    - **component**
      - **button** “Add a footnote” · on click `handler()`
- **button** “{menuItemCaption}” · on click `handler()`

### `InventoryVelocityReport2019_Service`

1 grids · 14 standalone fields · 0 windows · 0 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `InventoryVelocityMailing_Index_Container` · store `settingsStore` · placeholder `You do not have any mailing lists set up at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Location | `LocationID` |  | flex 2 | renderer() |  |
    | Mailing lists | `MailingListID` |  | flex 2 | renderer() |  |


#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| date field |  | `ScheduledReportEdit_startExecutionDate` | `` | placeholder `Select date` · format `UserDateFormat` |
| date field |  | `ScheduledReportEdit_lotExpiryDate` | `` | placeholder `Choose...` · format `TaskModule_DateFormatExt` |
| date field |  | `ScheduledReportEdit_effectiveDate` | `` | placeholder `Choose...` · format `TaskModule_DateFormatExt` |
| combo |  | `ScheduledReportEdit_interval` | `intervalDaysStore` | shows `name` · value `days` |
| combo |  | `ScheduledReportEdit_balanceDates` | `datesStore` | shows `name` · value `value` · pick-only |
| combo |  | `ScheduledReportEdit_compareTo` | `compareToTypesStorage` | shows `name` · value `value` · pick-only |
| combo |  | `ScheduledReportEdit_comparePeriods` | `comparePeriodsStorage` | shows `name` · value `value` · pick-only |
| combo |  | `ScheduledReportEdit_accountCode` | `vChartOfAccountsLinesStore` | shows `DisplayName` · value `Code` · pick-only |
| combo |  | `ScheduledReportEdit_DaysInterval` | `IntervalDaysStore` | shows `name` · value `value` · pick-only |
| combo |  | `ScheduledReportEdit_InventoryDetailsMode` | `InventoryDetailsModeStore` | shows `DisplayMode` · value `Mode` · pick-only |
| combo |  | `ScheduledReportEdit_SalesDemandForecastTemplate` | `vReportSalesDemandTemplateStore` | shows `TemplateName` · value `TemplateID` · pick-only |
| combo |  | `ScheduledReportEdit_BOMComponentDetails_ShowFilter` | `InventoryBOMComponentDetails_ShowFilterStore` | shows `Name` · value `Value` · placeholder `Choose...` · pick-only |
| checkbox |  | `ScheduledReportEdit_BOMComponentDetails_FilterByA…` | `` |  |
| number field |  | `ScheduledReportEdit_BOMComponentDetails_Available…` | `` |  |

### `ProfitAndLossReport2019`

1 grids · 6 standalone fields · 0 windows · 8 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `pivotGrid_footnotes_grid` · store `self.footNotesStore` · placeholder `You do not have any footnotes on this report.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | # | `index` |  | 50 | renderer() |  |
    | note | `note` |  | flex 1 | renderer() |  |
    |  | `` | action column | 20 |  |  |


#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| combo |  | `tdReporting_Index_Period` | `DatePeriodStore` | shows `name` · value `value` · pick-only |
| date field |  | `ProfitAndLoss_Index_Tab3_dtFrom` | `` | placeholder `Choose...` · format `window.UserDateFormat` |
| date field |  | `ProfitAndLoss_Index_Tab3_dtTo` | `` | placeholder `Choose...` · format `window.UserDateFormat` |
| combo |  | `ProfitAndLoss_Index_Tab3_CompareWith` | `self.compareToTypesStorage` | shows `name` · value `value` · pick-only |
| combo |  | `ProfitAndLoss_Index_Tab3_ComparePeriods` | `self.comparePeriodsStorage` | shows `name` · value `value` · pick-only |
| combo (+ add new) |  | `tdLayoutName` | `self.layoutStore` | shows `Layout` · value `Layout` · pick-only |

#### Menus, buttons and other parts

- **button** “Excel (with totals)” · on click `handler()`
- **button** “PDF” · on click `handler()`
- **button** “Rtf” · on click `handler()`
- **button** “Excel” · on click `handler()`
- **button** “Excel (without totals)” · on click `handler()`
- **button** “RTF” · on click `handler()`
- **button** · renders into `$(cellDom).children('#placeForCmb')[0]` · on click `handler()`
  - *menu:*
    - **component**
      - **button** “Add a footnote” · on click `handler()`
- **button** “{menuItemCaption}” · on click `handler()`

### `Report2019`

0 grids · 6 standalone fields · 0 windows · 4 menus, buttons and other parts · 0 custom components

#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| combo (+ add new) |  | `tdLayoutName` | `layoutStore` | shows `Layout` · value `Layout` · pick-only |
| combo |  | `tdCurrency` | `currencyStore` | shows `DisplayCurrency` · value `Currency` |
| combo |  | `tdReporting_Index_Period` | `DatePeriodStore` | shows `name` · value `value` · pick-only |
| date field |  | `tdReporting_Index_From` | `` | format `UserDateFormat` |
| date field |  | `tdReporting_Index_To` | `` | format `UserDateFormat` |
| checkbox | {"&nbsp;".concat(…)} | `chkReportFilter` | `` |  |

#### Menus, buttons and other parts

- **button** “Excel (without totals)” · on click `handler()`
- **button** “Excel (with totals)” · on click `handler()`
- **button** “PDF” · on click `handler()`
- **button** “RTF” · on click `handler()`

### `Reports2019`

1 grids · 0 standalone fields · 0 windows · 0 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `"div".concat(…)` · store `self.reportsStore` · placeholder `Ext.String.format(…)`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Name | `name` |  | flex 1 | renderer() |  |
    | Report date | `reportDate` |  | flex 1 | renderer() |  |
    | Author | `createdByUserName` |  | flex 1 | RenderHTMLText |  |
    | Create date \| Published date | `createDate \| publishDate` | date column | flex 1 | renderer() |  |


### `SalesTaxSummaryReport2019`

1 grids · 4 standalone fields · 0 windows · 7 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `pivotGrid_footnotes_grid` · store `self.footNotesStore` · placeholder `You do not have any footnotes on this report.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | # | `index` |  | 50 | renderer() |  |
    | note | `note` |  | flex 1 | renderer() |  |
    |  | `` | action column | 20 |  |  |


#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| combo |  | `tdReporting_Index_Period` | `DatePeriodStore` | shows `name` · value `value` · pick-only |
| date field |  | `tdReporting_Index_From` | `` | format `UserDateFormat` |
| date field |  | `tdReporting_Index_To` | `` | format `UserDateFormat` |
| combo (+ add new) |  | `tdLayoutName` | `self.layoutStore` | shows `Layout` · value `Layout` · pick-only |

#### Menus, buttons and other parts

- **button** “Excel” · on click `handler()`
- **button** “PDF” · on click `handler()`
- **button** “RTF” · on click `handler()`
- **button** “Excel (without totals)” · on click `handler()`
- **button** “Excel (with totals)” · on click `handler()`
- **button** · renders into `$(cellDom).children('#placeForCmb')[0]` · on click `handler()`
  - *menu:*
    - **component**
      - **button** “Add a footnote” · on click `handler()`
- **button** “{menuItemCaption}” · on click `handler()`

### `ScheduledReportSettings2019`

2 grids · 14 standalone fields · 0 windows · 0 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `ScheduledReportList_divScheduledReportGrid` · store `ScheduledReportListStore` · placeholder `You do not have any records at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | State | `IsActive` |  | flex 2 | renderer() |  |
    | Scheduled report name | `ReportScheduleName` |  | flex 2 | renderer() |  |
    | Period | `DatePeriod` |  | flex 2 | renderer() |  |
    | Frequency | `Frequency` |  | flex 2 | renderer() |  |
    | {Ext.String.format(…)} | `LastExecutionDate` |  | flex 2 | renderer() |  |
    | {Ext.String.format(…)} | `GenerationStatus` |  | flex 2 | renderer() |  |

- **grid** · renders into `ReportGenerationLog_divReportGenerationLogGrid` · store `ReportGenerationLogStore` · placeholder `You do not have any records at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Report code | `ReportName` |  | 300 | renderer() |  |
    | Run at | `StartExecutionDate` |  | flex 1 | renderer() |  |
    | End at | `EndExecutionDate` |  | flex 1 | renderer() |  |
    | Report format | `FileFormat` |  | flex 1 | renderer() |  |
    | Generation status | `GenerationStatus` |  | flex 1 | renderer() |  |
    | Generation message | `GenerationMessage` |  | flex 1 | renderer() |  |
    | Email sent | `IsEmailSended` |  | flex 1 | renderer() |  |
    | Email sending result | `EmailSendingResult` |  | flex 1 | renderer() | hidden |
    |  | `EmailSendingResult` |  | 30 | renderer() |  |


#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| date field |  | `ScheduledReportEdit_startExecutionDate` | `` | placeholder `Select date` · format `UserDateFormat` |
| date field |  | `ScheduledReportEdit_lotExpiryDate` | `` | placeholder `Choose...` · format `TaskModule_DateFormatExt` |
| date field |  | `ScheduledReportEdit_effectiveDate` | `` | placeholder `Choose...` · format `TaskModule_DateFormatExt` |
| combo |  | `ScheduledReportEdit_interval` | `intervalDaysStore` | shows `name` · value `days` |
| combo |  | `ScheduledReportEdit_balanceDates` | `datesStore` | shows `name` · value `value` · pick-only |
| combo |  | `ScheduledReportEdit_compareTo` | `compareToTypesStorage` | shows `name` · value `value` · pick-only |
| combo |  | `ScheduledReportEdit_comparePeriods` | `comparePeriodsStorage` | shows `name` · value `value` · pick-only |
| combo |  | `ScheduledReportEdit_accountCode` | `vChartOfAccountsLinesStore` | shows `DisplayName` · value `Code` · pick-only |
| combo |  | `ScheduledReportEdit_DaysInterval` | `IntervalDaysStore` | shows `name` · value `value` · pick-only |
| combo |  | `ScheduledReportEdit_InventoryDetailsMode` | `InventoryDetailsModeStore` | shows `DisplayMode` · value `Mode` · pick-only |
| combo |  | `ScheduledReportEdit_SalesDemandForecastTemplate` | `vReportSalesDemandTemplateStore` | shows `TemplateName` · value `TemplateID` · pick-only |
| combo |  | `ScheduledReportEdit_BOMComponentDetails_ShowFilter` | `InventoryBOMComponentDetails_ShowFilterStore` | shows `Name` · value `Value` · placeholder `Choose...` · pick-only |
| checkbox |  | `ScheduledReportEdit_BOMComponentDetails_FilterByA…` | `` |  |
| number field |  | `ScheduledReportEdit_BOMComponentDetails_Available…` | `` |  |

### `TraceabilityReport2019`

0 grids · 1 standalone fields · 0 windows · 1 menus, buttons and other parts · 0 custom components

#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| combo |  | `tdProduct` | `vProductStore` | shows `DisplayName` · value `FakeID` · placeholder `Choose...` |

#### Menus, buttons and other parts

- **component**
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `` |  | 100% |  |  |
    | Batch/serial # | `` |  | 250 |  |  |
    | Expiry date | `` |  | 150 |  |  |
    | Unit | `` |  | 150 |  |  |


### `TransactionPeriods`

1 grids · 0 standalone fields · 0 windows · 14 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `self.containerId` · store `self.store`
  - *columns:*
    - *(component built elsewhere: `columns`)*

#### Menus, buttons and other parts

- **column** “Total number of journal entry” · field `JournalsCount` · id `colJournalsCount`
- **column** · field `self.modelKey` · id `colMobileView` · hidden
- **column** “Period name” · field `MonthNum` · id `colMonthNum`
- **column** “Period from” · field `PeriodFrom` · id `colPeriodFrom`
- **column** “Period to” · field `PeriodTo` · id `colPeriodTo`
- **column** “Year” · field `Year` · id `colYear`
- **column** “Status” · field `IsClosed` · id `colIsClosed`
- **column** “Lock date” · field `ClosedDate` · id `colClosedDate`
- **column** “Accumulateddepreciation” · field `AccumulatedDepreciation` · id `colAccumulatedDepreciation`
- **column** “Realisedforeignexchangeadjustment” · field `RealizedForeignExchange` · id `colRealizedForeignExchange`
- **column** “Unrealizedforeignexchangeadjustment” · field `UnrealizedForeignExchange` · id `colUnrealizedForeignExchange`
- **column** “Carryforwardprofit & loss” · field `CarryForward_Profit_Loss` · id `colCarryForward_Profit_Loss`
- **column** “Unauthorizedmanualjournals” · field `DraftJournalCount` · id `colDraftJournalCount`
- **column** “Total numberof businessjournals” · field `BusinessJournalCount` · id `colBusinessJournalCount`

### `TrialBalanceReport2019`

1 grids · 7 standalone fields · 0 windows · 7 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `pivotGrid_footnotes_grid` · store `self.footNotesStore` · placeholder `You do not have any footnotes on this report.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | # | `index` |  | 50 | renderer() |  |
    | note | `note` |  | flex 1 | renderer() |  |
    |  | `` | action column | 20 |  |  |


#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| combo |  | `tdReporting_Index_Period` | `DatePeriodStore` | shows `name` · value `value` · pick-only |
| date field |  | `tdReporting_Index_From` | `` | format `UserDateFormat` |
| date field |  | `tdReporting_Index_To` | `` | format `UserDateFormat` |
| combo |  | `tdReporting_Index_balanceDates` | `datesStore` | shows `name` · value `value` · pick-only |
| combo |  | `tdReporting_Index_compareTo` | `self.compareToTypesStorage` | shows `name` · value `value` · pick-only |
| combo |  | `tdReporting_Index_comparePeriods` | `self.comparePeriodsStorage` | shows `name` · value `value` · pick-only |
| combo (+ add new) |  | `tdLayoutName` | `self.layoutStore` | shows `Layout` · value `Layout` · pick-only |

#### Menus, buttons and other parts

- **button** “Excel” · on click `handler()`
- **button** “Excel (without totals)” · on click `handler()`
- **button** “Excel (with totals)” · on click `handler()`
- **button** “PDF” · on click `handler()`
- **button** “RTF” · on click `handler()`
- **button** · renders into `$(cellDom).children('#placeForCmb')[0]` · on click `handler()`
  - *menu:*
    - **component**
      - **button** “Add a footnote” · on click `handler()`
- **button** “{menuItemCaption}” · on click `handler()`

