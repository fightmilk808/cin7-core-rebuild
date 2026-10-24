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

## Layout

Each screen's server-rendered HTML inside the shell, as an outline: headings, tabs, sections, labels, inputs (`#id`), buttons (`▾` = dropdown), menus, tables and `slot`s (empty `<div>`s the components below mount into). `(hidden)` parts are shown by the page code when needed. Read with GET from a signed-in session; no values are kept.

### `/BankAccount`: Bank accounts

Redirects to `/BankAccounts`.

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

### `/BankRule`: Bank rules

Frame: `task-upload-frame`.

```text
link "Home"
link "Bank accounts"
button "Back to list"
block #BankRule_RuleList
  heading "Bank rules"
  block #divAddRule
    button  primary
    link "Spend money"#NewSpendRule
    link "Receive money"#DeleteDeprecated
  button "Filter" ▾
    text "Filter"#divFilter
  slot #divFilterMenu
  input text#divSearchRules name=divSearch placeholder "Type text to search"
  button "Search" primary
  block #divActions
    button "Bulk actions" ▾
    link "Enable/disable rule"#EnableDisableRule
    link "Delete disabled rules"#DeleteDeprecated
  button #divRefreshRules
  button #Grid_bankRuleGrid_Options
  slot #ruleGridContainer
block #divRuleDetails (hidden)
  block #BankRule_Details_Content
    heading #BankRule_FormCaption
    button "Save"#BankRule_SaveAction2 primary
    button "Cancel"#BankRule_CancelAction2
    block #divTaskHeader
      slot #divBankRuleName
      label "Rule name" for #txtBankRuleName
      slot #divBankRuleTarget
      label "Bank account" for #cmbBankRuleTarget
      slot #divBankRulePriority
      label "Rule priority" for #cmbBankRulePriority
      textarea#divBankRuleDesc placeholder "Write your note here..."
      label "Short description" for #txtBankRuleDesc
    slot #BankRule_FirstLine
    slot #divBankRuleContitionType
    slot #divBankRuleConditions
    button "Add a condition"#divNewCondition primary
    slot #divBankRuleContact
    label "" for #cmbBankRuleContact
    slot #divBankRuleReference
    label "And the reference will be set" for #cmbBankRuleReference
    heading "Automatically allocate fixed value line items..."
    slot #divBankRuleFixedLines
    button "Add a new line"#divNewFixedLine primary
    heading "With the remainder, allocate items in the following ratios..."
    slot #divBankRuleRelativeLines
    button "Add a new line"#divNewRelativeLine primary
    block #divBankRule_RelTotal
      table: Total
modal#BankRule_NewSupplier_Content medium
  heading "Add a supplier"
  button "×"
  slot #divNewSupplierName
  label "Name" for #txtNewSupplierName
  slot #divNewSupplierPaymentTerm
  label "Payment term" for #cmbNewSupplierPaymentTerm
  slot #divNewSupplierTaxRule
  label "Tax rule" for #cmbNewSupplierTaxRule
  slot #divNewSupplierDiscount
  label "Discount" for #txtNewSupplierDiscount
  slot #divNewSupplierCurreny
  label "Currency" for #cmbNewSupplierCurreny
  slot #divNewSupplierAccountPayable
  label "Account payable" for #cmbNewSupplierAccountPayable
  slot #divNewSupplierDefaultCarrier
  label "Default carrier" for #cmbNewSupplierDefaultCarrier
  slot #divNewSupplierTaxNumber
  label "Tax number" for #txtNewSupplierTaxNumber
  textarea#divNewSupplierComments placeholder "Write your comments here..."
  label "Comments"
  button "Save" primary
  button "Close"
modal#BankRule_NewCustomer_Content medium
  heading "Add a customer"
  button "×"
  slot #divNewCustomerName
  label "Name" for #txtNewCustomerName
  slot #divNewCustomerPaymentTerm
  label "Payment term" for #cmbNewCustomerPaymentTerm
  slot #divNewCustomerSaleAccount
  label "Sale account" for #cmbNewCustomerSaleAccount
  slot #divNewCustomerSalesRep
  label "Sales rep" for #cmbNewCustomerSalesRep
  slot #divNewCustomerDefaultLocation
  label "Default location" for #cmbNewCustomerDefaultLocation
  slot #divNewCustomerDiscount
  label "Discount" for #txtNewCustomerDiscount
  slot #divNewCustomerCurreny
  label "Currency" for #cmbNewCustomerCurreny
  slot #divNewCustomerAccountReceivable
  label "Account receivable" for #cmbNewCustomerAccountReceivable
  slot #divNewCustomerTaxRule
  label "Tax rule" for #cmbNewCustomerTaxRule
  slot #divNewCustomerDefaultCarrier
  label "Default carrier" for #cmbNewCustomerDefaultCarrier
  slot #divNewCustomerTaxNumber
  label "Tax number" for #txtNewCustomerTaxNumber
  slot #divNewCustomerSalePriceTier
  label "Sale price tier" for #cmbNewCustomerSalePriceTier
  textarea#divNewCustomerComments placeholder "Write your comments here..."
  label "Comments"
  button "Save" primary
  button "Close"
```

### `/BankStatement`: Bank accounts

Redirects to `/BankAccounts`.

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

### `/Cin7Capital`: Cin7 Capital

Frame: `task-upload-frame`.

