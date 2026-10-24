# Reference books

The lookup lists everything else points at: locations, bins and logistics paths, supply rules and transfer plans, chart of accounts and account mapping, tax rules, payment terms, carriers, ship zones, brands, categories, units of measure, attribute sets, discounts, order routing and default field values.

| | Count |
|---|---:|
| Pages | 31 |
| Data models | 165 (plus [shared](../00-shared/README.md)) |
| Internal endpoints | 225 (109 write) |
| Public API operations | 54 |

## How to rebuild it

1. **Schema.** Create one table per data model below (165), starting from the generated [`schema.sql`](schema.sql). Ids are GUIDs; join on the `*ID` fields.
2. **Internal API.** Implement each controller's endpoints with the verbs listed, following the [internal API contract](../../docs/INTERNAL-API.md): one URL per store for GET/POST/PUT/DELETE, paged reads returning `{root, total}`, saves wrapped as `{ID, HasErrors, Original, Updated}`.
3. **Pages.** Build each route below as a server-rendered shell that loads the shell bundle and the page's own app, opening a record from `#<guid>` once at load ([page model](../../docs/ARCHITECTURE.md#what-a-page-is)).
4. **Public API.** Expose the 54 operations below under `/ExternalApi/v2` with header auth ([public API contract](../../docs/PUBLIC-API.md)).

## Pages

| Route | Menu label | Title | Bundle | Endpoints (write) |
|---|---|---|---|---:|
| `/AccountMapping` | Account mapping | Account mapping | `AccountMapping2019` | 2 (1) |
| `/AccountingDimensions` | Accounting dimensions | Accounting dimensions | `AccountingDimensions2019` | 1 (1) |
| `/BankAccounts` | Bank accounts | Bank accounts | `BankAccounts2019` | 2 (1) |
| `/ChartOfAccounts` | Chart of accounts | Chart of accounts | `ChartOfAccounts2019` | 5 (5) |
| `/DealList` | Deals | Deals | `DealList2019` | 1 (0) |
| `/DearToDearNetworking` | Cin7 Core to Cin7 Core networking | Cin7 Core to Cin7 Core Network | `DearToDear2019` | 5 (4) |
| `/DefaultFieldValues/Customer` | Default field values: customer | Default field values | `DefaultFieldValues2019` | 3 (1) |
| `/DefaultFieldValues/Product` | Default field values: product | Default field values | `DefaultFieldValues2019` | 3 (1) |
| `/DefaultFieldValues/Supplier` | Default field values: supplier | Default field values | `DefaultFieldValues2019` | 3 (1) |
| `/DiscountListNew` | Discounts | Discounts | `DiscountListNew2019` | 2 (1) |
| `/ExpenseItems` | Expense items | Expense items | `ExpenseItemList` | 4 (1) |
| `/FixedAssetType` | Fixed asset types | Fixed asset types | `FixedAssetType2019 Product2019` | 75 (48) |
| `/LeadStatus` | Lead statuses | Lead statuses | `LeadStatus2019` | 1 (1) |
| `/OpeningBalances` | Opening balances | Opening balances | `OpeningBalances2019 FixedAssetType2019` | 23 (10) |
| `/OrderRouting` | Order routing | Order routing | `OrderRouting2019` | 3 (2) |
| `/RMAReasonForReturn` | RMA reasons for return | Reason for return | `RMAReasonForReturn2019` | 1 (1) |
| `/RMAReturnOrderSettings` | Return order settings | Return order settings | `RMAReturnOrderSettings2019` | 3 (3) |
| `/RMAReturnPolicy` | RMA return policy | Return policy | `RMAReturnPolicy2019` | 9 (2) |
| `/TenantAddress` | Company addresses | Company addresses | `TenantAddress2019` | 2 (1) |
| `/TenantAttributeSet` | Attribute sets | Additional attributes | `TenantAttributeSet2019` | 1 (1) |
| `/TenantBrand` | Brands | Product brands | `TenantBrands2019` | 1 (1) |
| `/TenantCarrier` | Carriers | Carriers | `TenantCarriers2019` | 1 (1) |
| `/TenantContact` | Company contacts | Company contacts | `TenantContact2019` | 6 (2) |
| `/TenantInventoryCategory` | Product categories | Product categories | `TenantInventoryCategory2019` | 1 (1) |
| `/TenantLocation` | Locations and bins | Locations and bins | `TenantLocation2019` | 4 (4) |
| `/TenantLocationEdit` | Location (edit) | Edit location | `TenantLocationEdit` | 15 (14) |
| `/TenantPaymentTerm` | Payment terms | Payment terms | `TenantPaymentTerm2019` | 1 (1) |
| `/TenantShipZone` | Shipping zones | Shipping zones | `TenantShippingZones2019` | 8 (3) |
| `/TenantTaxationRule` | Taxation rules | Tax rules | `TenantTaxationRule2019` | 4 (2) |
| `/TenantUnitOfMeasure` | Units of measure | Units of measure | `TenantUnitOfMeasure2019` | 1 (1) |
| `/WarrantySetupList` | Warranty setup | Warranties | `WarrantiySetupList2019` | 2 (2) |

## Data models

ExtJS models the pages use; `v` prefix = view-model. Full DDL in [`schema.sql`](schema.sql).

