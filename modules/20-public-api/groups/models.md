# Public API: shared models and value lists

#### Available Statuses for Production Run

| Value | Meaning |
|---|---|

#### Available Statuses for Production Run Operation

| Value | Meaning |
|---|---|

#### Available Resource Types

| Value | Meaning |
|---|---|

#### Available DayOfWeek values

| Value | Meaning |
|---|---|

#### Available Purchase Statuses

| Value | Meaning |
|---|---|
| `DRAFT` | No data is added to Purchase details. |
| `VOIDED` | Task has been voided |
| `ORDERING` | OrderStatus = DRAFT |
| `ORDERED` | OrderStatus = AUTHORISED |
| `RECEIVING` | OrderStatus = AUTHORISED, StockReceivedStatus = DRAFT |
| `RECEIVED` | StockReceivedStatus = AUTHORISED |
| `INVOICED` | InvoiceStatus = AUTHORISED |
| `CREDITED` | CreditNoteStatus = AUTHORISED |
| `RECEIVING / CREDITED` | Combined Stock Status = PARTIALLY RECEIVED, RestockReceivedStatus = AUTHORISED |
| `RECEIVED / CREDITED` | Combined Stock Status = FULLY RECEIVED, RestockReceivedStatus = AUTHORISED |
| `PARTIALLY INVOICED` | Combined Invoice Status = PARTIALLY INVOICED |
| `COMPLETED` | InvoiceStatus = AUTHORISED, RestockReceivedStatus = AUTHORISED |

#### Purchase

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `ID` | Guid |  |  |  |
| `SupplierID` | Guid |  |  |  |
| `Supplier` | String | 256 |  |  |
| `Contact` | String | 256 |  |  |
| `Phone` | String | 50 |  |  |
| `InventoryAccount` | String | 50 |  |  |
| `BlindReceipt` | Boolean |  |  |  |
| `Approach` | String | 10 |  |  |
| `BillingAddress` | Address Model |  |  |  |
| `ShippingAddress` | Shipping Address Model |  |  |  |
| `BaseCurrency` | String | 3 |  |  |
| `SupplierCurrency` | String | 3 |  |  |
| `TaxRule` | String | 50 |  |  |
| `TaxCalculation` | String |  |  |  |
| `Terms` | String | 256 |  |  |
| `RequiredBy` | DateTime |  |  |  |
| `Location` | String | 256 |  |  |
| `Note` | String | 1024 |  |  |
| `OrderNumber` | String | 256 |  |  |
| `OrderDate` | DateTime |  |  |  |
| `CombinedReceivingStatus` | String | 20 |  | `FULLY RECEIVED`, `PARTIALLY RECEIVED`, `NOT AVAILABLE`, `NOT RECEIVED`, `VOIDED` |
| `CombinedInvoiceStatus` | String | 20 |  | `INVOICED`, `INVOICED / CREDITED`, `NOT AVAILABLE`, `NOT INVOICED`, `PARTIALLY INVOICED`, `PARTIALLY INVOICED / CREDITED` |
| `CombinedPaymentStatus` | String | 20 |  | `PREPAID`, `PARTIALLY PAID`, `UNPAID`, `PAID`, `OVERPAID / CREDITED`, `VOIDED` |
| `Type` | String | 20 |  | `Simple Purchase`, `Advanced Purchase`, `Service Purchase` |
| `IsServiceOnly` | Boolean |  |  |  |
| `Status` | String | 20 |  |  |
| `RelatedDropShipSaleTask` | Guid |  |  |  |
| `CurrencyRate` | Decimal |  |  |  |
| `LastUpdatedDate` | DateTime |  |  |  |
| `Order` | Purchase Order Model |  |  |  |
| `StockReceived` | [] Advanced Purchase Stock Model |  |  |  |
| `PutAway` | [] Advanced Purchase Put Away Model |  |  |  |
| `Invoice` | [] Advanced Purchase Invoice Model |  |  |  |
| `CreditNote` | [] Advanced Purchase Credit Note Model |  |  |  |
| `ManualJournals` | [] Advanced Purchase Manual Journal Model |  |  |  |
| `AdditionalAttributes` | Additional Attribute Model |  |  |  |
| `Attachments` | [] Attachment Line Model |  |  |  |
| `InventoryMovements` | Inventory Movement Line Model |  |  |  |

