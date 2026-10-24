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

## Layout

Each screen's server-rendered HTML inside the shell, as an outline: headings, tabs, sections, labels, inputs (`#id`), buttons (`▾` = dropdown), menus, tables and `slot`s (empty `<div>`s the components below mount into). `(hidden)` parts are shown by the page code when needed. Read with GET from a signed-in session; no values are kept.

### `/AccountMapping`: Account mapping

Frame: `task-upload-frame`.

```text
link "Home"
link "Reference Books"
block #ActivityLogDiv (hidden)
  button "Close"
  slot #ActivityLogs_Container
button "Activity log" primary
button "Save"#divSaveChanges primary
form
form#frmMapping
  block #FirstField
    label "Inventory control account"
    select#InventoryControlAccount
  block #liInventoryAccrual
    label "Goods received not invoiced account"
    select#InventoryAccrualAccount
  label "Cost of goods sold account"
  select#CostOfGoodsSoldAccount
  label "Tax liability account"
  select#TaxLiability
  block #liAREExciseTaxAccount
    label "Customer credit account"
    select#SalePrepayment
  label "In-transit account"
  select#TransferInTransit
  label "Current year profits account"
  select#CurrentYearProfits
  label "Unrealized currency gains account"
  select#UnrealisedCurrencyGain
  label "Inventory discrepancy account"
  select#InventoryDiscrepancyAccount
  block #liStockInTransit
    label "Goods invoiced not received account"
    select#StockInTransitAccount
  label "Default revenue account"
  select#DefaultRevenueAccount
  label "Work in progress account"
  select#WipAccount
  label "Supplier deposits account"
  select#PurchasePrepayment
  block #divGiftCardLiability
    label "Gift card liability account"
    select#GiftCard
  label "Realized currency gains account"
  select#RealisedCurrencyGain
  label "Payment clearing account"
  select#PaymentClearing
  block #QBSupplierDepositZeroTax_FormGroup (hidden)
    label "Supplier deposit zero-rated tax rule"
    select#QBSupplierDepositZeroTax
modal#AccountMapping_CreateAccountForm medium
  heading "Add account to Xero"
  button "×"
  label "Account type" for #tdAccountType
  select#tdAccountType: Current Asset | Fixed asset | Non-current Asset | Prepayment | Equity | Depreciation | Direct Cost | Expense | Overhead | Current Liability | Liability | Non-current Liability | Other Income | Revenue | Sale
  label "Account code" for #tdAccountCode
  input text#tdAccountCode placeholder "A unique code/number for this account (limited to "
  label "Name" for #tdAccountName
  input text#tdAccountName placeholder "A short title for this account (limited to 150 cha"
  label "Description (optional)" for #tdAccountDescription
  input text#tdAccountDescription placeholder "A description of how this account should be used."
  label "Show in expense claims" for #tdShowInExpenseClaims
  input checkbox#tdShowInExpenseClaims
  label "Enable payments to this account" for #tdEnablePayments
  input checkbox#tdEnablePayments
  button "Add" primary
  button "Close"
slot #CountrySpecificScript
```

### `/AccountingDimensions`: Accounting dimensions

Frame: `task-upload-frame`.

```text
link "Home"
link "Reference Books"
button "Save"#divSaveChanges primary
button "Activity log"#activityLogsButton primary
slot #AccountingDimensions_Index_Container
block #ActivityLogDiv (hidden)
  button "Close"
  input text#divActivityLogsSearch placeholder "Type text to search"
  button "Search" primary
  button #divActivityLogsRefresh
  slot #ActivityLogs_Container
```

### `/BankAccounts`: Bank accounts

Frame: `task-upload-frame`.

```text
link "Home"
link "Reference Books"
block #divMainContent
  block #empty-list-message (hidden)
    text "There are no bank accounts created for your organization yet."
  slot #bankAccountList
modal#divBankAccountDetails small
  heading "Edit bank account details"#divChartOfAccountsBankContentDialogTitle
  button "×"
  input text#tdBankAccounts_Bank_AccountName placeholder "Enter account name"
  label "Account name" for #tdBankAccounts_Bank_AccountName
  input text#tdBankAccounts_Bank_Currency read-only
  label "Account currency" for #tdBankAccounts_Bank_Currency
  input text#tdBankAccounts_Bank_AccountCode read-only
  label "Account code" for #tdBankAccounts_Bank_AccountCode
  input text#tdBankAccounts_Bank_Bank placeholder "Enter a bank name"
  label "Bank name" for #tdBankAccounts_Bank_Bank
  input text#tdBankAccounts_Bank_AccountNumber placeholder "Enter account number"
  label "Account number" for #tdBankAccounts_Bank_AccountNumber
  input text#tdBankAccounts_Bank_InitialBalance placeholder "Enter initial account balance"
  label "Initial account balance" for #tdBankAccounts_Bank_InitialBalance
  slot #tdBankAccounts_Bank_Status
  label "Status" for #tdBankAccounts_Bank_Status
  button "Save"#divSaveChanges primary
  button "Close"
```

### `/ChartOfAccounts`: Chart of accounts

Frame: `ifrmUploadChartOfAccount`.

```text
link "Home"
link "Reference Books"
button "Close"#cancelImport (hidden)
block #divAccountsList
  link "configure account mapping"
  button "Activity log" primary
  form#frmFillByDefault
  form#frmDeleteArchived
  form#frmLoadFromXero
  form#frmExport
  block #leftSideBtnBar
    button "Account"#divNewAccount primary
    button "Bank account"#divNewBankAccount primary
    button "Refresh"#divRefresh
    button "Load from Xero"#divLoadfromXero primary
    button "Load from QuickBooks"#divLoadfromQuickbooks primary
    button "Use default"#divFillByDefault
    button "More actions"#divMore ▾
    link "Delete unused archived accounts"#DeleteMenuItem
    link "Import"#ImportMenuItem
    link "Export"
  block #rightSideBtnBar
    input checkbox#divShowArchived
    label "Show archived" for #divShowArchived
    select#divFilter
  slot #ChartOfAccounts_Index_Container
  block #ActivityLogDiv (hidden)
    button "Close"
    button "Refresh"
    slot #ActivityLogs_Container
block #divImportAccounts (hidden)
  text "Download our chart of accounts template file"
  button "Download CSV template" primary
  text "Copy your chart of accounts into the template"
  button "Fields specification"#Imports_Spec_Requirement_Button ▾
  text "Do not change the column headings in the template file. These need to be unchanged for the import to work in the next st"
  text "The file should contain the full chart of accounts, all accounts not included in the file will be deactivated or deleted"
  block #Imports_Spec_Requirement (hidden)
    text "Accounts are identified first by code and then by name. You can change code only"
    table: Field name | What is it?
    text "Optional fields"
    text "You can fill in an optional field if you have them"
    button "Optional fields"#Imports_Spec_Optional_Button ▾
    block #Imports_Spec_Optional (hidden)
      table: Optional field | What is it?
  text "Import the updated template file"
  block #fileImportGridContainer (hidden)
    block #importResult_Success (hidden)
    block #importResult_Error (hidden)
      slot #importResult_ErrorMessage
  block #divExceptions (hidden)
    slot #ImportExceptionsContainer
  block #divImportResult (hidden)
    slot #divPerformedActionsGrid
  slot #ifrmUploadChartOfAccount (hidden)
  form#ChartOfAccountDropContainer
    heading "Drop files here or click to upload."
modal#divChartOfAccountsBankContentDialog small
  heading #divChartOfAccountsBankContentDialogTitle
  button "×"
  tabs: General #bank-account-general-settings | Accounting dimensions #bank-accounting-dimensions-setup
  tab pane#bank-account-general-settings
    select#tdParentBankAccount
    label "Parent account" for #tdParentBankAccount
    input text#tdChartOfAccounts_Bank_AccountName placeholder "Enter account name"
    label "Account name" for #tdChartOfAccounts_Bank_AccountName
    select#tdChartOfAccounts_Bank_Currency
    label "Account currency" for #tdChartOfAccounts_Bank_Currency
    input text#tdChartOfAccounts_Bank_AccountCode placeholder "Enter account code"
    label "Account code" for #tdChartOfAccounts_Bank_AccountCode
    input text#tdChartOfAccounts_Bank_Bank placeholder "Enter a bank name"
    label "Bank name" for #tdChartOfAccounts_Bank_Bank
    input text#tdChartOfAccounts_Bank_AccountNumber placeholder "Enter account number"
    label "Account number" for #tdChartOfAccounts_Bank_AccountNumber
    input text#tdChartOfAccounts_Bank_InitialBalance placeholder "Enter initial account balance"
    label "Initial account balance" for #tdChartOfAccounts_Bank_InitialBalance
    label "Status" for #tdChartOfAccounts_Bank_Status
    select#tdChartOfAccounts_Bank_Status
  tab pane#bank-accounting-dimensions-setup
    table#tableGridBankAccountDimensions: Dimension | Enable
  button "Save" primary
  button "Close"
modal#divChartOfAccountsIndexContentDialog small
  heading #divChartOfAccountsIndexContentDialogTitle
  button "×"
  tabs: General #account-general-settings | Accounting dimensions #accounting-dimensions-setup
  tab pane#account-general-settings
    select#tdParentAccount
    label "Parent account" for #tdParentAccount
    select#tdChartOfAccounts_Index_AccountType
    label "Account type" for #tdChartOfAccounts_Index_AccountType
    select#tdSystemAccount
    label "System account" for #tdSystemAccount
    input text#tdChartOfAccounts_Index_Code placeholder "Enter a code"
    label "Code" for #tdChartOfAccounts_Index_Code
    input text#tdChartOfAccounts_Index_Name placeholder "Enter a name"
    label "Name" for #tdChartOfAccounts_Index_Name
    textarea#tdChartOfAccounts_Index_Description placeholder "Enter a description"
    label "Description" for #tdChartOfAccounts_Index_Description
    select#tdChartOfAccounts_Index_Status
    label "Status" for #tdChartOfAccounts_Index_Status
    input checkbox#tdChartOfAccounts_Index_ForPayments
    label "Accept payments" for #tdChartOfAccounts_Index_ForPayments
  tab pane#accounting-dimensions-setup
    table#tableGridAccountDimensions: Dimension | Enable
  button "Save" primary
  button "Close"
```