| Model | Fields |
|---|---|
| `AccountingDimensionsWrapper` | ID:string, HasErrors:boolean |
| `AttachedFile` | EmailID:string, AttachmentID:string, Send:bool, FileName:string, ContentType:string, BlobGUID:string |
| `BOMProductList` | ProductID:string, CodeWithName:string |
| `BalanceWrapper` | HasErrors:bool, TenantID:string, HistoricalAccount:string, Error:string, OpeningBalancesDate:date |
| `BinGroup` | ID:string, Name:string, LocationID:string |
| `Brand` | ID:string, Name:string |
| `Category` | ID:string, Name:string |
| `ConnectionTypeModel` | ID:int, Name:string |
| `ContactMailingLists` | id:string, name:string |
| `CostTypeModel` |  |
| `CountryRegion` | ID:string, Selected:bool, CountryCode2:string, RegionName:string |
| `CustomPriceLine` | ProductID:string, ProductName:string, ProductCode:string, CustomPrice:float, ImageID:string, LatestPrice:float, LatestDate:date, ValidationState:string, ValidationText:string |
| `DearToDearContactEmail` | FakeID:string, EmailID:string, ID:string, Email:string, ConnectionType:int |
| `DiscountWrapper` | ID:int, HasErrors:bool |
| `Email` | Checked:string, EmailID:string, From:string, To:string, CC:string, Subject:string, Body:string, ValidationText:string, ValidationState:string |
| `ExceptionsList` | Line:int, SupplierName:string, SupplierNameError:string, SupplierReference:string, SupplierReferenceError:string, InvoiceDate:string, InvoiceDateError:string, Amount:string, AmountError:string, CurrencyConversionRate:string, CurrencyConversionRateError:string, ValidationText:string, ValidationState:string |
| `LocationWrapper` | ID:int, HasErrors:bool, RecommendBatchSN:number |
| `MarkupLine` | TierNumber:int, Price:float, CalculatedPrice:float, Calculated:boolean, MarkupType:string, UsePriceType:string, MarkupValue:float, ValidationState:string, ValidationText:string |
| `MarkupType` | Value:string, Name:string |
| `MeasurementUnit` | UoMAbbr:string, UoMName:string, IsFirst:bool, MeasurementSystem:string |
| `MovementTypeModel` | name:string, value:string |
| `OpeningBalanceLine` | Code:string, TaskID:string, Name:string, Currency:string, CurrencyName:string, Debit:float, SystemAccount:string, AccountType:string, AccountClass:string, Credit:float, InventoryAsset:bool, ValidationText:string, ValidationState:string |
| `PerformedImportActions` | ActionType:string, Code:string, NewCode:string, Name:string, Type:string, Class:string, Status:string, ImportResult:string, IsSuccessed:bool |
| `PickZones` | Value:string, LocationID:string |
| `PriceTiers` | Code:int, Name:string |
| `ProductMarkupPrices` | ProductID:string, PriceTier1:float, PriceTier2:float, PriceTier3:float, PriceTier4:float, PriceTier5:float, PriceTier6:float, PriceTier7:float, PriceTier8:float, PriceTier9:float, PriceTier10:float, AvgPriceUsed1:string, AvgPriceUsed2:string, AvgPriceUsed3:string, AvgPriceUsed4:string, AvgPriceUsed5:string, AvgPriceUsed6:string, AvgPriceUsed7:string, AvgPriceUsed8:string, AvgPriceUsed9:string, AvgPriceUsed10:string |
| `ProductStatus` | Value:string, Name:string |
| `ProductWrapper` | ID:int, HasErrors:bool |
| `PurchaseReferenceData` | ID:int, OrderViewPermission:string, OrderAuthorisationPermission:string, BillCreditNoteViewPermission:string, BillCreditNoteAuthorisationPermission:string, StockReceivedViewPermission:string, StockReceivedAuthorisationPermission:string, EditAuthorizedDocumentsPermission:string, UndoPermission:string, VoidPermission:string, OrderApproveRejectReviewPermission:string, OtherUsersAttachmentsPermission:string, ProductFamilyCount:int, DefaultAccount:string, TaxCalculationMethod:string, DefaultPurchaseMethod:string, HeadersVisible:string, FixedAssetPermission:string, CurrentAttributeSetId:string, Att… |
| `RMAReturnPolicy` | ID:string, Name:string, CreatedDate:date, UpdatedDate:date, IsActive:bool, IsRefundPossible:bool, RefundPaymentOptions:string, RefundDays:int, IsReplacementPossible:bool, IsPossibleCrossSale:bool, ReplacementDays:int, RestockingFeesPercent:int, RestockingFeesFixedAmount:int, InspectionsCost:string, RepairCost:string, IsReturnPossible:bool, ReturnDays:int, ShippingCost:string, PolicyText:string |
| `RMAReturnPolicyGrid` | ID:string, Name:string, CreatedDate:date, UpdatedDate:date, IsActive:bool |
| `ReasonForReturn` | ID:string, Name:string |
| `Reassign_TenantContact` | ContactID:string, Name:string |
| `Recipients` | Name:string, Email:string, IncludeInEmail:string, SupplierCustomerID:string, ConnectionType:int |
| `SaleReferenceDataWrapper` | ID:int, DefaultTaxRule:string |
| `SupplierCustomerModel` | ID:string, Name:string, Type:int |
| `SupplyInterval` | ID:string, DeliveryMethod:string, IntervalStartDate:date, IsMonday:bool, IsTuesday:bool, IsWednesday:bool, IsThursday:bool, IsFriday:bool, IsSaturday:bool, IsSunday:bool, LocationID:string, LeadSafetyOptionID:string |
| `TaxInclusive` | Value:bool, Name:string |
| `TaxStatus` | Value:string, Name:string |
| `TenantLocation` | ID, Name |
| `TenantLocationPutAwayRule` | ID:string, Name:string, IsActive:bool, LocationID:string, IsAppliedForAllProducts:bool, IsAllowBatchSplit:bool, MinCapacity:float, MaxCapacity:float, MinLength:float, MaxLength:float, MinWidth:float, MaxWidth:float, MinHeight:float, MaxHeight:float, MinWeight:float, MaxWeight:float |
| `TenantLocationSupplyRule` | ID:string, Name:string, IsActive:bool, IsAppliedForAllProducts:bool, LocationID:string |
| `WarrantySetupWrapper` | ID:int, HasErrors:bool |
| `Year` | year:float |
| `accountModel` | Code:string, DisplayName:string |
| `pProductAdditionalDescriptions` | SIMProductID:string, AliasName:string, ShopName:string, ShopType:string, ProductID:string, SKU:string, ECSConfigID:string, ECSProductID:string, ECSVariantID:string, ECSDescription:string |
| `pProduct_AdditionalUnitsOfMeasure_SearchProduct` | ProductID:string, Name:string, Code:string, Unit:string, PriceTear1:float, PriceTear2:float, PriceTear3:float, PriceTear4:float, PriceTear5:float, PriceTear6:float, PriceTear7:float, PriceTear8:float, PriceTear9:float, PriceTear10:float |
| `vAccountClassTypes` | Class:string |
| `vAccountStatusCode` | Value:string, Name:string |
| `vAccountTypesAndClasses` | Description:string, AccountType:string, AccountClass:string, IsFirst:bool |
| `vAccountingDimension` | ID:string, Name1:string, Name2:string, Name3:string, Name4:string, Name5:string, Name6:string, Name7:string, Name8:string, Name9:string, Name10:string, IsActive1:bool, IsActive2:bool, IsActive3:bool, IsActive4:bool, IsActive5:bool, IsActive6:bool, IsActive7:bool, IsActive8:bool, IsActive9:bool, IsActive10:bool, ListValues1:string, ListValues2:string, ListValues3:string, ListValues4:string, ListValues5:string, ListValues6:string, ListValues7:string, ListValues8:string, ListValues9:string, ListValues10:string, Type1:string, Type2:string, Type3:string, Type4:string, Type5:string, Type6:string, T… |
| `vAccountingDimensionAttribute` | AttributeID:string, Name:string, Type:string, ListValues:string, IsActive:boolean, ValidationText:string, ValidationState:string |
| `vAccountingDimensionsChartOfAccount` | ID:string, AccountCode:string, IsAtribute1Enabled:bool, IsAtribute2Enabled:bool, IsAtribute3Enabled:bool, IsAtribute4Enabled:bool, IsAtribute5Enabled:bool, IsAtribute6Enabled:bool, IsAtribute7Enabled:bool, IsAtribute8Enabled:bool, IsAtribute9Enabled:bool, IsAtribute10Enabled:bool, IsCustomerAtributeEnabled:bool, IsSupplierAtributeEnabled:bool, IsProductAtributeEnabled:bool, IsExpenseClaimAtributeEnabled:bool, IsCompanyContactAtributeEnabled:bool, IsProductionResourceAtributeEnabled:bool, ValidationState:string, ValidationText:string |
| `vBOMServices` | FakeID:int, ItemID:string, ComponentProductID:string, ProductID:string, Name:string, Quantity:float, Cost:float, PriceTier:float, PriceTier1:float, PriceTier2:float, PriceTier3:float, PriceTier4:float, PriceTier5:float, PriceTier6:float, PriceTier7:float, PriceTier8:float, PriceTier9:float, PriceTier10:float, ExpenseAccount:string, ValidationText:string, ValidationState:string |
| `vBankAccount` | AccountCode:string, DisplayName:string |
| `vBankAccountToShow` | AccountID:string, Bank:string, AccountName:string, AccountCode:string, AccountNumber:string, Currency:string, StatementBalance:float, BalanceInDear:float, BalanceInDearInBankAccountCurrency:float, InitialBalance:float, LastDate:date, TransactionCount:int |
| `vBillOfMaterialFinishedProducts` | ProductID:string, ProductCode:string, Name:string, Cost:float, CostingMethod:string, ImageID:string, Unit:string, PriceTier1:float, PriceTier2:float, PriceTier3:float, PriceTier4:float, PriceTier5:float, PriceTier6:float, PriceTier7:float, PriceTier8:float, PriceTier9:float, PriceTier10:float |
| `vBillOfMaterialProducts` | ProductID:string, ProductCode:string, Name:string, Cost:float, CostingMethod:string, ImageID:string, Unit:string, PriceTier1:float, PriceTier2:float, PriceTier3:float, PriceTier4:float, PriceTier5:float, PriceTier6:float, PriceTier7:float, PriceTier8:float, PriceTier9:float, PriceTier10:float |
| `vBillOfMaterialServices` | ProductID:string, Name:string, PriceTear1:float, PriceTear2:float, PriceTear3:float, PriceTear4:float, PriceTear5:float, PriceTear6:float, PriceTear7:float, PriceTear8:float, PriceTear9:float, PriceTear10:float, ExpenseAccount:string |
| `vBillOfMaterials` | FakeID:int, ItemID:string, ComponentProductID:string, ProductID:string, ProductCode:string, Name:string, Quantity:float, WastagePercent:float, WastageQuantity:float, CostPercentage:float, Cost:float, TotalCost:float, CostingMethod:string, ValidationText:string, ValidationState:string |
| `vBin` | LocationID:string, Description:string |
| `vBinData` | LocationID:string, Name:string |
| `vBinDataBinGroups` | LocationID:string, Name:string |
| `vBinGroup` | ID:string, Name:string |
| `vBinSimple` | LocationID:string, Description:string, BinGroupID:string |
| `vBomVersion` | BomID:string, Version:int, Name:string, DisplayName:string, IsDefault:boolean |
| `vBrand` | BrandID:string, Name:string |
| `vCategory` | CategoryID:string, Name:string |
| `vCondition` | ConditionID:string, Field:string, Condition:string, Expected:string, LineOrder:int |
| `vCountry` | Code:string, configid:string, Name:string, Code2:string |
| `vCountryOfOrigin` | Code:string, Name:string |
| `vCustomPrice` | ProductID:string, CustomerID:string, Price:float, IsDeleted:bool |
| `vDeal` | ID:string, Name:string, DateFrom:date, DateTo:date, IsActive:bool, AllowCoupons:bool, SingleCouponCodeUsage:bool, CouponCodes:string, CustomersGroup:string, ValidationText:string, ValidationState:string |
| `vDearToDearNetworking` | ID:string, SupplierCustomerID:string, Name:string, SupplierID:string, SupplierName:string, CustomerID:string, CustomerName:string, ConnectionType:int, IsInviteSent:bool, Status:string, DateInviteSent:date, DateConnected:date, NetworkingKey:string, LastUpdatedDate:date, ValidationState:string, ValidationText:string |
| `vDemandLocationID` | SupplyIntervalID:string, LocationID:string |
| `vDiscountLine` | FakeID:int, ID:string, DiscountID:string, MinValue:float, MaxValue:float, Type:string, Amount:float, ValidationText:string, ValidationState:string |
| `vDiscountMatrix` | FakeID:int, ID:string, DiscountID:string, CustomerID:string, ProductID:string, Customer:string, DiscountName:string, CustomerTag:string, ValidationText:string, ValidationState:string |
| `vDiscountMatrixCustomer` | CustomerID:string, Name:string |
| `vError` | Message:string |
| `vExpenseItem` | ExpenseItemID:string, Description:string, AccountCode:string |
| `vFamily` | FamilyID:string, FamilyValue:string, RMAReturnPolicyID:string |
| `vIntegration` | NetworkingKey, LegalName, FromMail |
| `vLeadStatus` | StatusID:string, Name:string, IsActive:bool, IsKanban:bool, Position:int, ValidationText:string, ValidationState:string |
| `vLocation` | LocationID:string, Description:string |
| `vLogisticsPath` | PathID:string, WarehouseLocationID:string, ShopFloorLocationID:string, RetailLocationID:string |
| `vMakeToOrderBomConfiguration` | BOMConfigurationID:string, HasValidationErrors:bool, MenuConfigurationID:string, Name:string, ProductID:string, TemplateID:string, TemplateName:string, QuantityRelationsJSON:string, QuantityConfigurationJSON:string, ValidationState:string, ValidationText:string, IsExpanded:bool |
| `vMakeToOrderBomImage` | MenuConfigurationID:string, TemplateName:string, OperationID:string, OriginalDetailedImageUrl:string, OriginalSketchUrl:string, UpdatedDetailedImageUrl:string, UpdatedSketchUrl:string |
| `vMakeToOrderBomProductFamily` | ID:string, Name:string, Unit:string |
| `vMakeToOrderBomProductMap` | BOMConfigurationID:string, BOMProductMapID:string, IsMain:bool, MappedProductCode:auto, MappedProductID:auto, MappedProductName:auto, MappedProductUnit:auto, MenuConfigurationID:string, Name:string, MenuConfigurationType:int, ProductID:string, Quantity:number, Order:number |
| `vMakeToOrderConditionOperator` | Value:string, Name:string |
| `vMakeToOrderConfigMenuItem` | Level:int, MenuConfigurationID:string, Name:string, Type:int |
| `vMakeToOrderConfigTemplate` | IsDisabled:bool, TemplateID:string, TemplateName:string |
| `vMakeToOrderJoinCondition` | Value:string, Label:string |
| `vMakeToOrderMappedProduct` | ProductCode:string, ProductID:string, Name:string, Unit:string |
| `vMakeToOrderMenuConfiguration` | Description:string, DetailedImageID:string, MenuConfigurationID:string, IsDefault:auto, IsOpened:auto, IsOptional:auto, Name:string, Order:int, ParentID:auto, PriceDelta:decimal, ProductFamilyID:auto, ProductFamilyName:auto, ProductFamilyUnitOfMeasure:string, ProductID:string, SketchImageID:string, Type:int, IsCopy:bool, ValidationState:string, ValidationText:string |
| `vMakeToOrderMenuConfigurationCondition` | MenuConfigurationConditionID:string, Condition:string, IsHidden:bool, JoinCondition:string, MenuConfigurationID:string, RelatedMenuConfigurationID:string, RelatedMenuConfigurationName:string, ValidationState:string, ValidationText:string |
| `vMakeToOrderQuantityMenuItem` | BOMConfigurationID:string, MenuConfigurationID:string, Name:string |
| `vMakeToOrderQuantityMenuItemOption` | Level:int, MenuConfigurationID:string, Name:string |
| `vMakeToOrderTreeConfigItem` | IsDisabled:bool, Level:int, MenuConfigurationID:string, Name:string |
| `vMakeToOrderVisibilityOption` | Value:string, Label:string |
| `vMilestone` | ID:string, Name:string, Number:int, RMACostTypeID:string, RMACostTypeName:string, ChargedTo:string, RMAReturnPolicyID:string, ValidationState:string, ValidationText:string |
| `vMissingExpenseAccountInBOM` | ProductID:string, ProductCode:string, Name:string |
| `vOpeningBalanceFixedAsset` | ID:string, TaskID:string, PurchaseOrderNumber:string, AccountCode:string, Amount:float |
| `vOpeningBalanceMultiCurrencyLine` | ID:string, TaskID:string, AccountCode:string, Type:string, Currency:string, Amount:float, Rate:float, CurrencyName:string, SystemAccount:string, ValidationText:string, ValidationState:string |
| `vOpeningBalancePurchases` | TaskID:string, TenantID:string, SupplierID:string, AccountCode:string, SupplierName:string, Currency:string, InvoiceTotalAmount:float, CurrencyConversionRate:float, InvoiceDate:date, SupplierReference:string, ValidationText:string, ValidationState:string, InvoiceDueDate:date |
| `vOpeningBalanceSales` | TaskID:string, TenantID:string, CustomerID:string, AccountCode:string, CustomerName:string, Currency:string, InvoiceTotalAmount:float, CurrencyConversionRate:float, InvoiceDate:date, CustomerReference:string, InvoiceNumber:string, ValidationText:string, ValidationState:string, InvoiceDueDate:date |
| `vOpeningBalanceStockOnHand` | ID:string, TaskID:string, PurchaseOrderNumber:string, AccountCode:string, Amount:float |
| `vOpeningBalancesFixedAssetDetail` | CardID:string, TaskID:string, Date:date, PurchaseDate:date, DepreciationStartDate:date, Quantity:float, UnitCost:float, BatchSN:string, Product:string, ProductID:string, Location:string, LocationID:string, DepreciationMethod:string, AveragingMethod:string, Rate:float, EffectiveLife:float, SalvageValue:float, AssetAccountCode:string, AssetAccount:string, AccumulatedDepreciationAccountCode:string, DepreciationExpenseAccountCode:string, StartAccumulatedDepreciationAmount:float, ValidationText:string, ValidationState:string |
| `vOpeningBalancesSOHDetail` | CardID:string, TaskID:string, Date:date, Quantity:float, UnitCost:float, BatchSN:string, ExpiryDate:date, AccountCode:string, Account:string, Product:string, Location:string, ValidationText:string, ValidationState:string |
| `vOrderRouting` | TenantID:string, OrderRoutingEnabled:bool, OrderRoutingKeepRouting:bool, ValidationText:string, ValidationState:string |
| `vOrderRoutingSettings` | ID:string, LocationID:string, LocationName:string, City:string, State:string, ZipPostCode:string, Country:string, TenantID:string, ValidationText:string, ValidationState:string |
| `vPickZone` | Value:string |
| `vProblematicProductCode` | ProductID:string, ProductCode:string, Name:string |
| `vProductAlternative` | MainProductID:string, AlternativeProductID:string, AlternativeProductCode:string, AlternativeProductName:string, Matching:float, UseInProduction:bool, IsInterchangeable:bool, Quantity:float, ValidationText:string, ValidationState:string |
| `vProductAlternativeAdd` | ProductID:string, ProductCode:string, Name:string |
| `vProductCombinedList` | ID:string, ProductCode:string, Name:string, DefaultUnitOfMeasure:string, Type:string, Category:string, Brand:string, LatestSupplier:string, Status:string, Selected:bool, ImageID:string, CustomField1:string, CustomField2:string, CustomField3:string, CustomField4:string, CustomField5:string, CustomField6:string, CustomField7:string, CustomField8:string, CustomField9:string, CustomField10:string, NotSellable:string, RowType:int, CountVariants:int, Barcode:string, BomType:string, AttributeSetID:string |
| `vProductImage` | ProductID:string, ImageID:string, ContentType:string, FileName:string, Uri:string, isDefault:bool, IsImage:bool, ExternalDownloadLink:string, ExternalViewLink:string, RowOrderNum:int |
| `vProductLeadSafetyOptionDisplay` | FakeID:int, ID:string, ProductID:string, LocationID:string, LocationName:string, SupplierID:string, SupplierName:string, ReorderQuantity:float, Lead:int, Safety:int, MinimumToReorder:float, ReorderQuantityLocation:float, LeadLocation:int, SafetyLocation:int, OnlyLocationRow:bool, ValidationText:string, ValidationState:string |
| `vProductLeadSafetyOptions` | FakeID:int, ID:string, ProductID:string, LocationID:string, LocationName:string, SupplierID:string, SupplierName:string, ReorderQuantity:float, Lead:int, Safety:int, MinimumToReorder:float, ValidationText:string, ValidationState:string |
| `vProductList` | ProductID:string, ProductCode:string, Name:string, DefaultUnitOfMeasure:string, Type:string, Category:string, Brand:string, LatestSupplier:string, Status:string, Selected:bool, ImageID:string, CustomField1:string, CustomField2:string, CustomField3:string, CustomField4:string, CustomField5:string, CustomField6:string, CustomField7:string, CustomField8:string, CustomField9:string, CustomField10:string, NotSellable:string |
| `vProductLocation` | FakeID:int, ID:string, LocationID:string, ProductID:string, MinimumBeforeReorder:float, ReorderQuantity:float, LocationName:string, StockLocator:string, PickZones:string, ValidationText:string, ValidationState:string |
| `vProductMarkups` | TierNumber:int, ProductID:string, MarkupType:string, UsePriceType:string, MarkupValue:float |
| `vProductMovement` | CardDetailsID:string, ProductID:string, TaskID:string, Type:string, Number:string, Status:string, Date:date, Quantity:float, Amount:float, Location:string, BatchSN:string, ExpiryDate:date, FromTo:string |
| `vProductMovementQuantity` | CardDetailsID:string, ProductID:string, TaskID:string, Type:string, Number:string, Status:string, Date:date, Quantity:float, Location:string, BatchSN:string, ExpiryDate:date, FromTo:string |
| `vProductQuantityChanges` | ConfigID:string, ProductID:string, TaskID:string, ChangeDate:date, Action:string, Reference:string, ReferenceName:string, Location:string, QtyMoved:string, Available:string, Status:string, UserName:string |
| `vProductionBom` | BomID:string, ProductID:string, OutputQuantity:float, BufferPercent:float, InstructionUrl:string, IssueMethod:int, IssueMethodComponent:int, IssueMethodParameter:int, IgnoreCumulativeLeadTime:boolean, ComponentProductionLeadTime:int, Version:int, Name:string, IsDefault:boolean, CreatedDate:date, CreatedBy:string, DeliveryTo:string, IsTracing:bool, MinQuantity:float, MaxQuantity:float, DeviationPercent:float, RunSize:float, ValidationState:string, ValidationText:string |
| `vProductionBomAttachment` | AttachmentID:string, OperationID:string, FileName:string, Date:date, ContentType:string, BlobGuid:string, IsCloned:bool, ValidationState:string, ValidationText:string, Position:int |
| `vProductionBomComponent` | BomComponentID:string, OperationID:string, ProductID:string, ProductName:string, ProductSku:string, Quantity:float, WastageQty:float, WastagePercent:float, Cost:float, CostingMethod:string, ValidationState:string, ValidationText:string, Position:int, Unit:string, SalePriceTier:int, PriceTier1:float, PriceTier2:float, PriceTier3:float, PriceTier4:float, PriceTier5:float, PriceTier6:float, PriceTier7:float, PriceTier8:float, PriceTier9:float, PriceTier10:float, IsBackflush:bool |
| `vProductionBomCopy` | BomID:string, ProductID:string, Version:int, VersionName:string, ProductID:string, ProductCode:string, Name:string, Description:string, IsMakeToOrderBom:bool |
| `vProductionBomNote` | NoteID:string, OperationID:string, Note:string, ValidationState:string, ValidationText:string, Position:int |
| `vProductionBomOperation` | OperationID:string, BomID:string, Order:int, Name:string, CycleTime:int, CycleTimeString:string, UnitsPerCycle:float, WorkCenterID:string, WorkCenterName:string, WorkCenterCoManProcurementType:string, WorkCenterCode:string, OperationType:int, TotalCost:float, OperationRelationIDsFake:auto, IsDropShip:bool, IsBackflush:bool, ValidationState:string, ValidationText:string |
| `vProductionBomOperationLink` | ID:string, OperationID:string, RelatedOperationID:string, RelationType:int, ValidationState:string, ValidationText:string |
| `vProductionBomOperationProduct` | ID:string, OperationID:string, ProductID:string, ProductName:string, ProductSku:string, Type:int, CostCalculationType:int, PriceTier:int, Ratio:float, OutputQuantity:float, AverageCost:float, CostingMethod:string, PriceTier:float, PriceTier1:float, PriceTier2:float, PriceTier3:float, PriceTier4:float, PriceTier5:float, PriceTier6:float, PriceTier7:float, PriceTier8:float, PriceTier9:float, PriceTier10:float, Position:int, Unit:string, Cost:float, TotalCost:float, Formula:string, WastageCost:int, DeliveryTo:string, ValidationState:string, ValidationText:string |
| `vProductionBomResource` | BomResourceID:string, OperationID:string, ResourceID:string, ResourceName:string, ResourceCode:string, Quantity:float, CycleTime:int, Cost:float, ValidationState:string, ValidationText:string, Position:int, CostCalculationType:int |
| `vProductionBomTemplate` | TemplateID:string, OperationID:string, Name:string, Quantity:float, ValidationState:string, ValidationText:string, Position:int |
| `vProductionCalendar` | CalendarID:string, Year:int, WeekStart:int, ValidationState:string, ValidationText:string |
| `vProductionCalendarDay` | DayID:string, CalendarID:string, DayOfWeek:int, IsWeekend:boolean, StartTime:int, EndTime:int, StartTimeStr:string, EndTimeStr:string, BreakStartTime:int, BreakEndTime:int, BreakStartTimeStr:string, BreakEndTimeStr:string, SortOrder:int, ValidationState:string, ValidationText:string |
| `vProductionCalendarSpecialDay` | DayID:string, CalendarID:string, Date:date, IsWeekend:boolean, IsHoliday:boolean, StartTime:int, EndTime:int, StartTimeStr:string, EndTimeStr:string, BreakStartTime:int, BreakEndTime:int, BreakStartTimeStr:string, BreakEndTimeStr:string, Comment:string, ValidationState:string, ValidationText:string |
| `vProductionOperationItem` | ItemID:string, OperationID:string, Type:string, Value:string, ResourceID:string, ResourceName:string, ResourceCode:string, Quantity:float, ProductID:string, ProductName:string, ProductSku:string, WastageQty:float, WastagePercent:float, AttachmentFileName:string, AttachmentDate:date, AttachmentContentType:string, AttachmentBlobGuid:string, Note:string, Cost:float, CostingMethod:string, CycleTime:int, ValidationState:string, ValidationText:string, TotalCost:float, Position:int, Unit:string, WastageCost:int, SalePriceTier:int, PriceTier1:float, PriceTier2:float, PriceTier3:float, PriceTier4:floa… |
| `vProductionResources` | ResourceID:string, Code:string, Name:string, ResourceCost:float, CycleDuration:int |
| `vProductsAdditionalUnitsOfMeasure` | FakeID:int, ID:string, ParentProductID:string, ProductID:string, Name:string, ProductCode:string, DefaultUnitOfMeasure:string, ConversionRate:float, PriceTear1:float, PriceTear2:float, PriceTear3:float, PriceTear4:float, PriceTear5:float, PriceTear6:float, PriceTear7:float, PriceTear8:float, PriceTear9:float, PriceTear10:float, NotSellable:bool, ValidationText:string, ValidationState:string |
| `vProductsStock` | Name:string, ProductID:string, ProductCode:string, BatchSN:string, ExpiryDate:date, Location:string, Bin:string, LocationID:string, OnHand:float, OnHandVolume:float, Available:float, Allocated:float, OnOrder:float, StockOnHand:float, InTransit:float, Category:string, Brand:string, Unit:string, Family:string, StockLocator:string, Status:string, Selected:bool, NextDeliveryDate:date |
| `vProductsStockAllocated` | TaskID:string, Number:string, Type:string, CustomerName:string, Date:date, Quantity:float |
| `vProductsStockInTransit` | TaskID:string, Number:string, SupplierName:string, Date:date, RequiredByDate:date, Quantity:float, Type:string, NextDeliveryDate:date |
| `vProductsStockOnOrder` | TaskID:string, Number:string, SupplierName:string, Date:date, RequiredByDate:date, Quantity:float, Type:string, NextDeliveryDate:date |
| `vPublishingProfile` | Id:string, Name:string |
| `vPurchase_Supplier` | SupplierID:string, Name:string, Currency:string, PaymentTerm:string, TaxRule:string, Comments:string, Discount:float, AttributeSet:string |
| `vRMACostType` | ID:string, Name:string |
| `vRMAExpenseAccount` | DisplayName:string, RuleID:string |
| `vServiceUsage` | ID:string, ProductID:string, TaskID:string, Type:string, Number:string, Status:string, Date:date, Price:float |
| `vSettings` | NoWarrantyExpenseAccount:string, ScrapWriteOffDefaultExpenseAccount:string, WarrantyExpenseAccount:string, DefaultReturnLocationID:string, CreateCreditNoteType:string |
| `vShipZoneApplyTo` | ID:string, ZoneID:string, Country2:string, StateID:string, PostCodeFrom:string, PostCodeTo:string, PostCodesList:string, ShippingRate:number, ValidationText:string, ValidationState:string |
| `vShipZoneCountryCode` | Code:string |
| `vSupplierProduct` | FakeID:int, SupplierProductID:string, SupplierID:string, ProductID:string, SupplierName:string, Currency:string, SupplierInventoryCode:string, URL:string, Cost:float, FixedCost:float, SupplierProductName:string, SysDate:date, DropShip:bool, IncludeInPricing:bool, ValidationText:string, ValidationState:string |
| `vSupplyRuleAction` | ID:string, SupplyTask:string, LocationID:string, TakeStockQuantity:string, FulfilDemandQuantity:string, Capacity:float, SupplierCondition:string, RuleID:string, LineOrder:int, IsOtherwiseAction:bool |
| `vSystemAccount` | Code:string, Name:string |
| `vSystemAccountInfo` | Code:string, Name:string, MultipleAllowed:string |
| `vTenantAddress` | AddressID:string, Line1:string, Line2:string, CitySuburb:string, StateProvince:string, ZipPostCode:string, Country:string, Type:string, DefaultForType:bool |
| `vTenantLocationList` | LocationID:string, Description:string |
| `vTenantShipZone` | ZoneID:string, Name:string, IsRestZone:bool, ShortDesc:string, PricesInclTax:bool, DefaultShippingCost:number, Negative:bool, TaxRuleID:string, ValidationText:string, ValidationState:string |
| `vTenantTaxationRuleComponent` | FakeID:int, RuleID:string, ID:string, Name:string, Percent:float, AccountCode:string, Compound:bool, ComponentOrder:int |
| `vWarrantySetup` | ID:string, Name:string |
| `vWorkCenter` | WorkCenterID:string, Code:string, Name:string, IsCoMan:boolean, CoManProcurementType:string, IsCoManPurchase:boolean |
| `vWorkCenters` | WorkCenterID:string, Code:string, Name:string, IsActive:bool |
| `vXEROTaxTypes` | Name:string, TaxType:string |