#### Purchase Stock Received

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `PurchaseID` | Guid |  | Yes |  |
| `TaskID` | Guid |  | No |  |
| `Status` | string |  | Yes | `NOT AVAILABLE`, `DRAFT`, `AUTHORISED`, `VOIDED`, `DRAFT`, `AUTHORISED` |
| `Lines` | [] Advanced Purchase Stock Line Model |  | Yes |  |

#### Purchase Put Away

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `PurchaseID` | Guid |  | Yes |  |
| `TaskID` | Guid |  | No |  |
| `Status` | string |  | Yes | `NOT AVAILABLE`, `DRAFT`, `AUTHORISED`, `VOIDED`, `DRAFT`, `AUTHORISED`, `AUTHORISED` |
| `Lines` | [] Advanced Purchase Put Away Line Model |  | Yes |  |

#### Purchase Credit Note

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `PurchaseID` | Guid |  | Yes |  |
| `CreditNotes` | [] Advanced Purchase Credit Note Model |  | Yes |  |

#### Purchase Payments

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `TaskID` | Guid |  | Yes |  |
| `ID` | GUID |  | Yes* |  |
| `Type` | String |  | Yes | `PREPAYMENT`, `PAYMENT`, `REFUND` |
| `Reference` | String |  |  |  |
| `Amount` | Decimal with up to 2 decimal places |  | Yes |  |
| `DatePaid` | DateTime |  | Yes |  |
| `Account` | String |  | Yes |  |
| `CurrencyRate` | Decimal with up to 4 decimal places |  | Yes |  |
| `DateCreated` | DateTime |  |  |  |
| `DepositID` | GUID |  | No |  |

#### Product Deal

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `ID` | Guid |  | Yes |  |
| `Name` | String |  | Yes |  |
| `DateFrom` | Date |  |  |  |
| `DateTo` | Date |  |  |  |
| `IsActive` | Bool |  | Yes |  |
| `AllowCoupons` | Bool |  | Yes |  |
| `SingleCouponCodeUsage` | Bool |  | Yes |  |
| `CustomersGroup` | String |  |  |  |
| `CouponCodes` | String |  |  |  |
| `DealCustomers` | [] Customer Model |  |  |  |
| `DealCustomerTags` | [] Customer Tag Model |  |  |  |
| `DealDiscounts` | [] Deal Discount Model |  |  |  |

#### Available Sale Statuses

| Value | Meaning |
|---|---|
| `DRAFT` | No data is added to sale details. Quote and order are empty and not authorised. This status is not used for sales created via the POST API. |
| `VOIDED` | Task has been voided |
| `ESTIMATING` | QuoteStatus = DRAFT, OrderStatus = NOT AVAILABLE |
| `ESTIMATED` | QuoteStatus = AUTHORISED or Skip Quote=true, OrderStatus = NOT AVAILABLE |
| `ORDERING` | OrderStatus = DRAFT |
| `ORDERED` | OrderStatus = AUTHORISED, all products in sale order are in stock, no backordering. PickStatus = NOT AVAILABLE |
| `BACKORDERED` | OrderStatus = AUTHORISED, at least one product in sale order has been backordered. PickStatus = NOT AVAILABLE |
| `PICKING` | PickStatus = DRAFT, only applicable to simple sale |
| `PICKED` | PickStatus = AUTHORISED, PackStatus = NOT AVAILABLE, only applicable to simple sale |
| `PACKING` | PackStatus = DRAFT, only applicable to simple sale |
| `PACKED` | PackStatus = AUTHORISED, ShipStatus = NOT AVAILABLE, only applicable to simple sale |
| `SHIPPING` | ShipStatus = DRAFT, only applicable to simple sale |
| `INVOICING` | OrderStatus=AUTHORISED, InvoiceStatus=DRAFT, only applicable to simple sale |
| `INVOICED` | InvoiceStatus = AUTHORISED or InvoiceStatus = PAID, CreditNoteStatus <> AUTHORISED, TotalInvoice – TotalPaid <> 0, only applicable to simple sale |
| `CREDITED` | CreditNoteStatus = AUTHORISED, TotalInvoice – TotalPaid <> 0, only applicable to simple sale |
| `COMPLETED` | InvoiceStatus = PAID, ShipStatus=AUTHORISED, TotalInvoice – TotalPaid = 0 |

#### Available Quote Statuses

