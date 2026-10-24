# CRM: UI

Every component the page code builds, read from the shipped ExtJS bundles: grids with their columns, fields, buttons, menus, windows and custom components. Labels are the English UI text. `renders into` is the id of the `<div>` in the page's server-rendered HTML that the component mounts in; `store` names the data store (see the endpoints in [README.md](README.md)); `on click` is the handler. Visual system and shell layout: [docs/UI.md](../../docs/UI.md).

## Screens

| Route | Title | Bundles |
|---|---|---|
| `/Deal` | Deal | [`Deal2019`](#deal2019) |
| `/Lead` | Lead | [`MultilingualSupport2019`](#multilingualsupport2019), [`LeadEdit2019`](#leadedit2019) |
| `/LeadList` | Leads | [`LeadList2019`](#leadlist2019) |
| `/Opportunity` | Opportunity | [`Opportunity2019`](#opportunity2019) |
| `/OpportunityList` | Opportunities | [`OpportunityList2019`](#opportunitylist2019) |
| `/TaskList` | Tasks | [`TaskList2019`](#tasklist2019) |

## Layout

Each screen's server-rendered HTML inside the shell, as an outline: headings, tabs, sections, labels, inputs (`#id`), buttons (`▾` = dropdown), menus, tables and `slot`s (empty `<div>`s the components below mount into). `(hidden)` parts are shown by the page code when needed. Read with GET from a signed-in session; no values are kept.

### `/Deal`: Deal

Frame: `task-upload-frame`.

```text
link "Home"
link "Reference Books"
link "Deals"
block #ActivityLogsLink
  button "Activity log" primary
slot #formCaption
button "Save"#saveAction primary
button "Back to list"#backAction
label "Name"
input text#tdDeal_Index_Name placeholder "Enter a deal name"
label "Status"
input checkbox#tdDeal_Index_IsActive (hidden)
input radio#tdDeal_Index_IsActive_Active name=Deal_Index_IsActive_Status
label "Active" for #tdDeal_Index_IsActive_Active
input radio#tdDeal_Index_IsActive_Inactive name=Deal_Index_IsActive_Status
label "Inactive" for #tdDeal_Index_IsActive_Inactive
label "Effective from (optional)"
slot #tdDeal_Index_DateFrom
label "Effective to (optional)"
slot #tdDeal_Index_DateTo
label "Customer type"
select#tdDeal_Index_CustomersGroup
block #couponsSetting
  label "Allow coupons"
  input checkbox#tdDeal_Index_AllowCoupons
block #customersComboboxCell
  slot #tdDeal_Index_Customers
  button #addCustomer primary
  block #specifiedCustomers (hidden)
    block #customersActionsTop (hidden)
      slot #customersPlaceholder
block #customerTagsComboboxCell
  slot #tdDeal_Index_CustomerTags
  button #addCustomerTag primary
  block #specifiedCustomerTags (hidden)
    block #customerTagsActionsTop (hidden)
      slot #customerTagsPlaceholder
block #couponsBlock
  label "Single use"
  input checkbox#tdDeal_Index_SingleCouponCodeUsage
  tabs: Coupon codes #CouponsCodes_tab | Report #CouponsReport_tab
  tab pane#CouponsCodes_tab
    text "Please enter each coupon code on a separate line. Coupon codes are not case sensitive."
    textarea#CouponCodes
  tab pane#CouponsReport_tab
    button #divRefresh primary
    input text#divSearch placeholder "Type text to search"
    button "Search" primary
    slot #CouponReportContainer
button  primary
slot #discountChildsPlaceholder
button  primary
block #ActivityLogDiv (hidden)
  button "Close"
  slot #ActivityLogs_Container
block #discountTemplate (hidden)
  slot #tdDeal_Index_Discounts{0}
  slot #cbDealDiscountLevel{0}
  block #divDiscountOrderLevel{0} (hidden)
    label "Buy"
    slot #tbDeal_Index_ValueBuy{0}
    text "Or more"
    slot #tbDeal_Index_ValueBuyDesciption{0} (hidden)
    slot #ulDeal_Index_TypeBuy{0}
    slot #cbDeal_Index_BrandListBuy{0}
    slot #cbDeal_Index_CategoryListBuy{0} (hidden)
    slot #cbDeal_Index_TagListBuy{0} (hidden)
    slot #cbDeal_Index_ProductListBuy{0} (hidden)
    button #Deal_Index_AddItemBuy{0} primary
    block #itemsPlaceholderBuyActionsTop{0} (hidden)
      slot #Deal_Index_ItemsPlaceholderBuy{0}
    label "Get"
    slot #tbDeal_Index_ValueGet{0}
    slot #ulDeal_Index_TypeGet{0}
    slot #cbDeal_Index_BrandListGet{0}
    slot #cbDeal_Index_CategoryListGet{0} (hidden)
    slot #cbDeal_Index_TagListGet{0} (hidden)
    slot #cbDeal_Index_ProductListGet{0} (hidden)
    button #Deal_Index_AddItemGet{0} primary
    block #itemsPlaceholderGetActionsTop{0} (hidden)
      slot #Deal_Index_ItemsPlaceholderGet{0}
  block #divDiscountLineLevel{0}
    slot #Deal_Index_Brands{0}
    button #addBrand{0} primary
    block #brandsActionsTop{0} (hidden)
      slot #brandsPlaceholder{0}
    slot #Deal_Index_Categories{0}
    button #addCategory{0} primary
    block #categoriesActionsTop{0} (hidden)
      slot #categoriesPlaceholder{0}
    slot #Deal_Index_Tags{0}
    button #addTag{0} primary
    block #tagsActionsTop{0} (hidden)
      slot #tagsPlaceholder{0}
    slot #Deal_Index_Products{0}
    button #addProduct{0} primary
    block #productsActionsTop{0} (hidden)
      slot #productsPlaceholder{0}
```

### `/Lead`: Lead

Frame: `iUpload`.

```text
link "Home"
link "Leads"
button "Save"#saveAction primary
button "Convert"#convertAction
button "Back to list"
button "General"
button "Addresses"
button "Contacts"
button "Attachments"
button "Activity log"
heading "New lead"#formCaption
block #divLeadTask (hidden)
  button 
  button  primary
  button "Workflow"
  button 
  button "Calendar"
button "Opportunity"#addOpportunity
button 
block #divGeneral
  input text#tdLead_Index_Name
  label "Name"
  slot #tdLead_Index_Status
  label "Status"
  slot #tdLead_Index_Currency
  label "Currency"
  block #divLead_Index_Amount
    slot #tdLead_Index_Amount
    label "Amount"
  slot #tdLead_Index_CloseChance
  label "Chance of close"
  slot #tdLead_Index_CloseDate
  label "Close by*"
  slot #tdLead_Index_SalesRepresentative
  label "Sales representative"
  slot #Lead_Index_Tax
  label "Tax rule*"
  slot #Lead_Index_PriceTier
  label "Price tier*"
  slot #Lead_Index_Terms
  label "Terms*"
  block #divComments
    textarea#tdLead_Index_Comments placeholder "Write your note here..."
    label "Comments"
block #divAddresses (hidden)
  button #btnNewAddress primary
  button #btnAddressSearching primary
  slot #divAddressLines
  button "Add a new address"#btnNewAddress1 primary
block #divContacts (hidden)
  button #btnNewContact primary
  slot #divContactLines
  button "Add a new contact"#btnNewContact2 primary
block #divAttachments (hidden)
  block #divUploadContainer
    block #preview-template (hidden)
    slot #iUpload (hidden)
    form#frmUpload
      heading "Drop files here or click to upload."
  button "Attach from Google Drive" primary
  slot #divAttachmentList
block #divActivityLogs (hidden)
  slot #ActivityLogs_Container
modal#Lead_NewContact_Content medium
  heading #Lead_NewContact_dialogTitle
  button "×"
  input text#tdLead_NewContact_Name
  label "Name" for #tdLead_NewContact_Name
  label "Job title" for #tdLead_NewContact_JobTitle
  input text#tdLead_NewContact_JobTitle
  label "Phone" for #tdLead_NewContact_Phone
  input text#tdLead_NewContact_Phone
  label "Mobile phone" for #tdLead_NewContact_MobilePhone
  input text#tdLead_NewContact_MobilePhone
  label "Fax" for #tdLead_NewContact_Fax
  input text#tdLead_NewContact_Fax
  label "Email" for #tdLead_NewContact_Email
  input text#tdLead_NewContact_Email
  label "Website" for #tdLead_NewContact_Website
  input text#tdLead_NewContact_Website
  input checkbox#tdLead_NewContact_IsDefault
  label "Default" for #tdLead_NewContact_IsDefault
  label "Comments" for #tdLead_NewContact_Comment
  textarea#tdLead_NewContact_Comment
  button "Save" primary
  button "Close"
modal#Lead_NewAddress_Content medium
  heading #Lead_NewAddress_dialogTitle
  button "×"
  slot #cmbAddress
  input text#tdLead_NewAddress_Line1
  label "Line 1" for #tdLead_NewAddress_Line1
  label "Line 2" for #tdLead_NewAddress_Line2
  input text#tdLead_NewAddress_Line2
  label "City / suburb" for #tdLead_NewAddress_CitySuburb
  input text#tdLead_NewAddress_CitySuburb
  label "State / province" for #tdLead_NewAddress_StateProvince
  input text#tdLead_NewAddress_StateProvince
  label "ZIP / postcode" for #tdLead_NewAddress_ZipPostCode
  input text#tdLead_NewAddress_ZipPostCode
  select#tdLead_NewAddress_Country
  label "Country" for #tdLead_NewAddress_Country
  block #SaleCommon_NewAddress_AvalaraTaxExemptionCode (hidden)
    label "Tax exemption reason" for #cmbAvalaraTaxExemptionCode_NewAddress
    slot #cmbAvalaraTaxExemptionCode_NewAddress
  select#tdLead_NewAddress_Type: Billing | Business | Shipping
  label "Type" for #tdLead_NewAddress_Type
  input checkbox#tdLead_NewAddress_DefaultForType
  label "Default for type" for #tdLead_NewAddress_DefaultForType
  button "Save" primary
  button "Close"
slot #CountrySpecificScript
```

### `/LeadList`: Leads

Frame: `task-upload-frame`.

```text
link "Home"
block #viewContainer
  link "Listing"#tabGeneral
  link "Kanban"#tabKanbanBoard
block #divListTypeSelector
  select#cmbListTypeSelector: Leads and customers | Only leads | Only customers
block #divGeneralToolbox (hidden)
  heading "Leads"
  label "Period" for #cmbPeriodList
  slot #divPeriodList
  label "From" for #dtFromList
  slot #divFromList
  label "To" for #dtToList
  slot #divToList
  block #import-form-control
    button "Import"#divImport ▾
    link "Leads"
    link "Lead addresses"
    link "Lead contacts"
  label "Status" for #cmbStatus
  select#cmbStatus
  label "Sales rep" for #cmb_Index_SalesRep
  slot #div_Index_SalesRep
  button #btnNew primary
  input text#divSearch placeholder "Type text to search"
  button "Search" primary
  button "Convert"
  block #export-form-control (hidden)
    button "Export"#divExport ▾
    link "Leads"
    link "Lead addresses"
    link "Lead contacts"
  button "Delete"
  button #btnRefresh
  button #Grid_gridName_Options
  slot #LeadList_Index_Container
block #divKanbanBoardToolbox (hidden)
  button #btnAddNew primary
  input text#boardSearch placeholder "Type to search"
  button "Search" primary
  button "Manage statuses"#btnManageStatuses
  label "Period" for #cmbPeriodBoard
  slot #divPeriodBoard
  label "From" for #dtFromBoard
  slot #divFromBoard
  label "To" for #dtToBoard
  slot #divToBoard
  label "Sales rep" for #cmb_Board_SalesRep
  slot #div_Board_SalesRep
  button #btnRefreshBoard
  button #kanban-settings
  slot #divKanbanBoard
modal#Kanban_Settings_Dialog small
  heading "Kanban settings"
  button "×"
  label "Summarize by" for #cmbSummarize
  slot #divSummarize
  label "Group by" for #cmbGroup
  select#cmbGroup
  button "Apply"#btnApplyKanbanSettings primary
  button "Close" primary
modal#Kanban_Statuses_Dialog medium
  heading "Configure lead statuses"
  button "×"
  text "Mark "Show in Kanban" checkbox to add lead status to Kanban view lead list in CRM. Each lead status will represent a Kan"
  button  primary
  button 
  slot #divStatusesKanbanGrid
  button "Update"#btnUpdateyKanbanStatuses primary
  button "Cancel" primary
form#frmExport
form#frmExportAddresses
form#frmExportContacts
form#frmPrintList
```

### `/Opportunity`: Opportunity

Frame: `iUpload`.

```text
link "Home"
link "Opportunities"
button "Save"#saveAction primary
button "Back to list"
block #taskActions
  button "Clone"#cloneAction
  button "Convert to sale"#convert2SaleAction
button "Undo"#undoAction
button "Void"#voidAction
block #divMainContent
  slot #Sale_Index_Status
  heading 
  block #divCustomerTask (hidden)
    button 
    button  primary
    button "Workflow"
    button 
    button "Calendar"
  button #taskHeaderCollapse
  block #divTaskHeader
    heading "Contact details"
    slot #Sale_Index_Customer
    label "Name"
    slot #Sale_Index_Contact
    label "Contact"
    slot #Sale_Index_Phone
    label "Phone"
    slot #Sale_Index_Email
    label "Email"
    slot #Sale_Index_CustomerReference
    label "Reference"
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
    slot #Sale_Index_Tax_Inclusive
    label "Tax inclusive" for #chkSale_Index_Tax_Inclusive
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
    block #Sale_Index_ShipServiceGroup
      input text#Sale_Index_ShippingCarrierService
      label "Carrier / service"
      button #Sale_Index_ShippingCarrierServiceLookup
    heading "Comments"
    block #divNote
      textarea#divStickyNote placeholder "Write your note here..."
  button "Opportunity"
  button "Attachments"
  button "Logs and attributes"
  block #divQuote (hidden)
    heading "Products"
    button "Email"#tabQuoteEmailAction ▾
    button "Print"#tabQuotePrintAction ▾
    form#frmPrintList
    button "Apply discounts"#divDiscounts_Quote
    button "Authorize"#divAuthorise_Quote primary
    button "In progress"#divSetInProgress primary
    button "Approve"#btApprove primary
    button "Reject"#btReject
    button "Mark as lost"#btMarkAsLost
    button "Review"#btReview
    slot #vSaleQuoteLinesDiscountDescription (hidden)
    button #divNewLines_Quote primary
    button "Family"#divAddBulk_Quote
    slot #divQuoteLines
    button "Add more items"#Sale_Quote_AddQuoteLinesRecordLink primary (hidden)
    button "Export"#divExport_Quote primary
    button "Import"#divImport_Quote primary
    heading "Additional charges and services"
    button #divNewAdditionalCostLine_Quote primary
    slot #divQuoteAdditionalChargesLines
    button "Add more items"#Sale_Quote_AddAdditionalChargesLinesRecordLink primary (hidden)
    textarea#tdOpportunity_Memo placeholder "Write your note here..."
    label "Opportunity memo"
    table: Opportunity lines | Additional charges | Total
  block #divHistory (hidden)
    heading "Logs and attributes"
    block #Opportunity_divAttributeSet (hidden)
      heading "Additional attributes"
      block #Opportunity_liCustomField1
        slot #Opportunity_CustomField1
        label "Attribute 1"
      block #Opportunity_liCustomField2
        slot #Opportunity_CustomField2
        label "Attribute 2"
      block #Opportunity_liCustomField3
        slot #Opportunity_CustomField3
        label "Attribute 3"
      block #Opportunity_liCustomField4
        slot #Opportunity_CustomField4
        label "Attribute 4"
      block #Opportunity_liCustomField5
        slot #Opportunity_CustomField5
        label "Attribute 5"
      block #Opportunity_liCustomField6
        slot #Opportunity_CustomField6
        label "Attribute 6"
      block #Opportunity_liCustomField7
        slot #Opportunity_CustomField7
        label "Attribute 7"
      block #Opportunity_liCustomField8
        slot #Opportunity_CustomField8
        label "Attribute 8"
      block #Opportunity_liCustomField9
        slot #Opportunity_CustomField9
        label "Attribute 9"
      block #Opportunity_liCustomField10
        slot #Opportunity_CustomField10
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
    slot #divAttachmentList
  slot #divPrint
  form#frmClone
  slot #ifrmDownloadFile (hidden)
  form#[object HTMLInputElement]
  modal#Sale_NewCustomer_Content medium
    heading "New lead"
    button "×"
    input text#tdOpportunity_NewCustomer_Name placeholder "Enter a lead name"
    label "Name"
    slot #tdLead_Index_Status
    label "Status"
    slot #tdLead_Index_CloseChance
    label "Chance of close"
    block #divLead_Index_Amount
      slot #tdLead_Index_Amount
      label "Amount"
    slot #tdLead_Index_CloseDate
    label "Close by"
    slot #tdOpportunity_NewCustomer_Currency
    label "Currency"
    select#tdOpportunity_NewCustomer_DefaultSalesRepresentative
    label "Sales representative"
    block #divCustomerTaxRule
      select#tdOpportunity_NewCustomer_TaxRule
      label "Tax rule"
    select#tdOpportunity_NewCustomer_PaymentTerm
    label "Payment term"
    select#tdOpportunity_NewCustomer_SalePriceTier
    label "Sale price tier"
    textarea#tdOpportunity_NewCustomer_Comments placeholder "Enter comments"
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
  modal#Sale_LookupCourierDialog_Content small
    heading "Carrier / service lookup"
    button "×"
    slot #divLookupCourierDialogGrid
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
    select#Sale_NewProduct_SaleTaxRule
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
  modal#divUploadQuoteDialog medium
    heading "Upload an opportunity"
    button "×"
    heading "1. Download this opportunity"
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
  modal#divProductFamily small
    heading "Add a product family to your sale task"
    button "×"
    slot #tdProductFamily
    label "Product family"
    block #divFamilyOptions
      slot #tdFamilyOption1
      label "Options 1*"
      block #divFamilyOption2
        slot #tdFamilyOption2
        label "Options 2*"
      block #divFamilyOption3
        slot #tdFamilyOption3
        label "Options 3*"
    input text#tdProductFamilyQuantity
    label "Quantity to sell"
    input checkbox#tdOnlyAvailable name=chkOnlyAvailable
    label "Sell only available variations" for #tdOnlyAvailable
    button "Add products" primary
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

### `/OpportunityList`: Opportunities

Frame: `task-upload-frame`.

```text
link "Home"
block #viewContainer
  link "List"#vListView
  link "Kanban"#vKanbanView
block #divSalesOrOpportunities
  select#cmbSalesOrOpportunities: Sales and opportunities | Only opportunities | Only sales
block #divList
  block #bulkActionsNoteSuccess (hidden)
  block #bulkActionsNoteWarning (hidden)
  block #bulkActionsNoteError (hidden)
  block #recordLimitMessage (hidden)
    slot #recordLimitMessageText
  button #divNew primary
  input text#divSearch placeholder "Type text to search"
  button "Search"#btnSearchOpportunity primary
  block #divDateRangeContainer
    slot #DDateRange_PageOverlay
    button #btnOpenRangeDropDown ▾
    button  ▾
    label "Date range"
    label "Starting" for #startreportrangemanual
    slot #startreportrangemanual
    label "Ending" for #endreportrangemanual
    slot #endreportrangemanual
    slot #startreportrange
    slot #endreportrange
    button "Apply"#btnApplyDateRange primary
    button "Cancel"#btnCloseDateRange primary
  block #divSaleStatusFilter (hidden)
    select#cmbSaleStatusFilter
  block #divOpportunityStatusFilter (hidden)
    select#cmbOpportunityStatusFilter
  slot #OpportunityList_Index_SalesRepresentative
  button #divRefresh
  button "Import"#tImport
  button #btnCustomisation
  block #GridOptions_OpportunityListContainer
    button #OpportunityGrid_gridName_Options1
  block #bulkActionsGroup
    button "Undo"#btnUndo
    button "Void"#btnVoid
    button "Export"#btnExport
    button "Print"#printAction ▾
    slot #printDropdownList
    button "Email"#emailAction ▾
    slot #emailDropdownList
  slot #vListViewContainer (hidden)
  slot #vKanbanViewContainer (hidden)
button 
form#frmExport
form#frmPrintList
modal#dlgOpportunityList_KanbanCustomisation small
  heading "Kanban settings"
  button "×"
  select#dlgOpportunityList_KanbanCustomisation_SummariseBy: Amount | Quantity
  label "Summarize by" for #dlgOpportunityList_KanbanCustomisation_SummariseBy
  button "Save"#dlgOpportunityList_KanbanCustomisation_btnSave primary
  button "Close"
modal#dlgReCaptchaModal small
  heading "CAPTCHA verification"#dlgReCaptchaModalCaption
  button "×"
  block #emailReCaptcha
  button "Continue"#dlgReCaptchaModal_continue primary
  button "Close"
```

### `/TaskList`: Tasks

Frame: `task-upload-frame`.

```text
link "Home"
slot #FeatureModuleDetailsBlock (hidden)
block #taskListContent
  block #viewContainer
    link "List"#tabList
    link "Calendar"#tabCalendar
  block #divList (hidden)
    block #bulkActionsNoteSuccess (hidden)
    block #bulkActionsNoteWarning (hidden)
    block #bulkActionsNoteError (hidden)
    heading "Tasks"
    label "Period" for #cmbPeriodList
    slot #divPeriodList
    slot #divFromList
    label "From" for #dtFromList
    slot #divToList
    label "To" for #dtToList
    label "Status" for #cmbListStatus
    select#cmbListStatus
    block #divListUsers (hidden)
      label "Assigned to" for #cmbListUsers
      select#cmbListUsers
    button  primary
    button 
    input text#listSearch placeholder "Type text to search"
    button "Search" primary
    block #divBulkActions4List
      button "Undo"#btnUndo
      button "More actions"#btnMoreActions ▾
      slot #moreActionsList
      button "Print"#btnPrint ▾
      slot #printDropdownList
      button "Email"#btnEmail ▾
      slot #printDropdownList
      block #export-form-control
        button "Export"#btnExport ▾
        link "CSV"
      button "Void"#btnVoid
    slot #TaskList_OnlyImportantTasks
    label "Only important tasks" for #chkTaskList_OnlyImportantTasks
    button #btnRefreshList
    button #Grid_gridName_Options
    slot #TaskList_Container
    form#frmExport
    form#frmPrintList
    modal#Task_AssignedTo small
      heading 
      button "×"
      label "Assign to" for #cmbAssignUsers
      select#cmbAssignUsers
      button "Apply"#btnSetAssigned primary
      text "Select assignee, press "Apply" to save, otherwise close the form."
      button "Close"
    modal#Task_Deadline medium
      heading "Change deadline for selected tasks"
      button "×"
      text "Move deadline forward"#deadline-curr-val
      input text#txbPartValue placeholder "Enter value"
      label "Value"
      select#cmbDateParts
      label "Date part"
      button "Apply"#btnSetDeadline primary
      text "Set deadline"
      block #divSetDeadlineDate
        label "New deadline"
      button "Apply"#btnSetDeadlineDate primary
      button "Close"
    modal#Task_Observers medium
      heading "Observers"
      button "×"
      label "Observer" for #cmbTenantUsers
      slot #divTenantUsers
      button "Add"#btnAddObserver primary
      slot #divObserversGrid
      button "Close"
  block #divTaskCalendar (hidden)
    input text#txbCalendarSearch placeholder "Type to search"
    button "Search"#btnCalendarSearch primary
    label "Show completed" for #cbxCalendarShowCompleted
    input checkbox#cbxCalendarShowCompleted
    label "Category" for #cmbCategoryList
    select#cmbCategoryList
    block #divCalendarUsers (hidden)
      label "Assigned to" for #cmbCalendarUsers
      select#cmbCalendarUsers
    slot #taskTabCalendar
  block #divKanban (hidden)
    button  primary
    input text#boardSearch placeholder "Type to search"
    button "Search" primary
    label "Show completed" for #cbxKanbanShowCompleted
    input checkbox#cbxKanbanShowCompleted
    label "Status" for #cmbBoardStatus
    select#cmbBoardStatus
    block #divBoardUsers (hidden)
      label "Assigned to" for #cmbBoardUsers
      select#cmbBoardUsers
    button #btnRefreshBoard
    button #kanban-settings
    slot #divKanbanBoard
  block #divGantt (hidden)
    button  primary
    input text#ganttSearch placeholder "Type to search"
    button "Search" primary
    label "Period" for #cmbPeriodGantt
    slot #divPeriodGantt
    label "From" for #dtFromGantt
    slot #divFromGantt
    label "To" for #dtToGantt
    slot #divToGantt
    label "Status" for #cmbGanttStatus
    select#cmbGanttStatus
    block #divGanttUsers (hidden)
      label "Assigned to" for #cmbGanttUsers
      select#cmbGanttUsers
    button #btnRefreshGantt
    slot #ganttContainer
  modal#dlgReCaptchaModal small
    heading "CAPTCHA verification"#dlgReCaptchaModalCaption
    button "×"
    block #emailReCaptcha
    button "Continue"#dlgReCaptchaModal_continue primary
    button "Close"
block #divModuleMessage (hidden)
  link "settings"
```

## Components by bundle

What the page code builds and mounts into the layout's slots.

### `Deal2019`

1 grids · 4 standalone fields · 0 windows · 22 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `CouponReportContainer` · store `couponReportStore` · placeholder `You do not have any used coupons at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Coupon code | `CouponCode` |  | flex 1 | renderer() |  |
    | Sale task | `OrderNumber` |  | flex 1 | renderer() |  |
    | Date | `SaleOrderDate` |  | flex 1 | renderer() |  |
    | Customer | `CustomerName` |  | flex 2 |  |  |
    | Total amount | `TotalAmount` |  | flex 1 |  |  |


#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| date field |  | `Sale_Index_ShipmentRequiredByDate` | `` | placeholder `Choose date` · format `UserDateFormat` |
| date field |  | `tdDeal_Index_DateFrom` | `` | placeholder `Choose...` · format `UserDateFormat` |
| date field |  | `tdDeal_Index_DateTo` | `` | placeholder `Choose...` · format `UserDateFormat` |
| text field |  | `renderTo` | `` | placeholder `placeHolder` |

#### Menus, buttons and other parts

- **component** · renders into `renderTo` · store `store` · shows `Value \| Name` · value `Value \| ID` · placeholder `placeHolder \| type to search...`
- **component** “{boxLabel}” · renders into `renderTo`
- **component** · name `controlName` · renders into `renderTo`
  - *(component built elsewhere: `items`)*
- **component** · renders into `tdDeal_Index_Discounts`
- **component** “Entire order” · renders into `cbDealDiscountLevel`
- **component** · renders into `Deal_Index_Brands`
- **component** · renders into `Deal_Index_Categories`
- **component** · renders into `Deal_Index_Tags`
- **component** · renders into `Deal_Index_Products`
- **component** · renders into `tbDeal_Index_ValueBuy`
- **component** · renders into `cbDeal_Index_IsMoreBuy`
- **component** · renders into `ulDeal_Index_TypeBuy`
  - **component** “Brand” · name `value_type_buy` · id `BrandTypeBuy`
  - **component** “Category” · name `value_type_buy` · id `CategoryTypeBuy`
  - **component** “Tag” · name `value_type_buy` · id `TagTypeBuy`
  - **component** “Product” · name `value_type_buy` · id `ProductTypeBuy`
  - **component** “Order total” · name `value_type_buy` · id `TotalOrderTypeBuy`
- **component** · renders into `cbDeal_Index_BrandListBuy`
- **component** · renders into `cbDeal_Index_CategoryListBuy`
- **component** · renders into `cbDeal_Index_TagListBuy`
- **component** · renders into `cbDeal_Index_ProductListBuy`
- **component** · renders into `tbDeal_Index_ValueGet`
- **component** · renders into `ulDeal_Index_TypeGet`
  - **component** “Brand” · name `value_type_get` · id `BrandTypeGet`
  - **component** “Category” · name `value_type_get` · id `CategoryTypeGet`
  - **component** “Tag” · name `value_type_get` · id `TagTypeGet`
  - **component** “Product” · name `value_type_get` · id `ProductTypeGet`
  - **component** “Buy collection total” · name `value_type_get` · id `DiscountBuyCollectionTypeGet`
  - **component** “Order total” · name `value_type_get` · id `TotalOrderTypeGet`
- **component** · renders into `cbDeal_Index_BrandListGet`
- **component** · renders into `cbDeal_Index_CategoryListGet`
- **component** · renders into `cbDeal_Index_TagListGet`
- **component** · renders into `cbDeal_Index_ProductListGet`

### `LeadEdit2019`

3 grids · 11 standalone fields · 0 windows · 0 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `divAddressLines` · placeholder `No addresses found.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Line 1 | `Line1` |  | flex 2 | RenderHTMLText | total count |
    | Line 2 | `Line2` |  | flex 2 | RenderHTMLText |  |
    | City / Suburb | `CitySuburb` |  | flex 1 | RenderHTMLText |  |
    | State / Province | `StateProvince` |  | flex 1 | RenderHTMLText |  |
    | ZIP / postcode | `ZipPostCode` |  | flex 1 | RenderHTMLText |  |
    | Country | `Country` |  | flex 2 | RenderHTMLText |  |
    | Type | `Type` |  | flex 1 | RenderHTMLText |  |
    | Default for type | `DefaultForType` | check column | 80 | renderer() |  |

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
| combo |  | `tdLead_Index_Currency` | `currencyStore` | shows `Code` · value `Code` · pick-only |
| combo |  | `tdLead_Index_Status` | `LeadStatusStore` | shows `Name` · value `Name` · placeholder `Choose...` · pick-only |
| combo |  | `tdLead_Index_CloseChance` | `CloseChanceStore` | shows `Name` · value `Value` · placeholder `Choose...` · pick-only |
| date field |  | `tdLead_Index_CloseDate` | `` | placeholder `Choose...` · format `UserDateFormat` |
| combo |  | `tdLead_Index_SalesRepresentative` | `vTenantContactStore` | shows `Name` · value `ContactID` · placeholder `Choose...` · pick-only |
| number field |  | `tdLead_Index_Amount` | `` |  |
| combo |  | `Lead_Index_Tax` | `vTenantTaxationRuleStore` | shows `Description` · value `RuleID` · placeholder `Choose...` · pick-only |
| combo |  | `Lead_Index_PriceTier` | `vSalesPriceTiersStore` | shows `Name` · value `Code` · placeholder `Choose...` · pick-only |
| combo |  | `Lead_Index_Terms` | `vTenantPaymentTermStore` | shows `Name` · value `TermID` · placeholder `Choose...` · pick-only |
| date field |  | `WorkflowModal_dtWorkflowDate` | `` | format `UserDateFormat` |

### `LeadList2019`

2 grids · 9 standalone fields · 0 windows · 0 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · id `GridGeneral` · renders into `LeadList_Index_Container` · store `leadStore`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    |  | `` |  | flex 1 | renderer() | hidden |
    | Name | `Name` |  | flex 1 | renderer() |  |
    | Amount | `Amount` |  | flex 1 | renderer() |  |
    | Currency | `Currency` |  | flex 1 | renderer() |  |
    | Sales representative | `SalesRepName` |  | flex 1 | renderer() |  |
    | Status | `LeadStatus` |  | flex 1 | renderer() |  |
    | Close date | `CloseDate` |  | flex 1 | renderer() |  |
    | Close chance | `CloseChance` |  | flex 1 | renderer() |  |
    | Comments | `Comments` |  | flex 2 | renderer() |  |
    | Contact | `Contact` |  | flex 1 | renderer() | hidden |
    | Phone | `Phone` |  | flex 1 | renderer() | hidden |
    | Mobile | `Mobile` |  | flex 1 | renderer() | hidden |
    | Email | `Email` |  | flex 1 | renderer() | hidden |
    | Website | `Website` |  | flex 1 | renderer() | hidden |
    | Address | `Address` |  | flex 1 | renderer() | hidden |
    | CreatedDate | `CreatedDate` |  | flex 1 | renderer() | hidden |

- **grid** · renders into `divStatusesKanbanGrid` · store `LeadStatusKanbanStore`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Lead status name | `Name` |  | flex 1 | RenderHTMLText |  |
    | Show in Kanban | `IsKanban` | check column | 150 | renderer() |  |


#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| combo |  | `div_Index_SalesRep` | `vTenantContactStore` | shows `Name` · value `ContactID` · placeholder `Choose...` · pick-only |
| combo |  | `div_Board_SalesRep` | `vTenantContactStore` | shows `Name` · value `ContactID` · placeholder `Choose...` · pick-only |
| date field |  | `divFromList` | `` | placeholder `Choose...` · format `UserDateFormat` |
| date field |  | `divToList` | `` | placeholder `Choose...` · format `UserDateFormat` |
| date field |  | `divFromBoard` | `` | placeholder `Choose...` · format `UserDateFormat` |
| date field |  | `divToBoard` | `` | placeholder `Choose...` · format `UserDateFormat` |
| combo |  | `divPeriodList` | `DatePeriodStore` | shows `name` · value `value` · pick-only |
| combo |  | `divPeriodBoard` | `DatePeriodStore` | shows `name` · value `value` · pick-only |
| combobox |  | `divSummarize` | `LeadSummariseByStore` | shows `Name` · value `Value` · pick-only |

### `Opportunity2019`

7 grids · 40 standalone fields · 0 windows · 7 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `divAdditionalTransactionsContainer` · placeholder `You do not have any tasks.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Task name | `Debit` |  | flex 1 | renderer() |  |
    | Task category | `Credit` |  | flex 1 | renderer() |  |
    | Due | `Reference` |  | flex 1 | renderer() |  |
    | Start time | `Date` | date column | flex 1 | edit: date field |  |
    | End time | `Amount` |  | flex 1 | renderer() |  |

- **grid** · renders into `divAttachmentList` · store `AttachmentsStore` · placeholder `You do not have any files attached.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Name | `FileName` |  | flex 2 | renderer() |  |
    | Date | `Date` |  | flex 1 | renderer() |  |
    | Attached by | `UserName` |  | flex 2 | RenderHTMLText |  |
    | Processed | `IsProcessed` | check column | 80 | renderer() |  |

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

- **grid** · renders into `divQuoteLines` · placeholder `You do not have any products in this opportunity.`
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
    | Margin | `AverageCost` |  | flex 1 | renderer() |  |
    | Total | `Total` |  | flex 1 | renderer() | total sum |

- **grid** · renders into `divQuoteAdditionalChargesLines` · placeholder `You do not have any additional charges in this opportunity.`
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
| combo |  | `cmbAvalaraTaxExemptionCode` | `vSale_AvalaraSaleTaxCodeStore` | shows `Name` · value `Code` · placeholder `Choose...` |
| combo |  | `cmbAvalaraTaxExemptionCode_NewAddress` | `vSale_AvalaraSaleTaxCodeStore` | shows `Name` · value `Code` · placeholder `Choose...` |
| combo |  | `inputId` | `AutocompleteAddressField.prototype.AddressInfoSto…` | shows `description` · value `place_id` · placeholder `Look up an address` |
| combo |  | `tdOpportunity_NewCustomer_Currency` | `currencyStore` | shows `Code` · value `Code` |
| combo |  | `tdLead_Index_CloseChance` | `CloseChanceStore` | shows `Name` · value `Value` · placeholder `Choose...` · pick-only |
| combo |  | `tdLead_Index_Status` | `LeadStatusStore` | shows `Name` · value `Name` · placeholder `Choose...` · pick-only |
| number field |  | `tdLead_Index_Amount` | `` |  |
| date field |  | `tdLead_Index_CloseDate` | `` | placeholder `Choose...` · format `UserDateFormat` |
| combo |  | `tdSale_NewProduct_Supplier` | `SupplierStore` | shows `Name` · value `SupplierID` · placeholder `type to search...` |
| combo (+ add new) |  | `Sale_Index_Customer` | `vOpportunity_CustomerStore` | shows `Name` · value `Name` · placeholder `type to search...` |
| combo |  | `Sale_Index_Ship_Another_Customer` | `vOpportunity_ShipAnotherCustomerStore` | shows `Name` · value `Name` · placeholder `type to search...` |
| combo |  | `Sale_Index_SippingAnotherAddressLine1` | `vOpportunity_ShipAnotherCustomerAddressStore` | shows `Line1` · value `AddressID` · placeholder `Choose...` |
| combo (+ add new) |  | `Sale_Index_Contact` | `vOpportunity_CustomerContactStore` | shows `Name` · value `Name` · placeholder `Choose...` |
| text field |  | `Sale_Index_Phone` | `` | placeholder `write...` |
| text field |  | `Sale_Index_Email` | `` | placeholder `write...` |
| combo (+ add new) |  | `Sale_Index_BillingAddressLine1` | `vOpportunity_CustomerAddressStore` | shows `Line1` · value `Line1` · placeholder `Address` |
| text field |  | `Sale_Index_BillingAddressLine2` | `` | placeholder `City, state, country, zip` |
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
| date field |  | `Sale_Index_Date` | `` | placeholder `Choose...` · format `UserDateFormat` |
| combo (+ add new) |  | `Sale_Index_SippingAddressLine1` | `vOpportunity_CustomerAddressStore` | shows `Line1` · value `Line1` · placeholder `Choose...` |
| text field |  | `Sale_Index_SippingAddressLine2` | `` | placeholder `Choose...` |
| checkbox |  | `Sale_Index_ShipToOther` | `` |  |
| date field |  | `WorkflowModal_dtWorkflowDate` | `` | format `UserDateFormat` |
| text field |  | `renderTo` | `` |  |
| combo |  | `renderTo` | `localStore` | shows `name` · value `value` · placeholder `Choose...` · pick-only |
| checkbox |  | `renderTo` | `` |  |
| numeric field |  | `renderTo` | `` |  |
| date field |  | `renderTo` | `` | placeholder `Choose...` · format `UserDateFormat` |
| text field |  | `renderTo` | `` |  |
| checkbox |  | `renderTo` | `` |  |
| numeric field |  | `renderTo` | `` |  |

#### Menus, buttons and other parts

- **component** · renders into `tdProductFamily` · store `FamilyStore` · shows `Name` · value `ID`
- **component** · renders into `tdFamilyOption1` · store `FamilyOptions1Store` · shows `value` · value `value` · pick-only · multi-select
- **component** · renders into `tdFamilyOption2` · store `FamilyOptions2Store` · shows `value` · value `value` · pick-only · multi-select
- **component** · renders into `tdFamilyOption3` · store `FamilyOptions3Store` · shows `value` · value `value` · pick-only · multi-select
- **component** · renders into `tdSale_Index_DefaultAccount` · store `vChartOfAccountsLinesStore` · shows `DisplayName` · value `Code` · placeholder `Choose...`
- **component** · id `cmpId` · renders into `renderTo` · store `localStore` · shows `name` · value `value` · placeholder `Choose...` · pick-only
- **column** “{attrSet.name}” · field `"CustomField".concat(…)`

### `OpportunityList2019`

1 grids · 3 standalone fields · 0 windows · 2 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `_self.containerId` · store `_self.store`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    |  | `@_self.modelKey` |  | flex 1 | renderer() | hidden |
    | Order # | `Number` |  | 90 | renderer() |  |
    | Created date | `Date` |  | 100 | renderer() |  |
    | Customer | `CustomerName` |  | flex 1 | renderer() |  |
    | Status | `Status` |  | flex 1 | renderer() |  |
    | Currency | `CustomerCurrency` |  | flex 1 | renderer() |  |
    | Sales representatives | `SalesRepresentative` |  | flex 1 | renderer() |  |
    | Total | `Total` |  | flex 1 | renderer() |  |


#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| date field |  | `startreportrangemanual` | `` | placeholder `Choose...` · format `UserDateFormat` |
| date field |  | `endreportrangemanual` | `` | placeholder `Choose...` · format `UserDateFormat` |
| combo |  | `containerId` | `vTenantContactsStore` | shows `Name` · value `Name` · placeholder `Sales rep ...` |

#### Menus, buttons and other parts

- **EmbeddedCalendarPicker** · renders into `startreportrange` · placeholder `Choose...` · format `UserDateFormat`
- **EmbeddedCalendarPicker** · renders into `endreportrange` · placeholder `Choose...` · format `UserDateFormat`

### `TaskList2019`

2 grids · 10 standalone fields · 0 windows · 0 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · id `ObserverListGrid` · renders into `divObserversGrid` · store `vTaskObserverStore`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    |  | `IsMain` |  | flex 1 | renderer() |  |
    | Name | `Name` |  | flex 1 | renderer() |  |
    | Create date | `CreatedDate` |  | flex 1 | renderer() |  |
    | Remove | `` |  | flex 1 | renderer() |  |

- **grid** · id `TaskListGrid` · renders into `TaskList_Container` · store `taskStore`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    |  | `Importance` |  | flex 1 | renderer() |  |
    | Name | `Name` |  | flex 1 | renderer() |  |
    | Created by | `AssignedByName` |  | flex 1 | renderer() |  |
    | Start date | `StartDate` |  | flex 1 | renderer() |  |
    | End date | `EndDate` | date column | flex 1 | renderer() |  |
    | Completed | `CompletedDate` |  | flex 1 | renderer() | hidden |
    | Assigned to | `AssignedToName` |  | flex 1 | renderer() |  |
    | Category | `TaskCategoryName` |  | flex 1 | renderer() | hidden |
    | Status | `TaskStatus` |  | flex 1 | RenderHTMLText |  |
    | Link | `LinkTo` |  | flex 1 | renderer() |  |
    | Description | `Details` |  | flex 2 | renderer() |  |
    | Observers | `` |  | 80 | renderer() |  |
    | Created | `CreatedDate` |  | flex 1 | renderer() | hidden |


#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| combo |  | `divTenantUsers` | `filteredUserStore` | shows `Email` · value `UserId` · placeholder `Choose...` · pick-only |
| date field |  | `divSetDeadlineDate` | `` | format `TaskModule_DateFormatExt` |
| date field |  | `divFromList` | `` | placeholder `Choose...` · format `UserDateFormat` |
| date field |  | `divToList` | `` | placeholder `Choose...` · format `UserDateFormat` |
| date field |  | `divFromGantt` | `` | placeholder `Choose...` · format `UserDateFormat` |
| date field |  | `divToGantt` | `` | placeholder `Choose...` · format `UserDateFormat` |
| number field |  | `txbPartValue` | `` |  |
| combo |  | `divPeriodList` | `DatePeriodStore` | shows `name` · value `value` · pick-only |
| combo |  | `divPeriodGantt` | `DatePeriodStore` | shows `name` · value `value` · pick-only |
| checkbox |  | `TaskList_OnlyImportantTasks` | `` |  |

