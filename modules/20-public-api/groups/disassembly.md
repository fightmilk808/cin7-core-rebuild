# Public API: Disassembly

From Cin7's API Blueprint: field tables (name, type, length, required, allowed values), each operation's query parameters, and request and response bodies as type outlines (`guid`, `string`, `number`, `boolean`, `date`, `null`; `[ … ]` = array of). Base `/ExternalApi/v2`; headers in [docs/PUBLIC-API.md](../../../docs/PUBLIC-API.md).

**Resources:** `/disassemblyList` · `/disassembly` · `/disassembly/order`

## Fields

#### Disassembly List

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `TaskID` | Guid |  |  |  |
| `DisassemblyNumber` | String |  |  |  |
| `ProductID` | Guid |  |  |  |
| `ProductCode` | String |  |  |  |
| `ProductName` | String |  |  |  |
| `Quantity` | Decimal |  |  |  |
| `LocationID` | Guid |  |  |  |
| `Location` | String |  |  |  |
| `Date` | DateTime |  |  |  |
| `Status` | String |  |  | `DRAFT`, `WORK IN PROGRESS`, `COMPLETED`, `VOIDED` |

#### Disassembly

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `TaskID` | Guid |  |  |  |
| `DisassemblyNumber` | String |  |  |  |
| `Status` | String |  |  | `DRAFT`, `WORK IN PROGRESS`, `COMPLETED`, `VOIDED` |
| `ProductID` | Guid |  |  |  |
| `ProductCode` | String |  |  |  |
| `ProductName` | String |  |  |  |
| `LocationID` | Guid |  |  |  |
| `Location` | String |  |  |  |
| `WIPAccount` | String |  |  |  |
| `Quantity` | Decimal |  |  |  |
| `AssemblyInstructionURL` | String |  |  |  |
| `PickLines` | [] Disassembly Pick Line Model |  |  |  |
| `OrderLines` | [] Disassembly Order Line Model |  |  |  |
| `OrderServiceLines` | [] Disassembly Order Service Line Model |  |  |  |
| `Transactions` | [] Transaction Stock Line Model |  |  |  |
| `Errors` | [] Error Model |  |  |  |

#### POST method

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `Status` | String |  | Yes | `DRAFT`, `AUTHORISED`, `IN PROGRESS`, `COMPLETED` |
| `ProductID` | Guid |  | Yes* |  |
| `ProductCode` | String |  | Yes* |  |
| `LocationID` | Guid |  | Yes* |  |
| `Location` | Decimal |  | Yes* |  |
| `WIPAccount` | String |  | Yes |  |
| `Quantity` | Decimal |  | Yes |  |

#### Disassembly Order

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `TaskID` | Guid |  |  |  |
| `Status` | String |  |  | `DRAFT`, `WORK IN PROGRESS`, `COMPLETED`, `VOIDED`, `POST`, `WORK IN PROGRESS`, `COMPLETED` |
| `OrderLines` | [] Disassembly Order Line Model |  |  |  |

## Operations

### GET `/disassemblyList`

| Parameter | Type | Required |
|---|---|---|
| `Page` | number |  |
| `Limit` | number |  |
| `Status` |  |  |
| `Search` |  |  |

Response 200:

```text
Total: number
Page: number
Disassemblies: [
  TaskID: guid
  DisassemblyNumber: string
  ProductID: guid
  ProductCode: string
  ProductName: string
  Quantity: number
  LocationID: guid
  Location: string
  Date: date
  Status: string
]
```

### GET `/disassembly`

| Parameter | Type | Required |
|---|---|---|
| `TaskID` |  |  |

Response 200:

```text
TaskID: guid
DisassemblyNumber: string
Status: string
ProductID: guid
ProductCode: string
ProductName: string
LocationID: guid
Location: string
CompletionDate: date
WIPAccount: string
Quantity: number
AssemblyInstructionURL: string
PickLines: [
  BinID: null
  Bin: null
  Date: date
  BatchSN: string
  ExpiryDate: date
  Available: number
  UnitCost: number
  Quantity: number
  TotalCost: number
]
OrderLines: [
  ProductID: guid
  ProductCode: string
  Name: string
  BinID: null
  Bin: null
  Unit: string
  BatchSN: null
  ExpiryDate: null
  Account: string
  Quantity: number
  Cost: number
]
OrderServiceLines: [
  ProductID: guid
  Name: string
  Account: string
  Comments: string
  Amount: number
]
Transactions: [
  ID: guid
  EffectiveDate: date
  Debit: string
  Credit: string
  Amount: number
]
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
CompletionDate: date
WIPAccount: string
Quantity: number
```

Response 200:

```text
TaskID: guid
DisassemblyNumber: string
Status: string
ProductID: guid
ProductCode: string
ProductName: string
LocationID: guid
Location: string
CompletionDate: date
WIPAccount: string
Quantity: number
AssemblyInstructionURL: string
PickLines: [
  BinID: null
  Bin: null
  Date: date
  BatchSN: string
  ExpiryDate: date
  Available: number
  UnitCost: number
  Quantity: number
  TotalCost: number
]
OrderLines: [
  ProductID: guid
  ProductCode: string
  Name: string
  BinID: null
  Bin: null
  Unit: string
  BatchSN: null
  ExpiryDate: null
  Account: string
  Quantity: number
  Cost: number
]
OrderServiceLines: [
  ProductID: guid
  Name: string
  Account: string
  Comments: string
  Amount: number
]
Transactions: [
  ID: guid
  EffectiveDate: date
  Debit: string
  Credit: string
  Amount: number
]
Errors: []
```

### DELETE `/disassembly` (Delete)

| Parameter | Type | Required |
|---|---|---|
| `ID` |  | yes |
| `Void` | boolean |  |

Response 200:

```text
TaskID: guid
DisassemblyNumber: string
Status: string
ProductID: guid
ProductCode: string
ProductName: string
LocationID: guid
Location: string
CompletionDate: date
WIPAccount: string
Quantity: number
AssemblyInstructionURL: string
PickLines: []
OrderLines: []
OrderServiceLines: []
Transactions: []
Errors: []
```

### GET `/disassembly/order`

| Parameter | Type | Required |
|---|---|---|
| `TaskID` |  |  |

Response 200:

```text
TaskID: guid
Status: string
CompletionDate: date
OrderLines: [
  ProductID: guid
  ProductCode: string
  Name: string
  BinID: null
  Bin: null
  Unit: string
  BatchSN: null
  ExpiryDate: null
  Account: string
  Quantity: number
  Cost: number
]
OrderServiceLines: [
  ProductID: guid
  Name: string
  Account: string
  Comments: string
  Amount: number
]
```

### POST `/`

Request body:

```text
TaskID: guid
Status: string
CompletionDate: date
OrderLines: [
  ProductID: guid
  ProductCode: string
  Name: string
  BinID: null
  Bin: null
  Unit: string
  BatchSN: null
  ExpiryDate: null
  Account: string
  Quantity: number
  Cost: number
]
OrderServiceLines: [
  ProductID: guid
  Name: string
  Account: string
  Comments: string
  Amount: number
]
```

Response 200:

```text
TaskID: guid
Status: string
CompletionDate: date
OrderLines: [
  ProductID: guid
  ProductCode: string
  Name: string
  BinID: null
  Bin: null
  Unit: string
  BatchSN: null
  ExpiryDate: null
  Account: string
  Quantity: number
  Cost: number
]
OrderServiceLines: [
  ProductID: guid
  Name: string
  Account: string
  Comments: string
  Amount: number
]
```

