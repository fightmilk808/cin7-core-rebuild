## Screens

Source: the Angular (Ivy, Material) app inside the Cordova bundle, `www/en-US/main.*.js` (compiled; templates are read from the component definitions, UI strings are the English build). Routes come from the router configuration in that file (`path:"..."` entries; `/` redirects to `/login`). A few components serve two routes with a route-data flag, and the stock-transfer item-details screen serves two child routes. Every screen shows a top header bar (`app-form-header`: back button, title, optional menu/confirm/refresh icons).

Server access: base `https://inventory.dearsystems.com`; every call is sent to `/ExternalApi` plus the path shown in the "API calls" lines (`/system/...` handheld namespace, `/v2/...` public API). Sign-in is `POST /system/login`; later calls carry the account id, application key, user id and user name as headers. Menu items check a permission name (the second argument to `checkAccessPermission`) before navigating.

**Navigation map**

```text
Sign in (/login: email + password, Google, Microsoft, biometrics, reset password)
  -> Working area (/working-area: organization, location, zones, bin groups)
  -> Main menu (/main-menu)

Main menu items (permission name in brackets), top to bottom:
  Pick [sale_index]            -> /pick -> /select-totes (when several orders and totes are used) -> /picking-list -> /picking-item
  Pack [sale_index]            -> /pack -> /packing-list (dialogs: pack box, carrier, package number)
  Receive                      -> /receive-menu
      With PO [purchase_index]     -> /receive-with-po -> /receive-list -> /receive-item (-> /receive-to-bin)
      Without PO                   -> /receive-without-po-clean -> /receive-without-po (choose supplier) -> /receive-list-wpo -> /receive-item
      Bin transfer [stocktransfer_index] -> /warehouse-transfer -> /put-away-item-transfer
  Put away (only if the organization uses put-away) -> /put-away-list-clean -> /put-away-item
  Restock [sale_index]         -> /restock -> /restock-list -> /restock-item
  Stocktake [stocktake_index]  -> /stocktake -> /stocktake-criteria (-> /stocktake-criteria-edit) -> /stocktake-list -> /stocktake-item
  Stock lookup [stock_index]   -> /stock-lookup
  Stock transfer [stocktransfer_index] -> /transfer-menu
      From location / To location -> /pick-location-list -> /transfer-to-pick or /transfer-to-put (each with /details) -> /put-away-select-location
      By order                    -> /stocktransfer-list -> /stocktransfer-details or /stocktransfer-new -> /stocktransfer-item-details
  Write off [issuetoproduction_index] -> /write-off -> /write-off-new -> /write-off-list -> /write-off-item
  Delivery schedule [tasksettings_onlyassigned] -> /delivery -> /delivery-details or /delivery-route
  Working area                 -> /working-area
  Print labels [product_index] -> /print-labels-search -> /print-labels-layout
  Open POS                     -> opens the web POS in the browser
  Settings                     -> /about
  Log out                      -> /login
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
heading "Sign In to WMS"
form (submit → submit(u), u = #ref)
  if configService.isDebug:
    input text "URL" (model: url)
    if url:
      button "[close]" → url = ""
  input email "Email" (name: UserName; required)
  if value:
    button "[close]" → ref.reset()
  if dirty&&touched&&errors&&errors.email&&!isEmailFocused():
    error "Please enter a valid email address"
  input type: showPassword?"text":"password" "Password" (name: Password; required) → copy: preventDefault()
  if value:
    button "[showPassword?"password-hide":"password-show"]" → showPassword = !showPassword
  if value:
    button "[close]" → ref.reset()
  if !isDeviceRooted:
    link "Reset password" → resetPassword()
  button "Login" [disabled when invalid||isDeviceRooted]
text "OR"
if deviceInfoService.isAndroid:
  button "[google-logo] Sign in with Google" → googleLogin() [disabled when isDeviceRooted]
button "[ms] Sign in with Microsoft" → msalLogin() [disabled when isDeviceRooted]
if isBioAvailable:
  button "[face-scan] Sign in with biometrics" → biometricLogin() [disabled when isDeviceRooted]
```

API calls: POST /system/login

### Working area

Route: `/working-area`. Component: `app-working-area`. Navigates to: `/login`, `/main-menu`.

```text
heading "Working area" [app-form-header]
input mat-select "Organizations" "{Company}" (required; disabled when !loginService.tenants||1===loginService.tenants.length; value: selectedOrganization) → valueChange: selectedOrganization = a; selectionChange: changeOrganization(a)
  for each item in loginService.tenants:
    option "{Company}"
input mat-select "Locations" "{Name}" (required; disabled when !locations.length; value: selectedLocation) → valueChange: selectedLocation = a; selectionChange: changeLocation(a)
  for each item in locations:
    option "{Name}"
input mat-select "Zones" "All zones All zones {n}" (required; disabled when !zones.length||!isAdvancedWMS; value: selectedZones) → valueChange: selectedZones = a
  if selectedZones&&isAllSelected():
    text "All zones"
  option "All zones" → click: masterToggle()
  for each item in zones:
    option "{n}" → click: zoneToggle()
if !isAdvancedWMS&&selectedOrganization:
  text "Zone picking is only available in Advanced WMS"
if selectedLocation:
  label "Bin groups"
  input mat-select "All groups" "{Name}" (disabled when !(null!=selectedLocation&&null!=selectedLocation.BinGroups&&selectedLocation.BinGroups.length); value: selectedBinGroups) → valueChange: selectedBinGroups = a
    for each item in selectedLocation.BinGroups:
      option "{Name}"
button "Next" → handleConfirm() [disabled when !selectedOrganization||!selectedLocation||!(null!=selectedZones&&selectedZones.l]
dialog "Do you want to enable biometric sign-in for user   [No]"
```

API calls: GET /system/Locations2; GET /system/PickAndPack_Configuration; GET /system/PickAndPack_StocktakeProducts

### Main menu

Route: `/main-menu`. Component: `app-main-menu`. Navigates to: `/login`.

```text
heading (dynamic) [app-form-header]
menu item "Pick" → checkAccessPermission("pick","sale_index")
menu item "Pack" → checkAccessPermission("pack","sale_index")
menu item "Receive" → navigate /receive-menu
if true===configService.organizationSettings.UsePutAway:
  menu item "Put away" → navigate /put-away-list-clean
menu item "Restock" → checkAccessPermission("restock","sale_index")
menu item "Stocktake" → checkAccessPermission("stocktake","stocktake_index")
menu item "Stock lookup" → checkAccessPermission("stock-lookup","stock_index")
menu item "Stock transfer" → checkAccessPermission("transfer-menu","stocktransfer_index",1)
menu item "Write off" → checkAccessPermission("write-off","issuetoproduction_index")
menu item "Delivery schedule" → checkAccessPermission("delivery","tasksettings_onlyassigned")
menu item "Working area" → navigate /working-area
menu item "Print labels" → checkAccessPermission("print-labels-search","product_index")
menu item "Open POS" → openPOS()
menu item "Settings" → navigate /about
menu item "Log out" → logOut()
```

API calls: none (local state only)

### Pick: order search

Route: `/pick`. Component: `app-pick`. Navigates to: `/picking-list`, `/select-totes`.

```text
heading "Pick" [app-form-header]
if !isLandscapeMode:
  form
list: rows (dataSource) show select | Order # | # of items | Customer name
  column select: <mat-checkbox input>
  column OrderNo "Order #": {OrderNo}
  column TotalProductQty "# of items": {TotalProductQty}
  column CustomerName "Customer name": {CustomerName}
component <mat-paginator> [pageSize=pageSize, pageIndex=pageIndex] → page: handleSearch(!0)
button "Start {selectedCounter()}" → handleConfirm() [disabled when 0==selectedCounter()]
```

API calls: GET /v2/sale; GET /v2/sale/fulfilment; /system/PickAndPack_Tots; POST /system/PickAndPack_PickList

### Pack: order search

Route: `/pack`. Component: `app-pack`. Navigates to: `/packing-list`.

```text
component <app-search-field> [placeholder="Enter order # or tote #", searchTerm=searchTerm] → searchTermChange: searchTerm = a; search: handleSearch()
heading "Pack" [app-form-header]
if !isLandscapeMode:
if !!selectedPackOrder:
  if !!selectedPackOrder:
    text "Order #"
    text "{selectedPackOrder.OrderNumber}"
    if !!selectedPackOrder&&!!selectedPackOrder.Customer:
      text "Customer"
      text "{selectedPackOrder.Customer}"
  if dataSourceTots.data.length&&useTotes:
    list: rows (dataSourceTots) show Order totes
      column tot "Order totes": {tot}
if !selectedPackOrder&&!!searchData:
  if dataSourceSearchResults.data.length:
    list: rows (dataSourceSearchResults) show Order number | Customer name
      column OrderNumber "Order number": {2===Type?OrderNumber+" ("+FulfillmentNumber+")":OrderNumber}
      column Customer "Customer name": {Customer}
if !selectedPackOrder&&!!searchData:
  component <mat-paginator> [pageSize=pageSize, pageIndex=page-1, length=totalRows] → page: handleSearch(!0)
button "Start" → handleConfirm() [disabled when 0===dataSourceTots.data.length]
```

API calls: GET /v2/sale/fulfilment/pick; PUT /system/PickAndPack_FulfilmentPick; /system/PickAndPack_Tots; GET /system/PickAndPack_Tots

### Receive with PO: PO search

Route: `/receive-with-po`. Component: `app-receive-with-po`. Navigates to: `/receive-menu`.

