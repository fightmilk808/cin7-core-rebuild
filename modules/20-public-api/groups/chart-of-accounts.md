# Public API: Chart of Accounts

From Cin7's API Blueprint: field tables (name, type, length, required, allowed values), each operation's query parameters, and request and response bodies as type outlines (`guid`, `string`, `number`, `boolean`, `date`, `null`; `[ … ]` = array of). Base `/ExternalApi/v2`; headers in [docs/PUBLIC-API.md](../../../docs/PUBLIC-API.md).

**Resources:** `/ref/account`

## Fields

#### Chart of Accounts

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `Code` | String | 50 | Yes |  |
| `Name` | String | 256 | Yes |  |
| `Type` | String | 50 | Yes |  |
| `Status` | String | 50 | Yes |  |
| `Description` | String |  |  |  |
| `Class` | String |  |  |  |
| `SystemAccount` | String (read-only) |  |  |  |
| `SystemAccountCode` | String (read-only) |  |  |  |
| `ForPayments` | String |  |  |  |
| `DisplayName` | String (read-only) |  |  |  |
| `OldCode` | String (read-only) |  |  |  |
| `Bank` | String |  |  |  |
| `BankAccountNumber` | String |  |  |  |
| `BankAccountId` | Guid (read-only) |  |  |  |
| `Currency` | String (read-only) |  |  |  |

## Operations

### GET `/ref/account`

| Parameter | Type | Required |
|---|---|---|
| `Page` | number |  |
| `Limit` | number |  |
| `Code` | string |  |
| `Name` | string |  |
| `Type` | string |  |
| `Status` | string |  |

Response 200:

```text
Total: number
Page: number
AccountsList: [
  Code: string
  Status: string
  Name: string
  Type: string
  Description: string
  Class: string
  SystemAccount: string
  SystemAccountCode: string
  BankAccountNumber: null
  BankAccountId: null
  ForPayments: boolean
  DisplayName: string
  OldCode: null
]
```

### POST `/`

Request body:

```text
Code: string
Status: string
Name: string
Type: string
Description: string
Class: string
SystemAccount: string
SystemAccountCode: string
```

Response 200:

```text
Total: number
Page: number
AccountsList: [
  Code: string
  Status: string
  Name: string
  Type: string
  Description: string
  Class: string
  SystemAccount: string
  SystemAccountCode: string
  BankAccountNumber: null
  BankAccountId: null
  ForPayments: boolean
  DisplayName: string
  OldCode: null
]
```

### PUT `/`

Request body:

```text
Code: string
Status: string
Name: string
Type: string
Description: string
Class: string
```

Response 200:

```text
Total: number
Page: number
AccountsList: [
  Code: string
  Status: string
  Name: string
  Type: string
  Description: string
  Class: string
  SystemAccount: string
  SystemAccountCode: string
  BankAccountNumber: null
  BankAccountId: null
  ForPayments: boolean
  DisplayName: string
  OldCode: null
]
```

### DELETE `/ref/account`

| Parameter | Type | Required |
|---|---|---|
| `Code` | string | yes |

Response 200:

```text
Success: boolean
```

