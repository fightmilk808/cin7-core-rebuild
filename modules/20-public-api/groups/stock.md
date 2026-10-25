# Public API: Stock

From Cin7's API Blueprint: field tables (name, type, length, required, allowed values), each operation's query parameters, and request and response bodies as type outlines (`guid`, `string`, `number`, `boolean`, `date`, `null`; `[ … ]` = array of). Base `/ExternalApi/v2`; headers in [docs/PUBLIC-API.md](../../../docs/PUBLIC-API.md).

**Resources:** `/stockadjustmentList?Page={Page}&Limit={Limit}&Status={Status}` · `/stockadjustment` · `/stockTakeList` · `/stocktake` · `/stockTransferList` · `/stockTransfer` · `/stockTransfer/order`

## Fields

#### Stock Adjustment List

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `TaskID` | Guid |  |  |  |
| `EffectiveDate` | DateTime |  |  |  |
| `StocktakeNumber` | String |  |  |  |
| `Status` | String |  |  | `DRAFT`, `COMPLETED`, `VOIDED` |
| `Account` | String |  |  |  |
| `Reference` | String |  |  |  |
| `Comment` | String |  |  |  |

#### Stock Adjustment

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `TaskID` | Guid |  |  |  |
| `EffectiveDate` | DateTime |  |  |  |
| `StocktakeNumber` | String |  |  |  |
| `Status` | String |  |  | `DRAFT`, `COMPLETED`, `VOIDED` |
| `Account` | String |  |  |  |
| `Reference` | String |  |  |  |
| `ExistingStockLines` | [] Existing Stock Line Model |  |  |  |
| `NewStockLines` | [] New Stock Line Model |  |  |  |
| `Transactions` | [] Transaction Stock Line Model |  |  |  |

#### Post/Put

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `TaskID` | Guid |  |  |  |
| `EffectiveDate` | DateTime |  | Yes |  |
| `Status` | String |  | Yes | `DRAFT`, `COMPLETED` |
| `Account` | String |  |  |  |
| `Reference` | String |  |  |  |
| `Comment` | String |  |  |  |
| `UpdateOnHand` | Boolean |  |  |  |
| `Lines` | [] New Stock Line Model |  | Yes |  |

#### Stock Take List

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `TaskID` | Guid |  |  |  |
| `EffectiveDate` | DateTime |  |  |  |
| `StocktakeNumber` | String |  |  |  |
| `Status` | String |  |  | `DRAFT`, `COMPLETED`, `VOIDED` |
| `Account` | String |  |  |  |
| `LocationID` | String |  |  |  |
| `Location` | String |  |  |  |
| `Tags` | String |  |  |  |
| `PickZones` | String |  |  |  |
| `StockLocators` | String |  |  |  |
| `Categories` | String |  |  |  |
| `Brands` | String |  |  |  |
| `Bins` | String |  |  |  |
| `Reference` | String |  |  |  |
| `CreatedDate` | String |  |  |  |
| `LastUpdatedDate` | String |  |  |  |
| `LastUpdatedBy` | String |  |  |  |

#### Stock Take

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `TaskID` | Guid |  | Yes* |  |
| `EffectiveDate` | DateTime |  | Yes |  |
| `StocktakeNumber` | String |  |  |  |
| `Status` | String |  | Yes* | `DRAFT`, `IN PROGRESS`, `COMPLETED`, `VOIDED` |
| `Account` | String |  | Yes |  |
| `LocationID` | String |  | Yes* |  |
| `Location` | String |  | Yes* |  |
| `Tags` | [] string |  |  |  |
| `PickZones` | [] string |  |  |  |
| `StockLocators` | [] string |  |  |  |
| `Categories` | [] IDName Model |  |  |  |
| `Brands` | [] IDName Model |  |  |  |
| `Bins` | [] IDName Model |  |  |  |
| `Reference` | String |  |  |  |
| `NonZeroStockOnHandProducts` | [] Existing Stock Line Model |  |  |  |
| `ZeroStockOnHandProducts` | [] New Stock Line Model |  |  |  |
| `Transactions` | [] Transaction Stock Line Model |  |  |  |
| `UseRelativeQuantity` | Boolean |  |  |  |

