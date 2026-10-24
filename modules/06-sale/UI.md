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

## Components by bundle

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


