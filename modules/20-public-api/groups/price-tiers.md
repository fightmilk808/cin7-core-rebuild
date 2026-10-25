# Public API: Price Tiers

From Cin7's API Blueprint: field tables (name, type, length, required, allowed values), each operation's query parameters, and request and response bodies as type outlines (`guid`, `string`, `number`, `boolean`, `date`, `null`; `[ … ]` = array of). Base `/ExternalApi/v2`; headers in [docs/PUBLIC-API.md](../../../docs/PUBLIC-API.md).

**Resources:** `/ref/priceTier`

## Fields

#### Price Tier

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `Code` | Integer |  |  |  |
| `Name` | String |  |  |  |

## Operations

### GET `/ref/priceTier`

Response 200:

```text
PriceTiers: [
  Code: number
  Name: string
]
```

