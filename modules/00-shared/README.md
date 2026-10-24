# Shared data models

83 models used across 4+ modules (or by shared bundles only). Build these first; every module's schema joins to them. DDL in [`schema.sql`](schema.sql).

| Model | Fields | Modules |
|---|---|---|
| `AccessInfo` | TenantID:string, UserID:string, Access:string, Subscription:string, SubscriptionCategory:string, AvailablePriceTiers:int, ImpersonatedUserName:string, ImpersonatedTenantID:string, UserName:string, FailedPaymentID:string, Xero:bool, Quickbooks:bool, Connected:bool, Organisation:string, Currency:string, Company:string, NotificationText:string, DateFormat:string, OpenDetailsInNewTabs:bool, ValidSession:bool, EnableFinancials:bool, ForceLogOff:bool, Locale:string, ProductImageUrl:string, ProductFamilyImageUrl:string, DaysRemaining:int, GettingStartedGuideLink:string, Country:string, CountrySpecif… | shell |
| `ActivityLogLine` | Date:date, Category:string, ID:string, TaskID:string, Total:int, Message:string, Reference:string, UserName:string | shell |
| `AddressInfo` | description:string, place_id:string, terms:object | 05-purchase, 06-sale, 07-production, 09-crm, 13-settings |
| `AutoPick` | ProductID:string, BinID:string, BinName:string, ProductCode:string, Name:string, Available:float, Quantity:float, Cost:float, CostingMethod:string, BatchSN:string, ExpiryDate:date, Unit:string, IsFirst:bool | 04-inventory, 06-sale, 07-production, 09-crm |
| `BankFeeAndMoneyTaskAdjustmentModel` | ID:string, To:string, Description:string, AccountCode:string, TaxRate:string, Amount:float, TransactionType:string | shell |
| `CostingMethod` | CostingMethod:string, DisplayName:string | shell |
| `Country` | Code:string, Name:string | 05-purchase, 06-sale, 09-crm, 13-settings, 14-reference-books |
| `Currency` | Code:string, Name:string | 05-purchase, 06-sale, 08-financials, 09-crm, 10-ai, 12-integrations, 13-settings, 14-reference-books |
| `DeliveryItem` | DeliveryItemID:string, ProductID:string, Quantity:float, ProductName:string, ProductCode:string, TaskID:string, TaskStatus:string, DeliveryNumber:string, ProductSearch:string, DeliveryDateStr:string | shell |
| `DropShipMode` | DropShipMode:string, DisplayName:string | shell |
| `Ext.grid.property.Property` | name:string, value | shell |
| `Family` | ID:string, Name:string, Option1Name:string, Option1Values:string, Option2Name:string, Option2Values:string, Option3Name:string, Option3Values:string | 04-inventory, 05-purchase, 06-sale, 09-crm, 14-reference-books |
| `History` | EntryID:string, ColumnsChanged:string, DateChanged:date, ChangedBy:string | 05-purchase, 06-sale, 08-financials, 09-crm |
| `Integrate` | Code:string, Name:string | shell |
| `LocationsSettingsModel` | LocationID:string, LocationName:string, Level:int, ParentID:string, IsActive:bool | shell |
| `MappingReferenceData` | ID:string, HasHeaderRow:bool, DemoRowsCount:int, SignatureHashFound:bool, SignatureHash:string | shell |
| `MinorAdjustmentModel` | ID:string, Amount:float | shell |
| `NotificationModel` | Id:string, Type:string, Notification:string, References:string, ConfirmToDelete:bool | shell |
| `PartnerAccessInfo` | ImpersonatedUserName:string, UserName:string, Company:string, DisplayName:string, TenantID:string | shell |
| `PhoneCountryCode` | ID:string, CountryCode:string, Code2:string, PhoneAreaCode:string, EnableOnlyEmailVerification:boolean, Name:string, SortPriority:int, FullName:string, FullCode:string | shell |
| `Product` | ProductID:string, Code:string, Name:string, Unit:string, SupplierInventoryCode:string, Cost:float, CostingMethod:string, Account:string, Type:string, TaxRule:string, BinID:string, NonInventory:bool | 04-inventory, 05-purchase, 06-sale, 07-production, 09-crm, 12-integrations, 14-reference-books |
| `ProductWithAttachments` | Name:string, Id:string | shell |
| `ProductsAffectedProductsModel` | Location:string, ProductCode:string, ProductName:string | shell |
| `ProductsRulesModel` | ProductRuleID:string, CustomFilterID:string, Name:string, Priority:int, CriteriaSummary:string, AffectedProductsCount:auto | shell |
| `ProductsSettingsModel` | Selected:bool, IsActive:bool, DefaultIsActive:bool, ProductID:string, LocationID:string, ProductCode:string, ProductName:string, Category:string, Brand:string, ProductUnit:string, Available:float, LocationName:string, SupplierName:string, Lead:int, DefaultLeadTime:int, SoldLast1Month:float, SoldLast3Months:float, SoldLast6Months:float, SoldLast12Months:float, Segment:string, SettingID:string, MinimumOrderQuantity:float, Packing:float, CanBeOrdered:bool, MinimumStockQuantity:float, MaximumStockQuantity:float, MaximumStockDays:int, OrderPeriod:int, DefaultOrderPeriod:int, DefaultReplenishedBy:s… | shell |
| `ReferenceDataWrapper` | ID:int, Permission:string, CustomerOnCreditHoldPermission:string, DefaultTaxRule:string, IsAccountingDimensionsEnabled:bool, DimensionsPermission:string | 04-inventory, 05-purchase, 06-sale, 07-production, 08-financials, 09-crm, 10-ai, 12-integrations, 14-reference-books |
| `ReportTemplate` | TemplateID:string, Type:string, Name:string | 04-inventory, 05-purchase, 06-sale, 07-production, 08-financials, 09-crm, 14-reference-books |
| `ScanProduct` | ProductID:string, Barcode:string, CostingMethod:string, Name:string, SKU:string, SupplierSKU:string, UOM:string, InventoryAccount:string, COGSAccount:string, TaxRule:string, Price:float, BinID:string, NonInventory:bool | 04-inventory, 05-purchase, 06-sale, 07-production |
| `SelectedList` | CustomerID:string, Name:string | 04-inventory, 05-purchase, 06-sale, 08-financials, 09-crm, 13-settings, 14-reference-books |
| `SkuAutogenerationFlagModel` | Value:bool | 05-purchase, 06-sale, 09-crm, 14-reference-books |
| `Tag` | Value:string | 04-inventory, 05-purchase, 12-integrations, 14-reference-books |
| `Tags` | Value:string | 04-inventory, 06-sale, 07-production, 12-integrations, 14-reference-books |
| `TimeZone` | name:string, displayName:string, offset:string | shell |
| `TransactionModel` | TransactionID:string, BankStatementID:string, TenantID:string, Date:date, Reference:string, PaymentReference:string, Description:string, Status:string, Amount:float, AccountCode:string, Selected:bool | shell |
| `WorkflowHistory` | WorkflowHistoryID:string, WorkflowID:string, EntityID:string, EntityType:string, ChildEntityID:string, ChildEntityType:string, Name:string, Description:string, State:string, DateUtc:date, WorkflowName:string, EventName:string | 05-purchase, 06-sale, 07-production, 09-crm |
| `XeroLink` | ID:string, Type:string, TaskID:string | 05-purchase, 06-sale, 08-financials, 09-crm |
| `stripePaymentLogEntry` | Id:string, SaleTaskId:string, Amount:float, AccountCode:string, AccountName:string, Currency:string, SaleInvoiceNumber:string, StatusText:string, StripePaymentId:string, IsTestMode:boolean, InitTime:date, LastUpdateTime:date | shell |
| `vAccountingDimensionsRealTemp` | EntityType:string, AccountCode:string, AccountName:string, ReferenceNumber:string, Amount:float, EffectiveDate:date, ProductID:string, ProductCode:string, ProductName:string, CustomerID:string, CustomerName:string, SupplierID:string, SupplierName:string, ExpenseItem:string, ProductionResource:string, CompanyContact:string | 04-inventory, 05-purchase, 06-sale, 07-production, 08-financials |
| `vAvailableCompanies` | TenantID:string, UserName:string, Company:string, IsExpired:bool | shell |
| `vBalanceInfo` | ID:string, BalanceInDearTxt:string, StatementBalanceTxt:string, LastDate:string | shell |
| `vBankStatement` | StatementID:string, ImportedDate:date, StartDate:date, EndDate:date, Status:string, OpenBalance:float, DeltaBalance:float, CloseBalance:float | shell |
| `vBankTransactionMappingProfile` | ProfileID:string, Name:string, Data:string, DateFormat:string, Hash:string | shell |
| `vChartOfAccounts` | Code:string, OldCode:string, Status:string, Name:string, Type:string, TaxType:string, Description:string, Class:string, SystemAccount:string, BankAccountNumber:string, CurrencyCode:string, BankAccountId:string, ForPayments:bool | 03-dashboard, 04-inventory, 05-purchase, 06-sale, 07-production, 08-financials, 09-crm, 10-ai, 11-reports, 12-integrations, 13-settings, 14-reference-books |
| `vCustomer` | CustomerID:string, Name:string | 04-inventory, 06-sale, 07-production, 08-financials, 09-crm, 10-ai, 12-integrations, 14-reference-books |
| `vCustomerWithSupplier` | ID:string, Name:string, DefaultTaxRule:string, DefaultAccount:string, Type:string | shell |
| `vDeliveryNote` | TaskID:string, Note:string, UserName:string, DateTime:date | shell |
| `vDiscount` | ID:string, Name:string, Type:string | 04-inventory, 06-sale, 09-crm, 14-reference-books |
| `vFilterBarcode` | Name:string | shell |
| `vFilterProduct` | ID:string, Name:string, ProductCode:string | shell |
| `vFixedAssetType` | FixedAssetTypeID:string, Name:string | 04-inventory, 05-purchase, 08-financials, 14-reference-books |
| `vMappingSettings` | Source, Data, Target | shell |
| `vMoneyTaskTenantTaxationRule` | RuleID:string, Description:string, EffectivePercentExclusive:float, EffectivePercentInclusive:float, EffectivePercent:float, Inclusive:bool | shell |
| `vMultilingualTemplateDatas` | TemplateCode:string, TemplateName:string, FieldName:string, Text:string | 04-inventory, 05-purchase, 06-sale, 09-crm |
| `vMultilingualTemplateNewDatas` | Code:string, Name:string, IsDefault:bool | 04-inventory, 05-purchase, 06-sale, 09-crm |
| `vProduct` | ProductID:string, SkuAutogenerationFlag:bool, ProductCode:string, Name:string, Category:string, Type:string, DefaultUnitOfMeasure:string, CostingMethod:string, ExpenseAccount:string, MinimumBeforeReorder:float, ReorderQuantity:float, QuantityToProduce:float, ProductAttributeSet:string, Barcode:string, CustomField1:string, CustomField2:string, CustomField3:string, CustomField4:string, CustomField5:string, CustomField6:string, CustomField7:string, CustomField8:string, CustomField9:string, CustomField10:string, Status:string, StockLocator:string, DropShipMode:string, PurchaseTaxRule:string, Sale… | 04-inventory, 05-purchase, 06-sale, 07-production, 09-crm, 11-reports, 12-integrations, 14-reference-books |
| `vProductAlternativeStock` | FakeID:string, ProductID:string, ProductCode:string, ProductName:string, LocationName:string, Price:float, OnHand:float, Available:float, OnOrder:float, Allocated:float, RequiredQuantityKoeff:float | shell |
| `vProductFamily` | ID:string, Name:string | 04-inventory, 05-purchase, 12-integrations, 14-reference-books |
| `vRecStatement` | ID:string, Name:string | shell |
| `vReconcilation` | ReconcileID:string, AccountID:string, BankStatementID:string, TransactionID:string, Date:date, Reference:string, PaymentReference:string, Description:string, Amount:float, Contractor:string, AccountCode:string, Currency:string, CurrencyConversionRate:float, MatchFound:bool, Comment:string, LinkObjectName:string, LineID:string, SaleTaskID:string, PurchaseTaskID:string, MoneyTaskID:string, ExpenseClaimTaskID:string, MapCount:float, ReconciledAmount:float, AdditionalData:string, DocDate:date, DocPerson:string, DocCurrency:string, DocReference:string, DocDescription:string, DocCurrencyConversionR… | shell |
| `vReconcilationMatchList` | ID:string, TaskID:string, EffectiveDate:date, ObjType:string, Type:string, Description:string, Reference:string, Amount:float, CurrencyConversionRate:float, Currency:string, Payee:string, Reserved:string, ReservedInternal:float, ReservedInternal2:float, Split:int, Selected:bool | shell |
| `vRelatedOrder` | TaskID:string, TaskType:string, TaskTypeName:string, TaskNumber:string, OrderDate:date, Status:string, TotalAmount:float, TotalCountRows:int | 05-purchase, 06-sale, 07-production, 10-ai |
| `vRelatedOrderDetails` | ProductID:string, ProductCode:string, Name:string, Quantity:float, Unit:string | 05-purchase, 06-sale, 07-production, 10-ai |
| `vSale_Customer` | CustomerID:string, Name:string | 05-purchase, 06-sale, 10-ai, 14-reference-books |
| `vSalesPriceTier` | Code:int, Name:string | 04-inventory, 05-purchase, 06-sale, 08-financials, 09-crm, 10-ai, 12-integrations, 14-reference-books |
| `vStandardEntity` | ID:string, Name:string | shell |
| `vStockTransferList` | TaskID:string, Date:date, From:string, To:string, Status:string, Number:string, LastUpdatedBy:string, CustomerReference:string, IsFBA:bool | shell |
| `vSupplier` | SupplierID:string, Name:string, Currency:string, PaymentTerm:string, TaxRule:string, DefaultPaymentMethod:string, DefaultCarrier:string, AccountCode:string, Comments:string, TaxNumber:string, IsActive:bool, Discount:float, CountrySpecificKey:string, CountrySpecificData:string, AttributeSet:string | 04-inventory, 05-purchase, 06-sale, 07-production, 08-financials, 09-crm, 12-integrations, 14-reference-books |
| `vSyncHistory` | EntryID:string, DateCreated:date, Status:int, Error:string, Description:string, QBID:string, Entity:int, IsConsolidated:boolean, IsSelected:boolean | shell |
| `vTag` | Value:string | 04-inventory, 05-purchase, 09-crm, 14-reference-books |
| `vTask` | TaskID:string, TenantID:string, UserID:string, TaskCategoryID:string, IsCategoryPredefined:string, Name:string, Details:string, StartDate:date, EndDate:date, CompletedDate:date, Sequence:int, WorkflowID:string, UserName:string, TaskCategoryName:string, TaskCategoryColor:string, WorkflowName:string, IsToday:bool, IsOverdue:bool, IsCompleted:bool, WorkflowProcessID:string, IsAllDay:bool, EntityID:string, EntityType:string, EntityName:string, MasterEntityID:string, IsOwner:bool, WorkflowProcessState:string, ValidationText:string, ValidationText:string | shell |
| `vTaskFile` | FileID:string, TaskID:string, FileName:string, ContentType:string, UserName:string, UploadedDate:date, ExternalDownloadLink:string, ExternalViewLink:string | shell |
| `vTenantAttributeSet` | SetID:string, Name:string, Column1:string, Column2:string, Column3:string, Column4:string, Column5:string, Column6:string, Column7:string, Column8:string, Column9:string, Column10:string | 04-inventory, 05-purchase, 06-sale, 07-production, 08-financials, 09-crm, 13-settings, 14-reference-books |
| `vTenantBrand` | ID:string, Brand:string | 04-inventory, 08-financials, 09-crm, 12-integrations, 14-reference-books |
| `vTenantCarrier` | CarrierID:string, Description:string | 05-purchase, 06-sale, 08-financials, 09-crm, 10-ai, 14-reference-books |
| `vTenantContact` | ContactID:string, Name:string, Email:string, DefaultForType:bool, Type:string | 05-purchase, 06-sale, 07-production, 08-financials, 09-crm, 10-ai, 14-reference-books |
| `vTenantCurrency` | CurrencyID:string, Currency:string, Default:bool, Name:string | 05-purchase, 06-sale, 09-crm, 14-reference-books |
| `vTenantInventoryCategory` | CategoryID:string, Category:string | 04-inventory, 05-purchase, 06-sale, 09-crm, 12-integrations, 14-reference-books |
| `vTenantLocation` | LocationID:string, Description:string, IsDefault:bool | 03-dashboard, 04-inventory, 05-purchase, 06-sale, 07-production, 08-financials, 09-crm, 10-ai, 14-reference-books |
| `vTenantPaymentTerm` | TermID:string, Name:string, Days:int, Method:int, DueNextMonth:int | 05-purchase, 06-sale, 08-financials, 09-crm, 10-ai, 12-integrations, 14-reference-books |
| `vTenantTaxationRule` | RuleID:string, Description:string, EffectivePercentExclusive:float, EffectivePercentInclusive:float, EffectivePercent:float, Inclusive:bool | 03-dashboard, 04-inventory, 05-purchase, 06-sale, 07-production, 08-financials, 09-crm, 10-ai, 12-integrations, 13-settings, 14-reference-books |
| `vTenantUnitOfMeasure` | UnitOfMeasureID:string, Unit:string | 04-inventory, 05-purchase, 06-sale, 09-crm, 14-reference-books |
| `vTermsMethod` | ID:int, Name:string | 05-purchase, 06-sale, 09-crm, 12-integrations, 14-reference-books |
| `vTransaction` | ID:string, Debit:string, DocRef:string, Credit:string, Amount:float, EffectiveDate:date | 04-inventory, 05-purchase, 06-sale, 07-production, 08-financials, 09-crm, 12-integrations |
