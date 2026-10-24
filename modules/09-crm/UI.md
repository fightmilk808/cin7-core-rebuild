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

## Components by bundle

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

