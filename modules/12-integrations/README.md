# Integrations

The integrations catalogue and each connector's settings, mappings and logs: e-commerce channels, shipping, payments, tax, accounting, CRM, the public-API application setup (`/ExternalApi`), the WMS settings page (`/WarehouseApp`), POS (`/DearPos`), B2B portal and RMA portal.

| | Count |
|---|---:|
| Pages | 43 |
| Data models | 240 (plus [shared](../00-shared/README.md)) |
| Internal endpoints | 732 (355 write) |
| Public API operations | 0 |

## How to rebuild it

1. **Schema.** Create one table per data model below (240), starting from the generated [`schema.sql`](schema.sql). Ids are GUIDs; join on the `*ID` fields.
2. **Internal API.** Implement each controller's endpoints with the verbs listed, following the [internal API contract](../../docs/INTERNAL-API.md): one URL per store for GET/POST/PUT/DELETE, paged reads returning `{root, total}`, saves wrapped as `{ID, HasErrors, Original, Updated}`.
3. **Pages.** Build each route below as a server-rendered shell that loads the shell bundle and the page's own app, opening a record from `#<guid>` once at load ([page model](../../docs/ARCHITECTURE.md#what-a-page-is)).

## Pages

| Route | Menu label | Title | Bundle | Endpoints (write) |
|---|---|---|---|---:|
| `/Airwallex` |  | Airwallex | `Airwallex2019` | 0 (0) |
| `/Amazon` |  | Amazon | `Amazon2019` | 40 (21) |
| `/AuthorizeNet` |  | AuthorizeNet | `AuthorizeNet2019` | 4 (6) |
| `/Avalara` |  | Avalara | `Avalara2019` | 12 (7) |
| `/Bigcommerce` |  | BigCommerce | `Bigcommerce2019` | 24 (12) |
| `/Capsule` |  | Capsule | `Capsule2019` | 9 (5) |
| `/DearPos` |  | POS | `Pos2019` | 57 (34) |
| `/EasyPost` |  | EasyPost | `EasyPost2019` | 1 (1) |
| `/Etsy` |  | Etsy | `Etsy2019` | 29 (12) |
| `/ExternalApi` |  | Cin7 Core API setup | `ExternalApi2019` | 7 (3) |
| `/FBA` |  | Fulfillment by Amazon | `FBA2019` | 17 (12) |
| `/Faire` |  | Faire | `Faire2019` | 26 (14) |
| `/GSuites` |  | Google Workspaces | `GSuites2019` | 3 (3) |
| `/HubSpot` |  | HubSpot | `HubSpot2019` | 24 (15) |
| `/Integrations` | Integration | Integrations | `IntegrationList2019` | 1 (0) |
| `/LeafLink` |  | LeafLink | `LeafLink2019` | 24 (12) |
| `/Lightspeed` |  | Lightspeed | `Vend2019` | 31 (17) |
| `/Lokad` |  | Lokad | `Lokad2019` | 5 (0) |
| `/LoyaltyLion` |  | LoyaltyLion | `LoyaltyLion2019` | 4 (2) |
| `/Magento2` |  | Magento 2.x | `MagentoSd2019` | 27 (12) |
| `/MagentoSIM` |  | Magento 1.x | `Magento2019` | 27 (12) |
| `/Neto` |  | Neto ~ | `` | 0 (0) |
| `/PayPal` |  | PayPal | `PayPal2019` | 7 (8) |
| `/PaymentGateway` |  | Cin7 Core Payments | `PaymentGateway2019 PaymentGatewayCOMMONREFUND2019` | 20 (20) |
| `/Pinch` |  | Pinch | `Pinch` | 4 (6) |
| `/Portal` |  | Portal | `Portal2019` | 48 (41) |
| `/Quickbooks` |  | QuickBooks | `Quickbooks2019` | 14 (17) |
| `/RmaPortal` |  | RMA Portal | `RmaPortal2019` | 12 (15) |
| `/ShipRush` |  | ShipRush | `ShipRush2019` | 2 (1) |
| `/ShipStation/ConfigurationNG` |  | ShipStation | `Shipstation2019` | 36 (18) |
| `/Shippit` |  | Shippit | `Shippit2019` | 4 (1) |
| `/Shiptheory` |  | Shiptheory | `Shiptheory2019` | 10 (4) |
| `/Shopify` |  | Shopify | `Shopify2019` | 32 (12) |
| `/Square/Main` |  | Square | `Square2019` | 25 (12) |
| `/StarShipIt` |  | StarShipIT | `StarShipIt2019` | 7 (1) |
| `/Synder` |  | Synder ~ | `` | 0 (0) |
| `/Vend` |  | Lightspeed | `Vend2019` | 31 (17) |
| `/Walmart` |  | Walmart | `Walmart2019` | 24 (10) |
| `/WarehouseApp` |  | Warehouse application configuration | `WarehouseApp2019` | 3 (4) |
| `/WooCommerce` |  | WooCommerce | `WooCommerce2019` | 24 (12) |
| `/Xero` |  | Xero | `Xero2019` | 5 (6) |
| `/Zapier` |  | Zapier ~ | `` | 0 (0) |
| `/eBayNG` |  | eBay | `eBay2019` | 36 (13) |

## Data models

ExtJS models the pages use; `v` prefix = view-model. Full DDL in [`schema.sql`](schema.sql).

