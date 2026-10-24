-- Sale: one table per Cin7 Core data model, generated from data/models.json

create table "AccessPermission" (
  "Name" text,
  "Title" text
);

create table "AccountCurrency" (
  "Code" text,
  "Currency" text
);

create table "AdditionalCharge" (
  "ID" text,
  "GroupedAdditionalChargeID" text,
  "IsIncludedToAdditionalCharge" boolean,
  "JobMilestoneID" text,
  "Amount" numeric,
  "Comment" text,
  "Description" text,
  "Discount" numeric,
  "LineOrder" numeric,
  "Price" numeric,
  "Quantity" numeric,
  "RmaProductID" text,
  "TaskID" text,
  "Tax" numeric,
  "TaxPercent" numeric,
  "TaxRule" text,
  "Total" numeric,
  "ValidationText" text,
  "ValidationState" text
);

create table "AddressCategory" (
  "Value" text,
  "Name" text
);

create table "AvailablePortals" (
  "ID" text,
  "Name" text
);

create table "AvalaraSaleTaxCode" (
  "Code" text,
  "Name" text
);

create table "AwaitingApprovalSale" (
  "ID" text,
  "SourcePurchaseID" text,
  "CustomerID" text,
  "CustomerName" text,
  "Contact" text,
  "Phone" text,
  "Email" text,
  "DefaultAccount" text,
  "BillingAddressLine1" text,
  "BillingAddressLine2" text,
  "Currency" text,
  "TaxPercent" numeric,
  "TaxInclusive" boolean,
  "TaxSchema" text,
  "Discount" numeric,
  "TermDays" integer,
  "TermMethod" integer,
  "Terms" text,
  "PriceTier" integer,
  "ShippingAddressLine1" text,
  "ShippingAddressLine2" text,
  "ShipmentRequiredByDate" timestamptz,
  "OrderLocationID" text,
  "SaleOrderLocation" text,
  "SaleOrderDate" timestamptz,
  "SaleTaskMemoInternal" text,
  "SaleOrderMemo" text,
  "CustomerReference" text,
  "Status" text,
  "SalesRepresentative" text,
  "CurrencyConversionRate" numeric,
  "CustomerCurrency" text,
  "Carrier" text,
  "IsRecursive" boolean,
  "Frequency" text,
  "NextInvoiceDate" timestamptz,
  "TermDueNextMonth" integer,
  "ShipAddressID" text,
  "CreditLimit" numeric,
  "ValidationText" text,
  "ValidationState" text,
  "ShipToOther" boolean,
  "ShipToCompany" text,
  "ShipToContact" text,
  "ShipToCountry" text,
  "ShipToPostCode" text,
  "ShipToState" text,
  "ShipToCity" text,
  "ShipToAddress1" text,
  "ShipToAddress2" text,
  "CarrierCode" text,
  "CarrierServiceCode" text,
  "DeliveryInstruction" text,
  "CarrierServiceDisplayName" text,
  "CreatedTaskID" text,
  "SaleOrderStatus" text,
  "TargetTaskID" text,
  "TaskType" integer,
  "InvoiceStatus" text,
  "InvoiceDate" timestamptz,
  "InvoiceDueDate" timestamptz,
  "InvoiceNumber" text,
  "InvoiceTotalAmount" numeric,
  "TargetSaleOrderNumber" text,
  "ShippingNotes" text
);

create table "ChooseProducts" (
  "ID" text,
  "BatchSerialNo" text,
  "Country" text,
  "CustomerComments" text,
  "CustomerID" text,
  "CustomerName" text,
  "ExpiryDate" timestamptz,
  "FulfilmentLink" text,
  "FulfilmentTaskID" text,
  "MaxQuantityToReturn" numeric,
  "SaleQuantity" numeric,
  "PackingCondition" text,
  "Price" numeric,
  "ProductCode" text,
  "ProductID" text,
  "ProductName" text,
  "ProductType" text,
  "QuantityToReturn" numeric,
  "RMAReturnPolicyID" text,
  "RMAReturnPolicyName" text,
  "ReasonForReturnID" text,
  "ReturnType" text,
  "SaleTaskID" text,
  "Tax" numeric,
  "Total" numeric,
  "TotalCost" numeric,
  "TotalQuantity" numeric,
  "WarrantyExpiryDate" text,
  "WarrantyNumber" text,
  "AttachmentPresentation" boolean,
  "ReturnExpirationDate" timestamptz,
  "RefundExpirationDate" timestamptz,
  "ReplacementExpirationDate" timestamptz,
  "IsReturnPossible" boolean,
  "IsRefundPossible" boolean,
  "IsReplacementPossible" boolean,
  "IsInvoiced" boolean,
  "DropShipReplacementID" text,
  "InvoiceNumbers" text,
  "IsPaid" boolean,
  "IsCrossShipPossible" boolean,
  "ValidationText" text,
  "ValidationState" text
);

create table "CreditNoteLineSelect" (
  "FakeKey" integer,
  "ProductID" text,
  "Quantity" numeric,
  "RemainingQuantity" numeric,
  "Price" numeric,
  "Discount" numeric,
  "Name" text,
  "AccountCode" text,
  "SupplierInventoryCode" text,
  "UnitOfMeasure" text,
  "ProductCode" text,
  "CostingMethod" text,
  "TaxRule" text,
  "TaxPercent" numeric
);

create table "CustomFilterCondition" (
  "CustomFilterID" text,
  "CustomFilterConditionID" text,
  "DisplayName" text,
  "ParameterName" text,
  "Condition" text,
  "ParameterFakeValue" jsonb,
  "ParameterValue" text,
  "ParameterValueDisplayNameJson" text,
  "JoinCondition" text,
  "ConditionNumber" integer,
  "ParameterType" text,
  "ValueType" text,
  "AttributeSetId" text
);

create table "CustomPriceLine" (
  "ProductID" text,
  "ProductName" text,
  "ProductCode" text,
  "CustomPrice" numeric,
  "ImageID" text,
  "LatestPrice" numeric,
  "LatestDate" timestamptz,
  "ValidationState" text,
  "ValidationText" text
);

create table "Customer" (
  "CustomerID" text,
  "Name" text,
  "Currency" text,
  "PaymentTerm" text,
  "TaxRule" text,
  "Comments" text,
  "DefaultSalesRepresentative" text,
  "AccountCode" text,
  "DefaultLocation" text,
  "Discount" numeric,
  "DefaultCarrier" text,
  "SalePriceTier" integer,
  "CreditLimit" numeric,
  "IsVATRegistered" boolean,
  "PlaceOfSupply" text
);

create table "CustomerAddress" (
  "CustomerID" text,
  "AddressID" text,
  "Line1" text,
  "Line2" text,
  "Type" text,
  "DefaultForType" boolean,
  "AddressLine1" text,
  "AddressLine2" text,
  "AddressCitySuburb" text,
  "CitySuburb" text,
  "AddressStateProvince" text,
  "StateProvince" text,
  "AddressCountry" text,
  "Country" text,
  "AddressZipPostCode" text,
  "ZipPostCode" text,
  "TaxExemptionReasonCode" text
);

create table "CustomerContact" (
  "CustomerID" text,
  "ContactID" text,
  "Name" text,
  "IsDefault" boolean,
  "Phone" text,
  "Email" text
);

create table "CustomerDefaultTemplate" (
  "DefaultTemplateID" text,
  "TemplateID" text,
  "Type" text
);

create table "CustomerPaymentWrapper" (
  "DimensionsPermission" text,
  "IsAccountingDimensionsEnabled" boolean
);

create table "CustomerStatus" (
  "Value" text,
  "Name" text
);

create table "CustomerWrapper" (
  "ID" integer,
  "HasErrors" boolean,
  "HasAvalaraIntegration" boolean
);

create table "DiscountWrapper" (
  "ID" integer,
  "HasErrors" boolean
);

create table "FamilyMatrix_Option" (
  "name" text,
  "index" integer,
  "values" text
);