```text
link "Home"
link "Integrations"
button "Help"
heading "Cin7 Capital"
tabs#settingsTabs: Cin7 Capital powered by Stripe #aboutCin7PayCapital | Cin7 Capital powered by Kanmon #aboutKanmon
tab pane#aboutCin7PayCapital
  heading "Cin7 Capital powered by Stripe"
  text "Cin7 Capital offers quick, affordable business financing, available for eligible businesses using Cin7 Pay for their pay"
  text "Depending on eligibility and your selections, you may be able to access:"
  text "If your business is using Cin7 Pay for payments processing, you can apply for financing through the Cin7 Pay admin page."
  button "Open the Cin7 Pay admin area" primary
  text "Don't have Cin7 Pay? Contact us to learn more."
  text "How do you determine who qualifies for an offer?"
  text "Eligibility is determined based on a combination of factors, including overall sales volume and history with Cin7 Pay. E"
  text "Do I have to pay interest?"
  text "No, you'll pay one flat fee that doesn't change. You won't pay any interest on top of this fee."
  text "Will applying for an offer affect my personal credit rating?"
  text "Applying for financing through Stripe Capital might require a personal credit check under some circumstances, but this c"
  text "Can I request a different offer amount?"
  text "When you log into your Cin7 Pay admin page, you can use a slider to choose a custom amount (up to the maximum offer amou"
  text "When do I need to pay the flat fee?"
  text "You'll automatically pay the flat fee through a percentage of your sales until the total amount financed is repaid. The "
  text "How does payment work?"
  text "Payment is collected automatically through a percentage of your Cin7 Pay sales as they're processed which means you pay "
  text "What's a minimum payment?"
  text "A minimum payment is the minimum amount that you're expected to pay every payment period. That period will be determined"
  text "How do I make my minimum payment?"
  text "If your payments deducted from sales cover the minimum payment requirement for payment period, no action will be taken. "
  text "After I accept an offer, how quickly will I get my funds?"
  text "If your application is approved, you'll see the funds in your bank account typically in as soon as 2 business days. To m"
  text "Can I have my Capital funds paid out to a card?"
  text "We currently don't support disbursal of funds to a card. To make sure that funds are disbursed successfully, you must se"
  text "What happens when my offer expires?"
  text "Each offer is available for 30 days. After that point, your business will automatically be re-evaluated to see if you're"
  text "Can I pay my financing early?"
  text "Yes, you can make additional payments or pay the total amount financed in full at any point by clicking the 'Make Paymen"
  text "Will paying early qualify me for a new offer?"
  text "After you pay the total amount financed, we'll automatically evaluate you for a new offer. Paying early doesn't automati"
  text "How should I report these funds on my taxes?"
  text "Tax reporting is often dependent on your specific situation, so we encourage you to talk with a tax advisor to ensure ap"
  text "Who can I contact to learn more about the Stripe Capital program?"
  text "If you have additional questions about how our financing program through Stripe Capital works, you can contact our partn"
tab pane#aboutKanmon
  heading "Cin7 Capital—embedded financing"
  text "Cin7 Capital offers quick and affordable business financing options from inside Cin7 Core."
  text "To apply for Cin7 Capital, open the Cin7 Capital funding portal below. Funding is provided by our trusted partner Kanmon"
  button "Open the Cin7 Capital funding portal" primary
  text "Who is Kanmon?"
  text "Kanmon is a licensed business lender founded by a team with deep financial technology experience and backed by long-stan"
  text "Eligibility, credit limits, and turnaround time"
  text "Cin7 Capital is available to business owners based in the United States only. Once you submit an application, you can ex"
  text "Your offer is determined by our trusted partner Kanmon. Their determination will be based on a variety of factors relate"
  text "Apply for Cin7 Capital"
  text "To apply for a term loan, a line of credit, or invoice financing, open the Cin7 Capital funding portal above."
  text "You will need to connect Kanmon to your bank account via Plaid, so Kanmon can securely review your cash flow and determi"
  text "When you apply for Cin7 Capital, Kanmon makes a soft pull of your credit report. This does not affect your personal cred"
  text "Repayments, prepayments, and late fees"
  text "Your exact repayments schedule will depend on the terms of your agreement with Kanmon."
  text "Kanmon typically deducts repayments from the bank account of your choice on a monthly basis and accepts penalty-free pre"
  text "Outstanding balances, payments history, and account management"
  text "To view any outstanding balances, your payments history, and other useful information, open the Cin7 Capital funding por"
  text "More information"
  text "For a full overview and instructions, see Cin7 Capital in the Help Center."
```

### `/Cin7Pay`: Cin7 Pay

Frame: `task-upload-frame`.