| Model | Fields |
|---|---|
| `AccountsMapping` | InventoryControlAccount:string, CostOfGoodsSoldAccount:string, DefaultRevenueAccount:string, TaxLiabilityAccount:string, PurchasePrepayment:string, SalePrepayment:string, InventoryAccrualAccount:string, StockInTransitAccount:string, InventoryDiscrepancyAccount:string, GiftCardAccount:string, WipAccount:string, TransferInTransitAccount:string, CurrentYearProfitsAccount:string, UnrealisedCurrencyGainAccount:string, RealisedCurrencyGainAccount:string, PaymentClearingAccount:string |
| `AmazonCode` | ECSCarrierCode:string |
| `AmazonConf` | ID:string, ShopName:string, Region:string, Country:string, DisplayName:string |
| `AspnetRole` | RoleId:string, RoleName:string |
| `AuthorizeNetPaymentLogEntry` | Id:string, SaleTaskId:string, PaymentId:string, Amount:float, AccountCode:string, AccountName:string, Currency:string, SaleInvoiceNumber:string, StatusText:string, AuthorizeNetPaymentId:string, IsTestMode:boolean, InitTime:date, LastUpdateTime:date |
| `AvalaraCompany` | CompanyCode:string, Name:string |
| `AvalaraTaxCode` | Code:string, Name:string |
| `B2B_SearchProduct` | Id:string, Code:string, Name:string, Type:string |
| `Carrier` | Key:string, Value:string |
| `CashManagementReason` | ID:string, ReasonName:string |
| `Category2` | Category:string |
| `ChannelMapping` | ChannelName:string, ConfigID:string, FulfillmentBoxSetting:string, LogisticsProviderSetting:string |
| `ConsolidationFrequencyModel` | value:int, description:string |
| `ConsolidationStore` | type:string, description:string |
| `ConsolidationTypeModel` | value:string, text:string |
| `ContactInfo` | ContactID:string, ContactTypeName:string, ContactType:string, ContactName:string, IsActive:bool |
| `CtlgFamily` | FamilyID:string, SKU:string, Name:string, Category:string, Brand:string, SKUCount:float, Option1Name:string, Option2Name:string, Option3Name:string, Option1Values:string, Option2Values:string, Option3Values:string, ImageID:string, ShortDescription:string, Tags:string |
| `CtlgProduct` | ProductID:string, ProductCode:string, Name:string, Available:float, OnHand:float, ImageID:string, IsStockProduct:bool |
| `CurrencyAndPortalIdWrapper` | PortalId:string |
| `DEARMappingModel` | Description:string, FieldName:string |
| `ECommerceShop` | ConfigID:string, ShopName:string |
| `EcsProductDetails` | ProductID:string, SyncStockLevel:bool, UseBufferInventory:bool, BufferInventory:int, SyncBufferInventory:int, SyncQuantity:float |
| `EnumNameValue` | name:string, value:number |
| `EtsyPublishingFailed` | ProductID:string, ProfileName:string, SKU:string, Name:string, Result:string, ImageID:string, ProductType:string |
| `EtsyPublishingNotListed` | ProductID:string, SKU:string, Type:string, ProductType:string, Name:string, Category:string, Brand:string, Price:float, Quantity:float, Status:string, LProfile:string, ItemID:string, Selected:bool, ImageID:string, FamilyID:string, ValidationText:string, ValidationState:string |
| `ExceptionsList` | Line:int, SupplierName:string, SupplierNameError:string, SupplierReference:string, SupplierReferenceError:string, InvoiceDate:string, InvoiceDateError:string, Amount:string, AmountError:string, CurrencyConversionRate:string, CurrencyConversionRateError:string, ValidationText:string, ValidationState:string |
| `ExternalEntityMapping` | ID:string, ExternalCode:string, ExternalName:string, EntityCode:string, EntityType:string |
| `ExternalEntityMappingTaxRule` | ID:string, ExternalCode:string, ExternalName:string, EntityCode:string, EntityType:string, TaxRuleIsActive:bool, TaxRuleIsPurchase:bool, TaxRuleIsSale:bool, TaxRulePercent:float, TaxRuleName:string |
| `FaireCarrierCode` | ECSCarrierCode:string |
| `FulfillmentBoxOption` | Name:string, Description:string |
| `HubSpotStage` | HubSpotStageID:string, HubSpotStageName:string |
| `IDDescription` | Description:string, ID:int |
| `IdNameModel` | id:string, name:string |
| `ImportItemsError` | Line:int, BoxNumber:int, SKU:string, ProductName:string, UnitsPerBox:int, BoxWeight:float, BoxWidth:float, BoxHeight:float, BoxDepth:float, ValidationState:string, ValidationText:string |
| `IntegrationModel` | ShopType:string |
| `IntegrationTypeStore` | value:string, name:string |
| `InventoryProductsCountInfo` | Count:int |
| `ItemSpecificsModel` | Name:string, FieldType:string, IsRequired:bool, Value:string, Mapped:bool, IsMultiSelection:bool, MappedField:string |
| `JournalsSearchResultModel` | QBOID:string, Date:date, DocNumber:string, Selected:boolean |
| `ListingsSpecificsModel` | Name:string, FieldType:string, IsRequired:bool, Value:string, Mapped:bool, MappedField:string |
| `LogisticsProviderOption` | Name:string, Description:string |
| `MasterDataSource` | name:string, value:string |
| `NameDescriptionModel` | Name:string, Description:string |
| `NameValue` | Name:string, Value:string |
| `NewStatusStore` | type:string, description:string |
| `OrderStatusStore` | type:string, description:string |
| `OutletSelector` | PosOutletID:string, OutletName:string |
| `PaymentReferenceStore` | type:string, description:string |
| `PinchPaymentLogEntry` | Id:string, SaleTaskID:string, PaymentId:string, Amount:float, AccountCode:string, AccountName:string, Currency:string, SaleInvoiceNumber:string, Status:string, PaymentStatus:string, TransID:string, ClientTransID:string, IsTestMode:boolean, Created:date, LastUpdateTime:date |
| `QuickbooksAccounts` | Code:string, DisplayName:string, Class:string, Type:string, SystemAccount:string, IsFirst:bool |
| `QuickbooksPaymentTerm` | Id:string, Name:string |
| `QuickbooksTaxationRule` | TaxType:string, Name:string, EffectiveRate:float, IsPurchaseTaxRule:bool, IsSaleTaxRule:bool |
| `ReferenceDataModel` | ID:int, TimeZone:string, TenantTaxCalculationMethod:string |
| `RegisterCountModel` | RegisterCount:int |
| `ShippingPackageType` | DimensionsSupported:bool, DefaultValue:bool, PackageID:int, Description:string, ShippingPackage:int |
| `ShippingReferenceData` | DefaultDimensionName:string |
| `ShippingService` | CODEnabled:bool, DimensionsRequired:bool, WeightRequired:bool, ExpeditedService:bool, InternationalService:bool, Description:string, ShippingTimeMax:int, ShippingTimeMin:int, Description:string, ShippingCategoryDescription:string, ShippingCategory:string, ValidForSellingFlow:bool, SurchargeApplicable:bool, DisplayName:string, ShippingServiceID:int |
| `SiteIdModel` | ID:int, Name:string, Abbr:string |
| `StatusMappingModel` | ID:string, HubSpotID:string, HubSpotPipeLineID:string, HubSpotPipeLineName:string, HubSpotStageID:string, HubSpotStageName:string, DearStatus:string, SortOrder:string |
| `TimeTrackingOptionsStore` | id:number, displayName:string |
| `TopicStore` | type:string, description:string |
| `USTaxTypeAhead` | ID:string, Description:string, Name:string |
| `UserPackage` | id:string, name:string, Weight:number, Width:number, Height:number, Length:number |
| `ValueNameDescriptionModel` | Value:string, Name:string, Description:string, Type:string |
| `ValueNameModel` | Value:string, Name:string |
| `XeroAccounts` | Code:string, DisplayName:string, Class:string, Type:string, SystemAccount:string, EnablePaymentsToAccount:bool, IsFirst:bool |
| `XeroTaxationRule` | TaxType:string, Name:string, EffectiveRate:float, IsPurchaseTaxRule:bool, IsSaleTaxRule:bool |
| `eBayPublishingFailed` | ProductID:string, ProfileName:string, SKU:string, Name:string, Result:string, ImageID:string, ProductType:string |
| `eBayPublishingNotListed` | ProductID:string, SKU:string, Type:string, ProductType:string, Name:string, Category:string, Brand:string, Price:float, Quantity:float, Status:string, LProfile:string, ItemID:string, Selected:bool, ImageID:string, FamilyID:string, ValidationText:string, ValidationState:string |
| `payPalPaymentLogEntry` | Id:string, SaleTaskId:string, Amount:float, AccountCode:string, AccountName:string, Currency:string, SaleInvoiceNumber:string, StatusText:string, PayPalPaymentId:string, IsTestMode:boolean, InitTime:date, LastUpdateTime:date |
| `stateList` | Code:string, Value:string |
| `vAbandonedCart` | CartID:string, DateTime:date, CustomerContactEmail:string, CustomerID:string, CustomerContactName:string, CartTotal:float, CartTotalCurrency:string, Quantity:float |
| `vAbandonedCartProduct` | ProductID:string, CartID:string, ProductName:string, ProductCode:string, Quantity:float, PriceValue:float, PriceCurrency:string, AvailableQuantity:float, Status:string |
| `vAccount` | Code:string, DisplayName:string |
| `vAddress` | AddressID:string, Line1:string, Line2:string |
| `vAddressType` | AddressType:string |
| `vAmazonCogs` | EcsManualJournalSetID:string, SKU:string, ProductID:string, ProductName:string, AverageCost:float, SoldQty:float, LastUpdatedDate:date, LastUpdatedBy:string, TotalCost:float |
| `vAppearance` | WebPortalID:string, Name:string, ButtonsBackgroundColor:string, ButtonsColor:string, ContactsTextColor:string, ContentColor:string, ContentLinkColor:string, FooterBackgroundColor:string, FooterLinkColor:string, FooterTextColor:string, HeaderBackgroundColor:string, NavigationTextColor:string, NavigationTextHoverColor:string, PageBackgroundColor:string, PreFooterBackgroundColor:string, PreFooterTextColor:string, PreHeaderBackgroundColor:string, SloganBackgroundColor:string, Status:string |
| `vAspnetUserRoles` | UserId:string, UserName:string, Name:string |
| `vAttributeSet` | ID:int, Name:string |
| `vAvalaraCustomerData` | Id:int, CustomerID:string, CustomerName:string, AvalaraCustomerID:int, AvalaraCustomerName:string, IsLinked:boolean, Selected:boolean |
| `vAvalaraCustomerLookup` | CustomerID:string, Name:string, IsDisplay:boolean |
| `vBankAccount` | AccountCode:string, DisplayName:string |
| `vBanknoteDenomination` | BanknoteID:string, Code:string, Nominal:float |
| `vBulkListingProduct` | ProductID:string, ProductCode:string, Name:string, Status:string, Category:string, Price:float, OrderedQuantity:float, MinimumToOrder:int, MaximumToOrder:int, Quantity:float, MenuItems:string, IsBackorderEnabled:bool |
| `vCCLP` | CustomerID:string, Name:string, LoyaltyPoints:float, StoreCredits:float, SendReceiptViaEmail:bool |
| `vCarrierList` | value:string, name:string |
| `vCarrierServiceList` | FakeID:string, CarrierCode:string, ServiceCode:string, Highlighted:bool, DisplayName:string, CarrierServiceCode:string, Domestic:bool, International:bool |
| `vCin7PayTransaction` | PaymentIntent:string, Created:date, Amount:float, Currency:string |
| `vConsolidateCustomers` | value:string, name:string |
| `vConsolidationChannelTypesStore` | EntryID:string, SaleChannel:string, InvoiceSyncType:string, COGSSyncType:string |
| `vContact` | ID:string, ECSConfigID:string, ECSName:string, IsOrganization:bool, ContactType:string, Status:string, Tags:string |
| `vContactType` | ContactType:string, ContactTypeLocalized:string |
| `vCountry` | Code:string, configid:string, Name:string, Code2:string |
| `vCurrency` | Currency:string, DisplayCurrency:string |
| `vCustomIntegration` | ShipstationUseStockLocator:bool, ShipstationExportFFOrders:bool, ShipStationTimezone:string, Enabled:bool, ImportShippingCosts:bool, ApplyTaxOnShippingCost:bool, ShippingCostZeroTaxRule:string, IgnoreBillingContact:bool, CustomStoreCurrency:string |
| `vCustomerInvite` | ID:string, CustomerID:string, CustomerName:string, ContactPerson:string, Email:string, Status:string, Role:string, InviteSendDate:date, InviteAccepted:bool, Selected:bool, SaleRepAccessType:int |
| `vDearApiEndpoint` | Name:string, Path:string |
| `vDearApiEndpointMethod` | Name:string, Url:string |
| `vDearApiEndpointMethodParam` | Name:string, Type:string, Required:string, Value:string, ToolTip:string |
| `vDearApiRequests` | ID:string, Date:date, ApplicationKey:string, Url:string, Request:string, Response:string, Code:int, Comments:string, Method:string, ApplicationName:string |
| `vDearPaymentGatewayNotificationsLogs` | NotificationExecutionLogID:string, ExecutionDate:date, Recipients:string, Subject:string, CustomerBody:string, MerchantBody:string, Status:string, ErrorMessage:string |
| `vDimensionUnit` | Code:string, Name:string |
| `vDispute` | DisputeID:string, DearPaymentGatewayTransactionID:string, CustomerName:string, Email:string, Currency:string, Amount:float, FeeAmount:float, ConvertedAmount:float, ConvertedAmountToAdditionalChargeExceptFee:float, State:string, Reason:string, DisputeDate:date, DisputeDueDate:date, TransactionDate:date, DocumentName:string, BillingAddressLine1:string, BillingAddressLine2:string, Error:string |
| `vDisputeItem` | DisputeID:string, DisputeItemID:string, DisputeItemDate:date, Actor:string, Details:string, Error:string |
| `vECSCarrierMapping` | ID:string, ECSConfigID:string, CarrierID:string, ECSCarrierCode:string, Description:string |
| `vECSOrderLog` | LogID:string, ConfigID:string, Date:date, DownloadDate:date, ProcessDate:date, OrderNumber:string, SaleTaskID:string, Status:string, Type:string, SaleOrderNumber:string, RefundID:string, OrderID:string, IsNewSale:bool |
| `vECSPaymentsToExport` | TaskID:string, OrderID:string, OrderNumber:string, TaskID:string, InvoiceNumber:string, Error:string |
| `vECSPendingOrders` | OrderLineID:string, InvoiceDate:date, Name:string, Quantity:float, Total:float, Contact:string, Error:string |
| `vECSPendingOrdersNew` | OrderLineID:string, OrderNumber:string, DateCreated:date, Name:string, Quantity:float, Total:float, CustomerName:string, Error:string, ValidationText:string, ValidationState:string |
| `vECSPurchases` | LogID:string, ConfigID:string, ECSPurchaseID:string, ECSPurchaseNumber:string, ECSStatus:string, DearPurchaseID:string, CreatedDate:date, ReceivedDate:date, Location:string, DearStatus:string, DearOrderNumber:string |
| `vECSStockAdjustments` | LogID:string, ConfigID:string, ECSStockAdjustmentID:string, ECSStockAdjustmentNumber:string, ECSStatus:string, DearStockAdjustmentID:string, CreatedDate:date, CompletedDate:date, DearStatus:string, DearNumber:string |
| `vECSStockTransfers` | LogID:string, ConfigID:string, ECSStockTransferID:string, ECSStockTransferNumber:string, ECSStatus:string, DearStockTransferID:string, FromLocation:string, ToLocation:string, CreatedDate:date, ReceivedDate:date, DearStatus:string, DearNumber:string |
| `vEcsAddressTypesMapping` | ID:string, ECSConfigID:string, ECSAddressType:string, AddressType:string, SortOrder:string |
| `vEcsBulkListing` | ProductID:string, ProductCode:string, Name:string, Status:string, Category:string, ProductType:string, Price:float, Quantity:float, UseBufferInventory:bool, BufferInventory:int, SyncBufferInventory:int, SyncQuantity:float |
| `vEcsCarriersMapping` | ID:string, ECSConfigID:string, CarrierID:string, Description:string, ECSCarrierCode:string |
| `vEcsCatalogItemNew` | SIMID:string, ProductID:string, FamilyID:string, EntityType:string, LinkedSKU:string, LinkedName:string, SKU:string, Name:string, Status:string, ImageID:string, SyncStockLevel:bool, Price:float, Category:string, Option1:string, Option2:string, Option3:string, IsStockProduct:bool, IgnoreProductUpdation:bool, Quantity:float |
| `vEcsConfiguration` | ID:string, TenantID:string, ShopName:string, AccessToken:string, RefreshToken:string, PrimaryPriceTier:int, ConsolidationType:string, ConsolidationTimeText:string, ConsolidateToCustomerID:string, IsActive:bool, PickWhenOrderStatus:string, ShippingTaxed:bool, SyncStockLevel:bool, ExportShippingInformation:bool, AutoInvoicingMode:string, AutoFulfilmentMode:string, ECSspecificParameter1:bool, ECSspecificParameter9:string, ECSspecificParameter8:string, ECSspecificParameter6:bool, ECSspecificParameter10:string, CustomerName:string, ECSTokenType:string, RevenueAccount:string, MoneySettlementBankAcc… |
| `vEcsContactTagMapping` | ID:string, ECSConfigID:string, ECSTag:string, ContactType:string, SortOrder:string |
| `vEcsLocationMapping` | ID:string, ECSConfigID:string, ECSLocationName:string, ECSLocationID:string, LocationID:string, LocationName:string |
| `vEcsManualJournalAccountMapping` | ID:string, EcsConfigID:string, EcsAccountCode:string, EcsAccountType:string, Description:string, Value:string, SortOrder:int, SkipMapping:bool, TaxRuleID:string |
| `vEcsManualJournalSet` | SetID:string, EcsConfigID:string, ActualDate:date, DateStart:date, DateEnd:date, Status:string, IsExportable:bool |
| `vEcsOperationLog` | ID:string, ConfigID:string, Date:date, Description:string, Category:string, Processed:bool, Type:int, UserName:string, ConfigName:string, ConfigType:string, Disabled:bool |
| `vEcsOverviewCustomersList` | CustomerID:string, Name:string, OrderCount:int, PaidTotalAmount:decimal, ConfigID:string |
| `vEcsOverviewFulfilmentCustomersList` | CustomerID:string, CustomerName:string, OrderCount:int, ConfigID:string |
| `vEcsOverviewOrdersList` | Date:date, SaleOrderNumber:string, CustomerName:string, Status:string, FulfillmentOrderID:string, SaleTaskID:string, ConfigID:string |
| `vEcsOverviewSalesList` | SaleOrderDate:date, SaleOrderNumber:string, CustomerName:string, Status:string, PaidTotalAmount:decimal, InvoicingStatus:string, OrderStatus:string, FulFilmentStatus:string, PaymentStatus:string, TaskID:string, TT:int, ConfigID:string |
| `vEcsPaymentProcessorMapping` | ID:string, ConfigID:string, PaymentProcessorID:string, PaymentProcessorName:string, LedgerAccount:string, AccountName:string, SortOrder:string |
| `vEcsProductVariation` | SIMID:string, SKU:string, Name:string, Category:string, Option1:string, Option2:string, Option3:string, Status:string, CustomField1:string, CustomField2:string, CustomField3:string, CustomField4:string, CustomField5:string, CustomField6:string, CustomField7:string, CustomField8:string, CustomField9:string, CustomField10:string, Price:float, SIMFamilyID:string, ProductID:string, LinkedName:string, LinkedSKU:string, ImageID:string, ValidationText:string, MaxRows:int |
| `vEcsTaxMapping` | ID:string, ECSConfigID:string, ECSTaxType:string, ECSTaxID:string, Description:string, Value:string, TaxRuleName:string, SortOrder:int |
| `vEmailNotification` | EmailNotificationSettingsID:string, IsActive:bool, Code:string, EmailTemplate:string, EmailSubject:string, ConditionParameterValue:string, Error:string |
| `vEtsyLanguage` | Code:string, description:string |
| `vExportFilter` | ParameterName:string, Condition:string, Value:string, Join:string, ValidationText:string, ValidationState:string |
| `vExportFilterItem` | Value:string, Name:string |
| `vExportFilterItemGroupped` | Value:string, Name:string, Group:string, IsFirst:bool |
| `vExportSale` | TaskID:string, OrderNo:string, OrderDate:date, Status:string, TotalAmount:float, Currency:string, Customer:string |
| `vFFProduct` | ID:string, ConfigID:string, FFProductID:string, SKU:string, FFSKU:string, Name:string, Price:float, QuantityFulfillable:float, QuantityWarehouse:float, QuantityUnsellable:float, QuantityReserved:float, QuantityInbound:float, Quantity:float, ProductID:string, MappedSKU:string, MappedName:string, ImageID:string, AdditionalField1:string, AdditionalField2:string, AdditionalField3:string, AdditionalField4:string, AdditionalField5:string, AdditionalField6:string, AdditionalField7:string, AdditionalField8:string, AdditionalField9:string, AdditionalField10:string, IsLinktoAnotherLocation:bool, IsElig… |
| `vFaireTaxonomyType` | Id:string, Name:string |
| `vFulfillmentInboundShipment` | InboundShipmentID:string, ConfigID:string, Currency:string, CarrierName:string, ShippingMethod:string, TrackingNumber:string, ShipmentPacking:string, PaperType:string, PageType:string, ShipmentDate:date, FromBox:int, ToBox:int, GeneratePaperType:string, TransferOrderID:string, HasPrintedLabels:bool, TransferOrderNumber:string, OrderDate:date, ShipmentID:string, ShipmentStatus:string, LabelPrepType:string, BoxContentsSource:string, ShipmentName:string, DestinationFulfillmentCenterId:string, AreCasesRequired:bool, ConfirmedNeedByDate:date, AddressName:string, AddressLine1:string, AddressLine2:s… |
| `vFulfillmentInboundShipmentBoxContent` | ID:string, InboundShipmentID:string, BoxNumber:int, ProductID:string, SKU:string, ProductName:string, ProductPrice:float, ProductTotalPrice:float, UnitsPerBox:int, QuantityInCase:int, NumberOfBoxes:int, BoxWidth:float, BoxHeight:float, BoxDepth:float, BoxWeight:float, ASIN:string, TransferOrderID:string, TransferOrderNumber:string, ShipmentDate:date, ValidationText:string, ValidationState:string |
| `vFulfillmentInboundShipmentEstimate` | CalculationID:string, ConfigID:string, InboundShipmentID:string, Carrier:string, NumberOfBoxes:int, ShipmentWeight:float, ShipmentCosts:float, FreightReadyDate:date, FreightClass:string, DeclaredValue:float, NumberOfPallets:int, PickUpDate:date, Status:string, CalculationDate:date, ValidationText:string, ValidationState:string |
| `vFulfillmentInboundShipmentItem` | LineID:string, InboundShipmentID:string, ConfigID:string, ASIN:string, HasPrintedLabels:bool, LocationID:string, LocationName:string, ProductCode:string, ProductName:string, ProductPrice:float, ProductTotalPrice:float, ProductID:string, QuantityInCase:int, QuantityReceived:int, QuantityShipped:int, SKU:string, ShipmentDate:date, ShipmentStatus:string, TransferOrderID:string, TransferOrderNumber:string, Condition:string, ReleaseDate:date, ValidationText:string, ValidationState:string |
| `vFulfillmentInboundShipmentList` | InboundShipmentID:string, ConfigID:string, Currency:string, TransferOrderID:string, TransferOrderNumber:string, HasPrintedLabels:bool, HasBillOfLading:bool, HasPalletLabels:bool, HasMultipleShipments:bool, CarrierName:string, ShippingMethod:string, ShipmentID:string, ShipmentStatus:string, TotalUnits:int, AmountPerUnit:float, TotalAmount:float, ShipmentDate:date, SellerCentralLink:string, LocationName:string, ValidationText:string, ValidationState:string |
| `vFulfillmentInboundShipmentPallet` | ID:string, ConfigID:string, InboundShipmentID:string, NumberOfPallets:int, PalletWeight:float, PalletDepth:float, PalletWidth:float, PalletHeight:float, TransferOrderID:string, TransferOrderNumber:string, ShipmentDate:date, IsStackable:bool, ValidationText:string, ValidationState:string |
| `vFulfillmentInboundShipmentWrapper` | ID:string, HasErrors:bool |
| `vGSuiteConfig` | ConfigID:string, HasSyncContacts:bool, HasExportData:bool, GD_DefaultDirID_Printing:string, GD_DefaultDirPath_Printing:string, GD_DefaultDirID_Reporting:string, GD_DefaultDirPath_Reporting:string, NeedsToReconnect:bool, ConnectedGoogleEmail:string, RequiresFolderReselection:bool |
| `vGSuiteLog` | LogID:string, Action:string, Message:string, LogDate:date |
| `vHubSpot` | HubSpotID:string, IsActive:bool, PriceTier:string, PriceTierCurrency:string, DefaultLocation:string, AutoSync:bool, AutoSync_StartDateStr:string, AutoSync_StartTime:string, AutoSync_Frequency:string, AutoSync_ErrorAlertType:string, AutoSync_MailListID:string, ProductSyncType:string, ProductExport_DescriptionType:string, ProductExport_TermValue:int, ProductExport_TermPeriod:string, ProductImport_Type:string, ProductImport_Category:string, ProductImport_MappingByUniqueName:bool, ProductImport_AutoCreate:bool, CustomerSyncType:string, CustomerExport_AddressType:string, CustomerExport_AllowCustom… |
| `vHubSpotContact` | ID:string, ContactName:string, CompanyName:string, IsOrganization:bool |
| `vHubspotFieldsMapping` | ID:string, ECSConfigID:string, DearFieldModel:string, DearFieldName:string, ECSFieldName:string |
| `vImportSale` | DealID:string, DealCurrency:string, HubSpotDealId:string, HubSpotDealName:string, HubSpotDealDate:date, HubSpotTotal:float, HubSpotDealStage:string, Error:string, ValidationText:string, ValidationState:string |
| `vInboundShipmentBoxLabes` | FromBox:int, ToBox:int, TotalOfBoxes:int, PaperType:string, ValidationText:string, ValidationState:string |
| `vInboundShipmentCharges` | ShippingCarrier:string, NumberOfBoxes:int, ShipmentWeight:float, BillableWeight:float, EstimatedShipmentCost:float, FreightReadyDate:date, FreightClass:string, DeclaredValue:float, ContactPerson:string, ValidationText:string, ValidationState:string |
| `vInboundShipmentPrintLabes` | NumberOfBoxes:int, PaperType:string, PaperSize:string, ShipmentDate:date, ValidationText:string, ValidationState:string |
| `vInternalNotification` | NotificationSettingsID:string, IsActive:bool, Code:string, Error:string |
| `vInvoiceTemplate` | TemplateID:string, Name:string |
| `vListingProfile` | id:string, Name:string, ShippingProfileID:string, ShippingProfileName:string, ReadinessStateId:auto |
| `vLocation` | LocationID:string, Description:string |
| `vLog` | LogID:string, Action:string, Message:string, AdditionalInfo:string, LogDate:date, Error:string, LogType:string, SyncID:string, AffectedEntitiesCount:int, ValidationText:string, ValidationState:string |
| `vLogRecord` | ID:string, LogDate:string, FulfillmentOrderId:string, FFOrderID:string, ChangesText:string, ChangedBy:string |
| `vMagentoStores` | ID:string, Name:string |
| `vMailingList` | MailingListID:string, Name:string, Emails:string, ValidationText:string, ValidationState:string |
| `vManualJournalLine` | EcsManualJournalSetID:string, ID:string, Description:string, Amount:float, Tax:float, AccountCode:string, AccountName:string, TaxRuleID:string, TaxRuleName:string |
| `vMarginTax` | Code:boolean, Name:string |
| `vMarketplace` | ID:string, Name:string |
| `vNameCodeModel` | Code:string, Name:string |
| `vNameValue` | Name:string, Value:string |
| `vNavbarItem` | ID:string, WebPortalID:string, NavbarType:string, Item:string, ItemId:string, ItemName:string, DisplayName:string, ItemType:string, LineOrder:int |
| `vOverviewAbandonedCarts` | ID:string, DateTime:date, ContactName:string, Quantity:float, CartTotal:float |
| `vOverviewCustomers` | CustomerID:string, CustomerName:string, Sales:int, Amount:float |
| `vOverviewSales` | ID:string, Date:date, Number:string, CustomerName:string, CustomerID:string, Amount:float, Status:string, TaskType:string |
| `vPackagesList` | name:string, value:string, Domestic:bool, International:bool |
| `vPaymentAccount` | Code:string, DisplayName:string |
| `vPaymentMethod` | Value:string, Name:string |
| `vPaymentMethodSurcharge` | SurchargeID:string, PaymentMethodID:string, ConfigID:string |
| `vPayout` | PayoutID:string, PayoutPlanedDate:date, PayoutDate:date, State:string, PayoutAmount:float, MoneyTaskID:string, PurchaseTaskID:string, Note:string, Error:string |
| `vPayoutItem` | PayoutItemID:string, PayoutID:string, TransactionDate:date, DocumentName:string, CustomerName:string, Amount:float, Error:string |
| `vPortalEmailTemplate` | WebPortalID:string, Name:string, Content:string, Description:string, Subject:string |
| `vPortalPage` | WebPortalPageID:string, WebPortalID:string, Name:string, LineOrder:string, Content:string, IsActive:string, Type:string |
| `vPortalPriceList` | WebPortalID:string, Name:string, ID:string, LineOrder:int |
| `vPosOutlets` | PosOutletID:string, LocationID:string, OutletName:string, TimeZone:string, DefaultTaxRule:string, LocationName:string, DefaultTaxRuleName:string, CountRegistry:int, EcsPaymentProcessorID:string, LedgerAccount:string, ReceiptID:string, PrintNotes:bool, PrintDiscounts:bool, Active:bool, SquareIntegrationID:string, PaymentSenseURL:string, PaymentSenseAPIKey:string, SurchargeTaxRule:string, PaymentSenseAPIKey:string, TyroMerchantID:string, TriPOSAccountID:string, TriPOSAcceptorID:string, TriPOSAccountToken:string, CustomizedCustomerDisplayUI:bool, CustomerDisplayLogo:string, CustomerDisplayBackgr… |
| `vPosProductEx` | ProductID:string, Name:string, SKU:string, Category:string, OutletSKU:string, ConfigID:string, PosOutletID:string, ValidationText:string, ValidationState:string |
| `vPosQuickKey` | QuickKeyID:string, Name:string, ContentQuery:string |
| `vPriceListBrand` | ID:string, WebPortalPriceListID:string, BrandID:string, Name:string |
| `vPriceListCategory` | ID:string, WebPortalPriceListID:string, CategoryID:string, Name:string |
| `vPriceListTag` | ID:string, WebPortalPriceListID:string, Tag:string |
| `vProductAttributeRow` | ID:string, DisplayName:string, SetID:string, ColumnNumber:string, AttributeSetName:string, ColumnName:string, ColumnType:string, ColumnValues:string, AttributeName:string |
| `vProductCatalogModel` | ID:string, HubSpotCatalogID:string, ProductID:string, ProductCode:string, Name:string, Type:string, CategoryName:string, Status:string, HubSpotName:string, HubSpotObjectID:string, HubSpotPrice:string, PriceTier1:decimal, PriceTier2:decimal, PriceTier3:decimal, PriceTier4:decimal, PriceTier5:decimal, PriceTier6:decimal, PriceTier7:decimal, PriceTier8:decimal, PriceTier9:decimal, PriceTier10:decimal, ValidationState:string, ValidationText:string |
| `vProductTaxCode` | Type:string, ProductID:string, ProductCode:string, ProductName:string, AvalaraTaxCode:string, AvalaraTaxName:string |
| `vProductToExportModel` | ProductID:string, ProductCode:string, Name:string, Type:string, CategoryName:string, Status:string, PriceTier:int, PriceTier1:decimal, PriceTier2:decimal, PriceTier3:decimal, PriceTier4:decimal, PriceTier5:decimal, PriceTier6:decimal, PriceTier7:decimal, PriceTier8:decimal, PriceTier9:decimal, PriceTier10:decimal |
| `vProductVariation` | ProductID:string, FamilyID:string, ProductCode:string, ImageID:string, Name:string, Option1:string, Option2:string, Option3:string |
| `vProductionCalendar` | CalendarID:string, Year:int, WeekStart:int, ValidationState:string, ValidationText:string |
| `vProductionCalendarDay` | DayID:string, CalendarID:string, DayOfWeek:int, IsWeekend:boolean, StartTime:int, EndTime:int, StartTimeStr:string, EndTimeStr:string, BreakStartTime:int, BreakEndTime:int, BreakStartTimeStr:string, BreakEndTimeStr:string, SortOrder:int, ValidationState:string, ValidationText:string |
| `vProductionCalendarSpecialDay` | DayID:string, CalendarID:string, Date:date, IsWeekend:boolean, IsHoliday:boolean, StartTime:int, EndTime:int, StartTimeStr:string, EndTimeStr:string, BreakStartTime:int, BreakEndTime:int, BreakStartTimeStr:string, BreakEndTimeStr:string, Comment:string, ValidationState:string, ValidationText:string |
| `vReadinessState` | Id:auto, Title:string, ReadinessState:string, DisplayTitle:string |
| `vReceiptTemplate` | TemplateID:string, Name:string |
| `vRefundReasons` | Code:string, Name:string |
| `vRegistries` | ConfigID:string, RegistryID:string, RegistryCode:string, LocationID:string, LocationName:string, EcsPaymentProcessorID:string, LedgerAccount:string, ReceiptID:string, TillDiscrepancyMapping:string, CashFloatMapping:string, PettyCashMapping:string, CashInOutMapping:string, RegistryPrefix:string, RegistrySuffix:string, Active:bool, QuickKeyID:string, UseTyro:bool, TyroTerminalID:string, UseTriPOS:bool, TriPOSLaneID:string, CatalogTilesSize:string, CatalogTilesVisibility:string, ShowProductAvailability:bool, LinklyUserName:string, LinklyPassword:string, WindcaveStation:string |
| `vReportLayout` | Fakeid:string, ReportName:string, LayoutName:string, Layout:string |
| `vReportTemplate` | TemplateID:string, Name:string |
| `vSSExportLog` | ScheduledPeriod:date, OrderNumber:string, FulfillmentNumber:string, InvoiceNumber:string, OrderID:string, FulfillmenID:string, InvoiceID:string, CustomerName:string, ShipByDate:date, Status:string, Comments:string, StatusDate:date |
| `vSSStoreList` | name:string, value:string |
| `vSSTenantAddress` | AddressID:string, Line1:string, Line2:string, CitySuburb:string, StateProvince:string, ZipPostCode:string, Country:string, CountryLine:string |
| `vSaleAttribute` | Id:int, Name:string, Type:string |
| `vScheduledExport` | periodBeg:date, periodEnd:date |
| `vSendNotificationOnLabelGeneration` | Code:boolean, Name:string |
| `vShipIntegrationLocationMapping` | ID:string, ConfigID:string, WarehouseName:string, WarehouseId:string, LocationID:string, LocationName:string, IsActive:bool |
| `vShipServConf` | ID:string, ModuleType:string |
| `vShippingMetadataMapping` | FakeID:string, PropertyName:string, Value:string |
| `vShippingMethod` | ID:string, Name:string |
| `vShippingService` | ID:string, Name:string |
| `vShippingTemplate` | Id:string, Title:string |
| `vShipstationNotMatchingAddresses` | TaskID:string, InvoiceNumber:string, ShippingAddressLine1:string, ShippingAddressLine2:string, CustomerName:string, CustomerID:string, InvoiceDate:date, ShipmentRequiredByDate:date, Reason:string |
| `vShopifyCatalogBulkListing` | ProductID:string, ProductCode:string, Name:string, Status:string, Available:int, CategoryName:string, PriceTear1:decimal, PriceTear2:decimal, PriceTear3:decimal, PriceTear4:decimal, PriceTear5:decimal, PriceTear6:decimal, PriceTear7:decimal, PriceTear8:decimal, PriceTear9:decimal, PriceTear10:decimal, SellOutOfStock:bool, UseBufferInventory:bool, BufferInventory:int, SyncBufferInventory:int, SyncQuantity:float, IsLinkToKitProduct:bool |
| `vShopifyCatalogList` | ProductID:string, ProductCode:string, Name:string, Status:string, PriceTier:int, Available:int, PriceTear1:float, PriceTear2:float, PriceTear3:float, PriceTear4:float, PriceTear5:float, PriceTear6:float, PriceTear7:float, PriceTear8:float, PriceTear9:float, PriceTear10:float, SellOutOfStock:bool, UseBufferInventory:bool, BufferInventory:int, SyncBufferInventory:int, SyncQuantity:float, IsLinkToKitProduct:bool |
| `vShopifyConfiguration` | ConfigID:string, TenantID:string, ShopName:string, AccessToken:string, LastCheck:date, IsActive:bool, ConsolidationType:string, ConsolidationTimeText:string, ConsolidateToCustomerID:string, CustomerName:string, Topic:string, ShippingTaxed:bool, SyncStockLevel:bool, ListAsDraft:bool, AllowDuplicateNames:bool, UseCompanyAsCustomer:bool, AddCompanyToAddresses:bool, UploadFulfilmentWithoutTrackingNumber:bool, SellOutOfStock:bool, BringDiscountCodes:bool, AutoShippingMode:string, InvoiceStatus:string, LiabilityAccount:string, RevenueAccount:string, CustomSalesRepresentative:string, PriceTier:int, … |
| `vShopifyLocation` | ID:string, ConfigID:string, ShopifyLocationName:string, ShopifyLocationID:int, IsFulfillmentLocation:bool, IsActive:bool, LocationID:string, LocationName:string, IsSelected:bool |
| `vShopifyLog` | LogID:string, ConfigID:string, Date:date, DownloadDate:date, ProcessDate:date, OrderNumber:string, SaleTaskID:string, InventoryTaskID:string, Status:string, Type:string, FulfillmentNumber:number, SaleOrderNumber:string, StocktakeNumber:string, TT:number |
| `vShopifyOperationLog` | ID:string, ConfigID:string, Date:date, Description:string, Category:string, Processed:bool, Type:int, UserName:string, TT:int |
| `vShopifyPaymentProcessorMapping` | ID:string, ConfigID:string, PaymentProcessor:string, AccountCode:string, SortOrder:int, AccountName:string |
| `vShopifyPendingOrders` | OrderLineID:string, OrderNumber:string, InvoiceDate:date, Name:string, Quantity:float, Total:float, Contact:string, Error:string, ValidationText:string, ValidationState:string |
| `vShopifyTaxMapping` | ID:string, ConfigID:string, Country:string, Province:string, Name:string, Value:string, SortOrder:int, TaxRuleName:string |
| `vShortLocation` | LocationID:string, Description:string |
| `vSortingOption` | WebPortalID:string, ID:string, Name:string, B2BName:string, IsDefault:bool |
| `vSquareIntegration` | ID:string, ShopName:string |
| `vSurcharge` | PaymentMethod:string, Type:string, FlatAmount:float, Rate:float, MaxAmount:float |
| `vSyncEntry` | SaleTaskID:string, Type:string, DateSynchronised:date, DateCreated:date, Status:string, Error:string, SaleOrderNumber:string, InvoiceNumber:string, CreditNoteNumber:string, InvoiceDate:date, SaleOrderDate:date, CustomerID:string, CustomerName:string, ControllerName:string |
| `vTax` | RuleID:string, Description:string |
| `vTaxRules` | RuleID:string, Description:string |
| `vTenantAddress` | AddressID:string, Line1:string, Line2:string, CitySuburb:string, StateProvince:string, ZipPostCode:string, Country:string, Type:string, DefaultForType:bool |
| `vTime` | Value:string, Name:string |
| `vTimezone` | name:string, displayName:string |
| `vUSTaxMapping` | id:int, configid:string, zip:string, city:string, county:string |
| `vUseCustomerTax` | Code:boolean, Name:string |
| `vUserImage` | UserId:string, ImageID:string, ContentType:string, FileName:string, Uri:string, isDefault:bool, IsImage:bool |
| `vWebPortal` | WebPortalID:string, Name:string, Type:string, Domain:string, Description:string, IsActive:bool, HorizontalNavbarDataType:string, DefaultCustomer:string, AllowBackorder:bool, ShowAdditionalAttributes:bool, ShowOutOfStockItems:bool, ShowMinimumOrderQuantityForProducts:bool, ShowMaximumOrderQuantityForProducts:bool, FacebookURL:string, GooglePlusURL:string, TwitterURL:string, InstagramURL:string, YouTubeURL:string, LinkedInURL:string, TenantContactID:string, TenantAddressID:string, LocationID:string, ShowImagesInShoppingCart:bool, SalesRepresentative:string, GoogleAnalyticsTrackerID:string, Goog… |
| `vWebPortalPageElements` | Id:string, WebPortalId:string, Name:string, LineOrder:int, IsRemovable:bool, IsVisible:bool, SectionType:string, Location:string, HideNavigationMenu:bool |
| `vWebPortalPageElementsDetails` | Id:string, WebPortalPageElementId:string, DetailsType:string, LineOrder:int, LinkType:string, ContentType:string, LinkItem:string, LinkMessage:string, LinkUrl:string, Text:string, FileName:string, FileHtml:string, IsFamily:string |
| `vWebPortalSale` | TaskId:string, OrderDate:date, Customer:string, SaleOrderNumber:string, Status:string, PaymentStatus:string, InvoiceAmount:float, Reference:string |
| `vWeightUnit` | Code:string, Name:string |