## Internal endpoints

Grouped by controller. Effect: 🟢 read · 🟠 read + write at the same URL · 🔴 write. `api` = JSON under `/api/`, `mvc` = controller action.

### AccountingDimensions

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/AccountingDimensions_Index_InUse` | api | GET | 🟢 read | accountCode attributeIndex |  |  |
| `/api/AccountingDimensions_Index_vAccountingDimensions` | api | PUT REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  | Updated |  |

### AccountMapping

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/AccountMapping/CountrySpecific` | mvc |  | 🟢 read | Key |  |  |
| `/api/AccountMapping_Index_vTaxationRules` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |

### BankAccountList

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/BankAccountList_Index_vBankAccounts` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |

### ChartOfAccounts

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/ChartOfAccounts/FillByDefault` | mvc | POST | 🔴 write |  |  |  |
| `/ChartOfAccounts/Import` | mvc | POST | 🔴 write |  |  |  |
| `/api/ChartOfAccounts_Index_ReferenceData` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/ChartOfAccounts_Index_vBankAccounts` | api | GET POST PUT REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | accountId limit page start |  |  |
| `/api/ChartOfAccounts_Index_vChartOfAccounts` | api | POST PUT REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | includeXeroAccountsIfPossible returnActiveOnly |  |  |

### ChatGpt

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/ChatGpt_GetSettings` | api | GET | 🟢 read |  |  |  |
| `/api/ChatGpt_ProductDescription` | api | POST | 🟢 read | requestContent |  |  |

