-- Settings: one table per Cin7 Core data model, generated from data/models.json

create table "CalendarSettingsWrapper" (
  "FirstDayOfWeek" text,
  "WeekendDays" text
);

create table "CatColor" (
  "Color" text,
  "BackgroundColor" text
);

create table "MeasurementUnit" (
  "UoMAbbr" text,
  "UoMName" text,
  "IsFirst" boolean,
  "MeasurementSystem" text
);

create table "RoundingRule" (
  "Code" text,
  "Name" text
);

create table "SecurityQuestion" (
  "ID" text,
  "Name" text
);

create table "SettingsPermission" (
  "Prefix" text,
  "Link" text,
  "Allowed" boolean,
  "Hidden" boolean
);

create table "State" (
  "Code" text,
  "Name" text,
  "CountryCode" text
);

create table "Template" (
  "TemplateID" text,  -- -> Template
  "Type" text,
  "Name" text,
  "ThumbnailPath" text,
  "IsNew" boolean,
  "IsDefault" boolean,
  "Process" text,
  "EmailTemplateID" text,  -- -> EmailTemplate
  "EmailSubject" text,
  "MultilingualTemplateCode" text,
  "EmailTypes" text,
  "MailingList" text,
  "CustomEmail" text
);

create table "WorkflowWrapper" (
  "ID" integer,
  "HasErrors" boolean
);

create table "vAutomatedWorkflow" (
  "AutomatedWorkflowID" text,  -- -> AutomatedWorkflow
  "Name" text,
  "Description" text,
  "IsActive" boolean,
  "EntityType" text,
  "CreatedDate" timestamptz,
  "LastUpdatedDate" timestamptz,
  "LastUpdatedBy" text
);

create table "vExternalNotificationSettings" (
  "ID" text,
  "NotificationSettingsID" text,  -- -> NotificationSettings
  "TenantID" text,  -- -> Tenant
  "IsActive" boolean,
  "IsWebhook" boolean,
  "ExternalURL" text,
  "ExternalAuthorizationType" text,
  "ExternalUserName" text,
  "ExternalPassword" text,
  "ExternalBearerToken" text,
  "ExternalHeaders" text
);

create table "vMailingList" (
  "MailingListID" text,  -- -> MailingList
  "Name" text,
  "Emails" text,
  "ValidationText" text,
  "ValidationState" text
);

create table "vMarkupRounding" (
  "MarkupRoundingID" text,  -- -> MarkupRounding
  "TenantID" text,  -- -> Tenant
  "RangeFrom" numeric,
  "RangeTo" numeric,
  "RoundToNearest" numeric,
  "AdjustmentRule" text,
  "AdjustmentValue" numeric
);

create table "vMultilingualSupportCultureModel" (
  "Code" text,
  "Name" text
);

create table "vMultilingualTemplate" (
  "Code" text,
  "Name" text,
  "IsDefault" boolean
);

create table "vNotificationExecutionLogEmail" (
  "ExecutionLogID" text,  -- -> ExecutionLog
  "TenantID" text,  -- -> Tenant
  "NotificationSystemName" text,
  "ExecutionStartDate" timestamptz,
  "ExecutionEndDate" timestamptz,
  "ExecutionDate" timestamptz,
  "EmailStatus" text,
  "Status" text,
  "Recipients" text,
  "Subject" text,
  "Body" text,
  "ErrorMessage" text
);

create table "vNotificationExecutionLogExternal" (
  "ExecutionLogID" text,  -- -> ExecutionLog
  "TenantID" text,  -- -> Tenant
  "NotificationSystemName" text,
  "ExecutionStartDate" timestamptz,
  "ExecutionEndDate" timestamptz,
  "ExecutionDate" timestamptz,
  "ExternalStatus" text,
  "Status" text,
  "ExternalStatusMessage" text,
  "ExternalUrls" text,
  "Url" text,
  "ExternalData" text,
  "Details" text,
  "SystemMessage" text
);

