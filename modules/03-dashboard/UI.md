# Dashboard: UI

Every component the page code builds, read from the shipped ExtJS bundles: grids with their columns, fields, buttons, menus, windows and custom components. Labels are the English UI text. `renders into` is the id of the `<div>` in the page's server-rendered HTML that the component mounts in; `store` names the data store (see the endpoints in [README.md](README.md)); `on click` is the handler. Visual system and shell layout: [docs/UI.md](../../docs/UI.md).

## Screens

| Route | Title | Bundles |
|---|---|---|
| `/ContinueSetup` | Continue setup | [`ContinueSetup`](#continuesetup) |
| `/Home` | Dashboard | [`Home2019`](#home2019) |

## Components by bundle

### `ContinueSetup`

2 grids · 0 standalone fields · 0 windows · 0 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `AccountsReconciliationGrid` · store `OnboardingReconciliationStore` · placeholder `Not available`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | External account | `ExternalName` |  | flex 1 | renderer() |  |
    | {Ext.String.format(…)} | `EntityCode` |  | flex 1 | renderer() |  |

- **grid** · renders into `TaxRulesReconciliationGrid` · store `OnboardingReconciliationStore` · placeholder `Not available`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | External tax rule | `ExternalName` |  | flex 1 | renderer() |  |
    | {Ext.String.format(…)} | `EntityCode` |  | flex 1 | renderer() |  |


### `Home2019`

15 grids · 5 standalone fields · 0 windows · 8 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `renderTo` · store `store` · placeholder `Please upload a file to check for issues.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Line # | `Line` |  | 50 |  |  |
    | Product code | `ProductCode` |  | 200 | renderer() |  |
    | Name | `Name` |  | 300 | renderer() |  |
    | Category | `Category` |  | 200 | renderer() |  |
    | Brand | `Brand` |  | 200 | renderer() |  |
    | Type | `Type` |  | 100 | renderer() |  |
    | Costing method | `CostingMethod` |  | 150 | renderer() |  |
    | Length | `Length` |  | 100 | renderer() |  |
    | Width | `Width` |  | 100 | renderer() |  |
    | Height | `Height` |  | 100 | renderer() |  |
    | Dimension units | `DimensionUnits` |  | 100 | renderer() |  |
    | Weight | `Weight` |  | 100 | renderer() |  |
    | Weight units | `WeightUnits` |  | 100 | renderer() |  |
    | Barcode | `Barcode` |  | 150 | renderer() |  |
    | Minimum before reorder | `MinimumBeforeReorder` |  | 100 | renderer() |  |
    | Reorder quantity | `ReorderQuantity` |  | 150 | renderer() |  |
    | Default location | `DefaultLocation` |  | 150 | renderer() |  |
    | Last supplied by | `LastSuppliedBy` |  | 200 | renderer() |  |
    | Supplier product code | `SupplierProductCode` |  | 300 | renderer() |  |
    | Supplier product name | `SupplierProductName` |  | 300 | renderer() |  |
    | Price tier 1 | `PriceTier1` |  | 130 | renderer() |  |
    | Price tier 2 | `PriceTier2` |  | 130 | renderer() |  |
    | Price tier 3 | `PriceTier3` |  | 130 | renderer() |  |
    | Price tier 4 | `PriceTier4` |  | 130 | renderer() |  |
    | Price tier 5 | `PriceTier5` |  | 130 | renderer() |  |
    | Price tier 6 | `PriceTier6` |  | 130 | renderer() |  |
    | Price tier 7 | `PriceTier7` |  | 130 | renderer() |  |
    | Price tier 8 | `PriceTier8` |  | 130 | renderer() |  |
    | Price tier 9 | `PriceTier9` |  | 130 | renderer() |  |
    | Price tier 10 | `PriceTier10` |  | 130 | renderer() |  |
    | Assembly BOM | `AssemblyBOM` |  | 200 | renderer() |  |
    | Auto assemble | `AutoAssemble` |  | 200 | renderer() |  |
    | Auto disassemble | `Auto Disassemble` |  | 200 | renderer() |  |
    | Drop ship | `DropShip` |  | 200 | renderer() |  |
    | Average cost | `AverageCost` |  | 130 | renderer() |  |
    | Default unit of measure | `DefaultUnitOfMeasure` |  | 200 | renderer() |  |
    | Inventory account | `InventoryAccount` |  | 200 | renderer() |  |
    | Revenue account | `RevenueAccount` |  | 200 | renderer() |  |
    | Expense account | `ExpenseAccount` |  | 200 | renderer() |  |
    | COGS account | `COGSAccount` |  | 200 | renderer() |  |
    | Product attribute set | `ProductAttributeSet` |  | 200 | renderer() |  |
    | Additional attribute 1 | `AdditionalAttribute1` |  | 200 | renderer() |  |
    | Additional attribute 2 | `AdditionalAttribute2` |  | 200 | renderer() |  |
    | Additional attribute 3 | `AdditionalAttribute3` |  | 200 | renderer() |  |
    | Additional attribute 4 | `AdditionalAttribute4` |  | 200 | renderer() |  |
    | Additional attribute 5 | `AdditionalAttribute5` |  | 200 | renderer() |  |
    | Additional attribute 6 | `AdditionalAttribute6` |  | 200 | renderer() |  |
    | Additional attribute 7 | `AdditionalAttribute7` |  | 200 | renderer() |  |
    | Additional attribute 8 | `AdditionalAttribute8` |  | 200 | renderer() |  |
    | Additional attribute 9 | `AdditionalAttribute9` |  | 200 | renderer() |  |
    | Additional attribute 10 | `AdditionalAttribute10` |  | 200 | renderer() |  |
    | Discount name | `DiscountName` |  | 200 | renderer() |  |
    | Product family SKU | `ProductFamilySKU` |  | 200 | renderer() |  |
    | Product family option 1 value | `ProductFamilyOption1Value` |  | 200 | renderer() |  |
    | Product family option 2 value | `ProductFamilyOption2Value` |  | 200 | renderer() |  |
    | Product family option 3 value | `ProductFamilyOption3Value` |  | 200 | renderer() |  |
    | Comma-delimited tags | `CommaDelimitedTags` |  | 200 | renderer() |  |
    | Stock locator | `StockLocator` |  | 200 | renderer() |  |
    | Purchase tax rule | `PurchaseTaxRule` |  | 200 | renderer() |  |
    | Sale tax rule | `SaleTaxRule` |  | 200 | renderer() |  |
    | Status | `Status` |  | 100 | renderer() |  |
    | Pick zones | `PickZones` |  | 100 | renderer() |  |
    | Always show quantity | `AlwaysShowQuantity` |  | 200 | renderer() |  |
    | Production BOM | `ProductionBOM` |  | 200 | renderer() |  |
    | Quantity to produce | `QuantityToProduce` |  | 200 | renderer() |  |

- **grid** · renders into `renderTo` · store `store`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Line # | `Line` |  | 50 | RenderHTMLText |  |
    | Name | `Name` |  | 100 | renderer() |  |
    | Status | `Status` |  | 100 | renderer() |  |
    | Currency | `Currency` |  | 100 | renderer() |  |
    | Payment term | `PaymentTerm` |  | 100 | renderer() |  |
    | Tax rule | `TaxRule` |  | 100 | renderer() |  |
    | Account receivable | `AccountReceivable` |  | 100 | renderer() |  |
    | Sale account | `SaleAccount` |  | 100 | renderer() |  |
    | Price tier | `PriceTier` |  | 100 | renderer() |  |
    | Discount | `Discount` |  | 100 | renderer() |  |
    | Credit limit | `CreditLimit` |  | 100 | renderer() |  |
    | Carrier | `Carrier` |  | 100 | renderer() |  |
    | Sales representative | `SalesRepresentative` |  | 100 | renderer() |  |
    | Location | `Location` |  | 100 | renderer() |  |
    | TaxNumber | `TaxNumber` |  | 100 | renderer() |  |
    | Tags | `Tags` |  | 100 | renderer() |  |
    | Display name | `DisplayName` |  | 100 | renderer() |  |
    | Is legal entity | `IsLegalEntity` |  | 100 | renderer() |  |
    | Parent customer | `ParentCustomer` |  | 100 | renderer() |  |
    | Is bill parent | `IsBillParent` |  | 100 | renderer() |  |
    | Attribute set | `AttributeSet` |  | 100 | renderer() |  |
    | Additional attribute 1 | `AdditionalAttribute1` |  | 100 | renderer() |  |
    | Additional attribute 2 | `AdditionalAttribute2` |  | 100 | renderer() |  |
    | Additional attribute 3 | `AdditionalAttribute3` |  | 100 | renderer() |  |
    | Additional attribute 4 | `AdditionalAttribute4` |  | 100 | renderer() |  |
    | Additional attribute 5 | `AdditionalAttribute5` |  | 100 | renderer() |  |
    | Additional attribute 6 | `AdditionalAttribute6` |  | 100 | renderer() |  |
    | Additional attribute 7 | `AdditionalAttribute7` |  | 100 | renderer() |  |
    | Additional attribute 8 | `AdditionalAttribute8` |  | 100 | renderer() |  |
    | Additional attribute 9 | `AdditionalAttribute9` |  | 100 | renderer() |  |
    | Additional attribute 10 | `AdditionalAttribute10` |  | 100 | renderer() |  |
    | Comments | `Comments` |  | 100 | renderer() |  |
    | Contact name | `ContactName` |  | 100 | renderer() |  |
    | Phone | `Phone` |  | 100 | renderer() |  |
    | Fax | `Fax` |  | 100 | renderer() |  |
    | Email | `Email` |  | 100 | renderer() |  |
    | Website | `Website` |  | 100 | renderer() |  |
    | Contact comment | `ContactComment` |  | 200 | renderer() |  |
    | Contact default | `ContactDefault` |  | 100 | renderer() |  |

- **grid** · renders into `renderTo` · store `store` · placeholder `Please upload a file to check for issues.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Line # | `Line` |  | 50 |  |  |
    | Name | `Name` |  | 100 | renderer() |  |
    | Status | `Status` |  | 100 | renderer() |  |
    | Currency | `Currency` |  | 100 | renderer() |  |
    | Payment term | `PaymentTerm` |  | 100 | renderer() |  |
    | Tax rule | `TaxRule` |  | 100 | renderer() |  |
    | Account payable | `AccountPayable` |  | 100 | renderer() |  |
    | Carrier | `Carrier` |  | 100 | renderer() |  |
    | Discount | `Discount` |  | 100 | renderer() |  |
    | TaxNumber | `TaxNumber` |  | 100 | renderer() |  |
    | Attribute set | `AttributeSet` |  | 100 | renderer() |  |
    | Additional attribute 1 | `AdditionalAttribute1` |  | 100 | renderer() |  |
    | Additional attribute 2 | `AdditionalAttribute2` |  | 100 | renderer() |  |
    | Additional attribute 3 | `AdditionalAttribute3` |  | 100 | renderer() |  |
    | Additional attribute 4 | `AdditionalAttribute4` |  | 100 | renderer() |  |
    | Additional attribute 5 | `AdditionalAttribute5` |  | 100 | renderer() |  |
    | Additional attribute 6 | `AdditionalAttribute6` |  | 100 | renderer() |  |
    | Additional attribute 7 | `AdditionalAttribute7` |  | 100 | renderer() |  |
    | Additional attribute 8 | `AdditionalAttribute8` |  | 100 | renderer() |  |
    | Additional attribute 9 | `AdditionalAttribute9` |  | 100 | renderer() |  |
    | Additional attribute 10 | `AdditionalAttribute10` |  | 100 | renderer() |  |
    | Comments | `Comments` |  | 100 | renderer() |  |
    | Contact name | `ContactName` |  | 100 | renderer() |  |
    | Job title | `JobTitle` |  | 100 | renderer() |  |
    | Phone | `Phone` |  | 100 | renderer() |  |
    | Mobile phone | `MobilePhone` |  | 100 | renderer() |  |
    | Fax | `Fax` |  | 100 | renderer() |  |
    | Email | `Email` |  | 100 | renderer() |  |
    | Website | `Website` |  | 100 | renderer() |  |
    | Contact comment | `ContactComment` |  | 200 | renderer() |  |
    | Contact default | `ContactDefault` |  | 100 | renderer() |  |
    | Contact include in email | `ContactIncludeInEmail` |  | 100 | renderer() |  |

- **grid** · renders into `renderTo` · store `store` · placeholder `Please upload a file to check for issues.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Line # | `Line` |  | 50 |  |  |

- **grid** · renders into `divPurchases` · store `PurchaseStore` · placeholder `No purchases found.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Order # | `OrderNo` |  | flex 2 | renderer() |  |
    | Order date | `OrderDate` |  | flex 2 | renderer() |  |
    | Due date | `InvoiceDueDate` |  | flex 2 | renderer() |  |
    | Supplier | `Supplier` |  | flex 4 | renderer() |  |
    | Due amount | `Due` |  | flex 2 | renderer() |  |
    | Invoiced amount | `Invoiced` |  | flex 2 | renderer() |  |
    | Ordered amount | `Ordered` |  | flex 2 | renderer() |  |
    | Required by | `ShipmentRequiredByDate` |  | flex 2 | renderer() |  |

- **grid** · renders into `divSales` · store `SaleStore` · placeholder `No sales found.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Order # | `OrderNo` |  | flex 2 | renderer() |  |
    | Order date | `OrderDate` |  | flex 2 | renderer() |  |
    | Ship by date | `InvoiceDueDate` |  | flex 2 | renderer() |  |
    | Due amount | `Due` |  | flex 2 | renderer() |  |
    | Total | `Amount` |  | flex 2 | renderer() |  |
    | Customer | `Customer` |  | flex 4 | renderer() |  |

- **grid** · renders into `divReorder` · store `ReorderStore` · placeholder `You do not have any products to reorder at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | SKU | `ProductCode` |  | flex 1 | renderer() |  |
    | Product description | `Name` |  | flex 2 | renderer() |  |
    | Supplier | `Supplier` |  | flex 2 | renderer() |  |
    | Reorder quantities shown here depend on your purchase proce… | `Available` |  | flex 1 |  |  |

- **grid** · renders into `divProductOverviewSellings` · store `Dashboard_ProductOverview_SellingsStore` · placeholder `No products`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    |  | `ProductImage` |  | 40 |  |  |
    | Product | `ProductName` |  | flex 3 | renderer() |  |
    | Price | `Price` |  | flex 1 | renderer() |  |
    | Sold | `Quantity` |  | flex 1 | renderer() |  |
    | Sale | `` |  | flex 1 | renderer() |  |
    | Tax | `Tax` |  | flex 1 | renderer() |  |
    | Total | `Quantity` |  | flex 1 | renderer() |  |

- **grid** · renders into `divProductOverviewBrand` · store `Dashboard_ProductOverview_BrandStore` · placeholder `No brands`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Brand | `Name` |  | flex 3 | renderer() |  |
    | Quantity | `Quantity` |  | flex 1 | renderer() |  |
    | Sale | `` |  | flex 1 | renderer() |  |
    | Tax | `Tax` |  | flex 1 | renderer() |  |
    | Total | `Amount` |  | flex 1 | renderer() |  |

- **grid** · renders into `divProductOverviewRegion` · store `Dashboard_ProductOverview_RegionStore` · placeholder `No regions`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Country | `Country` |  | flex 3 | renderer() |  |
    | City | `City` |  | flex 3 | renderer() |  |
    | Sale | `` |  | flex 1 | renderer() |  |
    | Tax | `Tax` |  | flex 1 | renderer() |  |
    | Total | `Amount` |  | flex 1 | renderer() |  |

- **grid** · renders into `divCustomerOverviewSalesRep` · store `Dashboard_CustomerOverview_SalesRepStore` · placeholder `No sales reps.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Sales rep | `SaleRep` |  | flex 3 | RenderHTMLText |  |
    | Sales | `Sales` |  | flex 1 | renderer() |  |
    | Sale | `` |  | flex 1 | renderer() |  |
    | Tax | `Tax` |  | flex 1 | renderer() |  |
    | Total | `Amount` |  | flex 1 | renderer() |  |

- **grid** · renders into `divCustomerOverviewTopCustomers` · store `Dashboard_CustomerOverview_TopCustomersStore` · placeholder `No customers`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Customer | `CustomerName` |  | flex 3 | renderer() |  |
    | Sales | `Sales` |  | flex 1 | renderer() |  |
    | Sale | `` |  | flex 1 | renderer() |  |
    | Tax | `Tax` |  | flex 1 | renderer() |  |
    | Total | `Amount` |  | flex 1 | renderer() |  |

- **grid** · renders into `divCustomerOverviewNoBuys` · store `Dashboard_CustomerOverview_NoBuysStore` · placeholder `No customers`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Customer | `CustomerName` |  | flex 1 | renderer() |  |

- **grid** · renders into `divCustomerOverviewByProducts` · store `Dashboard_CustomerOverview_ByProductStore` · placeholder `No customers, please select a product.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Customer | `CustomerName` |  | flex 3 | renderer() |  |
    | Sales | `Sales` |  | flex 1 | renderer() |  |
    | Sale | `` |  | flex 1 | renderer() |  |
    | Tax | `Tax` |  | flex 1 | renderer() |  |
    | Total | `Amount` |  | flex 1 | renderer() |  |

- **grid** · renders into `divReportGridContainer` · store `ReportStore`

#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| date field |  | `Sale_Index_ShipmentRequiredByDate` | `` | placeholder `Choose date` · format `UserDateFormat` |
| combo |  | `"extLocation_".concat(…)` | `vTenantLocationLoadStore[widgetName]` | shows `Description` · value `LocationID` · placeholder `Choose...` |
| combo |  | `Dashboard_CustomerOverviewByProducts` | `dashboardProductsStore` | shows `Name` · value `ProductID` · placeholder `Select product` |
| date field |  | `startreportrangemanual` | `` | placeholder `Choose...` · format `dearDateFormat` |
| date field |  | `endreportrangemanual` | `` | placeholder `Choose...` · format `dearDateFormat` |

#### Menus, buttons and other parts

- **column** · field `j`
- **column** “{title}” · field `field`
- **EmbeddedCalendarPicker** · renders into `startreportrange` · placeholder `Choose...` · format `dearDateFormat`
- **EmbeddedCalendarPicker** · renders into `endreportrange` · placeholder `Choose...` · format `dearDateFormat`
- **column** “Date” · field `Index`
- **column** “{series.label}” · field `series.label`
- **column** “Due” · field `Due`
- **column** “Overdue” · field `Overdue`

