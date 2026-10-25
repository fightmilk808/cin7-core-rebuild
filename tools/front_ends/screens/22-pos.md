## Screens

Source: the public AngularJS 1.x bundle of the web POS (webpack, `main-bundle.js`) and its `PosViews/*.html` templates. Routing is `ngRoute` (`$routeProvider.when(...)`, hash URLs such as `#/sell`), with `/` and any unknown path redirecting to `#/home`. There are 29 routed screens; the rest of the templates are dialogs, panels and sub-views that the routed screens include (`ng-include`) or open as modals. The page chrome (header bar and side menu) is shared by every screen.

All server calls go through one data service (`remoteRequestProvider`) to the base `/ExternalApi/POS` followed by the command name shown in each "API calls" line; the base host and keys come from build configuration and are not repeated here.

**Navigation map**

```text
Header bar: menu button (opens side menu) | outlet name | greeting + user | links: Set PIN code, Change outlet|register, Logout | language dialog
Side menu (sideBarPartial):
  Dashboard -> #dashboard
Sell (section heading, expands the items below)
  Register -> #sell
  Parked sales -> #salesparked
  Offline sales -> #offlinesales
  Open / close -> #opencloseregistry
  Cash management -> #cashManagement
  Sales history -> #saleshistory
  Scheduled deliveries -> #delivery
  Click & collect -> #clickAndCollectGrid
  Reload data -> reloadAll(false)
Inventory (section heading, expands the items below)
  Stocktake -> #stockTake
  Products -> #productManagement
  Stock transfer -> #stockTransfer
  Ordering -> #stockOrdering
  Customers -> #customers
  Users -> #userManagement
Reports (section heading, expands the items below)
  Register Closure -> #reportRegisterClosure
  Sales Summary -> #reportSalesSummary
  Inventory -> #reportInventory
  In transit -> #reportInTransit
  Product Performance -> #reportProductPerformance
  Gift Card -> #reportGiftCard
  Payment Type Summary -> #reportPaymentTypeSummary
  Store Credit Report -> #reportStoreCredit
  Surcharge Report -> #reportSurcharge
  Setup -> #setup
Session (section heading, expands the items below)
  Log out -> logoff()
  Change outlet|register -> changeOutlet()
  Open WMS -> openWMS()
  Set PIN code -> #pinCodeSetup
  Change language -> changeLanguage()
  Open WMS -> openWMS()
Sign-in: shown over any screen by the login dialog (loginPartial) until a session exists; start page `#/home` offers "Create an account" and "Sign in".
```

### Register (sell)

Route: `#/sell`. Template: `PosViews/sellPartial.html`; controller: `sellController`.

```text
heading "_register_" [page title]
heading "Main register"
if helperService.canShowCameraScanIcon():
  tap area <span> → helperService.cameraScan(false,true)
if isSearchVisible:
  input search "Search for products..." (model: searchText)
  if not showSearchResult:
    tap area <span> → toggleProductTiles()
  if showSearchResult:
    tap area <span> → toggleProductTiles()
  button "" → search()
  tap area <div> → cancelSearchMode()
  button "" → cancelSearchMode()
if viewLoaded:
  for each item in searchItems track by item.ProductID:
    link "{item.Name}" → processItem($event, '#tile-'+item.ProductID, item.ProductID, item.isFamily, !!item.QuickKeyID);$even
  if !searchItems.hasOwnProperty('0') && hideNoProdMessage !== true:
    text "No products found."
text "Swipe left/right"
if hasQuickKey:
  tap area <div> → searchType='quickKeySearch';search()
  link "Quick Key" → searchType='quickKeySearch';search()
if saleType === 'standaloneExchange':
  button "Return" → switchNoReceiptExchangeMode('Return') [disabled when noReceiptExchangeMode === 'Return']
  button "Sale" → switchNoReceiptExchangeMode('Sale') [disabled when noReceiptExchangeMode === 'Sale']
if helperService.showNewCheckoutUI(currentSale) === true:
  include: sellTopInfoNewPartial
if helperService.showNewCheckoutUI(currentSale) === true:
  include: sellCheckoutSectionNewPartial
if currentSale.CheckoutItems.length == 0:
  text "Add a product to your sale"
if helperService.showNewCheckoutUI(currentSale) === true:
  include: sellTotalSectionNewPartial
include: saleSummaryPartial, addCustomerPartial, addSalesRepresentativePartial, addShippingAddressPartial, customSaleDialogPartial, productOptionsP...
if !configService.isSite:
  include: backScreenTemplates
include: partialPaymentsDialogPartial, couponDialogPartial, giftCardSalePartial, giftCardPayPartial, scanSerialNumberDialogPartial, addSurchargePar...
component <ngm-keyboard>
button "({currency_symbol}) Fixed" → callback(false); [disabled when LLDiscountType === 'percentage']
button "(%) Percent" → callback(true) [disabled when LLDiscountType === 'flat']
component <ngm-keyboard>
text "Current price: {currency_symbol} {info1 | number:2}"
if activeButton=='standaloneReturn':
  button "({currency_symbol}) Price" → callback(activeButton);
if activeButton!='standaloneReturn':
  button "({currency_symbol}) Price" → callback('price');
if activeButton!='standaloneReturn':
  button "(%) Percent" → callback('percent');
component <ngm-keyboard> [float-precision=floatPrecision]
button "Apply" → callback(true, $event)
button "Open customer display" → openCustomerDisplay()
```

API calls: GET /ExternalApi/POS/PosCheckSerialNumber; POST /ExternalApi/POS/PosCheckoutProductsAvailability; GET /ExternalApi/POS/PosCloseRegistry; GET /ExternalApi/POS/PosCoupon; PUT /ExternalApi/POS/PosCustomer; GET /ExternalApi/POS/PosCustomer2; POST /ExternalApi/POS/PosGiftCard; POST /ExternalApi/POS/PosGiftCard/; GET /ExternalApi/POS/PosLoadCustomer; GET /ExternalApi/POS/PosLoadCustomer2; GET /ExternalApi/POS/PosLoyaltyLionCustomerRewards; DELETE /ExternalApi/POS/PosOrder; GET /ExternalApi/POS/PosOrder; POST /ExternalApi/POS/PosOrder; GET /ExternalApi/POS/PosOrder/GetNextSequence; GET /ExternalApi/POS/PosOrderList; DELETE /ExternalApi/POS/PosPing; GET /ExternalApi/POS/PosProductAvailability; GET /ExternalApi/POS/PosProductSearch2; GET /ExternalApi/POS/PosReceipt; POST /ExternalApi/POS/PosReceiptEmail; GET /ExternalApi/POS/PosRegistrySequence/GetCurrentSequence; GET /ExternalApi/POS/PosSurcharge

### Customer-facing second screen

Route: `#/secondScreen`. Template: `PosViews/secondScreen.html`; controller: `secondScreenController`.

```text
include: backScreenTemplates
```

API calls: GET /ExternalApi/POS/PosDelivery; GET /ExternalApi/POS/PosDeliveryDetails; POST /ExternalApi/POS/PosDeliveryDetails; PUT /ExternalApi/POS/PosDeliveryDetails; POST /ExternalApi/POS/PosDeliveryDetails/YearCalendarSettings

### Offline sales

Route: `#/offlinesales`. Template: `PosViews/offlineSalesPartial.html`; controller: `offlineSalesController`.

```text
heading "Offline sales" [page title]
heading "Offline sales"
component <ngm-date-range-selector> [date-from=filters.DateFrom, date-to=filters.DateTo, date-selected-callback=dateSelectedCallback(from, to), dat...
input search "Search for sales with customer name, receipt no" (model: searchInput) → enter: search()
if not isOnline === false:
  button "Sync" → sync() [disabled when isOnline === false]
if canClearOfflineSales && countOffline > 0:
  button "Clear ({countOffline})" → clearOfflineSalesDlg()
text "Register"
text "Receipt"
text "Date"
text "Sold by"
text "Customer"
text "Sale total"
for each row in data:
  tap area "{row.info.registryName} #{row.sale.OrderNumber} #{row.sale.O" <div> → rowClick(row)
dialog #viewErrorHistoryDialog:
  text "Close"
  button "×"
  button "Copy" → copyJSON() [disabled when isOnline === false]
  if errorText:
    text "Error: {errorText}"
  text "{selectedJSON | json}"
  button "Close"
include: customDialogPartial
```

API calls: GET /ExternalApi/POS/PosDiscounts; POST /ExternalApi/POS/PosOrder; GET /ExternalApi/POS/PosOutlet; GET /ExternalApi/POS/PosRegistrySequence/GetCurrentSequence

### Sales history

Route: `#/saleshistory`. Template: `PosViews/salesHistoryPartial.html`; controller: `salesHistoryController`.

```text
heading "Sales history" [page title]
heading "Sales View"
input search "Search..." (model: searchInput) → enter: inputSearch()
tap area <div> → openSalesHistoryFilterDialog()
if hideDetails !== true:
  text "..."
  link "No-receipt refund" → showStandaloneDialog()
  link "Quick refund" → fastRefund()
  link "No-receipt exchange" → showStandaloneExchangeDialog()
if helperService.canShowCameraScanIcon():
  tap area <span> → helperService.cameraScan(false,true)
if not gridType === 'pos':
  text "*Please enter a sale order number, customer name or an invoice number in the search field to\r populate all sales including backend sales f...
if gridType === 'pos':
  text "Order number"
  text "Date"
  text "Customer"
  text "User"
  text "Status"
  if canDelivery():
    text "Delivery tasks"
  text "Sale total"
  for each row in data:
    tap area "{row.OrderNumber} {getDateByFormat(row.OrderDate, 'D MMMM YY" <div> → selectItem(row)
if not gridType === 'pos':
  text "Order number"
  text "Date"
  text "Customer"
  text "Invoice number"
  text "Status"
  text "Sale total"
  for each row in dearSales:
    tap area "{row.SaleOrderNumber} {row.OrderDateFormated} {row.CustomerN" <div> → dearSalesSelectRow(row)
include: saleHistoryFilterDialogPartial, addCustomerPartial, returnPaymentsDialogPartial, returnCompliteDialogPartial, offlinePaymentsDialogPartial...
component <ngm-keyboard> [float-precision=floatPrecision]
button "Apply" → callback(true);
```

API calls: GET /ExternalApi/POS/PosCustomer2; POST /ExternalApi/POS/PosGiftCard; GET /ExternalApi/POS/PosLoadCustomer; GET /ExternalApi/POS/PosLoadCustomer2; DELETE /ExternalApi/POS/PosOrder; POST /ExternalApi/POS/PosOrder; GET /ExternalApi/POS/PosOrder/GetNextSequence; DELETE /ExternalApi/POS/PosOrderAttachment; POST /ExternalApi/POS/PosOrderAttachment; GET /ExternalApi/POS/PosOrderList; GET /ExternalApi/POS/PosOrderListDEARSales; GET /ExternalApi/POS/PosOutlet; GET /ExternalApi/POS/PosReceipt; POST /ExternalApi/POS/PosReceiptEmail; GET /ExternalApi/POS/PosSurcharge; GET /ExternalApi/POS/PosUser; POST /ExternalApi/POS/PosUtils

### Scheduled deliveries

Route: `#/delivery`. Template: `PosViews/deliveryPartial.html`; controller: `deliveryController`.

```text
heading "Scheduled deliveries" [page title]
form (name: filterForm):
  heading "Scheduled deliveries"
  component <ngm-date-range-selector> [date-from=currentFilter.fromDate, date-to=currentFilter.toDate, date-selected-callback=dateSelectedCallback(...
  input select (model: currentFilter.outletID) options: {item.OutletName}
  input select (model: currentFilter.status) options: Pending | In transit | Delivered | Cancelled
  input search "Search..." (model: searchText) → blur: blur()
  button "[calendar_2020]" → fullCalendar()
  if not cantExport:
    button "[export_2020]" → print() [disabled when (!data && !totals) || (data.length==0 && totals.length==0)]
text "Deliveries"
text "Delivery task"
text "Customer"
text "Shipping address"
text "Shipped by"
text "Preferred time"
if currentFilter.status == 'Pending':
  text "Actions"
if currentFilter.status == 'Cancelled':
  text "Cancelled on"
for each row in data:
  tap area "{row.DeliveryTaskNumber}" <div> → editRow(row)
  tap area "{row.CustomerName}" <div> → editRow(row)
  tap area "{row.ShipAddress}" <div> → editRow(row)
  tap area "{row.FormattedDate}" <div> → editRow(row)
  tap area "{row.FormattedTime}" <div> → editRow(row)
  if currentFilter.status == 'Pending':
    link "[checkMark]" → changeDeliveryStatus(row)
    link "[close]" → deactivateSchedule(row)
  if currentFilter.status == 'Cancelled':
    text "{row.FormattedVoidDate}"
include: deliveryDialogPartial, pdfWebPrintPartial, customDialogPartial
```

API calls: GET /ExternalApi/POS/StockTransferData

### Parked sales

Route: `#/salesparked`. Template: `PosViews/salesParkedPartial.html`; controller: `salesParkedController`.

```text
heading "Parked sales" [page title]
button "" → active = 1
heading "Sell"
component <uib-tabset> [active=active, justified=true]
  if isOnline:
    tap area "Parked sales Date Customer Receipt Sold by Note Sale total {" <uib-tab> → loadOnlineParkedSales()
  if isSite === false:
    tap area "Parked sales Date Customer Receipt Sold by Note Sale total {" <uib-tab> → loadOfflineParkedSales()
```

API calls: GET /ExternalApi/POS/PosOrderList

### Customers

Route: `#/customers`. Template: `PosViews/customersPartial.html`; controller: `customersController`.

```text
heading "Customers" [page title]
heading "Customers"
text "Total Customers"
heading "{customersTotal}"
button "Add new customer" → addCustomer()
form (name: filterForm):
  input search "Search for customer by name, email, address etc." (model: searchText) → enter: search()
  button "Search" → search()
  if helperService.canShowCameraScanIcon():
    tap area <span> → helperService.cameraScan(false,true)
text "Customers list"
text "Name"
text "Due"
if helperService.isLoyaltyEnabled():
  text "Loyalty points"
text "Store credit"
for each row in data:
  tap area "{row.Name} {abs(row.Account) | number:2} {row.Currency} {row" <div> → editCustomer(row)
include: addCustomerPartial
```

API calls: GET /ExternalApi/POS/PosCustomer2; GET /ExternalApi/POS/PosLoadCustomer; GET /ExternalApi/POS/PosLoadCustomer2

### Open / close register

Route: `#/opencloseregistry`. Template: `PosViews/openCloseRegistryPartial.html`; controller: `openCloseRegistryController`.

```text
heading "Open / close" [page title]
if loaded:
  if closeRegistryObj.ID === null:
    heading "POS register is closed"
    if lastCloseRegistryObj.ClosingTime:
      heading "Closed : {getFormatedDate(lastCloseRegistryObj.ClosingTime)}"
    tap area "{!!openingFloatAmount || openingFloatAmount === 0 ? (opening" <div> → showAmountDlg('#openingFloatAmount', 'floatAmount')
    input textarea "Enter Notes" (model: openingFloatNotes)
    button "Open register" → openRegistry()
  if closeRegistryObj.ID !== null:
    form (name: registryCloseForm) (submit → closeRegistry()):
      heading "Sell"
      text "{closeRegistryObj.OutletName} / {closeRegistryObj.RegistryNumber}"
      text "Opened: {getFormatedDate(closeRegistryObj.OpeningTime)}"
      if isOnline():
        button "Close register"
      if isOnline():
        tap area "Open / close Type Expected ({currency_symbol}) Counted ({cur" <div> → closeKeyborad()
      if not isOnline():
        text "Register closing is available online only."
dialog #closeRegisterConfirmPartial:
  tap area "x" <span> → closeDialog()
  text "Are you sure you want to close this register?"
  text "Your payment and sales totals will be finalised for this period."
  button "Close register" → closeRegistry(true);closeDialog()
  button "Cancel" → closeDialog()
component <ngm-keyboard>
if canChangeSign===true:
  button "+/-" → toggleSign();
button "Apply" → callback(true);
```

API calls: GET /ExternalApi/POS/PosCashManagement; POST /ExternalApi/POS/PosCashManagement; GET /ExternalApi/POS/PosCloseRegistry; POST /ExternalApi/POS/PosCloseRegistry; POST /ExternalApi/POS/PosOpenRegistry; GET /ExternalApi/POS/PosReceipt

### Cash management

Route: `#/cashManagement`. Template: `PosViews/cashManagementPartial.html`; controller: `cashManagementController`.

```text
heading "Cash management" [page title]
heading "Sell"
heading "Cash Balance {currency_symbol} {closeRegistryObj.CashExpected | number:2}"
button "Add cash" → addCash()
button "Remove cash" → removeCash()
if showOpenCashDrawer:
  button "Open cash drawer" → openCashDrawer()
text "Cash management"
text "Date"
text "User"
text "Notes"
text "Sale total"
for each operation in operations:
  text "{getDateByFormat(operation.OperationTime,'D MMMM YYYY')}"
  text "{operation.SalesRepresentative}"
  if operation.Reasons:
    text "{operation.Reasons}"
  text "{operation.Amount | number:2}"
  text "{getOperationType(operation.OperationType)} {getOperationSign(operation.OperationType)} ({currency_symbol})"
dialog #cashMovementModal:
  form (name: cashMovementForm) (submit → addMovement()):
    if movement.Type === 'Remove':
      heading "Remove cash"
    if movement.Type === 'Add':
      heading "Add cash"
    tap area "x" <span> → cancelDialog()
    if movement.Type === 'Add':
      label "Cash in"
    if movement.Type === 'Remove':
      label "Cash out"
    tap area "{movement.Amount}" <div> → showCasgManagementAmountDlg()
    if movement.Type === 'Add':
      label "Petty cash in"
    if movement.Type === 'Remove':
      label "Petty cash out"
    tap area "{movement.PettyAmount}" <div> → showCasgManagementPettyAmountDlg()
    label "Reason"
    input select "Select Reason" (model: movement.Reason) options: No reason | {reason}
    input textarea "Enter Custom Reason" (model: movement.CustomReason)
    button "Done" [disabled when !isValidAddMovementForm(cashMovementForm)]
    button "Cancel" → cancelDialog()
component <ngm-keyboard>
button "Apply" → callback(true);
component <ngm-keyboard>
button "Apply" → callback(true);
```

API calls: GET /ExternalApi/POS/PosCashManagement; POST /ExternalApi/POS/PosCashManagement; GET /ExternalApi/POS/PosCloseRegistry; GET /ExternalApi/POS/PosReceipt

