# Public API: Reference Books

From Cin7's API Blueprint: field tables (name, type, length, required, allowed values), each operation's query parameters, and request and response bodies as type outlines (`guid`, `string`, `number`, `boolean`, `date`, `null`; `[ … ]` = array of). Base `/ExternalApi/v2`; headers in [docs/PUBLIC-API.md](../../../docs/PUBLIC-API.md).

**Resources:** `/custom-prices` · `/reference/deals` · `/reference/discount` · `/product-suppliers` · `/reference/shipZones` · `/reference/shipZonesEnabled`

## Fields

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

#### Product Deal Customer

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `ID` | Guid |  | Yes* |  |
| `CustomerName` | String |  | Yes* |  |
| `CustomerID` | Guid |  | Yes* |  |

#### Product Deal Customer Tag

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `ID` | Guid |  | Yes* |  |
| `TagName` | String |  | Yes* |  |

#### Product Deal Discount

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `ID` | Guid |  | Yes* |  |
| `DiscountID` | Guid |  | Yes* |  |
| `DiscountName` | String |  | Yes* |  |
| `DiscountType` | String |  | Yes |  |
| `Sequence` | Int |  |  |  |
| `IsOrderLevel` | Bool |  | Yes |  |
| `BuyType` | String |  |  |  |
| `BuyValue` | Decimal |  |  |  |
| `BuyValueType` | String |  |  |  |
| `BuyMore` | Bool |  |  |  |
| `GetType` | String |  |  |  |
| `GetValue` | Decimal |  |  |  |
| `GetValueType` | String |  |  |  |
| `BuyMore` | Bool |  |  |  |
| `DealDiscountBrands` | [] Deal Discount Brand Model |  |  |  |
| `DealDiscountCategories` | [] Deal Discount Category Model |  |  |  |
| `DealDiscountTags` | [] Deal Discount Tag Model |  |  |  |
| `DealDiscountProducts` | [] Deal Discount Product Model |  |  |  |

#### Product Deal Discount Brand

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `ID` | Guid |  | Yes* |  |
| `BrandName` | String |  | Yes* |  |
| `BrandID` | Guid |  | Yes* |  |
| `Type` | String |  | Yes |  |

#### Product Deal Discount Product

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `ID` | Guid |  | Yes* |  |
| `ProductSKU` | String |  | Yes* |  |
| `ProductID` | Guid |  | Yes* |  |
| `ProductName` | String |  |  |  |
| `IsFamily` | Bool |  | Yes |  |
| `Type` | String |  | Yes |  |

#### Product Deal Discount Tag

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `ID` | Guid |  | Yes* |  |
| `TagName` | String |  | Yes* |  |
| `Type` | String |  | Yes |  |

#### Product Deal Discount Category

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `ID` | Guid |  | Yes* |  |
| `CategoryName` | String |  | Yes* |  |
| `Type` | String |  | Yes |  |

#### Product Discount Rule

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `ID` | Guid |  | Yes |  |
| `Name` | String | 128 | Yes |  |
| `IsActive` | Bool |  | Yes |  |
| `Type` | String |  | Yes |  |
| `DiscountLines` | [] Discount Line Model |  |  |  |

#### Discount Line Model

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `ID` | Guid |  | Yes |  |
| `MinValue` | Decimal |  |  |  |
| `MaxValue` | Decimal |  |  |  |
| `DiscountType` | String |  |  |  |
| `Amount` | Decimal |  | Yes* |  |
| `OrderExceeds` | Decimal |  | Yes* |  |

#### Shipping Zone

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `ZoneID` | Guid |  | Yes |  |
| `Name` | String | 128 | Yes |  |
| `IsRestZone` | Bool |  | Yes |  |
| `PricesInclTax` | Bool |  | Yes |  |
| `Negative` | Bool |  | Yes |  |
| `DefaultShippingCost` | Decimal |  | Yes |  |
| `ShortDesc` | Bool |  |  |  |
| `TaxRuleID` | Guid |  | Yes* |  |
| `TaxRuleName` | String | 255 | Yes* |  |
| `AppliesTo` | [] Applies To Model |  |  |  |
| `Conditions` | [] Condition Model |  |  |  |

