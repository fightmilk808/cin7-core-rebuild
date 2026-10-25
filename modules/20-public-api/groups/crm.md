# Public API: CRM

From Cin7's API Blueprint: field tables (name, type, length, required, allowed values), each operation's query parameters, and request and response bodies as type outlines (`guid`, `string`, `number`, `boolean`, `date`, `null`; `[ … ]` = array of). Base `/ExternalApi/v2`; headers in [docs/PUBLIC-API.md](../../../docs/PUBLIC-API.md).

**Resources:** `/crm/lead` · `/crm/opportunity` · `/crm/task` · `/crm/taskcategory` · `/crm/workflow` · `/crm/workflowstart`

## Fields

#### Lead

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `ID` | Guid |  | yes |  |
| `LeadStatus` | string | 256 | yes |  |
| `Name` | string | 256 | yes |  |
| `Currency` | string | 3 | yes |  |
| `PaymentTerm` | int |  | yes |  |
| `PriceTier` | string | 50 | yes |  |
| `SalesRepresentative` | string | 256 | yes |  |
| `TaxRule` | string | 255 | yes |  |
| `Amount` | decimal |  |  |  |
| `CloseChance` | int |  | yes |  |
| `CloseDate` | DateTime |  | yes |  |
| `Comments` | string | 2000 |  |  |
| `Contacts` | [] Lead Contact Model |  |  |  |
| `Addresses` | [] Lead Address Model |  |  |  |

#### Opportunity

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `ID` | Guid |  | yes |  |
| `CustomerID` | Guid |  |  |  |
| `LeadID` | Guid |  |  |  |
| `CustomerName` | string | 256 | yes |  |
| `Contact` | string | 256 |  |  |
| `Phone` | string | 50 |  |  |
| `DefaultAccount` | string | 50 |  |  |
| `BillingAddressLine1` | string | 256 | yes |  |
| `BillingAddressLine2` | string | 256 |  |  |
| `Currency` | string | 3 | yes |  |
| `TaxPercent` | decimal |  |  |  |
| `TaxInclusive` | bool |  |  |  |
| `TaxRule` | string | 255 | yes |  |
| `TermDays` | int |  |  |  |
| `Terms` | string | 50 | yes |  |
| `PriceTier` | string | 50 | yes |  |
| `ShippingAddressLine1` | string | 256 |  |  |
| `ShippingAddressLine2` | string | 256 |  |  |
| `OpportunityLocation` | string | 256 | yes |  |
| `OpportunityNumber` | string | 256 |  |  |
| `OpportunityDate` | DateTime |  |  |  |
| `OpportunityComment` | string | 1024 |  |  |
| `OpportunityMemo` | string | 1024 |  |  |
| `OpportunityStatus` | string | 25 |  |  |
| `TaxTotal` | decimal |  |  |  |
| `Total` | decimal |  |  |  |
| `CustomerReference` | string | 256 |  |  |
| `CurrencyConversionRate` | decimal |  |  |  |
| `CustomerCurrency` | string | 3 | yes |  |
| `TermMethod` | int |  | yes |  |
| `SalesRepresentative` | string | 256 | yes |  |
| `TermDueNextMonth` | int |  |  |  |
| `ShipToOther` | bool |  | yes |  |
| `ShipToCompany` | string | 128 |  |  |
| `ShipToContact` | string | 512 |  |  |
| `ShipToCountry` | string | 64 |  |  |
| `ShipToPostCode` | string | 32 |  |  |
| `ShipToState` | string | 128 |  |  |
| `ShipToCity` | string | 128 |  |  |
| `ShipToAddress1` | string | 256 |  |  |
| `ShipToAddress2` | string | 256 |  |  |
| `CustomField1` | string | 256 |  |  |
| `CustomField2` | string | 256 |  |  |
| `CustomField3` | string | 256 |  |  |
| `CustomField4` | string | 256 |  |  |
| `CustomField5` | string | 256 |  |  |
| `CustomField6` | string | 256 |  |  |
| `CustomField7` | string | 256 |  |  |
| `CustomField8` | string | 256 |  |  |
| `CustomField9` | string | 256 |  |  |
| `CustomField10` | string | 256 |  |  |
| `Lines` | Opportunity Line[] |  |  |  |
| `AdditionalCharges` | Opportunity Additional Charge[] |  |  |  |

#### Opportunity Line

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|