### User management

Route: `#/userManagement`. Template: `PosViews/userManagementPartial.html`; controller: `userManagementController`.

```text
heading "Users" [page title]
heading "Users"
text "Total Users"
heading "{totalRecords}"
button "Add new user" → addPosUser()
input select "Select Role" (model: filters.RoleName) options: All roles | {role.RoleName}
input select (model: filters.OutletID) options: All | All outlets | {outlet.OutletName}
input search "Search for user by name, email, address etc." (model: filters.UserName) → enter: selectedPage = 1; search()
button "Search" → selectedPage = 1; search()
text "Users list"
text "Email address / username"
text "Name"
text "Role"
text "Outlet"
for each row in data track by row.UserId:
  tap area "{row.UserName} disabled {row.Name} {row.RoleName} {row.Outle" <div> → editPosUser(row)
dialog #editUserModal:
  form (name: saveUserForm) (submit → saveUser()):
    if editedUser.UserId === null:
      heading "Add new user"
    if not editedUser.UserId === null:
      heading "{editedUser.UserName} - disabled"
    tap area "x" <span> → cancelDialogModal(saveUserForm)
    label "Email address / login *"
    if editedUser.UserId === null:
      input email "Email address / Username" (model: editedUser.UserName; required) → blur: form.userName.$validate()
    if editedUser.UserId !== null:
      text "{editedUser.UserName}"
    label "Name"
    input text "Name" (model: editedUser.Name)
    label "Role *"
    input select (model: editedUser.RoleFullName) options: Select role | {role.RoleName}
    label "Outlet"
    input select (model: editedUser.PosOutletID) options: All outlets | {outlet.OutletName}
    if not editedUser.UserId === null:
      if editedUser.IsLockedOut === false:
        button "Deactivate user" → deactivationModalDialog()
      if editedUser.IsLockedOut === true:
        button "Activate user" → activateUser()
    if not editedUser.UserId === null:
      button "Save" [disabled when saveUserForm.$invalid]
    if editedUser.UserId === null:
      button "Add" [disabled when saveUserForm.$invalid]
    button "Cancel" → cancelDialogModal(saveUserForm)
dialog #deactivateUserModal:
  heading "Deactivate user"
  tap area "x" <span> → cancelDeactivationModal()
  heading "Are you sure?"
  dialog:
    text "Once deactivated, users won't be able to use the POS any more until activated again."
  button "Continue Cancel" → deactivateUser()
dialog #deleteUserModal:
  heading "Delete user"
  dialog:
    text "Are you sure you want to delete"
    text "{userToDelete.UserName}"
    text "from users?"
  button "Delete" → deletePosUser(userToDelete,true)
  button "Cancel" → hideDeleteUserDialog()
```

API calls: GET /ExternalApi/POS/PosOutlet; PUT /ExternalApi/POS/PosUserActivation; DELETE /ExternalApi/POS/PosUserManagement; GET /ExternalApi/POS/PosUserManagement; POST /ExternalApi/POS/PosUserManagement; PUT /ExternalApi/POS/PosUserManagement

### Dashboard

Route: `#/dashboard`. Template: `PosViews/dashboardPartial.html`; controller: `dashboardController`.

```text
heading "Dashboard" [page title]
heading "Overview dashboard"
input select (model: filters.OutletID) options: All outlets | {item.OutletName}
input select (model: filters.viewMode) options: Day | Week | Month
tap area <div> → prevPeriod()
text "{filters.periodLabel}"
tap area <div> → nextPeriod()
if canSeeProfitabilityMetrics:
  heading "Revenue"
  text "{currency_symbol} {totalValue.Revenue}"
  if outleDetails.Revenue.length > 5:
    button "Show all" → showDetails('Revenue')
  for each outlet in outleDetails.Revenue|limitTo:5:
    text "{outlet.Name}"
    text "{currency_symbol} {outlet.Value}"
heading "Sale count"
text "{totalValue.SaleCount}"
if outleDetails.SaleCount.length > 5:
  button "Show all" → showDetails('SaleCount')
for each outlet in outleDetails.SaleCount|limitTo:5:
  text "{outlet.Name}"
  text "{outlet.Value}"
heading "Return count"
text "{totalValue.ReturnCount}"
if outleDetails.ReturnCount.length > 5:
  button "Show all" → showDetails('ReturnCount')
for each outlet in outleDetails.ReturnCount|limitTo:5:
  text "{outlet.Name}"
  text "{outlet.Value}"
heading "Customer count"
text "{totalValue.CustomerCount}"
if outleDetails.CustomerCount.length > 5:
  button "Show all" → showDetails('CustomerCount')
for each outlet in outleDetails.CustomerCount|limitTo:5:
  text "{outlet.Name}"
  text "{outlet.Value}"
if canSeeProfitabilityMetrics:
  heading "Gross profit"
  text "{currency_symbol} {totalValue.GrossProfit}"
  if outleDetails.GrossProfit.length > 5:
    button "Show all" → showDetails('GrossProfit')
  for each outlet in outleDetails.GrossProfit|limitTo:5:
    text "{outlet.Name}"
    text "{currency_symbol} {outlet.Value}"
if canSeeProfitabilityMetrics:
  heading "COGS"
  text "{currency_symbol} {totalValue.COGS}"
  if outleDetails.COGS.length > 5:
    button "Show all" → showDetails('COGS')
  for each outlet in outleDetails.COGS|limitTo:5:
    text "{outlet.Name}"
    text "{currency_symbol} {outlet.Value}"
heading "Discount"
text "{currency_symbol} {totalValue.DiscountValue}"
if outleDetails.DiscountValue.length > 5:
  button "Show all" → showDetails('DiscountValue')
for each outlet in outleDetails.DiscountValue|limitTo:5:
  text "{outlet.Name}"
  text "{currency_symbol} {outlet.Value}"
heading "Discount %"
text "{totalValue.DiscountPercent} %"
if outleDetails.DiscountPercent.length > 5:
  button "Show all" → showDetails('DiscountPercent')
for each outlet in outleDetails.DiscountPercent|limitTo:5:
  text "{outlet.Name}"
  text "{outlet.Value} %"
heading "Basket value"
text "{currency_symbol} {totalValue.BasketValue}"
if outleDetails.BasketValue.length > 5:
  button "Show all" → showDetails('BasketValue')
for each outlet in outleDetails.BasketValue|limitTo:5:
  text "{outlet.Name}"
  text "{currency_symbol} {outlet.Value}"
heading "Basket size"
text "{totalValue.BasketSize}"
if outleDetails.BasketSize.length > 5:
  button "Show all" → showDetails('BasketSize')
for each outlet in outleDetails.BasketSize|limitTo:5:
  text "{outlet.Name}"
  text "{outlet.Value}"
... (1 more lines of the same kinds of fields omitted)
```

API calls: GET /ExternalApi/POS/PosDashboard; GET /ExternalApi/POS/StockTransferData

### Products

Route: `#/productManagement`. Template: `PosViews/productManagementPartial.html`; controller: `productManagementController`.

```text
if mode == 'management':
  heading "Products" [page title]
  heading "Inventory"
  text "Total Products"
  heading "{dataCount}"
  if not true:
    button "Import products in bulk"
  button "Add new product" → addNewProduct()
  button "Print" → nextStepPrintModal()
  form (name: filterForm):
    input search "Search for product by name or SKU" (model: filters.ProductName) → enter: search()
    button "Search" → search()
  text "Products"
  text "Image"
  text "Product name / SKU"
  text "Category"
  text "Brand"
  tap area <div> → printLabelCheck(row)
  if row.IsFamily===1:
    button "[openInnerTable_2020]" → toggleRow(row, $event)
  if row.IsFamily===0:
    button "[editPencilRecord_2020]" → editProduct(row)
  if !!row.ProductCode:
    text "{row.ProductCode}"
  text "{row.Name}"
  if !!row.IsFamily:
    text "(Family)"
  text "{row.Category}"
  text "{row.Brand}"
  if not row.isActive !== true:
    text "Product name / SKU"
    text "Category"
    text "Brand"
    text "Options"
    for each inner_row in row.Products:
      tap area <div> → printLabelCheck(inner_row);
      text "{inner_row.Name}"
      if !!inner_row.ProductCode:
        text "{inner_row.ProductCode}"
      if row.IsFamily===0:
        button "" → editProduct(inner_row)
      text "{inner_row.Category}"
      text "{inner_row.Brand}"
      if !!inner_row.Option1:
        text "{inner_row.ProductFamilyOption1Name}"
        text ":"
        text "{inner_row.Option1}"
      if !!inner_row.Option2:
        text "{inner_row.ProductFamilyOption2Name}"
        text ":"
        text "{inner_row.Option2}"
      if !!inner_row.Option3:
        text "{inner_row.ProductFamilyOption3Name}"
        text ":"
        text "{inner_row.Option3}"
include: addProductPartial, productLabelPrintPartial, productManagementPriceDlgPartial
```

API calls: GET /ExternalApi/POS/PosOutlet; GET /ExternalApi/POS/PosProductManagement; POST /ExternalApi/POS/PosProductManagement; PUT /ExternalApi/POS/PosProductManagement; GET /ExternalApi/POS/PosReceipt; GET /ExternalApi/POS/PosTemplate; GET /ExternalApi/POS/ProductDataParams

### Setup

Route: `#/setup`. Template: `PosViews/setupPartial.html`; controller: `setupController`.

```text
heading "Setup" [page title]
heading "Setup"
heading "Set up your POS system"
button "Scanner setup" → openScannerSetup()
button "Printer setup" → openPrinterSetup()
button "Payment setup" → openPaymentSetup()
if configService.isSite:
  button "Customer display setup" → opencustomerDisplaySetup()
include: scannerModalSetupPartial, paymentModalSetupPartial, printerModalSetupPartial
if configService.isSite:
  include: customerDisplaySetupDialogPartial
include: setupPrinterSelectFromListDlgPartial, linklyPinPadPairing, messageBoxPartial
```

API calls: none directly (shared/local data only)

### Set PIN code

Route: `#/pinCodeSetup`. Template: `PosViews/pinCodeSetupPartial.html`; controller: `setPinController`.

```text
heading "PIN SETUP"
if pinEnabled:
  if not isSuccessMessage:
    include: pinCodePartial
    text "{pinFormCaption}"
    button "Remove" → reset()
    button "Done" → save() [disabled when !finished]
  if isSuccessMessage:
    if pinToken:
      text "Your PIN code has been successfully saved."
    if !pinToken:
      text "Your PIN code has been successfully reset."
    button "Start a new sale" → openRegister()
if not pinEnabled:
  heading "The PIN code is not available. Switch on the PIN code support on the Cin7 Core POS integration setup page."
```

API calls: none directly (shared/local data only)

### Stocktake

Route: `#/stockTake`. Template: `PosViews/stockTakePartial.html`; controller: `stockTakeController`.

```text
heading "Stocktake" [page title]
heading "Inventory"
input select (model: activeTab) options: Draft | In progress | Completed | Cancelled
button "New Stocktake/Inventory Count" → addNew()
list: columns Stocktake
  rows: for each row in stockTakesData show {row.Name} | {getDateByFormat(row.date, 'DD MMMM YYYY')} | {row.OutletName} Categories : {row.categorie...
    text "{row.Name}"
    text "{getDateByFormat(row.date, 'DD MMMM YYYY')}"
    text "{row.OutletName}"
    if !!row.categories:
      text "Categories"
      text ":"
      text "{row.categories}"
    if !!row.brands:
      text "Brands"
      text ":"
      text "{row.brands}"
    if !!row.tags:
include: addStockTakePartial, stocktakeProcessPartial, customDialogPartial, stocktakeSetQuantityDialogPartial, stocktakeScanPartial, stockItemQuant...
```

API calls: GET /ExternalApi/POS/PosOutlet; GET /ExternalApi/POS/StockTake; PUT /ExternalApi/POS/Stocktake; GET /ExternalApi/POS/StocktakeProcess; POST /ExternalApi/POS/StocktakeProcess; PUT /ExternalApi/POS/StocktakeProcess; DELETE /ExternalApi/POS/StocktakeTask; GET /ExternalApi/POS/StocktakeTask; POST /ExternalApi/POS/StocktakeTask; PUT /ExternalApi/POS/StocktakeTask

### Stock transfer

Route: `#/stockTransfer`. Template: `PosViews/stockTransferPartial.html`; controller: `stockTransferController`.

```text
heading "Stock transfer" [page title]
heading "Stock transfer"
input select (model: activeTab) options: Draft | Completed | Cancelled
input search "Type text to search" (model: searchText) → enter: search()
button "New stock transfer" → addNew()
text "Transfer #"
text "Date"
text "From"
text "To"
text "User"
for each row in dataContainer.stockTransfersData:
  tap area "{row.Number} {row.dateDisplay === '' ? '' : (row.dateDisplay" <div> → editCurrent(row)
include: stockTransferProcessPartial
```

API calls: DELETE /ExternalApi/POS/StockTransfer; GET /ExternalApi/POS/StockTransfer; PUT /ExternalApi/POS/StockTransfer; GET /ExternalApi/POS/StockTransferData; GET /ExternalApi/POS/StockTransferProcess; POST /ExternalApi/POS/StockTransferProcess; PUT /ExternalApi/POS/StockTransferProcess

### Stock ordering

Route: `#/stockOrdering`. Template: `PosViews/stockOrderingPartial.html`; controller: `stockOrderingController`.

```text
heading "Ordering" [page title]
heading "Inventory"
input select (model: dataStatus) options: {item.statusName}
input search "Search" (model: searchText) → enter: search()
button "Add order"
link "From warehouse" → closeAddOrder('transfer')
link "From supplier" → closeAddOrder('purchase')
text "Ordering"
text "Order number"
text "Date"
text "From"
text "Status"
text "User"
for each row in stockOrderingData:
  tap area "{row.Number} {row.date || row.stRequiredBy} {row.FromName} {" <div> → currentDetails(row)
include: stockTransferOrderAddItemPartial, stockFamilyProductMatrixPartial, stockTransferOrderDetailsPartial, stockPurchaseOrderDetailsPartial
```

API calls: GET /ExternalApi/POS/PosPurchaseOrderData; GET /ExternalApi/POS/PosStockOrderingTasks; GET /ExternalApi/POS/StockTransferOrderData

### Report: register closure

Route: `#/reportRegisterClosure`. Template: `PosViews/reportCloseRegistryPartial.html`; controller: `reportCloseRegistryController`.

```text
heading "Register Closure" [page title]
heading "Reports"
component <ngm-date-range-selector> [date-from=currentFilter.fromDate, date-to=currentFilter.toDate, date-selected-callback=dateSelectedCallback(fr...
input select "All outlets" (model: currentFilter.outletID) options: All outlets | {item.OutletName}
input select "All Registers" (model: currentFilter.registryID) options: All registers | {item.RegistryName}
text "Register Closure"
text "Outlet name"
text "Register name"
text "Start date"
text "Close date"
text "New sales"
for each row in reportCloseRegistryData:
  tap area "{row.OutletName} {row.OutletName} {row.LocationAddress} {row" <div> → showDetails(row)
include: reportCloseRegistryDetailsPartial, prepareAnyDayClosurePartial
```

API calls: GET /ExternalApi/POS/PosReceipt; POST /ExternalApi/POS/PosReceiptEmail; GET /ExternalApi/POS/ReportCloseRegistry; GET /ExternalApi/POS/ReportCloseRegistryDetails; GET /ExternalApi/POS/StockTransferData

### Report: sales summary

Route: `#/reportSalesSummary`. Template: `PosViews/reportSalesSummaryPartial.html`; controller: `reportSalesSummaryController`.

```text
heading "Sales Summary" [page title]
form (name: filterForm):
  heading "Reports"
  component <ngm-date-range-selector> [date-from=currentFilter.fromDate, date-to=currentFilter.toDate, date-selected-callback=dateSelectedCallback(...
  input select (model: currentFilter.outletID) options: {item.OutletName}
  input select (model: reportType) options: {item.Text}
  button "[cog_2020]" → showCustomiser()
  button "[mail_2020]" → helperService.showDialog('#emailReportDialogPartial') [disabled when (!data && !totals) || (data.length==0 && totals.lengt...
  if not cantExport:
    button "[export_2020]" → exportReport() [disabled when (!data && !totals) || (data.length==0 && totals.length==0)]
  if getCurrentReportType().Type !='Summary':
    input search "Type text to search..." (model: currentFilter.searchText) → enter: getReport(true)
text "Sales Summary"
text "{getCurrentReportType().Text}"
if currentFilter.showProducts && getCurrentReportType().showProductEnabled:
  text "Product"
if (currentFilter.showProducts && getCurrentReportType().showProductEnabled) || getCurrentReportType().Type=='Product' and for each h in sel:
  text "{h.name}"
for each h in listOfColumns | filter:columnHeaderFilter(h):
  text "{h.name}"
if !!totals && totals.length>0 && currentFilter.showTotals == true:
  text "Totals"
  for each v in totals | filter:columnFilter(v):
    if v.datatype == 'money':
      text "{v.Value | number:2}"
      text "{currency_symbol}"
    if v.datatype == 'number':
      text "{v.Value | number: 2}"
    if v.datatype == 'percent':
      text "{v.Value | number: 2} %"
    if v.datatype == 'string':
      text "{v.Value}"
    if v.datatype == 'int':
      text "{v.Value | number:2}"
for each row in data:
  text "{($index == 0 || (data[$index - 1].Name != row.Name || (!currentFilter.showProducts && getCurrentReportType().showProductEnabled && data[$i...
  if currentFilter.showProducts && getCurrentReportType().showProductEnabled:
    text "{row.ProductName}"
  for each (k, v) in row.Values | filter:additionalColumnFilter(v):
    text "{v.Value}"
  for each (k, v) in row.Values | filter:columnFilter(v):
    if v.datatype == 'money':
      text "{v.Value | number:2}"
      text "{currency_symbol}"
    if v.datatype == 'number':
      text "{v.Value | number: 2}"
    if v.datatype == 'percent':
      text "{v.Value | number: 2} %"
    if v.datatype == 'string':
      text "{v.Value}"
    if v.datatype == 'int':
      text "{v.Value}"
include: emailReportDialogPartial, reportSalesSummaryColumnSelectorPartial
```

API calls: GET /ExternalApi/POS/ReportSalesSummary; POST /ExternalApi/POS/ReportSalesSummary; PUT /ExternalApi/POS/ReportSalesSummary; GET /ExternalApi/POS/StockTransferData

