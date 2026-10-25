# Public API: Attribute Set

From Cin7's API Blueprint: field tables (name, type, length, required, allowed values), each operation's query parameters, and request and response bodies as type outlines (`guid`, `string`, `number`, `boolean`, `date`, `null`; `[ … ]` = array of). Base `/ExternalApi/v2`; headers in [docs/PUBLIC-API.md](../../../docs/PUBLIC-API.md).

**Resources:** `/ref/attributeset`

## Fields

#### Attribute Set

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `ID` | Guid |  | Yes* |  |
| `Name` | String | 50 | Yes |  |
| `Attribute#Name` | String | 50 | Yes* |  |
| `Attribute#Type` | String | 50 | Yes* | `Not used`, `Text`, `Checkbox`, `List`, `Date`, `Numeric` |
| `Attribute#Values` | String |  | Yes* |  |
| `Attributes` | [] Attribute Set Line Model (read-only) |  |  |  |

## Operations

### GET `/ref/attributeset`

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
AttributeSetList: [
  ID: guid
  Name: string
  Attribute1Name: string
  Attribute1Type: string
  Attribute1Values: string
  Attribute2Name: string
  Attribute2Type: string
  Attribute2Values: string
  Attribute3Name: string
  Attribute3Type: string
  Attribute3Values: string
  Attribute4Name: string
  Attribute4Type: string
  Attribute4Values: string
  Attribute5Name: string
  Attribute5Type: string
  Attribute5Values: string
  Attribute6Name: string
  Attribute6Type: string
  Attribute6Values: string
  Attribute7Name: string
  Attribute7Type: string
  Attribute7Values: string
  Attribute8Name: string
  Attribute8Type: string
  Attribute8Values: string
  Attribute9Name: string
  Attribute9Type: string
  Attribute9Values: string
  Attribute10Name: string
  Attribute10Type: string
  Attribute10Values: string
  Attributes: [
    Name: string
    Type: string
    Values: string
  ]
]
```

### POST `/`

Request body:

```text
Name: string
Attribute1Name: string
Attribute1Type: string
Attribute1Values: string
Attribute2Name: string
Attribute2Type: string
Attribute2Values: string
Attribute3Name: string
Attribute3Type: string
Attribute3Values: string
```

Response 200:

```text
ID: guid
Name: string
Attribute1Name: string
Attribute1Type: string
Attribute1Values: string
Attribute2Name: string
Attribute2Type: string
Attribute2Values: string
Attribute3Name: string
Attribute3Type: string
Attribute3Values: string
Attribute4Name: string
Attribute4Type: string
Attribute4Values: string
Attribute5Name: string
Attribute5Type: string
Attribute5Values: string
Attribute6Name: string
Attribute6Type: string
Attribute6Values: string
Attribute7Name: string
Attribute7Type: string
Attribute7Values: string
Attribute8Name: string
Attribute8Type: string
Attribute8Values: string
Attribute9Name: string
Attribute9Type: string
Attribute9Values: string
Attribute10Name: string
Attribute10Type: string
Attribute10Values: string
Attributes: [
  Name: string
  Type: string
  Values: string
]
```

### PUT `/`

Request body:

```text
ID: guid
Name: string
Attribute1Name: string
Attribute1Type: string
Attribute1Values: string
Attribute2Name: string
Attribute2Type: string
Attribute2Values: string
Attribute3Name: string
Attribute3Type: string
Attribute3Values: string
Attribute4Name: string
Attribute4Type: string
Attribute4Values: string
Attribute5Name: string
Attribute5Type: string
Attribute5Values: string
Attribute6Name: string
Attribute6Type: string
Attribute6Values: string
```

Response 200:

```text
ID: guid
Name: string
Attribute1Name: string
Attribute1Type: string
Attribute1Values: string
Attribute2Name: string
Attribute2Type: string
Attribute2Values: string
Attribute3Name: string
Attribute3Type: string
Attribute3Values: string
Attribute4Name: string
Attribute4Type: string
Attribute4Values: string
Attribute5Name: string
Attribute5Type: string
Attribute5Values: string
Attribute6Name: string
Attribute6Type: string
Attribute6Values: string
Attribute7Name: string
Attribute7Type: string
Attribute7Values: string
Attribute8Name: string
Attribute8Type: string
Attribute8Values: string
Attribute9Name: string
Attribute9Type: string
Attribute9Values: string
Attribute10Name: string
Attribute10Type: string
Attribute10Values: string
Attributes: [
  Name: string
  Type: string
  Values: string
]
```

### DELETE `/ref/attributeset`

| Parameter | Type | Required |
|---|---|---|
| `ID` | string | yes |

Response 200:

```text
Success: boolean
```