#### Applies To Model

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `ID` | Guid |  | Yes |  |
| `Country2` | String |  |  |  |
| `StateID` | Int |  |  |  |
| `StateName` | String |  |  |  |
| `PostCodeFrom` | String | 100 |  |  |
| `PostCodeTo` | String | 100 |  |  |
| `PostCodesList` | String |  |  |  |
| `ShippingRate` | Decimal |  | Yes |  |

#### Condition Model

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `ZoneConditionID` | Guid |  | Yes |  |
| `MinValue` | Decimal |  |  |  |
| `MaxValue` | Decimal |  |  |  |
| `ShippingCost` | Decimal |  | Yes |  |
| `ConditionType` | String |  | Yes |  |
| `ConditionDescription` | String | 128 |  |  |

## Operations

### POST `/custom-prices`

Request body:

```text
CustomPrices: [
  CustomerID: guid
  ProductSKU: string
  Price: number
]
```

Response 200:

```text
Errors: []
```

### PUT `/custom-prices`

Request body:

```text
CustomPrices: [
  CustomerID: guid
  ProductSKU: string
  Price: number
]
```

Response 200:

```text
Errors: []
```

### DELETE `/custom-prices`

| Parameter | Type | Required |
|---|---|---|
| `ProductID` | guid | yes |
| `CustomerID` | guid | yes |

Response 200:

```text
Success: boolean
```

### GET `/reference/deals`

| Parameter | Type | Required |
|---|---|---|
| `ID` |  |  |
| `Page` | number |  |
| `Limit` | number |  |
| `Search` | string |  |

Response 200:

```text
Deals: [
  ID: guid
  Name: string
  DateFrom: date
  DateTo: date
  IsActive: boolean
  AllowCoupons: boolean
  SingleCouponCodeUsage: boolean
  CustomersGroup: string
  CouponCodes: string
  DealCustomers: []
  DealCustomerTags: []
  DealDiscounts: [
    ID: guid
    DiscountName: string
    DiscountType: string
    DiscountID: guid
    Sequence: number
    IsOrderLevel: boolean
    BuyType: string
    BuyValue: null
    BuyValueType: string
    BuyMore: boolean
    GetType: string
    GetValue: null
    GetValueType: string
    DealDiscountBrands: []
    DealDiscountCategories: []
    DealDiscountTags: [
      ID: guid
      TagName: string
    ]
    DealDiscountProducts: []
  ]
]
```

### POST `/`

Request body:

```text
Name: string
CustomersGroup: string
DealDiscounts: [
  DiscountName: string
  DiscountType: string
  DiscountID: guid
  Sequence: number
  IsOrderLevel: boolean
  BuyType: string
  BuyValue: null
  BuyValueType: string
  BuyMore: boolean
  GetType: string
  GetValue: null
  GetValueType: string
  DealDiscountBrands: []
  DealDiscountCategories: []
  DealDiscountTags: []
  DealDiscountProducts: [
    ProductID: guid
    ProductName: string
    IsFamily: boolean
    ProductSKU: string
  ]
]
```

Response 200:

```text
Deals: [
  ID: guid
  Name: string
  DateFrom: null
  DateTo: null
  IsActive: boolean
  AllowCoupons: boolean
  SingleCouponCodeUsage: boolean
  CustomersGroup: string
  CouponCodes: null
  DealCustomers: []
  DealCustomerTags: []
  DealDiscounts: [
    ID: guid
    DiscountName: string
    DiscountType: string
    DiscountID: guid
    Sequence: number
    IsOrderLevel: boolean
    BuyType: string
    BuyValue: null
    BuyValueType: string
    BuyMore: boolean
    GetType: string
    GetValue: null
    GetValueType: string
    DealDiscountBrands: []
    DealDiscountCategories: []
    DealDiscountTags: []
    DealDiscountProducts: [
      ID: guid
      ProductID: guid
      ProductName: string
      ProductSKU: string
      IsFamily: boolean
    ]
  ]
]
```

### PUT `/`

Request body:

```text
ID: guid
Name: string
CustomersGroup: string
DealDiscounts: [
  ID: guid
  DiscountName: string
  DiscountType: string
  DiscountID: guid
  Sequence: number
  IsOrderLevel: boolean
  BuyType: string
  BuyValue: null
  BuyValueType: string
  BuyMore: boolean
  GetType: string
  GetValue: null
  GetValueType: string
  DealDiscountBrands: []
  DealDiscountCategories: []
  DealDiscountTags: []
  DealDiscountProducts: [
    ID: guid
    ProductID: guid
    IsFamily: boolean
  ]
]
```

