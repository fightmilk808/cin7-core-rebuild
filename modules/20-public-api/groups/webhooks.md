# Webhook payloads

The body Cin7 POSTs for each event, as a type outline. Delivery: up to 6 attempts (1, then 5, 10, 15, 20 and 25 minutes apart), after which the webhook is deactivated; at most 5 webhooks of one type. Subscriptions can carry extra headers (`ExternalHeaders`).

## `Sale/Created`

```text
SaleID: guid
SaleOrderNumber: string
CustomerName: string
CustomerContactName: string
CustomerContactEmail: string
SaleRepEmail: string
SaleOrderDate: date
TaskTypeSign: string
IsServiceOnly: string
DownloadLink: null
EventType: string
```

## `Sale/QuoteAuthorised`

```text
SaleID: guid
SaleOrderNumber: string
EventType: string
```

## `Sale/OrderAuthorised`

```text
SaleID: guid
SaleOrderNumber: string
EventType: string
```

## `Sale/Voided`

```text
SaleID: guid
SaleOrderNumber: string
EventType: string
CustomerName: string
CustomerContactName: string
CustomerContactEmail: string
```

## `Sale/Backordered`

```text
SaleID: guid
SaleOrderNumber: string
EventType: string
```

## `Sale/ShipmentAuthorised`

```text
keys: CustomerContactEmail, CustomerContactName, CustomerName, EventType, OrderNumber, SaleTaskID, TenantID
```

## `Sale/InvoiceAuthorised`

```text
SaleTaskID: guid
TenantID: guid
OrderNumber: string
InvoiceNumber: string
CustomerName: string
CustomerContactName: string
CustomerContactEmail: string
EventType: string
```

## `Sale/PickAuthorised`

```text
SaleID: guid
SaleOrderNumber: string
TaskID: guid
CustomerName: string
CustomerContactName: string
CustomerContactEmail: string
EventType: string
```

## `Sale/PackAuthorised`

```text
SaleID: guid
SaleOrderNumber: string
TaskID: guid
CustomerName: string
CustomerContactName: string
CustomerContactEmail: string
EventType: string
```

## `Sale/CreditNoteAuthorised`

```text
SaleID: guid
SaleOrderNumber: string
CreditNoteNumber: string
TaskID: guid
CustomerName: string
CustomerContactName: string
CustomerContactEmail: string
EventType: string
```

## `Sale/Undo`

```text
SaleID: guid
SaleOrderNumber: string
CustomerContactName: string
CustomerContactEmail: string
EventType: string
```

## `Sale/PartialPaymentReceived`

```text
SaleID: guid
DocumentNumber: string
DocumentType: string
DocumentDate: string
CustomerName: string
CustomerContactName: string
CustomerContactEmail: string
AmountPercent: string
EventType: string
```

## `Sale/FullPaymentReceived`

```text
SaleID: guid
DocumentNumber: string
DocumentType: string
DocumentDate: string
CustomerName: string
CustomerContactName: string
CustomerContactEmail: string
EventType: string
```

## `Sale/AttachmentAdded`

```text
keys: BlobGUID, ContentType, CustomerContactEmail, CustomerContactName, CustomerName, DownloadFileLink, DownloadFileUrl, EventType, FileName, IsServiceOnly, SaleID, SaleOrderNumber, SaleRepEmail, TaskTypeSign
```

## `Sale/AdditionalAttributesChanged`

```text
SaleID: guid
CustomerName: string
CustomerContactName: string
CustomerContactEmail: string
EventType: string
SaleOrderNumber: string
SaleRepEmail: string
Changes: {
  Field: string
  Result: string
  OldValue: string
  NewValue: string
}
```

## `Sale/ShipmentTrackingNumberChanged`

```text
SaleID: guid
TaskID: guid
SaleOrderNumber: string
SaleOrderDate: string
CustomerContact: string
CustomerEmail: string
CustomerName: string
TaskTypeSign: number
Shipments: [
  ShipmentDate: string
  TrackingNumber: string
  TrackingUrl: string
  Carrier: string
]
EventType: string
```

## `Purchase/OrderAuthorised`

```text
TaskID: guid
PurchaseOrderNumber: string
SupplierName: string
SupplierContactName: string
SupplierContactEmail: string
EventType: string
```

## `Purchase/InvoiceAuthorised`

```text
TaskID: guid
PurchaseOrderNumber: string
InvoiceNumber: string
SupplierName: null
SupplierContactName: null
SupplierContactEmail: null
EventType: string
```

## `Purchase/StockReceivedAuthorised`

```text
TaskID: guid
PurchaseOrderNumber: string
InvoiceNumber: string
SupplierName: null
SupplierContactName: null
SupplierContactEmail: null
EventType: string
```

## `Purchase/CreditNoteAuthorised`

```text
TaskID: guid
PurchaseOrderNumber: string
CreditNoteNumber: string
SupplierName: null
SupplierContactName: null
SupplierContactEmail: null
EventType: string
```

## `Purchase/Updated`

```text
NumberOfPurchase: number
CustomerDetailsList: [
  ID: guid
  SupplierID: guid
  Supplier: string
  Contact: string
  Phone: null
  InventoryAccount: null
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
    Company: null
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
]
EventType: string
```

## `Customer/Updated`

