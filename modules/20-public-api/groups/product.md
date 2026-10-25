# Public API: Product

From Cin7's API Blueprint: field tables (name, type, length, required, allowed values), each operation's query parameters, and request and response bodies as type outlines (`guid`, `string`, `number`, `boolean`, `date`, `null`; `[ … ]` = array of). Base `/ExternalApi/v2`; headers in [docs/PUBLIC-API.md](../../../docs/PUBLIC-API.md).

**Resources:** `/product` · `/product/attachments` · `/ref/productavailability`

## Fields

#### Product

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `ID` | Guid |  |  |  |
| `SKU` | String | 50 | Yes |  |
| `Name` | String | 256 | Yes |  |
| `Category` | String | 256 | Yes |  |
| `Brand` | String | 50 |  |  |
| `Type` | String (read-only) |  | Yes* |  |
| `CostingMethod` | String | 50 | Yes |  |
| `DropShipMode` | String |  |  |  |
| `DefaultLocation` | String | 50 |  |  |
| `Length` | Decimal | 50 |  |  |
| `Width` | Decimal | 50 |  |  |
| `Height` | Decimal | 50 |  |  |
| `Weight` | Decimal | 50 |  |  |
| `CartonLength` | Decimal | 50 |  |  |
| `CartonWidth` | Decimal | 50 |  |  |
| `CartonHeight` | Decimal | 50 |  |  |
| `CartonQuantity` | Decimal | 50 |  |  |
| `CartonInnerQuantity` | Decimal | 50 |  |  |
| `UOM` | String | 50 | Yes |  |
| `WeightUnits` | String | 10 |  |  |
| `DimensionsUnits` | String | 10 |  |  |
| `Barcode` | String | 256 |  |  |
| `MinimumBeforeReorder` | Decimal |  |  |  |
| `ReorderQuantity` | Decimal |  |  |  |
| `PriceTier1` | Decimal |  |  |  |
| `PriceTier2` | Decimal |  |  |  |
| `PriceTier3` | Decimal |  |  |  |
| `PriceTier4` | Decimal |  |  |  |
| `PriceTier5` | Decimal |  |  |  |
| `PriceTier6` | Decimal |  |  |  |
| `PriceTier7` | Decimal |  |  |  |
| `PriceTier8` | Decimal |  |  |  |
| `PriceTier9` | Decimal |  |  |  |
| `PriceTier10` | Decimal |  |  |  |
| `PriceTiers` | Price Tier Model |  |  |  |
| `AverageCost` | Decimal (read-only) |  |  |  |
| `ShortDescription` | String | 500 |  |  |
| `Description` | String | Unlimited |  |  |
| `InternalNote` | String | 4000 |  |  |
| `AdditionalAttribute1` | String | 256 |  |  |
| `AdditionalAttribute2` | String | 256 |  |  |
| `AdditionalAttribute3` | String | 256 |  |  |
| `AdditionalAttribute4` | String | 256 |  |  |
| `AdditionalAttribute5` | String | 256 |  |  |
| `AdditionalAttribute6` | String | 256 |  |  |
| `AdditionalAttribute7` | String | 256 |  |  |
| `AdditionalAttribute8` | String | 256 |  |  |
| `AdditionalAttribute9` | String | 256 |  |  |
| `AdditionalAttribute10` | String | 256 |  |  |
| `AttributeSet` | String | 50 |  |  |
| `DiscountRule` | String | 128 |  |  |
| `Tags` | String | 256 |  |  |
| `Status` | String |  | Yes |  |
| `StockLocator` | String | 256 |  |  |
| `COGSAccount` | String | 50 |  |  |
| `RevenueAccount` | String | 50 |  |  |
| `ExpenseAccount` | String | 50 |  |  |
| `InventoryAccount` | String | 50 |  |  |
| `PurchaseTaxRule` | String | 50 |  |  |
| `SaleTaxRule` | String | 50 |  |  |
| `LastModifiedOn` | DateTime (read-only) |  |  |  |
| `Sellable` | Bool |  |  |  |
| `PickZones` | String | 256 |  |  |
| `BillOfMaterial` | Bool |  |  |  |
| `AutoAssembly` | Bool |  |  |  |
| `AutoDisassembly` | Bool |  |  |  |
| `QuantityToProduce` | Decimal |  | Yes* |  |
| `AssemblyInstructionURL` | String | 256 |  |  |
| `AssemblyCostEstimationMethod` | String | 256 | Yes* |  |
| `BOMType` | String (read-only) |  |  |  |
| `HSCode` | String | 200 |  |  |
| `CountryOfOrigin` | String |  |  |  |
| `CountryOfOriginCode` | String |  |  |  |
| `Suppliers` | [] Product Supplier Model |  |  |  |
| `ReorderLevels` | [] Reorder Level Model |  |  |  |
| `BillOfMaterialsProducts` | [] Bill Of Material Product Model |  |  |  |
| `BillOfMaterialsServices` | [] Bill Of Material Service Model |  |  |  |
| `Movements` | [] Product Movement Model |  |  |  |
| `Attachments` | [] Attachment Line Model |  |  |  |
| `CustomPrices` | [] Custom Price Model |  |  |  |