```text
component <app-search-field> [placeholder="Search by PO #", searchTerm=searchTerm] → searchTermChange: searchTerm = a; search: handleSearch()
heading "PO search" [app-form-header]
if !isLandscapeMode:
  form
list: rows (dataSource) show CheckBoxColumn | Order # | Supplier | By date
  column CheckBoxColumn: <mat-checkbox input>
  column OrderNumber "Order #": {OrderNumber}
  column Supplier: {Supplier}
  column OrderDate "By date": {OrderDate}
component <mat-paginator> [pageSize=pageSize] → page: reloadData(a)
button "Finish" → goItemsList() [disabled when !selection.hasValue()]
```

API calls: GET /system/PickAndPack_ListOfPurchases

### Receive without PO: choose supplier

Routes: `/receive-without-po`, `/receive-without-po-clean` (route data {clearStorage:true}). Component: `app-receive-without-po`. Navigates to: `/receive-menu`.

```text
heading "Select supplier" [app-form-header]
input text "Supplier" (model: supplierValue; control: supplierCtrl; name: searchTerm; required) → keyup: onKeydown(o); keyup.enter: onCheckSupplier(o)
if !!supplierValue:
  button "[close]" → supplierValue = null
component <mat-autocomplete> [displayWith=displayFn]
  for each item in filteredSuppliers | pipe:
    option 
button "Load product data" → handleLoadProducts()
if !!dataContainer&&!!dataContainer.Products&&dataContainer.Products.length>0:
  text "{dataContainer.Products.length} products were loaded on {dataContainer.LoadDate}."
if isSuppliersMoreThanGot:
  text "Suppliers list contains first 50 records only."
button "Start" → handleStart() [disabled when null===supplierValue]
```

API calls: GET /v2/supplier; GET /system/PickAndPack_ReceiveListWPO

### Pick: select totes

Route: `/select-totes`. Component: `app-select-totes`. Navigates to: `/pick`, `/picking-list`.

```text
heading "Select totes" [app-form-header]
component <app-time-tracking> [autoStart=initCompleted, mode=1, sales=orders]
form
  list: rows (ordersDataSource) show Order # | Tote #
    column order "Order #": {OrderNo}
    column tote "Tote #": <input input model: ToteNumber> / [<button [close] → $implicit.ToteNumber=""> if ToteNumber] / [Tote# is mandatory if null==errors?null:errors.required] / [Tote# should be unique if null==errors?null:
button "Begin picking" → onBeginPicking(l), l = #ref [disabled when invalid]
```

API calls: GET /v2/sale; GET /v2/sale/fulfilment; /system/PickAndPack_Tots
API calls via child component `app-time-tracking`: POST /system/PickAndPack_TimeTrackingSession; PUT /system/PickAndPack_TimeTrackingSession; DELETE /system/PickAndPack_TimeTrackingSession

### Pick: picking list

Route: `/picking-list`. Component: `app-picking-list`. Navigates to: `/pick`, `/picking-item`.

```text
heading (dynamic) [app-form-header]
input text "Enter item # or scan UPC code" (model: searchTerm; name: searchTerm) → keyup.enter: onSearch()
if searchTerm:
  button "[close]" → searchTerm = ""
button "[search]" → onSearch()
if searchError:
  error "{searchError}"
component <app-time-tracking> [mode=1, sales=pickService.state.selectedOrders, autoStart=true]
for each item in items:
  mat-list-item "{Code} {Description} To tote: {OrderData.ToteNumber} Pick from: N/A {RecommendedBinName} {e||"N/A"} , Pick from: {e||"N/A"} , Sale order #: {OrderData.OrderNo} Remain: {Remain} Picked: {Picked} {getItemStatusValue(Status)}" → onItemClick(l), l = .$implicit
button "Finish" → handleFinish() [disabled when !isFinishEnabled()]
dialog "Are you sure you want to cancel picking? All information will be lost."
dialog "<h3>There are still unpicked items in the list. Are you sure you want to finish picking?</h3>"
```

API calls: /system/PickAndPack_FulfilmentPick; POST /system/PickAndPack_PickList; /system/PickAndPack_Tots; DELETE /system/PickAndPack_FulfilmentPick
API calls via child component `app-time-tracking`: POST /system/PickAndPack_TimeTrackingSession; PUT /system/PickAndPack_TimeTrackingSession; DELETE /system/PickAndPack_TimeTrackingSession

### Pack: packing list

Route: `/packing-list`. Component: `app-packing-list`. Navigates to: `/pack`.

```text
heading "" [app-form-header]
input text "Enter item # or scan UPC code" (model: searchTerm; name: searchTerm) → keyup.enter: onSearch()
if searchTerm:
  button "[close]" → searchTerm = ""
button "[search]" → onSearch()
component <app-time-tracking> [mode=2, autoStart=initCompleted, hidden=!initCompleted, sales=sales]
for each item in displayItems:
  mat-list-item "{SKU} {Name} Packed: {PackQuantity,"1.0-4"} Picked: {Quantity} Package# {Box}: Qty\xa0 {Quantity} {StatusName}" → showQuantityDialog(o), o = .$implicit
button "Cancel" → handleUndo() [disabled when isSaving||!isUndoEnabled()]
button "{…}" → handleConfirmNextBox() [disabled when isSaving||!isFinishEnabled()]
dialog "<h3>Are you sure?</h3>"
dialog "Are you sure you want to continue to the next order?"
dialog "{…}Are you sure to continue shipping?"
dialog "Shipping was not authorized automatically.<br/>You need to complete shipping in {…} manually."
dialog "You have unprocessed shipment. Are you sure you want pack another package?"
```

API calls: GET /system/PickAndPack_PackageManagement; GET /v2/sale/fulfilment/pick; GET /system/PickAndPack_Pack; POST /system/PickAndPack_UOM; POST /system/PickAndPack_Pack; POST /system/PickAndPack_Ship; POST /system/PickAndPack_PackageManagement; PUT /v2/sale/fulfilment/ship
API calls via child component `app-time-tracking`: POST /system/PickAndPack_TimeTrackingSession; PUT /system/PickAndPack_TimeTrackingSession; DELETE /system/PickAndPack_TimeTrackingSession

### Pick: item details

Route: `/picking-item`. Component: `app-picking-item`. Navigates to: `/picking-list`.

```text
heading "" [app-form-header]
component <app-time-tracking> [mode=1, sales=pickService.state.selectedOrders]
if pickItem.Image:
  tap area <div> → showImage(getImageUrl(pickItem.Image))
if !pickItem.Image:
  image assets/img/PosImages/image-placeholder.png
text "{pickItem.Code}"
text "{pickItem.Description}"
text "Pick:"
text "{pickItem.Quantity}"
if pickItem.PickFrom:
  text "Pick from:"
  if !recommendBatchSN:
    for each item in pickItem.PickFrom:
      text "{e||"N/A"}"
      if n<pickItem.PickFrom.length-1:
        text ","
  if recommendBatchSN:
    if pickItem.RecommendedBinID (else e):
      text "{pickItem.RecommendedBinName}"
    text "{e||"N/A"}"
    if n<pickItem.PickedFrom.length-1:
      text ","
if pickService.selectedOrders.length>1&&useTotes:
  text "To tote:"
  text "{pickItem.OrderData.ToteNumber}"
text "Picked:"
text "{pickItem.Picked}"
text "Remain:"
text "{pickItem.Remain}"
if pickItem.Comment&&pickItem.Comment.length>0:
  image assets/img/PosImages/info.svg
  text "{pickItem.Comment}"
if pickItem.PickFrom&&pickItem.PickFrom.length>0:
  input text "Bin" (model: binValue; name: Bin) → scanInput: handleBin()
  button "Bin empty" → handleBin(), binValue = ""
if isSimple():
  input text "Scan barcode / enter item #" (model: itemValue; name: scan-number) → scanInput: handleItem(); keyup.tab: handleItem()
  if itemValue:
    button "[close]" → itemValue = ""
  if itemError:
    error "{itemError}"
if isBatch():
  input text "Batch #" (model: batchValue; name: scan-number) → scanInput: handleBatch(); keyup.tab: handleBatch()
  if batchValue:
    button "[close]" → batchValue = ""
if isSerial():
  input text "Serial #" (model: serialValue; name: scan-number) → scanInput: handleSerial(); keyup.tab: handleSerial()
  if serialValue:
    button "[close]" → serialValue = ""
if pickService.selectedOrders.length>1&&useTotes:
  input text "Tote" (model: toteValue; name: Tote) → scanInput: handleTote(); keyup.tab: handleTote()
  if toteValue:
    button "[close]" → toteValue = ""
  if toteError:
    error "{toteError}"
tap area <uom-selector> → selectedUOMChange: uomChange(o)
if pickItem.PickedItems.length:
  heading "Picked items"
  list: rows (dataSource) show Details | Bin | Qty | {quantityHeader} | tools
    column details "Details": [{Unit} if pickItem.isVirtual] / [{Unit} @ {Bin||"N/A"} if !pickItem.isVirtual] / [Batch #: {BatchNumber} if isBatch()] / [Serial #: {SerialNumber} if isSerial()] / [Expiry: {FormattedExpiryDate} if F
    column bin "Bin": {Bin||"N/A"}
    column virtualQuantity "Qty": {VirtualQuantity}
    column quantity "{quantityHeader}": <number input model: Quantity> / [Min. allowed - {BatchNumber?0:1} if null==errors?null:errors.min]
    column tools: <button [trash] → removePickedItem(a), a = .$implicit>
if pickItem.Remain (else i):
  if !disablePartialPick (else e):
    button "Pick partially" → pickPartially() [disabled when !pickItem.PickedItems.length||isAnyQuantityInvalid]
  button "Cancel" → cancel()
button "Finish" → finish() [disabled when isAnyQuantityInvalid]
dialog "<h3>Current bin will be marked as empty.<br/>Are you sure?</h3>"
dialog "<h3>Are you sure you want to remove this item from the picked list?</h3>"
```

