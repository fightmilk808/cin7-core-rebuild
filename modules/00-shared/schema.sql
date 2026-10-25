-- Shared Cin7 Core data models, generated from data/models.json

create table "AccessInfo" (
  "TenantID" text,  -- -> Tenant
  "UserID" text,  -- -> User
  "Access" text,
  "Subscription" text,
  "SubscriptionCategory" text,
  "AvailablePriceTiers" integer,
  "ImpersonatedUserName" text,
  "ImpersonatedTenantID" text,  -- -> ImpersonatedTenant
  "UserName" text,
  "FailedPaymentID" text,  -- -> FailedPayment
  "Xero" boolean,
  "Quickbooks" boolean,
  "Connected" boolean,
  "Organisation" text,
  "Currency" text,
  "Company" text,
  "NotificationText" text,
  "DateFormat" text,
  "OpenDetailsInNewTabs" boolean,
  "ValidSession" boolean,
  "EnableFinancials" boolean,
  "ForceLogOff" boolean,
  "Locale" text,
  "ProductImageUrl" text,
  "ProductFamilyImageUrl" text,
  "DaysRemaining" integer,
  "GettingStartedGuideLink" text,
  "Country" text,
  "CountrySpecificKey" text,
  "EnableChat" boolean,
  "TaskModule_IsEnable" boolean,
  "TaskModule_AllTasks" text,
  "TaskModule_CanAssignTasks" text,
  "TaskModule_CanBeAssigned" text,
  "TaskModule_Management" text,
  "TaskModule_DateFormat" text,
  "NotificationCount" integer,
  "DisplayName" text,
  "TenantLockDate" timestamptz,
  "FinancialYearEndMonth" integer,
  "FinancialYearEndDay" integer,
  "IsActive" boolean,
  "IsPaymentGatewayEnabled" boolean,
  "IsCin7PayEnabled" boolean,
  "OnBoarding" boolean,
  "ChartOfAccountsDelimiter" text,
  "ChartOfAccountsDelimiterPlaceholder" text,
  "ChartOfAccountsDotPlaceholder" text,
  "ChartOfAccountsType" text,
  "AccountingDimensionsPriorityMode" text,
  "CreateNewAccountUrl" text,
  "CreateNewOrganizationUrl" text,
  "SessionTimeout" integer,
  "InventoroEnabled" boolean,
  "InventoroSettingsEnabled" boolean,
  "RevenueheroScriptUrl" text,
  "ZendeskWidgetKey" text,
  "IsApproved" boolean,
  "DemoDataGeneratorEnabled" boolean,
  "ShowUpdateAddressWarning" boolean,
  "DuePaymentDate" text,
  "IsNewUIAvailable" boolean,
  "SalesPercentageUsage" integer,
  "QBOConnectionExpirationStatus" integer,
  "QBOConnectionExpirationRemainingDays" integer
);

create table "ActivityLogLine" (
  "Date" timestamptz,
  "Category" text,
  "ID" text,
  "TaskID" text,  -- -> Task (any document)
  "Total" integer,
  "Message" text,
  "Reference" text,
  "UserName" text
);

create table "AddressInfo" (
  "description" text,
  "place_id" text,
  "terms" jsonb
);

create table "AutoPick" (
  "ProductID" text,  -- -> Product
  "BinID" text,  -- -> Bin
  "BinName" text,
  "ProductCode" text,
  "Name" text,
  "Available" numeric,
  "Quantity" numeric,
  "Cost" numeric,
  "CostingMethod" text,
  "BatchSN" text,
  "ExpiryDate" timestamptz,
  "Unit" text,
  "IsFirst" boolean
);

create table "BankFeeAndMoneyTaskAdjustmentModel" (
  "ID" text,
  "To" text,
  "Description" text,
  "AccountCode" text,
  "TaxRate" text,
  "Amount" numeric,
  "TransactionType" text
);

create table "CostingMethod" (
  "CostingMethod" text,
  "DisplayName" text
);

create table "Country" (
  "Code" text,
  "Name" text
);

