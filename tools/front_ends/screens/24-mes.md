## Screens

Source: the Angular (Ivy, Material) app inside the Cordova bundle, `www/en-US/main-es5.*.js` (compiled; templates are read from the component definitions, UI strings are the English build; the `main-es2015` file holds the same app). Routes come from the router configuration in that file (`path:"..."` entries; `/` redirects to `/login`). Sign-in, the header bar, the menu item rows, the search inputs, the camera scan widget and the stock-transfer / stock-lookup screens are shared with the WMS app.

Server access: same scheme as WMS: base `https://inventory.dearsystems.com`, every call is `/ExternalApi` plus the path shown in the "API calls" lines (`/system/DEARMan_*` is the manufacturing namespace, `/system/PickAndPack_*` the shared handheld one). Sign-in is `POST /system/login` with the application type `DEARMan` (the manufacturing app); later calls carry the account id, application key, user id and user name as headers. The main menu shows live counters for some entries (`/system/DEARMan_MenuCounters`) and checks a permission name (second argument of `checkAccessPermission`) before navigating.

**Navigation map**

```text
Sign in (/login: email + password, Google, Microsoft, biometrics, reset password)
  -> Working area setup (/working-area: organization + shop floor)
  -> Main menu (/main-menu)

Main menu items (permission name in brackets), top to bottom:
  Work center settings                  -> /workcenter-list (tick the work centers this device works on; back to the menu)
  Task list                             -> /task-list (or /task-list-storage to restore the last filters) -> /task-list-options (filters and sort)
      each task                         -> /task-item (tabs: To consume, Resources, Notes, Files, BOM, Attributes)
          component row                 -> /picking-item        add resource -> /picking-resource       Map batch/serial # -> /traceability-mapping
          finish operation              -> /task-output -> /task-item-putaway (operation output) ; unused components -> /task-unused
  Stock transfer [stocktransfer_index]  -> /transfer-menu
      From location / To location       -> /pick-location-list -> /transfer-to-pick or /transfer-to-put (each with /details) -> /put-away-select-location
      By order                          -> /stocktransfer-list -> /stocktransfer-details or /stocktransfer-new -> /stocktransfer-item-details
  Stock lookup [stock_index]            -> /stock-lookup
  Scheduler [scheduler_index]           -> /scheduler-list -> /scheduler (By production orders / By resources)
  Capacity lookup [capacityplanner_index] -> /capacity-lookup
  Production reports [reporting_production] -> /report-list -> /report
  Open WMS                              -> opens the WMS app (hidden in the simulator)
  Settings                              -> /about (camera scan toggle, language, push notification settings)
  Log out                               -> /login
Other entry: /certificate-error (shown on old Android devices that cannot validate the server certificate)
```

### Certificate error

Route: `/certificate-error`. Component: `ng-component`.

```text
text "You have an old Android device which faces a certificate problem when connecting to our API server. Please update your device to the latest version or follow the instructions below to manually install the certificate."
link "Link" → openLink()
```

API calls: none (local state only)

### Sign in

Route: `/login`. Component: `app-login`. Navigates to: `/working-area`.

```text
image assets/img/PosImages/cin7-core.svg
component <app-camera-scan> [show=true]
heading "Sign In to MES"
form
  if configService.isDebug:
    input text "URL" (model: url)
    if url:
      button "[close]" → url = ""
  input email "Email" (model: emailValue; name: UserName; required)
  if value:
    button "[close]" → ref.reset()
  if dirty&&touched&&errors&&errors.email&&!isEmailFocused():
    error "Please enter a valid email address"
  input type: showPassword?"text":"password" "Password" (model: passwordValue; name: Password; required) → copy: preventDefault()
  if value:
    button "[showPassword?"password-hide":"password-show"]" → showPassword = !showPassword
  if value:
    button "[close]" → ref.reset()
  if !isDeviceRooted:
    link "Forgot/reset password" → resetPassword()
  button "Sign in" → submit(e), e = #ref [disabled when invalid||isDeviceRooted]
text "OR"
button "[google-logo] Sign in with Google" → googleLogin() [disabled when isDeviceRooted]
button "[ms] Sign in with Microsoft" → msalLogin() [disabled when isDeviceRooted]
if isBioAvailable:
  button "[face-scan] Sign in with biometrics" → biometricLogin() [disabled when isDeviceRooted]
dialog "<h3>Current version of Android System WebView component {…} is less than required for correct GUI presentation.<br/> Would you like to updat"
```

API calls: POST /system/login

### Working area setup

Route: `/working-area`. Component: `app-working-area`. Navigates to: `/login`.

```text
heading "Setup Working Area" [app-form-header]
input mat-select "Organizations" "{Company}" (required; disabled when !loginService.tenants||1==loginService.tenants.length; value: selectedOrganization) → valueChange: selectedOrganization = e; selectionChange: changeOrganization()
  for each item in loginService.tenants:
    option "{Company}"
input mat-select "Shopfloor" "{ShopfloorName}" (required; disabled when !shopFloors||!shopFloors.length; value: selectedLocation) → valueChange: selectedLocation = e
  for each item in shopFloors:
    option "{ShopfloorName}"
button "Next" → handleConfirm() [disabled when !selectedOrganization||!selectedLocation]
dialog "Do you want to enable biometric sign-in for user   [No]"
```

API calls: GET /system/PickAndPack_Configuration; GET /system/DEARMan_WorkCenters; /system/login; /system/DEARMan_MenuCounters

### Work centers

Route: `/workcenter-list`. Component: `app-work-centers`. Navigates to: `/main-menu`.

```text
heading "Work Centers" [app-form-header]
heading "{shopFloorName}"
button "Select all" → ref.selectAll() [disabled when serverWorkCenters.length===selectedWorkCenters.length]
component <mat-selection-list> [ngModel=selectedWorkCenters, disabled=!isUserAttachedToShopfloor]
  for each item in serverWorkCenters:
    component <mat-list-option> [value=WorkCenterID]
      text "{Name}"
button "Save" → handleFinish() [disabled when !isSaveEnabled()]
dialog "<h3>Are you sure you want to cancel setup?</h3>"
```

API calls: /system/DEARMan_MenuCounters

### Main menu

Route: `/main-menu`. Component: `app-main-menu`. Navigates to: `/login`, `/task-list`.

```text
heading (dynamic) [app-form-header]
menu item "Work center settings" → navigate /workcenter-list
menu item "Task list" → toTaskList()
menu item "Stock transfer" → checkAccessPermission("transfer-menu","stocktransfer_index",1)
menu item "Stock lookup" → checkAccessPermission("stock-lookup","stock_index")
menu item "Scheduler" → checkAccessPermission("scheduler-list","scheduler_index",1)
menu item "Capacity lookup" → checkAccessPermission("capacity-lookup","capacityplanner_index",1)
menu item "Production reports" → checkAccessPermission("report-list","reporting_production")
if !configService.isSimulator:
  menu item "Open WMS" → openWMS()
menu item "Log out" → logOut()
menu item "Settings" → navigate /about
```

API calls: /system/DEARMan_MenuCounters

### Settings

Route: `/about`. Component: `app-settings`.

```text
heading "Settings" [app-form-header]
input mat-chip-list "Application version : v.{configService.appVersion}"
component <app-setting> [isEnabled=enableCameraScan, name=Enable camera scan] → isEnabledChange: enableCameraScan = e
component <app-setting-section> [name=Language setting]
input mat-select "Select language" (value: language) → valueChange: language = e
  for each item in languages:
button "Apply" → handleLanguageSelect()
component <app-push-settings>
```

API calls: none (local state only)
API calls via child component `app-push-settings`: GET /system/PushSettings; POST /system/PushSettings?app=

### Task list

Routes: `/task-list`, `/task-list-storage` (route data {getFromStorage:true}). Component: `app-task-list`. Navigates to: `/task-item`, `/task-list-options`.