#### Stock Transfer List

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `TaskID` | Guid |  |  |  |
| `From` | Guid |  |  |  |
| `FromLocation` | String |  |  |  |
| `To` | Guid |  |  |  |
| `ToLocation` | String |  |  |  |
| `Status` | String |  |  | `DRAFT`, `IN TRANSIT`, `COMPLETED`, `VOIDED` |
| `Number` | String |  |  |  |
| `CompletionDate` | DateTime |  |  |  |
| `CostDistributionType` | String |  |  | `Cost`, `Quantity`, `Weight`, `Volume` |
| `InTransitAccount` | String |  |  |  |
| `DepartureDate` | DateTime |  |  |  |
| `Reference` | String |  |  |  |
| `LastModifiedOn` | DateTime (read-only) |  |  |  |

#### Stock Transfer

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `TaskID` | Guid |  | Yes* |  |
| `From` | Guid |  | Yes* |  |
| `FromLocation` | String |  | Yes* |  |
| `To` | Guid |  | Yes* |  |
| `ToLocation` | String |  | Yes* |  |
| `Status` | String |  | Yes | `DRAFT`, `IN TRANSIT`, `COMPLETED`, `VOIDED` |
| `Number` | String |  |  |  |
| `CostDistributionType` | String |  |  | `Cost`, `Quantity`, `Weight`, `Volume`, `Cost` |
| `InTransitAccount` | String |  | Yes* |  |
| `DepartureDate` | DateTime |  | Yes* |  |
| `CompletionDate` | DateTime |  | Yes |  |
| `RequiredByDate` | DateTime |  |  |  |
| `Reference` | String |  |  |  |
| `SkipOrder` | Boolean |  |  |  |
| `Lines` | [] Stock Transfer Line Model |  | Yes |  |
| `Order` | Stock Transfer Order Model |  |  |  |
| `LastModifiedOn` | DateTime (read-only) |  |  |  |

#### Stock Transfer Order

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `TaskID` | Guid |  | Yes |  |
| `Status` | String |  | Yes | `DRAFT`, `AUTHORISED`, `NOT AVAILABLE` |
| `Lines` | [] Stock Transfer Order Line Model |  | Yes |  |
| `LastModifiedOn` | DateTime (read-only) |  |  |  |

## Operations

### GET `/`

| Parameter | Type | Required |
|---|---|---|
| `Page` | number |  |
| `Limit` | number |  |
| `Status` | string |  |

Response 200:

```text
Total: number
Page: number
StockAdjustmentList: [
  TaskID: guid
  EffectiveDate: date
  StocktakeNumber: string
  Status: string
  Account: string
  Reference: string
  Comment: string
]
```

### GET `/stockadjustment`

| Parameter | Type | Required |
|---|---|---|
| `TaskID` |  | yes |

Response 200:

```text
TaskID: guid
EffectiveDate: date
StocktakeNumber: string
Status: string
Account: string
Reference: string
Comment: string
ExistingStockLines: []
NewStockLines: [
  ProductID: guid
  SKU: string
  ProductName: string
  Quantity: number
  UnitCost: number
  LocationID: guid
  Location: string
  BatchSN: null
  ExpiryDate: null
  ReceivedDate: date
  Comments: string
  ProductLength: number
  ProductWidth: number
  ProductHeight: number
  ProductWeight: number
  WeightUnits: string
  DimensionsUnits: string
  ProductCustomField1: null
  ProductCustomField2: null
  ProductCustomField3: null
  ProductCustomField4: null
  ProductCustomField5: null
  ProductCustomField6: null
  ProductCustomField7: null
  ProductCustomField8: null
  ProductCustomField9: null
  ProductCustomField10: null
]
Transactions: [
  ID: guid
  Debit: string
  Credit: string
  Amount: number
  EffectiveDate: date
]
```

### POST `/`

Request body:

```text
EffectiveDate: date
StocktakeNumber: string
Status: string
Account: string
Reference: string
Comment: string
Lines: [
  ProductID: guid
  SKU: string
  ProductName: string
  Quantity: number
  UnitCost: number
  LocationID: guid
  Location: string
  BatchSN: null
  ExpiryDate: null
  ReceivedDate: date
  Comments: string
  ProductLength: number
  ProductWidth: number
  ProductHeight: number
  ProductWeight: number
  WeightUnits: string
  DimensionsUnits: string
  ProductCustomField1: null
  ProductCustomField2: null
  ProductCustomField3: null
  ProductCustomField4: null
  ProductCustomField5: null
  ProductCustomField6: null
  ProductCustomField7: null
  ProductCustomField8: null
  ProductCustomField9: null
  ProductCustomField10: null
]
```

Response 200:

```text
TaskID: guid
EffectiveDate: date
StocktakeNumber: string
Status: string
Account: string
Reference: string
Comment: string
ExistingStockLines: [
  ProductID: guid
  SKU: string
  ProductName: string
  QuantityOnHand: number
  Available: number
  Adjustment: number
  LocationID: guid
  Location: string
  BatchSN: null
  ExpiryDate: null
  Comments: string
  ProductLength: number
  ProductWidth: number
  ProductHeight: number
  ProductWeight: number
  ProductCustomField1: null
  ProductCustomField2: null
  ProductCustomField3: null
  ProductCustomField4: null
  ProductCustomField5: null
  ProductCustomField6: null
  ProductCustomField7: null
  ProductCustomField8: null
  ProductCustomField9: null
  ProductCustomField10: null
]
NewStockLines: []
Transactions: []
```

### PUT `/`

Request body:

```text
TaskID: guid
EffectiveDate: date
StocktakeNumber: string
Status: string
Account: string
Reference: string
Comment: string
Lines: [
  ProductID: guid
  SKU: string
  ProductName: string
  Quantity: number
  UnitCost: number
  LocationID: guid
  Location: string
  BatchSN: null
  ExpiryDate: null
  ReceivedDate: date
  Comments: string
  ProductLength: number
  ProductWidth: number
  ProductHeight: number
  ProductWeight: number
  WeightUnits: string
  DimensionsUnits: string
  ProductCustomField1: null
  ProductCustomField2: null
  ProductCustomField3: null
  ProductCustomField4: null
  ProductCustomField5: null
  ProductCustomField6: null
  ProductCustomField7: null
  ProductCustomField8: null
  ProductCustomField9: null
  ProductCustomField10: null
]
```

Response 200:

```text
TaskID: guid
EffectiveDate: date
StocktakeNumber: string
Status: string
Account: string
Reference: string
Comment: string
ExistingStockLines: [
  ProductID: guid
  SKU: string
  ProductName: string
  QuantityOnHand: number
  Available: number
  Adjustment: number
  LocationID: guid
  Location: string
  BatchSN: null
  ExpiryDate: null
  Comments: string
  ProductLength: number
  ProductWidth: number
  ProductHeight: number
  ProductWeight: number
  WeightUnits: string
  DimensionsUnits: string
  ProductCustomField1: null
  ProductCustomField2: null
  ProductCustomField3: null
  ProductCustomField4: null
  ProductCustomField5: null
  ProductCustomField6: null
  ProductCustomField7: null
  ProductCustomField8: null
  ProductCustomField9: null
  ProductCustomField10: null
]
NewStockLines: []
Transactions: [
  ID: guid
  Debit: string
  Credit: string
  Amount: number
  EffectiveDate: date
]
```

### DELETE `/stockadjustment`

| Parameter | Type | Required |
|---|---|---|
| `ID` |  | yes |
| `Void` | boolean |  |

Response 200:

```text
TaskID: guid
EffectiveDate: date
StocktakeNumber: string
Status: string
Account: string
Reference: string
Comment: string
ExistingStockLines: []
NewStockLines: []
Transactions: []
```

### GET `/stockTakeList`

| Parameter | Type | Required |
|---|---|---|
| `Page` | number |  |
| `Limit` | number |  |
| `Status` | string |  |

Response 200:

```text
Total: number
Page: number
StockAdjustmentList: [
  TaskID: guid
  EffectiveDate: date
  StocktakeNumber: string
  Status: string
  Account: string
  LocationID: guid
  Location: string
  Tags: string
  PickZones: string
  StockLocators: string
  Categories: string
  Brands: string
  Bins: string
  Reference: string
  CreatedDate: date
  LastUpdatedDate: date
  LastUpdatedBy: string
]
```

### GET `/stocktake`

| Parameter | Type | Required |
|---|---|---|
| `TaskID` |  | yes |

Response 200:

```text
TaskID: guid
EffectiveDate: date
StocktakeNumber: string
Status: string
Account: string
LocationID: guid
Location: string
Tags: [string]
PickZones: []
StockLocators: []
Categories: [
  ID: guid
  Name: string
]
Brands: []
Bins: []
Reference: string
NonZeroStockOnHandProducts: [
  ProductID: guid
  SKU: string
  ProductName: string
  QuantityOnHand: number
  Available: number
  Adjustment: number
  LocationID: guid
  Location: string
  BatchSN: string
  ExpiryDate: date
  Comments: null
  ProductLength: number
  ProductWidth: number
  ProductHeight: number
  ProductWeight: number
  WeightUnits: string
  DimensionsUnits: string
  ProductCustomField1: null
  ProductCustomField2: null
  ProductCustomField3: null
  ProductCustomField4: null
  ProductCustomField5: null
  ProductCustomField6: null
  ProductCustomField7: null
  ProductCustomField8: null
  ProductCustomField9: null
  ProductCustomField10: null
  Image: {
    ID: guid
    ContentType: string
    FileName: string
    DownloadUrl: string
  }
  Barcode: string
  StockLocator: string
  Unit: string
]
ZeroStockOnHandProducts: [
  ProductID: guid
  SKU: string
  ProductName: string
  Quantity: number
  UnitCost: number
  LocationID: guid
  Location: string
  BatchSN: null
  ExpiryDate: null
  ReceivedDate: date
  Comments: string
  ProductLength: number
  ProductWidth: number
  ProductHeight: number
  ProductWeight: number
  WeightUnits: string
  DimensionsUnits: string
  ProductCustomField1: null
  ProductCustomField2: null
  ProductCustomField3: null
  ProductCustomField4: null
  ProductCustomField5: null
  ProductCustomField6: null
  ProductCustomField7: null
  ProductCustomField8: null
  ProductCustomField9: null
  ProductCustomField10: null
  Image: {
    ID: guid
    ContentType: string
    FileName: string
    DownloadUrl: string
  }
  Barcode: string
  StockLocator: string
  Unit: string
]
Transactions: [
  ID: guid
  Debit: string
  Credit: string
  Amount: number
  EffectiveDate: date
]
```

### POST `/`

Request body:

```text
EffectiveDate: date
Account: string
LocationID: guid
Location: string
Tags: [string]
Categories: [
  ID: guid
  Name: string
]
Reference: string
```

Response 200:

```text
TaskID: guid
EffectiveDate: date
StocktakeNumber: string
Status: string
Account: string
LocationID: guid
Location: string
Tags: [string]
PickZones: []
StockLocators: []
Categories: [
  ID: guid
  Name: string
]
Brands: []
Bins: []
Reference: null
NonZeroStockOnHandProducts: [
  ProductID: guid
  SKU: string
  ProductName: string
  QuantityOnHand: number
  Available: number
  Adjustment: number
  LocationID: guid
  Location: string
  BatchSN: null
  ExpiryDate: null
  Comments: null
  ProductLength: number
  ProductWidth: number
  ProductHeight: number
  ProductWeight: number
  WeightUnits: string
  DimensionsUnits: string
  ProductCustomField1: string
  ProductCustomField2: string
  ProductCustomField3: string
  ProductCustomField4: string
  ProductCustomField5: string
  ProductCustomField6: string
  ProductCustomField7: string
  ProductCustomField8: string
  ProductCustomField9: string
  ProductCustomField10: string
  Image: {
    ID: guid
    ContentType: string
    FileName: string
    DownloadUrl: string
  }
  Barcode: string
  StockLocator: string
  Unit: string
  CostingMethod: string
]
ZeroStockOnHandProducts: []
Transactions: []
```

