# Purchase

Suppliers and the purchase documents: simple and advanced purchase orders, service and drop-ship purchases, receiving (stock received / put-away), purchase invoices, credit notes, supplier payments and deposits, and the reorder screens.

| | Count |
|---|---:|
| Pages | 15 |
| Data models | 90 (plus [shared](../00-shared/README.md)) |
| Internal endpoints | 167 (64 write) |
| Public API operations | 49 |

## How to rebuild it

1. **Schema.** Create one table per data model below (90), starting from the generated [`schema.sql`](schema.sql). Ids are GUIDs; join on the `*ID` fields.
2. **Internal API.** Implement each controller's endpoints with the verbs listed, following the [internal API contract](../../docs/INTERNAL-API.md): one URL per store for GET/POST/PUT/DELETE, paged reads returning `{root, total}`, saves wrapped as `{ID, HasErrors, Original, Updated}`.
3. **Screens.** Build each route below as a server-rendered shell that loads the shell bundle and the page's own app, opening a record from `#<guid>` once at load ([page model](../../docs/ARCHITECTURE.md#what-a-page-is)). Every grid, column, field, button and dialog is in [UI.md](UI.md).
4. **Public API.** Expose the 49 operations below under `/ExternalApi/v2` with header auth ([public API contract](../../docs/PUBLIC-API.md)).

## Pages

| Route | Menu label | Title | Bundle | Endpoints (write) |
|---|---|---|---|---:|
| `/DropShipPurchase` | Drop shipment purchase (redirect target) | Drop shipment purchase | `PurchaseDropShip2019` | 70 (39) |
| `/LatestProductPriceBySupplier` | Latest product price by supplier | Product Prices by Supplier | `LatestProductPriceBySupplier2019` | 1 (1) |
| `/LeadSafetyValues` | Supplier lead/safety values | Reorder parameters | `LeadSafetyValues2019` | 1 (1) |
| `/Payment` | Bulk payment (suppliers) | Supplier bulk payment | `Payment2019` | 3 (3) |
| `/Purchase` | Simple purchase | Purchase | `SimplePurchase2019` | 75 (36) |
| `/PurchaseAdvanced` | Advanced purchase | Advanced purchase | `AdvancedPurchase2019` | 77 (38) |
| `/PurchaseCreditNote` | Purchase credit note | Purchase credit note | `PurchaseCreditNote2019` | 64 (26) |
| `/PurchaseList` | Purchases | Purchases | `PurchaseList2019` | 17 (2) |
| `/PurchaseService` | Service purchase | Service purchase | `PurchaseService2019` | 67 (33) |
| `/Reorder` | Reorder | Reorder level of stock | `ReorderLevelOfStock2019` | 5 (1) |
| `/ReorderBackordered` | Reorder backordered | Reorder backordered stock | `ReorderBackorderedStock2019` | 6 (0) |
| `/SuggestReorder` | Reorder suggestion (from the Inventory Velocity Report) | Reorder suggestion | `ReorderSuggestion2019` | 5 (1) |
| `/Supplier` | Supplier | Supplier | `MultilingualSupport2019 Supplier2019` | 20 (7) |
| `/SupplierDeposits` | Supplier deposits | Supplier deposits | `SupplierDeposits2019` | 3 (0) |
| `/SupplierList` | Suppliers | Suppliers | `SupplierList2019` | 3 (2) |

## Data models

ExtJS models the pages use; `v` prefix = view-model. Full DDL in [`schema.sql`](schema.sql).

