# UI: visual system, shell and components

How Cin7 Core looks and is put together on screen, read from the shipped CSS (`corecontent.dearsystems.com/css/app_css`,
755 KB) and page bundles. Each module's `UI.md` lists the components of its own screens.

## How a screen is assembled

1. The server renders the page HTML: the shell (top bar and menu), the page header, Bootstrap tabs, form groups,
   buttons, modals and empty `<div id="div…">` slots.
2. The page bundle builds ExtJS components and mounts each one into its slot with `renderTo: '<div id>'`. Grids,
   combos, date fields and numeric fields are ExtJS; labels, tabs, buttons and modals are Bootstrap HTML.
3. Stores load from `/api/…`; grids page and sort on the server.

So rebuilding a screen takes both halves: the HTML layout (header, tabs, sections, buttons) and the components listed in
the module's `UI.md`, which name the slot they mount in (`renders into`).

Both halves are in each module's `UI.md`: **Layout** is the server-rendered HTML of every screen as an outline (headings,
tabs, sections, labels, inputs, buttons, menus, tables, dialogs and the `slot`s components mount into), and **Components
by bundle** is what the page code builds. The shell's own layout (top bar, add-new menu, left menu, appearance settings,
profile menu, footer) is in [`modules/01-shell/UI.md`](../modules/01-shell/UI.md). Layouts were read with GET from a
signed-in session on 2026-10-24 (260 of 261 routes; `/AMA` streams and was skipped) and keep no field values.

## Stack

| Layer | What |
|---|---|
| Widgets | ExtJS 4 (grids, combos, date and number fields, trees, windows, menus, tooltips) |
| Layout and chrome | Bootstrap (navbar, tabs, modals, dropdowns, form groups, buttons) with Cin7's own `design2019` styles |
| Reports | DevExpress pivot grids (report service) |
| Charts | ExtJS charts on the dashboard; DevExpress in reports |
| Uploads | Dropzone (bundled into document pages) |
| Phone inputs | intl-tel-input (`iti-*` classes) |
| Real time | SignalR (notifications and chat) |

## Custom widgets (`Ext.ux`)

| Widget | Extends | Use |
|---|---|---|
| `Ext.ux.ComboBox` | `Ext.form.field.ComboBox` | The standard lookup (989 uses): remote type-ahead over a store |
| `Ext.ux.ComboBoxAdd` | `Ext.form.field.ComboBox` | Lookup with an "add new" entry that opens a create dialog |
| `Ext.ux.CheckCombo` | `Ext.form.field.ComboBox` | Multi-select with checkboxes |
| `Ext.ux.NumericField` | `Ext.form.field.Number` | Locale-formatted numbers with set decimal precision |
| `Ext.ux.NumericFieldWithAction` | `Ext.ux.NumericField` | Numeric field with an inline action button |
| `Ext.ux.TextWithButton`, `Ext.ux.TextWithButtonInGrid` | `Ext.form.field.Text` | Text field with a trailing button, standalone or as a grid editor |
| `Ext.ux.CheckColumn` | `Ext.grid.column.Column` | Grid checkbox column |

Grid conventions: cell editing via `Ext.grid.plugin.CellEditing`, `RenderHTMLText` and `RenderDate(value, UserDateFormat)`
renderers, date formats from the user's settings (`UserDateFormat`), and an `emptyText` message on every grid.

## Typography

| | |
|---|---|
| Typeface | **IBM Plex Sans** (self-hosted `@font-face`), fallback `sans-serif`. Monospace: `"Courier New", Courier` |
| Body sizes | 13px and 12px most common; 14px for inputs and body copy; 11px for grid headers and meta |
| Headings | 16px, 18px (page header, weight 500), 20–22px, 26px |
| Grid column header | 11px, bold, uppercase, letter-spacing −0.4px, colour `#707887` |

## Colour

Users pick a theme; each theme sets the accent colour (`.theme-<name>` on the page). Ten themes:

| Theme | Accent | Hover / pressed |
|---|---|---|
| `theme-default` (teal) | `#05cbbf` | `#04beb3`, `#00afa5` |
| `theme-blue` | `#0e6cf8` (top bar `#00527c`) | `#0058db`, `#0046ae` |
| `theme-green` | `#00c064` | `#00a154`, `#008043` |
| `theme-violet` | `#6a56c9` | `#5540bb`, `#3b279a` |
| `theme-persian` | `#01a48e` | |
| `theme-cobalt` | `#044fb2` | |
| `theme-indigo` | `#4a007c` | |
| `theme-night` | `#303030` | |
| `theme-cyan`, `theme-grey` | (same pattern) | |

Neutrals and states (shared by all themes):

