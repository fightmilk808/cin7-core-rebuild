# Public API: Sale

From Cin7's API Blueprint: field tables (name, type, length, required, allowed values), each operation's query parameters, and request and response bodies as type outlines (`guid`, `string`, `number`, `boolean`, `date`, `null`; `[ … ]` = array of). Base `/ExternalApi/v2`; headers in [docs/PUBLIC-API.md](../../../docs/PUBLIC-API.md).

**Resources:** `/saleList` · `/saleCreditNoteList` · `/sale` · `/sale/quote` · `/sale/order` · `/sale/fulfilment` · `/sale/fulfilment/pick` · `/sale/fulfilment/pack` · `/sale/fulfilment/ship` · `/sale/invoice` · `/sale/creditnote` · `/sale/payment` · `/sale/manualJournal` · `/sale/attachment`

## Fields

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

#### Sale List

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `SaleID` | Guid |  | Yes |  |
| `OrderNumber` | String | 256 | Yes |  |
| `Status` | String |  | Yes |  |
| `OrderDate` | Date |  | Yes |  |
| `InvoiceDate` | Date |  |  |  |
| `Customer` | Date | 256 | Yes |  |
| `CustomerID` | Guid |  |  |  |
| `InvoiceNumber` | String | 256 |  |  |
| `CustomerReference` | String | 256 |  |  |
| `InvoiceAmount` | Decimal |  | Yes |  |
| `PaidAmount` | Decimal |  | Yes |  |
| `SaleInvoicesTotalAmount` | Decimal |  |  |  |
| `InvoiceDueDate` | Date |  |  |  |
| `ShipBy` | Date |  |  |  |
| `BaseCurrency` | String | 3 | Yes |  |
| `CustomerCurrency` | String | 3 | Yes |  |
| `CreditNoteNumber` | String | 256 |  |  |
| `Updated` | DateTime |  | Yes |  |
| `QuoteStatus` | String | 20 | Yes |  |
| `OrderStatus` | String | 20 | Yes |  |
| `CombinedPickingStatus` | String | 20 | Yes | `VOIDED`, `NOT AVAILABLE`, `PICKED`, `PICKING`, `NOT PICKED`, `PARTIALLY PICKED` |
| `CombinedPackingStatus` | String | 20 | Yes | `VOIDED`, `NOT AVAILABLE`, `PACKED`, `PACKING`, `NOT PACKED`, `PARTIALLY PACKED` |
| `CombinedShippingStatus` | String | 20 | Yes | `VOIDED`, `NOT AVAILABLE`, `SHIPPED`, `SHIPPING`, `NOT SHIPPED`, `PARTIALLY SHIPPED` |
| `FulFilmentStatus` | String | 20 | Yes | `FULFILLED`, `PARTIALLY FULFILLED`, `NOT AVAILABLE`, `NOT FULFILLED`, `VOIDED` |
| `CombinedInvoiceStatus` | String | 20 | Yes | `VOIDED`, `DRAFT`, `AUTHORISED`, `NOT AVAILABLE`, `PAID` |
| `CombinedPaymentTotal` | Decimal |  |  |  |
| `CreditNoteStatus` | String | 20 | Yes | `VOIDED`, `DRAFT`, `AUTHORISED`, `NOT AVAILABLE` |
| `CombinedPaymentStatus` | String | 20 | Yes | `NOT REFUNDED`, `PREPAID`, `PARTIALLY PAID`, `UNPAID`, `PAID`, `VOIDED` |
| `Type` | String | 50 | Yes | `Simple Sale`, `Advanced Sale`, `Service Sale` |
| `CombinedTrackingNumbers` | String | 256 | Yes |  |
| `SourceChannel` | String (read-only) | 32 |  |  |
| `ExternalID` | String | 256 |  |  |
| `OrderLocationID` | Guid |  |  |  |

#### Sale Credit Note List

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `SaleID` | Guid |  | Yes |  |
| `OrderNumber` | String | 256 | Yes |  |
| `Status` | String |  | Yes |  |
| `OrderDate` | Date |  | Yes |  |
| `InvoiceDate` | Date |  |  |  |
| `Customer` | Date | 256 | Yes |  |
| `CustomerID` | Guid |  |  |  |
| `InvoiceNumber` | String | 256 |  |  |
| `CustomerReference` | String | 256 |  |  |
| `InvoiceAmount` | Decimal |  | Yes |  |
| `PaidAmount` | Decimal |  | Yes |  |
| `InvoiceDueDate` | Date |  |  |  |
| `ShipBy` | Date |  |  |  |
| `BaseCurrency` | String | 3 | Yes |  |
| `CustomerCurrency` | String | 3 | Yes |  |
| `CreditNoteNumber` | String | 256 |  |  |
| `Updated` | DateTime |  | Yes |  |
| `QuoteStatus` | String | 20 | Yes |  |
| `OrderStatus` | String | 20 | Yes |  |
| `CombinedPickingStatus` | String | 20 | Yes | `VOIDED`, `NOT AVAILABLE`, `PICKED`, `PICKING`, `NOT PICKED`, `PARTIALLY PICKED` |
| `CombinedPackingStatus` | String | 20 | Yes | `VOIDED`, `NOT AVAILABLE`, `PACKED`, `PACKING`, `NOT PACKED`, `PARTIALLY PACKED` |
| `CombinedShippingStatus` | String | 20 | Yes | `VOIDED`, `NOT AVAILABLE`, `SHIPPED`, `SHIPPING`, `NOT SHIPPED`, `PARTIALLY SHIPPED` |
| `FulFilmentStatus` | String | 20 | Yes | `FULFILLED`, `PARTIALLY FULFILLED`, `NOT AVAILABLE`, `NOT FULFILLED`, `VOIDED` |
| `CombinedInvoiceStatus` | String | 20 | Yes | `VOIDED`, `DRAFT`, `AUTHORISED`, `NOT AVAILABLE`, `PAID` |
| `CreditNoteStatus` | String | 20 | Yes | `VOIDED`, `DRAFT`, `AUTHORISED`, `NOT AVAILABLE` |
| `CombinedPaymentStatus` | String | 20 | Yes | `NOT REFUNDED`, `PREPAID`, `PARTIALLY PAID`, `UNPAID`, `PAID`, `VOIDED` |
| `Type` | String | 50 | Yes | `Simple Sale`, `Advanced Sale`, `Service Sale`, `Sale Credit Note`, `Credit Note` |
| `CombinedTrackingNumbers` | String | 256 | Yes |  |
| `SourceChannel` | String (read-only) | 32 |  |  |
| `ExternalID` | String | 256 |  |  |
| `OrderLocationID` | Guid |  |  |  |

#### Sale

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `ID` | Guid |  |  |  |
| `Customer` | String | 256 |  |  |
| `CustomerID` | Guid |  |  |  |
| `Contact` | String | 256 |  |  |
| `Phone` | String | 50 |  |  |
| `Email` | String | 256 |  |  |
| `DefaultAccount` | String | 50 |  |  |
| `SkipQuote` | Boolean |  |  |  |
| `BillingAddress` | Address Model |  |  |  |
| `ShippingAddress` | Shipping Address Model |  |  |  |
| `ShippingNotes` | String | 1024 |  |  |
| `BaseCurrency` | String | 3 |  |  |
| `CustomerCurrency` | String | 3 |  |  |
| `TaxRule` | String | 50 |  |  |
| `TaxCalculation` | String |  |  |  |
| `Terms` | String | 256 |  |  |
| `PriceTier` | String | 50 |  |  |
| `ShipBy` | Date |  |  |  |
| `Location` | String | 256 |  |  |
| `SaleOrderDate` | Date |  |  |  |
| `LastModifiedOn` | DateTime |  |  |  |
| `Note` | String | 1024 |  |  |
| `CustomerReference` | String | 256 |  |  |
| `COGSAmount` | Money |  |  |  |
| `Status` | String | 25 |  |  |
| `CombinedPickingStatus` | String | 20 | Yes | `VOIDED`, `NOT AVAILABLE`, `PICKED`, `PICKING`, `NOT PICKED`, `PARTIALLY PICKED` |
| `CombinedPackingStatus` | String | 20 | Yes | `VOIDED`, `NOT AVAILABLE`, `PACKED`, `PACKING`, `NOT PACKED`, `PARTIALLY PACKED` |
| `CombinedShippingStatus` | String | 20 | Yes | `VOIDED`, `NOT AVAILABLE`, `SHIPPED`, `SHIPPING`, `NOT SHIPPED`, `PARTIALLY SHIPPED` |
| `FulFilmentStatus` | String | 20 |  | `FULFILLED`, `PARTIALLY FULFILLED`, `NOT AVAILABLE`, `NOT FULFILLED`, `VOIDED` |
| `CombinedInvoiceStatus` | String | 20 |  | `VOIDED`, `DRAFT`, `AUTHORISED`, `NOT AVAILABLE`, `PAID` |
| `CombinedPaymentStatus` | String | 20 |  | `NOT REFUNDED`, `PREPAID`, `PARTIALLY PAID`, `UNPAID`, `PAID`, `VOIDED` |
| `CombinedTrackingNumbers` | String | 256 |  |  |
| `Carrier` | String | 256 | Name of C… |  |
| `CurrencyRate` | Decimal | Up to 5 d… |  |  |
| `SalesRepresentative` | String | 256 |  |  |
| `Type` | String | 50 |  |  |
| `SourceChannel` | String (read-only) | 32 |  |  |
| `ExternalID` | String | 256 |  |  |
| `ServiceOnly` | Boolean |  |  |  |
| `Quote` | Sale Quote Model |  |  |  |
| `Order` | Sale Order Model |  |  |  |
| `Fulfilments` | [] Sale Fulfilment Model |  |  |  |
| `Invoices` | [] Sale Invoice Model |  |  |  |
| `CreditNotes` | [] Sale Credit Note Model |  |  |  |
| `ManualJournals` | Sale Manual Journal Model |  |  |  |
| `AdditionalAttributes` | Additional Attribute Model |  |  |  |
| `Attachments` | [] Attachment Line Model |  |  |  |
| `InventoryMovements` | [] Inventory Movement Line Model |  |  |  |
| `Transactions` | [] Sale Transaction Line Model |  |  |  |