## Internal endpoints

Grouped by controller. Effect: 🟢 read · 🟠 read + write at the same URL · 🔴 write. `api` = JSON under `/api/`, `mvc` = controller action.

### access

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/access` | api | POST REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | Action Controller DeviceID |  |  |

### Account

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/Account/LoginRMA` | mvc |  | 🔴 write |  |  |  |

### AccountMapping

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/AccountMapping_Index_vAccountMapping` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |

### Amazon

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/Amazon/ChangeMappingAndSyncStock` | mvc | POST | 🔴 write | ConfigID IgnoreProductUpdation ProductID SIMProductID SyncStockLevel |  |  |
| `/Amazon/CopyCarrierMappings` | mvc | POST | 🔴 write | destinationID sourceID |  |  |
| `/api/Amazon_Index_CheckFamily` | api | GET PUT | 🟠 read + write |  |  |  |
| `/api/Amazon_Index_CheckProduct` | api | GET PUT | 🟠 read + write | ConfigID |  |  |
| `/api/Amazon_Index_ConfirmSettlementXeroSync` | api | POST | 🔴 write |  |  |  |
| `/api/Amazon_Index_Dashboard_Summary` | api | GET | 🟢 read |  |  |  |
| `/api/Amazon_Index_EUCountries` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Amazon_Index_Family` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ConfigID CurrentFamilyID lang |  |  |
| `/api/Amazon_Index_Marketplace` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/Amazon_Index_Product` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ConfigID IsStockProduct Name lang |  |  |
| `/api/Amazon_Index_RecalculateCogs` | api | POST | 🔴 write |  |  |  |
| `/api/Amazon_Index_RecalculateSettlementInvoice` | api | POST | 🔴 write |  |  |  |
| `/api/Amazon_Index_SettlementCogs` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | EcsManualJournalSetID search |  | root |
| `/api/Amazon_Index_SettlementDetails` | api | POST | 🟢 read |  |  |  |
| `/api/Amazon_Index_SettlementLines` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | EcsManualJournalSetID search |  | root |
| `/api/Amazon_Index_vAccountMJMapping` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID Update |  |  |
| `/api/Amazon_Index_vAccounts` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Amazon_Index_vAmazonOverviewCustomersList` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ConfigID search |  | root |
| `/api/Amazon_Index_vAmazonOverviewSalesList` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ConfigID search |  | root |
| `/api/Amazon_Index_vAmazonPendingOrders` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ConfigID search |  | root |
| `/api/Amazon_Index_vAmazonSettlements` | api | DELETE REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID |  | root |
| `/api/Amazon_Index_vBankAccounts` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Amazon_Index_vCustomer` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Amazon_Index_vECSCarrierMapping` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID |  | root |
| `/api/Amazon_Index_vEcsConfiguration` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/Amazon_Index_vEcsLogs` | api | DELETE REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID search |  | root |
| `/api/Amazon_Index_vEcsPaymentProcessorMapping` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID Update |  |  |
| `/api/Amazon_Index_vEcsProductList` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ConfigID lang mode search status |  | root |
| `/api/Amazon_Index_vEcsTaxMapping` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID |  |  |
| `/api/Amazon_Index_vEcsVariationList` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ConfigID SIMFamilyID ScanFamilyID |  | root |
| `/api/Amazon_Index_vEcsVariationManual` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ConfigID FamilyID SIMFamilyID additionalSKUs search |  | root |
| `/api/Amazon_Index_vLocation` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Amazon_Index_vLocationExt` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Amazon_Index_vManualJournalAccounts` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Amazon_Index_vOperLog` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID search |  | root |
| `/api/Amazon_Index_vRevenueAccounts` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Amazon_Index_vSalesPriceTiers` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Amazon_Index_vTax` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/Amazon_Index_vTaxRules` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |

### AuthorizeNet

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/AuthorizeNet/GetTokenForManageCustomer` | mvc | GET | 🟢 read | authorizeNetProfileId doc |  |  |
| `/AuthorizeNet/Pay` | mvc |  | 🔴 write | doc |  |  |
| `/AuthorizeNet/PrepareAuthorizeNetSession` | mvc | GET | 🔴 write | amount authorizeNetProfileId doc saveCustomer |  |  |
| `/api/AuthorizeNet_Index_Dashboard_Summary` | api | GET | 🟢 read |  |  |  |
| `/api/AuthorizeNet_Index_LogEntries` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  | root |
| `/api/AuthorizeNet_Index_vAccounts` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/AuthorizeNet_PayDoc_Page` | api |  | 🟢 read | doc |  |  |

### Authorizenet

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/Authorizenet/Disconnect` | mvc | POST | 🔴 write |  |  |  |
| `/Authorizenet/SaveSettings` | mvc | POST | 🔴 write |  |  |  |

### Avalara

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/Avalara/CheckAvalaraAddresses` | mvc | POST | 🟢 read |  |  |  |
| `/api/Avalara_Index_CustomerDataList` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  | root |
| `/api/Avalara_Index_CustomerDataList/ApplyLink` | api | POST | 🔴 write |  |  |  |
| `/api/Avalara_Index_CustomerDataList/AutoLinkByCustomerName` | api | POST | 🔴 write |  |  |  |
| `/api/Avalara_Index_CustomerDataList/Customers` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Avalara_Index_CustomerDataList/LoadFromAvalara` | api | POST | 🔴 write |  |  |  |
| `/api/Avalara_Index_LicenseKey` | api | POST | 🔴 write |  |  |  |
| `/api/Avalara_Index_vCompany` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  | root |
| `/api/Avalara_Index_vMailingList` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  | root |
| `/api/Avalara_Index_vProductsTaxCodeList` | api | POST REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  | root |
| `/api/Avalara_Index_vSyncEntries` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  | root |
| `/api/Avalara_Index_vTaxCodeList` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  | root |

### B2B

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/B2B_BulkList` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | brand category configId family search tag |  | root |
| `/api/B2B_Index_AbandonedCarts` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | fromDate search toDate webPortalId |  | root |
| `/api/B2B_Index_B2BPriceListTemplates` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | WebPortalID |  |  |
| `/api/B2B_Index_ChangePortalDomain` | api | POST | 🔴 write | domainName webPortalID |  |  |
| `/api/B2B_Index_ChartOfAccounts` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/B2B_Index_EcsBulkList` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  | root |
| `/api/B2B_Index_Family` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/B2B_Index_InvoiceTemplates` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/B2B_Index_Product` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/B2B_Index_TenantPriceTierNames` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/B2B_Index_vAddress` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/B2B_Index_vAttributeSetRow` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  | Original |
| `/api/B2B_Index_vBrands` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  | Original |
| `/api/B2B_Index_vCategories` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  | Original |
| `/api/B2B_Index_vContacts` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/B2B_Index_vCustomMenu` | api | GET POST | 🟠 read + write |  | Conditions Items WebPortalID |  |
| `/api/B2B_Index_vEmailTemplates` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | WebPortalID |  |  |
| `/api/B2B_Index_vInvitations` | api | POST PUT REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | search statusFilter webPortalId |  | root |
| `/api/B2B_Index_vInvitations/AccessType/Set` | api | POST | 🔴 write |  |  |  |
| `/api/B2B_Index_vLocation` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/B2B_Index_vNavbarItems` | api | POST REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | WebPortalID itemType navbar | List WebPortalID |  |
| `/api/B2B_Index_vPageElements` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | WebPortalID |  |  |
| `/api/B2B_Index_vPageElementsDetails` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | WebPortalID |  |  |
| `/api/B2B_Index_vPages` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | WebPortalID |  |  |
| `/api/B2B_Index_vPaymentMethods` | api | POST REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | WebPortalID | List WebPortalID |  |
| `/api/B2B_Index_vPaymentMethods/Types` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/B2B_Index_vPriceList` | api | PUT REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | WebPortalID | List WebPortalID |  |
| `/api/B2B_Index_vProductFamilies` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  | Original |
| `/api/B2B_Index_vProducts` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  | Original |
| `/api/B2B_Index_vRmaReturnLocation` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/B2B_Index_vSaleRepInvitation` | api | POST | 🔴 write | accessType email name webPortalID |  |  |
| `/api/B2B_Index_vShippingMethods` | api | POST REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | WebPortalID | List WebPortalID |  |
| `/api/B2B_Index_vShippingServices` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/B2B_Index_vSortingOptionTypes` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/B2B_Index_vSortingOptions` | api | POST REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | WebPortalID | List WebPortalID |  |
| `/api/B2B_Index_vTags` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/B2B_Index_vTenantCarriers` | api | GET | 🟢 read |  |  |  |
| `/api/B2B_Index_vWebPortal` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/B2B_Overview_AbandonedCarts` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | lang webPortalId |  | root |
| `/api/B2B_Overview_Customers` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | lang webPortalId |  | root |
| `/api/B2B_Overview_SaleSummary` | api | POST | 🟢 read |  |  |  |
| `/api/B2B_Overview_Sales` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | webPortalId |  | root |
| `/api/B2B_Sales` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | filter search webPortalId |  | root |

