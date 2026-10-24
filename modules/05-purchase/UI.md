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

## Layout

Each screen's server-rendered HTML inside the shell, as an outline: headings, tabs, sections, labels, inputs (`#id`), buttons (`▾` = dropdown), menus, tables and `slot`s (empty `<div>`s the components below mount into). `(hidden)` parts are shown by the page code when needed. Read with GET from a signed-in session; no values are kept.

### `/DropShipPurchase`: Drop shipment purchase

Frame: `ifrmIdrUploader`.

```text
link "Home"
link "Purchases"
button "Save"#saveAction primary
button "Undo"#undoAction
button "Void"#voidAction
button "Back to list"
block #taskActions
  button "Convert"#convertToAdvancedAction (hidden)
  button "Clone"#cloneAction
block #moreActionsBlock (hidden)
  button "More actions"#moreActions
  link "Convert"#convertToAdvancedAction_more (hidden)
  link "Undo"#undoAction_more (hidden)
  link "Void"#voidAction_more (hidden)
  link "Clone"#cloneAction_more (hidden)
block #divMainContent
  slot #Purchase_Index_Status
  heading 
  block #divDropShipPurchaseTask (hidden)
    button 
    button  primary
    button "Workflow"
    button 
    button "Calendar"
  button #taskHeaderCollapse
  block #divTaskHeader
    heading "Supplier details"
    slot #Purchase_Index_Supplier
    label "Supplier"
    slot #Purchase_Index_Contact
    label "Contact"
    slot #Purchase_Index_Phone
    label "Phone"
    slot #Purchase_Index_VendorAddressLine1
    label "Vendor address line 1"
    block #divVendorAddressLine2
      slot #Purchase_Index_VendorAddressLine2
      label "Vendor address line 2"
    block #liInvoiceNo
      input text#Purchase_Index_SupplierReference
      label "Invoice #"
    heading "Accounting details"
    slot #Purchase_Index_Terms
    label "Terms"
    slot #Purchase_Index_ShipmentRequiredByDate
    label "Required by"
    block #divRate
      slot #tdPurchase_Index_CurrencyConversionRate
      label ""
    slot #tdPurchase_Index_DefaultAccount
    label "Expense account"
    slot #DropShipPurchase_Index_Tax_Inclusive
    label "Tax inclusive" for #chkDropShipPurchase_Index_Tax_Inclusive
    slot #Purchase_Index_Tax
    label "Tax rule*"
    heading "Shipping details"
    slot #Purchase_Index_BlindReceipt
    label "Blind receipt" for #chkBlindReceipt
    slot #Purchase_Index_Date
    label "Date*"
    slot #Purchase_Index_Location
    label "Location*"
    slot #HeaderShipToOther
    label "Ship to different company" for #chkHeaderShipToOther
    block #Purchase_Index_CustomerAddress
      slot #Purchase_Index_SippingAddressLine1
      label "Shipping address line 1"
      slot #Purchase_Index_SippingAddressLine2
      label "Shipping address line 2"
    block #Purchase_Index_RecepientAddress (hidden)
      input text#tdPurchase_Index_ShipToCompanyContact placeholder "Please enter the shipping contact..." read-only
      button #Purchase_Index_EditOtherAddress primary
      textarea#tdPurchase_Index_ShipToAddress placeholder "Please enter the address..."
    heading "Comments"
    block #divNote
      textarea#divStickyNote placeholder "Write your note here..."
  button "Order"
  button "Invoice"
  button "Bill of entry"
  button "Credit note"
  button "Manual journals"
  button "Related orders"
  button "Attachments"
  button "Logs and attributes"
  button "Financials"
  block #divOrder (hidden)
    heading "Order"
    block #OrderReports
      button "Email"#orderEmailMenu ▾
      button "Print"#orderPrintMenu ▾
    button "Authorize"#divAuthorise_Order primary
    block #divOrderLinesForm
      slot #divOrderLines
    heading "Additional costs"
    button #divNewAdditionalCostLine_Order primary
    slot #divOrderAdditionalCostLines
    button "Add more items"#Purchase_Order_AddAdditionalCostLinesRecordLink primary
    textarea#Purchase_Index_PurchaseOrderMemo placeholder "Write your note here..."
    label "Purchase order memo" for #Purchase_Index_PurchaseOrderMemo
    table: Order lines | Additional costs | Total
    block #divNewPayment_Order
      button "Supplier deposit"#btnNewPayment_Order primary
    slot #divDeposits
    button "Add more items"#Purchase_Order_AddDepositsRecordLink primary (hidden)
    text "Balance due"#Purchase_Order_BalanceHeader
    slot #Purchase_Order_Balance
    text "Balance due"#Purchase_Order_BalanceHeaderTenant
    slot #Purchase_Order_BalanceTenant
  block #divBillOfEntry (hidden)
    heading "Bill of entry"
    button "Authorize"#divAuthorise_BillOfEntry primary
    slot #tdPurchase_BillOfEntry_Number
    label "Bill of entry no.*"
    block #divPurchase_BillOfEntry_DateExciseTaxPaid
      slot #tdPurchase_BillOfEntry_DateExciseTaxPaid
      label "Date of excise tax paid"
    block #divPurchase_BillOfEntry_Date
      slot #tdPurchase_BillOfEntry_Date
      label "Bill of entry date*"
    slot #divBillOfEntryLines
    table
  block #divInvoice (hidden)
    heading "Invoice"
    button "Extract from file"
    block #InvoiceReports
      button "Email"#invoiceEmailMenu ▾
      button "Print"#invoicePrintMenu ▾
    button "Authorize"#divAuthorise_Invoice primary
    slot #tdPurchase_Invoice_Number
    label "Invoice number*"
    slot #tdPurchase_Invoice_Date
    label "Invoice date*"
    slot #tdPurchase_Invoice_DueDate
    label "Due date*"
    slot #tdPurchase_Invoice_Total
    label "Total*"
    button "View in Xero"#divXero_Invoice primary (hidden)
    button "Copy"#divCopy_Invoice
    slot #divInvoiceLines
    heading "Additional costs"
    block #divAdditionalCostLine_Invoice
      button #divNewAdditionalCostLine_Invoice primary
      button "Copy from order"#divCopyAdditionalCostLine_Invoice
    slot #divInvoiceAdditionalCostLines
    button "Add more items"#Purchase_Invoice_AddAdditionalCostLinesRecordLink primary
    table: Invoice lines | Additional costs | Total
    block #divInvoicePaymentsButtonSet
      button "Payment"#divNewPayment_Invoice primary
      button "Use supplier deposit"#divNewPaymentAllocation_Invoice primary
    slot #divInvoicePayments
    button "Payment"#Purchase_Invoice_AddPaymentLinesRecordLink primary (hidden)
    button "Use supplier deposit"#Purchase_Invoice_AddPaymentAllocationsLink primary (hidden)
    text "Balance due"#Purchase_Invoice_BalanceHeader
    slot #Purchase_Invoice_Balance
    text "Balance due"#Purchase_Invoice_BalanceHeaderTenant
    slot #Purchase_Invoice_BalanceTenant
  block #divIdr (hidden)
    heading "AI recognition"
    button "Void"#btnDocExtBack
    button "Add and save"#btnDocExtSave primary (hidden)
    link "Upload"
    link "Mapping"
    link "Logs"
    tab pane#divDocumentImport
      slot #FeatureModuleDetailsBlock (hidden)
      slot #divLimitAlert (hidden)
      text "Extract invoice lines:"
      text "Use Intelligent Document Recognition (IDR) to extract information from purchase documents and add it to your purchase or"
      text "Document requirements:"
      block #divIdrPreviewTemplate (hidden)
      slot #ifrmIdrUploader (hidden)
      form#frmIdrUpload
        heading "Drop files here or click to upload."
      block #divProgressBar (hidden)
        slot #spnIdrFileName
        button "Cancel"#btnIdrFileCancel
      text "How AI recognition works Upload your file Parse and extract data automatically using AI. Map the extracted data to corre"
    tab pane#divDocumentExtraction
      input text#txtDocExtFileName read-only
      label "Import file name"
      slot #divMappingFields
      heading "File preview -"
      slot #ifrmFilePreview
    tab pane#divIdeLogs
      input text#divSearchLog placeholder "Type text to search"
      button "Search"#btnSearch primary
      button "Refresh"#divRefreshLog
      button #Grid_gridName_Options
      slot #logsGridContainer
  block #divCreditNote (hidden)
    heading "Credit note"
    button "Extract from file"
    block #CrNoteReports
      button "Email"#creditNoteEmailMenu ▾
      button "Print"#creditNotePrintMenu ▾
    button "Authorize"#divAuthorise_CreditNote primary
    button "View in Xero"#divXero_CreditNote primary (hidden)
    slot #tdPurchase_CreditNote_Number
    label "Credit note #*"
    slot #tdPurchase_CreditNote_Date
    label "Credit note date*"
    button #divNewLine_CreditNote primary
    button "Copy"#divCopyLines_CreditNote
    button "Void credit note"#divVoid_CreditNote
    slot #divCreditNoteLines
    button "Add more items"#Purchase_CreditNote_AddLinesRecordLink primary
    heading "Additional costs"
    button #divNewAdditionalCostLine_CreditNote primary
    button "Copy"#divCopyAdditionalCostLines_CreditNote
    slot #divCreditNoteAdditionalCostLines
    button "Add more items"#Purchase_CreditNote_AddAdditionalCostLinesRecordLink primary
    table: Credit note lines | Additional costs | Total
    button "Refund"#divNewPayment_CreditNote primary
    button "Supplier deposit"#divNewPayment_CreditNote_Credit primary
    slot #divCreditNotePayments
    button "Refund"#Purchase_CreditNote_AddPaymentLinesRecordLink primary (hidden)
    button "Supplier deposit"#Purchase_CreditNote_AddPaymentCreditLinesRecordLink primary (hidden)
    text "Balance due"#Purchase_CreditNote_BalanceHeader
    slot #Purchase_CreditNote_Balance
    text "Balance due"#Purchase_CreditNote_BalanceHeaderTenant
    slot #Purchase_CreditNote_BalanceTenant
  block #divManualJournals (hidden)
    heading "Manual journals"
    button "Authorize"#divAuthorise_ManualJournals primary
    button #divNew_ManualJournals primary
    button "Undo journals"#divUndo_Journals
    slot #divManualJournalsLines
    button "Add more items"#DropShipPurchase_ManualJournals_AddLineLink primary
  block #divHistory (hidden)
    heading "Logs and attributes"
    block #Purchase_divAttributeSet (hidden)
      heading "Additional attributes"
      block #Purchase_liCustomField1
        slot #Purchase_CustomField1
        label "Attribute 1"
      block #Purchase_liCustomField2
        slot #Purchase_CustomField2
        label "Attribute 2"
      block #Purchase_liCustomField3
        slot #Purchase_CustomField3
        label "Attribute 3"
      block #Purchase_liCustomField4
        slot #Purchase_CustomField4
        label "Attribute 4"
      block #Purchase_liCustomField5
        slot #Purchase_CustomField5
        label "Attribute 5"
      block #Purchase_liCustomField6
        slot #Purchase_CustomField6
        label "Attribute 6"
      block #Purchase_liCustomField7
        slot #Purchase_CustomField7
        label "Attribute 7"
      block #Purchase_liCustomField8
        slot #Purchase_CustomField8
        label "Attribute 8"
      block #Purchase_liCustomField9
        slot #Purchase_CustomField9
        label "Attribute 9"
      block #Purchase_liCustomField10
        slot #Purchase_CustomField10
        label "Attribute 10"
    heading "Activity log"
    slot #divHistoryLines
    heading "Workflow activity log"
    slot #divWorkflowHistoryLines
  block #divRelatedOrders (hidden)
    heading "Related orders"
    button "Refresh"#btnRefreshRelatedOrders
    slot #divRelatedOrdersDetails
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
form#frmConvertToAdvanced
modal#divNewSupplierDialog medium
  heading "New supplier"
  button "×"
  input text#tdPurchase_NewSupplier_Name placeholder "Enter a supplier name"
  label "Name"
  select#tdPurchase_NewSupplier_PaymentTerm
  label "Payment term"
  block #divSupplierTaxRule
    select#tdPurchase_NewSupplier_TaxRule
    label "Tax rule"
  input text#tdPurchase_NewSupplier_Discount placeholder "Enter a supplier discount"
  label "Discount"
  slot #tdPurchase_NewSupplier_Currency
  label "Currency"
  select#tdPurchase_NewSupplier_AccountCode
  label "Account payable"
  select#tdPurchase_NewSupplier_DefaultCarrier
  label "Default carrier"
  block #divSupplierTaxNumber
    input text#tdPurchase_NewSupplier_TaxNumber placeholder "Enter a tax number"
    label "Tax number"
  textarea#tdPurchase_NewSupplier_Comments placeholder "Enter comments"
  label "Comments"
  button "Save" primary
  button "Close"
modal#Purchase_NewContact_Content medium
  heading "Add a supplier contact"
  button "×"
  input text#tdPurchase_NewContact_Name
  label "Name"
  input text#tdPurchase_NewContact_JobTitle
  label "Job title"
  input text#tdPurchase_NewContact_Phone
  label "Phone"
  input text#tdPurchase_NewContact_MobilePhone
  label "Mobile phone"
  input text#tdPurchase_NewContact_Fax
  label "Fax"
  input text#tdPurchase_NewContact_Email
  label "Email"
  input text#tdPurchase_NewContact_Website
  label "Website"
  input checkbox#tdPurchase_NewContact_IsDefault
  label "Default" for #tdPurchase_NewContact_IsDefault
  textarea#tdPurchase_NewContact_Comment
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
modal#Purchase_NewAddress_Content medium
  heading "Add a supplier address"
  button "×"
  slot #cmbVendorAddress
  button  primary
  label ""
  input text#tdPurchase_NewAddress_Line1
  label "Line 1"
  input text#tdPurchase_NewAddress_Line2
  label "Line 2"
  input text#tdPurchase_NewAddress_CitySuburb
  label "City / suburb"
  input text#tdPurchase_NewAddress_StateProvince
  label "State / province"
  input text#tdPurchase_NewAddress_ZipPostCode
  label "ZIP / postcode"
  select#tdPurchase_NewAddress_Country
  label "Country"
  block #SaleCommon_NewAddress_AvalaraTaxExemptionCode (hidden)
    slot #cmbAvalaraTaxExemptionCode_NewAddress
    label "Tax exemption reason"
  select#tdPurchase_NewAddress_Type: Billing | Business | Shipping
  label "Type"
  input checkbox#tdPurchase_NewAddress_DefaultForType
  label "Default for type" for #tdPurchase_NewAddress_DefaultForType
  button "Save" primary
  button "Close"
modal#Purchase_EditAddress_Content medium
  heading "Edit shipping address"
  button "×"
  input text#tdPurchase_EditAddress_Company
  label "Company"
  input text#tdPurchase_EditAddressContact
  label "Contact"
  input text#tdPurchase_EditAddress_Line1
  label "Line 1"
  input text#tdPurchase_EditAddress_Line2
  label "Line 2"
  input text#tdPurchase_EditAddress_CitySuburb
  label "City / suburb"
  input text#tdPurchase_EditAddress_ZipPostCode
  label "ZIP / postcode"
  input text#tdPurchase_EditAddress_StateProvince
  label "State / province"
  select#tdPurchase_EditAddress_Country
  label "Country"
  button "OK" primary
  button "Close"
modal#divNewProductDialog medium
  heading "Add a new product"
  button "×"
  input text#tdPurchase_NewProduct_ProductCode placeholder "Enter a product SKU"
  label "SKU"
  input text#tdPurchase_NewProduct_Name placeholder "Enter a product name"
  label "Name"
  select#tdPurchase_NewProduct_Category
  label "Category"
  select#tdPurchase_NewProduct_UnitOfMeasure
  label "Unit of measure"
  select#tdPurchase_NewProduct_PurchaseTaxRule
  label "Purchase tax rule"
  slot #tdPurchase_NewProduct_SaleTaxRule
  label "Sale tax rule"
  select#tdPurchase_NewProduct_ProductAttributeSet
  label "Attribute set"
  slot #divAdditionalAttributes_NewProduct
  block #AdditionalAttributes_FieldTemplate (hidden)
    slot #{CustomField}
    label "" for #{CustomField}
  button "Save" primary
  button "Close"
modal#Purchase_NewDeposit_Content small
  heading #Purchase_NewDeposit_Title
  button "×"
  slot #Purchase_NewDeposit_Account
  label "Deposit account"
  block #Purchase_NewDeposit_BankAcocuntBlock
    slot #Purchase_NewDeposit_BankAccount
    label "Account"
  input text#Purchase_NewDeposit_Reference
  label "Reference"
  slot #Purchase_NewDeposit_DatePaid
  label "Date paid"
  input text#Purchase_NewDeposit_Amount
  label "Amount"
  block #liPurchase_NewDeposit_ConversionRate
    input text#Purchase_NewDeposit_ConversionRate
    button #Purchase_NewDeposit_ConversionRate_GetRate
    label "Conversion rate"
  block #Purchase_NewDeposit_BaseAmountBlock (hidden)
    slot #Purchase_NewDeposit_BaseAmountLabel
    slot #Purchase_NewDeposit_BaseAmount
  button "Create" primary
  button "Close"
block #Purchase_NewAllocation (hidden)
  block #Purchase_NewAllocation_Content
    heading "Allocate supplier deposit as payment"
    button "Add and save"#Purchase_NewAllocation_SaveAction primary
    button "Cancel"#Purchase_NewAllocation_CancelAction
    heading "Select existing supplier deposit(s)"
    slot #Purchase_NewAllocation_Deposits
    heading "Allocation(s) that will be created"
    slot #Purchase_NewAllocation_Allocations
    table
    button "Add and save"#Purchase_NewAllocation_SaveAction2 primary
    button "Cancel"#Purchase_NewAllocation_CancelAction2
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
modal#divCOGSAccDims small
  heading "Accounting dimensions"
  button "×"
  button "Save"#btnSaveCOGSAccDims primary
  button "Close"
slot #CountrySpecificScript
```