### `/DealList`: Deals

Frame: `task-upload-frame`.

```text
link "Home"
link "Reference Books"
button #divNew primary
input text#divSearchField name=divSearch placeholder "Type text to search"
button "Search"#divSearch primary
button "Import"#divImport
button "Export"#divExport
button #divRefresh primary
slot #DealList_Index_Container
form#frmExport
```

### `/DearToDearNetworking`: Cin7 Core to Cin7 Core Network

Frame: `task-upload-frame`.

```text
link "Home"
link "Reference Books"
button "Save"#saveAction primary
block #divMainContent
  slot #DearToDear_Index_NetworkingKey
  button "Send an invite"#DearToDear_Index_SendInvite primary
  button "Regenerate"#DearToDear_Index_RegenerateNetworkingKey primary
  heading "Network connections"
  button #divNew primary
  slot #DearToDear_Index_Container
block #secEmail (hidden)
  block #secEmail_Content
    slot #emailDialogCaption
    button "Send"#btnSendEmail primary
    button "Back"#emailBackAction
    slot #EmailSendTemplate_AdditionalInfo (hidden)
    label "To" for #DEAREmailTo
    label "Subject" for #DEAREmailSubject
    input text#DEAREmailTo
    button #DEAREmailTo_btn primary
    input text#DEAREmailSubject
    slot #tdEmail_Body
    block #emailReCaptcha (hidden)
modal#secRecipients medium
  heading "Select a recipient"
  button "×"
  slot #gridRecipients
  button "Add" primary
  button "Close"
slot #btnSendEmail2
```

### `/DefaultFieldValues/Customer`: Default field values

Frame: `task-upload-frame`.

```text
link "Home"
link "Reference Books"
block #ActivityLogDiv (hidden)
  button "Close"
  input text#divActivityLogsSearch placeholder "Type text to search"
  button "Search" primary
  button #divActivityLogsRefresh
  slot #ActivityLogs_Container
button "Save"#saveAction1 primary
button "Activity log" primary
label "Currency"
slot #Customer_Index_Currency
block #liFixedAssetType
  label "Sale account"
  slot #Customer_Index_SaleAccount
block #liFixedAssetType
  label "Tax rule"
  slot #Customer_Index_TaxRule
label "Payment term"
slot #Customer_Index_PaymentTerm
block #liCostingMethod
  label "Account receivable"
  slot #Customer_Index_AccountReceivable
label "Sale price tier"
slot #Customer_Index_SalePriceTier
block #liDropShipMode
  label "Sales representative"
  slot #Customer_Index_DefaultSalesRepresentative
block #liDiscount
  label "Default carrier"
  slot #Customer_Index_DefaultCarrier
block #liLocation
  label "Default location"
  slot #Customer_Index_DefaultLocation
label "Attributes set"
slot #Customer_Index_AttributeSet
```

### `/DefaultFieldValues/Product`: Default field values

Frame: `task-upload-frame`.

```text
link "Home"
link "Reference Books"
block #ActivityLogDiv (hidden)
  button "Close"
  input text#divActivityLogsSearch placeholder "Type text to search"
  button "Search" primary
  button #divActivityLogsRefresh
  slot #ActivityLogs_Container
button "Save"#saveAction1 primary
button "Activity log" primary
label "Type"
slot #Product_Index_Type
block #liFixedAssetType
  label "Fixed asset type"
  slot #Product_Index_FixedAssetType
label "Category"
slot #Product_Index_Category
label "Brand"
slot #Product_Index_Brand
block #liCostingMethod
  label "Costing method"
  slot #Product_Index_CostingMethod
block #liDefaultUnitOfMeasure
  label "Unit of measure"
  slot #Product_Index_DefaultUnitOfMeasure
block #liDropShipMode
  label "Drop ship"
  slot #Product_Index_DropShipMode
block #liDiscount
  label "Product discount"
  slot #Product_Index_Discount
block #liLocation
  label "Default location"
  slot #Product_Index_DefaultLocation
label "Additional attributes set"
slot #Product_Index_ProductAttributeSet
label "I am selling this product"
slot #Product_Index_NotSellable
```

### `/DefaultFieldValues/Supplier`: Default field values

Frame: `task-upload-frame`.

```text
link "Home"
link "Reference Books"
block #ActivityLogDiv (hidden)
  button "Close"
  input text#divActivityLogsSearch placeholder "Type text to search"
  button "Search" primary
  button #divActivityLogsRefresh
  slot #ActivityLogs_Container
button "Save"#saveAction1 primary
button "Activity log" primary
label "Currency"
slot #Supplier_Index_Currency
label "Default carrier"
slot #Supplier_Index_DefaultCarrier
label "Tax rule"
slot #Supplier_Index_TaxRule
label "Payment term"
slot #Supplier_Index_PaymentTerm
block #liCostingMethod
  label "Account payable"
  slot #Supplier_Index_AccountPayable
block #liCostingMethod
  label "Attributes set"
  slot #Supplier_Index_AttributeSet
```

### `/DiscountListNew`: Discounts

Frame: `task-upload-frame`.

```text
link "Home"
link "Reference Books"
button #divNew primary
button #divRefresh primary
input text#divSearchField name=divSearch placeholder "Type text to search"
button "Search"#divSearch primary
slot #DiscountList_Index_Container
```

### `/ExpenseItems`: Expense items

Frame: `task-upload-frame`.

```text
link "Home"
link "Reference Books"
button "Save"#ExpenseItems_SaveAction primary
button "Activity log" primary
button #divNew primary
slot #ExpenseItem_Index_Container
button "Add more items"#ExpenseItem_CreateNew primary
block #ActivityLogDiv (hidden)
  button "Close"
  input text#divActivityLogsSearch placeholder "Type text to search"
  button "Search" primary
  button #divActivityLogsRefresh
  slot #ActivityLogs_Container
modal#divCOGSAccDims small
  heading "Accounting dimensions"
  button "×"
  button "Save"#btnSaveCOGSAccDims primary
  button "Close"
```

### `/FixedAssetType`: Fixed asset types

Frame: `task-upload-frame`.

```text
link "Home"
link "Reference Books"
button "Activity log" primary
button #divNew primary
slot #FixedAssetType_Index_Container
button "Add more items"#FixedAssetType_Index_NewLink primary
block #ActivityLogDiv (hidden)
  button "Close"
  input text#divActivityLogsSearch placeholder "Type text to search"
  button "Search" primary
  button #divActivityLogsRefresh
  slot #ActivityLogs_Container
modal#divNewFixedAssetTypeDialog
  heading "Add a new fixed asset type"#divNewFixedAssetTypeDialogTitle
  button "×"
  input text#tdFixedAssetTypeName placeholder "Enter a name"
  label "Name"
  select#tdFixedAssetTypeDepreciationMethod
  label "Depreciation method"
  label "Averaging method"
  select#tdFixedAssetTypeAveragingMethod
  select#tdFixedAssetTypeAssetAccountCode
  label "Asset account"
  select#tdFixedAssetTypeAccumulatedDepreciationAccountCode
  label "Accumulated depreciation account"
  select#tdFixedAssetTypeDepreciationExpenseAccountCode
  label "Depreciation expense account"
  input radio#radFixedAssetTypeRate name=rbRate
  label "Rate (%)" for #radFixedAssetTypeRate
  input radio#radFixedAssetTypeEffectiveLife name=rbRate
  label "Effective life (Yrs)" for #radFixedAssetTypeEffectiveLife
  input text#tdFixedAssetTypeRate (hidden)
  input text#tdFixedAssetTypeEffectiveLife (hidden)
  button "Save" primary
  button "Close"
```