```text
heading "Task List" [app-form-header]
form
  input text "Type text to search..." (model: searchTerm; name: searchTerm) → keyup.enter: onSearch()
  if searchTerm:
    button "[close]" → onSearch(), searchTerm = ""
  button "[search]" → onSearch()
  button "[filter]" → goFilter()
  tabs:
    tab "Overdue"
    tab "Today"
    tab "Tomorrow"
    tab "All"
  for each item in displayItems:
    mat-list-item "{WorkCenterCode} - {OperationName} \xa0({OrderNumber}/{RunNumber}) {ProductCode}: {ProductName} Order quantity: {Quantity} Run quantity: {RunQuantity} {BufferStatusName} {StatusDisplay} Start at: {StartDateLocal}" → showOperationDetails(e), e = .$implicit [disabled when IsReadOnly]
component <mat-paginator> [pageSize=pageSize, pageIndex=pageIndex] → page: reloadData()
```

API calls: /system/DEARMan_MenuCounters; GET /system/DEARMan_UnusedComponents; /system/DEARMan_OperationStatus; /system/DEARMan_TaskList

### Task list filters and sort

Route: `/task-list-options`. Component: `app-task-list-options`. Navigates to: `/task-list`, `/task-list-storage`.

```text
button "Save" → saveChanges()
heading "Filters"
button "[close]" → goBack()
heading "Status"
button "Select all" → ref.selectAll() [disabled when statuses.length===selectedOptions.length]
component <mat-selection-list> [ngModel=selectedOptions] → selectionChange: filterChanged(e)
  for each item in statuses:
    component <mat-list-option> [value=Code]
      text "{Description}"
heading "Sort"
input mat-radio-group "By urgency (required by date) By scheduled order By latest required by date" (model: sort)
  input mat-radio-button "By urgency (required by date)" (value: 0)
  input mat-radio-button "By scheduled order" (value: 1)
  input mat-radio-button "By latest required by date" (value: 2)
dialog "Please select at least one filter to see the task list."
```

API calls: none (local state only)

### Task (operation) details

Route: `/task-item`. Component: `app-task-item`. Navigates to: `/picking-item`, `/picking-resource`, `/task-list`, `/traceability-mapping`.

```text
heading " " [app-form-header]
expansion panel:
  text "Quantity"
  text "{details.Operation.Quantity}"
  text "Actual time"
  text "{liveTime | pipe}"
  if "PLANNED"===details.Operation.OperationStatus:
    button "[start]" → start()
  if "PLANNED"!==details.Operation.OperationStatus:
    button "[complete]" → finish() [disabled when readOnly]
  if "SUSPENDED"!==details.Operation.OperationStatus:
    button "[pause]" → suspend() [disabled when "PLANNED"===details.Operation.OperationStatus||"COMPLETED"===details.Operation.O]
  if "SUSPENDED"===details.Operation.OperationStatus:
    button "[pause]" → resume()
  if suspendReasonText&&"SUSPENDED"===details.Operation.OperationStatus:
    text "Operation suspended: {suspendReasonText}"
tabs:
  tab "To consume"
    if !readOnly:
      button "Auto-consume" → autoPick() [disabled when isBackflushing]
      if showTraceability:
        button "Map batch/serial #" → openMapping()
      input text "Product name/SKU/Barcode" (model: searchComponentText) → keyup.enter: searchComponent()
      if searchComponentText:
        button "[close]" → searchComponentText = ""
      button "[search]" → showComponentSearch(componentSearchHidden)
    if displayItems.length>0:
      for each item in displayItems:
        mat-list-item "{ComponentTypeName} Backflush Not available {ProductName} {ProductCode} Pick from: {PickFromDisplay} New component Required: Expected: {roundValue(PlannedQuantity,4)} Consumed: Produced: {Quantity} Consumed: Wastage: {WastageQuantity} Wastage: Consume \xa0/\xa0 Wastage [trash]"
    if 0===displayItems.length:
      text "This operation has no components."
    button "Save" → saveAll() [disabled when readOnly]
    button "Reset" → resetAll() [disabled when readOnly]
  tab "Resources"
    if !readOnly:
      button "Add resource" → addResource()
      input text "Resource name" (model: searchResourceText) → keyup: searchResource()
      if searchResourceText:
        button "[close]" → searchResource(), searchResourceText = ""
      button "[search]" → showResourceSearch(resourceSearchHidden)
    form
      if details.Resources.length>0:
        list: rows (resourcesDataSource) show NAME | QUANTITY | tools
          column name "NAME": {ResourceName} / [\xa0({ResourceCode}) if !!ResourceCode]
          column tools: <button [trash] → removeResource(e), e = .$implicit>
    if 0===details.Resources.length:
      text "This operation has no resources."
    button "Save" → saveAll() [disabled when readOnly||invalid]
    button "Reset" → resetAll() [disabled when readOnly]
  tab "Notes"
    input mat-chip-list "{Text}"
    if details.Notes.length>0:
      for each item in details.Notes | filter:
        mat-list-item "[4===Type?"note":"info"] {Note} Production instructions link [trash]" → previewNote(e), e = .$implicit
    if 0===details.Notes.length:
      text "There are no notes at the moment."
    button "Add note" → addNote()
  tab "Files"
    input mat-chip-list "{Text}"
    if details.Attachments.length>0:
      for each item in details.Attachments | filter:
        mat-list-item "[1===Type?"attach":"file"] {FileName} {FileName} [trash]" → previewAttachment(e), e = .$implicit
    if 0===details.Attachments.length:
      text "There are no attachments at the moment."
    button "Add file" → addAttachment(!1)
    if isAndroid:
      button "Add image" → addAttachment(!0)
  tab "BOM"
    if details.BOM:
      if !readOnly:
        if details.BOM.Version:
          if details.BOM.CreatedDate:
          text "{details.BOM.ProductName}"
      for each item in details.BOM.Operations:
        expansion panel:
          if Name!==details.Operation.OperationName (else i):
            if null!=Status&&"PLANNED"!==Status (else i):
          text "Step# {Order}"
          text "{OperationType | pipe}"
          text "{CycleTime | pipe}"
          list: rows ($implicit.Entities) show type | name | quantity | unit
            column type: {0===Type?"Resource":ComponentTypeName}
            column name: {Code}: {Name}
            column quantity: {Quantity | filter}
            column unit: {0!==Type?Unit:""}
    if !details.BOM:
      text "Loading..."
  tab "Attributes"
    if isShowAdditionalAttributes:
      component <app-additional-attribute-list>
    if !isShowAdditionalAttributes:
      text "No additional attribute set has been selected at the operation level."
    if isShowAdditionalAttributes:
      button "Save" → saveAttributes() [disabled when isReadOnlyAddAttributes]
dialog "All unsaved data will be lost. Do you want to refresh?"
dialog "The {…}/{…} data has been modified since it was loaded on your app. Please click/tap OK to reload the task list."
dialog "Data has been changed. Do you want to save data and return to task list?"
dialog "All changes you made will be discarded. Do you want to continue?"
dialog "Do you want to delete this resource?"
dialog "Do you want to complete current operation?"
dialog "Do you want to delete this attachment?"
dialog "Do you want to delete this note?"
```

API calls: GET /system/DEARMan_TaskDetails; GET /system/DEARMan_Traceability; GET /system/DEARMan_OperationStatus; /system/DEARMan_TaskDetails; PUT /system/DEARMan_RunOperationAttributeSet; POST /system/DEARMan_TaskDetails; POST /system/DEARMan_TaskDetailsSearch; GET /system/DEARMan_AttachmentV2; /system/DEARMan_OperationStatus; GET /system/DEARMan_UnusedComponents; POST /system/DEARMan_Attachment; DELETE /system/DEARMan_Attachment; POST /system/DEARMan_Note; DELETE /system/DEARMan_Note

### Transfer unused components

Route: `/task-unused`. Component: `app-unused-components-transfer`. Navigates to: `/task-list`.

```text
heading "Transfer unused components" [app-form-header]
text "{details.Operation.WorkCenterCode} - {details.Operation.OperationName}"
if 2!=status:
  text "{statusName}"
text "Unused components"
text "QTY"
text ":\xa0"
text "{quantity}"
input text "Type text to search..." (model: searchTerm; name: searchTerm) → keyup.enter: onSearch()
if searchTerm:
  button "[close]" → onSearch(), searchTerm = null
button "Select location to transfer" → openFillLocationDialog()
form
  list: rows (itemsDataSource) show NAME | Unused | QUANTITY | LOCATION
    column name "NAME": {ProductName} / SKU: {ProductCode}
    column unused "Unused": {UnusedQuantity} / [copy]
    column quantity "QUANTITY": <number input model: Quantity>
    column location "LOCATION": <app-location-dropdown>
button "Transfer all" → transferAll()
button "Finish" → finish() [disabled when invalid]
dialog "You have no components to transfer"
dialog "Are you sure you want to cancel components transfer?"
```