### `/LatestProductPriceBySupplier`: Product Prices by Supplier

Frame: `task-upload-frame`.

```text
link "Home"
link "Reports"
block #divList
  heading "Product Prices by Supplier"
  input text#divSearch placeholder "Type text to search"
  button "Search" primary
  button "Import"#divImport
  button "Export"#divExport
  button #divRefresh
  button #Grid_gridName_Options
  slot #LatestProductPriceBySupplier_Index_Container
  form#frmExport
```

### `/LeadSafetyValues`: Reorder parameters

Frame: `task-upload-frame`.

```text
link "Home"
heading "Reorder parameters"
input text#divSearch placeholder "Type text to search"
button "Search" primary
button #divRefresh
button "Import"#divImport
button "Export"#divExport
button #Grid_gridName_Options
slot #LeadSafetyValues_Index_Container
form#frmExport
```

### `/Payment`: Supplier bulk payment

Frame: `task-upload-frame`.

```text
link "Home"
link "Purchases"
slot #tdSupplier
label "Supplier" for #Supplier
slot #tdCurrency
label "Currency"
slot #tdPeriod
label "Period" for #Period
block #lblFrom (hidden)
  slot #tdFrom
  label "From" for #From
block #lblTo (hidden)
  slot #tdTo
  label "To" for #To
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
block #Payment_GridBlock (hidden)
  button "Pay" primary
  label "Unallocated"
  slot #tdUnallocated
  slot #divContainer
block #Payment_EmptyBlock
  text "Please fill all required fields first."
```

### `/Purchase`: Purchase

Frame: `ifrmIdrUploader`.