create table "vNotificationExecutionLogInternal" (
  "ExecutionLogID" text,  -- -> ExecutionLog
  "TenantID" text,  -- -> Tenant
  "NotificationSystemName" text,
  "ExecutionDate" timestamptz,
  "EntityName" text,
  "EntityType" text,
  "EntityID" text,  -- -> Entity (polymorphic)
  "Message" text,
  "Details" text
);

create table "vNotificationSettings" (
  "NotificationSettingsID" text,  -- -> NotificationSettings
  "TenantID" text,  -- -> Tenant
  "IsActive" boolean,
  "IsActiveSystem" boolean,
  "ModuleName" text,
  "NotificationType" text,
  "Name" text,
  "Description" text,
  "SystemName" text,
  "IsInternal" boolean,
  "IsEmail" boolean,
  "IsExternal" boolean,
  "Message" text,
  "EmailSubject" text,
  "EmailTemplate" text,
  "TemplateParameter" text,
  "AllowPeriods" jsonb,
  "Period" text,
  "StartExecutionDate" timestamptz,
  "LastExecutionDate" timestamptz,
  "CustomEmail" text,
  "AllowCustomEmail" boolean,
  "DeliveryMethods" text,
  "SendToRelated" boolean,
  "SendToSaleRep" boolean,
  "AllowSendToRelated" boolean,
  "AllowSendToSaleRep" boolean,
  "TemplateID" text,  -- -> Template
  "TemplateRequired" boolean,
  "Group" text,
  "AvailableEmailTypes" text,
  "EmailTypes" text,
  "MailingListIDs" text,
  "MailingList" text,
  "ConditionParameter" text,
  "ConditionText" text,
  "ConditionParameterValue" text,
  "AllowConditionParameter" boolean,
  "SubGroupName" text
);

create table "vNotificationWorkflow" (
  "NotitifcationWorkflowID" text,  -- -> NotitifcationWorkflow
  "NotificationSettingsID" text,  -- -> NotificationSettings
  "WorkflowID" text,  -- -> Workflow
  "Type" text,
  "ValidationText" text,
  "ValidationState" text
);

create table "vPaymentHistory" (
  "ID" text,
  "Plan" text,
  "From" timestamptz,
  "To" timestamptz,
  "Amount" numeric,
  "Currency" text,
  "Status" text,
  "HasInvoice" boolean,
  "SysDate" timestamptz,
  "InvoiceNumber" text,
  "ReferralCreditUsed" numeric,
  "ResponseText" text
);

create table "vReferrals" (
  "RowNum" integer,
  "CreatedDate" timestamptz,
  "Status" text,
  "Discount" text,
  "Company" text,
  "OwnerEmail" text,
  "CreditEarned" numeric
);

create table "vTaskCategory" (
  "TaskCategoryID" text,  -- -> TaskCategory
  "Name" text,
  "Color" text,
  "BackgroundColor" text,
  "IsPredefined" boolean,
  "ValidationText" text,
  "ValidationState" text
);