API calls: POST /system/DEARMan_UnusedComponents

### Products output

Route: `/task-output`. Component: `app-task-output`. Navigates to: `/task-item`, `/task-item-putaway`, `/task-list`.

```text
heading "Products Output" [app-form-header]
text "{details.Operation.ProductionOrderNumber}\xa0"
text "({details.Operation.RunNumber})"
if resultComponents.length>0:
  for each item in resultComponents:
    mat-list-item "{ComponentTypeName} {ProductName} {ProductCode} Produced: Wastage: Location: {BinName} Edit output data [trash]"
if 0===resultComponents.length:
  text "Operation has no produced finished products."
button "Complete" → saveAll()
```

API calls: GET /system/DEARMan_Traceability; /system/DEARMan_TaskDetails; /system/DEARMan_OperationStatus; GET /system/DEARMan_UnusedComponents

### Component details

Route: `/picking-item`. Component: `app-picking-item`. Navigates to: `/task-item`.

```text
heading "Component details" [app-form-header]
if line.Image:
  tap area <div> → showImage(getImageUrl(line.Image))
if !line.Image:
  image assets/img/PosImages/image-placeholder.png
text "{line.Name}"
text "SKU:\xa0{line.ProductCode}"
text "Unit:\xa0{line.Unit}"
text "Ordered:"
text "{line.Available}"
text "Consumed:"
text "{TotalCollected()}"
if !readOnly:
  input text "Type bin to search" (model: searchTerm; name: searchTerm) → keyup.enter: handleSearch()
  if searchTerm:
    button "[close]" → searchTerm = ""
  button "[search]" → handleSearch()
form
  list: rows (dataSource) show Details | LEFT IN STOCK | Wastage | Actual Quantity | Tools
    column Location "Details": {BinName?BinName:"N/A"} / [Exp.: {ExpiryDate | pipe} if ExpiryDate]
    column LeftInStock "LEFT IN STOCK": {AvailableQuantityAfterConsume}
    column Wastage: <number input model: WastageQuantity>
    column Quantity "Actual Quantity": <number input model: Quantity>
button "Finish" → finish() [disabled when readOnly||invalid]
dialog "Do you want to cancel changes in consumption?"
```

API calls: POST /system/DEARMan_TaskDetailsSearch

### Add resource to operation

Route: `/picking-resource`. Component: `app-picking-resource`. Navigates to: `/task-item`.

```text
heading "Add new resource to operation" [app-form-header]
text "{pickItem.ResourceName}"
text "{pickItem.ResourceCode}"
input number "Quantity to add" (model: itemValue; name: Quantity; min 1) → keyup.enter: saveAll()
button "Add resource to list" → saveAll() [disabled when invalid]
```

API calls: GET /system/DEARMan_TaskDetails; /system/DEARMan_TaskDetails

### Operation output (put away)

Route: `/task-item-putaway`. Component: `app-task-item-putaway`. Navigates to: `/task-output`.

```text
if null==selected:
  heading "Operation output" [app-form-header]
  text "{savedDetails.Operation.ProductionOrderNumber}\xa0"
  text "({RunNumber})"
  text "{details.ProductName}"
  text "SKU: {details.ProductCode}"
  if details.isSimple:
    input number "Produced quantity" (model: itemValue; name: scan-number; required) → keyup.enter: validateGridEditedValue("Quantity")
    if itemValue:
      button "[close]" → itemValue = 0
    input number "Wastage quantity" (model: wastageValue; name: wastage-number; required) → keydown.,: preventDefault(); keyup.enter: validateGridEditedValue("WastageQuantity")
    if wastageValue:
      button "[close]" → wastageValue = 0
  input mat-select "Selected location" "[default] {locationSelector.value.LocationName} [default] {LocationName} (default location)" (control: locationSelector; required; value: binValue) → valueChange: binValue = e
    if !!locationSelector.value&&locationSelector.value.IsDefault:
    if !!locationSelector.value:
      text "{locationSelector.value.LocationName}"
    for each item in locations:
      option "[default] {LocationName} (default location)"
  if "FIFO"!=details.CostingMethod:
    button "[clone]" → addItemAuto()
    input text "Batch/Serial #" (model: batchsnValue; name: Batch) → keyup.enter: addItemFromScan(e,batchsnValue); keyup.tab: addItemFromScan(e,batchsnValue)
    if batchsnValue:
      button "[close]" → batchsnValue = ""
  if hasExpiredDate:
    input text "Expired" (control: date; name: scan-expired; min minDate) → dateChange: globalExpiryDateChanged(e)
    if !!date.value:
      button "[close]" → date.setValue("")
    input mat-datepicker-toggle "[calendar]"
    component <mat-datepicker> [touchUi=true] → closed: datePickerClosed()
  form
    if !details.isSimple:
      if details.SerialItems&&details.SerialItems.length:
        tap area <serial-items-list> → itemsChange: details.SerialItems=e; itemClick: onClick(e)
  if shouldDisplayAdditionalAttributes():
    component <app-additional-attribute-list>
  button "Finish" → saveAll() [disabled when !details.isSimple&&(!(details.SerialItems&&details.SerialItems.length>0)||invali]
if null!=selected&&1===selectedActionType:
  component <app-finished-component-mapping-details> [selected=Traceability[selected], traceabilityDetails=traceability, allFinishedComponents=Traceability] → selectedChange: saveTraceabilityItem(e); closed: saveTraceabilityItem(null)
if null!=selected&&0===selectedActionType:
dialog "Actual quantity ({…}) is less than expected output quantity ({…}). Do you want to continue?"
```

API calls: GET /system/DEARMan_Traceability

### Map batch/serial numbers

Route: `/traceability-mapping`. Component: `app-finished-component-mapping`. Navigates to: `/task-item`.

```text
if null==openedDetailsIndex||openedDetailsIndex<0 (else n):
  heading "Map batch/serial #" [app-form-header]
  text "{details.Operation.ProductionOrderNumber}\xa0"
  text "({details.Operation.RunNumber})"
  if selected&&selected.ProductID:
    text "{selected.ProductName}"
    text "SKU: {selected.ProductCode}"
  text "Scan finished products to add them here and enable mapping"
  label "Select finished product"
  input mat-select "None {ProductCode+": "+ProductName}" (value: selected) → valueChange: selected = e; selectionChange: onSelect()
    option "None"
    for each item in finished:
      option "{ProductCode+": "+ProductName}"
  label "Expiry date"
  input text "Expiry date" (model: expiry; min minDate)
  input mat-datepicker-toggle "[calendar]"
  if !!expiry:
    button "[close]" → expiry = null
  component <mat-datepicker> [required-date=isExpiryRequired, touchUi=true]
  if invalid&&errors.required:
    error "Expiry date is required."
  if invalid&&errors.matDatepickerMin:
    error "Expiry date cannot be in the past."
  label "Scan batch/serial #"
  input text (model: batchSN) → keyup.enter: handleItem()
  text "Map components to finished products that have been added"
  if mappingFiltered.length>0:
    for each item in mappingFiltered:
      mat-list-item "{FinishedProduct.ProductName} SKU: {FinishedProduct.ProductCode} Batch/serial: {FinishedProduct.BatchSN} Expiry date: {FinishedProduct.ExpiryDate} Map batch/serial # [trash]"
  if 0===mappingFiltered.length&&selected:
    text "No mapping for selected product."
  button "Finish" → saveAll()
component <app-finished-component-mapping-details> [selected=mapping[openedDetailsIndex], traceabilityDetails=traceabilityDetails, isFromOperation=true] → selectedChange: saveDetails(e); closed: saveDetails(null)
```

API calls: GET /system/DEARMan_Traceability; POST /system/DEARMan_Traceability

### Production reports

Route: `/report-list`. Component: `app-report-list`. Navigates to: `/report`.

```text
heading "Production report list" [app-form-header]
for each item in reports:
  menu item "Name" → openReport(Value), e = .$implicit
```

API calls: /system/DEARMan_MenuCounters

### Production report