```text
link "Home"
link "Purchases"
button "Save"#saveAction primary
button "Save"#btnSaveDistribution primary (hidden)
button "Mark as received"#markAsReceivedAction primary
button "Back to list"
block #taskActions
  button "Clone"#cloneAction
  link "Keep order number"
  link "New order #"
  button "Convert"#convertAction
  button "Archive"#divArchive
button "Undo"#undoAction
button "Void"#voidAction
block #moreActionsBlock (hidden)
  button "More actions"#moreActions
  link "Undo"#undoAction_more (hidden)
  link "Void"#voidAction_more (hidden)
  link "Clone (keep order no.)"#cloneAction1_more (hidden)
  link "Clone (new order no.)"#cloneAction2_more (hidden)
  link "Convert"#convertAction_more (hidden)
  link "Archive"#divArchive_more (hidden)
block #divMainContent
  slot #Purchase_Index_Status
  heading 
  block #divArchiveStatic (hidden)
  block #divApproveStatic (hidden)
  button "Save as preset"#btnSavePreset primary
  select#cmbPresetList
  button "Delete preset"#btnDeletePreset
  block #divPurchaseTask (hidden)
    button 
    button  primary
    button "Workflow"
    button 
    button "Calendar"
  button #taskHeaderCollapse
  block #divTaskHeader
    heading "Supplier details"
    slot #Purchase_Index_Supplier
    label "Supplier"
    slot #Purchase_Index_Contact
    label "Contact"
    slot #Purchase_Index_Phone
    label "Phone"
    slot #Purchase_Index_VendorAddressLine1
    label "Vendor address line 1"
    block #divVendorAddressLine2
      slot #Purchase_Index_VendorAddressLine2
      label "Vendor address line 2"
    block #liInvoiceNo
      input text#Purchase_Index_SupplierReference
      label "Invoice #"
    heading "Accounting details"
    input radio#Purchase_Index_StockFirst
    label "Stock first" for #Purchase_Index_StockFirst
    input radio#Purchase_Index_InvoiceFirst
    label "Invoice first" for #Purchase_Index_InvoiceFirst
    slot #Purchase_Index_Terms
    label "Terms"
    slot #Purchase_Index_ShipmentRequiredByDate
    label "Required by"
    block #divRate
      slot #tdPurchase_Index_CurrencyConversionRate
      label ""
    slot #tdPurchase_Index_DefaultAccount
    label "Inventory account"
    block #purchase-milestone-section (hidden)
      slot #tdPurchase_Index_JobInfo
      slot #tdPurchase_Index_Milestone
      label "Milestone"
    slot #Purchase_Index_Tax_Inclusive
    label "Tax inclusive" for #chkPurchase_Index_Tax_Inclusive
    slot #Purchase_Index_Tax
    label "Tax rule*"
    heading "Shipping details"
    slot #Purchase_Index_BlindReceipt
    label "Blind receipt" for #chkBlindReceipt
    slot #Purchase_Index_Date
    label "Date*"
    slot #Purchase_Index_Location
    label "Location*"
    slot #HeaderShipToOther
    label "Ship to different company" for #chkHeaderShipToOther
    block #Purchase_Index_CustomerAddress
      slot #Purchase_Index_SippingAddressLine1
      label "Shipping address line 1"
      slot #Purchase_Index_SippingAddressLine2
      label "Shipping address line 2"
    block #Purchase_Index_RecepientAddress (hidden)
      input text#tdPurchase_Index_ShipToCompanyContact placeholder "Please enter the shipping contact..." read-only
      button #Purchase_Index_EditOtherAddress primary
      textarea#tdPurchase_Index_ShipToAddress placeholder "Please enter the address..."
    heading "Comments"
    block #divNote
      textarea#divStickyNote placeholder "Write your note here..."
  button "Stock received"
  button "Order"
  button "Invoice"
  button "Bill of entry"
  button "Credit note"
  button "Unstock"
  button "Manual journals"
  button "Related orders"
  button "Attachments"
  button "Logs and attributes"
  button "Financials"
  block #divOrder (hidden)
    heading "Order"
    block #OrderReports
      button "Email"#orderEmailMenu ▾
      button "Print"#orderPrintMenu ▾
    button "Authorize"#divAuthorise_Order primary
    button "Approve"#btApprove primary (hidden)
    button "Reject"#btReject (hidden)
    button "Review"#btReview (hidden)
    block #divOrderLinesForm
      button #divNewLines_Order primary
      button "Family"#divAddBulk_Order
      button "Scan"#divScan_Order
      button "Verify order"#divVerify_Order primary
      slot #divOrderLines
      button "Add more items"#Purchase_Order_AddOrderLinesRecordLink primary (hidden)
      button "Export"#divExport_Order primary
      button "Import"#divImport_Order primary
    block #divProductReplenishmentDetailsForm (hidden)
      button "Back to order"#divVerify_Order_Back
      slot #divProductReplenishmentDetails
    heading "Additional costs"
    button #divNewAdditionalCostLine_Order primary
    slot #divOrderAdditionalCostLines
    button "Add more items"#Purchase_Order_AddAdditionalCostLinesRecordLink primary
    textarea#Purchase_Index_PurchaseOrderMemo placeholder "Write your note here..."
    label "Purchase order memo" for #Purchase_Index_PurchaseOrderMemo
    table: Order lines | Additional costs | Total
    block #divNewPayment_Order
      button "Supplier deposit"#btnNewPayment_Order primary
    slot #divDeposits
    button "Add more items"#Purchase_Order_AddDepositsRecordLink primary (hidden)
    text "Balance due"#Purchase_Order_BalanceHeader
    slot #Purchase_Order_Balance
    text "Balance due"#Purchase_Order_BalanceHeaderTenant
    slot #Purchase_Order_BalanceTenant
  block #divStockReceived (hidden)
    heading "Stock received"
    button "Extract from file"
    block #StockReceivedReports
      button "Email"#stockReceivedEmailMenu ▾
      button "Print"#stockReceivedPrintMenu ▾
    button "Authorize"#divAuthorise_StockReceived primary
    block #purchaseStockReceivedNonInventoryWarning
    button #divNew_StockReceived primary
    button "Copy from order"#divCopyFromOrder_StockReceived
    button "Copy from invoice"#divCopyFromInvoice_StockReceived primary
    button "Scan"#divScan_StockReceived
    button "Load consumption bins"#btnLoadBins (hidden)
    button "Apply directed put away"#btnUseDirectedPutAway (hidden)
    slot #divStockReceivedLines
    button "Add more items"#Purchase_StockReceived_AddRecordLink primary (hidden)
    button "Export"#divExport_StockReceived primary
    button "Import"#divImport_StockReceived primary
  block #divInvoice (hidden)
    heading "Invoice"
    button "Extract from file"
    block #InvoiceReports
      button "Email"#invoiceEmailMenu ▾
      button "Print"#invoicePrintMenu ▾
    button "Authorize"#divAuthorise_Invoice primary
    block #divInvoiceLinesForm
      block #divInvoiceDetails
        slot #tdPurchase_Invoice_Number
        label "Invoice number*"
        slot #tdPurchase_Invoice_Date
        label "Invoice date*"
        slot #tdPurchase_Invoice_DueDate
        label "Due date*"
        slot #tdPurchase_Invoice_Total
        label "Total*"
        slot #tdPurchase_Invoice_Total_No_Access
        label "Total*"
        button "View in Xero"#divXero_Invoice primary (hidden)
      button #divNewLines_Invoice primary
      button "Copy"#divCopy_Invoice
      button "Family"#divAddBulk_Invoice
      button "Scan"#divScan_Invoice
      button "Verify invoice"#divVerify_Invoice primary
      slot #divInvoiceLines
      button "Add more items"#Purchase_Invoice_AddInvoiceLinesRecordLink primary (hidden)
      button "Export"#divExport_Invoice primary
      button "Import"#divImport_Invoice primary
    block #divVerifyInvoiceForm (hidden)
      button "Back to invoice"#divVerify_Invoice_Back
      text "Note: Below entered figures for domestic, freight costs are used for calculation purpose only and not saved in the syste"
      block #divFreightCostDetails
        slot #tdPurchaseInvoiceDomesticFreightCostCurrency
        label "Currency*" for #tdPurchaseInvoiceDomesticFreightCostCurrency
        block #tdPurchaseInvoiceDomesticFreightCostOtherCurrencyContainer (hidden)
          slot #tdPurchaseInvoiceDomesticFreightCostOtherCurrencyAmount
          label "Amount" for #tdPurchaseInvoiceDomesticFreightCostOtherCurrencyAmount
        slot #tdPurchaseInvoiceDomesticFreightCostBaseCurrencyAmount
        label "Amount" for #tdPurchaseInvoiceDomesticFreightCostBaseCurrencyAmount
        slot #tdPurchaseInvoiceOceanFreightCostCurrency
        label "Currency*" for #tdPurchaseInvoiceOceanFreightCostCurrency
        block #tdPurchaseInvoiceOceanFreightCostOtherCurrencyContainer (hidden)
          slot #tdPurchaseInvoiceOceanFreightCostOtherCurrencyAmount
          label "Amount" for #tdPurchaseInvoiceOceanFreightCostOtherCurrencyAmount
        slot #tdPurchaseInvoiceOceanFreightCostBaseCurrencyAmount
        label "Amount" for #tdPurchaseInvoiceOceanFreightCostBaseCurrencyAmount
        slot #tdPurchaseInvoiceTotalFreightCostAmount
        label "Amount" for #tdPurchaseInvoiceTotalFreightCostAmount
      slot #divVerifyInvoiceGrid
    heading "Additional costs"
    block #divAdditionalCostLine_Invoice
      button #divNewAdditionalCostLine_Invoice primary
      button "Expenses"#divDistributeExpenses primary (hidden)
      button "Copy from order"#divCopyAdditionalCostLine_Invoice
    slot #divInvoiceAdditionalCostLines
    button "Add more items"#Purchase_Invoice_AddAdditionalCostLinesRecordLink primary
    table: Invoice lines | Additional costs | Total
    block #divInvoicePaymentsButtonSet
      button "Payment"#divNewPayment_Invoice primary
      button "Use supplier deposit"#divNewPaymentAllocation_Invoice primary
      button "Pay with Settle"#divNewPaymentSettle_Invoice primary (hidden)
      button "Pay with Airwallex"#divNewPaymentAirwallex_Invoice primary (hidden)
    slot #divInvoicePayments
    button "Payment"#Purchase_Invoice_AddPaymentLinesRecordLink primary (hidden)
    button "Use supplier deposit"#Purchase_Invoice_AddPaymentAllocationsLink primary (hidden)
    text "Balance due"#Purchase_Invoice_BalanceHeader
    slot #Purchase_Invoice_Balance
    text "Balance due"#Purchase_Invoice_BalanceHeaderTenant
    slot #Purchase_Invoice_BalanceTenant
  block #divIdr (hidden)
    heading "AI recognition"
    button "Void"#btnDocExtBack
    button "Add and save"#btnDocExtSave primary (hidden)
    link "Upload"
    link "Mapping"
    link "Logs"
    tab pane#divDocumentImport
      slot #FeatureModuleDetailsBlock (hidden)
      slot #divLimitAlert (hidden)
      text "Extract invoice lines:"
      text "Use Intelligent Document Recognition (IDR) to extract information from purchase documents and add it to your purchase or"
      text "Document requirements:"
      block #divIdrPreviewTemplate (hidden)
      slot #ifrmIdrUploader (hidden)
      form#frmIdrUpload
        heading "Drop files here or click to upload."
      block #divProgressBar (hidden)
        slot #spnIdrFileName
        button "Cancel"#btnIdrFileCancel
      text "How AI recognition works Upload your file Parse and extract data automatically using AI. Map the extracted data to corre"
    tab pane#divDocumentExtraction
      input text#txtDocExtFileName read-only
      label "Import file name"
      slot #divMappingFields
      heading "File preview -"
      slot #ifrmFilePreview
    tab pane#divIdeLogs
      input text#divSearchLog placeholder "Type text to search"
      button "Search"#btnSearch primary
      button "Refresh"#divRefreshLog
      button #Grid_gridName_Options
      slot #logsGridContainer
  block #divBillOfEntry (hidden)
    heading "Bill of entry"
    button "Authorize"#divAuthorise_BillOfEntry primary
    slot #tdPurchase_BillOfEntry_Number
    label "Bill of entry no.*"
    block #divPurchase_BillOfEntry_DateExciseTaxPaid
      slot #tdPurchase_BillOfEntry_DateExciseTaxPaid
      label "Date of excise tax paid"
    block #divPurchase_BillOfEntry_Date
      slot #tdPurchase_BillOfEntry_Date
      label "Bill of entry date*"
    slot #divBillOfEntryLines
    table
  block #divCreditNote (hidden)
    heading "Credit note"
    button "Extract from file"
    block #CrNoteReports
      button "Email"#creditNoteEmailMenu ▾
      button "Print"#creditNotePrintMenu ▾
    button "Authorize"#divAuthorise_CreditNote primary
    button "View in Xero"#divXero_CreditNote primary (hidden)
    slot #tdPurchase_CreditNote_Number
    label "Credit note #*"
    slot #tdPurchase_CreditNote_Date
    label "Credit note date*"
    button #divNewLine_CreditNote primary
    button "Copy"#divCopyLines_CreditNote
    button "Void credit note"#divVoid_CreditNote
    slot #divCreditNoteLines
    button "Add more items"#Purchase_CreditNote_AddLinesRecordLink primary (hidden)
    heading "Additional costs"
    button #divNewAdditionalCostLine_CreditNote primary
    button "Expenses"#divDistributeExpenses_CreditNote primary (hidden)
    button "Copy"#divCopyAdditionalCostLines_CreditNote
    slot #divCreditNoteAdditionalCostLines
    button "Add more items"#Purchase_CreditNote_AddAdditionalCostLinesRecordLink primary (hidden)
    table: Credit note lines | Additional costs | Total
    button "Refund"#divNewPayment_CreditNote primary
    button "Supplier deposit"#divNewPayment_CreditNote_Credit primary
    slot #divCreditNotePayments
    button "Refund"#Purchase_CreditNote_AddPaymentLinesRecordLink primary (hidden)
    button "Supplier deposit"#Purchase_CreditNote_AddPaymentCreditLinesRecordLink primary (hidden)
    text "Balance due"#Purchase_CreditNote_BalanceHeader
    slot #Purchase_CreditNote_Balance
    text "Balance due"#Purchase_CreditNote_BalanceHeaderTenant
    slot #Purchase_CreditNote_BalanceTenant
  block #divUnstock (hidden)
    heading "Unstock"
    button "Authorize"#divAuthorise_Unstock primary
    block #purchaseUnstockNonInventoryWarning
    button "Copy from credit note"#divCopy_Unstock
    slot #divUnstockLines
  block #divManualJournals (hidden)
    heading "Manual journals"
    button "Authorize"#divAuthorise_ManualJournals primary
    button #divNew_ManualJournals primary
    button "Undo journals"#divUndo_Journals
    slot #divManualJournalsLines
    button "Add more items"#Purchase_ManualJournals_AddLineLink primary (hidden)
    block #Purchase_ManualJournals_DistributedCostsHeader (hidden)
      heading "Charge"
    block #Purchase_ManualJournals_DistributedCostsGrid (hidden)
      slot #divManualJournalsDistributedCosts
  block #divRelatedOrders (hidden)
    heading "Related orders"
    button "Refresh"#btnRefreshRelatedOrders
    slot #divRelatedOrdersDetails
  block #divHistory (hidden)
    heading "Logs and attributes"
    block #Purchase_divAttributeSet (hidden)
      heading "Additional attributes"
      block #Purchase_liCustomField1
        slot #Purchase_CustomField1
        label "Attribute 1"
      block #Purchase_liCustomField2
        slot #Purchase_CustomField2
        label "Attribute 2"
      block #Purchase_liCustomField3
        slot #Purchase_CustomField3
        label "Attribute 3"
      block #Purchase_liCustomField4
        slot #Purchase_CustomField4
        label "Attribute 4"
      block #Purchase_liCustomField5
        slot #Purchase_CustomField5
        label "Attribute 5"
      block #Purchase_liCustomField6
        slot #Purchase_CustomField6
        label "Attribute 6"
      block #Purchase_liCustomField7
        slot #Purchase_CustomField7
        label "Attribute 7"
      block #Purchase_liCustomField8
        slot #Purchase_CustomField8
        label "Attribute 8"
      block #Purchase_liCustomField9
        slot #Purchase_CustomField9
        label "Attribute 9"
      block #Purchase_liCustomField10
        slot #Purchase_CustomField10
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
  modal#PresetModal small
    heading "Name your pre-set"
    button "×"
    input text#PresetModal_Name
    label "Pre-set name"
    button "Save" primary
    button "Close"
slot #divPrint
form#frmClone
form#frmConvert
modal#divUploadPOLines medium
  heading "Upload a purchase order"
  button "×"
  heading "1. Download this purchase order"
  heading "2. Add new and modify existing products in the file."
  heading "3. Upload"
  block #UploadPOLinesExceptionsContainer (hidden)
    slot #UploadPOLinesExceptionsGrid
  block #divUploadContainer2
    form#frmDownloadOrder
      heading "Drop files here or click to upload."
  slot #ifrmDownloadOrder (hidden)
  slot #ifrmDownloadPOLines (hidden)
  form#frmDownloadPOLines
  button "Close"
modal#divUploadStockReceived medium
  heading "Upload stock received"
  button "×"
  heading "1. Download this stock received"
  heading "2. Add new and modify existing products in the file."
  heading "3. Upload"
  block #UploadStockReceivedLinesExceptionsContainer (hidden)
    slot #UploadStockReceivedLinesExceptionsGrid
  form#frmUploadStockReceived
    heading "Drop files here or click to upload."
  slot #ifrmUploadStockReceived (hidden)
  slot #ifrmDownloadStockReceived (hidden)
  form#frmDownloadStockReceived
  button "Close"
modal#divUploadInvoiceLines medium
  heading "Upload a bill"
  button "×"
  heading "1. Download this bill"
  heading "2. Add new and modify existing products in the file."
  heading "3. Upload"
  block #UploadInvoiceLinesExceptionsContainer (hidden)
    slot #UploadInvoiceLinesExceptionsGrid
  form#frmDownloadInvoice
    heading "Drop files here or click to upload."
  slot #ifrmDownloadInvoice (hidden)
  slot #ifrmDownloadInvoiceLines (hidden)
  form#frmDownloadInvoiceLines
  button "Close"
modal#dlgFamilyMatrix medium
  heading "Add a product family"
  button "×"
  slot #FamilyMatrix_cmbFamily
  label "Product family"
  input number#FamilyMatrix_txtPrice name=tdProductFamilyPrice
  label "Price" for #FamilyMatrix_txtPrice
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
modal#divScan medium
  heading "Scanning"
  button "×"
  tabs: Automatic #AutomaticMode_tab | Manual #ManualMode_tab | Inventory #InventoryMode_tab | Serial #AutomaticSerialMode_tab
  block #divScanBin
    slot #tdScanBin
    label "Bin (optional)" for #cmbScanLocation
  block #scanDesc
  block #scanBar
    block #dScan
      slot #spScan
  slot #ScanValidationContainer (hidden)
  input text#txtScanFocus
  block #divScanInfo (hidden)
    heading "Found product:"
    slot #divScanProductSelection (hidden)
    label "SKU"
    block #tdScanProductCode
    label "Name"
    block #tdScanName
    label "Barcode"
    block #tdScanBarcode
    block #liScanBatchSN (hidden)
      label "Batch/serial number"
      slot #tdScanBatchSN
    block #liScanExpiryDate (hidden)
      label "Expiry date"
      slot #tdScanExpiryDate
    block #liScanQuantity (hidden)
      label "Quantity"
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
  block #divScanInfoActions (hidden)
    button "Save"#liScanSave primary (hidden)
    button "Close"
  block #divScanAutoActions
    button "Close"
modal#divNewSupplierDialog medium
  heading "New supplier"
  button "×"
  input text#tdPurchase_NewSupplier_Name placeholder "Enter a supplier name"
  label "Name"
  select#tdPurchase_NewSupplier_PaymentTerm
  label "Payment term"
  block #divSupplierTaxRule
    select#tdPurchase_NewSupplier_TaxRule
    label "Tax rule"
  input text#tdPurchase_NewSupplier_Discount placeholder "Enter a supplier discount"
  label "Discount"
  slot #tdPurchase_NewSupplier_Currency
  label "Currency"
  select#tdPurchase_NewSupplier_AccountCode
  label "Account payable"
  select#tdPurchase_NewSupplier_DefaultCarrier
  label "Default carrier"
  block #divSupplierTaxNumber
    input text#tdPurchase_NewSupplier_TaxNumber placeholder "Enter a tax number"
    label "Tax number"
  textarea#tdPurchase_NewSupplier_Comments placeholder "Enter comments"
  label "Comments"
  button "Save" primary
  button "Close"
modal#Purchase_NewContact_Content medium
  heading "Add a supplier contact"
  button "×"
  input text#tdPurchase_NewContact_Name
  label "Name"
  input text#tdPurchase_NewContact_JobTitle
  label "Job title"
  input text#tdPurchase_NewContact_Phone
  label "Phone"
  input text#tdPurchase_NewContact_MobilePhone
  label "Mobile phone"
  input text#tdPurchase_NewContact_Fax
  label "Fax"
  input text#tdPurchase_NewContact_Email
  label "Email"
  input text#tdPurchase_NewContact_Website
  label "Website"
  input checkbox#tdPurchase_NewContact_IsDefault
  label "Default" for #tdPurchase_NewContact_IsDefault
  textarea#tdPurchase_NewContact_Comment
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
modal#Purchase_NewAddress_Content medium
  heading "Add a supplier address"
  button "×"
  slot #cmbVendorAddress
  button  primary
  label ""
  input text#tdPurchase_NewAddress_Line1
  label "Line 1"
  input text#tdPurchase_NewAddress_Line2
  label "Line 2"
  input text#tdPurchase_NewAddress_CitySuburb
  label "City / suburb"
  input text#tdPurchase_NewAddress_StateProvince
  label "State / province"
  input text#tdPurchase_NewAddress_ZipPostCode
  label "ZIP / postcode"
  select#tdPurchase_NewAddress_Country
  label "Country"
  block #SaleCommon_NewAddress_AvalaraTaxExemptionCode (hidden)
    slot #cmbAvalaraTaxExemptionCode_NewAddress
    label "Tax exemption reason"
  select#tdPurchase_NewAddress_Type: Billing | Business | Shipping
  label "Type"
  input checkbox#tdPurchase_NewAddress_DefaultForType
  label "Default for type" for #tdPurchase_NewAddress_DefaultForType
  button "Save" primary
  button "Close"
modal#Purchase_EditAddress_Content medium
  heading "Edit shipping address"
  button "×"
  input text#tdPurchase_EditAddress_Company
  label "Company"
  input text#tdPurchase_EditAddressContact
  label "Contact"
  input text#tdPurchase_EditAddress_Line1
  label "Line 1"
  input text#tdPurchase_EditAddress_Line2
  label "Line 2"
  input text#tdPurchase_EditAddress_CitySuburb
  label "City / suburb"
  input text#tdPurchase_EditAddress_ZipPostCode
  label "ZIP / postcode"
  input text#tdPurchase_EditAddress_StateProvince
  label "State / province"
  select#tdPurchase_EditAddress_Country
  label "Country"
  button "OK" primary
  button "Close"
modal#Purchase_NewTenantAddress_Content medium
  heading "Add company address"
  button "×"
  slot #cmbAddress
  button  primary
  label ""
  input text#tdPurchase_NewTenantAddress_Line1
  label "Line 1"
  input text#tdPurchase_NewTenantAddress_Line2
  label "Line 2"
  input text#tdPurchase_NewTenantAddress_CitySuburb
  label "City / suburb"
  input text#tdPurchase_NewTenantAddress_StateProvince
  label "State / province"
  input text#tdPurchase_NewTenantAddress_ZipPostCode
  label "ZIP / postcode"
  select#tdPurchase_NewTenantAddress_Country
  label "Country"
  block #SaleCommon_NewAddress_AvalaraTaxExemptionCode (hidden)
    slot #cmbAvalaraTaxExemptionCode_NewAddress
    label "Tax exemption reason"
  select#tdPurchase_NewTenantAddress_Type: Billing | Business | Shipping
  label "Type"
  input checkbox#tdPurchase_NewTenantAddress_DefaultForType
  label "Default for type" for #tdPurchase_NewTenantAddress_DefaultForType
  button "Save" primary
  button "Close"
modal#Purchase_NewLocation_Content small
  heading "Add a location"
  button 
  slot #Product_NewLocation_ValidationContainer
  input text#tdPurchase_NewLocation_Description
  label "Location" for #stocktakeSortingDropdown
  button "Save" primary
  button "Close"
modal#divNewProductDialog medium
  heading "Add a new product"
  button "×"
  input text#tdPurchase_NewProduct_ProductCode placeholder "Enter a product SKU"
  label "SKU"
  input text#tdPurchase_NewProduct_Name placeholder "Enter a product name"
  label "Name"
  select#tdPurchase_NewProduct_Type
  label "Type"
  block #FixedAssetTypeRow
    select#tdPurchase_NewProduct_FixedAssetType
    label "Fixed asset type"
  select#tdPurchase_NewProduct_Category
  label "Category"
  select#tdPurchase_NewProduct_PurchaseTaxRule
  label "Purchase tax rule"
  slot #tdPurchase_NewProduct_SaleTaxRule
  label "Sale tax rule"
  select#tdPurchase_NewProduct_UnitOfMeasure
  label "Unit of measure"
  block #trCostingMethod
    select#tdPurchase_NewProduct_CostingMethod
    label "Costing method"
  block #trExpenseAccount
    select#tdPurchase_NewProduct_ExpenseAccount
    label "Expense account"
  block #trMinimumBeforeReorder
    input text#tdPurchase_NewProduct_MinimumBeforeReorder placeholder "Enter a minimum before reorder."
    label "Minimum before reorder"
  block #trReorderQuantity
    input text#tdPurchase_NewProduct_ReorderQuantity placeholder "Enter reorder quantity"
    label "Reorder quantity"
  input text#tdPurchase_NewProduct_Barcode placeholder "Enter a barcode"
  label "Barcode"
  block #trStockLocator
    input text#tdPurchase_NewProduct_StockLocator placeholder "Enter a stock locator"
    label "Stock locator"
  select#tdPurchase_NewProduct_ProductAttributeSet
  label "Attribute set"
  slot #divAdditionalAttributes_NewProduct
  block #AdditionalAttributes_FieldTemplate (hidden)
    slot #{CustomField}
    label "" for #{CustomField}
  button "Save" primary
  button "Close"
modal#Purchase_NewDeposit_Content small
  heading #Purchase_NewDeposit_Title
  button "×"
  slot #Purchase_NewDeposit_Account
  label "Deposit account"
  block #Purchase_NewDeposit_BankAcocuntBlock
    slot #Purchase_NewDeposit_BankAccount
    label "Account"
  input text#Purchase_NewDeposit_Reference
  label "Reference"
  slot #Purchase_NewDeposit_DatePaid
  label "Date paid"
  input text#Purchase_NewDeposit_Amount
  label "Amount"
  block #liPurchase_NewDeposit_ConversionRate
    input text#Purchase_NewDeposit_ConversionRate
    button #Purchase_NewDeposit_ConversionRate_GetRate
    label "Conversion rate"
  block #Purchase_NewDeposit_BaseAmountBlock (hidden)
    slot #Purchase_NewDeposit_BaseAmountLabel
    slot #Purchase_NewDeposit_BaseAmount
  button "Create" primary
  button "Close"
block #Purchase_NewAllocation (hidden)
  block #Purchase_NewAllocation_Content
    heading "Allocate supplier deposit as payment"
    button "Add and save"#Purchase_NewAllocation_SaveAction primary
    button "Cancel"#Purchase_NewAllocation_CancelAction
    heading "Select existing supplier deposit(s)"
    slot #Purchase_NewAllocation_Deposits
    heading "Allocation(s) that will be created"
    slot #Purchase_NewAllocation_Allocations
    table
    button "Add and save"#Purchase_NewAllocation_SaveAction2 primary
    button "Cancel"#Purchase_NewAllocation_CancelAction2
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
modal#divCOGSAccDims small
  heading "Accounting dimensions"
  button "×"
  button "Save"#btnSaveCOGSAccDims primary
  button "Close"
slot #divExpenseDestributionContainer
slot #CountrySpecificScript
```

### `/PurchaseAdvanced`: Advanced purchase

Frame: `ifrmIdrUploader`.

