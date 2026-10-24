# Sale

Customers and the sale documents: quotes, simple and advanced (multi-fulfilment) sales, service sales, pick/pack/ship fulfilment, invoices, credit notes, customer payments, awaiting sales, recurring invoices, fulfilment orders, returns (RMA), warranties and discounts.

| | Count |
|---|---:|
| Pages | 16 |
| Data models | 156 (plus [shared](../00-shared/README.md)) |
| Internal endpoints | 304 (121 write) |
| Public API operations | 45 |

## How to rebuild it

1. **Schema.** Create one table per data model below (156), starting from the generated [`schema.sql`](schema.sql). Ids are GUIDs; join on the `*ID` fields.
2. **Internal API.** Implement each controller's endpoints with the verbs listed, following the [internal API contract](../../docs/INTERNAL-API.md): one URL per store for GET/POST/PUT/DELETE, paged reads returning `{root, total}`, saves wrapped as `{ID, HasErrors, Original, Updated}`.
3. **Screens.** Build each route below as a server-rendered shell that loads the shell bundle and the page's own app, opening a record from `#<guid>` once at load ([page model](../../docs/ARCHITECTURE.md#what-a-page-is)). Every grid, column, field, button and dialog is in [UI.md](UI.md).
4. **Public API.** Expose the 45 operations below under `/ExternalApi/v2` with header auth ([public API contract](../../docs/PUBLIC-API.md)).

## Pages

| Route | Menu label | Title | Bundle | Endpoints (write) |
|---|---|---|---|---:|
| `/AwaitingSale` | Awaiting sale | Awaiting approval sale | `AwaitingSale2019` | 34 (12) |
| `/CreditNote` | Sale credit note | Credit note | `CreditNote2019` | 33 (12) |
| `/Customer` | Customer | Customer | `MultilingualSupport2019 CustomerEdit2019` | 31 (12) |
| `/CustomerList` | Customers / Credits | Customers | `CustomerList2019` | 9 (4) |
| `/CustomerPayment` | Bulk payment (customers) | Customer bulk payment | `CustomerPayment2019` | 4 (6) |
| `/DiscountNew` | Discount | Discount | `DiscountNew2019` | 1 (1) |
| `/FulfillmentOrder` | Fulfillment order | Fulfillment order | `FulfilmentOrder2019` | 8 (2) |
| `/FulfillmentOrderList` | Fulfillment orders | Fulfillment orders | `FulfilmentOrderList2019` | 1 (0) |
| `/RMA` | RMAs | RMA | `RMA2019` | 39 (19) |
| `/RMAReturnOrder` | Return orders | Return order | `RMAReturnOrder2019` | 42 (16) |
| `/RecurringInvoices` | Recurring sales | Recurring invoices | `RecurringInvoices2019` | 1 (1) |
| `/Sale` | Simple sale | Simple sale | `Customization2019 SimpleSale2019` | 81 (37) |
| `/SaleList` | Sales | Sales | `SalesList2019` | 26 (7) |
| `/SaleMultiple` | Advanced sale | Advanced sale | `Customization2019 SaleMultiple2019` | 84 (37) |
| `/SaleService` | Service sale | Service sale | `ServiceSale2019` | 51 (23) |
| `/Warranties` | Warranties | Warranties | `Warranties2019` | 1 (0) |

## Data models

ExtJS models the pages use; `v` prefix = view-model. Full DDL in [`schema.sql`](schema.sql).

