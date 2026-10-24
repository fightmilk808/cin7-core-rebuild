# ShipStation: UI

Every component the page code builds, read from the shipped ExtJS bundles: grids with their columns, fields, buttons, menus, windows and custom components. Labels are the English UI text. `renders into` is the id of the `<div>` in the page's server-rendered HTML that the component mounts in; `store` names the data store (see the endpoints in [README.md](README.md)); `on click` is the handler. Visual system and shell layout: [docs/UI.md](../../../docs/UI.md).

## Screens

| Route | Title | Bundles |
|---|---|---|
| `/ShipStation/ConfigurationNG` | ShipStation | [`Shipstation2019`](#shipstation2019) |

## Components by bundle

### `Shipstation2019`

13 grids · 34 standalone fields · 0 windows · 4 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `overviewSalesGridContainer` · store `overviewSalesStore` · placeholder `No sales yet.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    |  | `Status` |  | 100 | renderer() |  |
    | Number | `SaleOrderNumber` |  | flex 2 | renderer() |  |
    | Date | `SaleOrderDate` |  | flex 1 | renderer() |  |
    | Customer | `CustomerName` |  | flex 1 | RenderHTMLText |  |
    | Amount | `PaidTotalAmount` |  | flex 1 | renderer() |  |

- **grid** · renders into `overviewCustomersGridContainer` · store `overviewCustomersStore` · placeholder `No customers yet.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Customer | `Name` |  | flex 2 | renderer() |  |
    | Sales | `OrderCount` |  | flex 1 |  |  |
    | Amount | `PaidTotalAmount` |  | flex 1 | renderer() |  |

- **grid** · renders into `NotMatchingAddresses` · store `mainStore` · placeholder `All sale tasks have matching customer addresses.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Invoice # | `InvoiceNumber` |  | flex 1 | renderer() |  |
    | Customer | `CustomerName` |  | flex 1 | renderer() |  |
    | Invoice date | `InvoiceDate` |  | flex 1 | renderer() |  |
    | Ship by | `ShipmentRequiredByDate` |  | flex 1 | renderer() |  |
    | Address | `ShippingAddressLine1` |  | flex 1 | renderer() |  |
    | Reason | `Reason` |  | flex 2 | RenderHTMLText |  |

- **grid** · renders into `divTaxMapping` · store `vEcsTaxMappingStore` · placeholder `Loading ShipStation tax rates...`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Type | `Description` |  | flex 1 |  |  |
    | Tax rule | `TaxRuleName` |  | flex 1 | renderer() |  |

- **grid** · renders into `divLocationMapping` · store `vEcsLocationMappingStore` · placeholder `Loading ShipStation warehouses...`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Name | `ECSLocationName` |  | flex 1 | RenderHTMLText |  |
    | Location | `LocationName` |  | flex 1 | renderer() |  |

- **grid** · renders into `divShipIntegrationLocationMapping` · store `vShipIntegrationLocationMappingStore` · placeholder `Loading ShipStation warehouses...`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Name | `WarehouseName` |  | flex 1 | RenderHTMLText |  |
    | Location | `LocationName` |  | flex 1 | renderer() |  |

- **grid** · renders into `divPaymentProcessorMapping` · store `vEcsPaymentProcessorMappingStore` · placeholder `Loading ShipStation payment methods...`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Name | `PaymentProcessorName` |  | flex 1 | RenderHTMLText |  |
    | Payment account code | `LedgerAccount` |  | flex 1 | renderer() |  |

- **grid** · renders into `divPendingOrdersGrid` · store `pendingOrdersStore` · placeholder `You do not have any pending orders at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Order # | `OrderNumber` |  | flex 1 | renderer() |  |
    | Date | `DateCreated` | date column | 80 | renderer() |  |
    | Customer | `CustomerName` |  | flex 2 | renderer() |  |
    | Product | `Name` |  | flex 2 | renderer() |  |
    | Quantity | `Quantity` |  | flex 1 |  |  |
    | Total paid | `Total` |  | flex 1 | renderer() |  |

- **grid** · renders into `logGridContainer` · store `logStore` · placeholder `You do not have any captured orders at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Status | `Status` |  | flex 1 | renderer() |  |
    | Date | `Date` | date column | flex 1 | renderer() |  |
    | Invoice # | `OrderNumber` |  | flex 1 |  |  |
    | Type | `Type` |  | flex 1 | renderer() |  |
    | Sale task | `SaleOrderNumber` |  | flex 1 | renderer() |  |

- **grid** · renders into `operationsLogGridContainer` · store `operationsLogStore` · placeholder `No entries found. Please hit refresh or change the search criteria.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Date | `Date` | date column | 170 | renderer() |  |
    | Type | `Type` |  | 80 | renderer() |  |
    | User | `UserName` |  | 200 | renderer() |  |
    | Category | `Category` |  | 100 | renderer() |  |
    | Processed | `Processed` | check column | 80 | renderer() |  |
    | Description | `Description` |  | flex 1 | renderer() |  |

- **grid** · renders into `catalogGridContainer` · store `productStore` · placeholder `There are no products in the catalog.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | SKU | `SKU` |  | flex 2 | renderer() |  |
    | Name | `Name` |  | flex 4 | renderer() |  |
    | Category | `Category` |  | flex 2 | renderer() |  |
    | Price | `Price` |  | flex 1 | renderer() |  |
    | Status | `Status` |  | 85 | renderer() |  |
    | Quantity | `Quantity` |  | flex 1 | renderer() |  |
    | Linked product | `ProductID` |  | flex 4 | renderer() |  |

- **grid** · renders into `gridShipmentServiceFilter` · placeholder `You do not have any filters at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Parameter name | `ParameterName` |  | flex 1 | renderer() |  |
    | Condition | `Condition` |  | flex 1 | renderer() |  |
    | Value | `Value` |  | flex 1 | renderer() |  |
    | Join | `Join` |  | flex 1 | renderer() |  |

- **grid** · renders into `divShipmentLogGrid` · store `ExportLogStore` · placeholder `You do not have any exported sale orders at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Scheduled for export | `ScheduledPeriod` |  | 105 | renderer() |  |
    | SO # | `OrderNumber` |  | flex 1 | renderer() |  |
    | Fulfillment # | `FulfillmentNumber` |  | flex 1 | renderer() |  |
    | Invoice # | `InvoiceNumber` |  | flex 1 | renderer() |  |
    | Customer | `CustomerName` |  | flex 1 | renderer() |  |
    | Ship by | `ShipByDate` |  | 105 | renderer() |  |
    | Status | `Status` |  | 120 | renderer() |  |
    | Comments | `Comments` |  | flex 2 | renderer() |  |


#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| text field |  | `ShipStationFF_Index_ApiKey` | `` |  |
| text field |  | `ShipStationFF_Index_ApiSecret` | `` |  |
| combo |  | `ShipStation_ShippingCostZeroTaxRule` | `ZeroTaxStore` | shows `Description` · value `RuleID` · placeholder `Choose...` |
| combo |  | `ShipstationFF_TaxMapping_Zip` | `USTaxZipTypeAhead` | shows `Name` · value `ID` · placeholder `Type a ZIP code here...` |
| combo |  | `ShipstationFF_TaxMapping_County` | `USTaxCountyTypeAhead` | shows `Name` · value `ID` · placeholder `Type the county name here...` · disabled |
| combo |  | `ShipstationFF_TaxMapping_City` | `USTaxCityTypeAhead` | shows `Name` · value `ID` · placeholder `Type the city name here...` · disabled |
| combo |  | `ShipStationFF_Editor_RevenueAccount` | `RevenueAccountStore` | shows `DisplayName` · value `Code` · placeholder `Choose...` |
| combo |  | `ShipStationFF_Editor_DimUnits` | `DefaultDimUnitStore` | shows `description` · value `type` · placeholder `Choose...` · pick-only |
| text field |  | `ShipStationFF_Editor_CustomSalesRepresentative` | `` | placeholder `write...` |
| combo |  | `ShipStationFF_Index_Topic` | `TopicStore` | shows `description` · value `type` · pick-only |
| combo |  | `ShipStationFF_Index_ConsolidationType` | `ConsolidationTypeStore` | shows `description` · value `type` · pick-only |
| combo |  | `ShipStationFF_Index_ConsolidationTime` | `vTimeStore` | shows `Name` · value `Value` · pick-only |
| combo |  | `ShipStationFF_Index_Customer` | `vCustomerStore` | shows `Name` · value `CustomerID` · placeholder `Choose...` |
| combo |  | `ShipStationFF_Editor_PrimaryPriceTier` | `vSalesPriceTiersStore` | shows `Name` · value `Code` · placeholder `Choose...` · pick-only |
| combo |  | `ShipStationFF_Editor_AutoFulfilmentMode` | `AutoFulfilmentModeStore` | shows `name` · value `value` · placeholder `Choose...` · pick-only |
| combo |  | `ShipStationFF_Editor_InvoiceStatus` | `InvoiceStatusStore` | shows `name` · value `value` · placeholder `Choose...` · pick-only |
| combo |  | `ShipStationFF_Index_CreateAssembly` | `CreateAssemblyStore` | shows `name` · value `value` · placeholder `Choose...` · pick-only |
| combo |  | `ShipStationFF_ShipServ_Currency` | `CurrencyStore` | shows `Code` · value `Code` |
| combo |  | `ShipStation_CustomStoreCurrency` | `CurrencyStore` | shows `Code` · value `Code` · pick-only |
| combo |  | `ShipStationFF_ShipServ_FromAddress` | `vTenantAddressStore` | shows `CountryLine` · value `AddressID` |
| combo |  | `ShipStationFF_ShipServ_TaxRule` | `TaxStore` | shows `Description` · value `RuleID` |
| combo |  | `ShipStationFF_ShipServ_WeightUnits` | `WeightUnitStore` | shows `Name` · value `Code` |
| combo |  | `ShipStationFF_ShipServ_DimUnits` | `DimUnitStore` | shows `Name` · value `Code` |
| combo |  | `ShipStationFF_ShipServ_SSStore` | `ShipstationStoresList` | shows `name` · value `value` · placeholder `Select store` |
| combo |  | `cmbShippingServiceShippingCostZeroTaxRule` | `window.ZeroTaxStore` | shows `Description` · value `RuleID` · placeholder `Choose...` |
| date field |  | `ShipstationFF_FromOrders` | `` | placeholder `Choose...` · format `UserDateFormat` |
| combo |  | `ShipStationFF_CatalogManagment_LinkToProduct` | `ProductChooseStore` | shows `Name` · value `ProductCode` |
| combo |  | `tdBulkListingBrand` | `vTenantBrandStore` | shows `Brand` · value `ID` · placeholder `List all brands` |
| combo |  | `tdBulkListingListedIn` | `ECommerceShopStore` | shows `ShopName` · value `ConfigID` · placeholder `Choose...` |
| date field |  | `divExportLogFrom` | `` | format `UserDateFormat` |
| date field |  | `divExportLogTo` | `` | format `UserDateFormat` |
| combo |  | `divExportLogPeriod` | `periodStore` | shows `name` · value `value` · pick-only |
| date field |  | `"cmbShippingServiceScheduleExport".concat(…)` | `` | placeholder `Choose date` · format `UserDateFormat` |
| date field |  | `"cmbShippingServiceLogDate".concat(…)` | `` | placeholder `Choose date` · format `UserDateFormat` · disabled |

#### Menus, buttons and other parts

- **component** · renders into `ShipStationFF_ShipServ_MarginValue` · required
- **component** · renders into `From_Contact_On_Shipping_Label` · required
- **component** · renders into `From_Company_On_Shipping_Label` · required
- **component** · renders into `"ShipStationFF_ShipServ_".concat(…)`

