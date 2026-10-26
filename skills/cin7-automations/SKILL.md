---
name: cin7-automations
description: Draft Cin7 Core (DEAR Inventory) automation rules and their email or message templates - choose the workflow, conditions and the exact merge fields available for the document type. Use when someone wants to write an automated workflow or notification in Cin7, asks "which fields can I put in this email", "what conditions can a workflow check", or wants a customer, supplier, invoice, tracking or credit-note email template. Drafts only; a person creates the rule in Cin7.
---

# Cin7 automations

You draft the rule and the template text. A person builds them in Cin7.

## Two places in Cin7

| Surface | Page | What it holds |
|---|---|---|
| Automated workflows | `/AutomatedWorkflow` (editor `/AutomatedWorkflow/Edit`) | Workflow-level **conditions**, **events**, and per-event **actions** that can have their own conditions. Entity type is a sale or an opportunity (see below). |
| Notification settings | `/NotificationSettings/Notifications` | Per-notification Internal message, Email (subject, template, recipients) and External delivery, with a "Parameters" list. |

Sources: [AUTOMATIONS.md](../../docs/AUTOMATIONS.md), [workflow-editor.json](../../data/workflow-editor.json), and the settings module ([README](../../modules/13-settings/README.md), [UI.md](../../modules/13-settings/UI.md)).

## Steps

1. **Say what should happen**: on what document, when, to whom, what it says.
2. **Conditions.** Use only the parameters and operators in AUTOMATIONS.md: `customer_name`, `sales_rep`, `location`, `product`, `tag`, `sale_channel`, `sale_order_state`, `supplier_name`, `purchase_product`, `purchase_tag`, `purchaselocation`; operators `equal`, `empty`, `not_empty`, `one_of`.
3. **Event and action.** The list of events and actions is served by Cin7 at run time and is **not in the map**. Have the person open the editor and read you the options; don't name an event you haven't seen.
4. **Template.** Pick merge fields from the table below (look up, don't recall). Write subject and body as plain text with the fields where they go.
5. **Hand over** a short spec: name, conditions, event/action as the person confirmed, subject, body, recipients.

## Look up merge fields

```bash
python3 -c "import json;[print(v['Name'],'-',v['Description']) for v in json.load(open('data/workflow-editor.json'))['dicts']['ValuesMap']]"
```

Fields that end in `DownloadLink` carry a download URL. The map shows these families: customer/sale (`CustomerName`, `SaleOrderNumber`, `OrderTotal`, `QuoteTotal`, `QuoteDownloadLink`), invoice (`InvoiceNumber`, `InvoiceDueDate`, `InvoiceTotal`, `InvoiceDownloadLink`), fulfilment (`PickListDownloadLink`, `PackListDownloadLink`, `TrackingNumberList`, `CarrierTrackingNumberList`, `BoxLabelDownloadLink`), credit notes (`CreditNoteNumber`, `RefundAmount`), purchase (`SupplierName`, `OrderNumber`, `OrderDate`, `StockReceivedDownloadLink`) and CRM (`LeadName`, `OpportunityNumber`, `OpportunityTotal`).

## What the map doesn't say

- **Which fields belong to which document.** The editor keeps a per-entity field list, but the map flattens it to one set. Some names repeat with different meanings (`OrderTotal`, `OrderDownloadLink`: sale vs purchase; `CreditNoteDownloadLink`: credit note vs purchase return). Check the Parameters list shown for that notification before using one.
- **The syntax for inserting a field** (braces, brackets, or a picker). The editor sets it. Have the person insert one field and read back how it appears.
- The event/action list, allowed values for a condition, and recipient rules.

## Rules

1. **Draft only.** Creating or editing a workflow or notification writes to Cin7. Don't call the editor endpoints; a person does it in the app.
2. **Real field names only.** If a field you want isn't in the list, say so and write the sentence without it.
3. **Link fields are links.** Don't promise an attachment where the field gives a URL.
4. **Conditions are scoped.** Sale conditions (`sale.*`, `customer.name`, `salesrep`) and purchase conditions (`purchase.*`, `supplier.name`) apply to different documents; don't mix them in one rule.
5. **Test before turning on.** Tell the person to run it on one test record before activating it.
6. **No real names or addresses** in drafts you save in this repo.

## When it fails

| Symptom | Cause |
|---|---|
| Email shows the field name or a blank | Field isn't valid for that document, or was inserted by hand in the wrong syntax. |
| Rule never fires | Conditions too narrow, a `sale_order_state` that doesn't match, or the workflow is inactive. |
| Same text goes to the wrong party | Recipient settings (related user, sales rep, mailing list) differ from what you drafted. |