| Model | Fields |
|---|---|
| `AccessPermission` | Name:string, Title:string |
| `AccountCurrency` | Code:string, Currency:string |
| `AdditionalCharge` | ID:string, GroupedAdditionalChargeID:string, IsIncludedToAdditionalCharge:bool, JobMilestoneID:string, Amount:float, Comment:string, Description:string, Discount:float, LineOrder:number, Price:float, Quantity:number, RmaProductID:string, TaskID:string, Tax:float, TaxPercent:float, TaxRule:string, Total:float, ValidationText:string, ValidationState:string |
| `AddressCategory` | Value:string, Name:string |
| `AvailablePortals` | ID:string, Name:string |
| `AvalaraSaleTaxCode` | Code:string, Name:string |
| `AwaitingApprovalSale` | ID:string, SourcePurchaseID:string, CustomerID:string, CustomerName:string, Contact:string, Phone:string, Email:string, DefaultAccount:string, BillingAddressLine1:string, BillingAddressLine2:string, Currency:string, TaxPercent:float, TaxInclusive:bool, TaxSchema:string, Discount:float, TermDays:int, TermMethod:int, Terms:string, PriceTier:int, ShippingAddressLine1:string, ShippingAddressLine2:string, ShipmentRequiredByDate:date, OrderLocationID:string, SaleOrderLocation:string, SaleOrderDate:date, SaleTaskMemoInternal:string, SaleOrderMemo:string, CustomerReference:string, Status:string, Sale… |
| `ChooseProducts` | ID:string, BatchSerialNo:string, Country:string, CustomerComments:string, CustomerID:string, CustomerName:string, ExpiryDate:date, FulfilmentLink:string, FulfilmentTaskID:string, MaxQuantityToReturn:number, SaleQuantity:number, PackingCondition:string, Price:float, ProductCode:string, ProductID:string, ProductName:string, ProductType:string, QuantityToReturn:number, RMAReturnPolicyID:string, RMAReturnPolicyName:string, ReasonForReturnID:string, ReturnType:string, SaleTaskID:string, Tax:float, Total:float, TotalCost:float, TotalQuantity:number, WarrantyExpiryDate:string, WarrantyNumber:string,… |
| `CreditNoteLineSelect` | FakeKey:int, ProductID:string, Quantity:float, RemainingQuantity:float, Price:float, Discount:float, Name:string, AccountCode:string, SupplierInventoryCode:string, UnitOfMeasure:string, ProductCode:string, CostingMethod:string, TaxRule:string, TaxPercent:float |
| `CustomFilterCondition` | CustomFilterID:string, CustomFilterConditionID:string, DisplayName:string, ParameterName:string, Condition:string, ParameterFakeValue:auto, ParameterValue:string, ParameterValueDisplayNameJson:string, JoinCondition:string, ConditionNumber:int, ParameterType:string, ValueType:string, AttributeSetId:string |
| `CustomPriceLine` | ProductID:string, ProductName:string, ProductCode:string, CustomPrice:float, ImageID:string, LatestPrice:float, LatestDate:date, ValidationState:string, ValidationText:string |
| `Customer` | CustomerID:string, Name:string, Currency:string, PaymentTerm:string, TaxRule:string, Comments:string, DefaultSalesRepresentative:string, AccountCode:string, DefaultLocation:string, Discount:float, DefaultCarrier:string, SalePriceTier:int, CreditLimit:float, IsVATRegistered:bool, PlaceOfSupply:string |
| `CustomerAddress` | CustomerID:string, AddressID:string, Line1:string, Line2:string, Type:string, DefaultForType:bool, AddressLine1:string, AddressLine2:string, AddressCitySuburb:string, CitySuburb:string, AddressStateProvince:string, StateProvince:string, AddressCountry:string, Country:string, AddressZipPostCode:string, ZipPostCode:string, TaxExemptionReasonCode:string |
| `CustomerContact` | CustomerID:string, ContactID:string, Name:string, IsDefault:bool, Phone:string, Email:string |
| `CustomerDefaultTemplate` | DefaultTemplateID:string, TemplateID:string, Type:string |
| `CustomerPaymentWrapper` | DimensionsPermission:string, IsAccountingDimensionsEnabled:bool |
| `CustomerStatus` | Value:string, Name:string |
| `CustomerWrapper` | ID:int, HasErrors:bool, HasAvalaraIntegration:bool |
| `DiscountWrapper` | ID:int, HasErrors:bool |
| `FamilyMatrix_Option` | name:string, index:int, values:string |
| `FamilyMatrix_ProductAvailability` | ProductID:string, ProductCode:string, Name:string, UnitOfMeasure:string, PriceTear1:float, PriceTear2:float, PriceTear3:float, PriceTear4:float, PriceTear5:float, PriceTear6:float, PriceTear7:float, PriceTear8:float, PriceTear9:float, PriceTear10:float, Available:float, OnHand:float, AverageCost:float, CostingMethod:string, RevenueAccount:string, BatchSN:string, ExpiryDate:date, DropShipMode:string, SaleTaxRule:string, Account:string, TaxRule:string, TaxPercent:float, ImageID:string, Type:string, Option1:string, Option2:string, Option3:string, AddQuantity:float |
| `FamilyMatrix_Value` | name:string |
| `FamilyOption` | value:string |
| `FamilyProduct` | ProductID:string, ProductCode:string, Name:string, UnitOfMeasure:string, Price:float, CostingMethod:string, RevenueAccount:string, DropShipMode:string, TaxRule:string, ImageID:string, NonInventory:bool |
| `FulfillmentBoxOptionModel` | Name:string, Description:string |
| `FulfillmentListItem` | number:int, count:number |
| `GiftCardGlobalSettings` | GiftCardProductID:string, IsGiftCardEnabled:bool, DefaultGiftCardExpirationPeriod:string, CanGiftCardExpire:bool, GiftCardSaleTaxID:string, GiftProductName:string, GiftProductCode:string, GiftCardRevenueAccount:string, GiftCardRevenueAccountName:string, CanGiftCardRefund:bool |
| `GroupedAdditionalCharge` | ID:string, CostTypeID:string, CostTypeName:string, IsIncudedInInvoice:bool, OriginalIsIncudedInInvoice:bool, TaskID:string, Total:float |
| `InvoiceForCreditNote` | TaskID:string, Invoice:string, Date:date |
| `InvoiceForFulfillment` | Invoice:string, Date:date |
| `JobCosting` | CustomerID:string, CustomerName:string, Comments:string, Contact:string, AddressLine1:string, AddressLine2:string, CustomerCurrency:string, Phone:string, PaymentTerm:string, TaxRuleID:string, DefaultSalesRepresentative:string, Discount:float, SalePriceTier:int, CreditLimit:float, SaleAccount:string, DefaultLocation:string |
| `JobTasks` | ID:string, AccountCode:string, AddressLine1:string, AddressLine2:string, AttributeSet:string, AutoInvoice:bool, BudgetedMargin:float, Comments:string, CompletedDate:date, Contact:string, CustomField1:string, CustomField2:string, CustomField3:string, CustomField4:string, CustomField5:string, CustomField6:string, CustomField7:string, CustomField8:string, CustomField9:string, CustomField10:string, CustomerCurrency:string, CustomerID:string, CustomerName:string, EstimatedValue:float, Frequency:number, JobID:string, JobNumber:string, JobResolution:string, Name:string, NextInvoiceDate:date, Phone:s… |
| `LineInfo` | RMAStatus:string, RmaProductID:string, RmaTaskID:string, ValidationState:string, ValidationText:string |
| `LogisticsProviderOptionModel` | Name:string, Description:string |
| `LookupCarrierModel` | FakeID:string, CarrierCode:string, ServiceCode:string, Highlighted:bool, DisplayName:string |
| `McfChannelMapping` | Id:string, ChannelName:string, ConfigID:string, FulfillmentBoxSetting:string, LogisticsProviderSetting:string |
| `MilestonesToJob` | DateActual:date, DateEstimated:date, Description:string, ID:string, JobID:string, LinksCount:number, MilestoneResolution:string, Name:string, Status:string, SysDate:date, ValidationState:string, ValidationText:string |
| `MilestonesToJob2` | Amount:float, Date:date, MilestoneID:string, MilestoneName:string, Number:string, TaskID:string, TaskType:string |
| `NewvTenantContact` | ContactID:string, Name:string, Phone:string, Fax:string, Email:string, Website:string, Type:string, DefaultForType:bool, Comment:string |
| `PeriodModel` | Period:string, Name:string |
| `PickLocations` | FakeKey:string, ProductID:string, ProductCode:string, Name:string, UnitOfMeasure:string, LocationID:string, Location:string, CostingMethod:string, BatchSN:string, ExpiryDate:date, Available:float, ImageID:string, IsFirst:bool, NonInventory:bool |
| `PortalInvites` | ID:string, PortalName:string, RecipientName:string, RecipientEmail:string, PortalId:string, Status:string, StatusDisplay:string, InvitationID:string, InvitationLink:string |
| `ProductToInvoice` | FakeID:string, ProductID:string, ProductCode:string, Name:string, Quantity:float, Price:float, Discount:float, AccountCode:string, UnitOfMeasure:string, TaxRule:string, ImageID:string, ConfigurationID:string, NonInventory:bool |
| `RMADropShipReplacement` | ID:string, ResolutionID:string, BatchSerialNo:string, Quantity:number, ExpiryDate:date |
| `RMAPrinting` | TemplateID:string, EmailTemplateID:string, Type:string, Name:string |
| `RMAProductAttachments` | ID:string, RMAProductID:string, FileName:string, BlobID:string, TaskID:string |
| `RMAResolution` | RmaTaskID:string, RmaProductID:string, ID:string, ResolutionType:string, JobID:string, JobMilestoneID:string, RmaReturnOrderTaskID:string, Resolution:string, ReturnOrderResolution:string, LocationID:string, LocationName:string, Quantity:number, InTransitAccountName:string, EffectiveDate:date, StockTranferTaskID:string, StockTranferNumber:string, Comments:string, BinID:string, BinName:string, BatchSerialNo:string, ExpenseAccount:string, ExpenseAccountName:string, Cost:float, AdditionalCharges:float, Total:float, Status:string, RestockToProductID:string, RestockToProductCode:string, RestockToPr… |
| `RMAReturnOrdersRelatedOrders` | Date:date, ID:string, InvoiceNumber:string, Number:string, RelatedTaskID:string, RelatedTaskType:string, RmaProductID:string, RmaTaskID:string, Status:string |
| `RMAReturnPolicy` | ID:string, Name:string, CreatedDate:date, UpdatedDate:date, IsActive:bool, IsRefundPossible:bool, RefundPaymentOptions:string, RefundDays:int, IsReplacementPossible:bool, IsPossibleCrossSale:bool, ReplacementDays:int, RestockingFeesPercent:int, RestockingFeesFixedAmount:int, InspectionsCost:string, RepairCost:string, IsReturnPossible:bool, ReturnDays:int, ShippingCost:string, PolicyText:string |
| `ROProduct` | Account:string, BinID:string, Code:string, Cost:float, CostingMethod:string, Name:string, NonInventory:bool, ProductID:string, SupplierInventoryCode:string, TaxRule:string, Type:string, Unit:string |
| `ReasonForReturn` | ID:string, Name:string |
| `RecurringFrequency` | Value:string, Name:string |
| `RecurringInvoice` | TaskID:string, IsServiceOnly:bool, InvoiceNumber:string, Customer:string, CustomerCurrency:string, Total:float, Frequency:string, NextInvoiceDate:date, IsSelected:bool, ValidationText:string, ValidationState:string |
| `RelatedTask` | Date:date, ID:string, InvoiceNumber:string, Number:string, RelatedTaskID:string, RelatedTaskType:string, RmaProductID:string, RmaTaskID:string, Status:string |
| `Resolution` | RmaTaskID:string, RmaProductID:string, ID:string, ResolutionType:string, JobID:string, JobMilestoneID:string, RmaReturnOrderTaskID:string, Resolution:string, ReturnOrderResolution:string, LocationID:string, LocationName:string, Quantity:number, InTransitAccountName:string, EffectiveDate:date, StockTranferTaskID:string, StockTranferNumber:string, Comments:string, BinID:string, BinName:string, BatchSerialNo:string, ExpenseAccount:string, ExpenseAccountName:string, Cost:float, AdditionalCharges:float, Total:float, Status:string, RestockToProductID:string, ReturnToCustomerHasBeenSent:bool, Return… |
| `ReturnOrders` | ReturnOrderTaskID:string, ReturnOrderNumber:string, TaskID:string |
| `SSCarrier` | ParentFakeID:string, FakeID:string, FFID:string, Name:string, Description:string |
| `SSPackageType` | name:string, value:string |
| `SSRecord` | FakeID:string, FFID:string, Carrier:string, ShippingService:string, CarrierText:string, ShippingServiceText:string, ID:string |
| `SSService` | ID:string, FFID:string, ParentFakeID:string, Carrier:string, Name:string, CarrierPrice:number, CarrierCurrency:string, Margin:number, Cost:number, Currency:string, Description:string |
| `SaleCustomFilterConditionConditionParameter` | AutomatedWorkflowConditionParameterID:string, DisplayName:string, ParameterName:string, EntityType:string, AvailableConditions:string, IsActive:bool, ValueType:string, AvailableValues:string, AttributeSetId:string, GroupNumber:int, IsFirstGroupMember:bool |
| `SaleOrderLineUploadError` | ValidationState:string, ValidationText:string, Line:int, SKU:string, SKUError:string, Name:string, NameError:string, Comment:string, CommentError:string, Quantity:string, QuantityError:string, Price:string, PriceError:string, Discount:string, DiscountError:string |
| `SalePickerModel` | UserID:string, Email:string |
| `SaleQuoteLineUploadError` | ValidationState:string, ValidationText:string, Line:int, SKU:string, SKUError:string, Name:string, NameError:string, Comment:string, CommentError:string, Quantity:string, QuantityError:string, Price:string, PriceError:string, Discount:string, DiscountError:string |
| `SaleReferenceData` | ID:int, COGSAccount:string, RevenueAccount:string, DefaultTaxRule:string, ProductFamilyCount:int, DiscountCount:int, CouponCount:int, SkipQuote:bool, SkipPack:bool, SkipShip:bool, ShowInvoiceBeforeFulfillment:bool, HasSaleDefaultAttributeSet:bool, AllowOrderNoAlloc:bool, ShipStation:bool, ExternallyFulfiledOrdersToShipStation:bool, ShipZonesEnabled:bool, DefaultShipDate:string, QuoteViewPermission:string, QuoteAuthorisationPermission:string, OrderViewPermission:string, OrderAuthorisationPermission:string, PickViewPermission:string, PickAuthorisationPermission:string, PackViewPermission:string… |
| `SaleTask` | TaskID:string, CustomerID:string, CustomerName:string, Contact:string, Phone:string, Email:string, DefaultAccount:string, SkipQuote:bool, BillingAddressLine1:string, BillingAddressLine2:string, Currency:string, TaxPercent:float, TaxInclusive:bool, TaxSchema:string, Discount:float, TermDays:int, TermMethod:int, Terms:string, PriceTier:int, ShippingAddressLine1:string, ShippingAddressLine2:string, ShipmentRequiredByDate:date, SaleOrderLocation:string, SaleOrderNumber:string, SaleOrderDate:date, SaleTaskMemoInternal:string, InternalMark:string, QuoteMemo:string, SaleOrderMemo:string, InvoiceMemo… |
| `SaleTaskWrapper` | ID:string, HasErrors:bool, SuppressTransactions:bool, DiscountsDesciption:string |
| `Scrap` | ID:string, Location:string, Bin:string, BatchSerialNo:string, ExpenseAccount:string, EffectiveDate:date, Quantity:number, Cost:float, Total:float |
| `ShipBox` | Box:string |
| `vBin` | LocationID:string, Description:string |
| `vChildCustomer` | ChildCustomerID:string, ChildCustomerName:string |
| `vChildCustomerList` | Expand:string, CustomerID:string, Name:string, SaleAccount:string, DisplayName:string, TotalSale:float |
| `vCreditAllocated` | AllocationID:string, TaskID:string, DocNumber:string, Currency:string, Date:date, Amount:float |
| `vCustomPrice` | ProductID:string, CustomerID:string, Price:float, IsDeleted:bool |
| `vCustomerAddress` | CustomerID:string, AddressID:string, Line1:string, Line2:string, CitySuburb:string, StateProvince:string, ZipPostCode:string, Country:string, Type:string, DefaultForType:bool |
| `vCustomerContact` | CustomerID:string, ContactID:string, Name:string, JobTitle:string, Phone:string, MobilePhone:string, Fax:string, Email:string, Website:string, IsDefault:bool, Comment:string |
| `vCustomerDefaultTemplate` | DefaultTemplateID:string, TemplateID:string, CustomerID:string, Type:string |
| `vCustomerFile` | FileID:string, CustomerID:string, FileName:string, ContentType:string, UserName:string, UploadedDate:date, ExternalDownloadLink:string, ExternalViewLink:string |
| `vCustomerList` | Expand:string, CustomerID:string, Name:string, Contact:string, Phone:string, Mobile:string, Email:string, Website:string, Address:string, TotalAmount:float, PaidAmount:float, DueAmount:float, Currency:string, IsActive:bool, CustomField1:string, CustomField2:string, CustomField3:string, CustomField4:string, CustomField5:string, CustomField6:string, CustomField7:string, CustomField8:string, CustomField9:string, CustomField10:string, Selected:bool, IsOnCreditHold:bool, Edit:string, AttributeSetID:string, DisplayName:string, IsLegalEntity:bool |
| `vCustomerParent` | CustomerID:string, Name:string |
| `vCustomerPaymentsDue` | TaskID:string, CustomerID:string, InvoiceNumber:string, InvoiceDate:date, DueDate:date, SONumber:string, InvoiceAmount:float, PaidAmount:float, DueAmount:float, DaysOverdue:int, AllocatedAmount:float, SourceChannel:string |
| `vCustomerPurchases` | ID:string, ProductID:string, Quantity:float, Price:float, TaskID:string, InvoiceDate:date, CustomerCurrency:string, InvoiceNumber:string, Name:string, ProductCode:string, IsServiceOnly:bool, CustomerName:string, CustomerID:string, IsMasterCustomerParent:bool, IsMasterCustomerChild:bool |
| `vCustomerSaleTasks` | TaskID:string, SaleOrderNumber:string, Status:string, SaleOrderDate:date, InvoiceNumber:string, CustomerReference:string, InvoiceAmount:float, PaidAmount:float, ShipmentRequiredByDate:date, IsServiceOnly:bool, Controller:string, CustomerName:string, CustomerID:string, IsMasterCustomerParent:bool, IsMasterCustomerChild:bool |
| `vDearToDearNetworkingTaskLinks` | ID:string, SourceTaskID:string, SourceType:int, TargetTaskID:string, TargetType:int |
| `vDiscountLine` | FakeID:int, ID:string, DiscountID:string, MinValue:float, MaxValue:float, Type:string, Amount:float, ValidationText:string, ValidationState:string |
| `vExpenseAccounts` | Code:string, DisplayName:string, Class:string, ForPayments:bool, Type:string |
| `vFulfillmentOrder` | ID:string, FFOrderId:string, ExternalOrderID:string, ConfigID:string, Date:date, SaleTaskID:string, Currency:string, SaleOrderNumber:string, Memo:string, Status:string, Source:string, CustomerName:string, ContactName:string, ContactPhone:string, AddressZipPostCode:string, AddressCountry:string, AddressStateProvince:string, AddressCitySuburb:string, AddressLine1:string, AddressLine2:string, ShippingMethod:string, CanBeCancelled:bool, ShipmentLineID:string |
| `vFulfillmentOrderForList` | ID:string, Location:string, FFOrderId:string, Date:date, SaleTaskID:string, SaleOrderNumber:string, Memo:string, Status:string, ItemsCount:int, Selected:bool |
| `vFulfillmentOrderItem` | ID:string, IdInOrder:string, ProductID:string, SKU:string, FFSKU:string, Quantity:string, Comment:string, PSKU:string, PNAME:string |
| `vFulfillmentOrderItemDisposition` | ID:string, Quantity:string, TrackingNumber:string |
| `vFulfillmentOrderLog` | ID:string, LogDate:date, ChangesText:string, ChangedBy:string |
| `vFulfillmentOrderStatus` | ID:string, RecieveDate:date, ShipDate:date, ArrivalDate:date, OrderStatus:string, ShipStatus:string |
| `vFulfillmentOrderTrackingInfo` | ID:string, ArrivalDate:date, Package:string, Carrier:string, CarrierPhone:string, CarrierUrl:string, TrackingNumber:string, Status:string, History:string, AdditionalInfo:string |
| `vLocation` | LocationID:string, Description:string |
| `vLocationAndBin` | LocationID:string, LocationName:string |
| `vRMA` | TaskID:string, Contact:string, CreatedDate:date, CustomerID:string, CustomerName:string, Email:string, ExpiredDate:date, Number:string, Phone:string, ReceiptsLocationID:string, ReceiptsLocationName:string, ShipAddressID:string, ShipToAddress1:string, ShipToAddress2:string, ShipToCity:string, ShipToCompany:string, ShipToContact:string, ShipToCountry:string, ShipToOther:bool, ShipToPostCode:string, ShipToState:string, ShippingAddressLine1:string, ShippingAddressLine2:string, ReturnOrder:string, ShippingNotes:string, Status:string, ValidationState:string, ValidationText:string, IsFulfilmentCompl… |
| `vRMAAttachments` | TaskID:string, ID:string, BlobID:string, ContentType:string, FileName:string, Date:date, UserName:string, IsProcessed:bool |
| `vRMAExpenseAccount` | DisplayName:string, RuleID:string |
| `vRMAInTransitAccount` | DisplayName:string, Code:string |
| `vRMAList` | TaskID:string, Number:string, SaleOrderNumber:string, SaleOrderCustomerReference:string, CustomerName:string, CustomerID:string, Contact:string, Phone:string, Email:string, ReceiptsLocationID:string, ReceiptsLocationName:string, ShipToOther:bool, ShipToCompany:string, ShipToContact:string, ShipToCountry:string, ShipToPostCode:string, ShipToState:string, ShipToCity:string, ShipToAddress1:string, ShipToAddress2:string, ShippingAddressLine1:string, ShippingAddressLine2:string, CreatedDate:date, ExpiredDate:date, Status:string |
| `vRMAProductAttachments` | ID:string, RmaProductID:string, FileName:string, BlobID:string, TaskID:string |
| `vRMAProducts` | Selected:bool, ID:string, TaskID:string, ProductType:string, ParentSaleTaskID:string, FulfilmentTaskID:string, ProductID:string, ProductCode:string, ProductName:string, ExpiryDate:date, SaleOrderNumber:string, SaleOrderCustomerReference:string, SaleLink:string, InvoiceNumber:string, WarrantyExpiredDate:date, WarrantyRegistrationNumber:string, ReturnPolicyName:string, ReturnPolicyID:string, IsCrossShipping:bool, IsDropShipping:bool, ShippingTrackingNumber:string, CustomerComments:string, BatchSerialNo:string, ReasonForReturnID:string, ReasonForReturnName:string, ReturnType:string, PackingCondi… |
| `vRMAProductsList` | TaskID:string, RMANumber:string, SaleOrderNumber:string, SaleOrderCustomerReference:string, CustomerName:string, CustomerID:string, Contact:string, Phone:string, Email:string, ReceiptsLocationID:string, ReceiptsLocationName:string, ShipToOther:bool, ShipToCompany:string, ShipToContact:string, ShipToCountry:string, ShipToPostCode:string, ShipToState:string, ShipToCity:string, ShipToAddress1:string, ShipToAddress2:string, ShippingAddressLine1:string, ShippingAddressLine2:string, CreatedDate:date, ExpiredDate:date, RMAStatus:string, ROStatus:string, RONumber:string, ProductID:string, ProductSKU:… |
| `vRMAReturnOrder` | TaskID:string, Contact:string, CreatedDate:date, CustomerID:string, CustomerName:string, Email:string, Number:string, Phone:string, ReceiptsLocationID:string, ReceiptsLocationName:string, RmaDate:date, RmaID:string, RmaNumber:string, ScrapWriteOffDefaultExpenseAccountName:string, ScrapWriteOffDefaultExpenseAccount:string, ShipAddressID:string, ShipToAddress1:string, ShipToAddress2:string, ShipToCity:string, ShipToCompany:string, ShipToContact:string, ShipToCountry:string, ShipToOther:bool, ShipToPostCode:string, ShipToState:string, ShippingAddressLine1:string, ShippingAddressLine2:string, Shi… |
| `vRMAReturnOrderAttachments` | RMAReturnOrderTaskID:string, ID:string, BlobID:string, ContentType:string, FileName:string, Date:date, UserName:string, IsProcessed:bool |
| `vRMAReturnOrderGeneral` | TaskID:string, Number:string, RmaNumber:string, RmaDate:date, CustomerName:string, CustomerID:string, Contact:string, Phone:string, Email:string, ReceiptsLocationID:string, ReceiptsLocationName:string, ShipToOther:bool, ShipToCompany:string, ShipToContact:string, ShipToCountry:string, ShipToPostCode:string, ShipToState:string, ShipToCity:string, ShipToAddress1:string, ShipToAddress2:string, ShippingAddressLine1:string, ShippingAddressLine2:string, CreatedDate:date, ExpiredDate:date, Status:string, ReceiveStatus:string, ResolutionStatus:string |
| `vRMAReturnOrderProductAttachment` | ID:string, RmaReturnOrderProductID:string, FileName:string, BlobID:string, TaskID:string |
| `vRMAReturnOrderProducts` | BatchSerialNo:string, BinID:string, BinName:string, CostingMethod:string, CustomerComments:string, FulfilmentTaskID:string, ID:string, TaskID:string, ParentSaleTaskID:string, ProductID:string, ProductName:string, ProductCode:string, QuantityToReturn:number, ReasonForReturnID:string, ReasonForReturnName:string, ReceiptAction:string, ReceivedQuantity:number, ExpiryDate:date, RmaProductID:string, Status:string, ValidationState:string, ValidationText:string, WarrantyExpiredDate:date, WarrantyRegistrationNumber:string, ReturnPolicyID:string, ReturnExpirationDate:date, RefundExpirationDate:date, Re… |
| `vRMASaleOrderInvoiceNumbers` | Number:string, CustomerReference:string |
| `vRMASuppliers` | SupplierID:string, Name:string |
| `vRMASuppliersAddresses` | AddressID:string, Line1:string, Line2:string, ShipToCity:string, ShipToCountry:string, ShipToLine1:string, ShipToLine2:string, ShipToPostcode:string, ShipToState:string, SupplierID:string |
| `vRMATaxRule` | Description:string, RuleID:string |
| `vSaleAdditionalCOGS` | FakeID:int, TaskID:string, ID:string, Reference:string, Amount:float, Date:date, Debit:string, Credit:string, ValidationText:string, ValidationState:string |
| `vSaleAllocations` | SaleCreditID:string, AllocationID:string, SalePaymentID:string, TaskID:string, Flag:bool |
| `vSaleConsolidatedTranscations` | ID:string, Channel:string, CreatedDate:date, Currency:string, Reference:string, TotalAmountForeign:float, TotalAmountLocal:float, TransactionDate:date, Type:string, UpdatedDate:date, Comment:string |
| `vSaleCreditNoteCostLines` | FakeID:int, TaskID:string, InvoiceCostID:string, Description:string, Quantity:float, Amount:float, Discount:float, TaxRule:string, Tax:float, Total:float, AccountCode:string, TaxPercent:float, Type:string, LineOrder:int, ValidationText:string, ValidationState:string, Comment:string |
| `vSaleCreditNoteLines` | FakeID:int, TaskID:string, InvoiceLineID:string, ProductID:string, Quantity:float, Price:float, Discount:float, Tax:float, Total:float, Type:string, AccountCode:string, TaxRule:string, TaxPercent:float, LineOrder:int, Name:string, UnitOfMeasure:string, ProductCode:string, Comment:string, ValidationText:string, ValidationState:string |
| `vSaleCreditNotePaymentLines` | FakeID:int, TaskID:string, PaymentID:string, Reference:string, Amount:float, DatePaid:date, TaxRule:string, AccountCode:string, Type:string, PaymentType:string, CurrencyConversionRate:float, IsNewCustomerCredit:bool, ValidationText:string, ValidationState:string |
| `vSaleCreditWithDetails` | SaleCreditID:string, CustomerID:string, Currency:string, Amount:float, RemainingAmount:float, Account:string, Description:string, Date:date, AllocatedAmount:float, Selected:bool, ConvRate:float |
| `vSaleCredits` | SaleCreditID:string, CustomerID:string, CustomerName:string, Currency:string, Amount:float, RemainingAmount:float, Account:string, SourceLineID:string, CreditSourceTaskID:string, OrigTaskType:string, Type:string, Date:date |
| `vSaleExciseLines` | FakeID:int, TaskID:string, LineID:string, ProductID:string, Quantity:float, ExciseTax:float, Total:float, LineOrder:int, Name:string, ProductCode:string, ImageID:string, ValidationText:string, ValidationState:string |
| `vSaleGiftCards` | ID:string, TaskID:string, GiftCardCode:string, InitialBalance:float, CurrentBalance:float, Date:date, ExpirationDate:date, RefundID:string |
| `vSaleInvoiceAdditionalCharges` | FakeID:int, TaskID:string, InvoiceCostID:string, Description:string, Quantity:float, Amount:float, Discount:float, TaxRule:string, Tax:float, Total:float, AccountCode:string, TaxPercent:float, Type:string, LineOrder:int, ValidationText:string, ValidationState:string, Comment:string |
| `vSaleInvoiceLines` | FakeID:int, TaskID:string, InvoiceLineID:string, ProductID:string, Quantity:float, Price:float, Discount:float, Tax:float, Total:float, AccountCode:string, LineOrder:int, Name:string, UnitOfMeasure:string, ProductCode:string, AverageCost:float, CostingMethod:string, TaxRule:string, TaxPercent:float, Comment:string, ImageID:string, SourceProductCode:string, SourceProductName:string, ValidationText:string, ValidationState:string, DropShip:bool, DropShipMode:string, NonInventory:bool, SupplierLatestPurchasePrice:float, SupplierFixedCost:float, SupplierCurrency:string |
| `vSaleMult_Customer` | CustomerID:string, Name:string, Currency:string, PaymentTerm:string, TaxRule:string, Comments:string, DefaultSalesRepresentative:string, AccountCode:string, DefaultLocation:string, Discount:float, DefaultCarrier:string, SalePriceTier:int, CreditLimit:float, AttributeSet:string, BillParent:bool |
| `vSaleMult_CustomerAddress` | CustomerID:string, AddressID:string, Line1:string, Line2:string, Type:string, DefaultForType:bool, AddressLine1:string, AddressLine2:string, AddressCitySuburb:string, AddressStateProvince:string, AddressCountry:string, AddressZipPostCode:string, TaxExemptionReasonCode:string, IsParent:bool |
| `vSaleMult_CustomerContact` | CustomerID:string, ContactID:string, Name:string, IsDefault:bool, Phone:string, Email:string |
| `vSaleMult_TenantAddress` | AddressID:string, Line1:string, Line2:string, Type:string, DefaultForType:bool |
| `vSaleOrderAdditionalCharges` | FakeID:int, TaskID:string, OrderCostID:string, Description:string, Quantity:float, Amount:float, Discount:float, TaxRule:string, Tax:float, Total:float, TaxPercent:float, LineOrder:int, RevenueAccount:string, ValidationText:string, ValidationState:string, Comment:string |
| `vSaleOrderAttachement` | TaskID:string, AttachementID:string, BlobGUID:string, ContentType:string, FileName:string, Date:date, UserName:string, IsProcessed:bool, ExternalDownloadLink:string, ExternalViewLink:string |
| `vSaleOrderLines` | FakeID:int, TaskID:string, OrderLineID:string, ProductID:string, SourceProductCode:string, SourceProductName:string, Quantity:float, Price:float, Discount:float, Tax:float, Total:float, LineOrder:int, Name:string, UnitOfMeasure:string, ProductCode:string, AverageCost:float, CostingMethod:string, RevenueAccount:string, TaxRule:string, TaxPercent:float, Comment:string, ImageID:string, ValidationText:string, ValidationState:string, DropShip:bool, DropShipMode:string, NonInventory:bool, SupplierLatestPurchasePrice:float, SupplierFixedCost:float, SupplierCurrency:string |
| `vSalePackingSlips` | FakeID:int, TaskID:string, SlipID:string, ProductID:string, Quantity:float, BoxNumber:string, Name:string, UnitOfMeasure:string, ProductCode:string, CostingMethod:string, BatchSN:string, ExpiryDate:date, LocationID:string, ImageID:string, NonInventory:bool, WarrantySetupName:string, WarrantySetupID:string, WarrantySetupCalculationStartDate:string, WarrantySetupAutoGenerate:bool, WarrantyRegistrationNumber:string, ValidationText:string, ValidationState:string |
| `vSalePaymentLines` | FakeID:int, TaskID:string, PaymentID:string, Reference:string, Amount:float, DatePaid:date, TaxRule:string, AccountCode:string, Type:string, PaymentType:string, CurrencyConversionRate:float, ValidationText:string, ValidationState:string |
| `vSalePickings` | FakeID:int, TaskID:string, ID:string, ProductID:string, ProductCode:string, Name:string, UnitOfMeasure:string, Quantity:float, LocationID:string, Type:string, CostingMethod:string, BatchSN:string, ExpiryDate:date, ImageID:string, NonInventory:bool, WarrantySetupName:string, WarrantySetupID:string, WarrantySetupCalculationStartDate:string, WarrantySetupAutoGenerate:bool, WarrantyRegistrationNumber:string, ValidationText:string, ValidationState:string, RestockDate:date, RestockLocationID:string |
| `vSaleQuoteAdditionalCharges` | FakeID:int, TaskID:string, QuoteCostID:string, Description:string, Quantity:float, Amount:float, Discount:float, TaxRule:string, Tax:float, Total:float, TaxPercent:float, LineOrder:int, RevenueAccount:string, ValidationText:string, ValidationState:string, Comment:string |
| `vSaleQuoteLines` | FakeID:int, TaskID:string, QuoteLineID:string, ProductID:string, Quantity:float, Price:float, Discount:float, Tax:float, Total:float, LineOrder:int, Name:string, UnitOfMeasure:string, ProductCode:string, TaxRule:string, TaxPercent:float, RevenueAccount:string, Comment:string, ValidationText:string, ValidationState:string |
| `vSaleShipments` | FakeID:int, TaskID:string, ShipmentID:string, ShipmentDate:date, Carrier:string, ExternalService:string, Boxes:string, BoxesUI:string, TrackingNumber:string, TrackingUrl:string, FulfillmentBoxOption:string, LogisticsProviderOption:string, Shipped:bool, ValidationText:string, ValidationState:string |
| `vSaleTaskLineConfigs` | LineConfigurationID:string, TaskID:string, ConfigurationID:string, QuoteLineID:string, OrderLineID:string, InvoiceLineID:string |
| `vSaleTaskListAccounting` | ID:string, TaskID:string, Type:string, Customer:string, Contact:string, Phone:string, Email:string, Currency:string, CustomerRef:string, CustomField1:string, CustomField2:string, CustomField3:string, CustomField4:string, CustomField5:string, CustomField6:string, CustomField7:string, CustomField8:string, CustomField9:string, CustomField10:string, Total:float, Paid:float, Credited:float, Due:float, DaysOverdue:int, DocNo:string, Location:string, SaleOrderDate:date, Date:date, DueDate:date, OrderNo:string, SaleRep:string, Terms:string, Status:string, FulFilmentStatus:string, TT:int, Selected:boo… |
| `vSaleTaskListFulfilment` | TaskID:string, OrderNo:string, OrderDate:date, Customer:string, Contact:string, Phone:string, Email:string, FulfillmentNumber:int, CustomerReference:string, ShipmentRequiredByDate:date, ShippingAddressLine1:string, PickStatus:int, PackStatus:int, ShipStatus:int, SalesRepresentative:string, CustomField1:string, CustomField2:string, CustomField3:string, CustomField4:string, CustomField5:string, CustomField6:string, CustomField7:string, CustomField8:string, CustomField9:string, CustomField10:string, SaleOrderLocation:string, Status:string, FulFilmentStatus:string, TrackingNumbers:string, DaysOve… |
| `vSaleTaskListGeneral` | TaskID:string, Customer:string, Contact:string, Phone:string, Email:string, Currency:string, CustomerReference:string, CustomField1:string, CustomField2:string, CustomField3:string, CustomField4:string, CustomField5:string, CustomField6:string, CustomField7:string, CustomField8:string, CustomField9:string, CustomField10:string, DCQuoteTotal:float, DCOrderTotal:float, DocNumbers:string, FulFilmentStatus:string, InvoicingStatus:string, PaymentStatus:string, Location:string, OrderDate:date, ReqBy:date, OrderNo:string, OrderStatus:int, QuoteStatus:int, SaleRep:string, ShippingAddressLine1:string,… |
| `vSaleTaskOrderTags` | TaskId:string, AmazonPrime:bool, AmazonBusiness:bool |
| `vSaleTaskProductConfigurationOptions` | ConfigurationOptionID:string, ConfigurationID:string, TaskID:string, MenuConfigurationID:string, Description:string, Name:string, ParentName:string, ConfigurationOptionArtID:string, Type:string, MappedProductID:string, MappedProductName:string |
| `vSaleTaskProductConfigurations` | ConfigurationID:string, TaskID:string, ProductID:string, Description:string |
| `vSaleTaskWmsOperator` | ID:string, TaskID:string, UserName:string, StartedPickDate:date |
| `vSaleWarranty` | ID:string, WarrantyName:string, CustomerName:string, OrderNumber:string, OrderDate:string, BatchSN:string, RegistrationNumber:string, ExpiryDate:date, IsLifetime:bool |
| `vSale_CustomerAddress` | CustomerID:string, AddressID:string, Line1:string, Line2:string, Type:string, DefaultForType:bool, Type:string, AddressLine1:string, AddressLine2:string, AddressCitySuburb:string, AddressStateProvince:string, AddressCountry:string, AddressZipPostCode:string |
| `vSale_CustomerContact` | CustomerID:string, ContactID:string, Name:string, IsDefault:bool, Phone:string, Email:string |
| `vSale_TenantAddress` | AddressID:string, Line1:string, Line2:string, Type:string, DefaultForType:bool |
| `vShippingLabelAttachment` | BlobGUID:string, TrackNumber:string |
| `vShippingManifestAttachment` | BlobGUID:string, TrackNumber:string |
| `vShippingMethod` | ID:string, Name:string |
| `vShippingRateOrLabelProvider` | ID:string, IsDefault:bool, Name:string, SupportsConsolidatedShipment:bool |
| `vTenantCarrierWithShippingOptions` | CarrierID:string, Code:string, Description:string, ExternalService:string, IsDefault:bool |
| `vTenantPaymentTermNew` | TermID:string, Name:string, Days:int, Method:int, DueNextMonth:int, IsActive:bool, IsDefault:bool |
| `vTransferOrder` | Value:string, Name:string |

