# Testing location and fulfilment behaviour

How to test the way Cin7 Core's Shopify and ShipStation connectors choose locations and report fulfilment, if you are rebuilding that behaviour. This is a **testing process**, not a statement of how Cin7, Shopify or ShipStation behave in production. The rules themselves are in [rules/shopify.md](../rules/shopify.md) and [rules/shipstation.md](../rules/shipstation.md); this file says which settings interact, which matrices are worth running, and how much each kind of test can and cannot prove.

All names below are generic (Location A, Warehouse B, SKU-1). Nothing here is drawn from a live account, and no result here should be read as a verified production outcome.

> [!WARNING]
> A simulator that passes proves the simulator. Every section below ends with what that kind of test cannot show. Read [Fidelity gaps](#fidelity-gaps) before trusting any matrix result.

## Why this is hard

Three systems each pick a location by their own rule, and the connector sits between them:

- **Shopify** assigns each order's items to a fulfilment order at a location, and can move that assignment.
- **Cin7** picks the sale's location from its own settings, and picks stock from a location that may differ from the sale's.
- **ShipStation** ships from a warehouse that is either chosen by a mapping or fixed by the connector that creates the order.

When the three disagree, the visible symptoms are error messages in the integration log and fulfilments in Shopify that do not match what Cin7 packed. Most of the work is separating "a setting is wrong" from "the systems legitimately chose different places".

## Settings that interact

| Setting | Where | Why it matters for location |
|---|---|---|
| Enable partial fulfilment | Shopify connector | Off: the first shipment sends a whole-order fulfilment. On: fulfilment is sent per line, so Shopify must know which location each line leaves from. Needs location mapping (next row). |
| Location mapping | Shopify connector | Each Shopify location maps 1:1 to a Cin7 location, to nothing, or to "All locations". Partial fulfilment cannot be enabled with an incomplete mapping, and a mapping to "All locations" is a pooled scope that cannot name one physical origin. |
| Use Shopify order location | Shopify connector | On: the sale takes the location Shopify assigned. Off: the sale takes the location chosen by the next setting. |
| Location for online sales | Shopify connector | A named Cin7 location, "Default location", or order routing. Used when the order location is not honoured or is missing. |
| Picking mode (auto pick and pack, no picking, load data from Shopify) | Shopify connector | Decides who picks, and from which location. Auto pick and pack can pick from the Cin7 default independently of what Shopify assigned. Changing the mode can also reset other settings (see the transition case). |
| Warehouse mapping | ShipStation connector | Maps a Cin7 location to a ShipStation warehouse. An unmapped location exports with no warehouse. |
| Auto-authorise shipment | ShipStation connector | On: tracking coming back authorises Ship, which is what triggers the Shopify fulfilment. Off: the shipment stops at draft and Shopify stays unfulfilled. |
| Custom connector in front of ShipStation | Outside Cin7 | A custom ShipStation connector may fix the warehouse itself, ignoring the sale's location, and may notify (or not) the sales channel on its own mark-as-shipped call. |

The first four are a single decision chain: *order origin → sale location → pick location → fulfilment origin*. Test that chain end to end, not each setting alone.

## Principles for the test harness

1. **Mock every external call.** Shopify, ShipStation and Cin7 are all faked at their HTTP boundary. A test must be unable to reach a real endpoint (block the network in the test runner).
2. **Use invented data only** and a throwaway database that the test session may rebuild. Never point the suite at a shared or real database.
3. **Make the order carry more than one line**, with only some lines picked and packed. A single-line order cannot show a line mismatch.
4. **Record what each system was told**, not just the final status: the warehouse sent to ShipStation, the origin and lines sent to Shopify, and every error stored in the log.
5. **State the dimensions you did not cross.** A full Cartesian product of six chosen dimensions is not a product of every suspected factor; say so in the results.

## Matrices worth running

### 1. Shopify side: partials x mapping x honour-location

| Dimension | Values |
|---|---|
| Partial fulfilment | off, on |
| Location mapping | none, one location, both locations |
| Use Shopify order location | off, on |

Expected shape: with partials off, the first partial shipment marks the whole mock order fulfilled. With partials on, an incomplete mapping must refuse to enable (assert that, do not work around it); complete mappings allow a partial shipment.

Why: this is the minimum grid that exercises the settings gate. It is cheap. Its main lesson is what it fails to discriminate: if every order originates at one location and is picked at the default, the honour-location setting never changes anything, so add the next matrix.

### 2. Differing origin and pick

Cross: partials on/off, honour-location on/off, Shopify order location (Location B, or absent), with both locations mapped.

Assert: with Location B present and honour on, the sale takes Location B while the pick stays at the default; with honour off the sale takes the default; a missing origin falls back to the default.

Why: this is the case that makes the three systems disagree. A simulator that lets such a shipment succeed has not shown that real Shopify accepts it. Real acceptance depends on destination stocking and fulfilment-order movement, which a simple mock does not model.

### 3. ShipStation side: warehouse mapping x auto-authorise

Cross: Cin7 location missing / loaded but unmapped / mapped to a warehouse, against auto-authorise on/off.

Assert: unmapped exports carry a null warehouse and mapped exports carry the mapped one; tracking returns to Cin7; the auto-authorise switch alone decides whether Ship is authorised.

### 4. Combined flow: Shopify to Cin7 to ShipStation to Cin7 to Shopify

Use a two-line order, ship one line only, and run the full round trip. Cross at least: partials on/off, ShipStation mapping absent/present, auto-authorise on/off, order origin A / B / missing, mapping none / one / both.

Observed shape worth asserting:

| Auto-authorise | Partials | Shopify ends |
|---|---|---|
| off | either | unfulfilled (shipment stops at draft) |
| on | off | whole order fulfilled, both lines |
| on | on | only the shipped line fulfilled |

Also assert the negative cases: partials on with missing mappings is rejected before any shipment, and a warehouse mapping configured for one location does not apply when the sale resolves to another.

A large Cartesian suite like this is useful for regression, but record exactly which dimensions it fixes (for example, every case may use the same pick location and online-sales location). Anything fixed is untested.

### 5. Three-location shape

Give sale and pick *distinct* locations (Location A, B, C), cross partials on/off and warehouse mapping absent/present for the sale location. Assert which location the Shopify fulfilment origin and the ShipStation warehouse follow. In a simple simulator both may follow the **sale** location even when the **pick** location differs; that is a modelling choice to compare against real order histories, not a conclusion.

## The transition case

The case most likely to explain later line-mismatch errors, and the easiest to miss because it spans a settings change:

1. Partial fulfilment is **off** (possibly because a picking-mode change reset it).
2. One line of a multi-line order ships; with partials off, the connector sends a whole-order fulfilment, so Shopify marks **every** line fulfilled.
3. Partial fulfilment is turned **on**.
4. The second line ships. Cin7 sends a per-line fulfilment for a line Shopify already considers fulfilled.
5. The upload fails because the remaining fulfillable quantity is zero, and saving again repeats the failure.

Test it as a scripted sequence, not a matrix. Then extend it with recovery: cancel the false full fulfilment (see [cancellation shim](#cancellation-shim-and-its-limits)), re-record the first shipment explicitly, and confirm a later resave creates no duplicate.

What it proves: a plausible mechanism for "not enough proper order lines" style errors. What it cannot prove: that any particular real order followed it. For real orders, compare timing and contents of the Shopify fulfilment against the Cin7 snapshot (see [Evidence discipline](#evidence-discipline)); a cancelled-and-recreated fulfilment between the two means the simple story is incomplete.

Also check whether a picking-mode change alters the partial-fulfilment setting. Audit logs can show the two changing together; model that coupling in the simulator rather than assuming settings are independent.

## Deleted-then-reloaded mapping

1. Enable partials with both locations mapped 1:1.
2. Delete one location's mapping. Assert whether partials stay on (the setting can be left inconsistent).
3. Reload locations from Shopify. The row comes back **with no Cin7 location**, which displays as "All locations".
4. Ship from the location that was deleted and reloaded.

A naive mock falls back to the order location and succeeds. The real integration logs an error that the location is mapped to "All locations". A narrow guard that refuses a partial-fulfilment push when the selected location has an existing null / "All locations" mapping row reproduces that error class. Keep three states distinct in tests: **row absent**, **row present with null Cin7 location**, **row mapped 1:1**. Only the second has an evidence-backed rejection; the behaviour for the first is unverified.

Vary: partials on/off, auto-authorise on/off, and whether the shipping location is the reloaded one or the other.

## Injected-error replay

Observed error classes in the integration log, by generic message type:

| Message type | What it points at |
|---|---|
| Location "mapped to All locations" | A pooled mapping used where a single origin is needed. |
| Items "not stocked at the new location" / destination | A requested fulfilment destination lacks a stocking association for the items. |
| "Cannot move to the current origin location" | A move was requested to the origin the fulfilment already has. |
| "Missing origin country code" | The origin address has no country. A location with a blank country is a candidate cause. |
| "Not enough proper order lines" | Fulfilment lines cannot be reconciled with the order. A separate class; do not assume a location change fixes it. |

Replay approach: inject each message at the mock fulfilment boundary, then cross message x partials on/off x no mapping / both mappings. Assert that no mock fulfilment is created, that the error is stored, that a retry stores it again, and that cases that are invalid at the settings level are rejected *before* the injection point.

**What replay cannot prove.** It verifies that your code propagates, records and retries an error. It does not show when or why the real platform emits that error, which HTTP status it uses, or what request preceded it. Do not label an injected status code as the platform's. Treat replay as a regression test for your error handling only.

## Documented-behaviour reference model

Where a mock lacks fulfilment-order semantics, build a small standalone model whose every rule is cited from public documentation, and keep it separate from the simulator.

Rules to encode, from Shopify's documentation:

- A fulfilment-order move can fail when the destination does not stock the inventory item, the order is closed, request or progress state blocks the move, or permissions are insufficient. Already-fulfilled lines cannot be reassigned. "Stocked at a location" is not proof of positive on-hand quantity. ([fulfillmentOrderMove](https://shopify.dev/docs/api/admin-graphql/latest/mutations/fulfillmentOrderMove))
- Cancelling a fulfilment can create new fulfilment orders for the cancelled items and restore remaining quantities, with the new assignment depending on stocking and location priority. ([fulfillmentCancel](https://shopify.dev/docs/api/admin-graphql/2026-04/mutations/fulfillmentCancel))
- Fulfilment input shape: [FulfillmentInput](https://shopify.dev/docs/api/admin-graphql/unstable/input-objects/fulfillmentinput). The API version a given integration uses is not known from outside.

Cases that cover the space: same versus different move origin; destination stocked versus not; already-fulfilled lines; cancellation quantities; origin stocked versus only an alternative stocked. Where the documentation does not determine an outcome (for example, no eligible location), return **unknown**, not a guess.

The model omits fulfilment-order IDs, real split and merge behaviour, location priority and permissions. It is a statement of what the documentation says, and it does not replace fixtures captured from real requests and responses.

## Cancellation shim and its limits

A test-only shim can model "cancel the false full fulfilment, quantities reopen". Use it for the transition recovery sequence and for a location extension: partials on/off x selected location A/B x that location mapped 1:1 versus "All locations".

Limits to write down next to every result:

- It edits the mock database directly; it does not go through Shopify.
- It assumes cancelled quantities reopen at the **same** selected location. Real Shopify can reroute based on stocking and priority.
- It has no fulfilment-order IDs, inventory, permissions, notifications or webhooks.
- The explicit re-recording of the first shipment is test data. Cancellation does not do it automatically.
- With partials off the mock marks the whole order fulfilled regardless; with partials on, a 1:1 mapping gives a partial fulfilment and an "All locations" row triggers the inferred guard. That combines a synthetic shim with a guard inferred from one error class; neither is a live test.

## ShipStation specifics

Public documentation says the warehouse identifier on an order is the warehouse it ships from, and that "notify sales channel" is an option on the mark-as-shipped call; label creation is a separate endpoint. ([advanced options](https://www.shipstation.com/docs/api/models/advanced-options/), [mark as shipped](https://www.shipstation.com/docs/api/orders/mark-as-shipped/), [create label](https://www.shipstation.com/docs/api/orders/create-label/))

Things to test when a custom connector, not Cin7's own export, creates the ShipStation orders:

- **Warehouse choice.** Does the connector use one configured warehouse for every order, or select by the sale's location? Run sale x pick location combinations with fake Cin7 and ShipStation transports and assert the exported warehouse for each. A configured-warehouse connector will export the same value for all of them.
- **Notification.** Assert what the explicit mark-as-shipped request sends for the notify flag. That is evidence about *that request only*; it is not evidence that the channel is never notified elsewhere (for example at label creation).
- **Existing orders.** With an order already present for the same reference, check whether the connector reuses it without updating the warehouse, whether a label request carries any warehouse override, and what happens with two open orders sharing a reference (hold, or pick the first). Note that a "shadow" or "log only" mode may still create or reuse orders in some paths; verify rather than assume.
- **Tracking write-back flags.** Cin7 tracking writes, ship authorisation and test-label switches are configuration; defaults in source can be overridden at runtime.

A fake ShipStation service establishes request shape only. It does not establish the physical label origin or what the live service sends to Shopify.

## Evidence discipline

When you compare a simulator to real behaviour, hold yourself to these rules.

- **Read-only, always.** No setting, mapping, order or inventory is changed to "see what happens". Reads of the live apps and of any replicated warehouse are fine; writes are not.
- **Read-only database transactions.** Use an explicit `READ ONLY` transaction and a short statement timeout for every warehouse query. Replicated tables are observations of the system, not direct reads of it; say which you used.
- **Verify deployed source by hash.** If you test a connector's code offline, copy the *running* source and compare the SHA-256 of the tested files against the deployed ones. A locally checked-out copy that differs by even one file is not an exact test of the deployed version. Re-run after the hashes match.
- **Environment-derived settings are not state.** A running container's configuration does not prove in-memory state or how a particular order was processed.
- **Log events are not orders.** Retries inflate event counts. Count distinct orders, and say which you are reporting.
- **Timing and contents show a discrepancy, not a cause.** If a Shopify fulfilment included lines Cin7 had not authorised, that is established. Why a later error occurred is a separate claim.
- **Absence of a record is not absence of the event.** A missing cancellation capture does not prove no cancellation. Audit searches are bounded text searches.
- **Account attribution does not separate a person from automation** using the same session.
- **Screenshots can conflict with a live page.** Neither disproves the other. Record both, and look for an intervening saved change, a different session, or an unsaved form.
- **Save the provenance** of every evidence file: where it came from, what it covers, what it does not.

## Fidelity gaps

Open items, roughly most to least important. Until each is closed, treat the related simulator results as mechanism sketches.

| Gap | Effect on your tests |
|---|---|
| No fulfilment-order model (assignment, move, split, priority) | Cannot show when real Shopify accepts or rejects a destination mismatch. |
| No destination-stock validation | Cannot reproduce "items not stocked at destination". |
| No origin-country validation | Cannot reproduce "missing origin country code". Locations with blank countries are a candidate, not a proven cause. |
| No real cancellation | Recovery after a false whole-order fulfilment is only modelled by a shim. |
| Failed-request payload not retained | Historical logs rarely keep the failed mutation, the assigned location or remaining quantities, so the original conditions behind a past error cannot be reconstructed. |
| Mapping rules inferred from one error class | The "All locations" guard is deliberately narrow. A missing row still follows an unverified fallback. |
| Custom connector and Custom Store flow not modelled together | A shipping-service mock is not the polling and notification flow of a live ShipStation store. |
| Duplicate and retry handling | Not established beyond the injected-error replay. |
| Untested dimensions | Online-sales location, picking mode, ShipStation export on/off and further locations are fixed in the big matrices; test them separately. |
| API versions in use | Unknown from outside; behaviour can differ by version. |

## A short checklist

1. Fake every external call; block the network.
2. Run the Shopify settings matrix, then add differing origin and pick.
3. Run the ShipStation mapping x auto-authorise matrix, then the combined round trip with a partly shipped multi-line order.
4. Script the transition case and its recovery.
5. Script delete-then-reload of a mapping; keep absent / null / 1:1 distinct.
6. Replay each logged error class and assert propagation and retry only.
7. Build the documented-behaviour model from vendor docs; return "unknown" where the docs are silent.
8. Test the custom connector's warehouse and notify behaviour on the exact deployed source (hash-verified).
9. Compare to real histories read-only, and write down every gap that remains.

See also: [rules/shopify.md](../rules/shopify.md), [rules/shipstation.md](../rules/shipstation.md), [Shopify module](../modules/12-integrations/shopify/README.md), [ShipStation module](../modules/12-integrations/shipstation/README.md).
