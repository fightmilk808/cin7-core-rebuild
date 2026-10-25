# Public API: Purchase

From Cin7's API Blueprint: field tables (name, type, length, required, allowed values), each operation's query parameters, and request and response bodies as type outlines (`guid`, `string`, `number`, `boolean`, `date`, `null`; `[ … ]` = array of). Base `/ExternalApi/v2`; headers in [docs/PUBLIC-API.md](../../../docs/PUBLIC-API.md).

**Resources:** `/purchaseList?Page={Page}&Limit={Limit}&Search={Search}&RequiredBy={RequiredBy}&UpdatedSince={UpdatedSince}&OrderStatus={OrderStatus}&RestockReceivedStatus={RestockReceivedStatus}&InvoiceStatus={InvoiceStatus}&CreditNoteStatus={CreditNoteStatus}&UnstockStatus={UnstockStatus}&Status{Status}&DropShipTaskID={DropShipTaskID}` · `/purchaseCreditNoteList?Page={Page}&Limit={Limit}&Search={Search}&UpdatedSince={UpdatedSince}&CreditNoteStatus={CreditNoteStatus}&Status{Status}` · `/purchase` · `/purchase/order` · `/purchase/stock` · `/purchase/invoice` · `/purchase/creditnote` · `/purchase/payment` · `/purchase/manualJournal` · `/purchase/attachment` · `/advanced-purchase` · `/advanced-purchase/stock` · `/advanced-purchase/put-away` · `/advanced-purchase/invoice` · `/advanced-purchase/creditnote` · `/advanced-purchase/payment` · `/advanced-purchase/manualJournal`

## Fields

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

#### Purchase List

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `ID` | Guid |  |  |  |
| `BlindReceipt` | Boolean |  |  |  |
| `OrderNumber` | String | 256 |  |  |
| `Status` | String | 50 |  |  |
| `OrderDate` | Date |  |  |  |
| `InvoiceDate` | Date |  |  |  |
| `Supplier` | Date | 256 |  |  |
| `SupplierID` | Guid |  |  |  |
| `InvoiceNumber` | String | 256 |  |  |
| `InvoiceAmount` | Decimal |  |  |  |
| `PaidAmount` | Decimal |  |  |  |
| `InvoiceDueDate` | Date |  |  |  |
| `RequiredBy` | Date |  |  |  |
| `BaseCurrency` | String | 3 |  |  |
| `SupplierCurrency` | String | 3 |  |  |
| `CreditNoteNumber` | String | 256 |  |  |
| `OrderStatus` | String | 20 |  | `VOIDED`, `, `, `, ` |
| `StockReceivedStatus` | String | 20 |  | `VOIDED`, `DRAFT`, `AUTHORISED`, `NOT AVAILABLE` |
| `UnstockStatus` | String | 20 |  | `VOIDED`, `DRAFT`, `AUTHORISED`, `NOT AVAILABLE` |
| `InvoiceStatus` | String | 20 |  | `VOIDED`, `DRAFT`, `AUTHORISED`, `NOT AVAILABLE` |
| `CreditNoteStatus` | String | 20 |  | `VOIDED`, `DRAFT`, `AUTHORISED`, `NOT AVAILABLE` |
| `LastUpdatedDate` | Date |  |  |  |
| `CombinedReceivingStatus` | String | 20 | Yes | `FULLY RECEIVED`, `PARTIALLY RECEIVED`, `NOT AVAILABLE`, `NOT RECEIVED`, `VOIDED` |
| `CombinedInvoiceStatus` | String | 20 | Yes | `INVOICED`, `INVOICED / CREDITED`, `NOT AVAILABLE`, `NOT INVOICED`, `PARTIALLY INVOICED`, `PARTIALLY INVOICED / CREDITED` |
| `CombinedPaymentStatus` | String | 20 | Yes | `PREPAID`, `PARTIALLY PAID`, `UNPAID`, `PAID`, `OVERPAID / CREDITED`, `VOIDED` |
| `Type` | String | 20 | Yes | `Simple Purchase`, `Advanced Purchase`, `Service Purchase` |
| `IsServiceOnly` | Boolean |  |  |  |
| `DropShipTaskID` | Guid |  |  |  |

#### Purchase Credit Note List

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `ID` | Guid |  |  |  |
| `BlindReceipt` | Boolean |  |  |  |
| `OrderNumber` | String | 256 |  |  |
| `Status` | String | 50 |  |  |
| `OrderDate` | Date |  |  |  |
| `InvoiceDate` | Date |  |  |  |
| `Supplier` | Date | 256 |  |  |
| `SupplierID` | Guid |  |  |  |
| `InvoiceNumber` | String | 256 |  |  |
| `InvoiceAmount` | Decimal |  |  |  |
| `PaidAmount` | Decimal |  |  |  |
| `InvoiceDueDate` | Date |  |  |  |
| `RequiredBy` | Date |  |  |  |
| `BaseCurrency` | String | 3 |  |  |
| `SupplierCurrency` | String | 3 |  |  |
| `CreditNoteNumber` | String | 256 |  |  |
| `OrderStatus` | String | 20 |  | `VOIDED`, `, `, `, ` |
| `StockReceivedStatus` | String | 20 |  | `VOIDED`, `DRAFT`, `AUTHORISED`, `NOT AVAILABLE` |
| `UnstockStatus` | String | 20 |  | `VOIDED`, `DRAFT`, `AUTHORISED`, `NOT AVAILABLE` |
| `InvoiceStatus` | String | 20 |  | `VOIDED`, `DRAFT`, `AUTHORISED`, `NOT AVAILABLE` |
| `CreditNoteStatus` | String | 20 |  | `VOIDED`, `DRAFT`, `AUTHORISED`, `NOT AVAILABLE` |
| `LastUpdatedDate` | Date |  |  |  |
| `CombinedReceivingStatus` | String | 20 | Yes | `FULLY RECEIVED`, `PARTIALLY RECEIVED`, `NOT AVAILABLE`, `NOT RECEIVED`, `VOIDED` |
| `CombinedInvoiceStatus` | String | 20 | Yes | `INVOICED`, `INVOICED / CREDITED`, `NOT AVAILABLE`, `NOT INVOICED`, `PARTIALLY INVOICED`, `PARTIALLY INVOICED / CREDITED` |
| `CombinedPaymentStatus` | String | 20 | Yes | `PREPAID`, `PARTIALLY PAID`, `UNPAID`, `PAID`, `OVERPAID / CREDITED`, `VOIDED` |
| `Type` | String | 20 | Yes | `Simple Purchase`, `Advanced Purchase`, `Service Purchase`, `Purchase Credit Note`, `Credit Note` |
| `IsServiceOnly` | Boolean |  |  |  |
| `DropShipTaskID` | Guid |  |  |  |

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
| `Status` | String | 20 |  |  |
| `RelatedDropShipSaleTask` | Guid |  |  |  |
| `CurrencyRate` | Decimal |  |  |  |
| `LastUpdatedDate` | DateTime |  |  |  |
| `Order` | Purchase Order Model |  |  |  |
| `StockReceived` | Purchase Stock Model |  |  |  |
| `Invoice` | Purchase Invoice Model |  |  |  |
| `CreditNote` | Purchase Credit Note Model |  |  |  |
| `ManualJournals` | Purchase Manual Journal Model |  |  |  |
| `AdditionalAttributes` | Additional Attribute Model |  |  |  |
| `Attachments` | [] Attachment Line Model |  |  |  |
| `InventoryMovements` | Inventory Movement Line Model |  |  |  |