### `/LeadStatus`: Lead statuses

Frame: `task-upload-frame`.

```text
link "Home"
link "Reference Books"
button "Save"#divSaveChanges primary
button #divNew primary
slot #LeadStatus_Index_Container
button "Add more items"#LeadStatus_Index_NewLink primary
modal#divLeadStatusDetails small
  heading "Payment term details"
  button "×"
  slot #LeadStatus_Errors (hidden)
  input text#LeadStatus_Description
  label "Name" for #LeadStatus_Description
  select#LeadStatus_Method: Number of days | Day of next month | Last day of next month | Days since the end of the month
  label "Method" for #LeadStatus_Method
  input text#LeadStatus_Days
  label "Days" for #LeadStatus_Days
  input checkbox#LeadStatus_IsDefault
  label "Is default" for #LeadStatus_IsDefault
  input checkbox#LeadStatus_IsActive
  label "Is active" for #LeadStatus_IsActive
  button "Save" primary
  button "Close"
block #ActivityLogDiv (hidden)
  button "Close"
  input text#divActivityLogsSearch placeholder "Type text to search"
  button "Search" primary
  button #divActivityLogsRefresh
  slot #ActivityLogs_Container
form#frmExportPaymentTerm
```

### `/OpeningBalances`: Opening balances

Frame: `task-upload-frame`.

```text
link "Home"
link "Reference Books"
button "Back to list"
block #MultiCurrencyEditor_MainContent
  button "Save"#divSaveChanges2 primary
  select#OpeningBalances_Index_OpeningBalancesMonth
  select#OpeningBalances_Index_OpeningBalancesYear
  tab pane#portlet_tab1
    slot #transactionDate
    slot #OpeningBalances_Index_BalancesContainer
  tab pane#portlet_tab2
    slot #accPayDate
    button "Invoice"#btnAddPurchase primary
    button "Import from CSV"#btnImportOutstandingPurchases
    slot #OpeningBalances_Purchase_Container
    slot #OpeningBalances_Purchase_Totals
    button "Add more items"#OpeningBalances_Purchases_AddLink primary
  tab pane#portlet_tab3
    slot #accRecDate
    button "Invoice"#btnAddSale primary
    button "Import from CSV"#btnImportOutstandingSales
    slot #OpeningBalances_Sale_Container
    slot #OpeningBalances_Sale_Totals
    button "Add more items"#OpeningBalances_Sales_AddLink primary
  tab pane#portlet_tab4
    slot #sohDate
    button "Refresh"#divRefreshSOH
    button "Import inventory list from CSV"#divimportInventoryList
    button "Import stock on hand from CSV"#divimportSOH
    slot #OpeningBalances_SOH_Container
    slot #OpeningBalances_SOH_Totals
  tab pane#portlet_tab5
    slot #fixedAssetDate
    button "Fixed asset"#divAddNewFixedAsset primary
    button "Refresh"#divAddNewFixedAsset
    button "Import from CSV"#divimportInventory
    slot #OpeningBalances_FixedAsset_Container
    slot #OpeningBalances_FixedAsset_Totals
  tab pane#portlet_tab6
    input text#divActivityLogsSearch placeholder "Type text to search"
    button "Search" primary
    button #divActivityLogsRefresh
    slot #ActivityLogs_Container
block #SOHEditor_Content
  button "Save"#btnSaveSOHEditorTop primary
  button "Cancel"#btnCancelSOHEditorTop primary
  slot #divSOHDetailLines
  block #SOHEditor_Actions
    button "Save"#btnSaveSOHEditor primary
    button "Cancel"#btnCancelSOHEditor primary
block #FixedAssetEditor_Content
  block #FixedAssetEditor_Content_Title
  button "Save"#btnSaveFixedAssetEditorTop primary
  button "Cancel"#btnCancelFixedAssetEditorTop primary
  block #divFixedAssetEditor_Content_EditNote
  block #divFixedAssetEditor_Content_AddNote
  block #divFixedAssetAddNewLine
    button "Fixed asset"#btnFixedAssetAddNewLine primary
  slot #divFixedAssetDetailLines
  block #FixedAssetEditor_Actions
    button "Save"#btnSaveFixedAssetEditor primary
    button "Cancel"#btnCancelFixedAssetEditor primary
block #FixedAssetDetailsEditor_Content (hidden)
  block #FixedAssetDetailsEditor_Index_Content_Title
  button "Save" primary
  button "Cancel" primary
  label "Product" for #txtProductName
  slot #tdProductName
  input text#tdSerialNumber placeholder "Enter a serial number"
  label "Serial number" for #tdSerialNumber
  label "Location" for #txtLocationName
  slot #tdLocationName
  slot #DepreciationStartDate
  label "Depreciation start date" for #txtDepreciationStartDate
  label "Depreciation method" for #tdDepreciationMethod
  select#tdDepreciationMethod
  label "Averaging method" for #tdAveragingMethod
  select#tdAveragingMethod
  input radio#rbRateProcent name=rbRate
  label "Rate (%)" for #rbRateProcent
  input text#tdRate
  input radio#rbRateLife name=rbRate
  label "Effective life (Yrs)" for #rbRateLife
  input text#tdEffectiveLife
  label "Asset account"
  slot #tdFAcmbAssetAccountCode
  label "Accumulated depreciation account"
  slot #tdFAAccumulatedDepreciationAccountCode
  label "Depreciation expense account"
  slot #tdFADepreciationExpenseAccountCode
  slot #PurchaseDate
  label "Purchase date" for #txtPurchaseDate
  input text#tdPurchaseCost placeholder "Enter purchase cost"
  label "Purchase cost" for #tdPurchaseCost
  input text#tdSalvageValue placeholder "Enter salvage value"
  label "Salvage value" for #tdSalvageValue
  input text#tdStartAccumulatedDepreciationAmount placeholder "Enter accumulated depreciation"
  label "Accumulated depreciation" for #tdStartAccumulatedDepreciationAmount
  block #FixedAssetEditor_Actions
    button "Save" primary
    button "Cancel" primary
block #MultiCurrencyEditor_Content
  slot #currentAccount
  button "Save"#btnSaveMultiCurrencyTop primary
  button "Cancel"#btnCancelMultiCurrencyTop primary
  slot #exchangeRateDate
  block #divAddMultiCurrency
    button "Currency"#divNewMultiCurrencyLine primary
  slot #divMultiCurrencyLines
  block #OpeningBalances_MultiCurrency_AddLink
    button "Add more items" primary
  block #MultiCurrencyEditor_Actions
    button "Save"#btnSaveMultiCurrency primary
    button "Cancel"#btnCancelMultiCurrency primary
modal#divNewSupplierDialog small
  heading "Add a supplier"
  button "×"
  block #tdOpeningBalances_NewSupplier_Name_Container
    input text#tdOpeningBalances_NewSupplier_Name placeholder "Enter a supplier name"
    label "Name" for #tdOpeningBalances_NewSupplier_Name
  label "Payment term" for #tdOpeningBalances_NewSupplier_PaymentTerm
  select#tdOpeningBalances_NewSupplier_PaymentTerm
  label "Tax rule" for #tdOpeningBalances_NewSupplier_TaxRule
  select#tdOpeningBalances_NewSupplier_TaxRule
  input text#tdOpeningBalances_NewSupplier_Discount placeholder "Enter a supplier discount"
  label "Discount" for #tdOpeningBalances_NewSupplier_Discount
  label "Currency" for #tdOpeningBalances_NewSupplier_Currency
  slot #tdOpeningBalances_NewSupplier_Currency
  label "Account payable" for #tdOpeningBalances_NewSupplier_AccountCode
  select#tdOpeningBalances_NewSupplier_AccountCode
  label "Default carrier" for #tdOpeningBalances_NewSupplier_DefaultCarrier
  select#tdOpeningBalances_NewSupplier_DefaultCarrier
  input text#tdOpeningBalances_NewSupplier_TaxNumber name=tdOpeningBalances_NewSupplier_Discount placeholder "Enter a tax number"
  label "Tax number" for #tdOpeningBalances_NewSupplier_TaxNumber
  textarea#tdOpeningBalances_NewSupplier_Comments placeholder "Enter comments"
  label "Comments" for #tdOpeningBalances_NewSupplier_Comments
  button "Save" primary
  button "Close"
modal#divNewCustomerDialog
  heading "Add a customer"
  button "×"
  block #tdOpeningBalances_NewCustomer_Name_Container
    input text#tdOpeningBalances_NewCustomer_Name placeholder "Enter a customer name"
    label "Name" for #tdOpeningBalances_NewCustomer_Name
  label "Payment term" for #tdOpeningBalances_NewCustomer_PaymentTerm
  select#tdOpeningBalances_NewCustomer_PaymentTerm
  label "Sale account" for #tdOpeningBalances_NewCustomer_SaleAccount
  select#tdOpeningBalances_NewCustomer_SaleAccount
  label "Sales representative" for #tdOpeningBalances_NewCustomer_DefaultSalesRepresentative
  select#tdOpeningBalances_NewCustomer_DefaultSalesRepresentative
  label "Default location" for #tdOpeningBalances_NewCustomer_DefaultLocation
  select#tdOpeningBalances_NewCustomer_DefaultLocation
  input text#tdOpeningBalances_NewCustomer_Discount placeholder "Enter a customer discount"
  label "Discount" for #tdOpeningBalances_NewCustomer_Discount
  label "Currency" for #tdOpeningBalances_NewCustomer_Currency
  slot #tdOpeningBalances_NewCustomer_Currency
  label "Account receivable" for #tdOpeningBalances_NewCustomer_AccountPayable
  select#tdOpeningBalances_NewCustomer_AccountPayable
  label "Tax rule" for #tdOpeningBalances_NewCustomer_TaxRule
  select#tdOpeningBalances_NewCustomer_TaxRule
  label "Default carrier" for #tdOpeningBalances_NewCustomer_DefaultCarrier
  select#tdOpeningBalances_NewCustomer_DefaultCarrier
  input text#tdOpeningBalances_NewCustomer_TaxNumber placeholder "Enter a tax number"
  label "Tax number" for #tdOpeningBalances_NewCustomer_TaxNumber
  label "Sale price tier" for #tdOpeningBalances_NewCustomer_SalePriceTier
  select#tdOpeningBalances_NewCustomer_SalePriceTier
  textarea#tdOpeningBalances_NewCustomer_Comments placeholder "Enter comments"
  label "Comments" for #tdOpeningBalances_NewCustomer_Comments
  button "Save" primary
  button "Close"
modal#divNewProductDialog small
  heading "Add a product"
  button "×"
  input text#tdPurchase_NewProduct_ProductCode
  label "SKU" for #tdPurchase_NewProduct_ProductCode
  input text#tdPurchase_NewProduct_Name
  label "Name" for #tdPurchase_NewProduct_Name
  label "Type" for #tdPurchase_NewProduct_Type
  select#tdPurchase_NewProduct_Type
  block #FixedAssetTypeRow
    label "Fixed asset type" for #tdPurchase_NewProduct_FixedAssetType
    select#tdPurchase_NewProduct_FixedAssetType
    button #addBtn_NewProduct_FixedAssetType
  label "Category" for #tdPurchase_NewProduct_Category
  select#tdPurchase_NewProduct_Category
  label "Unit of measure" for #tdPurchase_NewProduct_UnitOfMeasure
  select#tdPurchase_NewProduct_UnitOfMeasure
  label "Costing method" for #tdPurchase_NewProduct_CostingMethod
  select#tdPurchase_NewProduct_CostingMethod
  label "Purchase tax rule" for #tdPurchase_NewProduct_PurchaseTaxRule
  select#tdPurchase_NewProduct_PurchaseTaxRule
  label "Sale tax rule" for #tdPurchase_NewProduct_SaleTaxRule
  select#tdPurchase_NewProduct_SaleTaxRule
  label "Additional attributes set" for #tdPurchase_NewProduct_ProductAttributeSet
  select#tdPurchase_NewProduct_ProductAttributeSet
  input text#tdPurchase_NewProduct_MinimumBeforeReorder
  label "Minimum before reorder" for #tdPurchase_NewProduct_MinimumBeforeReorder
  block #ReorderQuantityRow
    input text#tdPurchase_NewProduct_ReorderQuantity
    label "Reorder quantity" for #tdPurchase_NewProduct_ReorderQuantity
  input text#tdPurchase_NewProduct_Barcode
  label "Barcode" for #tdPurchase_NewProduct_Barcode
  block #StockLocatorRow
    input text#tdPurchase_NewProduct_StockLocator
    label "Stock locator" for #tdPurchase_NewProduct_Barcode
  block #Purchase_NewProduct_RowCustomField1
    input text#tdPurchase_NewProduct_CustomField1
    label "Attribute 1"
  block #Purchase_NewProduct_RowCustomField2
    input text#tdPurchase_NewProduct_CustomField2
    label "Attribute 2"
  block #Purchase_NewProduct_RowCustomField3
    input text#tdPurchase_NewProduct_CustomField3
    label "Attribute 3"
  block #Purchase_NewProduct_RowCustomField4
    input text#tdPurchase_NewProduct_CustomField4
    label "Attribute 4"
  block #Purchase_NewProduct_RowCustomField5
    input text#tdPurchase_NewProduct_CustomField5
    label "Attribute 5"
  block #Purchase_NewProduct_RowCustomField6
    input text#tdPurchase_NewProduct_CustomField6
    label "Attribute 6"
  block #Purchase_NewProduct_RowCustomField7
    input text#tdPurchase_NewProduct_CustomField7
    label "Attribute 7"
  block #Purchase_NewProduct_RowCustomField8
    input text#tdPurchase_NewProduct_CustomField8
    label "Attribute 8"
  block #Purchase_NewProduct_RowCustomField9
    input text#tdPurchase_NewProduct_CustomField9
    label "Attribute 9"
  block #Purchase_NewProduct_RowCustomField10
    input text#tdPurchase_NewProduct_CustomField10
    label "Attribute 10"
  button "Save" primary
  button "Close"
modal#divNewFixedAssetTypeDialog
  heading "Add a new fixed asset type"#divNewFixedAssetTypeDialogTitle
  button "×"
  input text#tdFixedAssetTypeName placeholder "Enter a name"
  label "Name"
  select#tdFixedAssetTypeDepreciationMethod
  label "Depreciation method"
  label "Averaging method"
  select#tdFixedAssetTypeAveragingMethod
  select#tdFixedAssetTypeAssetAccountCode
  label "Asset account"
  select#tdFixedAssetTypeAccumulatedDepreciationAccountCode
  label "Accumulated depreciation account"
  select#tdFixedAssetTypeDepreciationExpenseAccountCode
  label "Depreciation expense account"
  input radio#radFixedAssetTypeRate name=rbRate
  label "Rate (%)" for #radFixedAssetTypeRate
  input radio#radFixedAssetTypeEffectiveLife name=rbRate
  label "Effective life (Yrs)" for #radFixedAssetTypeEffectiveLife
  input text#tdFixedAssetTypeRate (hidden)
  input text#tdFixedAssetTypeEffectiveLife (hidden)
  button "Save" primary
  button "Close"
modal#OpeningBalances_VoidFixedAsset_Content
  heading "Opening fixed asset will be deleted"
  button "Void" primary
  button "Close"
modal#OpeningBalances_VoidSOH_Content
  heading "Opening stock on hand will be voided"
  button "Void" primary
  button "Close"
```