```text
slot #breadcrumb
button "Save"#saveAction2 primary
button "Save"#btnSaveDistribution primary (hidden)
button "Back to list"
block #divMainContent
  block #ControlBlock
    slot #formCaption2
    slot #PurchaseAdvanced_Index_CurrencyLabel
    block #PurchaseAdvanced_Index_Status
  block #InvoicesBlock
    block #InvoicesBlockHeader
    block #taskInvoiceRibbon
      text "0"#InvoiceRemainingValue
    slot #InvoicesPlaceHolder
    block #divPurchase_Invoice_Add_Block
      button "Invoicing and receiving"#PurchaseAdvanced_Invoice_AddLink primary
  block #BillOfEntryBlock
    slot #BillOfEntryPlaceHolder
  block #PaymentsBlock
    block #taskPaymentRibbon
      text "paid"#PaidTotalValueLabel
      text "2"#PaidTotalValue
    slot #PaymentsPlaceHolder
  block #CreditNotesBlock
    slot #CreditNotePlaceHolder
    block #divPurchase_CrNote_Add_Block
      button "Credit note"#Purchase_CreditNote_AddLink primary
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
  slot #PurchaseAdvanced_Index_Status_Header
  heading 
  block #divArchiveStatic (hidden)
  block #divApproveStatic (hidden)
  button "Save as preset"#btnSavePreset primary
  select#cmbPresetList
  button "Delete preset"#btnDeletePreset
  block #divPurchaseAdvancedTask (hidden)
    button 
    button  primary
    button "Workflow"
    button 
    button "Calendar"
  button #taskHeaderCollapse
  block #divTaskHeader
    heading "Supplier details"
    slot #PurchaseAdvanced_Index_Supplier
    label "Supplier"
    slot #Purchase_Index_Contact
    label "Contact"
    slot #Purchase_Index_Phone
    label "Phone"
    slot #Purchase_Index_VendorAddressLine1
    label "Vendor address line 1"
    block #divVendorAddressLine2
      slot #Purchase_Index_VendorAddressLine2
      label "Vendor address line 2"
    heading "Accounting details"
    slot #Purchase_Index_Terms
    label "Terms"
    slot #Purchase_Index_ShipmentRequiredByDate
    label "Required by"
    block #divRate
      slot #tdPurchase_Index_CurrencyConversionRate
      label ""
    slot #tdPurchase_Index_DefaultAccount
    label "Inventory account"
    slot #Purchase_Index_Tax_Inclusive
    label "Tax inclusive" for #chkPurchase_Index_Tax_Inclusive
    slot #Purchase_Index_Tax
    label "Tax rule*"
    heading "Shipping details"
    slot #Purchase_Index_BlindReceipt
    label "Blind receipt"
    slot #Purchase_Index_Date
    label "Date*"
    slot #Purchase_Index_Location
    label "Location*"
    slot #chkHeaderShipToOther
    label "Ship to different company"
    block #Purchase_Index_CustomerAddress
      slot #Purchase_Index_SippingAddressLine1
      label "Shipping address line 1"
      slot #Purchase_Index_SippingAddressLine2
      label "Shipping address line 2"
    block #Purchase_Index_RecepientAddress (hidden)
      input text#tdPurchase_Index_ShipToCompanyContact placeholder "Please enter the shipping contact..." read-only
      button #Purchase_Index_EditOtherAddress primary
      textarea#tdPurchase_Index_ShipToAddress placeholder "Please enter the address..."
    heading "Comments"
    block #divNote
      textarea#divStickyNote placeholder "Write your note here..."
  block #divNone (hidden)
    heading "You do not have permission to view the purchase order."
  button "Show sidebar"#showSidebarButton primary
  block #divNoOrder (hidden)
    heading "This purchase is a blind receipt and has no purchase order."
  block #divOrder (hidden)
    slot #PurchaseAdvanced_Index_OrderStatus
    heading "Purchase order"
    button "Authorize"#divAuthorise_Order primary
    button "Archive"#divArchive
    button "Approve"#btApprove primary (hidden)
    button "Reject"#btReject (hidden)
    button "Review"#btReview (hidden)
    block #OrderReports
      button "Email"#btnOrderEmailMenu ▾
      slot #orderEmailMenu
      button "Print"#btnOrderPrintMenu ▾
      slot #orderPrintMenu
    block #divOrderLinesForm
      button #divNewLines_Order primary
      button "Family"#divAddBulk_Order
      button "Scan"#divScan_Order
      button "Verify order"#divVerify_Order primary
      slot #divOrderLines
      button "Add more items"#PurchaseAdvanced_Order_AddOrderLinesRecordLink primary (hidden)
      button "Export"#divExport_Order primary
      button "Import"#divImport_Order primary
    block #divProductReplenishmentDetailsForm (hidden)
      button "Back to order"#divVerify_Order_Back
      slot #divProductReplenishmentDetails
    heading "Additional costs"
    button #divNewAdditionalCostLine_Order primary
    slot #divOrderAdditionalCostLines
    button "Add more items"#PurchaseAdvanced_Order_AddAdditionalCostLinesRecordLink primary
    textarea#Purchase_Index_PurchaseOrderMemo placeholder "Write your note here..."
    label "Purchase order memo" for #Purchase_Index_PurchaseOrderMemo
    table: Order lines | Additional costs | Total
    block #OrderPrepaymentBlock
      block #divNewPayment_Order
        button "Supplier deposit"#btnNewPayment_Order primary
      slot #divDeposits
      button "Add more items"#PurchaseAdvanced_Order_AddDepositsRecordLink primary (hidden)
    text "Balance due"#Purchase_Order_BalanceHeader
    slot #Purchase_Order_Balance
    text "Balance due"#Purchase_Order_BalanceHeaderTenant
    slot #Purchase_Order_BalanceTenant
  block #divInvoice (hidden)
    slot #tdPurchase_Invoice_Status
    heading "Invoice"
    slot #labelPurchase_Invoice_Number
    button "Extract from file"
    button "Authorize"#divAuthorise_Invoice primary
    block #InvoiceReports
      button "Email"#btnInvoiceEmailMenu ▾
      slot #invoiceEmailMenu
      button "Print"#btnInvoicePrintMenu ▾
      slot #invoicePrintMenu
    block #divPurchaseAdvancedTask_Invoice (hidden)
      button 
      button  primary
      button "Workflow"
      button 
      button "Calendar"
    block #tabsList
    block #divInnerInvoice (hidden)
      block #divInvoiceLinesForm
        block #divInvoiceDetails
          slot #tdPurchase_Invoice_Number
          label "Invoice number*"
          slot #tdPurchase_Invoice_Date
          label "Invoice date*"
          block #rInvoiceDates
            slot #tdPurchase_Invoice_DueDate
            label "Due date*"
          block #divPurchase_Index_InvoiceCurrencyConversionRateBlock
            label ""
            input text#Purchase_Index_InvoiceCurrencyConversionRate
            button #Purchase_Index_InvoiceCurrencyConversionRate_GetRate
          slot #tdPurchase_Invoice_Total
          label "Total*"
          slot #tdPurchase_Invoice_Total_No_Access
          label "Total*"
          button "View in Xero"#divXero_Invoice primary (hidden)
        button #divNewLines_Invoice primary
        button "Copy remaining from order"#divCopy_Invoice
        button "Copy from receiving"#divCopy_Invoice_FromReceiving
        button "Family"#divAddBulk_Invoice
        button "Scan"#divScan_Invoice
        button "Verify invoice"#divVerify_Invoice primary
        slot #divInvoiceLines
        button "Add more items"#PurchaseAdvanced_Invoice_AddInvoiceLinesRecordLink primary (hidden)
        button "Export"#divExport_Invoice primary
        button "Import"#divImport_Invoice primary
      block #divVerifyInvoiceForm (hidden)
        button "Back to invoice"#divVerify_Invoice_Back
        text "Note: Below entered figures for domestic, freight costs are used for calculation purpose only and not saved in the syste"
        block #divFreightCostDetails
          slot #tdPurchaseInvoiceDomesticFreightCostCurrency
          label "Currency*" for #tdPurchaseInvoiceDomesticFreightCostCurrency
          block #tdPurchaseInvoiceDomesticFreightCostOtherCurrencyContainer (hidden)
            slot #tdPurchaseInvoiceDomesticFreightCostOtherCurrencyAmount
            label "Amount" for #tdPurchaseInvoiceDomesticFreightCostOtherCurrencyAmount
          slot #tdPurchaseInvoiceDomesticFreightCostBaseCurrencyAmount
          label "Amount" for #tdPurchaseInvoiceDomesticFreightCostBaseCurrencyAmount
          slot #tdPurchaseInvoiceOceanFreightCostCurrency
          label "Currency*" for #tdPurchaseInvoiceOceanFreightCostCurrency
          block #tdPurchaseInvoiceOceanFreightCostOtherCurrencyContainer (hidden)
            slot #tdPurchaseInvoiceOceanFreightCostOtherCurrencyAmount
            label "Amount" for #tdPurchaseInvoiceOceanFreightCostOtherCurrencyAmount
          slot #tdPurchaseInvoiceOceanFreightCostBaseCurrencyAmount
          label "Amount" for #tdPurchaseInvoiceOceanFreightCostBaseCurrencyAmount
          slot #tdPurchaseInvoiceTotalFreightCostAmount
          label "Amount" for #tdPurchaseInvoiceTotalFreightCostAmount
        slot #divVerifyInvoiceGrid
      heading "Additional costs"
      button #divNewAdditionalCostLine_Invoice primary
      button "Expenses"#divDistributeExpenses primary (hidden)
      button "Copy from order"#divCopyAdditionalCostLine_Invoice
      slot #divInvoiceAdditionalCostLines
      button "Add more items"#PurchaseAdvanced_Invoice_AddAdditionalCostLinesRecordLink primary
      table: Invoice lines | Additional costs | Total
      block #divInvoicePaymentsButtonSet
        button "Payment"#divNewPayment_Invoice primary
        button "Use supplier deposit"#divNewPaymentAllocation_Invoice primary
        button "Pay with Settle"#divNewPaymentSettle_Invoice primary (hidden)
        button "Pay with Airwallex"#divNewPaymentAirwallex_Invoice primary (hidden)
      slot #divInvoicePayments
      button "Payment"#PurchaseAdvanced_Invoice_AddPaymentLinesRecordLink primary (hidden)
      button "Use supplier deposit"#PurchaseAdvanced_Invoice_AddPaymentAllocationsLink primary (hidden)
      text "Balance due"#Purchase_Invoice_BalanceHeader
      slot #Purchase_Invoice_Balance
      text "Balance due"#Purchase_Invoice_BalanceHeaderTenant
      slot #Purchase_Invoice_BalanceTenant
    block #divInnerBillOfEntry (hidden)
      slot #tdPurchase_BillOfEntry_Number
      label "Bill of entry no.*"
      block #divPurchase_BillOfEntry_DateExciseTaxPaid
        slot #tdPurchase_BillOfEntry_DateExciseTaxPaid
        label "Date of excise tax paid"
      block #divPurchase_BillOfEntry_Date
        slot #tdPurchase_BillOfEntry_Date
        label "Bill of entry date*"
      button "Authorize"#divAuthorise_BillOfEntry primary
      slot #divBillOfEntryLines
      table
    block #divInnerManualJournal (hidden)
      button #divNew_ManualJournals primary
      button "Undo journals"#divUndo_Journals
      button "Authorize"#divAuthorise_ManualJournals primary
      slot #divManualJournalsLines
      button "Add more items"#PurchaseAdvanced_ManualJournals_AddLineLink primary (hidden)
      block #Purchase_ManualJournals_DistributedCostsHeader (hidden)
        heading "Charge"
      block #Purchase_ManualJournals_DistributedCostsGrid (hidden)
        slot #divManualJournalsDistributedCosts
  block #divStockReceived (hidden)
    slot #tdPurchase_Stock_Status
    heading "Stock received"
    block #StockReceivedReports
      button "Email"#btnStockReceivedEmailMenu ▾
      slot #stockReceivedEmailMenu
      button "Print"#btnStockReceivedPrintMenu ▾
      slot #stockReceivedPrintMenu
    block #tabsList
    block #divInnerIntermediateStockReceived (hidden)
      block #purchaseStockReceivedNonInventoryWarning
      slot #Purchase_IntermediateStockReceived_Date
      label "Date received*" for #Purchase_IntermediateStockReceived_Date
      button #divNew_IntermediateStockReceived primary
      button "Copy from order"#divCopyFromPO_IntermediateStockReceived
      button "Copy from invoice"#divCopyFromInvoice_IntermediateStockReceived
      button "Scan"#divScan_IntermediateStockReceived
      button "Extract from file"
      button "Authorize"#divAuthorise_IntermediateStockReceived primary
      slot #divIntermediateStockReceivedLines
      button "Add more items"#PurchaseAdvanced_IntermediateStockReceived_AddRecordLink primary (hidden)
      button "Export"#divExport_IntermediateStockReceived primary
      button "Import"#divImport_IntermediateStockReceived primary
    block #divInnerStockReceived (hidden)
      slot #Purchase_StockReceived_Date
      label "Date received*" for #Purchase_StockReceived_Date
      button #divNew_StockReceived primary
      button "Copy from order"#divCopyFromPO_StockReceived
      button "Copy from receiving"#divCopyFromReceiving_StockReceived
      button "Scan"#divScan_StockReceived
      button "Load consumption bins"#btnLoadBins (hidden)
      button "Apply directed put away"#btnUseDirectedPutAway (hidden)
      button "Extract from file"
      button "Authorize"#divAuthorise_StockReceived primary
      slot #divStockReceivedLines
      button "Add more items"#PurchaseAdvanced_StockReceived_AddRecordLink primary (hidden)
      button "Export"#divExport_StockReceived primary
      button "Import"#divImport_StockReceived primary
  block #divIdr (hidden)
    heading "AI recognition"
    button "Void"#btnDocExtBack
    button "Add and save"#btnDocExtSave primary (hidden)
    link "Upload"
    link "Mapping"
    link "Logs"
    tab pane#divDocumentImport
      slot #FeatureModuleDetailsBlock (hidden)
      slot #divLimitAlert (hidden)
      text "Extract invoice lines:"
      text "Use Intelligent Document Recognition (IDR) to extract information from purchase documents and add it to your purchase or"
      text "Document requirements:"
      block #divIdrPreviewTemplate (hidden)
      slot #ifrmIdrUploader (hidden)
      form#frmIdrUpload
        heading "Drop files here or click to upload."
      block #divProgressBar (hidden)
        slot #spnIdrFileName
        button "Cancel"#btnIdrFileCancel
      text "How AI recognition works Upload your file Parse and extract data automatically using AI. Map the extracted data to corre"
    tab pane#divDocumentExtraction
      input text#txtDocExtFileName read-only
      label "Import file name"
      slot #divMappingFields
      heading "File preview -"
      slot #ifrmFilePreview
    tab pane#divIdeLogs
      input text#divSearchLog placeholder "Type text to search"
      button "Search"#btnSearch primary
      button "Refresh"#divRefreshLog
      button #Grid_gridName_Options
      slot #logsGridContainer
  block #divCreditNote (hidden)
    slot #tdPurchase_CreditNote_Status
    heading "Credit note"
    button "Extract from file"
    block #divPurchaseAdvancedTask_CreditNote (hidden)
      button 
      button  primary
      button "Workflow"
      button 
      button "Calendar"
    block #CrNoteReports
      button "Email"#btnCreditNoteEmailMenu ▾
      slot #creditNoteEmailMenu
      button "Print"#btnCreditNotePrintMenu ▾
      slot #creditNotePrintMenu
    block #tabsList
    block #divInnerCreditNote (hidden)
      slot #tdPurchase_CreditNote_Number
      label "Credit note #*"
      slot #tdPurchase_CreditNote_Date
      label "Credit note date*"
      select#Purchase_CreditNote_SelectInvoice
      label "Credit note for"
      block #divPurchase_Index_CreditNoteCurrencyConversionRateBlock
        label ""
        input text#Purchase_Index_CreditNoteCurrencyConversionRate
        button #Purchase_Index_CreditNoteCurrencyConversionRate_GetRate
      button #divNewLine_CreditNote primary
      button "Copy from invoices"#btnCreditNote_CopyFromInvoices
      button "Authorize"#divAuthorise_CreditNote primary
      button "View in Xero"#divXero_CreditNote primary (hidden)
      slot #divCreditNoteLines
      button "Add more items"#PurchaseAdvanced_CreditNote_AddLinesRecordLink primary
      button #divNewAdditionalCostLine_CreditNote primary
      button "Expenses"#divDistributeExpenses_CreditNote primary (hidden)
      slot #divCreditNoteAdditionalCostLines
      button "Add more items"#PurchaseAdvanced_CreditNote_AddAdditionalCostLinesRecordLink primary
      table: Credit note lines | Additional costs | Total
      button "Refund"#divNewPayment_CreditNote primary
      button "Supplier deposit"#divNewPayment_CreditNote_Credit primary
      slot #divCreditNotePayments
      button "Add more items"#PurchaseAdvanced_CreditNote_AddPaymentLinesRecordLink primary (hidden)
      button "Supplier deposit"#PurchaseAdvanced_CreditNote_AddPaymentCreditLinesRecordLink primary (hidden)
      text "Balance due"#Purchase_CreditNote_BalanceHeader
      slot #Purchase_CreditNote_Balance
      text "Balance due"#Purchase_CreditNote_BalanceHeaderTenant
      slot #Purchase_CreditNote_BalanceTenant
    block #divInnerUnstock (hidden)
      block #purchaseUnstockNonInventoryWarning
      button "Copy from credit note"#divCopy_Unstock
      button "Authorize"#divAuthorise_Unstock primary
      slot #divUnstockLines
  block #divHistory (hidden)
    heading "Activity log"
    slot #divHistoryLines
    heading "Workflow activity log"
    slot #divWorkflowHistoryLines
  block #divAttributeSet (hidden)
    block #Purchase_divAttributeSet (hidden)
      heading "Additional attributes"
      block #Purchase_liCustomField1
        slot #Purchase_CustomField1
        label "Attribute 1"
      block #Purchase_liCustomField2
        slot #Purchase_CustomField2
        label "Attribute 2"
      block #Purchase_liCustomField3
        slot #Purchase_CustomField3
        label "Attribute 3"
      block #Purchase_liCustomField4
        slot #Purchase_CustomField4
        label "Attribute 4"
      block #Purchase_liCustomField5
        slot #Purchase_CustomField5
        label "Attribute 5"
      block #Purchase_liCustomField6
        slot #Purchase_CustomField6
        label "Attribute 6"
      block #Purchase_liCustomField7
        slot #Purchase_CustomField7
        label "Attribute 7"
      block #Purchase_liCustomField8
        slot #Purchase_CustomField8
        label "Attribute 8"
      block #Purchase_liCustomField9
        slot #Purchase_CustomField9
        label "Attribute 9"
      block #Purchase_liCustomField10
        slot #Purchase_CustomField10
        label "Attribute 10"
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
  block #divRelatedOrders (hidden)
    heading "Related orders"
    button "Refresh"#btnRefreshRelatedOrders
    slot #divRelatedOrdersDetails
  modal#PresetModal small
    heading "Name your pre-set"
    button "×"
    input text#PresetModal_Name
    label "Pre-set name"
    button "Save" primary
    button "Close"
slot #divPrint
form#frmClone
modal#divUploadPOLines medium
  heading "Upload a purchase order"
  button "×"
  heading "1. Download this purchase order"
  heading "2. Add new and modify existing products in the file."
  heading "3. Upload"
  block #UploadPOLinesExceptionsContainer (hidden)
    slot #UploadPOLinesExceptionsGrid
  block #divUploadContainer2
    form#frmDownloadOrder
      heading "Drop files here or click to upload."
  slot #ifrmDownloadOrder (hidden)
  slot #ifrmDownloadPOLines (hidden)
  form#frmDownloadPOLines
  button "Close"
modal#divUploadStockReceived medium
  heading "Upload stock received"
  button "×"
  heading "1. Download this stock received"
  heading "2. Add new and modify existing products in the file."
  heading "3. Upload"
  block #UploadStockReceivedLinesExceptionsContainer (hidden)
    slot #UploadStockReceivedLinesExceptionsGrid
  form#frmUploadStockReceived
    heading "Drop files here or click to upload."
  slot #ifrmUploadStockReceived (hidden)
  slot #ifrmDownloadStockReceived (hidden)
  form#frmDownloadStockReceived
  button "Close"
modal#divUploadInvoiceLines medium
  heading "Upload a bill"
  button "×"
  heading "1. Download this bill"
  heading "2. Add new and modify existing products in the file."
  heading "3. Upload"
  block #UploadInvoiceLinesExceptionsContainer (hidden)
    slot #UploadInvoiceLinesExceptionsGrid
  form#frmDownloadInvoice
    heading "Drop files here or click to upload."
  slot #ifrmDownloadInvoice (hidden)
  slot #ifrmDownloadInvoiceLines (hidden)
  form#frmDownloadInvoiceLines
  button "Close"
modal#divUploadIntermediateStockReceived medium
  heading "Upload stock received"
  button "×"
  heading "1. Download this stock received"
  heading "2. Add new and modify existing products in the file."
  heading "3. Upload"
  block #UploadIntermediateStockReceivedLinesExceptionsContainer (hidden)
    slot #UploadIntermediateStockReceivedLinesExceptionsGrid
  form#frmUploadIntermediateStockReceived
    heading "Drop files here or click to upload."
  slot #ifrmUploadIntermediateStockReceived (hidden)
  slot #ifrmDownloadIntermediateStockReceived (hidden)
  form#frmDownloadIntermediateStockReceived
  button "Close"
modal#dlgFamilyMatrix medium
  heading "Add a product family"
  button "×"
  slot #FamilyMatrix_cmbFamily
  label "Product family"
  input number#FamilyMatrix_txtPrice name=tdProductFamilyPrice
  label "Price" for #FamilyMatrix_txtPrice
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
modal#divScan medium
  heading "Scanning"
  button "×"
  tabs: Automatic #AutomaticMode_tab | Manual #ManualMode_tab | Inventory #InventoryMode_tab | Serial #AutomaticSerialMode_tab
  block #divScanBin
    slot #tdScanBin
    label "Bin (optional)" for #cmbScanLocation
  block #scanDesc
  block #scanBar
    block #dScan
      slot #spScan
  slot #ScanValidationContainer (hidden)
  input text#txtScanFocus
  block #divScanInfo (hidden)
    heading "Found product:"
    slot #divScanProductSelection (hidden)
    label "SKU"
    block #tdScanProductCode
    label "Name"
    block #tdScanName
    label "Barcode"
    block #tdScanBarcode
    block #liScanBatchSN (hidden)
      label "Batch/serial number"
      slot #tdScanBatchSN
    block #liScanExpiryDate (hidden)
      label "Expiry date"
      slot #tdScanExpiryDate
    block #liScanQuantity (hidden)
      label "Quantity"
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
  block #divScanInfoActions (hidden)
    button "Save"#liScanSave primary (hidden)
    button "Close"
  block #divScanAutoActions
    button "Close"
modal#divNewSupplierDialog medium
  heading "New supplier"
  button "×"
  input text#tdPurchase_NewSupplier_Name placeholder "Enter a supplier name"
  label "Name"
  select#tdPurchase_NewSupplier_PaymentTerm
  label "Payment term"
  block #divSupplierTaxRule
    select#tdPurchase_NewSupplier_TaxRule
    label "Tax rule"
  input text#tdPurchase_NewSupplier_Discount placeholder "Enter a supplier discount"
  label "Discount"
  slot #tdPurchase_NewSupplier_Currency
  label "Currency"
  select#tdPurchase_NewSupplier_AccountCode
  label "Account payable"
  select#tdPurchase_NewSupplier_DefaultCarrier
  label "Default carrier"
  block #divSupplierTaxNumber
    input text#tdPurchase_NewSupplier_TaxNumber placeholder "Enter a tax number"
    label "Tax number"
  textarea#tdPurchase_NewSupplier_Comments placeholder "Enter comments"
  label "Comments"
  button "Save" primary
  button "Close"
modal#Purchase_NewContact_Content medium
  heading "Add a supplier contact"
  button "×"
  input text#tdPurchase_NewContact_Name
  label "Name"
  input text#tdPurchase_NewContact_JobTitle
  label "Job title"
  input text#tdPurchase_NewContact_Phone
  label "Phone"
  input text#tdPurchase_NewContact_MobilePhone
  label "Mobile phone"
  input text#tdPurchase_NewContact_Fax
  label "Fax"
  input text#tdPurchase_NewContact_Email
  label "Email"
  input text#tdPurchase_NewContact_Website
  label "Website"
  input checkbox#tdPurchase_NewContact_IsDefault
  label "Default" for #tdPurchase_NewContact_IsDefault
  textarea#tdPurchase_NewContact_Comment
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
modal#Purchase_NewAddress_Content medium
  heading "Add a supplier address"
  button "×"
  slot #cmbVendorAddress
  button  primary
  label ""
  input text#tdPurchase_NewAddress_Line1
  label "Line 1"
  input text#tdPurchase_NewAddress_Line2
  label "Line 2"
  input text#tdPurchase_NewAddress_CitySuburb
  label "City / suburb"
  input text#tdPurchase_NewAddress_StateProvince
  label "State / province"
  input text#tdPurchase_NewAddress_ZipPostCode
  label "ZIP / postcode"
  select#tdPurchase_NewAddress_Country
  label "Country"
  block #SaleCommon_NewAddress_AvalaraTaxExemptionCode (hidden)
    slot #cmbAvalaraTaxExemptionCode_NewAddress
    label "Tax exemption reason"
  select#tdPurchase_NewAddress_Type: Billing | Business | Shipping
  label "Type"
  input checkbox#tdPurchase_NewAddress_DefaultForType
  label "Default for type" for #tdPurchase_NewAddress_DefaultForType
  button "Save" primary
  button "Close"
modal#Purchase_EditAddress_Content medium
  heading "Edit shipping address"
  button "×"
  input text#tdPurchase_EditAddress_Company
  label "Company"
  input text#tdPurchase_EditAddressContact
  label "Contact"
  input text#tdPurchase_EditAddress_Line1
  label "Line 1"
  input text#tdPurchase_EditAddress_Line2
  label "Line 2"
  input text#tdPurchase_EditAddress_CitySuburb
  label "City / suburb"
  input text#tdPurchase_EditAddress_ZipPostCode
  label "ZIP / postcode"
  input text#tdPurchase_EditAddress_StateProvince
  label "State / province"
  select#tdPurchase_EditAddress_Country
  label "Country"
  button "OK" primary
  button "Close"
modal#Purchase_NewTenantAddress_Content medium
  heading "Add company address"
  button "×"
  slot #cmbAddress
  button  primary
  label ""
  input text#tdPurchase_NewTenantAddress_Line1
  label "Line 1"
  input text#tdPurchase_NewTenantAddress_Line2
  label "Line 2"
  input text#tdPurchase_NewTenantAddress_CitySuburb
  label "City / suburb"
  input text#tdPurchase_NewTenantAddress_StateProvince
  label "State / province"
  input text#tdPurchase_NewTenantAddress_ZipPostCode
  label "ZIP / postcode"
  select#tdPurchase_NewTenantAddress_Country
  label "Country"
  block #SaleCommon_NewAddress_AvalaraTaxExemptionCode (hidden)
    slot #cmbAvalaraTaxExemptionCode_NewAddress
    label "Tax exemption reason"
  select#tdPurchase_NewTenantAddress_Type: Billing | Business | Shipping
  label "Type"
  input checkbox#tdPurchase_NewTenantAddress_DefaultForType
  label "Default for type" for #tdPurchase_NewTenantAddress_DefaultForType
  button "Save" primary
  button "Close"
modal#Purchase_NewLocation_Content small
  heading "Add a location"
  button 
  slot #Product_NewLocation_ValidationContainer
  input text#tdPurchase_NewLocation_Description
  label "Location" for #stocktakeSortingDropdown
  button "Save" primary
  button "Close"
modal#divNewProductDialog medium
  heading "Add a new product"
  button "×"
  input text#tdPurchase_NewProduct_ProductCode placeholder "Enter a product SKU"
  label "SKU"
  input text#tdPurchase_NewProduct_Name placeholder "Enter a product name"
  label "Name"
  select#tdPurchase_NewProduct_Type
  label "Type"
  block #FixedAssetTypeRow
    select#tdPurchase_NewProduct_FixedAssetType
    label "Fixed asset type"
  select#tdPurchase_NewProduct_Category
  label "Category"
  select#tdPurchase_NewProduct_PurchaseTaxRule
  label "Purchase tax rule"
  slot #tdPurchase_NewProduct_SaleTaxRule
  label "Sale tax rule"
  select#tdPurchase_NewProduct_UnitOfMeasure
  label "Unit of measure"
  block #trCostingMethod
    select#tdPurchase_NewProduct_CostingMethod
    label "Costing method"
  block #trExpenseAccount
    select#tdPurchase_NewProduct_ExpenseAccount
    label "Expense account"
  block #trMinimumBeforeReorder
    input text#tdPurchase_NewProduct_MinimumBeforeReorder placeholder "Enter a minimum before reorder."
    label "Minimum before reorder"
  block #trReorderQuantity
    input text#tdPurchase_NewProduct_ReorderQuantity placeholder "Enter reorder quantity"
    label "Reorder quantity"
  input text#tdPurchase_NewProduct_Barcode placeholder "Enter a barcode"
  label "Barcode"
  block #trStockLocator
    input text#tdPurchase_NewProduct_StockLocator placeholder "Enter a stock locator"
    label "Stock locator"
  select#tdPurchase_NewProduct_ProductAttributeSet
  label "Attribute set"
  slot #divAdditionalAttributes_NewProduct
  block #AdditionalAttributes_FieldTemplate (hidden)
    slot #{CustomField}
    label "" for #{CustomField}
  button "Save" primary
  button "Close"
modal#Purchase_NewDeposit_Content small
  heading #Purchase_NewDeposit_Title
  button "×"
  slot #Purchase_NewDeposit_Account
  label "Deposit account"
  block #Purchase_NewDeposit_BankAcocuntBlock
    slot #Purchase_NewDeposit_BankAccount
    label "Account"
  input text#Purchase_NewDeposit_Reference
  label "Reference"
  slot #Purchase_NewDeposit_DatePaid
  label "Date paid"
  input text#Purchase_NewDeposit_Amount
  label "Amount"
  block #liPurchase_NewDeposit_ConversionRate
    input text#Purchase_NewDeposit_ConversionRate
    button #Purchase_NewDeposit_ConversionRate_GetRate
    label "Conversion rate"
  block #Purchase_NewDeposit_BaseAmountBlock (hidden)
    slot #Purchase_NewDeposit_BaseAmountLabel
    slot #Purchase_NewDeposit_BaseAmount
  button "Create" primary
  button "Close"
modal#Purchase_NewPayment_Content small
  heading "Add a payment"
  button "×"
  slot #Purchase_NewPayment_Account
  label "Account"
  input text#Purchase_NewPayment_Reference
  label "Reference"
  slot #Purchase_NewPayment_DatePaid
  label "Date paid"
  input text#Purchase_NewPayment_Amount
  label "Amount"
  block #liPurchase_NewPayment_ConversionRate
    input text#Purchase_NewPayment_ConversionRate
    button #Purchase_NewPayment_ConversionRate_GetRate
    label "Conversion rate"
  block #liPurchase_NewPayment_BaseAmount (hidden)
    slot #Purchase_NewPayment_BaseAmount
  button "Create" primary
  button "Close"
block #Purchase_NewAllocation (hidden)
  block #Purchase_NewAllocation_Content
    heading "Allocate supplier deposit as payment"
    button "Add and save"#Purchase_NewAllocation_SaveAction primary
    button "Cancel"#Purchase_NewAllocation_CancelAction
    heading "Select existing supplier deposit(s)"
    slot #Purchase_NewAllocation_Deposits
    heading "Allocation(s) that will be created"
    slot #Purchase_NewAllocation_Allocations
    table
    button "Add and save"#Purchase_NewAllocation_SaveAction2 primary
    button "Cancel"#Purchase_NewAllocation_CancelAction2
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
modal#divCOGSAccDims small
  heading "Accounting dimensions"
  button "×"
  button "Save"#btnSaveCOGSAccDims primary
  button "Close"
slot #divExpenseDestributionContainer
slot #CountrySpecificScript
```

