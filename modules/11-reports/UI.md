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

## Layout

Each screen's server-rendered HTML inside the shell, as an outline: headings, tabs, sections, labels, inputs (`#id`), buttons (`▾` = dropdown), menus, tables and `slot`s (empty `<div>`s the components below mount into). `(hidden)` parts are shown by the page code when needed. Read with GET from a signed-in session; no values are kept.

### `/Report/AccountSummary`: Account Summary Report

Frame: `task-upload-frame`.

```text
form#rptExport
  block #divReport
    block #AccountSummaryReport
      link "Home"
      link "Reports"
      block #tdStatus
      slot #tdLayoutName
      button "Delete layout"#divDelete
      button "Reset layout"
      button "Save layout as"#divSaveAs primary
      heading "Account Summary Report"
      button "Fields specification"#fieldsSpecification
      block #taskActions
        button "Save" primary
        button "Publish" primary
        button "Archive" primary
        button "Apply filter"
        button "Export"#divExport ▾
        button "Reconcile with Xero"#divXeroReconcilation (hidden)
        button "Export the detailed General Ledger to Excel"#divExportDetailedLedger primary (hidden)
        button "Back to reports"
        button "{{navigateBackCaption}}"
      block #divTaskHeader
        slot #tdReporting_Index_AccountCode
        label "Account code"
        slot #tdReporting_Index_Period
        slot #tdReporting_Index_From
        slot #tdReporting_Index_To
        button "Update"
        input text#divSearch placeholder "Type text to search"
        button "Search" primary
      heading "Account Summary"
      heading #reportCompanyName
      heading #reportDate
      block #divAccountSummaryGrid
      heading "Notes"
      slot #pivotGrid_footnotes_grid
    modal#divReportNameDialog small
      heading "Publish the report"
      button "x"
      label "Please enter a name" for #Report_NewLayout_Name
      input text#txtReportName
      block #DialogActions
        button "Publish" primary
        button "Close"
block #divBalanceSheetTransactions (hidden)
  slot #formHeader
  slot #transactionAccountName
  button #backAction
  button "Update"
  button "Apply filter"
  heading #transactionHeader
  heading #transactionCompanyName
  heading #transactionDatePeriod
  slot #divBalanceSheetTransactionsGrid
modal#Report_NewLayout_Content small
  heading "Name your layout"
  button "x"
  label "Layout name" for #Report_NewLayout_Name
  input text#tdReport_NewLayout_Name
  button "Save"#newLayoutFooter primary
  button "Save"#saveAsLayoutFooter primary (hidden)
  button "Close"
modal#fieldsSpecificationModal small
  heading "Fields specification"
  button "x"
  text "The default report provides you with a summary of all the transactions for the selected period. Use this detailed report"
```

### `/Report/AccountingDimensionsSummary`: Accounting Dimensions Summary Report

Frame: `iReportFrame`.

```text
link "Home"
link "Reports"
block #divReportFrameLoading
slot #iReportFrame (hidden)
modal#fieldsSpecificationModal small
  heading "Fields specification"
  button "x"
  text "Accounting Dimensions Summary"
```

### `/Report/AuditReport`: Audit Report

Frame: `task-upload-frame`.

```text
block #AuditReport
  block #divList
    link "Home"
    link "Reports"
    heading "Audit Report"
    block #buttonContainer
      button "Back to reports"#backAction
      block #divExportReport
        button "Export" ▾
        link "Excel"
        link "PDF"
        link "RTF"
    button #GridOptions
    input text#divSearch placeholder "Type text to search"
    label "Search" for #divSearch
    button "Search" primary
    block #dashboard-report-range
      button "Choose..."#spDateTangeLabel ▾
      label "Date range"
      slot #startreportrange
      label "From"
      slot #endreportrange
      label "To"
      button "Apply"#btnApplyDateRange primary
    button #divRefresh
    slot #divFilterCategory
    label "Category"
    slot #divFilterUser
    label "User"
    slot #AuditReport_Index_Container
form#frmExport
```

### `/Report/BalanceSheet`: Balance Sheet Report

Frame: `task-upload-frame`.

```text
form#rptExport
  block #divReport
    block #BalanceSheetReport
      link "Home"
      link "Reports"
      block #tdStatus
      slot #tdLayoutName
      button "Delete layout"#divDelete
      button "Reset layout"
      button "Save layout as"#divSaveAs primary
      heading "Balance Sheet Report"
      button "Fields specification"#fieldsSpecification
      block #taskActions
        button "Save" primary
        button "Publish" primary
        button "Archive" primary
        button "Apply filter"
        button "Export"#divExport ▾
        button "Reconcile with Xero"#divXeroReconcilation (hidden)
        button "Export the detailed General Ledger to Excel"#divExportDetailedLedger primary (hidden)
        button "Back to reports"
        button "{{navigateBackCaption}}"
      block #divTaskHeader
        slot #tdReporting_Index_balanceDates
        label "Balance dates"
        slot #tdReporting_Index_compareTo
        label "Compare to"
        slot #tdReporting_Index_comparePeriods
        label "Compare periods"
        button "Update"
        input text#divSearch placeholder "Type text to search"
        button "Search" primary
      heading "Balance Sheet Report"
      heading #reportCompanyName
      heading #reportDate
      block #divBalanceSheetGrid
      heading "Notes"
      slot #pivotGrid_footnotes_grid
    modal#divReportNameDialog small
      heading "Publish the report"
      button "x"
      label "Please enter a name" for #Report_NewLayout_Name
      input text#txtReportName
      block #DialogActions
        button "Publish" primary
        button "Close"
block #divBalanceSheetTransactions (hidden)
  slot #formHeader
  slot #transactionAccountName
  button #backAction
  button "Update"
  button "Apply filter"
  heading #transactionHeader
  heading #transactionCompanyName
  heading #transactionDatePeriod
  slot #divBalanceSheetTransactionsGrid
modal#Report_NewLayout_Content small
  heading "Name your layout"
  button "x"
  label "Layout name" for #Report_NewLayout_Name
  input text#tdReport_NewLayout_Name
  button "Save"#newLayoutFooter primary
  button "Save"#saveAsLayoutFooter primary (hidden)
  button "Close"
modal#fieldsSpecificationModal small
  heading "Fields specification"
  button "x"
  text "This report shows the balance of all of your accounts for the selected time period. Use this report to compare account b"
```

### `/Report/DepreciationSchedule`: Depreciation Schedule Report

Frame: `iReportFrame`.

```text
link "Home"
link "Reports"
block #divReportFrameLoading
slot #iReportFrame (hidden)
modal#fieldsSpecificationModal small
  heading "Fields specification"
  button "x"
  text "The Depreciation Schedule shows actual or estimated depreciation against assets in the asset register (only registered i"
```

### `/Report/DisassemblyAnalysis`: Disassembly Analysis Report

Frame: `iReportFrame`.

```text
link "Home"
link "Reports"
block #divReportFrameLoading
slot #iReportFrame (hidden)
modal#fieldsSpecificationModal small
  heading "Fields specification"
  button "x"
  text "This report shows completed disassemblies within the selected time period. Use this report to analyze disassembled quant"
```

### `/Report/ExpenseClaim`: Expense Claim Report

Frame: `iReportFrame`.

```text
link "Home"
link "Reports"
block #divReportFrameLoading
slot #iReportFrame (hidden)
modal#fieldsSpecificationModal small
  heading "Fields specification"
  button "x"
  text "This report shows detailed analysis of the claims data captured over a specific period of time, including claim total am"
  slot #attributesDescriptions
```

### `/Report/FinancialPaymentDetails`: Financial Payment Details Report

Frame: `iReportFrame`.

```text
link "Home"
link "Reports"
block #divReportFrameLoading
slot #iReportFrame (hidden)
modal#fieldsSpecificationModal small
  heading "Fields specification"
  button "x"
  text "Detailed financial payments within a given period of time for selected account. Use this report to view detailed transac"
```

### `/Report/FindByPurchaseOrder`: Find Sale Backorder by Purchase Order Report

Frame: `iReportFrame`.

```text
link "Home"
link "Reports"
block #divReportFrameLoading
slot #iReportFrame (hidden)
modal#fieldsSpecificationModal small
  heading "Fields specification"
  button "x"
  text "This report allows finding all sales included in a specific purchase order created via the 'reorder backordered' functio"
  slot #attributesDescriptions
```