#### POST Methods

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `ProductID` | Guid |  | Yes |  |
| `FileName` | String |  | Yes |  |
| `IsDefault` | Boolean |  |  |  |
| `FileDownloadUrl` | String |  | No |  |
| `Content` | String |  | Yes* |  |

#### Product Availability

| Field | Type | Length | Required | Allowed values |
|---|---|---|---|---|
| `ID` | Guid |  |  |  |
| `SKU` | String | 50 |  |  |
| `Name` | String | 256 |  |  |
| `Barcode` | String | 256 |  |  |
| `Location` | String | 256 |  |  |
| `Bin` | String | 50 |  |  |
| `Batch` | String |  |  |  |
| `ExpiryDate` | DateTime |  |  |  |
| `OnHand` | Decimal |  |  |  |
| `Allocated` | Decimal |  |  |  |
| `Available` | Decimal |  |  |  |
| `OnOrder` | Decimal |  |  |  |
| `StockOnHand` | Decimal |  |  |  |
| `InTransit` | Decimal |  |  |  |
| `NextDeliveryDate` | DateTime |  |  |  |

## Operations

### GET `/product`

| Parameter | Type | Required |
|---|---|---|
| `ID` |  |  |
| `Page` | number |  |
| `Limit` | number |  |
| `Name` |  |  |
| `Sku` |  |  |
| `ModifiedSince` | date |  |
| `IncludeDeprecated` | boolean |  |
| `IncludeBOM` | boolean |  |
| `IncludeSuppliers` | boolean |  |
| `IncludeMovements` | boolean |  |
| `IncludeAttachments` | boolean |  |
| `IncludeReorderLevels` | boolean |  |
| `IncludeCustomPrices` | boolean |  |

Response 200:

```text
keys: AdditionalAttribute1, AdditionalAttribute10, AdditionalAttribute2, AdditionalAttribute3, AdditionalAttribute4, AdditionalAttribute5, AdditionalAttribute6, AdditionalAttribute7, AdditionalAttribute8, AdditionalAttribute9, Amount, AssemblyCostEstimationMethod, AssemblyInstructionURL, Attachments, AttributeSet, AutoAssembly, AutoDisassembly, AverageCost, Barcode, BatchSN, BillOfMaterial, BillOfMaterialsProducts, BillOfMaterialsServices, Brand, COGSAccount, CartonHeight, CartonInnerQuantity, CartonLength, CartonQuantity, CartonWidth, Category, ComponentProductID, ContentType, CostPercentage, CostingMethod, CountryOfOrigin, CountryOfOriginCode, CustomPrices, Date, DefaultLocation, Description, DimensionsUnits, DiscountRule, DownloadUrl, DropShipMode, ExpenseAccount, ExpiryDate, FileName, FromTo, HSCode, Height, ID, InternalNote, InventoryAccount, LastModifiedOn, Length, Location, LocationID, LocationName, MinimumBeforeReorder, Movements, Name, Number, Page, PickZones, Price, PriceTier, PriceTier1, PriceTier10, PriceTier2, PriceTier3, PriceTier4, PriceTier5, PriceTier6, PriceTier7, PriceTier8, PriceTier9, PriceTiers, ProductCode, ProductID, ProductName, ProductSKU, Products, PurchaseTaxRule, Quantity, QuantityToProduce, ReorderLevels, ReorderQuantity, RevenueAccount, SKU, SaleTaxRule, Sellable, ShortDescription, Status, StockLocator, Suppliers, Tags, TaskID, Total, Type, UOM, WastagePercent, WastageQuantity, Weight, WeightUnits, Width
```

