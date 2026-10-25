"""Build modules/ from the map in data/.

Run from the repo root: python3 tools/generate.py

Each module (and each integration under 12-integrations/) gets:
  README.md  what it is, how to rebuild it, pages, data models, endpoints, public API, reports
  UI.md      every screen's components from the page code: grids and columns, fields, buttons, menus, dialogs
  schema.sql one table per data model
"""

import csv
import html
import json
import re
import shutil
from collections import defaultdict
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
DATA = ROOT / "data"
OUT = ROOT / "modules"
FRONT_ENDS = ROOT / "tools" / "front_ends"

# Section names as the map writes them; endpoints.csv joins several with spaces, so match longest first.
SECTIONS = [
    "Shell (every page)", "Settings › Reference books", "Login / account", "Integrations", "Production",
    "Financials", "Dashboard", "Inventory", "Purchase", "Settings", "Reports", "Sale", "CRM", "AI",
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
     "location and bin, stock adjustments, stocktakes, stock transfers, batch recall, price lists and gift cards. "
     "MRP is its own module: [`16-mrp`](../16-mrp/README.md)."),
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
     "capacity planner, resources and work centres, the factory calendar, assemblies (finished goods), "
     "disassemblies, job costing and inventory write-offs. MRP is its own module: [`16-mrp`](../16-mrp/README.md)."),
    ("08-financials", "Financials", "Financials",
     "Money in and out outside sale and purchase documents: receive, spend and transfer money tasks, "
     "journals, expense claims, fixed assets and depreciation, bank accounts and bank rules, Cin7 Pay and "
     "Cin7 Capital."),
    ("09-crm", "CRM", "CRM", "Leads, opportunities, deals and tasks."),
    ("10-ai", "AI", "AI",
     "Ask AI (`/AMA`), document data extraction (upload a supplier document, get a purchase back) and "
     "generated product descriptions."),
    ("11-reports", "Reports", "Reports",
     "The report catalogue (`/Reports`) and each `/Report/<Name>` page. Most reports render inside a frame "
     "served by the separate report service; see [`../21-report-service`](../21-report-service/README.md)."),
    ("12-integrations", "Integrations", "Integrations",
     "The integrations catalogue (`/Integrations`) and one subfolder per connector: its settings page, "
     "mappings, sync logs and endpoints."),
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
    ("16-mrp", None, "MRP",
     "Material requirements planning: MRP runs (`/MRPList`, `/MRP#<id>`) with their settings, demand, supply "
     "suggestions, errors and log; the MRP scheduler (`/MRPScheduler`); and confirming suggestions into "
     "purchases, production orders and transfers. Its inputs are edited elsewhere and listed here too: supply "
     "rules and transfer plans per location, logistics paths, and lead and safety values. The MRP demand grid "
     "is a report-service report (`/Report/MRPDemand`)."),
]

MRP_ROUTES = {"/MRP", "/MRPList", "/MRPScheduler"}
MRP_URL = re.compile(r"MRP")
MRP_INPUT_URL = re.compile(r"SupplyRule|SupplyInterval|LogisticsPath|LeadSafety")

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
             "bool": "boolean", "boolean": "boolean", "date": "timestamptz", "auto": "jsonb", "decimal": "numeric",
             "object": "jsonb", "floar": "numeric"}

EFFECT_ICON = {"read": "🟢 read", "read+write": "🟠 read + write", "write": "🔴 write",
               "read (may log an audit line)": "🟢 read (logs)"}

SHARED_MODEL_LIMIT = 4  # a model used by this many modules or more goes to 00-shared
SHELL_BUNDLES = {"Main2019", "Main2019_rep"}

# Server-rendered page layouts (data/layout.json), filled in main().
LAYOUT = {"pages": {}, "modals": {}, "shell": ""}
SHELL_MODALS = set()  # dialogs present on most pages: documented once under 01-shell
SHELL_MODAL_SHARE = 0.3


def slugify(text):
    return re.sub(r"[^a-z0-9]+", "-", text.lower()).strip("-")


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
    value = str(value if value is not None else "").replace("|", "\\|").replace("\n", " ").strip()
    return value if len(value) <= limit else value[: limit - 1] + "…"


def controller_of(url):
    """`/api/Sale_Index_vSale` -> `Sale`; `/Sale/Void` -> `Sale`."""
    if url.startswith("/api/"):
        name = url[5:].split("/")[0]
        return name.split("_")[0] or name
    parts = url.strip("/").split("/")
    return parts[0] if parts else url


# Reference columns -> the entity they point at. Prefixes are roles (DefaultLocationID is a Location).
REF_ALIASES = {
    "Attachement": "Attachment", "SaleTask": "Sale", "PurchaseTask": "Purchase", "DropShipTask": "Purchase",
    "RmaTask": "RMA", "FulfilmentTask": "Fulfilment", "MoneyTask": "MoneyTask", "Bom": "ProductionBOM",
    "BOMConfiguration": "ProductionBOM", "Family": "ProductFamily", "Term": "PaymentTerm", "Run": "ProductionRun",
    "WorkCenter": "WorkCentre", "Resource": "ProductionResource", "Card": "InventoryCard", "CardDetails": "InventoryCard",
    "Set": "AttributeSet", "CurrentAttributeSet": "AttributeSet", "FinishedGoods": "Assembly", "SaleCredit": "SaleCreditNote",
    "Rule": "Rule (context-specific)", "Item": "Item (context-specific)", "Entity": "Entity (polymorphic)",
    "Config": "IntegrationConfig", "ECSConfig": "IntegrationConfig", "EcsConfig": "IntegrationConfig",
    "Configuration": "IntegrationConfig", "Blob": "Blob (stored file)", "BlobGUID": "Blob (stored file)", "File": "Blob (stored file)",
    "Image": "Blob (stored file)", "Line": "Line (parent document's line)", "OrderLine": "Line (parent document's line)",
    "InvoiceLine": "Line (parent document's line)", "QuoteLine": "Line (parent document's line)",
    "SourceLine": "Line (parent document's line)", "Order": "Order (context-specific)", "FFOrder": "FulfilmentOrder",
    "FF": "FulfilmentOrder", "Fake": None, "Tenant": "Tenant", "SupplierCustomer": "Customer",
    "ConsolidateToCustomer": "Customer", "Task": "Task (any document)", "SourceTask": "Task (any document)",
    "TargetTask": "Task (any document)", "CreditSourceTask": "Task (any document)", "LinkedProductionOrder": "ProductionOrder",
    "TransferOrder": "StockTransfer", "ShipAddress": "Address", "WebPortal": "Portal", "Portal": "Portal",
    "TaxRule": "TaxRule", "Category": "ProductCategory", "TaskCategory": "TaskCategory",
}
ROLE_PREFIXES = ("Default", "Receipts", "Order", "Ship", "Current", "Source", "Target", "Linked", "Parent", "Base", "Main")


