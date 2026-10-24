"""Build modules/<module>/README.md from the map in data/.

Run from the repo root: python3 tools/generate.py
"""

import csv
import json
import re
from collections import defaultdict
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
DATA = ROOT / "data"
OUT = ROOT / "modules"

# Section names as the map writes them; endpoints.csv joins several with spaces, so match longest first.
SECTIONS = [
    "Shell (every page)",
    "Settings › Reference books",
    "Login / account",
    "Integrations",
    "Production",
    "Financials",
    "Dashboard",
    "Inventory",
    "Purchase",
    "Settings",
    "Reports",
    "Sale",
    "CRM",
    "AI",
]

# slug, section, title, what it is
MODULES = [
    ("01-shell", "Shell (every page)", "Shell and navigation",
     "The frame every page loads: top menu, global search, favourites, quick links, notifications and chat "
     "(SignalR `messageHub`), session timeout, the activity log and access checks. Bundle `Main2019`."),
    ("02-account", "Login / account", "Sign-in and account",
     "Sign-in, sign-out, password change, organisation switching and impersonation. Server-rendered MVC "
     "actions under `/Account/*`; a signed-in session is a cookie."),
    ("03-dashboard", "Dashboard", "Dashboard",
     "The home page (`/Home`): counters and grids that link into the document lists, plus the setup "
     "checklist (`/ContinueSetup`)."),
    ("04-inventory", "Inventory", "Inventory",
     "The product master (products, services, fixed assets, families/variants), stock availability per "
     "location and bin, stock adjustments, stocktakes, stock transfers, MRP runs, batch recall, price lists "
     "and gift cards."),
    ("05-purchase", "Purchase", "Purchase",
     "Suppliers and the purchase documents: simple and advanced purchase orders, service and drop-ship "
     "purchases, receiving (stock received / put-away), purchase invoices, credit notes, supplier payments "
     "and deposits, and the reorder screens."),
    ("06-sale", "Sale", "Sale",
     "Customers and the sale documents: quotes, simple and advanced (multi-fulfilment) sales, service "
     "sales, pick/pack/ship fulfilment, invoices, credit notes, customer payments, awaiting sales, recurring "
     "invoices, fulfilment orders, returns (RMA), warranties and discounts."),
    ("07-production", "Production", "Production",
     "Manufacturing: production BOMs and operations, production orders and runs, the production scheduler, "
     "capacity planner, MRP scheduler, resources and work centres, the factory calendar, assemblies "
     "(finished goods), disassemblies, job costing and inventory write-offs."),
    ("08-financials", "Financials", "Financials",
     "Money in and out outside sale and purchase documents: receive, spend and transfer money tasks, "
     "journals, expense claims, fixed assets and depreciation, bank accounts and bank rules, Cin7 Pay and "
     "Cin7 Capital."),
    ("09-crm", "CRM", "CRM",
     "Leads, opportunities, deals and tasks."),
    ("10-ai", "AI", "AI",
     "Ask AI (`/AMA`), document data extraction (upload a supplier document, get a purchase back) and "
     "generated product descriptions."),
    ("11-reports", "Reports", "Reports",
     "The report catalogue (`/Reports`) and each `/Report/<Name>` page. Most reports render inside a frame "
     "served by the separate report service; see [`../21-report-service`](../21-report-service/README.md)."),
    ("12-integrations", "Integrations", "Integrations",
     "The integrations catalogue and each connector's settings, mappings and logs: e-commerce channels, "
     "shipping, payments, tax, accounting, CRM, the public-API application setup (`/ExternalApi`), the WMS "
     "settings page (`/WarehouseApp`), POS (`/DearPos`), B2B portal and RMA portal."),
    ("13-settings", "Settings", "Settings",
     "Tenant-wide settings: general settings, users and roles (page access), document and email templates, "
     "notifications and automations, reminders, task settings, scheduled reports, user profile and "
     "subscription."),
    ("14-reference-books", "Settings › Reference books", "Reference books",
     "The lookup lists everything else points at: locations, bins and logistics paths, supply rules and "
     "transfer plans, chart of accounts and account mapping, tax rules, payment terms, carriers, ship zones, "
     "brands, categories, units of measure, attribute sets, discounts, order routing and default field values."),
    ("15-other", "", "Unassigned endpoints",
     "Endpoints found in shared bundles that no menu page claims. Rebuild them where their name says they "
     "belong."),
]