Route: `/report`. Component: `app-report`. Navigates to: `/report-list`.

```text
heading (dynamic) [app-form-header]
text "{reportDescription}"
input mat-select "Select layout for report" "{n}" (required; value: selectedLayout) → valueChange: selectedLayout = e
  for each item in layouts:
    option "{n}"
if null==reportData?null:reportData.isRequiredMode:
  input mat-select "Select mode for report" "{Name}" (required; value: selectedMode) → valueChange: selectedMode = e; selectionChange: onModeSelect()
    for each item in modes:
      option "{Name}"
  input text "From date" (control: fromDateCtrl; readonly; required; disabled when "Custom"!==selectedMode)
  input mat-datepicker-toggle "[calendar]"
  component <mat-datepicker> [touchUi=true]
  input text "To date" (control: toDateCtrl; readonly; required; disabled when "Custom"!==selectedMode)
  input mat-datepicker-toggle "[calendar]"
  component <mat-datepicker> [touchUi=true]
for each item in null==reportData?null:reportData.Params:
  case paramValueTypes.checkbox:
    input checkbox "{valueLable}" (checked: requestParams[jsonName]) → change: .$implicit,t=;requestParams[jsonName]=!requestParams[jsonNam
  case paramValueTypes.radio:
    if valueLable:
      heading "{valueLable}"
    input mat-radio-group "{name}" (model: requestParams[jsonName])
      for each item in valueOptions:
        input mat-radio-button "{name}" (value: value)
input text "Enter text to filter the report data" (model: searchTerm)
heading "Select export file format *"
input mat-radio-group "Excel (with totals) Excel (without totals) PDF RTF" (model: selectedExportFormat)
  if true===(null==reportData?null:reportData.ShowTotals)||void 0===(null==reportData?null:repo:
    input mat-radio-button "Excel (with totals)"
  input mat-radio-button "Excel (without totals)"
  input mat-radio-button "PDF"
  input mat-radio-button "RTF"
button "Export/download report" → handleExport()
```

API calls: GET /system/PickAndPack_ProductionReports; POST /system/PickAndPack_ProductionReports

### Scheduler: choose view

Route: `/scheduler-list`. Component: `app-scheduler-list`. Navigates to: `/main-menu`, `/scheduler`.

```text
heading "Scheduler" [app-form-header]
menu item "By production orders" → goToScheduler("production")
menu item "By resources" → goToScheduler("resource")
```

API calls: none (local state only)

### Scheduler (gantt chart)

Route: `/scheduler`. Component: `app-scheduler`. Navigates to: `/scheduler-list`.

```text
if isShowRotateInfo:
  button "[close]" → isShowRotateInfo = !1
  text "This chart is better viewed on a larger screen"
  image assets/img/PosImages/mobile-rotate.svg
  text "Try rotating your device into landscape mode"
heading (dynamic) [app-form-header]
heading "{shopFloorName}"
input text "Type text to search..." (model: searchTerm; name: searchTerm) → keyup.enter: searchData()
if searchTerm:
  button "[close]" → searchData(), searchTerm = ""
button "[search]" → searchData()
button "Filters [filter] {null==filterData?null:filterData.filterCount}" → openFilterDialog()
button "Columns [table-chart]" → openColumnsDialog()
button "Chart [chart]" → toggleOtherColumns()
```

API calls: GET /system/DEARMan_Scheduler; /system/DEARMan_DetailedResources; /system/DEARMan_Resources; GET /system/DEARMan_WorkCentersAll

### Capacity lookup

Route: `/capacity-lookup`. Component: `app-capacity-lookup`.

```text
heading (dynamic) [app-form-header]
heading "{shopFloorName}"
input text "Type text to search..." (model: searchTerm; name: searchTerm) → keyup.enter: searchData()
if searchTerm:
  button "[close]" → searchData(), searchTerm = ""
button "[search]" → searchData()
button "Filters [filter] {filterData.filterCount}" → openFilterDialog()
button "Columns [table-chart]" → openColumnsDialog()
list: rows (dataSource) show Resource name | Total | Available | Allocated | Allocated planned | Allocated released | Consumed
  column ResourceName "Resource name": {getResourcePrefix(ResourceType)+" "+ResourceName}
  column TotalCapacity "Total": {TotalCapacity,"1.0-1"}
  column AvailableCapacity "Available": {AvailableCapacity,"1.0-1"}
  column AllocatedCapacity "Allocated": [{AllocatedCapacity | filter} if AllocatedCapacity>0] / [0 if 0==AllocatedCapacity]
  column AllocatedPlanned "Allocated planned": {AllocatedPlanned,"1.0-1"}
  column AllocatedReleased "Allocated released": {AllocatedReleased,"1.0-1"}
  column ConsumedCapacity "Consumed": {ConsumedCapacity,"1.0-1"}
```

API calls: none (local state only)

### Stock transfer menu

Route: `/transfer-menu`. Component: `app-transfer-menu`. Navigates to: `/main-menu`, `/pick-location-list`.

```text
heading "Stock transfer menu" [app-form-header]
menu item "From location" → openTransferPicking("from")
menu item "To location" → openTransferPicking("to")
menu item "By order" → navigate /stocktransfer-list
```

API calls: none (local state only)

### Stock transfer: choose location

Route: `/pick-location-list` (route data {fromMenu:true}). Component: `app-pick-location-list`. Navigates to: `/transfer-to-pick`, `/transfer-to-put`.

```text
heading (dynamic) [app-form-header]
text "{locationName}"
component <app-search-input> [ngModel=searchTerm] → onSearch: onSearch(); onKeyUp: onSearch(); onClose: searchTerm = null
list: rows (dataSource) show 
if !dataSource||0==dataSource.data.length:
button "" → goToPickItems() [disabled when !hasSelected]
dialog "You have uncompleted put away, do you want to complete it?"
```

API calls: GET /system/DEARMan_Transfer_Locations

### Stock transfer: picking list

Route: `/transfer-to-pick`. Component: `app-transfer-to-pick`. Navigates to: `/pick-location-list`, `/transfer-menu`, `/transfer-to-put`.

```text
heading "Picking list" [app-form-header]
component <app-search-input> [ngModel=searchTerm, placeholder="Enter item # or scan UPC code"] → onKeyUp: onSearch(); onSearch: onSearch()
for each item in itemsDataSource.filteredData:
  mat-list-item "" → showDetails(e), e = .$implicit
button "Finish" → saveAll() [disabled when 0===pickedCount||!isLoaded]
```

API calls: GET /system/DEARMan_Transfer_ToPick; POST /system/DEARMan_Transfer_ToPick

### Stock transfer: item details (pick and put)

Routes: `/transfer-to-pick/details`, `/transfer-to-put/details`. Component: `app-transfer-pick-details`. Navigates to: `/pick`.

```text
heading "Item details" [app-form-header]
image itemData.Image | pipe,aa
text "{itemData.ProductName}"
text "SKU: {itemData.ProductCode}"
if locations:
  text "{"pick"===mode?"Pick:":"Place:"}"
  text "{itemData.RequiredQuantity}"
if locations&&locations.length:
  text "{"pick"===mode?"Pick from:":"Place to:"}"
  if !itemData.UseRecommendedPick (else n):
    for each item in locations:
      text "{n||"N/A"}"
      if i<locations.length-1:
        text ","
  text "{itemData.RecommendedBinName}"
text "Remain:"
text "{itemData.QuantityInSelectedUOM>itemData.Picked?itemData.QuantityInSelectedUOM-itemData.Picked:0,"1.0-4"}"
text "Picked:"
text "{itemData.Picked,"1.0-4"}"
input text "Bin" (model: binValue; name: Bin) → keyup.enter: handleBin(); keyup.tab: handleBin()
button "Auto-fill" → autoFillBin()
input text "isBatchSN?"Batch / SN":"Item #"" (model: itemValue; name: Item) → keyup.enter: addItem(); keyup.tab: addItem()
tap area <uom-selector> → selectedUOMChange: uomChange(e)
form
  heading "Picked items"
  list: rows (itemsDataSource) show DETAILS | RECEIVED | tools
    column bin "DETAILS": {Unit} @ {"pick"===mode?LocationName:LocationToName} / [Serial: {BatchSN} if BatchSN]
    column quantity "RECEIVED": <number input model: Picked>
    column tools: <button [trash] → remove(t), t = .index>
if itemData.Picked<itemData.QuantityInSelectedUOM&&"pick"===mode (else n):
  button "Pick partially" → back() [disabled when 0===itemData.Picked||invalid]
button "Finish" → back() [disabled when "put"===mode&&itemData.Picked!==itemData.QuantityInSelectedUOM||"pick"===mode&&i]
```