## Internal endpoints

Grouped by controller. Effect: 🟢 read · 🟠 read + write at the same URL · 🔴 write. `api` = JSON under `/api/`, `mvc` = controller action.

### AccountingDimensions

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/AccountingDimensions_Index_RealDimensions` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |

### address

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/address` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | CountryCode countryCode |  |  |
| `/api/address/country/code` | api | GET | 🟢 read |  |  |  |
| `/api/address/details` | api | GET | 🟢 read |  |  |  |
| `/api/address/hasAccess` | api | GET | 🟢 read |  |  |  |

### AmazonBusinessShipping

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/AmazonBusinessShipping/GetBhdrWarningOrDefault` | api | GET | 🟢 read |  |  |  |

### Avalara

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/Avalara_Index_vTaxCodeList/TaxExemptionReason` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Avalara_Index_vTaxCodeList/hasintegration` | api | GET | 🟢 read |  |  |  |

### AwaitingSale

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/AwaitingSale_Index_vTask` | api | DELETE PUT REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | id lang | ClientDateTime HasErrors ID Lang Original Updated |  |

### Cin7Capital

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/Cin7Capital/GenerateConnectTokenForSalesList` | mvc | POST | 🔴 write |  |  |  |
| `/Cin7Capital/GenerateSessionToken` | mvc | POST | 🔴 write | idList |  |  |

### Cin7Pay

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/Cin7Pay/CompleteMerchantInitiatedCin7PayByBulkInvoiceCallBack` | mvc |  | 🔴 write |  |  |  |
| `/Cin7Pay/CompleteMerchantInitiatedCin7PayByBulkInvoicePayment` | mvc | POST | 🔴 write |  |  |  |

