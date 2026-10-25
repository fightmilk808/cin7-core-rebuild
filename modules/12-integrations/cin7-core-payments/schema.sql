-- Cin7 Core Payments: one table per Cin7 Core data model, generated from data/models.json

create table "vCin7PayTransaction" (
  "PaymentIntent" text,
  "Created" timestamptz,
  "Amount" numeric,
  "Currency" text
);

create table "vDearPaymentGatewayNotificationsLogs" (
  "NotificationExecutionLogID" text,  -- -> NotificationExecutionLog
  "ExecutionDate" timestamptz,
  "Recipients" text,
  "Subject" text,
  "CustomerBody" text,
  "MerchantBody" text,
  "Status" text,
  "ErrorMessage" text
);

create table "vDispute" (
  "DisputeID" text,  -- -> Dispute
  "DearPaymentGatewayTransactionID" text,  -- -> DearPaymentGatewayTransaction
  "CustomerName" text,
  "Email" text,
  "Currency" text,
  "Amount" numeric,
  "FeeAmount" numeric,
  "ConvertedAmount" numeric,
  "ConvertedAmountToAdditionalChargeExceptFee" numeric,
  "State" text,
  "Reason" text,
  "DisputeDate" timestamptz,
  "DisputeDueDate" timestamptz,
  "TransactionDate" timestamptz,
  "DocumentName" text,
  "BillingAddressLine1" text,
  "BillingAddressLine2" text,
  "Error" text
);

create table "vDisputeItem" (
  "DisputeID" text,  -- -> Dispute
  "DisputeItemID" text,  -- -> DisputeItem
  "DisputeItemDate" timestamptz,
  "Actor" text,
  "Details" text,
  "Error" text
);

create table "vEmailNotification" (
  "EmailNotificationSettingsID" text,  -- -> EmailNotificationSettings
  "IsActive" boolean,
  "Code" text,
  "EmailTemplate" text,
  "EmailSubject" text,
  "ConditionParameterValue" text,
  "Error" text
);

create table "vInternalNotification" (
  "NotificationSettingsID" text,  -- -> NotificationSettings
  "IsActive" boolean,
  "Code" text,
  "Error" text
);

create table "vPayout" (
  "PayoutID" text,  -- -> Payout
  "PayoutPlanedDate" timestamptz,
  "PayoutDate" timestamptz,
  "State" text,
  "PayoutAmount" numeric,
  "MoneyTaskID" text,  -- -> MoneyTask
  "PurchaseTaskID" text,  -- -> Purchase
  "Note" text,
  "Error" text
);

create table "vPayoutItem" (
  "PayoutItemID" text,  -- -> PayoutItem
  "PayoutID" text,  -- -> Payout
  "TransactionDate" timestamptz,
  "DocumentName" text,
  "CustomerName" text,
  "Amount" numeric,
  "Error" text
);

create table "vRefundReasons" (
  "Code" text,
  "Name" text
);