#### Purchase Order

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `TaskID` | Guid |  | Yes |  |
| `CombineAdditionalCharges` | Boolean |  | Yes |  |
| `Memo` | String | 1024 | Yes |  |
| `Status` | string |  | Yes | `NOT AVAILABLE`, `DRAFT`, `AUTHORISED`, `VOIDED`, `DRAFT`, `AUTHORISED` |
| `Lines` | [] Purchase Order Line Model |  | Yes |  |
| `AdditionalCharges` | [] Purchase Additional Charge Model |  |  |  |
| `TotalBeforeTax` | Decimal with up to 4 decimal places |  | Yes |  |
| `Tax` | Decimal with up to 4 decimal places |  | Yes |  |
| `Total` | Decimal with up to 4 decimal places |  | Yes |  |

#### Purchase Stock Received

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `TaskID` | Guid |  | Yes |  |
| `Status` | string |  | Yes | `NOT AVAILABLE`, `DRAFT`, `AUTHORISED`, `VOIDED`, `DRAFT`, `AUTHORISED` |
| `Lines` | [] Purchase Stock Line Model |  | Yes |  |

#### Purchase Invoice

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `TaskID` | Guid |  | Yes |  |
| `CombineAdditionalCharges` | Boolean |  | Yes |  |
| `InvoiceDate` | DateTime |  | Yes |  |
| `InvoiceDueDate` | DateTime |  | Yes |  |
| `InvoiceNumber` | string |  |  |  |
| `Status` | string |  | Yes | `NOT AVAILABLE`, `DRAFT`, `AUTHORISED`, `VOIDED`, `PAID`, `DRAFT`, `AUTHORISED` |
| `Lines` | [] Purchase Invoice Line Model |  | Yes |  |
| `AdditionalCharges` | [] Purchase Invoice Additional Charge Model |  |  |  |
| `TotalBeforeTax` | Decimal with up to 4 decimal places |  |  |  |
| `Tax` | Decimal with up to 4 decimal places |  |  |  |
| `Total` | Decimal with up to 4 decimal places |  |  |  |
| `InvoiceTotalAmount` | Decimal with up to 4 decimal places |  |  |  |
| `InvoiceTotalTaxAmount` | Decimal with up to 4 decimal places |  |  |  |

#### Purchase Credit Note

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `TaskID` | Guid |  | Yes |  |
| `CombineAdditionalCharges` | Boolean |  | Yes |  |
| `CreditNoteNumber` | string |  | Yes |  |
| `CreditNoteDate` | DateTime |  | Yes |  |
| `Status` | string |  | Yes | `NOT AVAILABLE`, `DRAFT`, `AUTHORISED`, `VOIDED`, `DRAFT`, `AUTHORISED` |
| `Lines` | [] Purchase Invoice Line Model |  | Yes |  |
| `AdditionalCharges` | [] Purchase Invoice Additional Charge Model |  |  |  |
| `Unstock` | [] Purchase Unstock Line Model |  | Yes |  |
| `TotalBeforeTax` | Decimal with up to 4 decimal places |  |  |  |
| `Tax` | Decimal with up to 4 decimal places |  |  |  |
| `Total` | Decimal with up to 4 decimal places |  |  |  |

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

#### Purchase Attachments

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `TaskID` | Guid |  | Yes |  |
| `Lines` | [] Attachment Line Model |  |  |  |

#### POST Methods

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `PurchaseID` | Guid |  | Yes |  |
| `FileName` | String |  | Yes |  |
| `FileDownloadUrl` | String |  | No |  |
| `Content` | String |  | Yes* |  |

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

## Operations

### GET `/`

| Parameter | Type | Required |
|---|---|---|
| `Page` | number |  |
| `Limit` | number |  |
| `Search` | string |  |
| `RequiredBy` | DateTime |  |
| `UpdatedSince` | DateTime |  |
| `UpdatedUntil` | DateTime |  |
| `OrderStatus` | string |  |
| `RestockReceivedStatus` | string |  |
| `InvoiceStatus` | string |  |
| `CreditNoteStatus` | string |  |
| `UnstockStatus` | string |  |
| `Status` | string |  |
| `DropShipTaskID` | Guid |  |

Response 200:

```text
Total: number
Page: number
PurchaseList: [
  ID: guid
  BlindReceipt: boolean
  OrderNumber: string
  Status: string
  OrderDate: date
  InvoiceDate: date
  Supplier: string
  SupplierID: guid
  InvoiceNumber: string
  InvoiceAmount: number
  PaidAmount: number
  InvoiceDueDate: date
  RequiredBy: null
  BaseCurrency: string
  SupplierCurrency: string
  CreditNoteNumber: string
  OrderStatus: string
  StockReceivedStatus: string
  UnstockStatus: string
  InvoiceStatus: string
  CreditNoteStatus: string
  LastUpdatedDate: date
  Type: string
  CombinedInvoiceStatus: string
  CombinedPaymentStatus: string
  CombinedReceivingStatus: string
  IsServiceOnly: boolean
  DropShipTaskID: null
]
```

### GET `/`

| Parameter | Type | Required |
|---|---|---|
| `Page` | number |  |
| `Limit` | number |  |
| `Search` | string |  |
| `UpdatedSince` | DateTime |  |
| `UpdatedUntil` | DateTime |  |
| `CreditNoteStatus` | string |  |
| `Status` | string |  |

Response 200:

```text
Total: number
Page: number
PurchaseList: [
  ID: guid
  BlindReceipt: boolean
  OrderNumber: string
  Status: string
  OrderDate: date
  InvoiceDate: null
  Supplier: string
  SupplierID: guid
  InvoiceNumber: string
  InvoiceAmount: number
  PaidAmount: number
  InvoiceDueDate: null
  RequiredBy: null
  BaseCurrency: string
  SupplierCurrency: string
  CreditNoteNumber: string
  OrderStatus: string
  StockReceivedStatus: string
  UnstockStatus: string
  InvoiceStatus: string
  CreditNoteStatus: string
  LastUpdatedDate: date
  Type: string
  CombinedInvoiceStatus: string
  CombinedPaymentStatus: string
  CombinedReceivingStatus: string
  IsServiceOnly: boolean
  DropShipTaskID: null
]
```

### GET `/purchase`

| Parameter | Type | Required |
|---|---|---|
| `ID` |  | yes |

Response 200:

```text
ID: guid
SupplierID: guid
Supplier: string
Contact: string
Phone: string
InventoryAccount: string
BlindReceipt: boolean
Approach: string
BillingAddress: {
  DisplayAddressLine1: string
  DisplayAddressLine2: string
  Line1: null
  Line2: null
  City: null
  State: null
  Postcode: null
  Country: null
}
ShippingAddress: {
  DisplayAddressLine1: string
  DisplayAddressLine2: string
  Line1: null
  Line2: null
  City: null
  State: null
  Postcode: null
  Country: null
  ShipToOther: boolean
}
BaseCurrency: string
SupplierCurrency: string
TaxRule: string
TaxCalculation: string
Terms: string
RequiredBy: null
Location: string
Note: string
OrderNumber: string
OrderDate: date
Status: string
RelatedDropShipSaleTask: null
CurrencyRate: number
LastUpdatedDate: date
Order: {
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
    TaxRule: string
    SupplierSKU: string
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
    Reference: string
    Price: number
    Quantity: number
    Discount: number
    Tax: number
    Total: number
    TaxRule: string
  ]
  Prepayments: [
    ID: guid
    Reference: string
    Amount: number
    DatePaid: date
    Account: string
    CurrencyRate: number
    DateCreated: date
  ]
  TotalBeforeTax: number
  Tax: number
  Total: number
}
StockReceived: {
  Status: string
  Lines: [
    Date: date
    Quantity: number
    ProductID: guid
    SKU: string
    Name: string
    Location: string
    LocationID: guid
    Received: boolean
    BatchSN: string
    SupplierSKU: string
    ExpiryDate: date
    CardID: guid
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
Invoice: {
  InvoiceDate: date
  InvoiceDueDate: date
  InvocieNumber: string
  Status: string
  Lines: [
    ProductID: guid
    SKU: string
    Name: string
    Quantity: number
    Price: number
    Discount: number
    Tax: number
    TaxRule: string
    Account: string
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
    Reference: string
    Quantity: number
    Price: number
    Discount: number
    Tax: number
    TaxRule: string
    Account: string
    Total: number
  ]
  Payments: [
    ID: guid
    Reference: string
    Amount: number
    DatePaid: date
    Account: string
    CurrencyRate: number
    DateCreated: date
  ]
  TotalBeforeTax: number
  Tax: number
  Total: number
  Paid: number
}
CreditNote: {
  CreditNoteNumber: string
  CreditNoteDate: date
  Status: string
  Lines: [
    ProductID: guid
    SKU: string
    Name: string
    Quantity: number
    Price: number
    Discount: number
    Tax: number
    TaxRule: string
    Account: string
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
    Reference: string
    Quantity: number
    Price: number
    Discount: number
    Tax: number
    TaxRule: string
    Account: string
    Total: number
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
  Unstock: {
    Status: string
    Lines: [
      CardID: guid
      Date: date
      Quantity: number
      ProductID: guid
      SKU: string
      Name: string
      Location: string
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
  TotalBeforeTax: number
  Tax: number
  Total: number
}
ManualJournals: {
  Status: string
  Lines: [
    Reference: string
    Amount: number
    Date: date
    Debit: string
    Credit: string
    IsSystem: boolean
  ]
}
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

### POST `/`

Request body:

```text
SupplierID: guid
Supplier: string
TaxRule: string
TaxCalculation: string
Terms: string
Approach: string
BlindReceipt: boolean
Contact: string
Phone: string
CurrencyRate: number
Location: string
Note: string
RequiredBy: null
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
  ShipToOther: boolean
}
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
```

Response 200:

```text
ID: guid
SupplierID: guid
Supplier: string
Contact: string
Phone: null
InventoryAccount: string
BlindReceipt: boolean
Approach: string
BillingAddress: {
  DisplayAddressLine1: null
  DisplayAddressLine2: null
  Line1: null
  Line2: null
  City: null
  State: null
  Postcode: null
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
  ShipToOther: boolean
}
BaseCurrency: string
SupplierCurrency: string
TaxRule: string
TaxCalculation: string
Terms: string
RequiredBy: null
Location: string
Note: null
OrderNumber: string
OrderDate: date
Status: string
RelatedDropShipSaleTask: null
CurrencyRate: number
LastUpdatedDate: date
Order: {
  Memo: null
  Status: string
  Lines: []
  AdditionalCharges: []
  Prepayments: []
  TotalBeforeTax: number
  Tax: number
  Total: number
}
StockReceived: {
  Status: string
  Lines: []
}
Invoice: {
  InvoiceDate: date
  InvoiceDueDate: null
  InvocieNumber: null
  Status: string
  Lines: []
  AdditionalCharges: []
  Payments: []
  TotalBeforeTax: number
  Tax: number
  Total: number
  Paid: number
}
CreditNote: {
  CreditNoteNumber: string
  CreditNoteDate: null
  Status: string
  Lines: []
  AdditionalCharges: []
  Refunds: []
  Unstock: {
    Status: string
    Lines: []
  }
  TotalBeforeTax: number
  Tax: number
  Total: number
}
ManualJournals: {
  Status: string
  Lines: []
}
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
Attachments: []
InventoryMovements: []
```

### PUT `/`

Request body:

```text
ID: guid
SupplierID: guid
Supplier: string
TaxRule: string
TaxCalculation: string
Terms: string
Approach: string
BlindReceipt: boolean
Contact: string
Phone: string
CurrencyRate: number
Location: string
Note: string
RequiredBy: null
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
  ShipToOther: boolean
}
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
```

Response 200:

```text
ID: guid
SupplierID: guid
Supplier: string
Contact: string
Phone: null
InventoryAccount: string
BlindReceipt: boolean
Approach: string
BillingAddress: {
  DisplayAddressLine1: null
  DisplayAddressLine2: null
  Line1: null
  Line2: null
  City: null
  State: null
  Postcode: null
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
  ShipToOther: boolean
}
BaseCurrency: string
SupplierCurrency: string
TaxRule: string
TaxCalculation: string
Terms: string
RequiredBy: null
Location: string
Note: null
OrderNumber: string
OrderDate: date
Status: string
RelatedDropShipSaleTask: null
CurrencyRate: number
LastUpdatedDate: date
Order: {
  Memo: null
  Status: string
  Lines: []
  AdditionalCharges: []
  Prepayments: []
  TotalBeforeTax: number
  Tax: number
  Total: number
}
StockReceived: {
  Status: string
  Lines: []
}
Invoice: {
  InvoiceDate: date
  InvoiceDueDate: null
  InvocieNumber: null
  Status: string
  Lines: []
  AdditionalCharges: []
  Payments: []
  TotalBeforeTax: number
  Tax: number
  Total: number
  Paid: number
}
CreditNote: {
  CreditNoteNumber: string
  CreditNoteDate: null
  Status: string
  Lines: []
  AdditionalCharges: []
  Refunds: []
  Unstock: {
    Status: string
    Lines: []
  }
  TotalBeforeTax: number
  Tax: number
  Total: number
}
ManualJournals: {
  Status: string
  Lines: []
}
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
Attachments: []
InventoryMovements: []
```

### DELETE `/purchase`

| Parameter | Type | Required |
|---|---|---|
| `ID` |  | yes |
| `Void` | boolean |  |

Response 200:

```text
ID: guid
SupplierID: guid
Supplier: string
Contact: string
Phone: null
InventoryAccount: string
BlindReceipt: boolean
Approach: string
BillingAddress: {
  DisplayAddressLine1: null
  DisplayAddressLine2: null
  Line1: null
  Line2: null
  City: null
  State: null
  Postcode: null
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
  ShipToOther: boolean
}
BaseCurrency: string
SupplierCurrency: string
TaxRule: string
TaxCalculation: string
Terms: string
RequiredBy: null
Location: string
Note: null
OrderNumber: string
OrderDate: date
Status: string
RelatedDropShipSaleTask: null
CurrencyRate: number
LastUpdatedDate: date
Order: {
  Memo: null
  Status: string
  Lines: []
  AdditionalCharges: []
  Prepayments: []
  TotalBeforeTax: number
  Tax: number
  Total: number
}
StockReceived: {
  Status: string
  Lines: []
}
Invoice: {
  InvoiceDate: date
  InvoiceDueDate: null
  InvocieNumber: null
  Status: string
  Lines: []
  AdditionalCharges: []
  Payments: []
  TotalBeforeTax: number
  Tax: number
  Total: number
  Paid: number
}
CreditNote: {
  CreditNoteNumber: string
  CreditNoteDate: null
  Status: string
  Lines: []
  AdditionalCharges: []
  Refunds: []
  Unstock: {
    Status: string
    Lines: []
  }
  TotalBeforeTax: number
  Tax: number
  Total: number
}
ManualJournals: {
  Status: string
  Lines: []
}
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
Attachments: []
InventoryMovements: []
```

### GET `/purchase/order`

| Parameter | Type | Required |
|---|---|---|
| `TaskID` |  | yes |

Response 200:

```text
TaskID: guid
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
  TaxRule: string
  SupplierSKU: string
  Comment: string
  Total: number
]
AdditionalCharges: [
  Description: string
  Reference: string
  Price: number
  Quantity: number
  Discount: number
  Tax: number
  Total: number
  TaxRule: string
]
TotalBeforeTax: number
Tax: number
Total: number
```

### POST `/`

Request body:

```text
TaskID: guid
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
  TaxRule: string
  SupplierSKU: string
  Comment: string
  Total: number
]
AdditionalCharges: [
  Description: string
  Reference: string
  Price: number
  Quantity: number
  Discount: number
  Tax: number
  Total: number
  TaxRule: string
]
```

Response 200:

```text
TaskID: guid
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
  TaxRule: string
  SupplierSKU: string
  Comment: string
  Total: number
]
AdditionalCharges: [
  Description: string
  Reference: string
  Price: number
  Quantity: number
  Discount: number
  Tax: number
  Total: number
  TaxRule: string
]
TotalBeforeTax: number
Tax: number
Total: number
```

### GET `/purchase/stock`

| Parameter | Type | Required |
|---|---|---|
| `TaskID` |  | yes |

Response 200:

```text
TaskID: guid
Status: string
Lines: [
  Date: date
  Quantity: number
  ProductID: guid
  SKU: string
  Name: string
  Location: string
  LocationID: guid
  Received: boolean
  BatchSN: string
  SupplierSKU: string
  ExpiryDate: date
  CardID: guid
]
```

### POST `/`

Request body:

```text
TaskID: guid
Status: string
Lines: [
  Date: date
  Quantity: number
  ProductID: guid
  SKU: string
  Name: string
  Location: string
  LocationID: guid
  Received: boolean
  BatchSN: string
  SupplierSKU: string
  ExpiryDate: date
  CardID: guid
]
```

Response 200:

```text
TaskID: guid
Status: string
Lines: [
  Date: date
  Quantity: number
  ProductID: guid
  SKU: string
  Name: string
  Location: string
  LocationID: guid
  Received: boolean
  BatchSN: string
  SupplierSKU: string
  ExpiryDate: date
  CardID: guid
]
```

### GET `/purchase/invoice`

| Parameter | Type | Required |
|---|---|---|
| `TaskID` |  | yes |

Response 200:

```text
TaskID: guid
CombineAdditionalCharges: boolean
InvoiceDate: date
InvoiceDueDate: date
InvoiceNumber: string
Status: string
Lines: [
  ProductID: guid
  SKU: string
  Name: string
  Quantity: number
  Price: number
  Discount: number
  Tax: number
  TaxRule: string
  Account: string
  Comment: string
  Total: number
]
AdditionalCharges: [
  Description: string
  Reference: string
  Quantity: number
  Price: number
  Discount: number
  Tax: number
  TaxRule: string
  Account: string
  Total: number
]
TotalBeforeTax: number
Tax: number
Total: number
InvoiceTotalAmount: number
InvoiceTotalTaxAmount: number
```

### POST `/`

Request body:

```text
TaskID: guid
CombineAdditionalCharges: boolean
InvoiceDate: date
InvoiceDueDate: date
InvoiceNumber: string
Status: string
Lines: [
  ProductID: guid
  SKU: string
  Name: string
  Quantity: number
  Price: number
  Discount: number
  Tax: number
  TaxRule: string
  Account: string
  Comment: string
  Total: number
]
AdditionalCharges: [
  Description: string
  Reference: string
  Quantity: number
  Price: number
  Discount: number
  Tax: number
  TaxRule: string
  Account: string
  Total: number
]
```

Response 200:

```text
TaskID: guid
CombineAdditionalCharges: boolean
InvoiceDate: date
InvoiceDueDate: date
InvoiceNumber: string
Status: string
Lines: [
  ProductID: guid
  SKU: string
  Name: string
  Quantity: number
  Price: number
  Discount: number
  Tax: number
  TaxRule: string
  Account: string
  Comment: string
  Total: number
]
AdditionalCharges: [
  Description: string
  Reference: string
  Quantity: number
  Price: number
  Discount: number
  Tax: number
  TaxRule: string
  Account: string
  Total: number
]
TotalBeforeTax: number
Tax: number
Total: number
InvoiceTotalAmount: number
InvoiceTotalTaxAmount: number
```

### GET `/purchase/creditnote`

| Parameter | Type | Required |
|---|---|---|
| `TaskID` |  | yes |

Response 200:

```text
TaskID: guid
CombineAdditionalCharges: boolean
CreditNoteNumber: string
CreditNoteDate: date
Status: string
Lines: [
  ProductID: guid
  SKU: string
  Name: string
  Quantity: number
  Price: number
  Discount: number
  Tax: number
  TaxRule: string
  Account: string
  Comment: string
  Total: number
]
AdditionalCharges: [
  Description: string
  Reference: string
  Quantity: number
  Price: number
  Discount: number
  Tax: number
  TaxRule: string
  Account: string
  Total: number
]
Unstock: [
  CardID: guid
  Date: date
  Quantity: number
  ProductID: guid
  SKU: string
  Name: string
  Location: string
  BatchSN: string
  ExpiryDate: date
]
TotalBeforeTax: number
Tax: number
Total: number
```

### POST `/`

Request body:

```text
TaskID: guid
CombineAdditionalCharges: boolean
CreditNoteNumber: string
CreditNoteDate: date
Status: string
Lines: [
  ProductID: guid
  SKU: string
  Name: string
  Quantity: number
  Price: number
  Discount: number
  Tax: number
  TaxRule: string
  Account: string
  Comment: string
  Total: number
]
AdditionalCharges: [
  Description: string
  Reference: string
  Quantity: number
  Price: number
  Discount: number
  Tax: number
  TaxRule: string
  Account: string
  Total: number
]
Unstock: [
  CardID: guid
  Date: date
  Quantity: number
  ProductID: guid
  SKU: string
  Name: string
  Location: string
  BatchSN: string
  ExpiryDate: date
]
```

Response 200:

```text
TaskID: guid
CombineAdditionalCharges: boolean
CreditNoteNumber: string
CreditNoteDate: date
Status: string
Lines: [
  ProductID: guid
  SKU: string
  Name: string
  Quantity: number
  Price: number
  Discount: number
  Tax: number
  TaxRule: string
  Account: string
  Comment: string
  Total: number
]
AdditionalCharges: [
  Description: string
  Reference: string
  Quantity: number
  Price: number
  Discount: number
  Tax: number
  TaxRule: string
  Account: string
  Total: number
]
Unstock: [
  CardID: guid
  Date: date
  Quantity: number
  ProductID: guid
  SKU: string
  Name: string
  Location: string
  BatchSN: string
  ExpiryDate: date
]
TotalBeforeTax: number
Tax: number
Total: number
```

### GET `/purchase/payment`

| Parameter | Type | Required |
|---|---|---|
| `TaskID` |  | yes |

Response 200:

```text
[
  TaskID: guid
  ID: guid
  Type: string
  Reference: string
  Amount: number
  DatePaid: date
  Account: string
  CurrencyRate: number
  DateCreated: date
  DepositID: null
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
DateCreated: date
DepositID: null
```

Response 200:

```text
TaskID: guid
ID: guid
Type: string
Reference: string
Amount: number
DatePaid: date
Account: string
CurrencyRate: number
DateCreated: date
DepositID: null
```

### PUT `/`

Request body:

```text
TaskID: guid
ID: guid
Type: string
Reference: string
Amount: number
DatePaid: date
Account: string
CurrencyRate: number
DateCreated: date
```

Response 200:

```text
TaskID: guid
ID: guid
Type: string
Reference: string
Amount: number
DatePaid: date
Account: string
CurrencyRate: number
DateCreated: date
```

### DELETE `/purchase/payment`

| Parameter | Type | Required |
|---|---|---|
| `ID` | string | yes |
| `DeleteAllocation` | boolean |  |

Response 200:

```text
Success: boolean
```

### GET `/purchase/manualJournal`

| Parameter | Type | Required |
|---|---|---|
| `TaskID` |  | yes |

Response 200:

```text
TaskID: guid
Status: string
Lines: [
  Reference: string
  Amount: number
  Date: date
  Debit: string
  Credit: string
  IsSystem: boolean
]
```

### POST `/`

Request body:

```text
TaskID: guid
Status: string
Lines: [
  Reference: string
  Amount: number
  Date: date
  Debit: string
  Credit: string
  IsSystem: boolean
]
```

Response 200:

```text
TaskID: guid
Status: string
Lines: [
  Reference: string
  Amount: number
  Date: date
  Debit: string
  Credit: string
  IsSystem: boolean
]
```

### GET `/purchase/attachment`

| Parameter | Type | Required |
|---|---|---|
| `TaskID` |  | yes |

Response 200:

```text
TaskID: guid
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
TaskID: guid
Lines: [
  ID: guid
  ContentType: string
  FileName: string
  DownloadUrl: string
]
```

### DELETE `/purchase/attachment`

| Parameter | Type | Required |
|---|---|---|
| `ID` |  |  |

Response 200:

```text
TaskID: guid
Lines: [
  ID: guid
  ContentType: string
  FileName: string
  DownloadUrl: string
]
```

### GET `/advanced-purchase`

| Parameter | Type | Required |
|---|---|---|
| `ID` |  | yes |

Response 200:

```text
ID: guid
SupplierID: guid
Supplier: string
Contact: string
Phone: string
InventoryAccount: string
BlindReceipt: boolean
Approach: string
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
  ShipToOther: boolean
}
BaseCurrency: string
SupplierCurrency: string
TaxRule: string
TaxCalculation: string
Terms: string
RequiredBy: null
Location: string
Note: string
OrderNumber: string
Type: string
CombinedInvoiceStatus: string
CombinedReceivingStatus: string
CombinedPaymentStatus: string
IsServiceOnly: boolean
OrderDate: date
Status: string
RelatedDropShipSaleTask: null
CurrencyRate: number
LastUpdatedDate: date
Order: {
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
    TaxRule: string
    SupplierSKU: string
    Comment: string
    Total: number
    ProductLength: number
    ProductWidth: number
    ProductHeight: number
    ProductWeight: number
    WeightUnits: string
    DimensionsUnits: string
    ProductCustomField1: string
    ProductCustomField2: string
    ProductCustomField3: string
    ProductCustomField4: string
    ProductCustomField5: string
    ProductCustomField6: string
    ProductCustomField7: string
    ProductCustomField8: string
    ProductCustomField9: string
    ProductCustomField10: string
  ]
  AdditionalCharges: []
  Prepayments: []
  TotalBeforeTax: number
  Tax: number
  Total: number
}
StockReceived: [
  TaskID: guid
  InvoicingAndReceivingNumber: number
  Status: string
  Lines: [
    Date: date
    Quantity: number
    ProductID: guid
    SKU: string
    Name: string
    Location: null
    LocationID: null
    Received: boolean
    BatchSN: string
    SupplierSKU: string
    ExpiryDate: null
    CardID: guid
    ProductLength: number
    ProductWidth: number
    ProductHeight: number
    ProductWeight: number
    WeightUnits: string
    DimensionsUnits: string
    ProductCustomField1: string
    ProductCustomField2: string
    ProductCustomField3: string
    ProductCustomField4: string
    ProductCustomField5: string
    ProductCustomField6: string
    ProductCustomField7: string
    ProductCustomField8: string
    ProductCustomField9: string
    ProductCustomField10: string
  ]
]
PutAway: [
  TaskID: guid
  InvoicingAndReceivingNumber: number
  Status: string
  Lines: [
    Date: date
    Quantity: number
    ProductID: guid
    SKU: string
    Name: string
    Location: string
    LocationID: guid
    Received: boolean
    BatchSN: null
    SupplierSKU: string
    ExpiryDate: null
    CardID: guid
    ProductLength: number
    ProductWidth: number
    ProductHeight: number
    ProductWeight: number
    WeightUnits: string
    DimensionsUnits: string
    ProductCustomField1: string
    ProductCustomField2: string
    ProductCustomField3: string
    ProductCustomField4: string
    ProductCustomField5: string
    ProductCustomField6: string
    ProductCustomField7: string
    ProductCustomField8: string
    ProductCustomField9: string
    ProductCustomField10: string
  ]
]
Invoice: [
  TaskID: guid
  InvoicingAndReceivingNumber: number
  InvoiceDate: date
  InvoiceDueDate: date
  InvoiceNumber: string
  Status: string
  Lines: [
    ProductID: guid
    SKU: string
    Name: string
    Quantity: number
    Price: number
    Discount: number
    Tax: number
    TaxRule: string
    Account: string
    Comment: string
    Total: number
    ProductLength: number
    ProductWidth: number
    ProductHeight: number
    ProductWeight: number
    WeightUnits: string
    DimensionsUnits: string
    ProductCustomField1: string
    ProductCustomField2: string
    ProductCustomField3: string
    ProductCustomField4: string
    ProductCustomField5: string
    ProductCustomField6: string
    ProductCustomField7: string
    ProductCustomField8: string
    ProductCustomField9: string
    ProductCustomField10: string
  ]
  AdditionalCharges: []
  Payments: [
    ID: guid
    Reference: string
    Amount: number
    DatePaid: date
    Account: string
    CurrencyRate: number
    DateCreated: date
  ]
  TotalBeforeTax: number
  Tax: number
  Total: number
  Paid: number
]
CreditNote: [
  TaskID: guid
  CreditNoteInvoiceNumber: string
  CreditNoteNumber: string
  CreditNoteDate: date
  Status: string
  Lines: [
    ProductID: guid
    SKU: string
    Name: string
    Quantity: number
    Price: number
    Discount: number
    Tax: number
    TaxRule: string
    Account: string
    Comment: string
    Total: number
    ProductLength: number
    ProductWidth: number
    ProductHeight: number
    ProductWeight: number
    WeightUnits: string
    DimensionsUnits: string
    ProductCustomField1: string
    ProductCustomField2: string
    ProductCustomField3: string
    ProductCustomField4: string
    ProductCustomField5: string
    ProductCustomField6: string
    ProductCustomField7: string
    ProductCustomField8: string
    ProductCustomField9: string
    ProductCustomField10: string
  ]
  AdditionalCharges: []
  Refunds: [
    ID: guid
    Reference: string
    Amount: number
    DatePaid: date
    Account: string
    CurrencyRate: number
    DateCreated: date
  ]
  Unstock: [
    CardID: guid
    Date: date
    Quantity: number
    ProductID: guid
    SKU: string
    Name: string
    Location: string
    BatchSN: null
    ExpiryDate: null
    ProductLength: number
    ProductWidth: number
    ProductHeight: number
    ProductWeight: number
    WeightUnits: string
    DimensionsUnits: string
    ProductCustomField1: string
    ProductCustomField2: string
    ProductCustomField3: string
    ProductCustomField4: string
    ProductCustomField5: string
    ProductCustomField6: string
    ProductCustomField7: string
    ProductCustomField8: string
    ProductCustomField9: string
    ProductCustomField10: string
  ]
  TotalBeforeTax: number
  Tax: number
  Total: number
]
ManualJournals: [
  TaskID: guid
  InvoicingAndReceivingNumber: number
  Status: string
  Lines: [
    Reference: string
    Amount: number
    Date: date
    Debit: string
    Credit: string
    IsSystem: boolean
  ]
]
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
Attachments: []
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
  ProductCustomField1: string
  ProductCustomField2: string
  ProductCustomField3: string
  ProductCustomField4: string
  ProductCustomField5: string
  ProductCustomField6: string
  ProductCustomField7: string
  ProductCustomField8: string
  ProductCustomField9: string
  ProductCustomField10: string
]
```

### POST `/`

Request body:

```text
SupplierID: guid
Supplier: string
TaxRule: string
TaxCalculation: string
Terms: string
Approach: string
BlindReceipt: boolean
Contact: string
Phone: string
CurrencyRate: number
Location: string
PurchaseType: string
Note: string
RequiredBy: null
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
  ShipToOther: boolean
}
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
```

Response 200:

```text
ID: guid
SupplierID: guid
Supplier: string
Contact: string
Phone: null
InventoryAccount: string
BlindReceipt: boolean
Approach: string
BillingAddress: {
  DisplayAddressLine1: string
  DisplayAddressLine2: string
  Line1: null
  Line2: null
  City: null
  State: null
  Postcode: null
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
  ShipToOther: boolean
}
BaseCurrency: string
SupplierCurrency: string
TaxRule: string
TaxCalculation: string
Terms: string
RequiredBy: null
Location: string
Note: string
OrderNumber: string
Type: string
CombinedInvoiceStatus: string
CombinedReceivingStatus: string
CombinedPaymentStatus: string
IsServiceOnly: boolean
OrderDate: date
Status: string
RelatedDropShipSaleTask: null
CurrencyRate: number
LastUpdatedDate: date
Order: {
  Memo: string
  Status: string
  Lines: []
  AdditionalCharges: []
  Prepayments: []
  TotalBeforeTax: number
  Tax: number
  Total: number
}
StockReceived: [
  TaskID: guid
  InvoicingAndReceivingNumber: number
  Status: string
  Lines: []
]
PutAway: [
  TaskID: guid
  InvoicingAndReceivingNumber: number
  Status: string
  Lines: []
]
Invoice: [
  TaskID: guid
  InvoicingAndReceivingNumber: number
  InvoiceDate: null
  InvoiceDueDate: null
  InvoiceNumber: string
  Status: string
  Lines: []
  AdditionalCharges: []
  Payments: []
  TotalBeforeTax: number
  Tax: number
  Total: number
  Paid: number
]
CreditNote: [
  TaskID: guid
  CreditNoteInvoiceNumber: string
  CreditNoteNumber: string
  CreditNoteDate: null
  Status: string
  Lines: []
  AdditionalCharges: []
  Refunds: []
  Unstock: []
  TotalBeforeTax: number
  Tax: number
  Total: number
]
ManualJournals: [
  TaskID: guid
  InvoicingAndReceivingNumber: number
  Status: string
  Lines: []
]
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
Attachments: []
InventoryMovements: []
```

### PUT `/`

Request body:

```text
ID: guid
SupplierID: guid
Supplier: string
TaxRule: string
TaxCalculation: string
Terms: string
BlindReceipt: boolean
Contact: string
Phone: string
CurrencyRate: number
Location: string
Note: string
RequiredBy: null
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
  ShipToOther: boolean
}
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
```

Response 200:

```text
ID: guid
SupplierID: guid
Supplier: string
Contact: string
Phone: string
InventoryAccount: string
BlindReceipt: boolean
Approach: string
BillingAddress: {
  DisplayAddressLine1: string
  DisplayAddressLine2: string
  Line1: null
  Line2: null
  City: null
  State: null
  Postcode: null
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
  ShipToOther: boolean
}
BaseCurrency: string
SupplierCurrency: string
TaxRule: string
TaxCalculation: string
Terms: string
RequiredBy: null
Location: string
Note: string
OrderNumber: string
Type: string
CombinedInvoiceStatus: string
CombinedReceivingStatus: string
CombinedPaymentStatus: string
IsServiceOnly: boolean
OrderDate: date
Status: string
RelatedDropShipSaleTask: null
CurrencyRate: number
LastUpdatedDate: date
Order: {
  Memo: string
  Status: string
  Lines: []
  AdditionalCharges: []
  Prepayments: []
  TotalBeforeTax: number
  Tax: number
  Total: number
}
StockReceived: [
  TaskID: guid
  InvoicingAndReceivingNumber: number
  Status: string
  Lines: []
]
PutAway: [
  TaskID: guid
  InvoicingAndReceivingNumber: number
  Status: string
  Lines: []
]
Invoice: [
  TaskID: guid
  InvoicingAndReceivingNumber: number
  InvoiceDate: null
  InvoiceDueDate: null
  InvoiceNumber: string
  Status: string
  Lines: []
  AdditionalCharges: []
  Payments: []
  TotalBeforeTax: number
  Tax: number
  Total: number
  Paid: number
]
CreditNote: [
  TaskID: guid
  CreditNoteInvoiceNumber: string
  CreditNoteNumber: string
  CreditNoteDate: null
  Status: string
  Lines: []
  AdditionalCharges: []
  Refunds: []
  Unstock: []
  TotalBeforeTax: number
  Tax: number
  Total: number
]
ManualJournals: [
  TaskID: guid
  InvoicingAndReceivingNumber: number
  Status: string
  Lines: []
]
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
Attachments: []
InventoryMovements: []
```

### DELETE `/advanced-purchase`

| Parameter | Type | Required |
|---|---|---|
| `ID` |  | yes |
| `Void` | boolean |  |

Response 200:

```text
ID: guid
SupplierID: guid
Supplier: string
Contact: string
Phone: string
InventoryAccount: string
BlindReceipt: boolean
Approach: string
BillingAddress: {
  DisplayAddressLine1: string
  DisplayAddressLine2: string
  Line1: null
  Line2: null
  City: null
  State: null
  Postcode: null
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
  ShipToOther: boolean
}
BaseCurrency: string
SupplierCurrency: string
TaxRule: string
TaxCalculation: string
Terms: string
RequiredBy: null
Location: string
Note: string
OrderNumber: string
Type: string
CombinedInvoiceStatus: string
CombinedReceivingStatus: string
CombinedPaymentStatus: string
IsServiceOnly: boolean
OrderDate: date
Status: string
RelatedDropShipSaleTask: null
CurrencyRate: number
LastUpdatedDate: date
Order: {
  Memo: string
  Status: string
  Lines: []
  AdditionalCharges: []
  Prepayments: []
  TotalBeforeTax: number
  Tax: number
  Total: number
}
StockReceived: [
  TaskID: guid
  InvoicingAndReceivingNumber: number
  Status: string
  Lines: []
]
PutAway: [
  TaskID: guid
  InvoicingAndReceivingNumber: number
  Status: string
  Lines: []
]
Invoice: [
  TaskID: guid
  InvoicingAndReceivingNumber: number
  InvoiceDate: null
  InvoiceDueDate: null
  InvoiceNumber: string
  Status: string
  Lines: []
  AdditionalCharges: []
  Payments: []
  TotalBeforeTax: number
  Tax: number
  Total: number
  Paid: number
]
CreditNote: [
  TaskID: guid
  CreditNoteInvoiceNumber: string
  CreditNoteNumber: string
  CreditNoteDate: null
  Status: string
  Lines: []
  AdditionalCharges: []
  Refunds: []
  Unstock: []
  TotalBeforeTax: number
  Tax: number
  Total: number
]
ManualJournals: [
  TaskID: guid
  InvoicingAndReceivingNumber: number
  Status: string
  Lines: []
]
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
Attachments: []
InventoryMovements: []
```

### GET `/advanced-purchase/stock`

| Parameter | Type | Required |
|---|---|---|
| `PurchaseID` |  | yes |

Response 200:

```text
PurchaseID: guid
StockReceiving: [
  TaskID: guid
  Status: string
  Lines: [
    Date: date
    Quantity: number
    ProductID: guid
    SKU: string
    Name: string
    LocationID: null
    Location: null
    Received: boolean
    BatchSN: string
    SupplierSKU: string
    ExpiryDate: date
  ]
]
```

### POST `/`

Request body:

```text
PurchaseID: guid
TaskID: guid
Status: string
Lines: [
  Date: date
  Quantity: number
  ProductID: guid
  SKU: string
  Name: string
  LocationID: null
  Location: null
  Received: boolean
  BatchSN: string
  SupplierSKU: string
  ExpiryDate: date
]
```

Response 200:

```text
PurchaseID: guid
StockReceiving: [
  TaskID: guid
  Status: string
  Lines: [
    Date: date
    Quantity: number
    ProductID: guid
    SKU: string
    Name: string
    LocationID: null
    Location: null
    Received: boolean
    BatchSN: string
    SupplierSKU: string
    ExpiryDate: null
  ]
]
```

### PUT `/`

Request body:

```text
PurchaseID: guid
TaskID: guid
Status: string
Lines: [
  Date: date
  Quantity: number
  ProductID: guid
  SKU: string
  Name: string
  LocationID: null
  Location: null
  Received: boolean
  BatchSN: string
  SupplierSKU: string
  ExpiryDate: date
]
```

Response 200:

```text
PurchaseID: guid
StockReceiving: [
  TaskID: guid
  Status: string
  Lines: [
    Date: date
    Quantity: number
    ProductID: guid
    SKU: string
    Name: string
    LocationID: null
    Location: null
    Received: boolean
    BatchSN: string
    SupplierSKU: string
    ExpiryDate: null
  ]
]
```

### DELETE `/advanced-purchase/stock`

| Parameter | Type | Required |
|---|---|---|
| `TaskID` |  | yes |
| `Void` | boolean |  |

Response 200:

```text
PurchaseID: guid
StockReceiving: [
  TaskID: guid
  Status: string
  Lines: [
    Date: date
    Quantity: number
    ProductID: guid
    SKU: string
    Name: string
    LocationID: null
    Location: null
    Received: boolean
    BatchSN: string
    SupplierSKU: string
    ExpiryDate: null
  ]
]
```

### GET `/advanced-purchase/put-away`

| Parameter | Type | Required |
|---|---|---|
| `PurchaseID` |  | yes |

Response 200:

```text
PurchaseID: guid
PutAway: [
  TaskID: guid
  Status: string
  Lines: [
    Date: date
    Quantity: number
    ProductID: guid
    SKU: string
    Name: string
    LocationID: guid
    Location: string
    Received: boolean
    BatchSN: null
    SupplierSKU: string
    ExpiryDate: null
  ]
]
```

### POST `/`

Request body:

```text
PurchaseID: guid
TaskID: guid
Status: string
Lines: [
  Date: date
  Quantity: number
  ProductID: guid
  SKU: string
  Name: string
  LocationID: guid
  Location: string
  Received: boolean
  BatchSN: string
  SupplierSKU: string
  ExpiryDate: date
]
```

Response 200:

```text
PurchaseID: guid
PutAway: [
  TaskID: guid
  Status: string
  Lines: [
    Date: date
    Quantity: number
    ProductID: guid
    SKU: string
    Name: string
    LocationID: guid
    Location: string
    Received: boolean
    BatchSN: null
    SupplierSKU: string
    ExpiryDate: null
  ]
]
```

### GET `/advanced-purchase/invoice`

| Parameter | Type | Required |
|---|---|---|
| `PurchaseID` |  | yes |

Response 200:

```text
PurchaseID: guid
Invoices: [
  TaskID: guid
  CombineAdditionalCharges: boolean
  InvoiceDate: date
  InvoiceDueDate: date
  InvoiceNumber: string
  Status: string
  Lines: [
    ProductID: guid
    SKU: string
    Name: string
    Quantity: number
    Price: number
    Discount: number
    Tax: number
    TaxRule: string
    Account: string
    Comment: string
    Total: number
  ]
  AdditionalCharges: []
  TotalBeforeTax: number
  Tax: number
  Total: number
  InvoiceTotalAmount: number
  InvoiceTotalTaxAmount: number
]
```

### POST `/`

Request body:

```text
PurchaseID: guid
TaskID: guid
CombineAdditionalCharges: boolean
InvoiceDate: date
InvoiceDueDate: date
InvoiceNumber: string
Status: string
Lines: [
  ProductID: guid
  SKU: string
  Name: string
  Quantity: number
  Price: number
  Discount: number
  Tax: number
  TaxRule: string
  Account: string
  Comment: string
  Total: number
]
AdditionalCharges: []
TotalBeforeTax: number
Tax: number
Total: number
InvoiceTotalAmount: number
InvoiceTotalTaxAmount: number
```

Response 200:

```text
PurchaseID: guid
Invoices: [
  TaskID: guid
  CombineAdditionalCharges: boolean
  InvoiceDate: date
  InvoiceDueDate: date
  InvoiceNumber: string
  Status: string
  Lines: [
    ProductID: guid
    SKU: string
    Name: string
    Quantity: number
    Price: number
    Discount: number
    Tax: number
    TaxRule: string
    Account: string
    Comment: string
    Total: number
  ]
  AdditionalCharges: []
  TotalBeforeTax: number
  Tax: number
  Total: number
  InvoiceTotalAmount: number
  InvoiceTotalTaxAmount: number
]
```

### DELETE `/advanced-purchase/invoice`

| Parameter | Type | Required |
|---|---|---|
| `TaskID` |  | yes |
| `Void` | boolean |  |

Response 200:

```text
PurchaseID: guid
Invoices: [
  TaskID: guid
  CombineAdditionalCharges: boolean
  InvoiceDate: date
  InvoiceDueDate: date
  InvoiceNumber: string
  Status: string
  Lines: []
  AdditionalCharges: []
  TotalBeforeTax: number
  Tax: number
  Total: number
  InvoiceTotalAmount: number
  InvoiceTotalTaxAmount: number
]
```

### GET `/advanced-purchase/creditnote`

| Parameter | Type | Required |
|---|---|---|
| `PurchaseID` |  | yes |

Response 200:

```text
PurchaseID: guid
CreditNotes: [
  TaskID: guid
  CombineAdditionalCharges: boolean
  CreditNoteNumber: string
  CreditNoteInvoiceNumber: string
  CreditNoteDate: date
  Status: string
  Lines: [
    ProductID: guid
    SKU: string
    Name: string
    Quantity: number
    Price: number
    Discount: number
    Tax: number
    TaxRule: string
    Account: string
    Comment: string
    Total: number
  ]
  AdditionalCharges: [
    Description: string
    Reference: string
    Quantity: number
    Price: number
    Discount: number
    Tax: number
    TaxRule: string
    Account: string
    Total: number
  ]
  Unstock: [
    CardID: guid
    Date: date
    Quantity: number
    ProductID: guid
    SKU: string
    Name: string
    Location: string
    BatchSN: null
    ExpiryDate: null
  ]
  TotalBeforeTax: number
  Tax: number
  Total: number
]
```

### POST `/`

Request body:

```text
PurchaseID: guid
TaskID: guid
CombineAdditionalCharges: boolean
CreditNoteNumber: string
CreditNoteInvoiceNumber: string
CreditNoteDate: date
Status: string
Lines: [
  ProductID: guid
  SKU: string
  Name: string
  Quantity: number
  Price: number
  Discount: number
  Tax: number
  TaxRule: string
  Account: string
  Comment: string
  Total: number
]
AdditionalCharges: [
  Description: string
  Reference: string
  Quantity: number
  Price: number
  Discount: number
  Tax: number
  TaxRule: string
  Account: string
  Total: number
]
Unstock: [
  CardID: guid
  Date: date
  Quantity: number
  ProductID: guid
  SKU: string
  Name: string
  Location: string
  BatchSN: null
  ExpiryDate: null
]
TotalBeforeTax: number
Tax: number
Total: number
```

Response 200:

```text
PurchaseID: guid
CreditNotes: [
  TaskID: guid
  CombineAdditionalCharges: boolean
  CreditNoteNumber: string
  CreditNoteInvoiceNumber: string
  CreditNoteDate: date
  Status: string
  Lines: [
    ProductID: guid
    SKU: string
    Name: string
    Quantity: number
    Price: number
    Discount: number
    Tax: number
    TaxRule: string
    Account: string
    Comment: string
    Total: number
  ]
  AdditionalCharges: []
  Unstock: [
    CardID: guid
    Date: date
    Quantity: number
    ProductID: guid
    SKU: string
    Name: string
    Location: string
    BatchSN: string
    ExpiryDate: date
  ]
  TotalBeforeTax: number
  Tax: number
  Total: number
]
```

### DELETE `/advanced-purchase/creditnote`

| Parameter | Type | Required |
|---|---|---|
| `TaskID` |  | yes |

Response 200:

```text
PurchaseID: guid
CreditNotes: [
  TaskID: guid
  CombineAdditionalCharges: boolean
  CreditNoteNumber: string
  CreditNoteInvoiceNumber: string
  CreditNoteDate: date
  Status: string
  Lines: []
  AdditionalCharges: []
  Unstock: []
  TotalBeforeTax: number
  Tax: number
  Total: number
]
```

### GET `/advanced-purchase/payment`

| Parameter | Type | Required |
|---|---|---|
| `PurchaseID` |  |  |
| `OrderNumber` |  |  |
| `InvoiceNumber` |  |  |
| `CreditNoteNumber` |  |  |

Response 200:

```text
[
  PurchaseID: guid
  TaskID: guid
  ID: guid
  Type: string
  Reference: string
  Amount: number
  DatePaid: date
  Account: string
  CurrencyRate: number
  DateCreated: date
  DepositID: null
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
DateCreated: date
DepositID: null
```

Response 200:

```text
PurchaseID: guid
TaskID: guid
ID: guid
Type: string
Reference: string
Amount: number
DatePaid: date
Account: string
CurrencyRate: number
DateCreated: date
DepositID: null
```

### PUT `/`

Request body:

```text
TaskID: guid
ID: guid
Type: string
Reference: string
Amount: number
DatePaid: date
Account: string
CurrencyRate: number
DateCreated: date
```

Response 200:

```text
PurchaseID: guid
TaskID: guid
ID: guid
Type: string
Reference: string
Amount: number
DatePaid: date
Account: string
CurrencyRate: number
DateCreated: date
```

### DELETE `/purchase/payment`

| Parameter | Type | Required |
|---|---|---|
| `ID` | string | yes |
| `DeleteAllocation` | boolean |  |

Response 200:

```text
Success: boolean
```

### GET `/advanced-purchase/manualJournal`

| Parameter | Type | Required |
|---|---|---|
| `PurchaseID` |  | yes |

Response 200:

```text
PurchaseID: guid
ManualJournals: [
  TaskID: guid
  Status: string
  Lines: [
    Reference: string
    Amount: number
    Date: date
    Debit: string
    Credit: string
    IsSystem: boolean
  ]
]
```

### POST `/`

Request body:

```text
PurchaseID: guid
TaskID: guid
Status: string
Lines: [
  Reference: string
  Amount: number
  Date: date
  Debit: string
  Credit: string
  IsSystem: boolean
]
```

Response 200:

```text
PurchaseID: guid
ManualJournals: [
  TaskID: guid
  Status: string
  Lines: [
    Reference: string
    Amount: number
    Date: date
    Debit: string
    Credit: string
    IsSystem: boolean
  ]
]
```