### country

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/country` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |

### CreditNote

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/CreditNote/CountrySpecific` | mvc |  | 🟢 read | Key |  |  |

### currency

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/currency` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |

### Customer

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/Customer/CountrySpecific` | mvc |  | 🟢 read | Key |  |  |
| `/Customer/CustomerPseudonimyse` | mvc | POST | 🔴 write | CustomerID |  |  |
| `/Customer/DownloadFile` | mvc |  | 🟢 read | id |  |  |
| `/Customer/Upload` | mvc | POST | 🔴 write |  |  |  |
| `/api/Customer_Index_AvailablePortals` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | CustomerId |  |  |
| `/api/Customer_Index_InviteToB2B` | api | POST REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | CustomerId InviteItems |  |  |
| `/api/Customer_Index_ProductPrices` | api | DELETE REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | CustomerID customerID filter nonExistingOnly returnCount |  | root |
| `/api/Customer_Index_ReferenceData` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Customer_Index_RemoveParentRelationship` | api | POST | 🔴 write |  | CustomerID |  |
| `/api/Customer_Index_RevokeB2BAccess` | api | POST | 🔴 write | invitationId portalId |  |  |
| `/api/Customer_Index_vChildCustomers` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | CustomerID |  | root |
| `/api/Customer_Index_vCustomer` | api | GET POST PUT REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | CountrySpecificKey id | HasErrors ID Original Updated |  |
| `/api/Customer_Index_vCustomerChildrenList` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  | root |
| `/api/Customer_Index_vCustomerParent` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  | root |
| `/api/Customer_Index_vCustomerPurchases` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | CustomerID childCustomersFilter filter search |  | root |
| `/api/Customer_Index_vCustomerSaleTasks` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | CustomerID childCustomersFilter filter search |  | root |
| `/api/Customer_Index_vReportTemplates` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |

### customer

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/customer_Index_vCustomerFile` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | CustomerID |  |  |

