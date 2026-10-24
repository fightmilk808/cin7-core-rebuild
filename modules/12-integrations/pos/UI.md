# POS: UI

Every component the page code builds, read from the shipped ExtJS bundles: grids with their columns, fields, buttons, menus, windows and custom components. Labels are the English UI text. `renders into` is the id of the `<div>` in the page's server-rendered HTML that the component mounts in; `store` names the data store (see the endpoints in [README.md](README.md)); `on click` is the handler. Visual system and shell layout: [docs/UI.md](../../../docs/UI.md).

## Screens

| Route | Title | Bundles |
|---|---|---|
| `/DearPos` | POS | [`Pos2019`](#pos2019) |

## Components by bundle

### `Pos2019`

18 grids · 104 standalone fields · 4 windows · 6 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `divOutletLevelSKU` · store `vPosProductStore` · placeholder `No outlet products SKU was found.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | SKU | `SKU` |  | flex 1 | renderer() |  |
    | Product | `Name` |  | flex 1 | renderer() |  |
    | Category | `Category` |  | flex 1 | renderer() |  |
    | Outlet SKU | `OutletSKU` |  | flex 1 | renderer() |  |

- **grid** · renders into `divPaymentProcessorMapping \| divPaymentsMapping` · store `vPaymentMethodStore \| @vPaymentMethodStoreSub` · placeholder `Loading POS payment methods mappings... \| No payment methods mapping…`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Name | `PaymentMethodName` |  | flex 1 |  |  |
    | Payment account code | `Value` |  | 250 | renderer() |  |
    | Surcharges | `SurchargeIDs` |  | flex 1 | renderer() |  |

- **grid** · renders into `cashManagementReasonGridContainer` · store `cashManagementReasonStore` · placeholder `Reasons are not found.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Reason | `ReasonName` |  | flex 1 | renderer() |  |

- **grid** · renders into `cashPaymentSetupGridContainer` · store `cashPaymentSetupStore` · placeholder `Banknote denominations are not found.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Denomination | `Nominal` | number column | flex 1 | renderer() |  |

- **grid** · renders into `catalogGridContainer` · store `productStore` · placeholder `No products found.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | SKU | `ProductCode` |  | flex 1 | renderer() |  |
    | Product | `Name` |  | flex 2 | renderer() |  |
    | Category | `Category` |  | flex 1 | renderer() |  |
    | Status | `Status` |  | flex 1 | renderer() |  |
    | Price | `Price` |  | flex 1 | renderer() |  |

- **grid** · renders into `exportPaymentsGridContainer` · store `exportPaymentsStore` · placeholder `No payments to export.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | POS sale # | `OrderNumber` |  | 160 | RenderHTMLText |  |
    | Invoice # | `InvoiceNumber` |  | 160 | renderer() |  |
    | Error | `Error` |  | flex 1 | renderer() |  |

- **grid** · renders into `userManagementGridContainer` · store `userManagementStore` · placeholder `Users are not found.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Email address | `UserName` |  | flex 1 | renderer() |  |
    | Name | `Name` |  | flex 1 | renderer() |  |
    | Role | `RoleName` |  | flex 1 | renderer() |  |
    | Outlet | `PosOutletIDs` |  | flex 1 | renderer() · edit: cell editor |  |
    | Permissions | `` |  | 110 | renderer() |  |
    | User images | `ImagesCount` |  | 100 | renderer() |  |

- **grid** · renders into `surchargeGridContainer` · store `surchargeStore` · placeholder `Surcharges are not found.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Name | `Name` |  | flex 1 | renderer() |  |
    | Type | `Type` |  | flex 1 | renderer() |  |
    | Value | `Value` |  | flex 1 | renderer() |  |
    | Refund surcharge | `RefundSurcharge` | check column | 100 | renderer() |  |
    | Active | `IsActive` | check column | 100 | renderer() |  |

- **grid** · renders into `cclpGridContainer` · store `cclpStore` · placeholder `Customers are not found`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Name | `Name` |  | flex 1 | renderer() |  |
    | Loyalty points | `LoyaltyPoints` |  | 160 | renderer() |  |
    | Customer's credits | `StoreCredits` |  | 160 | renderer() |  |
    | Email POS receipts automatically | `SendReceiptViaEmail` |  | 160 | renderer() |  |

- **grid** · renders into `divPendingOrdersGrid` · store `pendingOrdersStore` · placeholder `You do not have any pending POS sales at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Order # | `OrderNumber` |  | 100 | renderer() |  |
    | Date | `DateCreated` | date column | 120 | renderer() |  |
    | Customer | `CustomerName` |  | flex 1 | renderer() |  |
    | Product | `Name` |  | flex 2 | renderer() |  |
    | Quantity | `Quantity` |  | 100 |  |  |
    | Total | `Total` |  | flex 1 | renderer() |  |

- **grid** · renders into `logGridContainer` · store `logStore` · placeholder `You do not have any captured POS orders at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Status | `Status` |  | flex 1 | renderer() |  |
    | Date | `Date` | date column | flex 2 | renderer() |  |
    | Download date | `DownloadDate` | date column | flex 1 | renderer() |  |
    | Process date | `ProcessDate` | date column | flex 1 | renderer() |  |
    | POS invoice # | `OrderNumber` |  | flex 1 |  |  |
    | Type | `Type` |  | flex 1 | renderer() |  |
    | Sale task | `SaleOrderNumber` |  | flex 1 | renderer() |  |

- **grid** · renders into `divBulkList` · store `bulkStore` · placeholder `No products found.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | SKU | `ProductCode` |  | flex 1 | renderer() |  |
    | Product | `Name` |  | flex 2 | renderer() |  |
    | Category | `Category` |  | flex 1 | renderer() |  |
    | Status | `Status` |  | 100 | renderer() |  |
    | Available quantity | `Quantity` |  | 100 |  |  |
    | Price | `Price` |  | 100 | renderer() |  |

- **grid** · renders into `overviewSalesGridContainer` · store `overviewSalesStore` · placeholder `No sales yet.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    |  | `Status` |  | flex 1 | renderer() |  |
    | Number | `SaleOrderNumber` |  | 130 | renderer() |  |
    | Date | `SaleOrderDate` |  | 130 | renderer() |  |
    | Customer | `CustomerName` |  | flex 3 | RenderHTMLText |  |
    | Amount | `PaidTotalAmount` |  | flex 1 | renderer() |  |

- **grid** · renders into `overviewCustomersGridContainer` · store `overviewCustomersStore` · placeholder `No customers yet.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Customer | `Name` |  | flex 3 | renderer() |  |
    | Sales | `OrderCount` |  | 100 |  |  |
    | Amount | `PaidTotalAmount` |  | flex 1 | renderer() |  |
    |  | `` | action column | 25 |  |  |

- **grid** · renders into `divAttachmentList` · store `ImageStore` · placeholder `You do not have any files attached.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Name | `FileName` |  | flex 1 | renderer() |  |
    | Default | `isDefault` | check column | 100 | renderer() |  |

- **grid** · renders into `divHolidaysGrid` · placeholder `You do not have any holidays yet.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Date | `Date` | date column | flex 1 | edit: date field |  |
    | Description | `Comment` |  | flex 1 | renderer() |  |

- **grid** · renders into `divSpecialsGrid` · placeholder `You do not have any custom working days yet.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Date | `Date` | date column | 100 | edit: date field |  |
    | Start | `StartTime` |  | 130 | renderer() |  |
    | End | `EndTime` |  | 130 | renderer() |  |
    | Break start | `BreakStartTime` |  | flex 1 | renderer() |  |
    | Break end | `BreakEndTime` | date column | flex 1 | renderer() |  |

- **grid** · renders into `divDaysGrid` · placeholder `You do not have any working days yet.` · layout column
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Day | `DayOfWeek` |  | flex 1 | renderer() | pick-only |
    | Start | `StartTime` |  | flex 1 | renderer() |  |
    | End | `EndTime` |  | flex 1 | renderer() |  |
    | Break start | `BreakStartTime` |  | flex 1 | renderer() |  |
    | Break end | `BreakEndTime` | date column | flex 1 | renderer() |  |
    |  | `` |  | 57 | renderer() |  |


#### Windows and dialogs

- **window** “Update quantities in POS” · modal · layout fit
- **window** “Load stock operations from POS” · modal · layout fit
- **window** “Load customers from POS” · modal · layout fit
- **window** “Load suppliers from POS” · modal · layout fit

#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| combo |  | `tdAdvancedBarcodeMode` | `AdvancedBarcodeModeStore` | shows `name` · value `value` |
| number field |  | `divAdvancedBarcodeSKULength` | `` |  |
| number field |  | `divAdvancedBarcodeValueLength` | `` | read-only |
| number field |  | `divAdvancedBarcodeValueDecimalPoint` | `` |  |
| text field |  | `tdOutTyroMerchantID` | `` | placeholder `Tyro merchant ID` |
| text field |  | `tdOutTriPOSAccountID` | `` | placeholder `triPOS account ID` |
| text field |  | `tdOutTriPOSAcceptorID` | `` | placeholder `triPOS acceptor ID` |
| text field |  | `tdOutTriPOSAccountToken` | `` | placeholder `triPOS account token` |
| text field |  | `DearPos_Index_PosName` | `` | placeholder `New POS name` |
| combo |  | `DearPos_Index_Topic` | `TopicStore` | shows `description` · value `type` · pick-only |
| combo |  | `DearPos_Index_ConsolidationType` | `ConsolidationTypeStore` | shows `description` · value `type` · pick-only |
| combo |  | `DearPos_Index_ConsolidationTime` | `vTimeStore` | shows `Name` · value `Value` |
| combo |  | `DearPos_Index_Customer` | `vCustomerStore` | shows `Name` · value `CustomerID` · placeholder `Choose...` |
| text field |  | `divECSspecificParameter1` | `` |  |
| number field |  | `divPinLength` | `` |  |
| number field |  | `divDeliveryNumberPerDay` | `` |  |
| number field |  | `divDeliveryTimeInterval` | `` |  |
| number field |  | `divAutoLockAfter` | `` |  |
| text field |  | `divTyroMerchantID` | `` |  |
| text field |  | `divTriPOSAccountID` | `` |  |
| text field |  | `divTriPOSAcceptorID` | `` |  |
| text field |  | `divTriPOSAccountToken` | `` |  |
| combo |  | `tdECSspecificParameter3` | `vReceiptTemplateStore` | shows `Name` · value `TemplateID` · placeholder `Choose...` |
| combo |  | `tdClosureRegisterReportTemplate` | `vClosureRegisterReportTemplateStore` | shows `Name` · value `TemplateID` · placeholder `Choose...` |
| combo |  | `tdDeliveryTemplate` | `vDeliveryTemplateStore` | shows `Name` · value `TemplateID` · placeholder `Choose...` |
| combo |  | `tdSaleQuoteTemplate` | `vSaleQuoteTemplateStore` | shows `Name` · value `TemplateID` · placeholder `Choose...` |
| combo |  | `tdECSspecificParameter6` | `CashFloatStore` | shows `DisplayName` · value `Code` · placeholder `Choose...` |
| combo |  | `tdRounding` | `RevenueAccountStore` | shows `DisplayName` · value `Code` · placeholder `Choose...` |
| combo |  | `tdRoundTo` | `RoundingDenominationStore` | shows `Name` · value `Code` · placeholder `Choose...` |
| combo |  | `tdRoundingRule` | `RoundingRulesStore` | shows `Name` · value `Code` · placeholder `Choose...` |
| combo |  | `tdECSspecificParameter7` | `TillDiscrepancyStore` | shows `DisplayName` · value `Code` · placeholder `Choose...` |
| combo |  | `tdLoyaltyExpenseAccount` | `ExpenseAccountStore` | shows `DisplayName` · value `Code` · placeholder `Choose...` |
| combo |  | `tdDefaultSalesTax` | `TaxStore` | shows `Description` · value `RuleID` · placeholder `Choose...` |
| combo |  | `tdSurchargeTaxRule` | `TaxStore` | shows `Description` · value `RuleID` · placeholder `Choose...` |
| combo |  | `tdZeroTax` | `ZeroTaxStore` | shows `Description` · value `RuleID` · placeholder `Choose...` |
| combo |  | `DearPos_Editor_PrimaryPriceTier` | `vSalesPriceTiersStore` | shows `Name` · value `Code` · placeholder `Choose...` |
| combo |  | `DearPos_Editor_AutoFulfilmentMode` | `AutoFulfilmentModeStore` | shows `name` · value `value` · placeholder `Choose...` |
| combo |  | `DearPos_Editor_CreateAssembly` | `CreateAssemblyStore` | shows `name` · value `value` · placeholder `Choose...` |
| combo |  | `DearPos_Editor_LoadCustomersMode` | `LoadCustomersModeStore` | shows `name` · value `value` · placeholder `Choose...` |
| combo |  | `DearPos_Editor_PaymentDisplayOrder` | `PaymentDisplayOrderStore` | shows `name` · value `value` · placeholder `Choose...` |
| combo |  | `DearPos_Editor_InvoiceStatus` | `InvoiceStatusStore` | shows `name` · value `value` · placeholder `Choose...` |
| combo |  | `DearPos_Editor_PettyCash` | `PettyCashStore` | shows `DisplayName` · value `Code` · placeholder `Choose...` |
| combo |  | `DearPos_Editor_CashInOut` | `CashFloatStore` | shows `DisplayName` · value `Code` · placeholder `Choose...` |
| combo |  | `DearPos_Editor_RevenueAccount` | `RevenueAccountStore` | shows `DisplayName` · value `Code` · placeholder `Choose...` |
| text field |  | `DearPos_Editor_CustomSalesRepresentative` | `` | placeholder `write...` |
| text field |  | `DearPos_Editor_ReplyEmail` | `` | placeholder `write...` |
| combo |  | `DearPos_Editor_CmbCustomSalesRepresentative` | `customSalesRepresentativeComboStore` | shows `Name` · value `Code` · placeholder `Choose...` |
| text field |  | `tdWindcaveUsername` | `` | placeholder `Windcave username` |
| text field |  | `tdWindcaveKey` | `` | placeholder `Windcave key` |
| number field |  | `DearPos_Catalog_Loyalty` | `` |  |
| text field |  | `divAddUserName` | `` | placeholder `Email address / Login` |
| text field |  | `divAddName` | `` | placeholder `Name` |
| combo |  | `tdAddUserRole` | `RoleStore` | shows `RoleName` · value `RoleId` · placeholder `Role` · pick-only |
| combo |  | `tdAddUserOutlet` | `outletSelectorStore` | shows `OutletName` · value `PosOutletID` · placeholder `Outlet` · pick-only · multi-select |
| text field |  | `divAddSurchargeName` | `` | placeholder `Name` |
| combo |  | `tdAddSurchargeType` | `SurchargeTypeStore` | shows `name` · value `value` · placeholder `Type` · pick-only |
| number field |  | `tdAddSurchargeValue` | `` | placeholder `Value` |
| combo |  | `tdBulkListingStatus` | `BulkListingStatusStore` | shows `Name` · value `Value` · placeholder `List all products` · pick-only |
| text field |  | `tdOutletNameEdit` | `` |  |
| text field |  | `tdPaymentSenseURLEdit` | `` | placeholder `Paymentsense outlet URL` |
| text field |  | `tdPaymentSenseAPIKeyEdit` | `` | placeholder `Paymentsense outlet API key` |
| combo |  | `tdOutletMappingValue` | `LocationStore` | shows `Description` · value `LocationID` · pick-only |
| combo |  | `tdOutletTimeZoneEdit` | `vTimezoneStore` | shows `displayName` · value `name` · placeholder `Choose the store's timezone...` · pick-only |
| combo |  | `tdOutletTaxRuleEdit` | `TaxStore` | shows `Description` · value `RuleID` · placeholder `Default sales tax` |
| combo |  | `tdOutletSurchargeTaxRule` | `TaxStore` | shows `Description` · value `RuleID` · placeholder `Surcharge tax rule` |
| combo |  | `tdOutletLedgerAccountEdit` | `AccountStore` | shows `DisplayName` · value `Code` · read-only |
| combo |  | `tdOutletReceiptEdit` | `vReceiptTemplateStore` | shows `Name` · value `TemplateID` · placeholder `Receipt template` · pick-only |
| combo |  | `tdOutletSquareIntegration` | `SquareIntegrationStore` | shows `ShopName` · value `ID` · placeholder `Square integration to process returns` |
| text field |  | `tdRegistryCode` | `` |  |
| combo |  | `tdRegistryLedgerAccount` | `AccountStore` | shows `DisplayName` · value `Code` · placeholder `Cash account` |
| combo |  | `tdRegistryReceipt` | `vReceiptTemplateStore` | shows `Name` · value `TemplateID` · placeholder `Receipt template` |
| combo |  | `tdRegistryTillDiscrepancy` | `TillDiscrepancyStore` | shows `DisplayName` · value `Code` · placeholder `Till discrepancy` |
| combo |  | `tdRegistryCashFloat` | `CashFloatStore` | shows `DisplayName` · value `Code` · placeholder `Cash float` |
| combo |  | `tdRegistryPettyCash` | `PettyCashStore` | shows `DisplayName` · value `Code` · placeholder `Petty cash` |
| combo |  | `tdRegistryCashInOut` | `CashFloatStore` | shows `DisplayName` · value `Code` · placeholder `Cash in/out` |
| text field |  | `tdRegistryPrefix` | `` | placeholder `Receipt prefix` |
| text field |  | `tdRegistrySuffix` | `` | placeholder `Receipt suffix` |
| text field |  | `tdTyroTerminalID` | `` | placeholder `Tyro terminal ID` |
| text field |  | `tdTriPOSLaneID` | `` | placeholder `triPOS lane ID` |
| text field |  | `tdLinklyUserName` | `` | placeholder `Linkly Cloud username` |
| text field |  | `tdLinklyPassword` | `` | placeholder `Linkly Cloud password` |
| text field |  | `tdWindcaveStation` | `` | placeholder `Windcave station` |
| date field |  | `DearPos_FromOrders` | `` | placeholder `Choose...` · format `UserDateFormat` |
| combo |  | `tdBulkCategory` | `CategoryStore` | shows `Category` · value `CategoryID` · placeholder `List all categories` |
| combo |  | `tdBulkTag` | `TagsStore` | shows `Value` · value `Value` · placeholder `List all tags` |
| combo |  | `tdRegistryQuickKey` | `window.vPosQuickKeyStore` | shows `Name` · value `QuickKeyID` · placeholder `Quick Key` |
| text field |  | `tdquickKeyName` | `` |  |
| combo |  | `tdCatalogTilesSize` | `CatalogTilesSizeStore` | shows `name` · value `value` · placeholder `Choose...` |
| combo |  | `tdRegistryCatalogTilesSize` | `CatalogTilesSizeStore` | shows `name` · value `value` · placeholder `Catalog size` |
| combo |  | `tdCatalogTilesVisibility` | `CatalogTilesVisibilityStore` | shows `name` · value `value` · placeholder `Choose...` |
| combo |  | `tdRegistryCatalogTilesVisibility` | `CatalogTilesVisibilityStore` | shows `name` · value `value` · placeholder `Tile visibility` |
| combo |  | `"cmbGroupingOperator-".concat(…)` | `GroupingOperatorStore` | shows `name` · value `value` · pick-only |
| combo |  | `"cmbBrands-".concat(…)` | `brandStore` | shows `Brand` · value `Brand` · placeholder `type to search brands` |
| combo |  | `"cmbCategories-".concat(…)` | `CategoryStore2` | shows `Category` · value `Category` · placeholder `Type to search categories` |
| combo |  | `"cmbTags-".concat(…)` | `TagsStore` | shows `Value` · value `Value` · placeholder `type to search tags` |
| file field |  | `"tdUploadQuickKeyImageControl-".concat(…)` | `"attachedQuickKeyImageFile-".concat(…)` |  |
| text field |  | `"tdquickKeyFolderName-".concat(…)` | `` | placeholder `Name here` |
| combo |  | `tdBulkListingBrand` | `vTenantBrandStore` | shows `Brand` · value `ID` · placeholder `List all brands` |
| combo |  | `tdBulkListingListedIn` | `ECommerceShopStore` | shows `ShopName` · value `ConfigID` · placeholder `Choose...` |
| combo |  | `weekStartCmb` | `WeekDaysStore` | shows `name` · value `value` |
| multi-select combo |  | `weekEndsCmb` | `WeekDaysStore` | shows `name` · value `value` |
| date field |  | `divExportLogFrom` | `` | format `UserDateFormat` |
| date field |  | `divExportLogTo` | `` | format `UserDateFormat` |
| combo |  | `divExportLogPeriod` | `periodStore` | shows `name` · value `value` · pick-only |

#### Menus, buttons and other parts

- **button** “Download customers” · on click `DearPos_Index_DownloadCustomersShow`
- **button** “Download suppliers” · on click `DearPos_Index_DownloadSuppliersShow`
- **button** “Update quantity” · on click `DearPos_Index_UpdateQuantityShow`
- **button** “Reset layout” · on click `handler()`
- **component** · renders into `divECSspecificParameter5`
- **component** · renders into `tdBulkFamily` · store `FamilyStore` · shows `Name` · value `ID` · placeholder `List all families`

