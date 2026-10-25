# Public API: Transactions

From Cin7's API Blueprint: field tables (name, type, length, required, allowed values), each operation's query parameters, and request and response bodies as type outlines (`guid`, `string`, `number`, `boolean`, `date`, `null`; `[ … ]` = array of). Base `/ExternalApi/v2`; headers in [docs/PUBLIC-API.md](../../../docs/PUBLIC-API.md).

**Resources:** `/transactions`

## Fields

#### Transactions

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `TaskID` | Guid |  |  |  |
| `DebitAccountCode` | String |  |  |  |
| `CreditAccountCode` | String |  |  |  |
| `Amount` | Decimal |  |  |  |
| `EffectiveDate` | DateTime |  |  |  |
| `Reference` | String |  |  |  |
| `Transaction` | String |  |  |  |
| `Type` | String |  |  | `Purchase`, `Sale`, `MoneySpend`, `MoneyReceive`, `BankTransfer`, `ExpenseClaimTask`, `FinishedGoods`, `InventoryWriteOff`, `StockTake`, `StockAdjustment`, `Journal`, `Disassembly`, `Depreciation` |

## Operations

### GET `/transactions`

| Parameter | Type | Required |
|---|---|---|
| `Page` | number |  |
| `Limit` | number |  |
| `FromDate` |  |  |
| `ToDate` |  |  |
| `Account` |  |  |

Response 200:

```text
Total: number
Page: number
Transactions: [
  TaskID: guid
  DebitAccountCode: string
  CreditAccountCode: string
  Amount: number
  EffectiveDate: date
  Reference: string
  Transaction: string
  Type: string
]
```