### Report: inventory

Route: `#/reportInventory`. Template: `PosViews/reportInventoryPartial.html`; controller: `reportInventoryController`.

```text
heading "Inventory" [page title]
form (name: filterForm):
  heading "Reports"
  input search "Type text to search..." (model: currentFilter.searchText) → enter: getReport(true)
  input select (model: currentFilter.outletID) options: {item.OutletName}
  input select (model: reportType) options: {item.Text}
  button "[cog_2020]" → showCustomiser()
  button "[mail_2020]" → helperService.showDialog('#emailReportDialogPartial') [disabled when (!data && !totals) || (data.length==0 && totals.lengt...
  if not cantExport:
    button "[export_2020]" → exportReport() [disabled when (!data && !totals) || (data.length==0 && totals.length==0)]
text "Inventory"
text "Product"
text "Outlet"
for each h in selectedAdditionalColumns:
  text "{h.name}"
for each h in listOfColumns | filter:columnHeaderFilter(h):
  text "{h.name}"
if data.length > 0:
  text "Overall totals"
  for each v in totals | filter:columnFilter(v):
    if v.datatype == 'money':
      text "{v.Value | number:2}"
      text "{currency_symbol}"
    if v.datatype == 'number':
      text "{v.Value | number: 2}"
    if v.datatype == 'percent':
      text "{v.Value | number: 2} %"
    if v.datatype == 'string':
      text "{v.Value}"
    if v.datatype == 'int':
      text "{v.Value | number:2}"
for each row in data:
  text "{($index == 0 || (data[$index - 1].ProductName != row.ProductName || data[$index - 1].ProductSKU != row.ProductSKU)) ? row.ProductName: ''}"
  text "{row.Name}"
  for each (k, v) in row.Values | filter:additionalColumnFilter(v):
    text "{v.Value}"
  for each (k, v) in row.Values | filter:columnFilter(v):
    if v.datatype == 'money':
      text "{v.Value | number:2}"
      text "{currency_symbol}"
    if v.datatype == 'number':
      text "{v.Value | number: 2}"
    if v.datatype == 'percent':
      text "{v.Value | number: 2} %"
    if v.datatype == 'string':
      text "{v.Value}"
    if v.datatype == 'int':
      text "{v.Value}"
include: emailReportDialogPartial, reportInventoryColumnSelectorPartial
```

API calls: GET /ExternalApi/POS/ReportInventory; POST /ExternalApi/POS/ReportInventory; PUT /ExternalApi/POS/ReportInventory; GET /ExternalApi/POS/StockTransferData

### Report: in transit

Route: `#/reportInTransit`. Template: `PosViews/reportInTransitPartial.html`; controller: `reportInTransitController`.

```text
heading "In transit" [page title]
form (name: filterForm):
  heading "Reports"
  input select (model: currentFilter.outletID) options: {item.OutletName}
  input search "Type text to search..." (model: currentFilter.searchText) → enter: getReport(true)
  button "[cog_2020]" → showCustomiser()
  button "[mail_2020]" → helperService.showDialog('#emailReportDialogPartial') [disabled when (!data && !totals) || (data.length==0 && totals.lengt...
  if not cantExport:
    button "[export_2020]" → exportReport() [disabled when (!data && !totals) || (data.length==0 && totals.length==0)]
text "In transit"
text "Product"
for each h in selectedAdditionalColumns:
  text "{h.name}"
for each h in listOfColumns | filter:columnHeaderFilter(h):
  text "{h.name}"
if data.length > 0:
  text "Overall totals"
  for each v in totals | filter:columnFilter(v):
    if v.datatype == 'money':
      text "{v.Value | number:2}"
      text "{currency_symbol}"
    if v.datatype == 'number':
      text "{v.Value | number: 2}"
    if v.datatype == 'percent':
      text "{v.Value | number: 2} %"
    if v.datatype == 'string':
      text "{v.Value}"
    if v.datatype == 'int':
      text "{v.Value | number:2}"
for each row in data:
  text "{($index == 0 || (data[$index - 1].ProductName != row.ProductName || data[$index - 1].ProductSKU != row.ProductSKU)) ? row.ProductName : ''}"
  for each (k, v) in row.Values | filter:additionalColumnFilter(v):
    text "{v.Value}"
  for each (k, v) in row.Values | filter:columnFilter(v):
    if v.datatype == 'money':
      text "{v.Value | number:2}"
      text "{currency_symbol}"
    if v.datatype == 'number':
      text "{v.Value | number: 2}"
    if v.datatype == 'percent':
      text "{v.Value | number: 2} %"
    if v.datatype == 'string':
      text "{v.Value}"
    if v.datatype == 'int':
      text "{v.Value}"
include: emailReportDialogPartial, reportInTransitColumnSelectorPartial
```

API calls: GET /ExternalApi/POS/ReportInTransit; POST /ExternalApi/POS/ReportInTransit; PUT /ExternalApi/POS/ReportInTransit; GET /ExternalApi/POS/StockTransferData

### Report: product performance

Route: `#/reportProductPerformance`. Template: `PosViews/reportProductPerformancePartial.html`; controller: `reportProductPerformanceController`.

```text
heading "Product Performance" [page title]
form (name: filterForm):
  heading "Reports"
  component <ngm-date-range-selector> [date-from=currentFilter.fromDate, date-to=currentFilter.toDate, date-selected-callback=dateSelectedCallback(...
  input select (model: currentFilter.outletID) options: {item.OutletName}
  input search "Type text to search..." (model: currentFilter.searchText) → enter: getReport(true)
  button "[cog_2020]" → showCustomiser()
  button "[mail_2020]" → helperService.showDialog('#emailReportDialogPartial') [disabled when (!data && !totals) || (data.length==0 && totals.lengt...
  if not cantExport:
    button "[export_2020]" → exportReport() [disabled when (!data && !totals) || (data.length==0 && totals.length==0)]
list: columns Product Performance
  rows: for each row in data show {($index == 0 || (data[$index - 1].ProductName !=  | {row.Name} | {v.Value} | {v.Value | number:2} {currency_symb...
include: emailReportDialogPartial, reportProductPerformanceColumnSelectorPartial
```

API calls: GET /ExternalApi/POS/ReportProdPerf; POST /ExternalApi/POS/ReportProdPerf; PUT /ExternalApi/POS/ReportProdPerf; GET /ExternalApi/POS/StockTransferData

### Report: gift card

Route: `#/reportGiftCard`. Template: `PosViews/reportGiftCardPartial.html`; controller: `reportGiftCardController`.

```text
heading "Gift Card" [page title]
form (name: filterForm):
  heading "Reports"
  input search "Search for a gift card number..." (model: giftCardFilter) → enter: getReport(true)
  button "[mail_2020]" → helperService.showDialog('#emailReportDialogPartial') [disabled when (!data && !totals) || (data.length==0 && totals.lengt...
  if not cantExport:
    button "[export_2020]" → exportReport() [disabled when (!data && !totals) || (data.length==0 && totals.length==0)]
text "Gift Card"
text "Gift card #"
text "Total sold"
text "Total redeemed"
text "Balance"
for each row in data:
  tap area "{row.GiftCardCode} {row.InitialBalance | number:2} {currency" <div> → showGiftCardDetails(row.ID)
include: emailReportDialogPartial
dialog #reportGiftCardDetails:
  heading "Gift card history"
  tap area "x" <span> → helperService.closeDialog('#reportGiftCardDetails')
  text "Date"
  text "Status"
  text "Amount"
  for each data in selectedDetails:
    text "{getDateByFormat(data.Date, 'LL')}"
    text "{data.Status}"
    text "{data.Amount | number:2}"
    text "{currency_symbol}"
```

API calls: GET /ExternalApi/POS/ReportGiftCard; POST /ExternalApi/POS/ReportGiftCard; PUT /ExternalApi/POS/ReportGiftCard

### Report: surcharge

Route: `#/reportSurcharge`. Template: `PosViews/reportSurchargePartial.html`; controller: `reportSurchargeController`.

```text
heading "Surcharge Report" [page title]
form (name: filterForm):
  heading "Reports"
  component <ngm-date-range-selector> [date-from=currentFilter.fromDate, date-to=currentFilter.toDate, date-selected-callback=dateSelectedCallback(...
  input select (model: currentFilter.outletID) options: {item.OutletName}
  label "Group register"
  input checkbox (model: groupRegister)
  button "[mail_2020]" → helperService.showDialog('#emailReportDialogPartial') [disabled when (!data && !totals) || (data.length==0 && totals.lengt...
  if not cantExport:
    button "[export_2020]" → exportReport() [disabled when (!data && !totals) || (data.length==0 && totals.length==0)]
text "Surcharge Report"
text "Outlet / register"
text "Surcharge"
for each h in listOfColumns:
  text "{h.name}"
if !!totals && totals.length>0:
  text "Overall totals"
  for each v in totals:
    if v.datatype == 'money':
      text "{v.Value | number:2}"
      text "{currency_symbol}"
    if v.datatype == 'number':
      text "{v.Value | number: 2}"
    if v.datatype == 'percent':
      text "{v.Value | number: 2} %"
    if v.datatype == 'string':
      text "{v.Value}"
    if v.datatype == 'int':
      text "{v.Value}"
for each row in data:
  text "{($index == 0 || data[$index - 1].Name != row.Name) ? row.Name : ''}"
  text "{row.ProductName}"
  for each (k, v) in row.Values:
    if v.datatype == 'money':
      text "{v.Value | number:2}"
      text "{currency_symbol}"
    if v.datatype == 'number':
      text "{v.Value | number: 2}"
    if v.datatype == 'percent':
      text "{v.Value | number: 2} %"
    if v.datatype == 'string':
      text "{v.Value}"
    if v.datatype == 'int':
      text "{v.Value}"
include: emailReportDialogPartial
```

API calls: GET /ExternalApi/POS/ReportSurcharge; POST /ExternalApi/POS/ReportSurcharge; PUT /ExternalApi/POS/ReportSurcharge; GET /ExternalApi/POS/StockTransferData

### Report: payment type summary

Route: `#/reportPaymentTypeSummary`. Template: `PosViews/reportPaymentTypeSummaryPartial.html`; controller: `reportPaymentTypeSummaryController`.

```text
heading "Payment Type Summary" [page title]
form (name: filterForm):
  heading "Reports"
  component <ngm-date-range-selector> [date-from=currentFilter.fromDate, date-to=currentFilter.toDate, date-selected-callback=dateSelectedCallback(...
  input select (model: currentFilter.outletID) options: All outlets | {item.OutletName}
  input select (model: currentFilter.registryID) options: All Registers | {item.RegistryName}
  input select (model: currentFilter.userID) options: All Users | {item.UserName}
  button "[mail_2020]" → helperService.showDialog('#emailReportDialogPartial') [disabled when (!data && !totals) || (data.length==0 && totals.lengt...
  if not cantExport:
    button "[export_2020]" → exportReport() [disabled when (!data && !totals) || (data.length==0 && totals.length==0)]
list: columns Payment Type Summary
dialog #detailsModal:
  if showModal:
    heading "Payment Type Summary:"
    heading "{selectedData.MethodName}"
    tap area "x" <span> → goBack()
    grid (grid)
include: emailReportDialogPartial
```

API calls: GET /ExternalApi/POS/ReportPaymentTypeSummary; POST /ExternalApi/POS/ReportPaymentTypeSummary; PUT /ExternalApi/POS/ReportPaymentTypeSummary; GET /ExternalApi/POS/StockTransferData

### Report: store credit

Route: `#/reportStoreCredit`. Template: `PosViews/reportStoreCreditPartial.html`; controller: `reportStoreCreditController`.

```text
heading "Store Credit Report" [page title]
form (name: filterForm):
  heading "Reports"
  component <ngm-date-range-selector> [date-from=currentFilter.fromDate, date-to=currentFilter.toDate, date-selected-callback=dateSelectedCallback(...
  input select (model: currentFilter.type) options: {item.name}
  button "[mail_2020]" → helperService.showDialog('#emailReportDialogPartial') [disabled when (!data && !totals) || (data.length==0 && totals.lengt...
  if not cantExport:
    button "[export_2020]" → exportReport() [disabled when (!data && !totals) || (data.length==0 && totals.length==0)]
text "Store Credit"
if currentFilter.type === 'customer':
  text "Customer"
if currentFilter.type === 'date':
  text "Date"
text "Opening balance"
text "Total issued"
text "Total redeemed"
text "Balance"
for each row in data:
  if currentFilter.type === 'customer':
    text "{row.Name}"
  if currentFilter.type === 'date':
    text "{row.DateFormated || row.Name}"
  text "{row.OpeningBalance | number:2}"
  text "{currency_symbol}"
  text "{row.IssuedAmount | number:2}"
  text "{currency_symbol}"
  text "{row.RedeemedAmount | number:2}"
  text "{currency_symbol}"
  text "{row.StoreCredits | number:2}"
  text "{currency_symbol}"
include: emailReportDialogPartial
```

API calls: GET /ExternalApi/POS/ReportStoreCredit; POST /ExternalApi/POS/ReportStoreCredit; PUT /ExternalApi/POS/ReportStoreCredit

### Click and collect

Route: `#/clickAndCollectGrid`. Template: `PosViews/clickAndCollectGridPartial.html`; controller: `clickAndCollectGridController`.

```text
heading "Click & collect" [page title]
form (name: filterForm):
  heading "Click & collect"
  input search "Search by customer phone or email" (model: filters.CustomerSearch) → enter: search()
  input search "Search by order or invoice #" (model: filters.SaleNumberSearch) → enter: search()
  button "Search" → search()
text "Order #"
text "Date"
text "Customer"
text "Invoice #"
text "Status"
text "Amount"
for each row in data:
  tap area "{row.SaleOrderNumber} {getDateByFormat(row.OrderDateFormated" <div> → selectRow(row)
include: clickAndCollectModalDialogPartial, customDialogPartial
```

API calls: GET /ExternalApi/POS/PosClickAndCollect

### Home (start form)

Route: `#/home`. Template: `PosViews/homePartial.html`; controller: `homeController`.

```text
if showStartForm:
  dialog #showStartForm:
    heading "The ultimate solution for your business"
    text "New to Cin7 Core POS?"
    button "Create an account" → callGetStarted()
    text "or"
    button "Sign in" → callLogin()
```

API calls: none directly (shared/local data only)

### Certificate error

Route: `#/certificate-error`. Template: `PosViews/certificate-error.component.html`; controller: `certificateErrorComponent`.

```text
text "You have an old Android device which faces a certificate problem when connecting to our API server. Please update your device to the latest v...
link "Link" → openLink()
```

API calls: none directly (shared/local data only)

## Dialogs, panels and sub-views

### Panel: Add Customer

included by `customersPartial`, `salesHistoryPartial`, `sellPartial`. Template: `PosViews/addCustomerPartial.html`.

```text
dialog #customerModel:
  if mode=='search':
    form (name: searchCustomerForm) (submit → searchCustomer()):
      heading "Add customer to the sale"
      tap area "x" <span> → cancelDialog()
      if !showViewDetails:
        input search "Search by name, email, address, etc." (model: searchTextLive; required)
      if showViewDetails:
        input search "Search by name, email, address, etc." (model: searchTextLive; required)
      if isOnline === true:
        button "+" → switchMode(true)
      if isOnline === true:
        if isOnline === true:
          button "+" → switchMode(true)
      text "Only the first 10 customers will be shown. You can also add a new customer here."
      for each c in customerSearchList track by c.ID:
        dialog:
          dialog:
            text "{c.Name}"
            if showViewDetails === true:
              button "View details" → viewDetailsButtonHandler(c)
          dialog:
            if c.LoadedFromLocalDb !== true:
              dialog:
                text "Balance"
                text ": {formatBalance(c.Account)}"
            if helperService.isLoyaltyEnabled() && c.EnableLoyaltyPoints === true && enableLoyalty === true && c.LoadedFromLocalDb !== true:
              dialog:
                text "Loyalty points"
                text ": {c.LoyaltyPoints |currency}"
            if c.LoadedFromLocalDb !== true:
              dialog:
... (64 more lines of the same kinds of fields omitted)
```

API calls: none directly (shared/local data only)

### Dialog: Add Notes Dialog

included by `sellPartial`. Template: `PosViews/addNotesDialogPartial.html`.

```text
dialog #addNotesDialogModal:
  if $parent.noteMode=='note':
    heading "Sale note"
  if $parent.noteMode=='park':
    heading "Would you like to park this sale?"
  tap area "x" <span> → closeAddSaleNoteDialog(true)
  input textarea (model: $parent.currentNote)
  button "Done Park" → closeAddSaleNoteDialog(false)
  button "Close" → closeAddSaleNoteDialog(true)
```

API calls: none directly (shared/local data only)

### Panel: Add Product

included by `productManagementPartial`. Template: `PosViews/addProductPartial.html`.

```text
dialog #addProductModal:
  form (name: modify.addProductForm) (submit → modifyProduct()):
    if mode=='new':
      heading "Add new product"
    if mode=='edit':
      heading "Modify product"
    tap area "x" <span> → goBack()
    label "SKU *"
    input text "Enter Product SKU" (model: newProduct.ProductCode; required)
    label "Name *"
    input text "Enter Product Name" (model: newProduct.Name; required)
    label "Type *"
    input select (model: newProduct.Type) options: Select product type | {item.Name}
    label "Barcode"
    input text "Enter Barcode" (model: newProduct.Barcode)
    label "Category *"
    input select (model: newProduct.Category) options: Select product category | {item.Name}
    label "Location"
    input select (model: newProduct.DefaultLocation) options: Select default location | {item.Name}
    if newProduct.Type !== 'Non Inventory':
      label "Costing method *"
      input select (model: newProduct.CostingMethod) options: Select costing method | {item.Name}
    if newProduct.Type === 'Non Inventory':
      label "Expense account *"
      input select (model: newProduct.ExpenseAccount) options: Select expense account | {item.Name}
    label "Unit of measure *"
    input select (model: newProduct.DefaultUnitOfMeasure) options: Select product category | {item.Name}
    if newProduct.Type === 'Non Inventory':
      tap area "Always show quantity {newProduct.AlwaysShowQuantity}" <div> → showPriceDlg('AlwaysShowQuantity')
    if useOutletSKU:
      label "Outlet level SKU"
      input text "Enter Outlet level SKU" (model: newProduct.OutletSKU)
... (13 more lines of the same kinds of fields omitted)
```

API calls: none directly (shared/local data only)

### Panel: Add Sales Representative

