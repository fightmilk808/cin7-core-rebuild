# Shell and navigation: UI

Every component the page code builds, read from the shipped ExtJS bundles: grids with their columns, fields, buttons, menus, windows and custom components. Labels are the English UI text. `renders into` is the id of the `<div>` in the page's server-rendered HTML that the component mounts in; `store` names the data store (see the endpoints in [README.md](README.md)); `on click` is the handler. Visual system and shell layout: [docs/UI.md](../../docs/UI.md).

## Layout: the shell on every page

Top bar, navbar, left menu, floating action button and footer, from the page HTML.

```text
## .dr-header
block #divContinueSetupBlock
  button "Setup guide"#btnContinueSetup primary
block #divViewPlansBlock (hidden)
  slot #txtDaysRemaining
  button "Subscribe" primary
modal#Renew_Subscription_Message small
  heading "Renew subscription"
  button "×"
  slot #renewSubscriptionMessage
  button "Renew now" primary
  button "Close"

## .dr-subheader
button #syncMenuItem ▾
  slot #fSyncStatus
slot #SyncState
button 
menu#navFavoritesList: {the user's favourite pages}
button #navAddNewDropDown
block #navAddNewDropDownContainer
  button "Show more"#navQuickMenuShowMore
  link "Simple purchase"
  link "Simple sale"
  link "Job"
  link "Product"
  link "Receive money"
  heading "Purchase"
  link "Simple purchase"
  link "Advanced purchase"
  link "Service purchase"
  link "Supplier"
  link "Reorder"
  heading "Sale"
  link "Simple sale"
  link "Advanced sale"
  link "Service sale"
  link "Customer"
  heading "Production"
  link "Assembly"
  link "Disassembly"
  link "Job"
  link "Inventory write-off"
  link "Production order"
  heading "Inventory"
  link "Product"
  link "Product family"
  link "Stock adjustment"
  link "Stocktake"
  link "Transfer"
  heading "Financials"
  link "Receive money"
  link "Spend money"
  heading "CRM"
  link "Lead"
  link "Opportunity"
  heading "Money"
  link "Cin7 Capital"
  link "Cin7 Pay"
button #btnPendoResource
button 
button #notificationIcon
button #navLangDropDown
menu#langList: 
button #navThemeDropDown
heading "Customize appearance"
heading "Choose one of available colors:"
block #divMenuPosition
  heading "Select navigation style:"
  input radio#verticalNavigation name=radio-navigation
  label "Vertical" for #verticalNavigation
  input radio#horizontalNavigation name=radio-navigation
  label "Horizontal" for #horizontalNavigation
  heading "Layout:"
  input radio#layoutSize_adaptToScreen name=radio-layoutsize
  label "Fixed width" for #layoutSize_adaptToScreen
  input radio#layoutSize_originalSize name=radio-layoutsize
  label "Full screen width" for #layoutSize_originalSize
  heading "Grid view mode:"
  input radio#gridView_defaultMode name=radio-mode
  label "Default mode" for #gridView_defaultMode
  input radio#gridView_compactMode name=radio-mode
  label "Compact mode" for #gridView_compactMode
button #navOrgListDropDown ▾
button #navProfileDropDown ▾
  slot #navProfileInitials
link "My subscription"
link "Change password"
link "User profile"
link "Release notes"
link "Get Support"
link "Log out"

## .dr-menu
input checkbox#checkbox_left-menu
label "" for #checkbox_left-menu
link "Dashboard"
text "Purchase"
menu: New Simple purchase Advanced purchase Service purc #inventoro_menu_item | Simple purchase | Advanced purchase | Service purchase | Purchase credit note | Supplier | Bulk payment | Smart reorder #inventoro_menu_item | Reorder backordered | Reorder | Purchases | Suppliers | Supplier deposits
text "Sale"
menu: New Simple sale Advanced sale Service sale Sale cr | Simple sale | Advanced sale | Service sale | Sale credit note | Customer | Bulk payment | RMA | Sales | Winners & Losers | Fulfillment orders (hidden) | Customers / Credits | Recurring sales | Warranties | RMAs | Return orders
text "Production"
menu: New Assembly Disassembly Job Inventory write-off P | Assembly | Disassembly | Job | Inventory write-off | Production order | Assemblies | Disassemblies | Jobs | Inventory write-off | Production orders | Capacity Planner | Scheduler | Setup
text "Inventory"
menu: New Product/Service/Asset Product/Service Product  | Product/Service/Asset | Product/Service | Product family | Stock adjustment | Stocktake | Transfer | Inventory write-off | Products | Product families | Availability | Stocktake/adjustments | Transfers | Print the products price list | Inventory write-off | Gift cards | MRP
text "Financials"
menu: New Receipt Receive money Spend money Transfer mon #menuFsaiPlanning | Receipt | Receive money | Spend money | Transfer money | Journal | Receipts | Expense claims | Fixed assets | Depreciations | Bank accounts | Money tasks | Journals | Purchase budget planner #menuFsaiPlanning
text "CRM"
menu: New Lead Opportunity Search Leads Opportunities Ta | Lead | Opportunity | Leads | Opportunities | Tasks
text "Financials"
menu: New Receive money Spend money Search Money tasks P #menuFsaiPlanning | Receive money | Spend money | Money tasks | Purchase budget planner #menuFsaiPlanning
text "Money"
menu: New Cin7 Capital Cin7 Pay | Cin7 Capital | Cin7 Pay
link "Ask AI"
link "Reports"
link "Integration"
link "Marketplace"
text "Settings"
menu: General Settings Reference Books Users and roles D | General Settings | Reference Books | Users and roles | Document and email templates | Automation | ForesightAI settings | Demo data generation tool
text "New"
text "Smart reorder"#inventoro_vmenu_item
text "Search"
text "New"
text "Search"
text "New"
text "Search"
text "New"
text "Search"
text "New"
text "Search"
text "Purchase budget planner"#vmenuFsaiPlanning
text "New"
text "Search"
text "New"
text "Search"
text "Purchase budget planner"#vmenuFsaiPlanning
text "Search"

## .action-button
(none)

## .dr-footer
link "2012-2026 © Cin7 Americas, Inc"
link "Privacy policy"
link "Terms of use"
link "Support"
```

