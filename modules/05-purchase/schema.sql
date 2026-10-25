-- Purchase: one table per Cin7 Core data model, generated from data/models.json

create table "AccountCurrency" (
  "Code" text,
  "Currency" text
);

create table "AvailableActions" (
  "ID" text,
  "Name" text
);

create table "CreditNoteLineSelect" (
  "FakeKey" integer,
  "ProductID" text,  -- -> Product
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

create table "CurrencyWithConversionRate" (
  "ResultCurrencyCode" text,
  "Ratio" numeric,
  "IsBase" boolean
);

create table "Customer" (
  "CustomerID" text,  -- -> Customer
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

create table "DistributionTypeModel" (
  "Value" text,
  "Name" text
);

create table "FamilyMatrix_Option" (
  "name" text,
  "index" integer,
  "values" text
);

create table "FamilyMatrix_PurchaseProduct" (
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
  "NonInventory" boolean,
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

create table "InvoiceForCreditNote" (
  "TaskID" text,  -- -> Task (any document)
  "Invoice" text,
  "Date" timestamptz
);

create table "Location" (
  "LocationID" text,  -- -> Location
  "Description" text
);

create table "PaymentWrapper" (
  "DimensionsPermission" text,
  "IsAccountingDimensionsEnabled" boolean
);

create table "PeriodModel" (
  "Period" text,
  "Name" text
);

create table "ProductReplenishmentDetails" (
  "ProductID" text,  -- -> Product
  "ProductName" text,
  "OrderQuantity" numeric,
  "Available" numeric,
  "OnHand" numeric,
  "OnOrder" numeric,
  "MOQ" numeric,
  "Backordered" numeric,
  "MinimumBeforeReorder" numeric,
  "ReorderQuantity" numeric,
  "SuggestedQuantity" numeric,
  "InternalId" text,  -- -> Internal
  "CartonInnerQuantity" numeric,
  "CartonQuantity" numeric,
  "NumberOfCartons" numeric,
  "LineVolume" numeric,
  "LineVolumeSum" numeric,
  "ValidationState" text,
  "ValidationText" text
);

create table "PurchaseExternalPayment" (
  "TaskID" text,  -- -> Task (any document)
  "PaymentID" text  -- -> Payment
);

create table "PurchaseIntStockLineUploadError" (
  "ValidationState" text,
  "ValidationText" text,
  "Line" integer,
  "SKU" text,
  "SKUError" text,
  "ProductName" text,
  "ProductNameError" text,
  "BatchSerialNumber" text,
  "BatchSerialNumberError" text,
  "ExpiryDate_YYYYMMDD" text,
  "ExpiryDate_YYYYMMDDError" text,
  "Quantity" text,
  "QuantityError" text,
  "DateReceived_YYYYMMDD" text,
  "DateReceived_YYYYMMDDError" text
);

create table "PurchaseInvoiceLineUploadError" (
  "ValidationState" text,
  "ValidationText" text,
  "Line" integer,
  "SKU" text,
  "SKUError" text,
  "Name" text,
  "NameError" text,
  "Quantity" text,
  "QuantityError" text,
  "Price" text,
  "PriceError" text,
  "Discount" text,
  "DiscountError" text,
  "Comment" text,
  "CommentError" text
);

create table "PurchaseOrderLineUploadError" (
  "ValidationState" text,
  "ValidationText" text,
  "Line" integer,
  "SKU" text,
  "SKUError" text,
  "Name" text,
  "NameError" text,
  "Quantity" text,
  "QuantityError" text,
  "Price" text,
  "PriceError" text,
  "Discount" text,
  "DiscountError" text,
  "Comment" text,
  "CommentError" text
);

create table "PurchasePriceLookup" (
  "ProductID" text,  -- -> Product
  "Price" numeric
);

create table "PurchaseReferenceData" (
  "ID" integer,
  "OrderViewPermission" text,
  "OrderAuthorisationPermission" text,
  "BillCreditNoteViewPermission" text,
  "BillCreditNoteAuthorisationPermission" text,
  "StockReceivedViewPermission" text,
  "StockReceivedAuthorisationPermission" text,
  "EditAuthorizedDocumentsPermission" text,
  "UndoPermission" text,
  "VoidPermission" text,
  "OrderApproveRejectReviewPermission" text,
  "OtherUsersAttachmentsPermission" text,
  "ProductFamilyCount" integer,
  "DefaultAccount" text,
  "TaxCalculationMethod" text,
  "DefaultPurchaseMethod" text,
  "HeadersVisible" text,
  "FixedAssetPermission" text,
  "CurrentAttributeSetId" text,  -- -> AttributeSet
  "AttributeSetCopyFrom" text,
  "UsePurchasePutAway" boolean,
  "LockDate" timestamptz,
  "CountrySpecificData" text,
  "IsArchiveEnabled" boolean,
  "IsOrderApproveEnabled" boolean,
  "FinancialDataPermission" text,
  "IsAccountingDimensionsEnabled" boolean,
  "SaleAllowOrderNoAlloc" boolean
);

create table "PurchaseStockTask" (
  "FakeID" text,
  "TaskID" text,  -- -> Task (any document)
  "Date" timestamptz,
  "IntermediateStockReceivedDate" timestamptz,
  "StockReceivedDate" timestamptz,
  "StockReceivedLocation" text,
  "StockReceivedReceived" boolean,
  "IntermediateStockStatus" text,
  "StockStatus" text
);

create table "PurchaseTask" (
  "TaskID" text,  -- -> Task (any document)
  "SupplierID" text,  -- -> Supplier
  "SupplierName" text,
  "Contact" text,
  "Phone" text,
  "VendorAddressLine1" text,
  "VendorAddressLine2" text,
  "Currency" text,
  "TaxSchema" text,
  "TaxPercent" numeric,
  "TaxInclusive" boolean,
  "Terms" text,
  "TermDays" integer,
  "TermMethod" integer,
  "Approach" text,
  "ShippingAddressLine1" text,
  "ShippingAddressLine2" text,
  "ShipmentRequiredByDate" timestamptz,
  "BlindReceipt" boolean,
  "PurchaseOrderLocation" text,
  "PurchaseOrderNumber" text,
  "PurchaseOrderDate" timestamptz,
  "PurchaseOrderMemoInternal" text,
  "PurchaseOrderMemo" text,
  "PurchaseOrderStatus" text,
  "SupplierReference" text,
  "InvoiceDate" timestamptz,
  "InvoiceTotalAmount" numeric,
  "POTotalAmount" numeric,
  "InvoiceDueDate" timestamptz,
  "InvoiceToInventorySynch" boolean,
  "InvoiceStatus" text,
  "Status" text,
  "CreditNoteNumber" text,
  "CreditNoteDate" timestamptz,
  "StockStatus" text,
  "DefaultAccount" text,
  "CreditNoteStatus" text,
  "UnstockStatus" text,
  "CreditNoteInnerStatus" text,
  "ManualJournalsStatus" text,
  "CurrencyConversionRate" numeric,
  "SupplierCurrency" text,
  "SyncRequest" boolean,
  "TermDueNextMonth" integer,
  "DropShipTaskID" text,  -- -> Purchase
  "Discount" text,
  "JobID" text,  -- -> Job
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
  "HasDistributeExpense" boolean,
  "AllowAddDistributeExpense" boolean,
  "CreditNoteHasDistributeExpense" boolean,
  "CreditNoteAllowAddDistributeExpense" boolean,
  "StockInTransitAccount" text,
  "ShipToOther" boolean,
  "ShipToCompany" text,
  "ShipToContact" text,
  "ShipToCountry" text,
  "ShipToPostCode" text,
  "ShipToState" text,
  "ShipToCity" text,
  "ShipToAddress1" text,
  "ShipToAddress2" text,
  "TaskTypeSign" integer,
  "InvoicingAndReceivingNumber" integer,
  "CombinedInvoiceCrNoteDocumentNumbers" text,
  "InvoiceTaskForCreditNoteID" text,  -- -> InvoiceTaskForCreditNote
  "InternalMark" text,
  "SimpleTaskTypeSign" integer,
  "TaskTypeName" text,
  "IntermediateStockStatus" text,
  "CountrySpecificKey" text,
  "CountrySpecificData" text,
  "ValidationText" text,
  "ValidationState" text,
  "IsArchived" boolean,
  "OrderApprove" integer,
  "JobMilestoneID" text,  -- -> JobMilestone
  "HasProductionOrder" boolean,
  "LinkedProductionOrderID" text,  -- -> ProductionOrder
  "SaleID" text,  -- -> Sale
  "OrderSendStatus" text
);

create table "PurchaseTaskWrapper" (
  "ID" text,
  "Lang" text,
  "ClientDateTime" timestamptz,
  "HasErrors" boolean,
  "HasPriceInfoAccess" boolean,
  "IsAirwallexEnabled" boolean
);

create table "QuickBooksSyncedPurchaseInvoice" (
  "TaskID" text  -- -> Task (any document)
);

create table "ReorderEmailReferenceWrapper" (
  "FakeID" integer
);

create table "ReorderEmailWrapper" (
  "ID" text,
  "TenantID" text  -- -> Tenant
);

create table "ReorderMode" (
  "ReorderMode" text
);

create table "ReorderSuggestionEmailRecord" (
  "ID" text,
  "ProductID" text,  -- -> Product
  "ProductCode" text,
  "ProductName" text,
  "SupplierID" text,  -- -> Supplier
  "SupplierName" text,
  "ReorderQty" numeric,
  "ReorderDate" timestamptz,
  "SupplierSKU" text,
  "MinimumToReorder" numeric,
  "Available" numeric,
  "OnOrder" numeric,
  "Price" numeric,
  "AvailableAtWarehouse" numeric,
  "IsSelected" boolean,
  "LocationID" text,  -- -> Location
  "LocationName" text,
  "Unit" text
);

create table "Service_CreditNoteLineSelect" (
  "FakeKey" integer,
  "Description" text,
  "Quantity" numeric,
  "RemainingQuantity" text,
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

create table "Supplier" (
  "SupplierID" text,  -- -> Supplier
  "Name" text,
  "Contact" text,
  "Phone" text,
  "Email" text,
  "Website" text,
  "Address" text
);

create table "SupplierDefaultTemplate" (
  "DefaultTemplateID" text,  -- -> Template
  "TemplateID" text,  -- -> Template
  "Type" text
);

create table "SupplierStatus" (
  "Value" text,
  "Name" text
);

create table "SupplierWrapper" (
  "ID" integer,
  "HasErrors" boolean
);

create table "TenantLocation" (
  "ID" text,
  "Name" text
);

create table "VerifyInvoiceModel" (
  "ProductID" text,  -- -> Product
  "ProductName" text,
  "InvoiceQuantity" numeric,
  "CartonInnerQuantity" numeric,
  "CartonQuantity" numeric,
  "NumberOfCartons" numeric,
  "LineVolume" numeric,
  "CartonVolume" numeric,
  "LineFreightCost" numeric,
  "UnitFreightCost" numeric
);

create table "XeroSyncedPurchaseInvoice" (
  "TaskID" text  -- -> Task (any document)
);

create table "listModel" (
  "ID" text,
  "ProductID" text,  -- -> Product
  "SupplierID" text,  -- -> Supplier
  "SKU" text,
  "Product" text,
  "Category" text,
  "ProductTags" text,
  "Family" text,
  "Supplier" text,
  "Currency" text,
  "SupplierSKU" text,
  "SupplierProductName" text,
  "URL" text,
  "LatestPrice" numeric,
  "FixedPrice" numeric,
  "DropShip" boolean
);

create table "spTaskImportLogEntry" (
  "ID" text,
  "Date" timestamptz,
  "DocumentName" text,
  "Comment" text,
  "UserName" text
);

create table "vBrand" (
  "BrandID" text,  -- -> Brand
  "Name" text
);

create table "vCategory" (
  "CategoryID" text,  -- -> ProductCategory
  "Name" text
);

create table "vCreditAllocated" (
  "AllocationID" text,  -- -> Allocation
  "TaskID" text,  -- -> Task (any document)
  "DocNumber" text,
  "Currency" text,
  "Date" timestamptz,
  "Amount" numeric
);

create table "vDearToDearNetworkingTaskLinks" (
  "ID" text,
  "SourceTaskID" text,  -- -> Task (any document)
  "SourceType" integer,
  "TargetTaskID" text,  -- -> Task (any document)
  "TargetType" integer
);

create table "vDistributedAmount" (
  "ID" text,
  "TaskID" text,  -- -> Task (any document)
  "TaskType" text,
  "ValidationText" text,
  "ValidationState" text
);

create table "vDistributedAmountAccount" (
  "AccountCode" text,
  "AccountAmount" numeric,
  "AccountName" text,
  "DistributedAmount" numeric
);

create table "vDocumentAccount" (
  "AccountCode" text,
  "AccountAmount" numeric,
  "AccountName" text
);

create table "vExtractedDocument" (
  "DocumentName" text,
  "Status" text,
  "StatusDescription" text,
  "DateCreated" timestamptz,
  "EntityID" text  -- -> Entity (polymorphic)
);

create table "vInventoryMovement" (
  "FakeID" text,
  "TaskID" text,  -- -> Task (any document)
  "CardDetailsID" text,  -- -> InventoryCard
  "CardID" text,  -- -> InventoryCard
  "Date" timestamptz,
  "ProductID" text,  -- -> Product
  "Quantity" numeric,
  "Location" text,
  "Received" boolean,
  "Name" text,
  "ProductType" text,
  "SupplierInventoryCode" text,
  "UnitOfMeasure" text,
  "ProductCode" text,
  "CostingMethod" text,
  "BatchSN" text,
  "ExpiryDate" timestamptz,
  "SysDate" timestamptz,
  "AccountCode" text,
  "InventoryAccount" text,
  "DefaultFixedAssetAccountCode" text,
  "TaxRule" text,
  "ValidationText" text,
  "ValidationState" text,
  "FakeID2" text
);

create table "vInvoiceAdditionalCostLine" (
  "FakeID" text,
  "TaskID" text,  -- -> Task (any document)
  "PurchaseCostID" text,  -- -> PurchaseCost
  "Description" text,
  "Reference" text,
  "Quantity" numeric,
  "Amount" numeric,
  "Discount" numeric,
  "TaxRule" text,
  "TaxPercent" numeric,
  "Tax" numeric,
  "Total" numeric,
  "Type" text,
  "LineOrder" integer,
  "AccountCode" text,
  "ValidationText" text,
  "ValidationState" text
);

create table "vInvoiceLine" (
  "FakeID" text,
  "TaskID" text,  -- -> Task (any document)
  "InvoiceLineID" text,  -- -> Line (parent document's line)
  "ProductID" text,  -- -> Product
  "Quantity" numeric,
  "Price" numeric,
  "Discount" numeric,
  "Tax" numeric,
  "Total" numeric,
  "Type" text,
  "AccountCode" text,
  "DefaultFixedAssetAccountCode" text,
  "Name" text,
  "ProductType" text,
  "SupplierInventoryCode" text,
  "UnitOfMeasure" text,
  "ProductCode" text,
  "CostingMethod" text,
  "TaxRule" text,
  "TaxPercent" numeric,
  "LineOrder" integer,
  "BinID" text,  -- -> Bin
  "Comment" text,
  "NonInventory" boolean,
  "ValidationText" text,
  "ValidationState" text
);

create table "vJobMilestone" (
  "ID" text,
  "Name" text
);

create table "vPaymentsDue" (
  "TaskID" text,  -- -> Task (any document)
  "SupplierID" text,  -- -> Supplier
  "InvoiceNumber" text,
  "InvoiceDate" timestamptz,
  "DueDate" timestamptz,
  "PONumber" text,
  "InvoiceAmount" numeric,
  "PaidAmount" numeric,
  "DueAmount" numeric,
  "DaysOverdue" integer,
  "AllocatedAmount" numeric
);

create table "vProductionForDistribution" (
  "ProductionRunID" text,  -- -> ProductionRun
  "ProductionOrderNumber" text,
  "Date" timestamptz,
  "Amount" numeric,
  "Location" text
);

create table "vPurchaseAllocations" (
  "PurchaseDepositID" text,  -- -> PurchaseDeposit
  "ID" text,
  "PurchasePaymentID" text,  -- -> PurchasePayment
  "TaskID" text,  -- -> Task (any document)
  "Flag" boolean
);

create table "vPurchaseBillOfEntryLines" (
  "FakeID" text,
  "TaskID" text,  -- -> Task (any document)
  "LineID" text,  -- -> Line (parent document's line)
  "ProductID" text,  -- -> Product
  "Quantity" numeric,
  "Tax" numeric,
  "Total" numeric,
  "ExciseTax" numeric,
  "CustomsTotal" numeric,
  "Name" text,
  "ProductCode" text,
  "TaxRule" text,
  "LineOrder" integer,
  "ValidationText" text,
  "ValidationState" text
);

create table "vPurchaseCreditNoteCostLine" (
  "FakeID" text,
  "TaskID" text,  -- -> Task (any document)
  "PurchaseCostID" text,  -- -> PurchaseCost
  "Description" text,
  "Reference" text,
  "Quantity" numeric,
  "Amount" numeric,
  "Discount" numeric,
  "TaxRule" text,
  "TaxPercent" numeric,
  "Tax" numeric,
  "Total" numeric,
  "LineOrder" integer,
  "Type" text,
  "AccountCode" text,
  "ValidationText" text,
  "ValidationState" text
);

create table "vPurchaseCreditNoteLine" (
  "FakeID" text,
  "TaskID" text,  -- -> Task (any document)
  "InvoiceLineID" text,  -- -> Line (parent document's line)
  "ProductID" text,  -- -> Product
  "Quantity" numeric,
  "Price" numeric,
  "Discount" numeric,
  "Tax" numeric,
  "Total" numeric,
  "Type" text,
  "AccountCode" text,
  "Name" text,
  "SupplierInventoryCode" text,
  "UnitOfMeasure" text,
  "ProductCode" text,
  "CostingMethod" text,
  "TaxRule" text,
  "TaxPercent" numeric,
  "LineOrder" integer,
  "Comment" text,
  "ValidationText" text,
  "ValidationState" text
);

create table "vPurchaseCreditNotePaymentLine" (
  "FakeID" text,
  "TaskID" text,  -- -> Task (any document)
  "PaymentID" text,  -- -> Payment
  "Reference" text,
  "DatePaid" timestamptz,
  "Type" text,
  "Amount" numeric,
  "AccountCode" text,
  "CurrencyConversionRate" numeric,
  "PaymentType" text,
  "ValidationText" text,
  "ValidationState" text
);

create table "vPurchaseDepositWithDetails" (
  "ID" text,
  "SupplierID" text,  -- -> Supplier
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

create table "vPurchaseDeposits" (
  "ID" text,
  "SupplierID" text,  -- -> Supplier
  "SupplierName" text,
  "Currency" text,
  "Amount" numeric,
  "RemainingAmount" numeric,
  "Account" text,
  "SourceLineID" text,  -- -> Line (parent document's line)
  "CreditSourceTaskID" text,  -- -> Task (any document)
  "OrigTaskType" text,
  "Type" text,
  "Date" timestamptz
);

create table "vPurchaseDistribution" (
  "ID" text,
  "TaskID" text,  -- -> Task (any document)
  "InvoiceNumber" text,
  "TaskType" text,
  "ValidationText" text,
  "ValidationState" text
);

create table "vPurchaseDistributionAccountAmount" (
  "AccountCode" text,
  "AccountAmount" numeric,
  "AccountName" text,
  "DistributedAmount" numeric,
  "ValidationText" text,
  "ValidationState" text
);

create table "vPurchaseExpense" (
  "TaskID" text,  -- -> Task (any document)
  "AccountCode" text,
  "AccountName" text,
  "Amount" numeric,
  "Invoices" text,
  "DistributedAmount" numeric,
  "LeftToDistribute" numeric,
  "Selected" boolean
);

create table "vPurchaseForDistribution" (
  "TaskID" text,  -- -> Task (any document)
  "InvoiceNumber" text,
  "InvoiceDate" timestamptz,
  "PONumber" text,
  "InvoiceAmount" numeric,
  "SupplierName" text
);

create table "vPurchaseManualJournals" (
  "FakeID" text,
  "TaskID" text,  -- -> Task (any document)
  "ID" text,
  "Reference" text,
  "Amount" numeric,
  "Date" timestamptz,
  "Debit" text,
  "Credit" text,
  "AccrualType" text,
  "DistributeType" text,
  "ProductionRunID" text,  -- -> ProductionRun
  "ValidationText" text,
  "ValidationState" text
);

create table "vPurchaseManualJournalsDistributedCosts" (
  "ID" text,
  "ManualJournalID" text,  -- -> ManualJournal
  "ProductID" text,  -- -> Product
  "DistributedCost" numeric,
  "InvoiceTotal" numeric,
  "ValidationText" text,
  "ValidationState" text
);

create table "vPurchaseOrderAttachement" (
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

create table "vPurchaseOrderCostLines" (
  "FakeID" text,
  "TaskID" text,  -- -> Task (any document)
  "PurchaseCostID" text,  -- -> PurchaseCost
  "Description" text,
  "Reference" text,
  "Quantity" numeric,
  "Amount" numeric,
  "Discount" numeric,
  "TaxRule" text,
  "TaxPercent" numeric,
  "Tax" numeric,
  "Total" numeric,
  "LineOrder" integer,
  "ExpenseAccount" text,
  "ValidationText" text,
  "ValidationState" text
);

create table "vPurchaseOrderLines" (
  "FakeID" text,
  "TaskID" text,  -- -> Task (any document)
  "OrderLineID" text,  -- -> Line (parent document's line)
  "ProductID" text,  -- -> Product
  "Quantity" numeric,
  "Price" numeric,
  "Discount" numeric,
  "Tax" numeric,
  "Total" numeric,
  "LineOrder" integer,
  "Name" text,
  "ProductType" text,
  "SupplierInventoryCode" text,
  "UnitOfMeasure" text,
  "ProductCode" text,
  "CostingMethod" text,
  "InventoryAccount" text,
  "DefaultFixedAssetAccountCode" text,
  "COGSAccount" text,
  "TaxRule" text,
  "TaxPercent" numeric,
  "BinID" text,  -- -> Bin
  "Comment" text,
  "NonInventory" boolean,
  "ValidationText" text,
  "ValidationState" text
);

create table "vPurchasePaymentLine" (
  "FakeID" text,
  "TaskID" text,  -- -> Task (any document)
  "PaymentID" text,  -- -> Payment
  "Reference" text,
  "DatePaid" timestamptz,
  "Type" text,
  "Amount" numeric,
  "AccountCode" text,
  "CurrencyConversionRate" numeric,
  "PaymentType" text,
  "ValidationText" text,
  "ValidationState" text
);

create table "vPurchaseStockIntermediateLines" (
  "FakeID" text,
  "TaskID" text,  -- -> Task (any document)
  "ID" text,
  "ProductID" text,  -- -> Product
  "Quantity" numeric,
  "UnitCost" numeric,
  "AccountCode" text,
  "BatchSN" text,
  "Date" timestamptz,
  "ExpiryDate" timestamptz,
  "Received" boolean,
  "ProductName" text,
  "ProductType" text,
  "SupplierInventoryCode" text,
  "UnitOfMeasure" text,
  "ProductCode" text,
  "CostingMethod" text,
  "InventoryAccount" text,
  "DefaultFixedAssetAccountCode" text,
  "COGSAccount" text,
  "LocationID" text,  -- -> Location
  "NonInventory" boolean,
  "StockReceivingNumber" integer,
  "ValidationText" text,
  "ValidationState" text
);

create table "vPurchaseTaskList" (
  "TaskID" text,  -- -> Task (any document)
  "OrderNo" text,
  "Status" text,
  "OrderDate" timestamptz,
  "InvoiceDate" timestamptz,
  "ShipmentRequiredByDate" timestamptz,
  "Supplier" text,
  "Reference" text,
  "POTotalAmount" numeric,
  "Currency" text,
  "TenantCurrency" text,
  "DropShipTaskID" text,  -- -> Purchase
  "PurchaseOrderStatus" integer,
  "BillStatus" text,
  "StockStatus" text,
  "PaymentStatus" text,
  "Selected" boolean,
  "Approach" text,
  "DocNumbers" text,
  "Location" text,
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
  "TaskTypeSign" integer,
  "FakeField" text,
  "SimpleTaskTypeSign" integer,
  "TaskTypeName" text,
  "IsArchived" boolean,
  "OrderApprove" integer,
  "OrderSendStatus" text
);

create table "vPurchaseTaskListAccounting" (
  "ID" text,
  "TaskID" text,  -- -> Task (any document)
  "Type" integer,
  "Supplier" text,
  "Contact" text,
  "Phone" text,
  "Currency" text,
  "Reference" text,
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
  "DropShipTaskID" text,  -- -> Purchase
  "Total" numeric,
  "Paid" numeric,
  "Credited" numeric,
  "Due" numeric,
  "DaysOverdue" integer,
  "DocNo" text,
  "Location" text,
  "PurchaseOrderDate" timestamptz,
  "Date" timestamptz,
  "DueDate" timestamptz,
  "OrderNo" text,
  "Terms" text,
  "Status" text,
  "TaskTypeSign" integer,
  "Selected" boolean,
  "SimpleTaskTypeSign" integer,
  "TaskTypeName" text,
  "IsArchived" boolean,
  "OrderApprove" integer
);

create table "vPurchaseUnstock" (
  "FakeID" text,
  "TaskID" text,  -- -> Task (any document)
  "CardDetailsID" text,  -- -> InventoryCard
  "CardID" text,  -- -> InventoryCard
  "Date" timestamptz,
  "ProductID" text,  -- -> Product
  "Quantity" numeric,
  "Location" text,
  "Name" text,
  "SupplierInventoryCode" text,
  "UnitOfMeasure" text,
  "ProductCode" text,
  "CostingMethod" text,
  "BatchSN" text,
  "ExpiryDate" timestamptz,
  "ValidationText" text,
  "ValidationState" text
);

create table "vPurchase_Supplier" (
  "SupplierID" text,  -- -> Supplier
  "Name" text,
  "Currency" text,
  "PaymentTerm" text,
  "TaxRule" text,
  "Comments" text,
  "Discount" numeric,
  "AttributeSet" text
);

create table "vPurchase_SupplierAddress" (
  "SupplierID" text,  -- -> Supplier
  "AddressID" text,  -- -> Address
  "Line1" text,
  "Line2" text,
  "Type" text,
  "DefaultForType" boolean
);

create table "vPurchase_SupplierContact" (
  "SupplierID" text,  -- -> Supplier
  "ContactID" text,  -- -> Contact
  "Name" text,
  "IsDefault" boolean,
  "Phone" text
);

create table "vPurchase_TenantAddress" (
  "AddressID" text,  -- -> Address
  "Line1" text,
  "Line2" text,
  "Type" text,
  "DefaultForType" boolean,
  "Source" text
);

create table "vReorderSuggestionEmail" (
  "ID" text,
  "CreationDate" timestamptz,
  "ReportID" text,  -- -> Report
  "MailingListID" text,  -- -> MailingList
  "LocationID" text,  -- -> Location
  "SupplierID" text,  -- -> Supplier
  "ProductCode" text,
  "LocationName" text,
  "Sent" boolean,
  "PurchaseOrderStatus" text,
  "ErrorMessage" text,
  "ValidationText" text,
  "ValidationState" text
);

create table "vReorderSuggestionEmailRecordTask" (
  "ID" text,
  "RequiredBy" timestamptz,
  "ProductID" text,  -- -> Product
  "ProductName" text,
  "ProductCode" text,
  "Type" text,
  "TaskID" text,  -- -> Task (any document)
  "Number" text,
  "From" text,
  "To" text,
  "OrderedQty" text
);

create table "vSupplierAddress" (
  "SupplierID" text,  -- -> Supplier
  "AddressID" text,  -- -> Address
  "Line1" text,
  "Line2" text,
  "CitySuburb" text,
  "StateProvince" text,
  "ZipPostCode" text,
  "Country" text,
  "Type" text,
  "DefaultForType" boolean
);

create table "vSupplierContact" (
  "SupplierID" text,  -- -> Supplier
  "ContactID" text,  -- -> Contact
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

create table "vSupplierDefaultTemplate" (
  "DefaultTemplateID" text,  -- -> Template
  "TemplateID" text,  -- -> Template
  "SupplierID" text,  -- -> Supplier
  "Type" text
);

create table "vSupplierFile" (
  "FileID" text,  -- -> Blob (stored file)
  "SupplierID" text,  -- -> Supplier
  "FileName" text,
  "ContentType" text,
  "UserName" text,
  "UploadedDate" timestamptz,
  "ExternalDownloadLink" text,
  "ExternalViewLink" text
);

create table "vSupplierList" (
  "SupplierID" text,  -- -> Supplier
  "Name" text,
  "Contact" text,
  "Phone" text,
  "Email" text,
  "Website" text,
  "Address" text,
  "TotalAmount" numeric,
  "PaidAmount" numeric,
  "DueAmount" numeric,
  "Currency" text,
  "TenantCurrency" text,
  "IsActive" boolean
);

create table "vSupplierPurchaseTasks" (
  "TaskID" text,  -- -> Task (any document)
  "PurchaseOrderNumber" text,
  "Status" text,
  "PurchaseOrderDate" timestamptz,
  "SupplierReference" text,
  "Total" numeric,
  "Paid" numeric,
  "IsDropShip" boolean,
  "TaskTypeSign" integer,
  "TaskTypeName" text
);

create table "vSupplierPurchases" (
  "ID" text,
  "ProductID" text,  -- -> Product
  "Quantity" numeric,
  "Price" numeric,
  "TaskID" text,  -- -> Task (any document)
  "InvoiceDate" timestamptz,
  "SupplierCurrency" text,
  "InvoiceNumber" text,
  "Name" text,
  "ProductCode" text,
  "DropShipTaskID" text,  -- -> Purchase
  "TaskTypeSign" integer,
  "TaskTypeName" text,
  "SupplierSku" text
);

create table "vTaskForDistribution" (
  "TaskID" text,  -- -> Task (any document)
  "TaskTypeName" text,
  "TaskType" integer,
  "Date" timestamptz,
  "TaskNumber" text,
  "Amount" numeric,
  "Location" text
);

create table "vTenantAddress" (
  "AddressID" text,  -- -> Address
  "Line1" text,
  "Line2" text,
  "CitySuburb" text,
  "StateProvince" text,
  "ZipPostCode" text,
  "Country" text,
  "Type" text,
  "DefaultForType" boolean
);

create table "vTenantPaymentTermNew" (
  "TermID" text,  -- -> PaymentTerm
  "Name" text,
  "Days" integer,
  "Method" integer,
  "DueNextMonth" integer,
  "IsActive" boolean,
  "IsDefault" boolean
);