create table "FamilyMatrix_ProductAvailability" (
  "ProductID" text,
  "ProductCode" text,
  "Name" text,
  "UnitOfMeasure" text,
  "PriceTear1" numeric,
  "PriceTear2" numeric,
  "PriceTear3" numeric,
  "PriceTear4" numeric,
  "PriceTear5" numeric,
  "PriceTear6" numeric,
  "PriceTear7" numeric,
  "PriceTear8" numeric,
  "PriceTear9" numeric,
  "PriceTear10" numeric,
  "Available" numeric,
  "OnHand" numeric,
  "AverageCost" numeric,
  "CostingMethod" text,
  "RevenueAccount" text,
  "BatchSN" text,
  "ExpiryDate" timestamptz,
  "DropShipMode" text,
  "SaleTaxRule" text,
  "Account" text,
  "TaxRule" text,
  "TaxPercent" numeric,
  "ImageID" text,
  "Type" text,
  "Option1" text,
  "Option2" text,
  "Option3" text,
  "AddQuantity" numeric
);

create table "FamilyMatrix_Value" (
  "name" text
);

create table "FamilyOption" (
  "value" text
);

create table "FamilyProduct" (
  "ProductID" text,
  "ProductCode" text,
  "Name" text,
  "UnitOfMeasure" text,
  "Price" numeric,
  "CostingMethod" text,
  "RevenueAccount" text,
  "DropShipMode" text,
  "TaxRule" text,
  "ImageID" text,
  "NonInventory" boolean
);

create table "FulfillmentBoxOptionModel" (
  "Name" text,
  "Description" text
);

create table "FulfillmentListItem" (
  "number" integer,
  "count" numeric
);

create table "GiftCardGlobalSettings" (
  "GiftCardProductID" text,
  "IsGiftCardEnabled" boolean,
  "DefaultGiftCardExpirationPeriod" text,
  "CanGiftCardExpire" boolean,
  "GiftCardSaleTaxID" text,
  "GiftProductName" text,
  "GiftProductCode" text,
  "GiftCardRevenueAccount" text,
  "GiftCardRevenueAccountName" text,
  "CanGiftCardRefund" boolean
);

create table "GroupedAdditionalCharge" (
  "ID" text,
  "CostTypeID" text,
  "CostTypeName" text,
  "IsIncudedInInvoice" boolean,
  "OriginalIsIncudedInInvoice" boolean,
  "TaskID" text,
  "Total" numeric
);

create table "InvoiceForCreditNote" (
  "TaskID" text,
  "Invoice" text,
  "Date" timestamptz
);

create table "InvoiceForFulfillment" (
  "Invoice" text,
  "Date" timestamptz
);

create table "JobCosting" (
  "CustomerID" text,
  "CustomerName" text,
  "Comments" text,
  "Contact" text,
  "AddressLine1" text,
  "AddressLine2" text,
  "CustomerCurrency" text,
  "Phone" text,
  "PaymentTerm" text,
  "TaxRuleID" text,
  "DefaultSalesRepresentative" text,
  "Discount" numeric,
  "SalePriceTier" integer,
  "CreditLimit" numeric,
  "SaleAccount" text,
  "DefaultLocation" text
);

create table "JobTasks" (
  "ID" text,
  "AccountCode" text,
  "AddressLine1" text,
  "AddressLine2" text,
  "AttributeSet" text,
  "AutoInvoice" boolean,
  "BudgetedMargin" numeric,
  "Comments" text,
  "CompletedDate" timestamptz,
  "Contact" text,
  "CustomField1" text,
  "CustomField2" text,
  "CustomField3" text,
  "CustomField4" text,
  "CustomField5" text,
  "CustomField6" text,
  "CustomField7" text,
  "CustomField8" text,
  "CustomField9" text,
  "CustomField10" text,
  "CustomerCurrency" text,
  "CustomerID" text,
  "CustomerName" text,
  "EstimatedValue" numeric,
  "Frequency" numeric,
  "JobID" text,
  "JobNumber" text,
  "JobResolution" text,
  "Name" text,
  "NextInvoiceDate" timestamptz,
  "Phone" text,
  "ProjectManager" text,
  "StartDate" timestamptz,
  "Status" text,
  "TaxRuleID" text
);

create table "LineInfo" (
  "RMAStatus" text,
  "RmaProductID" text,
  "RmaTaskID" text,
  "ValidationState" text,
  "ValidationText" text
);

create table "LogisticsProviderOptionModel" (
  "Name" text,
  "Description" text
);

create table "LookupCarrierModel" (
  "FakeID" text,
  "CarrierCode" text,
  "ServiceCode" text,
  "Highlighted" boolean,
  "DisplayName" text
);

create table "McfChannelMapping" (
  "Id" text,
  "ChannelName" text,
  "ConfigID" text,
  "FulfillmentBoxSetting" text,
  "LogisticsProviderSetting" text
);

create table "MilestonesToJob" (
  "DateActual" timestamptz,
  "DateEstimated" timestamptz,
  "Description" text,
  "ID" text,
  "JobID" text,
  "LinksCount" numeric,
  "MilestoneResolution" text,
  "Name" text,
  "Status" text,
  "SysDate" timestamptz,
  "ValidationState" text,
  "ValidationText" text
);

create table "MilestonesToJob2" (
  "Amount" numeric,
  "Date" timestamptz,
  "MilestoneID" text,
  "MilestoneName" text,
  "Number" text,
  "TaskID" text,
  "TaskType" text
);

create table "NewvTenantContact" (
  "ContactID" text,
  "Name" text,
  "Phone" text,
  "Fax" text,
  "Email" text,
  "Website" text,
  "Type" text,
  "DefaultForType" boolean,
  "Comment" text
);

create table "PeriodModel" (
  "Period" text,
  "Name" text
);

create table "PickLocations" (
  "FakeKey" text,
  "ProductID" text,
  "ProductCode" text,
  "Name" text,
  "UnitOfMeasure" text,
  "LocationID" text,
  "Location" text,
  "CostingMethod" text,
  "BatchSN" text,
  "ExpiryDate" timestamptz,
  "Available" numeric,
  "ImageID" text,
  "IsFirst" boolean,
  "NonInventory" boolean
);

create table "PortalInvites" (
  "ID" text,
  "PortalName" text,
  "RecipientName" text,
  "RecipientEmail" text,
  "PortalId" text,
  "Status" text,
  "StatusDisplay" text,
  "InvitationID" text,
  "InvitationLink" text
);

create table "ProductToInvoice" (
  "FakeID" text,
  "ProductID" text,
  "ProductCode" text,
  "Name" text,
  "Quantity" numeric,
  "Price" numeric,
  "Discount" numeric,
  "AccountCode" text,
  "UnitOfMeasure" text,
  "TaxRule" text,
  "ImageID" text,
  "ConfigurationID" text,
  "NonInventory" boolean
);

create table "RMADropShipReplacement" (
  "ID" text,
  "ResolutionID" text,
  "BatchSerialNo" text,
  "Quantity" numeric,
  "ExpiryDate" timestamptz
);

create table "RMAPrinting" (
  "TemplateID" text,
  "EmailTemplateID" text,
  "Type" text,
  "Name" text
);

create table "RMAProductAttachments" (
  "ID" text,
  "RMAProductID" text,
  "FileName" text,
  "BlobID" text,
  "TaskID" text
);

create table "RMAResolution" (
  "RmaTaskID" text,
  "RmaProductID" text,
  "ID" text,
  "ResolutionType" text,
  "JobID" text,
  "JobMilestoneID" text,
  "RmaReturnOrderTaskID" text,
  "Resolution" text,
  "ReturnOrderResolution" text,
  "LocationID" text,
  "LocationName" text,
  "Quantity" numeric,
  "InTransitAccountName" text,
  "EffectiveDate" timestamptz,
  "StockTranferTaskID" text,
  "StockTranferNumber" text,
  "Comments" text,
  "BinID" text,
  "BinName" text,
  "BatchSerialNo" text,
  "ExpenseAccount" text,
  "ExpenseAccountName" text,
  "Cost" numeric,
  "AdditionalCharges" numeric,
  "Total" numeric,
  "Status" text,
  "RestockToProductID" text,
  "RestockToProductCode" text,
  "RestockToProductName" text
);