### country

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/country` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |

### countryregion

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/countryregion` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |

### currency

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/currency` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |

### CustomerList

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/CustomerList/ImportCustomPricesJson` | mvc | POST | 🔴 write |  |  |  |
| `/api/CustomerList_ImportCustomPrices_Exceptions` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |

### DealList

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/DealList_Index_vDeal` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | search |  | root |

### DearToDear

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/DearToDear_Index_Email` | api | POST REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/DearToDear_Index_vDearToDearNetworking` | api | PUT REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/DearToDear_Index_vIntegration` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/DearToDear_Index_vIntegration/Regenerate` | api | POST | 🔴 write |  |  |  |
| `/api/DearToDear_Index_vSupplierCustomer` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |

### DefaultFieldValues

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/DefaultFieldValues` | api | GET POST | 🟠 read + write | entityType |  |  |
| `/api/DefaultFieldValues/referencesdata` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | entityType |  |  |

### DiscountListNew

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/DiscountListNew_Index_vDiscountNew` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | search |  | root |

### DiscountNew

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/DiscountNew_Index_vDiscountNew` | api | POST PUT REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | id | ID |  |

### ExpenseItemList

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/ExpenseItemList/ChartOfAccounts` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  | ChartOfAccounts |
| `/api/ExpenseItemList/ExpenseItems` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/ExpenseItemList/ReferenceData` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/ExpenseItemList/vExpenseItem` | api | POST | 🔴 write |  |  |  |

### FixedAssetType

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/FixedAssetType_Index_vChartOfAccountsExpense` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/FixedAssetType_Index_vChartOfAccountsFixedAsset` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/FixedAssetType_Index_vFixedAssetType` | api | POST PUT REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | filter id search |  | vFixedAssetTypes |