### `/OrderRouting`: Order routing

Frame: `task-upload-frame`.

```text
link "Home"
link "Reference Books"
button "Save"#divSaveChanges2 primary
button "Activity log" primary
button "Help"
label "Order routing" for #tdWarrantySetup_IsAutoGeneratedNumber
input checkbox#OrderRouting_Index_Enable (hidden)
input radio#OrderRouting_Index_Enable_On name=OrderRouting_Index_Enable
label "On" for #OrderRouting_Index_Enable_On
input radio#OrderRouting_Index_Enable_Off name=OrderRouting_Index_Enable
label "Off" for #OrderRouting_Index_Enable_Off
block #keepRoutingBlock (hidden)
  label "Keep routing, regardless of the stock status" for #tdWarrantySetup_IsAutoGeneratedNumber
  input checkbox#OrderRouting_Index_KeepRouting (hidden)
  input radio#OrderRouting_Index_KeepRouting_On name=OrderRouting_Index_KeepRouting
  label "On" for #OrderRouting_Index_KeepRouting_On
  input radio#OrderRouting_Index_KeepRouting_Off name=OrderRouting_Index_KeepRouting
  label "Off" for #OrderRouting_Index_KeepRouting_Off
block #OrderRouting_SettingsTable (hidden)
  button "Location"#divNew primary
  button "Import"#divImport
  button "Export"#divExport
  slot #OrderRouting_Index_Container
block #ActivityLogDiv (hidden)
  button "Close"
  input text#divActivityLogsSearch placeholder "Type text to search"
  button "Search" primary
  button #divActivityLogsRefresh
  slot #ActivityLogs_Container
modal#divOrderRoutingDetails small
  heading "Order routing details"
  button "×"
  slot #OrderRoutingDetails_Errors
  select#OrderRoutingDetails_Country
  label "Country" for #OrderRoutingDetails_Country
  input text#OrderRoutingDetails_StateProvince
  label "State/province" for #OrderRoutingDetails_StateProvince
  input text#OrderRoutingDetails_CitySububrb
  label "City/ suburb" for #OrderRoutingDetails_CitySububrb
  input text#OrderRoutingDetails_ZIP
  label "Zip / postcode" for #OrderRoutingDetails_ZIP
  select#OrderRoutingDetails_Location
  label "Location" for #OrderRoutingDetails_Location
  button "Save"#divSaveDetails primary
  button "Close"#btnCloseModal
form#frmExportOrderRouting
```