def ref_entity(col):
    """`DefaultLocationID` -> `Location`; None when the column is not a reference."""
    m = re.match(r"^(.+?)(ID|Id|GUID)$", col)
    if not m or col in ("ID", "Id", "GUID"):
        return None
    base = m.group(1) if m.group(2) != "GUID" else col
    if base in REF_ALIASES:
        return REF_ALIASES[base]
    for p in ROLE_PREFIXES:
        if base.startswith(p) and len(base) > len(p) + 2:
            rest = base[len(p):]
            return REF_ALIASES.get(rest, rest)
    return base


def ddl(name, fields):
    cols = []
    seen = set()
    for f in fields:
        col, _, typ = f.partition(":")
        if not col or col.lower() in seen:
            continue
        seen.add(col.lower())
        ref = ref_entity(col)
        cols.append(f'  "{col}" {SQL_TYPES.get(typ.lower(), "text")}' + (f"  -- -> {ref}" if ref else ""))
    body = ""
    for i, c in enumerate(cols):
        code, sep, comment = c.partition("  -- ")
        body += code + ("," if i < len(cols) - 1 else "") + (f"  -- {comment}" if sep else "") + "\n"
    return f'create table "{name}" (\n' + body + ");"


def write_relationships(models):
    """docs/RELATIONSHIPS.md: which entity each reference column points at, across all models."""
    refs = defaultdict(lambda: {"cols": defaultdict(int), "models": set()})
    for name, m in models.items():
        for f in m.get("fields", []):
            col = f.split(":")[0]
            ent = ref_entity(col)
            if ent:
                refs[ent]["cols"][col] += 1
                refs[ent]["models"].add(name)
    homes = {}
    lower = {n.lower(): n for n in models}
    for ent in refs:
        key = re.sub(r"[^A-Za-z]", "", ent.split(" (")[0]).lower()
        homes[ent] = [lower[k] for k in (f"v{key}", key, f"v{key}s", f"{key}model") if k in lower]
    core = ["Product", "ProductFamily", "Customer", "Supplier", "Location", "Bin", "Sale", "Purchase", "Task (any document)",
            "ProductionOrder", "ProductionRun", "ProductionBOM", "Operation", "ProductionResource", "WorkCentre",
            "ProductCategory", "Brand", "TaxRule", "PaymentTerm", "Carrier", "Contact", "Address", "User", "Attachment"]
    L = ["# Relationships", "",
         "How Cin7 Core's records point at each other, read from the 1,024 data models' field names. Every id is a GUID. "
         "A column named `<Entity>ID` (or `<Role><Entity>ID`, like `DefaultLocationID`) references that entity. "
         "Each `schema.sql` marks these columns with `-- -> <Entity>`.", "",
         "## Conventions", "",
         "- **`TaskID` is the document id.** Sales, purchases, assemblies, disassemblies, transfers, stock adjustments, "
         "production orders, jobs, money tasks and CRM records are all *tasks*; their lines, payments, attachments and "
         "logs carry `TaskID` (or a typed alias such as `SaleTaskID`, `PurchaseTaskID`, `DropShipTaskID`).",
         "- **`TenantID` scopes everything** to one account.",
         "- **`ConfigID` / `ECSConfigID` point at an integration's configuration** (one per connected store or channel).",
         "- **`FakeID` is a client-side row id** used by grids before a save; it is not a reference.",
         "- **Lines reference their parent and the product:** `TaskID` + `ProductID` (+ `LocationID`, `BinID` for stock).",
         "- **Roles share an entity:** `LocationID`, `DefaultLocationID`, `ReceiptsLocationID`, `OrderLocationID` all point at a location.",
         "",
         "## Core entities", "",
         "```mermaid", "erDiagram",
         "  Customer ||--o{ Sale : places", "  Supplier ||--o{ Purchase : supplies",
         "  Sale ||--o{ SaleLine : has", "  Purchase ||--o{ PurchaseLine : has",
         "  Product ||--o{ SaleLine : sold", "  Product ||--o{ PurchaseLine : bought",
         "  ProductFamily ||--o{ Product : groups", "  ProductCategory ||--o{ Product : classifies", "  Brand ||--o{ Product : brands",
         "  Location ||--o{ Bin : contains", "  Location ||--o{ StockLevel : holds", "  Product ||--o{ StockLevel : stocked",
         "  Product ||--o{ ProductionBOM : made_by", "  ProductionBOM ||--o{ Operation : steps",
         "  Operation ||--o{ BOMComponent : consumes", "  Operation }o--|| WorkCentre : at",
         "  Operation ||--o{ ResourceUse : uses", "  ProductionResource ||--o{ ResourceUse : used",
         "  ProductionOrder ||--o{ ProductionRun : runs", "  ProductionOrder }o--|| ProductionBOM : follows",
         "  Sale ||--o{ ProductionOrder : triggers", "  Customer ||--o{ Contact : has", "  Customer ||--o{ Address : has",
         "  Supplier ||--o{ Contact : has", "  Supplier ||--o{ Address : has",
         "  TaxRule ||--o{ Sale : taxes", "  PaymentTerm ||--o{ Sale : terms", "  Carrier ||--o{ Sale : ships",
         "```", "",
         "## Every referenced entity", "",
         "| Entity | Columns that reference it | Models referencing it | Likely home model |", "|---|---|---:|---|"]
    order = [e for e in core if e in refs] + sorted(e for e in refs if e not in core)
    for ent in order:
        r = refs[ent]
        cols = ", ".join(f"`{c}`" for c, _ in sorted(r["cols"].items(), key=lambda x: -x[1])[:8])
        more = "" if len(r["cols"]) <= 8 else f" +{len(r['cols']) - 8}"
        L.append(f"| **{ent}** | {cols}{more} | {len(r['models'])} | {', '.join('`' + h + '`' for h in homes[ent]) or ''} |")
    (ROOT / "docs" / "RELATIONSHIPS.md").write_text("\n".join(L) + "\n")