### GetRate

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/GetRate` | api | GET | 🟢 read | From |  |  |

### Images

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/Images/Integrations` | mvc |  | 🟢 read |  |  |  |

### LatestProductPriceBySupplier

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/LatestProductPriceBySupplier/Export` | mvc |  | 🟢 read |  |  |  |

### LeadSafetyValues

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/LeadSafetyValues/Export` | mvc |  | 🟢 read |  |  |  |

### LeadStatus

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/LeadStatus_Index_vLeadStatus` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |

### MakeToOrder

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/MakeToOrder/DownloadMakeToOrderImage` | mvc | GET | 🟢 read | id |  |  |

### MoneyTask

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/MoneyTask/Receive` | mvc |  | 🟢 read |  |  |  |
| `/MoneyTask/Spend` | mvc |  | 🟢 read |  |  |  |
| `/MoneyTask/Transfer` | mvc |  | 🟢 read |  |  |  |

### OpeningBalances

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/OpeningBalances/ImportOutstandingPurchasesJson` | mvc | POST | 🔴 write |  |  |  |
| `/OpeningBalances/ImportOutstandingSalesJson` | mvc | POST | 🔴 write |  |  |  |
| `/api/OpeningBalances_Customer_ReferenceData` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/OpeningBalances_DeprecatedLocations` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/OpeningBalances_FixedAssetLocations` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/OpeningBalances_FixedAssetTaskDetails` | api | POST REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | TaskID |  |  |
| `/api/OpeningBalances_FixedAssets` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/OpeningBalances_ImportOutstandingPurchases_Exceptions` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/OpeningBalances_ImportOutstandingSales_Exceptions` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/OpeningBalances_Index` | api | POST REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  | HasErrors OpeningBalancesDate |  |
| `/api/OpeningBalances_NewProductReferenceData` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/OpeningBalances_StockOnHandTaskDetails` | api | POST REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | TaskID |  |  |
| `/api/OpeningBalances_Supplier_ReferenceData` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/OpeningBalances_vCustomer` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/OpeningBalances_vOpeningBalanceFixedAsset` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/OpeningBalances_vOpeningBalanceStockOnHand` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/OpeningBalances_vSupplier` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |

### OrderRouting

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/OrderRouting/ImportOrderRouting` | mvc | GET(navigate) | 🔴 write |  |  |  |
| `/api/OrderRouting_Index_vOrderRouting` | api | PUT REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/OrderRouting_Index_vTenantLocation` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |

### Product

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/Product/CountrySpecific` | mvc |  | 🟢 read | Key |  |  |
| `/Product/DownloadBomAttachment` | mvc |  | 🟢 read | id |  |  |
| `/Product/DownloadImage` | mvc |  | 🟢 read | id |  |  |
| `/Product/ExportBOM` | mvc |  | 🟢 read |  |  |  |
| `/Product/ExportCostingMethodUpdates` | mvc |  | 🟢 read | ids |  |  |
| `/Product/ExportCustomPrices` | mvc |  | 🟢 read |  |  |  |
| `/Product/ExportDiscountMatrix` | mvc |  | 🟢 read |  |  |  |
| `/Product/ExportFixedAssets` | mvc |  | 🟢 read |  |  |  |
| `/Product/ExportImages` | mvc |  | 🟢 read |  |  |  |
| `/Product/ExportInventoryList` | mvc |  | 🟢 read | withdescriptions |  |  |
| `/Product/ExportLocations` | mvc |  | 🟢 read |  |  |  |
| `/Product/ExportMarkupPrices` | mvc |  | 🟢 read |  |  |  |
| `/Product/ExportProductionBOM` | mvc |  | 🟢 read |  |  |  |
| `/Product/ExportSKUUpdates` | mvc |  | 🟢 read |  |  |  |
| `/Product/ExportSimplePrices` | mvc |  | 🟢 read |  |  |  |
| `/Product/ExportStockOnHand` | mvc |  | 🟢 read |  |  |  |
| `/Product/ExportUoM` | mvc |  | 🟢 read |  |  |  |
| `/Product/ImportCustomPricesJson` | mvc | POST | 🔴 write |  |  |  |
| `/Product/ImportFixedAssetsJson` | mvc | POST | 🔴 write |  |  |  |
| `/Product/ImportImagesJson` | mvc | POST | 🔴 write |  |  |  |
| `/Product/ImportInventoryListJson` | mvc | POST | 🔴 write |  |  |  |
| `/Product/ImportMarkupPricesJson` | mvc | POST | 🔴 write |  |  |  |
| `/Product/ImportSKUUpdatesJson` | mvc | POST | 🔴 write |  |  |  |
| `/Product/ImportStockOnHandJson` | mvc | POST | 🔴 write |  |  |  |
| `/Product/ImportUoMJson` | mvc | POST | 🔴 write |  |  |  |
| `/Product/Print` | mvc | POST | 🟢 read (logs) | IDList TemplateID |  |  |
| `/Product/Upload` | mvc | POST | 🔴 write |  |  |  |
| `/Product/UploadMakeToOrderImage` | mvc | POST | 🔴 write |  |  |  |
| `/Product/UploadMakeToOrderImage2` | mvc | POST | 🔴 write |  |  |  |
| `/Product/UploadProductionBomAttachment` | mvc | POST | 🔴 write |  |  |  |
| `/api/Product_AdditionalUnitsOfMeasure_SearchProduct` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | Name ProductID lang |  |  |
| `/api/Product_AdditionalUnitsOfMeasure_SearchProduct/CheckProductSKU` | api | GET | 🟢 read | sku |  |  |
| `/api/Product_Channels_PerformAction` | api | POST | 🔴 write |  |  |  |
| `/api/Product_Channels_PublishingProfiles` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID |  | root |
| `/api/Product_Channels_SIMQuantity` | api | POST | 🟢 read |  |  |  |
| `/api/Product_GetAutogenerationFlag` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Product_ImportCustomPrices_Exceptions` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/Product_ImportFixedAsset_Exceptions` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/Product_ImportImages_Exceptions` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/Product_ImportInventoryList_Exceptions` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/Product_ImportMarkupPrices_Exceptions` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/Product_ImportSKUUpdates_Exceptions` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/Product_ImportStockOnHand_Exceptions` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/Product_ImportUoM_Exceptions` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/Product_Index_BOMBulkUpdate` | api | GET POST | 🟠 read + write | componentProductId | NewComponent OldComponent |  |
| `/api/Product_Index_BOMProducts` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | search |  | root |
| `/api/Product_Index_Channels` | api | GET | 🟢 read | productID |  |  |
| `/api/Product_Index_Cost` | api | POST | 🟢 read | CostType costType |  |  |
| `/api/Product_Index_CostingMethod` | api | POST | 🔴 write |  |  |  |
| `/api/Product_Index_CustomPrices` | api | DELETE REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ProductID filter nonExistingOnly productID returnCount |  | root |
| `/api/Product_Index_CustomerTags` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Product_Index_DeleteDeprecated` | api | POST | 🔴 write |  |  |  |
| `/api/Product_Index_FamilyMakeToOrderConfiguration` | api | GET | 🟢 read | ProductID |  |  |
| `/api/Product_Index_PickZones` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  | PickZones |
| `/api/Product_Index_PickZonesWithLocations` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  | PickZones |
| `/api/Product_Index_ReferenceData` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Product_Index_Tags` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Product_Index_vAdditionalDescriptions` | api | DELETE REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ID ProductID |  | root |
| `/api/Product_Index_vBillOfMaterialProducts` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | CostType ProductID |  |  |
| `/api/Product_Index_vBillOfMaterialServices` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ProductID |  |  |
| `/api/Product_Index_vCountryOfOrigin` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Product_Index_vCustomer` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Product_Index_vMakeToOrderBomConfigurationProducts` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Product_Index_vMissingExpenseAccountInBOM` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Product_Index_vProblematicProductCodes` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Product_Index_vProduct` | api | POST PUT REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | CountrySpecificKey id | HasErrors ID Original SkuAutogenerationFlag Updated |  |
| `/api/Product_Index_vProduct/Locations` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | assetsOnly withBins |  |  |
| `/api/Product_Index_vProductAlternative` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ProductID |  |  |
| `/api/Product_Index_vProductAlternative/products` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | MainProductID Type |  |  |
| `/api/Product_Index_vProductCombinedList` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | IsActive lang search |  | root |
| `/api/Product_Index_vProductFamily` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Product_Index_vProductImage` | api | POST | 🔴 write |  |  |  |
| `/api/Product_Index_vProductList` | api | GET REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | IsActive lang search |  | root |
| `/api/Product_Index_vProductMovement` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ProductID search |  | root |
| `/api/Product_Index_vProductMovementActions` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/Product_Index_vProductMovementChannels` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/Product_Index_vProductMovementQuantity` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ProductID search |  | root |
| `/api/Product_Index_vProductQuantityChanges` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ProductID action channel search |  | root |
| `/api/Product_Index_vProductionBom` | api | GET REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | bomID cloneMakeToOrderConf isMakeToOrder sourceProductID |  |  |
| `/api/Product_Index_vProductionBomCopyProducts` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/Product_Index_vProductionBomFinishedProducts` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ProductID allowService |  |  |
| `/api/Product_Index_vProductionBomProducts` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ProductID Type |  |  |
| `/api/Product_Index_vProductionBomResources` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ShopFloorId |  |  |
| `/api/Product_Index_vServiceUsage` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ProductID search |  | root |
| `/api/Product_Index_vSupplier` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | lang |  |  |
| `/api/Product_Index_vTenantBrand` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/Product_Index_vTenantInventoryCategory` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/Product_Index_vTenantLocation` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/Product_Index_vTenantUnitOfMeasure` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/Product_Index_vWarrantySetup` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Product_Index_vWorkCenter` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  | root |
| `/api/Product_Merge` | api | POST | 🔴 write |  |  |  |