### `/PurchaseCreditNote`: Purchase credit note

Frame: `iUpload`.

```text
link "Home"
link "Purchases"
button "Save"#saveAction primary
button "Save"#btnSaveDistribution (hidden)
button "Back to list"#backAction
button "Undo"#undoAction
button "Void"#voidAction
block #moreActionsBlock (hidden)
  button "More actions"#moreActions
  link "Undo"#undoAction_more (hidden)
  link "Void"#voidAction_more (hidden)
block #divMainContent
  block #Purchase_Index_Status
  heading 
  block #divPurchaseTask (hidden)
    button 
    button  primary
    button "Workflow"
    button 
    button "Calendar"
  button "Email"#tabPurchaseCreditNoteEmailAction ▾
  menu: 
  button "Print"#tabPurchaseCreditNotePrintAction ▾
  menu: 
  button 
  block #divTaskHeader
    slot #Purchase_Index_Supplier
    label "Supplier*" for #cmbSupplier
    slot #Purchase_Index_Contact
    label "Contact" for #cmbContact
    slot #Purchase_Index_Phone
    label "Phone" for #txtPhone
    slot #Purchase_Index_VendorAddressLine1
    label "Vendor address line 1" for #cmbVendorAddressLine1
    slot #Purchase_Index_VendorAddressLine2
    label "Vendor address line 2" for #txtVendorAddressLine2
    slot #tdPurchase_CreditNote_Date
    label "Credit note date*" for #tdPurchase_CreditNote_Date
    slot #Purchase_Index_Terms
    label "Terms" for #cmbTerms
    slot #Purchase_Index_ShipmentRequiredByDate
    label "Required by" for #dtShipmentRequiredByDate
    block #divRate
      slot #tdPurchase_Index_CurrencyConversionRate
      label "Rate" for #Purchase_Index_CurrencyConversionRate
    slot #Purchase_Index_Tax
    label "Tax rule*" for #cmbTax
    slot #PurchaseCreditNote_Index_Tax_Inclusive
    label "Tax inclusive" for #chkPurchaseCreditNote_Index_Tax_Inclusive
    slot #tdPurchase_Index_DefaultAccount
    label "Inventory account" for #Purchase_Index_DefaultAccount
    slot #divDefaultAccount (hidden)
  link "Logs and attributes"
  block #divCreditNote (hidden)
    button #divNewAdditionalCostLine_CreditNote primary
    button "Expenses"#divDistributeExpenses_CreditNote (hidden)
    button "Extract from file"
    button "Authorize"#divAuthorise_CreditNote primary
    button "View in Xero"#divXero_CreditNote (hidden)
    slot #divCreditNoteAdditionalCostLines
    button "Add more items"#PurchaseCreditNote_CreditNote_AddAdditionalCostLinesRecordLink primary (hidden)
    label "Credit note memo" for #Purchase_Index_PurchaseOrderMemo
    textarea#Purchase_Index_PurchaseOrderMemo placeholder "Write your note here..."
    table: Total
    button "Refund"#divNewPayment_CreditNote primary
    button "Supplier deposit"#divNewPayment_CreditNote_Credit
    slot #divCreditNotePayments
    button "Add more items"#PurchaseCreditNote_CreditNote_AddPaymentLinesRecordLink primary (hidden)
    button "Supplier deposit"#PurchaseCreditNote_CreditNote_AddPaymentCreditLinesRecordLink primary (hidden)
    text "Balance due"#Purchase_CreditNote_BalanceHeader
    slot #Purchase_CreditNote_Balance
    text "Balance due"#Purchase_CreditNote_BalanceHeaderTenant (hidden)
    slot #Purchase_CreditNote_BalanceTenant (hidden)
  block #divHistory (hidden)
    heading "Logs and attributes"
    block #Purchase_divAttributeSet (hidden)
      heading "Additional attributes"
      block #Purchase_liCustomField1
        slot #Purchase_CustomField1
        label "Attribute 1"
      block #Purchase_liCustomField2
        slot #Purchase_CustomField2
        label "Attribute 2"
      block #Purchase_liCustomField3
        slot #Purchase_CustomField3
        label "Attribute 3"
      block #Purchase_liCustomField4
        slot #Purchase_CustomField4
        label "Attribute 4"
      block #Purchase_liCustomField5
        slot #Purchase_CustomField5
        label "Attribute 5"
      block #Purchase_liCustomField6
        slot #Purchase_CustomField6
        label "Attribute 6"
      block #Purchase_liCustomField7
        slot #Purchase_CustomField7
        label "Attribute 7"
      block #Purchase_liCustomField8
        slot #Purchase_CustomField8
        label "Attribute 8"
      block #Purchase_liCustomField9
        slot #Purchase_CustomField9
        label "Attribute 9"
      block #Purchase_liCustomField10
        slot #Purchase_CustomField10
        label "Attribute 10"
    heading "Activity log"
    slot #divHistoryLines
    heading "Workflow activity log"
    slot #divWorkflowHistoryLines
  block #divAttachments (hidden)
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
block #divIdr (hidden)
  heading "AI recognition"
  button "Void"#btnDocExtBack
  button "Add and save"#btnDocExtSave primary (hidden)
  link "Upload"
  link "Mapping"
  link "Logs"
  tab pane#divDocumentImport
    slot #FeatureModuleDetailsBlock (hidden)
    slot #divLimitAlert (hidden)
    text "Extract invoice lines:"
    text "Use Intelligent Document Recognition (IDR) to extract information from purchase documents and add it to your purchase or"
    text "Document requirements:"
    block #divIdrPreviewTemplate (hidden)
    slot #ifrmIdrUploader (hidden)
    form#frmIdrUpload
      heading "Drop files here or click to upload."
    block #divProgressBar (hidden)
      slot #spnIdrFileName
      button "Cancel"#btnIdrFileCancel
    text "How AI recognition works Upload your file Parse and extract data automatically using AI. Map the extracted data to corre"
  tab pane#divDocumentExtraction
    input text#txtDocExtFileName read-only
    label "Import file name"
    slot #divMappingFields
    heading "File preview -"
    slot #ifrmFilePreview
  tab pane#divIdeLogs
    input text#divSearchLog placeholder "Type text to search"
    button "Search"#btnSearch primary
    button "Refresh"#divRefreshLog
    button #Grid_gridName_Options
    slot #logsGridContainer
slot #divPrint
form#frmClone
modal#divNewSupplierDialog medium
  heading "New supplier"
  button "×"
  input text#tdPurchase_NewSupplier_Name placeholder "Enter a supplier name"
  label "Name"
  select#tdPurchase_NewSupplier_PaymentTerm
  label "Payment term"
  block #divSupplierTaxRule
    select#tdPurchase_NewSupplier_TaxRule
    label "Tax rule"
  input text#tdPurchase_NewSupplier_Discount placeholder "Enter a supplier discount"
  label "Discount"
  slot #tdPurchase_NewSupplier_Currency
  label "Currency"
  select#tdPurchase_NewSupplier_AccountCode
  label "Account payable"
  select#tdPurchase_NewSupplier_DefaultCarrier
  label "Default carrier"
  block #divSupplierTaxNumber
    input text#tdPurchase_NewSupplier_TaxNumber placeholder "Enter a tax number"
    label "Tax number"
  textarea#tdPurchase_NewSupplier_Comments placeholder "Enter comments"
  label "Comments"
  button "Save" primary
  button "Close"
modal#Purchase_NewContact_Content medium
  heading "Add a supplier contact"
  button "×"
  input text#tdPurchase_NewContact_Name
  label "Name"
  input text#tdPurchase_NewContact_JobTitle
  label "Job title"
  input text#tdPurchase_NewContact_Phone
  label "Phone"
  input text#tdPurchase_NewContact_MobilePhone
  label "Mobile phone"
  input text#tdPurchase_NewContact_Fax
  label "Fax"
  input text#tdPurchase_NewContact_Email
  label "Email"
  input text#tdPurchase_NewContact_Website
  label "Website"
  input checkbox#tdPurchase_NewContact_IsDefault
  label "Default" for #tdPurchase_NewContact_IsDefault
  textarea#tdPurchase_NewContact_Comment
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
modal#Purchase_NewAddress_Content medium
  heading "Add a supplier address"
  button "×"
  slot #cmbVendorAddress
  button  primary
  label ""
  input text#tdPurchase_NewAddress_Line1
  label "Line 1"
  input text#tdPurchase_NewAddress_Line2
  label "Line 2"
  input text#tdPurchase_NewAddress_CitySuburb
  label "City / suburb"
  input text#tdPurchase_NewAddress_StateProvince
  label "State / province"
  input text#tdPurchase_NewAddress_ZipPostCode
  label "ZIP / postcode"
  select#tdPurchase_NewAddress_Country
  label "Country"
  block #SaleCommon_NewAddress_AvalaraTaxExemptionCode (hidden)
    slot #cmbAvalaraTaxExemptionCode_NewAddress
    label "Tax exemption reason"
  select#tdPurchase_NewAddress_Type: Billing | Business | Shipping
  label "Type"
  input checkbox#tdPurchase_NewAddress_DefaultForType
  label "Default for type" for #tdPurchase_NewAddress_DefaultForType
  button "Save" primary
  button "Close"
modal#Purchase_EditAddress_Content medium
  heading "Edit shipping address"
  button "×"
  input text#tdPurchase_EditAddress_Company
  label "Company"
  input text#tdPurchase_EditAddressContact
  label "Contact"
  input text#tdPurchase_EditAddress_Line1
  label "Line 1"
  input text#tdPurchase_EditAddress_Line2
  label "Line 2"
  input text#tdPurchase_EditAddress_CitySuburb
  label "City / suburb"
  input text#tdPurchase_EditAddress_ZipPostCode
  label "ZIP / postcode"
  input text#tdPurchase_EditAddress_StateProvince
  label "State / province"
  select#tdPurchase_EditAddress_Country
  label "Country"
  button "OK" primary
  button "Close"
modal#Purchase_NewTenantAddress_Content medium
  heading "Add company address"
  button "×"
  slot #cmbAddress
  button  primary
  label ""
  input text#tdPurchase_NewTenantAddress_Line1
  label "Line 1"
  input text#tdPurchase_NewTenantAddress_Line2
  label "Line 2"
  input text#tdPurchase_NewTenantAddress_CitySuburb
  label "City / suburb"
  input text#tdPurchase_NewTenantAddress_StateProvince
  label "State / province"
  input text#tdPurchase_NewTenantAddress_ZipPostCode
  label "ZIP / postcode"
  select#tdPurchase_NewTenantAddress_Country
  label "Country"
  block #SaleCommon_NewAddress_AvalaraTaxExemptionCode (hidden)
    slot #cmbAvalaraTaxExemptionCode_NewAddress
    label "Tax exemption reason"
  select#tdPurchase_NewTenantAddress_Type: Billing | Business | Shipping
  label "Type"
  input checkbox#tdPurchase_NewTenantAddress_DefaultForType
  label "Default for type" for #tdPurchase_NewTenantAddress_DefaultForType
  button "Save" primary
  button "Close"
modal#Purchase_NewLocation_Content small
  heading "Add a location"
  button 
  slot #Product_NewLocation_ValidationContainer
  input text#tdPurchase_NewLocation_Description
  label "Location" for #stocktakeSortingDropdown
  button "Save" primary
  button "Close"
modal#divNewProductDialog medium
  heading "Add a new product"
  button "×"
  input text#tdPurchase_NewProduct_ProductCode placeholder "Enter a product SKU"
  label "SKU"
  input text#tdPurchase_NewProduct_Name placeholder "Enter a product name"
  label "Name"
  select#tdPurchase_NewProduct_Type
  label "Type"
  block #FixedAssetTypeRow
    select#tdPurchase_NewProduct_FixedAssetType
    label "Fixed asset type"
  select#tdPurchase_NewProduct_Category
  label "Category"
  select#tdPurchase_NewProduct_PurchaseTaxRule
  label "Purchase tax rule"
  slot #tdPurchase_NewProduct_SaleTaxRule
  label "Sale tax rule"
  select#tdPurchase_NewProduct_UnitOfMeasure
  label "Unit of measure"
  block #trCostingMethod
    select#tdPurchase_NewProduct_CostingMethod
    label "Costing method"
  block #trExpenseAccount
    select#tdPurchase_NewProduct_ExpenseAccount
    label "Expense account"
  block #trMinimumBeforeReorder
    input text#tdPurchase_NewProduct_MinimumBeforeReorder placeholder "Enter a minimum before reorder."
    label "Minimum before reorder"
  block #trReorderQuantity
    input text#tdPurchase_NewProduct_ReorderQuantity placeholder "Enter reorder quantity"
    label "Reorder quantity"
  input text#tdPurchase_NewProduct_Barcode placeholder "Enter a barcode"
  label "Barcode"
  block #trStockLocator
    input text#tdPurchase_NewProduct_StockLocator placeholder "Enter a stock locator"
    label "Stock locator"
  select#tdPurchase_NewProduct_ProductAttributeSet
  label "Attribute set"
  slot #divAdditionalAttributes_NewProduct
  block #AdditionalAttributes_FieldTemplate (hidden)
    slot #{CustomField}
    label "" for #{CustomField}
  button "Save" primary
  button "Close"
modal#Purchase_NewDeposit_Content small
  heading #Purchase_NewDeposit_Title
  button "×"
  slot #Purchase_NewDeposit_Account
  label "Deposit account"
  block #Purchase_NewDeposit_BankAcocuntBlock
    slot #Purchase_NewDeposit_BankAccount
    label "Account"
  input text#Purchase_NewDeposit_Reference
  label "Reference"
  slot #Purchase_NewDeposit_DatePaid
  label "Date paid"
  input text#Purchase_NewDeposit_Amount
  label "Amount"
  block #liPurchase_NewDeposit_ConversionRate
    input text#Purchase_NewDeposit_ConversionRate
    button #Purchase_NewDeposit_ConversionRate_GetRate
    label "Conversion rate"
  block #Purchase_NewDeposit_BaseAmountBlock (hidden)
    slot #Purchase_NewDeposit_BaseAmountLabel
    slot #Purchase_NewDeposit_BaseAmount
  button "Create" primary
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
slot #divExpenseDestributionContainer
slot #CountrySpecificScript
```

