# Cin7 Core MES (shop-floor app)

The operator app for production (bundle id `dear.man`): task lists, the scheduler, capacity, starting and completing
operations, transfers and traceability. Cordova + Angular, built on the same client core as the WMS app.

## How it works

Same sign-in and headers as the WMS app ([`23-wms`](../23-wms/README.md#how-it-works-shared-with-the-mes-app)), with
`AppType` set for MES. Its own calls are in the handheld namespace under `/ExternalApi/system/DEARMan_…`; it also creates
bins through public `POST /v2/ref/location`.

## How to rebuild it

A tablet client over the production module's scheduler and operation endpoints
([`07-production`](../07-production/README.md)), exposed to device keys through a `system/*` namespace. The calls are below.