| Use | Colour |
|---|---|
| Text | `#3b3b3b`; secondary `#6f6f6f`, `#707887`, `#595959` |
| Borders and rules | `#e0e1e7`, `#e7e8ec`, `#b5b9c2`, `#b9bdce` |
| Surfaces | `#ffffff`; panels `#f0f2f4`, `#f4f6fb`, `#f1f6fb` |
| Error / danger | `#fd4a4a` on `#fee8e8` |
| Warning | `#ffa901` |
| Success tint | `#d6f3e3`; info tint `#d6e3f3` |
| Shadows | `rgba(0,0,0,.2)` and lighter |

Primary button: white text on the theme accent, `min-width: 70px`.

## Shape and spacing

- Corner radius: 6px (cards and inputs), 4px (buttons), 3px (chips), 50% (avatars and status dots).
- Tabs: a 40px row, left-aligned, 1px `#e0e1e7` bottom rule.
- Modal header: flex row, 18px × 20px padding.
- Breakpoints: 1200, 991, 768, 640, 481 and 424px. The app is desktop-first; under 991px the menu collapses to a burger.

## Icons

Two icon fonts, `icons_2019` and `add_icons_2019` (`/content/design2019/fonts/icons/`). Classes are `icon19-<name>`; there are
129 glyph classes in [`data/icons.json`](../data/icons.json). Among them: `add`, `add-circle`, `attach`, `bill`, `calendar`,
`calculator`, `chart_bar`, `chart_line`, `chart_pie`, `clock`, `close`, `copy`, `credit-card`, `customize`, `discount`, `edit`,
`envelope`, `export`, `eye`, `family`, `file-download`, `filter`, `help`, `history`, `image`, `import`, `info_outlined`, `list`,
`lock`, and the status set `not-status_ordered`, `not-status_pick`, `not-status_pack`, `not-status_invoice`,
`not-status_fullfiled`.

## The shell

Every page shares the shell from `Main2019` ([`modules/01-shell`](../modules/01-shell/README.md)); its full HTML outline
is in [`modules/01-shell/UI.md`](../modules/01-shell/UI.md). In short:

- **Top bar:** logo, the main menu (one dropdown per module), global search, favourites and quick links, notifications
  (count badge, SignalR), chat, help widget, and the user menu (profile, organisation switch, language, sign out).
- **Page header:** the screen title, a status badge on documents, and the action buttons (save, authorise, void, print,
  more).
- **Body:** Bootstrap tabs for documents (for example Order → Pick → Pack → Ship → Invoice on a sale) and the ExtJS grids
  and fields mounted in each tab.
- **Footer:** activity log and comments on documents.
- **Session:** a timeout warning dialog; one web session per login.

## Main menu

From the menu as the app renders it. Detail pages (a single sale, supplier and so on) are opened from their lists.

| Menu | Items |
|---|---|
| Dashboard | Dashboard · Setup guide |
| Sale | Sales · Simple sale · Advanced sale · Service sale · Awaiting sale · Sale credit note · Customers / Credits · Bulk payment (customers) · Recurring sales · Fulfillment orders · RMAs · Return orders · Warranties · Discount |
| Purchase | Purchases · Simple purchase · Advanced purchase · Service purchase · Purchase credit note · Suppliers · Supplier deposits · Bulk payment (suppliers) · Reorder · Reorder backordered · Supplier lead/safety values · Latest product price by supplier |
| Inventory | Product/Service/Asset · Product families · Availability · Stocktake/adjustments · Stock adjustment · Stocktake · Transfers · Batch/lot recall · Print the products price list · Gift cards · MRP |
| Production | Production orders · Scheduler · Capacity Planner · MRP scheduler · Production resource · Factory calendar · Setup · Assemblies · Disassemblies · Jobs · Inventory write-offs |
| Financials | Money tasks (receive, spend, transfer) · Journals · Expense claims · Receipts · Fixed assets · Depreciations · Bank account · Bank rule · Bank statement · Cin7 Pay · Cin7 Capital |
| CRM | Leads · Opportunities · Deal · Tasks |
| AI | Ask AI · Document data extraction |
| Reports | Reports (catalogue of 86) · Scheduled reports |
| Integrations | Integration catalogue (one page per connector) |
| Settings | General settings · Users and roles · Document and email templates · Automation · Automated workflows · Notification settings · Mailing list · Reminders · Task settings · Reference books · User profile · My subscription · Marketplace |
| Settings › Reference books | Locations and bins · Chart of accounts · Account mapping · Accounting dimensions · Bank accounts · Taxation rules · Payment terms · Carriers · Shipping zones · Brands · Product categories · Units of measure · Attribute sets · Discounts · Order routing · Company addresses · Company contacts · Default field values (customer, product, supplier) · Expense items · Fixed asset types · Lead statuses · Deals · Opening balances · RMA reasons and policy · Return order settings · Warranty setup · Cin7 Core to Cin7 Core networking |