API calls: none (local state only)
API calls via child component `app-time-tracking`: POST /system/PickAndPack_TimeTrackingSession; PUT /system/PickAndPack_TimeTrackingSession; DELETE /system/PickAndPack_TimeTrackingSession

### Receive menu

Route: `/receive-menu`. Component: `app-receive-menu`. Navigates to: `/receive-without-po-clean`.

```text
heading "Receive menu" [app-form-header]
link "With PO [menu-arrow]" → checkAccessPermission("receive-with-po","purchase_index")
link "Without PO [menu-arrow]" → chooseReceiveWithoutPOLink()
link "Bin transfer [menu-arrow]" → checkAccessPermission("warehouse-transfer","stocktransfer_index")
```

API calls: GET /v2/supplier

### Receive: item list

Routes: `/receive-list`, `/receive-list-wpo` (route data {wpo:true}). Component: `app-receive-list`. Navigates to: `/receive-item`, `/receive-menu`, `/receive-to-bin`, `/receive-with-po`, `/receive-without-po`.

```text
heading "" [app-form-header]
if isWithoutPO():
  text "{orders[0].Supplier}"
  text "{productLoadedInfoText}"
  button "[refresh]" → handleGoBack(!0)
input text "Enter item # or scan UPC code" (model: searchTerm; name: searchTerm) → keyup.enter: onSearch()
if searchTerm:
  button "[close]" → searchTerm = ""
button "[search]" → onSearch()
for each item in displayItems:
  mat-list-item "{Name} SKU: {SKU} Receive To: {ReceiveTo} Received: {TotalProductReceivedQuantity} Remain: {TotalProductRemainQuantity} {getItemStatusValue(e)}" → goToDetails(s,null,!1,!1), s = .$implicit
if isDirectedPutAwayEnabled&&!isWithoutPO():
  button "Print receiving list" → printToReceiveList() [disabled when !(currentReceiveMap&&currentReceiveMap.size>0)]
button "Save" → handleSaveDlg() [disabled when !isSaveEnabled()]
dialog "All receiving information will be lost. Are you sure?"
dialog "Are you sure?"
dialog "Receiving data has been changed by another user. Do you want to force saving?  [Yes / No]"
```

API calls: GET /system/PickAndPack_ReceiveList; GET /v2/advanced-purchase/put-away; GET /v2/advanced-purchase/stock; POST /system/PickAndPack_Bins/GetDirectPutAwaySuggestedBins; POST /v2/advanced-purchase; GET /system/PickAndPack_Configuration; GET /v2/advanced-purchase/invoice; POST /v2/advanced-purchase/put-away; POST /v2/advanced-purchase/stock; POST /system/DEARMan_PutAwayList/PrintReceiveTo

### Receive: item details

Route: `/receive-item`. Component: `app-receive-item`. Navigates to: `/receive-list`.

```text
heading "" [app-form-header]
if receiveContainer.ReceiveItem.Image:
  tap area <div> → showImage(getImageUrl(receiveContainer.ReceiveItem.I...)
if !receiveContainer.ReceiveItem.Image:
  image assets/img/PosImages/image-placeholder.png
text "{receiveContainer.ReceiveItem.SKU}"
text "{receiveContainer.ReceiveItem.Name}"
if binValue:
  text "Receive to"
  text "{binValue}"
if !binValue:
  text "Receiving @"
  text "{receiveContainer.Location}"
text "Received:"
text "{sumReceived}"
if !isWithoutPO():
  text "Remain:"
  text "{sumRemain}"
if showBin&&!isDirectedPutAwayEnabled:
  input text "Bin" (model: binValue; name: scan-bin) → keyup.enter: handleBin(); keyup.tab: handleBin()
  if binValue:
    button "[close]" → binValue = ""
if isDirectedPutAwayEnabled:
  input mat-select "Bin" "{getBinName(e)}" (model: binID; name: binSelector; required; disabled when !availableBins.length) → valueChange: selectedBinValueChanged(a)
    for each item in availableBins:
      option "{getBinName(e)}"
if "FIFO"===costingMethod:
  input text "Item #" (model: itemValue; name: scan-number) → keyup.enter: handleItem(); keyup.tab: handleItem()
  if itemValue:
    button "[close]" → itemValue = ""
if "FIFO"!==costingMethod:
  input text "Expired" (control: date; name: scan-expired) → blur: onExpiryBlur(value), o = #ref
  input mat-datepicker-toggle "[calendar]"
  if !!date.value:
    button "[close]" → date.setValue("")
  component <mat-datepicker> [touchUi=true] → closed: datePickerClosed()
  if (null==date.errors?null:date.errors.matDatepickerParse)||(null==date.errors?null:date.erro:
    error "{getExpiryError()}"
if "FIFO"!==costingMethod:
  input text "costingLabel" (model: batchValue; name: scan-batch) → keyup.enter: handleBatchSerial(); keyup.tab: handleBatchSerial()
  if batchValue:
    button "[close]" → batchValue = ""
tap area <uom-selector> → selectedUOMChange: uomChange(a)
if receiveContainer.ListItems.length:
  heading "Received items"
  list: rows (dataSource) show Details | Quantity | tools
    column details "Details": {getUnitOfMeasureByProductID(ProductID)} / [Bin: / {e | filter} if BinID] / {e,BinID} / [{costingLabel}: / {BatchSN} if BatchSN] / [Expiry: / {getFormattedDate(ExpiryDate)} if ExpiryDate]
    column quantity "Quantity": <number input model: ReceiveQuantity> / [Min. allowed / - {minQuantity} if null==errors?null:errors.min] / [Max. allowed / - {maxQuantity} if null==errors?null:errors.max]
    column tools: <button [trash] → removeReceivedItem(a,o), i = a=i.$implicit, o = index>
if "FIFO"===costingMethod&&sumRemain>=0:
  button "Receive all ({sumRemain})" → receiveAll() [disabled when sumRemain<=0||isAnyQuantityInvalid]
if sumRemain>0:
  button "Receive partially" → receivePartially() [disabled when sumRemain<=0||0===sumReceived||isAnyQuantityInvalid]
if sumRemain<=0:
  button "Finish" → receiveFinish() [disabled when isAnyQuantityInvalid]
dialog "This bin is not found. Are you sure to create it?"
dialog "Are you sure you want to complete partial receiving?"
```

API calls: POST /v2/ref/location

### Stocktake: list

Route: `/stocktake`. Component: `app-stocktake`. Navigates to: `/stocktake-criteria`, `/stocktake-list`.

```text
component <app-search-field> [placeholder="Enter Stocktake #", searchTerm=searchTerm] → searchTermChange: searchTerm = a; search: handleSearch()
heading "Stocktake" [app-form-header]
if !isLandscapeMode:
for each item in stocktakeItems:
  mat-list-item "{StocktakeNumber} Created: {CreatedDate} {NextDateText}: {LastUpdatedDate} User: {LastUpdatedBy} Criteria: Entire warehouse Bins: {Bins} Brands: {Brands} Categories: {Categories} Stock Locators: {StockLocators} Tags: {Tags} Zones: {Zones}" → goStocktakeProcess(o), o = .$implicit
if activeOnly&&(!stocktakeItems||0==stocktakeItems.length):
  text "No active stocktake is found."
component <mat-paginator> [pageSize=pageSize, pageIndex=pageIndex] → page: reloadData()
button "New" → handleNew()
```

API calls: GET /v2/stockTakeList

### Stocktake: new stocktake criteria

Route: `/stocktake-criteria`. Component: `app-stocktake-criteria`. Navigates to: `/stocktake`, `/stocktake-criteria-edit`, `/stocktake-list`.

```text
heading "Stocktake criteria" [app-form-header]
input toggle "Entire warehouse Create stocktake for the entire warehouse" (model: disableAllCriteria) → change: handleEntireWarehouse()
for each item in criteriaItems:
  button "{Name} {getCriterionValue(n)} [menu-arrow]" → goCriteriaProcess(s), s = .$implicit [disabled when disableAllCriteria]
button "Start" → handleStart()
```

API calls: GET /system/PickAndPack_StocktakeCriteria; POST /system/PickAndPack_Stocktake

### Stocktake: choose criteria values

Route: `/stocktake-criteria-edit`. Component: `app-stocktake-criteria-edit`. Navigates to: `/stocktake-criteria`.

```text
button "Save" → handleConfirm()
heading "Select criteria"
button "[close]" → handleGoBack()
list: rows (dataSource) show {currentCriterion.Name} | Select all
  column Name "{currentCriterion.Name}": {Name}
  column select "Select all": <mat-checkbox input>
```

API calls: none (local state only)

### Stocktake: count list

Route: `/stocktake-list`. Component: `app-stocktake-list`. Navigates to: `/stocktake`, `/stocktake-item`.

```text
heading "" [app-form-header]
if showBin:
  input text "Bin" (model: binValue; name: binValue) → keyup.enter: handleBin()
  if binValue:
    button "[close]" → binValue = ""
input text "Item #" (control: searchCtrl; name: searchTerm) → keyup.enter: onSearch()
component <mat-autocomplete> → optionSelected: onSearch()
  for each item in filteredStocktakeItems | pipe:
    option "{SKU}: {ProductName}"
if searchCtrl.value:
  button "[close]" → searchCtrl.setValue("")
button "[search]" → onSearch() [disabled when !searchCtrl.value]
mat-list-item "{SKU} {ProductName} Counted: {Adjustment} On hand: {QuantityOnHand} {Adjustment-QuantityOnHand}" → goToDetails(s), s = .$implicit
button "Save" → handleSave()
button "Finish" → handleFinishDialog()
dialog "All unsaved data will be lost. Are you sure?"
dialog "Are you sure you want to finish?"
dialog "Are you sure?"
dialog "Item does not exist in the selected stocktake area. Do you want to add it?"
```

API calls: GET /system/PickAndPack_Stocktake; PUT /system/PickAndPack_Stocktake