### CustomerCredits

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/CustomerCredits_Index_vAccounts` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  | root |
| `/api/CustomerCredits_Index_vAllocation` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | SaleCreditID |  | root |
| `/api/CustomerCredits_Index_vList` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | search usedCredits |  | root |

### CustomerList

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/CustomerList/Print` | mvc | POST | 🟢 read (logs) | IDList TemplateID dateFrom dateTo |  |  |
| `/api/CustomerList_Index_DeleteDeprecated` | api | POST | 🔴 write |  |  |  |
| `/api/CustomerList_Index_vCustomerList` | api |  | 🟢 read |  |  |  |
| `/api/CustomerList_Merge` | api | POST | 🔴 write |  |  |  |
| `/api/CustomerList_SalesStatements` | api | POST | 🔴 write | Action CaptchaToken ID TemplateID fromDate toDate |  |  |

### CustomerPayment

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/CustomerPayment_Index_Cin7Pay` | api | GET POST | 🟠 read + write |  |  |  |
| `/api/CustomerPayment_Index_Customer` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/CustomerPayment_Index_vChartOfAccounts` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/CustomerPayment_Index_vPaymentsDue` | api | POST REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |

### DefaultFieldValues

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/DefaultFieldValues` | api | GET POST | 🟠 read + write | entityType |  |  |

