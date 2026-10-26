---
name: cin7-integrations
description: Explain how a Cin7 Core (DEAR Inventory) integration - Shopify, ShipStation, QuickBooks, Xero, Amazon and the rest of the catalogue - is wired, from the map of the web app: its settings page, the endpoints and logs behind it, what the map shows moving each way, and how to troubleshoot a sync with that. Use when someone asks how a Cin7 connector works, where a setting lives, why orders or stock are not syncing, or which endpoint backs an integration screen. Advisory and read-only.
---

# Cin7 integrations

Each connector has a folder in [`modules/12-integrations/`](../../modules/12-integrations/README.md): `README.md` (page, data models, every endpoint with read/write marking), `UI.md` (every tab, field and button label), `schema.sql`. The catalogue table in the module README maps integration to route (`/Shopify`, `/ShipStation/ConfigurationNG`, `/Quickbooks`, `/Xero`, `/Amazon`, ...).

## Look up an integration

```bash
ls modules/12-integrations
python3 - <<'PY'                       # endpoints behind a page, from the flat file
import csv
for r in csv.DictReader(open('data/endpoints.csv')):
    if r['pages'].startswith('/Shopify'): print(r['effect'], r['url'], r['params'])
PY
grep -n "label\|tabs" modules/12-integrations/shopify/UI.md | head -60   # settings and tabs
```

Read in this order: the module README (pages, endpoints), `UI.md` (what the person sees), the `v<Name>Configuration`-style model in the README (the setting names), then the `Log`/`Operation log`/`Pending orders` models (what to check when a sync misbehaves).

## What the map shows

- The page is a settings screen plus status tabs. For the e-commerce connectors the recorded tabs are Setup, Catalog, Bulk listing, Pending orders, Log and Operations log (Shopify's `UI.md` is the worked example); the others are similar but check each `UI.md`.
- Settings are saved through endpoints marked write; reads are the lists, logs and lookups (accounts, tax rules, locations, price tiers).
- Direction is only as clear as the labels and model names. For example Shopify's setup has "Load orders from Shopify" and "Update stock levels in Shopify", and the accounting connectors expose `StartSync`, `StartOnboardingImport` and a sync-history list. The map does not record the sync logic itself, schedules, or API limits of the other system. Where it matters, say "the map doesn't show this" and send the person to that vendor's and Cin7's help pages. Do not guess.

## Troubleshoot a sync

1. Find the integration's log endpoints (`...Logs`, `...OperationLogs`, `...PendingOrders`, `...SynchronisationHistory`) in the README and note their filter params (`status`, `fromDate`, `ConfigID`).
2. Ask the person to read those tabs in Cin7 (or give you an export), then match the status text against the model fields in the README.
3. Check the settings that gate the flow, named in `UI.md`: connection status, location mapping, tax and account mappings, price tier, consolidation, "load orders" toggles.
4. If the page says the connection needs reauthorisation, only the account owner can reconnect it.
5. For the public API side (what an external tool can read), use [`cin7-webhooks`](../cin7-webhooks/SKILL.md) or the `cin7-core` skill; the integration pages are internal, not a stable API.

## Rules

1. **Advisory only.** Never change an integration setting, mapping, connection or sync, and never press Save, Start sync, Import or Delete. Describe the click and let a person do it.
2. **Internal endpoints are a map.** Endpoints marked write (🔴) or read + write (🟠) are described, not called. Even "read" ones use the signed-in web session; do not script them.
3. **No secrets.** Models list fields like tokens and keys; never ask for, print or store their values.
4. **Name the source.** Cite the README or `UI.md` section you got a claim from, and mark anything inferred from a label as inferred.
5. Per-integration detail varies: some folders have no endpoints (Airwallex, Neto, Synder, Zapier) because they are catalogue entries only.

## When the map has no answer

| Question | Say |
|---|---|
| Why did a particular order fail? | The map has the log models, not the data or error catalogue. Read the Log tab. |
| How often does it sync? | Not recorded. Check the Setup tab and Cin7's help. |
| What does the other system do with it? | Out of scope; use that vendor's docs. |
