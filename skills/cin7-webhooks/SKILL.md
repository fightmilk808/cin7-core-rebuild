---
name: cin7-webhooks
description: Set up a receiver for Cin7 Core (DEAR Inventory) webhooks - pick the event, see the exact payload shape the map recorded, write a small handler, test it with a sample body, and draft the public API call that registers the webhook. Use when someone wants Cin7 to push events (a sale authorised, stock changed, a product updated) to their own URL, asks "which webhook fires when X", or needs a payload field list. Drafts the registration call only; a person sends it.
---

# Cin7 webhooks

The map records every webhook type, its body shape and the `/webhooks` subscription calls. Look things up there; do not guess.

| Need | Where |
|---|---|
| Event list and what does not exist | [module 20 README](../../modules/20-public-api/README.md#webhook-events-31-in-the-spec-32-accepted) |
| Body of each event | [`groups/webhooks.md`](../../modules/20-public-api/groups/webhooks.md), same data in `data/public-api-shapes.json` under `webhooks` |
| Subscription fields | `groups.Webhooks` in the same JSON; `Webhooks` rows in [`data/public-api.csv`](../../data/public-api.csv) |
| Auth and rate limit for the API call | [`docs/PUBLIC-API.md`](../../docs/PUBLIC-API.md) |

## Pick the event

```bash
python3 -c "import json;d=json.load(open('data/public-api-shapes.json'))['webhooks'];print(*d,sep='\n')"
python3 -c "import json,sys;d=json.load(open('data/public-api-shapes.json'))['webhooks'];print(json.dumps(d[sys.argv[1]],indent=1))" Sale/OrderAuthorised
```

- Events fire on status changes only. The map lists none for production orders, assemblies, transfers, adjustments or stocktakes. If the person needs one of those, say so and suggest polling the matching list endpoint with its `UpdatedSince`/`ModifiedSince` parameter, if the map shows it has one.
- Shapes differ. Some events carry the sale as `SaleID` + `SaleOrderNumber`, others as `SaleTaskID` + `OrderNumber`. A few (`Sale/ShipmentAuthorised`, `Sale/AttachmentAdded`, `Opportunity/AttachmentAdded`) are recorded as key lists only, with no types. `Stock/AvailableStockLevelChanged` and `Task/Overdue` arrive as a bare JSON array. Read the recorded shape for the exact event; do not reuse another event's handler.
- Every other body has an `EventType` string. Route on it, not on the URL.
- The webhook is a notification, often with few fields. Fetch the full record with the public API (for example `GET /sale?ID=<SaleID>`) when you need lines or totals.

## Registering (a write to Cin7)

`POST /webhooks` with `Type` (one of the event names), `IsActive`, `ExternalURL`, `ExternalAuthorizationType` (`noauth`, `basicauth` or `bearerauth`), the matching `ExternalUserName`/`ExternalPassword` or `ExternalBearerToken`, and optional `ExternalHeaders` as `[{"Key","Value"}]`. `GET /webhooks` lists, `PUT /webhooks` updates (send `ID`), `DELETE /webhooks?ID=` removes. Draft the exact call from the recorded request shape, with placeholder credentials, and hand it to a person. With the `cin7` CLI a write needs `--allow-write` and a person at a terminal; never try to get around that.

## Sample handler

```python
from flask import Flask, request
app = Flask(__name__)

@app.post("/cin7")
def cin7():
    body = request.get_json(force=True)
    events = body if isinstance(body, list) else [body]   # stock and task events are bare arrays
    for e in events:
        kind = e.get("EventType") if isinstance(e, dict) else None
        print("got", kind, e)                              # replace with a queue write
    return "", 200                                         # answer fast; do real work later
```

## Test it

Build a body from the recorded shape with invented values, then post it to your own URL:

```bash
curl -s -X POST localhost:5000/cin7 -H 'content-type: application/json' \
  -d '{"SaleID":"00000000-0000-0000-0000-000000000001","SaleOrderNumber":"SO-0001","EventType":"Sale/OrderAuthorised"}'
```

Check the auth path too: with `bearerauth`, make the handler reject a request without the token.

## Rules

1. Answer 2xx quickly. The map records the delivery rule: up to 6 attempts (1, then 5, 10, 15, 20, 25 minutes apart), then the webhook is deactivated; at most 5 webhooks of one type.
2. Be idempotent. Retries mean the same event can arrive twice; key on the record id plus `EventType`.
3. The map does not record request signing or a verification header. Do not invent one. Protect the endpoint with the auth type and `ExternalHeaders` above, and check Cin7's published docs for anything more.
4. Use HTTPS, and keep tokens in the environment, never in the repo.
5. Never register, change or delete a webhook yourself.

## When it fails

| Symptom | Likely cause |
|---|---|
| Events stopped for good | Six failed deliveries deactivated it: fix the endpoint, then a person re-enables it (the map shows `IsActive` on `PUT`; check Cin7's docs for the exact step). |
| No event for a change | That change has no event in the map; poll instead. |
| Handler crashes on one event | Shape differs per event, or the body is a bare array. |
| `POST /webhooks` is rejected | Possibly the 5-per-type limit, or a missing `Yes*` field for the auth type. The map doesn't record the error text. |
| HTML or a redirect from the API | Wrong path or casing: see [`docs/PUBLIC-API.md`](../../docs/PUBLIC-API.md#errors). |