### Stocktake: item details

Route: `/stocktake-item`. Component: `app-stocktake-item`. Navigates to: `/stocktake-list`.

```text
heading "Item details" [app-form-header]
if groupedItem.ImageUrl:
  tap area <div> → showImage(groupedItem.ImageUrl)
if !groupedItem.ImageUrl:
  image assets/img/PosImages/image-placeholder.png
text "{groupedItem.SKU}"
text "{groupedItem.ProductName}"
text "Placed @"
text "{groupedItem.Location}"
text "Counted:"
text "{groupedItem.Adjustment}"
if showOnHand:
  text "On hand:"
  text "{groupedItem.QuantityOnHand}"
if showOnHand:
  text "{groupedItem.Adjustment-groupedItem.QuantityOnHand}"
if showBin:
  input text "Bin" (model: binValue; name: scan-bin) → keyup.enter: handleBin(); keyup.tab: handleBin(); blur: onFieldBlur("bin")
  if binValue:
    button "[close]" → binValue = ""
if "FIFO"===costingMethod:
  input text "Item #" (model: itemValue; name: scan-number) → keyup.enter: handleItem(); keyup.tab: handleItem(); blur: onFieldBlur("item")
  if itemValue:
    button "[close]" → itemValue = ""
if "FIFO"!==costingMethod:
  input text "costingLabel" (model: batchValue; name: scan-batch) → keyup.enter: handleBatchSerial(); keyup.tab: handleBatchSerial()
  if batchValue:
    button "[close]" → batchValue = ""
if showUnitCost:
  input number "Unit Cost" (model: unitCost; min 0) → keyup.enter: confirmUnitCost(); blur: confirmUnitCost()
  if null!==unitCost:
input text (control: date)
component <mat-datepicker> [touchUi=true] → closed: datePickerClosed(); opened: datePickerOpened()
input text (control: receivedDate)
component <mat-datepicker> [touchUi=true] → opened: receivedOpened()
form
  heading "Counted items"
  list: rows (dataSource) show Details | Quantity | tools
    column details "Details": [{Unit} @ {getLocationToShow(e)} if ShowLocation] / [{Unit} if !ShowLocation] / [{costingLabel}: {BatchSN} if BatchSN] / [Expiry: {ExpiryDate | pipe} if ExpiryDate] / [Received: {ReceivedDate | pipe} 
    column quantity "Quantity": <number input model: Adjustment> / [Min. allowed - 0 if null==errors?null:errors.min]
    column tools: <button [trash] → removeReceivedSingleItem(a), a = .$implicit>
button "Finish" → finish() [disabled when !countedItemsDisplay.length||invalid]
dialog "Are you sure to remove the item from the counted list?"
dialog "Are you sure to remove entire counted list?"
dialog "This bin is not found. Are you sure to create it?"
dialog "This {…} is not found. Do you want to add it?"
dialog "The stocktake quantity entered for the item is   [Yes / No]"
```

API calls: POST /v2/ref/location

### Put away: list

Routes: `/put-away-list`, `/put-away-list-clean` (route data {clearStorage:true}). Component: `app-put-away-list`. Navigates to: `/main-menu`, `/put-away-item`, `/receive-menu`, `/warehouse-transfer-putaway`.

```text
component <app-search-field> [placeholder="Enter item # or scan UPC code", searchTerm=searchTerm] → searchTermChange: searchTerm = a; search: onSearch()
heading "Put away" [app-form-header]
if !isLandscapeMode:
for each item in displayItems:
  mat-list-item "{SKU} {Name} Picked from: {PickedLocations} Put away to: {Locations} Placed: {Placed} Remain: {Remain} {Status}" → goToDetails(o), o = .$implicit
if isPlaceAllVisible:
  button "Place all" → confirmPlaceAll() [disabled when !isPlaceAllEnabled]
button "Finish" → confirmFinish() [disabled when disableFinish()]
dialog "Are you sure you want to cancel put away?"
dialog "Are you sure you want to place all picked items in bin {…}?"
dialog "Are you sure?"
```

API calls: GET /system/PickAndPack_PutAway; POST /v2/stockTransfer; GET /system/PickAndPack_Configuration; POST /v2/advanced-purchase/put-away

### Put away: item details

Routes: `/put-away-item`, `/put-away-item-transfer` (route data {transfer:true}). Component: `app-put-away-item`. Navigates to: `/put-away-list`, `/warehouse-transfer`.

```text
heading "Item details" [app-form-header]
if groupedItem.Image:
  tap area <div> → showImage(getImageUrl(groupedItem.Image))
if !groupedItem.Image:
  image assets/img/PosImages/image-placeholder.png
text "{groupedItem.SKU}"
text "{groupedItem.Name}"
if !isTransferMode:
  text "Put away to:"
  text "{groupedItem.Locations}"
if isTransferMode:
  text "Picking @"
  text "{groupedItem.Locations}"
if !isTransferMode:
  text "Placed:"
  text "{groupedItem.Placed}"
  text "Remain:"
  text "{groupedItem.Remain}"
if isTransferMode:
  text "Available:"
  text "{groupedItem.QuantityInSelectedUOM}"
  text "Picked:"
  text "{groupedItem.Placed}"
  text "Remain:"
  text "{groupedItem.Remain}"
if !isTransferMode:
  input text "Bin" (model: binValue; name: scan-bin) → scanInput: handleBin()
  if binValue:
    button "[close]" → binValue = ""
if "FIFO"===groupedItem.CostingMethod:
  input text "costingLabel" (model: itemValue; name: scan-number) → scanInput: handleItem()
  if itemValue:
    button "[close]" → itemValue = ""
if "FIFO"!==groupedItem.CostingMethod:
  input text "costingLabel" (model: batchValue; name: scan-batch) → scanInput: handleBatchSerial()
  if batchValue:
    button "[close]" → batchValue = ""
tap area <uom-selector> → selectedUOMChange: uomChange(a)
if isTransferMode:
  heading "Picked items"
if !isTransferMode:
  heading "Placed items"
list: rows (dataSource) show Details | quantity | tools
  column details "Details": [{Unit} @ {Location} if ShowLocation] / [{Unit} if !ShowLocation] / [Batch #: {BatchSN} if BatchSN] / [Expiry: {FormattedExpiryDate} if FormattedExpiryDate]
  column quantity: <number input model: Adjustment> / [Min. allowed - 1 if null==errors?null:errors.min] / [Max. allowed - {calcUpperLimit(e)} if (null==errors?null:errors.max)&&(!isTran]
  column tools: <button [trash] → removePlaceSingleItem(a), a = .index>
if !isTransferMode&&groupedItem.Placed>0&&groupedItem.Placed<groupedItem.QuantityInSelectedUO:
  button "Place partially" → placePartially() [disabled when !groupedItem.Placed]
if isTransferMode||0===groupedItem.Placed||groupedItem.Placed===groupedItem.QuantityInSelecte:
  button "Finish" → placeFinish() [disabled when isTransferFinishDisabled()]
dialog "Are you sure to cancel operation?"
dialog "Are you sure to place partially?"
dialog "This bin is not found. Are you sure to create it?"
```

API calls: POST /v2/ref/location; GET /system/PickAndPack_WarehouseTransferList

### Receive to bin

Route: `/receive-to-bin`. Component: `app-receive-to-bin`. Navigates to: `/receive-list`, `/receive-with-po`.

```text
heading "To bin" [app-form-header]
form (submit → handleSearch())
  input text "Enter Item #, Bin # or Scan UPC code" (model: searchTerm; name: searchTerm)
  if searchTerm:
    button "[close]" → searchTerm = ""
  button "[search]"
list: rows (dataSource) show ToBin | Remain | Received
  column ToBin: <mat-checkbox input> / {Name}
  column Remain: <number input model: Remain>
  column Received: <number input model: Received>
button "Finish" → goItemsList() [disabled when !selection.hasValue()]
```

API calls: GET /system/PickAndPack_ReceiveList; GET /v2/advanced-purchase/put-away; GET /v2/advanced-purchase/stock; POST /system/PickAndPack_Bins/GetDirectPutAwaySuggestedBins

### Bin transfer: picking

Routes: `/warehouse-transfer`, `/warehouse-transfer-putaway` (route data {putawayBack:true}). Component: `app-warehouse-transfer`. Navigates to: `/put-away-item-transfer`, `/put-away-list`, `/receive-menu`.

```text
heading "Picking @" [app-form-header]
input text "Enter item # or scan UPC code" (model: searchTerm; name: searchTerm) → keyup.enter: onSearch()
if searchTerm:
  button "[close]" → searchTerm = ""
button "[search]" → onSearch()
if isBulkActionRowVisible():
  if isBulkShowAllVisible():
    button "Show available" → handleBulkShowAll()
  if isBulkPickAllVisible():
    button "✓ Pick available" → handleBulkPickAll()
for each item in displayItems:
  mat-list-item "{Name} SKU: {SKU} Picked from: {Locations} Available: {Quantity} Picked: {Placed} {transferPickStatusLabel(n)}" → goToDetails(s), s = .$implicit
button "Next" → handleNextBin() [disabled when !isNextBinEnabled()]
button "Start" → handleStart() [disabled when !isStartEnabled()]
dialog "Are you sure you want to cancel transfer?"
dialog "This bin is not found. Are you sure to create it?"
dialog "Are you sure you want to place all picked items in bin {…}?"
```

API calls: GET /system/PickAndPack_WarehouseTransferList; POST /v2/ref/location

### Write-off: list

Route: `/write-off`. Component: `app-write-off`. Navigates to: `/write-off-list`, `/write-off-new`.