| Model | Fields |
|---|---|
| `AccountCurrency` | Code:string, Currency:string |
| `AvailableActions` | ID:string, Name:string |
| `CreditNoteLineSelect` | FakeKey:int, ProductID:string, Quantity:float, RemainingQuantity:float, Price:float, Discount:float, Name:string, AccountCode:string, SupplierInventoryCode:string, UnitOfMeasure:string, ProductCode:string, CostingMethod:string, TaxRule:string, TaxPercent:float |
| `CurrencyWithConversionRate` | ResultCurrencyCode:string, Ratio:float, IsBase:bool |
| `Customer` | CustomerID:string, Name:string, Currency:string, PaymentTerm:string, TaxRule:string, Comments:string, DefaultSalesRepresentative:string, AccountCode:string, DefaultLocation:string, Discount:float, DefaultCarrier:string, SalePriceTier:int, CreditLimit:float, IsVATRegistered:bool, PlaceOfSupply:string |
| `DistributionTypeModel` | Value:string, Name:string |
| `FamilyMatrix_Option` | name:string, index:int, values:string |
| `FamilyMatrix_PurchaseProduct` | ProductID:string, Code:string, Name:string, Unit:string, SupplierInventoryCode:string, Cost:float, CostingMethod:string, Account:string, Type:string, TaxRule:string, BinID:string, NonInventory:bool, Option1:string, Option2:string, Option3:string, AddQuantity:float |
| `FamilyMatrix_Value` | name:string |
| `FamilyOption` | value:string |
| `InvoiceForCreditNote` | TaskID:string, Invoice:string, Date:date |
| `Location` | LocationID:string, Description:string |
| `PaymentWrapper` | DimensionsPermission:string, IsAccountingDimensionsEnabled:bool |
| `PeriodModel` | Period:string, Name:string |
| `ProductReplenishmentDetails` | ProductID:string, ProductName:string, OrderQuantity:float, Available:float, OnHand:float, OnOrder:float, MOQ:float, Backordered:float, MinimumBeforeReorder:float, ReorderQuantity:float, SuggestedQuantity:float, InternalId:string, CartonInnerQuantity:float, CartonQuantity:float, NumberOfCartons:float, LineVolume:float, LineVolumeSum:float, ValidationState:string, ValidationText:string |
| `PurchaseExternalPayment` | TaskID:string, PaymentID:string |
| `PurchaseIntStockLineUploadError` | ValidationState:string, ValidationText:string, Line:int, SKU:string, SKUError:string, ProductName:string, ProductNameError:string, BatchSerialNumber:string, BatchSerialNumberError:string, ExpiryDate_YYYYMMDD:string, ExpiryDate_YYYYMMDDError:string, Quantity:string, QuantityError:string, DateReceived_YYYYMMDD:string, DateReceived_YYYYMMDDError:string |
| `PurchaseInvoiceLineUploadError` | ValidationState:string, ValidationText:string, Line:int, SKU:string, SKUError:string, Name:string, NameError:string, Quantity:string, QuantityError:string, Price:string, PriceError:string, Discount:string, DiscountError:string, Comment:string, CommentError:string |
| `PurchaseOrderLineUploadError` | ValidationState:string, ValidationText:string, Line:int, SKU:string, SKUError:string, Name:string, NameError:string, Quantity:string, QuantityError:string, Price:string, PriceError:string, Discount:string, DiscountError:string, Comment:string, CommentError:string |
| `PurchasePriceLookup` | ProductID:string, Price:float |
| `PurchaseReferenceData` | ID:int, OrderViewPermission:string, OrderAuthorisationPermission:string, BillCreditNoteViewPermission:string, BillCreditNoteAuthorisationPermission:string, StockReceivedViewPermission:string, StockReceivedAuthorisationPermission:string, EditAuthorizedDocumentsPermission:string, UndoPermission:string, VoidPermission:string, OrderApproveRejectReviewPermission:string, OtherUsersAttachmentsPermission:string, ProductFamilyCount:int, DefaultAccount:string, TaxCalculationMethod:string, DefaultPurchaseMethod:string, HeadersVisible:string, FixedAssetPermission:string, CurrentAttributeSetId:string, Att… |
| `PurchaseStockTask` | FakeID:string, TaskID:string, Date:date, IntermediateStockReceivedDate:date, StockReceivedDate:date, StockReceivedLocation:string, StockReceivedReceived:bool, IntermediateStockStatus:string, StockStatus:string |
| `PurchaseTask` | TaskID:string, SupplierID:string, SupplierName:string, Contact:string, Phone:string, VendorAddressLine1:string, VendorAddressLine2:string, Currency:string, TaxSchema:string, TaxPercent:float, TaxInclusive:bool, Terms:string, TermDays:int, TermMethod:int, Approach:string, ShippingAddressLine1:string, ShippingAddressLine2:string, ShipmentRequiredByDate:date, BlindReceipt:bool, PurchaseOrderLocation:string, PurchaseOrderNumber:string, PurchaseOrderDate:date, PurchaseOrderMemoInternal:string, PurchaseOrderMemo:string, PurchaseOrderStatus:string, SupplierReference:string, InvoiceDate:date, Invoice… |
| `PurchaseTaskWrapper` | ID:string, Lang:string, ClientDateTime:date, HasErrors:bool, HasPriceInfoAccess:bool, IsAirwallexEnabled:bool |
| `QuickBooksSyncedPurchaseInvoice` | TaskID:string |
| `ReorderEmailReferenceWrapper` | FakeID:int |
| `ReorderEmailWrapper` | ID:string, TenantID:string |
| `ReorderMode` | ReorderMode:string |
| `ReorderSuggestionEmailRecord` | ID:string, ProductID:string, ProductCode:string, ProductName:string, SupplierID:string, SupplierName:string, ReorderQty:float, ReorderDate:date, SupplierSKU:string, MinimumToReorder:float, Available:float, OnOrder:float, Price:float, AvailableAtWarehouse:float, IsSelected:bool, LocationID:string, LocationName:string, Unit:string |
| `Service_CreditNoteLineSelect` | FakeKey:int, Description:string, Quantity:float, RemainingQuantity:string, Price:float, Discount:float, Name:string, AccountCode:string, SupplierInventoryCode:string, UnitOfMeasure:string, ProductCode:string, CostingMethod:string, TaxRule:string, TaxPercent:float |
| `Supplier` | SupplierID:string, Name:string, Contact:string, Phone:string, Email:string, Website:string, Address:string |
| `SupplierDefaultTemplate` | DefaultTemplateID:string, TemplateID:string, Type:string |
| `SupplierStatus` | Value:string, Name:string |
| `SupplierWrapper` | ID:int, HasErrors:bool |
| `TenantLocation` | ID, Name |
| `VerifyInvoiceModel` | ProductID:string, ProductName:string, InvoiceQuantity:float, CartonInnerQuantity:float, CartonQuantity:float, NumberOfCartons:float, LineVolume:float, CartonVolume:float, LineFreightCost:float, UnitFreightCost:float |
| `XeroSyncedPurchaseInvoice` | TaskID:string |
| `listModel` | ID:string, ProductID:string, SupplierID:string, SKU:string, Product:string, Category:string, ProductTags:string, Family:string, Supplier:string, Currency:string, SupplierSKU:string, SupplierProductName:string, URL:string, LatestPrice:float, FixedPrice:float, DropShip:bool |
| `spTaskImportLogEntry` | ID:string, Date:date, DocumentName:string, Comment:string, UserName:string |
| `vBrand` | BrandID:string, Name:string |
| `vCategory` | CategoryID:string, Name:string |
| `vCreditAllocated` | AllocationID:string, TaskID:string, DocNumber:string, Currency:string, Date:date, Amount:float |
| `vDearToDearNetworkingTaskLinks` | ID:string, SourceTaskID:string, SourceType:int, TargetTaskID:string, TargetType:int |
| `vDistributedAmount` | ID:string, TaskID:string, TaskType:string, ValidationText:string, ValidationState:string |
| `vDistributedAmountAccount` | AccountCode:string, AccountAmount:float, AccountName:string, DistributedAmount:float |
| `vDocumentAccount` | AccountCode:string, AccountAmount:float, AccountName:string |
| `vExtractedDocument` | DocumentName:string, Status:string, StatusDescription:string, DateCreated:date, EntityID:string |
| `vInventoryMovement` | FakeID:string, TaskID:string, CardDetailsID:string, CardID:string, Date:date, ProductID:string, Quantity:float, Location:string, Received:bool, Name:string, ProductType:string, SupplierInventoryCode:string, UnitOfMeasure:string, ProductCode:string, CostingMethod:string, BatchSN:string, ExpiryDate:date, SysDate:date, AccountCode:string, InventoryAccount:string, DefaultFixedAssetAccountCode:string, TaxRule:string, ValidationText:string, ValidationState:string, FakeID2:string |
| `vInvoiceAdditionalCostLine` | FakeID:string, TaskID:string, PurchaseCostID:string, Description:string, Reference:string, Quantity:float, Amount:float, Discount:float, TaxRule:string, TaxPercent:float, Tax:float, Total:float, Type:string, LineOrder:int, AccountCode:string, ValidationText:string, ValidationState:string |
| `vInvoiceLine` | FakeID:string, TaskID:string, InvoiceLineID:string, ProductID:string, Quantity:float, Price:float, Discount:float, Tax:float, Total:float, Type:string, AccountCode:string, DefaultFixedAssetAccountCode:string, Name:string, ProductType:string, SupplierInventoryCode:string, UnitOfMeasure:string, ProductCode:string, CostingMethod:string, TaxRule:string, TaxPercent:float, LineOrder:int, BinID:string, Comment:string, NonInventory:bool, ValidationText:string, ValidationState:string |
| `vJobMilestone` | ID:string, Name:string |
| `vPaymentsDue` | TaskID:string, SupplierID:string, InvoiceNumber:string, InvoiceDate:date, DueDate:date, PONumber:string, InvoiceAmount:float, PaidAmount:float, DueAmount:float, DaysOverdue:int, AllocatedAmount:float |
| `vProductionForDistribution` | ProductionRunID:string, ProductionOrderNumber:string, Date:date, Amount:float, Location:string |
| `vPurchaseAllocations` | PurchaseDepositID:string, ID:string, PurchasePaymentID:string, TaskID:string, Flag:bool |
| `vPurchaseBillOfEntryLines` | FakeID:string, TaskID:string, LineID:string, ProductID:string, Quantity:float, Tax:float, Total:float, ExciseTax:float, CustomsTotal:float, Name:string, ProductCode:string, TaxRule:string, LineOrder:int, ValidationText:string, ValidationState:string |
| `vPurchaseCreditNoteCostLine` | FakeID:string, TaskID:string, PurchaseCostID:string, Description:string, Reference:string, Quantity:float, Amount:float, Discount:float, TaxRule:string, TaxPercent:float, Tax:float, Total:float, LineOrder:int, Type:string, AccountCode:string, ValidationText:string, ValidationState:string |
| `vPurchaseCreditNoteLine` | FakeID:string, TaskID:string, InvoiceLineID:string, ProductID:string, Quantity:float, Price:float, Discount:float, Tax:float, Total:float, Type:string, AccountCode:string, Name:string, SupplierInventoryCode:string, UnitOfMeasure:string, ProductCode:string, CostingMethod:string, TaxRule:string, TaxPercent:float, LineOrder:int, Comment:string, ValidationText:string, ValidationState:string |
| `vPurchaseCreditNotePaymentLine` | FakeID:string, TaskID:string, PaymentID:string, Reference:string, DatePaid:date, Type:string, Amount:float, AccountCode:string, CurrencyConversionRate:float, PaymentType:string, ValidationText:string, ValidationState:string |
| `vPurchaseDepositWithDetails` | ID:string, SupplierID:string, Currency:string, Amount:float, RemainingAmount:float, Account:string, Description:string, Date:date, AllocatedAmount:float, Selected:bool, ConvRate:float |
| `vPurchaseDeposits` | ID:string, SupplierID:string, SupplierName:string, Currency:string, Amount:float, RemainingAmount:float, Account:string, SourceLineID:string, CreditSourceTaskID:string, OrigTaskType:string, Type:string, Date:date |
| `vPurchaseDistribution` | ID:string, TaskID:string, InvoiceNumber:string, TaskType:string, ValidationText:string, ValidationState:string |
| `vPurchaseDistributionAccountAmount` | AccountCode:string, AccountAmount:float, AccountName:string, DistributedAmount:float, ValidationText:string, ValidationState:string |
| `vPurchaseExpense` | TaskID:string, AccountCode:string, AccountName:string, Amount:float, Invoices:string, DistributedAmount:float, LeftToDistribute:float, Selected:bool |
| `vPurchaseForDistribution` | TaskID:string, InvoiceNumber:string, InvoiceDate:date, PONumber:string, InvoiceAmount:float, SupplierName:string |
| `vPurchaseManualJournals` | FakeID:string, TaskID:string, ID:string, Reference:string, Amount:float, Date:date, Debit:string, Credit:string, AccrualType:string, DistributeType:string, ProductionRunID:string, ValidationText:string, ValidationState:string |
| `vPurchaseManualJournalsDistributedCosts` | ID:string, ManualJournalID:string, ProductID:string, DistributedCost:float, InvoiceTotal:float, ValidationText:string, ValidationState:string |
| `vPurchaseOrderAttachement` | TaskID:string, AttachementID:string, BlobGUID:string, ContentType:string, FileName:string, Date:date, UserName:string, IsProcessed:bool, ExternalDownloadLink:string, ExternalViewLink:string |
| `vPurchaseOrderCostLines` | FakeID:string, TaskID:string, PurchaseCostID:string, Description:string, Reference:string, Quantity:float, Amount:float, Discount:float, TaxRule:string, TaxPercent:float, Tax:float, Total:float, LineOrder:int, ExpenseAccount:string, ValidationText:string, ValidationState:string |
| `vPurchaseOrderLines` | FakeID:string, TaskID:string, OrderLineID:string, ProductID:string, Quantity:float, Price:float, Discount:float, Tax:float, Total:float, LineOrder:int, Name:string, ProductType:string, SupplierInventoryCode:string, UnitOfMeasure:string, ProductCode:string, CostingMethod:string, InventoryAccount:string, DefaultFixedAssetAccountCode:string, COGSAccount:string, TaxRule:string, TaxPercent:float, BinID:string, Comment:string, NonInventory:bool, ValidationText:string, ValidationState:string |
| `vPurchasePaymentLine` | FakeID:string, TaskID:string, PaymentID:string, Reference:string, DatePaid:date, Type:string, Amount:float, AccountCode:string, CurrencyConversionRate:float, PaymentType:string, ValidationText:string, ValidationState:string |
| `vPurchaseStockIntermediateLines` | FakeID:string, TaskID:string, ID:string, ProductID:string, Quantity:float, UnitCost:float, AccountCode:string, BatchSN:string, Date:date, ExpiryDate:date, Received:bool, ProductName:string, ProductType:string, SupplierInventoryCode:string, UnitOfMeasure:string, ProductCode:string, CostingMethod:string, InventoryAccount:string, DefaultFixedAssetAccountCode:string, COGSAccount:string, LocationID:string, NonInventory:bool, StockReceivingNumber:integer, ValidationText:string, ValidationState:string |
| `vPurchaseTaskList` | TaskID:string, OrderNo:string, Status:string, OrderDate:date, InvoiceDate:date, ShipmentRequiredByDate:date, Supplier:string, Reference:string, POTotalAmount:float, Currency:string, TenantCurrency:string, DropShipTaskID:string, PurchaseOrderStatus:int, BillStatus:string, StockStatus:string, PaymentStatus:string, Selected:bool, Approach:string, DocNumbers:string, Location:string, CustomField1:string, CustomField2:string, CustomField3:string, CustomField4:string, CustomField5:string, CustomField6:string, CustomField7:string, CustomField8:string, CustomField9:string, CustomField10:string, TaskTy… |
| `vPurchaseTaskListAccounting` | ID:string, TaskID:string, Type:int, Supplier:string, Contact:string, Phone:string, Currency:string, Reference:string, CustomField1:string, CustomField2:string, CustomField3:string, CustomField4:string, CustomField5:string, CustomField6:string, CustomField7:string, CustomField8:string, CustomField9:string, CustomField10:string, DropShipTaskID:string, Total:float, Paid:float, Credited:float, Due:float, DaysOverdue:int, DocNo:string, Location:string, PurchaseOrderDate:date, Date:date, DueDate:date, OrderNo:string, Terms:string, Status:string, TaskTypeSign:int, Selected:bool, SimpleTaskTypeSign:i… |
| `vPurchaseUnstock` | FakeID:string, TaskID:string, CardDetailsID:string, CardID:string, Date:date, ProductID:string, Quantity:float, Location:string, Name:string, SupplierInventoryCode:string, UnitOfMeasure:string, ProductCode:string, CostingMethod:string, BatchSN:string, ExpiryDate:date, ValidationText:string, ValidationState:string |
| `vPurchase_Supplier` | SupplierID:string, Name:string, Currency:string, PaymentTerm:string, TaxRule:string, Comments:string, Discount:float, AttributeSet:string |
| `vPurchase_SupplierAddress` | SupplierID:string, AddressID:string, Line1:string, Line2:string, Type:string, DefaultForType:bool |
| `vPurchase_SupplierContact` | SupplierID:string, ContactID:string, Name:string, IsDefault:bool, Phone:string |
| `vPurchase_TenantAddress` | AddressID:string, Line1:string, Line2:string, Type:string, DefaultForType:bool, Source:string |
| `vReorderSuggestionEmail` | ID:string, CreationDate:date, ReportID:string, MailingListID:string, LocationID:string, SupplierID:string, ProductCode:string, LocationName:string, Sent:bool, PurchaseOrderStatus:string, ErrorMessage:string, ValidationText:string, ValidationState:string |
| `vReorderSuggestionEmailRecordTask` | ID:string, RequiredBy:date, ProductID:string, ProductName:string, ProductCode:string, Type:string, TaskID:string, Number:string, From:string, To:string, OrderedQty:string |
| `vSupplierAddress` | SupplierID:string, AddressID:string, Line1:string, Line2:string, CitySuburb:string, StateProvince:string, ZipPostCode:string, Country:string, Type:string, DefaultForType:bool |
| `vSupplierContact` | SupplierID:string, ContactID:string, Name:string, JobTitle:string, Phone:string, MobilePhone:string, Fax:string, Email:string, Website:string, IsDefault:bool, Comment:string |
| `vSupplierDefaultTemplate` | DefaultTemplateID:string, TemplateID:string, SupplierID:string, Type:string |
| `vSupplierFile` | FileID:string, SupplierID:string, FileName:string, ContentType:string, UserName:string, UploadedDate:date, ExternalDownloadLink:string, ExternalViewLink:string |
| `vSupplierList` | SupplierID:string, Name:string, Contact:string, Phone:string, Email:string, Website:string, Address:string, TotalAmount:float, PaidAmount:float, DueAmount:float, Currency:string, TenantCurrency:string, IsActive:bool |
| `vSupplierPurchaseTasks` | TaskID:string, PurchaseOrderNumber:string, Status:string, PurchaseOrderDate:date, SupplierReference:string, Total:float, Paid:float, IsDropShip:bool, TaskTypeSign:int, TaskTypeName:string |
| `vSupplierPurchases` | ID:string, ProductID:string, Quantity:float, Price:float, TaskID:string, InvoiceDate:date, SupplierCurrency:string, InvoiceNumber:string, Name:string, ProductCode:string, DropShipTaskID:string, TaskTypeSign:int, TaskTypeName:string, SupplierSku:string |
| `vTaskForDistribution` | TaskID:string, TaskTypeName:string, TaskType:int, Date:date, TaskNumber:string, Amount:float, Location:string |
| `vTenantAddress` | AddressID:string, Line1:string, Line2:string, CitySuburb:string, StateProvince:string, ZipPostCode:string, Country:string, Type:string, DefaultForType:bool |
| `vTenantPaymentTermNew` | TermID:string, Name:string, Days:int, Method:int, DueNextMonth:int, IsActive:bool, IsDefault:bool |

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

