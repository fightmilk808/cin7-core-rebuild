# Financials: UI

Every component the page code builds, read from the shipped ExtJS bundles: grids with their columns, fields, buttons, menus, windows and custom components. Labels are the English UI text. `renders into` is the id of the `<div>` in the page's server-rendered HTML that the component mounts in; `store` names the data store (see the endpoints in [README.md](README.md)); `on click` is the handler. Visual system and shell layout: [docs/UI.md](../../docs/UI.md).

## Screens

| Route | Title | Bundles |
|---|---|---|
| `/BankAccount` | Bank accounts | [`BankAccounts2019`](#bankaccounts2019) |
| `/BankRule` | Bank rules | [`BankRule2019`](#bankrule2019) |
| `/BankStatement` | Bank accounts | [`BankAccounts2019`](#bankaccounts2019) |
| `/Cin7Capital` | Cin7 Capital | [`Cin7Capital2019`](#cin7capital2019) |
| `/Cin7Pay` | Cin7 Pay | [`Cin7Pay2019`](#cin7pay2019) |
| `/Depreciation` | Depreciations | [`Depreciations2019`](#depreciations2019) |
| `/ExpenseClaim` | Expense claim | [`ExpenseClaim2019`](#expenseclaim2019) |
| `/ExpenseClaimList` | Expense claims | [`ExpenseClaimList2019`](#expenseclaimlist2019) |
| `/ExpenseClaimReceipt` | Expense claim receipt | [`ExpenseClaimReceipt2019`](#expenseclaimreceipt2019) |
| `/ExpenseClaimReceiptList` | Expense claims - Receipts | [`ExpenseClaimReceiptList2019`](#expenseclaimreceiptlist2019) |
| `/FixedAsset` | Fixed assets | [`FixedAsset2019`](#fixedasset2019) |
| `/Journal` | Journal | [`Journal2019`](#journal2019) |
| `/JournalList` | Journals | [`JournalList2019`](#journallist2019) |
| `/MoneyTask/Receive` | Receive money | [`MoneyTaskReceive2019`](#moneytaskreceive2019) |
| `/MoneyTask/Spend` | Spend money | [`MoneyTaskSpend2019`](#moneytaskspend2019) |
| `/MoneyTask/Transfer` | Transfer money | [`MoneyTaskTransfer2019`](#moneytasktransfer2019) |
| `/MoneyTaskList` | Money operations | [`MoneyTaskList2019`](#moneytasklist2019) |

## Components by bundle

### `BankAccounts2019`

0 grids · 1 standalone fields · 0 windows · 0 menus, buttons and other parts · 0 custom components

#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| combo |  | `tdBankAccounts_Bank_Status` | `vAccountStatusCodeStore` | shows `Name` · value `Value` · pick-only |

### `BankRule2019`

4 grids · 26 standalone fields · 0 windows · 0 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `ruleGridContainer` · store `BankRuleListStore` · placeholder `No rules to show for the selected filter.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Rule name | `RuleName` |  | flex 5 | renderer() |  |
    | Run on... | `AccountCode` |  | flex 2 | renderer() |  |
    | Rule type | `RuleType` |  | flex 1 | renderer() |  |
    | Priority | `Priority` |  | flex 1 | renderer() |  |
    | Status | `Active` |  | flex 1 | renderer() |  |

- **grid** · renders into `divBankRuleConditions` · store `vConditionStore` · placeholder `No conditions. Please create a condition.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Field | `Field` |  | flex 2 | renderer() |  |
    | Condition | `Condition` |  | flex 2 | renderer() |  |
    | Expected value | `Expected` |  | flex 4 | renderer() |  |

- **grid** · renders into `divBankRuleFixedLines` · store `vFixedBankRuleLineStore` · placeholder `No fixed value line items.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Description | `Name` |  | flex 4 | renderer() |  |
    | Account | `AccountCode` |  | flex 4 | renderer() |  |
    | Tax rule | `TaxRule` |  | flex 3 | renderer() |  |
    | Amount | `Amount` |  | flex 1 | renderer() |  |

- **grid** · renders into `divBankRuleRelativeLines` · store `vRelativeBankRuleLineStore` · placeholder `No ratio value line items.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Description | `Name` |  | flex 4 | renderer() |  |
    | Account | `AccountCode` |  | flex 4 | renderer() |  |
    | Tax rule | `TaxRule` |  | flex 3 | renderer() |  |
    | Percent | `Amount` |  | flex 1 | renderer() |  |


#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| text field |  | `divBankRuleName` | `` |  |
| combo |  | `divBankRuleTarget` | `vBankRuleAccountMappingStore` | shows `AccountName` · value `AccountID` · placeholder `Target account` · pick-only |
| combo |  | `divBankRulePriority` | `vBankRulePriorityStore` | shows `Name` · value `Value` · placeholder `Choose...` · pick-only |
| combo |  | `divBankRuleContitionType` | `vBankRuleContitionTypeStore` | shows `Name` · value `Value` · placeholder `Choose...` · pick-only |
| combo (+ add new) |  | `divBankRuleContact` | `vBankRuleCustomerWithSuppliers` | shows `Name` · value `ID` · placeholder `Entered during reconciliation...` |
| combo |  | `divBankRuleReference` | `TextFieldsStore` | shows `description` · value `name` · pick-only |
| text field |  | `divNewCustomerName` | `` |  |
| combo |  | `divNewCustomerPaymentTerm` | `vTenantPaymentTermStore` | shows `Name` · value `TermID` · placeholder `Choose...` |
| combo |  | `divNewCustomerSaleAccount` | `vChartOfAccountsLinesStore` | shows `DisplayName` · value `Code` · placeholder `Choose...` |
| combo |  | `divNewCustomerSalesRep` | `vTenantContactsStore` | shows `Name` · value `ContactID` · placeholder `Choose...` |
| combo |  | `divNewCustomerDefaultLocation` | `vTenantLocationStore` | shows `Description` · value `LocationID` · placeholder `Choose...` |
| text field |  | `divNewCustomerDiscount` | `` |  |
| combo |  | `divNewCustomerCurreny` | `currencyStore` | shows `Code` · value `Code` |
| combo |  | `divNewCustomerAccountReceivable` | `vChartOfAccountsNewCustomerStore` | shows `DisplayName` · value `Code` · placeholder `Choose...` |
| combo |  | `divNewCustomerTaxRule` | `vTenantTaxationRuleStore` | shows `Description` · value `RuleID` · placeholder `Choose...` |
| combo |  | `divNewCustomerDefaultCarrier` | `vTenantCarrierStore` | shows `Description` · value `CarrierID` · placeholder `Choose...` |
| text field |  | `divNewCustomerTaxNumber` | `` |  |
| combo |  | `divNewCustomerSalePriceTier` | `vSalesPriceTiersStore` | shows `Name` · value `Code` · placeholder `Choose...` |
| text field |  | `divNewSupplierName` | `` |  |
| combo |  | `divNewSupplierCurreny` | `currencyStore` | shows `Code` · value `Code` |
| combo |  | `divNewSupplierTaxRule` | `vTenantTaxationRuleStore` | shows `Description` · value `RuleID` · placeholder `Choose...` |
| combo |  | `divNewSupplierPaymentTerm` | `vTenantPaymentTermStore` | shows `Name` · value `TermID` · placeholder `Choose...` |
| text field |  | `divNewSupplierDiscount` | `` |  |
| combo |  | `divNewSupplierAccountPayable` | `vChartOfAccountsNewSupplierStore` | shows `DisplayName` · value `Code` · placeholder `Choose...` |
| combo |  | `divNewSupplierDefaultCarrier` | `vTenantCarrierStore` | shows `Description` · value `CarrierID` · placeholder `Choose...` |
| text field |  | `divNewSupplierTaxNumber` | `` |  |

### `Cin7Pay2019`

4 grids · 20 standalone fields · 0 windows · 10 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `divGridCardOnFileCustomers` · store `vCin7PayCardOnFileCustomerStore` · placeholder `No customers found`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    |  | `Expand` |  | 58 | renderer() |  |
    | Customer | `Name` |  | flex 1 | RenderHTMLText |  |
    | Payment methods | `CustomerID` |  | flex 1 | renderer() |  |
    |  | `CustomerID` |  | flex 1 | renderer() |  |

- **grid** · renders into `divUnlinkedCin7PayCustomers_Container` · store `vCardOnFileUnlinkedStripeCustomerStore` · placeholder `No unlinked customers`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Cin7 Pay Customer | `Name` |  | flex 1 | renderer() |  |
    | Core Customer | `CustomerID` |  | flex 1 | renderer() |  |
    |  | `` |  | flex 0.1 | renderer() |  |

- **grid** · renders into `divGridSurcharges` · store `vSurchargeStore` · placeholder `No surcharges`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Payment method | `PaymentMethod` |  | flex 1 | renderer() · edit: combo |  |
    | Type | `Type` |  | flex 1 |  |  |
    | Fixed | `FlatAmount` |  | flex 1 | renderer() · edit: number field |  |
    | Variable % | `Rate` | number column | flex 1 | renderer() · edit: number field |  |
    | Max | `MaxAmount` |  | flex 1 | renderer() · edit: number field |  |
    |  | `PaymentMethod` |  | flex 1 | renderer() |  |

- **grid** · renders into `divGridBulkPayment` · store `store`

#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| checkbox |  | `Cin7Pay_Index_B2BPay` | `` |  |
| checkbox |  | `Cin7Pay_Index_PayByInvoice` | `` |  |
| checkbox |  | `Cin7Pay_Index_PayWithSales` | `` |  |
| checkbox |  | `Cin7Pay_Index_AgreeCardOnFile` | `` |  |
| checkbox |  | `Cin7Pay_Index_AgreeSurcharge` | `` |  |
| checkbox |  | `Cin7Pay_Index_ChkMerchantReceiptNotification` | `` |  |
| checkbox |  | `Cin7Pay_Index_ChkCustomerReceiptNotification` | `` |  |
| checkbox |  | `Cin7Pay_Index_ChkMerchantRefundNotification` | `` |  |
| combo |  | `Cin7Pay_Index_AccuralAccount` | `AccrualAccountsStore` | shows `DisplayName` · value `Code` |
| combo |  | `Cin7Pay_Index_BankAccount` | `BankAccountsStore` | shows `DisplayName` · value `Code` |
| combo |  | `Cin7Pay_Index_PaymentFeeAccount` | `PaymentsFeeAccountStore` | shows `DisplayName` · value `Code` |
| combo |  | `Cin7Pay_Index_SurchargeAccount` | `SurchargeAccountsStore` | shows `DisplayName` · value `Code` |
| combo |  | `Cin7Pay_Index_LoanLiabilityAccount` | `LoanLiabilityAccountsStore` | shows `DisplayName` · value `Code` |
| combo |  | `Cin7Pay_Index_FinancingFeeAccount` | `FinancingFeeAccountsStore` | shows `DisplayName` · value `Code` |
| combo |  | `divCardOnFileSearchCustomers` | `vCardOnFileCustomersListStore` | shows `Name` · value `CustomerID` · placeholder `Search` |
| combo |  | `tdPeriod` | `PeriodStore` | shows `Name` · value `Period` · pick-only |
| date field |  | `tdFrom` | `` | placeholder `Select From Date` · format `UserDateFormat` |
| date field |  | `tdTo` | `` | placeholder `Select To Date` · format `UserDateFormat` |
| combo |  | `tdBulkListingBrand` | `vTenantBrandStore` | shows `Brand` · value `ID` · placeholder `List all brands` |
| combo |  | `tdBulkListingListedIn` | `ECommerceShopStore` | shows `ShopName` · value `ConfigID` · placeholder `Choose...` |

#### Menus, buttons and other parts

- **column** “Invoice #” · field `InvoiceNumber` · id `colInvoiceNumber`
- **date column** “Invoice date” · field `InvoiceDate` · id `colInvoiceDate` · format `UserDateFormat`
- **column** “Quoteorder #” · field `SONumber` · id `colSONumber`
- **column** “Saleschannel” · field `SourceChannel` · id `colSourceChannel`
- **column** “Currency” · field `CustomerCurrency` · id `colCustomerCurrency`
- **column** “Invoice amount” · field `InvoiceAmount` · id `colInvoiceAmount`
- **column** “Paid to date” · field `PaidAmount` · id `colPaidAmount`
- **column** “Due amount” · field `DueAmount` · id `colDueAmount`
- **column** “Overdue” · field `DaysOverdue` · id `colDaysOverdue`
- **column** “Pay amount” · field `AllocatedAmount` · id `colAllocatedAmount`

### `Depreciations2019`

2 grids · 5 standalone fields · 0 windows · 0 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `Depreciation_Index_Container` · store `store` · placeholder `You do not have any depreciation at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Start date | `StartDate` |  | flex 2 | renderer() |  |
    | End date | `EndDate` |  | flex 2 | renderer() |  |
    | Total items | `TotalItems` |  | 100 |  |  |
    | Total amount | `TotalAmount` |  | 100 | renderer() |  |
    | Created date | `CreatedDate` |  | flex 3 | renderer() |  |
    |  | `` |  | flex 1 | renderer() | hidden |

- **grid** · renders into `Depreciation_Index_DepreciationsList` · store `DepreciationDetailsStore` · placeholder `You do not have any depreciation at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Fixed asset | `FixedAssetName` |  | flex 1 | RenderHTMLText |  |
    | Serial number | `SerialNumber` |  | flex 1 | RenderHTMLText |  |
    | Accumulated account | `AccumulatedDepreciationAccountName` |  | flex 1 | Common_COA_TreeMode_RestoreDisplayName |  |
    | Expense account | `DepreciationExpenseAccountName` |  | flex 1 | Common_COA_TreeMode_RestoreDisplayName |  |
    | Book depreciation | `Amount` |  | flex 1 | renderer() |  |
    |  | `` |  | flex 1 | renderer() | hidden |


#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| date field |  | `tdStartDate` | `` | format `UserDateFormat` |
| combo |  | `tdEndDate` | `EndDateStore` | shows `EndDate` · value `YearMonth` · format `UserDateFormat` · pick-only |
| number field |  | `tdTotalItems` | `` | read-only |
| text field |  | `tdTotalAmount` | `` | read-only |
| date field |  | `tdCreatedDate` | `` | format `"".concat(…)` · read-only |

### `ExpenseClaim2019`

5 grids · 4 standalone fields · 0 windows · 12 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `divRealDimensions` · store `window.AccountingDimensionsRealTempStore` · placeholder `emptyMsgText`
- **grid** · renders into `divTDetails` · store `TransactionsStore` · placeholder `No transactions created.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Effective date | `EffectiveDate` |  | flex 1 | renderer() |  |
    | Debit | `Debit` |  | flex 1 | Common_COA_TreeMode_RestoreDisplayName |  |
    | Credit | `Credit` |  | flex 1 | Common_COA_TreeMode_RestoreDisplayName |  |
    | Amount | `Amount` |  | 130 | renderer() |  |

- **grid** · renders into `divOrderLines` · placeholder `You do not have any receipts.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Receipt # | `ReceiptNumber` |  | flex 1 | renderer() |  |
    | Receipt date | `ReceiptDate` |  | flex 1 | renderer() |  |
    | Status | `ReceiptStatus` |  | flex 2 | renderer() |  |
    | Reference | `ReceiptReference` |  | flex 1 | renderer() |  |
    | Paid to | `Employee` |  | flex 1 | renderer() |  |
    | Items | `ReceiptItemsNumber` |  | flex 1 | renderer() |  |
    | Cost | `ReceiptAmount` |  | flex 1 | renderer() |  |

- **grid** · renders into `divPayments` · placeholder `You do not have any payments.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Account | `AccountCode` |  | flex 1 | renderer() |  |
    | Reference | `Reference` |  | flex 2 | renderer() |  |
    | Date paid | `DatePaid` | date column | flex 1 | edit: date field |  |
    | {Ext.String.format(…)} | `Amount` |  | flex 1 | renderer() |  |

- **grid** · renders into `divHistoryLines` · store `_classPrivateFieldGet(…)` · placeholder `Activity log is not available now.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Date | `DateChanged` |  | flex 1 | renderer() |  |
    | Changes made | `ColumnsChanged` |  | flex 4 | renderer() |  |
    | User | `ChangedBy` |  | flex 2 |  |  |


#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| date field |  | `ExpenseClaim_Index_PaymentDueDate` | `` | placeholder `Choose...` · format `UserDateFormat` |
| date field |  | `ExpenseClaim_Index_EffectiveDate` | `` | placeholder `Choose...` · format `UserDateFormat` |
| text field |  | `ExpenseClaim_Index_Employee` | `` | placeholder `Choose...` · format `UserDateFormat` · disabled |
| date field |  | `WorkflowModal_dtWorkflowDate` | `` | format `UserDateFormat` |

#### Menus, buttons and other parts

- **column** “Entity” · field `EntityType` · id `colRealDimensionsEntity`
- **column** “Account” · field `AccountCode` · id `colRealDimensionsAccount`
- **column** “Amount” · field `Amount` · id `colRealDimensionsAmount`
- **column** “Reference number” · field `ReferenceNumber` · id `colRealDimensionsReferenceNumber`
- **column** “Effective date” · field `EffectiveDate` · id `colRealDimensionsDate`
- **column** “Product” · field `ProductCode` · id `colRealDimensionsProduct`
- **column** “Supplier \| Customer” · field `"".concat(…)` · id `"colRealDimensions".concat(…)`
- **column** “{attr}” · field `attr.replace(…)` · id `"col".concat(…)`
- **button** “Keep order number” · on click `handler()`
- **button** “New order #” · on click `handler()`
- **text area** · renders into `divStickyNote` · placeholder `Write your note here...`
- **component**
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    |  | `ProductCode` |  |  |  | hidden |
    |  | `CustomerName` |  |  |  | hidden |
    | Expense item | `ExpenseItem` |  | flex 1 |  |  |
    | Company contact | `CompanyContact` |  | flex 1 |  |  |


### `ExpenseClaimList2019`

1 grids · 0 standalone fields · 0 windows · 0 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `ExpenseClaimList_Index_Container` · store `mainStore` · placeholder `You do not have any expense claims at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    |  | `` |  | flex 1 | renderer() | hidden |
    | Status | `Status` |  | flex 1 | renderer() |  |
    | Date submitted | `DateSubmitted` |  | flex 1 | renderer() |  |
    | Effective date | `EffectiveDate` |  | flex 1 | renderer() |  |
    | Payment due date | `PaymentDueDate` |  | flex 1 | renderer() |  |
    | Receipts | `ReceiptsNumber` |  | 100 | renderer() |  |
    | Receipt # | `ReceiptNumbers` |  | flex 1 | renderer() |  |
    | Claim total amount | `ClaimTotalAmount` |  | flex 1 | renderer() |  |
    | Approved amount | `ApprovedTotalAmount` |  | flex 1 | renderer() |  |
    | Paid amount | `PaidAmount` |  | flex 1 | renderer() |  |
    | Due amount | `DueAmount` |  | flex 1 | renderer() |  |


### `ExpenseClaimReceipt2019`

2 grids · 17 standalone fields · 0 windows · 3 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `divOrderLines` · placeholder `You do not have any receipt lines.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Description | `Description` |  | flex 3 | renderer() |  |
    | Quantity | `Quantity` |  | 80 |  | total sum |
    | Price | `Price` |  | flex 1 | renderer() |  |
    | Tax rule | `TaxRule` |  | flex 1 | renderer() |  |
    | Account | `AccountCode` |  | flex 1 | renderer() |  |
    | Total | `Total` |  | flex 1 | renderer() | total sum |

- **grid** · renders into `divAttachmentList` · store `AttachmentsStore` · placeholder `You do not have any files attached.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Name | `FileName` |  | flex 2 | renderer() |  |
    | Date | `Date` |  | flex 1 | renderer() |  |
    | Attached by | `UserName` |  | flex 2 |  |  |
    | Processed | `IsProcessed` | check column | 80 | renderer() |  |


#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| combo (+ add new) |  | `Receipt_Index_Supplier` | `vExpenseClaimReceipt_SupplierStore` | shows `Name` · value `SupplierID` · placeholder `type to search...` |
| combo |  | `Receipt_Index_Employee` | `vExpenseClaimReceipt_TenantContactStore` | shows `Name` · value `Name` · placeholder `type or choose...` |
| combo |  | `tdReceipt_Index_Currency` | `CurrencyStore` | shows `Code` · value `Code` |
| numeric field |  | `tdExpenseClaimReceipt_Index_CurrencyConversionRate` | `` |  |
| date field |  | `Receipt_Index_Date` | `` | placeholder `Choose...` · format `UserDateFormat` |
| text field |  | `Receipt_Index_Reference` | `` | placeholder `write...` |
| combo |  | `Receipt_Index_Tax` | `vTenantTaxationRuleStore` | shows `Description` · value `RuleID` · placeholder `Choose...` |
| text field |  | `tdExpenseClaimReceipt_NewSupplier_Name` | `` |  |
| combo |  | `tdExpenseClaimReceipt_NewSupplier_Currency` | `currencyStore` | shows `Code` · value `Code` |
| combo |  | `tdExpenseClaimReceipt_NewSupplier_PaymentTerm` | `vTenantPaymentTermStore` | shows `Name` · value `TermID` |
| combo |  | `tdExpenseClaimReceipt_NewSupplier_AccountCode` | `vChartOfAccountsNewSupplierStore` | shows `DisplayName` · value `Code` |
| combo |  | `tdExpenseClaimReceipt_NewSupplier_TaxRule` | `vTenantTaxationRuleStore` | shows `Description` · value `RuleID` |
| combo |  | `tdExpenseClaimReceipt_NewSupplier_DefaultCarrier` | `vTenantCarrierStore` | shows `Description` · value `CarrierID` |
| number field |  | `tdExpenseClaimReceipt_NewSupplier_Discount` | `` |  |
| text field |  | `tdExpenseClaimReceipt_NewSupplier_Comments` | `` |  |
| text field |  | `tdExpenseClaimReceipt_NewSupplier_TaxNumber` | `` |  |
| date field |  | `WorkflowModal_dtWorkflowDate` | `` | format `UserDateFormat` |

#### Menus, buttons and other parts

- **button** “Keep order number” · on click `handler()`
- **button** “New order #” · on click `handler()`
- **component** · renders into `tdExpenseClaimReceipt_Index_DefaultAccount` · store `vChartOfAccountsExpensesStore` · shows `DisplayName` · value `Code` · placeholder `Choose...`

### `ExpenseClaimReceiptList2019`

2 grids · 0 standalone fields · 0 windows · 0 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `ExpenseClaimReceiptList_Index_Container` · store `mainStore` · placeholder `You do not have any receipts at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    |  | `` |  | flex 1 | renderer() | hidden |
    | Receipt # | `ReceiptNumber` |  | flex 1 | renderer() |  |
    | Date | `Date` |  | flex 1 | renderer() |  |
    | Supplier | `SupplierName` |  | flex 2 | renderer() |  |
    | Employee | `Employee` |  | flex 2 | renderer() |  |
    | Reference | `Reference` |  | flex 1 | renderer() |  |
    | Status | `Status` |  | flex 1 | RenderStatus |  |
    | Total | `TotalAmount` |  | flex 1 | renderer() |  |

- **grid** · renders into `ExpenseClaimReceiptList_SubmitForApproval_GridContainer` · store `selectedStore`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | # | `ReceiptNumber` |  | 120 | renderer() |  |
    | Name | `Name` |  | flex 2 | renderer() |  |
    | Total amount | `TotalAmount` |  | flex 1 | renderer() |  |


### `FixedAsset2019`

4 grids · 23 standalone fields · 0 windows · 1 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `FixedAsset_Index_Container` · store `store` · placeholder `You do not have any fixed assets at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Asset name | `ProductName` |  | flex 2 | RenderHTMLText |  |
    | Serial # | `SerialNumber` |  | flex 2 | RenderHTMLText |  |
    | Location | `LocationName` |  | flex 2 | RenderHTMLText |  |
    | Asset type | `DefaultFixedAssetTypeName` |  | flex 1 | RenderHTMLText |  |
    | Registered | `Registered` |  | flex 1 | renderer() |  |
    | Purchase date | `PurchaseDate` |  | flex 1 | renderer() |  |
    | Purchase price | `PurchaseCost` |  | flex 1 | renderer() |  |
    | Book value | `BookValue` |  | flex 1 | renderer() |  |
    |  | `` |  | flex 1 | renderer() | hidden |

- **grid** · renders into `FixedAsset_Index_DepreciationsContainer` · store `DepreciationsStore` · placeholder `You do not have any depreciation at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `FixedAssetName` |  | flex 2 | RenderHTMLText |  |
    | Serial number | `SerialNumber` |  | flex 2 | RenderHTMLText |  |
    | Date | `EffectiveDate` |  | flex 1 | renderer() |  |
    | Amount | `Amount` |  | flex 2 | renderer() |  |
    |  | `` |  | flex 1 | renderer() | hidden |

- **grid** · renders into `divAttachmentList` · store `AttachmentsStore` · placeholder `You do not have any files attached.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Name | `FileName` |  | flex 2 | renderer() |  |
    | Date | `Date` |  | flex 1 | renderer() |  |
    | Attached by | `UserName` |  | flex 2 |  |  |
    |  | `` |  | flex 1 | renderer() | hidden |

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
| text field |  | `tdProductName` | `` |  |
| text field |  | `tdSerialNumber` | `` |  |
| text field |  | `tdRegistrationDate` | `` |  |
| text field |  | `tdPurchaseDate` | `` |  |
| text field |  | `tdDisposalDate` | `` |  |
| date field |  | `tdDepreciationStartDate` | `` | placeholder `Choose...` · format `UserDateFormat` |
| text field |  | `tdPurchaseCost` | `` |  |
| text field |  | `tdOnHand` | `` |  |
| text field |  | `tdLocationName` | `` |  |
| text field |  | `tdAccumulatedDepreciation` | `` |  |
| combo |  | `tdDepreciationMethod` | `DepreciationMethodStore` | shows `DepreciationMethod` · value `DepreciationMethod` · pick-only |
| number field |  | `tdSalvageValue` | `` |  |
| number field |  | `tdBusinessUse` | `` |  |
| number field |  | `tdStartAccumulatedDepreciationAmount` | `` |  |
| number field |  | `tdStartAccumulatedBookValue` | `` |  |
| combo |  | `tdAveragingMethod` | `AveragingMethodStore` | shows `AveragingMethod` · value `AveragingMethod` · pick-only |
| radio | Rate (%) | `rbRate` | `Rate` |  |
| radio | Effective life (Yrs) | `rbEffectiveLife` | `Rate` |  |
| number field |  | `tdRate` | `` |  |
| number field |  | `tdEffectiveLife` | `` |  |
| combo |  | `tdAssetAccountCode` | `vChartOfAccountsFixedAssetStore` | shows `DisplayName` · value `Code` |
| combo |  | `tdAccumulatedDepreciationAccountCode` | `vChartOfAccountsFixedAssetStore` | shows `DisplayName` · value `Code` |
| combo |  | `tdDepreciationExpenseAccountCode` | `vChartOfAccountsExpenseStore` | shows `DisplayName` · value `Code` |

#### Menus, buttons and other parts

- **component**
  - *buttons:*
    - **item**

### `Journal2019`

4 grids · 3 standalone fields · 0 windows · 9 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `divRealDimensions` · store `window.AccountingDimensionsRealTempStore` · placeholder `emptyMsgText`
- **grid** · renders into `divLinesContainer` · placeholder `Add new lines to the journal task`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Debit | `Debit` |  | flex 1 | Journal_Index_GetAccountDisplayName |  |
    | Credit | `Credit` |  | flex 1 | Journal_Index_GetAccountDisplayName |  |
    | Reference | `Reference` |  | flex 1 | renderer() |  |
    | Amount | `Amount` |  | flex 1 | renderer() |  |
    | Base amount | `BaseAmount` |  | flex 1 | renderer() | hidden |

- **grid** · renders into `divAttachmentList` · store `AttachmentsStore` · placeholder `You do not have any files attached.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Name | `FileName` |  | flex 2 | renderer() |  |
    | Date | `Date` |  | flex 1 | renderer() |  |
    | Attached by | `UserName` |  | flex 2 | RenderHTMLText |  |

- **grid** · renders into `divDimensionLinesContainer` · store `vAccountingDimensionsLinesStore` · placeholder `No accounting dimension lines.`

#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| date field |  | `WorkflowModal_dtWorkflowDate` | `` | format `UserDateFormat` |
| date field |  | `Journal_Index_EffectiveDate` | `` | placeholder `Choose...` · format `UserDateFormat` |
| combo |  | `Journal_Index_Currency` | `currencyStore` | shows `DisplayName` · value `Code` |

#### Menus, buttons and other parts

- **column** “Entity” · field `EntityType` · id `colRealDimensionsEntity`
- **column** “Account” · field `AccountCode` · id `colRealDimensionsAccount`
- **column** “Amount” · field `Amount` · id `colRealDimensionsAmount`
- **column** “Reference number” · field `ReferenceNumber` · id `colRealDimensionsReferenceNumber`
- **column** “Effective date” · field `EffectiveDate` · id `colRealDimensionsDate`
- **column** “Product” · field `ProductCode` · id `colRealDimensionsProduct`
- **column** “Supplier \| Customer” · field `"".concat(…)` · id `"colRealDimensions".concat(…)`
- **column** “{attr}” · field `attr.replace(…)` · id `"col".concat(…)`
- **component**
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    |  | `ProductCode` |  |  |  | hidden |
    |  | `CustomerName` |  |  |  | hidden |


### `JournalList2019`

1 grids · 0 standalone fields · 0 windows · 0 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `Journal_Index_Container` · store `mainStore` · placeholder `You do not have any journals at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    |  | `` |  | flex 1 | renderer() | hidden |
    | Journal # | `JournalNumber` |  | flex 1 | renderer() |  |
    | Date created | `CreatedDate` |  | flex 1 | renderer() |  |
    | Effective date | `EffectiveDate` |  | flex 1 | renderer() |  |
    | Status | `Status` |  | flex 1 | RenderStatus |  |
    | Narration | `Narration` |  | flex 1 | renderer() |  |


### `MoneyTaskList2019`

1 grids · 0 standalone fields · 0 windows · 1 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `MoneyTaskList_Container` · store `mainStore` · placeholder `You do not have any spend/receive money operations at the moment.`

#### Menus, buttons and other parts

- **button** “{Title}” · id `rec.getId(…)` · on click `handler()`

### `MoneyTaskReceive2019`

4 grids · 23 standalone fields · 0 windows · 12 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `divRealDimensions` · store `window.AccountingDimensionsRealTempStore` · placeholder `emptyMsgText`
- **grid** · renders into `divTDetails` · store `TransactionsStore` · placeholder `No transactions created.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Effective date | `EffectiveDate` |  | flex 1 | renderer() |  |
    | Debit | `Debit` |  | flex 1 | Common_COA_TreeMode_RestoreDisplayName |  |
    | Credit | `Credit` |  | flex 1 | Common_COA_TreeMode_RestoreDisplayName |  |
    | Amount | `Amount` |  | 130 | renderer() |  |

- **grid** · renders into `divAttachmentList` · store `AttachmentsStore` · placeholder `You do not have any files attached.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Name | `FileName` |  | flex 2 | renderer() |  |
    | Date | `Date` |  | flex 1 | renderer() |  |
    | Attached by | `UserName` |  | flex 2 |  |  |
    | Processed | `IsProcessed` | check column | 80 | renderer() |  |

- **grid** · renders into `divMoneyTaskLines` · placeholder `You do not have any details.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `ProductID` |  | flex 3 | renderer() |  |
    | Comment | `Comment` |  | flex 1 | renderer() | total count |
    | Quantity | `Quantity` |  | flex 1 |  | total sum |
    | Price | `PriceBank` |  | flex 1 | renderer() |  |
    | Discount | `Discount` | number column | flex 1 | renderer() |  |
    | Tax rule | `TaxRule` |  | flex 1 | renderer() |  |
    | Account | `AccountCode` |  | flex 1 | renderer() |  |
    | Total | `TotalBank` |  | flex 1 | renderer() | total sum |


#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| date field |  | `WorkflowModal_dtWorkflowDate` | `` | format `UserDateFormat` |
| combo |  | `divBankAccount` | `vBankAccountStore` | shows `AccountName` · value `AccountCode` · placeholder `Choose...` |
| combo (+ add new) |  | `divSupplierCustomer` | `SupplierCustomerStore` | shows `DisplayName` · value `ID` · placeholder `type to search...` |
| date field |  | `divMoneyTaskDate` | `` | placeholder `Choose...` · format `UserDateFormat` |
| numeric field |  | `divCurrencyConversionRate` | `` |  |
| text field |  | `divReference` | `` |  |
| checkbox |  | `divTaxInclusive` | `` |  |
| text field |  | `divNewCustomerName` | `` |  |
| combo |  | `divNewCustomerPaymentTerm` | `vTenantPaymentTermStore` | shows `Name` · value `TermID` · placeholder `Choose...` |
| combo |  | `divNewCustomerSaleAccount` | `vChartOfAccountsLinesStore` | shows `DisplayName` · value `Code` · placeholder `Choose...` |
| combo |  | `divNewCustomerSalesRep` | `vTenantContactsStore` | shows `Name` · value `ContactID` · placeholder `Choose...` |
| combo |  | `divNewCustomerDefaultLocation` | `vTenantLocationStore` | shows `Description` · value `LocationID` · placeholder `Choose...` |
| text field |  | `divNewCustomerDiscount` | `` |  |
| combo |  | `divNewCustomerCurreny` | `currencyStore` | shows `Code` · value `Code` |
| combo |  | `divNewCustomerAccountReceivable` | `vChartOfAccountsNewSupplierCustomerStore` | shows `DisplayName` · value `Code` · placeholder `Choose...` |
| combo |  | `divNewCustomerTaxRule` | `vTenantTaxationRuleStore` | shows `Description` · value `RuleID` · placeholder `Choose...` |
| combo |  | `divNewCustomerDefaultCarrier` | `vTenantCarrierStore` | shows `Description` · value `CarrierID` · placeholder `Choose...` |
| text field |  | `divNewCustomerTaxNumber` | `` |  |
| combo |  | `divNewCustomerSalePriceTier` | `vSalesPriceTiersStore` | shows `Name` · value `Code` · placeholder `Choose...` |
| text field |  | `renderTo` | `` |  |
| checkbox |  | `renderTo` | `` |  |
| numeric field |  | `renderTo` | `` |  |
| date field |  | `renderTo` | `` | placeholder `Choose...` · format `UserDateFormat` |

#### Menus, buttons and other parts

- **column** “Entity” · field `EntityType` · id `colRealDimensionsEntity`
- **column** “Account” · field `AccountCode` · id `colRealDimensionsAccount`
- **column** “Amount” · field `Amount` · id `colRealDimensionsAmount`
- **column** “Reference number” · field `ReferenceNumber` · id `colRealDimensionsReferenceNumber`
- **column** “Effective date” · field `EffectiveDate` · id `colRealDimensionsDate`
- **column** “Product” · field `ProductCode` · id `colRealDimensionsProduct`
- **column** “Supplier \| Customer” · field `"".concat(…)` · id `"colRealDimensions".concat(…)`
- **column** “{attr}” · field `attr.replace(…)` · id `"col".concat(…)`
- **column** “Customer/ supplier” · field `CustomerSupplier` · id `colRealDimensionsCustomerSupplier`
- **component**
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    |  | `CustomerName` |  |  |  | hidden |
    |  | `SupplierName` |  |  |  | hidden |

- **component** · id `cmpId` · renders into `renderTo` · store `localStore` · shows `name` · value `value` · placeholder `Choose...` · pick-only
- **column** “{attrSet.name}” · field `"CustomField".concat(…)`

### `MoneyTaskSpend2019`

4 grids · 19 standalone fields · 0 windows · 12 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `divRealDimensions` · store `window.AccountingDimensionsRealTempStore` · placeholder `emptyMsgText`
- **grid** · renders into `divTDetails` · store `TransactionsStore` · placeholder `No transactions created.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Effective date | `EffectiveDate` |  | flex 1 | renderer() |  |
    | Debit | `Debit` |  | flex 1 | Common_COA_TreeMode_RestoreDisplayName |  |
    | Credit | `Credit` |  | flex 1 | Common_COA_TreeMode_RestoreDisplayName |  |
    | Amount | `Amount` |  | 130 | renderer() |  |

- **grid** · renders into `divAttachmentList` · store `AttachmentsStore` · placeholder `You do not have any files attached.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Name | `FileName` |  | flex 2 | renderer() |  |
    | Date | `Date` |  | flex 1 | renderer() |  |
    | Attached by | `UserName` |  | flex 2 |  |  |
    | Processed | `IsProcessed` | check column | 80 | renderer() |  |

- **grid** · renders into `divMoneyTaskLines` · placeholder `You do not have any details.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `ProductID` |  | flex 3 | renderer() |  |
    | Comment | `Comment` |  | flex 1 | renderer() | total count |
    | Quantity | `Quantity` |  | flex 1 |  | total sum |
    | Price | `PriceBank` |  | flex 1 | renderer() |  |
    | Discount | `Discount` | number column | flex 1 | renderer() |  |
    | Tax rule | `TaxRule` |  | flex 1 | renderer() |  |
    | Account | `AccountCode` |  | flex 1 | renderer() |  |
    | Total | `TotalBank` |  | flex 1 | renderer() | total sum |


#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| date field |  | `WorkflowModal_dtWorkflowDate` | `` | format `UserDateFormat` |
| combo |  | `divBankAccount` | `vBankAccountStore` | shows `AccountName` · value `AccountCode` · placeholder `Choose...` |
| combo (+ add new) |  | `divSupplierCustomer` | `SupplierCustomerStore` | shows `DisplayName` · value `ID` · placeholder `type to search...` |
| date field |  | `divMoneyTaskDate` | `` | placeholder `Choose...` · format `UserDateFormat` |
| numeric field |  | `divCurrencyConversionRate` | `` |  |
| text field |  | `divReference` | `` |  |
| checkbox |  | `divTaxInclusive` | `` |  |
| text field |  | `divNewSupplierName` | `` |  |
| combo |  | `divNewSupplierCurreny` | `currencyStore` | shows `Code` · value `Code` |
| combo |  | `divNewSupplierTaxRule` | `vTenantTaxationRuleStore` | shows `Description` · value `RuleID` · placeholder `Choose...` |
| combo |  | `divNewSupplierPaymentTerm` | `vTenantPaymentTermStore` | shows `Name` · value `TermID` · placeholder `Choose...` |
| text field |  | `divNewSupplierDiscount` | `` |  |
| combo |  | `divNewSupplierAccountPayable` | `vChartOfAccountsNewSupplierCustomerStore` | shows `DisplayName` · value `Code` · placeholder `Choose...` |
| combo |  | `divNewSupplierDefaultCarrier` | `vTenantCarrierStore` | shows `Description` · value `CarrierID` · placeholder `Choose...` |
| text field |  | `divNewSupplierTaxNumber` | `` |  |
| text field |  | `renderTo` | `` |  |
| checkbox |  | `renderTo` | `` |  |
| numeric field |  | `renderTo` | `` |  |
| date field |  | `renderTo` | `` | placeholder `Choose...` · format `UserDateFormat` |

#### Menus, buttons and other parts

- **column** “Entity” · field `EntityType` · id `colRealDimensionsEntity`
- **column** “Account” · field `AccountCode` · id `colRealDimensionsAccount`
- **column** “Amount” · field `Amount` · id `colRealDimensionsAmount`
- **column** “Reference number” · field `ReferenceNumber` · id `colRealDimensionsReferenceNumber`
- **column** “Effective date” · field `EffectiveDate` · id `colRealDimensionsDate`
- **column** “Product” · field `ProductCode` · id `colRealDimensionsProduct`
- **column** “Supplier \| Customer” · field `"".concat(…)` · id `"colRealDimensions".concat(…)`
- **column** “{attr}” · field `attr.replace(…)` · id `"col".concat(…)`
- **column** “Customer/ supplier” · field `CustomerSupplier` · id `colRealDimensionsCustomerSupplier`
- **component**
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    |  | `CustomerName` |  |  |  | hidden |
    |  | `SupplierName` |  |  |  | hidden |

- **component** · id `cmpId` · renders into `renderTo` · store `localStore` · shows `name` · value `value` · placeholder `Choose...` · pick-only
- **column** “{attrSet.name}” · field `"CustomField".concat(…)`

### `MoneyTaskTransfer2019`

3 grids · 4 standalone fields · 0 windows · 12 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `divRealDimensions` · store `window.AccountingDimensionsRealTempStore` · placeholder `emptyMsgText`
- **grid** · renders into `divTDetails` · store `TransactionsStore` · placeholder `No transactions created.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Effective date | `EffectiveDate` |  | flex 1 | renderer() |  |
    | Debit | `Debit` |  | flex 1 | Common_COA_TreeMode_RestoreDisplayName |  |
    | Credit | `Credit` |  | flex 1 | Common_COA_TreeMode_RestoreDisplayName |  |
    | Amount | `Amount` |  | 130 | renderer() |  |

- **grid** · renders into `divAttachmentList` · store `AttachmentsStore` · placeholder `You do not have any files attached.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Name | `FileName` |  | flex 2 | renderer() |  |
    | Date | `Date` |  | flex 1 | renderer() |  |
    | Attached by | `UserName` |  | flex 2 |  |  |
    | Processed | `IsProcessed` | check column | 80 | renderer() |  |


#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| date field |  | `divMoneyTaskDate` | `` | placeholder `Choose...` · format `UserDateFormat` |
| text field |  | `divReference` | `` | placeholder `write...` |
| numeric field |  | `divAmount` | `` |  |
| numeric field |  | `divAmountTo` | `` |  |

#### Menus, buttons and other parts

- **column** “Entity” · field `EntityType` · id `colRealDimensionsEntity`
- **column** “Account” · field `AccountCode` · id `colRealDimensionsAccount`
- **column** “Amount” · field `Amount` · id `colRealDimensionsAmount`
- **column** “Reference number” · field `ReferenceNumber` · id `colRealDimensionsReferenceNumber`
- **column** “Effective date” · field `EffectiveDate` · id `colRealDimensionsDate`
- **column** “Product” · field `ProductCode` · id `colRealDimensionsProduct`
- **column** “Supplier \| Customer” · field `"".concat(…)` · id `"colRealDimensions".concat(…)`
- **column** “{attr}” · field `attr.replace(…)` · id `"col".concat(…)`
- **column** “Customer/ supplier” · field `CustomerSupplier` · id `colRealDimensionsCustomerSupplier`
- **component** · renders into `divBankAccount` · store `vBankAccountStore` · shows `AccountName` · value `AccountCode` · placeholder `Choose...`
- **component** · renders into `divBankAccountTo` · store `vBankAccountStore` · shows `AccountName` · value `AccountCode` · placeholder `Choose...`
- **component**
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    |  | `CustomerName` |  |  |  | hidden |
    |  | `ProductCode` |  |  |  | hidden |