### Bigcommerce

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/Bigcommerce/ListOrUpdateProduct` | mvc | POST | 🔴 write | ConfigID ProductID SyncStockLevel bufferInventory createAsActive useBufferInventory |  |  |
| `/Bigcommerce/RemoveProduct` | mvc | POST | 🔴 write | ConfigID ProductID |  |  |
| `/Bigcommerce/SaveEcsProductLocally` | mvc | POST | 🔴 write | bufferInventory configID productID syncStockLevel useBufferInventory |  |  |
| `/api/Bigcommerce_Index_Dashboard_Summary` | api | GET | 🟢 read |  |  |  |
| `/api/Bigcommerce_Index_EcsBulkList` | api | DELETE REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | Category ConfigID Family Tag brandID lang listStatus listedInConfigID search |  | root |
| `/api/Bigcommerce_Index_Family` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Bigcommerce_Index_Tags` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Bigcommerce_Index_vAccounts` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Bigcommerce_Index_vBigcommerceOverviewCustomersList` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ConfigID search |  | root |
| `/api/Bigcommerce_Index_vBigcommerceOverviewSalesList` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ConfigID search |  | root |
| `/api/Bigcommerce_Index_vCategory` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Bigcommerce_Index_vCustomer` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Bigcommerce_Index_vEcsConfiguration` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/Bigcommerce_Index_vEcsLogs` | api | DELETE REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID search |  | root |
| `/api/Bigcommerce_Index_vEcsPaymentProcessorMapping` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID Update |  |  |
| `/api/Bigcommerce_Index_vEcsProduct` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ConfigID ProductID |  |  |
| `/api/Bigcommerce_Index_vEcsProductList` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID lang search |  | root |
| `/api/Bigcommerce_Index_vEcsTaxMapping` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID Update |  |  |
| `/api/Bigcommerce_Index_vLocation` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Bigcommerce_Index_vOperationLogs` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID search |  | root |
| `/api/Bigcommerce_Index_vPendingOrders` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ConfigID search |  | root |
| `/api/Bigcommerce_Index_vRevenueAccounts` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Bigcommerce_Index_vSalesPriceTiers` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Bigcommerce_Index_vTaxRules` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |

### Capsule

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/Capsule_Index_ContactsDashboard_Summary` | api | GET | 🟢 read |  |  |  |
| `/api/Capsule_Index_PurchaseTaxRules` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Capsule_Index_SaleTaxRules` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Capsule_Index_vAddressType` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/Capsule_Index_vContactType` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Capsule_Index_vEcsAddressTypeMapping` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID configID update |  |  |
| `/api/Capsule_Index_vEcsConfiguration` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/Capsule_Index_vEcsContact` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID search |  | root |
| `/api/Capsule_Index_vEcsContactTagMapping` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID configID update |  |  |

### ChartOfAccounts

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/ChartOfAccounts_Index_vChartOfAccounts` | api | POST PUT REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | includeXeroAccountsIfPossible returnActiveOnly |  |  |
| `/api/ChartOfAccounts_Index_vChartOfAccountsType` | api | POST | 🟢 read |  |  |  |

### Cin7Pay

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/Cin7Pay_Index_Cin7PayRefundProcessing` | api | POST | 🔴 write |  |  |  |
| `/api/Cin7Pay_Index_vCin7PayTransactions` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  | root |

### Currency

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/Currency` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |

### currency

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/currency` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |

### CustomDomain

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/CustomDomain` | api | GET | 🟢 read | webPortalId |  |  |
| `/api/CustomDomain/status` | api | GET | 🟢 read | webPortalId |  |  |

### DearApi

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/DearApi_Index_Dashboard_Summary` | api | GET | 🟢 read |  |  |  |
| `/api/DearApi_Index_vApplicationNG` | api | GET PUT | 🟠 read + write |  |  |  |
| `/api/DearApi_Index_vDearApiRequestsNG` | api | GET REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ID appId search |  | root |
| `/api/DearApi_Index_vEndpointActionParams` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | action apiVersion endpoint |  | root |
| `/api/DearApi_Index_vEndpointActions` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | apiVersion endpoint |  | root |
| `/api/DearApi_Index_vEndpoints` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | apiVersion |  | root |

### DearPos

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/DearPos/CustomerImport` | mvc | GET(navigate) | 🔴 write | applicationID ref |  |  |
| `/DearPos/DeleteQuickKeyImage` | mvc | DELETE | 🔴 write | quickKeyID |  |  |
| `/DearPos/DownloadQuickKeyImage` | mvc |  | 🟢 read |  |  |  |
| `/DearPos/GetImage` | mvc | POST | 🟢 read | imageID |  |  |
| `/DearPos/ListOrUpdateProduct` | mvc | POST | 🔴 write | ConfigID Loyalty ProductID SyncStockLevel |  |  |
| `/DearPos/OutletLevelSKUImport` | mvc | GET(navigate) | 🔴 write | applicationID ref |  |  |
| `/DearPos/RemoveProduct` | mvc | POST | 🔴 write | ConfigID ProductID |  |  |
| `/DearPos/ToggleAccess` | mvc | POST | 🔴 write | UserId permission value |  |  |
| `/DearPos/UploadLogoImage` | mvc | POST | 🔴 write |  |  |  |
| `/api/DearPos_Index_AspnetRole` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ConfigID |  |  |
| `/api/DearPos_Index_CashManagementReasons` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | configID |  | root |
| `/api/DearPos_Index_Dashboard_Settings` | api | GET | 🟢 read |  |  |  |
| `/api/DearPos_Index_Dashboard_Summary` | api | GET | 🟢 read |  |  |  |
| `/api/DearPos_Index_EcsBulkList` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | Category ConfigID Family Tag brandID lang listStatus listedInConfigID search |  | root |
| `/api/DearPos_Index_EcsBulkUnList` | api | POST | 🔴 write |  | CountToList |  |
| `/api/DearPos_Index_Family` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/DearPos_Index_PosRoundingDenomination` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/DearPos_Index_PosRoundingRules` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/DearPos_Index_ReferenceData` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/DearPos_Index_Tags` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/DearPos_Index_vAccounts` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/DearPos_Index_vBanknoteDenominations` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  | root |
| `/api/DearPos_Index_vBrands` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/DearPos_Index_vCCLP` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ConfigID search |  | root |
| `/api/DearPos_Index_vCashFloatAccounts` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/DearPos_Index_vCategory` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/DearPos_Index_vCategory2` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/DearPos_Index_vCustomer` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/DearPos_Index_vDearPosOverviewCustomersList` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ConfigID search |  | root |
| `/api/DearPos_Index_vDearPosOverviewSalesList` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ConfigID search |  | root |
| `/api/DearPos_Index_vDearPosPendingOrders` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | configId search |  | root |
| `/api/DearPos_Index_vECSPaymentsToExport` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID search |  | root |
| `/api/DearPos_Index_vEcsConfiguration` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/DearPos_Index_vEcsLogs` | api | DELETE REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID search |  | root |
| `/api/DearPos_Index_vEcsProduct` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ConfigID ProductID |  |  |
| `/api/DearPos_Index_vEcsProductList` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID lang search |  | root |
| `/api/DearPos_Index_vEcsPurchaseLogs` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID search |  | root |
| `/api/DearPos_Index_vEcsStockAdjustmentLogs` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID search |  | root |
| `/api/DearPos_Index_vEcsStockTransferLogs` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  | root |
| `/api/DearPos_Index_vExpenseAccounts` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/DearPos_Index_vLocation` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/DearPos_Index_vPaymentMethods` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID PosOutletID |  |  |
| `/api/DearPos_Index_vPettyCashAccounts` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/DearPos_Index_vPosOutlets` | api | DELETE PUT REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID id isNew | Active CustomerDisplayBackground CustomizedCustomerDisplayUI PaymentSenseAPIKey PaymentSenseURL PrintDiscounts SquareIntegrationID TriPOSAcceptorID TriPOSAccou… |  |
| `/api/DearPos_Index_vPosOutletsSelect` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ConfigID |  |  |
| `/api/DearPos_Index_vPosProduct` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID HasOutletSKU Name PosOutletID lang search |  | root |
| `/api/DearPos_Index_vPosQuickKey` | api | DELETE PUT REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | id |  |  |
| `/api/DearPos_Index_vPosRegisterCount` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID |  |  |
| `/api/DearPos_Index_vReceiptTemplates` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/DearPos_Index_vRegistries` | api | DELETE PUT REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID OutletId id | Active CashInOutMapping CatalogTilesSize CatalogTilesVisibility LinklyPassword LinklyUserName PettyCashMapping QuickKeyID RegistryPrefix RegistrySuffix ShowPro… |  |
| `/api/DearPos_Index_vReportTemplates` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | type |  |  |
| `/api/DearPos_Index_vRevenueAccounts` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/DearPos_Index_vSalesPriceTiers` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/DearPos_Index_vSquareConfigs` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/DearPos_Index_vSupplier` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/DearPos_Index_vSurcharge` | api | POST REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | configID limit start | ConfigID IsActive Name RefundSurcharge Type Value | root |
| `/api/DearPos_Index_vTaxRules` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/DearPos_Index_vTillDiscrepancyAccounts` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/DearPos_Index_vTimezone` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/DearPos_Index_vUserManagement` | api | POST PUT REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID id | ConfigID Name PosOutletIDs RoleId UserName | root |
| `/api/DearPos_Index_vZeroTax` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |

### dearPos

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/dearPos_Index_vUserImage` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | UserID |  |  |

### EasyPost

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/EasyPost_Index_vShipServConf` | api | GET(read) PUT REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | id |  | Configurations |

### EbayNG

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/EbayNG/ChangeMappingAndSyncStock` | mvc | POST | 🔴 write | ConfigID IgnoreProductUpdation ProductID SIMProductID SyncStockLevel |  |  |
| `/api/EbayNG_Index_CheckFamily` | api | GET PUT | 🟠 read + write |  |  |  |
| `/api/EbayNG_Index_CheckProduct` | api | GET PUT | 🟠 read + write | ConfigID |  |  |
| `/api/EbayNG_Index_Dashboard_Summary` | api | GET | 🟢 read |  |  |  |
| `/api/EbayNG_Index_Family` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ConfigID CurrentFamilyID lang |  |  |
| `/api/EbayNG_Index_Migration` | api | GET PUT | 🟠 read + write | ConfigID | ConfigID |  |
| `/api/EbayNG_Index_Product` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ConfigID IsStockProduct Name lang |  |  |
| `/api/EbayNG_Index_PublishingFailed` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ConfigID lang search |  | root |
| `/api/EbayNG_Index_PublishingNotListed` | api | PUT REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID lang search |  | root |
| `/api/EbayNG_Index_Tags` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/EbayNG_Index_vAccounts` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/EbayNG_Index_vCategory` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/EbayNG_Index_vCustomer` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/EbayNG_Index_vEBayPendingOrders` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ConfigID search |  | root |
| `/api/EbayNG_Index_vEbayCategory` | api | GET | 🟢 read | ConfigID |  |  |
| `/api/EbayNG_Index_vEbayCategorySg` | api | GET | 🟢 read | ConfigID |  |  |
| `/api/EbayNG_Index_vEbayCategorySpecs` | api | GET | 🟢 read | CategoryID ConfigID catLevel |  |  |
| `/api/EbayNG_Index_vEbayPublishingProfiles` | api | PUT REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID |  | root |
| `/api/EbayNG_Index_vEcsConfiguration` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/EbayNG_Index_vEcsLogs` | api | DELETE REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID search |  | root |
| `/api/EbayNG_Index_vEcsPaymentProcessorMapping` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID Update |  |  |
| `/api/EbayNG_Index_vEcsProductList` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ConfigID lang mode search status |  | root |
| `/api/EbayNG_Index_vEcsTaxMapping` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID Update |  |  |
| `/api/EbayNG_Index_vEcsVariationList` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ConfigID SIMFamilyID ScanFamilyID |  | root |
| `/api/EbayNG_Index_vEcsVariationManual` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ConfigID FamilyID SIMFamilyID additionalSKUs search |  | root |
| `/api/EbayNG_Index_vLiabilityAccounts` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/EbayNG_Index_vLocation` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/EbayNG_Index_vSalesPriceTiers` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/EbayNG_Index_vSiteId` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/EbayNG_Index_vTaxRules` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/EbayNG_Index_veBayOverviewCustomersList` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ConfigID search |  | root |
| `/api/EbayNG_Index_veBayOverviewSalesList` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ConfigID search |  | root |

### EBayNG

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/EBayNG_Index_vOperationLogs` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID search |  | root |
| `/api/EBayNG_Index_vRevenueAccounts` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |

### ECommerce

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/ECommerce_Common_BulkListing/product/brands` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/ECommerce_Common_BulkListing/shops` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | currentConfigID |  |  |