### `/PurchaseList`: Purchases

Frame: `task-upload-frame`.

```text
link "Home"
link "General"#vGeneral
link "Accounting"#vAccounting
block #divList
  block #bulkValidationSummary
    block #bulkActionsNoteSuccess (hidden)
    block #bulkActionsNoteWarning (hidden)
    block #bulkActionsNoteError (hidden)
  button #divNew primary
  input text#divSearch placeholder "Type text to search"
  button "Search" primary
  block #divFilterGeneralContainer (hidden)
    select#divFilterGeneral
  block #divFilterAccountingContainer (hidden)
    select#divFilterAccounting
  button #divRefresh
  button "Import"#tImport
  block #GridOptions_GeneralContainer
    button #Grid_gridName_Options1
  block #GridOptions_AccountingContainer
    button #Grid_gridName_Options2
  block #divBulkActions
    slot #lSelectedCounter
    button "Undo"#undoAction
    button "Print" ▾
    slot #printDropdownList
    button "Email" ▾
    slot #emailDropdownList
    button "Export" ▾
    link "Export accounts payable"
    link "Export to CSV format"
    button "Merge"#mergeAction
    button "Void"#voidAction
  slot #BulkActions_List (hidden)
  slot #BulkActionsAccounting_List (hidden)
  form#frmPrintList
  form#frmExportCsv
  form#frmExportXero
  slot #PurchaseList_Index_GeneralContainer
  slot #PurchaseList_Index_AccountingContainer (hidden)
modal#divPurchase_Merge_ContentDialog medium
  heading "Merge purchases"
  button "×"
  block #Purchase_Merge_ValidationContainerSuccess
    text "Merging rules:"
    text "Please note: Merging is not reversible."
  block #Purchase_Merge_ValidationContainerWarning (hidden)
  block #Purchase_Merge_ValidationContainerError (hidden)
  text "Select Primary Purchase"
  text "Primary purchase will be used as a template for a newly created purchase"
  select#tdPrimaryMergePurchase
  label "Primary purchase" for #cmbPrimaryMergeSupplier
  button "Merge"#Purchase_Merge_Execute
  button "Close"
modal#dlgReCaptchaModal small
  heading "CAPTCHA verification"#dlgReCaptchaModalCaption
  button "×"
  block #emailReCaptcha
  button "Continue"#dlgReCaptchaModal_continue primary
  button "Close"
```

### `/PurchaseService`: Service purchase

Frame: `ifrmIdrUploader`.

