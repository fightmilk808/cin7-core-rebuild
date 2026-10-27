# MRP business rules (Cin7 Core)

Rules for module 16 (MRP run list, run settings, scheduler) of the sandbox. Screens, fields and tables come from
`spec/modules/16-mrp/` (README.md, UI.md, schema.sql); this file adds the behaviour the map does not record.
Settings that live elsewhere are named here and owned by `rules/settings.md`.

## How to read this file

**Sources.** The public Cin7 Core help center, read in full (the MRP articles plus every related article on supply
rules, reorder, production, permissions and forecasting), the API map, the repo spec (`spec/`) and
`rules/mrp-client.md` (what Cin7's own page scripts decide in the browser). The Cin7 Core API v2 has no MRP endpoints
(the map tools list only internal web-app `/api/MRP_*` routes, which are described, never sent). Nothing was run
against the live app. The server-side calculation is not published anywhere, so the netting arithmetic, rounding
and date maths below stay marked [INFER] or [ASSUME] and are listed at the end.

Tags:

- **[DOC]** stated in a help-center article. The article is named by its key (S1 to S4 are the main MRP articles).
- **[HELP]** stated in a related help article (reorder, products, production) and applied to MRP here.
- **[CLIENT]** decided by Cin7's page scripts, as read in `rules/mrp-client.md` (the section there is named).
- **[API]** read from the API v2 spec, the map tools or the repo spec (`spec/`).
- **[INFER]** deduced from other rules. Medium-low confidence.
- **[ASSUME]** a sandbox default chosen because nothing publishes it. Re-listed in the last section.

`(corrected)` marks a rule an earlier draft of this file got wrong. Article text is paraphrased throughout.

### Source key

| Key | URL |
|---|---|
| S1 | https://help.core.cin7.com/hc/en-us/articles/9735447858703-Material-Requirements-Planning-MRP |
| S2 | https://help.core.cin7.com/hc/en-us/articles/9735470547215-Material-Requirements-Planning-for-Production |
| S3 | https://help.core.cin7.com/hc/en-us/articles/11073292991375-MRP-settings |
| S4 | https://help.core.cin7.com/hc/en-us/articles/9034516955791-Location-supply-rules-and-transfer-planning |
| S5 | https://help.core.cin7.com/hc/en-us/articles/10553627492239-Set-reorder-parameters |
| S6 | https://help.core.cin7.com/hc/en-us/articles/10553610466575-Generate-reorder-suggestions (describes the Inventory Velocity Report path, not MRP) |
| S7 | https://help.core.cin7.com/hc/en-us/articles/12047242513039-Configure-product-suppliers |
| S8 | https://help.core.cin7.com/hc/en-us/articles/9034476290447-Nested-production-orders-production-BOM-explosion |
| S9 | https://help.core.cin7.com/hc/en-us/articles/11073310369679-Purchase-process-customization-settings (holds "Minimum before reorder specified for"; an earlier draft cited General settings for this) |
| S10 | https://help.core.cin7.com/hc/en-us/articles/9034604405007-User-permissions-explained |
| S11 | https://help.core.cin7.com/hc/en-us/articles/9034569289359-Sales-demand-forecast-report |
| S12 | https://help.core.cin7.com/hc/en-us/articles/9034524048911-Production-Scheduler (a different Gantt for production orders; it is NOT the MRP Scheduler, which is described only in S1 and the client file) |
| S13 | https://help.core.cin7.com/hc/en-us/articles/11759857982095-Production-BOM-settings |
| S14 | https://help.core.cin7.com/hc/en-us/articles/9034486934031-Inventory-Velocity-Report |
| S15 | `spec/modules/16-mrp/README.md`, `UI.md`, `schema.sql` (repo) |
| S16 | `spec/modules/20-public-api/groups/product.md`, `reference-books.md` (repo; API v2 shapes) |
| S17 | `rules/mrp-client.md` (repo; Cin7's page scripts; cited as [CLIENT] with its section number) |
| S18 | https://help.core.cin7.com/hc/en-us/articles/11073293006991-Production-process-customization-settings |
| S19 | https://help.core.cin7.com/hc/en-us/articles/9034480843919-Co-manufacturing-outsourcing-parts-of-the-production-process |
| S20 | https://help.core.cin7.com/hc/en-us/articles/17647517073295 (Calculation of Available, On Hand and Allocated stock quantity) |
| S21 | https://help.core.cin7.com/hc/en-us/articles/9034517938191-Manufacturing-Buffer |
| S22 | https://help.core.cin7.com/hc/en-us/articles/11282074309007-Manage-roles |

---

## ⚠️ Gotchas: the sneaky stuff

The easy-to-miss behaviours, worst first. `CAUTION` = silently corrupts data, cost or stock, is irreversible, or fails silently. `WARNING` = a surprising rule that breaks a rebuild if missed. `NOTE` = the sources are silent or disagree. Each links to the full rule below.

> [!CAUTION]
> **Voiding a confirmed supply order voids the real document, and nothing recalculates**
> Void in the Results tab voids the purchase, transfer, production or assembly order it created; the row shows VOIDED and the order goes back to suggestions, but demand is not refreshed until someone presses Recalculate [DOC, CLIENT]. See [section 6, rule 58](#6-create-orders-confirm).

> [!CAUTION]
> **Options hidden by another option are saved as false, with no message**
> Choosing a customer hides and unticks "Ignore stock on hand/on order", transfer-draft demand and assembly-draft demand, and the form saves them as false [CLIENT]. "Ignore stock" is only offered when a customer is chosen at all [DOC]. See [section 3.3](#3-run-settings-screen-mrp).

> [!CAUTION]
> **Complete closes the run for everyone, and only one run can be active**
> A completed run is read-only and other users cannot continue it; there can be one active run at a time, so a stale open run blocks a new one [DOC, CLIENT]. See [section 7](#7-run-lifecycle).

> [!CAUTION]
> **Draft and planned supply is not "on order" by default**
> Unless "Include draft and planned supply orders" is on, orders you already drafted are not counted as supply and you get duplicate suggestions [DOC]. See [section 2.2](#22-supply-sources).

> [!CAUTION]
> **Supply is counted from any date, not only the planning period**
> By default supply from before and after the planning period is netted against demand inside it, so a purchase due next quarter hides a shortage this week. A separate "Exclude future supply" option limits it [DOC]. See [section 2.2, rule 11a](#22-supply-sources).

> [!WARNING]
> **MRP only works when "Minimum before reorder specified for" is "Each location"**
> The article does not say which value is the default, so check the setting rather than assuming a fresh account is ready [DOC]. See [section 1, rule 3](#1-what-an-mrp-run-is).

> [!WARNING]
> **A run is a frozen snapshot, and Recalculate is the only refresh**
> Stock, sales and orders changed after the run, and Scheduler data after the period ends, are not reflected. The help text also says Recalculate is available only after an edited supply order has been confirmed, a gate the page script does not enforce [DOC, CLIENT]. See [section 1, rule 6](#1-what-an-mrp-run-is) and [section 7](#7-run-lifecycle).

> [!WARNING]
> **"Procure up to" forces overdue demand on, and ticking overdue demand ticks "Authorized" sales**
> The two Procure up to boxes are mutually exclusive, tick and lock "Include overdue demand", and cannot be combined with "Ignore stock". The target is held every day, so day one can already show a gap [DOC, CLIENT]. See [section 3.5](#3-run-settings-screen-mrp).

> [!WARNING]
> **No supply rule or no supplier means no suggestion; co-manufacturing ignores supplier values**
> Uncovered demand shows red in the Scheduler with a reason. For a co-manufacturing location the supplier comes from the work center and product-supplier lead and reorder values are ignored (lead time and stock level are treated as 0) [DOC]. See [section 2.3](#23-parameters-from-products-suppliers-and-locations).

> [!WARNING]
> **Production and assembly demand covers first-level components only, and nested orders are Draft**
> Nested components need BOM explosion; explosion skips labour resources, and auto-assembled components yield no assembly suggestion. Orders confirmed from a production BOM and their nested orders are created as Draft in the nested-orders article, while the MRP-for-production article creates top-level orders as Planned [DOC]. See [section 2.5](#25-bom-explosion-and-nested-boms).

> [!WARNING]
> **Confirming one product confirms the whole order; merge is purchase-only and refuses invoiced or received lines**
> In the Scheduler, confirming one product of a multi-product suggestion confirms the whole order. Merge needs the same supplier and location and excludes purchases with invoice or stock-received lines [DOC, CLIENT]. See [section 6](#6-create-orders-confirm).

> [!WARNING]
> **"Load demand with details" caps at 2 weeks and 100 products**
> The Scheduler exists only for details runs, so a longer period or bigger catalogue gets no Scheduler [DOC]. See [section 3.1](#3-run-settings-screen-mrp).

> [!WARNING]
> **The planning period cannot start before today, and a saved parameter set carries its dates**
> "This week" starts today, not on Monday, and reloading a saved set can bring back stale dates and forecast [DOC, CLIENT]. See [section 3.2](#3-run-settings-screen-mrp).

> [!NOTE]
> **Netting, rounding, date arithmetic and safety days are a design, not published behaviour**
> Only the aggregate formula (independent plus dependent demand minus supply) and the stock-level target are documented. Errors in the Errors tab never block Confirm. See [Unclear / docs disagree](#unclear--docs-disagree).

---

## 1. What an MRP run is

1. MRP is a paid add-on. It compares demand (sales and other consumers) with supply (stock on hand, transfers,
   production, assembly, suppliers) for a planning period and produces a list of suggested supply orders. [DOC] S1
   Accounts that subscribed before 1 February 2024 keep the access level they had. [DOC] S1, S2 Without the add-on the
   run page is read-only and offers a 30-day trial (see 9, rule 72). [CLIENT] 1
2. A run **only suggests**. It never creates an order by itself. Orders appear only when the user confirms
   suggestions (the button is labelled Confirm/Reorder). [DOC] S1, S4
3. The General-settings option "Minimum before reorder specified for" must be **Each location** to use MRP. The
   setting lives under Purchase process customization; its two values are "All product units" and "Each location".
   [DOC] S1, S2, S4, S9 (see `rules/settings.md` G-42). No article says which value a new account starts with
   (corrected: the earlier draft called "All product units" the default).
4. A run is started from Inventory > MRP (route `/MRP`); past and active runs are listed at `/MRPList` (columns
   MRP run, Created by, Date, Status). [DOC] S1 · [CLIENT] 13
5. A run has a number (shown as `#<number>`), a creator, a created date and a status. The status values the page
   script tests are **Active**, **Running**, **Recalculating**, **Completed** and **Failed**. A Failed row cannot be
   opened. [CLIENT] 1, 13 (corrected: the earlier draft invented Calculated)
6. A run is a snapshot: demand and supply are read when the run is calculated and are not refreshed afterwards. The
   only way to refresh a run (and its Scheduler) is **Recalculate**. [DOC] S1
7. Run parameters can be saved as a named set and reused. [DOC] S1 · [API] S15 (`vMRPSettings`) · [CLIENT] 2.6
8. The run list shows **active and completed** runs; there can be only **one active run at a time**. Clicking an
   active run continues planning. [DOC] S1
9. Deleting a run does **not** delete the supply orders already created from it. [DOC] S1

## 2. Inputs

### 2.1 Demand sources

Demand is what must be covered at a location by a required-by date. S1 splits it into **independent demand** (confirmed
sales, draft sales if chosen, and stock-level targets if chosen; computed without looking at existing supply) and
**dependent demand** (demand created by another item, for example Retail replenished from Warehouse creates demand in
Warehouse). A task can be both supply and demand. [DOC] S1

| Source | Counted when | Notes |
|---|---|---|
| Sales orders | "Sales" source: All, Authorized, Not authorized (a radio-style group) | Confirmed sales always form independent demand; draft sales are optional [DOC] S1. Date = required-by date; location = the order's location [INFER]. |
| Production order components | "Production": include draft / planned / released | Components of the BOM become demand at the production location. [DOC] S1 |
| Assembly order components | "Assembly": include draft / released | Same idea for assembly BOMs. Assembly has no planned status. [DOC] S1 · [CLIENT] 2.1 |
| Transfer orders | "Transfer": include draft | Demand at the source location [INFER]. |
| Forecast | "Include forecast demand" and an uploaded forecast | Lines carry demand location, SKU, name, quantity, required-by date [CLIENT] 2.5; shown as `demand.forecast` in the details panel [CLIENT] 3.2. |
| Stock-level target | "Procure up to" options (3.5) | A standing target level, not a dated order. Included in the planning period by default, as are tasks with no required-by date. [DOC] S1 |
| Overdue demand | "Include overdue demand" | Demand dated before the planning-period start. [DOC] S1 (labelled "past due" in the help text; the UI label is "overdue"; same option) |

7. Production and assembly demand is **dependent demand** (components); sales and forecast are **independent
   demand**. The Scheduler shows both. [DOC] S1
8. Choosing production or assembly as a demand source produces suggestions for the **direct components only**.
   Nested (sub-assembly) components are suggested only if BOM explosion is on. [DOC] S1, S2
9. The date at which a production order's components become demand is chosen by the account setting "Production
   demand calculation date": **Release date** uses the order's release date when it has one and otherwise the
   required-by date (a draft or planned order has no release date); **Required by date/planned date** uses the
   required-by date when capacity is calculated backwards from it and the planned date when capacity is calculated
   forwards. [DOC] S3 (see `rules/settings.md` G-98). The article does not name a default (corrected: the earlier draft
   called Planned/required the default; kept as the sandbox default [ASSUME]).
10. Quotes, voided/cancelled orders and completed orders are not demand. [INFER] (the help text only names confirmed
    and draft sales)
10a. A sale-demand choice is mandatory when a customer is selected ("Please select sales demand for chosen
    customers"); with a customer chosen, every supply and demand-source parameter is filtered to that customer. [DOC]
    S1 · [CLIENT] 2.4
10b. A run needs at least one demand source, a forecast, or a Procure up to option; otherwise it will not start.
    [CLIENT] 2.4
10c. Demand-detail lines carry a type: sale, transfer, production, assembly, forecast, stock level (real demand);
    virtual transfer, virtual production, virtual assembly, "BOM components" (dependent demand from suggested orders);
    and supply types purchase, transfer, production, assembly, stock on hand. [CLIENT] 3.2

### 2.2 Supply sources

| Source | Counted when |
|---|---|
| Stock on hand | Always, unless "Ignore stock on hand/on order" is on (which is offered only with a customer, see 3.3). [DOC] S1 |
| Open purchase orders (on order) | Authorized quantity not yet received. [DOC] S1 |
| Open production and assembly orders | Authorized orders count as on order. [DOC] S1 (S1 also treats them as supply that can cover sales) |
| Open transfer orders / stock in transit | Authorized transfers count as on order at the destination. [DOC] S1 |
| **Draft and planned** supply orders | Not part of "On Order". Counted only if "Include draft and planned supply orders" is on; these can supply demand at one location while creating it at another. [DOC] S1 |

S1 gives the aggregate view: existing supply = stock on hand + stock on order + draft supply orders (optional); total
demand = independent demand + dependent demand - supply; suggested supply is the quantity of suggested orders that
meet that demand. [DOC] S1

11. Supply is netted **per location** because the module requires "Each location" mode. [DOC] S1 · [INFER]
11a. By default supply of **any date**, past or future, counts against demand regardless of the planning period. An
    "Exclude future supply" option limits supply to orders whose required-by date is inside the period. The page script
    passes it from the Demand report to the details panel; it is not a field on the run form. [DOC] S1 · [CLIENT] 3.1
11b. The help text says "stock on hand". On Hand includes goods on unfulfilled sales and Available is On Hand minus
    Allocated. [DOC] S20 Because sales are counted separately as demand, subtracting allocations as well would count
    them twice, so the sandbox nets against **on hand** and not against available. [INFER] (corrected: the earlier draft
    used available)
12. The location scope of a run is the **Location** setting (multi-select) with a synthetic **Every location** entry,
    which is the default and is mutually exclusive with named locations. Demand and supply are calculated for the
    chosen locations. [DOC] S1 · [CLIENT] 2.1, 2.3 (corrected: an empty list is not the default)
13. The Customer setting (multi-select) restricts sales demand, and all supply and demand-source parameters, to those
    customers; empty means all customers. [DOC] S1 · [CLIENT] 2.1

### 2.3 Parameters from products, suppliers and locations

| Input | Where it lives | Role |
|---|---|---|
| Minimum before reorder, reorder quantity | Product header and per-location **Reorder levels** (`ReorderLevels[]` with `LocationID`, `MinimumBeforeReorder`, `ReorderQuantity`) [API] S16 | Target level with "Procure up to". Location values beat the product header; the header is used when a location has no row. [DOC] S1 |
| Lead time (days) | Per supplier and location: `ProductSupplierOptions[].Lead` [API] S16 | Days from raising and submitting the order to delivery. [HELP] S5 |
| Safety (days) | `ProductSupplierOptions[].Safety` [API] S16 | Preferred minimum days of inventory. [HELP] S5 |
| Reorder quantity, minimum to order | `ReorderQuantity` and `MinimumToReorder` on the supplier option [API] S16 | How many to order at a time, and the smallest quantity the supplier accepts. [HELP] S5 |
| Supply rules | Per location, `TenantLocationEdit_vSupplyRule` [API] S15 | Tell MRP how to cover a product at that location (2.3a). [DOC] S4 |
| Transfer plan | Per location (Transfer planning tab) | When stock is moved between locations (2.3b). [DOC] S4 |
| Location calendar | `MRPScheduler_LocationCalendar` [API] S15 | Drives weekend and holiday shading in the Scheduler. [CLIENT] 12.2 (use in dating: [INFER]) |
| Lead and safety import/export | `LeadSafetyValues_List`, `/LeadSafetyValues/Import`, `/Export` [API] S15 | Bulk edit of the values above; also reachable as Products > Export/Import > Reorder parameters. [HELP] S5 · [CLIENT] 10.3 |
| Production BOM "Ignore cumulative lead time" | Production BOM Settings tab | Unchecked: component lead time comes from the product's Suppliers tab values. Checked: a manual lead time in days entered on the BOM (`ComponentProductionLeadTime`). Also a manufacturing buffer percentage on production time. [DOC] S13, S21 |

14. Suppliers with several locations inherit the supplier's lead, safety and reorder values by default, and each
    location may override them. [HELP] S5 When both exist the **location value wins** and a product with neither cannot
    be suggested; S6 states this priority for the Velocity-report reorder path, and S1 lists missing supplier, lead time,
    reorder quantity or stock as the cause of Errors-tab entries. Applied to MRP by [INFER]. (corrected tag: the
    priority list is not an MRP statement)
15. For a co-manufacturing location, product-supplier lead, reorder and minimum-before-reorder values are ignored;
    lead time and stock level are 0, and the run's purchase-order-supplier setting is ignored. The supplier is the one
    on the co-manufacturing work center. [DOC] S4
16. A product with no supply rule at the demand location cannot be covered: the demand shows red in the Scheduler and
    hovering gives the reason, for example "no supply rule to cover this demand". [DOC] S1
17. A purchase suggestion needs a supplier on the product; a product without one is not suggested and is reported on
    the Errors tab. [DOC] S4, S1

### 2.3a Supply rules (per location)

18a. A location can have several rules. A rule covers all products or a selection by family, tag, category, brand or
    single products. Within a group the match is OR, across groups AND. When several rules fit a product the priority
    is Family, Tag, Category, Brand; a rule for specific groups beats an all-products rule; two rules cannot have
    identical product parameters; only one active rule may apply to all products. [DOC] S4 · [CLIENT] 10.4
18b. A rule is an ordered list of actions tried in turn; if one cannot run, the next is tried. A final "if demand is
    still not fulfilled" action can be transfer, production, purchase, or nothing. [DOC] S4 · [CLIENT] 10.4
18c. **Transfer** action: supply location, how much stock may be taken (all available; up to stock level = minimum
    before reorder + reorder quantity; up to minimum before reorder), and how much of the demand to cover (All
    required: the rule fails if the full amount is not there; Partial: transfer what is available, then continue to the
    next rule). As the final action a transfer is suggested regardless of availability, which creates demand at the
    supply location. [DOC] S4
18d. **Produce** action: a shop-floor location and a minimum free-capacity percentage; if capacity is too low the rule
    fails and the next runs. It applies only to products with a production or assembly BOM, always adds a transfer of
    the finished goods back to the demand location, and capacity does not apply to assembly orders. As the final
    action it produces regardless of capacity. [DOC] S4 · [CLIENT] 10.4
18e. **Purchase** action: supplier criterion Lowest price, Lowest lead time or Latest supplier; it suggests a purchase
    for the remaining quantity. The run setting "Purchase order supplier" (3.9) offers the same three plus "Set up for
    supply rule". [DOC] S4 · [CLIENT] 2.1
18f. Co-manufacturing locations accept only transfer and purchase rules, and a rule is required there for MRP to
    suggest anything. [DOC] S4

### 2.3b Transfer planning

18g. A transfer plan is per location and per demand location: **Transfer at intervals** (every N days from a start
    date, the first delivery on the start date, all days treated as working days) or **Transfer on fixed days** (chosen
    weekdays). Several plans can exist. It sets the date of transfer suggestions: the suggestion is dated on a planned
    transfer day before the demand. [DOC] S4 · [CLIENT] 10.5 (the article's worked example uses inconsistent dates;
    the weekday logic is what it shows)
18h. Transfer suggestions are not authorized automatically: the user authorizes them. The run setting for the
    status of created transfers offers Draft or Ordered, so choosing Ordered is the user's explicit act. [DOC] S4 ·
    [CLIENT] 6.1 (corrected: the earlier draft stated only the first half)

### 2.4 Netting order and priority

The documentation gives the aggregate formula (2.2) and the cascade of supply rules (2.3a) but no processing order.
The sandbox order below is [INFER], consistent with the entity structure in the client (virtual orders produce
dependent component demand).

18. Process products from the **top-level** (finished goods) down the BOM when BOM explosion is on, so that
    components' dependent demand exists before they are netted. [INFER] S8 · [CLIENT] 3.2
19. For each product and location, sort demand and supply by date and net day by day (projected on-hand, 4.1).
    The Scheduler does show independent demand, dependent demand, current supply and suggested supply per day or week,
    so dated netting exists; its exact order is not published. [INFER] · [CLIENT] 12.2
20. Stock on hand is used first, then authorized open supply (by due date), then draft/planned supply when
    included. Anything left is a net requirement. [INFER]
21. Which kind of supply covers a net requirement follows the **supply rule cascade** of the demand location (2.3a).
    [DOC] S4
22. Within purchase, the supplier is chosen by the supply rule's criterion or by the run's "Purchase order supplier"
    setting (3.9). [DOC] S4 · [CLIENT] 2.1

### 2.5 BOM explosion and nested BOMs

23. BOM explosion **on**: production and assembly BOMs are broken down level by level; every nested level gets its
    own demand and its own suggestion. Turning explosion on forces the "released" production and assembly demand
    options on. [DOC] S1, S8 · [CLIENT] 2.3
23a. S1's own three-case summary for a sale of 5 tables: (1) production demand off, no explosion: only "produce 5
    tables"; (2) production demand on, no explosion: also suggestions for first-level components; (3) explosion on:
    also suggestions for nested components. [DOC] S1
23b. Explosion applies to components only, never to labour resources. BOMs with auto-assembly/disassembly generate
    suggestions for the components delivered to the assembly location and do **not** generate an assembly-order
    suggestion for the auto-assembled product. [DOC] S1, S2
24. BOM explosion **off**: only the top-level product is suggested. Recommended two-step workflow: step one, explosion
    off, create the production orders in **Planned** status, rearrange them in the Capacity Planner and do not release
    them; step two, explosion on with planned production orders as a demand source, confirm the component suggestions,
    optionally consolidate, then release. [DOC] S2
25. Component quantity = parent quantity x BOM line quantity. Yield or wastage handling is not described in any MRP
    article. [INFER] S13
26. Nested suggestions are linked to their parent: a suggestion carries a `ProductBOM` value (Production BOM or
    Assembly BOM) and `MrpSupplySuggestionID` on its product rows. [API] S15 · [CLIENT] 4
27. Component demand is dated by the parent's required-by date minus component lead/production time. With "Ignore
    cumulative lead time" unchecked the component lead time comes from the product's supplier values; checked, from
    the BOM's own field. [DOC] S13, S21 · [INFER] for how it shifts the demand date
28a. Nested orders created from an MRP production suggestion are all created as Draft; this path needs the production
    process setting "Create production order" set to the MRP/reorder-suggestions option. [DOC] S8 · [CLIENT] 10.1
28b. Minimum, maximum, deviation and run-size settings on a production BOM are described as applying to automatically
    created orders from sales. Whether MRP-confirmed orders honour them is not stated. [DOC] S13

---

## 3. Run settings (screen `/MRP`)

Defaults are what "Reset settings" restores in the page script [CLIENT] 2.1; the help articles state no defaults.

| # | Control | Field (`vMRPSettings`) | Allowed values | Default | Rule |
|---|---|---|---|---|---|
| 3.1 | Load demand with details | `IsLoadDetails` | on/off | off | Shows how independent demand, dependent demand and suggestions were calculated, turns the Demand-tab quantities into links to a detail view, and enables the Scheduler. **Limits: planning period up to 2 weeks and up to 100 products.** The app estimates load time and asks the user to confirm; the user is notified when background calculation finishes. [DOC] S1 |
| 3.2 | Planning period | `PlanningPeriodStart`, `PlanningPeriodEnd` | This week, Next week, This month, Next month, or From/To dates | none; required | Start and end are both included. **Cannot be in the past.** Demand inside the period is planned; demand before the start is overdue (3.4). "This week" and "This month" start today. [DOC] S1 · [CLIENT] 2.2 |
| 3.3 | Ignore stock on hand/on order | `IsIgnoreStockOnHand` | on/off | off | **Offered only when a customer is selected.** On: the customer's demand is not netted against current stock or stock on order (S1's example: a 5-chair sale with 2 on hand and 3 on order gives demand 5 when ticked, 0 when not). Ticking it unticks and disables both Procure up to boxes. [DOC] S1 · [CLIENT] 2.3 (corrected: not a global switch) |
| 3.4 | Include overdue demand | `IsIncludePastDueDemand` | on/off | off | Demand whose required-by date is before the planning start is taken into account. Ticking it also ticks the "Authorized" sales source. Where on the timeline overdue demand lands is not stated; the sandbox puts it on day 1 [INFER]. [DOC] S1 · [CLIENT] 2.3 |
| 3.5 | Procure up to | `IsProcureUpToStockLevel`, `IsProcureUpToMinimumBeforeReorder` | one of the two, or neither | off, off | **Stock level**: target = minimum before reorder + reorder quantity, held every day regardless of other demand. **Minimum before reorder**: target = minimum only (avoids overstock on slow movers). Location rows beat the product header. If the suggested purchase is below the reorder quantity the user gets a warning but can continue. The two boxes are mutually exclusive, and either one ticks and locks "Include overdue demand". [DOC] S1 · [CLIENT] 2.3 (corrected: the earlier draft allowed both) |
| 3.6 | Include draft and planned supply orders | `IsIncludeDraft` | on/off | off | Draft and planned transfer, production, purchase and assembly orders are not "On Order"; on = count them as supply. [DOC] S1 |
| 3.7 | BOM explosion | `IsBomExplosion` | on/off | off | See 2.5. Forces production and assembly "released" demand on. [DOC] S1, S2 · [CLIENT] 2.3 |
| 3.8 | Include forecast demand | `IsIncludeForecast`, `ForecastID`, `SalesForecastTemplateName` | on/off; one saved forecast | off | Adds uploaded forecast lines as demand. The forecast can come from the Sales demand forecast report exported as CSV and uploaded here. [DOC] S11 · [CLIENT] 2.5 |
| 3.9 | Purchase order supplier | `SupplyTask` (int) | Set up for supply rule; With the lowest price; With the lowest lead time; Latest supplier | `0` (Set up for supply rule) | Chooses the supplier when a product has several. Ignored for co-manufacturing locations. The integers for the last three are not published. [CLIENT] 2.1 · [DOC] S4 (same three criteria on a purchase action) |
| 3.10 | Demand source: Sales | `DemandSales` | All, Authorized, Not authorized | none selected | A radio-style group: ticking one unticks the others. The stored value `Authorised` is the only one the script names. Not-authorized most likely means draft sales [INFER]. [CLIENT] 2.1, 2.3 · [DOC] S1 (corrected: not independent checkboxes) |
| 3.11 | Demand source: Production / Assembly / Transfer | `IsDemandProductionDraft/Planned/Released`, `IsDemandAssemblyDraft/Released`, `IsDemandTransferDraft` | each on/off | all off | Which order statuses feed component demand. Assembly has no "planned". With a customer chosen the transfer-draft and assembly-draft options are hidden and saved as false. [DOC] S1 · [CLIENT] 2.1, 2.3 (corrected defaults) |
| 3.12 | Supply order status | `SupplyTaskPurchaseStatus`, `SupplyTaskTransferStatus`, `SupplyTaskProductionOrderStatus`, `SupplyTaskAssemblyStatus` | Purchase: Draft, Awaiting approval, Ordered. Transfer: Draft, Ordered. Production: Draft, Planned. Assembly: Draft, Authorized | Draft for all | Status given to orders created when suggestions are confirmed; it is also editable per suggestion row. "Awaiting approval" exists only when the account has order approval turned on. [DOC] S1 · [CLIENT] 2.1, 6.1 |
| 3.13 | Consolidate suggestions by source | `ConsolidationType` | on/off (stored as the text `purchase`) | off | **Purchase orders** from the same supplier to the same location are merged into one, using the earliest required-by date. It is purchase-only. The same merge can be done later from the Suggested supply orders tab. [DOC] S1 · [CLIENT] 2.1 (corrected: not for transfers or production) |
| 3.14 | Location, Customer | `Locations[]`, `Customers[]` (rows linked by `MRPSettingsID`) | multi-select | Every location; no customer | Scope filters (2.2). [DOC] S1 · [CLIENT] 2.1 |
| 3.15 | Saved settings | `ID`, `Name` | named sets | none | Dropdown of saved sets; **Save as** stores the current values under a unique name (up to 256 characters); **Reset settings** restores defaults; **Delete settings** removes a set. The saved record includes the planning period and forecast because the code meant to strip them does nothing. Whether other users see the sets is not stated [ASSUME]. [DOC] S1 · [CLIENT] 2.6 |

28. The sandbox must enforce: the 3.1 limits (period <= 14 days, <= 100 products) before a "details" run starts.
    [DOC] S1
29. "Ignore stock on hand/on order" and "Procure up to" cannot both be on: ticking Ignore stock clears and locks both
    Procure up to boxes. [CLIENT] 2.3 (corrected: the earlier draft let both be on)
30. The two Procure up to options cannot both be on, so no precedence rule is needed. [CLIENT] 2.3 (resolves an
    earlier open question)
31. Settings in 3.9 to 3.13 shape the suggestion only at calculation. Changing them after a run requires
    **Recalculate**. [DOC] S1 (recalculate is the only refresh)
32. Each supply order status list is a closed list; a value outside it is rejected. [CLIENT] 6.1
33a. A run needs a planning period (`Please select the planning period range.`), the end cannot be in the past,
    start cannot be later than end, and at least one demand source, forecast or Procure up to option must be chosen.
    [CLIENT] 2.2, 2.4

---

## 4. How a suggestion line is computed

A suggestion is one product at one demand location, covered by one supply kind from one source, with a quantity,
a required-by date and an order (document) date.

### 4.1 Daily netting per product and location

The documented core is the aggregate formula in 2.2 and the daily "held every day" stock-level target. [DOC] S1
The day-by-day projection below is the sandbox's model of it. [INFER]

For each day *t* in the planning period (plus the overdue bucket on day 1 when 3.4 is on):

```
gross requirement(t)  = sales demand(t) + component demand(t) + transfer demand(t) + forecast(t)
scheduled receipts(t) = open supply due on t (authorized; plus draft/planned if 3.6)
projected on-hand(t)  = projected on-hand(t-1) + scheduled receipts(t) - gross requirement(t)
projected on-hand(0)  = stock on hand now            (0 when 3.3 is on)
target(t)             = 0                             (no Procure up to)
                      = minimum before reorder        (3.5 minimum only)
                      = minimum + reorder quantity    (3.5 stock level)
net requirement(t)    = max(0, target(t) - projected on-hand(t))  before any new suggestion
```

When `net requirement(t) > 0` a suggestion is raised for day *t* and projected on-hand is lifted by the suggested
quantity from the receipt date. Because supply of any date counts (rule 11a), `scheduled receipts` includes orders
outside the period unless "Exclude future supply" is used. [DOC] S1 · [INFER]

### 4.2 Suggested quantity

```
raw      = net requirement
qty      = max(raw, minimum to order)
qty      = ceil(qty / order multiple) x order multiple        (order multiple = reorder quantity)
```

- No MRP article describes rounding. The fields exist: minimum to order is the smallest quantity a supplier accepts
  and reorder quantity is how many to order at a time. [HELP] S5, S7 The min-then-round-up order and treating reorder
  quantity as a multiple are [INFER].
- Round **up**, never down. [INFER]
- With "Procure up to minimum before reorder", a suggested quantity below the reorder quantity gives a warning that
  the user may dismiss. [DOC] S1

### 4.3 Worked example (made-up numbers, purchase)

An illustration of the sandbox model above, not a Cin7 result.

Product CHAIR, location Main, supplier A. Product reorder levels at Main: minimum before reorder 20, reorder
quantity 10. Supplier option: lead 7 days, safety 0, minimum to order 20. Run: planning period day 1 to day 14,
Procure up to **Stock level** on, no customer, BOM explosion off.

| Item | Value |
|---|---|
| Stock on hand day 1 | 12 |
| Authorized PO, due day 5 | +10 |
| Sale SO-A, due day 3 | 8 |
| Sale SO-B, due day 9 | 25 |
| Target level (Stock level) | 20 + 10 = 30 |

Day by day (projected on-hand before any new suggestion):

| Day | Receipts | Demand | Projected on-hand | Target | Net requirement |
|---|---|---|---|---|---|
| 1 | 0 | 0 | 12 | 30 | 18 |
| 3 | 0 | 8 | 4 | 30 | 26 |
| 5 | 10 | 0 | 14 | 30 | 16 |
| 9 | 0 | 25 | -11 | 30 | 41 |

The target is held every day [DOC] S1, so day 1 already has a gap of 18. Processing in date order, with each
suggestion raising later projections:

1. Day 1 gap 18 -> raw 18; minimum to order 20 -> 20; multiple of 10 -> 20. Suggest **20**. Receipt cannot arrive
   before day 1 + lead 7 = day 8, so days 1 to 7 stay below target (reported as uncovered shortfall; the order date
   is the period start, see 4.4).
2. Re-net with +20 on day 8: day 9 projected = 14 + 20 - 25 = 9; target 30; gap 21 -> raw 21, min 20, round up to
   multiple of 10 -> **30**. Second suggestion for day 9.

Result: two suggested purchase lines for CHAIR: 20 and 30, total 50. Projected on-hand after day 9 = 9 + 30 = 39, above
the target of 30; the 9 over target comes from rounding up to the 10-unit multiple.

Without "Procure up to" (target 0): day 3 projected 4, day 9 projected -11, so the one suggestion is 11, raised to the
minimum order 20, rounded to 20. With "Minimum before reorder" only: target 20; day 1 gap 8, raised to 20 by the
minimum order. [INFER]

### 4.4 Dates

```
required-by date  = date the net requirement occurs (demand date; target gaps use the day of the shortfall)
order date        = required-by date - lead time (days)
                    pushed to a working day of the location calendar, and never before today
```

- The suggestion row shows the required-by date and, for purchase and production, a second muted date (order date for
  a purchase, release date for a production order). A release date is the date components and resources are
  available to start production. Transfer and assembly rows show one date. [CLIENT] 4.1
- In the Scheduler a suggested purchase bar is as long as the supplier lead time for that product, supplier and
  location (falling back to the supplier's all-locations value, else 0). **Safety days are not used for the bar.**
  [CLIENT] 12.2
- Example: need on day 9, lead 7 -> order date day 2. If the order date falls before today it is set to today and
  the row is flagged late. [INFER]
- Safety days: **no MRP article describes how safety days are applied.** Safety is defined as the preferred minimum
  days of inventory [HELP] S5, and the Velocity report formula is sales velocity x (safety + lead) - available - on
  order [HELP] S6, S14; that formula belongs to the reorder-report path, not MRP. The sandbox does not shift MRP dates by
  safety days. [ASSUME]
- For production the order date is the production start (required-by minus production time, plus the manufacturing
  buffer percentage on the BOM); for transfers it is the planned transfer day (2.3b). [DOC] S4, S21 · [INFER] for the
  combination
- Required-by dates are editable on the grid only when the row's changed flag is set (for example after the order
  type is switched); a date before today is refused. [CLIENT] 6.4 (corrected: the earlier draft called the date always
  editable)

### 4.5 Which supply kind and source

| Supply rule action at demand location | Suggestion |
|---|---|
| Purchase | Purchase order line. Supplier by the rule's criterion or 3.9. [DOC] S4 |
| Transfer (from another location) | Transfer order from the supply location. Date by the transfer plan. [DOC] S4 |
| Produce | Production order with the product's production BOM, plus a transfer of finished goods back to the demand location. [DOC] S4, S2 |
| Assembly BOM product | Assembly order; capacity is not checked for assembly. [DOC] S4 |

33. A product without a rule for the demand location is not covered (red in the Scheduler, with a reason on hover;
    errors may appear on the Errors tab). [DOC] S1
34. A transfer suggestion creates dependent demand for the same product at the source location, so the source is
    netted too. [DOC] S1 (Retail/Warehouse example)
34a. Suggestion rows let the user change the order type before confirming: a purchase row can become a transfer, and a
    one-product row can become production or assembly when the product has that BOM; changing type clears the
    supplier/source, resets the status to the run default and sets the order date to the required-by date. Production
    rows offer only shop-floor locations. [CLIENT] 6.2, 6.3

### 4.6 Location calendar

35. The Scheduler loads a location calendar (weekend flags, holidays, week start) so non-working days can be shaded.
    Weekends default to Saturday and Sunday. Transfer-at-intervals plans treat every day as a working day. [CLIENT]
    12.2 · [DOC] S4 · whether purchase and production dates skip non-working days is [INFER]

---

## 5. Run output screen (`/MRP` after Run)

The result area has five tabs. [CLIENT] 3

| Tab | Contents |
|---|---|
| **Demand** | A Report Service grid with one line per product and location: independent demand, dependent demand, supply, total demand (independent + dependent - supply) and suggested supply. Searchable by SKU, product name and location; Export gives CSV. With "Load demand with details" the values are links to a detail panel listing the individual orders. [DOC] S1 · [CLIENT] 3.1, 3.2 (corrected: not one row per demand line) |
| **Suggested supply orders** | Expandable grid of suggestions (`vSupplySuggestion`), see below. |
| **Results** | The "Confirmed supply orders": orders created from suggestions, read-only with a link to the order (Supply task number, Total QTY, Demand, Supply, Required by date, Status, Created by, Created at, and a Void action). Empty text: "You have not created any supply orders at the moment." [DOC] S1 · [CLIENT] 8 |
| **Errors** | Column "Error description". Sub-tabs Critical, Warning, Information appear for current-version runs. Empty: "No supply errors." [CLIENT] 9 |
| **Activity log** | Action, Supply order, Demand in, Supply from/buy from, User, Date/time. [CLIENT] 9 |

### 5.1 Suggested supply orders tab

36. Columns: expander, validation icon, select box, Supply order (type), Products (Split products button), Demand in,
    Supply from/buy from (editable), Required by date, Status (editable). [CLIENT] 4.1
37. Search covers product name, demand location, supply location/supplier and required-by date. Filters: Products
    (families, categories, brands, tags or specific products), Demand location, Supply location/supplier, Supply
    order type; "Show products" expands product details; Reset all filters. [DOC] S1 · [CLIENT] 4.2 to 4.4
38. A suggested order can hold **several products**. Expanding it lists product, quantity and unit of measure.
    [DOC] S1 · [CLIENT] 4.1
39. Buttons: **Confirm**, **Merge**, **Recalculate**, **Export** (CSV with the full product list per suggestion), and per
    order **Split products**. [DOC] S1 · [CLIENT] 4.2
40. A suggestion's status is the status the order will have once confirmed (from 3.12, editable per row); a confirmed
    suggestion moves to the Results tab. [DOC] S1
41. **Errors never block Confirm.** The Errors tab is diagnostic: Critical = a critical setting is missing and results
    will be unexpected or wrong; Warning = a setting is missing and some results may be wrong; Information = an
    optional setting is missing and nothing is affected. Typical causes named: supplier, lead time, reorder quantity or
    stock not set. A row can carry its own validation error (for example empty supplier or status) which blocks
    confirming that row. [DOC] S1 · [CLIENT] 6.7 (corrected: the earlier draft said Critical blocks confirming)

### 5.2 Errors, warnings and information (sandbox classification)

The three levels are defined in 41. The assignment of concrete conditions below is a sandbox choice. [ASSUME]

| Level | Examples |
|---|---|
| Critical | no supply rule for the demand location; purchase needed but product has no supplier; no lead/reorder value at location or supplier level |
| Warning | suggested quantity below reorder quantity; order date earlier than today; demand could not be dated |
| Information | demand ignored by settings; supply skipped because of status filters |

### 5.3 Scheduler (`/MRPScheduler`)

42. Opened from the run (button "View Scheduler", shown for an active run loaded with details). Available **only** when
    "Load demand with details" was on. Limits: planning period <= 2 weeks, <= 100 products. [DOC] S1 · [CLIENT] 1
    (S12 is the separate production Scheduler and does not describe this one)
43. The Scheduler is a **Gantt view of the run, not a recurring job**: no frequency, time of day or recipients, and its
    only persistence is view settings in the browser. [CLIENT] 12
44. Two tabs. **Supply vs demand**: calendar of independent demand, dependent demand, current supply and suggested
    supply, one location at a time, days or weeks; uncovered demand in red with the reason on hover. **Supply orders**:
    Gantt of authorized supply orders and suggestions (when "Show suggestions" is on) by order type, showing status and
    lead time (the longest lead time when an order has several products). [DOC] S1 · [CLIENT] 12
45. View options: horizontal/vertical lines, show unused days, suggestions, supply days, weekends; scale Day or Week;
    collapse/expand groups; fullscreen; filters Order type (All, Purchase, Transfer, Assemblies, Production),
    Location, text search. The Gantt is read-only (no dragging). [CLIENT] 12.3
46. Suggestions can be confirmed from the Scheduler; confirming one product of a multi-product suggestion confirms the
    **whole order**. [DOC] S1 · [CLIENT] 6.7
47. Scheduler data is not refreshed when the period ends; Recalculate is the only refresh. [DOC] S1

---

## 6. Create orders (Confirm)

48. **Confirm** creates real documents from the selected suggestions. Nothing is created without the user pressing
    Confirm. [DOC] S1, S4 · [CLIENT] 6.7
49. Document created by supply kind: purchase order, transfer order, production order, assembly order, with the status
    on the row (3.12). [DOC] S1, S2 · [CLIENT] 6.1
50. A confirmed production BOM suggestion creates a production order, and the nested assembly and production orders
    for its components are created as Draft. S2 instead creates the top-level orders in Planned when the user chooses
    that status. The sandbox gives the top-level order the status on the row and nested orders Draft. [DOC] S8, S2 ·
    [CLIENT] 2.1 (the interaction is still partly open, see Unclear)
51. Transfers are not authorized automatically unless the chosen status is Ordered (2.3b, rule 18h). [DOC] S4 ·
    [CLIENT] 6.1
52. Grouping: one document per suggestion row. With 3.13 on, purchase rows from the same supplier to the same
    location are merged first, using the earliest required-by date. [DOC] S1 · [CLIENT] 2.1
53. Quantities, product and dates copy from the suggestion; the supplier's price, currency and terms come from the
    product supplier record as for a normal purchase. [INFER]
54. Created documents are recorded in the run's Results tab (`vSupplyResult`: `TaskID`, `TaskNumber`, `TaskType`,
    `TotalQuantity`, `TaskStatus`, `CreatedBy`, `CreatedAt`). Documents link to Purchase, Stock transfer, Finished goods
    (assembly) or Production order. [API] S15 · [CLIENT] 8
55. After creating, a suggestion leaves the Suggested tab and appears under Results; the activity log gets a row.
    [DOC] S1 · [CLIENT] 9
56. **Merge**: only purchase orders, at least two rows, the **same supplier and the same demand location**; the earliest
    required-by date becomes the suggestion's date. Purchase orders with invoice lines or stock-received lines cannot
    be merged. [DOC] S1 · [CLIENT] 6.8 (corrected: location also must match; invoiced/received exclusion added)
57. **Split products** divides one suggested order into several (quantities adjustable, undo available) so parts can
    go to different suppliers or documents. Done before confirming; the original keeps the remainder. [DOC] S1 ·
    [CLIENT] 7
58. **Void** (Results row action) voids the real document, marks the row VOIDED and returns the order to the suggested
    list; demand changes, so the user must **Recalculate** afterwards. [DOC] S1 · [CLIENT] 8
59. Confirming validates each row: supplier/source and status must be filled; a row that fails is marked invalid with
    the reason and the others still go through. [CLIENT] 6.7
60a. The row's supplier/source, order type and status can be edited before confirming; edits auto-save through the
    server immediately. [DOC] S1 · [CLIENT] 6.6

---

## 7. Run lifecycle

| Action | Endpoint | Effect |
|---|---|---|
| Run | `MRP_Run` (settings record) | Reads demand and supply, builds suggestions, errors and log. Disabled when a run already exists on the page, when read-only, or when completed; if another user is already running MRP the user is told who and sent to the list. [CLIENT] 1, 2.7 |
| Recalculate | `MRP_Recalculate` | Recalculates demand and suggestions taking edited and confirmed orders into account; reloads Demand report and Scheduler. Per the help text it is available only once an edited supply order has been confirmed, and demand is recalculated when order type, supply or required-by date changed; the page script has no such gate. [DOC] S1 · [CLIENT] 6.9 |
| Complete | `MRP_Complete` (`MrpID`) | Ends and saves the run; a completed run is read-only and unavailable to other users for further work. Confirms first ("Complete, anyway"); from the list only an active run can be completed, one at a time. [DOC] S1 · [CLIENT] 2.7, 13 |
| Delete | `MRP_vMRP` DELETE | Deletes selected runs; created supply orders stay. A run whose details were purged shows a banner. [DOC] S1 · [CLIENT] 1, 13 |
| Check long execution | `MRP_CheckLongExecution` | After about 15 seconds a long run shows "in progress" and can continue in the background. [CLIENT] 2.7 |
| Load from DB | `MRP_LoadDataFromDB` | Hidden support export of a run's data as a zip. [CLIENT] 2.7 |

60. **Re-run**: a new Run creates a **new** run number; earlier runs remain until deleted. Because only one run can be
    active, the previous one must be completed (or deleted) first. [DOC] S1 · [CLIENT] 13
61. Replies flagged deleted, completed, recalculating, failed or running (another user's action) abandon the original
    action and send the user to the list. [CLIENT] 2.7
62. Completing a run does not delete or void created orders. [INFER] (S1 says deleting a run leaves its orders and
    that completing makes the run read-only)
63. The run list offers a bulk Complete for one active run. [CLIENT] 13

---

## 8. Forecast upload

64. "Include forecast demand" shows a saved-template picker, **Download CSV template**, **Upload forecast**,
    **Remove**. The sales demand forecast report can be exported as CSV and uploaded in a run to count as demand.
    [CLIENT] 2.5 · [DOC] S11
65. The CSV must have exactly the five headers in order (demand location, product SKU, product name, quantity,
    required-by date); dates are `YYYYMMDD`; a blank required-by date is allowed; quantity must be positive; a duplicate
    of SKU + location + date is rejected; the product name is never validated. Failures list in an "Issues while
    uploading forecast" dialog with line number. [CLIENT] 2.5
66. A valid upload gets a forecast id sent with later runs; Remove clears it. Treating it as reusable across runs is
    [INFER]; a saved parameter set carries it (3.15). [CLIENT] 2.5, 2.6
67. The Sales demand forecast report is separate and does not feed MRP automatically; its CSV export is the manual
    bridge. [DOC] S11

---

## 9. Permissions

68. Users need the MRP **Run** permission to run MRP **and** change run settings. S1 words it "Run: MRP Run" and S2
    "Run - MR P" (a typo); S10 lists a standalone **MRP** permission group that grants access to the MRP run
    feature, and the page scripts check `MRP` / `Run`. One permission. [DOC] S1, S2, S10 · [CLIENT] 1 (corrected: it is
    its own group, not under Inventory)
69. No separate "complete" permission is documented; Complete falls under the same one. [INFER]
70. Creating the resulting documents is likely subject to each module's own creating permission. [INFER] / [ASSUME]
71. A user with several roles gets the highest level of access granted by any of them. [DOC] S22
72. Without the MRP add-on the page is **read-only** (Run is disabled) and shows a banner offering a 30-day trial,
    with active-trial and expired variants. A role without write on MRP also gets a read-only page. [CLIENT] 1
    (corrected: the menu is not hidden)
73a. Changing transfer planning and supply rules needs the Settings: Stock - Locations permission. [DOC] S4

---

## 10. Limitations and pitfalls

73. "Minimum before reorder specified for" must be "Each location"; otherwise MRP is unavailable. [DOC] S1
74. "Load demand with details" (and so the Scheduler) is limited to 2 weeks and 100 products. [DOC] S1
75. Draft and planned supply is **not** counted as on order by default; forgetting to include it causes duplicate
    suggestions. [DOC] S1
76. Production/assembly as demand gives component suggestions for the first level only unless BOM explosion is
    on. [DOC] S1
77. Voiding a confirmed order returns it to suggestions: recalculate. [DOC] S1
78. Only purchases from the same supplier (and location) can be merged. [DOC] S1 · [CLIENT] 6.8
79. Data is a snapshot. Stock changes after the run are not reflected until Recalculate. [DOC] S1
80. Products with no supplier or no supply rule are not suggested; check Errors. [DOC] S1, S4
81. For co-manufacturing locations, product-supplier lead/reorder settings are ignored. [DOC] S4
82. A long run triggers an "in progress" notice and continues in the background. [CLIENT] 2.7
83. Supply from outside the planning period counts unless "Exclude future supply" is used (11a). [DOC] S1
84. Hidden options are saved false (3.3, 3.11). [CLIENT] 2.3
85. Only one run can be active; Complete closes it for all users. [DOC] S1 · [CLIENT] 2.7
86. Voiding does not recalculate by itself. [CLIENT] 8

---

## 11. Sandbox implementation notes

- Today the module is read-only: every screen renders empty (`src/sandbox/modules/m16_mrp.py`). The rules above
  define the minimum behaviour when calculation is added: settings save/load (3), Run and Recalculate (4, 7),
  Confirm (6), Complete (7).
- Tables to write: `vMRPSettings` (+`vLocationID`, `vCustomerID`), `vMRP`, `vSupplySuggestion`,
  `vSuggestionProduct`, `vSupplyResult`, `vError`, `vLog`, `vForecastError`. [API] S15
- Run statuses to model: Active, Running, Recalculating, Completed, Failed. [CLIENT] 1
- Do not create documents in other modules directly; reuse their create paths so statuses and numbering match
  (`rules/purchase.md`, `rules/inventory.md`).

---

## Unclear / docs disagree

Closed by the full help-center read and the page scripts, now stated in the body: permission name (rule 68), "overdue"
vs "past due" wording (2.1), run statuses (rule 5), both Procure up to options at once (rule 30), consolidate
suggestions by source (3.13), supplier-choice options (3.9, 2.3a) and the defaults of the run form (section 3), and the
"no MRP endpoints" point (intro). What is left, with the reason each stays open:

1. **Netting algorithm.** The documents give only the aggregate formula, the stock-level "every day" rule and the
   supply-rule cascade; the server computes the rest and the page scripts only send inputs. Processing order, the
   day-by-day projection and how later days are re-netted (section 4.1, rules 18 to 20) are a model.
2. **Rounding and minimum order.** Minimum to order and reorder quantity are defined (S5, S7) but no MRP article says
   how a suggested quantity is rounded, so 4.2 is inferred.
3. **Date arithmetic.** How lead time, location calendar, production time, manufacturing buffer and transfer interval
   combine is not documented; only the transfer-day behaviour (by example) and the Scheduler bar length (lead only)
   are known. Section 4.4 is a design.
4. **Safety days in MRP.** No MRP article mentions them, and the Scheduler ignores them; the Velocity-report formula
   belongs to a different feature. Treated as unused by MRP [ASSUME].
5. **Recalculate details.** The help text says it is available only after an edited supply order has been confirmed;
   the page script has no such gate, so the real rule is server-side. Whether manual edits to unconfirmed rows
   (supplier, status, date) survive a recalculation is not stated.
6. **Created production order status.** S8 creates MRP-confirmed production orders and their nested orders as Draft
   (with the production-process setting "Create production order" on its MRP option); S2 tells users to create the
   top-level orders in Planned. The sandbox applies the row status to the top-level order and Draft to nested orders;
   the real interaction with the production-process setting is not described.
7. **Stock basis for supply.** S1 says "stock on hand" and S20 defines On Hand and Available; whether MRP nets against
   on hand or available (rule 11b) is inferred.
8. **"Exclude future supply".** S1 describes it; the page script exposes it only on the Demand report's details link,
   and the report is server-rendered, so whether it also alters the stored calculation is not visible.
9. **Co-manufacturing and transfer planning.** S4 lets a co-manufacturing location be a demand location of a transfer
   plan; S19 lists MRP as supported "including supply rules but not transfer planning". Both are kept; the sandbox
   follows S4 (rule 18f, 2.3b).
10. **Integers and stored values.** Values of `SupplyTask` other than 0, the other two `DemandSales` values and the
    production-date setting's stored values are not visible in the scripts or articles.
11. **Production BOM min/max quantities.** S13 limits them to automatically created orders; whether MRP-confirmed orders
    honour them is not stated (rule 28b).
12. **Remaining sandbox defaults [ASSUME].** Account default of "Minimum before reorder specified for", default of the
    production demand calculation date, error-level assignment of concrete conditions (5.2), sharing of saved
    parameter sets, quotes and voided orders excluded from demand, and the permission needed to create the resulting
    documents.
