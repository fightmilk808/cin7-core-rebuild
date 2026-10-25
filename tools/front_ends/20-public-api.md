# Public API and webhooks

The documented integration surface: `https://inventory.dearsystems.com/ExternalApi/v2` (a few resources only on v1,
`/ExternalApi/<Resource>`). Cin7 publishes it as an API Blueprint
([dearinventory.apib](https://jsapi.apiary.io/apis/dearinventory.apib), docs at
[dearinventory.docs.apiary.io](https://dearinventory.docs.apiary.io/)). 295 operations on 115 paths in 32 groups:
102 GET, 83 POST, 65 PUT, 45 DELETE. Each module folder lists its own operations; the full contract is in
[`docs/PUBLIC-API.md`](../../docs/PUBLIC-API.md).

## How to rebuild it

1. **Auth.** Issue API applications per tenant: an account id plus an application key. Every request carries
   `api-auth-accountid` and `api-auth-applicationkey`. JSON only.
2. **Rate limit.** 60 calls a minute per API application; answer 429 above it.
3. **Lists.** `GET /<resource>List` (or the resource with `Page`/`Limit`) returns `{Total, Page, <ArrayKey>: [...]}`.
   List rows are summaries; details come from `GET /<resource>?ID=`.
4. **Incremental reads.** `ModifiedSince` on master data (product, customer, supplier, product family), `UpdatedSince` on
   sale and purchase lists. Unknown query parameters are ignored, not rejected.
5. **Nested arrays on demand.** `/product` returns BOM, suppliers, reorder levels, movements, attachments and custom prices
   only when the matching `Include*` flag is set.
6. **Errors.** Unknown path: 302 to `/Error/NotFound`. Missing record: 400 with `[{"ErrorCode", "Exception"}]`.
7. **Writes.** POST creates, PUT updates (full-object replace on `/product`), DELETE takes `ID`.
8. **Webhooks.** `GET/POST/PUT/DELETE /webhooks` manages subscriptions; Cin7 POSTs JSON to the subscriber's URL.

## Webhook events (31 in the spec, 32 accepted)

| Object | Events |
|---|---|
| Sale | Created, OrderAuthorised, QuoteAuthorised, Backordered, PickAuthorised, PackAuthorised, ShipmentAuthorised, ShipmentTrackingNumberChanged, InvoiceAuthorised, PartialPaymentReceived, FullPaymentReceived, CreditNoteAuthorised, Voided, Undo, AttachmentAdded, AdditionalAttributesChanged |
| Purchase | OrderAuthorised, StockReceivedAuthorised, InvoiceAuthorised, CreditNoteAuthorised, Updated |
| Product / Customer / Supplier | Updated |
| Stock | AvailableStockLevelChanged (body is a bare array of `{ID, SKU, Location, OnHand, Allocated, Available, OnOrder}`) |
| Lead | Updated, Converted |
| Opportunity | Authorized, Converted, Voided, AttachmentAdded |

Events fire on status transitions only. There are none for production orders, assemblies, transfers, adjustments or
stocktakes. Sale and purchase payloads carry a `DownloadLink` to the rendered PDF.

## Fields, parameters and body shapes

One page per group in [`groups/`](groups/): field tables with types, lengths, required flags and allowed values; each
operation's parameters; request and response bodies as type outlines. Shared models and status lists:
[`groups/models.md`](groups/models.md). Every webhook body: [`groups/webhooks.md`](groups/webhooks.md).