### `/Report/FinishedGoodsAnalysis`: Production Cost Analysis Report

Frame: `iReportFrame`.

```text
link "Home"
link "Reports"
block #divReportFrameLoading
slot #iReportFrame (hidden)
modal#fieldsSpecificationModal small
  heading "Fields specification"
  button "x"
  text "This report shows completed finished goods within the selected time period. Use this report to analyze production yield "
```

### `/Report/FixedAssetOverview`: Fixed Asset Overview

Frame: `task-upload-frame`.

```text
block #FixedAssetOverviewReport
  link "Home"
  link "Reports"
  heading "Fixed Asset Overview"
  button "Tutorial"
  button "Back to reports"#backAction
modal#Report_NewLayout_Content small
  heading "Name your layout"
  button "x"
  label "Layout name" for #Report_NewLayout_Name
  input text#tdReport_NewLayout_Name
  button "Save"#newLayoutFooter primary
  button "Save"#saveAsLayoutFooter primary (hidden)
  button "Close"
```

### `/Report/GeneralLedger`: General Ledger Report

Frame: `task-upload-frame`.

```text
form#rptExport
  block #divReport
    block #GeneralLedgerReport
      link "Home"
      link "Reports"
      block #tdStatus
      slot #tdLayoutName
      button "Delete layout"#divDelete
      button "Reset layout"
      button "Save layout as"#divSaveAs primary
      heading "General Ledger Report"
      button "Fields specification"#fieldsSpecification
      block #taskActions
        button "Save" primary
        button "Publish" primary
        button "Archive" primary
        button "Apply filter"
        button "Export"#divExport ▾
        button "Reconcile with Xero"#divXeroReconcilation (hidden)
        button "Export the detailed General Ledger to Excel"#divExportDetailedLedger primary (hidden)
        button "Back to reports"
        button "{{navigateBackCaption}}"
      block #divTaskHeader
        slot #tdReporting_Index_Period
        slot #tdReporting_Index_From
        slot #tdReporting_Index_To
        button "Update"
        input text#divSearch placeholder "Type text to search"
        button "Search" primary
      heading "General Ledger"
      heading #reportCompanyName
      heading #reportDate
      block #divGeneralLedgerGrid
      heading "Notes"
      slot #pivotGrid_footnotes_grid
    modal#divReportNameDialog small
      heading "Publish the report"
      button "x"
      label "Please enter a name" for #Report_NewLayout_Name
      input text#txtReportName
      block #DialogActions
        button "Publish" primary
        button "Close"
block #divBalanceSheetTransactions (hidden)
  slot #formHeader
  slot #transactionAccountName
  button #backAction
  button "Update"
  button "Apply filter"
  heading #transactionHeader
  heading #transactionCompanyName
  heading #transactionDatePeriod
  slot #divBalanceSheetTransactionsGrid
modal#Report_NewLayout_Content small
  heading "Name your layout"
  button "x"
  label "Layout name" for #Report_NewLayout_Name
  input text#tdReport_NewLayout_Name
  button "Save"#newLayoutFooter primary
  button "Save"#saveAsLayoutFooter primary (hidden)
  button "Close"
modal#fieldsSpecificationModal small
  heading "Fields specification"
  button "x"
  text "The default report provides you with a summary of all the transactions for the selected period. The Excel detailed repor"
```

### `/Report/InventoryAging`: Inventory Aging Report

Frame: `iReportFrame`.

```text
link "Home"
link "Reports"
block #divReportFrameLoading
slot #iReportFrame (hidden)
modal#fieldsSpecificationModal small
  heading "Fields specification"
  button "x"
  text "This report shows the average age of your inventory. Use this report to see how long products stay in stock measured by "
```

### `/Report/InventoryBOMComponentDetails`: BOM Component Availability Report

Frame: `iReportFrame`.

```text
link "Home"
link "Reports"
block #divReportFrameLoading
slot #iReportFrame (hidden)
modal#fieldsSpecificationModal small
  heading "Fields specification"
  button "x"
  text "View a list of BOM products that consist of the queried component items along with their relevant product details."
```

### `/Report/InventoryLowOnStock`: Products Low on Stock Report

Frame: `iReportFrame`.

```text
link "Home"
link "Reports"
block #divReportFrameLoading
slot #iReportFrame (hidden)
modal#fieldsSpecificationModal small
  heading "Fields specification"
  button "x"
  text "This report shows stock level details necessary for stock refill. Use this report so see available, on order, reorder an"
```

### `/Report/InventoryMovementDetails`: Inventory Movement Details Report

Frame: `iReportFrame`.

```text
link "Home"
link "Reports"
block #divReportFrameLoading
slot #iReportFrame (hidden)
modal#fieldsSpecificationModal small
  heading "Fields specification"
  button "x"
  text "This report shows a summary of stock movements in a specified timeframe. Use this report to see inventory movement detai"
  slot #attributesDescriptionsSale
  slot #attributesDescriptionsPurchase
```

### `/Report/InventoryMovementSummary`: Inventory Movement Summary Report

Frame: `iReportFrame`.

```text
link "Home"
link "Reports"
block #divReportFrameLoading
slot #iReportFrame (hidden)
modal#fieldsSpecificationModal small
  heading "Fields specification"
  button "x"
  text "This report shows a summary of stock movements in a specified timeframe. Use this report to see financial information su"
```

### `/Report/InventoryPriceList`: Products Price List Report

Frame: `iReportFrame`.

```text
link "Home"
link "Reports"
block #divReportFrameLoading
slot #iReportFrame (hidden)
modal#fieldsSpecificationModal small
  heading "Fields specification"
  button "x"
  text "This report shows a product price list. Use this report to see all of your inventory products listed with prices from up"
  link "General Settings"
```

### `/Report/InventoryReordering`: Products Reordering Report

Frame: `iReportFrame`.

```text
link "Home"
link "Reports"
block #divReportFrameLoading
slot #iReportFrame (hidden)
modal#fieldsSpecificationModal small
  heading "Fields specification"
  button "x"
  text "This report shows stock level details necessary for stock refill. Use this report so see available, on order, reorder an"
```

### `/Report/InventoryStockLevel`: Products Stock Level Report

Frame: `iReportFrame`.

```text
link "Home"
link "Reports"
block #divReportFrameLoading
slot #iReportFrame (hidden)
modal#fieldsSpecificationModal small
  heading "Fields specification"
  button "x"
  text "This report shows the current stock level of all active products in all locations. Use this report to see available, on-"
```

### `/Report/InventorySuppliers`: Inventory Suppliers Report

Frame: `iReportFrame`.

```text
link "Home"
link "Reports"
block #divReportFrameLoading
slot #iReportFrame (hidden)
modal#fieldsSpecificationModal small
  heading "Fields specification"
  button "x"
  text "This report shows the latest price and fixed price (if applicable) for every supplier/product combination. Use this repo"
```

### `/Report/InventoryVelocity`: Inventory Velocity Report

Frame: `iReportFrame`.

