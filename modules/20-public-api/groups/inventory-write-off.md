# Public API: Inventory Write-Off

From Cin7's API Blueprint: field tables (name, type, length, required, allowed values), each operation's query parameters, and request and response bodies as type outlines (`guid`, `string`, `number`, `boolean`, `date`, `null`; `[ … ]` = array of). Base `/ExternalApi/v2`; headers in [docs/PUBLIC-API.md](../../../docs/PUBLIC-API.md).

**Resources:** `/inventoryWriteOffList` · `/inventoryWriteOff`

## Fields

#### Inventory Write-Off List

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `TaskID` | Guid |  |  |  |
| `InventoryWriteOffNumber` | String |  |  |  |
| `Status` | String |  |  | `DRAFT`, `COMPLETED`, `VOIDED` |
| `LocationID` | Guid |  |  |  |
| `Location` | String |  |  |  |
| `Date` | DateTime |  |  |  |
| `Notes` | String |  |  |  |

#### Inventory Write-Off

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `TaskID` | Guid |  |  |  |
| `InventoryWriteOffNumber` | String |  |  |  |
| `Status` | String |  |  | `DRAFT`, `COMPLETED`, `VOIDED` |
| `LocationID` | Guid |  |  |  |
| `Location` | String |  |  |  |
| `Account` | String |  |  |  |
| `EffectiveDate` | DateTime |  |  |  |
| `Notes` | String |  |  |  |
| `Lines` | [] Inventory Write-Off Line Model |  |  |  |
| `Transactions` | [] Transaction Stock Line Model |  |  |  |
| `Errors` | [] Error Model |  |  |  |

#### POST/PUT method

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `TaskID` | Guid |  | Yes* |  |
| `Status` | String |  | Yes | `DRAFT`, `COMPLETED` |
| `LocationID` | Guid |  | Yes* |  |
| `Location` | Decimal |  | Yes* |  |
| `Account` | String |  | Yes |  |
| `EffectiveDate` | DateTime |  | Yes* |  |
| `Notes` | String |  |  |  |
| `Lines` | [] Inventory Write-Off Line Model |  |  |  |

## Operations

### GET `/inventoryWriteOffList`

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
InventoryWriteOffs: [
  TaskID: guid
  InventoryWriteOffNumber: string
  Status: string
  LocationID: guid
  Location: string
  Date: date
  Notes: string
]
```

### GET `/inventoryWriteOff`

| Parameter | Type | Required |
|---|---|---|
| `TaskID` |  |  |

Response 200:

```text
TaskID: guid
InventoryWriteOffNumber: string
Status: string
LocationID: guid
Location: string
Account: string
EffectiveDate: date
Notes: string
Lines: [
  ProductID: guid
  ProductCode: string
  Name: string
  BinID: guid
  Bin: string
  BatchSN: string
  ExpiryDate: date
  ExpenseAccount: null
  Quantity: number
  Cost: number
  TotalCost: number
]
Transactions: []
Errors: []
```

### POST `/`

Request body:

```text
Status: string
LocationID: guid
Location: string
Account: string
EffectiveDate: date
Notes: string
Lines: [
  ProductID: guid
  ProductCode: string
  Name: string
  BinID: null
  Bin: null
  BatchSN: null
  ExpiryDate: null
  ExpenseAccount: string
  Quantity: number
  Cost: number
]
```

Response 200:

```text
TaskID: guid
InventoryWriteOffNumber: string
Status: string
LocationID: guid
Location: string
Account: string
EffectiveDate: date
Notes: string
Lines: [
  ProductID: guid
  ProductCode: string
  Name: string
  BinID: guid
  Bin: string
  BatchSN: string
  ExpiryDate: date
  ExpenseAccount: null
  Quantity: number
  Cost: number
  TotalCost: number
]
Transactions: []
Errors: []
```

### PUT `/`

Request body:

```text
TaskID: guid
Status: string
LocationID: guid
Location: string
Account: string
EffectiveDate: date
Notes: string
Lines: [
  ProductID: guid
  ProductCode: string
  Name: string
  BinID: guid
  Bin: string
  BatchSN: string
  ExpiryDate: date
  ExpenseAccount: null
  Quantity: number
  Cost: number
]
```

Response 200:

```text
TaskID: guid
InventoryWriteOffNumber: string
Status: string
LocationID: guid
Location: string
Account: string
EffectiveDate: date
Notes: string
Lines: [
  ProductID: guid
  ProductCode: string
  Name: string
  BinID: guid
  Bin: string
  BatchSN: string
  ExpiryDate: date
  ExpenseAccount: null
  Quantity: number
  Cost: number
  TotalCost: number
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

### DELETE `/inventoryWriteOff` (Delete)

| Parameter | Type | Required |
|---|---|---|
| `ID` |  | yes |
| `Void` | boolean |  |

Response 200:

```text
TaskID: guid
InventoryWriteOffNumber: string
Status: string
LocationID: guid
Location: string
Account: string
EffectiveDate: date
Notes: string
Lines: []
Transactions: []
Errors: []
```

