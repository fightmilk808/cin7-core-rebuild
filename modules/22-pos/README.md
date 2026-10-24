# POS

The point-of-sale app: `pos.dearsystems.com` on the web and the Cin7 Core POS mobile app (the same AngularJS 1.x code in
Cordova). Configured in the main app at `/DearPos` (bundle `Pos2019`, the `/api/DearPos_*` endpoints in
[`12-integrations`](../12-integrations/README.md)).

## How it works

- The app asks `GET /Pos/GetServerAddress` for its server, then calls
  `https://inventory.dearsystems.com/ExternalApi/POS/<Resource>`, an API namespace of its own beside `/ExternalApi/v2`.
- Sign-in: `POST /PosExternalAuth`. It also uses public `v2` (`/advanced-purchase`, `/purchase/order`) for stock ordering.
- Resources cover outlets and registers, opening and closing a register, cash management, orders and lay-bys, customers,
  products and availability, serial numbers, coupons and gift cards, click-and-collect with auto-pick and fulfilment,
  deliveries, stock ordering and transfers, and a dashboard.
- Payment terminals: Linkly/PC-EFTPOS cloud, Tyro iClient, Worldpay triPOS, Windcave, Square refunds. LoyaltyLion rewards.
  Google sign-in.

## How to rebuild it

An offline-capable client app over a dedicated `/ExternalApi/POS/*` namespace: register sessions, cart and checkout,
customer lookup, availability checks at checkout, and a terminal adapter per payment provider. The calls it needs are below.

## Every call (87)