```text
link "Home"
link "Reports"
block #divReportFrameLoading
slot #iReportFrame (hidden)
block #divMailingList (hidden)
  heading "Mailing lists for location mapping"
  text "Specify recipients for the reorder suggestion email, for each location in Cin7 Core"
  button "Mailing list"#divNew primary
  button "Save"#divSaveChanges primary
  slot #InventoryVelocityMailing_Index_Container
modal#fieldsSpecificationModal medium
  heading "Fields specification"
  button "x"
  text "This report shows information about each SKU, including its sales velocity, the number of available items in stock, the "
  slot #attributesDescriptions
modal#divScheduleReport medium
  heading "Report scheduling"
  button "x"
  block #reportScheduling_warning (hidden)
  heading "1. Report"
  input checkbox#ScheduledReportEdit_isActive
  label "Enabled" for #ScheduledReportEdit_isActive
  input text#ScheduledReportEdit_reportScheduleName placeholder "Scheduled report name"
  label "Name" for #ScheduledReportEdit_reportScheduleName
  label "Please select a report for scheduling" for #ScheduledReportEdit_reportName
  select#ScheduledReportEdit_reportName
  block #GSuite_SaveToGDrive_Block (hidden)
    input checkbox#ScheduledReportEdit_GSuitesSaveToGDrive
    label "Save to Google Drive" for #ScheduledReportEdit_GSuitesSaveToGDrive
    heading "Location"
    button "Change"#btnScheduledReportChangeGDriveLocation primary
    block #scheduledReportGDriveWarning (hidden)
      slot #scheduledReportGDriveWarningText
    slot #gdLocationNameReporting
  heading "2. Layout and period"
  select#ScheduledReportEdit_layoutName
  label "Please select a layout" for #ScheduledReportEdit_layoutName
  block #reportScheduling_intervalBlock
    label "Select inventory interval *" for #ScheduledReportEdit_interval
    slot #ScheduledReportEdit_interval
  block #reportScheduling_withSafetyStock
    input checkbox#chkWithSafetyStock
    label "Calculate reorder quantity using safety stock" for #chkWithSafetyStock
  block #SalesDemandForecast_Template_Block (hidden)
    label "Select template *"
    slot #ScheduledReportEdit_SalesDemandForecastTemplate
  block #reportScheduling_modeBlock (hidden)
    block #reportModes
      label "Mode *"
      select#reportMode: Period | As of date
  block #reportScheduling_asOfDateBlock
    block #reportAsOfDate
      label "As of *"
      select#asOfDrpDown: Today | Yesterday | Date offset
  block #ScheduledReportEdit_reportDateOffsetBlock
    input text#ScheduledReportEdit_reportDateOffset
    label "Date offset (days)" for #ScheduledReportEdit_reportDateOffset
  block #reportScheduling_periodBlock
    block #reportPeriods
      label "Select a period for the reporting *"
      select#dateperiod
    block #divCustomValue
      input text#ScheduledReportEdit_datePeriodValue placeholder "0"
    block #backUpPeriods (hidden)
      label "Backup period *"
      select#ScheduledReportEdit_backUpPeriods: Last 30 days | Last 60 days | Last 90 days | Last 365 days
  block #reportScheduling_onlyNonZeroValue
    input checkbox#chkOnlyNonZeroValue
    label "Non-zero quantities only" for #chkOnlyNonZeroValue
  block #reportScheduling_accountCode (hidden)
    label "Account code *"
    slot #ScheduledReportEdit_accountCode
  block #reportScheduling_balanceDates (hidden)
    label "Balance dates *"
    slot #ScheduledReportEdit_balanceDates
  block #reportScheduling_compareTo (hidden)
    label "Compare to *"
    slot #ScheduledReportEdit_compareTo
  block #reportScheduling_comparePeriods (hidden)
    label "Compare periods *"
    slot #ScheduledReportEdit_comparePeriods
  block #reportScheduling_currencyBlock (hidden)
    label "Report currency *"
    select#ScheduledReportEdit_currencyName
  block #reportScheduling_quoteStatusBlock (hidden)
    label "Quote status *"
    select#ScheduledReportEdit_quoteStatus: All quotes | Drafts only | Authorized only
  block #reportScheduling_cogsBlock (hidden)
    label "Show COGS *"
    select#ScheduledReportEdit_cogs: Only COGS within date range | All COGS
  block #reportScheduling_cogsBlock (hidden)
    label "Show COGS *"
    select#ScheduledReportEdit_cogs: Only COGS within date range | All COGS
  block #reportScheduling_costsBlock (hidden)
    label "Show journal costs *"
    select#ScheduledReportEdit_costs: Only journal costs within date range | Show journal costs
  block #reportScheduling_lotExpiry (hidden)
    label "Lot expire before *"
    slot #ScheduledReportEdit_lotExpiryDate
  block #reportScheduling_effectiveDate (hidden)
    label "Effective date to *"
    slot #ScheduledReportEdit_effectiveDate
  block #reportScheduling_BOMComponentDetails_ShowFilter (hidden)
    label "Show *"
    slot #ScheduledReportEdit_BOMComponentDetails_ShowFilter
  block #reportScheduling_BOMComponentDetails_FilterByAvailable (hidden)
    label "Filter by available *"
    slot #ScheduledReportEdit_BOMComponentDetails_FilterByAvailable
    block #reportScheduling_BOMComponentDetails_AvailableQtyLessThan (hidden)
      label "Quantity is less than *"
      slot #ScheduledReportEdit_BOMComponentDetails_AvailableQtyLessThan
  block #reportScheduling_DaysInterval (hidden)
    label "Aging bucket *"
    slot #ScheduledReportEdit_DaysInterval
  block #reportScheduling_InventoryDetailsMode (hidden)
    label "Filter by *"
    slot #ScheduledReportEdit_InventoryDetailsMode
  block #reportScheduling_timeShowInFormat (hidden)
    label "Show in *"
    select#ScheduledReportEdit_timeShowInFormat: Seconds | Minutes | Hours
  heading "3. Additional"
  label "Schedule from *" for #ScheduledReportEdit_startExecutionDate
  slot #ScheduledReportEdit_startExecutionDate
  label "Run at *" for #ScheduledReportEdit_startExecutionTime
  input text#ScheduledReportEdit_startExecutionTime
  label "Frequency *" for #ScheduledReportEdit_reportName
  select#ScheduledReportEdit_frequency: Daily report | Weekly report | Monthly report | Quarter report | Year report | Custom
  block #divFrequencyValue (hidden)
    label "Repeat every *"
    input text#ScheduledReportEdit_frequencyValue placeholder "Repeat every X day(s)"
  label "Mailing list *" for #ScheduledReportEdit_mailingList
  select#ScheduledReportEdit_mailingList multiple
  block #divReportFomrat
    label "Report format *" for #ScheduledReportEdit_reportFormat
    select#ScheduledReportEdit_reportFormat: PDF | RTF | Excel with totals | Excel without totals
  block #reportScheduling_dataBakup (hidden)
    label "Select data for backup *"
    block #dataBackupDiv
      input checkbox#checkall name=checkallbackupdata
      label "Select all" for #checkall
      input checkbox#inv_lst name=backupdata
      label "Inventory list" for #inv_lst
      input checkbox#stck_hnd name=backupdata
      label "Stock on hand" for #stck_hnd
      input checkbox#dsc_mtr name=backupdata
      label "Discount matrix" for #dsc_mtr
      input checkbox#bll_mt name=backupdata
      label "Bill of materials" for #bll_mt
      input checkbox#prod_bom name=backupdata
      label "Production BOM" for #prod_bom
      input checkbox#stck_rrd_lc name=backupdata
      label "Stock reorder locations" for #stck_rrd_lc
      input checkbox#prd_pr_spp name=backupdata
      label "Product Prices by Supplier" for #prd_pr_spp
      input checkbox#smrt_rrd_cnf name=backupdata
      label "Reorder parameters" for #smrt_rrd_cnf
      input checkbox#aun_ms name=backupdata
      label "Additional units of measure" for #aun_ms
      input checkbox#mrk_pr name=backupdata
      label "Markup prices" for #mrk_pr
      input checkbox#cst_pr name=backupdata
      label "Custom prices" for #cst_pr
      input checkbox#sppl name=backupdata
      label "Suppliers" for #sppl
      input checkbox#sppl_addr name=backupdata
      label "Supplier addresses" for #sppl_addr
      input checkbox#cst name=backupdata
      label "Customers" for #cst
      input checkbox#cst_addr name=backupdata
      label "Customer addresses" for #cst_addr
      input checkbox#un_ms name=backupdata
      label "Units of measure" for #un_ms
      input checkbox#gft_crd name=backupdata
      label "Gift cards" for #gft_crd
      input checkbox#lc_bns name=backupdata
      label "Locations/ bins" for #lc_bns
      input checkbox#shpp_zne name=backupdata
      label "Shipping zones" for #shpp_zne
      input checkbox#chrt_acc name=backupdata
      label "Chart of accounts" for #chrt_acc
      input checkbox#prd_brnd name=backupdata
      label "Product brands" for #prd_brnd
      input checkbox#prd_ct name=backupdata
      label "Product categories" for #prd_ct
      input checkbox#add_attr name=backupdata
      label "Additional attributes" for #add_attr
      input checkbox#crr name=backupdata
      label "Carriers" for #crr
      input checkbox#pym name=backupdata
      label "Payments" for #pym
      input checkbox#tx_rl name=backupdata
      label "Tax rules" for #tx_rl
      input checkbox#cmp_cnt name=backupdata
      label "Company contacts" for #cmp_cnt
      input checkbox#cnt_addr name=backupdata
      label "Contact addresses" for #cnt_addr
      input checkbox#sl name=backupdata
      label "Sales" for #sl
      input checkbox#prch name=backupdata
      label "Purchases" for #prch
  button "Save" primary
  button "Cancel"#cancel-button
```

