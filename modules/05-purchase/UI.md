# Purchase: UI

Every component the page code builds, read from the shipped ExtJS bundles: grids with their columns, fields, buttons, menus, windows and custom components. Labels are the English UI text. `renders into` is the id of the `<div>` in the page's server-rendered HTML that the component mounts in; `store` names the data store (see the endpoints in [README.md](README.md)); `on click` is the handler. Visual system and shell layout: [docs/UI.md](../../docs/UI.md).

## Screens

| Route | Title | Bundles |
|---|---|---|
| `/DropShipPurchase` | Drop shipment purchase | [`PurchaseDropShip2019`](#purchasedropship2019) |
| `/LatestProductPriceBySupplier` | Product Prices by Supplier | [`LatestProductPriceBySupplier2019`](#latestproductpricebysupplier2019) |
| `/LeadSafetyValues` | Reorder parameters | [`LeadSafetyValues2019`](#leadsafetyvalues2019) |
| `/Payment` | Supplier bulk payment | [`Payment2019`](#payment2019) |
| `/Purchase` | Purchase | [`SimplePurchase2019`](#simplepurchase2019) |
| `/PurchaseAdvanced` | Advanced purchase | [`AdvancedPurchase2019`](#advancedpurchase2019) |
| `/PurchaseCreditNote` | Purchase credit note | [`PurchaseCreditNote2019`](#purchasecreditnote2019) |
| `/PurchaseList` | Purchases | [`PurchaseList2019`](#purchaselist2019) |
| `/PurchaseService` | Service purchase | [`PurchaseService2019`](#purchaseservice2019) |
| `/Reorder` | Reorder level of stock | [`ReorderLevelOfStock2019`](#reorderlevelofstock2019) |
| `/ReorderBackordered` | Reorder backordered stock | [`ReorderBackorderedStock2019`](#reorderbackorderedstock2019) |
| `/SuggestReorder` | Reorder suggestion | [`ReorderSuggestion2019`](#reordersuggestion2019) |
| `/Supplier` | Supplier | [`MultilingualSupport2019`](#multilingualsupport2019), [`Supplier2019`](#supplier2019) |
| `/SupplierDeposits` | Supplier deposits | [`SupplierDeposits2019`](#supplierdeposits2019) |
| `/SupplierList` | Suppliers | [`SupplierList2019`](#supplierlist2019) |

## Components by bundle

### `AdvancedPurchase2019`

32 grids · 60 standalone fields · 0 windows · 35 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `divWorkflowHistoryLines` · store `store` · placeholder `Workflow history is not available now.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Date | `DateUtc` |  | flex 1 | renderer() |  |
    | Workflow name | `WorkflowName` |  | flex 1 |  |  |
    | Event | `EventName` |  | flex 1 |  |  |
    | Name | `Name` |  | flex 1 |  |  |
    | State | `State` |  | flex 1 |  |  |
    | Description | `Description` |  | flex 3 | renderer() |  |

- **grid** · renders into `divRealDimensions` · store `window.AccountingDimensionsRealTempStore` · placeholder `emptyMsgText`
- **grid** · renders into `_classPrivateFieldGet(…)` · store `_classPrivateFieldGet(…)`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    |  | `Selected` |  | 58 | renderer() |  |
    | Original account | `AccountCode` |  | flex 1 | renderer() |  |
    | Amount | `Amount` |  | flex 1 | renderer() |  |
    | Distributed amount | `DistributedAmount` |  | flex 1 | renderer() |  |
    | Left to distribute | `LeftToDistribute` |  | flex 1 | renderer() |  |
    | Note | `Invoices` |  | flex 2 | renderer() |  |

- **grid** · renders into `divHistoryLines` · store `_classPrivateFieldGet(…)` · placeholder `Activity log is not available now.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Date | `DateChanged` |  | flex 1 | renderer() |  |
    | Changes made | `ColumnsChanged` |  | flex 4 | renderer() |  |
    | User | `ChangedBy` |  | flex 2 |  |  |

- **grid** · renders into `_classPrivateFieldGet(_DOM_ID_MAP,this).DIV_GRID` · store `store` · placeholder `You have not imported any files.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | File name | `DocumentName` |  | flex 3 | renderer() |  |
    | Status | `Status` |  | flex 1 | renderer() |  |
    | Extracted date | `DateCreated` |  | flex 1 | renderer() |  |
    | Action | `FileID` |  | flex 1 | renderer() |  |

- **grid** · renders into `logsGridContainer` · store `store`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Date | `Date` | date column | 200 | renderer() |  |
    | Document name | `DocumentName` |  | flex 1 | RenderHTMLText |  |
    | Comment | `Comment` |  | flex 1 |  |  |
    | User | `UserName` |  | flex 1 |  |  |

- **grid** · renders into `divDistributedAccounts` · store `PurchaseExpenseStore`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    |  | `Selected` |  | 58 | renderer() |  |
    | Original account | `AccountCode` |  | flex 1 | renderer() |  |
    | Amount | `Amount` |  | flex 1 | renderer() |  |
    | Distributed amount | `DistributedAmount` |  | flex 1 | renderer() |  |
    | Left to distribute | `LeftToDistribute` |  | flex 1 | renderer() |  |
    | Note | `Invoices` |  | flex 2 | renderer() |  |

- **grid** · renders into `divRelatedOrdersDetails` · store `RelatedOrdersStore` · placeholder `No related orders created.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Order | `TaskNumber` |  | flex 1 | renderer() |  |
    | Type | `TaskTypeName` |  | flex 1 | RenderHTMLText |  |
    | Order date | `OrderDate` |  | flex 1 | renderer() |  |
    | Status | `Status` |  | flex 1 | renderer() |  |
    | Total | `TotalAmount` |  | 130 | renderer() |  |

- **grid** · renders into `divManualJournalsDistributedCosts` · placeholder `You do not have any manual journals.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `ProductID` |  | flex 1 | renderer() |  |
    | Invoice total | `InvoiceTotal` |  | 200 | renderer() | total sum |
    | Manual journal cost | `DistributedCost` |  | 200 | renderer() | total sum |

- **grid** · renders into `Purchase_NewAllocation_Deposits` · store `vPurchaseDepositStore` · placeholder `No credits/deposits found for the selected supplier.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Date | `Date` |  | flex 2 | renderer() |  |
    | Description | `Description` |  | flex 5 |  |  |
    | Remaining / total | `Amount` |  | flex 3 | renderer() |  |

- **grid** · renders into `Purchase_NewAllocation_Allocations` · store `dialogSelectedStore` · placeholder `No selected supplier deposits.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Date | `Date` |  | flex 2 | renderer() |  |
    | Description | `Description` |  | flex 4 |  |  |
    | Available to allocate | `RemainingAmount` |  | flex 2 | renderer() |  |
    | Allocated | `AllocatedAmount` |  | flex 2 | renderer() |  |

- **grid** · renders into `divCreditNoteLines` · placeholder `You do not have any credit note lines.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `ProductCode` |  | flex 2 | renderer() |  |
    | Comment | `Comment` |  | flex 1 | renderer() | total count |
    | Supplier SKU | `SupplierInventoryCode` |  | flex 1 | renderer() |  |
    | Unit | `UnitOfMeasure` |  | flex 1 | renderer() |  |
    | Quantity | `Quantity` |  | flex 1 |  | total sum |
    | Price | `Price` |  | flex 1 | renderer() |  |
    | Discount | `Discount` | number column | flex 1 | renderer() |  |
    | Account | `AccountCode` |  | flex 2 | renderer() |  |
    | Total | `Total` |  | flex 1 | renderer() | total sum |

- **grid** · renders into `divCreditNoteAdditionalCostLines` · placeholder `You do not have any additional costs.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Description | `Description` |  | flex 2 | renderer() |  |
    | Reference | `Reference` |  | flex 2 | renderer() |  |
    | Quantity | `Quantity` |  | flex 1 | renderer() |  |
    | Price | `Amount` |  | flex 1 | renderer() |  |
    | Discount | `Discount` | number column | flex 1 | renderer() |  |
    | Tax rule | `TaxRule` |  | flex 2 | renderer() |  |
    | Account | `AccountCode` |  | flex 2 | renderer() |  |
    | Total | `Total` |  | flex 1 | renderer() |  |

- **grid** · renders into `divCreditNotePayments` · placeholder `You do not have any refunds.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Account | `AccountCode` |  | flex 2 | renderer() |  |
    | Reference | `Reference` |  | flex 3 | renderer() |  |
    | Date paid | `DatePaid` | date column | flex 1 | edit: date field |  |
    | Amount | `Amount` |  | flex 1 | renderer() |  |
    | Conversion rate | `CurrencyConversionRate` |  | flex 1 | renderer() |  |
    | Base amount | `Amount` |  | flex 1 | renderer() |  |

- **grid** · renders into `divInvoiceLines` · placeholder `You do not have any invoice lines.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `ProductCode` |  | flex 2 | renderer() |  |
    | Comment | `Comment` |  | flex 1 | renderer() | total count |
    | Supplier SKU | `SupplierInventoryCode` |  | flex 1 | RenderHTMLText |  |
    | Unit | `UnitOfMeasure` |  | flex 1 | renderer() |  |
    | Quantity | `Quantity` |  | flex 1 |  | total sum |
    | Price | `Price` |  | flex 1 | renderer() |  |
    | Discount | `Discount` | number column | flex 1 | renderer() |  |
    | Tax rule | `TaxRule` |  | flex 1 | renderer() |  |
    | Account | `AccountCode` |  | flex 1 | renderer() |  |
    | Total | `Total` |  | flex 1 | renderer() | total sum |

- **grid** · renders into `divInvoiceAdditionalCostLines` · placeholder `You do not have any additional costs.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Description | `Description` |  | flex 3 | renderer() |  |
    | Reference | `Reference` |  | flex 2 | renderer() |  |
    | Quantity | `Quantity` |  | flex 1 |  |  |
    | Price | `Amount` |  | flex 1 | renderer() |  |
    | Discount | `Discount` | number column | flex 1 | renderer() |  |
    | Tax rule | `TaxRule` |  | flex 1 | renderer() |  |
    | Account | `AccountCode` |  | flex 1 | renderer() |  |
    | Total | `Total` |  | flex 1 | renderer() |  |

- **grid** · renders into `divInvoicePayments` · placeholder `You do not have any payments.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Account | `AccountCode` |  | flex 1 | renderer() |  |
    | Reference | `Reference` |  | flex 2 | renderer() |  |
    | Date paid | `DatePaid` | date column | flex 1 | edit: date field |  |
    | Amount | `Amount` |  | flex 1 | renderer() |  |
    | Conversion rate | `CurrencyConversionRate` |  | flex 1 | renderer() |  |
    | Base amount | `Amount` |  | flex 1 | renderer() |  |

- **grid** · renders into `UploadInvoiceLinesExceptionsGrid` · store `InvoiceLinesUploadErrorsStore` · placeholder `Please upload a file to check for issues.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Line # | `Line` |  | 50 |  |  |
    | Product SKU | `SKU` |  | 150 | renderer() |  |
    | Product name | `Name` |  | 250 | renderer() |  |
    | Quantity | `Quantity` |  | 100 | renderer() |  |
    | Price | `Price` |  | 100 | renderer() |  |
    | Discount | `Discount` |  | 100 | renderer() |  |
    | Comment | `Comment` |  | 150 | renderer() |  |

- **grid** · renders into `divVerifyInvoiceGrid` · store `VerifyInvoiceStore`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `ProductName` |  | flex 1 |  | total count |
    | Inner quantity | `CartonInnerQuantity` |  | flex 1 |  |  |
    | Estimated outer carton quantity | `CartonQuantity` |  | flex 1 |  |  |
    | Actual number of outer cartons | `NumberOfCartons` |  | flex 1 |  | total sum |
    | Volume of outer carton | `CartonVolume` |  | flex 1 | renderer() |  |
    | Line volume | `LineVolume` |  | flex 1 | renderer() | total sum |
    | Line freight cost | `LineFreightCost` |  | flex 1 | renderer() |  |
    | Unit freight cost | `UnitFreightCost` |  | flex 1 | renderer() |  |

- **grid** · renders into `divManualJournalsLines` · placeholder `You do not have any manual journals.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    |  | `DistributeType` |  | 100 | renderer() |  |
    | Debit | `Debit` |  | flex 1 | renderer() |  |
    | Credit | `Credit` |  | flex 1 | renderer() |  |
    | Reference | `Reference` |  | flex 1 | renderer() |  |
    | Date | `Date` | date column | flex 1 | edit: date field |  |
    | Amount | `Amount` |  | flex 1 | renderer() |  |
    | Type | `DistributeType` |  | flex 1 | renderer() |  |

- **grid** · renders into `divOrderLines` · placeholder `You do not have any purchase order lines.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `ProductCode` |  | flex 2 | renderer() |  |
    | Comment | `Comment` |  | flex 1 | renderer() | total count |
    | Supplier SKU | `SupplierInventoryCode` |  | flex 1 | renderer() |  |
    | Unit | `UnitOfMeasure` |  | flex 1 | renderer() |  |
    | Quantity | `Quantity` |  | flex 1 |  | total sum |
    | Price | `Price` |  | flex 1 | renderer() |  |
    | Discount | `Discount` | number column | flex 1 | renderer() |  |
    | Tax rule | `TaxRule` |  | flex 1 | renderer() |  |
    | Total | `Total` |  | flex 1 | renderer() | total sum |

- **grid** · renders into `divOrderAdditionalCostLines` · placeholder `You do not have any additional costs in your purchase order.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Description | `Description` |  | flex 3 | renderer() |  |
    | Reference | `Reference` |  | flex 2 | renderer() |  |
    | Quantity | `Quantity` |  | flex 1 |  |  |
    | Price | `Amount` |  | flex 1 | renderer() |  |
    | Discount | `Discount` | number column | flex 1 | renderer() |  |
    | Tax rule | `TaxRule` |  | flex 1 | renderer() |  |
    | Total | `Total` |  | flex 1 | renderer() |  |

- **grid** · renders into `divDeposits` · placeholder `You do not have any supplier deposits.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Account | `AccountCode` |  | flex 2 | renderer() |  |
    | Reference | `Reference` |  | flex 2 | renderer() |  |
    | Date paid | `DatePaid` | date column | flex 1 | edit: date field |  |
    | Amount | `Amount` |  | flex 1 | renderer() |  |
    | Conversion rate | `CurrencyConversionRate` |  | flex 1 | renderer() |  |
    | Base amount | `Amount` |  | flex 1 | renderer() |  |

- **grid** · renders into `UploadPOLinesExceptionsGrid` · store `POLinesUploadErrorsStore` · placeholder `Please upload a file to check for issues.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Line # | `Line` |  | 50 |  |  |
    | Product SKU | `SKU` |  | 150 | renderer() |  |
    | Product name | `Name` |  | 250 | renderer() |  |
    | Quantity | `Quantity` |  | 100 | renderer() |  |
    | Price | `Price` |  | 100 | renderer() |  |
    | Discount | `Discount` |  | 100 | renderer() |  |
    | Supplier SKU | `SupplierSKU` |  | 150 | renderer() |  |
    | Comment | `Comment` |  | 150 | renderer() |  |

- **grid** · renders into `divProductReplenishmentDetails` · store `ProductReplenishmentDetailsStore`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `ProductName` |  | flex 1 |  |  |
    | Orderquantity | `OrderQuantity` | number column | flex 1 |  | total sum |
    | Available | `Available` |  | flex 1 |  |  |
    | Backordered | `Backordered` |  | flex 1 |  |  |
    | MBR | `MinimumBeforeReorder` |  | flex 1 |  |  |
    | MOQ | `MOQ` |  | flex 1 |  |  |
    | On hand | `OnHand` |  | flex 1 |  |  |
    | On order | `OnOrder` |  | flex 1 |  |  |
    | Reorderquantity | `ReorderQuantity` |  | flex 1 |  |  |
    | Suggestedquantity | `SuggestedQuantity` |  | flex 1 |  |  |
    | Inner / outer carton quantity | `CartonInnerQuantity` |  | flex 1 | renderer() |  |
    | Number ofouter cartons | `NumberOfCartons` |  | flex 1 |  | total sum |
    | Linevolume | `LineVolumeSum` |  | flex 1 | renderer() | total sum |

- **grid** · renders into `divTDetails` · store `TransactionsStore` · placeholder `No transactions created.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Effective date | `EffectiveDate` |  | flex 1 | renderer() |  |
    | Document | `DocRef` |  | flex 1 | RenderHTMLText |  |
    | Debit | `Debit` |  | flex 1 | Common_COA_TreeMode_RestoreDisplayName |  |
    | Credit | `Credit` |  | flex 1 | Common_COA_TreeMode_RestoreDisplayName |  |
    | Amount | `Amount` |  | 130 | renderer() |  |

- **grid** · renders into `divScanProductSelection` · store `storeScanProduct`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `SKU` |  | flex 1 | renderer() |  |

- **grid** · renders into `divIntermediateStockReceivedLines` · placeholder `You do not have any stock received lines.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `ProductCode` |  | flex 3 | renderer() |  |
    | Batch/serial # | `BatchSN` |  | flex 1 | renderer() | total count |
    | Expiry date | `ExpiryDate` | date column | flex 1 | renderer() · edit: date field |  |
    | Supplier SKU | `SupplierInventoryCode` |  | flex 1 | RenderHTMLText |  |
    | Unit | `UnitOfMeasure` |  | flex 1 | renderer() |  |
    | Quantity | `Quantity` |  | flex 1 |  | total sum |

- **grid** · renders into `UploadIntermediateStockReceivedLinesExceptionsGrid` · store `IntermediateStockReceivedLinesUploadErrorsStore` · placeholder `Please upload a file to check for issues.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Line # | `Line` |  | 50 |  |  |
    | Product SKU | `SKU` |  | 150 | renderer() |  |
    | Product name | `ProductName` |  | 250 | renderer() |  |
    | Batch/serial # | `BatchSerialNumber` |  | 120 | renderer() |  |
    | Expiry date | `ExpiryDate_YYYYMMDD` |  | 100 | renderer() |  |
    | Quantity | `Quantity` |  | 100 | renderer() |  |
    | Date received | `DateReceived_YYYYMMDD` |  | 100 | renderer() |  |

- **grid** · renders into `divStockReceivedLines` · placeholder `You do not have any stock received lines.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `ProductCode` |  | flex 3 | renderer() |  |
    | Batch/serial # | `BatchSN` |  | flex 1 | renderer() | total count |
    | Expiry date | `ExpiryDate` | date column | flex 1 | renderer() · edit: date field |  |
    | Supplier SKU | `SupplierInventoryCode` |  | flex 1 | RenderHTMLText |  |
    | Unit | `UnitOfMeasure` |  | flex 1 | renderer() |  |
    | Quantity | `Quantity` |  | flex 1 |  | total sum |
    | Location | `Location` |  | flex 1 | renderer() |  |

- **grid** · renders into `UploadStockReceivedLinesExceptionsGrid` · store `StockReceivedLinesUploadErrorsStore` · placeholder `Please upload a file to check for issues.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Line # | `Line` |  | 50 |  |  |
    | Product SKU | `SKU` |  | 150 | renderer() |  |
    | Product name | `Name` |  | 250 | renderer() |  |
    | Batch/serial # | `BatchSerialNumber` |  | 120 | renderer() |  |
    | Expiry date | `ExpiryDate_YYYYMMDD` |  | 100 | renderer() |  |
    | Quantity | `Quantity` |  | 100 | renderer() |  |
    | Location | `Location` |  | 100 | renderer() |  |
    | Date received | `DateReceived_YYYYMMDD` |  | 100 | renderer() |  |
    | Received | `Received` |  | 100 | renderer() |  |

- **grid** · renders into `divUnstockLines` · placeholder `You do not have any items to unstock.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `ProductCode` |  | flex 3 | renderer() | total count |
    | Batch/serial no. | `BatchSN` |  | flex 1 | renderer() |  |
    | Expiry date | `ExpiryDate` |  | flex 1 | renderer() |  |
    | Supplier SKU | `SupplierInventoryCode` |  | flex 1 | renderer() |  |
    | Unit | `UnitOfMeasure` |  | flex 1 | renderer() |  |
    | Quantity | `Quantity` |  | flex 1 |  | total sum |
    | Location | `Location` |  | flex 1 | renderer() |  |
    | Date | `Date` | date column | flex 1 | edit: date field |  |


#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| date field |  | `WorkflowModal_dtWorkflowDate` | `` | format `UserDateFormat` |
| combo |  | `inputId` | `AutocompleteAddressField.prototype.AddressInfoSto…` | shows `description` · value `place_id` · placeholder `Look up an address` |
| text field |  | `renderTo` | `` |  |
| combo |  | `renderTo` | `localStore` | shows `name` · value `value` · placeholder `Choose...` · pick-only |
| checkbox |  | `renderTo` | `` |  |
| numeric field |  | `renderTo` | `` |  |
| date field |  | `renderTo` | `` | placeholder `Choose...` · format `UserDateFormat` |
| text field |  | `renderTo` | `` |  |
| checkbox |  | `renderTo` | `` |  |
| numeric field |  | `renderTo` | `` |  |
| combo |  | `"js-task-name_".concat(…)` | `store` | shows `DistributedAmountGrid_classPrivateField…` · value `DistributedAmountGrid_classPrivateField…` · placeholder `type… |
| numeric field |  | `"divTargetAccountDistribute_".concat(id).concat(…)` | `` |  |
| combo (+ add new) |  | `extDocExtCustomer` | `store` | shows `Name` · value `Name` · placeholder `type to search...` |
| combo |  | `"divTargetPurchase_".concat(…)` | `_store` | shows `InvoiceNumber` · value `TaskID` · placeholder `type to search` |
| numeric field |  | `"divTargetPurchaseAccountDistribute_".concat(inde…` | `` |  |
| combo |  | `"divTargetTask_".concat(…)` | `_store` | shows `TaskNumber` · value `TaskID` · placeholder `type to search` |
| numeric field |  | `"divTargetPurchaseAccountDistribute_other_".conca…` | `` |  |
| combo |  | `"divTargetProduction_".concat(…)` | `_store` | shows `ProductionOrderNumber` · value `ProductionRunID` · placeholder `type to search` |
| numeric field |  | `"divTargetProductionAccountDistribute_production_…` | `` |  |
| combo |  | `Purchase_NewDeposit_Account` | `AccountSupplierDepositStore` | shows `DisplayName` · value `Code` · placeholder `Choose...` |
| combo |  | `Purchase_NewDeposit_BankAccount` | `vBankAccountsStore` | shows `DisplayName` · value `Code` · placeholder `Select a bank account...` · pick-only |
| date field |  | `Purchase_NewDeposit_DatePaid` | `` | placeholder `Choose...` · format `UserDateFormat` |
| combo |  | `tdPurchase_NewSupplier_Currency` | `currencyStore` | shows `Code` · value `Code` |
| text field |  | `tdPurchase_CreditNote_Number` | `` | placeholder `write...` |
| date field |  | `tdPurchase_CreditNote_Date` | `` | placeholder `Choose...` · format `UserDateFormat` |
| text field |  | `tdPurchase_Invoice_Number` | `` | placeholder `write...` |
| date field |  | `tdPurchase_Invoice_Date` | `` | placeholder `Choose...` · format `UserDateFormat` |
| date field |  | `tdPurchase_Invoice_DueDate` | `` | placeholder `Choose...` · format `UserDateFormat` |
| numeric field |  | `tdPurchase_Invoice_Total` | `` |  |
| text field |  | `tdPurchase_Invoice_Total_No_Access` | `` | placeholder `No access` · hidden · disabled |
| numeric field |  | `tdPurchaseInvoiceDomesticFreightCostBaseCurrencyA…` | `` | placeholder `write...` |
| numeric field |  | `tdPurchaseInvoiceDomesticFreightCostOtherCurrency…` | `` | placeholder `write...` |
| numeric field |  | `tdPurchaseInvoiceOceanFreightCostBaseCurrencyAmou…` | `` | placeholder `write...` |
| numeric field |  | `tdPurchaseInvoiceOceanFreightCostOtherCurrencyAmo…` | `` | placeholder `write...` |
| combo |  | `tdPurchaseInvoiceDomesticFreightCostCurrency` | `vCurrenciesWithConversionRates` | shows `ResultCurrencyCode` · value `ResultCurrencyCode` · placeholder `Choose...` |
| combo |  | `tdPurchaseInvoiceOceanFreightCostCurrency` | `vCurrenciesWithConversionRates2` | shows `ResultCurrencyCode` · value `ResultCurrencyCode` · placeholder `Choose...` |
| numeric field |  | `tdPurchaseInvoiceTotalFreightCostAmount` | `` | placeholder `0` |
| combo |  | `Purchase_NewPayment_Account` | `vChartOfAccountsPaymentsStore` | shows `DisplayName` · value `Code` · placeholder `Choose...` |
| date field |  | `Purchase_NewPayment_DatePaid` | `` | placeholder `Choose a date...` · format `UserDateFormat` |
| combo (+ add new) |  | `PurchaseAdvanced_Index_Supplier` | `vPurchase_SupplierStore` | shows `Name` · value `SupplierID` · placeholder `Select a supplier...` |
| combo (+ add new) |  | `Purchase_Index_Contact` | `vPurchase_SupplierContactStore` | shows `Name` · value `Name` · placeholder `Choose...` |
| text field |  | `Purchase_Index_Phone` | `` | placeholder `write...` |
| combo (+ add new) |  | `Purchase_Index_VendorAddressLine1` | `vPurchase_SupplierAddressStore` | shows `Line1` · value `Line1` · placeholder `Address` |
| text field |  | `Purchase_Index_VendorAddressLine2` | `` | placeholder `City, state, country, zip` |
| combo (+ add new) |  | `Purchase_Index_Terms` | `vTenantPaymentTermStore` | shows `Name` · value `Name` · placeholder `Choose...` |
| date field |  | `Purchase_Index_ShipmentRequiredByDate` | `` | placeholder `Choose...` · format `UserDateFormat` |
| numeric field (with action) |  | `tdPurchase_Index_CurrencyConversionRate` | `` |  |
| combo |  | `Purchase_Index_Tax` | `vTenantTaxationRuleStore` | shows `Description` · value `RuleID` · placeholder `Choose...` |
| checkbox |  | `Purchase_Index_Tax_Inclusive` | `` |  |
| checkbox |  | `Purchase_Index_BlindReceipt` | `` |  |
| date field |  | `Purchase_Index_Date` | `` | placeholder `Choose...` · format `UserDateFormat` |
| combo (+ add new) |  | `Purchase_Index_Location` | `vTenantLocationLoadStore` | shows `Description` · value `Description` · placeholder `Choose...` |
| combo (+ add new) |  | `Purchase_Index_SippingAddressLine1` | `vPurchase_TenantAddressStore` | shows `Line1` · value `Line1` · placeholder `Address` |
| text field |  | `Purchase_Index_SippingAddressLine2` | `` | placeholder `City, state, country, zip` |
| checkbox |  | `chkHeaderShipToOther` | `` |  |
| text field |  | `tdScanBatchSN` | `` | placeholder `write...` |
| combo |  | `tdScanBin` | `vTenantLocationLoadStore` | shows `Description` · value `LocationID` · placeholder `choose...` |
| date field |  | `tdScanExpiryDate` | `` | placeholder `Choose...` · format `UserDateFormat` |
| date field |  | `Purchase_IntermediateStockReceived_Date` | `` | placeholder `Choose...` · format `UserDateFormat` |
| date field |  | `Purchase_StockReceived_Date` | `` | placeholder `Choose...` · format `UserDateFormat` |

#### Menus, buttons and other parts

- **column** “Entity” · field `EntityType` · id `colRealDimensionsEntity`
- **column** “Account” · field `AccountCode` · id `colRealDimensionsAccount`
- **column** “Amount” · field `Amount` · id `colRealDimensionsAmount`
- **column** “Reference number” · field `ReferenceNumber` · id `colRealDimensionsReferenceNumber`
- **column** “Effective date” · field `EffectiveDate` · id `colRealDimensionsDate`
- **column** “Product” · field `ProductCode` · id `colRealDimensionsProduct`
- **column** “Supplier \| Customer” · field `"".concat(…)` · id `"colRealDimensions".concat(…)`
- **column** “{attr}” · field `attr.replace(…)` · id `"col".concat(…)`
- **component** · id `cmpId` · renders into `renderTo` · store `localStore` · shows `name` · value `value` · placeholder `Choose...` · pick-only
- **column** “{attrSet.name}” · field `"CustomField".concat(…)`
- **component** · renders into `_self.names.cmbFamily` · store `_self.familyStore` · shows `Name` · value `ID`
- **component** · renders into `_self.names.cmbBaseOption` · store `_self.familyOptionStore` · shows `name` · value `name` · pick-only
- **component** · renders into `_self.names.cmbBaseOptionValue` · store `_self.familyBaseOptionValueStore` · shows `name` · value `name` · pick-only
- **FamilyMatrix_Option** · name `optionName`
- **FamilyMatrix_Value** · name `item`
- **tooltip** “{item.ValidationText}”
- **component** · renders into `tdPurchase_NewProduct_SaleTaxRule` · store `SaleTaxRuleStore` · shows `Description` · value `RuleID` · placeholder `Select a sale tax rule`
- **component** · renders into `tdProductFamily` · store `FamilyStore` · shows `Name` · value `ID`
- **component** · renders into `tdFamilyOption1` · store `FamilyOptions1Store` · shows `value` · value `value` · pick-only
- **component** · renders into `tdFamilyOption2` · store `FamilyOptions2Store` · shows `value` · value `value` · pick-only
- **component** · renders into `tdFamilyOption3` · store `FamilyOptions3Store` · shows `value` · value `value` · pick-only
- **button** “New payment” · on click `function(taskId){return function(){PurchaseAdvanced_NewPayme(…)`
- **button** “Undo” · on click `function(taskId){return function(){PurchaseAdvanced_Index_Un(…)`
- **button** “Void” · on click `function(task){return function(){PurchaseAdvanced_Index_Dele(…)`
- **button** “Void” · on click `function(taskId){return function(){PurchaseAdvanced_Index_Ca(…)`
- **button** “New refund” · on click `function(taskId){return function(){PurchaseAdvanced_NewPayme(…)`
- **button** “Save” · id `itmSaveWholePurchase1` · on click `handler()`
- **button** “Undo” · id `itmUndoWholePurchase1` · on click `PurchaseAdvanced_Index_Undo`
- **button** “Void” · id `itmVoidWholePurchase1` · on click `handler()`
- **button** “Clone” · id `itmCloneWholePurchase` · on click `handler()`
- **button** “Mark as received” · id `ExclusiveOrderStatusBlock2` · on click `PurchaseAdvanced_Index_MarkAsReceived`
- **button** “Mark as closed” · id `ExclusiveOrderStatusBlock3` · on click `PurchaseAdvanced_Index_MarkAsClosed`
- **component** · renders into `tdPurchase_Index_DefaultAccount` · store `vChartOfAccountsLinesStore` · shows `DisplayName` · value `Code` · placeholder `Choose...`
- **component** · renders into `tdScanQuantity` · required
- **text area** · renders into `divInventoryModeBarcodes` · placeholder `Enter your barcodes here...`

### `LatestProductPriceBySupplier2019`

1 grids · 0 standalone fields · 0 windows · 0 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `LatestProductPriceBySupplier_Index_Container` · store `mainStore` · placeholder `Nothing to show at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `SKU` |  | flex 2 | renderer() |  |
    | Category | `Category` |  | flex 1 | renderer() |  |
    | Product tags | `ProductTags` |  | flex 1 | renderer() | hidden |
    | Family | `Family` |  | flex 1 | renderer() | hidden |
    | Supplier | `SupplierID` |  | flex 2 | renderer() |  |
    | Supplier SKU | `SupplierSKU` |  | flex 1 | renderer() |  |
    | Supplier product name | `SupplierProductName` |  | flex 1 | renderer() |  |
    | URL | `URL` |  | flex 1 | renderer() |  |
    | Latest price | `LatestPrice` |  | flex 1 | renderer() |  |
    | Fixed price | `FixedPrice` |  | flex 1 | renderer() |  |
    | Drop ship | `DropShip` | check column | 80 | renderer() |  |


### `LeadSafetyValues2019`

1 grids · 0 standalone fields · 0 windows · 0 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `LeadSafetyValues_Index_Container` · store `mainStore` · placeholder `Nothing to show at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    |  | `` |  | flex 1 | renderer() | hidden |
    | Product | `ProductID` |  | flex 3 | renderer() |  |
    | Supplier | `SupplierID` |  | flex 2 | renderer() |  |
    | Location | `Location` |  | flex 2 | RenderHTMLText |  |
    | Lead | `Lead` |  | 90 | RenderHTMLText |  |
    | Safety | `Safety` |  | 90 | RenderHTMLText |  |
    | Reorder quantity | `ReorderQuantity` |  | 90 | RenderHTMLText |  |
    | Minimum to order | `MinimumToReorder` |  | 90 | RenderHTMLText |  |


### `Payment2019`

1 grids · 11 standalone fields · 0 windows · 8 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `divContainer` · store `window.store`

#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| combo |  | `tdSupplier` | `vSupplierStore` | shows `Name` · value `SupplierID` |
| combo |  | `tdPeriod` | `PeriodStore` | shows `Name` · value `Period` · pick-only |
| date field |  | `tdFrom` | `` | format `UserDateFormat` |
| date field |  | `tdTo` | `` | format `UserDateFormat` |
| numeric field |  | `tdAmount` | `` |  |
| date field |  | `tdPaymentDate` | `` | format `UserDateFormat` |
| text field |  | `tdCurrency` | `` | disabled |
| text field |  | `dtPaymentReference` | `` |  |
| combo |  | `tdPaymentAccountCode` | `vChartOfAccountsStore` | shows `DisplayName` · value `Code` · pick-only |
| numeric field |  | `tdConversionRateContainer` | `` |  |
| numeric field |  | `tdUnallocated` | `` | read-only |

#### Menus, buttons and other parts

- **column** “Invoice #” · field `InvoiceNumber` · id `InvoiceNumber`
- **date column** “Invoice date” · field `InvoiceDate` · id `InvoiceDate` · format `UserDateFormat`
- **column** “Order #” · field `PONumber` · id `PONumber`
- **column** “Invoice amount” · field `InvoiceAmount` · id `InvoiceAmount`
- **column** “Paid to date” · field `PaidAmount` · id `PaidAmount`
- **column** “Due amount” · field `DueAmount` · id `DueAmount`
- **column** “Overdue” · field `DaysOverdue` · id `DaysOverdue`
- **column** “Pay amount” · field `AllocatedAmount`

### `PurchaseCreditNote2019`

15 grids · 30 standalone fields · 0 windows · 13 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `divWorkflowHistoryLines` · store `store` · placeholder `Workflow history is not available now.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Date | `DateUtc` |  | flex 1 | renderer() |  |
    | Workflow name | `WorkflowName` |  | flex 1 |  |  |
    | Event | `EventName` |  | flex 1 |  |  |
    | Name | `Name` |  | flex 1 |  |  |
    | State | `State` |  | flex 1 |  |  |
    | Description | `Description` |  | flex 3 | renderer() |  |

- **grid** · renders into `divRealDimensions` · store `window.AccountingDimensionsRealTempStore` · placeholder `emptyMsgText`
- **grid** · renders into `_classPrivateFieldGet(…)` · store `_classPrivateFieldGet(…)`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    |  | `Selected` |  | 58 | renderer() |  |
    | Original account | `AccountCode` |  | flex 1 | renderer() |  |
    | Amount | `Amount` |  | flex 1 | renderer() |  |
    | Distributed amount | `DistributedAmount` |  | flex 1 | renderer() |  |
    | Left to distribute | `LeftToDistribute` |  | flex 1 | renderer() |  |
    | Note | `Invoices` |  | flex 2 | renderer() |  |

- **grid** · renders into `divHistoryLines` · store `_classPrivateFieldGet(…)` · placeholder `Activity log is not available now.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Date | `DateChanged` |  | flex 1 | renderer() |  |
    | Changes made | `ColumnsChanged` |  | flex 4 | renderer() |  |
    | User | `ChangedBy` |  | flex 2 |  |  |

- **grid** · renders into `_classPrivateFieldGet(_DOM_ID_MAP,this).DIV_GRID` · store `store` · placeholder `You have not imported any files.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | File name | `DocumentName` |  | flex 3 | renderer() |  |
    | Status | `Status` |  | flex 1 | renderer() |  |
    | Extracted date | `DateCreated` |  | flex 1 | renderer() |  |
    | Action | `FileID` |  | flex 1 | renderer() |  |

- **grid** · renders into `logsGridContainer` · store `store`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Date | `Date` | date column | 200 | renderer() |  |
    | Document name | `DocumentName` |  | flex 1 | RenderHTMLText |  |
    | Comment | `Comment` |  | flex 1 |  |  |
    | User | `UserName` |  | flex 1 |  |  |

- **grid** · renders into `divDistributedAccounts` · store `PurchaseExpenseStore`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    |  | `Selected` |  | 58 | renderer() |  |
    | Original account | `AccountCode` |  | flex 1 | renderer() |  |
    | Amount | `Amount` |  | flex 1 | renderer() |  |
    | Distributed amount | `DistributedAmount` |  | flex 1 | renderer() |  |
    | Left to distribute | `LeftToDistribute` |  | flex 1 | renderer() |  |
    | Note | `Invoices` |  | flex 2 | renderer() |  |

- **grid** · renders into `divRelatedOrdersDetails` · store `RelatedOrdersStore` · placeholder `No related orders created.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Order | `TaskNumber` |  | flex 1 | renderer() |  |
    | Type | `TaskTypeName` |  | flex 1 | RenderHTMLText |  |
    | Order date | `OrderDate` |  | flex 1 | renderer() |  |
    | Status | `Status` |  | flex 1 | renderer() |  |
    | Total | `TotalAmount` |  | 130 | renderer() |  |

- **grid** · renders into `divManualJournalsDistributedCosts` · placeholder `You do not have any manual journals.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `ProductID` |  | flex 1 | renderer() |  |
    | Invoice total | `InvoiceTotal` |  | 200 | renderer() | total sum |
    | Manual journal cost | `DistributedCost` |  | 200 | renderer() | total sum |

- **grid** · renders into `Purchase_NewAllocation_Deposits` · store `vPurchaseDepositStore` · placeholder `No credits/deposits found for the selected supplier.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Date | `Date` |  | flex 2 | renderer() |  |
    | Description | `Description` |  | flex 5 |  |  |
    | Remaining / total | `Amount` |  | flex 3 | renderer() |  |

- **grid** · renders into `Purchase_NewAllocation_Allocations` · store `dialogSelectedStore` · placeholder `No selected supplier deposits.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Date | `Date` |  | flex 2 | renderer() |  |
    | Description | `Description` |  | flex 4 |  |  |
    | Available to allocate | `RemainingAmount` |  | flex 2 | renderer() |  |
    | Allocated | `AllocatedAmount` |  | flex 2 | renderer() |  |

- **grid** · renders into `divAttachmentList` · store `AttachmentsStore` · placeholder `You do not have any files attached.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Name | `FileName` |  | flex 2 | renderer() |  |
    | Date | `Date` |  | flex 1 | renderer() |  |
    | Attached by | `UserName` |  | flex 2 |  |  |
    | Processed | `IsProcessed` | check column | 80 | Purchase_RenderAttachmentProcessed |  |

- **grid** · renders into `divCreditNoteAdditionalCostLines` · placeholder `You do not have any credit note lines.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `Description` |  | flex 3 | renderer() |  |
    | Reference | `Reference` |  | flex 2 | renderer() |  |
    | Quantity | `Quantity` |  | flex 1 |  |  |
    | Price | `Amount` |  | flex 1 | renderer() |  |
    | Discount | `Discount` | number column | flex 1 | renderer() |  |
    | Tax rule | `TaxRule` |  | flex 2 | renderer() |  |
    | Account | `AccountCode` |  | flex 2 | renderer() |  |
    | Total | `Total` |  | flex 1 | renderer() |  |

- **grid** · renders into `divCreditNotePayments` · placeholder `You do not have any refunds.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Account | `AccountCode` |  | flex 2 | renderer() |  |
    | Reference | `Reference` |  | flex 3 | renderer() |  |
    | Date paid | `DatePaid` | date column | flex 1 | edit: date field |  |
    | Amount | `Amount` |  | flex 1 | renderer() |  |
    | Conversion rate | `CurrencyConversionRate` |  | flex 1 | renderer() |  |
    | Base amount | `Amount` |  | flex 1 | renderer() |  |

- **grid** · renders into `divTDetails` · store `TransactionsStore` · placeholder `No transactions created.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Effective date | `EffectiveDate` |  | flex 1 | renderer() |  |
    | Debit | `Debit` |  | flex 1 | Common_COA_TreeMode_RestoreDisplayName |  |
    | Credit | `Credit` |  | flex 1 | Common_COA_TreeMode_RestoreDisplayName |  |
    | Amount | `Amount` |  | 130 | renderer() |  |


#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| combo |  | `inputId` | `AutocompleteAddressField.prototype.AddressInfoSto…` | shows `description` · value `place_id` · placeholder `Look up an address` |
| date field |  | `WorkflowModal_dtWorkflowDate` | `` | format `UserDateFormat` |
| combo |  | `"js-task-name_".concat(…)` | `store` | shows `DistributedAmountGrid_classPrivateField…` · value `DistributedAmountGrid_classPrivateField…` · placeholder `type… |
| numeric field |  | `"divTargetAccountDistribute_".concat(id).concat(…)` | `` |  |
| text field |  | `renderTo` | `` |  |
| checkbox |  | `renderTo` | `` |  |
| numeric field |  | `renderTo` | `` |  |
| date field |  | `renderTo` | `` | placeholder `Choose...` · format `UserDateFormat` |
| combo (+ add new) |  | `extDocExtCustomer` | `store` | shows `Name` · value `Name` · placeholder `type to search...` |
| combo |  | `"divTargetPurchase_".concat(…)` | `_store` | shows `InvoiceNumber` · value `TaskID` · placeholder `type to search` |
| numeric field |  | `"divTargetPurchaseAccountDistribute_".concat(inde…` | `` |  |
| combo |  | `"divTargetTask_".concat(…)` | `_store` | shows `TaskNumber` · value `TaskID` · placeholder `type to search` |
| numeric field |  | `"divTargetPurchaseAccountDistribute_other_".conca…` | `` |  |
| combo |  | `"divTargetProduction_".concat(…)` | `_store` | shows `ProductionOrderNumber` · value `ProductionRunID` · placeholder `type to search` |
| numeric field |  | `"divTargetProductionAccountDistribute_production_…` | `` |  |
| combo |  | `Purchase_NewDeposit_Account` | `AccountSupplierDepositStore` | shows `DisplayName` · value `Code` · placeholder `Choose...` |
| combo |  | `Purchase_NewDeposit_BankAccount` | `vBankAccountsStore` | shows `DisplayName` · value `Code` · placeholder `Select a bank account...` · pick-only |
| date field |  | `Purchase_NewDeposit_DatePaid` | `` | placeholder `Choose...` · format `UserDateFormat` |
| combo |  | `tdPurchase_NewSupplier_Currency` | `currencyStore` | shows `Code` · value `Code` |
| date field |  | `tdPurchase_CreditNote_Date` | `` | placeholder `Choose...` · format `UserDateFormat` |
| combo (+ add new) |  | `Purchase_Index_Supplier` | `vPurchase_SupplierStore` | shows `Name` · value `SupplierID` · placeholder `type to search...` |
| combo (+ add new) |  | `Purchase_Index_Contact` | `vPurchase_SupplierContactStore` | shows `Name` · value `Name` · placeholder `Choose...` |
| text field |  | `Purchase_Index_Phone` | `` | placeholder `write...` |
| combo (+ add new) |  | `Purchase_Index_VendorAddressLine1` | `vPurchase_SupplierAddressStore` | shows `Line1` · value `Line1` · placeholder `Address` |
| text field |  | `Purchase_Index_VendorAddressLine2` | `` | placeholder `City, state, country, zip` |
| combo (+ add new) |  | `Purchase_Index_Terms` | `vTenantPaymentTermStore` | shows `Name` · value `Name` · placeholder `Choose...` |
| date field |  | `Purchase_Index_ShipmentRequiredByDate` | `` | placeholder `Choose...` · format `UserDateFormat` |
| numeric field (with action) |  | `tdPurchase_Index_CurrencyConversionRate` | `` |  |
| combo |  | `Purchase_Index_Tax` | `vTenantTaxationRuleStore` | shows `Description` · value `RuleID` · placeholder `Choose...` |
| checkbox |  | `PurchaseCreditNote_Index_Tax_Inclusive` | `` |  |

#### Menus, buttons and other parts

- **column** “Entity” · field `EntityType` · id `colRealDimensionsEntity`
- **column** “Account” · field `AccountCode` · id `colRealDimensionsAccount`
- **column** “Amount” · field `Amount` · id `colRealDimensionsAmount`
- **column** “Reference number” · field `ReferenceNumber` · id `colRealDimensionsReferenceNumber`
- **column** “Effective date” · field `EffectiveDate` · id `colRealDimensionsDate`
- **column** “Product” · field `ProductCode` · id `colRealDimensionsProduct`
- **column** “Supplier \| Customer” · field `"".concat(…)` · id `"colRealDimensions".concat(…)`
- **column** “{attr}” · field `attr.replace(…)` · id `"col".concat(…)`
- **component** · id `cmpId` · renders into `renderTo` · store `localStore` · shows `name` · value `value` · placeholder `Choose...` · pick-only
- **column** “{attrSet.name}” · field `"CustomField".concat(…)`
- **tooltip** “{item.ValidationText}”
- **component** · renders into `tdPurchase_NewProduct_SaleTaxRule` · store `SaleTaxRuleStore` · shows `Description` · value `RuleID` · placeholder `Select a sale tax rule`
- **component** · renders into `tdPurchase_Index_DefaultAccount` · store `vChartOfAccountsLinesStore` · shows `DisplayName` · value `Code` · placeholder `Choose...`

### `PurchaseDropShip2019`

37 grids · 61 standalone fields · 0 windows · 25 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `divWorkflowHistoryLines` · store `store` · placeholder `Workflow history is not available now.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Date | `DateUtc` |  | flex 1 | renderer() |  |
    | Workflow name | `WorkflowName` |  | flex 1 |  |  |
    | Event | `EventName` |  | flex 1 |  |  |
    | Name | `Name` |  | flex 1 |  |  |
    | State | `State` |  | flex 1 |  |  |
    | Description | `Description` |  | flex 3 | renderer() |  |

- **grid** · renders into `divRealDimensions` · store `window.AccountingDimensionsRealTempStore` · placeholder `emptyMsgText`
- **grid** · renders into `divHistoryLines` · store `_classPrivateFieldGet(…)` · placeholder `Activity log is not available now.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Date | `DateChanged` |  | flex 1 | renderer() |  |
    | Changes made | `ColumnsChanged` |  | flex 4 | renderer() |  |
    | User | `ChangedBy` |  | flex 2 |  |  |

- **grid** · renders into `_classPrivateFieldGet(_DOM_ID_MAP,this).DIV_GRID` · store `store` · placeholder `You have not imported any files.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | File name | `DocumentName` |  | flex 3 | renderer() |  |
    | Status | `Status` |  | flex 1 | renderer() |  |
    | Extracted date | `DateCreated` |  | flex 1 | renderer() |  |
    | Action | `FileID` |  | flex 1 | renderer() |  |

- **grid** · renders into `logsGridContainer` · store `store`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Date | `Date` | date column | 200 | renderer() |  |
    | Document name | `DocumentName` |  | flex 1 | RenderHTMLText |  |
    | Comment | `Comment` |  | flex 1 |  |  |
    | User | `UserName` |  | flex 1 |  |  |

- **grid** · renders into `divDistributedAccounts` · store `PurchaseExpenseStore`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    |  | `Selected` |  | 58 | renderer() |  |
    | Original account | `AccountCode` |  | flex 1 | renderer() |  |
    | Amount | `Amount` |  | flex 1 | renderer() |  |
    | Distributed amount | `DistributedAmount` |  | flex 1 | renderer() |  |
    | Left to distribute | `LeftToDistribute` |  | flex 1 | renderer() |  |
    | Note | `Invoices` |  | flex 2 | renderer() |  |

- **grid** · renders into `divRelatedOrdersDetails` · store `RelatedOrdersStore` · placeholder `No related orders created.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Order | `TaskNumber` |  | flex 1 | renderer() |  |
    | Type | `TaskTypeName` |  | flex 1 | RenderHTMLText |  |
    | Order date | `OrderDate` |  | flex 1 | renderer() |  |
    | Status | `Status` |  | flex 1 | renderer() |  |
    | Total | `TotalAmount` |  | 130 | renderer() |  |

- **grid** · renders into `divManualJournalsDistributedCosts` · placeholder `You do not have any manual journals.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `ProductID` |  | flex 1 | renderer() |  |
    | Invoice total | `InvoiceTotal` |  | 200 | renderer() | total sum |
    | Manual journal cost | `DistributedCost` |  | 200 | renderer() | total sum |

- **grid** · renders into `Purchase_NewAllocation_Deposits` · store `vPurchaseDepositStore` · placeholder `No credits/deposits found for the selected supplier.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Date | `Date` |  | flex 2 | renderer() |  |
    | Description | `Description` |  | flex 5 |  |  |
    | Remaining / total | `Amount` |  | flex 3 | renderer() |  |

- **grid** · renders into `Purchase_NewAllocation_Allocations` · store `dialogSelectedStore` · placeholder `No selected supplier deposits.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Date | `Date` |  | flex 2 | renderer() |  |
    | Description | `Description` |  | flex 4 |  |  |
    | Available to allocate | `RemainingAmount` |  | flex 2 | renderer() |  |
    | Allocated | `AllocatedAmount` |  | flex 2 | renderer() |  |

- **grid** · renders into `divAttachmentList` · store `AttachmentsStore` · placeholder `You do not have any files attached.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Name | `FileName` |  | flex 2 | renderer() |  |
    | Date | `Date` |  | flex 1 | renderer() |  |
    | Attached by | `UserName` |  | flex 2 |  |  |
    | Processed | `IsProcessed` | check column | 80 | Purchase_RenderAttachmentProcessed |  |

- **grid** · renders into `divCreditNoteLines` · placeholder `You do not have any credit note lines.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `ProductCode` |  | flex 2 | renderer() |  |
    | Comment | `Comment` |  | flex 1 | renderer() | total count |
    | Supplier SKU | `SupplierInventoryCode` |  | flex 1 | renderer() |  |
    | Unit | `UnitOfMeasure` |  | flex 1 | renderer() |  |
    | Quantity | `Quantity` |  | flex 1 |  | total sum |
    | Price | `Price` |  | flex 1 | renderer() |  |
    | Discount | `Discount` | number column | flex 1 | renderer() |  |
    | Account | `AccountCode` |  | flex 2 | renderer() |  |
    | Total | `Total` |  | flex 1 | renderer() | total sum |

- **grid** · renders into `divCreditNoteAdditionalCostLines` · placeholder `You do not have any additional costs.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Description | `Description` |  | flex 2 | renderer() |  |
    | Reference | `Reference` |  | flex 2 | renderer() |  |
    | Quantity | `Quantity` |  | flex 1 |  |  |
    | Price | `Amount` |  | flex 1 | renderer() |  |
    | Discount | `Discount` | number column | flex 1 | renderer() |  |
    | Tax rule | `TaxRule` |  | flex 2 | renderer() |  |
    | Account | `AccountCode` |  | flex 2 | renderer() |  |
    | Total | `Total` |  | flex 1 | renderer() |  |

- **grid** · renders into `divCreditNotePayments` · placeholder `You do not have any refunds.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Account | `AccountCode` |  | flex 2 | renderer() |  |
    | Reference | `Reference` |  | flex 3 | renderer() |  |
    | Date paid | `DatePaid` | date column | flex 1 | edit: date field |  |
    | Amount | `Amount` |  | flex 1 | renderer() |  |
    | Conversion rate | `CurrencyConversionRate` |  | flex 1 | renderer() |  |
    | Base amount | `Amount` |  | flex 1 | renderer() |  |

- **grid** · renders into `divInvoiceLines` · placeholder `You do not have any invoice lines.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `ProductCode` |  | flex 2 | renderer() |  |
    | Comment | `Comment` |  | flex 1 | renderer() | total count |
    | Supplier SKU | `SupplierInventoryCode` |  | flex 1 | RenderHTMLText |  |
    | Unit | `UnitOfMeasure` |  | flex 1 | renderer() |  |
    | Quantity | `Quantity` |  | flex 1 |  | total sum |
    | Price | `Price` |  | flex 1 | renderer() |  |
    | Discount | `Discount` | number column | flex 1 | renderer() |  |
    | Tax rule | `TaxRule` |  | flex 1 | renderer() |  |
    | Account | `AccountCode` |  | flex 1 | renderer() |  |
    | Total | `Total` |  | flex 1 | renderer() | total sum |

- **grid** · renders into `divInvoiceAdditionalCostLines` · placeholder `You do not have any additional costs.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Description | `Description` |  | flex 3 | renderer() |  |
    | Reference | `Reference` |  | flex 2 | renderer() |  |
    | Quantity | `Quantity` |  | flex 1 |  |  |
    | Price | `Amount` |  | flex 1 | renderer() |  |
    | Discount | `Discount` | number column | flex 1 | renderer() |  |
    | Tax rule | `TaxRule` |  | flex 1 | renderer() |  |
    | Account | `AccountCode` |  | flex 1 | renderer() |  |
    | Total | `Total` |  | flex 1 | renderer() |  |

- **grid** · renders into `divInvoicePayments` · placeholder `You do not have any payments.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Account | `AccountCode` |  | flex 1 | renderer() |  |
    | Reference | `Reference` |  | flex 2 | renderer() |  |
    | Date paid | `DatePaid` | date column | flex 1 | edit: date field |  |
    | Amount | `Amount` |  | flex 1 | renderer() |  |
    | Conversion rate | `CurrencyConversionRate` |  | flex 1 | renderer() |  |
    | Base amount | `Amount` |  | flex 1 | renderer() |  |

- **grid** · renders into `UploadInvoiceLinesExceptionsGrid` · store `InvoiceLinesUploadErrorsStore` · placeholder `Please upload a file to check for issues.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Line # | `Line` |  | 50 |  |  |
    | Product SKU | `SKU` |  | 150 | renderer() |  |
    | Product name | `Name` |  | 250 | renderer() |  |
    | Quantity | `Quantity` |  | 100 | renderer() |  |
    | Price | `Price` |  | 100 | renderer() |  |
    | Discount | `Discount` |  | 100 | renderer() |  |
    | Comment | `Comment` |  | 150 | renderer() |  |

- **grid** · renders into `divVerifyInvoiceGrid` · store `VerifyInvoiceStore`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `ProductName` |  | flex 1 |  | total count |
    | Inner quantity | `CartonInnerQuantity` |  | flex 1 |  |  |
    | Estimated outer carton quantity | `CartonQuantity` |  | flex 1 |  |  |
    | Actual number of outer cartons | `NumberOfCartons` |  | flex 1 |  | total sum |
    | Volume of outer carton | `CartonVolume` |  | flex 1 | renderer() |  |
    | Line volume | `LineVolume` |  | flex 1 | renderer() | total sum |
    | Line freight cost | `LineFreightCost` |  | flex 1 | renderer() |  |
    | Unit freight cost | `UnitFreightCost` |  | flex 1 | renderer() |  |

- **grid** · renders into `divManualJournalsLines` · placeholder `You do not have any manual journals.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    |  | `DistributeType` |  | 100 | renderer() |  |
    | Debit | `Debit` |  | flex 1 | renderer() |  |
    | Credit | `Credit` |  | flex 1 | renderer() |  |
    | Reference | `Reference` |  | flex 1 | renderer() |  |
    | Date | `Date` | date column | flex 1 | edit: date field |  |
    | Amount | `Amount` |  | flex 1 | renderer() |  |
    | Type | `DistributeType` |  | flex 1 | renderer() |  |

- **grid** · renders into `divOrderLines` · placeholder `You do not have any purchase order lines.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `ProductCode` |  | flex 2 | renderer() |  |
    | Comment | `Comment` |  | flex 1 | renderer() | total count |
    | Supplier SKU | `SupplierInventoryCode` |  | flex 1 | renderer() |  |
    | Unit | `UnitOfMeasure` |  | flex 1 | renderer() |  |
    | Quantity | `Quantity` |  | flex 1 |  | total sum |
    | Price | `Price` |  | flex 1 | renderer() |  |
    | Discount | `Discount` | number column | flex 1 | renderer() |  |
    | Tax rule | `TaxRule` |  | flex 1 | renderer() |  |
    | Total | `Total` |  | flex 1 | renderer() | total sum |

- **grid** · renders into `divOrderAdditionalCostLines` · placeholder `You do not have any additional costs in your purchase order.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Description | `Description` |  | flex 3 | renderer() |  |
    | Reference | `Reference` |  | flex 2 | renderer() |  |
    | Quantity | `Quantity` |  | flex 1 |  |  |
    | Price | `Amount` |  | flex 1 | renderer() |  |
    | Discount | `Discount` | number column | flex 1 | renderer() |  |
    | Tax rule | `TaxRule` |  | flex 1 | renderer() |  |
    | Total | `Total` |  | flex 1 | renderer() |  |

- **grid** · renders into `divDeposits` · placeholder `You do not have any supplier deposits.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Account | `AccountCode` |  | flex 2 | renderer() |  |
    | Reference | `Reference` |  | flex 2 | renderer() |  |
    | Date paid | `DatePaid` | date column | flex 1 | edit: date field |  |
    | Amount | `Amount` |  | flex 1 | renderer() |  |
    | Conversion rate | `CurrencyConversionRate` |  | flex 1 | renderer() |  |
    | Base amount | `Amount` |  | flex 1 | renderer() |  |

- **grid** · renders into `UploadPOLinesExceptionsGrid` · store `POLinesUploadErrorsStore` · placeholder `Please upload a file to check for issues.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Line # | `Line` |  | 60 |  |  |
    | Product SKU | `SKU` |  | 150 | renderer() |  |
    | Product name | `Name` |  | 250 | renderer() |  |
    | Quantity | `Quantity` |  | 100 | renderer() |  |
    | Price | `Price` |  | 100 | renderer() |  |
    | Discount | `Discount` |  | 100 | renderer() |  |
    | Supplier SKU | `SupplierSKU` |  | 150 | renderer() |  |
    | Comment | `Comment` |  | 150 | renderer() |  |

- **grid** · renders into `divProductReplenishmentDetails` · store `ProductReplenishmentDetailsStore`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `ProductName` |  | flex 1 |  | total count |
    | Order quantity | `OrderQuantity` | number column | flex 1 |  | total sum |
    | Available | `Available` |  | flex 1 |  |  |
    | Backordered | `Backordered` |  | flex 1 |  |  |
    | MBR | `MinimumBeforeReorder` |  | flex 1 |  |  |
    | MOQ | `MOQ` |  | flex 1 |  |  |
    | On hand | `OnHand` |  | flex 1 |  |  |
    | On order | `OnOrder` |  | flex 1 |  |  |
    | Reorderquantity | `ReorderQuantity` |  | flex 1 |  |  |
    | Suggestedquantity | `SuggestedQuantity` |  | flex 1 |  |  |
    | Inner / outer carton quantity | `CartonInnerQuantity` |  | flex 1 | renderer() |  |
    | Number ofouter cartons | `NumberOfCartons` |  | flex 1 |  | total sum |
    | Linevolume | `LineVolumeSum` |  | flex 1 | renderer() | total sum |

- **grid** · renders into `divTDetails` · store `TransactionsStore` · placeholder `No transactions created.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Effective date | `EffectiveDate` |  | flex 1 | renderer() |  |
    | Debit | `Debit` |  | flex 1 | Common_COA_TreeMode_RestoreDisplayName |  |
    | Credit | `Credit` |  | flex 1 | Common_COA_TreeMode_RestoreDisplayName |  |
    | Amount | `Amount` |  | 130 | renderer() |  |

- **grid** · renders into `divScanProductSelection` · store `storeScanProduct`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `SKU` |  | flex 1 | renderer() |  |

- **grid** · renders into `divStockReceivedLines` · placeholder `You do not have any stock received lines.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `ProductCode` |  | flex 3 | renderer() |  |
    | Batch/serial # | `BatchSN` |  | flex 1 | renderer() | total count |
    | Expiry date | `ExpiryDate` | date column | flex 1 | renderer() · edit: date field |  |
    | Supplier SKU | `SupplierInventoryCode` |  | flex 1 | RenderHTMLText |  |
    | Unit | `UnitOfMeasure` |  | flex 1 | renderer() |  |
    | Quantity | `Quantity` |  | flex 1 |  | total sum |
    | Location | `Location` |  | flex 1 | renderer() |  |
    | Date received | `Date` | date column | flex 1 | edit: date field |  |
    | Received | `Received` | check column | 80 | renderer() |  |

- **grid** · renders into `UploadStockReceivedLinesExceptionsGrid` · store `StockReceivedLinesUploadErrorsStore` · placeholder `Please upload a file to check for issues.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Line # | `Line` |  | 60 |  |  |
    | Product SKU | `SKU` |  | 150 | renderer() |  |
    | Product name | `Name` |  | 250 | renderer() |  |
    | Batch/serial # | `BatchSerialNumber` |  | 120 | renderer() |  |
    | Supplier SKU | `SupplierSKU` |  | 250 | renderer() |  |
    | Expiry date | `ExpiryDate_YYYYMMDD` |  | 100 | renderer() |  |
    | Quantity | `Quantity` |  | 100 | renderer() |  |
    | Location | `Location` |  | 100 | renderer() |  |
    | Date received | `DateReceived_YYYYMMDD` |  | 100 | renderer() |  |
    | Received | `Received` |  | 100 | renderer() |  |

- **grid** · renders into `divUnstockLines` · placeholder `You do not have any items to unstock.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `ProductCode` |  | flex 3 | renderer() | total count |
    | Batch/serial no. | `BatchSN` |  | flex 1 | renderer() |  |
    | Expiry date | `ExpiryDate` |  | flex 1 | renderer() |  |
    | Supplier SKU | `SupplierInventoryCode` |  | flex 1 | renderer() |  |
    | Unit | `UnitOfMeasure` |  | flex 1 | renderer() |  |
    | Quantity | `Quantity` |  | flex 1 |  | total sum |
    | Location | `Location` |  | flex 1 | renderer() |  |
    | Date | `Date` | date column | flex 1 | edit: date field |  |

- **grid** · renders into `divCreditNoteAdditionalCostLines` · placeholder `You do not have any additional costs.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Description | `Description` |  | flex 5 | renderer() |  |
    | Quantity | `Quantity` |  | flex 1 |  |  |
    | Price | `Amount` |  | flex 1 | renderer() |  |
    | Discount | `Discount` | number column | flex 1 | renderer() |  |
    | Tax rule | `TaxRule` |  | flex 2 | renderer() |  |
    | Account | `AccountCode` |  | flex 2 | renderer() |  |
    | Total | `Total` |  | flex 1 | renderer() |  |

- **grid** · renders into `divInvoiceLines` · placeholder `You do not have any invoice lines.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `ProductCode` |  | flex 2 | renderer() | total count |
    | Comment | `Comment` |  | flex 1 | renderer() |  |
    | Supplier SKU | `SupplierInventoryCode` |  | flex 1 | RenderHTMLText |  |
    | Unit | `UnitOfMeasure` |  | flex 1 | renderer() |  |
    | Quantity | `Quantity` |  | flex 1 |  | total sum |
    | Price | `Price` |  | flex 1 | renderer() |  |
    | Discount | `Discount` | number column | flex 1 | renderer() |  |
    | Tax rule | `TaxRule` |  | flex 1 | renderer() |  |
    | Account | `AccountCode` |  | flex 1 | renderer() |  |
    | Total | `Total` |  | flex 1 | renderer() | total sum |

- **grid** · renders into `divInvoiceAdditionalCostLines` · placeholder `You do not have any additional costs.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Description | `Description` |  | flex 2 | renderer() |  |
    | Reference | `Reference` |  | flex 3 | renderer() |  |
    | Quantity | `Quantity` |  | flex 1 |  |  |
    | Price | `Amount` |  | flex 1 | renderer() |  |
    | Discount | `Discount` | number column | flex 1 | renderer() |  |
    | Tax rule | `TaxRule` |  | flex 1 | renderer() |  |
    | Account | `AccountCode` |  | flex 1 | renderer() |  |
    | Total | `Total` |  | flex 1 | renderer() |  |

- **grid** · renders into `divInvoicePayments` · placeholder `You do not have any payments.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Account | `AccountCode` |  | flex 1 | renderer() |  |
    | Reference | `Reference` |  | flex 2 | renderer() |  |
    | Date paid | `DatePaid` | date column | flex 1 | edit: date field |  |
    | Amount | `Amount` |  | flex 1 | renderer() |  |
    | Conversion rate | `CurrencyConversionRate` |  | flex 1 | renderer() |  |
    | Base amount | `Amount` |  | flex 1 | renderer() |  |

- **grid** · renders into `divManualJournalsLines` · placeholder `You do not have any manual journals.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Debit | `Debit` |  | flex 1 | renderer() |  |
    | Credit | `Credit` |  | flex 1 | renderer() |  |
    | Reference | `Reference` |  | flex 1 | renderer() |  |
    | Date | `Date` | date column | flex 1 | edit: date field |  |
    | Amount | `Amount` |  | flex 1 | renderer() |  |

- **grid** · renders into `divOrderLines` · placeholder `You do not have any purchase order lines.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `ProductCode` |  | flex 2 | renderer() | total count |
    | Comment | `Comment` |  | flex 1 | renderer() |  |
    | Supplier SKU | `SupplierInventoryCode` |  | flex 1 | renderer() |  |
    | Unit | `UnitOfMeasure` |  | flex 1 | renderer() |  |
    | Quantity | `Quantity` |  | flex 1 |  | total sum |
    | Price | `Price` |  | flex 1 | renderer() |  |
    | Discount | `Discount` | number column | flex 1 | renderer() |  |
    | Tax rule | `TaxRule` |  | flex 1 | renderer() |  |
    | Total | `Total` |  | flex 1 | renderer() | total sum |

- **grid** · renders into `divOrderAdditionalCostLines` · placeholder `You do not have any additional costs in your purchase order.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Description | `Description` |  | flex 2 | renderer() |  |
    | Reference | `Reference` |  | flex 3 | renderer() |  |
    | Quantity | `Quantity` |  | flex 1 |  |  |
    | Price | `Amount` |  | flex 1 | renderer() |  |
    | Discount | `Discount` | number column | flex 1 | renderer() |  |
    | Tax rule | `TaxRule` |  | flex 1 | renderer() |  |
    | Total | `Total` |  | flex 1 | renderer() |  |


#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| combo |  | `inputId` | `AutocompleteAddressField.prototype.AddressInfoSto…` | shows `description` · value `place_id` · placeholder `Look up an address` |
| date field |  | `WorkflowModal_dtWorkflowDate` | `` | format `UserDateFormat` |
| text field |  | `renderTo` | `` |  |
| combo |  | `renderTo` | `localStore` | shows `name` · value `value` · placeholder `Choose...` · pick-only |
| checkbox |  | `renderTo` | `` |  |
| numeric field |  | `renderTo` | `` |  |
| date field |  | `renderTo` | `` | placeholder `Choose...` · format `UserDateFormat` |
| text field |  | `renderTo` | `` |  |
| checkbox |  | `renderTo` | `` |  |
| numeric field |  | `renderTo` | `` |  |
| combo (+ add new) |  | `extDocExtCustomer` | `store` | shows `Name` · value `Name` · placeholder `type to search...` |
| combo |  | `"divTargetPurchase_".concat(…)` | `_store` | shows `InvoiceNumber` · value `TaskID` · placeholder `type to search` |
| numeric field |  | `"divTargetPurchaseAccountDistribute_".concat(inde…` | `` |  |
| combo |  | `"divTargetTask_".concat(…)` | `_store` | shows `TaskNumber` · value `TaskID` · placeholder `type to search` |
| numeric field |  | `"divTargetPurchaseAccountDistribute_other_".conca…` | `` |  |
| combo |  | `"divTargetProduction_".concat(…)` | `_store` | shows `ProductionOrderNumber` · value `ProductionRunID` · placeholder `type to search` |
| numeric field |  | `"divTargetProductionAccountDistribute_production_…` | `` |  |
| combo |  | `Purchase_NewDeposit_Account` | `AccountSupplierDepositStore` | shows `DisplayName` · value `Code` · placeholder `Choose...` |
| combo |  | `Purchase_NewDeposit_BankAccount` | `vBankAccountsStore` | shows `DisplayName` · value `Code` · placeholder `Select a bank account...` · pick-only |
| date field |  | `Purchase_NewDeposit_DatePaid` | `` | placeholder `Choose...` · format `UserDateFormat` |
| combo |  | `tdPurchase_NewSupplier_Currency` | `currencyStore` | shows `Code` · value `Code` |
| text field |  | `tdPurchase_CreditNote_Number` | `` | placeholder `write...` |
| date field |  | `tdPurchase_CreditNote_Date` | `` | placeholder `Choose...` · format `UserDateFormat` |
| text field |  | `tdPurchase_Invoice_Number` | `` | placeholder `write...` |
| date field |  | `tdPurchase_Invoice_Date` | `` | placeholder `Choose...` · format `UserDateFormat` |
| date field |  | `tdPurchase_Invoice_DueDate` | `` | placeholder `Choose...` · format `UserDateFormat` |
| numeric field |  | `tdPurchase_Invoice_Total` | `` |  |
| text field |  | `tdPurchase_Invoice_Total_No_Access` | `` | placeholder `No access` · hidden · disabled |
| numeric field |  | `tdPurchaseInvoiceDomesticFreightCostBaseCurrencyA…` | `` | placeholder `write...` |
| numeric field |  | `tdPurchaseInvoiceDomesticFreightCostOtherCurrency…` | `` | placeholder `write...` |
| numeric field |  | `tdPurchaseInvoiceOceanFreightCostBaseCurrencyAmou…` | `` | placeholder `write...` |
| numeric field |  | `tdPurchaseInvoiceOceanFreightCostOtherCurrencyAmo…` | `` | placeholder `write...` |
| combo |  | `tdPurchaseInvoiceDomesticFreightCostCurrency` | `vCurrenciesWithConversionRates` | shows `ResultCurrencyCode` · value `ResultCurrencyCode` · placeholder `Choose...` |
| combo |  | `tdPurchaseInvoiceOceanFreightCostCurrency` | `vCurrenciesWithConversionRates2` | shows `ResultCurrencyCode` · value `ResultCurrencyCode` · placeholder `Choose...` |
| numeric field |  | `tdPurchaseInvoiceTotalFreightCostAmount` | `` | placeholder `0` |
| combo (+ add new) |  | `Purchase_Index_Supplier` | `vPurchase_SupplierStore` | shows `Name` · value `SupplierID` · placeholder `type to search...` |
| combo (+ add new) |  | `Purchase_Index_Contact` | `vPurchase_SupplierContactStore` | shows `Name` · value `Name` · placeholder `Choose...` |
| text field |  | `Purchase_Index_Phone` | `` | placeholder `write...` |
| combo (+ add new) |  | `Purchase_Index_VendorAddressLine1` | `vPurchase_SupplierAddressStore` | shows `Line1` · value `Line1` · placeholder `Address` |
| text field |  | `Purchase_Index_VendorAddressLine2` | `` | placeholder `City, state, country, zip` |
| combo (+ add new) |  | `Purchase_Index_Terms` | `vTenantPaymentTermStore` | shows `Name` · value `Name` · placeholder `Choose...` |
| date field |  | `Purchase_Index_ShipmentRequiredByDate` | `` | placeholder `Choose...` · format `UserDateFormat` |
| numeric field (with action) |  | `tdPurchase_Index_CurrencyConversionRate` | `` |  |
| combo |  | `Purchase_Index_Tax` | `vTenantTaxationRuleStore` | shows `Description` · value `RuleID` · placeholder `Choose...` |
| combo |  | `tdPurchase_Index_Milestone` | `vPurchase_JobMilestonesStore` | shows `Name` · value `ID` · placeholder `type to search...` |
| checkbox |  | `Purchase_Index_Tax_Inclusive` | `` |  |
| checkbox |  | `Purchase_Index_BlindReceipt` | `` |  |
| date field |  | `Purchase_Index_Date` | `` | placeholder `Choose...` · format `UserDateFormat` |
| combo (+ add new) |  | `Purchase_Index_Location` | `vTenantLocationLoadStore` | shows `Description` · value `Description` · placeholder `Choose...` |
| combo (+ add new) |  | `Purchase_Index_SippingAddressLine1` | `vPurchase_TenantAddressStore` | shows `Line1` · value `Line1` · placeholder `Address` |
| text field |  | `Purchase_Index_SippingAddressLine2` | `` | placeholder `City, state, country, zip` |
| checkbox |  | `HeaderShipToOther` | `` |  |
| text field |  | `tdScanBatchSN` | `` | placeholder `write...` |
| combo |  | `tdScanBin` | `vTenantLocationLoadStore` | shows `Description` · value `LocationID` · placeholder `choose...` |
| date field |  | `tdScanExpiryDate` | `` | placeholder `Choose...` · format `UserDateFormat` |
| combo (+ add new) |  | `Purchase_Index_VendorAddressLine1` | `vPurchase_SupplierAddressStore` | shows `Line1` · value `Line1` · placeholder `Choose...` |
| text field |  | `Purchase_Index_VendorAddressLine2` | `` | placeholder `Choose...` |
| checkbox |  | `DropShipPurchase_Index_Tax_Inclusive` | `` |  |
| text field |  | `Purchase_Index_Location` | `` |  |
| text field |  | `Purchase_Index_SippingAddressLine1` | `` | placeholder `fill in...` |
| text field |  | `Purchase_Index_SippingAddressLine2` | `` | placeholder `Choose...` |

#### Menus, buttons and other parts

- **column** “Entity” · field `EntityType` · id `colRealDimensionsEntity`
- **column** “Account” · field `AccountCode` · id `colRealDimensionsAccount`
- **column** “Amount” · field `Amount` · id `colRealDimensionsAmount`
- **column** “Reference number” · field `ReferenceNumber` · id `colRealDimensionsReferenceNumber`
- **column** “Effective date” · field `EffectiveDate` · id `colRealDimensionsDate`
- **column** “Product” · field `ProductCode` · id `colRealDimensionsProduct`
- **column** “Supplier \| Customer” · field `"".concat(…)` · id `"colRealDimensions".concat(…)`
- **column** “{attr}” · field `attr.replace(…)` · id `"col".concat(…)`
- **component** · id `cmpId` · renders into `renderTo` · store `localStore` · shows `name` · value `value` · placeholder `Choose...` · pick-only
- **column** “{attrSet.name}” · field `"CustomField".concat(…)`
- **component** · renders into `_self.names.cmbFamily` · store `_self.familyStore` · shows `Name` · value `ID`
- **component** · renders into `_self.names.cmbBaseOption` · store `_self.familyOptionStore` · shows `name` · value `name` · pick-only
- **component** · renders into `_self.names.cmbBaseOptionValue` · store `_self.familyBaseOptionValueStore` · shows `name` · value `name` · pick-only
- **FamilyMatrix_Option** · name `optionName`
- **FamilyMatrix_Value** · name `item`
- **tooltip** “{item.ValidationText}”
- **component** · renders into `tdPurchase_NewProduct_SaleTaxRule` · store `SaleTaxRuleStore` · shows `Description` · value `RuleID` · placeholder `Select a sale tax rule`
- **component** · renders into `tdProductFamily` · store `FamilyStore` · shows `Name` · value `ID`
- **component** · renders into `tdFamilyOption1` · store `FamilyOptions1Store` · shows `value` · value `value` · pick-only
- **component** · renders into `tdFamilyOption2` · store `FamilyOptions2Store` · shows `value` · value `value` · pick-only
- **component** · renders into `tdFamilyOption3` · store `FamilyOptions3Store` · shows `value` · value `value` · pick-only
- **component** · renders into `tdPurchase_Index_DefaultAccount` · store `vChartOfAccountsLinesStore` · shows `DisplayName` · value `Code` · placeholder `Choose...`
- **component** · renders into `tdScanQuantity` · required
- **text area** · renders into `divInventoryModeBarcodes` · placeholder `Enter your barcodes here...`
- **component** · renders into `tdPurchase_Index_DefaultAccount` · store `vExpenseAccountsStore` · shows `DisplayName` · value `Code` · placeholder `Choose...`

### `PurchaseList2019`

5 grids · 0 standalone fields · 0 windows · 0 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `PurchaseList_Index_GeneralContainer` · store `mainStore`
- **grid** · renders into `PurchaseList_Index_AccountingContainer` · store `accountingStore`
- **grid** · renders into `BulkActions_List` · store `bulkStore`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Status | `OrderNo` |  | 130 | renderer() |  |
    | Order # | `OrderNo` |  | flex 1 | renderer() |  |
    | Status | `Status` |  | flex 1 | renderer() |  |
    | Order date | `OrderDate` |  | flex 1 | renderer() |  |
    | Supplier | `Supplier` |  | flex 1 | renderer() |  |
    | Document # | `Reference` |  | flex 1 | renderer() |  |
    | Required by | `ShipmentRequiredByDate` |  | flex 1 | renderer() |  |

- **grid** · renders into `BulkActionsAccounting_List` · store `bulkStoreAccounting`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Document | `DocNo` |  | 90 | renderer() |  |
    | Status | `Status` |  | 120 | renderer() |  |
    | From | `Supplier` |  | flex 1 | renderer() |  |
    | Total | `Total` |  | flex 1 | renderer() |  |
    | Paid | `Paid` |  | flex 1 | renderer() |  |
    | Due | `Due` |  | flex 1 | renderer() |  |

- **grid** · renders into `divRelatedOrdersDetails` · store `RelatedOrdersStore` · placeholder `No related orders created.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Order | `TaskNumber` |  | flex 1 | renderer() |  |
    | Type | `TaskTypeName` |  | flex 1 | RenderHTMLText |  |
    | Order date | `OrderDate` |  | flex 1 | renderer() |  |
    | Status | `Status` |  | flex 1 | renderer() |  |
    | Total | `TotalAmount` |  | 130 | renderer() |  |


### `PurchaseService2019`

20 grids · 45 standalone fields · 0 windows · 13 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `divWorkflowHistoryLines` · store `store` · placeholder `Workflow history is not available now.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Date | `DateUtc` |  | flex 1 | renderer() |  |
    | Workflow name | `WorkflowName` |  | flex 1 |  |  |
    | Event | `EventName` |  | flex 1 |  |  |
    | Name | `Name` |  | flex 1 |  |  |
    | State | `State` |  | flex 1 |  |  |
    | Description | `Description` |  | flex 3 | renderer() |  |

- **grid** · renders into `divRealDimensions` · store `window.AccountingDimensionsRealTempStore` · placeholder `emptyMsgText`
- **grid** · renders into `_classPrivateFieldGet(…)` · store `_classPrivateFieldGet(…)`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    |  | `Selected` |  | 58 | renderer() |  |
    | Original account | `AccountCode` |  | flex 1 | renderer() |  |
    | Amount | `Amount` |  | flex 1 | renderer() |  |
    | Distributed amount | `DistributedAmount` |  | flex 1 | renderer() |  |
    | Left to distribute | `LeftToDistribute` |  | flex 1 | renderer() |  |
    | Note | `Invoices` |  | flex 2 | renderer() |  |

- **grid** · renders into `divHistoryLines` · store `_classPrivateFieldGet(…)` · placeholder `Activity log is not available now.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Date | `DateChanged` |  | flex 1 | renderer() |  |
    | Changes made | `ColumnsChanged` |  | flex 4 | renderer() |  |
    | User | `ChangedBy` |  | flex 2 |  |  |

- **grid** · renders into `_classPrivateFieldGet(_DOM_ID_MAP,this).DIV_GRID` · store `store` · placeholder `You have not imported any files.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | File name | `DocumentName` |  | flex 3 | renderer() |  |
    | Status | `Status` |  | flex 1 | renderer() |  |
    | Extracted date | `DateCreated` |  | flex 1 | renderer() |  |
    | Action | `FileID` |  | flex 1 | renderer() |  |

- **grid** · renders into `logsGridContainer` · store `store`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Date | `Date` | date column | 200 | renderer() |  |
    | Document name | `DocumentName` |  | flex 1 | RenderHTMLText |  |
    | Comment | `Comment` |  | flex 1 |  |  |
    | User | `UserName` |  | flex 1 |  |  |

- **grid** · renders into `divDistributedAccounts` · store `PurchaseExpenseStore`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    |  | `Selected` |  | 58 | renderer() |  |
    | Original account | `AccountCode` |  | flex 1 | renderer() |  |
    | Amount | `Amount` |  | flex 1 | renderer() |  |
    | Distributed amount | `DistributedAmount` |  | flex 1 | renderer() |  |
    | Left to distribute | `LeftToDistribute` |  | flex 1 | renderer() |  |
    | Note | `Invoices` |  | flex 2 | renderer() |  |

- **grid** · renders into `divRelatedOrdersDetails` · store `RelatedOrdersStore` · placeholder `No related orders created.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Order | `TaskNumber` |  | flex 1 | renderer() |  |
    | Type | `TaskTypeName` |  | flex 1 | RenderHTMLText |  |
    | Order date | `OrderDate` |  | flex 1 | renderer() |  |
    | Status | `Status` |  | flex 1 | renderer() |  |
    | Total | `TotalAmount` |  | 130 | renderer() |  |

- **grid** · renders into `divManualJournalsDistributedCosts` · placeholder `You do not have any manual journals.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `ProductID` |  | flex 1 | renderer() |  |
    | Invoice total | `InvoiceTotal` |  | 200 | renderer() | total sum |
    | Manual journal cost | `DistributedCost` |  | 200 | renderer() | total sum |

- **grid** · renders into `Purchase_NewAllocation_Deposits` · store `vPurchaseDepositStore` · placeholder `No credits/deposits found for the selected supplier.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Date | `Date` |  | flex 2 | renderer() |  |
    | Description | `Description` |  | flex 5 |  |  |
    | Remaining / total | `Amount` |  | flex 3 | renderer() |  |

- **grid** · renders into `Purchase_NewAllocation_Allocations` · store `dialogSelectedStore` · placeholder `No selected supplier deposits.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Date | `Date` |  | flex 2 | renderer() |  |
    | Description | `Description` |  | flex 4 |  |  |
    | Available to allocate | `RemainingAmount` |  | flex 2 | renderer() |  |
    | Allocated | `AllocatedAmount` |  | flex 2 | renderer() |  |

- **grid** · renders into `divAttachmentList` · store `AttachmentsStore` · placeholder `You do not have any files attached.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Name | `FileName` |  | flex 2 | renderer() |  |
    | Date | `Date` |  | flex 1 | renderer() |  |
    | Attached by | `UserName` |  | flex 2 |  |  |

- **grid** · renders into `divCreditNoteAdditionalCostLines` · placeholder `You do not have any lines.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `Description` |  | flex 2 | renderer() |  |
    | Reference | `Reference` |  | flex 2 | renderer() |  |
    | Quantity | `Quantity` |  | flex 1 |  |  |
    | Price | `Amount` |  | flex 1 | renderer() |  |
    | Discount | `Discount` | number column | flex 1 | renderer() |  |
    | Tax rule | `TaxRule` |  | flex 2 | renderer() |  |
    | Account | `AccountCode` |  | flex 2 | renderer() |  |
    | Total | `Total` |  | flex 1 | renderer() |  |

- **grid** · renders into `divCreditNotePayments` · placeholder `You do not have any refunds.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Account | `AccountCode` |  | flex 2 | renderer() |  |
    | Reference | `Reference` |  | flex 3 | renderer() |  |
    | Date paid | `DatePaid` | date column | flex 1 | edit: date field |  |
    | Amount | `Amount` |  | flex 1 | renderer() |  |
    | Conversion rate | `CurrencyConversionRate` |  | flex 1 | renderer() |  |
    | Base amount | `Amount` |  | flex 1 | renderer() |  |

- **grid** · renders into `divInvoiceAdditionalCostLines` · placeholder `You do not have any additional costs.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `Description` |  | flex 3 | renderer() |  |
    | Reference | `Reference` |  | flex 2 | renderer() |  |
    | Quantity | `Quantity` |  | flex 1 |  |  |
    | Price | `Amount` |  | flex 1 | renderer() |  |
    | Discount | `Discount` | number column | flex 1 | renderer() |  |
    | Tax rule | `TaxRule` |  | flex 1 | renderer() |  |
    | Account | `AccountCode` |  | flex 1 | renderer() |  |
    | Total | `Total` |  | flex 1 | renderer() |  |

- **grid** · renders into `divInvoicePayments` · placeholder `You do not have any payments.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Account | `AccountCode` |  | flex 1 | renderer() |  |
    | Reference | `Reference` |  | flex 2 | renderer() |  |
    | Date paid | `DatePaid` | date column | flex 1 | edit: date field |  |
    | Amount | `Amount` |  | flex 1 | renderer() |  |
    | Conversion rate | `CurrencyConversionRate` |  | flex 1 | renderer() |  |
    | Base amount | `Amount` |  | flex 1 | renderer() |  |

- **grid** · renders into `divManualJournalsLines` · placeholder `You do not have any manual journals.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Debit | `Debit` |  | flex 1 | renderer() |  |
    | Credit | `Credit` |  | flex 1 | renderer() |  |
    | Reference | `Reference` |  | flex 1 | renderer() |  |
    | Date | `Date` | date column | flex 1 | edit: date field |  |
    | Amount | `Amount` |  | flex 1 | renderer() |  |

- **grid** · renders into `divOrderAdditionalCostLines` · placeholder `You do not have any lines in your purchase order.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `Description` |  | flex 3 | renderer() |  |
    | Reference | `Reference` |  | flex 2 | renderer() |  |
    | Quantity | `Quantity` |  | flex 1 |  |  |
    | Price | `Amount` |  | flex 1 | renderer() |  |
    | Discount | `Discount` | number column | flex 1 | renderer() |  |
    | Tax rule | `TaxRule` |  | flex 1 | renderer() |  |
    | Total | `Total` |  | flex 1 | renderer() |  |

- **grid** · renders into `divDeposits` · placeholder `You do not have any supplier deposits.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Account | `AccountCode` |  | flex 2 | renderer() |  |
    | Reference | `Reference` |  | flex 2 | renderer() |  |
    | Date paid | `DatePaid` | date column | flex 1 | edit: date field |  |
    | Amount | `Amount` |  | flex 1 | renderer() |  |
    | Conversion rate | `CurrencyConversionRate` |  | flex 1 | renderer() |  |
    | Base amount | `Amount` |  | flex 1 | renderer() |  |

- **grid** · renders into `divTDetails` · store `TransactionsStore` · placeholder `No transactions created.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Effective date | `EffectiveDate` |  | flex 1 | renderer() |  |
    | Debit | `Debit` |  | flex 1 | Common_COA_TreeMode_RestoreDisplayName |  |
    | Credit | `Credit` |  | flex 1 | Common_COA_TreeMode_RestoreDisplayName |  |
    | Amount | `Amount` |  | 130 | renderer() |  |


#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| combo |  | `inputId` | `AutocompleteAddressField.prototype.AddressInfoSto…` | shows `description` · value `place_id` · placeholder `Look up an address` |
| date field |  | `WorkflowModal_dtWorkflowDate` | `` | format `UserDateFormat` |
| text field |  | `renderTo` | `` |  |
| combo |  | `renderTo` | `localStore` | shows `name` · value `value` · placeholder `Choose...` · pick-only |
| checkbox |  | `renderTo` | `` |  |
| numeric field |  | `renderTo` | `` |  |
| date field |  | `renderTo` | `` | placeholder `Choose...` · format `UserDateFormat` |
| text field |  | `renderTo` | `` |  |
| checkbox |  | `renderTo` | `` |  |
| numeric field |  | `renderTo` | `` |  |
| combo |  | `"js-task-name_".concat(…)` | `store` | shows `DistributedAmountGrid_classPrivateField…` · value `DistributedAmountGrid_classPrivateField…` · placeholder `type… |
| numeric field |  | `"divTargetAccountDistribute_".concat(id).concat(…)` | `` |  |
| combo (+ add new) |  | `extDocExtCustomer` | `store` | shows `Name` · value `Name` · placeholder `type to search...` |
| combo |  | `"divTargetPurchase_".concat(…)` | `_store` | shows `InvoiceNumber` · value `TaskID` · placeholder `type to search` |
| numeric field |  | `"divTargetPurchaseAccountDistribute_".concat(inde…` | `` |  |
| combo |  | `"divTargetTask_".concat(…)` | `_store` | shows `TaskNumber` · value `TaskID` · placeholder `type to search` |
| numeric field |  | `"divTargetPurchaseAccountDistribute_other_".conca…` | `` |  |
| combo |  | `"divTargetProduction_".concat(…)` | `_store` | shows `ProductionOrderNumber` · value `ProductionRunID` · placeholder `type to search` |
| numeric field |  | `"divTargetProductionAccountDistribute_production_…` | `` |  |
| combo |  | `Purchase_NewDeposit_Account` | `AccountSupplierDepositStore` | shows `DisplayName` · value `Code` · placeholder `Choose...` |
| combo |  | `Purchase_NewDeposit_BankAccount` | `vBankAccountsStore` | shows `DisplayName` · value `Code` · placeholder `Select a bank account...` · pick-only |
| date field |  | `Purchase_NewDeposit_DatePaid` | `` | placeholder `Choose...` · format `UserDateFormat` |
| combo |  | `tdPurchase_NewSupplier_Currency` | `currencyStore` | shows `Code` · value `Code` |
| text field |  | `tdPurchase_CreditNote_Number` | `` | placeholder `write...` |
| date field |  | `tdPurchase_CreditNote_Date` | `` | placeholder `Choose...` · format `UserDateFormat` |
| text field |  | `tdPurchase_Invoice_Number` | `` | placeholder `write...` |
| date field |  | `tdPurchase_Invoice_Date` | `` | placeholder `Choose...` · format `UserDateFormat` |
| date field |  | `tdPurchase_Invoice_DueDate` | `` | placeholder `Choose...` · format `UserDateFormat` |
| numeric field |  | `tdPurchase_Invoice_Total` | `` |  |
| combo (+ add new) |  | `Purchase_Index_Supplier` | `vPurchase_SupplierStore` | shows `Name` · value `SupplierID` · placeholder `type to search...` |
| combo (+ add new) |  | `Purchase_Index_Contact` | `vPurchase_SupplierContactStore` | shows `Name` · value `Name` · placeholder `Choose...` |
| text field |  | `Purchase_Index_Phone` | `` | placeholder `write...` |
| combo (+ add new) |  | `Purchase_Index_VendorAddressLine1` | `vPurchase_SupplierAddressStore` | shows `Line1` · value `Line1` · placeholder `Address` |
| text field |  | `Purchase_Index_VendorAddressLine2` | `` | placeholder `City, state, country, zip` |
| combo (+ add new) |  | `Purchase_Index_Terms` | `vTenantPaymentTermStore` | shows `Name` · value `Name` · placeholder `Choose...` |
| date field |  | `Purchase_Index_ShipmentRequiredByDate` | `` | placeholder `Choose...` · format `UserDateFormat` |
| numeric field (with action) |  | `tdPurchase_Index_CurrencyConversionRate` | `` |  |
| combo |  | `Purchase_Index_Tax` | `vTenantTaxationRuleStore` | shows `Description` · value `RuleID` · placeholder `Choose...` |
| checkbox |  | `PurchaseService_Index_Tax_Inclusive` | `` |  |
| checkbox |  | `Purchase_Index_BlindReceipt` | `` |  |
| date field |  | `Purchase_Index_Date` | `` | placeholder `Choose...` · format `UserDateFormat` |
| combo (+ add new) |  | `Purchase_Index_Location` | `vTenantLocationLoadStore` | shows `Description` · value `Description` · placeholder `Choose...` |
| combo (+ add new) |  | `Purchase_Index_SippingAddressLine1` | `vPurchase_TenantAddressStore` | shows `Line1` · value `Line1` · placeholder `Choose...` |
| text field |  | `Purchase_Index_SippingAddressLine2` | `` | placeholder `Choose...` |
| checkbox |  | `Purchase_Index_HeaderShipToOther` | `` |  |

#### Menus, buttons and other parts

- **column** “Entity” · field `EntityType` · id `colRealDimensionsEntity`
- **column** “Account” · field `AccountCode` · id `colRealDimensionsAccount`
- **column** “Amount” · field `Amount` · id `colRealDimensionsAmount`
- **column** “Reference number” · field `ReferenceNumber` · id `colRealDimensionsReferenceNumber`
- **column** “Effective date” · field `EffectiveDate` · id `colRealDimensionsDate`
- **column** “Product” · field `ProductCode` · id `colRealDimensionsProduct`
- **column** “Supplier \| Customer” · field `"".concat(…)` · id `"colRealDimensions".concat(…)`
- **column** “{attr}” · field `attr.replace(…)` · id `"col".concat(…)`
- **component** · id `cmpId` · renders into `renderTo` · store `localStore` · shows `name` · value `value` · placeholder `Choose...` · pick-only
- **column** “{attrSet.name}” · field `"CustomField".concat(…)`
- **tooltip** “{item.ValidationText}”
- **component** · renders into `tdPurchase_NewProduct_SaleTaxRule` · store `SaleTaxRuleStore` · shows `Description` · value `RuleID` · placeholder `Select a sale tax rule`
- **component** · renders into `tdPurchase_Index_DefaultAccount` · store `vChartOfAccountsLinesStore` · shows `DisplayName` · value `Code` · placeholder `Choose...`

### `ReorderBackorderedStock2019`

2 grids · 3 standalone fields · 0 windows · 0 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `divSuppliersContainer` · store `supplierStore` · placeholder `You do not have any products ready for reorder.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    |  | `SupplierID` |  | flex 1 | renderer() |  |

- **grid** · renders into `divProductsContainer` · store `productStore` · placeholder `You do not have any products ready for reorder.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Supplier SKU | `SupplierProductCode` |  | flex 1 | renderer() |  |
    | Product | `ProductCode` |  | flex 2 | renderer() |  |
    | On hand | `OnHand` |  | flex 1 |  |  |
    | Available | `Available` |  | flex 1 |  |  |
    | On order | `OnOrder` |  | flex 1 |  |  |
    | Backordered | `Backordered` |  | flex 1 |  |  |
    | Suggested reorder quantity | `ReorderQuantity` |  | flex 1 |  |  |
    | Price | `Price` |  | flex 1 | renderer() |  |


#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| combo |  | `tdCustomer` | `CustomerStore` | shows `Name` · value `CustomerID` |
| combo |  | `tdLocation` | `LocationStore` | shows `Name` · value `LocationID` |
| combo |  | `tdTag` | `TagStore` | shows `Value` · value `Value` · pick-only |

### `ReorderLevelOfStock2019`

2 grids · 1 standalone fields · 0 windows · 0 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `divSuppliersContainer` · store `supplierStore`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    |  | `SupplierID` |  | flex 1 | renderer() |  |

- **grid** · renders into `divProductsContainer` · store `productStore` · placeholder `You do not have any products ready for reorder.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Supplier SKU | `SupplierProductCode` |  | flex 1 | renderer() |  |
    | Product | `ProductCode` |  | flex 2 | renderer() |  |
    | Available | `OnHand` |  | flex 1 |  |  |
    | On order | `OnOrder` |  | flex 1 |  |  |
    | Minimum before reorder | `MinimumBeforeReorder` |  | flex 1 |  |  |
    | Reorder quantity | `ReorderQuantity` |  | flex 1 |  |  |
    | Price | `Price` |  | flex 1 | renderer() |  |


#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| combo |  | `tdLocation` | `TenantLocationStore` | shows `Description` · value `LocationID` · pick-only |

### `ReorderSuggestion2019`

2 grids · 5 standalone fields · 0 windows · 0 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `divProductsContainer` · store `productStore` · placeholder `You do not have any products ready for reorder.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Location | `LocationName` |  | flex 1 | renderer() |  |
    | Supplier | `SupplierName` |  | flex 1 | renderer() |  |
    | Supplier SKU | `SupplierSKU` |  | flex 1 | renderer() |  |
    | Product | `ProductCode` |  | flex 2 | renderer() |  |
    | Reorder date | `ReorderDate` |  | flex 1 | renderer() |  |
    | Units of measure | `Unit` |  | flex 1 | renderer() |  |
    | Available at | `AvailableAtWarehouse` |  | flex 1 |  |  |
    | Available | `Available` |  | flex 1 |  |  |
    | On order | `OnOrder` |  | flex 1 |  |  |
    | Minimum order quantity | `MinimumToReorder` |  | flex 1 |  |  |
    | Reorder quantity | `ReorderQty` |  | flex 1 | renderer() |  |
    | Price | `Price` |  | flex 1 | renderer() |  |

- **grid** · renders into `divOrderedContainer` · store `productTaskStore` · placeholder `You do not have any ordered products.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `ProductCode` |  | flex 1 | renderer() |  |
    | Task | `Number` |  | flex 1 | renderer() |  |
    | From | `From` |  | flex 2 | renderer() |  |
    | To | `To` |  | flex 1 | renderer() |  |
    | Ordered | `OrderedQty` |  | flex 1 |  |  |


#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| combo |  | `cmbLocation` | `vEmailLocationsStore` | shows `Description` · value `LocationID` · pick-only |
| combo |  | `cmbReorderFrom` | `ReorderTypes` | shows `name` · value `value` · pick-only |
| combo |  | `cmbSupplier` | `SuppliersStore` | shows `Name` · value `SupplierID` · pick-only |
| combo |  | `cmbWarehouse` | `WarehousesDisplayStore` | shows `Description` · value `LocationID` · pick-only |
| combo |  | `cmbReorderAction` | `AvailableActionsStore` | shows `Name` · value `ID` · pick-only |

### `SimplePurchase2019`

31 grids · 57 standalone fields · 0 windows · 20 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `divWorkflowHistoryLines` · store `store` · placeholder `Workflow history is not available now.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Date | `DateUtc` |  | flex 1 | renderer() |  |
    | Workflow name | `WorkflowName` |  | flex 1 |  |  |
    | Event | `EventName` |  | flex 1 |  |  |
    | Name | `Name` |  | flex 1 |  |  |
    | State | `State` |  | flex 1 |  |  |
    | Description | `Description` |  | flex 3 | renderer() |  |

- **grid** · renders into `divRealDimensions` · store `window.AccountingDimensionsRealTempStore` · placeholder `emptyMsgText`
- **grid** · renders into `divAttachmentList` · store `AttachmentsStore` · placeholder `You do not have any files attached.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Name | `FileName` |  | flex 2 | renderer() |  |
    | Date | `Date` |  | flex 1 | renderer() |  |
    | Attached by | `UserName` |  | flex 2 |  |  |
    | Processed | `IsProcessed` | check column | 80 | Purchase_RenderAttachmentProcessed |  |

- **grid** · renders into `divCreditNoteLines` · placeholder `You do not have any credit note lines.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `ProductCode` |  | flex 2 | renderer() |  |
    | Comment | `Comment` |  | flex 1 | renderer() | total count |
    | Supplier SKU | `SupplierInventoryCode` |  | flex 1 | renderer() |  |
    | Unit | `UnitOfMeasure` |  | flex 1 | renderer() |  |
    | Quantity | `Quantity` |  | flex 1 |  | total sum |
    | Price | `Price` |  | flex 1 | renderer() |  |
    | Discount | `Discount` | number column | flex 1 | renderer() |  |
    | Account | `AccountCode` |  | flex 2 | renderer() |  |
    | Total | `Total` |  | flex 1 | renderer() | total sum |

- **grid** · renders into `divCreditNoteAdditionalCostLines` · placeholder `You do not have any additional costs.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Description | `Description` |  | flex 2 | renderer() |  |
    | Reference | `Reference` |  | flex 2 | renderer() |  |
    | Quantity | `Quantity` |  | flex 1 |  |  |
    | Price | `Amount` |  | flex 1 | renderer() |  |
    | Discount | `Discount` | number column | flex 1 | renderer() |  |
    | Tax rule | `TaxRule` |  | flex 2 | renderer() |  |
    | Account | `AccountCode` |  | flex 2 | renderer() |  |
    | Total | `Total` |  | flex 1 | renderer() |  |

- **grid** · renders into `divCreditNotePayments` · placeholder `You do not have any refunds.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Account | `AccountCode` |  | flex 2 | renderer() |  |
    | Reference | `Reference` |  | flex 3 | renderer() |  |
    | Date paid | `DatePaid` | date column | flex 1 | edit: date field |  |
    | Amount | `Amount` |  | flex 1 | renderer() |  |
    | Conversion rate | `CurrencyConversionRate` |  | flex 1 | renderer() |  |
    | Base amount | `Amount` |  | flex 1 | renderer() |  |

- **grid** · renders into `divInvoiceLines` · placeholder `You do not have any invoice lines.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `ProductCode` |  | flex 2 | renderer() |  |
    | Comment | `Comment` |  | flex 1 | renderer() | total count |
    | Supplier SKU | `SupplierInventoryCode` |  | flex 1 | RenderHTMLText |  |
    | Unit | `UnitOfMeasure` |  | flex 1 | renderer() |  |
    | Quantity | `Quantity` |  | flex 1 |  | total sum |
    | Price | `Price` |  | flex 1 | renderer() |  |
    | Discount | `Discount` | number column | flex 1 | renderer() |  |
    | Tax rule | `TaxRule` |  | flex 1 | renderer() |  |
    | Account | `AccountCode` |  | flex 1 | renderer() |  |
    | Total | `Total` |  | flex 1 | renderer() | total sum |

- **grid** · renders into `divInvoiceAdditionalCostLines` · placeholder `You do not have any additional costs.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Description | `Description` |  | flex 3 | renderer() |  |
    | Reference | `Reference` |  | flex 2 | renderer() |  |
    | Quantity | `Quantity` |  | flex 1 |  |  |
    | Price | `Amount` |  | flex 1 | renderer() |  |
    | Discount | `Discount` | number column | flex 1 | renderer() |  |
    | Tax rule | `TaxRule` |  | flex 1 | renderer() |  |
    | Account | `AccountCode` |  | flex 1 | renderer() |  |
    | Total | `Total` |  | flex 1 | renderer() |  |

- **grid** · renders into `divInvoicePayments` · placeholder `You do not have any payments.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Account | `AccountCode` |  | flex 1 | renderer() |  |
    | Reference | `Reference` |  | flex 2 | renderer() |  |
    | Date paid | `DatePaid` | date column | flex 1 | edit: date field |  |
    | Amount | `Amount` |  | flex 1 | renderer() |  |
    | Conversion rate | `CurrencyConversionRate` |  | flex 1 | renderer() |  |
    | Base amount | `Amount` |  | flex 1 | renderer() |  |

- **grid** · renders into `UploadInvoiceLinesExceptionsGrid` · store `InvoiceLinesUploadErrorsStore` · placeholder `Please upload a file to check for issues.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Line # | `Line` |  | 50 |  |  |
    | Product SKU | `SKU` |  | 150 | renderer() |  |
    | Product name | `Name` |  | 250 | renderer() |  |
    | Quantity | `Quantity` |  | 100 | renderer() |  |
    | Price | `Price` |  | 100 | renderer() |  |
    | Discount | `Discount` |  | 100 | renderer() |  |
    | Comment | `Comment` |  | 150 | renderer() |  |

- **grid** · renders into `divVerifyInvoiceGrid` · store `VerifyInvoiceStore`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `ProductName` |  | flex 1 |  | total count |
    | Inner quantity | `CartonInnerQuantity` |  | flex 1 |  |  |
    | Estimated outer carton quantity | `CartonQuantity` |  | flex 1 |  |  |
    | Actual number of outer cartons | `NumberOfCartons` |  | flex 1 |  | total sum |
    | Volume of outer carton | `CartonVolume` |  | flex 1 | renderer() |  |
    | Line volume | `LineVolume` |  | flex 1 | renderer() | total sum |
    | Line freight cost | `LineFreightCost` |  | flex 1 | renderer() |  |
    | Unit freight cost | `UnitFreightCost` |  | flex 1 | renderer() |  |

- **grid** · renders into `divManualJournalsLines` · placeholder `You do not have any manual journals.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    |  | `DistributeType` |  | 100 | renderer() |  |
    | Debit | `Debit` |  | flex 1 | renderer() |  |
    | Credit | `Credit` |  | flex 1 | renderer() |  |
    | Reference | `Reference` |  | flex 1 | renderer() |  |
    | Date | `Date` | date column | flex 1 | edit: date field |  |
    | Amount | `Amount` |  | flex 1 | renderer() |  |
    | Type | `DistributeType` |  | flex 1 | renderer() |  |

- **grid** · renders into `divOrderLines` · placeholder `You do not have any purchase order lines.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `ProductCode` |  | flex 2 | renderer() |  |
    | Comment | `Comment` |  | flex 1 | renderer() | total count |
    | Supplier SKU | `SupplierInventoryCode` |  | flex 1 | renderer() |  |
    | Unit | `UnitOfMeasure` |  | flex 1 | renderer() |  |
    | Quantity | `Quantity` |  | flex 1 |  | total sum |
    | Price | `Price` |  | flex 1 | renderer() |  |
    | Discount | `Discount` | number column | flex 1 | renderer() |  |
    | Tax rule | `TaxRule` |  | flex 1 | renderer() |  |
    | Total | `Total` |  | flex 1 | renderer() | total sum |

- **grid** · renders into `divOrderAdditionalCostLines` · placeholder `You do not have any additional costs in your purchase order.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Description | `Description` |  | flex 3 | renderer() |  |
    | Reference | `Reference` |  | flex 2 | renderer() |  |
    | Quantity | `Quantity` |  | flex 1 |  |  |
    | Price | `Amount` |  | flex 1 | renderer() |  |
    | Discount | `Discount` | number column | flex 1 | renderer() |  |
    | Tax rule | `TaxRule` |  | flex 1 | renderer() |  |
    | Total | `Total` |  | flex 1 | renderer() |  |

- **grid** · renders into `divDeposits` · placeholder `You do not have any supplier deposits.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Account | `AccountCode` |  | flex 2 | renderer() |  |
    | Reference | `Reference` |  | flex 2 | renderer() |  |
    | Date paid | `DatePaid` | date column | flex 1 | edit: date field |  |
    | Amount | `Amount` |  | flex 1 | renderer() |  |
    | Conversion rate | `CurrencyConversionRate` |  | flex 1 | renderer() |  |
    | Base amount | `Amount` |  | flex 1 | renderer() |  |

- **grid** · renders into `UploadPOLinesExceptionsGrid` · store `POLinesUploadErrorsStore` · placeholder `Please upload a file to check for issues.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Line # | `Line` |  | 60 |  |  |
    | Product SKU | `SKU` |  | 150 | renderer() |  |
    | Product name | `Name` |  | 250 | renderer() |  |
    | Quantity | `Quantity` |  | 100 | renderer() |  |
    | Price | `Price` |  | 100 | renderer() |  |
    | Discount | `Discount` |  | 100 | renderer() |  |
    | Supplier SKU | `SupplierSKU` |  | 150 | renderer() |  |
    | Comment | `Comment` |  | 150 | renderer() |  |

- **grid** · renders into `divProductReplenishmentDetails` · store `ProductReplenishmentDetailsStore`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `ProductName` |  | flex 1 |  | total count |
    | Order quantity | `OrderQuantity` | number column | flex 1 |  | total sum |
    | Available | `Available` |  | flex 1 |  |  |
    | Backordered | `Backordered` |  | flex 1 |  |  |
    | MBR | `MinimumBeforeReorder` |  | flex 1 |  |  |
    | MOQ | `MOQ` |  | flex 1 |  |  |
    | On hand | `OnHand` |  | flex 1 |  |  |
    | On order | `OnOrder` |  | flex 1 |  |  |
    | Reorderquantity | `ReorderQuantity` |  | flex 1 |  |  |
    | Suggestedquantity | `SuggestedQuantity` |  | flex 1 |  |  |
    | Inner / outer carton quantity | `CartonInnerQuantity` |  | flex 1 | renderer() |  |
    | Number ofouter cartons | `NumberOfCartons` |  | flex 1 |  | total sum |
    | Linevolume | `LineVolumeSum` |  | flex 1 | renderer() | total sum |

- **grid** · renders into `divTDetails` · store `TransactionsStore` · placeholder `No transactions created.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Effective date | `EffectiveDate` |  | flex 1 | renderer() |  |
    | Debit | `Debit` |  | flex 1 | Common_COA_TreeMode_RestoreDisplayName |  |
    | Credit | `Credit` |  | flex 1 | Common_COA_TreeMode_RestoreDisplayName |  |
    | Amount | `Amount` |  | 130 | renderer() |  |

- **grid** · renders into `divStockReceivedLines` · placeholder `You do not have any stock received lines.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `ProductCode` |  | flex 3 | renderer() |  |
    | Batch/serial # | `BatchSN` |  | flex 1 | renderer() | total count |
    | Expiry date | `ExpiryDate` | date column | flex 1 | renderer() · edit: date field |  |
    | Supplier SKU | `SupplierInventoryCode` |  | flex 1 | RenderHTMLText |  |
    | Unit | `UnitOfMeasure` |  | flex 1 | renderer() |  |
    | Quantity | `Quantity` |  | flex 1 |  | total sum |
    | Location | `Location` |  | flex 1 | renderer() |  |
    | Date received | `Date` | date column | flex 1 | edit: date field |  |
    | Received | `Received` | check column | 80 | renderer() |  |

- **grid** · renders into `UploadStockReceivedLinesExceptionsGrid` · store `StockReceivedLinesUploadErrorsStore` · placeholder `Please upload a file to check for issues.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Line # | `Line` |  | 60 |  |  |
    | Product SKU | `SKU` |  | 150 | renderer() |  |
    | Product name | `Name` |  | 250 | renderer() |  |
    | Batch/serial # | `BatchSerialNumber` |  | 120 | renderer() |  |
    | Supplier SKU | `SupplierSKU` |  | 250 | renderer() |  |
    | Expiry date | `ExpiryDate_YYYYMMDD` |  | 100 | renderer() |  |
    | Quantity | `Quantity` |  | 100 | renderer() |  |
    | Location | `Location` |  | 100 | renderer() |  |
    | Date received | `DateReceived_YYYYMMDD` |  | 100 | renderer() |  |
    | Received | `Received` |  | 100 | renderer() |  |

- **grid** · renders into `divUnstockLines` · placeholder `You do not have any items to unstock.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `ProductCode` |  | flex 3 | renderer() | total count |
    | Batch/serial no. | `BatchSN` |  | flex 1 | renderer() |  |
    | Expiry date | `ExpiryDate` |  | flex 1 | renderer() |  |
    | Supplier SKU | `SupplierInventoryCode` |  | flex 1 | renderer() |  |
    | Unit | `UnitOfMeasure` |  | flex 1 | renderer() |  |
    | Quantity | `Quantity` |  | flex 1 |  | total sum |
    | Location | `Location` |  | flex 1 | renderer() |  |
    | Date | `Date` | date column | flex 1 | edit: date field |  |

- **grid** · renders into `divScanProductSelection` · store `storeScanProduct`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `SKU` |  | flex 1 | renderer() |  |

- **grid** · renders into `_classPrivateFieldGet(…)` · store `_classPrivateFieldGet(…)`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    |  | `Selected` |  | 58 | renderer() |  |
    | Original account | `AccountCode` |  | flex 1 | renderer() |  |
    | Amount | `Amount` |  | flex 1 | renderer() |  |
    | Distributed amount | `DistributedAmount` |  | flex 1 | renderer() |  |
    | Left to distribute | `LeftToDistribute` |  | flex 1 | renderer() |  |
    | Note | `Invoices` |  | flex 2 | renderer() |  |

- **grid** · renders into `divHistoryLines` · store `_classPrivateFieldGet(…)` · placeholder `Activity log is not available now.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Date | `DateChanged` |  | flex 1 | renderer() |  |
    | Changes made | `ColumnsChanged` |  | flex 4 | renderer() |  |
    | User | `ChangedBy` |  | flex 2 |  |  |

- **grid** · renders into `_classPrivateFieldGet(_DOM_ID_MAP,this).DIV_GRID` · store `store` · placeholder `You have not imported any files.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | File name | `DocumentName` |  | flex 3 | renderer() |  |
    | Status | `Status` |  | flex 1 | renderer() |  |
    | Extracted date | `DateCreated` |  | flex 1 | renderer() |  |
    | Action | `FileID` |  | flex 1 | renderer() |  |

- **grid** · renders into `logsGridContainer` · store `store`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Date | `Date` | date column | 200 | renderer() |  |
    | Document name | `DocumentName` |  | flex 1 | RenderHTMLText |  |
    | Comment | `Comment` |  | flex 1 |  |  |
    | User | `UserName` |  | flex 1 |  |  |

- **grid** · renders into `divDistributedAccounts` · store `PurchaseExpenseStore`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    |  | `Selected` |  | 58 | renderer() |  |
    | Original account | `AccountCode` |  | flex 1 | renderer() |  |
    | Amount | `Amount` |  | flex 1 | renderer() |  |
    | Distributed amount | `DistributedAmount` |  | flex 1 | renderer() |  |
    | Left to distribute | `LeftToDistribute` |  | flex 1 | renderer() |  |
    | Note | `Invoices` |  | flex 2 | renderer() |  |

- **grid** · renders into `divRelatedOrdersDetails` · store `RelatedOrdersStore` · placeholder `No related orders created.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Order | `TaskNumber` |  | flex 1 | renderer() |  |
    | Type | `TaskTypeName` |  | flex 1 | RenderHTMLText |  |
    | Order date | `OrderDate` |  | flex 1 | renderer() |  |
    | Status | `Status` |  | flex 1 | renderer() |  |
    | Total | `TotalAmount` |  | 130 | renderer() |  |

- **grid** · renders into `divManualJournalsDistributedCosts` · placeholder `You do not have any manual journals.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `ProductID` |  | flex 1 | renderer() |  |
    | Invoice total | `InvoiceTotal` |  | 200 | renderer() | total sum |
    | Manual journal cost | `DistributedCost` |  | 200 | renderer() | total sum |

- **grid** · renders into `Purchase_NewAllocation_Deposits` · store `vPurchaseDepositStore` · placeholder `No credits/deposits found for the selected supplier.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Date | `Date` |  | flex 2 | renderer() |  |
    | Description | `Description` |  | flex 5 |  |  |
    | Remaining / total | `Amount` |  | flex 3 | renderer() |  |

- **grid** · renders into `Purchase_NewAllocation_Allocations` · store `dialogSelectedStore` · placeholder `No selected supplier deposits.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Date | `Date` |  | flex 2 | renderer() |  |
    | Description | `Description` |  | flex 4 |  |  |
    | Available to allocate | `RemainingAmount` |  | flex 2 | renderer() |  |
    | Allocated | `AllocatedAmount` |  | flex 2 | renderer() |  |


#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| date field |  | `WorkflowModal_dtWorkflowDate` | `` | format `UserDateFormat` |
| combo |  | `inputId` | `AutocompleteAddressField.prototype.AddressInfoSto…` | shows `description` · value `place_id` · placeholder `Look up an address` |
| text field |  | `renderTo` | `` |  |
| combo |  | `renderTo` | `localStore` | shows `name` · value `value` · placeholder `Choose...` · pick-only |
| checkbox |  | `renderTo` | `` |  |
| numeric field |  | `renderTo` | `` |  |
| date field |  | `renderTo` | `` | placeholder `Choose...` · format `UserDateFormat` |
| text field |  | `renderTo` | `` |  |
| checkbox |  | `renderTo` | `` |  |
| numeric field |  | `renderTo` | `` |  |
| text field |  | `tdPurchase_CreditNote_Number` | `` | placeholder `write...` |
| date field |  | `tdPurchase_CreditNote_Date` | `` | placeholder `Choose...` · format `UserDateFormat` |
| text field |  | `tdPurchase_Invoice_Number` | `` | placeholder `write...` |
| date field |  | `tdPurchase_Invoice_Date` | `` | placeholder `Choose...` · format `UserDateFormat` |
| date field |  | `tdPurchase_Invoice_DueDate` | `` | placeholder `Choose...` · format `UserDateFormat` |
| numeric field |  | `tdPurchase_Invoice_Total` | `` |  |
| text field |  | `tdPurchase_Invoice_Total_No_Access` | `` | placeholder `No access` · hidden · disabled |
| numeric field |  | `tdPurchaseInvoiceDomesticFreightCostBaseCurrencyA…` | `` | placeholder `write...` |
| numeric field |  | `tdPurchaseInvoiceDomesticFreightCostOtherCurrency…` | `` | placeholder `write...` |
| numeric field |  | `tdPurchaseInvoiceOceanFreightCostBaseCurrencyAmou…` | `` | placeholder `write...` |
| numeric field |  | `tdPurchaseInvoiceOceanFreightCostOtherCurrencyAmo…` | `` | placeholder `write...` |
| combo |  | `tdPurchaseInvoiceDomesticFreightCostCurrency` | `vCurrenciesWithConversionRates` | shows `ResultCurrencyCode` · value `ResultCurrencyCode` · placeholder `Choose...` |
| combo |  | `tdPurchaseInvoiceOceanFreightCostCurrency` | `vCurrenciesWithConversionRates2` | shows `ResultCurrencyCode` · value `ResultCurrencyCode` · placeholder `Choose...` |
| numeric field |  | `tdPurchaseInvoiceTotalFreightCostAmount` | `` | placeholder `0` |
| combo (+ add new) |  | `Purchase_Index_Supplier` | `vPurchase_SupplierStore` | shows `Name` · value `SupplierID` · placeholder `type to search...` |
| combo (+ add new) |  | `Purchase_Index_Contact` | `vPurchase_SupplierContactStore` | shows `Name` · value `Name` · placeholder `Choose...` |
| text field |  | `Purchase_Index_Phone` | `` | placeholder `write...` |
| combo (+ add new) |  | `Purchase_Index_VendorAddressLine1` | `vPurchase_SupplierAddressStore` | shows `Line1` · value `Line1` · placeholder `Address` |
| text field |  | `Purchase_Index_VendorAddressLine2` | `` | placeholder `City, state, country, zip` |
| combo (+ add new) |  | `Purchase_Index_Terms` | `vTenantPaymentTermStore` | shows `Name` · value `Name` · placeholder `Choose...` |
| date field |  | `Purchase_Index_ShipmentRequiredByDate` | `` | placeholder `Choose...` · format `UserDateFormat` |
| numeric field (with action) |  | `tdPurchase_Index_CurrencyConversionRate` | `` |  |
| combo |  | `Purchase_Index_Tax` | `vTenantTaxationRuleStore` | shows `Description` · value `RuleID` · placeholder `Choose...` |
| combo |  | `tdPurchase_Index_Milestone` | `vPurchase_JobMilestonesStore` | shows `Name` · value `ID` · placeholder `type to search...` |
| checkbox |  | `Purchase_Index_Tax_Inclusive` | `` |  |
| checkbox |  | `Purchase_Index_BlindReceipt` | `` |  |
| date field |  | `Purchase_Index_Date` | `` | placeholder `Choose...` · format `UserDateFormat` |
| combo (+ add new) |  | `Purchase_Index_Location` | `vTenantLocationLoadStore` | shows `Description` · value `Description` · placeholder `Choose...` |
| combo (+ add new) |  | `Purchase_Index_SippingAddressLine1` | `vPurchase_TenantAddressStore` | shows `Line1` · value `Line1` · placeholder `Address` |
| text field |  | `Purchase_Index_SippingAddressLine2` | `` | placeholder `City, state, country, zip` |
| checkbox |  | `HeaderShipToOther` | `` |  |
| text field |  | `tdScanBatchSN` | `` | placeholder `write...` |
| combo |  | `tdScanBin` | `vTenantLocationLoadStore` | shows `Description` · value `LocationID` · placeholder `choose...` |
| date field |  | `tdScanExpiryDate` | `` | placeholder `Choose...` · format `UserDateFormat` |
| combo |  | `"js-task-name_".concat(…)` | `store` | shows `DistributedAmountGrid_classPrivateField…` · value `DistributedAmountGrid_classPrivateField…` · placeholder `type… |
| numeric field |  | `"divTargetAccountDistribute_".concat(id).concat(…)` | `` |  |
| combo (+ add new) |  | `extDocExtCustomer` | `store` | shows `Name` · value `Name` · placeholder `type to search...` |
| combo |  | `"divTargetPurchase_".concat(…)` | `_store` | shows `InvoiceNumber` · value `TaskID` · placeholder `type to search` |
| numeric field |  | `"divTargetPurchaseAccountDistribute_".concat(inde…` | `` |  |
| combo |  | `"divTargetTask_".concat(…)` | `_store` | shows `TaskNumber` · value `TaskID` · placeholder `type to search` |
| numeric field |  | `"divTargetPurchaseAccountDistribute_other_".conca…` | `` |  |
| combo |  | `"divTargetProduction_".concat(…)` | `_store` | shows `ProductionOrderNumber` · value `ProductionRunID` · placeholder `type to search` |
| numeric field |  | `"divTargetProductionAccountDistribute_production_…` | `` |  |
| combo |  | `Purchase_NewDeposit_Account` | `AccountSupplierDepositStore` | shows `DisplayName` · value `Code` · placeholder `Choose...` |
| combo |  | `Purchase_NewDeposit_BankAccount` | `vBankAccountsStore` | shows `DisplayName` · value `Code` · placeholder `Select a bank account...` · pick-only |
| date field |  | `Purchase_NewDeposit_DatePaid` | `` | placeholder `Choose...` · format `UserDateFormat` |
| combo |  | `tdPurchase_NewSupplier_Currency` | `currencyStore` | shows `Code` · value `Code` |

#### Menus, buttons and other parts

- **column** “Entity” · field `EntityType` · id `colRealDimensionsEntity`
- **column** “Account” · field `AccountCode` · id `colRealDimensionsAccount`
- **column** “Amount” · field `Amount` · id `colRealDimensionsAmount`
- **column** “Reference number” · field `ReferenceNumber` · id `colRealDimensionsReferenceNumber`
- **column** “Effective date” · field `EffectiveDate` · id `colRealDimensionsDate`
- **column** “Product” · field `ProductCode` · id `colRealDimensionsProduct`
- **column** “Supplier \| Customer” · field `"".concat(…)` · id `"colRealDimensions".concat(…)`
- **column** “{attr}” · field `attr.replace(…)` · id `"col".concat(…)`
- **component** · id `cmpId` · renders into `renderTo` · store `localStore` · shows `name` · value `value` · placeholder `Choose...` · pick-only
- **column** “{attrSet.name}” · field `"CustomField".concat(…)`
- **component** · renders into `_self.names.cmbFamily` · store `_self.familyStore` · shows `Name` · value `ID`
- **component** · renders into `_self.names.cmbBaseOption` · store `_self.familyOptionStore` · shows `name` · value `name` · pick-only
- **component** · renders into `_self.names.cmbBaseOptionValue` · store `_self.familyBaseOptionValueStore` · shows `name` · value `name` · pick-only
- **FamilyMatrix_Option** · name `optionName`
- **FamilyMatrix_Value** · name `item`
- **component** · renders into `tdPurchase_Index_DefaultAccount` · store `vChartOfAccountsLinesStore` · shows `DisplayName` · value `Code` · placeholder `Choose...`
- **component** · renders into `tdScanQuantity` · required
- **text area** · renders into `divInventoryModeBarcodes` · placeholder `Enter your barcodes here...`
- **tooltip** “{item.ValidationText}”
- **component** · renders into `tdPurchase_NewProduct_SaleTaxRule` · store `SaleTaxRuleStore` · shows `Description` · value `RuleID` · placeholder `Select a sale tax rule`

### `Supplier2019`

5 grids · 21 standalone fields · 0 windows · 2 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `divAddressLines` · placeholder `No addresses found.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Line 1 | `Line1` |  | flex 2 | RenderHTMLText |  |
    | Line 2 | `Line2` |  | flex 2 | RenderHTMLText |  |
    | City / Suburb | `CitySuburb` |  | flex 1 | RenderHTMLText |  |
    | State / Province | `StateProvince` |  | flex 1 | RenderHTMLText |  |
    | ZIP / postcode | `ZipPostCode` |  | flex 1 | RenderHTMLText |  |
    | Country | `Country` |  | flex 2 | RenderHTMLText |  |
    | Type | `Type` |  | flex 1 | renderer() |  |
    | Default for type | `DefaultForType` | check column | 80 | renderer() |  |

- **grid** · renders into `divContactLines` · placeholder `No contacts found.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Name | `Name` |  | flex 1 | RenderHTMLText |  |
    | Phone | `Phone` |  | flex 1 | RenderHTMLText |  |
    | Mobile phone | `MobilePhone` |  | flex 1 | RenderHTMLText |  |
    | Job title | `JobTitle` |  | flex 1 | RenderHTMLText |  |
    | Fax | `Fax` |  | flex 1 | RenderHTMLText |  |
    | Email | `Email` |  | flex 2 | RenderHTMLText |  |
    | Website | `Website` |  | flex 2 | RenderHTMLText |  |
    | Comment | `Comment` |  | flex 2 | renderer() |  |
    | Default | `IsDefault` | check column | 80 | renderer() |  |
    | Include in emails | `IncludeInEmail` | check column | 120 | renderer() |  |

- **grid** · renders into `divPurchasesByProductLines` · store `vSupplierPurchasesStore` · placeholder `No purchases found.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | SKU | `ProductCode` |  | flex 1 | renderer() |  |
    | Product | `Name` |  | flex 1 | renderer() |  |
    | Invoice # | `InvoiceNumber` |  | flex 1 | renderer() |  |
    | Supplier SKU | `SupplierSku` |  | flex 1 |  |  |
    | Date | `InvoiceDate` |  | flex 1 | renderer() |  |
    | Quantity | `Quantity` |  | flex 1 |  |  |
    | Price | `Price` |  | flex 1 | renderer() |  |

- **grid** · renders into `divPurchasesByDocumentLines` · store `vSupplierPurchaseTasksStore` · placeholder `No purchases found.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Invoice # | `SupplierReference` |  | flex 1 | renderer() |  |
    | Order # | `PurchaseOrderNumber` |  | flex 1 | renderer() |  |
    | Status | `Status` |  | flex 1 | renderer() |  |
    | Order date | `PurchaseOrderDate` |  | flex 1 | renderer() |  |
    | Invoice | `Total` |  | flex 1 | renderer() |  |
    | Paid | `Paid` |  | flex 1 | renderer() |  |

- **grid** · renders into `divAttachmentList` · store `FileStore` · placeholder `You do not have any uploaded files.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | File name | `FileName` |  | flex 1 | renderer() |  |
    | Attached by | `UserName` |  | flex 1 | renderer() |  |
    | Uploaded date | `UploadedDate` |  | flex 1 | renderer() |  |


#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| combo |  | `inputId` | `AutocompleteAddressField.prototype.AddressInfoSto…` | shows `description` · value `place_id` · placeholder `Look up an address` |
| combo |  | `tdSupplier_Index_Status` | `StatusStore` | shows `Name` · value `Value` |
| combo |  | `tdSupplier_Index_Currency` | `currencyStore` | shows `Code` · value `Code` |
| combo (+ add new) |  | `tdSupplier_Index_PaymentTerm` | `vTenantPaymentTermStore` | shows `Name` · value `TermID` |
| combo |  | `tdSupplier_Index_AccountCode` | `vChartOfAccountsStore` | shows `DisplayName` · value `Code` |
| combo |  | `tdSupplier_Index_TaxRule` | `vTenantTaxationRuleStore` | shows `Description` · value `RuleID` |
| combo |  | `tdSupplier_Index_DefaultCarrier` | `vTenantCarrierStore` | shows `Description` · value `CarrierID` |
| text field |  | `tdSupplier_Index_TaxNumber` | `` |  |
| number field |  | `tdSupplier_Index_Discount` | `` |  |
| combo |  | `tdSupplier_Index_AttributeSet` | `AttributeSetStore` | shows `Name` · value `SetID` |
| combo |  | `tdSupplier_Index_DefaultTemplate_PurchaseOrder` | `vPurchaseOrderTemplateStore` | shows `Name` · value `TemplateID` · placeholder `choose...` |
| combo |  | `tdSupplier_Index_DefaultTemplate_PurchaseOrderMat…` | `vPurchaseOrderMatrixTemplateStore` | shows `Name` · value `TemplateID` · placeholder `choose...` |
| combo |  | `tdSupplier_Index_DefaultTemplate_PurchaseInvoice` | `vPurchaseInvoiceTemplateStore` | shows `Name` · value `TemplateID` · placeholder `choose...` |
| combo |  | `tdSupplier_Index_DefaultTemplate_ReceivingNote` | `vReceivingNoteTemplateStore` | shows `Name` · value `TemplateID` · placeholder `choose...` |
| combo |  | `tdSupplier_Index_DefaultTemplate_ProductLabel` | `vProductLabelTemplateStore` | shows `Name` · value `TemplateID` · placeholder `choose...` |
| combo |  | `tdSupplier_Index_DefaultTemplate_PurchaseReturn` | `vPurchaseReturnTemplateStore` | shows `Name` · value `TemplateID` · placeholder `choose...` |
| date field |  | `WorkflowModal_dtWorkflowDate` | `` | format `UserDateFormat` |
| text field |  | `renderTo` | `` |  |
| checkbox |  | `renderTo` | `` |  |
| numeric field |  | `renderTo` | `` |  |
| date field |  | `renderTo` | `` | placeholder `Choose...` · format `UserDateFormat` |

#### Menus, buttons and other parts

- **component** · id `cmpId` · renders into `renderTo` · store `localStore` · shows `name` · value `value` · placeholder `Choose...` · pick-only
- **column** “{attrSet.name}” · field `"CustomField".concat(…)`

### `SupplierDeposits2019`

2 grids · 0 standalone fields · 0 windows · 0 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `divAllocatedDetailsGridContainer` · store `vAllocatedStore`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Document # | `DocNumber` |  | flex 1 | renderer() |  |
    | Date paid | `Date` |  | flex 1 | renderer() |  |
    | Allocated amount | `Amount` |  | flex 1 | renderer() |  |

- **grid** · renders into `SupplierDeposits_Index_Container` · store `mainStore`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    |  | `` |  | flex 1 | renderer() | hidden |
    | Supplier | `SupplierName` |  | flex 1 | renderer() |  |
    | Date | `Date` |  | flex 1 | renderer() |  |
    | Amount/balance | `Amount` |  | flex 1 | renderer() |  |
    | Created as/by | `Description` |  | flex 1 |  |  |


### `SupplierList2019`

2 grids · 0 standalone fields · 0 windows · 0 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `MergeSupplierGridContainer` · store `selectedStore`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    |  | `Name` |  | flex 1 | renderer() |  |

- **grid** · renders into `SupplierList_Index_Container` · store `mainStore`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    |  | `` |  | flex 1 | renderer() | hidden |
    | Name | `Name` |  | flex 1 | renderer() |  |
    | Contact | `Contact` |  | flex 1 | renderer() |  |
    | Phone | `Phone` |  | flex 1 | renderer() |  |
    | Email | `Email` |  | flex 1 | renderer() |  |
    | Website | `Website` |  | flex 1 | renderer() |  |
    | Address | `Address` |  | flex 2 | renderer() |  |
    | Due | `DueAmount` |  | flex 1 | renderer() |  |
    | Status | `IsActive` |  | flex 1 | renderer() |  |