included by `sellPartial`. Template: `PosViews/addSalesRepresentativePartial.html`.

```text
dialog #SalesRepresentativeModel:
  if mode=='search':
    form (name: searchSalesRepresentativeForm) (submit → searchSalesRepresentative()):
      heading "Add a sales representative to the sale"
      tap area "x" <span> → cancelDialog()
      input search "Search by email" (model: searchText)
      text "Only first"
      text "{searchLimit}"
      text "sale representatives will be shown"
      input checkbox "Hide users assigned to all locations" (model: hideUsersAssignedToAllLocations) → change: hideUsersAssignedToAllLocationsChang...
      label "Hide users assigned to all locations"
      for each c in salesRepresentativeSearchList track by c.ID:
        tap area "{c.Name}" <div> → selectSalesRepresentative(c);addSalesRepresentative();
      button "Cancel" → cancelDialog()
```

API calls: none directly (shared/local data only)

### Panel: Add Shipping Address

included by `sellPartial`. Template: `PosViews/addShippingAddressPartial.html`.

```text
dialog #SalesShippingAddressModel:
  form (name: searchSalesShippingAddressForm) (submit → searchShippingAddress()):
    heading "Select a shipping address to add to the sale"
    tap area "x" <span> → cancelDialog()
    input search "Search by address" (model: searchText)
    if resultCount:
      if c.displayAddress and for each c in shippingAddressSearchList track by c.ID:
        tap area "{c.displayText}" <div> → selectSalesShippingAddress(c);addSalesShippingAddress();
    if !resultCount:
      text "{getEmptyText()}"
    button "Cancel" → cancelDialog()
```

API calls: none directly (shared/local data only)

### Panel: Add Stock Take

included by `stockTakePartial`. Template: `PosViews/addStockTakePartial.html`.

```text
dialog #editStocktakeModal:
  form (name: addStockTakeForm) (submit → modifyStocktake()):
    if mode=='new':
      heading "Add a new stocktake"
    if mode=='edit':
      heading "Modify stocktake"
    tap area "x" <span> → goBack('edit')
    label "Name *"
    input text (model: newStocktake.name; required)
    label "Outlet"
    input select (model: newStocktake.outletID) options: {item.name}
    label "Account *"
    input select (model: newStocktake.account) options: {item.displayName}
    label "Show on hand"
    input checkbox (model: newStocktake.showOnhand)
    label "Lock products"
    input checkbox (model: newStocktake.lockSell)
    input search "Category" (model: selectedCategory)
    if newStocktake.categories.length > 0:
      for each item in newStocktake.categories:
        tap area "{item} x" <div> → removeFromList(newStocktake.categories, item)
    if newStocktake.categories.length > 0:
      for each item in newStocktake.categories:
        tap area "{item} x" <div> → removeFromList(newStocktake.categories, item)
    input search "Brand" (model: selectedBrand)
    if newStocktake.brands.length > 0:
      for each item in newStocktake.brands:
        tap area "{item} x" <div> → removeFromList(newStocktake.brands, item)
    if newStocktake.brands.length > 0:
      for each item in newStocktake.brands:
        tap area "{item} x" <div> → removeFromList(newStocktake.brands, item)
    input search "Tag" (model: selectedTag)
... (11 more lines of the same kinds of fields omitted)
```

API calls: none directly (shared/local data only)

### Panel: Add Surcharge

included by `sellPartial`. Template: `PosViews/addSurchargePartial.html`.

```text
dialog #SurchargeModal:
  form (name: searchSurchargeForm):
    heading "Apply surcharge"
    tap area "x" <span> → cancelDialog()
    if surcharges[0].Name === 'Amex':
      text "Pay with Amex"
    for each sur in surcharges:
      button "{sur.Name} ({currency_symbol} {sur.CalculatedValueWithTax})" → selectSurcharge(sur);addSurcharge();
    button "No surcharge" → selectSurcharge(null);addSurcharge();
```

API calls: none directly (shared/local data only)

### Panel: Availability Check

included by `sellPartial`. Template: `PosViews/availabilityCheckPartial.html`.

```text
text "{availabilityObject.name}"
text "availability"
button "Back to list" → goBack()
if availabilityObject.canSeeItemValue:
  text "Average cost:"
  text "{availabilityObject.averageCost}"
input select (model: availabilityObject.FilterName) options: {item.name}
input select (model: availabilityObject.FilterSKU) options: {item.name}
input select (model: availabilityObject.FilterOutlet) options: {item.name}
if availabilityObject.maxLevel>0:
  input select (model: availabilityObject.FilterOption1) options: {item.name}
if availabilityObject.maxLevel>0 && availabilityObject.maxLevel>1:
  input select (model: availabilityObject.FilterOption2) options: {item.name}
if availabilityObject.maxLevel>0 && availabilityObject.maxLevel>2:
  input select (model: availabilityObject.FilterOption3) options: {item.name}
text "Name"
if availabilityObject.maxLevel>0:
  text "Variation"
text "Quantity"
text "SKU"
if availabilityObject.maxLevel>0:
  text "{availabilityObject.option1Name}"
if availabilityObject.maxLevel>1:
  text "{availabilityObject.option2Name}"
if availabilityObject.maxLevel>2:
  text "{availabilityObject.option3Name}"
text "Outlet"
for each row in availabilityObject.displayCheckData:
  text "{row.Name}"
  if availabilityObject.maxLevel>0:
    text "{row.Option1}"
    if row.Option2 || row.Option3:
... (15 more lines of the same kinds of fields omitted)
```

API calls: none directly (shared/local data only)

### Panel: Back Screen Templates

included by `secondScreen`, `sellPartial`. Template: `PosViews/backScreenTemplates.html`.

```text
if secondScreenState == null || secondScreenState !== 'off':
  if currentSale && currentSale.Customer && currentSale.Customer.ID:
    text "{currentSale.Customer.Name}"
    if customerContact && customerContact.Email || currentSale.SelectedContact && currentSale.SelectedContact.ID:
      text "{customerContact ? customerContact.Email : currentSale.SelectedContact.Email}"
  if currentSale.OrderNumber && (secondScreenState === 'payment' || secondScreenState === 'finish'):
    text "Order: #{currentSale.OrderNumber}"
  if currentSale && currentSale.CheckoutItems.length && secondScreenState !== 'finish':
    list: columns Quantity | Price | Total
      rows: for each item in currentSale.CheckoutItems track by item.ID show <> | {item.Name} {item.OptionLine} | {item.Count | roundQty} | {item.F...
  if secondScreenState === 'finish':
    if customizedUI:
      include PosImages/checkMark3.svg
    if !(lastSaleType && (lastSaleType === 'return' || lastSaleType === 'standaloneReturn' || lastSaleType === 'standaloneExchange')):
      text "Sale"
      text "#"
      text "{currentSale.OrderNumber}"
      text "completed."
    if lastSaleType && (lastSaleType === 'return' || lastSaleType === 'standaloneReturn' || lastSaleType === 'standaloneExchange'):
      text "Refund completed."
    if customerContact && customerContact.Email || currentSale.SelectedContact && currentSale.SelectedContact.ID:
      text "Electronic receipt is sent to e-mail: {customerContact ? customerContact.Email : currentSale.SelectedContact.Email}."
    if currentSale.LoyaltyPoints > 0:
      if currentSale.LoyaltyPoints > 0:
        text "{currentSale.LoyaltyPoints}"
        text "Loyalty points earned"
    text "Thank you for the purchase!"
  if secondScreenState === 'sale' || secondScreenState === 'payment':
    text "Subtotal"
    text "{currentSale.SubTotal | currency}"
    if currentSale.DiscountValue:
      text "Discount"
... (13 more lines of the same kinds of fields omitted)
```

API calls: none directly (shared/local data only)

### Dialog: Cash Rounding Dialog

included by `sellPartial`. Template: `PosViews/cashRoundingDialogPartial.html`.

```text
dialog #cashRoundingModal:
  heading "Rounding"
  tap area "x" <span> → currentSale.processZero=false;cancelCashRoundingDialog()
  if roundedAmount>0:
    dialog:
      text "Collect {currency_symbol} {roundedAmount}?"
  if roundedAmount<=0:
    dialog:
      text "There is nothing to pay. Continue?"
  if roundedAmount>0:
    button "Collect" → currentSale.processZero=true;cashPay(roundedAmount);cancelCashRoundingDialog()
  if roundedAmount<=0:
    button "Continue" → currentSale.processZero=true;cashPay(roundedAmount);cancelCashRoundingDialog()
```

API calls: none directly (shared/local data only)

### Dialog: Change Password

Template: `PosViews/changePasswordPartial.html`.

```text
dialog:
  form (name: confirmPasswordForm) (submit → confirm()):
    heading "Change password"
    input password "Password" (model: password1; required)
    tap area <span> → showPassword1Warning()
    if confirmPasswordForm.password1.$error.required && canShowErrors && warningVisibility.Password1 == true:
      text "Password is required."
    if confirmPasswordForm.password1.$error.required && canShowErrors && warningVisibility.Password1 == true:
      text "Password is required."
    input password "Confirm Password" (model: password2; required)
    tap area <span> → showPassword2Warning()
    if !confirmPasswordForm.password2.$error.required && confirmPasswordForm.password2.$error.equalToValidator && canShowErrors && warningVisibi:
      text "Confirm password doesn't match"
    if confirmPasswordForm.password2.$error.required && canShowErrors && warningVisibility.Password2 == true:
      text "Confirm password is required."
    if !confirmPasswordForm.password2.$error.required && confirmPasswordForm.password2.$error.equalToValidator && canShowErrors && warningVisibi:
      text "Confirm password doesn't match"
    if confirmPasswordForm.password2.$error.required && canShowErrors && warningVisibility.Password2 == true:
      text "Confirm password is required."
    button "Confirm"
```

API calls: none directly (shared/local data only)

### Dialog: Checkout Products Availability Insufficient Dialog

included by `sellPartial`. Template: `PosViews/checkoutProductsAvailabilityInsufficientDialogPartial.html`.

```text
dialog #checkoutProductsAvailabilityInsufficientDialogPartial:
  heading "Insufficient stock"
  dialog #customModalDlgText:
    text "Insufficient stock quantity detected in the following sale item(s):"
    text "{insufficientQuantitySKUs}."
    text "Are you sure you want to proceed with the sale?"
  button "Yes" → closeCheckoutProductsAvailabilityInsufficientDialog(); goPayment();
  button "No" → closeCheckoutProductsAvailabilityInsufficientDialog();
```

API calls: none directly (shared/local data only)

### Dialog: Click And Collect Modal Dialog

included by `clickAndCollectGridPartial`, `salesHistoryPartial`. Template: `PosViews/clickAndCollectModalDialogPartial.html`.

```text
dialog #clickAndCollectModel:
  heading "Fulfillment"
  tap area "x" <span> → cancelDialog()
  dialog #clickAndCollectDetails:
    text "Order info:"
    text "{fulfillment.SaleOrderNumber}"
    text "Customer:"
    text "{fulfillment.CustomerName}"
    text "Phone:"
    text "{fulfillment.CustomerPhone}"
    text "Email:"
    text "{fulfillment.CustomerEmail}"
    text "Billing address:"
    text "{fulfillment.BillingAddress}"
    text "Customer reference #:"
    text "{fulfillment.CustomerReference}"
    text "Invoice #:"
    text "{fulfillment.InvoiceNumber}"
    text "Invoice date:"
    text "{fulfillment.InvoiceDateFormated}"
    text "Due date:"
    text "{fulfillment.DueDateFormated}"
  dialog:
    text "Goods to pick"
    text "{fulfillment.PickLines.sum("Quantity")}"
    text "Already picked"
    text "{fulfillment.PickedLines.sum("Quantity")}"
    if fulfillment.PickLines.sum("Quantity") !== 0:
      dialog:
        text "Goods to pick"
      for each product in fulfillment.PickLines:
        tap area "{product.Name} {product.SKU} {product.BatchSN} Available: {p" <div> → pickItemFunc(product)
... (16 more lines of the same kinds of fields omitted)
```

API calls: none directly (shared/local data only)

### Dialog: Click And Collect Scan Batch Dialog

included by `clickAndCollectModalDialogPartial`. Template: `PosViews/clickAndCollectScanBatchDialogPartial.html`.

```text
dialog #scanBatchDialogPartial:
  form (name: scanBatchForm) (submit → submitScanBatch()):
    heading "Enter serial/batch #"
    tap area "x" <span> → closeScanBatchDialog(true)
    input text "Serial/Batch #" (model: scanedBatch.value; required; maxlength 50)
    if helperService.canShowCameraScanIcon():
      tap area <span> → helperService.cameraScan(false,true)
    button "Confirm"
dialog #notFoundBatchDialogPartial:
  heading "Enter serial/batch #"
  tap area "x" <span> → closeNotFoundBatchDialog();
  dialog #customModalDlgText:
    text "Batch/Serial Number Not Found"
```

API calls: none directly (shared/local data only)

### Dialog: Coupon Dialog

included by `sellPartial`. Template: `PosViews/couponDialogPartial.html`.

```text
dialog #couponlDialogPartial:
  form (name: couponlDialogForm):
    heading "Apply coupon"
    tap area "x" <span> → helperService.closeDialog('#couponlDialogPartial');couponDialogCallback('cancel')
    label "Coupon code"
    input text (model: $parent.couponCode; required)
    if canDismissCoupon():
      button "Dismiss" → helperService.closeDialog('#couponlDialogPartial');couponDialogCallback('dismiss')
    button "Apply" → checkCouponIsValidAndProcess('ok') [disabled when couponlDialogForm.$invalid]
```

API calls: none directly (shared/local data only)

### Dialog: Credit Card Processing Error

included by `sellPartial`. Template: `PosViews/creditCardProcessingErrorPartial.html`.

```text
dialog #creditCardProcessingErrorModal:
  heading "Error"
  dialog:
    text "An error occurred during payment processing."
  if creditCardError.errorText.length > 0:
    dialog:
      text "{creditCardError.errorText}"
  dialog:
    text "Was the payment successful?"
  button "Yes" → creditCardError.addFailedCreditCardPayment = true; closeCreditCardProcessingErrorDialog()
  button "No" → creditCardError.addFailedCreditCardPayment = false; closeCreditCardProcessingErrorDialog()
dialog #creditCardProcessingErrorModal2:
  heading "Error"
  dialog:
    text "An error occurred during payment processing."
  if creditCardError.errorText.length > 0:
    dialog:
      text "{creditCardError.errorText}"
  button "OK" → creditCardError.addFailedCreditCardPayment = false; closeCreditCardProcessingErrorDialog2()
```

API calls: none directly (shared/local data only)

### Dialog: Custom Dialog2

included by `salesHistoryPartial`, `sellPartial`. Template: `PosViews/customDialog2Partial.html`.

```text
dialog #customModalDlg2:
  heading "{customModalDlg2Caption}"
  for each btn in customModalDlg2Buttons | filter:{value:'cancel'} track by $index:
    tap area "x" <span> → helperService.closeDialog('#customModalDlg2');callbackModal2(btn.value)
  if !!customModalDlg2Text && customModalDlg2Text.length>0:
    dialog #customModalDlg2Text:
      text "{customModalDlg2Text}"
  for each btn in customModalDlg2Buttons track by $index:
    button "{btn.name}" → helperService.closeDialog('#customModalDlg2');callbackModal2(btn.value)
```

API calls: none directly (shared/local data only)

### Dialog: Custom Dialog

included by `clickAndCollectGridPartial`, `deliveryPartial`, `loginPartial`, `offlineSalesPartial`. Template: `PosViews/customDialogPartial.html`.

```text
dialog #customModalDlg:
  tap area "x" <span> → helperService.closeDialog('#customModalDlg', callbackModalCancel)
  button "Delete" → helperService.closeDialog('#customModalDlg', null, true);callbackModal()
  button "Close" → helperService.closeDialog('#customModalDlg', callbackModalCancel)
dialog #customModalDlg3:
  tap area "x" <span> → helperService.closeDialog('#customModalDlg3', callbackModalCancel)
  label "Do not show this warning again"
  input checkbox (model: checkBoxValue)
  button "Delete" → helperService.closeDialog('#customModalDlg3');callbackModal3()
  button "Cancel" → helperService.closeDialog('#customModalDlg3', callbackModalCancel)
```

API calls: none directly (shared/local data only)

### Dialog: Custom Sale Dialog

included by `sellPartial`; referenced from `sellController`. Template: `PosViews/customSaleDialogPartial.html`.

```text
dialog #customSaleDialogPartial:
  form (name: customSaleForm) (submit → addCustomSaleProduct(this)):
    heading "Custom sale"
    tap area "x" <span> → closeCustomSaleDialog()
    label "Product name *"
    input text "Enter Product's Name" (model: $parent.customSale.Title; required)
    tap area "Quantity {$parent.customSale.Quantity}" <div> → showqQickPayDlg()
    tap area "Price {$parent.customSale.Price|currency}" <div> → showQuickPaySumDlg()
    button "Add" [disabled when customSaleForm.$invalid]
    button "Cancel" → closeCustomSaleDialog()
component <ngm-keyboard> [float-precision=floatPrecision]
button "Apply" → callback(true, $event);
component <ngm-keyboard>
button "Apply" → callback(true, $event);
```

API calls: none directly (shared/local data only)

### Dialog: Customer Display Setup Dialog

included by `setupPartial`. Template: `PosViews/customerDisplaySetupDialogPartial.html`.

```text
dialog #customerDisplaySetupModal:
  form (name: customerDisplaySetup):
    heading "Customer display setup"
    tap area "x" <span> → closeCustomerDisplaySetup();
    input checkbox (model: secondScreenSettings.enableAuto)
    label "Enable automatic opening"
    if configService.isSite:
      tap area <span> → openCustomerScreen()
    label "Open customer display"
    button "Save" → saveCustomerDisplaySetup()
    button "Close" → closeCustomerDisplaySetup();
```

API calls: none directly (shared/local data only)

### Panel: Date Range Selector

Template: `PosViews/dateRangeSelector.html`.

```text
tap area "Date {filters.FormatedDateRange}" <div> → showDateSelector()
input text (model: filters.DateFrom; required; readonly)
input text (model: filters.DateTo; required; readonly)
button "Apply" → apply() [disabled when disableApplyButton]
for each item in dateRanges:
  tap area "{item.Name}" <li> → setDateRange(item)
button "Apply" → apply() [disabled when disableApplyButton]
if allowReset:
  button "Reset" → reset()
tap area <div> → hideDateSelector()
```