### `/Report/InventoryWarehouseDetails`: Warehouse Details Report

Frame: `iReportFrame`.

```text
link "Home"
link "Reports"
block #divReportFrameLoading
slot #iReportFrame (hidden)
modal#fieldsSpecificationModal small
  heading "Fields specification"
  button "x"
  text "This report shows warehouse details for fulfilled sale orders in selected date range. The report shows warehouse pickers"
```

### `/Report/JobCostingMaterials`: Job Costing Materials Report

Frame: `iReportFrame`.

```text
link "Home"
link "Reports"
block #divReportFrameLoading
slot #iReportFrame (hidden)
modal#fieldsSpecificationModal small
  heading "Fields specification"
  button "x"
  text "This report shows materials and stock used on a particular job during the selected time period. It also indicates where "
```

### `/Report/JobCostingProfitLoss`: Job Costing Profit & Loss Report

Frame: `iReportFrame`.

```text
link "Home"
link "Reports"
block #divReportFrameLoading
slot #iReportFrame (hidden)
modal#fieldsSpecificationModal small
  heading "Fields specification"
  button "x"
  text "This report shows the profit/loss for each job. Use this report to view all income, expenses and profits associated with"
```

### `/Report/LotExpiry`: Lot Expiry Report

Frame: `iReportFrame`.

```text
link "Home"
link "Reports"
block #divReportFrameLoading
slot #iReportFrame (hidden)
modal#fieldsSpecificationModal small
  heading "Fields specification"
  button "x"
  text "This report shows all product batches with their expiry dates. Use this report to check how much quantity on hand you ha"
```

### `/Report/OutOfStockComponentsForAutoAssembly`: Out of Stock Components for Auto-Assembly Report

Frame: `iReportFrame`.

```text
link "Home"
link "Reports"
block #divReportFrameLoading
slot #iReportFrame (hidden)
modal#fieldsSpecificationModal small
  heading "Fields specification"
  button "x"
  text "This report shows out of stock components for auto-assembly products grouped by location. Use this report to see the qua"
```

### `/Report/ProductionActualVsPlannedCycleTime`: Production Actual vs Planned Cycle Time Report

Frame: `iReportFrame`.

```text
link "Home"
link "Reports"
block #divReportFrameLoading
slot #iReportFrame (hidden)
modal#fieldsSpecificationModal small
  heading "Fields specification"
  button "x"
  text "This report shows the ratio of planned time vs actual time spent on production, showing data for production orders, prod"
```

### `/Report/ProductionCoManCostAnalysis`: Co-manufacturer Production Cost Analysis Report

Frame: `iReportFrame`.

```text
link "Home"
link "Reports"
block #divReportFrameLoading
slot #iReportFrame (hidden)
modal#fieldsSpecificationModal small
  heading "Fields specification"
  button "x"
  text "This report shows co-manufacturing production costs associated with finished products. Use this report to analyze co-man"
```

### `/Report/ProductionComanMovementSummary`: Co-manufacturing Components Movement Report

Frame: `iReportFrame`.

```text
link "Home"
link "Reports"
block #divReportFrameLoading
slot #iReportFrame (hidden)
modal#fieldsSpecificationModal small
  heading "Fields specification"
  button "x"
  text "This report shows component movements between co-manufacturers during production. It shows cost and quantity of stock en"
```

### `/Report/ProductionCostBreakdown`: Production Cost Breakdown Report

Frame: `iReportFrame`.

```text
link "Home"
link "Reports"
block #divReportFrameLoading
slot #iReportFrame (hidden)
modal#fieldsSpecificationModal small
  heading "Fields specification"
  button "x"
  text "This report shows the costs breakdown by resource costs, material costs and manufacturing overhead endured and costs ove"
```

### `/Report/ProductionDowntime`: Production Downtime Report

Frame: `iReportFrame`.

```text
link "Home"
link "Reports"
block #divReportFrameLoading
slot #iReportFrame (hidden)
modal#fieldsSpecificationModal small
  heading "Fields specification"
  button "x"
  text "Downtime report is intended for display of downtime for the production process. This is the time when resource is not wo"
```

### `/Report/ProductionFinishedProductsWastageRate`: Production Finished Products Wastage Rate Report

Frame: `iReportFrame`.

```text
link "Home"
link "Reports"
block #divReportFrameLoading
slot #iReportFrame (hidden)
modal#fieldsSpecificationModal small
  heading "Fields specification"
  button "x"
  text "This report shows the planned/expected production quantities compared with actually consumed quantities. Use this report"
```

### `/Report/ProductionOverdue`: Production Overdue Report

Frame: `iReportFrame`.

```text
link "Home"
link "Reports"
block #divReportFrameLoading
slot #iReportFrame (hidden)
modal#fieldsSpecificationModal small
  heading "Fields specification"
  button "x"
  text "This report shows production orders/runs which have not been started on the required date. Use this report to see which "
```

### `/Report/ProductionProductsUsedInProductionBOM`: Production BOM Components and Resources

Frame: `iReportFrame`.

```text
link "Home"
link "Reports"
block #divReportFrameLoading
slot #iReportFrame (hidden)
modal#fieldsSpecificationModal small
  heading "Fields specification"
  button "x"
  text "This reports shows a list of all components and resources used in production and assembly BOMs, showing component detail"
```

### `/Report/ProductionResourceEfficiency`: Production Resource Efficiency Report

Frame: `iReportFrame`.

```text
link "Home"
link "Reports"
block #divReportFrameLoading
slot #iReportFrame (hidden)
modal#fieldsSpecificationModal small
  heading "Fields specification"
  button "x"
  text "This report allows users to compare planned time with actual time for all completed production operations, production ru"
```

### `/Report/ProductionScheduleUpdate`: Production Required by Date Exceptions Report

Frame: `iReportFrame`.

```text
link "Home"
link "Reports"
block #divReportFrameLoading
slot #iReportFrame (hidden)
modal#fieldsSpecificationModal small
  heading "Fields specification"
  button "x"
  text "This report shows production orders for which the 'required by date' has been changed due to production delays. Use this"
```

### `/Report/ProductionShortage`: Production Shortage Report

Frame: `iReportFrame`.

```text
link "Home"
link "Reports"
block #divReportFrameLoading
slot #iReportFrame (hidden)
modal#fieldsSpecificationModal small
  heading "Fields specification"
  button "x"
  text "This report shows the products required for production orders currently released or in progress. Use this report to iden"
```

### `/Report/Products`: Finished Product Traceability

Frame: `task-upload-frame`.

```text
block #TraceabilityReport
  block #MainContent
    link "Home"
    link "Reports"
    heading "Finished Product Traceability"
    button "Back to reports"#backAction
    slot #tdProduct
    label "Product / Batch / Lot / Serial number"
    button "Show"#btnShowReport primary
    button "Export"#btnExport
    button "Print"#btnPrint
    slot #divGridLines
    block #gridEmptyText
    form#frmExport
```

### `/Report/ProfitAndLoss`: Profit & Loss Report

Frame: `task-upload-frame`.

