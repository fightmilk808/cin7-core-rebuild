# Public API: Location

From Cin7's API Blueprint: field tables (name, type, length, required, allowed values), each operation's query parameters, and request and response bodies as type outlines (`guid`, `string`, `number`, `boolean`, `date`, `null`; `[ … ]` = array of). Base `/ExternalApi/v2`; headers in [docs/PUBLIC-API.md](../../../docs/PUBLIC-API.md).

**Resources:** `/ref/location`

## Fields

#### Location

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `ID` | Guid |  | Yes* |  |
| `Name` | String | 50 | Yes |  |
| `IsDefault` | Bool |  |  |  |
| `Deprecated` | Bool |  |  |  |
| `Bins` | Array |  |  |  |
| `FixedAssetsLocation` | Bool |  |  |  |
| `ParentID` | Guid |  |  |  |
| `ReferenceCount` | Int |  |  |  |
| `AddressLine1` | String | 50 |  |  |
| `AddressLine2` | String | 50 |  |  |
| `AddressCitySuburb` | String | 50 |  |  |
| `AddressStateProvince` | String | 50 |  |  |
| `AddressZipPostCode` | String | 50 |  |  |
| `AddressCountry` | String | 50 |  |  |
| `PickZones` | String | 50 |  |  |
| `IsShopfloor` | Bool |  |  |  |
| `IsCoMan` | Bool |  |  |  |
| `IsStaging` | Bool |  |  |  |

## Operations

### GET `/ref/location`

| Parameter | Type | Required |
|---|---|---|
| `Page` | number |  |
| `Limit` | number |  |
| `ID` | Guid |  |
| `Deprecated` | bool |  |
| `Name` | string |  |

Response 200:

```text
Total: number
Page: number
LocationList: [
  ID: guid
  Name: string
  IsDefault: boolean
  IsDeprecated: boolean
  Bins: null
  FixedAssetsLocation: boolean
  ParentID: null
  ParentName: null
  ReferenceCount: number
  AddressLine1: string
  AddressLine2: string
  AddressCitySuburb: string
  AddressStateProvince: string
  AddressZipPostCode: string
  AddressCountry: string
  PickZones: null
  IsShopfloor: boolean
  IsCoMan: boolean
  IsStaging: boolean
]
```

### POST `/`

Request body:

```text
Name: string
AddressLine1: string
AddressLine2: string
AddressCitySuburb: string
AddressStateProvince: string
AddressZipPostCode: string
AddressCountry: string
IsShopfloor: boolean
IsCoMan: boolean
IsStaging: boolean
```

Response 200:

```text
ID: guid
Name: string
IsDefault: boolean
AllowReorder: boolean
Bins: []
PickZones: null
IsDeprecated: boolean
IsShopfloor: boolean
IsCoMan: boolean
IsStaging: boolean
```

### PUT `/`

Request body:

```text
ID: guid
Name: string
AddressLine1: string
AddressLine2: string
AddressCitySuburb: string
AddressStateProvince: string
AddressZipPostCode: string
AddressCountry: string
IsShopfloor: boolean
IsCoMan: boolean
```

Response 200:

```text
ID: guid
Name: string
IsDefault: boolean
AllowReorder: boolean
Bins: []
PickZones: null
IsDeprecated: boolean
IsShopfloor: boolean
IsCoMan: boolean
IsStaging: boolean
```

### DELETE `/ref/location`

| Parameter | Type | Required |
|---|---|---|
| `ID` | string | yes |

Response 200:

```text
Success: boolean
```

