# POS

The point-of-sale app: `pos.dearsystems.com` on the web and the Cin7 Core POS mobile app (the same AngularJS 1.x code in
Cordova). Configured in the main app at `/DearPos` (bundle `Pos2019`, the `/api/DearPos_*` endpoints in
[`12-integrations`](../12-integrations/README.md)).

## How it works

- The app asks `GET /Pos/GetServerAddress` for its server, then calls
  `https://inventory.dearsystems.com/ExternalApi/POS/<Resource>`, an API namespace of its own beside `/ExternalApi/v2`.
- Sign-in: `POST /PosExternalAuth`. It also uses public `v2` (`/advanced-purchase`, `/purchase/order`) for stock ordering.
- Resources cover outlets and registers, opening and closing a register, cash management, orders and lay-bys, customers,
  products and availability, serial numbers, coupons and gift cards, click-and-collect with auto-pick and fulfilment,
  deliveries, stock ordering and transfers, and a dashboard.
- Payment terminals: Linkly/PC-EFTPOS cloud, Tyro iClient, Worldpay triPOS, Windcave, Square refunds. LoyaltyLion rewards.
  Google sign-in.

## How to rebuild it

An offline-capable client app over a dedicated `/ExternalApi/POS/*` namespace: register sessions, cart and checkout,
customer lookup, availability checks at checkout, and a terminal adapter per payment provider. The calls it needs are below.