### product

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/product_Index_vProductImage` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ProductID |  |  |

### ProductFamily

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/ProductFamily/DownloadImage` | mvc |  | 🟢 read | id |  |  |

### Purchase

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/Purchase/Cancel` | mvc | POST | 🔴 write | TaskID removeAllocations |  |  |
| `/api/Purchase_Index_Product` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | HideNonInventory SupplierID lang |  |  |

### QuickbooksImportExport

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/QuickbooksImportExport/Quickbooks` | mvc | GET(navigate) | 🔴 write |  |  |  |

### RMA

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/RMA_Index_Countries` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/RMA_Index_ExpenseAccounts` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/RMA_Index_Settings` | api | GET POST | 🟠 read + write |  | ID |  |
| `/api/RMA_Index_vBrand` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/RMA_Index_vCategory` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/RMA_Index_vLocation` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/RMA_Index_vProductFamilies` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/RMA_Index_vRMACostType` | api | POST REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  | root |
| `/api/RMA_Index_vRMAReasonForReturn` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | search |  | root |
| `/api/RMA_Index_vRMAReturnPolicy` | api | DELETE GET POST PUT REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | id | ID |  |
| `/api/RMA_Index_vRMAReturnPolicyList` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | search |  | root |
| `/api/RMA_Index_vRMAReturnPolicy_ValidateConflicts` | api | POST | 🟢 read |  |  |  |
| `/api/RMA_Index_vTag` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |

### Stock

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/Stock/Print` | mvc | POST | 🟢 read (logs) | IDList TemplateID |  |  |
| `/api/Stock_Index_Permissions` | api | GET | 🟢 read | Type |  |  |
| `/api/Stock_Index_vProductsStock/GetByProductId` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | lang productId search showNonZero withBatches |  | root |
| `/api/Stock_Index_vProductsStockAllocated` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | BatchSN LocationID ProductID lang withBatches |  | root |
| `/api/Stock_Index_vProductsStockInTransit` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | LocationID ProductID lang |  | root |
| `/api/Stock_Index_vProductsStockOnOrder` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | LocationID ProductID lang |  | root |

