# Production: UI

Every component the page code builds, read from the shipped ExtJS bundles: grids with their columns, fields, buttons, menus, windows and custom components. Labels are the English UI text. `renders into` is the id of the `<div>` in the page's server-rendered HTML that the component mounts in; `store` names the data store (see the endpoints in [README.md](README.md)); `on click` is the handler. Visual system and shell layout: [docs/UI.md](../../docs/UI.md).

## Screens

| Route | Title | Bundles |
|---|---|---|
| `/CapacityPlanner` | Capacity Planner | [`CapacityPlanner`](#capacityplanner) |
| `/Disassembly` | Disassembly | [`Disassembly2019`](#disassembly2019) |
| `/DisassemblyList` | Disassemblies | [`DisassemblyList2019`](#disassemblylist2019) |
| `/FinishedGoods` | Assemblies | [`Assembly2019`](#assembly2019) |
| `/FinishedGoodsList` | Assemblies | [`FinishedGoodsList2019`](#finishedgoodslist2019) |
| `/IssueToProduction` | Inventory write-off | [`IssueToProduction2019`](#issuetoproduction2019) |
| `/IssueToProductionList` | Inventory write-off list | [`IssueToProductionList2019`](#issuetoproductionlist2019) |
| `/JobCosting` | Job details | [`JobCosting2019`](#jobcosting2019) |
| `/JobCostingList` | Job costings | [`JobCostingList2019`](#jobcostinglist2019) |
| `/ProductionCalendar` | Factory Calendar | [`ProductionCalendar`](#productioncalendar) |
| `/ProductionOrder` | Production order | [`Customization2019`](#customization2019), [`ProductionOrder`](#productionorder) |
| `/ProductionOrders` | Production orders list | [`ProductionOrdersList`](#productionorderslist) |
| `/ProductionResource` | Production resource | [`ProductionResource`](#productionresource) |
| `/ProductionScheduler` | Scheduler | [`Scheduler`](#scheduler) |
| `/ProductionSetup` | Setup | [`ProductionSetup`](#productionsetup) |

## Layout

Each screen's server-rendered HTML inside the shell, as an outline: headings, tabs, sections, labels, inputs (`#id`), buttons (`▾` = dropdown), menus, tables and `slot`s (empty `<div>`s the components below mount into). `(hidden)` parts are shown by the page code when needed. Read with GET from a signed-in session; no values are kept.

### `/CapacityPlanner`: Capacity Planner

Frame: `task-upload-frame`.

```text
link "Home"
link "Production"
heading "Capacity Planner"
slot #chkOverAllocated
label "Show overallocated" for #chkOverAllocated
slot #cmbPlanFrom
label "From" for #cmbPlanFrom
slot #cmbPlanTo
label "To" for #cmbPlanTo
slot #cmbResource
label "Resource" for #cmbResource
slot #cmbLocation
label "Shop floor" for #cmbLocation
button "Refresh"#divRefresh
block #GridOptions_GeneralContainer
  button #Grid_gridName_Options1
slot #listContainer
modal#dlgShowCapacityDetails large
  heading 
  button "×"
  slot #detailsContainer
```

### `/Disassembly`: Disassembly

Frame: `iUpload`.

```text
link "Home"
link "Disassemblies"
button "Save"#saveAction primary
button "Back to list"
button "Print"#printAction ▾
menu#PrintMenu: 
block #divMainContent
  slot #Disassembly_Index_Status
  heading 
  button "Void"#voidAction
  button "Undo"#undoAction
  block #divDisassemblyTask (hidden)
    button 
    button  primary
    button "Workflow"
    button 
    button "Calendar"
  button #taskHeaderCollapse
  block #divTaskHeader
    slot #Disassembly_Index_MainValidationContainer
    slot #tdLocation
    label "Location"
    slot #tdProductCode
    label "SKU"
    slot #tdProductName
    label "Product name"
    slot #tdWIPAccount
    label "Work in progress account"
    slot #tdQuantity
    label "Quantity to disassemble*"
    input text#MaxQuantity
    label "Maximum quantity" for #MaxQuantity
    button #MaxQuantityCalc primary
    block #tdAssemblyInstruction
    block #liInvoiceDate
      slot #tdCompletionDate
      label "Completion date"
    textarea#divNotes placeholder "Write your comment here..."
    label "Comment"
  button "Pick"
  button "Result"
  button "Activity logs"
  button "Attachments"
  button "Financials"
  block #divPick (hidden)
    heading "Pick"
    button "Auto pick"#divAutoPick
    button "Authorize"#divAuthorise_Pick primary
    slot #divPickLines
  block #divResult (hidden)
    button #divNewLines_Component primary
    button "Load BOM"#divLoadBOM
    button "Complete"#divAuthorise_Result primary
    slot #ComponentsContainer
    button "Add more items"#Disassembly_Index_AddComponentsLineLink primary (hidden)
    button #divNewLines_Service primary
    slot #ServicesContainer
    button "Add more items"#Disassembly_Index_AddServicesLineLink primary (hidden)
    table
  block #divFinancial (hidden)
    heading "Financials"
    tabs: Edit accounting dimensions #financials-default (hidden) | Transactions #financials-transactions | Final accounting dimensions values #financials-real (hidden)
    tab pane#financials-default
      heading "Edit accounting dimensions"
      text "Accounting dimension settings can overwrite reference data. All accounting dimensions can be edited. Accounting dimensio"
      table#tableDefaultDimensions: Event type
    tab pane#financials-transactions
      heading "Transactions"
      button "Refresh"#divRefreshTransactions
      slot #divTDetails
    tab pane#financials-real
      heading "Final accounting dimensions values"
      input text#txtRealDimensionsSearch placeholder "Type text to search"
      button "Search"#btnRealDimensionsSearch primary
      button "Refresh"#btnRealDimensionsRefresh
      slot #divRealDimensions
  block #divActivityLogs (hidden)
    slot #ActivityLogs_Container
  block #divAttachments (hidden)
    heading "Attachments"
    block #preview-template (hidden)
    slot #iUpload (hidden)
    form#frmUpload
      heading "Drop files here or click to upload."
    button "Attach from Google Drive" primary
    slot #divAttachmentList
form#frmPrint
```

### `/DisassemblyList`: Disassemblies

Frame: `task-upload-frame`.

```text
link "Home"
block #divList
  heading "Disassemblies"
  button #divNew primary
  input text#divSearch placeholder "Type text to search"
  button "Search" primary
  select#divFilter
  button #divRefresh
  button #Grid_gridName_Options
  slot #DisassemblyList_Index_Container
```

### `/FinishedGoods`: Assemblies

Frame: `iUpload`.

```text
link "Home"
link "Assemblies"
button "Save"#saveAction primary
button "Back to list"
block #taskActions
  button "Print"#printAction ▾
  menu#PrintMenu: 
  button "Clone"#cloneAction
block #divMainContent
  slot #Assembly_Index_Status
  heading 
  block #divArchiveStatic (hidden)
  block #divApproveStatic (hidden)
  button "Void"#voidAction
  button "Undo"#undoAction
  block #divAssemblyTask (hidden)
    button 
    button  primary
    button "Workflow"
    button 
    button "Calendar"
  button #taskHeaderCollapse
  block #divTaskHeader
    slot #tdLocation
    label "Location*"
    slot #tdProductCode
    label "SKU*"
    slot #tdProductName
    label "Product name*"
    block #liBin
      slot #tdBin
      label "Bin"
    slot #tdWIPAccount
    label "Work in progress account*"
    slot #tdAccount
    label "Finished goods account*"
    block #job-milestone-section (hidden)
      slot #tdJobInfo
      slot #tdJobMilestone
      label "Milestone"
    slot #tdQuantity
    label "Quantity*"
    input text#MaxQuantity
    label "Maximum quantity" for #MaxQuantity
    button #MaxQuantityCalc primary
    block #tdAssemblyInstruction
    slot #tdWIPDate
    label "Work in progress date"
    slot #tdCompletionDate
    label "Completion date"
    block #liBatch
      slot #tdBatchSN
      label "Batch/serial no."
    block #liExpiryDate
      slot #tdExpiryDate
      label "Expiry date"
    textarea#divNotes placeholder "Write your comment here..."
    label "Comment"
  button "Assembly order"
  button "Pick"
  button "Excise tax"
  button "Manual journals"
  button "Attachments"
  button "Related orders"
  button "Logs and attributes"
  button "Financials"
  block #divOrder (hidden)
    heading "Order"
    button "Authorize"#divAuthorise_Order primary
    button "Allocate"#divAllocate_Order primary
    button "Complete"#divComplete_Order primary
    button #divNewLines_Order primary
    button "Load BOM"#divLoadBOM
    button "Scan"#divScan_Order
    slot #divOrderLines
    button "Add more items"#FinishedGoods_Index_AddOrderLineLink primary (hidden)
    text "Fields Wastage % and Wastage quantity are mutually exclusive."
  block #divPick (hidden)
    heading "Pick"
    button "Allocate"#divAllocate_Pick primary
    button "Complete"#divComplete_Pick primary
    button #divNewLines_Pick primary
    button "Scan"#divScan_Pick
    button "Auto pick"#divAuto_Pick
    slot #divPickLines
    button "Add more items"#FinishedGoods_Index_AddPickLineLink primary (hidden)
  block #divExciseTax (hidden)
    heading "Excise tax"
    slot #tdFinishedGoods_ExciseTax_ExciseTax
    label "Excise tax amount*"
    slot #tdFinishedGoods_ExciseTax_ExciseTaxEffectiveDate
    label "Excise tax effective date*"
    slot #tdFinishedGoods_ExciseTax_DateExciseTaxPaid
    label "Date of excise tax paid"
    button "Authorize"#divAuthorise_ExciseTax primary
  block #divManualJournals (hidden)
    heading "Manual journals"
    button #divNew_ManualJournals primary
    slot #divManualJournalsLines
    button "Add more items"#FinishedGoods_ManualJournals_Add primary (hidden)
  block #divAttachments (hidden)
    heading "Attachments"
    block #preview-template (hidden)
    slot #iUpload (hidden)
    form#frmUpload
      heading "Drop files here or click to upload."
    button "Attach from Google Drive" primary
    slot #divAttachmentList
  block #divActivityLogs (hidden)
    heading "Logs and attributes"
    block #divAttributeSet (hidden)
      heading "Additional attributes"
      block #liCustomField1
        slot #CustomField1
        label "Attribute 1"
      block #liCustomField2
        slot #CustomField2
        label "Attribute 2"
      block #liCustomField3
        slot #CustomField3
        label "Attribute 3"
      block #liCustomField4
        slot #CustomField4
        label "Attribute 4"
      block #liCustomField5
        slot #CustomField5
        label "Attribute 5"
      block #liCustomField6
        slot #CustomField6
        label "Attribute 6"
      block #liCustomField7
        slot #CustomField7
        label "Attribute 7"
      block #liCustomField8
        slot #CustomField8
        label "Attribute 8"
      block #liCustomField9
        slot #CustomField9
        label "Attribute 9"
      block #liCustomField10
        slot #CustomField10
        label "Attribute 10"
    slot #ActivityLogs_Container
  block #divFinancial (hidden)
    heading "Financials"
    tabs: Edit accounting dimensions #financials-default (hidden) | Transactions #financials-transactions | Final accounting dimensions values #financials-real (hidden)
    tab pane#financials-default
      heading "Edit accounting dimensions"
      text "Accounting dimension settings can overwrite reference data. All accounting dimensions can be edited. Accounting dimensio"
      table#tableDefaultDimensions: Event type
    tab pane#financials-transactions
      heading "Transactions"
      button "Refresh"#divRefreshTransactions
      slot #divTDetails
    tab pane#financials-real
      heading "Final accounting dimensions values"
      input text#txtRealDimensionsSearch placeholder "Type text to search"
      button "Search"#btnRealDimensionsSearch primary
      button "Refresh"#btnRealDimensionsRefresh
      slot #divRealDimensions
  block #divRelatedOrders (hidden)
    heading "Related orders"
    button "Refresh"#btnRefreshRelatedOrders
    slot #divRelatedOrdersDetails
form#frmPrint
form#frmClone
modal#divScanDialog small
  heading "Scanning"
  button "×"
  tabs: Automatic #AutomaticMode_tab | Manual #ManualMode_tab | Inventory #InventoryMode_tab
  block #divScanLocation (hidden)
    slot #tdScanLocation
    label "Location to pick from" for #cmbScanLocation
  block #scanDesc
  block #scanBar
    block #dScan
      slot #spScan
  slot #ScanValidationContainer (hidden)
  block #liScanPackBoxAutomatic (hidden)
    slot #tdScanPackBoxAutomatic
    label "Box #" for #txtScanPackBoxInventory
  input text#txtScanFocus
  block #divScanInfo (hidden)
    heading "Found product:"
    slot #divScanProductSelection (hidden)
    block #liScanPackBox (hidden)
      label "Box #:"
      slot #tdScanPackBox
    label "SKU:"
    block #tdScanProductCode
    label "Name:"
    block #tdScanName
    label "Barcode:"
    block #tdScanBarcode
    block #liScanBatchSN (hidden)
      label "Batch/serial number:"
      slot #tdScanBatchSN
    block #liScanExpiryDate (hidden)
      label "Expiry date:"
      slot #tdScanExpiryDate
    block #liScanQuantity (hidden)
      label "Quantity:"
      slot #tdScanQuantity
  block #ScanInventoryModeContainer (hidden)
    slot #divInventoryModeBarcodes
    label "Barcodes"
    block #liScanPackBoxInventory (hidden)
      slot #tdScanPackBoxInventory
      label "Box #"
  block #ScanInventoryModeControls (hidden)
    button "Save"#liScanSaveInventory primary
    button "Close"
  block #ScanManualModeControls (hidden)
    button "Save"#liScanSave primary (hidden)
    button "Close"
  block #divScanAutoActions
    button "Close"
modal#divCOGSAccDims small
  heading "Accounting dimensions"
  button "×"
  button "Save"#btnSaveCOGSAccDims primary
  button "Close"
slot #CountrySpecificScript
```

### `/FinishedGoodsList`: Assemblies

Frame: `task-upload-frame`.

```text
link "Home"
block #divList
  heading "Assemblies"
  button #divNew primary
  input text#divSearch placeholder "Type text to search"
  button "Search" primary
  select#divFilter
  button #divRefresh
  button #Grid_gridName_Options
  slot #FinishedGoodsList_Index_Container
```

### `/IssueToProduction`: Inventory write-off

Frame: `iUpload`.

```text
link "Home"
link "Inventory write-off list"
button "Save"#saveAction primary
button "Save"#btnSaveDistribution primary (hidden)
button "Back to list"
block #divMainContent
  slot #tdStatus
  heading 
  button "Void"#voidAction
  button "Complete"#completeAction primary
  button "Print" ▾
  slot #divPrintContainer
  button "Undo"#undoAction
  block #divIssueToProductionTask (hidden)
    button 
    button  primary
    button "Workflow"
    button 
    button "Calendar"
  button #taskHeaderCollapse
  block #divTaskHeader
    slot #tdLocation
    label "Location"
    slot #tdAccount
    label "Expense account"
    block #job-milestone-section (hidden)
      slot #tdJobInfo
      slot #tdJobMilestone
      label "Milestone"
    block #rowEffectiveDate
      slot #tdCompletionDate
      label "Effective date"
    block #divNote
      textarea#divNotes placeholder "Write your note here..."
      label "Notes"
  button "Inventory write-off"
  button "Attachments"
  button "Activity logs"
  button "Financials"
  block #divOrder (hidden)
    button #divNewLines primary
    button "Scan"#divButtonScan
    slot #GridContainer
    button "Add more items"#IssueToProduction_Index_AddLink primary (hidden)
    button "Export"#divExport_Components primary
    button "Import"#divImport_Components primary
  block #divActivityLogs (hidden)
    slot #ActivityLogs_Container
  block #divFinancial (hidden)
    heading "Financials"
    tabs: Edit accounting dimensions #financials-default (hidden) | Transactions #financials-transactions | Final accounting dimensions values #financials-real (hidden)
    tab pane#financials-default
      heading "Edit accounting dimensions"
      text "Accounting dimension settings can overwrite reference data. All accounting dimensions can be edited. Accounting dimensio"
      table#tableDefaultDimensions
    tab pane#financials-transactions
      heading "Transactions"
      button "Expenses"#divDistributeExpenses primary (hidden)
      button "Refresh"#divRefreshTransactions
      slot #divTDetails
    tab pane#financials-real
      heading "Final accounting dimensions values"
      input text#txtRealDimensionsSearch placeholder "Type text to search"
      button "Search"#btnRealDimensionsSearch primary
      button "Refresh"#btnRealDimensionsRefresh
      slot #divRealDimensions
  block #divAttachments (hidden)
    heading "Attachments"
    block #divAttachmentUpload
      block #divUploadContainer
        block #preview-template (hidden)
        slot #iUpload (hidden)
        form#frmUpload
          heading "Drop files here or click to upload."
    button "Attach from Google Drive" primary
    slot #divAttachmentList
  form#frmPrint
  modal#divUploadComponents medium
    heading "Upload an inventory write-off list"
    button "×"
    heading "1. Download this inventory write-off"
    heading "2. Add new and modify existing components in the file."
    heading "3. Upload"
    slot #UploadValidationContainer (hidden)
    block #UploadExceptionsContainer (hidden)
      slot #UploadExceptionsGrid
    form#frmUploadNewLines
      heading "Drop files here or click to upload."
    slot #ifrmDownloadComponents (hidden)
    form#frmDownloadComponents
    slot #ifrmUploadComponents (hidden)
    button "Close"
  slot #divFooterPlaceholder
  modal#divScan small
    heading "Scanning"
    button 
    tabs: Automatic #AutomaticMode_tab | Manual #ManualMode_tab | Inventory #InventoryMode_tab
    block #divScanLocation
      slot #tdScanLocation
      label "Location to pick from" for #cmbScanLocation
    block #scanDesc
    block #scanBar
      block #dScan
        slot #spScan
    slot #ScanValidationContainer (hidden)
    block #liScanPackBoxAutomatic (hidden)
      slot #tdScanPackBoxAutomatic
      label "Box #" for #txtScanPackBoxInventory
    input text#txtScanFocus
    block #divScanInfo (hidden)
      heading "Found product:"
      slot #divScanProductSelection (hidden)
      block #liScanPackBox (hidden)
        label "Box #:"
        slot #tdScanPackBox
      label "SKU:"
      block #tdScanProductCode
      label "Name:"
      block #tdScanName
      label "Barcode:"
      block #tdScanBarcode
      block #liScanBatchSN (hidden)
        label "Batch/serial number:"
        slot #tdScanBatchSN
      block #liScanExpiryDate (hidden)
        label "Expiry date:"
        slot #tdScanExpiryDate
      block #liScanQuantity (hidden)
        label "Quantity:"
        slot #tdScanQuantity
    block #ScanInventoryModeContainer (hidden)
      slot #divInventoryModeBarcodes
      label "Barcodes"
      block #liScanPackBoxInventory (hidden)
        slot #tdScanPackBoxInventory
        label "Box #"
    block #ScanInventoryModeControls (hidden)
      button "Save"#liScanSaveInventory primary
      button "Close"
    block #ScanManualModeControls (hidden)
      button "Save"#liScanSave primary (hidden)
      button "Close"
    block #divScanAutoActions
      button "Close"
slot #divExpenseDestributionContainer
slot #CountrySpecificScript
```

### `/IssueToProductionList`: Inventory write-off list

Frame: `task-upload-frame`.

```text
link "Home"
heading "Inventory write-off list"
button #divNew primary
input text#divSearch placeholder "Type text to search"
button "Search" primary
button #divRefresh
button #Grid_gridName_Options
slot #IssueToProductionList_Index_Container
```

### `/JobCosting`: Job details

Frame: `iUpload`.

```text
link "Home"
link "Job costings"
button "Save"#saveAction primary
button "Back to list"#backAction
block #divMainContent
  slot #Job_Index_Status
  heading 
  block #printAction
    button "Print" ▾
    slot #divPrintContainer
  button "Quote"#saleAction
  block #expenseAction
    button "Expense" ▾
    slot #divExpenseContainer
  block #divJobCostingTask (hidden)
    button 
    button  primary
    button "Workflow"
    button 
    button "Calendar"
  button #taskHeaderCollapse
  block #divTaskHeader
    slot #JobCosting_Index_Name
    label "Job description" for #txtName
    slot #JobCosting_Index_Customer
    label "Customer" for #cmbCustomer
    slot #JobCosting_Index_Contact
    label "Contact" for #cmbContact
    slot #JobCosting_Index_Phone
    label "Phone" for #txtPhone
    slot #JobCosting_Index_AddressLine1
    label "Address line 1" for #cmbAddressLine1
    slot #JobCosting_Index_AddressLine2
    label "Address line 2" for #cmbAddressLine2
    slot #JobCosting_Index_ProjectManager
    label "Project manager" for #cmbProjectManager
    slot #JobCosting_Index_Account
    label "Expense account" for #cmbAccount
    slot #JobCosting_Index_Start
    label "Start date" for #dtStart
    slot #JobCosting_Index_Completed
    label "Completed date" for #dtCompleted
    slot #JobCosting_Index_AutoInvoice
    label "Auto invoice" for #chkAutoInvoice
    block #liNextInvoiceDate
      slot #JobCosting_Index_NextInvoiceDate
      label "Next invoice date" for #dtNextInvoiceDate
    block #liFrequency
      slot #JobCosting_Index_Frequency
      label "Frequency" for #cmbFrequency
    slot #JobCosting_Index_Status
    label "Status" for #cmbStatus
    slot #JobCosting_Index_EstimatedValue
    label "Estimated value" for #txtEstimatedValue
    slot #JobCosting_Index_BudgetedMargin
    label "Budgeted margin %" for #txtBudgetedMargin
    slot #JobCosting_Index_TaxRule
    label "Tax rule" for #cmbTaxRule
    slot #JobCosting_Index_AttributeSet
    label "Attribute set" for #cmbAttributeSet
    textarea#JobCosting_Index_Comments placeholder "Write your note here..."
    label "Comments" for #txtComments
  button "Additional attributes"
  button "Milestones"
  button "Notes"
  button "Attachments"
  button "Generate a new invoice for expenses"
  button "Link expenses to an existing invoice"
  button "Invoiced"
  block #divAdditionalAttributes
    block #Job_divAttributeSet (hidden)
      heading "Additional attributes"
      block #Job_liCustomField1
        slot #Job_CustomField1
        label "Attribute 1"
      block #Job_liCustomField2
        slot #Job_CustomField2
        label "Attribute 2"
      block #Job_liCustomField3
        slot #Job_CustomField3
        label "Attribute 3"
      block #Job_liCustomField4
        slot #Job_CustomField4
        label "Attribute 4"
      block #Job_liCustomField5
        slot #Job_CustomField5
        label "Attribute 5"
      block #Job_liCustomField6
        slot #Job_CustomField6
        label "Attribute 6"
      block #Job_liCustomField7
        slot #Job_CustomField7
        label "Attribute 7"
      block #Job_liCustomField8
        slot #Job_CustomField8
        label "Attribute 8"
      block #Job_liCustomField9
        slot #Job_CustomField9
        label "Attribute 9"
      block #Job_liCustomField10
        slot #Job_CustomField10
        label "Attribute 10"
  block #divMilestones
    heading "Milestones"
    button #divNew_Milestone primary
    slot #divMilestonesLines
    button "Add more items"#JobCosting_Milestone_AddLink primary
  block #divNotes
    heading "Notes"
    button #divNew_Note primary
    slot #tblNote
    button "Add more items"#JobCosting_Note_AddLink primary
    block #divNoNoteSelected
    block #tblNoteEdit
      slot #JobCosting_Index_NoteCategory
      label "Category" for #txtNoteCategory
      slot #JobCosting_Index_NoteDate
      label "Date" for #dtNoteDate
      textarea#JobCosting_Index_Note placeholder "Write your note here..."
      label "Note" for #txtNote
      block #tdNoteAttachmentsGrid
        block #divUploadContainer
          block #preview-template (hidden)
          slot #iUpload (hidden)
          form#frmUpload
            heading "Drop files here or click to upload."
        slot #divAttachmentsGrid
      block #tdNoteAttachmentsNotAllowed
  block #divAttachments
    heading "Attachments"
    input text#searchFieldAttachments placeholder "Type text to search"
    button "Search"#divSearchAttachments primary
    button #divRefreshAttachments
    slot #divAttachmentsLines
  block #divInvoicing
    heading "Generate new invoice"
    button "Generate"#divGenerate_Invoicing primary
    text "Generate a new sale invoice for outstanding expenses"
    slot #JobCosting_Index_InvoicingMilestone
    label "Milestone" for #cmbInvoicingMilestone
    block #liInvoicing_Rate
      slot #JobCosting_Index_Rate
      label "" for #txtRate
    text "Select what to include on this invoice"
    slot #divUnallocatedExpensesLinesInvoicing
  block #divLinking
    heading "Update existing invoice"
    button "Link"#divLink primary
    text "Link outstanding expenses to an existing sale invoice"
    slot #JobCosting_Index_LinkingMilestone
    label "Milestone" for #cmbLinkingMilestone
    text "Select a sale to link expenses to"
    slot #JobCosting_Index_LinkingSale
    label "Sale" for #cmbLinkingSale
    text "Select expenses to link with the sale"
    slot #divUnallocatedExpensesLinesLinking
  block #divInvoiced
    heading "Invoiced"
    input text#searchFieldInvoiced placeholder "Type text to search"
    button "Search"#divSearchInvoiced primary
    button #divRefreshInvoiced
    slot #divInvoicedLines
modal#dlgExpenseMiliestone small
  heading "Please select a milestone to assign the expense too."
  button "×"
  slot #dlgExpenseMiliestone_Content
modal#JobCosting_Print_Content medium
  heading "Print"
  button "×"
  slot #tdJobCosting_Print_Milestone
  label "Milestone" for #MilestonePrint
  form#frmPrint
  button "Print" primary
  button "Close"
```

### `/JobCostingList`: Job costings

Frame: `task-upload-frame`.

```text
link "Home"
block #divList
  heading "Job costings"
  button #divNew primary
  input text#divSearch placeholder "Type text to search"
  button "Search" primary
  select#divFilter
  button #divRefresh
  button #Grid_gridName_Options
  slot #JobsContainer
  heading "Draft sale invoices"
  input text#divSearchInvoices name=divSearch placeholder "Type text to search"
  button "Search" primary
  button #divRefresh
  button #GridInvoices_gridName_Options
  slot #InvoicesContainer
```

### `/ProductionCalendar`: Factory Calendar

Frame: `task-upload-frame`.

```text
link "Home"
link "Production"
link "Setup"
button "Save"#saveBtn primary
button "Back to setup"
button 
slot #currentYearSpan
button 
button "Calendar settings"#editCalendarSettings
slot #calendarContainer
button #addHolidayBtn
slot #divHolidaysGrid
button #addSpecialBtn
slot #divSpecialsGrid
modal#calendarSettingsModal medium
  heading "Calendar settings"
  button "×"
  slot #weekStartCmb
  label "Working week starts on:" for #weekStartCmb
  slot #weekEndsCmb
  label "Select weekend days:" for #weekEndsCmb
  slot #divDaysGrid
  button "Apply changes"#applyCalendarSettingsBtn primary
```

### `/ProductionOrder`: Production order

Frame: `iUpload`.

```text
link "Home"
link "Production"
link "Production orders"
button "Save"#saveBtn primary
button "Back to list"#cancelBtn
slot #FeatureModuleDetailsBlock (hidden)
slot #taskStatus
heading 
button "Void"#btnVoid
button "Mark as completed"#btnMarkCompleted primary
button "Email"#btnOrderEmailDropdown ▾
button "Print"#btnOrderPrintDropdown ▾
button "Undo"#btnUndo
block #divProductionOrderTask (hidden)
  button 
  button  primary
  button "Workflow"
  button 
  button "Calendar"
button #collapseBtn
heading "General info"
slot #cmbProduct
label "SKU" for #cmbProduct
slot #cmbProductName
label "Product name" for #cmbProductName
slot #cmbLocation
label "Shop floor" for #cmbLocation
input text#ProductionOrder_Index_Tags
label "Tags" for #ProductionOrder_Index_Tags
slot #cmbOrderSource
label "Order source" for #cmbOrderSource
slot #cmbSaleOrder
label "Sales order #" for #cmbSaleOrder
slot #cmbAccount
label "Finished goods account" for #cmbAccount
slot #cmbWIPAccount
label "Work in progress account" for #cmbWIPAccount
heading "Order details"
slot #txtQuantity
label "Quantity" for #txtQuantity
input text#MaxQuantity
label "Maximum quantity" for #MaxQuantity
button #MaxQuantityCalc primary
input text#txtTotalCycleTime
label "Total cycle time" for #txtTotalCycleTime
slot #cmbCalcType
label "Capacity calculation" for #cmbCalcType
button #recalculateDates primary
slot #cmbRequiredByDate
label "Required by date" for #cmbRequiredByDate
slot #cmbStartDate
label "Planned date" for #cmbStartDate
slot #cmbReleaseDate
label "Release date" for #cmbReleaseDate
slot #cmbCompletionDate
label "Completion date" for #cmbCompletionDate
input checkbox#chkIgnoreLeadTime
label "Ignore components cumulative lead time" for #chkIgnoreLeadTime
heading "Quantities"
input text#QuantityInProgress
label "In production" for #QuantityInProgress
input text#QuantityCompleted
label "Ready to put away" for #QuantityCompleted
input text#QuantityRemained
label "Remaining" for #QuantityRemained
input text#QuantityPutAway
label "Output" for #QuantityPutAway
textarea#Comments placeholder "Type your comment here..."
block #mainTabsContainer
  button "Split"#btnSplitOrder primary
  button "Authorize"#btnAuthoriseOrder primary
  button "Release"#btnReleaseOrder primary
  button "Production run"#btnAddRun primary
block #orderForm
  tabs#orderTabs: Order #bomContent | DeliveryTo #deliveryToContent | Transactions #transactionsContent | Related orders #relatedOrdersContent | Attachments #attachmentsContent | Logs and attributes #activityLogContent
  block #divMTOButtons
    button "Default configuration"#btnDefaultMTOConfigure primary
    button "Configure"#btnMTOConfigure primary
  block #orderContent
    tab pane#bomContent
      block #divBomVersionBlock
        block #cmbBomVersionBlock
          slot #cmbBomVersion
          label "Version" for #cmbBomVersion
      block #divBomVersionBlock2
      button "Load BOM"#btnLoadBOM primary
      button "Add operation"#btnAddOperation primary
      slot #divProductionBomData
      block #divTotalCost
        block #simpleCost
          slot #ProductionOrderTotal
        block #detailedCost
          table: Product | Output quantity | Cost per unit | Total cost
    tab pane#transactionsContent
      button "Refresh"#btnRefreshTrans
      slot #divTDetails
    tab pane#relatedOrdersContent
      button #divNewRelatedOrder primary
      button "Refresh"#btnRefreshRelatedOrders
      slot #divRelatedOrdersDetails
      button "Add more items"#PurchaseOrder_AddRelatedOrder primary
    tab pane#attachmentsContent
      block #instructionBlock
        link "Click here"
      block #divAttachmentUpload
        block #divUploadContainer
          block #preview-template (hidden)
          slot #iUpload (hidden)
          form#frmUpload
            heading "Drop files here or click to upload."
        block #divUploadImpossible
      button "Attach from Google Drive" primary
      slot #divAttachmentList
    tab pane#deliveryToContent
      slot #divDeliveryToDetails
    tab pane#activityLogContent
      block #ProductionOrder_divAttributeSet (hidden)
        heading "Additional attributes"
        block #ProductionOrder_liCustomField1
          slot #ProductionOrder_CustomField1
          label "Attribute 1"
        block #ProductionOrder_liCustomField2
          slot #ProductionOrder_CustomField2
          label "Attribute 2"
        block #ProductionOrder_liCustomField3
          slot #ProductionOrder_CustomField3
          label "Attribute 3"
        block #ProductionOrder_liCustomField4
          slot #ProductionOrder_CustomField4
          label "Attribute 4"
        block #ProductionOrder_liCustomField5
          slot #ProductionOrder_CustomField5
          label "Attribute 5"
        block #ProductionOrder_liCustomField6
          slot #ProductionOrder_CustomField6
          label "Attribute 6"
        block #ProductionOrder_liCustomField7
          slot #ProductionOrder_CustomField7
          label "Attribute 7"
        block #ProductionOrder_liCustomField8
          slot #ProductionOrder_CustomField8
          label "Attribute 8"
        block #ProductionOrder_liCustomField9
          slot #ProductionOrder_CustomField9
          label "Attribute 9"
        block #ProductionOrder_liCustomField10
          slot #ProductionOrder_CustomField10
          label "Attribute 10"
      block #divActivityLogs (hidden)
        slot #ActivityLogs_Container
block #productionOrder_tooltipTemplate_Product (hidden)
  table: Shop floor | Available | On order
form#productionBomFileUploader
  input file name=file
form#productionRunOperationFileUploader
  input file name=file
block #runForm (hidden)
  tabs#runTabs: Order #runOrderContent | Output #putAwayContent | Manual journals #manualJournalContent | Financials #runFinancialContent | Reservation #runRunReservationContent | Batch/serial traceability #runTraceabilityContent | Attributes #runAttributeSetContent
  button "Void"#btnRunVoid
  button "Print pick list"#btnRunPrintDropdown ▾
  button "Undo"#btnRunUndo
  block #divProductionRunTask (hidden)
    button 
    button  primary
    button "Workflow"
    button 
    button "Calendar"
  block #runContent
    tab pane#runOrderContent
      slot #txtRunQuantity
      label "Quantity to produce" for #txtRunQuantity
      slot #cmbRunWipAccount
      label "Work in progress account" for #cmbRunWipAccount
      slot #cmb_BackflushDefinedFor
      label "Apply backflush method to:" for #cmbBackflushDefinedFor
      slot #cmbRunDueDate
      label "Due date" for #cmbRunDueDate
      slot #cmbRunScheduledStartDate
      label "Scheduled start date" for #cmbRunScheduledStartDate
      slot #cmbRunStartDate
      label "Start date" for #cmbRunStartDate
      slot #cmbRunCompletionDate
      label "Completion date" for #cmbRunCompletionDate
      slot #runNavigation
      slot #sequenceName
      slot #runOperationStatus
      slot #runOperationMode
      button "Start" primary
      button "Suspend"
      button "Resume" primary
      button "Complete" primary
      button "Auto consume"#pickOperation
      button "Scan"#scanOperation
      text "Related orders Print pick list Undo"
      slot #cmbOperationStartDate
      label "Operation start date" for #cmbOperationStartDate
      slot #cmbOperationCompletionDate
      label "Operation completion date" for #cmbOperationCompletionDate
      block #runOperationSuspendReason
      slot #runMasterGrid
      slot #runNotesGrid
      slot #runComponentGrid
      slot #runResourceGrid
      slot #runCostGrid
      block #ProductionRunOperation_divAttributeSet (hidden)
        heading "Additional attributes"
        block #ProductionRunOperation_liCustomField1
          slot #ProductionRunOperation_CustomField1
          label "Attribute 1"
        block #ProductionRunOperation_liCustomField2
          slot #ProductionRunOperation_CustomField2
          label "Attribute 2"
        block #ProductionRunOperation_liCustomField3
          slot #ProductionRunOperation_CustomField3
          label "Attribute 3"
        block #ProductionRunOperation_liCustomField4
          slot #ProductionRunOperation_CustomField4
          label "Attribute 4"
        block #ProductionRunOperation_liCustomField5
          slot #ProductionRunOperation_CustomField5
          label "Attribute 5"
        block #ProductionRunOperation_liCustomField6
          slot #ProductionRunOperation_CustomField6
          label "Attribute 6"
        block #ProductionRunOperation_liCustomField7
          slot #ProductionRunOperation_CustomField7
          label "Attribute 7"
        block #ProductionRunOperation_liCustomField8
          slot #ProductionRunOperation_CustomField8
          label "Attribute 8"
        block #ProductionRunOperation_liCustomField9
          slot #ProductionRunOperation_CustomField9
          label "Attribute 9"
        block #ProductionRunOperation_liCustomField10
          slot #ProductionRunOperation_CustomField10
          label "Attribute 10"
    tab pane#putAwayContent
      slot #cmbRunReceivedDate
      label "Effective date" for #cmbRunReceivedDate
      button "Print"#btnRunPutawayPrintDropdown ▾
      button "Complete"#btnPutAwayCompleted primary
      block # putAwayActionBtns
        button "Add line"#btnPutAwayAddLine
        button "Copy from production run"#btnPutAwayCopy
        button "Scan"#btnPutAwayScan
      slot #divPutAwayGrid
      block #coManReceivingBlock
        heading "Co-manufacturing output"
        slot #divCoManReceivingGrid
    tab pane#manualJournalContent
      block #runMjActionBtns
        button "Manual journal"#btnAddMj primary
      slot #divManualJournalsLines
    tab pane#runFinancialContent
      block #divFinancial
        tabs: Edit accounting dimensions #financials-default (hidden) | Transactions #financials-transactions | Final accounting dimensions values #financials-real (hidden)
        tab pane#financials-default
          text "Accounting dimension settings can overwrite reference data. All accounting dimensions can be edited. Accounting dimensio"
          table#tableDefaultDimensions: Event type
        tab pane#financials-transactions
          button "Refresh"#btnRefreshRunTrans
          slot #divRunTDetails
        tab pane#financials-real
          input text#txtRealDimensionsSearch placeholder "Type text to search"
          button "Search"#btnRealDimensionsSearch primary
          button "Refresh"#btnRealDimensionsRefresh
          slot #divRealDimensions
    tab pane#runRunReservationContent
      button "Refresh"#btnRefreshRunReservation
      slot #divRunReservationDetails
    tab pane#runTraceabilityContent
      input text#inpTraceabilitySearch placeholder "Type text to search"
      button "Search"#btnTraceabilitySearch primary
      button "Print"#btnRunTraceabilityPrintDropdown ▾
      slot #traceabilityFP
      button "Scan"#btnTraceComponents
      button "Clear"#btnTraceablityClear
      slot #traceabilityGridComponents1
    tab pane#runAttributeSetContent
      block #ProductionRun_divAttributeSet (hidden)
        heading "Additional attributes"
        block #ProductionRun_liCustomField1
          slot #ProductionRun_CustomField1
          label "Attribute 1"
        block #ProductionRun_liCustomField2
          slot #ProductionRun_CustomField2
          label "Attribute 2"
        block #ProductionRun_liCustomField3
          slot #ProductionRun_CustomField3
          label "Attribute 3"
        block #ProductionRun_liCustomField4
          slot #ProductionRun_CustomField4
          label "Attribute 4"
        block #ProductionRun_liCustomField5
          slot #ProductionRun_CustomField5
          label "Attribute 5"
        block #ProductionRun_liCustomField6
          slot #ProductionRun_CustomField6
          label "Attribute 6"
        block #ProductionRun_liCustomField7
          slot #ProductionRun_CustomField7
          label "Attribute 7"
        block #ProductionRun_liCustomField8
          slot #ProductionRun_CustomField8
          label "Attribute 8"
        block #ProductionRun_liCustomField9
          slot #ProductionRun_CustomField9
          label "Attribute 9"
        block #ProductionRun_liCustomField10
          slot #ProductionRun_CustomField10
          label "Attribute 10"
modal#divUploadYieldLines medium
  heading "Upload output"
  button "×"
  heading "1. Download this output"
  heading "2. Add new and modify existing products in the file."
  heading "3. Upload"
  block #UploadYieldLinesExceptionsContainer (hidden)
    slot #UploadYieldLinesExceptionsGrid
  form#frmUploadYield
    heading "Drop files here or click to upload."
  slot #ifrmUploadRunYieldLines (hidden)
  slot #ifrmDownloadRunYieldLines (hidden)
  form#frmDownloadRunYieldLines
  button "Close"
modal#divCOGSAccDims small
  heading "Accounting dimensions"
  button "×"
  button "Save"#btnSaveCOGSAccDims primary
  button "Close"
modal#createRunModal medium
  heading "Create production run"#createRunTitle
  button "×"
  slot #divCreateRunsGrid
  button "Run"#createRunsBtn primary
  button "Cancel"#closeRunsDlg
modal#productionRunPrintOperationsModal medium
  heading "Select operations to print"#createRunTitle
  button "×"
  slot #divProductionRunPrintOperationsGrid
  button "Print"#productionRunPrintSelectedOperations primary
  button "Cancel"#productionRunPrintSelectedOperationsCloseRunsDlg
modal#divScan small
  heading "Scanning"
  button "×"
  block #PutAwayScanFP (hidden)
    slot #divPutAwayScanFP
    label "Finished product" for #cmbPutAwayScanFP
    slot #divPutAwayScanFPExpiryDate
    label "Expiry date" for #cmbPutAwayScanExpiryDate
  tabs: Automatic #AutomaticMode_tab | Manual #ManualMode_tab | Inventory #InventoryMode_tab
  slot #ScanValidationContainer (hidden)
  label "Shop floor to pick from" for #cmbScanLocation
  slot #tdScanLocation
  block #scanDesc
  block #scanBar
    block #dScan
      slot #spScan
    button "Start scanning"#startScan
  input text#txtScanFocus
  block #ScanInventoryModeContainer (hidden)
    slot #divInventoryModeBarcodes
    block #liScanPackBoxInventory (hidden)
      label "Box #" for #txtScanPackBoxInventory
      slot #tdScanPackBoxInventory
  block #divScanInfo (hidden)
    slot #divScanProductSelection (hidden)
    block #liScanPackBox (hidden)
      label "Box #:"
      slot #tdScanPackBox
    label "SKU:"
    block #tdScanProductCode
    label "Name:"
    block #tdScanName
    label "Barcode:"
    block #tdScanBarcode
    block #liScanBatchSN (hidden)
      label "Batch/serial number:"
      slot #tdScanBatchSN
    block #liScanExpiryDate (hidden)
      label "Expiry date:"
      slot #tdScanExpiryDate
    block #liScanQuantity (hidden)
      label "Quantity:"
      slot #tdScanQuantity
  block #ScanInventoryModeControls (hidden)
    button "Save"#liScanSaveInventory primary
    button "Close"
  block #ScanManualModeControls (hidden)
    button "Close"
    button "Save"#liScanSave primary (hidden)
  block #divScanAutoActions
    button "Cancel"
modal#productionOrderSplitModal medium
  heading "Split production order"#createRunTitle
  button "×"
  slot #divProductionOrderSplitGrid
  button "Split"#executeSplitActionBtn primary
  button "Cancel"#closeProductionOrderSplitDlgBtn
  block #productionOrderSplitResult (hidden)
    slot #productionOrderSplitResult_List
    button "Close"#closeProductionOrderSplitDlgBtn2
modal#productionRunSuspendModal small
  heading "Suspend operation"
  button "×"
  slot #cmbOperationSuspendReason
  label "Reason" for #cmbOperationSuspendReason
  button "Suspend" primary
  button "Cancel"
modal#runYieldModal large
  heading "Output"#addYieldModal
  button "×"
  button "Auto-generate batch/serial no."#yieldAutoGenerateBtn primary
  button "Import"#yieldImportBatchBtn primary (hidden)
  button "Export"#yieldExportBatchBtn primary (hidden)
  button "Complete"#yieldCompleteBtn primary
  button "Complete without output"#yieldCompleteBtnNoOutput primary
  slot #divYieldPopupGrid
modal#productConfigurationModal small
  heading "Product configuration"#addYieldModal
  button "×"
  slot #productConfigurationModal_txtConfiguration
  button "Close"#productConfigurationModal_btnClose
modal#selectedOptionsDialog small
  heading "Selected options"
  button "×"
  slot #configurationList
  button "Load BOM"#btnloadDefaultBOM primary
  button "Close"
modal#secEmail medium
  heading #emailDialogCaption
  button "×"
  button "Send"#btnSendEmail2 primary
  button "Close"#emailBackAction2
  heading "Email subject"
  slot #EmailSendTemplate_AdditionalInfo (hidden)
  input text#DEAREmailTo
  label "To"
  button #DEAREmailTo_btn
  block #EmailSendTemplate_CC
    input text#DEAREmailCC
    label "CC"
    button #DEAREmailCC_btn
  input text#DEAREmailSubject placeholder "Type email subject..."
  label "Subject"
  block #EmailSendTemplate_NetworkingBlock (hidden)
    slot #EmailSendTemplate_NetworkingCheck
    label "Send via Cin7 Core network" for #chkEmail_sendViaNetwork
  heading "Select files to attach"
  block #EmailSendTemplate_AttachedFiles
    heading #headerForOrderAttachments
    slot #attachedFiles
  block #EmailSendTemplate_AttachedFiles_Product
    heading "Product"
    slot #attachedFiles_Product
  block #EmailSendTemplate_AttachedFiles_Supplier
    heading "Supplier"
    slot #attachedFiles_Supplier
  block #EmailSendTemplate_AttachedFiles_Customer
    heading "Customer"
    slot #attachedFiles_Customer
  heading "Email template"
  slot #tdEmail_Body
  block #emailReCaptcha (hidden)
  button "Send"#btnSendEmail primary
  button "Close"#emailBackAction
modal#secRecipients medium
  heading "Select a recipient"
  button "×"
  slot #gridRecipients
  button "OK" primary
  button "Close"
slot #btnSendEmail2
modal#TraceabilityYieldModal medium
  heading "Add batch/serial numbers"
  button "×"
  slot #traceabilityGridComponents2
  button "Done" primary
modal#customizationDialog large
  heading "Customization for product:"
  button "×"
  block #customizationContainer
    button "➜"
    button "Set to default"
    button "➜"
    button "Set to default"
    input text#searchFiled placeholder "Type to search..."
    button "Search"
    button 
    input number#quantity
    button 
    button "Reset to default"
    slot #totalAmount
    button "Confirm order" (hidden)
    button 
    button "➜"
    button "Clear selected"
    label "Custom element text" for #artText
    input text#artText placeholder "Type custom element text"
    text "For example your initials. Maximum 64 characters including punctuation."
    label "Choose file" for #artFile + file #artFile
    text "Choose the image that you want to apply. Size should be lesser than 16MB."
    button "Confirm changes"
  block #zoomPopup (hidden)
  button "Save"#btnSaveCustomization primary
  button "Close"
form#frmPrintDownload
```

### `/ProductionOrders`: Production orders list

Frame: `task-upload-frame`.

```text
link "Home"
link "Production"
slot #FeatureModuleDetailsBlock (hidden)
heading "Production orders"
block #bulkActionsNoteSuccess (hidden)
block #bulkActionsNoteWarning (hidden)
block #bulkActionsNoteError (hidden)
button #divNew primary
input text#search placeholder "Type text to search"
button "Search" primary
button "Consolidate orders"#newConsolidateOrders primary
block #bulkActions (hidden)
  button "Plan & schedule" ▾
  link "Plan orders from required by date backward"
  link "Release orders"
slot #cmbLocation
label "Shop floor" for #cmbLocation
slot #SchedulerRangePageOverlay
button "Dates"#btnDatesFilter ▾
link "All dates"
link "7 days ahead from required by date"
link "14 days ahead from required by date"
link "Custom dates"
block #DateFrom
  label "From"
block #DateTo
  label "To"
button "Apply"#btnApplyDateRange primary
button "Filter"#btnFilter ▾
link "All"
link "All but voided"
link "Draft"
link "Planned"
link "Released"
link "Completed"
link "Work in progress"
button #btnRefresh
block #GridOptions_listContainer
  button #Grid_gridName_Options3
block #divBulkActions
  slot #lSelectedCounter
  button "Undo"#btnUndo (hidden)
  button "Add tag"#btnAddTag primary (hidden)
  button "Mark as completed"#btnMarkAsCompleted primary (hidden)
  button "Bulk print"#btnBulkPrint (hidden)
  button "Void"#btnVoid (hidden)
slot #listContainer
form#frmPrintList
modal#productionOrderList_modal_BatchSerial medium
  heading "Product batches or serial numbers"
  button "×"
  table: Product | Batch/ serial no. | Expiry date | Run #
  button "Close"
modal#productionOrderList_modal_SourceTasks small
  heading "Sales orders"
  button "×"
  slot #divSalesOrdersList
  button "Close"
modal#ProductionOrders_ProductionOrder_Comment small
  heading "Comment for production order"#commentCaption
  button "×"
  textarea#ProductionOrder_Comment
  label "Comments" for #ProductionOrder_Comment
  button "Close"
modal#ProductionOrders_ProductionOrder_Tag small
  heading "Tag for production order"#tagCaption
  button "×"
  textarea#ProductionOrder_Tag
  label "Tags" for #ProductionOrder_Tag
  button "Close"
modal#planProductionOrderDialog small
  heading "Plan"
  button "×"
  slot #cmbPlanOrderCalcType
  label "Capacity calculation" for #cmbPlanOrderCalcType
  slot #cmbPlanOrderDate
  label "Required by date" for #cmbPlanOrderDate
  button "Plan"#planProductionOrder primary
  button "Cancel"#closePlanProductionOrderDialog
modal#productionOrderList_modal_AddTag small
  heading "Add tag"
  button "×"
  input text#ProductionOrder_Index_Tags
  button "Save"#saveProductionOrderTags primary
  button "Cancel"
modal#ConsolidateOrdersModal medium
  heading "Consolidate orders"
  button "×"
  slot #ConsolidateOrders_List
  slot #ConsolidateOrders_RequiredByDate
  label "Required by date" for #ConsolidateOrders_RequiredByDate
  button "Consolidate"#consolidateOrders_ConsolidateAction primary
  button "Cancel"
modal#releaseProductionOrderDialog small
  heading "Release"
  button "×"
  slot #cmbReleaseOrderDate
  label "Release date" for #cmbReleaseOrderDate
  button "Release"#releaseProductionOrder primary
  button "Cancel"#closeReleaseProductionOrderDialog
```

### `/ProductionResource`: Production resource

Frame: `iUpload`.

```text
link "Home"
link "Production"
link "Setup"
text "New resource"#breadcrumbTitle
button "Save"#saveBtn primary
button "New"#newBtn
button "Back to setup"
heading "New resource"#resourceNameTitle
input text#Code required
label "Resource code" for #Code
input text#Name required
label "Resource name" for #Name
slot #cmbType
label "Type" for #cmbType
slot #cmbOperational
label "Status" for #cmbOperational
input checkbox#chkInfiniteResource
label "Infinite resource" for #chkInfiniteResource
input checkbox#chkUseAllAvailable
label "Use all available resources" for #chkUseAllAvailable
label "Tags"
input text#Tags name=Name
tabs#resourceTabs: Capacity #capacityContent | Costs #costsContent | Attachments #attachmentsContent | Remarks #remarksContent | Used in #referencesContent | Accounting dimensions #dimensionsContent (hidden)
block #resourceContent
  tab pane#capacityContent
    input checkbox#chkWorkOnWeekends
    label "Working on weekends" for #chkWorkOnWeekends
    input checkbox#chkWorkOnHolidays
    label "Working on holidays" for #chkWorkOnHolidays
    slot #capacityGridContainer
  tab pane#costsContent
    button #addCost primary
    label "Unit of time"
    label "Hours" for #CycleTimeH
    input text#CycleTimeH placeholder "Hours" required
    label "Minutes" for #CycleTimeM
    input text#CycleTimeM placeholder "Minutes" required
    label "Seconds" for #CycleTimeS
    input text#CycleTimeS placeholder "Seconds" required
    slot #costsGridContainer
    text "Cost of for is"
  tab pane#attachmentsContent
    block #divAttachmentUpload
      block #divUploadContainer
        block #preview-template
        slot #iUpload (hidden)
      form#frmUpload
        heading "Drop files here."
    button "Attach from Google Drive" primary
    slot #divAttachmentList
  tab pane#remarksContent
    textarea#Remark placeholder "Type here..."
    button "Add"#addRemark primary
    button "Cancel"#cancelRemark
    slot #remarksGrid
  tab pane#referencesContent
    slot #divReferences
  tab pane#dimensionsContent
    slot #divAccountingDimensionsList
modal#customModal medium
  heading "Custom working hours"#customTitle
  button "×"
  slot #divDaysGrid
  button "Save"#applyCustomHours primary
  button "Cancel"#closeCustomHours
  button "Reset to default"#deleteCustomHours
modal#unitsModal medium
  heading "Map individual resources"#unitsTitle
  button "×"
  button  primary
  slot #unitsGridContainer
  button "Add more items" primary
  button "Save"#saveUnits primary
  button "Cancel"#cancelUnits
```

### `/ProductionScheduler`: Scheduler

Frame: `task-upload-frame`.

```text
button "Release orders"#releaseOrders primary (hidden)
button "Consolidate orders"#newConsolidateOrders primary (hidden)
button "Month"#btnCalendar ▾
menu: Week #dayGridWeek | Month #dayGridMonth | Days #dayGridDay
slot #cmbShopFloor
label "Shop floor"
slot #SchedulerRangePageOverlay
button "Dates"#btnDatesSetup ▾
link "All dates"
link "Due today"
link "This week"
link "7 days ahead"
link "14 days ahead"
link "Custom dates"
block #cmbPlanFrom
  label "From"
block #cmbPlanTo
  label "To"
button "Apply"#btnApplyDateRange primary
select#btnBufferSetup multiple: Urgent | Medium | Safe
label "Buffer"
slot #btnWorkCenterSetup
label "Work center"
slot #btnResourceSetup
label "Resource"
select#cmbProductionStatus: All | Planned | Released
label "Production status"
button "Edit mode"#startEdit
button "Save changes"#saveAction primary
button "Cancel"#cancelEdit
button 
button #fullscreenMode
button #btnViewSetup
block #viewSetupDropdownList
  link "Collapse all groups"
  link "Expand all groups"
  input checkbox#chkHorizontalLines
  label "Horizontal lines" for #chkHorizontalLines
  input checkbox#chkVerticalLines
  label "Vertical lines" for #chkVerticalLines
  input checkbox#chkDependencies
  label "Dependencies" for #chkDependencies
  input checkbox#chkCompleted
  label "Show completed" for #chkCompleted
  input checkbox#chkShowWeekends
  label "Show weekends" for #chkShowWeekends
  block #resourceViewCheck
    input checkbox#showResourcesToggle
    label "Show resources" for #showResourcesToggle
  input checkbox#chkShowNestedOrders
  label "Group nested orders" for #chkShowNestedOrders
  input radio#radioHour name=scale
  label "Hour" for #radioHour
  input radio#radioDay name=scale
  label "Day" for #radioDay
  input radio#radioWeek name=scale
  label "Week" for #radioWeek
  input checkbox#chkToggleProductName
  label "Product name" for #chkToggleProductName
  input checkbox#chkToggleSku
  label "SKU" for #chkToggleSku
  input checkbox#chkToggleQty
  label "Quantity" for #chkToggleQty
  input checkbox#chkToggleReleaseDate
  label "Release date" for #chkToggleReleaseDate
  input checkbox#chkToggleRequiredByDate
  label "Required by date" for #chkToggleRequiredByDate
  input checkbox#chkToggleWc
  label "Work centers" for #chkToggleWc
  input checkbox#chkToggleLogs
  label "Problem logs" for #chkToggleLogs
  input checkbox#chkToggleWeekends
  label "Weekends" for #chkToggleWeekends
  input checkbox#chkToggleHolidays
  label "Holidays" for #chkToggleHolidays
block #schedulerTabs
  link "Calendar"#calendarTab
  link "Planning"#planningTab
  link "Production"#poTab
  link "Resources"#resourcesTab
  link "Sales/Purchases"#salesTab
input text#search placeholder "Type text to search..."
button  primary
slot #ganttContainer
block #schedulerCalendarContainer
  slot #divSchedulerCalendar
  slot #schedulerDayRange (hidden)
modal#schedulerTask_StartDateModal small
  block #currentStartDate
  slot #newStartDate
  label "New start date" for #newStartDate
  button "OK"#setStartDateButton primary
modal#releaseProductionOrderDialog small
  heading "Release"
  button "×"
  slot #cmbReleaseOrderDate
  label "Release date" for #cmbReleaseOrderDate
  button "Release"#releaseProductionOrder primary
  button "Cancel"#closeReleaseProductionOrderDialog
modal#ConsolidateOrdersModal medium
  heading 
  button "×"
  text "The following production orders for consolidation have been found:"
  slot #ConsolidateOrders_List
  text "Set the required by date to consolidate these orders"
  slot #ConsolidateOrders_RequiredByDate
  button "Consolidate" primary
  button "Cancel"
```

### `/ProductionSetup`: Setup

Frame: `task-upload-frame`.

```text
link "Home"
link "Production"
heading "Factory Calendar"
text "Set up factory schedule to plan your production."
button "Set up calendar" primary
heading "Account mapping"
button "Go to account mapping" primary
tabs#setupTabs: Resources #resources | Work centers #wc | Suspend reasons #suspendReasons
block #setupContent
  tab pane#resources
    text "Configure resource capacity to plan production."
    button #addResBtn primary
    input text#searchRes name=divSearch placeholder "Type text to search"
    button "Search" primary
    input checkbox#chkOnlyOperational
    label "Only operational" for #chkOnlyOperational
    slot #resGridContainer
  tab pane#wc
    text "If you plan to pick up components from a shop floor location, the "Consumption bin" field should be left empty. If you n"
    button #addWcBtn primary
    input text#searchWc placeholder "Type text to search"
    button "Search" primary
    button "Save"#saveBtn primary
    button "Cancel"#cancelBtn
    button "Tutorial"
    slot #wcGridContainer
  tab pane#suspendReasons
    button #addWcBtn primary
    input text#searchSusp placeholder "Type text to search"
    button "Search" primary
    button "Save"#saveBtn primary
    button "Cancel"#cancelBtn
    slot #SuspendReasonGridContainer
```

## Components by bundle

What the page code builds and mounts into the layout's slots.

### `Assembly2019`

8 grids · 16 standalone fields · 0 windows · 18 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `divRealDimensions` · store `window.AccountingDimensionsRealTempStore` · placeholder `emptyMsgText`
- **grid** · renders into `divTDetails` · store `TransactionsStore` · placeholder `No transactions created.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Effective date | `EffectiveDate` |  | flex 1 | renderer() |  |
    | Debit | `Debit` |  | flex 1 | Common_COA_TreeMode_RestoreDisplayName |  |
    | Credit | `Credit` |  | flex 1 | Common_COA_TreeMode_RestoreDisplayName |  |
    | Amount | `Amount` |  | 130 | renderer() |  |

- **grid** · renders into `divOrderLines` · placeholder `Click the 'Load BOM' button to view the bill of materials`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `ProductCode` |  | flex 2 | renderer() | total count |
    | Expense account | `ExpenseAccount` |  | flex 1 | renderer() |  |
    | Quantity | `Quantity` |  | flex 1 |  |  |
    | Unit | `Unit` |  | flex 1 | RenderHTMLText |  |
    | Wastage % | `WastagePercent` |  | flex 1 | renderer() |  |
    | Wastage quantity | `WastageQuantity` |  | flex 1 | renderer() |  |
    | Total quantity | `TotalQuantity` |  | flex 1 | renderer() | total sum |
    | Available | `Available` |  | flex 1 | renderer() |  |
    | Total cost | `TotalCost` |  | flex 1 | renderer() | total sum |

- **grid** · renders into `divPickLines` · placeholder `Click the 'Auto pick' button to fill in the data`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `ProductCode` |  | flex 2 | renderer() | total count |
    | Bin | `BinName` |  | flex 1 | renderer() |  |
    | Batch # | `BatchSN` |  | flex 1 | renderer() |  |
    | Expiry date | `ExpiryDate` |  | flex 1 | renderer() |  |
    | Total quantity | `TotalQuantity` |  | flex 1 | renderer() | total sum |
    | Unit | `Unit` |  | flex 1 | RenderHTMLText |  |
    | Available | `Available` |  | flex 1 | renderer() |  |
    | Cost | `TotalQuantity` |  | flex 1 | renderer() | total sum |

- **grid** · renders into `divManualJournalsLines` · placeholder `You do not have any manual journals.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Debit | `Debit` |  | flex 1 | renderer() |  |
    | Credit | `Credit` |  | flex 1 | renderer() |  |
    | Reference | `Reference` |  | flex 1 | RenderHTMLText |  |
    | Date | `Date` | date column | flex 1 | edit: date field |  |
    | Amount | `Amount` |  | flex 1 | renderer() |  |

- **grid** · renders into `divRelatedOrdersDetails` · store `RelatedOrdersStore` · placeholder `No related orders created.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Order | `TaskNumber` |  | flex 1 | renderer() |  |
    | Type | `TaskTypeName` |  | flex 1 | RenderHTMLText |  |
    | Order date | `OrderDate` |  | flex 1 | renderer() |  |
    | Status | `Status` |  | flex 1 | renderer() |  |
    | Total | `TotalAmount` |  | 130 | renderer() |  |

- **grid** · renders into `divScanProductSelection` · store `storeScanProduct`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `ProductCode` |  | flex 2 | renderer() |  |
    | Batch/serial # | `BatchSN` |  | flex 1 | renderer() |  |
    | Expiry date | `ExpiryDate` |  | flex 1 | renderer() |  |

- **grid** · renders into `divAttachmentList` · store `FileStore` · placeholder `You do not have any uploaded files.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | File name | `FileName` |  | flex 1 | renderer() |  |
    | Attached by | `UserName` |  | flex 1 | renderer() |  |
    | Uploaded date | `UploadedDate` |  | flex 1 | renderer() |  |


#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| combo |  | `tdLocation` | `vTenantLocationStore` | shows `Description` · value `LocationID` · placeholder `Choose...` |
| combo |  | `tdBin` | `BinsStore` | shows `Description` · value `LocationID` · placeholder `Choose...` |
| combo |  | `tdJobMilestone` | `vJobMilestonesStore` | shows `Name` · value `ID` · placeholder `type to search...` |
| date field |  | `tdWIPDate` | `` | placeholder `Choose...` · format `UserDateFormat` |
| date field |  | `tdCompletionDate` | `` | placeholder `Choose...` · format `UserDateFormat` |
| text field |  | `tdBatchSN` | `` |  |
| date field |  | `tdExpiryDate` | `` | placeholder `Choose...` · format `UserDateFormat` |
| text field |  | `tdScanPackBox` | `` | placeholder `Choose...` |
| text field |  | `tdScanPackBoxInventory` | `` | placeholder `Choose...` |
| combo |  | `inputId` | `AutocompleteAddressField.prototype.AddressInfoSto…` | shows `description` · value `place_id` · placeholder `Look up an address` |
| date field |  | `WorkflowModal_dtWorkflowDate` | `` | format `UserDateFormat` |
| combo |  | `"SalePicker_".concat(…)` | `window.saleVars.originalStore` | shows `window.saleVars.displayFieldName` · value `window.saleVars.idFieldName` · placeholder `window.saleVars.emptyText… |
| text field |  | `renderTo` | `` |  |
| checkbox |  | `renderTo` | `` |  |
| numeric field |  | `renderTo` | `` |  |
| date field |  | `renderTo` | `` | placeholder `Choose...` · format `UserDateFormat` |

#### Menus, buttons and other parts

- **column** “Entity” · field `EntityType` · id `colRealDimensionsEntity`
- **column** “Account” · field `AccountCode` · id `colRealDimensionsAccount`
- **column** “Amount” · field `Amount` · id `colRealDimensionsAmount`
- **column** “Reference number” · field `ReferenceNumber` · id `colRealDimensionsReferenceNumber`
- **column** “Effective date” · field `EffectiveDate` · id `colRealDimensionsDate`
- **column** “Product” · field `ProductCode` · id `colRealDimensionsProduct`
- **column** “Supplier \| Customer” · field `"".concat(…)` · id `"colRealDimensions".concat(…)`
- **column** “{attr}” · field `attr.replace(…)` · id `"col".concat(…)`
- **button** “{Name}” · id `"Print".concat(…)` · on click `handler()`
- **component** · renders into `tdProductCode` · store `ProductsStore` · shows `ProductCode` · value `ProductID` · placeholder `Choose...`
- **component** · renders into `tdProductName` · store `ProductsStore` · shows `Name` · value `ProductID` · placeholder `Choose...`
- **component** · renders into `tdWIPAccount` · store `wipAccountStore` · shows `DisplayName` · value `Code` · placeholder `Choose...`
- **component** · renders into `tdAccount` · store `FinishedGoodsAccountStore` · shows `DisplayName` · value `Code` · placeholder `Choose...`
- **component** · renders into `tdQuantity` · required
- **component** · renders into `tdScanQuantity` · required
- **text area** · renders into `divInventoryModeBarcodes` · placeholder `Enter your barcodes here...`
- **component** · id `cmpId` · renders into `renderTo` · store `localStore` · shows `name` · value `value` · placeholder `Choose...` · pick-only
- **column** “{attrSet.name}” · field `"CustomField".concat(…)`

### `CapacityPlanner`

2 grids · 5 standalone fields · 0 windows · 0 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `listContainer` · store `mainStore` · placeholder `PageResources.NoResources`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | {PageResources.Resource} | `ResourceID` |  | flex 2 | renderer() |  |
    | {PageResources.Location} | `LocationID` |  | flex 2 | renderer() | total count |
    | {PageResources.Total} | `TotalCapacity` |  | flex 1 | renderer() | total sum |
    | {PageResources.Available} | `AvailableCapacity` |  | flex 1 | renderer() | total sum |
    | {PageResources.Allocated} | `AllocatedCapacity` |  | flex 1 | renderer() | total sum |
    | {PageResources.AllocatedPlanned} | `AllocatedPlanned` |  | flex 2 | renderer() | total sum |
    | {PageResources.AllocatedReleased} | `AllocatedReleased` |  | flex 2 | renderer() | total sum |
    | {PageResources.Consumed} | `ConsumedCapacity` |  | flex 1 | renderer() | total sum |

- **grid** · renders into `detailsContainer` · store `detailsStore`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    |  | `Status` |  | 34 | renderer() |  |
    | {PageResources.OrderNo} | `ProductionOrderNumber` |  | flex 1 | renderer() |  |
    | {PageResources.SaleOrderNumber} | `SaleOrderNumber` |  | flex 1 | renderer() |  |
    | {PageResources.CustomerName} | `CustomerName` |  | flex 1 | renderer() |  |
    | {PageResources.ProductName} | `ProductCode` |  | flex 1 | renderer() |  |
    | {PageResources.SalesRep} | `SalesRepresentative` |  | flex 1 | renderer() |  |
    | {PageResources.Resource} | `ResourceCode` |  | flex 1 | renderer() |  |
    | {PageResources.Location} | `LocationName` |  | flex 1 |  |  |
    | {PageResources.ReleaseDate} | `ReleaseDate` |  | flex 1 | renderer() |  |
    | {PageResources.PlannedDate} | `StartDate` | date column | flex 1 | renderer() · edit: date field |  |
    | {PageResources.RequiredByDate} | `RequiredByDate` | date column | flex 1 | renderer() · edit: date field |  |
    | {PageResources.Allocated} | `Capacity` |  | flex 1 | renderer() |  |
    |  | `FakeID` |  | 150 | renderer() |  |


#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| date field |  | `cmbPlanFrom` | `` | format `UserDateFormat` |
| date field |  | `cmbPlanTo` | `` | format `UserDateFormat` |
| combo |  | `cmbLocation` | `locationStore` | shows `Description` · value `LocationID` · placeholder `Choose...` · multi-select |
| combo |  | `cmbResource` | `resourcesStore` | shows `Name` · value `ResourceID` · placeholder `Choose...` · multi-select |
| checkbox |  | `chkOverAllocated` | `` |  |

### `Disassembly2019`

6 grids · 3 standalone fields · 0 windows · 13 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `divAttachmentList` · store `FileStore` · placeholder `You do not have any uploaded files.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | File name | `FileName` |  | flex 1 | renderer() |  |
    | Attached by | `UserName` |  | flex 1 | renderer() |  |
    | Uploaded date | `UploadedDate` |  | flex 1 | renderer() |  |

- **grid** · renders into `divRealDimensions` · store `window.AccountingDimensionsRealTempStore` · placeholder `emptyMsgText`
- **grid** · renders into `divTDetails` · store `TransactionsStore` · placeholder `No transactions created.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Effective date | `EffectiveDate` |  | flex 1 | renderer() |  |
    | Debit | `Debit` |  | flex 1 | Common_COA_TreeMode_RestoreDisplayName |  |
    | Credit | `Credit` |  | flex 1 | Common_COA_TreeMode_RestoreDisplayName |  |
    | Amount | `Amount` |  | 130 | renderer() |  |

- **grid** · renders into `divPickLines` · placeholder `Click the 'Auto pick' button to view the available cards to disassemb…`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Bin | `Bin` |  | flex 1 | renderer() |  |
    | Date received | `Date` | date column | flex 1 |  | total count |
    | Batch/serial # | `BatchSN` |  | flex 1 | renderer() |  |
    | Expiry date | `ExpiryDate` | date column | flex 1 | renderer() |  |
    | On hand | `Available` |  | flex 1 |  |  |
    | Unit cost | `UnitCost` |  | flex 1 |  |  |
    | Quantity to disassemble | `Quantity` |  | flex 1 | renderer() | total sum |
    | Total cost | `Cost` |  | flex 1 |  | total sum |

- **grid** · renders into `ComponentsContainer` · placeholder `Add at least one component as a result of disassembly.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `ProductCode` |  | flex 2 | renderer() | total count |
    | Bin | `BinID` |  | flex 1 | renderer() |  |
    | Unit of measure | `Unit` |  | flex 1 | renderer() |  |
    | Batch no. | `BatchSN` |  | flex 1 | renderer() |  |
    | Expiry date | `ExpiryDate` | date column | flex 1 | renderer() · edit: date field |  |
    | Inventory account | `Account` |  | flex 1 | renderer() |  |
    | Quantity | `Quantity` |  | flex 1 |  | total sum |
    | Total cost | `Cost` |  | flex 1 | renderer() | total sum |

- **grid** · renders into `ServicesContainer` · placeholder `No labor and overheads added to this disassembly.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Labor & overheads | `Name` |  | flex 2 | renderer() | total count |
    | Expense account | `Account` |  | flex 1 | renderer() |  |
    | Comments | `Comments` |  | flex 2 |  |  |
    | Amount | `Amount` |  | flex 1 | renderer() | total sum |


#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| date field |  | `WorkflowModal_dtWorkflowDate` | `` | format `UserDateFormat` |
| combo |  | `tdLocation` | `vTenantLocationStore` | shows `Description` · value `LocationID` · placeholder `Choose...` |
| date field |  | `tdCompletionDate` | `` | placeholder `Choose...` · format `UserDateFormat` |

#### Menus, buttons and other parts

- **column** “Entity” · field `EntityType` · id `colRealDimensionsEntity`
- **column** “Account” · field `AccountCode` · id `colRealDimensionsAccount`
- **column** “Amount” · field `Amount` · id `colRealDimensionsAmount`
- **column** “Reference number” · field `ReferenceNumber` · id `colRealDimensionsReferenceNumber`
- **column** “Effective date” · field `EffectiveDate` · id `colRealDimensionsDate`
- **column** “Product” · field `ProductCode` · id `colRealDimensionsProduct`
- **column** “Supplier \| Customer” · field `"".concat(…)` · id `"colRealDimensions".concat(…)`
- **column** “{attr}” · field `attr.replace(…)` · id `"col".concat(…)`
- **button** “{Name}” · id `"Print".concat(…)` · on click `handler()`
- **component** · renders into `tdProductCode` · store `DisassemblyProductSelectStore` · shows `ProductCode` · value `ProductID` · placeholder `Choose...`
- **component** · renders into `tdProductName` · store `DisassemblyProductSelectStore` · shows `Name` · value `ProductID` · placeholder `Choose...`
- **component** · renders into `tdWIPAccount` · store `InventoryAccountsStore` · shows `DisplayName` · value `Code` · placeholder `Choose...`
- **component** · renders into `tdQuantity` · required

### `DisassemblyList2019`

1 grids · 0 standalone fields · 0 windows · 0 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `DisassemblyList_Index_Container` · store `mainStore` · placeholder `You do not have any disassemblies at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    |  | `` |  | flex 1 | renderer() | hidden |
    | Disassembly # | `DisassemblyNumber` |  | flex 1 | renderer() |  |
    | Product | `ProductCode` |  | flex 1 | renderer() |  |
    | Quantity | `Quantity` |  | flex 1 |  |  |
    | Location | `Location` |  | flex 1 | renderer() |  |
    | Date | `Date` |  | flex 1 | renderer() |  |
    | Status | `Status` |  | flex 1 | RenderStatus |  |
    | Comment | `Notes` |  | flex 1 |  |  |


### `FinishedGoodsList2019`

1 grids · 0 standalone fields · 0 windows · 0 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `FinishedGoodsList_Index_Container` · store `mainStore` · placeholder `You do not have any finished goods at the moment.`

### `IssueToProduction2019`

7 grids · 8 standalone fields · 0 windows · 11 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `divRealDimensions` · store `window.AccountingDimensionsRealTempStore` · placeholder `emptyMsgText`
- **grid** · renders into `divTDetails` · store `TransactionsStore` · placeholder `No transactions created.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Effective date | `EffectiveDate` |  | flex 1 | renderer() |  |
    | Debit | `Debit` |  | flex 1 | Common_COA_TreeMode_RestoreDisplayName |  |
    | Credit | `Credit` |  | flex 1 | Common_COA_TreeMode_RestoreDisplayName |  |
    | Amount | `Amount` |  | 130 | renderer() |  |

- **grid** · renders into `GridContainer` · placeholder `Nothing added to this inventory write-off task.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `ProductCode` |  | flex 2 | renderer() | total count |
    | Bin | `LocationName` |  | flex 1 | renderer() |  |
    | Batch/serial no. | `BatchSN` |  | flex 1 | renderer() |  |
    | Expiry date | `ExpiryDate` |  | flex 1 | renderer() |  |
    | Expense account | `ExpenseAccount` |  | flex 1 | renderer() |  |
    | Quantity | `Quantity` |  | flex 1 |  | total sum |
    | Cost | `CostValue` |  | flex 1 | renderer() |  |
    | Available | `Available` |  | flex 1 | renderer() |  |
    | Total cost | `TotalQuantity` |  | flex 1 | renderer() | total count |

- **grid** · renders into `UploadExceptionsGrid` · store `UploadErrorsStore` · placeholder `Please upload a file to check for issues.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Line # | `Line` |  | 50 |  |  |
    | Product SKU | `SKU` |  | 150 | renderer() |  |
    | Bin | `Bin` |  | 120 | renderer() |  |
    | Batch S/N | `BatchSN` |  | 120 | renderer() |  |
    | Expiry date | `ExpiryDate` |  | 100 | renderer() |  |
    | Expense account | `ExpenseAccount` |  | 100 | renderer() |  |
    | Quantity | `Quantity` |  | 80 | renderer() |  |

- **grid** · renders into `divScanProductSelection` · store `storeScanProduct`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `ProductCode` |  | flex 2 | renderer() |  |
    | Batch/serial # | `BatchSN` |  | flex 1 | renderer() |  |
    | Expiry date | `ExpiryDate` |  | flex 1 | renderer() |  |

- **grid** · renders into `divAttachmentList` · store `AttachmentsStore` · placeholder `You do not have any files attached.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Name | `FileName` |  | flex 2 | renderer() |  |
    | Date | `UploadedDate` |  | flex 1 | renderer() |  |
    | Attached by | `UserName` |  | flex 2 | RenderHTMLText |  |

- **grid** · renders into `_classPrivateFieldGet(…)` · store `_classPrivateFieldGet(…)`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    |  | `Selected` |  | 58 | renderer() |  |
    | Original account | `AccountCode` |  | flex 1 | renderer() |  |
    | Amount | `Amount` |  | flex 1 | renderer() |  |
    | Distributed amount | `DistributedAmount` |  | flex 1 | renderer() |  |
    | Left to distribute | `LeftToDistribute` |  | flex 1 | renderer() |  |
    | Note | `Invoices` |  | flex 2 | renderer() |  |


#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| date field |  | `WorkflowModal_dtWorkflowDate` | `` | format `UserDateFormat` |
| combo |  | `tdLocation` | `vTenantLocationStore` | shows `Description` · value `LocationID` · placeholder `Choose...` |
| combo |  | `tdJobMilestone` | `vJobMilestonesStore` | shows `Name` · value `ID` · placeholder `type to search...` |
| date field |  | `tdCompletionDate` | `` | placeholder `Choose...` · format `UserDateFormat` |
| text field |  | `tdScanPackBox` | `` | placeholder `Choose...` |
| text field |  | `tdScanPackBoxInventory` | `` | placeholder `Choose...` |
| combo |  | `"js-task-name_".concat(…)` | `store` | shows `DistributedAmountGrid_classPrivateField…` · value `DistributedAmountGrid_classPrivateField…` · placeholder `type… |
| numeric field |  | `"divTargetAccountDistribute_".concat(id).concat(…)` | `` |  |

#### Menus, buttons and other parts

- **column** “Entity” · field `EntityType` · id `colRealDimensionsEntity`
- **column** “Account” · field `AccountCode` · id `colRealDimensionsAccount`
- **column** “Amount” · field `Amount` · id `colRealDimensionsAmount`
- **column** “Reference number” · field `ReferenceNumber` · id `colRealDimensionsReferenceNumber`
- **column** “Effective date” · field `EffectiveDate` · id `colRealDimensionsDate`
- **column** “Product” · field `ProductCode` · id `colRealDimensionsProduct`
- **column** “Supplier \| Customer” · field `"".concat(…)` · id `"colRealDimensions".concat(…)`
- **column** “{attr}” · field `attr.replace(…)` · id `"col".concat(…)`
- **component** · renders into `tdAccount` · store `vChartOfAccountsStore` · shows `DisplayName` · value `Code` · placeholder `Choose...`
- **component** · renders into `tdScanQuantity` · required
- **text area** · renders into `divInventoryModeBarcodes` · placeholder `Enter your barcodes here...`

### `IssueToProductionList2019`

1 grids · 0 standalone fields · 0 windows · 0 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · id `Grid` · renders into `IssueToProductionList_Index_Container` · store `mainStore`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    |  | `` |  | flex 1 | renderer() | hidden |
    | Write-off # | `AssemblyNumber` |  | flex 1 | renderer() |  |
    | Location | `Location` |  | flex 1 | renderer() |  |
    | Date | `Date` |  | flex 1 | renderer() |  |
    | Status | `Status` |  | flex 1 | RenderStatus |  |
    | Notes | `Notes` |  | flex 2 | RenderHTMLText |  |


### `JobCosting2019`

7 grids · 30 standalone fields · 0 windows · 2 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `divMilestonesLines` · placeholder `No milestones added to this job.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Description | `Name` |  | flex 2 | RenderHTMLText |  |
    | Comments | `Description` |  | flex 2 | renderer() |  |
    | Date estimated | `DateEstimated` | date column | flex 1 | renderer() · edit: date field |  |
    | Date actual | `DateActual` | date column | flex 1 | renderer() · edit: date field |  |
    | Status | `Status` |  | flex 1 | renderer() |  |

- **grid** · renders into `divAttachmentsLines` · store `vJobCostingAllAttachementsStore` · placeholder `No attachments found.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | File | `FileName` |  | flex 2 | renderer() |  |
    | Date | `Date` |  | flex 1 | renderer() |  |
    | Milestone | `MileStoneName` |  | flex 1 | RenderHTMLText |  |
    | Attached by | `UserName` |  | flex 1 | RenderHTMLText |  |

- **grid** · renders into `divInvoicedLines` · store `vJobCostingSalesStore` · placeholder `No sale invoices found.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Milestone | `Milestone` |  | flex 1 | renderer() |  |
    | Sale order # | `SaleOrderNumber` |  | flex 1 | renderer() |  |
    | Invoice # | `InvoiceNumber` |  | flex 1 | renderer() |  |
    | Invoice date | `InvoiceDate` |  | flex 1 | renderer() |  |
    | Expense amount | `ExpenseAmount` |  | flex 1 | renderer() |  |
    | Budgeted amount | `BudgetedAmount` |  | flex 1 | renderer() |  |
    | Invoiced amount | `SaleAmount` |  | flex 1 | renderer() |  |

- **grid** · renders into `tblNote` · placeholder `You do not have any notes.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Date | `Date` |  | flex 1 | renderer() |  |
    | Category | `Category` |  | flex 1 | renderer() |  |
    | Note | `Note` |  | flex 2 | renderer() |  |
    | User | `Username` |  | flex 1 | renderer() |  |

- **grid** · renders into `divAttachmentsGrid` · store `vJobCostingAttachementStore` · placeholder `You do not have any attached files.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | File | `FileName` |  | flex 1 | renderer() |  |

- **grid** · renders into `divUnallocatedExpensesLinesInvoicing` · store `vJobCostingUnallocatedExpensesStore` · placeholder `You do not have any unallocated expenses.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Expense task | `ExpenseTaskID` |  | flex 1 | renderer() | total count |
    | Milestone | `MilestoneName` |  | flex 1 | renderer() |  |
    | Date | `Date` |  | flex 1 | renderer() |  |
    | Expense amount | `ExpenseAmount` |  | flex 1 | renderer() |  |
    | Margin | `ExpenseAmount` |  | flex 1 | renderer() |  |
    | Invoicing amount | `InvoicingAmount` |  | flex 1 | renderer() | total sum |

- **grid** · renders into `divUnallocatedExpensesLinesLinking` · store `vJobCostingUnallocatedExpensesStore` · placeholder `You do not have any unallocated expenses.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Expense task | `ExpenseTaskID` |  | flex 1 | renderer() | total count |
    | Milestone | `MilestoneName` |  | flex 1 | renderer() |  |
    | Date | `Date` |  | flex 1 | renderer() |  |
    | Expense amount | `ExpenseAmount` |  | flex 1 | renderer() | total sum |


#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| date field |  | `WorkflowModal_dtWorkflowDate` | `` | format `UserDateFormat` |
| text field |  | `JobCosting_Index_Name` | `` |  |
| combo |  | `JobCosting_Index_Customer` | `vCustomerStore` | shows `Name` · value `Name` · placeholder `type to search...` |
| combo |  | `JobCosting_Index_Contact` | `vCustomerContactStore` | shows `Name` · value `Name` · placeholder `Choose or type new...` |
| text field |  | `JobCosting_Index_Phone` | `` | placeholder `write...` |
| combo |  | `JobCosting_Index_AddressLine1` | `vCustomerAddressStore` | shows `Line1` · value `Line1` · placeholder `Choose or type new...` |
| text field |  | `JobCosting_Index_AddressLine2` | `` | placeholder `Choose...` |
| combo |  | `JobCosting_Index_ProjectManager` | `vTenantContactsStore` | shows `Name` · value `Name` · placeholder `Choose or type new...` |
| combo |  | `JobCosting_Index_Account` | `vChartOfAccountsStore` | shows `DisplayName` · value `Code` |
| date field |  | `JobCosting_Index_Start` | `` | placeholder `Choose...` · format `UserDateFormat` |
| date field |  | `JobCosting_Index_Completed` | `` | placeholder `Choose...` · format `UserDateFormat` |
| checkbox |  | `JobCosting_Index_AutoInvoice` | `` |  |
| date field |  | `JobCosting_Index_NextInvoiceDate` | `` | placeholder `Choose...` · format `UserDateFormat` |
| combo |  | `JobCosting_Index_Frequency` | `FrequencyStore` | shows `Name` · value `Value` · pick-only |
| combo |  | `JobCosting_Index_Status` | `JobCostingStatusStore` | shows `Name` · value `Value` · pick-only |
| numeric field |  | `JobCosting_Index_EstimatedValue` | `` |  |
| numeric field |  | `JobCosting_Index_BudgetedMargin` | `` |  |
| combo |  | `JobCosting_Index_TaxRule` | `vTenantTaxationRuleStore` | shows `Description` · value `RuleID` · placeholder `Choose...` |
| combo |  | `JobCosting_Index_AttributeSet` | `AttributeSetStore` | shows `Name` · value `SetID` · pick-only |
| text field |  | `JobCosting_Index_NoteCategory` | `` |  |
| date field |  | `JobCosting_Index_NoteDate` | `` | placeholder `Choose...` · format `UserDateFormat` |
| combo |  | `JobCosting_Index_InvoicingMilestone` | `InvoicingMilestoneStore` | shows `Name` · value `ID` · placeholder `Select the milestone you would like to …` |
| numeric field |  | `JobCosting_Index_Rate` | `` | placeholder `Specify the exchange rate between your …` |
| combo |  | `JobCosting_Index_LinkingMilestone` | `InvoicingMilestoneStore` | shows `Name` · value `ID` · placeholder `Select the milestone you would like to …` |
| combo |  | `JobCosting_Index_LinkingSale` | `vJobCostingLinkingSaleStore` | shows `SaleOrderNumber` · value `TaskID` · placeholder `Choose a sale invoice...` |
| combo |  | `tdJobCosting_Print_Milestone` | `vJobCostingMilestonePrintStore` | shows `Name` · value `ID` · pick-only |
| text field |  | `renderTo` | `` |  |
| checkbox |  | `renderTo` | `` |  |
| numeric field |  | `renderTo` | `` |  |
| date field |  | `renderTo` | `` | placeholder `Choose...` · format `UserDateFormat` |

#### Menus, buttons and other parts

- **component** · id `cmpId` · renders into `renderTo` · store `localStore` · shows `name` · value `value` · placeholder `Choose...` · pick-only
- **column** “{attrSet.name}” · field `"CustomField".concat(…)`

### `JobCostingList2019`

2 grids · 0 standalone fields · 0 windows · 0 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `JobsContainer` · store `mainStore` · placeholder `You do not have any jobs at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    |  | `` |  | flex 1 | renderer() | hidden |
    | Job # | `JobNumber` |  | flex 1 | RenderHTMLText |  |
    | Name | `Name` |  | flex 1 | RenderHTMLText |  |
    | Start date | `StartDate` |  | flex 1 | renderer() |  |
    | Customer | `CustomerName` |  | flex 1 | RenderHTMLText |  |
    | Account | `AccountCode` |  | flex 1 | Common_COA_TreeMode_RestoreDisplayName |  |
    | Status | `Status` |  | flex 1 | renderer() |  |

- **grid** · renders into `InvoicesContainer` · store `invoicesStore` · placeholder `You do not have any draft sale invoices associated with jobs.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    |  | `` |  | flex 1 | renderer() | hidden |
    | Job # | `JobNumber` |  | flex 1 | renderer() |  |
    | Job name | `JobName` |  | flex 2 | renderer() |  |
    | Milestone | `Milestone` |  | flex 2 | RenderHTMLText |  |
    | SO # | `SaleOrderNumber` |  | flex 1 | renderer() |  |
    | Invoice # | `InvoiceNumber` |  | flex 1 | renderer() |  |
    | Date | `SaleOrderDate` |  | flex 1 | renderer() |  |
    | Amount | `Amount` |  | flex 1 | renderer() |  |


### `ProductionCalendar`

3 grids · 3 standalone fields · 0 windows · 0 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `divHolidaysGrid` · placeholder `You do not have any holidays yet.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Date | `Date` | date column | flex 1 | edit: date field |  |
    | Description | `Comment` |  | flex 1 | renderer() |  |

- **grid** · renders into `divSpecialsGrid` · placeholder `You do not have any custom working days yet.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Date | `Date` | date column | 100 | edit: date field |  |
    | Start | `StartTime` |  | 130 | renderer() |  |
    | End | `EndTime` |  | 130 | renderer() |  |
    | Break start | `BreakStartTime` |  | flex 1 | renderer() |  |
    | Break end | `BreakEndTime` | date column | flex 1 | renderer() |  |

- **grid** · renders into `divDaysGrid` · placeholder `You do not have any working days yet.` · layout column
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Day | `DayOfWeek` |  | flex 1 | renderer() | pick-only |
    | Start | `StartTime` |  | flex 1 | renderer() |  |
    | End | `EndTime` |  | flex 1 | renderer() |  |
    | Break start | `BreakStartTime` |  | flex 1 | renderer() |  |
    | Break end | `BreakEndTime` | date column | flex 1 | renderer() |  |
    |  | `` |  | 57 | renderer() |  |


#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| date field |  | `cmbReleaseOrderDate` | `` | format `UserDateFormat` |
| combo |  | `weekStartCmb` | `WeekDaysStore` | shows `name` · value `value` |
| multi-select combo |  | `weekEndsCmb` | `WeekDaysStore` | shows `name` · value `value` |

### `ProductionOrder`

23 grids · 29 standalone fields · 0 windows · 19 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `divRealDimensions` · store `window.AccountingDimensionsRealTempStore` · placeholder `emptyMsgText`
- **grid** · renders into `divProductionOrderSplitGrid` · store `ProductionOrderSplitStore`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Production order | `Number` |  | flex 1 | renderer() |  |
    | Quantity to produce | `Quantity` |  | flex 1 | renderer() |  |
    | Remaining quantity | `RemainingQuantity` |  | flex 1 | renderer() |  |

- **grid** · renders into `divScanProductSelection` · store `storeScanProduct`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `ProductCode` |  | flex 2 | renderer() |  |
    | Bin | `BinName` |  | flex 1 | renderer() |  |
    | Batch/serial # | `BatchSN` |  | flex 1 | renderer() |  |
    | Expiry date | `ExpiryDate` |  | flex 1 | renderer() |  |

- **grid** · renders into `divTDetails` · store `TransactionsStore` · placeholder `No transactions created.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Effective date | `EffectiveDate` |  | flex 1 | renderer() |  |
    | Debit | `Debit` |  | flex 1 | Common_COA_TreeMode_RestoreDisplayName |  |
    | Credit | `Credit` |  | flex 1 | Common_COA_TreeMode_RestoreDisplayName |  |
    | Amount | `Amount` |  | 130 | renderer() |  |

- **grid** · renders into `divRelatedOrdersDetails` · store `RelatedOrdersStore` · placeholder `No related orders created.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Order | `Number` |  | flex 1 | renderer() |  |
    | Type | `TaskTypeName` |  | flex 1 | RenderHTMLText |  |
    | Parent production order | `ParentProductionOrderNumber` |  | flex 1 | renderer() |  |
    | Order date | `OrderDate` |  | flex 1 | renderer() |  |
    | Status | `Status` |  | flex 1 | renderer() |  |
    | Total | `TotalAmount` |  | 130 | renderer() |  |

- **grid** · renders into `divDeliveryToDetails` · store `vProductionOrderDeliveryToStore` · placeholder `No finished products.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `ProductName` |  | flex 1 | renderer() |  |
    | Unit | `ProductUnit` |  | flex 1 | RenderHTMLText |  |
    | Sale | `SaleTaskID` |  | flex 1 | renderer() |  |
    | Delivery to | `LocationID` |  | flex 1 | renderer() |  |

- **grid** · renders into `divAttachmentList` · store `AttachmentsStore` · placeholder `You do not have any files attached.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Name | `FileName` |  | flex 2 | renderer() |  |
    | Date | `Date` |  | flex 1 | renderer() |  |
    | Attached by | `UserName` |  | flex 2 |  |  |

- **grid** · renders into `divCreateRunsGrid` · store `ProductionRunCreateStore`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Production run # | `Number` |  | flex 1 | renderer() |  |
    | Quantity to produce | `Quantity` |  | flex 1 | renderer() |  |
    | Remaining quantity | `RemainingQuantity` |  | flex 1 | renderer() |  |

- **grid** · renders into `divProductionRunPrintOperationsGrid` · store `ProductionRunOperationsPrintSelectStore`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Name | `Name` |  | flex 1 | renderer() | pick-only |

- **grid** · renders into `runComponentGrid` · store `RunProductItemsStore` · placeholder `No components selected.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Type | `ItemType` |  | flex 1 | renderer() |  |
    | Component | `ProductSku` |  | flex 2 | renderer() |  |
    | Location | `LocationName` |  | flex 1 | renderer() |  |
    | Batch no. | `BatchSN` |  | flex 1 | renderer() |  |
    | Backflush | `IsBackflush` | check column | 100 | renderer() | hidden |
    | Required/expected quantity | `PlannedQuantity` |  | 100 | renderer() |  |
    | Actual quantity | `ActualQuantity` |  | 100 | renderer() |  |
    | Wastage quantity | `WastageQuantity` |  | 100 | renderer() |  |
    | Total quantity | `Quantity` |  | 100 | renderer() |  |
    | Unit | `Unit` |  | 80 | RenderHTMLText |  |
    | Cost per unit | `UnitCost` |  | 80 | renderer() |  |
    | Cost | `TotalCost` |  | 80 | renderer() |  |
    | Reserved | `IsReserved` | check column | 80 | renderer() |  |

- **grid** · renders into `runResourceGrid` · placeholder `No resources selected.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Resource | `ResourceCode` |  | flex 1 | renderer() |  |
    | Quantity | `Quantity` |  | flex 1 |  |  |
    | Availability | `Available` |  | flex 1 | renderer() |  |
    | Cost | `TotalCost` |  | flex 1 | renderer() |  |

- **grid** · renders into `runCostGrid` · placeholder `No costs selected.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Labor and overheads | `ProductName` |  | flex 1 | RenderHTMLText |  |
    | Resource | `ResourceID` |  | flex 1 | renderer() |  |
    | Expense account | `ExpenseAccount` |  | flex 1 | renderer() |  |
    | Cost | `Cost` |  | flex 1 | renderer() |  |

- **grid** · renders into `runMasterGrid`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Sequence | `Order` |  | 100 | renderer() |  |
    | Type | `OperationType` |  | 120 | renderer() |  |
    | Operation | `Name` |  | flex 3 | renderer() |  |
    | Backflush | `IsBackflush` | check column | 100 | renderer() | hidden |
    | Planned time | `PlannedTimeString` |  | 100 |  |  |
    | Actual time | `ActualTimeString` |  | 100 |  |  |
    | Work center | `WorkCenterCode` |  | flex 1 | renderer() |  |

- **grid** · renders into `runNotesGrid` · placeholder `You do not have notes or attachments in this operation.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Notes & attachments | `Type` |  | 150 | renderer() |  |
    |  | `Value` |  | flex 2 | renderer() |  |

- **grid** · renders into `divManualJournalsLines` · placeholder `You do not have any manual journals.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Debit | `Debit` |  | flex 1 | renderer() |  |
    | Credit | `Credit` |  | flex 1 | renderer() |  |
    | Reference | `Reference` |  | flex 1 | RenderHTMLText |  |
    | Operation | `OperationID` |  | flex 1 | renderer() |  |
    | Date | `Date` | date column | flex 1 | edit: date field |  |
    | Amount | `Amount` |  | flex 1 | renderer() |  |

- **grid** · renders into `divRunTDetails` · store `RunTransactionsStore` · placeholder `No transactions created.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Effective date | `EffectiveDate` |  | flex 1 | renderer() |  |
    | Debit | `Debit` |  | flex 1 | Common_COA_TreeMode_RestoreDisplayName |  |
    | Credit | `Credit` |  | flex 1 | Common_COA_TreeMode_RestoreDisplayName |  |
    | Amount | `Amount` |  | 130 | renderer() |  |

- **grid** · renders into `divRunReservationDetails` · store `ReservedComponentsStore` · placeholder `No reserved components.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Component | `ProductName` |  | flex 1 | RenderHTMLText |  |
    | Operation | `OperationName` |  | flex 1 | RenderHTMLText |  |
    | Location | `LocationName` |  | flex 1 | RenderHTMLText |  |
    | Batch S/N | `BatchSN` |  | flex 1 | RenderHTMLText |  |
    | Expiry date | `ExpiryDate` |  | flex 1 | renderer() |  |
    | Available | `Available` |  | 130 | renderer() |  |
    | On order | `OnOrder` |  | 130 | renderer() |  |
    | Reserved | `Reserved` |  | 130 | renderer() |  |

- **grid** · renders into `divPutAwayGrid` · store `RunOutputStore` · placeholder `You do not have any output lines in the production run.`
- **grid** · renders into `divCoManReceivingGrid` · store `RunCoManReceivingStore` · placeholder `You do not have any stock receiving lines.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Source | `TaskID` |  | 100 | renderer() |  |
    | Product | `ProductCode` |  | flex 2 | renderer() |  |
    | Batch / serial # | `BatchSN` |  | flex 1 | renderer() |  |
    | Expiry date | `ExpiryDate` | date column | flex 1 |  |  |
    | Quantity | `Quantity` |  | flex 1 | renderer() |  |
    | Unit | `Unit` |  | flex 1 | renderer() |  |
    | Received date | `ReceivedDate` | date column | 100 | renderer() |  |
    | Location | `LocationName` |  | flex 1 | renderer() |  |
    | Cost per unit | `Cost` |  | flex 1 | renderer() |  |
    | Cost | `Cost` |  | flex 1 | renderer() |  |

- **grid** · renders into `traceabilityFP` · store `TraceabilityFPStore` · placeholder `No finished products have been added yet.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `ProductID` |  | flex 2 | renderer() |  |
    | Batch/serial # | `BatchSN` |  | flex 2 | renderer() |  |
    | Expiry date | `ExpiryDate` |  | flex 1 | renderer() |  |

- **grid** · renders into `"traceabilityGridComponents".concat(…)` · store `TraceabilityComponentsByProductStore` · placeholder `No components have been reserved or consumed yet.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Component | `UsedProductID` |  | flex 1 | renderer() |  |
    | Batch/serial # | `UsedFullBatchSN` |  | flex 1 | renderer() |  |
    | Expiry date | `UsedProductExpiryDate` |  | flex 1 | renderer() |  |

- **grid** · renders into `divYieldPopupGrid` · store `ProductionRunYieldStore` · placeholder `You do not have any component lines.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Type | `ItemType` |  | 120 | renderer() |  |
    | Product | `ProductSku` |  | flex 2 | renderer() |  |
    | Batch / serial # | `BatchSN` |  | flex 1 | renderer() |  |
    | Expiry date | `ExpiryDate` | date column | flex 1 | renderer() · edit: date field |  |
    | Actually produced | `Quantity` |  | flex 1 | renderer() |  |
    | Wastage | `WastageQuantity` |  | flex 1 | renderer() |  |
    | Total produced | `Quantity` |  | flex 1 | renderer() |  |
    | Unit | `Unit` |  | flex 1 | renderer() |  |
    | Received date | `ReceivedDate` | date column | flex 1 | renderer() · edit: date field |  |
    | Location | `LocationName` |  | flex 1 | renderer() |  |
    |  | `` |  | flex 1 | renderer() |  |
    |  | `` |  | flex 1 | renderer() |  |

- **grid** · renders into `UploadYieldLinesExceptionsGrid` · store `YieldLinesUploadErrorsStore` · placeholder `Please upload a file to check for issues.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Line # | `Line` |  | 60 |  |  |
    | Product SKU | `SKU` |  | 150 | renderer() |  |
    | Product name | `Name` |  | 250 | renderer() |  |
    | Batch/serial # | `BatchSerialNumber` |  | 120 | renderer() |  |
    | Expiry date | `ExpiryDate_YYYYMMDD` |  | 100 | renderer() |  |
    | Quantity | `Quantity` |  | 100 | renderer() |  |
    | Location | `Location` |  | 100 | renderer() |  |
    | Date received | `DateReceived_YYYYMMDD` |  | 100 | renderer() |  |


#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| text field |  | `renderTo` | `` |  |
| checkbox |  | `renderTo` | `` |  |
| numeric field |  | `renderTo` | `` |  |
| date field |  | `renderTo` | `` | placeholder `Choose...` · format `UserDateFormat` |
| date field |  | `WorkflowModal_dtWorkflowDate` | `` | format `UserDateFormat` |
| date field |  | `cmbReleaseOrderDate` | `` | format `UserDateFormat` |
| combo |  | `cmbLocation` | `vTenantLocationsStore` | shows `Description` · value `LocationID` |
| combo |  | `cmbAccount` | `FinishedGoodsAccountStore` | shows `DisplayName` · value `Code` |
| combo |  | `cmbWIPAccount` | `WipAccountStore` | shows `DisplayName` · value `Code` |
| date field |  | `cmbStartDate` | `` | format `UserDateFormat` |
| date field |  | `cmbCompletionDate` | `` | format `UserDateFormat` |
| date field |  | `cmbRequiredByDate` | `` | format `UserDateFormat` |
| combo |  | `cmbCalcType` | `CapacityCalculationsStore` | shows `name` · value `value` |
| date field |  | `cmbReleaseDate` | `` | format `UserDateFormat` |
| text field |  | `tdScanPackBox` | `` | placeholder `Choose...` |
| text field |  | `tdScanPackBoxInventory` | `` | placeholder `Choose...` |
| combo |  | `cmbBomVersion` | `vProductionBomVersions` | shows `DisplayName` · value `Version` |
| combo |  | `cmbRunWipAccount` | `WipAccountStore` | shows `DisplayName` · value `Code` |
| date field |  | `cmbRunStartDate` | `` | format `UserDateFormat` |
| date field |  | `cmbRunScheduledStartDate` | `` | format `UserDateFormat` |
| date field |  | `cmbRunDueDate` | `` | format `UserDateFormat` |
| date field |  | `cmbRunCompletionDate` | `` | format `UserDateFormat` |
| combo |  | `cmb_BackflushDefinedFor` | `BackflushDefinedForStore` | shows `name` · value `value` · pick-only |
| date field |  | `cmbOperationStartDate` | `` | format `UserDateFormat` |
| date field |  | `cmbOperationCompletionDate` | `` | format `UserDateFormat` |
| combo |  | `cmbOperationSuspendReason` | `vSuspendReasonsStoreFiltered` | shows `Reason` · value `Reason` |
| date field |  | `cmbRunReceivedDate` | `` | format `UserDateFormat` |
| date field |  | `divPutAwayScanFPExpiryDate` | `` | format `UserDateFormat` |
| combo |  | `divPutAwayScanFP` | `YieldProductsScanStore` | shows `ProductName` · value `ProductID` |

#### Menus, buttons and other parts

- **component** · id `cmpId` · renders into `renderTo` · store `localStore` · shows `name` · value `value` · placeholder `Choose...` · pick-only
- **column** “{attrSet.name}” · field `"CustomField".concat(…)`
- **column** “Entity” · field `EntityType` · id `colRealDimensionsEntity`
- **column** “Account” · field `AccountCode` · id `colRealDimensionsAccount`
- **column** “Amount” · field `Amount` · id `colRealDimensionsAmount`
- **column** “Reference number” · field `ReferenceNumber` · id `colRealDimensionsReferenceNumber`
- **column** “Effective date” · field `EffectiveDate` · id `colRealDimensionsDate`
- **column** “Product” · field `ProductCode` · id `colRealDimensionsProduct`
- **column** “Supplier \| Customer” · field `"".concat(…)` · id `"colRealDimensions".concat(…)`
- **column** “{attr}” · field `attr.replace(…)` · id `"col".concat(…)`
- **component** · renders into `cmbProduct` · store `ProductsStore` · shows `ProductCode` · value `ProductID`
- **component** · renders into `cmbProductName` · store `ProductsStore` · shows `Name` · value `ProductID`
- **component** · renders into `txtQuantity` · required
- **component** · renders into `tdScanQuantity` · required
- **text area** · renders into `divInventoryModeBarcodes` · placeholder `Enter your barcodes here...`
- **component**
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    |  | `CustomerName` |  |  |  | hidden |
    | Resource | `ProductionResource` |  | flex 1 |  |  |

- **column**
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Type | `Type` |  | flex 1 | renderer() |  |
    | Component | `Value` |  | flex 2 | renderer() |  |
    |  | `CostCalculationType` |  | 150 | renderer() |  |
    | Quantity | `TotalQuantity` |  | 80 | renderer() |  |
    | Unit | `Unit` |  | 80 | renderer() |  |
    | Wastage % | `WastagePercent` |  | 90 | renderer() |  |
    | Wastage qty | `TotalWastageQty` |  | 100 | renderer() |  |
    | Availability | `Available` |  | 100 | renderer() |  |
    | Sales price | `SalePriceTier` |  | 120 | renderer() |  |
    | Cost per unit | `Cost` |  | 110 | renderer() |  |
    | Total cost | `TotalCost` |  | 90 | renderer() |  |

- **column**
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Sequence | `Order` |  | flex 1 | renderer() |  |
    | Previous step | `OperationRelationIDsFake` |  | flex 1 | renderer() |  |
    | Type | `OperationType` |  | flex 1 | renderer() |  |
    | Operation | `Name` |  | flex 1 | renderer() |  |
    | Cycle time | `CycleTimeString` |  | flex 1 |  |  |
    | Work center | `WorkCenterID` |  | flex 1 | renderer() |  |
    | Units per cycle time | `UnitsPerCycle` |  | flex 1 | renderer() |  |
    | Number of cycles | `ProductionOrderID` |  | flex 1 | renderer() |  |
    | Total cost | `TotalCost` |  | flex 1 | renderer() |  |

- **component** · renders into `txtRunQuantity` · required

### `ProductionOrdersList`

2 grids · 7 standalone fields · 0 windows · 0 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `listContainer` · store `mainStore` · placeholder `You do not have any production orders at the moment.`
- **grid** · renders into `divSalesOrdersList`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Sales order | `SourceTaskID` |  | flex 1 | renderer() |  |


#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| date field |  | `cmbReleaseOrderDate` | `` | format `UserDateFormat` |
| combo |  | `cmbLocation` | `locationStore` | shows `Description` · value `LocationID` · placeholder `Choose...` · pick-only · multi-select |
| date field |  | `DateFrom` | `` | placeholder `Choose...` · format `UserDateFormat` |
| date field |  | `DateTo` | `` | placeholder `Choose...` · format `UserDateFormat` |
| combo |  | `cmbPlanOrderCalcType` | `CapacityCalculationsStore` | shows `name` · value `value` |
| date field |  | `cmbPlanOrderDate` | `` | format `UserDateFormat` |
| date field |  | `ConsolidateOrders_RequiredByDate` | `` | format `UserDateFormat` |

### `ProductionResource`

7 grids · 3 standalone fields · 0 windows · 0 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `divAttachmentList` · store `AttachmentsStore` · placeholder `You do not have any files attached.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Name | `FileName` |  | 200 | renderer() |  |
    | Date | `Date` |  | flex 1 | renderer() |  |
    | Attached by | `UserName` |  | flex 2 |  |  |
    |  | `` | action column | 23 |  |  |

- **grid** · renders into `capacityGridContainer` · placeholder `You do not have any shop floor locations yet.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Shop floor | `LocationID` |  | flex 1 | renderer() | total custom |
    | Custom operational hours | `HasCapacityHours` |  | flex 1 | renderer() |  |
    | Number of individual resources | `ResourceQuantity` |  | flex 1 | renderer() | total sum |
    | Capacity per week (hours) | `CapacityHoursWeek` |  | flex 1 | renderer() | total sum |

- **grid** · renders into `divDaysGrid` · placeholder `You do not have any working days yet.` · layout column
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Day | `DayOfWeek` |  | flex 1 | renderer() | pick-only |
    | Start | `StartTime` |  | flex 1 | renderer() |  |
    | End | `EndTime` |  | flex 1 | renderer() |  |
    | Break start | `BreakStartTime` |  | flex 1 | renderer() |  |
    | Break end | `BreakEndTime` | date column | flex 1 | renderer() |  |
    |  | `` |  | 57 | renderer() |  |

- **grid** · renders into `unitsGridContainer` · placeholder `You do not have any individual resources in shop floor.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Name | `Name` |  | flex 1 |  |  |
    | Operational from | `OperationalFrom` | date column | flex 1 | edit: date field |  |
    | Operational to | `OperationalTo` | date column | flex 1 | edit: date field |  |
    | Non-operational from | `NonOperationalFrom` | date column | flex 1 | edit: date field |  |
    | Non-operational to | `NonOperationalTo` | date column | flex 1 | edit: date field |  |

- **grid** · renders into `costsGridContainer` · placeholder `You do not have any costs in resource.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    |  | `ProductName` |  | flex 2 |  |  |
    | Account | `AccountCode` |  | flex 1 | renderer() |  |
    | Production | `PriceTier` |  | flex 1 | renderer() |  |
    | Amount | `Cost` |  | flex 1 | renderer() | total sum |
    | Planned downtime | `PlannedDowntimePriceTier` |  | flex 1 | renderer() |  |
    | Amount | `PlannedDowntimeCost` |  | flex 1 | renderer() | total sum |
    | Not planned downtime | `NotPlannedDowntimePriceTier` |  | flex 1 | renderer() |  |
    | Amount | `NotPlannedDowntimeCost` |  | flex 1 | renderer() | total sum |

- **grid** · renders into `divReferences` · store `ReferencesStore` · placeholder `Resource is not used in any production BOM.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    |  | `ImageID` |  | 60 | renderer() |  |
    | Product | `ProductCode` |  | flex 1 | renderer() |  |

- **grid** · renders into `remarksGrid` · placeholder `You do not have any remarks yet.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Remark | `Remark` |  | flex 3 |  |  |
    | Attached by | `CreatedBy` |  | flex 1 |  |  |
    | Date | `CreatedDate` |  | flex 1 | renderer() |  |


#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| date field |  | `cmbReleaseOrderDate` | `` | format `UserDateFormat` |
| combo |  | `cmbOperational` | `StatusStore` | shows `name` · value `value` |
| combo |  | `cmbType` | `TypesStore` | shows `name` · value `value` |

### `ProductionSetup`

3 grids · 1 standalone fields · 0 windows · 3 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `wcGridContainer` · store `workCenterListStore` · placeholder `You do not have any work centers yet. To set up bin for every work ce…`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    |  | `` |  | flex 1 | renderer() | hidden |
    | Code | `Code` |  | flex 1 |  |  |
    | Purchase co-man | `IsCoManPurchase` | check column | 100 | renderer() |  |
    | Co-man | `IsCoMan` | check column | 90 | renderer() |  |
    | Name | `NameFake` |  | flex 1 | renderer() |  |
    | Color code | `ColorCode` |  | flex 1 | renderer() |  |
    | Mode | `CoManProcurementType` |  | flex 1 | renderer() |  |
    |  | `InLocationIDsFake` |  | flex 1 | renderer() |  |
    | {"".concat('Output bin'+'<span class="prod-tooltip-icon" da… | `OutLocationIDsFake` |  | flex 1 | renderer() |  |
    | State | `IsActive` |  | 120 | renderer() |  |

- **grid** · renders into `resGridContainer` · store `resourcesStore` · placeholder `You do not have any resources yet.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    |  | `` |  | flex 1 | renderer() | hidden |
    | Code | `Code` |  | flex 1 |  |  |
    | Name | `Name` |  | flex 1 |  |  |
    | State | `IsActive` |  | flex 1 | renderer() |  |

- **grid** · renders into `SuspendReasonGridContainer` · store `vSuspendReasonsLocalStore` · placeholder `You do not have any suspend reasons at the moment.`
  - *columns:*
    - *(component built elsewhere: `addColumns`)*

#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| date field |  | `cmbReleaseOrderDate` | `` | format `UserDateFormat` |

#### Menus, buttons and other parts

- **check column** “{"".concat(item.Code,": ").concat(…)}” · field `item.WorkCenterID` · id `"colSuspendReasonGrid_".concat(…)`
- **column** “Reason” · field `Reason` · id `colSuspendReasonId`
- **column** “Downtime type” · field `DowntimeType` · id `colDowntimeType`

### `Scheduler`

0 grids · 8 standalone fields · 0 windows · 3 menus, buttons and other parts · 0 custom components

#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| date field |  | `cmbReleaseOrderDate` | `` | format `UserDateFormat` |
| date field |  | `cmbPlanFrom` | `` | placeholder `Choose...` · format `UserDateFormat` |
| date field |  | `newStartDate` | `` | placeholder `Choose...` · format `UserDateFormat` |
| date field |  | `cmbPlanTo` | `` | placeholder `Choose...` · format `UserDateFormat` |
| combo |  | `cmbShopFloor` | `shopFloorsStore` | shows `Description` · value `LocationID` |
| combo |  | `btnResourceSetup` | `resourcesStoreForFilter` | shows `Name` · value `ResourceID` · placeholder `Choose...` · multi-select |
| combo |  | `btnWorkCenterSetup` | `workCentersStore` | shows `Name` · value `WorkCenterID` · placeholder `Choose...` · multi-select |
| date field |  | `ConsolidateOrders_RequiredByDate` | `` | format `UserDateFormat` |

#### Menus, buttons and other parts

- **component**
  - *columns:*
    - **component** · name `text`
    - **component** · name `start_date`
    - **component** · name `duration`
    - **component** · name `add`
- **component**
  - *columns:*
    - **component** · name `name`
    - **component** · name `capacity`
    - **component** · name `count`
- **EmbeddedCalendarPicker** · renders into `schedulerDayRange` · format `window.UserDateFormat`