```text
form#rptExport
  block #divReport
    block #ProfitAndLossReport
      link "Home"
      link "Reports"
      block #tdStatus
      slot #tdLayoutName
      button "Delete layout"#divDelete
      button "Reset layout"
      button "Save layout as"#divSaveAs primary
      heading "Profit & Loss Report"
      button "Fields specification"#fieldsSpecification
      block #taskActions
        button "Save" primary
        button "Publish" primary
        button "Archive" primary
        button "Apply filter"
        button "Export"#divExport ▾
        button "Reconcile with Xero"#divXeroReconcilation (hidden)
        button "Export the detailed General Ledger to Excel"#divExportDetailedLedger primary (hidden)
        button "Back to reports"
        button "{{navigateBackCaption}}"
      block #divTaskHeader3
        slot #tdReporting_Index_Period
        slot #ProfitAndLoss_Index_Tab3_dtFrom
        slot #ProfitAndLoss_Index_Tab3_dtTo
        slot #ProfitAndLoss_Index_Tab3_CompareWith
        label "Compare with"
        slot #ProfitAndLoss_Index_Tab3_ComparePeriods
        label "Compare periods"
        button "Update"
        input text#divSearch placeholder "Type text to search"
        button "Search" primary
      heading "Profit & Loss"
      heading #reportCompanyName
      heading #reportDate
      block #divProfitAndLossGrid
      heading "Notes"
      slot #pivotGrid_footnotes_grid
    modal#divReportNameDialog small
      heading "Publish the report"
      button "x"
      label "Please enter a name" for #Report_NewLayout_Name
      input text#txtReportName
      block #DialogActions
        button "Publish" primary
        button "Close"
block #divProfitAndLossTransactions (hidden)
  slot #formHeader
  slot #transactionAccountName
  button "Back to Profit & Loss"#backAction
  button "Update"
  button "Apply filter"
  heading #transactionHeader
  heading #transactionCompanyName
  heading #transactionDatePeriod
  slot #divProfitAndLossTransactionsGrid
modal#Report_NewLayout_Content small
  heading "Name your layout"
  button "x"
  label "Layout name" for #Report_NewLayout_Name
  input text#tdReport_NewLayout_Name
  button "Save"#newLayoutFooter primary
  button "Save"#saveAsLayoutFooter primary (hidden)
  button "Close"
modal#fieldsSpecificationModal small
  heading "Fields specification"
  button "x"
  text "The Profit and Loss (or Income Statement) report shows your organization's net income, by deducting expenses from the re"
```

### `/Report/ProfitLossByProduct`: Profit & Loss by Product Report

Frame: `iReportFrame`.

```text
link "Home"
link "Reports"
block #divReportFrameLoading
slot #iReportFrame (hidden)
modal#fieldsSpecificationModal small
  heading "Fields specification"
  button "x"
  text "This report shows the profit made for each product within a given period. Use this report to see detailed financial info"
```

### `/Report/PurchaseCostAnalysis`: Purchase Cost Analysis Report

Frame: `iReportFrame`.

```text
link "Home"
link "Reports"
block #divReportFrameLoading
slot #iReportFrame (hidden)
modal#fieldsSpecificationModal small
  heading "Fields specification"
  button "x"
  text "Purchase Cost Analysis Report detailing the costs associated with purchasing every product during a given period. Use th"
  slot #attributesDescriptions
```

### `/Report/PurchaseDocuments`: Purchase Invoices & Credit Notes Report

Frame: `iReportFrame`.

```text
link "Home"
link "Reports"
block #divReportFrameLoading
slot #iReportFrame (hidden)
modal#fieldsSpecificationModal small
  heading "Fields specification"
  button "x"
  text "This report shows all authorized purchase invoices and credit notes applicable to the selected time period. Use this rep"
  slot #attributesDescriptions
```

### `/Report/PurchaseGoodsReceivedNotInvoiced`: Stock Received Not Invoiced

Frame: `iReportFrame`.

```text
link "Home"
link "Reports"
block #divReportFrameLoading
slot #iReportFrame (hidden)
modal#fieldsSpecificationModal small
  heading "Fields specification"
  button "x"
  text "This report displays purchase orders where stock has been received but the supplier has not yet issued an invoice. Use t"
  slot #attributesDescriptions
```

### `/Report/PurchaseInvoiceDetails`: Purchase Invoice Details Report

Frame: `iReportFrame`.

```text
link "Home"
link "Reports"
block #divReportFrameLoading
slot #iReportFrame (hidden)
modal#fieldsSpecificationModal small
  heading "Fields specification"
  button "x"
  text "This report shows details of purchase invoices. This detailed view breaks down purchase invoices by product. Use this re"
  slot #attributesDescriptions
```

### `/Report/PurchaseInvoiceSummary`: Purchase Invoice Summary Report

Frame: `iReportFrame`.

```text
link "Home"
link "Reports"
block #divReportFrameLoading
slot #iReportFrame (hidden)
modal#fieldsSpecificationModal small
  heading "Fields specification"
  button "x"
  text "This report shows a summary of purchase orders. This summary view displays purchase orders without product details. Use "
  slot #attributesDescriptions
```

### `/Report/PurchaseOrderDetails`: Purchase Order Details Report

Frame: `iReportFrame`.

```text
link "Home"
link "Reports"
block #divReportFrameLoading
slot #iReportFrame (hidden)
modal#fieldsSpecificationModal small
  heading "Fields specification"
  button "x"
  text "This report shows details of purchase orders. This detailed view breaks down purchase orders by product. Use this report"
  slot #attributesDescriptions
```

### `/Report/PurchaseOrderPending`: Pending Purchase Orders Report

Frame: `iReportFrame`.

```text
link "Home"
link "Reports"
block #divReportFrameLoading
slot #iReportFrame (hidden)
modal#fieldsSpecificationModal small
  heading "Fields specification"
  button "x"
  text "This report shows pending purchase orders. A purchase order is pending if it is at least in draft status but the invoice"
  slot #attributesDescriptions
```

### `/Report/PurchaseOrderSummary`: Purchase Order Summary Report

Frame: `iReportFrame`.

```text
link "Home"
link "Reports"
block #divReportFrameLoading
slot #iReportFrame (hidden)
modal#fieldsSpecificationModal small
  heading "Fields specification"
  button "x"
  text "This report shows a summary of purchase orders. This summary view displays purchase orders without product details. Use "
  slot #attributesDescriptions
```

### `/Report/PurchaseOrderVsInvoice`: Purchase Order vs Invoice Report

Frame: `iReportFrame`.

```text
link "Home"
link "Reports"
block #divReportFrameLoading
slot #iReportFrame (hidden)
modal#fieldsSpecificationModal small
  heading "Fields specification"
  button "x"
  text "This report compares what has been ordered vs what has been invoiced. Use this report to view discrepancies between orde"
```

### `/Report/PurchaseSupplierFinancialSummary`: Supplier Financial Summary Report

Frame: `iReportFrame`.

```text
link "Home"
link "Reports"
block #divReportFrameLoading
slot #iReportFrame (hidden)
modal#fieldsSpecificationModal small
  heading "Fields specification"
  button "x"
  text "This report indicates summaries of all financial transactions for every supplier including opening balance, total invoic"
  slot #attributesDescriptions
```

### `/Report/SaleBackorderDetails`: Sale Backorder Details Report

Frame: `iReportFrame`.

```text
link "Home"
link "Reports"
block #divReportFrameLoading
slot #iReportFrame (hidden)
modal#fieldsSpecificationModal small
  heading "Fields specification"
  button "x"
  text "This report shows all authorized sale orders containing backordered items which have not yet shipped to the customer. Us"
  slot #attributesDescriptions
```

### `/Report/SaleBackordersSummary`: Sale Backorder Summary Report

Frame: `iReportFrame`.

```text
link "Home"
link "Reports"
block #divReportFrameLoading
slot #iReportFrame (hidden)
modal#fieldsSpecificationModal small
  heading "Fields specification"
  button "x"
  text "This report shows all backordered products in your inventory. Use this report to view a summary of backordered products,"
```

### `/Report/SaleCreditNotesByProduct`: Sale Credit Notes by Product Report

Frame: `iReportFrame`.

```text
link "Home"
link "Reports"
block #divReportFrameLoading
slot #iReportFrame (hidden)
modal#fieldsSpecificationModal small
  heading "Fields specification"
  button "x"
  text "This report shows detailed financial and quantity-related information about each sale credit note. Use this report to se"
  slot #attributesDescriptions
```

### `/Report/SaleCustomerOrderByProduct`: Customer Orders by Product Report

Frame: `iReportFrame`.

```text
link "Home"
link "Reports"
block #divReportFrameLoading
slot #iReportFrame (hidden)
modal#fieldsSpecificationModal small
  heading "Fields specification"
  button "x"
  text "This report shows detailed financial and quantity-related information about each product sold. Use this report to see ho"
  slot #attributesDescriptions
```

### `/Report/SaleCustomerPaymentDetails`: Customer Payment Details Report

Frame: `iReportFrame`.

```text
link "Home"
link "Reports"
block #divReportFrameLoading
slot #iReportFrame (hidden)
modal#fieldsSpecificationModal small
  heading "Fields specification"
  button "x"
  text "This report shows payment details by customer with invoiced, paid, still due/credited for the selected time period. Outp"
  slot #attributesDescriptions
```

### `/Report/SaleCustomerPaymentSummary`: Customer Payment Summary Report