#### Opportunity Opportunity Additional Charge

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|

## Operations

### GET `/crm/lead`

| Parameter | Type | Required |
|---|---|---|
| `Page` | number |  |
| `Limit` | number |  |
| `ID` | Guid |  |
| `Name` | string |  |
| `ModifiedSince` | DateTime? |  |

Response 200:

```text
Total: number
Page: number
LeadList: [
  ID: guid
  Name: string
  Currency: string
  LeadStatus: string
  CloseChance: number
  PaymentTerm: string
  TaxRule: string
  SalesRepresentative: string
  Comments: string
  PriceTier: string
  CloseDate: date
  Amount: number
  Addresses: []
  Contacts: [
    ID: guid
    Name: string
    JobTitle: string
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

### POST `/`

Request body:

```text
Name: string
Currency: string
LeadStatus: string
CloseChance: number
PaymentTerm: string
TaxRule: string
SalesRepresentative: string
Comments: string
PriceTier: string
CloseDate: date
Amount: number
Addresses: [
  Type: string
  Line1: string
  Line2: string
  City: string
  State: string
  Postcode: string
  Country: string
  DefaultForType: boolean
]
Contacts: [
  Name: string
  JobTitle: string
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
LeadList: [
  Name: string
  Currency: string
  LeadStatus: string
  CloseChance: number
  PaymentTerm: string
  TaxRule: string
  SalesRepresentative: string
  Comments: string
  PriceTier: string
  CloseDate: date
  Amount: number
  Addresses: [
    ID: guid
    Type: string
    Line1: string
    Line2: string
    City: string
    State: string
    Postcode: string
    Country: string
    DefaultForType: boolean
  ]
  Contacts: [
    ID: guid
    Name: string
    JobTitle: string
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

### PUT `/`

Request body:

```text
Name: string
Currency: string
LeadStatus: string
CloseChance: number
PaymentTerm: string
TaxRule: string
SalesRepresentative: string
Comments: string
PriceTier: string
CloseDate: date
Amount: number
Addresses: [
  Type: string
  Line1: string
  Line2: string
  City: string
  State: string
  Postcode: string
  Country: string
  DefaultForType: boolean
]
Contacts: [
  Name: string
  JobTitle: string
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
LeadList: [
  Name: string
  Currency: string
  LeadStatus: string
  CloseChance: number
  PaymentTerm: string
  TaxRule: string
  SalesRepresentative: string
  Comments: string
  PriceTier: string
  CloseDate: date
  Amount: number
  Addresses: [
    ID: guid
    Type: string
    Line1: string
    Line2: string
    City: string
    State: string
    Postcode: string
    Country: string
    DefaultForType: boolean
  ]
  Contacts: [
    ID: guid
    Name: string
    JobTitle: string
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

### GET `/crm/opportunity`

| Parameter | Type | Required |
|---|---|---|
| `Page` | number |  |
| `Limit` | number |  |
| `ID` | Guid |  |
| `ModifiedSince` | DateTime? |  |

Response 200:

```text
Total: number
Page: number
opportunityList: [
  ID: guid
  CustomerID: guid
  LeadID: null
  CustomerName: string
  Contact: string
  Phone: string
  DefaultAccount: string
  BillingAddressLine1: string
  BillingAddressLine2: string
  Currency: string
  TaxPercent: number
  TaxInclusive: boolean
  TaxRule: string
  TermDays: number
  Terms: string
  PriceTier: string
  ShippingAddressLine1: string
  ShippingAddressLine2: string
  OpportunityLocation: string
  OpportunityNumber: string
  OpportunityDate: date
  OpportunityComment: string
  OpportunityMemo: string
  OpportunityStatus: string
  TaxTotal: number
  Total: number
  CustomerReference: string
  CurrencyConversionRate: number
  CustomerCurrency: string
  TermMethod: number
  SalesRepresentative: string
  TermDueNextMonth: number
  ShipToOther: boolean
  ShipToCompany: string
  ShipToContact: string
  ShipToCountry: string
  ShipToPostCode: string
  ShipToState: string
  ShipToCity: string
  ShipToAddress1: string
  ShipToAddress2: string
  CustomField1: string
  CustomField2: string
  CustomField3: string
  CustomField4: string
  CustomField5: string
  CustomField6: string
  CustomField7: string
  CustomField8: string
  CustomField9: string
  CustomField10: string
  Lines: [
    ID: guid
    ProductID: guid
    ProductName: string
    ProductSku: string
    Quantity: number
    Price: number
    Discount: number
    Tax: number
    Total: number
    TaxRule: string
    TaxPercent: number
    Comment: string
  ]
  AdditionalCharges: [
    ID: guid
    Description: string
    Quantity: number
    Amount: number
    Discount: number
    Tax: number
    Total: number
    TaxRule: string
    TaxPercent: number
    Comment: string
  ]
]
```

### POST `/`

Request body:

```text
CustomerID: guid
LeadID: null
CustomerName: string
Contact: string
Phone: string
DefaultAccount: string
BillingAddressLine1: string
BillingAddressLine2: string
Currency: string
TaxPercent: number
TaxInclusive: boolean
TaxRule: string
TermDays: number
Terms: string
PriceTier: string
ShippingAddressLine1: string
ShippingAddressLine2: string
OpportunityLocation: string
OpportunityNumber: string
OpportunityDate: date
OpportunityComment: string
OpportunityMemo: string
OpportunityStatus: string
TaxTotal: number
Total: number
CustomerReference: string
CurrencyConversionRate: number
CustomerCurrency: string
TermMethod: number
SalesRepresentative: string
TermDueNextMonth: number
ShipToOther: boolean
ShipToCompany: string
ShipToContact: string
ShipToCountry: string
ShipToPostCode: string
ShipToState: string
ShipToCity: string
ShipToAddress1: string
ShipToAddress2: string
CustomField1: string
CustomField2: string
CustomField3: string
CustomField4: string
CustomField5: string
CustomField6: string
CustomField7: string
CustomField8: string
CustomField9: string
CustomField10: string
Lines: [
  ProductID: guid
  ProductName: string
  ProductSku: string
  Quantity: number
  Price: number
  Discount: number
  Tax: number
  Total: number
  TaxRule: string
  TaxPercent: number
  Comment: string
]
AdditionalCharges: [
  Description: string
  Quantity: number
  Amount: number
  Discount: number
  Tax: number
  Total: number
  TaxRule: string
  TaxPercent: number
  Comment: string
]
```

Response 200:

```text
Total: number
Page: number
opportunityList: [
  ID: guid
  CustomerID: guid
  LeadID: null
  CustomerName: string
  Contact: string
  Phone: string
  DefaultAccount: string
  BillingAddressLine1: string
  BillingAddressLine2: string
  Currency: string
  TaxPercent: number
  TaxInclusive: boolean
  TaxRule: string
  TermDays: number
  Terms: string
  PriceTier: string
  ShippingAddressLine1: string
  ShippingAddressLine2: string
  OpportunityLocation: string
  OpportunityNumber: string
  OpportunityDate: date
  OpportunityComment: string
  OpportunityMemo: string
  OpportunityStatus: string
  TaxTotal: number
  Total: number
  CustomerReference: string
  CurrencyConversionRate: number
  CustomerCurrency: string
  TermMethod: number
  SalesRepresentative: string
  TermDueNextMonth: number
  ShipToOther: boolean
  ShipToCompany: string
  ShipToContact: string
  ShipToCountry: string
  ShipToPostCode: string
  ShipToState: string
  ShipToCity: string
  ShipToAddress1: string
  ShipToAddress2: string
  CustomField1: string
  CustomField2: string
  CustomField3: string
  CustomField4: string
  CustomField5: string
  CustomField6: string
  CustomField7: string
  CustomField8: string
  CustomField9: string
  CustomField10: string
  Lines: [
    ID: guid
    ProductID: guid
    ProductName: string
    ProductSku: string
    Quantity: number
    Price: number
    Discount: number
    Tax: number
    Total: number
    TaxRule: string
    TaxPercent: number
    Comment: string
  ]
  AdditionalCharges: [
    ID: guid
    Description: string
    Quantity: number
    Amount: number
    Discount: number
    Tax: number
    Total: number
    TaxRule: string
    TaxPercent: number
    Comment: string
  ]
]
```

### PUT `/`

Request body:

```text
CustomerID: guid
LeadID: null
CustomerName: string
Contact: string
Phone: string
DefaultAccount: string
BillingAddressLine1: string
BillingAddressLine2: string
Currency: string
TaxPercent: number
TaxInclusive: boolean
TaxRule: string
TermDays: number
Terms: string
PriceTier: string
ShippingAddressLine1: string
ShippingAddressLine2: string
OpportunityLocation: string
OpportunityNumber: string
OpportunityDate: date
OpportunityComment: string
OpportunityMemo: string
OpportunityStatus: string
TaxTotal: number
Total: number
CustomerReference: string
CurrencyConversionRate: number
CustomerCurrency: string
TermMethod: number
SalesRepresentative: string
TermDueNextMonth: number
ShipToOther: boolean
ShipToCompany: string
ShipToContact: string
ShipToCountry: string
ShipToPostCode: string
ShipToState: string
ShipToCity: string
ShipToAddress1: string
ShipToAddress2: string
CustomField1: string
CustomField2: string
CustomField3: string
CustomField4: string
CustomField5: string
CustomField6: string
CustomField7: string
CustomField8: string
CustomField9: string
CustomField10: string
Lines: [
  ProductID: guid
  ProductName: string
  ProductSku: string
  Quantity: number
  Price: number
  Discount: number
  Tax: number
  Total: number
  TaxRule: string
  TaxPercent: number
  Comment: string
]
AdditionalCharges: [
  Description: string
  Quantity: number
  Amount: number
  Discount: number
  Tax: number
  Total: number
  TaxRule: string
  TaxPercent: number
  Comment: string
]
```

Response 200:

```text
Total: number
Page: number
opportunityList: [
  ID: guid
  CustomerID: guid
  LeadID: null
  CustomerName: string
  Contact: string
  Phone: string
  DefaultAccount: string
  BillingAddressLine1: string
  BillingAddressLine2: string
  Currency: string
  TaxPercent: number
  TaxInclusive: boolean
  TaxRule: string
  TermDays: number
  Terms: string
  PriceTier: string
  ShippingAddressLine1: string
  ShippingAddressLine2: string
  OpportunityLocation: string
  OpportunityNumber: string
  OpportunityDate: date
  OpportunityComment: string
  OpportunityMemo: string
  OpportunityStatus: string
  TaxTotal: number
  Total: number
  CustomerReference: string
  CurrencyConversionRate: number
  CustomerCurrency: string
  TermMethod: number
  SalesRepresentative: string
  TermDueNextMonth: number
  ShipToOther: boolean
  ShipToCompany: string
  ShipToContact: string
  ShipToCountry: string
  ShipToPostCode: string
  ShipToState: string
  ShipToCity: string
  ShipToAddress1: string
  ShipToAddress2: string
  CustomField1: string
  CustomField2: string
  CustomField3: string
  CustomField4: string
  CustomField5: string
  CustomField6: string
  CustomField7: string
  CustomField8: string
  CustomField9: string
  CustomField10: string
  Lines: [
    ID: guid
    ProductID: guid
    ProductName: string
    ProductSku: string
    Quantity: number
    Price: number
    Discount: number
    Tax: number
    Total: number
    TaxRule: string
    TaxPercent: number
    Comment: string
  ]
  AdditionalCharges: [
    ID: guid
    Description: string
    Quantity: number
    Amount: number
    Discount: number
    Tax: number
    Total: number
    TaxRule: string
    TaxPercent: number
    Comment: string
  ]
]
```

### GET `/crm/task`

| Parameter | Type | Required |
|---|---|---|
| `Page` | number |  |
| `Limit` | number |  |
| `ID` | Guid |  |
| `Name` | string |  |
| `StartDateFrom` | DateTime? |  |
| `StartDateTo` | DateTime? |  |
| `EndDateFrom` | DateTime? |  |
| `EndDateTo` | DateTime? |  |
| `CompleteDateFrom` | DateTime? |  |
| `CompleteDateTo` | DateTime? |  |
| `AssignedTo` | string |  |
| `Category` | string |  |

Response 200:

```text
Total: number
Page: number
Tasks: [
  ID: guid
  Name: string
  Description: null
  StartDate: date
  EndDate: date
  IsAllDay: boolean
  CompletedDate: null
  Category: string
  WorkflowName: null
  AssignedTo: string
  EntityType: string
  EntityID: guid
  IsImportant: boolean
  TaskStatus: string
  AssignedBy: string
  VoidDate: null
]
```

### POST `/`

Request body:

```text
Name: string
Description: null
StartDate: date
EndDate: date
IsAllDay: boolean
CompletedDate: null
Category: string
WorkflowName: null
AssignedTo: string
EntityType: string
EntityID: guid
IsImportant: boolean
TaskStatus: string
AssignedBy: string
VoidDate: null
```

Response 200:

```text
Total: number
Page: number
Tasks: [
  ID: guid
  Name: string
  Description: null
  StartDate: date
  EndDate: date
  IsAllDay: boolean
  CompletedDate: null
  Category: string
  WorkflowName: null
  AssignedTo: string
  EntityType: string
  EntityID: guid
  IsImportant: boolean
  TaskStatus: string
  AssignedBy: string
  VoidDate: null
]
```

### PUT `/`

Request body:

```text
ID: guid
Name: string
Description: null
StartDate: date
EndDate: date
IsAllDay: boolean
CompletedDate: null
Category: string
WorkflowName: null
AssignedTo: string
EntityType: string
EntityID: guid
IsImportant: boolean
TaskStatus: string
AssignedBy: string
VoidDate: null
```

Response 200:

```text
Total: number
Page: number
Tasks: [
  ID: guid
  Name: string
  Description: null
  StartDate: date
  EndDate: date
  IsAllDay: boolean
  CompletedDate: null
  Category: string
  WorkflowName: null
  AssignedTo: string
  EntityType: string
  EntityID: guid
  IsImportant: boolean
  TaskStatus: string
  AssignedBy: string
  VoidDate: null
]
```

### GET `/crm/task`

| Parameter | Type | Required |
|---|---|---|
| `Page` | number |  |
| `Limit` | number |  |
| `ID` | Guid |  |
| `Name` | string |  |

Response 200:

```text
Total: number
Page: number
Categories: [
  ID: guid
  Name: string
  Color: string
  BackgroundColor: string
]
```

### POST `/`

Request body:

```text
Name: string
Color: string
BackgroundColor: string
```

Response 200:

```text
Total: number
Page: number
Categories: [
  ID: guid
  Name: string
  Color: string
  BackgroundColor: string
]
```

### PUT `/`

Request body:

```text
ID: guid
Name: string
Color: string
BackgroundColor: string
```

Response 200:

```text
Total: number
Page: number
Categories: [
  ID: guid
  Name: string
  Color: string
  BackgroundColor: string
]
```

### GET `/crm/task`

| Parameter | Type | Required |
|---|---|---|
| `Page` | number |  |
| `Limit` | number |  |
| `ID` | Guid |  |
| `Name` | string |  |

Response 200:

```text
Total: number
Page: number
Workflows: [
  ID: guid
  Name: string
  IsActive: boolean
  EntityType: string
  DueDaysType: string
  Steps: [
    ID: guid
    Name: string
    Category: null
    Days: number
    StartTime: string
    EndTime: string
    UserName: string
    SkipHoliday: string
  ]
]
```

### POST `/`

Request body:

```text
Name: string
IsActive: boolean
EntityType: string
DueDaysType: string
Steps: [
  Name: string
  Category: null
  Days: number
  StartTime: string
  EndTime: string
  UserName: string
  SkipHoliday: string
]
```

Response 200:

```text
Total: number
Page: number
Workflows: [
  ID: guid
  Name: string
  IsActive: boolean
  EntityType: string
  DueDaysType: string
  Steps: [
    ID: guid
    Name: string
    Category: null
    Days: number
    StartTime: string
    EndTime: string
    UserName: string
    SkipHoliday: string
  ]
]
```

### PUT `/`

Request body:

```text
ID: guid
Name: string
IsActive: boolean
EntityType: string
DueDaysType: string
Steps: [
  Name: string
  Category: null
  Days: number
  StartTime: string
  EndTime: string
  UserName: string
  SkipHoliday: string
]
```

Response 200:

```text
Total: number
Page: number
Workflows: [
  ID: guid
  Name: string
  IsActive: boolean
  EntityType: string
  DueDaysType: string
  Steps: [
    Name: string
    Category: null
    Days: number
    StartTime: string
    EndTime: string
    UserName: string
    SkipHoliday: string
  ]
]
```

### POST `/crm/workflowstart`

| Parameter | Type | Required |
|---|---|---|
| `ID` | string |  |
| `Name` | string |  |
| `StartDate` | DateTime? | yes |
| `EnityType` | string | yes |
| `EntityID` | string | yes |

Request body:

```text
```

Response 200:

```text
keys: 
```