create table "RMAReturnOrdersRelatedOrders" (
  "Date" timestamptz,
  "ID" text,
  "InvoiceNumber" text,
  "Number" text,
  "RelatedTaskID" text,
  "RelatedTaskType" text,
  "RmaProductID" text,
  "RmaTaskID" text,
  "Status" text
);

create table "RMAReturnPolicy" (
  "ID" text,
  "Name" text,
  "CreatedDate" timestamptz,
  "UpdatedDate" timestamptz,
  "IsActive" boolean,
  "IsRefundPossible" boolean,
  "RefundPaymentOptions" text,
  "RefundDays" integer,
  "IsReplacementPossible" boolean,
  "IsPossibleCrossSale" boolean,
  "ReplacementDays" integer,
  "RestockingFeesPercent" integer,
  "RestockingFeesFixedAmount" integer,
  "InspectionsCost" text,
  "RepairCost" text,
  "IsReturnPossible" boolean,
  "ReturnDays" integer,
  "ShippingCost" text,
  "PolicyText" text
);

create table "ROProduct" (
  "Account" text,
  "BinID" text,
  "Code" text,
  "Cost" numeric,
  "CostingMethod" text,
  "Name" text,
  "NonInventory" boolean,
  "ProductID" text,
  "SupplierInventoryCode" text,
  "TaxRule" text,
  "Type" text,
  "Unit" text
);

create table "ReasonForReturn" (
  "ID" text,
  "Name" text
);

create table "RecurringFrequency" (
  "Value" text,
  "Name" text
);

create table "RecurringInvoice" (
  "TaskID" text,
  "IsServiceOnly" boolean,
  "InvoiceNumber" text,
  "Customer" text,
  "CustomerCurrency" text,
  "Total" numeric,
  "Frequency" text,
  "NextInvoiceDate" timestamptz,
  "IsSelected" boolean,
  "ValidationText" text,
  "ValidationState" text
);

create table "RelatedTask" (
  "Date" timestamptz,
  "ID" text,
  "InvoiceNumber" text,
  "Number" text,
  "RelatedTaskID" text,
  "RelatedTaskType" text,
  "RmaProductID" text,
  "RmaTaskID" text,
  "Status" text
);

create table "Resolution" (
  "RmaTaskID" text,
  "RmaProductID" text,
  "ID" text,
  "ResolutionType" text,
  "JobID" text,
  "JobMilestoneID" text,
  "RmaReturnOrderTaskID" text,
  "Resolution" text,
  "ReturnOrderResolution" text,
  "LocationID" text,
  "LocationName" text,
  "Quantity" numeric,
  "InTransitAccountName" text,
  "EffectiveDate" timestamptz,
  "StockTranferTaskID" text,
  "StockTranferNumber" text,
  "Comments" text,
  "BinID" text,
  "BinName" text,
  "BatchSerialNo" text,
  "ExpenseAccount" text,
  "ExpenseAccountName" text,
  "Cost" numeric,
  "AdditionalCharges" numeric,
  "Total" numeric,
  "Status" text,
  "RestockToProductID" text,
  "ReturnToCustomerHasBeenSent" boolean,
  "ReturnToCustomerSentDate" timestamptz
);

create table "ReturnOrders" (
  "ReturnOrderTaskID" text,
  "ReturnOrderNumber" text,
  "TaskID" text
);

create table "SSCarrier" (
  "ParentFakeID" text,
  "FakeID" text,
  "FFID" text,
  "Name" text,
  "Description" text
);

create table "SSPackageType" (
  "name" text,
  "value" text
);

create table "SSRecord" (
  "FakeID" text,
  "FFID" text,
  "Carrier" text,
  "ShippingService" text,
  "CarrierText" text,
  "ShippingServiceText" text,
  "ID" text
);

create table "SSService" (
  "ID" text,
  "FFID" text,
  "ParentFakeID" text,
  "Carrier" text,
  "Name" text,
  "CarrierPrice" numeric,
  "CarrierCurrency" text,
  "Margin" numeric,
  "Cost" numeric,
  "Currency" text,
  "Description" text
);

create table "SaleCustomFilterConditionConditionParameter" (
  "AutomatedWorkflowConditionParameterID" text,
  "DisplayName" text,
  "ParameterName" text,
  "EntityType" text,
  "AvailableConditions" text,
  "IsActive" boolean,
  "ValueType" text,
  "AvailableValues" text,
  "AttributeSetId" text,
  "GroupNumber" integer,
  "IsFirstGroupMember" boolean
);

create table "SaleOrderLineUploadError" (
  "ValidationState" text,
  "ValidationText" text,
  "Line" integer,
  "SKU" text,
  "SKUError" text,
  "Name" text,
  "NameError" text,
  "Comment" text,
  "CommentError" text,
  "Quantity" text,
  "QuantityError" text,
  "Price" text,
  "PriceError" text,
  "Discount" text,
  "DiscountError" text
);

create table "SalePickerModel" (
  "UserID" text,
  "Email" text
);

create table "SaleQuoteLineUploadError" (
  "ValidationState" text,
  "ValidationText" text,
  "Line" integer,
  "SKU" text,
  "SKUError" text,
  "Name" text,
  "NameError" text,
  "Comment" text,
  "CommentError" text,
  "Quantity" text,
  "QuantityError" text,
  "Price" text,
  "PriceError" text,
  "Discount" text,
  "DiscountError" text
);

create table "SaleReferenceData" (
  "ID" integer,
  "COGSAccount" text,
  "RevenueAccount" text,
  "DefaultTaxRule" text,
  "ProductFamilyCount" integer,
  "DiscountCount" integer,
  "CouponCount" integer,
  "SkipQuote" boolean,
  "SkipPack" boolean,
  "SkipShip" boolean,
  "ShowInvoiceBeforeFulfillment" boolean,
  "HasSaleDefaultAttributeSet" boolean,
  "AllowOrderNoAlloc" boolean,
  "ShipStation" boolean,
  "ExternallyFulfiledOrdersToShipStation" boolean,
  "ShipZonesEnabled" boolean,
  "DefaultShipDate" text,
  "QuoteViewPermission" text,
  "QuoteAuthorisationPermission" text,
  "OrderViewPermission" text,
  "OrderAuthorisationPermission" text,
  "PickViewPermission" text,
  "PickAuthorisationPermission" text,
  "PackViewPermission" text,
  "PackAuthorisationPermission" text,
  "ShipViewPermission" text,
  "ShipAuthorisationPermission" text,
  "InvoiceCreditNoteViewPermission" text,
  "InvoiceCreditNoteAuthorisationPermission" text,
  "MarginPermission" text,
  "PricesDiscountsPermission" text,
  "UndoVoidPermission" text,
  "TaxCalculationMethod" text,
  "DiscountCalculationMethod" text,
  "FillInvoiceDateOnOrderAuthorisation" text,
  "FillInvoiceDateOption" text,
  "HeadersVisible" boolean,
  "CurrentAttributeSetId" text,
  "CouponCode" text,
  "CouponDealName" text,
  "AppliedCouponNumber" integer,
  "ForceHideLookup" boolean,
  "CountrySpecificData" text,
  "OrderRoutingEnabled" boolean,
  "IsSaleTaxManagementServiceEnabled" boolean,
  "SaleTaxManagementRuleID" text,
  "SaleTaxManagementServiceName" text
);