# ---------------------------------------------------------------- UI rendering

KIND = {
    "Ext.grid.Panel": "grid", "Ext.tree.Panel": "tree grid", "Ext.ux.ComboBox": "combo", "Ext.ux.ComboBoxAdd": "combo (+ add new)",
    "Ext.form.field.ComboBox": "combo", "Ext.ux.CheckCombo": "multi-select combo", "Ext.form.field.Text": "text field",
    "Ext.form.field.TextArea": "text area", "Ext.form.field.Date": "date field", "Ext.form.field.Checkbox": "checkbox",
    "Ext.form.field.Radio": "radio", "Ext.form.field.Number": "number field", "Ext.ux.NumericField": "numeric field",
    "Ext.ux.NumericFieldWithAction": "numeric field (with action)", "Ext.form.field.File": "file field",
    "Ext.form.field.Time": "time field", "Ext.form.field.Display": "display field", "Ext.Window": "window",
    "Ext.window.Window": "window", "Ext.Button": "button", "Ext.button.Button": "button", "Ext.menu.Menu": "menu",
    "Ext.tip.ToolTip": "tooltip", "Ext.grid.CellEditor": "cell editor", "Ext.grid.plugin.CellEditing": "cell-editing plugin",
    "Ext.grid.plugin.RowEditing": "row-editing plugin", "Ext.panel.Panel": "panel", "Ext.form.Panel": "form",
    "Ext.tab.Panel": "tab panel", "Ext.toolbar.Toolbar": "toolbar", "Ext.container.Container": "container",
    "Ext.picker.Date": "date picker", "Ext.view.View": "data view", "Ext.chart.Chart": "chart",
}
XTYPE = {
    "datecolumn": "date column", "checkcolumn": "check column", "numbercolumn": "number column", "actioncolumn": "action column",
    "rownumberer": "row number", "treecolumn": "tree column", "templatecolumn": "template column", "gridcolumn": "column",
    "datefield": "date field", "textfield": "text field", "numberfield": "number field", "combo": "combo", "combobox": "combo",
    "checkbox": "checkbox", "menu": "menu", "menuseparator": "separator", "menuitem": "menu item", "button": "button",
    "tbtext": "toolbar text", "tbfill": "spacer", "tbseparator": "separator", "toolbar": "toolbar", "displayfield": "display field",
    "textareafield": "text area", "textarea": "text area", "panel": "panel", "container": "container", "form": "form",
    "tabpanel": "tab panel", "window": "window", "grid": "grid", "gridpanel": "grid", "fieldset": "field set",
    "radiogroup": "radio group", "checkboxgroup": "checkbox group", "hiddenfield": "hidden field", "hidden": "hidden field",
    "timepicker": "time picker", "datepicker": "date picker", "colorpicker": "colour picker", "tool": "tool button",
    "pagingtoolbar": "paging toolbar", "splitbutton": "split button", "cycle": "cycle button",
}
LABEL_KEYS = ["title", "fieldLabel", "text", "header", "boxLabel", "html", "tooltip"]
ATTR_KEYS = [("name", "name"), ("dataIndex", "field"), ("itemId", "itemId"), ("id", "id"), ("renderTo", "renders into"),
             ("store", "store"), ("displayField", "shows"), ("valueField", "value"), ("emptyText", "placeholder"),
             ("format", "format"), ("iconCls", "icon"), ("handler", "on click"), ("region", "region")]
FLAG_KEYS = [("allowBlank", False, "required"), ("readOnly", True, "read-only"), ("hidden", True, "hidden"),
             ("disabled", True, "disabled"), ("editable", False, "pick-only"), ("multiSelect", True, "multi-select"),
             ("modal", True, "modal"), ("checked", True, "checked")]


def kind_of(node):
    c = node.get("class")
    if c:
        return KIND.get(c, c if not c.startswith("Ext.") else c.split(".")[-1].lower())
    x = node.get("xtype")
    if isinstance(x, str):
        return XTYPE.get(x, x)
    if "dataIndex" in node or ("header" in node and "fieldLabel" not in node):
        return "column"
    if "fieldLabel" in node:
        return "field"
    if "text" in node and ("handler" in node or "menu" in node.get("children", {})):
        return "button"
    if "text" in node:
        return "item"
    return "component"