### PUT `/`

Request body:

```text
TaskID: guid
EffectiveDate: date
Status: string
Account: string
LocationID: guid
Location: string
UseRelativeQuantity: number
Tags: [string]
PickZones: []
StockLocators: []
Categories: [
  ID: guid
  Name: string
]
Brands: []
Bins: []
Reference: null
NonZeroStockOnHandProducts: [
  ProductID: guid
  SKU: string
  Adjustment: number
  LocationID: guid
  Location: string
  BatchSN: null
  ExpiryDate: null
]
ZeroStockOnHandProducts: [
  ProductID: guid
  SKU: string
  ProductName: string
  Quantity: number
  UnitCost: number
  LocationID: guid
  Location: string
  BatchSN: null
  ExpiryDate: null
  ReceivedDate: date
  Comments: string
]
```

Response 200:

```text
TaskID: guid
EffectiveDate: date
StocktakeNumber: string
Status: string
Account: string
LocationID: guid
Location: string
Tags: [string]
PickZones: []
StockLocators: []
Categories: [
  ID: guid
  Name: string
]
Brands: []
Bins: []
Reference: null
NonZeroStockOnHandProducts: [
  ProductID: guid
  SKU: string
  ProductName: string
  QuantityOnHand: number
  Available: number
  Adjustment: number
  LocationID: guid
  Location: string
  BatchSN: null
  ExpiryDate: null
  Comments: null
  ProductLength: number
  ProductWidth: number
  ProductHeight: number
  ProductWeight: number
  WeightUnits: string
  DimensionsUnits: string
  ProductCustomField1: string
  ProductCustomField2: string
  ProductCustomField3: string
  ProductCustomField4: string
  ProductCustomField5: string
  ProductCustomField6: string
  ProductCustomField7: string
  ProductCustomField8: string
  ProductCustomField9: string
  ProductCustomField10: string
  Image: {
    ID: guid
    ContentType: string
    FileName: string
    DownloadUrl: string
  }
  Barcode: string
  StockLocator: string
  Unit: string
  CostingMethod: string
]
ZeroStockOnHandProducts: [
  ProductID: guid
  SKU: string
  ProductName: string
  Quantity: number
  UnitCost: number
  LocationID: guid
  Location: string
  BatchSN: null
  ExpiryDate: null
  Comments: string
  ProductLength: number
  ProductWidth: number
  ProductHeight: number
  ProductWeight: number
  WeightUnits: string
  DimensionsUnits: string
  ProductCustomField1: string
  ProductCustomField2: string
  ProductCustomField3: string
  ProductCustomField4: string
  ProductCustomField5: string
  ProductCustomField6: string
  ProductCustomField7: string
  ProductCustomField8: string
  ProductCustomField9: string
  ProductCustomField10: string
  Image: {
    ID: guid
    ContentType: string
    FileName: string
    DownloadUrl: string
  }
  Barcode: string
  StockLocator: string
  Unit: string
  CostingMethod: string
]
Transactions: [
  ID: guid
  Debit: string
  Credit: string
  Amount: number
  EffectiveDate: date
]
```

### DELETE `/stocktake`

| Parameter | Type | Required |
|---|---|---|
| `ID` |  | yes |
| `Void` | boolean |  |

Response 200:

```text
TaskID: guid
EffectiveDate: date
StocktakeNumber: string
Status: string
Account: string
LocationID: guid
Location: string
Tags: [string]
PickZones: []
StockLocators: []
Categories: [
  ID: guid
  Name: string
]
Brands: []
Bins: []
Reference: string
NonZeroStockOnHandProducts: []
ZeroStockOnHandProducts: []
Transactions: []
```

### GET `/stockTransferList`

| Parameter | Type | Required |
|---|---|---|
| `Page` | number |  |
| `Limit` | number |  |
| `Status` | string |  |
| `Search` | string |  |

Response 200:

```text
Total: number
Page: number
StockTransferList: [
  TaskID: guid
  From: guid
  FromLocation: string
  To: guid
  ToLocation: string
  Status: string
  Number: string
  CompletionDate: date
  DepartureDate: date
  InTransitAccount: string
  CostDistributionType: string
  Reference: string
  LastModifiedOn: date
]
```

