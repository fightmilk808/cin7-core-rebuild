# Public API: Fixed Asset Type

From Cin7's API Blueprint: field tables (name, type, length, required, allowed values), each operation's query parameters, and request and response bodies as type outlines (`guid`, `string`, `number`, `boolean`, `date`, `null`; `[ … ]` = array of). Base `/ExternalApi/v2`; headers in [docs/PUBLIC-API.md](../../../docs/PUBLIC-API.md).

**Resources:** `/ref/fixedassettype`

## Fields

#### Fixed Asset Types

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `FixedAssetTypeID` | Guid |  |  |  |
| `Name` | String | 50 | Yes |  |
| `DepreciationMethod` | String | 255 | Yes |  |
| `AveragingMethod` | String | 255 | Yes |  |
| `Rate` | Decimal |  | Yes |  |
| `EffectiveLife` | Decimal |  | Yes |  |
| `AssetAccountCode` | Decimal |  | Yes |  |
| `AccumulatedDepreciationAccountCode` | String |  | Yes |  |
| `AssetAccountName` | String (read-only) |  |  |  |
| `AccumulatedDepreciationAccountName` | String (read-only) |  |  |  |
| `DepreciationExpenseAccountName` | String (read-only) |  |  |  |

## Operations

### GET `/ref/fixedassettype`

| Parameter | Type | Required |
|---|---|---|
| `Page` | number |  |
| `Limit` | number |  |
| `FixedAssetTypeID` | Guid |  |
| `Name` | string |  |

Response 200:

```text
Total: number
Page: number
FixedAssetTypeList: [
  FixedAssetTypeID: guid
  Name: string
  DepreciationMethod: string
  AveragingMethod: string
  Rate: number
  EffectiveLife: null
  AssetAccountCode: string
  AccumulatedDepreciationAccountCode: string
  DepreciationExpenseAccountCode: string
  AssetAccountName: string
  AccumulatedDepreciationAccountName: string
  DepreciationExpenseAccountName: string
]
```

### POST `/`

Request body:

```text
Name: string
DepreciationMethod: string
AveragingMethod: string
Rate: number
EffectiveLife: null
AssetAccountCode: string
AccumulatedDepreciationAccountCode: string
DepreciationExpenseAccountCode: string
```

Response 200:

```text
Total: number
Page: number
FixedAssetTypeList: [
  FixedAssetTypeID: guid
  Name: string
  DepreciationMethod: string
  AveragingMethod: string
  Rate: number
  EffectiveLife: null
  AssetAccountCode: string
  AccumulatedDepreciationAccountCode: string
  DepreciationExpenseAccountCode: string
  AssetAccountName: string
  AccumulatedDepreciationAccountName: string
  DepreciationExpenseAccountName: string
]
```

### PUT `/`

Request body:

```text
FixedAssetTypeID: guid
Name: string
DepreciationMethod: string
AveragingMethod: string
Rate: number
EffectiveLife: null
AssetAccountCode: string
AccumulatedDepreciationAccountCode: string
DepreciationExpenseAccountCode: string
```

Response 200:

```text
Total: number
Page: number
FixedAssetTypeList: [
  FixedAssetTypeID: guid
  Name: string
  DepreciationMethod: string
  AveragingMethod: string
  Rate: number
  EffectiveLife: null
  AssetAccountCode: string
  AccumulatedDepreciationAccountCode: string
  DepreciationExpenseAccountCode: string
  AssetAccountName: string
  AccumulatedDepreciationAccountName: string
  DepreciationExpenseAccountName: string
]
```

