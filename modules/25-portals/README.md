# B2B and RMA portals

Two kinds of customer-facing site, one site per portal, each configured from the main app.

## B2B portal

- A wholesale ordering site at `https://<name>.dearportal.com`. Signed out, it shows only `/Account/Login`; `/Checkout` and
  `/Catalog` redirect there.
- Public scripts: `/Scripts/site/Login.js`, `Home.js`, `Checkout.js`. Checkout calls `/Checkout/GetSaleTaxLookupTaxes`,
  `/Checkout/GetGiftCards`, `/Checkout/CheckGiftCard`, `/Checkout/AddGiftCard`, `/Checkout/RemoveGiftCard` and
  `/CheckoutTaskAttachement/Upload`. Built with ASP.NET MVC, jQuery, Bootstrap, MagicZoom.
- Configured at `/Portal` (bundle `Portal2019`, the `/api/B2B_*` endpoints in [`12-integrations`](../12-integrations/README.md)).
- The signed-in catalogue and order pages are behind a customer login and are not mapped.

## RMA (returns) portal

- A returns-request site at `https://<name>.dearreturns.com`.
- Configured at `/RmaPortal` (bundle `RmaPortal2019`: `/api/RmaPortal_Index_vWebPortal`, `_vPages`, `_vEmailTemplates`,
  `_vAddress`, `_vContacts`, `_ChangePortalDomain`).
- Returns it raises are worked in the main app at `/RMA` and `/RMAReturnOrder` ([`06-sale`](../06-sale/README.md)).

## How to rebuild them

A multi-tenant site keyed by subdomain, with its own customer accounts linked to the tenant's customer records. The B2B
portal reads the tenant's catalogue, price tiers and availability and writes sales; the RMA portal writes return requests.
Both read their branding, pages and email templates from the portal configuration records.
