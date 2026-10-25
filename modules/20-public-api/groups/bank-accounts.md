# Public API: Bank Accounts

From Cin7's API Blueprint: field tables (name, type, length, required, allowed values), each operation's query parameters, and request and response bodies as type outlines (`guid`, `string`, `number`, `boolean`, `date`, `null`; `[ … ]` = array of). Base `/ExternalApi/v2`; headers in [docs/PUBLIC-API.md](../../../docs/PUBLIC-API.md).

**Resources:** `/ref/account/bank`

## Fields

#### Bank Accounts

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `AccountID` | Guid |  |  |  |
| `Bank` | String | 512 |  |  |
| `AccountName` | String | 256 |  |  |
| `AccountNumber` | String | 256 |  |  |
| `AccountCode` | String | 50 |  |  |
| `Currency` | String | 3 |  |  |
| `StatementBalance` | Decimal |  |  |  |
| `BalanceInDear` | Decimal |  |  |  |
| `InitialBalance` | String |  |  |  |

## Operations

### GET `/ref/account/bank`

| Parameter | Type | Required |
|---|---|---|
| `Page` | number |  |
| `Limit` | number |  |
| `ID` | Guid |  |
| `Name` | string |  |
| `Bank` | string |  |

Response 200:

```text
Total: number
Page: number
BankAccountsList: [
  AccountID: guid
  Bank: string
  AccountName: string
  AccountNumber: string
  AccountCode: string
  Currency: string
  StatementBalance: number
  BalanceInDear: number
  InitialBalance: number
]
```

