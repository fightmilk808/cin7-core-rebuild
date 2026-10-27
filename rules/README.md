# Business rules

The rest of this repo maps Cin7 Core's **structure**. This folder holds its **behaviour**: status flows, quantities, costing, journals, totals, tax, validations, and what each setting changes.

Every area has two files:

| Kind | Source | Tells you |
|---|---|---|
| `<area>.md` | Cin7 Core's public help center, read in full, plus the public API v2 spec and this map | What Cin7 says should happen, server side included |
| `<area>-client.md` | Static reading of the page scripts Cin7 ships to every browser (never executed) | What the screens actually do: field rules, enable conditions, client calculations, message text |

Each rule carries a tag: `[DOC]` Cin7 documentation, `[API]` the public API, `[CLIENT]` the page scripts, `[SPEC]` this map, `[INFER]` deduced, `[ASSUME]` a choice made where Cin7 is silent. Treat `[INFER]` and `[ASSUME]` as unverified. Each file ends with what is still open or where Cin7's own docs disagree.

> [!WARNING]
> Every file opens with **⚠️ Gotchas: the sneaky stuff**, ranked worst first. Read those before building anything.

## Files

| Area | Rules | Screens | Worst gotcha |
|---|---|---|---|
| Settings | [settings.md](settings.md) | [settings-client.md](settings-client.md) | Saving General Settings always forces two-factor authentication on |
| Inventory | [inventory.md](inventory.md) | [inventory-client.md](inventory-client.md) | Set stock on hand is not an update: on existing balances it duplicates stock |
| Purchase | [purchase.md](purchase.md) | [purchase-client.md](purchase-client.md) | Void is permanent and takes deposits, payments and linked production with it |
| Sale | [sale.md](sale.md) | [sale-client.md](sale-client.md) | Voiding a sale that has a payment deletes its transactions and refunds nothing |
| Production | [production.md](production.md) | [production-client.md](production-client.md) | Editing an order line silently deletes every production run |
| MRP | [mrp.md](mrp.md) | [mrp-client.md](mrp-client.md) | Voiding a confirmed suggestion voids the real document, and nothing recalculates |
| Reference books | [reference-books.md](reference-books.md) | [reference-books-client.md](reference-books-client.md) | Chart of accounts "Use default" re-archives accounts and cannot be undone |
| ShipStation | [shipstation.md](shipstation.md) | [shipstation-client.md](shipstation-client.md) | A sale that fails the export rules is skipped with no error |
| Shopify | [shopify.md](shopify.md) | [shopify-client.md](shopify-client.md) | Disconnecting wipes the links between the two systems, plus logs and pending orders |

Not covered yet: financials, CRM, reports, the other integrations, POS, WMS and B2B.

## Limits

- Cin7 can change behaviour at any time. The help center was read in October 2026.
- Help-center text is paraphrased. Option lists, UI labels and short messages are quoted as facts.
- Nothing here was tested against a live account, and no account data is included.