### country

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/country` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |

### currency

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/currency` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |

### Customer

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/Customer_Index_ReferenceData` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |

### DefaultFieldValues

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/DefaultFieldValues` | api | GET POST | 🟠 read + write | entityType |  |  |

### DocumentExtraction

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/DocumentExtraction/Upload` | mvc |  | 🔴 write |  |  |  |
| `/api/DocumentExtraction_BuildEntity` | api | POST | 🔴 write |  |  |  |
| `/api/DocumentExtraction_Index_LogEntries` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  | root |
| `/api/DocumentExtraction_Index_MapExtractedDocument` | api | GET | 🟢 read | entityID entityType |  |  |
| `/api/DocumentExtraction_Index_vExtractedDocument` | api |  | 🟢 read |  |  |  |

### DropShipPurchase

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/DropShipPurchase/Cancel` | mvc | POST | 🔴 write | TaskID removeAllocations |  |  |
| `/DropShipPurchase/CancelCreditNote` | mvc | POST | 🔴 write | RemoveAllocations TaskID |  |  |
| `/DropShipPurchase/CountrySpecific` | mvc |  | 🟢 read | Key |  |  |
| `/DropShipPurchase/Undo` | mvc | POST | 🔴 write | TaskID removeAllocations |  |  |
| `/api/DropShipPurchase_Index_vPurchaseTask` | api | PUT REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | CountrySpecificKey id lang | ClientDateTime HasErrors ID Lang Original Updated |  |

