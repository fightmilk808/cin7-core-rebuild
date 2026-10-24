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

create table "CurrencyWithConversionRate" (
  "ResultCurrencyCode" text,
  "Ratio" numeric,
  "IsBase" boolean
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
  "ProductID" text,
  "Code" text,
  "Name" text,
  "Unit" text,
  "SupplierInventoryCode" text,
  "Cost" numeric,
  "CostingMethod" text,
  "Account" text,
  "Type" text,
  "TaxRule" text,
  "BinID" text,
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
  "TaskID" text,
  "Invoice" text,
  "Date" timestamptz
);

create table "Location" (
  "LocationID" text,
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
  "ProductID" text,
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
  "InternalId" text,
  "CartonInnerQuantity" numeric,
  "CartonQuantity" numeric,
  "NumberOfCartons" numeric,
  "LineVolume" numeric,
  "LineVolumeSum" numeric,
  "ValidationState" text,
  "ValidationText" text
);

create table "PurchaseExternalPayment" (
  "TaskID" text,
  "PaymentID" text
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
  "ProductID" text,
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
  "CurrentAttributeSetId" text,
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
  "TaskID" text,
  "Date" timestamptz,
  "IntermediateStockReceivedDate" timestamptz,
  "StockReceivedDate" timestamptz,
  "StockReceivedLocation" text,
  "StockReceivedReceived" boolean,
  "IntermediateStockStatus" text,
  "StockStatus" text
);

create table "PurchaseTask" (
  "TaskID" text,
  "SupplierID" text,
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
  "DropShipTaskID" text,
  "Discount" text,
  "JobID" text,
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
  "InvoiceTaskForCreditNoteID" text,
  "InternalMark" text,
  "SimpleTaskTypeSign" integer,
  "TaskTypeName" text,
  "IntermediateStockStatus" text,
  "InternalMark" text,
  "CountrySpecificKey" text,
  "CountrySpecificData" text,
  "ValidationText" text,
  "ValidationState" text,
  "IsArchived" boolean,
  "OrderApprove" integer,
  "JobMilestoneID" text,
  "HasProductionOrder" boolean,
  "LinkedProductionOrderID" text,
  "SaleID" text,
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
  "TaskID" text
);

create table "ReorderEmailReferenceWrapper" (
  "FakeID" integer
);

create table "ReorderEmailWrapper" (
  "ID" text,
  "TenantID" text
);

create table "ReorderMode" (
  "ReorderMode" text
);

create table "ReorderSuggestionEmailRecord" (
  "ID" text,
  "ProductID" text,
  "ProductCode" text,
  "ProductName" text,
  "SupplierID" text,
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
  "LocationID" text,
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
  "SupplierID" text,
  "Name" text,
  "Contact" text,
  "Phone" text,
  "Email" text,
  "Website" text,
  "Address" text
);

create table "SupplierDefaultTemplate" (
  "DefaultTemplateID" text,
  "TemplateID" text,
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
  "ProductID" text,
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
  "TaskID" text
);

create table "listModel" (
  "ID" text,
  "ProductID" text,
  "SupplierID" text,
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
  "BrandID" text,
  "Name" text
);

create table "vCategory" (
  "CategoryID" text,
  "Name" text
);

create table "vCreditAllocated" (
  "AllocationID" text,
  "TaskID" text,
  "DocNumber" text,
  "Currency" text,
  "Date" timestamptz,
  "Amount" numeric
);

create table "vDearToDearNetworkingTaskLinks" (
  "ID" text,
  "SourceTaskID" text,
  "SourceType" integer,
  "TargetTaskID" text,
  "TargetType" integer
);

create table "vDistributedAmount" (
  "ID" text,
  "TaskID" text,
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
  "EntityID" text
);

create table "vInventoryMovement" (
  "FakeID" text,
  "TaskID" text,
  "CardDetailsID" text,
  "CardID" text,
  "Date" timestamptz,
  "ProductID" text,
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
  "TaskID" text,
  "PurchaseCostID" text,
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
  "BinID" text,
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
  "TaskID" text,
  "SupplierID" text,
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
  "ProductionRunID" text,
  "ProductionOrderNumber" text,
  "Date" timestamptz,
  "Amount" numeric,
  "Location" text
);

create table "vPurchaseAllocations" (
  "PurchaseDepositID" text,
  "ID" text,
  "PurchasePaymentID" text,
  "TaskID" text,
  "Flag" boolean
);