API calls: none directly (shared/local data only)

### Dialog: Delivery Dialog

included by `deliveryPartial`, `salesHistoryPartial`, `sellPartial`. Template: `PosViews/deliveryDialogPartial.html`.

```text
dialog #deliveryDialogModel:
  button "" → active = 1
  heading "{caption}"
  tap area "x" <span> → cancelDialog()
  form (name: deliveryForm) (submit → false;):
    component <uib-tabset> [active=active, justified=true]
      component <uib-tab> [index=0, heading=Contact]
        label "Customer name *"
        input text "Enter Customer Name" (model: form.customerName; required; readonly) → mobile-click: addCustomer()
        label "Contact *"
        input select "Select Contact" (model: form.contactID) options: Select contact | {item.Name}
        label "Contact name *"
        input text "Enter Contact Name" (model: form.contactName; required)
        label "Phone"
        input text "Enter Phone" (model: form.phone)
        label "Mobile phone"
        input text "Enter Mobile Phone" (model: form.mobilePhone)
        label "Email"
        input text "Enter Email" (model: form.email)
      component <uib-tab> [index=1, heading=Address]
        label "Address"
        input select "Select Address" (model: form.addressID) options: Select address | {item.Line1} {item.Line2} {item.City} {i
        label "Address line 1"
        input text "Enter Address Line 1" (model: form.addressLine1)
        label "Address line 2"
        input text "Enter Address Line 2" (model: form.addressLine2)
        label "City / suburb"
        input text "Enter City / Suburb" (model: form.city)
        label "State / province"
        input text "Enter State / Province" (model: form.state)
        label "Country"
        input text "Enter Country" (model: form.country)
... (27 more lines of the same kinds of fields omitted)
```

API calls: none directly (shared/local data only)

### Dialog: Email Report Dialog

included by `reportCloseRegistryDetailsPartial`, `reportGiftCardPartial`, `reportInTransitPartial`, `reportInventoryPartial`. Template: `PosViews/emailReportDialogPartial.html`.

```text
dialog #emailReportDialogPartial:
  form (name: emailReportForm):
    heading "Email report"
    tap area "x" <span> → helperService.closeDialog('#emailReportDialogPartial')
    if allowEmailSubject()===true:
      label "Email subject *"
      input text "Enter email subject" (model: reportSubject; required)
    label "Email *"
    input email "Enter email" (model: reportEmail; required)
    button "Email report" → emailReport(emailReportForm.reportEmail, emailReportForm.reportSubject) [disabled when emailReportForm.reportEmail.$inv...
    button "Cancel" → helperService.closeDialog('#emailReportDialogPartial')
dialog #reportSentEmailStatus:
  heading "Email report"
  tap area "x" <span> → helperService.closeDialog('#reportSentEmailStatus')
  if reportEmailSentStatus===true:
    heading "Email receipt"
    dialog:
      text "This report has been successfully sent"
      text "to"
      text "{reportEmail}"
  if not reportEmailSentStatus===true:
    dialog:
      text "The receipt cannot be sent. Please check your email address."
```

API calls: none directly (shared/local data only)

### Panel: Gift Card Pay

included by `sellPartial`. Template: `PosViews/giftCardPayPartial.html`.

```text
dialog #giftCardPayDlg:
  form (name: giftCardPayForm):
    heading "Pay with a gift card"
    tap area "x" <span> → helperService.closeDialog('#giftCardPayDlg');giftCardPayDialogCallback('cancel')
    label "Gift card code"
    input text (model: currentGiftCardPay.giftCardCode; required)
    label "Amount"
    tap area "{currentGiftCardPay.amount|currency}" <div> → showGiftCardPayAmountDlg()
    button "Save" → helperService.closeDialog('#giftCardPayDlg');giftCardPayDialogCallback('save') [disabled when giftCardPayForm.payGiftCardCode.$...
    button "Cancel" → helperService.closeDialog('#giftCardPayDlg');giftCardPayDialogCallback('cancel')
component <ngm-keyboard>
button "Apply" → callback(true);
```

API calls: none directly (shared/local data only)

### Panel: Gift Card Sale

included by `sellPartial`. Template: `PosViews/giftCardSalePartial.html`.

```text
dialog #giftCardSaleDlg:
  heading "Sale gift card"
  if helperService.canShowCameraScanIcon():
    tap area <span> → helperService.cameraScan(false,true)
  tap area "x" <span> → helperService.closeDialog('#giftCardSaleDlg');giftCardSaleDialogCallback('cancel')
  label "Gift card code"
  input text (model: currentGiftCardProduct.giftCardCode; required)
  if currentGiftCardProduct.isExpirationDateEnabled:
    label "Expiration date"
    input text (model: currentGiftCardProduct.expirationDate)
  tap area "Gift card price {currentGiftCardProduct.amount|currency}" <div> → showGiftCardAmountDlg()
  button "Save" → onGiftCardDialogSave() [disabled when giftCardSaleForm.newSaleGiftCardCode.$invalid || Number(currentGiftCar]
component <ngm-keyboard>
button "Apply" → callback(true);
```

API calls: none directly (shared/local data only)

### Panel: Header

Template: `PosViews/headerPartial.html`.

```text
if showHeader:
  if showHeader:
    if enableMenu:
      tap area <div> → toggleMenu($event)
    if enableMenu:
      button "[menu-hamburger_2020]" → toggleMenu($event)
    heading "{currentOutlet}"
    text "Hello"
    text "{currentUser}"
    if isOnline === true:
      link "Set PIN code" → #pinCodeSetup
    if isSite === false || isOnline === true:
      link "Change outlet|register" → changeOutlet()
    link "Logout ( {configService.userName} )" → logoff()
  include: changeLanguagePartial
  dialog #pageRefreshPartial:
    heading "Refresh page"
    tap area "x" <span> → closePageRefreshDialog();
    dialog:
      text "Your current sale will be lost. You will need to log in again. Would you like to continue?"
    button "Refresh" → closePageRefreshDialog();refreshPage();
    button "Cancel" → closePageRefreshDialog();
  dialog #cancelDialogConfirmPartial:
    heading "Confirm cancellation of editing"
    tap area "x" <span> → closeCancelDialogModalDialog();
    dialog:
      text "Are you sure?"
      text "All changes will be lost. Would you like to continue?"
    button "Continue" → cancelDialogModal();closeCancelDialogModalDialog();
    button "Cancel" → closeCancelDialogModalDialog();
```

API calls: none directly (shared/local data only)

### Panel: Login

Template: `PosViews/loginPartial.html`.

```text
dialog #enterModal:
  if isDBEngineSupported() && !showWaitPopup:
    if !pinMode || isDeviceRooted:
      form (name: loginForm) (submit → login()):
        heading "Sign in to POS"
        if dearPosModeShow === true:
          input checkbox "Old Sale Mode (QA debug)" (model: dearPosMode)
          label "Old Sale Mode"
        input text "Cin7 Core POS Name" (model: dearPosName; required)
        tap area <span> → showDEARPOSWarning()
        if getPosNameRequiredError(loginForm) && warningVisibility.DEARPOSName == true:
          text "Cin7 Core POS name is required."
        input email "Login" (model: userName; required)
        tap area <span> → showEmailWarning()
        if getEmailFormatError(loginForm) && warningVisibility.Email == true:
          text "The email is not well-formed."
        if getEmailRequiredError(loginForm) && warningVisibility.Email == true:
          text "Email is required."
        input password "Password" (model: password; required)
        if password && password.length:
          link "" → eyePasswordToggle()
        tap area <span> → showPasswordWarning()
        if getPasswordRequiredError(loginForm) && warningVisibility.Password == true:
          text "Password is required."
        button "Sign in" [disabled when isDeviceRooted]
        text "OR"
        if isOnline:
          button "Sign in with Google" → googleLogin() [disabled when isDeviceRooted]
        if isOnline:
          button "Sign in with Microsoft" → msalLogin() [disabled when isDeviceRooted]
        if isBioAuthEnabled:
          button "Sign in with biometrics" → biometricLogin() [disabled when isDeviceRooted]
... (64 more lines of the same kinds of fields omitted)
```

API calls: none directly (shared/local data only)

### Dialog: Number Keyboard

Template: `PosViews/numberKeyboardPartial.html`.

```text
if signIsPositive!=true:
  text "-"
text "{formattedModel}"
button "1" → clickFun('1')
button "2" → clickFun('2')
button "3" → clickFun('3')
button "4" → clickFun('4')
button "5" → clickFun('5')
button "6" → clickFun('6')
button "7" → clickFun('7')
button "8" → clickFun('8')
button "9" → clickFun('9')
if type==='floatCalculator' || type=='integer':
  button "00" → clickFun('00')
  button "0" → clickFun('0')
  button "" → clickFun('backspace')
if not type==='floatCalculator' || type=='integer':
  button "." → clickFun('.')
  button "0" → clickFun('0')
  button "[arrowLeft_2020]" → clickFun('backspace')
```

API calls: none directly (shared/local data only)

### Dialog: Payment Modal Setup

included by `setupPartial`. Template: `PosViews/paymentModalSetupPartial.html`.

```text
dialog #paymentSetupModal:
  form (name: cardPaySetup) (submit → savePaymentSystem()):
    heading "Payment system setup"
    tap area "x" <span> → closePaymentSetup();
    if paymentModalMode=='connect':
      label "Card payment system"
      input select (model: selectedPaymentSystem.key) options: Select payment system | {item.name}
      if selectedPaymentSystem.key=='tyroReaderProvider':
        label "Print EFTPOS receipts on the Tyro terminal"
        input checkbox (model: paymentSettings.printTyroReceiptOnTerminal)
        button "Pair with terminal" → pairTyro()
      if selectedPaymentSystem.key=='triPOSReaderProvider':
        text "Terminal Lane ID: {paymentSettings.triPOSLaneID}"
        label "Print merchant receipt copy"
        input checkbox (model: paymentSettings.printTriPOSMerchantReceipt)
        label "Terminal ID"
        input text "Terminal ID" (model: paymentSettings.triTerminalID)
        label "Activation code"
        input text "Activation Code" (model: paymentSettings.triActivationCode)
        button "Remove pairing" → removePairTriPOS()
        button "Pair with terminal" → pairTriPOS()
      if selectedPaymentSystem.key=='paymentSenseReaderProvider':
        input text
        label "Available Paymentsense terminals:"
        input select (model: paymentSettings.PaymentSenseTerminalID) options: Select terminal to pair | {item.tpi} ({item.currency})
        button "Pair with terminal" → showPaymentSenseTerminals()
      if selectedPaymentSystem.key=='linklyPaymentReaderProvider':
        label "Print receipts on Linkly PIN pad"
        input checkbox "When disabled, main receipts as well as terminal receipts are printed on a POS printer. When enabled, main receipt is print...
        label "Cut receipts"
        input checkbox "Please choose whether receipts should be cut after each printout." (model: paymentSettings.receiptsLinklyPaymentReceiptOnTe...
        label "Pair code"
... (21 more lines of the same kinds of fields omitted)
```

API calls: none directly (shared/local data only)

### Panel: Pin Code

included by `loginPartial`, `pinCodeSetupPartial`. Template: `PosViews/pinCodePartial.html`.

```text
if pinMode && !isDeviceRooted:
  form (name: pinForm):
    heading "{pinFormCaption}"
    button "1" → clickFun('1') [disabled when finished]
    button "2" → clickFun('2') [disabled when finished]
    button "3" → clickFun('3') [disabled when finished]
    button "4" → clickFun('4') [disabled when finished]
    button "5" → clickFun('5') [disabled when finished]
    button "6" → clickFun('6') [disabled when finished]
    button "7" → clickFun('7') [disabled when finished]
    button "8" → clickFun('8') [disabled when finished]
    button "9" → clickFun('9') [disabled when finished]
    if not hideGoToLogin===true:
      button "" → setLoginMode()
    button "0" → clickFun('0') [disabled when finished]
    button "[arrow-left-clear_2020]" → clickFun('backspace')
```

API calls: none directly (shared/local data only)

### Panel: Prepare Any Day Closure

included by `reportCloseRegistryPartial`. Template: `PosViews/prepareAnyDayClosurePartial.html`.

```text
dialog #prepareAnyDayClosureModal:
  form (name: prepareAnyDayClosureForm) (submit → redirectToClosureDay()):
    heading "Close register day"
    tap area "x" <span> → closePrepareAnyDayClosure()
    if prepareAnyDayClosureData.mode === 'warning':
      text "If you really want to close this day, please, press 'Continue'"
    if prepareAnyDayClosureData.mode === 'date':
      text "Please, select the day closure date and press 'Continue'."
    if prepareAnyDayClosureData.mode === 'date':
      label "Day closure date *"
      input text (model: prepareAnyDayClosureData.closureDate; required; readonly)
    if prepareAnyDayClosureData.mode === 'warning':
      button "Continue" → prepareAnyDayClosureData.mode = 'date'
    if prepareAnyDayClosureData.mode === 'date':
      button "Continue" [disabled when prepareAnyDayClosureForm.$invalid]
```

API calls: none directly (shared/local data only)

### Dialog: Printer Modal Setup

included by `setupPartial`. Template: `PosViews/printerModalSetupPartial.html`.

```text
dialog #printerSetupModal:
  form (name: printerSetup) (submit → save()):
    heading "Printer setup"
    tap area "x" <span> → closePrinterSetup();
    if isSite:
      heading "In the web version, the standard browser printing form is used."
    if !isSite:
      if printerModalMode === 'connect':
        label "Printer manufacturer"
        input select (model: selected.selectedSystem) options: Select printer manufacturer | {item.name}
        if !isSite && selected.selectedSystem!='embedded':
          label "Printer name/ IP address Model name"
          if selected.selectedSystem=='star' || selected.selectedSystem=='epson':
            input text "Printer Name" (model: settings.printerName)
          if not selected.selectedSystem=='star' || selected.selectedSystem=='epson':
            text "{settings.printerName}"
          if (selected.selectedSystem=='star' || selected.selectedSystem=='epson') && settings.modelName && settings.modelName !== settings.printer...
            text "{settings.modelName}"
          if selected.selectedSystem=='epson':
            text "Connect using IP or MAC address: TCP:192.168.0.100"
            text "Connect using Bluetooth: BT:00:11:22:33:FF:EE"
        if selected.selectedSystem=='star' || selected.selectedSystem=='epson':
          button "Auto-discover printer" → discoverPrinter()
          button "Reset" → resetPrinter()
        if !isSite && (selected.selectedSystem == 'star' || selected.selectedSystem=='epson'):
          label "Printer model"
          input select (model: selected.selectedModel) options: Select printer model | {item.display} {item.modelNames && item.
        if !isSite && selected.selectedSystem!='embedded':
          label "Paper width"
          input select (model: selectedArea.text) options: Select paper width | {item.text}
        label "Simulator mode"
        input checkbox (model: settings.simulatorMode)
... (14 more lines of the same kinds of fields omitted)
```

API calls: none directly (shared/local data only)

### Panel: Product Label Print

included by `productManagementPartial`. Template: `PosViews/productLabelPrintPartial.html`.

```text
if mode == 'labels':
  heading "Inventory"
  text "Total Products"
  heading "{dataCount}"
  button "Back to product list" → goBack()
  form (name: receiptHolder.receiptForm):
    heading "Print"
    if printComplete === 'true':
      text "Print complete!"
    label "Copies"
    tap area "{printParams.copies}" <div> → showKeyboardTemplateDlg()
    if isSite:
      label "Paper width"
      input select (model: printParams.labelSelectedArea; change: nextStepPrintModal()) options: Select paper type | {item.text}
    button "Print labels" → printLabels()
    text "To select a product to print a label, you can click on product image in the product list on the previous screen."
    if labelsPRow < 2:
      text "Set the margins value to 'none' in the next print dialogue for correct printing."
component <ngm-keyboard> [float-precision=floatPrecision]
button "Apply" → callback(true, $event)
```

API calls: none directly (shared/local data only)

### Dialog: Quote Email Dialog

included by `sellPartial`. Template: `PosViews/quoteEmailDialogPartial.html`.

```text
dialog #quoteEmailDialogPartial:
  form (name: quoteTemplateHolder.quoteForm):
    heading "Sale quote"
    tap area "x" <span> → closeQuoteEmailDialog()
    input email "Email" (model: quoteTemplateHolder.QuoteEmail; required)
    button "Email quote" → sendEmailQuote() [disabled when quoteTemplateHolder.quoteForm.receiptEmail.$invalid || quoteTemplateHo]
    button "Close" → closeQuoteEmailDialog()
dialog #quoteEmailCompletion:
  heading "Email quote"
  tap area "x" <span> → closeQuoteEmailCompleteDialog()
  dialog:
    text "Sale quote sent successfully."
    text "to"
    text "{quoteTemplateHolder.QuoteEmail}"
dialog #quoteEmailCompletionError:
  heading "Email quote"
  tap area "x" <span> → closeQuoteEmailCompleteDialog()
  dialog:
    text "The quote cannot be sent. Please check your email address."
```

API calls: none directly (shared/local data only)

### Dialog: Receipt Dialog

included by `salesHistoryPartial`. Template: `PosViews/receiptDialogPartial.html`.

```text
dialog #receiptDialogPartial:
  form (name: receiptHolder.receiptForm):
    heading "Receipt"
    tap area "x" <span> → closeReceiptDialog()
    if hasTerminalReceipts():
      label "Print all receipts"
      input checkbox (model: printAllReceipts)
    input email "Email" (model: email.receiptEmail; required)
    heading "Sale summary"
    button "Print receipt" → printReceipt(); closeReceiptDialog()
    button "Email receipt" → sendEmailReceipt() [disabled when receiptHolder.receiptForm.receiptEmail.$invalid || receiptHolder.recei]
    button "Cancel" → closeReceiptDialog()
```

API calls: none directly (shared/local data only)

### Dialog: Receipt Email Dialog

included by `salesHistoryPartial`, `sellPartial`. Template: `PosViews/receiptEmailDialogPartial.html`.

```text
dialog #receiptSentToEmail:
  tap area "x" <span> → closeReceiptEmailDialog()
  dialog:
    heading "Email receipt"
    text "Receipt sent successfully."
    text "to"
    text "{sentToEmail}"
dialog #receiptSentToEmailError:
  heading "Email receipt"
  tap area "Close" <span> → closeReceiptEmailDialog()
  dialog:
    text "The receipt cannot be sent. Please check your email address."
```

API calls: none directly (shared/local data only)

### Panel: Report Close Registry Details