| Value | Meaning |
|---|---|
| `NOT AVAILABLE` | Not ready for processing. |
| `DRAFT` | Contains some lines, ready for processing |
| `AUTHORISED` | AUTHORISED |
| `VOIDED` | VOIDED |

#### Available Order Statuses

| Value | Meaning |
|---|---|
| `NOT AVAILABLE` | Not ready for processing. |
| `DRAFT` | Contains some lines, ready for processing |
| `AUTHORISED` | AUTHORISED |
| `VOIDED` | VOIDED |
| `AUTH_NO_ALLOC` | AUTORISED, without stock allocation |
| `FULFILLED` | The order is FULFILLED, and no further fulfillments are required |
| `CLOSED` | The Invoice and Shipment stages are completed |

#### Available Invoice Statuses

| Value | Meaning |
|---|---|
| `NOT AVAILABLE` | Not ready for processing. |
| `DRAFT` | Contains some lines, ready for processing |
| `AUTHORISED` | AUTHORISED |
| `VOIDED` | VOIDED |
| `PAID` | Fully Paid |

#### Sale Invoice Partial Model

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `TaskID` | GUID |  | Yes |  |
| `CombineAdditionalCharges` | Boolean |  | Yes |  |
| `InvoiceNumber` | string |  |  |  |
| `Memo` | String | 1024 |  |  |
| `Status` | String |  | Yes | `POST`, `DRAFT`, `AUTHORISED` |
| `InvoiceDate` | DateTime |  | Yes |  |
| `InvoiceDueDate` | DateTime |  | Yes |  |
| `CurrencyConversionRate` | Decimal with up to 4 decimal places |  |  |  |
| `BillingAddressLine1` | String | 256 |  |  |
| `BillingAddressLine2` | String | 256 |  |  |
| `LinkedFulfillmentNumber` | String |  |  |  |
| `Lines` | [] Sale Invoice Line Model |  |  |  |
| `AdditionalCharges` | [] Sale Invoice Additional Charge Model |  |  |  |

#### Sale Credit Note Invoice Partial Model

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `TaskID` | GUID |  | Yes |  |
| `CombineAdditionalCharges` | Boolean |  | Yes |  |
| `Memo` | String | 1024 |  |  |
| `Status` | String |  | Yes | `NOT AVAILABLE`, `DRAFT`, `AUTHORISED`, `VOIDED`, `POST`, `DRAFT`, `AUTHORISED` |
| `CreditNoteDate` | DateTime |  | Yes |  |
| `CreditNoteNumber` | string |  |  |  |
| `CreditNoteConversionRate` | Decimal with up to 4 decimal places |  |  |  |
| `Lines` | [] Sale Invoice Line Model |  |  |  |
| `AdditionalCharges` | [] Sale Invoice Additional Charge Model |  |  |  |
| `Restock` | [] Sale Fulfilment Pick Pack Line Model |  |  |  |

#### Available values for Webhook Type

| Value | Meaning |
|---|---|
| `Sale/Created` |  |
| `Sale/QuoteAuthorised` |  |
| `Sale/OrderAuthorised` |  |
| `Sale/Voided` |  |
| `Sale/Backordered` |  |
| `Sale/ShipmentAuthorised` |  |
| `Sale/InvoiceAuthorised` |  |
| `Sale/PickAuthorised` |  |
| `Sale/PackAuthorised` |  |
| `Sale/CreditNoteAuthorised` |  |
| `Sale/Undo` |  |
| `Sale/PartialPaymentReceived` |  |
| `Sale/FullPaymentReceived` |  |
| `Sale/AttachmentAdded` |  |
| `Sale/AdditionalAttributesChanged` |  |
| `Sale/ShipmentTrackingNumberChanged` |  |
| `Purchase/OrderAuthorised` |  |
| `Purchase/InvoiceAuthorised` |  |
| `Purchase/StockReceivedAuthorised` |  |
| `Purchase/CreditNoteAuthorised` |  |
| `Purchase/Updated` |  |
| `Customer/Updated` |  |
| `Supplier/Updated` |  |
| `Product/Updated` |  |
| `Stock/AvailableStockLevelChanged` |  |
| `Lead/Updated` |  |
| `Lead/Converted` |  |
| `Opportunity/Authorized` |  |
| `Opportunity/AttachmentAdded` |  |
| `Opportunity/Voided` |  |
| `Opportunity/Converted` |  |
| `Task/Overdue` |  |