# Public API group -> module slug
PUBLIC_GROUPS = {
    "Production": "07-production", "Finished Goods": "07-production", "Disassembly": "07-production",
    "Inventory Write-Off": "07-production",
    "Purchase": "05-purchase", "Supplier": "05-purchase",
    "Sale": "06-sale", "Customer": "06-sale",
    "Stock": "04-inventory", "Product": "04-inventory", "Product Family": "04-inventory",
    "Product Markup Prices": "04-inventory", "Price Tiers": "04-inventory",
    "CRM": "09-crm",
    "Money Task": "08-financials", "Journal": "08-financials", "Bank Accounts": "08-financials",
    "Fixed Asset Type": "08-financials", "Transactions": "08-financials",
    "Chart of Accounts": "14-reference-books", "Tax": "14-reference-books", "Payment Term": "14-reference-books",
    "Carrier": "14-reference-books", "Location": "14-reference-books", "Reference Books": "14-reference-books",
    "Brand": "14-reference-books", "Unit of Measure": "14-reference-books", "Attribute Set": "14-reference-books",
    "Product Categories": "14-reference-books",
    "Me": "13-settings", "Webhooks": "13-settings", "Templates": "13-settings",
}

SQL_TYPES = {"string": "text", "int": "integer", "integer": "integer", "float": "numeric", "number": "numeric",
             "bool": "boolean", "boolean": "boolean", "date": "timestamptz", "auto": "jsonb", "decimal": "numeric", "object": "jsonb", "floar": "numeric"}

EFFECT_ICON = {"read": "🟢 read", "read+write": "🟠 read + write", "write": "🔴 write",
               "read (may log an audit line)": "🟢 read (logs)"}

SHARED_MODEL_LIMIT = 4  # a model used by this many modules or more goes to 00-shared


def split_sections(value):
    """Split a space-joined section list into section names."""
    found, rest = [], value
    while rest.strip():
        rest = rest.strip()
        for name in SECTIONS:
            if rest.startswith(name):
                found.append(name)
                rest = rest[len(name):]
                break
        else:
            break
    return found


def cell(value, limit=160):
    value = (value or "").replace("|", "\\|").replace("\n", " ").strip()
    return value if len(value) <= limit else value[: limit - 1] + "…"


def controller_of(url):
    """`/api/Sale_Index_vSale` -> `Sale`; `/Sale/Void` -> `Sale`."""
    if url.startswith("/api/"):
        name = url[5:].split("/")[0]
        return re.split(r"_", name)[0] or name
    parts = url.strip("/").split("/")
    return parts[0] if parts else url


def ddl(name, fields):
    cols = []
    for f in fields:
        col, _, typ = f.partition(":")
        cols.append(f'  "{col}" {SQL_TYPES.get(typ.lower(), "text")}')
    return f'create table "{name}" (\n' + ",\n".join(cols) + "\n);"


def load():
    endpoints = list(csv.DictReader(open(DATA / "endpoints.csv")))
    pages = list(csv.DictReader(open(DATA / "pages.csv")))
    public = [r for r in csv.DictReader(open(DATA / "public-api.csv")) if r["group"] != "group"]
    models = json.load(open(DATA / "models.json"))
    reports = []
    for line in open(DATA / "report-columns.txt"):
        parts = [p.strip() for p in line.split(" ~ ")]
        if len(parts) == 4:
            reports.append({"name": parts[0], "script": parts[1], "title": parts[2], "columns": parts[3].split("|")})
    return endpoints, pages, public, models, reports


def main():
    endpoints, pages, public, models, reports = load()
    section_slug = {sec: slug for slug, sec, _, _ in MODULES}

    ep_by = defaultdict(list)
    bundle_mods = defaultdict(set)
    for e in endpoints:
        secs = split_sections(e["sections"]) or [""]
        for sec in secs:
            slug = section_slug.get(sec, "15-other")
            ep_by[slug].append(e)
    pages_by = defaultdict(list)
    for p in pages:
        slug = section_slug.get(p["section"], "15-other")
        pages_by[slug].append(p)
        for b in p["bundles"].split():
            bundle_mods[b].add(slug)

    models_by = defaultdict(list)
    shared = []
    for name, m in sorted(models.items()):
        mods = set()
        for b in m.get("bundles", []):
            mods |= bundle_mods.get(b, set())
        if len(mods) >= SHARED_MODEL_LIMIT or not mods:
            shared.append((name, m, mods))
        else:
            for slug in mods:
                models_by[slug].append((name, m))

    pub_by = defaultdict(list)
    for r in public:
        pub_by[PUBLIC_GROUPS.get(r["group"], "13-settings")].append(r)

    OUT.mkdir(exist_ok=True)
    index = []
    for slug, sec, title, about in MODULES:
        eps = ep_by.get(slug, [])
        pgs = pages_by.get(slug, [])
        mdl = models_by.get(slug, [])
        pub = pub_by.get(slug, [])
        reps = reports if slug == "11-reports" else []
        index.append((slug, title, len(pgs), len(mdl), len(eps), len(pub)))
        write_module(slug, title, about, pgs, mdl, eps, pub, reps)

    write_shared(shared)
    write_front_ends(public)
    write_index(index, len(shared))


