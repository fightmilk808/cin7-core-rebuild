# HubSpot: UI

Every component the page code builds, read from the shipped ExtJS bundles: grids with their columns, fields, buttons, menus, windows and custom components. Labels are the English UI text. `renders into` is the id of the `<div>` in the page's server-rendered HTML that the component mounts in; `store` names the data store (see the endpoints in [README.md](README.md)); `on click` is the handler. Visual system and shell layout: [docs/UI.md](../../../docs/UI.md).

## Screens

| Route | Title | Bundles |
|---|---|---|
| `/HubSpot` | HubSpot | [`HubSpot2019`](#hubspot2019) |

## Components by bundle

### `HubSpot2019`

12 grids · 14 standalone fields · 0 windows · 0 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `contactsGridContainer` · store `contactsStore` · placeholder `Contacts are not found`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Contact name | `ContactName` |  | flex 1 |  |  |
    | Company name | `CompanyName` |  | flex 1 |  |  |
    | Company / person | `IsOrganization` |  | flex 1 | renderer() |  |

- **grid** · renders into `divCustomersToExportList` · store `customerStore` · placeholder `Customers are not found`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Name | `Name` |  | flex 1 |  |  |
    | Currency | `Currency` |  | flex 1 | RenderHTMLText |  |
    | Discount | `Discount` |  | flex 1 | RenderHTMLText |  |
    | Status | `IsListed` |  | flex 1 | renderer() |  |
    | Is active | `IsActive` | check column | 90 | renderer() |  |

- **grid** · renders into `logGridContainer` · store `logStore` · placeholder `You do not have any HubSpot log entries at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Date | `LogDate` | date column | flex 1 | renderer() |  |
    | Action | `Action` |  | flex 2 | RenderHTMLText |  |
    | Message | `Message` |  | flex 4 | renderer() |  |

- **grid** · renders into `overviewSalesGridContainer` · store `overviewSalesStore` · placeholder `No data`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Date | `SaleOrderDate` |  | flex 1 | renderer() |  |
    | Number | `SaleOrderNumber` |  | flex 1 | renderer() |  |
    | Customer | `CustomerName` |  | flex 1 | RenderHTMLText |  |
    | Amount | `PaidTotalAmount` |  | flex 1 | renderer() |  |
    | Status | `Status` |  | flex 1 | renderer() |  |

- **grid** · renders into `overviewCustomersGridContainer` · store `overviewCustomersStore` · placeholder `No data`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Customer | `Name` |  | flex 1 | RenderHTMLText |  |
    | Sales | `OrderCount` |  | flex 1 | RenderHTMLText |  |
    | Amount | `PaidTotalAmount` |  | flex 1 | renderer() |  |

- **grid** · renders into `divProductCatalogList` · store `vProductCatalogStore` · placeholder `No products are found.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | HubSpot name | `HubSpotName` |  | flex 1 | renderer() |  |
    | {Ext.String.format(…)} | `ProductCode` |  | flex 3 | renderer() |  |
    | Status | `Status` |  | flex 1 | renderer() |  |
    | Price | `ProductID` |  | flex 1 | renderer() |  |

- **grid** · renders into `divProductToExportList` · store `vProductToExportStore` · placeholder `No products are found.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Category | `CategoryName` |  | flex 1 | RenderHTMLText |  |
    | Type | `Type` |  | flex 1 | RenderHTMLText |  |
    | Product | `ProductCode` |  | flex 5 | renderer() |  |
    | Status | `Status` |  | flex 1 | renderer() |  |
    | Price | `ProductID` |  | flex 1 | renderer() |  |
    |  | `` | action column | 25 |  |  |

- **grid** · renders into `salesImportGridContainer` · store `salesImportStore` · placeholder `You do not have any pending HubSpot sales at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Deal name | `HubSpotDealName` |  | flex 1 |  |  |
    | Create date | `HubSpotDealDate` | date column | flex 1 | renderer() |  |
    | Total | `HubSpotTotal` |  | flex 1 | renderer() |  |
    | HubSpot deal stage | `HubSpotDealStage` |  | flex 1 | RenderHTMLText |  |

- **grid** · renders into `salesExportGridContainer` · store `saleExportStore` · placeholder `Sales are not found.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Order number | `OrderNo` |  | flex 1 |  |  |
    | Date | `OrderDate` | date column | flex 1 | renderer() |  |
    | Customer | `Customer` |  | flex 2 | RenderHTMLText |  |
    | Amount | `TotalAmount` |  | flex 1 | renderer() |  |

- **grid** · renders into `divHubspotCustomerFieldsMapping` · store `vHubspotCustomerFieldsMappingStore` · placeholder `No fields specified yet...`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | {Ext.String.format(…)} | `DearFieldName` |  | flex 1 | renderer() |  |
    | Hubspot field name | `ECSFieldName` |  | flex 1 | renderer() |  |
    |  | `` | action column | 45 | renderer() |  |

- **grid** · renders into `divHubspotSaleFieldsMapping` · store `vHubspotSaleFieldsMappingStore` · placeholder `No fields specified yet...`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | {Ext.String.format(…)} | `DearFieldName` |  | flex 1 | renderer() |  |
    | Hubspot field name | `ECSFieldName` |  | flex 1 | renderer() |  |
    |  | `` | action column | 45 | renderer() |  |

- **grid** · renders into `divHubspotStatusesMapping` · store `vPipeLineStageMappingStore` · placeholder `No fields specified yet...`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Hubspot deal stage | `HubSpotStageName` |  | flex 1 |  |  |
    | {Ext.String.format(…)} | `DearStatus` |  | flex 1 | renderer() |  |


#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| combo |  | `HubSpot_ProductCatalog_Edit_PriceTier` | `vSalesPriceTiersStore` | shows `Name` · value `Code` · placeholder `Choose...` · pick-only |
| combo |  | `HubSpot_ProductCatalog_Edit_Currency` | `` | shows `DisplayCurrency` · value `Currency` · placeholder `Choose...` · pick-only |
| combo |  | `HubSpot_ProductCatalog_Edit_ProductName` | `DearProductStore` | shows `Name` · value `ProductID` · placeholder `type or choose...` |
| combo |  | `cmbProductToExport_Category` | `vTenantCategoriesStore` | shows `Name` · value `Value` |
| combo |  | `cmbProductToExport_Type` | `ProductToExportTypeStore` | shows `Name` · value `Value` |
| combo |  | `cmdProductToExport_PriceTier` | `vSalesPriceTiersStore` | shows `Name` · value `Code` · placeholder `Choose...` · pick-only |
| combo |  | `cmbProductToExport_PriceTierCurrency` | `` | shows `DisplayCurrency` · value `Currency` · placeholder `Choose...` · pick-only |
| combo |  | `cmbProductToExport_ListingStatus` | `BulkListingStatusStore` | shows `Name` · value `Value` · placeholder `List all products` · pick-only |
| date field |  | `HubSpot_FromOrders` | `` | placeholder `Choose...` · format `UserDateFormat` |
| date field |  | `HubSpot_ExportFromOrders` | `` | placeholder `Choose...` · format `UserDateFormat` |
| combo |  | `HubSpot_NewProperty_EntityType` | `PropertyTypeStore` | shows `Name` · value `Value` · placeholder `Select an entity type` · pick-only |
| date field |  | `divAutoSyncStartDate` | `` | placeholder `Choose...` · format `UserDateFormat` |
| combo |  | `divAutoSyncMailingList` | `MailingListStore` | shows `Name` · value `MailingListID` · placeholder `type or choose...` |
| combo |  | `cmbCreateSaleWhenHubSpotReachesStage` | `vHubSpotStagesStore` | shows `HubSpotStageName` · value `HubSpotStageID` · placeholder `type or choose...` |

