# Public API: Payment Term

From Cin7's API Blueprint: field tables (name, type, length, required, allowed values), each operation's query parameters, and request and response bodies as type outlines (`guid`, `string`, `number`, `boolean`, `date`, `null`; `[ … ]` = array of). Base `/ExternalApi/v2`; headers in [docs/PUBLIC-API.md](../../../docs/PUBLIC-API.md).

**Resources:** `/ref/paymentterm`

## Fields

#### Payment Term

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `ID` | Guid |  |  |  |
| `Name` | String | 256 | Yes |  |
| `Duration` | Int |  |  |  |
| `Method` | String |  |  |  |
| `IsActive` | Bool |  |  |  |
| `IsDefault` | Bool |  |  |  |

## Operations

### GET `/ref/paymentterm`

| Parameter | Type | Required |
|---|---|---|
| `Page` | number |  |
| `Limit` | number |  |
| `ID` | Guid |  |
| `Name` | string |  |
| `Method` | string |  |
| `IsActive` | bool |  |
| `IsDefault` | bool |  |

Response 200:

```text
Total: number
Page: number
PaymentTermList: [
  ID: guid
  Name: string
  Duration: number
  Method: string
  IsActive: boolean
  IsDefault: boolean
]
```

### POST `/`

Request body:

```text
Name: string
Duration: number
Method: string
IsActive: boolean
IsDefault: boolean
```

Response 200:

```text
Total: number
Page: number
PaymentTermList: [
  ID: guid
  Name: string
  Duration: number
  Method: string
  IsActive: boolean
  IsDefault: boolean
]
```

### PUT `/`

Request body:

```text
ID: guid
Name: string
Duration: number
Method: string
IsActive: boolean
IsDefault: boolean
```

Response 200:

```text
Total: number
Page: number
PaymentTermList: [
  ID: guid
  Name: string
  Duration: number
  Method: string
  IsActive: boolean
  IsDefault: boolean
]
```

### DELETE `/ref/paymentterm`

| Parameter | Type | Required |
|---|---|---|
| `ID` | Guid | yes |

Response 200:

```text
Success: boolean
```