### ExpenseDestribution

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/ExpenseDestribution_ProductionForDistribution` | api |  | 🟢 read |  |  |  |
| `/api/ExpenseDestribution_PurchaseForDistribution` | api |  | 🟢 read |  |  |  |
| `/api/ExpenseDestribution_TaskForDistribution` | api |  | 🟢 read |  |  |  |

### FinishedGoodsTask

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/FinishedGoodsTask_Index_vPurchaseExpense` | api |  | 🟢 read |  |  |  |

### FixedAssetType

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/FixedAssetType_Index_vFixedAssetType` | api | POST PUT REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | filter id search |  | vFixedAssetTypes |

### GetRate

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/GetRate` | api | GET | 🟢 read | From |  |  |

### LatestProductPriceBySupplier

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/LatestProductPriceBySupplier/Import` | mvc | GET(navigate) | 🔴 write | ref |  |  |
| `/api/LatestProductPriceBySupplier_List` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | search |  | root |

### LeadSafetyValues

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/LeadSafetyValues/Import` | mvc | GET(navigate) | 🔴 write | ref |  |  |
| `/api/LeadSafetyValues_List` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | search |  | root |

### MySubscription

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/MySubscription/DetailsUpdate` | mvc | GET | 🔴 write |  |  |  |

### Payment

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/Payment_Index_Supplier` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | lang |  |  |
| `/api/Payment_Index_vChartOfAccounts` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/Payment_Index_vPaymentsDue` | api | POST REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |

### Preset

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/Preset` | api | DELETE GET POST | 🟠 read + write | lang presetFor presetID search | Name OrderCostID |  |