```text
modal#Cin7Pay_CardOnFile_Off_To_On_Modal small
  heading "Terms and conditions"
  button "×"
  link "saved payment methods terms and conditions"
  slot #Cin7Pay_Index_AgreeCardOnFile
  label "I accept the terms and conditions" for #chkAgreeCardOnFile
  button "Activate"#btn_ActivateCardOnFile primary
  button "Cancel"
modal#Cin7Pay_CardOnFile_On_To_Off_Modal small
  heading "Deactivate saved payment methods"
  button "×"
  button "Deactivate"#btn_DeActivateCardOnFile primary
  button "Cancel"
modal#CardOnFile_ChooseCustomers_Content
  heading "Add customers"
  button "×"
  slot #divCardOnFileSearchCustomers
  label "Search"
  block #CardOnFile_Request_Customers_Container
    table: Customer | Status
  button "+ Customer" primary
  button "Cancel"
modal#CardOnFile_LinkCustomers_Content medium
  heading "Link customers"
  button "×"
  input text#stripeCustomerSearch placeholder "Search"
  button "Search"#stripeCustomerSearchBtn primary
  slot #divUnlinkedCin7PayCustomers_Container
  text "Link customers one page at a time. Moving ahead without clicking Link will clear your selections"
  button "Link"#btn_ActivateCardOnFileLinking primary
  button "Cancel"
modal#Cin7Pay_CardOnFile_Customer_Link_Modal small
  heading "Confirm links"
  button "×"
  link "terms and conditions"
  button "Accept and link"#btn_ActivateCardOnFileLinkingCustomers primary
  button "Cancel"
modal#Cin7Pay_Payment_Method_Setup_Modal small
  heading "Save payment method"
  button "×"
  slot #cin7paypaymentmethodsetup-element
  slot #error-message
  block #setupNoteText
    link "terms and conditions"
  block #div_CardOnFile_AddPaymentMethods_Buttons
    button "Accept and save"#btnCin7PayPaymentMethodSetup primary
    button "Cancel"
  block #div_CardOnFile_AddPaymentMethods_Processing (hidden)
modal#CardOnFile_BulkCustomers_Content small
  heading "Confirm bulk adding customers"
  button "×"
  button "Accept and add"#btn_AddBulkCardOnFileCustomers primary
  button "Cancel"#btn_AddBulkCardOnFileCustomersCancel
  text "Customers are being added. Please don't refresh or close this page."#divBulkCofCustomersProcessingText (hidden)
modal#Cin7Pay_Surcharge_Off_To_On_Modal small
  heading "Activate surcharges"
  button "×"
  slot #Cin7Pay_Index_AgreeSurcharge
  label "I understand the legal requirements" for #chkAgreeSurcharge
  button "Activate"#btn_ActivateSurcharge primary
  button "Cancel"
modal#Cin7Pay_Surcharge_On_To_Off_Modal small
  heading "Deactivate surcharge"
  button "×"
  button "Deactivate"#btn_DeActivateSurcharge primary
  button "Cancel"
link "Home"
link "Money"
button "Get support"#cin7pay-help-portal
slot #btnCin7PayTutorial
heading "Flexible payments, seamlessly integrated"
text "Cin7 Pay is a powerful, fully integrated payment solution designed to simplify payment processing."
link "competitive pricing"
text "Create a Cin7 Pay account and start processing payments today. For a full overview and instructions, see Cin7 Pay in the"
button "Create account"#StripeGetStarted primary
heading "How it works"
text "Click Create account, fill in your business details and accept the pricing agreement and Stripe's terms and conditions."
text "Choose your payment channels-whether you want to receive payments via invoices, the B2B portal, and/or directly from the"
text "Automatically receive online payments and payouts and monitor reports."
heading "About Cin7 Pay, powered by Stripe"
text "Cin7 Pay is a fully embedded payment processing solution. It allows your customers to checkout from your B2B online stor"
text "Cin7 Pay has no account or setup fees. Cin7 Pay charges competitive, per-transaction fees determined by the payment meth"
text "To create a Cin7 Pay account, click Create account above. You'll provide Cin7 and our partner Stripe with key informatio"
text "Find out more about Cin7 Pay in the Help Center."
text "By using Cin7 Pay, you agree to the Stripe terms and conditions and you acknowledge that Cin7 Pay is a Third-Party Appli"
tabs#overview-list: Account and setup #tab-cin7pay-myAccount | Payments, refunds, and disputes #tab-cin7pay-paymentsRefundsDisputes | Payouts #tab-cin7pay-payouts | Payment method settings #tab-cin7pay-paymentMethodSettings | Documents #tab-cin7pay-documents | Saved payment methods #tab-cin7pay-cardOnFile | Surcharges #tab-cin7pay-surcharges | Cin7 Capital application #tab-cin7pay-cin7paycapital-onboarding | Cin7 Capital financing #tab-cin7pay-cin7paycapital-financing
tab pane#overview-content-tab
  tab pane#tab-cin7pay-myAccount
    slot #notificationbannercontainer
    heading "Setup"
    button "Save"#accountSaveAction primary
    heading "Accounting"
    label "Clearing account*" for #Cin7Pay_Index_AccuralAccount
    slot #Cin7Pay_Index_AccuralAccount
    label "Bank account*" for #Cin7Pay_Index_BankAccount
    slot #Cin7Pay_Index_BankAccount
    label "Payment fee account*" for #Cin7Pay_Index_PaymentFeeAccount
    slot #Cin7Pay_Index_PaymentFeeAccount
    label "Surcharge account" for #Cin7Pay_Index_SurchargeAccount
    slot #Cin7Pay_Index_SurchargeAccount
    block #div_Cin7Pay_Loan_Liability_Account (hidden)
      label "Financing liability account" for #Cin7Pay_Index_LoanLiabilityAccount
      slot #Cin7Pay_Index_LoanLiabilityAccount
    block #div_Cin7Pay_Financing_Fee_Account (hidden)
      label "Financing fee account" for #Cin7Pay_Index_FinancingFeeAccount
      slot #Cin7Pay_Index_FinancingFeeAccount
    block #paymentChannelsSection (hidden)
      heading "Payment channels"
      slot #Cin7Pay_Index_B2BPay
      label "B2B Portal" for #chkB2BPay
      slot #Cin7Pay_Index_PayByInvoice
      label "Pay Online" for #chkPayByInvoice
      slot #Cin7Pay_Index_PayWithSales
      label "Merchant-initiated transactions" for #chkPayWithSales
    block #NotificationsSection (hidden)
      heading "Notifications"
      label "Default merchant (internal) email address" for #Cin7Pay_Index_MerchantNotificationEmail
      input text#Cin7Pay_Index_MerchantNotificationEmail placeholder "Merchant email address"
      label "Additional merchant email addresses" for #Cin7Pay_Index_AdditionalNotificationEmails
      textarea#Cin7Pay_Index_AdditionalNotificationEmails placeholder "Enter additional email addresses"
      slot #Cin7Pay_Index_ChkMerchantReceiptNotification
      label "Send receipt notification to merchant after payment" for #chkMerchantReceiptNotification
      slot #Cin7Pay_Index_ChkCustomerReceiptNotification
      label "Send receipt notification to customer after payment" for #chkCustomerReceiptNotification
      slot #Cin7Pay_Index_ChkMerchantRefundNotification
      label "Send refund notification to merchant" for #chkMerchantRefundNotification
    heading "Account details"
    slot #myaccountcontainer
    slot #myaccountmanagecontainer
  tab pane#tab-cin7pay-paymentMethodSettings
    heading "Payment method settings"
    slot #mypaymentmethodsettingscontainer
  tab pane#tab-cin7pay-paymentsRefundsDisputes
    heading "Payments, refunds, and disputes"
    slot #mypaymentrefundchannelcontainer
  tab pane#tab-cin7pay-payouts
    heading "Payouts"
    slot #mypayoutscontainer
  tab pane#tab-cin7pay-documents
    heading "Documents"
    slot #mydocumentscontainer
  tab pane#tab-cin7pay-cardOnFile
    heading "Setup"
    link "saving payment methods in the Help Center"
    label "Save payment methods"
    input checkbox#Cin7Pay_Index_CardOnFile
    block #cardonfile_customers (hidden)
      heading "Payment methods and customers"
      button "Customer"#btn_AddCardOnFileCustomer primary
      input text#divCustomerSearch placeholder "Search"
      button "Search"#Cin7PayCustomerSearchBtn primary
      button "Link customers"#btn_LinkCardOnFileCustomer primary
      button "Bulk customers"#btn_BulkAddCardOnFileCustomer primary
      block #cardonfilecustomersgrid
        slot #divGridCardOnFileCustomers
  tab pane#tab-cin7pay-surcharges
    heading "Setup"
    link "surcharges in the Help Center"
    label "Activate surcharges"
    input checkbox#Cin7Pay_Index_Surcharge
    block #div_surcharges (hidden)
      heading "Surcharges"
      button "Save"#btn_SaveSurchargeMapping primary
      block #surchargesgrid
        slot #divGridSurcharges
        button "Surcharge"#SurchargesLinesRecordLink primary (hidden)
  tab pane#tab-cin7pay-cin7paycapital-onboarding
    heading "Cin7 Capital application"
    block #div_Cin7PayCapital_Onboarding_Block
      slot #cin7paycapitalonboardingcontainer
    block #div_LoanLiabilityWarning (hidden)
    block #div_NoCin7CapitalOfferWarning (hidden)
    block #div_ActiveCin7CapitalOfferWarning (hidden)
    block #div_Cin7CapitalOfferSubmitted (hidden)
  tab pane#tab-cin7pay-cin7paycapital-financing
    heading "Cin7 Capital financing"
    slot #cin7paycapitalfinancingcontainer
slot #container
block #error
```