### `/RMAReasonForReturn`: Reason for return

Frame: `task-upload-frame`.

```text
link "Home"
link "Reference Books"
button "Tutorial"
text "Add reasons for returning an item."
button "Save"#divSaveChanges primary
button #divNew primary
input text#divSearchField placeholder "Type text to search"
button "Search" primary
slot #RMAReasonForReturn_Index_Container
button "Add more items"#RMAReasonForReturn_Index_NewLink primary
```

### `/RMAReturnOrderSettings`: Return order settings

Frame: `task-upload-frame`.

```text
link "Home"
link "Reference Books"
button "Tutorial"
heading "Return order settings"
button "Save"#divSaveChanges primary
label "When RMA is created in Cin7 Core, receive the returned products to" for #ReceiptsLocationID
slot #ReturnPolicyReceiptsLocation
label "Non-warranty expense account" for #NoWarrantyExpenseAccount
slot #NoWarrantyExpenseAccount
text "Expenses (replacement, inspection, repair, shipment etc.) incurred for items not covered by warranty will be charged to "
label "Warranty expense account" for #WarrantyExpenseAccount
slot #WarrantyExpenseAccount
text "Expenses (replacement, inspection, repair, shipment etc.) incurred for items covered by warranty will be charged to this"
label "Scrap/write-off default expense account" for #ScrapWriteOffDefaultExpenseAccount
slot #ScrapWriteOffDefaultExpenseAccount
text "Returned products that are scrapped/written-off will be charged to this expense account."
label "Credit note creation and authorization setting" for #CreateCreditNoteType
select#CreateCreditNoteType: After each product line is received | After all products are received
text "Credit notes can either be created for each receiving order (RO) line the uses authorizes, or alternatively a single cre"
text "Changes will be applied to new RMA orders only."
```

### `/RMAReturnPolicy`: Return policy

Frame: `task-upload-frame`.

```text
link "Home"
link "Reference Books"
button "Save"#saveBtn primary (hidden)
button "Tutorial"
button "Back to list"#btnBackToList (hidden)
block #updatePolicy (hidden)
  text "Add return policy to associate it further with the product. Set up attributes for new return policy Edit attributes for "
  heading #formCaption
  label "Active" for #tdRMAReturnPolicy_Index_IsActive
  input checkbox#tdRMAReturnPolicy_Index_IsActive
  label "Name" for #tdRMAReturnPolicy_Index_Name
  input text#tdRMAReturnPolicy_Index_Name placeholder "Enter a name for the return policy"
  text "Available for the following countries"
  label "Countries" for #tdRMAReturnPolicy_Index_Countries
  slot #tdRMAReturnPolicy_Index_Countries
  slot #countriesPlaceholder (hidden)
  text "Available for the following products"
  label "Product families" for #tdRMAReturnPolicy_Index_Families
  slot #tdRMAReturnPolicy_Index_Families
  slot #familiesPlaceholder (hidden)
  label "Tags" for #tdRMAReturnPolicy_Index_Tags
  slot #tdRMAReturnPolicy_Index_Tags
  slot #tagsPlaceholder (hidden)
  label "Categories" for #tdRMAReturnPolicy_Index_Categories
  slot #tdRMAReturnPolicy_Index_Categories
  slot #categoriesPlaceholder (hidden)
  label "Brands" for #tdRMAReturnPolicy_Index_Brands
  slot #tdRMAReturnPolicy_Index_Brands
  slot #brandsPlaceholder (hidden)
  heading "RMA processing milestones"
  slot #RMAMilestones_Index_Container
  button "Add more items"#RMAMilestones_Index_NewLink primary
  heading "Attributes"
  label "Return is possible" for #tdRMAReturnPolicy_Index_IsReturnPossible
  input checkbox#tdRMAReturnPolicy_Index_IsReturnPossible
  label "Return calculation start date"
  select#tdRMAReturnPolicy_Index_ReturnCalculationStartDate
  label "Return is available within X calendar days of the sale"
  input text#tdRMAReturnPolicy_Index_ReturnDays placeholder "Lifetime"
  label "Refund is possible" for #tdRMAReturnPolicy_Index_IsRefundPossible
  input checkbox#tdRMAReturnPolicy_Index_IsRefundPossible
  label "Refund payment options"
  input radio#tdRMAReturnPolicy_Index_RefundPaymentOptions_Credit name=tdRMAReturnPolicy_Index_RefundPaymentOptions
  label "Credit" for #tdRMAReturnPolicy_Index_RefundPaymentOptions_Credit
  input radio#tdRMAReturnPolicy_Index_RefundPaymentOptions_Original name=tdRMAReturnPolicy_Index_RefundPaymentOptions
  label "Based on original method of payment" for #tdRMAReturnPolicy_Index_RefundPaymentOptions_Original
  label "Refund calculation start date"
  select#tdRMAReturnPolicy_Index_RefundCalculationStartDate
  label "Refund is available within X calendar days of the sale"
  input text#tdRMAReturnPolicy_Index_RefundDays placeholder "Lifetime"
  label "Replacement is possible" for #tdRMAReturnPolicy_Index_IsReplacementPossible
  input checkbox#tdRMAReturnPolicy_Index_IsReplacementPossible
  label "Cross ship is possible" for #tdRMAReturnPolicy_Index_IsPossibleCrossSale
  input checkbox#tdRMAReturnPolicy_Index_IsPossibleCrossSale
  label "Replacement calculation start date"
  select#tdRMAReturnPolicy_Index_ReplacementCalculationStartDate
  label "Replacement is available within X calendar days"
  input text#tdRMAReturnPolicy_Index_ReplacementDays placeholder "Lifetime"
  label "Restocking fees"
  input radio#rbtnRMAReturnPolicy_Index_RestockingFees_Percent name=tdRMAReturnPolicy_Index_RestockingFeesType
  label "percent" for #rbtnRMAReturnPolicy_Index_RestockingFees_Percent
  input text#tdRMAReturnPolicy_Index_RestockingFeesPercent
  input radio#rbtnRMAReturnPolicy_Index_RestockingFees_Amount name=tdRMAReturnPolicy_Index_RestockingFeesType
  label "amount" for #rbtnRMAReturnPolicy_Index_RestockingFees_Amount
  input text#tdRMAReturnPolicy_Index_RestockingFeesFixedAmount
  slot #tdRMAReturnPolicy_Index_ReturnPolicyText
block #mainGrid
  button #divNew primary
  input text#divSearchField placeholder "Type text to search"
  button "Search" primary
  button #divExport
  slot #RMAReturnPolicy_Index_Container
modal#divNewCostTypeDialog small
  heading "Add a new cost type"
  button "×"
  input text#tdCostTypeName placeholder "Enter a name"
  label "Name" for #tdCostTypeName
  button "Save" primary
  button "Close"
```

### `/TenantAddress`: Company addresses

Frame: `task-upload-frame`.

```text
link "Home"
link "Reference Books"
button "Save"#divSaveChanges2 primary
button "Activity log" primary
button #divNew primary
button "Export"#divExport
slot #TenantAddress_Index_Container
button "Add more items"#TenantAddress_Index_NewLink primary
block #ActivityLogDiv (hidden)
  button "Close"
  input text#divActivityLogsSearch placeholder "Type text to search"
  button "Search" primary
  button #divActivityLogsRefresh
  slot #ActivityLogs_Container
modal#divAddressDetails small
  heading "Company address details"
  button "×"
  slot #AddressDetails_Errors
  input text#AddressDetails_Line1
  label "Line 1" for #AddressDetails_Line1
  input text#AddressDetails_Line2
  label "Line 2" for #AddressDetails_Line2
  input text#AddressDetails_CitySuburb
  label "City / suburb" for #AddressDetails_CitySuburb
  input text#AddressDetails_StateProvince
  label "State / province" for #AddressDetails_StateProvince
  input text#AddressDetails_ZipPostCode
  label "ZIP / postcode" for #AddressDetails_ZipPostCode
  select#AddressDetails_Country
  label "Country" for #AddressDetails_Country
  select#AddressDetails_Type: Billing | Business | Shipping
  label "Type" for #AddressDetails_Type
  input checkbox#AddressDetails_Default
  label "Default" for #AddressDetails_Default
  button "Save"#divSaveDetails primary
  button "Close"#btnCloseModal
form#frmExportAddresses
```

### `/TenantAttributeSet`: Additional attributes

Frame: `task-upload-frame`.