create table "Currency" (
  "Code" text,
  "Name" text
);

create table "DeliveryItem" (
  "DeliveryItemID" text,  -- -> DeliveryItem
  "ProductID" text,  -- -> Product
  "Quantity" numeric,
  "ProductName" text,
  "ProductCode" text,
  "TaskID" text,  -- -> Task (any document)
  "TaskStatus" text,
  "DeliveryNumber" text,
  "ProductSearch" text,
  "DeliveryDateStr" text
);

create table "DropShipMode" (
  "DropShipMode" text,
  "DisplayName" text
);

create table "Ext.grid.property.Property" (
  "name" text,
  "value" text
);

create table "Family" (
  "ID" text,
  "Name" text,
  "Option1Name" text,
  "Option1Values" text,
  "Option2Name" text,
  "Option2Values" text,
  "Option3Name" text,
  "Option3Values" text
);

create table "History" (
  "EntryID" text,  -- -> Entry
  "ColumnsChanged" text,
  "DateChanged" timestamptz,
  "ChangedBy" text
);

create table "Integrate" (
  "Code" text,
  "Name" text
);

create table "LocationsSettingsModel" (
  "LocationID" text,  -- -> Location
  "LocationName" text,
  "Level" integer,
  "ParentID" text,  -- -> Parent
  "IsActive" boolean
);

create table "MappingReferenceData" (
  "ID" text,
  "HasHeaderRow" boolean,
  "DemoRowsCount" integer,
  "SignatureHashFound" boolean,
  "SignatureHash" text
);

create table "MinorAdjustmentModel" (
  "ID" text,
  "Amount" numeric
);

create table "NotificationModel" (
  "Id" text,
  "Type" text,
  "Notification" text,
  "References" text,
  "ConfirmToDelete" boolean
);

create table "PartnerAccessInfo" (
  "ImpersonatedUserName" text,
  "UserName" text,
  "Company" text,
  "DisplayName" text,
  "TenantID" text  -- -> Tenant
);

create table "PhoneCountryCode" (
  "ID" text,
  "CountryCode" text,
  "Code2" text,
  "PhoneAreaCode" text,
  "EnableOnlyEmailVerification" boolean,
  "Name" text,
  "SortPriority" integer,
  "FullName" text,
  "FullCode" text
);

create table "Product" (
  "ProductID" text,  -- -> Product
  "Code" text,
  "Name" text,
  "Unit" text,
  "SupplierInventoryCode" text,
  "Cost" numeric,
  "CostingMethod" text,
  "Account" text,
  "Type" text,
  "TaxRule" text,
  "BinID" text,  -- -> Bin
  "NonInventory" boolean
);

create table "ProductWithAttachments" (
  "Name" text,
  "Id" text
);

create table "ProductsAffectedProductsModel" (
  "Location" text,
  "ProductCode" text,
  "ProductName" text
);

create table "ProductsRulesModel" (
  "ProductRuleID" text,  -- -> ProductRule
  "CustomFilterID" text,  -- -> CustomFilter
  "Name" text,
  "Priority" integer,
  "CriteriaSummary" text,
  "AffectedProductsCount" jsonb
);