API calls: none (local state only)

### Stock transfer: put-away list

Route: `/transfer-to-put`. Component: `app-transfer-to-put`. Navigates to: `/put-away-select-location`.

```text
heading "Put away list" [app-form-header]
component <app-search-input> [ngModel=searchTerm, placeholder="Enter item # or scan UPC code"] → onKeyUp: onSearch(); onSearch: onSearch()
for each item in itemsDataSource.filteredData:
  mat-list-item "" → showDetails(e), e = .$implicit
button "Close" → cancel()
button "Finish" → saveAll() [disabled when 0===pickedCount||pickedCount!==toPickCount]
```

API calls: GET /system/DEARMan_Transfer_ToPut; POST /system/DEARMan_Transfer_ToPut; POST /system/DEARMan_PrintStockTransfer

### Stock transfer: choose put-away locations

Route: `/put-away-select-location`. Component: `app-put-away-locations-select`. Navigates to: `/main-menu`, `/transfer-to-put`.

```text
heading "Put away" [app-form-header]
text "{locationName}"
component <app-search-input> [ngModel=searchTerm, placeholder=Enter item # or scan UPC code] → onSearch: onSearch(); onKeyUp: onSearch()
list: rows (dataSource) show select | To location | Remain | Placed
  column select: <mat-checkbox input>
  column location "To location": {LocationName} / [{WorkCenterCodes} if WorkCenterCodes]
  column remain "Remain": {Remain}
  column picked "Placed": {Picked}
button "Close" → close()
button "Next" → next() [disabled when !hasSelected]
```

API calls: POST /system/DEARMan_PrintStockTransfer

### Transfer orders

Route: `/stocktransfer-list`. Component: `app-stocktransfer-list`. Navigates to: `/stocktransfer-details`, `/stocktransfer-new`.

```text
heading "Transfer orders" [app-form-header]
tabs:
  tab "All"
    component <app-stocktransfer-list-tab> [data=tabs[0]]
  tab "Draft"
    component <app-stocktransfer-list-tab> [data=tabs[1]]
  tab "Ordered"
    component <app-stocktransfer-list-tab> [data=tabs[2]]
  tab "Sent"
    component <app-stocktransfer-list-tab> [data=tabs[3]]
  tab "Completed"
    component <app-stocktransfer-list-tab> [data=tabs[4]]
button "Add Transfer" → addNewTransfer()
```

API calls: none (local state only)
API calls via child component `app-stocktransfer-list-tab`: GET /system/PickAndPack_StockTransferList; DELETE /system/PickAndPack_StockTransfer; POST /system/PickAndPack_PdfPrint

### Transfer order details

Route: `/stocktransfer-details`. Component: `app-stocktransfer-details`. Navigates to: `/stocktransfer-item-details`, `/stocktransfer-list`.

```text
heading "" [app-form-header]
expansion panel:
  text "Additional info"
  text "Transfer #"
  text "{task.Number}"
  text "From"
  text "{task.FromLocation}"
  text "To"
  text "{task.ToLocation}"
  text "Date"
  text "{task.CreatedDate}"
  text "Status"
  text "{statusText}"
if 0!==mode:
  form (submit → handleSearch())
    input text "searchLabel" (model: searchTerm; name: searchTerm)
    if searchTerm:
      button "[close]" → searchTerm = ""
    button "[search]"
list: rows (dataSource) show Name | Available | Ordered | Picked | {isPutAway()?"Received":"Quantity"} | Tools
  column Name: {Name} / SKU: {ProductCode} / [Serial: {BatchSN} if isPutAwayOrReadonly()&&BatchSN] / [Expiry: {…} if isPutAwayOrReadonly()&&ExpiryDate]
  column AvailableQuantity "Available": {AvailableQuantity}
  column OrderedQuantity "Ordered": {OrderedQuantity}
  column TransferQuantity "Picked": {TransferQuantity}
  column Quantity "{isPutAway()?"Received":"Quantity"}": [<number input model: Quantity> / [Min. allowed - 0.0001 if null==errors?null:errors.min] / [Max. allowed - {AvailableQuantity} if null==errors?null:errors.max] if isOrder()] / [{Quantity} if !isOrder
  column Tools: <button [trash] → removeItem(e), e = .$implicit>
if 0!==mode:
  button "Save" → saveTransfer()
  if 1===mode:
    button "Authorize" → validateThenAuthorize()
  if 2===mode&&!task.IsCoMan:
    button "Send" → send()
  if 2===mode&&task.IsCoMan:
    button "Complete" → send()
  if 3===mode:
    button "Complete" → complete()
dialog "Data was changed. Do you wish to skip data saving and return back to Stock Transfers list?"
dialog "Do you wish to remove product from transfer order list?"
dialog "This order contains products where required quantity is greater than their availability. Are you sure you want to authorize the order?"
```

API calls: GET /system/PickAndPack_StockTransfer; POST /system/PickAndPack_StockTransfer; /system/PickAndPack_StockTransfer

### New transfer order

Route: `/stocktransfer-new`. Component: `app-stocktransfer-new`. Navigates to: `/stocktransfer-details`, `/stocktransfer-list`.

```text
heading "Add a stock transfer" [app-form-header]
form
  input text "Required by date" (control: date; name: date; min minDate)
  if !!date.value:
    button "[close]" → date.setValue("")
  input mat-datepicker-toggle "[calendar]"
  component <mat-datepicker> [touchUi=true] → opened: datePickerOpened()
button "Save" → createTransfer() [disabled when invalid]
```

API calls: POST /system/PickAndPack_StockTransfer

### Transfer order item details

Route: `/stocktransfer-item-details`. Component: `app-stocktransfer-item-details`. Navigates to: `/stocktransfer-details`.

```text
heading "" [app-form-header]
tap area <div> → showImage(getImageUrl(line.Image))
text "{line.Name}"
text "SKU: {line.ProductCode}"
if !isPicking()&&line.BatchSN:
  text "Batch: {line.BatchSN}"
if !isPicking()&&line.ExpiryDate:
  text "Expiry: {…}"
text "{isPicking()?"Ordered":"Picked"}:"
text "{QuantityToPick}"
text "{isPicking()?"Picked":"Received"}:"
text "{TotalCollected()}"
if 0!==mode:
  form (submit → handleSearch())
    input text "searchLabel" (model: searchTerm; name: searchTerm)
    if searchTerm:
      button "[close]" → searchTerm = ""
    button "[search]"
    tap area <uom-selector> → selectedUOMChange: uomChange(e)
form
  list: rows (dataSource) show Details | Unit | Quantity | Quantity | Tools
    column Location "Details": {locationDataLabel}: {filterLocation(Location)} / [{batchTitle}: {BatchSN} if isPicking()&&BatchSN] / [Expiry: {…} if isPicking()&&ExpiryDate]
    column UnitName "Unit": {UnitName}
    column TransferQuantity "Quantity": <number input model: TransferQuantity> / [Min - {min} if null==errors?null:errors.min]
    column ReceivedQuantity "Quantity": [<number input model: ReceivedQuantity> if 0!==mode] / [{ReceivedQuantity} if 0===mode]
    column Tools: <button [trash] → removeItem(e), e = .$implicit>
if 0!==mode:
  button "Finish" → goBack() [disabled when invalid]
dialog "Total pick qty is greater than the ordered qty. Please press OK to confirm to proceed to pick or press cancel to change pick qty."
dialog "Do you wish to cancel picking changes?"
dialog "Do you wish to remove this line?"
```

API calls: none (local state only)

### Stock lookup

Route: `/stock-lookup`. Component: `app-stock-lookup`.