### `/Depreciation`: Depreciations

Frame: `task-upload-frame`.

```text
link "Home"
button "Tutorial"
block #divList
  heading "Depreciations"
  block #liLastDepreciation (hidden)
    slot #txtLastDepreciation
  button "Run depreciation"#divNew primary
  button "Rollback depreciation"#divRollback
  button #divRefresh
  button #Grid_gridName_Options
  slot #Depreciation_Index_Container
modal#divDepreciationEditForm large
  heading #FixedAssetEditFormTitle
  button "×"
  slot #tdStartDate
  label "Start date" for #txtStartDate
  slot #tdTotalAmount
  label "Total amount" for #txtTotalAmount
  slot #tdEndDate
  label "End date" for #txtEndDate
  slot #tdTotalItems
  label "Total items" for #txtTotalItems
  slot #tdCreatedDate
  label "Created date" for #txtCreatedDate
  slot #Depreciation_Index_DepreciationsList
  button "Save"#divSave primary
  button "Close"
```

### `/ExpenseClaim`: Expense claim

Frame: `task-upload-frame`.

```text
link "Home"
link "Expense claims"
button "Save"#saveAction primary
button "Back to list"
block #taskActions
  button "Undo"#undoAction
  button "Void"#voidAction
block #divMainContent
  block #formHeader
    slot #ExpenseClaim_Index_Status
    heading 
    button "Email" ▾
    slot #divEmailContainer
    button "Print" ▾
    slot #divPrintContainer
    block #divExpenseClaimTask (hidden)
      button 
      button  primary
      button "Workflow"
      button 
      button "Calendar"
    button #taskHeaderCollapse
  block #divTaskHeader
    slot #ExpenseClaim_Index_Employee
    label "Employee"
    slot #ExpenseClaim_Index_PaymentDueDate
    label "Payment due date*"
    slot #ExpenseClaim_Index_EffectiveDate
    label "Effective date*"
    slot #divStickyNote
    label "Note"
  button "Items"
  button "Financials"
  button "Activity logs"
  block #divOrder (hidden)
    button "Approve"#divApprove_Receipts primary
    button "Decline"#divDecline_Receipts
    button "Authorize"#divAuthorise primary
    slot #divOrderLines
    table: Total
    block #paymentContainer
      block #formHeader
        heading "Payments"
      button #divNewPayment primary
      slot #divPayments
      button "Add more items"#ExpenseClaim_AddPaymentLinesRecordLink primary
      table: Total
  block #divHistory (hidden)
    slot #divHistoryLines
  block #divFinancial (hidden)
    heading "Financials"
    tabs: Edit accounting dimensions #financials-default (hidden) | Transactions #financials-transactions | Final accounting dimensions values #financials-real (hidden)
    tab pane#financials-default
      heading "Edit accounting dimensions"
      text "Accounting dimension settings can overwrite reference data. All accounting dimensions can be edited. Accounting dimensio"
      table#tableDefaultDimensions: Event type
    tab pane#financials-transactions
      heading "Transactions"
      button "Refresh"#divRefreshTransactions
      slot #divTDetails
    tab pane#financials-real
      heading "Final accounting dimensions values"
      input text#txtRealDimensionsSearch placeholder "Type text to search"
      button "Search"#btnRealDimensionsSearch primary
      button "Refresh"#btnRealDimensionsRefresh
      slot #divRealDimensions
form#frmPrint
modal#secEmail medium
  heading #emailDialogCaption
  button "×"
  button "Send"#btnSendEmail2 primary
  button "Close"#emailBackAction2
  heading "Email subject"
  slot #EmailSendTemplate_AdditionalInfo (hidden)
  input text#DEAREmailTo
  label "To"
  button #DEAREmailTo_btn
  block #EmailSendTemplate_CC
    input text#DEAREmailCC
    label "CC"
    button #DEAREmailCC_btn
  input text#DEAREmailSubject placeholder "Type email subject..."
  label "Subject"
  block #EmailSendTemplate_NetworkingBlock (hidden)
    slot #EmailSendTemplate_NetworkingCheck
    label "Send via Cin7 Core network" for #chkEmail_sendViaNetwork
  heading "Select files to attach"
  block #EmailSendTemplate_AttachedFiles
    heading #headerForOrderAttachments
    slot #attachedFiles
  block #EmailSendTemplate_AttachedFiles_Product
    heading "Product"
    slot #attachedFiles_Product
  block #EmailSendTemplate_AttachedFiles_Supplier
    heading "Supplier"
    slot #attachedFiles_Supplier
  block #EmailSendTemplate_AttachedFiles_Customer
    heading "Customer"
    slot #attachedFiles_Customer
  heading "Email template"
  slot #tdEmail_Body
  block #emailReCaptcha (hidden)
  button "Send"#btnSendEmail primary
  button "Close"#emailBackAction
modal#secRecipients medium
  heading "Select a recipient"
  button "×"
  slot #gridRecipients
  button "OK" primary
  button "Close"
slot #btnSendEmail2
```

### `/ExpenseClaimList`: Expense claims

Frame: `task-upload-frame`.

```text
link "Home"
button "Tutorial"
block #divList
  heading "Expense claims"
  button "Print" ▾
  slot #printDropdownList
  button "Email" ▾
  slot #emailDropdownList
  block #export-form-control
    button "Export"#btnExport ▾
    link "CSV"
  block #bulkActionsNoteSuccess (hidden)
  block #bulkActionsNoteWarning (hidden)
  block #bulkActionsNoteError (hidden)
  input text#divSearch placeholder "Type text to search"
  button "Search" primary
  select#divFilter
  button #divRefresh
  button #Grid_gridName_Options
  slot #ExpenseClaimList_Index_Container
modal#dlgReCaptchaModal small
  heading "CAPTCHA verification"#dlgReCaptchaModalCaption
  button "×"
  block #emailReCaptcha
  button "Continue"#dlgReCaptchaModal_continue primary
  button "Close"
form#frmPrint
form#frmExport
```