create table "ProductsSettingsModel" (
  "Selected" boolean,
  "IsActive" boolean,
  "DefaultIsActive" boolean,
  "ProductID" text,  -- -> Product
  "LocationID" text,  -- -> Location
  "ProductCode" text,
  "ProductName" text,
  "Category" text,
  "Brand" text,
  "ProductUnit" text,
  "Available" numeric,
  "LocationName" text,
  "SupplierName" text,
  "Lead" integer,
  "DefaultLeadTime" integer,
  "SoldLast1Month" numeric,
  "SoldLast3Months" numeric,
  "SoldLast6Months" numeric,
  "SoldLast12Months" numeric,
  "Segment" text,
  "SettingID" text,  -- -> Setting
  "MinimumOrderQuantity" numeric,
  "Packing" numeric,
  "CanBeOrdered" boolean,
  "MinimumStockQuantity" numeric,
  "MaximumStockQuantity" numeric,
  "MaximumStockDays" integer,
  "OrderPeriod" integer,
  "DefaultOrderPeriod" integer,
  "DefaultReplenishedBy" text,
  "PredecessorProductCode" text,
  "PredecessorProductName" text,
  "PredecessorProductID" text,  -- -> PredecessorProduct
  "IsPredecessorSet" boolean,
  "ReplenishmentRecommendations" text,
  "ReplenishedBy" text,
  "RedistributionLocations" jsonb,
  "RuleLeadTime" integer,
  "RuleOrderPeriod" integer,
  "RuleMinimumOrderQuantity" numeric,
  "RulePacking" numeric,
  "RuleMinimumStockQuantity" numeric,
  "RuleMaximumStockQuantity" numeric,
  "RuleMaximumStockDays" integer,
  "RuleCanBeOrdered" boolean,
  "RuleIsActive" boolean,
  "RulePredecessorProductID" text,  -- -> RulePredecessorProduct
  "RulePredecessorProductCode" text,
  "RulePredecessorProductName" text,
  "RuleReplenishmentRecommendations" text,
  "RuleReplenishedBy" text
);

create table "ReferenceDataWrapper" (
  "ID" integer,
  "Permission" text,
  "CustomerOnCreditHoldPermission" text,
  "DefaultTaxRule" text,
  "IsAccountingDimensionsEnabled" boolean,
  "DimensionsPermission" text
);

create table "ReportTemplate" (
  "TemplateID" text,  -- -> Template
  "Type" text,
  "Name" text
);

create table "ScanProduct" (
  "ProductID" text,  -- -> Product
  "Barcode" text,
  "CostingMethod" text,
  "Name" text,
  "SKU" text,
  "SupplierSKU" text,
  "UOM" text,
  "InventoryAccount" text,
  "COGSAccount" text,
  "TaxRule" text,
  "Price" numeric,
  "BinID" text,  -- -> Bin
  "NonInventory" boolean
);

create table "SelectedList" (
  "CustomerID" text,  -- -> Customer
  "Name" text
);

create table "SkuAutogenerationFlagModel" (
  "Value" boolean
);

create table "Tag" (
  "Value" text
);

create table "Tags" (
  "Value" text
);

create table "TimeZone" (
  "name" text,
  "displayName" text,
  "offset" text
);

create table "TransactionModel" (
  "TransactionID" text,  -- -> Transaction
  "BankStatementID" text,  -- -> BankStatement
  "TenantID" text,  -- -> Tenant
  "Date" timestamptz,
  "Reference" text,
  "PaymentReference" text,
  "Description" text,
  "Status" text,
  "Amount" numeric,
  "AccountCode" text,
  "Selected" boolean
);

create table "WorkflowHistory" (
  "WorkflowHistoryID" text,  -- -> WorkflowHistory
  "WorkflowID" text,  -- -> Workflow
  "EntityID" text,  -- -> Entity (polymorphic)
  "EntityType" text,
  "ChildEntityID" text,  -- -> ChildEntity
  "ChildEntityType" text,
  "Name" text,
  "Description" text,
  "State" text,
  "DateUtc" timestamptz,
  "WorkflowName" text,
  "EventName" text
);

create table "XeroLink" (
  "ID" text,
  "Type" text,
  "TaskID" text  -- -> Task (any document)
);

create table "stripePaymentLogEntry" (
  "Id" text,
  "SaleTaskId" text,  -- -> Sale
  "Amount" numeric,
  "AccountCode" text,
  "AccountName" text,
  "Currency" text,
  "SaleInvoiceNumber" text,
  "StatusText" text,
  "StripePaymentId" text,  -- -> StripePayment
  "IsTestMode" boolean,
  "InitTime" timestamptz,
  "LastUpdateTime" timestamptz
);