```text
link "Home"
link "Reference Books"
button "Activity log" primary
button #divNew primary
button "Export"#divExport
slot #TenantAttributeSet_Index_Container
modal#divAttributeDetails large
  input text#TenantAttributes_Index_AttributeSetName placeholder "Enter an attribute set name"
  button "×"
  button 
  heading "Attribute name"
  heading "Attribute type"
  heading "Values"
  input text#TenantAttributes_Index_Attribute1Name placeholder "Attribute 1 name"
  select#TenantAttributes_Index_Attribute1Type: Not used | List | Checkbox | Text | Numeric | Date
  input text#TenantAttributes_Index_Attribute1Values
  input text#TenantAttributes_Index_Attribute2Name placeholder "Attribute 2 name"
  select#TenantAttributes_Index_Attribute2Type: Not used | List | Checkbox | Text | Numeric | Date
  input text#TenantAttributes_Index_Attribute2Values
  input text#TenantAttributes_Index_Attribute3Name placeholder "Attribute 3 name"
  select#TenantAttributes_Index_Attribute3Type: Not used | List | Checkbox | Text | Numeric | Date
  input text#TenantAttributes_Index_Attribute3Values
  input text#TenantAttributes_Index_Attribute4Name placeholder "Attribute 4 name"
  select#TenantAttributes_Index_Attribute4Type: Not used | List | Checkbox | Text | Numeric | Date
  input text#TenantAttributes_Index_Attribute4Values
  input text#TenantAttributes_Index_Attribute5Name placeholder "Attribute 5 name"
  select#TenantAttributes_Index_Attribute5Type: Not used | List | Checkbox | Text | Numeric | Date
  input text#TenantAttributes_Index_Attribute5Values
  input text#TenantAttributes_Index_Attribute6Name placeholder "Attribute 6 name"
  select#TenantAttributes_Index_Attribute6Type: Not used | List | Checkbox | Text | Numeric | Date
  input text#TenantAttributes_Index_Attribute6Values
  input text#TenantAttributes_Index_Attribute7Name placeholder "Attribute 7 name"
  select#TenantAttributes_Index_Attribute7Type: Not used | List | Checkbox | Text | Numeric | Date
  input text#TenantAttributes_Index_Attribute7Values
  input text#TenantAttributes_Index_Attribute8Name placeholder "Attribute 8 name"
  select#TenantAttributes_Index_Attribute8Type: Not used | List | Checkbox | Text | Numeric | Date
  input text#TenantAttributes_Index_Attribute8Values
  input text#TenantAttributes_Index_Attribute9Name placeholder "Attribute 9 name"
  select#TenantAttributes_Index_Attribute9Type: Not used | List | Checkbox | Text | Numeric | Date
  input text#TenantAttributes_Index_Attribute9Values
  input text#TenantAttributes_Index_Attribute10Name placeholder "Attribute 10 name"
  select#TenantAttributes_Index_Attribute10Type: Not used | List | Checkbox | Text | Numeric | Date
  input text#TenantAttributes_Index_Attribute10Values
  button "Save"#divSaveChanges primary
  button "Close"
block #ActivityLogDiv (hidden)
  button "Close"
  input text#divActivityLogsSearch placeholder "Type text to search"
  button "Search" primary
  button #divActivityLogsRefresh
  slot #ActivityLogs_Container
form#frmExportAttributeSets
```

### `/TenantBrand`: Product brands

Frame: `task-upload-frame`.

```text
link "Home"
link "Reference Books"
button "Save"#divSaveChanges primary
button "Activity log" primary
button #divNew primary
button "Export"#divExport
slot #TenantBrand_Index_Container
button "Add more items"#TenantBrand_Index_NewLink primary
block #ActivityLogDiv (hidden)
  button "Close"
  input text#divActivityLogsSearch placeholder "Type text to search"
  button "Search" primary
  button #divActivityLogsRefresh
  slot #ActivityLogs_Container
modal#divBrandDetails small
  heading "Brand details"
  button "×"
  slot #BrandDetails_Errors
  input text#BrandDetails_Brand
  label "Brand" for #BrandDetails_Brand
  button "Save"#divSaveDetails primary
  button "Close"#btnCloseModal
form#frmExportBrands
```

### `/TenantCarrier`: Carriers

Frame: `task-upload-frame`.

```text
link "Home"
link "Reference Books"
button "Save"#divSaveChanges primary
button "Activity log" primary
button #divNew primary
button "Export"#divExport
slot #TenantCarrier_Index_Container
button "Add more items"#TenantCarrier_Index_NewLink primary
block #ActivityLogDiv (hidden)
  button "Close"
  input text#divActivityLogsSearch placeholder "Type text to search"
  button "Search" primary
  button #divActivityLogsRefresh
  slot #ActivityLogs_Container
modal#divCarrierDetails small
  heading "Carrier details"
  button "×"
  slot #CarrierDetails_Errors
  input text#CarrierDetails_Description
  label "Carrier name" for #CarrierDetails_Description
  input text#CarrierDetails_TrackingURL
  label "Tracking URL" for #CarrierDetails_TrackingURL
  button "Save"#divSaveDetails primary
  button "Close"#btnCloseModal
form#frmExportCarriers
```

### `/TenantContact`: Company contacts

Frame: `task-upload-frame`.

```text
link "Home"
link "Reference Books"
button "Save"#divSaveChanges2 primary
button "Activity log" primary
button #divNew primary
button "Export"#divExport
button "Reassign"#btnReassignCompanyContactOpenDialog
input text#divSearchField name=divSearch placeholder "Type text to search"
button "Search" primary
slot #TenantContact_Index_Container
button "Add more items"#TenantContact_Index_NewLink primary
modal#divContactDetails small
  heading "Company contact details"
  button "×"
  slot #ContactDetails_Errors
  input text#ContactDetails_Name
  label "Name" for #ContactDetails_Name
  input text#ContactDetails_Phone
  label "Phone" for #ContactDetails_Phone
  input text#ContactDetails_Fax
  label "Fax" for #ContactDetails_Fax
  input text#ContactDetails_Email
  label "Email" for #ContactDetails_Email
  input text#ContactDetails_Website
  label "Website" for #ContactDetails_Website
  select#ContactDetails_Type: Billing | Business | Sale | Shipping | Employee
  label "Type" for #AddressDetails_Type
  input checkbox#ContactDetails_Default
  label "Default" for #ContactDetails_Default
  select#selMailingList multiple
  label "Mailing list" for #AddressDetails_Country
  button "Save"#divSaveDetails primary
  button "Close"#btnCloseModal
modal#divReassignCompanyContact small
  heading "Reassign company contact"
  button "×"
  slot #divReassignFromContact
  label "Reassign from"
  slot #divReassignToContact
  label "Reassign to"
  button "Reassign"#btnReassignCompanyContact primary
  button "Close"#btnCloseReassignModal
block #ActivityLogDiv (hidden)
  button "Close"
  input text#divActivityLogsSearch placeholder "Type text to search"
  button "Search" primary
  button #divActivityLogsRefresh
  slot #ActivityLogs_Container
modal#divCOGSAccDims small
  heading "Accounting dimensions"
  button "×"
  button "Save"#btnSaveCOGSAccDims primary
  button "Close"
form#frmExportContacts
```

### `/TenantInventoryCategory`: Product categories

Frame: `task-upload-frame`.

```text
link "Home"
link "Reference Books"
button "Save"#divSaveChanges primary
button "Activity log" primary
button #divNew primary
button "Export"#divExport
slot #TenantInventoryCategory_Index_Container
button "Add more items"#TenantInventoryCategory_Index_NewLink primary
block #ActivityLogDiv (hidden)
  button "Close"
  input text#divActivityLogsSearch placeholder "Type text to search"
  button "Search" primary
  button #divActivityLogsRefresh
  slot #ActivityLogs_Container
modal#divInventoryCategoryDetails small
  heading "Inventory category details"
  button "×"
  slot #InventoryCategoryDetails_Errors
  input text#InventoryCategoryDetails_InventoryCategory
  label "Category" for #InventoryCategoryDetails_InventoryCategory
  button "Save"#divSaveDetails primary
  button "Close"#btnCloseModal
form#frmExportInventoryCategory
```

### `/TenantLocation`: Locations and bins

Frame: `task-upload-frame`.

```text
link "Home"
link "Reference Books"
button "Save"#divSaveChanges2 primary
heading "Locations and bins"
button "Activity log" primary
button "Locations"#tabLocations
button "Logistics paths"#tabLogisticsPath
tab pane#portlet_tab1
  button #divNew primary
  block #divImport
    button "Import" ▾
    block #importDropdownList
      link "Inventory supply rules"
      link "Inventory put away rules"
  block #divExport
    button "Export" ▾
    block #exportDropdownList
      link "Locations with bins"#divExportwBins
      link "Supply rules"#btnExportSupplyRules
      link "Put away rules"#btnExportPutAwayRules
  slot #TenantLocation_Index_Container
  button "Add more items"#TenantLocation_Index_AddLink primary
tab pane#portlet_tab5
  text "Logistics paths are applied to production orders and to orders related to them. For more complicated routing please set "
  button #divNewPath primary
  slot #TenantLocation_Index_LogisticsPaths
  button "Add more items"#TenantLocation_Index_AddLPLink primary
form#frmExportLocationsWithBins
form#frmExportRules
form#frmExportPutAwayRules
block #ActivityLogDiv (hidden)
  button "Close"
  input text#divActivityLogsSearch placeholder "Type text to search"
  button "Search" primary
  button #divActivityLogsRefresh
  slot #ActivityLogs_Container
slot #CountrySpecificScript
```

