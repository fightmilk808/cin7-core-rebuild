# Public API: Journal

From Cin7's API Blueprint: field tables (name, type, length, required, allowed values), each operation's query parameters, and request and response bodies as type outlines (`guid`, `string`, `number`, `boolean`, `date`, `null`; `[ … ]` = array of). Base `/ExternalApi/v2`; headers in [docs/PUBLIC-API.md](../../../docs/PUBLIC-API.md).

**Resources:** `/journal`

## Fields

#### Journal

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `TaskID` | Guid |  | Yes* |  |
| `Status` | String |  | Yes | `DRAFT`, `COMPLETED`, `VOIDED` |
| `JournalNumber` | String (read-only) |  |  |  |
| `Currency` | String |  | Yes |  |
| `CurrencyConversionRate` | Decimal |  | Yes |  |
| `EffectiveDate` | DateTime |  | Yes |  |
| `Narration` | String |  |  |  |
| `Notes` | String |  |  |  |
| `Lines` | [] Journal Line Model |  |  |  |
| `Attachments` | [] Attachment Line Model |  |  |  |

## Operations

### GET `/journal`

| Parameter | Type | Required |
|---|---|---|
| `Page` | number |  |
| `Limit` | number |  |
| `TaskID` |  |  |
| `Status` |  |  |
| `Search` |  |  |

Response 200:

```text
Total: number
Page: number
Journals: [
  TaskID: guid
  Status: string
  JournalNumber: string
  Currency: string
  CurrencyConversionRate: number
  EffectiveDate: date
  Narration: string
  Notes: string
  Lines: [
    Debit: string
    Credit: string
    Reference: string
    Amount: number
    BaseAmount: number
  ]
  Attachments: [
    ID: guid
    ContentType: string
    FileName: string
    DownloadUrl: string
  ]
]
```

### POST `/`

Request body:

```text
Status: string
Currency: string
CurrencyConversionRate: number
EffectiveDate: date
Narration: string
Notes: string
Lines: [
  Debit: string
  Credit: string
  Reference: string
  Amount: number
  BaseAmount: number
]
```

Response 200:

```text
Total: number
Page: number
Journals: [
  TaskID: guid
  Status: string
  JournalNumber: string
  Currency: string
  CurrencyConversionRate: number
  EffectiveDate: date
  Narration: null
  Notes: null
  Lines: [
    Debit: string
    Credit: string
    Reference: string
    Amount: number
    BaseAmount: number
  ]
  Attachments: []
]
```

### PUT `/`

Request body:

```text
TaskID: guid
Status: string
Currency: string
CurrencyConversionRate: number
EffectiveDate: date
Narration: null
Notes: null
Lines: [
  Debit: string
  Credit: string
  Reference: string
  Amount: number
  BaseAmount: number
]
```

Response 200:

```text
Total: number
Page: number
Journals: [
  TaskID: guid
  Status: string
  JournalNumber: string
  Currency: string
  CurrencyConversionRate: number
  EffectiveDate: date
  Narration: null
  Notes: null
  Lines: [
    Debit: string
    Credit: string
    Reference: string
    Amount: number
    BaseAmount: number
  ]
  Attachments: []
]
```

### DELETE `/journal` (Delete)

| Parameter | Type | Required |
|---|---|---|
| `ID` |  | yes |
| `Void` | boolean |  |

Response 200:

```text
Total: number
Page: number
Journals: [
  TaskID: guid
  Status: string
  JournalNumber: string
  Currency: string
  CurrencyConversionRate: number
  EffectiveDate: date
  Narration: null
  Notes: null
  Lines: []
  Attachments: []
]
```