### EcsOrderLogExport

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/EcsOrderLogExport` | api | GET | 🟢 read |  |  |  |

### Etsy

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/Etsy/ChangeMappingAndSyncStock` | mvc | POST | 🔴 write | ConfigID IgnoreProductUpdation ProductID SIMProductID SyncStockLevel |  |  |
| `/api/Etsy_Index_CheckFamily` | api | GET PUT | 🟠 read + write |  |  |  |
| `/api/Etsy_Index_CheckProduct` | api | GET PUT | 🟠 read + write | ConfigID |  |  |
| `/api/Etsy_Index_Dashboard_Summary` | api | GET | 🟢 read |  |  |  |
| `/api/Etsy_Index_Family` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ConfigID CurrentFamilyID lang |  |  |
| `/api/Etsy_Index_Product` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ConfigID IsStockProduct Name lang |  |  |
| `/api/Etsy_Index_PublishingFailed` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ConfigID lang search |  | root |
| `/api/Etsy_Index_PublishingNotListed` | api | PUT REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID lang search |  | root |
| `/api/Etsy_Index_PublishingProfiles` | api | PUT REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID | IsSupply Name NonTaxable ReadinessStateId ShippingProfileID ShippingProfileName TaxonomyCategoryName TaxonomyID When Who | root |
| `/api/Etsy_Index_vAccounts` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Etsy_Index_vCustomer` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Etsy_Index_vEcsConfiguration` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/Etsy_Index_vEcsLogs` | api | DELETE REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID search |  | root |
| `/api/Etsy_Index_vEcsPaymentProcessorMapping` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID Update |  |  |
| `/api/Etsy_Index_vEcsProductList` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ConfigID lang mode search status |  | root |
| `/api/Etsy_Index_vEcsTaxMapping` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID |  |  |
| `/api/Etsy_Index_vEcsVariationList` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ConfigID SIMFamilyID ScanFamilyID |  | root |
| `/api/Etsy_Index_vEcsVariationManual` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ConfigID FamilyID SIMFamilyID additionalSKUs search |  | root |
| `/api/Etsy_Index_vEtsyOverviewCustomersList` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ConfigID search |  | root |
| `/api/Etsy_Index_vEtsyOverviewSalesList` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ConfigID search |  | root |
| `/api/Etsy_Index_vEtsyPendingOrders` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ConfigID search |  | root |
| `/api/Etsy_Index_vLocation` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Etsy_Index_vOperationLogs` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID search |  | root |
| `/api/Etsy_Index_vReferenceDataForPublishing` | api | GET | 🟢 read | ConfigID |  |  |
| `/api/Etsy_Index_vRevenueAccounts` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Etsy_Index_vSalesPriceTiers` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Etsy_Index_vTaxRules` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |

### ExternalEntityMapping

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/ExternalEntityMapping_Index_vExternalEntityMapping` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | returnActiveOnly showDetails type |  |  |

### Faire

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/Faire/CopyCarrierMappings` | mvc | POST | 🔴 write | destinationID sourceID |  |  |
| `/Faire/ListOrUpdateProduct` | mvc | POST | 🔴 write | ConfigID ProductID SyncStockLevel TaxonomyTypeId bufferInventory useBufferInventory |  |  |
| `/Faire/RemoveProduct` | mvc | POST | 🔴 write | ConfigID ProductID |  |  |
| `/Faire/SaveEcsProductLocally` | mvc | POST | 🔴 write | bufferInventory configID productID syncStockLevel useBufferInventory |  |  |
| `/api/Faire_Index_Dashboard_Summary` | api | GET | 🟢 read |  |  |  |
| `/api/Faire_Index_EcsBulkList` | api | DELETE REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | Category ConfigID Family Tag brandID lang listStatus listedInConfigID search |  | root |
| `/api/Faire_Index_Family` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Faire_Index_Tags` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Faire_Index_TaxonomyTypes` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | configID |  |  |
| `/api/Faire_Index_vAccounts` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Faire_Index_vCategory` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Faire_Index_vCustomer` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Faire_Index_vEcsCarrierMapping` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID |  | root |
| `/api/Faire_Index_vEcsConfiguration` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/Faire_Index_vEcsLogs` | api | DELETE REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID search |  | root |
| `/api/Faire_Index_vEcsPaymentProcessorMapping` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID |  |  |
| `/api/Faire_Index_vEcsProduct` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ConfigID ProductID |  |  |
| `/api/Faire_Index_vEcsProductList` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID lang search |  | root |
| `/api/Faire_Index_vEcsTaxMapping` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID |  |  |
| `/api/Faire_Index_vFaireOverviewCustomersList` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ConfigID search |  | root |
| `/api/Faire_Index_vFaireOverviewSalesList` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ConfigID search |  | root |
| `/api/Faire_Index_vFairePendingOrders` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ConfigID search |  | root |
| `/api/Faire_Index_vLocation` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Faire_Index_vOperationLogs` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID search |  | root |
| `/api/Faire_Index_vRevenueAccounts` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Faire_Index_vSalesPriceTiers` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Faire_Index_vTaxRules` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |

### FBA

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/FBA/ChangeMapping` | mvc | POST | 🔴 write | ConfigID ProductID SIMProductID |  |  |
| `/FBA/DownloadLabels` | mvc | POST | 🟢 read | ConfigID InboundShipmentID |  |  |
| `/FBA/GenerateBoxLabels` | mvc | POST | 🔴 write | ConfigID InboundShipmentID IsPallet fromBox isPartnered numberOfBoxes pageSize pageType shipmentDate toBox |  |  |
| `/FBA/ImportBoxContent` | mvc | POST | 🔴 write | InboundShipmentId |  |  |
| `/FBA/QueueStockSync` | mvc | POST | 🔴 write | ConfigID |  |  |
| `/api/FBA_Index_Carriers` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | region |  |  |
| `/api/FBA_Index_CheckProduct` | api | GET PUT | 🟠 read + write | ConfigID |  |  |
| `/api/FBA_Index_Dashboard_Summary` | api | GET | 🟢 read |  |  |  |
| `/api/FBA_Index_FulfillmentBoxOptions` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/FBA_Index_LogisticsProviderOptions` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/FBA_Index_McfChannelMapping` | api | GET REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID ConfigIds |  |  |
| `/api/FBA_Index_vAmazonConfiguration` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/FBA_Index_vAmazonOverviewCustomersList` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ConfigID search |  | root |
| `/api/FBA_Index_vAmazonOverviewOrdersList` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ConfigID search |  | root |
| `/api/FBA_Index_vChooseLocation` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/FBA_Index_vEcsConfiguration` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/FBA_Index_vFFProductList` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  | root |
| `/api/FBA_Index_vFulfillmentInboundShipment` | api | DELETE PUT REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID InboundShipmentID action dateFrom dateTo search status | HasErrors ID Original Updated | root |
| `/api/FBA_Index_vLog` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ConfigID search |  | root |
| `/api/FBA_Index_vOperLog` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID search |  | root |
| `/api/FBA_Index_vProductList` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ConfigID lang search |  |  |
| `/api/FBA_Index_vSalesPriceTiers` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |

### GSuites

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/GSuites_Index_Config` | api | GET REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  | root |
| `/api/GSuites_Index_Contacts` | api | GET REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  | root |
| `/api/GSuites_Index_Logs` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  | root |

### HubSpot

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/HubSpot/Reconnect` | mvc | GET(navigate) | 🔴 write |  |  |  |
| `/api/HubSpot_Index/CatalogViewList` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | Category HubSpotID Type listStatus search |  | root |
| `/api/HubSpot_Index/CreateProperty` | api | POST | 🔴 write | DisplayName Entity |  |  |
| `/api/HubSpot_Index/HsObjectProperties` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/HubSpot_Index/HubSpotReferenceData` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/HubSpot_Index/Pipelines` | api | GET | 🟢 read | HubSpotID |  |  |
| `/api/HubSpot_Index/vCustomers` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID ListingStatus Status search |  | root |
| `/api/HubSpot_Index/vHubSpot` | api | GET REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/HubSpot_Index/vHubSpotContacts` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID search |  | root |
| `/api/HubSpot_Index/vHubSpotFieldsMapping` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | hubSpotID |  |  |
| `/api/HubSpot_Index/vHubSpotPipelineStageMapping` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | hubSpotID hubSpotPipelineID |  |  |
| `/api/HubSpot_Index/vImportSales` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID search |  | root |
| `/api/HubSpot_Index_Dashboard_Summary` | api | GET | 🟢 read |  |  |  |
| `/api/HubSpot_Index_DearProduct` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/HubSpot_Index_Disconnect` | api | DELETE | 🔴 write | hubSpotID |  |  |
| `/api/HubSpot_Index_SaleTaxRules` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/HubSpot_Index_vCatalog` | api | GET POST | 🟠 read + write | CatalogID Currency HubSpotID Operation PriceTier ProductID SKU |  |  |
| `/api/HubSpot_Index_vCurrency` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/HubSpot_Index_vExportSales` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID dateFrom search |  | root |
| `/api/HubSpot_Index_vHubSpotOverviewCustomersList` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ConfigID search |  | root |
| `/api/HubSpot_Index_vHubSpotOverviewSalesList` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ConfigID search |  | root |
| `/api/HubSpot_Index_vLog` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID search |  | root |
| `/api/HubSpot_Index_vMailingList` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  | root |
| `/api/HubSpot_Index_vProductToExport` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | Category HubSpotID Type listStatus search |  | root |
| `/api/HubSpot_Index_vSalesPriceTiers` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |

### LeafLink

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/LeafLink/ListOrUpdateProduct` | mvc | POST | 🔴 write | ConfigID ProductID SyncStockLevel bufferInventory useBufferInventory |  |  |
| `/LeafLink/RemoveProduct` | mvc | POST | 🔴 write | ConfigID ProductID |  |  |
| `/LeafLink/SaveEcsProductLocally` | mvc | POST | 🔴 write | bufferInventory configID productID syncStockLevel useBufferInventory |  |  |
| `/api/LeafLink_Index_Dashboard_Summary` | api | GET | 🟢 read |  |  |  |
| `/api/LeafLink_Index_EcsBulkList` | api | DELETE REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | Category ConfigID Family Tag brandID lang listStatus listedInConfigID search |  | root |
| `/api/LeafLink_Index_Family` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/LeafLink_Index_Tags` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/LeafLink_Index_vAccounts` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/LeafLink_Index_vCategory` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/LeafLink_Index_vCustomer` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/LeafLink_Index_vEcsConfiguration` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/LeafLink_Index_vEcsLogs` | api | DELETE REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID search |  | root |
| `/api/LeafLink_Index_vEcsPaymentProcessorMapping` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID |  |  |
| `/api/LeafLink_Index_vEcsProduct` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ConfigID ProductID |  |  |
| `/api/LeafLink_Index_vEcsProductList` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID lang search |  | root |
| `/api/LeafLink_Index_vEcsTaxMapping` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID |  |  |
| `/api/LeafLink_Index_vLeafLinkOverviewCustomersList` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ConfigID search |  | root |
| `/api/LeafLink_Index_vLeafLinkOverviewSalesList` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ConfigID search |  | root |
| `/api/LeafLink_Index_vLeafLinkPendingOrders` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ConfigID search |  | root |
| `/api/LeafLink_Index_vLocation` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/LeafLink_Index_vOperationLogs` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID search |  | root |
| `/api/LeafLink_Index_vRevenueAccounts` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/LeafLink_Index_vSalesPriceTiers` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/LeafLink_Index_vTaxRules` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |

### Lightspeed

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/Lightspeed/ListOrUpdateProduct` | mvc | POST | 🔴 write | ConfigID ProductID SyncStockLevel bufferInventory createAsActive useBufferInventory |  |  |
| `/Lightspeed/RemoveProduct` | mvc | POST | 🔴 write | ConfigID ProductID |  |  |
| `/Lightspeed/SaveEcsProductLocally` | mvc | POST | 🔴 write | bufferInventory configID productID syncStockLevel useBufferInventory |  |  |

### Lokad

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/Lokad_Index_vSalesPriceTiers` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |

### LoyaltyLion

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/LoyaltyLion_Index` | api |  | 🟢 read |  |  |  |