create table "SaleTask" (
  "TaskID" text,
  "CustomerID" text,
  "CustomerName" text,
  "Contact" text,
  "Phone" text,
  "Email" text,
  "DefaultAccount" text,
  "SkipQuote" boolean,
  "BillingAddressLine1" text,
  "BillingAddressLine2" text,
  "Currency" text,
  "TaxPercent" numeric,
  "TaxInclusive" boolean,
  "TaxSchema" text,
  "Discount" numeric,
  "TermDays" integer,
  "TermMethod" integer,
  "Terms" text,
  "PriceTier" integer,
  "ShippingAddressLine1" text,
  "ShippingAddressLine2" text,
  "ShipmentRequiredByDate" timestamptz,
  "SaleOrderLocation" text,
  "SaleOrderNumber" text,
  "SaleOrderDate" timestamptz,
  "SaleTaskMemoInternal" text,
  "InternalMark" text,
  "QuoteMemo" text,
  "SaleOrderMemo" text,
  "InvoiceMemo" text,
  "CreditNoteMemo" text,
  "SaleOrderStatus" text,
  "InvoiceNumber" text,
  "CustomerReference" text,
  "InvoiceDate" timestamptz,
  "COGSAmount" numeric,
  "InvoiceDueDate" timestamptz,
  "InvoiceStatus" text,
  "QuoteNumber" text,
  "QuoteCreatedDate" timestamptz,
  "QuoteStatus" text,
  "Status" text,
  "CreditNoteNumber" text,
  "CreditNoteDate" timestamptz,
  "CreditNoteStatus" text,
  "SalesRepresentative" text,
  "CurrencyConversionRate" numeric,
  "CreditNoteConversionRate" numeric,
  "PickStatus" text,
  "PackStatus" text,
  "ShipmentStatus" text,
  "RestockStatus" text,
  "AdditionalCOGSStatus" text,
  "CustomerCurrency" text,
  "Carrier" text,
  "SyncRequest" boolean,
  "IsServiceOnly" boolean,
  "IsRecursive" boolean,
  "Frequency" text,
  "TermDueNextMonth" integer,
  "NextInvoiceDate" timestamptz,
  "ShipAddressID" text,
  "CreditLimit" numeric,
  "JobID" text,
  "ValidationText" text,
  "ValidationState" text,
  "CustomField1" text,
  "CustomField2" text,
  "CustomField3" text,
  "CustomField4" text,
  "CustomField5" text,
  "CustomField6" text,
  "CustomField7" text,
  "CustomField8" text,
  "CustomField9" text,
  "CustomField10" text,
  "FulfillmentNumber" integer,
  "ExternalID" text,
  "CountrySpecificKey" text
);

create table "SaleTaskWrapper" (
  "ID" text,
  "HasErrors" boolean,
  "SuppressTransactions" boolean,
  "DiscountsDesciption" text
);

create table "Scrap" (
  "ID" text,
  "Location" text,
  "Bin" text,
  "BatchSerialNo" text,
  "ExpenseAccount" text,
  "EffectiveDate" timestamptz,
  "Quantity" numeric,
  "Cost" numeric,
  "Total" numeric
);

create table "ShipBox" (
  "Box" text
);

create table "vBin" (
  "LocationID" text,
  "Description" text
);

create table "vChildCustomer" (
  "ChildCustomerID" text,
  "ChildCustomerName" text
);

create table "vChildCustomerList" (
  "Expand" text,
  "CustomerID" text,
  "Name" text,
  "SaleAccount" text,
  "DisplayName" text,
  "TotalSale" numeric
);

create table "vCreditAllocated" (
  "AllocationID" text,
  "TaskID" text,
  "DocNumber" text,
  "Currency" text,
  "Date" timestamptz,
  "Amount" numeric
);

create table "vCustomPrice" (
  "ProductID" text,
  "CustomerID" text,
  "Price" numeric,
  "IsDeleted" boolean
);

create table "vCustomerAddress" (
  "CustomerID" text,
  "AddressID" text,
  "Line1" text,
  "Line2" text,
  "CitySuburb" text,
  "StateProvince" text,
  "ZipPostCode" text,
  "Country" text,
  "Type" text,
  "DefaultForType" boolean
);

create table "vCustomerContact" (
  "CustomerID" text,
  "ContactID" text,
  "Name" text,
  "JobTitle" text,
  "Phone" text,
  "MobilePhone" text,
  "Fax" text,
  "Email" text,
  "Website" text,
  "IsDefault" boolean,
  "Comment" text
);

create table "vCustomerDefaultTemplate" (
  "DefaultTemplateID" text,
  "TemplateID" text,
  "CustomerID" text,
  "Type" text
);

create table "vCustomerFile" (
  "FileID" text,
  "CustomerID" text,
  "FileName" text,
  "ContentType" text,
  "UserName" text,
  "UploadedDate" timestamptz,
  "ExternalDownloadLink" text,
  "ExternalViewLink" text
);

create table "vCustomerList" (
  "Expand" text,
  "CustomerID" text,
  "Name" text,
  "Contact" text,
  "Phone" text,
  "Mobile" text,
  "Email" text,
  "Website" text,
  "Address" text,
  "TotalAmount" numeric,
  "PaidAmount" numeric,
  "DueAmount" numeric,
  "Currency" text,
  "IsActive" boolean,
  "CustomField1" text,
  "CustomField2" text,
  "CustomField3" text,
  "CustomField4" text,
  "CustomField5" text,
  "CustomField6" text,
  "CustomField7" text,
  "CustomField8" text,
  "CustomField9" text,
  "CustomField10" text,
  "Selected" boolean,
  "IsOnCreditHold" boolean,
  "Edit" text,
  "AttributeSetID" text,
  "DisplayName" text,
  "IsLegalEntity" boolean
);

create table "vCustomerParent" (
  "CustomerID" text,
  "Name" text
);

create table "vCustomerPaymentsDue" (
  "TaskID" text,
  "CustomerID" text,
  "InvoiceNumber" text,
  "InvoiceDate" timestamptz,
  "DueDate" timestamptz,
  "SONumber" text,
  "InvoiceAmount" numeric,
  "PaidAmount" numeric,
  "DueAmount" numeric,
  "DaysOverdue" integer,
  "AllocatedAmount" numeric,
  "SourceChannel" text
);

create table "vCustomerPurchases" (
  "ID" text,
  "ProductID" text,
  "Quantity" numeric,
  "Price" numeric,
  "TaskID" text,
  "InvoiceDate" timestamptz,
  "CustomerCurrency" text,
  "InvoiceNumber" text,
  "Name" text,
  "ProductCode" text,
  "IsServiceOnly" boolean,
  "CustomerName" text,
  "CustomerID" text,
  "IsMasterCustomerParent" boolean,
  "IsMasterCustomerChild" boolean
);

create table "vCustomerSaleTasks" (
  "TaskID" text,
  "SaleOrderNumber" text,
  "Status" text,
  "SaleOrderDate" timestamptz,
  "InvoiceNumber" text,
  "CustomerReference" text,
  "InvoiceAmount" numeric,
  "PaidAmount" numeric,
  "ShipmentRequiredByDate" timestamptz,
  "IsServiceOnly" boolean,
  "Controller" text,
  "CustomerName" text,
  "CustomerID" text,
  "IsMasterCustomerParent" boolean,
  "IsMasterCustomerChild" boolean
);

create table "vDearToDearNetworkingTaskLinks" (
  "ID" text,
  "SourceTaskID" text,
  "SourceType" integer,
  "TargetTaskID" text,
  "TargetType" integer
);

create table "vDiscountLine" (
  "FakeID" integer,
  "ID" text,
  "DiscountID" text,
  "MinValue" numeric,
  "MaxValue" numeric,
  "Type" text,
  "Amount" numeric,
  "ValidationText" text,
  "ValidationState" text
);

create table "vExpenseAccounts" (
  "Code" text,
  "DisplayName" text,
  "Class" text,
  "ForPayments" boolean,
  "Type" text
);

