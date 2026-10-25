# Public API: Tax

From Cin7's API Blueprint: field tables (name, type, length, required, allowed values), each operation's query parameters, and request and response bodies as type outlines (`guid`, `string`, `number`, `boolean`, `date`, `null`; `[ … ]` = array of). Base `/ExternalApi/v2`; headers in [docs/PUBLIC-API.md](../../../docs/PUBLIC-API.md).

**Resources:** `/ref/tax`

## Fields

#### Tax

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `ID` | Guid | 50 |  |  |
| `Name` | String | 50 | Yes |  |
| `Account` | String |  | Yes |  |
| `IsActive` | Bool |  | Yes |  |
| `TaxInclusive` | Bool |  | Yes |  |
| `TaxPercent` | Decimal (read-only) |  |  |  |
| `IsTaxForSale` | Bool |  |  |  |
| `IsTaxForPurchase` | Bool |  |  |  |
| `Components` | [] Tax Component Model |  |  |  |

## Operations

### GET `/ref/tax`

| Parameter | Type | Required |
|---|---|---|
| `Page` | number |  |
| `Limit` | number |  |
| `ID` | Guid |  |
| `Name` | string |  |
| `IsActive` | bool |  |
| `IsTaxForSale` | bool |  |
| `IsTaxForPurchase` | bool |  |
| `Account` | string |  |

Response 200:

```text
Total: number
Page: number
TaxRuleList: [
  ID: guid
  Name: string
  Account: string
  IsActive: boolean
  TaxInclusive: boolean
  TaxPercent: number
  IsTaxForSale: boolean
  IsTaxForPurchase: boolean
  Components: [
    ID: guid
    Name: string
    Percent: string
    AccountCode: string
    ComponentOrder: string
  ]
]
```

### POST `/`

Request body:

```text
Name: string
Account: string
IsActive: boolean
TaxInclusive: boolean
TaxPercent: number
IsTaxForSale: boolean
IsTaxForPurchase: boolean
Components: [
  Name: string
  Percent: string
  AccountCode: string
  Compound: string
  ComponentOrder: string
]
```

Response 200:

```text
Total: number
Page: number
TaxRuleList: [
  ID: guid
  Name: string
  Account: string
  IsActive: boolean
  TaxInclusive: boolean
  TaxPercent: number
  IsTaxForSale: boolean
  IsTaxForPurchase: boolean
  Components: [
    ID: guid
    Name: string
    Percent: string
    AccountCode: string
    Compound: string
    ComponentOrder: string
  ]
]
```

### PUT `/`

Request body:

```text
ID: guid
Name: string
Account: string
IsActive: boolean
TaxInclusive: boolean
TaxPercent: number
IsTaxForSale: boolean
IsTaxForPurchase: boolean
Components: [
  ID: guid
  Name: string
  Percent: string
  AccountCode: string
  Compound: string
  ComponentOrder: string
]
```

Response 200:

```text
Total: number
Page: number
TaxRuleList: [
  ID: guid
  Name: string
  Account: string
  IsActive: boolean
  TaxInclusive: boolean
  TaxPercent: number
  IsTaxForSale: boolean
  IsTaxForPurchase: boolean
  Components: [
    ID: guid
    Name: string
    Percent: string
    AccountCode: string
    Compound: string
    ComponentOrder: string
  ]
]
```