## Dialogs on most pages

### `Delivery_deliveryTaskModal`

```text
modal#Delivery_deliveryTaskModal medium
  heading "Delivery task"
  button "×"
  input text#Delivery_dvTaskDate read-only
  label "Date"
  input text#Delivery_dvTaskTime read-only
  label "Time"
  input text#Delivery_dvTaskLinkTo
  label "Link to"
  input text#Delivery_dvTaskAvailableDeliverySlots
  label "Available delivery slots"
  button #divTaskDeliveryAddItem primary
  button "All products"#divTaskDeliveryAddAllItems
  slot #divTaskDeliveryItems
  button "Save"#Delivery_Save primary
  button "Close"
```

### `GDrive_ExplorerModal`

```text
modal#GDrive_ExplorerModal medium
  heading #GDrive_ExplorerModal_Header
  button "×"
  slot #divGSuites_DirectoryTree
  slot #divGSuites_DirectoryTree_Files (hidden)
  button "Save"#GDrive_ExplorerModal_btnSave primary
  button "Close"
```

### `GDrive_ReportExport`

```text
modal#GDrive_ReportExport medium
  heading "Export report"
  button "×"
  text "Export of the report will be downloaded to your local machine. Please select a location below to provide the folder to w"
  heading "Report export folder"
  slot #gdLocationNameReporting
  button "Change" primary
  label "Select format"
  select#GDrive_ReportExport_Format
  button "Export"#GDrive_ReportExport_btnSave primary
  button "Close"
```

### `Task_Attachments`

```text
modal#Task_Attachments medium
  heading 
  button "×"
  block #divUploadTaskAttachment
    block #preview-template (hidden)
    slot #task-upload-frame (hidden)
    form#task-upload-form
      heading "Drop files here or click to upload."
  slot #divAttachmentGrid
  button "Close"
```