create table "vFulfillmentOrder" (
  "ID" text,
  "FFOrderId" text,
  "ExternalOrderID" text,
  "ConfigID" text,
  "Date" timestamptz,
  "SaleTaskID" text,
  "Currency" text,
  "SaleOrderNumber" text,
  "Memo" text,
  "Status" text,
  "Source" text,
  "CustomerName" text,
  "ContactName" text,
  "ContactPhone" text,
  "AddressZipPostCode" text,
  "AddressCountry" text,
  "AddressStateProvince" text,
  "AddressCitySuburb" text,
  "AddressLine1" text,
  "AddressLine2" text,
  "ShippingMethod" text,
  "CanBeCancelled" boolean,
  "ShipmentLineID" text
);

create table "vFulfillmentOrderForList" (
  "ID" text,
  "Location" text,
  "FFOrderId" text,
  "Date" timestamptz,
  "SaleTaskID" text,
  "SaleOrderNumber" text,
  "Memo" text,
  "Status" text,
  "ItemsCount" integer,
  "Selected" boolean
);

create table "vFulfillmentOrderItem" (
  "ID" text,
  "IdInOrder" text,
  "ProductID" text,
  "SKU" text,
  "FFSKU" text,
  "Quantity" text,
  "Comment" text,
  "PSKU" text,
  "PNAME" text
);

create table "vFulfillmentOrderItemDisposition" (
  "ID" text,
  "Quantity" text,
  "TrackingNumber" text
);

create table "vFulfillmentOrderLog" (
  "ID" text,
  "LogDate" timestamptz,
  "ChangesText" text,
  "ChangedBy" text
);

create table "vFulfillmentOrderStatus" (
  "ID" text,
  "RecieveDate" timestamptz,
  "ShipDate" timestamptz,
  "ArrivalDate" timestamptz,
  "OrderStatus" text,
  "ShipStatus" text
);

create table "vFulfillmentOrderTrackingInfo" (
  "ID" text,
  "ArrivalDate" timestamptz,
  "Package" text,
  "Carrier" text,
  "CarrierPhone" text,
  "CarrierUrl" text,
  "TrackingNumber" text,
  "Status" text,
  "History" text,
  "AdditionalInfo" text
);

create table "vLocation" (
  "LocationID" text,
  "Description" text
);

create table "vLocationAndBin" (
  "LocationID" text,
  "LocationName" text
);

create table "vRMA" (
  "TaskID" text,
  "Contact" text,
  "CreatedDate" timestamptz,
  "CustomerID" text,
  "CustomerName" text,
  "Email" text,
  "ExpiredDate" timestamptz,
  "Number" text,
  "Phone" text,
  "ReceiptsLocationID" text,
  "ReceiptsLocationName" text,
  "ShipAddressID" text,
  "ShipToAddress1" text,
  "ShipToAddress2" text,
  "ShipToCity" text,
  "ShipToCompany" text,
  "ShipToContact" text,
  "ShipToCountry" text,
  "ShipToOther" boolean,
  "ShipToPostCode" text,
  "ShipToState" text,
  "ShippingAddressLine1" text,
  "ShippingAddressLine2" text,
  "ReturnOrder" text,
  "ShippingNotes" text,
  "Status" text,
  "ValidationState" text,
  "ValidationText" text,
  "IsFulfilmentCompleted" boolean,
  "IsInvoiceAuthorised" boolean,
  "CreateCreditNoteType" text,
  "SaleOrderNumber" text,
  "SaleOrderCustomerReference" text,
  "FreeNotes" text,
  "RmaPortalID" text
);

create table "vRMAAttachments" (
  "TaskID" text,
  "ID" text,
  "BlobID" text,
  "ContentType" text,
  "FileName" text,
  "Date" timestamptz,
  "UserName" text,
  "IsProcessed" boolean
);

create table "vRMAExpenseAccount" (
  "DisplayName" text,
  "RuleID" text
);

create table "vRMAInTransitAccount" (
  "DisplayName" text,
  "Code" text
);

create table "vRMAList" (
  "TaskID" text,
  "Number" text,
  "SaleOrderNumber" text,
  "SaleOrderCustomerReference" text,
  "CustomerName" text,
  "CustomerID" text,
  "Contact" text,
  "Phone" text,
  "Email" text,
  "ReceiptsLocationID" text,
  "ReceiptsLocationName" text,
  "ShipToOther" boolean,
  "ShipToCompany" text,
  "ShipToContact" text,
  "ShipToCountry" text,
  "ShipToPostCode" text,
  "ShipToState" text,
  "ShipToCity" text,
  "ShipToAddress1" text,
  "ShipToAddress2" text,
  "ShippingAddressLine1" text,
  "ShippingAddressLine2" text,
  "CreatedDate" timestamptz,
  "ExpiredDate" timestamptz,
  "Status" text
);

create table "vRMAProductAttachments" (
  "ID" text,
  "RmaProductID" text,
  "FileName" text,
  "BlobID" text,
  "TaskID" text
);

create table "vRMAProducts" (
  "Selected" boolean,
  "ID" text,
  "TaskID" text,
  "ProductType" text,
  "ParentSaleTaskID" text,
  "FulfilmentTaskID" text,
  "ProductID" text,
  "ProductCode" text,
  "ProductName" text,
  "ExpiryDate" timestamptz,
  "SaleOrderNumber" text,
  "SaleOrderCustomerReference" text,
  "SaleLink" text,
  "InvoiceNumber" text,
  "WarrantyExpiredDate" timestamptz,
  "WarrantyRegistrationNumber" text,
  "ReturnPolicyName" text,
  "ReturnPolicyID" text,
  "IsCrossShipping" boolean,
  "IsDropShipping" boolean,
  "ShippingTrackingNumber" text,
  "CustomerComments" text,
  "BatchSerialNo" text,
  "ReasonForReturnID" text,
  "ReasonForReturnName" text,
  "ReturnType" text,
  "PackingCondition" text,
  "QuantityToReturn" numeric,
  "Price" numeric,
  "Total" numeric,
  "ReceiptAction" text,
  "LocationID" text,
  "Status" text,
  "RejectionReason" text,
  "DropShipMode" text,
  "DropShipSupplierID" text,
  "DropShipSupplierName" text,
  "SelectedDropShipAddressShipToCity" text,
  "SelectedDropShipAddressShipToCountry" text,
  "SelectedDropShipAddressShipToLine1" text,
  "SelectedDropShipAddressShipToLine2" text,
  "SelectedDropShipAddressShipToPostcode" text,
  "SelectedDropShipAddressShipToState" text,
  "SelectedDropShipSupplierID" text,
  "ReturnExpirationDate" timestamptz,
  "RefundExpirationDate" timestamptz,
  "ReplacementExpirationDate" timestamptz,
  "IsReturnPossible" boolean,
  "IsRefundPossible" boolean,
  "IsReplacementPossible" boolean,
  "IsInvoiced" boolean,
  "DropShipReplacementID" text,
  "IsPaid" boolean,
  "IsCrossShipPossible" boolean,
  "CostingMethod" text,
  "TotalCost" numeric
);

create table "vRMAProductsList" (
  "TaskID" text,
  "RMANumber" text,
  "SaleOrderNumber" text,
  "SaleOrderCustomerReference" text,
  "CustomerName" text,
  "CustomerID" text,
  "Contact" text,
  "Phone" text,
  "Email" text,
  "ReceiptsLocationID" text,
  "ReceiptsLocationName" text,
  "ShipToOther" boolean,
  "ShipToCompany" text,
  "ShipToContact" text,
  "ShipToCountry" text,
  "ShipToPostCode" text,
  "ShipToState" text,
  "ShipToCity" text,
  "ShipToAddress1" text,
  "ShipToAddress2" text,
  "ShippingAddressLine1" text,
  "ShippingAddressLine2" text,
  "CreatedDate" timestamptz,
  "ExpiredDate" timestamptz,
  "RMAStatus" text,
  "ROStatus" text,
  "RONumber" text,
  "ProductID" text,
  "ProductSKU" text,
  "ProductName" text,
  "BatchSerialNo" text,
  "RMAProductStatus" text,
  "IsReceived" boolean,
  "ReceiptAction" text,
  "JobID" text,
  "JobNumber" text,
  "ROResolution" text,
  "RMAResolution" text,
  "RMAResolutionStatus" text,
  "SaleTaskID" text,
  "RMATaskID" text,
  "ROTaskID" text
);

