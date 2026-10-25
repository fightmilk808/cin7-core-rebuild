# Public API: Customer

From Cin7's API Blueprint: field tables (name, type, length, required, allowed values), each operation's query parameters, and request and response bodies as type outlines (`guid`, `string`, `number`, `boolean`, `date`, `null`; `[ … ]` = array of). Base `/ExternalApi/v2`; headers in [docs/PUBLIC-API.md](../../../docs/PUBLIC-API.md).

**Resources:** `/customer` · `/ref/customer/templates` · `/ref/customer/credits`

## Fields

#### Customer

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `ID` | Guid |  | Yes |  |
| `Name` | String | 256 | Yes |  |
| `DisplayName` | String | 256 |  |  |
| `Status` | String |  | Yes* | `Active`, `Deprecated` |
| `Currency` | String |  | Yes |  |
| `PaymentTerm` | String |  | Yes |  |
| `AccountReceivable` | String |  | Yes |  |
| `RevenueAccount` | String |  | Yes |  |
| `TaxRule` | String |  | Yes |  |
| `PriceTier` | String |  |  |  |
| `Carrier` | String |  |  |  |
| `SalesRepresentative` | String |  |  |  |
| `Location` | String |  |  |  |
| `Discount` | Int |  |  |  |
| `Comments` | String | 2000 |  |  |
| `TaxNumber` | Int |  |  |  |
| `CreditLimit` | Int |  |  |  |
| `Tags` | String |  |  |  |
| `AttributeSet` | String |  |  |  |
| `AdditionalAttribute#` | String |  |  |  |
| `LastModifiedOn` | String |  |  |  |
| `IsOnCreditHold` | Bool |  |  |  |
| `LastModifiedOn` | DateTime (read-only) |  |  |  |
| `IsLegalEntity` | Bool |  |  |  |
| `CustomerParentID` | Guid |  |  |  |
| `CustomerParentName` | String | 256 |  |  |
| `IsBillParent` | Bool |  |  |  |
| `ProductPrices` | [] Product Price Model |  |  |  |
| `Addresses` | [] Customer Address Model |  |  |  |
| `Contacts` | [] Customer Contact Model |  |  |  |
| `ChildCustomers` | [] Child Customer Model |  |  |  |

#### Customer Default Template

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `CustomerID` | Guid |  | Yes* |  |
| `TemplateID` | Guid |  | Yes* |  |

#### Customer Credits

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `CreditID` | Guid |  |  |  |
| `CustomerID` | Guid |  |  |  |
| `CustomerName` | String |  |  |  |
| `Account` | String |  |  |  |
| `Amount` | Decimal |  |  |  |
| `RemainingAmount` | Decimal |  |  |  |
| `Currency` | String |  |  |  |
| `ConvRate` | Decimal |  |  |  |
| `Date` | Date |  |  |  |
| `Description` | String |  |  |  |

## Operations

### GET `/customer`

| Parameter | Type | Required |
|---|---|---|
| `Page` | number |  |
| `Limit` | number |  |
| `ID` | Guid |  |
| `Name` | string |  |
| `ContactFilter` | string |  |
| `ModifiedSince` | DateTime? |  |
| `IncludeDeprecated` | bool |  |
| `IncludeProductPrices` | bool |  |

Response 200:

```text
Total: number
Page: number
CustomerList: [
  ID: guid
  Name: string
  DisplayName: string
  Currency: string
  PaymentTerm: string
  Discount: number
  TaxRule: string
  Carrier: string
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
  CreditLimit: number
  IsOnCreditHold: boolean
  IsLegalEntity: boolean
  CustomerParentID: null
  CustomerParentName: null
  IsBillParent: boolean
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
    ID: guid
  ]
  Contacts: [
    Name: string
    JobTitle: null
    Phone: string
    MobilePhone: null
    Fax: null
    Email: null
    Website: null
    Default: boolean
    Comment: null
    IncludeInEmail: boolean
    MarketingConsent: number
    ID: guid
  ]
  ChildCustomers: [
    CustomerID: guid
    CustomerName: string
  ]
  ProductPrices: [
    ProductID: guid
    ProductName: string
    ProductSKU: string
    Price: number
  ]
]
```

### POST `/`

Request body:

```text
Name: string
DisplayName: string
Currency: string
PaymentTerm: string
Discount: number
TaxRule: string
Carrier: string
SalesRepresentative: null
Location: string
Comments: null
AccountReceivable: string
RevenueAccount: string
PriceTier: string
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
Tags: null
Status: string
IsOnCreditHold: boolean
IsLegalEntity: boolean
CustomerParentID: guid
CustomerParentName: string
IsBillParent: boolean
Addresses: [
  ID: guid
  CustomerID: guid
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
  ID: guid
  CustomerID: guid
  Name: string
  JobTitle: null
  Phone: string
  MobilePhone: null
  Fax: string
  Email: string
  Website: null
  Default: boolean
  Comment: null
  IncludeInEmail: boolean
  MarketingConsent: number
]
```

Response 200:

```text
keys: AccountReceivable, AdditionalAttribute1, AdditionalAttribute10, AdditionalAttribute2, AdditionalAttribute3, AdditionalAttribute4, AdditionalAttribute5, AdditionalAttribute6, AdditionalAttribute7, AdditionalAttribute8, AdditionalAttribute9, Addresses, AttributeSet, Carrier, ChildCustomers, City, Comment, Comments, Contacts, Country, CreditLimit, Currency, CustomerID, CustomerList, CustomerParentID, CustomerParentName, Default, DefaultForType, Discount, DisplayName, Email, Fax, ID, IncludeInEmail, IsBillParent, IsLegalEntity, IsOnCreditHold, JobTitle, LastModifiedOn, Line1, Line2, Location, MarketingConsent, MobilePhone, Name, Page, PaymentTerm, Phone, Postcode, PriceTier, RevenueAccount, SalesRepresentative, State, Status, Tags, TaxNumber, TaxRule, Total, Type, Website
```

### PUT `/`

Request body:

```text
ID: guid
Name: string
DisplayName: string
Currency: string
PaymentTerm: string
Discount: number
TaxRule: string
Carrier: string
SalesRepresentative: null
Location: string
Comments: null
AccountReceivable: string
RevenueAccount: string
PriceTier: string
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
Tags: null
IsOnCreditHold: boolean
IsLegalEntity: boolean
CustomerParentID: null
CustomerParentName: null
IsBillParent: boolean
Status: string
Addresses: [
  ID: guid
  CustomerID: guid
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
  ID: guid
  CustomerID: guid
  Name: string
  JobTitle: null
  Phone: string
  MobilePhone: null
  Fax: string
  Email: string
  Website: null
  Default: boolean
  Comment: null
  IncludeInEmail: boolean
  MarketingConsent: number
]
```

Response 200:

```text
keys: AccountReceivable, AdditionalAttribute1, AdditionalAttribute10, AdditionalAttribute2, AdditionalAttribute3, AdditionalAttribute4, AdditionalAttribute5, AdditionalAttribute6, AdditionalAttribute7, AdditionalAttribute8, AdditionalAttribute9, Addresses, AttributeSet, Carrier, ChildCustomers, City, Comment, Comments, Contacts, Country, CreditLimit, Currency, CustomerID, CustomerList, CustomerName, CustomerParentID, CustomerParentName, Default, DefaultForType, Discount, DisplayName, Email, Fax, ID, IncludeInEmail, IsBillParent, IsLegalEntity, IsOnCreditHold, JobTitle, LastModifiedOn, Line1, Line2, Location, MarketingConsent, MobilePhone, Name, Page, PaymentTerm, Phone, Postcode, PriceTier, RevenueAccount, SalesRepresentative, State, Status, Tags, TaxNumber, TaxRule, Total, Type, Website
```

### GET `/ref/customer/templates`

| Parameter | Type | Required |
|---|---|---|
| `Page` | number |  |
| `Limit` | number |  |
| `CustomerId` | Guid |  |

Response 200:

```text
Page: number
CustomerTemplates: [
  CustomerID: guid
  TemplateID: guid
]
```

### POST `/`

Request body:

```text
CustomerTemplates: [
  CustomerID: guid
  TemplateID: guid
]
```

Response 200:

```text
Page: number
CustomerTemplates: [
  CustomerID: guid
  TemplateID: guid
]
```

### DELETE `/ref/customer/templates`

| Parameter | Type | Required |
|---|---|---|
| `TemplateId` | string | yes |
| `CustomerId` | string | yes |

Response 200:

```text
Page: number
CustomerTemplates: [
  CustomerID: guid
  TemplateID: guid
]
```

### GET `/ref/customer/credits`

| Parameter | Type | Required |
|---|---|---|
| `Page` | number |  |
| `Limit` | number |  |
| `CustomerID` | Guid |  |
| `ShowUsedCredits` | Boolean |  |

Response 200:

```text
Page: number
CustomerCredits: [
  CreditID: guid
  CustomerID: guid
  CustomerName: string
  Account: string
  Amount: number
  RemainingAmount: number
  Currency: string
  ConvRate: number
  Date: date
  Description: string
]
```