create table "vTaskList" (
  "Expand" text,
  "TaskID" text,  -- -> Task (any document)
  "DueName" text,
  "TaskCategoryID" text,  -- -> TaskCategory
  "TaskCategoryName" text,
  "WorkflowID" text,  -- -> Workflow
  "UserID" text,  -- -> User
  "AssignedToName" text,
  "Name" text,
  "Details" text,
  "StartDate" timestamptz,
  "EndDate" timestamptz,
  "CompletedDate" timestamptz,
  "Sequence" text,
  "WorkflowProcessID" text,  -- -> WorkflowProcess
  "IsAllDay" boolean,
  "EntityType" text,
  "EntityID" text,  -- -> Entity (polymorphic)
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

create table "vTaxCalculationBasisOptions" (
  "Code" text,
  "Name" text
);

create table "vTaxCalculationFrequency" (
  "Code" text,
  "Name" text
);

create table "vTemplate" (
  "TemplateID" text,  -- -> Template
  "Name" text,
  "Type" text,
  "Process" text
);

create table "vTenant" (
  "TenantID" text,  -- -> Tenant
  "Company" text,
  "Comment" text,
  "Currency" text,
  "DefaultTaxationRule" text,
  "EmailSender" text,
  "DocumentSortOrder" text,
  "PurchaseDocumentSortOrder" text,
  "CustomerCreditLimitMode" text,
  "DiscountCalculationMethod" text,
  "RecurringInvoicePriceHandlingMethod" text,
  "AutomaticallyApplyDiscounts" boolean,
  "ApplyManualPriceChanges" boolean,
  "ApplyCustomerDiscountAfterOtherDiscounts" boolean,
  "DefaultPurchaseMethod" text,
  "TaxCalculationMethod" text,
  "SearchOnlySupplierAttachedProductsInPurchaseLines" boolean,
  "SkuAutogeneration" boolean,
  "StockChanged" boolean,
  "StockPrefix" text,
  "StockNextNumber" text,
  "StockSuffix" text,
  "ServiceChanged" boolean,
  "ServicePrefix" text,
  "ServiceNextNumber" text,
  "ServiceSuffix" text,
  "FixedAssetChanged" boolean,
  "FixedAssetPrefix" text,
  "FixedAssetNextNumber" text,
  "FixedAssetSuffix" text,
  "POChanged" boolean,
  "POPrefix" text,
  "PONextNumber" text,
  "POSuffix" text,
  "INVChanged" boolean,
  "INVPrefix" text,
  "INVNextNumber" text,
  "INVSuffix" text,
  "SOChanged" boolean,
  "SOPrefix" text,
  "SONextNumber" text,
  "SOSuffix" text,
  "JobChanged" boolean,
  "JobPrefix" text,
  "JobNextNumber" text,
  "JobSuffix" text,
  "CRChanged" boolean,
  "CRPrefix" text,
  "CRNextNumber" text,
  "CRSuffix" text,
  "STChanged" boolean,
  "STPrefix" text,
  "STNextNumber" text,
  "STSuffix" text,
  "TRChanged" boolean,
  "TRPrefix" text,
  "TRNextNumber" text,
  "TRSuffix" text,
  "FGChanged" boolean,
  "FGPrefix" text,
  "FGNextNumber" text,
  "FGSuffix" text,
  "FOChanged" boolean,
  "FOPrefix" text,
  "FONextNumber" text,
  "FOSuffix" text,
  "MOChanged" boolean,
  "MOPrefix" text,
  "MONextNumber" text,
  "MOSuffix" text,
  "WRNChanged" boolean,
  "WRNPrefix" text,
  "WRNNextNumber" text,
  "WRNSuffix" text,
  "RMAChanged" boolean,
  "RMAPrefix" text,
  "RMANextNumber" text,
  "RMASuffix" text,
  "MRPChanged" boolean,
  "MRPPrefix" text,
  "MRPNextNumber" text,
  "MRPSuffix" text,
  "MRPProductionDate" text,
  "ECRChanged" boolean,
  "ECRPrefix" text,
  "ECRNextNumber" text,
  "ECRSuffix" text,
  "RMAReturnOrderChanged" boolean,
  "RMAReturnOrderPrefix" text,
  "RMAReturnOrderNextNumber" text,
  "RMAReturnOrderSuffix" text,
  "OpenDetailsInNewTabs" boolean,
  "PickFromAllLocations" boolean,
  "PriceTierName1" text,
  "PriceTierName2" text,
  "PriceTierName3" text,
  "PriceTierName4" text,
  "PriceTierName5" text,
  "PriceTierName6" text,
  "PriceTierName7" text,
  "PriceTierName8" text,
  "PriceTierName9" text,
  "PriceTierName10" text,
  "DateFormat" text,
  "TimeZone" text,
  "UseLatestPurchaseCost" boolean,
  "SkipQuote" boolean,
  "AutoPick" boolean,
  "SkipPack" boolean,
  "SkipShip" boolean,
  "HeadersVisible" boolean,
  "EnableChat" boolean,
  "AddEmailSenderToCC" boolean,
  "FillInvoiceDateOnOrderAuthorisation" text,
  "FillInvoiceDateOption" text,
  "RequestMailReceipt" boolean,
  "GlobalBcc" text,
  "InvoiceNumberTimePoint" text,
  "DecimalPlacesInQuantity" text,
  "ReorderMode" text,
  "DefaultShipDate" text,
  "ExportEncoding" text,
  "HasTransactions" boolean,
  "FinancialYearEndMonth" integer,
  "FinancialYearEndDay" integer,
  "TaxNumber" text,
  "TaxNumberDisplayName" text,
  "TaxCalculationBasis" text,
  "TaxPeriod" text,
  "LockDate" text,
  "ReverseCurrentYearDepreciationWhenAssetsAreSold" boolean,
  "ShowInvoiceBeforeFulfillment" boolean,
  "AllowOrderNoAlloc" boolean,
  "PurchaseAttributeSet" text,
  "PurchaseAttributeSetCopyFrom" text,
  "SaleAttributeSet" text,
  "SaleAttributeSetCopyFrom" text,
  "IsSupportMultilingual" boolean,
  "InventoryAccrual" boolean,
  "InventoryAccrualAccount" text,
  "DefaultDimensionsUnits" text,
  "DefaultWeightUnits" text,
  "StockInTransitAccount" text,
  "IsGiftCardEnabled" boolean,
  "GiftCardAccount" text,
  "CanGiftCardExpire" boolean,
  "DefaultGiftCardExpirationPeriod" text,
  "CanGiftCardRefund" boolean,
  "UsePurchasePutAway" boolean,
  "AllowChargeToCardOnFile" boolean,
  "CanEditCardOnFileSetting" boolean,
  "CountrySpecificKey" text,
  "CountrySpecificData" text,
  "RoundingTableChanged" boolean,
  "IsTFAEnabled" boolean,
  "PasswordChangeFrequency" integer,
  "SaleQuoteArchivePeriod" integer,
  "PurchaseOrderArchivePeriod" integer,
  "DefaultQuantity" integer,
  "CreditHoldGracePeriod" integer,
  "AllowQuoteApproval" boolean,
  "AllowPurchaseOrderApproval" boolean,
  "AllowArchiving" boolean,
  "TooltipSections" text,
  "IsDefaultAdvancedPurchase" boolean,
  "IsDefaultAdvancedSale" boolean,
  "AddExistingAttachmentsIntoTheEmail" boolean,
  "MOIsStockTransferAuto" boolean,
  "MOIsPurchaseOrderAuto" boolean,
  "MOIsNestedOrderAuto" boolean,
  "MOIsFinishedGoodsAuto" boolean,
  "MOCreateProductionOrderStatus" text,
  "MOCreateProductionOrder" text,
  "MOProduce" text,
  "FGProduce" text,
  "MOComponentDescriptionSource" text,
  "MOWastageType" text,
  "MOCoManType" text,
  "MOWastageExpenseAccount" text,
  "MOAttributeSet" text,
  "MORunOutputAttributeSet" text,
  "MORunOperationAttributeSet" text,
  "OpportunityChanged" boolean,
  "OpportunityPrefix" text,
  "OpportunityNextNumber" text,
  "OpportunitySuffix" text,
  "EnableOpportunityApproval" boolean,
  "MOTransferFinishedProduct" integer,
  "MOTraceFinishedProduct" integer,
  "MODocumentSortOrder" text,
  "MOBackdatedTransaction" boolean,
  "ChartOfAccountsType" text,
  "ChartOfAccountsTreeDelimiter" text,
  "UnrealizedForeignCurrency" boolean,
  "CarryForward" boolean,
  "IsAccountingDimensionsEnabled" boolean,
  "AccountingDimensionsPriorityMode" text,
  "UseCurrentUserAsSaleRep" boolean,
  "UpdateStockReceivedDateOnLocationTransfer" boolean,
  "RecommendBatchSN" numeric,
  "IgnoreExpiredBatch" boolean,
  "ChatGptPromptForEmptyDescription" text,
  "ChatGptPromptForExistingDescription" text,
  "SplitAutoAssembly" boolean,
  "SessionTimeout" integer
);

create table "vTenantHoliday" (
  "HolidayID" text,  -- -> Holiday
  "Date" timestamptz,
  "Description" text,
  "Skip" boolean
);

create table "vTenantTaskSettings" (
  "TenantID" text,  -- -> Tenant
  "IsActive" boolean,
  "ApprovalEnabled" boolean,
  "FirstDayOfWeek" integer,
  "WeekendDays" text
);

create table "vTenantUser" (
  "TenantID" text,  -- -> Tenant
  "UserId" text,  -- -> User
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

create table "vTenantUserPageAccessEdit" (
  "RoleID" text,  -- -> Role
  "UserID" text,  -- -> User
  "PageID" text,  -- -> Page
  "Category" text,
  "DisplayName" text,
  "AllowReadOnly" boolean,
  "ReadOnlyAccess" boolean,
  "FullAccess" boolean,
  "CategoryPosition" integer,
  "Position" integer,
  "ValidationText" text,
  "ValidationState" text
);

create table "vTenants" (
  "UserID" text,  -- -> User
  "TenantID" text,  -- -> Tenant
  "Company" text,
  "MasterUserEmail" text,
  "Status" text,
  "IsExpired" boolean,
  "ExpirationDate" timestamptz,
  "IsTFAEnabled" boolean,
  "AnniversaryDate" timestamptz,
  "StartDate" timestamptz,
  "PlanType" text
);

create table "vTimezone" (
  "name" text,
  "displayName" text
);

create table "vUserData" (
  "UserID" text,  -- -> User
  "UserName" text,
  "DisplayName" text,
  "IsTFAEnabled" boolean,
  "AnyCompanyWithTFA" boolean,
  "IsTFASetupCompleted" boolean,
  "TFAAlternativeMethod" text,
  "TFAAlternativeEmail" text,
  "TFAQuestion1" text,
  "TFAQuestion2" text,
  "TFAQuestion3" text
);

create table "vUserLoginHistory" (
  "ID" text,
  "UserID" text,  -- -> User
  "IPAddress" text,
  "Country" text,
  "SysDate" timestamptz,
  "State" text,
  "TenantID" text,  -- -> Tenant
  "Company" text
);

create table "vUserPasskey" (
  "ID" text,
  "FriendlyName" text,
  "CreatedAt" timestamptz,
  "LastUsedAt" timestamptz
);

create table "vWorkflow" (
  "WorkflowID" text,  -- -> Workflow
  "Name" text,
  "IsActive" boolean,
  "EntityType" text,
  "DueDaysType" text,
  "ActiveProcessCount" integer,
  "ValidationText" text,
  "ValidationState" text
);

create table "vWorkflowList" (
  "WorkflowID" text,  -- -> Workflow
  "Name" text,
  "DueDaysType" text,
  "IsActive" boolean,
  "ActiveProcessCount" integer
);

create table "vWorkflowProcess" (
  "WorkflowProcessID" text,  -- -> WorkflowProcess
  "CreatedDate" timestamptz,
  "EntityName" text,
  "EntityID" text,  -- -> Entity (polymorphic)
  "EntityType" text,
  "Notes" text,
  "CompletedTaskCount" integer,
  "AllTaskCount" integer
);

create table "vWorkflowStep" (
  "WorkflowStepID" text,  -- -> WorkflowStep
  "Name" text,
  "WorkflowID" text,  -- -> Workflow
  "Sequence" integer,
  "Days" integer,
  "StartTimeStr" text,
  "EndTimeStr" text,
  "TaskCategoryName" text,
  "TaskCategoryID" text,  -- -> TaskCategory
  "UserName" text,
  "UserID" text,  -- -> User
  "SkipHoliday" text,
  "ValidationText" text,
  "ValidationState" text
);