### `/ExpenseClaimReceipt`: Expense claim receipt

Frame: `iUpload`.

```text
link "Home"
link "Expense claim receipts"
button "Save"#saveAction primary
button "Back to list"
button "Void"#voidAction
slot #taskActions
block #divMainContent
  block #formHeader
    slot #Receipt_Index_Status
    heading 
    button "Email" ▾
    slot #divEmailContainer
    button "Print" ▾
    slot #divPrintContainer
    block #divExpenseClaimReceiptTask (hidden)
      button 
      button  primary
      button "Workflow"
      button 
      button "Calendar"
    button #taskHeaderCollapse
  block #divTaskHeader
    slot #Receipt_Index_Supplier
    label "Supplier*"
    slot #Receipt_Index_Employee
    label "Employee*"
    slot #Receipt_Index_Reference
    label "Reference"
    slot #Receipt_Index_Date
    label "Date*"
    slot #tdReceipt_Index_Currency
    label "Currency*"
    block #ExpenseClaimReceipt_RateContainer
      slot #tdExpenseClaimReceipt_Index_CurrencyConversionRate
      label "Rate"
    slot #Receipt_Index_Tax
    label "Tax*"
    slot #tdExpenseClaimReceipt_Index_DefaultAccount
    label "Account"
  button "Items"
  button "Attachments"
  button "Activity logs"
  block #divOrder (hidden)
    button #divNewLines_Order primary
    slot #divOrderLines
    button "Add more items"#FinishedGoods_Index_AddOrderLineLink primary
    table: Total
  block #divAttachments (hidden)
    block #divAttachmentUpload
      block #divUploadContainer
        slot #iUpload (hidden)
        form#frmUploadReceipt
          heading "Drop files here or click to upload."
      block #divUploadImpossible
        text "Please save your expense claim receipt before attaching a file."
    slot #divAttachmentList
  block #divActivityLogs (hidden)
    slot #ActivityLogs_Container
modal#ExpenseClaimReceipt_NewSupplier_Content medium
  heading "Add a supplier"
  button "×"
  slot #tdExpenseClaimReceipt_NewSupplier_Name
  label "Name"
  slot #tdExpenseClaimReceipt_NewSupplier_PaymentTerm
  label "Payment term"
  slot #tdExpenseClaimReceipt_NewSupplier_TaxRule
  label "Tax rule"
  slot #tdExpenseClaimReceipt_NewSupplier_Discount
  label "Discount"
  slot #tdExpenseClaimReceipt_NewSupplier_Comments
  label "Comments"
  slot #tdExpenseClaimReceipt_NewSupplier_Currency
  label "Currency"
  slot #tdExpenseClaimReceipt_NewSupplier_AccountCode
  label "Account payable"
  slot #tdExpenseClaimReceipt_NewSupplier_DefaultCarrier
  label "Default carrier"
  slot #tdExpenseClaimReceipt_NewSupplier_TaxNumber
  label "Tax number"
  button "Save" primary
  button "Close"
modal#secEmail medium
  heading #emailDialogCaption
  button "×"
  button "Send"#btnSendEmail2 primary
  button "Close"#emailBackAction2
  heading "Email subject"
  slot #EmailSendTemplate_AdditionalInfo (hidden)
  input text#DEAREmailTo
  label "To"
  button #DEAREmailTo_btn
  block #EmailSendTemplate_CC
    input text#DEAREmailCC
    label "CC"
    button #DEAREmailCC_btn
  input text#DEAREmailSubject placeholder "Type email subject..."
  label "Subject"
  block #EmailSendTemplate_NetworkingBlock (hidden)
    slot #EmailSendTemplate_NetworkingCheck
    label "Send via Cin7 Core network" for #chkEmail_sendViaNetwork
  heading "Select files to attach"
  block #EmailSendTemplate_AttachedFiles
    heading #headerForOrderAttachments
    slot #attachedFiles
  block #EmailSendTemplate_AttachedFiles_Product
    heading "Product"
    slot #attachedFiles_Product
  block #EmailSendTemplate_AttachedFiles_Supplier
    heading "Supplier"
    slot #attachedFiles_Supplier
  block #EmailSendTemplate_AttachedFiles_Customer
    heading "Customer"
    slot #attachedFiles_Customer
  heading "Email template"
  slot #tdEmail_Body
  block #emailReCaptcha (hidden)
  button "Send"#btnSendEmail primary
  button "Close"#emailBackAction
modal#secRecipients medium
  heading "Select a recipient"
  button "×"
  slot #gridRecipients
  button "OK" primary
  button "Close"
slot #btnSendEmail2
slot #divPrint
```

### `/ExpenseClaimReceiptList`: Expense claims - Receipts

Frame: `task-upload-frame`.

```text
link "Home"
button "Tutorial"
block #divList
  heading "Expense claims - Receipts"
  button "Print" ▾
  slot #printDropdownList
  button "Email" ▾
  slot #emailDropdownList
  block #export-form-control
    button "Export"#btnExport ▾
    link "CSV"
  block #bulkActionsNoteSuccess (hidden)
  block #bulkActionsNoteWarning (hidden)
  block #bulkActionsNoteError (hidden)
  button #divNew primary
  button "Submit for approval"#divSubmitForApproval primary
  input text#divSearch placeholder "Type text to search"
  button "Search" primary
  select#divFilter
  button #divRefresh
  button #Grid_gridName_Options
  slot #ExpenseClaimReceiptList_Index_Container
modal#ExpenseClaimReceiptList_SubmitForApproval_Dialog large
  heading "Submit for approval"
  button "×"
  block #ExpenseClaimReceiptList_SubmitForApproval_ValidationContainerSuccess (hidden)
  block #ExpenseClaimReceiptList_SubmitForApproval_ValidationContainerWarning (hidden)
  block #ExpenseClaimReceiptList_SubmitForApproval_ValidationContainerError (hidden)
  slot #ExpenseClaimReceiptList_SubmitForApproval_GridContainer
  block #ExpenseClaimReceiptList_SubmitForApproval_Dialog_Actions
    button "Submit for approval"#ExpenseClaimReceiptList_SubmitForApproval_Dialog_Execute primary
    button "Close"
modal#dlgReCaptchaModal small
  heading "CAPTCHA verification"#dlgReCaptchaModalCaption
  button "×"
  block #emailReCaptcha
  button "Continue"#dlgReCaptchaModal_continue primary
  button "Close"
form#frmPrintList
form#frmExport
```