### POST `/`

Request body:

```text
SKU: string
Name: string
Category: string
Brand: null
Type: string
CostingMethod: string
DropShipMode: string
DefaultLocation: string
Length: number
Width: number
Height: number
Weight: number
UOM: string
WeightUnits: string
DimensionsUnits: null
Barcode: string
MinimumBeforeReorder: number
ReorderQuantity: number
PriceTier1: number
PriceTier2: number
PriceTier3: number
PriceTier4: number
PriceTier5: number
PriceTier6: number
PriceTier7: number
PriceTier8: number
PriceTier9: number
PriceTier10: number
PriceTiers: {
  Tier 1: number
  Tier 2: number
  Tier 3: number
  Tier 4: number
  Tier 5: number
  Tier 6: number
  Tier 7: number
  Tier 8: number
  Tier 9: number
  Tier 10: number
}
ShortDescription: string
Description: string
InternalNote: string
AdditionalAttribute1: string
AdditionalAttribute2: string
AdditionalAttribute3: string
AdditionalAttribute4: string
AdditionalAttribute5: string
AdditionalAttribute6: string
AdditionalAttribute7: string
AdditionalAttribute8: string
AdditionalAttribute9: string
AdditionalAttribute10: string
AttributeSet: null
DiscountRule: null
Tags: string
Status: string
StockLocator: string
COGSAccount: null
RevenueAccount: null
ExpenseAccount: null
InventoryAccount: null
PurchaseTaxRule: null
SaleTaxRule: null
Sellable: boolean
PickZones: string
BillOfMaterial: boolean
AutoAssembly: boolean
AutoDisassembly: boolean
QuantityToProduce: number
AssemblyInstructionURL: string
AssemblyCostEstimationMethod: string
Suppliers: [
  SupplierID: guid
  SupplierName: string
  SupplierInventoryCode: string
  SupplierProductName: string
  Cost: number
  FixedCost: number
  Currency: string
  DropShip: boolean
  URL: string
]
ReorderLevels: [
  LocationID: guid
  LocationName: string
  MinimumBeforeReorder: number
  ReorderQuantity: number
  StockLocator: string
  PickZones: string
]
BillOfMaterialsProducts: [
  ComponentProductID: guid
  ProductCode: string
  Name: string
  Quantity: number
  WastagePercent: number
  WastageQuantity: number
  CostPercentage: number
]
BillOfMaterialsServices: [
  ComponentProductID: guid
  Name: string
  Quantity: number
  ExpenseAccount: string
  PriceTier: number
]
CartonHeight: number
CartonWidth: number
CartonLength: number
CartonQuantity: number
CartonInnerQuantity: number
HSCode: string
CountryOfOrigin: string
```

Response 200:

```text
Total: number
Page: number
Products: [
  ID: guid
  SKU: string
  Name: string
  Category: string
  Brand: null
  Type: string
  CostingMethod: string
  DropShipMode: string
  DefaultLocation: string
  Length: number
  Width: number
  Height: number
  Weight: number
  UOM: string
  Barcode: null
  MinimumBeforeReorder: number
  ReorderQuantity: number
  PriceTier1: number
  PriceTier2: number
  PriceTier3: number
  PriceTier4: number
  PriceTier5: number
  PriceTier6: number
  PriceTier7: number
  PriceTier8: number
  PriceTier9: number
  PriceTier10: number
  PriceTiers: {
    Tier 1: number
    Tier 2: number
    Tier 3: number
    Tier 4: number
    Tier 5: number
    Tier 6: number
    Tier 7: number
    Tier 8: number
    Tier 9: number
    Tier 10: number
  }
  AverageCost: number
  ShortDescription: null
  Description: null
  InternalNote: string
  AdditionalAttribute1: null
  AdditionalAttribute2: null
  AdditionalAttribute3: null
  AdditionalAttribute4: null
  AdditionalAttribute5: null
  AdditionalAttribute6: null
  AdditionalAttribute7: null
  AdditionalAttribute8: null
  AdditionalAttribute9: null
  AdditionalAttribute10: null
  AttributeSet: null
  DiscountRule: null
  Tags: string
  Status: string
  StockLocator: null
  COGSAccount: null
  RevenueAccount: null
  ExpenseAccount: null
  InventoryAccount: null
  PurchaseTaxRule: null
  SaleTaxRule: null
  LastModifiedOn: date
  Sellable: boolean
  PickZones: string
  BillOfMaterial: boolean
  AutoAssembly: boolean
  AutoDisassembly: boolean
  QuantityToProduce: number
  AssemblyInstructionURL: null
  AssemblyCostEstimationMethod: string
  Suppliers: [
    SupplierID: guid
    SupplierName: string
    SupplierInventoryCode: string
    SupplierProductName: string
    Cost: number
    FixedCost: number
    Currency: string
    DropShip: boolean
    URL: string
  ]
  ReorderLevels: [
    LocationID: guid
    LocationName: string
    MinimumBeforeReorder: number
    ReorderQuantity: number
    StockLocator: string
    PickZones: string
  ]
  BillOfMaterialsProducts: [
    ComponentProductID: guid
    ProductCode: string
    Name: string
    Quantity: number
    WastagePercent: number
    WastageQuantity: number
    CostPercentage: number
  ]
  BillOfMaterialsServices: [
    ComponentProductID: guid
    Name: string
    Quantity: number
    ExpenseAccount: string
    PriceTier: number
  ]
  Movements: []
  Attachments: []
  CartonHeight: number
  CartonWidth: number
  CartonLength: number
  CartonQuantity: number
  CartonInnerQuantity: number
  HSCode: string
  CountryOfOrigin: string
  CountryOfOriginCode: string
]
```

