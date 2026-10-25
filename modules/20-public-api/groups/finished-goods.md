# Public API: Finished Goods

From Cin7's API Blueprint: field tables (name, type, length, required, allowed values), each operation's query parameters, and request and response bodies as type outlines (`guid`, `string`, `number`, `boolean`, `date`, `null`; `[ … ]` = array of). Base `/ExternalApi/v2`; headers in [docs/PUBLIC-API.md](../../../docs/PUBLIC-API.md).

**Resources:** `/finishedGoodsList` · `/finishedGoods` · `/finishedGoods/order` · `/finishedGoods/pick`

## Fields

#### Finished Goods List

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `TaskID` | Guid |  |  |  |
| `AssemblyNumber` | String |  |  |  |
| `BatchSN` | String |  |  |  |
| `ExpiryDate` | DateTime |  |  |  |
| `ProductID` | Guid |  |  |  |
| `ProductCode` | String |  |  |  |
| `ProductName` | String |  |  |  |
| `Quantity` | Decimal |  |  |  |
| `LocationID` | Guid |  |  |  |
| `Location` | String |  |  |  |
| `Date` | DateTime |  |  |  |
| `Status` | String |  |  | `DRAFT`, `AUTHORISED`, `IN PROGRESS`, `COMPLETED`, `VOIDED` |
| `UnitCost` | Decimal |  |  |  |
| `Notes` | String |  |  |  |
| `CustomField1` | String |  |  |  |
| `CustomField2` | String |  |  |  |
| `CustomField3` | String |  |  |  |
| `CustomField4` | String |  |  |  |
| `CustomField5` | String |  |  |  |
| `CustomField6` | String |  |  |  |
| `CustomField7` | String |  |  |  |
| `CustomField8` | String |  |  |  |
| `CustomField9` | String |  |  |  |
| `CustomField10` | String |  |  |  |

#### Finished Goods

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `TaskID` | Guid |  |  |  |
| `AssemblyNumber` | String |  |  |  |
| `Status` | String |  |  | `DRAFT`, `AUTHORISED`, `IN PROGRESS`, `COMPLETED`, `VOIDED` |
| `ProductID` | Guid |  |  |  |
| `ProductCode` | String |  |  |  |
| `ProductName` | String |  |  |  |
| `LocationID` | Guid |  |  |  |
| `Location` | String |  |  |  |
| `BinID` | Guid |  |  |  |
| `Bin` | Decimal |  |  |  |
| `WIPAccount` | String |  |  |  |
| `WIPDate` | DateTime |  |  |  |
| `Account` | String |  |  |  |
| `Quantity` | Decimal |  |  |  |
| `AssemblyInstructionURL` | String |  |  |  |
| `CompletionDate` | DateTime |  |  |  |
| `BatchSN` | String |  |  |  |
| `ExpiryDate` | DateTime |  |  |  |
| `Notes` | String |  |  |  |
| `OrderLines` | [] Finished Goods Order Line Model |  |  |  |
| `PickLines` | [] Finished Goods Pick Line Model |  |  |  |
| `Transactions` | [] Transaction Stock Line Model |  |  |  |
| `Errors` | [] Error Model |  |  |  |
| `CustomField1` | String |  |  |  |
| `CustomField2` | String |  |  |  |
| `CustomField3` | String |  |  |  |
| `CustomField4` | String |  |  |  |
| `CustomField5` | String |  |  |  |
| `CustomField6` | String |  |  |  |
| `CustomField7` | String |  |  |  |
| `CustomField8` | String |  |  |  |
| `CustomField9` | String |  |  |  |
| `CustomField10` | String |  |  |  |

