# Automations

Cin7 Core's automated workflows (`/AutomatedWorkflow`, editor `/AutomatedWorkflow/Edit`, bundle `AutomatedWorkflowEdit2019`): a workflow has **conditions**, **events** and per-event **actions** (with their own conditions). Read from the editor's page code; the list of triggers and actions itself is served by `/api/vAutomatedWorkflow_Edit_ReferenceData/` at run time and is not captured here.

## Data model

| Model | Belongs to | Key |
|---|---|---|
| `vAutomatedWorkflow` | — | `AutomatedWorkflowID` |
| `vAutomatedWorkflowCondition` | workflow (`WorkflowConditions`) | `AutomatedWorkflowID` |
| `vAutomatedWorkflowEvent` | workflow (`WorkflowEvents`) | `AutomatedWorkflowID` |
| `vAutomatedWorkflowEventActionCondition` | event action (`ActionConditions`) | `AutomatedWorkflowEventActionID` |

Editor endpoints: `/api/vAutomatedWorkflow_Edit_vAutomatedWorkflow`, `_ReferenceData`, `_vAutomatedWorkflowConditionParameter`, `_vWaitTime`, `_vTemplate/Get`, `_vTaskWorkflow/Get`, `_vMailingList/Get`, and lookups `_vCustomer`, `_vSupplier`, `_vProduct`, `_vTag`, `_vSaleChannels`, `_vTenantUser`, billing/shipping addresses.

## Conditions

| Parameter | Path |
|---|---|
| `customer_name` | `customer.name` |
| `sales_rep` | `salesrep` |
| `location` | `sale.location` |
| `product` | `sale.orderproduct` |
| `tag` | `sale.orderproducttag` |
| `sale_channel` | `sale.saleschannel` |
| `sale_order_state` | `sale.orderstate` |
| `supplier_name` | `supplier.name` |
| `purchase_product` | `purchase.orderproduct` |
| `purchase_tag` | `purchase.orderproducttag` |
| `purchaselocation` | `purchase.location` |

| Operator | Symbol |
|---|---|
| `equal` | `=` |
| `empty` | `0` |
| `not_empty` | `!0` |
| `one_of` | `[%]` |

## Merge fields

Fields an automation's email or message can insert (field names as the editor stores them; the insertion syntax is set by the editor). **Link** fields carry a download URL.

| Field | Meaning | Link |
|---|---|---|
| `CustomerName` | Customer name |  |
| `CustomerContact` | Customer contact |  |
| `CustomerEmail` | Customer email |  |
| `CustomerReference` | Customer reference |  |
| `SalesRepresentative` | Sale representative |  |
| `SaleOrderDate` | Sale order date |  |
| `SaleOrderNumber` | Sale order number |  |
| `OrderTotal` | Order total |  |
| `QuoteCreatedDate` | Quote created date |  |
| `QuoteTotal` | Quote total |  |
| `QuoteDownloadLink` | Quote download link | yes |
| `SupplierName` | Supplier name |  |
| `SupplierContact` | Supplier contact |  |
| `SupplierEmail` | Supplier email |  |
| `OrderDownloadLink` | Order download link | yes |
| `InvoiceDate` | Invoice date |  |
| `InvoiceNumber` | Invoice number |  |
| `InvoiceDueDate` | Invoice due date |  |
| `InvoiceTotal` | Invoice total |  |
| `InvoiceDownloadLink` | Invoice download link | yes |
| `PickListDownloadLink` | Pick list download link | yes |
| `PackListDownloadLink` | Pack list download link | yes |
| `TrackingNumberList` | List of tracking numbers |  |
| `CarrierTrackingNumberList` | List of tracking numbers with carrier |  |
| `OrderAttachments` | Order attachments |  |
| `BoxLabelDownloadLink` | Box label download link | yes |
| `FulfilmentCreatedDownloadLink` | Document download link | yes |
| `CreditNoteDownloadLink` | Credit note download link | yes |
| `CreditNoteDownloadLink` | Purchase return download link | yes |
| `CreditNoteDate` | Credit note date |  |
| `CreditNoteNumber` | Credit note number |  |
| `RefundAmount` | Refund amount |  |
| `CreditNoteTotal` | Credit note total |  |
| `OrderNumber` | Purchase order number |  |
| `OrderDate` | Purchase order date |  |
| `OrderTotal` | Purchase order total |  |
| `OrderDownloadLink` | Purchase order download link | yes |
| `StockReceivedDownloadLink` | Receiving note download link | yes |
| `LeadName` | Lead name |  |
| `LeadContact` | Lead contact |  |
| `LeadEmail` | Lead email |  |
| `CustomerOrLeadName` | Customer/lead name |  |
| `CustomerOrLeadContact` | Customer/lead contact |  |
| `CustomerOrLeadEmail` | Customer/lead email |  |
| `OpportunityTotal` | Opportunity total |  |
| `OpportunityCreatedDate` | Opportunity created date |  |
| `OpportunityNumber` | Opportunity number |  |
| `OpportunityDownloadLink` | Opportunity download link |  |
