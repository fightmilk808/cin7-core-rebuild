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
  "TaskID" text,
  "Status" text,
  "StartDate" timestamptz,
  "EndDate" timestamptz,
  "CreatedDate" timestamptz,
  "TotalItems" numeric,
  "TotalAmount" numeric
);

create table "DepreciationTaskLine" (
  "TaskID" text,
  "LineID" text,
  "InventoryCardID" text,
  "FixedAssetName" text,
  "SerialNumber" text,
  "AccumulatedDepreciationAccountName" text,
  "DepreciationExpenseAccountName" text,
  "Amount" numeric
);

create table "ECommerceShop" (
  "ConfigID" text,
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
  "TaskID" text,
  "ReceiptNumber" text,
  "SupplierID" text,
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
  "TaskID" text,
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
  "IsAuthorised" boolean,
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
  "ProductID" text,
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
  "AttributeID" text,
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
  "AccountID" text,
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
  "RuleID" text,
  "Description" text,
  "RuleName" text,
  "ConditionCase" text,
  "RunOnAccountID" text,
  "CustomerSupplierID" text,
  "Active" boolean,
  "Priority" integer,
  "ReferenceField" text
);

create table "vBankRuleAccountMapping" (
  "AccountID" text,
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
  "LineID" text,
  "Name" text,
  "AccountCode" text,
  "TaxRule" text,
  "Amount" numeric
);

create table "vBankRuleListItem" (
  "RuleID" text,
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
  "RuleID" text,
  "Description" text,
  "EffectivePercentExclusive" numeric,
  "EffectivePercentInclusive" numeric,
  "EffectivePercent" numeric,
  "Inclusive" boolean
);

create table "vCardOnFileCustomers" (
  "Name" text,
  "CustomerID" text,
  "Status" text
);

create table "vCin7PayCardOnFileCardInfo" (
  "CustomerID" text,
  "PaymentMethodId" text,
  "Last4" text,
  "ExpMonth" text,
  "ExpYear" text,
  "Type" text,
  "Provider" text,
  "CreatedDate" text
);

create table "vCin7PayCustomer" (
  "CustomerID" text,
  "Name" text,
  "StripeCustomerID" text,
  "IsMigrated" boolean,
  "MaxRows" integer
);

create table "vCondition" (
  "ConditionID" text,
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

create table "vDepreciation" (
  "FixedAssetName" text,
  "SerialNumber" text,
  "EffectiveDate" timestamptz,
  "Amount" numeric
);

create table "vExpenseClaimLines" (
  "FakeID" integer,
  "TaskID" text,
  "LineID" text,
  "LineOrder" integer,
  "ExpenseClaimReceiptTaskId" text,
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
  "TaskID" text,
  "LineID" text,
  "LineOrder" integer,
  "Reference" text,
  "DatePaid" timestamptz,
  "Amount" numeric,
  "AccountCode" text,
  "ValidationText" text,
  "ValidationState" text
);

create table "vExpenseClaimReceiptAttachement" (
  "TaskID" text,
  "AttachementID" text,
  "BlobGUID" text,
  "ContentType" text,
  "FileName" text,
  "Date" timestamptz,
  "UserName" text,
  "IsProcessed" boolean
);

create table "vExpenseClaimReceiptLines" (
  "FakeID" integer,
  "TaskID" text,
  "LineID" text,
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
  "SupplierID" text,
  "Name" text,
  "Currency" text,
  "PaymentTerm" text,
  "TaxRule" text,
  "Comments" text,
  "Discount" numeric
);

create table "vExpenseClaimTaskList" (
  "Selected" boolean,
  "TaskID" text,
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
  "ExpenseItemID" text,
  "Description" text,
  "AccountCode" text
);

create table "vFixedAsset" (
  "Selected" boolean,
  "InventoryCardID" text,
  "CategoryID" text,
  "CategoryName" text,
  "ProductID" text,
  "ProductName" text,
  "LocationID" text,
  "LocationName" text,
  "BinID" text,
  "BinName" text,
  "SerialNumber" text,
  "OnHand" numeric,
  "Registered" boolean,
  "AccumulatedDepreciation" numeric,
  "RegistrationDate" timestamptz,
  "RegisteredBy" text,
  "DefaultFixedAssetTypeID" text,
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
  "InventoryCardID" text,
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

create table "vJournalAccountingDimension" (
  "JournalLineID" text,
  "Type" text,
  "AttributeName" text,
  "AttributeValue" text,
  "CustomerID" text,
  "CompanyContactID" text,
  "ProductID" text,
  "SupplierID" text,
  "ProductionResourceID" text,
  "ExpenseClaimID" text
);

create table "vJournalAttachement" (
  "TaskID" text,
  "AttachementID" text,
  "BlobGUID" text,
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
  "TaskID" text,
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
  "TaskID" text,
  "JournalNumber" text,
  "CreatedDate" timestamptz,
  "EffectiveDate" timestamptz,
  "Status" text,
  "Narration" text
);

create table "vJournalTask" (
  "TaskID" text,
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
  "TaskID" text,
  "TaskType" text,
  "BankAccountCode" text,
  "CustomerID" text,
  "SupplierID" text,
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
  "AttributeSetID" text
);

create table "vMoneyTaskAttachement" (
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

create table "vMoneyTaskLine" (
  "LineID" text,
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
  "TaskID" text,
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
  "CarrierID" text,
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
  "CustomerID" text
);

create table "vUnlinkedStripeCustomer" (
  "Name" text,
  "StripeCustomerID" text,
  "CustomerID" text,
  "Email" text,
  "CustomerName" text,
  "PreviousBatchReference" text,
  "NextBatchReference" text
);