### DiscountNew

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/DiscountNew_Index_vDiscountNew` | api | POST PUT REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | id | ID |  |

### FBA

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/FBA_Index_FulfillmentBoxOptions` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/FBA_Index_LogisticsProviderOptions` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/FBA_Index_McfChannelMapping` | api | GET REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID ConfigIds |  |  |
| `/api/FBA_Index_vFulfillmentOutboundShipmentEstimate` | api | POST | 🟢 read |  | Address BoxNumber ConfigId Items |  |

### FFOrderList

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/FFOrderList_Index_vFulfillmentOrderList` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | search |  | root |

### FulfillmentOrder

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/FulfillmentOrder/UpdateOrder` | mvc | POST | 🔴 write | ConfigID OrderID |  |  |
| `/api/FulfillmentOrder_Index_vItemDisposition` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | id |  |  |
| `/api/FulfillmentOrder_Index_vItems` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | id |  |  |
| `/api/FulfillmentOrder_Index_vLog` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | id |  |  |
| `/api/FulfillmentOrder_Index_vOrder` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | id |  |  |
| `/api/FulfillmentOrder_Index_vShippingMethod` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | id |  |  |
| `/api/FulfillmentOrder_Index_vStatus` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | id |  |  |
| `/api/FulfillmentOrder_Index_vTrackingInfo` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | id |  |  |

### GetRate

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/GetRate` | api | GET | 🟢 read | From |  |  |

### MakeToOrder

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/MakeToOrder/DownloadMakeToOrderImage` | mvc | GET | 🟢 read | id |  |  |
| `/MakeToOrder/GetMakeToOrderArtImage` | mvc |  | 🟢 read | ArtID |  |  |
| `/MakeToOrder/UploadArtImage` | mvc | POST | 🔴 write |  |  |  |
| `/api/MakeToOrder_CheckProductConfigurations` | api | POST | 🟢 read |  |  |  |
| `/api/MakeToOrder_MakeToOrderConfiguration` | api | GET | 🟢 read | ProductID |  |  |

### MySubscription

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/MySubscription/DetailsUpdate` | mvc | GET | 🔴 write |  |  |  |

### PickRecommendation

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/PickRecommendation` | api | POST | 🟢 read | allowAllLocations locationID taskID |  |  |

### Preset

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/Preset` | api | DELETE GET POST | 🟠 read + write | lang presetFor presetID search | Name OrderCostID |  |

### Product

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/Product_GetAutogenerationFlag` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |

### Purchase

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/Purchase/Download` | mvc | GET POST | 🟢 read | PrintEntityID PrintTemplateID |  |  |
| `/Purchase/PrintReceiveTo` | mvc | POST | 🟢 read (logs) | PrintTemplateID |  |  |
| `/api/Purchase_Index_CoManCheck` | api | GET | 🟢 read | taskID |  |  |
| `/api/Purchase_Index_CoManCheck/CanBeCompleted` | api | POST | 🟢 read | masterTaskID taskID |  |  |
| `/api/Purchase_Index_CoManCheck/HasProduction` | api | GET | 🟢 read | masterTaskID taskID |  |  |
| `/api/Purchase_Index_SaleOrder/Prefill` | api | GET | 🟢 read | currentUILang onlyBackorder saleID |  |  |
| `/api/Purchase_Index_SaleOrder/SupplierProducts` | api | POST | 🟢 read | supplierID |  |  |
| `/api/Purchase_Index_WorkflowHistory` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | entityID |  |  |
| `/api/Purchase_Index_vPurchase_SupplierSKU` | api | POST | 🟢 read | supplierID |  |  |
| `/api/Purchase_Index_vTenantLocation` | api | GET REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | assetsOnly locationID withBins |  |  |
| `/api/Purchase_Invoice_CheckForName` | api | POST | 🟢 read | InvoiceNumbers SupplierID |  |  |
| `/api/Purchase_RelatedTasks` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | taskId |  | root |

### Quickbooks

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/Quickbooks/ConsolidatedTransactionDetails` | mvc |  | 🟢 read |  |  |  |
| `/api/Quickbooks_HasConsolidatedTranscations` | api | GET | 🟢 read |  |  |  |
| `/api/Quickbooks_Index_ConsolidatedTranscations` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  | root |

### QuoteNOrderApprove

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/QuoteNOrderApprove/Approve` | mvc | POST | 🔴 write | newState taskID taskType |  |  |

### QuoteNOrderArchive

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/QuoteNOrderArchive/Archive` | mvc | POST | 🔴 write | taskID |  |  |
| `/QuoteNOrderArchive/ArchivePurchase` | mvc | POST | 🔴 write | taskID |  |  |

### RecurringInvoices

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/RecurringInvoices_Index_Invoices` | api | POST REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |

### RMA

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/RMA/DeleteAttachment` | mvc | POST | 🔴 write |  |  |  |
| `/RMA/DownloadFile` | mvc |  | 🟢 read | id |  |  |
| `/RMA/Email` | mvc | POST | 🔴 write |  |  |  |
| `/RMA/Print` | mvc | POST(form) | 🟢 read (logs) |  |  |  |
| `/RMA/UploadAttachment` | mvc | POST | 🔴 write |  |  |  |
| `/api/RMA_Index_AssetAccounts` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/RMA_Index_Attachments` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | TaskID |  |  |
| `/api/RMA_Index_Attachments/Download` | api |  | 🟢 read | ID |  |  |
| `/api/RMA_Index_Attachments/Upload` | api | POST | 🔴 write |  |  |  |
| `/api/RMA_Index_Authorise` | api | POST | 🔴 write |  |  |  |
| `/api/RMA_Index_Category` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/RMA_Index_Countries` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/RMA_Index_ExpenseAccounts` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/RMA_Index_LineInfo` | api | PUT REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | rmaProductID rmaTaskID |  |  |
| `/api/RMA_Index_Product` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | CostingMethod TaskLocationID customerID lang |  |  |
| `/api/RMA_Index_RMACreationForm` | api | POST REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | search |  |  |
| `/api/RMA_Index_Reject` | api | POST | 🔴 write |  |  |  |
| `/api/RMA_Index_ReturnOrderAttachments` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/RMA_Index_ReturnOrderAttachments/Download` | api |  | 🟢 read | ID |  |  |
| `/api/RMA_Index_ReturnOrderAttachments/Upload` | api | POST | 🔴 write |  |  |  |
| `/api/RMA_Index_SearchSaleOrderInvoiceNumbers` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  | root |
| `/api/RMA_Index_Supplier` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/RMA_Index_SupplierAddress` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | SupplierID |  |  |
| `/api/RMA_Index_Undo` | api | POST | 🔴 write |  |  |  |
| `/api/RMA_Index_UndoReject` | api | POST | 🔴 write |  |  |  |
| `/api/RMA_Index_ValidateSettings` | api | POST | 🟢 read |  |  |  |
| `/api/RMA_Index_vBin` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | locationID |  |  |
| `/api/RMA_Index_vCustomer` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | CountrySpecificKey lang |  |  |
| `/api/RMA_Index_vCustomerAddress` | api | POST REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | CustomerID |  |  |
| `/api/RMA_Index_vCustomerContact` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | CustomerID |  |  |
| `/api/RMA_Index_vLocation` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/RMA_Index_vLocationsWithBins` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/RMA_Index_vRMA` | api | PUT REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ID |  |  |
| `/api/RMA_Index_vRMAList` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | filter search |  | root |
| `/api/RMA_Index_vRMAProductsList` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | filter search |  | root |
| `/api/RMA_Index_vRMAReasonForReturn` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | search |  | root |
| `/api/RMA_Index_vRMAReturnOrderList` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | filter search |  | root |
| `/api/RMA_Index_vRMAReturnPolicy` | api | DELETE GET POST PUT REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | id | ID |  |
| `/api/RMA_Index_vSupplier` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/RMA_Index_vTemplates` | api | GET | 🟢 read |  |  |  |
| `/api/RMA_Index_vTenantAttributeSet` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/RMA_Index_vTenantPurchaseTaxationRule` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/RMA_Index_vTenantSaleTaxationRule` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/RMA_Index_vTenantUnitOfMeasure` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/RMA_RO_Authorise` | api | POST | 🔴 write |  |  |  |
| `/api/RMA_RO_LineInfo` | api | GET PUT | 🟠 read + write | RmaReturnOrderTaskID rmaProductID rmaTaskID |  |  |
| `/api/RMA_RO_RestockTransfer` | api | GET | 🟢 read | fromLocation toLocation |  |  |
| `/api/RMA_RO_vRMAReturnOrder` | api | PATCH PUT REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ID |  |  |

### RMAReturnOrder

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/RMAReturnOrder/DownloadFile` | mvc |  | 🟢 read | id |  |  |
| `/RMAReturnOrder/Email` | mvc | POST | 🔴 write |  |  |  |
| `/RMAReturnOrder/Print` | mvc | POST(form) | 🟢 read (logs) |  |  |  |

