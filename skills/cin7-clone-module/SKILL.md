---
name: cin7-clone-module
description: Turn one module of the cin7-core-rebuild map (for example Inventory, Sale or Purchase) into a build plan and scaffold for the person's own app - tables from schema.sql, screens from UI.md, API surface from the module's endpoints. Use when someone says "build my own version of Cin7's <X> screen", "clone the stock adjustment page", "scaffold the purchase module", or "what do I build first". The map is structure only, so this skill asks the person for business rules instead of inventing them.
---

# Clone a Cin7 module

The map says what Cin7 Core's screens, fields, tables and endpoints are. It says **nothing** about business rules or calculations: no costing, no allocation, no status transitions, no tax or rounding, no validation beyond field names and types. Those come from the person.

## Read, in this order

| # | File | Gives you |
|---|---|---|
| 1 | [`README.md`](../../README.md), [`modules/README.md`](../../modules/README.md) | Module numbers and the build order |
| 2 | `modules/<nn-name>/README.md` | Pages, models, endpoints (read/write marked), public API ops, "How to rebuild it" |
| 3 | `modules/<nn-name>/UI.md` | Per screen: layout outline, grids, columns, fields, buttons, dialogs |
| 4 | `modules/<nn-name>/schema.sql` | One table per model; `-- -> Entity` comments mark `*ID` references |
| 5 | [`docs/RELATIONSHIPS.md`](../../docs/RELATIONSHIPS.md) | What each `*ID` points to; `TaskID` is the document id; `TenantID` scopes everything |
| 6 | [`docs/ARCHITECTURE.md`](../../docs/ARCHITECTURE.md), [`docs/INTERNAL-API.md`](../../docs/INTERNAL-API.md) | Page model, deep links, paging `{root, total}`, save wrapper |
| 7 | [`docs/UI.md`](../../docs/UI.md) | Layout vocabulary only (see rule 3) |

Modules with no `UI.md` or `schema.sql` (e.g. `20-public-api`, `21-report-service`) have a README only; say so rather than guessing.

## Build order

Modules depend on each other. Check the diagram in `modules/README.md` before starting: tenancy and roles (02, 13), shared models and reference books (00, 14), shell (01), inventory (04), then purchase, sale, production (05, 06, 07), financials (08), public API (20), reports (11, 21). If the person asks for module 06 first, list the earlier tables it joins to (from the `-- ->` comments) and stub them.

## Make the plan

1. **Scope.** Ask which screens and whether read-only or editable. Take the screen names from the module's `UI.md` "Screens" table.
2. **Tables.** Start from the module's `schema.sql`. Keep only the tables the chosen screens use, found by following the models named in README "Data models" and `-- ->` references. Add shared tables from `modules/00-shared/schema.sql` as needed. Keep GUID ids and `*ID` joins; the person may rename.
3. **API surface.** From README "Internal endpoints" pick the controllers the screens call. Use the Effect column: read is a GET; read+write means one URL serves list and save; write needs a design decision. Note the person's own API need not copy the paths.
4. **Screens.** One per route in `UI.md`. List its grids and columns, form fields, buttons and dialogs from that file. Order by what is needed to open a record, then to save it.
5. **Rules list.** Write down every place a rule is needed (a status field, a total, a cost, a quantity that changes stock) and **ask the person what it should do**. Do not fill the gap from your idea of how an ERP works.
6. **Scaffold** only what the plan covers: migrations, a read endpoint per list, one screen. Run it before adding the next.

```bash
# endpoints a module's README marks as writes
grep -E '🔴|🟠' modules/04-inventory/README.md | cut -c1-120
# columns of one table
awk '/create table "ProductLocation"/,/^\);/' modules/04-inventory/schema.sql
```

## Rules

1. **Ask, don't invent.** Any status flow, calculation, permission or validation the map lacks goes in a "Questions for you" list before code.
2. **Structure, not source.** Field names and types come from the map; do not claim Cin7 behaves a certain way beyond what a file shows.
3. **No Cin7 assets or branding.** Do not copy its logo, name, icons (`data/icons.json` names only), fonts or colour palette. The person's app gets its own look; use `docs/UI.md` for layout ideas, not styling.
4. **Don't clone the tenant data.** Use invented sample rows.
5. **Say what is unmapped.** Missing from the map means "not recorded", not "doesn't exist".

## When it fails

| Symptom | Cause |
|---|---|
| A table has fields the screen never shows | `schema.sql` is every model in the module; trim to the chosen screens. |
| A `-> Entity` has no table in this module | It is in `00-shared` or another module; look it up in `RELATIONSHIPS.md`. |
| Endpoint marked read+write | One URL, several verbs; split by verb in your API. |
| The person wants "how Cin7 calculates X" | Not recorded. Ask them, or have them test Cin7 themselves. |