```text
link "Home"
link "Purchases"
button "Save"#saveAction primary
button "Save"#btnSaveDistribution (hidden)
button "Back to list"#backAction
block #taskActions
  button "Clone"#cloneAction
  button "Archive"#divArchive
button "Undo"#undoAction
button "Void"#voidAction
block #moreActionsBlock (hidden)
  button "More actions"#moreActions
  link "Undo"#undoAction_more (hidden)
  link "Void"#voidAction_more (hidden)
  link "Clone"#cloneAction_more (hidden)
  link "Archive"#divArchive_more (hidden)
block #divMainContent
  block #Purchase_Index_Status
  heading 
  block #divArchiveStatic (hidden)
  block #divApproveStatic (hidden)
  button "Save as preset"#btnSavePreset primary
  select#cmbPresetList
  button "Delete preset"#btnDeletePreset
  block #divPurchaseTask (hidden)
    button 
    button  primary
    button "Workflow"
    button 
    button "Calendar"
  button 
  block #divTaskHeader
    slot #Purchase_ValidationContainer
    slot #Purchase_Index_Supplier
    label "Supplier*" for #cmbSupplier
    slot #Purchase_Index_Contact
    label "Contact" for #cmbContact
    slot #Purchase_Index_Phone
    label "Phone" for #txtPhone
    slot #Purchase_Index_VendorAddressLine1
    label "Vendor address line 1" for #cmbVendorAddressLine1
    slot #Purchase_Index_VendorAddressLine2
    label "Vendor address line 2" for #txtVendorAddressLine2
    slot #Purchase_Index_Terms
    label "Terms" for #cmbTerms
    slot #Purchase_Index_ShipmentRequiredByDate
    label "Required by" for #dtShipmentRequiredByDate
    block #divRate
      slot #tdPurchase_Index_CurrencyConversionRate
      label "Rate" for #Purchase_Index_CurrencyConversionRate
    slot #tdPurchase_Index_DefaultAccount
    label "Inventory account" for #Purchase_Index_DefaultAccount
    slot #PurchaseService_Index_Tax_Inclusive
    label "Tax inclusive" for #chkPurchaseService_Index_Tax_Inclusive
    slot #Purchase_Index_Tax
    label "Tax rule*" for #cmbTax
    block #liInvoiceNo
      input text#Purchase_Index_SupplierReference
      label "Invoice #"
    slot #Purchase_Index_BlindReceipt
    label "Skip order" for #chkBlindReceipt
    slot #Purchase_Index_Date
    label "Date" for #dtDate
    slot #Purchase_Index_Location
    label "Location*" for #cmbLocation
    slot #Purchase_Index_HeaderShipToOther
    label "Ship to different company" for #chkHeaderShipToOther
    button #Purchase_Index_EditOtherAddress primary
    block #Purchase_Index_CustomerAddress
      slot #Purchase_Index_SippingAddressLine1
      label "Shipping address line 1"
      slot #Purchase_Index_SippingAddressLine2
      label "Shipping address line 2"
    block #Purchase_Index_RecepientAddress (hidden)
      input text#tdPurchase_Index_ShipToCompanyContact placeholder "Please enter the shipping contact..." read-only
      textarea#tdPurchase_Index_ShipToAddress placeholder "Please enter the address..."
    heading "Note"
    block #divNote
      textarea#divStickyNote placeholder "Write your note here..."
  slot #downloadPrint (hidden)
  button "Order"
  button "Invoice"
  button "Credit note"
  button "Manual journals"
  button "Attachments"
  button "Logs and attributes"
  button "Financials"
  block #divOrder (hidden)
    heading "Order"
    block #purchaseService_PrintEmail
      button "Email"#divEmail ▾
      button "Print"#divPrint ▾
    button "Authorize"#divAuthorise_Order primary
    button "Approve"#btApprove primary (hidden)
    button "Reject"#btReject (hidden)
    button "Review"#btReview (hidden)
    button #divNewAdditionalCostLine_Order primary
    slot #divOrderAdditionalCostLines
    button "Add more items"#PurchaseService_Order_AddAdditionalCostLinesRecordLink primary
    label "Purchase order memo" for #Purchase_Index_PurchaseOrderMemo
    textarea#Purchase_Index_PurchaseOrderMemo placeholder "Write your note here..."
    table: Total
    block #divNewPayment_Order
      button "Supplier deposit"#btnNewPayment_Order primary
    slot #divDeposits
    button "Add more items"#PurchaseService_Order_AddDepositsRecordLink primary
    text "Balance due"#Purchase_Order_BalanceHeader
    slot #Purchase_Order_Balance
    text "Balance due"#Purchase_Order_BalanceHeaderTenant
    slot #Purchase_Order_BalanceTenant
  block #divInvoice (hidden)
    heading "Invoice"
    button "Extract from file"
    block #purchaseServiceInvoice_PrintEmail
      button "Email"#divEmailInvoice ▾
      button "Print"#divPrintInvoice ▾
    button "Authorize"#divAuthorise_Invoice primary
    slot #tdPurchase_Invoice_Number
    label "Invoice number*" for #Purchase_Invoice_Number
    slot #tdPurchase_Invoice_Date
    label "Invoice date*" for #Purchase_Invoice_Date
    slot #tdPurchase_Invoice_DueDate
    label "Due date*" for #Purchase_Invoice_DueDate
    slot #tdPurchase_Invoice_Total
    label "TOTAL*" for #Purchase_Invoice_Total
    button "View in Xero"#divXero_Invoice primary (hidden)
    button "Expenses"#divDistributeExpenses primary (hidden)
    button #divNewAdditionalCostLine_Invoice primary
    button "Copy from order"#divCopyAdditionalCostLine_Invoice
    slot #divInvoiceAdditionalCostLines
    button "Add more items"#PurchaseService_Invoice_AddAdditionalCostLinesRecordLink primary
    table: Total
    block #divInvoicePaymentsButtonSet
      button "Payment"#divNewPayment_Invoice primary
      button "Use supplier deposit"#divNewPaymentAllocation_Invoice primary
      button "Pay with Settle"#divNewPaymentSettle_Invoice primary (hidden)
      button "Pay with Airwallex"#divNewPaymentAirwallex_Invoice primary (hidden)
    slot #divInvoicePayments
    button "Payment"#PurchaseService_Invoice_AddPaymentLinesRecordLink primary
    button "Use supplier deposit"#PurchaseService_Invoice_AddPaymentAllocationsLink primary
    text "Balance due"#Purchase_Invoice_BalanceHeader
    slot #Purchase_Invoice_Balance
    text "Balance due"#Purchase_Invoice_BalanceHeaderTenant
    slot #Purchase_Invoice_BalanceTenant
  block #divIdr (hidden)
    heading "AI recognition"
    button "Void"#btnDocExtBack
    button "Add and save"#btnDocExtSave primary (hidden)
    link "Upload"
    link "Mapping"
    link "Logs"
    tab pane#divDocumentImport
      slot #FeatureModuleDetailsBlock (hidden)
      slot #divLimitAlert (hidden)
      text "Extract invoice lines:"
      text "Use Intelligent Document Recognition (IDR) to extract information from purchase documents and add it to your purchase or"
      text "Document requirements:"
      block #divIdrPreviewTemplate (hidden)
      slot #ifrmIdrUploader (hidden)
      form#frmIdrUpload
        heading "Drop files here or click to upload."
      block #divProgressBar (hidden)
        slot #spnIdrFileName
        button "Cancel"#btnIdrFileCancel
      text "How AI recognition works Upload your file Parse and extract data automatically using AI. Map the extracted data to corre"
    tab pane#divDocumentExtraction
      input text#txtDocExtFileName read-only
      label "Import file name"
      slot #divMappingFields
      heading "File preview -"
      slot #ifrmFilePreview
    tab pane#divIdeLogs
      input text#divSearchLog placeholder "Type text to search"
      button "Search"#btnSearch primary
      button "Refresh"#divRefreshLog
      button #Grid_gridName_Options
      slot #logsGridContainer
  block #divCreditNote (hidden)
    heading "Credit note"
    button "Extract from file"
    block #purchaseServiceCreditNote_PrintEmail
      button "Email"#divEmailCreditNote ▾
      button "Print"#divPrintCreditNote ▾
    button "Authorize"#divAuthorise_CreditNote primary
    slot #tdPurchase_CreditNote_Number
    label "Credit note #*" for #Purchase_CreditNote_Number
    slot #tdPurchase_CreditNote_Date
    label "Credit note date*" for #tdPurchase_CreditNote_Date
    button "Expenses"#divDistributeExpenses_CreditNote primary (hidden)
    button #divNewAdditionalCostLine_CreditNote primary
    button "Copy"#divCopyAdditionalCostLines_CreditNote
    button "Void credit note"#divVoid_CreditNote
    button "View in Xero"#divXero_CreditNote primary (hidden)
    slot #divCreditNoteAdditionalCostLines
    button "Add more items"#PurchaseService_CreditNote_AddAdditionalCostLinesRecordLink primary (hidden)
    table: Total
    block #divInvoicePaymentsButtonSet
      button "Refund"#divNewPayment_CreditNote primary
      button "Supplier deposit"#divNewPayment_CreditNote_Credit primary
    slot #divCreditNotePayments
    button "Add more items"#PurchaseService_CreditNote_AddPaymentLinesRecordLink primary (hidden)
    button "Supplier deposit"#PurchaseService_CreditNote_AddPaymentCreditLinesRecordLink primary (hidden)
    text "Balance due"#Purchase_CreditNote_BalanceHeader
    slot #Purchase_CreditNote_Balance
    text "Balance due"#Purchase_CreditNote_BalanceHeaderTenant
    slot #Purchase_CreditNote_BalanceTenant
  block #divManualJournals (hidden)
    heading "Manual journals"
    button "Authorize"#divAuthorise_ManualJournals primary
    button #divNew_ManualJournals primary
    button "Undo journals"#divUndo_Journals
    slot #divManualJournalsLines
    button "Add more items"#PurchaseService_ManualJournals_AddLineLink primary (hidden)
  block #divHistory (hidden)
    heading "Logs and attributes"
    block #Purchase_divAttributeSet (hidden)
      heading "Additional attributes"
      block #Purchase_liCustomField1
        slot #Purchase_CustomField1
        label "Attribute 1"
      block #Purchase_liCustomField2
        slot #Purchase_CustomField2
        label "Attribute 2"
      block #Purchase_liCustomField3
        slot #Purchase_CustomField3
        label "Attribute 3"
      block #Purchase_liCustomField4
        slot #Purchase_CustomField4
        label "Attribute 4"
      block #Purchase_liCustomField5
        slot #Purchase_CustomField5
        label "Attribute 5"
      block #Purchase_liCustomField6
        slot #Purchase_CustomField6
        label "Attribute 6"
      block #Purchase_liCustomField7
        slot #Purchase_CustomField7
        label "Attribute 7"
      block #Purchase_liCustomField8
        slot #Purchase_CustomField8
        label "Attribute 8"
      block #Purchase_liCustomField9
        slot #Purchase_CustomField9
        label "Attribute 9"
      block #Purchase_liCustomField10
        slot #Purchase_CustomField10
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
  modal#PresetModal small
    heading "Name your pre-set"
    button "×"
    input text#PresetModal_Name
    label "Pre-set name"
    button "Save" primary
    button "Close"
form#frmClone
modal#divNewSupplierDialog medium
  heading "New supplier"
  button "×"
  input text#tdPurchase_NewSupplier_Name placeholder "Enter a supplier name"
  label "Name"
  select#tdPurchase_NewSupplier_PaymentTerm
  label "Payment term"
  block #divSupplierTaxRule
    select#tdPurchase_NewSupplier_TaxRule
    label "Tax rule"
  input text#tdPurchase_NewSupplier_Discount placeholder "Enter a supplier discount"
  label "Discount"
  slot #tdPurchase_NewSupplier_Currency
  label "Currency"
  select#tdPurchase_NewSupplier_AccountCode
  label "Account payable"
  select#tdPurchase_NewSupplier_DefaultCarrier
  label "Default carrier"
  block #divSupplierTaxNumber
    input text#tdPurchase_NewSupplier_TaxNumber placeholder "Enter a tax number"
    label "Tax number"
  textarea#tdPurchase_NewSupplier_Comments placeholder "Enter comments"
  label "Comments"
  button "Save" primary
  button "Close"
modal#Purchase_NewContact_Content medium
  heading "Add a supplier contact"
  button "×"
  input text#tdPurchase_NewContact_Name
  label "Name"
  input text#tdPurchase_NewContact_JobTitle
  label "Job title"
  input text#tdPurchase_NewContact_Phone
  label "Phone"
  input text#tdPurchase_NewContact_MobilePhone
  label "Mobile phone"
  input text#tdPurchase_NewContact_Fax
  label "Fax"
  input text#tdPurchase_NewContact_Email
  label "Email"
  input text#tdPurchase_NewContact_Website
  label "Website"
  input checkbox#tdPurchase_NewContact_IsDefault
  label "Default" for #tdPurchase_NewContact_IsDefault
  textarea#tdPurchase_NewContact_Comment
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
modal#Purchase_NewAddress_Content medium
  heading "Add a supplier address"
  button "×"
  slot #cmbVendorAddress
  button  primary
  label ""
  input text#tdPurchase_NewAddress_Line1
  label "Line 1"
  input text#tdPurchase_NewAddress_Line2
  label "Line 2"
  input text#tdPurchase_NewAddress_CitySuburb
  label "City / suburb"
  input text#tdPurchase_NewAddress_StateProvince
  label "State / province"
  input text#tdPurchase_NewAddress_ZipPostCode
  label "ZIP / postcode"
  select#tdPurchase_NewAddress_Country
  label "Country"
  block #SaleCommon_NewAddress_AvalaraTaxExemptionCode (hidden)
    slot #cmbAvalaraTaxExemptionCode_NewAddress
    label "Tax exemption reason"
  select#tdPurchase_NewAddress_Type: Billing | Business | Shipping
  label "Type"
  input checkbox#tdPurchase_NewAddress_DefaultForType
  label "Default for type" for #tdPurchase_NewAddress_DefaultForType
  button "Save" primary
  button "Close"
modal#Purchase_EditAddress_Content medium
  heading "Edit shipping address"
  button "×"
  input text#tdPurchase_EditAddress_Company
  label "Company"
  input text#tdPurchase_EditAddressContact
  label "Contact"
  input text#tdPurchase_EditAddress_Line1
  label "Line 1"
  input text#tdPurchase_EditAddress_Line2
  label "Line 2"
  input text#tdPurchase_EditAddress_CitySuburb
  label "City / suburb"
  input text#tdPurchase_EditAddress_ZipPostCode
  label "ZIP / postcode"
  input text#tdPurchase_EditAddress_StateProvince
  label "State / province"
  select#tdPurchase_EditAddress_Country
  label "Country"
  button "OK" primary
  button "Close"
modal#Purchase_NewTenantAddress_Content medium
  heading "Add company address"
  button "×"
  slot #cmbAddress
  button  primary
  label ""
  input text#tdPurchase_NewTenantAddress_Line1
  label "Line 1"
  input text#tdPurchase_NewTenantAddress_Line2
  label "Line 2"
  input text#tdPurchase_NewTenantAddress_CitySuburb
  label "City / suburb"
  input text#tdPurchase_NewTenantAddress_StateProvince
  label "State / province"
  input text#tdPurchase_NewTenantAddress_ZipPostCode
  label "ZIP / postcode"
  select#tdPurchase_NewTenantAddress_Country
  label "Country"
  block #SaleCommon_NewAddress_AvalaraTaxExemptionCode (hidden)
    slot #cmbAvalaraTaxExemptionCode_NewAddress
    label "Tax exemption reason"
  select#tdPurchase_NewTenantAddress_Type: Billing | Business | Shipping
  label "Type"
  input checkbox#tdPurchase_NewTenantAddress_DefaultForType
  label "Default for type" for #tdPurchase_NewTenantAddress_DefaultForType
  button "Save" primary
  button "Close"
modal#Purchase_NewLocation_Content small
  heading "Add a location"
  button 
  slot #Product_NewLocation_ValidationContainer
  input text#tdPurchase_NewLocation_Description
  label "Location" for #stocktakeSortingDropdown
  button "Save" primary
  button "Close"
modal#divNewProductDialog medium
  heading "Add a new product"
  button "×"
  input text#tdPurchase_NewProduct_ProductCode placeholder "Enter a product SKU"
  label "SKU"
  input text#tdPurchase_NewProduct_Name placeholder "Enter a product name"
  label "Name"
  select#tdPurchase_NewProduct_Type
  label "Type"
  block #FixedAssetTypeRow
    select#tdPurchase_NewProduct_FixedAssetType
    label "Fixed asset type"
  select#tdPurchase_NewProduct_Category
  label "Category"
  select#tdPurchase_NewProduct_PurchaseTaxRule
  label "Purchase tax rule"
  slot #tdPurchase_NewProduct_SaleTaxRule
  label "Sale tax rule"
  select#tdPurchase_NewProduct_UnitOfMeasure
  label "Unit of measure"
  block #trCostingMethod
    select#tdPurchase_NewProduct_CostingMethod
    label "Costing method"
  block #trExpenseAccount
    select#tdPurchase_NewProduct_ExpenseAccount
    label "Expense account"
  block #trMinimumBeforeReorder
    input text#tdPurchase_NewProduct_MinimumBeforeReorder placeholder "Enter a minimum before reorder."
    label "Minimum before reorder"
  block #trReorderQuantity
    input text#tdPurchase_NewProduct_ReorderQuantity placeholder "Enter reorder quantity"
    label "Reorder quantity"
  input text#tdPurchase_NewProduct_Barcode placeholder "Enter a barcode"
  label "Barcode"
  block #trStockLocator
    input text#tdPurchase_NewProduct_StockLocator placeholder "Enter a stock locator"
    label "Stock locator"
  select#tdPurchase_NewProduct_ProductAttributeSet
  label "Attribute set"
  slot #divAdditionalAttributes_NewProduct
  block #AdditionalAttributes_FieldTemplate (hidden)
    slot #{CustomField}
    label "" for #{CustomField}
  button "Save" primary
  button "Close"
modal#Purchase_NewDeposit_Content small
  heading #Purchase_NewDeposit_Title
  button "×"
  slot #Purchase_NewDeposit_Account
  label "Deposit account"
  block #Purchase_NewDeposit_BankAcocuntBlock
    slot #Purchase_NewDeposit_BankAccount
    label "Account"
  input text#Purchase_NewDeposit_Reference
  label "Reference"
  slot #Purchase_NewDeposit_DatePaid
  label "Date paid"
  input text#Purchase_NewDeposit_Amount
  label "Amount"
  block #liPurchase_NewDeposit_ConversionRate
    input text#Purchase_NewDeposit_ConversionRate
    button #Purchase_NewDeposit_ConversionRate_GetRate
    label "Conversion rate"
  block #Purchase_NewDeposit_BaseAmountBlock (hidden)
    slot #Purchase_NewDeposit_BaseAmountLabel
    slot #Purchase_NewDeposit_BaseAmount
  button "Create" primary
  button "Close"
block #Purchase_NewAllocation (hidden)
  block #Purchase_NewAllocation_Content
    heading "Allocate supplier deposit as payment"
    button "Add and save"#Purchase_NewAllocation_SaveAction primary
    button "Cancel"#Purchase_NewAllocation_CancelAction
    heading "Select existing supplier deposit(s)"
    slot #Purchase_NewAllocation_Deposits
    heading "Allocation(s) that will be created"
    slot #Purchase_NewAllocation_Allocations
    table
    button "Add and save"#Purchase_NewAllocation_SaveAction2 primary
    button "Cancel"#Purchase_NewAllocation_CancelAction2
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
modal#divCOGSAccDims small
  heading "Accounting dimensions"
  button "×"
  button "Save"#btnSaveCOGSAccDims primary
  button "Close"
slot #divExpenseDestributionContainer
slot #CountrySpecificScript
```

