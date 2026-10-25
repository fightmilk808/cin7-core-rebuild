# Xero

The Xero connector: its settings page, mappings, logs and the endpoints behind them. Part of [Integrations](../README.md).

| | Count |
|---|---:|
| Pages | 1 |
| Data models | 5 (plus [shared](../../00-shared/README.md)) |
| Internal endpoints | 9 (5 write) |
| Public API operations | 0 |

## How to rebuild it

1. **Schema.** Create one table per data model below (5), starting from the generated [`schema.sql`](schema.sql). Ids are GUIDs; join on the `*ID` fields.
2. **Internal API.** Implement each controller's endpoints with the verbs listed, following the [internal API contract](../../../docs/INTERNAL-API.md): one URL per store for GET/POST/PUT/DELETE, paged reads returning `{root, total}`, saves wrapped as `{ID, HasErrors, Original, Updated}`.
3. **Screens.** Build each route below as a server-rendered shell that loads the shell bundle and the page's own app, opening a record from `#<guid>` once at load ([page model](../../../docs/ARCHITECTURE.md#what-a-page-is)). Every grid, column, field, button and dialog is in [UI.md](UI.md).

## Pages

| Route | Menu label | Title | Bundle | Endpoints (write) |
|---|---|---|---|---:|
| `/Xero` |  | Xero | `Xero2019` | 5 (6) |

## Data models

ExtJS models the pages use; `v` prefix = view-model. Full DDL in [`schema.sql`](schema.sql).

| Model | Fields |
|---|---|
| `AccountsMapping` | InventoryControlAccount:string, CostOfGoodsSoldAccount:string, DefaultRevenueAccount:string, TaxLiabilityAccount:string, PurchasePrepayment:string, SalePrepayment:string, InventoryAccrualAccount:string, StockInTransitAccount:string, InventoryDiscrepancyAccount:string, GiftCardAccount:string, WipAccount:string, TransferInTransitAccount:string, CurrentYearProfitsAccount:string, UnrealisedCurrencyGainAccount:string, RealisedCurrencyGainAccount:string, PaymentClearingAccount:string |
| `ExternalEntityMapping` | ID:string, ExternalCode:string, ExternalName:string, EntityCode:string, EntityType:string |
| `ExternalEntityMappingTaxRule` | ID:string, ExternalCode:string, ExternalName:string, EntityCode:string, EntityType:string, TaxRuleIsActive:bool, TaxRuleIsPurchase:bool, TaxRuleIsSale:bool, TaxRulePercent:float, TaxRuleName:string |
| `XeroAccounts` | Code:string, DisplayName:string, Class:string, Type:string, SystemAccount:string, EnablePaymentsToAccount:bool, IsFirst:bool |
| `XeroTaxationRule` | TaxType:string, Name:string, EffectiveRate:float, IsPurchaseTaxRule:bool, IsSaleTaxRule:bool |

## Internal endpoints

Grouped by controller. Effect: 🟢 read · 🟠 read + write at the same URL · 🔴 write. `api` = JSON under `/api/`, `mvc` = controller action.

### AccountMapping

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/api/AccountMapping_Index_vAccountMapping` | api | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |

### Xero

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/Xero/ConnectWizardFinish` | mvc | POST | 🔴 write |  |  |  |
| `/Xero/CreateXeroAccount` | mvc | POST | 🔴 write |  |  |  |
| `/Xero/GetCustomersSuppliersCount` | mvc | GET | 🟢 read |  |  |  |
| `/Xero/XeroChartOfAccounts` | mvc | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/Xero/XeroTaxRules` | mvc | REST(GET read; POST/PUT/DELETE on store.sync) | 🟢 read |  |  |  |
| `/api/Xero_StartOnboardingImport` | api | POST | 🔴 write |  |  |  |
| `/api/Xero_StartSync` | api | POST | 🔴 write |  |  |  |

### XEROImportExport

| URL | Kind | Methods | Effect | Params | Body keys | Reader root |
|---|---|---|---|---|---|---|
| `/XEROImportExport/WizardConnectToXero` | mvc | GET(navigate) | 🔴 write |  |  |  |
