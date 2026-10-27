# Integrations

The integrations catalogue (`/Integrations`) and one subfolder per connector: its settings page, mappings, sync logs and endpoints.

| 📄 Pages | 🧱 Models | 🔌 Endpoints | ✍️ Can write | 🌍 Public API |
|:-:|:-:|:-:|:-:|:-:|
| **1** | **1** + [shared](../00-shared/README.md) | **0** | 0 | **0** |

[📄 Pages (1)](#pages) · [🧱 Models (1)](#data-models) · [🖼️ UI](UI.md) · [🗄️ schema.sql](schema.sql)

## Integrations

| Integration | Page | Endpoints | Data models |
|---|---|---:|---:|
| [Shared integration endpoints](_common/README.md) |  | 1 | 0 |
| [Airwallex](airwallex/README.md) | `/Airwallex` | 0 | 0 |
| [Amazon](amazon/README.md) | `/Amazon` | 45 | 29 |
| [AuthorizeNet](authorizenet/README.md) | `/AuthorizeNet` | 11 | 2 |
| [Avalara](avalara/README.md) | `/Avalara` | 15 | 8 |
| [BigCommerce](bigcommerce/README.md) | `/Bigcommerce` | 24 | 17 |
| [Capsule](capsule/README.md) | `/Capsule` | 9 | 7 |
| [Cin7 Core API setup](cin7-core-api-setup/README.md) | `/ExternalApi` | 7 | 4 |
| [Cin7 Core Payments](cin7-core-payments/README.md) | `/PaymentGateway` | 20 | 9 |
| [EasyPost](easypost/README.md) | `/EasyPost` | 1 | 5 |
| [eBay](ebay/README.md) | `/eBayNG` | 34 | 31 |
| [Etsy](etsy/README.md) | `/Etsy` | 27 | 27 |
| [Faire](faire/README.md) | `/Faire` | 27 | 21 |
| [Fulfillment by Amazon](fulfillment-by-amazon/README.md) | `/FBA` | 23 | 25 |
| [Google Workspaces](google-workspaces/README.md) | `/GSuites` | 6 | 3 |
| [HubSpot](hubspot/README.md) | `/HubSpot` | 25 | 19 |
| [LeafLink](leaflink/README.md) | `/LeafLink` | 24 | 18 |
| [Lightspeed](lightspeed/README.md) | `/Lightspeed`, `/Vend` | 31 | 22 |
| [Lokad](lokad/README.md) | `/Lokad` | 5 | 0 |
| [LoyaltyLion](loyaltylion/README.md) | `/LoyaltyLion` | 2 | 1 |
| [Magento 1.x](magento-1-x/README.md) | `/MagentoSIM` | 27 | 18 |
| [Magento 2.x](magento-2-x/README.md) | `/Magento2` | 27 | 19 |
| [Neto](neto/README.md) | `/Neto` | 0 | 0 |
| [PayPal](paypal/README.md) | `/PayPal` | 10 | 2 |
| [Pinch](pinch/README.md) | `/Pinch` | 9 | 2 |
| [Portal](portal/README.md) | `/Portal` | 62 | 30 |
| [POS](pos/README.md) | `/DearPos` | 69 | 43 |
| [QuickBooks](quickbooks/README.md) | `/Quickbooks` | 37 | 11 |
| [RMA Portal](rma-portal/README.md) | `/RmaPortal` | 12 | 6 |
| [Shippit](shippit/README.md) | `/Shippit` | 2 | 6 |
| [ShipRush](shiprush/README.md) | `/ShipRush` | 2 | 8 |
| [ShipStation](shipstation/README.md) | `/ShipStation/ConfigurationNG` | 34 | 37 |
| [Shiptheory](shiptheory/README.md) | `/Shiptheory` | 11 | 12 |
| [Shopify](shopify/README.md) | `/Shopify` | 32 | 22 |
| [Square](square/README.md) | `/Square/Main` | 27 | 19 |
| [StarShipIT](starshipit/README.md) | `/StarShipIt` | 2 | 9 |
| [Synder](synder/README.md) | `/Synder` | 0 | 0 |
| [Walmart](walmart/README.md) | `/Walmart` | 22 | 19 |
| [Warehouse application configuration](warehouse-application-configuration/README.md) | `/WarehouseApp` | 0 | 2 |
| [WooCommerce](woocommerce/README.md) | `/WooCommerce` | 24 | 18 |
| [Xero](xero/README.md) | `/Xero` | 9 | 5 |
| [Zapier](zapier/README.md) | `/Zapier` | 0 | 0 |

## Endpoints by integration

Every internal endpoint, filed under the integration its controller names (whichever page calls it). Full detail, data models and UI are in each subfolder.

<details><summary><b>Shared integration endpoints</b> · 1 endpoints (0 write)</summary>

| URL | Methods | Effect |
|---|---|---|
| `/api/vCurrentIntegrations` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |

</details>

<details><summary><b>Amazon</b> · 45 endpoints (21 write)</summary>

| URL | Methods | Effect |
|---|---|---|
| `/Amazon/ChangeMappingAndSyncStock` | POST | 🔴 write |
| `/Amazon/CopyCarrierMappings` | POST | 🔴 write |
| `/Product/GetEcsFamilyImage` |  | 🟢 read |
| `/Product/GetEcsImage` |  | 🟢 read |
| `/api/AmazonBusinessShipping/GetBhdrWarningOrDefault` | GET | 🟢 read |
| `/api/Amazon_Index_CheckFamily` | GET PUT | 🟠 read + write |
| `/api/Amazon_Index_CheckProduct` | GET PUT | 🟠 read + write |
| `/api/Amazon_Index_ConfirmSettlementXeroSync` | POST | 🔴 write |
| `/api/Amazon_Index_Dashboard_Summary` | GET | 🟢 read |
| `/api/Amazon_Index_EUCountries` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Amazon_Index_Family` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Amazon_Index_Marketplace` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/Amazon_Index_Product` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Amazon_Index_RecalculateCogs` | POST | 🔴 write |
| `/api/Amazon_Index_RecalculateSettlementInvoice` | POST | 🔴 write |
| `/api/Amazon_Index_SettlementCogs` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/Amazon_Index_SettlementDetails` | POST | 🟢 read |
| `/api/Amazon_Index_SettlementLines` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/Amazon_Index_vAccountMJMapping` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/Amazon_Index_vAccounts` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Amazon_Index_vAmazonOverviewCustomersList` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Amazon_Index_vAmazonOverviewSalesList` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Amazon_Index_vAmazonPendingOrders` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Amazon_Index_vAmazonSettlements` | DELETE REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/Amazon_Index_vBankAccounts` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Amazon_Index_vCustomer` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Amazon_Index_vECSCarrierMapping` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/Amazon_Index_vEcsConfiguration` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/Amazon_Index_vEcsLogs` | DELETE REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/Amazon_Index_vEcsPaymentProcessorMapping` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/Amazon_Index_vEcsProductList` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Amazon_Index_vEcsTaxMapping` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/Amazon_Index_vEcsVariationList` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Amazon_Index_vEcsVariationManual` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Amazon_Index_vLocation` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Amazon_Index_vLocationExt` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Amazon_Index_vManualJournalAccounts` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Amazon_Index_vOperLog` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/Amazon_Index_vRevenueAccounts` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Amazon_Index_vSalesPriceTiers` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Amazon_Index_vTax` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/Amazon_Index_vTaxRules` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/ECommerce_Common_BulkListing/product/brands` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/ECommerce_Common_BulkListing/shops` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/EcsOrderLogExport` | GET | 🟢 read |

</details>

<details><summary><b>AuthorizeNet</b> · 11 endpoints (6 write)</summary>

| URL | Methods | Effect |
|---|---|---|
| `/AuthorizeNet/GetTokenForManageCustomer` | GET | 🟢 read |
| `/AuthorizeNet/Pay` |  | 🔴 write |
| `/AuthorizeNet/PrepareAuthorizeNetSession` | GET | 🔴 write |
| `/Authorizenet/Disconnect` | POST | 🔴 write |
| `/Authorizenet/SaveSettings` | POST | 🔴 write |
| `/SalePayDoc/GetCsv` | GET(navigate) | 🟢 read |
| `/SalePayDoc/GetPdf` | GET(navigate) | 🟢 read |
| `/api/AuthorizeNet_Index_Dashboard_Summary` | GET | 🟢 read |
| `/api/AuthorizeNet_Index_LogEntries` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/AuthorizeNet_Index_vAccounts` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/AuthorizeNet_PayDoc_Page` |  | 🟢 read |

</details>

<details><summary><b>Avalara</b> · 15 endpoints (7 write)</summary>

| URL | Methods | Effect |
|---|---|---|
| `/Avalara/CheckAvalaraAddresses` | POST | 🟢 read |
| `/api/Avalara_Index_CustomerDataList` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Avalara_Index_CustomerDataList/ApplyLink` | POST | 🔴 write |
| `/api/Avalara_Index_CustomerDataList/AutoLinkByCustomerName` | POST | 🔴 write |
| `/api/Avalara_Index_CustomerDataList/Customers` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Avalara_Index_CustomerDataList/LoadFromAvalara` | POST | 🔴 write |
| `/api/Avalara_Index_LicenseKey` | POST | 🔴 write |
| `/api/Avalara_Index_vCompany` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Avalara_Index_vMailingList` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/Avalara_Index_vProductsTaxCodeList` | POST REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Avalara_Index_vSyncEntries` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/Avalara_Index_vTaxCodeList` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Avalara_Index_vTaxCodeList/TaxExemptionReason` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Avalara_Index_vTaxCodeList/hasintegration` | GET | 🟢 read |
| `/api/TenantAddress_Index_vTenantAddress` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |

</details>

<details><summary><b>BigCommerce</b> · 24 endpoints (10 write)</summary>

| URL | Methods | Effect |
|---|---|---|
| `/Bigcommerce/ListOrUpdateProduct` | POST | 🔴 write |
| `/Bigcommerce/RemoveProduct` | POST | 🔴 write |
| `/Bigcommerce/SaveEcsProductLocally` | POST | 🔴 write |
| `/api/Bigcommerce_Index_Dashboard_Summary` | GET | 🟢 read |
| `/api/Bigcommerce_Index_EcsBulkList` | DELETE REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/Bigcommerce_Index_Family` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Bigcommerce_Index_Tags` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Bigcommerce_Index_vAccounts` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Bigcommerce_Index_vBigcommerceOverviewCustomersList` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Bigcommerce_Index_vBigcommerceOverviewSalesList` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Bigcommerce_Index_vCategory` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Bigcommerce_Index_vCustomer` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Bigcommerce_Index_vEcsConfiguration` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/Bigcommerce_Index_vEcsLogs` | DELETE REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/Bigcommerce_Index_vEcsPaymentProcessorMapping` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/Bigcommerce_Index_vEcsProduct` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Bigcommerce_Index_vEcsProductList` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/Bigcommerce_Index_vEcsTaxMapping` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/Bigcommerce_Index_vLocation` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Bigcommerce_Index_vOperationLogs` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/Bigcommerce_Index_vPendingOrders` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Bigcommerce_Index_vRevenueAccounts` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Bigcommerce_Index_vSalesPriceTiers` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Bigcommerce_Index_vTaxRules` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |

</details>

<details><summary><b>Capsule</b> · 9 endpoints (5 write)</summary>

| URL | Methods | Effect |
|---|---|---|
| `/api/Capsule_Index_ContactsDashboard_Summary` | GET | 🟢 read |
| `/api/Capsule_Index_PurchaseTaxRules` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Capsule_Index_SaleTaxRules` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Capsule_Index_vAddressType` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/Capsule_Index_vContactType` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Capsule_Index_vEcsAddressTypeMapping` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/Capsule_Index_vEcsConfiguration` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/Capsule_Index_vEcsContact` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/Capsule_Index_vEcsContactTagMapping` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |

</details>

<details><summary><b>Cin7 Core API setup</b> · 7 endpoints (2 write)</summary>

| URL | Methods | Effect |
|---|---|---|
| `/api/DearApi_Index_ApiExplorer` | POST | 🔴 write |
| `/api/DearApi_Index_Dashboard_Summary` | GET | 🟢 read |
| `/api/DearApi_Index_vApplicationNG` | GET PUT | 🟠 read + write |
| `/api/DearApi_Index_vDearApiRequestsNG` | GET REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/DearApi_Index_vEndpointActionParams` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/DearApi_Index_vEndpointActions` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/DearApi_Index_vEndpoints` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |

</details>

<details><summary><b>Cin7 Core Payments</b> · 20 endpoints (20 write)</summary>

| URL | Methods | Effect |
|---|---|---|
| `/api/Cin7Pay_Index_Cin7PayRefundProcessing` | POST | 🔴 write |
| `/api/Cin7Pay_Index_vCin7PayTransactions` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/PaymentGateway_Index_ChartOfAccounts` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/PaymentGateway_Index_ChartOfAccountsNoP` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/PaymentGateway_Index_GenerateAgreement` | POST PUT | 🔴 write |
| `/api/PaymentGateway_Index_PaymentGatewayExternalAccount` | DELETE | 🔴 write |
| `/api/PaymentGateway_Index_PaymentGatewayFiles` | POST | 🔴 write |
| `/api/PaymentGateway_Index_PaymentGatewayPerson` | DELETE | 🔴 write |
| `/api/PaymentGateway_Index_PaymentGatewayRefundProcessing` | GET POST | 🟠 read + write |
| `/api/PaymentGateway_Index_PaymentGatewaySetup` | DELETE GET POST | 🟠 read + write |
| `/api/PaymentGateway_Index_PaymentGatewaySetupActivation` | POST | 🔴 write |
| `/api/PaymentGateway_Index_vDearPaymentGatewayDisputeItems` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/PaymentGateway_Index_vDearPaymentGatewayDisputes` | GET PUT REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/PaymentGateway_Index_vDearPaymentGatewayEmailNotificationSettings` | PUT REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/PaymentGateway_Index_vDearPaymentGatewayInternalNotificationSettings` | PUT REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/PaymentGateway_Index_vDearPaymentGatewayNotificationsLogsController` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/PaymentGateway_Index_vDearPaymentGatewayPayoutItems` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/PaymentGateway_Index_vDearPaymentGatewayPayouts` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/PaymentGateway_Index_vDearPaymentGatewayRefunds` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/PaymentGateway_Index_vDearPaymentGatewayTransactions` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |

</details>

<details><summary><b>EasyPost</b> · 1 endpoints (1 write)</summary>

| URL | Methods | Effect |
|---|---|---|
| `/api/EasyPost_Index_vShipServConf` | GET(read) PUT REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |

</details>

<details><summary><b>eBay</b> · 34 endpoints (11 write)</summary>

| URL | Methods | Effect |
|---|---|---|
| `/EbayNG/ChangeMappingAndSyncStock` | POST | 🔴 write |
| `/api/EBayNG_Index_vOperationLogs` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/EBayNG_Index_vRevenueAccounts` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/EbayNG_Index_CheckFamily` | GET PUT | 🟠 read + write |
| `/api/EbayNG_Index_CheckProduct` | GET PUT | 🟠 read + write |
| `/api/EbayNG_Index_Dashboard_Summary` | GET | 🟢 read |
| `/api/EbayNG_Index_Family` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/EbayNG_Index_Migration` | GET PUT | 🟠 read + write |
| `/api/EbayNG_Index_Product` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/EbayNG_Index_PublishingFailed` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/EbayNG_Index_PublishingNotListed` | PUT REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/EbayNG_Index_Tags` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/EbayNG_Index_vAccounts` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/EbayNG_Index_vCategory` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/EbayNG_Index_vCustomer` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/EbayNG_Index_vEBayPendingOrders` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/EbayNG_Index_vEbayCategory` | GET | 🟢 read |
| `/api/EbayNG_Index_vEbayCategorySg` | GET | 🟢 read |
| `/api/EbayNG_Index_vEbayCategorySpecs` | GET | 🟢 read |
| `/api/EbayNG_Index_vEbayPublishingProfiles` | PUT REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/EbayNG_Index_vEcsConfiguration` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/EbayNG_Index_vEcsLogs` | DELETE REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/EbayNG_Index_vEcsPaymentProcessorMapping` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/EbayNG_Index_vEcsProductList` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/EbayNG_Index_vEcsTaxMapping` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/EbayNG_Index_vEcsVariationList` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/EbayNG_Index_vEcsVariationManual` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/EbayNG_Index_vLiabilityAccounts` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/EbayNG_Index_vLocation` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/EbayNG_Index_vSalesPriceTiers` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/EbayNG_Index_vSiteId` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/EbayNG_Index_vTaxRules` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/EbayNG_Index_veBayOverviewCustomersList` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/EbayNG_Index_veBayOverviewSalesList` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |

</details>

<details><summary><b>Etsy</b> · 27 endpoints (10 write)</summary>

| URL | Methods | Effect |
|---|---|---|
| `/Etsy/ChangeMappingAndSyncStock` | POST | 🔴 write |
| `/api/Etsy_Index_CheckFamily` | GET PUT | 🟠 read + write |
| `/api/Etsy_Index_CheckProduct` | GET PUT | 🟠 read + write |
| `/api/Etsy_Index_Dashboard_Summary` | GET | 🟢 read |
| `/api/Etsy_Index_Family` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Etsy_Index_Product` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Etsy_Index_PublishingFailed` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Etsy_Index_PublishingNotListed` | PUT REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/Etsy_Index_PublishingProfiles` | PUT REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/Etsy_Index_vAccounts` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Etsy_Index_vCustomer` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Etsy_Index_vEcsConfiguration` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/Etsy_Index_vEcsLogs` | DELETE REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/Etsy_Index_vEcsPaymentProcessorMapping` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/Etsy_Index_vEcsProductList` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Etsy_Index_vEcsTaxMapping` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/Etsy_Index_vEcsVariationList` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Etsy_Index_vEcsVariationManual` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Etsy_Index_vEtsyOverviewCustomersList` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Etsy_Index_vEtsyOverviewSalesList` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Etsy_Index_vEtsyPendingOrders` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Etsy_Index_vLocation` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Etsy_Index_vOperationLogs` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/Etsy_Index_vReferenceDataForPublishing` | GET | 🟢 read |
| `/api/Etsy_Index_vRevenueAccounts` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Etsy_Index_vSalesPriceTiers` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Etsy_Index_vTaxRules` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |

</details>

<details><summary><b>Faire</b> · 27 endpoints (12 write)</summary>

| URL | Methods | Effect |
|---|---|---|
| `/Faire/CopyCarrierMappings` | POST | 🔴 write |
| `/Faire/ListOrUpdateProduct` | POST | 🔴 write |
| `/Faire/RemoveProduct` | POST | 🔴 write |
| `/Faire/SaveEcsProductLocally` | POST | 🔴 write |
| `/api/Faire_Index_Dashboard_Summary` | GET | 🟢 read |
| `/api/Faire_Index_EcsBulkList` | DELETE REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/Faire_Index_Family` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Faire_Index_Tags` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Faire_Index_TaxonomyTypes` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Faire_Index_vAccounts` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Faire_Index_vCategory` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Faire_Index_vCustomer` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Faire_Index_vEcsCarrierMapping` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/Faire_Index_vEcsConfiguration` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/Faire_Index_vEcsLogs` | DELETE REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/Faire_Index_vEcsPaymentProcessorMapping` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/Faire_Index_vEcsProduct` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Faire_Index_vEcsProductList` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/Faire_Index_vEcsTaxMapping` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/Faire_Index_vFaireOverviewCustomersList` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Faire_Index_vFaireOverviewSalesList` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Faire_Index_vFairePendingOrders` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Faire_Index_vLocation` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Faire_Index_vOperationLogs` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/Faire_Index_vRevenueAccounts` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Faire_Index_vSalesPriceTiers` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Faire_Index_vTaxRules` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |

</details>

<details><summary><b>Fulfillment by Amazon</b> · 23 endpoints (12 write)</summary>

| URL | Methods | Effect |
|---|---|---|
| `/FBA/ChangeMapping` | POST | 🔴 write |
| `/FBA/DownloadLabels` | POST | 🟢 read |
| `/FBA/GenerateBoxLabels` | POST | 🔴 write |
| `/FBA/ImportBoxContent` | POST | 🔴 write |
| `/FBA/QueueStockSync` | POST | 🔴 write |
| `/api/FBA_Index_Carriers` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/FBA_Index_CheckProduct` | GET PUT | 🟠 read + write |
| `/api/FBA_Index_Dashboard_Summary` | GET | 🟢 read |
| `/api/FBA_Index_FulfillmentBoxOptions` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/FBA_Index_LogisticsProviderOptions` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/FBA_Index_McfChannelMapping` | GET REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/FBA_Index_vAmazonConfiguration` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/FBA_Index_vAmazonOverviewCustomersList` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/FBA_Index_vAmazonOverviewOrdersList` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/FBA_Index_vChooseLocation` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/FBA_Index_vEcsConfiguration` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/FBA_Index_vFFProductList` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/FBA_Index_vFulfillmentInboundShipment` | DELETE PUT REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/FBA_Index_vFulfillmentOutboundShipmentEstimate` | POST | 🟢 read |
| `/api/FBA_Index_vLog` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/FBA_Index_vOperLog` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/FBA_Index_vProductList` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/FBA_Index_vSalesPriceTiers` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |

</details>

<details><summary><b>Google Workspaces</b> · 6 endpoints (3 write)</summary>

| URL | Methods | Effect |
|---|---|---|
| `/api/GSuites_Index_Config` | GET REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/GSuites_Index_Contacts` | GET REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/GSuites_Index_Directory` | GET | 🟢 read |
| `/api/GSuites_Index_Files` | GET POST | 🟢 read |
| `/api/GSuites_Index_Files/GetAccessToken` | GET | 🟢 read |
| `/api/GSuites_Index_Logs` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |

</details>

<details><summary><b>HubSpot</b> · 25 endpoints (15 write)</summary>

| URL | Methods | Effect |
|---|---|---|
| `/HubSpot/Reconnect` | GET(navigate) | 🔴 write |
| `/api/HubSpot_Index/CatalogViewList` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/HubSpot_Index/CreateProperty` | POST | 🔴 write |
| `/api/HubSpot_Index/HsObjectProperties` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/HubSpot_Index/HubSpotReferenceData` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/HubSpot_Index/Pipelines` | GET | 🟢 read |
| `/api/HubSpot_Index/vCustomers` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/HubSpot_Index/vHubSpot` | GET REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/HubSpot_Index/vHubSpotContacts` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/HubSpot_Index/vHubSpotFieldsMapping` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/HubSpot_Index/vHubSpotPipelineStageMapping` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/HubSpot_Index/vImportSales` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/HubSpot_Index_Dashboard_Summary` | GET | 🟢 read |
| `/api/HubSpot_Index_DearProduct` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/HubSpot_Index_Disconnect` | DELETE | 🔴 write |
| `/api/HubSpot_Index_SaleTaxRules` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/HubSpot_Index_vCatalog` | GET POST | 🟠 read + write |
| `/api/HubSpot_Index_vCurrency` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/HubSpot_Index_vExportSales` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/HubSpot_Index_vHubSpotOverviewCustomersList` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/HubSpot_Index_vHubSpotOverviewSalesList` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/HubSpot_Index_vLog` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/HubSpot_Index_vMailingList` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/HubSpot_Index_vProductToExport` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/HubSpot_Index_vSalesPriceTiers` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |

</details>

<details><summary><b>LeafLink</b> · 24 endpoints (10 write)</summary>

| URL | Methods | Effect |
|---|---|---|
| `/LeafLink/ListOrUpdateProduct` | POST | 🔴 write |
| `/LeafLink/RemoveProduct` | POST | 🔴 write |
| `/LeafLink/SaveEcsProductLocally` | POST | 🔴 write |
| `/api/LeafLink_Index_Dashboard_Summary` | GET | 🟢 read |
| `/api/LeafLink_Index_EcsBulkList` | DELETE REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/LeafLink_Index_Family` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/LeafLink_Index_Tags` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/LeafLink_Index_vAccounts` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/LeafLink_Index_vCategory` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/LeafLink_Index_vCustomer` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/LeafLink_Index_vEcsConfiguration` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/LeafLink_Index_vEcsLogs` | DELETE REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/LeafLink_Index_vEcsPaymentProcessorMapping` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/LeafLink_Index_vEcsProduct` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/LeafLink_Index_vEcsProductList` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/LeafLink_Index_vEcsTaxMapping` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/LeafLink_Index_vLeafLinkOverviewCustomersList` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/LeafLink_Index_vLeafLinkOverviewSalesList` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/LeafLink_Index_vLeafLinkPendingOrders` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/LeafLink_Index_vLocation` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/LeafLink_Index_vOperationLogs` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/LeafLink_Index_vRevenueAccounts` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/LeafLink_Index_vSalesPriceTiers` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/LeafLink_Index_vTaxRules` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |

</details>

<details><summary><b>Lightspeed</b> · 31 endpoints (15 write)</summary>

| URL | Methods | Effect |
|---|---|---|
| `/Lightspeed/ListOrUpdateProduct` | POST | 🔴 write |
| `/Lightspeed/RemoveProduct` | POST | 🔴 write |
| `/Lightspeed/SaveEcsProductLocally` | POST | 🔴 write |
| `/api/Vend_Index_Dashboard_Summary` | GET | 🟢 read |
| `/api/Vend_Index_EcsBulkList` | DELETE REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/Vend_Index_Family` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Vend_Index_Tags` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Vend_Index_vAccounts` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Vend_Index_vCategory` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Vend_Index_vCustomer` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Vend_Index_vECSPaymentsToExport` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/Vend_Index_vEcsConfiguration` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/Vend_Index_vEcsLocationMapping` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/Vend_Index_vEcsLogs` | DELETE REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/Vend_Index_vEcsPaymentProcessorMapping` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/Vend_Index_vEcsProduct` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Vend_Index_vEcsProductList` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/Vend_Index_vEcsPurchaseLogs` | DELETE REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/Vend_Index_vEcsStockAdjustmentLogs` | DELETE REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/Vend_Index_vEcsStockTransferLogs` | DELETE REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/Vend_Index_vEcsTaxMapping` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/Vend_Index_vLiabilityAccounts` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Vend_Index_vLocation` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Vend_Index_vOperationLogs` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/Vend_Index_vRevenueAccounts` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Vend_Index_vSalesPriceTiers` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Vend_Index_vSupplier` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Vend_Index_vTaxRules` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Vend_Index_vVendOverviewCustomersList` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Vend_Index_vVendOverviewSalesList` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Vend_Index_vVendPendingOrders` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |

</details>

<details><summary><b>Lokad</b> · 5 endpoints (0 write)</summary>

| URL | Methods | Effect |
|---|---|---|
| `/api/Lokad_Index_vSalesPriceTiers` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/QuickLinks_Index_Tooltips/customer` | GET | 🟢 read |
| `/api/QuickLinks_Index_Tooltips/product` | GET | 🟢 read |
| `/api/QuickLinks_Index_Tooltips/sections` | GET | 🟢 read |
| `/api/QuickLinks_Index_Tooltips/supplier` | GET | 🟢 read |

</details>

<details><summary><b>LoyaltyLion</b> · 2 endpoints (0 write)</summary>

| URL | Methods | Effect |
|---|---|---|
| `/api/LoyaltyLion_Index` |  | 🟢 read |
| `/api/access` | POST REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |

</details>

<details><summary><b>Magento 1.x</b> · 27 endpoints (10 write)</summary>

| URL | Methods | Effect |
|---|---|---|
| `/MagentoSim/ListOrUpdateProduct` | POST | 🔴 write |
| `/MagentoSim/RemoveProduct` | POST | 🔴 write |
| `/MagentoSim/SaveEcsProductLocally` | POST | 🔴 write |
| `/api/MagentoSim_Index_Dashboard_Summary` | GET | 🟢 read |
| `/api/MagentoSim_Index_EcsBulkList` | DELETE REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/MagentoSim_Index_Family` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/MagentoSim_Index_Tags` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/MagentoSim_Index_vAccounts` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/MagentoSim_Index_vAttributeSet` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/MagentoSim_Index_vCategory` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/MagentoSim_Index_vCustomer` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/MagentoSim_Index_vEcsConfiguration` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/MagentoSim_Index_vEcsLogs` | DELETE REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/MagentoSim_Index_vEcsPaymentProcessorMapping` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/MagentoSim_Index_vEcsProduct` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/MagentoSim_Index_vEcsProductList` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/MagentoSim_Index_vEcsTaxMapping` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/MagentoSim_Index_vLiabilityAccounts` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/MagentoSim_Index_vLocation` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/MagentoSim_Index_vMagentoSimOverviewCustomersList` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/MagentoSim_Index_vMagentoSimOverviewSalesList` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/MagentoSim_Index_vOperationLogs` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/MagentoSim_Index_vPendingOrders` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/MagentoSim_Index_vRevenueAccounts` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/MagentoSim_Index_vSalesPriceTiers` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/MagentoSim_Index_vTaxRules` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/currency` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |

</details>

<details><summary><b>Magento 2.x</b> · 27 endpoints (10 write)</summary>

| URL | Methods | Effect |
|---|---|---|
| `/Magento2/ListOrUpdateProduct` | POST | 🔴 write |
| `/Magento2/RemoveProduct` | POST | 🔴 write |
| `/Magento2/SaveEcsProductLocally` | POST | 🔴 write |
| `/api/Magento2_Index_Dashboard_Summary` | GET | 🟢 read |
| `/api/Magento2_Index_EcsBulkList` | DELETE REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/Magento2_Index_Family` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Magento2_Index_Tags` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Magento2_Index_vAccounts` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Magento2_Index_vAttributeSet` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Magento2_Index_vCategory` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Magento2_Index_vCustomer` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Magento2_Index_vEcsConfiguration` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/Magento2_Index_vEcsLogs` | DELETE REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/Magento2_Index_vEcsPaymentProcessorMapping` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/Magento2_Index_vEcsProduct` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Magento2_Index_vEcsProductList` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/Magento2_Index_vEcsTaxMapping` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/Magento2_Index_vLiabilityAccounts` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Magento2_Index_vLocation` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Magento2_Index_vMagento2OverviewCustomersList` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Magento2_Index_vMagento2OverviewSalesList` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Magento2_Index_vMagentoStores` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Magento2_Index_vOperationLogs` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/Magento2_Index_vPendingOrders` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Magento2_Index_vRevenueAccounts` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Magento2_Index_vSalesPriceTiers` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Magento2_Index_vTaxRules` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |

</details>

<details><summary><b>PayPal</b> · 10 endpoints (8 write)</summary>

| URL | Methods | Effect |
|---|---|---|
| `/PayPal/CompletePayment` |  | 🔴 write |
| `/PayPal/CompleteTestPayment` |  | 🔴 write |
| `/PayPal/StartPayment` |  | 🔴 write |
| `/PayPal/StartTestPayment` |  | 🔴 write |
| `/api/PayPal_Index` |  | 🟠 read + write |
| `/api/PayPal_Index_Config` |  | 🟠 read + write |
| `/api/PayPal_Index_Dashboard_Summary` | GET | 🟢 read |
| `/api/PayPal_Index_LogEntries` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/PayPal_Index_vAccounts` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/PayPal_PayDoc_Page` |  | 🟢 read |

</details>

<details><summary><b>Pinch</b> · 9 endpoints (6 write)</summary>

| URL | Methods | Effect |
|---|---|---|
| `/Pinch/CompletePaymentToKen` | POST | 🔴 write |
| `/Pinch/Connect` | POST | 🔴 write |
| `/Pinch/Disconnect` | POST | 🔴 write |
| `/Pinch/Pay` |  | 🔴 write |
| `/Pinch/SaveSettings` | POST | 🔴 write |
| `/api/Pinch_Index_Dashboard_Summary` | GET | 🟢 read |
| `/api/Pinch_Index_LogEntries` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/Pinch_Index_vAccounts` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Pinch_PayDoc_Page` |  | 🟢 read |

</details>

<details><summary><b>Portal</b> · 62 endpoints (38 write)</summary>

| URL | Methods | Effect |
|---|---|---|
| `/Account/LoginRMA` |  | 🔴 write |
| `/Portal/AddDomain` | POST | 🔴 write |
| `/Portal/AuthorisePost` | POST | 🔴 write |
| `/Portal/BulkChangeProductBackorderState` |  | 🔴 write |
| `/Portal/BulkListDelist` |  | 🔴 write |
| `/Portal/BulkListRecalculateQuantities` |  | 🔴 write |
| `/Portal/ChangeProductBackorderState` | POST | 🔴 write |
| `/Portal/CustomMenuPreview` | POST | 🟢 read |
| `/Portal/DownloadCartImage` |  | 🟢 read |
| `/Portal/DownloadLogo` |  | 🟢 read |
| `/Portal/DownloadNoImage` |  | 🟢 read |
| `/Portal/RemoveCustomDomain` | DELETE | 🔴 write |
| `/Portal/ResetCartImage` | DELETE | 🔴 write |
| `/Portal/UploadCartImage` | POST | 🔴 write |
| `/Portal/UploadLogo` | POST | 🔴 write |
| `/Portal/UploadPageItemsImages` | POST | 🔴 write |
| `/api/B2B_BulkList` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/B2B_Index_AbandonedCarts` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/B2B_Index_B2BPriceListTemplates` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/B2B_Index_ChangePortalDomain` | POST | 🔴 write |
| `/api/B2B_Index_ChartOfAccounts` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/B2B_Index_EcsBulkList` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/B2B_Index_Family` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/B2B_Index_InvoiceTemplates` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/B2B_Index_Product` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/B2B_Index_TenantPriceTierNames` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/B2B_Index_vAddress` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/B2B_Index_vAttributeSetRow` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/B2B_Index_vBrands` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/B2B_Index_vCategories` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/B2B_Index_vContacts` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/B2B_Index_vCustomMenu` | GET POST | 🟠 read + write |
| `/api/B2B_Index_vEmailTemplates` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/B2B_Index_vInvitations` | POST PUT REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/B2B_Index_vInvitations/AccessType/Set` | POST | 🔴 write |
| `/api/B2B_Index_vLocation` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/B2B_Index_vNavbarItems` | POST REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/B2B_Index_vPageElements` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/B2B_Index_vPageElementsDetails` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/B2B_Index_vPages` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/B2B_Index_vPaymentMethods` | POST REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/B2B_Index_vPaymentMethods/Types` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/B2B_Index_vPriceList` | PUT REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/B2B_Index_vProductFamilies` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/B2B_Index_vProducts` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/B2B_Index_vRmaReturnLocation` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/B2B_Index_vSaleRepInvitation` | POST | 🔴 write |
| `/api/B2B_Index_vShippingMethods` | POST REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/B2B_Index_vShippingServices` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/B2B_Index_vSortingOptionTypes` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/B2B_Index_vSortingOptions` | POST REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/B2B_Index_vTags` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/B2B_Index_vTenantCarriers` | GET | 🟢 read |
| `/api/B2B_Index_vWebPortal` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/B2B_Overview_AbandonedCarts` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/B2B_Overview_Customers` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/B2B_Overview_SaleSummary` | POST | 🟢 read |
| `/api/B2B_Overview_Sales` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/B2B_Sales` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/CustomDomain` | GET | 🟢 read |
| `/api/CustomDomain/status` | GET | 🟢 read |
| `/api/Product_Index_Tags` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |

</details>

<details><summary><b>POS</b> · 69 endpoints (31 write)</summary>

| URL | Methods | Effect |
|---|---|---|
| `/DearPos/CustomerImport` | GET(navigate) | 🔴 write |
| `/DearPos/DeleteQuickKeyImage` | DELETE | 🔴 write |
| `/DearPos/DownloadQuickKeyImage` |  | 🟢 read |
| `/DearPos/GetImage` | POST | 🟢 read |
| `/DearPos/ListOrUpdateProduct` | POST | 🔴 write |
| `/DearPos/OutletLevelSKUImport` | GET(navigate) | 🔴 write |
| `/DearPos/RemoveProduct` | POST | 🔴 write |
| `/DearPos/ToggleAccess` | POST | 🔴 write |
| `/DearPos/UploadLogoImage` | POST | 🔴 write |
| `/MoneyTask/Receive` |  | 🟢 read |
| `/MoneyTask/Spend` |  | 🟢 read |
| `/MySubscription/DetailsUpdate` | GET | 🔴 write |
| `/UserImage/DownloadImage` |  | 🟢 read |
| `/UserImage/Upload` | POST | 🔴 write |
| `/api/DearPos_Index_AspnetRole` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/DearPos_Index_CashManagementReasons` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/DearPos_Index_Dashboard` | GET | 🟢 read |
| `/api/DearPos_Index_Dashboard_Settings` | GET | 🟢 read |
| `/api/DearPos_Index_Dashboard_Summary` | GET | 🟢 read |
| `/api/DearPos_Index_EcsBulkList` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/DearPos_Index_EcsBulkUnList` | POST | 🔴 write |
| `/api/DearPos_Index_Family` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/DearPos_Index_PosRoundingDenomination` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/DearPos_Index_PosRoundingRules` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/DearPos_Index_ReferenceData` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/DearPos_Index_Tags` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/DearPos_Index_vAccounts` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/DearPos_Index_vBanknoteDenominations` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/DearPos_Index_vBrands` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/DearPos_Index_vCCLP` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/DearPos_Index_vCashFloatAccounts` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/DearPos_Index_vCategory` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/DearPos_Index_vCategory2` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/DearPos_Index_vCustomer` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/DearPos_Index_vDearPosOverviewCustomersList` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/DearPos_Index_vDearPosOverviewSalesList` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/DearPos_Index_vDearPosPendingOrders` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/DearPos_Index_vECSPaymentsToExport` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/DearPos_Index_vEcsConfiguration` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/DearPos_Index_vEcsLogs` | DELETE REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/DearPos_Index_vEcsProduct` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/DearPos_Index_vEcsProductList` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/DearPos_Index_vEcsPurchaseLogs` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/DearPos_Index_vEcsStockAdjustmentLogs` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/DearPos_Index_vEcsStockTransferLogs` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/DearPos_Index_vExpenseAccounts` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/DearPos_Index_vLocation` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/DearPos_Index_vPaymentMethods` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/DearPos_Index_vPettyCashAccounts` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/DearPos_Index_vPosOutlets` | DELETE PUT REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/DearPos_Index_vPosOutletsSelect` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/DearPos_Index_vPosProduct` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/DearPos_Index_vPosQuickKey` | DELETE PUT REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/DearPos_Index_vPosRegisterCount` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/DearPos_Index_vReceiptTemplates` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/DearPos_Index_vRegistries` | DELETE PUT REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/DearPos_Index_vReportTemplates` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/DearPos_Index_vRevenueAccounts` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/DearPos_Index_vSalesPriceTiers` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/DearPos_Index_vSquareConfigs` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/DearPos_Index_vSupplier` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/DearPos_Index_vSurcharge` | POST REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/DearPos_Index_vTaxRules` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/DearPos_Index_vTillDiscrepancyAccounts` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/DearPos_Index_vTimezone` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/DearPos_Index_vUserManagement` | POST PUT REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/DearPos_Index_vZeroTax` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/TenantAccessToFeatures` | GET POST | 🟠 read + write |
| `/api/dearPos_Index_vUserImage` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |

</details>

<details><summary><b>QuickBooks</b> · 37 endpoints (24 write)</summary>

| URL | Methods | Effect |
|---|---|---|
| `/QuickBooks/ConnectWizardFinish` | POST | 🔴 write |
| `/Quickbooks/ConnectWizard` | GET(navigate) | 🔴 write |
| `/Quickbooks/ConsolidatedTransactionDetails` |  | 🟢 read |
| `/Quickbooks/ExportCOGS` | POST | 🟢 read |
| `/Quickbooks/ExportHistoricalData` | POST | 🟢 read |
| `/Quickbooks/GenerateSaleChannelList` | POST(read) | 🔴 write |
| `/Quickbooks/GetCustomersSuppliersCount` | GET | 🟢 read |
| `/Quickbooks/QuickbooksChartOfAccounts` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/Quickbooks/QuickbooksInventoryProductsCount` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/Quickbooks/QuickbooksPaymentTerms` | REST(GET read; POST/PUT/DELETE on store.sync) | 🔴 write |
| `/Quickbooks/QuickbooksTaxRules` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/Quickbooks/SetQuickbooksSyncModeDirectionBothWays` | POST | 🔴 write |
| `/Quickbooks/StartConnection` |  | 🔴 write |
| `/Quickbooks/VoidCOGS` | POST | 🔴 write |
| `/QuickbooksImportExport/Quickbooks` | GET(navigate) | 🔴 write |
| `/QuickbooksSynchronisation/GetLastSyncDate` | GET | 🟢 read |
| `/api/ChartOfAccounts_Index_vChartOfAccounts` | POST PUT REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/ChartOfAccounts_Index_vChartOfAccountsType` | POST | 🟢 read |
| `/api/ExternalEntityMapping_Index_vExternalEntityMapping` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/QuickBooks_CheckOverpayments` | POST | 🟢 read |
| `/api/QuickBooks_ImportOB` | POST | 🔴 write |
| `/api/QuickBooks_ImportSoH` | POST | 🔴 write |
| `/api/QuickBooks_Index_Integration` | POST | 🔴 write |
| `/api/QuickBooks_ReplaceProduct` | POST | 🔴 write |
| `/api/QuickBooks_StartOnboardingImport` | POST | 🔴 write |
| `/api/QuickBooks_StartSync` | POST | 🔴 write |
| `/api/QuickbooksSynchronisation_History` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/QuickbooksSynchronisation_History/BulkStatusUpdate` | POST | 🔴 write |
| `/api/Quickbooks_Customer` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/Quickbooks_HasConsolidatedTranscations` | GET | 🟢 read |
| `/api/Quickbooks_Index_ConsolidatedTranscations` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Quickbooks_Index_JournalsReconciliation` | GET POST | 🟠 read + write |
| `/api/Quickbooks_Index_vMailingList` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/Quickbooks_Location` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Quickbooks_StartSync` | POST | 🔴 write |
| `/api/TenantPaymentTerm_Index_vTenantPaymentTerm` | DELETE REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/TenantTaxationRule_Index_vTenantTaxationRule` | POST PUT REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |

</details>

<details><summary><b>RMA Portal</b> · 12 endpoints (11 write)</summary>

| URL | Methods | Effect |
|---|---|---|
| `/RmaPortal/AddDomain` | POST | 🔴 write |
| `/RmaPortal/AuthorisePost` | POST | 🔴 write |
| `/RmaPortal/RemoveCustomDomain` | DELETE | 🔴 write |
| `/api/RmaPortal_Index_B2BPortalAppearance` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/RmaPortal_Index_ChangePortalDomain` | POST | 🔴 write |
| `/api/RmaPortal_Index_vAddress` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/RmaPortal_Index_vContacts` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/RmaPortal_Index_vEmailTemplates` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/RmaPortal_Index_vNavbarItems` | POST | 🔴 write |
| `/api/RmaPortal_Index_vPages` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/RmaPortal_Index_vSortingOptions` | POST | 🔴 write |
| `/api/RmaPortal_Index_vWebPortal` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |

</details>

<details><summary><b>Shippit</b> · 2 endpoints (1 write)</summary>

| URL | Methods | Effect |
|---|---|---|
| `/api/Shippit_Index_vShipServConf` | PUT REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/Shippit_Index_vTaxRules` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |

</details>

<details><summary><b>ShipRush</b> · 2 endpoints (1 write)</summary>

| URL | Methods | Effect |
|---|---|---|
| `/api/Sale_Index_LookupCarrier` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/ShipRush_Index_vShipServConf` | GET(read) PUT REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |

</details>

<details><summary><b>ShipStation</b> · 34 endpoints (16 write)</summary>

| URL | Methods | Effect |
|---|---|---|
| `/ShipStation/ConfigurationNG` |  | 🟢 read |
| `/Shipstation/ChangeMappingAndSyncStock` | POST | 🔴 write |
| `/api/Currency` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/ShipStation_Index_vAccounts` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/ShipStation_Index_vCustomIntegration` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/ShipStation_Index_vCustomer` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/ShipStation_Index_vEcsConfiguration` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/ShipStation_Index_vEcsLogs` | DELETE REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/ShipStation_Index_vEcsPaymentProcessorMapping` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/ShipStation_Index_vEcsTaxMapping` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/ShipStation_Index_vLocation` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/ShipStation_Index_vRevenueAccounts` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/ShipStation_Index_vSalesPriceTiers` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/ShipStation_Index_vShipServConf` | PUT REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/ShipStation_Index_vTaxRules` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/ShipStation_Index_vZeroTax` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/Shipstation_Ext_CarrierPackage` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Shipstation_Index_CheckProduct` | GET PUT | 🟠 read + write |
| `/api/Shipstation_Index_Dashboard_Summary` | GET | 🟢 read |
| `/api/Shipstation_Index_Product` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Shipstation_Index_vEcsLocationMapping` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/Shipstation_Index_vEcsProductList` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/Shipstation_Index_vEcsUSTaxTypeAhead` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Shipstation_Index_vMailingList` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Shipstation_Index_vOperationLogs` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/Shipstation_Index_vShipIntegrationLocationMapping` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/Shipstation_Index_vShipStationExportOrdersFilterParameter` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Shipstation_Index_vShipstationNotMatchingAddresses` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/Shipstation_Index_vShipstationOverviewCustomersList` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Shipstation_Index_vShipstationOverviewSalesList` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Shipstation_Index_vShipstationPendingOrders` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Shipstation_Index_vStore` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Shipstation_Index_vTax` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/Shipstation_Index_vTenantAddress` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |

</details>

<details><summary><b>Shiptheory</b> · 11 endpoints (4 write)</summary>

| URL | Methods | Effect |
|---|---|---|
| `/Product/ExportCommodityDetails` | GET(navigate) | 🟢 read |
| `/Product/ImportProductCommodityDetails` | GET(navigate) | 🔴 write |
| `/Product/ImportProductCommodityDetailsJson` | POST | 🔴 write |
| `/api/Product_ImportCommodityDetails_Exceptions` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/Shipping_Index_Family` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Shipping_Index_vBrands` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Shipping_Index_vCategories` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Shipping_Index_vTags` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Shipping_ProductCatalogueList` | POST REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Shiptheory_Index_vMailingList` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Shiptheory_Index_vShipServConf` | PUT REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |

</details>

<details><summary><b>Shopify</b> · 32 endpoints (10 write)</summary>

| URL | Methods | Effect |
|---|---|---|
| `/Report/DeleteLayout` | DELETE | 🔴 write |
| `/Report/DeleteLayoutNew` |  | 🔴 write |
| `/Shopify/GetFeatureFlags` | GET | 🟢 read |
| `/api/Report_v` |  | 🟢 read |
| `/api/Report_vReportLayout` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/Shopify_Chart_Sales` | GET | 🟢 read |
| `/api/Shopify_Index_BulkList` | DELETE PUT REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/Shopify_Index_Dashboard_Summary` | GET | 🟢 read |
| `/api/Shopify_Index_Family` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Shopify_Index_LocationMapping` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/Shopify_Index_LocationMapping_Locations` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Shopify_Index_Locations` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Shopify_Index_Tags` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Shopify_Index_vAccounts` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Shopify_Index_vCategory` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Shopify_Index_vCustomer` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Shopify_Index_vLiabilityAccounts` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Shopify_Index_vMasterDataSource` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Shopify_Index_vRetailDeliveryFeeAccounts` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Shopify_Index_vRevenueAccounts` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Shopify_Index_vSaleAttributes` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Shopify_Index_vSalesPriceTiers` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Shopify_Index_vShopifyCatalog` | GET | 🟢 read |
| `/api/Shopify_Index_vShopifyCatalogList` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Shopify_Index_vShopifyConfiguration` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/Shopify_Index_vShopifyLogs` | DELETE REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/Shopify_Index_vShopifyOperationLogs` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/Shopify_Index_vShopifyPaymentProcessorMapping` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/Shopify_Index_vShopifyPendingOrders` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Shopify_Index_vShopifyTaxMapping` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/Shopify_Index_vTaxRules` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/USState` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |

</details>

<details><summary><b>Square</b> · 27 endpoints (11 write)</summary>

| URL | Methods | Effect |
|---|---|---|
| `/Square/AddPaymentsShop` |  | 🔴 write |
| `/Square/ListOrUpdateProduct` | POST | 🔴 write |
| `/Square/Main` |  | 🟢 read |
| `/Square/RemoveProduct` | POST | 🔴 write |
| `/Square/SaveEcsProductLocally` | POST | 🔴 write |
| `/api/Square_Index_Dashboard_Summary` | GET | 🟢 read |
| `/api/Square_Index_EcsBulkList` | DELETE REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/Square_Index_Family` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Square_Index_Tags` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Square_Index_vAccounts` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Square_Index_vCategory` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Square_Index_vCustomer` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Square_Index_vEcsConfiguration` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/Square_Index_vEcsLogs` | DELETE REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/Square_Index_vEcsPaymentProcessorMapping` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/Square_Index_vEcsProduct` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Square_Index_vEcsProductList` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/Square_Index_vEcsTaxMapping` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/Square_Index_vLiabilityAccounts` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Square_Index_vLocation` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Square_Index_vOperationLogs` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/Square_Index_vRevenueAccounts` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Square_Index_vSalesPriceTiers` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Square_Index_vSquareOverviewCustomersList` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Square_Index_vSquareOverviewSalesList` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Square_Index_vSquarePendingOrders` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Square_Index_vTaxRules` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |

</details>

<details><summary><b>StarShipIT</b> · 2 endpoints (1 write)</summary>

| URL | Methods | Effect |
|---|---|---|
| `/api/StarShipIt_Index_vShipServConf` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/StarShipIt_Index_vTaxRules` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |

</details>

<details><summary><b>Walmart</b> · 22 endpoints (8 write)</summary>

| URL | Methods | Effect |
|---|---|---|
| `/Walmart/ChangeMappingAndSyncStock` | POST | 🔴 write |
| `/api/Walmart_Index_AcknowledgeOrders` | POST | 🔴 write |
| `/api/Walmart_Index_CheckProduct` | GET PUT | 🟠 read + write |
| `/api/Walmart_Index_Dashboard_Summary` | GET | 🟢 read |
| `/api/Walmart_Index_Product` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Walmart_Index_vAccounts` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Walmart_Index_vBankAccounts` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Walmart_Index_vCustomer` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Walmart_Index_vEcsConfiguration` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/Walmart_Index_vEcsLogs` | DELETE REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/Walmart_Index_vEcsPaymentProcessorMapping` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/Walmart_Index_vEcsProductList` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Walmart_Index_vEcsTaxMapping` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/Walmart_Index_vLocation` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Walmart_Index_vLocationExt` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Walmart_Index_vOperLog` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/Walmart_Index_vPendingOrders` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Walmart_Index_vRevenueAccounts` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Walmart_Index_vSalesPriceTiers` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Walmart_Index_vTaxRules` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Walmart_Index_vWalmartOverviewCustomersList` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Walmart_Index_vWalmartOverviewSalesList` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |

</details>

<details><summary><b>WooCommerce</b> · 24 endpoints (10 write)</summary>

| URL | Methods | Effect |
|---|---|---|
| `/WooCommerce/ListOrUpdateProduct` | POST | 🔴 write |
| `/WooCommerce/RemoveProduct` | POST | 🔴 write |
| `/WooCommerce/SaveEcsProductLocally` | POST | 🔴 write |
| `/api/WooCommerce_Index_Dashboard_Summary` | GET | 🟢 read |
| `/api/WooCommerce_Index_EcsBulkList` | DELETE REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/WooCommerce_Index_Family` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/WooCommerce_Index_Tags` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/WooCommerce_Index_vAccounts` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/WooCommerce_Index_vCategory` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/WooCommerce_Index_vCustomer` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/WooCommerce_Index_vEcsConfiguration` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/WooCommerce_Index_vEcsLogs` | DELETE REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/WooCommerce_Index_vEcsPaymentProcessorMapping` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/WooCommerce_Index_vEcsProduct` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/WooCommerce_Index_vEcsProductList` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/WooCommerce_Index_vEcsTaxMapping` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/WooCommerce_Index_vLocation` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/WooCommerce_Index_vOperationLogs` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟠 read + write |
| `/api/WooCommerce_Index_vPendingOrders` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/WooCommerce_Index_vRevenueAccounts` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/WooCommerce_Index_vSalesPriceTiers` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/WooCommerce_Index_vTaxRules` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/WooCommerce_Index_vWooCommerceOverviewCustomersList` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/WooCommerce_Index_vWooCommerceOverviewSalesList` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |

</details>

<details><summary><b>Xero</b> · 9 endpoints (5 write)</summary>

| URL | Methods | Effect |
|---|---|---|
| `/XEROImportExport/WizardConnectToXero` | GET(navigate) | 🔴 write |
| `/Xero/ConnectWizardFinish` | POST | 🔴 write |
| `/Xero/CreateXeroAccount` | POST | 🔴 write |
| `/Xero/GetCustomersSuppliersCount` | GET | 🟢 read |
| `/Xero/XeroChartOfAccounts` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/Xero/XeroTaxRules` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/AccountMapping_Index_vAccountMapping` | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |
| `/api/Xero_StartOnboardingImport` | POST | 🔴 write |
| `/api/Xero_StartSync` | POST | 🔴 write |

</details>

## How to rebuild it

| # | Build | How |
|:-:|---|---|
| 1 | 🗄️ Schema | 1 tables from [`schema.sql`](schema.sql); GUID ids, join on `*ID` |
| 2 | 🖥️ Screens | Server-rendered shell + page app, record from `#<guid>` · [page model](../../docs/ARCHITECTURE.md#what-a-page-is) · every control in [UI.md](UI.md) |

## Pages

| Route | Menu label | Title | Bundle | Endpoints (write) |
|---|---|---|---|---:|
| `/Integrations` | Integration | Integrations | `IntegrationList2019` | 1 (0) |

## Data models

ExtJS models the pages use; `v` prefix = view-model. Full DDL in [`schema.sql`](schema.sql).

| Model | Fields |
|---|---|
| `IntegrationModel` | ShopType:string |