### PUT `/`

Request body:

```text
ID: guid
SKU: string
Name: string
Category: string
Brand: null
CostingMethod: string
DropShipMode: string
DefaultLocation: string
Length: number
Width: number
Height: number
Weight: number
UOM: string
WeightUnits: string
DimensionsUnits: null
Barcode: string
MinimumBeforeReorder: number
ReorderQuantity: number
PriceTier1: number
PriceTier2: number
PriceTier3: number
PriceTier4: number
PriceTier5: number
PriceTier6: number
PriceTier7: number
PriceTier8: number
PriceTier9: number
PriceTier10: number
PriceTiers: {
  Tier 1: number
  Tier 2: number
  Tier 3: number
  Tier 4: number
  Tier 5: number
  Tier 6: number
  Tier 7: number
  Tier 8: number
  Tier 9: number
  Tier 10: number
}
ShortDescription: string
Description: string
InternalNote: string
AdditionalAttribute1: string
AdditionalAttribute2: string
AdditionalAttribute3: string
AdditionalAttribute4: string
AdditionalAttribute5: string
AdditionalAttribute6: string
AdditionalAttribute7: string
AdditionalAttribute8: string
AdditionalAttribute9: string
AdditionalAttribute10: string
AttributeSet: null
DiscountRule: null
Tags: string
Status: string
StockLocator: string
COGSAccount: null
RevenueAccount: null
ExpenseAccount: null
InventoryAccount: null
PurchaseTaxRule: null
SaleTaxRule: null
Sellable: boolean
PickZones: string
BillOfMaterial: boolean
AutoAssembly: boolean
AutoDisassembly: boolean
QuantityToProduce: number
AssemblyInstructionURL: string
AssemblyCostEstimationMethod: string
Suppliers: [
  SupplierID: guid
  SupplierName: string
  SupplierInventoryCode: string
  SupplierProductName: string
  Cost: number
  FixedCost: number
  Currency: string
  DropShip: boolean
  URL: string
]
ReorderLevels: [
  LocationID: guid
  LocationName: string
  MinimumBeforeReorder: number
  ReorderQuantity: number
  StockLocator: string
  PickZones: string
]
BillOfMaterialsProducts: [
  ComponentProductID: guid
  ProductCode: string
  Name: string
  Quantity: number
  WastagePercent: number
  WastageQuantity: number
  CostPercentage: number
]
BillOfMaterialsServices: [
  ComponentProductID: guid
  Name: string
  Quantity: number
  ExpenseAccount: string
  PriceTier: number
]
CartonHeight: number
CartonWidth: number
CartonLength: number
CartonQuantity: number
CartonInnerQuantity: number
HSCode: string
CountryOfOrigin: string
```

Response 200:

```text
Total: number
Page: number
Products: [
  ID: guid
  SKU: string
  Name: string
  Category: string
  Brand: null
  Type: string
  CostingMethod: string
  DropShipMode: string
  DefaultLocation: string
  Length: number
  Width: number
  Height: number
  Weight: number
  UOM: string
  Barcode: string
  MinimumBeforeReorder: number
  ReorderQuantity: number
  PriceTier1: number
  PriceTier2: number
  PriceTier3: number
  PriceTier4: number
  PriceTier5: number
  PriceTier6: number
  PriceTier7: number
  PriceTier8: number
  PriceTier9: number
  PriceTier10: number
  PriceTiers: {
    Tier 1: number
    Tier 2: number
    Tier 3: number
    Tier 4: number
    Tier 5: number
    Tier 6: number
    Tier 7: number
    Tier 8: number
    Tier 9: number
    Tier 10: number
  }
  AverageCost: number
  ShortDescription: string
  Description: string
  InternalNote: string
  AdditionalAttribute1: string
  AdditionalAttribute2: string
  AdditionalAttribute3: string
  AdditionalAttribute4: string
  AdditionalAttribute5: string
  AdditionalAttribute6: string
  AdditionalAttribute7: string
  AdditionalAttribute8: string
  AdditionalAttribute9: string
  AdditionalAttribute10: string
  AttributeSet: null
  DiscountRule: null
  Tags: string
  Status: string
  StockLocator: string
  COGSAccount: null
  RevenueAccount: null
  ExpenseAccount: null
  InventoryAccount: null
  PurchaseTaxRule: null
  SaleTaxRule: null
  LastModifiedOn: date
  Sellable: boolean
  PickZones: string
  BillOfMaterial: boolean
  AutoAssembly: boolean
  AutoDisassembly: boolean
  QuantityToProduce: number
  AssemblyInstructionURL: string
  AssemblyCostEstimationMethod: string
  Suppliers: [
    SupplierID: guid
    SupplierName: string
    SupplierInventoryCode: string
    SupplierProductName: string
    Cost: number
    FixedCost: number
    Currency: string
    DropShip: boolean
    URL: string
  ]
  ReorderLevels: [
    LocationID: guid
    LocationName: string
    MinimumBeforeReorder: number
    ReorderQuantity: number
    StockLocator: string
    PickZones: string
  ]
  BillOfMaterialsProducts: [
    ComponentProductID: guid
    ProductCode: string
    Name: string
    Quantity: number
    WastagePercent: number
    WastageQuantity: number
    CostPercentage: number
  ]
  BillOfMaterialsServices: [
    ComponentProductID: guid
    Name: string
    Quantity: number
    ExpenseAccount: string
    PriceTier: number
  ]
  Movements: [
    TaskID: guid
    Type: string
    Date: date
    Number: string
    Quantity: number
    Amount: number
    Location: string
    BatchSN: string
    ExpiryDate: date
    FromTo: string
  ]
  Attachments: [
    ID: guid
    ContentType: string
    FileName: string
    DownloadUrl: string
  ]
  CartonHeight: number
  CartonWidth: number
  CartonLength: number
  CartonQuantity: number
  CartonInnerQuantity: number
  HSCode: string
  CountryOfOrigin: string
  CountryOfOriginCode: string
]
```

### GET `/product/attachments`

| Parameter | Type | Required |
|---|---|---|
| `ProductID` |  |  |

Response 200:

```text
[
  ID: guid
  ContentType: string
  IsDefault: string
  FileName: string
  DownloadUrl: string
]
```

### POST `/`

Request body:

```text
keys: 
```

Response 200:

```text
[
  ID: guid
  ContentType: string
  IsDefault: string
  FileName: string
  DownloadUrl: string
]
```

### DELETE `/product/attachments`

| Parameter | Type | Required |
|---|---|---|
| `ID` |  |  |

Response 200:

```text
[
  ID: guid
  ContentType: string
  IsDefault: string
  FileName: string
  DownloadUrl: string
]
```

### GET `/ref/productavailability`

| Parameter | Type | Required |
|---|---|---|
| `Page` | number |  |
| `Limit` | number |  |
| `ID` | Guid |  |
| `Name` | string |  |
| `Sku` | string |  |
| `Location` | string |  |
| `Batch` | string |  |
| `Category` | string |  |

Response 200:

```text
Total: number
Page: number
ProductAvailabilityList: [
  ID: guid
  SKU: string
  Name: string
  Barcode: null
  Location: string
  Bin: null
  Batch: null
  ExpiryDate: null
  OnHand: number
  Allocated: number
  Available: number
  OnOrder: number
  StockOnHand: number
  InTransit: number
  NextDeliveryDate: date
]
```