#### Sale Quote

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `SaleID` | Guid |  | Yes |  |
| `CombineAdditionalCharges` | Boolean |  | Yes |  |
| `Memo` | String | 1024 | Yes |  |
| `Status` | string |  | Yes | `DRAFT`, `AUTHORISED` |
| `Lines` | [] Sale Quote Line Model |  | Yes |  |
| `AdditionalCharges` | [] Sale Additional Charge Model |  |  |  |
| `TotalBeforeTax` | Decimal with up to 4 decimal places |  | Yes |  |
| `Tax` | Decimal with up to 4 decimal places |  | Yes |  |
| `Total` | Decimal with up to 4 decimal places |  | Yes |  |

#### Sale Order

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `SaleID` | Guid |  | Yes |  |
| `SaleOrderNumber` | String | 256 |  |  |
| `CombineAdditionalCharges` | Boolean |  | Yes |  |
| `Memo` | String | 1024 | Yes |  |
| `Status` | string |  | Yes | `DRAFT`, `AUTHORISED` |
| `Lines` | [] Sale Order Line Model |  | Yes |  |
| `AdditionalCharges` | [] Sale Additional Charge Model |  |  |  |
| `TotalBeforeTax` | Decimal with up to 4 decimal places |  | Yes |  |
| `Tax` | Decimal with up to 4 decimal places |  | Yes |  |
| `Total` | Decimal with up to 4 decimal places |  | Yes |  |

#### Sale Fulfilment

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `SaleID` | Guid |  | Yes |  |
| `Fulfilments` | [] Sale Fulfilment Model |  |  |  |

#### Sale Fulfilment Pick

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `TaskID` | Guid |  | Yes |  |
| `Status` | String |  | Yes | `NOT AVAILABLE`, `DRAFT`, `AUTHORISED`, `VOIDED`, `POST`, `DRAFT`, `AUTHORISED` |
| `Lines` | [] Sale Fulfilment Pick Pack Line Model |  |  |  |

#### Sale Fulfilment Pack

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `TaskID` | Guid |  | Yes |  |
| `Status` | String |  | Yes | `NOT AVAILABLE`, `DRAFT`, `AUTHORISED`, `VOIDED`, `POST`, `DRAFT`, `AUTHORISED` |
| `Lines` | [] Sale Fulfilment Pick Pack Line Model |  |  |  |

#### Sale Fulfilment Ship

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `TaskID` | Guid |  | Yes |  |
| `Status` | String |  | Yes | `NOT AVAILABLE`, `DRAFT`, `PARTIALLY AUTHORISED`, `AUTHORISED`, `VOIDED`, `POST`, `PUT`, `DRAFT`, `PARTIALLY AUTHORISED`, `AUTHORISED` |
| `RequireBy` | Date |  |  |  |
| `ShippingAddress` | Shipping Address Model |  |  |  |
| `ShippingNotes` | String | 1024 |  |  |
| `Lines` | [] Sale Fulfilment Ship Line Model |  |  |  |

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

#### Sale Attachments

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `SaleID` | Guid |  | Yes |  |
| `Lines` | [] Attachment Line Model |  |  |  |

#### POST Methods

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `SaleID` | Guid |  | Yes |  |
| `FileName` | String |  | Yes |  |
| `FileDownloadUrl` | String |  | No |  |
| `Content` | String |  | Yes* |  |

## Operations

### GET `/saleList`

| Parameter | Type | Required |
|---|---|---|
| `Page` | number |  |
| `Limit` | number |  |
| `Search` | string |  |
| `CreatedSince` | DateTime |  |
| `UpdatedSince` | DateTime |  |
| `UpdatedUntil` | DateTime |  |
| `ShipBy` | DateTime |  |
| `QuoteStatus` | string |  |
| `OrderStatus` | string |  |
| `CombinedPickStatus` | string |  |
| `CombinedPackStatus` | string |  |
| `CombinedShippingStatus` | string |  |
| `CombinedInvoiceStatus` | string |  |
| `CreditNoteStatus` | string |  |
| `ExternalID` | string |  |
| `Status` | string |  |
| `ReadyForShipping` | boolean |  |
| `OrderLocationID` | Guid |  |

Response 200:

```text
Total: number
Page: number
SaleList: [
  SaleID: guid
  OrderNumber: string
  Status: string
  OrderDate: date
  InvoiceDate: null
  Customer: string
  CustomerID: guid
  InvoiceNumber: null
  CustomerReference: string
  InvoiceAmount: number
  PaidAmount: number
  SaleInvoicesTotalAmount: number
  InvoiceDueDate: null
  ShipBy: null
  BaseCurrency: string
  CustomerCurrency: string
  CreditNoteNumber: null
  Updated: date
  QuoteStatus: string
  OrderStatus: string
  CombinedPickingStatus: string
  CombinedPaymentStatus: string
  CombinedTrackingNumbers: string
  CombinedPackingStatus: string
  CombinedShippingStatus: string
  CombinedInvoiceStatus: string
  CombinedPaymentTotal: number
  CreditNoteStatus: string
  FulFilmentStatus: string
  Type: string
  SourceChannel: string
  ExternalID: null
  OrderLocationID: guid
]
```

### GET `/saleCreditNoteList`

| Parameter | Type | Required |
|---|---|---|
| `Page` | number |  |
| `Limit` | number |  |
| `Search` | string |  |
| `CreatedSince` | DateTime |  |
| `UpdatedSince` | DateTime |  |
| `UpdatedUntil` | DateTime |  |
| `CreditNoteStatus` | string |  |
| `Status` | string |  |

Response 200:

```text
Total: number
Page: number
SaleList: [
  SaleID: guid
  OrderNumber: string
  Status: string
  OrderDate: date
  InvoiceDate: null
  Customer: string
  CustomerID: guid
  InvoiceNumber: null
  CustomerReference: string
  InvoiceAmount: number
  PaidAmount: number
  InvoiceDueDate: null
  ShipBy: null
  BaseCurrency: string
  CustomerCurrency: string
  CreditNoteNumber: null
  Updated: date
  QuoteStatus: string
  OrderStatus: string
  CombinedPickingStatus: string
  CombinedPaymentStatus: string
  CombinedTrackingNumbers: null
  CombinedPackingStatus: string
  CombinedShippingStatus: string
  CombinedInvoiceStatus: string
  CreditNoteStatus: string
  FulFilmentStatus: string
  Type: string
  SourceChannel: string
  ExternalID: string
  OrderLocationID: guid
  RestockStatus: string
]
```

### GET `/sale`

| Parameter | Type | Required |
|---|---|---|
| `ID` |  | yes |

Response 200:

```text
ID: guid
Customer: string
CustomerID: guid
Contact: string
Phone: string
Email: string
DefaultAccount: string
SkipQuote: boolean
BillingAddress: {
  DisplayAddressLine1: string
  DisplayAddressLine2: string
  Line1: string
  Line2: string
  City: string
  State: string
  Postcode: string
  Country: string
}
ShippingAddress: {
  DisplayAddressLine1: string
  DisplayAddressLine2: string
  Line1: string
  Line2: string
  City: string
  State: string
  Postcode: string
  Country: string
  Company: string
  Contact: string
  ShipToOther: boolean
}
ShippingNotes: string
BaseCurrency: string
CustomerCurrency: string
TaxRule: string
TaxCalculation: string
Terms: string
PriceTier: string
ShipBy: date
Location: string
SaleOrderDate: date
LastModifiedOn: date
Note: string
CustomerReference: string
COGSAmount: number
Status: string
CombinedPickingStatus: string
CombinedPackingStatus: string
CombinedShippingStatus: string
FulFilmentStatus: string
CombinedInvoiceStatus: string
CombinedPaymentStatus: string
CombinedTrackingNumbers: string
Carrier: string
CurrencyRate: number
SalesRepresentative: string
ServiceOnly: boolean
Type: string
SourceChannel: string
Quote: {
  Memo: string
  Status: string
  Prepayments: []
  Lines: [
    ProductID: guid
    SKU: string
    Name: string
    Quantity: number
    Price: number
    Discount: number
    Tax: number
    AverageCost: number
    TaxRule: string
    Comment: string
    Total: number
    ProductLength: number
    ProductWidth: number
    ProductHeight: number
    ProductWeight: number
    WeightUnits: string
    DimensionsUnits: string
    ProductCustomField1: null
    ProductCustomField2: null
    ProductCustomField3: null
    ProductCustomField4: null
    ProductCustomField5: null
    ProductCustomField6: null
    ProductCustomField7: null
    ProductCustomField8: null
    ProductCustomField9: null
    ProductCustomField10: null
  ]
  AdditionalCharges: [
    Description: string
    Price: number
    Quantity: number
    Discount: number
    Tax: number
    Total: number
    TaxRule: string
    Comment: string
  ]
  TotalBeforeTax: number
  Tax: number
  Total: number
}
Order: {
  SaleOrderNumber: string
  Memo: string
  Status: string
  Lines: [
    ProductID: guid
    SKU: string
    Name: string
    Quantity: number
    Price: number
    Discount: number
    Tax: number
    AverageCost: number
    TaxRule: string
    Comment: string
    DropShip: boolean
    Backorder: boolean
    BackorderQuantity: number
    Total: number
    ProductLength: number
    ProductWidth: number
    ProductHeight: number
    ProductWeight: number
    WeightUnits: string
    DimensionsUnits: string
    ProductCustomField1: null
    ProductCustomField2: null
    ProductCustomField3: null
    ProductCustomField4: null
    ProductCustomField5: null
    ProductCustomField6: null
    ProductCustomField7: null
    ProductCustomField8: null
    ProductCustomField9: null
    ProductCustomField10: null
  ]
  AdditionalCharges: [
    Description: string
    Price: number
    Quantity: number
    Discount: number
    Tax: number
    Total: number
    TaxRule: string
    Comment: string
  ]
  TotalBeforeTax: number
  Tax: number
  Total: number
}
Fulfilments: [
  TaskID: guid
  FulfillmentNumber: number
  LinkedInvoiceNumber: string
  FulFilmentStatus: string
  Pick: {
    Status: string
    Lines: [
      ProductID: guid
      SKU: string
      Name: string
      Location: string
      LocationID: guid
      Quantity: number
      BatchSN: string
      ExpiryDate: date
      ProductLength: number
      ProductWidth: number
      ProductHeight: number
      ProductWeight: number
      WeightUnits: string
      DimensionsUnits: string
      ProductCustomField1: null
      ProductCustomField2: null
      ProductCustomField3: null
      ProductCustomField4: null
      ProductCustomField5: null
      ProductCustomField6: null
      ProductCustomField7: null
      ProductCustomField8: null
      ProductCustomField9: null
      ProductCustomField10: null
    ]
  }
  Pack: {
    Status: string
    Lines: [
      ProductID: guid
      SKU: string
      Name: string
      Location: string
      LocationID: guid
      Box: string
      Quantity: number
      BatchSN: string
      ExpiryDate: date
      ProductLength: number
      ProductWidth: number
      ProductHeight: number
      ProductWeight: number
      WeightUnits: string
      DimensionsUnits: string
      ProductCustomField1: null
      ProductCustomField2: null
      ProductCustomField3: null
      ProductCustomField4: null
      ProductCustomField5: null
      ProductCustomField6: null
      ProductCustomField7: null
      ProductCustomField8: null
      ProductCustomField9: null
      ProductCustomField10: null
    ]
  }
  Ship: {
    Status: string
    RequireBy: null
    ShippingAddress: {
      DisplayAddressLine1: string
      DisplayAddressLine2: string
      Line1: string
      Line2: string
      City: string
      State: string
      Postcode: string
      Country: string
      Company: string
      Contact: string
      ShipToOther: boolean
    }
    ShippingNotes: string
    Lines: [
      ID: guid
      ShipmentDate: date
      Carrier: string
      Boxes: string
      TrackingNumber: string
      TrackingURL: string
      IsShipped: boolean
    ]
  }
]
Invoices: [
  TaskID: guid
  InvoiceNumber: string
  Memo: string
  Status: string
  InvoiceDate: date
  InvoiceDueDate: date
  CurrencyConversionRate: number
  BillingAddressLine1: string
  BillingAddressLine2: string
  LinkedFulfillmentNumber: string
  Lines: [
    ProductID: guid
    SKU: string
    Name: string
    Quantity: number
    Price: number
    Discount: number
    Tax: number
    Total: number
    AverageCost: number
    TaxRule: string
    Account: string
    Comment: string
    ProductLength: number
    ProductWidth: number
    ProductHeight: number
    ProductWeight: number
    WeightUnits: string
    DimensionsUnits: string
    ProductCustomField1: null
    ProductCustomField2: null
    ProductCustomField3: null
    ProductCustomField4: null
    ProductCustomField5: null
    ProductCustomField6: null
    ProductCustomField7: null
    ProductCustomField8: null
    ProductCustomField9: null
    ProductCustomField10: null
  ]
  AdditionalCharges: [
    Description: string
    Quantity: number
    Price: number
    Discount: number
    Tax: number
    Total: number
    TaxRule: string
    Account: string
    Comment: string
  ]
  Payments: []
  TotalBeforeTax: number
  Tax: number
  Total: number
  Paid: number
]
CreditNotes: [
  TaskID: guid
  CreditNoteInvoiceNumber: string
  Memo: string
  Status: string
  CreditNoteDate: date
  CreditNoteNumber: string
  CreditNoteConversionRate: number
  Lines: [
    ProductID: guid
    SKU: string
    Name: string
    Quantity: number
    Price: number
    Discount: number
    Tax: number
    Total: number
    AverageCost: number
    TaxRule: string
    Account: string
    Comment: string
    ProductLength: number
    ProductWidth: number
    ProductHeight: number
    ProductWeight: number
    WeightUnits: string
    DimensionsUnits: string
    ProductCustomField1: null
    ProductCustomField2: null
    ProductCustomField3: null
    ProductCustomField4: null
    ProductCustomField5: null
    ProductCustomField6: null
    ProductCustomField7: null
    ProductCustomField8: null
    ProductCustomField9: null
    ProductCustomField10: null
  ]
  AdditionalCharges: [
    Description: string
    Quantity: number
    Price: number
    Discount: number
    Tax: number
    Total: number
    TaxRule: string
    Account: string
    Comment: string
  ]
  Refunds: [
    ID: guid
    Reference: string
    Amount: number
    DatePaid: date
    Account: string
    CurrencyRate: number
    DateCreated: date
  ]
  Restock: [
    ProductID: guid
    SKU: string
    Name: string
    Location: string
    LocationID: guid
    Quantity: number
    BatchSN: string
    ExpiryDate: date
  ]
  TotalBeforeTax: number
  Tax: number
  Total: number
]
ManualJournals: {
  Status: string
  Lines: []
}
ExternalID: null
AdditionalAttributes: {
  AdditionalAttribute1: string
  AdditionalAttribute2: string
  AdditionalAttribute3: string
  AdditionalAttribute4: string
  AdditionalAttribute5: string
  AdditionalAttribute6: string
  AdditionalAttribute7: string
  AdditionalAttribute8: string
  AdditionalAttribute9: string
  AdditionalAttribute10: string
}
Attachments: [
  ID: guid
  ContentType: string
  FileName: string
  DownloadUrl: string
]
InventoryMovements: [
  TaskID: guid
  ProductID: guid
  Date: date
  COGS: number
  ProductLength: number
  ProductWidth: number
  ProductHeight: number
  ProductWeight: number
  WeightUnits: string
  DimensionsUnits: string
  ProductCustomField1: null
  ProductCustomField2: null
  ProductCustomField3: null
  ProductCustomField4: null
  ProductCustomField5: null
  ProductCustomField6: null
  ProductCustomField7: null
  ProductCustomField8: null
  ProductCustomField9: null
  ProductCustomField10: null
]
Transactions: [
  TaskID: guid
  TransactionID: guid
  Debit: string
  Credit: string
  Description: string
  Amount: number
  EffectiveDate: date
]
```

### POST `/`

Request body:

```text
CustomerID: guid
Customer: string
Phone: string
Email: string
Contact: string
DefaultAccount: string
BillingAddress: {
  Line1: string
  Line2: string
  City: string
  State: string
  Postcode: string
  Country: string
}
ShippingAddress: {
  Line1: string
  Line2: string
  City: string
  State: string
  Postcode: string
  Country: string
  Company: string
  Contact: string
  ShipToOther: boolean
}
ShippingNotes: string
TaxRule: string
TaxInclusive: string
Terms: string
PriceTier: string
Location: string
Note: string
CustomerReference: string
AutoPickPackShipMode: string
SalesRepresentative: string
Carrier: string
CurrencyRate: string
AdditionalAttributes: {
  AdditionalAttribute1: string
  AdditionalAttribute2: string
  AdditionalAttribute3: string
  AdditionalAttribute4: string
  AdditionalAttribute5: string
  AdditionalAttribute6: string
  AdditionalAttribute7: string
  AdditionalAttribute8: string
  AdditionalAttribute9: string
  AdditionalAttribute10: string
}
ShipBy: date
SaleOrderDate: date
SkipQuote: string
```

Response 200:

```text
ID: guid
Customer: string
CustomerID: guid
Contact: string
Phone: string
Email: string
DefaultAccount: string
SkipQuote: boolean
BillingAddress: {
  DisplayAddressLine1: string
  DisplayAddressLine2: string
  Line1: string
  Line2: string
  City: string
  State: string
  Postcode: string
  Country: string
}
ShippingAddress: {
  DisplayAddressLine1: string
  DisplayAddressLine2: string
  Line1: string
  Line2: string
  City: string
  State: string
  Postcode: string
  Country: string
  Company: string
  Contact: string
  ShipToOther: boolean
}
ShippingNotes: string
BaseCurrency: string
CustomerCurrency: string
TaxRule: string
TaxCalculation: string
Terms: string
PriceTier: string
ShipBy: date
Location: string
SaleOrderDate: date
LastModifiedOn: date
Note: string
CustomerReference: string
COGSAmount: number
Status: string
CombinedPickingStatus: string
CombinedPackingStatus: string
CombinedShippingStatus: string
FulFilmentStatus: string
CombinedInvoiceStatus: string
CombinedPaymentStatus: string
CombinedTrackingNumbers: string
Carrier: string
CurrencyRate: number
SalesRepresentative: string
ServiceOnly: boolean
Type: string
SourceChannel: string
Quote: {
  Memo: string
  Status: string
  Prepayments: []
  Lines: [
    ProductID: guid
    SKU: string
    Name: string
    Quantity: number
    Price: number
    Discount: number
    Tax: number
    AverageCost: number
    TaxRule: string
    Comment: string
    Total: number
    ProductLength: number
    ProductWidth: number
    ProductHeight: number
    ProductWeight: number
    WeightUnits: string
    DimensionsUnits: string
    ProductCustomField1: null
    ProductCustomField2: null
    ProductCustomField3: null
    ProductCustomField4: null
    ProductCustomField5: null
    ProductCustomField6: null
    ProductCustomField7: null
    ProductCustomField8: null
    ProductCustomField9: null
    ProductCustomField10: null
  ]
  AdditionalCharges: [
    Description: string
    Price: number
    Quantity: number
    Discount: number
    Tax: number
    Total: number
    TaxRule: string
    Comment: string
  ]
  TotalBeforeTax: number
  Tax: number
  Total: number
}
Order: {
  SaleOrderNumber: string
  Memo: string
  Status: string
  Lines: [
    ProductID: guid
    SKU: string
    Name: string
    Quantity: number
    Price: number
    Discount: number
    Tax: number
    AverageCost: number
    TaxRule: string
    Comment: string
    DropShip: boolean
    Backorder: boolean
    BackorderQuantity: number
    Total: number
    ProductLength: number
    ProductWidth: number
    ProductHeight: number
    ProductWeight: number
    WeightUnits: string
    DimensionsUnits: string
    ProductCustomField1: null
    ProductCustomField2: null
    ProductCustomField3: null
    ProductCustomField4: null
    ProductCustomField5: null
    ProductCustomField6: null
    ProductCustomField7: null
    ProductCustomField8: null
    ProductCustomField9: null
    ProductCustomField10: null
  ]
  AdditionalCharges: [
    Description: string
    Price: number
    Quantity: number
    Discount: number
    Tax: number
    Total: number
    TaxRule: string
    Comment: string
  ]
  TotalBeforeTax: number
  Tax: number
  Total: number
}
Fulfilments: [
  TaskID: guid
  FulfillmentNumber: number
  LinkedInvoiceNumber: string
  FulFilmentStatus: string
  Pick: {
    Status: string
    Lines: [
      ProductID: guid
      SKU: string
      Name: string
      Location: string
      LocationID: guid
      Quantity: number
      BatchSN: string
      ExpiryDate: date
      ProductLength: number
      ProductWidth: number
      ProductHeight: number
      ProductWeight: number
      WeightUnits: string
      DimensionsUnits: string
      ProductCustomField1: null
      ProductCustomField2: null
      ProductCustomField3: null
      ProductCustomField4: null
      ProductCustomField5: null
      ProductCustomField6: null
      ProductCustomField7: null
      ProductCustomField8: null
      ProductCustomField9: null
      ProductCustomField10: null
    ]
  }
  Pack: {
    Status: string
    Lines: [
      ProductID: guid
      SKU: string
      Name: string
      Location: string
      LocationID: guid
      Box: string
      Quantity: number
      BatchSN: string
      ExpiryDate: date
      ProductLength: number
      ProductWidth: number
      ProductHeight: number
      ProductWeight: number
      WeightUnits: string
      DimensionsUnits: string
      ProductCustomField1: null
      ProductCustomField2: null
      ProductCustomField3: null
      ProductCustomField4: null
      ProductCustomField5: null
      ProductCustomField6: null
      ProductCustomField7: null
      ProductCustomField8: null
      ProductCustomField9: null
      ProductCustomField10: null
    ]
  }
  Ship: {
    Status: string
    RequireBy: null
    ShippingAddress: {
      DisplayAddressLine1: string
      DisplayAddressLine2: string
      Line1: string
      Line2: string
      City: string
      State: string
      Postcode: string
      Country: string
      Company: string
      Contact: string
      ShipToOther: boolean
    }
    ShippingNotes: string
    Lines: [
      ID: guid
      ShipmentDate: date
      Carrier: string
      Boxes: string
      TrackingNumber: string
      TrackingURL: string
      IsShipped: boolean
    ]
  }
]
Invoices: [
  TaskID: guid
  InvoiceNumber: string
  Memo: string
  Status: string
  InvoiceDate: date
  InvoiceDueDate: date
  CurrencyConversionRate: number
  BillingAddressLine1: string
  BillingAddressLine2: string
  LinkedFulfillmentNumber: string
  Lines: [
    ProductID: guid
    SKU: string
    Name: string
    Quantity: number
    Price: number
    Discount: number
    Tax: number
    Total: number
    AverageCost: number
    TaxRule: string
    Account: string
    Comment: string
    ProductLength: number
    ProductWidth: number
    ProductHeight: number
    ProductWeight: number
    WeightUnits: string
    DimensionsUnits: string
    ProductCustomField1: null
    ProductCustomField2: null
    ProductCustomField3: null
    ProductCustomField4: null
    ProductCustomField5: null
    ProductCustomField6: null
    ProductCustomField7: null
    ProductCustomField8: null
    ProductCustomField9: null
    ProductCustomField10: null
  ]
  AdditionalCharges: [
    Description: string
    Quantity: number
    Price: number
    Discount: number
    Tax: number
    Total: number
    TaxRule: string
    Account: string
    Comment: string
  ]
  Payments: []
  TotalBeforeTax: number
  Tax: number
  Total: number
  Paid: number
]
CreditNotes: [
  TaskID: guid
  CreditNoteInvoiceNumber: string
  Memo: string
  Status: string
  CreditNoteDate: date
  CreditNoteNumber: string
  CreditNoteConversionRate: number
  Lines: [
    ProductID: guid
    SKU: string
    Name: string
    Quantity: number
    Price: number
    Discount: number
    Tax: number
    Total: number
    AverageCost: number
    TaxRule: string
    Account: string
    Comment: string
    ProductLength: number
    ProductWidth: number
    ProductHeight: number
    ProductWeight: number
    WeightUnits: string
    DimensionsUnits: string
    ProductCustomField1: null
    ProductCustomField2: null
    ProductCustomField3: null
    ProductCustomField4: null
    ProductCustomField5: null
    ProductCustomField6: null
    ProductCustomField7: null
    ProductCustomField8: null
    ProductCustomField9: null
    ProductCustomField10: null
  ]
  AdditionalCharges: [
    Description: string
    Quantity: number
    Price: number
    Discount: number
    Tax: number
    Total: number
    TaxRule: string
    Account: string
    Comment: string
  ]
  Refunds: [
    ID: guid
    Reference: string
    Amount: number
    DatePaid: date
    Account: string
    CurrencyRate: number
    DateCreated: date
  ]
  Restock: [
    ProductID: guid
    SKU: string
    Name: string
    Location: string
    LocationID: guid
    Quantity: number
    BatchSN: string
    ExpiryDate: date
  ]
  TotalBeforeTax: number
  Tax: number
  Total: number
]
ManualJournals: {
  Status: string
  Lines: []
}
ExternalID: null
AdditionalAttributes: {
  AdditionalAttribute1: string
  AdditionalAttribute2: string
  AdditionalAttribute3: string
  AdditionalAttribute4: string
  AdditionalAttribute5: string
  AdditionalAttribute6: string
  AdditionalAttribute7: string
  AdditionalAttribute8: string
  AdditionalAttribute9: string
  AdditionalAttribute10: string
}
Attachments: [
  ID: guid
  ContentType: string
  FileName: string
  DownloadUrl: string
]
InventoryMovements: [
  TaskID: guid
  ProductID: guid
  Date: date
  COGS: number
  ProductLength: number
  ProductWidth: number
  ProductHeight: number
  ProductWeight: number
  WeightUnits: string
  DimensionsUnits: string
  ProductCustomField1: null
  ProductCustomField2: null
  ProductCustomField3: null
  ProductCustomField4: null
  ProductCustomField5: null
  ProductCustomField6: null
  ProductCustomField7: null
  ProductCustomField8: null
  ProductCustomField9: null
  ProductCustomField10: null
]
```

### PUT `/`

Request body:

```text
ID: guid
Customer: string
CustomerID: guid
Phone: string
Email: string
Contact: string
DefaultAccount: string
BillingAddress: {
  Line1: string
  Line2: string
  City: string
  State: string
  Postcode: string
  Country: string
}
ShippingAddress: {
  Line1: string
  Line2: string
  City: string
  State: string
  Postcode: string
  Country: string
  Company: string
  Contact: string
  ShipToOther: boolean
}
ShippingNotes: string
TaxRule: string
TaxInclusive: string
Terms: string
PriceTier: string
Location: string
Note: string
CustomerReference: string
SalesRepresentative: string
Carrier: string
CurrencyRate: string
AdditionalAttributes: {
  AdditionalAttribute1: string
  AdditionalAttribute2: string
  AdditionalAttribute3: string
  AdditionalAttribute4: string
  AdditionalAttribute5: string
  AdditionalAttribute6: string
  AdditionalAttribute7: string
  AdditionalAttribute8: string
  AdditionalAttribute9: string
  AdditionalAttribute10: string
}
ShipBy: date
SaleOrderDate: date
SkipQuote: string
```

Response 200:

```text
ID: guid
Customer: string
CustomerID: guid
Contact: string
Phone: string
Email: string
DefaultAccount: string
SkipQuote: boolean
BillingAddress: {
  DisplayAddressLine1: string
  DisplayAddressLine2: string
  Line1: string
  Line2: string
  City: string
  State: string
  Postcode: string
  Country: null
}
ShippingAddress: {
  DisplayAddressLine1: string
  DisplayAddressLine2: string
  Line1: string
  Line2: string
  City: string
  State: string
  Postcode: string
  Country: string
  Company: string
  Contact: string
  ShipToOther: boolean
}
ShippingNotes: string
BaseCurrency: string
CustomerCurrency: string
TaxRule: string
TaxCalculation: string
Terms: string
PriceTier: string
ShipBy: date
Location: string
SaleOrderDate: date
LastModifiedOn: date
Note: string
CustomerReference: string
COGSAmount: number
Status: string
CombinedPickingStatus: string
CombinedPackingStatus: string
CombinedShippingStatus: string
FulFilmentStatus: string
CombinedInvoiceStatus: string
CombinedPaymentStatus: string
CombinedTrackingNumbers: string
Carrier: string
CurrencyRate: number
SalesRepresentative: string
ServiceOnly: boolean
Type: string
SourceChannel: string
Quote: {
  Memo: string
  Status: string
  Prepayments: []
  Lines: [
    ProductID: guid
    SKU: string
    Name: string
    Quantity: number
    Price: number
    Discount: number
    Tax: number
    AverageCost: number
    TaxRule: string
    Comment: string
    Total: number
    ProductLength: number
    ProductWidth: number
    ProductHeight: number
    ProductWeight: number
    WeightUnits: string
    DimensionsUnits: string
    ProductCustomField1: null
    ProductCustomField2: null
    ProductCustomField3: null
    ProductCustomField4: null
    ProductCustomField5: null
    ProductCustomField6: null
    ProductCustomField7: null
    ProductCustomField8: null
    ProductCustomField9: null
    ProductCustomField10: null
  ]
  AdditionalCharges: [
    Description: string
    Price: number
    Quantity: number
    Discount: number
    Tax: number
    Total: number
    TaxRule: string
    Comment: string
  ]
  TotalBeforeTax: number
  Tax: number
  Total: number
}
Order: {
  SaleOrderNumber: string
  Memo: string
  Status: string
  Lines: [
    ProductID: guid
    SKU: string
    Name: string
    Quantity: number
    Price: number
    Discount: number
    Tax: number
    AverageCost: number
    TaxRule: string
    Comment: string
    DropShip: boolean
    Backorder: boolean
    BackorderQuantity: number
    Total: number
    ProductLength: number
    ProductWidth: number
    ProductHeight: number
    ProductWeight: number
    WeightUnits: string
    DimensionsUnits: string
    ProductCustomField1: null
    ProductCustomField2: null
    ProductCustomField3: null
    ProductCustomField4: null
    ProductCustomField5: null
    ProductCustomField6: null
    ProductCustomField7: null
    ProductCustomField8: null
    ProductCustomField9: null
    ProductCustomField10: null
  ]
  AdditionalCharges: [
    Description: string
    Price: number
    Quantity: number
    Discount: number
    Tax: number
    Total: number
    TaxRule: string
    Comment: string
  ]
  TotalBeforeTax: number
  Tax: number
  Total: number
}
Fulfilments: [
  TaskID: guid
  FulfillmentNumber: number
  LinkedInvoiceNumber: string
  FulFilmentStatus: string
  Pick: {
    Status: string
    Lines: [
      ProductID: guid
      SKU: string
      Name: string
      Location: string
      LocationID: guid
      Quantity: number
      BatchSN: string
      ExpiryDate: date
      ProductLength: number
      ProductWidth: number
      ProductHeight: number
      ProductWeight: number
      WeightUnits: string
      DimensionsUnits: string
      ProductCustomField1: null
      ProductCustomField2: null
      ProductCustomField3: null
      ProductCustomField4: null
      ProductCustomField5: null
      ProductCustomField6: null
      ProductCustomField7: null
      ProductCustomField8: null
      ProductCustomField9: null
      ProductCustomField10: null
    ]
  }
  Pack: {
    Status: string
    Lines: [
      ProductID: guid
      SKU: string
      Name: string
      Location: string
      LocationID: guid
      Box: string
      Quantity: number
      BatchSN: string
      ExpiryDate: date
      ProductLength: number
      ProductWidth: number
      ProductHeight: number
      ProductWeight: number
      WeightUnits: string
      DimensionsUnits: string
      ProductCustomField1: null
      ProductCustomField2: null
      ProductCustomField3: null
      ProductCustomField4: null
      ProductCustomField5: null
      ProductCustomField6: null
      ProductCustomField7: null
      ProductCustomField8: null
      ProductCustomField9: null
      ProductCustomField10: null
    ]
  }
  Ship: {
    Status: string
    RequireBy: null
    ShippingAddress: {
      DisplayAddressLine1: string
      DisplayAddressLine2: string
      Line1: string
      Line2: string
      City: string
      State: string
      Postcode: string
      Country: string
      Company: string
      Contact: string
      ShipToOther: boolean
    }
    ShippingNotes: string
    Lines: [
      ID: guid
      ShipmentDate: date
      Carrier: string
      Boxes: string
      TrackingNumber: string
      TrackingURL: string
      IsShipped: boolean
    ]
  }
]
Invoices: [
  TaskID: guid
  InvoiceNumber: string
  Memo: string
  Status: string
  InvoiceDate: date
  InvoiceDueDate: date
  CurrencyConversionRate: number
  BillingAddressLine1: string
  BillingAddressLine2: string
  LinkedFulfillmentNumber: string
  Lines: [
    ProductID: guid
    SKU: string
    Name: string
    Quantity: number
    Price: number
    Discount: number
    Tax: number
    Total: number
    AverageCost: number
    TaxRule: string
    Account: string
    Comment: string
    ProductLength: number
    ProductWidth: number
    ProductHeight: number
    ProductWeight: number
    WeightUnits: string
    DimensionsUnits: string
    ProductCustomField1: null
    ProductCustomField2: null
    ProductCustomField3: null
    ProductCustomField4: null
    ProductCustomField5: null
    ProductCustomField6: null
    ProductCustomField7: null
    ProductCustomField8: null
    ProductCustomField9: null
    ProductCustomField10: null
  ]
  AdditionalCharges: [
    Description: string
    Quantity: number
    Price: number
    Discount: number
    Tax: number
    Total: number
    TaxRule: string
    Account: string
    Comment: string
  ]
  Payments: []
  TotalBeforeTax: number
  Tax: number
  Total: number
  Paid: number
]
CreditNotes: [
  TaskID: guid
  CreditNoteInvoiceNumber: string
  Memo: string
  Status: string
  CreditNoteDate: date
  CreditNoteNumber: string
  CreditNoteConversionRate: number
  Lines: [
    ProductID: guid
    SKU: string
    Name: string
    Quantity: number
    Price: number
    Discount: number
    Tax: number
    Total: number
    AverageCost: number
    TaxRule: string
    Account: string
    Comment: string
    ProductLength: number
    ProductWidth: number
    ProductHeight: number
    ProductWeight: number
    WeightUnits: string
    DimensionsUnits: string
    ProductCustomField1: null
    ProductCustomField2: null
    ProductCustomField3: null
    ProductCustomField4: null
    ProductCustomField5: null
    ProductCustomField6: null
    ProductCustomField7: null
    ProductCustomField8: null
    ProductCustomField9: null
    ProductCustomField10: null
  ]
  AdditionalCharges: [
    Description: string
    Quantity: number
    Price: number
    Discount: number
    Tax: number
    Total: number
    TaxRule: string
    Account: string
    Comment: string
  ]
  Refunds: [
    ID: guid
    Reference: string
    Amount: number
    DatePaid: date
    Account: string
    CurrencyRate: number
    DateCreated: date
  ]
  Restock: [
    ProductID: guid
    SKU: string
    Name: string
    Location: string
    LocationID: guid
    Quantity: number
    BatchSN: string
    ExpiryDate: date
  ]
  TotalBeforeTax: number
  Tax: number
  Total: number
]
ManualJournals: {
  Status: string
  Lines: []
}
ExternalID: null
AdditionalAttributes: {
  AdditionalAttribute1: string
  AdditionalAttribute2: string
  AdditionalAttribute3: string
  AdditionalAttribute4: string
  AdditionalAttribute5: string
  AdditionalAttribute6: string
  AdditionalAttribute7: string
  AdditionalAttribute8: string
  AdditionalAttribute9: string
  AdditionalAttribute10: string
}
Attachments: [
  ID: guid
  ContentType: string
  FileName: string
  DownloadUrl: string
]
InventoryMovements: [
  TaskID: guid
  ProductID: guid
  Date: date
  COGS: number
  ProductLength: number
  ProductWidth: number
  ProductHeight: number
  ProductWeight: number
  WeightUnits: string
  DimensionsUnits: string
  ProductCustomField1: null
  ProductCustomField2: null
  ProductCustomField3: null
  ProductCustomField4: null
  ProductCustomField5: null
  ProductCustomField6: null
  ProductCustomField7: null
  ProductCustomField8: null
  ProductCustomField9: null
  ProductCustomField10: null
]
```

### DELETE `/sale` (Delete)

| Parameter | Type | Required |
|---|---|---|
| `ID` |  | yes |
| `Void` | boolean |  |

Response 200:

```text
ID: guid
Customer: string
CustomerID: guid
Contact: string
Phone: string
Email: string
DefaultAccount: string
SkipQuote: boolean
BillingAddress: {
  DisplayAddressLine1: string
  DisplayAddressLine2: string
  Line1: string
  Line2: string
  City: string
  State: string
  Postcode: string
  Country: string
}
ShippingAddress: {
  DisplayAddressLine1: string
  DisplayAddressLine2: string
  Line1: string
  Line2: string
  City: string
  State: string
  Postcode: string
  Country: string
  Company: string
  Contact: string
  ShipToOther: boolean
}
ShippingNotes: string
BaseCurrency: string
CustomerCurrency: string
TaxRule: string
TaxCalculation: string
Terms: string
PriceTier: string
ShipBy: date
Location: string
SaleOrderDate: date
LastModifiedOn: date
Note: string
CustomerReference: string
COGSAmount: number
Status: string
CurrencyRate: number
SalesRepresentative: string
ServiceOnly: boolean
Type: string
SourceChannel: string
Quote: {
  Memo: string
  Status: string
  Prepayments: []
  Lines: [
    ProductID: guid
    SKU: string
    Name: string
    Quantity: number
    Price: number
    Discount: number
    Tax: number
    AverageCost: number
    TaxRule: string
    Comment: string
    Total: number
    ProductLength: number
    ProductWidth: number
    ProductHeight: number
    ProductWeight: number
    WeightUnits: string
    DimensionsUnits: string
    ProductCustomField1: null
    ProductCustomField2: null
    ProductCustomField3: null
    ProductCustomField4: null
    ProductCustomField5: null
    ProductCustomField6: null
    ProductCustomField7: null
    ProductCustomField8: null
    ProductCustomField9: null
    ProductCustomField10: null
  ]
  AdditionalCharges: [
    Description: string
    Price: number
    Quantity: number
    Discount: number
    Tax: number
    Total: number
    TaxRule: string
    Comment: string
  ]
  TotalBeforeTax: number
  Tax: number
  Total: number
}
Order: {
  SaleOrderNumber: string
  Memo: string
  Status: string
  Lines: [
    ProductID: guid
    SKU: string
    Name: string
    Quantity: number
    Price: number
    Discount: number
    Tax: number
    AverageCost: number
    TaxRule: string
    Comment: string
    DropShip: boolean
    Backorder: boolean
    BackorderQuantity: number
    Total: number
    ProductLength: number
    ProductWidth: number
    ProductHeight: number
    ProductWeight: number
    WeightUnits: string
    DimensionsUnits: string
    ProductCustomField1: null
    ProductCustomField2: null
    ProductCustomField3: null
    ProductCustomField4: null
    ProductCustomField5: null
    ProductCustomField6: null
    ProductCustomField7: null
    ProductCustomField8: null
    ProductCustomField9: null
    ProductCustomField10: null
  ]
  AdditionalCharges: [
    Description: string
    Price: number
    Quantity: number
    Discount: number
    Tax: number
    Total: number
    TaxRule: string
    Comment: string
  ]
  TotalBeforeTax: number
  Tax: number
  Total: number
}
Fulfilments: [
  TaskID: guid
  FulfillmentNumber: number
  LinkedInvoiceNumber: string
  FulFilmentStatus: string
  Pick: {
    Status: string
    Lines: [
      ProductID: guid
      SKU: string
      Name: string
      Location: string
      LocationID: guid
      Quantity: number
      BatchSN: string
      ExpiryDate: date
      ProductLength: number
      ProductWidth: number
      ProductHeight: number
      ProductWeight: number
      WeightUnits: string
      DimensionsUnits: string
      ProductCustomField1: null
      ProductCustomField2: null
      ProductCustomField3: null
      ProductCustomField4: null
      ProductCustomField5: null
      ProductCustomField6: null
      ProductCustomField7: null
      ProductCustomField8: null
      ProductCustomField9: null
      ProductCustomField10: null
    ]
  }
  Pack: {
    Status: string
    Lines: [
      ProductID: guid
      SKU: string
      Name: string
      Location: string
      LocationID: guid
      Box: string
      Quantity: number
      BatchSN: string
      ExpiryDate: date
      ProductLength: number
      ProductWidth: number
      ProductHeight: number
      ProductWeight: number
      WeightUnits: string
      DimensionsUnits: string
      ProductCustomField1: null
      ProductCustomField2: null
      ProductCustomField3: null
      ProductCustomField4: null
      ProductCustomField5: null
      ProductCustomField6: null
      ProductCustomField7: null
      ProductCustomField8: null
      ProductCustomField9: null
      ProductCustomField10: null
    ]
  }
  Ship: {
    Status: string
    RequireBy: null
    ShippingAddress: {
      DisplayAddressLine1: string
      DisplayAddressLine2: string
      Line1: string
      Line2: string
      City: string
      State: string
      Postcode: string
      Country: string
      Company: string
      Contact: string
      ShipToOther: boolean
    }
    ShippingNotes: string
    Lines: [
      ID: guid
      ShipmentDate: date
      Carrier: string
      Boxes: string
      TrackingNumber: string
      TrackingURL: string
      IsShipped: boolean
    ]
  }
]
Invoices: [
  TaskID: guid
  InvoiceNumber: string
  Memo: string
  Status: string
  InvoiceDate: date
  InvoiceDueDate: date
  CurrencyConversionRate: number
  BillingAddressLine1: string
  BillingAddressLine2: string
  LinkedFulfillmentNumber: string
  Lines: [
    ProductID: guid
    SKU: string
    Name: string
    Quantity: number
    Price: number
    Discount: number
    Tax: number
    Total: number
    AverageCost: number
    TaxRule: string
    Account: string
    Comment: string
    ProductLength: number
    ProductWidth: number
    ProductHeight: number
    ProductWeight: number
    WeightUnits: string
    DimensionsUnits: string
    ProductCustomField1: null
    ProductCustomField2: null
    ProductCustomField3: null
    ProductCustomField4: null
    ProductCustomField5: null
    ProductCustomField6: null
    ProductCustomField7: null
    ProductCustomField8: null
    ProductCustomField9: null
    ProductCustomField10: null
  ]
  AdditionalCharges: [
    Description: string
    Quantity: number
    Price: number
    Discount: number
    Tax: number
    Total: number
    TaxRule: string
    Account: string
    Comment: string
  ]
  Payments: []
  TotalBeforeTax: number
  Tax: number
  Total: number
  Paid: number
]
CreditNotes: [
  TaskID: guid
  CreditNoteInvoiceNumber: string
  Memo: string
  Status: string
  CreditNoteDate: date
  CreditNoteNumber: string
  CreditNoteConversionRate: number
  Lines: [
    ProductID: guid
    SKU: string
    Name: string
    Quantity: number
    Price: number
    Discount: number
    Tax: number
    Total: number
    AverageCost: number
    TaxRule: string
    Account: string
    Comment: string
    ProductLength: number
    ProductWidth: number
    ProductHeight: number
    ProductWeight: number
    WeightUnits: string
    DimensionsUnits: string
    ProductCustomField1: null
    ProductCustomField2: null
    ProductCustomField3: null
    ProductCustomField4: null
    ProductCustomField5: null
    ProductCustomField6: null
    ProductCustomField7: null
    ProductCustomField8: null
    ProductCustomField9: null
    ProductCustomField10: null
  ]
  AdditionalCharges: [
    Description: string
    Quantity: number
    Price: number
    Discount: number
    Tax: number
    Total: number
    TaxRule: string
    Account: string
    Comment: string
  ]
  Refunds: [
    ID: guid
    Reference: string
    Amount: number
    DatePaid: date
    Account: string
    CurrencyRate: number
    DateCreated: date
  ]
  Restock: [
    ProductID: guid
    SKU: string
    Name: string
    Location: string
    LocationID: guid
    Quantity: number
    BatchSN: string
    ExpiryDate: date
  ]
  TotalBeforeTax: number
  Tax: number
  Total: number
]
ManualJournals: {
  Status: string
  Lines: []
}
ExternalID: null
AdditionalAttributes: {
  AdditionalAttribute1: string
  AdditionalAttribute2: string
  AdditionalAttribute3: string
  AdditionalAttribute4: string
  AdditionalAttribute5: string
  AdditionalAttribute6: string
  AdditionalAttribute7: string
  AdditionalAttribute8: string
  AdditionalAttribute9: string
  AdditionalAttribute10: string
}
Attachments: [
  ID: guid
  ContentType: string
  FileName: string
  DownloadUrl: string
]
InventoryMovements: [
  TaskID: guid
  ProductID: guid
  Date: date
  COGS: number
  ProductLength: number
  ProductWidth: number
  ProductHeight: number
  ProductWeight: number
  WeightUnits: string
  DimensionsUnits: string
  ProductCustomField1: null
  ProductCustomField2: null
  ProductCustomField3: null
  ProductCustomField4: null
  ProductCustomField5: null
  ProductCustomField6: null
  ProductCustomField7: null
  ProductCustomField8: null
  ProductCustomField9: null
  ProductCustomField10: null
]
```

### GET `/sale/quote`

| Parameter | Type | Required |
|---|---|---|
| `SaleID` |  | yes |

Response 200:

```text
SaleID: guid
CombineAdditionalCharges: boolean
Memo: string
Status: string
Lines: [
  ProductID: guid
  SKU: string
  Name: string
  Quantity: number
  Price: number
  Discount: number
  Tax: number
  AverageCost: number
  TaxRule: string
  Comment: string
  Total: number
]
AdditionalCharges: [
  Description: string
  Price: number
  Quantity: number
  Discount: number
  Tax: number
  Total: number
  TaxRule: string
  Comment: string
]
TotalBeforeTax: number
Tax: number
Total: number
```

### POST `/sale/quote`

Request body:

```text
SaleID: guid
CombineAdditionalCharges: boolean
Memo: string
Status: string
Prepayments: []
Lines: [
  ProductID: guid
  SKU: string
  Name: string
  Quantity: number
  Price: number
  Discount: number
  Tax: number
  AverageCost: number
  TaxRule: string
  Comment: string
  Total: number
]
AdditionalCharges: [
  Description: string
  Price: number
  Quantity: number
  Discount: number
  Tax: number
  Total: number
  TaxRule: string
  Comment: string
]
```

Response 200:

```text
SaleID: guid
CombineAdditionalCharges: boolean
Memo: string
Status: string
Lines: [
  ProductID: guid
  SKU: string
  Name: string
  Quantity: number
  Price: number
  Discount: number
  Tax: number
  AverageCost: number
  TaxRule: string
  Comment: string
  Total: number
]
AdditionalCharges: [
  Description: string
  Price: number
  Quantity: number
  Discount: number
  Tax: number
  Total: number
  TaxRule: string
  Comment: string
]
TotalBeforeTax: number
Tax: number
Total: number
```

### GET `/sale/order`

| Parameter | Type | Required |
|---|---|---|
| `SaleID` |  | yes |

Response 200:

```text
SaleID: guid
SaleOrderNumber: string
Memo: string
Status: string
Lines: [
  ProductID: guid
  SKU: string
  Name: string
  Quantity: number
  Price: number
  Discount: number
  Tax: number
  AverageCost: number
  TaxRule: string
  Comment: string
  DropShip: boolean
  BackorderQuantity: number
  Total: number
]
AdditionalCharges: [
  Description: string
  Price: number
  Quantity: number
  Discount: number
  Tax: number
  Total: number
  TaxRule: string
  Comment: string
]
TotalBeforeTax: number
Tax: number
Total: number
```

### POST `/`

Request body:

```text
SaleID: guid
Memo: string
Status: string
AutoPickPackShipMode: string
Lines: [
  ProductID: guid
  SKU: string
  Name: string
  Quantity: number
  Price: number
  Discount: number
  Tax: number
  AverageCost: number
  TaxRule: string
  Comment: string
  DropShip: boolean
  BackorderQuantity: number
  Total: number
]
AdditionalCharges: [
  Description: string
  Price: number
  Quantity: number
  Discount: number
  Tax: number
  Total: number
  TaxRule: string
  Comment: string
]
TotalBeforeTax: number
Tax: number
Total: number
```

Response 200:

```text
SaleID: guid
SaleOrderNumber: string
Memo: string
Status: string
Lines: [
  ProductID: guid
  SKU: string
  Name: string
  Quantity: number
  Price: number
  Discount: number
  Tax: number
  AverageCost: number
  TaxRule: string
  Comment: string
  DropShip: boolean
  BackorderQuantity: number
  Total: number
]
AdditionalCharges: [
  Description: string
  Price: number
  Quantity: number
  Discount: number
  Tax: number
  Total: number
  TaxRule: string
  Comment: string
]
TotalBeforeTax: number
Tax: number
Total: number
```

### GET `/sale/fulfilment`

| Parameter | Type | Required |
|---|---|---|
| `SaleID` |  | yes |

Response 200:

```text
SaleID: guid
Fulfilments: [
  TaskID: guid
  FulfillmentNumber: number
  LinkedInvoiceNumber: string
  FulFilmentStatus: string
  Pick: {
    Status: string
    Lines: [
      ProductID: guid
      SKU: string
      Name: string
      Location: string
      LocationID: guid
      Quantity: number
      BatchSN: string
      ExpiryDate: date
    ]
  }
  Pack: {
    Status: string
    Lines: [
      ProductID: guid
      SKU: string
      Name: string
      Location: string
      LocationID: guid
      Box: string
      Quantity: number
      BatchSN: string
      ExpiryDate: date
    ]
  }
  Ship: {
    Status: string
    RequireBy: null
    ShippingAddress: {
      DisplayAddressLine1: string
      DisplayAddressLine2: string
      Line1: string
      Line2: string
      City: string
      State: string
      Postcode: string
      Country: string
      Company: string
      Contact: string
      ShipToOther: boolean
    }
    ShippingNotes: string
    Lines: [
      ID: guid
      ShipmentDate: date
      Carrier: string
      Boxes: string
      TrackingNumber: string
      TrackingURL: string
      IsShipped: boolean
    ]
  }
]
```

### POST `/`

Request body:

```text
SaleID: guid
```

Response 200:

```text
SaleID: guid
Fulfilments: [
  TaskID: guid
  FulfillmentNumber: number
  LinkedInvoiceNumber: string
  FulFilmentStatus: string
  Pick: {
    Status: string
    Lines: [
      ProductID: guid
      SKU: string
      Name: string
      Location: string
      LocationID: guid
      Quantity: number
      BatchSN: string
      ExpiryDate: date
    ]
  }
  Pack: {
    Status: string
    Lines: [
      ProductID: guid
      SKU: string
      Name: string
      Location: string
      LocationID: guid
      Box: string
      Quantity: number
      BatchSN: string
      ExpiryDate: date
    ]
  }
  Ship: {
    Status: string
    RequireBy: null
    ShippingAddress: {
      DisplayAddressLine1: string
      DisplayAddressLine2: string
      Line1: string
      Line2: string
      City: string
      State: string
      Postcode: string
      Country: string
      Company: string
      Contact: string
      ShipToOther: boolean
    }
    ShippingNotes: string
    Lines: [
      ID: guid
      ShipmentDate: date
      Carrier: string
      Boxes: string
      TrackingNumber: string
      TrackingURL: string
      IsShipped: boolean
    ]
  }
]
```

### DELETE `/sale/fulfilment`

| Parameter | Type | Required |
|---|---|---|
| `TaskID` |  | yes |
| `Void` | boolean |  |

Response 200:

```text
SaleID: guid
Fulfilments: [
  TaskID: guid
  FulfillmentNumber: number
  LinkedInvoiceNumber: string
  FulFilmentStatus: string
  Pick: {
    Status: string
    Lines: [
      ProductID: guid
      SKU: string
      Name: string
      Location: string
      LocationID: guid
      Quantity: number
      BatchSN: string
      ExpiryDate: date
    ]
  }
  Pack: {
    Status: string
    Lines: [
      ProductID: guid
      SKU: string
      Name: string
      Location: string
      LocationID: guid
      Box: string
      Quantity: number
      BatchSN: string
      ExpiryDate: date
    ]
  }
  Ship: {
    Status: string
    RequireBy: null
    ShippingAddress: {
      DisplayAddressLine1: string
      DisplayAddressLine2: string
      Line1: string
      Line2: string
      City: string
      State: string
      Postcode: string
      Country: string
      Company: string
      Contact: string
      ShipToOther: boolean
    }
    ShippingNotes: string
    Lines: [
      ID: guid
      ShipmentDate: date
      Carrier: string
      Boxes: string
      TrackingNumber: string
      TrackingURL: string
      IsShipped: boolean
    ]
  }
]
```

### GET `/sale/fulfilment/pick`

| Parameter | Type | Required |
|---|---|---|
| `TaskID` |  | yes |

Response 200:

```text
TaskID: guid
Status: string
Lines: [
  ProductID: guid
  SKU: string
  Name: string
  Location: string
  LocationID: guid
  Quantity: number
  BatchSN: string
  ExpiryDate: date
  NonInventory: boolean
]
```

### POST `/`

Request body:

```text
TaskID: guid
Status: string
Lines: [
  ProductID: guid
  SKU: string
  Name: string
  Location: string
  LocationID: guid
  Quantity: number
  BatchSN: string
  ExpiryDate: date
]
```

Response 200:

```text
TaskID: guid
Status: string
Lines: [
  ProductID: guid
  SKU: string
  Name: string
  Location: string
  LocationID: guid
  Quantity: number
  BatchSN: string
  ExpiryDate: date
  NonInventory: boolean
]
```

### PUT `/`

Request body:

```text
TaskID: guid
Status: string
Lines: [
  ProductID: guid
  SKU: string
  Name: string
  Location: string
  LocationID: guid
  Quantity: number
  BatchSN: string
  ExpiryDate: date
]
```

Response 200:

```text
TaskID: guid
Status: string
Lines: [
  ProductID: guid
  SKU: string
  Name: string
  Location: string
  LocationID: guid
  Quantity: number
  BatchSN: string
  ExpiryDate: date
  NonInventory: boolean
]
```

### GET `/sale/fulfilment/pack`

| Parameter | Type | Required |
|---|---|---|
| `TaskID` |  | yes |

Response 200:

```text
TaskID: guid
Status: string
Lines: [
  ProductID: guid
  SKU: string
  Name: string
  Location: string
  LocationID: guid
  Box: string
  Quantity: number
  BatchSN: string
  ExpiryDate: date
  NonInventory: boolean
  WarrantyRegistrationNumber: null
]
```

### POST `/`

Request body:

```text
TaskID: guid
Status: string
Lines: [
  ProductID: guid
  SKU: string
  Name: string
  Location: string
  LocationID: guid
  Box: string
  Quantity: number
  BatchSN: string
  ExpiryDate: date
  WarrantyRegistrationNumber: null
]
```

Response 200:

```text
TaskID: guid
Status: string
Lines: [
  ProductID: guid
  SKU: string
  Name: string
  Location: string
  LocationID: guid
  Box: string
  Quantity: number
  BatchSN: string
  ExpiryDate: date
  NonInventory: boolean
  WarrantyRegistrationNumber: null
]
```

### PUT `/`

Request body:

```text
TaskID: guid
Status: string
Lines: [
  ProductID: guid
  SKU: string
  Name: string
  Location: string
  LocationID: guid
  Box: string
  Quantity: number
  BatchSN: string
  ExpiryDate: date
  WarrantyRegistrationNumber: null
]
```

Response 200:

```text
TaskID: guid
Status: string
Lines: [
  ProductID: guid
  SKU: string
  Name: string
  Location: string
  LocationID: guid
  Box: string
  Quantity: number
  BatchSN: string
  ExpiryDate: date
  NonInventory: boolean
  WarrantyRegistrationNumber: null
]
```

### GET `/sale/fulfilment/ship`

| Parameter | Type | Required |
|---|---|---|
| `TaskID` |  | yes |

Response 200:

```text
TaskID: guid
Status: string
RequireBy: null
ShippingAddress: {
  DisplayAddressLine1: string
  DisplayAddressLine2: string
  Line1: string
  Line2: string
  City: string
  State: string
  Postcode: string
  Country: string
  Company: string
  Contact: string
  ShipToOther: boolean
}
ShippingNotes: string
Lines: [
  ID: guid
  ShipmentDate: date
  Carrier: string
  Boxes: string
  TrackingNumber: string
  TrackingURL: string
  IsShipped: boolean
]
```

### POST `/`

Request body:

```text
TaskID: guid
Status: string
RequireBy: null
ShippingAddress: {
  DisplayAddressLine1: string
  DisplayAddressLine2: string
  Line1: string
  Line2: string
  City: string
  State: string
  Postcode: string
  Country: string
  Company: string
  Contact: string
  ShipToOther: boolean
}
ShippingNotes: string
Lines: [
  ShipmentDate: date
  Carrier: string
  Box: string
  TrackingNumber: string
  TrackingURL: string
  IsShipped: boolean
]
```

Response 200:

```text
TaskID: guid
Status: string
RequireBy: null
ShippingAddress: {
  DisplayAddressLine1: string
  DisplayAddressLine2: string
  Line1: string
  Line2: string
  City: string
  State: string
  Postcode: string
  Country: string
  Company: string
  Contact: string
  ShipToOther: boolean
}
ShippingNotes: string
Lines: [
  ID: guid
  ShipmentDate: date
  Carrier: string
  Boxes: string
  TrackingNumber: string
  TrackingURL: string
  IsShipped: boolean
]
```

### PUT `/`

Request body:

```text
TaskID: guid
Status: string
RequireBy: null
ShippingAddress: {
  DisplayAddressLine1: string
  DisplayAddressLine2: string
  Line1: string
  Line2: string
  City: string
  State: string
  Postcode: string
  Country: string
  Company: string
  Contact: string
  ShipToOther: boolean
}
ShippingNotes: string
Lines: [
  ShipmentDate: date
  Carrier: string
  Box: string
  TrackingNumber: string
  TrackingURL: string
  IsShipped: boolean
]
```

Response 200:

```text
TaskID: guid
Status: string
RequireBy: null
ShippingAddress: {
  DisplayAddressLine1: string
  DisplayAddressLine2: string
  Line1: string
  Line2: string
  City: string
  State: string
  Postcode: string
  Country: string
  Company: string
  Contact: string
  ShipToOther: boolean
}
ShippingNotes: string
Lines: [
  ID: guid
  ShipmentDate: date
  Carrier: string
  Boxes: string
  TrackingNumber: string
  TrackingURL: string
  IsShipped: boolean
]
```

### GET `/sale/invoice`

| Parameter | Type | Required |
|---|---|---|
| `SaleID` |  | yes |

Response 200:

```text
SaleID: guid
Invoices: [
  TaskID: guid
  CombineAdditionalCharges: boolean
  InvoiceNumber: string
  Memo: string
  Status: string
  InvoiceDate: date
  InvoiceDueDate: date
  CurrencyConversionRate: number
  BillingAddressLine1: string
  BillingAddressLine2: string
  LinkedFulfillmentNumber: string
  Lines: [
    ProductID: guid
    SKU: string
    Name: string
    Quantity: number
    Price: number
    Discount: number
    Tax: number
    Total: number
    AverageCost: number
    TaxRule: string
    Account: string
    Comment: string
  ]
  AdditionalCharges: [
    Description: string
    Quantity: number
    Price: number
    Discount: number
    Tax: number
    Total: number
    TaxRule: string
    Account: string
    Comment: string
  ]
]
```

### POST `/`

Request body:

```text
SaleID: guid
TaskID: guid
CombineAdditionalCharges: boolean
Memo: string
Status: string
InvoiceDate: date
InvoiceDueDate: date
CurrencyConversionRate: number
BillingAddressLine1: string
BillingAddressLine2: string
LinkedFulfillmentNumber: string
Lines: [
  ProductID: guid
  SKU: string
  Name: string
  Quantity: number
  Price: number
  Discount: number
  Tax: number
  Total: number
  TaxRule: string
  Account: string
  Comment: string
]
AdditionalCharges: [
  Description: string
  Quantity: number
  Price: number
  Discount: number
  Tax: number
  Total: number
  TaxRule: string
  Account: string
  Comment: string
]
```

Response 200:

```text
SaleID: guid
Invoices: [
  TaskID: guid
  CombineAdditionalCharges: boolean
  InvoiceNumber: string
  Memo: string
  Status: string
  InvoiceDate: date
  InvoiceDueDate: date
  CurrencyConversionRate: number
  BillingAddressLine1: string
  BillingAddressLine2: string
  LinkedFulfillmentNumber: string
  Lines: [
    ProductID: guid
    SKU: string
    Name: string
    Quantity: number
    Price: number
    Discount: number
    Tax: number
    Total: number
    AverageCost: number
    TaxRule: string
    Account: string
    Comment: string
  ]
  AdditionalCharges: [
    Description: string
    Quantity: number
    Price: number
    Discount: number
    Tax: number
    Total: number
    TaxRule: string
    Account: string
    Comment: string
  ]
]
```

### PUT `/`

Request body:

```text
SaleID: guid
TaskID: guid
Memo: string
Status: string
```

Response 200:

```text
SaleID: guid
Invoices: [
  TaskID: guid
  CombineAdditionalCharges: boolean
  InvoiceNumber: string
  Memo: string
  Status: string
  InvoiceDate: date
  InvoiceDueDate: date
  CurrencyConversionRate: number
  BillingAddressLine1: string
  BillingAddressLine2: string
  LinkedFulfillmentNumber: string
  Lines: [
    ProductID: guid
    SKU: string
    Name: string
    Quantity: number
    Price: number
    Discount: number
    Tax: number
    Total: number
    AverageCost: number
    TaxRule: string
    Account: string
    Comment: string
  ]
  AdditionalCharges: [
    Description: string
    Quantity: number
    Price: number
    Discount: number
    Tax: number
    Total: number
    TaxRule: string
    Account: string
    Comment: string
  ]
]
```

### DELETE `/sale/invoice`

| Parameter | Type | Required |
|---|---|---|
| `TaskID` |  | yes |
| `Void` | boolean |  |

Response 200:

```text
SaleID: guid
Invoices: [
  TaskID: guid
  CombineAdditionalCharges: boolean
  InvoiceNumber: string
  Memo: string
  Status: string
  InvoiceDate: date
  InvoiceDueDate: date
  CurrencyConversionRate: number
  BillingAddressLine1: string
  BillingAddressLine2: string
  LinkedFulfillmentNumber: string
  Lines: []
  AdditionalCharges: []
]
```

### GET `/sale/creditnote`

| Parameter | Type | Required |
|---|---|---|
| `SaleID` |  | yes |

Response 200:

```text
SaleID: guid
CreditNotes: [
  TaskID: guid
  CombineAdditionalCharges: boolean
  CreditNoteInvoiceNumber: string
  Memo: string
  Status: string
  CreditNoteDate: date
  CreditNoteNumber: string
  CreditNoteConversionRate: number
  Lines: [
    ProductID: guid
    SKU: string
    Name: string
    Quantity: number
    Price: number
    Discount: number
    Tax: number
    Total: number
    AverageCost: number
    TaxRule: string
    Account: string
    Comment: string
  ]
  AdditionalCharges: [
    Description: string
    Quantity: number
    Price: number
    Discount: number
    Tax: number
    Total: number
    TaxRule: string
    Account: string
    Comment: string
  ]
  Restock: [
    ProductID: guid
    SKU: string
    Name: string
    Location: string
    LocationID: guid
    Quantity: number
    BatchSN: string
    ExpiryDate: date
    RestockLocation: string
    RestockLocationID: guid
  ]
  CreditNoteBalance: number
  Payments: [
    ID: guid
    SaleOrderNumber: string
    InvoiceNumber: null
    CreditNoteNumber: string
    Type: string
    Reference: string
    Amount: number
    DatePaid: date
    Account: string
    CurrencyRate: number
    DateCreated: date
    CreditID: null
  ]
]
```

### POST `/`

Request body:

```text
keys: Account, AdditionalCharges, AverageCost, BatchSN, CombineAdditionalCharges, Comment, CreditNoteConversionRate, CreditNoteDate, CreditNoteInvoiceNumber, Description, Discount, ExpiryDate, Lines, Location, LocationID, Memo, Name, Price, ProductID, Quantity, Restock, RestockLocation, RestockLocationID, SKU, Status, TaskID, Tax, TaxRule, Total
```

Response 200:

```text
SaleID: guid
CreditNotes: [
  TaskID: guid
  CombineAdditionalCharges: boolean
  CreditNoteInvoiceNumber: string
  Memo: string
  Status: string
  CreditNoteDate: date
  CreditNoteNumber: string
  CreditNoteConversionRate: number
  Lines: [
    ProductID: guid
    SKU: string
    Name: string
    Quantity: number
    Price: number
    Discount: number
    Tax: number
    Total: number
    AverageCost: number
    TaxRule: string
    Account: string
    Comment: string
  ]
  AdditionalCharges: [
    Description: string
    Quantity: number
    Price: number
    Discount: number
    Tax: number
    Total: number
    TaxRule: string
    Account: string
    Comment: string
  ]
  Restock: [
    ProductID: guid
    SKU: string
    Name: string
    Location: string
    LocationID: guid
    Quantity: number
    BatchSN: null
    ExpiryDate: date
    RestockLocation: string
    RestockLocationID: guid
  ]
]
```

### DELETE `/sale/creditnote`

| Parameter | Type | Required |
|---|---|---|
| `TaskID` |  | yes |
| `Void` | boolean |  |

Response 200:

```text
SaleID: guid
CreditNotes: [
  TaskID: guid
  CombineAdditionalCharges: boolean
  CreditNoteInvoiceNumber: string
  Memo: string
  Status: string
  CreditNoteDate: date
  CreditNoteNumber: string
  CreditNoteConversionRate: number
  Lines: []
  AdditionalCharges: []
  Restock: []
]
```

### GET `/sale/payment`

| Parameter | Type | Required |
|---|---|---|
| `SaleID` |  | yes |

Response 200:

```text
[
  SaleID: guid
  TaskID: guid
  ID: guid
  SaleOrderNumber: string
  InvoiceNumber: string
  CreditNoteNumber: null
  Type: string
  Reference: string
  Amount: number
  DatePaid: date
  Account: string
  CurrencyRate: number
  DateCreated: date
  CreditID: null
]
```

### POST `/`

Request body:

```text
TaskID: guid
Type: string
Reference: string
Amount: number
DatePaid: date
Account: string
CurrencyRate: number
CreditID: null
```

Response 200:

```text
SaleID: guid
TaskID: guid
ID: guid
SaleOrderNumber: string
InvoiceNumber: string
CreditNoteNumber: null
Type: string
Reference: string
Amount: number
DatePaid: date
Account: string
CurrencyRate: number
DateCreated: date
CreditID: null
```

### PUT `/`

Request body:

```text
ID: guid
Reference: string
Amount: number
DatePaid: date
Account: string
CurrencyRate: number
```

Response 200:

```text
SaleID: guid
TaskID: guid
ID: guid
SaleOrderNumber: string
InvoiceNumber: string
CreditNoteNumber: null
Type: string
Reference: string
Amount: number
DatePaid: date
Account: string
CurrencyRate: number
DateCreated: date
CreditID: null
```

### DELETE `/sale/payment`

| Parameter | Type | Required |
|---|---|---|
| `ID` | string | yes |

Response 200:

```text
Success: boolean
```

### GET `/sale/manualJournal`

| Parameter | Type | Required |
|---|---|---|
| `SaleID` |  | yes |

Response 200:

```text
SaleID: guid
Status: string
Lines: [
  Reference: string
  Amount: number
  Date: date
  Debit: string
  Credit: string
]
```

### POST `/`

Request body:

```text
SaleID: guid
Status: string
Lines: [
  Reference: string
  Amount: number
  Date: date
  Debit: string
  Credit: string
]
```

Response 200:

```text
SaleID: guid
Status: string
Lines: [
  Reference: string
  Amount: number
  Date: date
  Debit: string
  Credit: string
]
```

### GET `/sale/attachment`

| Parameter | Type | Required |
|---|---|---|
| `SaleID` |  | yes |

Response 200:

```text
SaleID: guid
Lines: [
  ID: guid
  ContentType: string
  FileName: string
  DownloadUrl: string
]
```

### POST `/`

Request body:

```text
keys: 
```

Response 200:

```text
SaleID: guid
Lines: [
  ID: guid
  ContentType: string
  FileName: string
  DownloadUrl: string
]
```

### DELETE `/sale/attachment`

| Parameter | Type | Required |
|---|---|---|
| `ID` |  |  |

Response 200:

```text
SaleID: guid
Lines: [
  ID: guid
  ContentType: string
  FileName: string
  DownloadUrl: string
]
```