create table "vRMAReturnOrder" (
  "TaskID" text,
  "Contact" text,
  "CreatedDate" timestamptz,
  "CustomerID" text,
  "CustomerName" text,
  "Email" text,
  "Number" text,
  "Phone" text,
  "ReceiptsLocationID" text,
  "ReceiptsLocationName" text,
  "RmaDate" timestamptz,
  "RmaID" text,
  "RmaNumber" text,
  "ScrapWriteOffDefaultExpenseAccountName" text,
  "ScrapWriteOffDefaultExpenseAccount" text,
  "ShipAddressID" text,
  "ShipToAddress1" text,
  "ShipToAddress2" text,
  "ShipToCity" text,
  "ShipToCompany" text,
  "ShipToContact" text,
  "ShipToCountry" text,
  "ShipToOther" boolean,
  "ShipToPostCode" text,
  "ShipToState" text,
  "ShippingAddressLine1" text,
  "ShippingAddressLine2" text,
  "ShippingNotes" text,
  "Status" text,
  "ScrapWriteOffDefaultExpenseAccount" text,
  "ValidationState" text,
  "ValidationText" text,
  "CreateCreditNoteType" text,
  "ReceiveStatus" text,
  "ResolutionStatus" text,
  "FreeNotes" text
);

create table "vRMAReturnOrderAttachments" (
  "RMAReturnOrderTaskID" text,
  "ID" text,
  "BlobID" text,
  "ContentType" text,
  "FileName" text,
  "Date" timestamptz,
  "UserName" text,
  "IsProcessed" boolean
);

create table "vRMAReturnOrderGeneral" (
  "TaskID" text,
  "Number" text,
  "RmaNumber" text,
  "RmaDate" timestamptz,
  "CustomerName" text,
  "CustomerID" text,
  "Contact" text,
  "Phone" text,
  "Email" text,
  "ReceiptsLocationID" text,
  "ReceiptsLocationName" text,
  "ShipToOther" boolean,
  "ShipToCompany" text,
  "ShipToContact" text,
  "ShipToCountry" text,
  "ShipToPostCode" text,
  "ShipToState" text,
  "ShipToCity" text,
  "ShipToAddress1" text,
  "ShipToAddress2" text,
  "ShippingAddressLine1" text,
  "ShippingAddressLine2" text,
  "CreatedDate" timestamptz,
  "ExpiredDate" timestamptz,
  "Status" text,
  "ReceiveStatus" text,
  "ResolutionStatus" text
);

create table "vRMAReturnOrderProductAttachment" (
  "ID" text,
  "RmaReturnOrderProductID" text,
  "FileName" text,
  "BlobID" text,
  "TaskID" text
);

create table "vRMAReturnOrderProducts" (
  "BatchSerialNo" text,
  "BinID" text,
  "BinName" text,
  "CostingMethod" text,
  "CustomerComments" text,
  "FulfilmentTaskID" text,
  "ID" text,
  "TaskID" text,
  "ParentSaleTaskID" text,
  "ProductID" text,
  "ProductName" text,
  "ProductCode" text,
  "QuantityToReturn" numeric,
  "ReasonForReturnID" text,
  "ReasonForReturnName" text,
  "ReceiptAction" text,
  "ReceivedQuantity" numeric,
  "ExpiryDate" timestamptz,
  "RmaProductID" text,
  "Status" text,
  "ValidationState" text,
  "ValidationText" text,
  "WarrantyExpiredDate" timestamptz,
  "WarrantyRegistrationNumber" text,
  "ReturnPolicyID" text,
  "ReturnExpirationDate" timestamptz,
  "RefundExpirationDate" timestamptz,
  "ReplacementExpirationDate" timestamptz,
  "IsReturnPossible" boolean,
  "IsRefundPossible" boolean,
  "IsReplacementPossible" boolean,
  "IsCrossShipping" boolean,
  "TotalCost" numeric,
  "Price" numeric,
  "Total" numeric,
  "ReceivedDate" timestamptz,
  "IsReceived" boolean
);

create table "vRMASaleOrderInvoiceNumbers" (
  "Number" text,
  "CustomerReference" text
);

create table "vRMASuppliers" (
  "SupplierID" text,
  "Name" text
);

create table "vRMASuppliersAddresses" (
  "AddressID" text,
  "Line1" text,
  "Line2" text,
  "ShipToCity" text,
  "ShipToCountry" text,
  "ShipToLine1" text,
  "ShipToLine2" text,
  "ShipToPostcode" text,
  "ShipToState" text,
  "SupplierID" text
);

create table "vRMATaxRule" (
  "Description" text,
  "RuleID" text
);

create table "vSaleAdditionalCOGS" (
  "FakeID" integer,
  "TaskID" text,
  "ID" text,
  "Reference" text,
  "Amount" numeric,
  "Date" timestamptz,
  "Debit" text,
  "Credit" text,
  "ValidationText" text,
  "ValidationState" text
);

create table "vSaleAllocations" (
  "SaleCreditID" text,
  "AllocationID" text,
  "SalePaymentID" text,
  "TaskID" text,
  "Flag" boolean
);

create table "vSaleConsolidatedTranscations" (
  "ID" text,
  "Channel" text,
  "CreatedDate" timestamptz,
  "Currency" text,
  "Reference" text,
  "TotalAmountForeign" numeric,
  "TotalAmountLocal" numeric,
  "TransactionDate" timestamptz,
  "Type" text,
  "UpdatedDate" timestamptz,
  "Comment" text
);

create table "vSaleCreditNoteCostLines" (
  "FakeID" integer,
  "TaskID" text,
  "InvoiceCostID" text,
  "Description" text,
  "Quantity" numeric,
  "Amount" numeric,
  "Discount" numeric,
  "TaxRule" text,
  "Tax" numeric,
  "Total" numeric,
  "AccountCode" text,
  "TaxPercent" numeric,
  "Type" text,
  "LineOrder" integer,
  "ValidationText" text,
  "ValidationState" text,
  "Comment" text
);

create table "vSaleCreditNoteLines" (
  "FakeID" integer,
  "TaskID" text,
  "InvoiceLineID" text,
  "ProductID" text,
  "Quantity" numeric,
  "Price" numeric,
  "Discount" numeric,
  "Tax" numeric,
  "Total" numeric,
  "Type" text,
  "AccountCode" text,
  "TaxRule" text,
  "TaxPercent" numeric,
  "LineOrder" integer,
  "Name" text,
  "UnitOfMeasure" text,
  "ProductCode" text,
  "Comment" text,
  "ValidationText" text,
  "ValidationState" text
);

create table "vSaleCreditNotePaymentLines" (
  "FakeID" integer,
  "TaskID" text,
  "PaymentID" text,
  "Reference" text,
  "Amount" numeric,
  "DatePaid" timestamptz,
  "TaxRule" text,
  "AccountCode" text,
  "Type" text,
  "PaymentType" text,
  "CurrencyConversionRate" numeric,
  "IsNewCustomerCredit" boolean,
  "ValidationText" text,
  "ValidationState" text
);

create table "vSaleCreditWithDetails" (
  "SaleCreditID" text,
  "CustomerID" text,
  "Currency" text,
  "Amount" numeric,
  "RemainingAmount" numeric,
  "Account" text,
  "Description" text,
  "Date" timestamptz,
  "AllocatedAmount" numeric,
  "Selected" boolean,
  "ConvRate" numeric
);

create table "vSaleCredits" (
  "SaleCreditID" text,
  "CustomerID" text,
  "CustomerName" text,
  "Currency" text,
  "Amount" numeric,
  "RemainingAmount" numeric,
  "Account" text,
  "SourceLineID" text,
  "CreditSourceTaskID" text,
  "OrigTaskType" text,
  "Type" text,
  "Date" timestamptz
);