#### POST method

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `Status` | String |  | Yes | `DRAFT`, `AUTHORISED`, `IN PROGRESS`, `COMPLETED` |
| `ProductID` | Guid |  | Yes* |  |
| `ProductCode` | String |  | Yes* |  |
| `LocationID` | Guid |  | Yes* |  |
| `Location` | Decimal |  | Yes* |  |
| `BinID` | Guid |  |  |  |
| `Bin` | Decimal |  |  |  |
| `WIPAccount` | String |  | Yes |  |
| `WIPDate` | DateTime |  | Yes* |  |
| `Account` | String |  | Yes |  |
| `Quantity` | Decimal |  | Yes |  |
| `CompletionDate` | DateTime |  | Yes |  |
| `BatchSN` | String |  |  |  |
| `ExpiryDate` | DateTime |  |  |  |
| `Notes` | String |  |  |  |
| `CustomField1` | String |  |  |  |
| `CustomField2` | String |  |  |  |
| `CustomField3` | String |  |  |  |
| `CustomField4` | String |  |  |  |
| `CustomField5` | String |  |  |  |
| `CustomField6` | String |  |  |  |
| `CustomField7` | String |  |  |  |
| `CustomField8` | String |  |  |  |
| `CustomField9` | String |  |  |  |
| `CustomField10` | String |  |  |  |

#### PUT method

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `ID` | Guid |  | Yes |  |
| `ProductID` | Guid |  | No |  |
| `ProductCode` | String |  | No |  |
| `LocationID` | Guid |  | No |  |
| `Location` | Decimal |  | No |  |
| `BinID` | Guid |  |  |  |
| `Bin` | Decimal |  |  |  |
| `WIPAccount` | String |  | No |  |
| `WIPDate` | DateTime |  | No |  |
| `Account` | String |  | No |  |
| `Quantity` | Decimal |  | No |  |
| `CompletionDate` | DateTime |  | No |  |
| `BatchSN` | String |  |  |  |
| `ExpiryDate` | DateTime |  |  |  |
| `Notes` | String |  |  |  |
| `CustomField1` | String |  |  |  |
| `CustomField2` | String |  |  |  |
| `CustomField3` | String |  |  |  |
| `CustomField4` | String |  |  |  |
| `CustomField5` | String |  |  |  |
| `CustomField6` | String |  |  |  |
| `CustomField7` | String |  |  |  |
| `CustomField8` | String |  |  |  |
| `CustomField9` | String |  |  |  |
| `CustomField10` | String |  |  |  |

#### Finished Goods Order

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `TaskID` | Guid |  |  |  |
| `Status` | String |  |  | `DRAFT`, `AUTHORISED`, `IN PROGRESS`, `COMPLETED`, `VOIDED`, `POST`, `DRAFT`, `AUTHORISED` |
| `OrderLines` | [] Finished Goods Order Line Model |  |  |  |

#### Finished Goods Pick

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `TaskID` | Guid |  |  |  |
| `Status` | String |  |  | `DRAFT`, `AUTHORISED`, `IN PROGRESS`, `COMPLETED`, `VOIDED`, `POST`, `AUTHORISED`, `IN PROGRESS`, `COMPLETED` |
| `WIPAccount` | String (read-only) |  |  |  |
| `WIPDate` | DateTime (read-only) |  |  |  |
| `Account` | String (read-only) |  |  |  |
| `CompletionDate` | DateTime (read-only) |  | Yes |  |
| `PickLines` | [] Finished Goods Pick Line Model |  |  |  |

## Operations

### GET `/finishedGoodsList`

| Parameter | Type | Required |
|---|---|---|
| `Page` | number |  |
| `Limit` | number |  |
| `Status` |  |  |
| `Search` |  |  |
| `SaleID` |  |  |

Response 200:

```text
Total: number
Page: number
FinishedGoods: [
  TaskID: guid
  AssemblyNumber: string
  BatchSN: string
  ExpiryDate: date
  ProductID: guid
  ProductCode: string
  ProductName: string
  Quantity: number
  LocationID: guid
  Location: string
  Date: date
  Status: string
  UnitCost: number
  Notes: string
  CustomField1: string
  CustomField2: string
  CustomField3: string
  CustomField4: string
  CustomField5: string
  CustomField6: string
  CustomField7: string
  CustomField8: string
  CustomField9: string
  CustomField10: string
]
```