```text
heading "Stock lookup" [app-form-header]
input text "Enter bin or UPC code" (model: searchTerm; name: searchTerm) → keyup.enter: handleSearch()
if searchTerm:
  button "[close]" → searchTerm = ""
button "[search]" → handleSearch()
if selectedLocation&&selectedLocation.IsBin&&2===mode&&directedPutAwayInfo[selectedLocation.I:
  expansion panel:
    text "{selectedLocation.CombinedName} - {directedPutAwayInfo[selectedLocation.ID].Rules[0].Name}"
if 3==mode&&selectedProduct:
  component <app-stock-lookup-item-details-info> [info=selectedProduct]
if 0===mode:
if 1===mode:
  if datasources[mode].data.length (else i):
    list: rows (datasources[mode]) show Location | Product | Avail | Tools
      column Location: {LocationName} / [{BinName} if BinName]
      column Product: {ProductName} / {ProductCode}
      column Available "Avail": [- if Available>=0] / {Au(4 | filter}
      column Tools: [menu-arrow]
if 2===mode:
  if selectedLocation&&selectedLocation.IsBin&&2===mode&&directedPutAwayInfo[selectedLocation.I:
    for each item in directedPutAwayInfo[selectedLocation.ID].Rules:
      expansion panel:
        text "{selectedLocation.CombinedName} - {Name}"
  if datasources[mode].data.length (else i):
    for each item in datasources[mode].data:
      component <app-stock-lookup-item-details-info> [info=n]
      component <app-stock-lookup-item-details-grid> [data=Rows, paginator=i]
      component <mat-paginator> [hiddenPaginator=length<=1||length<=pageSize]
if 3===mode:
  if datasources[mode].data.length (else i):
    for each item in datasources[mode].data:
      text "{LocationName}"
      component <app-stock-lookup-item-details-grid> [data=Rows, paginator=i]
      component <mat-paginator> [hiddenPaginator=length<=1||length<=pageSize]
text "You do not have any products right now."
text "Item is not found."
if 1===mode (else n):
  component <mat-paginator> [hiddenPaginator=length<=pageSizeDynamic, pageSize=pageSizeDynamic, pageIndex=pageIndex, length=length] → page: pageChanged(e)
component <mat-paginator> [hiddenPaginator=length<=pageSize||0===mode, pageSize=pageSize, pageIndex=pageIndex, length=length] → page: pageChanged(e)
component <app-stock-lookup-item-details> [hiddenContent=!detailsSelected||!isLoaded, selected=detailsSelected] → closed: detailsSelected = null
if info:
  if MinCapacity||MaxCapacity:
    text "Capacity: {MinCapacity} - {MaxCapacity||"\u221e"}"
  if MinWeight||MaxWeight:
    text "Product weight: {MinWeight} - {MaxWeight||"\u221e"} {weightMeasure}"
  if MinWidth||MaxWidth:
    text "Product width: {MinWidth} - {MaxWidth||"\u221e"} {dimensionsMeasure}"
  if MinHeight||MaxHeight:
    text "Product height: {MinHeight} - {MaxHeight||"\u221e"} {dimensionsMeasure}"
  if MinLength||MaxLength:
    text "Product length: {MinLength} - {MaxLength||"\u221e"} {dimensionsMeasure}"
  if Products&&Products.Length:
    text "Products: {Products}"
  if Families&&Families.length:
    text "Families: {Families}"
  if Tags&&Tags.length:
    text "Tags: {Tags}"
  if Categories&&Categories.length:
    text "Categories: {Categories}"
  if Brands&&Brands.length:
    text "Brands: {Brands}"
```

API calls: GET /system/PickAndPack_StockAvailability/Search; GET /system/PickAndPack_StockAvailability/SearchProduct; GET /system/PickAndPack_StockAvailability/ByLocation
API calls via child component `app-stock-lookup-item-details`: GET /system/PickAndPack_StockAvailability/Details

## Dialogs and shared components

### Error snack bar

Component: `app-error-snack`.

```text
tap area "["push"===type?"info":type] Error" <div> → hanldeClick()
```

API calls: none (local state only)

### Generic message / confirm dialog

Component: `app-dialog`.

```text
if icon (else n):
if "WMS"===appName (else n):
if 0!=data.mode:
  if 1==data.mode:
  if 2==data.mode:
if title:
  heading "{title}"
if keyForCheckbox:
  input checkbox "{textForCheckbox}" (checked: isChecked) → change: isChecked = !isChecked
button "[close]" → handleClose()
component <mat-dialog-actions>
  button "{okButtonText}" → handleConfirm()
  if showCancelButton:
    button "{cancelButtonText}" → handleCancel()
```

API calls: none (local state only)

### Recommended batch warning dialog

Component: `app-recommend-batch-warning`.

```text
heading "{message}"
button "[close]"
component <mat-dialog-content>
  if showBatch:
    for each item in data.recommendations:
      mat-list-item "{isSimple?LocationName:BatchSN} \xa0{LocationName}"
button "{buttonText}" → ok()
```

API calls: none (local state only)

### Settings row (toggle)

Component: `app-setting`.

```text
text "{name}"
text "{description}"
input toggle (model: isEnabled)
```

API calls: none (local state only)

### Settings section

Component: `app-setting-section`.

```text
heading "{name}"
```

API calls: none (local state only)

### Camera scan button

Component: `app-camera-scan`.

```text
if show&&_enableInSettings&&(window.CameraPermission||deviceService.isSimulator)&&cameraScanS:
  button "["barcode-camera-header-dark"===icon?"barcode-camera-header":icon]" → scanBarcode(); mousedown: getLastFocus()
dialog "Please enter the quantity manually, barcode scanning is not allowed for quantity input.  [Ok]"
```

API calls: none (local state only)

### Menu item row

Component: `app-menu-item`.

```text
if !routerLink (else n):
  button "[icon] {title} [menu-arrow]" → onClick(e)
link "[icon] {title} {counter} [menu-arrow]" → navigate routerLink
```

API calls: none (local state only)

### Search input

Component: `app-search-input`.

```text
input text "placeholder" (model: ngModel; name: searchTerm) → keyup.enter: onKeyUp.emit()
if ngModel:
  button "[close]" → clear()
button "[search]" → onSearch.emit()
```

API calls: none (local state only)

### Select location dialog

Component: `app-select-location`. Opened from: Unused components transfer.

```text
heading "Select location"
button "[close]"
component <mat-dialog-content>
  if multiple (else n):
    for each item in selectedLocations:
      mat-list-item "{i[0].Name}" → selectItem(e[0]), e = .$implicit
  for each item in locations:
    mat-list-item "{Name}" → selectItem(e), e = .$implicit
button "Next" → goNext() [disabled when isDisabled]
```

API calls: none (local state only)

### Screen header bar

Component: `app-form-header`. Navigates to: `/main-menu`.

```text
heading "[back] [menu] {header.headerText} {header.headerText2} {text} [confirm] [refresh-black]"
```

API calls: none (local state only)

### Item image dialog

Component: `app-item-image-dialog`. Opened from: Picking item, Stock transfer item details, Task item, Task output.

```text
tap area "[close]" <div> → closeDialog()
```

API calls: none (local state only)

### Print document dialog

Component: `app-print-dialog`. Opened from: Transfer order list tab.

```text
heading "Print stock transfer"
text "Select document template to print"
button "[close]"
component <mat-dialog-content>
  for each item in data.templates:
    mat-list-item "{Name}" → selectTemplate(e), e = .$implicit
component <mat-dialog-actions>
  button "Print" → apply() [disabled when !selectedTemplate]
```

API calls: none (local state only)

### Product search results dialog

Component: `app-product-search-select`. Opened from: Transfer pick details.

```text
heading "Products found"
button "[close]"
component <mat-dialog-content>
  list: rows (dataSource) show Name | Name | Location | Available
    column Name: {ProductName} / SKU: {ProductCode}
    column NameComplex "Name": {Name} / [SKU: {ProductCode} if showSKU] / [Serial: {BatchSN} if isDetailed&&BatchSN] / [Expiry: {ExpiryDate | pipe} if isDetailed&&ExpiryDate]
    column Location: [{BinName} if BinName]
    column Available: {Available}
```

API calls: none (local state only)

### Push notification settings

Component: `app-push-settings`.

```text
component <app-setting-section> [name=Notification settings]
for each item in data:
  component <app-setting> [name=DisplayName, description=Description, isEnabled=IsEnabled] → isEnabledChange: .$implicit.IsEnabled=e
```