### Magento2

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/Magento2/ListOrUpdateProduct` | mvc | POST | 🔴 write | ConfigID ProductID SyncStockLevel attributeSetId bufferInventory createAsActive useBufferInventory |  |  |
| `/Magento2/RemoveProduct` | mvc | POST | 🔴 write | ConfigID ProductID |  |  |
| `/Magento2/SaveEcsProductLocally` | mvc | POST | 🔴 write | bufferInventory configID productID syncStockLevel useBufferInventory |  |  |
| `/api/Magento2_Index_Dashboard_Summary` | api | GET | 🟢 read |  |  |  |
| `/api/Magento2_Index_EcsBulkList` | api | DELETE REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | Category ConfigID Family Tag brandID lang listStatus listedInConfigID search |  | root |
| `/api/Magento2_Index_Family` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Magento2_Index_Tags` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Magento2_Index_vAccounts` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Magento2_Index_vAttributeSet` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ConfigID |  |  |
| `/api/Magento2_Index_vCategory` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Magento2_Index_vCustomer` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Magento2_Index_vEcsConfiguration` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/Magento2_Index_vEcsLogs` | api | DELETE REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID search |  | root |
| `/api/Magento2_Index_vEcsPaymentProcessorMapping` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID Update |  | Mappings |
| `/api/Magento2_Index_vEcsProduct` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ConfigID ProductID |  |  |
| `/api/Magento2_Index_vEcsProductList` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID lang search |  | root |
| `/api/Magento2_Index_vEcsTaxMapping` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID Update |  | Mappings |
| `/api/Magento2_Index_vLiabilityAccounts` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Magento2_Index_vLocation` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Magento2_Index_vMagento2OverviewCustomersList` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ConfigID search |  | root |
| `/api/Magento2_Index_vMagento2OverviewSalesList` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ConfigID search |  | root |
| `/api/Magento2_Index_vMagentoStores` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | configID |  |  |
| `/api/Magento2_Index_vOperationLogs` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID search |  | root |
| `/api/Magento2_Index_vPendingOrders` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ConfigID search |  | root |
| `/api/Magento2_Index_vRevenueAccounts` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Magento2_Index_vSalesPriceTiers` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Magento2_Index_vTaxRules` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |

### MagentoSim

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/MagentoSim/ListOrUpdateProduct` | mvc | POST | 🔴 write | ConfigID ProductID SyncStockLevel attributeSetId bufferInventory createAsActive useBufferInventory |  |  |
| `/MagentoSim/RemoveProduct` | mvc | POST | 🔴 write | ConfigID ProductID |  |  |
| `/MagentoSim/SaveEcsProductLocally` | mvc | POST | 🔴 write | bufferInventory configID productID syncStockLevel useBufferInventory |  |  |
| `/api/MagentoSim_Index_Dashboard_Summary` | api | GET | 🟢 read |  |  |  |
| `/api/MagentoSim_Index_EcsBulkList` | api | DELETE REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | Category ConfigID Family Tag brandID currencyCode lang listStatus listedInConfigID search |  | root |
| `/api/MagentoSim_Index_Family` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/MagentoSim_Index_Tags` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/MagentoSim_Index_vAccounts` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/MagentoSim_Index_vAttributeSet` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ConfigID |  |  |
| `/api/MagentoSim_Index_vCategory` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/MagentoSim_Index_vCustomer` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/MagentoSim_Index_vEcsConfiguration` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/MagentoSim_Index_vEcsLogs` | api | DELETE REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID search |  | root |
| `/api/MagentoSim_Index_vEcsPaymentProcessorMapping` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID Update |  | Mappings |
| `/api/MagentoSim_Index_vEcsProduct` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ConfigID ProductID |  |  |
| `/api/MagentoSim_Index_vEcsProductList` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID lang search |  | root |
| `/api/MagentoSim_Index_vEcsTaxMapping` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID Update |  | Mappings |
| `/api/MagentoSim_Index_vLiabilityAccounts` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/MagentoSim_Index_vLocation` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/MagentoSim_Index_vMagentoSimOverviewCustomersList` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ConfigID search |  | root |
| `/api/MagentoSim_Index_vMagentoSimOverviewSalesList` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ConfigID search |  | root |
| `/api/MagentoSim_Index_vOperationLogs` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID search |  | root |
| `/api/MagentoSim_Index_vPendingOrders` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ConfigID search |  | root |
| `/api/MagentoSim_Index_vRevenueAccounts` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/MagentoSim_Index_vSalesPriceTiers` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/MagentoSim_Index_vTaxRules` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |

### MoneyTask

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/MoneyTask/Receive` | mvc |  | 🟢 read |  |  |  |
| `/MoneyTask/Spend` | mvc |  | 🟢 read |  |  |  |

### MySubscription

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/MySubscription/DetailsUpdate` | mvc | GET | 🔴 write |  |  |  |

### PaymentGateway

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/PaymentGateway_Index_ChartOfAccounts` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/PaymentGateway_Index_ChartOfAccountsNoP` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/PaymentGateway_Index_GenerateAgreement` | api | POST PUT | 🔴 write | isSandBox |  |  |
| `/api/PaymentGateway_Index_PaymentGatewayExternalAccount` | api | DELETE | 🔴 write | id |  |  |
| `/api/PaymentGateway_Index_PaymentGatewayFiles` | api | POST | 🔴 write |  |  |  |
| `/api/PaymentGateway_Index_PaymentGatewayPerson` | api | DELETE | 🔴 write | id |  |  |
| `/api/PaymentGateway_Index_PaymentGatewayRefundProcessing` | api | GET POST | 🟠 read + write | transactionID |  |  |
| `/api/PaymentGateway_Index_PaymentGatewaySetup` | api | DELETE GET POST | 🟠 read + write | checkSigning |  |  |
| `/api/PaymentGateway_Index_PaymentGatewaySetupActivation` | api | POST | 🔴 write | IsActive |  |  |
| `/api/PaymentGateway_Index_vDearPaymentGatewayDisputeItems` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  | root |
| `/api/PaymentGateway_Index_vDearPaymentGatewayDisputes` | api | GET PUT REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | DisputeID action disputeID |  | root |
| `/api/PaymentGateway_Index_vDearPaymentGatewayEmailNotificationSettings` | api | PUT REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | Code State |  | root |
| `/api/PaymentGateway_Index_vDearPaymentGatewayInternalNotificationSettings` | api | PUT REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | Code State |  | root |
| `/api/PaymentGateway_Index_vDearPaymentGatewayNotificationsLogsController` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  | root |
| `/api/PaymentGateway_Index_vDearPaymentGatewayPayoutItems` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  | root |
| `/api/PaymentGateway_Index_vDearPaymentGatewayPayouts` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  | root |
| `/api/PaymentGateway_Index_vDearPaymentGatewayRefunds` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  | root |
| `/api/PaymentGateway_Index_vDearPaymentGatewayTransactions` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  | root |

### PayPal

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/PayPal/CompletePayment` | mvc |  | 🔴 write |  |  |  |
| `/PayPal/CompleteTestPayment` | mvc |  | 🔴 write |  |  |  |
| `/PayPal/StartPayment` | mvc |  | 🔴 write | doc |  |  |
| `/PayPal/StartTestPayment` | mvc |  | 🔴 write |  |  |  |
| `/api/PayPal_Index` | api |  | 🟠 read + write |  |  |  |
| `/api/PayPal_Index_Config` | api |  | 🟠 read + write |  |  |  |
| `/api/PayPal_Index_Dashboard_Summary` | api | GET | 🟢 read |  |  |  |
| `/api/PayPal_Index_LogEntries` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  | root |
| `/api/PayPal_Index_vAccounts` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/PayPal_PayDoc_Page` | api |  | 🟢 read | doc |  |  |

### Pinch

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/Pinch/CompletePaymentToKen` | mvc | POST | 🔴 write |  |  |  |
| `/Pinch/Connect` | mvc | POST | 🔴 write |  |  |  |
| `/Pinch/Disconnect` | mvc | POST | 🔴 write |  |  |  |
| `/Pinch/Pay` | mvc |  | 🔴 write | doc |  |  |
| `/Pinch/SaveSettings` | mvc | POST | 🔴 write |  |  |  |
| `/api/Pinch_Index_Dashboard_Summary` | api | GET | 🟢 read |  |  |  |
| `/api/Pinch_Index_LogEntries` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  | root |
| `/api/Pinch_Index_vAccounts` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Pinch_PayDoc_Page` | api |  | 🟢 read | doc |  |  |

### Portal

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/Portal/AddDomain` | mvc | POST | 🔴 write |  |  |  |
| `/Portal/AuthorisePost` | mvc | POST | 🔴 write |  |  |  |
| `/Portal/BulkChangeProductBackorderState` | mvc |  | 🔴 write |  |  |  |
| `/Portal/BulkListDelist` | mvc |  | 🔴 write |  |  |  |
| `/Portal/BulkListRecalculateQuantities` | mvc |  | 🔴 write |  |  |  |
| `/Portal/ChangeProductBackorderState` | mvc | POST | 🔴 write |  | IsEnabled ProductID WebPortalID |  |
| `/Portal/CustomMenuPreview` | mvc | POST | 🟢 read |  | Colors Conditions CustomMenuFirstLevelBgColor CustomMenuFirstLevelHoverBgColor CustomMenuFirstLevelTextColor CustomMenuSecondLevelBgColor CustomMenuSecondLevel… |  |
| `/Portal/DownloadCartImage` | mvc |  | 🟢 read | id |  |  |
| `/Portal/DownloadLogo` | mvc |  | 🟢 read | id |  |  |
| `/Portal/DownloadNoImage` | mvc |  | 🟢 read | id |  |  |
| `/Portal/RemoveCustomDomain` | mvc | DELETE | 🔴 write | id |  |  |
| `/Portal/ResetCartImage` | mvc | DELETE | 🔴 write | id |  |  |
| `/Portal/UploadCartImage` | mvc | POST | 🔴 write |  |  |  |
| `/Portal/UploadLogo` | mvc | POST | 🔴 write |  |  |  |
| `/Portal/UploadPageItemsImages` | mvc | POST | 🔴 write |  |  |  |

### Product

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/Product/ExportCommodityDetails` | mvc | GET(navigate) | 🟢 read |  |  |  |
| `/Product/GetEcsFamilyImage` | mvc |  | 🟢 read | id |  |  |
| `/Product/GetEcsImage` | mvc |  | 🟢 read | id |  |  |
| `/Product/ImportProductCommodityDetails` | mvc | GET(navigate) | 🔴 write | module ref |  |  |
| `/Product/ImportProductCommodityDetailsJson` | mvc | POST | 🔴 write |  |  |  |
| `/api/Product_ImportCommodityDetails_Exceptions` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/Product_Index_Tags` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |

### QuickBooks

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/QuickBooks/ConnectWizardFinish` | mvc | POST | 🔴 write |  |  |  |
| `/api/QuickBooks_CheckOverpayments` | api | POST | 🟢 read |  |  |  |
| `/api/QuickBooks_ImportOB` | api | POST | 🔴 write |  |  |  |
| `/api/QuickBooks_ImportSoH` | api | POST | 🔴 write |  |  |  |
| `/api/QuickBooks_Index_Integration` | api | POST | 🔴 write |  |  |  |
| `/api/QuickBooks_ReplaceProduct` | api | POST | 🔴 write |  |  |  |

### Quickbooks

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/Quickbooks/ExportCOGS` | mvc | POST | 🟢 read | From To |  |  |
| `/Quickbooks/ExportHistoricalData` | mvc | POST | 🟢 read |  |  |  |
| `/Quickbooks/GenerateSaleChannelList` | mvc | POST(read) | 🔴 write | consolidationChannelTypeJsonStr requestedSaleChannelMode |  |  |
| `/Quickbooks/GetCustomersSuppliersCount` | mvc | GET | 🟢 read |  |  |  |
| `/Quickbooks/QuickbooksChartOfAccounts` | mvc | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/Quickbooks/QuickbooksInventoryProductsCount` | mvc | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/Quickbooks/QuickbooksPaymentTerms` | mvc | REST(GET read; POST/PUT/DELETE on store.sync) | 🔴 write |  |  |  |
| `/Quickbooks/QuickbooksTaxRules` | mvc | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/Quickbooks/SetQuickbooksSyncModeDirectionBothWays` | mvc | POST | 🔴 write |  |  |  |
| `/Quickbooks/VoidCOGS` | mvc | POST | 🔴 write | From To |  |  |
| `/api/Quickbooks_Customer` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  | root |
| `/api/Quickbooks_Index_JournalsReconciliation` | api | GET POST | 🟠 read + write | fromDate toDate |  |  |
| `/api/Quickbooks_Index_vMailingList` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  | root |
| `/api/Quickbooks_Location` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |

### QuickbooksImportExport

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/QuickbooksImportExport/Quickbooks` | mvc | GET(navigate) | 🔴 write |  |  |  |

### QuickLinks

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/QuickLinks_Index_Tooltips/customer` | api | GET | 🟢 read | customerId |  |  |
| `/api/QuickLinks_Index_Tooltips/product` | api | GET | 🟢 read | currentPage customerId locationId productId |  |  |
| `/api/QuickLinks_Index_Tooltips/sections` | api | GET | 🟢 read |  |  |  |
| `/api/QuickLinks_Index_Tooltips/supplier` | api | GET | 🟢 read | supplierId |  |  |

### Report

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/Report/DeleteLayout` | mvc | DELETE | 🔴 write | LayoutName ReportName |  |  |
| `/Report/DeleteLayoutNew` | mvc |  | 🔴 write | layoutName reportTypeId |  |  |
| `/api/Report_v` | api |  | 🟢 read |  |  |  |
| `/api/Report_vReportLayout` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ReportName |  |  |

### RmaPortal

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/RmaPortal/AddDomain` | mvc | POST | 🔴 write |  |  |  |
| `/RmaPortal/AuthorisePost` | mvc | POST | 🔴 write |  |  |  |
| `/RmaPortal/RemoveCustomDomain` | mvc | DELETE | 🔴 write | id |  |  |
| `/api/RmaPortal_Index_B2BPortalAppearance` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/RmaPortal_Index_ChangePortalDomain` | api | POST | 🔴 write | domainName webPortalID |  |  |
| `/api/RmaPortal_Index_vAddress` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/RmaPortal_Index_vContacts` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/RmaPortal_Index_vEmailTemplates` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | WebPortalID |  |  |
| `/api/RmaPortal_Index_vNavbarItems` | api | POST | 🔴 write |  | List WebPortalID |  |
| `/api/RmaPortal_Index_vPages` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | WebPortalID |  |  |
| `/api/RmaPortal_Index_vSortingOptions` | api | POST | 🔴 write |  | List WebPortalID |  |
| `/api/RmaPortal_Index_vWebPortal` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |

### Sale

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/Sale_Index_LookupCarrier` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ShippingServiceID carrierCode jsonData serviceCode shippingServiceID |  |  |

### SalePayDoc

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/SalePayDoc/GetCsv` | mvc | GET(navigate) | 🟢 read | doc |  |  |
| `/SalePayDoc/GetPdf` | mvc | GET(navigate) | 🟢 read | doc |  |  |

### Shipping

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/Shipping_Index_Family` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Shipping_Index_vBrands` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Shipping_Index_vCategories` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Shipping_Index_vTags` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Shipping_ProductCatalogueList` | api | POST REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | brand category family search tag |  | root |

### Shippit

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/Shippit_Index_vShipServConf` | api | PUT REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | id |  |  |
| `/api/Shippit_Index_vTaxRules` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |

### ShipRush

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/ShipRush_Index_vShipServConf` | api | GET(read) PUT REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | id |  | Configurations |

### Shipstation

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/Shipstation/ChangeMappingAndSyncStock` | mvc | POST | 🔴 write | ConfigID IgnoreProductUpdation ProductID SIMProductID SyncStockLevel |  |  |
| `/api/Shipstation_Ext_CarrierPackage` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ConfigID box carrierCode limit page start |  |  |
| `/api/Shipstation_Index_CheckProduct` | api | GET PUT | 🟠 read + write | ConfigID |  |  |
| `/api/Shipstation_Index_Dashboard_Summary` | api | GET | 🟢 read |  |  |  |
| `/api/Shipstation_Index_Product` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ConfigID IsStockProduct Name lang |  |  |
| `/api/Shipstation_Index_vEcsLocationMapping` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/Shipstation_Index_vEcsProductList` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID lang mode search |  | root |
| `/api/Shipstation_Index_vEcsUSTaxTypeAhead` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Shipstation_Index_vMailingList` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Shipstation_Index_vOperationLogs` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID search |  | root |
| `/api/Shipstation_Index_vShipIntegrationLocationMapping` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID Update |  |  |
| `/api/Shipstation_Index_vShipStationExportOrdersFilterParameter` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Shipstation_Index_vShipstationNotMatchingAddresses` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | search |  | root |
| `/api/Shipstation_Index_vShipstationOverviewCustomersList` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ConfigID search |  | root |
| `/api/Shipstation_Index_vShipstationOverviewSalesList` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ConfigID search |  | root |
| `/api/Shipstation_Index_vShipstationPendingOrders` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | search |  | root |
| `/api/Shipstation_Index_vStore` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ConfigID |  |  |
| `/api/Shipstation_Index_vTax` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/Shipstation_Index_vTenantAddress` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |

### ShipStation

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/ShipStation/ConfigurationNG` | mvc |  | 🟢 read |  |  |  |
| `/api/ShipStation_Index_vAccounts` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/ShipStation_Index_vCustomIntegration` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/ShipStation_Index_vCustomer` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/ShipStation_Index_vEcsConfiguration` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/ShipStation_Index_vEcsLogs` | api | DELETE REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID search |  | root |
| `/api/ShipStation_Index_vEcsPaymentProcessorMapping` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID |  |  |
| `/api/ShipStation_Index_vEcsTaxMapping` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/ShipStation_Index_vLocation` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/ShipStation_Index_vRevenueAccounts` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/ShipStation_Index_vSalesPriceTiers` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/ShipStation_Index_vShipServConf` | api | PUT REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/ShipStation_Index_vTaxRules` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/ShipStation_Index_vZeroTax` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |

### Shiptheory

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/Shiptheory_Index_vMailingList` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Shiptheory_Index_vShipServConf` | api | PUT REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |

### Shopify

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/Shopify/GetFeatureFlags` | mvc | GET | 🟢 read |  |  |  |
| `/api/Shopify_Chart_Sales` | api | GET | 🟢 read |  |  |  |
| `/api/Shopify_Index_BulkList` | api | DELETE PUT REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | Category ConfigID Family Tag brandID listStatus listedInConfigID search |  | root |
| `/api/Shopify_Index_Dashboard_Summary` | api | GET | 🟢 read |  |  |  |
| `/api/Shopify_Index_Family` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Shopify_Index_LocationMapping` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID Update |  |  |
| `/api/Shopify_Index_LocationMapping_Locations` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Shopify_Index_Locations` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Shopify_Index_Tags` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Shopify_Index_vAccounts` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Shopify_Index_vCategory` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Shopify_Index_vCustomer` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Shopify_Index_vLiabilityAccounts` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Shopify_Index_vMasterDataSource` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Shopify_Index_vRetailDeliveryFeeAccounts` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Shopify_Index_vRevenueAccounts` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Shopify_Index_vSaleAttributes` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Shopify_Index_vSalesPriceTiers` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Shopify_Index_vShopifyCatalog` | api | GET | 🟢 read | BufferInventory ConfigID ListAsDraft Locations Operation PriceTier ProductID SellOutOfStock UseBufferInventory |  |  |
| `/api/Shopify_Index_vShopifyCatalogList` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ConfigID search |  | root |
| `/api/Shopify_Index_vShopifyConfiguration` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/Shopify_Index_vShopifyLogs` | api | DELETE REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID dateColumn fromDate search status toDate typeFilter |  | root |
| `/api/Shopify_Index_vShopifyOperationLogs` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID categoryFilter fromDate search toDate typeFilter |  | root |
| `/api/Shopify_Index_vShopifyPaymentProcessorMapping` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID Update |  |  |
| `/api/Shopify_Index_vShopifyPendingOrders` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  | root |
| `/api/Shopify_Index_vShopifyTaxMapping` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID Update |  |  |
| `/api/Shopify_Index_vTaxRules` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |

### Square

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/Square/AddPaymentsShop` | mvc |  | 🔴 write |  |  |  |
| `/Square/ListOrUpdateProduct` | mvc | POST | 🔴 write | ConfigID ProductID SyncStockLevel bufferInventory useBufferInventory |  |  |
| `/Square/RemoveProduct` | mvc | POST | 🔴 write | ConfigID ProductID |  |  |
| `/Square/SaveEcsProductLocally` | mvc | POST | 🔴 write | bufferInventory configID productID syncStockLevel useBufferInventory |  |  |
| `/api/Square_Index_Dashboard_Summary` | api | GET | 🟢 read |  |  |  |
| `/api/Square_Index_EcsBulkList` | api | DELETE REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | Category ConfigID Family Tag brandID lang listStatus listedInConfigID search |  | root |
| `/api/Square_Index_Family` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Square_Index_Tags` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Square_Index_vAccounts` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Square_Index_vCategory` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Square_Index_vCustomer` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Square_Index_vEcsConfiguration` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/Square_Index_vEcsLogs` | api | DELETE REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID search |  | root |
| `/api/Square_Index_vEcsPaymentProcessorMapping` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID Update |  |  |
| `/api/Square_Index_vEcsProduct` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ConfigID ProductID |  |  |
| `/api/Square_Index_vEcsProductList` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID lang search |  | root |
| `/api/Square_Index_vEcsTaxMapping` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID |  |  |
| `/api/Square_Index_vLiabilityAccounts` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Square_Index_vLocation` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Square_Index_vOperationLogs` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID search |  | root |
| `/api/Square_Index_vRevenueAccounts` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Square_Index_vSalesPriceTiers` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Square_Index_vSquareOverviewCustomersList` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ConfigID search |  | root |
| `/api/Square_Index_vSquareOverviewSalesList` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ConfigID search |  | root |
| `/api/Square_Index_vSquarePendingOrders` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ConfigID search |  | root |
| `/api/Square_Index_vTaxRules` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |

### StarShipIt

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/StarShipIt_Index_vShipServConf` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/StarShipIt_Index_vTaxRules` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |

### TenantAccessToFeatures

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/TenantAccessToFeatures` | api | GET POST | 🟠 read + write |  |  |  |

### TenantAddress

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/TenantAddress_Index_vTenantAddress` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |

### TenantPaymentTerm

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/TenantPaymentTerm_Index_vTenantPaymentTerm` | api | DELETE REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | id |  |  |

### TenantTaxationRule

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/TenantTaxationRule_Index_vTenantTaxationRule` | api | POST PUT REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |

### UserImage

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/UserImage/DownloadImage` | mvc |  | 🟢 read | id |  |  |
| `/UserImage/Upload` | mvc | POST | 🔴 write |  |  |  |

### USState

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/USState` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |

### vCurrentIntegrations

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/vCurrentIntegrations` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |

### Vend

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/Vend_Index_Dashboard_Summary` | api | GET | 🟢 read |  |  |  |
| `/api/Vend_Index_EcsBulkList` | api | DELETE REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | Category ConfigID Family Tag brandID lang listStatus listedInConfigID search |  | root |
| `/api/Vend_Index_Family` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Vend_Index_Tags` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Vend_Index_vAccounts` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Vend_Index_vCategory` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Vend_Index_vCustomer` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Vend_Index_vECSPaymentsToExport` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID search |  | root |
| `/api/Vend_Index_vEcsConfiguration` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/Vend_Index_vEcsLocationMapping` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID Update |  |  |
| `/api/Vend_Index_vEcsLogs` | api | DELETE REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID search |  | root |
| `/api/Vend_Index_vEcsPaymentProcessorMapping` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID Update |  |  |
| `/api/Vend_Index_vEcsProduct` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ConfigID ProductID |  |  |
| `/api/Vend_Index_vEcsProductList` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID lang search |  | root |
| `/api/Vend_Index_vEcsPurchaseLogs` | api | DELETE REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID search |  | root |
| `/api/Vend_Index_vEcsStockAdjustmentLogs` | api | DELETE REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID search |  | root |
| `/api/Vend_Index_vEcsStockTransferLogs` | api | DELETE REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID search |  | root |
| `/api/Vend_Index_vEcsTaxMapping` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID Update |  |  |
| `/api/Vend_Index_vLiabilityAccounts` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Vend_Index_vLocation` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Vend_Index_vOperationLogs` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID search |  | root |
| `/api/Vend_Index_vRevenueAccounts` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Vend_Index_vSalesPriceTiers` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Vend_Index_vSupplier` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Vend_Index_vTaxRules` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Vend_Index_vVendOverviewCustomersList` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ConfigID search |  | root |
| `/api/Vend_Index_vVendOverviewSalesList` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ConfigID search |  | root |
| `/api/Vend_Index_vVendPendingOrders` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ConfigID search |  | root |

### Walmart

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/Walmart/ChangeMappingAndSyncStock` | mvc | POST | 🔴 write | ConfigID IgnoreProductUpdation ProductID SIMProductID SyncStockLevel bufferInventory useBufferInventory |  |  |
| `/api/Walmart_Index_AcknowledgeOrders` | api | POST | 🔴 write | LogId OrderId configId |  |  |
| `/api/Walmart_Index_CheckProduct` | api | GET PUT | 🟠 read + write | ConfigID |  |  |
| `/api/Walmart_Index_Dashboard_Summary` | api | GET | 🟢 read |  |  |  |
| `/api/Walmart_Index_Product` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ConfigID IsStockProduct Name lang |  |  |
| `/api/Walmart_Index_vAccounts` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Walmart_Index_vBankAccounts` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Walmart_Index_vCustomer` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Walmart_Index_vEcsConfiguration` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/Walmart_Index_vEcsLogs` | api | DELETE REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID search |  | root |
| `/api/Walmart_Index_vEcsPaymentProcessorMapping` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID |  | Mappings |
| `/api/Walmart_Index_vEcsProductList` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ConfigID lang mode search status |  | root |
| `/api/Walmart_Index_vEcsTaxMapping` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID Update |  |  |
| `/api/Walmart_Index_vLocation` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Walmart_Index_vLocationExt` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Walmart_Index_vOperLog` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID search |  | root |
| `/api/Walmart_Index_vPendingOrders` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ConfigID search |  | root |
| `/api/Walmart_Index_vRevenueAccounts` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Walmart_Index_vSalesPriceTiers` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Walmart_Index_vTaxRules` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Walmart_Index_vWalmartOverviewCustomersList` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ConfigID search |  | root |
| `/api/Walmart_Index_vWalmartOverviewSalesList` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ConfigID search |  | root |

### WooCommerce

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/WooCommerce/ListOrUpdateProduct` | mvc | POST | 🔴 write | ConfigID ProductID SyncStockLevel bufferInventory createAsActive useBufferInventory |  |  |
| `/WooCommerce/RemoveProduct` | mvc | POST | 🔴 write | ConfigID ProductID |  |  |
| `/WooCommerce/SaveEcsProductLocally` | mvc | POST | 🔴 write | bufferInventory configID productID syncStockLevel useBufferInventory |  |  |
| `/api/WooCommerce_Index_Dashboard_Summary` | api | GET | 🟢 read |  |  |  |
| `/api/WooCommerce_Index_EcsBulkList` | api | DELETE REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | Category ConfigID Family Tag brandID lang listStatus listedInConfigID search |  | root |
| `/api/WooCommerce_Index_Family` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/WooCommerce_Index_Tags` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/WooCommerce_Index_vAccounts` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/WooCommerce_Index_vCategory` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/WooCommerce_Index_vCustomer` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/WooCommerce_Index_vEcsConfiguration` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |  |  |  |
| `/api/WooCommerce_Index_vEcsLogs` | api | DELETE REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID search |  | root |
| `/api/WooCommerce_Index_vEcsPaymentProcessorMapping` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID Update |  | Mappings |
| `/api/WooCommerce_Index_vEcsProduct` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ConfigID ProductID |  |  |
| `/api/WooCommerce_Index_vEcsProductList` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID lang search |  | root |
| `/api/WooCommerce_Index_vEcsTaxMapping` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID Update |  | Mappings |
| `/api/WooCommerce_Index_vLocation` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/WooCommerce_Index_vOperationLogs` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write | ConfigID search |  | root |
| `/api/WooCommerce_Index_vPendingOrders` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ConfigID search |  | root |
| `/api/WooCommerce_Index_vRevenueAccounts` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/WooCommerce_Index_vSalesPriceTiers` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/WooCommerce_Index_vTaxRules` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/WooCommerce_Index_vWooCommerceOverviewCustomersList` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ConfigID search |  | root |
| `/api/WooCommerce_Index_vWooCommerceOverviewSalesList` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read | ConfigID search |  | root |

### Xero

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/Xero/ConnectWizardFinish` | mvc | POST | 🔴 write |  |  |  |
| `/Xero/CreateXeroAccount` | mvc | POST | 🔴 write |  |  |  |
| `/Xero/GetCustomersSuppliersCount` | mvc | GET | 🟢 read |  |  |  |
| `/Xero/XeroChartOfAccounts` | mvc | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/Xero/XeroTaxRules` | mvc | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |

### XEROImportExport

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/XEROImportExport/WizardConnectToXero` | mvc | GET(navigate) | 🔴 write |  |  |  |