create table "vSaleExciseLines" (
  "FakeID" integer,
  "TaskID" text,
  "LineID" text,
  "ProductID" text,
  "Quantity" numeric,
  "ExciseTax" numeric,
  "Total" numeric,
  "LineOrder" integer,
  "Name" text,
  "ProductCode" text,
  "ImageID" text,
  "ValidationText" text,
  "ValidationState" text
);

create table "vSaleGiftCards" (
  "ID" text,
  "TaskID" text,
  "GiftCardCode" text,
  "InitialBalance" numeric,
  "CurrentBalance" numeric,
  "Date" timestamptz,
  "ExpirationDate" timestamptz,
  "RefundID" text
);

create table "vSaleInvoiceAdditionalCharges" (
  "FakeID" integer,
  "TaskID" text,
  "InvoiceCostID" text,
  "Description" text,
  "Quantity" numeric,
  "Amount" numeric,
  "Discount" numeric,
  "TaxRule" text,
  "Tax" numeric,
  "Total" numeric,
  "AccountCode" text,
  "TaxPercent" numeric,
  "Type" text,
  "LineOrder" integer,
  "ValidationText" text,
  "ValidationState" text,
  "Comment" text
);

create table "vSaleInvoiceLines" (
  "FakeID" integer,
  "TaskID" text,
  "InvoiceLineID" text,
  "ProductID" text,
  "Quantity" numeric,
  "Price" numeric,
  "Discount" numeric,
  "Tax" numeric,
  "Total" numeric,
  "AccountCode" text,
  "LineOrder" integer,
  "Name" text,
  "UnitOfMeasure" text,
  "ProductCode" text,
  "AverageCost" numeric,
  "CostingMethod" text,
  "TaxRule" text,
  "TaxPercent" numeric,
  "Comment" text,
  "ImageID" text,
  "SourceProductCode" text,
  "SourceProductName" text,
  "ValidationText" text,
  "ValidationState" text,
  "DropShip" boolean,
  "DropShipMode" text,
  "NonInventory" boolean,
  "SupplierLatestPurchasePrice" numeric,
  "SupplierFixedCost" numeric,
  "SupplierCurrency" text
);

create table "vSaleMult_Customer" (
  "CustomerID" text,
  "Name" text,
  "Currency" text,
  "PaymentTerm" text,
  "TaxRule" text,
  "Comments" text,
  "DefaultSalesRepresentative" text,
  "AccountCode" text,
  "DefaultLocation" text,
  "Discount" numeric,
  "DefaultCarrier" text,
  "SalePriceTier" integer,
  "CreditLimit" numeric,
  "AttributeSet" text,
  "BillParent" boolean
);

create table "vSaleMult_CustomerAddress" (
  "CustomerID" text,
  "AddressID" text,
  "Line1" text,
  "Line2" text,
  "Type" text,
  "DefaultForType" boolean,
  "AddressLine1" text,
  "AddressLine2" text,
  "AddressCitySuburb" text,
  "AddressStateProvince" text,
  "AddressCountry" text,
  "AddressZipPostCode" text,
  "TaxExemptionReasonCode" text,
  "IsParent" boolean
);

create table "vSaleMult_CustomerContact" (
  "CustomerID" text,
  "ContactID" text,
  "Name" text,
  "IsDefault" boolean,
  "Phone" text,
  "Email" text
);

create table "vSaleMult_TenantAddress" (
  "AddressID" text,
  "Line1" text,
  "Line2" text,
  "Type" text,
  "DefaultForType" boolean
);

create table "vSaleOrderAdditionalCharges" (
  "FakeID" integer,
  "TaskID" text,
  "OrderCostID" text,
  "Description" text,
  "Quantity" numeric,
  "Amount" numeric,
  "Discount" numeric,
  "TaxRule" text,
  "Tax" numeric,
  "Total" numeric,
  "TaxPercent" numeric,
  "LineOrder" integer,
  "RevenueAccount" text,
  "ValidationText" text,
  "ValidationState" text,
  "Comment" text
);

create table "vSaleOrderAttachement" (
  "TaskID" text,
  "AttachementID" text,
  "BlobGUID" text,
  "ContentType" text,
  "FileName" text,
  "Date" timestamptz,
  "UserName" text,
  "IsProcessed" boolean,
  "ExternalDownloadLink" text,
  "ExternalViewLink" text
);

create table "vSaleOrderLines" (
  "FakeID" integer,
  "TaskID" text,
  "OrderLineID" text,
  "ProductID" text,
  "SourceProductCode" text,
  "SourceProductName" text,
  "Quantity" numeric,
  "Price" numeric,
  "Discount" numeric,
  "Tax" numeric,
  "Total" numeric,
  "LineOrder" integer,
  "Name" text,
  "UnitOfMeasure" text,
  "ProductCode" text,
  "AverageCost" numeric,
  "CostingMethod" text,
  "RevenueAccount" text,
  "TaxRule" text,
  "TaxPercent" numeric,
  "Comment" text,
  "ImageID" text,
  "ValidationText" text,
  "ValidationState" text,
  "DropShip" boolean,
  "DropShipMode" text,
  "NonInventory" boolean,
  "SupplierLatestPurchasePrice" numeric,
  "SupplierFixedCost" numeric,
  "SupplierCurrency" text
);

create table "vSalePackingSlips" (
  "FakeID" integer,
  "TaskID" text,
  "SlipID" text,
  "ProductID" text,
  "Quantity" numeric,
  "BoxNumber" text,
  "Name" text,
  "UnitOfMeasure" text,
  "ProductCode" text,
  "CostingMethod" text,
  "BatchSN" text,
  "ExpiryDate" timestamptz,
  "LocationID" text,
  "ImageID" text,
  "NonInventory" boolean,
  "WarrantySetupName" text,
  "WarrantySetupID" text,
  "WarrantySetupCalculationStartDate" text,
  "WarrantySetupAutoGenerate" boolean,
  "WarrantyRegistrationNumber" text,
  "ValidationText" text,
  "ValidationState" text
);

create table "vSalePaymentLines" (
  "FakeID" integer,
  "TaskID" text,
  "PaymentID" text,
  "Reference" text,
  "Amount" numeric,
  "DatePaid" timestamptz,
  "TaxRule" text,
  "AccountCode" text,
  "Type" text,
  "PaymentType" text,
  "CurrencyConversionRate" numeric,
  "ValidationText" text,
  "ValidationState" text
);

create table "vSalePickings" (
  "FakeID" integer,
  "TaskID" text,
  "ID" text,
  "ProductID" text,
  "ProductCode" text,
  "Name" text,
  "UnitOfMeasure" text,
  "Quantity" numeric,
  "LocationID" text,
  "Type" text,
  "CostingMethod" text,
  "BatchSN" text,
  "ExpiryDate" timestamptz,
  "ImageID" text,
  "NonInventory" boolean,
  "WarrantySetupName" text,
  "WarrantySetupID" text,
  "WarrantySetupCalculationStartDate" text,
  "WarrantySetupAutoGenerate" boolean,
  "WarrantyRegistrationNumber" text,
  "ValidationText" text,
  "ValidationState" text,
  "RestockDate" timestamptz,
  "RestockLocationID" text
);

create table "vSaleQuoteAdditionalCharges" (
  "FakeID" integer,
  "TaskID" text,
  "QuoteCostID" text,
  "Description" text,
  "Quantity" numeric,
  "Amount" numeric,
  "Discount" numeric,
  "TaxRule" text,
  "Tax" numeric,
  "Total" numeric,
  "TaxPercent" numeric,
  "LineOrder" integer,
  "RevenueAccount" text,
  "ValidationText" text,
  "ValidationState" text,
  "Comment" text
);