included by `reportCloseRegistryPartial`. Template: `PosViews/reportCloseRegistryDetailsPartial.html`.

```text
dialog #reportCloseRegistryDetailsDialogPartial:
  heading "Close Registry Details"
  tap area "x" <span> → closeReportCloseRegistryDetailsDialog()
  text "Opened"
  text "{currentReport.OpeningTime}"
  if currentReport.ID != null:
    text "Closed"
    text "{currentReport.ClosingTime}"
  text "Register"
  text "{currentReport.OutletName} / {currentReport.RegistryName}"
  text "Sales"
  text "Type"
  text "Value"
  text "New sales"
  text "{currentReport.saleTotalCount | number:2}"
  text "{currency_symbol}"
  if !!currentReport.saleCount && currentReport.saleCount!=0:
    text "New"
    text "{currentReport.saleCount | number:2}"
    text "{currency_symbol}"
  if !!currentReport.onAccountCount && currentReport.onAccountCount!=0:
    text "On account"
    text "{currentReport.onAccountCount | number:2}"
    text "{currency_symbol}"
  if !!currentReport.layByCount && currentReport.layByCount!=0:
    text "Layby"
    text "{currentReport.layByCount | number:2}"
    text "{currency_symbol}"
  text "Tax"
  text "{(!!currentReport.taxCount ? currentReport.taxCount : 0) | number:2}"
  text "{currency_symbol}"
  text "Discounts"
... (187 more lines of the same kinds of fields omitted)
```

API calls: none directly (shared/local data only)

### Panel: Report In Transit Column Selector

included by `reportInTransitPartial`; referenced from `reportInTransitController`. Template: `PosViews/reportInTransitColumnSelectorPartial.html`.

```text
dialog #reportInTransitGridCustomiser:
  heading "Customise columns"
  tap area "x" <span> → closeCustomiser()
  component <uib-tabset>
    component <uib-tab> [index=0, heading=Options]
      for each item in listOfColumns:
        link "{item.name}" → selectColumn(selectedColumns,item);
      label "Group variants"
      input checkbox (model: currentFilter.groupFamilies)
      if additionalHeaders && additionalHeaders.length > 0:
        for each item in additionalHeaders:
          link "{item.name}" → selectColumn(selectedAdditionalColumns,item);
```

API calls: none directly (shared/local data only)

### Panel: Report Inventory Column Selector

included by `reportInventoryPartial`; referenced from `reportInventoryController`. Template: `PosViews/reportInventoryColumnSelectorPartial.html`.

```text
dialog #reportInventoryGridCustomiser:
  heading "Customise columns"
  tap area "x" <span> → closeCustomiser()
  component <uib-tabset>
    component <uib-tab> [index=0, heading=Data columns]
      for each item in listOfColumns:
        link "{item.name}" → selectColumn(selectedColumns,item);
      if additionalHeaders && additionalHeaders.length > 0:
        for each item in additionalHeaders:
          link "{item.name}" → selectColumn(selectedAdditionalColumns,item);
      if getCurrentReportType().variantsGroupEnabled:
        label "Group variants"
        input checkbox (model: currentFilter.groupFamilies)
```

API calls: none directly (shared/local data only)

### Panel: Report Product Performance Column Selector

included by `reportProductPerformancePartial`; referenced from `reportProductPerformanceController`. Template: `PosViews/reportProductPerformanceColumnSelectorPartial.html`.

```text
dialog #reportProdPerfGridCustomiser:
  heading "Customise columns"
  tap area "x" <span> → closeCustomiser()
  component <uib-tabset>
    component <uib-tab> [index=0, heading=Data columns]
      for each rows in chunkedColumnsData:
        for each item in rows:
          link "{item.name}" → selectColumn(selectedColumns,item);
    component <uib-tab> [index=1, heading=Additional Options]
      if additionalHeaders && additionalHeaders.length > 0:
        for each item in additionalHeaders:
          link "{item.name}" → selectColumn(selectedAdditionalColumns,item);
      input checkbox (model: currentFilter.groupFamilies)
      label "Group variants"
```

API calls: none directly (shared/local data only)

### Panel: Report Sales Summary Column Selector

included by `reportSalesSummaryPartial`; referenced from `reportSalesSummaryController`. Template: `PosViews/reportSalesSummaryColumnSelectorPartial.html`.

```text
dialog #reportSalesSummaryGridCustomiser:
  heading "Customise columns"
  tap area "x" <span> → closeCustomiser()
  component <uib-tabset>
    component <uib-tab> [index=0, heading=Data columns]
      for each rows in chunkedColumnsData:
        for each item in rows:
          link "{item.name}" → selectColumn(selectedColumns,item);
    if getCurrentReportType().showProductEnabled || getCurrentReportType().variantsGroupEnabled || (additionalHeaders && additionalHeaders.lengt:
      component <uib-tab> [index=1, heading=Additional Options]
        if getCurrentReportType().showProductEnabled || getCurrentReportType().variantsGroupEnabled:
          if getCurrentReportType().showProductEnabled:
            input checkbox (model: currentFilter.showProducts)
            label "Show products"
          if additionalHeaders && additionalHeaders.length > 0:
            for each item in additionalHeaders:
              link "{item.name}" → selectColumn(selectedAdditionalColumns,item);
          if getCurrentReportType().variantsGroupEnabled:
            input checkbox (model: currentFilter.groupFamilies)
            label "Group variants"
```

API calls: none directly (shared/local data only)

### Dialog: Return Complite Dialog

included by `salesHistoryPartial`. Template: `PosViews/returnCompliteDialogPartial.html`.

```text
dialog #returnCompliteDialogPartial:
  heading "{selectedItem.OrderNumber}"
  heading "Refund successful"
  if returnedLoaylty.value>0:
    heading "{returnedLoaylty.value} loyalty points deducted"
  button "Start a new sale" → openRegister()
  button "Print receipt" → showReceiptDialog(true)
  button "Close" → closeReturnCompliteDialog()
```

API calls: none directly (shared/local data only)

### Dialog: Return Payments Dialog

included by `salesHistoryPartial`, `sellPartial`. Template: `PosViews/returnPaymentsDialogPartial.html`.

```text
dialog #returnPaymentsDialogPartial:
  form (name: selectRetrunAmountForm) (submit → submitSelectReturnPayments()):
    heading "Refund"
    tap area "x" <span> → closeReturnPaymentsDialog()
    if showRefundPaymentsAmountError === true:
      text "Remaining to refund amount must be equal to zero."
    if showRefundExactPaymentsAmountError === true:
      for each error in refundPaymentsError:
        text "{error}"
    if paymentValidation.cashAmount>0:
      label "To cash ({currency_symbol} {paymentValidation.cashAmount | number:2} max)"
      input text → mobile-click: showRefundPaymentAmountDlg('cash','#refundCashPaymentAmount'
      if paymentValidation.cashSurchargeAmount > 0 || paymentValidation.hasSurchargeRest === true:
        label "Cash surcharge ({currency_symbol} {paymentValidation.cashSurchargeAmount | number:2} max)"
        input text → mobile-click: showRefundPaymentAmountDlg('cashSurcharge','#refundCashPayme
      if abs(payments.cashRounded - payments.cash - payments.cashSurcharge) > 0:
        if not payments.cashRounded != (payments.cash + payments.cashSurcharge):
          label "Cash to refund"
        if not payments.cashRounded != (payments.cash + payments.cashSurcharge):
          label "Rounded cash to refund"
        input text
    if paymentValidation.creditCardAmount>0 and for each obj in paymentValidation.cardPayments:
      label "To credit card #{$index+1} ({currency_symbol} {obj.validationAmount | number:2} max)"
      input text → mobile-click: showRefundPaymentAmountDlg('creditCard','#'+obj.id, obj.vali
      tap area "Processed" <div> → handleRemotedlyProcessed(obj)
      if !!obj.cardPAN:
        label "{obj.cardPAN}"
      if !!obj.Surcharge:
        label "Credit card surcharge: {obj.Surcharge.Name} ({currency_symbol} {obj.Surcharge.CalculatedValueWithTax | number:2} max)"
        input text (readonly)
    if paymentValidation.customPayments.length>0 and for each obj in paymentValidation.customPayments:
      if obj.ShortName !== 'loyaltylion':
... (29 more lines of the same kinds of fields omitted)
```

API calls: none directly (shared/local data only)

### Dialog: Sale History Details Dialog

included by `salesHistoryPartial`. Template: `PosViews/saleHistoryDetailsDialogPartial.html`.

```text
dialog #saleHistoryDetailsDialogPartial:
  if not hideDetails === true:
    heading "Sale details"
    tap area "x" <span> → closeSalesHistoryDetailsDialog()
    text "Order Number:"
    text "#{selectedItem.OrderNumber}"
    if selectedItem.Data.StandaloneRefund !== true:
      text "Sold by:"
      if selectedItem.Data.SalesRepresentative:
        text "{selectedItem.Data.SalesRepresentative}"
      if not selectedItem.Data.SalesRepresentative:
        text "{selectedItem.UserName}"
    if selectedItem.Data.CustomerName && selectedItem.CustomerID:
      text "Customer Name:"
      text "{selectedItem.Data.CustomerName}"
    if selectedItem.Data.CustomerEmail && selectedItem.CustomerID:
      text "Customer Email:"
      text "{selectedItem.Data.CustomerEmail}"
    if selectedItem.Data.CustomerMobilePhone && selectedItem.CustomerID:
      text "Customer Phone:"
      text "{selectedItem.Data.CustomerMobilePhone}"
    if selectedItem.Data.CustomerNote:
      text "Customer note:"
      text "{selectedItem.Data.CustomerNote}"
    if selectedItem.Data.CustomerShippingAddressLine1:
      text "Customer shipping address:"
      text "{getSaleShippingAddress()}"
    if selectedItem.showLaybyDate:
      text "Pay by date:"
      text "{selectedItem.LaybyDate}"
    text "Status:"
    text "{financialStatusName(selectedItem.Data.FinancialStatus, selectedItem.isPartiallyPaid, selectedItem.Data, selectedItem.shouldPayExtra)}"
... (132 more lines of the same kinds of fields omitted)
```

API calls: none directly (shared/local data only)

### Dialog: Sale History Filter Dialog

included by `salesHistoryPartial`. Template: `PosViews/saleHistoryFilterDialogPartial.html`.

```text
dialog #saleHistoryFilterDialogPartial:
  form:
    heading "Filters"
    tap area "x" <span> → closeSalesHistoryFilterDialog()
    label "Date"
    component <ngm-date-range-selector> [date-from=filters.DateFrom, date-to=filters.DateTo1, allow-reset=true, date-selected-callback=dateSelected...
    label "Outlets"
    input select "All outlets" (model: filters.OutletID) options: All outlets | {item.OutletName}
    label "Statuses"
    input select "All Statuses" (model: filters.StatusID) options: All statuses | {item.StatusName}
    if isOnline && canSeeAllSales:
      input radio (model: gridType; value: pos) → change: changeGridType('pos')
      label "POS sales"
      input radio (model: gridType; value: dear) → change: changeGridType('dear')
      label "All sales"
    button "Apply filters" → closeSalesHistoryFilterDialog()
    button "Close" → closeSalesHistoryFilterDialog()
```

API calls: none directly (shared/local data only)

### Panel: Sale Summary

included by `sellPartial`. Template: `PosViews/saleSummaryPartial.html`.

```text
heading "Main register"
if not isPaymentFinished():
  heading "Sale summary"
  if currentSale.Payments.length==0 && currentSale.OrderType !== 'LAYBY' && currentSale.OrderType !== 'ONACCOUNT':
    button "Back to sale" → goBack(currentSale.Payments.length>0)
  if currentSale.Payments.length>0 && currentSale.OrderType !== 'LAYBY' && currentSale.OrderType !== 'ONACCOUNT':
    button "Done" → setPaymentFinished()
  if isPaymentStage():
    form (name: formHolder.paymentForm):
      if isValidAmount === false:
        text "{invalidPaymentAmount}"
      if paymentDisplayOrder === 2 and if not cashMode || creditCardMode:
        button "Cash" → cashPay() [disabled when cashRegistryPaymentProcessorID === null || refundNeedCustomer === true]
        button "Credit card" → creditCardPay() [disabled when creditCardPaymentProcessorID === null || refundNeedCustomer === true |]
        if isGiftCardEnabled():
          button "Gift card" → showGiftCardPayDialog() [disabled when saleType === 'return' || formHolder.sumToPayLeft < 0 || isDisableOffli]
        for each pm in customPaymentMethods:
          button "{pm.paymentMethodName}" → customPay(pm.paymentProcessorID) [disabled when refundNeedCustomer === true || formHolder.sumToPayLeft ...
      if paymentDisplayOrder !== 2:
        tap area "Payable amount {currency_symbol} {formHolder.realSum}" <div> → !cashMode && showPayDlg()
      if paymentDisplayOrder === 2:
        heading "Pay"
        tap area "{currency_symbol} {formHolder.realSum}" <div> → !cashMode && showPayDlg()
      if paymentDisplayOrder !== 2 and if not cashMode:
        button "Cash" → cashPay() [disabled when cashRegistryPaymentProcessorID === null || refundNeedCustomer === true]
        button "Credit card" → creditCardPay() [disabled when creditCardPaymentProcessorID === null || refundNeedCustomer === true |]
        if isGiftCardEnabled():
          button "Gift card" → showGiftCardPayDialog() [disabled when saleType === 'return' || formHolder.sumToPayLeft < 0 || isDisableOffli]
        for each pm in customPaymentMethods:
          button "{pm.paymentMethodName}" → customPay(pm.paymentProcessorID) [disabled when refundNeedCustomer === true || formHolder.sumToPayLeft ...
      if cashMode:
        button "Tender" → cashPay2() [disabled when paymentActionInProgress === true]
... (69 more lines of the same kinds of fields omitted)
```

API calls: none directly (shared/local data only)

### Dialog: Scan Serial Number Dialog

included by `sellPartial`. Template: `PosViews/scanSerialNumberDialogPartial.html`.

```text
dialog #scanSerialNumberDialogPartial:
  form (name: scanSerialNumberForm) (submit → submitScanSerialNumber()):
    heading "Scan serial number"
    tap area "x" <span> → closeScanSerialNumberDialog(true)
    input text "Serial Number..." (model: scanedSerialNumber.value; required; maxlength 50)
    if helperService.canShowCameraScanIcon():
      tap area <span> → helperService.cameraScan(false,true)
    button "Confirm"
dialog #notFoundSerialNumberDialogPartial:
  heading "Scan serial number"
  tap area "x" <span> → closeNotFoundSerialNumberDialog();
  dialog #customModalDlgText:
    text "Serial number is not found."
    text "Do you want to add item to checkout?"
  button "Add" → notNoundSerialNumberAddToCheckOut();
  button "Cancel" → closeNotFoundSerialNumberDialog();
```

API calls: none directly (shared/local data only)

### Dialog: Scanner Modal Setup

included by `setupPartial`. Template: `PosViews/scannerModalSetupPartial.html`.

```text
dialog #scannerSetupModal:
  form (name: scanerSetup):
    heading "Scanner setup"
    tap area "x" <span> → closeScannerSetup();
    if showSoftKbdPart:
      input checkbox (model: scannerSettings.enableSoftKbd)
      label "Enable software keyboard"
    if helperService.isCameraScanAvailable():
      input checkbox (model: scannerSettings.enableCameraScan)
      label "Enable camera scanner"
    if scanModalMode === 'scan':
      heading "Please scan barcode"
      if helperService.canShowCameraScanIcon():
        tap area <span> → helperService.cameraScan(false,true)
      text "All barcodes were recognised and added to your document."
    if scanModalMode === 'succ':
      label "Barcode detected."
      text "{scanValue}"
    if scanModalMode === 'fail':
      heading "Oops!"
      text "The barcode could not be detected. Make sure your scanner is connected correctly and then try scanning again."
      if not true:
        text "The printer is not responding. Make sure your printer is connected correctly and then try again."
    button "Scan again" → scanAgain() [disabled when isScanAgainReady()]
    button "Close" → closeScannerSetup();
```

API calls: none directly (shared/local data only)

### Panel: Select Outlet Registry

Template: `PosViews/selectOutletRegistryPartial.html`.

```text
dialog #selectOutletRegistryModal:
  heading "Select outlet Select register"
  if activeMode==0:
    input select (model: selectedOutlet; options: item as item.OutletName for item in outlets) options: Select outlet
  if activeMode==1:
    input select (model: selectedRegister; options: item as item.Code for item in selectedOutletItem.Registries) options: Select register
  if activeMode==0:
    button "Next" → setOutlet() [disabled when selectedOutlet === null]
  if activeMode==1:
    button "Next" → setRegister() [disabled when selectedRegister === null]
  if activeMode==0:
    button "Back" → backToLogin()
  if activeMode==1:
    button "Back" → activeMode=0;forceScroller();
```

API calls: none directly (shared/local data only)

### Dialog: Select Tax Dialog

included by `sellPartial`. Template: `PosViews/selectTaxDialogPartial.html`.

```text
dialog #taxModelDlg:
  form (name: selectTaxForm) (submit → applyChanges()):
    heading "Edit taxes"
    tap area "x" <span> → helperService.closeDialog('#taxModelDlg')
    component <uib-tabset> [active=currentTab]
      tap area "Edit or delete assigned taxes for individual products {item." <uib-tab> → synchronizeGroupToProducts();
      tap area "Edit or delete assigned taxes for multiple products grouped " <uib-tab> → synchronizeProductsToGroup();
    button "Save"
```

API calls: none directly (shared/local data only)

### Panel: Sell To Pay New

included by `sellTotalSectionNewPartial`. Template: `PosViews/sellToPayNewPartial.html`.

```text
tap area "Total" <div> → togglePaymentDetails()
text "+"
link "Customer" → addCustomer()
if currentSale.customer && currentSale.customer.ID:
  link "Shipping address" → addShippingAddress()
link "Sale rep" → addSalesRepresentative()
link "Quick sale" → showCustomSaleDialog()
if not !currentSale.CheckoutItems || currentSale.CheckoutItems.length==0:
  link "Note" → showAddSaleNoteDialog();hideOptions('#saleOptionsMenuButton')
text "{currency_symbol} {(subType!==true ? currentSale.Total : formHolder.realSum) | number:2}"
button "{operationName}" → goPayment(true) [disabled when currentSale.CheckoutItems.length==0 || refundNeedCustomer === true || ]
```

API calls: none directly (shared/local data only)

### Panel: Sell Top Info New

