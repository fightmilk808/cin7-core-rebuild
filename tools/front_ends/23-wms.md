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