### Product

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/Product_GetAutogenerationFlag` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |

### ProductionOrder

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/ProductionOrder_Index_ConsumptionBins` | api | POST | 🟢 read |  |  |  |

### Purchase

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/Purchase/Cancel` | mvc | POST | 🔴 write | TaskID removeAllocations |  |  |
| `/Purchase/CancelCreditNote` | mvc | POST | 🔴 write | RemoveAllocations TaskID |  |  |
| `/Purchase/CountrySpecific` | mvc |  | 🟢 read | Key |  |  |
| `/Purchase/CreditNoteDepositValidate` | mvc | POST | 🟢 read | TaskID |  |  |
| `/Purchase/DepositValidate` | mvc | POST | 🟢 read | TaskID |  |  |
| `/Purchase/Download` | mvc | GET POST | 🟢 read | PrintEntityID PrintTemplateID |  |  |
| `/Purchase/GetDepositAllocatedPayments` | mvc | POST | 🟢 read | PurchaseDepositID |  |  |
| `/Purchase/Print` | mvc | GET | 🟢 read (logs) | PrintEntityID PrintTemplateID |  |  |
| `/Purchase/PrintReceiveTo` | mvc | POST | 🟢 read (logs) | PrintTemplateID |  |  |
| `/Purchase/Undo` | mvc | POST | 🔴 write | TaskID removeAllocations |  |  |
| `/Purchase/UndoJournals` | mvc | POST | 🔴 write | TaskID |  |  |
| `/Purchase/Upload` | mvc | POST | 🔴 write |  |  |  |
| `/Purchase/UploadIntermediateStockReceivedTemplate` | mvc | POST | 🔴 write |  |  |  |
| `/Purchase/UploadInvoiceTemplate` | mvc | POST | 🔴 write |  |  |  |
| `/Purchase/UploadPOLinesTemplate` | mvc | POST | 🔴 write |  |  |  |
| `/Purchase/UploadStockReceivedTemplate` | mvc | POST | 🔴 write |  |  |  |
| `/api/Purchase_DocumentExtraction` | api | POST PUT | 🔴 write |  |  |  |
| `/api/Purchase_Index_AttributeColumnName` | api | GET(navigate) REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Purchase_Index_CoManCheck` | api | GET | 🟢 read | taskID |  |  |
| `/api/Purchase_Index_CoManCheck/CanBeCompleted` | api | POST | 🟢 read | masterTaskID taskID |  |  |
| `/api/Purchase_Index_CoManCheck/HasProduction` | api | GET | 🟢 read | masterTaskID taskID |  |  |
| `/api/Purchase_Index_Family` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Purchase_Index_FamilyMatrixProduct` | api |  | 🟢 read |  |  |  |
| `/api/Purchase_Index_FamilyProducts` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Purchase_Index_History` | api |  | 🟢 read |  |  |  |
| `/api/Purchase_Index_Job` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ID |  |  |
| `/api/Purchase_Index_PayWithAirwallex` | api | GET | 🔴 write | invoiceTaskID |  |  |
| `/api/Purchase_Index_PayWithSetle` | api | GET | 🔴 write | invoiceTaskID |  |  |
| `/api/Purchase_Index_Product` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | HideNonInventory SupplierID lang |  |  |
| `/api/Purchase_Index_ProductReplenishmentDetails` | api | POST | 🟢 read |  |  |  |
| `/api/Purchase_Index_ProductionForDistribution` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | Number |  |  |
| `/api/Purchase_Index_PurchaseForDistribution` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | InvoiceNumber excludeTaskID |  |  |
| `/api/Purchase_Index_SaleOrder/Prefill` | api | GET | 🟢 read | currentUILang onlyBackorder saleID |  |  |
| `/api/Purchase_Index_SaleOrder/SupplierProducts` | api | POST | 🟢 read | supplierID |  |  |
| `/api/Purchase_Index_Service` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | SupplierID |  |  |
| `/api/Purchase_Index_TaskForDistribution` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | Number |  |  |
| `/api/Purchase_Index_Transactions` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Purchase_Index_UndoVoidAccess` | api | GET | 🟢 read |  |  |  |
| `/api/Purchase_Index_VerifyInvoice` | api | POST | 🟢 read |  |  |  |
| `/api/Purchase_Index_WorkflowHistory` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | entityID |  |  |
| `/api/Purchase_Index_XeroLink` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | TaskID |  |  |
| `/api/Purchase_Index_vJobMilestones` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | jobID |  |  |
| `/api/Purchase_Index_vPurchaseDeposit` | api | POST REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | SupplierID TaskID |  |  |
| `/api/Purchase_Index_vPurchaseExpense` | api | DELETE POST REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | taskID | AccountCode OriginalPurchaseDate ProductionExpenseDistributions PurchaseExpenseDistributions TaskExpenseDistributions |  |
| `/api/Purchase_Index_vPurchaseList` | api | POST REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ID filter lang search |  | root |
| `/api/Purchase_Index_vPurchaseListAccounting` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | filter lang search |  | root |
| `/api/Purchase_Index_vPurchaseOrderAttachement` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | TaskID |  |  |
| `/api/Purchase_Index_vPurchaseTask` | api | POST PUT REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | CountrySpecificKey id lang | IsAirwallexEnabled Original PurchaseExternalPayments QuickBooksSyncedInvoices Updated XeroSyncedInvoices |  |
| `/api/Purchase_Index_vPurchase_LocationAddress` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | Location |  |  |
| `/api/Purchase_Index_vPurchase_Supplier` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | CountrySpecificKey Name lang |  |  |
| `/api/Purchase_Index_vPurchase_SupplierAddress` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | SupplierID |  |  |
| `/api/Purchase_Index_vPurchase_SupplierContact` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | SupplierID |  |  |
| `/api/Purchase_Index_vPurchase_SupplierDefaultTemplate` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | SupplierID |  |  |
| `/api/Purchase_Index_vPurchase_SupplierSKU` | api | POST | 🟢 read | supplierID |  |  |
| `/api/Purchase_Index_vSupplier` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/Purchase_Index_vSupplierAddress` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/Purchase_Index_vSupplierContact` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/Purchase_Index_vTenantAddress` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/Purchase_Index_vTenantLocation` | api | GET REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | assetsOnly locationID withBins |  |  |
| `/api/Purchase_Invoice_CheckForDeposits` | api | GET | 🟢 read | SupplierID |  |  |
| `/api/Purchase_Invoice_CheckForName` | api | POST | 🟢 read | InvoiceNumbers SupplierID |  |  |
| `/api/Purchase_Invoice_PriceLookup` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ProductIDList SupplierID |  |  |
| `/api/Purchase_RelatedTasks` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | taskId |  | root |
| `/api/Purchase_Scan` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | SupplierID lang search |  |  |
| `/api/Purchase_Scan_InventoryMode` | api | POST | 🟢 read | SupplierID barcodes lang |  |  |

### PurchaseAdvanced

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/PurchaseAdvanced/Cancel` | mvc | POST | 🔴 write | TaskID removeAllocations |  |  |
| `/PurchaseAdvanced/CancelChild` | mvc | POST | 🔴 write | TaskID TaskTypeSign |  |  |
| `/PurchaseAdvanced/CountrySpecific` | mvc |  | 🟢 read | Key |  |  |
| `/PurchaseAdvanced/Undo` | mvc | POST | 🔴 write | TaskID removeAllocations |  |  |
| `/PurchaseAdvanced/UndoChild` | mvc | POST | 🔴 write | TaskID TaskTypeSign |  |  |
| `/api/PurchaseAdvanced_Index_History` | api |  | 🟢 read |  |  |  |
| `/api/PurchaseAdvanced_Index_InventoryMovementsWithAmount` | api | GET | 🟢 read | invoiceTaskID |  |  |
| `/api/PurchaseAdvanced_Index_Transactions` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/PurchaseAdvanced_Index_XeroLink` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | TaskID |  |  |
| `/api/PurchaseAdvanced_Index_vPurchaseDeposit` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | SupplierID TaskID |  |  |
| `/api/PurchaseAdvanced_Index_vPurchaseOrderAttachement` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | TaskID |  |  |
| `/api/PurchaseAdvanced_Index_vPurchaseTask` | api | POST PUT REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | CountrySpecificKey id lang | IsAirwallexEnabled Original PurchaseExternalPayments QuickBooksSyncedInvoices Updated XeroSyncedInvoices |  |

### PurchaseCreditNote

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/PurchaseCreditNote/CountrySpecific` | mvc |  | 🟢 read | Key |  |  |
| `/api/PurchaseCreditNote_Index_vPurchaseTask` | api | POST PUT REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | CountrySpecificKey id lang | ClientDateTime CountrySpecificKey HasErrors ID Lang Original Updated |  |