| path | methods | params | client_functions |
|---|---|---|---|
| `/ExternalApi/v2/advanced-purchase` | DELETE POST PUT | ID void | deleteUndoPurchase saveNewPurchase updatePurchase |
| `/ExternalApi/v2/purchase/order` | POST |  | savePurchaseOrder |
| `/lanes/` | DELETE GET |  |  |
| `/Pos/GetServerAddress` | GET |  | getApiUrl |
| `/PosAccount` | POST |  |  |
| `/PosCashManagement` | GET POST | CloseRegistryID Data | addCashMovements getCashMovements |
| `/PosChangeEvent` | GET |  | dataChangeStatuses |
| `/PosCheckoutProductsAvailability` | POST |  | checkCheckoutProductsAvailability |
| `/PosCheckSerialNumber` | GET | OutletID ProductID SerialNumber | checkSerialNumber |
| `/PosClickAndCollect` | GET | CustomerSearch FromOrderLines Limit OutletID Page SaleNumberSearch TaskID limit page | loadClickAndCollectSale loadClickAndCollectSales |
| `/PosClickAndCollectAutoPick` | GET | FromOrderLines OutletID TaskID | clickAndCollectAutoPick |
| `/PosClickAndCollectFulfilment` | POST |  | clickAndCollectFulfill |
| `/PosCloseRegistry` | GET POST | Data IsActive RegistryID UserName isMobile | closeRegistry getClosedRegistries |
| `/PosCORSProxy` | DELETE GET POST | initialUrl |  |
| `/POSCorsProxy` | POST |  |  |
| `/PosCountry` | GET |  | loadCountries |
| `/PosCoupon` | GET | CouponCode | getSaleCoupons |
| `/PosCustomer` | DELETE POST PUT |  | createCustomer removeCustomer |
| `/PosCustomer2` | GET | Email FakeServerKey ID | getCustomer loadFakeCustomer |
| `/PosDashboard` | GET | ApplicationID DateFrom DateTo OutletID UserID ViewMode outletID | getDashboardData |
| `/PosDelivery` | GET |  | loadDeliveries |
| `/PosDeliveryDetails` | GET POST PUT | deliveryID deliveryTaskID locationID newStatus posOrderID | CreateDelivery UpdateDelivery UpdateDeliveryTaskStatus loadDelivery loadProductsAvailableForDelivery |
| `/PosDeliveryDetails/YearCalendarSettings` | POST | ecsLocationMappingID | loadCalendars |
| `/PosDiscounts` | GET |  | getPosDiscounts |
| `/PosExternalAuth` | POST | ExternalToken Password Platform PosApplicationName TokenType UserName | linkingExternal |
| `/PosGetRate` | GET | date from to | getExchangeRate |
| `/PosGiftCard` | POST |  | getGiftCardForPayment getGiftCardSettings isGiftCardsRefundAvailable |
| `/PosGiftCard/` | POST |  | checkGiftCardExists |
| `/PosLoadCustomer2` | GET | checkCount isLiveDataRequest | loadLiveCustomers |
| `/PosLoadSaleRepresentatives` | GET | SaleRepresentativesHash | loadSaleRepresentativesAll |
| `/PosLoyaltyLionCustomerRewards` | GET | MerchantID | getLLCustomerRewards |
| `/PosOpenRegistry` | POST | Data ID IsMobile RegistryID SalesRepresentative | openRegistry |
| `/PosOrder` | DELETE GET POST | Data ID PosOrderID | checkSaleOrderExists discardParkedSale processSale voidSale |
| `/PosOrder/GetNextSequence` | GET | RegistryID | getNextSequence |
| `/PosOrderAttachment` | DELETE POST | attachmentId orderID userName | attachFilesToOrder removeAttachment |
| `/PosOrderList` | GET | ApplicationID ID Limit OutletID Page SaleID Status |  |
| `/PosOrderListDEARSales` | GET | TaskID | loadDEARSale loadDEARSales |
| `/PosOutlet` | GET | ID UserID | getPosOutlet getPosOutletsRegistry getUserPosOutletsRegistry |
| `/PosPasswordRecovery` | POST | PosApplicationName UserName | recoverPassword |
| `/PosPing` | GET | configID tenantID |  |
| `/PosProduct3` | GET | ProductHash hash ignoreNullValues isLiveDataRequest outletLocationMappingID | getLiveSearchProducs loadProducts |
| `/PosProductAvailability` | GET |  | getProductAvailability |
| `/PosProductManagement` | GET POST PUT |  | loadProductList |
| `/PosProductSearch2` | GET | Barcode Family Limit Name ProductCode ProductID QuickKeyID QuickKeyTemplateID outletLocationMappingID | getProductByID search |
| `/PosPurchaseOrderData` | GET |  | loadPurchaseOrderRelatedData |
| `/PosPurchaseOrderEmail` | GET POST | TaskID TemplateID User | getPurchaseOrderEmail sendPurchaseOrderEmail |
| `/PosPurchaseOrderPrint` | GET | TaskID TemplateID User | printPurchaseOrder |
| `/PosPurchaseOrderProcess` | GET | Direction FieldName Limit LocationID Page SortDirection SortField TaskID limit page | loadPurchaseOrderDetails |
| `/PosPurchaseOrderTask` | GET | taskID | loadPurchaseTask |
| `/PosPurchaseReorder` | GET | locationID supplierID | loadPurchaseReorderData |
| `/PosReceipt` | GET | ID ReportShortName RootProperty Type | getLabelTemplate getReceiptTemplate getReceiptTemplateByName |
| `/PosReceiptEmail` | POST | BaseOrderID DocumentBody Email EmailBody EmailSubject IgnoreOrderID OrderID TemplateID | sendEmailReceipt |
| `/PosRegistrySequence/GetCurrentSequence` | GET | RegistryID | getCurrentSequence |
| `/PosSearchSaleRepresentatives` | GET |  |  |
| `/PosSetPassword` | POST | FinalizeID Password | setPassword |
| `/PosSquareRefund` | POST |  | squareRefund |
| `/PosStockOrderingTasks` | GET |  | loadStockOrderingList |
| `/PosSurcharge` | GET |  | loadSurcharges |
| `/PosTaxRules` | GET |  | loadTaxRules |
| `/PosTemplate` | GET | Name Process RootProperty Type | getTemplates |
| `/PosUser` | GET PUT | ID NewPassword OldPassword | changePassword loadPosUsers |
| `/PosUserActivation` | PUT | ID isLocked | activateUser deactivateUser |
| `/PosUserManagement` | DELETE GET POST PUT | CurrentUser ID Name OutletID RoleName UserName | createPosUser removePosUser updatePosUser |
| `/PosUserPin` | PUT | PinToken UserID | savePin |
| `/PosUtils` | POST |  | posUtils |
| `/ProductDataParams` | GET |  | getProductData |
| `/ReportCloseRegistry` | GET |  | loadRegistryCloseList |
| `/ReportCloseRegistryDetails` | GET | RegistryCloseID | loadClosureRegistryDetails |
| `/ReportGiftCard` | GET POST PUT |  | loadReportGiftCard loadReportGiftCardCSV loadReportGiftCardEmail |
| `/ReportInTransit` | GET POST PUT |  | loadInTransitReport loadInTransitReportCSV loadInTransitReportEmail |
| `/ReportInventory` | GET POST PUT |  | loadInventoryReport loadInventoryReportCSV loadInventoryReportEmail |
| `/ReportPaymentTypeSummary` | GET POST PUT |  | loadPaymentTypeSummary loadPaymentTypeSummaryReportCSV loadPaymentTypeSummaryReportEmail |
| `/ReportProdPerf` | GET POST PUT |  | loadProductPerformanceReport loadProductPerformanceReportCSV loadProductPerformanceReportEmail |
| `/ReportSalesSummary` | GET POST PUT |  | loadSalesSummary loadSalesSummaryCSV loadSalesSummaryEmail |
| `/ReportStoreCredit` | GET POST PUT |  | loadStoreCredit loadStoreCreditCSV loadStoreCreditEmail |
| `/ReportSurcharge` | GET POST PUT |  | loadSurchargeReport loadSurchargeReportCSV loadSurchargeReportEmail |
| `/sale` | POST |  |  |
| `/StockTake` | GET |  | getStockTakeData |
| `/Stocktake` | PUT | localDate status taskID userName | cancelStocktake completeStocktake startStocktake undoStocktake |
| `/StocktakeProcess` | GET POST PUT | LocationID SearchString TaskID batchSN expiryDate isAbsolute itemID locationID productID receivedDate taskID value | adjustStocktakeItem loadStocktake scanStockTakeInventoryMode |
| `/StocktakeTask` | DELETE GET POST PUT | Direction FieldName Limit Page SortDirection SortField Status TaskID limit page | deleteStocktake loadStocktakeList saveNewStockTake updateStockTake |
| `/StockTransfer` | DELETE GET PUT | TaskID completionDate mode | completeStockTransfer deleteStockTransfer loadStockTransferList undoStockTransfer |
| `/StockTransferData` | GET |  | loadStockTransferSatelliteData |
| `/StockTransferOrderData` | GET |  | loadStockTransferOrderRelatedData |
| `/StockTransferOrderProcess` | GET POST PUT | Direction FieldName Limit Page SortDirection SortField TaskID limit page | loadStockTransferOrderDetails saveNewStockTransferOrder updateStockTransferOrder |
| `/StockTransferProcess` | GET POST PUT | Direction FieldName Limit Page SortDirection SortField TaskID limit page | loadStockTransferDetails saveNewStockTransfer updateStockTransfer |
| `/StockTransferReorder` | GET | fromLocationID onlyAvailable toLocationID | loadStockTransferReorderData |