def clean(v):
    if isinstance(v, list):
        return ", ".join(str(x) for x in v)
    v = str(v)
    if v.startswith("@this."):
        v = v[6:]
    elif v.startswith("@"):
        v = v[1:]
    if v.startswith("fn:"):
        v = v[3:] + "()"
    if v.startswith("call:"):
        v = v[5:] + "(…)"
    return re.sub(r"<[^>]+>", "", v).strip()


def label_of(node):
    for k in LABEL_KEYS:
        v = node.get(k)
        if isinstance(v, str) and v and not v.startswith(("@", "call:", "fn")) and v not in ("expr",):
            return html.unescape(re.sub(r"<[^>]+>", "", v)).strip()[:120]
    for k in LABEL_KEYS:
        v = node.get(k)
        if isinstance(v, str) and v.startswith(("@", "call:")):
            return "{" + clean(v)[:60] + "}"
    return ""


def describe(node):
    parts = [f"**{kind_of(node)}**"]
    lab = label_of(node)
    if lab:
        parts.append(f"“{cell(lab, 120)}”")
    attrs = []
    for k, name in ATTR_KEYS:
        v = node.get(k)
        if v is None or v in ("fn", "expr") or (k == "handler" and v == "fn"):
            continue
        attrs.append(f"{name} `{cell(clean(v), 70)}`")
    for k, val, name in FLAG_KEYS:
        if node.get(k) is val:
            attrs.append(name)
    lay = node.get("layout")
    if isinstance(lay, (str, dict)) and lay:
        attrs.append("layout " + (lay if isinstance(lay, str) else cell(lay.get("type", ""), 30)))
    if attrs:
        parts.append("· " + " · ".join(attrs))
    return " ".join(parts)


def has_content(node):
    if any(isinstance(node.get(k), str) for k in LABEL_KEYS + ["name", "dataIndex", "renderTo", "emptyText", "itemId"]):
        return True
    return any(has_content(c) for kids in node.get("children", {}).values() for c in kids if isinstance(c, dict))


def column_table(cols, depth):
    pad = "  " * depth
    rows = [f"{pad}| Header | Field | Type | Width | Renderer / editor | Flags |", f"{pad}|---|---|---|---|---|---|"]
    for c in cols:
        if not isinstance(c, dict):
            continue
        if "ref" in c:
            rows.append(f"{pad}| {{{cell(clean(c['ref']), 40)}}} | | | | | |")
            continue
        width = c.get("width") or (f"flex {c['flex']}" if c.get("flex") is not None else "")
        ed = c.get("children", {}).get("editor") or c.get("children", {}).get("field")
        rend = clean(c["renderer"]) if isinstance(c.get("renderer"), str) and c.get("renderer") != "fn" else ""
        if ed and isinstance(ed[0], dict):
            rend = (rend + " · " if rend else "") + "edit: " + kind_of(ed[0])
        flags = [name for k, val, name in FLAG_KEYS if c.get(k) is val]
        if c.get("summaryType"):
            flags.append(f"total {c['summaryType']}")
        if c.get("locked"):
            flags.append("locked")
        sub = c.get("children", {}).get("columns")
        head = cell(label_of(c), 60)
        if sub:
            head += " (group: " + ", ".join(cell(label_of(s), 30) for s in sub if isinstance(s, dict)) + ")"
        typ = XTYPE.get(c.get("xtype"), c.get("xtype") or "")
        rows.append(f"{pad}| {head} | `{cell(c.get('dataIndex', ''), 40)}` | {typ} | {cell(width, 12)} | "
                    f"{cell(rend, 50)} | {', '.join(flags)} |")
    return rows


def render_node(node, depth, out, seen_depth=0):
    if depth > 12:
        return
    pad = "  " * depth
    if "ref" in node:
        out.append(f"{pad}- *(component built elsewhere: `{cell(clean(node['ref']), 60)}`)*")
        return
    out.append(f"{pad}- {describe(node)}")
    for key, kids in node.get("children", {}).items():
        if key == "columns" and any(isinstance(c, dict) and ("dataIndex" in c or "header" in c or "text" in c) for c in kids):
            out.append(f"{pad}  - columns:")
            out.append("")
            out.extend(column_table(kids, depth + 2))
            out.append("")
            continue
        if key in ("editor", "field") and len(kids) == 1:
            out.append(f"{pad}  - editor: {describe(kids[0]) if 'ref' not in kids[0] else clean(kids[0]['ref'])}")
            continue
        label = {"items": None, "tbar": "top toolbar", "bbar": "bottom toolbar", "fbar": "footer buttons",
                 "buttons": "buttons", "dockedItems": "docked", "menu": "menu", "tools": "header tools",
                 "lbar": "left toolbar", "rbar": "right toolbar", "columns": "columns"}.get(key, key)
        nd = depth + 1
        if label:
            out.append(f"{pad}  - *{label}:*")
            nd = depth + 2
        for c in kids:
            if isinstance(c, dict):
                render_node(c, nd, out)


