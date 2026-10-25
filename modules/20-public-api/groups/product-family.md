# Public API: Product Family

From Cin7's API Blueprint: field tables (name, type, length, required, allowed values), each operation's query parameters, and request and response bodies as type outlines (`guid`, `string`, `number`, `boolean`, `date`, `null`; `[ … ]` = array of). Base `/ExternalApi/v2`; headers in [docs/PUBLIC-API.md](../../../docs/PUBLIC-API.md).

**Resources:** `/productFamily` · `/productFamily/attachments`

## Fields

#### Product Family

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `Products` | [] Product Family Product Line Model |  |  |  |
| `ID` | Guid |  |  |  |
| `SKU` | String | 45 | Yes |  |
| `Name` | String | 256 | Yes |  |
| `Category` | String | 256 | Yes |  |
| `Brand` | String | 256 |  |  |
| `CostingMethod` | String |  | Yes |  |
| `DefaultLocation` | String | 256 | Yes |  |
| `UOM` | String | 0 | Yes |  |
| `MinimumBeforeReorder` | Decimal  (Nullable) |  |  |  |
| `ReorderQuantity` | Decimal  (Nullable) |  |  |  |
| `PriceTier1` | Decimal |  |  |  |
| `PriceTier2` | Decimal |  |  |  |
| `PriceTier3` | Decimal |  |  |  |
| `PriceTier4` | Decimal |  |  |  |
| `PriceTier5` | Decimal |  |  |  |
| `PriceTier6` | Decimal |  |  |  |
| `PriceTier7` | Decimal |  |  |  |
| `PriceTier8` | Decimal |  |  |  |
| `PriceTier9` | Decimal |  |  |  |
| `PriceTier10` | Decimal |  |  |  |
| `ShortDescription` | String | 500 |  |  |
| `Description` | String | Unlimited |  |  |
| `AttributeSet` | String | 50 |  |  |
| `DiscountRule` | String | 128 |  |  |
| `Tags` | String | 256 |  |  |
| `COGSAccount` | String | 50 |  |  |
| `RevenueAccount` | String | 50 |  |  |
| `InventoryAccount` | String | 50 |  |  |
| `PurchaseTaxRule` | String | 50 |  |  |
| `SaleTaxRule` | String | 50 |  |  |
| `DropShipMode` | String |  |  |  |
| `Option1Name` | String | 50 | Yes |  |
| `Option2Name` | String | 50 |  |  |
| `Option3Name` | String | 50 |  |  |
| `Option1Values` | String (read-only) |  |  |  |
| `Option2Values` | String (read-only) |  |  |  |
| `Option3Values` | String (read-only) |  |  |  |
| `LastModifiedOn` | DateTime  (Nullable) |  |  |  |
| `Attachments` | [] Attachment Line Model |  |  |  |
| `HSCode` | String | 200 |  |  |
| `CountryOfOrigin` | String |  |  |  |
| `CountryOfOriginCode` | String |  |  |  |

#### POST Methods

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `FamilyID` | Guid |  | Yes |  |
| `FileName` | String |  | Yes |  |
| `IsDefault` | Boolean |  |  |  |
| `FileDownloadUrl` | String |  | No |  |
| `Content` | String |  | Yes |  |

## Operations

### GET `/productFamily`

| Parameter | Type | Required |
|---|---|---|
| `ID` |  |  |
| `Page` | number |  |
| `Limit` | number |  |
| `Name` |  |  |
| `Sku` |  |  |
| `ModifiedSince` | date |  |

Response 200:

```text
Total: number
Page: number
ProductFamilies: [
  Products: [
    ID: guid
    SKU: string
    Name: string
    Option1: string
    Option2: string
    Option3: string
  ]
  ID: guid
  SKU: string
  Name: string
  Category: string
  DefaultLocation: string
  Brand: null
  CostingMethod: string
  UOM: string
  MinimumBeforeReorder: number
  ReorderQuantity: number
  PriceTier1: number
  PriceTier2: number
  PriceTier3: number
  PriceTier4: number
  PriceTier5: number
  PriceTier6: number
  PriceTier7: number
  PriceTier8: number
  PriceTier9: number
  PriceTier10: number
  ShortDescription: null
  Description: null
  AttributeSet: null
  DiscountRule: null
  Tags: string
  COGSAccount: null
  RevenueAccount: null
  InventoryAccount: null
  PurchaseTaxRule: null
  SaleTaxRule: null
  DropShipMode: string
  Option1Name: string
  Option2Name: string
  Option3Name: string
  Option1Values: string
  Option2Values: string
  Option3Values: string
  LastModifiedOn: date
  Attachments: [
    ID: guid
    ContentType: string
    FileName: string
    DownloadUrl: string
  ]
  HSCode: string
  CountryOfOrigin: string
  CountryOfOriginCode: string
]
```

### POST `/`

Request body:

```text
Products: [
  ID: guid
  SKU: string
  Name: string
  Option1: string
  Option2: string
  Option3: string
]
SKU: string
Name: string
Category: string
DefaultLocation: string
Brand: null
CostingMethod: string
UOM: string
MinimumBeforeReorder: number
ReorderQuantity: number
PriceTier1: number
PriceTier2: number
PriceTier3: number
PriceTier4: number
PriceTier5: number
PriceTier6: number
PriceTier7: number
PriceTier8: number
PriceTier9: number
PriceTier10: number
ShortDescription: string
Description: string
AttributeSet: null
DiscountRule: null
Tags: string
COGSAccount: null
RevenueAccount: null
InventoryAccount: null
PurchaseTaxRule: null
SaleTaxRule: null
DropShipMode: string
Option1Name: string
Option2Name: string
Option3Name: string
HSCode: string
CountryOfOrigin: string
```

Response 200:

```text
Total: number
Page: number
ProductFamilies: [
  Products: [
    ID: guid
    SKU: string
    Name: string
    Option1: string
    Option2: string
    Option3: string
  ]
  ID: guid
  SKU: string
  Name: string
  Category: string
  DefaultLocation: string
  Brand: null
  CostingMethod: string
  UOM: string
  MinimumBeforeReorder: number
  ReorderQuantity: number
  PriceTier1: number
  PriceTier2: number
  PriceTier3: number
  PriceTier4: number
  PriceTier5: number
  PriceTier6: number
  PriceTier7: number
  PriceTier8: number
  PriceTier9: number
  PriceTier10: number
  ShortDescription: string
  Description: string
  AttributeSet: null
  DiscountRule: null
  Tags: string
  COGSAccount: null
  RevenueAccount: null
  InventoryAccount: null
  PurchaseTaxRule: null
  SaleTaxRule: null
  DropShipMode: string
  Option1Name: string
  Option2Name: string
  Option3Name: string
  Option1Values: string
  Option2Values: string
  Option3Values: string
  LastModifiedOn: date
  Attachments: []
  HSCode: string
  CountryOfOrigin: string
  CountryOfOriginCode: string
]
```

### PUT `/`

Request body:

```text
ID: guid
Products: [
  ID: guid
  SKU: string
  Name: string
  Option1: string
  Option2: string
  Option3: string
]
SKU: string
Name: string
Category: string
DefaultLocation: string
Brand: null
CostingMethod: string
UOM: string
MinimumBeforeReorder: number
ReorderQuantity: number
PriceTier1: number
PriceTier2: number
PriceTier3: number
PriceTier4: number
PriceTier5: number
PriceTier6: number
PriceTier7: number
PriceTier8: number
PriceTier9: number
PriceTier10: number
ShortDescription: string
Description: string
AttributeSet: null
DiscountRule: null
Tags: string
COGSAccount: null
RevenueAccount: null
InventoryAccount: null
PurchaseTaxRule: null
SaleTaxRule: null
DropShipMode: string
Option1Name: string
Option2Name: string
Option3Name: string
HSCode: string
CountryOfOrigin: string
```

Response 200:

```text
Total: number
Page: number
ProductFamilies: [
  Products: [
    ID: guid
    SKU: string
    Name: string
    Option1: string
    Option2: string
    Option3: string
  ]
  ID: guid
  SKU: string
  Name: string
  Category: string
  DefaultLocation: string
  Brand: null
  CostingMethod: string
  UOM: string
  MinimumBeforeReorder: number
  ReorderQuantity: number
  PriceTier1: number
  PriceTier2: number
  PriceTier3: number
  PriceTier4: number
  PriceTier5: number
  PriceTier6: number
  PriceTier7: number
  PriceTier8: number
  PriceTier9: number
  PriceTier10: number
  ShortDescription: string
  Description: string
  AttributeSet: null
  DiscountRule: null
  Tags: string
  COGSAccount: null
  RevenueAccount: null
  InventoryAccount: null
  PurchaseTaxRule: null
  SaleTaxRule: null
  DropShipMode: string
  Option1Name: string
  Option2Name: string
  Option3Name: string
  Option1Values: string
  Option2Values: string
  Option3Values: string
  LastModifiedOn: date
  Attachments: []
  HSCode: string
  CountryOfOrigin: string
  CountryOfOriginCode: string
]
```

### GET `/productFamily/attachments`

| Parameter | Type | Required |
|---|---|---|
| `FamilyID` |  |  |

Response 200:

```text
[
  ID: guid
  ContentType: string
  IsDefault: string
  FileName: string
  DownloadUrl: string
]
```

### POST `/`

Request body:

```text
keys: 
```

Response 200:

```text
[
  ID: guid
  ContentType: string
  IsDefault: string
  FileName: string
  DownloadUrl: string
]
```

### DELETE `/productFamily/attachments`

| Parameter | Type | Required |
|---|---|---|
| `ID` |  |  |

Response 200:

```text
[
  ID: guid
  ContentType: string
  IsDefault: string
  FileName: string
  DownloadUrl: string
]
```

