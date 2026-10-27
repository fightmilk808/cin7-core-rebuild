# Production business rules (Cin7 Core)

Rules for module 07 (production) of the sandbox: production setup, resources and work centres, the factory
calendar, production BOMs, production orders and runs, issue and backflush, finished goods, cost of production,
capacity planner and scheduler, assembly and disassembly, inventory write-off, job costing and permissions.
Screens, fields and tables come from `spec/modules/07-production/` and `spec/modules/20-public-api/groups/production.md`.
General settings that touch production are owned by `rules/settings.md` section 7 (G-77 to G-90); they are summarised
here only where they change production behaviour. Stock and costing of assembly are also covered in `rules/inventory.md`.

## ⚠️ Gotchas: the sneaky stuff

The surprising, easy-to-get-wrong and silently failing behaviours, worst first. Each links to the section with the full rule. Tags are the same as in "How to read this file" below.

> [!CAUTION]
> **Editing an order line silently deletes every production run.** Changing a quantity or another row value on an order that is not yet Released (or already Completed) throws away all its runs, because run lines are derived from order lines. Lowering the order quantity below the runs total, or reloading a BOM whose operations changed, does the same after a confirm. [CLIENT]
> [Full rule: 5.4 Runs and partial completion](#54-runs-and-partial-completion)

> [!CAUTION]
> **Cost variance is never posted anywhere that the help center describes.** An over- or under-run shows only as Actual minus Planned in the Production Cost Breakdown (manual-journal overhead is folded into Actual), and the actual cost goes into the finished-goods layer, so a bad run silently inflates stock value. The help center never says a variance account exists. [DOC / INFER]
> [Full rule: 7. Cost of production](#7-cost-of-production)

> [!CAUTION]
> **Undo never cascades to nested production orders, Void only does if you say so, and neither follows the sale.** Undoing a parent leaves the child orders with their allocations and transactions. Voiding offers a "with nested orders" choice in the dialog; the default leaves them alone. Undoing or voiding the sale that spawned an order does nothing to the order. [DOC / CLIENT] (corrected: the page does offer a nested void)
> [Full rule: 5.2 Transitions](#52-transitions)

> [!CAUTION]
> **Bulk "Mark as completed" on the orders list reverses uncompleted work, while the single-order button refuses.** The list confirm says it reverses all uncompleted operations and the component and resource allocations. On the order page the same action is refused while any run is neither Completed nor Voided. [CLIENT]
> [Full rule: 5.2 Transitions](#52-transitions)

> [!CAUTION]
> **Blank disassembly cost % splits cost per component line, not per unit.** You would expect a blank percentage to follow quantity. Instead the cost pool is split equally across lines and quantity per line is ignored, so a line of 4 fittings gets the same cost as a line of 1 frame. Percentages, when set, must total 100, and a rounding gap blocks completion until the result total is edited to match the pick total. [DOC / CLIENT]
> [Full rule: 9.2 Disassembly](#92-disassembly-disassembly)

> [!CAUTION]
> **"Posted to expense account" wastage is costed at the BOM's sale price tier.** You would assume waste is expensed at what it cost to make. Under that setting the amount sent to the wastage expense account is based on the sale price tier, while "Included in production cost" spreads it over the finished products instead. Under "Included", a run with zero output cannot be completed at all. Switching the setting changes your books. [DOC / CLIENT]
> [Full rule: 7. Cost of production (rule 7.7)](#7-cost-of-production)

> [!WARNING]
> **Backflush is all-or-nothing, checked only when Output is completed, and locked once work starts.** All components must be on hand at the shop floor or consumption bin (no partial issue), so the failure shows up at the very end of the run. Scan, Auto-consume and typing an actual quantity are disabled for backflushed lines, newly added components cannot be backflushed, it cannot be used with product tracing even for one component, and it cannot be switched after an operation has started (undo the run to change it). Co-manufacturing operations cannot use it. [DOC]
> [Full rule: 6. Issuing components, backflush, finished goods receipt](#6-issuing-components-backflush-finished-goods-receipt)

> [!WARNING]
> **Planned does not allocate stock; only Released does, and release never refuses for a shortage.** Authorising an order books resource capacity but allocates no components, so two Planned orders can both count on the same parts. Release allocates and, if the transfer and replenishment settings are Automatic, raises transfers and POs; the help center never describes a refusal for shortage. Odd corner: the documents say an order whose components are all available is released straight on authorisation. [DOC]
> [Full rule: 5.1 Status values](#51-status-values)

> [!WARNING]
> **Setup and co-manufacturing operations ignore the order quantity.** Their planned time is just the cycle time and their components scale by the BOM output quantity, not the order quantity. Treating every operation as quantity-driven overstates setup time and material. [CLIENT / DOC]
> [Full rule: 3.3 Operations and operation types](#33-operations-and-operation-types)

> [!WARNING]
> **Nested orders appear only for sub-assemblies that have their own production BOM and are out of stock, and their status depends on where the parent came from.** Manual authorisation makes them Planned, authorising a sale makes them the parent's status, MRP and reorder suggestions make them Draft. An assembled component is not a production order; the articles disagree on whether an assembly order is raised for it. [DOC]
> [Full rule: 4.2 Production BOM](#42-production-bom)

> [!WARNING]
> **Min and max quantity, deviation % and run size are not enforced on manual orders.** They shape only automatically created orders (a small sale waits until the total reaches the minimum). A manual order outside the range only gets a "proceed anyway" prompt on save. Wastage quantity also silently beats wastage percent when both are set. [DOC / CLIENT]
> [Full rule: 2.3 Per-BOM and per-order options](#23-per-bom-and-per-order-options-set-on-the-bom-copied-to-the-order-overridable-until-work-starts)

> [!WARNING]
> **Dragging in the Scheduler Calendar view ignores capacity, and the Scheduler always lays work out forward.** The drop succeeds and silently over-allocates the resource; only the Capacity Planner or Production view respects capacity. Rescheduling needs the full-access Scheduler permission, and moving an order never changes the sale's required-by date. Editing Required by after capacity is allocated does not recalculate anything. [DOC / CLIENT]
> [Full rule: 8.2 Scheduler](#82-scheduler)

> [!WARNING]
> **Production options are not on the Production setup page, and calendar edits only reach orders created afterwards.** Auto transfers, auto POs, nested creation, wastage handling, backdating and tracing live in General settings tab 7. Resources have no working hours until the factory calendar exists, and changing the calendar, weekend days or resource capacity applies only to orders created or authorised afterwards. [DOC / CLIENT]
> [Full rule: 1. Prerequisites and module gating](#1-prerequisites-and-module-gating)

> [!WARNING]
> **Backdated transactions are off by default.** With it off, completing a run is blocked unless the completion date is today, the operation start and end date pickers stay disabled, and the lock date blocks even when it is on. The default is a sandbox suggestion, not a documented Cin7 value. [DOC / CLIENT / ASSUME]
> [Full rule: 2.2 General settings tab 7](#22-general-settings-tab-7-production-process-customization)

---

## How to read this file

**Sources.** The source is the public Cin7 Core help center, read in full (660 articles, plain text, updated 2026-10-26), plus the API map
(the `cin7-core` map tools `search_operations` and `describe_operation`; `read` was not called), the repo spec, and the client-script notes in `rules/production-client.md`
(static reading of the shipped page scripts). Nothing was run against the live Cin7 app and nothing was written to Cin7.
Cin7's server-side error and warning texts are not documented in the help center; browser-side texts come from the client notes and are
listed in section 5.5. Where a sandbox message is needed beyond those, it is marked [ASSUME] and worded by us. Article text is paraphrased, never copied.

Tags (each rule carries one or more, plus a source key):

- **[DOC]** stated in a Cin7 help article, read in full. High confidence.
- **[API]** read from the public API v2 map or the repo spec (field names, shapes, enums). High confidence for shape, none for behaviour.
- **[CLIENT]** settled by the shipped page scripts (`rules/production-client.md`): what the browser decides, validates or labels. High confidence for the browser, none for the server.
- **[INFER]** deduced from other rules. Medium-low.
- **[ASSUME]** a sandbox default we chose because neither the help center nor the scripts settle it. Listed again at the end.
- The old **[HELP]** tag (an excerpt-only reading) is retired: every such rule was re-read in the full article and now carries [DOC], or a correction.

A rule marked `(corrected)` differs from the earlier excerpt-based version of this file.

### Source key

| Key | URL |
|---|---|
| S-INTRO | https://help.core.cin7.com/hc/en-us/articles/9034465587727-Introduction-to-the-Advanced-Manufacturing-Module |
| S-STDMFG | https://help.core.cin7.com/hc/en-us/articles/9034465572111-Introduction-to-Standard-Manufacturing |
| S-MPO | https://help.core.cin7.com/hc/en-us/articles/9034490882575-Managing-Production-Orders |
| S-POLIST | https://help.core.cin7.com/hc/en-us/articles/9034520965903-Production-orders-list |
| S-NESTED | https://help.core.cin7.com/hc/en-us/articles/9034476290447-Nested-production-orders-production-BOM-explosion |
| S-FAQ | https://help.core.cin7.com/hc/en-us/articles/9982480721167-Production-FAQs |
| S-BOMTYPES | https://help.core.cin7.com/hc/en-us/articles/9034450446479-Bill-of-materials |
| S-BOM | https://help.core.cin7.com/hc/en-us/articles/9034493208847-Production-BOM |
| S-BOMSET | https://help.core.cin7.com/hc/en-us/articles/11759857982095-Production-BOM-settings |
| S-BOMVER | https://help.core.cin7.com/hc/en-us/articles/11759833766927-Production-BOM-versions |
| S-BOMREPL | https://help.core.cin7.com/hc/en-us/articles/12595538582031-Replace-BOM-components |
| S-BOMIMP | https://help.core.cin7.com/hc/en-us/articles/11759847437071-Import-and-export-production-BOM |
| S-BOMEX | https://help.core.cin7.com/hc/en-us/articles/11917410018959-Example-production-BOM |
| S-BOMFAM | https://help.core.cin7.com/hc/en-us/articles/9034520205071-Production-BOM-for-product-families |
| S-MTO | https://help.core.cin7.com/hc/en-us/articles/9034464800399-Customizable-products-Make-to-Order |
| S-FINPROD | https://help.core.cin7.com/hc/en-us/articles/9034435941007-Finished-products-Primary-products-coproducts-byproducts-joint-production-products |
| S-IO | https://help.core.cin7.com/hc/en-us/articles/9034587837839-Using-Inputs-and-Outputs-Intermediate-or-semi-finished-products |
| S-PARALLEL | https://help.core.cin7.com/hc/en-us/articles/9034498439055-Implement-parallel-and-non-parallel-operations-in-a-Production-BOM |
| S-BACKFLUSH | https://help.core.cin7.com/hc/en-us/articles/9034474589839-Issue-components-based-on-production-output-quantity-Backflushing-method |
| S-TRACE | https://help.core.cin7.com/hc/en-us/articles/9034506893455-Production-component-tracing |
| S-ALT | https://help.core.cin7.com/hc/en-us/articles/9034587409935-Specify-alternative-products-for-sale-or-production |
| S-PSET | https://help.core.cin7.com/hc/en-us/articles/11073293006991-Production-process-customization-settings |
| S-FACCAL | https://help.core.cin7.com/hc/en-us/articles/9034451182351-Factory-Calendar |
| S-SHOP | https://help.core.cin7.com/hc/en-us/articles/9034569676431-Shop-floors-and-logistics-paths |
| S-WC | https://help.core.cin7.com/hc/en-us/articles/10553632409487-Work-centers-and-bins |
| S-RES | https://help.core.cin7.com/hc/en-us/articles/9034471143823-Production-resources-and-capacity |
| S-RESCOST | https://help.core.cin7.com/hc/en-us/articles/11759858005775-Resource-costs |
| S-CAP | https://help.core.cin7.com/hc/en-us/articles/9034480737551-Capacity-Planner |
| S-SCHED | https://help.core.cin7.com/hc/en-us/articles/9034524048911-Production-Scheduler |
| S-BUFFER | https://help.core.cin7.com/hc/en-us/articles/9034517938191-Manufacturing-Buffer |
| S-OP | https://help.core.cin7.com/hc/en-us/articles/11759833715215-Carry-out-a-production-operation |
| S-MES | https://help.core.cin7.com/hc/en-us/articles/9034435197199-Cin7-Core-Manufacturing-Execution-System-MES |
| S-MESLIST | https://help.core.cin7.com/hc/en-us/articles/11073310323599-MES-task-list |
| S-COSTBRK | https://help.core.cin7.com/hc/en-us/articles/9034478195215-Production-Cost-Breakdown |
| S-PCA | https://help.core.cin7.com/hc/en-us/articles/9034506918543-Production-Cost-Analysis-Report |
| S-WASTE | https://help.core.cin7.com/hc/en-us/articles/9034481503887-Finished-Products-Wastage-Report |
| S-SHORT | https://help.core.cin7.com/hc/en-us/articles/9034521051535-Production-Shortage-Report |
| S-OVERDUE | https://help.core.cin7.com/hc/en-us/articles/9034520981647-Production-Overdue-Report |
| S-RBDE | https://help.core.cin7.com/hc/en-us/articles/9034544875919-Required-by-Date-Exceptions |
| S-DOWN | https://help.core.cin7.com/hc/en-us/articles/9034506944655-Production-Downtime-Report |
| S-CYCLE | https://help.core.cin7.com/hc/en-us/articles/9034540118927-Production-Actual-vs-Planned-Cycle-Time |
| S-EFF | https://help.core.cin7.com/hc/en-us/articles/9735447865103-Production-Resource-Efficiency |
| S-COMAN | https://help.core.cin7.com/hc/en-us/articles/9034480843919-Co-manufacturing-outsourcing-parts-of-the-production-process |
| S-CMSET | https://help.core.cin7.com/hc/en-us/articles/12119885977359-Co-manufacturing-procurement-settings |
| S-CMPO | https://help.core.cin7.com/hc/en-us/articles/9034544437263-Raise-a-co-manufacturing-order-from-a-purchase |
| S-LANDED | https://help.core.cin7.com/hc/en-us/articles/10553585017999-Allocate-landed-costs-to-production-runs |
| S-ASM | https://help.core.cin7.com/hc/en-us/articles/9034464144015-Assembly |
| S-BOMASM | https://help.core.cin7.com/hc/en-us/articles/9034480629647-Bill-of-materials-assembly |
| S-ALLOC | https://help.core.cin7.com/hc/en-us/articles/10553608901263-Allocate-costs-to-assemblies |
| S-AUTOASM | https://help.core.cin7.com/hc/en-us/articles/11952177561743-Auto-assembly |
| S-MULTI | https://help.core.cin7.com/hc/en-us/articles/9034476129295-Multi-level-Assembly |
| S-PHANTOM | https://help.core.cin7.com/hc/en-us/articles/9034491863567-Phantom-BOM |
| S-DISASM | https://help.core.cin7.com/hc/en-us/articles/9034497989135-Disassembly |
| S-WO | https://help.core.cin7.com/hc/en-us/articles/9034490040079-Inventory-write-off |
| S-JOB | https://help.core.cin7.com/hc/en-us/articles/9034516692239-Job-Costing |
| S-PERM | https://help.core.cin7.com/hc/en-us/articles/9034604405007-User-permissions-explained |
| S-TASKCAL | https://help.core.cin7.com/hc/en-us/articles/9034604259215-Tasks-Module-Using-Notifications-Tasks-to-Create-Workflows |
| S-MRP | https://help.core.cin7.com/hc/en-us/articles/9735470547215-Material-Requirements-Planning-for-Production |
| S-APIBOM | https://help.core.cin7.com/hc/en-us/articles/9034480650127-Bill-Of-Materials-endpoint |
| S-APIPROD | `spec/modules/20-public-api/groups/production.md` and `cin7-core` map ops `production order-*`, `production run-*`, `production product-production-bom-*` |
| S-SCHEMA | `spec/modules/07-production/schema.sql`, `UI.md` |
| S-SET | `rules/settings.md` section 7 (itself sourced from S-PSET) |
| S-CLIENT | `rules/production-client.md` (section numbers cited as `S-CLIENT 4.3`) |

---

## 1. Prerequisites and module gating

| # | Rule | Tag | Source |
|---|---|---|---|
| 1.1 | Production orders, the Scheduler, the Capacity Planner, resources, work centres, the factory calendar, production BOMs and the MES app belong to the **Advanced Manufacturing** add-on (30-day trial available). Standard Manufacturing is assembly BOMs, assembly, disassembly, write-off and jobs, included in every plan. | DOC | S-INTRO, S-STDMFG, S-MES |
| 1.2 | Setup order (corrected: the shop floor and logistics path come before work centres): factory calendar, then shop floors and logistics paths, then work centres and bins, then resources with capacity and costs, then production BOMs; production process settings and the WIP account mapping come before the first order. | DOC | S-INTRO, S-SHOP |
| 1.3 | The Production setup page (`/ProductionSetup`) shows a Factory Calendar block ("Set up calendar"), an Account mapping block, and three tabs: Resources, Work centers, Suspend reasons. Access uses the Capacity Planner permission. | CLIENT / DOC | S-CLIENT 1, S-FACCAL |
| 1.4 | Production-process options (auto transfers, auto POs, nested creation, wastage handling, backdating, tracing and so on) are **not on the Production setup page**. They sit in General settings, tab 7 "Production process customization" (see section 2). | DOC | S-PSET, S-SET |
| 1.5 | The Task calendar is a different calendar from the Factory Calendar; weekend and holiday settings do not sync between them, and tasks created even for production items follow the task calendar. | DOC | S-TASKCAL |
| 1.6 | Production happens at a **shop floor** location. Marking a location as Shop floor enables manufacturing for it; at least one shop floor is needed. A location or bin cannot be deleted once used in an order, and a logistics path cannot be deleted or changed once used by a production or sale order. Stock actions for production are limited to locations where the user has access. | DOC | S-SHOP, S-PERM |
| 1.7 | A **logistics path** links three locations: Components (where parts are stored), Shop floor (where made) and Demand (where sold). They may be the same location, but it must then be a shop floor. A shop floor connects to exactly one components warehouse; a components or demand location may serve several shop floors. The path sets lead times, creates transfers and POs, and logs stock movements. | DOC | S-SHOP |

---

## 2. Production setup options

"Production setup" in Cin7 is spread over three places. Each option: name, values, default, effect.
Defaults marked "suggested" are not documented by Cin7; they are the sandbox default.

### 2.1 Production setup page (`/ProductionSetup`)

| Option | Values | Default | Effect | Tag | Source |
|---|---|---|---|---|---|
| Factory calendar | Per-day working window (start, end, **one** break), week-start day, weekend days (any number), holidays, custom-hours days; one calendar per year | none until "Set up calendar" is used; no calendar means no capacity | Default working days and hours for every resource. Saving with no working-day hours is refused. Special days cannot be dated in the past. Edits (week start, weekends, holidays) apply only to orders created afterwards; released orders keep their schedule but warn if now over-allocated. A break pauses all resources like a weekend does. (corrected: past-date rule, one break, edits not retroactive) | DOC / CLIENT / API | S-FACCAL, S-CLIENT 7, S-SCHEMA (`vProductionCalendar`, `vProductionCalendarDay`, `vProductionCalendarSpecialDay`) |
| Account mapping | Default Work-in-progress account; the finished-goods account defaults to the Inventory control account | blank | Per order the WIP and finished-goods accounts can be overridden (`WIPAccountCode`, `FinishedGoodsAccountCode`). The wastage expense account is a general setting (G-83); resource-cost accounts sit on each resource's Costs tab. Lives under Settings, Reference books, Account Mapping. (corrected: not one block of four accounts) | DOC / API | S-INTRO, S-MPO, S-RESCOST, S-PSET |
| Resources tab | list with search and "Only operational" filter; columns Code, Name, State (Operational / Non-operational) | empty | Master list of resources (section 3). | CLIENT | S-CLIENT 1.1 |
| Work centers tab | columns Code, Name, Color code, Co-man, Purchase co-man, Mode, Consumption bin, Output bin, State | empty | Master list of work centres (section 3). Leave Consumption bin empty to pick from the shop floor itself. Two chosen bins in one shop floor are refused; toggling a co-man flag clears the name, supplier and bins. | CLIENT / DOC | S-CLIENT 1.2, S-WC |
| Suspend reasons tab | list of reasons, each with a downtime type (Planned, Not planned, Undefined) and the work centres it applies to | empty | Reasons offered when an operation is suspended; a reason with no work centre applies to all. The type feeds the Downtime report and the downtime cost rates. (corrected: type and work-centre scope) | DOC / CLIENT | S-WC, S-CLIENT 1.3, S-DOWN |

### 2.2 General settings tab 7: Production process customization

Full text for each is in `rules/settings.md` G-77 to G-90. Condensed here with what each changes in production.

| Id | Option | Values | Default (suggested) | What it changes | Tag |
|---|---|---|---|---|---|
| G-77 | Stock transfer | Automatic / Manual | Manual | Automatic: release creates transfer orders from the connected warehouse to the shop floor for short components; they must still be completed by hand when stock arrives. | DOC |
| G-78 | Purchase order replenishment | Automatic / Manual | Manual | Automatic: release creates POs to the shop floor location for missing components, completed by hand on receipt; needs a supplier on the product. | DOC |
| G-79 | Nested production order creation | Automatic / Manual | Manual | Automatic: orders for component BOMs are created for the parent. The settings article ties creation to release and says nested assembly orders are always manual; the nested article says authorising a draft makes Planned child orders. See Unclear item 18. (corrected: timing and nested-assembly wording disagree between articles) | DOC |
| G-80 | Production order from sale | When order is authorised or backordered / Via MRP and reorder suggestions | Via MRP | "When authorised": authorising or backordering a sale (or a purchase) of a finished product creates a production order. Does not affect manual orders or MRP/reorder creation. Requires G-81 and G-82 to be set. (corrected: backorder trigger, purchases) | DOC |
| G-81 | Set order status to | Draft / Planned / Released | Draft | Status of auto-created orders. Draft: nothing allocated; Planned: capacity allocated, no stock; Released: capacity and components allocated and the order enters the Scheduler. | DOC |
| G-82 | On order release produce | Quantity required / Quantity required plus min stock / Difference to cover shortage | Quantity required | Quantity of auto-created orders. Second form: sale quantity plus (minimum before reorder plus reorder quantity minus on order minus available), read at the Demand location. Third form: sale quantity minus available minus on order. Only Released orders use the 2nd and 3rd forms; Draft and Planned always use the sale quantity. Availability is re-checked on each status change and the user may keep or update the quantity. (The nested article prints different sign conventions; the settings article is followed.) (corrected: formulas and recheck) | DOC |
| G-83 | Waste write-off | Posted to expense account / Included in production cost | Included | Section 7.7. Expense: cost at the BOM's sale price tier goes to the chosen waste account. Included: spread over finished products by the BOM allocation method. | DOC |
| G-84 | Backdated transactions | on / off | off | Allows consumption, operation start/end and finished-goods receipt dates other than today. Still blocked by the lock date. | DOC / CLIENT |
| G-85 | Co-manufacturing procurement | Sell components / Transfer components / Purchase components | Transfer | Default mode for new co-man work centres; can be changed per work centre until it is used in a BOM. Section 11. | DOC |
| G-86 | Component description source | product description / short description / internal note | description | Print only. Not described in any help article; kept as a field name only. | ASSUME |
| G-87 | Transfer finished products | Don't / On run completion / On order completion | Don't | Generates a transfer from the output location to the delivery location. With "Don't", the Delivery-to fields are hidden. | DOC |
| G-88 | Attribute sets | order/run, operation, output | none | Extra custom fields. Editing after an operation (or the last operation of a run, for output) completes needs "Production orders - Edit completed operations". | DOC |
| G-89 | Product tracing | Never / Always / Optional (per BOM version) | Never | Records which component batch or serial went into which finished batch. Needs one of the batch or serial costing methods on both sides (FIFO, FEFO or Special, batch or serial). Excludes backflush. Optional is chosen per BOM version and the BOM checkbox only applies to products not costed FIFO. (corrected: per BOM version, costing methods) | DOC / CLIENT |
| G-90 | Document sort order | screen / name / SKU | screen | Print only. | DOC |

Numbering: production orders use the `MO` prefix of the document-numbering table (G-93); the number is
prefix + zero-padded next number + suffix, for example `MO-00012`. Runs are numbered 1, 2, 3 within an order
(`Runs[].Number`). Next run number is the highest existing plus one. The help center does not describe numbering. [ASSUME for the MO type, API for run number] Source: S-SET, S-APIPROD.

### 2.3 Per-BOM and per-order options (set on the BOM, copied to the order, overridable until work starts)

| Option | Values | Default | Effect | Tag | Source |
|---|---|---|---|---|---|
| Issue method (`IssueMethodComponent`, `IssueMethodParameter`; `IssueMethod` also appears in the API) | Component issue method: Manual = 1, Backflush = 2. Backflush defined for: BOM = 1, Operation = 2, Component = 3 | Manual | Section 6. The parameter is shown only for Backflush (defaults to BOM) and saved null for Manual. The meaning of the separate API field `IssueMethod` is unpublished. (corrected: integer maps now known) | CLIENT / DOC / API | S-CLIENT 3.1, S-BACKFLUSH, S-APIPROD |
| Manufacturing buffer % (`BufferPercent`) | decimal >= 0 | 0 | Pads production time and component lead time (section 10). The buffer is not applied to runs or single operations. | DOC / CLIENT | S-BUFFER |
| Ignore cumulative lead time (`IgnoreCumulativeLeadTime`) and component production lead time (days) | bool; integer | false | If checked, component lead time is typed on the BOM in days; if not, taken from the Suppliers tab of each component. Leave unchecked when components have their own production BOM so cumulative lead time counts. | DOC / CLIENT | S-BUFFER, S-BOMSET |
| Run size (`RunSize`) | decimal >= 0 | blank | Quantity per production run; the order splits into runs of that size and the last run gets the remainder (270 with run size 50 gives five of 50 and one of 20). Not time-driving. A released order with a run of a different size gets a "proceed anyway" prompt on save. (corrected: units per run, not a count of runs, and not a time driver) | DOC / CLIENT | S-BOMSET, S-CLIENT 4.6 |
| Min / max quantity, deviation % (`MinQuantity`, `MaxQuantity`, `DeviationPercent`) | decimals | blank | Apply to **automatically created** orders only: a sale below the minimum waits until the accumulated total reaches it; above the maximum the order splits at the maximum and the remainder accumulates. Deviation % lets an order land slightly under the minimum or over the maximum. 0 or blank means no threshold. Nested orders ignore the child BOM's thresholds. A manual order outside the range just prompts. (corrected: enforcement now documented) | DOC / CLIENT | S-BOMSET, S-CLIENT 4.6 |
| Output quantity (`OutputQuantity`) | decimal > 0 | 1 | The quantity of the main finished product that the BOM quantities are written for (BOM quantity). | DOC / API | S-BOM, S-APIPROD |
| Capacity calculation (`CapacityCalculationType`) | `FromStartForward` (1), `FromRequiredBackward` (2) | `FromStartForward` | Direction of scheduling (section 10); a new order defaults to forward. (upgraded from ASSUME) | CLIENT / API | S-CLIENT 4.1 |
| Ignore lead time (`IsIgnoreLeadTime`) | bool | false | Skip component lead time in the dates; editable only while the order is Draft. | CLIENT / API | S-CLIENT 4.1 |
| Traced (`IsTracing`) | bool | follows G-89 | Per-BOM tracing when G-89 is Optional; disabled and cleared when the issue method is Backflush. | DOC / CLIENT | S-TRACE, S-CLIENT 3.1 |
| Delivery location (`DeliveryTo`) | location | blank | Target of the finished-product transfer (G-87); falls back to the logistics-path Demand location. Editable on Draft or Planned orders, locked once released. A default only; the user can pick another at production time. (corrected: fallback and lock) | DOC | S-BOMSET, S-MPO |
| Version, Name, IsDefault | int, text, bool | 1, blank, true for the first | A product holds several BOM versions; "Add version" clones the current one. The default is used for auto-generated orders; a manual order can choose a version while Draft or Planned. | DOC / API | S-BOMVER, S-APIPROD |
| Instruction URL | URL | blank | Shown on the order and in the MES app. | DOC / API | S-BOMSET |
| Finished product cost allocation | Sales value (1) / Net realisable value (2) | Sales value | Splits cost over several finished products; with a single finished product it falls back to Sales value. | CLIENT / DOC | S-CLIENT 3.1, S-FINPROD |

---

## 3. Work centres, resources, operations, operation types

### 3.1 Work centres

| # | Rule | Tag | Source |
|---|---|---|---|
| 3.1.1 | A work centre has Code, Name, Color code, a state (Operational / Non-operational), **consumption bins** (component pick locations, several allowed; `InLocationIDs`) and **one output bin** (`OutLocationIDs`), and a co-manufacturing flag (`IsCoMan`) with mode `CoManProcurementType` and suppliers. A work centre may be both co-man and purchase co-man. With no bins, everything is taken from and put to the shop floor and no transfers are generated; with bins, transfers are generated between them. (corrected: several consumption bins, one output bin) | DOC / API | S-WC, S-SCHEMA |
| 3.1.2 | Components are issued from the work centre's consumption bin when one is set; when it is empty they are picked from the shop floor location. If the bin runs out the user must pick from another bin. | DOC | S-WC, S-OP |
| 3.1.3 | A non-operational work centre cannot host production operations; an existing one can be hidden from operations by setting that state. A work centre can be deleted only if no operation used it (undo the old orders first). (upgraded from ASSUME) | DOC | S-WC |
| 3.1.4 | A work centre flagged co-manufacturing is used by co-manufacturing operations; its consumption bin is a co-man location and it has no output bin (outputs land at the shop floor unless another bin is chosen at receipt). | DOC | S-COMAN |
| 3.1.5 | Work-centre colour is used only to colour operations in the Scheduler's Planning, Production and Resources views, not runs, orders or resources. | DOC | S-SCHED |

### 3.2 Resources

| # | Rule | Tag | Source |
|---|---|---|---|
| 3.2.1 | A resource has Code, Name, Tags, type (**Labor**, **Machine**, **Other**), state, `IsInfinite`, "Use all available resources" (`IsAllowAllCapacityUsage`), `IsAvailableOnHolidays`, `IsAvailableOnWeekends`, `CycleDuration` (its unit of time, at most 90 days, required). Labor resources are mapped one user per individual unit, which also limits what that user sees in MES; do not map one user to several resources. Changing an existing resource to Labor warns that every unit needs a user. (corrected: type list and unit of time) | DOC / CLIENT / API | S-RES, S-CLIENT 6.1 |
| 3.2.2 | **Infinite** resources (for example electricity) have no capacity limit but do carry a cost; capacity cannot be set on them. All others are capacity-limited. | DOC | S-RES |
| 3.2.3 | A resource can consist of several **units** per shop floor; capacity per week = weekly operational hours x number of units. "Use all available resources" means extra units speed an operation up (three ovens bake three times as much); leave it off for jobs where more units do not help. (corrected: weekly formula, speed-up option) | DOC / CLIENT | S-RES, S-CAP |
| 3.2.4 | By default a resource follows the Factory Calendar. It can override with custom hours (start, end, break) per shop floor and resource pair, and be allowed to work on holidays and weekends. Each unit can have operational and non-operational periods (open-ended allowed). A resource or unit used in an order cannot be deleted, only made non-operational. | DOC | S-RES |
| 3.2.5 | Resource cost is held per costing line: a **service product**, account code, price tiers (the BOM line picks the tier), and separate production, planned-downtime and unplanned-downtime rates. The unit of service measure must match the resource's unit of time. Editing costs recalculates uncompleted operations only; past transactions stay. (corrected: three rates, recalculation scope) | DOC / CLIENT / API | S-RESCOST, S-CLIENT 6.3 |
| 3.2.6 | Cost calculation type on a BOM resource line (`CostCalculationType`): **per unit of time** or **per unit of finished product** (piece rate), chosen when the resource is added to a BOM. | DOC | S-RESCOST, S-BOMSET |
| 3.2.7 | A cost per unit cannot be edited on the BOM or the order; edit the resource's cost record (or the component product). | DOC / CLIENT | S-BOM, S-CLIENT 6.3 |
| 3.2.8 | Resource and calendar edits (week start, weekends, holidays, unit count, finite/infinite, use-all-available) change the Scheduler and Capacity Planner only for orders created or authorised afterwards; released orders warn if now over-allocated. | DOC | S-RES, S-FACCAL |

### 3.3 Operations and operation types

| # | Rule | Tag | Source |
|---|---|---|---|
| 3.3.1 | A BOM is an ordered list of **operations**. Each has sequence number, Name, `OperationType`, Work centre, cycle time (`CycleTime`), units per cycle (`UnitsPerCycle`), previous-step links, and entries of these types: Component, Resource, Note (200 chars), Attachment (32 MB), Finished product, Input, Output, plus Template (make-to-order) on the product page. Objects cannot be moved between operations; operations can be dragged to renumber. | DOC / API / CLIENT | S-BOM, S-CLIENT 3.2 |
| 3.3.2 | `OperationType` values: **Manufacturing** (1), **Setup** (2), **Quality Control** (3), **Co-manufacturing** (4). Setup is for steps whose time does not scale with quantity (calibration), its components are allocated when the operation starts, and its type cannot be edited later. Resources are not allowed on co-man operations; finished product, input and output lines are not allowed on Setup. (corrected: meaning of Setup, allowed rows) | DOC / CLIENT | S-BOM, S-CLIENT 3.2 |
| 3.3.3 | Dependencies are the "Previous step" column: Step 0 means no predecessor and the operation is scheduled as soon as resources are free (non-parallel); operations sharing a sequence number start together; an operation starts only after every operation it points at is complete; missing step numbers are allowed. `RelationType` is always 1 on the order links. (corrected: the integer is not a choice) | DOC / CLIENT | S-PARALLEL, S-CLIENT 3.2 |
| 3.3.4 | Outputs of an operation can feed later operations. A product can be an **input** of an operation only if it is an **output** of an earlier operation of the same BOM, with matching quantities. Inputs/outputs are virtual: no stock movement, allocation or cost, and picking is always FIFO. Allowed types: Stock or Non-inventory. A product that is a finished product elsewhere in the BOM cannot be an input or output downstream. | DOC / CLIENT | S-IO, S-CLIENT 3.3 |
| 3.3.5 | Operation time on an order = for Manufacturing and Quality control, ceiling(order or run quantity / `UnitsPerCycle`) x `CycleTime`; for Setup and Co-manufacturing it is just `CycleTime`. Number of cycles is shown as 1 for Setup and Co-man. (corrected: Setup/Co-man exception, upgraded from INFER) | DOC / CLIENT | S-BOM, S-CLIENT 4.3 |
| 3.3.6 | Status values (all confirmed by the scripts): **order** `DRAFT, AUTHORISED, PLANNED, RELEASED, IN PROGRESS, COMPLETED, VOIDED`; **run** `PLANNED, IN PROGRESS, OPERATIONS COMPLETED, COMPLETED, VOIDED`; **operation** `PLANNED, IN PROGRESS, COMPLETED, VOIDED, SUSPENDED`. The sandbox set from the earlier draft is replaced. (corrected) | CLIENT | S-CLIENT 4.2 |
| 3.3.7 | A run operation can start only when all predecessors are complete, the run is Planned or In progress, and the operation has at least one component or resource. Start date cannot precede the previous operation's end. Suspending needs a reason from the list; resuming restarts the timer. Actual time (start to complete minus suspended time) feeds efficiency reports and can be edited only with the edit-completed-operations permission. | CLIENT / DOC | S-CLIENT 4.9, S-OP |

---

## 4. Bills of materials

Four kinds: **assembly BOM** (flat list of components on the product; used by assembly, disassembly, auto-assembly), **production BOM**
(operations, resources, outputs; used by production orders), **make-to-order BOM** (a production BOM whose components vary with the
customer's options) and **product-family production BOM** (a general BOM that generates one BOM per variation). A product's BOM type can be
changed at any time, but delete the old BOM's components first or they can leak into later orders. [DOC, S-BOMTYPES]

### 4.1 Assembly BOM

| # | Rule | Tag | Source |
|---|---|---|---|
| 4.1.1 | Components may be stock products and services (services carry labour and overhead and need an expense account). Fields: `BOMType`, `AutoAssembly`, `AutoDisassembly`, `QuantityToProduce` (the yield, default 1), `AssemblyCostEstimationMethod`, `AssemblyInstructionURL`. A manual assembly treats the BOM as a draft (components can change during assembly); an auto-assembled one cannot be changed. | DOC / API | S-BOMASM, `rules/inventory.md` section 1 |
| 4.1.2 | Optional wastage % or wastage quantity per component line; the two are mutually exclusive. If both are blank, no wastage. | DOC | S-BOMASM |
| 4.1.3 | **Estimated cost** of the BOM uses each component's average cost, latest purchase cost, or fixed purchase cost, per `AssemblyCostEstimationMethod`. It is a planning figure only and can display 0 without making the assembly wrong. | DOC | S-BOMASM, S-ASM |
| 4.1.4 | **Actual cost** at completion uses each component's own costing method (for example FIFO), so it can differ from the BOM total. | DOC | S-BOMASM |
| 4.1.5 | Labour and overhead are added as service products with an expense account and price tier. If no standard rate exists, the amount can be typed at assembly time. | DOC | S-BOMASM |
| 4.1.6 | **Disassembly cost %** per component line; percentages must total 100. If blank, cost is split equally across component **lines** (quantity per line is ignored). Service costs are split the same way. Set it before any disassembly; auto-disassembly always uses the BOM values. | DOC / CLIENT | S-BOMASM, S-DISASM, S-CLIENT 11 |
| 4.1.7 | **Auto-assembly**: finished-product stock is virtual (available = what could be built from available components); a sale authorisation triggers the assembly; it picks only at the sale location, never partially assembles, and tops up for negative stock if settings allow. The parent's costing method must be FIFO, FIFO (batch), FIFO (special) or Special (batch). The quantity assembled follows the sale-process setting (quantity required / plus minimum stock / difference to cover a shortage); integrations also offer "ordered quantity" or "minimum required for picking". **Auto-disassembly** triggers when stock received is authorised (for an advanced purchase, stock received and invoice), and for restocked credit notes of auto-assembled items, never on sales; same costing methods. (corrected: added costing-method restriction, triggers, quantity options) | DOC | S-AUTOASM, S-DISASM, `rules/inventory.md` |
| 4.1.8 | **Phantom BOM** = an assembly BOM with auto-assembly and auto-disassembly on. Created by the system for additional units of measure. When used inside a production BOM it is exploded into the parent operation instead of getting its own order, and the explosion also converts units (a case of eggs into single eggs; ounces into kilograms). | DOC | S-PHANTOM, S-NESTED |
| 4.1.9 | **Multi-level assembly**: auto-assembly on a level means its components are picked and pre-built units of that level are ignored; manual assembly on a level means pre-built units are picked and its components ignored. Switching on only the top level and keeping lower levels manual causes the fewest problems. A product cannot be a component of its own component (the system cannot authorise). | DOC | S-MULTI, S-DISASM |
| 4.1.10 | BOMs import and export as CSV (action column Delete or Create/Update; wastage and cost % columns apply to stock components, price tier and expense account to services); the API `PUT /BillOfMaterials` replaces the whole BOM per product, so any line omitted is deleted. | DOC | S-BOMASM, S-APIBOM |

### 4.2 Production BOM

| # | Rule | Tag | Source |
|---|---|---|---|
| 4.2.1 | A production BOM belongs to a product or to a product family (`production product-family-production-bom-*`). A family BOM uses a Variation entry type for components that change per option; each parent variation maps to exactly one child variation; generating creates an independent BOM per variation and regenerating adds the new family BOM as an extra version where a variation was hand-edited. Variation components cannot themselves have a production BOM and nested families are not supported. (corrected: family BOMs generate per-variation BOMs rather than being applied live) | API / DOC | S-APIPROD, S-BOMFAM |
| 4.2.2 | A product may have several **versions**; exactly one is default. Auto-generated orders (from a sale, a purchase, MRP) use the default; a manual order may choose a version while Draft or Planned, and a co-man order from a purchase uses the default. | DOC / API | S-BOMVER, S-CMPO |
| 4.2.3 | Component fields: product, quantity (per BOM output quantity), `WastagePercent`, `WastageQty`, `IsAlternative`, `IsBackflush`, `Position`, `SalePriceTier`, cost fields. On the BOM, wastage % and wastage quantity are mutually exclusive: percent locks once a quantity is entered. Both are locked for serial-number costing methods. | API / CLIENT | S-APIPROD, S-CLIENT 3.2 |
| 4.2.4 | Component quantity on an order: `TotalQuantity` = order quantity x (per-unit quantity + wastage), where wastage is the wastage quantity if it is above zero, else the percent of the per-unit quantity; serial-costed components round up. Setup operations use the BOM output quantity in place of the order quantity. (corrected: wastage quantity wins; Setup exception; upgraded from INFER) | CLIENT | S-CLIENT 4.3 |
| 4.2.5 | **Wastage**: raising wastage % or wastage quantity increases the number of components allocated, exactly like raising the quantity. Wastage may differ from the BOM at run time until the operation is completed. On the order, the percent is not editable; only the wastage quantity is. | DOC / CLIENT | S-BOM, S-OP, S-CLIENT 4.3 |
| 4.2.6 | Wastage % in the Finished Products Wastage report = wastage quantity / (total produced or consumed) x 100. The report covers only finished products and components named in the BOM, not intermediate inputs/outputs. | DOC | S-WASTE |
| 4.2.7 | **Alternative components**: set on the product's Alternative products tab (interchangeable flag, Matching %, "Used in production" flag, replacement quantity). On **Release**, a component out of stock at the shop floor and its connected warehouse is swapped for the usable alternative with the highest Matching %, ties broken alphabetically. A manually released order asks for confirmation (the dialog lists the substitutions); an auto-released order swaps without asking. A substitution can be reverted, which raises a transfer or purchase for the original if needed. `IsAlternative` marks the substituted line. (corrected: the sandbox should auto-pick on release, not leave it manual) | DOC / CLIENT | S-ALT, S-CLIENT 4.7 |
| 4.2.8 | **Scrap and yield**: Cin7 has no scrap or yield field. Input loss is component wastage; output loss is the wastage quantity typed against each output line when the final operation completes; yield is whatever was produced against the BOM output quantity, shown in the Yield section and the wastage report. A yield dialog appears on operations that have output lines. (resolved from INFER) | DOC / CLIENT | S-BOM, S-WASTE, S-IO, S-CLIENT 4.9 |
| 4.2.9 | **Finished products** (outputs of the whole BOM): primary product, coproducts, byproducts, joint products. Each has `CostCalculationType`, `PriceTier` (1 to 10), `OutputQuantity`, `FixedCost`. Costs are split by **Sales value** or **Net realisable value** from the finished product's sale price. Only Stock products qualify and a finished product cannot also be a component of the same BOM. Every operation chain must end in a finished product; the single-product case needs no explicit line. | DOC / API / CLIENT | S-FINPROD, S-BOM |
| 4.2.10 | A BOM with a **single** finished product uses the **actual** cost for it (no split); an NRV selector silently falls back to Sales value. NRV needs a sale price on every finished product and a cost on every operation. | DOC / CLIENT | S-FINPROD, S-CLIENT 3.4 |
| 4.2.11 | A sub-assembly component generates a **nested production order** only if it has its own production BOM and is not in stock at the shop floor or the connected warehouse of the logistics path. A component with only an assembly BOM is assembled (or phantom-exploded), not produced. Planned nested orders are created at the same location, tags and attribute sets are copied from the parent, and nested quantities follow the parent order, ignoring the child BOM's min/max. | DOC | S-NESTED, S-BOMSET |
| 4.2.12 | BOM validation (corrected: now the page's own rules, replacing the invented list): the same product cannot appear twice in an operation, the same resource cannot appear twice in an operation, a finished product cannot be a component (outside co-man buy/sell), an input needs a matching output in the same or an earlier step with equal quantity, and every non-zero operation needs an incoming and an outgoing link. A negative NRV result only warns. Editing needs full Production BOM permission. | CLIENT | S-CLIENT 3.3 |
| 4.2.13 | **Editing a BOM**: sequence, name, cycle time, units per cycle and work centre edits reach runs not yet started; runs in progress are unaffected; capacity planner and scheduler are not updated, you get a notice to re-plan. Existing orders pick up component or quantity changes only by reloading the BOM, which the articles say is possible on Draft orders (replace-components article) or on Planned orders (BOM article); see Unclear item 20. Replace-component (Inventory, More actions) swaps a component in assembly, production and family BOMs but not make-to-order BOMs; quantity and wastage stay, cost follows the new product. | DOC | S-BOM, S-BOMREPL |
| 4.2.14 | **Make-to-order** BOM: stock products only, FIFO costing not allowed, no suppliers, reorder levels or additional units of measure, no co-manufacturing; an order always makes exactly the sold quantity regardless of G-82. | DOC | S-MTO |
| 4.2.15 | Production BOMs import and export as CSV (Import / Export, Production BOM); a line marked Delete in the Action column removes that line. | DOC | S-BOMIMP |

### 4.3 Costing roll-up, worked example (made-up numbers)

Product Cabinet, BOM output quantity 1, price tier for resources = tier 1.

| Line | Qty per unit | Unit cost | Line cost |
|---|---:|---:|---:|
| Component Panel (wastage 5 %) | 4 | 10.00 | 40.00 (standard, no wastage) |
| Component Screw pack (wastage 10 %) | 2 | 1.50 | 3.00 |
| Resource Assembler (labour), 0.50 h per unit at 24.00 per hour | 0.5 h | 24.00 | 12.00 |
| Resource Press (machine), 0.25 h at 40.00 per hour | 0.25 h | 40.00 | 10.00 |
| Resource Utilities (other, infinite), per unit of finished product | 1 | 2.00 | 2.00 |

Estimated cost per unit without wastage = 40 + 3 + 12 + 10 + 2 = **67.00**.

Order of 10 units:

1. Panel total quantity = 4 x 10 x 1.05 = **42.0** (wastage qty 2.0). Screw packs = 2 x 10 x 1.10 = **22.0** (wastage qty 2.0).
2. Planned component cost at average cost: Panel 42 x 10.00 = 420.00; Screw 22 x 1.50 = 33.00. Total 453.00.
3. Planned resource cost: Assembler 5 h x 24 = 120.00; Press 2.5 h x 40 = 100.00; Utilities 10 x 2.00 = 20.00. Total 240.00.
4. Planned total = 693.00, so planned unit cost = **69.30** (wastage is inside the 453.00).
5. Actual run: 42 Panels issued, two layers (30 at 9.80, 12 at 10.50) = 294.00 + 126.00 = 420.00; screws 22 at 1.50 = 33.00; assembler took 5.5 h = 132.00; press 2.5 h = 100.00; utilities 20.00. Actual total = 705.00.
6. Finished goods received: 10 units at **70.50** each (705.00 / 10). Variance to plan = +11.70 per unit, +12.00 on the order (705.00 minus 693.00); it is shown in the Production Cost Breakdown as Actual minus Planned and is **not** posted separately: the actual cost goes into the stock layer. [INFER, S-COSTBRK]
7. Two sales-value finished products: if the order also yields 5 offcut units priced 4.00 each (total 20.00) and 10 Cabinets priced 150.00 each (total 1500.00), the joint cost 705.00 splits 705 x 1500/1520 = 695.72 to Cabinets (69.57 each) and 705 x 20/1520 = 9.28 to offcuts (1.86 each). [DOC method, numbers made up] S-FINPROD.

---

## 5. Production order lifecycle

### 5.1 Status values

The list shows `OrderStatus` (order level) and `Status` (display). Documented values: **Draft, Planned, Released, Work in Progress, Completed, Voided**. Cin7 calls "In progress" **Work in Progress**; there is no separate "In progress" label. Internally the page also holds `AUTHORISED` (the state that "Planned" names in the help text; the form chip shows it raw, the list shows "Authorized") and `IN PROGRESS`. Runs and operations have their own statuses (3.3.6); at run level the list says **Started** while an operation is running. A run reaching `OPERATIONS COMPLETED` is "ready to put away"; the run and then the order become **Completed** when put-away is done. (Resolved: former Unclear item 2.) [DOC / CLIENT] S-MPO, S-POLIST, S-CLIENT 4.2.

| Status | Meaning | Tag |
|---|---|---|
| Draft | Created, not authorised. No nested orders are created yet. No capacity or stock allocated. | DOC |
| Planned | Authorised. Resource capacity is planned and allocated (Capacity Planner). Stock components are **not** allocated; they need not be available. A plan from the list needs a capacity direction and a date. Documents also say an order whose components are all available is released when authorised, and G-81 = Released releases on authorise. (corrected: auto-release corner) | DOC |
| Released | Released to the shop floor. Components are allocated to the order, reservations become possible, the order enters the Scheduler's Production view. Release date cannot precede the planned date. All runs inherit the status. Releasing from the list or Scheduler creates one run for the full quantity. (corrected: single-run creation) | DOC |
| Work in Progress | Set when at least one run has an operation started (the Start button); the run start date is filled on Start and cannot be edited afterwards. | DOC |
| Completed | Set when the whole order's output has been received to the output location (put away), or by **Mark as Completed**. The completion date is filled and locked. | DOC |
| Voided | Cancelled; its transactions are reversed. | DOC |

### 5.2 Transitions

| Action | From | To | What happens | Blocked when | Tag | Source |
|---|---|---|---|---|---|---|
| Create | none | Draft (or the status chosen in G-81 when auto-created) | Order number assigned; BOM loaded into operations, components, resources, outputs with cost from the BOM; dates calculated (section 10). Only products with a production BOM can be chosen; finished products must be Stock; location must be a shop floor. | Product has no production BOM; product not stock type; location is not a shop floor; required fields missing (product, shop floor, source, accounts, quantity, calc type and its date). | DOC / CLIENT | S-MPO, S-CLIENT 4.1 |
| Authorise (`production order-authorise`) | Draft | Planned | Capacity booked on the resources. Nested production orders are created per G-79 (Planned if authorised by hand; parent status if from a sale; Draft from MRP). Order can be split into independent Draft orders beforehand (Split, before Authorise). If G-82 needs it, the suggested-quantity prompt runs first when G-81 is Released. (corrected: preconditions and split) | No BOM loaded; capacity cannot be found and the user declines to schedule forward; missing calendar; lock date. | DOC / CLIENT | S-MPO, S-NESTED, S-CAP, S-CLIENT 4.7 |
| Release (`production order-release`, body `productionOrderID`, `releaseDate`) | Planned | Released | Components allocated at the shop floor (Allocated up). Replenishment: G-77 creates transfer orders, G-78 creates POs for short components (shop floor first, then the connected warehouse, then a PO to the warehouse). Alternative components are swapped (4.2.7). The page always asks for a suggested quantity when G-82 is set, and answering "0" voids the order. Response carries a `Warning` string when something is short. Release date stored. Nested orders are released by hand per the capacity articles but with the parent per the nested article (Unclear item 18). (corrected: replenishment order, alternatives, quantity prompt) | Order not Planned; release date missing; user lacks the release permission. Component shortage is a **warning, not a block**. | DOC / API / CLIENT | S-MPO, S-PSET, S-ALT, S-APIPROD, S-CLIENT 4.7 |
| Start operation | Released | Work in Progress | Components must be populated first (Auto consume or scan) and the operation needs at least one component or resource. Start moves component and resource cost from inventory into WIP and fills the start date. Setup operations allocate components at Start. Predecessor operations must be complete. (corrected: components are consumed at Start, not issued beforehand) | Predecessors not completed; nothing on the operation; start date earlier than the previous operation's end; backflush lines cannot be scanned. | DOC / CLIENT | S-MPO, S-OP, S-CLIENT 4.9 |
| Complete operation | Work in Progress | (stays WIP) | Actual time stored; operation Completed and the next in sequence becomes available. Quantities consumed can still be edited until completion; final consumed cost trues up the transactions. On the last or output-bearing operation the user enters actual output and wastage. Resource cost switches from planned to actual time. (corrected: output prompt, true-up) | Previous linked operation not completed; completion date before start; (co-man) co-man status not completed or received. | DOC / CLIENT | S-MPO, S-OP, S-RES, S-CLIENT 4.9 |
| Complete run | Work in Progress | (WIP, or Completed if last) | Entering a completion date and pressing Complete: **WIP is credited, Finished Goods is debited**, wastage posted to expense if G-83 says so; cost is allocated to finished products; finished goods land in stock; component cost layers consumed. Costs show 0 until this moment. | Not all operations completed; lock date; backdating off and date is not today; NRV gives negative costs; under G-83 Included, total output of 0. | DOC / CLIENT | S-MPO, S-CLIENT 4.9 |
| Mark as Completed | Released or WIP | Completed | Closes the order early (under-production). Only when no run is in progress; not-started runs should be voided. From the orders list the bulk version reverses uncompleted work instead (see Gotchas). (corrected: bulk behaviour differs) | A run is neither Completed nor Voided (order page). | DOC / CLIENT | S-MPO, S-CLIENT 5 |
| Undo (`production order-undo`) | Planned, Released, WIP, Completed | Draft | Keeps the order data, reverses its transactions, resets to Draft; capacity and component allocation released; reservations reset. Linked tasks created on release (transfers, POs) are offered for undo unless still Draft or in progress; nested orders are **not** undone. Completed orders need the undo permission. | Undo permission missing. | DOC / CLIENT | S-MPO, S-CLIENT 4.9 |
| Void (`production order-void`, `ApplyToTasks`) | any not-voided | Voided | Cancels and reverses transactions. Nested orders are not voided by default, but if any exist the dialog offers "Yes with nested orders". `ApplyToTasks` true also voids the linked tasks created at release or for a co-man operation (transfers, purchases; exact kinds are not listed). (corrected: nested option; ApplyToTasks resolved) | Void permission missing; unsaved order. | DOC / API / CLIENT | S-MPO, S-NESTED, S-APIPROD, S-CLIENT 4.9 |
| Run void / undo (`production run-void`, `production run-undo`) | per run | Voided / back to planned | Same pattern at run level; unsaved run is just deleted. A single operation can be undone only if no later operation has started. (corrected: order-completed block) | Order already Completed; run Planned (undo); permission missing. | DOC / API / CLIENT | S-MPO, S-APIPROD, S-CLIENT 4.9 |

### 5.3 Effect on stock, allocation and cost

| Event | Component OnHand | Component Allocated | Finished OnHand | Finished OnOrder | Cost | Tag | Source |
|---|---|---|---|---|---|---|---|
| Draft | - | - | - | - | estimate only | DOC | S-MPO |
| Planned | - | - | - | - | resource capacity booked; no stock | DOC | S-MPO |
| Released | - | **+ total quantity** | - | - | allocated cost estimated at average cost. Finished OnOrder rises when a run with finished products is **started** (planned run quantity), not at release. (corrected: OnOrder timing) | DOC | S-MPO, S-FINPROD |
| Components issued (manual consume, or backflush at Output) | **- issued qty** | - issued qty | - | - | moves cost from inventory into WIP at each component's costing method | DOC | S-OP, S-BACKFLUSH |
| Run completed (output received) | - | - | **+ output qty** | - output qty | WIP credited, Finished Goods debited; layer created at actual cost | DOC | S-MPO |
| Undo / Void of a completed run | + back | reversal | - back | reversal | reverses layers | DOC / INFER | S-MPO |

### 5.4 Runs and partial completion

| # | Rule | Tag | Source |
|---|---|---|---|
| 5.4.1 | Once released, an order can be split into several **production runs** (`production run-create` with `Runs[].Quantity`, `WIPAccount`, and `IncreaseOrderQuantity`). Runs can be completed in any order; at least one run is required (a release from the list creates one automatically). | DOC / API | S-MPO, S-APIPROD |
| 5.4.2 | Sum of run quantities may exceed the order quantity: the order quantity is raised to fit (after a confirm; `IncreaseOrderQuantity`). If runs total less, the order should be Marked as Completed when no more will be made. Lowering the order quantity below the runs total deletes the runs after a confirm; editing any order line value before release also removes all runs silently. Order-level Split (before Authorise) is a different thing: it creates independent Draft orders. (corrected: silent run deletion) | DOC / API / CLIENT | S-MPO, S-CLIENT 4.3, 4.6 |
| 5.4.3 | An order closes either when all runs are complete and the required quantity is produced, or earlier by Mark as Completed. | DOC | S-MPO |
| 5.4.4 | **Partial completion** = completing some runs, or completing a run with output below plan. Over-production (resolved): there is no global setting; output above plan is accepted with warnings ("more than planned quantity", and a "proceed anyway" if total output differs from the run quantity). Min/max/deviation do not cap output; they only shape auto-created orders and prompt on manual save. Pending output stays on the run until put away. (corrected: no cap) | DOC / CLIENT / API | S-MPO, S-BOMSET, S-CLIENT 4.9 |
| 5.4.5 | Run lines expose `ExpectedQuantity` (plan) and `Quantity` (issued actual) per component. | API | S-APIPROD |
| 5.4.6 | Run operations can be **suspended** with a reason from the Suspend reasons list, and carry `ManualStartDate` / `ManualEndDate` (editable only with backdating on). | API / CLIENT | S-APIPROD, S-CLIENT 6.4 |
| 5.4.7 | Quantity boxes: In production = runs In progress; Ready to put away = runs with operations completed; Output = runs completed; Remaining = order quantity minus the last two, never negative. | CLIENT | S-CLIENT 4.5 |
| 5.4.8 | Orders can be **consolidated** (identical SKU, same shop floor, Draft or Planned only) into one order with the summed quantity and a chosen required-by date; bulk Plan needs Draft orders that already have a required-by date. | DOC | S-POLIST |

### 5.5 Error and warning texts

Cin7's server-side texts are not published. These browser-side ones come from the page scripts (short phrases; full list in `rules/production-client.md`).

| Where | Text (short) | Tag |
|---|---|---|
| Authorise with no BOM loaded | "Please load BOM first." | CLIENT |
| Release with no date | "Please specify release date." | CLIENT |
| Mark as completed with an active run | refused until every run is completed or voided | CLIENT |
| Complete run, G-83 Included, no output | "Cannot complete production run without any output." | CLIENT |
| Complete run, output differs from run quantity | "Output quantity is not equal to quantity in production run." with Proceed | CLIENT |
| Start an operation with nothing on it | "Operation doesn't have any components or resources." | CLIENT |
| Start earlier than the previous operation ended | start date before the previous operation ended is refused | CLIENT |
| Suspend with no reason | "Suspend reason is required." | CLIENT |
| Reload BOM on a released order after the operation structure changed | refused; undo the order first | CLIENT |
| Scheduler move into the past | "Cannot re-schedule task in the past." | CLIENT |
| Scheduler cannot fit work | "Could not schedule task within given time period." | CLIENT |
| Capacity Planner finds no capacity before required-by | offers to allocate forward from required-by | CLIENT |
| Factory calendar special day in the past | "Date should not be less than today." | CLIENT |
| Work centre with two bins in one shop floor | refused with a warning | CLIENT |
| NRV costs negative at completion | refuses completion with a warning about negative costs | CLIENT |
| Assembly start with no pick lines | "Your pick list is empty." | CLIENT |
| Disassembly authorise with no pick | needs at least one pick line | CLIENT |

---

## 6. Issuing components, backflush, finished goods receipt

| # | Rule | Tag | Source |
|---|---|---|---|
| 6.1 | **Manual issue** (default): components are populated onto the operation (Auto consume or scan) and quantities can be edited up to completion; **Start** moves their cost from inventory into WIP. Components copied from the BOM cannot be deleted from an operation, only set to an actual quantity of 0. Components with batch or serial numbers must be entered with them or auto-consumed; one serial cannot be picked twice. (corrected: issue happens at Start) | DOC | S-BOM, S-MPO, S-OP |
| 6.2 | **Backflush**: component quantity = finished quantity x (per-unit BOM quantity + BOM wastage quantity), computed when the **Output** tab is completed. Cost and quantity are posted then and distributed to finished goods. With several finished products the primary one drives component quantity and the other outputs. Nested orders backflush their own components by their own BOM. | DOC | S-BACKFLUSH |
| 6.3 | Backflush can be set for the whole BOM, one operation, or one component. It affects only Component lines, not Input, Output, Finished product or Resource lines. Scan and Auto-consume are disabled on backflushed lines, actual quantity cannot be typed, backflushed lines cannot be edited or deleted, and added components cannot be backflushed. (corrected: edit locks) | DOC | S-BACKFLUSH |
| 6.4 | The BOM setting can be overridden on the production run, but **not once an operation of the run has started**. To change it, undo the run and start again. It can only be switched on at the BOM level. | DOC | S-BACKFLUSH |
| 6.5 | Backflush forbids partial issue: **all components must be on hand** at the shop floor or consumption bin **when Output is completed**; fix a shortage by adjustment, transfer or purchase. (corrected: the check is at Output, not start) | DOC | S-BACKFLUSH |
| 6.6 | Backflush cannot be used with product tracing (even for one component; trace must be off globally or on the BOM), and cannot be used on co-manufacturing operations or their components. Always-trace also hides the issue-method controls. | DOC / CLIENT | S-BACKFLUSH, S-CLIENT 2 |
| 6.7 | Stock can be **reserved** to a run before it starts: tick Reserved on the operation's component grid after Auto-consume and before Start. Reservation follows FIFO/FEFO and covers on-hand stock only, not incoming; only the available on-hand amount is reserved. Reserved stock is consumed only by that run. `ReservedQuantity` / `IsReserved` on run components. Reservations are reset if backflush components are removed or the order is undone. (corrected: timing and partial reservation) | DOC / API / CLIENT | S-MPO, S-APIPROD, S-CLIENT 4.9 |
| 6.8 | **Auto-pick** (`ProductionRunAutoPickWrapper`, Auto consume): picks batch, serial and location for components by costing method (FEFO for expiry, FIFO for batch). Components with an expiry date are consumed FEFO and an expired date raises an error. (corrected: error rather than skip) | DOC / API | S-MPO, S-SCHEMA |
| 6.9 | Receiving finished goods: from the Output tab choose an output location (default the work centre's output bin, else the shop floor), enter a received date and tick Received; put-away completes the run. With G-87 on, a transfer to the delivery location is created at run or order completion and must be completed by hand. Put-away freezes the serial/output data. | DOC | S-MPO, S-SET |
| 6.10 | Batch- or serial-costed finished products need batch/serial numbers (auto-generated if left blank for serials) and, for FEFO, expiry dates at the Output step (`BatchSN`, `ExpiryDate`); wastage of a batch product needs its own line and batch. Serial output is capped at one per line and cannot be edited once sold, transferred or adjusted. (upgraded from INFER) | DOC / CLIENT | S-MPO, S-CLIENT 4.9 |
| 6.11 | Unused components left after the last operation can be transferred to storage from MES; if not, they stay in the consumption bin or shop floor. | DOC | S-OP |

---

## 7. Cost of production

| # | Rule | Tag | Source |
|---|---|---|---|
| 7.1 | Production cost = **materials** (components at actual consumed cost) + **resources** (labour, machine, overhead; planned time then actual time) + **additional costs** (manual journals on the run: `ManualJournals`, landed-cost allocations, and service lines; the "Overhead" column is spread in proportion to component and resource cost) + **wastage** if included (G-83). | DOC / API | S-COSTBRK, S-PSET, S-APIPROD, S-LANDED |
| 7.2 | **Estimate** uses average component cost and planned resource time. **Actual** uses each component's own costing method and actual operation time. | DOC | S-BOM, S-RES |
| 7.3 | Costs are allocated to finished products at the moment the Output is completed; the effective date is the run completion date. | DOC | S-FINPROD |
| 7.4 | **WIP**: during a run, component cost and resource cost sit in the WIP account (per-run `WIPAccount`), moved there from inventory at Start; on completion WIP is credited and Finished Goods debited. (The field-help for the two account fields words the debit and credit the other way round; see Unclear item 19.) | DOC | S-MPO |
| 7.5 | **Variance**: the Production Cost Breakdown shows overrun or underrun as Actual minus Planned (and as a percentage of planned) per run, operation or work centre. The help center never mentions a variance account or posting; the sandbox capitalises the actual cost into the finished-goods layer with no separate account. | INFER | S-COSTBRK |
| 7.6 | Resource cost: `Quantity` x `Cost` per unit of time or per finished product (`CostCalculationType`) at the chosen price tier; planned and unplanned downtime have their own rates. Actual time replaces planned time when the operation completes; the unit-of-time conversion is cost x operation time / resource unit of time. | DOC / API / CLIENT | S-RESCOST, S-SCHEMA, S-CLIENT 4.4 |
| 7.7 | Wastage handling: **Posted to expense account** = waste cost based on the BOM's sale price tier (chosen in the BOM's Cost of wastage block) goes to the waste posting account; **Included in production cost** = waste cost is added to the order and spread over finished products by the BOM's allocation method. | DOC | S-PSET, S-BOM |
| 7.8 | Standard-manufacturing assembly: finished unit cost = sum of component cost by costing method + labour/overhead service lines; extra invoices (freight, insurance) can be allocated across assembly lines, production runs or transfers by cost or manually if the debit account equals the inventory account of the lines. | DOC | S-ASM, S-ALLOC, S-LANDED |
| 7.9 | Co-manufacturing cost, by mode (corrected: three different cost paths). **Sell components**: COGS of the components is struck at the sale to the co-manufacturer; the finished cost holds only the purchase invoice and extra manual journals. **Transfer components**: component cost goes to In Transit when sent, then inventory, then WIP, and is spread into the finished cost on completion; the invoice adds service cost. **Purchase components**: component cost is not moved to WIP when the supplier PO completes; everything is allocated when the finished product is received. In every mode the finished cost reads 0 until the purchase invoice is authorised, then updates (and updates COGS if already sold). | DOC | S-COMAN, S-CMSET |
| 7.10 | Costing method of the finished product (FIFO, FEFO, special, average) decides how the layer is created. Average cost updates as the weighted average. | INFER | `rules/inventory.md` |
| 7.11 | Showing cost to users is controlled by a permission ("Advanced Manufacturing - View production cost data"); without it costs, totals and transactions are hidden from shop-floor staff. | DOC / CLIENT | S-PERM, S-MPO, S-CLIENT 2 |

---

## 8. Capacity planning and scheduling

### 8.1 Capacity Planner

| # | Rule | Tag | Source |
|---|---|---|---|
| 8.1.1 | For a date range it shows per resource and shop floor: **Total**, **Available**, **Allocated** (planned plus released orders; the two parts are optional columns), **Consumed** (completed orders). Total = (operational hours minus breaks) x units. Available = Total - (Allocated + Consumed) (corrected: Consumed is subtracted too). Over-allocated resources have a negative Available and are filtered by "Show overallocated". | DOC | S-CAP |
| 8.1.2 | Capacity is **reserved on authorisation** (Planned). Only **Planned** orders can be re-planned; released orders cannot. | DOC | S-CAP |
| 8.1.3 | Editing the **Planned (start) date** recalculates capacity **forward** from it. Editing the **Required by date** recalculates **backward** from it. Manual date edits bind strictly to the dates and may over-allocate; planned must be strictly before required-by. | DOC / CLIENT | S-CAP, S-CLIENT 8 |
| 8.1.4 | **Re-plan** button: searches **backward** from the Required by date toward today; if full capacity is not found, it offers to schedule **forward** from the Required by date and, if yes, to move the required-by date. If nothing is found the order is unchanged and stays over-allocated. A sale-date prompt may follow. | DOC / CLIENT | S-CAP, S-CLIENT 8 |
| 8.1.5 | Capacity calculation skips days where a resource is not working (weekends, holidays, special days off) unless the resource is allowed on them; the operation's days must be sequential (no working day gap). | DOC | S-MPO, S-RES |
| 8.1.6 | Infinite resources never reduce capacity; they only add cost. | DOC | S-RES |
| 8.1.7 | Re-planning one nested order does not re-plan the parent or siblings; check the Scheduler afterwards. Only one Capacity Planner browser tab may be open at a time. | DOC / CLIENT | S-CAP, S-CLIENT 8 |

### 8.2 Scheduler

| # | Rule | Tag | Source |
|---|---|---|---|
| 8.2.1 | Views: **Calendar** (Planned orders only), **Planning** (Planned and Released), **Production** (Released), **Sales** and **Resources** Gantt views. Edit mode exists only in Production and Calendar views, and only one user can edit at a time. Orders carry a priority (High, Medium by default, Low) that MES uses to sort tasks. (corrected: which statuses appear where) | DOC / CLIENT | S-SCHED, S-CLIENT 9 |
| 8.2.2 | Drag-and-drop in Calendar view **ignores capacity** and can over-allocate; Cin7 recommends the Capacity Planner or Production view. Moves cannot go into the past, objects cannot overlap, dependencies are kept, and the sale's required-by date is not changed. | DOC / CLIENT | S-SCHED |
| 8.2.3 | Rescheduling an order, run or operation needs the full-access Scheduler permission. | DOC | S-PERM |
| 8.2.4 | The buffer shown on the Scheduler is only the production-time buffer; the component lead time buffer was already consumed when the Release date was set. Buffer zones: green above 66.6 %, yellow 33.3 to 66.6, red below. | DOC | S-BUFFER |
| 8.2.5 | Scheduling inside the Scheduler always walks the time line **forward**: the `forward` flag is never read, so even a backward-planned order is laid out forward when rescheduled. Operations are placed in step order, each starting when its predecessors end; resources in one operation must be free at the same time; if the end of the time line is reached it fails and undoes the move. This is the browser engine, not the server's authorise-time capacity calculation. | CLIENT | S-CLIENT 9.3 |
| 8.2.6 | Operations are rescheduled automatically within their run when a start is early or late, quantity changes or actual time is edited; other runs and nested orders are untouched. Completing an operation from the Scheduler fixes used quantities to planned. | DOC / CLIENT | S-SCHED, S-CLIENT 9.2 |

---

## 9. Disassembly, assembly, write-off

### 9.1 Assembly (`/FinishedGoods`, list `/FinishedGoodsList`)

| # | Rule | Tag | Source |
|---|---|---|---|
| 9.1.1 | Statuses: Draft, Authorised, In progress, Completed, Voided. Flow: Draft, Authorise (opens the Pick tab), Allocate or Auto-pick, Start, Complete. Quantity is relabelled "Actual yield" once In progress. Save is blocked only on Voided; location, accounts and product are editable only while Draft. (corrected: In progress added, from CLIENT) | CLIENT | S-CLIENT 10, S-ASM |
| 9.1.2 | Authorising does not require stock: short components show red and the missing quantity goes to backorder. **Allocate** removes the components from inventory and moves their value into WIP; **Complete** moves WIP value to the finished-goods account and adds the finished product to stock. The inventory model's "authorise reserves components, adds OnOrder" (`rules/inventory.md` rows 120-123) is not stated in the help center. (corrected: stock leaves at Allocate) | DOC | S-ASM, `rules/inventory.md` |
| 9.1.3 | Assembly orders for **assembled** components of a production BOM: the production-orders article says they are never created and must be assembled by hand before the production order can complete; the nested-orders article says authorising a parent creates Authorised assembly orders for them. Phantom (auto-assembled) components need neither. Open: Unclear item 18. (corrected: now a documented disagreement) | DOC | S-MPO, S-NESTED |
| 9.1.4 | A completed assembly feeds Job Costing actual expenses when allocated to a job; authorised assemblies feed the Planned Expenses document. | DOC | S-JOB |
| 9.1.5 | If components were backordered, the assembly does not complete itself when they arrive; authorise the pick by hand (even for auto-assembly). For auto-assembly the Out-of-Stock Components report lists what to buy, then undo and re-authorise the sale to trigger the build. Backordering components needs a supplier on each component. Cloning is allowed except for voided assemblies. | DOC | S-ASM, S-AUTOASM |

### 9.2 Disassembly (`/Disassembly`)

| # | Rule | Tag | Source |
|---|---|---|---|
| 9.2.1 | Breaks one inventory item into its BOM components. Completed: OnHand of parent down, OnHand of components up. Non-inventory items cannot be disassembled and **partial disassembly is not supported**: the full quantity must be disassembled. | DOC | S-DISASM |
| 9.2.2 | **Cost of components** = actual cost of the parent as picked by its costing method, split by Disassembly Cost % (equal per component line when blank). Labour and overhead go into the same cost pool. | DOC | S-DISASM, S-BOMASM |
| 9.2.3 | Account flow: the disassembled product moves through Work-In-Progress (a WIP account is chosen on the task); the components enter Inventory. | DOC | S-DISASM |
| 9.2.4 | Worked example (made-up): parent 3 units at actual cost 30.00 each (total 90.00) plus 6.00 labour = 96.00 pool. BOM lines: Frame (qty 2, 50 %), Panel (qty 1, 30 %), Fitting (qty 4, 20 %). Per parent unit pool 32.00: Frame 16.00 total (8.00 each), Panel 9.60, Fitting 6.40 (1.60 each). Equal split (percent blank) would give 10.67 per line regardless of quantity. [DOC method, made-up numbers] | DOC | S-DISASM |
| 9.2.5 | Statuses: Draft, Work in progress, Completed, Voided. Flow: pick (auto-pick walks source cards in order and takes what is needed), Authorise (needs at least one pick line), fill or Load BOM results, Complete. Rounding can leave the result total off the pick total, which blocks completion until a result cost is edited to match. Auto-disassembly results cannot be altered; components land at the stock-received location. | CLIENT / DOC | S-CLIENT 11, S-DISASM |

### 9.3 Inventory write-off (`/IssueToProduction`, list `/IssueToProductionList`)

| # | Rule | Tag | Source |
|---|---|---|---|
| 9.3.1 | The screen is called Inventory write-off but the route and bundle are `IssueToProduction`: it removes stock and expenses its cost to an account. Functionally identical to a stock adjustment; also used to use stock internally. | DOC / API | S-WO, S-SCHEMA |
| 9.3.2 | Cost is calculated automatically from the item's costing method and prior transactions. Completing writes the cost to the chosen expense account (line `ExpenseAccount` or header `Account`). Default line cost = average cost. | DOC / API | S-WO, `rules/inventory.md` |
| 9.3.3 | Statuses: Draft, Completed, Voided; there is no separate authorise step (Complete does it). Completed: OnHand down, layers consumed. Undo returns to Draft keeping the data; Void reverses and closes it for good (API DELETE with `Void`). Undo is offered only on Completed. (corrected: no Authorised state) | CLIENT / DOC | S-CLIENT 12, S-WO |
| 9.3.4 | A write-off can be allocated to a job via New Expense then Inventory write-off / Expense allocation; the job can invoice only completed write-offs. Write-off expenses can also be allocated to purchases, runs, assemblies and transfers from the Financials tab. | DOC | S-WO, S-JOB |
| 9.3.5 | Non-inventory products cannot be written off. The screen has no import or export; summarise via the general ledger on one expense account or the inventory movement details report. | DOC | S-WO |

### 9.4 Job costing (`/JobCosting`, list `/JobCostingList`)

| # | Rule | Tag | Source |
|---|---|---|---|
| 9.4.1 | Job statuses: **Prospect, In Progress, Completed, Cancelled**; milestones are Draft, In progress, Completed, Cancelled. A job in Prospect cannot accumulate expenses. Creating a job makes a sub-account under the chosen expense account. | DOC / CLIENT | S-JOB, S-CLIENT 13 |
| 9.4.2 | Expenses come from purchases, inventory write-offs and assemblies allocated to the job's sub-account. A budgeted margin % in the header is added to cost when invoicing: invoiced amount = expense x (1 + margin %), margin blank = 0. | DOC / CLIENT | S-JOB, S-CLIENT 13 |
| 9.4.3 | An invoice may contain expenses of only one job. Before invoicing: expenses assigned to the right job, POs authorised with stock received, write-offs completed. Existing invoices can be linked to expenses logically without adding lines. | DOC | S-JOB |
| 9.4.4 | Auto-invoicing happens only while a milestone is In Progress; the generated invoice (frequency weekly to annually) holds all unlinked expenses and is assigned to the first milestone. | DOC / CLIENT | S-JOB, S-CLIENT 13 |
| 9.4.5 | Fixed-price labour or services use a service sale started from the job. | DOC | S-JOB |

---

## 10. Scheduling a production order: dates, buffer, capacity

### 10.1 Rules

| # | Rule | Tag | Source |
|---|---|---|---|
| 10.1.1 | Dates on an order: **Start (Planned) date** (when replenishment must start), **Release date** (never earlier than the planned date), **Required by date**, **Completion date** (read-only). Release date drives the Scheduler, the transfer and PO required-by dates. The sale's required-by date is not updated when these change. | DOC / CLIENT | S-BUFFER, S-MPO |
| 10.1.2 | Direction `FromRequiredBackward`: Release date = Required by date minus (sum of operation times + sum x buffer %); Planned date = Release date minus component lead time minus the lead-time buffer. The Release date is therefore slightly later than the longest component lead time. | DOC | S-BUFFER |
| 10.1.3 | Direction `FromStartForward`: Release date = Planned date + component lead time + the lead-time buffer; the order then finishes after operation time plus buffer, which becomes Required by. (corrected: the earlier text left out the lead time and the two buffer parts; the help formula text prints the lead-time part unclearly, the worked example governs) | DOC | S-BUFFER, S-MPO |
| 10.1.4 | Operation time = cycle time x number of cycles; number of cycles depends on run quantity and units per cycle (not for Setup/Co-man, see 3.3.5). | DOC / CLIENT | S-BOM, S-CLIENT 4.3 |
| 10.1.5 | Resource hours per day come from the factory calendar (or resource custom hours) minus the break; a task that does not fit in one day continues on the next working day. A resource used by an operation must be free for the **cycle duration** every day until the operation ends, and all resources listed on one operation work in parallel: with 3 resources and a 3 hour cycle, all 3 must be available for 3 hours daily. | DOC | S-RES, S-MPO |
| 10.1.6 | Operations in a chain wait for their "previous step" predecessors; operations sharing a step start together (and the next step waits for the longest); Step 0 operations are non-parallel and scheduled as soon as resources are free. (upgraded from INFER) | DOC | S-PARALLEL |
| 10.1.7 | Component lead time: from the BOM when "Ignore cumulative lead time" is checked, otherwise from each product's Suppliers tab. The planned (replenishment) date is when transfers and POs for components need to be created so components reach the shop floor in time. | DOC | S-BUFFER |
| 10.1.8 | `IsIgnoreLeadTime` on the order skips the component lead time. `RecalculateDates` on order create asks the API to recompute dates. | API / CLIENT | S-APIPROD, S-CLIENT 4.8 |
| 10.1.9 | Nested orders are scheduled backward on their own: child required-by = the parent's **release date** (not its start), calculated as for a top-level order; the parent's timeline is the sum of the children's. (corrected: release date, not start) | DOC | S-MPO, S-NESTED, S-CAP |
| 10.1.10 | Buffer maths: manufacturing buffer = (sum of operation times) x buffer %; the lead-time buffer = longest component lead time x 24 hours per day x buffer % (a day counts as 24 hours, regardless of working hours). Runs have no buffer of their own; buffers apply to the whole order. Editing the Required by date after capacity is allocated does not recalculate. | DOC | S-BUFFER, S-MPO |
| 10.1.11 | A co-man order raised from a purchase schedules backward from the PO's required-by date when it has one, else forward from the PO creation date; time allocated = co-man cycle time + replenishment PO lead time + buffer. | DOC | S-CMPO |

### 10.2 Worked example (made-up numbers)

Factory calendar: Monday to Friday, 08:00 to 16:00 with a 30 minute break, so 7.5 working hours a day. Saturday and
Sunday off; no special days in the window.

Order: 30 units of Cabinet. BOM operations (one cycle makes 10 units):

| Op | Work centre | Resource (units) | Cycle time | Cycles | Operation time |
|---|---|---|---:|---:|---:|
| 10 Cut | Saw | Saw (1) | 2.0 h | 3 | 6.0 h |
| 20 Assemble | Bench | Assembler (2) | 3.0 h | 3 | 9.0 h |
| 30 Paint | Booth | Booth (1) | 1.5 h | 3 | 4.5 h |

Linked finish-to-start. Sum = 19.5 h. Buffer % = 20, so buffer = 3.9 h; padded production time = **23.4 h**.
Component lead time: longest 3 days, "Ignore cumulative lead time" unchecked and taken from suppliers.

Backward from Required by Thursday 22 Oct (end of day, 16:00):

1. Count back 23.4 h over working days at 7.5 h a day: Thu 22 Oct (7.5), Wed 21 Oct (7.5), Tue 20 Oct (7.5) = 22.5 h; the last 0.9 h falls on Mon 19 Oct, so the padded window opens Mon 19 Oct at about 15:06 (0.9 h before the end of that day) and closes Thu 22 Oct 16:00.
2. Release date = Mon 19 Oct. Operations are laid in chain order (Cut, Assemble, Paint) inside the window with the 3.9 h buffer at the end. [INFER on exact placement]
3. Components: the lead-time buffer is 3 days x 24 h x 20 % = 14.4 h, so the replenishment window is 72 h + 14.4 h = 86.4 h before the Release date. Counted in elapsed hours that is Fri 16 Oct about 00:42, so the Planned (replenishment) date = **Fri 16 Oct**. Counting working days instead would land earlier (three working days is Wed 14 Oct before adding the buffer). Cin7 does not say which for the lead time itself; the sandbox counts calendar days, then moves back to the previous working day if the result is a non-working day. (corrected: the buffer on the lead time was missing) [ASSUME for the day type, DOC for the buffer]
4. Forward check (same order, Planned Fri 16 Oct): Release date = Planned + 3 days + 14.4 h = Mon 19 Oct about 15:06; 19.5 h of operations + 3.9 h buffer = 23.4 h from there over 7.5 h days: 0.9 h Mon, then Tue, Wed, Thu 7.5 each, so it finishes Thu 22 Oct 16:00, the same as the backward run. (corrected: earlier version started the clock at the release date by mistake)
5. Capacity: the Assembler resource has 2 units, so its capacity per day = 7.5 h x 2 = 15 unit-hours. Op 20 books 2 units for 3 h per cycle, so its 3 cycles book 18 unit-hours over at least 2 days. If another order already allocates 12 of the 15 unit-hours on Wed 21 Oct, only 3 remain that day and this op over-allocates there: the Capacity Planner flags the Assembler on that day when Show overallocated is on, and Authorise offers Re-plan, which searches backward from the required-by date for a window with enough free hours and otherwise offers to schedule forward from the required-by date.

---

## 11. Co-manufacturing (outsourced operations)

| # | Rule | Tag | Source |
|---|---|---|---|
| 11.1 | An operation with type Co-manufacturing runs at a co-manufacturing work centre (`IsCoMan`) tied to a supplier. It must contain a finished product or an output, even for a single-product BOM, and cannot be part of a make-to-order BOM. | DOC | S-COMAN, S-MTO |
| 11.2 | Time allocated in the schedule = cycle time of the co-man operation + replenishment PO lead time + manufacturing buffer; co-man cycle time does not vary with quantity. | DOC | S-CMPO, S-BUFFER |
| 11.3 | A co-man order can be raised from a purchase; if the product BOM has several versions the **default** version is used. The BOM must have a single co-manufacturing operation. Several purchase invoices (and so several production runs) can be created per purchase; authorising the invoice starts the run and operation for the invoice quantity, and the order quantity follows the invoice. The production location is the purchase location and cannot be changed. | DOC | S-CMPO |
| 11.4 | Partial return is normal (for example 5 of 10 items back); unused components stay at the co-manufacturer. Backflush is not available. | DOC | S-COMAN, S-BACKFLUSH |
| 11.5 | Procurement mode (G-85) decides who owns components and whether finished cost includes them (cost paths in 7.9). A work centre's mode can change only until it is used in a BOM. Sell mode makes the supplier a customer too. | DOC | S-CMSET |
| 11.6 | Mode restrictions: Input lines are not allowed on a co-man operation in Sell mode (list the semi-finished product as a finished product in the earlier operation instead); Sell mode needs a sale price tier on the co-man operation; several co-manufacturers in one BOM are allowed only in Transfer or Purchase mode. | DOC | S-COMAN, S-CMSET |
| 11.7 | Starting a co-man operation creates the documents: a purchase order for the finished products and outputs (Authorised, or Draft if purchase approval is on; services become additional-cost lines), plus a transfer order (Transfer mode), a sales order (Sell mode), or component POs per supplier (Purchase mode, errors if a component has no supplier). The finished PO line defaults to price 0; its account must stay the order's finished-goods account or costs are not allocated. The PO cannot be voided without voiding the operation. | DOC | S-COMAN, S-CMSET |
| 11.8 | The operation completes when stock is received for all expected finished products and outputs; the invoice is not needed (cost reads 0 until it is authorised). If it was the last operation the run completes and WIP is allocated to the finished products. | DOC | S-COMAN, S-CMSET |
| 11.9 | Co-manufacturing locations cannot have bins, be a default or shop floor location, be an order-routing target, a POS outlet, an integration location or an auto-pick location; they can be PO and transfer destinations and count in replenishment, write-off, stocktake, adjustment and assembly. | DOC | S-COMAN |
| 11.10 | Dropship: components can be dropshipped to the co-manufacturer (Always / Optional product setting; Sell or Purchase mode) and finished products can be dropshipped from the co-manufacturer to the customer (flag on the BOM; the product then reads as Co-manufacturer Drop Ship). Landed costs from separate invoices allocate to runs by cost or by hand. | DOC | S-COMAN, S-LANDED |

---

## 12. Availability, MRP link

| # | Rule | Tag | Source |
|---|---|---|---|
| 12.1 | Allocated includes quantities reserved by production (finished goods) tasks; OnOrder includes authorised/ released production output. For production the finished product shows as On Order once a run with it has started. | DOC | `rules/inventory.md` rows 205-206, S-FINPROD |
| 12.2 | MRP can explode BOMs (assembly and production) to compute demand for nested products and components; recommended two-step run (without then with explosion, Planned orders as the second run's demand source). MRP rules live in a separate module (`16-mrp`) and need the MRP add-on and "Minimum before reorder" set to each location. | DOC | S-MRP |
| 12.3 | "Difference between available and required" quantity uses the reorder level at the shop floor, else the product's minimum before reorder and reorder quantity, summed per the purchase-process setting; the quantity-plus-minimum form reads the Demand (retail) location. (corrected: location nuance, and the help texts differ) | DOC | S-PSET |
| 12.4 | Reports built on this: the Shortage report counts only Released and In progress orders (in-progress first, then by required-by) and ignores sale demand; the Overdue report lists orders or runs not started 24 hours after release or scheduled start; the Required by Date Exceptions report lists orders whose required-by differs from the sale's. | DOC | S-SHORT, S-OVERDUE, S-RBDE |

---

## 13. Permissions

Canonical names are from the user-permissions article; the older labels seen in other articles are listed as aliases. Read-only tiers
exist for list screens; full access allows create, edit, authorise, undo and void as noted.

| Capability | Documented label | Gives | Tag | Source |
|---|---|---|---|---|
| Production orders: list and tasks | "Production orders - List and tasks" (alias "Production - Production List & Tasks") | read-only sees orders and tasks; full creates and edits orders and runs, picks components, starts and completes operations, consolidates | DOC | S-PERM |
| Authorise / Release / put-away | "Production orders - Authorize orders, release orders, authorize put away" | one permission for all three, singly and in bulk (corrected: not separate permissions) | DOC | S-PERM |
| Undo, Void, Mark as Completed | "Production orders - Undo, void, mark as completed, mark as in progress"; plus the module-wide "Production - Undo" and "Production - Void" for assembly, disassembly, production, jobs and write-offs (corrected: grouped) | undo, complete and void orders and runs | DOC | S-PERM |
| Edit completed operations | "Production orders - Edit completed operations" | change actual times, costs and attributes after completion | DOC | S-PERM, S-CLIENT 4.9 |
| Production setup | "Advanced Manufacturing - Capacity Planner" | full edits work centres, resources and the factory calendar and re-plans capacity (corrected: no separate setup permission) | DOC | S-PERM, S-RES |
| Capacity Planner | same permission | read-only views; full re-plans manually or automatically | DOC | S-PERM |
| Scheduler | "Advanced Manufacturing - Scheduler" | view; full allows rescheduling orders, runs, operations | DOC | S-PERM |
| Production BOM | "Advanced Manufacturing - Production BOM" | read-only sees; full creates and edits production, make-to-order and family BOMs | DOC | S-PERM |
| Assembly / Disassembly / Jobs | "Assembly - List and tasks", "Disassembly - Lists and tasks", "Manufacturing - Jobs list and tasks" (alias "Finished goods") (corrected names) | read-only tier or full create, authorise, undo, void | DOC | S-PERM, S-STDMFG |
| Inventory write-off | "Inventory write-off - List and details" | read-only or full create, authorise, undo, void | DOC | S-PERM |
| Production cost data | "Advanced Manufacturing - View production cost data" (alias "Production financial data") (corrected name) | see cost columns, totals and transactions; turning it off hides costing from shop-floor staff | DOC | S-PERM, S-MPO |
| Locations | per-user location access | assembly, disassembly, write-off and production actions limited to granted locations; other locations' documents stay visible | DOC | S-PERM |
| Modules | Advanced Manufacturing subscription | Scheduler, Capacity Planner, production orders, MES (MES grandfathered for subscriptions before 2023-09-01) | DOC | S-INTRO, S-MES |
| MES access | "Production orders - List and tasks" full, plus the authorise/release/put-away permission for put-away tasks | task list and put-away tasks in the MES app; labour resources tie tasks to users | DOC | S-MES |

---

## Unclear / docs disagree

Items 1 to 17 are the original list; resolved ones are struck through with the answer and where it now lives. Items 18 onward are new disagreements found in the full text.

1. **Error and warning text.** *Partly resolved.* Browser-side texts are now in section 5.5. Still open: Cin7's server-side texts (including the content of the Release response `Warning` string) are not in the help center or the scripts, so every other sandbox message is our wording.
2. ~~**Status labels.**~~ Resolved in 5.1 and 3.3.6: help says "Work in Progress", the scripts hold `IN PROGRESS` for orders, runs and operations, and the full run and operation status sets are known.
3. ~~**Does release block on shortage?**~~ Resolved in 5.2: no article describes a refusal; planning needs no stock, release allocates and may raise transfers and POs, and the shortage is reported (Shortage report, `Warning`). The one hard block is backflush, and it bites at Output completion (6.5), not at start or release.
4. ~~**Over-production and partial completion.**~~ Resolved in 5.4.4 and 2.3: no allow-over-production setting; output above plan is accepted with warnings; min/max/deviation apply only to auto-created orders and prompt on manual save.
5. ~~**Alternative components.**~~ Resolved in 4.2.7: substitution happens on Release by highest Matching %, ties alphabetical, confirmation only for manual release.
6. ~~**Scrap and yield.**~~ Resolved in 4.2.8: no dedicated fields; wastage on inputs, wastage quantity on outputs, yield shown against BOM output.
7. **Issue method integers and `RelationType`.** *Mostly resolved.* `IssueMethodComponent` Manual = 1, Backflush = 2; `IssueMethodParameter` BOM = 1, Operation = 2, Component = 3; `RelationType` is always 1 on order links (2.3, 3.3.3). Still open: the meaning of the API's separate `IssueMethod` field, which neither the help center nor the scripts use.
8. **Backward scheduling detail.** *Mostly resolved.* The formulas are in 10.1.2, 10.1.3 and 10.1.10, the resources-in-parallel and sequential-day rules in 10.1.5. Still open: whether component lead time counts calendar or working days. The buffer article's worked example uses a seven-day week, so it cannot tell, and its lead-time buffer treats a day as 24 hours.
9. ~~**Forward scheduling when capacity is short.**~~ Resolved in 8.1.4 and 8.2.5: Re-plan goes backward then offers forward; the Scheduler engine walks the time line forward, interval by interval, and fails with an error if it runs off the end.
10. **Undo vs void on Completed orders.** *Partly resolved.* Both are offered on Completed orders (with the permission) and both reverse transactions, but run-level undo and void are blocked once the order is Completed (5.2). Still open: whether a completed order whose finished goods were already sold can be undone; no article says and the scripts leave it to the server.
11. ~~**`ApplyToTasks` on void.**~~ Resolved in 5.2: it voids the linked tasks created at release or for a co-man operation (transfers, purchases); the dialog lists them. Not stated: an exhaustive list of task kinds.
12. **Auto-create from sale (G-80)** appears twice in the map (`MOIsFinishedGoodsAuto` and `MOCreateProductionOrder`); see `rules/settings.md`. Stays open: a field-mapping question the help center cannot answer; the help text only gives two values (when authorised or backordered, via MRP and reorder suggestions).
13. ~~**Permission names** differ between articles.~~ Resolved in section 13: the user-permissions article gives the canonical names, other labels are listed as aliases.
14. **Variance.** Stays open: the help center does not use the word variance. The Cost Breakdown shows Actual minus Planned only; whether any variance is posted separately is not stated, so the sandbox capitalises actual cost with no separate account (7.5).
15. ~~**Assembly status labels.**~~ Resolved in 9.1.1: Draft, Authorised, In progress, Completed, Voided (scripts); disassembly and write-off sets in 9.2.5 and 9.3.3.
16. **Job statuses.** Documented in 9.4.1, with milestones. Stays open: the transitions between them and any Authorised state on the job's invoice are not described.
17. ~~**Factory calendar screen.**~~ Resolved in 2.1: the Factory Calendar article and the scripts give week start, weekend days, per-day hours with one break, holidays, custom-hour days, the past-date rule and save rules.

New items:

18. **Nested orders: assembly orders, timing and release.** The production-orders and settings articles say assembly orders for nested components are never created automatically and must be built by hand, while the nested-orders article says authorising a draft creates Authorised assembly orders. They also differ on when nested production orders appear (at release versus at authorisation) and on whether releasing the parent releases the children (the nested article says yes, the capacity articles say release the children by hand). Stays open: the sandbox follows the capacity articles (children released by hand, assembly by hand).
19. **WIP debit and credit wording.** The field help for the WIP and finished-goods accounts words credit and debit the opposite way round from the run-completion text. 7.4 follows the completion text. Stays open until a transaction view is checked.
20. **Reload BOM on which statuses.** One article says reloading is possible on Draft orders only, another on Planned orders only; the scripts allow Load BOM on Draft or Planned and refuse it once released (4.2.13). Treated as Draft and Planned; stays open for the exact server rule.
21. **Auto-release on authorisation.** The articles say an order whose components are all available is released straight on authorisation, besides the G-81 setting; neither the scripts nor the other articles confirm a second trigger. Stays open; the sandbox releases on authorise only when G-81 says so.

### Assumptions the sandbox makes (summary)

Calendar days for component lead time (day type unspecified); sandbox wording for any server-side error text; the MO document prefix and run numbering display; G-86 and the "suggested" defaults for the production settings; no separate variance account (7.5); children of a nested order released by hand and assembly by hand (item 18); release on authorise only through G-81 (item 21); WIP debit and credit direction per the completion text (item 19).