API calls: GET /system/PushSettings; POST /system/PushSettings?app=

### Operation resources list dialog

Component: `app-resources-list`. Opened from: Task item.

```text
heading "Search resources"
button "[close]"
component <mat-dialog-content>
  input text "Resource name" (model: searchNewResourceText) → keyup: searchNewResource()
  if searchNewResourceText:
    button "[close]" → searchNewResource(), searchNewResourceText = ""
  button "[search]" → searchNewResource()
  list: rows (allResourcesDataSource) show NAME
    column resname "NAME": {ResourceName} / [\xa0({ResourceCode}) if !!ResourceCode]
```

API calls: none (local state only)

### Note view dialog

Component: `app-note-view`. Opened from: Task item.

```text
heading "{data.title}"
button "[close]"
component <mat-dialog-content>
  input textarea (model: text; readonly)
if true!==data.readOnly:
  button "Save" → saveNote()
  button "Cancel"
```

API calls: none (local state only)

### Suspend operation dialog

Component: `app-suspend-dlg`. Opened from: Task item.

```text
heading "Suspend operation"
text "Do you want to stop time tracking?"
button "[close]"
component <mat-dialog-content>
  for each item in data.causes:
    mat-list-item "{Text}" → selectItem(e), e = .$implicit
button "Suspend" → suspend()
```

API calls: none (local state only)

### Resume operation dialog

Component: `app-resume-dlg`. Opened from: Task item.

```text
heading "Resume operation"
text "Do you want to resume time tracking?"
button "[close]"
component <mat-dialog-content>
  text "{data.cause?data.cause:"No cause"}"
  text "{data.date}"
button "Resume" → resume()
```

API calls: none (local state only)

### Component search dialog

Component: `app-component-search-dialog`. Opened from: Picking item, Task item.

```text
heading "Products found"
button "[close]"
component <mat-dialog-content>
  list: rows (dataSource) show Name | Name | Location | Available
    column Name: {Name} / {ProductCode}
    column NameComplex "Name": {Name} / SKU: {ProductCode} / [Serial: {BatchSN} if isDetailed&&BatchSN] / [Expire: {ExpiryDate | pipe} if isDetailed&&ExpiryDate]
    column BinName "Location": {BinName}
    column Available: {Available}
```

API calls: none (local state only)

### Additional attributes list

Component: `app-additional-attribute-list`.

```text
if attributeSet:
  text "Output Additional Attribute"
  text "(Optional)"
  for each item in attributeSetKeys:
    case AtrributeFieldTypes.date:
    case AtrributeFieldTypes.list:
      text "{attributeSet[i].Title}:"
      input mat-select "attributeSet[i].Title" "{n}" (disabled when isReadOnly; value: attributeSet[i].ResultValue) → valueChange: .$implicit;attributeSet[t].ResultValue=e
        for each item in attributeSet[i].Value:
          option "{n}"
    case AtrributeFieldTypes.text:
      text "{attributeSet[i].Title}:"
      input text "attributeSet[i].Title" (model: attributeSet[i].ResultValue; disabled when isReadOnly)
      if attributeSet[i].ResultValue:
        button "[close]" → .$implicit;attributeSet[e].ResultValue=""
    case AtrributeFieldTypes.checkbox:
      text "{attributeSet[i].Title}:"
      input checkbox (model: attributeSet[i].ResultValue; disabled when isReadOnly)
    case AtrributeFieldTypes.numeric:
      text "{attributeSet[i].Title}:"
      input number "attributeSet[i].Title" (model: attributeSet[i].ResultValue; disabled when isReadOnly) → beforeinput: handleChange(e,t)
      if attributeSet[i].ResultValue:
        button "[close]" → .$implicit;attributeSet[e].ResultValue=0
```

API calls: none (local state only)

### Serial items list

Component: `serial-items-list`.

```text
list: rows (dataSource) show name | quantity | wastage-quantity | tools | expander
```

API calls: none (local state only)

### Batch/serial mapping details

Component: `app-finished-component-mapping-details`.

```text
heading (dynamic) [app-form-header]
input text "Scan batch/serial #" (model: batchValue; name: batch) → keyup.enter: handleBatch()
form
  list: rows (dataSource) show component | batch | tools
  if 0===dataSource.data.length&&selected:
  button "+ Add Line" → addLine()
button "Save" → save() [disabled when invalid]
```

API calls: none (local state only)

### Edit serial item dialog

Component: `app-edit-serial-item`.

```text
heading "Edit item" [app-form-header]
input mat-select "Selected location" "[default] {locationSelectorItem.value.LocationName} [default] {LocationName} (default location)" (control: locationSelectorItem; required)
  if !!locationSelectorItem.value&&locationSelectorItem.value.IsDefault:
  if !!locationSelectorItem.value:
    text "{locationSelectorItem.value.LocationName}"
  for each item in locations:
    option "[default] {LocationName} (default location)"
if isShowAdditionalAttributes:
  component <app-additional-attribute-list>
input text "Batch/Serial #" (model: batchsnValue; name: Batch) → keyup.enter: submitBatch(); keyup.tab: submitBatch(); blur: submitBatch()
if batchsnValue:
  button "[close]" → batchsnValue = ""
input text "Expiry Date" (model: internalItem.ExpiryDate; name: scan-expired; min minDate)
if !!internalItem.ExpiryDate:
  button "[close]" → internalItem.ExpiryDate=null
input mat-datepicker-toggle "[calendar]"
component <mat-datepicker> [touchUi=true]
if invalid&&errors.matDatepickerMin:
  error "Expiry date cannot be in the past."
button "Delete" → delete.emit(), close.emit()
button "Save" → save() [disabled when expiryRequired&&!internalItem.ExpiryDate||!internalItem.BatchSN]
```

API calls: none (local state only)

### Location dropdown

Component: `app-location-dropdown`.

```text
input mat-select "{Name}" (model: null==selected?null:selected.ID; value: null==selected?null:selected.ID) → selectionChange: onValueChange(e); ngModeChange: ngForm.form.updateValueAndValidity()
  for each item in locations:
    option "{Name}"
if showErrors&&invalid&&errors.required:
  error "Select a location"
```

API calls: none (local state only)

### Scheduler filters dialog

Component: `app-scheduler-filters`. Opened from: Scheduler.

```text
tap area "Reset" <span> → clearFilters()
heading "Filters ({data.data.filterCount})"
button "[close]"
component <mat-dialog-content>
  input mat-select "Select date mode" "{name}" (required; value: data.data.selectedDateMode) → valueChange: data.data.selectedDateMode=e; selectionChange: onDateModeSelect()
    for each item in data.data.dateModes:
      option "{name}"
  if ![list].includes(data.data.selectedDateMode):
    input text "From date" (control: fromDateCtrl; readonly; required; disabled when "Custom"!==data.data.selectedDateMode)
    input mat-datepicker-toggle "[calendar]"
    component <mat-datepicker> [touchUi=true]
    input text "To date" (control: toDateCtrl; readonly; required; disabled when "Custom"!==data.data.selectedDateMode)
    input mat-datepicker-toggle "[calendar]"
    component <mat-datepicker> [touchUi=true]
  heading "Work center"
  for each item in data.data.workCenters:
    input checkbox "{Name}: {Code}" (model: Selected)
  heading "Resources"
  for each item in data.data.resources:
    input checkbox "{Name}" (model: isSelected)
  if "production"===mode:
    heading "Buffer"
    for each item in data.data.buffers:
      input checkbox "{name}" (model: Selected)
button "Apply" → applyFilters()
```

API calls: none (local state only)

### Scheduler columns / layout dialog

Component: `app-scheduler-layout`. Opened from: Scheduler.

```text
heading "Layout settings"
button "[close]"
component <mat-dialog-content>
  text "Layout settings that have been selected or deselected will be immediately reflected and saved until you next make edits."
  heading "Layout"
  input mat-radio-group "{name}" (model: data.data.tableLayoutData.selectedValue)
    for each item in data.data.tableLayoutData.valueOptions:
      input mat-radio-button "{name}" (value: value)
  heading "Chart view"
  for each item in data.data.chartLayoutData:
    if !mode||mode&&mode===mode:
      input checkbox "{name}" (model: value)
  heading "View"
  input mat-radio-group "{name}" (model: data.data.timeLayoutData.view.selectedValue)
    for each item in data.data.timeLayoutData.view.valueOptions:
      input mat-radio-button "{name}" (value: value)
button "Apply" → applyColumnChanges()
```