Response 200:

```text
Deals: [
  ID: guid
  Name: string
  DateFrom: null
  DateTo: null
  IsActive: boolean
  AllowCoupons: boolean
  SingleCouponCodeUsage: boolean
  CustomersGroup: string
  CouponCodes: string
  DealCustomers: []
  DealCustomerTags: []
  DealDiscounts: [
    ID: guid
    DiscountName: string
    DiscountType: string
    DiscountID: guid
    Sequence: number
    IsOrderLevel: boolean
    BuyType: string
    BuyValue: null
    BuyValueType: string
    BuyMore: boolean
    GetType: string
    GetValue: null
    GetValueType: string
    DealDiscountBrands: []
    DealDiscountCategories: []
    DealDiscountTags: []
    DealDiscountProducts: [
      ID: guid
      ProductID: guid
      ProductName: string
      ProductSKU: string
      IsFamily: boolean
    ]
  ]
]
```

### GET `/reference/discount`

| Parameter | Type | Required |
|---|---|---|
| `ID` |  |  |
| `Page` | number |  |
| `Limit` | number |  |
| `Search` | string |  |

Response 200:

```text
DiscountRules: [
  ID: guid
  Name: string
  IsActive: boolean
  Type: string
  DiscountLines: [
    ID: guid
    MinValue: number
    MaxValue: number
    DiscountType: string
    Amount: number
  ]
]
Total: number
Page: number
```

### POST `/`

Request body:

```text
DiscountRules: [
  Name: string
  IsActive: boolean
  DiscountLines: [
    MinValue: number
    MaxValue: number
    DiscountType: string
    Amount: number
  ]
  Type: string
]
```

Response 200:

```text
DiscountRules: [
  ID: guid
  Name: string
  IsActive: boolean
  Type: string
  DiscountLines: [
    ID: guid
    MinValue: number
    MaxValue: number
    DiscountType: string
    Amount: number
  ]
]
```

### PUT `/`

Request body:

```text
ID: guid
Name: string
DiscountLines: [
  ID: guid
  MinValue: number
  MaxValue: number
  DiscountType: string
  Amount: number
]
```

Response 200:

```text
DiscountRules: [
  ID: guid
  Name: string
  IsActive: boolean
  Type: string
  DiscountLines: [
    ID: guid
    MinValue: number
    MaxValue: number
    DiscountType: string
    Amount: number
  ]
]
```

### GET `/product-suppliers`

| Parameter | Type | Required |
|---|---|---|
| `ProductID` | guid | yes |

Response 200:

```text
ProductSuppliers: [
  ProductSupplierID: guid
  SupplierID: guid
  SupplierName: string
  ProductID: guid
  ProductSKU: string
  Cost: number
  FixedCost: number
  SupplierInventoryCode: string
  SupplierProductName: string
  SupplierProductURL: string
  DropShip: boolean
  Currency: string
  PurchaseCost: number
  LastSupplied: date
  ProductSupplierOptions: [
    ID: guid
    LocationID: guid
    LocationName: string
    ReorderQuantity: number
    Lead: number
    Safety: number
    MinimumToReorder: null
    SupplyIntervals: [
      ID: guid
      DeliveryMethod: string
      IntervalDays: number
      IntervalStartDate: null
      IsMonday: boolean
      IsTuesday: boolean
      IsWednesday: boolean
      IsThursday: boolean
      IsFriday: boolean
      IsSaturday: boolean
      IsSunday: boolean
    ]
  ]
]
```

### POST `/`

Request body:

```text
ProductSuppliers: [
  SupplierID: guid
  ProductID: guid
  Cost: number
  FixedCost: number
  SupplierInventoryCode: string
  SupplierProductName: string
  SupplierProductURL: string
  DropShip: boolean
  Currency: string
  PurchaseCost: number
  ProductSupplierOptions: [
    LocationID: null
    LocationName: null
    ReorderQuantity: number
    Lead: number
    Safety: number
    MinimumToReorder: number
    SupplyIntervals: []
  ]
]
```

Response 200:

```text
Success: boolean
```

### PUT `/`

Request body:

```text
ProductSuppliers: [
  ProductSupplierID: guid
  SupplierID: guid
  SupplierName: null
  ProductID: guid
  ProductSKU: null
  Cost: number
  FixedCost: number
  SupplierInventoryCode: string
  SupplierProductName: string
  SupplierProductURL: string
  DropShip: boolean
  Currency: string
  PurchaseCost: number
  ProductSupplierOptions: [
    ID: guid
    LocationID: guid
    LocationName: string
    ReorderQuantity: number
    Lead: number
    Safety: number
    MinimumToReorder: null
    SupplyIntervals: [
      ID: guid
      DeliveryMethod: string
      IntervalDays: number
      IntervalStartDate: null
      IsMonday: boolean
      IsTuesday: boolean
      IsWednesday: boolean
      IsThursday: boolean
      IsFriday: boolean
      IsSaturday: boolean
      IsSunday: boolean
    ]
  ]
]
```

Response 200:

```text
Success: boolean
```

### DELETE `/product-suppliers`

| Parameter | Type | Required |
|---|---|---|
| `ProductID` | guid | yes |
| `SupplierID` | guid | yes |

Response 200:

```text
Success: boolean
```

### GET `/reference/shipZones`

| Parameter | Type | Required |
|---|---|---|
| `ID` |  |  |
| `Page` | number |  |
| `Limit` | number |  |
| `Search` | string |  |

Response 200:

```text
ShipZones: [
  ZoneID: guid
  Name: string
  IsRestZone: boolean
  PricesInclTax: boolean
  Negative: boolean
  DefaultShippingCost: number
  ShortDesc: string
  TaxRuleID: guid
  TaxRuleName: null
  AppliesTo: []
  Conditions: []
]
Total: number
Page: number
```

### POST `/`

Request body:

```text
Name: string
IsRestZone: boolean
PricesInclTax: boolean
Negative: boolean
TaxRuleID: guid
AppliesTo: [
  Country2: string
  StateID: null
  StateName: null
  PostCodeFrom: string
  PostCodeTo: string
  PostCodesList: string
  ShippingRate: number
  ID: guid
]
Conditions: [
  MinValue: number
  MaxValue: number
  ShippingCost: number
  ConditionType: string
  ConditionDescription: string
  ZoneConditionID: guid
]
```

Response 200:

```text
ShipZones: [
  ZoneID: guid
  Name: string
  IsRestZone: boolean
  PricesInclTax: boolean
  Negative: boolean
  DefaultShippingCost: number
  ShortDesc: null
  TaxRuleID: guid
  TaxRuleName: null
  AppliesTo: [
    ID: guid
    Country2: string
    StateID: null
    StateName: null
    PostCodeFrom: string
    PostCodeTo: string
    PostCodesList: string
    ShippingRate: number
  ]
  Conditions: [
    ZoneConditionID: guid
    MinValue: number
    MaxValue: number
    ShippingCost: number
    ConditionType: string
    ConditionDescription: string
  ]
]
```

### PUT `/`

Request body:

```text
ZoneID: guid
Name: string
Conditions: [
  ZoneConditionID: guid
  MinValue: number
  MaxValue: number
  ShippingCost: number
  ConditionType: string
  ConditionDescription: string
]
```

Response 200:

```text
ShipZones: [
  ZoneID: guid
  Name: string
  IsRestZone: boolean
  PricesInclTax: boolean
  Negative: boolean
  DefaultShippingCost: number
  ShortDesc: string
  TaxRuleID: guid
  TaxRuleName: null
  AppliesTo: [
    ID: guid
    Country2: string
    StateID: null
    StateName: null
    PostCodeFrom: string
    PostCodeTo: string
    PostCodesList: string
    ShippingRate: number
  ]
  Conditions: [
    ZoneConditionID: guid
    MinValue: number
    MaxValue: number
    ShippingCost: number
    ConditionType: string
    ConditionDescription: string
  ]
]
```

### DELETE `/reference/shipZones` (Delete)

| Parameter | Type | Required |
|---|---|---|
| `ShipZoneID` |  | yes |

Response 200:

```text
Success: boolean
```

### GET `/` (Get)

Response 200:

```text
IsEnabled: boolean
```

### PUT `/` (Update)

Request body:

```text
IsEnabled: boolean
```

Response 200:

```text
IsEnabled: boolean
```