### `/FixedAsset`: Fixed assets

Frame: `iUpload`.

```text
link "Home"
button "Tutorial"
block #divList
  heading "Fixed assets"
  button "Register"#divRegister primary
  button "Unregister"#divUnregister
  input text#divSearch placeholder "Type text to search"
  button "Search" primary
  select#divFilter
  button #divRefresh
  button #Grid_gridName_Options
  slot #FixedAsset_Index_Container
modal#divFixedAssetEditForm large
  heading #FixedAssetEditFormTitle
  button "×"
  block #viewContainer
  block #fixed_asset_content
    slot #tdProductName
    label "Name" for #txtProductName
    slot #tdSerialNumber
    label "Serial number" for #txtSerialNumber
    slot #tdDepreciationStartDate
    label "Depreciation start date" for #txtDepreciationStartDate
    slot #tdDepreciationMethod
    label "Depreciation method" for #cmbDepreciationMethod
    slot #tdAveragingMethod
    label "Averaging method" for #cmbAveragingMethod
    slot #rbRate
    slot #tdRate
    slot #rbEffectiveLife
    slot #tdEffectiveLife
    slot #tdSalvageValue
    label "Salvage value" for #txtSalvageValue
    slot #tdBusinessUse
    label "Business use %" for #txtBusinessUse
    slot #tdAssetAccountCode
    label "Asset account" for #cmbAssetAccountCode
    slot #tdAccumulatedDepreciationAccountCode
    label "Accumulated depreciation account" for #cmbAccumulatedDepreciationAccountCode
    slot #tdDepreciationExpenseAccountCode
    label "Depreciation expense account" for #cmbDepreciationExpenseAccountCode
    slot #tdPurchaseDate
    label "Purchase date" for #txtPurchaseDate
    slot #tdPurchaseCost
    label "Purchase cost" for #txtPurchaseCost
    slot #tdOnHand
    label "On hand" for #txtOnHand
    slot #tdLocationName
    label "Location" for #txtLocationName
    slot #tdAccumulatedDepreciation
    label "Accumulated depreciation" for #txtAccumulatedDepreciation
    slot #tdRegistrationDate
    label "Registration date" for #txtRegistrationDate
    slot #tdDisposalDate
    label "Disposal date" for #txtDisposalDate
    block #divStartAccumulation
      heading "The depreciation start date for this asset is before the opening start date:"
      slot #tdStartAccumulatedDepreciationAmount
      label "Accumulated depreciation as of*" for #txtStartAccumulatedDepreciationAmount
      slot #txtStartAccumulatedDepreciationAmountComment
      slot #tdStartAccumulatedBookValue
      label "Book value as of" for #txtStartAccumulatedBookValue
    slot #Depreciation_Index_DepreciationsList
  block #depreciations_content (hidden)
    slot #FixedAsset_Index_DepreciationsContainer
  block #attachments_content (hidden)
    block #divAttachmentUpload
      block #divUploadContainer
        block #preview-template (hidden)
        slot #iUpload (hidden)
        form#frmUpload
          heading "Drop files here or click to upload."
    slot #divAttachmentList
    button "Attach from Google Drive" primary
  button "Save"#FixedAssetEditFormSaveButton primary
  button "Close"
```

### `/Journal`: Journal

Frame: `task-upload-frame`.

```text
link "Home"
link "Journals"
button "Save"#saveAction primary
button "Undo"#undoAction
button "Back to list"#backAction
button "Void"#voidAction
button "Clone"#cloneAction
block #divMainContent
  slot #tdStatus
  heading "New journal"
  block #divJournalTask (hidden)
    button 
    button  primary
    button "Workflow"
    button 
    button "Calendar"
  block #divTaskHeader
    slot #Journal_Index_Currency
    label "Currency" for #cmbCurrency
    slot #Journal_Index_EffectiveDate
    label "Effective date" for #dtEffectiveDate
    block #divRate
      input text#Journal_Index_CurrencyConversionRate name=txtCurrencyConversionRate
      button #Journal_Index_CurrencyConversionRate_GetRate
      label "" for #txtCurrencyConversionRate
    textarea#Journal_Index_Narration placeholder "Write your narration here..."
    label "Narration"
    textarea#divStickyNote placeholder "Write your note here..."
    label "Note"
  button "Lines"
  button "Final accounting dimensions"
  button "Attachments"
  button "Activity logs"
  block #divLines (hidden)
    button #divNewLines primary
    button "Authorize"#authoriseAction primary
    slot #divLinesContainer
    button "Add a line"#Journal_Index_AddLink primary (hidden)
  block #divDimensions (hidden)
    input text#txtRealDimensionsSearch placeholder "Type text to search"
    button "Search"#btnRealDimensionsSearch primary
    button "Refresh"#btnRealDimensionsRefresh
    slot #divRealDimensions
  block #divAttachments (hidden)
    block #divUploadContainer
      block #preview-template (hidden)
      form#frmUpload
        heading "Drop files here or click to upload."
    button "Attach from Google Drive" primary
    slot #divAttachmentList
  block #divActivityLogs (hidden)
    slot #ActivityLogs_Container
modal#divCOGSAccDims small
  heading "Accounting dimensions"
  button "×"
  button "Save"#btnSaveCOGSAccDims primary
  button "Close"
```

### `/JournalList`: Journals

Frame: `task-upload-frame`.

```text
link "Home"
button "Tutorial"
block #divList
  heading "Journals"
  button #divNew primary
  input text#divSearch placeholder "Type text to search"
  button "Search" primary
  button #divRefresh
  button #Grid_gridName_Options
  slot #Journal_Index_Container
```

### `/MoneyTask/Receive`: Receive money

Frame: `task-upload-frame`.