### Sale

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/Sale/Cancel` | mvc | POST | 🔴 write | RemoveAllocations TaskID |  |  |
| `/Sale/CancelCreditNote` | mvc | POST | 🔴 write | RemoveAllocations TaskID |  |  |
| `/Sale/CloneValidate` | mvc | POST | 🔴 write | IDToClone |  |  |
| `/Sale/CountrySpecific` | mvc |  | 🟢 read | Key |  |  |
| `/Sale/CrNoteDepositValidate` | mvc | POST | 🟢 read | TaskID |  |  |
| `/Sale/DepositValidate` | mvc | POST | 🟢 read | TaskID |  |  |
| `/Sale/Download` | mvc | GET | 🟢 read | PrintEntityID PrintTemplateID |  |  |
| `/Sale/GetDepositAllocatedPayments` | mvc | POST | 🟢 read | SourceLineID TaskID |  |  |
| `/Sale/LoadUsers` | mvc | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  | Data |
| `/Sale/NewFromUnshipped` | mvc | POST | 🟢 read | TaskID |  |  |
| `/Sale/Print` | mvc | GET | 🟢 read (logs) | PrintEntityID PrintTemplateID |  |  |
| `/Sale/ResendToShipStation` | mvc | PUT | 🔴 write | TaskID |  |  |
| `/Sale/Undo` | mvc | POST | 🔴 write | RemoveAllocations TaskID |  |  |
| `/Sale/UndoJournals` | mvc | POST | 🔴 write | TaskID |  |  |
| `/Sale/UndoRestock` | mvc | POST | 🔴 write | TaskID |  |  |
| `/Sale/Upload` | mvc | POST | 🔴 write |  |  |  |
| `/Sale/UploadOrderTemplate` | mvc | POST | 🔴 write |  |  |  |
| `/Sale/UploadQuoteTemplate` | mvc | POST | 🔴 write |  |  |  |
| `/api/Sale_Index_AttributeColumnName` | api | GET(navigate) REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Sale_Index_AutoPick` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Sale_Index_Category` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Sale_Index_Coupon` | api | GET POST PUT | 🟠 read + write | taskID |  |  |
| `/api/Sale_Index_CurrentCredit` | api | GET | 🟢 read | CustomerID |  |  |
| `/api/Sale_Index_ExchangeLinks` | api | GET | 🟢 read | taskId |  |  |
| `/api/Sale_Index_ExchangeParent` | api | GET | 🟢 read | taskId |  |  |
| `/api/Sale_Index_Family` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Sale_Index_FamilyProductsAvailability` | api |  | 🟢 read |  |  |  |
| `/api/Sale_Index_GenerateLabel` | api | GET | 🔴 write | ShippingServiceID TaskID |  |  |
| `/api/Sale_Index_GetPackageDetails` | api | DELETE GET POST | 🟠 read + write | ShippingServiceID TaskID | Box Data ShippingServiceID TaskID |  |
| `/api/Sale_Index_GetPackageValues` | api | POST | 🟢 read |  | PackageNumbers ShippingServiceID TaskID |  |
| `/api/Sale_Index_GetShippingInstructions` | api | DELETE GET POST | 🟠 read + write | ShippingServiceID TaskID | Data ShippingServiceID TaskID |  |
| `/api/Sale_Index_GetShippingLabel` | api | GET POST PUT | 🟠 read + write | ShippingServiceID TaskID box | Box ConfigID TaskID TrackNum |  |
| `/api/Sale_Index_GetShippingRate` | api | GET | 🟢 read | ShippingServiceID TaskID carrierCode mode packageType |  |  |
| `/api/Sale_Index_GiftCard` | api | GET POST | 🟢 read |  |  |  |
| `/api/Sale_Index_History` | api |  | 🟢 read |  |  |  |
| `/api/Sale_Index_Job` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | id |  |  |
| `/api/Sale_Index_LookupCarrier` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ShippingServiceID carrierCode jsonData serviceCode shippingServiceID |  |  |
| `/api/Sale_Index_MarginExchangeRates` | api | GET | 🟢 read |  |  |  |
| `/api/Sale_Index_Pick` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ProductID TaskID TaskLocation lang |  |  |
| `/api/Sale_Index_PriceRequest` | api | POST | 🔴 write |  |  |  |
| `/api/Sale_Index_Product` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | TaskLocationID currencyRate customerID lang |  |  |
| `/api/Sale_Index_RouteOrder` | api | GET | 🟢 read | City Country State ZipCode |  |  |
| `/api/Sale_Index_Service` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Sale_Index_Transactions` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | id |  |  |
| `/api/Sale_Index_WorkflowHistory` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | automatedWorkflowID entityID entityType |  |  |
| `/api/Sale_Index_XeroLink` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | TaskID |  |  |
| `/api/Sale_Index_vChartOfAccountsExpense` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Sale_Index_vCustomer` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/Sale_Index_vCustomer/HasDefaultContact` | api | GET | 🟢 read | customerId |  |  |
| `/api/Sale_Index_vCustomerAddress` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/Sale_Index_vCustomerContact` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/Sale_Index_vCustomerParent` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  | root |
| `/api/Sale_Index_vFulfillmentOrder` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | id |  |  |
| `/api/Sale_Index_vSaleCredits` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | TaskID |  |  |
| `/api/Sale_Index_vSaleCredits/Notes` | api | POST REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Sale_Index_vSaleOrderAttachement` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | TaskID |  |  |
| `/api/Sale_Index_vSaleTask` | api | POST PUT REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | CountrySpecificKey id lang | AvalaraTaxExemptionCode DiscountsDescription HasErrors Original SuppressTransactions Updated |  |
| `/api/Sale_Index_vSale_Customer` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | CountrySpecificKey Name lang |  |  |
| `/api/Sale_Index_vSale_CustomerAddress` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | CustomerID |  |  |
| `/api/Sale_Index_vSale_CustomerContact` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | CustomerID |  |  |
| `/api/Sale_Index_vSale_CustomerDefaultTemplate` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | CustomerID |  |  |
| `/api/Sale_Index_vShippingLabelAttachment` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | TaskID |  |  |
| `/api/Sale_Index_vShippingManifestAttachment` | api |  | 🟢 read |  |  |  |
| `/api/Sale_Index_vSupplier` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Sale_Index_vTenantCarrier` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/Sale_Index_vTenantContact` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/Sale_Invoice_CheckForDeposits` | api | GET | 🟢 read | CustomerID |  |  |
| `/api/Sale_Scan` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | LocationID PriceTier ScanSource TaskID customerID lang search |  |  |
| `/api/Sale_Scan_InventoryMode` | api | POST | 🟢 read | LocationID PriceTier ScanSource TaskID lang search |  |  |

### SaleCommon

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/SaleCommon_GetAvailableLocations` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | withBins |  |  |
| `/api/SaleCommon_RelatedTasks` | api | GET REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | taskId |  | root |
| `/api/SaleCommon_TaxRules/purchase` | api | GET | 🟢 read |  |  |  |
| `/api/SaleCommon_TaxRules/sale` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/SaleCommon_TaxRules/saleAll` | api | GET | 🟢 read |  |  |  |

### SaleList

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/SaleList/Print` | mvc | POST | 🟢 read (logs) | IDList TemplateID |  |  |
| `/SaleList/PrintCombined` | mvc | POST | 🟢 read (logs) | IDList SortBy TemplateID |  |  |
| `/SaleList/ScheduleForPicking` | mvc | POST | 🔴 write | IDList |  |  |
| `/SaleList/SetSalePicker` | mvc | POST | 🔴 write | IDList SalePicker |  |  |
| `/SaleList/UnscheduleForPicking` | mvc | POST | 🔴 write | IDList |  |  |
| `/api/SaleList_Index_AccessPermissions` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/SaleList_Index_ReportTemplates` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/SaleList_Index_UndoVoidAccess` | api | GET | 🟢 read |  |  |  |

### SaleListBulkAction

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/SaleListBulkAction` | api | POST | 🔴 write | Action CaptchaToken ID TemplateID lang |  |  |

### SaleMult

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/SaleMult_Index_AutoPickAvailable` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | Invoices TaskID TaskLocation ffTaskId lang |  |  |
| `/api/SaleMult_Index_AutoPickFromInvoice` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/SaleMult_Index_Category` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/SaleMult_Index_CurrentCredit` | api | GET | 🟢 read | CustomerID |  |  |
| `/api/SaleMult_Index_Family` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/SaleMult_Index_FamilyProductsAvailability` | api |  | 🟢 read |  |  |  |
| `/api/SaleMult_Index_GetShippingLabel` | api | GET PUT | 🟠 read + write | ShippingServiceID TaskID box | TaskID TrackNum |  |
| `/api/SaleMult_Index_GetShippingRate` | api | GET | 🟢 read | ShippingServiceID TaskID carrierCode mode packageType |  |  |
| `/api/SaleMult_Index_History` | api |  | 🟢 read |  |  |  |
| `/api/SaleMult_Index_InvoiceNewItem` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | id |  |  |
| `/api/SaleMult_Index_Job` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | id |  |  |
| `/api/SaleMult_Index_LookupCarrier` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | carrierCode jsonData serviceCode shippingServiceID |  |  |
| `/api/SaleMult_Index_Pick` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ProductID TaskID TaskLocation lang |  |  |
| `/api/SaleMult_Index_PriceRequest` | api | POST | 🔴 write |  | IsMakeToOrder |  |
| `/api/SaleMult_Index_Product` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | IncludeNotAvailable TaskLocationID currencyRate customerID lang |  |  |
| `/api/SaleMult_Index_Service` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/SaleMult_Index_Transactions` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | id |  |  |
| `/api/SaleMult_Index_WorkflowHistory` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | automatedWorkflowID entityID entityType |  |  |
| `/api/SaleMult_Index_XeroLink` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/SaleMult_Index_vChartOfAccountsExpense` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/SaleMult_Index_vCustomer` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/SaleMult_Index_vCustomerAddress` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/SaleMult_Index_vCustomerContact` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/SaleMult_Index_vCustomerParent` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  | root |
| `/api/SaleMult_Index_vFulfillmentOrder` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | id |  |  |
| `/api/SaleMult_Index_vSaleCredits` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | TaskID |  |  |
| `/api/SaleMult_Index_vSaleMult_Customer` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | CountrySpecificKey Name lang |  |  |
| `/api/SaleMult_Index_vSaleMult_CustomerAddress` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | CustomerID |  |  |
| `/api/SaleMult_Index_vSaleMult_CustomerContact` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | CustomerID |  |  |
| `/api/SaleMult_Index_vSaleOrderAttachement` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | TaskID |  |  |
| `/api/SaleMult_Index_vSaleTask` | api | POST PUT REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | CountrySpecificKey id lang | AvalaraTaxExemptionCode DiscountsDescription HasErrors ID Original SuppressTransactions Updated |  |
| `/api/SaleMult_Index_vShippingLabelAttachment` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/SaleMult_Index_vShippingManifestAttachment` | api |  | 🟢 read |  |  |  |
| `/api/SaleMult_Index_vSupplier` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/SaleMult_Index_vTenantCarrier` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/SaleMult_Index_vTenantContact` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/SaleMult_Scan` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | LocationID PriceTier ScanSource TaskID customerID lang search |  |  |
| `/api/SaleMult_Scan_InventoryMode` | api | POST | 🟢 read | LocationID PriceTier ScanSource TaskID lang search |  |  |

