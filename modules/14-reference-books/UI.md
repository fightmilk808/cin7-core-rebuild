# Reference books: UI

Every component the page code builds, read from the shipped ExtJS bundles: grids with their columns, fields, buttons, menus, windows and custom components. Labels are the English UI text. `renders into` is the id of the `<div>` in the page's server-rendered HTML that the component mounts in; `store` names the data store (see the endpoints in [README.md](README.md)); `on click` is the handler. Visual system and shell layout: [docs/UI.md](../../docs/UI.md).

## Screens

| Route | Title | Bundles |
|---|---|---|
| `/AccountMapping` | Account mapping | [`AccountMapping2019`](#accountmapping2019) |
| `/AccountingDimensions` | Accounting dimensions | [`AccountingDimensions2019`](#accountingdimensions2019) |
| `/BankAccounts` | Bank accounts | [`BankAccounts2019`](#bankaccounts2019) |
| `/ChartOfAccounts` | Chart of accounts | [`ChartOfAccounts2019`](#chartofaccounts2019) |
| `/DealList` | Deals | [`DealList2019`](#deallist2019) |
| `/DearToDearNetworking` | Cin7 Core to Cin7 Core Network | [`DearToDear2019`](#deartodear2019) |
| `/DefaultFieldValues/Customer` | Default field values | [`DefaultFieldValues2019`](#defaultfieldvalues2019) |
| `/DefaultFieldValues/Product` | Default field values | [`DefaultFieldValues2019`](#defaultfieldvalues2019) |
| `/DefaultFieldValues/Supplier` | Default field values | [`DefaultFieldValues2019`](#defaultfieldvalues2019) |
| `/DiscountListNew` | Discounts | [`DiscountListNew2019`](#discountlistnew2019) |
| `/ExpenseItems` | Expense items | [`ExpenseItemList`](#expenseitemlist) |
| `/FixedAssetType` | Fixed asset types | [`FixedAssetType2019`](#fixedassettype2019), [`Product2019`](#product2019) |
| `/LeadStatus` | Lead statuses | [`LeadStatus2019`](#leadstatus2019) |
| `/OpeningBalances` | Opening balances | [`OpeningBalances2019`](#openingbalances2019), [`FixedAssetType2019`](#fixedassettype2019) |
| `/OrderRouting` | Order routing | [`OrderRouting2019`](#orderrouting2019) |
| `/RMAReasonForReturn` | Reason for return | [`RMAReasonForReturn2019`](#rmareasonforreturn2019) |
| `/RMAReturnOrderSettings` | Return order settings | [`RMAReturnOrderSettings2019`](#rmareturnordersettings2019) |
| `/RMAReturnPolicy` | Return policy | [`RMAReturnPolicy2019`](#rmareturnpolicy2019) |
| `/TenantAddress` | Company addresses | [`TenantAddress2019`](#tenantaddress2019) |
| `/TenantAttributeSet` | Additional attributes | [`TenantAttributeSet2019`](#tenantattributeset2019) |
| `/TenantBrand` | Product brands | [`TenantBrands2019`](#tenantbrands2019) |
| `/TenantCarrier` | Carriers | [`TenantCarriers2019`](#tenantcarriers2019) |
| `/TenantContact` | Company contacts | [`TenantContact2019`](#tenantcontact2019) |
| `/TenantInventoryCategory` | Product categories | [`TenantInventoryCategory2019`](#tenantinventorycategory2019) |
| `/TenantLocation` | Locations and bins | [`TenantLocation2019`](#tenantlocation2019) |
| `/TenantLocationEdit` | Edit location | [`TenantLocationEdit`](#tenantlocationedit) |
| `/TenantPaymentTerm` | Payment terms | [`TenantPaymentTerm2019`](#tenantpaymentterm2019) |
| `/TenantShipZone` | Shipping zones | [`TenantShippingZones2019`](#tenantshippingzones2019) |
| `/TenantTaxationRule` | Tax rules | [`TenantTaxationRule2019`](#tenanttaxationrule2019) |
| `/TenantUnitOfMeasure` | Units of measure | [`TenantUnitOfMeasure2019`](#tenantunitofmeasure2019) |
| `/WarrantySetupList` | Warranties | [`WarrantiySetupList2019`](#warrantiysetuplist2019) |

## Components by bundle

### `AccountingDimensions2019`

1 grids · 0 standalone fields · 0 windows · 0 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `AccountingDimensions_Index_Container` · store `window.GridStore` · placeholder `You do not have any accounting dimension attributes at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Name | `Name` |  | flex 1 | renderer() |  |
    |  | `Type` |  | flex 1 | renderer() |  |
    | Values | `ListValues` |  | flex 1 | renderer() |  |
    | Active | `IsActive` | check column | flex 1 | renderer() |  |


### `BankAccounts2019`

0 grids · 1 standalone fields · 0 windows · 0 menus, buttons and other parts · 0 custom components

#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| combo |  | `tdBankAccounts_Bank_Status` | `vAccountStatusCodeStore` | shows `Name` · value `Value` · pick-only |

### `ChartOfAccounts2019`

5 grids · 0 standalone fields · 0 windows · 1 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `ChartOfAccounts_Index_Container` · store `mainStore` · placeholder `Please either load the chart of accounts from accounting software or …`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Class | `Class` |  | flex 1 | RenderHTMLText | hidden |
    |  | `TreeLevel` |  |  | renderer() | hidden |
    | Code | `Code` |  | flex 1 | renderer() |  |
    | Name | `Name` |  | flex 5 | renderer() |  |
    |  | `` |  | 60 | renderer() | hidden |
    | Accounting dimension | `Code` |  |  | renderer() | hidden |
    | Type | `Type` |  | flex 1 | RenderHTMLText |  |
    | Status | `Status` |  | flex 1 | renderer() |  |

- **grid** · renders into `divTypeClassGrid` · store `vAccountTypesAndClassesStore`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Class | `AccountClass` |  | flex 1 | RenderHTMLText | hidden |
    | Type | `AccountType` |  | flex 1 | RenderHTMLText |  |
    | Description | `Description` |  | flex 1 | RenderHTMLText |  |

- **grid** · renders into `divSystemAccountsGrid` · store `vSystemAccountInfoStore`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Code | `Code` |  | flex 1 | RenderHTMLText |  |
    | Name | `Name` |  | flex 1 | RenderHTMLText |  |
    | Multiple allowed | `MultipleAllowed` |  | flex 1 |  |  |

- **grid** · renders into `divPerformedActionsGrid` · store `PerformedImportActionsStore` · placeholder `No actions performed.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | New code | `NewCode` |  | 100 | RenderHTMLText |  |
    | Code | `Code` |  | 100 | RenderHTMLText |  |
    | Name | `Name` |  | flex 1 | RenderHTMLText |  |
    | Type | `Type` |  | 120 | RenderHTMLText |  |
    | Class | `Class` |  | 120 | RenderHTMLText |  |
    | Performed action | `ImportResult` |  | flex 1 | renderer() |  |

- **grid** · renders into `renderTo` · store `store` · placeholder `Please upload a file to check for issues.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Line # | `Line` |  | 50 |  |  |


#### Menus, buttons and other parts

- **column** “{title}” · field `field`

### `DealList2019`

1 grids · 0 standalone fields · 0 windows · 0 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `DealList_Index_Container` · store `mainStore` · placeholder `You do not have any deals at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    |  | `` |  | flex 1 | renderer() | hidden |
    | Deal name | `Name` |  | flex 3 | renderer() |  |
    | Date from | `DateFrom` |  | flex 2 | renderer() |  |
    | Date to | `DateTo` |  | flex 2 | renderer() |  |
    | Active | `IsActive` |  | 80 | renderer() |  |


### `DearToDear2019`

2 grids · 0 standalone fields · 0 windows · 0 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `DearToDear_Index_Container` · store `store` · placeholder `You do not have any connections at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Contact | `SupplierCustomerID` |  | flex 2 | renderer() |  |
    | Contact type | `ConnectionType` |  | flex 2 | renderer() |  |
    | Is invite sent | `IsInviteSent` | check column | 100 | renderer() |  |
    | Date when the invite was sent | `DateInviteSent` | date column | flex 2 |  |  |
    | Status | `Status` |  | flex 2 | renderer() |  |
    | Date connected | `DateConnected` | date column | flex 2 |  |  |
    | Networking key | `NetworkingKey` |  | flex 2 | RenderHTMLText |  |
    |  | `` | action column | 100 |  |  |

- **grid** · renders into `gridRecipients` · store `RecipientsStore` · placeholder `You do not have any contacts with emails at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    |  | `Checked` | check column |  | renderer() |  |
    | Name | `Name` |  | flex 1 | RenderHTMLText |  |
    | Email | `Email` |  | flex 1 |  |  |


### `DefaultFieldValues2019`

0 grids · 27 standalone fields · 0 windows · 0 menus, buttons and other parts · 0 custom components

#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| combo |  | `Customer_Index_Currency` | `AllCurrencyStore` | shows `Code` · value `Code` · placeholder `Choose...` |
| combo |  | `Customer_Index_SalePriceTier` | `vSalesPriceTierStore` | shows `Name` · value `Code` · placeholder `Choose...` |
| combo |  | `Customer_Index_TaxRule` | `vTenantTaxationRuleStore` | shows `Description` · value `RuleID` · placeholder `Choose...` |
| combo |  | `Customer_Index_PaymentTerm` | `vTenantPaymentTermStore` | shows `Name` · value `TermID` · placeholder `Choose...` |
| combo |  | `Customer_Index_AccountReceivable` | `vChartOfAccountsStore` | shows `DisplayName` · value `Code` · placeholder `Choose...` |
| combo |  | `Customer_Index_SaleAccount` | `vChartOfAccountsForSaleAccountStore` | shows `DisplayName` · value `Code` · placeholder `Choose...` |
| combo |  | `Customer_Index_DefaultSalesRepresentative` | `vTenantContactStore` | shows `Name` · value `ContactID` · placeholder `Choose...` |
| combo |  | `Customer_Index_DefaultCarrier` | `vTenantCarrierStore` | shows `Description` · value `CarrierID` · placeholder `Choose...` |
| combo |  | `Customer_Index_DefaultLocation` | `vTenantLocationStore` | shows `Description` · value `LocationID` · placeholder `Choose...` |
| combo |  | `Customer_Index_AttributeSet` | `AttributeSetStore` | shows `Name` · value `SetID` · placeholder `Choose...` |
| combo |  | `Product_Index_Type` | `ProductTypeStore` | shows `name` · value `value` · placeholder `Choose...` |
| combo |  | `Product_Index_FixedAssetType` | `vProductFixedAssetTypeStore` | shows `Name` · value `FixedAssetTypeID` · placeholder `Choose...` |
| combo |  | `Product_Index_Category` | `vTenantInventoryCategoryStore` | shows `Category` · value `CategoryID` · placeholder `Choose...` |
| combo |  | `Product_Index_Brand` | `vTenantBrandStore` | shows `Brand` · value `ID` · placeholder `Choose...` |
| combo |  | `Product_Index_CostingMethod` | `CostingMethodStore` | shows `DisplayName` · value `CostingMethod` · placeholder `Choose...` |
| combo |  | `Product_Index_DefaultUnitOfMeasure` | `vTenantUnitOfMeasureStore` | shows `Unit` · value `UnitOfMeasureID` · placeholder `Choose...` |
| combo |  | `Product_Index_DropShipMode` | `DropShipModeStore` | shows `DisplayName` · value `DropShipMode` · placeholder `Choose...` |
| combo |  | `Product_Index_Discount` | `vDiscountStore` | shows `Name` · value `ID` · placeholder `Choose...` |
| combo |  | `Product_Index_DefaultLocation` | `vLocationsWithBinsStore` | shows `Description` · value `LocationID` · placeholder `Choose...` |
| combo |  | `Product_Index_ProductAttributeSet` | `AttributeSetStore` | shows `Name` · value `SetID` · placeholder `Choose...` |
| combo |  | `Product_Index_NotSellable` | `NotSellableTypesStore` | shows `name` · value `value` · placeholder `Choose...` |
| combo |  | `Supplier_Index_Currency` | `AllCurrencyStore` | shows `Code` · value `Code` · placeholder `Choose...` |
| combo |  | `Supplier_Index_TaxRule` | `vTenantTaxationRuleStore` | shows `Description` · value `RuleID` · placeholder `Choose...` |
| combo |  | `Supplier_Index_PaymentTerm` | `vTenantPaymentTermStore` | shows `Name` · value `TermID` · placeholder `Choose...` |
| combo |  | `Supplier_Index_AccountPayable` | `vChartOfAccountsStore` | shows `DisplayName` · value `Code` · placeholder `Choose...` |
| combo |  | `Supplier_Index_DefaultCarrier` | `vTenantCarrierStore` | shows `Description` · value `CarrierID` · placeholder `Choose...` |
| combo |  | `Supplier_Index_AttributeSet` | `AttributeSetStore` | shows `Name` · value `SetID` · placeholder `Choose...` |

### `DiscountListNew2019`

2 grids · 0 standalone fields · 0 windows · 0 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `DiscountList_Index_Container` · store `mainStore` · placeholder `You do not have any discounts at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Discount name | `Name` |  | flex 1 | renderer() |  |
    | Discount type | `Type` |  | flex 1 | renderer() |  |
    | Status | `IsActive` |  | 80 | renderer() |  |

- **grid** · renders into `DiscountNew_QuantityBasedGrid` · placeholder `No discount lines added.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Up to | `MaxValue` |  | flex 1 |  |  |
    | Type of discount | `Type` |  | flex 1 | renderer() |  |
    | Amount | `Amount` |  | flex 1 | renderer() |  |


### `ExpenseItemList`

1 grids · 0 standalone fields · 0 windows · 0 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `ExpenseItem_Index_Container` · store `ExpenseItemsStore` · placeholder `You do not have any expense items at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Description | `Description` |  | flex 1 | RenderHTMLText |  |
    | Account | `AccountCode` |  | flex 1 | renderer() |  |


### `FixedAssetType2019`

1 grids · 0 standalone fields · 0 windows · 1 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `FixedAssetType_Index_Container` · store `store` · placeholder `You do not have any fixed asset types at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    |  | `` |  | flex 1 | renderer() | hidden |
    | Name | `Name` |  | flex 1 | RenderHTMLText |  |
    | Depreciation method | `DepreciationMethod` |  | flex 1 | RenderHTMLText |  |
    | Averaging method | `AveragingMethod` |  | flex 1 | RenderHTMLText |  |
    | Rate | `Rate` |  | flex 1 | renderer() |  |
    | Effective life | `EffectiveLife` |  | flex 1 | renderer() |  |
    | Asset account | `AssetAccountName` |  | flex 1 | Common_COA_TreeMode_RestoreDisplayName |  |
    | Accumulated depreciation account | `AccumulatedDepreciationAccountName` |  | flex 2 | Common_COA_TreeMode_RestoreDisplayName |  |
    | Depreciation expense account | `DepreciationExpenseAccountName` |  | flex 2 | Common_COA_TreeMode_RestoreDisplayName |  |


#### Menus, buttons and other parts

- **component**
  - *buttons:*
    - **item**

### `LeadStatus2019`

1 grids · 0 standalone fields · 0 windows · 0 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `LeadStatus_Index_Container` · store `store` · placeholder `You do not have any custom lead statuses at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    |  | `` |  | flex 1 | renderer() | hidden |
    | Name | `Name` |  | flex 1 | RenderHTMLText |  |
    | Is active | `IsActive` | check column | 90 | renderer() |  |


### `OpeningBalances2019`

11 grids · 6 standalone fields · 0 windows · 4 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `OpeningBalances_Index_BalancesContainer` · placeholder `Load your chart of accounts before editing opening balances.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Account | `Name` |  | flex 6 | Common_COA_TreeMode_RestoreDisplayName | total count |
    | Inventory/Fixed asset \| Inventory | `InventoryAsset` | check column | flex 2 | renderer() |  |
    | Debit | `Debit` |  | flex 2 | renderer() | total sum |
    | Credit | `Credit` |  | flex 2 | renderer() | total sum |

- **grid** · renders into `divMultiCurrencyLines` · store `multiCurrencyBalancesStore` · placeholder `Add amounts in all currencies for the account.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Currency | `Currency` |  | flex 2 | renderer() |  |
    | Amount | `Amount` |  | flex 1 | renderer() |  |
    | Exchange rate | `Rate` |  | flex 1 | renderer() | total count |
    | {"Amount (".concat(…)} | `Amount` |  | flex 1 | renderer() | total sum |

- **grid** · renders into `OpeningBalances_Purchase_Container` · placeholder `Add outstanding bills prior to opening balances date.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Supplier | `SupplierName` |  | flex 2 | renderer() |  |
    | Currency | `Currency` |  | flex 2 |  |  |
    | Invoice # | `SupplierReference` |  | flex 2 | renderer() |  |
    | Invoice date | `InvoiceDate` | date column | flex 2 | edit: date field |  |
    | Amount | `InvoiceTotalAmount` |  | flex 1 | renderer() |  |
    | Conversion  rate | `CurrencyConversionRate` |  | flex 2 | renderer() |  |
    | Total | `InvoiceTotalAmount` |  | flex 1 | renderer() |  |

- **grid** · renders into `OpeningBalances_Sale_Container` · placeholder `Add outstanding invoices prior to opening balances date.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Customer | `CustomerName` |  | flex 2 | renderer() |  |
    | Currency | `Currency` |  | flex 1 | RenderHTMLText |  |
    | Invoice # | `InvoiceNumber` |  | flex 2 | renderer() |  |
    | Customer reference | `CustomerReference` |  | flex 2 | renderer() |  |
    | Invoice date | `InvoiceDate` | date column | flex 1 | edit: date field |  |
    | Amount | `InvoiceTotalAmount` |  | flex 1 | renderer() |  |
    | Conversion rate | `CurrencyConversionRate` |  | flex 2 | renderer() |  |
    | Total | `InvoiceTotalAmount` |  | flex 1 | renderer() |  |

- **grid** · renders into `divSOHDetailLines` · store `sohEditorStore` · placeholder `No stock on hand uploaded.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `Product` |  | flex 2 | renderer() |  |
    | Location | `Location` |  | flex 1 | renderer() |  |
    | Account | `AccountCode` |  | flex 1 | renderer() |  |
    | Unit cost | `UnitCost` |  | flex 1 |  |  |
    | Received | `Date` | date column | 150 |  |  |
    | Quantity | `Quantity` |  | flex 1 |  |  |
    | Batch/serial # | `BatchSN` |  | flex 1 | renderer() |  |
    | Expiry date | `ExpiryDate` | date column | 150 | renderer() |  |

- **grid** · renders into `OpeningBalances_SOH_Container` · store `sohStore` · placeholder `No opening stock on hand uploaded.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Opening stock on hand | `PurchaseOrderNumber` |  | flex 1 | renderer() |  |
    | Account | `AccountCode` |  | flex 1 | renderer() |  |
    | Amount | `Amount` |  | 200 | renderer() |  |

- **grid** · renders into `divExceptionsContainer` · store `store` · placeholder `Please upload a file to check for issues.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Line # | `Line` |  | 50 |  |  |
    | Supplier | `SupplierName` |  | flex 2 | renderer() |  |
    | Supplier reference | `SupplierReference` |  | flex 2 | renderer() |  |
    | Invoice date | `InvoiceDate` |  | flex 2 | renderer() |  |
    | Amount | `Amount` |  | flex 1 | renderer() |  |
    | Conversion  rate | `CurrencyConversionRate` |  | flex 2 | renderer() |  |

- **grid** · renders into `divExceptionsContainer` · store `store` · placeholder `Please upload a file to check for issues.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Line # | `Line` |  | flex 1 |  |  |
    | Customer | `CustomerName` |  | flex 2 | renderer() |  |
    | Invoice # | `InvoiceNumber` |  | flex 2 | renderer() |  |
    | Customer reference | `CustomerReference` |  | flex 2 | renderer() |  |
    | Invoice date | `InvoiceDate` |  | flex 1 | renderer() |  |
    | Amount | `Amount` |  | flex 1 | renderer() |  |
    | Conversion rate | `CurrencyConversionRate` |  | flex 2 | renderer() |  |

- **grid** · renders into `divFixedAssetDetailLines` · store `FixedAssetDetailsStore` · placeholder `No fixed assets uploaded.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `Product` |  | flex 2 | renderer() |  |
    | Location | `Location` |  | flex 1 | renderer() |  |
    | Account | `AssetAccount` |  | flex 1 | Common_COA_TreeMode_RestoreDisplayName |  |
    | Unit cost | `UnitCost` |  | flex 1 |  |  |
    | Received | `Date` | date column | 150 |  |  |
    | Batch/serial # | `BatchSN` |  | flex 1 | renderer() |  |
    | Depreciation method | `DepreciationMethod` |  | 150 |  |  |

- **grid** · renders into `OpeningBalances_FixedAsset_Container` · store `fixedAssetStore` · placeholder `No opening fixed assets uploaded.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Opening fixed assets | `PurchaseOrderNumber` |  | flex 1 | renderer() |  |
    | Account | `AccountCode` |  | flex 1 | renderer() |  |
    | Amount | `Amount` |  | 200 | renderer() |  |

- **grid** · renders into `FixedAssetType_Index_Container` · store `store` · placeholder `You do not have any fixed asset types at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    |  | `` |  | flex 1 | renderer() | hidden |
    | Name | `Name` |  | flex 1 | RenderHTMLText |  |
    | Depreciation method | `DepreciationMethod` |  | flex 1 | RenderHTMLText |  |
    | Averaging method | `AveragingMethod` |  | flex 1 | RenderHTMLText |  |
    | Rate | `Rate` |  | flex 1 | renderer() |  |
    | Effective life | `EffectiveLife` |  | flex 1 | renderer() |  |
    | Asset account | `AssetAccountName` |  | flex 1 | Common_COA_TreeMode_RestoreDisplayName |  |
    | Accumulated depreciation account | `AccumulatedDepreciationAccountName` |  | flex 2 | Common_COA_TreeMode_RestoreDisplayName |  |
    | Depreciation expense account | `DepreciationExpenseAccountName` |  | flex 2 | Common_COA_TreeMode_RestoreDisplayName |  |


#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| combo (+ add new) |  | `tdProductName` | `FixedAssetProductsStore` | shows `Name` · value `ProductID` |
| combo |  | `tdLocationName` | `LocationStore` | shows `Description` · value `LocationID` |
| date field |  | `DepreciationStartDate` | `` | placeholder `Choose...` · format `UserDateFormat` |
| date field |  | `PurchaseDate` | `` | placeholder `Choose...` · format `UserDateFormat` |
| combo |  | `tdOpeningBalances_NewCustomer_Currency` | `currencyStore` | shows `Code` · value `Code` |
| combo |  | `tdOpeningBalances_NewSupplier_Currency` | `currencyStore` | shows `Code` · value `Code` |

#### Menus, buttons and other parts

- **component** · renders into `tdFAcmbAssetAccountCode` · store `vChartOfAccountsFixedAssetStore` · shows `DisplayName` · value `Code` · placeholder `Choose...`
- **component** · renders into `tdFAAccumulatedDepreciationAccountCode` · store `vChartOfAccountsFixedAssetStore` · shows `DisplayName` · value `Code` · placeholder `Choose...`
- **component** · renders into `tdFADepreciationExpenseAccountCode` · store `vChartOfAccountsExpenseStore` · shows `DisplayName` · value `Code` · placeholder `Choose...`
- **component**
  - *buttons:*
    - **item**

### `OrderRouting2019`

1 grids · 0 standalone fields · 0 windows · 0 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `OrderRouting_Index_Container` · store `locationStore` · placeholder `You do not have any settings at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Country | `Country` |  | flex 2 | RenderHTMLText |  |
    | State / province | `State` |  | flex 1 | RenderHTMLText |  |
    | City / suburb | `City` |  | flex 1 | RenderHTMLText |  |
    | ZIP / postcode | `ZipPostCode` |  | flex 1 | RenderHTMLText |  |
    | Location | `LocationID` |  | flex 2 | renderer() |  |


### `Product2019`

33 grids · 72 standalone fields · 1 windows · 11 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `divPBom_Versions` · store `window.VersionsBomTempStore` · placeholder `There are no production BOM versions at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Number | `Version` |  | flex 1 | renderer() |  |
    | Name | `Name` |  | flex 1 | renderer() |  |
    | Created | `CreatedDate` |  | flex 1 | renderer() |  |
    | Default | `IsDefault` | check column | 100 | renderer() |  |

- **grid** · renders into `CustomPrices_Container` · store `CustomPricesGridStore` · placeholder `There are no custom prices at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Customer | `CustomerName` |  | flex 1 | renderer() |  |
    | Customer currency | `CurrencyCode` |  | flex 1 | renderer() |  |
    | Latest price | `LatestPrice` |  | flex 1 | renderer() |  |
    | Custom price | `CustomPrice` | number column | flex 1 | renderer() |  |
    | Last sold | `LatestDate` |  | flex 1 | renderer() |  |

- **grid** · renders into `Markup_Container` · store `MarkupGridStore` · placeholder `There are no price tiers at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Price tier | `TierNumber` |  | flex 1 | renderer() |  |
    | Price | `Price` | number column | 100 | renderer() |  |
    | Calculated | `Calculated` | check column | 100 | renderer() |  |
    | Type | `MarkupType` |  | flex 1 | renderer() |  |
    | Use | `UsePriceType` |  | flex 1 | renderer() |  |
    | Value | `MarkupValue` | number column | 100 | renderer() |  |

- **grid** · renders into `MergeProductGridContainer` · store `selectedStore`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    |  | `Name` |  | flex 1 | renderer() |  |

- **grid** · renders into `divMovementLines` · store `vProductMovementStore` · placeholder `You do not have any product movements at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Type | `Type` |  | flex 1 | renderer() |  |
    | Date | `Date` |  | flex 1 | renderer() |  |
    | Task | `Number` |  | flex 1 | renderer() |  |
    | From/to | `FromTo` |  | flex 1 | renderer() |  |
    | Status | `Status` |  | flex 1 |  |  |
    | Location | `Location` |  | flex 1 | renderer() |  |
    | Batch/serial # | `BatchSN` |  | flex 1 | renderer() |  |
    | Expiry date | `ExpiryDate` |  | flex 1 | renderer() |  |
    | Quantity | `Quantity` |  | flex 1 |  |  |
    | Cost | `Amount` |  | flex 1 | renderer() |  |

- **grid** · renders into `divMovementQuantityLines` · store `vProductMovementQuantityStore` · placeholder `You do not have any product movements at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Type | `Type` |  | flex 1 | renderer() |  |
    | Date | `Date` |  | flex 1 | renderer() |  |
    | Task | `Number` |  | flex 1 | renderer() |  |
    | From/To | `FromTo` |  | flex 1 | renderer() |  |
    | Status | `Status` |  | flex 1 |  |  |
    | Location | `Location` |  | flex 1 | renderer() |  |
    | Batch/serial # | `BatchSN` |  | flex 1 | renderer() |  |
    | Expiry date | `ExpiryDate` |  | flex 1 | renderer() |  |
    | Quantity | `Quantity` |  | flex 1 |  |  |

- **grid** · renders into `divMovementQuantityChangesLines` · store `vProductQuantityChangesStore` · placeholder `You do not have any product movements at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Date | `ChangeDate` |  | 135 | renderer() |  |
    | User name | `UserName` |  | flex 1 |  |  |
    | Action | `Action` |  | flex 2 |  |  |
    | Reference | `Reference` |  | flex 1 | renderer() |  |
    | Location | `Location` |  | flex 2 | renderer() |  |
    | Qty moved | `QtyMoved` |  | 85 | renderer() |  |
    | Available qty in stock | `Available` |  | 100 |  |  |
    | Status | `Status` |  | 75 | renderer() |  |

- **grid** · renders into `divUsageLines` · store `vServiceUsageStore` · placeholder `Service has never been used.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Type | `Type` |  | flex 1 | renderer() |  |
    | Date | `Date` |  | flex 1 | renderer() |  |
    | Document number | `Number` |  | flex 1 | renderer() |  |
    | Status | `Status` |  | flex 1 |  |  |
    | Price | `Price` |  | flex 1 | renderer() |  |

- **grid** · renders into `divBOMComponents` · placeholder `You do not have any components in BOM.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `ProductCode` |  | flex 2 | renderer() | total count |
    | Quantity | `Quantity` |  | flex 1 |  | total sum |
    | Wastage % | `WastagePercent` |  | flex 1 |  |  |
    | Wastage quantity | `WastageQuantity` |  | flex 1 |  |  |
    | Disassembly cost % | `CostPercentage` | number column | flex 1 | renderer() | total sum |
    | Cost per unit | `Cost` |  | flex 1 | renderer() |  |
    | Total cost | `TotalCost` |  | flex 1 | renderer() | total sum |

- **grid** · renders into `divBOMServices` · placeholder `You do not have any labor or overheads in BOM.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Labor & overheads | `Name` |  | flex 2 | RenderHTMLText | total count |
    | Quantity | `Quantity` |  | flex 1 |  |  |
    | Expense account | `ExpenseAccount` |  | flex 1 | renderer() |  |
    | Price tier | `PriceTier` |  | flex 1 | renderer() |  |
    | Total cost | `Cost` |  | flex 1 | renderer() | total sum |

- **grid** · renders into `divDiscountLines` · placeholder `You do not have any customer-specific discounts for this product.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Customer | `Customer` |  | flex 1 | RenderHTMLText |  |
    | Customer tag | `CustomerTag` |  | flex 1 | RenderHTMLText · edit: combo |  |
    | Discount | `DiscountName` |  | flex 1 | RenderHTMLText |  |

- **grid** · renders into `divSupplierLines` · placeholder `No suppliers found.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Supplier | `SupplierName` |  | flex 2 | renderer() |  |
    | SKU | `SupplierInventoryCode` |  | flex 1 | renderer() |  |
    | Product name | `SupplierProductName` |  | flex 1 | renderer() |  |
    | Product URL | `URL` |  | flex 1 | renderer() |  |
    | Drop ship | `DropShip` | check column | 80 | renderer() |  |
    | Currency | `Currency` |  | flex 1 |  |  |
    | Latest price | `Cost` |  | flex 1 | renderer() |  |
    | Fixed price | `FixedCost` |  | flex 1 | renderer() |  |
    | Last supplied | `SysDate` |  | flex 1 | renderer() |  |
    | Include in pricing Find out about calculated pricing"> | `IncludeInPricing` | check column | 130 | renderer() |  |

- **grid** · renders into `divLocationLines` · placeholder `No locations found.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Location | `LocationName` |  | flex 1 | renderer() |  |
    | Minimum before reorder | `MinimumBeforeReorder` |  | flex 1 |  |  |
    | Reorder quantity | `ReorderQuantity` |  | flex 1 |  |  |
    | Stock locator | `StockLocator` |  | flex 1 | renderer() |  |
    | Pick zones | `PickZones` |  | flex 1 | renderer() |  |

- **grid** · renders into `divAdditionalUnitOfMeasureLines` · placeholder `You do not have any additional units of measure for this product.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `ProductID` |  | flex 1 | renderer() |  |
    | Unit of measure | `DefaultUnitOfMeasure` |  | flex 1 | renderer() · edit: combo |  |
    | Conversion rate | `ConversionRate` |  | flex 1 | renderer() |  |
    | I am selling this product | `NotSellable` | check column | flex 1 | renderer() |  |
    | Tier 1 | `PriceTear1` |  | flex 1 | renderer() |  |
    | Tier 2 | `PriceTear2` |  | flex 1 | renderer() | hidden |
    | Tier 3 | `PriceTear3` |  | flex 1 | renderer() | hidden |
    | Tier 4 | `PriceTear4` |  | flex 1 | renderer() | hidden |
    | Tier 5 | `PriceTear5` |  | flex 1 | renderer() | hidden |
    | Tier 6 | `PriceTear6` |  | flex 1 | renderer() | hidden |
    | Tier 7 | `PriceTear7` |  | flex 1 | renderer() | hidden |
    | Tier 8 | `PriceTear8` |  | flex 1 | renderer() | hidden |
    | Tier 9 | `PriceTear9` |  | flex 1 | renderer() | hidden |
    | Tier 10 | `PriceTear10` |  | flex 1 | renderer() | hidden |

- **grid** · renders into `Product_Index_Container` · store `mainStore` · placeholder `No products found.`
- **grid** · renders into `CombinedProduct_Index_Container` · store `combinedProductsStore` · placeholder `No products found.`
- **grid** · renders into `divAttachmentList` · store `ImageStore` · placeholder `You do not have any files attached.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Reorder | `` |  | 80 | renderer() |  |
    | No. | `RowOrderNum` |  | 60 | renderer() |  |
    | Mark as default | `isDefault` | check column | 116 | renderer() |  |
    | Img. preview | `ImageID` |  | 100 | renderer() |  |
    | Filename | `FileName` |  | flex 2 | renderer() |  |

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

- **grid** · renders into `divExceptionsContainer` · store `store` · placeholder `Please upload a file to check for issues.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Line # | `Line` |  | 50 |  |  |
    | Action | `Action` |  | 120 | renderer() |  |
    | Product SKU | `ProductSKU` |  | 200 | renderer() |  |
    | Product name | `ProductName` |  | 300 | renderer() |  |
    | Price tier | `PriceTier` |  | 200 | renderer() |  |
    | Type | `MarkupType` |  | 300 | renderer() |  |
    | Use | `UseType` |  | 200 | renderer() |  |
    | Value | `Value` |  | 200 | renderer() |  |

- **grid** · renders into `divExceptionsContainer` · store `store` · placeholder `Please upload a file to check for issues.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Line # | `Line` |  | 50 |  |  |
    | Old product SKU | `CurrentSKU` |  | 200 | renderer() |  |
    | Product SKU | `NewSKU` |  | 200 | renderer() |  |
    | Product name | `Name` |  | flex 1 | renderer() |  |

- **grid** · renders into `divExceptionsContainer` · store `store` · placeholder `Please upload a file to check for issues.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Line # | `Line` |  | 50 |  |  |
    | Action | `Action` |  | flex 1 | renderer() |  |
    | Base SKU | `BaseSKU` |  | flex 1 | renderer() |  |
    | Base product name | `BaseProductName` |  | flex 1 | renderer() |  |
    | Base units of measure | `BaseUnitsOfMeasure` |  | flex 1 | renderer() |  |
    | Additional units of measure SKU | `AdditionalUnitsOfMeasureSKU` |  | flex 1 | renderer() |  |
    | Additional units of measure product name | `AdditionalUnitsOfMeasureProductName` |  | flex 1 | renderer() |  |
    | Additional units of measure name | `AdditionalUnitsOfMeasureName` |  | flex 1 | renderer() |  |
    | Number of base units in additional unit | `NumberOfBaseUnitsInAdditionalUnit` |  | flex 1 | renderer() |  |
    | I am selling this product | `IAmSellingThisProduct` |  | flex 1 | renderer() |  |

- **grid** · renders into `divExceptionsContainer` · store `store`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Line # | `Line` |  | 50 |  |  |
    | Action | `Action` |  |  | renderer() |  |
    | Product SKU | `ProductSKU` |  |  | renderer() |  |
    | Product name | `ProductName` |  | flex 1 | renderer() |  |
    | Customer name | `CustomerName` |  | 200 | renderer() |  |
    | Price | `Price` |  |  | renderer() |  |

- **grid** · renders into `divExceptionsContainer` · store `store`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Line # | `Line` |  | 50 |  |  |
    | Product code | `ProductCode` |  | 100 | renderer() |  |
    | Quantity | `Quantity` |  | 100 | renderer() |  |
    | Average cost | `AverageCost` |  | 100 | renderer() |  |
    | Location | `Location` |  | 100 | renderer() |  |
    | Batch or serial number | `BatchOrSerialNumber` |  | 200 | renderer() |  |
    | Expiry date | `ExpiryDate_YYYYMMDD` |  | 100 | renderer() |  |
    | Received date | `ReceivedDate_YYYYMMDD` |  | 100 | renderer() |  |

- **grid** · renders into `divExceptionsContainer` · store `store` · placeholder `Please upload a file to check for issues.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Line # | `Line` |  | 50 |  |  |
    | Product code | `ProductCode` |  | 150 | renderer() |  |
    | Quantity | `Quantity` |  | 100 | renderer() |  |
    | Average cost | `AverageCost` |  | 100 | renderer() |  |
    | Location | `Location` |  | flex 1 | renderer() |  |
    | Batch or serial number | `BatchOrSerialNumber` |  | 200 | renderer() |  |
    | Received date | `ReceivedDate_YYYYMMDD` |  | 150 | renderer() |  |

- **grid** · renders into `divAlternativProducts` · placeholder `No alternative products found.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `AlternativeProductCode` |  | flex 1 | renderer() |  |
    | Interchangeable | `IsInterchangeable` | check column | 150 | renderer() |  |
    |  | `Matching` |  | 150 | renderer() |  |
    | Use in production | `UseInProduction` | check column | 100 | renderer() |  |
    | Quantity | `Quantity` |  | 110 | renderer() |  |

- **grid** · renders into `Stock_Index_Container` · store `stockStore` · placeholder `You do not have any products matching the specified criteria.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Location | `Location` |  | flex 1 | RenderHTMLText |  |
    | Bin | `Bin` |  | flex 1 | RenderHTMLText |  |
    | Batch/serial # | `BatchSN` |  | flex 1 | RenderHTMLText |  |
    | Expiry date | `ExpiryDate` |  | 100 | renderer() |  |
    | Stock value | `StockOnHand` |  | 100 | renderer() |  |
    | On hand | `OnHand` |  | 90 |  |  |
    | Available | `Available` |  | 90 |  |  |
    | On order | `OnOrder` |  | 90 | renderer() |  |
    | In transit | `InTransit` |  | 80 | renderer() |  |
    | Allocated | `Allocated` |  | 90 | renderer() |  |
    | Next delivery | `NextDeliveryDate` |  | flex 1 | Stock_Index_FormatNextDeliveryDate |  |

- **grid** · renders into `AllocatedGrid_Container` · store `vProductsStockAllocatedStore`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Task no. | `Number` |  | flex 1 | renderer() |  |
    | Customer | `CustomerName` |  | flex 2 | renderer() |  |
    | Quantity | `Quantity` |  | flex 1 |  |  |
    | Date | `Date` | date column | flex 1 | renderer() |  |

- **grid** · renders into `OnOrderGrid_Container` · store `vProductsStockOnOrderStore`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Order | `Number` |  | flex 1 | renderer() |  |
    | Supplier | `SupplierName` |  | flex 2 | renderer() |  |
    | Date | `Date` | date column | flex 1 | renderer() |  |
    | Required by | `RequiredByDate` | date column | flex 1 | renderer() |  |
    | Quantity | `Quantity` |  | flex 1 |  |  |
    | Next delivery | `NextDeliveryDate` | date column | flex 1 | renderer() |  |

- **grid** · renders into `InTransitGrid_Container` · store `vProductsStockInTransitStore`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Order | `Number` |  | flex 1 | renderer() |  |
    | Supplier | `SupplierName` |  | flex 2 | renderer() |  |
    | Date | `Date` | date column | flex 1 | renderer() |  |
    | Required by | `RequiredByDate` | date column | flex 1 | renderer() |  |
    | Quantity | `Quantity` |  | flex 1 |  |  |
    | Next delivery | `NextDeliveryDate` | date column | flex 1 | renderer() |  |
    |  | `` |  | flex 1 | renderer() | hidden |

- **grid** · renders into `divExceptionsContainer` · store `store` · placeholder `Please upload a file to check for issues.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Line # | `Line` |  | 50 |  |  |
    | Action | `Action` |  | 150 | RenderHTMLText |  |
    | Product SKU | `ProductSKU` |  | 250 | renderer() |  |
    | URL | `ImageUrl` |  | 600 | renderer() |  |
    | File name | `ImageFileName` |  | 400 | renderer() |  |

- **grid** · renders into `divLeadSafetyLines` · store `vProductLeadSafetyPagedStore` · placeholder `No suppliers found.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    |  (group: Supplier, Lead, Safety, Reorder quantity, Minimum order quantity) | `` |  |  |  |  |
    | Location set up (group: Location, Lead, Safety, Reorder quantity, ) | `` |  |  |  |  |

- **grid** · renders into `"divMTOProductMapGrid-".concat(…)` · store `item.vMakeToOrderBOMProductMaps(…)` · placeholder `Please add at least one choice, product family or custom element item…`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Choice | `MenuConfigurationID` |  | flex 1 | renderer() |  |
    | Product | `MappedProductCode` |  | flex 1 | renderer() |  |
    | Unit | `MappedProductUnit` |  | 100 | renderer() |  |

- **grid** · renders into `divMakeToOrderConditionsGrid` · store `vMakeToOrderConditionsStore` · placeholder `There are no conditions added.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Condition item | `RelatedMenuConfigurationID` |  | flex 1 | renderer() |  |
    | Condition | `Condition` |  | flex 1 | renderer() |  |


#### Windows and dialogs

- **window** “Add a new product category” · layout fit

#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| combo |  | `cmbPBomVersion` | `PBomVersionStore` | shows `DisplayName` · value `BomID` · pick-only |
| number field |  | `liOutputQuantity` | `` |  |
| text field |  | `Product_Index_ProductionInstructionURL` | `` |  |
| number field |  | `liManufacturingBufferTime` | `` |  |
| combo |  | `liManufacturingDeliveryTo` | `vTenantLocationLoadStore` | shows `Description` · value `LocationID` · placeholder `Choose...` |
| checkbox |  | `liIgnoreCumulativeLeadTime` | `` |  |
| checkbox |  | `divProductTracing` | `` |  |
| number field |  | `liComponentProductionLeadTime` | `` |  |
| combo |  | `cmb_ProductionIssueMethod` | `IssueMethodTypesStore` | shows `name` · value `value` · pick-only |
| combo |  | `cmb_BackflushDefinedFor` | `BackflushDefinedForStore` | shows `name` · value `value` · pick-only |
| number field |  | `liManufacturingMinQuantity` | `` |  |
| number field |  | `liManufacturingMaxQuantity` | `` |  |
| number field |  | `liManufacturingDeviationPercent` | `` |  |
| number field |  | `liManufacturingRunSize` | `` |  |
| combo |  | `cmbFinishedProductCost` | `CostCalculationsTypesStore` | shows `name` · value `value` · pick-only |
| combo |  | `cmbCopyBom` | `vProductionBomProductsCopyStore` | shows `Description` · value `BomID` · placeholder `Select another BOM to copy` |
| combo |  | `Product_Index_BulkComponentUpdateInBOMs_OldCompon…` | `vProductListBOMOldComponentStore` | shows `CodeWithName` · value `ProductID` · placeholder `Select old component` |
| combo |  | `Product_Index_BulkComponentUpdateInBOMs_NewCompon…` | `vProductListBOMNewComponentStore` | shows `CodeWithName` · value `ProductID` · placeholder `Select new component` |
| combo |  | `Product_Channels_PublishingProfiles` | `vPublishingProfileStore` | shows `Name` · value `Id` · pick-only |
| combo |  | `Product_Index_Type` | `ProductTypeStore` | shows `name` · value `value` · pick-only |
| combo (+ add new) |  | `Product_Index_FixedAssetType` | `vProductFixedAssetTypeStore` | shows `Name` · value `FixedAssetTypeID` |
| combo (+ add new) |  | `Product_Index_Category` | `vTenantInventoryCategoryStore` | shows `Category` · value `CategoryID` |
| combo (+ add new) |  | `Product_Index_Brand` | `vTenantBrandStore` | shows `Brand` · value `ID` |
| combo (+ add new) |  | `Product_Index_DefaultUnitOfMeasure` | `vTenantUnitOfMeasureStore` | shows `Unit` · value `UnitOfMeasureID` |
| combo |  | `Product_Index_DropShipMode` | `DropShipModeStore` | shows `DisplayName` · value `DropShipMode` · pick-only |
| combo |  | `Product_Index_BillOfMaterial` | `BomTypeStore` | shows `name` · value `value` · pick-only |
| combo |  | `Product_Index_InventoryAccount` | `InventoryAccountsStore` | shows `DisplayName` · value `Code` |
| combo |  | `Product_Index_RevenueAccount` | `RevenueAccountsStore` | shows `DisplayName` · value `Code` |
| combo |  | `Product_Index_ExpenseAccount` | `vChartOfAccountsStore` | shows `DisplayName` · value `Code` |
| combo |  | `Product_Index_COGSAccount` | `vChartOfAccountsStore` | shows `DisplayName` · value `Code` |
| combo |  | `Product_Index_PurchaseTaxRule` | `PurchaseTaxRuleStore` | shows `Description` · value `RuleID` |
| combo |  | `Product_Index_SaleTaxRule` | `SaleTaxRuleStore` | shows `Description` · value `RuleID` |
| combo |  | `Product_Index_Discount` | `vDiscountStore` | shows `Name` · value `ID` |
| combo |  | `Product_Index_WarrantySetup` | `vWarrantySetupStore` | shows `Name` · value `ID` |
| combo |  | `Product_Index_CountryOfOrigin` | `vCountryOfOriginStore` | shows `Name` · value `Code` · placeholder `Not defined` |
| combo |  | `Product_Index_Status` | `StatusStore` | shows `Name` · value `Value` · pick-only |
| combo (+ add new) |  | `Product_Index_DefaultLocation` | `vTenantLocationLoadStore` | shows `Description` · value `LocationID` |
| combo |  | `Product_Index_ProductAttributeSet` | `AttributeSetStore` | shows `Name` · value `SetID` · pick-only |
| combo |  | `Product_Index_NotSellable` | `NotSellableTypesStore` | shows `name` · value `value` |
| text field |  | `Product_Index_AssemblyInstructionURL` | `` |  |
| checkbox |  | `liAutoAssembly` | `` |  |
| checkbox |  | `liAutoDisassembly` | `` |  |
| combo |  | `liCostType` | `window.CostTypeStore` | shows `CostTypeName` · value `CostType` · pick-only |
| number field |  | `liQuantityToProduce` | `` |  |
| combo |  | `divMovementType` | `MovementTypeStore` | shows `name` · value `value` · pick-only |
| combo |  | `divMovementChanel` | `MovementChanelStore` | shows `name` · value `value` · pick-only |
| combo |  | `divMovementAction` | `MovementActionStore` | shows `name` · value `value` · pick-only |
| combo |  | `divNewProduct_AdditionalUnitOfMeasureUnitOfMeasure` | `vTenantUnitOfMeasureStore` | shows `Unit` · value `UnitOfMeasureID` |
| combo |  | `Product_Index_WeightUnits` | `MeasurementWeightStore` | shows `UoMName` · value `UoMAbbr` · pick-only |
| combo |  | `Product_Index_DimensionUnits` | `MeasurementDimensionsStore` | shows `UoMName` · value `UoMAbbr` · pick-only |
| combo |  | `AdditionalDescriptionsSelect` | `pProductAdditionalDescriptionsStore` | shows `ShopName` · value `SIMProductID` · pick-only |
| text field |  | `tdProduct_NewFixedAssetType_Category` | `` |  |
| date field |  | `"dtSupplyIntervalDate".concat(…)` | `` | placeholder `Select date` · format `UserDateFormat` |
| date field |  | `divCostingMethodModal_ExpiryDate` | `` | placeholder `Choose...` · format `UserDateFormat` |
| text field |  | `renderTo` | `` |  |
| checkbox |  | `renderTo` | `` |  |
| numeric field |  | `renderTo` | `` |  |
| date field |  | `renderTo` | `` | placeholder `Choose...` · format `UserDateFormat` |
| number field |  | `liMakeToOrderOutputQuantity` | `` |  |
| text field |  | `Product_Index_MakeToOrderInstructionURL` | `` |  |
| number field |  | `liMakeToOrderManufacturingBufferTime` | `` |  |
| checkbox |  | `liMakeToOrderIgnoreCumulativeLeadTime` | `` |  |
| combo |  | `liMakeToOrderManufacturingDeliveryTo` | `vTenantLocationLoadStore` | shows `Description` · value `LocationID` · placeholder `Choose...` |
| number field |  | `liMakeToOrderComponentProductionLeadTime` | `` |  |
| combo |  | `cmb_MakeToOrderIssueMethod` | `window.IssueMethodTypesStore` | shows `name` · value `value` · pick-only |
| combo |  | `cmbMakeToOrderFinishedProductCost` | `window.CostCalculationsTypesStore` | shows `name` · value `value` · pick-only |
| combo |  | `cmbMakeToOrderCopyBom` | `vProductionBomProductsCopyStore` | shows `Description` · value `BomID` · placeholder `Select another BOM to copy` |
| combo |  | `"divMTOConfigTemplate-".concat(…)` | `vMakeToOrderConfigTemplatesStore` | shows `TemplateName` · value `TemplateID` · pick-only |
| combo |  | `"divMTOConfigMenuItem-".concat(…)` | `vMakeToOrderConfigMenuItemsStore` | shows `Name` · value `MenuConfigurationID` · pick-only |
| combo |  | `divId` | `window[optionStoreName]` | shows `Name` · value `MenuConfigurationID` · pick-only |
| combo |  | `divMakeToOrderConditionalVisibility` | `vMakeToOrderVisibilityOptionsStore` | shows `Label` · value `Value` · placeholder `Choose...` · pick-only |
| combo |  | `divMakeToOrderJoinCondition` | `vMakeToOrderJoinConditionsStore` | shows `Label` · value `Value` · placeholder `Choose...` · pick-only |

#### Menus, buttons and other parts

- **column** · placeholder `You do not have any components yet.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Type | `Type` |  | flex 1 | renderer() |  |
    | Component | `Value` |  | flex 1 | renderer() |  |
    |  | `CostCalculationType` |  | flex 1 | renderer() |  |
    | Backflush | `IsBackflush` | check column | 100 | renderer() | hidden |
    | Quantity | `Quantity` |  | flex 1 | renderer() |  |
    | Unit | `Unit` |  | flex 1 | renderer() |  |
    | Wastage % | `WastagePercent` |  | flex 1 | renderer() |  |
    |  | `WastageQty` |  | flex 1 | renderer() |  |
    | Sales price | `SalePriceTier` |  | flex 1 | renderer() |  |
    | Cost per unit | `Cost` |  | flex 1 | renderer() |  |
    | Total cost | `TotalCost` |  | flex 1 | renderer() |  |

- **column**
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Sequence | `Order` |  | 75 | renderer() |  |
    | Previous step | `OperationRelationIDsFake` |  | 75 | renderer() |  |
    | Type | `OperationType` |  | flex 1 | renderer() |  |
    | Operation | `Name` |  | flex 1 | renderer() |  |
    | Backflush | `IsBackflush` | check column | flex 1 | renderer() | hidden |
    | Cycle time | `CycleTimeString` |  | 90 | renderer() |  |
    | Units per cycle | `UnitsPerCycle` |  | flex 1 | renderer() |  |
    | Work center | `WorkCenterID` |  | flex 1 | renderer() |  |
    |  | `IsDropShip` | check column | 100 | renderer() |  |
    | Total cost | `TotalCost` |  | flex 1 | renderer() |  |

- **column** · store `OperationProductsStore` · placeholder `You do not have any finished products yet.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `ProductSku` |  | flex 2 | renderer() |  |
    | Unit of measure | `Unit` |  | 100 | renderer() |  |
    | Sales Value | `PriceTier` | number column | flex 1 | renderer() |  |
    | Sales Value per unit | `Ratio` | number column | flex 1 | renderer() |  |
    | Estimated cost per unit | `Cost` | number column | flex 1 | renderer() |  |
    | Estimated total cost | `TotalCost` | number column | flex 1 | renderer() |  |
    | Delivery to | `DeliveryTo` |  | flex 1 | renderer() |  |

- **column** · store `WastageProductsStore` · placeholder `You do not have any finished products or input/output components yet.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `ProductSku` |  | flex 2 | renderer() |  |
    | Fixed price | `WastageCost` | number column | flex 1 | renderer() |  |
    | Cost per unit | `WastageCost` | number column | flex 1 | renderer() |  |

- **MovementTypeModel** · name `Show availability changes`
- **MovementTypeModel** · name `Show quantity movements`
- **MovementTypeModel** · name `Show quantity and cost movements`
- **form** · renders into `Ext.getBody(…)`
- **component** · id `cmpId` · renders into `renderTo` · store `localStore` · shows `name` · value `value` · placeholder `Choose...` · pick-only
- **column** “{attrSet.name}” · field `"CustomField".concat(…)`
- **column** · store `OperationProductsStore` · placeholder `You do not have any finished products yet.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `ProductSku` |  | flex 2 | renderer() |  |
    | Unit of measure | `Unit` |  | 100 | renderer() |  |
    | Sales Value | `PriceTier` | number column | flex 1 | renderer() |  |
    | Sales Value per unit | `Ratio` | number column | flex 1 | renderer() |  |
    | Estimated cost per unit | `Cost` | number column | flex 1 | renderer() |  |
    | Estimated total cost | `TotalCost` | number column | flex 1 | renderer() |  |
    | Delivery to | `DeliveryTo` |  | flex 1 | renderer() |  |


### `RMAReasonForReturn2019`

1 grids · 0 standalone fields · 0 windows · 0 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `RMAReasonForReturn_Index_Container` · store `store` · placeholder `You do not have any return reasons at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Name | `Name` |  | flex 1 | RenderHTMLText |  |


### `RMAReturnOrderSettings2019`

0 grids · 4 standalone fields · 0 windows · 0 menus, buttons and other parts · 0 custom components

#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| combo |  | `ReturnPolicyReceiptsLocation` | `vLocationStore` | shows `Description` · value `LocationID` · placeholder `Choose...` · pick-only |
| combo |  | `NoWarrantyExpenseAccount` | `expenseAccountStore` | shows `DisplayName` · value `Code` · placeholder `Choose...` · pick-only |
| combo |  | `WarrantyExpenseAccount` | `expenseAccountStore` | shows `DisplayName` · value `Code` · placeholder `Choose...` · pick-only |
| combo |  | `ScrapWriteOffDefaultExpenseAccount` | `expenseAccountStore` | shows `DisplayName` · value `Code` · placeholder `Choose...` · pick-only |

### `RMAReturnPolicy2019`

2 grids · 5 standalone fields · 0 windows · 0 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `RMAReturnPolicy_Index_Container` · store `gridStore` · placeholder `You do not have any return policies at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Name | `Name` |  | flex 3 | RenderHTMLText |  |
    | Created | `CreatedDate` |  | flex 3 | renderer() |  |
    | Updated | `UpdatedDate` |  | flex 3 | renderer() |  |
    | Active | `IsActive` |  | flex 3 | renderer() |  |

- **grid** · renders into `RMAMilestones_Index_Container` · placeholder `You do not have any RMA processing milestones at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Sequential number | `Number` |  | flex 1 | RenderHTMLText |  |
    | Milestone | `Name` |  | flex 3 | RenderHTMLText |  |
    | Description for customer invoice | `RMACostTypeID` |  | flex 2 | renderer() |  |
    | Charged to | `ChargedTo` |  | flex 2 | RenderHTMLText |  |


#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| combo |  | `tdRMAReturnPolicy_Index_Countries` | `сountryStore` | shows `Name` · value `Code` · placeholder `Select country` |
| combo |  | `tdRMAReturnPolicy_Index_Categories` | `categoryStore` | shows `Name` · value `ID` · placeholder `Select category` |
| combo |  | `tdRMAReturnPolicy_Index_Families` | `familyStore` | shows `Name` · value `ID` · placeholder `Select family` |
| combo |  | `tdRMAReturnPolicy_Index_Brands` | `brandStore` | shows `Name` · value `ID` · placeholder `Select brand` |
| combo |  | `tdRMAReturnPolicy_Index_Tags` | `tagStore` | shows `Value` · value `Value` · placeholder `Select tag` |

### `TenantAddress2019`

1 grids · 0 standalone fields · 0 windows · 0 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `TenantAddress_Index_Container` · store `store` · placeholder `You do not have any addresses at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    |  | `` |  | flex 1 | renderer() | hidden |
    | Line 1 | `Line1` |  | flex 3 | RenderHTMLText |  |
    | Line 2 | `Line2` |  | flex 3 | RenderHTMLText |  |
    | City / suburb | `CitySuburb` |  | flex 2 | RenderHTMLText |  |
    | State / province | `StateProvince` |  | flex 2 | RenderHTMLText |  |
    | ZIP / postcode | `ZipPostCode` |  | flex 2 | RenderHTMLText |  |
    | Country | `Country` |  | flex 2 | RenderHTMLText |  |
    | Type | `Type` |  | 90 | renderer() |  |
    | Default | `DefaultForType` | check column | 80 | renderer() |  |


### `TenantAttributeSet2019`

1 grids · 0 standalone fields · 0 windows · 0 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `TenantAttributeSet_Index_Container` · store `store` · placeholder `You do not have any attribute sets at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Name | `Name` |  | flex 1 | renderer() |  |


### `TenantBrands2019`

1 grids · 0 standalone fields · 0 windows · 0 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `TenantBrand_Index_Container` · store `store` · placeholder `You do not have any brands at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Brand | `Brand` |  | flex 1 | RenderHTMLText |  |


### `TenantCarriers2019`

1 grids · 0 standalone fields · 0 windows · 0 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `TenantCarrier_Index_Container` · store `store` · placeholder `You do not have any carriers at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Carrier name | `Description` |  | flex 1 | RenderHTMLText |  |
    | Tracking URL | `TrackingURL` |  | flex 1 | renderer() |  |


### `TenantContact2019`

1 grids · 2 standalone fields · 0 windows · 0 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `TenantContact_Index_Container` · store `store` · placeholder `You do not have any contacts at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    |  | `` |  | flex 1 | renderer() | hidden |
    | Name | `Name` |  | flex 3 | RenderHTMLText |  |
    | Phone | `Phone` |  | flex 1 | RenderHTMLText |  |
    | Fax | `Fax` |  | flex 1 | RenderHTMLText |  |
    | Email | `Email` |  | flex 2 | RenderHTMLText |  |
    | Website | `Website` |  | flex 1 | RenderHTMLText |  |
    | Mailing lists | `MailingListsEdit` |  | flex 2 | renderer() |  |
    | Sales Commission % | `SalesCommission` | number column | 140 | renderer() |  |
    | Type | `Type` |  | flex 1 |  |  |
    | Default | `DefaultForType` | check column | 80 | renderer() |  |


#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| combo |  | `divReassignFromContact` | `ReassignFromContactStore` | shows `Name` · value `ContactID` · placeholder `type to search...` |
| combo |  | `divReassignToContact` | `ReassignToContactStore` | shows `Name` · value `ContactID` · placeholder `type to search...` |

### `TenantInventoryCategory2019`

1 grids · 0 standalone fields · 0 windows · 0 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `TenantInventoryCategory_Index_Container` · store `store` · placeholder `You do not have any inventory categories at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Category | `Category` |  | flex 1 | RenderHTMLText |  |


### `TenantLocation2019`

2 grids · 0 standalone fields · 0 windows · 0 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `TenantLocation_Index_Container` · store `store` · placeholder `You do not have any locations at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Location | `Description` |  | flex 1 | renderer() |  |
    | Location type | `LocationType` |  | flex 1 | renderer() |  |
    | Default | `IsDefault` | check column | 90 | renderer() |  |
    | Deprecated | `IsDeprecated` | check column | 90 | renderer() |  |

- **grid** · renders into `TenantLocation_Index_LogisticsPaths` · store `storeLogisticsPaths` · placeholder `You do not have any logistics paths.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Components | `WarehouseLocationID` |  | flex 1 | renderer() |  |
    | Shop floor | `ShopFloorLocationID` |  | flex 1 | renderer() |  |
    | Demand | `RetailLocationID` |  | flex 1 | renderer() |  |


### `TenantLocationEdit`

8 grids · 5 standalone fields · 0 windows · 0 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `divGridPutAwayRules` · store `store` · placeholder `You do not have any put away rules in the selected location at the mo…`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Put away rule | `Name` |  | flex 1 | RenderHTMLText |  |
    | Bin | `Bins` |  | flex 1 | renderer() |  |
    |  | `` |  | 120 | renderer() |  |
    | Status | `IsActive` |  | 120 | renderer() |  |

- **grid** · renders into `divGridBinGroups` · store `store` · placeholder `You do not have any bin groups in the selected location at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Bin group | `Name` |  | flex 1 | RenderHTMLText |  |
    | Bins | `Bins` |  | flex 1 | renderer() |  |

- **grid** · renders into `divGridBins` · store `store` · placeholder `You do not have any bins in the selected location at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Bin description | `Description` |  | flex 1 | RenderHTMLText |  |
    | Bin group | `BinGroupID` |  | flex 1 | renderer() |  |
    | Rule | `PutAwayRuleIDsFake` |  | flex 1 | renderer() |  |
    | Work center | `WorkCenterIDsFake` |  | flex 1 | renderer() |  |
    |  | `IsStaging` | check column | 90 | renderer() |  |
    | Deprecated | `IsDeprecated` | check column | 90 | renderer() |  |

- **grid** · renders into `divGridPickZones` · store `store` · placeholder `You do not have any pick zones in the selected location at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Pick zone name | `value` |  | flex 1 | RenderHTMLText |  |

- **grid** · renders into `divGridRules` · store `store` · placeholder `You do not have any supply rules in the selected location at the mome…`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Supply rule | `Name` |  | flex 1 | RenderHTMLText |  |
    |  | `` |  | 120 | renderer() |  |
    | Status | `IsActive` |  | 120 | renderer() |  |

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


#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| combo |  | `divBinSuggestionPriority` | `binSuggestionStore` | shows `name` · value `value` · placeholder `Choose...` |
| combo |  | `cmbTenantLocationAddressCountry` | `countryStore` | shows `Name` · value `Name` · placeholder `Choose...` |
| date field |  | `"dtSupplyIntervalDate".concat(…)` | `` | placeholder `Select date` · format `UserDateFormat` |
| combo |  | `weekStartCmb` | `WeekDaysStore` | shows `name` · value `value` |
| multi-select combo |  | `weekEndsCmb` | `WeekDaysStore` | shows `name` · value `value` |

### `TenantPaymentTerm2019`

1 grids · 0 standalone fields · 0 windows · 0 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `TenantPaymentTerm_Index_Container` · store `store` · placeholder `You do not have any payment terms at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    |  | `` |  | flex 1 | renderer() | hidden |
    | Description | `Name` |  | flex 1 | RenderHTMLText |  |
    | Method | `Method` |  | flex 1 | renderer() |  |
    | Duration (days) | `Days` |  | flex 1 | renderer() |  |
    | Is default | `IsDefault` | check column | 90 | renderer() |  |
    | Is active | `IsActive` | check column | 90 | renderer() |  |


### `TenantShippingZones2019`

4 grids · 0 standalone fields · 0 windows · 0 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `divPriceGrid` · store `vPriceRatesStore` · placeholder `Add rates based on the total of ordered items.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Description | `ConditionDescription` |  | flex 2 |  |  |
    | Min total | `MinValue` |  | flex 1 | renderer() |  |
    | Max total | `MaxValue` |  | flex 1 | renderer() |  |
    | Rate | `ShippingCost` |  | flex 1 | renderer() |  |

- **grid** · renders into `divWeightGrid` · store `vWeightRatesStore` · placeholder `Add rates based on the weight of ordered items.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Description | `ConditionDescription` |  | flex 2 |  |  |
    | Min weight | `MinValue` |  | flex 1 | renderer() |  |
    | Max weight | `MaxValue` |  | flex 1 | renderer() |  |
    | Rate | `ShippingCost` |  | flex 1 | renderer() |  |

- **grid** · renders into `divZoneCountries` · store `vShipZoneApplyToStore` · placeholder `[:There are no any items.]:]`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Country | `Country2` |  | flex 1 | renderer() |  |
    | State | `StateID` |  | flex 1 | renderer() |  |
    | Zip Code From \| Postcode from | `PostCodeFrom` |  | flex 1 | RenderHTMLText |  |
    | Zip Code To \| Postcode to | `PostCodeTo` |  | flex 1 | RenderHTMLText |  |
    | Zip Codes list \| Postcodes list | `PostCodesList` |  | flex 1 | RenderHTMLText |  |
    | Shipping rate | `ShippingRate` |  | flex 1 | renderer() |  |

- **grid** · renders into `ShipZone_EditCountry_StateList` · store `countryRegionStore`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    |  | `Selected` | check column | 28 | renderer() |  |
    | State / province | `RegionName` |  | flex 1 | RenderHTMLText |  |


### `TenantTaxationRule2019`

2 grids · 0 standalone fields · 0 windows · 3 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `TenantTaxationRule_Index_Container` · store `store` · placeholder `You do not have any tax rules at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Name | `Description` |  | flex 1 | renderer() |  |
    | Status | `IsActive` |  | flex 1 | renderer() |  |

- **grid** · renders into `cntComponents` · placeholder `Click the 'Component' button to add a new line`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Tax component name | `Name` |  | flex 2 | renderer() | total text |
    | Rate | `Percent` |  | flex 2 | renderer() | total sum |
    |  | `Compound` | check column | flex 4 | renderer() | total text |
    | Liability account | `AccountCode` |  | flex 4 | renderer() |  |


#### Menus, buttons and other parts

- **component**
  - *buttons:*
    - **item**
- **component** · renders into `ComponentDetails_LiabilityAccount` · store `vChartOfAccountsStore` · shows `DisplayName` · value `Code` · placeholder `Choose...`
- **component** · renders into `tdAccountCode` · store `vChartOfAccountsStore` · shows `DisplayName` · value `Code` · placeholder `Choose...`

### `TenantUnitOfMeasure2019`

1 grids · 0 standalone fields · 0 windows · 0 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `TenantUnitOfMeasure_Index_Container` · store `store` · placeholder `You do not have any units of measure at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Unit name | `Unit` |  | flex 1 | RenderHTMLText |  |


### `WarrantiySetupList2019`

1 grids · 1 standalone fields · 0 windows · 0 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `WarrantySetupList_Index_Container` · store `mainStore` · placeholder `You do not have any warranties at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Name | `Name` |  | flex 1 | renderer() |  |
    | Start date | `CalculationStartDate` |  | flex 1 | renderer() |  |
    | Terms | `TermsType` |  | flex 1 | renderer() |  |
    | Active | `IsActive` |  |  | renderer() |  |


#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| combo |  | `divFilter` | `FilterStore` | shows `name` · value `Value` · pick-only |

