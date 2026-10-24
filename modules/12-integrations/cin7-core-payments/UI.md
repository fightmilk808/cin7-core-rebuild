# Cin7 Core Payments: UI

Every component the page code builds, read from the shipped ExtJS bundles: grids with their columns, fields, buttons, menus, windows and custom components. Labels are the English UI text. `renders into` is the id of the `<div>` in the page's server-rendered HTML that the component mounts in; `store` names the data store (see the endpoints in [README.md](README.md)); `on click` is the handler. Visual system and shell layout: [docs/UI.md](../../../docs/UI.md).

## Screens

| Route | Title | Bundles |
|---|---|---|
| `/PaymentGateway` | Cin7 Core Payments | [`PaymentGateway2019`](#paymentgateway2019), [`PaymentGatewayCOMMONREFUND2019`](#paymentgatewaycommonrefund2019) |

## Layout

Each screen's server-rendered HTML inside the shell, as an outline: headings, tabs, sections, labels, inputs (`#id`), buttons (`▾` = dropdown), menus, tables and `slot`s (empty `<div>`s the components below mount into). `(hidden)` parts are shown by the page code when needed. Read with GET from a signed-in session; no values are kept.

### `/PaymentGateway`: Cin7 Core Payments

Frame: `task-upload-frame`.

```text
block #payment-gateway
  link "Home"
  link "Integrations"
  heading "Sorry"
  heading "Cin7 Core Payments is not supported in your country."
modal#PaymentGatewayRefundDialog medium
  slot #paymentGateway_transactionID_element
  heading "Cin7 Core Payments"
  button "x"
  label "Refund amount" for #PaymentGatewayCommon_Refund_Amount
  slot #PaymentGatewayCommon_Refund_Amount
  label "Refund reason" for #PaymentGatewayCommon_Refund_Reason
  slot #PaymentGatewayCommon_Refund_Reason
  slot #paymentGateway_refundMaxAmount
  text "Refunds take 5-10 days to appear on a customer's statement."
  block #paymentGateway_refundProcessingresult
    slot #paymentGateway_refundProcessingresult_message
  button "Refund" primary
  button "Close"
modal#PaymentGatewayPaymentsToRefundGridDialog medium
  slot #paymentGateway_saleTaskID_element
  heading "Cin7 Core Payments"
  button "x"
  slot #dashboardPaymentsToRefundGrid
  button "Close"
modal#Cin7PayRefundDialog medium
  slot #cin7Pay_transactionID_element
  heading "Cin7 Pay Payments"
  button "x"
  label "Refund amount" for #Cin7PayCommon_Refund_Amount
  slot #Cin7PayCommon_Refund_Amount
  label "Refund reason" for #Cin7PayCommon_Refund_Reason
  slot #Cin7PayCommon_Refund_Reason
  slot #cin7Pay_refundMaxAmount
  text "Refunds take 5-10 days to appear on a customer's statement."
  block #cin7Pay_refundProcessingresult
    slot #cin7Pay_refundProcessingresult_message
  button "Refund" primary
  button "Close"
modal#Cin7PayPaymentsToRefundGridDialog medium
  heading "Cin7 Pay Payments"
  button "x"
  slot #dashboardCin7PayPaymentsToRefundGrid
  button "Close"
```

## Components by bundle

What the page code builds and mounts into the layout's slots.

### `PaymentGateway2019`

6 grids · 17 standalone fields · 0 windows · 0 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `dashboardPaymentsGrid` · store `transactionsStore` · placeholder `You do not have any transactions at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Date and time | `TransactionDate` | date column | 125 | renderer() |  |
    | Document # | `DocumentName` |  | 90 | renderer() |  |
    | Customer | `CustomerName` |  | flex 2 | renderer() |  |
    | Status | `State` |  | 80 | renderer() |  |
    | Amount | `Amount` |  | flex 2 | renderer() |  |
    | Fee amount | `FeeAmount` |  | flex 2 | renderer() |  |
    |  | `` |  | 80 | renderer() |  |

  - *bottom toolbar:*
    - **pagingtoolbar** · id `transactionsPagingBar` · store `transactionsStore`
      - *(component built elsewhere: `-`)*
      - *(component built elsewhere: `Per page:`)*
      - *(component built elsewhere: `dashboardTransactionsPageSize`)*
- **grid** · renders into `dashboardRefundsGrid` · store `refundsStore` · placeholder `You do not have any refunds at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Sale date | `OriginalPaymentDate` | date column | 125 | renderer() |  |
    | Refund date | `TransactionDate` | date column | 125 | renderer() |  |
    | Status | `State` |  | 100 | renderer() |  |
    | Document # | `DocumentName` |  | 90 | renderer() |  |
    | Customer | `CustomerName` |  | flex 2 | renderer() |  |
    | Reason | `Note` |  | flex 2 | renderer() |  |
    | Amount | `Amount` |  | flex 2 | renderer() |  |

  - *bottom toolbar:*
    - **pagingtoolbar** · id `refundsPagingBar` · store `refundsStore`
      - *(component built elsewhere: `-`)*
      - *(component built elsewhere: `Per page:`)*
      - *(component built elsewhere: `dashboardRefundsPageSize`)*
- **grid** · renders into `dashboardPayoutsGrid` · store `payoutsStore` · placeholder `You do not have any payouts at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Payout date | `PayoutDate` | date column | 125 | renderer() |  |
    | Payout planned date | `PayoutPlanedDate` | date column | 155 | renderer() |  |
    | Status | `State` |  | 80 | renderer() |  |
    | Payout amount | `PayoutAmount` |  | flex 2 | renderer() |  |
    | Note | `Note` |  | flex 3 | renderer() |  |
    |  | `` |  | 80 | renderer() |  |

  - *bottom toolbar:*
    - **pagingtoolbar** · id `payoutsPagingBar` · store `payoutsStore`
      - *(component built elsewhere: `-`)*
      - *(component built elsewhere: `Per page:`)*
      - *(component built elsewhere: `dashboardPayoutsPageSize`)*
- **grid** · renders into `dashboardPayoutItemsGrid` · store `payoutItemsStore` · placeholder `You do not have any payout items at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Date and time | `TransactionDate` | date column | 155 | renderer() |  |
    | Document # | `DocumentName` |  | 100 | renderer() |  |
    | Customer | `CustomerName` |  | flex 2 | renderer() |  |
    | Amount | `Amount` |  | flex 2 | renderer() |  |

  - *bottom toolbar:*
    - **pagingtoolbar** · id `payoutItemsPagingBar` · store `payoutItemsStore`
      - *(component built elsewhere: `-`)*
      - *(component built elsewhere: `Per page:`)*
      - *(component built elsewhere: `20`)*
- **grid** · renders into `dashboardDisputesGrid` · store `disputesStore` · placeholder `You do not have any disputes at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Dispute date | `DisputeDate` | date column | 155 | renderer() |  |
    | Dispute due date | `DisputeDueDate` | date column | 155 | renderer() |  |
    | Document # | `DocumentName` |  | 110 | renderer() |  |
    | Status | `State` |  | flex 2 | renderer() |  |
    | Dispute amount | `Amount` |  | flex 2 | renderer() |  |
    |  | `` |  | 90 | renderer() |  |

  - *bottom toolbar:*
    - **pagingtoolbar** · id `disputesPagingBar` · store `disputesStore`
      - *(component built elsewhere: `-`)*
      - *(component built elsewhere: `Per page:`)*
      - *(component built elsewhere: `dashboardDisputesPageSize`)*
- **grid** · renders into `dashboardDisputeItemsGrid` · store `disputeItemsStore` · placeholder `You do not have any dispute items at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Date and time | `DisputeItemDate` | date column | 125 | renderer() |  |
    | Actor | `Actor` |  | flex 3 | renderer() |  |
    | Details | `Details` |  | flex 5 | renderer() |  |

  - *bottom toolbar:*
    - **pagingtoolbar** · id `disputeItemsPagingBar` · store `disputeItemsStore`
      - *(component built elsewhere: `-`)*
      - *(component built elsewhere: `Per page:`)*
      - *(component built elsewhere: `20`)*

#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| combo |  | `PaymentGateway_step1_AccrualAccount` | `AccrualAccountsStore` | shows `Name` · value `Code` · pick-only |
| combo |  | `PaymentGateway_step1_BankAccount` | `BankAccountsStore` | shows `Name` · value `Code` · pick-only |
| combo |  | `PaymentGateway_step1_PaymentsFeeAccount` | `PaymentsFeeAccountStore` | shows `Name` · value `Code` · pick-only |
| number field |  | `PaymentGateway_step1_BalanceToHold` | `` | placeholder `write...` |
| date field |  | `PaymentGateway_TransactionsDateFrom` | `` | placeholder `Date from...` · format `UserDateFormat` |
| date field |  | `PaymentGateway_TransactionsDateTo` | `` | placeholder `Date to...` · format `UserDateFormat` |
| date field |  | `PaymentGateway_RefundsDateFrom` | `` | placeholder `Date from...` · format `UserDateFormat` |
| date field |  | `PaymentGateway_RefundsDateTo` | `` | placeholder `Date to...` · format `UserDateFormat` |
| date field |  | `PaymentGateway_PayoutsDateFrom` | `` | placeholder `Date from...` · format `UserDateFormat` |
| date field |  | `PaymentGateway_PayoutsDateTo` | `` | placeholder `Date to...` · format `UserDateFormat` |
| combo |  | `cmbDashboard_PayoutStates` | `PayoutStateStore` | shows `name` · value `value` · pick-only |
| date field |  | `PaymentGateway_DisputesDateFrom` | `` | placeholder `Date from...` · format `UserDateFormat` |
| date field |  | `PaymentGateway_DisputesDateTo` | `` | placeholder `Date to...` · format `UserDateFormat` |
| combo |  | `cmbDashboard_DisputeStates` | `DisputeStateStore` | shows `name` · value `value` · pick-only |
| date field |  | `PaymentGateway_Evidence_PurchaseInfo_ShippingDate` | `` | placeholder `Shipping Date` · format `UserDateFormat` |
| date field |  | `PaymentGateway_Evidence_PurchaseInfo_ServiceDate` | `` | placeholder `Service Date` · format `UserDateFormat` |
| file field |  | `"f".concat(…)` | `"verificationDocument".concat(…)` |  |

### `PaymentGatewayCOMMONREFUND2019`

2 grids · 4 standalone fields · 0 windows · 0 menus, buttons and other parts · 0 custom components

#### Grids

- **grid** · renders into `dashboardPaymentsToRefundGrid` · store `paymnetGatewayPaymentsToRefundStore` · placeholder `You do not have any transactions at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Date and time | `TransactionDate` | date column | flex 3 | renderer() |  |
    | Reference | `DocumentName` |  | flex 2 | renderer() |  |
    | Amount | `Amount` |  | flex 3 | renderer() |  |
    |  | `State` |  | flex 2 | renderer() |  |

- **grid** · renders into `dashboardCin7PayPaymentsToRefundGrid` · store `cin7PayPaymentsToRefundStore` · placeholder `You do not have any transactions at the moment.`
  - columns:

    | Header | Field | Type | Width | Renderer / editor | Flags |
    |---|---|---|---|---|---|
    | Date and time | `Created` | date column | flex 3 | renderer() |  |
    | Reference | `PaymentIntent` |  | flex 2 | renderer() |  |
    | Amount | `Amount` |  | flex 3 | renderer() |  |
    |  | `PaymentIntent` |  | flex 2 | renderer() |  |


#### Fields

| Kind | Label | Renders into | Name / store | Details |
|---|---|---|---|---|
| number field |  | `PaymentGatewayCommon_Refund_Amount` | `` | placeholder `0.00` |
| text field |  | `PaymentGatewayCommon_Refund_Reason` | `` | placeholder `Reason for refund` |
| number field |  | `Cin7PayCommon_Refund_Amount` | `` | placeholder `0.00` |
| combo |  | `Cin7PayCommon_Refund_Reason` | `RefundReasons` | shows `Name` · value `Code` · placeholder `Select reason for refund` · pick-only |