def write_module(slug, title, about, pages, models, eps, public, reports):
    d = OUT / slug
    d.mkdir(exist_ok=True)
    L = [f"# {title}", "", about, ""]
    n_write = sum(1 for e in eps if "write" in e["effect"])
    L += ["| | Count |", "|---|---:|",
          f"| Pages | {len(pages)} |", f"| Data models | {len(models)} (plus [shared](../00-shared/README.md)) |",
          f"| Internal endpoints | {len(eps)} ({n_write} write) |", f"| Public API operations | {len(public)} |"]
    if reports:
        L.append(f"| Reports | {len(reports)} |")
    L += ["", "## How to rebuild it", ""]
    steps = []
    if models:
        steps.append(f"**Schema.** Create one table per data model below ({len(models)}), starting from the generated "
                     "[`schema.sql`](schema.sql). Ids are GUIDs; join on the `*ID` fields.")
    if eps:
        steps.append("**Internal API.** Implement each controller's endpoints with the verbs listed, following the "
                     "[internal API contract](../../docs/INTERNAL-API.md): one URL per store for GET/POST/PUT/DELETE, "
                     "paged reads returning `{root, total}`, saves wrapped as `{ID, HasErrors, Original, Updated}`.")
    if pages:
        steps.append("**Pages.** Build each route below as a server-rendered shell that loads the shell bundle and "
                     "the page's own app, opening a record from `#<guid>` once at load "
                     "([page model](../../docs/ARCHITECTURE.md#what-a-page-is)).")
    if public:
        steps.append(f"**Public API.** Expose the {len(public)} operations below under `/ExternalApi/v2` with "
                     "header auth ([public API contract](../../docs/PUBLIC-API.md)).")
    if reports:
        steps.append("**Reports.** Each report is a pivot grid over the columns listed, served by the report "
                     "service ([`21-report-service`](../21-report-service/README.md)).")
    L += [f"{i}. {s}" for i, s in enumerate(steps, 1)] + [""]

    if pages:
        L += ["## Pages", "", "| Route | Menu label | Title | Bundle | Endpoints (write) |", "|---|---|---|---|---:|"]
        for p in sorted(pages, key=lambda p: p["route"]):
            L.append(f"| `{p['route']}` | {cell(p['menu_label'])} | {cell(p['title'])} | `{cell(p['bundles'])}` | "
                     f"{p['n_api']} ({p['n_write']}) |")
        L.append("")

    if models:
        L += ["## Data models", "", "ExtJS models the pages use; `v` prefix = view-model. Full DDL in "
              "[`schema.sql`](schema.sql).", "", "| Model | Fields |", "|---|---|"]
        for name, m in models:
            L.append(f"| `{name}` | {cell(', '.join(m.get('fields', [])), 600)} |")
        L.append("")
        (d / "schema.sql").write_text(
            f"-- {title}: one table per Cin7 Core data model, generated from data/models.json\n\n"
            + "\n\n".join(ddl(n, m.get("fields", [])) for n, m in models if m.get("fields")) + "\n")

    if eps:
        L += ["## Internal endpoints", "",
              "Grouped by controller. Effect: 🟢 read · 🟠 read + write at the same URL · 🔴 write. "
              "`api` = JSON under `/api/`, `mvc` = controller action.", ""]
        groups = defaultdict(list)
        for e in eps:
            groups[controller_of(e["url"])].append(e)
        for ctrl in sorted(groups, key=str.lower):
            L += [f"### {ctrl}", "", "| URL | Kind | Methods | Effect | Params | Body keys | Reader root |",
                  "|---|---|---|---|---|---|---|"]
            for e in sorted(groups[ctrl], key=lambda e: e["url"]):
                L.append(f"| `{cell(e['url'])}` | {e['kind']} | {cell(e['methods'])} | "
                         f"{EFFECT_ICON.get(e['effect'], e['effect'])} | {cell(e['params'])} | "
                         f"{cell(e['body_keys'])} | {cell(e['reader_root'])} |")
            L.append("")

    if public:
        L += ["## Public API (`/ExternalApi/v2`)", "", "| Group | Method | Path | Query / params |", "|---|---|---|---|"]
        for r in sorted(public, key=lambda r: (r["group"], r["path"], r["method"])):
            L.append(f"| {r['group']} | {r['method']} | `{r['path']}` | {cell(r['query'] or r['params'])} |")
        L.append("")

    if reports:
        L += ["## Reports and their columns", "", "| Report | Title | Script | Columns |", "|---|---|---|---|"]
        for r in sorted(reports, key=lambda r: r["name"]):
            L.append(f"| `{r['name']}` | {cell(r['title'])} | `{r['script']}` | {cell(', '.join(r['columns']), 900)} |")
        L.append("")

    (d / "README.md").write_text("\n".join(L))