def ui_section(bundle, entry, out):
    roots, seen = [], set()
    for r in entry.get("roots", []):
        if not has_content(r):
            continue
        key = json.dumps(r, sort_keys=True)
        if key in seen:
            continue
        seen.add(key)
        roots.append(r)
    defines = [d for d in entry.get("defines", []) if has_content(d)]
    if not roots and not defines:
        return 0
    grids = [r for r in roots if kind_of(r) in ("grid", "tree grid")]
    windows = [r for r in roots if kind_of(r) == "window"]
    fields = [r for r in roots if r not in grids and r not in windows and ("field" in kind_of(r) or "combo" in kind_of(r)
                                                                          or kind_of(r) in ("checkbox", "radio"))]
    rest = [r for r in roots if r not in grids and r not in windows and r not in fields]
    out.append(f"### `{bundle}`")
    out.append("")
    out.append(f"{len(grids)} grids · {len(fields)} standalone fields · {len(windows)} windows · "
               f"{len(rest)} menus, buttons and other parts · {len(defines)} custom components")
    out.append("")
    for title, group in [("Grids", grids), ("Windows and dialogs", windows), ("Fields", fields),
                         ("Menus, buttons and other parts", rest)]:
        if not group:
            continue
        out.append(f"#### {title}")
        out.append("")
        if title == "Fields":
            out.append("| Kind | Label | Renders into | Name / store | Details |")
            out.append("|---|---|---|---|---|")
            for f in group:
                det = [f"{n} `{cell(clean(f[k]), 40)}`" for k, n in ATTR_KEYS
                       if k in ("displayField", "valueField", "emptyText", "format") and f.get(k) is not None]
                det += [n for k, val, n in FLAG_KEYS if f.get(k) is val]
                out.append(f"| {kind_of(f)} | {cell(label_of(f), 60)} | `{cell(clean(f.get('renderTo', '')), 50)}` | "
                           f"`{cell(clean(f.get('name') or f.get('store') or ''), 50)}` | {cell(' · '.join(det), 120)} |")
            out.append("")
            continue
        for r in group:
            render_node(r, 0, out)
        out.append("")
    if defines:
        out.append("#### Custom components (`Ext.define`)")
        out.append("")
        for d in defines:
            head = f"- **`{d['define']}`** extends `{d.get('class', '?')}`"
            if d.get("alias"):
                head += f" · alias `{clean(d['alias'])}`"
            out.append(head)
            for key, kids in d.get("children", {}).items():
                tmp = {"children": {key: kids}}
                sub = []
                for k2, k3 in tmp["children"].items():
                    if k2 == "columns":
                        sub.append("  - columns:")
                        sub.append("")
                        sub.extend(column_table(k3, 2))
                        sub.append("")
                    else:
                        sub.append(f"  - *{k2}:*")
                        for c in k3:
                            if isinstance(c, dict):
                                render_node(c, 2, sub)
                out.extend(sub)
        out.append("")
    return len(roots) + len(defines)


def write_ui(d, title, pages, bundles, ui):
    """UI.md: the components each bundle builds, grouped by page."""
    out = [f"# {title}: UI", "",
           "Every component the page code builds, read from the shipped ExtJS bundles: grids with their columns, "
           "fields, buttons, menus, windows and custom components. Labels are the English UI text. "
           "`renders into` is the id of the `<div>` in the page's server-rendered HTML that the component mounts in; "
           "`store` names the data store (see the endpoints in [README.md](README.md)); `on click` is the handler. "
           "Visual system and shell layout: [docs/UI.md](" + "../" * (len(d.relative_to(OUT).parts) + 1) + "docs/UI.md).", ""]
    if pages:
        out += ["## Screens", "", "| Route | Title | Bundles |", "|---|---|---|"]
        for p in sorted(pages, key=lambda p: p["route"]):
            out.append(f"| `{p['route']}` | {cell(p['title'])} | " + ", ".join(f"[`{b}`](#{b.lower()})" for b in p["bundles"].split()) + " |")
        out.append("")
    lay = layout_section(d, pages)
    n = 0
    body = []
    for b in sorted(bundles):
        if b in ui:
            n += ui_section(b, ui[b], body)
    if not n and not lay:
        return False
    parts = out + lay
    if n:
        parts += ["## Components by bundle", "",
                  "What the page code builds and mounts into the layout's slots.", ""] + body
    (d / "UI.md").write_text("\n".join(parts) + "\n")
    return True


def outline_block(text):
    return ["```text", text.rstrip(), "```", ""]


def layout_section(d, pages):
    """The server-rendered HTML of each screen, as an outline, plus its own dialogs."""
    out = []
    if d.name == "01-shell" and LAYOUT["shell"]:
        out += ["## Layout: the shell on every page", "",
                "Top bar, navbar, left menu, floating action button and footer, from the page HTML.", ""]
        out += outline_block(LAYOUT["shell"])
        out += ["## Dialogs on most pages", ""]
        for m in sorted(SHELL_MODALS):
            if LAYOUT["modals"].get(m):
                out += [f"### `{m}`", ""] + outline_block(LAYOUT["modals"][m])
    shown = [p for p in sorted(pages, key=lambda p: p["route"]) if p["route"] in LAYOUT["pages"]]
    if not shown:
        return out
    out += ["## Layout", "",
            "Each screen's server-rendered HTML inside the shell, as an outline: headings, tabs, sections, labels, "
            "inputs (`#id`), buttons (`▾` = dropdown), menus, tables and `slot`s (empty `<div>`s the components "
            "below mount into). `(hidden)` parts are shown by the page code when needed. Read with GET from a "
            "signed-in session; no values are kept.", ""]
    for p in shown:
        L = LAYOUT["pages"][p["route"]]
        out += [f"### `{p['route']}`: {L.get('title') or p['title']}", ""]
        if L.get("final") and L["final"].split("?")[0] != p["route"]:
            out += [f"Redirects to `{L['final'].split('?')[0]}`.", ""]
        if L.get("iframe"):
            out += [f"Frame: `{L['iframe']}`.", ""]
        out += outline_block(L.get("outline") or "(empty)")
        own = [m for m in L.get("modals", []) if m not in SHELL_MODALS and LAYOUT["modals"].get(m)]
        if own:
            out += ["Dialogs on this page:", ""]
            for m in own:
                out += [f"<details><summary><code>{m}</code></summary>", ""] + outline_block(LAYOUT["modals"][m]) + ["</details>", ""]
    return out


# ---------------------------------------------------------------- module pages

