# Public API: Carrier

From Cin7's API Blueprint: field tables (name, type, length, required, allowed values), each operation's query parameters, and request and response bodies as type outlines (`guid`, `string`, `number`, `boolean`, `date`, `null`; `[ … ]` = array of). Base `/ExternalApi/v2`; headers in [docs/PUBLIC-API.md](../../../docs/PUBLIC-API.md).

**Resources:** `/ref/carrier`

## Fields

#### Carrier

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `CarrierID` | Guid |  |  |  |
| `Description` | String | 256 | Yes |  |

## Operations

### GET `/ref/carrier`

| Parameter | Type | Required |
|---|---|---|
| `Page` | number |  |
| `Limit` | number |  |
| `CarrierID` | Guid |  |
| `Description` | string |  |

Response 200:

```text
Total: number
Page: number
CarrierList: [
  CarrierID: guid
  Description: string
]
```

### POST `/`

Request body:

```text
Description: string
```

Response 200:

```text
Total: number
Page: number
CarrierList: [
  CarrierID: guid
  Description: string
]
```

### PUT `/`

Request body:

```text
CarrierID: guid
Description: string
```

Response 200:

```text
Total: number
Page: number
CarrierList: [
  CarrierID: guid
  Description: string
]
```

### DELETE `/ref/carrier`

| Parameter | Type | Required |
|---|---|---|
| `ID` | Guid | yes |

Response 200:

```text
Success: boolean
```