### SaleMultiple

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/SaleMultiple/Cancel` | mvc | POST | 🔴 write | RemoveAllocations TaskID |  |  |
| `/SaleMultiple/CancelChild` | mvc | POST | 🔴 write | TaskID TaskTypeSign |  |  |
| `/SaleMultiple/CloneValidate` | mvc | POST | 🔴 write | IDToClone |  |  |
| `/SaleMultiple/CountrySpecific` | mvc |  | 🟢 read | Key |  |  |
| `/SaleMultiple/DepositValidate` | mvc | POST | 🟢 read | TaskID |  |  |
| `/SaleMultiple/GetDepositAllocatedPayments` | mvc | POST | 🟢 read | SourceLineID TaskID |  |  |
| `/SaleMultiple/ResendToShipStation` | mvc | PUT | 🔴 write | TaskID |  |  |
| `/SaleMultiple/Undo` | mvc | POST | 🔴 write | RemoveAllocations TaskID |  |  |
| `/SaleMultiple/UndoChild` | mvc | POST | 🔴 write | TaskID TaskTypeSign |  |  |
| `/SaleMultiple/UndoJournals` | mvc | POST | 🔴 write | TaskID |  |  |
| `/SaleMultiple/UndoRestock` | mvc | POST | 🔴 write | TaskID TaskTypeSign |  |  |

### SaleService

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/SaleService/Cancel` | mvc | POST | 🔴 write | TaskID |  |  |
| `/SaleService/CancelCreditNote` | mvc | POST | 🔴 write | TaskID |  |  |
| `/SaleService/CloneValidate` | mvc | POST | 🔴 write | IDToClone |  |  |
| `/SaleService/CountrySpecific` | mvc |  | 🟢 read | Key |  |  |
| `/SaleService/Download` | mvc | GET | 🟢 read | PrintEntityID PrintTemplateID |  |  |
| `/SaleService/Print` | mvc | GET | 🟢 read (logs) | PrintEntityID PrintTemplateID |  |  |
| `/SaleService/Undo` | mvc | POST | 🔴 write | TaskID |  |  |
| `/SaleService/UndoJournals` | mvc | POST | 🔴 write | TaskID |  |  |
| `/api/SaleService_Index_GetBuyCollectionDiscountProduct` | api | POST | 🟢 read |  |  |  |
| `/api/SaleService_Index_GetOrderTotalDiscountProduct` | api | POST | 🟢 read |  |  |  |
| `/api/SaleService_Index_vSaleTask` | api | POST PUT REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | CountrySpecificKey id lang | AvalaraTaxExemptionCode DiscountsDescription HasErrors ID Original Updated |  |

### SaleStatements

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/SaleStatements_Index_ReportTemplates` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |

### TaskShared

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/TaskShared_TaskList_vTask` | api |  | 🟢 read |  |  |  |
| `/api/TaskShared_Workflow_WorkflowProcess` | api | DELETE | 🔴 write | id |  |  |
| `/api/TaskShared_Workflow_vWorkflow` | api |  | 🟢 read |  |  |  |

### TenantAccessToFeatures

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/TenantAccessToFeatures` | api | GET POST | 🟠 read + write |  |  |  |

### TenantAttributeSet

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/TenantAttributeSet_Index_vTenantAttributeSet` | api | DELETE REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | id |  |  |
| `/api/TenantAttributeSet_Index_vTenantAttributeSet/GetCopyFrom` | api | GET | 🟢 read | entityID entityType fromID id |  |  |

### TenantGeneralSettings

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/TenantGeneralSettings_Index_vMultilingualSupport` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | newItem |  |  |
| `/api/TenantGeneralSettings_Index_vMultilingualSupportAccess` | api |  | 🟢 read |  |  |  |
| `/api/TenantGeneralSettings_Index_vTenant/short` | api | GET | 🟢 read |  |  |  |

### TenantPaymentTerm

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/TenantPaymentTerm_Index_vTenantPaymentTerm` | api | DELETE REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | id |  |  |

### vAutomatedWorkflow

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/vAutomatedWorkflow_Edit_vCustomer` | api |  | 🟢 read |  |  |  |
| `/api/vAutomatedWorkflow_Edit_vProduct` | api |  | 🟢 read |  |  |  |
| `/api/vAutomatedWorkflow_Edit_vSaleChannels` | api |  | 🟢 read |  |  |  |
| `/api/vAutomatedWorkflow_Edit_vSupplier` | api |  | 🟢 read |  |  |  |
| `/api/vAutomatedWorkflow_Edit_vTag` | api |  | 🟢 read |  |  |  |

### vSaleListAccounting

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/vSaleListAccounting` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  | root |

### vSaleListFulfilment

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/vSaleListFulfilment` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  | root |

### vSaleListGeneral

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/vSaleListGeneral` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  | root |

### Warranties

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/Warranties_Index_vSaleWarranty` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | filter search |  | root |

## Public API (`/ExternalApi/v2`)

| Group | Method | Path | Query / params |
|---|---|---|---|
| Customer | GET | `/customer` | Page,Limit,ID,Name,ModifiedSince,IncludeDeprecated,IncludeProductPrices,ContactFilter |
| Customer | POST | `/customer` |  |
| Customer | PUT | `/customer` |  |
| Customer | GET | `/ref/customer/credits` | Page,Limit,CustomerID,ShowUsedCredits |
| Customer | DELETE | `/ref/customer/templates` | TemplateId,CustomerId |
| Customer | GET | `/ref/customer/templates` | Page,Limit,CustomerId |
| Customer | POST | `/ref/customer/templates` |  |
| Sale | DELETE | `/sale` | ID,Void |
| Sale | GET | `/sale` | ID,CombineAdditionalCharges,HideInventoryMovements,IncludeTransactions,CountryFormat |
| Sale | POST | `/sale` |  |
| Sale | PUT | `/sale` |  |
| Sale | DELETE | `/sale/attachment` | ID |
| Sale | GET | `/sale/attachment` | SaleID |
| Sale | POST | `/sale/attachment` |  |
| Sale | DELETE | `/sale/creditnote` | TaskID,Void |
| Sale | GET | `/sale/creditnote` | SaleID,CombineAdditionalCharges,IncludeProductInfo,IncludePaymentInfo |
| Sale | POST | `/sale/creditnote` |  |
| Sale | DELETE | `/sale/fulfilment` | TaskID,Void |
| Sale | GET | `/sale/fulfilment` | SaleID,IncludeProductInfo |
| Sale | POST | `/sale/fulfilment` |  |
| Sale | GET | `/sale/fulfilment/pack` | TaskID,IncludeProductInfo |
| Sale | POST | `/sale/fulfilment/pack` |  |
| Sale | PUT | `/sale/fulfilment/pack` |  |
| Sale | GET | `/sale/fulfilment/pick` | TaskID,IncludeProductInfo |
| Sale | POST | `/sale/fulfilment/pick` |  |
| Sale | PUT | `/sale/fulfilment/pick` |  |
| Sale | GET | `/sale/fulfilment/ship` | TaskID |
| Sale | POST | `/sale/fulfilment/ship` |  |
| Sale | PUT | `/sale/fulfilment/ship` |  |
| Sale | DELETE | `/sale/invoice` | TaskID,Void |
| Sale | GET | `/sale/invoice` | SaleID,CombineAdditionalCharges,IncludeProductInfo |
| Sale | POST | `/sale/invoice` |  |
| Sale | PUT | `/sale/invoice` |  |
| Sale | GET | `/sale/manualJournal` | SaleID |
| Sale | POST | `/sale/manualJournal` |  |
| Sale | GET | `/sale/order` | SaleID,CombineAdditionalCharges,IncludeProductInfo |
| Sale | POST | `/sale/order` |  |
| Sale | DELETE | `/sale/payment` | ID |
| Sale | GET | `/sale/payment` | SaleID |
| Sale | POST | `/sale/payment` |  |
| Sale | PUT | `/sale/payment` |  |
| Sale | GET | `/sale/quote` | SaleID,CombineAdditionalCharges,IncludeProductInfo |
| Sale | POST | `/sale/quote` |  |
| Sale | GET | `/saleCreditNoteList` | Page,Limit,Search,CreatedSince,UpdatedSince,CreditNoteStatus,Status |
| Sale | GET | `/saleList` | Page,Limit,Search,CreatedSince,UpdatedSince,ShipBy,QuoteStatus,OrderStatus,CombinedPickStatus,CombinedPackStatus,CombinedShippingStatus,CombinedInvoiceStatus,C… |
