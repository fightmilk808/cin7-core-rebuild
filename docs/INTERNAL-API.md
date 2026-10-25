# Internal API contract

The web app's own endpoints, used only by a signed-in browser (session cookie). 1,633 JSON endpoints under `/api/` and 544
controller actions. Every module folder lists its endpoints with methods, parameters, body keys and reader root.

## Naming

- `/api/<Controller>_<View>_<Thing>`, e.g. `/api/ProductionOrder_Index_vProductionOrder`. `View` is almost always `Index`.
- A `v` prefix on `Thing` marks a view-model (`vSupplyRule`, `vTenantLocation`).
- Cross-page endpoints may have no controller (`/api/vSaleListFulfilment`, `/api/access`, `/api/settings_all_permissions`).
- Controller actions are `/<Controller>/<Action>`: `Void`, `Undo`, `Cancel`, `Print`, `Upload`, `Download…`, `Export…`,
  `Import…Json`, `CountrySpecific`.

## One URL, four verbs

An ExtJS `rest` store loads with `GET`, creates with `POST`, saves with `PUT /<id>` and deletes with `DELETE /<id>`, all on
the same URL. So the URL that reads a thing usually saves it too. Whether a page saves through a store shows in its code
(`store.sync()`, a `writer` config); the endpoint tables mark these 🟠 read + write.

## Reads

- Grid stores page: they send `_dc=<ms>`, `page`, `start`, `limit` and read `{<root>: [...], total}`. Some refuse with 405
  when `page`/`start` are missing.
- Some reads are `POST` with a JSON query body (the scheduler's `/api/Scheduler_Index_vProductionOrders`, MRP suggestion
  lines, several search grids). The verb alone doesn't say read or write.
- Dates in query strings use `dd.MM.yyyy` on dashboard and report endpoints.
- A missing GET action answers 405 or 404 (Web API's "no action matches these arguments"); a removed controller answers
  "No type was found that matches the controller".

## Saves

- Detail pages save `{ID, HasErrors, Original, Updated}` (the record before and after the edit) to the same `v<Thing>` URL.
- Heavy calls (scheduler, release, bulk actions) carry client timeouts up to 2 hours, so the server computes on each call.

## Documents and files

- Prints and downloads are form POSTs that return a file, not XHR.
- Sale and purchase documents also have signed links that work without a session
  (`/Sale/DownloadPickList?tenantID=&saleTaskID=&templateID=&timeStamp=`).
- Uploads go to `/<Controller>/Upload` (attachments) or `Import…Json` (bulk imports).

## How to rebuild it

For each module: one controller per screen, one REST resource per store with the four verbs, paged list reads in the
`{root, total}` shape, the `{ID, HasErrors, Original, Updated}` save wrapper on detail records, and controller actions for
document operations and files. Keep the names: the page scripts are wired to them.

## Page access (permissions)

A user's access is checked per page by a permission key named `<Controller>_<View>` (the same prefix the internal API uses). `GET /api/settings_all_permissions` returns, for the Reference Books menu, each key with its page and whether the user may open it (`{Prefix, Allowed, Link, Hidden}`); `/api/access` and `/api/PageAccess_*` cover the rest (roles, users, effective permissions). The Reference Books keys:

| Permission key | Page |
|---|---|
| `TenantAddress_Index` | `/TenantAddress` |
| `TenantCarrier_Index` | `/TenantCarrier` |
| `TenantContact_Index` | `/TenantContact` |
| `TenantInventoryCategory_Index` | `/TenantInventoryCategory` |
| `TenantBrand_Index` | `/TenantBrand` |
| `TenantLocation_Index` | `/TenantLocation` |
| `TenantPaymentTerm_Index` | `/TenantPaymentTerm` |
| `TenantTaxationRule_Index` | `/TenantTaxationRule` |
| `TenantUnitOfMeasure_Index` | `/TenantUnitOfMeasure` |
| `TenantAttributeSet_Index` | `/TenantAttributeSet` |
| `TenantShipZone_Index` | `/TenantShipZone` |
| `ChartOfAccounts_Index` | `/ChartOfAccounts` |
| `AccountMapping_Index` | `/AccountMapping` |
| `Bank_Index` | `/BankAccounts` |
| `Discount_Index` | `/DiscountListNew` |
| `FixedAsset_Index` | `/FixedAssetType` |
| `ExpenseItems_Index` | `/ExpenseItems` |
| `OpeningBalances_Index` | `/OpeningBalances` |
| `Deal_Index` | `/DealList` |
| `OrderRouting_Index` | `/OrderRouting` |
| `DearToDearNetworking_Index` | `/DearToDearNetworking` |
| `WarrantySetup_Index`, `RMAWarrantySetup_Index` | `/WarrantySetupList` |
| `RMAReturnPolicy_Index` | `/RMAReturnPolicy` |
| `RMAReasonForReturn_Index` | `/RMAReasonForReturn` |
| `RMAReturnOrderSettings_Index` | `/RMAReturnOrderSettings` |
| `DefaultFieldValues_Product` / `_Customer` / `_Supplier` | `/DefaultFieldValues/Product` / `Customer` / `Supplier` |
| `MailingList_Index` | `/NotificationSettings/MailingList` |
| `LeadStatus_Index` | `/LeadStatus` |
| `AccountingDimensions_Settings` | `/AccountingDimensions` |