included by `sellPartial`. Template: `PosViews/sellTopInfoNewPartial.html`.

```text
if currentSale.SalesRepresentative.ID!=null:
  tap area "{currentSale.SalesRepresentative.Name}" <div> → addSalesRepresentative()
  if canChangeSalesRepresentative === true:
    tap area <div> → unsetSalesRepresentative()
if currentSale.Customer.ID!=null:
  tap area "{currentSale.Customer.Name} {currentSale.SelectedContact.Ema" <div> → itemCustomerToggle()
if !!currentSale.Comment && currentSale.Comment.length > 0:
  text "{currentSale.Comment | limitTo : 90 : 0}"
  if currentSale.Comment.length > 90:
    text "{currentSale.Comment | limitTo : (-currentSale.Comment.length + 90) : 0}"
  if currentSale.Comment.length > 90:
    tap area "... more" <div> → saleNotesShowMoreClick()
  tap area <div> → currentSale.Comment=''
```

API calls: none directly (shared/local data only)

### Panel: Sell Total Section New

included by `sellPartial`. Template: `PosViews/sellTotalSectionNewPartial.html`.

```text
if currentSale.TotalItemDiscount>0:
  heading "Total before discount"
  text "{currency_symbol} {currentSale.TotalBasePrice | number:2}"
if currentSale.TotalItemDiscount>0:
  heading "Total discount"
  text "- {currency_symbol} {currentSale.TotalItemDiscount | number:2}"
heading "Subtotal"
text "{currency_symbol} {currentSale.SubTotal | number:2}"
if hasAvailableCoupons():
  if !currentSale.SelectedCoupon:
    tap area "Apply coupon +" <div> → showCouponDlg()
  if !!currentSale.SelectedCoupon:
    tap area "Applied coupon {currentSale.SelectedCoupon}" <div> → showCouponDlg()
if canAddDiscount == true || currentSale.Discount > 0:
  if currentSale.Discount == 0:
    tap area "Discount +" <div> → showDiscountDlg()
  if currentSale.Discount>0:
    tap area "Discount {currency_symbol} {currentSale.Discount | number:2}" <div> → showDiscountDlg()
if not currentSale.IsTaxInclusive:
  tap area "Tax" <div> → isTaxPopupAvailable() && showSelectTaxDialog()
  text "{currency_symbol} {currentSale.Tax | number:2}"
if currentSale.IsTaxInclusive:
  tap area "Including tax" <div> → isTaxPopupAvailable() && showSelectTaxDialog()
  text "{currency_symbol} {currentSale.Tax | number:2}"
tap area "Discard" <div> → discardSale()
tap area "Park" <div> → showAddSaleNoteDialog('park');hideOptions('#saleOptionsMenuButton')
if canEmailQuote():
  tap area "Email" <div> → showQuoteEmailDialog()
if canPrintQuote():
  tap area "Print" <div> → printQuote()
if helperService.showNewCheckoutUI(currentSale) === true:
  include: sellToPayNewPartial
```

API calls: none directly (shared/local data only)

### Dialog: Set Password

Template: `PosViews/setPassword.html`.

```text
dialog:
  form (name: confirmPasswordForm) (submit → confirm()):
    heading "Change password"
    input password "Password" (model: password1; required)
    input password "Confirm Password" (model: password2; required)
    if !confirmPasswordForm.password2.$error.required && confirmPasswordForm.password2.$error.equalToValidator && canShowErrors:
      text "Confirm password doesn't match"
    button "Confirm"
```

API calls: none directly (shared/local data only)

### Panel: Side Bar

Template: `PosViews/sideBarPartial.html`.

```text
tap area "{currentPosName} {currentOutlet} / {currentRegister} Dashboa" <div> → clickOutside($event)
dialog #pageNotAvailablePartial:
  heading "Page Is Not Available Offline"
  dialog:
    text "Your computer is not connected to the internet. Please check the status of your connection. You can make sales in register while you're o...
  button "Sell offline" → closePageNotAvailableDialog();sellOffline();
dialog #wmsApplicationNotAvailablePartial:
  heading "Warehouse Management System application is not available"
  tap area "x" <span> → closeWMSApplicationNotAvailableDialog()
  if isQA():
    dialog:
      text "Please install our Warehouse Management System QA application to process shipment from the store."
  if not isQA():
    dialog:
      text "Please install our Warehouse Management System application to process shipment from the store."
  button "Download" → closeWMSApplicationNotAvailableDialog();getWMS();
```

API calls: none directly (shared/local data only)

### Dialog: Standalone Exchange Dialog

included by `salesHistoryPartial`. Template: `PosViews/standaloneExchangeDialogPartial.html`.

```text
dialog #standaloneExchangeDialogPartial:
  form (name: selectStandaloneExchangeParamsForm) (submit → submitStandaloneExchange()):
    heading "Create exchange without sale"
    tap area "x" <span> → closeStandaloneExchangeDialog()
    label "Receipt number *"
    input text "Receipt Number" (model: standaloneSettings.receiptNumber; required)
    button "Continue" [disabled when selectStandaloneExchangeParamsForm.$invalid]
    button "Cancel" → closeStandaloneExchangeDialog()
```

API calls: none directly (shared/local data only)

### Dialog: Standalone Refund Dialog

included by `salesHistoryPartial`. Template: `PosViews/standaloneRefundDialogPartial.html`.

```text
dialog #standaloneRefundDialogPartial:
  form (name: selectStandaloneRefundParamsForm) (submit → submitStandaloneRefund()):
    heading "Create refund without sale"
    tap area "x" <span> → closeStandaloneRefundDialog()
    label "Receipt number *"
    input text "Receipt Number" (model: standaloneSettings.receiptNumber; required)
    label "Allow stock adjustment"
    input checkbox (model: standaloneSettings.allowStockAdjustment)
    button "Continue" [disabled when selectStandaloneRefundParamsForm.$invalid]
    button "Cancel" → closeStandaloneRefundDialog()
```

API calls: none directly (shared/local data only)

### Panel: Stock Family Product Matrix

included by `stockOrderingPartial`. Template: `PosViews/stockFamilyProductMatrixPartial.html`.

```text
dialog #stockMatrixDlg:
  heading "Ordering for product family {familyName}"
  tap area "x" <span> → hide()
  if hideBaseGridLine==false:
    input select (model: baseOption; change: baseOptionChange(baseOption)) options: {productFamily.Options.Option1} | {productFamily.Options.Option...
  if hideBaseGridLine==false:
    input select (model: baseOptionValue; change: baseOptionValueChange(baseOptionValue)) options: {opt}
  if isEditable:
    button "SET TO ALL" → setAllQty()
  if col.Empty===true:
    text "N/A"
  if col.IsHeader===true:
    text "{col.Header}"
  if col.IsHeader!==true && col.Empty!==true && isEditable && !isMobile:
    input number (model: productFamily.Available[col.Index][QuantityPropName]; min/max: 0/)
  if col.IsHeader!==true && col.Empty!==true && (isMobile || !isEditable):
    button "{productFamily.Available[col.Index][QuantityPropName]}" → showSetQty(col)
  if isEditable:
    input textarea "Enter comments to order..." (model: qty.comments)
  if not isEditable:
    text "Comments:"
    text "{qty.comments}"
  if isEditable === true:
    button "Apply" → save()
  text "{info1}"
  component <ngm-keyboard> [float-precision=floatPrecision]
  button "Apply" → callback(true, $event)
```

API calls: none directly (shared/local data only)

### Dialog: Stock Ordering Comments Dialog

included by `stockTransferOrderDetailsPartial`. Template: `PosViews/stockOrderingCommentsDialogPartial.html`.

```text
dialog #addCommentsDialogModal:
  heading "Comment for product "{currentLineCommentRow.Name}""
  tap area "X" <span> → closeAddLineCommentsDialog(true)
  if currentOrder.dataStatus === 'DRAFT':
    input textarea (model: currentLineComment.value)
  if not currentOrder.dataStatus === 'DRAFT':
    if not currentLineComment.value && currentLineComment.value.length > 0:
      text "There are no comments."
    if currentLineComment.value && currentLineComment.value.length > 0:
      text "{currentLineComment.value}"
  if currentOrder.dataStatus === 'DRAFT':
    button "Save" → closeAddLineCommentsDialog(false)
  button "Close" → closeAddLineCommentsDialog(true)
```

API calls: none directly (shared/local data only)

### Panel: Stock Purchase Order Details

included by `stockOrderingPartial`. Template: `PosViews/stockPurchaseOrderDetailsPartial.html`.

```text
dialog #stockPurchaseOrderDetailPartial:
  form (name: purchaseProcessForm) (submit → modifyOrder()):
    if mode=='new' && currentOrder.dataStatus=='DRAFT':
      heading "New purchase order"
    if mode=='edit' && currentOrder.dataStatus=='DRAFT':
      heading "Edit purchase order {currentOrder.number}"
    if mode=='edit' && currentOrder.dataStatus!='DRAFT':
      heading "Purchase order {currentOrder.number}"
    tap area "x" <span> → goBack()
    if !isSite:
      input text
    if not currentOrder.dataStatus!='DRAFT':
      input select "Select supplier..." (model: currentOrder.supplierID) options: {item.Name}
    if currentOrder.dataStatus!='DRAFT':
      input text (model: currentOrder.supplierName)
    label "Supplier *"
    input text (model: currentOrder.location)
    label "To"
    if not currentOrder.dataStatus!='DRAFT':
      input text "Enter Required By Date" (model: currentOrder.date; required; readonly) → mobile-click: showCalendar($event)
    if currentOrder.dataStatus!='DRAFT':
      text "{currentOrder.date}"
    label "Required by *"
    input text (model: currentOrder.statusName)
    label "Status"
    if currentOrder.dataStatus=='DRAFT':
      button "Add" → showScanDlg()
    if currentOrder.dataStatus=='DRAFT':
      button "Reorder" → reorderProducts()
    if currentOrder.dataStatus!=='DRAFT':
      button "Email" → showPrintDialog('email')
    if currentOrder.dataStatus!=='DRAFT':
... (71 more lines of the same kinds of fields omitted)
```

API calls: none directly (shared/local data only)

### Panel: Stock Transfer Add Item

included by `stockTransferProcessPartial`. Template: `PosViews/stockTransferAddItemPartial.html`.

```text
dialog #stockTransferAddDlg:
  form (name: stockTransferAddForm):
    heading "New stock transfer order"
    tap area "x" <span> → hideScanDlg()
    component <uib-tabset> [active=stockTransferActiveTab, justified=true]
      component <uib-tab> [index=0, heading=Single]
        heading "Select a product to transfer and click to add"
        include: stockTransferScanGridPartial
      component <uib-tab> [index=1, heading=Automatic]
        heading "Scan your Product Barcode, SKU or Batch/Serial number"
        text "Ready to scan"
        if helperService.canShowCameraScanIcon():
          tap area <span> → helperService.cameraScan(false,true)
        if !!scanError && scanError.length>0:
          text "{scanError}"
        if !!scanSuccess && scanSuccess.length>0:
          text "{scanSuccess}"
        if !!scanGridProducts && scanGridProducts.length>1:
          include: stockTransferScanGridPartial2
      component <uib-tab> [index=2, heading=Inventory]
        heading "Scan your Barcodes saving them in scanner memory. Once you are back from your warehouse, simply dump all scanned barcode"
        if helperService.canShowCameraScanIcon():
          tap area <span> → helperService.cameraScan(true,true)
        if !!scanError && scanError.length>0:
          text "{scanError}"
        if !!scanSuccess && scanSuccess.length>0:
          text "{scanSuccess}"
        input textarea (model: fakeVar)
      component <uib-tab> [index=3, heading=Manual]
        heading "Scan your Product Barcode, SKU or Batch/Serial number"
        if helperService.canShowCameraScanIcon():
          tap area <span> → helperService.cameraScan(false,true)
... (14 more lines of the same kinds of fields omitted)
```

API calls: none directly (shared/local data only)

### Panel: Stock Transfer Order Add Item

included by `stockOrderingPartial`. Template: `PosViews/stockTransferOrderAddItemPartial.html`.

```text
dialog #stockTransferAddDlg:
  form (name: stockTransferAddForm):
    heading "Select a product to order"
    tap area "x" <span> → hideScanDlg()
    component <uib-tabset> [active=stockTransferActiveTab, justified=true]
      component <uib-tab> [index=0, heading=Single]
        heading "Select a product to order and click to add"
        include: stockTransferOrderScanGridPartial
      component <uib-tab> [index=1, heading=Automatic]
        heading "Scan your Product Barcode or SKU"
        text "Ready to scan"
        if helperService.canShowCameraScanIcon():
          tap area <span> → helperService.cameraScan(false,true)
        if !!scanError && scanError.length>0:
          text "{scanError}"
        if !!scanSuccess && scanSuccess.length>0:
          text "{scanSuccess}"
        if !!scanGridProducts && scanGridProducts.length>1:
          include: stockTransferOrderScanGridPartial2
      component <uib-tab> [index=2, heading=Inventory]
        heading "Scan your Barcodes saving them in scanner memory. Once you are back from your warehouse, simply dump all scanned barcode"
        if helperService.canShowCameraScanIcon():
          tap area <span> → helperService.cameraScan(true,true)
        if !!scanError && scanError.length>0:
          text "{scanError}"
        if !!scanSuccess && scanSuccess.length>0:
          text "{scanSuccess}"
        input textarea "Scan your Products" (model: fakeVar)
      component <uib-tab> [index=3, heading=Manual]
        heading "Scan your Product Barcode or SKU"
        if helperService.canShowCameraScanIcon():
          tap area <span> → helperService.cameraScan(false,true)
... (15 more lines of the same kinds of fields omitted)
```

API calls: none directly (shared/local data only)

### Panel: Stock Transfer Order Details

included by `stockOrderingPartial`. Template: `PosViews/stockTransferOrderDetailsPartial.html`.

```text
dialog #stockTransferOrderDetailPartial:
  form (name: stocktransferProcessForm) (submit → modifyStockTransfer()):
    if mode=='new' && currentOrder.dataStatus=='DRAFT':
      heading "New stock transfer order"
    if mode=='edit' && currentOrder.dataStatus=='DRAFT':
      heading "Edit stock transfer order {currentOrder.number}"
    if mode=='edit' && currentOrder.dataStatus!='DRAFT':
      heading "Stock transfer order {currentOrder.number}"
    tap area "x" <span> → goBack()
    if !isSite:
      input text
    if not currentOrder.dataStatus!='DRAFT':
      input select (model: currentOrder.fromLocationID) options: {item.DisplayName}
    if currentOrder.dataStatus!='DRAFT':
      input text (model: currentOrder.fromLocationName)
    label "From *"
    if currentOrder.dataStatus!='IN TRANSIT' && currentOrder.dataStatus !='COMPLETED':
      if currentOrder.dataStatus=='DRAFT':
        input text "Enter Required By Date" (model: currentOrder.stRequiredBy; readonly)
      if currentOrder.dataStatus!='DRAFT':
        input text (model: currentOrder.stRequiredBy)
      label "Required by"
    input text (model: currentOrder.toLocationName)
    label "To"
    input text (model: currentOrder.statusName)
    label "Status"
    if currentOrder.dataStatus=='IN TRANSIT' || currentOrder.dataStatus =='COMPLETED':
      if currentOrder.dataStatus==='IN TRANSIT':
        input text (model: currentOrder.date; required; readonly)
      if currentOrder.dataStatus!='IN TRANSIT':
        text "{currentOrder.date}"
      label "Effective date *"
... (53 more lines of the same kinds of fields omitted)
```

API calls: none directly (shared/local data only)

### Panel: Stock Transfer Order Quantity Absolute

included by `stockTransferOrderAddItemPartial`, `stockTransferOrderSetQuantityDialogPartial`. Template: `PosViews/stockTransferOrderQuantityAbsolutePartial.html`.

```text
text "SKU:"
text "{quantityObject.ProductCode}"
text "Name:"
text "{quantityObject.Name}"
if not quantityObject.hideBarcode===true:
  text "Barcode:"
  text "{quantityObject.Barcode}"
if !currentOrder.toLocationName:
  text "On Order:"
if currentOrder.toLocationName:
  text "On order at {currentOrder.toLocationName}:"
text "{quantityObject.OnOrder}"
if !currentOrder.fromLocationName:
  text "Available:"
if currentOrder.fromLocationName:
  text "Available at {currentOrder.fromLocationName}"
text "{quantityObject.QuantityAvailable || quantityObject.Available}"
if !!quantityObject.ID && !(isScanDlgVisible && !!stocktakeScanActiveTab && stocktakeScanActiveTab==0):
  text "{QuantityPropName === 'TransferQuantity' ? 'Transfer quantity' : 'Quantity'}"
  tap area "{quantityObject.Adjustment}" <div> → showItemQuantityDlg()
```

API calls: none directly (shared/local data only)

### Panel: Stock Transfer Order Scan Grid

included by `stockTransferOrderAddItemPartial`. Template: `PosViews/stockTransferOrderScanGridPartial.html`.

```text
input search "Search for products..." (model: scanGridSearchText)
text "{minSymbolsMessage}"
text "Product"
text "On order"
if currentOrder.toLocationName:
  text "at"
  text "{currentOrder.toLocationName}"
text "Available"
if currentOrder.fromLocationName:
  text "at"
  text "{currentOrder.fromLocationName}"
for each row in displayAvailableProducts:
  tap area "{row.ProductCode}: {row.Name} {row.OnOrder} {row.Available}" <div> → modifyTransferItem(row)
```

API calls: none directly (shared/local data only)

### Panel: Stock Transfer Process

included by `stockTransferPartial`. Template: `PosViews/stockTransferProcessPartial.html`.

