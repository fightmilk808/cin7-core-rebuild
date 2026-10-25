# Public API: Supplier

From Cin7's API Blueprint: field tables (name, type, length, required, allowed values), each operation's query parameters, and request and response bodies as type outlines (`guid`, `string`, `number`, `boolean`, `date`, `null`; `[ … ]` = array of). Base `/ExternalApi/v2`; headers in [docs/PUBLIC-API.md](../../../docs/PUBLIC-API.md).

**Resources:** `/supplier` · `/ref/supplier/deposits`

## Fields

#### Supplier

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `ID` | Guid |  | Yes |  |
| `Name` | String | 256 | Yes |  |
| `Currency` | String |  | Yes |  |
| `PaymentTerm` | String |  | Yes |  |
| `AccountPayable` | String |  | Yes |  |
| `TaxRule` | String |  | Yes |  |
| `Status` | String |  | Yes* |  |
| `Discount` | Int |  |  |  |
| `Comments` | String | 256 |  |  |
| `TaxNumber` | Int |  |  |  |
| `AttributeSet` | String |  |  |  |
| `AdditionalAttribute#` | String |  |  |  |
| `LastModifiedOn` | String |  |  |  |
| `Addresses` | [] Supplier Address Model |  |  |  |
| `Contacts` | [] Supplier Contact Model |  |  |  |

#### Supplier Deposits

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `DepositID` | Guid |  |  |  |
| `SupplierID` | Guid |  |  |  |
| `SupplierName` | String |  |  |  |
| `Account` | String |  |  |  |
| `Amount` | Decimal |  |  |  |
| `RemainingAmount` | Decimal |  |  |  |
| `Currency` | String |  |  |  |
| `ConvRate` | Decimal |  |  |  |
| `Date` | Date |  |  |  |
| `Description` | String |  |  |  |

## Operations

### GET `/supplier`

| Parameter | Type | Required |
|---|---|---|
| `Page` | number |  |
| `Limit` | number |  |
| `ID` | Guid |  |
| `Name` | string |  |
| `ModifiedSince` | DateTime? |  |
| `IncludeDeprecated` | bool |  |

Response 200:

```text
Total: number
Page: number
SupplierList: [
  ID: guid
  Name: string
  Currency: string
  PaymentTerm: string
  TaxRule: string
  Discount: number
  Comments: null
  AccountPayable: string
  TaxNumber: null
  AdditionalAttribute1: null
  AdditionalAttribute2: null
  AdditionalAttribute3: null
  AdditionalAttribute4: null
  AdditionalAttribute5: null
  AdditionalAttribute6: null
  AdditionalAttribute7: null
  AdditionalAttribute8: null
  AdditionalAttribute9: null
  AdditionalAttribute10: null
  AttributeSet: null
  Status: string
  LastModifiedOn: date
  Addresses: [
    Line1: string
    Line2: string
    City: string
    State: string
    Postcode: string
    Country: string
    Type: string
    DefaultForType: boolean
  ]
  Contacts: [
    Name: string
    Phone: string
    MobilePhone: string
    Fax: string
    Email: string
    Website: null
    Default: boolean
    Comment: null
    IncludeInEmail: boolean
  ]
]
```

### POST `/`

Request body:

```text
Name: string
Currency: string
PaymentTerm: string
TaxRule: string
AccountPayable: string
Status: string
AdditionalAttribute1: string
AdditionalAttribute2: string
AdditionalAttribute3: string
AdditionalAttribute4: null
AdditionalAttribute5: null
AdditionalAttribute6: null
AdditionalAttribute7: null
AdditionalAttribute8: null
AdditionalAttribute9: null
AdditionalAttribute10: null
AttributeSet: string
```

Response 200:

```text
Total: number
Page: number
SupplierList: [
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
  AttributeSet: string
  Status: string
  LastModifiedOn: date
  Addresses: []
  Contacts: []
]
```

### PUT `/`

Request body:

```text
ID: guid
Name: string
Currency: string
PaymentTerm: string
TaxRule: string
Discount: number
Comments: string
AccountPayable: string
TaxNumber: string
Status: string
AdditionalAttribute1: string
AdditionalAttribute2: string
AdditionalAttribute3: string
AdditionalAttribute4: null
AdditionalAttribute5: null
AdditionalAttribute6: null
AdditionalAttribute7: null
AdditionalAttribute8: null
AdditionalAttribute9: null
AdditionalAttribute10: null
AttributeSet: string
Addresses: [
  Line1: string
  Line2: string
  City: string
  State: string
  Postcode: string
  Country: string
  Type: string
  DefaultForType: boolean
]
Contacts: [
  Name: string
  Phone: string
  MobilePhone: string
  Fax: string
  Email: string
  Website: string
  Default: boolean
  Comment: string
  IncludeInEmail: boolean
]
```

Response 200:

```text
Total: number
Page: number
SupplierList: [
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
  AttributeSet: string
  Status: string
  LastModifiedOn: date
  Addresses: [
    ID: guid
    SupplierID: guid
    Line1: string
    Line2: string
    City: null
    State: null
    Postcode: null
    Country: string
    Type: string
    DefaultForType: boolean
  ]
  Contacts: [
    ID: guid
    SupplierID: guid
    Name: string
    Phone: string
    MobilePhone: string
    Fax: string
    Email: string
    Website: string
    Default: boolean
    Comment: string
    IncludeInEmail: boolean
  ]
]
```

### GET `/ref/supplier/deposits`

| Parameter | Type | Required |
|---|---|---|
| `Page` | number |  |
| `Limit` | number |  |
| `SupplierID` | Guid |  |

Response 200:

```text
Page: number
SupplierDeposits: [
  DepositID: guid
  SupplierID: guid
  SupplierName: string
  Account: string
  Amount: number
  RemainingAmount: number
  Currency: string
  ConvRate: number
  Date: date
  Description: string
]
```

