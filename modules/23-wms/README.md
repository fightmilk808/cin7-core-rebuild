# Cin7 Core WMS (handheld app)

The warehouse handheld app (bundle id `dear.wms`, iOS, Android and Apple-silicon Macs): picking, packing, shipping,
receiving, put-away, transfers, stocktakes, write-offs and bin moves with a scanner. Cordova + Angular. Its settings page in
the main app is `/WarehouseApp` (bundle `WarehouseApp2019`). Not to be confused with `wms.cin7.com`, which is Cin7 Omni's.

## How it works (shared with the MES app)

- Base URL `https://inventory.dearsystems.com`; every call is `/ExternalApi` + a path: mostly the handheld namespace
  `/ExternalApi/system/<Controller>_<Action>`, plus public `v2` and the POS ping.
- **Sign-in:** `POST /ExternalApi/system/login` with user name and password, or a Google token (`externalLogin`), plus device
  info (`DeviceID`, `DeviceName`, `Platform`, `AppVersion`, `AppType: "WMS"`). The answer carries the tenant's account id and
  an application key.
- **Every later call** sends the public API headers `api-auth-accountid` and `api-auth-applicationkey`, plus
  `api-auth-userid` and `api-auth-username`, so the server records the staff member as the actor. Default timeout 30 s.
- Uses public `v2` for sale fulfilment, purchase stock and put-away, transfers, inventory write-offs and creating bins
  (`POST /v2/ref/location`).

## Settings (`/WarehouseApp`)

Picking type, orders per pick round, totes, auto-pack, auto-ship, always scan bin numbers, print box label, picking for
kitting, manual quantity entry, explicit batch pick confirmation, write-off account, in-transit account, time-tracking mode.
The page copies its controls into hidden fields and submits a form.

## How to rebuild it

A scanner-first mobile client that signs in once to get a per-device API key, then works through the public API plus a
small `system/*` namespace for things the public API lacks (pick rounds, totes, user context). The calls are below.

Every screen, its fields, buttons, lists, dialogs and API calls: [SCREENS.md](SCREENS.md).

## Every call (63)

| path | methods | effect | client_functions |
|---|---|---|---|
| `/POS/PosPing` | GET | read |  |
| `/system/DEARMan_PickList` | GET | read |  |
| `/system/DEARMan_PrintStockTransfer` | POST | read (POST query or print) | getPrintContent |
| `/system/DEARMan_PutAwayList/PrintReceiveTo` | POST | read (POST query or print) |  |
| `/system/DEARMan_Transfer_Locations` | GET | read |  |
| `/system/DEARMan_Transfer_ToPick` | GET POST | read + write |  |
| `/system/DEARMan_Transfer_ToPut` | GET POST | read + write |  |
| `/system/EasyPost_CarrierService` | GET | read |  |
| `/system/Locations2` | GET | read |  |
| `/system/login` | POST | sign-in |  |
| `/system/PickAndPack_Bins/GetDirectPutAwaySuggestedBins` | POST | write |  |
| `/system/PickAndPack_CarrierServices` | GET | read |  |
| `/system/PickAndPack_Configuration` | GET | read |  |
| `/system/PickAndPack_Delivery` | GET PUT | read + write |  |
| `/system/PickAndPack_DeliveryAttachment` | DELETE GET POST | read + write |  |
| `/system/PickAndPack_DeliveryDetails` | GET | read |  |
| `/system/PickAndPack_DeliveryNotes` | DELETE POST PUT | write |  |
| `/system/PickAndPack_FulfilmentPick` | DELETE PUT | write |  |
| `/system/PickAndPack_GoogleRoute` | POST | read (POST query or print) |  |
| `/system/PickAndPack_LabelPrinting` | GET | read |  |
| `/system/PickAndPack_ListOfPurchases` | GET | read |  |
| `/system/PickAndPack_ListOfRestocks` | GET | read |  |
| `/system/PickAndPack_ListOfSales` | GET | read |  |
| `/system/PickAndPack_Location/DirectedPutAwayInfo` | GET | read | getDirectedPutAwayData |
| `/system/PickAndPack_Pack` | GET POST PUT | read + write |  |
| `/system/PickAndPack_PackageManagement` | GET POST PUT | read + write |  |
| `/system/PickAndPack_PdfPrint` | POST | read (POST query or print) |  |
| `/system/PickAndPack_PickList` | POST | read (POST query or print) |  |
| `/system/PickAndPack_PutAway` | GET | read |  |
| `/system/PickAndPack_ReceiveList` | GET | read |  |
| `/system/PickAndPack_ReceiveListWPO` | GET | read |  |
| `/system/PickAndPack_Restock` | GET POST | read + write |  |
| `/system/PickAndPack_RestockList` | GET | read |  |
| `/system/PickAndPack_Ship` | POST | write |  |
| `/system/PickAndPack_StockAvailability/ByLocation` | GET | read |  |
| `/system/PickAndPack_StockAvailability/Details` | GET | read |  |
| `/system/PickAndPack_StockAvailability/Search` | GET | read |  |
| `/system/PickAndPack_StockAvailability/SearchProduct` | GET | read | searchProduct |
| `/system/PickAndPack_Stocktake` | GET POST PUT | read + write |  |
| `/system/PickAndPack_StocktakeCriteria` | GET | read |  |
| `/system/PickAndPack_StocktakeProducts` | GET | read |  |
| `/system/PickAndPack_StockTransfer` | DELETE GET POST | read + write |  |
| `/system/PickAndPack_StockTransferList` | GET | read |  |
| `/system/PickAndPack_TimeTrackingSession` | DELETE? | write |  |
| `/system/PickAndPack_Tots` | GET | read |  |
| `/system/PickAndPack_UOM` | POST | write |  |
| `/system/PickAndPack_WarehouseTransferList` | GET | read |  |
| `/system/PickAndPack_WriteOff` | GET | read |  |
| `/system/v2/PickAndPack_PackageWeightAndValue` | GET | read |  |
| `/v2/advanced-purchase` | POST | write |  |
| `/v2/advanced-purchase/invoice` | GET | read |  |
| `/v2/advanced-purchase/put-away` | GET POST | read + write |  |
| `/v2/advanced-purchase/stock` | GET POST | read + write |  |
| `/v2/inventoryWriteOff` | DELETE POST PUT | write |  |
| `/v2/purchase/order` | POST | write |  |
| `/v2/ref/location` | POST | write |  |
| `/v2/sale` | GET | read |  |
| `/v2/sale/fulfilment` | POST | write |  |
| `/v2/sale/fulfilment/pick` | GET | read |  |
| `/v2/sale/fulfilment/ship` | PUT | write |  |
| `/v2/stockTakeList` | GET | read |  |
| `/v2/stockTransfer` | POST | write |  |
| `/v2/supplier` | GET | read |  |