def write_unit(d, title, about, pages, models, eps, public, reports, ui, bundles, extra=None, depth=1):
    d.mkdir(parents=True, exist_ok=True)
    up = "../" * depth
    has_ui = write_ui(d, title, pages, bundles, ui)
    L = [f"# {title}", "", about, ""]
    n_write = sum(1 for e in eps if "write" in e["effect"])
    L += ["| | Count |", "|---|---:|",
          f"| Pages | {len(pages)} |", f"| Data models | {len(models)} (plus [shared]({up}00-shared/README.md)) |",
          f"| Internal endpoints | {len(eps)} ({n_write} write) |", f"| Public API operations | {len(public)} |"]
    if reports:
        L.append(f"| Reports | {len(reports)} |")
    L.append("")
    if extra:
        L += extra
    L += ["## How to rebuild it", ""]
    steps = []
    if models:
        steps.append(f"**Schema.** Create one table per data model below ({len(models)}), starting from the generated "
                     "[`schema.sql`](schema.sql). Ids are GUIDs; join on the `*ID` fields.")
    if eps:
        steps.append("**Internal API.** Implement each controller's endpoints with the verbs listed, following the "
                     f"[internal API contract]({up}../docs/INTERNAL-API.md): one URL per store for GET/POST/PUT/DELETE, "
                     "paged reads returning `{root, total}`, saves wrapped as `{ID, HasErrors, Original, Updated}`.")
    if pages:
        steps.append("**Screens.** Build each route below as a server-rendered shell that loads the shell bundle and "
                     "the page's own app, opening a record from `#<guid>` once at load "
                     f"([page model]({up}../docs/ARCHITECTURE.md#what-a-page-is))."
                     + (" Every grid, column, field, button and dialog is in [UI.md](UI.md)." if has_ui else
                        " Its page code builds no ExtJS components; the screen is server-rendered HTML."))
    if public:
        steps.append(f"**Public API.** Expose the {len(public)} operations below under `/ExternalApi/v2` with "
                     f"header auth ([public API contract]({up}../docs/PUBLIC-API.md)).")
    if reports:
        steps.append("**Reports.** Each report is a pivot grid over the columns listed, served by the report "
                     f"service ([`21-report-service`]({up}21-report-service/README.md)).")
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
        groups = sorted({r["group"] for r in public})
        L += ["## Public API (`/ExternalApi/v2`)", "",
              "Fields, parameters and body shapes: " + " · ".join(
                  f"[{g}]({up}20-public-api/groups/{slugify(g)}.md)" for g in groups) + ".", "",
              "| Group | Method | Path | Query / params |", "|---|---|---|---|"]
        for r in sorted(public, key=lambda r: (r["group"], r["path"], r["method"])):
            L.append(f"| {r['group']} | {r['method']} | `{r['path']}` | {cell(r['query'] or r['params'])} |")
        L.append("")

    if reports:
        filters = json.load(open(DATA / "report-filters.json")) if (DATA / "report-filters.json").exists() else {}
        std = {"RequestID", "Search", "LayoutName", "OperationName", "layoutName", "operationName", "IsResetGridViewPageIndex"}
        L += ["## Reports, their filters and columns", "",
              "Every report's callback sends `RequestID`, `Search`, `LayoutName` and `OperationName` "
              "([protocol](" + up + "21-report-service/README.md)); **Filters** lists the extra parameters each one sends, "
              "with the control that supplies it.", "",
              "| Report | Title | Script | Filters | Columns |", "|---|---|---|---|---|"]
        for r in sorted(reports, key=lambda r: r["name"]):
            f = filters.get(r["script"], {})
            fl = {**{k: v for k, v in f.get("params", {}).items() if k not in std}, **f.get("extra", {})}
            ftxt = ", ".join(f"`{k}`" + (f" ({cell(v, 30)})" if v and v != k else "") for k, v in fl.items())
            L.append(f"| `{r['name']}` | {cell(r['title'])} | `{r['script']}` | {cell(ftxt, 400)} | {cell(', '.join(r['columns']), 900)} |")
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


def shape_lines(sh, depth=0):
    pad = "  " * depth
    out = []
    if isinstance(sh, dict):
        if "_keys" in sh:
            return [pad + "keys: " + ", ".join(sh["_keys"])]
        for k, v in sh.items():
            if isinstance(v, dict):
                out.append(f"{pad}{k}: {{")
                out += shape_lines(v, depth + 1)
                out.append(pad + "}")
            elif isinstance(v, list) and v and isinstance(v[0], dict):
                out.append(f"{pad}{k}: [")
                out += shape_lines(v[0], depth + 1)
                out.append(pad + "]")
            elif isinstance(v, list):
                out.append(f"{pad}{k}: [{v[0] if v else ''}]")
            else:
                out.append(f"{pad}{k}: {v}")
    elif isinstance(sh, list):
        if sh and isinstance(sh[0], dict):
            out.append(pad + "[")
            out += shape_lines(sh[0], depth + 1)
            out.append(pad + "]")
        else:
            out.append(pad + str(sh))
    else:
        out.append(pad + str(sh))
    return out


def field_table(t):
    if t.get("kind") == "values":
        L = [f"#### {t['model']}", "", "| Value | Meaning |", "|---|---|"]
        L += [f"| `{cell(f['name'], 60)}` | {cell(f['type'], 200)} |" for f in t["fields"]]
        return L + [""]
    L = [f"#### {t['model']}", "", "| Field | Type | Length | Required | Allowed values |", "|---|---|---|---|---|"]
    for f in t["fields"]:
        req = f.get("required", "")
        vals = ", ".join(f"`{v}`" for v in f.get("values", []))
        typ = f["type"] + (" (read-only)" if f.get("read_only") else "")
        L.append(f"| `{cell(f['name'], 60)}` | {cell(typ, 60)} | {cell(f.get('length', ''), 10)} | {cell(req, 10)} | {cell(vals, 400)} |")
    return L + [""]