### PurchaseList

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/PurchaseList/Print` | mvc | POST | 🟢 read (logs) | IDList TemplateID |  |  |
| `/api/PurchaseList_Index_ReportTemplates` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |

### PurchaseListBulkAction

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/PurchaseListBulkAction` | api | POST | 🔴 write | Action CaptchaToken ID PrimaryID TemplateID |  |  |

### PurchaseService

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/PurchaseService/CountrySpecific` | mvc |  | 🟢 read | Key |  |  |
| `/api/PurchaseService_Index_vPurchaseTask` | api | POST PUT REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | CountrySpecificKey id lang | IsAirwallexEnabled Original PurchaseExternalPayments QuickBooksSyncedInvoices Updated XeroSyncedInvoices |  |

### QuoteNOrderApprove

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/QuoteNOrderApprove/Approve` | mvc | POST | 🔴 write | newState taskID taskType |  |  |

### QuoteNOrderArchive

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/QuoteNOrderArchive/Archive` | mvc | POST | 🔴 write | taskID |  |  |
| `/QuoteNOrderArchive/ArchivePurchase` | mvc | POST | 🔴 write | taskID |  |  |

### Reorder

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/Reorder_Index_Locations` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Reorder_Index_Products` | api | POST | 🔴 write |  |  |  |
| `/api/Reorder_Index_Products/search` | api | POST(read) | 🟢 read |  |  | root |
| `/api/Reorder_Index_Suppliers` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | LocationID lang search |  | root |
| `/api/Reorder_Index_Tenant` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |

### ReorderBackordered

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/ReorderBackordered_Index_Customer` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | lang |  |  |
| `/api/ReorderBackordered_Index_Location` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | lang |  |  |
| `/api/ReorderBackordered_Index_Products` | api | POST REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | Criteria CustomerID LocationID Tag lang |  |  |
| `/api/ReorderBackordered_Index_ProductsWithOutSupplier` | api | GET | 🟢 read |  |  |  |
| `/api/ReorderBackordered_Index_Suppliers` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | CustomerID LocationID Tag lang search |  | root |
| `/api/ReorderBackordered_Index_Tags` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |

### Sale

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/Sale_Index_vSale_Customer` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | CountrySpecificKey Name lang |  |  |

### SaleCommon

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/SaleCommon_TaxRules/sale` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |

### SaleService

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/SaleService/CountrySpecific` | mvc |  | 🟢 read | Key |  |  |

### SuggestReorder

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/SuggestReorder_Index_Access` | api | GET | 🟢 read | hash |  |  |
| `/api/SuggestReorder_Index_AvailableReorderActions` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/SuggestReorder_Index_Email` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | id locationId productId reportId supplierId |  |  |
| `/api/SuggestReorder_Index_vEmailRecordTasks` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | Locations hash locationFromCache search |  | root |
| `/api/SuggestReorder_Index_vEmailRecords` | api | POST REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | Locations ReorderType SupplierID WarehouseID hash locationFromCache search |  | root |

### Supplier

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/Supplier/CountrySpecific` | mvc |  | 🟢 read | Key |  |  |
| `/Supplier/DownloadFile` | mvc |  | 🟢 read | id |  |  |
| `/Supplier/Upload` | mvc | POST | 🔴 write |  |  |  |
| `/api/Supplier_Index_ReferenceData` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Supplier_Index_vPurchaseTasks` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | SupplierID search |  | root |
| `/api/Supplier_Index_vReportTemplates` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Supplier_Index_vSupplier` | api | POST PUT REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | CountrySpecificKey id | HasErrors ID Original Updated |  |
| `/api/Supplier_Index_vSupplierPurchases` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | SupplierID search |  | root |

