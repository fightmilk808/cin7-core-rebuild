# Public API contract

`https://inventory.dearsystems.com/ExternalApi/v2` (some resources only on v1 at `/ExternalApi/<Resource>`). Spec:
[dearinventory.apib](https://jsapi.apiary.io/apis/dearinventory.apib). Every operation, per module, is in the module folders
and in [`data/public-api.csv`](../data/public-api.csv); webhooks are in [module 20](../modules/20-public-api/README.md).

## Transport

- Headers `api-auth-accountid` and `api-auth-applicationkey` on every request. JSON only.
- 60 calls a minute per API application; 429 above it, sometimes with `Retry-After`. No rate-limit headers.
- Dates as `yyyy-MM-ddTHH:mm:ss.fff` UTC. Pure-date fields (`OrderDate`, `ShipDate`) come back as UTC midnight.
- `GET /me` returns company, base currency, timezone, lock date and tax method.

## Errors

| Case | Answer |
|---|---|
| Wrong path or casing | 302 to `/Error/NotFound` |
| Bad or revoked key | 403 |
| Missing or deleted record on a detail GET | 400, `[{"ErrorCode":400,"Exception":"... not found ..."}]` |
| Immutable field on update (e.g. `CreatedDate` on `PUT /product`) | 400 carrying `ErrorCode` 409 |
| Deprecated endpoint (`GET /purchase`) | 400 naming the replacement |
| Over the rate limit | 429 |

## Lists and details

- Lists return `{Total, Page, <ArrayKey>: [...]}`, paged by `Page` and `Limit` (default 100). No stable sort.
- List rows are summaries; lines, components and payments need one detail call per record. Some header fields exist only
  on the list row.
- Incremental parameters differ: `ModifiedSince` on `/product`, `/supplier`, `/customer`, `/productFamily`; `UpdatedSince` on
  `/saleList`, `/saleCreditNoteList`, `/purchaseList`, `/purchaseCreditNoteList`; none on transfer, adjustment, assembly and
  production order lists. An unknown parameter is ignored and the full set returned.
- `/product` and `/supplier` default `IncludeDeprecated=false`.
- Credit-note lists take `CreditNoteStatus`.

## `Include*` flags on `/product`

| Flag | Fills |
|---|---|
| `IncludeBOM` | `BillOfMaterialsProducts[]`, `BillOfMaterialsServices[]` |
| `IncludeSuppliers` | `Suppliers[]` with `ProductSupplierOptions[]` |
| `IncludeReorderLevels` | `ReorderLevels[]` per location |
| `IncludeMovements` | `Movements[]` |
| `IncludeAttachments` | `Attachments[]` |
| `IncludeCustomPrices` | `CustomPrices[]` |

Customer has `IncludeProductPrices`; production BOMs and orders take `ReturnAttachmentsContent` / `IncludeAttachmentContent`.

## Shapes worth matching

- Production BOM envelope `ProductionBoms`; ids `BomID`, `BomComponentID`; a BOM has `Version`, `IsDefault`,
  `OutputQuantity`, `Operations[] → Components[]` and `Resources[]`.
- `/production/orderList` returns orders and runs together, `Type` `O` or `R`.
- `/stockTakeList` answers in `StockAdjustmentList`; credit-note lists reuse `SaleList` / `PurchaseList`; work centres come
  back as `Workcenters`.
- Attachments: product and product-family paths are plural, purchase and sale singular.
- Advanced purchase detail (`/advanced-purchase?ID=`) carries `Invoice[]` (with `Lines`, `AdditionalCharges`, `Payments`),
  `StockReceived`, `PutAway`, `InventoryMovements`, `ManualJournals`, `CreditNote`. Its stock sub-resource takes `PurchaseID`.
- Sale detail carries `Fulfilments[]` with `Pick`, `Pack` and `Ship`, each `{Lines, Status}`.
- `PUT /product` is a full-object replace; a new `ReorderLevels` element must be sent in full.
- Stocktake line `Adjustment` is the new absolute quantity.