def write_api_groups():
    """modules/20-public-api/groups/<group>.md: fields, parameters and body shapes per API group."""
    path = DATA / "public-api-shapes.json"
    if not path.exists():
        return {}
    d = json.load(open(path))
    gdir = OUT / "20-public-api" / "groups"
    gdir.mkdir(parents=True, exist_ok=True)
    links = {}
    for name, g in d["groups"].items():
        if not g["operations"] and not g["tables"]:
            continue
        slug = slugify(name)
        links[name] = slug
        L = [f"# Public API: {name}", "",
             "From Cin7's API Blueprint: field tables (name, type, length, required, allowed values), each "
             "operation's query parameters, and request and response bodies as type outlines (`guid`, `string`, "
             "`number`, `boolean`, `date`, `null`; `[ … ]` = array of). Base `/ExternalApi/v2`; headers in "
             "[docs/PUBLIC-API.md](../../../docs/PUBLIC-API.md).", ""]
        if g.get("resources"):
            L += ["**Resources:** " + " · ".join(f"`{r['path']}`" for r in g["resources"]), ""]
        if g["tables"]:
            L += ["## Fields", ""]
            for t in g["tables"]:
                L += field_table(t)
        L += ["## Operations", ""]
        for o in g["operations"]:
            L += [f"### {o['method']} `{o['path'].split('?')[0] or '/'}`" + (f" ({o['title']})" if o["title"] not in (o["method"], "") else ""), ""]
            if o["params"]:
                L += ["| Parameter | Type | Required |", "|---|---|---|"]
                L += [f"| `{p['name']}` | {cell(p['type'], 40)} | {'yes' if p['required'] else ''} |" for p in o["params"]]
                L.append("")
            for key, label in [("request", "Request body"), ("response", "Response 200")]:
                if o.get(key) is not None:
                    L += [f"{label}:", "", "```text"] + shape_lines(o[key]) + ["```", ""]
            for key in sorted(k for k in o if k.startswith("response_")):
                L += [f"Response {key.split('_')[1]}:", "", "```text"] + shape_lines(o[key]) + ["```", ""]
        (gdir / f"{slug}.md").write_text("\n".join(L) + "\n")
    if d.get("models"):
        L = ["# Public API: shared models and value lists", ""]
        for t in d["models"].values():
            L += field_table(t)
        (gdir / "models.md").write_text("\n".join(L) + "\n")
    if d.get("webhooks"):
        L = ["# Webhook payloads", "",
             "The body Cin7 POSTs for each event, as a type outline. Delivery: up to 6 attempts (1, then 5, 10, 15, 20 "
             "and 25 minutes apart), after which the webhook is deactivated; at most 5 webhooks of one type. "
             "Subscriptions can carry extra headers (`ExternalHeaders`).", ""]
        for typ, sh in d["webhooks"].items():
            L += [f"## `{typ}`", "", "```text"]
            L += (shape_lines(sh) if not (isinstance(sh, list) and sh and isinstance(sh[0], str)) else ["keys: " + ", ".join(sh)])
            L += ["```", ""]
        (gdir / "webhooks.md").write_text("\n".join(L) + "\n")
    return links


API_LINKS = {}


def write_front_ends():
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
        screens = FRONT_ENDS / "screens" / f"{slug}.md"
        if screens.exists():
            (d / "SCREENS.md").write_text(screens.read_text())
            L += ["Every screen, its fields, buttons, lists, dialogs and API calls: [SCREENS.md](SCREENS.md).", ""]
        if src:
            rows = [r for r in csv.DictReader(open(DATA / src)) if r.get("group") != "group"]
            L += [f"## Every call ({len(rows)})", "", "| " + " | ".join(cols) + " |", "|" + "---|" * len(cols)]
            for r in rows:
                L.append("| " + " | ".join(f"`{cell(r[c])}`" if i == 0 or c == "path" else cell(r[c])
                                           for i, c in enumerate(cols)) + " |")
            L.append("")
        (d / "README.md").write_text("\n".join(L))


# ---------------------------------------------------------------- main

def load():
    endpoints = list(csv.DictReader(open(DATA / "endpoints.csv")))
    pages = list(csv.DictReader(open(DATA / "pages.csv")))
    public = [r for r in csv.DictReader(open(DATA / "public-api.csv")) if r["group"] != "group"]
    models = json.load(open(DATA / "models.json"))
    ui = json.load(open(DATA / "ui.json"))
    if (DATA / "report-ui.json").exists():
        ui.update({f"report-service/{k}": v for k, v in json.load(open(DATA / "report-ui.json")).items()})
    reports = []
    for line in open(DATA / "report-columns.txt"):
        parts = [p.strip() for p in line.split(" ~ ")]
        if len(parts) == 4:
            reports.append({"name": parts[0], "script": parts[1], "title": parts[2], "columns": parts[3].split("|")})
    return endpoints, pages, public, models, ui, reports


