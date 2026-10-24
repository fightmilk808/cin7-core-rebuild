# Integrations

The integrations catalogue (`/Integrations`) and one subfolder per connector: its settings page, mappings, sync logs and endpoints.

| | Count |
|---|---:|
| Pages | 1 |
| Data models | 1 (plus [shared](../00-shared/README.md)) |
| Internal endpoints | 0 (0 write) |
| Public API operations | 0 |

## Integrations

| Integration | Page | Endpoints | Data models |
|---|---|---:|---:|
| [Shared integration endpoints](_common/README.md) |  | 1 | 0 |
| [Airwallex](airwallex/README.md) | `/Airwallex` | 0 | 0 |
| [Amazon](amazon/README.md) | `/Amazon` | 44 | 29 |
| [AuthorizeNet](authorizenet/README.md) | `/AuthorizeNet` | 11 | 2 |
| [Avalara](avalara/README.md) | `/Avalara` | 13 | 8 |
| [BigCommerce](bigcommerce/README.md) | `/Bigcommerce` | 24 | 17 |
| [Capsule](capsule/README.md) | `/Capsule` | 9 | 7 |
| [Cin7 Core API setup](cin7-core-api-setup/README.md) | `/ExternalApi` | 6 | 4 |
| [Cin7 Core Payments](cin7-core-payments/README.md) | `/PaymentGateway` | 20 | 9 |
| [EasyPost](easypost/README.md) | `/EasyPost` | 1 | 5 |
| [eBay](ebay/README.md) | `/eBayNG` | 34 | 31 |
| [Etsy](etsy/README.md) | `/Etsy` | 27 | 27 |
| [Faire](faire/README.md) | `/Faire` | 27 | 21 |
| [Fulfillment by Amazon](fulfillment-by-amazon/README.md) | `/FBA` | 22 | 25 |
| [Google Workspaces](google-workspaces/README.md) | `/GSuites` | 3 | 3 |
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
| [QuickBooks](quickbooks/README.md) | `/Quickbooks` | 26 | 11 |
| [RMA Portal](rma-portal/README.md) | `/RmaPortal` | 12 | 6 |
| [Shippit](shippit/README.md) | `/Shippit` | 2 | 6 |
| [ShipRush](shiprush/README.md) | `/ShipRush` | 2 | 8 |
| [ShipStation](shipstation/README.md) | `/ShipStation/ConfigurationNG` | 34 | 37 |
| [Shiptheory](shiptheory/README.md) | `/Shiptheory` | 11 | 12 |
| [Shopify](shopify/README.md) | `/Shopify` | 32 | 22 |
| [Square](square/README.md) | `/Square/Main` | 25 | 19 |
| [StarShipIT](starshipit/README.md) | `/StarShipIt` | 2 | 9 |
| [Synder](synder/README.md) | `/Synder` | 0 | 0 |
| [Walmart](walmart/README.md) | `/Walmart` | 22 | 19 |
| [Warehouse application configuration](warehouse-application-configuration/README.md) | `/WarehouseApp` | 0 | 2 |
| [WooCommerce](woocommerce/README.md) | `/WooCommerce` | 24 | 18 |
| [Xero](xero/README.md) | `/Xero` | 7 | 5 |
| [Zapier](zapier/README.md) | `/Zapier` | 0 | 0 |

## How to rebuild it

1. **Schema.** Create one table per data model below (1), starting from the generated [`schema.sql`](schema.sql). Ids are GUIDs; join on the `*ID` fields.
2. **Screens.** Build each route below as a server-rendered shell that loads the shell bundle and the page's own app, opening a record from `#<guid>` once at load ([page model](../../docs/ARCHITECTURE.md#what-a-page-is)). Every grid, column, field, button and dialog is in [UI.md](UI.md).

## Pages

| Route | Menu label | Title | Bundle | Endpoints (write) |
|---|---|---|---|---:|
| `/Integrations` | Integration | Integrations | `IntegrationList2019` | 1 (0) |

## Data models

ExtJS models the pages use; `v` prefix = view-model. Full DDL in [`schema.sql`](schema.sql).

| Model | Fields |
|---|---|
| `IntegrationModel` | ShopType:string |