### GET `/stockTransfer`

| Parameter | Type | Required |
|---|---|---|
| `TaskID` |  | yes |

Response 200:

```text
TaskID: guid
Status: string
From: guid
FromLocation: string
To: guid
ToLocation: string
Number: string
CostDistributionType: string
InTransitAccount: string
DepartureDate: date
CompletionDate: date
RequiredByDate: date
Reference: string
Lines: [
  ProductID: guid
  SKU: string
  ProductName: string
  QuantityOnHand: number
  QuantityAvailable: number
  TransferQuantity: number
  BatchSN: string
  ExpiryDate: date
  Comments: string
  ProductLength: number
  ProductWidth: number
  ProductHeight: number
  ProductWeight: number
  WeightUnits: string
  DimensionsUnits: string
  ProductCustomField1: null
  ProductCustomField2: null
  ProductCustomField3: null
  ProductCustomField4: null
  ProductCustomField5: null
  ProductCustomField6: null
  ProductCustomField7: null
  ProductCustomField8: null
  ProductCustomField9: null
  ProductCustomField10: null
]
ManualJournals: []
SkipOrder: boolean
Order: {
  Status: string
  Lines: [
    ProductID: guid
    SKU: string
    ProductName: string
    QuantityOnHand: number
    QuantityAvailable: number
    TransferQuantity: number
    Comments: string
    ProductLength: number
    ProductWidth: number
    ProductHeight: number
    ProductWeight: number
    WeightUnits: null
    DimensionsUnits: null
    ProductCustomField1: null
    ProductCustomField2: null
    ProductCustomField3: null
    ProductCustomField4: null
    ProductCustomField5: null
    ProductCustomField6: null
    ProductCustomField7: null
    ProductCustomField8: null
    ProductCustomField9: null
    ProductCustomField10: null
  ]
}
LastModifiedOn: date
```

### POST `/`

Request body:

```text
Status: string
From: guid
FromLocation: string
To: guid
ToLocation: string
CostDistributionType: string
InTransitAccount: string
DepartureDate: date
CompletionDate: date
RequiredByDate: date
Reference: string
Lines: [
  ProductID: guid
  SKU: string
  ProductName: string
  TransferQuantity: number
  BatchSN: string
  ExpiryDate: date
  Comments: string
]
ManualJournals: []
SkipOrder: boolean
```

Response 200:

```text
TaskID: guid
Status: string
From: guid
FromLocation: string
To: guid
ToLocation: string
Number: string
CostDistributionType: string
InTransitAccount: string
DepartureDate: date
CompletionDate: date
RequiredByDate: date
Reference: string
Lines: [
  ProductID: guid
  SKU: string
  ProductName: string
  QuantityOnHand: number
  QuantityAvailable: number
  TransferQuantity: number
  BatchSN: string
  ExpiryDate: date
  Comments: string
  ProductLength: number
  ProductWidth: number
  ProductHeight: number
  ProductWeight: number
  WeightUnits: string
  DimensionsUnits: string
  ProductCustomField1: null
  ProductCustomField2: null
  ProductCustomField3: null
  ProductCustomField4: null
  ProductCustomField5: null
  ProductCustomField6: null
  ProductCustomField7: null
  ProductCustomField8: null
  ProductCustomField9: null
  ProductCustomField10: null
]
ManualJournals: []
SkipOrder: boolean
Order: {
  Status: string
  Lines: []
}
LastModifiedOn: date
```

### PUT `/`

Request body:

```text
TaskID: guid
Status: string
From: guid
FromLocation: string
To: guid
ToLocation: string
CostDistributionType: string
InTransitAccount: string
DepartureDate: date
CompletionDate: date
RequiredByDate: date
Reference: string
Lines: [
  ProductID: guid
  SKU: string
  ProductName: string
  TransferQuantity: number
  BatchSN: string
  ExpiryDate: date
  Comments: string
]
ManualJournals: []
SkipOrder: boolean
```

