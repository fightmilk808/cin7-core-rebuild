# Public API: Product Markup Prices

From Cin7's API Blueprint: field tables (name, type, length, required, allowed values), each operation's query parameters, and request and response bodies as type outlines (`guid`, `string`, `number`, `boolean`, `date`, `null`; `[ … ]` = array of). Base `/ExternalApi/v2`; headers in [docs/PUBLIC-API.md](../../../docs/PUBLIC-API.md).

**Resources:** `/ref/markupprices`

## Operations

### GET `/product/markupprices`

| Parameter | Type | Required |
|---|---|---|
| `ProductID` |  | yes |

Response 200:

```text
ProductID: guid
MarkupPrices: [
  TierNumber: number
  MarkupType: string
  UsePriceType: string
  MarkupValue: number
]
```

### PUT `/product/markupprices`

Request body:

```text
keys: MarkupType, MarkupValue, TierNumber, UsePriceType
```

Response 200:

```text
ProductID: guid
MarkupPrices: [
  TierNumber: number
  MarkupType: string
  UsePriceType: string
  MarkupValue: number
]
```