### TenantAddress

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/TenantAddress_Index_vTenantAddress` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |

### TenantAttributeSet

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/TenantAttributeSet_Index_vTenantAttributeSet` | api | DELETE REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | id |  |  |
| `/api/TenantAttributeSet_Index_vTenantAttributeSet/GetCopyFrom` | api | GET | 🟢 read | entityID entityType fromID id |  |  |

### TenantBrand

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/TenantBrand_Index_vTenantBrand` | api | DELETE REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | id |  |  |

### TenantCarrier

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/TenantCarrier_Index_vTenantCarrier` | api | DELETE REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | id |  |  |

### TenantContact

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/TenantContact_Index_ReferenceData` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/TenantContact_Index_vMailingList/Get` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | name page |  | Result |
| `/api/TenantContact_Index_vTenantContact` | api | DELETE DELETE* POST* PUT* REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | id |  |  |
| `/api/TenantContact_Index_vTenantContact/Get` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | name page |  |  |
| `/api/TenantContact_Index_vTenantContact/GetWithPaging` | api | GET* | 🟢 read |  |  |  |
| `/api/TenantContact_Index_vTenantContact/ReassignCompanyContact` | api | POST | 🔴 write | fromContact toContact |  |  |

### TenantInventoryCategory

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/TenantInventoryCategory_Index_vTenantInventoryCategory` | api | DELETE REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | id |  |  |

### TenantLocation

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/TenantLocation/CountrySpecific` | mvc |  | 🟢 read | Key |  |  |
| `/TenantLocation/Import` | mvc | GET(navigate) | 🔴 write |  |  |  |
| `/api/TenantLocation_Index_LogisticsPath` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/TenantLocation_Index_vTenantLocationLocation` | api | DELETE REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | CountrySpecificKey id |  | root |

### TenantLocationEdit

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/TenantLocationEdit_DeliveryYearCalendar` | api | POST PUT REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | configID year |  |  |
| `/api/TenantLocationEdit_DemandLocationList` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | currentLocationID limit |  |  |
| `/api/TenantLocationEdit_ProduceLocation` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | limit |  |  |
| `/api/TenantLocationEdit_ShopFloorLocation` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/TenantLocationEdit_TenantLocationList` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | limit |  |  |
| `/api/TenantLocationEdit_TransferLocation` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | includeComanLocation limit |  |  |
| `/api/TenantLocationEdit_vBinGroup` | api | DELETE POST PUT REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ID limit locationID search |  | root |
| `/api/TenantLocationEdit_vBinGroupBins` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | binGroupID locationID |  |  |
| `/api/TenantLocationEdit_vPutAwayRule` | api | DELETE POST PUT REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ID limit locationID search |  | root |
| `/api/TenantLocationEdit_vPutAwayRuleBins` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | locationID |  |  |
| `/api/TenantLocationEdit_vPutAwayRuleUOMData` | api | GET | 🟢 read |  |  |  |
| `/api/TenantLocationEdit_vSupplyRule` | api | DELETE POST PUT REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ID limit locationID search |  | root |
| `/api/TenantLocationEdit_vTenantLocation` | api | POST PUT REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | CountrySpecificKey locationID | HasErrors ID Original Updated |  |
| `/api/TenantLocationEdit_vTenantLocationBin` | api | DELETE POST PUT REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | CountrySpecificKey locationID page search |  | root |
| `/api/TenantLocationEdit_vWorkCenters` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |

### TenantPaymentTerm

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/TenantPaymentTerm_Index_vTenantPaymentTerm` | api | DELETE REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | id |  |  |