```text
heading "Write-off" [app-form-header]
list: rows (dataSource) show Write-Off # | Date | Status
  column AssemblyNumber "Write-Off #": {AssemblyNumber}
  column SysDate "Date": {SysDateFormated}
  column Status: {getItemStatusValue(Status)}
if !dataSource.data||0==dataSource.data.length:
  text "No Write-off is found."
component <mat-paginator> [pageSize=pageSize, pageIndex=pageIndex] → page: reloadData(a)
button "New" → handleNew()
```

API calls: GET /system/PickAndPack_WriteOff

### Write-off: new

Route: `/write-off-new`. Component: `app-write-off-new`. Navigates to: `/write-off`, `/write-off-list`.

```text
heading "New write-off" [app-form-header]
text "Account Code:"
text "{selectedAccountCode}"
form
  input text "Effective date" (control: date; name: scan-effective; required)
  input mat-datepicker-toggle "[calendar]"
  component <mat-datepicker> [touchUi=true] → closed: datePickerClosed()
  error "Effective date is required."
button "Continue" → handleContinue() [disabled when isCreating]
```

API calls: GET /system/PickAndPack_Configuration; POST /v2/inventoryWriteOff

### Write-off: items

Route: `/write-off-list`. Component: `app-write-off-list`. Navigates to: `/write-off`, `/write-off-item`.

```text
heading "Write-off # " [app-form-header]
if canProcess:
  input text "Enter item # or scan UPC code" (model: searchTerm; name: searchTerm) → keyup.enter: onSearch()
  if searchTerm:
    button "[close]" → searchTerm = ""
  button "[search]" → onSearch()
for each item in data.displayLines:
  mat-list-item "{ProductCode} {Name} Write-off: {Quantity} Available: {Available}" → onClickRow(s), s = .$implicit
button "Finish" → finishHandle() [disabled when !canProcess]
dialog "Are you sure you want to cancel the changes?"
dialog "Are you sure you want to complete this write-off?"
```

API calls: DELETE /v2/inventoryWriteOff; GET /system/PickAndPack_WriteOff; PUT /v2/inventoryWriteOff

### Write-off: item details

Route: `/write-off-item`. Component: `app-write-off-item`. Navigates to: `/write-off-list`.

```text
heading "Write-off # " [app-form-header]
if productImage:
  tap area <div> → showImage(getImageUrl(productImage))
if !productImage:
  image assets/img/PosImages/image-placeholder.png
text "{productCode}"
text "{productName}"
text "Write-off:"
text "{quantity}"
if showAvailability:
  text "Available:"
  text "{available}"
if canBeProcessed:
  input text "binPlaceholder" (model: binValue; name: scan-bin) → keyup.enter: handleBin(); keyup.tab: handleBin()
  if binValue:
    button "[close]" → handleBin(), binValue = ""
if "FIFO"===costingMethod:
  input text "costingLabel" (model: itemValue; name: scan-number; disabled when !canBeProcessed) → keyup.enter: handleItem(); keyup.tab: handleItem()
  if itemValue:
    button "[close]" → itemValue = ""
if "FIFO"!==costingMethod:
  input text "costingLabel" (model: batchValue; name: scan-batch; disabled when !canBeProcessed) → keyup.enter: handleBatchSerial(); keyup.tab: handleBatchSerial()
  if batchValue:
    button "[close]" → batchValue = ""
form
  heading "Items to write-off"
  list: rows (dataSource) show Details | Quantity | tools
    column details "Details": {Unit} @ {BinName||"N/A"} / [Batch #: {BatchSN} if BatchSN] / [Expiry: {FormattedExpiryDate} if FormattedExpiryDate]
    column quantity "Quantity": <number input model: Quantity> / [Min. allowed - 0 if null==errors?null:errors.min] / [Max. allowed - {Available} if null==errors?null:errors.max]
button "Done" → handleFinish() [disabled when !canBeProcessed||!data.listItems.length||invalid]
dialog "Are you sure to cancel the changes?"
```

API calls: none (local state only)

### Print labels: choose products

Route: `/print-labels-search`. Component: `app-print-labels-search`. Navigates to: `/print-labels-layout`.

```text
component <app-search-field> [placeholder="Enter item # or scan UPC code", searchTerm=data.searchTerm] → searchTermChange: data.searchTerm=a; search: handleSearch()
heading "Print labels" [app-form-header]
if !isLandscapeMode:
for each item in data.displayLines:
  mat-list-item "{SKU} {Name} Category: {Category}"
button "Print labels" → handlePrintLabels() [disabled when 0===data.displayLines.length]
```

API calls: GET /system/PickAndPack_LabelPrinting

### Print labels: layout

Route: `/print-labels-layout`. Component: `app-print-labels-layout`. Navigates to: `/print-labels-search`.

```text
heading "Print labels" [app-form-header]
input number "Copies" (model: copies; name: copies) → keyup.enter: numberOfCopiesSelected()
if copies:
  button "[close]" → copies = "1"
input mat-select "Select layout for printing" "{text}" (name: layoutSelector; required; value: selectedLayout) → valueChange: selectedLayout = a
  for each item in layouts:
    option "{text}"
text "On the next print preview dialog you need to set the margins value to "none"."
button "Print labels" → handlePrintLabels() [disabled when !checkCanContinue()]
text "{0 | pipe}"
```

API calls: GET /system/PickAndPack_LabelPrinting

### Delivery: list

Route: `/delivery`. Component: `app-delivery`. Navigates to: `/delivery-details`, `/delivery-route`.

```text
heading "Delivery" [app-form-header]
input text "Delivery date" (control: fromDateCtrl; readonly; required)
input mat-datepicker-toggle "[calendar]"
component <mat-datepicker> [touchUi=true]
input text "From" (control: startTimeCtrl; readonly)
input text "To" (control: endTimeCtrl; readonly)
input mat-select "Status" "All Pending In transit Completed Canceled" (required; value: deliveryStatus) → valueChange: deliveryStatus = l
  option "All"
  option "Pending"
  option "In transit"
  option "Completed"
  option "Canceled"
input text "Enter text to search" (model: searchTerm; name: searchTerm) → keyup.enter: onSearch()
if searchTerm:
  button "[close]" → searchTerm = ""
button "Search" → onSearch()
list: rows (dataSource) show DeliveryName | Date | Quantity
  column DeliveryName: {DeliveryTaskNumber} / {OrderNumber}
  column StatusDate "Date": {LocalDate} / {LocalTime}
  column DeliveryQty "Quantity": {ProductItemsCount}
component <mat-paginator> [pageSize=pageSize] → page: loadData()
```

API calls: /system/PickAndPack_Delivery

### Delivery: details

Route: `/delivery-details`. Component: `app-delivery-details`. Navigates to: `/delivery`.

```text
heading "Delivery" [app-form-header]
expansion panel:
  text "Delivery number: {deliveryItem.DeliveryTaskNumber}"
  text "Number of items"
  text "{deliveryItem.ProductItemsCount}"
  text "Customer"
  text "{deliveryItem.CustomerName}"
  text "Contact"
  text "{data.Details.ContactName}"
  text "Phones"
  text "{data.Details.Phones}"
  text "Shipping address"
  text "{deliveryItem.ShipAddress1}"
  text "{deliveryItem.ShipAddress2}"
tabs:
  tab "Delivery items"
    list: rows (data.Rows) show Image | ProductName | Quantity
      column ProductName: {ProductName} / {ProductCode}
      column Quantity: {Quantity}
  tab "Attachments"
    if attachments.length>0:
      for each item in attachments:
        mat-list-item "[attach] {FileName} [trash]"
    if 0===attachments.length:
      text "This delivery task has no attachments."
    button "[plus]" → addAttachment(!0)
    button "[plus]" → addAttachment(!1)
  tab "Notes"
    if notes.length>0:
      for each item in notes:
        mat-list-item "{Note} [trash]" → previewNote(o), o = .$implicit
    if 0===notes.length:
      text "This delivery task has no notes."
    button "Add new note" → addNote()
if "Open"==deliveryItem.TaskStatus:
  button "In transit" → inTransit()
if "In progress"==deliveryItem.TaskStatus:
  button "Complete" → complete()
if "In progress"==deliveryItem.TaskStatus:
  button "Cancel" → cancel()
if "Completed"==deliveryItem.TaskStatus||"Void"==deliveryItem.TaskStatus:
  button "Undo" → undo()
dialog "Do you want to complete this delivery task?"
dialog "Do you want to cancel this delivery task?"
dialog "Do you want to set 'In transit' status for this delivery task?"
dialog "Do you want to reset this delivery task to pending state?"
dialog "Do you want to delete this attachment?"
dialog "Do you want to delete this note?"
```

API calls: GET /system/PickAndPack_DeliveryDetails; PUT /system/PickAndPack_Delivery; GET /system/PickAndPack_DeliveryAttachment; POST /system/PickAndPack_DeliveryAttachment; DELETE /system/PickAndPack_DeliveryAttachment; POST /system/PickAndPack_DeliveryNotes; PUT /system/PickAndPack_DeliveryNotes; DELETE /system/PickAndPack_DeliveryNotes

### Delivery: route

Route: `/delivery-route`. Component: `app-delivery-route`. Navigates to: `/delivery`.

```text
heading "Delivery route" [app-form-header]
text "Please, mark addresses to include into route and mark destination address."
input mat-radio-group "Tasks {DeliveryTaskNumber} Shipping address {ShipAddress} Planned delivery time {LocalTime}" (model: favoriteDestinationID)
  list: rows (dataSource) show Marker | Tasks | Shipping address | Planned delivery time | DestinationMarker
    column Marker: <mat-checkbox input model: Marker>
    column DeliveryName "Tasks": {DeliveryTaskNumber}
    column Address "Shipping address": {ShipAddress}
    column Time "Planned delivery time": {LocalTime}
    column DestinationMarker: [<mat-radio-button input> if true===Marker]
button "Show route" → calcRoute() [disabled when routeDisabled]
```