Frame: `iReportFrame`.

```text
link "Home"
link "Reports"
block #divReportFrameLoading
slot #iReportFrame (hidden)
modal#fieldsSpecificationModal small
  heading "Fields specification"
  button "x"
  text "This report shows a payment summary for your customers, with total invoiced, paid and still due/credited for the selecte"
  slot #attributesDescriptions
```

### `/Report/SaleDocuments`: Sale Invoices & Credit Notes Report

Frame: `iReportFrame`.

```text
link "Home"
link "Reports"
block #divReportFrameLoading
slot #iReportFrame (hidden)
modal#fieldsSpecificationModal small
  heading "Fields specification"
  button "x"
  text "This report shows all authorized sale invoices and credit notes applicable to the selected time period. Use this report "
  slot #attributesDescriptions
```

### `/Report/SaleFulfillmentDetails`: Fulfillment Details Report

Frame: `iReportFrame`.

```text
link "Home"
link "Reports"
block #divReportFrameLoading
slot #iReportFrame (hidden)
modal#fieldsSpecificationModal small
  heading "Fields specification"
  button "x"
  text "This report shows fulfillment details for authorized sale orders. Use this report to see fulfillment status for each ord"
  slot #attributesDescriptions
```

### `/Report/SaleOrderDetails`: Sale Order Details

Frame: `iReportFrame`.

```text
link "Home"
link "Reports"
block #divReportFrameLoading
slot #iReportFrame (hidden)
modal#fieldsSpecificationModal small
  heading "Fields specification"
  button "x"
  text "This report shows details of sale orders. This detailed view to breaks down sales orders by product, showing product qua"
  slot #attributesDescriptions
```

### `/Report/SaleOrderPending`: Pending Sale Orders Report

Frame: `iReportFrame`.

```text
link "Home"
link "Reports"
block #divReportFrameLoading
slot #iReportFrame (hidden)
modal#fieldsSpecificationModal small
  heading "Fields specification"
  button "x"
  text "This report shows pending sale orders. A sale order is classed as pending if the order has been authorized but it does n"
  slot #attributesDescriptions
```

### `/Report/SaleOutstandingQuotes`: Sale Outstanding Quotes Report

Frame: `iReportFrame`.

```text
link "Home"
link "Reports"
block #divReportFrameLoading
slot #iReportFrame (hidden)
modal#fieldsSpecificationModal small
  heading "Fields specification"
  button "x"
  text "This report shows all authorized quotes without an authorized sale order/invoice issued during the specified time interv"
  slot #attributesDescriptions
```

### `/Report/SaleOverview`: Sale Overview Report

Frame: `iReportFrame`.

```text
link "Home"
link "Reports"
block #divReportFrameLoading
slot #iReportFrame (hidden)
modal#fieldsSpecificationModal small
  heading "Fields specification"
  button "x"
  text "This report shows an overview of all sales, the customer and the sale and shipment status. Use this report to get a snap"
  slot #attributesDescriptions
```

### `/Report/SalePriceHistory`: Sale Price History Report

Frame: `iReportFrame`.

```text
block #SalePriceHistoryReport
  link "Home"
  link "Reports"
  block #divReportFrameLoading
  slot #iReportFrame (hidden)
modal#fieldsSpecificationModal small
  heading "Fields specification"
  button "x"
  text "This report shows sale price fluctuations for all active products during the selected time period. Price history can be "
```

### `/Report/SaleProfitBySalesRepresentative`: Profit by Sales Representatives Report

Frame: `iReportFrame`.

```text
link "Home"
link "Reports"
block #divReportFrameLoading
slot #iReportFrame (hidden)
modal#fieldsSpecificationModal small
  heading "Fields specification"
  button "x"
  text "This report shows profit and additional financial summary by sales representatives. Use this report to see the amount in"
  slot #attributesDescriptions
```

### `/Report/SaleProfitSummary`: Sale Profit Summary Report

Frame: `iReportFrame`.

```text
link "Home"
link "Reports"
block #divReportFrameLoading
slot #iReportFrame (hidden)
modal#fieldsSpecificationModal small
  heading "Fields specification"
  button "x"
  text "This report shows profit and additional financial summary for sales. Services, gift cards and non-inventory products are"
  slot #attributesDescriptions
```

### `/Report/SalesByCustomer`: Sales by Customer Report

Frame: `iReportFrame`.

```text
link "Home"
link "Reports"
block #divReportFrameLoading
slot #iReportFrame (hidden)
modal#fieldsSpecificationModal small
  heading "Fields specification"
  button "x"
  text "This report is a general overview of your sales amounts by customer. It lists each customer and the amount they purchase"
```

### `/Report/SalesByProductDetails`: Sales by Product Details Report

Frame: `iReportFrame`.

```text
link "Home"
link "Reports"
block #divReportFrameLoading
slot #iReportFrame (hidden)
modal#fieldsSpecificationModal small
  heading "Fields specification"
  button "x"
  text "This report shows quantities, profit and additional financial summary for sales by product. It shows product quantity, a"
  slot #attributesDescriptions
```

### `/Report/SalesByProductSummary`: Sales by Product Summary Report

Frame: `iReportFrame`.

```text
link "Home"
link "Reports"
block #divReportFrameLoading
slot #iReportFrame (hidden)
modal#fieldsSpecificationModal small
  heading "Fields specification"
  button "x"
  text "This report shows quantities, profit and additional financial summary for sales by product. It shows product quantity, a"
  slot #attributesDescriptions
```

### `/Report/SalesDemandForecast`: Sales Demand Forecast Report

Frame: `iReportFrame`.

```text
link "Home"
link "Reports"
block #divReportFrameLoading
slot #iReportFrame (hidden)
modal#fieldsSpecificationModal small
  heading "Fields specification"
  button "x"
  text "This report uses historical sales data to estimate future sales quantities of goods and services. This report can also t"
```

### `/Report/SalesTaxSummary`: Sales Tax Report

Frame: `task-upload-frame`.

```text
form#rptExport
  block #divReport
    block #SalesTaxSummaryReport
      link "Home"
      link "Reports"
      block #tdStatus
      slot #tdLayoutName
      button "Delete layout"#divDelete
      button "Reset layout"
      button "Save layout as"#divSaveAs primary
      heading "Sales Tax Report"
      button "Fields specification"#fieldsSpecification
      block #taskActions
        button "Save" primary
        button "Publish" primary
        button "Archive" primary
        button "Apply filter"
        button "Export"#divExport ▾
        button "Reconcile with Xero"#divXeroReconcilation (hidden)
        button "Export the detailed General Ledger to Excel"#divExportDetailedLedger primary (hidden)
        button "Back to reports"
        button "{{navigateBackCaption}}"
      block #divTaskHeader
        slot #tdReporting_Index_Period
        slot #tdReporting_Index_From
        slot #tdReporting_Index_To
        button "Update"
        input text#divSearch placeholder "Type text to search"
        button "Search" primary
      heading "Sales Tax Report"
      heading #reportCompanyName
      heading #reportDate
      block #divSalesTaxSummaryGrid
      heading "Notes"
      slot #pivotGrid_footnotes_grid
    modal#divReportNameDialog small
      heading "Publish the report"
      button "x"
      label "Please enter a name" for #Report_NewLayout_Name
      input text#txtReportName
      block #DialogActions
        button "Publish" primary
        button "Close"
modal#Report_NewLayout_Content small
  heading "Name your layout"
  button "x"
  label "Layout name" for #Report_NewLayout_Name
  input text#tdReport_NewLayout_Name
  button "Save"#newLayoutFooter primary
  button "Save"#saveAsLayoutFooter primary (hidden)
  button "Close"
modal#fieldsSpecificationModal small
  heading "Fields specification"
  button "x"
  text "The Tax Report is a summary showing the tax charged or paid by your organization for the tax period being reported."
```

### `/Report/StockReceivedVsInvoice`: Stock Received vs Invoice Report

Frame: `iReportFrame`.

```text
link "Home"
link "Reports"
block #divReportFrameLoading
slot #iReportFrame (hidden)
modal#fieldsSpecificationModal small
  heading "Fields specification"
  button "x"
  text "This report compares stock received vs invoice. Use this report to see what has been received but not invoiced or what h"
  slot #attributesDescriptions
```

### `/Report/StockValueInventoryAging`: Stock Value Inventory Aging Report