create table "vPurchaseBillOfEntryLines" (
  "FakeID" text,
  "TaskID" text,
  "LineID" text,
  "ProductID" text,
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
  "TaskID" text,
  "PurchaseCostID" text,
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
  "TaskID" text,
  "PaymentID" text,
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
  "SupplierID" text,
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
  "SupplierID" text,
  "SupplierName" text,
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

create table "vPurchaseDistribution" (
  "ID" text,
  "TaskID" text,
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
  "TaskID" text,
  "AccountCode" text,
  "AccountName" text,
  "Amount" numeric,
  "Invoices" text,
  "DistributedAmount" numeric,
  "LeftToDistribute" numeric,
  "Selected" boolean
);

create table "vPurchaseForDistribution" (
  "TaskID" text,
  "InvoiceNumber" text,
  "InvoiceDate" timestamptz,
  "PONumber" text,
  "InvoiceAmount" numeric,
  "SupplierName" text
);

create table "vPurchaseManualJournals" (
  "FakeID" text,
  "TaskID" text,
  "ID" text,
  "Reference" text,
  "Amount" numeric,
  "Date" timestamptz,
  "Debit" text,
  "Credit" text,
  "AccrualType" text,
  "DistributeType" text,
  "ProductionRunID" text,
  "ValidationText" text,
  "ValidationState" text
);

create table "vPurchaseManualJournalsDistributedCosts" (
  "ID" text,
  "ManualJournalID" text,
  "ProductID" text,
  "DistributedCost" numeric,
  "InvoiceTotal" numeric,
  "ValidationText" text,
  "ValidationState" text
);

create table "vPurchaseOrderAttachement" (
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

create table "vPurchaseOrderCostLines" (
  "FakeID" text,
  "TaskID" text,
  "PurchaseCostID" text,
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
  "TaskID" text,
  "OrderLineID" text,
  "ProductID" text,
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
  "BinID" text,
  "Comment" text,
  "NonInventory" boolean,
  "ValidationText" text,
  "ValidationState" text
);

create table "vPurchasePaymentLine" (
  "FakeID" text,
  "TaskID" text,
  "PaymentID" text,
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
  "TaskID" text,
  "ID" text,
  "ProductID" text,
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
  "LocationID" text,
  "NonInventory" boolean,
  "StockReceivingNumber" integer,
  "ValidationText" text,
  "ValidationState" text
);

create table "vPurchaseTaskList" (
  "TaskID" text,
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
  "DropShipTaskID" text,
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
  "TaskID" text,
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
  "DropShipTaskID" text,
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
  "TaskID" text,
  "CardDetailsID" text,
  "CardID" text,
  "Date" timestamptz,
  "ProductID" text,
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
  "SupplierID" text,
  "Name" text,
  "Currency" text,
  "PaymentTerm" text,
  "TaxRule" text,
  "Comments" text,
  "Discount" numeric,
  "AttributeSet" text
);

create table "vPurchase_SupplierAddress" (
  "SupplierID" text,
  "AddressID" text,
  "Line1" text,
  "Line2" text,
  "Type" text,
  "DefaultForType" boolean
);

create table "vPurchase_SupplierContact" (
  "SupplierID" text,
  "ContactID" text,
  "Name" text,
  "IsDefault" boolean,
  "Phone" text
);

create table "vPurchase_TenantAddress" (
  "AddressID" text,
  "Line1" text,
  "Line2" text,
  "Type" text,
  "DefaultForType" boolean,
  "Source" text
);

create table "vReorderSuggestionEmail" (
  "ID" text,
  "CreationDate" timestamptz,
  "ReportID" text,
  "MailingListID" text,
  "LocationID" text,
  "SupplierID" text,
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
  "ProductID" text,
  "ProductName" text,
  "ProductCode" text,
  "Type" text,
  "TaskID" text,
  "Number" text,
  "From" text,
  "To" text,
  "OrderedQty" text
);

create table "vSupplierAddress" (
  "SupplierID" text,
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

create table "vSupplierContact" (
  "SupplierID" text,
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

create table "vSupplierDefaultTemplate" (
  "DefaultTemplateID" text,
  "TemplateID" text,
  "SupplierID" text,
  "Type" text
);

create table "vSupplierFile" (
  "FileID" text,
  "SupplierID" text,
  "FileName" text,
  "ContentType" text,
  "UserName" text,
  "UploadedDate" timestamptz,
  "ExternalDownloadLink" text,
  "ExternalViewLink" text
);

create table "vSupplierList" (
  "SupplierID" text,
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
  "TaskID" text,
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
  "ProductID" text,
  "Quantity" numeric,
  "Price" numeric,
  "TaskID" text,
  "InvoiceDate" timestamptz,
  "SupplierCurrency" text,
  "InvoiceNumber" text,
  "Name" text,
  "ProductCode" text,
  "DropShipTaskID" text,
  "TaskTypeSign" integer,
  "TaskTypeName" text,
  "SupplierSku" text
);

create table "vTaskForDistribution" (
  "TaskID" text,
  "TaskTypeName" text,
  "TaskType" integer,
  "Date" timestamptz,
  "TaskNumber" text,
  "Amount" numeric,
  "Location" text
);

create table "vTenantAddress" (
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

create table "vTenantPaymentTermNew" (
  "TermID" text,
  "Name" text,
  "Days" integer,
  "Method" integer,
  "DueNextMonth" integer,
  "IsActive" boolean,
  "IsDefault" boolean
);