### `Task_DeliveryNotes`

```text
modal#Task_DeliveryNotes medium
  heading 
  button "×"
  slot #divNotesUserFilter
  label "User"
  slot #divNotesDateFilter
  label "Date"
  slot #divTaskDeliveryNotesGrid
  button "Close"
```

### `Task_taskModal`

```text
modal#Task_taskModal small
  heading 
  button "×"
  block #divEntityLink
    label "Entity"
    slot #spEntityLink
  block #Task_divWorkflowGroup (hidden)
    input text#Task_tbWorkflow read-only
    label "Workflow"
  input text#Task_tbTaskName
  label "Name"
  select#Task_selTaskCategory
  label "Category"
  button "Delivery items"#deliveryTaskButton primary
  select#Task_ddlEntityType
  label "Entity type"
  select#Task_ddlEntityInstance
  label "Entity"
  block #Task_tbTaskStart
    label "Date from"
  input text#Task_timeFrom
  label "Time from"
  select#Delivery_Task_timeFrom
  label "Delivery time"
  input checkbox#chkAllDay
  label "All day" for #chkAllDay
  block #Task_tbTaskEnd
    label "Date to"
  input text#Task_timeTo
  label "Time to"
  select#Task_ddlTaskStatus: Open | In progress
  label "Status"
  select#Task_ddlTaskStatusFake: Completed | Voided
  label "Status"
  select#Task_ddlLinkTo
  label "Link to"
  select#Task_ddlAssignedTo
  label "Assigned to"
  textarea#Task_txtDetails
  label "Description"
  label ""
  button "Notes"#Task_btnNotes (hidden)
  button "Attachments"#Task_btnAttachments (hidden)
  button "Clone"#Task_btnClone primary (hidden)
  button "Save"#Task_btnSaveTask2 primary
  button "Complete"#Task_btnCompleteTask2 primary
  button "Stop the process"#Task_btnStopProcess2
  button "Close"
```

### `WorkflowModal_startWorflow`

```text
modal#WorkflowModal_startWorflow small
  heading "Start a new workflow"
  button "×"
  label "Workflow"
  select#WorkflowModal_selWorkflow
  label "Start date"
  slot #WorkflowModal_dtWorkflowDate
  button "Save"#WorkflowModal_save primary
  button "Close"
```

### `calendarModal`

```text
modal#calendarModal large
  heading "Calendar"#exampleModalLabel
  button "×"
  block #divCalendarSelectors
    select#cbEntityType multiple: All types | Purchase | Supplier | Sale | CreditNote | Customer | Lead | Opportunity | Assembly | Disassembly | JobCosting | Inventory write-off | Expense claim | Expense claim receipt | Receive money | Spend money | Stock adjustment | Stocktake | Journal
    select#cbTaskCategory: All categories
    select#cbUser: All users
  slot #divCalendar
  button "Task"#btnAddNewTask primary
  button "Refresh"#btnRefresh primary
```

### `divReferencesData`

```text
modal#divReferencesData medium
  heading "References"
  button "×"
  table#tblReferencesTable
  button "Export to CSV"#Notification_Index_ExportToCsvButton primary
  button "Close"
```

### `divReferencesData_Html`

```text
modal#divReferencesData_Html medium
  heading "References"
  button "×"
  slot #divNotificationRefDetails
  button "Close"
```

## Components by bundle

What the page code builds and mounts into the layout's slots.

### `Main2019`

6 grids · 10 standalone fields · 0 windows · 19 menus, buttons and other parts · 11 custom components

#### Grids

- **grid** · renders into `ActivityLogs_Container` · store `ActivityLogsStore` · placeholder `There are no records in activity log at the moment.`
  - *columns:*
    - *(component built elsewhere: `gridColumns`)*
