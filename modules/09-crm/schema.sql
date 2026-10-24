-- CRM: one table per Cin7 Core data model, generated from data/models.json

create table "AccountCurrency" (
  "Code" text,
  "Currency" text
);

create table "AvalaraSaleTaxCode" (
  "Code" text,
  "Name" text
);

create table "CalegoryModel" (
  "id" text,
  "name" text
);

create table "CustomerDefaultTemplate" (
  "DefaultTemplateID" text,
  "TemplateID" text,
  "Type" text
);

create table "DealWrapper" (
  "ID" integer,
  "HasErrors" boolean
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

create table "LeadStatus" (
  "Value" text,
  "Name" text
);

create table "LeadStatusList" (
  "StatusID" text,
  "Name" text,
  "IsKanban" boolean,
  "Position" integer,
  "PositionLocal" integer
);

create table "LeadWrapper" (
  "ID" integer,
  "HasErrors" boolean
);

create table "LookupCarrierModel" (
  "FakeID" text,
  "CarrierCode" text,
  "ServiceCode" text,
  "Highlighted" boolean,
  "DisplayName" text
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

create table "Opportunity" (
  "OpportunityID" text,
  "CustomerID" text,
  "LeadID" text,
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
  "OpportunityLocationID" text,
  "OpportunityLocation" text,
  "OpportunityNumber" text,
  "OpportunityDate" timestamptz,
  "OpportunityMemo" text,
  "OpportunityComment" text,
  "OpportunityStatus" text,
  "CustomerReference" text,
  "SalesRepresentative" text,
  "CurrencyConversionRate" numeric,
  "CustomerCurrency" text,
  "Carrier" text,
  "TermDueNextMonth" integer,
  "ShipAddressID" text,
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
  "ASTaxTotal" numeric,
  "ASTotalWithTax" numeric,
  "ProductTaxTotal" numeric,
  "ProductTotalWithTax" numeric,
  "TaxTotal" numeric,
  "TotalWithTax" text,
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
  "CarrierCode" text,
  "CarrierServiceCode" text,
  "CarrierServiceDisplayName" text
);

create table "OpportunityReferenceData" (
  "ID" integer,
  "DefaultTaxRule" text,
  "DefaultAccountCode" text,
  "ProductFamilyCount" integer,
  "DiscountCount" integer,
  "ChangePricesDiscountsPermission" text,
  "HasPriceInfoAccess" boolean,
  "UndoPermission" text,
  "VoidPermission" text,
  "ApprovePermission" text,
  "AddEditPermission" text,
  "ConvertToSalePermission" text,
  "CSVImportPermission" text,
  "TasksViewPermission" text,
  "CurrentAttributeSetId" text,
  "EnableOpportunityApproval" boolean,
  "TaxCalculationMethod" text,
  "DiscountCalculationMethod" text,
  "HeadersVisible" boolean,
  "ForceHideLookup" boolean,
  "AttributeSetCopyFrom" text
);

create table "OpportunityWrapper" (
  "ID" text,
  "HasErrors" boolean,
  "DiscountsDesciption" text,
  "HasAvalaraIntegration" boolean,
  "AvalaraTaxExemptionCode" text,
  "Warnings" text,
  "ConvertedSaleTaskID" text
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

create table "RecurringFrequency" (
  "Value" text,
  "Name" text
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

create table "ShipBox" (
  "Box" text
);

create table "TaskCalendarSettingsModel" (
  "FirstDayOfWeek" text,
  "WeekendDays" text
);

create table "TaskReferenceData" (
  "ID" integer,
  "UserName" text,
  "UserID" text,
  "TaskApprovalPermission" boolean,
  "TaskViewPermission" boolean,
  "ChangeAssigneePermission" boolean,
  "ViewAllTasksPermission" boolean
);

create table "vCouponReport" (
  "ID" text,
  "SaleTaskID" text,
  "SaleOrderDate" timestamptz,
  "SaleOrderDateString" text,
  "OrderNumber" text,
  "CustomerName" text,
  "TotalAmount" numeric,
  "CouponCode" text,
  "MaxRows" integer,
  "TT" integer
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

create table "vDeal" (
  "ID" text,
  "Name" text,
  "DateFrom" timestamptz,
  "DateTo" timestamptz,
  "IsActive" boolean,
  "AllowCoupons" boolean,
  "SingleCouponCodeUsage" boolean,
  "CouponCodes" text,
  "CustomersGroup" text,
  "ValidationText" text,
  "ValidationState" text
);

create table "vDealCustomer" (
  "ID" text,
  "CustomerID" text,
  "CustomerName" text,
  "DealID" text
);

create table "vDealCustomerTag" (
  "ID" text,
  "TagName" text,
  "DealID" text
);

create table "vDealDiscount" (
  "ID" text,
  "DiscountID" text,
  "DiscountName" text,
  "DiscountType" text,
  "DealID" text,
  "ValidationText" text,
  "ValidationState" text,
  "Sequence" integer,
  "IsOrderLevel" boolean,
  "BuyType" text,
  "BuyValue" numeric,
  "BuyValueType" text,
  "BuyMore" boolean,
  "GetType" text,
  "GetValue" numeric,
  "GetValueType" text
);

create table "vDealDiscountBrand" (
  "ID" text,
  "BrandID" text,
  "BrandName" text,
  "DealDiscountID" text,
  "Type" text
);

create table "vDealDiscountCategory" (
  "ID" text,
  "CategoryID" text,
  "CategoryName" text,
  "DealDiscountID" text,
  "Type" text
);

create table "vDealDiscountProduct" (
  "ID" text,
  "ProductID" text,
  "ProductName" text,
  "DealDiscountID" text,
  "Type" text,
  "IsFamily" boolean
);

create table "vDealDiscountTag" (
  "ID" text,
  "TagName" text,
  "DealDiscountID" text,
  "Type" text
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

create table "vLead" (
  "LeadID" text,
  "LeadStatus" text,
  "Name" text,
  "Currency" text,
  "Amount" numeric,
  "SalesRepresentative" text,
  "CloseChance" text,
  "CloseDate" timestamptz,
  "Comments" text,
  "PriceTier" numeric,
  "TermID" text,
  "TaxSchema" text,
  "ValidationText" text,
  "ValidationState" text
);

create table "vLeadAddress" (
  "Edit" text,
  "FakeID" integer,
  "LeadID" text,
  "AddressID" text,
  "Line1" text,
  "Line2" text,
  "CitySuburb" text,
  "StateProvince" text,
  "ZipPostCode" text,
  "Country" text,
  "Type" text,
  "DefaultForType" boolean,
  "TaxExemptionReasonCode" text,
  "ValidationText" text,
  "ValidationState" text
);

create table "vLeadContact" (
  "Edit" text,
  "FakeID" integer,
  "LeadID" text,
  "ContactID" text,
  "Name" text,
  "Phone" text,
  "Fax" text,
  "Email" text,
  "JobTitle" text,
  "MobilePhone" text,
  "Website" text,
  "IsDefault" boolean,
  "Comment" text,
  "IncludeInEmail" boolean,
  "ValidationText" text,
  "ValidationState" text
);

create table "vLeadFile" (
  "FileID" text,
  "LeadID" text,
  "FileName" text,
  "ContentType" text,
  "UserName" text,
  "UploadedDate" timestamptz,
  "ExternalDownloadLink" text,
  "ExternalViewLink" text
);

create table "vLeadList" (
  "Expand" text,
  "LeadID" text,
  "CustomerID" text,
  "LeadStatus" text,
  "Name" text,
  "Contact" text,
  "Phone" text,
  "Mobile" text,
  "Email" text,
  "Website" text,
  "Address" text,
  "Currency" text,
  "Amount" numeric,
  "SalesRepresentative" text,
  "SalesRepName" text,
  "CloseChance" numeric,
  "CloseDate" timestamptz,
  "CreatedDate" timestamptz,
  "Comments" text,
  "PriceTier" integer,
  "TermID" text,
  "TaxSchema" text,
  "TaskCount" integer,
  "Edit" text
);

create table "vOpportunityAdditionalCharges" (
  "FakeID" integer,
  "OpportunityID" text,
  "ChargeID" text,
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

create table "vOpportunityAllocations" (
  "SaleCreditID" text,
  "AllocationID" text,
  "SalePaymentID" text,
  "TaskID" text,
  "Flag" boolean
);

create table "vOpportunityAttachement" (
  "OpportunityID" text,
  "AttachementID" text,
  "BlobGUID" text,
  "ContentType" text,
  "FileName" text,
  "Date" timestamptz,
  "UserName" text,
  "IsProcessed" boolean
);

create table "vOpportunityCreditWithDetails" (
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

create table "vOpportunityCredits" (
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

create table "vOpportunityLines" (
  "FakeID" integer,
  "OpportunityID" text,
  "OpportunityLineID" text,
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
  "AverageCost" numeric,
  "CostingMethod" text,
  "RevenueAccount" text,
  "DropShipMode" text,
  "TaxRule" text,
  "TaxPercent" numeric,
  "Comment" text,
  "ImageID" text,
  "ValidationText" text,
  "ValidationState" text
);

create table "vOpportunity_Customer" (
  "CustomerID" text,
  "isLead" boolean,
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
  "AttributeSet" text
);

create table "vOpportunity_CustomerAddress" (
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
  "AddressZipPostCode" text,
  "TaxExemptionReasonCode" text
);

create table "vOpportunity_CustomerContact" (
  "CustomerID" text,
  "ContactID" text,
  "Name" text,
  "IsDefault" boolean,
  "Phone" text,
  "Email" text
);

create table "vOpportunity_TenantAddress" (
  "AddressID" text,
  "Line1" text,
  "Line2" text,
  "Type" text,
  "DefaultForType" boolean
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

create table "vShippingLabelAttachment" (
  "BlobGUID" text,
  "TrackNumber" text
);

create table "vShippingRateOrLabelProvider" (
  "ID" text,
  "IsDefault" boolean,
  "Name" text,
  "SupportsConsolidatedShipment" boolean
);

create table "vTaskList" (
  "Expand" text,
  "TaskID" text,
  "DueName" text,
  "TaskCategoryID" text,
  "TaskCategoryName" text,
  "WorkflowID" text,
  "UserID" text,
  "AssignedToName" text,
  "Name" text,
  "Details" text,
  "StartDate" timestamptz,
  "EndDate" timestamptz,
  "CompletedDate" timestamptz,
  "Sequence" text,
  "WorkflowProcessID" text,
  "IsAllDay" boolean,
  "EntityType" text,
  "EntityID" text,
  "TaskStatus" text,
  "LinkTo" text,
  "Importance" boolean,
  "AssignedBy" text,
  "AssignedByName" text,
  "ApprovedBy" text,
  "ApprovedByName" text,
  "CreatedDate" timestamptz,
  "IsCategoryPredefined" boolean,
  "Edit" text
);

create table "vTaskObserver" (
  "ObserverID" text,
  "TaskID" text,
  "UserID" text,
  "Name" text,
  "IsMain" boolean,
  "CreatedDate" timestamptz
);

create table "vTenantCarrierWithShippingOptions" (
  "CarrierID" text,
  "Code" text,
  "Description" text,
  "ExternalService" text,
  "IsDefault" boolean
);

create table "vTenantHoliday" (
  "HolidayID" text,
  "Date" timestamptz,
  "Description" text,
  "Skip" boolean
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

create table "vTenantTaskSettings" (
  "TenantID" text,
  "IsActive" boolean,
  "ApprovalEnabled" boolean,
  "FirstDayOfWeek" integer,
  "WeekendDays" text
);

create table "vTenantUser" (
  "TenantID" text,
  "UserId" text,
  "Email" text,
  "IsOwner" boolean,
  "IsCurrentUser" boolean,
  "IsLockedOut" boolean,
  "IsPending" boolean,
  "IsPartner" boolean,
  "LastActivityDate" timestamptz,
  "ValidationText" text,
  "ValidationState" text,
  "Roles" text,
  "IsCoOwner" boolean
);