Frame: `iReportFrame`.

```text
link "Home"
link "Reports"
block #divReportFrameLoading
slot #iReportFrame (hidden)
modal#fieldsSpecificationModal small
  heading "Fields specification"
  button "x"
  text "This report shows the average age of your inventory. Stock value for the products is included in the report. Use this re"
```

### `/Report/TaxTransactions`: Sales Tax Transactions Report

Frame: `iReportFrame`.

```text
link "Home"
link "Reports"
block #divReportFrameLoading
slot #iReportFrame (hidden)
modal#fieldsSpecificationModal small
  heading "Fields specification"
  button "x"
  text "Sales Tax Transactions"
```

### `/Report/TransactionPeriods`: Financial Periods Report

Frame: `task-upload-frame`.

```text
link "Home"
link "Reports"
button "Back to reports"#backAction
block #divList
  select#divStatusFilter
  select#divYearFilter
  button #divRefresh
  block #GridOptions_Container
    button #Grid_gridName_Options1
  slot #divReportData
```

### `/Report/Transactions`: Transactions Report

Frame: `iReportFrame`.

```text
link "Home"
link "Reports"
block #divReportFrameLoading
slot #iReportFrame (hidden)
modal#fieldsSpecificationModal small
  heading "Fields specification"
  button "x"
  text "This report shows detailed financial transactions within the selected time period. Use this report to view all transacti"
```

### `/Report/TransactionsVsInventoryCards`: Transactions vs Stock on Hand Difference Report

Frame: `iReportFrame`.

```text
link "Home"
link "Reports"
block #divReportFrameLoading
slot #iReportFrame (hidden)
modal#fieldsSpecificationModal small
  heading "Fields specification"
  button "x"
  text "Shows the difference between stock on hand and transactions on the specified effective date. If there are no differences"
```

### `/Report/TrialBalance`: Trial Balance Report

Frame: `task-upload-frame`.

```text
form#rptExport
  block #divReport
    block #TrialBalanceReport
      link "Home"
      link "Reports"
      block #tdStatus
      slot #tdLayoutName
      button "Delete layout"#divDelete
      button "Reset layout"
      button "Save layout as"#divSaveAs primary
      heading "Trial Balance Report"
      button "Fields specification"#fieldsSpecification
      block #taskActions
        button "Save" primary
        button "Publish" primary
        button "Archive" primary
        button "Apply filter"
        button "Export"#divExport ▾
        button "Reconcile with Xero"#divXeroReconcilation (hidden)
        button "Export the detailed General Ledger to Excel"#divExportDetailedLedger primary (hidden)
        button "Back to reports"
        button "{{navigateBackCaption}}"
      block #divTaskHeader
        slot #tdReporting_Index_Period
        slot #tdReporting_Index_From
        slot #tdReporting_Index_To
        button "Update"
        input text#divSearch placeholder "Type text to search"
        button "Search" primary
      heading "Trial Balance"
      heading #reportCompanyName
      heading #reportDate
      block #divTrialBalanceGrid
      heading "Notes"
      slot #pivotGrid_footnotes_grid
    modal#divReportNameDialog small
      heading "Publish the report"
      button "x"
      label "Please enter a name" for #Report_NewLayout_Name
      input text#txtReportName
      block #DialogActions
        button "Publish" primary
        button "Close"
block #divBalanceSheetTransactions (hidden)
  slot #formHeader
  slot #transactionAccountName
  button #backAction
  button "Update"
  button "Apply filter"
  heading #transactionHeader
  heading #transactionCompanyName
  heading #transactionDatePeriod
  slot #divBalanceSheetTransactionsGrid
modal#Report_NewLayout_Content small
  heading "Name your layout"
  button "x"
  label "Layout name" for #Report_NewLayout_Name
  input text#tdReport_NewLayout_Name
  button "Save"#newLayoutFooter primary
  button "Save"#saveAsLayoutFooter primary (hidden)
  button "Close"
modal#fieldsSpecificationModal small
  heading "Fields specification"
  button "x"
  text "A simple snapshot of all financial transactions within a given period. Use this report to see opening balance, closing b"
```

### `/Report/VATReturn`: VAT Return

Redirects to `/Report/VATReturnList`.

Frame: `task-upload-frame`.

```text
block #VATReturnListReport
  link "Home"
  link "Reports"
  heading "VAT Return"
  block #infoNoReturns
  button "Generate VAT Return"#btnGenerate
  table#tblVATList: Status | Tax return | Filed on
```

### `/Report/VATReturnList`: VAT Return

Frame: `task-upload-frame`.

```text
block #VATReturnListReport
  link "Home"
  link "Reports"
  heading "VAT Return"
  block #infoNoReturns
  button "Generate VAT Return"#btnGenerate
  table#tblVATList: Status | Tax return | Filed on
```

### `/Report/XeroSync`: Xero Synchronization Report

Frame: `iReportFrame`.

```text
link "Home"
link "Reports"
block #divReportFrameLoading
slot #iReportFrame (hidden)
modal#fieldsSpecificationModal small
  heading "Fields specification"
  button "x"
  text "This report shows mismatches between Cin7 Core and Xero data synchronization."
```

### `/Reports`: Reports

Frame: `task-upload-frame`.

```text
link "Home"
tabs: All reports #all | Drafts #drafts | Published #published | Archived #archived
tab pane#all
  tabs: 0 Favorites #tab1 | Purchase reports #tab2 | Sale reports #tab3 | Inventory reports #tab4 | Financial reports #tab5 | Audit reports #tab6 | Production reports #tab7 | ForesightAI Reports #tab8
  tab pane#tab1
  tab pane#tab2
  tab pane#tab3
  tab pane#tab4
  tab pane#tab5
    slot #FixedAssetOverview
    slot #ReconciliationWithXero
    slot #DepreciationSchedule
    slot #PeriodsReport
  tab pane#tab6
  tab pane#tab7
  tab pane#tab8
tab pane#drafts
  input text#divDraftsSearch placeholder "Type text to search"
  button "Search"#btnDraftsSearch primary
  slot #divDraftsReportsGrid
tab pane#published
  input text#divPublishedSearch placeholder "Type text to search"
  button "Search"#btnPublishedSearch primary
  slot #divPublishedReportsGrid
tab pane#archived
  input text#divArchivedSearch placeholder "Type text to search"
  button "Search"#btnArchivedSearch primary
  slot #divArchivedReportsGrid
```

### `/ScheduledReportSettings`: Scheduled report settings

Frame: `task-upload-frame`.