create table "vSaleQuoteLines" (
  "FakeID" integer,
  "TaskID" text,
  "QuoteLineID" text,
  "ProductID" text,
  "Quantity" numeric,
  "Price" numeric,
  "Discount" numeric,
  "Tax" numeric,
  "Total" numeric,
  "LineOrder" integer,
  "Name" text,
  "UnitOfMeasure" text,
  "ProductCode" text,
  "TaxRule" text,
  "TaxPercent" numeric,
  "RevenueAccount" text,
  "Comment" text,
  "ValidationText" text,
  "ValidationState" text
);

create table "vSaleShipments" (
  "FakeID" integer,
  "TaskID" text,
  "ShipmentID" text,
  "ShipmentDate" timestamptz,
  "Carrier" text,
  "ExternalService" text,
  "Boxes" text,
  "BoxesUI" text,
  "TrackingNumber" text,
  "TrackingUrl" text,
  "FulfillmentBoxOption" text,
  "LogisticsProviderOption" text,
  "Shipped" boolean,
  "ValidationText" text,
  "ValidationState" text
);

create table "vSaleTaskLineConfigs" (
  "LineConfigurationID" text,
  "TaskID" text,
  "ConfigurationID" text,
  "QuoteLineID" text,
  "OrderLineID" text,
  "InvoiceLineID" text
);

create table "vSaleTaskListAccounting" (
  "ID" text,
  "TaskID" text,
  "Type" text,
  "Customer" text,
  "Contact" text,
  "Phone" text,
  "Email" text,
  "Currency" text,
  "CustomerRef" text,
  "CustomField1" text,
  "CustomField2" text,
  "CustomField3" text,
  "CustomField4" text,
  "CustomField5" text,
  "CustomField6" text,
  "CustomField7" text,
  "CustomField8" text,
  "CustomField9" text,
  "CustomField10" text,
  "Total" numeric,
  "Paid" numeric,
  "Credited" numeric,
  "Due" numeric,
  "DaysOverdue" integer,
  "DocNo" text,
  "Location" text,
  "SaleOrderDate" timestamptz,
  "Date" timestamptz,
  "DueDate" timestamptz,
  "OrderNo" text,
  "SaleRep" text,
  "Terms" text,
  "Status" text,
  "FulFilmentStatus" text,
  "TT" integer,
  "Selected" boolean,
  "SendStatus" text,
  "IsArchived" boolean,
  "QuoteApprove" integer
);

create table "vSaleTaskListFulfilment" (
  "TaskID" text,
  "OrderNo" text,
  "OrderDate" timestamptz,
  "Customer" text,
  "Contact" text,
  "Phone" text,
  "Email" text,
  "FulfillmentNumber" integer,
  "CustomerReference" text,
  "ShipmentRequiredByDate" timestamptz,
  "ShippingAddressLine1" text,
  "PickStatus" integer,
  "PackStatus" integer,
  "ShipStatus" integer,
  "SalesRepresentative" text,
  "CustomField1" text,
  "CustomField2" text,
  "CustomField3" text,
  "CustomField4" text,
  "CustomField5" text,
  "CustomField6" text,
  "CustomField7" text,
  "CustomField8" text,
  "CustomField9" text,
  "CustomField10" text,
  "SaleOrderLocation" text,
  "Status" text,
  "FulFilmentStatus" text,
  "TrackingNumbers" text,
  "DaysOverdue" integer,
  "CarrierCode" text,
  "CarrierServiceCode" text,
  "CarrierServiceDisplayName" text,
  "TT" integer,
  "CombinedPaymentStatus" text,
  "CombinedInvoiceStatus" text,
  "Terms" text,
  "Selected" boolean,
  "SelectedForPickingDate" timestamptz,
  "PickedBy" text,
  "ShippingNotes" text
);

create table "vSaleTaskListGeneral" (
  "TaskID" text,
  "Customer" text,
  "Contact" text,
  "Phone" text,
  "Email" text,
  "Currency" text,
  "CustomerReference" text,
  "CustomField1" text,
  "CustomField2" text,
  "CustomField3" text,
  "CustomField4" text,
  "CustomField5" text,
  "CustomField6" text,
  "CustomField7" text,
  "CustomField8" text,
  "CustomField9" text,
  "CustomField10" text,
  "DCQuoteTotal" numeric,
  "DCOrderTotal" numeric,
  "DocNumbers" text,
  "FulFilmentStatus" text,
  "InvoicingStatus" text,
  "PaymentStatus" text,
  "Location" text,
  "OrderDate" timestamptz,
  "ReqBy" timestamptz,
  "OrderNo" text,
  "OrderStatus" integer,
  "QuoteStatus" integer,
  "SaleRep" text,
  "ShippingAddressLine1" text,
  "Status" text,
  "TrackingNumbers" text,
  "TT" integer,
  "CarrierServiceApplicable" boolean,
  "CarrierCode" text,
  "CarrierServiceCode" text,
  "CarrierServiceDisplayName" text,
  "Selected" boolean,
  "QuoteSendStatus" text,
  "OrderSendStatus" text,
  "IsArchived" boolean,
  "QuoteApprove" integer,
  "ShippingNotes" text,
  "Type" text
);

create table "vSaleTaskOrderTags" (
  "TaskId" text,
  "AmazonPrime" boolean,
  "AmazonBusiness" boolean
);

create table "vSaleTaskProductConfigurationOptions" (
  "ConfigurationOptionID" text,
  "ConfigurationID" text,
  "TaskID" text,
  "MenuConfigurationID" text,
  "Description" text,
  "Name" text,
  "ParentName" text,
  "ConfigurationOptionArtID" text,
  "Type" text,
  "MappedProductID" text,
  "MappedProductName" text
);

create table "vSaleTaskProductConfigurations" (
  "ConfigurationID" text,
  "TaskID" text,
  "ProductID" text,
  "Description" text
);

create table "vSaleTaskWmsOperator" (
  "ID" text,
  "TaskID" text,
  "UserName" text,
  "StartedPickDate" timestamptz
);

create table "vSaleWarranty" (
  "ID" text,
  "WarrantyName" text,
  "CustomerName" text,
  "OrderNumber" text,
  "OrderDate" text,
  "BatchSN" text,
  "RegistrationNumber" text,
  "ExpiryDate" timestamptz,
  "IsLifetime" boolean
);

create table "vSale_CustomerAddress" (
  "CustomerID" text,
  "AddressID" text,
  "Line1" text,
  "Line2" text,
  "Type" text,
  "DefaultForType" boolean,
  "Type" text,
  "AddressLine1" text,
  "AddressLine2" text,
  "AddressCitySuburb" text,
  "AddressStateProvince" text,
  "AddressCountry" text,
  "AddressZipPostCode" text
);

create table "vSale_CustomerContact" (
  "CustomerID" text,
  "ContactID" text,
  "Name" text,
  "IsDefault" boolean,
  "Phone" text,
  "Email" text
);

create table "vSale_TenantAddress" (
  "AddressID" text,
  "Line1" text,
  "Line2" text,
  "Type" text,
  "DefaultForType" boolean
);

create table "vShippingLabelAttachment" (
  "BlobGUID" text,
  "TrackNumber" text
);

create table "vShippingManifestAttachment" (
  "BlobGUID" text,
  "TrackNumber" text
);

create table "vShippingMethod" (
  "ID" text,
  "Name" text
);

create table "vShippingRateOrLabelProvider" (
  "ID" text,
  "IsDefault" boolean,
  "Name" text,
  "SupportsConsolidatedShipment" boolean
);

create table "vTenantCarrierWithShippingOptions" (
  "CarrierID" text,
  "Code" text,
  "Description" text,
  "ExternalService" text,
  "IsDefault" boolean
);

create table "vTenantPaymentTermNew" (
  "TermID" text,
  "Name" text,
  "Days" integer,
  "Method" integer,
  "DueNextMonth" integer,
  "IsActive" boolean,
  "IsDefault" boolean
);

create table "vTransferOrder" (
  "Value" text,
  "Name" text
);
