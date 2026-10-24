# Dashboard: UI

Every component the page code builds, read from the shipped ExtJS bundles: grids with their columns, fields, buttons, menus, windows and custom components. Labels are the English UI text. `renders into` is the id of the `<div>` in the page's server-rendered HTML that the component mounts in; `store` names the data store (see the endpoints in [README.md](README.md)); `on click` is the handler. Visual system and shell layout: [docs/UI.md](../../docs/UI.md).

## Screens

| Route | Title | Bundles |
|---|---|---|
| `/ContinueSetup` | Continue setup | [`ContinueSetup`](#continuesetup) |
| `/Home` | Dashboard | [`Home2019`](#home2019) |

## Layout

Each screen's server-rendered HTML inside the shell, as an outline: headings, tabs, sections, labels, inputs (`#id`), buttons (`▾` = dropdown), menus, tables and `slot`s (empty `<div>`s the components below mount into). `(hidden)` parts are shown by the page code when needed. Read with GET from a signed-in session; no values are kept.

### `/ContinueSetup`: Continue setup

Frame: `https://www.youtube.com/embed/zn9alFMPlp4?si=…`.

```text
block #divSetupPage
  heading "Hi {email}, welcome to Cin7 Core!"
  heading "Getting started"
  text "1"#currentStep
  block #divProgressBar
  text "View the product tour"
  text "Explore Cin7 Core with our quick self-guided tour."
  button "View tour" primary
  text "Add your first product"
  text "Create a product and see what Cin7 Core can do for your business."
  button "Add product" primary
  text "Add stock"
  text "Let’s add stock to your newly created product."
  button "Add stock" primary
  text "Add your first sale order"
  text "See what Cin7 Core can do for your sales."
  button "Create order" primary
  text "Invite users"
  text "Collaborate with your team members to explore Cin7 Core."
  button "Invite users" primary
  heading "Manage trial account"
  text "Delete all trial data"
  text "We’ve added examples to help you learn about Cin7 Core. When you are ready, you can delete these examples."
  button "Continue" primary
  text "Set up your accounting integration"
  text "Quickly import customers, suppliers, products, and more from your accounting integration."
  button "Complete account mapping"
  button "Continue sync"
  button "Connect"
  button "Complete account mapping"
  button "Continue sync"
  button "Connect"
  button "Close setup guide" primary
  heading "Overview video"
  heading "Help options"
  text "Visit knowledge base"
modal#dlgVideoGuide medium
  heading "Overview video"
  button "×"
  button "Close"
slot #CountrySpecificScript
modal#dlgClearDemoData small
  heading "Clear demo data"
  button "×"
  button "Clear demo data"#btnClearDemoData primary
  button "Cancel"
modal#dlgConnectToDEAR small
  heading "Continue with demo data"
  button "×"
  button "Continue with data"#dlgConnectToDEAR_btnContinue primary
  button "Erase data and continue"#dlgConnectToDEAR_btnEraseData primary
modal#dlgRemoveDemoData small
  heading "Clear demo data"
  button "×"
  button "Clear demo data"#btnRemoveDemoData primary
  button "Open Wizard"#btnOpenXeroWizard primary (hidden)
  button "Open Wizard"#btnOpenQBWizard primary (hidden)
  button "Cancel"
modal#dlgAccountMapping small
  heading "Account mapping"
  button "×"
  button "Save"#dlgAccountMapping_btnSave primary
  button "Cancel"
modal#AccountMapping_CreateAccountForm medium
  heading "Add account to Xero"
  button "×"
  label "Account type" for #tdAccountType
  select#tdAccountType: Current Asset | Fixed asset | Non-current Asset | Prepayment | Equity | Depreciation | Direct Cost | Expense | Overhead | Current Liability | Liability | Non-current Liability | Other Income | Revenue | Sale
  label "Account code" for #tdAccountCode
  input text#tdAccountCode placeholder "A unique code/number for this account (limited to "
  label "Name" for #tdAccountName
  input text#tdAccountName placeholder "A short title for this account (limited to 150 cha"
  label "Description (optional)" for #tdAccountDescription
  input text#tdAccountDescription placeholder "A description of how this account should be used."
  label "Show in expense claims" for #tdShowInExpenseClaims
  input checkbox#tdShowInExpenseClaims
  label "Enable payments to this account" for #tdEnablePayments
  input checkbox#tdEnablePayments
  button "Add" primary
  button "Close"
modal#dlgError small
  heading 
  button "×"
  button "Close"
modal#dlgImport small
  heading 
  button "×"
  slot #dlgImport_message
modal#dlgChangeCurrency small
  heading "Change Cin7 Core currency"
  button "×"
  slot #txtChangeCurrencyMessage
  button "Yes"#btnChangeCurrency primary
  button "No"
modal#dlgDemoDataDeletePreview small
  heading "Delete demo data"
  button "×"
  block #dlgDemoDataDeletePreview_hasdata
    table
    text "Including demo data for: Deprecation, ShipZone, Deal, Discount, AttributeSet"
  block #dlgDemoDataDeletePreview_nodata (hidden)
    text "No data to delete."
  button "Delete demo data"#dlgDemoDataDeletePreview_btnDelete primary
  button "Cancel"
modal#dlgDemoDataDeletePreview_Details medium
  heading 
  button "×"
  button "Cancel"
modal#dlgConnectToXero small
  heading "Connect to Xero"
  button "×"
  block #dlgConnectToXero_options
    input checkbox#dlgConnectToXero_chkAccountingData
    label "Accounting data" for #dlgConnectToXero_chkAccountingData
    slot #dlgConnectToXero_txtAccountsImported (hidden)
    input checkbox#dlgConnectToXero_chkCustomers
    label "Customers" for #dlgConnectToXero_chkCustomers
    slot #dlgConnectToXero_txtCustomersImported (hidden)
    input checkbox#dlgConnectToXero_chkSuppliers
    label "Suppliers" for #dlgConnectToXero_chkSuppliers
    slot #dlgConnectToXero_txtSuppliersImported (hidden)
    input checkbox#dlgConnectToXero_chkProducts
    label "Products" for #dlgConnectToXero_chkProducts
    slot #dlgConnectToXero_txtProductsImported (hidden)
  slot #dlgConnectToXero_synclog (hidden)
  button "Synchronize selected data"#dlgConnectToXero_btnStartSync primary
  button "Resynchronize"#dlgConnectToXero_btnReSync primary (hidden)
  button "Complete account mapping"#dlgConnectToXero_btnAccountMapping (hidden)
modal#dlgCurrencyErrorXero small
  heading "Cannot connect to Xero."
  button "×"
  slot #errorXeroOrganizationName
  slot #errorXeroCurrency
  slot #errorXeroDEARCurrency
  link "My subscription"
  link "General Settings"
  button "Connect to another organization"#btnConnectToAnotherXero primary
  button "Cancel"
modal#dlgTokenErrorXero small
  heading "Cannot connect to Xero."
  button "×"
  button "Connect"#btnConnectToXeroAgain primary
  button "Cancel"
modal#dlgCurrencyErrorQB small
  heading "Cannot connect to QuickBooks."
  button "×"
  slot #errorQBOrganizationName
  slot #errorQBCurrency
  slot #errorQBDEARCurrency
  link "My subscription"
  link "General Settings"
  button "Connect to another organization"#dlgCurrencyErrorQB_btnConnectToAnother primary
  button "Cancel"
modal#dlgConnectToQB small
  heading "Connect to QuickBooks"
  button "×"
  block #dlgConnectToQB_options
    input checkbox#dlgConnectToQB_chkAccountingData
    label "Accounting data" for #dlgConnectToQB_chkAccountingData
    slot #dlgConnectToQB_txtAccountsImported (hidden)
    input checkbox#dlgConnectToQB_chkCustomers
    label "Customers" for #dlgConnectToQB_chkCustomers
    slot #dlgConnectToQB_txtCustomersImported (hidden)
    input checkbox#dlgConnectToQB_chkSuppliers
    label "Suppliers" for #dlgConnectToQB_chkSuppliers
    slot #dlgConnectToQB_txtSuppliersImported (hidden)
    input checkbox#dlgConnectToQB_chkProducts
    label "Products" for #dlgConnectToQB_chkProducts
    slot #dlgConnectToQB_txtProductsImported (hidden)
  slot #dlgConnectToQB_synclog (hidden)
  button "Synchronize selected data"#dlgConnectToQB_btnStartSync primary
  button "Resynchronize"#dlgConnectToQB_btnReSync primary (hidden)
  button "Complete account mapping"#dlgConnectToQB_btnAccountMapping (hidden)
modal#dlgConfirmationNotUsingDearUaeSpecificFinancialFeature small
  heading "Confirm not utilizing Cin7 Core UAE specific financial features"
  button "×"
  slot #dlgConfirmationNotUsingDearUaeSpecificFinancialFeatureMessage
  button "Yes"#btnConfirmationNotUsingDearUaeSpecificFinancialFeature primary
  button "No"
modal#dlgConnectErrorQB small
  heading "Cannot connect to QuickBooks."
  button "×"
  slot #dlgConnectErrorQB_message
  button "Try to connect again"#dlgConnectErrorQB_btnConnectToAnother primary
  button "Cancel"
modal#accountReconciliationModal small
  heading "Account mapping"
  button "×"
  slot #AccountsReconciliationGrid
  slot #TaxRulesReconciliationGrid
  button "Save changes" primary
  button "Close"
```

### `/Home`: Dashboard

Frame: `task-upload-frame`.

```text
block #viewContainer
  link "General Dashboard"#vGeneral
slot #DashBoardRangePageOverlay
button  ▾
block #spDateTangeLabel
button  ▾
label "Date range"
label "Starting" for #startreportrangemanual
slot #startreportrangemanual
label "Ending" for #endreportrangemanual
slot #endreportrangemanual
slot #startreportrange
slot #endreportrange
input checkbox#cmpToPrevDates
label "Compare to previous dates" for #cmpToPrevDates
button  ▾
label "Compare to"
button "Apply"#btnApplyDateRange primary
button "Cancel"#btnCloseDateRange primary
button "Manage dashboard"#btnDashboardManagement primary
modal#dashboard-settings-button small
  heading "Manage dashboard"
  button "×"
  heading "Dashboard actions:"
  link "Reset layout"
  heading "Select widgets to display:"
  input checkbox#checkbox-dashboard-quicklinks
  label "Quick links" for #checkbox-dashboard-quicklinks
  input checkbox#checkbox-dashboard-referral
  label "Referral credit program" for #checkbox-dashboard-referral
  input checkbox#checkbox-dashboard-kpi
  label "Key performance indicators" for #checkbox-dashboard-kpi
  input checkbox#checkbox-dashboard-knowledgebase
  label "Discover Knowledge Base" for #checkbox-dashboard-knowledgebase
  input checkbox#checkbox-dashboard-purchases
  label "Bills and orders" for #checkbox-dashboard-purchases
  input checkbox#checkbox-dashboard-purchases-list
  label "Purchases" for #checkbox-dashboard-purchases-list
  input checkbox#checkbox-dashboard-sales-list
  label "Sales" for #checkbox-dashboard-sales-list
  input checkbox#checkbox-dashboard-product-overview
  label "Product overview" for #checkbox-dashboard-product-overview
  input checkbox#checkbox-dashboard-customer-overview
  label "Customer overview" for #checkbox-dashboard-customer-overview
  input checkbox#checkbox-dashboard-reorder
  label "Reorder" for #checkbox-dashboard-reorder
  input checkbox#checkbox-dashboard-reminder
  label "Reminders" for #checkbox-dashboard-reminder
  input checkbox#checkbox-dashboard-cin7-capital
  label "Cin7 Capital" for #checkbox-dashboard-cin7-capital
  button "Close"
link "Collapse all sections"
link "Expand all sections"
link "Reset layout"
block #dashboard-body
  slot #tilesContainer
block #hiddenContainer (hidden)
  block #dashboard-inventoro-teaser-section (hidden)
    slot #spnInventoroTotalStockouts
    slot #spnInventoroTotalStock
    slot #spnInventoroTotalOverstock
    button "Explore"#btnInvetoroTeaserExplore primary
  block #dashboard-inventoro-overstock-section (hidden)
    slot #extLocation_inventoro-overstock
    button "Stockouts"
    button "Healthy stock"
    button "Overstocks"
  block #dashboard-inventoro-winners-section (hidden)
    slot #extLocation_inventoro-winners
    button "Winners stock value"
    button "Winners stock share"
    button "Chasers stock value"
    button "Chasers stock share"
    button "Losers stock value"
    button "Losers stock share"
  block #dashboard-inventoro-kpi-section (hidden)
    slot #divInventoroGraphLegend_Stockouts
    slot #chart_InventoroGraph_Stockouts
    block #chart_InventoroGraph_Stockouts_no_data
    slot #divInventoroGraphLegend_LostRevenue
    slot #chart_InventoroGraph_LostRevenue
    block #chart_InventoroGraph_LostRevenue_no_data
    slot #divInventoroGraphLegend_Overstock
    slot #chart_InventoroGraph_Overstock
    block #chart_InventoroGraph_Overstock_no_data
  block #dashboard-exploredashboard-section (hidden)
    button "Get Started Guide" primary
    button "Take a quick tour" primary
  block #dashboard-managedemo-section (hidden)
    button "Clear demo data" primary
  block #dashboard-cin7-capital-section (hidden)
    button "Learn more" primary
  block #dashboard-knowledgebase-section (hidden)
    button "Open Knowledge Base" primary
  block #dashboard-quicklinks-section (hidden)
    button "Chart of accounts {count}"
    button "Suppliers {count}"
    button "Products {count}"
    button "Customers {count}"
    button "Bank accounts {count}"#DashboardNotifyBankAccounts
  block #dashboard-referral-section (hidden)
    heading "Share a discount with your friends!"
    text "Send a discount code to a friend so they get 10% off their monthly bill for 6 months."
    text "You save 10% on your monthly bill per active referral - and up to 100% when more friends sign up."
    button "Refer a friend"#refInviteClientsBtn primary
    input text#refInvitationCodeInput read-only
    button "Copy"#refInvitationCodeBtn primary
    button "Share"
    button "Tweet"
    button "Share"
    text "How does it work ?"
    heading "Step 1"
    text "Copy your unique discount code or click Refer a Friend to email it to your friends."
    heading "Step 2"
    text "Every time a friend uses your code to subscribe, you both get a 10% discount."
    heading "Step 3"
    text "Share your Cin7 Core code with more friends and receive up to 100% off your monthly bill."
    text "To compliment discounts you can also use Cin7 Core to Cin7 Core networking functionality-which can send purchases and sa"
    text "*referred accounts will need to be active for you to continue receiving a discount"
  block #dashboard-kpi-section (hidden)
    block #dashboard-kpi-section-blocks
      button "Revenue No data"
      button "Net No data"
      button "Pending orders No data"
      button "Due No data"
      button "Overdue No data"
      button "Inflow No data"
      button "Outflow No data"
      link "Revenue / Net"
      link "Pending orders"
      link "Due / Overdue"
      link "Inflow / Outflow"
    button "Bars" ▾
    button "View report"
    slot #chart_KpiSummary
    block #chart_KpiSummary-no-data
  block #dashboard-purchases-section (hidden)
    heading "Bills"
    button "Draft -"
    button "Awaiting delivery -"
    button "Due -"
    button "Overdue -"
    button "Bars" ▾
    button "View report"
    slot #chart_PurchaseGraph
    heading "Purchase orders"
    button "Draft -"
    button "Authorized -"
    button "Not invoiced -"
    button "Not received -"
  block #dashboard-purchases-list-section (hidden)
    block #purchaseMenu
      slot #Dashboard2017_PurchaseDraftPO (hidden)
      slot #Dashboard2017_PurchaseDraftInvoice (hidden)
      slot #Dashboard2017_PurchaseAwaitingPayment (hidden)
      slot #Dashboard2017_PurchaseOverdue (hidden)
      slot #Dashboard2017_PurchaseAwaitingDelivery (hidden)
    heading "Draft orders"#PurchasesSelectedFilterHeader (hidden)
    tab pane#tab_5_1
      button "Go to purchases list" primary
      button #PurchaseGrid_gridName_Options
      slot #divPurchases
  block #dashboard-sales-list-section (hidden)
    block #saleMenu
      slot #Dashboard2017_SaleDraftQuote (hidden)
      slot #Dashboard2017_SalePendingInvoice (hidden)
      slot #Dashboard2017_SaleAwaitingPayment (hidden)
      slot #Dashboard2017_SaleOverdue (hidden)
      slot #Dashboard2017_SaleReadyToShip (hidden)
    heading "Draft orders"#PurchasesSelectedFilterHeader (hidden)
    tab pane#tab_SalesSection
      button "Go to sales list" primary
      button #SaleGrid_gridName_Options
      slot #divSales
  block #dashboard-product-overview-section (hidden)
    block #productOverviewMenu
    tab pane#productOverview_report
      button "Go to products list" primary
      button #ProductOverview_SellingsGrid_gridName_Options
      slot #divProductOverviewSellings
    tab pane#productOverview_brand
      button "Go to products list" primary
      button #ProductOverview_BrandGrid_gridName_Options
      slot #divProductOverviewBrand
    tab pane#productOverview_region
      button "Go to products list" primary
      button #ProductOverview_RegionGrid_gridName_Options
      slot #divProductOverviewRegion
  block #dashboard-customer-overview-section (hidden)
    block #customerOverviewMenu
    tab pane#customerOverview_topSelesRep
      button "Go to customers list" primary
      button #CustomerOverview_SalesRepGrid_gridName_Options
      slot #divCustomerOverviewSalesRep
    tab pane#customerOverview_topCustomers
      button "Go to customers list" primary
      button #CustomerOverview_TopCustomersGrid_gridName_Options
      slot #divCustomerOverviewTopCustomers
    tab pane#customerOverview_noBuysYet
      button "Go to customers list" primary
      button #CustomerOverview_NoBuysGrid_gridName_Options
      slot #divCustomerOverviewNoBuys
    tab pane#customerOverview_byProducts
      button "Go to customers list" primary
      slot #Dashboard_CustomerOverviewByProducts
      button #CustomerOverview_ByProductsGrid_gridName_Options
      slot #divCustomerOverviewByProducts
  block #dashboard-reorder-section (hidden)
    input text#divSearch placeholder "Type text to search"
    button "Search" primary
    button #ReorderGrid_gridName_Options
    slot #divReorder
  block #dashboard-reminder-section (hidden)
    slot #ulReminder
    slot #divReminder
    block #divReminderNoData (hidden)
modal#dlgClearDemoData small
  heading "Clear demo data"
  button "×"
  button "Clear demo data"#btnClearDemoData primary
  button "Cancel"
modal#dlgDemoDataDeletePreview small
  heading "Delete demo data"
  button "×"
  block #dlgDemoDataDeletePreview_hasdata
    table
    text "Including demo data for: Deprecation, ShipZone, Deal, Discount, AttributeSet"
  block #dlgDemoDataDeletePreview_nodata (hidden)
    text "No data to delete."
  button "Delete demo data"#dlgDemoDataDeletePreview_btnDelete primary
  button "Cancel"
modal#dlgDemoDataDeletePreview_Details medium
  heading 
  button "×"
  button "Cancel"
modal#gridViewModal medium
  heading "Report"#allocationHeader
  button "×"
  slot #divReportGridContainer
  button "Close"
slot #fb-root
```

## Components by bundle

What the page code builds and mounts into the layout's slots.

### `ContinueSetup`

2 grids · 0 standalone fields · 0 windows · 0 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `AccountsReconciliationGrid` · store `OnboardingReconciliationStore` · placeholder `Not available`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | External account | `ExternalName` |  | flex 1 | renderer() |  |
    | {Ext.String.format(…)} | `EntityCode` |  | flex 1 | renderer() |  |

- **grid** · renders into `TaxRulesReconciliationGrid` · store `OnboardingReconciliationStore` · placeholder `Not available`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | External tax rule | `ExternalName` |  | flex 1 | renderer() |  |
    | {Ext.String.format(…)} | `EntityCode` |  | flex 1 | renderer() |  |


### `Home2019`

15 grids · 5 standalone fields · 0 windows · 8 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `renderTo` · store `store` · placeholder `Please upload a file to check for issues.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Line # | `Line` |  | 50 |  |  |
    | Product code | `ProductCode` |  | 200 | renderer() |  |
    | Name | `Name` |  | 300 | renderer() |  |
    | Category | `Category` |  | 200 | renderer() |  |
    | Brand | `Brand` |  | 200 | renderer() |  |
    | Type | `Type` |  | 100 | renderer() |  |
    | Costing method | `CostingMethod` |  | 150 | renderer() |  |
    | Length | `Length` |  | 100 | renderer() |  |
    | Width | `Width` |  | 100 | renderer() |  |
    | Height | `Height` |  | 100 | renderer() |  |
    | Dimension units | `DimensionUnits` |  | 100 | renderer() |  |
    | Weight | `Weight` |  | 100 | renderer() |  |
    | Weight units | `WeightUnits` |  | 100 | renderer() |  |
    | Barcode | `Barcode` |  | 150 | renderer() |  |
    | Minimum before reorder | `MinimumBeforeReorder` |  | 100 | renderer() |  |
    | Reorder quantity | `ReorderQuantity` |  | 150 | renderer() |  |
    | Default location | `DefaultLocation` |  | 150 | renderer() |  |
    | Last supplied by | `LastSuppliedBy` |  | 200 | renderer() |  |
    | Supplier product code | `SupplierProductCode` |  | 300 | renderer() |  |
    | Supplier product name | `SupplierProductName` |  | 300 | renderer() |  |
    | Price tier 1 | `PriceTier1` |  | 130 | renderer() |  |
    | Price tier 2 | `PriceTier2` |  | 130 | renderer() |  |
    | Price tier 3 | `PriceTier3` |  | 130 | renderer() |  |
    | Price tier 4 | `PriceTier4` |  | 130 | renderer() |  |
    | Price tier 5 | `PriceTier5` |  | 130 | renderer() |  |
    | Price tier 6 | `PriceTier6` |  | 130 | renderer() |  |
    | Price tier 7 | `PriceTier7` |  | 130 | renderer() |  |
    | Price tier 8 | `PriceTier8` |  | 130 | renderer() |  |
    | Price tier 9 | `PriceTier9` |  | 130 | renderer() |  |
    | Price tier 10 | `PriceTier10` |  | 130 | renderer() |  |
    | Assembly BOM | `AssemblyBOM` |  | 200 | renderer() |  |
    | Auto assemble | `AutoAssemble` |  | 200 | renderer() |  |
    | Auto disassemble | `Auto Disassemble` |  | 200 | renderer() |  |
    | Drop ship | `DropShip` |  | 200 | renderer() |  |
    | Average cost | `AverageCost` |  | 130 | renderer() |  |
    | Default unit of measure | `DefaultUnitOfMeasure` |  | 200 | renderer() |  |
    | Inventory account | `InventoryAccount` |  | 200 | renderer() |  |
    | Revenue account | `RevenueAccount` |  | 200 | renderer() |  |
    | Expense account | `ExpenseAccount` |  | 200 | renderer() |  |
    | COGS account | `COGSAccount` |  | 200 | renderer() |  |
    | Product attribute set | `ProductAttributeSet` |  | 200 | renderer() |  |
    | Additional attribute 1 | `AdditionalAttribute1` |  | 200 | renderer() |  |
    | Additional attribute 2 | `AdditionalAttribute2` |  | 200 | renderer() |  |
    | Additional attribute 3 | `AdditionalAttribute3` |  | 200 | renderer() |  |
    | Additional attribute 4 | `AdditionalAttribute4` |  | 200 | renderer() |  |
    | Additional attribute 5 | `AdditionalAttribute5` |  | 200 | renderer() |  |
    | Additional attribute 6 | `AdditionalAttribute6` |  | 200 | renderer() |  |
    | Additional attribute 7 | `AdditionalAttribute7` |  | 200 | renderer() |  |
    | Additional attribute 8 | `AdditionalAttribute8` |  | 200 | renderer() |  |
    | Additional attribute 9 | `AdditionalAttribute9` |  | 200 | renderer() |  |
    | Additional attribute 10 | `AdditionalAttribute10` |  | 200 | renderer() |  |
    | Discount name | `DiscountName` |  | 200 | renderer() |  |
    | Product family SKU | `ProductFamilySKU` |  | 200 | renderer() |  |
    | Product family option 1 value | `ProductFamilyOption1Value` |  | 200 | renderer() |  |
    | Product family option 2 value | `ProductFamilyOption2Value` |  | 200 | renderer() |  |
    | Product family option 3 value | `ProductFamilyOption3Value` |  | 200 | renderer() |  |
    | Comma-delimited tags | `CommaDelimitedTags` |  | 200 | renderer() |  |
    | Stock locator | `StockLocator` |  | 200 | renderer() |  |
    | Purchase tax rule | `PurchaseTaxRule` |  | 200 | renderer() |  |
    | Sale tax rule | `SaleTaxRule` |  | 200 | renderer() |  |
    | Status | `Status` |  | 100 | renderer() |  |
    | Pick zones | `PickZones` |  | 100 | renderer() |  |
    | Always show quantity | `AlwaysShowQuantity` |  | 200 | renderer() |  |
    | Production BOM | `ProductionBOM` |  | 200 | renderer() |  |
    | Quantity to produce | `QuantityToProduce` |  | 200 | renderer() |  |

- **grid** · renders into `renderTo` · store `store`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Line # | `Line` |  | 50 | RenderHTMLText |  |
    | Name | `Name` |  | 100 | renderer() |  |
    | Status | `Status` |  | 100 | renderer() |  |
    | Currency | `Currency` |  | 100 | renderer() |  |
    | Payment term | `PaymentTerm` |  | 100 | renderer() |  |
    | Tax rule | `TaxRule` |  | 100 | renderer() |  |
    | Account receivable | `AccountReceivable` |  | 100 | renderer() |  |
    | Sale account | `SaleAccount` |  | 100 | renderer() |  |
    | Price tier | `PriceTier` |  | 100 | renderer() |  |
    | Discount | `Discount` |  | 100 | renderer() |  |
    | Credit limit | `CreditLimit` |  | 100 | renderer() |  |
    | Carrier | `Carrier` |  | 100 | renderer() |  |
    | Sales representative | `SalesRepresentative` |  | 100 | renderer() |  |
    | Location | `Location` |  | 100 | renderer() |  |
    | TaxNumber | `TaxNumber` |  | 100 | renderer() |  |
    | Tags | `Tags` |  | 100 | renderer() |  |
    | Display name | `DisplayName` |  | 100 | renderer() |  |
    | Is legal entity | `IsLegalEntity` |  | 100 | renderer() |  |
    | Parent customer | `ParentCustomer` |  | 100 | renderer() |  |
    | Is bill parent | `IsBillParent` |  | 100 | renderer() |  |
    | Attribute set | `AttributeSet` |  | 100 | renderer() |  |
    | Additional attribute 1 | `AdditionalAttribute1` |  | 100 | renderer() |  |
    | Additional attribute 2 | `AdditionalAttribute2` |  | 100 | renderer() |  |
    | Additional attribute 3 | `AdditionalAttribute3` |  | 100 | renderer() |  |
    | Additional attribute 4 | `AdditionalAttribute4` |  | 100 | renderer() |  |
    | Additional attribute 5 | `AdditionalAttribute5` |  | 100 | renderer() |  |
    | Additional attribute 6 | `AdditionalAttribute6` |  | 100 | renderer() |  |
    | Additional attribute 7 | `AdditionalAttribute7` |  | 100 | renderer() |  |
    | Additional attribute 8 | `AdditionalAttribute8` |  | 100 | renderer() |  |
    | Additional attribute 9 | `AdditionalAttribute9` |  | 100 | renderer() |  |
    | Additional attribute 10 | `AdditionalAttribute10` |  | 100 | renderer() |  |
    | Comments | `Comments` |  | 100 | renderer() |  |
    | Contact name | `ContactName` |  | 100 | renderer() |  |
    | Phone | `Phone` |  | 100 | renderer() |  |
    | Fax | `Fax` |  | 100 | renderer() |  |
    | Email | `Email` |  | 100 | renderer() |  |
    | Website | `Website` |  | 100 | renderer() |  |
    | Contact comment | `ContactComment` |  | 200 | renderer() |  |
    | Contact default | `ContactDefault` |  | 100 | renderer() |  |

- **grid** · renders into `renderTo` · store `store` · placeholder `Please upload a file to check for issues.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Line # | `Line` |  | 50 |  |  |
    | Name | `Name` |  | 100 | renderer() |  |
    | Status | `Status` |  | 100 | renderer() |  |
    | Currency | `Currency` |  | 100 | renderer() |  |
    | Payment term | `PaymentTerm` |  | 100 | renderer() |  |
    | Tax rule | `TaxRule` |  | 100 | renderer() |  |
    | Account payable | `AccountPayable` |  | 100 | renderer() |  |
    | Carrier | `Carrier` |  | 100 | renderer() |  |
    | Discount | `Discount` |  | 100 | renderer() |  |
    | TaxNumber | `TaxNumber` |  | 100 | renderer() |  |
    | Attribute set | `AttributeSet` |  | 100 | renderer() |  |
    | Additional attribute 1 | `AdditionalAttribute1` |  | 100 | renderer() |  |
    | Additional attribute 2 | `AdditionalAttribute2` |  | 100 | renderer() |  |
    | Additional attribute 3 | `AdditionalAttribute3` |  | 100 | renderer() |  |
    | Additional attribute 4 | `AdditionalAttribute4` |  | 100 | renderer() |  |
    | Additional attribute 5 | `AdditionalAttribute5` |  | 100 | renderer() |  |
    | Additional attribute 6 | `AdditionalAttribute6` |  | 100 | renderer() |  |
    | Additional attribute 7 | `AdditionalAttribute7` |  | 100 | renderer() |  |
    | Additional attribute 8 | `AdditionalAttribute8` |  | 100 | renderer() |  |
    | Additional attribute 9 | `AdditionalAttribute9` |  | 100 | renderer() |  |
    | Additional attribute 10 | `AdditionalAttribute10` |  | 100 | renderer() |  |
    | Comments | `Comments` |  | 100 | renderer() |  |
    | Contact name | `ContactName` |  | 100 | renderer() |  |
    | Job title | `JobTitle` |  | 100 | renderer() |  |
    | Phone | `Phone` |  | 100 | renderer() |  |
    | Mobile phone | `MobilePhone` |  | 100 | renderer() |  |
    | Fax | `Fax` |  | 100 | renderer() |  |
    | Email | `Email` |  | 100 | renderer() |  |
    | Website | `Website` |  | 100 | renderer() |  |
    | Contact comment | `ContactComment` |  | 200 | renderer() |  |
    | Contact default | `ContactDefault` |  | 100 | renderer() |  |
    | Contact include in email | `ContactIncludeInEmail` |  | 100 | renderer() |  |

- **grid** · renders into `renderTo` · store `store` · placeholder `Please upload a file to check for issues.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Line # | `Line` |  | 50 |  |  |

- **grid** · renders into `divPurchases` · store `PurchaseStore` · placeholder `No purchases found.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Order # | `OrderNo` |  | flex 2 | renderer() |  |
    | Order date | `OrderDate` |  | flex 2 | renderer() |  |
    | Due date | `InvoiceDueDate` |  | flex 2 | renderer() |  |
    | Supplier | `Supplier` |  | flex 4 | renderer() |  |
    | Due amount | `Due` |  | flex 2 | renderer() |  |
    | Invoiced amount | `Invoiced` |  | flex 2 | renderer() |  |
    | Ordered amount | `Ordered` |  | flex 2 | renderer() |  |
    | Required by | `ShipmentRequiredByDate` |  | flex 2 | renderer() |  |

- **grid** · renders into `divSales` · store `SaleStore` · placeholder `No sales found.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Order # | `OrderNo` |  | flex 2 | renderer() |  |
    | Order date | `OrderDate` |  | flex 2 | renderer() |  |
    | Ship by date | `InvoiceDueDate` |  | flex 2 | renderer() |  |
    | Due amount | `Due` |  | flex 2 | renderer() |  |
    | Total | `Amount` |  | flex 2 | renderer() |  |
    | Customer | `Customer` |  | flex 4 | renderer() |  |

- **grid** · renders into `divReorder` · store `ReorderStore` · placeholder `You do not have any products to reorder at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | SKU | `ProductCode` |  | flex 1 | renderer() |  |
    | Product description | `Name` |  | flex 2 | renderer() |  |
    | Supplier | `Supplier` |  | flex 2 | renderer() |  |
    | Reorder quantities shown here depend on your purchase proce… | `Available` |  | flex 1 |  |  |

- **grid** · renders into `divProductOverviewSellings` · store `Dashboard_ProductOverview_SellingsStore` · placeholder `No products`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    |  | `ProductImage` |  | 40 |  |  |
    | Product | `ProductName` |  | flex 3 | renderer() |  |
    | Price | `Price` |  | flex 1 | renderer() |  |
    | Sold | `Quantity` |  | flex 1 | renderer() |  |
    | Sale | `` |  | flex 1 | renderer() |  |
    | Tax | `Tax` |  | flex 1 | renderer() |  |
    | Total | `Quantity` |  | flex 1 | renderer() |  |

- **grid** · renders into `divProductOverviewBrand` · store `Dashboard_ProductOverview_BrandStore` · placeholder `No brands`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Brand | `Name` |  | flex 3 | renderer() |  |
    | Quantity | `Quantity` |  | flex 1 | renderer() |  |
    | Sale | `` |  | flex 1 | renderer() |  |
    | Tax | `Tax` |  | flex 1 | renderer() |  |
    | Total | `Amount` |  | flex 1 | renderer() |  |

- **grid** · renders into `divProductOverviewRegion` · store `Dashboard_ProductOverview_RegionStore` · placeholder `No regions`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Country | `Country` |  | flex 3 | renderer() |  |
    | City | `City` |  | flex 3 | renderer() |  |
    | Sale | `` |  | flex 1 | renderer() |  |
    | Tax | `Tax` |  | flex 1 | renderer() |  |
    | Total | `Amount` |  | flex 1 | renderer() |  |

- **grid** · renders into `divCustomerOverviewSalesRep` · store `Dashboard_CustomerOverview_SalesRepStore` · placeholder `No sales reps.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Sales rep | `SaleRep` |  | flex 3 | RenderHTMLText |  |
    | Sales | `Sales` |  | flex 1 | renderer() |  |
    | Sale | `` |  | flex 1 | renderer() |  |
    | Tax | `Tax` |  | flex 1 | renderer() |  |
    | Total | `Amount` |  | flex 1 | renderer() |  |

- **grid** · renders into `divCustomerOverviewTopCustomers` · store `Dashboard_CustomerOverview_TopCustomersStore` · placeholder `No customers`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Customer | `CustomerName` |  | flex 3 | renderer() |  |
    | Sales | `Sales` |  | flex 1 | renderer() |  |
    | Sale | `` |  | flex 1 | renderer() |  |
    | Tax | `Tax` |  | flex 1 | renderer() |  |
    | Total | `Amount` |  | flex 1 | renderer() |  |

- **grid** · renders into `divCustomerOverviewNoBuys` · store `Dashboard_CustomerOverview_NoBuysStore` · placeholder `No customers`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Customer | `CustomerName` |  | flex 1 | renderer() |  |

- **grid** · renders into `divCustomerOverviewByProducts` · store `Dashboard_CustomerOverview_ByProductStore` · placeholder `No customers, please select a product.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Customer | `CustomerName` |  | flex 3 | renderer() |  |
    | Sales | `Sales` |  | flex 1 | renderer() |  |
    | Sale | `` |  | flex 1 | renderer() |  |
    | Tax | `Tax` |  | flex 1 | renderer() |  |
    | Total | `Amount` |  | flex 1 | renderer() |  |

- **grid** · renders into `divReportGridContainer` · store `ReportStore`

#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| date field |  | `Sale_Index_ShipmentRequiredByDate` | `` | placeholder `Choose date` · format `UserDateFormat` |
| combo |  | `"extLocation_".concat(…)` | `vTenantLocationLoadStore[widgetName]` | shows `Description` · value `LocationID` · placeholder `Choose...` |
| combo |  | `Dashboard_CustomerOverviewByProducts` | `dashboardProductsStore` | shows `Name` · value `ProductID` · placeholder `Select product` |
| date field |  | `startreportrangemanual` | `` | placeholder `Choose...` · format `dearDateFormat` |
| date field |  | `endreportrangemanual` | `` | placeholder `Choose...` · format `dearDateFormat` |

#### Menus, buttons and other parts

- **column** · field `j`
- **column** “{title}” · field `field`
- **EmbeddedCalendarPicker** · renders into `startreportrange` · placeholder `Choose...` · format `dearDateFormat`
- **EmbeddedCalendarPicker** · renders into `endreportrange` · placeholder `Choose...` · format `dearDateFormat`
- **column** “Date” · field `Index`
- **column** “{series.label}” · field `series.label`
- **column** “Due” · field `Due`
- **column** “Overdue” · field `Overdue`