```text
dialog #stockTransferProcessModal:
  form (name: stocktransferProcessForm) (submit → modifyStockTransfer()):
    if mode=='new' && currentTransfer.dataStatus=='DRAFT':
      heading "Add a stock transfer"
    if mode=='edit' && currentTransfer.dataStatus=='DRAFT':
      heading "Edit stock transfer {currentTransfer.number}"
    if mode=='edit' && currentTransfer.dataStatus!='DRAFT':
      heading "Stock transfer {currentTransfer.number}"
    tap area "x" <span> → goBack()
    if not currentTransfer.dataStatus!='DRAFT':
      input select (model: currentTransfer.fromLocationID) options: Select location | {item.OutletLocationName}
    if currentTransfer.dataStatus!='DRAFT':
      input text (model: currentTransfer.fromLocationName)
    label "From *"
    if not currentTransfer.dataStatus!='DRAFT':
      input text (model: currentTransfer.date; required; readonly)
    if currentTransfer.dataStatus!='DRAFT':
      text "{currentTransfer.date}"
    label "Effective date *"
    if not currentTransfer.dataStatus!='DRAFT':
      input select (model: currentTransfer.toLocationID) options: Select location | {item.OutletLocationName}
    if currentTransfer.dataStatus!='DRAFT':
      input text (model: currentTransfer.toLocationName)
    label "To *"
    if currentTransfer.dataStatus=='DRAFT':
      button "Add" → showScanDlg()
    if mode=='edit' && currentTransfer.dataStatus=='DRAFT':
      button "Complete" → modifyStockTransfer(true) [disabled when stocktransferProcessForm.$invalid]
    if mode=='edit' && currentTransfer.dataStatus=='COMPLETED':
      button "Undo" → undoStockTransfer(currentTransfer.taskID)
    if mode=='edit' && currentTransfer.dataStatus!='VOIDED':
      button "Void" → voidStockTransfer(currentTransfer.taskID)
... (26 more lines of the same kinds of fields omitted)
```

API calls: none directly (shared/local data only)

### Panel: Stock Transfer Scan Grid

included by `stockTransferAddItemPartial`. Template: `PosViews/stockTransferScanGridPartial.html`.

```text
input search "Search for products..." (model: scanGridSearchText)
text "{minSymbolsMessage}"
text "Product"
text "Batch"
text "Expiry date"
text "On hand"
for each row in displayAvailableProducts:
  tap area "{row.ProductCode}: {row.Name} {row.BatchSN} {row.ExpiryDate2" <div> → modifyTransferItem(row)
```

API calls: none directly (shared/local data only)

### Panel: Stocktake Process

included by `stockTakePartial`. Template: `PosViews/stocktakeProcessPartial.html`.

```text
dialog #stockTakeProcessModal:
  form (name: stocktakeProcessForm):
    heading "{currentStocktake.name}"
    tap area "x" <span> → goBack('process')
    if currentStocktake.status=='IN PROGRESS':
      button "Scan barcode" → showScanDlg()
    if currentStocktake.status=='IN PROGRESS':
      button "Complete" → completeStocktakeDlgShow()
    input search "Type text to search" (model: currentStocktake.searchText) → enter: loadGridProcess(true)
    text "Name"
    text "Bin"
    text "Batch"
    text "Unit"
    if currentStocktake.showOnHand:
      text "Quantity on hand"
    text "Stocktake quantity"
    for each row in currentStocktake.data:
      tap area "{row.Name} {row.ProductCode} {row.LocationName} {row.BatchSN" <div> → showSetQuantityDlg(row)
```

API calls: none directly (shared/local data only)

### Panel: Stocktake Quantity Absolute

included by `stockTransferAddItemPartial`, `stockTransferSetQuantityDialogPartial`, `stocktakeScanPartial`, `stocktakeSetQuantityDialogPartial`. Template: `PosViews/stocktakeQuantityAbsolutePartial.html`.

```text
text "SKU:"
text "{quantityObject.ProductCode}"
text "Name:"
text "{quantityObject.Name}"
if not quantityObject.hideBarcode===true:
  text "Barcode:"
  text "{quantityObject.Barcode}"
if quantityObject.showOnHand:
  text "On hand:"
  text "{quantityObject.QuantityOnHand}"
if quantityObject.CostingMethod!='FIFO':
  if quantityObject.readOnly===true || quantityObject.QuantityOnHand > 0:
    text "{quantityObject.BatchSN}"
  label "Batch/SN *"
  if not quantityObject.readOnly===true || quantityObject.QuantityOnHand > 0:
    input text (model: quantityObject.BatchSN; required)
if quantityObject.CostingMethod!='FIFO':
  if quantityObject.readOnly===true || quantityObject.QuantityOnHand > 0:
    text "{quantityObject.date}"
  label "Expiry date *"
  if not quantityObject.readOnly===true || quantityObject.QuantityOnHand > 0:
    input text (model: quantityObject.ExpiryDate; required)
if !!quantityObject.ID && !(isScanDlgVisible && !!stocktakeScanActiveTab && stocktakeScanActiveTab==0):
  text "Stocktake quantity:"
  if not quantityObject.CostingMethod=='FESN' || quantityObject.CostingMethod=='FISN' || quantityObject.CostingMethod == 'SN':
    tap area "{quantityObject.Adjustment}" <span> → showItemQuantityDlg()
  if quantityObject.CostingMethod=='FESN' || quantityObject.CostingMethod=='FISN' || quantityObject.CostingMethod == 'SN':
    input select "Choose..." (model: quantityObject.Adjustment) options: {item}
if not quantityObject.QuantityOnHand > 0:
  if quantityObject.readOnly===true:
    text "{quantityObject.ReceivedDate}"
  label "Received date *"
... (2 more lines of the same kinds of fields omitted)
```

API calls: none directly (shared/local data only)

### Panel: Stocktake Scan

included by `stockTakePartial`. Template: `PosViews/stocktakeScanPartial.html`.

```text
dialog #stocktakeScanDlg:
  form (name: stocktakeScanForm):
    heading "SCANNING"
    tap area "x" <span> → hideScanDlg()
    if !!currentStocktake.bins && currentStocktake.bins.length>0:
      label "BIN"
      input select (model: currentStocktake.scanLocationID) options: {item.Name}
    component <uib-tabset> [active=stocktakeScanActiveTab, justified=true]
      component <uib-tab> [index=0, heading=Automatic]
        heading "Scan your Product Barcode, SKU or Batch/Serial number"
        if helperService.canShowCameraScanIcon():
          tap area <span> → helperService.cameraScan(false,true)
        if not helperService.canShowCameraScanIcon():
          text "Ready to scan"
        if !!scanError && scanError.length>0:
          text "{scanError}"
        if !!scanSuccess && scanSuccess.length>0:
          text "{scanSuccess}"
        if !!stockTakeScanData && stockTakeScanData.length>0:
          include: stocktakeScanGridPartial
          button "Add new stock" → addNewZeroStockItem()
        if !!quantityObject && !!quantityObject.ID && quantityObject.CostingMethod != 'FIFO':
          include: stocktakeQuantityAbsolutePartial
      component <uib-tab> [index=1, heading=Inventory]
        heading "Scan your Barcodes saving them in scanner memory. Once you are back from your warehouse, simply dump all scanned barcode"
        if helperService.canShowCameraScanIcon():
          tap area <span> → helperService.cameraScan(true,true)
        if !!scanError && scanError.length>0:
          text "{scanError}"
        if !!scanSuccess && scanSuccess.length>0:
          text "{scanSuccess}"
        input textarea (model: fakeVar)
... (22 more lines of the same kinds of fields omitted)
```

API calls: none directly (shared/local data only)

### Dialog: Stocktake Set Quantity Dialog

included by `stockTakePartial`. Template: `PosViews/stocktakeSetQuantityDialogPartial.html`.

```text
dialog #stocktakeSetQuantityDlg:
  form (name: stocktakeSetQuantityForm):
    heading "Specify stocktake quantity"
    tap area "x" <span> → helperService.closeDialog('#stocktakeSetQuantityDlg')
    if !!currentStocktake.bins && currentStocktake.bins.length>0:
      label "Bin"
      input select (model: quantityObject.LocationID) options: {item.Name}
    include: stocktakeQuantityAbsolutePartial
    button "Save" → helperService.closeDialog('#stocktakeSetQuantityDlg');adjustStocktakeAbsolute() [disabled when stocktakeSetQuantityForm.$invalid]
```

API calls: none directly (shared/local data only)

### Small dialogs and fragments

Short pop-ups and sub-view fragments (7 lines or fewer, no direct server calls), grouped to save space. Each block starts with the template name.

```text
[cameraScanSequentialPartial] Camera Scan Sequential
  dialog #cameraScanModal:
    text "{barcode}"
    button "Next" → nextScan()
    button "Finish" → finishScan()
[changeLanguagePartial] Change Language (included by `headerPartial`)
  dialog #changeLanguagePartial:
    heading "Select language"
    input select (model: selectedLanguage.Value) options: {language.Text}
    button "Apply" → setLanguage();closeChangeLanguageDialog()
    button "Cancel" → closeChangeLanguageDialog()
[customerEmailWarningDialog] Customer Email Warning Dialog (included by `sellPartial`)
  dialog #customerEmailWarningDialog:
    heading "Warning"
    tap area "x" <span> → closeCustomerEmailWarningDialog();
    label "Email"
    input email "Customer Email" (name: customerEmail)
    button "Update" → closeCustomerEmailWarningDialog(); editCustomerEmail();
    button "Close" → closeCustomerEmailWarningDialog();
[dashboardDetailsPartial] Dashboard Details (included by `dashboardPartial`)
  dialog #dashboardDetailsDialogPartial:
    heading "{chartDetails.Title}"
    tap area "x" <span> → closeDashboardDetailsDialog()
    text "{chartDetails.totalValue}"
    for each outlet in chartDetails.Outlets:
      text "{outlet.Name}"
      text "{outlet.Value}"
[deliveryCalendarPartial] Delivery Calendar (included by `deliveryDialogPartial`)
  dialog #deliveryCalendarPage:
    heading "Delivery calendar"
    tap area "x" <span> → helperService.closeDialog('#deliveryCalendarPage')
[errorDialogPartial] Error Dialog
  dialog #errorModal:
    text "x"
    button "Ok"
[fullCalendarPartial] Full Calendar (included by `salesHistoryPartial`)
  dialog #fullCalendarDialogModel:
    button "" → active = 1
    heading "Full calendar"
    tap area "x" <span> → cancelDialog()
    button "Close" → cancelDialog()
[layByPaymentDateDialogPartial] Lay By Payment Date Dialog (included by `sellPartial`)
  dialog #layByDateDlg:
    form (name: layByDateForm):
      heading "Select layby date"
      tap area "x" <span> → helperService.closeDialog('#layByDateDlg');layByDateDialogCallback('cancel')
      tap area <div> → showCalendar($event)
      button "Save" → helperService.closeDialog('#layByDateDlg');layByDateDialogCallback('save')
      button "Cancel" → helperService.closeDialog('#layByDateDlg');layByDateDialogCallback('cancel')
[linklyPinPadPairing] Linkly Pin Pad Pairing (included by `setupPartial`)
  dialog #linklyPinPadPairing:
    heading "Warning"
    dialog:
      text "The PIN pad has already been paired. Do you want to remove the current pairing and pair it again?"
    button "Yes" → closeLinklyPinPadPairingConfirmDialog(); pairLinklyPaymentSystem();
    button "No" → closeLinklyPinPadPairingConfirmDialog();
[loyaltyConfirmPartial] Loyalty Confirm (included by `sellPartial`)
  dialog #loyaltyConfirmPartialDialog:
    tap area "x" <span> → closeLoyaltyDialog()
    dialog:
      text "You can only redeem up to the value of your current loyalty balance. You may still proceed with this as a partial payment, then choose another payment method fo"
    button "Continue" → loyaltyPay(true);closeLoyaltyDialog()
[loyaltyLionDialogPartial] Loyalty Lion Dialog
  text "Loyalty Points"
  dialog #loyaltyLionModal:
    heading "Loyalty Lion"
    tap area "x" <span> → closeLoyaltyLionDialog()
    button "Close" → closeLoyaltyLionDialog()
[messageBoxPartial] Message Box (included by `sellPartial`, `setupPartial`)
  dialog #messageBoxModal:
    tap area "x" <span> → helperService.closeDialog('#messageBoxModal')
    text "{$parent.messageBoxText}"
    button "{$parent.messageBoxYes ? $parent.messageBoxYes : 'Yes'}" → closeDiscardDialog(false)
    button "{$parent.messageBoxNo ? $parent.messageBoxNo : 'No'}" → closeDiscardDialog(true)
[offlinePaymentsDialogPartial] Offline Payments Dialog (included by `salesHistoryPartial`, `sellPartial`)
  (no static content)
[partialPaymentsDialogPartial] Partial Payments Dialog (included by `sellPartial`)
  dialog #partialPaymentsDlg:
    heading "Cancel partial payments"
    list: columns Payment type | Sum
      rows: for each row in currentSale.Payments show {row.PaymentTypeName} | {currency_symbol} {row.Amount} | <btn>
        tap area <div> → cancelPaymentDlg(row)
        button "" → cancelPaymentDlg(row)
    button "Close" → helperService.closeDialog('#partialPaymentsDlg')
[pdfWebPrintPartial] Pdf Web Print (included by `deliveryPartial`)
  dialog #pdfPreviewDialog:
    tap area "x" <span> → helperService.closeDialog('#pdfPreviewDialog');
[productManagementPriceDlgPartial] Product Management Price Dlg (included by `productManagementPartial`)
  component <ngm-keyboard> [float-precision=floatPrecision]
  button "Apply" → callback(true, $event)
[productOptionsPartial] Product Options (included by `sellPartial`)
  (no static content)
[requestCancelDialogPartial] Request Cancel Dialog
  dialog #requestCancelModalDlg:
    tap area "x" <span> → cancelAllRequests()
    dialog:
      text "Press the 'Cancel' button to interrupt the request."
    button "Cancel" → cancelAllRequests()
[returnSaleDialogPartial] Return Sale Dialog (included by `sellPartial`; referenced from `sellController`)
  (no static content)
[sellCheckoutSectionNewPartial] Sell Checkout Section New (included by `sellPartial`)
  for each item in currentSale.CheckoutItems | orderBy:'-' track by item.ID:
    tap area "{item.Name} {item.Sku} Count: {item.Count} SN: {item.SerialN" <div> → toggleItemDetails(item)
[sellProductNamePartial] Sell Product Name (included by `sellCheckoutSectionNewPartial`, `sellCheckoutSectionPartial`)
  text "{item.Name}"
  text "{item.Sku}"
  if !!item.SerialNumber:
    text "{item.SerialNumber}"
  text "Count:"
  text "{item.Count}"
[sellProductPriceNewPartial] Sell Product Price New (included by `sellCheckoutSectionNewPartial`)
  if item.BasePrice != item.FinalPrice:
    text "{currency_symbol} {item.FinalAmount | number:2}"
    if item.BasePrice != item.FinalPrice && item.FinalAmount > 0:
      text "{currency_symbol} {item.BasePrice*item.Count | number:2}"
  if not item.BasePrice != item.FinalPrice:
    text "{currency_symbol} {item.FinalAmount | number:2}"
[setupLabelPrinterSelectFromListDlgPartial] Setup Label Printer Select From List Dlg
  dialog #selectLabelPrinterFromListModalDlg:
    heading "Please select a label printer from the list below"
    list: columns Label printer name
      rows: for each row in labelPrintersList show {row.labelPrinterName} {row.modelName}
    button "Cancel" → helperService.closeDialog('#selectLabelPrinterFromListModalDlg')
[setupPrinterSelectFromListDlgPartial] Setup Printer Select From List Dlg (included by `setupPartial`)
  dialog #selectPrinterFromListModalDlg:
    heading "Please select a printer from the list below"
    list: columns Printer name
      rows: for each row in printersList show {row.printerName} {row.modelName} ({row.interface 
    button "Cancel" → helperService.closeDialog('#selectPrinterFromListModalDlg')
[stockItemQuantityDlgPartial] Stock Item Quantity Dlg (included by `stockPurchaseOrderDetailsPartial`, `stockTakePartial`, `stockTransferOrderAddItemPartial`, `stockTransferOrderDetailsPartial`)
  component <ngm-keyboard> [float-precision=floatPrecision]
  button "Apply" → callback(true, $event)
[stockTransferOrderReorderDialogPartial] Stock Transfer Order Reorder Dialog (included by `stockTransferOrderDetailsPartial`)
  dialog #reorderItemsDialogModal:
    heading "Reorder products"
    tap area "x" <span> → closeReorderDlg(false, true)
    dialog:
      text "Would you like to reorder only the products available at {currentOrder.fromLocationName}, or all low on stock products?"
    button "All low on stock" → closeReorderDlg(true)
    button "Only available" → closeReorderDlg(false)
[stockTransferOrderSetQuantityDialogPartial] Stock Transfer Order Set Quantity Dialog (included by `stockPurchaseOrderDetailsPartial`, `stockTransferOrderAddItemPartial`, `stockTransferOrderDetailsPartial`)
  dialog #stockTransferSetQuantityDlg:
    form (name: stockTransferSetQuantityForm):
      heading "Specify product quantity"
      include: stockTransferOrderQuantityAbsolutePartial
      button "Set" → helperService.closeDialog('#stockTransferSetQuantityDlg');adjustStockTransfer() [disabled when stockTransferSetQuantityForm.$invalid]
      button "Cancel" → helperService.closeDialog('#stockTransferSetQuantityDlg')
[stockTransferSetQuantityDialogPartial] Stock Transfer Set Quantity Dialog (included by `stockTransferProcessPartial`)
  dialog #stockTransferSetQuantityDlg:
    form (name: stockTransferSetQuantityForm):
      heading "Specify stock transfer quantity"
      include: stocktakeQuantityAbsolutePartial
      button "Set" → helperService.closeDialog('#stockTransferSetQuantityDlg');adjustStockTransfer() [disabled when stockTransferSetQuantityForm.$invalid]
      button "Cancel" → helperService.closeDialog('#stockTransferSetQuantityDlg')
[stocktakeScanGridPartial] Stocktake Scan Grid (included by `stocktakeScanPartial`)
  text "Product"
  text "Bin"
  text "Batch"
  text "Expiry date"
  for each row in availableProducts:
    tap area "{row.ProductCode}: {row.Name} {row.LocationName} {row.BatchS" <div> → selectScanProduct(row)
[storeCreditConfirmPartial] Store Credit Confirm (included by `sellPartial`)
  (no static content)
```

### Legacy layout variants

These templates are the older layout of a part that also exists in a newer layout (the register picks one with `helperService.showNewCheckoutUI(...)`); they hold the same kinds of fields and are not repeated: `sellCheckoutSectionPartial` (older form of `sellCheckoutSectionNewPartial`), `sellProductPricePartial` (older form of `sellProductPriceNewPartial`), `sellToPayPartial` (older form of `sellToPayNewPartial`), `sellTopInfoPartial` (older form of `sellTopInfoNewPartial`), `sellTotalSectionPartial` (older form of `sellTotalSectionNewPartial`), `stockTransferOrderScanGridPartial2` (older form of `stockTransferOrderScanGridPartial`), `stockTransferScanGridPartial2` (older form of `stockTransferScanGridPartial`).