Response 200:

```text
TaskID: guid
Status: string
From: guid
FromLocation: string
To: guid
ToLocation: string
Number: string
CostDistributionType: string
InTransitAccount: string
DepartureDate: date
CompletionDate: date
RequiredByDate: date
Reference: string
Lines: [
  ProductID: guid
  SKU: string
  ProductName: string
  QuantityOnHand: number
  QuantityAvailable: number
  TransferQuantity: number
  BatchSN: string
  ExpiryDate: date
  Comments: string
  ProductLength: number
  ProductWidth: number
  ProductHeight: number
  ProductWeight: number
  WeightUnits: string
  DimensionsUnits: string
  ProductCustomField1: null
  ProductCustomField2: null
  ProductCustomField3: null
  ProductCustomField4: null
  ProductCustomField5: null
  ProductCustomField6: null
  ProductCustomField7: null
  ProductCustomField8: null
  ProductCustomField9: null
  ProductCustomField10: null
]
ManualJournals: []
SkipOrder: boolean
Order: {
  Status: string
  Lines: [
    ProductID: guid
    SKU: string
    ProductName: string
    QuantityOnHand: number
    QuantityAvailable: number
    TransferQuantity: number
    Comments: string
    ProductLength: number
    ProductWidth: number
    ProductHeight: number
    ProductWeight: number
    WeightUnits: null
    DimensionsUnits: null
    ProductCustomField1: null
    ProductCustomField2: null
    ProductCustomField3: null
    ProductCustomField4: null
    ProductCustomField5: null
    ProductCustomField6: null
    ProductCustomField7: null
    ProductCustomField8: null
    ProductCustomField9: null
    ProductCustomField10: null
  ]
}
LastModifiedOn: date
```

### DELETE `/stockTransfer`

| Parameter | Type | Required |
|---|---|---|
| `ID` |  | yes |
| `Void` | boolean |  |

Response 200:

```text
TaskID: guid
Status: string
From: guid
FromLocation: string
To: guid
ToLocation: string
Number: string
CostDistributionType: string
InTransitAccount: string
DepartureDate: date
CompletionDate: date
RequiredByDate: date
Reference: string
Lines: []
ManualJournals: []
SkipOrder: boolean
Order: {
  Status: string
  Lines: []
}
LastModifiedOn: date
```

### GET `/stockTransfer/order`

| Parameter | Type | Required |
|---|---|---|
| `TaskID` |  | yes |

Response 200:

```text
TaskID: guid
Status: string
Lines: [
  ProductID: guid
  SKU: string
  ProductName: string
  QuantityOnHand: number
  QuantityAvailable: number
  TransferQuantity: number
  Comments: string
  ProductLength: number
  ProductWidth: number
  ProductHeight: number
  ProductWeight: number
  WeightUnits: null
  DimensionsUnits: null
  ProductCustomField1: null
  ProductCustomField2: null
  ProductCustomField3: null
  ProductCustomField4: null
  ProductCustomField5: null
  ProductCustomField6: null
  ProductCustomField7: null
  ProductCustomField8: null
  ProductCustomField9: null
  ProductCustomField10: null
]
LastModifiedOn: date
```

### POST `/`

Request body:

```text
TaskID: guid
Status: string
Lines: [
  ProductID: guid
  SKU: string
  ProductName: string
  TransferQuantity: number
  Comments: string
]
LastModifiedOn: date
```

Response 200:

```text
TaskID: guid
Status: string
Lines: [
  ProductID: guid
  SKU: string
  ProductName: string
  QuantityOnHand: number
  QuantityAvailable: number
  TransferQuantity: number
  Comments: string
  ProductLength: number
  ProductWidth: number
  ProductHeight: number
  ProductWeight: number
  WeightUnits: null
  DimensionsUnits: null
  ProductCustomField1: null
  ProductCustomField2: null
  ProductCustomField3: null
  ProductCustomField4: null
  ProductCustomField5: null
  ProductCustomField6: null
  ProductCustomField7: null
  ProductCustomField8: null
  ProductCustomField9: null
  ProductCustomField10: null
]
LastModifiedOn: date
```