- **grid** · renders into `gridRecipients` · store `RecipientsStore` · placeholder `You do not have any contacts with emails at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    |  | `Checked` | check column | 58 | renderer() |  |
    | Name | `Name` |  | flex 1 | RenderHTMLText |  |
    | Email | `Email` |  | flex 1 |  |  |

- **grid** · id `id` · renders into `divTaskDeliveryNotesGrid` · store `store` · placeholder `emptyText`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Date | `DateTime` |  | flex 1 | renderer() |  |
    | Added by | `UserName` |  | flex 1 | renderer() |  |
    | Notes | `Note` |  | flex 1 | renderer() |  |

- **grid** · renders into `divTaskDeliveryItems` · store `DeliveryItemsStore` · placeholder `You do not have any delivery items.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `ProductID` |  | flex 1 | renderer() |  |
    | Quantity | `Quantity` |  | 80 |  |  |

- **grid** · renders into `divAttachmentGrid` · store `TaskFileStore` · placeholder `You do not have any uploaded files.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | File name | `FileName` |  | flex 1 | renderer() |  |
    | Attached by | `UserName` |  | flex 1 | renderer() |  |
    | Uploaded date | `UploadedDate` |  | flex 1 | renderer() |  |

- **grid** · renders into `AlternativeProductsModal_Grid` · store `vProductAlternativeStockStore` · placeholder `No alternative products found.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    |  | `` |  | 100 | renderer() |  |
    | Product | `ProductName` |  | flex 2 | renderer() |  |
    | Location | `LocationName` |  | flex 1 | renderer() |  |
    | Price | `Price` |  | flex 1 | renderer() |  |
    | On hand | `OnHand` |  | flex 1 | renderer() |  |
    | Available | `Available` |  | flex 1 | renderer() |  |
    | On order | `OnOrder` |  | flex 1 | renderer() |  |
    | Allocated | `Allocated` |  | flex 1 | renderer() |  |


#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| text field |  | `renderTo` | `` |  |
| checkbox |  | `renderTo` | `` |  |
| checkbox |  | `EmailSendTemplate_NetworkingCheck` | `` |  |
| combo |  | `divNotesUserFilter` | `usersStore` | shows `UserName` · value `id` · placeholder `Choose...` |
| date field |  | `divNotesDateFilter` | `` | placeholder `Choose...` · format `window.UserDateFormat` |
| date field |  | `Task_tbTaskStart` | `` | format `TaskModule_DateFormatExt` |
| date field |  | `Task_tbTaskEnd` | `` | format `TaskModule_DateFormatExt` |
| combo |  | `TFA_Question_1` | `securityQuestionsStore` | shows `Name` · value `ID` · placeholder `Select security question...` |
| combo |  | `TFA_Question_2` | `securityQuestionsStore` | shows `Name` · value `ID` · placeholder `Select security question...` |
| combo |  | `TFA_Question_3` | `securityQuestionsStore` | shows `Name` · value `ID` · placeholder `Select security question...` |

#### Menus, buttons and other parts

- **tooltip** · renders into `Ext.getBody(…)`
- **component** · id `cmpId` · renders into `renderTo` · store `localStore` · shows `name` · value `value` · placeholder `Choose...` · pick-only
- **item** “{menuItemText}” · icon `sortCls`
- **button** “{menuItemText}” · icon `sortCls` · on click `function(col){return function(){var subColCount=col.items.ge(…)`
- **column** “{name}” · field `valueProperty` · id `"colDimension_".concat(…)`
- **date column** “Date” · field `Date` · id `ActivityLogs_Date`
- **column** “Activity” · field `Message` · id `ActivityLogs_Message`
- **column** “Username” · field `UserName` · id `ActivityLogs_UserName`
- **column** “Reference” · field `Reference` · id `ActivityLogs_Reference`
- **action column** “{header}”
- **action column** “{header}” · id `"actionColumn_".concat(…)`
- **action column**
  - **component** “test” · on click `handler()`
- **action column**
  - **component** “test” · on click `handler()`
- **component** “Are you sure?”
- **column** “LogicalExpression” · field `Expand` · hidden
- **column** · field `Edit` · hidden
- **column** · field `colDelete`
- **check column** · field `Selected`
- **column** · field `None`

#### Custom components (`Ext.define`)

