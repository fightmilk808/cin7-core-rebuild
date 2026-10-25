# Public API: Me

From Cin7's API Blueprint: field tables (name, type, length, required, allowed values), each operation's query parameters, and request and response bodies as type outlines (`guid`, `string`, `number`, `boolean`, `date`, `null`; `[ … ]` = array of). Base `/ExternalApi/v2`; headers in [docs/PUBLIC-API.md](../../../docs/PUBLIC-API.md).

**Resources:** `/me` · `/me/addresses` · `/me/contacts`

## Fields

#### ME

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `Company` | String |  |  |  |
| `Currency` | String |  |  |  |
| `TimeZone` | String |  |  |  |
| `DefaultWeightUnits` | String | 10 |  |  |
| `DefaultDimensionsUnits` | String | 10 |  |  |
| `LockDate` | Date |  |  |  |
| `OpeningBalanceDate` | Date |  |  |  |
| `TaxCalculationMethod` | String |  | Row Total… |  |
| `DefaultSaleTaxRuleId` | Guid |  |  |  |
| `DefaultSaleTaxRuleName` | String |  |  |  |
| `MaximumDecimalPlacesInQuantity` | String |  |  |  |
| `ApplyCustomerDiscountsAfterOtherDiscounts` | Bool |  |  |  |
| `DiscountRule` | String |  | Discount,… |  |
| `AutomaticallyApplyDiscounts` | Bool |  |  |  |
| `RoundingTable` | [] Rounding Table Model |  |  |  |

#### Rounding Table Model

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `RangeTo` | Decimal |  |  |  |
| `RoundToNearest` | Decimal |  |  |  |
| `AdjustmentRule` | String |  | N, S, A |  |
| `AdjustmentValue` | String |  |  |  |

#### Me Address

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `AddressID` | Guid |  |  |  |
| `Line1` | String | 256 | Yes |  |
| `Line2` | String | 256 |  |  |
| `CitySuburb` | String | 256 | Yes |  |
| `StateProvince` | String | 256 | Yes |  |
| `ZipPostCode` | String | 20 | Yes |  |
| `Country` | String |  | Yes |  |
| `Type` | String |  | Yes |  |
| `DefaultForType` | Bool |  |  |  |

#### Me Contact

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `ContactID` | Guid |  |  |  |
| `Name` | String | 256 | Yes |  |
| `Phone` | String | 50 |  |  |
| `Fax` | String | 50 |  |  |
| `Email` | String | 256 |  |  |
| `Website` | String | 256 |  |  |
| `Comment` | String | 256 |  |  |
| `Type` | String | 50 |  |  |
| `DefaultForType` | Bool |  |  |  |

## Operations

### GET `/`

Response 200:

```text
Company: string
Currency: string
TimeZone: string
DefaultWeightUnits: string
DefaultDimensionsUnits: string
LockDate: null
OpeningBalanceDate: date
TaxCalculationMethod: string
DefaultSaleTaxRuleId: guid
DefaultSaleTaxRuleName: string
MaximumDecimalPlacesInQuantity: string
ApplyCustomerDiscountsAfterOtherDiscounts: boolean
DiscountRule: string
AutomaticallyApplyDiscounts: boolean
RoundingTable: [
  RangeTo: number
  RoundToNearest: number
  AdjustmentRule: string
  AdjustmentValue: number
]
```

### GET `/me/addresses`

| Parameter | Type | Required |
|---|---|---|
| `Page` | number |  |
| `Limit` | number |  |
| `ID` | Guid |  |
| `Type` | string |  |
| `DefaultForType` | bool |  |
| `Country` | string |  |
| `StateProvince` | string |  |
| `CitySuburb` | string |  |

Response 200:

```text
Total: number
Page: number
MeAddressesList: [
  AddressID: guid
  Line1: string
  Line2: null
  CitySuburb: string
  StateProvince: string
  ZipPostCode: string
  Country: string
  Type: string
  DefaultForType: boolean
]
```

### POST `/`

Request body:

```text
Line1: string
Line2: null
CitySuburb: string
StateProvince: string
ZipPostCode: string
Country: string
Type: string
DefaultForType: boolean
```

Response 200:

```text
Total: number
Page: number
MeAddressesList: [
  AddressID: guid
  Line1: string
  Line2: null
  CitySuburb: string
  StateProvince: string
  ZipPostCode: string
  Country: string
  Type: string
  DefaultForType: boolean
]
```

### PUT `/`

Request body:

```text
AddressID: guid
Line1: string
Line2: null
CitySuburb: string
StateProvince: string
ZipPostCode: string
Country: string
Type: string
DefaultForType: boolean
```

Response 200:

```text
Total: number
Page: number
MeAddressesList: [
  AddressID: guid
  Line1: string
  Line2: null
  CitySuburb: string
  StateProvince: string
  ZipPostCode: string
  Country: string
  Type: string
  DefaultForType: boolean
]
```

### DELETE `/me/addresses`

| Parameter | Type | Required |
|---|---|---|
| `ID` | Guid | yes |

Response 200:

```text
Success: boolean
```

### GET `/me/contacts`

| Parameter | Type | Required |
|---|---|---|
| `Page` | number |  |
| `Limit` | number |  |
| `ID` | Guid |  |
| `Name` | string |  |
| `Type` | string |  |
| `DefaultForType` | bool |  |
| `Phone` | string |  |
| `Fax` | string |  |
| `Email` | string |  |

Response 200:

```text
Total: number
Page: number
MeContactsList: [
  ContactID: guid
  Name: string
  Phone: string
  Fax: null
  Email: string
  Website: null
  Comment: null
  Type: string
  DefaultForType: boolean
]
```

### POST `/`

Request body:

```text
Name: string
Phone: string
Fax: null
Email: string
Website: null
Comment: null
Type: string
DefaultForType: boolean
```

Response 200:

```text
Total: number
Page: number
MeContactsList: [
  ContactID: guid
  Name: string
  Phone: string
  Fax: null
  Email: string
  Website: null
  Comment: null
  Type: string
  DefaultForType: boolean
]
```

### PUT `/`

Request body:

```text
ContactID: guid
Name: string
Phone: string
Fax: null
Email: string
Website: null
Comment: null
Type: string
DefaultForType: boolean
```

Response 200:

```text
Total: number
Page: number
MeContactsList: [
  ContactID: guid
  Name: string
  Phone: string
  Fax: null
  Email: string
  Website: null
  Comment: null
  Type: string
  CRMID: null
  DefaultForType: boolean
  ReferenceCount: number
]
```

### DELETE `/me/contacts`

| Parameter | Type | Required |
|---|---|---|
| `ID` | Guid | yes |

Response 200:

```text
Success: boolean
```

