# Public API: Templates

From Cin7's API Blueprint: field tables (name, type, length, required, allowed values), each operation's query parameters, and request and response bodies as type outlines (`guid`, `string`, `number`, `boolean`, `date`, `null`; `[ … ]` = array of). Base `/ExternalApi/v2`; headers in [docs/PUBLIC-API.md](../../../docs/PUBLIC-API.md).

**Resources:** `/ref/templates`

## Fields

#### Templates

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `TemplateID` | GUID |  |  |  |
| `Type` | String |  |  |  |
| `Name` | String |  |  |  |
| `EmailSubject` | String |  |  |  |
| `CustomEmail` | String |  |  |  |

## Operations

### GET `/ref/templates`

| Parameter | Type | Required |
|---|---|---|
| `Page` | number |  |
| `Limit` | number |  |
| `Type` | string |  |
| `Name` | string |  |

Response 200:

```text
Page: number
Templates: [
  TemplateID: guid
  Type: string
  Name: string
  EmailSubject: string
  CustomEmail: null
]
```