### `/TenantLocationEdit`: Edit location

Frame: `task-upload-frame`.

```text
link "Home"
link "Reference Books"
link "Locations"
select#cmbLocationList: New location
button "Save" primary
button "Back to list"#btnBack
tabs#ulNavigation: General #general | Transfer planning #supplyintervals | Bins #bins | Pick zones #pickzones | Supply rules #supplyrules | Delivery calendar #deliveryCalendar
heading 
text "Default"#spnLocationStatus
button #taskHeaderCollapse
block #divTaskHeader
  input text#txtTenantLocationName
  label "Name"
  select#cmbLocationType: Warehouse/retail | Fixed assets | Shop floor | Co-manufacturing
  label "Type"
  heading "Status"
  block #divRbtnsActive
    input radio#rbtnTenantLocationActive name=locationStatus
    label "Active" for #rbtnTenantLocationActive
    input radio#rbtnTenantLocationDeprecated name=locationStatus
    label "Deprecated" for #rbtnTenantLocationDeprecated
  heading "Options"
  input checkbox#chkTenantLocationType
  label "Set as default" for #chkTenantLocationType
  input checkbox#chkTenantLocationReorder
  label "Allow to reorder stock level" for #chkTenantLocationReorder
  slot #divTenantLocationIsDesignatedZone (hidden)
  input checkbox#chkTenantLocationUseDirectedPick
  label "Use directed pick" for #chkTenantLocationUseDirectedPick
  block #directed-pick-note (hidden)
    text "The sale order pick using bin group will take priority over the "recommend & enforce" setting."
  input checkbox#chkTenantLocationUseDirectedPutAway
  label "Use directed receive/put away" for #chkTenantLocationUseDirectedPutAway
  slot #divBinSuggestionPriority
  label "Bin suggestion priority" for #cmbBinSuggestionPriority
  heading "Address"
  input text#txtTenantLocationAddressLine1
  label "Line 1"
  input text#txtTenantLocationAddressLine2
  label "Line 2"
  input text#txtTenantLocationAddressCitySuburb
  label "City / suburb"
  input text#txtTenantLocationAddressStateProvince
  label "State / province"
  input text#txtTenantLocationAddressZipPostCode
  label "ZIP / postcode"
  slot #cmbTenantLocationAddressCountry
  label "Country"
  slot #divLocationEmirate (hidden)
  heading "Description"
  textarea#txtTenantLocationAddressDescription placeholder "Type description"
tab pane#general
tab pane#supplyintervals
  block #divSupplyIntervalsContainer
    button #btnAddInterval primary
    text "These settings are used to plan transfer order supply suggestions. When carrying out a Materials Requirements Planning ("
    block #divSupplyIntervalTemplate (hidden)
      label "Planning method"
      select: Transfer at intervals | Transfer on fixed days
      label "Demand location"
      select#cmbDemandLocation
      slot #divSelectedDemandLocation (hidden)
      label "Interval"
      input text
      label "days"
      label "Start date"
      slot #dtSupplyIntervalDate
      label "Fixed days"
      input checkbox#chkFixedMonday
      label "Monday" for #chkFixedMonday
      input checkbox#chkFixedTuesday
      label "Tuesday" for #chkFixedTuesday
      input checkbox#chkFixedWednesday
      label "Wednesday" for #chkFixedWednesday
      input checkbox#chkFixedThursday
      label "Thursday" for #chkFixedThursday
      input checkbox#chkFixedFriday
      label "Friday" for #chkFixedFriday
      input checkbox#chkFixedSaturday
      label "Saturday" for #chkFixedSaturday
      input checkbox#chkFixedSunday
      label "Sunday" for #chkFixedSunday
tab pane#bins
  block #divBinsToolbar
    tabs#binsTabs: Bins #binsContent | Directed put away rules #putAwayRulesContent | Bin groups #binGroupContent
  tab pane#binsContent
    button  primary
    input text#txtBinsSearchField placeholder "Type text to search"
    button "Search"#btnBinsSearch primary
    button "+ Bin group"#addBinGroupBtn primary (hidden)
    button "Export"#btnExportBin
    button "Import"#btnImportBin
    block #divBinsAlert
      text "Location is not saved. Please click save before adding bins to the selected location."
    slot #divGridBins
    button "Add more items" primary
    form#frmExportBins
  tab pane#putAwayRulesContent
    block #divPutAwayRulesContainer
      button  primary
      slot #divGridPutAwayRules
      button "Add more rules" primary
    block #divPutAwayRuleEditContainer (hidden)
      heading "New put away rule"
      input text#txtPutAwayRuleName placeholder "Put Away Rule name"
      label "Name"
      label "Active" for #chkPutAwayRuleIsActive
      input checkbox#chkPutAwayRuleIsActive
      label "Bin"
      select#cmbPutAwayRuleBin
      slot #divPutAwayRuleBinValues (hidden)
      input text#txtPutAwayRuleMinCapacity
      label "Min capacity"
      input text#txtPutAwayRuleMaxCapacity
      label "Max capacity"
      input checkbox#chkPutAwayRuleAllowSplit
      label "Allow batch split at receive/put away" for #chkPutAwayRuleAllowSplit
      block #divErrorMessage (hidden)
      input text#txtPutAwayRuleMinLength
      label "Min length"
      input text#txtPutAwayRuleMaxLength
      label "Max length"
      input text#txtPutAwayRuleMinWidth
      label "Min width"
      input text#txtPutAwayRuleMaxWidth
      label "Max width"
      input text#txtPutAwayRuleMinHeight
      label "Min height"
      input text#txtPutAwayRuleMaxHeight
      label "Max height"
      input text#txtPutAwayRuleMinWeight
      label "Min weight"
      input text#txtPutAwayRuleMaxWeight
      label "Max weight"
      slot #spanUOFWeightUnit
      input radio#rbtnProductAll2 name=productarea
      label "All products" for #rbtnProductAll2
      input radio#rbtnProductSelect2 name=productarea
      label "Select products" for #rbtnProductSelect2
      block #divPutAwayProductArea (hidden)
        heading "Apply rules to these products:"
        select#cmbFamiliesputaway
        slot #divSelectedFamiliesValuesputaway (hidden)
        select#cmbTagsputaway
        slot #divSelectedTagsValuesputaway (hidden)
        select#cmbCategoriesputaway
        slot #divSelectedCategoriesValuesputaway (hidden)
        select#cmbBrandsputaway
        slot #divSelectedBrandsValuesputaway (hidden)
        heading "OR"
        select#cmbProductsputaway
        slot #divSelectedProductsValuesputaway (hidden)
  tab pane#binGroupContent
    block #divBinGroupsContainer
      button  primary
      slot #divGridBinGroups
      button "Add more groups" primary
    block #divBinGroupEditContainer (hidden)
      heading "New bin group"
      input text#txtBinGroupName placeholder "Name"
      label "Name"
      label "Bins"
      select#cmbBinGroupBin
      slot #divBinGroupBinValues (hidden)
tab pane#pickzones
  button  primary
  slot #divGridPickZones
  button "Add more items" primary
tab pane#supplyrules
  block #divSupplyRulesContainer
    button  primary
    slot #divGridRules
    button "Add more rules" primary
  block #divSupplyRuleEditContainer (hidden)
    heading "New supply rule"
    input text#txtSupplyRuleName placeholder "Supply Rule name"
    label "Name"
    label "Active" for #chkSupplyRuleIsActive
    input checkbox#chkSupplyRuleIsActive
    input radio#rbtnProductAll name=productarea
    label "All products" for #rbtnProductAll
    input radio#rbtnProductSelect name=productarea
    label "Select products" for #rbtnProductSelect
    block #divSupplyRuleProductArea (hidden)
      heading "Apply rules to these products:"
      select#cmbFamiliessupply
      slot #divSelectedFamiliesValuessupply (hidden)
      select#cmbTagssupply
      slot #divSelectedTagsValuessupply (hidden)
      select#cmbCategoriessupply
      slot #divSelectedCategoriesValuessupply (hidden)
      select#cmbBrandssupply
      slot #divSelectedBrandsValuessupply (hidden)
      heading "OR"
      select#cmbProductssupply
      slot #divSelectedProductsValuessupply (hidden)
    block #divSupplyRuleActions
      heading 
      slot #divSupplyRuleList
      button "Add more items" primary
      slot #divSupplyRuleOtherwise
      block #divSupplyRuleActionTemplate (hidden)
        select: Purchase | Transfer | Produce
        label "from"
        select
        label "take"
        select: All available | Until minimum before reorder | Until stock level
        label "to fulfill"
        select: Total demand quantity only | Partial demand quantity
        label "if >"
        input text
        label "% production capacity is available"
        select: With the lowest price | With the lowest lead time | Latest supplier
tab pane#deliveryCalendar
  block #deliveryCalendarSettings
    button "Delivery scheduling"#openDeliveryCalendarButton primary
    input number#txtDeliveryNumberPerDay
    label "No. Of deliveries per day"
    input number#txtDeliveryTimeInterval
    label "Delivery time interval, mins"
modal#DearPos_YearCalendar
  heading "Delivery scheduling calendar settings"
  button "×"
  button 
  slot #currentYearSpan
  button 
  button "Calendar settings"#editCalendarSettings
  slot #calendarContainer
  button #addHolidayBtn
  slot #divHolidaysGrid
  button #addSpecialBtn
  slot #divSpecialsGrid
  block #DearPos_Calendar_Actions
    button "Save" primary
    button "Cancel"
modal#calendarSettingsModal medium
  heading "Calendar settings"
  button "×"
  slot #weekStartCmb
  label "Working week starts on:" for #weekStartCmb
  slot #weekEndsCmb
  label "Select weekend days:" for #weekEndsCmb
  slot #divDaysGrid
  button "Apply changes"#applyCalendarSettingsBtn primary
slot #CountrySpecificScript
```

