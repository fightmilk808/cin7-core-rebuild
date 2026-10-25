# Cin7 Core rebuild

What Cin7 Core is, and how to rebuild each of its modules.

**Cin7 Core** (formerly DEAR Inventory) is a multi-tenant cloud inventory and operations system for product businesses:
products and stock across locations and bins, purchasing, sales and fulfilment, manufacturing, light accounting, CRM,
reporting, and connectors to e-commerce, shipping, payment and accounting services. The main app runs at
`inventory.dearsystems.com`, with a report service, a POS, handheld warehouse and shop-floor apps, and customer portals
beside it.

This repo documents its structure only: pages, data models, endpoints, API contracts and front ends, read from the shipped
web app, its public scripts and Cin7's published API spec (October 2026). Business rules and calculations are left out.

## Start here

| Doc | What it covers |
|---|---|
| [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md) | The hosts, the tech stack, what a page is, and the build order |
| [docs/INTERNAL-API.md](docs/INTERNAL-API.md) | The contract the web app's 2,177 internal endpoints follow |
| [docs/PUBLIC-API.md](docs/PUBLIC-API.md) | The public `/ExternalApi/v2` contract: auth, paging, errors, shapes |
| [docs/UI.md](docs/UI.md) | The visual system (themes, colours, type, icons, widgets), the shell and the main menu |
| [docs/IMPORTS.md](docs/IMPORTS.md) | CSV layouts for document line uploads and master-data imports |
| [docs/AUTOMATIONS.md](docs/AUTOMATIONS.md) | Automated workflows: data model, condition parameters and operators, and the 48 merge fields |
| [docs/RELATIONSHIPS.md](docs/RELATIONSHIPS.md) | How records point at each other: every `*ID` column mapped to its entity, with an ER diagram of the core (each `schema.sql` marks reference columns `-- -> Entity`) |
| [modules/20-public-api/groups/](modules/20-public-api/groups/) | Every public API group: field tables (types, lengths, required, allowed values), each operation's parameters, request and response body shapes, status lists, and [all 32 webhook payloads](modules/20-public-api/groups/webhooks.md) |
| `modules/22-pos`, `23-wms`, `24-mes` → `SCREENS.md` | Every screen of the POS and the two handheld apps: navigation, fields, buttons, lists, dialogs and the API calls each makes |
| [modules/](modules/README.md) | **One folder per module** (and per integration): `README.md` with what it is, how to rebuild it, its pages, data models, internal endpoints, public API operations and reports; `UI.md` with every grid and column, field, button, menu and dialog its screens build; `schema.sql` |
| [data/](data/) | The machine-readable map the module folders are generated from |
| [tools/generate.py](tools/generate.py) | Rebuilds `modules/` from `data/` |
| [tools/extract_ui.js](tools/extract_ui.js) | Rebuilds `data/ui.json` from the page bundles (`node tools/extract_ui.js <bundle dir> data/ui.json`, needs `acorn`) |

## The modules

| # | Module | # | Module |
|---|---|---|---|
| 00 | [Shared data models](modules/00-shared/README.md) | 13 | [Settings](modules/13-settings/README.md) |
| 01 | [Shell and navigation](modules/01-shell/README.md) | 14 | [Reference books](modules/14-reference-books/README.md) |
| 02 | [Sign-in and account](modules/02-account/README.md) | 15 | [Unassigned endpoints](modules/15-other/README.md) |
| 03 | [Dashboard](modules/03-dashboard/README.md) | 20 | [Public API and webhooks](modules/20-public-api/README.md) |
| 04 | [Inventory](modules/04-inventory/README.md) | 21 | [Report service](modules/21-report-service/README.md) |
| 05 | [Purchase](modules/05-purchase/README.md) | 22 | [POS](modules/22-pos/README.md) |
| 06 | [Sale](modules/06-sale/README.md) | 23 | [WMS handheld app](modules/23-wms/README.md) |
| 07 | [Production](modules/07-production/README.md) | 24 | [MES shop-floor app](modules/24-mes/README.md) |
| 08 | [Financials](modules/08-financials/README.md) | 25 | [B2B and RMA portals](modules/25-portals/README.md) |
| 09 | [CRM](modules/09-crm/README.md) | | |
| 10 | [AI](modules/10-ai/README.md) | 16 | [MRP](modules/16-mrp/README.md) |
| 11 | [Reports](modules/11-reports/README.md) | | |
| 12 | [Integrations](modules/12-integrations/README.md) (one subfolder per connector, 42) | | |

## At a glance

| | Count |
|---|---:|
| Page routes | 261 |
| Page script bundles | 202 |
| Internal JSON endpoints (`/api/…`) | 1,633 |
| Controller actions (`/<Controller>/<Action>`) | 544 |
| Data models | 1,024 |
| Public API operations | 295 on 115 paths |
| Webhook events | 31 |
| Reports | 86 (69 with captured columns) |
| Other front ends | 6: report service, POS, WMS, MES, B2B portal, RMA portal |

## Regenerating

```bash
python3 tools/generate.py
```