### `/Reorder`: Reorder level of stock

Frame: `task-upload-frame`.

```text
link "Home"
link "Purchases"
block #divLocationContent (hidden)
  heading "Select a location to reorder stock for"
  slot #tdLocation
heading "Select a supplier to see the available products OR click "Select all""
button "Select all"#divSelectAll primary
input text#divSearch placeholder "Type text to search"
button "Search" primary
slot #divSuppliersContainer
heading "Choose the products and click 'Reorder'"
text "Supplier not selected"#ReorderSelectedSupplierName
button "Reorder"#btnReorder primary
button "Products"#btnProductsFilter
button "Reset all filters"#btnClearFilters (hidden)
input text#divSearchProducts placeholder "Type text to search"
button "Search" primary
slot #divProductsContainer
modal#dlgProductsFilter medium
  heading "Select products to filter"
  button "×"
  select#cmbFamilies
  slot #divSelectedFamiliesValues (hidden)
  select#cmbTags
  slot #divSelectedTagsValues (hidden)
  select#cmbCategories
  slot #divSelectedCategoriesValues (hidden)
  select#cmbBrands
  slot #divSelectedBrandsValues (hidden)
  heading "OR"
  select#cmbProducts
  slot #divSelectedProductsValues (hidden)
  button "Apply"#btnApplyFilters primary
  button "Close"
```

### `/ReorderBackordered`: Reorder backordered stock

Frame: `task-upload-frame`.

```text
link "Home"
link "Purchases"
slot #tdCustomer
label "Customer" for #cmbCustomer
slot #tdTag
label "Product tag" for #cmbTag
slot #tdLocation
label "Location" for #cmbTag
heading "3. Select a supplier to see available products OR click 'select all'."
button "Select all"#divSelectAll primary
input text#divSearch placeholder "Type text to search"
button "Search" primary
slot #divSuppliersContainer
slot #ReorderProductWarning (hidden)
heading "4. Choose products and click 'Reorder'."
button "Reorder"#btnReorder primary
slot #divProductsContainer
```

### `/SuggestReorder`: Reorder suggestion

Frame: `task-upload-frame`.

```text
link "Home"
block #divLocationContent
  heading "Reorder suggestion"
  slot #cmbLocation
  label "Location"
  slot #cmbReorderFrom
  label "Reorder type"
  block #cmbSupplierBlock
    slot #cmbSupplier
    label "Supplier"
  block #cmbWarehouseBlock
    slot #cmbWarehouse
    label "Warehouse"
block #productsContent
  heading "Choose the products and click 'Reorder'"
  input text#divSearchProducts placeholder "Type text to search"
  button "Search" primary
  slot #cmbReorderAction
  button "Reorder"#btnReorder primary
  slot #divProductsContainer
block #orderedItemsContent
  heading "Reordered products"
  input text#divSearchTaskProducts placeholder "Type text to search"
  button "Search" primary
  slot #divOrderedContainer
block #errorContent (hidden)
  text "The email link expired."
  text "Reorder suggestion email link has expired or you have an invalid link."
```

### `/Supplier`: Supplier

Frame: `iUpload`.

```text
link "Home"
link "Suppliers"
button "Save"#saveAction primary
button "Clone"#cloneAction
button "Back to list"
heading "New supplier"
block #divSupplierTask (hidden)
  button 
  button  primary
  button "Workflow"
  button 
  button "Calendar"
button "Purchase"#purchaseDropdownButton ▾
link "Simple"
link "Advanced"
link "Service"
link "Credit note"
button 
block #divGeneral
  input text#tdSupplier_Index_Name
  label "Name*" for #Supplier_Index_Name
  slot #tdSupplier_Index_Currency
  label "Currency" for #Supplier_Index_Currency
  slot #tdSupplier_Index_PaymentTerm
  label "Payment term" for #Supplier_Index_PaymentTerm
  block #divAccountPayable
    slot #tdSupplier_Index_AccountCode
    label "Account payable" for #Supplier_Index_AccountCode
  slot #tdSupplier_Index_TaxRule
  label "Tax rule" for #Supplier_Index_TaxRule
  slot #tdSupplier_Index_Status
  label "Status" for #Supplier_Index_Status
  slot #tdSupplier_Index_DefaultCarrier
  label "Default carrier" for #Supplier_Index_DefaultCarrier
  block #divTaxNumber
    slot #tdSupplier_Index_TaxNumber
    label "Tax number" for #Supplier_Index_TaxNumber
  slot #tdSupplier_Index_Discount
  label "Discount" for #Supplier_Index_Discount
  slot #tdSupplier_Index_AttributeSet
  label "Attribute set" for #Supplier_Index_AttributeSet
  block #divComments
    textarea#tdSupplier_Index_Comments placeholder "Write your note here..."
    label "Comments" for #Supplier_Index_Comments
button "Addresses"
button "Contacts"
button "Default templates"
button "Additional attributes"
button "Purchases by product"
button "Purchases by document"
button "Attachments"
button "Activity log"
button "Accounting dimensions"
block #divAddresses (hidden)
  block #btnNewAddress (hidden)
    button  primary
  block #btnNewAddress2
    button  primary
  block #btnAddressSearching (hidden)
    button  primary
  slot #divAddressLines
  block #btnNewAddress3
    button "Add a new address" primary
block #divContacts (hidden)
  block #btnNewContact (hidden)
    button  primary
  block #btnNewContact2
    button  primary
  slot #divContactLines
  block #btnNewContact3
    button "Add a new contact" primary
block #divDefaultTemplates
  heading "Purchase document templates"
  slot #tdSupplier_Index_DefaultTemplate_PurchaseOrder
  label "Purchase order" for #tdSupplier_Index_DefaultTemplate_PurchaseOrder
  slot #tdSupplier_Index_DefaultTemplate_PurchaseOrderMatrix
  label "Purchase order matrix" for #tdSupplier_Index_DefaultTemplate_PurchaseOrderMatrix
  slot #tdSupplier_Index_DefaultTemplate_PurchaseInvoice
  label "Purchase invoice" for #tdSupplier_Index_DefaultTemplate_PurchaseInvoice
  slot #tdSupplier_Index_DefaultTemplate_ReceivingNote
  label "Receiving note" for #tdSupplier_Index_DefaultTemplate_ReceivingNote
  slot #tdSupplier_Index_DefaultTemplate_PurchaseReturn
  label "Purchase return" for #tdSupplier_Index_DefaultTemplate_PurchaseReturn
  slot #tdSupplier_Index_DefaultTemplate_ProductLabel
  label "Product label" for #tdSupplier_Index_DefaultTemplate_ProductLabel
block #Supplier_divAttributeSet (hidden)
  heading "Additional attributes"
  block #Supplier_liCustomField1
    slot #Supplier_CustomField1
    label "Attribute 1"
  block #Supplier_liCustomField2
    slot #Supplier_CustomField2
    label "Attribute 2"
  block #Supplier_liCustomField3
    slot #Supplier_CustomField3
    label "Attribute 3"
  block #Supplier_liCustomField4
    slot #Supplier_CustomField4
    label "Attribute 4"
  block #Supplier_liCustomField5
    slot #Supplier_CustomField5
    label "Attribute 5"
  block #Supplier_liCustomField6
    slot #Supplier_CustomField6
    label "Attribute 6"
  block #Supplier_liCustomField7
    slot #Supplier_CustomField7
    label "Attribute 7"
  block #Supplier_liCustomField8
    slot #Supplier_CustomField8
    label "Attribute 8"
  block #Supplier_liCustomField9
    slot #Supplier_CustomField9
    label "Attribute 9"
  block #Supplier_liCustomField10
    slot #Supplier_CustomField10
    label "Attribute 10"
block #divPurchasesByProduct (hidden)
  input text#divSearchPurchasesByProduct name=searchFieldPurchaseByProductValue placeholder "Type text to search"
  button "Search" primary
  slot #divPurchasesByProductLines
block #divPurchasesByDocument (hidden)
  input text#divSearchPurchasesByDocument name=searchFieldPurchaseByDocumentValue placeholder "Type text to search"
  button "Search" primary
  slot #divPurchasesByDocumentLines
block #divAccountingDimensions (hidden)
  heading "Accounting dimensions"
  slot #divAccountingDimensionsList
block #divAttachments (hidden)
  heading "Attachments"
  block #preview-template (hidden)
  slot #iUpload (hidden)
  form#frmUpload
    heading "Drop files here or click to upload."
  block #divUploadImpossible
  button "Attach from Google Drive" primary
  slot #divAttachmentList
block #divActivityLogs (hidden)
  slot #ActivityLogs_Container
modal#Supplier_NewContact_Content medium
  heading #Supplier_NewContact_dialogTitle
  button "×"
  input text#tdSupplier_NewContact_Name
  label "Name" for #tdSupplier_NewContact_Name
  input text#tdSupplier_NewContact_JobTitle
  label "Job title" for #tdSupplier_NewContact_JobTitle
  input text#tdSupplier_NewContact_Phone
  label "Phone" for #tdSupplier_NewContact_Phone
  input text#tdSupplier_NewContact_MobilePhone
  label "Mobile phone" for #tdSupplier_NewContact_MobilePhone
  input text#tdSupplier_NewContact_Fax
  label "Fax" for #tdSupplier_NewContact_Fax
  input text#tdSupplier_NewContact_Email
  label "Email" for #tdSupplier_NewContact_Email
  input text#tdSupplier_NewContact_Website
  label "Website" for #tdSupplier_NewContact_Website
  input checkbox#tdSupplier_NewContact_IsDefault
  label "Default" for #tdSupplier_NewContact_IsDefault
  textarea#tdSupplier_NewContact_Comment
  label "Comments" for #tdSupplier_NewContact_Comment
  button "Add" primary
  button "Close"
modal#Supplier_NewAddress_Content medium
  heading #Supplier_NewAddress_dialogTitle
  button "×"
  slot #cmbAddress
  label "Line 1" for #tdSupplier_NewAddress_Line1
  input text#tdSupplier_NewAddress_Line1
  label "Line 2" for #tdSupplier_NewAddress_Line2
  input text#tdSupplier_NewAddress_Line2
  label "City / suburb" for #tdSupplier_NewAddress_CitySuburb
  input text#tdSupplier_NewAddress_CitySuburb
  label "State / province" for #tdSupplier_NewAddress_StateProvince
  input text#tdSupplier_NewAddress_StateProvince
  label "ZIP / postcode" for #tdSupplier_NewAddress_ZipPostCode
  input text#tdSupplier_NewAddress_ZipPostCode
  label "Country" for #tdSupplier_NewAddress_Country
  select#tdSupplier_NewAddress_Country
  select#tdSupplier_NewAddress_Type: Billing | Business | Shipping
  label "Type" for #tdSupplier_NewAddress_Type
  input checkbox#tdSupplier_NewAddress_DefaultForType
  label "Default for type" for #tdSupplier_NewAddress_DefaultForType
  button "Add" primary
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

### `/SupplierDeposits`: Supplier deposits

Frame: `task-upload-frame`.

```text
link "Home"
input text#divSearch placeholder "Type text to search"
button "Search" primary
input checkbox#divUsedDeposits
label "Show used deposits" for #divUsedDeposits
button "Refresh"#divRefresh
slot #SupplierDeposits_Index_Container
modal#SupplierDeposits_Allocated_Details medium
  heading "Allocated details"
  button "×"
  slot #divAllocatedDetailsGridContainer
  button "Close"
```

### `/SupplierList`: Suppliers

Frame: `task-upload-frame`.

```text
link "Home"
heading "Suppliers"
button "More actions"#divMoreActions ▾
link "Delete deprecated suppliers"#itemDeleteDeprecatedCustomers
link "Merge selected suppliers"#itemMergeSelectedCustomers
button "Import"#divImport ▾
link "Suppliers"
link "Supplier addresses"
link "Supplier contacts"
link "Product prices by supplier"
button "Export"#divExport ▾
link "Suppliers"
link "Supplier addresses"
link "Supplier contacts"
button #divNew primary
input text#divSearch placeholder "Type text to search"
button "Search" primary
input checkbox#IsActiveContainer
label "Only active suppliers" for #IsActiveContainer
button #divRefresh
button #Grid_gridName_Options
slot #SupplierList_Index_Container
form#frmExport
form#frmExportAddresses
form#frmExportContacts
modal#divSupplierList_Delete_ContentDialog small
  heading "Delete deprecated suppliers"
  button "×"
  block #SupplierList_Delete_ValidationContainerSuccess
  slot #Delete_ResultContainer (hidden)
  block #SupplierList_Delete_ValidationContainerWarning
  block #SupplierList_Delete_ValidationContainerError
  button "Delete"#SupplierList_Delete_Actions
  button "Close"
modal#divSupplierList_Merge_ContentDialog small
  heading "Merge suppliers"
  button "×"
  slot #SupplierList_Merge_ValidationContainerSuccess (hidden)
  slot #SupplierList_Merge_ValidationContainerWarning (hidden)
  slot #SupplierList_Merge_ValidationContainerError (hidden)
  select#cmbPrimaryMergeSupplier
  label "Primary supplier" for #cmbPrimaryMergeSupplier
  label "Merge suppliers"
  slot #MergeSupplierGridContainer
  block #SupplierList_Merge_Actions
    button "Merge"#SupplierList_Merge_Execute
    button "Close"
```

## Components by bundle

What the page code builds and mounts into the layout's slots.

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