```text
link "Home"
link "Automation"
button "Back to list"
block #divScheduledReportList
  tab pane#portlet_tab1
    block #divScheduledReports
      button #ScheduledReportList_btnAddNew primary
      input text#ScheduledReportList_tbSearch placeholder "Type text to search"
      button "Search" primary
      select#ScheduledReportList_selStatus: All | Active | Inactive
      button "Refresh"#ScheduledReportList_btnRefresh
      slot #ScheduledReportList_divScheduledReportGrid
  tab pane#portlet_tab2
    block #divReportsGenerationLog
      slot #divReportGeneration_title
      button "Back to report list"#aBackToReportList
      button "Back to report"#aBackToReport
      slot #ReportGenerationLog_divReportGenerationLogGrid
modal#divScheduledReportEdit medium
  heading "Scheduled report<"#divScheduledReportEdit_title
  button "×"
  block #reportScheduling_warning (hidden)
  heading "1. Report"
  input checkbox#ScheduledReportEdit_isActive
  label "Enabled" for #ScheduledReportEdit_isActive
  input text#ScheduledReportEdit_reportScheduleName placeholder "Scheduled report name"
  label "Name" for #ScheduledReportEdit_reportScheduleName
  label "Please select a report for scheduling" for #ScheduledReportEdit_reportName
  select#ScheduledReportEdit_reportName
  block #GSuite_SaveToGDrive_Block (hidden)
    input checkbox#ScheduledReportEdit_GSuitesSaveToGDrive
    label "Save to Google Drive" for #ScheduledReportEdit_GSuitesSaveToGDrive
    heading "Location"
    button "Change"#btnScheduledReportChangeGDriveLocation primary
    block #scheduledReportGDriveWarning (hidden)
      slot #scheduledReportGDriveWarningText
    slot #gdLocationNameReporting
  heading "2. Layout and period"
  select#ScheduledReportEdit_layoutName
  label "Please select a layout" for #ScheduledReportEdit_layoutName
  block #reportScheduling_intervalBlock
    label "Select inventory interval *" for #ScheduledReportEdit_interval
    slot #ScheduledReportEdit_interval
  block #reportScheduling_withSafetyStock
    input checkbox#chkWithSafetyStock
    label "Calculate reorder quantity using safety stock" for #chkWithSafetyStock
  block #SalesDemandForecast_Template_Block (hidden)
    label "Select template *"
    slot #ScheduledReportEdit_SalesDemandForecastTemplate
  block #reportScheduling_modeBlock (hidden)
    block #reportModes
      label "Mode *"
      select#reportMode: Period | As of date
  block #reportScheduling_asOfDateBlock
    block #reportAsOfDate
      label "As of *"
      select#asOfDrpDown: Today | Yesterday | Date offset
  block #ScheduledReportEdit_reportDateOffsetBlock
    input text#ScheduledReportEdit_reportDateOffset
    label "Date offset (days)" for #ScheduledReportEdit_reportDateOffset
  block #reportScheduling_periodBlock
    block #reportPeriods
      label "Select a period for the reporting *"
      select#dateperiod
    block #divCustomValue
      input text#ScheduledReportEdit_datePeriodValue placeholder "0"
    block #backUpPeriods (hidden)
      label "Backup period *"
      select#ScheduledReportEdit_backUpPeriods: Last 30 days | Last 60 days | Last 90 days | Last 365 days
  block #reportScheduling_onlyNonZeroValue
    input checkbox#chkOnlyNonZeroValue
    label "Non-zero quantities only" for #chkOnlyNonZeroValue
  block #reportScheduling_accountCode (hidden)
    label "Account code *"
    slot #ScheduledReportEdit_accountCode
  block #reportScheduling_balanceDates (hidden)
    label "Balance dates *"
    slot #ScheduledReportEdit_balanceDates
  block #reportScheduling_compareTo (hidden)
    label "Compare to *"
    slot #ScheduledReportEdit_compareTo
  block #reportScheduling_comparePeriods (hidden)
    label "Compare periods *"
    slot #ScheduledReportEdit_comparePeriods
  block #reportScheduling_currencyBlock (hidden)
    label "Report currency *"
    select#ScheduledReportEdit_currencyName
  block #reportScheduling_quoteStatusBlock (hidden)
    label "Quote status *"
    select#ScheduledReportEdit_quoteStatus: All quotes | Drafts only | Authorized only
  block #reportScheduling_cogsBlock (hidden)
    label "Show COGS *"
    select#ScheduledReportEdit_cogs: Only COGS within date range | All COGS
  block #reportScheduling_cogsBlock (hidden)
    label "Show COGS *"
    select#ScheduledReportEdit_cogs: Only COGS within date range | All COGS
  block #reportScheduling_costsBlock (hidden)
    label "Show journal costs *"
    select#ScheduledReportEdit_costs: Only journal costs within date range | Show journal costs
  block #reportScheduling_lotExpiry (hidden)
    label "Lot expire before *"
    slot #ScheduledReportEdit_lotExpiryDate
  block #reportScheduling_effectiveDate (hidden)
    label "Effective date to *"
    slot #ScheduledReportEdit_effectiveDate
  block #reportScheduling_BOMComponentDetails_ShowFilter (hidden)
    label "Show *"
    slot #ScheduledReportEdit_BOMComponentDetails_ShowFilter
  block #reportScheduling_BOMComponentDetails_FilterByAvailable (hidden)
    label "Filter by available *"
    slot #ScheduledReportEdit_BOMComponentDetails_FilterByAvailable
    block #reportScheduling_BOMComponentDetails_AvailableQtyLessThan (hidden)
      label "Quantity is less than *"
      slot #ScheduledReportEdit_BOMComponentDetails_AvailableQtyLessThan
  block #reportScheduling_DaysInterval (hidden)
    label "Aging bucket *"
    slot #ScheduledReportEdit_DaysInterval
  block #reportScheduling_InventoryDetailsMode (hidden)
    label "Filter by *"
    slot #ScheduledReportEdit_InventoryDetailsMode
  block #reportScheduling_timeShowInFormat (hidden)
    label "Show in *"
    select#ScheduledReportEdit_timeShowInFormat: Seconds | Minutes | Hours
  heading "3. Additional"
  label "Schedule from *" for #ScheduledReportEdit_startExecutionDate
  slot #ScheduledReportEdit_startExecutionDate
  label "Run at *" for #ScheduledReportEdit_startExecutionTime
  input text#ScheduledReportEdit_startExecutionTime
  label "Frequency *" for #ScheduledReportEdit_reportName
  select#ScheduledReportEdit_frequency: Daily report | Weekly report | Monthly report | Quarter report | Year report | Custom
  block #divFrequencyValue (hidden)
    label "Repeat every *"
    input text#ScheduledReportEdit_frequencyValue placeholder "Repeat every X day(s)"
  label "Mailing list *" for #ScheduledReportEdit_mailingList
  select#ScheduledReportEdit_mailingList multiple
  block #divReportFomrat
    label "Report format *" for #ScheduledReportEdit_reportFormat
    select#ScheduledReportEdit_reportFormat: PDF | RTF | Excel with totals | Excel without totals
  block #reportScheduling_dataBakup (hidden)
    label "Select data for backup *"
    block #dataBackupDiv
      input checkbox#checkall name=checkallbackupdata
      label "Select all" for #checkall
      input checkbox#inv_lst name=backupdata
      label "Inventory list" for #inv_lst
      input checkbox#stck_hnd name=backupdata
      label "Stock on hand" for #stck_hnd
      input checkbox#dsc_mtr name=backupdata
      label "Discount matrix" for #dsc_mtr
      input checkbox#bll_mt name=backupdata
      label "Bill of materials" for #bll_mt
      input checkbox#prod_bom name=backupdata
      label "Production BOM" for #prod_bom
      input checkbox#stck_rrd_lc name=backupdata
      label "Stock reorder locations" for #stck_rrd_lc
      input checkbox#prd_pr_spp name=backupdata
      label "Product Prices by Supplier" for #prd_pr_spp
      input checkbox#smrt_rrd_cnf name=backupdata
      label "Reorder parameters" for #smrt_rrd_cnf
      input checkbox#aun_ms name=backupdata
      label "Additional units of measure" for #aun_ms
      input checkbox#mrk_pr name=backupdata
      label "Markup prices" for #mrk_pr
      input checkbox#cst_pr name=backupdata
      label "Custom prices" for #cst_pr
      input checkbox#sppl name=backupdata
      label "Suppliers" for #sppl
      input checkbox#sppl_addr name=backupdata
      label "Supplier addresses" for #sppl_addr
      input checkbox#cst name=backupdata
      label "Customers" for #cst
      input checkbox#cst_addr name=backupdata
      label "Customer addresses" for #cst_addr
      input checkbox#un_ms name=backupdata
      label "Units of measure" for #un_ms
      input checkbox#gft_crd name=backupdata
      label "Gift cards" for #gft_crd
      input checkbox#lc_bns name=backupdata
      label "Locations/ bins" for #lc_bns
      input checkbox#shpp_zne name=backupdata
      label "Shipping zones" for #shpp_zne
      input checkbox#chrt_acc name=backupdata
      label "Chart of accounts" for #chrt_acc
      input checkbox#prd_brnd name=backupdata
      label "Product brands" for #prd_brnd
      input checkbox#prd_ct name=backupdata
      label "Product categories" for #prd_ct
      input checkbox#add_attr name=backupdata
      label "Additional attributes" for #add_attr
      input checkbox#crr name=backupdata
      label "Carriers" for #crr
      input checkbox#pym name=backupdata
      label "Payments" for #pym
      input checkbox#tx_rl name=backupdata
      label "Tax rules" for #tx_rl
      input checkbox#cmp_cnt name=backupdata
      label "Company contacts" for #cmp_cnt
      input checkbox#cnt_addr name=backupdata
      label "Contact addresses" for #cnt_addr
      input checkbox#sl name=backupdata
      label "Sales" for #sl
      input checkbox#prch name=backupdata
      label "Purchases" for #prch
  button "Save" primary
  button "Cancel"#cancel-button
```

## Components by bundle

What the page code builds and mounts into the layout's slots.

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