### GET `/finishedGoods`

| Parameter | Type | Required |
|---|---|---|
| `TaskID` |  |  |

Response 200:

```text
TaskID: guid
AssemblyNumber: string
Status: string
ProductID: guid
ProductCode: string
ProductName: string
LocationID: guid
Location: string
BinID: guid
Bin: string
WIPAccount: string
WIPDate: date
Account: string
Quantity: number
AssemblyInstructionURL: string
CompletionDate: date
BatchSN: string
ExpiryDate: date
Notes: string
CustomField1: string
CustomField2: string
CustomField3: string
CustomField4: string
CustomField5: string
CustomField6: string
CustomField7: string
CustomField8: string
CustomField9: string
CustomField10: string
OrderLines: [
  ProductID: guid
  ProductCode: string
  Name: string
  ExpenseAccount: string
  Quantity: number
  Unit: string
  WastagePercent: number
  WastageQuantity: number
  TotalQuantity: number
  TotalCost: number
]
PickLines: [
  ProductID: guid
  ProductCode: string
  Name: string
  BinID: null
  Bin: null
  BatchSN: null
  ExpiryDate: null
  Quantity: number
  Unit: string
  Cost: number
]
Transactions: []
Errors: []
```

### POST `/`

Request body:

```text
Status: string
ProductID: guid
ProductCode: string
ProductName: string
LocationID: guid
Location: string
BinID: string
Bin: string
WIPAccount: string
WIPDate: date
Account: string
Quantity: number
CompletionDate: date
BatchSN: string
ExpiryDate: date
Notes: string
CustomField1: string
CustomField2: string
CustomField3: string
CustomField4: string
CustomField5: string
CustomField6: string
CustomField7: string
CustomField8: string
CustomField9: string
CustomField10: string
```

Response 200:

```text
TaskID: guid
AssemblyNumber: string
Status: string
ProductID: guid
ProductCode: string
ProductName: string
LocationID: guid
Location: string
BinID: null
Bin: null
WIPAccount: string
WIPDate: date
Account: string
Quantity: number
AssemblyInstructionURL: string
CompletionDate: date
BatchSN: string
ExpiryDate: date
Notes: null
CustomField1: string
CustomField2: string
CustomField3: string
CustomField4: string
CustomField5: string
CustomField6: string
CustomField7: string
CustomField8: string
CustomField9: string
CustomField10: string
OrderLines: [
  ProductID: guid
  ProductCode: string
  Name: string
  ExpenseAccount: null
  Quantity: number
  Unit: string
  WastagePercent: number
  WastageQuantity: number
  TotalQuantity: number
  TotalCost: number
]
PickLines: [
  ProductID: guid
  ProductCode: string
  Name: string
  BinID: guid
  Bin: string
  BatchSN: null
  ExpiryDate: null
  Quantity: number
  Unit: string
  Cost: number
]
Transactions: []
Errors: []
```

### PUT `/`

Request body:

```text
ID: guid
ProductID: guid
ProductCode: string
ProductName: string
LocationID: guid
Location: string
BinID: string
Bin: string
WIPAccount: string
WIPDate: date
Account: string
Quantity: number
CompletionDate: date
BatchSN: string
ExpiryDate: date
Notes: string
CustomField1: string
CustomField2: string
CustomField3: string
CustomField4: string
CustomField5: string
CustomField6: string
CustomField7: string
CustomField8: string
CustomField9: string
CustomField10: string
```

Response 200:

```text
TaskID: guid
AssemblyNumber: string
Status: string
ProductID: guid
ProductCode: string
ProductName: string
LocationID: guid
Location: string
BinID: null
Bin: null
WIPAccount: string
WIPDate: date
Account: string
Quantity: number
AssemblyInstructionURL: string
CompletionDate: date
BatchSN: string
ExpiryDate: date
Notes: null
CustomField1: string
CustomField2: string
CustomField3: string
CustomField4: string
CustomField5: string
CustomField6: string
CustomField7: string
CustomField8: string
CustomField9: string
CustomField10: string
OrderLines: [
  ProductID: guid
  ProductCode: string
  Name: string
  ExpenseAccount: null
  Quantity: number
  Unit: string
  WastagePercent: number
  WastageQuantity: number
  TotalQuantity: number
  TotalCost: number
]
PickLines: [
  ProductID: guid
  ProductCode: string
  Name: string
  BinID: guid
  Bin: string
  BatchSN: null
  ExpiryDate: null
  Quantity: number
  Unit: string
  Cost: number
]
Transactions: []
Errors: []
```

### DELETE `/finishedGoods` (Delete)

| Parameter | Type | Required |
|---|---|---|
| `ID` |  | yes |
| `Void` | boolean |  |

Response 200:

```text
TaskID: guid
AssemblyNumber: string
Status: string
ProductID: guid
ProductCode: string
ProductName: string
LocationID: guid
Location: string
BinID: null
Bin: null
WIPAccount: string
WIPDate: date
Account: string
Quantity: number
AssemblyInstructionURL: string
CompletionDate: date
BatchSN: string
ExpiryDate: date
Notes: null
CustomField1: string
CustomField2: string
CustomField3: string
CustomField4: string
CustomField5: string
CustomField6: string
CustomField7: string
CustomField8: string
CustomField9: string
CustomField10: string
OrderLines: []
PickLines: []
Transactions: []
Errors: []
```

### GET `/finishedGoods/order`

| Parameter | Type | Required |
|---|---|---|
| `TaskID` |  |  |

Response 200:

```text
TaskID: guid
Status: string
OrderLines: [
  ProductID: guid
  ProductCode: string
  Name: string
  ExpenseAccount: string
  Quantity: number
  Unit: string
  WastagePercent: number
  WastageQuantity: number
  TotalQuantity: number
  TotalCost: number
]
```

### POST `/`

Request body:

```text
TaskID: guid
Status: string
OrderLines: [
  ProductID: guid
  ProductCode: string
  Name: string
  ExpenseAccount: string
  Quantity: number
  Unit: string
  WastagePercent: number
  WastageQuantity: number
  TotalQuantity: number
  TotalCost: number
]
```

Response 200:

```text
TaskID: guid
Status: string
OrderLines: [
  ProductID: guid
  ProductCode: string
  Name: string
  ExpenseAccount: string
  Quantity: number
  Unit: string
  WastagePercent: number
  WastageQuantity: number
  TotalQuantity: number
  TotalCost: number
]
```

### GET `/finishedGoods/pick`

| Parameter | Type | Required |
|---|---|---|
| `TaskID` |  |  |

Response 200:

```text
TaskID: guid
Status: string
WIPAccount: string
WIPDate: date
Account: string
CompletionDate: date
PickLines: [
  ProductID: guid
  ProductCode: string
  Name: string
  BinID: null
  Bin: null
  BatchSN: null
  ExpiryDate: null
  Quantity: number
  Unit: string
  Cost: number
]
```

### POST `/`

Request body:

```text
TaskID: guid
Status: string
WIPAccount: string
WIPDate: date
Account: string
CompletionDate: date
PickLines: [
  ProductID: guid
  ProductCode: string
  Name: string
  BinID: null
  Bin: null
  BatchSN: null
  ExpiryDate: null
  Quantity: number
  Unit: string
  Cost: number
]
```

Response 200:

```text
TaskID: guid
Status: string
WIPAccount: string
WIPDate: date
Account: string
CompletionDate: date
PickLines: [
  ProductID: guid
  ProductCode: string
  Name: string
  BinID: null
  Bin: null
  BatchSN: null
  ExpiryDate: null
  Quantity: number
  Unit: string
  Cost: number
]
```

