# Public API: Money Task

From Cin7's API Blueprint: field tables (name, type, length, required, allowed values), each operation's query parameters, and request and response bodies as type outlines (`guid`, `string`, `number`, `boolean`, `date`, `null`; `[ … ]` = array of). Base `/ExternalApi/v2`; headers in [docs/PUBLIC-API.md](../../../docs/PUBLIC-API.md).

**Resources:** `/moneyTaskList` · `/moneyOperation` · `/bankTransfer`

## Fields

#### Money Task List

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `TaskID` | Guid |  |  |  |
| `Date` | DateTime |  |  |  |
| `TaskType` | String |  |  | `Spend Money`, `Receive Money`, `Transfer Money` |
| `Status` | String |  |  | `DRAFT`, `COMPLETED`, `VOIDED` |
| `SupplierCustomerName` | String |  |  |  |
| `SupplierID` | Guid |  |  |  |
| `CustomerID` | Guid |  |  |  |
| `Reference` | Decimal |  |  |  |
| `TotalAmount` | String |  |  |  |

#### Money Task List

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `TaskID` | Guid |  | Yes* |  |
| `TaskType` | String |  | Yes | `Spend Money`, `Receive Money`, `Transfer Money` |
| `Status` | String |  | Yes | `DRAFT`, `COMPLETED`, `VOIDED` |
| `BankAccount` | String |  | Yes |  |
| `CurrencyConversionRate` | Decimal |  |  |  |
| `SupplierCustomerName` | String |  |  |  |
| `SupplierID` | Guid |  |  |  |
| `CustomerID` | Guid |  |  |  |
| `Reference` | String |  |  |  |
| `Date` | DateTime |  | Yes |  |
| `TaxInclusive` | Boolean |  |  |  |
| `Note` | String |  |  |  |
| `Lines` | [] Money Task Line Model |  |  |  |
| `Transactions` | [] Transaction Stock Line Model |  |  |  |
| `Attachments` | [] Attachment Line Model |  |  |  |

#### Money Task List

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `TaskID` | Guid |  | Yes* |  |
| `Status` | String |  | Yes | `DRAFT`, `COMPLETED`, `VOIDED` |
| `FromAccount` | String |  | Yes |  |
| `ToAccount` | String |  | Yes |  |
| `FromAmount` | Decimal |  | Yes |  |
| `ToAmount` | Decimal |  | Yes |  |
| `CurrencyConversionRate` | Decimal |  |  |  |
| `Reference` | String |  |  |  |
| `Date` | DateTime |  | Yes |  |
| `Note` | String |  |  |  |
| `Transactions` | [] Transaction Stock Line Model |  |  |  |
| `Attachments` | [] Attachment Line Model |  |  |  |

## Operations

### GET `/moneyTaskList`

| Parameter | Type | Required |
|---|---|---|
| `Page` | number |  |
| `Limit` | number |  |
| `Status` |  |  |
| `Search` |  |  |
| `TaskType` |  |  |

Response 200:

```text
Total: number
Page: number
MoneyTasks: [
  TaskID: guid
  Date: date
  TaskType: string
  Status: string
  SupplierCustomerName: string
  SupplierID: null
  CustomerID: null
  Reference: string
  TotalAmount: number
]
```

### GET `/moneyOperation`

| Parameter | Type | Required |
|---|---|---|
| `TaskID` |  |  |

Response 200:

```text
TaskID: guid
TaskType: string
Status: string
BankAccount: string
CurrencyConversionRate: number
SupplierCustomer: string
SupplierID: guid
CustomerID: null
Reference: string
Date: date
TaxInclusive: boolean
Note: string
Lines: [
  Name: string
  Comment: string
  Quantity: number
  Price: number
  Discount: number
  Tax: number
  TaxRuleName: string
  AccountCode: string
  Total: number
]
Transactions: [
  ID: guid
  EffectiveDate: date
  Debit: string
  Credit: string
  Amount: number
]
Attachments: []
```

### POST `/`

Request body:

```text
TaskType: string
Status: string
BankAccount: string
SupplierID: null
CustomerID: null
Reference: string
Date: date
TaxInclusive: boolean
Note: string
Lines: [
  Name: string
  Comment: string
  Quantity: number
  Price: number
  Discount: number
  Tax: number
  TaxRuleName: string
  AccountCode: string
  Total: number
]
```

Response 200:

```text
TaskID: guid
TaskType: string
Status: string
BankAccount: string
CurrencyConversionRate: number
SupplierCustomer: string
SupplierID: null
CustomerID: null
Reference: string
Date: date
TaxInclusive: boolean
Note: null
Lines: [
  Name: string
  Comment: string
  Quantity: number
  Price: number
  Discount: number
  Tax: number
  TaxRuleName: string
  AccountCode: string
  Total: number
]
Transactions: []
Attachments: []
```

### PUT `/`

Request body:

```text
TaskID: guid
TaskType: string
Status: string
BankAccount: string
CurrencyConversionRate: number
SupplierID: null
CustomerID: null
Reference: string
Date: date
TaxInclusive: boolean
Note: null
Lines: [
  Name: string
  Comment: string
  Quantity: number
  Price: number
  Discount: number
  Tax: number
  TaxRuleName: string
  AccountCode: string
  Total: number
]
```

Response 200:

```text
TaskID: guid
TaskType: string
Status: string
BankAccount: string
CurrencyConversionRate: number
SupplierCustomer: string
SupplierID: null
CustomerID: null
Reference: string
Date: date
TaxInclusive: boolean
Note: null
Lines: [
  Name: string
  Comment: string
  Quantity: number
  Price: number
  Discount: number
  Tax: number
  TaxRuleName: string
  AccountCode: string
  Total: number
]
Transactions: [
  ID: guid
  EffectiveDate: date
  Debit: string
  Credit: string
  Amount: number
]
Attachments: []
```

### DELETE `/moneyOperation` (Delete)

| Parameter | Type | Required |
|---|---|---|
| `ID` |  | yes |
| `Void` | boolean |  |

Response 200:

```text
TaskID: guid
TaskType: string
Status: string
BankAccount: string
CurrencyConversionRate: number
SupplierCustomer: string
SupplierID: null
CustomerID: null
Reference: string
Date: date
TaxInclusive: boolean
Note: null
Lines: []
Transactions: []
Attachments: []
```

### GET `/bankTransfer`

| Parameter | Type | Required |
|---|---|---|
| `TaskID` |  |  |

Response 200:

```text
TaskID: guid
Status: string
FromAccount: string
ToAccount: string
FromAmount: number
ToAmount: number
CurrencyConversionRate: number
Reference: string
Date: date
Note: string
Transactions: [
  ID: guid
  EffectiveDate: date
  Debit: string
  Credit: string
  Amount: number
]
Attachments: []
```

### POST `/`

Request body:

```text
Status: string
FromAccount: string
ToAccount: string
FromAmount: number
ToAmount: number
Reference: string
Date: date
Note: string
```

Response 200:

```text
TaskID: guid
Status: string
FromAccount: string
ToAccount: string
FromAmount: number
ToAmount: number
CurrencyConversionRate: number
Reference: string
Date: date
Note: string
Transactions: []
Attachments: []
```

### PUT `/`

Request body:

```text
TaskID: guid
Status: string
FromAccount: string
ToAccount: string
FromAmount: number
ToAmount: number
Reference: string
Date: date
Note: string
```

Response 200:

```text
TaskID: guid
Status: string
FromAccount: string
ToAccount: string
FromAmount: number
ToAmount: number
CurrencyConversionRate: number
Reference: string
Date: date
Note: string
Transactions: [
  ID: guid
  EffectiveDate: date
  Debit: string
  Credit: string
  Amount: number
]
Attachments: []
```

### DELETE `/bankTransfer` (Delete)

| Parameter | Type | Required |
|---|---|---|
| `ID` |  | yes |
| `Void` | boolean |  |

Response 200:

```text
TaskID: guid
Status: string
FromAccount: string
ToAccount: string
FromAmount: number
ToAmount: number
CurrencyConversionRate: number
Reference: string
Date: date
Note: string
Transactions: []
Attachments: []
```