### TenantShipZone

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/TenantShipZone/ImportShippingZones` | mvc | GET(navigate) | 🔴 write | ref |  |  |
| `/api/TenantShipZone_Index_vShipZones` | api | POST REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/TenantShipZone_Index_vShipZonesAppliesTo` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | id |  |  |
| `/api/TenantShipZone_Index_vShipZonesConditions` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | id |  |  |
| `/api/TenantShipZone_Index_vShipZonesCountriesMinus` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | id |  |  |
| `/api/TenantShipZone_Index_vShipZonesEnabled` | api | DELETE GET POST | 🟠 read + write |  |  |  |
| `/api/TenantShipZone_Index_vTenantTaxationRule` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |

### TenantTaxationRule

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/TenantTaxationRule_Index_Paging_vTenantTaxationRule` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | IsActive |  | root |
| `/api/TenantTaxationRule_Index_vChartOfAccounts` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/TenantTaxationRule_Index_vTenantTaxationRule` | api | POST PUT REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/TenantTaxationRule_Index_vXEROTaxTypes` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |

### TenantUnitOfMeasure

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/TenantUnitOfMeasure_Index_vTenantUnitOfMeasure` | api | DELETE REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | id |  |  |

### WarrantySetup

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/WarrantySetup_Index_vWarrantySetup` | api | POST PUT REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  | ID |  |

### WarrantySetupList

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/WarrantySetupList_Index_vWarrantySetup` | api | DELETE REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | filter search |  | root |

## Public API (`/ExternalApi/v2`)

| Group | Method | Path | Query / params |
|---|---|---|---|
| Attribute Set | DELETE | `/ref/attributeset` | ID |
| Attribute Set | GET | `/ref/attributeset` | ID,Page,Limit,Name |
| Attribute Set | POST | `/ref/attributeset` |  |
| Attribute Set | PUT | `/ref/attributeset` |  |
| Brand | DELETE | `/ref/brand` | ID |
| Brand | GET | `/ref/brand` | Page,Limit,Name |
| Brand | POST | `/ref/brand` |  |
| Brand | PUT | `/ref/brand` |  |
| Carrier | DELETE | `/ref/carrier` | ID |
| Carrier | GET | `/ref/carrier` | Page,Limit,CarrierID,Description |
| Carrier | POST | `/ref/carrier` |  |
| Carrier | PUT | `/ref/carrier` |  |
| Chart of Accounts | DELETE | `/ref/account` | Code |
| Chart of Accounts | GET | `/ref/account` | Page,Limit,Code,Name,Type,Status |
| Chart of Accounts | POST | `/ref/account` |  |
| Chart of Accounts | PUT | `/ref/account` |  |
| Location | DELETE | `/ref/location` | ID |
| Location | GET | `/ref/location` | ID,Page,Limit,Deprecated,Name |
| Location | POST | `/ref/location` |  |
| Location | PUT | `/ref/location` |  |
| Payment Term | DELETE | `/ref/paymentterm` | ID |
| Payment Term | GET | `/ref/paymentterm` | Page,Limit,ID,Name,Method,IsActive,IsDefault |
| Payment Term | POST | `/ref/paymentterm` |  |
| Payment Term | PUT | `/ref/paymentterm` |  |
| Product Categories | DELETE | `/ref/category` | ID |
| Product Categories | GET | `/ref/category` | Page,Limit,Name |
| Product Categories | POST | `/ref/category` |  |
| Product Categories | PUT | `/ref/category` |  |
| Reference Books | DELETE | `/custom-prices` | ProductID,CustomerID |
| Reference Books | POST | `/custom-prices` |  |
| Reference Books | PUT | `/custom-prices` |  |
| Reference Books | DELETE | `/product-suppliers` | ProductID,SupplierID |
| Reference Books | GET | `/product-suppliers` | ProductID |
| Reference Books | POST | `/product-suppliers` |  |
| Reference Books | PUT | `/product-suppliers` |  |
| Reference Books | GET | `/reference/deals` | ID,Page,Limit,Search |
| Reference Books | POST | `/reference/deals` |  |
| Reference Books | PUT | `/reference/deals` |  |
| Reference Books | GET | `/reference/discount` | ID,Page,Limit,Search |
| Reference Books | POST | `/reference/discount` |  |
| Reference Books | PUT | `/reference/discount` |  |
| Reference Books | DELETE | `/reference/shipZones` | ShipZoneID* Request |
| Reference Books | GET | `/reference/shipZones` | ID,Page,Limit,Search |
| Reference Books | POST | `/reference/shipZones` |  |
| Reference Books | PUT | `/reference/shipZones` |  |
| Reference Books | GET | `/reference/shipZonesEnabled` |  |
| Reference Books | PUT | `/reference/shipZonesEnabled` |  |
| Tax | GET | `/ref/tax` | Page,Limit,ID,Name,IsActive,IsTaxForSale,IsTaxForPurchase,Account |
| Tax | POST | `/ref/tax` |  |
| Tax | PUT | `/ref/tax` |  |
| Unit of Measure | DELETE | `/ref/unit` | ID |
| Unit of Measure | GET | `/ref/unit` | Page,Limit,Name |
| Unit of Measure | POST | `/ref/unit` |  |
| Unit of Measure | PUT | `/ref/unit` |  |
