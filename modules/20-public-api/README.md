# Public API and webhooks

The documented integration surface: `https://inventory.dearsystems.com/ExternalApi/v2` (a few resources only on v1,
`/ExternalApi/<Resource>`). Cin7 publishes it as an API Blueprint
([dearinventory.apib](https://jsapi.apiary.io/apis/dearinventory.apib), docs at
[dearinventory.docs.apiary.io](https://dearinventory.docs.apiary.io/)). 295 operations on 115 paths in 32 groups:
102 GET, 83 POST, 65 PUT, 45 DELETE. Each module folder lists its own operations; the full contract is in
[`docs/PUBLIC-API.md`](../../docs/PUBLIC-API.md).

## How to rebuild it

1. **Auth.** Issue API applications per tenant: an account id plus an application key. Every request carries
   `api-auth-accountid` and `api-auth-applicationkey`. JSON only.
2. **Rate limit.** 60 calls a minute per API application; answer 429 above it.
3. **Lists.** `GET /<resource>List` (or the resource with `Page`/`Limit`) returns `{Total, Page, <ArrayKey>: [...]}`.
   List rows are summaries; details come from `GET /<resource>?ID=`.
4. **Incremental reads.** `ModifiedSince` on master data (product, customer, supplier, product family), `UpdatedSince` on
   sale and purchase lists. Unknown query parameters are ignored, not rejected.
5. **Nested arrays on demand.** `/product` returns BOM, suppliers, reorder levels, movements, attachments and custom prices
   only when the matching `Include*` flag is set.
6. **Errors.** Unknown path: 302 to `/Error/NotFound`. Missing record: 400 with `[{"ErrorCode", "Exception"}]`.
7. **Writes.** POST creates, PUT updates (full-object replace on `/product`), DELETE takes `ID`.
8. **Webhooks.** `GET/POST/PUT/DELETE /webhooks` manages subscriptions; Cin7 POSTs JSON to the subscriber's URL.

## Webhook events (31 in the spec, 32 accepted)

| Object | Events |
|---|---|
| Sale | Created, OrderAuthorised, QuoteAuthorised, Backordered, PickAuthorised, PackAuthorised, ShipmentAuthorised, ShipmentTrackingNumberChanged, InvoiceAuthorised, PartialPaymentReceived, FullPaymentReceived, CreditNoteAuthorised, Voided, Undo, AttachmentAdded, AdditionalAttributesChanged |
| Purchase | OrderAuthorised, StockReceivedAuthorised, InvoiceAuthorised, CreditNoteAuthorised, Updated |
| Product / Customer / Supplier | Updated |
| Stock | AvailableStockLevelChanged (body is a bare array of `{ID, SKU, Location, OnHand, Allocated, Available, OnOrder}`) |
| Lead | Updated, Converted |
| Opportunity | Authorized, Converted, Voided, AttachmentAdded |

Events fire on status transitions only. There are none for production orders, assemblies, transfers, adjustments or
stocktakes. Sale and purchase payloads carry a `DownloadLink` to the rendered PDF.

## Every call (295)

| group | method | path | query |
|---|---|---|---|
| `Attribute Set` | GET | `/ref/attributeset` | ID,Page,Limit,Name |
| `Attribute Set` | POST | `/ref/attributeset` |  |
| `Attribute Set` | PUT | `/ref/attributeset` |  |
| `Attribute Set` | DELETE | `/ref/attributeset` | ID |
| `Bank Accounts` | GET | `/ref/account/bank` | Page,Limit,ID,Name,Bank |
| `Brand` | GET | `/ref/brand` | Page,Limit,Name |
| `Brand` | POST | `/ref/brand` |  |
| `Brand` | PUT | `/ref/brand` |  |
| `Brand` | DELETE | `/ref/brand` | ID |
| `Carrier` | GET | `/ref/carrier` | Page,Limit,CarrierID,Description |
| `Carrier` | POST | `/ref/carrier` |  |
| `Carrier` | PUT | `/ref/carrier` |  |
| `Carrier` | DELETE | `/ref/carrier` | ID |
| `Chart of Accounts` | GET | `/ref/account` | Page,Limit,Code,Name,Type,Status |
| `Chart of Accounts` | POST | `/ref/account` |  |
| `Chart of Accounts` | PUT | `/ref/account` |  |
| `Chart of Accounts` | DELETE | `/ref/account` | Code |
| `Customer` | GET | `/customer` | Page,Limit,ID,Name,ModifiedSince,IncludeDeprecated,IncludeProductPrices,ContactFilter |
| `Customer` | POST | `/customer` |  |
| `Customer` | PUT | `/customer` |  |
| `Customer` | GET | `/ref/customer/templates` | Page,Limit,CustomerId |
| `Customer` | POST | `/ref/customer/templates` |  |
| `Customer` | DELETE | `/ref/customer/templates` | TemplateId,CustomerId |
| `Customer` | GET | `/ref/customer/credits` | Page,Limit,CustomerID,ShowUsedCredits |
| `Disassembly` | GET | `/disassemblyList` | Page,Limit,Status,Search |
| `Disassembly` | GET | `/disassembly` | TaskID |
| `Disassembly` | POST | `/disassembly` |  |
| `Disassembly` | DELETE | `/disassembly` | ID,Void |
| `Disassembly` | GET | `/disassembly/order` | TaskID |
| `Disassembly` | POST | `/disassembly/order` |  |
| `Finished Goods` | GET | `/finishedGoodsList` | Page,Limit,Status,Search,SaleID |
| `Finished Goods` | GET | `/finishedGoods` | TaskID |
| `Finished Goods` | POST | `/finishedGoods` |  |
| `Finished Goods` | PUT | `/finishedGoods` |  |
| `Finished Goods` | DELETE | `/finishedGoods` | ID,Void |
| `Finished Goods` | GET | `/finishedGoods/order` | TaskID |
| `Finished Goods` | POST | `/finishedGoods/order` |  |
| `Finished Goods` | GET | `/finishedGoods/pick` | TaskID |
| `Finished Goods` | POST | `/finishedGoods/pick` |  |
| `Fixed Asset Type` | GET | `/ref/fixedassettype` | Page,Limit,ID,Name |
| `Fixed Asset Type` | POST | `/ref/fixedassettype` |  |
| `Fixed Asset Type` | PUT | `/ref/fixedassettype` |  |
| `Inventory Write-Off` | GET | `/inventoryWriteOffList` | Page,Limit,Status,Search |
| `Inventory Write-Off` | GET | `/inventoryWriteOff` | TaskID |
| `Inventory Write-Off` | POST | `/inventoryWriteOff` |  |
| `Inventory Write-Off` | PUT | `/inventoryWriteOff` |  |
| `Inventory Write-Off` | DELETE | `/inventoryWriteOff` | ID,Void |
| `Journal` | GET | `/journal` | Page,Limit,TaskID,Status,Search |
| `Journal` | POST | `/journal` |  |
| `Journal` | PUT | `/journal` |  |
| `Journal` | DELETE | `/journal` | ID,Void |
| `Location` | GET | `/ref/location` | ID,Page,Limit,Deprecated,Name |
| `Location` | POST | `/ref/location` |  |
| `Location` | PUT | `/ref/location` |  |
| `Location` | DELETE | `/ref/location` | ID |
| `Me` | GET | `/me` |  |
| `Me` | GET | `/me/addresses` | Page,Limit,ID,Type,DefaultForType,Country,StateProvince,CitySuburb |
| `Me` | POST | `/me/addresses` |  |
| `Me` | PUT | `/me/addresses` |  |
| `Me` | DELETE | `/me/addresses` | ID |
| `Me` | GET | `/me/contacts` | Page,Limit,ID,Name,Type,DefaultForType,Phone,Fax,Email |
| `Me` | POST | `/me/contacts` |  |
| `Me` | PUT | `/me/contacts` |  |
| `Me` | DELETE | `/me/contacts` | ID |
| `Money Task` | GET | `/moneyTaskList` | Page,Limit,Status,Search,TaskType |
| `Money Task` | GET | `/moneyOperation` | TaskID |
| `Money Task` | POST | `/moneyOperation` |  |
| `Money Task` | PUT | `/moneyOperation` |  |
| `Money Task` | DELETE | `/moneyOperation` | ID,Void |
| `Money Task` | GET | `/bankTransfer` | TaskID |
| `Money Task` | POST | `/bankTransfer` |  |
| `Money Task` | PUT | `/bankTransfer` |  |
| `Money Task` | DELETE | `/bankTransfer` | ID,Void |
| `Payment Term` | GET | `/ref/paymentterm` | Page,Limit,ID,Name,Method,IsActive,IsDefault |
| `Payment Term` | POST | `/ref/paymentterm` |  |
| `Payment Term` | PUT | `/ref/paymentterm` |  |
| `Payment Term` | DELETE | `/ref/paymentterm` | ID |
| `Price Tiers` | GET | `/ref/priceTier` |  |
| `Product` | GET | `/product` | ID,Page,Limit,Name,Sku,ModifiedSince,IncludeDeprecated,IncludeBOM,IncludeSuppliers,IncludeMovements,IncludeAttachments,IncludeReorderLevels,IncludeCustomPrices |
| `Product` | POST | `/product` |  |
| `Product` | PUT | `/product` |  |
| `Product` | GET | `/product/attachments` | ProductID |
| `Product` | POST | `/product/attachments` |  |
| `Product` | DELETE | `/product/attachments` | ID |
| `Product` | GET | `/ref/productavailability` | Page,Limit,ID,Name,Sku,Location,Batch,Category |
| `Product Categories` | GET | `/ref/category` | Page,Limit,Name |
| `Product Categories` | POST | `/ref/category` |  |
| `Product Categories` | PUT | `/ref/category` |  |
| `Product Categories` | DELETE | `/ref/category` | ID |
| `Product Family` | GET | `/productFamily` | ID,Page,Limit,Name,Sku,ModifiedSince |
| `Product Family` | POST | `/productFamily` |  |
| `Product Family` | PUT | `/productFamily` |  |
| `Product Family` | GET | `/productFamily/attachments` | FamilyID |
| `Product Family` | POST | `/productFamily/attachments` |  |
| `Product Family` | DELETE | `/productFamily/attachments` | ID |
| `Product Markup Prices` | GET | `/product/markupprices` | ProductID |
| `Product Markup Prices` | PUT | `/product/markupprices` |  |
| `Production` | GET | `/production/factoryCalendar` | Year |
| `Production` | POST | `/production/factoryCalendar` |  |
| `Production` | PUT | `/production/factoryCalendar` |  |
| `Production` | GET | `/production/productionBOM` | ProductID,ReturnAttachmentsContent |
| `Production` | POST | `/production/productionBOM` |  |
| `Production` | PUT | `/production/productionBOM` |  |
| `Production` | DELETE | `/production/productionBOM` | ProductID,BOMID |
| `Production` | GET | `/production/productionBOM` | ProductFamilyID,ReturnAttachmentsContent |
| `Production` | POST | `/production/productionBOM` |  |
| `Production` | PUT | `/production/productionBOM` |  |
| `Production` | DELETE | `/production/productionBOM` | ProductFamilyID,BOMID |
| `Production` | GET | `/production/order` | ProductionOrderID,returnAttachmentsContent |
| `Production` | POST | `/production/order` | RecalculateDates |
| `Production` | PUT | `/production/order` | AllowRecalculateDates,AllowRecalculateCyclesAndQuantities |
| `Production` | POST | `/production/order/authorise` |  |
| `Production` | POST | `/production/order/release` |  |
| `Production` | POST | `/production/order/undo` |  |
| `Production` | POST | `/production/order/attachment` | ProductionOrderID |
| `Production` | PUT | `/production/order/attachment` |  |
| `Production` | DELETE | `/production/order/attachment` | ProductionOrderAttachmentID |
| `Production` | GET | `/production/order/attachment` | ProductionOrderID,ReturnAttachmentsContent |
| `Production` | POST | `/production/order/void` |  |
| `Production` | GET | `/production/order/referenceData` |  |
| `Production` | GET | `/production/orderList` | Page,Limit,Status,Search,LocationID,RequiredByDateFrom,RequiredByDateTo,CompletionDateFrom,CompletionDateTo,SourceTaskID |
| `Production` | POST | `/production/order/run` |  |
| `Production` | GET | `/production/order/run` | ProductionOrderID,IncludeAttachmentContent |
| `Production` | PUT | `/production/order/run` | ProductionOrderID,IncreaseOrderQuantity |
| `Production` | PUT | `/production/order/run/complete` |  |
| `Production` | PUT | `/production/order/run/undo` |  |
| `Production` | PUT | `/production/order/run/void` |  |
| `Production` | PUT | `/production/order/run/manualJournal` | ProductionOrderID |
| `Production` | PUT | `/production/order/run/operation/start` |  |
| `Production` | PUT | `/production/order/run/operation/suspend` |  |
| `Production` | PUT | `/production/order/run/operation/resume` |  |
| `Production` | PUT | `/production/order/run/operation/complete` |  |
| `Production` | GET | `/production/resourceList` | Page,Limit,Name,OnlyActive |
| `Production` | GET | `/production/resource` | ResourceID,IncludeAttachments |
| `Production` | POST | `/production/resource` |  |
| `Production` | PUT | `/production/resource` |  |
| `Production` | DELETE | `/production/resource` | ResourceID |
| `Production` | GET | `/production/suspendReason` | Page,Limit,WorkcenterID |
| `Production` | PUT | `/production/suspendReason` |  |
| `Production` | GET | `/production/workcenters` | Page,Limit,Name |
| `Production` | POST | `/production/workcenters` |  |
| `Production` | PUT | `/production/workcenters` |  |
| `Production` | DELETE | `/production/workcenters` | WorkCenterId |
| `Purchase` | GET | `/purchaseList` | Page,Limit,Search,RequiredBy,UpdatedSince,OrderStatus,RestockReceivedStatus,InvoiceStatus,CreditNoteStatus,UnstockStatus,DropShipTaskID |
| `Purchase` | GET | `/purchaseCreditNoteList` | Page,Limit,Search,UpdatedSince,CreditNoteStatus |
| `Purchase` | GET | `/purchase` | ID,CombineAdditionalCharges |
| `Purchase` | POST | `/purchase` |  |
| `Purchase` | PUT | `/purchase` |  |
| `Purchase` | DELETE | `/purchase` | ID,Void |
| `Purchase` | GET | `/purchase/order` | TaskID,CombineAdditionalCharges |
| `Purchase` | POST | `/purchase/order` |  |
| `Purchase` | GET | `/purchase/stock` | TaskID |
| `Purchase` | POST | `/purchase/stock` |  |
| `Purchase` | GET | `/purchase/invoice` | TaskID,CombineAdditionalCharges |
| `Purchase` | POST | `/purchase/invoice` |  |
| `Purchase` | GET | `/purchase/creditnote` | TaskID,CombineAdditionalCharges |
| `Purchase` | POST | `/purchase/creditnote` |  |
| `Purchase` | GET | `/purchase/payment` | TaskID |
| `Purchase` | POST | `/purchase/payment` |  |
| `Purchase` | PUT | `/purchase/payment` |  |
| `Purchase` | DELETE | `/purchase/payment` | ID,DeleteAllocation |
| `Purchase` | GET | `/purchase/manualJournal` | TaskID |
| `Purchase` | POST | `/purchase/manualJournal` |  |
| `Purchase` | GET | `/purchase/attachment` | TaskID |
| `Purchase` | POST | `/purchase/attachment` |  |
| `Purchase` | DELETE | `/purchase/attachment` | ID |
| `Purchase` | GET | `/advanced-purchase` | ID,CombineAdditionalCharges |
| `Purchase` | POST | `/advanced-purchase` |  |
| `Purchase` | PUT | `/advanced-purchase` |  |
| `Purchase` | DELETE | `/advanced-purchase` | ID,Void |
| `Purchase` | GET | `/advanced-purchase/stock` | PurchaseID |
| `Purchase` | POST | `/advanced-purchase/stock` |  |
| `Purchase` | PUT | `/advanced-purchase/stock` |  |
| `Purchase` | DELETE | `/advanced-purchase/stock` | TaskID,Void |
| `Purchase` | GET | `/advanced-purchase/put-away` | PurchaseID |
| `Purchase` | POST | `/advanced-purchase/put-away` |  |
| `Purchase` | GET | `/advanced-purchase/invoice` | PurchaseID,CombineAdditionalCharges |
| `Purchase` | POST | `/advanced-purchase/invoice` |  |
| `Purchase` | DELETE | `/advanced-purchase/invoice` | TaskID,Void |
| `Purchase` | GET | `/advanced-purchase/creditnote` | PurchaseID,CombineAdditionalCharges |
| `Purchase` | POST | `/advanced-purchase/creditnote` |  |
| `Purchase` | DELETE | `/advanced-purchase/creditnote` | TaskID |
| `Purchase` | GET | `/advanced-purchase/payment` | PurchaseID,OrderNumber,InvoiceNumber,CreditNoteNumber |
| `Purchase` | POST | `/advanced-purchase/payment` |  |
| `Purchase` | PUT | `/advanced-purchase/payment` |  |
| `Purchase` | DELETE | `/purchase/payment` | ID,DeleteAllocation |
| `Purchase` | GET | `/advanced-purchase/manualJournal` | PurchaseID |
| `Purchase` | POST | `/advanced-purchase/manualJournal` |  |
| `Reference Books` | POST | `/custom-prices` |  |
| `Reference Books` | PUT | `/custom-prices` |  |
| `Reference Books` | DELETE | `/custom-prices` | ProductID,CustomerID |
| `Reference Books` | GET | `/reference/deals` | ID,Page,Limit,Search |
| `Reference Books` | POST | `/reference/deals` |  |
| `Reference Books` | PUT | `/reference/deals` |  |
| `Reference Books` | GET | `/reference/discount` | ID,Page,Limit,Search |
| `Reference Books` | POST | `/reference/discount` |  |
| `Reference Books` | PUT | `/reference/discount` |  |
| `Reference Books` | GET | `/product-suppliers` | ProductID |
| `Reference Books` | POST | `/product-suppliers` |  |
| `Reference Books` | PUT | `/product-suppliers` |  |
| `Reference Books` | DELETE | `/product-suppliers` | ProductID,SupplierID |
| `Reference Books` | GET | `/reference/shipZones` | ID,Page,Limit,Search |
| `Reference Books` | POST | `/reference/shipZones` |  |
| `Reference Books` | PUT | `/reference/shipZones` |  |
| `Reference Books` | DELETE | `/reference/shipZones` |  |
| `Reference Books` | GET | `/reference/shipZonesEnabled` |  |
| `Reference Books` | PUT | `/reference/shipZonesEnabled` |  |
| `Sale` | GET | `/saleList` | Page,Limit,Search,CreatedSince,UpdatedSince,ShipBy,QuoteStatus,OrderStatus,CombinedPickStatus,CombinedPackStatus,CombinedShippingStatus,CombinedInvoiceStatus,C… |
| `Sale` | GET | `/saleCreditNoteList` | Page,Limit,Search,CreatedSince,UpdatedSince,CreditNoteStatus,Status |
| `Sale` | GET | `/sale` | ID,CombineAdditionalCharges,HideInventoryMovements,IncludeTransactions,CountryFormat |
| `Sale` | POST | `/sale` |  |
| `Sale` | PUT | `/sale` |  |
| `Sale` | DELETE | `/sale` | ID,Void |
| `Sale` | GET | `/sale/quote` | SaleID,CombineAdditionalCharges,IncludeProductInfo |
| `Sale` | POST | `/sale/quote` |  |
| `Sale` | GET | `/sale/order` | SaleID,CombineAdditionalCharges,IncludeProductInfo |
| `Sale` | POST | `/sale/order` |  |
| `Sale` | GET | `/sale/fulfilment` | SaleID,IncludeProductInfo |
| `Sale` | POST | `/sale/fulfilment` |  |
| `Sale` | DELETE | `/sale/fulfilment` | TaskID,Void |
| `Sale` | GET | `/sale/fulfilment/pick` | TaskID,IncludeProductInfo |
| `Sale` | POST | `/sale/fulfilment/pick` |  |
| `Sale` | PUT | `/sale/fulfilment/pick` |  |
| `Sale` | GET | `/sale/fulfilment/pack` | TaskID,IncludeProductInfo |
| `Sale` | POST | `/sale/fulfilment/pack` |  |
| `Sale` | PUT | `/sale/fulfilment/pack` |  |
| `Sale` | GET | `/sale/fulfilment/ship` | TaskID |
| `Sale` | POST | `/sale/fulfilment/ship` |  |
| `Sale` | PUT | `/sale/fulfilment/ship` |  |
| `Sale` | GET | `/sale/invoice` | SaleID,CombineAdditionalCharges,IncludeProductInfo |
| `Sale` | POST | `/sale/invoice` |  |
| `Sale` | PUT | `/sale/invoice` |  |
| `Sale` | DELETE | `/sale/invoice` | TaskID,Void |
| `Sale` | GET | `/sale/creditnote` | SaleID,CombineAdditionalCharges,IncludeProductInfo,IncludePaymentInfo |
| `Sale` | POST | `/sale/creditnote` |  |
| `Sale` | DELETE | `/sale/creditnote` | TaskID,Void |
| `Sale` | GET | `/sale/payment` | SaleID |
| `Sale` | POST | `/sale/payment` |  |
| `Sale` | PUT | `/sale/payment` |  |
| `Sale` | DELETE | `/sale/payment` | ID |
| `Sale` | GET | `/sale/manualJournal` | SaleID |
| `Sale` | POST | `/sale/manualJournal` |  |
| `Sale` | GET | `/sale/attachment` | SaleID |
| `Sale` | POST | `/sale/attachment` |  |
| `Sale` | DELETE | `/sale/attachment` | ID |
| `Stock` | GET | `/stockadjustmentList` | Page,Limit,Status |
| `Stock` | GET | `/stockadjustment` | TaskID |
| `Stock` | POST | `/stockadjustment` |  |
| `Stock` | PUT | `/stockadjustment` |  |
| `Stock` | DELETE | `/stockadjustment` | ID,Void |
| `Stock` | GET | `/stockTakeList` | Page,Limit,Status |
| `Stock` | GET | `/stocktake` | TaskID |
| `Stock` | POST | `/stocktake` |  |
| `Stock` | PUT | `/stocktake` |  |
| `Stock` | DELETE | `/stocktake` | ID,Void |
| `Stock` | GET | `/stockTransferList` | Page,Limit,Status,Search |
| `Stock` | GET | `/stockTransfer` | TaskID |
| `Stock` | POST | `/stockTransfer` |  |
| `Stock` | PUT | `/stockTransfer` |  |
| `Stock` | DELETE | `/stockTransfer` | ID,Void |
| `Stock` | GET | `/stockTransfer/order` | TaskID |
| `Stock` | POST | `/stockTransfer/order` |  |
| `Supplier` | GET | `/supplier` | Page,Limit,ID,Name,ModifiedSince,IncludeDeprecated |
| `Supplier` | POST | `/supplier` |  |
| `Supplier` | PUT | `/supplier` |  |
| `Supplier` | GET | `/ref/supplier/deposits` | Page,Limit,SupplierID,ShowUsedDeposits |
| `Tax` | GET | `/ref/tax` | Page,Limit,ID,Name,IsActive,IsTaxForSale,IsTaxForPurchase,Account |
| `Tax` | POST | `/ref/tax` |  |
| `Tax` | PUT | `/ref/tax` |  |
| `Templates` | GET | `/ref/templates` | Page,Limit,Type,Name |
| `Transactions` | GET | `/transactions` | Page,Limit,FromDate,ToDate,Account |
| `Unit of Measure` | GET | `/ref/unit` | Page,Limit,Name |
| `Unit of Measure` | POST | `/ref/unit` |  |
| `Unit of Measure` | PUT | `/ref/unit` |  |
| `Unit of Measure` | DELETE | `/ref/unit` | ID |
| `Webhooks` | GET | `/webhooks` |  |
| `Webhooks` | POST | `/webhooks` |  |
| `Webhooks` | PUT | `/webhooks` |  |
| `Webhooks` | DELETE | `/webhooks` | ID |
| `CRM` | GET | `/crm/lead` | Page,Limit,ID,Name,ModifiedSince |
| `CRM` | POST | `/crm/lead` |  |
| `CRM` | PUT | `/crm/lead` |  |
| `CRM` | GET | `/crm/opportunity` | Page,Limit,ID,ModifiedSince |
| `CRM` | POST | `/crm/opportunity` |  |
| `CRM` | PUT | `/crm/opportunity` |  |
| `CRM` | GET | `/crm/task` | Page,Limit,ID,Name,StartDateFrom,StartDateTo,EndDateFrom,EndDateTo,CompleteDateFrom,CompleteDateTo,AssignedTo,Category |
| `CRM` | POST | `/crm/task` |  |
| `CRM` | PUT | `/crm/task` |  |
| `CRM` | GET | `/crm/task` | Page,Limit,ID,Name |
| `CRM` | POST | `/crm/taskcategory` |  |
| `CRM` | PUT | `/crm/taskcategory` |  |
| `CRM` | GET | `/crm/task` | Page,Limit,ID,Name |
| `CRM` | POST | `/crm/workflow` |  |
| `CRM` | PUT | `/crm/workflow` |  |
| `CRM` | POST | `/crm/workflowstart` | ID,Name,StartDate,EnityType,EntityID |