```text
NumberOfCustomers: number
CustomerDetailsList: [
  Customer: {
    ID: guid
    Name: string
    Currency: string
    PaymentTerm: string
    Discount: number
    TaxRule: string
    Carrier: null
    SalesRepresentative: null
    Location: string
    Comments: string
    AccountReceivable: string
    RevenueAccount: string
    PriceTier: string
    TaxNumber: string
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
    AttributeSet: null
    Tags: string
    Status: string
    LastModifiedOn: date
    CreditLimit: number
  }
  Addresses: []
  Contacts: [
    ID: guid
    CustomerID: guid
    Name: string
    JobTitle: null
    Phone: null
    MobilePhone: string
    Fax: null
    Email: null
    Website: null
    Default: boolean
    Comment: null
    IncludeInEmail: boolean
  ]
]
EventType: string
```

## `Supplier/Updated`

```text
NumberOfSuppliers: number
SupplierDetailsList: [
  Supplier: {
    ID: guid
    Name: string
    Currency: string
    PaymentTerm: string
    TaxRule: string
    Discount: number
    Comments: string
    AccountPayable: string
    TaxNumber: string
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
    AttributeSet: null
    Status: string
    LastModifiedOn: date
  }
  Addresses: []
  Contacts: [
    ID: guid
    SupplierID: guid
    Name: string
    Phone: string
    Fax: null
    Email: string
    Website: null
    Default: boolean
    Comment: null
    IncludeInEmail: boolean
  ]
]
EventType: string
```

## `Stock/AvailableStockLevelChanged`

```text
[
  ID: guid
  SKU: string
  Name: string
  Barcode: string
  Location: string
  Bin: null
  Batch: null
  ExpiryDate: null
  Category: string
  OnHand: number
  Allocated: number
  Available: number
  OnOrder: number
  StockOnHand: number
  MaxRows: number
]
```

## `Product/Updated`

```text
NumberOfProducts: number
ProductDetailsList: [
  Event: string
  ID: guid
  SKU: string
  Name: string
  Category: string
  Brand: null
  Type: string
  CostingMethod: string
  DropShipMode: string
  DefaultLocation: string
  Length: number
  Width: number
  Height: number
  Weight: number
  UOM: string
  WeightUnits: string
  DimensionsUnits: string
  Barcode: string
  MinimumBeforeReorder: number
  ReorderQuantity: number
  PriceTier1: number
  PriceTier2: number
  PriceTier3: number
  PriceTier4: number
  PriceTier5: number
  PriceTier6: number
  PriceTier7: number
  PriceTier8: number
  PriceTier9: number
  PriceTier10: number
  PriceTiers: {
    Tier 1: number
    Tier 2: number
    Tier 3: number
    Tier 4: number
    Tier 5: number
    Tier 6: number
    Tier 7: number
    Tier 8: number
    Tier 9: number
    Tier 10: number
  }
  AverageCost: number
  ShortDescription: string
  InternalNote: string
  Description: string
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
  AttributeSet: null
  DiscountRule: null
  Tags: string
  Status: string
  StockLocator: string
  COGSAccount: null
  RevenueAccount: null
  ExpenseAccount: null
  InventoryAccount: null
  PurchaseTaxRule: null
  SaleTaxRule: null
  LastModifiedOn: date
  Sellable: boolean
  PickZones: string
  BillOfMaterial: boolean
  AutoAssembly: boolean
  AutoDisassembly: boolean
  QuantityToProduce: number
  AlwaysShowQuantity: number
  AssemblyInstructionURL: string
  AssemblyCostEstimationMethod: string
  BOMType: string
  WarrantyName: null
  HSCode: null
  CountryOfOrigin: null
  CountryOfOriginCode: null
  CreatedDate: date
]
EventType: string
```

## `Lead/Updated`

```text
NumberOfLeads: number
LeadsDetailsList: [
  Event: string
  LeadID: guid
  Name: string
  Currency: string
  Comments: string
  LeadStatus: string
  CloseChance: number
  PriceTier: number
  Amount: number
  CloseDate: date
  Addresses: []
  Contacts: []
]
EventType: string
```

## `Lead/Converted`

```text
LeadID: guid
LeadName: string
LeadContactName: null
LeadContactEmail: null
EventType: string
```

## `Opportunity/Authorized`

```text
OpportunityID: guid
OpportunityNumber: string
CustomerOrLeadName: string
CustomerOrLeadContactName: string
CustomerOrLeadContactEmail: string
SaleRepName: string
SaleRepEmail: string
EventType: string
```

## `Opportunity/AttachmentAdded`

```text
keys: BlobGUID, ContentType, CustomerOrLeadContactEmail, CustomerOrLeadContactName, CustomerOrLeadName, DownloadFileLink, DownloadFileUrl, EventType, FileName, OpportunityID, OpportunityNumber, SaleRepEmail, SaleRepName
```

## `Opportunity/Voided`

```text
OpportunityID: guid
OpportunityNumber: string
CustomerOrLeadName: string
CustomerOrLeadContactName: string
CustomerOrLeadContactEmail: string
SaleRepEmail: string
EventType: string
```

## `Opportunity/Converted`

```text
OpportunityID: guid
OpportunityNumber: string
CustomerOrLeadName: string
CustomerOrLeadContactName: string
CustomerOrLeadContactEmail: string
SaleRepEmail: string
SaleOrderNumber: string
EventType: string
```

## `Task/Overdue`

```text
[
  TaskID: guid
  Name: string
  AssingedTo: string
  Entity: string
  DueDate: string
  Status: string
]
```