API calls: POST /system/PickAndPack_GoogleRoute

### Settings

Route: `/about`. Component: `app-about`.

```text
heading "Settings" [app-form-header]
input mat-chip-list "Application version : v.{configService.appVersion}"
input toggle "Enable camera scanner" (model: enableCameraScan)
input mat-select "Select language" "{name}" (value: language) → valueChange: language = a
  for each item in languages:
    option "{name}"
button "Apply" → handleLanguageSelect()
if showSystemInfoButton:
  button "Show System Info" → openSystemInfoDialog()
```

API calls: none (local state only)

### Restock: sales order search

Route: `/restock`. Component: `app-restock`. Navigates to: `/main-menu`, `/restock-list`.

```text
component <app-search-field> [placeholder="Search by SO #", searchTerm=searchTerm] → searchTermChange: searchTerm = a; search: handleSearch()
heading "SO search" [app-form-header]
if !isLandscapeMode:
  form (submit → handleSearch())
list: rows (dataSource) show ORDER # | Shipped date
  column SaleOrderNumber "ORDER #": {SaleCreditNoteNumber?SaleOrderNumber+" ("+SaleCreditNoteNumber+")":SaleOrderNumber}
  column ShipmentDate "Shipped date": {ShipmentDate}
component <mat-paginator> [pageSize=pageSize] → page: reloadData(a)
```

API calls: GET /system/PickAndPack_ListOfRestocks

### Restock: item list

Route: `/restock-list`. Component: `app-restock-list`. Navigates to: `/restock`, `/restock-item`.

```text
heading "" [app-form-header]
input text "Enter item # or scan UPC code" (model: searchTerm; name: searchTerm) → keyup.enter: onSearch()
if searchTerm:
  button "[close]" → searchTerm = ""
button "[search]" → onSearch()
for each item in displayItems:
  mat-list-item "{Name} SKU: {SKU} Restock to: {RestockTo} Restock: {TotalProductRestockedQuantity} Remain: {TotalProductRemainQuantity} {getItemStatusValue(n)}" → goToDetails(s,null), s = .$implicit
button "Save" → handleSaveDlg() [disabled when !isSaveEnabled()]
dialog "All restock information will be lost. Are you sure?"
dialog "Are you sure?"
```

API calls: GET /system/PickAndPack_Restock; GET /system/PickAndPack_RestockList; POST /system/PickAndPack_Restock

### Restock: item details

Route: `/restock-item`. Component: `app-restock-item`. Navigates to: `/restock-list`.

```text
heading "" [app-form-header]
if restockContainer.RestockItem.Image:
  tap area <div> → showImage(getImageUrl(restockContainer.RestockItem.I...)
if !restockContainer.RestockItem.Image:
  image assets/img/PosImages/image-placeholder.png
text "{restockContainer.RestockItem.SKU}"
text "{restockContainer.RestockItem.Name}"
if binValue:
  text "Restock to"
  text "{binValue}"
if !binValue:
  text "Restocking @"
  text "{restockContainer.Location}"
text "Restocked:"
text "{calcRestocked()}"
text "Remain:"
text "{calcRemain(true)}"
input text "Bin" (model: binValue; name: scan-bin) → keyup.enter: handleBin(); keyup.tab: handleBin()
if binValue:
  button "[close]" → binValue = ""
if "FIFO"===costingMethod:
  input text "Item #" (model: itemValue; name: scan-number) → keyup.enter: handleItem(); keyup.tab: handleItem()
  if itemValue:
    button "[close]" → itemValue = ""
if "FIFO"!==costingMethod:
  input text "Expired" (control: date; name: scan-expired)
  input mat-datepicker-toggle "[calendar]"
  if !!date.value:
    button "[close]" → date.setValue("")
  component <mat-datepicker> [touchUi=true] → closed: datePickerClosed()
if "FIFO"!==costingMethod:
  input text "costingLabel" (model: batchValue; name: scan-batch) → keyup.enter: handleBatchSerial(); keyup.tab: handleBatchSerial()
  if batchValue:
    button "[close]" → batchValue = ""
if restockContainer.ListItems.length:
if "FIFO"===costingMethod&&calcRemain()>=0:
  button "Restock all ({calcRemain(true)})" → restockAll() [disabled when calcRemain()<=0||isAnyQuantityInvalid]
if calcRemain()>0:
  button "Restock partially" → restockPartially() [disabled when calcRemain()<=0||0==calcRestocked()||isAnyQuantityInvalid]
if calcRemain()<=0:
  button "Finish" → restockFinish() [disabled when isAnyQuantityInvalid]
dialog "This bin is not found. Are you sure to create it?"
dialog "Are you sure you want to complete partial restocking?"
```

API calls: POST /v2/ref/location

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
  mat-list-item "" → showDetails(o), o = .$implicit
button "Finish" → saveAll() [disabled when 0===pickedCount||!isLoaded]
```

API calls: GET /system/DEARMan_Transfer_ToPick; POST /system/DEARMan_Transfer_ToPick

### Stock transfer: item details (pick and put)

Routes: `/transfer-to-pick/details`, `/transfer-to-put/details`. Component: `app-transfer-pick-details`. Navigates to: `/pick`.

```text
heading "Item details" [app-form-header]
image itemData.Image | pipe,oo
text "{itemData.ProductName}"
text "SKU: {itemData.ProductCode}"
if locations:
  text "{"pick"===mode?"Pick:":"Place:"}"
  text "{itemData.RequiredQuantity}"
if locations&&locations.length:
  text "{"pick"===mode?"Pick from:":"Place to:"}"
  if !itemData.UseRecommendedPick (else e):
    for each item in locations:
      text "{e||"N/A"}"
      if n<locations.length-1:
        text ","
  text "{itemData.RecommendedBinName}"
text "Remain:"
text "{itemData.QuantityInSelectedUOM>itemData.Picked?itemData.QuantityInSelectedUOM-itemData.Picked:0,"1.0-4"}"
text "Picked:"
text "{itemData.Picked,"1.0-4"}"
input text "Bin" (model: binValue; name: Bin) → keyup.enter: handleBin(); keyup.tab: handleBin()
button "Auto-fill" → autoFillBin()
input text "isBatchSN?"Batch / SN":"Item #"" (model: itemValue; name: Item) → keyup.enter: addItem(); keyup.tab: addItem()
tap area <uom-selector> → selectedUOMChange: uomChange(a)
form
  heading "Picked items"
  list: rows (itemsDataSource) show DETAILS | RECEIVED | tools
    column bin "DETAILS": {Unit} @ {"pick"===mode?LocationName:LocationToName} / [Serial: {BatchSN} if BatchSN] / [Expiry: {…} if ExpiryDate]
    column quantity "RECEIVED": <number input model: Picked>
    column tools: <button [trash] → remove(o), o = .index>
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
  mat-list-item "" → showDetails(s), s = .$implicit
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
  column Quantity "{isPutAway()?"Received":"Quantity"}": [<number input model: Quantity> / [Min. allowed - 0.0001 if null==errors?null:errors.min] / [Max. allowed - {AvailableQuantity} if null==errors?null:errors.max] if isOrder()]
  column Tools: <button [trash] → removeItem(a), a = .$implicit>
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
    tap area <uom-selector> → selectedUOMChange: uomChange(a)
form
  list: rows (dataSource) show Details | Unit | Quantity | Quantity | Tools
    column Location "Details": {locationDataLabel}: {filterLocation(Location)} / [{batchTitle}: {BatchSN} if isPicking()&&BatchSN] / [Expiry: {…} if isPicking()&&ExpiryDate]
    column UnitName "Unit": {UnitName}
    column TransferQuantity "Quantity": <number input model: TransferQuantity> / [Min - {min} if null==errors?null:errors.min]
    column ReceivedQuantity "Quantity": [<number input model: ReceivedQuantity> if 0!==mode] / [{ReceivedQuantity} if 0===mode]
    column Tools: <button [trash] → removeItem(a), a = .$implicit>
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
input text "Enter SKU/Item Code and Name" (model: searchTerm; name: searchTerm) → keyup.enter: handleSearch()
if searchTerm:
  button "[close]" → onSearchInput(""), searchTerm = ""