def main():
    endpoints, pages, public, models, ui, reports = load()
    if (DATA / "layout.json").exists():
        LAYOUT.update(json.load(open(DATA / "layout.json")))
        counts = defaultdict(int)
        for L in LAYOUT["pages"].values():
            for m in set(L.get("modals", [])):
                counts[m] += 1
        SHELL_MODALS.update(m for m, c in counts.items() if c >= SHELL_MODAL_SHARE * max(1, len(LAYOUT["pages"])))
    section_slug = {sec: slug for slug, sec, _, _ in MODULES if sec is not None}

    # Units: each module, plus one per integration ("12-integrations/<slug>").
    integ_pages = [p for p in pages if p["section"] == "Integrations" and p["route"] != "/Integrations"]
    integ_slug = {}
    for p in integ_pages:
        name = re.sub(r"\s*~\s*$", "", p["title"]).strip() or p["route"].strip("/")
        integ_slug[p["route"]] = "12-integrations/" + slugify(name)

    def page_unit(p):
        if p["route"] in MRP_ROUTES:
            return "16-mrp"
        if p["route"] in integ_slug:
            return integ_slug[p["route"]]
        return section_slug.get(p["section"], "15-other")

    pages_by = defaultdict(list)
    bundle_units = defaultdict(set)
    for p in pages:
        u = page_unit(p)
        pages_by[u].append(p)
        for b in p["bundles"].split():
            bundle_units[b].add(u)

    ep_by = defaultdict(list)
    for e in endpoints:
        units = []
        if MRP_URL.search(e["url"]):
            units = ["16-mrp"]
        else:
            secs = split_sections(e["sections"]) or [""]
            for sec in secs:
                slug = section_slug.get(sec, "15-other")
                if slug == "12-integrations":
                    owner = next((integ_slug[r] for r in e["pages"].split() if r in integ_slug), "12-integrations/_common")
                    units.append(owner)
                else:
                    units.append(slug)
            if MRP_INPUT_URL.search(e["url"]):
                units.append("16-mrp")
        for u in dict.fromkeys(units):
            ep_by[u].append(e)

    module_of = lambda u: u.split("/")[0]
    models_by = defaultdict(list)
    shared = []
    for name, m in sorted(models.items()):
        units = set()
        for b in m.get("bundles", []):
            units |= bundle_units.get(b, set())
        mods = {module_of(u) for u in units}
        if len(mods) >= SHARED_MODEL_LIMIT or not units:
            shared.append((name, m, mods))
        else:
            for u in units:
                models_by[u].append((name, m))

    pub_by = defaultdict(list)
    for r in public:
        pub_by[PUBLIC_GROUPS.get(r["group"], "13-settings")].append(r)

    bundles_by = defaultdict(set)
    for b, units in bundle_units.items():
        if b in SHELL_BUNDLES or len({module_of(u) for u in units}) >= SHARED_MODEL_LIMIT:
            bundles_by["01-shell"].add(b)
        else:
            for u in units:
                bundles_by[u].add(b)
    for b in ui:
        if b not in bundle_units:
            bundles_by["11-reports" if "Report" in b else ("01-shell" if b.startswith("Main") else "15-other")].add(b)

    if OUT.exists():
        for child in OUT.iterdir():
            if child.is_dir():
                shutil.rmtree(child)
    OUT.mkdir(exist_ok=True)

    index = []
    integ_index = []
    for slug, sec, title, about in MODULES:
        extra = None
        if slug == "12-integrations":
            units = sorted({u for u in list(pages_by) + list(ep_by) if u.startswith("12-integrations/")})
            extra = ["## Integrations", "", "| Integration | Page | Endpoints | Data models |", "|---|---|---:|---:|"]
            for u in units:
                pg = pages_by.get(u, [])
                ttl = re.sub(r"\s*~\s*$", "", pg[0]["title"]) if pg else "Shared integration endpoints"
                extra.append(f"| [{ttl}]({u.split('/')[1]}/README.md) | {', '.join('`' + p['route'] + '`' for p in pg)} | "
                             f"{len(ep_by.get(u, []))} | {len(models_by.get(u, []))} |")
                integ_index.append((u, ttl))
            extra.append("")
        eps = ep_by.get(slug, [])
        pgs = pages_by.get(slug, [])
        mdl = models_by.get(slug, [])
        pub = pub_by.get(slug, [])
        reps = reports if slug == "11-reports" else []
        if slug == "16-mrp":
            reps = [r for r in reports if "MRP" in r["name"]]
        n_eps = len(eps) + (sum(len(ep_by.get(u, [])) for u, _ in integ_index) if slug == "12-integrations" else 0)
        index.append((slug, title, len(pgs), len(mdl), n_eps, len(pub)))
        write_unit(OUT / slug, title, about, pgs, mdl, eps, pub, reps, ui, bundles_by.get(slug, set()), extra)

    for u, ttl in integ_index:
        about = (f"The {ttl} connector: its settings page, mappings, logs and the endpoints behind them. "
                 "Part of [Integrations](../README.md).") if not u.endswith("_common") else \
            "Integration endpoints that no single connector page claims (shared by several, or by the catalogue)."
        write_unit(OUT / u, ttl, about, pages_by.get(u, []), models_by.get(u, []), ep_by.get(u, []), [], [], ui,
                   bundles_by.get(u, set()), depth=2)

    write_shared(shared)
    write_front_ends()
    write_api_groups()
    write_relationships(models)
    write_index(index, len(shared))


def write_index(index, n_shared):
    L = ["| Module | Pages | Models | Internal endpoints | Public API ops |", "|---|---:|---:|---:|---:|",
         f"| [00 Shared data models](00-shared/README.md) | | {n_shared} | | |"]
    for slug, title, p, m, e, pub in sorted(index):
        L.append(f"| [{slug[:2]} {title}]({slug}/README.md) | {p} | {m} | {e} | {pub} |")
    for slug, title in [("20-public-api", "Public API and webhooks"), ("21-report-service", "Report service"),
                        ("22-pos", "POS"), ("23-wms", "WMS handheld app"), ("24-mes", "MES shop-floor app"),
                        ("25-portals", "B2B and RMA portals")]:
        L.append(f"| [{slug[:2]} {title}]({slug}/README.md) | | | | |")
    (OUT / "README.md").write_text("# Modules\n\nOne folder per module, each with `README.md` (what it is, how to "
                                   "rebuild it, pages, models, endpoints), `UI.md` (every screen's components) and "
                                   "`schema.sql`. Integrations have one subfolder each. Generated by "
                                   "`tools/generate.py`; 20–25 are hand-written.\n\n" + "\n".join(L) + "\n")


if __name__ == "__main__":
    main()