- **`Ext.draw.Text`** extends `Ext.draw.Component` · alias `widget.text`
- **`Ext.view.AbstractView`** extends `Ext.Component`
- **`Ext.form.Labelable`** extends `?`
- **`Ext.ProgressBar`** extends `Ext.Component` · alias `widget.progressbar`
- **`Ext.menu.Separator`** extends `Ext.menu.Item` · alias `widget.menuseparator`
- **`Ext.grid.column.Column`** extends `Ext.grid.header.Container` · alias `widget.gridcolumn`
- **`Ext.grid.RowNumberer`** extends `Ext.grid.column.Column` · alias `widget.rownumberer`
- **`Ext.toolbar.TextItem`** extends `Ext.toolbar.Item` · alias `widget.tbtext`
- **`Ext.panel.Panel`** extends `Ext.panel.AbstractPanel` · alias `widget.panel`
- **`Ext.tip.QuickTip`** extends `Ext.tip.ToolTip` · alias `widget.quicktip`
- **`Ext.window.MessageBox`** extends `Ext.window.Window` · alias `widget.messagebox`

### `MainAccount2019`

0 grids · 5 standalone fields · 0 windows · 11 menus, buttons and other parts · 11 custom components

#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| text field |  | `renderTo` | `` |  |
| checkbox |  | `renderTo` | `` |  |
| combo |  | `cmbAreaCode` | `countryCodeStore` | shows `FullCode` · value `CountryCode` · placeholder `` |
| combo |  | `cmbAreaCode` | `countryCodeStore` | shows `FullCode` · value `CountryCode` · placeholder `` |
| combo |  | `inputId` | `AutocompleteAddressField.prototype.AddressInfoSto…` | shows `description` · value `place_id` · placeholder `Look up an address` |

#### Menus, buttons and other parts

- **tooltip** · renders into `Ext.getBody(…)`
- **component** · id `cmpId` · renders into `renderTo` · store `localStore` · shows `name` · value `value` · placeholder `Choose...` · pick-only
- **item** “{menuItemText}” · icon `sortCls`
- **button** “{menuItemText}” · icon `sortCls` · on click `function(col){return function(){var subColCount=col.items.ge(…)`
- **column** “{name}” · field `valueProperty` · id `"colDimension_".concat(…)`
- **component** “Are you sure?”
- **column** “LogicalExpression” · field `Expand` · hidden
- **column** · field `Edit` · hidden
- **column** · field `colDelete`
- **check column** · field `Selected`
- **column** · field `None`

#### Custom components (`Ext.define`)

- **`Ext.draw.Text`** extends `Ext.draw.Component` · alias `widget.text`
- **`Ext.view.AbstractView`** extends `Ext.Component`
- **`Ext.form.Labelable`** extends `?`
- **`Ext.ProgressBar`** extends `Ext.Component` · alias `widget.progressbar`
- **`Ext.menu.Separator`** extends `Ext.menu.Item` · alias `widget.menuseparator`
- **`Ext.grid.column.Column`** extends `Ext.grid.header.Container` · alias `widget.gridcolumn`
- **`Ext.grid.RowNumberer`** extends `Ext.grid.column.Column` · alias `widget.rownumberer`
- **`Ext.toolbar.TextItem`** extends `Ext.toolbar.Item` · alias `widget.tbtext`
- **`Ext.panel.Panel`** extends `Ext.panel.AbstractPanel` · alias `widget.panel`
- **`Ext.tip.QuickTip`** extends `Ext.tip.ToolTip` · alias `widget.quicktip`
- **`Ext.window.MessageBox`** extends `Ext.window.Window` · alias `widget.messagebox`

### `MultilingualSupport2019`

1 grids · 0 standalone fields · 0 windows · 4 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · id `gridCustomId` · renders into `langGridId` · store `MultilingualDataStore`
  - *columns:*
    - *(component built elsewhere: `colSet`)*

#### Menus, buttons and other parts

- **column** · field `TemplateName`
- **column** · field `Text`
- **column** “Language” · field `TemplateName`
- **column** “Translation” · field `Text`

