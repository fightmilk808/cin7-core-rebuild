# Sale: UI

Every component the page code builds, read from the shipped ExtJS bundles: grids with their columns, fields, buttons, menus, windows and custom components. Labels are the English UI text. `renders into` is the id of the `<div>` in the page's server-rendered HTML that the component mounts in; `store` names the data store (see the endpoints in [README.md](README.md)); `on click` is the handler. Visual system and shell layout: [docs/UI.md](../../docs/UI.md).

## Screens

| Route | Title | Bundles |
|---|---|---|
| `/AwaitingSale` | Awaiting approval sale | [`AwaitingSale2019`](#awaitingsale2019) |
| `/CreditNote` | Credit note | [`CreditNote2019`](#creditnote2019) |
| `/Customer` | Customer | [`MultilingualSupport2019`](#multilingualsupport2019), [`CustomerEdit2019`](#customeredit2019) |
| `/CustomerList` | Customers | [`CustomerList2019`](#customerlist2019) |
| `/CustomerPayment` | Customer bulk payment | [`CustomerPayment2019`](#customerpayment2019) |
| `/DiscountNew` | Discount | [`DiscountNew2019`](#discountnew2019) |
| `/FulfillmentOrder` | Fulfillment order | [`FulfilmentOrder2019`](#fulfilmentorder2019) |
| `/FulfillmentOrderList` | Fulfillment orders | [`FulfilmentOrderList2019`](#fulfilmentorderlist2019) |
| `/RMA` | RMA | [`RMA2019`](#rma2019) |
| `/RMAReturnOrder` | Return order | [`RMAReturnOrder2019`](#rmareturnorder2019) |
| `/RecurringInvoices` | Recurring invoices | [`RecurringInvoices2019`](#recurringinvoices2019) |
| `/Sale` | Simple sale | [`Customization2019`](#customization2019), [`SimpleSale2019`](#simplesale2019) |
| `/SaleList` | Sales | [`SalesList2019`](#saleslist2019) |
| `/SaleMultiple` | Advanced sale | [`Customization2019`](#customization2019), [`SaleMultiple2019`](#salemultiple2019) |
| `/SaleService` | Service sale | [`ServiceSale2019`](#servicesale2019) |
| `/Warranties` | Warranties | [`Warranties2019`](#warranties2019) |

## Layout

Each screen's server-rendered HTML inside the shell, as an outline: headings, tabs, sections, labels, inputs (`#id`), buttons (`▾` = dropdown), menus, tables and `slot`s (empty `<div>`s the components below mount into). `(hidden)` parts are shown by the page code when needed. Read with GET from a signed-in session; no values are kept.

### `/AwaitingSale`: Awaiting approval sale

Frame: `task-upload-frame`.

```text
link "Home"
link "Sales"
button "Back to list"#backAction
block #divMainContent
  block #Sale_Index_Status
  heading 
  button "Approve"#approvaAction primary
  button "Save as draft"#saveAsDraftAction primary
  button "Decline"#declineAction
  block #divTaskHeader
    heading "Customer details"
    label "Customer" for #cmbCustomer
    slot #Sale_Index_Customer
    label "Contact" for #cmbContact
    slot #Sale_Index_Contact
    label "Phone" for #txtPhone
    slot #Sale_Index_Phone
    label "Email" for #txtEmail
    slot #Sale_Index_Email
    label "Reference" for #cmbCustomerReference
    slot #Sale_Index_CustomerReference
    label "Billing address line 1" for #cmbBillingAddressLine1
    slot #Sale_Index_BillingAddressLine1
    label "Billing address line 2" for #txtBillingAddressLine2
    slot #Sale_Index_BillingAddressLine2
    label "Price tier" for #cmbPriceTier
    slot #Sale_Index_PriceTier
    heading "Accounting details"
    label "Terms" for #cmbTerms
    slot #Sale_Index_Terms
    label "Sales rep" for #cmbSalesRepresentative
    slot #Sale_Index_SalesRepresentative
    label "Account" for #cmbDefaultAccount
    slot #tdSale_Index_DefaultAccount
    block #divRate
      label "" for #Sale_Index_CurrencyConversionRate
      slot #tdSale_Index_CurrencyConversionRate
    label "Tax rule *" for #cmbTax
    slot #Sale_Index_Tax
    slot #Sale_Index_Tax_Inclusive
    label "Tax inclusive" for #cmbTax
    slot #Sale_Index_IsRecursive
    label "Recurring task"
    block #Sale_Index_lblFrequency
      label "Recurring frequency" for #cmbFrequency
      slot #Sale_Index_Frequency
    heading "Shipping details"
    label "Location" for #cmbLocation
    slot #Sale_Index_Location
    label "Date" for #dtDate
    slot #Sale_Index_Date
    label "Ship to company" for #cmbShipToCompany
    slot #Sale_Index_ShipToCompany
    label "Ship to contact" for #cmbShipToContact
    slot #Sale_Index_ShipToContact
    slot #Sale_Index_ShipToOther
    label "Ship to different company" for #chkHeaderShipToOther
    block #Sale_Index_RecepientAddress_Button
      button #Sale_Index_EditOtherAddress primary
    block #Sale_Index_CustomerAddress
      label "Shipping address line 1" for #cmbShippingAddressLine1
      slot #Sale_Index_SippingAddressLine1
      label "Shipping address line 2" for #txtShippingAddressLine2
      slot #Sale_Index_SippingAddressLine2
    block #Sale_Index_RecepientAddress (hidden)
      textarea#tdSale_Index_ShipToAddress placeholder "Please enter the address..."
    label "Shipping notes" for #cmbShippingNotes
    textarea#Sale_Index_ShippingNotes placeholder "Shipping notes..."
    label "Required by" for #dtShipmentRequiredByDate
    slot #Sale_Index_ShipmentRequiredByDate
    block #Sale_Index_ShipServiceGroup
      label "Carrier / service" for #Sale_Index_ShippingCarrierService
      input text#Sale_Index_ShippingCarrierService
      button #Sale_Index_ShippingCarrierServiceLookup
    heading "Comments"
    block #divNote
      textarea#divStickyNote placeholder "Write your note here..."
    block #invoiceheaderblock
      heading "Invoice details"
      block #blockSale_Invoice_Date
        label "Invoice date" for #tdSale_Invoice_Date
        slot #tdSale_Invoice_Date
      label "Due date" for #tdSale_Invoice_DueDate
      slot #tdSale_Invoice_DueDate
  block #divOrder
    slot #vSaleOrderLinesDiscountDescription (hidden)
    heading "Order"
    slot #divOrderLines
    heading "Additional charges"
    slot #divOrderAdditionalChargesLines
    textarea#tdSale_Index_OrderMemo placeholder "Write your note here..."
    label "Order memo" for #Sale_Index_OrderMemo
    table: Order lines | Additional charges | Total
  block #divInvoice (hidden)
    heading "Invoice"
    slot #divInvoiceLines
    heading "Additional charges"
    slot #divInvoiceAdditionalChargesLines
    textarea#tdSale_Index_InvoiceMemo placeholder "Write your note here..."
    label "Invoice memo" for #Sale_Index_InvoiceMemo
    table: Invoice lines | Additional costs | Total
modal#Sale_NewTenantContact_Content small
  heading "Add a sales representative"
  button "x"
  label "Name" for #tdSale_NewTenantContact_Name
  input text#tdSale_NewTenantContact_Name
  label "Phone" for #tdSale_NewTenantContact_Phone
  input text#tdSale_NewTenantContact_Phone
  label "Fax" for #tdSale_NewTenantContact_Fax
  input text#tdSale_NewTenantContact_Fax
  label "Email" for #tdSale_NewTenantContact_Email
  input text#tdSale_NewTenantContact_Email
  label "Website" for #tdSale_NewTenantContact_Website
  input text#tdSale_NewTenantContact_Website
  label "Comments" for #tdSale_NewTenantContact_Comment
  textarea#tdSale_NewTenantContact_Comment
  button "Save" primary
  button "Close"
modal#Sale_NewContact_Content small
  heading "Add a customer contact"
  button "x"
  label "Name" for #tdSale_NewContact_Name
  input text#tdSale_NewContact_Name
  label "Job title" for #tdSale_NewContact_JobTitle
  input text#tdSale_NewContact_JobTitle
  label "Phone" for #tdSale_NewContact_Phone
  input text#tdSale_NewContact_Phone
  label "Mobile phone" for #tdSale_NewContact_MobilePhone
  input text#tdSale_NewContact_MobilePhone
  label "Fax" for #tdSale_NewContact_Fax
  input text#tdSale_NewContact_Fax
  label "Email" for #tdSale_NewContact_Email
  input text#tdSale_NewContact_Email
  label "Website" for #tdSale_NewContact_Website
  input text#tdSale_NewContact_Website
  label "Default contact" for #tdSale_NewContact_IsDefault
  input checkbox#tdSale_NewContact_IsDefault
  label "Comments" for #tdSale_NewContact_Comment
  textarea#tdSale_NewContact_Comment
  button "Save" primary
  button "Close"
modal#TenantPaymentTerm_NewTerm_Content small
  heading "Add a payment term"
  button "×"
  input text#tdTenantPaymentTerm_NewTerm_Name
  label "Name" for #tdTenantPaymentTerm_NewTerm_Name
  select#tdTenantPaymentTerm_NewTerm_Method: Number of days | Day of next month | Last day of next month | Days since the end of the month
  label "Method" for #tdTenantPaymentTerm_NewTerm_Method
  input text#tdTenantPaymentTerm_NewTerm_Days
  label "Days" for #tdTenantPaymentTerm_NewTerm_Days
  button "Save" primary
  button "Close"
modal#Sale_NewAddress_Content small
  heading "Add customer address"
  button "x"
  slot #cmbVendorAddress
  button 
  label "Line 1" for #tdSale_NewAddress_Line1
  input text#tdSale_NewAddress_Line1
  label "Line 2" for #tdSale_NewAddress_Line2
  input text#tdSale_NewAddress_Line2
  label "City / suburb" for #tdSale_NewAddress_CitySuburb
  input text#tdSale_NewAddress_CitySuburb
  label "State / province" for #tdSale_NewAddress_StateProvince
  input text#tdSale_NewAddress_StateProvince
  label "ZIP / postcode" for #tdSale_NewAddress_ZipPostCode
  input text#tdSale_NewAddress_ZipPostCode
  label "Country" for #tdSale_NewAddress_Country
  select#tdSale_NewAddress_Country
  label "Type" for #tdSale_NewAddress_Type
  select#tdSale_NewAddress_Type: Billing | Business | Shipping
  label "Default for type" for #tdSale_NewAddress_DefaultForType
  input checkbox#tdSale_NewAddress_DefaultForType
  button "Save" primary
  button "Close"
modal#Sale_EditAddress_Content small
  heading "Edit shipping address"
  button "x"
  button "Search customer address"#divShowAddressSearch
  button "Hide customer search"#divHideAddressSearch (hidden)
  block #divSale_Index_Ship_Another_Customer (hidden)
    label "Customer" for #Sale_Index_Ship_Another_Customer
    slot #Sale_Index_Ship_Another_Customer
    label "Address" for #cmbShippingAnotherAddressLine1
    slot #Sale_Index_SippingAnotherAddressLine1
  label "Line 1" for #tdSale_EditAddress_Line1
  input text#tdSale_EditAddress_Line1
  label "Line 2" for #tdSale_EditAddress_Line2
  input text#tdSale_EditAddress_Line2
  label "City / suburb" for #tdSale_EditAddress_CitySuburb
  input text#tdSale_EditAddress_CitySuburb
  label "State / province" for #tdSale_EditAddress_StateProvince
  input text#tdSale_EditAddress_StateProvince
  label "ZIP / postcode" for #tdSale_EditAddress_ZipPostCode
  input text#tdSale_EditAddress_ZipPostCode
  select#tdSale_EditAddress_Country
  label "Country" for #tdSale_EditAddress_Country
  button "OK" primary
  button "Close"
modal#Sale_NewCarrier_Content small
  heading "Add carrier"
  button "x"
  label "Carrier" for #tdSale_NewCarrier_Description
  input text#tdSale_NewCarrier_Description
  button "Save" primary
  button "Close"
modal#Sale_LookupCourierDialog_Content small
  heading "Carrier / service lookup"
  button "×"
  slot #divLookupCourierDialogGrid
  button "OK" primary
  button "Close"
modal#Sale_NewProduct_Content medium
  heading "Add a new product"
  button "x"
  label "SKU"
  input text#Sale_NewProduct_ProductCode placeholder "Enter a product SKU"
  label "Name"
  input text#Sale_NewProduct_Name placeholder "Enter a product name"
  label "Category"
  select#Sale_NewProduct_Category
  label "Purchase tax rule"
  select#Sale_NewProduct_PurchaseTaxRule
  label "Sale tax rule"
  select#Sale_NewProduct_SaleTaxRule
  block #trSupplier
    label "Supplier"
    slot #tdSale_NewProduct_Supplier
  block #trPurchasePrice
    label "Purchase price"
    input text#Sale_NewProduct_PurchasePrice
  label "Unit of measure"
  select#Sale_NewProduct_UnitOfMeasure
  block #trCostingMethod
    label "Costing method"
    select#Sale_NewProduct_CostingMethod
  block #trMinimumBeforeReorder
    label "Minimum before reorder"
    input text#Sale_NewProduct_MinimumBeforeReorder placeholder "Enter a minimum before reorder."
  block #trReorderQuantity
    label "Reorder quantity"
    input text#Sale_NewProduct_ReorderQuantity placeholder "Enter reorder quantity"
  label "Barcode"
  input text#Sale_NewProduct_Barcode placeholder "Enter barcode"
  block #trStockLocator
    label "Stock locator"
    input text#Sale_NewProduct_StockLocator placeholder "Enter a stock locator"
  block #trDropShipMode
    label "Drop ship"
    select#Sale_NewProduct_DropShipMode
  label "Attribute set"
  select#Sale_NewProduct_ProductAttributeSet
  block #Sale_NewProduct_trCustomField1
    label "Attribute 1"
    input text#Sale_NewProduct_CustomField1 placeholder "Enter an attribute 1"
  block #Sale_NewProduct_trCustomField2
    label "Attribute 2"
    input text#Sale_NewProduct_CustomField2 placeholder "Enter an attribute 2"
  block #Sale_NewProduct_trCustomField3
    label "Attribute 3"
    input text#Sale_NewProduct_CustomField3 placeholder "Enter an attribute 3"
  block #Sale_NewProduct_trCustomField4
    label "Attribute 4"
    input text#Sale_NewProduct_CustomField4 placeholder "Enter an attribute 4"
  block #Sale_NewProduct_trCustomField5
    label "Attribute 5"
    input text#Sale_NewProduct_CustomField5 placeholder "Enter an attribute 5"
  block #Sale_NewProduct_trCustomField6
    label "Attribute 6"
    input text#Sale_NewProduct_CustomField6 placeholder "Enter an attribute 6"
  block #Sale_NewProduct_trCustomField7
    label "Attribute 7"
    input text#Sale_NewProduct_CustomField7 placeholder "Enter an attribute 7"
  block #Sale_NewProduct_trCustomField8
    label "Attribute 8"
    input text#Sale_NewProduct_CustomField8 placeholder "Enter an attribute 8"
  block #Sale_NewProduct_trCustomField9
    label "Attribute 9"
    input text#Sale_NewProduct_CustomField9 placeholder "Enter an attribute 9"
  block #Sale_NewProduct_trCustomField10
    label "Attribute 10"
    input text#Sale_NewProduct_CustomField10 placeholder "Enter an attribute 10"
  button "Save" primary
  button "Close"
modal#Sale_NewExtShippingLine_Content small
  heading "Choose a box for external fulfillment"
  button "x"
  label "Box" for #Sale_NewTerm_Name
  select#tdSale_NewExtShippingLine_Box
  button "Add" primary
  button "Close"
```

### `/CreditNote`: Credit note

Frame: `iUpload`.

```text
link "Home"
link "Sales"
button "Save"#saveAction primary
button "Undo"#undoAction
button "Back to list"
button "Void"#voidAction
block #moreActionsBlock (hidden)
  button "More actions"#moreActions
  link "Undo"#undoAction_more (hidden)
  link "Void"#voidAction_more (hidden)
block #divMainContent
  slot #CreditNote_Index_Status
  heading 
  block #divCustomerTask (hidden)
    button 
    button  primary
    button "Workflow"
    button 
    button "Calendar"
  button 
  block #divTaskHeader
    heading "Customer details"
    slot #CreditNote_Index_Customer
    label "Customer"
    slot #CreditNote_Index_Contact
    label "Contact"
    slot #CreditNote_Index_Phone
    label "Phone"
    slot #CreditNote_Index_Email
    label "Email"
    slot #CreditNote_Index_CustomerReference
    label "Customer reference"
    heading 
    slot #CreditNote_Index_BillingAddressLine1
    label "Billing address line 1"
    block #Sale_Index_RecepientAddress
      slot #CreditNote_Index_BillingAddressLine2
      label "Billing address line 2"
    slot #CreditNote_Index_PriceTier
    label "Price tier"
    slot #CreditNote_Index_Tax_Inclusive
    label "Tax inclusive" for #chkCreditNote_Index_Tax_Inclusive
    heading "Accounting details"
    slot #CreditNote_Index_Tax
    label "Tax rule"
    slot #CreditNote_Index_SalesRepresentative
    label "Sales rep*"
    slot #tdCreditNote_Index_DefaultAccount
    label "Account*"
    block #SaleCommon_AvalaraTaxExemptionCode (hidden)
      slot #cmbAvalaraTaxExemptionCode
      label "Tax exemption reason"
    slot #CreditNote_Index_Date
    label "Credit note date"
    block #divRate
      slot #tdCreditNote_Index_CurrencyConversionRate
      label ""
    block #divNote
      heading "Comments"
      textarea#divStickyNote placeholder "Write your notes here..."
      label "Note"
  button "Credit note"
  button "Attachments"
  button "Logs and attributes"
  button "Financials"
  block #divCreditNote (hidden)
    heading "Credit note"
    button "Email"#tabCreditNoteEmailAction ▾
    menu: 
    button "Print"#tabCreditNotePrintAction ▾
    menu: 
    button "View in Xero"#divXero_CreditNote primary (hidden)
    button "Authorize"#divAuthorise_CreditNote primary
    button #divNewLine_CreditNote primary
    button "Expenses"#divDistributeExpenses_CreditNote (hidden)
    slot #divCreditNoteLines
    button "Add more items"#CreditNote_CreditNote_AddLinesRecordLink primary (hidden)
    textarea#tdCreditNote_Index_CreditNoteMemo placeholder "Write your notes here..."
    label "Credit note memo" for #tdCreditNote_Index_CreditNoteMemo
    table: Total
    block #divCreditNoteRefundBlock
      heading "Refunds"
      button "Refund"#divNewPayment_CreditNote primary
      button "Customer credit"#divNewPayment_CreditNote_Credit
      slot #divCreditNotePayments
      button "Add more items"#CreditNote_AddPaymentLinesRecordLink primary (hidden)
      text "Balance due"#CreditNote_CreditNote_BalanceHeader
      slot #CreditNote_CreditNote_Balance
      text "Balance due"#CreditNote_CreditNote_BalanceHeaderTenant
      slot #CreditNote_CreditNote_BalanceTenant
  block #divHistory (hidden)
    heading "Logs and attributes"
    block #Sale_divAttributeSet (hidden)
      heading "Additional attributes"
      block #Sale_liCustomField1
        slot #Sale_CustomField1
        label "Attribute 1"
      block #Sale_liCustomField2
        slot #Sale_CustomField2
        label "Attribute 2"
      block #Sale_liCustomField3
        slot #Sale_CustomField3
        label "Attribute 3"
      block #Sale_liCustomField4
        slot #Sale_CustomField4
        label "Attribute 4"
      block #Sale_liCustomField5
        slot #Sale_CustomField5
        label "Attribute 5"
      block #Sale_liCustomField6
        slot #Sale_CustomField6
        label "Attribute 6"
      block #Sale_liCustomField7
        slot #Sale_CustomField7
        label "Attribute 7"
      block #Sale_liCustomField8
        slot #Sale_CustomField8
        label "Attribute 8"
      block #Sale_liCustomField9
        slot #Sale_CustomField9
        label "Attribute 9"
      block #Sale_liCustomField10
        slot #Sale_CustomField10
        label "Attribute 10"
    heading "Activity log"
    slot #divHistoryLines
    heading "Workflow activity log"
    slot #divWorkflowHistoryLines
  block #divAttachments (hidden)
    heading "Attach file"
    block #divAttachmentUpload
      block #divUploadContainer
        block #preview-template (hidden)
        slot #iUpload (hidden)
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
  slot #divPrint
  modal#CrNote_NewTenantContact_Content medium
    heading "Add a sales representative"
    button "×"
    input text#tdCrNote_NewTenantContact_Name
    label "Name"
    input text#tdCrNote_NewTenantContact_Phone
    label "Phone"
    input text#tdCrNote_NewTenantContact_Fax
    label "Fax"
    input text#tdCrNote_NewTenantContact_Email
    label "Email"
    input text#tdCrNote_NewTenantContact_Website
    label "Website"
    textarea#tdCrNote_NewTenantContact_Comment
    label "Comments"
    button "Save" primary
    button "Close"
  modal#CrNote_NewContact_Content medium
    heading "ADD CUSTOMER CONTACT"
    button "×"
    input text#tdCrNote_NewContact_Name
    label "Name"
    input text#tdCrNote_NewContact_JobTitle
    label "Job title"
    input text#tdCrNote_NewContact_Phone
    label "Phone"
    input text#tdCrNote_NewContact_MobilePhone
    label "Mobile phone"
    input checkbox#tdCrNote_NewContact_IsDefault
    label "Default" for #tdCrNote_NewContact_IsDefault
    input text#tdCrNote_NewContact_Fax
    label "Fax"
    input text#tdCrNote_NewContact_Email
    label "Email"
    input text#tdCrNote_NewContact_Website
    label "Website"
    textarea#tdCrNote_NewContact_Comment
    label "Comments"
    button "Save" primary
    button "Close"
  modal#CrNote_NewDeposit_Content small
    heading #CrNote_NewDeposit_Title
    button "×"
    slot #CrNote_NewDeposit_Account
    label "Deposit account"
    block #CrNote_NewDeposit_BankAcocuntBlock
      input text#CrNote_NewDeposit_BankAccount
      label "Account"
    input text#CrNote_NewDeposit_Reference
    label "Reference"
    slot #CrNote_NewDeposit_DatePaid
    label "Deposit date"
    input text#CrNote_NewDeposit_Amount
    label "Amount"
    block #liCrNote_NewDeposit_ConversionRate
      input text#CrNote_NewDeposit_ConversionRate
      label "Conversion rate"
      button #CrNote_NewDeposit_ConversionRate_GetRate
    block #CrNote_NewDeposit_BaseAmountBlock (hidden)
      slot #CrNote_NewDeposit_BaseAmountLabel
      slot #CrNote_NewDeposit_BaseAmount
    button "Save" primary
    button "Close"
  modal#CrNote_NewAddress_Content medium
    heading "ADD CUSTOMER ADDRESS"
    button "×"
    label "Line 1" for #tdCrNote_NewAddress_Line1
    input text#tdCrNote_NewAddress_Line1
    label "Line 2" for #tdCrNote_NewAddress_Line2
    input text#tdCrNote_NewAddress_Line2
    label "City / suburb" for #tdCrNote_NewAddress_CitySuburb
    input text#tdCrNote_NewAddress_CitySuburb
    label "State / province" for #tdCrNote_NewAddress_StateProvince
    input text#tdCrNote_NewAddress_StateProvince
    label "ZIP / postcode" for #tdCrNote_NewAddress_ZipPostCode
    input text#tdCrNote_NewAddress_ZipPostCode
    label "Country" for #tdCrNote_NewAddress_Country
    select#tdCrNote_NewAddress_Country
    block #SaleCommon_NewAddress_AvalaraTaxExemptionCode (hidden)
      label "Tax exemption reason" for #cmbAvalaraTaxExemptionCode_NewAddress
      slot #cmbAvalaraTaxExemptionCode_NewAddress
    select#tdCrNote_NewAddress_Type: Billing | Business | Shipping
    label "Type" for #tdCrNote_NewAddress_Type
    input checkbox#tdCrNote_NewAddress_DefaultForType
    label "Default for type" for #tdCrNote_NewAddress_DefaultForType
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
slot #CountrySpecificScript
```

### `/Customer`: Customer

Frame: `iUpload`.

```text
link "Home"
link "Customers"
button "Save"#saveAction primary
button "Clone"#cloneAction
button "Back to list"
button "General"
button "Addresses"
button "Contacts"
button "Default templates"
button "Additional attributes"
button "Sales by product"
button "Sales by document"
button "Invitations"
button "Product prices"
button "Attachments"
button "Child accounts"
button "Activity log"
button "Accounting dimensions"
heading "New customer"#formCaption
block #divCustomerTask (hidden)
  button 
  button  primary
  button "Workflow"
  button 
  button "Calendar"
button "Sale"#divNewSale ▾
menu: Simple | Advanced #itemDeleteDeprecatedCustomers | Service #itemMergeSelectedCustomers | Credit note #itemMergeSelectedCustomers | Opportunity #itemMergeSelectedCustomers
button "More"#divMore ▾
menu: Pseudonymize
button 
block #divGeneral
  input text#tdCustomer_Index_Name
  label "Name"
  slot #tdCustomer_Index_Status
  label "Status"
  block #divSaleAccount
    slot #tdCustomer_Index_SaleAccount
    label "Sale account"
    slot #tdCustomer_Index_TaxRule
    label "Tax rule"
  slot #tdCustomer_Index_Currency
  label "Currency"
  slot #tdCustomer_Index_AccountPayable
  label "Account receivable"
  slot #tdCustomer_Index_SalePriceTier
  label "Sale price tier"
  input text#tdCustomer_Index_CustomerName
  label "Display name"
  slot #tdCustomer_Index_Parent
  label "Parent"
  slot #tdCustomer_Index_DefaultSalesRepresentative
  label "Sales representative"
  slot #tdCustomer_Index_CreditLimit
  label "Credit limit"
  slot #tdCustomer_Index_PaymentTerm
  label "Payment term"
  slot #tdCustomer_Index_AttributeSet
  label "Attribute set"
  block #divTaxNumber
    slot #tdCustomer_Index_TaxNumber
    label "Tax number"
  slot #tdCustomer_Index_IsLegalEntity
  label "Legal entity" for #chkIsLegalEntity
  slot #tdCustomer_Index_BillParent
  label "Bill parent" for #chkBillParent
  block #divCustomer_Index_Discount
    slot #tdCustomer_Index_Discount
    label "Discount"
  slot #tdCustomer_Index_IsOnCreditHold
  label "On credit hold" for #chkIsOnCreditHold
  block #divIsOnHoldByCreditLimit (hidden)
  slot #tdCustomer_Index_DefaultCarrier
  label "Default carrier"
  slot #tdCustomer_Index_DefaultLocation
  label "Default location"
  input text#tdCustomer_Index_Tags
  label "Tags"
  block #divComments
    textarea#tdCustomer_Index_Comments placeholder "Write your note here..."
    label "Comments"
block #divAddresses (hidden)
  button #btnNewAddress primary
  button #btnAddressSearching primary
  button #btnAddressSearching2 primary
  slot #tdCustomer_Index_AddressCategory
  slot #divAddressLines
  button "Add a new address"#btnNewAddress3 primary
  button "Add a new address"#btnAddressSearching3 primary
block #divContacts (hidden)
  button #btnNewContact primary
  button #btnNewContactSearching primary
  slot #divContactLines
  button "Add a new contact"#btnNewContact2 primary
  button "Add a new contact"#btnNewContactSearching2 primary
block #divDefaultTemplates (hidden)
  heading "Sale document templates"
  slot #tdCustomer_Index_DefaultTemplate_SaleQuote
  label "Sale quote" for #tdCustomer_Index_DefaultTemplate_SaleQuote
  slot #tdCustomer_Index_DefaultTemplate_SaleQuoteMatrix
  label "Sale quote matrix" for #tdCustomer_Index_DefaultTemplate_SaleQuoteMatrix
  slot #tdCustomer_Index_DefaultTemplate_SalesOrder
  label "Sales order" for #tdCustomer_Index_DefaultTemplate_SalesOrder
  slot #tdCustomer_Index_DefaultTemplate_SalesOrderMatrix
  label "Sales order matrix" for #tdCustomer_Index_DefaultTemplate_SalesOrderMatrix
  slot #tdCustomer_Index_DefaultTemplate_Invoice
  label "Invoice" for #tdCustomer_Index_DefaultTemplate_Invoice
  slot #tdCustomer_Index_DefaultTemplate_InvoiceMatrix
  label "Invoice matrix" for #tdCustomer_Index_DefaultTemplate_InvoiceMatrix
  slot #tdCustomer_Index_DefaultTemplate_PickList
  label "Pick list" for #tdCustomer_Index_DefaultTemplate_PickList
  slot #tdCustomer_Index_DefaultTemplate_ExpandedPickListBOM
  label "Expanded pick list-BOM" for #tdCustomer_Index_DefaultTemplate_ExpandedPickListBOM
  slot #tdCustomer_Index_DefaultTemplate_Receipt
  label "Receipt" for #tdCustomer_Index_DefaultTemplate_Receipt
  slot #tdCustomer_Index_DefaultTemplate_PackingSlip
  label "Packing slip" for #tdCustomer_Index_DefaultTemplate_PackingSlip
  slot #tdCustomer_Index_DefaultTemplate_BoxLabel
  label "Box label" for #tdCustomer_Index_DefaultTemplate_BoxLabel
  slot #tdCustomer_Index_DefaultTemplate_CreditNote
  label "Credit note" for #tdCustomer_Index_DefaultTemplate_CreditNote
  slot #tdCustomer_Index_DefaultTemplate_GiftCards
  label "Gift cards" for #tdCustomer_Index_DefaultTemplate_GiftCards
  slot #tdCustomer_Index_DefaultTemplate_WarrantyCertificates
  label "Warranty certificates" for #tdCustomer_Index_DefaultTemplate_WarrantyCertificates
block #Customer_divAttributeSet (hidden)
  heading "Additional attributes"
  block #Customer_liCustomField1
    slot #Customer_CustomField1
    label "Attribute 1"
  block #Customer_liCustomField2
    slot #Customer_CustomField2
    label "Attribute 2"
  block #Customer_liCustomField3
    slot #Customer_CustomField3
    label "Attribute 3"
  block #Customer_liCustomField4
    slot #Customer_CustomField4
    label "Attribute 4"
  block #Customer_liCustomField5
    slot #Customer_CustomField5
    label "Attribute 5"
  block #Customer_liCustomField6
    slot #Customer_CustomField6
    label "Attribute 6"
  block #Customer_liCustomField7
    slot #Customer_CustomField7
    label "Attribute 7"
  block #Customer_liCustomField8
    slot #Customer_CustomField8
    label "Attribute 8"
  block #Customer_liCustomField9
    slot #Customer_CustomField9
    label "Attribute 9"
  block #Customer_liCustomField10
    slot #Customer_CustomField10
    label "Attribute 10"
block #divSalesByProduct (hidden)
  input text#divSearchSalesByProduct name=searchFieldSalesByProductValue placeholder "Type text to search"
  button "Search" primary
  slot #tdCustomer_Sales_By_Product_Search (hidden)
  block #divFilterCustomerSalesByProductContainer
    select#divFilterCustomerSalesByProduct
  slot #divSalesByProductLines
block #divSalesByDocument (hidden)
  input text#divSearchSalesByDocument name=searchFieldSalesByDocumentValue placeholder "Type text to search"
  button "Search" primary
  slot #tdCustomer_Sales_By_Document_Search (hidden)
  block #divFilterCustomerSalesByDocumentContainer
    select#divFilterCustomerSalesByDocument
  slot #divSalesByDocumentLines
block #divInvitations (hidden)
  slot #Customer_Index_PortalFilterCombobox
  slot #gridInviteToB2BRecipients
block #divAccountingDimensions (hidden)
  heading "Accounting dimensions"
  slot #divAccountingDimensionsList
block #divAttachments (hidden)
  block #divUploadContainer
    block #preview-template (hidden)
    slot #iUpload (hidden)
    form#frmUpload
      heading "Drop files here or click to upload."
  button "Attach from Google Drive" primary
  slot #divAttachmentList
block #divChildAccounts (hidden)
  slot #Customer_Index_CustomerChildrenContainer
block #divCustomPrices (hidden)
  button #divCustomPricesNew primary
  input text#divCustomPricesSearch placeholder "Type text to search"
  button "Search" primary
  button #divCustomPricesRefresh
  button "Auto-fill"#divCustomPricesAutoFill
  button "Clear all"#divCustomPricesClearAll
  slot #CustomPrices_Container
  slot #customPriceLimit (hidden)
block #divActivityLogs (hidden)
  slot #ActivityLogs_Container
modal#Customer_NewContact_Content medium
  heading #Customer_NewContact_dialogTitle
  button "×"
  input text#tdCustomer_NewContact_Name
  label "Name" for #tdCustomer_NewContact_Name
  label "Job title" for #tdCustomer_NewContact_JobTitle
  input text#tdCustomer_NewContact_JobTitle
  label "Phone" for #tdCustomer_NewContact_Phone
  input text#tdCustomer_NewContact_Phone
  label "Mobile phone" for #tdCustomer_NewContact_MobilePhone
  input text#tdCustomer_NewContact_MobilePhone
  label "Fax" for #tdCustomer_NewContact_Fax
  input text#tdCustomer_NewContact_Fax
  label "Email" for #tdCustomer_NewContact_Email
  input text#tdCustomer_NewContact_Email
  label "Website" for #tdCustomer_NewContact_Website
  input text#tdCustomer_NewContact_Website
  input checkbox#tdCustomer_NewContact_IsDefault
  label "Default" for #tdCustomer_NewContact_IsDefault
  label "Comments" for #tdCustomer_NewContact_Comment
  textarea#tdCustomer_NewContact_Comment
  button "Save" primary
  button "Close"
modal#Customer_NewAddress_Content medium
  heading #Customer_NewAddress_dialogTitle
  button "×"
  slot #cmbAddress
  input text#tdCustomer_NewAddress_Line1
  label "Line 1" for #tdCustomer_NewAddress_Line1
  label "Line 2" for #tdCustomer_NewAddress_Line2
  input text#tdCustomer_NewAddress_Line2
  label "City / suburb" for #tdCustomer_NewAddress_CitySuburb
  input text#tdCustomer_NewAddress_CitySuburb
  label "State / province" for #tdCustomer_NewAddress_StateProvince
  input text#tdCustomer_NewAddress_StateProvince
  label "ZIP / postcode" for #tdCustomer_NewAddress_ZipPostCode
  input text#tdCustomer_NewAddress_ZipPostCode
  select#tdCustomer_NewAddress_Country
  label "Country" for #tdCustomer_NewAddress_Country
  block #SaleCommon_NewAddress_AvalaraTaxExemptionCode (hidden)
    label "Tax exemption reason" for #cmbAvalaraTaxExemptionCode_NewAddress
    slot #cmbAvalaraTaxExemptionCode_NewAddress
  select#tdCustomer_NewAddress_Type: Billing | Business | Shipping
  label "Type" for #tdCustomer_NewAddress_Type
  input checkbox#tdCustomer_NewAddress_DefaultForType
  label "Default for type" for #tdCustomer_NewAddress_DefaultForType
  button "Save" primary
  button "Close"
modal#TenantPaymentTerm_NewTerm_Content small
  heading "Add a payment term"
  button "×"
  input text#tdTenantPaymentTerm_NewTerm_Name
  label "Name" for #tdTenantPaymentTerm_NewTerm_Name
  select#tdTenantPaymentTerm_NewTerm_Method: Number of days | Day of next month | Last day of next month | Days since the end of the month
  label "Method" for #tdTenantPaymentTerm_NewTerm_Method
  input text#tdTenantPaymentTerm_NewTerm_Days
  label "Days" for #tdTenantPaymentTerm_NewTerm_Days
  button "Save" primary
  button "Close"
slot #CountrySpecificScript
```

### `/CustomerList`: Customers

Frame: `task-upload-frame`.

```text
link "Home"
link "Customers"#vCustomers
link "Customer credits"#vCustomerCredits
block #Customers_Index_Container_Wrapper
  heading "Customers"
  heading "Sales statements"
  block #back-form-control (hidden)
    button "Back"#backAction
  block #print-form-control (hidden)
    button "Print"#divPrint ▾
  block #email-form-control (hidden)
    button "Email"#divEmail ▾
  block #import-form-control
    button "Import"#divImport ▾
    link "Customers"
    link "Customer addresses"
    link "Customer contacts"
    link "Custom prices"
  block #export-form-control
    button "Export"#divExport ▾
    link "Customers"
    link "Customer addresses"
    link "Customer contacts"
    link "Custom prices"
  block #more-actions-form-control
    button "More actions"#divMoreActions ▾
    link "Sales statements"
    link "Delete deprecated customers"#itemDeleteDeprecatedCustomers
    link "Merge selected customers"#itemMergeSelectedCustomers
  button #divNew primary
  input text#divSearch placeholder "Type text to search"
  button "Search" primary
  select#divFilter
  input checkbox#IsActiveContainer
  label "Only active customers" for #IsActiveContainer
  button #divRefresh
  button #Grid_gridName_Options
  block #divSelectedItemCount
    slot #lSelectedCounter
  input text#divSearchSalesStatements placeholder "Type text to search"
  button "Search" primary
  input text#divFrom
  input text#divTo
  button #divRefreshSalesStatements
  button #Grid_gridName_OptionsSalesStatements
  slot #CustomerList_Index_Container (hidden)
  form#frmExport
  form#frmExportAddresses
  form#frmExportContacts
  form#frmPrintList
  form#frmExportCustomPrices
block #CustomerCredits_Index_Container_Wrapper
  input text#divSearchCustomerCredits placeholder "Type text to search"
  button "Search" primary
  input checkbox#divUsedCredits
  label "Show used credits" for #divUsedCredits
  button "Refresh"#divRefreshCustomerCredits
  button #Grid_gridName_OptionsCustomerCredits
  slot #CustomerCredits_Index_Container (hidden)
modal#CustomerCredits_Allocated_Details medium
  heading "Allocated details"#allocationHeader
  button "×"
  slot #divAllocatedDetailsGridContainer
  button "Close"
modal#divCustomerList_Delete_ContentDialog small
  heading "Delete deprecated customers"
  button "×"
  block #CustomerList_Delete_ValidationContainerSuccess
  slot #Delete_ResultContainer (hidden)
  block #CustomerList_Delete_ValidationContainerWarning
  block #CustomerList_Delete_ValidationContainerError
  button "Delete"#CustomerList_Delete_Actions
  button "Close"
modal#divCustomerList_Merge_ContentDialog small
  heading "Merge customers"
  button "×"
  block #CustomerList_Merge_ValidationContainerSuccess (hidden)
  block #CustomerList_Merge_ValidationContainerWarning (hidden)
  block #CustomerList_Merge_ValidationContainerError (hidden)
  select#tdPrimaryMergeCustomer
  label "Primary customer" for #ctdPrimaryMergeCustomer
  label "Merge customers"
  slot #MergeCustomerGridContainer
  block #CustomerList_Merge_Actions
    button "Merge"#CustomerList_Merge_Execute primary
    button "Cancel"
modal#dlgReCaptchaModal small
  heading "CAPTCHA verification"#dlgReCaptchaModalCaption
  button "×"
  block #emailReCaptcha
  button "Continue"#dlgReCaptchaModal_continue primary
  button "Close"
```

### `/CustomerPayment`: Customer bulk payment

Frame: `task-upload-frame`.

```text
link "Home"
link "Customers"
slot #tdCustomer
label "Customer"
slot #tdCurrency
label "Currency"
slot #tdPeriod
label "Period"
block #lblFrom (hidden)
  slot #tdFrom
  label "From"
block #lblTo (hidden)
  slot #tdTo
  label "To"
button "Show due invoices" primary
slot #tdAmount
label "Amount"
block #liConversionRate (hidden)
  slot #tdConversionRateContainer
  label "Conversion rate"
slot #tdPaymentDate
label "Payment date"
slot #dtPaymentReference
label "Reference"
slot #tdPaymentAccountCode
label "Account"
block #Customer_Payment_GridBlock (hidden)
  block #div_Button_Cin7Pay (hidden)
    button "Cin7 Pay" primary
  button "Pay" primary
  label "Unallocated"
  slot #tdUnallocated
  slot #divContainer
block #Customer_Payment_EmptyBlock
  text "Please fill all required fields first."
modal#CustomerPayment_Cin7PayBulkPaymentForm small
  heading "Pay now"
  button "×"
  slot #cin7paybulkpaymentcheckout
  block #paymentNoteText (hidden)
    slot #divAdditionalDescriptionsNotes
  block #surchageNoteText (hidden)
    slot #divSurchargeDescriptionsNotes
  block #divCin7PayPayment
    button "Pay"#submit primary
    button "Close"
    slot #payment-message (hidden)
  text "Payment processing..."#spanCin7PayPaymentprocessing (hidden)
link "2012-2026 © Cin7 Americas, Inc"
link "Privacy policy"
link "Terms of use"
link "Support"
```

### `/DiscountNew`: Discount

Frame: `task-upload-frame`.

```text
link "Home"
link "Reference Books"
link "Discounts"
block #discount-new-page
  slot #formCaption
  button "Save"#saveAction primary
  button "Back to list"#backAction
  label "Name" for #tdWarrantySetup_Index_Name
  label "Type"
  input text#tdDiscountNew_Index_Name placeholder "Enter a discount name"
  select#tdDiscountNew_Index_Type
  label "Active discount" for #tdWarrantySetup_IsAutoGeneratedNumber
  input checkbox#tdDiscountNew_Index_IsActive (hidden)
  input radio#tdDiscountNew_Index_IsActive_Active name=tdDiscountNew_Index_IsActive
  label "Active" for #tdDiscountNew_Index_IsActive_Active
  input radio#tdDiscountNew_Index_IsActive_Inactive name=tdDiscountNew_Index_IsActive
  label "Inactive" for #tdDiscountNew_Index_IsActive_Inactive
  block #sectionSimple
    label "Discount type" for #tdWarrantySetup_Index_Name
    label "Value"
    select#Discount_Simple_ValueType
    input text#Discount_Simple_Amount name=tdDiscountNew_Index_Name placeholder "Enter a discount value"
  block #sectionQuantityBased
    button #divNew primary
    slot #DiscountNew_QuantityBasedGrid
    button "Add more items"#DiscountNew_Lines_AddLink primary
  block #sectionFreeShipping
    label "Order total exceeds" for #tdWarrantySetup_Index_Name
    input text#Discount_Exceeds_Amount placeholder "Enter total order exceeds"
```

### `/FulfillmentOrder`: Fulfillment order

Frame: `task-upload-frame`.

```text
link "Home"
link "Fulfillment list"
button "Save"#saveAction primary
button "Back to list"
block #divMainContent
  slot #tdStatus
  heading 
  button "Complete"#shipAction primary (hidden)
  button "Update"#refreshAction (hidden)
  button "Process"#processAction primary (hidden)
  button "Cancel order"#cancelAction (hidden)
  button #taskHeaderCollapse
  block #divTaskHeader
    slot #tdFulfillmentOrder_Index_SaleTask
    label "Sale task"
    slot #tdFulfillmentOrder_Index_CustomerName
    label "Customer name"
    slot #tdFulfillmentOrder_Index_Date
    label "Date"
    slot #tdFulfillmentOrder_Index_Shipping
    label "Shipping method"
    slot #tdFulfillmentOrder_Index_ShipmentName
    label "Contact"
    slot #tdFulfillmentOrder_Index_ShipmentPhone
    label "Contact phone"
    input text#tdFulfillmentOrder_Index_ShippingLine1
    button #btnFulfillmentOrder_Index_EditShippingAddress primary
    label "Shipping address line 1"
    slot #tdFulfillmentOrder_Index_ShippingLine2
    label "Shipping address line 2"
    textarea#tdFulfillmentOrder_Index_Comments placeholder "Write your note here..."
    label "Comments" for #tdFulfillmentOrder_Index_Comments
  button "Items"
  button "Log"
  button "Tracking information"
  block #divItems (hidden)
    slot #divItemsLines
  block #divLog (hidden)
    slot #divLogLines
  block #divTracking (hidden)
    slot #tdFulfillmentOrder_Index_RecievedDate
    label "" for #FulfillmentOrder_Index_RecievedDate
    slot #tdFulfillmentOrder_Index_ShipDate
    label "" for #FulfillmentOrder_Index_ShipDate
    slot #tdFulfillmentOrder_Index_ArrivalDate
    label "" for #FulfillmentOrder_Index_ArrivalDate
    slot #divTrackingLines
    block #TrackingLinesDetailsBlock
      heading "Tracking details for the selected package"#PackageSelectedDetails
      slot #divTrackingDetails
modal#FulfillmentOrder_EditAddress_Content small
  heading "Edit shipping address"
  button "×"
  input text#tdFulfillmentOrder_EditAddress_Line1
  label "Line 1" for #tdFulfillmentOrder_EditAddress_Line1
  input text#tdFulfillmentOrder_EditAddress_Line2
  label "Line 2" for #tdFulfillmentOrder_EditAddress_Line2
  input text#tdFulfillmentOrder_EditAddress_CitySuburb
  label "City / suburb" for #tdFulfillmentOrder_EditAddress_CitySuburb
  input text#tdFulfillmentOrder_EditAddress_StateProvince
  label "State / province" for #tdFulfillmentOrder_EditAddress_StateProvince
  input text#tdFulfillmentOrder_EditAddress_ZipPostCode
  label "ZIP / postcode" for #tdFulfillmentOrder_EditAddress_ZipPostCode
  slot #tdFulfillmentOrder_EditAddress_Country
  label "Country" for #tdFulfillmentOrder_EditAddress_Country
  button "Save" primary
  button "Close"
```

### `/FulfillmentOrderList`: Fulfillment orders

Frame: `task-upload-frame`.

```text
link "Home"
input text#divSearch placeholder "Type text to search"
button "Search" primary
button "Refresh"#divRefresh
button #Grid_gridName_Options
slot #FulfillmentOrderList_Index_Container
```

### `/RMA`: RMA

Frame: `iUpload`.

```text
block #list-view
  block #gridBreadcrumb
    link "Home"
    button "Tutorial"
  block #gridTabs
    link "RMA - General"#vGeneral
    link "RMA - Products"#vProducts
    link "Registered warranties"
  slot #FeatureModuleDetailsBlock (hidden)
  block #General_Index_Container_Wrapper
    block #grid
      button  primary
      input text#divSearch placeholder "Type text to search"
      button "Search"#RMAListSearchBtn primary
      select#divFilter
      button "Export"#divExport
      button "Refresh"#divRefresh
      button #Grid_RMAListGrid_Options
      slot #RMAList_Index_Container
  block #Products_Index_Container_Wrapper (hidden)
    block #grid
      button  primary
      input text#divProductsSearch placeholder "Type text to search"
      button "Search"#RMAProductsListSearchBtn primary
      select#divProductsFilter
      button "Export"#divProductsExport
      button "Refresh"#divProductsRefresh
      button #Grid_RMAProductsListGrid_Options
      slot #RMAProductsList_Index_Container
modal#RMA_ChooseProducts_Content
  heading "Find products for RMA request"
  button "×"
  slot #divRMASearchOrderNumbers
  label "Order number"
  button "Search" primary (hidden)
  block #RMA_Request_Products_Container
    table: Product | Batch info | Customer | Max QTYto return | QTY toreturn | QTY alreadyreturned | Return policy | Packing conditions | Reasons for return | Return type | Notes
  button "Create" primary
  button "Close"
modal#RMA_GridAttachment_Content medium
  heading "Add an attachment to RMA request"
  button "×"
  block #preview-template (hidden)
  slot #iUpload (hidden)
  form#RMAAttachmensDropContainer
    heading "Drop files here or click to upload."
  textarea#RMA_Index_AttachmentComment placeholder "Add a comment..."
  label "Comments" for #RMA_Index_AttachmentComment
  button "Add" primary
  button "Close"
modal#RMA_ReturnPolicyModal_Content small
  heading "Return policy agreement"
  button "×"
  slot #warrantyNumber
  slot #expiredOn
  slot #refundOption
  slot #refundPeriod
  slot #returnPeriod
  slot #replacementPeriod
  slot #inspectionCosts
  slot #shippingCosts
  slot #btnRMAShowReturnPolicyLink
  link "Agreement text"#btnRMAShowReturnPolicyText
  button "Close"
modal#RMA_ReturnPolicyModal_Text medium
  heading "Return policy agreement text"
  button "×"
  button "Close"
slot #modalDialogsContainer
block #editor-view
  block #formBreadcrumb
    link "Home"
    link "RMAs"
    button "Save"#topSaveBtn primary (hidden)
    button "Tutorial"
    button "Back to list"
    button "Void"#voidAction
  block #form
    slot #RMA_Index_Status
    heading 
    block #email-button
      button "Email"#emailAction ▾
      menu: 
    block #print-button
      button "Print"#printAction ▾
      menu: 
    block #completeBtn
      button "Mark as completed" primary
    block #transferToInProgressBtn
      button "Mark as in progress"
    button #taskHeaderCollapse
    block #divTaskHeader
      heading "General info"
      slot #RMA_CreatedDate
      label "Created"
      slot #RMA_ExpiredDate
      label "Expired"
      input text#RMA_ReturnOrder
      label "Return order"
      slot #RMA_ReceiptsLocation
      label "Receipts location"
      textarea#RMA_Index_FreeNotes placeholder "RMA order notes..."
      label "RMA order notes"
      heading "Customer details"
      slot #RMA_Customer
      label "Customer"
      slot #RMA_Contact
      label "Contact"
      slot #RMA_Phone
      label "Phone"
      slot #RMA_Email
      label "Email"
      heading "Shipping details"
      slot #RMA_ShipToCompany
      label "Ship to company"
      slot #RMA_ShipToContact
      label "Ship to contact"
      slot #ShipToOther
      label "Ship to different company" for #chkShipToOther
      block #recepientAddress_Button
        button #RMA_Index_EditOtherAddress primary
      block #customerAddress
        slot #ShippingAddressLine1
        label "Shipping address line 1"
        slot #ShippingAddressLine2
        label "Shipping address line 2"
      block #recepientAddress
        textarea#RMA_Index_ShipToAddress placeholder "Please enter the address..."
      textarea#RMA_Index_ShippingNotes placeholder "Shipping notes..."
      label "Shipping notes"
    button "Products"
    button "Activity logs"
    button "Attachments"
    block #divProducts
      heading "Products"
      block #divProductsContainer
        table#tableRmaProducts: Product | Cross ship | Receipt action
      link "Details"#tabDetails
      link "Resolution"#tabResolution
      link "Related orders"#tabRelatedOrders
      block #divDetails
        slot #dropShip
        slot #SupplierName
        slot #SupplierShippingAddressLine1
        slot #SupplierShippingAddressLine2
        slot #saleOrder
        slot #invoice
        slot #expiryDate
        slot #batchSerial
        slot #warrantyRegistration
        slot #reason
        slot #type
        slot #packing
        slot #returnQuantity
        slot #price
        slot #total
        slot #rejectReason
        slot #btnRmaDetailsReturnPolicyLink
      block #divResolution (hidden)
        heading "Inspection/repair costs"
        text "Please select any expenses that will be billed to the customer."
        slot #divAdditionalCharges
        heading "Resolution"
        block #divReturnToCustomer (hidden)
        button "Resolve"#authoriseBtn primary
        button #btnRefreshResolution
        button #RMAResolution_gridName_Options
        slot #divRMAResolution
        slot #dvRMAResolutionAlert
        slot #txtAreaRMAResolution
      block #divRelatedOrders (hidden)
        button 
        button #RMARelatedOrders_gridName_Options
        slot #divRMARelatedOrders
    block #divActivityLogs
      heading "Activity logs"
      button #divActivityLogsRefresh
      slot #ActivityLogs_Container
    block #divAttachments (hidden)
      heading "Attachments"
      block #divAttachmentUpload
        block #divUploadContainer
          block #preview-template (hidden)
          slot #iUpload (hidden)
          form#frmUpload
            heading "Drop files here or click to upload."
      button "Attach from Google Drive" primary
      slot #divAttachmentList
modal#RMA_EditAddress_Content medium
  heading "Edit shipping address"
  button "×"
  button "Search customer address"#divShowAddressSearch
  button "Hide customer search"#divHideAddressSearch (hidden)
  block #divRMA_Index_Ship_Another_Customer (hidden)
    slot #RMA_Index_Ship_Another_Customer
    label "Customer" for #RMA_Index_Ship_Another_Customer
    slot #RMA_Index_SippingAnotherAddressLine
    label "Address" for #cmbShippingAnotherAddressLine1
  label "Line 1" for #txtRMAAddressLine1
  slot #RMA_EditAddress_Line1
  label "Line 2" for #txtRMAAddressLine2
  slot #RMA_EditAddress_Line2
  label "City / suburb" for #txtRMAAddressCitySuburb
  slot #RMA_EditAddress_CitySuburb
  label "State / province" for #txtRMAAddressStateProvince
  slot #RMA_EditAddress_StateProvince
  label "ZIP / postcode" for #txtRMAAddressZipPostCode
  slot #RMA_EditAddress_ZipPostCode
  label "Country" for #cmbShippingAnotherCountries
  slot #RMA_Index_Countries
  button "OK" primary
  button "Close"
modal#RMA_NewAddress_Content medium
  heading "Add customer address"
  button "×"
  slot #cmbAddress
  button  primary
  label ""
  slot #RMA_NewAddress_Line1
  label "Line 1"
  slot #RMA_NewAddress_Line2
  label "Line 2"
  slot #RMA_NewAddress_CitySuburb
  label "City / suburb"
  slot #RMA_NewAddress_StateProvince
  label "State / province"
  slot #RMA_NewAddress_ZipPostCode
  label "ZIP / postcode"
  slot #RMA_NewAddress_Country
  label "Country"
  slot #RMA_NewAddress_Type
  label "Type"
  input checkbox#chkRMA_NewAddress_DefaultForType
  label "Default for type" for #chkRMA_NewAddress_DefaultForType
  button "Save" primary
  button "Close"
modal#RMA_RejectModal_Content small
  heading "Reject RMA"#rejectCaption
  button "×"
  textarea#RMA_Index_RejectReason placeholder "Add a comment..."
  label "Rejection reason" for #RMA_Index_RejectReason
  button "Submit" primary
  button "Close"
modal#RMA_ProductGridComment_Content small
  heading "Comments and attachments"#commentCaption
  button "×"
  heading "Attachments:"
  slot #fileNames
  textarea#RMA_Index_ProductComment
  label "Comments" for #RMA_Index_ProductComment
  button "Close"
modal#secEmail medium
  heading #emailDialogCaption
  button "×"#crossClose
  button "Send"#btnSendEmail2 primary
  button "Close"#emailBackAction2
  heading "Email subject"
  slot #EmailSendTemplate_AdditionalInfo (hidden)
  input text#DEAREmailTo
  label "To"
  block #EmailSendTemplate_CC
    input text#DEAREmailCC
    label "CC"
  input text#DEAREmailSubject placeholder "Type email subject..."
  label "Subject"
  block #EmailSendTemplate_NetworkingBlock (hidden)
    slot #EmailSendTemplate_NetworkingCheck
    label "Send via Cin7 Core network" for #chkEmail_sendViaNetwork
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
modal#dlgAddSerialNumbers small
  heading "Add serial/batch number"
  button "×"
  text "Please add a serial/batch number for the replacement product to add it to original sale."
  input text
  label "Serial/batch number"
  input text
  label "QTY"
  slot #divAddSerialNumbersDate_1
  label "Expiry date"
  button "Add more numbers"#btnAddSerialNumbersAddLine primary
  button "Add"#btnAddSerialNumbersSave primary
  button "Close"
form#frmExport
form#frmExportProducts
```

### `/RMAReturnOrder`: Return order

Frame: `iUpload`.

```text
block #gridBreadcrumb
  link "Home"
  button "Tutorial"
block #formBreadcrumb (hidden)
  link "Home"
  link "Return orders"
  button "Save"#topSaveBtn primary
  button "Tutorial"
  button "Back to list"
slot #FeatureModuleDetailsBlock (hidden)
block #grid
  input text#divSearch placeholder "Type text to search"
  button "Search" primary
  select#divFilter: All | Waiting for products | Partially authorized | Fully authorized | Completed
  button "Export"#divExport
  button "Refresh"#divRefresh
  button #Grid_gridName_Options
  slot #RMAList_Index_Container
block #form (hidden)
  slot #RMAReturnOrder_Index_Status
  heading 
  button "Void"#voidAction (hidden)
  button "Email"#emailAction ▾
  menu: 
  button "Print"#printAction ▾
  menu: 
  block #completeBtn
    button "Mark as completed" primary
  block #btnBackToInprogress (hidden)
    button "Mark as in progress"
  button #taskHeaderCollapse
  block #divTaskHeader
    heading "General info"
    slot #RMA_CreatedDate
    label "Created"
    slot #RMA_ExpiredDate
    label "Expired"
    textarea#RMA_ReturnOrder
    label "Return order"
    slot #RMA_ReceiptsLocation
    label "Location"
    textarea#RMA_Index_FreeNotes placeholder "Return order notes..."
    label "Return order notes"
    heading "Customer details"
    slot #RMA_Customer
    label "Customer"
    slot #RMA_Contact
    label "Contact"
    input text#RMA_Phone
    label "Phone"
    input text#RMA_Email
    label "Email"
    heading "Shipping details"
    slot #RMA_ShipToCompany
    label "Ship to company"
    slot #RMA_ShipToContact
    label "Ship to contact"
    slot #ShipToOther
    label "Ship to different company" for #chkShipToOther
    block #recepientAddress_Button (hidden)
      button #RMA_Index_EditOtherAddress primary
    block #customerAddress
      slot #ShippingAddressLine1
      label "Shipping address line 1"
      slot #ShippingAddressLine2
      label "Shipping address line 2"
    block #recepientAddress (hidden)
      textarea#RMA_Index_ShipToAddress placeholder "Please enter the address..."
    textarea#RMA_Index_ShippingNotes placeholder "Shipping notes..."
    label "Shipping notes"
  button "Products"
  button "Activity logs"
  button "Attachments"
  block #Products_Index_Container_Wrapper
    heading "Products"
    block #divProductsContainer
      table#tableRmaProducts: Product | Receipt action | QTY toreturn | Bin | ReceivedQTY | Date received | Received
    link "Details"#tabDetails
    link "Inspection/repair costs"#tabAdditionalCharges (hidden)
    link "Resolution"#tabResolution (hidden)
    link "Related orders"#tabRelatedOrders
    block #paneDetails
      slot #warrantyExpired
      slot #warrantyRegistrationNum
      slot #reasonForReturn
      slot #returnExpirationDate
      slot #expiryDate
    block #paneAdditionalCharges (hidden)
      block #jobMilestones
        block #expenseAction
          button "New expense"#newExpense ▾
          slot #divExpenseContainer
        button #btnRefreshMilestones
        button #Milestones2_gridName_Options
        slot #divMilestones2
    block #paneResolution (hidden)
      block #jobResolutionWrap
        label "Job Resolution:"
        slot #RMA_JobResolution
      block #returnToCustomerBtn (hidden)
        button "Resolve" primary
      block #restockNoTransferBtn (hidden)
        button "Resolve" primary
        button #RestockTransferOrder_gridName_Options
      block #restockTransferBtn (hidden)
        button "Resolve" primary
        button #RestockNoTransferOrder_gridName_Options
      block #scrapContainerBtn (hidden)
        button "Resolve" primary
        button #ScrapGrid_gridName_Options
      block #restockNoTransfer (hidden)
        slot #divRestockNoTransferOrder
      block #restockTransfer (hidden)
        slot #divRestockTransferOrder
      block #scrapContainer (hidden)
        slot #divScrap
      block #divReturnToCustomer (hidden)
        text "Product will be returned to customer after resolution of RMA."
    block #paneRelatedOrders (hidden)
      button #btnRefreshRelatedOrders
      button #RMARelatedOrders_gridName_Options
      slot #divRMAReturnOrderRelatedOrders
  block #AuditLog_Index_Container_Wrapper
    block #divActivityLogs
      heading "Activity logs"
      button 
      slot #ActivityLogs_Container
  block #divAttachments (hidden)
    heading "Attachments"
    block #divAttachmentUpload
      block #divUploadContainer
        block #preview-template (hidden)
        slot #iUpload (hidden)
        form#frmUpload
          heading "Drop files here or click to upload."
    button "Attach from Google Drive" primary
    slot #divAttachmentList
modal#RMA_EditAddress_Content medium
  heading "Edit shipping address"
  button "×"
  button "Search customer address"#divShowAddressSearch
  button "Hide customer search"#divHideAddressSearch (hidden)
  block #divRMA_Index_Ship_Another_Customer (hidden)
    slot #RMA_Index_Ship_Another_Customer
    label "Customer" for #RMA_Index_Ship_Another_Customer
    slot #RMA_Index_SippingAnotherAddressLine
    label "Address" for #cmbShippingAnotherAddressLine1
  label "Line 1" for #RMA_EditAddress_Line1
  input text#RMA_EditAddress_Line1
  label "Line 2" for #RMA_EditAddress_Line2
  input text#RMA_EditAddress_Line2
  label "City / suburb" for #RMA_EditAddress_CitySuburb
  input text#RMA_EditAddress_CitySuburb
  label "State / province" for #RMA_EditAddress_StateProvince
  input text#RMA_EditAddress_StateProvince
  label "ZIP / postcode" for #RMA_EditAddress_ZipPostCode
  input text#RMA_EditAddress_ZipPostCode
  label "Country" for #RMA_Index_Countries
  slot #RMA_Index_Countries
  button "OK" primary
  button "Close"
modal#RMA_NewAddress_Content medium
  heading "ADD CUSTOMER ADDRESS"
  button "×"
  slot #cmbAddress
  button  primary
  label ""
  input text#tdRMA_NewAddress_Line1
  label "Line 1"
  input text#tdRMA_NewAddress_Line2
  label "Line 2"
  input text#tdRMA_NewAddress_CitySuburb
  label "City / suburb"
  input text#tdRMA_NewAddress_StateProvince
  label "State / province"
  input text#tdRMA_NewAddress_ZipPostCode
  label "ZIP / postcode"
  select#tdRMA_NewAddress_Country
  label "Country"
  block #RMACommon_NewAddress_AvalaraTaxExemptionCode (hidden)
    slot #cmbAvalaraTaxExemptionCode_NewAddress
    label "Tax exemption reason"
  select#tdRMA_NewAddress_Type: Billing | Business | Shipping
  label "Type"
  input checkbox#tdRMA_NewAddress_DefaultForType
  label "Default for type" for #tdRMA_NewAddress_DefaultForType
  button "Save" primary
  button "Close"
modal#RMA_ProductGridComment_Content small
  heading "Comments and attachments"#commentCaption
  button "×"
  heading "Attachments:"
  slot #fileNames
  textarea#RMA_Index_ProductComment
  label "Comments" for #RMA_Index_ProductComment
  button "Close"
modal#dlgExpenseMiliestone small
  heading "Please select a milestone to assign the expense too."
  button "×"
  slot #dlgExpenseMiliestone_Content
form#frmExport
modal#secEmail medium
  heading #emailDialogCaption
  button "×"#crossClose
  button "Send"#btnSendEmail2 primary
  button "Close"#emailBackAction2
  heading "Email subject"
  slot #EmailSendTemplate_AdditionalInfo (hidden)
  input text#DEAREmailTo
  label "To"
  block #EmailSendTemplate_CC
    input text#DEAREmailCC
    label "CC"
  input text#DEAREmailSubject placeholder "Type email subject..."
  label "Subject"
  block #EmailSendTemplate_NetworkingBlock (hidden)
    slot #EmailSendTemplate_NetworkingCheck
    label "Send via Cin7 Core network" for #chkEmail_sendViaNetwork
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
modal#RO_NewProduct_Content medium
  heading "Add a new product"
  button "×"
  input text#RO_NewProduct_ProductCode placeholder "Enter a product SKU"
  label "SKU"
  input text#RO_NewProduct_Name placeholder "Enter a product name"
  label "Name"
  select#RO_NewProduct_Type
  label "Type"
  select#RO_NewProduct_Category
  label "Category"
  select#RO_NewProduct_PurchaseTaxRule
  label "Purchase tax rule"
  select#RO_NewProduct_SaleTaxRule
  label "Sale tax rule"
  block #trSupplier
    slot #tdRO_NewProduct_Supplier
    label "Supplier"
  block #trPurchasePrice
    input text#RO_NewProduct_PurchasePrice
    label "Purchase price"
  select#RO_NewProduct_UnitOfMeasure
  label "Unit of measure"
  block #trCostingMethod
    select#RO_NewProduct_CostingMethod
    label "Costing method"
  block #trExpenseAccount
    select#RO_NewProduct_ExpenseAccount
    label "Expense account"
  block #trMinimumBeforeReorder
    input text#RO_NewProduct_MinimumBeforeReorder placeholder "Enter a minimum before reorder."
    label "Minimum before reorder"
  block #trReorderQuantity
    input text#RO_NewProduct_ReorderQuantity placeholder "Enter reorder quantity"
    label "Reorder quantity"
  input text#RO_NewProduct_Barcode placeholder "Enter a barcode"
  label "Barcode"
  block #trStockLocator
    input text#RO_NewProduct_StockLocator placeholder "Enter a stock locator"
    label "Stock locator"
  block #trDropShipMode
    select#RO_NewProduct_DropShipMode
    label "Drop ship"
  select#RO_NewProduct_ProductAttributeSet
  label "Attribute set"
  slot #divAdditionalAttributes_NewProduct
  block #AdditionalAttributes_FieldTemplate (hidden)
    slot #{CustomField}
    label "" for #{CustomField}
  button "Save" primary
  button "Close"
```

### `/RecurringInvoices`: Recurring invoices

Frame: `task-upload-frame`.

```text
link "Home"
button "Save"#saveAction primary
button "Create sales"#divProcess primary
button "Refresh"#divRefresh
button #Grid_gridName_Options
slot #divInvoices
```

### `/Sale`: Simple sale

Frame: `iUpload`.

```text
link "Home"
link "Sales"
button "Save"#saveAction primary
button "Back to list"
block #taskActions
  button "Clone"#cloneAction
  button "Convert"#convertAction
  button "New sale for the unshipped goods"#newFromUnshippedAction
  button "Archive"#divArchive
button "Undo"#undoAction
button "Void"#voidAction
block #moreActionsBlock (hidden)
  button "More actions"#moreActions
  link "Undo"#undoAction_more (hidden)
  link "Void"#voidAction_more (hidden)
  link "Clone"#cloneAction_more (hidden)
  link "Convert"#convertAction_more (hidden)
  link "New sale for the unshipped goods"#newFromUnshippedAction_more (hidden)
  link "Archive"#divArchive_more (hidden)
block #divMainContent
  slot #Sale_Index_Status
  heading 
  block #divArchiveStatic (hidden)
  block #divApproveStatic (hidden)
  button "Save as preset"#btnSavePreset primary
  select#cmbPresetList
  button "Delete preset"#btnDeletePreset
  block #divCustomerTask (hidden)
    button 
    button  primary
    button "Workflow"
    button 
    button "Calendar"
  button #taskHeaderCollapse
  block #divTaskHeader
    heading "Customer details"
    slot #Sale_Index_Customer
    label "Customer"
    slot #Sale_Index_Contact
    label "Contact"
    slot #Sale_Index_Phone
    label "Phone"
    slot #Sale_Index_Email
    label "Email"
    slot #Sale_Index_CustomerReference
    label "Reference"
    block #Sale_Index_PurchaseOrderReference_FormControl
      slot #Sale_Index_PurchaseOrderReference
      label "Purchase order reference"
    slot #Sale_Index_BillingAddressLine1
    label "Billing address line 1"
    slot #Sale_Index_BillingAddressLine2
    label "Billing address line 2"
    block #Sale_Index_ChannelOrderType_FormControl
      slot #Sale_Index_ChannelOrderType
      label "Channel order type"
    slot #Sale_Index_PriceTier
    label "Price tier*"
    heading "Accounting details"
    slot #Sale_Index_Terms
    label "Terms"
    slot #Sale_Index_SalesRepresentative
    label "Sales rep*"
    slot #tdSale_Index_DefaultAccount
    label "Account*"
    block #divRate
      slot #tdSale_Index_CurrencyConversionRate
      label ""
    slot #Sale_Index_Tax
    label "Tax rule*"
    slot #Sale_Index_Tax_Inclusive
    label "Tax inclusive" for #chkSale_Index_Tax_Inclusive
    slot #Sale_Index_SkipQuote
    label "Skip quote" for #chkSkipQuote
    slot #Sale_Index_IsRecursive
    label "Recurring task" for #chkIsRecursive
    block #Sale_Index_lblFrequency
      slot #Sale_Index_Frequency
      label "Recurring frequency"
    block #liInvoiceNo
      input text#Sale_Index_InvoiceNo
      label "Invoice #"
    block #liInvoiceDate
      input text#Sale_Index_InvoiceDate
      label "Invoice date"
    block #liInvoiceDueDate
      input text#Sale_Index_DueDate
      label "Due date"
    heading "Shipping details"
    slot #Sale_Index_Location
    label "Location*"
    slot #Sale_Index_Date
    label "Date*"
    slot #Sale_Index_ShipToCompany
    label "Ship to company"
    slot #Sale_Index_ShipToContact
    label "Ship to contact"
    slot #Sale_Index_ShipToOther
    label "Ship to different company" for #chkHeaderShipToOther
    button #Sale_Index_EditOtherAddress primary
    block #Sale_Index_CustomerAddress
      slot #Sale_Index_SippingAddressLine1
      label "Shipping address line 1"
      slot #Sale_Index_SippingAddressLine2
      label "Shipping address line 2"
    block #SaleCommon_AvalaraTaxExemptionCode (hidden)
      slot #cmbAvalaraTaxExemptionCode
      label "Tax exemption reason"
    block #Sale_Index_RecepientAddress (hidden)
      textarea#tdSale_Index_ShipToAddress placeholder "Please enter the address..."
    textarea#Sale_Index_ShippingNotes placeholder "Shipping notes..."
    label "Shipping notes"
    slot #Sale_Index_ShipmentRequiredByDate
    label "Required by"
    block #Sale_Index_ShipServiceGroup
      input text#Sale_Index_ShippingCarrierService
      label "Carrier / service"
      button #Sale_Index_ShippingCarrierServiceLookup
    heading "Comments"
    block #divNote
      textarea#divStickyNote placeholder "Write your note here..."
  button "Quote"
  button "Order"
  button "Pick"
  button "Pack"
  button "Ship"
  button "Invoice"
  button "Excise tax"
  button "Credit note"
  button "Restock"
  button "Manual journals"
  button "Related orders"
  button "Attachments"
  button "Logs and attributes"
  button "Financials"
  block #divQuote (hidden)
    heading "Quote"
    button "Email"#tabQuoteEmailAction ▾
    button "Print"#tabQuotePrintAction ▾
    button "Apply discounts"#divDiscounts_Quote
    button "Apply coupon"#divCoupon_Quote
    button "Authorize"#divAuthorise_Quote primary
    button "Approve"#btApprove primary (hidden)
    button "Reject"#btReject (hidden)
    button "Review"#btReview (hidden)
    button "To order"#divAuthorise_Quote_GoToOrder primary (hidden)
    slot #vSaleQuoteLinesDiscountDescription (hidden)
    button #divNewLines_Quote primary
    button "Family"#divAddBulk_Quote
    button "Scan"#divScan_Quote
    slot #divQuoteLines
    button "Add more items"#Sale_Quote_AddQuoteLinesRecordLink primary (hidden)
    button "Export"#divExport_Quote primary
    button "Import"#divImport_Quote primary
    heading "Additional charges and services"
    button #divNewAdditionalCostLine_Quote primary
    button "Get shipping rates"#divGetShippingRate_Quote ▾
    slot #divQuoteAdditionalChargesLines
    button "Add more items"#Sale_Quote_AddAdditionalChargesLinesRecordLink primary (hidden)
    textarea#tdSale_Index_QuoteMemo placeholder "Write your note here..."
    label "Quote memo"
    table: Quote lines | Additional charges | Total
    heading "Customer credit"
    button "Customer credit"#divNewPayment_Quote primary
    button "Cin7 Core Payments"#divNewPayment_Quote_PaymentGateway
    button "Cin7 Pay Payments"#divNewPayment_Quote_Cin7Pay
    slot #divDeposits
    button "Add more items"#Sale_Quote_AddDepositsRecordLink primary (hidden)
  block #divOrder (hidden)
    heading "Order"
    block #divCreatePurchaseNote
      button "Create purchase order" primary
      link "For backordered"
      link "For entire sale"
    block #divCreatePurchaseOnStock
      button "Create purchase order" primary
    button "Email"#tabOrderEmailAction ▾
    button "Print"#tabOrderPrintAction ▾
    button "Apply discounts"#divDiscounts_Order
    button "Apply coupon"#divCoupon_Order
    button "Mark as fulfilled"#divFulfill_Order primary
    button "Authorize"#divAuthorise_Order primary
    link "Allocate stock"
    link "Don't allocate stock"
    button "Split order"#divSplit_Order primary
    button "Backorder"#divBackorder_Order primary
    slot #vSaleOrderLinesDiscountDescription (hidden)
    button #divNewLines_Order primary
    button "Copy from quote"#divCopy_Order
    button "Family"#divAddBulk_Order
    button "Scan"#divScan_Order
    slot #SalePicker_Order
    label "Should be picked by" for #cmbSalePicker_Order
    slot #pickerItemsPlaceholder_Order (hidden)
    slot #divOrderLines
    button "Add more items"#Sale_Order_AddOrderLinesRecordLink primary (hidden)
    button "Export"#divExport_Order primary
    button "Import"#divImport_Order primary
    button #divNewAdditionalCostLine_Order primary
    button "Gift card"#divNewGiftCard_Order
    button "Get shipping rates"#divGetShippingRate_Order ▾
    heading "Additional charges and services"
    slot #divOrderAdditionalChargesLines
    button "Add more items"#Sale_Order_AddAdditionalChargesLinesRecordLink primary (hidden)
    textarea#tdSale_Index_OrderMemo placeholder "Write your note here..."
    label "Order memo" for #Sale_Index_OrderMemo
    table: Order lines | Additional charges | Total
    heading "Customer credit"
    button "Customer credit"#divNewPayment_Order primary
    button "Cin7 Core Payments"#divNewPayment_Order_PaymentGateway
    button "Cin7 Pay Payments"#divNewPayment_Order_Cin7Pay
    slot #divOrderDeposits
    button "Add more items"#Sale_Order_AddDepositsRecordLink primary (hidden)
  block #divPick (hidden)
    heading "Pick"
    button "Email"#tabPickEmailAction ▾
    button "Print"#tabPickPrintAction ▾
    button "Multiple fulfillment"#divNewSale_Pick primary
    button "New sale"#divSplitSale_Pick primary
    button "Undo"#divUndo_Pick
    button "Authorize"#divAuthorise_Pick primary
    button "Authorize"#divAuthorise2_Pick primary
    button "To pack"#divAuthorise_Pick_GoToPack primary (hidden)
    button #divNew_Pick primary
    button "Scan"#divScan_Pick
    button "Auto pick"#divAuto_Pick
    slot #SalePicker_Pick
    label "Should be picked by" for #cmbSalePicker_Pick
    slot #pickerItemsPlaceholder_Pick (hidden)
    slot #divPickLines
    button "Add more items"#Sale_Pick_AddRecordLink primary (hidden)
  block #divPack (hidden)
    block #blockPackTab
      block #hasShippingPackHeader
        button "Pack"
        button "Shipping instructions"#subTabShippingInstructions
        button "Package details"#subTabPackageDetail
      block #hasNoShippingPackHeader
        heading "Pack"
      button "Email"#tabPackEmailAction ▾
      button "Print"#tabPackPrintAction ▾
      button "Undo"#divUndo_Pack
      button "Authorize"#divAuthorise_Pack primary
      button "To ship"#divAuthorise_Pack_GoToShip primary (hidden)
      button #divNew_Pack primary
      button "Scan"#divScan_Pack
      button "Copy from pick"#divCopyFromPick_Pack
      slot #divPackLines
      button "Add more items"#Sale_Pack_AddRecordLink primary (hidden)
    block #blockShippingInstructions (hidden)
      button "Pack"
      button "Shipping instructions"
      button "Package details"
      button "To package details" primary
      button "Enter shipping instructions"#btnEnterShippingInstructions
      slot #divShippingInstructions
    block #blockPackageDetails (hidden)
      button "Pack"
      button "Shipping instructions"
      button "Package details"
      button "Enter package details"#btnEnterPackageDetails
      slot #divPackageDetails
  block #divShip (hidden)
    heading "Ship"
    button "Email"#tabShipEmailAction ▾
    button "Print"#tabShipPrintAction ▾
    button "Undo"#divUndo_Ship
    button "Authorize"#divAuthorise_Ship primary
    button #divNew_Ship primary
    block #controlCopyFromPack_Ship
      button "Auto fill"#divCopyFromPack_Ship ▾
    block #controlCopyFromPack2_Ship
      button "Copy from pack"#divCopyFromPack2_Ship
    button "Add a line for external fulfillment"#divNew_ShipExt
    button "Shipping manifest"#divDownloadShipManifest ▾ (hidden)
    button "Shipping label"#divDownloadShipLabel ▾ (hidden)
    button "Generate shipping label"#divGenerateShipLabel
    button "Confirm authorization"#divConfirmAuthorise_Ship
    button "Resend to ShipStation"#divResendToShipStation (hidden)
    slot #divShipLines
    button "Add more items"#Sale_Ship_AddRecordLink primary (hidden)
    block #FulfillmentBlock
      heading "Fulfillment orders"
      slot #divFulfillmentLines
  block #divInvoice (hidden)
    heading "Invoice"
    slot #HeaderInvoiceNo
    button "Email"#tabInvoiceEmailAction ▾
    button "Print"#tabInvoicePrintAction ▾
    button "View in Xero"#divXero_Invoice (hidden)
    button "Authorize"#divAuthorise_Invoice primary
    slot #tdSale_Invoice_Date
    label "Invoice date*"
    slot #tdSale_Invoice_DueDate
    label "Due date*"
    slot #divInvoiceLines
    button "Copy from order"#divCopy_Invoice
    heading "Additional charges and services"
    button #divNewAdditionalCostLine_Invoice primary
    button "Gift card"#divNewGiftCard_Invoice
    button "Get shipping rates"#divGetShippingRate_Invoice ▾
    slot #divInvoiceAdditionalChargesLines
    button "Add more items"#Sale_Invoice_AddAdditionalChargesLinesRecordLink primary (hidden)
    textarea#tdSale_Index_InvoiceMemo placeholder "Write your note here..."
    label "Invoice memo" for #Sale_Index_InvoiceMemo
    table: Invoice lines | Additional costs | Total
    heading "Payment"
    block #divInvoicePaymentsButtonSet
      button "Payment"#divNewPayment_Invoice primary
      button "Use customer credit"#divUseCustomerCredit
      button "Allocate credit note"#divNewCreditNoteAllocation
      button "Use a gift card"#divNewPaymentGiftCard_Invoice
      button "Cin7 Core Payments"#divNewPayment_Invoice_PaymentGateway
      button "Cin7 Pay Payments"#divNewPayment_Invoice_Cin7Pay
    slot #divInvoicePayments
    button "Payment"#Sale_Invoice_AddPaymentLinesRecordLink primary (hidden)
    button "Use customer credit"#btnUseCustomerCreditLink primary (hidden)
    button "Allocate credit note"#btnNewCreditNoteAllocationLink primary (hidden)
    text "Balance due"#Sale_Invoice_BalanceHeader
    slot #Sale_Invoice_Balance
    block #Sale_Invoice_BalanceDueText
      text "Balance due"#Sale_Invoice_BalanceHeaderTenant
      slot #Sale_Invoice_BalanceTenant
    heading "Customer credit"
    button "Customer credit"#divNewCreditPayment_Invoice primary
    button "Cin7 Core Payments"#divNewCreditPayment_Invoice_PaymentGateway
    button "Cin7 Pay Payments"#divNewCreditPayment_Invoice_Cin7Pay
    slot #divInvoiceDeposits
    button "Add more items"#Sale_Invoice_AddDepositsRecordLink primary (hidden)
  block #divExciseTax (hidden)
    heading "Excise tax"
    button "Authorize"#divAuthorise_ExciseTax primary
    label "Reference no. *" for #Sale_ExciseTax_ExciseReferenceNo
    slot #tdSale_ExciseTax_ExciseReferenceNo
    label "Transfer license no." for #Sale_ExciseTax_TransferLicenseNo
    slot #tdSale_ExciseTax_TransferLicenseNo
    slot #tdSale_ExciseTax_Deductible
    label "Deductible" for #Sale_ExciseTax_Deductible
    label "Excise tax effective date *" for #Sale_ExciseTax_ExciseDate
    slot #tdSale_ExciseTax_ExciseDate
    label "Date of excise tax paid" for #Sale_ExciseTax_DateExciseTaxPaid
    slot #tdSale_ExciseTax_DateExciseTaxPaid
    slot #divExciseTaxLines
    table
  block #divCreditNote (hidden)
    heading "Credit note"
    slot #tdSale_CreditNote_Number
    button "Void credit note and restock"#divVoid_CreditNote
    button "Email"#tabCreditNoteEmailAction ▾
    button "Print"#tabCreditNotePrintAction ▾
    button "Authorize"#divAuthorise_CreditNote primary
    slot #tdSale_CreditNote_Date
    label "Credit note date*"
    button #divNewLine_CreditNote primary
    button "Copy from restock / invoices"#divCopyLines_CreditNote
    button "View in Xero"#divXero_CreditNote (hidden)
    slot #divCreditNoteLines
    button "Add more items"#Sale_CreditNote_AddLinesRecordLink primary (hidden)
    heading "Additional charges and services"
    button #divNewAdditionalCostLine_CreditNote primary
    button "Copy"#divCopyAdditionalCostLines_CreditNote
    slot #divCreditNoteAdditionalChargesLines
    button "Add more items"#Sale_CreditNote_AddAdditionalChargesLinesRecordLink primary (hidden)
    textarea#tdSale_Index_CreditNoteMemo placeholder "Write your note here..."
    label "Credit note memo" for #Sale_Index_QuoteMemo
    table: Credit note lines | Additional charges | Total
    button "Refund"#divNewPayment_CreditNote primary
    button "Customer credit"#divNewPayment_CreditNote_Credit
    button "Cin7 Core refunds"#divNewPayment_CreditNote_PaymentGateway_Refund
    button "Cin7 Pay refunds"#divNewPayment_CreditNote_Cin7Pay_Refund
    slot #divCreditNotePayments
    button "Refund"#Sale_CreditNote_AddPaymentLinesRecordLink primary (hidden)
    button "Customer credit"#Sale_CreditNote_AddPaymentCreditLinesRecordLink primary (hidden)
    text "Balance due"#Sale_CreditNote_BalanceHeader
    slot #Sale_CreditNote_Balance
    block #Sale_Invoice_BalanceDueText
      text "Balance due"#Sale_CreditNote_BalanceHeaderTenant
      slot #Sale_CreditNote_BalanceTenant
  block #divRestock (hidden)
    heading "Restock"
    button "Undo"#divUndo_Restock
    button "Void credit note and restock"#divVoid_Restock
    button "Authorize"#divAuthorise_Restock primary
    button "Copy from credit note / fulfillment"#divCopy_Restock
    slot #divRestockLines
  block #divAdditionalCOGS (hidden)
    heading "Manual journals"
    button "Undo journals"#divNew_UndoManualJournals
    button "Authorize"#divAuthorise_AdditionalCOGS primary
    button #divNew_AdditionalCOGS primary
    slot #divAdditionalTransactionsContainer
    button "Add more items"#Sale_AdditionalCOGS_AddLineLink primary (hidden)
    heading "NOTE"
  block #divRelatedOrders (hidden)
    heading "Related orders"
    button "Refresh"#btnRefreshRelatedOrders
    slot #divRelatedOrdersDetails
  block #divHistory (hidden)
    heading "Logs and attributes"
    block #Sale_divAttributeSet (hidden)
      heading "Additional attributes"
      block #Sale_liCustomField1
        slot #Sale_CustomField1
        label "Attribute 1"
      block #Sale_liCustomField2
        slot #Sale_CustomField2
        label "Attribute 2"
      block #Sale_liCustomField3
        slot #Sale_CustomField3
        label "Attribute 3"
      block #Sale_liCustomField4
        slot #Sale_CustomField4
        label "Attribute 4"
      block #Sale_liCustomField5
        slot #Sale_CustomField5
        label "Attribute 5"
      block #Sale_liCustomField6
        slot #Sale_CustomField6
        label "Attribute 6"
      block #Sale_liCustomField7
        slot #Sale_CustomField7
        label "Attribute 7"
      block #Sale_liCustomField8
        slot #Sale_CustomField8
        label "Attribute 8"
      block #Sale_liCustomField9
        slot #Sale_CustomField9
        label "Attribute 9"
      block #Sale_liCustomField10
        slot #Sale_CustomField10
        label "Attribute 10"
    heading "Activity log"
    slot #divHistoryLines
    heading "Workflow activity log"
    slot #divWorkflowHistoryLines
  block #divAttachments (hidden)
    heading "Attachments"
    block #divAttachmentUpload
      block #divUploadContainer
        block #preview-template (hidden)
        slot #iUpload (hidden)
        form#frmUpload
          heading "Drop files here or click to upload."
      block #divUploadImpossible
    button "Attach from Google Drive" primary
    slot #divAttachmentList
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
  slot #divPrint
  form#frmClone
  slot #ifrmDownloadFile (hidden)
  form#[object HTMLInputElement]
  modal#Sale_NewCustomer_Content medium
    heading "New customer"
    button "×"
    input text#tdSale_NewCustomer_Name placeholder "Enter a customer name"
    label "Name"
    slot #tdSale_NewCustomer_Parent
    label "Parent"
    select#tdSale_NewCustomer_PaymentTerm
    label "Payment term"
    select#tdSale_NewCustomer_SaleAccount
    label "Sale account"
    select#tdSale_NewCustomer_DefaultSalesRepresentative
    label "Sales representative"
    slot #tdSale_NewCustomer_DefaultLocation
    label "Default location"
    input text#tdSale_NewCustomer_Discount placeholder "Enter a customer discount"
    label "Discount"
    slot #tdSale_NewCustomer_IsLegalEntity
    label "Legal entity" for #chkSale_NewCustomer_IsLegalEntity
    input text#tdSale_NewCustomer_CustomerName placeholder "Enter a display name"
    label "Display name"
    slot #tdSale_NewCustomer_BillParent
    label "Bill parent" for #chkSale_NewCustomer_BillParent
    slot #tdSale_NewCustomer_Currency
    label "Currency"
    select#tdSale_NewCustomer_AccountPayable
    label "Account receivable"
    block #divCustomerTaxRule
      select#tdSale_NewCustomer_TaxRule
      label "Tax rule"
    select#tdSale_NewCustomer_DefaultCarrier
    label "Default carrier"
    block #divCustomerTaxNumber
      input text#tdSale_NewCustomer_TaxNumber placeholder "Enter a tax number"
      label "Tax number"
    select#tdSale_NewCustomer_SalePriceTier
    label "Sale price tier"
    textarea#tdSale_NewCustomer_Comments placeholder "Enter comments"
    label "Comments"
    button "Save" primary
    button "Close"
  modal#Sale_NewTenantContact_Content medium
    heading "Add a sales representative"
    button "×"
    input text#tdSale_NewTenantContact_Name
    label "Name" for #tdSale_NewTenantContact_Name
    input text#tdSale_NewTenantContact_Phone
    label "Phone" for #tdSale_NewTenantContact_Phone
    input text#tdSale_NewTenantContact_Fax
    label "Fax" for #tdSale_NewTenantContact_Fax
    input text#tdSale_NewTenantContact_Email
    label "Email" for #tdSale_NewTenantContact_Email
    input text#tdSale_NewTenantContact_Website
    label "Website" for #tdSale_NewTenantContact_Website
    textarea#tdSale_NewTenantContact_Comment
    label "Comments" for #tdSale_NewTenantContact_Comment
    button "Save" primary
    button "Close"
  modal#Sale_NewContact_Content medium
    heading "ADD CUSTOMER CONTACT"
    button "×"
    input text#tdSale_NewContact_Name
    label "Name"
    input text#tdSale_NewContact_JobTitle
    label "Job title"
    input text#tdSale_NewContact_Phone
    label "Phone"
    input text#tdSale_NewContact_MobilePhone
    label "Mobile phone"
    input text#tdSale_NewContact_Fax
    label "Fax"
    input text#tdSale_NewContact_Email
    label "Email"
    input text#tdSale_NewContact_Website
    label "Website"
    input checkbox#tdSale_NewContact_IsDefault
    label "Default" for #tdSale_NewContact_IsDefault
    textarea#tdSale_NewContact_Comment
    label "Comments"
    button "Save" primary
    button "Close"
  modal#Sale_NewDeposit_Content small
    heading #Sale_NewDeposit_Title
    button "×"
    slot #Sale_NewDeposit_Account
    label "Deposit account"
    block #Sale_NewDeposit_BankAcocuntBlock
      slot #Sale_NewDeposit_BankAccount
      label "Account"
    input text#Sale_NewDeposit_Reference
    label "Reference"
    slot #Sale_NewDeposit_DatePaid
    label "Date paid"
    input text#Sale_NewDeposit_Amount
    label "Amount"
    block #liSale_NewDeposit_ConversionRate
      input text#Sale_NewDeposit_ConversionRate
      button #Sale_NewDeposit_ConversionRate_GetRate
      label "Conversion rate"
    block #Sale_NewDeposit_BaseAmountBlock (hidden)
      slot #Sale_NewDeposit_BaseAmountLabel
      slot #Sale_NewDeposit_BaseAmount
    button "Create" primary
    button "Close"
  modal#TenantPaymentTerm_NewTerm_Content small
    heading "Add a payment term"
    button "×"
    input text#tdTenantPaymentTerm_NewTerm_Name
    label "Name" for #tdTenantPaymentTerm_NewTerm_Name
    select#tdTenantPaymentTerm_NewTerm_Method: Number of days | Day of next month | Last day of next month | Days since the end of the month
    label "Method" for #tdTenantPaymentTerm_NewTerm_Method
    input text#tdTenantPaymentTerm_NewTerm_Days
    label "Days" for #tdTenantPaymentTerm_NewTerm_Days
    button "Save" primary
    button "Close"
  modal#Sale_NewAddress_Content medium
    heading "ADD CUSTOMER ADDRESS"
    button "×"
    slot #cmbAddress
    button  primary
    label ""
    input text#tdSale_NewAddress_Line1
    label "Line 1"
    input text#tdSale_NewAddress_Line2
    label "Line 2"
    input text#tdSale_NewAddress_CitySuburb
    label "City / suburb"
    input text#tdSale_NewAddress_StateProvince
    label "State / province"
    input text#tdSale_NewAddress_ZipPostCode
    label "ZIP / postcode"
    select#tdSale_NewAddress_Country
    label "Country"
    block #SaleCommon_NewAddress_AvalaraTaxExemptionCode (hidden)
      slot #cmbAvalaraTaxExemptionCode_NewAddress
      label "Tax exemption reason"
    select#tdSale_NewAddress_Type: Billing | Business | Shipping
    label "Type"
    input checkbox#tdSale_NewAddress_DefaultForType
    label "Default for type" for #tdSale_NewAddress_DefaultForType
    button "Save" primary
    button "Close"
  modal#Sale_EditAddress_Content medium
    heading "Edit shipping address"
    button "×"
    button "Search customer address"#divShowAddressSearch
    button "Hide customer search"#divHideAddressSearch (hidden)
    block #divSale_Index_Ship_Another_Customer (hidden)
      slot #Sale_Index_Ship_Another_Customer
      label "Customer"
      slot #Sale_Index_SippingAnotherAddressLine1
      label "Address"
    input text#tdSale_EditAddress_Line1
    label "Line 1"
    input text#tdSale_EditAddress_Line2
    label "Line 2"
    input text#tdSale_EditAddress_CitySuburb
    label "City / suburb"
    input text#tdSale_EditAddress_ZipPostCode
    label "ZIP / postcode"
    input text#tdSale_EditAddress_StateProvince
    label "State / province"
    select#tdSale_EditAddress_Country
    label "Country"
    button "OK" primary
    button "Close"
  modal#Sale_NewCarrier_Content small
    heading "ADD CARRIER"
    button "×"
    input text#tdSale_NewCarrier_Description
    label "Carrier"
    button "Save" primary
    button "Close"
  modal#Sale_LookupCourierDialog_Content small
    heading "Carrier / service lookup"
    button "×"
    slot #divLookupCourierDialogGrid
    button "OK" primary
    button "Close"
  modal#Sale_SelectShippingRate_Content medium
    heading "Please select a shipping option"
    button "×"
    slot #divShippingOptionsGrid
    button "OK" primary
    button "Close"
  modal#Sale_NewProduct_Content medium
    heading "Add a new product"
    button "×"
    input text#Sale_NewProduct_ProductCode placeholder "Enter a product SKU"
    label "SKU"
    input text#Sale_NewProduct_Name placeholder "Enter a product name"
    label "Name"
    select#Sale_NewProduct_Type
    label "Type"
    select#Sale_NewProduct_Category
    label "Category"
    select#Sale_NewProduct_PurchaseTaxRule
    label "Purchase tax rule"
    slot #Sale_NewProduct_SaleTaxRule
    label "Sale tax rule"
    block #trSupplier
      slot #tdSale_NewProduct_Supplier
      label "Supplier"
    block #trPurchasePrice
      input text#Sale_NewProduct_PurchasePrice
      label "Purchase price"
    select#Sale_NewProduct_UnitOfMeasure
    label "Unit of measure"
    block #trCostingMethod
      select#Sale_NewProduct_CostingMethod
      label "Costing method"
    block #trExpenseAccount
      select#Sale_NewProduct_ExpenseAccount
      label "Expense account"
    block #trMinimumBeforeReorder
      input text#Sale_NewProduct_MinimumBeforeReorder placeholder "Enter a minimum before reorder."
      label "Minimum before reorder"
    block #trReorderQuantity
      input text#Sale_NewProduct_ReorderQuantity placeholder "Enter reorder quantity"
      label "Reorder quantity"
    input text#Sale_NewProduct_Barcode placeholder "Enter a barcode"
    label "Barcode"
    block #trStockLocator
      input text#Sale_NewProduct_StockLocator placeholder "Enter a stock locator"
      label "Stock locator"
    block #trDropShipMode
      select#Sale_NewProduct_DropShipMode
      label "Drop ship"
    select#Sale_NewProduct_ProductAttributeSet
    label "Attribute set"
    slot #divAdditionalAttributes_NewProduct
    block #AdditionalAttributes_FieldTemplate (hidden)
      slot #{CustomField}
      label "" for #{CustomField}
    button "Save" primary
    button "Close"
  modal#Sale_NewExtShippingLine_Content small
    heading "Choose a box for external fulfillment"
    button "×"
    select#tdSale_NewExtShippingLine_Box
    label "Box" for #Sale_NewTerm_Name
    button "Add" primary
    button "Close"
  modal#divScanDialog small
    heading "Scanning"
    button "×"
    tabs: Automatic #AutomaticMode_tab | Manual #ManualMode_tab | Inventory #InventoryMode_tab
    block #divScanLocation
      slot #tdScanLocation
      label "Location to pick from" for #cmbScanLocation
    block #scanDesc
    block #scanBar
      block #dScan
        slot #spScan
    slot #ScanValidationContainer (hidden)
    block #liScanPackBoxAutomatic (hidden)
      slot #tdScanPackBoxAutomatic
      label "Box #" for #txtScanPackBoxInventory
    input text#txtScanFocus
    block #divScanInfo (hidden)
      heading "Found product:"
      slot #divScanProductSelection (hidden)
      block #liScanPackBox (hidden)
        label "Box #:"
        slot #tdScanPackBox
      label "SKU:"
      block #tdScanProductCode
      label "Name:"
      block #tdScanName
      label "Barcode:"
      block #tdScanBarcode
      block #liScanBatchSN (hidden)
        label "Batch/serial number:"
        slot #tdScanBatchSN
      block #liScanExpiryDate (hidden)
        label "Expiry date:"
        slot #tdScanExpiryDate
      block #liScanQuantity (hidden)
        label "Quantity:"
        slot #tdScanQuantity
    block #ScanInventoryModeContainer (hidden)
      slot #divInventoryModeBarcodes
      label "Barcodes"
      block #liScanPackBoxInventory (hidden)
        slot #tdScanPackBoxInventory
        label "Box #"
    block #ScanInventoryModeControls (hidden)
      button "Save"#liScanSaveInventory primary
      button "Close"
    block #ScanManualModeControls (hidden)
      button "Save"#liScanSave primary (hidden)
      button "Close"
    block #divScanAutoActions
      button "Close"
  modal#divUploadQuoteDialog medium
    heading "Upload a quote"
    button "×"
    heading "1. Download this quote"
    heading "2. Add new and modify existing products in the file."
    heading "3. Upload"
    block #UploadQuoteLinesExceptionsContainer (hidden)
      slot #UploadSaleQuoteLinesExceptionsGrid
    block #QuoteDropContainer
      heading "Drop files here or click to upload."
    slot #ifrmDownloadQuote (hidden)
    form#frmDownloadQuote
    button "Close"
  modal#divUploadOrderDialog medium
    heading "Upload an order"
    button "×"
    heading "1. Download this sale order"
    heading "2. Add new and modify existing products in the file."
    heading "3. Upload"
    block #UploadSOLinesExceptionsContainer (hidden)
      slot #UploadSaleOrderLinesExceptionsGrid
    form#frmUploadOrder
      block #OrderDropContainer
        heading "Drop files here or click to upload."
    slot #ifrmDownloadOrder (hidden)
    form#frmDownloadOrder
    slot #ifrmUploadOrder (hidden)
    button "Close"
  modal#customizationDialog large
    heading "Customization for product:"
    button "×"
    block #customizationContainer
      button "➜"
      button "Set to default"
      button "➜"
      button "Set to default"
      input text#searchFiled placeholder "Type to search..."
      button "Search"
      button 
      input number#quantity
      button 
      button "Reset to default"
      slot #totalAmount
      button "Confirm order" (hidden)
      button 
      button "➜"
      button "Clear selected"
      label "Custom element text" for #artText
      input text#artText placeholder "Type custom element text"
      text "For example your initials. Maximum 64 characters including punctuation."
      label "Choose file" for #artFile + file #artFile
      text "Choose the image that you want to apply. Size should be lesser than 16MB."
      button "Confirm changes"
    block #zoomPopup (hidden)
    button "Save"#btnSaveCustomization primary
    button "Close"
  modal#selectedOptionsDialog small
    heading "Selected options"
    button "×"
    button "Customize"#btnCustomize primary
    button "Close"
  modal#dlgFamilyMatrix medium
    heading "Add a product family"
    button "×"
    slot #FamilyMatrix_cmbFamily
    label "Product family"
    input checkbox#FamilyMatrix_cbOnlyAvailable
    label "Sell only available variations" for #FamilyMatrix_cbOnlyAvailable_InputId
    slot #FamilyMatrix_divMessage (hidden)
    block #FamilyMatrix_divOptions (hidden)
      tabs: Matrix | List
      tab pane#FamilyMatrix_divFamilyMatrixTab
        block #FamilyMatrix_divBaseOptionContainer (hidden)
          slot #FamilyMatrix_cmbBaseOption
          label "Select base option:"
          slot #FamilyMatrix_cmbBaseOptionValue
          label "and its value:"
        slot #FamilyMatrix_divMatrixContainer
      tab pane#FamilyMatrix_divFamilyListTab
        slot #FamilyMatrix_divListContainer
    button "Add products"#FamilyMatrix_btnAdd primary
    button "Close"#FamilyMatrix_btnClose
  modal#saleGiftCardDialog small
    heading "Sale gift card"
    button "×"
    input text#newSaleGiftCardCode
    label "Gift card code" for #newSaleGiftCardCode
    button "Generate" primary
    block #newGiftCardExpirationSection
      slot #dtNewSaleGiftCardExpirationDate
      label "Gift card expiration date" for #dtNewSaleGiftCardExpirationDate
    input text#newSaleGiftCardAmount
    label "Gift card price" for #newSaleGiftCardAmount
    button "Save" primary
    button "Cancel"
  modal#payGiftCardDialog small
    heading "Pay with a gift card"
    button "×"
    input text#newPayGiftCardCode
    label "Gift card code" for #newPayGiftCardCode
    button "Check gift card" primary
    input text#giftCardCurrentBalance
    label "Balance" for #giftCardCurrentBalance
    input text#newPayGiftCardAmount
    label "Amount" for #newPayGiftCardAmount
    button "Save"#applyGiftCardPayment primary
    button "Cancel"
  modal#PresetModal small
    heading "Name your pre-set"
    button "×"
    input text#PresetModal_Name
    label "Pre-set name"
    button "Save" primary
    button "Close"
block #Sale_ShippingService_Labeling (hidden)
  block #Sale_ShippingService_Content
    block #Sale_ShippingService_title
    button "Generate label"#Sale_ShipLabel_GenerateAction primary
    button "Cancel"#Sale_ShipLabel_CancelAction
    slot #ifrmDownloadLabel (hidden)
    form#frmDownloadLabel
    slot #Sale_ShippingService_ContentDynamic
    button "Generate label"#Sale_ShipLabel_GenerateAction2 primary
    button "Cancel"#Sale_ShipLabel_CancelAction2
block #Sale_NewAllocation (hidden)
  block #divHeaderCustomerCredit
    heading "Allocate customer credit as payment"
  block #divHeaderCreditNote
    heading "Allocate credit note"
  button "Add and save"#Sale_NewAllocation_SaveAction primary
  button "Cancel"#Sale_NewAllocation_CancelAction
  block #divExistingCustomerCredit
    heading "Select existing customer credit(s)"
    slot #Sale_NewAllocation_Credits
  block #divExistingCreditNote
    heading "Select existing credit note(s)"
    slot #Sale_NewAllocation_CreditNotes
  heading "Allocation(s) that will be created"
  slot #Sale_NewAllocation_Allocations
  table
  button "Add and save"#Sale_NewAllocation_SaveAction2 primary
  button "Cancel"#Sale_NewAllocation_CancelAction2
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
modal#AlternativeProductsModal large
  heading "Alternative products"
  button "×"
  slot #AlternativeProductsModal_Grid
  button "Close"
block #Sale_ShippingInstructions (hidden)
  heading "Please provide shipping instructions"
  button "OK"#Sale_ShippingInstructions_SaveAction primary
  button "Cancel"#Sale_ShippingInstructions_CancelAction
  slot #Sale_ShippingInstructions_ContentDynamic
  slot #Sale_ShippingInstructionWarning
block #Sale_PackageDetails (hidden)
  heading "Please select your packages"
  button "OK"#Sale_PackageDetails_SaveAction primary
  button "Cancel"#Sale_PackageDetails_CancelAction
  slot #package-select
  slot #Sale_PackageDetails_ContentDynamic
modal#divCOGSAccDims small
  heading "Accounting dimensions"
  button "×"
  button "Save"#btnSaveCOGSAccDims primary
  button "Close"
slot #CountrySpecificScript
```

### `/SaleList`: Sales

Frame: `task-upload-frame`.

```text
link "Home"
block #viewContainer
  link "General"#vGeneral
  link "Accounting"#vAccounting
  link "Fulfillment"#vFulfilment
  link "Consolidated transactions"#vTransactions (hidden)
block #divList
  block #bulkActionsNoteSuccess (hidden)
    text "×"
  block #bulkActionsNoteWarning (hidden)
    text "×"
  block #bulkActionsNoteError (hidden)
    text "×"
  button #divNew primary
  input text#divSearch placeholder "Type text to search"
  button "Search" primary
  block #divFilterRequiredBy (hidden)
    label "Required by" for #dtShipmentRequiredByDate
    slot #Sale_Index_ShipmentRequiredByDate
  block #divFilterGeneralContainer (hidden)
    select#divFilterGeneral
  block #divFilterAccountingContainer (hidden)
    select#divFilterAccounting
  block #divFilterFulfilmentContainer (hidden)
    select#divFilterFulfilment
  block #divFilterTransactionsContainer (hidden)
    select#divFilterTransactions
  block #divFinanceInvoices (hidden)
    button "Finance invoices"#financeInvoiceAction
  button "Refresh"#divRefresh
  button "Import"#btnSalesImport ▾
  link "Import CSV file"
  button "Export"#btnExportTransactions (hidden)
  block #GridOptions_GeneralContainer
    button #Grid_gridName_Options1
  block #GridOptions_AccountingContainer
    button #Grid_gridName_Options2
  block #GridOptions_FulfilmentContainer
    button #Grid_gridName_Options3
  block #GridOptions_TransactionsContainer
    button #btnTransactionsGridSettings
  block #divBulkActions
    slot #lSelectedCounter
    button "Undo"#undoAction
    button "Fill and authorize"#authoriseAction ▾
    slot #authoriseActionDropdownList
    button "Print"#printAction ▾
    slot #printDropdownList
    button "Email"#emailAction ▾
    slot #emailDropdownList
    button "Export" ▾
    link "Export account receivable"
    link "Export 3PL shipment list"
    link "Export to CSV format"
    block #fulfilmentSchedulePickActions (hidden)
      button "Picking" ▾
      link "Schedule for picking"
      link "Clear pick schedule"
      link "Set picker"
    button "Void"#voidAction
  slot #SaleList_Index_GeneralContainer (hidden)
  slot #SaleList_Index_AccountingContainer (hidden)
  slot #SaleList_Index_FulfilmentContainer (hidden)
  slot #SaleList_Index_TransactionsContainer (hidden)
  form#frmPrintList
  form#frmExportAccount
  form#frmExportCsv
  form#frmExport3Pl
  form#frmExportConsolidatedTransactions
modal#divCombinedPrintDialog small
  heading "Print"
  button "×"
  select#selectPrintSort: SKU | Product name | Location | Box
  label "Sort data by"
  button "Print" primary
  button "Close"
modal#dlgReCaptchaModal small
  heading "CAPTCHA verification"#dlgReCaptchaModalCaption
  button "×"
  block #emailReCaptcha
  button "Continue"#dlgReCaptchaModal_continue primary
  button "Close"
modal#selectSalePickerDialog small
  heading "Select sale picker"
  button "×"
  label "Picker" for #cmbSalePicker_Bulk
  slot #SalePicker_Bulk
  button "Continue" primary
  button "Cancel"
```

### `/SaleMultiple`: Advanced sale

Frame: `ifrmDownloadFile`.

```text
slot #breadcrumb
button "Save"#saveAction2 primary
button "Back to list"
block #divMainContent
  block #ControlBlock
    slot #formCaption2
    text "( )"#SaleMult_Index_Currency_block
    block #SaleMult_Index_Status
    slot #ExchangeParentOrderSaleNumber
  block #FulfillmentsBlock
    block #taskFulfillmentRibbon
      text "0"#FulfillmentRemainingValue
    slot #FulfillmentPlaceHolder
    block #divSaleMult_FulFillment_Add
      button "Fulfillment"#SaleMult_Fulfillment_AddLink primary
  block #InvoicesBlock
    block #taskInvoiceRibbon
      text "0"#InvoiceRemainingValue
    slot #InvoicesPlaceHolder
    block #divSaleMult_Invoice_Add_Block
      button "Invoice"#SaleMult_Invoice_AddLink primary
  block #ExciseTaxBlock
    slot #ExciseTaxPlaceHolder
  block #PaymentsBlock
    block #taskPaymentRibbon
      text "paid"#PaidTotalValueLabel
      text "2"#PaidTotalValue
    slot #PaymentsPlaceHolder
  block #CreditNotesBlock
    slot #CreditNotePlaceHolder
    block #divSaleMult_CrNote_Add_Block
      button "Credit note & restock"#SaleMult_CreditNote_AddLink primary
  block #ExchangesBlock (hidden)
    slot #ExchangesPlaceHolder
  block #AttachmentsBlock
    slot #divAttachmentList
    slot #uploadProgress hiddenContent
    block #divUploadContainer (hidden)
      form#frm-upload
        block #preview-template (hidden)
        input file name=file
        button "Upload"
    button "Attach a file"#btnAttachFile
    button "Attach from Google Drive" primary
  block #OthersBlock
  block #divSaleHeader
    slot #SaleMult_Index_Status_Header
    heading 
    block #divArchiveStatic (hidden)
    block #divApproveStatic (hidden)
    button "Save as preset"#btnSavePreset primary
    select#cmbPresetList
    button "Delete preset"#btnDeletePreset
    block #divAdvancedSaleTask (hidden)
      button 
      button  primary
      button "Workflow"
      button 
      button "Calendar"
    button #taskHeaderCollapse
    block #divTaskHeader
      heading "Customer details"
      slot #SaleMult_Index_Customer
      label "Customer"
      slot #SaleMult_Index_Contact
      label "Contact"
      slot #SaleMult_Index_Phone
      label "Phone"
      slot #SaleMult_Index_Email
      label "Email"
      slot #SaleMult_Index_CustomerReference
      label "Reference"
      block #SaleMult_Index_PurchaseOrderReference_FormControl
        slot #SaleMult_Index_PurchaseOrderReference
        label "Purchase order reference"
      slot #SaleMult_Index_BillingAddressLine1
      label "Billing address line 1"
      slot #SaleMult_Index_BillingAddressLine2
      label "Billing address line 2"
      block #SaleMult_Index_ChannelOrderType_FormControl
        slot #SaleMult_Index_ChannelOrderType
        label "Channel order type" for #SaleMult_Index_ChannelOrderType
      slot #SaleMult_Index_PriceTier
      label "Price tier*"
      heading "Accounting details"
      slot #SaleMult_Index_Terms
      label "Terms"
      slot #SaleMult_Index_SalesRepresentative
      label "Sales rep*"
      slot #tdSaleMult_Index_DefaultAccount
      label "Account*"
      slot #SaleMult_Index_Tax
      label "Tax rule*"
      slot #SaleMult_Index_Tax_Inclusive
      label "Tax inclusive" for #chkSaleMult_Index_Tax_Inclusive
      slot #Sale_Index_SkipQuote
      label "Skip quote" for #chkSkipQuote
      heading "Shipping details"
      slot #SaleMult_Index_Location
      label "Location*"
      slot #SaleMult_Index_Date
      label "Date*"
      slot #SaleMult_Index_ShipmentRequiredByDate
      label "Ship by"
      slot #SaleMult_Index_ShipToCompany
      label "Ship to company"
      slot #SaleMult_Index_ShipToContact
      label "Ship to contact"
      slot #SaleMult_Index_ShipToOther
      label "Ship to different company" for #chkHeaderShipToOther
      button #SaleMult_Index_EditOtherAddress primary
      block #SaleMult_Index_CustomerAddress
        slot #SaleMult_Index_SippingAddressLine1
        label "Shipping address line 1"
        slot #SaleMult_Index_SippingAddressLine2
        label "Shipping address line 2"
      block #SaleCommon_AvalaraTaxExemptionCode (hidden)
        slot #cmbAvalaraTaxExemptionCode
        label "Tax exemption reason"
      block #SaleMult_Index_RecepientAddress (hidden)
        textarea#tdSaleMult_Index_ShipToAddress placeholder "Please enter the address..."
      textarea#SaleMult_Index_ShippingNotes placeholder "Shipping notes..."
      label "Shipping notes"
      block #SaleMult_Index_ShipServiceGroup
        input text#SaleMult_Index_ShippingCarrierService
        label "Carrier / service"
        button #SaleMult_Index_ShippingCarrierServiceLookup
      heading "Comments"
      block #divNote
        textarea#divStickyNote placeholder "Write your note here..."
    block #divNone (hidden)
      heading "You do not have permission to view the sale order."
  button "Show sidebar"#showSidebarButton primary
  block #divQuote (hidden)
    slot #SaleMult_Index_QuoteStatus
    heading "Sale quote"
    button "Email"#btnQuoteEmailAction ▾
    menu#quoteEmailMenu: 
    button "Print"#btnQuotePrintAction ▾
    menu#quotePrintMenu: 
    button "To order"#divAuthorise_Quote_GoToOrder primary (hidden)
    button "Authorize"#divAuthorise_Quote primary
    button "Approve"#btApprove primary (hidden)
    button "Reject"#btReject (hidden)
    button "Review"#btReview (hidden)
    button "Archive"#divArchive
    slot #vSaleQuoteLinesDiscountDescription (hidden)
    button #divNewLines_Quote primary
    button "Family"#divAddBulk_Quote
    button "Scan"#divScan_Quote
    block #divSaleMult_Index_QuoteCurrencyConversionRateBlock (hidden)
      input text#SaleMult_Quote_ConversionRate
      button #SaleMult_Quote_ConversionRate_GetRate
      label "" for #SaleMult_Quote_ConversionRate
    button "Apply coupon"#divCoupon_Quote
    button "Apply discounts"#divDiscounts_Quote
    slot #divQuoteLines
    button "Add more items"#SaleMult_Quote_AddQuoteLinesRecordLink primary (hidden)
    button "Export"#divExport_Quote primary
    button "Import"#divImport_Quote primary
    heading "Additional charges and services"
    button #divNewAdditionalCostLine_Quote primary
    button "Get shipping rates"#divGetShippingRate_Quote
    slot #divQuoteAdditionalChargesLines
    button "Add more items"#SaleMult_Quote_AddAdditionalChargesLinesRecordLink primary (hidden)
    textarea#tdSaleMult_Index_QuoteMemo placeholder "Write your note here..."
    label "Quote memo"
    table: Quote lines | Additional charges | Total
    block #QuotePrepaymentBlock
      heading "Customer credit"
      button "Customer credit"#divNewPayment_Quote primary
      button "Cin7 Core Payments"#divNewPayment_Quote_PaymentGateway
      button "Cin7 Pay Payments"#divNewPayment_Quote_Cin7Pay
      slot #divDeposits
      button "Add more items"#SaleMult_Quote_AddDepositsRecordLink primary (hidden)
  block #divOrder (hidden)
    slot #SaleMult_Index_OrderStatus
    heading "Sale order"
    slot #SaleMult_Index_OrderNumber
    block #divSaleMult_Index_OrderCurrencyConversionRateBlock (hidden)
      slot #SaleMult_Order_ConversionRate
      label ""
    block #divCreatePurchaseNote
      button "Create purchase order" primary
      link "For backordered"
      link "For entire sale"
    block #divCreatePurchaseOnStock
      button "Create purchase order" primary
    block #OrderReports
      button "Email"#tabOrderEmailAction ▾
      button "Print"#tabOrderPrintAction ▾
    button "Apply coupon"#divCoupon_Order
    button "Apply discounts"#divDiscounts_Order
    button "Authorize"#divAuthorise_Order primary
    link "Allocate stock"
    link "Don't allocate stock"
    slot #vSaleOrderLinesDiscountDescription (hidden)
    heading "Products"
    button #divNewLines_Order primary
    button "Copy from quote"#divCopy_Order
    button "Family"#divAddBulk_Order
    button "Scan"#divScan_Order
    slot #SalePicker_Order
    label "Should be picked by" for #cmbSalePicker_Order
    slot #pickerItemsPlaceholder_Order (hidden)
    slot #divOrderLines
    button "Add more items"#Sale_Order_AddOrderLinesRecordLink primary (hidden)
    button "Export"#divExport_Order primary
    button "Import"#divImport_Order primary
    heading "Additional charges and services"
    button #divNewAdditionalCostLine_Order primary
    button "Gift card"#divNewGiftCard_Order
    button "Get shipping rates"#divGetShippingRate_Order
    slot #divOrderAdditionalChargesLines
    button "Add more items"#SaleMult_Order_AddAdditionalChargesLinesRecordLink primary (hidden)
    textarea#tdSaleMult_Index_OrderMemo placeholder "Write your notes here..."
    label "Order memo" for #tdSaleMult_Index_OrderMemo
    table: Order lines | Additional charges | Total
    block #OrderPrepaymentBlock
      heading "Customer credit"
      button "Customer credit"#divNewPayment_Order primary
      button "Cin7 Core Payments"#divNewPayment_Order_PaymentGateway
      button "Cin7 Pay Payments"#divNewPayment_Order_Cin7Pay
      slot #divMultOrderDeposits
      button "Add more items"#SaleMult_Order_AddDepositsRecordLink primary (hidden)
  block #divPick (hidden)
    slot #SaleMult_Index_PickStatus
    heading "Picking"
    label "For invoice(s)" for #SaleMult_Pick_SelectInvoice
    select#SaleMult_Pick_SelectInvoice multiple
    block #divPurchaseAdvancedTask_FulfilmentPick (hidden)
      button 
      button  primary
      button "Workflow"
      button 
      button "Calendar"
    block #PickReports
      button "Email"#tabPickEmailAction ▾
      button "Print"#tabPickPrintAction ▾
    button "Undo"#divUndo_Pick
    button "Authorize"#divAuthorise_Pick primary
    button "To pack"#divAuthorise_Pick_GoToPack primary (hidden)
    button #divNew_Pick primary
    button "Scan"#divScan_Pick
    button "Pick remaining"#divAuto_Pick
    button "Pick available"#divAuto_PickAvailable
    slot #tdSaleMult_Pick_ShipmentRequiredByDate
    label "Required by"
    slot #SalePicker_Pick
    label "Should be picked by" for #cmbSalePicker_Pick
    slot #pickerItemsPlaceholder_Pick (hidden)
    slot #divPickLines
    button "Add more items"#SaleMult_Pick_AddRecordLink primary (hidden)
  block #divPack (hidden)
    block #blockPackTab
      block #hasShippingPackHeader
        button "Pack"
        button "Shipping instructions"#subTabShippingInstructions
        button "Package details"#subTabPackageDetail
      block #hasNoShippingPackHeader
        slot #SaleMult_Index_PackStatus
        heading "Packing"
      block #divPurchaseAdvancedTask_FulfilmentPack (hidden)
        button 
        button  primary
        button "Workflow"
        button 
        button "Calendar"
      block #PackReports
        button "Email"#tabPackEmailAction ▾
        button "Print"#tabPackPrintAction ▾
      button "Undo"#divUndo_Pack
      button "Authorize"#divAuthorise_Pack primary
      button "To ship"#divAuthorise_Pack_GoToShip primary (hidden)
      button #divNew_Pack primary
      button "Scan"#divScan_Pack
      button "Copy from pick"#divCopyFromPick_Pack
      slot #divPackLines
      button "Add more items"#SaleMult_Pack_AddRecordLink primary (hidden)
    block #blockShippingInstructions (hidden)
      button "Pack"
      button "Shipping instructions"
      button "Package details"
      button "To package details" primary
      button "Enter shipping instructions"#btnEnterShippingInstructions
      slot #divShippingInstructions
    block #blockPackageDetails (hidden)
      button "Pack"
      button "Shipping instructions"
      button "Package details"
      button "Enter package details"#btnEnterPackageDetails
      slot #divPackageDetails
  block #divShip (hidden)
    slot #SaleMult_Ship_Status
    heading "Shipping"
    block #divPurchaseAdvancedTask_FulfilmentShip (hidden)
      button 
      button  primary
      button "Workflow"
      button 
      button "Calendar"
    block #ShipReports
      button "Email"#tabShipEmailAction ▾
      button "Print"#tabShipPrintAction ▾
    button "Undo"#divUndo_Ship
    button "Authorize"#divAuthorise_Ship primary
    heading "Shipping details"
    slot #tdSaleMult_Ship_ShipmentRequiredByDate
    label "Required by"
    slot #SaleMult_Ship_ShipToCompany
    label "Ship to company"
    slot #SaleMult_Ship_ShipToContact
    label "Ship to contact"
    textarea#SaleMult_Ship_ShippingNotes placeholder "Shipping notes..."
    label "Shipping notes"
    input checkbox#chkShipToOther
    label "Different company" for #chkShipToOther
    block #SaleMult_Ship_CustomerAddress
      slot #tdSaleMult_Ship_ShippingAddressLine1
      label "Address"
      input text#tdSaleMult_Ship_ShippingAddressLine2
      label "Address line 2" for #tdSaleMult_Ship_ShippingAddressLine2
    block #SaleMult_Ship_RecepientAddress (hidden)
      input text#tdSaleMult_Ship_ShipToCompanyContact placeholder "Please enter the shipping contact..."
      button #SaleMult_Ship_EditOtherAddress primary
      textarea#tdSaleMult_Ship_ShipToAddress placeholder "Please enter the address..."
    button #divNew_Ship primary
    block #controlCopyFromPack_Ship
      button "Auto fill"#divCopyFromPack_Ship ▾
    block #controlCopyFromPack2_Ship
      button "Copy from pack"#divCopyFromPack2_Ship
    button "Add a line for external fulfillment"#divNew_ShipExt
    button "Shipping manifest"#divDownloadShipManifest ▾ (hidden)
    button "Shipping label"#divDownloadShipLabel ▾ (hidden)
    button "Generate shipping label"#divGenerateShipLabel
    button "Confirm authorization"#divConfirmAuthorise_Ship
    button "Resend to ShipStation"#divResendToShipStation (hidden)
    slot #divShipLines
    button "Add more items"#SaleMult_Ship_AddRecordLink primary (hidden)
    block #FulfillmentBlock
      heading "Fulfillment orders"
      slot #divFulfillmentLines
  block #divInvoice (hidden)
    slot #tdSaleMult_Invoice_Status
    heading "Invoice"
    slot #tdSaleMult_Invoice_Number
    button "Undo"#divUndo_Invoice (hidden)
    block #InvoiceReports
      button "Email"#tabInvoiceEmailAction ▾
      button "Print"#tabInvoicePrintAction ▾
    button "View in Xero"#divXero_Invoice (hidden)
    button "Authorize"#divAuthorise_Invoice primary
    heading "Bill to"
    slot #Sale_Index_InvBillingAddressLine1
    label "Address"
    slot #Sale_Index_InvBillingAddressLine2
    label "Address line 2"
    heading "Invoice details"
    slot #tdSaleMult_Invoice_Date
    label "Invoice date*"
    slot #tdSaleMult_Invoice_DueDate
    label "Due date*"
    block #divSaleMult_Index_InvoiceCurrencyConversionRateBlock (hidden)
      slot #SaleMult_Index_InvoiceCurrencyConversionRate
      label ""
    block #SaleMult_Invoice_SelectFulfillmentBlock
      label "Fulfillment(s) #" for #SaleMult_Invoice_SelectFulfillment
      select#SaleMult_Invoice_SelectFulfillment multiple
    heading "Products"
    button #divNewLine_Invoice primary
    button "Invoice remaining"#btnCopy_Invoice
    button "Invoice remaining with charges"#btnCopyWithCharges_Invoice
    slot #divInvoiceLines
    button "Add more items"#SaleMult_Invoice_AddLinesRecordLink primary (hidden)
    heading "Additional charges and services"
    button #divNewAdditionalCostLine_Invoice primary
    button "Gift card"#divNewGiftCard_Invoice
    button "Get shipping rates"#divGetShippingRate_Invoice
    slot #divInvoiceAdditionalChargesLines
    button "Add more items"#SaleMult_Invoice_AddAdditionalChargesLinesRecordLink primary (hidden)
    textarea#tdSaleMult_Index_InvoiceMemo placeholder "Write your note here..."
    label "Invoice memo" for #SaleMult_Index_InvoiceMemo
    table: Invoice lines | Additional costs | Total
    block #divInvoicePaymentBlock (hidden)
      heading "Payments"
      block #divInvoicePaymentsButtonSet
        button "Payment"#divNewPayment_Invoice primary
        button "Use customer credit"#divNewAllocation_Invoice
        button "Allocate credit note"#divNewCreditNoteAllocation_Multi
        button "Use a gift card"#divNewPaymentGiftCard_Invoice
        button "Cin7 Core Payments"#divNewPayment_Invoice_PaymentGateway
        button "Cin7 Pay Payments"#divNewPayment_Invoice_Cin7Pay
      slot #divInvoicePayments
      button "Payment"#SaleMult_Invoice_AddPaymentLinesRecordLink primary (hidden)
      button "Use customer credit"#SaleMult_Invoice_AddPaymentAllocationsLink primary (hidden)
      text "Balance due"#SaleMult_Invoice_BalanceHeader
      slot #SaleMult_Invoice_Balance
      block #SaleMult_Invoice_BalanceDueText
        text "Balance due"#SaleMult_Invoice_BalanceHeaderTenant
        slot #SaleMult_Invoice_BalanceTenant
      block #InvoicePrepaymentBlock
        heading "Customer credit"
        button "Customer credit"#divNewCreditPayment_Invoice primary
        button "Cin7 Core Payments"#divNewCreditPayment_Invoice_PaymentGateway
        button "Cin7 Pay Payments"#divNewCreditPayment_Invoice_Cin7Pay
        slot #divMultInvoiceDeposits
        button "Add more items"#SaleMult_Invoice_AddDepositsRecordLink primary (hidden)
  block #divExciseTax (hidden)
    slot #tdSaleMult_ExciseTax_Status
    heading "Excise tax"
    slot #tdSaleMult_ExciseTax_Number
    block #divSaleMultTask_Invoice (hidden)
      button 
      button  primary
      button "Workflow"
      button 
      button "Calendar"
    button "Authorize"#divAuthorise_ExciseTax primary
    label "Reference no.*" for #Sale_ExciseTax_ExciseReferenceNo
    slot #tdSale_ExciseTax_ExciseReferenceNo
    label "Transfer license no." for #Sale_ExciseTax_TransferLicenseNo
    slot #tdSale_ExciseTax_TransferLicenseNo
    slot #tdSale_ExciseTax_Deductible
    label "Deductible" for #Sale_ExciseTax_Deductible
    slot #tdSale_ExciseTax_ExciseDate
    label "Excise tax effective date*" for #Sale_ExciseTax_ExciseDate
    slot #tdSale_ExciseTax_DateExciseTaxPaid
    label "Date of excise tax paid" for #Sale_ExciseTax_DateExciseTaxPaid
    slot #divExciseTaxLines
    table
  block #divCreditNote (hidden)
    slot #tdSaleMult_CreditNote_Status
    heading "Credit note"
    slot #tdSaleMult_CreditNote_Number
    block #divSaleMultTask_CreditNote (hidden)
      button 
      button  primary
      button "Workflow"
      button 
      button "Calendar"
    block #CrNoteReports
      button "Email"#tabCreditNoteEmailAction ▾
      button "Print"#tabCreditNotePrintAction ▾
    button "Authorize"#divAuthorise_CreditNote primary
    slot #tdSaleMult_CreditNote_Date
    label "Credit note date*"
    block #divSaleMult_Index_CreditNoteCurrencyConversionRateBlock
      label "" for #SaleMult_Index_CreditNoteCurrencyConversionRate
      input text#SaleMult_Index_CreditNoteCurrencyConversionRate
      button #SaleMult_Index_CreditNoteCurrencyConversionRate_GetRate
    block #SaleMult_CreditNote_SelectInvoiceBlock
      label "Credit note for" for #SaleMult_CreditNote_SelectInvoice
      select#SaleMult_CreditNote_SelectInvoice multiple
    heading "Products"
    button #divAddLine_CreditNote primary
    button "Copy from restock / invoices"#divCopyFromInvoices_CreditNote
    button "View in Xero"#divXero_CreditNote (hidden)
    slot #divCreditNoteLines
    button "Add more items"#SaleMult_CreditNote_AddLinesRecordLink primary (hidden)
    button #divNewAdditionalCostLine_CreditNote primary
    slot #divCreditNoteAdditionalChargesLines
    button "Add more items"#SaleMult_CreditNote_AddAdditionalChargesLinesRecordLink primary (hidden)
    textarea#tdSaleMult_Index_CreditNoteMemo placeholder "Write your notes here..."
    label "Credit note memo" for #SaleMult_Index_QuoteMemo
    table: Credit note lines | Additional costs | Total
    block #divCreditNoteRefundBlock
      heading "Refunds"
      button "Refund"#divNewPayment_CreditNote primary
      button "Customer credit"#divNewPayment_CreditNote_Credit
      button "Cin7 Core refunds"#divNewPayment_CreditNote_PaymentGateway_Refund
      button "Cin7 Pay refunds"#divNewPayment_CreditNote_Cin7Pay_Refund
      slot #divCreditNotePayments
      text "Balance due"#SaleMult_CreditNote_BalanceHeader
      slot #SaleMult_CreditNote_Balance
      block #SaleMult_Invoice_BalanceDueText
        text "Balance due"#SaleMult_CreditNote_BalanceHeaderTenant
        slot #SaleMult_CreditNote_BalanceTenant
  block #divRestock (hidden)
    slot #tdSaleMult_Restock_Status
    heading "Restock"
    block #divSaleMultTask_Restock (hidden)
      button 
      button  primary
      button "Workflow"
      button 
      button "Calendar"
    button "Authorize"#divAuthorise_Restock primary
    block #SaleMult_Restock_SelectInvoiceBlock
      label "Restock for" for #SaleMult_Restock_SelectInvoice
      select#SaleMult_Restock_SelectInvoice multiple
    button "Copy from credit note / fulfillment"#divCopy_Restock
    slot #divRestockLines
  block #divAdditionalCOGS (hidden)
    slot #SaleMult_Index_MJStatus
    heading "Manual journals"
    button "Authorize"#divAuthorise_AdditionalCOGS primary
    button "Undo journals"#divNew_UndoManualJournals (hidden)
    button #divNew_AdditionalCOGS primary
    slot #divAdditionalTransactionsContainer
    button "Add more items"#Sale_AdditionalCOGS_AddLineLink primary (hidden)
    heading "NOTE"
  block #divHistory (hidden)
    heading "Activity log"
    slot #divHistoryLines
  block #divWorkflowHistory (hidden)
    heading "Workflow activity log"
    slot #divWorkflowHistoryLines
  block #divAttributes (hidden)
    block #Sale_divAttributeSet (hidden)
      heading "Additional attributes"
      block #Sale_liCustomField1
        slot #Sale_CustomField1
        label "Attribute 1"
      block #Sale_liCustomField2
        slot #Sale_CustomField2
        label "Attribute 2"
      block #Sale_liCustomField3
        slot #Sale_CustomField3
        label "Attribute 3"
      block #Sale_liCustomField4
        slot #Sale_CustomField4
        label "Attribute 4"
      block #Sale_liCustomField5
        slot #Sale_CustomField5
        label "Attribute 5"
      block #Sale_liCustomField6
        slot #Sale_CustomField6
        label "Attribute 6"
      block #Sale_liCustomField7
        slot #Sale_CustomField7
        label "Attribute 7"
      block #Sale_liCustomField8
        slot #Sale_CustomField8
        label "Attribute 8"
      block #Sale_liCustomField9
        slot #Sale_CustomField9
        label "Attribute 9"
      block #Sale_liCustomField10
        slot #Sale_CustomField10
        label "Attribute 10"
  block #divRelatedOrders (hidden)
    heading "Related orders"
    button "Refresh"#btnRefreshRelatedOrders
    slot #divRelatedOrdersDetails
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
slot #divPrint (hidden)
form#frmClone
slot #ifrmDownloadFile (hidden)
form#[object HTMLInputElement]
modal#dlgFamilyMatrix medium
  heading "Add a product family"
  button "×"
  slot #FamilyMatrix_cmbFamily
  label "Product family"
  input checkbox#FamilyMatrix_cbOnlyAvailable
  label "Sell only available variations" for #FamilyMatrix_cbOnlyAvailable_InputId
  slot #FamilyMatrix_divMessage (hidden)
  block #FamilyMatrix_divOptions (hidden)
    tabs: Matrix | List
    tab pane#FamilyMatrix_divFamilyMatrixTab
      block #FamilyMatrix_divBaseOptionContainer (hidden)
        slot #FamilyMatrix_cmbBaseOption
        label "Select base option:"
        slot #FamilyMatrix_cmbBaseOptionValue
        label "and its value:"
      slot #FamilyMatrix_divMatrixContainer
    tab pane#FamilyMatrix_divFamilyListTab
      slot #FamilyMatrix_divListContainer
  button "Add products"#FamilyMatrix_btnAdd primary
  button "Close"#FamilyMatrix_btnClose
modal#divScanDialog small
  heading "Scanning"
  button "×"
  tabs: Automatic #AutomaticMode_tab | Manual #ManualMode_tab | Inventory #InventoryMode_tab
  block #divScanLocation
    slot #tdScanLocation
    label "Location to pick from" for #cmbScanLocation
  block #scanDesc
  block #scanBar
    block #dScan
      slot #spScan
  slot #ScanValidationContainer (hidden)
  input text#txtScanFocus
  block #liScanPackBoxAutomatic (hidden)
    slot #tdScanPackBoxAutomatic
    label "Box #" for #txtScanPackBoxInventory
  block #divScanInfo (hidden)
    heading "Found product:"
    slot #divScanProductSelection (hidden)
    block #liScanPackBox (hidden)
      label "Box #:"
      slot #tdScanPackBox
    label "SKU:"
    block #tdScanProductCode
    label "Name:"
    block #tdScanName
    label "Barcode:"
    block #tdScanBarcode
    block #liScanBatchSN (hidden)
      label "Batch/serial number:"
      slot #tdScanBatchSN
    block #liScanExpiryDate (hidden)
      label "Expiry date:"
      slot #tdScanExpiryDate
    block #liScanQuantity (hidden)
      label "Quantity:"
      slot #tdScanQuantity
  block #ScanInventoryModeContainer (hidden)
    slot #divInventoryModeBarcodes
    label "Barcodes"
    block #liScanPackBoxInventory (hidden)
      slot #tdScanPackBoxInventory
      label "Box #"
  block #ScanInventoryModeControls (hidden)
    button "Save"#liScanSaveInventory primary
    button "Close"
  block #ScanManualModeControls (hidden)
    button "Save"#liScanSave primary (hidden)
    button "Close"
  block #divScanAutoActions
    button "Close"
modal#SaleMult_NewCustomer_Content medium
  heading "New customer"
  button "×"
  input text#tdSaleMult_NewCustomer_Name placeholder "Enter a customer name"
  label "Name"
  slot #tdSaleMult_NewCustomer_Parent
  label "Parent"
  select#tdSaleMult_NewCustomer_PaymentTerm
  label "Payment term"
  select#tdSaleMult_NewCustomer_SaleAccount
  label "Sale account"
  select#tdSaleMult_NewCustomer_DefaultSalesRepresentative
  label "Sales representative"
  slot #tdSaleMult_NewCustomer_DefaultLocation
  label "Default location"
  input text#tdSaleMult_NewCustomer_Discount placeholder "Enter a customer discount"
  label "Discount"
  slot #tdSaleMult_NewCustomer_IsLegalEntity
  label "Legal entity" for #chkSaleMult_NewCustomer_IsLegalEntity
  input text#tdSaleMult_NewCustomer_CustomerName placeholder "Enter a display name"
  label "Display name"
  slot #tdSaleMult_NewCustomer_BillParent
  label "Bill parent" for #chkSaleMult_NewCustomer_BillParent
  slot #tdSaleMult_NewCustomer_Currency
  label "Currency"
  select#tdSaleMult_NewCustomer_AccountPayable
  label "Account receivable"
  block #divCustomerTaxRule
    select#tdSaleMult_NewCustomer_TaxRule
    label "Tax rule"
  select#tdSaleMult_NewCustomer_DefaultCarrier
  label "Default carrier"
  block #divCustomerTaxNumber
    input text#tdSaleMult_NewCustomer_TaxNumber placeholder "Enter a tax number"
    label "Tax number"
  select#tdSaleMult_NewCustomer_SalePriceTier
  label "Sale price tier"
  textarea#tdSaleMult_NewCustomer_Comments placeholder "Enter comments"
  label "Comments"
  button "Save" primary
  button "Close"
modal#SaleMult_NewTenantContact_Content medium
  heading "Add a sales representative"
  button "×"
  input text#tdSaleMult_NewTenantContact_Name
  label "Name" for #tdSaleMult_NewTenantContact_Name
  input text#tdSaleMult_NewTenantContact_Phone
  label "Phone" for #tdSaleMult_NewTenantContact_Phone
  input text#tdSaleMult_NewTenantContact_Fax
  label "Fax" for #tdSaleMult_NewTenantContact_Fax
  input text#tdSaleMult_NewTenantContact_Email
  label "Email" for #tdSaleMult_NewTenantContact_Email
  input text#tdSaleMult_NewTenantContact_Website
  label "Website" for #tdSaleMult_NewTenantContact_Website
  textarea#tdSaleMult_NewTenantContact_Comment
  label "Comments" for #tdSaleMult_NewTenantContact_Comment
  button "Save" primary
  button "Close"
modal#SaleMult_NewContact_Content medium
  heading "ADD CUSTOMER CONTACT"
  button "×"
  input text#tdSaleMult_NewContact_Name
  label "Name"
  input text#tdSaleMult_NewContact_JobTitle
  label "Job title"
  input text#tdSaleMult_NewContact_Phone
  label "Phone"
  input text#tdSaleMult_NewContact_MobilePhone
  label "Mobile phone"
  input checkbox#tdSaleMult_NewContact_IsDefault
  label "Default" for #tdSaleMult_NewContact_IsDefault
  input text#tdSaleMult_NewContact_Fax
  label "Fax"
  input text#tdSaleMult_NewContact_Email
  label "Email"
  input text#tdSaleMult_NewContact_Website
  label "Website"
  textarea#tdSaleMult_NewContact_Comment
  label "Comments"
  button "Save" primary
  button "Close"
modal#TenantPaymentTerm_NewTerm_Content small
  heading "Add a payment term"
  button "×"
  input text#tdTenantPaymentTerm_NewTerm_Name
  label "Name" for #tdTenantPaymentTerm_NewTerm_Name
  select#tdTenantPaymentTerm_NewTerm_Method: Number of days | Day of next month | Last day of next month | Days since the end of the month
  label "Method" for #tdTenantPaymentTerm_NewTerm_Method
  input text#tdTenantPaymentTerm_NewTerm_Days
  label "Days" for #tdTenantPaymentTerm_NewTerm_Days
  button "Save" primary
  button "Close"
modal#SaleMult_NewDeposit_Content small
  heading #SaleMult_NewDeposit_Title
  button "×"
  slot #SaleMult_NewDeposit_Account
  label "Deposit account"
  block #SaleMult_NewDeposit_BankAcocuntBlock
    slot #SaleMult_NewDeposit_BankAccount
    label "Account"
  input text#SaleMult_NewDeposit_Reference
  label "Reference"
  slot #SaleMult_NewDeposit_DatePaid
  label "Date paid"
  input text#SaleMult_NewDeposit_Amount
  label "Amount"
  block #liSaleMult_NewDeposit_ConversionRate
    input text#SaleMult_NewDeposit_ConversionRate
    button #SaleMult_NewDeposit_ConversionRate_GetRate
    label "Conversion rate"
  block #SaleMult_NewDeposit_BaseAmountBlock (hidden)
    slot #SaleMult_NewDeposit_BaseAmountLabel
    slot #SaleMult_NewDeposit_BaseAmount
  button "Create" primary
  button "Close"
modal#SaleMult_NewPayment_Content small
  heading "Add a payment"#SaleMult_NewPayment_Title
  button "×"
  slot #SaleMult_NewPayment_Account
  label "Account"
  input text#SaleMult_NewPayment_Reference
  label "Reference"
  slot #SaleMult_NewPayment_DatePaid
  label "Date paid"
  input text#SaleMult_NewPayment_Amount
  label "Amount"
  block #liSaleMult_NewPayment_ConversionRate
    input text#SaleMult_NewPayment_ConversionRate
    button #SaleMult_NewPayment_ConversionRate_GetRate
    label "Conversion rate" for #SaleMult_NewPayment_ConversionRate
  block #liSaleMult_NewPayment_BaseAmount
    slot #SaleMult_NewPayment_BaseAmount
  button "Create" primary
  button "Close"
modal#SaleMult_NewAddress_Content medium
  heading "ADD CUSTOMER ADDRESS"
  button "×"
  slot #cmbAddress
  button  primary
  label ""
  input text#tdSaleMult_NewAddress_Line1
  label "Line 1"
  input text#tdSaleMult_NewAddress_Line2
  label "Line 2"
  input text#tdSaleMult_NewAddress_CitySuburb
  label "City / suburb"
  input text#tdSaleMult_NewAddress_StateProvince
  label "State / province"
  input text#tdSaleMult_NewAddress_ZipPostCode
  label "ZIP / postcode"
  select#tdSaleMult_NewAddress_Country
  label "Country"
  block #SaleCommon_NewAddress_AvalaraTaxExemptionCode (hidden)
    slot #cmbAvalaraTaxExemptionCode_NewAddress
    label "Tax exemption reason"
  select#tdSaleMult_NewAddress_Type: Billing | Business | Shipping
  label "Type"
  input checkbox#tdSaleMult_NewAddress_DefaultForType
  label "Default for type" for #tdSaleMult_NewAddress_DefaultForType
  button "Save" primary
  button "Close"
modal#SaleMult_EditAddress_Content medium
  heading "Edit shipping address"
  button "×"
  button "Search customer address"#divShowAddressSearch
  button "Hide search"#divHideAddressSearch (hidden)
  block #divSale_Index_Ship_Another_Customer (hidden)
    slot #Sale_Index_Ship_Another_Customer
    label "Customer"
    slot #Sale_Index_SippingAnotherAddressLine1
    label "Address"
  input text#tdSaleMult_EditAddress_Line1
  label "Line 1"
  input text#tdSaleMult_EditAddress_Line2
  label "Line 2"
  input text#tdSaleMult_EditAddress_CitySuburb
  label "City / suburb"
  input text#tdSaleMult_EditAddress_ZipPostCode
  label "ZIP / postcode"
  input text#tdSaleMult_EditAddress_StateProvince
  label "State / province"
  select#tdSaleMult_EditAddress_Country
  label "Country"
  button "OK" primary
  button "Close"
modal#SaleMult_NewCarrier_Content small
  heading "ADD CARRIER"
  button "×"
  input text#tdSaleMult_NewCarrier_Description
  label "Carrier" for #tdSaleMult_NewCarrier_Description
  button "Save" primary
  button "Close"
modal#SaleMult_LookupCourierDialog_Content medium
  heading "Carrier / service lookup"
  button "×"
  slot #divLookupCourierDialogGrid
  button "OK" primary
  button "Close"
modal#Sale_SelectShippingRate_Content medium
  heading "Please select a shipping option"
  button "×"
  slot #divShippingOptionsGrid
  button "OK" primary
  button "Close"
modal#SaleMult_NewProduct_Content medium
  heading "Add a new product"
  button "×"
  input text#SaleMult_NewProduct_ProductCode placeholder "Enter a product SKU"
  label "SKU"
  input text#SaleMult_NewProduct_Name placeholder "Enter a product name"
  label "Name"
  select#SaleMult_NewProduct_Type
  label "Type"
  select#SaleMult_NewProduct_Category
  label "Category"
  select#SaleMult_NewProduct_PurchaseTaxRule
  label "Purchase tax rule"
  slot #SaleMult_NewProduct_SaleTaxRule
  label "Sale tax rule"
  block #trSupplier
    slot #SaleMult_NewProduct_Supplier
    label "Supplier"
  block #trPurchasePrice
    input text#SaleMult_NewProduct_PurchasePrice
    label "Purchase price"
  select#SaleMult_NewProduct_UnitOfMeasure
  label "Unit of measure"
  block #trCostingMethod
    select#SaleMult_NewProduct_CostingMethod
    label "Costing method"
  block #trExpenseAccount
    select#SaleMult_NewProduct_ExpenseAccount
    label "Expense account"
  block #trMinimumBeforeReorder
    input text#SaleMult_NewProduct_MinimumBeforeReorder placeholder "Enter a minimum before reorder."
    label "Minimum before reorder"
  block #trReorderQuantity
    input text#SaleMult_NewProduct_ReorderQuantity placeholder "Enter reorder quantity"
    label "Reorder quantity"
  input text#SaleMult_NewProduct_Barcode placeholder "Enter a barcode"
  label "Barcode"
  block #trStockLocator
    input text#SaleMult_NewProduct_StockLocator placeholder "Enter a stock locator"
    label "Stock locator"
  block #trDropShipMode
    select#SaleMult_NewProduct_DropShipMode
    label "Drop ship"
  select#SaleMult_NewProduct_ProductAttributeSet
  label "Attribute set"
  slot #divAdditionalAttributes_NewProduct
  block #AdditionalAttributes_FieldTemplate (hidden)
    slot #{CustomField}
    label "" for #{CustomField}
  button "Save" primary
  button "Close"
modal#SaleMult_NewExtShippingLine_Content small
  heading "Choose a box for external fulfillment"
  button "×"
  select#tdSaleMult_NewExtShippingLine_Box
  label "Box" for #SaleMult_NewTerm_Name
  button "Add" primary
  button "Close"
modal#divUploadOrderDialog medium
  heading "Upload an order"
  button "×"
  heading "1. Download this sale order"
  heading "2. Add new and modify existing products in the file."
  heading "3. Upload"
  slot #ifrmDownloadOrder (hidden)
  form#frmDownloadOrder
  slot #ifrmUploadOrder (hidden)
  form#frmUploadOrder
    block #OrderDropContainer
      heading "Drop files here or click to upload."
  block #UploadSOLinesExceptionsContainer (hidden)
    slot #UploadSaleOrderLinesExceptionsGrid
  button "Close"
modal#divUploadQuoteDialog medium
  heading "Upload a quote"
  button "×"
  heading "1. Download this quote"
  heading "2. Add new and modify existing products in the file."
  heading "3. Upload"
  slot #ifrmDownloadQuote (hidden)
  form#frmDownloadQuote
  block #QuoteDropContainer
    heading "Drop files here or click to upload."
  block #UploadQuoteLinesExceptionsContainer (hidden)
    slot #UploadSaleQuoteLinesExceptionsGrid
  button "Close"
modal#PresetModal small
  heading "Name your pre-set"
  button "×"
  input text#PresetModal_Name
  label "Pre-set name"
  button "Save" primary
  button "Close"
modal#saleGiftCardDialog small
  heading "Sale gift card"
  button "×"
  input text#newSaleGiftCardCode
  label "Gift card code" for #newSaleGiftCardCode
  button "Generate" primary
  block #newGiftCardExpirationSection
    slot #dtNewSaleGiftCardExpirationDate
    label "Gift card expiration date" for #dtNewSaleGiftCardExpirationDate
  input text#newSaleGiftCardAmount
  label "Gift card price" for #newSaleGiftCardAmount
  button "Save" primary
  button "Cancel"
modal#payGiftCardDialog small
  heading "Pay with a gift card"
  button "×"
  input text#newPayGiftCardCode
  label "Gift card code" for #newPayGiftCardCode
  button "Check gift card" primary
  input text#giftCardCurrentBalance
  label "Balance" for #giftCardCurrentBalance
  input text#newPayGiftCardAmount
  label "Amount" for #newPayGiftCardAmount
  button "Save"#applyGiftCardPayment primary
  button "Cancel"
block #SaleMult_ShippingService_Labeling (hidden)
  block #SaleMult_ShippingService_Content
    slot #SaleMult_ShippingService_title
    button "Generate label"#SaleMult_ShipLabel_GenerateAction primary
    button "Cancel"#SaleMult_ShipLabel_CancelAction
    slot #ifrmDownloadLabel (hidden)
    form#frmDownloadLabel
    slot #SaleMult_ShippingService_ContentDynamic
    button "Generate label"#SaleMult_ShipLabel_GenerateAction2 primary
    button "Cancel"#SaleMult_ShipLabel_CancelAction2
block #SaleMult_NewAllocation (hidden)
  block #divHeaderCustomerCredit
    heading "Allocate customer credit as payment"
  block #divHeaderCreditNote
    heading "Allocate credit note"
  button "Add and save"#SaleMult_NewAllocation_SaveAction primary
  button "Cancel"#SaleMult_NewAllocation_CancelAction
  block #divExistingCustomerCredit
    heading "Select existing customer credit(s)"
    slot #SaleMult_NewAllocation_Credits
  block #divExistingCreditNote
    heading "Select existing credit note(s)"
    slot #SaleMult_NewAllocation_CreditNotes
  heading "Allocation(s) that will be created"
  slot #SaleMult_NewAllocation_Allocations
  table
  button "Add and save"#SaleMult_NewAllocation_SaveAction2 primary
  button "Cancel"#SaleMult_NewAllocation_CancelAction2
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
modal#customizationDialog large
  heading "Customization for product:"
  button "×"
  block #customizationContainer
    button "➜"
    button "Set to default"
    button "➜"
    button "Set to default"
    input text#searchFiled placeholder "Type to search..."
    button "Search"
    button 
    input number#quantity
    button 
    button "Reset to default"
    slot #totalAmount
    button "Confirm order" (hidden)
    button 
    button "➜"
    button "Clear selected"
    label "Custom element text" for #artText
    input text#artText placeholder "Type custom element text"
    text "For example your initials. Maximum 64 characters including punctuation."
    label "Choose file" for #artFile + file #artFile
    text "Choose the image that you want to apply. Size should be lesser than 16MB."
    button "Confirm changes"
  block #zoomPopup (hidden)
  button "Save"#btnSaveCustomization primary
  button "Close"
modal#selectedOptionsDialog small
  heading "Selected options"
  button "×"
  button "Customize"#btnCustomize primary
  button "Close"
modal#AlternativeProductsModal large
  heading "Alternative products"
  button "×"
  slot #AlternativeProductsModal_Grid
  button "Close"
block #Sale_ShippingInstructions (hidden)
  heading "Please provide shipping instructions"
  button "OK"#Sale_ShippingInstructions_SaveAction primary
  button "Cancel"#Sale_ShippingInstructions_CancelAction
  slot #Sale_ShippingInstructions_ContentDynamic
  slot #Sale_ShippingInstructionWarning
block #Sale_PackageDetails (hidden)
  heading "Please select your packages"
  button "OK"#Sale_PackageDetails_SaveAction primary
  button "Cancel"#Sale_PackageDetails_CancelAction
  slot #package-select
  slot #Sale_PackageDetails_ContentDynamic
modal#divCOGSAccDims small
  heading "Accounting dimensions"
  button "×"
  button "Save"#btnSaveCOGSAccDims primary
  button "Close"
slot #CountrySpecificScript
```

### `/SaleService`: Service sale

Frame: `iUpload`.

```text
link "Home"
link "Sales"
button "Save"#saveAction primary
button "Undo"#undoAction
button "Back to list"
button "Void"#voidAction
block #taskActions
  button "Clone"#cloneAction
block #moreActionsBlock (hidden)
  button "More actions"#moreActions
  link "Undo"#undoAction_more (hidden)
  link "Void"#voidAction_more (hidden)
  link "Clone"#cloneAction_more (hidden)
block #divMainContent
  slot #Sale_Index_Status
  heading 
  block #divArchiveStatic (hidden)
  block #divApproveStatic (hidden)
  button "Save as preset"#btnSavePreset primary
  select#cmbPresetList
  button "Delete preset"#btnDeletePreset
  block #divCustomerTask (hidden)
    button 
    button  primary
    button "Workflow"
    button 
    button "Calendar"
  button 
  block #divTaskHeader
    heading "Customer details"
    slot #Sale_Index_Customer
    label "Customer"
    slot #Sale_Index_Contact
    label "Contact"
    slot #Sale_Index_Phone
    label "Phone"
    slot #Sale_Index_Email
    label "Email"
    slot #Sale_Index_CustomerReference
    label "Customer reference"
    slot #Sale_Index_BillingAddressLine1
    label "Billing address line 1"
    slot #Sale_Index_BillingAddressLine2
    label "Billing address line 2"
    slot #Sale_Index_PriceTier
    label "Price tier*"
    heading "Accounting details"
    slot #Sale_Index_Terms
    label "Terms"
    slot #Sale_Index_SalesRepresentative
    label "Sales rep*"
    slot #tdSale_Index_DefaultAccount
    label "Account*"
    block #divRate
      slot #tdSale_Index_CurrencyConversionRate
      label ""
    slot #Sale_Index_Tax
    label "Tax rule*"
    slot #SaleService_Index_Tax_Inclusive
    label "Tax inclusive" for #chkSaleService_Index_Tax_Inclusive
    slot #Sale_Index_SkipQuote
    label "Skip quote" for #chkSkipQuote
    slot #Sale_Index_IsRecursive
    label "Recurring task" for #chkIsRecursive
    block #Sale_Index_lblFrequency
      slot #Sale_Index_Frequency
      label "Recurring frequency"
    block #liInvoiceDate
      input text#Sale_Index_InvoiceDate
      label "Invoice date"
    block #liInvoiceDueDate
      input text#Sale_Index_DueDate
      label "Due date"
    heading "Shipping details"
    slot #Sale_Index_Date
    label "Date*"
    slot #Sale_Index_ShipToCompany
    label "Ship to company"
    slot #Sale_Index_ShipToContact
    label "Ship to contact"
    slot #Sale_Index_SippingAddressLine1
    label "Shipping address line 1"
    block #Sale_Index_RecepientAddress
      slot #Sale_Index_SippingAddressLine2
      label "Shipping address line 2"
    block #SaleCommon_AvalaraTaxExemptionCode (hidden)
      slot #cmbAvalaraTaxExemptionCode
      label "Tax exemption reason"
    textarea#Sale_Index_ShippingNotes placeholder "Shipping notes..."
    label "Shipping notes"
    slot #Sale_Index_ShipmentRequiredByDate
    label "Required by"
    block #divNote
      heading "Comments"
      textarea#divStickyNote placeholder "Write your note here..."
  button "Quote"
  button "Invoice"
  button "Credit note"
  button "Manual journals"
  button "Attachments"
  button "Logs and attributes"
  button "Financials"
  block #divQuote (hidden)
    heading "Quote"
    button "Email"#tabQuoteEmailAction ▾
    menu: 
    button "Print"#tabQuotePrintAction ▾
    menu: 
    button "Apply discounts"#divDiscounts_Quote
    button "Authorize"#divAuthorise_Quote primary
    button "Approve"#btApprove primary (hidden)
    button "Reject"#btReject (hidden)
    button "Review"#btReview (hidden)
    slot #vSaleQuoteLinesDiscountDescription (hidden)
    button #divNewLines_Quote primary
    slot #divQuoteLines
    button "Add more items"#SaleService_Quote_AddQuoteLinesRecordLink primary (hidden)
    textarea#tdSale_Index_QuoteMemo placeholder "Write your notes here..."
    label "Quote memo" for #tdSale_Index_QuoteMemo
    table: Total
    block #divCreditNoteRefundBlock
      heading "Credits"
      button "Cin7 Pay Payments"#divNewPayment_Quote_Cin7Pay
      button "Cin7 Core Payments"#divNewPayment_Quote_PaymentGateway primary
      button "Customer credit"#divNewPayment_Quote primary
      slot #divDeposits
  block #divInvoice (hidden)
    heading "Invoice"
    text "#"#liInvoiceNo
    button "Email"#tabInvoiceEmailAction ▾
    menu: 
    button "Print"#tabInvoicePrintAction ▾
    menu: 
    button "Apply coupon"#divCoupon_Invoice
    button "View in Xero"#divXero_Invoice primary (hidden)
    button "Apply discounts"#divDiscounts_Invoice
    button "Authorize"#divAuthorise_Invoice primary
    slot #vSaleInvoiceLinesDiscountDescription (hidden)
    slot #tdSale_Invoice_Date
    label "Invoice date*"
    slot #tdSale_Invoice_DueDate
    label "Due date*"
    button #divNewLines_Invoice primary
    button "Copy from quote"#divCopy_Invoice
    button "Gift card"#divNewGiftCard_Invoice
    slot #divInvoiceLines
    button "Add more items"#SaleService_Invoice_AddLinesRecordLink primary (hidden)
    textarea#tdSale_Index_InvoiceMemo placeholder "Write your notes here..."
    label "Invoice memo" for #tdSale_Index_InvoiceMemo
    table: Total
    heading "Payments"
    button "Payment"#divNewPayment_Invoice primary
    button "Use customer credit"#divNewPaymentAllocation_Invoice
    button "Allocate credit note"#divNewPaymentAllocation_CrNoteAlloc
    button "Use a gift card"#divNewPaymentGiftCard_Invoice
    button "Cin7 Core Payments"#divNewPayment_Invoice_PaymentGateway
    button "Cin7 Pay Payments"#divNewPayment_Invoice_Cin7Pay
    slot #divInvoicePayments
    text "Balance due"#Sale_Invoice_BalanceHeader
    slot #Sale_Invoice_Balance
    block #Sale_Invoice_BalanceDueText
      text "Balance due"#Sale_Invoice_BalanceHeaderTenant
      slot #Sale_Invoice_BalanceTenant
    block #divCreditNoteRefundBlock
      heading "Credits"
      button "Customer credit"#divNewPayment_SaleServiceInvoice primary
      button "Cin7 Pay Payments"#divNewCreditPayment_Invoice_Cin7Pay
      slot #divDepositsSaleServiceInvoice
  block #divCreditNote (hidden)
    heading "Credit note"
    slot #tdSale_CreditNote_Number
    button "Void credit note"#divVoid_CreditNote (hidden)
    button "Email"#tabCreditNoteEmailAction ▾
    menu: 
    button "Print"#tabCreditNotePrintAction ▾
    menu: 
    button "View in Xero"#divXero_CreditNote primary (hidden)
    button "Authorize"#divAuthorise_CreditNote primary
    slot #tdSale_CreditNote_Date
    label "Credit note date*"
    button #divNewLine_CreditNote primary
    button "Copy from invoice"#divCopyLines_CreditNote
    slot #divCreditNoteLines
    button "Add more items"#SaleService_CreditNote_AddLinesRecordLink primary (hidden)
    textarea#tdSale_Index_CreditNoteMemo placeholder "Write your notes here..."
    label "Credit note memo" for #tdSale_Index_CreditNoteMemo
    table: Total
    block #divCreditNoteRefundBlock
      heading "Refunds"
      button "Refund"#divNewPayment_CreditNote primary
      button "Customer credit"#divNewPayment_CreditNote_Credit
      button "Cin7 Core refunds"#divNewPayment_CreditNote_PaymentGateway_Refund
      button "Cin7 Pay refunds"#divNewPayment_CreditNote_Cin7Pay_Refund
      slot #divCreditNotePayments
      text "Balance due"#Sale_CreditNote_BalanceHeader
      slot #Sale_CreditNote_Balance
      text "Balance due"#Sale_CreditNote_BalanceHeaderTenant (hidden)
      slot #Sale_CreditNote_BalanceTenant (hidden)
  block #divAdditionalCOGS (hidden)
    heading "Manual journals"
    button "Undo journals"#divNew_UndoManualJournals
    button "Authorize"#divAuthorise_AdditionalCOGS primary
    button #divNew_AdditionalCOGS primary
    slot #divAdditionalTransactionsContainer
    button "Add more items"#SaleService_AdditionalCOGS_AddLineLink primary (hidden)
  block #divHistory (hidden)
    block #Sale_divAttributeSet (hidden)
      heading "Additional attributes"
      block #Sale_liCustomField1
        slot #Sale_CustomField1
        label "Attribute 1"
      block #Sale_liCustomField2
        slot #Sale_CustomField2
        label "Attribute 2"
      block #Sale_liCustomField3
        slot #Sale_CustomField3
        label "Attribute 3"
      block #Sale_liCustomField4
        slot #Sale_CustomField4
        label "Attribute 4"
      block #Sale_liCustomField5
        slot #Sale_CustomField5
        label "Attribute 5"
      block #Sale_liCustomField6
        slot #Sale_CustomField6
        label "Attribute 6"
      block #Sale_liCustomField7
        slot #Sale_CustomField7
        label "Attribute 7"
      block #Sale_liCustomField8
        slot #Sale_CustomField8
        label "Attribute 8"
      block #Sale_liCustomField9
        slot #Sale_CustomField9
        label "Attribute 9"
      block #Sale_liCustomField10
        slot #Sale_CustomField10
        label "Attribute 10"
    heading "Activity log"
    slot #divHistoryLines
    heading "Workflow activity log"
    slot #divWorkflowHistoryLines
  block #divAttachments (hidden)
    heading "Attach file"
    block #divAttachmentUpload
      block #divUploadContainer
        block #preview-template (hidden)
        slot #iUpload (hidden)
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
  slot #divPrint
  form#frmClone
  slot #ifrmDownloadFile (hidden)
  form#[object HTMLInputElement]
  modal#Sale_NewCustomer_Content medium
    heading "New customer"
    button "×"
    input text#tdSale_NewCustomer_Name placeholder "Enter a customer name"
    label "Name"
    slot #tdSale_NewCustomer_Parent
    label "Parent"
    select#tdSale_NewCustomer_PaymentTerm
    label "Payment term"
    select#tdSale_NewCustomer_SaleAccount
    label "Sale account"
    select#tdSale_NewCustomer_DefaultSalesRepresentative
    label "Sales representative"
    select#tdSale_NewCustomer_DefaultLocation
    label "Default location"
    input text#tdSale_NewCustomer_Discount placeholder "Enter a customer discount"
    label "Discount"
    slot #tdSale_NewCustomer_IsLegalEntity
    label "Legal entity" for #chkSale_NewCustomer_IsLegalEntity
    input text#tdSale_NewCustomer_CustomerName placeholder "Enter a display name"
    label "Display name"
    slot #tdSale_NewCustomer_BillParent
    label "Bill parent" for #chkSale_NewCustomer_BillParent
    slot #tdSale_NewCustomer_Currency
    label "Currency"
    select#tdSale_NewCustomer_AccountPayable
    label "Account receivable"
    block #divCustomerTaxRule
      select#tdSale_NewCustomer_TaxRule
      label "Tax rule"
    select#tdSale_NewCustomer_DefaultCarrier
    label "Default carrier"
    block #divCustomerTaxNumber
      input text#tdSale_NewCustomer_TaxNumber placeholder "Enter a tax number"
      label "Tax number"
    select#tdSale_NewCustomer_SalePriceTier
    label "Sale price tier"
    textarea#tdSale_NewCustomer_Comments placeholder "Enter comments"
    label "Comments"
    button "Save" primary
    button "Close"
  modal#Sale_NewTenantContact_Content medium
    heading "Add a sales representative"
    button "×"
    input text#tdSale_NewTenantContact_Name
    label "Name" for #tdSale_NewTenantContact_Name
    input text#tdSale_NewTenantContact_Phone
    label "Phone" for #tdSale_NewTenantContact_Phone
    input text#tdSale_NewTenantContact_Fax
    label "Fax" for #tdSale_NewTenantContact_Fax
    input text#tdSale_NewTenantContact_Email
    label "Email" for #tdSale_NewTenantContact_Email
    input text#tdSale_NewTenantContact_Website
    label "Website" for #tdSale_NewTenantContact_Website
    textarea#tdSale_NewTenantContact_Comment
    label "Comments" for #tdSale_NewTenantContact_Comment
    button "Save" primary
    button "Close"
  modal#Sale_NewContact_Content medium
    heading "ADD CUSTOMER CONTACT"
    button "×"
    input text#tdSale_NewContact_Name
    label "Name"
    input text#tdSale_NewContact_JobTitle
    label "Job title"
    input text#tdSale_NewContact_Phone
    label "Phone"
    input text#tdSale_NewContact_MobilePhone
    label "Mobile phone"
    input checkbox#tdSale_NewContact_IsDefault
    label "Default" for #tdSale_NewContact_IsDefault
    input text#tdSale_NewContact_Fax
    label "Fax"
    input text#tdSale_NewContact_Email
    label "Email"
    input text#tdSale_NewContact_Website
    label "Website"
    textarea#tdSale_NewContact_Comment
    label "Comments"
    button "Save" primary
    button "Close"
  modal#Sale_NewDeposit_Content small
    heading #Sale_NewDeposit_Title
    button "×"
    slot #Sale_NewDeposit_Account
    label "Deposit account"
    block #Sale_NewDeposit_BankAcocuntBlock
      slot #Sale_NewDeposit_BankAccount
      label "Account"
    input text#Sale_NewDeposit_Reference
    label "Reference"
    slot #Sale_NewDeposit_DatePaid
    label "Date paid"
    input text#Sale_NewDeposit_Amount
    label "Amount"
    block #liSale_NewDeposit_ConversionRate
      input text#Sale_NewDeposit_ConversionRate
      button #Sale_NewDeposit_ConversionRate_GetRate
      label "Conversion rate"
    block #Sale_NewDeposit_BaseAmountBlock (hidden)
      slot #Sale_NewDeposit_BaseAmountLabel
      slot #Sale_NewDeposit_BaseAmount
    button "Create" primary
    button "Close"
  modal#TenantPaymentTerm_NewTerm_Content small
    heading "Add a payment term"
    button "×"
    input text#tdTenantPaymentTerm_NewTerm_Name
    label "Name" for #tdTenantPaymentTerm_NewTerm_Name
    select#tdTenantPaymentTerm_NewTerm_Method: Number of days | Day of next month | Last day of next month | Days since the end of the month
    label "Method" for #tdTenantPaymentTerm_NewTerm_Method
    input text#tdTenantPaymentTerm_NewTerm_Days
    label "Days" for #tdTenantPaymentTerm_NewTerm_Days
    button "Save" primary
    button "Close"
  modal#SaleService_NewProduct_Content medium
    heading "Add new product"
    button "×"
    input text#SaleService_NewProduct_ProductCode placeholder "Enter a product SKU"
    label "SKU"
    input text#SaleService_NewProduct_Name placeholder "Enter a product name"
    label "Name"
    select#SaleService_NewProduct_Category
    label "Category"
    select#SaleService_NewProduct_PurchaseTaxRule
    label "Purchase tax rule"
    select#SaleService_NewProduct_SaleTaxRule
    label "Sale tax rule"
    select#SaleService_NewProduct_UnitOfMeasure
    label "Unit of measure"
    input text#SaleService_NewProduct_Barcode placeholder "Enter a barcode"
    label "Barcode"
    select#SaleService_NewProduct_ProductAttributeSet
    label "Attribute set"
    slot #divAdditionalAttributes_NewProduct
    block #AdditionalAttributes_FieldTemplate (hidden)
      slot #{CustomField}
      label "" for #{CustomField}
    button "Save" primary
    button "Close"
  modal#Sale_NewAddress_Content medium
    heading "ADD CUSTOMER ADDRESS"
    button "×"
    slot #cmbAddress
    button  primary
    label ""
    input text#tdSale_NewAddress_Line1
    label "Line 1" for #tdSale_NewAddress_Line1
    input text#tdSale_NewAddress_Line2
    label "Line 2" for #tdSale_NewAddress_Line2
    input text#tdSale_NewAddress_CitySuburb
    label "City / suburb" for #tdSale_NewAddress_CitySuburb
    input text#tdSale_NewAddress_StateProvince
    label "State / province" for #tdSale_NewAddress_StateProvince
    input text#tdSale_NewAddress_ZipPostCode
    label "ZIP / postcode" for #tdSale_NewAddress_ZipPostCode
    select#tdSale_NewAddress_Country
    label "Country" for #tdSale_NewAddress_Country
    block #SaleCommon_NewAddress_AvalaraTaxExemptionCode (hidden)
      slot #cmbAvalaraTaxExemptionCode_NewAddress
      label "Tax exemption reason" for #cmbAvalaraTaxExemptionCode_NewAddress
    select#tdSale_NewAddress_Type: Billing | Business | Shipping
    label "Type" for #tdSale_NewAddress_Type
    input checkbox#tdSale_NewAddress_DefaultForType
    label "Default for type" for #tdSale_NewAddress_DefaultForType
    button "Save" primary
    button "Close"
  modal#saleGiftCardDialog small
    heading "Sale gift card"
    button "×"
    input text#newSaleGiftCardCode
    label "Gift card code" for #newSaleGiftCardCode
    button "Generate" primary
    block #newGiftCardExpirationSection
      slot #dtNewSaleGiftCardExpirationDate
      label "Gift card expiration date" for #dtNewSaleGiftCardExpirationDate
    input text#newSaleGiftCardAmount
    label "Gift card price" for #newSaleGiftCardAmount
    button "Save" primary
    button "Cancel"
  modal#payGiftCardDialog small
    heading "Pay with a gift card"
    button "×"
    input text#newPayGiftCardCode
    label "Gift card code" for #newPayGiftCardCode
    button "Check gift card" primary
    input text#giftCardCurrentBalance
    label "Balance" for #giftCardCurrentBalance
    input text#newPayGiftCardAmount
    label "Amount" for #newPayGiftCardAmount
    button "Save"#applyGiftCardPayment primary
    button "Cancel"
  modal#PresetModal small
    heading "Name your pre-set"
    button "×"
    input text#PresetModal_Name
    label "Pre-set name"
    button "Save" primary
    button "Close"
block #Sale_NewAllocation (hidden)
  block #divHeaderCustomerCredit
    heading "Allocate customer credit as payment"
  block #divHeaderCreditNote
    heading "Allocate credit note"
  button "Add and save"#Sale_NewAllocation_SaveAction primary
  button "Cancel"#Sale_NewAllocation_CancelAction
  block #divExistingCustomerCredit
    heading "Select existing customer credit(s)"
    slot #Sale_NewAllocation_Credits
  block #divExistingCreditNote
    heading "Select existing credit note(s)"
    slot #Sale_NewAllocation_CreditNotes
  heading "Allocation(s) that will be created"
  slot #Sale_NewAllocation_Allocations
  table
  button "Add and save"#Sale_NewAllocation_SaveAction2 primary
  button "Cancel"#Sale_NewAllocation_CancelAction2
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
modal#AlternativeProductsModal large
  heading "Alternative products"
  button "×"
  slot #AlternativeProductsModal_Grid
  button "Close"
modal#divCOGSAccDims small
  heading "Accounting dimensions"
  button "×"
  button "Save"#btnSaveCOGSAccDims primary
  button "Close"
slot #CountrySpecificScript
```

### `/Warranties`: Warranties

Frame: `task-upload-frame`.

```text
link "Home"
button "Tutorial"
link "RMA - General"
link "RMA - Products"
link "Registered warranties"
input text#divSearch placeholder "Type text to search"
button "Search" primary
select#divFilter: All | Valid | Expired
button "Export"#divExport
button "Refresh"#divRefresh
button #Grid_gridName_Options
slot #Warranties_Index_Container
form#frmExport
```

## Components by bundle

What the page code builds and mounts into the layout's slots.

### `AwaitingSale2019`

5 grids · 36 standalone fields · 0 windows · 3 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `divRelatedOrdersDetails` · store `RelatedOrdersStore` · placeholder `No related orders created.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Order | `TaskNumber` |  | flex 1 | renderer() |  |
    | Type | `TaskTypeName` |  | flex 1 | RenderHTMLText |  |
    | Order date | `OrderDate` |  | flex 1 | renderer() |  |
    | Status | `Status` |  | flex 1 | renderer() |  |
    | Total | `TotalAmount` |  | 130 | renderer() |  |

- **grid** · renders into `divInvoiceLines` · placeholder `You do not have any invoice lines.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Requested product | `SourceProductCode` |  | flex 2 | renderer() |  |
    | Your product | `ProductCode` |  | flex 2 | renderer() |  |
    | Comment | `Comment` |  | flex 1 | renderer() | total count |
    | Unit | `UnitOfMeasure` |  | flex 1 | renderer() | hidden |
    | Quantity | `Quantity` |  | flex 1 |  | total sum |
    | Price | `Price` |  | flex 1 | renderer() |  |
    | Discount | `Discount` |  | flex 1 | renderer() |  |
    | Tax rule | `TaxRule` |  | flex 1 | renderer() |  |
    | Margin | `AverageCost` |  | flex 1 | renderer() |  |
    | Account | `AccountCode` |  | flex 1 | renderer() |  |
    | Total | `Total` |  | flex 1 | renderer() | total sum |

- **grid** · renders into `divInvoiceAdditionalChargesLines` · placeholder `You do not have any additional charges.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Description | `Description` |  | flex 2 | renderer() |  |
    | Comment | `Comment` |  | flex 1 | renderer() | total count |
    | Quantity | `Quantity` |  | flex 1 |  |  |
    | Price | `Amount` |  | flex 1 | renderer() |  |
    | Discount | `Discount` | number column | flex 1 | renderer() |  |
    | Tax rule | `TaxRule` |  | flex 2 | renderer() |  |
    | Account | `AccountCode` |  | flex 1 | renderer() |  |
    | Total | `Total` |  | flex 1 | renderer() |  |

- **grid** · renders into `divOrderLines` · placeholder `You do not have any order lines.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Requested product | `SourceProductCode` |  | flex 2 | renderer() |  |
    | Your product | `ProductCode` |  | flex 3 | renderer() |  |
    | Comment | `Comment` |  | flex 1 | renderer() | total count |
    | Unit | `UnitOfMeasure` |  | flex 1 | renderer() | hidden |
    | Quantity | `Quantity` |  | flex 1 |  | total sum |
    | Price | `Price` |  | flex 1 | renderer() |  |
    | Discount | `Discount` | number column | flex 1 | renderer() |  |
    | Tax rule | `TaxRule` |  | flex 1 | renderer() |  |
    | Margin | `AverageCost` |  | flex 1 | renderer() |  |
    | Total | `Total` |  | flex 1 | renderer() | total sum |

- **grid** · renders into `divOrderAdditionalChargesLines` · placeholder `You do not have any additional charges in your order.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Additional charges | `Description` |  | flex 3 | renderer() |  |
    | Comment | `Comment` |  | flex 1 | renderer() |  |
    | Quantity | `Quantity` |  | flex 1 |  |  |
    | Price | `Amount` |  | flex 1 | renderer() |  |
    | Discount | `Discount` | number column | flex 1 | renderer() |  |
    | Tax rule | `TaxRule` |  | flex 2 | renderer() |  |
    | Total | `Total` |  | flex 1 | renderer() |  |


#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| text field |  | `renderTo` | `` |  |
| combo |  | `renderTo` | `localStore` | shows `name` · value `value` · placeholder `Choose...` · pick-only |
| checkbox |  | `renderTo` | `` |  |
| numeric field |  | `renderTo` | `` |  |
| date field |  | `renderTo` | `` | placeholder `Choose...` · format `UserDateFormat` |
| date field |  | `dtNewSaleGiftCardExpirationDate` | `` | placeholder `Choose...` · format `UserDateFormat` |
| combo |  | `cmbAvalaraTaxExemptionCode` | `vSale_AvalaraSaleTaxCodeStore` | shows `Name` · value `Code` · placeholder `Choose...` |
| combo |  | `cmbAvalaraTaxExemptionCode_NewAddress` | `vSale_AvalaraSaleTaxCodeStore` | shows `Name` · value `Code` · placeholder `Choose...` |
| date field |  | `tdSale_Invoice_Date` | `` | placeholder `Choose...` · format `UserDateFormat` |
| date field |  | `tdSale_Invoice_DueDate` | `` | placeholder `Choose...` · format `UserDateFormat` |
| combo |  | `tdSale_NewProduct_Supplier` | `SupplierStore` | shows `Name` · value `SupplierID` · placeholder `type to search...` |
| combo (+ add new) |  | `Sale_Index_Customer` | `vSale_CustomerStore` | shows `Name` · value `Name` · placeholder `type to search...` |
| combo |  | `Sale_Index_Ship_Another_Customer` | `vSale_ShipAnotherCustomerStore` | shows `Name` · value `Name` · placeholder `type to search...` |
| combo |  | `Sale_Index_SippingAnotherAddressLine1` | `vSale_ShipAnotherCustomerAddressStore` | shows `Line1` · value `AddressID` · placeholder `Choose...` |
| combo (+ add new) |  | `Sale_Index_Contact` | `vSale_CustomerContactStore` | shows `Name` · value `Name` · placeholder `Choose...` |
| text field |  | `Sale_Index_Phone` | `` | placeholder `write...` |
| text field |  | `Sale_Index_Email` | `` | placeholder `write...` |
| combo (+ add new) |  | `Sale_Index_BillingAddressLine1` | `vSale_CustomerAddressStore` | shows `Line1` · value `Line1` · placeholder `Choose...` |
| text field |  | `Sale_Index_BillingAddressLine2` | `` | placeholder `Choose...` |
| combo |  | `Sale_Index_Tax` | `vTenantTaxationRuleStore` | shows `Description` · value `RuleID` · placeholder `Choose...` |
| checkbox |  | `Sale_Index_Tax_Inclusive` | `` |  |
| combo |  | `Sale_Index_PriceTier` | `vSalesPriceTiersStore` | shows `Name` · value `Code` · placeholder `Choose...` · pick-only |
| combo (+ add new) |  | `Sale_Index_Terms` | `vTenantPaymentTermStore` | shows `Name` · value `Name` · placeholder `Choose...` |
| text field |  | `Sale_Index_CustomerReference` | `` |  |
| text field |  | `Sale_Index_ShipToContact` | `` |  |
| text field |  | `Sale_Index_ShipToCompany` | `` |  |
| combo (+ add new) |  | `Sale_Index_SalesRepresentative` | `vTenantContactsStore` | shows `Name` · value `Name` · placeholder `Choose...` |
| combo |  | `Sale_Index_Location` | `vTenantLocationNoneFixedAssetStore` | shows `Description` · value `LocationID` · placeholder `Choose...` |
| numeric field (with action) |  | `tdSale_Index_CurrencyConversionRate` | `` |  |
| checkbox |  | `Sale_Index_IsRecursive` | `` |  |
| combo |  | `Sale_Index_Frequency` | `FrequencyStore` | shows `Name` · value `Value` · pick-only |
| date field |  | `Sale_Index_Date` | `` | placeholder `Choose...` · format `UserDateFormat` |
| combo (+ add new) |  | `Sale_Index_SippingAddressLine1` | `vSale_CustomerAddressStore` | shows `Line1` · value `Line1` · placeholder `Choose...` |
| text field |  | `Sale_Index_SippingAddressLine2` | `` | placeholder `Choose...` |
| checkbox |  | `Sale_Index_ShipToOther` | `` |  |
| date field |  | `Sale_Index_ShipmentRequiredByDate` | `` | placeholder `Choose...` · format `UserDateFormat` |

#### Menus, buttons and other parts

- **button** “{"Manifest: ".concat(…)}” · id `r.get(…)` · on click `handler()`
- **component** · renders into `tdSale_Index_DefaultAccount` · store `vChartOfAccountsLinesStore` · shows `DisplayName` · value `Code` · placeholder `Choose...`
- **button** “{ssRec.get(…)}” · id `"ss".concat(…)` · on click `handler()`

### `CreditNote2019`

8 grids · 23 standalone fields · 0 windows · 12 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `divRealDimensions` · store `window.AccountingDimensionsRealTempStore` · placeholder `emptyMsgText`
- **grid** · renders into `divRelatedOrdersDetails` · store `RelatedOrdersStore` · placeholder `No related orders created.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Order | `TaskNumber` |  | flex 1 | renderer() |  |
    | Type | `TaskTypeName` |  | flex 1 | RenderHTMLText |  |
    | Order date | `OrderDate` |  | flex 1 | renderer() |  |
    | Status | `Status` |  | flex 1 | renderer() |  |
    | Total | `TotalAmount` |  | 130 | renderer() |  |

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

- **grid** · renders into `divCreditNoteLines` · placeholder `You do not have any credit note lines.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Description | `ProductCode` |  | flex 3 | renderer() |  |
    | Comment | `Comment` |  | flex 1 | renderer() | total count |
    | Unit | `UnitOfMeasure` |  | flex 1 | renderer() | hidden |
    | Quantity | `Quantity` |  | flex 1 |  | total sum |
    | Price | `Price` |  | flex 1 | renderer() |  |
    | Discount | `Discount` | number column | flex 1 | renderer() |  |
    | Tax rule | `TaxRule` |  | flex 1 | renderer() |  |
    | Account | `AccountCode` |  | flex 1 | renderer() |  |
    | Total | `Total` |  | 120 | renderer() | total sum |

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

- **grid** · renders into `divAttachmentList` · store `AttachmentsStore` · placeholder `You do not have any files attached.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Name | `FileName` |  | flex 2 | renderer() |  |
    | Date | `Date` |  | flex 1 | renderer() |  |
    | Attached by | `UserName` |  | flex 2 |  |  |
    | Processed | `IsProcessed` | check column | 80 | renderer() |  |

- **grid** · renders into `divTDetails` · store `TransactionsStore` · placeholder `No transactions created.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Effective date | `EffectiveDate` |  | flex 1 | renderer() |  |
    | Debit | `Debit` |  | flex 1 | Common_COA_TreeMode_RestoreDisplayName |  |
    | Credit | `Credit` |  | flex 1 | Common_COA_TreeMode_RestoreDisplayName |  |
    | Amount | `Amount` |  | 130 | renderer() |  |

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
| date field |  | `dtNewSaleGiftCardExpirationDate` | `` | placeholder `Choose...` · format `UserDateFormat` |
| combo |  | `cmbAvalaraTaxExemptionCode` | `vSale_AvalaraSaleTaxCodeStore` | shows `Name` · value `Code` · placeholder `Choose...` |
| combo |  | `cmbAvalaraTaxExemptionCode_NewAddress` | `vSale_AvalaraSaleTaxCodeStore` | shows `Name` · value `Code` · placeholder `Choose...` |
| date field |  | `WorkflowModal_dtWorkflowDate` | `` | format `UserDateFormat` |
| combo |  | `CreditNote_Index_Customer` | `vSale_CustomerStore` | shows `Name` · value `Name` · placeholder `type to search...` |
| combo (+ add new) |  | `CreditNote_Index_Contact` | `vSale_CustomerContactStore` | shows `Name` · value `Name` · placeholder `Choose...` |
| text field |  | `CreditNote_Index_Phone` | `` | placeholder `write...` |
| text field |  | `CreditNote_Index_Email` | `` | placeholder `write...` |
| combo (+ add new) |  | `CreditNote_Index_BillingAddressLine1` | `vSale_CustomerAddressStore` | shows `Line1` · value `Line1` · placeholder `Address` |
| text field |  | `CreditNote_Index_BillingAddressLine2` | `` | placeholder `City, state, country, zip` |
| combo |  | `CreditNote_Index_Tax` | `vTenantTaxationRuleStore` | shows `Description` · value `RuleID` · placeholder `Choose...` |
| checkbox |  | `CreditNote_Index_Tax_Inclusive` | `` |  |
| combo |  | `CreditNote_Index_PriceTier` | `vSalesPriceTiersStore` | shows `Name` · value `Code` · placeholder `Choose...` · pick-only |
| text field |  | `CreditNote_Index_CustomerReference` | `` |  |
| combo (+ add new) |  | `CreditNote_Index_SalesRepresentative` | `vTenantContactsStore` | shows `Name` · value `Name` · placeholder `Choose...` |
| numeric field |  | `tdCreditNote_Index_CurrencyConversionRate` | `` |  |
| date field |  | `CreditNote_Index_Date` | `` | placeholder `Choose...` · format `UserDateFormat` |
| combo |  | `CrNote_NewDeposit_Account` | `AccountCustomerCreditStore` | shows `DisplayName` · value `Code` · placeholder `Choose...` |
| date field |  | `CrNote_NewDeposit_DatePaid` | `` | placeholder `Choose...` · format `UserDateFormat` |
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
- **button** “{"Manifest: ".concat(…)}” · id `r.get(…)` · on click `handler()`
- **component** · renders into `tdCreditNote_Index_DefaultAccount` · store `vChartOfAccountsLinesStore` · shows `DisplayName` · value `Code` · placeholder `Choose...`
- **component** · id `cmpId` · renders into `renderTo` · store `localStore` · shows `name` · value `value` · placeholder `Choose...` · pick-only
- **column** “{attrSet.name}” · field `"CustomField".concat(…)`

### `CustomerEdit2019`

8 grids · 40 standalone fields · 0 windows · 15 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `CustomPrices_Container` · store `CustomPricesGridStore` · placeholder `There are no custom prices at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `ProductCode` |  | flex 2 | renderer() |  |
    | Latest price | `LatestPrice` |  | flex 1 | renderer() |  |
    | Custom price | `CustomPrice` | number column | flex 1 | renderer() |  |
    | Last sold | `LatestDate` |  | flex 1 | renderer() |  |

- **grid** · renders into `divAddressLines` · placeholder `No addresses found.`
  - *columns:*
    - *(component built elsewhere: `gridColumns`)*
- **grid** · renders into `divContactLines` · placeholder `No contacts found.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Name | `Name` |  | flex 1 | RenderHTMLText | total count |
    | Phone | `Phone` |  | flex 1 | RenderHTMLText |  |
    | Mobile phone | `MobilePhone` |  | flex 1 | RenderHTMLText |  |
    | Job title | `JobTitle` |  | flex 1 | RenderHTMLText |  |
    | Fax | `Fax` |  | flex 1 | RenderHTMLText |  |
    | Email | `Email` |  | flex 1 | RenderHTMLText |  |
    | Website | `Website` |  | flex 1 | RenderHTMLText |  |
    | Comment | `Comment` |  | flex 1 | renderer() |  |
    | Default | `IsDefault` | check column | flex 1 | renderer() |  |
    | Include in emails | `IncludeInEmail` | check column | flex 1 | renderer() |  |
    | Marketing consent | `MarketingConsent` |  | flex 1 | renderer() |  |

- **grid** · renders into `divSalesByProductLines` · store `vCustomerPurchasesStore` · placeholder `No products found.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | SKU | `ProductCode` |  | flex 1 | renderer() |  |
    | Product | `Name` |  | flex 1 | renderer() |  |
    | Customer name | `CustomerName` |  | flex 1 | renderer() |  |
    | Invoice # | `InvoiceNumber` |  | flex 1 | renderer() |  |
    | Date | `InvoiceDate` |  | flex 1 | renderer() |  |
    | Quantity | `Quantity` |  | flex 1 |  |  |
    | Price | `Price` |  | flex 1 | renderer() |  |

- **grid** · renders into `divSalesByDocumentLines` · store `vCustomerSaleTasksStore` · placeholder `No documents found.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Invoice # | `InvoiceNumber` |  | flex 1 | renderer() |  |
    | Quote/order # | `SaleOrderNumber` |  | flex 1 | renderer() |  |
    | Status | `Status` |  | flex 1 | renderer() |  |
    | Customer name | `CustomerName` |  | flex 1 | renderer() |  |
    | Customer reference | `CustomerReference` |  | flex 1 | renderer() |  |
    | Order date | `SaleOrderDate` |  | flex 1 | renderer() |  |
    | Ship by | `ShipmentRequiredByDate` |  | flex 1 | renderer() |  |
    | Invoice | `InvoiceAmount` |  | flex 1 | renderer() |  |
    | Paid | `PaidAmount` |  | flex 1 | renderer() |  |

- **grid** · renders into `Customer_Index_CustomerChildrenContainer` · store `customerChildrenListStore` · placeholder `You do not have children for this customer.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    |  | `` |  | flex 1 | renderer() | hidden |
    | Name | `Name` |  | flex 1 | renderer() |  |
    | Display Name | `DisplayName` |  | flex 1 | renderer() |  |
    | Sale Account | `SaleAccount` |  | flex 1 | renderer() |  |
    | Total Sales | `TotalSale` |  | flex 1 | renderer() |  |

- **grid** · renders into `gridInviteToB2BRecipients` · store `PortalInvitesStore` · placeholder `You do not have any contacts with emails at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    |  | `InvitationLink` |  |  | renderer() |  |
    | Portal | `PortalName` |  | flex 2 | RenderHTMLText |  |
    | Contact | `RecipientName` |  | flex 2 | RenderHTMLText |  |
    | Email | `RecipientEmail` |  | flex 2 | RenderHTMLText |  |
    | Status | `StatusDisplay` |  | flex 1 | renderer() |  |
    |  | `colActions` | action column | 150 | renderer() |  |

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
| combo |  | `tdCustomer_Index_Status` | `StatusStore` | shows `Name` · value `Value` · pick-only |
| combo |  | `tdCustomer_Index_Currency` | `currencyStore` | shows `Code` · value `Code` |
| combo (+ add new) |  | `tdCustomer_Index_PaymentTerm` | `vTenantPaymentTermStore` | shows `Name` · value `TermID` |
| combo |  | `tdCustomer_Index_AccountPayable` | `vChartOfAccountsStore` | shows `DisplayName` · value `Code` |
| combo |  | `tdCustomer_Index_SaleAccount` | `vChartOfAccountsForSaleAccountStore` | shows `DisplayName` · value `Code` |
| combo |  | `tdCustomer_Index_TaxRule` | `vTenantTaxationRuleStore` | shows `Description` · value `RuleID` |
| combo |  | `tdCustomer_Index_SalePriceTier` | `vSalesPriceTierStore` | shows `Name` · value `Code` |
| checkbox |  | `tdCustomer_Index_IsOnCreditHold` | `` |  |
| checkbox |  | `tdCustomer_Index_IsLegalEntity` | `` |  |
| checkbox |  | `tdCustomer_Index_BillParent` | `` |  |
| combo |  | `tdCustomer_Index_Parent` | `vCustomerParentStore` | shows `Name` · value `CustomerID` · placeholder `Select parent` |
| combo |  | `tdCustomer_Index_AddressCategory` | `AddressCategoryStore` | shows `Name` · value `Value` · pick-only |
| text field |  | `tdCustomer_Index_TaxNumber` | `` |  |
| number field |  | `tdCustomer_Index_Discount` | `` |  |
| number field |  | `tdCustomer_Index_CreditLimit` | `` |  |
| combo |  | `tdCustomer_Index_AttributeSet` | `AttributeSetStore` | shows `Name` · value `SetID` · pick-only |
| combo |  | `tdCustomer_Sales_By_Product_Search` | `vChildCustomerStore` | shows `ChildCustomerName` · value `ChildCustomerID` · placeholder `Search by children` · multi-select |
| combo |  | `tdCustomer_Sales_By_Document_Search` | `vChildCustomerStore` | shows `ChildCustomerName` · value `ChildCustomerID` · placeholder `Search by children` · multi-select |
| combo |  | `tdCustomer_Index_DefaultTemplate_SaleQuote` | `vSaleQuoteTemplateStore` | shows `Name` · value `TemplateID` · placeholder `choose...` |
| combo |  | `tdCustomer_Index_DefaultTemplate_SaleQuoteMatrix` | `vSaleQuoteMatrixTemplateStore` | shows `Name` · value `TemplateID` · placeholder `choose...` |
| combo |  | `tdCustomer_Index_DefaultTemplate_SalesOrder` | `vSalesOrderTemplateStore` | shows `Name` · value `TemplateID` · placeholder `choose...` |
| combo |  | `tdCustomer_Index_DefaultTemplate_SalesOrderMatrix` | `vSalesOrderMatrixTemplateStore` | shows `Name` · value `TemplateID` · placeholder `choose...` |
| combo |  | `tdCustomer_Index_DefaultTemplate_Invoice` | `vInvoiceTemplateStore` | shows `Name` · value `TemplateID` · placeholder `choose...` |
| combo |  | `tdCustomer_Index_DefaultTemplate_InvoiceMatrix` | `vInvoiceMatrixTemplateStore` | shows `Name` · value `TemplateID` · placeholder `choose...` |
| combo |  | `tdCustomer_Index_DefaultTemplate_PickList` | `vPickListTemplateStore` | shows `Name` · value `TemplateID` · placeholder `choose...` |
| combo |  | `tdCustomer_Index_DefaultTemplate_ExpandedPickList…` | `vExpandedPickListBOMTemplateStore` | shows `Name` · value `TemplateID` · placeholder `choose...` |
| combo |  | `tdCustomer_Index_DefaultTemplate_Receipt` | `vReceiptTemplateStore` | shows `Name` · value `TemplateID` · placeholder `choose...` |
| combo |  | `tdCustomer_Index_DefaultTemplate_PackingSlip` | `vPackingSlipTemplateStore` | shows `Name` · value `TemplateID` · placeholder `choose...` |
| combo |  | `tdCustomer_Index_DefaultTemplate_BoxLabel` | `vBoxLabelTemplateStore` | shows `Name` · value `TemplateID` · placeholder `choose...` |
| combo |  | `tdCustomer_Index_DefaultTemplate_CreditNote` | `vCreditNoteTemplateStore` | shows `Name` · value `TemplateID` · placeholder `choose...` |
| combo |  | `tdCustomer_Index_DefaultTemplate_GiftCards` | `vGiftCardsTemplateStore` | shows `Name` · value `TemplateID` · placeholder `choose...` |
| combo |  | `tdCustomer_Index_DefaultTemplate_WarrantyCertific…` | `vWarrantyCertificatesTemplateStore` | shows `Name` · value `TemplateID` · placeholder `choose...` |
| combo |  | `Customer_Index_PortalFilterCombobox` | `AvailablePortalsStore` | shows `Name` · value `ID` · placeholder `Choose Portal...` · pick-only |
| combo |  | `cmbAvalaraTaxExemptionCode_NewAddress` | `window.AvalaraSaleTaxCodeStore` | shows `Name` · value `Code` · placeholder `Choose...` |
| date field |  | `WorkflowModal_dtWorkflowDate` | `` | format `UserDateFormat` |
| text field |  | `renderTo` | `` |  |
| checkbox |  | `renderTo` | `` |  |
| numeric field |  | `renderTo` | `` |  |
| date field |  | `renderTo` | `` | placeholder `Choose...` · format `UserDateFormat` |

#### Menus, buttons and other parts

- **component** · renders into `tdCustomer_Index_DefaultSalesRepresentative` · store `vTenantContactStore` · shows `Name` · value `ContactID` · placeholder `Choose...`
- **component** · renders into `tdCustomer_Index_DefaultCarrier` · store `vTenantCarrierStore` · shows `Description` · value `CarrierID` · placeholder `Choose...`
- **component** · renders into `tdCustomer_Index_DefaultLocation` · store `vTenantLocationStore` · shows `Description` · value `LocationID` · placeholder `Choose...`
- **column** “Line 1” · field `Line1` · id `Line1_GridCustomer_Address_Lines`
- **column** “Line 2” · field `Line2` · id `Line2_GridCustomer_Address_Lines`
- **column** “City / Suburb” · field `CitySuburb` · id `CitySuburb_GridCustomer_Address_Lines`
- **column** “State / Province” · field `StateProvince` · id `StateProvince_GridCustomer_Address_Lines`
- **column** “ZIP / postcode” · field `ZipPostCode` · id `ZipPostCode_GridCustomer_Address_Lines`
- **column** “Country” · field `Country` · id `Country_GridCustomer_Address_Lines`
- **column** “Type” · field `Type` · id `Type_GridCustomer_Address_Lines`
- **check column** “Default for type” · field `DefaultForType` · id `DefaultForType_GridCustomer_Address_Lines`
- **check column** “Is Parent” · field `IsParent` · id `IsParent_GridCustomer_Address_Lines`
- **column** “Tax exemptionreason code” · field `TaxExemptionReasonCode` · id `colAvalaraTaxExemptionReason`
- **component** · id `cmpId` · renders into `renderTo` · store `localStore` · shows `name` · value `value` · placeholder `Choose...` · pick-only
- **column** “{attrSet.name}” · field `"CustomField".concat(…)`

### `CustomerList2019`

4 grids · 0 standalone fields · 0 windows · 0 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · id `MergeCustomersGrid` · renders into `MergeCustomerGridContainer` · store `selectedStore`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    |  | `Name` |  | flex 1 | renderer() |  |

- **grid** · id `Grid` · renders into `CustomerList_Index_Container` · store `mainStore`
- **grid** · renders into `divAllocatedDetailsGridContainer` · store `vAllocatedStore`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Document # | `DocNumber` |  | flex 1 | renderer() |  |
    | Date paid | `Date` |  | flex 1 | renderer() |  |
    | Allocated amount | `Amount` |  | flex 1 | renderer() |  |

- **grid** · renders into `CustomerCredits_Index_Container` · store `SaleCreditWithDetailStore`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    |  | `` |  | flex 1 | renderer() | hidden |
    | Customer | `CustomerName` |  | flex 3 | renderer() |  |
    | Date | `Date` |  | flex 1 | renderer() |  |
    | Amount/balance | `Amount` |  | flex 2 | renderer() |  |
    | Created as/by | `Description` |  | flex 2 |  |  |


### `CustomerPayment2019`

1 grids · 11 standalone fields · 0 windows · 9 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `divContainer` · store `store`

#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| combo |  | `tdCustomer` | `vCustomerStore` | shows `Name` · value `CustomerID` |
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

- **column** “Invoice #” · field `InvoiceNumber` · id `colInvoiceNumber`
- **date column** “Invoice date” · field `InvoiceDate` · id `colInvoiceDate` · format `UserDateFormat`
- **column** “Quoteorder #” · field `SONumber` · id `colSONumber`
- **column** “Saleschannel” · field `SourceChannel` · id `colSourceChannel`
- **column** “Invoice amount” · field `InvoiceAmount` · id `colInvoiceAmount`
- **column** “Paid to date” · field `PaidAmount` · id `colPaidAmount`
- **column** “Due amount” · field `DueAmount` · id `colDueAmount`
- **column** “Overdue” · field `DaysOverdue` · id `colDaysOverdue`
- **column** “Pay amount” · field `AllocatedAmount` · id `colAllocatedAmount`

### `DiscountNew2019`

1 grids · 0 standalone fields · 0 windows · 0 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `DiscountNew_QuantityBasedGrid` · placeholder `No discount lines added.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Up to | `MaxValue` |  | flex 1 |  |  |
    | Type of discount | `Type` |  | flex 1 | renderer() |  |
    | Amount | `Amount` |  | flex 1 | renderer() |  |


### `FulfilmentOrder2019`

4 grids · 10 standalone fields · 0 windows · 0 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `divItemsLines` · store `FulfillmentOrderItemsStore` · placeholder `No fulfillment order items found.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `ProductID` |  | flex 4 | renderer() |  |
    | SKU | `SKU` |  | flex 2 | RenderHTMLText |  |
    | Fulfillment SKU | `FFSKU` |  | flex 2 | RenderHTMLText |  |
    | Quantity | `Quantity` |  | flex 1 |  |  |
    | Comment | `Comment` |  | flex 2 | RenderHTMLText |  |

- **grid** · renders into `divLogLines` · store `FulfillmentOrderLogStore` · placeholder `No log record for this fulfillment order found.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Date | `LogDate` |  | flex 1 | renderer() |  |
    | Information | `ChangesText` |  | flex 3 | renderer() |  |
    | User | `ChangedBy` |  | flex 1 |  |  |

- **grid** · renders into `divTrackingLines` · store `FulfillmentOrderTrackingInfoStore` · placeholder `No tracking information for the fulfillment order found.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Carrier | `Carrier` |  | flex 2 | renderer() |  |
    | Tracking number | `TrackingNumber` |  | flex 2 | RenderHTMLText |  |
    | Delivery status | `Status` |  | flex 1 |  |  |
    | Additional information | `AdditionalInfo` |  | flex 3 |  |  |

- **grid** · renders into `divTrackingDetails` · store `dynamicHistoryStore` · placeholder `No tracking details for the fulfillment order found.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Date | `Date` |  | flex 2 |  |  |
    | Place | `Place` |  | flex 3 | RenderHTMLText |  |
    | Information | `Info` |  | flex 6 |  |  |


#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| text field |  | `tdFulfillmentOrder_Index_RecievedDate` | `` | pick-only |
| text field |  | `tdFulfillmentOrder_Index_ShipDate` | `` | pick-only |
| text field |  | `tdFulfillmentOrder_Index_ArrivalDate` | `` | pick-only |
| text field |  | `tdFulfillmentOrder_Index_CustomerName` | `` | pick-only |
| text field |  | `tdFulfillmentOrder_Index_Date` | `` | pick-only |
| combo |  | `tdFulfillmentOrder_Index_Shipping` | `ShippingMethodStore` | shows `Name` · value `ID` · placeholder `Select the shipping method...` · pick-only |
| text field |  | `tdFulfillmentOrder_Index_ShipmentName` | `` | pick-only |
| text field |  | `tdFulfillmentOrder_Index_ShipmentPhone` | `` | pick-only |
| text field |  | `tdFulfillmentOrder_Index_ShippingLine2` | `` | pick-only |
| combo |  | `tdFulfillmentOrder_EditAddress_Country` | `countryStore` | shows `Name` · value `Name` · placeholder `Select a country...` |

### `FulfilmentOrderList2019`

1 grids · 0 standalone fields · 0 windows · 0 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `FulfillmentOrderList_Index_Container` · store `mainStore`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    |  | `` |  | flex 1 | renderer() | hidden |
    | Status | `Status` |  | flex 1 | renderer() |  |
    | Location | `Location` |  | flex 1 | renderer() |  |
    | Order # | `FFOrderId` |  | flex 1 | renderer() |  |
    | Order date | `Date` |  | flex 1 | renderer() |  |
    | Sale | `SaleOrderNumber` |  | flex 1 | renderer() |  |


### `RMA2019`

7 grids · 34 standalone fields · 0 windows · 0 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `divRelatedOrdersDetails` · store `RelatedOrdersStore` · placeholder `No related orders created.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Order | `TaskNumber` |  | flex 1 | renderer() |  |
    | Type | `TaskTypeName` |  | flex 1 | RenderHTMLText |  |
    | Order date | `OrderDate` |  | flex 1 | renderer() |  |
    | Status | `Status` |  | flex 1 | renderer() |  |
    | Total | `TotalAmount` |  | 130 | renderer() |  |

- **grid** · renders into `divAdditionalCharges` · store `rmaGroupedAdditionalCharges` · placeholder `No inspection/repair costs.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Expenses | `CostTypeName` |  | flex 2 | renderer() |  |
    | Comment | `Comment` |  | flex 4 | renderer() |  |
    | Total | `Total` |  | flex 1 | renderer() |  |

- **grid** · renders into `divRMAResolution` · store `rmaResolution` · placeholder `No RMA resolutions have been found.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Return order resolution | `ReturnOrderResolution` |  | flex 1 | renderer() |  |
    | QTY | `Quantity` |  | 55 | renderer() |  |
    | RMA resolution | `Resolution` |  | flex 1 | renderer() |  |
    | Cost | `Cost` |  | 90 | renderer() |  |
    | Invoiced expenses | `AdditionalCharges` |  | 90 | renderer() |  |
    | Comment | `Comments` |  | flex 1 | renderer() |  |
    | Sales total | `Total` |  | 90 | renderer() |  |

- **grid** · renders into `divRMARelatedOrders` · store `rmaRelatedOrders` · placeholder `No related orders have been found.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Order | `RelatedTaskType` |  | flex 2 | renderer() |  |
    | Type | `RelatedTaskType` |  | flex 3 | renderer() |  |
    | Order date | `Date` |  | flex 2 | renderer() |  |
    | Status | `Status` |  | flex 2 | renderer() |  |
    | Invoice | `InvoiceNumber` |  | flex 2 | renderer() |  |

- **grid** · renders into `divAttachmentList` · store `window.rmaAttachmentsStore` · placeholder `You do not have any files attached.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Name | `FileName` |  | flex 2 | renderer() |  |
    | Date | `Date` |  | flex 1 | renderer() |  |
    | Attached by | `UserName` |  | flex 2 | RenderHTMLText |  |
    | Processed | `IsProcessed` | check column | 80 | renderer() |  |

- **grid** · renders into `RMAList_Index_Container` · store `vRMAListStore` · placeholder `You do not have any RMA at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | RMA# | `Number` |  | flex 1 | renderer() |  |
    | SO# | `SaleOrderNumber` |  | flex 1 | renderer() |  |
    | SO Ref | `SaleOrderCustomerReference` |  | flex 1 | renderer() |  |
    | Customer | `CustomerName` |  | flex 1 | renderer() |  |
    | Created | `CreatedDate` |  | flex 1 | renderer() |  |
    | Expired | `ExpiredDate` |  | flex 1 | renderer() |  |
    | RMA status | `Status` |  | flex 1 | RMA_BuildStatus |  |

- **grid** · renders into `RMAProductsList_Index_Container` · store `vRMAProductsListStore` · placeholder `You do not have any RMA at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | RMA#RO# | `RMANumber` |  | flex 2 | renderer() |  |
    | SO#Ref | `SaleOrderNumber` |  | flex 2 | renderer() |  |
    | Customer | `CustomerName` |  | flex 2 | RenderHTMLText |  |
    | CreatedExpired | `CreatedDate` |  | flex 2 | renderer() |  |
    | RMA status | `RMAStatus` |  | flex 2 | RMA_BuildStatus |  |
    | RO status | `ROStatus` |  | flex 2 | renderer() |  |
    | Product | `ProductID` |  | flex 3 | renderer() |  |
    | RMA product status | `RMAProductStatus` |  | flex 1 | renderer() |  |
    | RO received | `IsReceived` |  | 75 | renderer() |  |
    | Receipt action | `ReceiptAction` |  | flex 1 | RenderHTMLText |  |
    | Job# | `JobID` |  | flex 2 | renderer() |  |
    | RO resolution | `ROResolution` |  | flex 2 | RenderHTMLText |  |
    | RMA resolution | `RMAResolution` |  | flex 2 | RenderHTMLText |  |
    | RMA resolution status | `RMAResolutionStatus` |  | flex 2 | renderer() |  |


#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| combo |  | `inputId` | `AutocompleteAddressField.prototype.AddressInfoSto…` | shows `description` · value `place_id` · placeholder `Look up an address` |
| date field |  | `RMA_CreatedDate` | `` | placeholder `Select date` · format `UserDateFormat` |
| date field |  | `RMA_ExpiredDate` | `` | placeholder `Select date` · format `UserDateFormat` |
| combo |  | `RMA_ReceiptsLocation` | `vLocationStore` | shows `Description` · value `LocationID` · placeholder `Choose...` |
| text field |  | `RMA_Customer` | `` | disabled |
| combo |  | `RMA_Contact` | `CustomerContactStore` | shows `Name` · value `ContactID` |
| text field |  | `RMA_Phone` | `` |  |
| text field |  | `RMA_Email` | `` |  |
| text field |  | `RMA_ShipToCompany` | `` |  |
| text field |  | `RMA_ShipToContact` | `` |  |
| checkbox |  | `ShipToOther` | `` |  |
| combo (+ add new) |  | `ShippingAddressLine1` | `CustomerAddressStore` | shows `Line1` · value `AddressID` · placeholder `Choose...` |
| text field |  | `ShippingAddressLine2` | `` | placeholder `Choose...` · disabled |
| checkbox |  | `dropShip` | `` |  |
| combo |  | `SupplierName` | `rmaSupplierStore` | shows `Name` · value `SupplierID` · placeholder `Choose...` |
| combo |  | `SupplierShippingAddressLine1` | `window.rmaDropshipSupplierAddresses` | shows `Line1` · value `ShipToLine1` · placeholder `Choose...` |
| text field |  | `SupplierShippingAddressLine2` | `` | placeholder `Choose...` · disabled |
| date field |  | `containerId` | `` | placeholder `Select date` · format `UserDateFormat` |
| combo |  | `divRMASearchOrderNumbers` | `vRMAListOrderInvoiceNumbersStore` | shows `Number` · value `Number` · placeholder `Sales order no., invoice no., sale refe…` |
| text field |  | `RMA_NewAddress_Line1` | `` |  |
| text field |  | `RMA_NewAddress_Line2` | `` |  |
| text field |  | `RMA_NewAddress_CitySuburb` | `` |  |
| combo |  | `RMA_NewAddress_Country` | `window.countryStore` | shows `Name` · value `Name` · placeholder `Choose...` |
| text field |  | `RMA_NewAddress_StateProvince` | `` |  |
| text field |  | `RMA_NewAddress_ZipPostCode` | `` |  |
| text field |  | `RMA_NewAddress_Type` | `` | disabled |
| combo |  | `RMA_Index_Ship_Another_Customer` | `CustomerStore` | shows `Name` · value `Name` · placeholder `type to search...` |
| combo |  | `RMA_Index_SippingAnotherAddressLine` | `CustomerAddressStore` | shows `Line1` · value `AddressID` · placeholder `Choose...` |
| text field |  | `RMA_EditAddress_Line1` | `` |  |
| text field |  | `RMA_EditAddress_Line2` | `` |  |
| text field |  | `RMA_EditAddress_CitySuburb` | `` |  |
| text field |  | `RMA_EditAddress_StateProvince` | `` |  |
| text field |  | `RMA_EditAddress_ZipPostCode` | `` |  |
| combo |  | `RMA_Index_Countries` | `window.countryStore` | shows `Name` · value `Code` · placeholder `Select country` |

### `RMAReturnOrder2019`

8 grids · 21 standalone fields · 0 windows · 0 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `divRelatedOrdersDetails` · store `RelatedOrdersStore` · placeholder `No related orders created.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Order | `TaskNumber` |  | flex 1 | renderer() |  |
    | Type | `TaskTypeName` |  | flex 1 | RenderHTMLText |  |
    | Order date | `OrderDate` |  | flex 1 | renderer() |  |
    | Status | `Status` |  | flex 1 | renderer() |  |
    | Total | `TotalAmount` |  | 130 | renderer() |  |

- **grid** · renders into `RMAList_Index_Container` · store `window.RMAReturnOrderListStore` · placeholder `You do not have any return orders at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Order # | `Number` |  | flex 1 | renderer() |  |
    | RMA # | `RmaNumber` |  | flex 1 | renderer() |  |
    | Customer | `CustomerName` |  | flex 1 | renderer() |  |
    | Order date | `CreatedDate` |  | flex 1 | renderer() |  |
    | RMA date | `RmaDate` |  | flex 1 | renderer() |  |
    | Location | `ReceiptsLocationName` |  | flex 1 | renderer() |  |
    | Receive status | `ReceiveStatus` |  | flex 1 | RO_List_RenderStatus |  |
    | RO status | `Status` |  | flex 1 | RO_List_RenderStatus |  |
    | RO resolution status | `ResolutionStatus` |  | flex 1 | RO_List_RenderStatus |  |

- **grid** · renders into `divMilestones2` · store `returnOrderMilestones2` · placeholder `No milestones.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Expense task | `TaskType` |  | flex 1 | renderer() |  |
    | Milestone | `MilestoneName` |  | flex 1 | renderer() |  |
    | Date | `Date` |  | flex 1 | renderer() |  |
    | Expense amount | `Amount` |  | flex 1 | renderer() |  |

- **grid** · renders into `divRestockTransferOrder` · store `rmaResolution` · placeholder `You do not have any restock tasks at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Add product to restock | `TransferOrder` |  | flex 3 | renderer() |  |
    | Quantity | `Quantity` |  | flex 2 | renderer() |  |
    | Batch/serial no. | `BatchSerialNo` |  | flex 2 | renderer() |  |
    | Comments | `Comments` |  | flex 3 | renderer() |  |
    | Status | `Status` |  | flex 2 | renderer() |  |

- **grid** · renders into `divRestockNoTransferOrder` · store `rmaResolution` · placeholder `You do not have any restock tasks at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Location to | `LocationID` |  | flex 1 | renderer() |  |
    | Restock as | `RestockToProductID` |  | flex 1 | renderer() |  |
    | QTY | `Quantity` |  | 55 | renderer() |  |
    | Status | `Status` |  | flex 1 | renderer() |  |
    | Restock date | `EffectiveDate` | date column | 110 | renderer() · edit: date field |  |
    | Comments | `Comments` |  | flex 1 | renderer() |  |

- **grid** · renders into `divScrap` · store `rmaResolution` · placeholder `No scraps.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Location | `LocationName` |  | flex 2 | renderer() |  |
    | Batch/serial | `BatchSerialNo` |  | flex 2 | renderer() |  |
    | Expense account | `ExpenseAccountName` |  | flex 3 | renderer() |  |
    | Effective date | `EffectiveDate` | date column | flex 2 | renderer() · edit: date field |  |
    | QTY | `Quantity` |  | 55 | renderer() |  |
    | Cost | `Cost` |  | 90 | renderer() |  |
    | Total | `Total` |  | 90 | renderer() |  |

- **grid** · renders into `divRMAReturnOrderRelatedOrders` · store `rmaRelatedOrders` · placeholder `No related orders have been found.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Order | `RelatedTaskType` |  | flex 2 | renderer() |  |
    | Type | `RelatedTaskType` |  | flex 3 | renderer() |  |
    | Order date | `Date` |  | flex 2 | renderer() |  |
    | Status | `Status` |  | 110 | renderer() |  |
    | Invoice | `InvoiceNumber` |  | flex 2 | renderer() |  |

- **grid** · renders into `divAttachmentList` · store `window.rmaReturnOrderAttachmentsStore` · placeholder `You do not have any files attached.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Name | `FileName` |  | flex 2 | renderer() |  |
    | Date | `Date` |  | flex 1 | renderer() |  |
    | Attached by | `UserName` |  | flex 2 | RenderHTMLText |  |
    | Processed | `IsProcessed` | check column | 80 | renderer() |  |


#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| date field |  | `RMA_CreatedDate` | `` | placeholder `Select date` · format `UserDateFormat` · disabled |
| text field |  | `RMA_ReceiptsLocation` | `` | disabled |
| combo |  | `RMA_Customer` | `CustomerStore` | shows `Name` · value `CustomerID` · placeholder `Choose...` · disabled |
| combo |  | `RMA_Index_Ship_Another_Customer` | `CustomerStore` | shows `Name` · value `Name` · placeholder `type to search...` · disabled |
| combo |  | `RMA_Contact` | `CustomerContactStore` | shows `Name` · value `ContactID` · placeholder `Choose...` · disabled |
| text field |  | `RMA_ShipToCompany` | `` | disabled |
| text field |  | `RMA_ShipToContact` | `` | disabled |
| checkbox |  | `ShipToOther` | `` | disabled |
| combo (+ add new) |  | `ShippingAddressLine1` | `CustomerAddressStore` | shows `Line1` · value `Line1` · placeholder `Choose...` · disabled |
| combo |  | `RMA_Index_SippingAnotherAddressLine` | `CustomerAddressStore` | shows `Line1` · value `Line1` · placeholder `Choose...` · disabled |
| text field |  | `ShippingAddressLine2` | `` | placeholder `Choose...` · disabled |
| combo |  | `RMA_Index_Countries` | `countryStore` | shows `Name` · value `Name` · placeholder `Select country` · disabled |
| combo |  | `RMA_JobResolution` | `jobResolutionStore` | shows `name` · value `name` · placeholder `Choose...` · pick-only |
| combo |  | `inputId` | `AutocompleteAddressField.prototype.AddressInfoSto…` | shows `description` · value `place_id` · placeholder `Look up an address` |
| combo |  | `tdRO_NewProduct_Supplier` | `SupplierStore` | shows `Name` · value `SupplierID` · placeholder `type to search...` |
| date field |  | `"RMA_ReturnOrderRecievedDateProduct-".concat(…)` | `` | placeholder `Select date` · format `UserDateFormat` |
| text field |  | `renderTo` | `` |  |
| combo |  | `renderTo` | `localStore` | shows `name` · value `value` · placeholder `Choose...` · pick-only |
| checkbox |  | `renderTo` | `` |  |
| numeric field |  | `renderTo` | `` |  |
| date field |  | `renderTo` | `` | placeholder `Choose...` · format `UserDateFormat` |

### `RecurringInvoices2019`

1 grids · 0 standalone fields · 0 windows · 0 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `divInvoices` · store `store` · placeholder `You do not have any recurring tasks.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Customer | `Customer` |  | flex 1 | renderer() |  |
    | Invoice number | `InvoiceNumber` |  | flex 1 | renderer() |  |
    | Invoice total | `Total` |  | flex 1 | renderer() |  |
    | Frequency | `Frequency` |  | flex 1 | renderer() |  |
    | Next invoice date | `NextInvoiceDate` | date column | flex 1 | renderer() · edit: date field |  |
    |  | `` |  | flex 1 | renderer() | hidden |


### `SaleMultiple2019`

33 grids · 67 standalone fields · 0 windows · 44 menus, buttons and other parts · 0 custom components

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
- **grid** · renders into `divRelatedOrdersDetails` · store `RelatedOrdersStore` · placeholder `No related orders created.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Order | `TaskNumber` |  | flex 1 | renderer() |  |
    | Type | `TaskTypeName` |  | flex 1 | RenderHTMLText |  |
    | Order date | `OrderDate` |  | flex 1 | renderer() |  |
    | Status | `Status` |  | flex 1 | renderer() |  |
    | Total | `TotalAmount` |  | 130 | renderer() |  |

- **grid** · renders into `divAdditionalTransactionsContainer` · placeholder `No manual journals`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Debit | `Debit` |  | flex 1 | renderer() |  |
    | Credit | `Credit` |  | flex 1 | renderer() |  |
    | Reference | `Reference` |  | flex 1 | renderer() |  |
    | Date | `Date` | date column | flex 1 | edit: date field |  |
    | Amount | `Amount` |  | flex 1 | renderer() |  |

- **grid** · renders into `divCreditNoteLines` · placeholder `No credit note lines.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `ProductCode` |  | flex 3 | renderer() |  |
    | Comment | `Comment` |  | flex 1 | renderer() |  |
    | Unit | `UnitOfMeasure` |  | flex 1 | renderer() | hidden |
    | Quantity | `Quantity` |  | flex 1 |  | total sum |
    | Price | `Price` |  | flex 1 | renderer() |  |
    | Discount | `Discount` | number column | flex 2 | renderer() |  |
    | Account | `AccountCode` |  | flex 1 | renderer() |  |
    | Total | `Total` |  | flex 1 | renderer() | total sum |

- **grid** · renders into `divCreditNoteAdditionalChargesLines` · placeholder `No additional charges.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Additional charges / services | `Description` |  | flex 3 | renderer() |  |
    | Comment | `Comment` |  | flex 1 | renderer() |  |
    | Quantity | `Quantity` |  | flex 1 |  |  |
    | Price | `Amount` |  | flex 1 | renderer() |  |
    | Tax rule | `TaxRule` |  | flex 1 | renderer() |  |
    | Discount | `Discount` | number column | flex 1 | renderer() |  |
    | Account | `AccountCode` |  | flex 1 | renderer() |  |
    | Total | `Total` |  | flex 1 | renderer() |  |

- **grid** · renders into `divCreditNotePayments` · placeholder `No refunds.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Refund to account | `AccountCode` |  | flex 2 | renderer() |  |
    | Reference | `Reference` |  | flex 2 | renderer() |  |
    | Date paid | `DatePaid` | date column | flex 1 | edit: date field |  |
    | Amount | `Amount` |  | flex 1 | renderer() |  |
    | Conversion rate | `CurrencyConversionRate` |  | flex 1 | renderer() |  |
    | Base amount | `Amount` |  | flex 1 | renderer() |  |

- **grid** · renders into `divRestockLines` · placeholder `No items to restock.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product to restock | `ProductCode` |  | flex 3 | renderer() |  |
    | Batch/serial no. | `BatchSN` |  | flex 1 | renderer() |  |
    | Expiry date | `ExpiryDate` |  | flex 1 | renderer() |  |
    | Unit | `UnitOfMeasure` |  | flex 1 | renderer() | total count |
    | Quantity | `Quantity` |  | flex 1 |  | total sum |
    | Sale location | `LocationID` |  | flex 1 | renderer() |  |
    | Restock location | `RestockLocationID` |  | flex 1 | renderer() |  |
    | Date | `RestockDate` | date column | flex 1 | edit: date field |  |

- **grid** · renders into `divInvoiceLines` · placeholder `No invoice lines.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `ProductCode` |  | flex 2 | renderer() |  |
    | Comment | `Comment` |  | flex 1 | renderer() | total count |
    | Unit | `UnitOfMeasure` |  | flex 1 | renderer() | hidden |
    | Quantity | `Quantity` |  | 80 |  | total sum |
    | Price | `Price` |  | flex 1 | renderer() |  |
    | Discount | `Discount` |  | flex 1 | renderer() |  |
    | Tax rule | `TaxRule` |  | flex 1 | renderer() |  |
    | Margin | `AverageCost` |  | flex 1 | renderer() |  |
    | Account | `AccountCode` |  | flex 1 | renderer() |  |
    | Total | `Total` |  | flex 1 | renderer() | total sum |

- **grid** · renders into `divInvoiceAdditionalChargesLines` · placeholder `No additional charges`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Additional charges / services | `Description` |  | flex 2 | renderer() |  |
    | Comment | `Comment` |  | flex 1 | renderer() |  |
    | Quantity | `Quantity` |  | flex 1 |  |  |
    | Price | `Amount` |  | flex 1 | renderer() |  |
    | Discount | `Discount` | number column | flex 1 | renderer() |  |
    | Tax rule | `TaxRule` |  | flex 1 | renderer() |  |
    | Account | `AccountCode` |  | flex 1 | renderer() |  |
    | Total | `Total` |  | flex 1 | renderer() |  |

- **grid** · renders into `divInvoicePayments` · placeholder `No payments`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Account | `AccountCode` |  | flex 1 | renderer() |  |
    | Reference | `Reference` |  | flex 2 | renderer() |  |
    | Date paid | `DatePaid` | date column | flex 1 | edit: date field |  |
    | Amount | `Amount` |  | flex 1 | renderer() |  |
    | Conversion rate | `CurrencyConversionRate` |  | flex 1 | renderer() |  |
    | Base amount | `Amount` |  | flex 1 | renderer() |  |
    | Status | `Status` |  | flex 1 | renderer() |  |

- **grid** · renders into `divMultInvoiceDeposits` · placeholder `No customer credits.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Account | `AccountCode` |  | flex 2 | renderer() |  |
    | Reference | `Reference` |  | flex 2 | renderer() |  |
    | Date paid | `DatePaid` | date column | flex 1 | edit: date field |  |
    | Amount | `Amount` |  | flex 1 | renderer() |  |
    | Conversion rate | `CurrencyConversionRate` |  | flex 1 | renderer() |  |
    | Base amount | `Amount` |  | flex 1 | renderer() |  |

- **grid** · renders into `SaleMult_NewAllocation_Credits` · store `vSaleCreditStore` · placeholder `No credits/deposits found for the selected customer.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Date | `Date` |  | flex 2 | renderer() |  |
    | Description | `Description` |  | flex 5 |  |  |
    | Remaining / total | `Amount` |  | flex 3 | renderer() |  |

- **grid** · renders into `SaleMult_NewAllocation_CreditNotes` · store `CreditNotesStore` · placeholder `No credits notes found for the selected customer.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Credit note # | `Description` |  | flex 5 | renderer() |  |
    | Date | `Date` |  | flex 2 | renderer() |  |
    | Remaining / total | `Amount` |  | flex 3 | renderer() |  |

- **grid** · renders into `SaleMult_NewAllocation_Allocations` · store `dialogSelectedStore` · placeholder `No selected customer credits/deposits.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Date | `Date` |  | flex 2 | renderer() |  |
    | Description | `Description` |  | flex 4 | renderer() |  |
    | Available to allocate | `RemainingAmount` |  | flex 2 | renderer() |  |
    | Allocated | `AllocatedAmount` |  | flex 2 | renderer() |  |

- **grid** · renders into `divShippingOptionsGrid` · store `SSStore`
  - *columns:*
    - *(component built elsewhere: `columns`)*
- **grid** · renders into `divQuoteLines` · placeholder `No sale quote lines.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `ProductCode` |  | flex 3 | renderer() |  |
    | Comment | `Comment` |  | flex 1 | renderer() |  |
    | Unit | `UnitOfMeasure` |  | flex 1 | renderer() | hidden |
    | Quantity | `Quantity` |  | 80 |  | total sum |
    | Price | `Price` |  | flex 1 | renderer() |  |
    | Discount | `Discount` | number column | flex 1 | renderer() |  |
    | Tax rule | `TaxRule` |  | flex 1 | renderer() |  |
    | Margin | `AverageCost` |  | flex 1 | renderer() |  |
    | Total | `Total` |  | flex 1 | renderer() | total sum |

- **grid** · renders into `divQuoteAdditionalChargesLines` · placeholder `No additional charges in your sale quote.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Additional charges / services | `Description` |  | flex 3 | renderer() |  |
    | Comment | `Comment` |  | flex 1 | renderer() |  |
    | Quantity | `Quantity` |  | flex 1 |  |  |
    | Price | `Amount` |  | flex 1 | renderer() |  |
    | Discount | `Discount` | number column | flex 1 | renderer() |  |
    | Tax rule | `TaxRule` |  | flex 1 | renderer() |  |
    | Total | `Total` |  | flex 1 | renderer() |  |

- **grid** · renders into `divDeposits` · placeholder `No customer credits.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Account | `AccountCode` |  | flex 2 | renderer() |  |
    | Reference | `Reference` |  | flex 2 | renderer() |  |
    | Date paid | `DatePaid` | date column | flex 1 | edit: date field |  |
    | Amount | `Amount` |  | flex 1 | renderer() |  |
    | Conversion rate | `CurrencyConversionRate` |  | flex 1 | renderer() |  |
    | Base amount | `Amount` |  | flex 1 | renderer() |  |

- **grid** · renders into `UploadSaleQuoteLinesExceptionsGrid` · store `QuoteLinesUploadErrorsStore2` · placeholder `Please upload a file to check for issues.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Line # | `Line` |  | 50 |  |  |
    | Product SKU | `SKU` |  | 150 | renderer() |  |
    | Product name | `Name` |  | 250 | renderer() |  |
    | Quantity | `Quantity` |  | 100 | renderer() |  |
    | Price | `Price` |  | 100 | renderer() |  |
    | Discount | `Discount` |  | 100 | renderer() |  |

- **grid** · renders into `divOrderLines` · placeholder `No sale order lines.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `ProductCode` |  | flex 3 | renderer() |  |
    | Comment | `Comment` |  | flex 1 | renderer() |  |
    | Unit | `UnitOfMeasure` |  | flex 1 | renderer() | hidden |
    | Quantity | `Quantity` |  | 80 |  | total sum |
    | Price | `Price` |  | flex 1 | renderer() |  |
    | Discount | `Discount` | number column | flex 1 | renderer() |  |
    | Tax rule | `TaxRule` |  | flex 1 | renderer() |  |
    | Margin | `AverageCost` |  | flex 1 | renderer() |  |
    | Total | `Total` |  | flex 1 | renderer() | total sum |
    | Drop ship | `DropShip` | check column | 80 | renderer() |  |

- **grid** · renders into `divOrderAdditionalChargesLines` · placeholder `No additional charges in your sale order.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Additional charges / services | `Description` |  | flex 3 | renderer() |  |
    | Comment | `Comment` |  | flex 1 | renderer() |  |
    | Quantity | `Quantity` |  | flex 1 |  |  |
    | Price | `Amount` |  | flex 1 | renderer() |  |
    | Discount | `Discount` | number column | flex 1 | renderer() |  |
    | Tax rule | `TaxRule` |  | flex 1 | renderer() |  |
    | Total | `Total` |  | flex 1 | renderer() |  |

- **grid** · renders into `UploadSaleOrderLinesExceptionsGrid` · store `SOLinesUploadErrorsStore` · placeholder `Please upload a file to check for issues.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Line # | `Line` |  | 50 |  |  |
    | Product SKU | `SKU` |  | 150 | renderer() |  |
    | Product name | `Name` |  | 250 | renderer() |  |
    | Quantity | `Quantity` |  | 100 | renderer() |  |
    | Price | `Price` |  | 100 | renderer() |  |
    | Discount | `Discount` |  | 100 | renderer() |  |

- **grid** · renders into `divMultOrderDeposits` · placeholder `No customer credits.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Account | `AccountCode` |  | flex 2 | renderer() |  |
    | Reference | `Reference` |  | flex 2 | renderer() |  |
    | Date paid | `DatePaid` | date column | flex 1 | edit: date field |  |
    | Amount | `Amount` |  | flex 1 | renderer() |  |
    | Conversion rate | `CurrencyConversionRate` |  | flex 1 | renderer() |  |
    | Base amount | `Amount` |  | flex 1 | renderer() |  |

- **grid** · renders into `divPackLines` · placeholder `Please provide the packing information.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `ProductCode` |  | flex 3 | renderer() |  |
    | Unit | `UnitOfMeasure` |  | flex 1 | renderer() | hidden |
    | Location | `LocationID` |  | flex 1 | renderer() |  |
    | Batch/serial no. | `BatchSN` |  | flex 1 | renderer() |  |
    | Expiry date | `ExpiryDate` |  | flex 1 | renderer() | total count |
    | Quantity | `Quantity` |  | flex 1 |  | total sum |
    | Package# | `BoxNumber` |  | flex 1 | RenderHTMLText |  |
    | Warranty | `WarrantySetupName` |  | flex 1 | RenderHTMLText |  |
    | Registration# | `WarrantyRegistrationNumber` |  | flex 2 | renderer() |  |

- **grid** · renders into `divPickLines` · placeholder `No picks`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `ProductCode` |  | flex 3 | renderer() |  |
    | Batch/serial no. | `BatchSN` |  | flex 1 | renderer() |  |
    | Expiry date | `ExpiryDate` |  | flex 1 | renderer() |  |
    | Unit | `UnitOfMeasure` |  | flex 1 | renderer() | total count |
    | Quantity | `Quantity` |  | flex 1 |  | total sum |
    | Location | `LocationID` |  | flex 1 | renderer() |  |

- **grid** · renders into `divFulfillmentLines` · store `FulfillmentStore` · placeholder `No fulfillment orders were created for this sale.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Date created | `Date` |  | flex 1 | renderer() |  |
    | Shipping method | `ShippingMethod` |  | flex 1 | renderer() |  |
    | Status | `Status` |  | flex 1 |  |  |
    | Order comment | `Memo` |  | flex 2 | renderer() |  |
    | Fulfillment order | `ID` |  | flex 2 | renderer() |  |

- **grid** · renders into `divShipLines` · placeholder `Please provide the shipping information.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Ship date | `ShipmentDate` | date column | flex 1 | edit: date field |  |
    | Carrier | `Carrier` |  | flex 2 | renderer() |  |
    | Tracking number | `TrackingNumber` |  | flex 2 | renderer() |  |
    | Tracking URL | `TrackingUrl` |  | flex 1 | renderer() |  |
    | Package# | `BoxesUI` |  | flex 3 | renderer() |  |
    | Order fulfillment box | `FulfillmentBoxOption` |  | flex 2 | renderer() |  |
    | Logistics provider | `LogisticsProviderOption` |  | flex 2 | renderer() |  |
    | Ship | `Shipped` | check column | 50 | renderer() |  |

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
    | Product | `SKU` |  | flex 2 | renderer() |  |
    | Batch/serial # | `BatchSN` |  | flex 1 | renderer() |  |
    | Expiry date | `ExpiryDate` |  | flex 1 | renderer() |  |

- **grid** · id `ShippingInstructionsGrid` · renders into `divShippingInstructions` · store `vShippingInstructionsParametersStore` · placeholder `Please provide shipping instructions`
- **grid** · id `PackageDetailsGrid` · renders into `divPackageDetails` · store `vPackageDetailsParametersStore` · placeholder `Please provide package details.`
  - *columns:*
    - *(component built elsewhere: `columns`)*
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
| combo |  | `"SalePicker_".concat(…)` | `window.saleVars.originalStore` | shows `window.saleVars.displayFieldName` · value `window.saleVars.idFieldName` · placeholder `window.saleVars.emptyText… |
| date field |  | `dtNewSaleGiftCardExpirationDate` | `` | placeholder `Choose...` · format `UserDateFormat` |
| combo |  | `cmbAvalaraTaxExemptionCode` | `vSale_AvalaraSaleTaxCodeStore` | shows `Name` · value `Code` · placeholder `Choose...` |
| combo |  | `cmbAvalaraTaxExemptionCode_NewAddress` | `vSale_AvalaraSaleTaxCodeStore` | shows `Name` · value `Code` · placeholder `Choose...` |
| date field |  | `tdSaleMult_CreditNote_Date` | `` | placeholder `Choose...` · format `UserDateFormat` |
| date field |  | `tdSaleMult_Invoice_Date` | `` | placeholder `Choose...` · format `UserDateFormat` |
| date field |  | `tdSaleMult_Invoice_DueDate` | `` | placeholder `Choose...` · format `UserDateFormat` |
| combo (+ add new) |  | `Sale_Index_InvBillingAddressLine1` | `vSaleMult_CustomerAddressStore` | shows `Line1` · value `Line1` · placeholder `Address` |
| text field |  | `Sale_Index_InvBillingAddressLine2` | `` | read-only |
| numeric field (with action) |  | `SaleMult_Index_InvoiceCurrencyConversionRate` | `` |  |
| combo |  | `SaleMult_NewProduct_Supplier` | `SupplierStore` | shows `Name` · value `SupplierID` · placeholder `type to search...` |
| combo |  | `tdSaleMult_NewCustomer_DefaultLocation` | `vTenantLocationLoadStore2` | shows `Description` · value `LocationID` · placeholder `Default location` |
| combo |  | `tdSaleMult_NewCustomer_Currency` | `currencyStore` | shows `Code` · value `Code` |
| checkbox |  | `tdSaleMult_NewCustomer_IsLegalEntity` | `` |  |
| checkbox |  | `tdSaleMult_NewCustomer_BillParent` | `` |  |
| combo |  | `tdSaleMult_NewCustomer_Parent` | `vCustomerParentStore` | shows `Name` · value `CustomerID` · placeholder `Select parent` |
| combo |  | `SaleMult_NewDeposit_Account` | `AccountCustomerCreditStore` | shows `DisplayName` · value `Code` · placeholder `Choose...` |
| combo |  | `SaleMult_NewDeposit_BankAccount` | `vBankAccountsStore` | shows `DisplayName` · value `Code` · placeholder `Select a bank account...` · pick-only |
| date field |  | `SaleMult_NewDeposit_DatePaid` | `` | placeholder `Choose...` · format `UserDateFormat` |
| combo |  | `SaleMult_NewPayment_Account` | `vChartOfAccountsPaymentsStore` | shows `DisplayName` · value `Code` · placeholder `Choose...` |
| date field |  | `SaleMult_NewPayment_DatePaid` | `` | placeholder `Choose a date...` · format `UserDateFormat` |
| numeric field (with action) |  | `SaleMult_Order_ConversionRate` | `` |  |
| date field |  | `tdSaleMult_Pick_ShipmentRequiredByDate` | `` | placeholder `Select...` · format `UserDateFormat` |
| date field |  | `tdSaleMult_Ship_ShipmentRequiredByDate` | `` | placeholder `Select...` · format `UserDateFormat` |
| combo (+ add new) |  | `tdSaleMult_Ship_ShippingAddressLine1` | `vSaleMult_CustomerAddressStore` | shows `Line1` · value `Line1` · placeholder `Address` |
| text field |  | `SaleMult_Ship_ShipToContact` | `` |  |
| text field |  | `SaleMult_Ship_ShipToCompany` | `` |  |
| combo (+ add new) |  | `SaleMult_Index_Customer` | `vSaleMult_CustomerStore` | shows `Name` · value `Name` · placeholder `Select a customer...` |
| combo |  | `Sale_Index_Ship_Another_Customer` | `vSaleMult_ShipAnotherCustomerStore` | shows `Name` · value `Name` · placeholder `type to search...` |
| combo |  | `Sale_Index_SippingAnotherAddressLine1` | `vSaleMult_ShipAnotherCustomerAddressStore` | shows `Line1` · value `AddressID` · placeholder `Choose...` |
| combo (+ add new) |  | `SaleMult_Index_Contact` | `vSaleMult_CustomerContactStore` | shows `Name` · value `Name` · placeholder `Choose...` |
| text field |  | `SaleMult_Index_Phone` | `` | placeholder `write...` |
| text field |  | `SaleMult_Index_Email` | `` | placeholder `write...` |
| combo (+ add new) |  | `SaleMult_Index_BillingAddressLine1` | `vSaleMult_CustomerAddressStore` | shows `Line1` · value `Line1` · placeholder `Address` |
| text field |  | `SaleMult_Index_BillingAddressLine2` | `` | placeholder `City, state, country, zip` |
| combo |  | `SaleMult_Index_Tax` | `vTenantTaxationRuleEditStore` | shows `Description` · value `RuleID` · placeholder `Choose...` |
| checkbox |  | `SaleMult_Index_Tax_Inclusive` | `` |  |
| combo |  | `SaleMult_Index_PriceTier` | `vSalesPriceTiersStore` | shows `Name` · value `Code` · placeholder `Choose...` · pick-only |
| combo (+ add new) |  | `SaleMult_Index_SalesRepresentative` | `vTenantContactsStore` | shows `Name` · value `Name` · placeholder `Choose...` |
| combo (+ add new) |  | `SaleMult_Index_Terms` | `vTenantPaymentTermStore` | shows `Name` · value `Name` · placeholder `Choose...` |
| text field |  | `SaleMult_Index_CustomerReference` | `` |  |
| text field |  | `SaleMult_Index_ShipToContact` | `` |  |
| text field |  | `SaleMult_Index_ShipToCompany` | `` |  |
| checkbox |  | `Sale_Index_SkipQuote` | `` |  |
| date field |  | `SaleMult_Index_Date` | `` | placeholder `Choose...` · format `UserDateFormat` |
| combo |  | `SaleMult_Index_Location` | `vTenantLocationLoadStore` | shows `Description` · value `LocationID` · placeholder `Choose...` |
| date field |  | `SaleMult_Index_ShipmentRequiredByDate` | `` | placeholder `Select...` · format `UserDateFormat` |
| combo (+ add new) |  | `SaleMult_Index_SippingAddressLine1` | `vSaleMult_CustomerAddressStore` | shows `Line1` · value `Line1` · placeholder `Address` |
| text field |  | `SaleMult_Index_SippingAddressLine2` | `` | placeholder `Choose...` |
| checkbox |  | `SaleMult_Index_ShipToOther` | `` |  |
| text field |  | `SaleMult_Index_ChannelOrderType` | `` | placeholder `` |
| text field |  | `SaleMult_Index_PurchaseOrderReference` | `` | placeholder `Enter up tp 256 characters` |
| combo |  | `tdScanLocation` | `vTenantLocationWithBinsLoadStore2` | shows `Description` · value `LocationID` · placeholder `Choose...` |
| text field |  | `tdScanPackBox` | `` | placeholder `Choose...` |
| text field |  | `tdScanPackBoxInventory` | `` | placeholder `Choose...` |
| text field |  | `tdScanPackBoxAutomatic` | `` | placeholder `Choose...` |
| checkbox |  | `id` | `` |  |

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
- **button** “{"Manifest: ".concat(…)}” · id `r.get(…)` · on click `handler()`
- **component** · renders into `_self.names.cmbFamily` · store `_self.familyStore` · shows `Name` · value `ID`
- **component** · renders into `_self.names.cmbBaseOption` · store `_self.familyOptionStore` · shows `name` · value `name` · pick-only
- **component** · renders into `_self.names.cmbBaseOptionValue` · store `_self.familyBaseOptionValueStore` · shows `name` · value `name` · pick-only
- **FamilyMatrix_Option** · name `optionName`
- **FamilyMatrix_Value** · name `item`
- **column** “Carrier” · field `Carrier`
- **column** “Package type” · field `PackageType`
- **column** “Service” · field `ShippingService`
- **component** · renders into `SaleMult_NewProduct_SaleTaxRule` · placeholder `Select a sale tax rule`
- **button** “{"Package: ".concat(…)}” · id `"spack".concat(…)` · on click `handler()`
- **button** “{"Shipment: ".concat(…)}” · id `_r2.get(…)` · on click `handler()`
- **button** “Save” · id `itmSaveWholeSale1` · on click `handler()`
- **button** “Undo” · id `itmUndoWholeSale1` · on click `SaleMult_Index_Undo`
- **button** “Void” · id `itmVoidWholeSale1` · on click `handler()`
- **button** “Clone” · id `itmCloneWholeSale` · on click `handler()`
- **button** “Mark as fulfilled” · id `ExclusiveOrderStatusBlock2` · on click `SaleMult_Index_MarkAsFulfilled`
- **button** “Mark as closed” · id `ExclusiveOrderStatusBlock3` · on click `SaleMult_Index_MarkAsClosed`
- **component** · renders into `tdSaleMult_Index_DefaultAccount` · store `vChartOfAccountsLinesStore` · shows `DisplayName` · value `Code` · placeholder `Choose...`
- **button** “{_ssRec.get(…)}” · id `"ss".concat(…)` · on click `handler()`
- **component** · renders into `tdScanQuantity` · required
- **text area** · renders into `divInventoryModeBarcodes` · placeholder `Enter your barcodes here...`
- **button** “New payment” · on click `function(taskId){return function(){SaleMult_NewPayment_Show((…)`
- **button** “Undo” · on click `function(taskId){return function(){SaleMult_Index_UndoChild((…)`
- **button** “Void” · on click `function(task){return function(){SaleMult_Index_DeleteChildF(…)`
- **button** “Void” · on click `function(taskId){return function(){SaleMult_Index_CancelChil(…)`
- **button** “New refund” · on click `function(taskId){return function(){SaleMult_NewPayment_Show((…)`
- **button** “Undo” · on click `function(taskId){return function(){SaleMult_Index_UndoRestoc(…)`
- **button** “Undo fulfillment” · on click `function(taskId){return function(){SaleMult_Index_UndoChild((…)`
- **column** · name `parameter.ControlName` · field `parameter.ControlName`
- **column** · name `BoxNumber` · field `BoxNumber`
- **column** “Package #” · field `BoxNumber`
- **check column** “LogicalExpression” · field `f.name` · read-only · disabled
- **column** “LogicalExpression” · field `f.name`

### `SalesList2019`

6 grids · 5 standalone fields · 0 windows · 1 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `SaleList_Index_GeneralContainer` · store `generalStore`
- **grid** · renders into `SaleList_Index_AccountingContainer` · store `accountingStore`
- **grid** · renders into `SaleList_Index_FulfilmentContainer` · store `fulfilmentStore`
- **grid** · renders into `_classPrivateFieldGet(…)` · store `_classPrivateFieldGet(…)`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Reference | `Reference` |  | flex 1 | RenderHTMLText |  |
    | Created date | `CreatedDate` |  | flex 1 | renderer() |  |
    | Updated date | `UpdatedDate` |  | flex 1 | renderer() |  |
    | Transaction date | `TransactionDate` |  | flex 1 | renderer() |  |
    | Type | `Type` |  | flex 1 | RenderHTMLText |  |
    | Channel | `Channel` |  | flex 1 | renderer() |  |
    | Currency | `Currency` |  | flex 1 | RenderHTMLText |  |
    | Total amount (foreign) | `TotalAmountForeign` |  | flex 1 | renderer() |  |
    | Total amount (local) | `TotalAmountLocal` |  | flex 1 | renderer() |  |
    | Comment | `Comment` |  | flex 3 | RenderHTMLText |  |

- **grid** · renders into `divRelatedOrdersDetails` · store `RelatedOrdersStore` · placeholder `No related orders created.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Order | `TaskNumber` |  | flex 1 | renderer() |  |
    | Type | `TaskTypeName` |  | flex 1 | RenderHTMLText |  |
    | Order date | `OrderDate` |  | flex 1 | renderer() |  |
    | Status | `Status` |  | flex 1 | renderer() |  |
    | Total | `TotalAmount` |  | 130 | renderer() |  |

- **grid** · renders into `this.$gridContainer.attr(…)` · store `store` · placeholder `You do not have any conditions at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Parameter name | `ParameterName` |  | flex 1 | renderer() |  |
    | Condition | `Condition` |  | flex 1 | renderer() |  |
    | Value | `ParameterFakeValue` |  | flex 1 | renderer() |  |
    | Join | `JoinCondition` |  | flex 1 | renderer() |  |


#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| date field |  | `Sale_Index_ShipmentRequiredByDate` | `` | placeholder `Choose date` · format `UserDateFormat` |
| combo |  | `"SalePicker_".concat(…)` | `window.saleVars.originalStore` | shows `window.saleVars.displayFieldName` · value `window.saleVars.idFieldName` · placeholder `window.saleVars.emptyText… |
| date field |  | `dtNewSaleGiftCardExpirationDate` | `` | placeholder `Choose...` · format `UserDateFormat` |
| combo |  | `cmbAvalaraTaxExemptionCode` | `vSale_AvalaraSaleTaxCodeStore` | shows `Name` · value `Code` · placeholder `Choose...` |
| combo |  | `cmbAvalaraTaxExemptionCode_NewAddress` | `vSale_AvalaraSaleTaxCodeStore` | shows `Name` · value `Code` · placeholder `Choose...` |

#### Menus, buttons and other parts

- **button** “{"Manifest: ".concat(…)}” · id `r.get(…)` · on click `handler()`

### `ServiceSale2019`

17 grids · 45 standalone fields · 0 windows · 12 menus, buttons and other parts · 0 custom components

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
- **grid** · renders into `divRelatedOrdersDetails` · store `RelatedOrdersStore` · placeholder `No related orders created.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Order | `TaskNumber` |  | flex 1 | renderer() |  |
    | Type | `TaskTypeName` |  | flex 1 | RenderHTMLText |  |
    | Order date | `OrderDate` |  | flex 1 | renderer() |  |
    | Status | `Status` |  | flex 1 | renderer() |  |
    | Total | `TotalAmount` |  | 130 | renderer() |  |

- **grid** · renders into `divAdditionalTransactionsContainer` · placeholder `You do not have any manual journals.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Debit | `Debit` |  | flex 1 | renderer() |  |
    | Credit | `Credit` |  | flex 1 | renderer() |  |
    | Reference | `Reference` |  | flex 1 | renderer() |  |
    | Date | `Date` | date column | flex 1 | edit: date field |  |
    | Amount | `Amount` |  | flex 1 | renderer() |  |

- **grid** · renders into `divAttachmentList` · store `AttachmentsStore` · placeholder `You do not have any files attached.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Name | `FileName` |  | flex 2 | renderer() |  |
    | Date | `Date` |  | flex 1 | renderer() |  |
    | Attached by | `UserName` |  | flex 2 |  |  |
    | Processed | `IsProcessed` | check column | 80 | renderer() |  |

- **grid** · renders into `divCreditNoteLines` · placeholder `You do not have any credit note lines.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `ProductCode` |  | flex 3 | renderer() |  |
    | Comment | `Comment` |  | flex 1 | renderer() | total count |
    | Unit | `UnitOfMeasure` |  | flex 1 | renderer() | hidden |
    | Quantity | `Quantity` |  | flex 1 |  | total sum |
    | Price | `Price` |  | flex 1 | renderer() |  |
    | Discount | `Discount` | number column | flex 1 | renderer() |  |
    | Account | `AccountCode` |  | flex 2 | renderer() |  |
    | Total | `Total` |  | 120 | renderer() | total sum |

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
    | Unit | `UnitOfMeasure` |  | flex 1 | renderer() | hidden |
    | Quantity | `Quantity` |  | flex 1 |  | total sum |
    | Price | `Price` |  | flex 1 | renderer() |  |
    | Discount | `Discount` |  | flex 1 | renderer() |  |
    | Tax rule | `TaxRule` |  | flex 1 | renderer() |  |
    | Account | `AccountCode` |  | flex 1 | renderer() |  |
    | Total | `Total` |  | flex 1 | renderer() | total sum |

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
    | Status | `Status` |  | flex 1 | renderer() |  |

- **grid** · renders into `divDepositsSaleServiceInvoice` · placeholder `You do not have any customer credits.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Account | `AccountCode` |  | flex 2 | renderer() |  |
    | Reference | `Reference` |  | flex 2 | renderer() |  |
    | Date paid | `DatePaid` | date column | flex 1 | edit: date field |  |
    | Amount | `Amount` |  | flex 1 | renderer() |  |
    | Conversion rate | `CurrencyConversionRate` |  | flex 1 | renderer() |  |
    | Base amount | `Amount` |  | flex 1 | renderer() |  |

- **grid** · renders into `Sale_NewAllocation_Credits` · store `vSaleCreditStore` · placeholder `No credits/deposits found for the selected customer.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Date | `Date` |  | flex 2 | renderer() |  |
    | Description | `Description` |  | flex 5 |  |  |
    | Remaining / total | `Amount` |  | flex 3 | renderer() |  |

- **grid** · renders into `Sale_NewAllocation_CreditNotes` · store `CreditNotesStore` · placeholder `No credits notes found for the selected customer.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Credit note # | `Description` |  | flex 5 |  |  |
    | Date | `Date` |  | flex 2 | renderer() |  |
    | Remaining / total | `Amount` |  | flex 3 | renderer() |  |

- **grid** · renders into `Sale_NewAllocation_Allocations` · store `dialogSelectedStore` · placeholder `No selected customer credits/deposits.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    |  | `Selected` | check column | 58 | renderer() |  |
    | Date | `Date` |  | flex 2 | renderer() |  |
    | Description | `Description` |  | flex 4 | renderer() |  |
    | Available to allocate | `RemainingAmount` |  | flex 2 | renderer() |  |
    | Allocated | `AllocatedAmount` |  | flex 2 | renderer() |  |

- **grid** · renders into `divQuoteLines` · placeholder `You do not have any sale quote lines.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `ProductCode` |  | flex 3 | renderer() |  |
    | Comment | `Comment` |  | flex 1 | renderer() | total count |
    | Unit | `UnitOfMeasure` |  | flex 1 | renderer() | hidden |
    | Quantity | `Quantity` |  | flex 1 |  | total sum |
    | Price | `Price` |  | flex 1 | renderer() |  |
    | Discount | `Discount` | number column | flex 1 | renderer() |  |
    | Tax rule | `TaxRule` |  | flex 1 | renderer() |  |
    | Total | `Total` |  | flex 1 | renderer() | total sum |

- **grid** · renders into `divDeposits` · placeholder `You do not have any customer credits.`
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
| date field |  | `dtNewSaleGiftCardExpirationDate` | `` | placeholder `Choose...` · format `UserDateFormat` |
| combo |  | `cmbAvalaraTaxExemptionCode` | `vSale_AvalaraSaleTaxCodeStore` | shows `Name` · value `Code` · placeholder `Choose...` |
| combo |  | `cmbAvalaraTaxExemptionCode_NewAddress` | `vSale_AvalaraSaleTaxCodeStore` | shows `Name` · value `Code` · placeholder `Choose...` |
| date field |  | `tdSale_CreditNote_Date` | `` | placeholder `Choose...` · format `UserDateFormat` |
| date field |  | `tdSale_Invoice_Date` | `` | placeholder `Choose...` · format `UserDateFormat` |
| date field |  | `tdSale_Invoice_DueDate` | `` | placeholder `Choose...` · format `UserDateFormat` |
| combo |  | `Sale_NewDeposit_Account` | `AccountCustomerCreditStore` | shows `DisplayName` · value `Code` · placeholder `Choose...` |
| combo |  | `Sale_NewDeposit_BankAccount` | `vBankAccountsStore` | shows `DisplayName` · value `Code` · placeholder `Select a bank account...` · pick-only |
| date field |  | `Sale_NewDeposit_DatePaid` | `` | placeholder `Choose...` · format `UserDateFormat` |
| combo (+ add new) |  | `Sale_Index_Customer` | `vSale_CustomerStore` | shows `Name` · value `Name` · placeholder `type to search...` |
| combo (+ add new) |  | `Sale_Index_Contact` | `vSale_CustomerContactStore` | shows `Name` · value `Name` · placeholder `Choose...` |
| text field |  | `Sale_Index_Phone` | `` | placeholder `write...` |
| text field |  | `Sale_Index_Email` | `` | placeholder `write...` |
| combo (+ add new) |  | `Sale_Index_BillingAddressLine1` | `vSale_CustomerAddressStore` | shows `Line1` · value `Line1` · placeholder `Address` |
| text field |  | `Sale_Index_BillingAddressLine2` | `` | placeholder `City, state, country, zip` |
| combo |  | `Sale_Index_Tax` | `vTenantTaxationRuleStore` | shows `Description` · value `RuleID` · placeholder `Choose...` |
| checkbox |  | `SaleService_Index_Tax_Inclusive` | `` |  |
| combo |  | `Sale_Index_PriceTier` | `vSalesPriceTiersStore` | shows `Name` · value `Code` · placeholder `Choose...` · pick-only |
| combo (+ add new) |  | `Sale_Index_Terms` | `vTenantPaymentTermStore` | shows `Name` · value `Name` · placeholder `Choose...` |
| text field |  | `Sale_Index_CustomerReference` | `` |  |
| text field |  | `Sale_Index_ShipToContact` | `` |  |
| text field |  | `Sale_Index_ShipToCompany` | `` |  |
| combo (+ add new) |  | `Sale_Index_SalesRepresentative` | `vTenantContactsStore` | shows `Name` · value `Name` · placeholder `Choose...` |
| numeric field |  | `tdSale_Index_CurrencyConversionRate` | `` |  |
| checkbox |  | `Sale_Index_SkipQuote` | `` |  |
| checkbox |  | `Sale_Index_IsRecursive` | `` |  |
| combo |  | `Sale_Index_Frequency` | `FrequencyStore` | shows `Frequency` · value `Frequency` · pick-only |
| date field |  | `Sale_Index_Date` | `` | placeholder `Choose...` · format `UserDateFormat` |
| combo (+ add new) |  | `Sale_Index_SippingAddressLine1` | `vSale_CustomerAddressStore` | shows `Line1` · value `Line1` · placeholder `Choose...` |
| text field |  | `Sale_Index_SippingAddressLine2` | `` | placeholder `Choose...` |
| date field |  | `Sale_Index_ShipmentRequiredByDate` | `` | placeholder `Choose...` · format `UserDateFormat` |
| combo |  | `tdSale_NewCustomer_Currency` | `currencyStore` | shows `Code` · value `Code` |
| checkbox |  | `tdSale_NewCustomer_IsLegalEntity` | `` |  |
| checkbox |  | `tdSale_NewCustomer_BillParent` | `` |  |
| combo |  | `tdSale_NewCustomer_Parent` | `vCustomerParentStore` | shows `Name` · value `CustomerID` · placeholder `Select parent` |

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
- **button** “{"Manifest: ".concat(…)}” · id `r.get(…)` · on click `handler()`
- **component** · renders into `tdSale_Index_DefaultAccount` · store `vChartOfAccountsLinesStore` · shows `DisplayName` · value `Code` · placeholder `Choose...`

### `SimpleSale2019`

34 grids · 59 standalone fields · 0 windows · 30 menus, buttons and other parts · 0 custom components

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
- **grid** · renders into `divRelatedOrdersDetails` · store `RelatedOrdersStore` · placeholder `No related orders created.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Order | `TaskNumber` |  | flex 1 | renderer() |  |
    | Type | `TaskTypeName` |  | flex 1 | RenderHTMLText |  |
    | Order date | `OrderDate` |  | flex 1 | renderer() |  |
    | Status | `Status` |  | flex 1 | renderer() |  |
    | Total | `TotalAmount` |  | 130 | renderer() |  |

- **grid** · renders into `divAdditionalTransactionsContainer` · placeholder `You do not have any manual journals.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Debit | `Debit` |  | flex 1 | renderer() |  |
    | Credit | `Credit` |  | flex 1 | renderer() |  |
    | Reference | `Reference` |  | flex 1 | renderer() |  |
    | Date | `Date` | date column | flex 1 | edit: date field |  |
    | Amount | `Amount` |  | flex 1 | renderer() |  |

- **grid** · renders into `divAttachmentList` · store `AttachmentsStore` · placeholder `You do not have any files attached.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Name | `FileName` |  | flex 2 | renderer() |  |
    | Date | `Date` |  | flex 1 | renderer() |  |
    | Attached by | `UserName` |  | flex 2 | RenderHTMLText |  |
    | Processed | `IsProcessed` | check column | 80 | renderer() |  |

- **grid** · renders into `divCreditNoteLines` · placeholder `You do not have any credit note lines.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `ProductCode` |  | flex 3 | renderer() |  |
    | Comment | `Comment` |  | flex 1 | renderer() | total count |
    | Unit | `UnitOfMeasure` |  | flex 1 | renderer() | hidden |
    | Quantity | `Quantity` |  | flex 1 |  | total sum |
    | Price | `Price` |  | flex 1 | renderer() |  |
    | Discount | `Discount` | number column | flex 1 | renderer() |  |
    | Account | `AccountCode` |  | flex 2 | renderer() |  |
    | Total | `Total` |  | flex 1 | renderer() | total sum |

- **grid** · renders into `divCreditNoteAdditionalChargesLines` · placeholder `You do not have any additional charges.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Description | `Description` |  | flex 3 | renderer() |  |
    | Comment | `Comment` |  | flex 1 | renderer() | total count |
    | Quantity | `Quantity` |  | flex 1 |  |  |
    | Price | `Amount` |  | flex 1 | renderer() |  |
    | Discount | `Discount` | number column | flex 1 | renderer() |  |
    | Tax rule | `TaxRule` |  | flex 1 | renderer() |  |
    | Account | `AccountCode` |  | flex 1 | renderer() |  |
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

- **grid** · renders into `divFulfillmentLines` · store `FulfillmentStore` · placeholder `No fulfillment orders were created for this sale.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Date created | `Date` |  | flex 1 | renderer() |  |
    | Shipping method | `ShippingMethod` |  | flex 1 | renderer() |  |
    | Status | `Status` |  | flex 1 |  |  |
    | Order comment | `Memo` |  | flex 2 | renderer() |  |
    | Fulfillment order | `ID` |  | flex 2 | renderer() |  |

- **grid** · renders into `divInvoiceLines` · placeholder `You do not have any invoice lines.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `ProductCode` |  | flex 2 | renderer() |  |
    | Comment | `Comment` |  | flex 1 | renderer() | total count |
    | Unit | `UnitOfMeasure` |  | flex 1 | renderer() | hidden |
    | Quantity | `Quantity` |  | 80 |  | total sum |
    | Price | `Price` |  | flex 1 | renderer() |  |
    | Discount | `Discount` | number column | flex 1 | renderer() |  |
    | Tax rule | `TaxRule` |  | flex 1 | renderer() |  |
    | Margin | `AverageCost` |  | flex 1 | renderer() |  |
    | Account | `AccountCode` |  | flex 1 | renderer() |  |
    | Total | `Total` |  | flex 1 | renderer() | total sum |

- **grid** · renders into `divInvoiceAdditionalChargesLines` · placeholder `You do not have any additional charges.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Description | `Description` |  | flex 2 | renderer() |  |
    | Comment | `Comment` |  | flex 1 | renderer() | total count |
    | Quantity | `Quantity` |  | flex 1 |  |  |
    | Price | `Amount` |  | flex 1 | renderer() |  |
    | Discount | `Discount` | number column | flex 1 | renderer() |  |
    | Tax rule | `TaxRule` |  | flex 2 | renderer() |  |
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
    | Status | `Status` |  | flex 1 | renderer() |  |

- **grid** · renders into `divInvoiceDeposits` · placeholder `You do not have any customer credits.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Account | `AccountCode` |  | flex 2 | renderer() |  |
    | Reference | `Reference` |  | flex 2 | renderer() |  |
    | Date paid | `DatePaid` | date column | flex 1 | edit: date field |  |
    | Amount | `Amount` |  | flex 1 | renderer() |  |
    | Conversion rate | `CurrencyConversionRate` |  | flex 1 | renderer() |  |
    | Base amount | `Amount` |  | flex 1 | renderer() |  |

- **grid** · renders into `Sale_NewAllocation_Credits` · store `vSaleCreditStore` · placeholder `No credits/deposits found for the selected customer.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Date | `Date` |  | flex 2 | renderer() |  |
    | Description | `Description` |  | flex 5 |  |  |
    | Remaining / total | `Amount` |  | flex 3 | renderer() |  |

- **grid** · renders into `Sale_NewAllocation_CreditNotes` · store `CreditNotesStore` · placeholder `No credits notes found for the selected customer.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Credit note # | `Description` |  | flex 5 |  |  |
    | Date | `Date` |  | flex 2 | renderer() |  |
    | Remaining / total | `Amount` |  | flex 3 | renderer() |  |

- **grid** · renders into `Sale_NewAllocation_Allocations` · store `dialogSelectedStore` · placeholder `No selected customer credits/deposits.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Date | `Date` |  | flex 2 | renderer() |  |
    | Description | `Description` |  | flex 4 | renderer() |  |
    | Available to allocate | `RemainingAmount` |  | flex 2 | renderer() |  |
    | Allocated | `AllocatedAmount` |  | flex 2 | renderer() |  |

- **grid** · renders into `divShippingOptionsGrid` · store `SSStore`
  - *columns:*
    - *(component built elsewhere: `columns`)*
- **grid** · renders into `divOrderLines` · placeholder `You do not have any sale order lines.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `ProductCode` |  | flex 3 | renderer() |  |
    | Comment | `Comment` |  | flex 1 | renderer() | total count |
    | Unit | `UnitOfMeasure` |  | flex 1 | renderer() | hidden |
    | Quantity | `Quantity` |  | 80 |  | total sum |
    | Price | `Price` |  | flex 1 | renderer() |  |
    | Discount | `Discount` | number column | flex 1 | renderer() |  |
    | Tax rule | `TaxRule` |  | flex 1 | renderer() |  |
    | Margin | `AverageCost` |  | flex 1 | renderer() |  |
    | Total | `Total` |  | flex 1 | renderer() | total sum |
    | Drop ship | `DropShip` | check column | 80 | renderer() |  |

- **grid** · renders into `divOrderAdditionalChargesLines` · placeholder `You do not have any additional charges in your sale order.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Description | `Description` |  | flex 3 | renderer() |  |
    | Comment | `Comment` |  | flex 1 | renderer() |  |
    | Quantity | `Quantity` |  | flex 1 |  |  |
    | Price | `Amount` |  | flex 1 | renderer() |  |
    | Discount | `Discount` | number column | flex 1 | renderer() |  |
    | Tax rule | `TaxRule` |  | flex 2 | renderer() |  |
    | Total | `Total` |  | flex 1 | renderer() |  |

- **grid** · renders into `UploadSaleOrderLinesExceptionsGrid` · store `SOLinesUploadErrorsStore` · placeholder `Please upload a file to check for issues.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Line # | `Line` |  | 50 |  |  |
    | Product SKU | `SKU` |  | 150 | renderer() |  |
    | Product name | `Name` |  | 250 | renderer() |  |
    | Quantity | `Quantity` |  | 100 | renderer() |  |
    | Price | `Price` |  | 100 | renderer() |  |
    | Discount | `Discount` |  | 100 | renderer() |  |

- **grid** · renders into `divOrderDeposits` · placeholder `You do not have any customer credits.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Account | `AccountCode` |  | flex 2 | renderer() |  |
    | Reference | `Reference` |  | flex 2 | renderer() |  |
    | Date paid | `DatePaid` | date column | flex 1 | edit: date field |  |
    | Amount | `Amount` |  | flex 1 | renderer() |  |
    | Conversion rate | `CurrencyConversionRate` |  | flex 1 | renderer() |  |
    | Base amount | `Amount` |  | flex 1 | renderer() |  |

- **grid** · renders into `divPackLines` · placeholder `Please provide the packing information.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `ProductCode` |  | flex 6 | renderer() |  |
    | Unit | `UnitOfMeasure` |  | flex 2 | renderer() | hidden |
    | Location | `LocationID` |  | flex 2 | renderer() |  |
    | Batch/serial no. | `BatchSN` |  | flex 2 | renderer() |  |
    | Expiry date | `ExpiryDate` |  | flex 1 | renderer() | total count |
    | Quantity | `Quantity` |  | flex 1 |  | total sum |
    | Package# | `BoxNumber` |  | flex 1 | RenderHTMLText |  |
    | Warranty | `WarrantySetupName` |  | flex 1 | RenderHTMLText |  |
    | Registration# | `WarrantyRegistrationNumber` |  | flex 2 | renderer() |  |

- **grid** · renders into `divPickLines` · placeholder `You do not have any pickings.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `ProductCode` |  | flex 3 | renderer() |  |
    | Batch/serial no. | `BatchSN` |  | flex 1 | renderer() |  |
    | Expiry date | `ExpiryDate` |  | flex 1 | renderer() |  |
    | Unit | `UnitOfMeasure` |  | flex 1 | renderer() | total count |
    | Quantity | `Quantity` |  | flex 1 |  | total sum |
    | Location | `LocationID` |  | flex 1 | renderer() |  |

- **grid** · renders into `divQuoteLines` · placeholder `You do not have any sale quote lines.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `ProductCode` |  | flex 3 | renderer() |  |
    | Comment | `Comment` |  | flex 1 | renderer() | total count |
    | Unit | `UnitOfMeasure` |  | flex 1 | renderer() | hidden |
    | Quantity | `Quantity` |  | 80 |  | total sum |
    | Price | `Price` |  | flex 1 | renderer() |  |
    | Discount | `Discount` | number column | flex 1 | renderer() |  |
    | Tax rule | `TaxRule` |  | flex 1 | renderer() |  |
    | Margin | `AverageCost` |  | flex 1 | renderer() |  |
    | Total | `Total` |  | flex 1 | renderer() | total sum |

- **grid** · renders into `divQuoteAdditionalChargesLines` · placeholder `You do not have any additional charges in your sale quote.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Description | `Description` |  | flex 3 | renderer() |  |
    | Comment | `Comment` |  | flex 1 | renderer() | total count |
    | Quantity | `Quantity` |  | flex 1 |  |  |
    | Price | `Amount` |  | flex 1 | renderer() |  |
    | Discount | `Discount` | number column | flex 1 | renderer() |  |
    | Tax rule | `TaxRule` |  | flex 2 | renderer() |  |
    | Total | `Total` |  | flex 1 | renderer() |  |

- **grid** · renders into `divDeposits` · placeholder `You do not have any customer credits.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Account | `AccountCode` |  | flex 2 | renderer() |  |
    | Reference | `Reference` |  | flex 2 | renderer() |  |
    | Date paid | `DatePaid` | date column | flex 1 | edit: date field |  |
    | Amount | `Amount` |  | flex 1 | renderer() |  |
    | Conversion rate | `CurrencyConversionRate` |  | flex 1 | renderer() |  |
    | Base amount | `Amount` |  | flex 1 | renderer() |  |

- **grid** · renders into `UploadSaleQuoteLinesExceptionsGrid` · store `QuoteLinesUploadErrorsStore2` · placeholder `Please upload a file to check for issues.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Line # | `Line` |  | 50 |  |  |
    | Product SKU | `SKU` |  | 150 | renderer() |  |
    | Product name | `Name` |  | 250 | renderer() |  |
    | Quantity | `Quantity` |  | 100 | renderer() |  |
    | Price | `Price` |  | 100 | renderer() |  |
    | Discount | `Discount` |  | 100 | renderer() |  |

- **grid** · renders into `divRestockLines` · placeholder `You do not have any items to restock.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Product | `ProductCode` |  | flex 3 | renderer() |  |
    | Batch/serial no. | `BatchSN` |  | flex 1 | renderer() |  |
    | Expiry date | `ExpiryDate` |  | flex 1 | renderer() |  |
    | Unit | `UnitOfMeasure` |  | flex 1 | renderer() | total count |
    | Quantity | `Quantity` |  | flex 1 |  | total sum |
    | Sale location | `LocationID` |  | flex 1 | renderer() |  |
    | Restock location | `RestockLocationID` |  | flex 1 | renderer() |  |
    | Date | `RestockDate` | date column | flex 1 | edit: date field |  |

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
    | Product | `SKU` |  | flex 2 | renderer() |  |
    | Batch/serial # | `BatchSN` |  | flex 1 | renderer() |  |
    | Expiry date | `ExpiryDate` |  | flex 1 | renderer() |  |

- **grid** · renders into `divShipLines` · placeholder `Please provide the shipping information.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Ship date | `ShipmentDate` | date column | 130 | edit: date field |  |
    | Carrier | `Carrier` |  | flex 2 | renderer() |  |
    | Tracking number | `TrackingNumber` |  | flex 2 | renderer() |  |
    | Tracking URL | `TrackingUrl` |  | flex 1 | renderer() |  |
    | Package# | `BoxesUI` |  | flex 3 | renderer() |  |
    | Order fulfillment box | `FulfillmentBoxOption` |  | flex 2 | renderer() |  |
    | Logistics provider | `LogisticsProviderOption` |  | flex 2 | renderer() |  |
    | Ship | `Shipped` | check column | 50 | renderer() |  |

- **grid** · id `ShippingInstructionsGrid` · renders into `divShippingInstructions` · store `vShippingInstructionsParametersStore` · placeholder `Please provide shipping instructions`
- **grid** · id `PackageDetailsGrid` · renders into `divPackageDetails` · store `vPackageDetailsParametersStore` · placeholder `Please provide package details.`
  - *columns:*
    - *(component built elsewhere: `columns`)*
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
| date field |  | `dtNewSaleGiftCardExpirationDate` | `` | placeholder `Choose...` · format `UserDateFormat` |
| combo |  | `cmbAvalaraTaxExemptionCode` | `vSale_AvalaraSaleTaxCodeStore` | shows `Name` · value `Code` · placeholder `Choose...` |
| combo |  | `cmbAvalaraTaxExemptionCode_NewAddress` | `vSale_AvalaraSaleTaxCodeStore` | shows `Name` · value `Code` · placeholder `Choose...` |
| date field |  | `tdSale_CreditNote_Date` | `` | placeholder `Choose...` · format `UserDateFormat` |
| date field |  | `tdSale_Invoice_Date` | `` | placeholder `Choose...` · format `UserDateFormat` |
| date field |  | `tdSale_Invoice_DueDate` | `` | placeholder `Choose...` · format `UserDateFormat` |
| combo |  | `inputId` | `AutocompleteAddressField.prototype.AddressInfoSto…` | shows `description` · value `place_id` · placeholder `Look up an address` |
| combo |  | `tdSale_NewCustomer_Currency` | `currencyStore` | shows `Code` · value `Code` |
| combo |  | `tdSale_NewCustomer_DefaultLocation` | `vTenantLocationLoadStore2` | shows `Description` · value `LocationID` · placeholder `Default location` |
| checkbox |  | `tdSale_NewCustomer_IsLegalEntity` | `` |  |
| checkbox |  | `tdSale_NewCustomer_BillParent` | `` |  |
| combo |  | `tdSale_NewCustomer_Parent` | `vCustomerParentStore` | shows `Name` · value `CustomerID` · placeholder `Select parent` |
| combo |  | `Sale_NewDeposit_Account` | `AccountCustomerCreditStore` | shows `DisplayName` · value `Code` · placeholder `Choose...` |
| combo |  | `Sale_NewDeposit_BankAccount` | `vBankAccountsStore` | shows `DisplayName` · value `Code` · placeholder `Select a bank account...` · pick-only |
| date field |  | `Sale_NewDeposit_DatePaid` | `` | placeholder `Choose...` · format `UserDateFormat` |
| combo |  | `tdSale_NewProduct_Supplier` | `SupplierStore` | shows `Name` · value `SupplierID` · placeholder `type to search...` |
| combo (+ add new) |  | `Sale_Index_Customer` | `vSale_CustomerStore` | shows `Name` · value `Name` · placeholder `type to search...` |
| combo |  | `Sale_Index_Ship_Another_Customer` | `vSale_ShipAnotherCustomerStore` | shows `Name` · value `Name` · placeholder `type to search...` |
| combo |  | `Sale_Index_SippingAnotherAddressLine1` | `vSale_ShipAnotherCustomerAddressStore` | shows `Line1` · value `AddressID` · placeholder `Choose...` |
| combo (+ add new) |  | `Sale_Index_Contact` | `vSale_CustomerContactStore` | shows `Name` · value `Name` · placeholder `Choose...` |
| text field |  | `Sale_Index_Phone` | `` | placeholder `write...` |
| text field |  | `Sale_Index_Email` | `` | placeholder `write...` |
| combo (+ add new) |  | `Sale_Index_BillingAddressLine1` | `vSale_CustomerAddressStore` | shows `Line1` · value `Line1` · placeholder `Address` |
| text field |  | `Sale_Index_BillingAddressLine2` | `` | placeholder `City, state, country, zip` |
| combo |  | `Sale_Index_Tax` | `vTenantTaxationRuleEditStore` | shows `Description` · value `RuleID` · placeholder `Choose...` |
| checkbox |  | `Sale_Index_Tax_Inclusive` | `` |  |
| combo |  | `Sale_Index_PriceTier` | `vSalesPriceTiersStore` | shows `Name` · value `Code` · placeholder `Choose...` · pick-only |
| combo (+ add new) |  | `Sale_Index_Terms` | `vTenantPaymentTermStore` | shows `Name` · value `Name` · placeholder `Choose...` |
| text field |  | `Sale_Index_CustomerReference` | `` |  |
| text field |  | `Sale_Index_ShipToContact` | `` |  |
| text field |  | `Sale_Index_ShipToCompany` | `` |  |
| combo (+ add new) |  | `Sale_Index_SalesRepresentative` | `vTenantContactsStore` | shows `Name` · value `Name` · placeholder `Choose...` |
| combo |  | `Sale_Index_Location` | `vTenantLocationLoadStore` | shows `Description` · value `LocationID` · placeholder `Choose...` |
| numeric field (with action) |  | `tdSale_Index_CurrencyConversionRate` | `` |  |
| checkbox |  | `Sale_Index_SkipQuote` | `` |  |
| checkbox |  | `Sale_Index_IsRecursive` | `` |  |
| combo |  | `Sale_Index_Frequency` | `FrequencyStore` | shows `Name` · value `Value` · pick-only |
| date field |  | `Sale_Index_Date` | `` | placeholder `Choose...` · format `UserDateFormat` |
| combo (+ add new) |  | `Sale_Index_SippingAddressLine1` | `vSale_CustomerAddressStore` | shows `Line1` · value `Line1` · placeholder `Choose...` |
| text field |  | `Sale_Index_SippingAddressLine2` | `` | placeholder `Choose...` |
| checkbox |  | `Sale_Index_ShipToOther` | `` |  |
| date field |  | `Sale_Index_ShipmentRequiredByDate` | `` | placeholder `Choose...` · format `UserDateFormat` |
| text field |  | `Sale_Index_ChannelOrderType` | `` | placeholder `` |
| text field |  | `Sale_Index_PurchaseOrderReference` | `` | placeholder `Enter up tp 256 characters` |
| combo |  | `tdScanLocation` | `vTenantLocationWithBinsLoadStore2` | shows `Description` · value `LocationID` · placeholder `Choose...` |
| text field |  | `tdScanPackBox` | `` | placeholder `Choose...` |
| text field |  | `tdScanPackBoxInventory` | `` | placeholder `Choose...` |
| text field |  | `tdScanPackBoxAutomatic` | `` | placeholder `Choose...` |
| date field |  | `WorkflowModal_dtWorkflowDate` | `` | format `UserDateFormat` |
| text field |  | `renderTo` | `` |  |
| combo |  | `renderTo` | `localStore` | shows `name` · value `value` · placeholder `Choose...` · pick-only |
| checkbox |  | `renderTo` | `` |  |
| numeric field |  | `renderTo` | `` |  |
| date field |  | `renderTo` | `` | placeholder `Choose...` · format `UserDateFormat` |
| text field |  | `renderTo` | `` |  |
| checkbox |  | `renderTo` | `` |  |
| numeric field |  | `renderTo` | `` |  |
| combo |  | `"SalePicker_".concat(…)` | `window.saleVars.originalStore` | shows `window.saleVars.displayFieldName` · value `window.saleVars.idFieldName` · placeholder `window.saleVars.emptyText… |
| checkbox |  | `id` | `` |  |

#### Menus, buttons and other parts

- **column** “Entity” · field `EntityType` · id `colRealDimensionsEntity`
- **column** “Account” · field `AccountCode` · id `colRealDimensionsAccount`
- **column** “Amount” · field `Amount` · id `colRealDimensionsAmount`
- **column** “Reference number” · field `ReferenceNumber` · id `colRealDimensionsReferenceNumber`
- **column** “Effective date” · field `EffectiveDate` · id `colRealDimensionsDate`
- **column** “Product” · field `ProductCode` · id `colRealDimensionsProduct`
- **column** “Supplier \| Customer” · field `"".concat(…)` · id `"colRealDimensions".concat(…)`
- **column** “{attr}” · field `attr.replace(…)` · id `"col".concat(…)`
- **button** “{"Manifest: ".concat(…)}” · id `r.get(…)` · on click `handler()`
- **component** · renders into `_self.names.cmbFamily` · store `_self.familyStore` · shows `Name` · value `ID`
- **component** · renders into `_self.names.cmbBaseOption` · store `_self.familyOptionStore` · shows `name` · value `name` · pick-only
- **component** · renders into `_self.names.cmbBaseOptionValue` · store `_self.familyBaseOptionValueStore` · shows `name` · value `name` · pick-only
- **FamilyMatrix_Option** · name `optionName`
- **FamilyMatrix_Value** · name `item`
- **column** “Carrier” · field `Carrier`
- **column** “Package type” · field `PackageType`
- **column** “Service” · field `ShippingService`
- **component** · renders into `Sale_NewProduct_SaleTaxRule` · placeholder `Select a sale tax rule`
- **component** · renders into `tdSale_Index_DefaultAccount` · store `vChartOfAccountsLinesStore` · shows `DisplayName` · value `Code` · placeholder `Choose...`
- **component** · renders into `tdScanQuantity` · required
- **text area** · renders into `divInventoryModeBarcodes` · placeholder `Enter your barcodes here...`
- **button** “{"Package: ".concat(…)}” · id `"spack".concat(…)` · on click `handler()`
- **button** “{"Shipment: ".concat(…)}” · id `_r.get(…)` · on click `handler()`
- **component** · id `cmpId` · renders into `renderTo` · store `localStore` · shows `name` · value `value` · placeholder `Choose...` · pick-only
- **column** “{attrSet.name}” · field `"CustomField".concat(…)`
- **column** · name `parameter.ControlName` · field `parameter.ControlName`
- **column** · name `BoxNumber` · field `BoxNumber`
- **column** “Package #” · field `BoxNumber`
- **check column** “LogicalExpression” · field `f.name` · read-only · disabled
- **column** “LogicalExpression” · field `f.name`

### `Warranties2019`

1 grids · 0 standalone fields · 0 windows · 0 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `Warranties_Index_Container` · store `mainStore` · placeholder `No warranties to display.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Warranty name | `WarrantyName` |  | flex 1 | RenderHTMLText |  |
    | Customer | `CustomerName` |  | flex 1 | RenderHTMLText |  |
    | Order number | `OrderNumber` |  | flex 1 | RenderHTMLText |  |
    | Order date | `OrderDate` | date column | flex 1 |  |  |
    |  | `OrderNumber` |  | flex 1 | renderer() | hidden |
    | Serial # | `BatchSN` |  | flex 1 | RenderHTMLText |  |
    | Registration # | `RegistrationNumber` |  | flex 1 | RenderHTMLText |  |
    | Expiration date | `ExpiryDate` |  | flex 1 | renderer() |  |