create table "vAccountingDimensionsRealTemp" (
  "EntityType" text,
  "AccountCode" text,
  "AccountName" text,
  "ReferenceNumber" text,
  "Amount" numeric,
  "EffectiveDate" timestamptz,
  "ProductID" text,  -- -> Product
  "ProductCode" text,
  "ProductName" text,
  "CustomerID" text,  -- -> Customer
  "CustomerName" text,
  "SupplierID" text,  -- -> Supplier
  "SupplierName" text,
  "ExpenseItem" text,
  "ProductionResource" text,
  "CompanyContact" text
);

create table "vAvailableCompanies" (
  "TenantID" text,  -- -> Tenant
  "UserName" text,
  "Company" text,
  "IsExpired" boolean
);

create table "vBalanceInfo" (
  "ID" text,
  "BalanceInDearTxt" text,
  "StatementBalanceTxt" text,
  "LastDate" text
);

create table "vBankStatement" (
  "StatementID" text,  -- -> Statement
  "ImportedDate" timestamptz,
  "StartDate" timestamptz,
  "EndDate" timestamptz,
  "Status" text,
  "OpenBalance" numeric,
  "DeltaBalance" numeric,
  "CloseBalance" numeric
);

create table "vBankTransactionMappingProfile" (
  "ProfileID" text,  -- -> Profile
  "Name" text,
  "Data" text,
  "DateFormat" text,
  "Hash" text
);

create table "vChartOfAccounts" (
  "Code" text,
  "OldCode" text,
  "Status" text,
  "Name" text,
  "Type" text,
  "TaxType" text,
  "Description" text,
  "Class" text,
  "SystemAccount" text,
  "BankAccountNumber" text,
  "CurrencyCode" text,
  "BankAccountId" text,  -- -> BankAccount
  "ForPayments" boolean
);

create table "vCustomer" (
  "CustomerID" text,  -- -> Customer
  "Name" text
);

create table "vCustomerWithSupplier" (
  "ID" text,
  "Name" text,
  "DefaultTaxRule" text,
  "DefaultAccount" text,
  "Type" text
);

create table "vDeliveryNote" (
  "TaskID" text,  -- -> Task (any document)
  "Note" text,
  "UserName" text,
  "DateTime" timestamptz
);

create table "vDiscount" (
  "ID" text,
  "Name" text,
  "Type" text
);

create table "vFilterBarcode" (
  "Name" text
);

create table "vFilterProduct" (
  "ID" text,
  "Name" text,
  "ProductCode" text
);

create table "vFixedAssetType" (
  "FixedAssetTypeID" text,  -- -> FixedAssetType
  "Name" text
);

create table "vMappingSettings" (
  "Source" text,
  "Data" text,
  "Target" text
);

create table "vMoneyTaskTenantTaxationRule" (
  "RuleID" text,  -- -> Rule (context-specific)
  "Description" text,
  "EffectivePercentExclusive" numeric,
  "EffectivePercentInclusive" numeric,
  "EffectivePercent" numeric,
  "Inclusive" boolean
);

create table "vMultilingualTemplateDatas" (
  "TemplateCode" text,
  "TemplateName" text,
  "FieldName" text,
  "Text" text
);

create table "vMultilingualTemplateNewDatas" (
  "Code" text,
  "Name" text,
  "IsDefault" boolean
);

create table "vProduct" (
  "ProductID" text,  -- -> Product
  "SkuAutogenerationFlag" boolean,
  "ProductCode" text,
  "Name" text,
  "Category" text,
  "Type" text,
  "DefaultUnitOfMeasure" text,
  "CostingMethod" text,
  "ExpenseAccount" text,
  "MinimumBeforeReorder" numeric,
  "ReorderQuantity" numeric,
  "QuantityToProduce" numeric,
  "ProductAttributeSet" text,
  "Barcode" text,
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
  "Status" text,
  "StockLocator" text,
  "DropShipMode" text,
  "PurchaseTaxRule" text,
  "SaleTaxRule" text,
  "FixedAssetTypeID" text,  -- -> FixedAssetType
  "BrandID" text,  -- -> Brand
  "DiscountID" text,  -- -> Discount
  "DefaultLocation" text,
  "NotSellable" text
);