```text
link "Home"
link "Money tasks"
button "Save"#saveAction primary
button "Back to list"#backAction
button "Tutorial"
block #divMainContent
  slot #MoneyTask_Status
  heading "Receive Money"
  button "Void"#voidAction
  button "Complete"#completeAction primary
  button "Clone"#cloneAction
  button "View in Xero"#divXeroBtn (hidden)
  button "Undo"#undoAction
  block #divMoneyReceiveTask (hidden)
    button 
    button  primary
    button "Workflow"
    button 
    button "Calendar"
  slot #divBankAccount
  label "Bank account" for #cmbBankAccount
  slot #divSupplierCustomer
  label "From" for #cmbSupplierCustomer
  slot #divReference
  label "Reference" for #txtReference
  block #divRate
    slot #divCurrencyConversionRate
    label "Rate" for #txtCurrencyConversionRate
  slot #divMoneyTaskDate
  label "Date" for #dtMoneyTaskDate
  slot #divTaxInclusive
  label "Tax inclusive" for #chkTaxInclusive
  textarea#divMoneyTaskMemo placeholder "Write your note here..."
  label "Note" for #txtNote
  button "Lines"
  button "Attachments"
  button "Financials"
  button "Logs and attributes"
  block #divLines
    button #divNewMoneyTaskLine primary
    slot #divMoneyTaskLines
    button "Add more items"#MoneyTask_AddMoneyTaskLinesRecordLink primary (hidden)
    table: Total
  block #divAttachments
    block #divUploadContainer
      block #preview-template (hidden)
      form#frmUpload
        heading "Drop files here or click to upload."
    button "Attach from Google Drive" primary
    slot #divAttachmentList
  block #divFinancial (hidden)
    heading "Financials"
    tabs: Edit accounting dimensions #financials-default (hidden) | Transactions #financials-transactions | Final accounting dimensions values #financials-real (hidden)
    tab pane#financials-default
      heading "Edit accounting dimensions"
      text "Accounting dimension settings can overwrite reference data. All accounting dimensions can be edited. Accounting dimensio"
      table#tableDefaultDimensions
    tab pane#financials-transactions
      heading "Transactions"
      button "Refresh"#divRefreshTransactions
      slot #divTDetails
    tab pane#financials-real
      heading "Final accounting dimensions values"
      input text#txtRealDimensionsSearch placeholder "Type text to search"
      button "Search"#btnRealDimensionsSearch primary
      button "Refresh"#btnRealDimensionsRefresh
      slot #divRealDimensions
  block #divHistory
    block #MoneyTask_divAttributeSet (hidden)
      heading "Additional attributes"
      block #MoneyTask_liCustomField1
        slot #MoneyTask_CustomField1
        label "Attribute 1"
      block #MoneyTask_liCustomField2
        slot #MoneyTask_CustomField2
        label "Attribute 2"
      block #MoneyTask_liCustomField3
        slot #MoneyTask_CustomField3
        label "Attribute 3"
      block #MoneyTask_liCustomField4
        slot #MoneyTask_CustomField4
        label "Attribute 4"
      block #MoneyTask_liCustomField5
        slot #MoneyTask_CustomField5
        label "Attribute 5"
      block #MoneyTask_liCustomField6
        slot #MoneyTask_CustomField6
        label "Attribute 6"
      block #MoneyTask_liCustomField7
        slot #MoneyTask_CustomField7
        label "Attribute 7"
      block #MoneyTask_liCustomField8
        slot #MoneyTask_CustomField8
        label "Attribute 8"
      block #MoneyTask_liCustomField9
        slot #MoneyTask_CustomField9
        label "Attribute 9"
      block #MoneyTask_liCustomField10
        slot #MoneyTask_CustomField10
        label "Attribute 10"
    block #divActivityLogs
      heading "Activity log"
      slot #ActivityLogs_Container
modal#MoneyTask_NewCustomer_Content medium
  heading "Add a customer"
  button "×"
  slot #divNewCustomerName
  label "Name" for #txtNewCustomerName
  slot #divNewCustomerPaymentTerm
  label "Payment term" for #cmbNewCustomerPaymentTerm
  slot #divNewCustomerSaleAccount
  label "Sale account" for #cmbNewCustomerSaleAccount
  slot #divNewCustomerSalesRep
  label "Sales rep" for #cmbNewCustomerSalesRep
  slot #divNewCustomerDefaultLocation
  label "Default location" for #cmbNewCustomerDefaultLocation
  slot #divNewCustomerDiscount
  label "Discount" for #txtNewCustomerDiscount
  slot #divNewCustomerCurreny
  label "Currency" for #cmbNewCustomerCurreny
  slot #divNewCustomerAccountReceivable
  label "Account receivable" for #cmbNewCustomerAccountReceivable
  slot #divNewCustomerTaxRule
  label "Tax rule" for #cmbNewCustomerTaxRule
  slot #divNewCustomerDefaultCarrier
  label "Default carrier" for #cmbNewCustomerDefaultCarrier
  slot #divNewCustomerTaxNumber
  label "Tax number" for #txtNewCustomerTaxNumber
  slot #divNewCustomerSalePriceTier
  label "Sale price tier" for #cmbNewCustomerSalePriceTier
  textarea#divNewCustomerComments placeholder "Write your comments here..."
  label "Comments"
  button "Save" primary
  button "Close"
form#frmClone
```

### `/MoneyTask/Spend`: Spend money

Frame: `task-upload-frame`.