API calls: none (local state only)

### Scheduler task popup

Component: `app-scheduler-gantt-task`. Opened from: Scheduler.

```text
heading "{null==header?null:header.label} - {null==header?null:header.value}"
button "[close]"
component <mat-dialog-content>
  if err:
    text "{err}"
  for each item in data:
    text "{null==n?null:label}"
    text "{null==n?null:value}"
```

API calls: none (local state only)

### Capacity lookup filters dialog

Component: `app-capacity-lookup-filters`.

```text
tap area "Reset" <span> → clearFilters()
heading "Filters ({data.data.filterCount})"
button "[close]"
component <mat-dialog-content>
  heading "Date range"
  input text "From date" (model: handleChangeFilter(); control: fromDateCtrl; readonly; required)
  input mat-datepicker-toggle "[calendar]"
  component <mat-datepicker> [touchUi=true]
  input text "To date" (model: handleChangeFilter(); control: toDateCtrl; readonly; required)
  input mat-datepicker-toggle "[calendar]"
  component <mat-datepicker> [touchUi=true]
  input toggle "Show overallocated" (model: data.data.isShowOverAllocated)
  heading "Resources"
  for each item in data.data.resources:
    input checkbox "{Name}" (model: isSelected)
button "Apply" → applyFilters()
```

API calls: none (local state only)

### Capacity lookup columns dialog

Component: `app-capacity-lookup-columns`. Opened from: Capacity lookup.

```text
heading "Table columns"
button "[close]"
component <mat-dialog-content>
  text "Column(s) that have been selected or deselected will be immediately reflected and saved till you edit again."
  for each item in data.data:
    if !isFixed:
      input checkbox "{columnName}" (model: isChecked)
button "Apply" → applyColumnChanges()
```

API calls: none (local state only)

### Capacity lookup allocated detail dialog

Component: `app-capacity-lookup-allocated-detail`. Navigates to: `/scheduler`.

```text
button "[table-chart]"
for each item in totalRowData:
  tap area "{name}" <div> → stopPropagation()
heading "Allocated capacity"
button "[close]"
component <mat-dialog-content>
  input text "search by MO#" (model: searchTerm; name: searchTerm) → keyup.enter: searchData()
  if searchTerm:
    button "[close]" → searchData(), searchTerm = ""
  button "[search]" → searchData()
  text "Total orders:"
  text "{dataSource.data.length}"
  list: rows (dataSource) show Order # | SaleOrderNumber | Customer | Finished product | Sales representative | Release date | Planned date | Required by date | Allocated capacity | ViewDetails
    column ProductionOrderNumber "Order #": Order # / {ProductionOrderNumber}
    column SaleOrderNumber: Sale order # / {SaleOrderNumber}
    column CustomerName "Customer": Customer / {CustomerName}
    column ProductName "Finished product": Finished product / {ProductName}
    column SalesRepresentative "Sales representative": Sales representative / {SalesRepresentative}
    column ReleaseDate "Release date": Release date / {ReleaseDate}
    column StartDate "Planned date": Planned date / {StartDate | pipe}
    column RequiredByDate "Required by date": Required by date / {RequiredByDate | pipe}
    column Capacity "Allocated capacity": Allocated capacity / {Capacity | filter}
    column ViewDetails: [<button Open scheduler → goToScheduler(ProductionOrderNumber)> if isMobile&&[list].includes(Status)] / [<button [external-link]> if !isMobile&&[list].includes(Status)]
```

API calls: none (local state only)

### HTML viewer dialog

Component: `app-html-viewer-dialog`.

```text
component <mat-dialog-content>
component <mat-dialog-actions>
  button "Close"
```

API calls: none (local state only)

### PDF viewer dialog

Component: `app-pdf-viewer-dialog`.

```text
component <mat-dialog-content>
component <mat-dialog-actions>
  button "Close"
```

API calls: none (local state only)

### Transfer order sort dialog

Component: `app-stocktransfer-list-sort-dialog`. Opened from: Transfer order list tab.

```text
button "Apply" → apply()
heading "Sort by"
button "[close]"
component <mat-dialog-content>
  heading "Sort field"
  input mat-radio-group "Transfer Order Number Transfer Order Date" (model: sortField)
    input mat-radio-button "Transfer Order Number"
    input mat-radio-button "Transfer Order Date"
  heading "Sort direction"
  input mat-radio-group "Ascending Descending None" (model: sortDirectionField)
    input mat-radio-button "Ascending"
    input mat-radio-button "Descending"
    input mat-radio-button "None"
```

API calls: none (local state only)

### Transfer order list tab

Component: `app-stocktransfer-list-tab`.

```text
input text "Type Order #, or scan UPC code" (model: searchTerm; name: searchTerm) → keyup.enter: LoadData()
if searchTerm:
  button "[close]" → searchTerm = ""
button "[search]" → LoadData()
list: rows (dataSource) show Order # Date | From | To | Status | Expander
  column NumberDate "Order # Date": {Number} / {CreatedDate}
  column From: {FromLocation}
  column To: {ToLocation}
  column Status: {StatusText}
  column Expander: [[expand] if !Expanded] / [[collapse] if true===Expanded]
component <mat-paginator> [pageSize=pageSize, pageIndex=pageIndex] → page: LoadData()
text "User"
text "{LastUpdatedBy}"
button "[print]" → print(e), e = .$implicit
button "Undo" → undo(e), e = .$implicit
button "Void" → void(e), e = .$implicit
dialog "This will reverse all transfers and change the transfer status to draft. Would you like to proceed anyway?"
dialog "Would you like to void stock transfer?"
```

API calls: GET /system/PickAndPack_StockTransferList; DELETE /system/PickAndPack_StockTransfer; POST /system/PickAndPack_PdfPrint

### Transfer order search dialog

Component: `app-stocktransfer-search-dialog`. Opened from: Stock transfer details, Stock transfer item details.

```text
heading "{isLocations()?"Locations found":"Products found"}"
button "[close]"
component <mat-dialog-content>
  list: rows (dataSource) show Name | Name | Location | {isLocations()?"Current Qty":"Available"}
    column Name: {Name} / SKU: {ProductCode}
    column NameComplex "Name": {Name} / SKU: {ProductCode} / [Serial: {BatchSN} if isDetailed&&BatchSN] / [Expiry: {ExpiryDate | pipe} if isDetailed&&ExpiryDate]
    column Location: [{ParentLocation} if !BinLocation] / [{BinLocation} if BinLocation]
```

API calls: none (local state only)

### Stock lookup item info panel

Component: `app-stock-lookup-item-details-info`.

```text
image info.Image | pipe,aa
text "{info.ProductName}"
text "{info.ProductCode}"
if info.Barcode:
  text "UPC: {info.Barcode}"
if info.Unit:
  text "UOM: {info.Unit}"
```

API calls: none (local state only)

### Stock lookup item details grid

Component: `app-stock-lookup-item-details-grid`.

```text
list: rows (dataSource) show BatchSN | SOH | Avail | On order | Allocated
  column BatchSN: {BatchSN||"N/A"} / [({ExpiryDate | pipe}) if ExpiryDate]
  column OnHand "SOH": [- if OnHand>=0] / {Au(4 | filter}
  column Available "Avail": [- if Available>=0] / {Au(4 | filter}
  column OnOrder "On order": [- if OnOrder>=0] / {Au(4 | filter}
  column Allocated: [- if Allocated>=0] / {Au(4 | filter}
```

API calls: none (local state only)

### Stock lookup item details

Component: `app-stock-lookup-item-details`.

```text
heading "Item details" [app-form-header]
if info:
  component <app-stock-lookup-item-details-info> [info=info]
if data&&data.length:
  text "{info.LocationName}"
  component <app-stock-lookup-item-details-grid> [data=data] → sortChanged: sortChange(e)
component <mat-paginator> [hiddenPaginator=length<=pageSize&&1!==length, pageSize=pageSize, pageIndex=pageIndex, length=length] → page: pageChanged(e)
```

API calls: GET /system/PickAndPack_StockAvailability/Details; GET /system/PickAndPack_StockAvailability/Search
