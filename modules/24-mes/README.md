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

## Every call (40)

| path | methods | effect | client_functions |
|---|---|---|---|
| `/POS/PosPing` | GET | read |  |
| `/system/DEARMan_Attachment` | DELETE POST | write |  |
| `/system/DEARMan_AttachmentV2` | GET | read |  |
| `/system/DEARMan_CapacityPlanner` | GET | read |  |
| `/system/DEARMan_CapacityPlannerDetails` | GET | read |  |
| `/system/DEARMan_DetailedResources` | GET | read |  |
| `/system/DEARMan_MenuCounters` | POST | read (POST query or print) |  |
| `/system/DEARMan_Note` | DELETE POST | write |  |
| `/system/DEARMan_OperationStatus` | GET GET? | read |  |
| `/system/DEARMan_PickList` | GET | read |  |
| `/system/DEARMan_PrintStockTransfer` | POST | read (POST query or print) |  |
| `/system/DEARMan_Resources` | GET | read |  |
| `/system/DEARMan_RunOperationAttributeSet` | PUT | write |  |
| `/system/DEARMan_Scheduler` | GET | read |  |
| `/system/DEARMan_TaskDetails` | GET POST PUT | read + write |  |
| `/system/DEARMan_TaskDetailsSearch` | POST | read (POST query or print) |  |
| `/system/DEARMan_TaskList` | POST | read (POST query or print) |  |
| `/system/DEARMan_Traceability` | GET POST | read + write |  |
| `/system/DEARMan_Transfer_Locations` | GET | read |  |
| `/system/DEARMan_Transfer_ToPick` | GET POST | read + write |  |
| `/system/DEARMan_Transfer_ToPut` | GET POST | read + write |  |
| `/system/DEARMan_UnusedComponents` | GET POST | read + write |  |
| `/system/DEARMan_WorkCenters` | GET | read |  |
| `/system/DEARMan_WorkCentersAll` | GET | read |  |
| `/system/login` | POST | sign-in |  |
| `/system/PickAndPack_Configuration` | GET | read |  |
| `/system/PickAndPack_Location/DirectedPutAwayInfo` | GET | read |  |
| `/system/PickAndPack_PdfPrint` | POST | read (POST query or print) |  |
| `/system/PickAndPack_ProductionReports` | GET POST | read + write |  |
| `/system/PickAndPack_StockAvailability/ByLocation` | GET | read |  |
| `/system/PickAndPack_StockAvailability/Details` | GET | read |  |
| `/system/PickAndPack_StockAvailability/Search` | GET | read |  |
| `/system/PickAndPack_StockAvailability/SearchProduct` | GET | read |  |
| `/system/PickAndPack_StockTransfer` | DELETE GET POST | read + write |  |
| `/system/PickAndPack_StockTransferList` | GET | read |  |
| `/system/PickAndPack_WarehouseTransferList` | GET | read |  |
| `/system/PushBadge` | DELETE | write |  |
| `/system/PushSettings` | GET POST | read + write |  |
| `/v2/ref/location` | POST | write |  |
| `/v2/stockTransfer` | POST | write |  |