create table "vProductAlternativeStock" (
  "FakeID" text,
  "ProductID" text,  -- -> Product
  "ProductCode" text,
  "ProductName" text,
  "LocationName" text,
  "Price" numeric,
  "OnHand" numeric,
  "Available" numeric,
  "OnOrder" numeric,
  "Allocated" numeric,
  "RequiredQuantityKoeff" numeric
);

create table "vProductFamily" (
  "ID" text,
  "Name" text
);

create table "vRecStatement" (
  "ID" text,
  "Name" text
);

create table "vReconcilation" (
  "ReconcileID" text,  -- -> Reconcile
  "AccountID" text,  -- -> Account
  "BankStatementID" text,  -- -> BankStatement
  "TransactionID" text,  -- -> Transaction
  "Date" timestamptz,
  "Reference" text,
  "PaymentReference" text,
  "Description" text,
  "Amount" numeric,
  "Contractor" text,
  "AccountCode" text,
  "Currency" text,
  "CurrencyConversionRate" numeric,
  "MatchFound" boolean,
  "Comment" text,
  "LinkObjectName" text,
  "LineID" text,  -- -> Line (parent document's line)
  "SaleTaskID" text,  -- -> Sale
  "PurchaseTaskID" text,  -- -> Purchase
  "MoneyTaskID" text,  -- -> MoneyTask
  "ExpenseClaimTaskID" text,  -- -> ExpenseClaimTask
  "MapCount" numeric,
  "ReconciledAmount" numeric,
  "AdditionalData" text,
  "DocDate" timestamptz,
  "DocPerson" text,
  "DocCurrency" text,
  "DocReference" text,
  "DocDescription" text,
  "DocCurrencyConversionRate" numeric,
  "BankRuleID" text,  -- -> BankRule
  "BankRuleName" text,
  "BankRuleContactID" text,  -- -> BankRuleContact
  "BankRuleSearchDisabled" boolean,
  "BankRuleContactName" text,
  "BankRuleContactType" text
);

create table "vReconcilationMatchList" (
  "ID" text,
  "TaskID" text,  -- -> Task (any document)
  "EffectiveDate" timestamptz,
  "ObjType" text,
  "Type" text,
  "Description" text,
  "Reference" text,
  "Amount" numeric,
  "CurrencyConversionRate" numeric,
  "Currency" text,
  "Payee" text,
  "Reserved" text,
  "ReservedInternal" numeric,
  "ReservedInternal2" numeric,
  "Split" integer,
  "Selected" boolean
);

create table "vRelatedOrder" (
  "TaskID" text,  -- -> Task (any document)
  "TaskType" text,
  "TaskTypeName" text,
  "TaskNumber" text,
  "OrderDate" timestamptz,
  "Status" text,
  "TotalAmount" numeric,
  "TotalCountRows" integer
);

create table "vRelatedOrderDetails" (
  "ProductID" text,  -- -> Product
  "ProductCode" text,
  "Name" text,
  "Quantity" numeric,
  "Unit" text
);

create table "vSale_Customer" (
  "CustomerID" text,  -- -> Customer
  "Name" text
);

create table "vSalesPriceTier" (
  "Code" integer,
  "Name" text
);

create table "vStandardEntity" (
  "ID" text,
  "Name" text
);

create table "vStockTransferList" (
  "TaskID" text,  -- -> Task (any document)
  "Date" timestamptz,
  "From" text,
  "To" text,
  "Status" text,
  "Number" text,
  "LastUpdatedBy" text,
  "CustomerReference" text,
  "IsFBA" boolean
);

create table "vSupplier" (
  "SupplierID" text,  -- -> Supplier
  "Name" text,
  "Currency" text,
  "PaymentTerm" text,
  "TaxRule" text,
  "DefaultPaymentMethod" text,
  "DefaultCarrier" text,
  "AccountCode" text,
  "Comments" text,
  "TaxNumber" text,
  "IsActive" boolean,
  "Discount" numeric,
  "CountrySpecificKey" text,
  "CountrySpecificData" text,
  "AttributeSet" text
);

create table "vSyncHistory" (
  "EntryID" text,  -- -> Entry
  "DateCreated" timestamptz,
  "Status" integer,
  "Error" text,
  "Description" text,
  "QBID" text,  -- -> QB
  "Entity" integer,
  "IsConsolidated" boolean,
  "IsSelected" boolean
);

create table "vTag" (
  "Value" text
);

create table "vTask" (
  "TaskID" text,  -- -> Task (any document)
  "TenantID" text,  -- -> Tenant
  "UserID" text,  -- -> User
  "TaskCategoryID" text,  -- -> TaskCategory
  "IsCategoryPredefined" text,
  "Name" text,
  "Details" text,
  "StartDate" timestamptz,
  "EndDate" timestamptz,
  "CompletedDate" timestamptz,
  "Sequence" integer,
  "WorkflowID" text,  -- -> Workflow
  "UserName" text,
  "TaskCategoryName" text,
  "TaskCategoryColor" text,
  "WorkflowName" text,
  "IsToday" boolean,
  "IsOverdue" boolean,
  "IsCompleted" boolean,
  "WorkflowProcessID" text,  -- -> WorkflowProcess
  "IsAllDay" boolean,
  "EntityID" text,  -- -> Entity (polymorphic)
  "EntityType" text,
  "EntityName" text,
  "MasterEntityID" text,  -- -> MasterEntity
  "IsOwner" boolean,
  "WorkflowProcessState" text,
  "ValidationText" text
);

create table "vTaskFile" (
  "FileID" text,  -- -> Blob (stored file)
  "TaskID" text,  -- -> Task (any document)
  "FileName" text,
  "ContentType" text,
  "UserName" text,
  "UploadedDate" timestamptz,
  "ExternalDownloadLink" text,
  "ExternalViewLink" text
);

create table "vTenantAttributeSet" (
  "SetID" text,  -- -> AttributeSet
  "Name" text,
  "Column1" text,
  "Column2" text,
  "Column3" text,
  "Column4" text,
  "Column5" text,
  "Column6" text,
  "Column7" text,
  "Column8" text,
  "Column9" text,
  "Column10" text
);

create table "vTenantBrand" (
  "ID" text,
  "Brand" text
);

create table "vTenantCarrier" (
  "CarrierID" text,  -- -> Carrier
  "Description" text
);

create table "vTenantContact" (
  "ContactID" text,  -- -> Contact
  "Name" text,
  "Email" text,
  "DefaultForType" boolean,
  "Type" text
);

create table "vTenantCurrency" (
  "CurrencyID" text,  -- -> Currency
  "Currency" text,
  "Default" boolean,
  "Name" text
);

create table "vTenantInventoryCategory" (
  "CategoryID" text,  -- -> ProductCategory
  "Category" text
);

create table "vTenantLocation" (
  "LocationID" text,  -- -> Location
  "Description" text,
  "IsDefault" boolean
);

create table "vTenantPaymentTerm" (
  "TermID" text,  -- -> PaymentTerm
  "Name" text,
  "Days" integer,
  "Method" integer,
  "DueNextMonth" integer
);

create table "vTenantTaxationRule" (
  "RuleID" text,  -- -> Rule (context-specific)
  "Description" text,
  "EffectivePercentExclusive" numeric,
  "EffectivePercentInclusive" numeric,
  "EffectivePercent" numeric,
  "Inclusive" boolean
);

create table "vTenantUnitOfMeasure" (
  "UnitOfMeasureID" text,  -- -> UnitOfMeasure
  "Unit" text
);

create table "vTermsMethod" (
  "ID" integer,
  "Name" text
);

create table "vTransaction" (
  "ID" text,
  "Debit" text,
  "DocRef" text,
  "Credit" text,
  "Amount" numeric,
  "EffectiveDate" timestamptz
);