### `/TenantPaymentTerm`: Payment terms

Frame: `task-upload-frame`.

```text
link "Home"
link "Reference Books"
button "Save"#divSaveChanges primary
button "Activity log" primary
button #divNew primary
button "Export"#divExport
slot #TenantPaymentTerm_Index_Container
button "Add more items"#TenantPaymentTerm_Index_NewLink primary
modal#divTenantPaymentTermDetails small
  heading "Payment term details"
  button "×"
  slot #TenantPaymentTerm_Errors (hidden)
  input text#TenantPaymentTerm_Description
  label "Name" for #TenantPaymentTerm_Description
  select#TenantPaymentTerm_Method: Number of days | Day of next month | Last day of next month | Days since the end of the month
  label "Method" for #TenantPaymentTerm_Method
  input text#TenantPaymentTerm_Days
  label "Days" for #TenantPaymentTerm_Days
  input checkbox#TenantPaymentTerm_IsDefault
  label "Is default" for #TenantPaymentTerm_IsDefault
  input checkbox#TenantPaymentTerm_IsActive
  label "Is active" for #TenantPaymentTerm_IsActive
  button "Save" primary
  button "Close"
block #ActivityLogDiv (hidden)
  button "Close"
  input text#divActivityLogsSearch placeholder "Type text to search"
  button "Search" primary
  button #divActivityLogsRefresh
  slot #ActivityLogs_Container
form#frmExportPaymentTerm
```

### `/TenantShipZone`: Shipping zones

Frame: `task-upload-frame`.

```text
link "Home"
link "Reference Books"
block #ShipZoneList
  text "Use shipping zones to choose the locations that you ship to. Define your shipping rates for each zone that could be auto"
  block #descriptionNote
    heading 
  button "Shipping zone"#divNew primary
  button "Rest of world zone"#divNewRest primary
  button "Exception zone"#divNewNegative primary
  button "Import"#divImport
  button "Export"#divExport
  label "Enabled" for #TenantShippingZone_Index_Switch
  input checkbox#TenantShippingZone_Index_Switch
  slot #TenantShippingZone_Index_Container
block #divZoneDetails (hidden)
  block #ShipZone_Details_Content
    button "Activity log"#ActivityLogsLink2 primary
    button "Delete"#ShipZone_DeleteAction2
    button "Save"#ShipZone_SaveAction2 primary
    button "Cancel"#ShipZone_CancelAction2
    input text#txtShipZoneName name=tdOpeningBalances_NewCustomer_Discount placeholder "Zone name..."
    block #cmbTaxRuleBlock
      select#cmbTaxRule
    block #DefaultShipCostBlock
      input text#ShippingZone_Details_CostFixed
      label "Default shipping cost" for #ShippingZone_Details_CostFixed
      slot #defCurrency
    block #ShipZoneContents
      heading "Applies to"
      button #divAddCountry primary
      slot #divZoneCountries
      button "Add more items"#addMoreZoneContries primary
      block #RatesBlock
        text "Note: If price-/weight-based rates are set up, they have a higher priority than the shipping zones rate."
        heading "Price-based rates"
        button #divAddPriceRates primary
        label "Tax included" for #PricesInclTax
        input checkbox#PricesInclTax
        slot #divPriceGrid
        heading "Weight-based rates"
        button #divAddWeightRate primary
        slot #divWeightGrid
      button "Save"#ShipZone_SaveAction primary
      button "Cancel"#ShipZone_CancelAction
block #ActivityLogDiv (hidden)
  button "Close"
  input text#divActivityLogsSearch placeholder "Type text to search"
  button "Search" primary
  button #divActivityLogsRefresh
  slot #ActivityLogs_Container
modal#ShipZone_EditCountry_Content
  button 
  heading "Add/edit shipping place"
  label "Country"
  select#ShipZone_EditCountry_CountryList
  label "Whole country" + checkbox #ShipZone_EditCountry_CountryAllRegions
  slot #ShipZone_EditCountry_StateList
  button "Save"
  button "Close"
form#frmExportShippingZones
```

### `/TenantTaxationRule`: Tax rules

Frame: `task-upload-frame`.

```text
link "Home"
link "Reference Books"
button "Load from QuickBooks"#divLoad primary
block #divTaxList
  button "Activity log" primary
  button #gridOptions
  button #divNew primary
  button "Export"#divExport
  input checkbox#divShowOnlyActive
  label "Only active" for #divShowOnlyActive
  slot #TenantTaxationRule_Index_Container
block #divTaxDetails
  slot #formCaption
  slot #Tax_Status
  button "Save"#saveAction primary
  button "Close"#backAction
  label "Tax rule name"
  input text#tdDescription placeholder "Enter a tax rule name"
  label "Inclusive/exclusive"
  select#tdInclusive
  label "Status"
  select#tdStatus
  label "Tax type"
  select#tdTax1
  label "Liability account"
  slot #tdAccountCode
  button #divNewComponent primary
  button #ComponentsGridOptions
  slot #cntComponents
  button "Add more items"#TenantTaxationRule_Index_AddComponentLink primary
modal#divComponentDetails small
  heading "Component details"
  button "×"
  slot #ComponentDetails_Errors (hidden)
  input text#ComponentDetails_Name placeholder "Type name..."
  label "Tax component name" for #ComponentDetails_Name
  input text#ComponentDetails_Rate
  label "Rate"
  input checkbox#ComponentDetails_Compound
  label "Compound (apply to taxed subtotal)" for #ComponentDetails_Compound
  slot #ComponentDetails_LiabilityAccount
  label "Liability account" for #ComponentDetails_LiabilityAccount
  button "Save"#divSaveDetails primary
  button "Close"#btnCloseModal
block #ActivityLogDiv (hidden)
  button "Close"
  input text#divActivityLogsSearch placeholder "Type text to search"
  button "Search" primary
  button #divActivityLogsRefresh
  slot #ActivityLogs_Container
form#frmExportTaxationRules
```

### `/TenantUnitOfMeasure`: Units of measure

Frame: `task-upload-frame`.

```text
link "Home"
link "Reference Books"
button "Save"#divSaveChanges primary
button "Activity log" primary
button #divNew primary
button "Export"#divExport
slot #TenantUnitOfMeasure_Index_Container
button "Add more items"#TenantUnitOfMeasure_Index_NewLink primary
block #ActivityLogDiv (hidden)
  button "Close"
  input text#divActivityLogsSearch placeholder "Type text to search"
  button "Search" primary
  button #divActivityLogsRefresh
  slot #ActivityLogs_Container
modal#divUnitOfMeasureDetails small
  heading "Unit of measure details"
  button "×"
  slot #UnitOfMeasureDetails_Errors
  input text#UnitOfMeasureDetails_UnitOfMeasure
  label "Name" for #UnitOfMeasureDetails_UnitOfMeasure
  button "Save"#divSaveDetails primary
  button "Close"#btnCloseModal
form#frmExportUnitOfMeasure
```

### `/WarrantySetupList`: Warranties

Frame: `task-upload-frame`.

```text
link "Home"
link "Reference Books"
button #divNew primary
button #divRefresh primary
slot #divFilter
input text#divSearchText name=divSearch placeholder "Type text to search"
button "Search"#divSearch primary
slot #WarrantySetupList_Error_Container (hidden)
slot #WarrantySetupList_Index_Container
```

## Components by bundle

What the page code builds and mounts into the layout's slots.

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

