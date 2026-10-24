# Etsy: UI

Every component the page code builds, read from the shipped ExtJS bundles: grids with their columns, fields, buttons, menus, windows and custom components. Labels are the English UI text. `renders into` is the id of the `<div>` in the page's server-rendered HTML that the component mounts in; `store` names the data store (see the endpoints in [README.md](README.md)); `on click` is the handler. Visual system and shell layout: [docs/UI.md](../../../docs/UI.md).

## Screens

| Route | Title | Bundles |
|---|---|---|
| `/Etsy` | Etsy | [`Etsy2019`](#etsy2019) |

## Components by bundle

### `Etsy2019`

13 grids · 28 standalone fields · 0 windows · 8 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `divTaxMapping` · store `vEcsTaxMappingStore` · placeholder `Loading Etsy tax rates...`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Type | `Description` |  | flex 1 | RenderHTMLText |  |
    | Tax rule | `TaxRuleName` |  | flex 1 | renderer() |  |

- **grid** · renders into `divPaymentProcessorMapping` · store `vEcsPaymentProcessorMappingStore` · placeholder `Loading Etsy payment methods...`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Name | `PaymentProcessorName` |  | flex 1 | RenderHTMLText |  |
    | Payment account code | `LedgerAccount` |  | flex 1 | renderer() |  |

- **grid** · renders into `divPendingOrdersGrid` · store `pendingOrdersStore` · placeholder `You do not have any pending Etsy sales at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Order number | `OrderNumber` |  | flex 2 | renderer() |  |
    | Date | `DateCreated` | date column | 150 | renderer() |  |
    | Customer | `CustomerName` |  | flex 2 | renderer() |  |
    | Product | `Name` |  | flex 2 | renderer() |  |
    | Quantity | `Quantity` |  | flex 1 |  |  |
    | Total paid | `Total` |  | flex 1 | renderer() |  |

- **grid** · renders into `logGridContainer` · store `logStore` · placeholder `You do not have any captured Etsy sales at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Status | `Status` |  | flex 1 | renderer() |  |
    | Date | `Date` | date column | flex 1 | renderer() |  |
    | Download date | `DownloadDate` | date column | flex 1 | renderer() |  |
    | Process date | `ProcessDate` | date column | flex 1 | renderer() |  |
    | Etsy invoice # | `OrderNumber` |  | flex 1 |  |  |
    | Type | `Type` |  | flex 1 | renderer() |  |
    | Sale task | `SaleOrderNumber` |  | flex 1 | renderer() |  |

- **grid** · renders into `operationsLogGridContainer` · store `operationsLogStore` · placeholder `No entries found. Please hit refresh or change the search criteria.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Date | `Date` | date column | flex 2 | renderer() |  |
    | Type | `Type` |  | flex 1 | renderer() |  |
    | User | `UserName` |  | flex 2 | renderer() |  |
    | Category | `Category` |  | flex 2 | renderer() |  |
    | Processed | `Processed` | check column | 80 | renderer() |  |
    | Description | `Description` |  | flex 4 | renderer() |  |

- **grid** · renders into `overviewSalesGridContainer` · store `overviewSalesStore` · placeholder `No sales yet.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    |  | `Status` |  | 100 | renderer() |  |
    | Number | `SaleOrderNumber` |  | 130 | renderer() |  |
    | Date | `SaleOrderDate` |  | 130 | renderer() |  |
    | Customer | `CustomerName` |  | flex 1 | RenderHTMLText |  |
    | Amount | `PaidTotalAmount` |  | 130 | renderer() |  |

- **grid** · renders into `overviewCustomersGridContainer` · store `overviewCustomersStore` · placeholder `No customers yet.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Customer | `Name` |  | flex 1 | renderer() |  |
    | Sales | `OrderCount` |  | 100 |  |  |
    | Amount | `PaidTotalAmount` |  | 130 | renderer() |  |

- **grid** · renders into `dearCatalogGridContainer` · store `productToListStore` · placeholder `There are no products available to be published.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `Name` |  | flex 1 | renderer() |  |
    | Price | `Price` |  | 100 | renderer() |  |
    | Quantity | `Quantity` |  | 100 | renderer() |  |
    | Status | `Status` |  | 150 | renderer() |  |

- **grid** · renders into `dearSelectedCatalogGridContainer` · store `selectedProductsToListStore` · placeholder `There are no selected products.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `Name` |  | flex 3 | renderer() |  |
    | SKU | `SKU` |  | flex 1 | renderer() |  |
    | Price | `Price` |  | 80 | renderer() |  |
    | Publishing profile | `LProfile` |  | flex 2 | renderer() |  |

- **grid** · renders into `EtsyListingProfilesContainer` · store `vListingProfileStore` · placeholder `There are no profiles created yet..`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Profile name | `Name` |  | flex 3 | renderer() |  |
    | Shipping template | `ShippingProfileName` |  | flex 3 | renderer() |  |

- **grid** · renders into `failedPublishGridContainer` · store `productToListFailedStore` · placeholder `There are no error messages..`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `Name` |  | flex 5 | renderer() |  |
    | Publishing profile | `ProfileName` |  | flex 3 |  |  |
    | Message | `Result` |  | flex 6 | renderer() |  |

- **grid** · renders into `catalogGridContainer` · store `productStore` · placeholder `There are no products in the catalog.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | SKU | `SKU` |  | flex 2 | renderer() |  |
    | Name | `Name` |  | flex 4 | renderer() |  |
    | Category | `Category` |  | flex 2 | renderer() |  |
    | Price | `Price` |  | flex 1 | renderer() |  |
    | Status | `Status` |  | 75 | renderer() |  |
    | Quantity | `Quantity` |  | 90 | renderer() |  |
    | Linked product | `ProductID` |  | flex 4 | renderer() |  |

- **grid** · renders into `Etsy_Catalog_FamilyMappingGrid` · store `variationStore` · placeholder `There are no variations.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    |  | `Status` |  | 110 | renderer() |  |
    | Etsy product | `SKU` |  | flex 4 | renderer() |  |
    | Price | `Price` |  | flex 1 | renderer() |  |
    | Option 1 | `Option1` |  | flex 1 | renderer() |  |
    | Option 2 | `Option2` |  | flex 1 | renderer() |  |
    | Option 3 | `Option3` |  | flex 1 | renderer() |  |
    | Linked product | `ProductID` |  | flex 4 | renderer() |  |


#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| text field |  | `Etsy_Index_ShopName` | `` |  |
| combo |  | `Etsy_Index_Language` | `vEtsyLanguageStore` | shows `description` · value `Code` · pick-only |
| combo |  | `Etsy_Editor_RevenueAccount` | `RevenueAccountStore` | shows `DisplayName` · value `Code` · placeholder `Choose...` |
| text field |  | `Etsy_Editor_CustomSalesRepresentative` | `` | placeholder `write...` |
| combo |  | `Etsy_Index_Topic` | `TopicStore` | shows `description` · value `type` · pick-only |
| combo |  | `Etsy_Index_ConsolidationType` | `ConsolidationTypeStore` | shows `description` · value `type` · pick-only |
| combo |  | `Etsy_Index_ConsolidationTime` | `vTimeStore` | shows `Name` · value `Value` · pick-only |
| combo |  | `Etsy_Index_Customer` | `vCustomerStore` | shows `Name` · value `CustomerID` · placeholder `Choose...` |
| combo |  | `Etsy_Editor_PrimaryPriceTier` | `vSalesPriceTiersStore` | shows `Name` · value `Code` · placeholder `Choose...` · pick-only |
| combo |  | `Etsy_Editor_AutoFulfilmentMode` | `AutoFulfilmentModeStore` | shows `name` · value `value` · placeholder `Choose...` · pick-only |
| combo |  | `Etsy_Editor_InvoiceStatus` | `InvoiceStatusStore` | shows `name` · value `value` · placeholder `Choose...` · pick-only |
| combo |  | `Etsy_Index_CreateAssembly` | `CreateAssemblyStore` | shows `name` · value `value` · placeholder `Choose...` · pick-only |
| combo |  | `Etsy_Editor_Location` | `LocationStore` | shows `Description` · value `LocationID` · placeholder `Choose warehouse...` · pick-only |
| date field |  | `Etsy_FromOrders` | `` | placeholder `Choose...` · format `UserDateFormat` |
| text field |  | `` | `` | placeholder `Type a price...` |
| combo |  | `` | `vListingProfileStore` | shows `Name` · value `id` · placeholder `Select a profile...` |
| combo |  | `Etsy_PListingDialog_Category` | `EstyCategoryStore` | shows `name` · value `id` · placeholder `Select category...` · pick-only |
| combo |  | `Etsy_LProfile_ShipTemplate` | `ShippingTemplateStore` | shows `Title` · value `Id` · placeholder `Select a template...` · pick-only |
| combo |  | `Etsy_LProfile_ReadinessState` | `ReadinessStateStore` | shows `DisplayTitle` · value `Id` · placeholder `Select readiness state...` · pick-only |
| combo |  | `Etsy_LProfile_Who` | `EstyWhoStore` | shows `name` · value `id` · placeholder `Made by...` · pick-only |
| combo |  | `Etsy_LProfile_When` | `EstyWhenStore` | shows `name` · value `id` · placeholder `Select when it was made...` · pick-only |
| combo |  | `Etsy_CatalogManagment_LinkToProduct` | `ProductChooseStore` | shows `Name` · value `ProductCode` |
| combo |  | `Etsy_CatalogManagment_LinkToFamily` | `FamilyChooseStore` | shows `Name` · value `FamilyID` · placeholder `Do not link Etsy product` |
| combo |  | `tdBulkListingBrand` | `vTenantBrandStore` | shows `Brand` · value `ID` · placeholder `List all brands` |
| combo |  | `tdBulkListingListedIn` | `ECommerceShopStore` | shows `ShopName` · value `ConfigID` · placeholder `Choose...` |
| date field |  | `divExportLogFrom` | `` | format `UserDateFormat` |
| date field |  | `divExportLogTo` | `` | format `UserDateFormat` |
| combo |  | `divExportLogPeriod` | `periodStore` | shows `name` · value `value` · pick-only |

#### Menus, buttons and other parts

- **button** “All” · on click `Etsy_Index_Publish_SelectedBulkMenu_SetLProfileAll`
- **button** “Only selected” · on click `Etsy_Index_Publish_SelectedBulkMenu_SetLProfileSelected`
- **button** “Only empty” · on click `Etsy_Index_Publish_SelectedBulkMenu_SetLProfileOnlyForEmpty`
- **button** “Clear all” · on click `Etsy_Index_Publish_SelectedBulkMenu_SetLProfileEmptyAll`
- **button** “All” · on click `Etsy_Index_Publish_SelectedBulkMenu_SetPriceAll`
- **button** “Only selected” · on click `Etsy_Index_Publish_SelectedBulkMenu_SetPriceSelected`
- **item** “Price”
- **item** “Profile”