```text
link "Home"
link "Money tasks"
button "Save"#saveAction primary
button "Back to list"#backAction
button "Tutorial"
block #divMainContent
  slot #MoneyTask_Status
  heading "Spend Money"
  button "Void"#voidAction
  button "Complete"#completeAction primary
  button "Clone"#cloneAction
  button "View in Xero"#divXeroBtn (hidden)
  button "Undo"#undoAction
  block #divMoneySpendTask (hidden)
    button 
    button  primary
    button "Workflow"
    button 
    button "Calendar"
  slot #divBankAccount
  label "Bank account" for #cmbBankAccount
  slot #divSupplierCustomer
  label "To" for #cmbSupplierCustomer
  slot #divReference
  label "Reference" for #txtReference
  block #divRate
    slot #divCurrencyConversionRate
    label "Rate" for #txtCurrencyConversionRate
  slot #divMoneyTaskDate
  label "Date" for #dtMoneyTaskDate
  slot #divTaxInclusive
  label "Tax inclusive" for #chkTaxInclusive
  textarea#divMoneyTaskMemo placeholder "Write your note here..."
  label "Note" for #txtNote
  button "Lines"
  button "Attachments"
  button "Financials"
  button "Logs and attributes"
  block #divLines
    button #divNewMoneyTaskLine primary
    slot #divMoneyTaskLines
    button "Add more items"#MoneyTask_AddMoneyTaskLinesRecordLink primary (hidden)
    table: Total
  block #divAttachments
    block #divUploadContainer
      block #preview-template (hidden)
      form#frmUpload
        heading "Drop files here or click to upload."
    button "Attach from Google Drive" primary
    slot #divAttachmentList
  block #divFinancial (hidden)
    heading "Financials"
    tabs: Edit accounting dimensions #financials-default (hidden) | Transactions #financials-transactions | Final accounting dimensions values #financials-real (hidden)
    tab pane#financials-default
      heading "Edit accounting dimensions"
      text "Accounting dimension settings can overwrite reference data. All accounting dimensions can be edited. Accounting dimensio"
      table#tableDefaultDimensions
    tab pane#financials-transactions
      heading "Transactions"
      button "Refresh"#divRefreshTransactions
      slot #divTDetails
    tab pane#financials-real
      heading "Final accounting dimensions values"
      input text#txtRealDimensionsSearch placeholder "Type text to search"
      button "Search"#btnRealDimensionsSearch primary
      button "Refresh"#btnRealDimensionsRefresh
      slot #divRealDimensions
  block #divHistory (hidden)
    block #MoneyTask_divAttributeSet (hidden)
      heading "Additional attributes"
      block #MoneyTask_liCustomField1
        slot #MoneyTask_CustomField1
        label "Attribute 1"
      block #MoneyTask_liCustomField2
        slot #MoneyTask_CustomField2
        label "Attribute 2"
      block #MoneyTask_liCustomField3
        slot #MoneyTask_CustomField3
        label "Attribute 3"
      block #MoneyTask_liCustomField4
        slot #MoneyTask_CustomField4
        label "Attribute 4"
      block #MoneyTask_liCustomField5
        slot #MoneyTask_CustomField5
        label "Attribute 5"
      block #MoneyTask_liCustomField6
        slot #MoneyTask_CustomField6
        label "Attribute 6"
      block #MoneyTask_liCustomField7
        slot #MoneyTask_CustomField7
        label "Attribute 7"
      block #MoneyTask_liCustomField8
        slot #MoneyTask_CustomField8
        label "Attribute 8"
      block #MoneyTask_liCustomField9
        slot #MoneyTask_CustomField9
        label "Attribute 9"
      block #MoneyTask_liCustomField10
        slot #MoneyTask_CustomField10
        label "Attribute 10"
    block #divActivityLogs
      heading "Activity log"
      slot #ActivityLogs_Container
modal#MoneyTask_NewSupplier_Content medium
  heading "Add a supplier"
  button "×"
  slot #divNewSupplierName
  label "Name" for #txtNewSupplierName
  slot #divNewSupplierPaymentTerm
  label "Payment term" for #cmbNewSupplierPaymentTerm
  slot #divNewSupplierTaxRule
  label "Tax rule" for #cmbNewSupplierTaxRule
  slot #divNewSupplierDiscount
  label "Discount" for #txtNewSupplierDiscount
  slot #divNewSupplierCurreny
  label "Currency" for #cmbNewSupplierCurreny
  slot #divNewSupplierAccountPayable
  label "Account payable" for #cmbNewSupplierAccountPayable
  slot #divNewSupplierDefaultCarrier
  label "Default carrier" for #cmbNewSupplierDefaultCarrier
  slot #divNewSupplierTaxNumber
  label "Tax number" for #txtNewSupplierTaxNumber
  textarea#divNewSupplierComments placeholder "Write your comments here..."
  label "Comments"
  button "Save" primary
  button "Close"
form#frmClone
```

### `/MoneyTask/Transfer`: Transfer money

Frame: `task-upload-frame`.

```text
link "Home"
link "Money tasks"
block #saveAction
  button "Save" primary
block #undoAction
  button "Undo"
block #backAction
  button "Back to list"
button "Tutorial"
block #voidAction
  button "Void"
block #cloneAction
  button "Clone"
block #divMainContent
  slot #tdStatus
  heading "Transfer money"
  button "Complete"#completeAction primary
  block #divTaskHeader
    slot #divBankAccount
    label "From" for #cmbBankAccount
    slot #divAmount
    label "Amount" for #txtAmount
    slot #divBankAccountTo
    label "To" for #cmbBankAccountTo
    block #divAmountToContainer
      slot #divAmountTo
      label "Amount" for #txtAmountTo
    slot #divMoneyTaskDate
    label "Date" for #dtMoneyTaskDate
    slot #divReference
    label "Reference" for #txtReference
    block #divDateRatesContainer (hidden)
      slot #divCurrencyConversionRate
      slot #lblCurrencyConversionRate
      slot #divCurrencyConversionRateTo
      slot #lblCurrencyConversionRateTo
    block #divRatesForDataLabelContainer (hidden)
      slot #lblDateRates
      slot #divDateRates
      slot #divDateRatesTo
    textarea#divMoneyTaskMemo placeholder "Write your note here..."
    label "Note" for #txtMoneyTaskMemo
  block #tabs-bar
    button "Attachments"
    button "Financials"
    button "Activity logs"
  block #divEmptyPage
    heading "No additional information available yet."
  block #divAttachments (hidden)
    block #divUploadContainer
      block #preview-template (hidden)
      form#frmUpload
        heading "Drop files here or click to upload."
    button "Attach from Google Drive" primary
    slot #divAttachmentList
  block #divFinancial (hidden)
    heading "Financials"
    tabs: Edit accounting dimensions #financials-default (hidden) | Transactions #financials-transactions | Final accounting dimensions values #financials-real (hidden)
    tab pane#financials-default
      heading "Edit accounting dimensions"
      text "Accounting dimension settings can overwrite reference data. All accounting dimensions can be edited. Accounting dimensio"
      table#tableDefaultDimensions: Account
    tab pane#financials-transactions
      heading "Transactions"
      button "Refresh"#divRefreshTransactions
      slot #divTDetails
    tab pane#financials-real
      heading "Final accounting dimensions values"
      input text#txtRealDimensionsSearch placeholder "Type text to search"
      button "Search"#btnRealDimensionsSearch primary
      button "Refresh"#btnRealDimensionsRefresh
      slot #divRealDimensions
  block #divActivityLogs (hidden)
    slot #ActivityLogs_Container
form#frmClone
```

### `/MoneyTaskList`: Money operations

Frame: `task-upload-frame`.

```text
link "Home"
button "Tutorial"
block #divList
  heading "Money operations"
  button #divNew primary
  slot #newDropdownList
  input text#divSearch placeholder "Type text to search"
  button "Search" primary
  select#divFilter
  button #divRefresh
  button #Grid_gridName_Options
  slot #MoneyTaskList_Container
```

## Components by bundle

What the page code builds and mounts into the layout's slots.

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