### supplier

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/supplier_Index_vSupplierFile` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | SupplierID |  |  |

### SupplierDeposits

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/SupplierDeposits_Index_vAccounts` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  | root |
| `/api/SupplierDeposits_Index_vAllocation` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | PurchaseDepositID |  | root |
| `/api/SupplierDeposits_Index_vList` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | search usedDeposits |  | root |

### SupplierList

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/SupplierList_Index_DeleteDeprecated` | api | POST | 🔴 write |  |  |  |
| `/api/SupplierList_Index_vSupplierList` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | IsActive lang search |  | root |
| `/api/SupplierList_Merge` | api | POST | 🔴 write |  |  |  |

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
| `/api/TenantAttributeSet_Index_vTenantAttributeSet/GetCopyFrom` | api | GET | 🟢 read | entityID entityType fromID id |  |  |

### TenantGeneralSettings

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/TenantGeneralSettings_Index_vMultilingualSupport` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | newItem |  |  |
| `/api/TenantGeneralSettings_Index_vMultilingualSupportAccess` | api |  | 🟢 read |  |  |  |
| `/api/TenantGeneralSettings_Index_vTenant/short` | api | GET | 🟢 read |  |  |  |

### TenantLocation

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/TenantLocation_Index_BinSuggestion` | api | GET POST | 🟢 read | locationID purchaseID |  |  |

### TenantPaymentTerm

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/TenantPaymentTerm_Index_vTenantPaymentTerm` | api | DELETE REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | id |  |  |

## Public API (`/ExternalApi/v2`)

| Group | Method | Path | Query / params |
|---|---|---|---|
| Purchase | DELETE | `/advanced-purchase` | ID,Void |
| Purchase | GET | `/advanced-purchase` | ID,CombineAdditionalCharges |
| Purchase | POST | `/advanced-purchase` |  |
| Purchase | PUT | `/advanced-purchase` |  |
| Purchase | DELETE | `/advanced-purchase/creditnote` | TaskID |
| Purchase | GET | `/advanced-purchase/creditnote` | PurchaseID,CombineAdditionalCharges |
| Purchase | POST | `/advanced-purchase/creditnote` |  |
| Purchase | DELETE | `/advanced-purchase/invoice` | TaskID,Void |
| Purchase | GET | `/advanced-purchase/invoice` | PurchaseID,CombineAdditionalCharges |
| Purchase | POST | `/advanced-purchase/invoice` |  |
| Purchase | GET | `/advanced-purchase/manualJournal` | PurchaseID |
| Purchase | POST | `/advanced-purchase/manualJournal` |  |
| Purchase | GET | `/advanced-purchase/payment` | PurchaseID,OrderNumber,InvoiceNumber,CreditNoteNumber |
| Purchase | POST | `/advanced-purchase/payment` |  |
| Purchase | PUT | `/advanced-purchase/payment` |  |
| Purchase | GET | `/advanced-purchase/put-away` | PurchaseID |
| Purchase | POST | `/advanced-purchase/put-away` |  |
| Purchase | DELETE | `/advanced-purchase/stock` | TaskID,Void |
| Purchase | GET | `/advanced-purchase/stock` | PurchaseID |
| Purchase | POST | `/advanced-purchase/stock` |  |
| Purchase | PUT | `/advanced-purchase/stock` |  |
| Purchase | DELETE | `/purchase` | ID,Void |
| Purchase | GET | `/purchase` | ID,CombineAdditionalCharges |
| Purchase | POST | `/purchase` |  |
| Purchase | PUT | `/purchase` |  |
| Purchase | DELETE | `/purchase/attachment` | ID |
| Purchase | GET | `/purchase/attachment` | TaskID |
| Purchase | POST | `/purchase/attachment` |  |
| Purchase | GET | `/purchase/creditnote` | TaskID,CombineAdditionalCharges |
| Purchase | POST | `/purchase/creditnote` |  |
| Purchase | GET | `/purchase/invoice` | TaskID,CombineAdditionalCharges |
| Purchase | POST | `/purchase/invoice` |  |
| Purchase | GET | `/purchase/manualJournal` | TaskID |
| Purchase | POST | `/purchase/manualJournal` |  |
| Purchase | GET | `/purchase/order` | TaskID,CombineAdditionalCharges |
| Purchase | POST | `/purchase/order` |  |
| Purchase | DELETE | `/purchase/payment` | ID,DeleteAllocation |
| Purchase | DELETE | `/purchase/payment` | ID,DeleteAllocation |
| Purchase | GET | `/purchase/payment` | TaskID |
| Purchase | POST | `/purchase/payment` |  |
| Purchase | PUT | `/purchase/payment` |  |
| Purchase | GET | `/purchase/stock` | TaskID |
| Purchase | POST | `/purchase/stock` |  |
| Purchase | GET | `/purchaseCreditNoteList` | Page,Limit,Search,UpdatedSince,CreditNoteStatus |
| Purchase | GET | `/purchaseList` | Page,Limit,Search,RequiredBy,UpdatedSince,OrderStatus,RestockReceivedStatus,InvoiceStatus,CreditNoteStatus,UnstockStatus,DropShipTaskID |
| Supplier | GET | `/ref/supplier/deposits` | Page,Limit,SupplierID,ShowUsedDeposits |
| Supplier | GET | `/supplier` | Page,Limit,ID,Name,ModifiedSince,IncludeDeprecated |
| Supplier | POST | `/supplier` |  |
| Supplier | PUT | `/supplier` |  |
