-- Financials: one table per Cin7 Core data model, generated from data/models.json

create table "AccessPermission" (
  "Name" text,
  "Title" text
);

create table "Cin7PayWrapper" (
  "AccuralAccountCode" text,
  "BankAccountCode" text,
  "PaymentFeeAccountCode" text,
  "SurchargeAccountCode" text,
  "LoanLiabilityAccountCode" text,
  "FinancingFeeAccountCode" text,
  "IsB2BPortal" boolean,
  "PayByInvoice" boolean,
  "PayWithSales" boolean,
  "CardOnFile" boolean,
  "IsSurchargeEnabled" boolean,
  "Status" text,
  "IsMerchantReceiptNotificationEnabled" boolean,
  "IsCustomerReceiptNotificationEnabled" boolean,
  "IsMerchantRefundNotificationEnabled" boolean,
  "MerchantNotificationEmail" text,
  "AdditionalNotificationEmails" text
);

create table "DepreciationTask" (
  "TaskID" text,  -- -> Task (any document)
  "Status" text,
  "StartDate" timestamptz,
  "EndDate" timestamptz,
  "CreatedDate" timestamptz,
  "TotalItems" numeric,
  "TotalAmount" numeric
);

create table "DepreciationTaskLine" (
  "TaskID" text,  -- -> Task (any document)
  "LineID" text,  -- -> Line (parent document's line)
  "InventoryCardID" text,  -- -> InventoryCard
  "FixedAssetName" text,
  "SerialNumber" text,
  "AccumulatedDepreciationAccountName" text,
  "DepreciationExpenseAccountName" text,
  "Amount" numeric
);

create table "ECommerceShop" (
  "ConfigID" text,  -- -> IntegrationConfig
  "ShopName" text
);

create table "ExpenseClaimReceiptReferenceData" (
  "ID" integer,
  "ExpenseClaimReceiptCreationPermission" text,
  "ExpenseClaimApprovePermission" text,
  "ExpenseClaimCreatePaymentPermission" text,
  "ExpenseClaimUndoVoidPermission" text,
  "ProductFamilyCount" integer,
  "DefaultAccount" text,
  "TaxCalculationMethod" text,
  "HeadersVisible" text,
  "TenantCurrency" text
);

create table "ExpenseClaimReceiptTask" (
  "TaskID" text,  -- -> Task (any document)
  "ReceiptNumber" text,
  "SupplierID" text,  -- -> Supplier
  "SupplierName" text,
  "Currency" text,
  "Date" timestamptz,
  "Reference" text,
  "Tax" numeric,
  "TotalAmount" numeric,
  "CurrencyConversionRate" numeric,
  "ItemsNumber" integer,
  "TaxPercent" numeric,
  "TaxInclusive" boolean,
  "Status" text,
  "TaxSchema" text,
  "DefaultAccount" text,
  "Employee" text,
  "CreatedDate" timestamptz,
  "CreatedBy" text,
  "LastUpdatedDate" timestamptz,
  "LastUpdatedBy" text,
  "ValidationText" text,
  "ValidationState" text
);

create table "ExpenseClaimReceiptTaskWrapper" (
  "ID" text,
  "ClientDateTime" timestamptz,
  "HasErrors" boolean
);

create table "ExpenseClaimReferenceData" (
  "ID" integer,
  "ExpenseClaimReceiptCreationPermission" text,
  "ExpenseClaimApprovePermission" text,
  "ExpenseClaimCreatePaymentPermission" text,
  "ExpenseClaimUndoVoidPermission" text,
  "ExpenseClaimIsReconciled" boolean,
  "ProductFamilyCount" integer,
  "DefaultAccount" text,
  "TaxCalculationMethod" text,
  "HeadersVisible" text
);

create table "ExpenseClaimTask" (
  "TaskID" text,  -- -> Task (any document)
  "DateSubmitted" timestamptz,
  "EffectiveDate" timestamptz,
  "PaymentDueDate" timestamptz,
  "MemoInternal" text,
  "ClaimTotalAmount" numeric,
  "ApprovedTotalAmount" numeric,
  "ReceiptsNumber" integer,
  "Status" text,
  "IsAuthorised" boolean,
  "Employee" text,
  "ValidationText" text,
  "ValidationState" text
);

create table "ExpenseClaimTaskWrapper" (
  "ID" text,
  "ClientDateTime" timestamptz,
  "HasErrors" boolean
);

create table "JournalWrapper" (
  "ID" integer,
  "HasErrors" boolean
);

create table "MoneyTaskReferenceData" (
  "ID" integer,
  "RevenueAccount" text,
  "ApprovePermission" text,
  "UndoPermission" text,
  "VoidPermission" text,
  "DefaultTaxRule" text
);

create table "MoneyTaskWrapper" (
  "ID" text,
  "ClientDateTime" timestamptz,
  "HasErrors" boolean
);

create table "MoneyTask_SearchProduct" (
  "ProductID" text,  -- -> Product
  "ProductCode" text,
  "Name" text,
  "Type" text,
  "Price" numeric,
  "DefaultTaxRule" text,
  "DefaultAccount" text
);

create table "PeriodModel" (
  "Period" text,
  "Name" text
);

create table "ReferenceData" (
  "ID" text
);

create table "Status" (
  "Value" text,
  "Name" text
);

create table "SupplierCustomerSelect" (
  "ID" text,
  "Name" text,
  "Type" text,
  "DisplayName" text
);

create table "vAccount" (
  "Code" text,
  "DisplayName" text
);

create table "vAccountClassTypes" (
  "Class" text
);

create table "vAccountStatusCode" (
  "Value" text,
  "Name" text
);

create table "vAccountTypesAndClasses" (
  "Description" text,
  "AccountType" text,
  "AccountClass" text,
  "IsFirst" boolean
);

create table "vAccountingDimensionAttribute" (
  "AttributeID" text,  -- -> Attribute
  "Name" text,
  "Type" text,
  "ListValues" text,
  "IsActive" boolean,
  "ValidationText" text,
  "ValidationState" text
);

create table "vBankAccount" (
  "AccountCode" text,
  "DisplayName" text
);

create table "vBankAccountToShow" (
  "AccountID" text,  -- -> Account
  "Bank" text,
  "AccountName" text,
  "AccountCode" text,
  "AccountNumber" text,
  "Currency" text,
  "StatementBalance" numeric,
  "BalanceInDear" numeric,
  "BalanceInDearInBankAccountCurrency" numeric,
  "InitialBalance" numeric,
  "LastDate" timestamptz,
  "TransactionCount" integer
);

create table "vBankRule" (
  "RuleID" text,  -- -> Rule (context-specific)
  "Description" text,
  "RuleName" text,
  "ConditionCase" text,
  "RunOnAccountID" text,  -- -> RunOnAccount
  "CustomerSupplierID" text,  -- -> CustomerSupplier
  "Active" boolean,
  "Priority" integer,
  "ReferenceField" text
);

create table "vBankRuleAccountMapping" (
  "AccountID" text,  -- -> Account
  "Selected" boolean,
  "AccountName" text,
  "Currency" text,
  "AccountCode" text
);

create table "vBankRuleChartOfAccounts" (
  "Code" text,
  "Status" text,
  "Name" text,
  "Type" text,
  "DisplayName" text,
  "Description" text,
  "Class" text,
  "ForPayments" boolean,
  "IsFirst" boolean
);

create table "vBankRuleContitionType" (
  "Name" text,
  "Value" text
);

create table "vBankRuleCustomerWithSupplier" (
  "ID" text,
  "Name" text,
  "DefaultTaxRule" text,
  "DefaultAccount" text,
  "Type" text
);

create table "vBankRuleFilter" (
  "ID" text,
  "Value" text,
  "FilterType" text,
  "IsSeparator" boolean,
  "AccountCode" text
);

create table "vBankRuleLine" (
  "LineID" text,  -- -> Line (parent document's line)
  "Name" text,
  "AccountCode" text,
  "TaxRule" text,
  "Amount" numeric
);

create table "vBankRuleListItem" (
  "RuleID" text,  -- -> Rule (context-specific)
  "Priority" integer,
  "Active" boolean,
  "RuleType" text,
  "Description" text,
  "RuleName" text,
  "AccountCode" text,
  "AccountName" text,
  "Selected" boolean
);

create table "vBankRulePriority" (
  "Name" text,
  "Value" integer
);

create table "vBankRuleTenantTaxationRule" (
  "RuleID" text,  -- -> Rule (context-specific)
  "Description" text,
  "EffectivePercentExclusive" numeric,
  "EffectivePercentInclusive" numeric,
  "EffectivePercent" numeric,
  "Inclusive" boolean
);

create table "vCardOnFileCustomers" (
  "Name" text,
  "CustomerID" text,  -- -> Customer
  "Status" text
);

create table "vCin7PayCardOnFileCardInfo" (
  "CustomerID" text,  -- -> Customer
  "PaymentMethodId" text,  -- -> PaymentMethod
  "Last4" text,
  "ExpMonth" text,
  "ExpYear" text,
  "Type" text,
  "Provider" text,
  "CreatedDate" text
);

create table "vCin7PayCustomer" (
  "CustomerID" text,  -- -> Customer
  "Name" text,
  "StripeCustomerID" text,  -- -> StripeCustomer
  "IsMigrated" boolean,
  "MaxRows" integer
);

create table "vCondition" (
  "ConditionID" text,  -- -> Condition
  "Field" text,
  "Condition" text,
  "Expected" text,
  "LineOrder" integer
);

create table "vConditionField" (
  "name" text,
  "type" text,
  "description" text
);

create table "vConditionType" (
  "name" text,
  "description" text
);

create table "vCustomerPaymentsDue" (
  "TaskID" text,  -- -> Task (any document)
  "CustomerID" text,  -- -> Customer
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

create table "vDepreciation" (
  "FixedAssetName" text,
  "SerialNumber" text,
  "EffectiveDate" timestamptz,
  "Amount" numeric
);

create table "vExpenseClaimLines" (
  "FakeID" integer,
  "TaskID" text,  -- -> Task (any document)
  "LineID" text,  -- -> Line (parent document's line)
  "LineOrder" integer,
  "ExpenseClaimReceiptTaskId" text,  -- -> ExpenseClaimReceiptTask
  "ReceiptNumber" text,
  "Status" text,
  "SupplierName" text,
  "ReceiptDate" timestamptz,
  "ReceiptCurrency" text,
  "ReceiptItemsNumber" integer,
  "ReceiptReference" text,
  "ReceiptStatus" text,
  "ReceiptAmount" numeric,
  "ReceiptOriginalAmount" numeric,
  "ValidationText" text,
  "ValidationState" text
);

create table "vExpenseClaimPaymentLine" (
  "FakeID" integer,
  "TaskID" text,  -- -> Task (any document)
  "LineID" text,  -- -> Line (parent document's line)
  "LineOrder" integer,
  "Reference" text,
  "DatePaid" timestamptz,
  "Amount" numeric,
  "AccountCode" text,
  "ValidationText" text,
  "ValidationState" text
);

create table "vExpenseClaimReceiptAttachement" (
  "TaskID" text,  -- -> Task (any document)
  "AttachementID" text,  -- -> Attachment
  "BlobGUID" text,  -- -> Blob (stored file)
  "ContentType" text,
  "FileName" text,
  "Date" timestamptz,
  "UserName" text,
  "IsProcessed" boolean
);

create table "vExpenseClaimReceiptLines" (
  "FakeID" integer,
  "TaskID" text,  -- -> Task (any document)
  "LineID" text,  -- -> Line (parent document's line)
  "Quantity" numeric,
  "Price" numeric,
  "LineOrder" integer,
  "Description" text,
  "Tax" numeric,
  "Total" numeric,
  "TaxRule" text,
  "TaxPercent" numeric,
  "AccountCode" text,
  "ValidationText" text,
  "ValidationState" text
);

create table "vExpenseClaimReceipt_Supplier" (
  "SupplierID" text,  -- -> Supplier
  "Name" text,
  "Currency" text,
  "PaymentTerm" text,
  "TaxRule" text,
  "Comments" text,
  "Discount" numeric
);

create table "vExpenseClaimTaskList" (
  "Selected" boolean,
  "TaskID" text,  -- -> Task (any document)
  "Status" text,
  "DateSubmitted" timestamptz,
  "EffectiveDate" timestamptz,
  "PaymentDueDate" timestamptz,
  "ClaimTotalAmount" numeric,
  "ApprovedTotalAmount" numeric,
  "PaidAmount" numeric,
  "DueAmount" numeric,
  "ReceiptsNumber" integer,
  "ReceiptNumbers" text
);

create table "vExpenseItem" (
  "ExpenseItemID" text,  -- -> ExpenseItem
  "Description" text,
  "AccountCode" text
);

create table "vFixedAsset" (
  "Selected" boolean,
  "InventoryCardID" text,  -- -> InventoryCard
  "CategoryID" text,  -- -> ProductCategory
  "CategoryName" text,
  "ProductID" text,  -- -> Product
  "ProductName" text,
  "LocationID" text,  -- -> Location
  "LocationName" text,
  "BinID" text,  -- -> Bin
  "BinName" text,
  "SerialNumber" text,
  "OnHand" numeric,
  "Registered" boolean,
  "AccumulatedDepreciation" numeric,
  "RegistrationDate" timestamptz,
  "RegisteredBy" text,
  "DefaultFixedAssetTypeID" text,  -- -> FixedAssetType
  "PurchaseDate" timestamptz,
  "DisposalDate" timestamptz,
  "PurchaseCost" numeric,
  "SalvageValue" numeric,
  "BusinessUse" numeric,
  "BookValue" numeric,
  "DefaultFixedAssetTypeName" text,
  "StartAccumulatedDepreciationDate" timestamptz,
  "StartAccumulatedDepreciationAmount" numeric,
  "DepreciationStartDate" timestamptz,
  "DepreciationMethod" text,
  "AveragingMethod" text,
  "Rate" numeric,
  "EffectiveLife" numeric,
  "AssetAccountCode" text,
  "AccumulatedDepreciationAccountCode" text,
  "DepreciationExpenseAccountCode" text,
  "AssetAccountName" text,
  "AccumulatedDepreciationAccountName" text,
  "DepreciationExpenseAccountName" text
);

create table "vFixedAssetAttachement" (
  "InventoryCardID" text,  -- -> InventoryCard
  "AttachementID" text,  -- -> Attachment
  "BlobGUID" text,  -- -> Blob (stored file)
  "ContentType" text,
  "FileName" text,
  "Date" timestamptz,
  "UserName" text,
  "IsProcessed" boolean,
  "ExternalDownloadLink" text,
  "ExternalViewLink" text
);

create table "vJournalAccountingDimension" (
  "JournalLineID" text,  -- -> JournalLine
  "Type" text,
  "AttributeName" text,
  "AttributeValue" text,
  "CustomerID" text,  -- -> Customer
  "CompanyContactID" text,  -- -> CompanyContact
  "ProductID" text,  -- -> Product
  "SupplierID" text,  -- -> Supplier
  "ProductionResourceID" text,  -- -> ProductionResource
  "ExpenseClaimID" text  -- -> ExpenseClaim
);

create table "vJournalAttachement" (
  "TaskID" text,  -- -> Task (any document)
  "AttachementID" text,  -- -> Attachment
  "BlobGUID" text,  -- -> Blob (stored file)
  "ContentType" text,
  "FileName" text,
  "Date" timestamptz,
  "UserName" text,
  "ExternalDownloadLink" text,
  "ExternalViewLink" text
);

create table "vJournalLine" (
  "FakeID" integer,
  "ID" text,
  "TaskID" text,  -- -> Task (any document)
  "Reference" text,
  "Amount" numeric,
  "BaseAmount" numeric,
  "Debit" text,
  "Credit" text,
  "DebitDisplayName" text,
  "CreditDisplayName" text,
  "ValidationText" text,
  "ValidationState" text
);

create table "vJournalList" (
  "TaskID" text,  -- -> Task (any document)
  "JournalNumber" text,
  "CreatedDate" timestamptz,
  "EffectiveDate" timestamptz,
  "Status" text,
  "Narration" text
);

create table "vJournalTask" (
  "TaskID" text,  -- -> Task (any document)
  "JournalNumber" text,
  "Status" text,
  "CreatedDate" timestamptz,
  "EffectiveDate" timestamptz,
  "Narration" text,
  "Notes" text,
  "Currency" text,
  "SyncRequest" boolean,
  "CurrencyConversionRate" numeric,
  "IsSystemJournal" boolean,
  "SystemJournalTypeNo" integer,
  "ValidationText" text,
  "ValidationState" text
);

create table "vMoneyTask" (
  "TaskID" text,  -- -> Task (any document)
  "TaskType" text,
  "BankAccountCode" text,
  "CustomerID" text,  -- -> Customer
  "SupplierID" text,  -- -> Supplier
  "SupplierCustomerName" text,
  "TaxInclusive" boolean,
  "Date" timestamptz,
  "BankAccountCurrency" text,
  "TenantCurrency" text,
  "CurrencyConversionRate" numeric,
  "Memo" text,
  "Reference" text,
  "Status" text,
  "TotalAmount" numeric,
  "TotalTaxAmount" numeric,
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
  "AttributeSetID" text  -- -> AttributeSet
);

create table "vMoneyTaskAttachement" (
  "TaskID" text,  -- -> Task (any document)
  "AttachementID" text,  -- -> Attachment
  "BlobGUID" text,  -- -> Blob (stored file)
  "ContentType" text,
  "FileName" text,
  "Date" timestamptz,
  "UserName" text,
  "IsProcessed" boolean,
  "ExternalDownloadLink" text,
  "ExternalViewLink" text
);

create table "vMoneyTaskLine" (
  "LineID" text,  -- -> Line (parent document's line)
  "Name" text,
  "AccountCode" text,
  "TaxRule" text,
  "Amount" numeric
);

create table "vPaymentMethod" (
  "Value" text,
  "Name" text
);

create table "vReceiptTaskList" (
  "Selected" boolean,
  "TaskID" text,  -- -> Task (any document)
  "ReceiptNumber" text,
  "SupplierName" text,
  "Employee" text,
  "Date" timestamptz,
  "Reference" text,
  "Currency" text,
  "TotalAmount" numeric,
  "Status" text
);

create table "vSurcharge" (
  "PaymentMethod" text,
  "Type" text,
  "FlatAmount" numeric,
  "Rate" numeric,
  "MaxAmount" numeric
);

create table "vSurchargeType" (
  "Value" text,
  "Name" text
);

create table "vSystemAccount" (
  "Code" text,
  "Name" text
);

create table "vSystemAccountInfo" (
  "Code" text,
  "Name" text,
  "MultipleAllowed" text
);

create table "vTenantCarrierWithShippingOptions" (
  "CarrierID" text,  -- -> Carrier
  "Code" text,
  "Description" text,
  "ExternalService" text,
  "IsDefault" boolean
);

create table "vTextField" (
  "name" text,
  "description" text
);

create table "vUnlinkedCoreCustomer" (
  "Name" text,
  "CustomerID" text  -- -> Customer
);

create table "vUnlinkedStripeCustomer" (
  "Name" text,
  "StripeCustomerID" text,  -- -> StripeCustomer
  "CustomerID" text,  -- -> Customer
  "Email" text,
  "CustomerName" text,
  "PreviousBatchReference" text,
  "NextBatchReference" text
);