def write_shared(shared):
    d = OUT / "00-shared"
    d.mkdir(exist_ok=True)
    L = ["# Shared data models", "",
         f"{len(shared)} models used across {SHARED_MODEL_LIMIT}+ modules (or by shared bundles only). Build these "
         "first; every module's schema joins to them. DDL in [`schema.sql`](schema.sql).", "",
         "| Model | Fields | Modules |", "|---|---|---|"]
    for name, m, mods in shared:
        L.append(f"| `{name}` | {cell(', '.join(m.get('fields', [])), 600)} | {', '.join(sorted(mods)) or 'shell'} |")
    (d / "README.md").write_text("\n".join(L) + "\n")
    (d / "schema.sql").write_text(
        "-- Shared Cin7 Core data models, generated from data/models.json\n\n"
        + "\n\n".join(ddl(n, m.get("fields", [])) for n, m, _ in shared if m.get("fields")) + "\n")


def write_index(index, n_shared):
    L = ["| Module | Pages | Models | Internal endpoints | Public API ops |", "|---|---:|---:|---:|---:|",
         f"| [00 Shared data models](00-shared/README.md) | | {n_shared} | | |"]
    for slug, title, p, m, e, pub in index:
        L.append(f"| [{slug[:2]} {title}]({slug}/README.md) | {p} | {m} | {e} | {pub} |")
    for slug, title in [("20-public-api", "Public API and webhooks"), ("21-report-service", "Report service"),
                        ("22-pos", "POS"), ("23-wms", "WMS handheld app"), ("24-mes", "MES shop-floor app"),
                        ("25-portals", "B2B and RMA portals")]:
        L.append(f"| [{slug[:2]} {title}]({slug}/README.md) | | | | |")
    (OUT / "README.md").write_text("# Modules\n\nOne folder per module. Generated by `tools/generate.py` "
                                   "(00–15); 20–25 are hand-written.\n\n" + "\n".join(L) + "\n")


FRONT_ENDS = ROOT / "tools" / "front_ends"


def write_front_ends(public):
    """Modules 20-25: hand-written prose in tools/front_ends/<slug>.md plus the generated call tables."""
    tables = {
        "20-public-api": ("public-api.csv", ["group", "method", "path", "query"]),
        "21-report-service": ("report-service-endpoints.csv", ["url", "methods", "params", "bundles"]),
        "22-pos": ("pos-api.csv", ["path", "methods", "params", "client_functions"]),
        "23-wms": ("wms-api.csv", ["path", "methods", "effect", "client_functions"]),
        "24-mes": ("mes-api.csv", ["path", "methods", "effect", "client_functions"]),
        "25-portals": (None, []),
    }
    for slug, (src, cols) in tables.items():
        d = OUT / slug
        d.mkdir(exist_ok=True)
        L = [(FRONT_ENDS / f"{slug}.md").read_text().rstrip(), ""]
        if src:
            rows = [r for r in csv.DictReader(open(DATA / src)) if r.get("group") != "group"]
            L += [f"## Every call ({len(rows)})", "", "| " + " | ".join(cols) + " |", "|" + "---|" * len(cols)]
            for r in rows:
                L.append("| " + " | ".join(f"`{cell(r[c])}`" if i == 0 or c == "path" else cell(r[c])
                                           for i, c in enumerate(cols)) + " |")
            L.append("")
        (d / "README.md").write_text("\n".join(L))


if __name__ == "__main__":
    main()
