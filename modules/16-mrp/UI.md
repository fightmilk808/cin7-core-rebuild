# MRP: UI

Every component the page code builds, read from the shipped ExtJS bundles: grids with their columns, fields, buttons, menus, windows and custom components. Labels are the English UI text. `renders into` is the id of the `<div>` in the page's server-rendered HTML that the component mounts in; `store` names the data store (see the endpoints in [README.md](README.md)); `on click` is the handler. Visual system and shell layout: [docs/UI.md](../../docs/UI.md).

## Screens

| Route | Title | Bundles |
|---|---|---|
| `/MRP` | MRP run settings | [`ReportService`](#reportservice), [`MRPRunSettings`](#mrprunsettings) |
| `/MRPList` | MRP list | [`MRPList`](#mrplist) |
| `/MRPScheduler` | MRP Scheduler | [`MRPScheduler`](#mrpscheduler) |

## Layout

Each screen's server-rendered HTML inside the shell, as an outline: headings, tabs, sections, labels, inputs (`#id`), buttons (`▾` = dropdown), menus, tables and `slot`s (empty `<div>`s the components below mount into). `(hidden)` parts are shown by the page code when needed. Read with GET from a signed-in session; no values are kept.

### `/MRP`: MRP run settings

Frame: `iReportFrame`.

```text
link "Home"
link "List"
select#cmbSavedSettings
button "Delete settings"#btnDeleteSettings
button "Run"#btnRun primary
button "Show on Scheduler"#btnScheduler primary (hidden)
button "Complete"#btnComplete primary
button "View Scheduler"#btnOpenScheduler (hidden)
button "Back to list"#btnBack
block #alertDetailsDeleted (hidden)
  text "All MRP run details have been deleted."
slot #FeatureModuleDetailsBlock (hidden)
block #divCollapsible
  heading "MRP run"
  slot #txtMRPRunID
  button "Reset settings"#btnResetSettings
  button "Save as"#btnSaveSettingsAs primary
  button 
  block #divGeneral
    heading "General"
    input checkbox#chkIsLoadDetails
    label "Load demand with details" for #chkIsLoadDetails
    block #cmbPlanningPeriod
      button "Choose..."#btnPlanningPeriod ▾
      label "Planning period"
    slot #cmbLocation
    label "Location"
    slot #cmbCustomer
    label "Customer"
    heading "Supply settings"
    input checkbox#chkIgnoreStockOnHand
    label "Ignore stock on hand/on order" for #chkIgnoreStockOnHand
    block #divProcureUpTo
      heading "Procure up to"
      input checkbox#chkProcureUpToStockLevel
      label "Stock level" for #chkProcureUpToStockLevel
      input checkbox#chkProcureUpToMinimumBeforeReorder
      label "Minimum before reorder" for #chkProcureUpToMinimumBeforeReorder
    input checkbox#chkIncludePastDueDemand
    label "Include overdue demand" for #chkIncludePastDueDemand
    input checkbox#chkIncludeDraftAndPlannedSupplyTasks
    label "Include draft and planned supply orders" for #chkIncludeDraftAndPlannedSupplyTasks
    input checkbox#chkBomExplosion
    label "BOM explosion" for #chkBomExplosion
    input checkbox#chkIncludeForecast
    label "Include forecast demand" for #chkIncludeForecast
    block #divForecastBtns (hidden)
      select#cmbSalesForecastTemplate: {saved forecast templates}
      input file#fileImportForecast (hidden)
      button "Download CSV template"#btnDownloadForecast
      button "Upload forecast"#btnUploadForecast primary
      button "Remove"#btnRemoveForecast (hidden)
    block #divDemandSourceSettings
      heading "Demand source"
      block #divDemandSales
        heading "Sales"
        input checkbox#rbtnSalesAll
        label "All" for #rbtnSalesAll
        input checkbox#rbtnSalesAuth
        label "Authorized" for #rbtnSalesAuth
        input checkbox#rbtnSalesNotAuth
        label "Not authorized" for #rbtnSalesNotAuth
      heading "Production"
      input checkbox#chkProductionDraft
      label "Include draft" for #chkProductionDraft
      input checkbox#chkProductionPlanned
      label "Include planned" for #chkProductionPlanned
      input checkbox#chkProductionReleased
      label "Include released" for #chkProductionReleased
      heading "Assembly"
      input checkbox#chkAssemblyDraft
      label "Include draft" for #chkAssemblyDraft
      input checkbox#chkAssemblyReleased
      label "Include released" for #chkAssemblyReleased
      heading "Transfer"
      input checkbox#chkTransferDraft
      label "Include draft" for #chkTransferDraft
    heading "Supply order status"
    select#cmbTransferStatus: Draft | Ordered
    label "Transfer order"
    select#cmbProductionOrderStatus: Draft | Planned
    label "Production order"
    select#cmbAssemblyStatus: Draft | Authorized
    label "Assembly order"
    select#cmbPurchaseStatus: Draft | Awaiting approval | Ordered
    label "Purchase order"
    select#cmbSupplyTask: Set up for supply rule | With the lowest price | With the lowest lead time | Latest supplier
    label "Purchase order supplier"
    heading "Consolidate suggestions by source"
    input checkbox#chkConsolidationType_Purchase
    label "Consolidate suggestions by source" for #chkConsolidationType_Purchase
    block #btnPlanningPeriod_popup (hidden)
      link "This week"
      link "Next week"
      link "This month"
      link "Next month"
      block #divCalendarForm
        slot #cmbPlanFrom
        label "From"
        slot #cmbPlanTo
        label "To"
        button "Apply"#btnApplyDateRange primary
block #divRun (hidden)
  tabs#ulNavigation: Demand #demand | Suggested supply orders #suggestions | Results #results | Errors #errors | Activity log #log
  tab pane#demand
    block #divReportFrameLoading
    slot #iReportFrame (hidden)
    modal#fieldsSpecificationModal small
      heading "Fields specification"
      button "x"
      text "This report shows MRP demands."
  tab pane#suggestions
    input text#txtSuggestionsSearchField placeholder "Type text to search"
    button "Search"#btnSuggestionsSearch primary
    button "Merge"#btnMergeSuggestion primary
    button "Products"#btnProductsFilter
    button "Reset all filters"#btnClearFilters (hidden)
    slot #cmbFilterDemandLocation
    label "Demand in"
    slot #cmbFilterSupplyLocation
    label "Supply from/buy from"
    slot #cmbFilterSupplyTask
    label "Supply order"
    button "Confirm"#btnReorder primary
    button "Recalculate"#btnRecalculate primary
    button "Export"#btnSuggestionExport
    block #divSelectedProductsFilters (hidden)
    input checkbox#ckbShowProducts
    label "Show products" for #ckbShowProducts
    slot #divGridSupplySuggestions
  tab pane#results
    input text#txtResultsSearchField placeholder "Type text to search"
    button "Search"#btnResultsSearch primary
    slot #divGridSupplyResults
  tab pane#errors
    input text#txtErrorsSearchField placeholder "Type text to search"
    button "Search"#btnErrorsSearch primary
    block #divErrorTypeTabs (hidden)
      tabs#ulErrorNavigation: Critical #critical | Warning #warning | Information #information
    tab pane
      slot #divGridSupplyErrors
  tab pane#log
    input text#txtLogSearchField placeholder "Type text to search"
    button "Search"#btnLogSearch primary
    slot #divGridActivityLog
modal#dlgForecastUploadingErrors medium
  heading "Issues while uploading forecast"
  button "×"
  slot #divForecastUploadingErrorsAlert
  slot #divForecastUploadingErrorsGrid
  button "Close"
form#frmExportSupplySuggestion
```

### `/MRPList`: MRP list

Frame: `task-upload-frame`.

```text
link "Home"
slot #FeatureModuleDetailsBlock (hidden)
button #btnAdd primary
input text#txtSearch placeholder "Type text to search"
button "Search"#btnSearch primary
button "Complete"#btnCompleteMRPGrid primary
button "Refresh"#btnRefresh
button "Delete"#btnDelete
slot #divMRPListGrid
```

### `/MRPScheduler`: MRP Scheduler

Frame: `task-upload-frame`.

```text
link "Home"
link "List"
link "MRP"#aMRPBreadcrumb
button "Back to MRP"#btnBack
tabs#ulMrpSchedulerTabs: Supply vs demand #demand | Supply orders #supply
button #btnFullscreen
button "Tutorial"
button #btnViewSetup
block #viewSetupDropdownList
  link "Collapse all groups"#btnCollapseAll (hidden)
  link "Expand all groups"#btnExpandAll (hidden)
  input checkbox#chkHorizontalLines
  label "Horizontal lines" for #chkHorizontalLines
  input checkbox#chkVerticalLines
  label "Vertical lines" for #chkVerticalLines
  input checkbox#chkUnusedDays
  label "Show unused days" for #chkUnusedDays
  input checkbox#chkSuggestions
  label "Show suggestions" for #chkSuggestions
  input checkbox#chkSupplyDays
  label "Show supply days" for #chkSupplyDays
  input checkbox#chkWeekends
  label "Show weekends" for #chkWeekends
  input radio#radioDay name=scale
  label "Day" for #radioDay
  input radio#radioWeek name=scale
  label "Week" for #radioWeek
slot #spanPeriodFrom
slot #spanPeriodTo
select#cmbOrderType multiple: All orders | Purchase orders | Transfer order | Assemblies | Production orders
select#cmbLocation
input text#txtMrpSchedulerSearchField placeholder "Type to search"
button #btnMrpSchedulerSearch primary
slot #ganttContainer
```

## Components by bundle

What the page code builds and mounts into the layout's slots.

### `MRPList`

1 grids · 0 standalone fields · 0 windows · 0 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `divMRPListGrid` · store `store` · placeholder `You do not have any MRP at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | MRP run | `Number` |  | flex 1 | RenderHTMLText |  |
    | Created by | `CreatedBy` |  | flex 1 | RenderHTMLText |  |
    | Date | `CreatedAt` | date column | flex 1 | renderer() |  |
    | Status | `Status` |  | flex 1 | renderer() |  |


### `MRPRunSettings`

7 grids · 5 standalone fields · 0 windows · 2 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `divForecastUploadingErrorsGrid` · store `store` · placeholder `Please upload a file to check for issues.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Line # | `Line` |  | 55 |  |  |
    | Demand | `DemandLocation` |  | flex 1 | RenderHTMLText |  |
    | SKU | `ProductSku` |  | flex 1 | RenderHTMLText |  |
    | Name | `ProductName` |  | flex 1 | RenderHTMLText |  |
    | Quantity | `Quantity` |  | 80 | RenderHTMLText |  |
    | Required by date | `RequiredByDate` | date column | 100 | renderer() |  |

- **grid** · renders into `divGridSplitProducts` · store `store` · placeholder `No products.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `ProductID` |  | flex 5 | renderer() |  |
    | Quantity | `Quantity` |  | flex 1 | RenderHTMLText |  |
    | UOM | `UnitOfMeasure` |  | flex 1 | RenderHTMLText |  |
    | Split | `IsSplitted` |  | flex 1 | renderer() |  |

- **grid** · renders into `"divGridProductsTask".concat(…)` · store `subStores[i]` · placeholder `No products.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `ProductCode` |  | flex 5 | renderer() |  |
    | Quantity | `Quantity` |  | flex 1 | RenderHTMLText |  |
    | UOM | `UnitOfMeasure` |  | flex 1 | RenderHTMLText |  |

- **grid** · renders into `divGridSupplyErrors` · store `store` · placeholder `No supply errors.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Error description | `Message` |  | flex 1 | renderer() |  |

- **grid** · renders into `divResultsId` · store `store` · placeholder `You have not created any supply orders at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Supply task | `TaskNumber` |  | flex 1 | renderer() |  |
    | Total QTY | `TotalQuantity` |  | 80 | RenderHTMLText |  |
    | Demand | `DemandLocationName` |  | flex 1 | RenderHTMLText |  |
    | Supply | `SupplyName` |  | flex 1 | RenderHTMLText |  |
    | Required by date | `RequiredByDate` | date column | flex 1 | renderer() |  |
    | Status | `TaskStatus` |  | flex 1 | RenderHTMLText |  |
    | Created by | `CreatedBy` |  | flex 1 | RenderHTMLText |  |
    | Created at | `CreatedAt` | date column | flex 1 | renderer() |  |
    |  | `` |  | 110 | renderer() |  |

- **grid** · renders into `divGridShowProducts` · store `productStore` · placeholder `No products.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `ProductID` |  | flex 5 | renderer() |  |
    | Quantity | `Quantity` |  | flex 1 | RenderHTMLText |  |
    | UOM | `UnitOfMeasure` |  | flex 1 | RenderHTMLText |  |
    | Split | `IsSplitted` |  | flex 1 | renderer() |  |

- **grid** · renders into `divGridActivityLog` · store `store` · placeholder `You do not have any activity at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Action | `Message` |  | flex 2 | RenderHTMLText |  |
    | Supply order | `TaskType` |  | 110 | RenderHTMLText |  |
    | Demand in | `DemandLocationName` |  | flex 1 | RenderHTMLText |  |
    | Supply from/buy from | `SupplyName` |  | flex 1 | RenderHTMLText |  |
    | User | `Username` |  | flex 1 | RenderHTMLText |  |
    | Date/time | `Date` | date column | flex 1 | renderer() |  |


#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| date field |  | `cmbPlanFrom` | `` | placeholder `Choose...` · format `UserDateFormat` |
| date field |  | `cmbPlanTo` | `` | placeholder `Choose...` · format `UserDateFormat` |
| combo |  | `cmbCustomer` | `customerListStore` | shows `Name` · value `CustomerID` · placeholder `Choose...` · multi-select |
| combo |  | `cmbLocation` | `locationListStore` | shows `Name` · value `ID` · placeholder `Choose...` · multi-select |
| combo |  | `renderToId` | `store` | shows `fieldName` · value `fieldValue` · placeholder `Choose...` · multi-select |

#### Menus, buttons and other parts

- **column** · renders into `divSuggestionsId` · store `suggestionStore` · placeholder `You do not have any supply orders at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    |  | `Expand` |  | 58 | renderer() |  |
    | Supply order | `SupplyTask` |  | flex 1 | renderer() |  |
    | Products | `` |  | flex 1 | renderer() |  |
    | Demand in | `DemandLocationName` |  | flex 1 | RenderHTMLText |  |
    | Supply from/buy from | `SupplyID` |  | flex 1 | renderer() |  |
    | Required by date | `RequiredByDate` | date column | flex 1 | renderer() · edit: date field |  |
    | Status | `TaskStatus` |  | flex 1 | renderer() |  |

- **action column** · id `actionColumn_validationstate`
  - **component** · on click `handler()`

### `MRPScheduler`

1 grids · 0 standalone fields · 0 windows · 1 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `divRelatedOrdersDetails` · store `RelatedOrdersStore` · placeholder `No related orders created.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Order | `TaskNumber` |  | flex 1 | renderer() |  |
    | Type | `TaskTypeName` |  | flex 1 | RenderHTMLText |  |
    | Order date | `OrderDate` |  | flex 1 | renderer() |  |
    | Status | `Status` |  | flex 1 | renderer() |  |
    | Total | `TotalAmount` |  | 130 | renderer() |  |


#### Menus, buttons and other parts

- **component**
  - *columns:*
    - **component** · name `text`
    - **component** · name `start_date`
    - **component** · name `duration`
    - **component** · name `add`