button "[search]" → handleSearch()
if selectedLocation&&selectedLocation.IsBin&&2===mode&&directedPutAwayInfo[selectedLocation.I:
  expansion panel:
    text "{selectedLocation.CombinedName} - {directedPutAwayInfo[selectedLocation.ID].Rules[0].Name}"
if 3==mode&&selectedProduct:
  component <app-stock-lookup-item-details-info> [info=selectedProduct]
if 0===mode:
if 1===mode:
  if datasources[mode].data.length (else n):
    list: rows (datasources[mode]) show Location | Product | Avail | Tools
      column Location: {LocationName} / [Your Area if showWorkingAreaBadges&&LocationID===work] / [{BinName} if BinName]
      column Product: {ProductName} / {ProductCode}
      column Available "Avail": [- if Available>=0] / {Ts(4 | filter}
      column Tools: [menu-arrow]
if 2===mode:
  if selectedLocation&&selectedLocation.IsBin&&2===mode&&directedPutAwayInfo[selectedLocation.I:
    for each item in directedPutAwayInfo[selectedLocation.ID].Rules:
      expansion panel:
        text "{selectedLocation.CombinedName} - {Name}"
  if datasources[mode].data.length (else n):
    for each item in datasources[mode].data:
      component <app-stock-lookup-item-details-info> [info=e]
      component <app-stock-lookup-item-details-grid> [data=Rows, paginator=n]
      component <mat-paginator> [hiddenPaginator=length<=1||length<=pageSize]
if 3===mode:
  if datasources[mode].data.length (else n):
    for each item in datasources[mode].data:
      text "{LocationName}"
      component <app-stock-lookup-item-details-grid> [data=Rows, paginator=n]
      component <mat-paginator> [hiddenPaginator=length<=1||length<=pageSize]
text "You do not have any products right now."
text "Item is not found."
if 1===mode (else n):
  component <mat-paginator> [hiddenPaginator=length<=pageSizeDynamic, pageSize=pageSizeDynamic, pageIndex=pageIndex, length=length] → page: pageChanged(a)
component <mat-paginator> [hiddenPaginator=length<=pageSize||0===mode, pageSize=pageSize, pageIndex=pageIndex, length=length] → page: pageChanged(a)
component <app-stock-lookup-item-details> [hiddenContent=!detailsSelected||!isLoaded, selected=detailsSelected] → closed: detailsSelected = null
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

API calls: GET /system/PickAndPack_StockAvailability/Search; GET /system/PickAndPack_StockAvailability/ByLocation
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
if "WMS"===appName (else e):
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

### Camera scan dialog

Component: `app-camera-scan-dialog`.

```text
heading "Camera scan"
component <mat-dialog-content>
  text "{barcode}"
component <mat-dialog-actions>
  button "Next" → next()
  button "Finish"
```

API calls: none (local state only)

### Camera scan button

Component: `app-camera-scan`.

```text
if shouldShowButton:
  button "["barcode-camera-header-dark"===icon?"barcode-camera-header":icon]" → scanBarcode(); mousedown: getLastFocus()
dialog "Please enter the quantity manually, barcode scanning is not allowed for quantity input.  [Ok]"
```

API calls: none (local state only)

### Error mark

Component: `app-error-mark`.

```text
if "Invalid"===state||"Warning"===state:
```

API calls: none (local state only)

### Menu item row

Component: `app-menu-item`.

```text
if !routerLink (else n):
  button "[icon] {title} {counter} [menu-arrow]" → onClick(a)
link "[icon] {title} {counter} [menu-arrow]" → navigate routerLink
```

API calls: none (local state only)

### Note view dialog

Component: `app-note-view`. Opened from: Delivery details.

```text
heading "{data.title}"
button "[close]"
component <mat-dialog-content>
  input textarea "placeholder" (model: text; readonly)
if true!==data.readOnly:
  button "Save" → saveNote()
  button "Cancel"
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

Component: `app-select-location`.

```text
heading "Select location"
button "[close]"
component <mat-dialog-content>
  if multiple (else n):
    for each item in selectedLocations:
      mat-list-item "{n[0].Name}" → selectItem(o[0]), o = .$implicit
  mat-list-item "{Name}" → selectItem(s), s = .$implicit
button "Next" → goNext() [disabled when isDisabled]
```

API calls: none (local state only)

### Screen header bar

Component: `app-form-header`. Navigates to: `/main-menu`.

```text
heading "[back] [menu] {header.headerText} {header.headerText2} {text} [confirm] [refresh-black]"
```

API calls: none (local state only)

### Scan source bin dialog

Component: `app-bin-scan-dialog`. Opened from: Warehouse transfer.

```text
heading "Scan/enter source bin"
text "(leave empty if your stock is not in the bin)"
button "[close]"
component <mat-dialog-content>
  input text "Bin" (model: binValue; name: bin-value) → blur: onBinBlur(); keyup.enter: searchBin()
  component <app-camera-scan> [inputScanButton=true, matSuffix=true] → barcodeScanned: onBarcodeScanned(i)
  if showAllDisabledNote:
    text "{showAllDisabledNote}"
component <mat-dialog-actions>
  button "Next" → searchBin() [disabled when isNextDisabled]
  if hasBulkActions:
    button "Show available" → onBulk("showAll") [disabled when isShowAllBulkDisabled]
    button "Pick available" → onBulk("pickAll") [disabled when isPickAllBulkDisabled]
  button "Cancel" → cancel()
```

API calls: none (local state only)

### Scan destination bin dialog

Component: `app-destination-bin-dialog`. Opened from: Warehouse transfer.

```text
heading "Scan/enter destination bin"
button "[close]" → cancel()
component <mat-dialog-content>
  label "Bin"
  input text (model: binValue; name: destination-bin-value) → blur: onBinBlur(); keyup.enter: onOk()
  component <app-camera-scan> [inputScanButton=true, matSuffix=true] → barcodeScanned: onBarcodeScanned(i)
component <mat-dialog-actions>
  button "Next" → onOk() [disabled when actionBusy]
  button "Cancel" → cancel() [disabled when actionBusy]
  button "Place all" → onPlaceAll() [disabled when isPlaceAllDisabled]
```

API calls: none (local state only)

### Item image dialog

Component: `app-item-image-dialog`. Opened from: Delivery details, Picking item, Put away item, Receive item, Restock item.

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
    mat-list-item "{Name}" → selectTemplate(o), o = .$implicit
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

### Search field

Component: `app-search-field`.

```text
input text "placeholder" (model: searchTerm; name: searchTerm) → keyup.enter: onSearch()
if searchTerm:
  button "[close]" → clearSearch()
button "[search]" → onSearch()
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

### Time tracking bar

Component: `app-time-tracking`.

```text
text "Actual time"
text "{liveTime | pipe}"
if isLoaded:
  case "none":
    button "[start]" → start()
  case "progress":
    button "[pause]" → pause()
  case "suspended":
    button "[pause]" → resume()
dialog "Resume time tracking for this operation? You will be able to suspend time tracking again if required.   [Resume]"
dialog "Stop time tracking for this operation?  [Suspend]"
```

API calls: POST /system/PickAndPack_TimeTrackingSession; PUT /system/PickAndPack_TimeTrackingSession; DELETE /system/PickAndPack_TimeTrackingSession

### Change carrier dialog

Component: `app-change-carrier-dialog`. Opened from: Pack box dialog.

```text
heading "Carrier/Service Lookup"
button "[close]"
component <mat-dialog-content>
  input mat-radio-group "{DisplayName}" (model: selectedItem)
    for each item in data.Items:
      input mat-radio-button "{DisplayName}" (value: e)
component <mat-dialog-actions>
  button "OK" → finish()
  button "Cancel"
```

API calls: none (local state only)

### Package number selector

Component: `app-package-number`.

```text
label "Enter or scan package#"
input text (control: formControl; name: package-number) → scanInput: onScanPackageNumber(), closePanel(), s = #ref; focus: ref.openPanel()
if null==formControl||null==formControl.errors?null:formControl.errors.required:
  error "Package# cannot be blank."
if null==formControl||null==formControl.errors?null:formControl.errors.invalid:
  error "Package# is not valid."
component <mat-autocomplete>
  for each item in filteredOptions | pipe:
    option "{n}" → onSelectionChange: onOptionSelected(a)
component <app-camera-scan> [icon="barcode-camera-header-dark", inputScanButton=true, matSuffix=true] → barcodeScanned: onScanPackageNumber(), selectedPackage = s
```

API calls: none (local state only)

### Multi-package select

Component: `app-multi-package-select`.

```text
label "Select packages for consignment"
input mat-select "{selectedPackages.length} package(s) selected No packages selected Select All {e}" (name: package-multi-select; value: selectedPackages) → valueChange: selectedPackages = a; selectionChange: onMultiplePackageChange(a)
  if selectedPackages&&selectedPackages.length>0:
    text "{selectedPackages.length} package(s) selected"
  if !selectedPackages||0===selectedPackages.length:
    text "No packages selected"
  input checkbox "Select All" (checked: isAllPackagesSelected()) → click: stopPropagation(); change: toggleSelectAllPackages()
  for each item in sortedPackages:
    option "{e}"
component <app-camera-scan> [icon="barcode-camera-header-dark", inputScanButton=true, matSuffix=true] → barcodeScanned: onScanPackageNumber(a)
```

API calls: GET /system/v2/PickAndPack_PackageWeightAndValue

### Shipping field

Component: `app-shipping-field`.

```text
if field&&!field.hidden&&(field.Control||field.Group):
  label "{field.Parameter.DisplayName}"
  input type: field.Type (control: field.Control)
  label "{field.Parameter.DisplayName}"
  input mat-select "{DisplayName}" (control: field.Control)
    for each item in listParameter.Items:
      option "{DisplayName}"
  if groupParameter.fields&&groupParameter.fields.length:
    heading "{groupParameter.param.DisplayName}"
    for each item in groupParameter.fields:
      if !hidden:
        component <app-shipping-field>
```

API calls: none (local state only)

### Shipping form

Component: `app-shipping-form`.

```text
if fields&&fields.length:
  for each item in fields:
    if !hidden:
      component <app-shipping-field>
```

API calls: none (local state only)

### Pack box dialog

Component: `app-pack-box-dialog`. Opened from: Packing list.

```text
heading "Package settings"
button "[close]" → close()
component <mat-dialog-content>
  form
    if !isMultiPackageEnabled:
      component <app-package-number> [packages=packagesAll, selectedPackage=selectedPackage[0], validate=true] → selectedPackageChange: selectedPackage[0]=a; onChange: onChangePackage(a)
    if isMultiPackageEnabled:
      component <app-multi-package-select> [packages=packagesAll, taskID=data.taskID, serviceID=data.serviceID, boxes=boxes, selectedPackages=selectedPackage] → selectedPackagesChange: selectedPackage = a; selectionResult: onMultiPackageSelectionResult(a)
    if shippingMethod:
      input text "Shipping method" (name: shippingMethod)
    if hasCarriesList:
      input text "requiresServicesLoading?"Select Carrier":"Select Carrier/Service"" (control: controls.Carrier; name: carrier) → click: handleSearchCarrier()
      button "[search]" → handleSearchCarrier()
    if requiresServiceSelection||searchCarrier&&requiresServicesLoading&&carrierServices&&carrier:
      input mat-select "Service" "{name}" (control: controls.Service; name: service-select; required) → openedChange: handleLoadServices()
        for each item in carrierServices:
          option "{name}"
    if requiresCourierTypes&&courierTypes&&courierTypes.length:
      input mat-select "Service level" "{DisplayName}" (control: controls.CourierLevel)
        for each item in courierTypes:
          option "{DisplayName}"
    if isBoxSelectionEnabled:
      input mat-select "Package" "{PackageName}" (control: controls.Package; name: box-select; required)
        for each item in boxes:
          option "{PackageName}"
    if !isBoxSelectionEnabled:
      input text "Package"
    input number "box.SizeMeasureUnit?"Width("+box.SizeMeasureUnit+")":"Width"" (control: controls.Width)
    input number "box.SizeMeasureUnit?"Length("+box.SizeMeasureUnit+")":"Length"" (control: controls.Length)
    input number "box.SizeMeasureUnit?"Height("+box.SizeMeasureUnit+")":"Height"" (control: controls.Height)
    input number "box.WeightMeasureUnit?"Weight("+box.WeightMeasureUnit+")":"Weight"" (control: controls.Weight; required)
    if data.fields&&(null==data.fields.controls?null:data.fields.controls.length):
      component <app-shipping-form> [fields=data.fields.controls, formGroup=formGroup, value=null==values?null:values.ValueInSelec...]
component <mat-dialog-actions>
  if !allSaved (else i):
    if !selectedPackageIsSaved (else e):
      button "Save package details" → handleSave() [disabled when invalid||!box.Code||isSaving||formGroup.invalid]
    button "Next package" → handleNextPackage() [disabled when formGroup.invalid]
  if isLastBox&&!allLabelsPrinted:
    button "Print label" → printLabel() [disabled when formGroup.invalid||!box.Code||isPrintingLabel||disablePrintButton()]
  if !isLastBox:
    button "{nextBoxButtonText}" → handleNext()
dialog "Valid package#<br/>  [OK]"
```

API calls: GET /system/v2/PickAndPack_PackageWeightAndValue; PUT /system/PickAndPack_PackageManagement; /system/PickAndPack_PackageManagement; GET /system/PickAndPack_PackageManagement; GET /system/PickAndPack_CarrierServices

### Change quantity dialog

Component: `app-change-quantity-dialog`. Opened from: Packing list.

```text
heading "Change quantity for"
button "[close]"
component <mat-dialog-content>
  if data.itemImageUrl:
    image data.itemImageUrl,oo
  if !data.itemImageUrl:
    image assets/img/PosImages/image-placeholder.png
  text "{data.itemSKU}"
  text "{data.itemName}"
  if data.item.Comment&&data.item.Comment.length>0:
    image assets/img/PosImages/info.svg
    text "{data.item.Comment}"
  component <app-package-number> [selectedPackage=packageNumber, packages=packages] → selectedPackageChange: packageNumber = o; onChange: onScanPackageNumber(o)
  input text "modeName" (model: itemScan; name: scan) → scanInput: onSearch()
  if itemScan:
  component <app-camera-scan> [icon="barcode-camera-header-dark", inputScanButton=true, matSuffix=true] → barcodeScanned: onBatchChange(), onSearch(), itemScan = o
  button "[minus]" → decreaseQty() [disabled when data.qtyValue<=data.minValue||"FIFO"!==costingMethod&&!isSearchDone||!packageNum]
  input number (model: data.qtyValue; name: quantity; disabled when "FIFO"!==costingMethod&&!isSearchDone||!packageNumber; min 0) → scanInput: changeQty(); input: numberOnly(o)
  button "[plus]" → increaseQty() [disabled when data.qtyValue>=data.maxValue||"FIFO"!==costingMethod&&!isSearchDone||!packageNum]
component <mat-dialog-actions>
  button "Save" → changeQty() [disabled when "FIFO"!==data.productType&&!isSearchDone||!valid]
  button "Cancel" → onCancel()
```

API calls: none (local state only)

### Not enough stock dialog

Component: `app-picking-item-no-available-dialog`. Opened from: Picking item.

```text
heading "Not enough items in batch."
text "{getTitle()}"
button "[close]"
if data.pickItem.OnOrder:
  component <mat-dialog-content>
    text "On order:"
    for each item in data.pickItem.OnOrder:
      text "{TaskNumber} ({Quantity})"
component <mat-dialog-actions>
  button "Refresh Availability" → refreshAvailability()
  button "Close"
```

API calls: POST /system/PickAndPack_PickList

### Zero counted quantity notification (stocktake finish)

Component: `app-counted-quantity-notification-dialog`. Opened from: Stocktake list.

```text
heading "Finish stocktake"
heading "Counted quantity of the following items is '0'"
button "[close]"
component <mat-dialog-content>
  text "Details"
  text "Variance"
  text "{ProductName}"
  text "SKU: {SKU}"
  if BatchSN:
    text "{"SN"==CostingMethod||"FISN"==CostingMethod||"FESN"==CostingMethod?serialLabel:batchLabel}: {BatchSN}"
  text "Location: {Location}"
  text "{-QuantityOnHand}"
component <mat-dialog-actions>
  button "Finish" → finish()
  button "Close"
```

API calls: none (local state only)

### Availability dialog

Component: `app-availablility-dialog`. Opened from: Put away item.

```text
heading "No available items"
text "There are no available items in this Bin/Batch."
button "[close]"
if onOrder.length>0:
  component <mat-dialog-content>
    text "On order:"
    for each item in onOrder:
      text "{PurchaseOrderNumber} ({Quantity})"
component <mat-dialog-actions>
  button "Refresh availability" → refreshAvailability()
  button "Close"
```

API calls: GET /system/PickAndPack_WarehouseTransferList

### System info dialog

Component: `app-system-info-dialog`. Opened from: About.

```text
heading "System Information"
component <mat-dialog-content>
  text "Safe Areas"
  text "Top: {(null==data.safeAreaInsets?null:data.safeAreaInsets.top)||0}px"
  text "Bottom: {(null==data.safeAreaInsets?null:data.safeAreaInsets.bottom)||0}px"
  text "Left: {(null==data.safeAreaInsets?null:data.safeAreaInsets.left)||0}px"
  text "Right: {(null==data.safeAreaInsets?null:data.safeAreaInsets.right)||0}px"
  text "Viewport"
  text "Width: {getViewportWidth()}px"
  text "Height: {getViewportHeight()}px"
  text "Scale: {(null==data.visualViewport?null:data.visualViewport.scale)||1}"
  text "Position"
  text "Offset X: {(null==data.visualViewport?null:data.visualViewport.offsetLeft)||0}"
  text "Offset Y: {(null==data.visualViewport?null:data.visualViewport.offsetTop)||0}"
  text "Page X: {(null==data.visualViewport?null:data.visualViewport.pageLeft)||0}"
  text "Page Y: {(null==data.visualViewport?null:data.visualViewport.pageTop)||0}"
  text "Device Information"
  text "Model: {(null==data.deviceInfo?null:data.deviceInfo.model)||"Unknown"}"
  text "Platform: {(null==data.deviceInfo?null:data.deviceInfo.platform)||"Unknown"}"
  text "OS Version: {(null==data.deviceInfo?null:data.deviceInfo.version)||"Unknown"}"
  text "App Version: {(null==data.deviceInfo?null:data.deviceInfo.appVersion)||"Unknown"}"
  text "Device ID: {(null==data.deviceInfo?null:data.deviceInfo.deviceID)||"Unknown"}"
  text "Mobile: {isMobileDevice()}"
  text "Environment"
  text "Browser: {(null==data.deviceInfoService?null:data.deviceInfoService.isBrowser)||false}"
  text "Virtual: {(null==data.deviceInfoService?null:data.deviceInfoService.isDeviceVirtual)||false}"
  text "Simulator: {(null==data.deviceInfoService?null:data.deviceInfoService.isSimulator)||false}"
  text "Rooted: {(null==data.deviceInfoService?null:data.deviceInfoService.isDeviceRooted)||false}"
  text "Cordova"
  text "Version: {(null==data.cordovaDevice?null:data.cordovaDevice.cordova)||"Not available"}"
component <mat-dialog-actions> [align=end]
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
button "[print]" → print(o), o = .$implicit
button "Undo" → undo(o), o = .$implicit
button "Void" → void(o), o = .$implicit
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
  list: rows (dataSource) show Name | NameComplex | Location | {isLocations()?"Current Qty":"Available"}
    column Name: {Name} / SKU: {ProductCode}
    column NameComplex: {Name} / SKU: {ProductCode} / [Serial: {BatchSN} if isDetailed&&BatchSN] / [Expiry: {ExpiryDate | pipe} if isDetailed&&ExpiryDate]
    column Location: [{ParentLocation} if !BinLocation] / [{BinLocation} if BinLocation]
    column AvailableQuantity "{isLocations()?"Current Qty":"Available"}": [{AvailableQuantity,uomService.selectedUOM} if isSimple()] / [{Available} if !isSimple()]
```

API calls: none (local state only)

### Stock lookup item info panel

Component: `app-stock-lookup-item-details-info`.

```text
image info.Image | pipe,oo
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
  column OnHand "SOH": [- if OnHand>=0] / {Ts(4 | filter}
  column Available "Avail": [- if Available>=0] / {Ts(4 | filter}
  column OnOrder "On order": [- if OnOrder>=0] / {Ts(4 | filter}
  column Allocated: [- if Allocated>=0] / {Ts(4 | filter}
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
  component <app-stock-lookup-item-details-grid> [data=data] → sortChanged: sortChange(a)
component <mat-paginator> [hiddenPaginator=length<=pageSize&&1!==length, pageSize=pageSize, pageIndex=pageIndex, length=length] → page: pageChanged(i)
```

API calls: GET /system/PickAndPack_StockAvailability/Details; GET /system/PickAndPack_StockAvailability/Search
