# Public API: Unit of Measure

From Cin7's API Blueprint: field tables (name, type, length, required, allowed values), each operation's query parameters, and request and response bodies as type outlines (`guid`, `string`, `number`, `boolean`, `date`, `null`; `[ … ]` = array of). Base `/ExternalApi/v2`; headers in [docs/PUBLIC-API.md](../../../docs/PUBLIC-API.md).

**Resources:** `/ref/unit`

## Fields

#### Unit of Measure

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `ID` | Guid |  |  |  |
| `Name` | String | 50 | Yes |  |

## Operations

### GET `/ref/unit`

| Parameter | Type | Required |
|---|---|---|
| `Page` | number |  |
| `Limit` | number |  |
| `Name` |  |  |

Response 200:

```text
Total: number
Page: number
UnitList: [
  ID: guid
  Name: string
]
```

### POST `/`

Request body:

```text
Name: string
```

Response 200:

```text
ID: guid
Name: string
```

### PUT `/`

Request body:

```text
ID: guid
Name: string
```

Response 200:

```text
ID: guid
Name: string
```

### DELETE `/ref/unit`

| Parameter | Type | Required |
|---|---|---|
| `ID` | string | yes |

Response 200:

```text
Success: boolean
```

